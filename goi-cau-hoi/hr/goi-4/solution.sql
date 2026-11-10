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

-- [hr-t2-doi-soat-dinh-bien] solution
WITH cuoi_t12 AS (
  SELECT CAST(LEFT(snapshot_month, 4) AS SIGNED) AS nam, position_id,
         SUM(CASE WHEN attrition_this_month = 0 THEN 1 ELSE 0 END) AS so_nv
  FROM employee_monthly_snapshot
  WHERE snapshot_month IN ('2024-12', '2025-12')
  GROUP BY nam, position_id
), trong_nam AS (
  SELECT CAST(LEFT(snapshot_month, 4) AS SIGNED) AS nam, position_id, COUNT(DISTINCT employee_id) AS so_nv
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY nam, position_id
)
SELECT p.plan_period, p.position_id, 'lech_quan_so' AS loai_lech,
       COALESCE(c.so_nv, 0) AS so_nv_danh_sach, p.actual_headcount
FROM position_plan p
LEFT JOIN cuoi_t12 c ON c.nam = p.plan_period AND c.position_id = p.position_id
WHERE COALESCE(c.so_nv, 0) <> p.actual_headcount
UNION ALL
SELECT t.nam, t.position_id, 'khong_co_ke_hoach', t.so_nv, NULL
FROM trong_nam t
WHERE NOT EXISTS (SELECT 1 FROM position_plan p
                  WHERE p.plan_period = t.nam AND p.position_id = t.position_id)
ORDER BY plan_period, position_id;

-- [hr-t2-doi-soat-dinh-bien] wrong: dem_ca_nguoi_nghi_t12
-- Quân số tháng 12 đếm mọi dòng (gồm người nghỉ trong tháng): chiều lệch quân số mất hết, rớt ở public.
WITH cuoi_t12 AS (
  SELECT CAST(LEFT(snapshot_month, 4) AS SIGNED) AS nam, position_id, COUNT(*) AS so_nv
  FROM employee_monthly_snapshot
  WHERE snapshot_month IN ('2024-12', '2025-12')
  GROUP BY nam, position_id
), trong_nam AS (
  SELECT CAST(LEFT(snapshot_month, 4) AS SIGNED) AS nam, position_id, COUNT(DISTINCT employee_id) AS so_nv
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY nam, position_id
)
SELECT p.plan_period, p.position_id, 'lech_quan_so' AS loai_lech,
       COALESCE(c.so_nv, 0) AS so_nv_danh_sach, p.actual_headcount
FROM position_plan p
LEFT JOIN cuoi_t12 c ON c.nam = p.plan_period AND c.position_id = p.position_id
WHERE COALESCE(c.so_nv, 0) <> p.actual_headcount
UNION ALL
SELECT t.nam, t.position_id, 'khong_co_ke_hoach', t.so_nv, NULL
FROM trong_nam t
WHERE NOT EXISTS (SELECT 1 FROM position_plan p
                  WHERE p.plan_period = t.nam AND p.position_id = t.position_id)
ORDER BY plan_period, position_id;

-- [hr-t2-doi-soat-dinh-bien] wrong: chi_mot_chieu
-- Chỉ đối soát từ phía kế hoạch, bỏ vị trí có nhân viên mà không có trong kế hoạch: rớt ở public.
WITH cuoi_t12 AS (
  SELECT CAST(LEFT(snapshot_month, 4) AS SIGNED) AS nam, position_id,
         SUM(CASE WHEN attrition_this_month = 0 THEN 1 ELSE 0 END) AS so_nv
  FROM employee_monthly_snapshot
  WHERE snapshot_month IN ('2024-12', '2025-12')
  GROUP BY nam, position_id
)
SELECT p.plan_period, p.position_id, 'lech_quan_so' AS loai_lech,
       COALESCE(c.so_nv, 0) AS so_nv_danh_sach, p.actual_headcount
FROM position_plan p
LEFT JOIN cuoi_t12 c ON c.nam = p.plan_period AND c.position_id = p.position_id
WHERE COALESCE(c.so_nv, 0) <> p.actual_headcount
ORDER BY plan_period, position_id;

