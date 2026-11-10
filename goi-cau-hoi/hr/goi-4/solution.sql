-- solution.sql: gói 4 bộ HR Analytics (hr) · Module 7 CTE & Set Operations, Module 8 Window Functions, case c7, c8.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chạy trên hr (public) và hr_hidden_1 (hidden-1).

-- ===================================================================== MODULE 7 · CTE & SET OPERATIONS

-- [hr-t1-nghi-viec-yoy-theo-phong] solution
WITH thang AS (
  SELECT department, LEFT(snapshot_month, 4) AS nam,
         COUNT(*) AS so_dong, SUM(attrition_this_month) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY department, LEFT(snapshot_month, 4)
), ty_le AS (
  SELECT department,
         MAX(CASE WHEN nam = '2024' THEN 100 * so_nghi / (so_dong / 12) END) AS tl_2024,
         MAX(CASE WHEN nam = '2025' THEN 100 * so_nghi / (so_dong / 12) END) AS tl_2025
  FROM thang
  GROUP BY department
)
SELECT department,
       ROUND(tl_2024, 2) AS ty_le_2024_pct,
       ROUND(tl_2025, 2) AS ty_le_2025_pct,
       ROUND(tl_2025 - tl_2024, 2) AS chenh_lech_diem
FROM ty_le
ORDER BY chenh_lech_diem DESC, department;

-- [hr-t1-nghi-viec-yoy-theo-phong] wrong: chenh_lech_tuong_doi
-- Lấy mức thay đổi tương đối (%) thay cho hiệu hai tỷ lệ (điểm phần trăm): rớt ở public.
WITH thang AS (
  SELECT department, LEFT(snapshot_month, 4) AS nam,
         COUNT(*) AS so_dong, SUM(attrition_this_month) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY department, LEFT(snapshot_month, 4)
), ty_le AS (
  SELECT department,
         MAX(CASE WHEN nam = '2024' THEN 100 * so_nghi / (so_dong / 12) END) AS tl_2024,
         MAX(CASE WHEN nam = '2025' THEN 100 * so_nghi / (so_dong / 12) END) AS tl_2025
  FROM thang
  GROUP BY department
)
SELECT department,
       ROUND(tl_2024, 2) AS ty_le_2024_pct,
       ROUND(tl_2025, 2) AS ty_le_2025_pct,
       ROUND(100 * (tl_2025 - tl_2024) / tl_2024, 2) AS chenh_lech_diem
FROM ty_le
ORDER BY chenh_lech_diem DESC, department;

-- [hr-t1-nghi-viec-yoy-theo-phong] wrong: mau_so_la_tong_dong
-- Chia cho tổng số dòng của năm (ra tỷ lệ bình quân tháng) thay cho quân số bình quân: rớt ở public.
WITH n24 AS (
  SELECT department, COUNT(*) AS so_dong, SUM(attrition_this_month) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2024-12'
  GROUP BY department
), n25 AS (
  SELECT department, COUNT(*) AS so_dong, SUM(attrition_this_month) AS so_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY department
)
SELECT a.department,
       ROUND(100 * a.so_nghi / a.so_dong, 2) AS ty_le_2024_pct,
       ROUND(100 * b.so_nghi / b.so_dong, 2) AS ty_le_2025_pct,
       ROUND(100 * b.so_nghi / b.so_dong - 100 * a.so_nghi / a.so_dong, 2) AS chenh_lech_diem
FROM n24 a
JOIN n25 b ON b.department = a.department
ORDER BY chenh_lech_diem DESC, a.department;

-- [hr-t2-vi-tri-moi-ke-hoach-2025] solution
SELECT position_id, country, department
FROM position_plan
WHERE plan_period = 2025
EXCEPT
SELECT position_id, country, department
FROM position_plan
WHERE plan_period = 2024
ORDER BY position_id;

-- [hr-t2-vi-tri-moi-ke-hoach-2025] wrong: dao_hai_ve
-- Đảo hai vế: ra các vị trí có ở kế hoạch 2024 mà vắng ở 2025, rớt cả hai biến thể.
SELECT position_id, country, department
FROM position_plan
WHERE plan_period = 2024
EXCEPT
SELECT position_id, country, department
FROM position_plan
WHERE plan_period = 2025
ORDER BY position_id;

-- [hr-t2-vi-tri-moi-ke-hoach-2025] wrong: so_ca_dinh_bien
-- Đưa cả planned_headcount vào hai vế: vị trí nào đổi định biên cũng bị coi là mới, rớt cả hai biến thể.
SELECT position_id, country, department, planned_headcount
FROM position_plan
WHERE plan_period = 2025
EXCEPT
SELECT position_id, country, department, planned_headcount
FROM position_plan
WHERE plan_period = 2024
ORDER BY position_id;

-- [hr-t3-pheu-tuyen-dung] solution
WITH yc AS (
  SELECT requisition_id, offer_accept_date, start_date
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
)
SELECT 1 AS buoc, 'duyet' AS ten_buoc, COUNT(*) AS so_yeu_cau FROM yc
UNION ALL
SELECT 2, 'nhan_loi', COUNT(*) FROM yc WHERE offer_accept_date < '2026-01-01'
UNION ALL
SELECT 3, 'di_lam', COUNT(*) FROM yc WHERE start_date < '2026-01-01'
ORDER BY buoc;

-- [hr-t3-pheu-tuyen-dung] wrong: khong_chan_ngay_di_lam
-- Đếm mọi yêu cầu có ngày bắt đầu làm việc, kể cả sau tháng 12/2025: rớt ở public.
WITH yc AS (
  SELECT requisition_id, offer_accept_date, start_date
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
)
SELECT 1 AS buoc, 'duyet' AS ten_buoc, COUNT(*) AS so_yeu_cau FROM yc
UNION ALL
SELECT 2, 'nhan_loi', COUNT(offer_accept_date) FROM yc
UNION ALL
SELECT 3, 'di_lam', COUNT(start_date) FROM yc
ORDER BY buoc;

