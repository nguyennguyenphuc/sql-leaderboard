-- solution.sql: gói 2 của bộ Marketing (dulieu=mkt), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên mkt (public) và mkt_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.
-- Mã danh mục: brand_id 1 Nykaa, 2 Purplle, 3 Tira Beauty; type_id 1 Email, 2 Influencer, 3 Paid Ads, 4 SEO,
-- 5 Social Media; audience_id 1 College Students, 2 Premium Shoppers, 3 Tier 2 City Customers, 4 Working Women,
-- 5 Youth; language_id 1 Bengali, 2 English, 3 Hindi, 4 Tamil.
-- hidden-1 thêm chiến dịch NY-CMP-56555 (Nykaa, Social Media, College Students, Hindi) ngày 2025-07-01.

-- ================================================ MODULE 3 · STRING & DATE

-- [mkt-s1-social-nykaa-chay-sang-thang-sau] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) > LAST_DAY(start_date) THEN 1 ELSE 0 END) AS so_sang_thang_sau,
       ROUND(SUM(CASE WHEN DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) > LAST_DAY(start_date) THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_sang_thang_sau
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s1-social-nykaa-chay-sang-thang-sau] wrong: quen_tru_1
-- Rớt ở public: ngày bắt đầu cộng thời lượng là ngày sau ngày cuối, nên chiến dịch kết thúc đúng ngày cuối tháng bị tính là chạy sang tháng sau.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN DATE_ADD(start_date, INTERVAL duration_days DAY) > LAST_DAY(start_date) THEN 1 ELSE 0 END) AS so_sang_thang_sau,
       ROUND(SUM(CASE WHEN DATE_ADD(start_date, INTERVAL duration_days DAY) > LAST_DAY(start_date) THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_sang_thang_sau
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s1-social-nykaa-chay-sang-thang-sau] wrong: so_so_thang_bo_nam
-- Rớt ở public: so MONTH() của ngày cuối với ngày bắt đầu; chiến dịch tháng 12 chạy sang tháng 1 có số tháng nhỏ hơn nên tháng 2024-12 ra 0.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN MONTH(DATE_ADD(start_date, INTERVAL duration_days - 1 DAY)) > MONTH(start_date) THEN 1 ELSE 0 END) AS so_sang_thang_sau,
       ROUND(SUM(CASE WHEN MONTH(DATE_ADD(start_date, INTERVAL duration_days - 1 DAY)) > MONTH(start_date) THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_sang_thang_sau
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s1-social-nykaa-chay-sang-thang-sau] wrong: giu_thang_chua_du
-- Rớt ở public: cận trên 1/7/2025 giữ tháng 6/2025 chưa đủ (dữ liệu tới 24/6, không chiến dịch nào chạy sang tháng 7).
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) > LAST_DAY(start_date) THEN 1 ELSE 0 END) AS so_sang_thang_sau,
       ROUND(SUM(CASE WHEN DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) > LAST_DAY(start_date) THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_sang_thang_sau
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s2-ket-thuc-ngay-14-2] solution
SELECT campaign_id, start_date, duration_days,
       DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) AS ngay_cuoi
FROM campaigns
WHERE brand_id = 3
  AND type_id = 2
  AND target_audience_id = 5
  AND DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) = '2025-02-14'
ORDER BY start_date, campaign_id;

-- [mkt-s2-ket-thuc-ngay-14-2] wrong: quen_tru_1
-- Rớt ở public: ngày bắt đầu cộng thời lượng là ngày sau ngày cuối, lệch một ngày.
SELECT campaign_id, start_date, duration_days,
       DATE_ADD(start_date, INTERVAL duration_days DAY) AS ngay_cuoi
FROM campaigns
WHERE brand_id = 3
  AND type_id = 2
  AND target_audience_id = 5
  AND DATE_ADD(start_date, INTERVAL duration_days DAY) = '2025-02-14'
ORDER BY start_date, campaign_id;

-- [mkt-s2-ket-thuc-ngay-14-2] wrong: loc_theo_ngay_bat_dau
-- Rớt ở public: lấy chiến dịch bắt đầu ngày 14/2 thay vì kết thúc ngày 14/2.
SELECT campaign_id, start_date, duration_days,
       DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) AS ngay_cuoi
