-- solution.sql: gói 3 bộ HR Analytics (hr). Module 5 Joins, Module 6 Subqueries, case c5, c6.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên hr (public) và hr_hidden_1 (hidden-1).

-- ================================================================ MODULE 5 · JOINS

-- [hr-j1-yeu-cau-theo-bac] solution
SELECT p.job_level,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(r.recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline r
JOIN positions p ON p.position_id = r.position_id
WHERE r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
GROUP BY p.job_level
ORDER BY so_yeu_cau DESC, p.job_level;

-- [hr-j1-yeu-cau-theo-bac] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có thêm yêu cầu R0801 duyệt ngày 2026-01-05.
SELECT p.job_level,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(r.recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline r
JOIN positions p ON p.position_id = r.position_id
WHERE r.approval_date >= '2025-01-01'
GROUP BY p.job_level
ORDER BY so_yeu_cau DESC, p.job_level;

-- [hr-j1-yeu-cau-theo-bac] wrong: noi_ke_hoach_thieu_nam
-- Lấy bậc từ kế hoạch định biên nhưng chỉ nối theo vị trí: mỗi vị trí có hai năm kế hoạch nên mỗi yêu cầu lặp hai lần.
SELECT p.job_level,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(r.recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline r
JOIN position_plan p ON p.position_id = r.position_id
WHERE r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
GROUP BY p.job_level
ORDER BY so_yeu_cau DESC, p.job_level;

-- [hr-j2-ngoai-dinh-bien-van-tuyen] solution
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       s.department,
       s.job_level,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       COUNT(*) AS so_dong,
       COALESCE(y.so_yeu_cau, 0) AS so_yeu_cau
FROM employee_monthly_snapshot s
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
LEFT JOIN (SELECT position_id, YEAR(approval_date) AS nam, COUNT(*) AS so_yeu_cau
           FROM recruiting_pipeline
           GROUP BY position_id, YEAR(approval_date)) y
  ON y.position_id = s.position_id
 AND y.nam = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), s.department, s.job_level, y.so_yeu_cau
ORDER BY nam, s.position_id;

-- [hr-j2-ngoai-dinh-bien-van-tuyen] wrong: noi_ke_hoach_thieu_nam
-- Nối kế hoạch chỉ theo vị trí: vị trí có trong kế hoạch của năm khác vẫn khớp, chỉ còn vị trí vắng ở cả hai năm.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       s.department,
       s.job_level,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       COUNT(*) AS so_dong,
       COALESCE(y.so_yeu_cau, 0) AS so_yeu_cau
FROM employee_monthly_snapshot s
LEFT JOIN position_plan p ON p.position_id = s.position_id
LEFT JOIN (SELECT position_id, YEAR(approval_date) AS nam, COUNT(*) AS so_yeu_cau
           FROM recruiting_pipeline
           GROUP BY position_id, YEAR(approval_date)) y
  ON y.position_id = s.position_id
 AND y.nam = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), s.department, s.job_level, y.so_yeu_cau
ORDER BY nam, s.position_id;

-- [hr-j2-ngoai-dinh-bien-van-tuyen] wrong: noi_thang_yeu_cau
-- Nối thẳng bảng tuyển dụng vào dòng nhân viên – tháng: vị trí có hai yêu cầu thì mỗi dòng lặp hai lần, số dòng gấp đôi.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       s.department,
       s.job_level,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       COUNT(*) AS so_dong,
       COUNT(DISTINCT r.requisition_id) AS so_yeu_cau
FROM employee_monthly_snapshot s
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
LEFT JOIN recruiting_pipeline r
  ON r.position_id = s.position_id
 AND YEAR(r.approval_date) = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), s.department, s.job_level
ORDER BY nam, s.position_id;

-- [hr-j2-ngoai-dinh-bien-van-tuyen] wrong: phong_ban_tu_ke_hoach
-- Lấy phòng ban, bậc từ bảng kế hoạch: dòng không khớp kế hoạch nên hai cột này trống.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       p.department,
       p.job_level,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       COUNT(*) AS so_dong,
       COALESCE(y.so_yeu_cau, 0) AS so_yeu_cau
FROM employee_monthly_snapshot s
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
LEFT JOIN (SELECT position_id, YEAR(approval_date) AS nam, COUNT(*) AS so_yeu_cau
           FROM recruiting_pipeline
           GROUP BY position_id, YEAR(approval_date)) y
  ON y.position_id = s.position_id
 AND y.nam = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), p.department, p.job_level, y.so_yeu_cau
ORDER BY nam, s.position_id;

-- [hr-j2-ngoai-dinh-bien-van-tuyen] wrong: inner_join_yeu_cau
-- INNER JOIN với bảng đếm yêu cầu: vị trí ngoài định biên không có yêu cầu nào bị rơi khỏi danh sách.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       s.department,
       s.job_level,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       COUNT(*) AS so_dong,
       y.so_yeu_cau
FROM employee_monthly_snapshot s
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
JOIN (SELECT position_id, YEAR(approval_date) AS nam, COUNT(*) AS so_yeu_cau
      FROM recruiting_pipeline
      GROUP BY position_id, YEAR(approval_date)) y
  ON y.position_id = s.position_id
 AND y.nam = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), s.department, s.job_level, y.so_yeu_cau
