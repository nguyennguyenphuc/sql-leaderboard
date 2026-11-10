-- solution.sql: gói 4 bộ Marketing (mkt) · Module 7 CTE & Set Operations, Module 8 Window Functions, case c7, c8.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chạy trên mkt (public) và mkt_hidden_1 (hidden-1).
-- hidden-1: bỏ chiến dịch có số đuôi tận cùng 7; thêm NY-CMP-56555 ngày 2025-07-01 (bắt thiếu cận trên);
-- NY-CMP-53612 = NY-CMP-56543 = 4.119.654 ở hạng 3 doanh thu Nykaa (bắt RANK và quy tắc hoà).

-- ===================================================================== MODULE 7 · CTE & SET OPERATIONS

-- [mkt-t1-roas-nua-dau-2025] solution
WITH tong AS (
  SELECT brand_id,
         SUM(revenue) AS doanh_thu,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-07-01'
  GROUP BY brand_id
)
SELECT b.brand_name,
       t.doanh_thu,
       ROUND(t.chi_phi, 2) AS chi_phi,
       ROUND((t.doanh_thu - t.chi_phi) / t.chi_phi, 4) AS roi,
       ROUND(t.doanh_thu / t.chi_phi, 4) AS roas
FROM tong t
JOIN brands b ON b.brand_id = t.brand_id
ORDER BY t.brand_id;

-- [mkt-t1-roas-nua-dau-2025] wrong: thieu_can_tren
-- Chỉ có cận dưới: hidden-1 có chiến dịch Nykaa ngày 2025-07-01 nên doanh thu, chi phí của Nykaa lệch (rớt ở hidden-1).
WITH tong AS (
  SELECT brand_id,
         SUM(revenue) AS doanh_thu,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2025-01-01'
  GROUP BY brand_id
)
SELECT b.brand_name,
       t.doanh_thu,
       ROUND(t.chi_phi, 2) AS chi_phi,
       ROUND((t.doanh_thu - t.chi_phi) / t.chi_phi, 4) AS roi,
       ROUND(t.doanh_thu / t.chi_phi, 4) AS roas
FROM tong t
JOIN brands b ON b.brand_id = t.brand_id
ORDER BY t.brand_id;

-- [mkt-t1-roas-nua-dau-2025] wrong: binh_quan_cot_roi
-- Lấy bình quân cột roi làm ROI của thương hiệu và cộng 1 làm ROAS: bình quân giản đơn cao hơn tỷ lệ của tổng (rớt ở public).
WITH tong AS (
  SELECT brand_id,
         SUM(revenue) AS doanh_thu,
         SUM(acquisition_cost * conversions) AS chi_phi,
         AVG(roi) AS roi_bq
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-07-01'
  GROUP BY brand_id
)
SELECT b.brand_name,
       t.doanh_thu,
       ROUND(t.chi_phi, 2) AS chi_phi,
       ROUND(t.roi_bq, 4) AS roi,
       ROUND(t.roi_bq + 1, 4) AS roas
FROM tong t
JOIN brands b ON b.brand_id = t.brand_id
ORDER BY t.brand_id;

-- [mkt-t2-pheu-dang-dai] solution
WITH tong AS (
  SELECT brand_id,
         SUM(impressions) AS hien_thi,
         SUM(clicks) AS nhap,
         SUM(leads) AS khtn,
         SUM(conversions) AS chuyen_doi
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
  GROUP BY brand_id
), dang_dai AS (
  SELECT brand_id, 1 AS thu_tu, 'nhan_biet' AS tang, hien_thi AS so_luong, NULL AS ty_le_di_tiep_pct FROM tong
  UNION ALL
  SELECT brand_id, 2, 'quan_tam', nhap, ROUND(nhap * 100 / hien_thi, 2) FROM tong
  UNION ALL
  SELECT brand_id, 3, 'can_nhac', khtn, ROUND(khtn * 100 / nhap, 2) FROM tong
  UNION ALL
  SELECT brand_id, 4, 'chuyen_doi', chuyen_doi, ROUND(chuyen_doi * 100 / khtn, 2) FROM tong
)
SELECT brand_id, thu_tu, tang, so_luong, ty_le_di_tiep_pct
FROM dang_dai
ORDER BY brand_id, thu_tu;

-- [mkt-t2-pheu-dang-dai] wrong: sap_theo_ten_tang
-- Sắp theo tên tầng thay vì thứ tự tầng: 'can_nhac' đứng trước 'nhan_biet' (rớt ở public).
WITH tong AS (
  SELECT brand_id,
         SUM(impressions) AS hien_thi,
         SUM(clicks) AS nhap,
         SUM(leads) AS khtn,
         SUM(conversions) AS chuyen_doi
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
  GROUP BY brand_id
), dang_dai AS (
  SELECT brand_id, 1 AS thu_tu, 'nhan_biet' AS tang, hien_thi AS so_luong, NULL AS ty_le_di_tiep_pct FROM tong
  UNION ALL
  SELECT brand_id, 2, 'quan_tam', nhap, ROUND(nhap * 100 / hien_thi, 2) FROM tong
  UNION ALL
  SELECT brand_id, 3, 'can_nhac', khtn, ROUND(khtn * 100 / nhap, 2) FROM tong
  UNION ALL
  SELECT brand_id, 4, 'chuyen_doi', chuyen_doi, ROUND(chuyen_doi * 100 / khtn, 2) FROM tong
)
SELECT brand_id, thu_tu, tang, so_luong, ty_le_di_tiep_pct
FROM dang_dai
ORDER BY brand_id, tang;

-- [mkt-t2-pheu-dang-dai] wrong: chia_cho_luot_hien_thi
-- Mọi tầng chia cho lượt hiển thị thay vì tầng ngay trước (rớt ở public).
WITH tong AS (
  SELECT brand_id,
         SUM(impressions) AS hien_thi,
         SUM(clicks) AS nhap,
         SUM(leads) AS khtn,
         SUM(conversions) AS chuyen_doi
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
  GROUP BY brand_id
), dang_dai AS (
  SELECT brand_id, 1 AS thu_tu, 'nhan_biet' AS tang, hien_thi AS so_luong, NULL AS ty_le_di_tiep_pct FROM tong
  UNION ALL
  SELECT brand_id, 2, 'quan_tam', nhap, ROUND(nhap * 100 / hien_thi, 2) FROM tong
  UNION ALL
  SELECT brand_id, 3, 'can_nhac', khtn, ROUND(khtn * 100 / hien_thi, 2) FROM tong
  UNION ALL
  SELECT brand_id, 4, 'chuyen_doi', chuyen_doi, ROUND(chuyen_doi * 100 / hien_thi, 2) FROM tong
)
SELECT brand_id, thu_tu, tang, so_luong, ty_le_di_tiep_pct
FROM dang_dai
ORDER BY brand_id, thu_tu;

