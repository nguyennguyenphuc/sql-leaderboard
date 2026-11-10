-- 04_bo_sung_bien_the_hr.sql: bổ sung hr_hidden_1 để các câu chỉ dựa vào dòng không bị (a) chạm tới cũng ra khác public.
-- Chạy SAU 03_bien_the_an_hr.sql, chỉ trên hr_hidden_1 (không đụng hr). Chạy lặp lại được: xoá dòng giả theo khoá riêng rồi chèn lại.
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/hr/04_bo_sung_bien_the_hr.sql
-- Khoá giả dễ nhận: nhân viên E09001 (public tối đa E03872), vị trí P0901 (public tối đa P0426).
-- Mọi thay đổi ghi ở README-hr.md, bảng "Biến thể".
--   (d) nhân viên giả E09001: Account Executive bậc 3 ở Jakarta (Indonesia), vào làm 2025-10 (tenure 0, 1, 2),
--       3 dòng snapshot 2025-10 … 2025-12 + 1 dòng khảo sát 2025-Q4. 10 ngày công tác ở 2025-12 -> lọt top 10 câu r4.
--       Không nghỉ việc, làm thêm ít (không đụng cặp hoà (c), (c')), quản lý E00743 (còn làm ở 2025-12).
--   (e) vị trí giả P0901: Vietnam · Engineering · Data Engineer bậc 6, vị trí mới mở năm 2025, chưa có người:
--       positions + position_plan 2025 (định biên 2, thực tế 0, chỗ trống 2, không tuyển thay thế) + mức lương thị trường 2025.
--   (f) yêu cầu tuyển giả R9001: New headcount cho P0239 (Singapore · Engineering · Software Engineer bậc 4, vị trí có người
--       nhưng vắng trong kế hoạch 2025), attrition_month '2025-08', duyệt 2025-08-14 -> thêm 1 dòng "tuyển ngoài kế hoạch".

USE hr_hidden_1;

-- ------------------------------------------------------------------ xoá dòng giả cũ (idempotent)
DELETE FROM recruiting_pipeline       WHERE requisition_id = 'R9001';
DELETE FROM engagement_survey         WHERE employee_id = 'E09001';
DELETE FROM employee_monthly_snapshot WHERE employee_id = 'E09001';
DELETE FROM position_plan             WHERE position_id = 'P0901';
DELETE FROM country_market_benchmark  WHERE benchmark_year = 2025 AND country = 'Vietnam'
                                        AND job_role = 'Data Engineer' AND job_level = 6;
DELETE FROM positions                 WHERE position_id = 'P0901';

-- ------------------------------------------------------------------ (d) nhân viên giả E09001
-- compa_ratio = 1700 / 1753 (mức P50 Indonesia · Account Executive · bậc 3 năm 2025).
INSERT INTO employee_monthly_snapshot
  (employee_id, snapshot_month, country, city, department, job_role, job_family, job_level, age, age_band, gender,
   employment_type, work_model, monthly_salary_usd, compa_ratio, performance_rating, potential_rating,
   high_performer_flag, engagement_score, manager_effectiveness_score, overtime_hours, absence_days,
   training_hours_6m, business_travel_days, tenure_months, months_since_promotion, internal_move_last_12m,
   attrition_this_month, attrition_type, attrition_reason, manager_id, position_id,
   attrition_next_3m, attrition_next_5m, attrition_next_6m)
VALUES
  ('E09001', '2025-10', 'Indonesia', 'Jakarta', 'Sales', 'Account Executive', 'Account Executive', 3, 29, '25-34', 'Male',
   'Permanent', 'Hybrid', 1700, 0.970, 3, 'Medium', 0, 71, 62, 5, 0, 12, 6, 0, 0, 0, 0, NULL, NULL, 'E00743', 'P0064', 0, 0, 0),
  ('E09001', '2025-11', 'Indonesia', 'Jakarta', 'Sales', 'Account Executive', 'Account Executive', 3, 29, '25-34', 'Male',
   'Permanent', 'Hybrid', 1700, 0.970, 3, 'Medium', 0, 69, 62, 6, 1, 16, 8, 1, 1, 0, 0, NULL, NULL, 'E00743', 'P0064', 0, 0, 0),
  ('E09001', '2025-12', 'Indonesia', 'Jakarta', 'Sales', 'Account Executive', 'Account Executive', 3, 29, '25-34', 'Male',
   'Permanent', 'Hybrid', 1700, 0.970, 3, 'Medium', 0, 72, 62, 4, 0, 20, 10, 2, 2, 0, 0, NULL, NULL, 'E00743', 'P0064', 0, 0, 0);

INSERT INTO engagement_survey
  (employee_id, survey_quarter, engagement_score, manager_trust_score, workload_score, career_growth_score, eNPS, intent_to_stay)
VALUES ('E09001', '2025-Q4', 70, 66, 61, 73, 8, 4);

-- ------------------------------------------------------------------ (e) vị trí giả P0901 (chỉ có trong kế hoạch 2025)
INSERT INTO positions (position_id, country, department, job_family, job_level)
VALUES ('P0901', 'Vietnam', 'Engineering', 'Data Engineer', 6);

INSERT INTO position_plan
  (plan_period, position_id, country, department, job_role, job_level, actual_headcount, planned_headcount,
   vacancy_count, critical_role_flag, backfill_allowed, business_priority)
VALUES (2025, 'P0901', 'Vietnam', 'Engineering', 'Data Engineer', 6, 0, 2, 2, 1, 'No', 'High');

-- bậc 5 năm 2025: P50 4070, P75 5088 -> bậc 6 tăng khoảng 1,45 lần như các bậc dưới
INSERT INTO country_market_benchmark
  (benchmark_year, country, job_role, job_level, market_salary_p50_usd, market_salary_p75_usd, unemployment_proxy, hiring_difficulty)
VALUES (2025, 'Vietnam', 'Data Engineer', 6, 5900, 7375, 'Medium', 4);

-- ------------------------------------------------------------------ (f) yêu cầu tuyển giả R9001 (trong cửa sổ 2024-01 … 2025-12)
INSERT INTO recruiting_pipeline
  (requisition_id, position_id, vacated_employee_id, country, department, job_role, attrition_month, requisition_type,
   recruitment_source, approval_date, time_to_fill_days, offer_accept_date, start_date, recruiting_cost_usd)
VALUES ('R9001', 'P0239', NULL, 'Singapore', 'Engineering', 'Software Engineer', '2025-08', 'New headcount',
        'LinkedIn', '2025-08-14', 41, '2025-09-24', '2025-10-20', 3870);

ANALYZE TABLE employee_monthly_snapshot, engagement_survey, recruiting_pipeline, positions, position_plan, country_market_benchmark;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'employee_monthly_snapshot' AS bang, COUNT(*) AS hidden_1 FROM employee_monthly_snapshot
UNION ALL SELECT 'engagement_survey', COUNT(*) FROM engagement_survey
UNION ALL SELECT 'recruiting_pipeline', COUNT(*) FROM recruiting_pipeline
UNION ALL SELECT 'positions', COUNT(*) FROM positions
UNION ALL SELECT 'position_plan', COUNT(*) FROM position_plan
UNION ALL SELECT 'country_market_benchmark', COUNT(*) FROM country_market_benchmark;
