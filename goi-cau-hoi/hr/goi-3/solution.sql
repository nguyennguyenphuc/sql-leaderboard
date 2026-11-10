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

-- [hr-j2-vi-tri-ngoai-ke-hoach] solution
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       COUNT(*) AS so_dong,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       y.so_dong_ca_nam
FROM employee_monthly_snapshot s
JOIN (SELECT LEFT(snapshot_month, 4) AS nam, COUNT(*) AS so_dong_ca_nam
      FROM employee_monthly_snapshot
      GROUP BY LEFT(snapshot_month, 4)) y ON y.nam = LEFT(s.snapshot_month, 4)
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), y.so_dong_ca_nam
ORDER BY nam, s.position_id;

-- [hr-j2-vi-tri-ngoai-ke-hoach] wrong: noi_thieu_nam
-- Chỉ nối theo vị trí: vị trí có trong kế hoạch của năm khác vẫn khớp, chỉ còn vị trí vắng ở cả hai năm.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       COUNT(*) AS so_dong,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       y.so_dong_ca_nam
FROM employee_monthly_snapshot s
JOIN (SELECT LEFT(snapshot_month, 4) AS nam, COUNT(*) AS so_dong_ca_nam
      FROM employee_monthly_snapshot
      GROUP BY LEFT(snapshot_month, 4)) y ON y.nam = LEFT(s.snapshot_month, 4)
LEFT JOIN position_plan p ON p.position_id = s.position_id
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), y.so_dong_ca_nam
ORDER BY nam, s.position_id;

-- [hr-j2-vi-tri-ngoai-ke-hoach] wrong: inner_join
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       COUNT(*) AS so_dong,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       y.so_dong_ca_nam
FROM employee_monthly_snapshot s
JOIN (SELECT LEFT(snapshot_month, 4) AS nam, COUNT(*) AS so_dong_ca_nam
      FROM employee_monthly_snapshot
      GROUP BY LEFT(snapshot_month, 4)) y ON y.nam = LEFT(s.snapshot_month, 4)
JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), y.so_dong_ca_nam
ORDER BY nam, s.position_id;

-- [hr-j2-vi-tri-ngoai-ke-hoach] wrong: thieu_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 không có kế hoạch năm 2026 nên thành một vị trí ngoài kế hoạch.
SELECT s.position_id,
       LEFT(s.snapshot_month, 4) AS nam,
       COUNT(*) AS so_dong,
       COUNT(DISTINCT s.employee_id) AS so_nhan_vien,
       y.so_dong_ca_nam
FROM employee_monthly_snapshot s
JOIN (SELECT LEFT(snapshot_month, 4) AS nam, COUNT(*) AS so_dong_ca_nam
      FROM employee_monthly_snapshot
      GROUP BY LEFT(snapshot_month, 4)) y ON y.nam = LEFT(s.snapshot_month, 4)
LEFT JOIN position_plan p
  ON p.position_id = s.position_id
 AND p.plan_period = LEFT(s.snapshot_month, 4)
WHERE s.snapshot_month >= '2024-01'
  AND p.position_id IS NULL
GROUP BY s.position_id, LEFT(s.snapshot_month, 4), y.so_dong_ca_nam
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

-- [hr-j4-tin-tuong-quan-ly-theo-phong] solution
SELECT s.department,
       COUNT(*) AS so_phieu,
       ROUND(AVG(k.manager_trust_score), 2) AS tin_tuong_bq
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month = '2025-12'
WHERE k.survey_quarter = '2025-Q4'
GROUP BY s.department
ORDER BY tin_tuong_bq, s.department;

-- [hr-j4-tin-tuong-quan-ly-theo-phong] wrong: noi_ca_quy
-- Nối với cả ba tháng của quý: mỗi phiếu lặp lại theo số tháng có tên.
SELECT s.department,
       COUNT(*) AS so_phieu,
       ROUND(AVG(k.manager_trust_score), 2) AS tin_tuong_bq
FROM engagement_survey k
JOIN employee_monthly_snapshot s
  ON s.employee_id = k.employee_id
 AND s.snapshot_month >= '2025-10' AND s.snapshot_month <= '2025-12'
WHERE k.survey_quarter = '2025-Q4'
GROUP BY s.department
ORDER BY tin_tuong_bq, s.department;

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