-- [hr-t3-pheu-tuyen-dung] solution
WITH yc AS (
  SELECT requisition_id, offer_accept_date, start_date
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
), pheu AS (
  SELECT 1 AS buoc, 'duyet' AS ten_buoc, COUNT(*) AS so_yeu_cau FROM yc
  UNION ALL
  SELECT 2, 'nhan_loi', COUNT(*) FROM yc WHERE offer_accept_date < '2026-01-01'
  UNION ALL
  SELECT 3, 'di_lam', COUNT(*) FROM yc WHERE start_date < '2026-01-01'
)
SELECT buoc, ten_buoc, so_yeu_cau,
       ROUND(100 * so_yeu_cau / MAX(CASE WHEN buoc = 1 THEN so_yeu_cau END) OVER (), 2) AS ty_le_pct
FROM pheu
ORDER BY buoc;

-- [hr-t3-pheu-tuyen-dung] wrong: khong_chan_ngay_di_lam
-- Đếm mọi yêu cầu có ngày bắt đầu làm việc, kể cả sau tháng 12/2025: rớt ở public.
WITH yc AS (
  SELECT requisition_id, offer_accept_date, start_date
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
), pheu AS (
  SELECT 1 AS buoc, 'duyet' AS ten_buoc, COUNT(*) AS so_yeu_cau FROM yc
  UNION ALL
  SELECT 2, 'nhan_loi', COUNT(offer_accept_date) FROM yc
  UNION ALL
  SELECT 3, 'di_lam', COUNT(start_date) FROM yc
)
SELECT buoc, ten_buoc, so_yeu_cau,
       ROUND(100 * so_yeu_cau / MAX(CASE WHEN buoc = 1 THEN so_yeu_cau END) OVER (), 2) AS ty_le_pct
FROM pheu
ORDER BY buoc;

-- [hr-t3-pheu-tuyen-dung] wrong: quen_can_tren
-- Ngày duyệt không có cận trên: hidden-1 có yêu cầu duyệt ngày 2026-01-05, rớt ở hidden-1.
WITH yc AS (
  SELECT requisition_id, offer_accept_date, start_date
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01'
), pheu AS (
  SELECT 1 AS buoc, 'duyet' AS ten_buoc, COUNT(*) AS so_yeu_cau FROM yc
  UNION ALL
  SELECT 2, 'nhan_loi', COUNT(*) FROM yc WHERE offer_accept_date < '2026-01-01'
  UNION ALL
  SELECT 3, 'di_lam', COUNT(*) FROM yc WHERE start_date < '2026-01-01'
)
SELECT buoc, ten_buoc, so_yeu_cau,
       ROUND(100 * so_yeu_cau / MAX(CASE WHEN buoc = 1 THEN so_yeu_cau END) OVER (), 2) AS ty_le_pct
FROM pheu
ORDER BY buoc;

-- [hr-t4-cay-duoi-mot-giam-doc] solution
WITH RECURSIVE cay AS (
  SELECT employee_id, manager_id, 0 AS tang
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E01688'
  UNION ALL
  SELECT e.employee_id, e.manager_id, c.tang + 1
  FROM cay c
  JOIN employee_monthly_snapshot e
    ON e.manager_id = c.employee_id AND e.snapshot_month = '2025-12'
  WHERE c.tang < 20
)
SELECT tang, employee_id, manager_id
FROM cay
ORDER BY tang, employee_id;

-- [hr-t4-cay-duoi-mot-giam-doc] wrong: noi_nguoc_chieu
-- Nối ngược (đi lên quản lý thay vì đi xuống cấp dưới): chỉ ra người gốc, rớt ở public.
WITH RECURSIVE cay AS (
  SELECT employee_id, manager_id, 0 AS tang
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E01688'
  UNION ALL
  SELECT e.employee_id, e.manager_id, c.tang + 1
  FROM cay c
  JOIN employee_monthly_snapshot e
    ON e.employee_id = c.manager_id AND e.snapshot_month = '2025-12'
  WHERE c.tang < 20
)
SELECT tang, employee_id, manager_id
FROM cay
ORDER BY tang, employee_id;