-- [hr-t3-pheu-tuyen-dung] wrong: quen_can_tren
-- Ngày duyệt không có cận trên: hidden-1 có yêu cầu duyệt ngày 2026-01-05, rớt ở hidden-1.
WITH yc AS (
  SELECT requisition_id, offer_accept_date, start_date
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01'
)
SELECT 1 AS buoc, 'duyet' AS ten_buoc, COUNT(*) AS so_yeu_cau FROM yc
UNION ALL
SELECT 2, 'nhan_loi', COUNT(*) FROM yc WHERE offer_accept_date < '2026-01-01'
UNION ALL
SELECT 3, 'di_lam', COUNT(*) FROM yc WHERE start_date < '2026-01-01'
ORDER BY buoc;

-- [hr-t4-so-cap-duoi-truc-tiep] solution
WITH cap_duoi AS (
  SELECT manager_id, COUNT(*) AS so_cap_duoi
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND manager_id IS NOT NULL
  GROUP BY manager_id
)
SELECT so_cap_duoi, COUNT(*) AS so_quan_ly
FROM cap_duoi
GROUP BY so_cap_duoi
ORDER BY so_cap_duoi;

-- [hr-t4-so-cap-duoi-truc-tiep] wrong: giu_quan_ly_trong
-- Không bỏ dòng manager_id trống: nhóm NULL bị tính như một quản lý có nhiều cấp dưới, rớt cả hai biến thể.
WITH cap_duoi AS (
  SELECT manager_id, COUNT(*) AS so_cap_duoi
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY manager_id
)
SELECT so_cap_duoi, COUNT(*) AS so_quan_ly
FROM cap_duoi
GROUP BY so_cap_duoi
ORDER BY so_cap_duoi;

-- [hr-t4-so-cap-duoi-truc-tiep] wrong: quen_loc_thang
-- Không lọc tháng 12/2025: đếm cấp dưới qua cả 24 tháng, rớt cả hai biến thể.
WITH cap_duoi AS (
  SELECT manager_id, COUNT(DISTINCT employee_id) AS so_cap_duoi
  FROM employee_monthly_snapshot
  WHERE manager_id IS NOT NULL
  GROUP BY manager_id
)
SELECT so_cap_duoi, COUNT(*) AS so_quan_ly
FROM cap_duoi
GROUP BY so_cap_duoi
ORDER BY so_cap_duoi;

-- [hr-t5-chuoi-quan-ly-lap] starter
WITH RECURSIVE chuoi AS (
  SELECT 1 AS buoc, employee_id, manager_id
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E00041'
  UNION ALL
  SELECT c.buoc + 1, e.employee_id, e.manager_id
  FROM chuoi c
  JOIN employee_monthly_snapshot e
    ON e.employee_id = c.manager_id AND e.snapshot_month = '2025-12'
  WHERE c.buoc < 10
)
SELECT buoc, employee_id, manager_id
FROM chuoi
ORDER BY buoc;

-- [hr-t5-chuoi-quan-ly-lap] solution
WITH RECURSIVE chuoi AS (
  SELECT 1 AS buoc, employee_id, manager_id, CAST(employee_id AS CHAR(500)) AS da_qua
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E00041'
  UNION ALL
  SELECT c.buoc + 1, e.employee_id, e.manager_id, CONCAT(c.da_qua, ',', e.employee_id)
  FROM chuoi c
  JOIN employee_monthly_snapshot e
    ON e.employee_id = c.manager_id AND e.snapshot_month = '2025-12'
  WHERE c.buoc < 10 AND FIND_IN_SET(e.employee_id, c.da_qua) = 0
)
SELECT buoc, employee_id, manager_id
FROM chuoi
ORDER BY buoc;

-- [hr-t5-chuoi-quan-ly-lap] wrong: chi_dung_khi_ve_nguoi_dau
-- Chỉ dừng khi quay lại người xuất phát; vòng lặp nằm phía trên nên vẫn chạy tới 10 bước, rớt ở public.
WITH RECURSIVE chuoi AS (
  SELECT 1 AS buoc, employee_id, manager_id
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E00041'
  UNION ALL
  SELECT c.buoc + 1, e.employee_id, e.manager_id
  FROM chuoi c
  JOIN employee_monthly_snapshot e
    ON e.employee_id = c.manager_id AND e.snapshot_month = '2025-12'
  WHERE c.buoc < 10 AND e.employee_id <> 'E00041'
)
SELECT buoc, employee_id, manager_id
FROM chuoi
ORDER BY buoc;

-- [hr-t5-chuoi-quan-ly-lap] wrong: dung_som_mot_buoc
-- Dừng khi quản lý của dòng hiện tại đã đi qua, nên mất người cuối cùng của chuỗi: rớt ở public.
WITH RECURSIVE chuoi AS (
  SELECT 1 AS buoc, employee_id, manager_id, CAST(employee_id AS CHAR(500)) AS da_qua
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E00041'
  UNION ALL
  SELECT c.buoc + 1, e.employee_id, e.manager_id, CONCAT(c.da_qua, ',', e.employee_id)
  FROM chuoi c
  JOIN employee_monthly_snapshot e
    ON e.employee_id = c.manager_id AND e.snapshot_month = '2025-12'
  WHERE c.buoc < 10 AND FIND_IN_SET(e.employee_id, c.da_qua) = 0
    AND FIND_IN_SET(e.manager_id, CONCAT(c.da_qua, ',', e.employee_id)) = 0
)
SELECT buoc, employee_id, manager_id
FROM chuoi
ORDER BY buoc;

-- [hr-t6-ty-trong-quy-luong] solution
WITH phong AS (
  SELECT department, SUM(monthly_salary_usd) AS quy_luong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY department
)
SELECT department, quy_luong,
       ROUND(100 * quy_luong / (SELECT SUM(quy_luong) FROM phong), 2) AS ty_trong_pct
FROM phong
ORDER BY quy_luong DESC, department;

-- [hr-t6-ty-trong-quy-luong] wrong: tong_khong_loc_thang
-- Mẫu số lấy tổng tiền lương của cả bảng (24 tháng) thay cho tháng 12/2025: rớt ở public.
WITH phong AS (
  SELECT department, SUM(monthly_salary_usd) AS quy_luong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY department
)
SELECT department, quy_luong,
       ROUND(100 * quy_luong / (SELECT SUM(monthly_salary_usd) FROM employee_monthly_snapshot), 2) AS ty_trong_pct
FROM phong
ORDER BY quy_luong DESC, department;

