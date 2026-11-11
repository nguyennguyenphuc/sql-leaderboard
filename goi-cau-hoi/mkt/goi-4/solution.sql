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

-- [mkt-t4-ngung-kenh-anh-huong-doanh-thu] solution
WITH cd_quy AS (
  SELECT campaign_id, brand_id, revenue
  FROM campaigns
  WHERE start_date >= '2025-04-01' AND start_date < '2025-07-01'
), so_kenh AS (
  SELECT q.campaign_id, COUNT(*) AS so_kenh
  FROM cd_quy q
  JOIN campaign_channels cc ON cc.campaign_id = q.campaign_id
  GROUP BY q.campaign_id
), tong_thuong_hieu AS (
  SELECT brand_id, SUM(revenue) AS doanh_thu_tong
  FROM cd_quy
  GROUP BY brand_id
), theo_kenh AS (
  SELECT q.brand_id, cc.channel_id,
         COUNT(*) AS so_chien_dich,
         SUM(q.revenue) AS doanh_thu_anh_huong,
         SUM(CASE WHEN s.so_kenh = 1 THEN q.revenue ELSE 0 END) AS doanh_thu_mat_han
  FROM cd_quy q
  JOIN campaign_channels cc ON cc.campaign_id = q.campaign_id
  JOIN so_kenh s ON s.campaign_id = q.campaign_id
  GROUP BY q.brand_id, cc.channel_id
)
SELECT k.brand_id, ch.channel_name, k.so_chien_dich,
       ROUND(k.doanh_thu_anh_huong * 100 / t.doanh_thu_tong, 2) AS ty_trong_anh_huong_pct,
       ROUND(k.doanh_thu_mat_han * 100 / t.doanh_thu_tong, 2) AS ty_trong_mat_han_pct
FROM theo_kenh k
JOIN tong_thuong_hieu t ON t.brand_id = k.brand_id
JOIN channels ch ON ch.channel_id = k.channel_id
ORDER BY k.brand_id, ch.channel_name;

-- [mkt-t4-ngung-kenh-anh-huong-doanh-thu] wrong: tong_thuong_hieu_tren_dong_da_noi
-- Tổng doanh thu thương hiệu cộng trên các dòng đã nối kênh: chiến dịch nhiều kênh bị cộng nhiều lần, tỷ trọng còn khoảng một nửa (rớt ở public).
WITH cd_kenh AS (
  SELECT c.campaign_id, c.brand_id, c.revenue, cc.channel_id
  FROM campaigns c
  JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
  WHERE c.start_date >= '2025-04-01' AND c.start_date < '2025-07-01'
), so_kenh AS (
  SELECT campaign_id, COUNT(*) AS so_kenh
  FROM cd_kenh
  GROUP BY campaign_id
), tong_thuong_hieu AS (
  SELECT brand_id, SUM(revenue) AS doanh_thu_tong
  FROM cd_kenh
  GROUP BY brand_id
), theo_kenh AS (
  SELECT k.brand_id, k.channel_id,
         COUNT(*) AS so_chien_dich,
         SUM(k.revenue) AS doanh_thu_anh_huong,
         SUM(CASE WHEN s.so_kenh = 1 THEN k.revenue ELSE 0 END) AS doanh_thu_mat_han
  FROM cd_kenh k
  JOIN so_kenh s ON s.campaign_id = k.campaign_id
  GROUP BY k.brand_id, k.channel_id
)
SELECT k.brand_id, ch.channel_name, k.so_chien_dich,
       ROUND(k.doanh_thu_anh_huong * 100 / t.doanh_thu_tong, 2) AS ty_trong_anh_huong_pct,
       ROUND(k.doanh_thu_mat_han * 100 / t.doanh_thu_tong, 2) AS ty_trong_mat_han_pct
FROM theo_kenh k
JOIN tong_thuong_hieu t ON t.brand_id = k.brand_id
JOIN channels ch ON ch.channel_id = k.channel_id
ORDER BY k.brand_id, ch.channel_name;

