-- solution.sql: gói 5 của bộ HR Analytics (dulieu=hr). Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Module 9 Data Quality (k1–k9), Module 10 Query Performance (p1–p9), case Khó c9, c10.
-- Chạy trên hr (public) và hr_hidden_1 (hidden-1).

-- ======================================================================= MODULE 9 · DATA QUALITY

-- [hr-k1-de-bat-vuot-tham-nien] solution
SELECT COUNT(*) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND months_since_promotion > tenure_months;

-- [hr-k1-de-bat-vuot-tham-nien] wrong: lon_hon_hoac_bang
-- Dùng >=: tính cả người chưa được đề bạt lần nào kể từ khi vào làm (hai số bằng nhau là hợp lý).
SELECT COUNT(*) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND months_since_promotion >= tenure_months;

-- [hr-k1-de-bat-vuot-tham-nien] wrong: quen_loc_thang
-- Không lọc tháng: đếm dòng nhân viên – tháng của cả 24 tháng, một người bị đếm nhiều lần.
SELECT COUNT(*) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE months_since_promotion > tenure_months;

-- [hr-k2-loai-ly-do-nghi] solution
SELECT attrition_type, attrition_reason, COUNT(*) AS so_nguoi,
       COUNT(CASE WHEN NOT (   (attrition_type = 'Retirement'  AND attrition_reason = 'Retirement' AND age >= 60)
                            OR (attrition_type = 'Involuntary' AND attrition_reason = 'Performance')
                            OR (attrition_type = 'Voluntary'
                                AND attrition_reason NOT IN ('Retirement', 'Performance')))
                  THEN 1 END) AS so_can_ra_soat
FROM employee_monthly_snapshot
WHERE attrition_this_month = 1
  AND snapshot_month BETWEEN '2024-01' AND '2025-12'
GROUP BY attrition_type, attrition_reason
ORDER BY attrition_type, attrition_reason;

-- [hr-k2-loai-ly-do-nghi] wrong: chi_kiem_cap_loai_ly_do
-- Chỉ kiểm cặp loại – lý do, bỏ quy tắc tuổi của nghỉ hưu: mọi nhóm ra 0.
SELECT attrition_type, attrition_reason, COUNT(*) AS so_nguoi,
       COUNT(CASE WHEN NOT (   (attrition_type = 'Retirement'  AND attrition_reason = 'Retirement')
                            OR (attrition_type = 'Involuntary' AND attrition_reason = 'Performance')
                            OR (attrition_type = 'Voluntary'
                                AND attrition_reason NOT IN ('Retirement', 'Performance')))
                  THEN 1 END) AS so_can_ra_soat
FROM employee_monthly_snapshot
WHERE attrition_this_month = 1
  AND snapshot_month BETWEEN '2024-01' AND '2025-12'
GROUP BY attrition_type, attrition_reason
ORDER BY attrition_type, attrition_reason;

-- [hr-k2-loai-ly-do-nghi] wrong: nguong_tuoi_lech_bien
-- Viết "từ 60 tuổi" thành age > 60: người nghỉ hưu đúng 60 tuổi bị đưa vào diện rà soát.
SELECT attrition_type, attrition_reason, COUNT(*) AS so_nguoi,
       COUNT(CASE WHEN NOT (   (attrition_type = 'Retirement'  AND attrition_reason = 'Retirement' AND age > 60)
                            OR (attrition_type = 'Involuntary' AND attrition_reason = 'Performance')
                            OR (attrition_type = 'Voluntary'
                                AND attrition_reason NOT IN ('Retirement', 'Performance')))
                  THEN 1 END) AS so_can_ra_soat
FROM employee_monthly_snapshot
WHERE attrition_this_month = 1
  AND snapshot_month BETWEEN '2024-01' AND '2025-12'
GROUP BY attrition_type, attrition_reason
ORDER BY attrition_type, attrition_reason;

-- [hr-k2-loai-ly-do-nghi] wrong: quen_loc_thang_nghi
-- Không lọc tháng nghỉ: mọi dòng còn làm việc gom thành một nhóm (NULL, NULL) rất lớn.
SELECT attrition_type, attrition_reason, COUNT(*) AS so_nguoi,
       COUNT(CASE WHEN NOT (   (attrition_type = 'Retirement'  AND attrition_reason = 'Retirement' AND age >= 60)
                            OR (attrition_type = 'Involuntary' AND attrition_reason = 'Performance')
                            OR (attrition_type = 'Voluntary'
                                AND attrition_reason NOT IN ('Retirement', 'Performance')))
                  THEN 1 END) AS so_can_ra_soat
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2024-01' AND '2025-12'
GROUP BY attrition_type, attrition_reason
ORDER BY attrition_type, attrition_reason;

-- [hr-k3-gan-ket-lech-so-cong-ty] solution
WITH so_sanh AS (
  SELECT s.department,
         ABS(s.engagement_score - k.engagement_score) > 10 AS lech
  FROM employee_monthly_snapshot s
  JOIN engagement_survey k
    ON k.employee_id = s.employee_id
   AND k.survey_quarter = CONCAT(LEFT(s.snapshot_month, 4), '-Q', QUARTER(CONCAT(s.snapshot_month, '-01')))
  WHERE s.snapshot_month BETWEEN '2024-01' AND '2025-12'
    AND s.engagement_score IS NOT NULL
), phong AS (
  SELECT department, COUNT(*) AS so_dong_so_sanh, SUM(lech) AS so_dong_lech
  FROM so_sanh
  GROUP BY department
)
SELECT department, so_dong_so_sanh,
       ROUND(100 * so_dong_lech / so_dong_so_sanh, 2) AS ty_le_lech_pct,
       ROUND(100 * so_dong_lech / so_dong_so_sanh
             - 100 * SUM(so_dong_lech) OVER () / SUM(so_dong_so_sanh) OVER (), 2) AS chenh_so_cong_ty
FROM phong
ORDER BY chenh_so_cong_ty DESC, department;