ORDER BY nam, s.position_id;

-- [hr-j2-ngoai-dinh-bien-van-tuyen] wrong: thieu_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 không có kế hoạch năm 2026 nên thành thêm một vị trí ngoài định biên.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       s.department,
       s.job_level,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       COUNT(*) AS so_dong,
       COALESCE(y.so_yeu_cau, 0) AS so_yeu_cau
FROM employee_monthly_snapshot s
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
LEFT JOIN (SELECT position_id, YEAR(approval_date) AS nam, COUNT(*) AS so_yeu_cau
           FROM recruiting_pipeline
           GROUP BY position_id, YEAR(approval_date)) y
  ON y.position_id = s.position_id
 AND y.nam = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), s.department, s.job_level, y.so_yeu_cau
ORDER BY nam, s.position_id;

-- [hr-j3-tuyen-thay-nguoi-nghi-vi-luong] solution
SELECT r.requisition_id, r.vacated_employee_id, r.attrition_month,
       s.job_level, s.compa_ratio, r.approval_date
FROM recruiting_pipeline r
JOIN employee_monthly_snapshot s
  ON s.employee_id = r.vacated_employee_id
 AND s.snapshot_month = r.attrition_month
WHERE r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
  AND s.attrition_reason = 'Compensation'
ORDER BY r.approval_date, r.requisition_id;

-- [hr-j3-tuyen-thay-nguoi-nghi-vi-luong] wrong: noi_theo_vi_tri
-- Nối theo vị trí thay cho người nghỉ: yêu cầu khớp với mọi người cùng vị trí từng nghỉ vì lương.
SELECT r.requisition_id, r.vacated_employee_id, r.attrition_month,
       s.job_level, s.compa_ratio, r.approval_date
FROM recruiting_pipeline r
JOIN employee_monthly_snapshot s
  ON s.position_id = r.position_id
 AND s.snapshot_month = r.attrition_month
WHERE r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
  AND s.attrition_reason = 'Compensation'
ORDER BY r.approval_date, r.requisition_id;

-- [hr-j4-tin-tuong-quan-ly-cskh-philippines] solution
SELECT COUNT(*) AS so_phieu,
       ROUND(AVG(k.manager_trust_score), 2) AS tin_tuong_bq
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month = '2025-12'
WHERE k.survey_quarter = '2025-Q4'
  AND s.country = 'Philippines'
  AND s.department = 'Customer Support';

-- [hr-j4-tin-tuong-quan-ly-cskh-philippines] wrong: thieu_dieu_kien_thang
-- Nối chỉ theo mã nhân viên: mỗi phiếu lặp lại theo số tháng có tên của người trả lời.
SELECT COUNT(*) AS so_phieu,
       ROUND(AVG(k.manager_trust_score), 2) AS tin_tuong_bq
FROM engagement_survey k
JOIN employee_monthly_snapshot s ON s.employee_id = k.employee_id
WHERE k.survey_quarter = '2025-Q4'
  AND s.country = 'Philippines'
  AND s.department = 'Customer Support';

-- [hr-j4-tin-tuong-quan-ly-cskh-philippines] wrong: noi_ca_quy
-- Nối với cả ba tháng của quý thay cho tháng 12: mỗi phiếu lặp tới ba lần.
SELECT COUNT(*) AS so_phieu,
       ROUND(AVG(k.manager_trust_score), 2) AS tin_tuong_bq
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month >= '2025-10' AND s.snapshot_month <= '2025-12'
WHERE k.survey_quarter = '2025-Q4'
  AND s.country = 'Philippines'
  AND s.department = 'Customer Support';