-- [mkt-t4-ngung-kenh-anh-huong-doanh-thu] wrong: kenh_dau_chuoi_la_kenh_duy_nhat
-- Coi kênh đứng đầu chuỗi (channel_pos = 1) là kênh duy nhất: phần mất hẳn gộp cả chiến dịch còn kênh khác (rớt ở public).
WITH cd_quy AS (
  SELECT campaign_id, brand_id, revenue
  FROM campaigns
  WHERE start_date >= '2025-04-01' AND start_date < '2025-07-01'
), tong_thuong_hieu AS (
  SELECT brand_id, SUM(revenue) AS doanh_thu_tong
  FROM cd_quy
  GROUP BY brand_id
), theo_kenh AS (
  SELECT q.brand_id, cc.channel_id,
         COUNT(*) AS so_chien_dich,
         SUM(q.revenue) AS doanh_thu_anh_huong,
         SUM(CASE WHEN cc.channel_pos = 1 THEN q.revenue ELSE 0 END) AS doanh_thu_mat_han
  FROM cd_quy q
  JOIN campaign_channels cc ON cc.campaign_id = q.campaign_id
  GROUP BY q.brand_id, cc.channel_id
)
SELECT k.brand_id, ch.channel_name, k.so_chien_dich,
       ROUND(k.doanh_thu_anh_huong * 100 / t.doanh_thu_tong, 2) AS ty_trong_anh_huong_pct,
       ROUND(k.doanh_thu_mat_han * 100 / t.doanh_thu_tong, 2) AS ty_trong_mat_han_pct
FROM theo_kenh k
JOIN tong_thuong_hieu t ON t.brand_id = k.brand_id
JOIN channels ch ON ch.channel_id = k.channel_id
ORDER BY k.brand_id, ch.channel_name;

-- [mkt-t4-ngung-kenh-anh-huong-doanh-thu] wrong: thieu_can_tren
-- Chỉ có cận dưới 1/4/2025: hidden-1 lấy thêm NY-CMP-56555 (Nykaa, 1/7/2025, WhatsApp và YouTube), số chiến dịch và tỷ trọng Nykaa lệch (chỉ rớt ở hidden-1).
WITH cd_quy AS (
  SELECT campaign_id, brand_id, revenue
  FROM campaigns
  WHERE start_date >= '2025-04-01'
), so_kenh AS (
  SELECT q.campaign_id, COUNT(*) AS so_kenh
  FROM cd_quy q
  JOIN campaign_channels cc ON cc.campaign_id = q.campaign_id
  GROUP BY q.campaign_id
), tong_thuong_hieu AS (
  SELECT brand_id, SUM(revenue) AS doanh_thu_tong
  FROM cd_quy
  GROUP BY brand_id
), theo_kenh AS (
  SELECT q.brand_id, cc.channel_id,
         COUNT(*) AS so_chien_dich,
         SUM(q.revenue) AS doanh_thu_anh_huong,
         SUM(CASE WHEN s.so_kenh = 1 THEN q.revenue ELSE 0 END) AS doanh_thu_mat_han
  FROM cd_quy q
  JOIN campaign_channels cc ON cc.campaign_id = q.campaign_id
  JOIN so_kenh s ON s.campaign_id = q.campaign_id
  GROUP BY q.brand_id, cc.channel_id
)
SELECT k.brand_id, ch.channel_name, k.so_chien_dich,
       ROUND(k.doanh_thu_anh_huong * 100 / t.doanh_thu_tong, 2) AS ty_trong_anh_huong_pct,
       ROUND(k.doanh_thu_mat_han * 100 / t.doanh_thu_tong, 2) AS ty_trong_mat_han_pct
FROM theo_kenh k
JOIN tong_thuong_hieu t ON t.brand_id = k.brand_id
JOIN channels ch ON ch.channel_id = k.channel_id
ORDER BY k.brand_id, ch.channel_name;

