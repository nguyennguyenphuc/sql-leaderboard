-- 02_nap_mkt.sql: nạp CSV (mysql/mkt/du-lieu/, mount /sqllb/mkt/du-lieu/) và chuẩn hoá vào các bảng của 01_tao_bang_mkt.sql.
-- Chạy qua 02_nap_mkt.sh (đã USE mkt, --local-infile=1). Không ghi tên database.
--   bản sạch  *_original.csv -> stg_original (tạm) -> brands/danh mục/campaigns/campaign_channels
--   bản nhiễu *.csv          -> campaigns_raw (giữ nguyên chuỗi, NULL, số âm, dòng trùng)
--   noise_log.csv            -> noise_log

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ 1. danh mục cố định
INSERT INTO brands VALUES
  (1, 'Nykaa',       'NY', 'nykaa_campaign_data.csv'),
  (2, 'Purplle',     'PU', 'purplle_campaign_data.csv'),
  (3, 'Tira Beauty', 'TI', 'tira_campaign_data.csv');

-- lịch 12 tháng tròn 2024-07-01 .. 2025-06-30
INSERT INTO calendar
WITH RECURSIVE d AS (
  SELECT DATE '2024-07-01' AS dt
  UNION ALL SELECT dt + INTERVAL 1 DAY FROM d WHERE dt < DATE '2025-06-30'
)
SELECT dt, YEAR(dt), QUARTER(dt), MONTH(dt), MONTHNAME(dt),
       YEARWEEK(dt, 3) DIV 100, WEEK(dt, 3), dt - INTERVAL WEEKDAY(dt) DAY,
       WEEKDAY(dt) + 1, DAYNAME(dt), WEEKDAY(dt) >= 5
FROM d;

-- ------------------------------------------------------------------ 2. bản sạch -> bảng tạm
DROP TABLE IF EXISTS stg_original;
CREATE TABLE stg_original (
  brand_id TINYINT UNSIGNED, campaign_id VARCHAR(12), campaign_type VARCHAR(30), target_audience VARCHAR(40),
  duration TINYINT UNSIGNED, channel_used VARCHAR(60), impressions INT, clicks INT, leads INT, conversions INT,
  revenue INT, acquisition_cost DECIMAL(10,2), roi DECIMAL(6,2), `language` VARCHAR(30),
  engagement_score DECIMAL(5,2), customer_segment VARCHAR(40), start_date DATE
);

LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/nykaa_campaign_data_original.csv' INTO TABLE stg_original
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (campaign_id, campaign_type, target_audience, duration, channel_used, impressions, clicks, leads, conversions,
   revenue, acquisition_cost, roi, `language`, engagement_score, customer_segment, @d)
  SET brand_id = 1, start_date = STR_TO_DATE(@d, '%d-%m-%Y');
LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/purplle_campaign_data_original.csv' INTO TABLE stg_original
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (campaign_id, campaign_type, target_audience, duration, channel_used, impressions, clicks, leads, conversions,
   revenue, acquisition_cost, roi, `language`, engagement_score, customer_segment, @d)
  SET brand_id = 2, start_date = STR_TO_DATE(@d, '%d-%m-%Y');
LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/tira_campaign_data_original.csv' INTO TABLE stg_original
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (campaign_id, campaign_type, target_audience, duration, channel_used, impressions, clicks, leads, conversions,
   revenue, acquisition_cost, roi, `language`, engagement_score, customer_segment, @d)
  SET brand_id = 3, start_date = STR_TO_DATE(@d, '%d-%m-%Y');

-- ------------------------------------------------------------------ 3. danh mục từ dữ liệu (id theo thứ tự chữ cái)
INSERT INTO campaign_types (type_id, type_name)
SELECT ROW_NUMBER() OVER (ORDER BY campaign_type), campaign_type
FROM (SELECT DISTINCT campaign_type FROM stg_original) t;

INSERT INTO audiences (audience_id, audience_name)
SELECT ROW_NUMBER() OVER (ORDER BY a), a
FROM (SELECT target_audience AS a FROM stg_original UNION SELECT customer_segment FROM stg_original) t;

INSERT INTO languages (language_id, language_name)
SELECT ROW_NUMBER() OVER (ORDER BY `language`), `language`
FROM (SELECT DISTINCT `language` FROM stg_original) t;

INSERT INTO channels (channel_id, channel_name)
SELECT ROW_NUMBER() OVER (ORDER BY ch), ch
FROM (
  SELECT DISTINCT j.ch
  FROM stg_original s,
       JSON_TABLE(CONCAT('["', REPLACE(s.channel_used, ', ', '","'), '"]'), '$[*]'
                  COLUMNS (ch VARCHAR(20) PATH '$')) j
) t;

-- ------------------------------------------------------------------ 4. campaigns + campaign_channels
INSERT INTO campaigns
SELECT s.campaign_id, s.brand_id, ct.type_id, ta.audience_id, sg.audience_id, l.language_id,
       s.start_date, s.duration, s.impressions, s.clicks, s.leads, s.conversions, s.revenue,
       s.acquisition_cost, s.roi, s.engagement_score