-- [hr-j5-luong-duoi-thi-truong] solution
SELECT s.country,
       COUNT(*) AS so_nguoi,
       ROUND(AVG(b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chenh_lech_bq
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.benchmark_year = LEFT(s.snapshot_month, 4)
 AND b.country = s.country
 AND b.job_role = s.job_family
 AND b.job_level = s.job_level
WHERE s.snapshot_month = '2025-12'
  AND s.monthly_salary_usd < 0.8 * b.market_salary_p50_usd
GROUP BY s.country
ORDER BY so_nguoi DESC, s.country;

-- [hr-j5-luong-duoi-thi-truong] wrong: noi_thieu_nam
-- Thiếu điều kiện năm: mỗi nhân viên khớp hai dòng thang lương (2024 và 2025).
SELECT s.country,
       COUNT(*) AS so_nguoi,
       ROUND(AVG(b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chenh_lech_bq
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.country = s.country
 AND b.job_role = s.job_family
 AND b.job_level = s.job_level
WHERE s.snapshot_month = '2025-12'
  AND s.monthly_salary_usd < 0.8 * b.market_salary_p50_usd
GROUP BY s.country
ORDER BY so_nguoi DESC, s.country;

-- [hr-j5-luong-duoi-thi-truong] wrong: dung_compa_ratio
-- Lọc bằng compa_ratio có sẵn: cột này tính trước khi làm tròn lương nên lệch ở sát ngưỡng.
SELECT s.country,
       COUNT(*) AS so_nguoi,
       ROUND(AVG(b.market_salary_p50_usd - s.monthly_salary_usd), 0) AS chenh_lech_bq
FROM employee_monthly_snapshot s
JOIN country_market_benchmark b
  ON b.benchmark_year = LEFT(s.snapshot_month, 4)
 AND b.country = s.country
 AND b.job_role = s.job_family
 AND b.job_level = s.job_level
WHERE s.snapshot_month = '2025-12'
  AND s.compa_ratio < 0.8
GROUP BY s.country
ORDER BY so_nguoi DESC, s.country;

-- [hr-j6-quan-ly-khong-cao-hon] solution
SELECT e.country,
       COUNT(*) AS so_nhan_vien,
       COUNT(DISTINCT m.employee_id) AS so_quan_ly
FROM employee_monthly_snapshot e
JOIN employee_monthly_snapshot m
  ON m.employee_id = e.manager_id
 AND m.snapshot_month = e.snapshot_month
WHERE e.snapshot_month = '2025-12'
  AND m.job_level <= e.job_level
GROUP BY e.country
ORDER BY so_nhan_vien DESC, e.country;

-- [hr-j6-quan-ly-khong-cao-hon] wrong: thieu_cung_thang
-- Thiếu điều kiện cùng tháng: mỗi nhân viên khớp với mọi tháng của quản lý.
SELECT e.country,
       COUNT(*) AS so_nhan_vien,
       COUNT(DISTINCT m.employee_id) AS so_quan_ly
FROM employee_monthly_snapshot e
JOIN employee_monthly_snapshot m ON m.employee_id = e.manager_id
WHERE e.snapshot_month = '2025-12'
  AND m.job_level <= e.job_level
GROUP BY e.country
ORDER BY so_nhan_vien DESC, e.country;

-- [hr-j7-phieu-khao-sat-gap-ba] solution
SELECT s.department, COUNT(DISTINCT k.employee_id) AS so_phieu
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month >= '2025-10' AND s.snapshot_month <= '2025-12'
WHERE k.survey_quarter = '2025-Q4'
GROUP BY s.department
ORDER BY s.department;

-- [hr-j7-phieu-khao-sat-gap-ba] starter
SELECT s.department, COUNT(*) AS so_phieu
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month >= '2025-10' AND s.snapshot_month <= '2025-12'
WHERE k.survey_quarter = '2025-Q4'
GROUP BY s.department
ORDER BY s.department;

-- [hr-j7-phieu-khao-sat-gap-ba] wrong: chi_noi_thang_12
-- Chỉ nối tháng 12: mất phiếu của người đã nghỉ trong tháng 10, tháng 11.
SELECT s.department, COUNT(*) AS so_phieu
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month = '2025-12'
WHERE k.survey_quarter = '2025-Q4'
GROUP BY s.department
ORDER BY s.department;

-- [hr-j8-nghi-thang-11-ra-rong] solution
SELECT s.employee_id, s.attrition_type, r.requisition_id, r.start_date
FROM employee_monthly_snapshot s
JOIN recruiting_pipeline r ON r.vacated_employee_id = s.employee_id
WHERE s.snapshot_month = '2025-11'
  AND s.attrition_this_month = 1
  AND s.department = 'Engineering'
ORDER BY s.employee_id;

-- [hr-j8-nghi-thang-11-ra-rong] starter
SELECT s.employee_id, s.attrition_type, r.requisition_id, r.start_date
FROM employee_monthly_snapshot s
JOIN recruiting_pipeline r ON r.requisition_id = s.employee_id
WHERE s.snapshot_month = '2025-11'
  AND s.attrition_this_month = 1
  AND s.department = 'Engineering'
ORDER BY s.employee_id;

-- [hr-j8-nghi-thang-11-ra-rong] wrong: noi_theo_vi_tri
-- Nối theo vị trí và tháng nghỉ: người nghỉ khớp cả yêu cầu thay cho người khác cùng vị trí, cùng tháng.
SELECT s.employee_id, s.attrition_type, r.requisition_id, r.start_date
FROM employee_monthly_snapshot s
JOIN recruiting_pipeline r
  ON r.position_id = s.position_id
 AND r.attrition_month = s.snapshot_month
WHERE s.snapshot_month = '2025-11'
  AND s.attrition_this_month = 1
  AND s.department = 'Engineering'
ORDER BY s.employee_id;

-- [hr-j8-nghi-thang-11-ra-rong] wrong: left_join_giu_nguoi_chua_co_yeu_cau
-- LEFT JOIN giữ cả người chưa có yêu cầu tuyển thay thế. Public: mọi người đều có yêu cầu nên chỉ rớt ở hidden-1.
SELECT s.employee_id, s.attrition_type, r.requisition_id, r.start_date
FROM employee_monthly_snapshot s
LEFT JOIN recruiting_pipeline r ON r.vacated_employee_id = s.employee_id
WHERE s.snapshot_month = '2025-11'
  AND s.attrition_this_month = 1
  AND s.department = 'Engineering'
ORDER BY s.employee_id;

-- [hr-j9-trang-thai-quan-ly-vuot-100] solution
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM employee_monthly_snapshot
                               WHERE snapshot_month = '2025-12'), 2) AS ty_le_pct
FROM employee_monthly_snapshot e
LEFT JOIN employee_monthly_snapshot m
  ON m.employee_id = e.manager_id
 AND m.snapshot_month = e.snapshot_month
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- [hr-j9-trang-thai-quan-ly-vuot-100] starter
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM employee_monthly_snapshot
                               WHERE snapshot_month = '2025-12'), 2) AS ty_le_pct