-- [mkt-t5-chi-phi-quy-2-theo-ngay-chay] solution
WITH ngay_chay AS (
  SELECT c.type_id,
         c.acquisition_cost * c.conversions / c.duration_days AS chi_phi_mot_ngay
  FROM campaigns c
  JOIN calendar k
    ON k.cal_date BETWEEN c.start_date AND c.start_date + INTERVAL c.duration_days - 1 DAY
  WHERE c.brand_id = 1
    AND k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
), theo_ngay_chay AS (
  SELECT type_id, SUM(chi_phi_mot_ngay) AS chi_phi
  FROM ngay_chay
  GROUP BY type_id
), theo_ngay_bat_dau AS (
  SELECT type_id, SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE brand_id = 1
    AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY type_id
)
SELECT t.type_name,
       ROUND(b.chi_phi, 2) AS chi_phi_theo_ngay_bat_dau,
       ROUND(r.chi_phi, 2) AS chi_phi_theo_ngay_chay,
       ROUND(r.chi_phi - b.chi_phi, 2) AS chenh_lech
FROM campaign_types t
JOIN theo_ngay_bat_dau b ON b.type_id = t.type_id
JOIN theo_ngay_chay r ON r.type_id = t.type_id
ORDER BY t.type_name;

-- [mkt-t5-chi-phi-quy-2-theo-ngay-chay] wrong: tinh_hai_cach_tren_mot_lan_noi
-- Tính cả hai cách ghi trên cùng một lần nối với lịch: chi phí ghi theo ngày bắt đầu bị cộng lại ở mỗi ngày chạy trong quý (rớt ở public).
SELECT t.type_name,
       ROUND(SUM(CASE WHEN c.start_date >= '2025-04-01' THEN c.acquisition_cost * c.conversions ELSE 0 END), 2) AS chi_phi_theo_ngay_bat_dau,
       ROUND(SUM(c.acquisition_cost * c.conversions / c.duration_days), 2) AS chi_phi_theo_ngay_chay,
       ROUND(SUM(c.acquisition_cost * c.conversions / c.duration_days)
             - SUM(CASE WHEN c.start_date >= '2025-04-01' THEN c.acquisition_cost * c.conversions ELSE 0 END), 2) AS chenh_lech
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
JOIN calendar k
  ON k.cal_date BETWEEN c.start_date AND c.start_date + INTERVAL c.duration_days - 1 DAY
WHERE c.brand_id = 1
  AND k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
GROUP BY t.type_name
ORDER BY t.type_name;

-- [mkt-t5-chi-phi-quy-2-theo-ngay-chay] wrong: chi_xet_chien_dich_bat_dau_trong_quy
-- Chỉ lấy chiến dịch bắt đầu trong quý cho cả hai cách ghi: mất phần chi phí quý 2 của các chiến dịch bắt đầu tháng 3/2025 còn chạy sang tháng 4, chênh lệch ra 0 (rớt ở public).
WITH cd_quy AS (
  SELECT campaign_id, type_id, start_date, duration_days,
         acquisition_cost * conversions AS chi_phi
  FROM campaigns
  WHERE brand_id = 1
    AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
), theo_ngay_chay AS (
  SELECT q.type_id, SUM(q.chi_phi / q.duration_days) AS chi_phi
  FROM cd_quy q
  JOIN calendar k
    ON k.cal_date BETWEEN q.start_date AND q.start_date + INTERVAL q.duration_days - 1 DAY
  WHERE k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
  GROUP BY q.type_id
), theo_ngay_bat_dau AS (
  SELECT type_id, SUM(chi_phi) AS chi_phi
  FROM cd_quy
  GROUP BY type_id
)
SELECT t.type_name,
       ROUND(b.chi_phi, 2) AS chi_phi_theo_ngay_bat_dau,
       ROUND(r.chi_phi, 2) AS chi_phi_theo_ngay_chay,
       ROUND(r.chi_phi - b.chi_phi, 2) AS chenh_lech