-- [hr-k3-gan-ket-lech-so-cong-ty] wrong: noi_theo_nam
-- Nối phiếu theo năm: mỗi dòng tháng gặp cả 4 phiếu của năm, số dòng so sánh nhân 4 và so với điểm của quý khác.
WITH so_sanh AS (
  SELECT s.department,
         ABS(s.engagement_score - k.engagement_score) > 10 AS lech
  FROM employee_monthly_snapshot s
  JOIN engagement_survey k
    ON k.employee_id = s.employee_id
   AND LEFT(k.survey_quarter, 4) = LEFT(s.snapshot_month, 4)
  WHERE s.snapshot_month BETWEEN '2024-01' AND '2025-12'
    AND s.engagement_score IS NOT NULL
), phong AS (
  SELECT department, COUNT(*) AS so_dong_so_sanh, SUM(lech) AS so_dong_lech
  FROM so_sanh
  GROUP BY department
)
SELECT department, so_dong_so_sanh,
       ROUND(100 * so_dong_lech / so_dong_so_sanh, 2) AS ty_le_lech_pct,
       ROUND(100 * so_dong_lech / so_dong_so_sanh
             - 100 * SUM(so_dong_lech) OVER () / SUM(so_dong_so_sanh) OVER (), 2) AS chenh_so_cong_ty
FROM phong
ORDER BY chenh_so_cong_ty DESC, department;

-- [hr-k3-gan-ket-lech-so-cong-ty] wrong: diem_trong_thanh_0
-- Thay ô trống bằng 0: dòng thiếu điểm tháng thành dòng so sánh và gần như luôn bị tính là lệch.
WITH so_sanh AS (
  SELECT s.department,
         ABS(COALESCE(s.engagement_score, 0) - k.engagement_score) > 10 AS lech
  FROM employee_monthly_snapshot s
  JOIN engagement_survey k
    ON k.employee_id = s.employee_id
   AND k.survey_quarter = CONCAT(LEFT(s.snapshot_month, 4), '-Q', QUARTER(CONCAT(s.snapshot_month, '-01')))
  WHERE s.snapshot_month BETWEEN '2024-01' AND '2025-12'
), phong AS (
  SELECT department, COUNT(*) AS so_dong_so_sanh, SUM(lech) AS so_dong_lech
  FROM so_sanh
  GROUP BY department
)
SELECT department, so_dong_so_sanh,
       ROUND(100 * so_dong_lech / so_dong_so_sanh, 2) AS ty_le_lech_pct,
       ROUND(100 * so_dong_lech / so_dong_so_sanh
             - 100 * SUM(so_dong_lech) OVER () / SUM(so_dong_so_sanh) OVER (), 2) AS chenh_so_cong_ty
FROM phong
ORDER BY chenh_so_cong_ty DESC, department;

-- [hr-k3-gan-ket-lech-so-cong-ty] wrong: quen_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 ghép được với phiếu '2026-Q1' nên phòng Sales thêm một dòng so sánh.
WITH so_sanh AS (
  SELECT s.department,
         ABS(s.engagement_score - k.engagement_score) > 10 AS lech
  FROM employee_monthly_snapshot s
  JOIN engagement_survey k
    ON k.employee_id = s.employee_id
   AND k.survey_quarter = CONCAT(LEFT(s.snapshot_month, 4), '-Q', QUARTER(CONCAT(s.snapshot_month, '-01')))
  WHERE s.snapshot_month >= '2024-01'
    AND s.engagement_score IS NOT NULL
), phong AS (
  SELECT department, COUNT(*) AS so_dong_so_sanh, SUM(lech) AS so_dong_lech
  FROM so_sanh
  GROUP BY department
)
SELECT department, so_dong_so_sanh,
       ROUND(100 * so_dong_lech / so_dong_so_sanh, 2) AS ty_le_lech_pct,
       ROUND(100 * so_dong_lech / so_dong_so_sanh
             - 100 * SUM(so_dong_lech) OVER () / SUM(so_dong_so_sanh) OVER (), 2) AS chenh_so_cong_ty
FROM phong
ORDER BY chenh_so_cong_ty DESC, department;

-- [hr-k3-gan-ket-lech-so-cong-ty] wrong: muc_chung_la_binh_quan_cac_phong
-- Lấy mức chung là bình quân tỷ lệ của sáu phòng ban: phòng đông người và phòng ít người có trọng số như nhau.
WITH so_sanh AS (
  SELECT s.department,
         ABS(s.engagement_score - k.engagement_score) > 10 AS lech
  FROM employee_monthly_snapshot s
  JOIN engagement_survey k
    ON k.employee_id = s.employee_id
   AND k.survey_quarter = CONCAT(LEFT(s.snapshot_month, 4), '-Q', QUARTER(CONCAT(s.snapshot_month, '-01')))
  WHERE s.snapshot_month BETWEEN '2024-01' AND '2025-12'
    AND s.engagement_score IS NOT NULL
), phong AS (
  SELECT department, COUNT(*) AS so_dong_so_sanh, 100 * SUM(lech) / COUNT(*) AS ty_le
  FROM so_sanh
  GROUP BY department
)
SELECT department, so_dong_so_sanh,
       ROUND(ty_le, 2) AS ty_le_lech_pct,
       ROUND(ty_le - AVG(ty_le) OVER (), 2) AS chenh_so_cong_ty
FROM phong
ORDER BY chenh_so_cong_ty DESC, department;

-- [hr-k4-bao-cao-vong] solution
SELECT a.employee_id AS nv_a, a.job_level AS bac_a,
       b.employee_id AS nv_b, b.job_level AS bac_b,
       a.country, a.department
FROM employee_monthly_snapshot a
JOIN employee_monthly_snapshot b
  ON b.employee_id    = a.manager_id
 AND b.snapshot_month = a.snapshot_month
 AND b.manager_id     = a.employee_id
WHERE a.snapshot_month = '2025-12'
  AND a.employee_id < b.employee_id
ORDER BY nv_a;

-- [hr-k4-bao-cao-vong] wrong: dem_moi_cap_hai_lan
-- Thiếu điều kiện a < b: mỗi cặp ra hai dòng (A, B) và (B, A).
SELECT a.employee_id AS nv_a, a.job_level AS bac_a,
       b.employee_id AS nv_b, b.job_level AS bac_b,
       a.country, a.department
FROM employee_monthly_snapshot a
JOIN employee_monthly_snapshot b
  ON b.employee_id    = a.manager_id
 AND b.snapshot_month = a.snapshot_month
 AND b.manager_id     = a.employee_id
WHERE a.snapshot_month = '2025-12'
ORDER BY nv_a;

-- [hr-k4-bao-cao-vong] wrong: quen_cung_thang
-- Nối quản lý ở mọi tháng: một cặp lặp theo số tháng của B, thêm cả cặp đã từng báo cáo vòng ở tháng khác.
SELECT DISTINCT a.employee_id AS nv_a, a.job_level AS bac_a,
       b.employee_id AS nv_b, b.job_level AS bac_b,
       a.country, a.department