FROM employee_monthly_snapshot e
JOIN employee_monthly_snapshot m ON m.employee_id = e.manager_id
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- [hr-j9-trang-thai-quan-ly-vuot-100] wrong: chi_sua_left_join
-- Chỉ đổi sang LEFT JOIN: quản lý đã nghỉ vẫn khớp các tháng cũ, mỗi nhân viên lặp nhiều dòng và mất nhóm quản lý không còn tên.
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM employee_monthly_snapshot
                               WHERE snapshot_month = '2025-12'), 2) AS ty_le_pct
FROM employee_monthly_snapshot e
LEFT JOIN employee_monthly_snapshot m ON m.employee_id = e.manager_id
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- [hr-j9-trang-thai-quan-ly-vuot-100] wrong: chi_them_cung_thang
-- Chỉ thêm điều kiện cùng tháng, giữ INNER JOIN: nhân viên không ghi quản lý và nhân viên có quản lý đã nghỉ bị rơi.
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM employee_monthly_snapshot
                               WHERE snapshot_month = '2025-12'), 2) AS ty_le_pct
FROM employee_monthly_snapshot e
JOIN employee_monthly_snapshot m
  ON m.employee_id = e.manager_id
 AND m.snapshot_month = e.snapshot_month
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- [hr-j9-trang-thai-quan-ly-vuot-100] wrong: dem_distinct_thay_cung_thang
-- LEFT JOIN thiếu điều kiện cùng tháng, chữa nhân dòng bằng COUNT(DISTINCT): người có quản lý đã nghỉ vẫn bị xếp vào nhóm quản lý còn tên.
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(DISTINCT e.employee_id) AS so_nhan_vien,
       ROUND(100 * COUNT(DISTINCT e.employee_id) / (SELECT COUNT(*) FROM employee_monthly_snapshot
                                                    WHERE snapshot_month = '2025-12'), 2) AS ty_le_pct
FROM employee_monthly_snapshot e
LEFT JOIN employee_monthly_snapshot m ON m.employee_id = e.manager_id
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- ================================================================ MODULE 6 · SUBQUERIES

-- [hr-q1-luong-tren-bq-bac] solution
SELECT s.employee_id, s.job_level, s.monthly_salary_usd
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND s.country = 'Vietnam'
  AND s.department = 'Finance'
  AND s.monthly_salary_usd > (SELECT AVG(s2.monthly_salary_usd)
                              FROM employee_monthly_snapshot s2
                              WHERE s2.snapshot_month = '2025-12'
                                AND s2.country = 'Vietnam'
                                AND s2.job_level = s.job_level)
ORDER BY s.job_level, s.employee_id;

-- [hr-q1-luong-tren-bq-bac] wrong: thieu_dieu_kien_thang
-- Truy vấn con lấy bình quân bậc của cả 24 tháng (lương các tháng trước thấp hơn).
SELECT s.employee_id, s.job_level, s.monthly_salary_usd
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND s.country = 'Vietnam'
  AND s.department = 'Finance'
  AND s.monthly_salary_usd > (SELECT AVG(s2.monthly_salary_usd)
                              FROM employee_monthly_snapshot s2
                              WHERE s2.country = 'Vietnam'
                                AND s2.job_level = s.job_level)
ORDER BY s.job_level, s.employee_id;

-- [hr-q1-luong-tren-bq-bac] wrong: bq_cua_phong
-- So với bình quân của chính phòng Tài chính thay cho bình quân bậc của cả Việt Nam.
SELECT s.employee_id, s.job_level, s.monthly_salary_usd
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND s.country = 'Vietnam'
  AND s.department = 'Finance'
  AND s.monthly_salary_usd > (SELECT AVG(s2.monthly_salary_usd)
                              FROM employee_monthly_snapshot s2
                              WHERE s2.snapshot_month = '2025-12'
                                AND s2.country = 'Vietnam'
                                AND s2.department = 'Finance'
                                AND s2.job_level = s.job_level)
ORDER BY s.job_level, s.employee_id;

-- [hr-q2-tuyen-khi-het-cho-trong] solution
SELECT r.country,
       COUNT(DISTINCT r.position_id) AS so_vi_tri,
       COUNT(*) AS so_yeu_cau
FROM recruiting_pipeline r
WHERE r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
  AND r.position_id IN (SELECT p.position_id
                        FROM position_plan p
                        WHERE p.plan_period = 2025
                          AND p.vacancy_count = 0)
GROUP BY r.country
ORDER BY so_yeu_cau DESC, r.country;

-- [hr-q2-tuyen-khi-het-cho-trong] wrong: ke_hoach_moi_nam
-- Truy vấn con không lọc năm kế hoạch: vị trí hết chỗ trống năm 2024 cũng bị tính.
SELECT r.country,
       COUNT(DISTINCT r.position_id) AS so_vi_tri,
       COUNT(*) AS so_yeu_cau