FROM campaigns
WHERE brand_id = 3
  AND type_id = 2
  AND target_audience_id = 5
  AND start_date = '2025-02-14'
ORDER BY start_date, campaign_id;

-- [mkt-s3-tong-ket-cho-qua-cuoi-tuan] solution
WITH ngay_hop AS (
  SELECT type_id,
         WEEKDAY(DATE_ADD(start_date, INTERVAL duration_days DAY)) AS thu_ngay_sau
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
)
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) AS so_phai_cho,
       ROUND(SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_phai_cho,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 7 - thu_ngay_sau ELSE 0 END) AS tong_ngay_cho
FROM ngay_hop
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s3-tong-ket-cho-qua-cuoi-tuan] wrong: xet_thu_cua_ngay_cuoi
-- Rớt ở public: xét thứ của chính ngày cuối thay vì ngày ngay sau ngày cuối.
WITH ngay_hop AS (
  SELECT type_id,
         WEEKDAY(DATE_ADD(start_date, INTERVAL duration_days - 1 DAY)) AS thu_ngay_sau
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
)
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) AS so_phai_cho,
       ROUND(SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_phai_cho,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 7 - thu_ngay_sau ELSE 0 END) AS tong_ngay_cho
FROM ngay_hop
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s3-tong-ket-cho-qua-cuoi-tuan] wrong: dayofweek_6_7
-- Rớt ở public: DAYOFWEEK đánh 1 = Chủ nhật, 7 = thứ Bảy; (6, 7) là thứ Sáu và thứ Bảy.
WITH ngay_hop AS (
  SELECT type_id,
         DAYOFWEEK(DATE_ADD(start_date, INTERVAL duration_days DAY)) AS thu_ngay_sau
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
)
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN thu_ngay_sau IN (6, 7) THEN 1 ELSE 0 END) AS so_phai_cho,
       ROUND(SUM(CASE WHEN thu_ngay_sau IN (6, 7) THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_phai_cho,
       SUM(CASE WHEN thu_ngay_sau = 7 THEN 2 WHEN thu_ngay_sau = 6 THEN 1 ELSE 0 END) AS tong_ngay_cho
FROM ngay_hop
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s3-tong-ket-cho-qua-cuoi-tuan] wrong: dem_ngay_cho_nguoc
-- Rớt ở public: thứ Bảy tính chờ 1 ngày, Chủ nhật chờ 2 ngày (đếm ngược tới thứ Hai).
WITH ngay_hop AS (
  SELECT type_id,
         WEEKDAY(DATE_ADD(start_date, INTERVAL duration_days DAY)) AS thu_ngay_sau
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
)
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) AS so_phai_cho,
       ROUND(SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_phai_cho,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN thu_ngay_sau - 4 ELSE 0 END) AS tong_ngay_cho
FROM ngay_hop
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s3-tong-ket-cho-qua-cuoi-tuan] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Social Media ngày 1/7/2025 vào số chiến dịch của loại 5.
WITH ngay_hop AS (
  SELECT type_id,
         WEEKDAY(DATE_ADD(start_date, INTERVAL duration_days DAY)) AS thu_ngay_sau
  FROM campaigns
  WHERE start_date >= '2024-07-01'
)
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) AS so_phai_cho,
       ROUND(SUM(CASE WHEN thu_ngay_sau >= 5 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_phai_cho,
       SUM(CASE WHEN thu_ngay_sau >= 5 THEN 7 - thu_ngay_sau ELSE 0 END) AS tong_ngay_cho
FROM ngay_hop
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s4-ba-kenh-youtube-dau] solution
SELECT brand_id,
       COUNT(DISTINCT campaign_id) AS so_chien_dich
FROM campaigns_raw
WHERE channel_used LIKE 'YouTube,%'
  AND LENGTH(channel_used) - LENGTH(REPLACE(channel_used, ',', '')) = 2
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s4-ba-kenh-youtube-dau] wrong: youtube_moi_vi_tri
-- Rớt ở public: lấy cả chuỗi có YouTube ở vị trí thứ hai, thứ ba.
SELECT brand_id,
       COUNT(DISTINCT campaign_id) AS so_chien_dich