FROM employee_monthly_snapshot a
JOIN employee_monthly_snapshot b
  ON b.employee_id = a.manager_id
 AND b.manager_id  = a.employee_id
WHERE a.snapshot_month = '2025-12'
  AND a.employee_id < b.employee_id
ORDER BY nv_a;

-- [hr-k5-ty-le-thieu-du-lieu] solution
-- Đếm cả sáu cột trong một lần đọc bảng, rồi mới tách thành mỗi cột một dòng.
WITH d AS (
  SELECT COUNT(*) AS so_dong,
         COUNT(*) - COUNT(absence_days)                AS absence_days,
         COUNT(*) - COUNT(engagement_score)            AS engagement_score,
         COUNT(*) - COUNT(training_hours_6m)           AS training_hours_6m,
         COUNT(*) - COUNT(manager_effectiveness_score) AS manager_effectiveness_score,
         COUNT(*) - COUNT(potential_rating)            AS potential_rating,
         COUNT(*) - COUNT(performance_rating)          AS performance_rating
  FROM employee_monthly_snapshot
  WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
), t AS (
  SELECT 'absence_days' AS ten_cot, absence_days AS so_dong_trong, so_dong FROM d
  UNION ALL SELECT 'engagement_score', engagement_score, so_dong FROM d
  UNION ALL SELECT 'training_hours_6m', training_hours_6m, so_dong FROM d
  UNION ALL SELECT 'manager_effectiveness_score', manager_effectiveness_score, so_dong FROM d
  UNION ALL SELECT 'potential_rating', potential_rating, so_dong FROM d
  UNION ALL SELECT 'performance_rating', performance_rating, so_dong FROM d
)
SELECT ten_cot, so_dong_trong, ROUND(100 * so_dong_trong / so_dong, 2) AS ty_le_trong_pct
FROM t
ORDER BY ty_le_trong_pct DESC, ten_cot;

-- [hr-k5-ty-le-thieu-du-lieu] wrong: count_cot_la_dem_trong
-- Hiểu nhầm COUNT(cột) đếm ô trống; thực ra COUNT(cột) đếm ô có giá trị.
WITH t AS (
  SELECT 'absence_days' AS ten_cot, COUNT(absence_days) AS so_dong_trong, COUNT(*) AS so_dong
  FROM employee_monthly_snapshot WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  UNION ALL
  SELECT 'engagement_score', COUNT(engagement_score), COUNT(*)
  FROM employee_monthly_snapshot WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  UNION ALL
  SELECT 'training_hours_6m', COUNT(training_hours_6m), COUNT(*)
  FROM employee_monthly_snapshot WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  UNION ALL
  SELECT 'manager_effectiveness_score', COUNT(manager_effectiveness_score), COUNT(*)
  FROM employee_monthly_snapshot WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  UNION ALL
  SELECT 'potential_rating', COUNT(potential_rating), COUNT(*)
  FROM employee_monthly_snapshot WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  UNION ALL
  SELECT 'performance_rating', COUNT(performance_rating), COUNT(*)
  FROM employee_monthly_snapshot WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
)
SELECT ten_cot, so_dong_trong, ROUND(100 * so_dong_trong / so_dong, 2) AS ty_le_trong_pct
FROM t
ORDER BY ty_le_trong_pct DESC, ten_cot;

-- [hr-k6-compa-tu-tinh] solution
SELECT s.country,
       COUNT(*) AS so_dong,
       SUM(ABS(s.compa_ratio - s.monthly_salary_usd / b.market_salary_p50_usd) > 0.02) AS so_dong_lech,
       ROUND(MAX(ABS(s.compa_ratio - s.monthly_salary_usd / b.market_salary_p50_usd)), 4) AS lech_lon_nhat
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.benchmark_year = LEFT(s.snapshot_month, 4)
 AND b.country        = s.country
 AND b.job_role       = s.job_family
 AND b.job_level      = s.job_level
WHERE s.snapshot_month BETWEEN '2025-01' AND '2025-12'
  AND s.job_family = 'Software Engineer'
GROUP BY s.country
ORDER BY s.country;

-- [hr-k6-compa-tu-tinh] wrong: noi_thieu_nam
-- Nối mức lương thị trường không theo năm: mỗi dòng gặp mức P50 của cả 2024 và 2025.
SELECT s.country,
       COUNT(*) AS so_dong,
       SUM(ABS(s.compa_ratio - s.monthly_salary_usd / b.market_salary_p50_usd) > 0.02) AS so_dong_lech,
       ROUND(MAX(ABS(s.compa_ratio - s.monthly_salary_usd / b.market_salary_p50_usd)), 4) AS lech_lon_nhat
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.country   = s.country
 AND b.job_role  = s.job_family
 AND b.job_level = s.job_level
WHERE s.snapshot_month BETWEEN '2025-01' AND '2025-12'
  AND s.job_family = 'Software Engineer'
GROUP BY s.country
ORDER BY s.country;

-- [hr-k7-doi-bac-thua-nguoi] starter
SELECT employee_id, MIN(job_level) AS bac_thap_nhat, MAX(job_level) AS bac_cao_nhat
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY employee_id
HAVING COUNT(DISTINCT job_level) >= 1
ORDER BY employee_id;

-- [hr-k7-doi-bac-thua-nguoi] solution
SELECT employee_id, MIN(job_level) AS bac_thap_nhat, MAX(job_level) AS bac_cao_nhat
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY employee_id
HAVING COUNT(DISTINCT job_level) > 1
ORDER BY employee_id;

-- [hr-k7-doi-bac-thua-nguoi] wrong: dem_so_thang
-- Bỏ DISTINCT: đếm số tháng có tên, nên ai có từ hai tháng trở lên đều vào danh sách.
SELECT employee_id, MIN(job_level) AS bac_thap_nhat, MAX(job_level) AS bac_cao_nhat
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY employee_id
HAVING COUNT(job_level) > 1
ORDER BY employee_id;

-- [hr-k7-doi-bac-thua-nguoi] wrong: bo_loc_nam
-- Bỏ điều kiện tháng: thêm người chỉ đổi bậc trong năm 2024.
SELECT employee_id, MIN(job_level) AS bac_thap_nhat, MAX(job_level) AS bac_cao_nhat
FROM employee_monthly_snapshot
GROUP BY employee_id
HAVING COUNT(DISTINCT job_level) > 1
ORDER BY employee_id;