-- [hr-j8-nghi-co-tuyen-thay-the] solution
SELECT COUNT(*) AS so_nguoi_nghi,
       COUNT(r.requisition_id) AS so_co_yeu_cau,
       ROUND(100 * COUNT(r.requisition_id) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
LEFT JOIN recruiting_pipeline r
  ON r.vacated_employee_id = s.employee_id
 AND r.attrition_month = s.snapshot_month
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_this_month = 1;

-- [hr-j8-nghi-co-tuyen-thay-the] starter
SELECT COUNT(*) AS so_nguoi_nghi,
       COUNT(r.requisition_id) AS so_co_yeu_cau,
       ROUND(100 * COUNT(r.requisition_id) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
JOIN recruiting_pipeline r
  ON r.vacated_employee_id = s.employee_id
 AND r.attrition_month = s.snapshot_month
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_this_month = 1;

-- [hr-j8-nghi-co-tuyen-thay-the] wrong: loc_bang_phai_o_where
-- LEFT JOIN nhưng lọc cột của bảng tuyển dụng ở WHERE: dòng không khớp có NULL nên bị loại, quay lại như INNER JOIN.
SELECT COUNT(*) AS so_nguoi_nghi,
       COUNT(r.requisition_id) AS so_co_yeu_cau,
       ROUND(100 * COUNT(r.requisition_id) / COUNT(*), 2) AS ty_le_pct
FROM employee_monthly_snapshot s
LEFT JOIN recruiting_pipeline r
  ON r.vacated_employee_id = s.employee_id
 AND r.attrition_month = s.snapshot_month
WHERE s.snapshot_month >= '2024-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_this_month = 1
  AND r.requisition_type = 'Backfill';

-- [hr-j9-trang-thai-quan-ly] solution
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien
FROM employee_monthly_snapshot e
LEFT JOIN employee_monthly_snapshot m
  ON m.employee_id = e.manager_id
 AND m.snapshot_month = e.snapshot_month
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- [hr-j9-trang-thai-quan-ly] starter
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien
FROM employee_monthly_snapshot e
JOIN employee_monthly_snapshot m
  ON m.employee_id = e.manager_id
 AND m.snapshot_month = e.snapshot_month
WHERE e.snapshot_month = '2025-12'
GROUP BY tinh_trang
ORDER BY tinh_trang;

-- [hr-j9-trang-thai-quan-ly] wrong: left_join_thieu_cung_thang
-- LEFT JOIN đúng nhưng bỏ điều kiện cùng tháng: quản lý đã nghỉ vẫn khớp với các tháng cũ, mỗi nhân viên lặp nhiều dòng.
SELECT CASE WHEN e.manager_id IS NULL THEN 'khong_ghi_quan_ly'
            WHEN m.employee_id IS NULL THEN 'quan_ly_khong_con_ten'
            ELSE 'quan_ly_con_ten' END AS tinh_trang,
       COUNT(*) AS so_nhan_vien
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
SELECT s.country, s.department, s.employee_id, s.engagement_score
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.department, s.engagement_score) IN
      (SELECT s2.country, s2.department, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       WHERE s2.snapshot_month = '2025-12'
       GROUP BY s2.country, s2.department)
ORDER BY s.country, s.department, s.employee_id;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] wrong: max_ca_nuoc
-- Truy vấn con chỉ gom theo nước: mỗi nước chỉ còn phòng có người đạt mức cao nhất của cả nước.
SELECT s.country, s.department, s.employee_id, s.engagement_score
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.engagement_score) IN
      (SELECT s2.country, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       WHERE s2.snapshot_month = '2025-12'
       GROUP BY s2.country)
ORDER BY s.country, s.department, s.employee_id;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] wrong: max_ca_24_thang
-- Truy vấn con thiếu điều kiện tháng: so với điểm cao nhất của mỗi nhóm trong cả 24 tháng.
SELECT s.country, s.department, s.employee_id, s.engagement_score
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.department, s.engagement_score) IN
      (SELECT s2.country, s2.department, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       GROUP BY s2.country, s2.department)
ORDER BY s.country, s.department, s.employee_id;

-- [hr-q3-gan-ket-cao-nhat-moi-phong] wrong: moi_nhom_mot_nguoi
-- Gom theo nhóm rồi lấy mã nhỏ nhất: nhóm có hai người cùng điểm cao nhất chỉ còn một người.
SELECT s.country, s.department, MIN(s.employee_id) AS employee_id, MAX(s.engagement_score) AS engagement_score
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND (s.country, s.department, s.engagement_score) IN
      (SELECT s2.country, s2.department, MAX(s2.engagement_score)
       FROM employee_monthly_snapshot s2
       WHERE s2.snapshot_month = '2025-12'
       GROUP BY s2.country, s2.department)
GROUP BY s.country, s.department
ORDER BY s.country, s.department, employee_id;

-- [hr-q4-nghi-du-dinh-o-lai-cao] solution
SELECT s.employee_id, s.snapshot_month AS thang_nghi,
       k.survey_quarter, k.intent_to_stay
FROM employee_monthly_snapshot s
JOIN engagement_survey k ON k.employee_id = s.employee_id
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
  AND k.survey_quarter = (SELECT MAX(k2.survey_quarter)
                          FROM engagement_survey k2
                          WHERE k2.employee_id = s.employee_id
                            AND k2.survey_quarter <= CONCAT(LEFT(s.snapshot_month, 4), '-Q',
                                                            QUARTER(CONCAT(s.snapshot_month, '-01'))))
  AND k.intent_to_stay >= 4