FROM campaign_types t
JOIN theo_ngay_bat_dau b ON b.type_id = t.type_id
JOIN theo_ngay_chay r ON r.type_id = t.type_id
ORDER BY t.type_name;

-- [mkt-t5-chi-phi-quy-2-theo-ngay-chay] wrong: ngay_cuoi_thua_mot_ngay
-- Ngày chạy cuối lấy start_date + duration_days: mỗi chiến dịch có thêm một ngày, phần chi phí theo ngày chạy vượt chi phí thật (rớt ở public).
WITH ngay_chay AS (
  SELECT c.type_id,
         c.acquisition_cost * c.conversions / c.duration_days AS chi_phi_mot_ngay
  FROM campaigns c
  JOIN calendar k
    ON k.cal_date BETWEEN c.start_date AND c.start_date + INTERVAL c.duration_days DAY
  WHERE c.brand_id = 1
    AND k.cal_date >= '2025-04-01' AND k.cal_date < '2025-07-01'
), theo_ngay_chay AS (
  SELECT type_id, SUM(chi_phi_mot_ngay) AS chi_phi
  FROM ngay_chay
  GROUP BY type_id
), theo_ngay_bat_dau AS (
  SELECT type_id, SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE brand_id = 1
    AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY type_id
)
SELECT t.type_name,
       ROUND(b.chi_phi, 2) AS chi_phi_theo_ngay_bat_dau,
       ROUND(r.chi_phi, 2) AS chi_phi_theo_ngay_chay,
       ROUND(r.chi_phi - b.chi_phi, 2) AS chenh_lech
FROM campaign_types t
JOIN theo_ngay_bat_dau b ON b.type_id = t.type_id
JOIN theo_ngay_chay r ON r.type_id = t.type_id
ORDER BY t.type_name;

-- [mkt-t5-chi-phi-quy-2-theo-ngay-chay] wrong: thieu_can_tren
-- Lọc ngày bắt đầu và ngày lịch chỉ từ 1/4/2025, không có cận trên: public khớp vì dữ liệu dừng ở tháng 6/2025; hidden-1 thêm NY-CMP-56555 (Nykaa, Social Media, bắt đầu 1/7/2025) nên dòng Social Media lệch (chỉ rớt ở hidden-1).
WITH ngay_chay AS (
  SELECT c.type_id,
         c.acquisition_cost * c.conversions / c.duration_days AS chi_phi_mot_ngay
  FROM campaigns c
  JOIN calendar k
    ON k.cal_date BETWEEN c.start_date AND c.start_date + INTERVAL c.duration_days - 1 DAY
  WHERE c.brand_id = 1
    AND k.cal_date >= '2025-04-01'
), theo_ngay_chay AS (
  SELECT type_id, SUM(chi_phi_mot_ngay) AS chi_phi
  FROM ngay_chay
  GROUP BY type_id
), theo_ngay_bat_dau AS (
  SELECT type_id, SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE brand_id = 1
    AND start_date >= '2025-04-01'
  GROUP BY type_id
)
SELECT t.type_name,
       ROUND(b.chi_phi, 2) AS chi_phi_theo_ngay_bat_dau,
       ROUND(r.chi_phi, 2) AS chi_phi_theo_ngay_chay,
       ROUND(r.chi_phi - b.chi_phi, 2) AS chenh_lech
FROM campaign_types t
JOIN theo_ngay_bat_dau b ON b.type_id = t.type_id
JOIN theo_ngay_chay r ON r.type_id = t.type_id
ORDER BY t.type_name;

-- [mkt-t6-so-chien-dich-theo-so-kenh] solution
WITH kenh_moi_chien_dich AS (
  SELECT campaign_id, COUNT(*) AS so_kenh
  FROM campaign_channels
  GROUP BY campaign_id
)
SELECT so_kenh, COUNT(*) AS so_chien_dich
FROM kenh_moi_chien_dich
GROUP BY so_kenh
ORDER BY so_kenh;