-- [mkt-t3-nhom-khach-hai-vai] solution
WITH hai_vai AS (
  SELECT campaign_id, target_audience_id AS audience_id, 'doi_tuong' AS vai
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
  UNION ALL
  SELECT campaign_id, segment_id, 'phan_khuc'
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT a.audience_id,
       a.audience_name,
       COUNT(CASE WHEN h.vai = 'doi_tuong' THEN 1 END) AS so_cd_doi_tuong,
       COUNT(CASE WHEN h.vai = 'phan_khuc' THEN 1 END) AS so_cd_phan_khuc,
       COUNT(DISTINCT h.campaign_id) AS so_chien_dich
FROM hai_vai h
JOIN audiences a ON a.audience_id = h.audience_id
GROUP BY a.audience_id, a.audience_name
ORDER BY a.audience_id;

-- [mkt-t3-nhom-khach-hai-vai] wrong: dem_dong_khong_dem_chien_dich
-- Đếm số dòng sau khi ghép hai vai: chiến dịch có đối tượng trùng phân khúc bị đếm hai lần (rớt ở public).
WITH hai_vai AS (
  SELECT campaign_id, target_audience_id AS audience_id, 'doi_tuong' AS vai
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
  UNION ALL
  SELECT campaign_id, segment_id, 'phan_khuc'
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT a.audience_id,
       a.audience_name,
       COUNT(CASE WHEN h.vai = 'doi_tuong' THEN 1 END) AS so_cd_doi_tuong,
       COUNT(CASE WHEN h.vai = 'phan_khuc' THEN 1 END) AS so_cd_phan_khuc,
       COUNT(*) AS so_chien_dich
FROM hai_vai h
JOIN audiences a ON a.audience_id = h.audience_id
GROUP BY a.audience_id, a.audience_name
ORDER BY a.audience_id;

-- [mkt-t3-nhom-khach-hai-vai] wrong: thieu_can_tren
-- Chỉ lọc từ 1/1/2025, không có cận trên: lấy cả chiến dịch quý 2/2025 (rớt ở public).
WITH hai_vai AS (
  SELECT campaign_id, target_audience_id AS audience_id, 'doi_tuong' AS vai
  FROM campaigns
  WHERE start_date >= '2025-01-01'
  UNION ALL
  SELECT campaign_id, segment_id, 'phan_khuc'
  FROM campaigns
  WHERE start_date >= '2025-01-01'
)
SELECT a.audience_id,
       a.audience_name,
       COUNT(CASE WHEN h.vai = 'doi_tuong' THEN 1 END) AS so_cd_doi_tuong,
       COUNT(CASE WHEN h.vai = 'phan_khuc' THEN 1 END) AS so_cd_phan_khuc,
       COUNT(DISTINCT h.campaign_id) AS so_chien_dich
FROM hai_vai h
JOIN audiences a ON a.audience_id = h.audience_id
GROUP BY a.audience_id, a.audience_name
ORDER BY a.audience_id;

-- [mkt-t4-luat-phat-hien-so-nhat-ky] solution
WITH luat AS (
  SELECT 'NULL' AS loai, brand_id, row_index FROM campaigns_raw
  WHERE impressions IS NULL OR clicks IS NULL OR leads IS NULL OR conversions IS NULL
     OR revenue IS NULL OR acquisition_cost IS NULL
  UNION ALL
  SELECT 'NEGATIVE', brand_id, row_index FROM campaigns_raw
  WHERE impressions < 0 OR revenue < 0
  UNION ALL
  SELECT 'FUNNEL_ERROR', brand_id, row_index FROM campaigns_raw
  WHERE clicks > impressions OR leads > clicks OR conversions > leads
  UNION ALL
  SELECT 'INVALID_DATE', brand_id, row_index FROM campaigns_raw
  WHERE STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01'
  UNION ALL
  SELECT 'WHITESPACE', brand_id, row_index FROM campaigns_raw
  WHERE campaign_type <> TRIM(campaign_type) OR `language` <> TRIM(`language`)
     OR target_audience <> TRIM(target_audience) OR customer_segment <> TRIM(customer_segment)
  UNION ALL
  SELECT 'DUPLICATE', r.brand_id, r.row_index FROM campaigns_raw r
  WHERE EXISTS (SELECT 1 FROM campaigns_raw s
                WHERE s.brand_id = r.brand_id AND s.campaign_id = r.campaign_id AND s.row_index > r.row_index)
), nhat_ky AS (
  SELECT DISTINCT noise_type AS loai, brand_id, row_index FROM noise_log
), dem_luat AS (
  SELECT loai, COUNT(*) AS so_dong_luat FROM luat GROUP BY loai
), dem_nhat_ky AS (
  SELECT loai, COUNT(*) AS so_dong_nhat_ky FROM nhat_ky GROUP BY loai
), dem_khop AS (
  SELECT l.loai, COUNT(*) AS so_dong_khop
  FROM luat l
  JOIN nhat_ky n ON n.loai = l.loai AND n.brand_id = l.brand_id AND n.row_index = l.row_index
  GROUP BY l.loai
)
SELECT k.loai AS loai_nhieu,
       COALESCE(l.so_dong_luat, 0) AS so_dong_luat,
       k.so_dong_nhat_ky,
       COALESCE(m.so_dong_khop, 0) AS so_dong_khop
FROM dem_nhat_ky k
LEFT JOIN dem_luat l ON l.loai = k.loai
LEFT JOIN dem_khop m ON m.loai = k.loai
ORDER BY k.loai;

-- [mkt-t4-luat-phat-hien-so-nhat-ky] wrong: ngay_chi_kiem_doc_duoc
-- Luật ngày chỉ bắt chuỗi không đọc được, bỏ sót '01-01-1999', '15-06-2030' (đọc được nhưng ngoài kỳ) (rớt ở public).
WITH luat AS (
  SELECT 'NULL' AS loai, brand_id, row_index FROM campaigns_raw
  WHERE impressions IS NULL OR clicks IS NULL OR leads IS NULL OR conversions IS NULL
     OR revenue IS NULL OR acquisition_cost IS NULL
  UNION ALL
  SELECT 'NEGATIVE', brand_id, row_index FROM campaigns_raw
  WHERE impressions < 0 OR revenue < 0
  UNION ALL
  SELECT 'FUNNEL_ERROR', brand_id, row_index FROM campaigns_raw
  WHERE clicks > impressions OR leads > clicks OR conversions > leads
  UNION ALL
  SELECT 'INVALID_DATE', brand_id, row_index FROM campaigns_raw
  WHERE STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
  UNION ALL
  SELECT 'WHITESPACE', brand_id, row_index FROM campaigns_raw
  WHERE campaign_type <> TRIM(campaign_type) OR `language` <> TRIM(`language`)
     OR target_audience <> TRIM(target_audience) OR customer_segment <> TRIM(customer_segment)
  UNION ALL
  SELECT 'DUPLICATE', r.brand_id, r.row_index FROM campaigns_raw r
  WHERE EXISTS (SELECT 1 FROM campaigns_raw s
                WHERE s.brand_id = r.brand_id AND s.campaign_id = r.campaign_id AND s.row_index > r.row_index)
), nhat_ky AS (
  SELECT DISTINCT noise_type AS loai, brand_id, row_index FROM noise_log
), dem_luat AS (
  SELECT loai, COUNT(*) AS so_dong_luat FROM luat GROUP BY loai
), dem_nhat_ky AS (
  SELECT loai, COUNT(*) AS so_dong_nhat_ky FROM nhat_ky GROUP BY loai
), dem_khop AS (
  SELECT l.loai, COUNT(*) AS so_dong_khop
  FROM luat l
  JOIN nhat_ky n ON n.loai = l.loai AND n.brand_id = l.brand_id AND n.row_index = l.row_index
  GROUP BY l.loai
)
SELECT k.loai AS loai_nhieu,
       COALESCE(l.so_dong_luat, 0) AS so_dong_luat,
       k.so_dong_nhat_ky,
       COALESCE(m.so_dong_khop, 0) AS so_dong_khop
FROM dem_nhat_ky k
LEFT JOIN dem_luat l ON l.loai = k.loai
LEFT JOIN dem_khop m ON m.loai = k.loai
ORDER BY k.loai;

-- [mkt-t4-luat-phat-hien-so-nhat-ky] wrong: doi_chieu_thieu_brand
-- Đối chiếu nhật ký chỉ theo row_index: vị trí dòng lặp lại ở ba file nên số dòng khớp bị nhân lên (rớt ở public).
WITH luat AS (
  SELECT 'NULL' AS loai, brand_id, row_index FROM campaigns_raw
  WHERE impressions IS NULL OR clicks IS NULL OR leads IS NULL OR conversions IS NULL
     OR revenue IS NULL OR acquisition_cost IS NULL
  UNION ALL
  SELECT 'NEGATIVE', brand_id, row_index FROM campaigns_raw
  WHERE impressions < 0 OR revenue < 0
  UNION ALL
  SELECT 'FUNNEL_ERROR', brand_id, row_index FROM campaigns_raw
  WHERE clicks > impressions OR leads > clicks OR conversions > leads
  UNION ALL
  SELECT 'INVALID_DATE', brand_id, row_index FROM campaigns_raw
  WHERE STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01'
  UNION ALL
  SELECT 'WHITESPACE', brand_id, row_index FROM campaigns_raw
  WHERE campaign_type <> TRIM(campaign_type) OR `language` <> TRIM(`language`)
     OR target_audience <> TRIM(target_audience) OR customer_segment <> TRIM(customer_segment)
  UNION ALL
  SELECT 'DUPLICATE', r.brand_id, r.row_index FROM campaigns_raw r
  WHERE EXISTS (SELECT 1 FROM campaigns_raw s
                WHERE s.brand_id = r.brand_id AND s.campaign_id = r.campaign_id AND s.row_index > r.row_index)
), nhat_ky AS (
  SELECT DISTINCT noise_type AS loai, brand_id, row_index FROM noise_log
), dem_luat AS (
  SELECT loai, COUNT(*) AS so_dong_luat FROM luat GROUP BY loai
), dem_nhat_ky AS (
  SELECT loai, COUNT(*) AS so_dong_nhat_ky FROM nhat_ky GROUP BY loai
), dem_khop AS (
  SELECT l.loai, COUNT(*) AS so_dong_khop
  FROM luat l
  JOIN nhat_ky n ON n.loai = l.loai AND n.row_index = l.row_index
  GROUP BY l.loai
)
SELECT k.loai AS loai_nhieu,
       COALESCE(l.so_dong_luat, 0) AS so_dong_luat,
       k.so_dong_nhat_ky,
       COALESCE(m.so_dong_khop, 0) AS so_dong_khop
FROM dem_nhat_ky k
LEFT JOIN dem_luat l ON l.loai = k.loai
LEFT JOIN dem_khop m ON m.loai = k.loai
ORDER BY k.loai;

-- [mkt-t5-dang-chay-binh-quan-theo-tuan] solution
WITH theo_ngay AS (
  SELECT k.cal_date, k.week_start, COUNT(c.campaign_id) AS so_dang_chay
  FROM calendar k
  LEFT JOIN campaigns c
    ON c.start_date <= k.cal_date
   AND k.cal_date <= c.start_date + INTERVAL c.duration_days - 1 DAY
  WHERE k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
  GROUP BY k.cal_date, k.week_start
)
SELECT week_start,
       COUNT(*) AS so_ngay,
       ROUND(AVG(so_dang_chay), 1) AS bq_dang_chay_moi_ngay
FROM theo_ngay
GROUP BY week_start
ORDER BY week_start;

-- [mkt-t5-dang-chay-binh-quan-theo-tuan] wrong: noi_trong_mat_ngay_trong
-- Nối trong bỏ mất ngày không có chiến dịch nào đang chạy (29/6, 30/6): tuần cuối sai số ngày và bình quân (rớt ở public).
WITH theo_ngay AS (
  SELECT k.cal_date, k.week_start, COUNT(c.campaign_id) AS so_dang_chay
  FROM calendar k
  JOIN campaigns c
    ON c.start_date <= k.cal_date
   AND k.cal_date <= c.start_date + INTERVAL c.duration_days - 1 DAY
  WHERE k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
  GROUP BY k.cal_date, k.week_start
)
SELECT week_start,
       COUNT(*) AS so_ngay,
       ROUND(AVG(so_dang_chay), 1) AS bq_dang_chay_moi_ngay
FROM theo_ngay
GROUP BY week_start
ORDER BY week_start;

-- [mkt-t5-dang-chay-binh-quan-theo-tuan] wrong: lech_bien_ngay_cuoi
-- Ngày cuối lấy start_date + duration_days (thừa một ngày) (rớt ở public).
WITH theo_ngay AS (
  SELECT k.cal_date, k.week_start, COUNT(c.campaign_id) AS so_dang_chay
  FROM calendar k
  LEFT JOIN campaigns c
    ON c.start_date <= k.cal_date
   AND k.cal_date <= c.start_date + INTERVAL c.duration_days DAY
  WHERE k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
  GROUP BY k.cal_date, k.week_start
)
SELECT week_start,
       COUNT(*) AS so_ngay,
       ROUND(AVG(so_dang_chay), 1) AS bq_dang_chay_moi_ngay
FROM theo_ngay
GROUP BY week_start
ORDER BY week_start;

-- [mkt-t5-dang-chay-binh-quan-theo-tuan] wrong: thieu_can_tren
-- Chỉ có cận dưới của lịch: hidden-1 có ngày 2025-07-01 rơi vào tuần bắt đầu 2025-06-30 (rớt ở hidden-1).
WITH theo_ngay AS (
  SELECT k.cal_date, k.week_start, COUNT(c.campaign_id) AS so_dang_chay
  FROM calendar k
  LEFT JOIN campaigns c
    ON c.start_date <= k.cal_date
   AND k.cal_date <= c.start_date + INTERVAL c.duration_days - 1 DAY
  WHERE k.cal_date >= '2025-04-01'
  GROUP BY k.cal_date, k.week_start
)
SELECT week_start,
       COUNT(*) AS so_ngay,
       ROUND(AVG(so_dang_chay), 1) AS bq_dang_chay_moi_ngay
FROM theo_ngay
GROUP BY week_start
ORDER BY week_start;

-- [mkt-t6-phan-nhom-roi-ctr] solution
WITH nguong AS (
  SELECT (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_chung,
         ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_chung
  FROM campaigns
  WHERE brand_id = 2
), gan_nhan AS (
  SELECT c.campaign_id, c.revenue,
         CASE WHEN c.roi > n.roi_chung THEN 'cao' ELSE 'thap' END AS nhom_roi,
         CASE WHEN ROUND(c.clicks * 100 / c.impressions, 2) > n.ctr_chung THEN 'cao' ELSE 'thap' END AS nhom_ctr
  FROM campaigns c
  CROSS JOIN nguong n
  WHERE c.brand_id = 2
)
SELECT nhom_roi, nhom_ctr, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM gan_nhan
GROUP BY nhom_roi, nhom_ctr
ORDER BY nhom_roi, nhom_ctr;

-- [mkt-t6-phan-nhom-roi-ctr] wrong: nguong_binh_quan_gian_don
-- Ngưỡng lấy bình quân cột roi và bình quân CTR từng chiến dịch: ngưỡng ROI cao hơn hẳn tỷ lệ của tổng (rớt ở public).
WITH nguong AS (
  SELECT AVG(roi) AS roi_chung,
         ROUND(AVG(clicks * 100 / impressions), 2) AS ctr_chung
  FROM campaigns
  WHERE brand_id = 2
), gan_nhan AS (
  SELECT c.campaign_id, c.revenue,
         CASE WHEN c.roi > n.roi_chung THEN 'cao' ELSE 'thap' END AS nhom_roi,
         CASE WHEN ROUND(c.clicks * 100 / c.impressions, 2) > n.ctr_chung THEN 'cao' ELSE 'thap' END AS nhom_ctr
  FROM campaigns c
  CROSS JOIN nguong n
  WHERE c.brand_id = 2
)
SELECT nhom_roi, nhom_ctr, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM gan_nhan
GROUP BY nhom_roi, nhom_ctr
ORDER BY nhom_roi, nhom_ctr;

-- [mkt-t6-phan-nhom-roi-ctr] wrong: nguong_ca_ba_thuong_hieu
-- Ngưỡng tính trên cả ba thương hiệu thay vì riêng Purplle (rớt ở public).
WITH nguong AS (
  SELECT (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_chung,
         ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_chung
  FROM campaigns
), gan_nhan AS (
  SELECT c.campaign_id, c.revenue,
         CASE WHEN c.roi > n.roi_chung THEN 'cao' ELSE 'thap' END AS nhom_roi,
         CASE WHEN ROUND(c.clicks * 100 / c.impressions, 2) > n.ctr_chung THEN 'cao' ELSE 'thap' END AS nhom_ctr
  FROM campaigns c
  CROSS JOIN nguong n
  WHERE c.brand_id = 2
)
SELECT nhom_roi, nhom_ctr, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM gan_nhan
GROUP BY nhom_roi, nhom_ctr
ORDER BY nhom_roi, nhom_ctr;

-- [mkt-t7-union-mat-doanh-thu] starter
WITH hai_quy AS (
  SELECT brand_id, revenue FROM campaigns
  WHERE start_date >= '2024-10-01' AND start_date < '2025-01-01'
  UNION
  SELECT brand_id, revenue FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM hai_quy
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t7-union-mat-doanh-thu] solution
WITH hai_quy AS (
  SELECT brand_id, revenue FROM campaigns
  WHERE start_date >= '2024-10-01' AND start_date < '2025-01-01'
  UNION ALL
  SELECT brand_id, revenue FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM hai_quy
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t7-union-mat-doanh-thu] wrong: gop_mot_khoang_thieu_ngay_cuoi
-- Bỏ UNION, gộp hai quý thành một khoảng nhưng cận trên '2025-03-31' bỏ mất ngày 31/3 (rớt ở public).
SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-10-01' AND start_date < '2025-03-31'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t7-union-mat-doanh-thu] wrong: union_them_ngay_bat_dau
-- Giữ UNION, thêm start_date vào hai nhánh cho khỏi trùng: vẫn mất các chiến dịch cùng thương hiệu, cùng ngày, cùng doanh thu (rớt ở public).
WITH hai_quy AS (
  SELECT brand_id, start_date, revenue FROM campaigns
  WHERE start_date >= '2024-10-01' AND start_date < '2025-01-01'
  UNION
  SELECT brand_id, start_date, revenue FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
FROM hai_quy
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t8-ty-le-roi-pheu-sai-mau] starter
WITH tong AS (
  SELECT type_id,
         SUM(impressions) AS hien_thi,
         SUM(clicks) AS nhap,
         SUM(leads) AS khtn,
         SUM(conversions) AS chuyen_doi
  FROM campaigns
  WHERE start_date >= '2025-05-01' AND start_date < '2025-06-01'
  GROUP BY type_id
)
SELECT type_id,
       ROUND((1 - nhap / hien_thi) * 100, 2) AS ty_le_roi_tang_2_pct,
       ROUND((1 - khtn / hien_thi) * 100, 2) AS ty_le_roi_tang_3_pct,
       ROUND((1 - chuyen_doi / hien_thi) * 100, 2) AS ty_le_roi_tang_4_pct
FROM tong
ORDER BY type_id;

-- [mkt-t8-ty-le-roi-pheu-sai-mau] solution
WITH tong AS (
  SELECT type_id,
         SUM(impressions) AS hien_thi,
         SUM(clicks) AS nhap,
         SUM(leads) AS khtn,
         SUM(conversions) AS chuyen_doi
  FROM campaigns
  WHERE start_date >= '2025-05-01' AND start_date < '2025-06-01'
  GROUP BY type_id
)
SELECT type_id,
       ROUND((1 - nhap / hien_thi) * 100, 2) AS ty_le_roi_tang_2_pct,
       ROUND((1 - khtn / nhap) * 100, 2) AS ty_le_roi_tang_3_pct,
       ROUND((1 - chuyen_doi / khtn) * 100, 2) AS ty_le_roi_tang_4_pct
FROM tong
ORDER BY type_id;

-- [mkt-t8-ty-le-roi-pheu-sai-mau] wrong: ty_le_di_tiep_thay_ty_le_roi
-- Sửa mẫu số nhưng quên lấy 1 trừ: ra tỷ lệ đi tiếp, không phải tỷ lệ rơi (rớt ở public).
WITH tong AS (
  SELECT type_id,
         SUM(impressions) AS hien_thi,
         SUM(clicks) AS nhap,
         SUM(leads) AS khtn,
         SUM(conversions) AS chuyen_doi
  FROM campaigns
  WHERE start_date >= '2025-05-01' AND start_date < '2025-06-01'
  GROUP BY type_id
)
SELECT type_id,
       ROUND(nhap / hien_thi * 100, 2) AS ty_le_roi_tang_2_pct,
       ROUND(khtn / nhap * 100, 2) AS ty_le_roi_tang_3_pct,
       ROUND(chuyen_doi / khtn * 100, 2) AS ty_le_roi_tang_4_pct
FROM tong
ORDER BY type_id;

-- [mkt-t8-ty-le-roi-pheu-sai-mau] wrong: binh_quan_ty_le_tung_chien_dich
-- Bình quân tỷ lệ rơi của từng chiến dịch thay vì tỷ lệ của tổng (rớt ở public).
SELECT type_id,
       ROUND(AVG(1 - clicks / impressions) * 100, 2) AS ty_le_roi_tang_2_pct,
       ROUND(AVG(1 - leads / clicks) * 100, 2) AS ty_le_roi_tang_3_pct,
       ROUND(AVG(1 - conversions / leads) * 100, 2) AS ty_le_roi_tang_4_pct
FROM campaigns
WHERE start_date >= '2025-05-01' AND start_date < '2025-06-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-t9-bo-trung-khong-het] starter
WITH khong_trung AS (
  SELECT DISTINCT * FROM campaigns_raw
)
SELECT brand_id, COUNT(*) AS so_dong, SUM(revenue) AS doanh_thu
FROM khong_trung
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t9-bo-trung-khong-het] solution
WITH khong_trung AS (
  SELECT DISTINCT brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
         impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
         `language`, engagement_score, customer_segment, date_raw
  FROM campaigns_raw
)
SELECT brand_id, COUNT(*) AS so_dong, SUM(revenue) AS doanh_thu
FROM khong_trung
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t9-bo-trung-khong-het] wrong: dem_khac_nhau_thay_bo_trung
-- Không bỏ dòng mà đếm mã khác nhau và cộng doanh thu khác nhau: số dòng đúng nhưng mất doanh thu của các chiến dịch khác nhau có cùng doanh thu (rớt ở public).
SELECT brand_id, COUNT(DISTINCT campaign_id) AS so_dong, SUM(DISTINCT revenue) AS doanh_thu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-t9-bo-trung-khong-het] wrong: cat_theo_vi_tri_dong
-- Cắt cứng theo vị trí dòng (row_index < 55555) vì thấy dòng trùng nằm cuối file: hidden-1 có dòng thật ở vị trí 55605 bị bỏ (rớt ở hidden-1).
WITH khong_trung AS (
  SELECT * FROM campaigns_raw WHERE row_index < 55555
)
SELECT brand_id, COUNT(*) AS so_dong, SUM(revenue) AS doanh_thu
FROM khong_trung
GROUP BY brand_id
ORDER BY brand_id;

-- ===================================================================== MODULE 8 · WINDOW FUNCTIONS

-- [mkt-f1-top-3-doanh-thu-moi-thuong-hieu] solution
WITH xep_hang AS (
  SELECT brand_id, campaign_id, revenue,
         ROW_NUMBER() OVER (PARTITION BY brand_id ORDER BY revenue DESC, campaign_id) AS hang
  FROM campaigns
)
SELECT brand_id, hang, campaign_id, revenue
FROM xep_hang
WHERE hang <= 3
ORDER BY brand_id, hang;

-- [mkt-f1-top-3-doanh-thu-moi-thuong-hieu] wrong: rank_ra_bon_dong
-- RANK cho hai chiến dịch bằng doanh thu cùng hạng 3: hidden-1 ra 4 dòng cho Nykaa (rớt ở hidden-1).
WITH xep_hang AS (
  SELECT brand_id, campaign_id, revenue,
         RANK() OVER (PARTITION BY brand_id ORDER BY revenue DESC) AS hang
  FROM campaigns
)
SELECT brand_id, hang, campaign_id, revenue
FROM xep_hang
WHERE hang <= 3
ORDER BY brand_id, hang, campaign_id;

-- [mkt-f1-top-3-doanh-thu-moi-thuong-hieu] wrong: hoa_lay_ma_lon_hon
-- Bằng doanh thu thì lấy campaign_id lớn hơn: hidden-1 chọn NY-CMP-56543 thay NY-CMP-53612 (rớt ở hidden-1).
WITH xep_hang AS (
  SELECT brand_id, campaign_id, revenue,
         ROW_NUMBER() OVER (PARTITION BY brand_id ORDER BY revenue DESC, campaign_id DESC) AS hang
  FROM campaigns
)
SELECT brand_id, hang, campaign_id, revenue
FROM xep_hang
WHERE hang <= 3
ORDER BY brand_id, hang;

-- [mkt-f1-top-3-doanh-thu-moi-thuong-hieu] wrong: thieu_partition
-- Không chia theo thương hiệu: ra 3 chiến dịch cao nhất toàn bộ (rớt ở public).
WITH xep_hang AS (
  SELECT brand_id, campaign_id, revenue,
         ROW_NUMBER() OVER (ORDER BY revenue DESC, campaign_id) AS hang
  FROM campaigns
)
SELECT brand_id, hang, campaign_id, revenue
FROM xep_hang
WHERE hang <= 3
ORDER BY brand_id, hang;

-- [mkt-f2-mom-purplle] solution
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE brand_id = 2 AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
), co_thang_truoc AS (
  SELECT thang, doanh_thu, LAG(doanh_thu) OVER (ORDER BY thang) AS doanh_thu_thang_truoc
  FROM theo_thang
)
SELECT thang, doanh_thu, doanh_thu_thang_truoc,
       ROUND((doanh_thu - doanh_thu_thang_truoc) * 100 / doanh_thu_thang_truoc, 2) AS thay_doi_pct