-- [hr-t6-ty-trong-quy-luong] wrong: chi_tinh_nguoi_con_lam
-- Bỏ người nghỉ trong tháng 12 khỏi quỹ lương, trái với định nghĩa ``có tên trong tháng'': rớt ở public.
WITH phong AS (
  SELECT department, SUM(monthly_salary_usd) AS quy_luong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND attrition_this_month = 0
  GROUP BY department
)
SELECT department, quy_luong,
       ROUND(100 * quy_luong / (SELECT SUM(quy_luong) FROM phong), 2) AS ty_trong_pct
FROM phong
ORDER BY quy_luong DESC, department;

-- [hr-t7-cohort-tuyen-moi] solution
WITH vao AS (
  SELECT employee_id, MIN(snapshot_month) AS thang_vao
  FROM employee_monthly_snapshot
  WHERE tenure_months = 0 AND snapshot_month >= '2024-02' AND snapshot_month <= '2025-06'
  GROUP BY employee_id
), theo_doi AS (
  SELECT v.employee_id,
         CONCAT(LEFT(v.thang_vao, 4), '-Q', QUARTER(CONCAT(v.thang_vao, '-01'))) AS quy_vao_lam,
         MAX(CASE WHEN PERIOD_DIFF(REPLACE(s.snapshot_month, '-', ''), REPLACE(v.thang_vao, '-', '')) = 3
                   AND s.attrition_this_month = 0 THEN 1 ELSE 0 END) AS con_3t,
         MAX(CASE WHEN PERIOD_DIFF(REPLACE(s.snapshot_month, '-', ''), REPLACE(v.thang_vao, '-', '')) = 6
                   AND s.attrition_this_month = 0 THEN 1 ELSE 0 END) AS con_6t
  FROM vao v
  JOIN employee_monthly_snapshot s ON s.employee_id = v.employee_id
  GROUP BY v.employee_id, quy_vao_lam
)
SELECT quy_vao_lam, COUNT(*) AS so_nguoi,
       ROUND(100 * AVG(con_3t), 2) AS giu_chan_3t_pct,
       ROUND(100 * AVG(con_6t), 2) AS giu_chan_6t_pct
FROM theo_doi
GROUP BY quy_vao_lam
ORDER BY quy_vao_lam;

-- [hr-t7-cohort-tuyen-moi] wrong: co_dong_la_con_lam
-- Coi người còn có dòng ở tháng thứ 6 là còn làm, kể cả người nghỉ đúng tháng đó: rớt ở public.
WITH vao AS (
  SELECT employee_id, MIN(snapshot_month) AS thang_vao
  FROM employee_monthly_snapshot
  WHERE tenure_months = 0 AND snapshot_month >= '2024-02' AND snapshot_month <= '2025-06'
  GROUP BY employee_id
), theo_doi AS (
  SELECT v.employee_id,
         CONCAT(LEFT(v.thang_vao, 4), '-Q', QUARTER(CONCAT(v.thang_vao, '-01'))) AS quy_vao_lam,
         MAX(CASE WHEN PERIOD_DIFF(REPLACE(s.snapshot_month, '-', ''), REPLACE(v.thang_vao, '-', '')) = 3 THEN 1 ELSE 0 END) AS con_3t,
         MAX(CASE WHEN PERIOD_DIFF(REPLACE(s.snapshot_month, '-', ''), REPLACE(v.thang_vao, '-', '')) = 6 THEN 1 ELSE 0 END) AS con_6t
  FROM vao v
  JOIN employee_monthly_snapshot s ON s.employee_id = v.employee_id
  GROUP BY v.employee_id, quy_vao_lam
)
SELECT quy_vao_lam, COUNT(*) AS so_nguoi,
       ROUND(100 * AVG(con_3t), 2) AS giu_chan_3t_pct,
       ROUND(100 * AVG(con_6t), 2) AS giu_chan_6t_pct
FROM theo_doi
GROUP BY quy_vao_lam
ORDER BY quy_vao_lam;

-- [hr-t7-cohort-tuyen-moi] wrong: lay_ca_thang_2024_01
-- Tính cả người có thâm niên 0 ở tháng 2024-01 (đầu cửa sổ dữ liệu) và cohort chưa đủ 6 tháng: rớt ở public.
WITH vao AS (
  SELECT employee_id, MIN(snapshot_month) AS thang_vao
  FROM employee_monthly_snapshot
  WHERE tenure_months = 0 AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY employee_id
), theo_doi AS (
  SELECT v.employee_id,
         CONCAT(LEFT(v.thang_vao, 4), '-Q', QUARTER(CONCAT(v.thang_vao, '-01'))) AS quy_vao_lam,
         MAX(CASE WHEN PERIOD_DIFF(REPLACE(s.snapshot_month, '-', ''), REPLACE(v.thang_vao, '-', '')) = 3
                   AND s.attrition_this_month = 0 THEN 1 ELSE 0 END) AS con_3t,
         MAX(CASE WHEN PERIOD_DIFF(REPLACE(s.snapshot_month, '-', ''), REPLACE(v.thang_vao, '-', '')) = 6
                   AND s.attrition_this_month = 0 THEN 1 ELSE 0 END) AS con_6t
  FROM vao v
  JOIN employee_monthly_snapshot s ON s.employee_id = v.employee_id
  GROUP BY v.employee_id, quy_vao_lam
)
SELECT quy_vao_lam, COUNT(*) AS so_nguoi,
       ROUND(100 * AVG(con_3t), 2) AS giu_chan_3t_pct,
       ROUND(100 * AVG(con_6t), 2) AS giu_chan_6t_pct
FROM theo_doi
GROUP BY quy_vao_lam
ORDER BY quy_vao_lam;

-- [hr-t8-union-mat-dong] starter
WITH hai_nam AS (
  SELECT recruitment_source, COUNT(*) AS so_yeu_cau
  FROM recruiting_pipeline
  WHERE approval_date >= '2024-01-01' AND approval_date < '2025-01-01'
  GROUP BY recruitment_source
  UNION
  SELECT recruitment_source, COUNT(*)
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  GROUP BY recruitment_source
)
SELECT recruitment_source, SUM(so_yeu_cau) AS tong_yeu_cau
FROM hai_nam
GROUP BY recruitment_source
ORDER BY tong_yeu_cau DESC, recruitment_source;