-- [hr-k8-thieu-quan-ly-ra-0] starter
SELECT department,
       COUNT(*) AS so_nhan_vien,
       COUNT(CASE WHEN manager_id = '' THEN 1 END) AS so_thieu_quan_ly
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-k8-thieu-quan-ly-ra-0] solution
SELECT department,
       COUNT(*) AS so_nhan_vien,
       COUNT(CASE WHEN manager_id IS NULL THEN 1 END) AS so_thieu_quan_ly
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-k8-thieu-quan-ly-ra-0] wrong: count_cot_quan_ly
-- COUNT(manager_id) đếm dòng CÓ quản lý.
SELECT department,
       COUNT(*) AS so_nhan_vien,
       COUNT(manager_id) AS so_thieu_quan_ly
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-k8-thieu-quan-ly-ra-0] wrong: so_sanh_bang_null
-- manager_id = NULL luôn ra NULL nên không dòng nào được đếm.
SELECT department,
       COUNT(*) AS so_nhan_vien,
       COUNT(CASE WHEN manager_id = NULL THEN 1 END) AS so_thieu_quan_ly
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-k9-backfill-lech-thang] starter
SELECT r.country,
       COUNT(*) AS so_yeu_cau,
       COUNT(CASE WHEN s.job_level <> v.job_level THEN 1 END) AS so_lech_bac
FROM recruiting_pipeline r
JOIN positions v ON v.position_id = r.position_id
JOIN employee_monthly_snapshot s ON s.employee_id = r.vacated_employee_id
WHERE r.requisition_type = 'Backfill'
  AND r.approval_date BETWEEN '2025-01-01' AND '2025-12-01'
GROUP BY r.country
ORDER BY r.country;

-- [hr-k9-backfill-lech-thang] solution
SELECT r.country,
       COUNT(*) AS so_yeu_cau,
       COUNT(CASE WHEN s.job_level <> v.job_level THEN 1 END) AS so_lech_bac
FROM recruiting_pipeline r
JOIN positions v ON v.position_id = r.position_id
JOIN employee_monthly_snapshot s
  ON s.employee_id    = r.vacated_employee_id
 AND s.snapshot_month = r.attrition_month
WHERE r.requisition_type = 'Backfill'
  AND r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
GROUP BY r.country
ORDER BY r.country;

-- [hr-k9-backfill-lech-thang] wrong: chi_sua_can_tren
-- Sửa khoảng ngày nhưng vẫn nối người nghỉ với mọi tháng của họ.
SELECT r.country,
       COUNT(*) AS so_yeu_cau,
       COUNT(CASE WHEN s.job_level <> v.job_level THEN 1 END) AS so_lech_bac
FROM recruiting_pipeline r
JOIN positions v ON v.position_id = r.position_id
JOIN employee_monthly_snapshot s ON s.employee_id = r.vacated_employee_id
WHERE r.requisition_type = 'Backfill'
  AND r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
GROUP BY r.country
ORDER BY r.country;

-- [hr-k9-backfill-lech-thang] wrong: distinct_che_nhan_dong
-- Dùng COUNT(DISTINCT) che số dòng nhân lên; số lệch bậc vẫn đếm theo mọi tháng của người nghỉ.
SELECT r.country,
       COUNT(DISTINCT r.requisition_id) AS so_yeu_cau,
       COUNT(DISTINCT CASE WHEN s.job_level <> v.job_level THEN r.requisition_id END) AS so_lech_bac
FROM recruiting_pipeline r
JOIN positions v ON v.position_id = r.position_id
JOIN employee_monthly_snapshot s ON s.employee_id = r.vacated_employee_id
WHERE r.requisition_type = 'Backfill'
  AND r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
GROUP BY r.country
ORDER BY r.country;

-- [hr-k9-backfill-lech-thang] wrong: chi_sua_dieu_kien_thang
-- Nối đúng tháng nghỉ nhưng giữ cận trên ngày 01/12, mất yêu cầu duyệt trong tháng 12.
SELECT r.country,
       COUNT(*) AS so_yeu_cau,
       COUNT(CASE WHEN s.job_level <> v.job_level THEN 1 END) AS so_lech_bac
FROM recruiting_pipeline r
JOIN positions v ON v.position_id = r.position_id
JOIN employee_monthly_snapshot s
  ON s.employee_id    = r.vacated_employee_id
 AND s.snapshot_month = r.attrition_month
WHERE r.requisition_type = 'Backfill'
  AND r.approval_date BETWEEN '2025-01-01' AND '2025-12-01'
GROUP BY r.country
ORDER BY r.country;

-- ======================================================================= MODULE 10 · QUERY PERFORMANCE

-- [hr-p1-nghi-ba-loai-mot-lan-quet] starter
SELECT c.country,
       (SELECT COUNT(*) FROM employee_monthly_snapshot s
         WHERE s.country = c.country AND s.attrition_type = 'Voluntary'
           AND s.snapshot_month BETWEEN '2025-01' AND '2025-12') AS tu_nguyen,
       (SELECT COUNT(*) FROM employee_monthly_snapshot s
         WHERE s.country = c.country AND s.attrition_type = 'Involuntary'
           AND s.snapshot_month BETWEEN '2025-01' AND '2025-12') AS khong_tu_nguyen,
       (SELECT COUNT(*) FROM employee_monthly_snapshot s
         WHERE s.country = c.country AND s.attrition_type = 'Retirement'
           AND s.snapshot_month BETWEEN '2025-01' AND '2025-12') AS nghi_huu
FROM (SELECT DISTINCT country FROM employee_monthly_snapshot
      WHERE snapshot_month BETWEEN '2025-01' AND '2025-12') c
ORDER BY c.country;

-- [hr-p1-nghi-ba-loai-mot-lan-quet] solution
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary'   THEN 1 END) AS tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Involuntary' THEN 1 END) AS khong_tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Retirement'  THEN 1 END) AS nghi_huu
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-p1-nghi-ba-loai-mot-lan-quet] wrong: count_phep_so_sanh
-- COUNT(điều kiện) đếm mọi dòng có loại nghỉ (đúng hay sai đều khác NULL), ba cột thành tổng người nghỉ.
SELECT country,
       COUNT(attrition_type = 'Voluntary')   AS tu_nguyen,
       COUNT(attrition_type = 'Involuntary') AS khong_tu_nguyen,
       COUNT(attrition_type = 'Retirement')  AS nghi_huu
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-p1-nghi-ba-loai-mot-lan-quet] wrong: count_case_else_0
-- COUNT(CASE ... THEN 1 ELSE 0 END): COUNT đếm cả số 0, nên mỗi cột ra số dòng của nước.
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary'   THEN 1 ELSE 0 END) AS tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Involuntary' THEN 1 ELSE 0 END) AS khong_tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Retirement'  THEN 1 ELSE 0 END) AS nghi_huu
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-p2-chi-so-thang-mot-lan-quet] starter
SELECT
  (SELECT COUNT(*) FROM employee_monthly_snapshot
    WHERE snapshot_month = '2025-12' AND attrition_this_month = 0) AS quan_so_cuoi_thang,
  (SELECT COUNT(*) FROM employee_monthly_snapshot
    WHERE snapshot_month = '2025-12' AND attrition_this_month = 1) AS so_nguoi_nghi,
  (SELECT SUM(overtime_hours) FROM employee_monthly_snapshot
    WHERE snapshot_month = '2025-12') AS tong_gio_lam_them;