FROM recruiting_pipeline r
WHERE r.approval_date >= '2025-01-01' AND r.approval_date < '2026-01-01'
  AND r.position_id IN (SELECT p.position_id
                        FROM position_plan p
                        WHERE p.vacancy_count = 0)
GROUP BY r.country
ORDER BY so_yeu_cau DESC, r.country;

-- [hr-q2-tuyen-khi-het-cho-trong] wrong: thieu_can_tren
-- Rớt ở hidden-1 nếu vị trí của R0801 (chép R0800) hết chỗ trống năm 2025.
SELECT r.country,
       COUNT(DISTINCT r.position_id) AS so_vi_tri,
       COUNT(*) AS so_yeu_cau
FROM recruiting_pipeline r
WHERE r.approval_date >= '2025-01-01'
  AND r.position_id IN (SELECT p.position_id
                        FROM position_plan p
                        WHERE p.plan_period = 2025
                          AND p.vacancy_count = 0)
GROUP BY r.country
ORDER BY so_yeu_cau DESC, r.country;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] solution
SELECT s.country, s.department, s.engagement_score AS diem_cao_nhat, COUNT(*) AS so_nguoi_dat
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.department, s.engagement_score) IN
      (SELECT s2.country, s2.department, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       WHERE s2.snapshot_month = '2025-12'
       GROUP BY s2.country, s2.department)
GROUP BY s.country, s.department, s.engagement_score
ORDER BY s.country, s.department;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] wrong: max_ca_nuoc
-- Truy vấn con chỉ gom theo nước: mỗi nước chỉ còn phòng có người đạt mức cao nhất của cả nước.
SELECT s.country, s.department, s.engagement_score AS diem_cao_nhat, COUNT(*) AS so_nguoi_dat
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.engagement_score) IN
      (SELECT s2.country, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       WHERE s2.snapshot_month = '2025-12'
       GROUP BY s2.country)
GROUP BY s.country, s.department, s.engagement_score
ORDER BY s.country, s.department;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] wrong: max_ca_24_thang
-- Truy vấn con thiếu điều kiện tháng: so với điểm cao nhất của mỗi nhóm trong cả 24 tháng.
SELECT s.country, s.department, s.engagement_score AS diem_cao_nhat, COUNT(*) AS so_nguoi_dat
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.department, s.engagement_score) IN
      (SELECT s2.country, s2.department, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       GROUP BY s2.country, s2.department)
GROUP BY s.country, s.department, s.engagement_score
ORDER BY s.country, s.department;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] wrong: quen_thang_truy_van_ngoai
-- Truy vấn ngoài thiếu điều kiện tháng: đếm cả dòng của tháng khác có cùng điểm với mức cao nhất tháng 12.
SELECT s.country, s.department, s.engagement_score AS diem_cao_nhat, COUNT(*) AS so_nguoi_dat
FROM employee_monthly_snapshot s
WHERE (s.country, s.department, s.engagement_score) IN
      (SELECT s2.country, s2.department, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       WHERE s2.snapshot_month = '2025-12'
       GROUP BY s2.country, s2.department)
GROUP BY s.country, s.department, s.engagement_score
ORDER BY s.country, s.department;

