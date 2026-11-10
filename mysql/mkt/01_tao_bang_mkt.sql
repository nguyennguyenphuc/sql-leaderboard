-- 01_tao_bang_mkt.sql: 10 bảng của bộ Marketing (`mkt`), PK/FK/index.
-- Không ghi tên database: dùng chung cho `mkt` và `mkt_hidden_1` (chạy sau USE <db>).
-- Nguồn: Multi-Brand Marketing Campaign Performance Dataset (Kaggle, CC BY 4.0, synthetic),
--   3 file phẳng (Nykaa, Purplle, Tira Beauty) x 55.555 dòng, bản sạch *_original.csv và bản có nhiễu *.csv.
-- Thiết kế: README-mkt.md. Tên bảng/cột tiếng Anh snake_case như bộ scm.

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS noise_log, campaigns_raw, campaign_channels, campaigns,
                     calendar, channels, languages, audiences, campaign_types, brands;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ bảng danh mục
CREATE TABLE brands (
  brand_id     TINYINT UNSIGNED NOT NULL,
  brand_name   VARCHAR(20)      NOT NULL,      -- Nykaa, Purplle, Tira Beauty
  id_prefix    CHAR(2)          NOT NULL,      -- NY, PU, TI (đầu campaign_id)
  source_file  VARCHAR(40)      NOT NULL,      -- file CSV gốc (bản có nhiễu)
  PRIMARY KEY (brand_id),
  UNIQUE KEY uq_brands_name (brand_name),
  UNIQUE KEY uq_brands_prefix (id_prefix)
);

CREATE TABLE campaign_types (
  type_id    TINYINT UNSIGNED NOT NULL,
  type_name  VARCHAR(20)      NOT NULL,        -- Email, Influencer, Paid Ads, SEO, Social Media
  PRIMARY KEY (type_id),
  UNIQUE KEY uq_types_name (type_name)
);

-- Một danh mục dùng cho HAI vai: đối tượng mục tiêu (target_audience_id) và phân khúc khách hàng (segment_id)
CREATE TABLE audiences (
  audience_id    TINYINT UNSIGNED NOT NULL,
  audience_name  VARCHAR(30)      NOT NULL,    -- College Students, Premium Shoppers, Tier 2 City Customers, Working Women, Youth
  PRIMARY KEY (audience_id),
  UNIQUE KEY uq_audiences_name (audience_name)
);

CREATE TABLE languages (
  language_id    TINYINT UNSIGNED NOT NULL,
  language_name  VARCHAR(20)      NOT NULL,    -- Bengali, English, Hindi, Tamil
  PRIMARY KEY (language_id),
  UNIQUE KEY uq_languages_name (language_name)
);

CREATE TABLE channels (
  channel_id    TINYINT UNSIGNED NOT NULL,
  channel_name  VARCHAR(20)      NOT NULL,     -- Email, Facebook, Google, Instagram, WhatsApp, YouTube
  PRIMARY KEY (channel_id),
  UNIQUE KEY uq_channels_name (channel_name)
);

-- Lịch 12 tháng tròn 2024-07-01 .. 2025-06-30 (start_date 2024-07-01 .. 2025-06-24; ngày kết thúc muộn nhất 2025-06-28)
CREATE TABLE calendar (
  cal_date     DATE             NOT NULL,
  `year`       SMALLINT         NOT NULL,
  `quarter`    TINYINT          NOT NULL,
  `month`      TINYINT          NOT NULL,
  month_name   VARCHAR(10)      NOT NULL,      -- January .. December
  iso_year     SMALLINT         NOT NULL,      -- năm của tuần ISO (YEARWEEK(d,3) DIV 100)
  iso_week     TINYINT          NOT NULL,      -- tuần ISO 1..53 (WEEK(d,3))
  week_start   DATE             NOT NULL,      -- thứ Hai đầu tuần
  day_of_week  TINYINT          NOT NULL,      -- 1 = thứ Hai .. 7 = Chủ nhật (WEEKDAY()+1)
  day_name     VARCHAR(10)      NOT NULL,      -- Monday .. Sunday
  is_weekend   TINYINT(1)       NOT NULL,      -- 1 = thứ Bảy/Chủ nhật
  PRIMARY KEY (cal_date),
  KEY idx_calendar_week (week_start)
);

-- ------------------------------------------------------------------ bảng sự kiện (bản sạch)
CREATE TABLE campaigns (
  campaign_id         VARCHAR(12)       NOT NULL,   -- NY-CMP-1000 .. TI-CMP-56554
  brand_id            TINYINT UNSIGNED  NOT NULL,
  type_id             TINYINT UNSIGNED  NOT NULL,
  target_audience_id  TINYINT UNSIGNED  NOT NULL,   -- Target_Audience: đối tượng mục tiêu
  segment_id          TINYINT UNSIGNED  NOT NULL,   -- Customer_Segment: phân khúc khách hàng
  language_id         TINYINT UNSIGNED  NOT NULL,
  start_date          DATE              NOT NULL,   -- cột Date (DD-MM-YYYY) = ngày bắt đầu
  duration_days       TINYINT UNSIGNED  NOT NULL,   -- 5..30 ngày
  impressions         INT               NOT NULL,   -- lượt hiển thị
  clicks              INT               NOT NULL,   -- lượt nhấp
  leads               INT               NOT NULL,   -- khách hàng tiềm năng
  conversions         INT               NOT NULL,   -- lượt chuyển đổi
  revenue             INT               NOT NULL,   -- doanh thu (số nguyên)
  acquisition_cost    DECIMAL(10,2)     NOT NULL,   -- chi phí trên một chuyển đổi (CPA)
  roi                 DECIMAL(6,2)      NOT NULL,   -- ROI tính sẵn = (revenue - acquisition_cost*conversions) / (acquisition_cost*conversions)
  engagement_score    DECIMAL(5,2)      NOT NULL,   -- điểm tương tác
  PRIMARY KEY (campaign_id),
  KEY idx_campaigns_brand_date (brand_id, start_date),
  KEY idx_campaigns_date (start_date),
  KEY idx_campaigns_type (type_id),
  KEY idx_campaigns_target (target_audience_id),
  KEY idx_campaigns_segment (segment_id),
  KEY idx_campaigns_language (language_id),
  CONSTRAINT fk_campaigns_brand    FOREIGN KEY (brand_id)           REFERENCES brands (brand_id),
  CONSTRAINT fk_campaigns_type     FOREIGN KEY (type_id)            REFERENCES campaign_types (type_id),
  CONSTRAINT fk_campaigns_target   FOREIGN KEY (target_audience_id) REFERENCES audiences (audience_id),
  CONSTRAINT fk_campaigns_segment  FOREIGN KEY (segment_id)         REFERENCES audiences (audience_id),
  CONSTRAINT fk_campaigns_language FOREIGN KEY (language_id)        REFERENCES languages (language_id),
  CONSTRAINT fk_campaigns_date     FOREIGN KEY (start_date)         REFERENCES calendar (cal_date)
);