FROM stg_original s
JOIN campaign_types ct ON ct.type_name = s.campaign_type
JOIN audiences ta      ON ta.audience_name = s.target_audience
JOIN audiences sg      ON sg.audience_name = s.customer_segment
JOIN languages l       ON l.language_name = s.`language`;

INSERT INTO campaign_channels (campaign_id, channel_id, channel_pos)
SELECT s.campaign_id, c.channel_id, j.pos
FROM stg_original s,
     JSON_TABLE(CONCAT('["', REPLACE(s.channel_used, ', ', '","'), '"]'), '$[*]'
                COLUMNS (pos FOR ORDINALITY, ch VARCHAR(20) PATH '$')) j
JOIN channels c ON c.channel_name = j.ch;

-- ------------------------------------------------------------------ 5. bản có nhiễu -> campaigns_raw
-- Số có thể là '57804.0' (pandas đổi sang float khi có ô trống) hoặc rỗng (-> NULL).
SET @r = -1;
LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/nykaa_campaign_data.csv' INTO TABLE campaigns_raw
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (campaign_id, campaign_type, target_audience, @dur, channel_used, @imp, @clk, @lea, @cnv, @rev, @ac, roi,
   `language`, engagement_score, customer_segment, @d)
  SET brand_id = 1, row_index = (@r := @r + 1), duration = CAST(@dur AS DECIMAL(6,1)),
      impressions = CAST(NULLIF(@imp,'') AS DECIMAL(14,1)), clicks = CAST(NULLIF(@clk,'') AS DECIMAL(14,1)),
      leads = CAST(NULLIF(@lea,'') AS DECIMAL(14,1)), conversions = CAST(NULLIF(@cnv,'') AS DECIMAL(14,1)),
      revenue = CAST(NULLIF(@rev,'') AS DECIMAL(14,1)), acquisition_cost = NULLIF(@ac,''), date_raw = NULLIF(@d,'');
SET @r = -1;
LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/purplle_campaign_data.csv' INTO TABLE campaigns_raw
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (campaign_id, campaign_type, target_audience, @dur, channel_used, @imp, @clk, @lea, @cnv, @rev, @ac, roi,
   `language`, engagement_score, customer_segment, @d)
  SET brand_id = 2, row_index = (@r := @r + 1), duration = CAST(@dur AS DECIMAL(6,1)),
      impressions = CAST(NULLIF(@imp,'') AS DECIMAL(14,1)), clicks = CAST(NULLIF(@clk,'') AS DECIMAL(14,1)),
      leads = CAST(NULLIF(@lea,'') AS DECIMAL(14,1)), conversions = CAST(NULLIF(@cnv,'') AS DECIMAL(14,1)),
      revenue = CAST(NULLIF(@rev,'') AS DECIMAL(14,1)), acquisition_cost = NULLIF(@ac,''), date_raw = NULLIF(@d,'');
SET @r = -1;
LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/tira_campaign_data.csv' INTO TABLE campaigns_raw
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (campaign_id, campaign_type, target_audience, @dur, channel_used, @imp, @clk, @lea, @cnv, @rev, @ac, roi,
   `language`, engagement_score, customer_segment, @d)
  SET brand_id = 3, row_index = (@r := @r + 1), duration = CAST(@dur AS DECIMAL(6,1)),
      impressions = CAST(NULLIF(@imp,'') AS DECIMAL(14,1)), clicks = CAST(NULLIF(@clk,'') AS DECIMAL(14,1)),
      leads = CAST(NULLIF(@lea,'') AS DECIMAL(14,1)), conversions = CAST(NULLIF(@cnv,'') AS DECIMAL(14,1)),
      revenue = CAST(NULLIF(@rev,'') AS DECIMAL(14,1)), acquisition_cost = NULLIF(@ac,''), date_raw = NULLIF(@d,'');

-- row_index = vị trí dòng trong file (đếm bằng @r, 0 = dòng dữ liệu đầu, khớp noise_log.row_index).
-- Lưu ý: LOAD DATA LOCAL bỏ qua dòng trùng khoá (như IGNORE) -> 02_nap_mkt.sh so số dòng để chắc không mất dòng.

-- ------------------------------------------------------------------ 6. noise_log
LOAD DATA LOCAL INFILE '/sqllb/mkt/du-lieu/noise_log.csv' INTO TABLE noise_log
  CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
  (@f, row_index, campaign_id, @nt, column_name, @o, @n)
  SET brand_id = CASE @f WHEN 'nykaa_campaign_data.csv' THEN 1 WHEN 'purplle_campaign_data.csv' THEN 2
                         WHEN 'tira_campaign_data.csv' THEN 3 END,
      noise_type = IFNULL(@nt, 'NULL'),  -- chữ NULL trần bị LOAD DATA đọc thành NULL
      old_value = NULLIF(@o, ''), new_value = NULLIF(@n, '');

DROP TABLE stg_original;
ANALYZE TABLE brands, campaign_types, audiences, languages, channels, calendar,
              campaigns, campaign_channels, campaigns_raw, noise_log;