FROM campaigns_raw
WHERE channel_used LIKE '%YouTube%'
  AND LENGTH(channel_used) - LENGTH(REPLACE(channel_used, ',', '')) = 2
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s4-ba-kenh-youtube-dau] wrong: dem_dong_co_trung
-- Rớt ở public: COUNT(*) đếm cả dòng trùng của bản thô.
SELECT brand_id,
       COUNT(*) AS so_chien_dich
FROM campaigns_raw
WHERE channel_used LIKE 'YouTube,%'
  AND LENGTH(channel_used) - LENGTH(REPLACE(channel_used, ',', '')) = 2
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s5-ngay-tho-khong-doc-duoc] solution
SELECT brand_id,
       COUNT(*) AS so_dong_ngay_loi
FROM campaigns_raw
WHERE STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
   OR STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
   OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s5-ngay-tho-khong-doc-duoc] wrong: chi_dem_khong_doc_duoc
-- Rớt ở public: bỏ sót '01-01-1999', '15-06-2030' (đọc được nhưng ngoài kỳ).
SELECT brand_id,
       COUNT(*) AS so_dong_ngay_loi
FROM campaigns_raw
WHERE STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s5-ngay-tho-khong-doc-duoc] wrong: not_between_bo_null
-- Rớt ở public: NOT BETWEEN với NULL ra NULL, mất mọi dòng không đọc được.
SELECT brand_id,
       COUNT(*) AS so_dong_ngay_loi
FROM campaigns_raw
WHERE STR_TO_DATE(date_raw, '%d-%m-%Y') NOT BETWEEN '2024-07-01' AND '2025-06-30'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s6-so-duoi-ma-lon-nhat] solution
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       MIN(CAST(SUBSTRING_INDEX(campaign_id, '-', -1) AS UNSIGNED)) AS so_nho_nhat,
       MAX(CAST(SUBSTRING_INDEX(campaign_id, '-', -1) AS UNSIGNED)) AS so_lon_nhat
FROM campaigns
WHERE start_date = '2025-06-24'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s6-so-duoi-ma-lon-nhat] wrong: max_theo_chuoi
-- Rớt ở public: phần số còn là chuỗi nên so theo ký tự ('5403' lớn hơn '38888'), kết quả lại là chuỗi.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       MIN(SUBSTRING_INDEX(campaign_id, '-', -1)) AS so_nho_nhat,
       MAX(SUBSTRING_INDEX(campaign_id, '-', -1)) AS so_lon_nhat
FROM campaigns
WHERE start_date = '2025-06-24'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s6-so-duoi-ma-lon-nhat] wrong: cat_sai_vi_tri
-- Rớt ở public: SUBSTRING_INDEX(..., 1) lấy phần đầu ('NY'), CAST ra 0.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       MIN(CAST(SUBSTRING_INDEX(campaign_id, '-', 1) AS UNSIGNED)) AS so_nho_nhat,
       MAX(CAST(SUBSTRING_INDEX(campaign_id, '-', 1) AS UNSIGNED)) AS so_lon_nhat
FROM campaigns
WHERE start_date = '2025-06-24'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s7-dem-loai-ra-20-nhom] starter
SELECT campaign_type AS loai_chien_dich,
       COUNT(*) AS so_dong
FROM campaigns_raw
GROUP BY campaign_type
ORDER BY loai_chien_dich;

-- [mkt-s7-dem-loai-ra-20-nhom] solution
SELECT TRIM(campaign_type) AS loai_chien_dich,
       COUNT(*) AS so_dong
FROM campaigns_raw
GROUP BY TRIM(campaign_type)
ORDER BY loai_chien_dich;

-- [mkt-s7-dem-loai-ra-20-nhom] wrong: chi_rtrim
-- Rớt ở public: RTRIM chỉ bỏ khoảng trắng cuối, còn các nhóm có khoảng trắng đầu.
SELECT RTRIM(campaign_type) AS loai_chien_dich,
       COUNT(*) AS so_dong
FROM campaigns_raw
GROUP BY RTRIM(campaign_type)
ORDER BY loai_chien_dich;

-- [mkt-s8-tuan-dau-nam-bi-tach-doi] starter
SELECT MIN(start_date) AS tuan_bat_dau,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE start_date >= '2024-12-02' AND start_date < '2025-02-03'
GROUP BY YEAR(start_date), WEEK(start_date, 1)
ORDER BY tuan_bat_dau;