-- [hr-t4-cay-duoi-mot-giam-doc] wrong: quen_cung_thang
-- Bước đệ quy không giữ tháng 2025-12: kéo cả người đã nghỉ trước đó vào cây, rớt ở public.
WITH RECURSIVE cay AS (
  SELECT employee_id, manager_id, 0 AS tang
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND employee_id = 'E01688'
  UNION
  SELECT e.employee_id, e.manager_id, c.tang + 1
  FROM cay c
  JOIN employee_monthly_snapshot e ON e.manager_id = c.employee_id
  WHERE c.tang < 20
)
SELECT tang, employee_id, manager_id
FROM cay
ORDER BY tang, employee_id;

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
  SELECT department, COUNT(*) AS quan_so, SUM(monthly_salary_usd) AS quy_luong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY department
), tong AS (
  SELECT SUM(quan_so) AS tong_quan_so, SUM(quy_luong) AS tong_quy_luong FROM phong
)
SELECT p.department, p.quan_so, p.quy_luong,
       ROUND(100 * p.quy_luong / t.tong_quy_luong, 2) AS ty_trong_quy_luong_pct,
       ROUND(100 * p.quan_so / t.tong_quan_so, 2) AS ty_trong_quan_so_pct
FROM phong p
CROSS JOIN tong t
ORDER BY p.quy_luong DESC, p.department;

-- [hr-t6-ty-trong-quy-luong] wrong: tong_khong_loc_thang
-- CTE tổng quên lọc tháng nên chia cho quỹ lương của cả 24 tháng: rớt ở public.
WITH phong AS (
  SELECT department, COUNT(*) AS quan_so, SUM(monthly_salary_usd) AS quy_luong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY department
), tong AS (
  SELECT COUNT(*) AS tong_quan_so, SUM(monthly_salary_usd) AS tong_quy_luong
  FROM employee_monthly_snapshot
)
SELECT p.department, p.quan_so, p.quy_luong,
       ROUND(100 * p.quy_luong / t.tong_quy_luong, 2) AS ty_trong_quy_luong_pct,
       ROUND(100 * p.quan_so / t.tong_quan_so, 2) AS ty_trong_quan_so_pct
FROM phong p
CROSS JOIN tong t
ORDER BY p.quy_luong DESC, p.department;

-- [hr-t6-ty-trong-quy-luong] wrong: chi_tinh_nguoi_con_lam
-- Bỏ người nghỉ trong tháng 12 khỏi quỹ lương, trái với định nghĩa ``có tên trong tháng'': rớt ở public.
WITH phong AS (
  SELECT department, COUNT(*) AS quan_so, SUM(monthly_salary_usd) AS quy_luong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12' AND attrition_this_month = 0
  GROUP BY department
), tong AS (
  SELECT SUM(quan_so) AS tong_quan_so, SUM(quy_luong) AS tong_quy_luong FROM phong
)
SELECT p.department, p.quan_so, p.quy_luong,
       ROUND(100 * p.quy_luong / t.tong_quy_luong, 2) AS ty_trong_quy_luong_pct,
       ROUND(100 * p.quan_so / t.tong_quan_so, 2) AS ty_trong_quan_so_pct
FROM phong p
CROSS JOIN tong t
ORDER BY p.quy_luong DESC, p.department;

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