FROM co_thang_truoc
ORDER BY thang;

-- [mkt-f2-mom-purplle] wrong: tinh_ca_thang_chua_du
-- Lấy cả tháng 6/2025 chưa đủ ngày (rớt ở public).
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE brand_id = 2 AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
), co_thang_truoc AS (
  SELECT thang, doanh_thu, LAG(doanh_thu) OVER (ORDER BY thang) AS doanh_thu_thang_truoc
  FROM theo_thang
)
SELECT thang, doanh_thu, doanh_thu_thang_truoc,
       ROUND((doanh_thu - doanh_thu_thang_truoc) * 100 / doanh_thu_thang_truoc, 2) AS thay_doi_pct
FROM co_thang_truoc
ORDER BY thang;

-- [mkt-f2-mom-purplle] wrong: chia_cho_thang_nay
-- Chia mức thay đổi cho doanh thu tháng này thay vì tháng trước (rớt ở public).
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE brand_id = 2 AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
), co_thang_truoc AS (
  SELECT thang, doanh_thu, LAG(doanh_thu) OVER (ORDER BY thang) AS doanh_thu_thang_truoc
  FROM theo_thang
)
SELECT thang, doanh_thu, doanh_thu_thang_truoc,
       ROUND((doanh_thu - doanh_thu_thang_truoc) * 100 / doanh_thu, 2) AS thay_doi_pct