-- [mkt-s8-tuan-dau-nam-bi-tach-doi] solution
SELECT DATE_SUB(start_date, INTERVAL WEEKDAY(start_date) DAY) AS tuan_bat_dau,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE start_date >= '2024-12-02' AND start_date < '2025-02-03'
GROUP BY DATE_SUB(start_date, INTERVAL WEEKDAY(start_date) DAY)
ORDER BY tuan_bat_dau;

-- [mkt-s8-tuan-dau-nam-bi-tach-doi] wrong: yearweek_mac_dinh
-- Rớt ở public: YEARWEEK không ghi chế độ thì tuần bắt đầu từ Chủ nhật; tuần đầu năm không còn tách nhưng mọi tuần lệch một ngày.
SELECT MIN(start_date) AS tuan_bat_dau,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE start_date >= '2024-12-02' AND start_date < '2025-02-03'
GROUP BY YEARWEEK(start_date)
ORDER BY tuan_bat_dau;

-- [mkt-s8-tuan-dau-nam-bi-tach-doi] wrong: lui_theo_dayofweek
-- Rớt ở public: DAYOFWEEK cho Chủ nhật là 1, nên lùi theo DAYOFWEEK ra tuần từ Chủ nhật tới thứ Bảy, mốc là thứ Bảy.
SELECT DATE_SUB(start_date, INTERVAL DAYOFWEEK(start_date) DAY) AS tuan_bat_dau,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE start_date >= '2024-12-02' AND start_date < '2025-02-03'
GROUP BY DATE_SUB(start_date, INTERVAL DAYOFWEEK(start_date) DAY)
ORDER BY tuan_bat_dau;

-- [mkt-s9-dang-chay-dau-thang-lech] starter
SELECT DATE_FORMAT(k.cal_date, '%Y-%m') AS thang,
       COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date < k.cal_date
 AND DATE_ADD(c.start_date, INTERVAL c.duration_days DAY) >= k.cal_date
WHERE DAY(k.cal_date) = 1
  AND k.cal_date >= '2024-08-01'
GROUP BY DATE_FORMAT(k.cal_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s9-dang-chay-dau-thang-lech] solution
SELECT DATE_FORMAT(k.cal_date, '%Y-%m') AS thang,
       COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date <= k.cal_date
 AND DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY) >= k.cal_date
WHERE DAY(k.cal_date) = 1
  AND k.cal_date >= '2024-08-01' AND k.cal_date <= '2025-06-01'
GROUP BY DATE_FORMAT(k.cal_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s9-dang-chay-dau-thang-lech] wrong: chi_sua_ngay_cuoi
-- Rớt ở public: vẫn bỏ chiến dịch bắt đầu đúng ngày 1 của tháng.
SELECT DATE_FORMAT(k.cal_date, '%Y-%m') AS thang,
       COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date < k.cal_date
 AND DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY) >= k.cal_date
WHERE DAY(k.cal_date) = 1
  AND k.cal_date >= '2024-08-01' AND k.cal_date <= '2025-06-01'
GROUP BY DATE_FORMAT(k.cal_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s9-dang-chay-dau-thang-lech] wrong: chi_sua_ngay_bat_dau
-- Rớt ở public: vẫn đếm chiến dịch đã kết thúc ngày cuối của tháng trước.
SELECT DATE_FORMAT(k.cal_date, '%Y-%m') AS thang,
       COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date <= k.cal_date
 AND DATE_ADD(c.start_date, INTERVAL c.duration_days DAY) >= k.cal_date
WHERE DAY(k.cal_date) = 1
  AND k.cal_date >= '2024-08-01' AND k.cal_date <= '2025-06-01'
GROUP BY DATE_FORMAT(k.cal_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s9-dang-chay-dau-thang-lech] wrong: sua_hai_bien_thieu_can_tren
-- Rớt ở hidden-1: lịch có thêm ngày 1/7/2025 và chiến dịch bắt đầu ngày đó, thêm dòng 2025-07.
SELECT DATE_FORMAT(k.cal_date, '%Y-%m') AS thang,
       COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date <= k.cal_date
 AND DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY) >= k.cal_date
WHERE DAY(k.cal_date) = 1
  AND k.cal_date >= '2024-08-01'