-- [mkt-t6-so-chien-dich-theo-so-kenh] wrong: dem_theo_vi_tri_kenh
-- Coi channel_pos là số kênh: đếm số dòng ở mỗi vị trí, chiến dịch ba kênh bị tính ở cả ba vị trí (rớt ở public).
SELECT channel_pos AS so_kenh, COUNT(*) AS so_chien_dich
FROM campaign_channels
GROUP BY channel_pos
ORDER BY channel_pos;

-- [mkt-t6-so-chien-dich-theo-so-kenh] wrong: cong_so_kenh_thay_dem_chien_dich
-- Ở truy vấn ngoài cộng số kênh thay vì đếm chiến dịch: ra tổng số dòng kênh của nhóm (rớt ở public).
WITH kenh_moi_chien_dich AS (
  SELECT campaign_id, COUNT(*) AS so_kenh
  FROM campaign_channels
  GROUP BY campaign_id
)
SELECT so_kenh, SUM(so_kenh) AS so_chien_dich
FROM kenh_moi_chien_dich
GROUP BY so_kenh
ORDER BY so_kenh;

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
       ROUND((1 - khtn / nhap) * 100, 2) AS ty_le_roi_tang_3_pct,
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

-- [mkt-t8-ty-le-roi-pheu-sai-mau] wrong: tang_4_chia_luot_nhap
-- Đổi mẫu số của tầng 4 thành lượt nhấp thay vì khách hàng tiềm năng (tầng ngay trước) (rớt ở public).
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
       ROUND((1 - chuyen_doi / nhap) * 100, 2) AS ty_le_roi_tang_4_pct
FROM tong
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

-- [mkt-f3-hang-luot-nhap-trong-ngay] solution
SELECT start_date,
       ROW_NUMBER() OVER (PARTITION BY start_date ORDER BY clicks DESC, campaign_id) AS hang,
       campaign_id,
       clicks
FROM campaigns
WHERE brand_id = 2 AND type_id = 5 AND language_id = 2
  AND start_date >= '2025-03-03' AND start_date < '2025-03-05'
ORDER BY start_date, hang;

-- [mkt-f3-hang-luot-nhap-trong-ngay] wrong: thieu_partition
-- Không chia theo ngày: số thứ tự chạy liền qua hai ngày (rớt ở public).
SELECT start_date,
       ROW_NUMBER() OVER (ORDER BY clicks DESC, campaign_id) AS hang,
       campaign_id,
       clicks
FROM campaigns
WHERE brand_id = 2 AND type_id = 5 AND language_id = 2
  AND start_date >= '2025-03-03' AND start_date < '2025-03-05'
ORDER BY start_date, hang;

-- [mkt-f3-hang-luot-nhap-trong-ngay] wrong: sap_luot_nhap_tang_dan
-- Quên DESC: hạng 1 là chiến dịch ít lượt nhấp nhất (rớt ở public).
SELECT start_date,
       ROW_NUMBER() OVER (PARTITION BY start_date ORDER BY clicks, campaign_id) AS hang,
       campaign_id,
       clicks
FROM campaigns
WHERE brand_id = 2 AND type_id = 5 AND language_id = 2
  AND start_date >= '2025-03-03' AND start_date < '2025-03-05'
ORDER BY start_date, hang;

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
  SELECT segment_id, campaign_id,
         revenue / conversions AS gia_tri_don,
         NTILE(4) OVER (PARTITION BY segment_id
                        ORDER BY revenue / conversions DESC, campaign_id) AS nhom
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       ROUND(MIN(gia_tri_don), 2) AS gia_tri_don_thap_nhat
FROM chia_nhom
WHERE nhom = 1
GROUP BY segment_id
ORDER BY segment_id;