-- [hr-q4-khao-sat-khong-bao-truoc] solution
SELECT s.country,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) AS so_khong_bao_truoc,
       ROUND(100 * COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
LEFT JOIN engagement_survey k
  ON k.employee_id = s.employee_id
 AND k.survey_quarter = (SELECT MAX(k2.survey_quarter)
                         FROM engagement_survey k2
                         WHERE k2.employee_id = s.employee_id
                           AND k2.survey_quarter <= CONCAT(LEFT(s.snapshot_month, 4), '-Q',
                                                           QUARTER(CONCAT(s.snapshot_month, '-01'))))
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
GROUP BY s.country
ORDER BY ty_le_pct DESC, s.country;

-- [hr-q4-khao-sat-khong-bao-truoc] wrong: quy_moi_nhat_ca_bang
-- Lấy quý lớn nhất của cả bảng khảo sát: chỉ người nghỉ trong quý 4 có phiếu khớp (hidden-1: quý lớn nhất là 2026-Q1, không ai khớp).
SELECT s.country,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) AS so_khong_bao_truoc,
       ROUND(100 * COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
LEFT JOIN engagement_survey k
  ON k.employee_id = s.employee_id
 AND k.survey_quarter = (SELECT MAX(k2.survey_quarter) FROM engagement_survey k2)
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
GROUP BY s.country
ORDER BY ty_le_pct DESC, s.country;

-- [hr-q4-khao-sat-khong-bao-truoc] wrong: so_quy_voi_thang
-- So chuỗi quý '2025-Q2' với chuỗi tháng '2025-05': chữ Q đứng sau chữ số nên mọi quý cùng năm bị loại, lấy nhầm phiếu năm trước.
SELECT s.country,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) AS so_khong_bao_truoc,
       ROUND(100 * COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
LEFT JOIN engagement_survey k
  ON k.employee_id = s.employee_id
 AND k.survey_quarter = (SELECT MAX(k2.survey_quarter)
                         FROM engagement_survey k2
                         WHERE k2.employee_id = s.employee_id
                           AND k2.survey_quarter <= s.snapshot_month)
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
GROUP BY s.country
ORDER BY ty_le_pct DESC, s.country;

-- [hr-q4-khao-sat-khong-bao-truoc] wrong: loc_y_dinh_o_where
-- Lọc điểm ý định ở lại ở WHERE: mẫu số chỉ còn người khảo sát không báo trước, tỷ lệ nước nào cũng 100%.
SELECT s.country,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) AS so_khong_bao_truoc,
       ROUND(100 * COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
JOIN engagement_survey k
  ON k.employee_id = s.employee_id
 AND k.survey_quarter = (SELECT MAX(k2.survey_quarter)
                         FROM engagement_survey k2
                         WHERE k2.employee_id = s.employee_id
                           AND k2.survey_quarter <= CONCAT(LEFT(s.snapshot_month, 4), '-Q',
                                                           QUARTER(CONCAT(s.snapshot_month, '-01'))))
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
  AND k.intent_to_stay >= 3
GROUP BY s.country
ORDER BY ty_le_pct DESC, s.country;

-- [hr-q4-khao-sat-khong-bao-truoc] wrong: mau_so_moi_loai_nghi
-- Tính mọi lượt nghỉ (cả nghỉ hưu, chấm dứt hợp đồng) thay cho nghỉ tự nguyện.
SELECT s.country,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) AS so_khong_bao_truoc,
       ROUND(100 * COUNT(CASE WHEN k.intent_to_stay >= 3 THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
LEFT JOIN engagement_survey k
  ON k.employee_id = s.employee_id
 AND k.survey_quarter = (SELECT MAX(k2.survey_quarter)
                         FROM engagement_survey k2
                         WHERE k2.employee_id = s.employee_id
                           AND k2.survey_quarter <= CONCAT(LEFT(s.snapshot_month, 4), '-Q',
                                                           QUARTER(CONCAT(s.snapshot_month, '-01'))))
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_this_month = 1
GROUP BY s.country
ORDER BY ty_le_pct DESC, s.country;

-- [hr-q5-sales-lam-them-tren-bq] solution
SELECT t.country,
       ROUND((SELECT AVG(t2.tong_gio)
              FROM (SELECT employee_id, country, SUM(overtime_hours) AS tong_gio
                    FROM employee_monthly_snapshot
                    WHERE department = 'Sales'
                      AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
                    GROUP BY employee_id, country) t2
              WHERE t2.country = t.country), 1) AS gio_bq_nguoi,
       COUNT(*) AS so_nguoi_tren_bq
FROM (SELECT employee_id, country, SUM(overtime_hours) AS tong_gio
      FROM employee_monthly_snapshot
      WHERE department = 'Sales'
        AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
      GROUP BY employee_id, country) t
WHERE t.tong_gio > (SELECT AVG(t2.tong_gio)
                    FROM (SELECT employee_id, country, SUM(overtime_hours) AS tong_gio
                          FROM employee_monthly_snapshot
                          WHERE department = 'Sales'
                            AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
                          GROUP BY employee_id, country) t2
                    WHERE t2.country = t.country)
GROUP BY t.country
ORDER BY t.country;

-- [hr-q5-sales-lam-them-tren-bq] wrong: so_voi_bq_dong_thang
-- So tổng giờ cả năm của một người với bình quân giờ của một dòng nhân viên – tháng.
SELECT t.country,
       ROUND((SELECT AVG(s2.overtime_hours)
              FROM employee_monthly_snapshot s2
              WHERE s2.department = 'Sales' AND s2.country = t.country
                AND s2.snapshot_month >= '2025-01' AND s2.snapshot_month <= '2025-12'), 1) AS gio_bq_nguoi,
       COUNT(*) AS so_nguoi_tren_bq
FROM (SELECT employee_id, country, SUM(overtime_hours) AS tong_gio
      FROM employee_monthly_snapshot
      WHERE department = 'Sales'
        AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
      GROUP BY employee_id, country) t
WHERE t.tong_gio > (SELECT AVG(s2.overtime_hours)
                    FROM employee_monthly_snapshot s2
                    WHERE s2.department = 'Sales' AND s2.country = t.country
                      AND s2.snapshot_month >= '2025-01' AND s2.snapshot_month <= '2025-12')
GROUP BY t.country
ORDER BY t.country;

-- [hr-q6-yeu-cau-thang-12-tuyen-lau] solution
SELECT requisition_id, department, approval_date, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-12-01' AND approval_date < '2026-01-01'
  AND time_to_fill_days > (SELECT AVG(time_to_fill_days) FROM recruiting_pipeline)
ORDER BY time_to_fill_days DESC, requisition_id;

-- [hr-q6-yeu-cau-thang-12-tuyen-lau] wrong: bq_rieng_thang_12
-- Mức bình quân chỉ lấy các yêu cầu tháng 12/2025 thay cho mọi yêu cầu trong bảng.
SELECT requisition_id, department, approval_date, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-12-01' AND approval_date < '2026-01-01'
  AND time_to_fill_days > (SELECT AVG(time_to_fill_days) FROM recruiting_pipeline
                           WHERE approval_date >= '2025-12-01' AND approval_date < '2026-01-01')
ORDER BY time_to_fill_days DESC, requisition_id;

-- [hr-q7-chua-quan-ly-ai-ra-rong] solution
SELECT e.country, COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot e
WHERE e.snapshot_month = '2025-12'
  AND e.job_level >= 5
  AND NOT EXISTS (SELECT 1
                  FROM employee_monthly_snapshot c
                  WHERE c.snapshot_month = '2025-12'
                    AND c.manager_id = e.employee_id)
GROUP BY e.country
ORDER BY e.country;

-- [hr-q7-chua-quan-ly-ai-ra-rong] starter
SELECT e.country, COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot e
WHERE e.snapshot_month = '2025-12'
  AND e.job_level >= 5
  AND e.employee_id NOT IN (SELECT c.manager_id
                            FROM employee_monthly_snapshot c
                            WHERE c.snapshot_month = '2025-12')
GROUP BY e.country
ORDER BY e.country;

-- [hr-q7-chua-quan-ly-ai-ra-rong] wrong: thieu_dieu_kien_thang
-- Bỏ điều kiện tháng trong truy vấn con: người từng quản lý ai đó ở tháng trước cũng bị loại.
SELECT e.country, COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot e
WHERE e.snapshot_month = '2025-12'
  AND e.job_level >= 5
  AND NOT EXISTS (SELECT 1
                  FROM employee_monthly_snapshot c
                  WHERE c.manager_id = e.employee_id)
GROUP BY e.country
ORDER BY e.country;

-- [hr-q8-tren-bq-phong-sai-nam] solution
SELECT employee_id, job_level, monthly_salary_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Singapore'
  AND department = 'Finance'
  AND monthly_salary_usd > (SELECT AVG(monthly_salary_usd)
                            FROM employee_monthly_snapshot
                            WHERE snapshot_month = '2025-12'
                              AND country = 'Singapore'
                              AND department = 'Finance')
ORDER BY monthly_salary_usd DESC, employee_id;

-- [hr-q8-tren-bq-phong-sai-nam] starter
SELECT employee_id, job_level, monthly_salary_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Singapore'
  AND department = 'Finance'
  AND monthly_salary_usd > (SELECT AVG(monthly_salary_usd)
                            FROM employee_monthly_snapshot
                            WHERE snapshot_month = '2024-12'
                              AND country = 'Singapore'
                              AND department = 'Finance')
ORDER BY monthly_salary_usd DESC, employee_id;

-- [hr-q8-tren-bq-phong-sai-nam] wrong: bo_loc_nuoc
-- Sửa đúng tháng nhưng bỏ điều kiện nước trong truy vấn con: so với bình quân phòng Tài chính của cả sáu nước.
SELECT employee_id, job_level, monthly_salary_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Singapore'
  AND department = 'Finance'
  AND monthly_salary_usd > (SELECT AVG(monthly_salary_usd)
                            FROM employee_monthly_snapshot
                            WHERE snapshot_month = '2025-12'
                              AND department = 'Finance')
ORDER BY monthly_salary_usd DESC, employee_id;

-- [hr-q9-ly-do-pho-bien-hai-loi] solution
SELECT t.country, t.attrition_reason, t.so_nguoi
FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
      FROM employee_monthly_snapshot
      WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
        AND attrition_type = 'Voluntary'
      GROUP BY country, attrition_reason) t
WHERE t.so_nguoi = (SELECT MAX(t2.so_nguoi)
                    FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
                          FROM employee_monthly_snapshot
                          WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
                            AND attrition_type = 'Voluntary'
                          GROUP BY country, attrition_reason) t2
                    WHERE t2.country = t.country)
