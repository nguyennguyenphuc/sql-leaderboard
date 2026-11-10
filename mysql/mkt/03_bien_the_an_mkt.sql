-- 03_bien_the_an_mkt.sql: tạo biến thể ẩn mkt_hidden_1 từ mkt (khuôn datathon_2026_hidden_1 / scm_hidden_1).
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/mkt/03_bien_the_an_mkt.sql
-- (a) bỏ ~10% chiến dịch: số đuôi campaign_id % 10 = 7 (bỏ cả kênh, dòng thô, nhật ký nhiễu của chiến dịch đó: không mồ côi khoá)
-- (b) thêm 1 chiến dịch ngày 2025-07-01, ngay sau cửa sổ 12 tháng 2024-07-01 .. 2025-06-30 (+ 1 ngày lịch 2025-07-01)
-- (c) tạo cặp hoà: Nykaa, top 3 chiến dịch theo revenue -> hạng 3 = hạng 4

DROP DATABASE IF EXISTS mkt_hidden_1;
CREATE DATABASE mkt_hidden_1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE mkt_hidden_1;
SOURCE /sqllb/mkt/01_tao_bang_mkt.sql;

INSERT INTO brands         SELECT * FROM mkt.brands;
INSERT INTO campaign_types SELECT * FROM mkt.campaign_types;
INSERT INTO audiences      SELECT * FROM mkt.audiences;
INSERT INTO languages      SELECT * FROM mkt.languages;
INSERT INTO channels       SELECT * FROM mkt.channels;
INSERT INTO calendar       SELECT * FROM mkt.calendar;

-- (a)
INSERT INTO campaigns
SELECT * FROM mkt.campaigns
WHERE CAST(SUBSTRING_INDEX(campaign_id, '-', -1) AS UNSIGNED) % 10 <> 7;

INSERT INTO campaign_channels
SELECT cc.* FROM mkt.campaign_channels cc JOIN campaigns c ON c.campaign_id = cc.campaign_id;

INSERT INTO campaigns_raw
SELECT * FROM mkt.campaigns_raw
WHERE CAST(SUBSTRING_INDEX(campaign_id, '-', -1) AS UNSIGNED) % 10 <> 7;

INSERT INTO noise_log
SELECT * FROM mkt.noise_log
WHERE CAST(SUBSTRING_INDEX(campaign_id, '-', -1) AS UNSIGNED) % 10 <> 7;

-- (b) NY-CMP-56555 chép NY-CMP-1000 (chiến dịch ví dụ của bài giảng), bắt đầu 2025-07-01
INSERT INTO calendar
SELECT d, YEAR(d), QUARTER(d), MONTH(d), MONTHNAME(d), YEARWEEK(d, 3) DIV 100, WEEK(d, 3),
       d - INTERVAL WEEKDAY(d) DAY, WEEKDAY(d) + 1, DAYNAME(d), WEEKDAY(d) >= 5
FROM (SELECT DATE '2025-07-01' AS d) x;

INSERT INTO campaigns
SELECT 'NY-CMP-56555', brand_id, type_id, target_audience_id, segment_id, language_id, DATE '2025-07-01',
       duration_days, impressions, clicks, leads, conversions, revenue, acquisition_cost, roi, engagement_score
FROM mkt.campaigns WHERE campaign_id = 'NY-CMP-1000';

INSERT INTO campaign_channels
SELECT 'NY-CMP-56555', channel_id, channel_pos FROM mkt.campaign_channels WHERE campaign_id = 'NY-CMP-1000';

INSERT INTO campaigns_raw (brand_id, row_index, campaign_id, campaign_type, target_audience, duration, channel_used,
       impressions, clicks, leads, conversions, revenue, acquisition_cost, roi, `language`, engagement_score,
       customer_segment, date_raw)
SELECT brand_id, 55605, 'NY-CMP-56555', campaign_type, target_audience, duration, channel_used,
       impressions, clicks, leads, conversions, revenue, acquisition_cost, roi, `language`, engagement_score,
       customer_segment, '01-07-2025'
FROM mkt.campaigns_raw WHERE campaign_id = 'NY-CMP-1000';

-- (c) Nykaa sau bước (a): hạng 3 NY-CMP-56543 (4.119.654), hạng 4 NY-CMP-53612 (4.067.481) -> nâng hạng 4 lên bằng hạng 3
UPDATE campaigns
SET revenue = 4119654,
    roi = ROUND((4119654 - acquisition_cost * conversions) / (acquisition_cost * conversions), 2)
WHERE campaign_id = 'NY-CMP-53612';

UPDATE campaigns_raw r JOIN campaigns c ON c.campaign_id = r.campaign_id
SET r.revenue = c.revenue, r.roi = c.roi
WHERE r.campaign_id = 'NY-CMP-53612' AND r.revenue IS NOT NULL AND r.revenue > 0;

ANALYZE TABLE brands, campaign_types, audiences, languages, channels, calendar,
              campaigns, campaign_channels, campaigns_raw, noise_log;

-- ------------------------------------------------------------------ kiểm
SELECT 'campaigns' AS bang, (SELECT COUNT(*) FROM mkt.campaigns) AS mkt, (SELECT COUNT(*) FROM campaigns) AS hidden_1
UNION ALL SELECT 'campaign_channels', (SELECT COUNT(*) FROM mkt.campaign_channels), (SELECT COUNT(*) FROM campaign_channels)
UNION ALL SELECT 'campaigns_raw', (SELECT COUNT(*) FROM mkt.campaigns_raw), (SELECT COUNT(*) FROM campaigns_raw)
UNION ALL SELECT 'noise_log', (SELECT COUNT(*) FROM mkt.noise_log), (SELECT COUNT(*) FROM noise_log)
UNION ALL SELECT 'calendar', (SELECT COUNT(*) FROM mkt.calendar), (SELECT COUNT(*) FROM calendar);

SELECT campaign_id, revenue, roi,
       RANK() OVER (ORDER BY revenue DESC) AS hang
FROM campaigns WHERE brand_id = 1
ORDER BY revenue DESC, campaign_id LIMIT 5;