-- [hr-t8-union-mat-dong] solution
WITH hai_nam AS (
  SELECT recruitment_source, COUNT(*) AS so_yeu_cau
  FROM recruiting_pipeline
  WHERE approval_date >= '2024-01-01' AND approval_date < '2025-01-01'
  GROUP BY recruitment_source
  UNION ALL
  SELECT recruitment_source, COUNT(*)
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  GROUP BY recruitment_source
)
SELECT recruitment_source, SUM(so_yeu_cau) AS tong_yeu_cau
FROM hai_nam
GROUP BY recruitment_source
ORDER BY tong_yeu_cau DESC, recruitment_source;

-- [hr-t8-union-mat-dong] wrong: union_all_bo_gom_ngoai
-- Đổi sang UNION ALL nhưng bỏ phép cộng ở truy vấn ngoài: mỗi nguồn ra hai dòng, rớt ở public.
WITH hai_nam AS (
  SELECT recruitment_source, COUNT(*) AS so_yeu_cau
  FROM recruiting_pipeline
  WHERE approval_date >= '2024-01-01' AND approval_date < '2025-01-01'
  GROUP BY recruitment_source
  UNION ALL
  SELECT recruitment_source, COUNT(*)
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  GROUP BY recruitment_source
)
SELECT recruitment_source, so_yeu_cau AS tong_yeu_cau
FROM hai_nam
ORDER BY tong_yeu_cau DESC, recruitment_source;

-- [hr-t9-doi-soat-except] starter
SELECT employee_id, snapshot_month AS thang_nghi
FROM employee_monthly_snapshot
WHERE attrition_type IN ('Voluntary', 'Involuntary')
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
EXCEPT
SELECT vacated_employee_id, DATE_FORMAT(start_date, '%Y-%m')
FROM recruiting_pipeline
WHERE start_date <= '2025-12-31'
ORDER BY thang_nghi, employee_id;

-- [hr-t9-doi-soat-except] wrong: tru_moi_yeu_cau
-- Bỏ điều kiện người thay đã đi làm: trừ cả yêu cầu mà người thay chưa bắt đầu, danh sách gần như rỗng; rớt ở public.
SELECT employee_id, snapshot_month AS thang_nghi
FROM employee_monthly_snapshot
WHERE attrition_type IN ('Voluntary', 'Involuntary')
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
EXCEPT
SELECT vacated_employee_id, attrition_month
FROM recruiting_pipeline
ORDER BY thang_nghi, employee_id;

-- [hr-t9-doi-soat-except] solution
SELECT employee_id, snapshot_month AS thang_nghi
FROM employee_monthly_snapshot
WHERE attrition_type IN ('Voluntary', 'Involuntary')
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
EXCEPT
SELECT vacated_employee_id, attrition_month
FROM recruiting_pipeline
WHERE start_date <= '2025-12-31'
ORDER BY thang_nghi, employee_id;

-- [hr-t9-doi-soat-except] wrong: not_in_gap_null
-- Thay EXCEPT bằng NOT IN: yêu cầu tuyển mới có vacated_employee_id trống (NULL) nên NOT IN không trả dòng nào, rớt ở public.
SELECT employee_id, snapshot_month AS thang_nghi
FROM employee_monthly_snapshot
WHERE attrition_type IN ('Voluntary', 'Involuntary')
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  AND employee_id NOT IN (SELECT vacated_employee_id FROM recruiting_pipeline
                          WHERE start_date <= '2025-12-31')
ORDER BY thang_nghi, employee_id;

-- ===================================================================== MODULE 8 · WINDOW FUNCTIONS

-- [hr-f1-top3-lam-them-moi-nuoc] solution
WITH tong AS (
  SELECT country, employee_id, SUM(overtime_hours) AS tong_gio
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY country, employee_id
), xep AS (
  SELECT country, employee_id, tong_gio,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY tong_gio DESC, employee_id) AS hang
  FROM tong
)
SELECT country, hang, employee_id, tong_gio
FROM xep
WHERE hang <= 3
ORDER BY country, hang;

-- [hr-f1-top3-lam-them-moi-nuoc] wrong: dung_rank
-- RANK() cho hai người bằng giờ cùng hạng 3 (Indonesia ở public, Malaysia ở hidden-1): ra 4 dòng.
WITH tong AS (
  SELECT country, employee_id, SUM(overtime_hours) AS tong_gio
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY country, employee_id
), xep AS (
  SELECT country, employee_id, tong_gio,
         RANK() OVER (PARTITION BY country ORDER BY tong_gio DESC) AS hang
  FROM tong
)
SELECT country, hang, employee_id, tong_gio
FROM xep
WHERE hang <= 3
ORDER BY country, hang, employee_id;

-- [hr-f1-top3-lam-them-moi-nuoc] wrong: thieu_partition_by
-- Xếp hạng trên toàn công ty: chỉ còn 3 dòng, đều ở Malaysia; rớt ở public.
WITH tong AS (
  SELECT country, employee_id, SUM(overtime_hours) AS tong_gio
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY country, employee_id
), xep AS (
  SELECT country, employee_id, tong_gio,
         ROW_NUMBER() OVER (ORDER BY tong_gio DESC, employee_id) AS hang
  FROM tong
)
SELECT country, hang, employee_id, tong_gio
FROM xep
WHERE hang <= 3
ORDER BY country, hang;

-- [hr-f2-luy-ke-chi-phi-tuyen-dung] solution
WITH thang AS (
  SELECT DATE_FORMAT(approval_date, '%Y-%m') AS thang, SUM(recruiting_cost_usd) AS chi_phi
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  GROUP BY DATE_FORMAT(approval_date, '%Y-%m')
)
SELECT thang, chi_phi,
       SUM(chi_phi) OVER (ORDER BY thang) AS chi_phi_luy_ke
FROM thang
ORDER BY thang;

-- [hr-f2-luy-ke-chi-phi-tuyen-dung] wrong: quen_can_tren
-- Thiếu cận trên ngày duyệt: hidden-1 có yêu cầu duyệt 2026-01-05, ra 13 dòng.
WITH thang AS (
  SELECT DATE_FORMAT(approval_date, '%Y-%m') AS thang, SUM(recruiting_cost_usd) AS chi_phi
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01'
  GROUP BY DATE_FORMAT(approval_date, '%Y-%m')
)
SELECT thang, chi_phi,
       SUM(chi_phi) OVER (ORDER BY thang) AS chi_phi_luy_ke