-- [hr-p2-chi-so-thang-mot-lan-quet] solution
SELECT COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang,
       SUM(attrition_this_month)            AS so_nguoi_nghi,
       SUM(overtime_hours)                  AS tong_gio_lam_them
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-p2-chi-so-thang-mot-lan-quet] wrong: quan_so_tinh_ca_nguoi_nghi
-- Quân số cuối tháng đếm cả người nghỉ trong tháng.
SELECT COUNT(*)                  AS quan_so_cuoi_thang,
       SUM(attrition_this_month) AS so_nguoi_nghi,
       SUM(overtime_hours)       AS tong_gio_lam_them
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-p3-loc-ngay-dung-chi-muc] starter
SELECT recruitment_source,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE YEAR(approval_date) = 2025
  AND QUARTER(approval_date) = 4
GROUP BY recruitment_source
ORDER BY so_yeu_cau DESC, recruitment_source;

-- [hr-p3-loc-ngay-dung-chi-muc] solution
SELECT recruitment_source,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01'
  AND approval_date < '2026-01-01'
GROUP BY recruitment_source
ORDER BY so_yeu_cau DESC, recruitment_source;

-- [hr-p3-loc-ngay-dung-chi-muc] wrong: quen_can_tren
-- Rớt ở hidden-1: yêu cầu R0801 duyệt ngày 2026-01-05 lọt vào quý 4/2025.
SELECT recruitment_source,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01'
GROUP BY recruitment_source
ORDER BY so_yeu_cau DESC, recruitment_source;

-- [hr-p3-loc-ngay-dung-chi-muc] wrong: doi_ham_khac_van_boc_cot
-- Đúng kết quả nhưng vẫn bọc cột trong hàm: đọc hết bảng như truy vấn khởi đầu, vượt ngân sách dòng trung gian.
SELECT recruitment_source,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE DATE_FORMAT(approval_date, '%Y-%m') BETWEEN '2025-10' AND '2025-12'
GROUP BY recruitment_source
ORDER BY so_yeu_cau DESC, recruitment_source;

-- [hr-p4-yeu-cau-ngoai-ke-hoach] starter
SELECT requisition_id, position_id, attrition_month, requisition_type
FROM recruiting_pipeline
WHERE attrition_month BETWEEN '2024-01' AND '2024-12'
  AND position_id NOT IN (SELECT position_id FROM position_plan WHERE plan_period = 2024)
UNION ALL
SELECT requisition_id, position_id, attrition_month, requisition_type
FROM recruiting_pipeline
WHERE attrition_month BETWEEN '2025-01' AND '2025-12'
  AND position_id NOT IN (SELECT position_id FROM position_plan WHERE plan_period = 2025)
ORDER BY requisition_id;

-- [hr-p4-yeu-cau-ngoai-ke-hoach] solution
SELECT r.requisition_id, r.position_id, r.attrition_month, r.requisition_type
FROM recruiting_pipeline r
LEFT JOIN position_plan p
  ON p.position_id = r.position_id
 AND p.plan_period = LEFT(r.attrition_month, 4)
WHERE r.attrition_month BETWEEN '2024-01' AND '2025-12'
  AND p.position_id IS NULL
ORDER BY r.requisition_id;

-- [hr-p4-yeu-cau-ngoai-ke-hoach] wrong: quen_can_tren
-- Rớt ở hidden-1: yêu cầu có tháng '2026-01' không có kế hoạch năm 2026 nên lọt vào danh sách.
SELECT r.requisition_id, r.position_id, r.attrition_month, r.requisition_type
FROM recruiting_pipeline r
LEFT JOIN position_plan p
  ON p.position_id = r.position_id
 AND p.plan_period = LEFT(r.attrition_month, 4)
WHERE r.attrition_month >= '2024-01'
  AND p.position_id IS NULL
ORDER BY r.requisition_id;

-- [hr-p4-yeu-cau-ngoai-ke-hoach] wrong: dieu_kien_nam_dat_o_where
-- Điều kiện năm đặt ở WHERE: dòng không có cặp có plan_period trống nên bị loại hết.
SELECT r.requisition_id, r.position_id, r.attrition_month, r.requisition_type
FROM recruiting_pipeline r
LEFT JOIN position_plan p
  ON p.position_id = r.position_id
WHERE r.attrition_month BETWEEN '2024-01' AND '2025-12'
  AND p.plan_period = LEFT(r.attrition_month, 4)
  AND p.position_id IS NULL
ORDER BY r.requisition_id;

-- [hr-p5-tang-luong-khong-tu-noi] starter
SELECT a.snapshot_month AS thang,
       COUNT(*) AS so_nguoi_tang_luong,
       ROUND(AVG(100 * (a.monthly_salary_usd - b.monthly_salary_usd) / b.monthly_salary_usd), 2) AS muc_tang_bq_pct
FROM employee_monthly_snapshot a
JOIN employee_monthly_snapshot b
  ON b.employee_id    = a.employee_id
 AND b.snapshot_month = DATE_FORMAT(DATE_SUB(CONCAT(a.snapshot_month, '-01'), INTERVAL 1 MONTH), '%Y-%m')
WHERE a.snapshot_month BETWEEN '2025-01' AND '2025-12'
  AND a.monthly_salary_usd > b.monthly_salary_usd
GROUP BY a.snapshot_month
ORDER BY thang;

-- [hr-p5-tang-luong-khong-tu-noi] solution
WITH x AS (
  SELECT snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month BETWEEN '2024-12' AND '2025-12'
)
SELECT snapshot_month AS thang,
       COUNT(*) AS so_nguoi_tang_luong,
       ROUND(AVG(100 * (monthly_salary_usd - luong_truoc) / luong_truoc), 2) AS muc_tang_bq_pct