GROUP BY DATE_FORMAT(k.cal_date, '%Y-%m')
ORDER BY thang;

-- ================================================ MODULE 4 · AGGREGATION

-- [mkt-a1-chi-phi-cho-chien-dich-lo] solution
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN revenue < acquisition_cost * conversions THEN 1 ELSE 0 END) AS so_chien_dich_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost * conversions ELSE 0 END) * 100
             / SUM(acquisition_cost * conversions), 2) AS ty_trong_chi_phi_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN revenue ELSE 0 END) * 100
             / SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost * conversions ELSE 0 END), 2) AS ty_le_thu_hoi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-chi-phi-cho-chien-dich-lo] wrong: lo_theo_cot_roi_lam_tron
-- Rớt ở public: roi < 0 bỏ sót chiến dịch lỗ rất ít mà cột roi (làm tròn 2 chữ số) ghi 0,00.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN roi < 0 THEN 1 ELSE 0 END) AS so_chien_dich_lo,
       ROUND(SUM(CASE WHEN roi < 0 THEN acquisition_cost * conversions ELSE 0 END) * 100
             / SUM(acquisition_cost * conversions), 2) AS ty_trong_chi_phi_lo,
       ROUND(SUM(CASE WHEN roi < 0 THEN revenue ELSE 0 END) * 100
             / SUM(CASE WHEN roi < 0 THEN acquisition_cost * conversions ELSE 0 END), 2) AS ty_le_thu_hoi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-chi-phi-cho-chien-dich-lo] wrong: chi_phi_la_cpa
-- Rớt ở public: xác định lỗ đúng nhưng cộng acquisition_cost (CPA) làm chi phí chiến dịch.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN revenue < acquisition_cost * conversions THEN 1 ELSE 0 END) AS so_chien_dich_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost ELSE 0 END) * 100
             / SUM(acquisition_cost), 2) AS ty_trong_chi_phi_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN revenue ELSE 0 END) * 100
             / SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost ELSE 0 END), 2) AS ty_le_thu_hoi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-chi-phi-cho-chien-dich-lo] wrong: ty_trong_theo_so_chien_dich
-- Rớt ở public: tỷ trọng tính theo số chiến dịch lỗ, không theo chi phí.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN revenue < acquisition_cost * conversions THEN 1 ELSE 0 END) AS so_chien_dich_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_trong_chi_phi_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN revenue ELSE 0 END) * 100
             / SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost * conversions ELSE 0 END), 2) AS ty_le_thu_hoi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-chi-phi-cho-chien-dich-lo] wrong: thu_hoi_binh_quan_gian_don
-- Rớt ở public: bình quân tỷ lệ thu hồi của từng chiến dịch lỗ, không phải tổng doanh thu chia tổng chi phí của nhóm.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN revenue < acquisition_cost * conversions THEN 1 ELSE 0 END) AS so_chien_dich_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost * conversions ELSE 0 END) * 100
             / SUM(acquisition_cost * conversions), 2) AS ty_trong_chi_phi_lo,
       ROUND(AVG(CASE WHEN revenue < acquisition_cost * conversions THEN revenue * 100 / (acquisition_cost * conversions) END), 2) AS ty_le_thu_hoi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-chi-phi-cho-chien-dich-lo] wrong: thieu_can_tren
-- Rớt ở hidden-1: Nykaa thêm chiến dịch ngày 1/7/2025 vào số chiến dịch.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN revenue < acquisition_cost * conversions THEN 1 ELSE 0 END) AS so_chien_dich_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost * conversions ELSE 0 END) * 100
             / SUM(acquisition_cost * conversions), 2) AS ty_trong_chi_phi_lo,
       ROUND(SUM(CASE WHEN revenue < acquisition_cost * conversions THEN revenue ELSE 0 END) * 100
             / SUM(CASE WHEN revenue < acquisition_cost * conversions THEN acquisition_cost * conversions ELSE 0 END), 2) AS ty_le_thu_hoi