FROM thang
ORDER BY thang;

-- [hr-f2-luy-ke-chi-phi-tuyen-dung] wrong: thieu_order_by_trong_over
-- Bỏ ORDER BY trong OVER: cửa sổ là cả năm nên mọi tháng ra tổng năm, rớt ở public.
WITH thang AS (
  SELECT DATE_FORMAT(approval_date, '%Y-%m') AS thang, SUM(recruiting_cost_usd) AS chi_phi
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  GROUP BY DATE_FORMAT(approval_date, '%Y-%m')
)
SELECT thang, chi_phi,
       SUM(chi_phi) OVER () AS chi_phi_luy_ke
FROM thang
ORDER BY thang;

-- [hr-f3-de-bat-theo-thang] solution
WITH truoc AS (
  SELECT employee_id, snapshot_month, job_level,
         LAG(job_level) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS bac_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-12' AND snapshot_month <= '2025-12'
)
SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_de_bat
FROM truoc
WHERE job_level > bac_truoc AND snapshot_month >= '2025-01'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-f3-de-bat-theo-thang] wrong: lag_khong_chia_nhan_vien
-- LAG không chia theo nhân viên: dòng đầu của mỗi người so bậc với dòng của người khác, rớt ở public.
WITH truoc AS (
  SELECT employee_id, snapshot_month, job_level,
         LAG(job_level) OVER (ORDER BY employee_id, snapshot_month) AS bac_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-12' AND snapshot_month <= '2025-12'
)
SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_de_bat
FROM truoc
WHERE job_level > bac_truoc AND snapshot_month >= '2025-01'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-f3-de-bat-theo-thang] wrong: loc_truoc_khi_lag
-- Lọc năm 2025 trước khi LAG: tháng 1/2025 không có tháng trước để so, mất dòng tháng 1; rớt ở public.
WITH truoc AS (
  SELECT employee_id, snapshot_month, job_level,
         LAG(job_level) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS bac_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
)
SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_de_bat
FROM truoc
WHERE job_level > bac_truoc
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-f4-gan-ket-giam-truoc-nghi] solution
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), co_giam AS (
  SELECT s.employee_id, s.snapshot_month, n.thang_nghi,
         CASE WHEN s.engagement_score < LAG(s.engagement_score)
                   OVER (PARTITION BY s.employee_id ORDER BY s.snapshot_month)
              THEN 1 ELSE 0 END AS giam
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
), dao AS (
  SELECT employee_id, snapshot_month, thang_nghi, giam,
         SUM(1 - giam) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS ma_dao
  FROM co_giam
), chuoi AS (
  SELECT employee_id, snapshot_month, thang_nghi,
         ROW_NUMBER() OVER (PARTITION BY employee_id, ma_dao ORDER BY snapshot_month) - 1 AS so_thang_giam
  FROM dao
)
SELECT employee_id, thang_nghi, so_thang_giam
FROM chuoi
WHERE snapshot_month = thang_nghi AND so_thang_giam >= 3
ORDER BY so_thang_giam DESC, employee_id;

-- [hr-f4-gan-ket-giam-truoc-nghi] wrong: dem_khong_lien_tiep
-- Đếm số tháng giảm trong 6 tháng tính tới tháng nghỉ, không cần liền nhau: rớt ở public.
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), co_giam AS (
  SELECT s.employee_id, s.snapshot_month, n.thang_nghi,
         CASE WHEN s.engagement_score < LAG(s.engagement_score)
                   OVER (PARTITION BY s.employee_id ORDER BY s.snapshot_month)
              THEN 1 ELSE 0 END AS giam
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
), dem AS (
  SELECT employee_id, snapshot_month, thang_nghi,
         SUM(giam) OVER (PARTITION BY employee_id ORDER BY snapshot_month
                         ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS so_thang_giam
  FROM co_giam
)
SELECT employee_id, thang_nghi, so_thang_giam
FROM dem
WHERE snapshot_month = thang_nghi AND so_thang_giam >= 3
ORDER BY so_thang_giam DESC, employee_id;

-- [hr-f4-gan-ket-giam-truoc-nghi] wrong: bo_thang_trong_diem
-- Bỏ các tháng điểm gắn kết trống trước khi so: tháng trống không còn cắt chuỗi, rớt ở public.
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), co_giam AS (
  SELECT s.employee_id, s.snapshot_month, n.thang_nghi,
         CASE WHEN s.engagement_score < LAG(s.engagement_score)
                   OVER (PARTITION BY s.employee_id ORDER BY s.snapshot_month)
              THEN 1 ELSE 0 END AS giam
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
  WHERE s.engagement_score IS NOT NULL
), dao AS (
  SELECT employee_id, snapshot_month, thang_nghi, giam,
         SUM(1 - giam) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS ma_dao
  FROM co_giam
), chuoi AS (
  SELECT employee_id, snapshot_month, thang_nghi,
         ROW_NUMBER() OVER (PARTITION BY employee_id, ma_dao ORDER BY snapshot_month) - 1 AS so_thang_giam
  FROM dao
)
SELECT employee_id, thang_nghi, so_thang_giam
FROM chuoi
WHERE snapshot_month = thang_nghi AND so_thang_giam >= 3
ORDER BY so_thang_giam DESC, employee_id;

-- [hr-f5-hang-nghi-viec-sales-theo-chuc-danh] solution
WITH nhom AS (
  SELECT country, job_family,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi
  FROM employee_monthly_snapshot
  WHERE department = 'Sales'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY country, job_family
)
SELECT country, job_family, so_nguoi_nghi,
       RANK() OVER (PARTITION BY country ORDER BY so_nguoi_nghi DESC) AS hang
FROM nhom
ORDER BY country, hang, job_family;