FROM co_thang_truoc
ORDER BY thang;

-- [mkt-f3-truot-7-ngay-tira] solution
WITH theo_ngay AS (
  SELECT k.cal_date, COUNT(c.campaign_id) AS so_moi
  FROM calendar k
  LEFT JOIN campaigns c ON c.start_date = k.cal_date AND c.brand_id = 3
  WHERE k.cal_date >= '2025-02-23' AND k.cal_date < '2025-04-01'
  GROUP BY k.cal_date
), truot AS (
  SELECT cal_date, so_moi,
         SUM(so_moi) OVER (ORDER BY cal_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS so_7_ngay
  FROM theo_ngay
)
SELECT cal_date, so_moi AS so_chien_dich_moi, so_7_ngay AS so_chien_dich_7_ngay
FROM truot
WHERE cal_date >= '2025-03-01'
ORDER BY cal_date;

-- [mkt-f3-truot-7-ngay-tira] wrong: loc_thang_truoc_khi_truot
-- Lọc tháng 3 trước khi tính cửa sổ: sáu ngày đầu tháng thiếu ngày cuối tháng 2 (rớt ở public).
WITH theo_ngay AS (
  SELECT k.cal_date, COUNT(c.campaign_id) AS so_moi
  FROM calendar k
  LEFT JOIN campaigns c ON c.start_date = k.cal_date AND c.brand_id = 3
  WHERE k.cal_date >= '2025-03-01' AND k.cal_date < '2025-04-01'
  GROUP BY k.cal_date
)
SELECT cal_date, so_moi AS so_chien_dich_moi,
       SUM(so_moi) OVER (ORDER BY cal_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS so_chien_dich_7_ngay
FROM theo_ngay
ORDER BY cal_date;

-- [mkt-f3-truot-7-ngay-tira] wrong: khung_tam_ngay
-- Khung ROWS BETWEEN 7 PRECEDING lấy 8 ngày (rớt ở public).
WITH theo_ngay AS (
  SELECT k.cal_date, COUNT(c.campaign_id) AS so_moi
  FROM calendar k
  LEFT JOIN campaigns c ON c.start_date = k.cal_date AND c.brand_id = 3
  WHERE k.cal_date >= '2025-02-22' AND k.cal_date < '2025-04-01'
  GROUP BY k.cal_date
), truot AS (
  SELECT cal_date, so_moi,
         SUM(so_moi) OVER (ORDER BY cal_date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) AS so_7_ngay
  FROM theo_ngay
)
SELECT cal_date, so_moi AS so_chien_dich_moi, so_7_ngay AS so_chien_dich_7_ngay
FROM truot
WHERE cal_date >= '2025-03-01'
ORDER BY cal_date;

-- [mkt-f4-pareto-tira] solution
WITH luy_ke AS (
  SELECT campaign_id, revenue,
         ROW_NUMBER() OVER (ORDER BY revenue DESC, campaign_id) AS thu_tu,
         SUM(revenue) OVER (ORDER BY revenue DESC, campaign_id
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS doanh_thu_luy_ke,
         SUM(revenue) OVER () AS tong_doanh_thu,
         COUNT(*) OVER () AS tong_so_cd
  FROM campaigns
  WHERE brand_id = 3
)
SELECT MIN(thu_tu) AS so_chien_dich_80,
       MAX(tong_so_cd) AS tong_so_chien_dich,
       ROUND(MIN(thu_tu) * 100 / MAX(tong_so_cd), 2) AS ty_le_chien_dich_pct
FROM luy_ke
WHERE doanh_thu_luy_ke >= 0.8 * tong_doanh_thu;

-- [mkt-f4-pareto-tira] wrong: dem_chien_dich_duoi_80
-- Đếm chiến dịch có luỹ kế dưới 80%: thiếu đúng chiến dịch làm luỹ kế chạm 80% (rớt ở public).
WITH luy_ke AS (
  SELECT campaign_id, revenue,
         SUM(revenue) OVER (ORDER BY revenue DESC, campaign_id
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS doanh_thu_luy_ke,
         SUM(revenue) OVER () AS tong_doanh_thu,
         COUNT(*) OVER () AS tong_so_cd
  FROM campaigns
  WHERE brand_id = 3
)
SELECT COUNT(*) AS so_chien_dich_80,
       MAX(tong_so_cd) AS tong_so_chien_dich,
       ROUND(COUNT(*) * 100 / MAX(tong_so_cd), 2) AS ty_le_chien_dich_pct
FROM luy_ke
WHERE doanh_thu_luy_ke < 0.8 * tong_doanh_thu;

-- [mkt-f4-pareto-tira] wrong: sap_doanh_thu_tang_dan
-- Cộng dồn từ chiến dịch doanh thu thấp nhất (rớt ở public).
WITH luy_ke AS (
  SELECT campaign_id, revenue,
         ROW_NUMBER() OVER (ORDER BY revenue, campaign_id) AS thu_tu,
         SUM(revenue) OVER (ORDER BY revenue, campaign_id
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS doanh_thu_luy_ke,
         SUM(revenue) OVER () AS tong_doanh_thu,
         COUNT(*) OVER () AS tong_so_cd
  FROM campaigns
  WHERE brand_id = 3
)
SELECT MIN(thu_tu) AS so_chien_dich_80,
       MAX(tong_so_cd) AS tong_so_chien_dich,
       ROUND(MIN(thu_tu) * 100 / MAX(tong_so_cd), 2) AS ty_le_chien_dich_pct
FROM luy_ke
WHERE doanh_thu_luy_ke >= 0.8 * tong_doanh_thu;

-- [mkt-f5-chuoi-ngay-lien-tiep] solution
WITH ngay AS (
  SELECT DISTINCT start_date
  FROM campaigns
  WHERE brand_id = 1 AND type_id = 2 AND language_id = 1 AND target_audience_id = 5
), danh_dau AS (
  SELECT start_date,
         DATE_SUB(start_date, INTERVAL ROW_NUMBER() OVER (ORDER BY start_date) DAY) AS moc
  FROM ngay
), chuoi AS (
  SELECT MIN(start_date) AS ngay_dau, MAX(start_date) AS ngay_cuoi, COUNT(*) AS so_ngay
  FROM danh_dau
  GROUP BY moc
)
SELECT ngay_dau, ngay_cuoi, so_ngay
FROM chuoi
ORDER BY so_ngay DESC, ngay_dau
LIMIT 1;

-- [mkt-f5-chuoi-ngay-lien-tiep] wrong: danh_so_ca_ngay_trung
-- Đánh số trên từng chiến dịch, không bỏ ngày trùng: ngày có hai chiến dịch làm đứt chuỗi (rớt ở public).
WITH danh_dau AS (
  SELECT start_date,
         DATE_SUB(start_date, INTERVAL ROW_NUMBER() OVER (ORDER BY start_date, campaign_id) DAY) AS moc
  FROM campaigns
  WHERE brand_id = 1 AND type_id = 2 AND language_id = 1 AND target_audience_id = 5
), chuoi AS (
  SELECT MIN(start_date) AS ngay_dau, MAX(start_date) AS ngay_cuoi, COUNT(*) AS so_ngay
  FROM danh_dau
  GROUP BY moc
)
SELECT ngay_dau, ngay_cuoi, so_ngay
FROM chuoi
ORDER BY so_ngay DESC, ngay_dau
LIMIT 1;

-- [mkt-f5-chuoi-ngay-lien-tiep] wrong: hoa_lay_chuoi_muon_hon
-- Hai chuỗi dài bằng nhau thì lấy chuỗi muộn hơn: hidden-1 có hai chuỗi cùng dài nhất (rớt ở hidden-1).
WITH ngay AS (
  SELECT DISTINCT start_date
  FROM campaigns
  WHERE brand_id = 1 AND type_id = 2 AND language_id = 1 AND target_audience_id = 5
), danh_dau AS (
  SELECT start_date,
         DATE_SUB(start_date, INTERVAL ROW_NUMBER() OVER (ORDER BY start_date) DAY) AS moc
  FROM ngay
), chuoi AS (
  SELECT MIN(start_date) AS ngay_dau, MAX(start_date) AS ngay_cuoi, COUNT(*) AS so_ngay
  FROM danh_dau
  GROUP BY moc
)
SELECT ngay_dau, ngay_cuoi, so_ngay
FROM chuoi
ORDER BY so_ngay DESC, ngay_dau DESC
LIMIT 1;

-- [mkt-f6-nhom-gia-tri-don-theo-phan-khuc] solution
WITH chia_nhom AS (
  SELECT segment_id, campaign_id, revenue,
         revenue / NULLIF(conversions, 0) AS gia_tri_don,
         NTILE(4) OVER (PARTITION BY segment_id
                        ORDER BY revenue / NULLIF(conversions, 0) DESC, campaign_id) AS nhom
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       ROUND(MIN(gia_tri_don), 2) AS gia_tri_don_thap_nhat,
       SUM(revenue) AS doanh_thu
FROM chia_nhom
WHERE nhom = 1
GROUP BY segment_id
ORDER BY segment_id;

-- [mkt-f6-nhom-gia-tri-don-theo-phan-khuc] wrong: thieu_partition
-- Chia bốn nhóm trên toàn bộ chiến dịch rồi mới tách phân khúc (rớt ở public).
WITH chia_nhom AS (
  SELECT segment_id, campaign_id, revenue,
         revenue / NULLIF(conversions, 0) AS gia_tri_don,
         NTILE(4) OVER (ORDER BY revenue / NULLIF(conversions, 0) DESC, campaign_id) AS nhom
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       ROUND(MIN(gia_tri_don), 2) AS gia_tri_don_thap_nhat,
       SUM(revenue) AS doanh_thu
FROM chia_nhom
WHERE nhom = 1
GROUP BY segment_id
ORDER BY segment_id;

-- [mkt-f6-nhom-gia-tri-don-theo-phan-khuc] wrong: sap_tang_lay_nhom_4
-- Sắp tăng dần rồi lấy nhóm 4: khi số chiến dịch không chia hết cho 4, nhóm cuối ít hơn nhóm đầu (rớt ở public).
WITH chia_nhom AS (
  SELECT segment_id, campaign_id, revenue,
         revenue / NULLIF(conversions, 0) AS gia_tri_don,
         NTILE(4) OVER (PARTITION BY segment_id
                        ORDER BY revenue / NULLIF(conversions, 0), campaign_id) AS nhom
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       ROUND(MIN(gia_tri_don), 2) AS gia_tri_don_thap_nhat,
       SUM(revenue) AS doanh_thu
FROM chia_nhom
WHERE nhom = 4
GROUP BY segment_id
ORDER BY segment_id;

-- [mkt-f7-chi-phi-luy-ke-nhay-bac] starter
WITH chi_phi AS (
  SELECT campaign_id, start_date, acquisition_cost * conversions AS chi_phi
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
)
SELECT start_date,
       ROUND(SUM(chi_phi) OVER (ORDER BY start_date, campaign_id
                                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS chi_phi_luy_ke
FROM chi_phi
ORDER BY start_date, chi_phi_luy_ke;

-- [mkt-f7-chi-phi-luy-ke-nhay-bac] solution
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (ORDER BY start_date
                                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f7-chi-phi-luy-ke-nhay-bac] wrong: luy_ke_tu_dau_ky_roi_moi_loc
-- Gom theo ngày và cộng dồn từ đầu kỳ dữ liệu rồi mới lọc quý 2: ngày 1/4 mang theo chi phí từ tháng 7/2024 (rớt ở public).
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date < '2025-07-01'
  GROUP BY start_date
), luy_ke AS (
  SELECT start_date,
         SUM(chi_phi_ngay) OVER (ORDER BY start_date
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS chi_phi_luy_ke
  FROM theo_ngay
)
SELECT start_date, ROUND(chi_phi_luy_ke, 2) AS chi_phi_luy_ke
FROM luy_ke
WHERE start_date >= '2025-04-01'
ORDER BY start_date;

-- [mkt-f7-chi-phi-luy-ke-nhay-bac] wrong: chia_cua_so_theo_ngay
-- Gom theo ngày nhưng PARTITION BY start_date: mỗi ngày tự cộng lại từ đầu, ra chi phí trong ngày (rớt ở public).
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (PARTITION BY start_date ORDER BY start_date), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f7-chi-phi-luy-ke-nhay-bac] wrong: thieu_can_tren
-- Gom theo ngày đúng nhưng chỉ có cận dưới: hidden-1 có chiến dịch Nykaa ngày 2025-07-01 (rớt ở hidden-1).
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (ORDER BY start_date
                                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f8-lag-khong-chia-thuong-hieu] starter
WITH theo_thang AS (
  SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE start_date >= '2024-07-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang, doanh_thu,
       ROUND((doanh_thu - LAG(doanh_thu) OVER (ORDER BY brand_id, thang)) * 100
             / LAG(doanh_thu) OVER (ORDER BY brand_id, thang), 2) AS thay_doi_pct
FROM theo_thang
ORDER BY brand_id, thang;

-- [mkt-f8-lag-khong-chia-thuong-hieu] solution
WITH theo_thang AS (
  SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang, doanh_thu,
       ROUND((doanh_thu - LAG(doanh_thu) OVER (PARTITION BY brand_id ORDER BY thang)) * 100
             / LAG(doanh_thu) OVER (PARTITION BY brand_id ORDER BY thang), 2) AS thay_doi_pct
FROM theo_thang
ORDER BY brand_id, thang;

-- [mkt-f8-lag-khong-chia-thuong-hieu] wrong: chi_sua_partition
-- Chỉ thêm PARTITION BY brand_id, vẫn giữ tháng 6/2025 chưa đủ (và tháng 7/2025 ở hidden-1) (rớt ở public).
WITH theo_thang AS (
  SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE start_date >= '2024-07-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang, doanh_thu,
       ROUND((doanh_thu - LAG(doanh_thu) OVER (PARTITION BY brand_id ORDER BY thang)) * 100
             / LAG(doanh_thu) OVER (PARTITION BY brand_id ORDER BY thang), 2) AS thay_doi_pct
FROM theo_thang
ORDER BY brand_id, thang;

-- [mkt-f8-lag-khong-chia-thuong-hieu] wrong: chi_sua_ky
-- Chỉ sửa kỳ, quên chia theo thương hiệu: tháng 7/2024 của Purplle, Tira Beauty so với tháng 5/2025 của thương hiệu trước (rớt ở public).
WITH theo_thang AS (
  SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang, doanh_thu,
       ROUND((doanh_thu - LAG(doanh_thu) OVER (ORDER BY brand_id, thang)) * 100
             / LAG(doanh_thu) OVER (ORDER BY brand_id, thang), 2) AS thay_doi_pct
FROM theo_thang
ORDER BY brand_id, thang;

-- [mkt-f9-tuong-tac-cao-nhat-moi-loai] starter
WITH xep_hang AS (
  SELECT type_id, campaign_id, engagement_score,
         ROW_NUMBER() OVER (ORDER BY engagement_score DESC, campaign_id) AS hang
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT type_id, campaign_id, engagement_score
FROM xep_hang
WHERE hang = 1
ORDER BY type_id;

-- [mkt-f9-tuong-tac-cao-nhat-moi-loai] solution
WITH xep_hang AS (
  SELECT type_id, campaign_id, engagement_score,
         ROW_NUMBER() OVER (PARTITION BY type_id ORDER BY engagement_score DESC, campaign_id) AS hang
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT type_id, campaign_id, engagement_score
FROM xep_hang
WHERE hang = 1
ORDER BY type_id;

-- [mkt-f9-tuong-tac-cao-nhat-moi-loai] wrong: gom_max_lay_ma_nho_nhat
-- Bỏ hàm cửa sổ, gom theo loại lấy MAX điểm và MIN mã: mã chiến dịch không đi cùng điểm cao nhất (rớt ở public).
SELECT type_id, MIN(campaign_id) AS campaign_id, MAX(engagement_score) AS engagement_score
FROM campaigns
WHERE brand_id = 3 AND start_date >= '2025-01-01' AND start_date < '2025-04-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-f9-tuong-tac-cao-nhat-moi-loai] wrong: chia_loai_nhung_sap_tang_dan
-- Thêm PARTITION BY type_id nhưng sắp điểm tăng dần: lấy chiến dịch điểm thấp nhất mỗi loại (rớt ở public).
WITH xep_hang AS (
  SELECT type_id, campaign_id, engagement_score,
         ROW_NUMBER() OVER (PARTITION BY type_id ORDER BY engagement_score, campaign_id) AS hang
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT type_id, campaign_id, engagement_score
FROM xep_hang
WHERE hang = 1
ORDER BY type_id;

-- [mkt-c7-doanh-thu-nykaa-co-giam.b1] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE brand_id = 1 AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c7-doanh-thu-nykaa-co-giam.b1] wrong: thieu_can_tren
-- Chỉ có cận dưới: hidden-1 thêm tháng 2025-07 (rớt ở hidden-1).
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE brand_id = 1 AND start_date >= '2025-01-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c7-doanh-thu-nykaa-co-giam.b2] solution
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT thang, doanh_thu,
       ROUND((doanh_thu - LAG(doanh_thu) OVER (ORDER BY thang)) * 100
             / LAG(doanh_thu) OVER (ORDER BY thang), 2) AS thay_doi_pct
FROM theo_thang
ORDER BY thang;

-- [mkt-c7-doanh-thu-nykaa-co-giam.b2] wrong: chia_cho_thang_nay
-- Chia mức thay đổi cho tháng này thay vì tháng trước (rớt ở public).
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, SUM(revenue) AS doanh_thu
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT thang, doanh_thu,
       ROUND((doanh_thu - LAG(doanh_thu) OVER (ORDER BY thang)) * 100 / doanh_thu, 2) AS thay_doi_pct
FROM theo_thang
ORDER BY thang;

-- [mkt-c7-doanh-thu-nykaa-co-giam.b3] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(DISTINCT start_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT start_date), 1) AS so_chien_dich_moi_ngay,
       ROUND(SUM(revenue) / COUNT(*), 0) AS doanh_thu_moi_chien_dich
FROM campaigns
WHERE brand_id = 1 AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c7-doanh-thu-nykaa-co-giam.b3] wrong: so_ngay_theo_lich
-- Lấy số ngày theo lịch của tháng (30 ngày cho tháng 6) thay vì số ngày có chiến dịch (rớt ở public).
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       DAY(LAST_DAY(MIN(start_date))) AS so_ngay,
       ROUND(COUNT(*) / DAY(LAST_DAY(MIN(start_date))), 1) AS so_chien_dich_moi_ngay,
       ROUND(SUM(revenue) / COUNT(*), 0) AS doanh_thu_moi_chien_dich
FROM campaigns
WHERE brand_id = 1 AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b1] solution
SELECT a.audience_id,
       a.audience_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN audiences a ON a.audience_id = c.target_audience_id
GROUP BY a.audience_id, a.audience_name
ORDER BY roi DESC, a.audience_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b1] wrong: binh_quan_cot_roi
-- Bình quân cột roi thay vì ROI của tổng (rớt ở public).
SELECT a.audience_id,
       a.audience_name,
       COUNT(*) AS so_chien_dich,
       ROUND(AVG(c.roi), 4) AS roi
FROM campaigns c
JOIN audiences a ON a.audience_id = c.target_audience_id
GROUP BY a.audience_id, a.audience_name
ORDER BY roi DESC, a.audience_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b1] wrong: noi_theo_phan_khuc
-- Nối audiences qua segment_id: ra ROI theo phân khúc khách hàng, không phải đối tượng mục tiêu (rớt ở public).
SELECT a.audience_id,
       a.audience_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN audiences a ON a.audience_id = c.segment_id
GROUP BY a.audience_id, a.audience_name
ORDER BY roi DESC, a.audience_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b2] solution
SELECT target_audience_id AS audience_id,
       type_id,
       ROUND(SUM(acquisition_cost * conversions) / SUM(conversions), 2) AS cpa
FROM campaigns
GROUP BY target_audience_id, type_id
ORDER BY audience_id, type_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b2] wrong: binh_quan_acquisition_cost
-- Bình quân cột acquisition_cost thay vì tổng chi phí chia tổng lượt chuyển đổi (rớt ở public).
SELECT target_audience_id AS audience_id,
       type_id,
       ROUND(AVG(acquisition_cost), 2) AS cpa
FROM campaigns
GROUP BY target_audience_id, type_id
ORDER BY audience_id, type_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b3] solution
WITH roi_nhom AS (
  SELECT brand_id, target_audience_id AS audience_id,
         (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi
  FROM campaigns
  GROUP BY brand_id, target_audience_id
)
SELECT brand_id, audience_id, ROUND(roi, 4) AS roi,
       RANK() OVER (PARTITION BY brand_id ORDER BY roi DESC) AS hang
FROM roi_nhom
ORDER BY brand_id, hang, audience_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b3] wrong: xep_hang_chung_ba_thuong_hieu
-- Xếp hạng chung 15 cặp, không chia theo thương hiệu (rớt ở public).
WITH roi_nhom AS (
  SELECT brand_id, target_audience_id AS audience_id,
         (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi
  FROM campaigns
  GROUP BY brand_id, target_audience_id
)
SELECT brand_id, audience_id, ROUND(roi, 4) AS roi,
       RANK() OVER (ORDER BY roi DESC) AS hang
FROM roi_nhom
ORDER BY brand_id, hang, audience_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b4] solution
WITH theo_nhom AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, target_audience_id AS audience_id,
         (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m'), target_audience_id
), muc_chung AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
         (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_chung
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT t.audience_id,
       COUNT(CASE WHEN t.roi > m.roi_chung THEN 1 END) AS so_thang_tren_muc_chung,
       ROUND(MIN(t.roi), 4) AS roi_thap_nhat,
       ROUND(MAX(t.roi), 4) AS roi_cao_nhat
FROM theo_nhom t
JOIN muc_chung m ON m.thang = t.thang
GROUP BY t.audience_id
ORDER BY t.audience_id;

-- [mkt-c8-doi-tuong-dang-tang-ngan-sach.b4] wrong: tinh_ca_thang_chua_du
-- Tính cả tháng 6/2025 chưa đủ (rớt ở public).
WITH theo_nhom AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, target_audience_id AS audience_id,
         (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m'), target_audience_id
), muc_chung AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
         (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_chung
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT t.audience_id,
       COUNT(CASE WHEN t.roi > m.roi_chung THEN 1 END) AS so_thang_tren_muc_chung,
       ROUND(MIN(t.roi), 4) AS roi_thap_nhat,
       ROUND(MAX(t.roi), 4) AS roi_cao_nhat
FROM theo_nhom t
JOIN muc_chung m ON m.thang = t.thang
GROUP BY t.audience_id
ORDER BY t.audience_id;