FROM x
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  AND monthly_salary_usd > luong_truoc
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-p5-tang-luong-khong-tu-noi] wrong: loc_nam_truoc_khi_lag
-- Lọc năm 2025 trước khi lấy tháng trước: dòng tháng 1/2025 không còn tháng 12/2024 để so.
WITH x AS (
  SELECT snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
)
SELECT snapshot_month AS thang,
       COUNT(*) AS so_nguoi_tang_luong,
       ROUND(AVG(100 * (monthly_salary_usd - luong_truoc) / luong_truoc), 2) AS muc_tang_bq_pct
FROM x
WHERE monthly_salary_usd > luong_truoc
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-p5-tang-luong-khong-tu-noi] wrong: lag_khong_chia_theo_nguoi
-- Thiếu PARTITION BY employee_id: dòng trước là của người khác.
WITH x AS (
  SELECT snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (ORDER BY employee_id, snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month BETWEEN '2024-12' AND '2025-12'
)
SELECT snapshot_month AS thang,
       COUNT(*) AS so_nguoi_tang_luong,
       ROUND(AVG(100 * (monthly_salary_usd - luong_truoc) / luong_truoc), 2) AS muc_tang_bq_pct
FROM x
WHERE snapshot_month BETWEEN '2025-01' AND '2025-12'
  AND monthly_salary_usd > luong_truoc
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-p6-y-dinh-o-lai-mot-lan-quet] starter
SELECT '2025-Q1' AS quy, COUNT(*) AS so_phieu,
       ROUND(AVG(intent_to_stay), 2) AS y_dinh_o_lai_bq,
       ROUND(100 * SUM(intent_to_stay = 1) / COUNT(*), 2) AS ty_le_diem_1_pct
FROM engagement_survey WHERE survey_quarter = '2025-Q1'
UNION ALL
SELECT '2025-Q2', COUNT(*), ROUND(AVG(intent_to_stay), 2),
       ROUND(100 * SUM(intent_to_stay = 1) / COUNT(*), 2)
FROM engagement_survey WHERE survey_quarter = '2025-Q2'
UNION ALL
SELECT '2025-Q3', COUNT(*), ROUND(AVG(intent_to_stay), 2),
       ROUND(100 * SUM(intent_to_stay = 1) / COUNT(*), 2)
FROM engagement_survey WHERE survey_quarter = '2025-Q3'
UNION ALL
SELECT '2025-Q4', COUNT(*), ROUND(AVG(intent_to_stay), 2),
       ROUND(100 * SUM(intent_to_stay = 1) / COUNT(*), 2)
FROM engagement_survey WHERE survey_quarter = '2025-Q4'
ORDER BY quy;

-- [hr-p6-y-dinh-o-lai-mot-lan-quet] solution
SELECT survey_quarter AS quy, COUNT(*) AS so_phieu,
       ROUND(AVG(intent_to_stay), 2) AS y_dinh_o_lai_bq,
       ROUND(100 * SUM(intent_to_stay = 1) / COUNT(*), 2) AS ty_le_diem_1_pct
FROM engagement_survey
WHERE survey_quarter BETWEEN '2025-Q1' AND '2025-Q4'
GROUP BY survey_quarter
ORDER BY quy;

-- [hr-p6-y-dinh-o-lai-mot-lan-quet] wrong: quen_can_tren
-- Rớt ở hidden-1: phiếu '2026-Q1' của E00002 thành thêm một dòng quý.
SELECT survey_quarter AS quy, COUNT(*) AS so_phieu,
       ROUND(AVG(intent_to_stay), 2) AS y_dinh_o_lai_bq,
       ROUND(100 * SUM(intent_to_stay = 1) / COUNT(*), 2) AS ty_le_diem_1_pct
FROM engagement_survey
WHERE survey_quarter >= '2025-Q1'
GROUP BY survey_quarter
ORDER BY quy;

-- [hr-p6-y-dinh-o-lai-mot-lan-quet] wrong: count_dieu_kien
-- COUNT(điều kiện) đếm cả phiếu có điều kiện sai (giá trị 0 không phải NULL), nên tỷ lệ luôn 100%.
SELECT survey_quarter AS quy, COUNT(*) AS so_phieu,
       ROUND(AVG(intent_to_stay), 2) AS y_dinh_o_lai_bq,
       ROUND(100 * COUNT(intent_to_stay = 1) / COUNT(*), 2) AS ty_le_diem_1_pct
FROM engagement_survey
WHERE survey_quarter BETWEEN '2025-Q1' AND '2025-Q4'
GROUP BY survey_quarter
ORDER BY quy;

-- [hr-p7-dem-theo-thang-chi-muc] solution
SELECT snapshot_month AS thang,
       COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-10' AND '2025-12'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-p7-dem-theo-thang-chi-muc] wrong: loc_thang_khong_co_nam
-- Lọc theo hai ký tự cuối: lẫn cả quý 4/2024 (và bọc cột trong hàm nên đọc hết chỉ mục).
SELECT snapshot_month AS thang,
       COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE RIGHT(snapshot_month, 2) >= '10'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-p7-dem-theo-thang-chi-muc] wrong: tinh_ca_nguoi_nghi
-- Quân số cuối tháng đếm cả người nghỉ trong tháng.
SELECT snapshot_month AS thang, COUNT(*) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-10' AND '2025-12'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-p8-chuoi-thang-sai] starter
SELECT employee_id,
       COUNT(*) AS so_thang,
       MIN(engagement_score) AS diem_thap_nhat
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-7' AND '2025-12'
  AND potential_rating = 'High'
  AND engagement_score < 30
GROUP BY employee_id
ORDER BY employee_id;

-- [hr-p8-chuoi-thang-sai] solution
SELECT employee_id,
       COUNT(*) AS so_thang,
       MIN(engagement_score) AS diem_thap_nhat
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-07' AND '2025-12'
  AND potential_rating = 'High'
  AND engagement_score < 30
GROUP BY employee_id
ORDER BY employee_id;

-- [hr-p8-chuoi-thang-sai] wrong: ca_nam_2025
-- Đổi sang lọc cả năm 2025 bằng LIKE: thêm tháng 1–6.
SELECT employee_id,
       COUNT(*) AS so_thang,
       MIN(engagement_score) AS diem_thap_nhat
FROM employee_monthly_snapshot
WHERE snapshot_month LIKE '2025-%'
  AND potential_rating = 'High'
  AND engagement_score < 30