-- [hr-f5-hang-nghi-viec-sales-theo-chuc-danh] wrong: dung_row_number
-- ROW_NUMBER() chia hạng khác nhau cho hai chức danh bằng số người nghỉ (hoà hạng 2 ở Malaysia, Thailand): rớt cả hai biến thể.
WITH nhom AS (
  SELECT country, job_family,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi
  FROM employee_monthly_snapshot
  WHERE department = 'Sales'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY country, job_family
)
SELECT country, job_family, so_nguoi_nghi,
       ROW_NUMBER() OVER (PARTITION BY country ORDER BY so_nguoi_nghi DESC, job_family) AS hang
FROM nhom
ORDER BY country, hang, job_family;

-- [hr-f5-hang-nghi-viec-sales-theo-chuc-danh] wrong: loc_truoc_khi_gom
-- Lọc người nghỉ tự nguyện ở WHERE trước khi gom: cặp không có ai nghỉ biến mất (Singapore), rớt cả hai biến thể.
WITH nhom AS (
  SELECT country, job_family, COUNT(*) AS so_nguoi_nghi
  FROM employee_monthly_snapshot
  WHERE department = 'Sales' AND attrition_type = 'Voluntary'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY country, job_family
)
SELECT country, job_family, so_nguoi_nghi,
       RANK() OVER (PARTITION BY country ORDER BY so_nguoi_nghi DESC) AS hang
FROM nhom
ORDER BY country, hang, job_family;

-- [hr-f6-thu-tu-yeu-cau-singapore] solution
SELECT department, requisition_id, approval_date,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY approval_date, requisition_id) AS thu_tu
FROM recruiting_pipeline
WHERE country = 'Singapore'
  AND approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
ORDER BY department, thu_tu;

-- [hr-f6-thu-tu-yeu-cau-singapore] wrong: thieu_partition_by
-- Không chia nhóm theo phòng ban: đánh số chung cả văn phòng, rớt cả hai biến thể.
SELECT department, requisition_id, approval_date,
       ROW_NUMBER() OVER (ORDER BY approval_date, requisition_id) AS thu_tu
FROM recruiting_pipeline
WHERE country = 'Singapore'
  AND approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
ORDER BY department, thu_tu;

-- [hr-f6-thu-tu-yeu-cau-singapore] wrong: sap_theo_ma_yeu_cau
-- Đánh số theo mã yêu cầu thay cho ngày duyệt (mã không cấp theo ngày duyệt): rớt cả hai biến thể.
SELECT department, requisition_id, approval_date,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY requisition_id) AS thu_tu
FROM recruiting_pipeline
WHERE country = 'Singapore'
  AND approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
ORDER BY department, thu_tu;

-- [hr-f7-top3-lam-them-rank] starter
WITH xep AS (
  SELECT department, employee_id, overtime_hours,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY overtime_hours DESC, employee_id) AS hang
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
)
SELECT department, hang, employee_id, overtime_hours AS tong_gio
FROM xep
WHERE hang <= 3
ORDER BY department, hang;

-- [hr-f7-top3-lam-them-rank] solution
WITH tong AS (
  SELECT department, employee_id, SUM(overtime_hours) AS tong_gio
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY department, employee_id
), xep AS (
  SELECT department, employee_id, tong_gio,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY tong_gio DESC, employee_id) AS hang
  FROM tong
)
SELECT department, hang, employee_id, tong_gio
FROM xep
WHERE hang <= 3
ORDER BY department, hang;

-- [hr-f7-top3-lam-them-rank] wrong: tong_bang_ham_cua_so
-- Tính tổng năm bằng SUM() OVER (PARTITION BY employee_id) nhưng vẫn xếp hạng trên dòng tháng: một người chiếm cả ba hạng, rớt ở public.
WITH dong AS (
  SELECT department, employee_id,
         SUM(overtime_hours) OVER (PARTITION BY employee_id) AS tong_gio
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), xep AS (
  SELECT department, employee_id, tong_gio,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY tong_gio DESC, employee_id) AS hang
  FROM dong
)
SELECT department, hang, employee_id, tong_gio
FROM xep
WHERE hang <= 3
ORDER BY department, hang;

