-- 01_tao_bang_jelly.sql: 13 bảng + 2 view của bộ GAME Jelly Trail Academy (`jelly`) cho MySQL 8.0.
-- Sinh từ catalog Postgres của lớp (DB candy_game, CHỈ schema jelly_analytics; KHÔNG dùng schema public).
-- Không ghi tên database: chạy sau `USE jelly;` hoặc `USE jelly_hidden_1;` (xem 02_nap_jelly.sh, 03_bien_the_an_jelly.sql).
-- Bỏ: view live_player_wallets (đọc public.wallets/account_identities = dữ liệu tài khoản thật), bảng dataset_metadata
-- (manifest kỹ thuật). PG lưu MỌI cột dạng text; ở đây đổi kiểu (ghi đủ trong README-jelly.md):
--   'YYYY-MM-DD' -> DATE;  'YYYY-MM-DDTHH:MM:SS' -> DATETIME;  số nguyên -> INT/SMALLINT;  cờ '0'/'1' -> TINYINT(1)
--   tiền/tỷ lệ -> DECIMAL đủ số lẻ có trong dữ liệu;  purchases.level_id_if_relevant '12.0' -> INT (NULL giữ NULL)
-- PG chỉ có khoá chính một cột/ab_assignments; MySQL thêm khoá chính hạt dữ liệu (player_daily, tutorial_steps,
-- campaign_spend) và khoá ngoại logic — đã kiểm 0 dòng trùng, 0 dòng mồ côi trên dữ liệu nguồn.

SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS tutorial_step4_health, level_28_30_health;
DROP TABLE IF EXISTS booster_events, ad_events, purchases, level_attempts, tutorial_steps, player_daily,
  ab_assignments, sessions, users, level_metadata, liveops_events, campaign_spend, daily_kpi;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ bảng danh mục / tổng hợp
CREATE TABLE users (
  user_id             VARCHAR(32) NOT NULL,
  install_date        DATE NULL,
  platform            VARCHAR(16) NULL,
  country             CHAR(2) NULL,
  channel             VARCHAR(32) NULL,
  campaign_id         VARCHAR(40) NULL,
  app_version_install VARCHAR(10) NULL,
  device_tier         VARCHAR(8) NULL,
  PRIMARY KEY (user_id),
  KEY idx_users_install (install_date)
) ENGINE=InnoDB;

CREATE TABLE level_metadata (
  level_id                  SMALLINT NOT NULL,
  episode                   TINYINT NULL,
  world_name                VARCHAR(40) NULL,
  screen_context            VARCHAR(80) NULL,
  objective_type            VARCHAR(32) NULL,
  difficulty_tag            VARCHAR(20) NULL,
  moves_limit               SMALLINT NULL,
  designed_fail_probability DECIMAL(5,3) NULL,
  teaching_note             VARCHAR(160) NULL,
  PRIMARY KEY (level_id)
) ENGINE=InnoDB;

CREATE TABLE liveops_events (
  event_id       VARCHAR(16) NOT NULL,
  event_name     VARCHAR(40) NULL,
  start_date     DATE NULL,
  end_date       DATE NULL,
  screen_context VARCHAR(48) NULL,
  mechanic       VARCHAR(96) NULL,
  PRIMARY KEY (event_id)
) ENGINE=InnoDB;

-- hạt: 1 dòng / ngày / chiến dịch / quốc gia / nền tảng đích (PG không có khoá; đã kiểm không trùng)
CREATE TABLE campaign_spend (
  `date`          DATE NOT NULL,
  campaign_id     VARCHAR(40) NOT NULL,
  channel         VARCHAR(32) NULL,
  country         CHAR(2) NOT NULL,
  spend_usd       DECIMAL(10,2) NULL,
  target_platform VARCHAR(16) NOT NULL,
  PRIMARY KEY (`date`, campaign_id, country, target_platform)
) ENGINE=InnoDB;