GROUP BY employee_id
ORDER BY employee_id;

-- [hr-p9-pareto-quan-ly] solution
WITH m AS (
  SELECT manager_id, COUNT(*) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary'
    AND manager_id IS NOT NULL
    AND snapshot_month BETWEEN '2024-01' AND '2025-12'
  GROUP BY manager_id
), lk AS (
  SELECT manager_id, so_nghi,
         SUM(so_nghi) OVER (ORDER BY so_nghi DESC, manager_id
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS luy_ke,
         SUM(so_nghi) OVER () AS tong
  FROM m
)
SELECT COUNT(*) AS so_quan_ly,
       COUNT(CASE WHEN luy_ke - so_nghi < tong / 2 THEN 1 END) AS so_quan_ly_dat_nua,
       ROUND(100 * COUNT(CASE WHEN luy_ke - so_nghi < tong / 2 THEN 1 END) / COUNT(*), 2) AS ty_le_quan_ly_pct
FROM lk;

-- [hr-p9-pareto-quan-ly] wrong: khung_range_mac_dinh
-- Không ghi khung ROWS: khung mặc định RANGE cộng cả các quản lý cùng số người nghỉ vào một bậc.
WITH m AS (
  SELECT manager_id, COUNT(*) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary'
    AND manager_id IS NOT NULL
    AND snapshot_month BETWEEN '2024-01' AND '2025-12'
  GROUP BY manager_id
), lk AS (
  SELECT manager_id, so_nghi,
         SUM(so_nghi) OVER (ORDER BY so_nghi DESC) AS luy_ke,
         SUM(so_nghi) OVER () AS tong
  FROM m
)
SELECT COUNT(*) AS so_quan_ly,
       COUNT(CASE WHEN luy_ke - so_nghi < tong / 2 THEN 1 END) AS so_quan_ly_dat_nua,
       ROUND(100 * COUNT(CASE WHEN luy_ke - so_nghi < tong / 2 THEN 1 END) / COUNT(*), 2) AS ty_le_quan_ly_pct
FROM lk;

-- [hr-p9-pareto-quan-ly] wrong: tinh_ca_nguoi_khong_quan_ly
-- Giữ nhóm manager_id trống như một "quản lý".
WITH m AS (
  SELECT manager_id, COUNT(*) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary'
    AND snapshot_month BETWEEN '2024-01' AND '2025-12'
  GROUP BY manager_id
), lk AS (
  SELECT manager_id, so_nghi,
         SUM(so_nghi) OVER (ORDER BY so_nghi DESC, manager_id
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS luy_ke,
         SUM(so_nghi) OVER () AS tong
  FROM m
)
SELECT COUNT(*) AS so_quan_ly,
       COUNT(CASE WHEN luy_ke - so_nghi < tong / 2 THEN 1 END) AS so_quan_ly_dat_nua,
       ROUND(100 * COUNT(CASE WHEN luy_ke - so_nghi < tong / 2 THEN 1 END) / COUNT(*), 2) AS ty_le_quan_ly_pct
FROM lk;

-- ======================================================================= CASE STUDY · KHÓ

-- [hr-c9-chi-phi-tuyen-thay-the.b1] solution
SELECT country, COUNT(*) AS so_nguoi_nghi
FROM employee_monthly_snapshot
WHERE attrition_this_month = 1
  AND snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-c9-chi-phi-tuyen-thay-the.b1] wrong: chi_dem_tu_nguyen
SELECT country, COUNT(*) AS so_nguoi_nghi
FROM employee_monthly_snapshot
WHERE attrition_type = 'Voluntary'
  AND snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-c9-chi-phi-tuyen-thay-the.b2] solution
SELECT country,
       COUNT(*) AS so_yeu_cau,
       SUM(recruiting_cost_usd) AS tong_chi_phi,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline
WHERE requisition_type = 'Backfill'
  AND attrition_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY tong_chi_phi DESC, country;

-- [hr-c9-chi-phi-tuyen-thay-the.b2] wrong: tinh_ca_tuyen_moi
-- Không lọc loại yêu cầu: lẫn tuyển mới theo định biên tăng thêm (và yêu cầu '2026-01' ở hidden-1).
SELECT country,
       COUNT(*) AS so_yeu_cau,
       SUM(recruiting_cost_usd) AS tong_chi_phi,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline
WHERE attrition_month >= '2025-01'
GROUP BY country
ORDER BY tong_chi_phi DESC, country;

-- [hr-c9-chi-phi-tuyen-thay-the.b3] solution
SELECT country, ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE requisition_type = 'Backfill'
  AND attrition_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY so_ngay_tuyen_bq DESC, country;

-- [hr-c9-chi-phi-tuyen-thay-the.b3] wrong: tinh_toi_ngay_di_lam
-- Đo tới ngày bắt đầu làm việc thay vì ngày nhận lời.
SELECT country, ROUND(AVG(DATEDIFF(start_date, approval_date)), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE requisition_type = 'Backfill'
  AND attrition_month BETWEEN '2025-01' AND '2025-12'
GROUP BY country
ORDER BY so_ngay_tuyen_bq DESC, country;

-- [hr-c9-chi-phi-tuyen-thay-the.b4] solution
SELECT r.country,
       ROUND(AVG(r.recruiting_cost_usd), 0)   AS chi_phi_bq,
       ROUND(AVG(b.market_salary_p50_usd), 0) AS luong_p50_bq,
       ROUND(AVG(r.recruiting_cost_usd) / AVG(b.market_salary_p50_usd), 2) AS so_thang_luong
FROM recruiting_pipeline r
JOIN positions v ON v.position_id = r.position_id
JOIN country_market_benchmark b
  ON b.benchmark_year = LEFT(r.attrition_month, 4)
 AND b.country        = r.country
 AND b.job_role       = r.job_role
 AND b.job_level      = v.job_level
WHERE r.requisition_type = 'Backfill'
  AND r.attrition_month BETWEEN '2025-01' AND '2025-12'
GROUP BY r.country
ORDER BY so_thang_luong DESC, r.country;

-- [hr-c9-chi-phi-tuyen-thay-the.b4] wrong: noi_thieu_bac
-- Nối mức lương thị trường không theo bậc: mỗi yêu cầu gặp mức P50 của mọi bậc cùng chức danh.
SELECT r.country,
       ROUND(AVG(r.recruiting_cost_usd), 0)   AS chi_phi_bq,
       ROUND(AVG(b.market_salary_p50_usd), 0) AS luong_p50_bq,
       ROUND(AVG(r.recruiting_cost_usd) / AVG(b.market_salary_p50_usd), 2) AS so_thang_luong
FROM recruiting_pipeline r
JOIN country_market_benchmark b
  ON b.benchmark_year = LEFT(r.attrition_month, 4)
 AND b.country        = r.country
 AND b.job_role       = r.job_role
WHERE r.requisition_type = 'Backfill'
  AND r.attrition_month BETWEEN '2025-01' AND '2025-12'
GROUP BY r.country
ORDER BY so_thang_luong DESC, r.country;

-- [hr-c10-tang-luong-nhom-compa-thap.b1] solution
SELECT COUNT(*) AS so_nhan_vien,
       COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) AS so_duoi_0_9,
       ROUND(100 * COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) / COUNT(*), 2) AS ty_trong_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month = '2025-12'
  AND attrition_this_month = 0;