-- [hr-f8-tang-luong-lag-sai] starter
WITH luong AS (
  SELECT employee_id, snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (ORDER BY employee_id, snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering'
    AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
)
SELECT employee_id, snapshot_month AS thang, luong_truoc, monthly_salary_usd AS luong_moi,
       ROUND(100 * (monthly_salary_usd - luong_truoc) / luong_truoc, 2) AS tang_pct
FROM luong
WHERE 100 * (monthly_salary_usd - luong_truoc) / luong_truoc >= 8
ORDER BY thang, employee_id;

-- [hr-f8-tang-luong-lag-sai] solution
WITH luong AS (
  SELECT employee_id, snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering'
    AND snapshot_month >= '2024-12' AND snapshot_month <= '2025-12'
)
SELECT employee_id, snapshot_month AS thang, luong_truoc, monthly_salary_usd AS luong_moi,
       ROUND(100 * (monthly_salary_usd - luong_truoc) / luong_truoc, 2) AS tang_pct
FROM luong
WHERE snapshot_month >= '2025-01'
  AND 100 * (monthly_salary_usd - luong_truoc) / luong_truoc >= 8
ORDER BY thang, employee_id;

-- [hr-f8-tang-luong-lag-sai] wrong: chi_them_partition_by
-- Chỉ sửa PARTITION BY, vẫn lọc 2025 trước khi LAG: mất các lần tăng của tháng 1/2025, rớt ở public.
WITH luong AS (
  SELECT employee_id, snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering'
    AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
)
SELECT employee_id, snapshot_month AS thang, luong_truoc, monthly_salary_usd AS luong_moi,
       ROUND(100 * (monthly_salary_usd - luong_truoc) / luong_truoc, 2) AS tang_pct
FROM luong
WHERE 100 * (monthly_salary_usd - luong_truoc) / luong_truoc >= 8
ORDER BY thang, employee_id;

-- [hr-f8-tang-luong-lag-sai] wrong: chi_mo_rong_thang
-- Chỉ mở rộng cửa sổ tới 2024-12, vẫn thiếu PARTITION BY: dòng đầu mỗi người so với người khác, rớt ở public.
WITH luong AS (
  SELECT employee_id, snapshot_month, monthly_salary_usd,
         LAG(monthly_salary_usd) OVER (ORDER BY employee_id, snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering'
    AND snapshot_month >= '2024-12' AND snapshot_month <= '2025-12'
)
SELECT employee_id, snapshot_month AS thang, luong_truoc, monthly_salary_usd AS luong_moi,
       ROUND(100 * (monthly_salary_usd - luong_truoc) / luong_truoc, 2) AS tang_pct
FROM luong
WHERE snapshot_month >= '2025-01'
  AND 100 * (monthly_salary_usd - luong_truoc) / luong_truoc >= 8
ORDER BY thang, employee_id;

-- [hr-f9-luy-ke-chay-nguoc] starter
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (ORDER BY thang DESC) AS luy_ke
FROM thang
ORDER BY thang;

-- [hr-f9-luy-ke-chay-nguoc] solution
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (ORDER BY thang) AS luy_ke
FROM thang
ORDER BY thang;

-- [hr-f9-luy-ke-chay-nguoc] wrong: bo_order_by_trong_over
-- Bỏ hẳn ORDER BY trong OVER: cửa sổ là cả năm nên mọi tháng ra tổng năm, rớt cả hai biến thể.
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER () AS luy_ke
FROM thang
ORDER BY thang;

-- [hr-f9-luy-ke-chay-nguoc] wrong: sap_theo_so_nguoi_nghi
-- Sắp trong OVER theo số người nghỉ thay cho tháng: cộng dồn sai thứ tự tháng, rớt cả hai biến thể.
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (ORDER BY so_nghi_tu_nguyen) AS luy_ke
FROM thang
ORDER BY thang;

-- ===================================================================== CASE STUDY

-- [hr-c7-gan-ket-bao-truoc.b1] solution
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), o_lai AS (
  SELECT employee_id
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND attrition_this_month = 0
), diem AS (
  SELECT 'nghi_tu_nguyen' AS nhom, s.employee_id, s.engagement_score
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
  WHERE PERIOD_DIFF(REPLACE(n.thang_nghi, '-', ''), REPLACE(s.snapshot_month, '-', '')) BETWEEN 1 AND 6
  UNION ALL
  SELECT 'o_lai', s.employee_id, s.engagement_score
  FROM employee_monthly_snapshot s
  JOIN o_lai o ON o.employee_id = s.employee_id
  WHERE s.snapshot_month >= '2025-06' AND s.snapshot_month <= '2025-11'
)
SELECT nhom, COUNT(DISTINCT employee_id) AS so_nguoi, ROUND(AVG(engagement_score), 1) AS diem_gan_ket_bq
FROM diem
GROUP BY nhom
ORDER BY nhom;

-- [hr-c7-gan-ket-bao-truoc.b1] wrong: gom_ca_thang_nghi
-- Tính cả tháng nghỉ việc vào 6 tháng trước khi nghỉ: rớt ở public.
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), o_lai AS (
  SELECT employee_id
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND attrition_this_month = 0
), diem AS (
  SELECT 'nghi_tu_nguyen' AS nhom, s.employee_id, s.engagement_score
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
  WHERE PERIOD_DIFF(REPLACE(n.thang_nghi, '-', ''), REPLACE(s.snapshot_month, '-', '')) BETWEEN 0 AND 6
  UNION ALL
  SELECT 'o_lai', s.employee_id, s.engagement_score
  FROM employee_monthly_snapshot s
  JOIN o_lai o ON o.employee_id = s.employee_id
  WHERE s.snapshot_month >= '2025-06' AND s.snapshot_month <= '2025-11'
)
SELECT nhom, COUNT(DISTINCT employee_id) AS so_nguoi, ROUND(AVG(engagement_score), 1) AS diem_gan_ket_bq
FROM diem
GROUP BY nhom
ORDER BY nhom;

-- [hr-c7-gan-ket-bao-truoc.b2] solution
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), cach AS (
  SELECT PERIOD_DIFF(REPLACE(n.thang_nghi, '-', ''), REPLACE(s.snapshot_month, '-', '')) AS thang_truoc_nghi,
         s.employee_id, s.engagement_score
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
)
SELECT thang_truoc_nghi, COUNT(*) AS so_nguoi, ROUND(AVG(engagement_score), 1) AS diem_gan_ket_bq
FROM cach
WHERE thang_truoc_nghi BETWEEN 1 AND 6
GROUP BY thang_truoc_nghi
ORDER BY thang_truoc_nghi DESC;

-- [hr-c7-gan-ket-bao-truoc.b2] wrong: tinh_ca_nghi_huu
-- Lấy mọi người nghỉ (attrition_this_month = 1), gồm cả nghỉ hưu và chấm dứt hợp đồng: rớt ở public.
WITH nghi AS (
  SELECT employee_id, snapshot_month AS thang_nghi
  FROM employee_monthly_snapshot
  WHERE attrition_this_month = 1 AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
), cach AS (
  SELECT PERIOD_DIFF(REPLACE(n.thang_nghi, '-', ''), REPLACE(s.snapshot_month, '-', '')) AS thang_truoc_nghi,
         s.employee_id, s.engagement_score
  FROM employee_monthly_snapshot s
  JOIN nghi n ON n.employee_id = s.employee_id
)
SELECT thang_truoc_nghi, COUNT(*) AS so_nguoi, ROUND(AVG(engagement_score), 1) AS diem_gan_ket_bq
FROM cach
WHERE thang_truoc_nghi BETWEEN 1 AND 6
GROUP BY thang_truoc_nghi
ORDER BY thang_truoc_nghi DESC;

-- [hr-c7-gan-ket-bao-truoc.b3] solution
WITH nhom AS (
  SELECT employee_id, 'nghi_tu_nguyen_sau_q2' AS nhom
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-07' AND snapshot_month <= '2025-12'
  UNION ALL
  SELECT employee_id, 'o_lai'
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND attrition_this_month = 0
)
SELECT n.nhom, COUNT(*) AS so_nguoi,
       ROUND(AVG(k.intent_to_stay), 2) AS y_dinh_o_lai_bq,
       ROUND(AVG(k.engagement_score), 1) AS gan_ket_khao_sat_bq
FROM nhom n
JOIN engagement_survey k ON k.employee_id = n.employee_id AND k.survey_quarter = '2025-Q2'
GROUP BY n.nhom
ORDER BY n.nhom;