-- [hr-f2-luy-ke-nghi-viec] solution
WITH thang AS (
  SELECT snapshot_month AS thang, SUM(attrition_this_month) AS so_nguoi_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nguoi_nghi,
       SUM(so_nguoi_nghi) OVER (ORDER BY thang) AS luy_ke,
       ROUND(100 * SUM(so_nguoi_nghi) OVER (ORDER BY thang) / SUM(so_nguoi_nghi) OVER (), 2) AS ty_le_luy_ke_pct
FROM thang
ORDER BY thang;

-- [hr-f2-luy-ke-nghi-viec] wrong: quen_can_tren
-- Thiếu cận trên: hidden-1 có thêm tháng '2026-01', ra 13 dòng.
WITH thang AS (
  SELECT snapshot_month AS thang, SUM(attrition_this_month) AS so_nguoi_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01'
  GROUP BY snapshot_month
)
SELECT thang, so_nguoi_nghi,
       SUM(so_nguoi_nghi) OVER (ORDER BY thang) AS luy_ke,
       ROUND(100 * SUM(so_nguoi_nghi) OVER (ORDER BY thang) / SUM(so_nguoi_nghi) OVER (), 2) AS ty_le_luy_ke_pct
FROM thang
ORDER BY thang;

-- [hr-f2-luy-ke-nghi-viec] wrong: dem_dong_thay_nguoi_nghi
-- COUNT(*) đếm mọi dòng của tháng (quân số) thay cho số người nghỉ: rớt ở public.
WITH thang AS (
  SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_nghi
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nguoi_nghi,
       SUM(so_nguoi_nghi) OVER (ORDER BY thang) AS luy_ke,
       ROUND(100 * SUM(so_nguoi_nghi) OVER (ORDER BY thang) / SUM(so_nguoi_nghi) OVER (), 2) AS ty_le_luy_ke_pct
FROM thang
ORDER BY thang;

-- [hr-f3-de-bat-theo-thang] solution
WITH truoc AS (
  SELECT employee_id, snapshot_month, job_level, monthly_salary_usd,
         LAG(job_level) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS bac_truoc,
         LAG(monthly_salary_usd) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-12' AND snapshot_month <= '2025-12'
)
SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_de_bat,
       ROUND(AVG(100 * (monthly_salary_usd - luong_truoc) / luong_truoc), 2) AS tang_luong_bq_pct
FROM truoc
WHERE job_level > bac_truoc AND snapshot_month >= '2025-01'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-f3-de-bat-theo-thang] wrong: lag_khong_chia_nhan_vien
-- LAG không chia theo nhân viên: so bậc với dòng của người khác, rớt ở public.
WITH truoc AS (
  SELECT employee_id, snapshot_month, job_level, monthly_salary_usd,
         LAG(job_level) OVER (ORDER BY employee_id, snapshot_month) AS bac_truoc,
         LAG(monthly_salary_usd) OVER (ORDER BY employee_id, snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-12' AND snapshot_month <= '2025-12'
)
SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_de_bat,
       ROUND(AVG(100 * (monthly_salary_usd - luong_truoc) / luong_truoc), 2) AS tang_luong_bq_pct
FROM truoc
WHERE job_level > bac_truoc AND snapshot_month >= '2025-01'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-f3-de-bat-theo-thang] wrong: loc_truoc_khi_lag
-- Lọc năm 2025 trước khi LAG: tháng 1/2025 không có tháng trước để so, mất dòng tháng 1; rớt ở public.
WITH truoc AS (
  SELECT employee_id, snapshot_month, job_level, monthly_salary_usd,
         LAG(job_level) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS bac_truoc,
         LAG(monthly_salary_usd) OVER (PARTITION BY employee_id ORDER BY snapshot_month) AS luong_truoc
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
)
SELECT snapshot_month AS thang, COUNT(*) AS so_nguoi_de_bat,
       ROUND(AVG(100 * (monthly_salary_usd - luong_truoc) / luong_truoc), 2) AS tang_luong_bq_pct
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

-- [hr-f5-gan-ket-truot-sales-indonesia] solution
WITH thang AS (
  SELECT snapshot_month AS thang, AVG(engagement_score) AS diem
  FROM employee_monthly_snapshot
  WHERE country = 'Indonesia' AND department = 'Sales'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
), truot AS (
  SELECT thang, diem,
         AVG(diem) OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS tb3,
         ROW_NUMBER() OVER (ORDER BY thang) AS stt
  FROM thang
)
SELECT thang, ROUND(diem, 1) AS diem_bq,
       CASE WHEN stt >= 3 THEN ROUND(tb3, 1) END AS diem_truot_3t
FROM truot
ORDER BY thang;

-- [hr-f5-gan-ket-truot-sales-indonesia] wrong: hai_thang_dau_tinh_thieu
-- Để khung mặc định tính cho hai tháng đầu trên 1 và 2 tháng: rớt ở public.
WITH thang AS (
  SELECT snapshot_month AS thang, AVG(engagement_score) AS diem
  FROM employee_monthly_snapshot
  WHERE country = 'Indonesia' AND department = 'Sales'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, ROUND(diem, 1) AS diem_bq,
       ROUND(AVG(diem) OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 1) AS diem_truot_3t
FROM thang
ORDER BY thang;

-- [hr-f5-gan-ket-truot-sales-indonesia] wrong: truot_tren_dong_nhan_vien
-- Trượt trên dòng nhân viên – tháng thay vì trên dòng tháng: rớt ở public.
WITH dong AS (
  SELECT snapshot_month AS thang, engagement_score,
         AVG(engagement_score) OVER (ORDER BY snapshot_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS tb3
  FROM employee_monthly_snapshot
  WHERE country = 'Indonesia' AND department = 'Sales'
    AND snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
)
SELECT thang, ROUND(AVG(engagement_score), 1) AS diem_bq,
       CASE WHEN thang >= '2024-03' THEN ROUND(AVG(tb3), 1) END AS diem_truot_3t
FROM dong
GROUP BY thang
ORDER BY thang;

-- [hr-f6-yeu-cau-dat-nhat-moi-phong] solution
WITH yc AS (
  SELECT department, requisition_id, recruiting_cost_usd,
         AVG(recruiting_cost_usd) OVER (PARTITION BY department) AS chi_phi_bq,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY recruiting_cost_usd DESC, requisition_id) AS hang
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
)
SELECT department, requisition_id, recruiting_cost_usd,
       ROUND(chi_phi_bq, 0) AS chi_phi_bq_phong,
       ROUND(recruiting_cost_usd / chi_phi_bq, 2) AS so_lan_binh_quan
FROM yc
WHERE hang = 1
ORDER BY recruiting_cost_usd DESC, department;

-- [hr-f6-yeu-cau-dat-nhat-moi-phong] wrong: quen_can_tren
-- Ngày duyệt thiếu cận trên: hidden-1 có yêu cầu duyệt 2026-01-05 làm đổi chi phí bình quân phòng Operations.
WITH yc AS (
  SELECT department, requisition_id, recruiting_cost_usd,
         AVG(recruiting_cost_usd) OVER (PARTITION BY department) AS chi_phi_bq,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY recruiting_cost_usd DESC, requisition_id) AS hang
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01'
)
SELECT department, requisition_id, recruiting_cost_usd,
       ROUND(chi_phi_bq, 0) AS chi_phi_bq_phong,
       ROUND(recruiting_cost_usd / chi_phi_bq, 2) AS so_lan_binh_quan
FROM yc
WHERE hang = 1
ORDER BY recruiting_cost_usd DESC, department;

-- [hr-f6-yeu-cau-dat-nhat-moi-phong] wrong: binh_quan_toan_cong_ty
-- AVG() OVER () không chia nhóm: so với bình quân toàn công ty, rớt ở public.
WITH yc AS (
  SELECT department, requisition_id, recruiting_cost_usd,
         AVG(recruiting_cost_usd) OVER () AS chi_phi_bq,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY recruiting_cost_usd DESC, requisition_id) AS hang
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
)
SELECT department, requisition_id, recruiting_cost_usd,
       ROUND(chi_phi_bq, 0) AS chi_phi_bq_phong,
       ROUND(recruiting_cost_usd / chi_phi_bq, 2) AS so_lan_binh_quan