-- [hr-c10-tang-luong-nhom-compa-thap.b1] wrong: tinh_ca_nguoi_nghi
SELECT COUNT(*) AS so_nhan_vien,
       COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) AS so_duoi_0_9,
       ROUND(100 * COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) / COUNT(*), 2) AS ty_trong_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month = '2025-12';

-- [hr-c10-tang-luong-nhom-compa-thap.b2] solution
SELECT CASE WHEN compa_ratio < 0.9 THEN 'Dưới 0,9' ELSE 'Từ 0,9 trở lên' END AS nhom,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(*) / 12, 2) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 12), 2) AS ty_le_nghi_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY nhom
ORDER BY nhom;

-- [hr-c10-tang-luong-nhom-compa-thap.b2] wrong: mau_so_dem_nguoi
-- Mẫu số đếm số người từng có tên trong năm, không phải quân số bình quân.
SELECT CASE WHEN compa_ratio < 0.9 THEN 'Dưới 0,9' ELSE 'Từ 0,9 trở lên' END AS nhom,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(DISTINCT employee_id), 2) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / COUNT(DISTINCT employee_id), 2) AS ty_le_nghi_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month BETWEEN '2025-01' AND '2025-12'
GROUP BY nhom
ORDER BY nhom;

-- [hr-c10-tang-luong-nhom-compa-thap.b3] solution
SELECT COUNT(*) AS so_nguoi,
       ROUND(SUM(0.95 * b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chi_phi_thang,
       ROUND(12 * SUM(0.95 * b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chi_phi_nam
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.benchmark_year = LEFT(s.snapshot_month, 4)
 AND b.country        = s.country
 AND b.job_role       = s.job_family
 AND b.job_level      = s.job_level
WHERE s.country = 'Vietnam'
  AND s.snapshot_month = '2025-12'
  AND s.attrition_this_month = 0
  AND s.compa_ratio < 0.9;

-- [hr-c10-tang-luong-nhom-compa-thap.b3] wrong: noi_thieu_nam
-- Nối mức lương thị trường không theo năm: mỗi người gặp mức P50 của 2024 và 2025, số người nhân đôi.
SELECT COUNT(*) AS so_nguoi,
       ROUND(SUM(0.95 * b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chi_phi_thang,
       ROUND(12 * SUM(0.95 * b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chi_phi_nam
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.country   = s.country
 AND b.job_role  = s.job_family
 AND b.job_level = s.job_level
WHERE s.country = 'Vietnam'
  AND s.snapshot_month = '2025-12'
  AND s.attrition_this_month = 0
  AND s.compa_ratio < 0.9;

-- [hr-c10-tang-luong-nhom-compa-thap.b4] solution
WITH tl AS (
  SELECT 100 * COUNT(CASE WHEN compa_ratio < 0.9 AND attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) / 12) AS tl_thap,
         100 * COUNT(CASE WHEN compa_ratio >= 0.9 AND attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(CASE WHEN compa_ratio >= 0.9 THEN 1 END) / 12) AS tl_con_lai
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam'
    AND snapshot_month BETWEEN '2025-01' AND '2025-12'
), nhom AS (
  SELECT COUNT(*) AS so_nguoi
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND snapshot_month = '2025-12'
    AND attrition_this_month = 0 AND compa_ratio < 0.9
), cp AS (
  SELECT AVG(recruiting_cost_usd) AS chi_phi_bq
  FROM recruiting_pipeline
  WHERE country = 'Vietnam' AND requisition_type = 'Backfill'
    AND attrition_month BETWEEN '2025-01' AND '2025-12'
)
SELECT ROUND((tl.tl_thap - tl.tl_con_lai) / 100 * nhom.so_nguoi, 2) AS so_nghi_tranh_duoc,
       ROUND(cp.chi_phi_bq, 0) AS chi_phi_tuyen_bq,
       ROUND((tl.tl_thap - tl.tl_con_lai) / 100 * nhom.so_nguoi * cp.chi_phi_bq, 0) AS chi_phi_tranh_duoc
FROM tl CROSS JOIN nhom CROSS JOIN cp;

-- [hr-c10-tang-luong-nhom-compa-thap.b4] wrong: tinh_ca_tuyen_moi
-- Chi phí tuyển bình quân lấy cả yêu cầu tuyển mới.
WITH tl AS (
  SELECT 100 * COUNT(CASE WHEN compa_ratio < 0.9 AND attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) / 12) AS tl_thap,
         100 * COUNT(CASE WHEN compa_ratio >= 0.9 AND attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(CASE WHEN compa_ratio >= 0.9 THEN 1 END) / 12) AS tl_con_lai
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam'
    AND snapshot_month BETWEEN '2025-01' AND '2025-12'
), nhom AS (
  SELECT COUNT(*) AS so_nguoi
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND snapshot_month = '2025-12'
    AND attrition_this_month = 0 AND compa_ratio < 0.9
), cp AS (
  SELECT AVG(recruiting_cost_usd) AS chi_phi_bq
  FROM recruiting_pipeline
  WHERE country = 'Vietnam'
    AND attrition_month BETWEEN '2025-01' AND '2025-12'
)
SELECT ROUND((tl.tl_thap - tl.tl_con_lai) / 100 * nhom.so_nguoi, 2) AS so_nghi_tranh_duoc,
       ROUND(cp.chi_phi_bq, 0) AS chi_phi_tuyen_bq,
       ROUND((tl.tl_thap - tl.tl_con_lai) / 100 * nhom.so_nguoi * cp.chi_phi_bq, 0) AS chi_phi_tranh_duoc
FROM tl CROSS JOIN nhom CROSS JOIN cp;