ORDER BY thang_nghi, s.employee_id;

-- [hr-q4-nghi-du-dinh-o-lai-cao] wrong: quy_moi_nhat_ca_bang
-- Lấy quý lớn nhất của cả bảng khảo sát: chỉ còn người nghỉ trong quý 4.
SELECT s.employee_id, s.snapshot_month AS thang_nghi,
       k.survey_quarter, k.intent_to_stay
FROM employee_monthly_snapshot s
JOIN engagement_survey k ON k.employee_id = s.employee_id
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
  AND k.survey_quarter = (SELECT MAX(k2.survey_quarter) FROM engagement_survey k2)
  AND k.intent_to_stay >= 4
ORDER BY thang_nghi, s.employee_id;

-- [hr-q4-nghi-du-dinh-o-lai-cao] wrong: so_quy_voi_thang
-- So chuỗi quý '2025-Q2' với chuỗi tháng '2025-05': chữ Q đứng sau chữ số nên mọi quý cùng năm đều bị loại.
SELECT s.employee_id, s.snapshot_month AS thang_nghi,
       k.survey_quarter, k.intent_to_stay
FROM employee_monthly_snapshot s
JOIN engagement_survey k ON k.employee_id = s.employee_id
WHERE s.snapshot_month >= '2025-01' AND s.snapshot_month <= '2025-12'
  AND s.attrition_type = 'Voluntary'
  AND k.survey_quarter = (SELECT MAX(k2.survey_quarter)
                          FROM engagement_survey k2
                          WHERE k2.employee_id = s.employee_id
                            AND k2.survey_quarter <= s.snapshot_month)
  AND k.intent_to_stay >= 4
ORDER BY thang_nghi, s.employee_id;

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

-- [hr-q6-yeu-cau-tuyen-lau] solution
SELECT COUNT(*) AS so_yeu_cau_lau,
       ROUND((SELECT AVG(time_to_fill_days) FROM recruiting_pipeline
              WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  AND time_to_fill_days > (SELECT AVG(time_to_fill_days)
                           FROM recruiting_pipeline
                           WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01');

-- [hr-q6-yeu-cau-tuyen-lau] wrong: bq_ca_hai_nam
-- Mức bình quân lấy trên mọi yêu cầu của cả năm 2024 và 2025.
SELECT COUNT(*) AS so_yeu_cau_lau,
       ROUND((SELECT AVG(time_to_fill_days) FROM recruiting_pipeline), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  AND time_to_fill_days > (SELECT AVG(time_to_fill_days) FROM recruiting_pipeline);

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

-- [hr-q8-tren-bq-bac-sai-thang] solution
SELECT s.employee_id, s.department, s.job_level, s.monthly_salary_usd
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND s.country = 'Singapore'
  AND s.monthly_salary_usd > (SELECT AVG(s2.monthly_salary_usd)
                              FROM employee_monthly_snapshot s2
                              WHERE s2.snapshot_month = '2025-12'
                                AND s2.country = s.country
                                AND s2.department = s.department
                                AND s2.job_level = s.job_level)
ORDER BY s.department, s.job_level, s.employee_id;

-- [hr-q8-tren-bq-bac-sai-thang] starter
SELECT s.employee_id, s.department, s.job_level, s.monthly_salary_usd
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND s.country = 'Singapore'
  AND s.monthly_salary_usd > (SELECT AVG(s2.monthly_salary_usd)
                              FROM employee_monthly_snapshot s2
                              WHERE s2.country = s.country
                                AND s2.department = s.department
                                AND s2.job_level = s.job_level)
ORDER BY s.department, s.job_level, s.employee_id;

-- [hr-q8-tren-bq-bac-sai-thang] wrong: thieu_tuong_quan_phong
-- Thêm điều kiện tháng nhưng bỏ điều kiện cùng phòng ban: so với bình quân bậc của cả nước.
SELECT s.employee_id, s.department, s.job_level, s.monthly_salary_usd
FROM employee_monthly_snapshot s
WHERE s.snapshot_month = '2025-12'
  AND s.country = 'Singapore'
  AND s.monthly_salary_usd > (SELECT AVG(s2.monthly_salary_usd)
                              FROM employee_monthly_snapshot s2
                              WHERE s2.snapshot_month = '2025-12'
                                AND s2.country = s.country
                                AND s2.job_level = s.job_level)
ORDER BY s.department, s.job_level, s.employee_id;

-- [hr-q9-ly-do-pho-bien-moi-nuoc] solution
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

-- [hr-q9-ly-do-pho-bien-moi-nuoc] starter
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

-- [hr-q9-ly-do-pho-bien-moi-nuoc] wrong: tinh_ca_nghi_huu
-- Tương quan đúng nhưng đếm mọi loại nghỉ việc: lý do nghỉ hưu bị tính thêm vào danh sách.
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