FROM yc
WHERE hang = 1
ORDER BY recruiting_cost_usd DESC, department;

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

-- [hr-f9-luy-ke-khong-reset] starter
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (ORDER BY thang) AS luy_ke_trong_nam
FROM thang
ORDER BY thang;

-- [hr-f9-luy-ke-khong-reset] solution
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (PARTITION BY LEFT(thang, 4) ORDER BY thang) AS luy_ke_trong_nam
FROM thang
ORDER BY thang;

-- [hr-f9-luy-ke-khong-reset] wrong: chia_nhom_theo_thang
-- PARTITION BY theo tháng: mỗi nhóm một dòng nên luỹ kế chỉ bằng số của tháng đó, rớt ở public.
WITH thang AS (
  SELECT snapshot_month AS thang,
         COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (PARTITION BY thang ORDER BY thang) AS luy_ke_trong_nam
FROM thang
ORDER BY thang;

-- [hr-f9-luy-ke-khong-reset] wrong: dem_moi_loai_nghi
-- Sửa đúng PARTITION BY nhưng đếm cả nghỉ hưu và chấm dứt hợp đồng: rớt ở public.
WITH thang AS (
  SELECT snapshot_month AS thang, SUM(attrition_this_month) AS so_nghi_tu_nguyen
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  GROUP BY snapshot_month
)
SELECT thang, so_nghi_tu_nguyen,
       SUM(so_nghi_tu_nguyen) OVER (PARTITION BY LEFT(thang, 4) ORDER BY thang) AS luy_ke_trong_nam
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