ORDER BY t.country, t.attrition_reason;

-- [hr-q9-ly-do-pho-bien-hai-loi] starter
SELECT t.country, t.attrition_reason, t.so_nguoi
FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
      FROM employee_monthly_snapshot
      WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
        AND attrition_this_month = 1
      GROUP BY country, attrition_reason) t
WHERE t.so_nguoi = (SELECT MAX(t2.so_nguoi)
                    FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
                          FROM employee_monthly_snapshot
                          WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
                            AND attrition_this_month = 1
                          GROUP BY country, attrition_reason) t2)
ORDER BY t.country, t.attrition_reason;

-- [hr-q9-ly-do-pho-bien-hai-loi] wrong: chi_sua_tuong_quan
-- Chỉ thêm tương quan theo nước, vẫn đếm mọi loại nghỉ: lý do nghỉ hưu lọt vào nhóm hoà ở Thái Lan.
SELECT t.country, t.attrition_reason, t.so_nguoi
FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
      FROM employee_monthly_snapshot
      WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
        AND attrition_this_month = 1
      GROUP BY country, attrition_reason) t
WHERE t.so_nguoi = (SELECT MAX(t2.so_nguoi)
                    FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
                          FROM employee_monthly_snapshot
                          WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
                            AND attrition_this_month = 1
                          GROUP BY country, attrition_reason) t2
                    WHERE t2.country = t.country)
ORDER BY t.country, t.attrition_reason;

-- [hr-q9-ly-do-pho-bien-hai-loi] wrong: chi_sua_loai_nghi
-- Chỉ đổi sang nghỉ tự nguyện, truy vấn con vẫn lấy số lớn nhất của cả công ty: bảng còn một nước.
SELECT t.country, t.attrition_reason, t.so_nguoi
FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
      FROM employee_monthly_snapshot
      WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
        AND attrition_type = 'Voluntary'
      GROUP BY country, attrition_reason) t