FROM campaigns
WHERE start_date >= '2024-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a2-pheu-theo-loai] solution
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_pct,
       ROUND(SUM(leads) * 100 / SUM(clicks), 2) AS ty_le_khtn_pct,
       ROUND(SUM(conversions) * 100 / SUM(leads), 2) AS ty_le_chuyen_doi_pct
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-a2-pheu-theo-loai] wrong: binh_quan_ty_le
-- Rớt ở public: bình quân giản đơn tỷ lệ của từng chiến dịch.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(AVG(clicks * 100 / impressions), 2) AS ctr_pct,
       ROUND(AVG(leads * 100 / clicks), 2) AS ty_le_khtn_pct,
       ROUND(AVG(conversions * 100 / leads), 2) AS ty_le_chuyen_doi_pct
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-a2-pheu-theo-loai] wrong: chuyen_doi_chia_luot_nhap
-- Rớt ở public: tỷ lệ chuyển đổi chia cho lượt nhấp, không theo quy ước chia cho khách hàng tiềm năng.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_pct,
       ROUND(SUM(leads) * 100 / SUM(clicks), 2) AS ty_le_khtn_pct,
       ROUND(SUM(conversions) * 100 / SUM(clicks), 2) AS ty_le_chuyen_doi_pct
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-a2-pheu-theo-loai] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Social Media ngày 1/7/2025 vào số chiến dịch của loại 5.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_pct,
       ROUND(SUM(leads) * 100 / SUM(clicks), 2) AS ty_le_khtn_pct,
       ROUND(SUM(conversions) * 100 / SUM(leads), 2) AS ty_le_chuyen_doi_pct
FROM campaigns
WHERE start_date >= '2025-01-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-a3-doi-tuong-quy-1] solution
SELECT target_audience_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
GROUP BY target_audience_id
ORDER BY doanh_thu DESC, target_audience_id;

-- [mkt-a3-doi-tuong-quy-1] wrong: gom_theo_phan_khuc
-- Rớt ở public: segment_id là phân khúc khách hàng, không phải đối tượng mục tiêu.
SELECT segment_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
GROUP BY segment_id
ORDER BY doanh_thu DESC, segment_id;

-- [mkt-a3-doi-tuong-quy-1] wrong: thieu_can_tren
-- Rớt ở public: gộp cả quý 2/2025.
SELECT target_audience_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2025-01-01'
GROUP BY target_audience_id
ORDER BY doanh_thu DESC, target_audience_id;

-- [mkt-a4-bang-cheo-ngon-ngu] solution
SELECT language_id,
       SUM(CASE WHEN brand_id = 1 THEN conversions ELSE 0 END) AS nykaa,
       SUM(CASE WHEN brand_id = 2 THEN conversions ELSE 0 END) AS purplle,
       SUM(CASE WHEN brand_id = 3 THEN conversions ELSE 0 END) AS tira_beauty,
       SUM(conversions) AS tong
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY language_id
ORDER BY language_id;

-- [mkt-a4-bang-cheo-ngon-ngu] wrong: dem_chien_dich
-- Rớt ở public: COUNT đếm số chiến dịch, không cộng lượt chuyển đổi.
SELECT language_id,
       COUNT(CASE WHEN brand_id = 1 THEN conversions END) AS nykaa,
       COUNT(CASE WHEN brand_id = 2 THEN conversions END) AS purplle,
       COUNT(CASE WHEN brand_id = 3 THEN conversions END) AS tira_beauty,
       COUNT(*) AS tong
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY language_id
ORDER BY language_id;

-- [mkt-a4-bang-cheo-ngon-ngu] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Nykaa tiếng Hindi ngày 1/7/2025 vào ô Hindi × Nykaa.
SELECT language_id,
       SUM(CASE WHEN brand_id = 1 THEN conversions ELSE 0 END) AS nykaa,
       SUM(CASE WHEN brand_id = 2 THEN conversions ELSE 0 END) AS purplle,
       SUM(CASE WHEN brand_id = 3 THEN conversions ELSE 0 END) AS tira_beauty,
       SUM(conversions) AS tong
FROM campaigns
WHERE start_date >= '2024-07-01'
GROUP BY language_id
ORDER BY language_id;

-- [mkt-a5-ngay-tren-350-co-lai] solution
SELECT start_date,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN roi > 0 THEN 1 ELSE 0 END) AS so_chien_dich_lai
FROM campaigns
WHERE start_date >= '2025-03-01' AND start_date < '2025-04-01'
GROUP BY start_date
HAVING SUM(CASE WHEN roi > 0 THEN 1 ELSE 0 END) > 350
ORDER BY start_date;