-- [mkt-f6-nhom-gia-tri-don-theo-phan-khuc] wrong: thieu_partition
-- Chia bốn nhóm trên toàn bộ chiến dịch rồi mới tách phân khúc (rớt ở public).
WITH chia_nhom AS (
  SELECT segment_id, campaign_id,
         revenue / conversions AS gia_tri_don,
         NTILE(4) OVER (ORDER BY revenue / conversions DESC, campaign_id) AS nhom
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       ROUND(MIN(gia_tri_don), 2) AS gia_tri_don_thap_nhat
FROM chia_nhom
WHERE nhom = 1
GROUP BY segment_id
ORDER BY segment_id;

-- [mkt-f6-nhom-gia-tri-don-theo-phan-khuc] wrong: sap_tang_lay_nhom_4
-- Sắp tăng dần rồi lấy nhóm 4: khi số chiến dịch không chia hết cho 4, nhóm cuối ít hơn nhóm đầu (rớt ở public).
WITH chia_nhom AS (
  SELECT segment_id, campaign_id,
         revenue / conversions AS gia_tri_don,
         NTILE(4) OVER (PARTITION BY segment_id
                        ORDER BY revenue / conversions, campaign_id) AS nhom
  FROM campaigns
  WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
)
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       ROUND(MIN(gia_tri_don), 2) AS gia_tri_don_thap_nhat
FROM chia_nhom
WHERE nhom = 4
GROUP BY segment_id
ORDER BY segment_id;

-- [mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang] starter
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang] solution
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (ORDER BY start_date), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang] wrong: chia_cua_so_theo_ngay
-- Thêm PARTITION BY start_date thay vì ORDER BY: mỗi ngày tự cộng lại từ đầu, ra chi phí trong ngày (rớt ở public).
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (PARTITION BY start_date), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang] wrong: cong_don_nguoc_tu_cuoi_quy
-- Sắp ngày giảm dần trong OVER: cộng dồn ngược từ cuối quý về đầu quý (rớt ở public).
WITH theo_ngay AS (
  SELECT start_date, SUM(acquisition_cost * conversions) AS chi_phi_ngay
  FROM campaigns
  WHERE brand_id = 1 AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  GROUP BY start_date
)
SELECT start_date,
       ROUND(SUM(chi_phi_ngay) OVER (ORDER BY start_date DESC), 2) AS chi_phi_luy_ke
FROM theo_ngay
ORDER BY start_date;

-- [mkt-f8-thang-truoc-lay-so-thang-sau] starter
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, COUNT(*) AS so_chien_dich
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT thang, so_chien_dich,
       LEAD(so_chien_dich) OVER (ORDER BY thang) AS so_chien_dich_thang_truoc
FROM theo_thang
ORDER BY thang;

-- [mkt-f8-thang-truoc-lay-so-thang-sau] solution
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, COUNT(*) AS so_chien_dich
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT thang, so_chien_dich,
       LAG(so_chien_dich) OVER (ORDER BY thang) AS so_chien_dich_thang_truoc
FROM theo_thang
ORDER BY thang;

-- [mkt-f8-thang-truoc-lay-so-thang-sau] wrong: lag_sap_theo_so_chien_dich
-- Đổi sang LAG nhưng sắp trong OVER theo số chiến dịch thay vì theo tháng: "tháng trước" là tháng có số chiến dịch liền dưới (rớt ở public).
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, COUNT(*) AS so_chien_dich
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT thang, so_chien_dich,
       LAG(so_chien_dich) OVER (ORDER BY so_chien_dich) AS so_chien_dich_thang_truoc
FROM theo_thang
ORDER BY thang;

-- [mkt-f8-thang-truoc-lay-so-thang-sau] wrong: lag_hai_thang
-- Đổi sang LAG nhưng ghi độ lệch 2: lấy số của hai tháng trước (rớt ở public).
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, COUNT(*) AS so_chien_dich
  FROM campaigns
  WHERE brand_id = 3 AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT thang, so_chien_dich,
       LAG(so_chien_dich, 2) OVER (ORDER BY thang) AS so_chien_dich_thang_truoc
FROM theo_thang
ORDER BY thang;

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
