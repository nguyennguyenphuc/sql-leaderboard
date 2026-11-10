-- 03_bien_the_an_hr.sql: biến thể ẩn hr_hidden_1 (chấm câu có bokiemtra={public, hidden-1}).
-- Chạy sau 02_nap_hr.sh, trong container sqllb-mysql (thư mục mysql/ mount ở /sqllb):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/hr/03_bien_the_an_hr.sql
-- Khuôn giống scm_hidden_1 / datathon_2026_hidden_1. Mọi thay đổi ghi ở README-hr.md, bảng "Biến thể".
--   (a) bỏ ~10%: mọi dòng của nhân viên có số hiệu % 10 = 7 (snapshot + khảo sát), yêu cầu tuyển dụng có số % 10 = 7
--   (b) thêm 1 dòng ngay sau mốc cuối: snapshot '2026-01', khảo sát '2026-Q1', yêu cầu tuyển dụng duyệt 2026-01-05
--   (c) cặp hoà hạng 3: top 3 nhân viên theo tổng overtime_hours năm 2025

DROP DATABASE IF EXISTS hr_hidden_1;
CREATE DATABASE hr_hidden_1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE hr_hidden_1;
SOURCE /sqllb/hr/01_tao_bang_hr.sql

-- ------------------------------------------------------------------ chép hr, (a) bỏ ~10% ngay khi chép
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO positions                SELECT * FROM hr.positions;
INSERT INTO country_market_benchmark SELECT * FROM hr.country_market_benchmark;
INSERT INTO position_plan            SELECT * FROM hr.position_plan;
INSERT INTO employee_monthly_snapshot SELECT * FROM hr.employee_monthly_snapshot
  WHERE CAST(SUBSTRING(employee_id, 2) AS UNSIGNED) % 10 <> 7;          -- E00007, E00017, ...: cả lịch sử
INSERT INTO engagement_survey        SELECT * FROM hr.engagement_survey
  WHERE CAST(SUBSTRING(employee_id, 2) AS UNSIGNED) % 10 <> 7;
INSERT INTO recruiting_pipeline      SELECT * FROM hr.recruiting_pipeline
  WHERE CAST(SUBSTRING(requisition_id, 2) AS UNSIGNED) % 10 <> 7;       -- R0007, R0017, ...
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ (b) 1 dòng ngay ngoài mốc cuối
-- snapshot: public 2024-01 … 2025-12 -> thêm tháng '2026-01' cho E00002 (đang làm ở 2025-12, không nghỉ):
-- chép dòng 2025-12, tenure +1, months_since_promotion +1, mọi cờ nghỉ việc = 0.
INSERT INTO employee_monthly_snapshot
SELECT employee_id, '2026-01', country, city, department, job_role, job_family, job_level, age, age_band, gender,
       employment_type, work_model, monthly_salary_usd, compa_ratio, performance_rating, potential_rating,
       high_performer_flag, engagement_score, manager_effectiveness_score, overtime_hours, absence_days,
       training_hours_6m, business_travel_days, tenure_months + 1, months_since_promotion + 1, internal_move_last_12m,
       0, NULL, NULL, manager_id, position_id, 0, 0, 0
FROM hr.employee_monthly_snapshot WHERE employee_id = 'E00002' AND snapshot_month = '2025-12';

-- khảo sát: public 2024-Q1 … 2025-Q4 -> thêm '2026-Q1' cho E00002 (chép 2025-Q4)
INSERT INTO engagement_survey
SELECT employee_id, '2026-Q1', engagement_score, manager_trust_score, workload_score, career_growth_score, eNPS, intent_to_stay
FROM hr.engagement_survey WHERE employee_id = 'E00002' AND survey_quarter = '2025-Q4';

-- tuyển dụng: approval_date public tới 2025-12-22, attrition_month tới '2025-12'
-- -> thêm R0801 (chép R0800, New headcount) duyệt 2026-01-05, attrition_month '2026-01'
INSERT INTO recruiting_pipeline
SELECT 'R0801', position_id, NULL, country, department, job_role, '2026-01', 'New headcount', recruitment_source,
       '2026-01-05', time_to_fill_days, '2026-01-05' + INTERVAL time_to_fill_days DAY,
       '2026-01-05' + INTERVAL (time_to_fill_days + DATEDIFF(start_date, offer_accept_date)) DAY, recruiting_cost_usd
FROM hr.recruiting_pipeline WHERE requisition_id = 'R0800';

-- ------------------------------------------------------------------ (c) cặp hoà hạng
-- Top 3 nhân viên theo SUM(overtime_hours) năm 2025 (sau bước a, như public):
--   E00371 1029, E01526 961, hạng 3 E02682 849, hạng 4 E01799 840.
--   Cộng 9 giờ vào tháng 2025-02 của E01799 (41 -> 50, Malaysia, dưới trần 104) -> E01799 = E02682 = 849.
--   ORDER BY tong DESC, employee_id: E01799 đứng hạng 3; RANK()/DENSE_RANK() trả 4 dòng.
UPDATE employee_monthly_snapshot SET overtime_hours = overtime_hours + 9
WHERE employee_id = 'E01799' AND snapshot_month = '2025-02';

ANALYZE TABLE employee_monthly_snapshot, engagement_survey, recruiting_pipeline;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'employee_monthly_snapshot' AS bang, (SELECT COUNT(*) FROM hr.employee_monthly_snapshot) AS public, COUNT(*) AS hidden_1 FROM employee_monthly_snapshot
UNION ALL SELECT 'engagement_survey', (SELECT COUNT(*) FROM hr.engagement_survey), COUNT(*) FROM engagement_survey
UNION ALL SELECT 'recruiting_pipeline', (SELECT COUNT(*) FROM hr.recruiting_pipeline), COUNT(*) FROM recruiting_pipeline;

SELECT employee_id, SUM(overtime_hours) AS tong, RANK() OVER (ORDER BY SUM(overtime_hours) DESC) AS hang
FROM employee_monthly_snapshot WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY employee_id ORDER BY tong DESC, employee_id LIMIT 5;