-- Cầu nối nhiều-nhiều chiến dịch x kênh (tách cột đa trị Channel_Used "WhatsApp, YouTube")
CREATE TABLE campaign_channels (
  campaign_id  VARCHAR(12)      NOT NULL,
  channel_id   TINYINT UNSIGNED NOT NULL,
  channel_pos  TINYINT UNSIGNED NOT NULL,   -- thứ tự kênh trong chuỗi gốc (1, 2, 3)
  PRIMARY KEY (campaign_id, channel_id),
  KEY idx_cc_channel (channel_id),
  CONSTRAINT fk_cc_campaign FOREIGN KEY (campaign_id) REFERENCES campaigns (campaign_id),
  CONSTRAINT fk_cc_channel  FOREIGN KEY (channel_id)  REFERENCES channels (channel_id)
);

-- ------------------------------------------------------------------ bản có nhiễu (module Data Quality)
-- Đúng như 3 file CSV có nhiễu (phẳng, giữ nguyên chuỗi), thêm brand_id và vị trí dòng.
-- Không có khoá ngoại tới campaigns (có dòng trùng campaign_id, ngày sai, khoảng trắng thừa...).
CREATE TABLE campaigns_raw (
  raw_id            INT UNSIGNED      NOT NULL AUTO_INCREMENT,  -- thứ tự nạp: Nykaa, Purplle, Tira Beauty
  brand_id          TINYINT UNSIGNED  NOT NULL,                 -- theo file nguồn
  row_index         INT UNSIGNED      NOT NULL,                 -- vị trí dòng trong file (0 = dòng dữ liệu đầu); >= 55555 là dòng trùng chép thêm
  campaign_id       VARCHAR(12)       NOT NULL,
  campaign_type     VARCHAR(30)       NOT NULL,                 -- có thể có khoảng trắng thừa
  target_audience   VARCHAR(40)       NOT NULL,
  duration          TINYINT UNSIGNED  NOT NULL,
  channel_used      VARCHAR(60)       NOT NULL,                 -- đa trị, "WhatsApp, YouTube"
  impressions       INT               NULL,                     -- có NULL, số âm
  clicks            INT               NULL,
  leads             INT               NULL,
  conversions       INT               NULL,
  revenue           INT               NULL,                     -- có NULL, số âm
  acquisition_cost  DECIMAL(10,2)     NULL,
  roi               DECIMAL(6,2)      NOT NULL,
  `language`        VARCHAR(30)       NOT NULL,
  engagement_score  DECIMAL(5,2)      NOT NULL,
  customer_segment  VARCHAR(40)       NOT NULL,
  date_raw          VARCHAR(12)       NULL,                     -- chuỗi gốc 'DD-MM-YYYY'; có giá trị lạ ('N/A', 'TBD', '2025-04-15', '31-13-2025'...) và NULL
  PRIMARY KEY (raw_id),
  UNIQUE KEY uq_raw_brand_row (brand_id, row_index),
  KEY idx_raw_campaign (campaign_id),
  CONSTRAINT fk_raw_brand FOREIGN KEY (brand_id) REFERENCES brands (brand_id)
);

-- Nhật ký nhiễu đã chèn (noise_log.csv của inject_noise.py) - "đáp án" để đối chiếu
CREATE TABLE noise_log (
  log_id       SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,  -- thứ tự trong file
  brand_id     TINYINT UNSIGNED  NOT NULL,
  row_index    INT UNSIGNED      NOT NULL,   -- = campaigns_raw.row_index (DUPLICATE: vị trí dòng GỐC bị chép)
  campaign_id  VARCHAR(12)       NOT NULL,
  noise_type   VARCHAR(15)       NOT NULL,   -- NULL, FUNNEL_ERROR, DUPLICATE, INVALID_DATE, NEGATIVE, WHITESPACE
  column_name  VARCHAR(20)       NOT NULL,   -- cột bị chèn nhiễu (tên cột trong CSV gốc)
  old_value    VARCHAR(60)       NULL,
  new_value    VARCHAR(60)       NULL,
  PRIMARY KEY (log_id),
  KEY idx_noise_brand_row (brand_id, row_index),
  KEY idx_noise_campaign (campaign_id),
  CONSTRAINT fk_noise_brand FOREIGN KEY (brand_id) REFERENCES brands (brand_id)
);