-- [mkt-a5-ngay-tren-350-co-lai] wrong: loc_lai_o_where
-- Rớt ở public: lọc roi > 0 ở WHERE làm cột so_chien_dich chỉ còn chiến dịch có lãi.
SELECT start_date,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN roi > 0 THEN 1 ELSE 0 END) AS so_chien_dich_lai
FROM campaigns
WHERE start_date >= '2025-03-01' AND start_date < '2025-04-01'
  AND roi > 0
GROUP BY start_date
HAVING COUNT(*) > 350
ORDER BY start_date;

-- [mkt-a5-ngay-tren-350-co-lai] wrong: having_dem_tat_ca
-- Rớt ở public: HAVING xét tổng số chiến dịch, không xét số chiến dịch có lãi.
SELECT start_date,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN roi > 0 THEN 1 ELSE 0 END) AS so_chien_dich_lai
FROM campaigns
WHERE start_date >= '2025-03-01' AND start_date < '2025-04-01'
GROUP BY start_date
HAVING COUNT(*) > 350
ORDER BY start_date;

-- [mkt-a5-ngay-tren-350-co-lai] wrong: thieu_can_tren
-- Rớt ở public: lấy cả các ngày tháng 4 tới tháng 6/2025.
SELECT start_date,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN roi > 0 THEN 1 ELSE 0 END) AS so_chien_dich_lai
FROM campaigns
WHERE start_date >= '2025-03-01'
GROUP BY start_date
HAVING SUM(CASE WHEN roi > 0 THEN 1 ELSE 0 END) > 350
ORDER BY start_date;

-- [mkt-a6-doanh-thu-nykaa-theo-thang] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(conversions) AS luot_chuyen_doi,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a6-doanh-thu-nykaa-theo-thang] wrong: binh_quan_thay_tong
-- Rớt ở public: AVG ra số bình quân một chiến dịch, không phải tổng của tháng.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       AVG(conversions) AS luot_chuyen_doi,
       AVG(revenue) AS doanh_thu
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a6-doanh-thu-nykaa-theo-thang] wrong: dem_thay_cong
-- Rớt ở public: COUNT(cột) đếm số chiến dịch có giá trị, không cộng số lượt và số tiền.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       COUNT(conversions) AS luot_chuyen_doi,
       COUNT(revenue) AS doanh_thu
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a6-doanh-thu-nykaa-theo-thang] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Nykaa ngày 1/7/2025 thêm dòng 2025-07.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(conversions) AS luot_chuyen_doi,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thang-nykaa-lech-tai-chinh] starter
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost), 2) AS chi_phi,
       ROUND(AVG(roi), 4) AS roi
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2025-01-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thang-nykaa-lech-tai-chinh] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS chi_phi,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thang-nykaa-lech-tai-chinh] wrong: chi_sua_roi
-- Rớt ở public: ROI đã tính từ tổng nhưng cột chi_phi vẫn là tổng CPA.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost), 2) AS chi_phi,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thang-nykaa-lech-tai-chinh] wrong: roi_tu_tong_cpa
-- Rớt ở public: ROI tính từ tổng CPA của cột chi_phi cũ, ra hàng trăm.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost), 2) AS chi_phi,
       ROUND((SUM(revenue) - SUM(acquisition_cost)) / SUM(acquisition_cost), 4) AS roi
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thang-nykaa-lech-tai-chinh] wrong: doanh_thu_chia_chi_phi
-- Rớt ở public: doanh thu chia chi phí là ROAS, lớn hơn ROI đúng 1.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS chi_phi,
       ROUND(SUM(revenue) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2025-01-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thang-nykaa-lech-tai-chinh] wrong: sua_hai_loi_thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Nykaa Social Media ngày 1/7/2025 thêm dòng 2025-07.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS chi_phi,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2025-01-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a8-so-chien-dich-tho-thua] starter
SELECT COUNT(*) AS so_dong,
       COUNT(campaign_id) AS so_chien_dich
FROM campaigns_raw
WHERE brand_id = 3;

-- [mkt-a8-so-chien-dich-tho-thua] solution
SELECT COUNT(*) AS so_dong,
       COUNT(DISTINCT campaign_id) AS so_chien_dich
