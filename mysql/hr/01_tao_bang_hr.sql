-- 01_tao_bang_hr.sql: 6 bảng bộ HR Analytics (quản trị nhân lực), MySQL 8.0.
-- Không ghi tên database: dùng cho cả `hr` và `hr_hidden_1` (USE trước khi SOURCE).
-- Nguồn: Project 02 HR Analytics, data/generated/*.csv (Revision 3, 2026-06-21; data_dictionary.md).
-- `positions` là bảng chiều SUY RA (không có trong CSV): mọi position_id xuất hiện ở 3 bảng nguồn, để có khoá ngoại
-- (cùng cách dbt dim_position phục hồi vị trí mồ côi P0107; xem README-hr.md).
-- Tên cột giữ nguyên như CSV. Không dùng UNSIGNED: phép trừ hai cột UNSIGNED ra âm sẽ báo lỗi 1690 trong MySQL. Tháng/quý giữ chuỗi: snapshot_month, attrition_month 'YYYY-MM'; survey_quarter 'YYYY-QN'.

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS recruiting_pipeline, engagement_survey, employee_monthly_snapshot,
                     position_plan, country_market_benchmark, positions;
SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------- chiều vị trí (suy ra)
CREATE TABLE positions (
  position_id   VARCHAR(8)  NOT NULL,          -- P0001 … P0426: (country, department, job_family, job_level)
  country       VARCHAR(24) NOT NULL,
  department    VARCHAR(32) NOT NULL,
  job_family    VARCHAR(48) NOT NULL,
  job_level     TINYINT NOT NULL,     -- 1 … 7 (L1 … L7)
  PRIMARY KEY (position_id),
  KEY idx_pos_country_dept (country, department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ---------------------------------------------------------------- thang lương thị trường (tham chiếu ngoài)
CREATE TABLE country_market_benchmark (
  benchmark_year        SMALLINT NOT NULL,   -- 2024, 2025
  country               VARCHAR(24) NOT NULL,
  job_role              VARCHAR(48) NOT NULL,         -- = job_family
  job_level             TINYINT NOT NULL,
  market_salary_p50_usd INT NOT NULL,
  market_salary_p75_usd INT NOT NULL,
  unemployment_proxy    VARCHAR(12) NOT NULL,         -- Low / Medium / High
  hiring_difficulty     TINYINT NOT NULL,
  PRIMARY KEY (benchmark_year, country, job_role, job_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ---------------------------------------------------------------- kế hoạch định biên theo năm
CREATE TABLE position_plan (
  plan_period        SMALLINT NOT NULL,      -- 2024, 2025 (chốt tháng 12)
  position_id        VARCHAR(8)  NOT NULL,
  country            VARCHAR(24) NOT NULL,
  department         VARCHAR(32) NOT NULL,
  job_role           VARCHAR(48) NOT NULL,            -- = job_family
  job_level          TINYINT NOT NULL,
  actual_headcount   SMALLINT NOT NULL,
  planned_headcount  SMALLINT NOT NULL,
  vacancy_count      SMALLINT NOT NULL,               -- planned - actual
  critical_role_flag TINYINT(1) NOT NULL,             -- 1 nếu job_level >= 4
  backfill_allowed   VARCHAR(4)  NOT NULL,            -- 'Yes' / 'No' (chuỗi)
  business_priority  VARCHAR(8)  NOT NULL,            -- High / Medium / Low
  PRIMARY KEY (plan_period, position_id),
  KEY idx_plan_position (position_id),
  CONSTRAINT fk_plan_position FOREIGN KEY (position_id) REFERENCES positions (position_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ---------------------------------------------------------------- bảng sự kiện chính: nhân viên × tháng
CREATE TABLE employee_monthly_snapshot (
  employee_id                 VARCHAR(8)  NOT NULL,   -- E00001 …
  snapshot_month              CHAR(7)     NOT NULL,   -- 'YYYY-MM', 2024-01 … 2025-12
  country                     VARCHAR(24) NOT NULL,
  city                        VARCHAR(32) NOT NULL,
  department                  VARCHAR(32) NOT NULL,
  job_role                    VARCHAR(48) NOT NULL,   -- bí danh của job_family
  job_family                  VARCHAR(48) NOT NULL,
  job_level                   TINYINT NOT NULL,
  age                         TINYINT NOT NULL,
  age_band                    VARCHAR(8)  NOT NULL,
  gender                      VARCHAR(16) NOT NULL,   -- Male / Female / Non-disclosed
  employment_type             VARCHAR(12) NOT NULL,   -- Permanent / Contractor
  work_model                  VARCHAR(8)  NOT NULL,   -- Office / Hybrid / Remote
  monthly_salary_usd          INT NOT NULL,
  compa_ratio                 DECIMAL(5,3) NOT NULL,
  performance_rating          TINYINT NULL,  -- 1 … 4, ~2 % NULL
  potential_rating            VARCHAR(8)  NULL,       -- High / Medium / Low, ~3 % NULL
  high_performer_flag         TINYINT(1)  NOT NULL,
  engagement_score            TINYINT NULL,  -- 0 … 100, ~3,5 % NULL
  manager_effectiveness_score TINYINT NULL,  -- 0 … 100, ~3 % NULL
  overtime_hours              SMALLINT NOT NULL,
  absence_days                TINYINT NULL,  -- ~5 % NULL
  training_hours_6m           SMALLINT NULL, -- ~4 % NULL
  business_travel_days        TINYINT NOT NULL,
  tenure_months               SMALLINT NOT NULL,
  months_since_promotion      SMALLINT NOT NULL,
  internal_move_last_12m      TINYINT(1)  NOT NULL,
  attrition_this_month        TINYINT(1)  NOT NULL,
  attrition_type              VARCHAR(16) NULL,       -- chỉ ở tháng nghỉ việc
  attrition_reason            VARCHAR(32) NULL,       -- chỉ ở tháng nghỉ việc
  manager_id                  VARCHAR(8)  NULL,       -- employee_id của quản lý; ~1 % NULL
  position_id                 VARCHAR(8)  NOT NULL,
  attrition_next_3m           TINYINT(1)  NOT NULL,
  attrition_next_5m           TINYINT(1)  NOT NULL,
  attrition_next_6m           TINYINT(1)  NOT NULL,
  PRIMARY KEY (employee_id, snapshot_month),
  KEY idx_snap_month (snapshot_month),
  KEY idx_snap_position (position_id),
  KEY idx_snap_manager (manager_id),
  KEY idx_snap_country_dept (country, department),
  CONSTRAINT fk_snap_position FOREIGN KEY (position_id) REFERENCES positions (position_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ---------------------------------------------------------------- khảo sát gắn kết theo quý
CREATE TABLE engagement_survey (
  employee_id         VARCHAR(8) NOT NULL,
  survey_quarter      CHAR(7)    NOT NULL,            -- 'YYYY-QN', 2024-Q1 … 2025-Q4
  engagement_score    TINYINT NOT NULL,
  manager_trust_score TINYINT NOT NULL,
  workload_score      TINYINT NOT NULL,
  career_growth_score TINYINT NOT NULL,
  eNPS                TINYINT NOT NULL,      -- 0 … 10
  intent_to_stay      TINYINT NOT NULL,      -- 1 … 5
  PRIMARY KEY (employee_id, survey_quarter),
  KEY idx_survey_quarter (survey_quarter)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ---------------------------------------------------------------- yêu cầu tuyển dụng
CREATE TABLE recruiting_pipeline (
  requisition_id      VARCHAR(8)  NOT NULL,           -- R0001 …
  position_id         VARCHAR(8)  NOT NULL,
  vacated_employee_id VARCHAR(8)  NULL,               -- NULL với New headcount
  country             VARCHAR(24) NOT NULL,
  department          VARCHAR(32) NOT NULL,
  job_role            VARCHAR(48) NOT NULL,
  attrition_month     CHAR(7)     NOT NULL,           -- 'YYYY-MM'
  requisition_type    VARCHAR(16) NOT NULL,           -- Backfill / New headcount
  recruitment_source  VARCHAR(32) NOT NULL,
  approval_date       DATE        NOT NULL,
  time_to_fill_days   SMALLINT NOT NULL,
  offer_accept_date   DATE        NOT NULL,
  start_date          DATE        NOT NULL,
  recruiting_cost_usd INT NOT NULL,
  PRIMARY KEY (requisition_id),
  KEY idx_req_position (position_id),
  KEY idx_req_vacated (vacated_employee_id),
  KEY idx_req_approval (approval_date),
  CONSTRAINT fk_req_position FOREIGN KEY (position_id) REFERENCES positions (position_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