-- [hr-c7-gan-ket-bao-truoc.b3] wrong: noi_theo_nam
-- Nối khảo sát theo năm 2025 thay vì đúng quý 2025-Q2: mỗi người nhân 4 dòng, rớt ở public.
WITH nhom AS (
  SELECT employee_id, 'nghi_tu_nguyen_sau_q2' AS nhom
  FROM employee_monthly_snapshot
  WHERE attrition_type = 'Voluntary' AND snapshot_month >= '2025-07' AND snapshot_month <= '2025-12'
  UNION ALL
  SELECT employee_id, 'o_lai'
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND attrition_this_month = 0
)
SELECT n.nhom, COUNT(*) AS so_nguoi,
       ROUND(AVG(k.intent_to_stay), 2) AS y_dinh_o_lai_bq,
       ROUND(AVG(k.engagement_score), 1) AS gan_ket_khao_sat_bq
FROM nhom n
JOIN engagement_survey k ON k.employee_id = n.employee_id
 AND LEFT(k.survey_quarter, 4) = '2025' AND k.survey_quarter <= '2025-Q4'
GROUP BY n.nhom
ORDER BY n.nhom;

-- [hr-c8-diem-nong-vn-engineering.b1] solution
WITH nhom AS (
  SELECT country, department,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi,
         COUNT(*) / 24 AS quan_so_bq
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY country, department
), xep AS (
  SELECT country, department, so_nguoi_nghi, quan_so_bq,
         ROW_NUMBER() OVER (ORDER BY so_nguoi_nghi DESC, country, department) AS hang
  FROM nhom
)
SELECT country, department, so_nguoi_nghi,
       ROUND(100 * so_nguoi_nghi / quan_so_bq, 2) AS ty_le_nghi_pct
FROM xep
WHERE hang <= 3
ORDER BY hang;

-- [hr-c8-diem-nong-vn-engineering.b1] wrong: dung_rank
-- RANK() cho Indonesia·Sales và Philippines·Customer Support cùng hạng 3: ra 4 dòng ở public.
WITH nhom AS (
  SELECT country, department,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi,
         COUNT(*) / 24 AS quan_so_bq
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY country, department
), xep AS (
  SELECT country, department, so_nguoi_nghi, quan_so_bq,
         RANK() OVER (ORDER BY so_nguoi_nghi DESC) AS hang
  FROM nhom
)
SELECT country, department, so_nguoi_nghi,
       ROUND(100 * so_nguoi_nghi / quan_so_bq, 2) AS ty_le_nghi_pct
FROM xep
WHERE hang <= 3
ORDER BY hang, country, department;

-- [hr-c8-diem-nong-vn-engineering.b2] solution
SELECT department,
       ROUND(AVG(overtime_hours), 1) AS gio_lam_them_bq,
       ROUND(100 * AVG(CASE WHEN overtime_hours >= 40 THEN 1 ELSE 0 END), 2) AS ty_le_tu_40_gio_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam' AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY department
ORDER BY AVG(overtime_hours) DESC, department;
-- [hr-c8-diem-nong-vn-engineering.b3] solution
WITH nghi AS (
  SELECT 'nghi_tu_nguyen' AS nhom, employee_id, compa_ratio
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering' AND attrition_type = 'Voluntary'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
), o_lai AS (
  SELECT 'o_lai' AS nhom, employee_id, compa_ratio
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering'
    AND snapshot_month = '2025-12' AND attrition_this_month = 0
), gop AS (
  SELECT * FROM nghi
  UNION ALL
  SELECT * FROM o_lai
)
SELECT nhom, COUNT(*) AS so_nguoi,
       ROUND(AVG(compa_ratio), 3) AS compa_ratio_bq,
       ROUND(100 * AVG(CASE WHEN compa_ratio < 0.9 THEN 1 ELSE 0 END), 2) AS ty_le_duoi_0_9_pct
FROM gop
GROUP BY nhom
ORDER BY nhom;

-- [hr-c8-diem-nong-vn-engineering.b3] wrong: o_lai_gom_moi_thang
-- Nhóm ở lại lấy mọi dòng còn làm của 24 tháng thay cho tháng 12/2025: rớt ở public.
WITH nghi AS (
  SELECT 'nghi_tu_nguyen' AS nhom, employee_id, compa_ratio
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering' AND attrition_type = 'Voluntary'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
), o_lai AS (
  SELECT 'o_lai' AS nhom, employee_id, compa_ratio
  FROM employee_monthly_snapshot
  WHERE country = 'Vietnam' AND department = 'Engineering'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12' AND attrition_this_month = 0
), gop AS (
  SELECT * FROM nghi
  UNION ALL
  SELECT * FROM o_lai
)
SELECT nhom, COUNT(*) AS so_nguoi,
       ROUND(AVG(compa_ratio), 3) AS compa_ratio_bq,
       ROUND(100 * AVG(CASE WHEN compa_ratio < 0.9 THEN 1 ELSE 0 END), 2) AS ty_le_duoi_0_9_pct
FROM gop
GROUP BY nhom
ORDER BY nhom;

-- [hr-c8-diem-nong-vn-engineering.b4] solution
SELECT department,
       ROUND(AVG(manager_effectiveness_score), 1) AS diem_nang_luc_ql_bq,
       ROUND(100 * COUNT(CASE WHEN manager_effectiveness_score < 55 THEN 1 END)
                 / COUNT(manager_effectiveness_score), 2) AS ty_le_duoi_55_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam' AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY department
ORDER BY diem_nang_luc_ql_bq, department;

-- [hr-c8-diem-nong-vn-engineering.b4] wrong: mau_so_gom_o_trong
-- Mẫu số COUNT(*) gồm cả dòng điểm trống: tỷ lệ dưới 55 bị kéo xuống, rớt ở public.
SELECT department,
       ROUND(AVG(manager_effectiveness_score), 1) AS diem_nang_luc_ql_bq,
       ROUND(100 * COUNT(CASE WHEN manager_effectiveness_score < 55 THEN 1 END) / COUNT(*), 2) AS ty_le_duoi_55_pct
FROM employee_monthly_snapshot
WHERE country = 'Vietnam' AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY department
ORDER BY diem_nang_luc_ql_bq, department;