WHERE t.so_nguoi = (SELECT MAX(t2.so_nguoi)
                    FROM (SELECT country, attrition_reason, COUNT(*) AS so_nguoi
                          FROM employee_monthly_snapshot
                          WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
                            AND attrition_type = 'Voluntary'
                          GROUP BY country, attrition_reason) t2)
ORDER BY t.country, t.attrition_reason;

-- ================================================================ CASE STUDY

-- [hr-c5-tuyen-thay-the-kip-khong.b1] solution
SELECT attrition_type, COUNT(*) AS so_nguoi_nghi
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  AND attrition_this_month = 1
GROUP BY attrition_type
ORDER BY so_nguoi_nghi DESC, attrition_type;

-- [hr-c5-tuyen-thay-the-kip-khong.b2] solution
SELECT s.attrition_type,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(r.requisition_id) AS so_co_yeu_cau,
       ROUND(100 * COUNT(r.requisition_id) / COUNT(*), 2) AS ty_le_pct,
       ROUND(AVG(DATEDIFF(r.start_date, LAST_DAY(CONCAT(s.snapshot_month, '-01')))), 1) AS so_ngay_bq,
       COUNT(CASE WHEN r.start_date >= '2026-01-01' THEN 1 END) AS so_di_lam_sau_2025
FROM employee_monthly_snapshot s
LEFT JOIN recruiting_pipeline r
  ON r.vacated_employee_id = s.employee_id
 AND r.attrition_month = s.snapshot_month
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_this_month = 1
GROUP BY s.attrition_type
ORDER BY so_nguoi_nghi DESC, s.attrition_type;

-- [hr-c5-tuyen-thay-the-kip-khong.b2] wrong: inner_join
-- INNER JOIN làm mất nhóm người nghỉ không có yêu cầu tuyển thay thế.
SELECT s.attrition_type,
       COUNT(*) AS so_nguoi_nghi,
       COUNT(r.requisition_id) AS so_co_yeu_cau,
       ROUND(100 * COUNT(r.requisition_id) / COUNT(*), 2) AS ty_le_pct,
       ROUND(AVG(DATEDIFF(r.start_date, LAST_DAY(CONCAT(s.snapshot_month, '-01')))), 1) AS so_ngay_bq,
       COUNT(CASE WHEN r.start_date >= '2026-01-01' THEN 1 END) AS so_di_lam_sau_2025
FROM employee_monthly_snapshot s
JOIN recruiting_pipeline r
  ON r.vacated_employee_id = s.employee_id
 AND r.attrition_month = s.snapshot_month
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_this_month = 1
GROUP BY s.attrition_type
ORDER BY so_nguoi_nghi DESC, s.attrition_type;

-- [hr-c6-luong-thap-va-nghi-viec.b1] solution
SELECT CASE WHEN compa_ratio < 0.9 THEN '1_duoi_0_9'
            WHEN compa_ratio <= 1.1 THEN '2_tu_0_9_den_1_1'
            ELSE '3_tren_1_1' END AS nhom_compa,
       COUNT(*) AS so_dong,
       ROUND(COUNT(*) / 12, 1) AS quan_so_bq,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM employee_monthly_snapshot
                               WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'), 2) AS ty_trong_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY nhom_compa
ORDER BY nhom_compa;

-- [hr-c6-luong-thap-va-nghi-viec.b2] solution
SELECT CASE WHEN compa_ratio < 0.9 THEN '1_duoi_0_9'
            WHEN compa_ratio <= 1.1 THEN '2_tu_0_9_den_1_1'
            ELSE '3_tren_1_1' END AS nhom_compa,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 12), 2) AS ty_le_nghi_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY nhom_compa
ORDER BY nhom_compa;

-- [hr-c6-luong-thap-va-nghi-viec.b2] wrong: mau_so_la_so_dong
-- Chia cho số dòng nhân viên – tháng thay cho quân số bình quân: ra tỷ lệ theo tháng, nhỏ hơn 12 lần.
SELECT CASE WHEN compa_ratio < 0.9 THEN '1_duoi_0_9'
            WHEN compa_ratio <= 1.1 THEN '2_tu_0_9_den_1_1'
            ELSE '3_tren_1_1' END AS nhom_compa,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / COUNT(*), 2) AS ty_le_nghi_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY nhom_compa
ORDER BY nhom_compa;

-- [hr-c6-luong-thap-va-nghi-viec.b3] solution
SELECT country,
       ROUND(100 * COUNT(CASE WHEN compa_ratio < 0.9 AND attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) / 12), 2) AS tl_duoi_0_9_pct,
       ROUND(100 * COUNT(CASE WHEN compa_ratio >= 0.9 AND attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(CASE WHEN compa_ratio >= 0.9 THEN 1 END) / 12), 2) AS tl_tu_0_9_pct,
       ROUND(100 * COUNT(CASE WHEN compa_ratio < 0.9 THEN 1 END) / COUNT(*), 2) AS ty_trong_duoi_0_9_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY country
ORDER BY country;