FROM campaigns_raw
WHERE brand_id = 3;

-- [mkt-a8-so-chien-dich-tho-thua] wrong: distinct_row_index
-- Rớt ở public: row_index khác nhau ở mọi dòng nên vẫn đếm dòng trùng.
SELECT COUNT(*) AS so_dong,
       COUNT(DISTINCT row_index) AS so_chien_dich
FROM campaigns_raw
WHERE brand_id = 3;

-- [mkt-a8-so-chien-dich-tho-thua] wrong: distinct_sai_cot
-- Rớt ở public: COUNT(DISTINCT campaign_type) đếm số loại chiến dịch (có cả biến thể khoảng trắng), không đếm chiến dịch.
SELECT COUNT(*) AS so_dong,
       COUNT(DISTINCT campaign_type) AS so_chien_dich
FROM campaigns_raw
WHERE brand_id = 3;

-- [mkt-a9-doanh-thu-theo-quy-gop-sai] starter
SELECT QUARTER(start_date) AS quy,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01'
GROUP BY QUARTER(start_date)
ORDER BY quy;

-- [mkt-a9-doanh-thu-theo-quy-gop-sai] solution
SELECT YEAR(start_date) AS nam,
       QUARTER(start_date) AS quy,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY YEAR(start_date), QUARTER(start_date)
ORDER BY nam, quy;

-- [mkt-a9-doanh-thu-theo-quy-gop-sai] wrong: them_nam_thieu_can_tren
-- Rớt ở hidden-1: có năm nhưng thiếu cận trên, thêm dòng quý 3/2025.
SELECT YEAR(start_date) AS nam,
       QUARTER(start_date) AS quy,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01'
GROUP BY YEAR(start_date), QUARTER(start_date)
ORDER BY nam, quy;

-- [mkt-a9-doanh-thu-theo-quy-gop-sai] wrong: them_can_tren_thieu_nam
-- Rớt ở public: có cận trên nhưng vẫn gom theo quý không có năm, thiếu cột năm và quý 1 đứng trước quý 3/2024.
SELECT QUARTER(start_date) AS quy,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY QUARTER(start_date)
ORDER BY quy;

-- ================================================ CASE STUDY

-- [mkt-c3-thang-purplle-mo-nhieu-nhat.b1] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       COUNT(DISTINCT start_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT start_date), 2) AS binh_quan_ngay
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c3-thang-purplle-mo-nhieu-nhat.b1] wrong: giu_thang_chua_du
-- Rớt ở public: cận trên 1/7/2025 giữ tháng 6/2025 chưa đủ.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       COUNT(DISTINCT start_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT start_date), 2) AS binh_quan_ngay
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c3-thang-purplle-mo-nhieu-nhat.b1] wrong: chia_31_ngay
-- Rớt ở public: chia mọi tháng cho 31 ngày, tháng 2 và tháng 30 ngày bị kéo xuống.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       COUNT(DISTINCT start_date) AS so_ngay,
       ROUND(COUNT(*) / 31, 2) AS binh_quan_ngay
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-06-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-c4-loai-roi-duoi-muc-chung.b1] solution
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY roi, type_id;

-- [mkt-c4-loai-roi-duoi-muc-chung.b1] wrong: avg_roi
-- Rớt ở public: bình quân giản đơn cột roi.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(AVG(roi), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY roi, type_id;

-- [mkt-c4-loai-roi-duoi-muc-chung.b1] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Social Media ngày 1/7/2025 vào loại 5.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01'
GROUP BY type_id
ORDER BY roi, type_id;

-- [mkt-c4-loai-roi-duoi-muc-chung.b2] solution
SELECT COUNT(*) AS so_chien_dich,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01';

-- [mkt-c4-loai-roi-duoi-muc-chung.b2] wrong: doanh_thu_chia_chi_phi
-- Rớt ở public: tổng doanh thu chia tổng chi phí là ROAS, lớn hơn ROI đúng 1.
SELECT COUNT(*) AS so_chien_dich,
       ROUND(SUM(revenue) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01';

-- [mkt-c4-loai-roi-duoi-muc-chung.b2] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch ngày 1/7/2025 vào số chiến dịch.
SELECT COUNT(*) AS so_chien_dich,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01';