CREATE TABLE daily_kpi (
  `date`           DATE NOT NULL,
  dau              INT NULL,
  new_users        INT NULL,
  sessions         INT NULL,
  playtime_minutes INT NULL,
  iap_revenue      DECIMAL(10,2) NULL,
  ad_revenue       DECIMAL(10,2) NULL,
  crash_count      INT NULL,
  arpdau           DECIMAL(8,4) NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB;

-- ------------------------------------------------------------------ phiên chơi và sự kiện
CREATE TABLE sessions (
  session_id       VARCHAR(64) NOT NULL,
  user_id          VARCHAR(32) NULL,
  session_start    DATETIME NULL,
  event_date       DATE NULL,
  event_time       DATETIME NULL,
  duration_minutes SMALLINT NULL,
  entry_screen     VARCHAR(16) NULL,
  app_version      VARCHAR(10) NULL,
  platform         VARCHAR(16) NULL,
  country          CHAR(2) NULL,
  PRIMARY KEY (session_id),
  KEY jelly_sessions_user_day_idx (user_id, event_date),
  KEY idx_sessions_date (event_date),
  CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=InnoDB;

-- hạt: 1 dòng / người chơi / ngày có hoạt động (PG không có khoá; đã kiểm không trùng)
CREATE TABLE player_daily (
  user_id               VARCHAR(32) NOT NULL,
  install_date          DATE NULL,
  activity_date         DATE NOT NULL,
  cohort_day            SMALLINT NULL,
  platform              VARCHAR(16) NULL,
  country               CHAR(2) NULL,
  channel               VARCHAR(32) NULL,
  campaign_id           VARCHAR(40) NULL,
  app_version           VARCHAR(10) NULL,
  sessions              SMALLINT NULL,
  playtime_minutes      SMALLINT NULL,
  max_level             SMALLINT NULL,
  boosters_used         SMALLINT NULL,
  extra_moves_purchased SMALLINT NULL,
  crash_count           SMALLINT NULL,
  iap_revenue           DECIMAL(8,2) NULL,
  ad_revenue            DECIMAL(10,4) NULL,
  PRIMARY KEY (user_id, activity_date),
  KEY jelly_daily_cohort_idx (cohort_day, app_version, platform, country),
  KEY idx_daily_activity (activity_date),
  CONSTRAINT fk_daily_user FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=InnoDB;

-- hạt: 1 dòng / người chơi / bước hướng dẫn đã bắt đầu (PG không có khoá; đã kiểm không trùng)
CREATE TABLE tutorial_steps (
  user_id        VARCHAR(32) NOT NULL,
  install_date   DATE NULL,
  event_time     DATETIME NULL,
  event_date     DATE NULL,
  session_id     VARCHAR(64) NULL,
  step_id        TINYINT NOT NULL,
  step_name      VARCHAR(80) NULL,
  screen_context VARCHAR(72) NULL,
  step_completed TINYINT(1) NULL,
  platform       VARCHAR(16) NULL,
  country        CHAR(2) NULL,
  channel        VARCHAR(32) NULL,
  app_version    VARCHAR(10) NULL,
  PRIMARY KEY (user_id, step_id),
  KEY jelly_tutorial_segment_idx (step_id, app_version, platform, country),
  CONSTRAINT fk_tutorial_user FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_tutorial_session FOREIGN KEY (session_id) REFERENCES sessions (session_id)
) ENGINE=InnoDB;

CREATE TABLE ab_assignments (
  user_id              VARCHAR(32) NOT NULL,
  experiment_id        VARCHAR(64) NOT NULL,
  variant              VARCHAR(48) NULL,
  assigned_at          DATETIME NULL,
  platform             VARCHAR(16) NULL,
  country              CHAR(2) NULL,
  eligible_at          DATETIME NULL,
  exposed_at           DATETIME NULL,
  exposure_status      VARCHAR(16) NULL,
  eligibility_rule     VARCHAR(80) NULL,
  primary_metric       VARCHAR(84) NULL,
  guardrail_metric     VARCHAR(24) NULL,
  analysis_window_days SMALLINT NULL,
  PRIMARY KEY (user_id, experiment_id),
  CONSTRAINT fk_ab_user FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=InnoDB;

CREATE TABLE level_attempts (
  attempt_id            VARCHAR(48) NOT NULL,
  user_id               VARCHAR(32) NULL,
  event_date            DATE NULL,
  event_time            DATETIME NULL,
  session_id            VARCHAR(64) NULL,
  level_id              SMALLINT NULL,
  episode               TINYINT NULL,
  world_name            VARCHAR(40) NULL,
  screen_context        VARCHAR(80) NULL,
  objective_type        VARCHAR(32) NULL,
  difficulty_tag        VARCHAR(20) NULL,
  moves_limit           SMALLINT NULL,
  moves_used            SMALLINT NULL,
  moves_left            SMALLINT NULL,
  result                VARCHAR(40) NULL,
  booster_used          TINYINT(1) NULL,
  extra_moves_offered   TINYINT(1) NULL,
  extra_moves_purchased TINYINT(1) NULL,
  duration_sec          SMALLINT NULL,
  app_version           VARCHAR(10) NULL,
  platform              VARCHAR(16) NULL,
  country               CHAR(2) NULL,
  PRIMARY KEY (attempt_id),
  KEY jelly_attempt_segment_idx (level_id, app_version, platform, country, result),
  KEY jelly_attempts_user_day_idx (user_id, event_date),
  KEY idx_attempts_date (event_date),
  CONSTRAINT fk_attempt_user FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_attempt_session FOREIGN KEY (session_id) REFERENCES sessions (session_id),
  CONSTRAINT fk_attempt_level FOREIGN KEY (level_id) REFERENCES level_metadata (level_id)
) ENGINE=InnoDB;

CREATE TABLE booster_events (
  booster_event_id VARCHAR(48) NOT NULL,
  attempt_id       VARCHAR(48) NULL,
  user_id          VARCHAR(32) NULL,
  event_date       DATE NULL,
  event_time       DATETIME NULL,
  session_id       VARCHAR(64) NULL,
  level_id         SMALLINT NULL,
  booster_type     VARCHAR(32) NULL,
  action           VARCHAR(8) NULL,
  screen_context   VARCHAR(56) NULL,
  app_version      VARCHAR(10) NULL,
  platform         VARCHAR(16) NULL,
  country          CHAR(2) NULL,
  PRIMARY KEY (booster_event_id),
  KEY jelly_boosters_user_day_idx (user_id, event_date),
  CONSTRAINT fk_booster_attempt FOREIGN KEY (attempt_id) REFERENCES level_attempts (attempt_id),
  CONSTRAINT fk_booster_user FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_booster_session FOREIGN KEY (session_id) REFERENCES sessions (session_id),
  CONSTRAINT fk_booster_level FOREIGN KEY (level_id) REFERENCES level_metadata (level_id)
) ENGINE=InnoDB;

CREATE TABLE purchases (
  transaction_id       VARCHAR(48) NOT NULL,
  user_id              VARCHAR(32) NULL,
  event_date           DATE NULL,
  event_time           DATETIME NULL,
  session_id           VARCHAR(64) NULL,
  product_type         VARCHAR(32) NULL,
  product_name         VARCHAR(32) NULL,
  price_usd            DECIMAL(6,2) NULL,
  level_id_if_relevant SMALLINT NULL,
  screen_context       VARCHAR(72) NULL,
  currency             CHAR(3) NULL,
  is_refund            TINYINT(1) NULL,
  app_version          VARCHAR(10) NULL,
  platform             VARCHAR(16) NULL,
  country              CHAR(2) NULL,
  PRIMARY KEY (transaction_id),
  KEY jelly_purchases_user_day_idx (user_id, event_date),
  CONSTRAINT fk_purchase_user FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_purchase_session FOREIGN KEY (session_id) REFERENCES sessions (session_id),
  CONSTRAINT fk_purchase_level FOREIGN KEY (level_id_if_relevant) REFERENCES level_metadata (level_id)
) ENGINE=InnoDB;

CREATE TABLE ad_events (
  ad_id          VARCHAR(48) NOT NULL,
  user_id        VARCHAR(32) NULL,
  event_date     DATE NULL,
  event_time     DATETIME NULL,
  session_id     VARCHAR(64) NULL,
  ad_type        VARCHAR(24) NULL,
  placement      VARCHAR(36) NULL,
  reward_type    VARCHAR(24) NULL,
  revenue_usd    DECIMAL(10,5) NULL,
  screen_context VARCHAR(60) NULL,
  app_version    VARCHAR(10) NULL,
  platform       VARCHAR(16) NULL,
  country        CHAR(2) NULL,
  PRIMARY KEY (ad_id),
  KEY jelly_ads_user_day_idx (user_id, event_date),
  KEY idx_ads_date (event_date),
  CONSTRAINT fk_ad_user FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_ad_session FOREIGN KEY (session_id) REFERENCES sessions (session_id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------------ 2 view chẩn đoán (định nghĩa chép từ PG)
CREATE VIEW tutorial_step4_health AS
SELECT app_version, platform,
       CASE WHEN country IN ('VN','TH','PH','ID') THEN 'SEA' ELSE 'Other' END AS region,
       AVG(CASE WHEN step_completed = 1 THEN 1.0 ELSE 0.0 END) AS completion_rate,
       COUNT(*) AS `rows`
FROM tutorial_steps
WHERE step_id = 4
GROUP BY app_version, platform, CASE WHEN country IN ('VN','TH','PH','ID') THEN 'SEA' ELSE 'Other' END;

CREATE VIEW level_28_30_health AS
SELECT app_version, platform,
       CASE WHEN country IN ('VN','TH','PH','ID') THEN 'SEA' ELSE 'Other' END AS region,
       AVG(CASE WHEN result = 'complete' THEN 1.0 ELSE 0.0 END) AS win_rate,
       AVG(CASE WHEN result <> 'complete' THEN 1.0 ELSE 0.0 END) AS non_complete_rate,
       COUNT(*) AS attempts
FROM level_attempts
WHERE level_id IN (28, 29, 30)
GROUP BY app_version, platform, CASE WHEN country IN ('VN','TH','PH','ID') THEN 'SEA' ELSE 'Other' END;
