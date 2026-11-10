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

-- [mkt-s1-social-nykaa-theo-thang] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s1-social-nykaa-theo-thang] wrong: thieu_can_tren
-- Rớt ở hidden-1: thêm dòng 2025-07 của chiến dịch ngày 1/7/2025.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s1-social-nykaa-theo-thang] wrong: ten_thang_chu
-- Rớt ở public: '%M' ra tên tháng tiếng Anh, sắp theo chữ cái (2024-August đứng trước 2024-December).
SELECT DATE_FORMAT(start_date, '%Y-%M') AS thang,
       COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%M')
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

-- [mkt-s3-bat-dau-cuoi-tuan] solution
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN WEEKDAY(start_date) >= 5 THEN 1 ELSE 0 END) AS so_cuoi_tuan,
       ROUND(SUM(CASE WHEN WEEKDAY(start_date) >= 5 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_cuoi_tuan_pct
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s3-bat-dau-cuoi-tuan] wrong: dayofweek_6_7
-- Rớt ở public: DAYOFWEEK đánh 1 = Chủ nhật, 7 = thứ Bảy; (6, 7) là thứ Sáu và thứ Bảy.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN DAYOFWEEK(start_date) IN (6, 7) THEN 1 ELSE 0 END) AS so_cuoi_tuan,
       ROUND(SUM(CASE WHEN DAYOFWEEK(start_date) IN (6, 7) THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_cuoi_tuan_pct
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-s3-bat-dau-cuoi-tuan] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch Social Media ngày 1/7/2025 (thứ Ba) vào mẫu số của loại 5.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(CASE WHEN WEEKDAY(start_date) >= 5 THEN 1 ELSE 0 END) AS so_cuoi_tuan,
       ROUND(SUM(CASE WHEN WEEKDAY(start_date) >= 5 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS ty_le_cuoi_tuan_pct
FROM campaigns
WHERE start_date >= '2024-07-01'
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

-- [mkt-s8-thang-sap-sai-thu-tu] starter
SELECT DATE_FORMAT(start_date, '%m/%Y') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%m/%Y')
ORDER BY thang;

-- [mkt-s8-thang-sap-sai-thu-tu] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-s8-thang-sap-sai-thu-tu] wrong: ten_thang_chu
-- Rớt ở public: '%M' là tên tháng tiếng Anh, sắp theo chữ cái.
SELECT DATE_FORMAT(start_date, '%Y-%M') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%M')
ORDER BY thang;

-- [mkt-s8-thang-sap-sai-thu-tu] wrong: giu_nhan_thang_nam
-- Rớt ở public: sắp đúng nhưng nhãn tháng vẫn dạng MM/YYYY, khác yêu cầu YYYY-MM.
SELECT DATE_FORMAT(start_date, '%m/%Y') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%m/%Y')
ORDER BY MIN(start_date);

-- [mkt-s9-dang-chay-ngay-1-1] starter
SELECT brand_id,
       COUNT(*) AS so_dang_chay
FROM campaigns
WHERE start_date <= '2025-01-01'
  AND DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) > '2025-01-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s9-dang-chay-ngay-1-1] solution
SELECT brand_id,
       COUNT(*) AS so_dang_chay
FROM campaigns
WHERE start_date <= '2025-01-01'
  AND DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) >= '2025-01-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s9-dang-chay-ngay-1-1] wrong: thua_mot_ngay
-- Rớt ở public: quên trừ 1 nên tính cả chiến dịch đã kết thúc ngày 31/12/2024.
SELECT brand_id,
       COUNT(*) AS so_dang_chay
FROM campaigns
WHERE start_date <= '2025-01-01'
  AND DATE_ADD(start_date, INTERVAL duration_days DAY) >= '2025-01-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-s9-dang-chay-ngay-1-1] wrong: chi_bat_dau_ngay_1_1
-- Rớt ở public: chỉ đếm chiến dịch bắt đầu đúng ngày 1/1/2025.
SELECT brand_id,
       COUNT(*) AS so_dang_chay
FROM campaigns
WHERE start_date = '2025-01-01'
GROUP BY brand_id
ORDER BY brand_id;

-- ================================================ MODULE 4 · AGGREGATION

-- [mkt-a1-roi-tong-theo-thuong-hieu] solution
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(SUM(acquisition_cost * conversions), 2) AS chi_phi,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-roi-tong-theo-thuong-hieu] wrong: avg_roi
-- Rớt ở public: bình quân giản đơn cột roi (khoảng 2,69) khác ROI của tổng (khoảng 1,94).
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(SUM(acquisition_cost * conversions), 2) AS chi_phi,
       ROUND(AVG(roi), 4) AS roi
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-a1-roi-tong-theo-thuong-hieu] wrong: thieu_can_tren
-- Rớt ở hidden-1: Nykaa thêm chiến dịch ngày 1/7/2025.
SELECT brand_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(SUM(acquisition_cost * conversions), 2) AS chi_phi,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
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
       SUM(conversions) AS luot_chuyen_doi,
       SUM(revenue) AS doanh_thu,
       ROUND(SUM(revenue) / SUM(conversions), 2) AS gia_tri_don_bq
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a6-doanh-thu-nykaa-theo-thang] wrong: gom_theo_thang_bo_nam
-- Rớt ở hidden-1: gom theo MONTH() bỏ năm, chiến dịch ngày 1/7/2025 cộng vào tháng 7/2024. Trên public trùng lời giải.
SELECT DATE_FORMAT(MIN(start_date), '%Y-%m') AS thang,
       SUM(conversions) AS luot_chuyen_doi,
       SUM(revenue) AS doanh_thu,
       ROUND(SUM(revenue) / SUM(conversions), 2) AS gia_tri_don_bq
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01'
GROUP BY MONTH(start_date)
ORDER BY MIN(start_date);

-- [mkt-a6-doanh-thu-nykaa-theo-thang] wrong: binh_quan_gia_tri_don_tung_chien_dich
-- Rớt ở public: bình quân giản đơn giá trị đơn của từng chiến dịch, khác tổng doanh thu chia tổng lượt chuyển đổi.
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       SUM(conversions) AS luot_chuyen_doi,
       SUM(revenue) AS doanh_thu,
       ROUND(AVG(revenue / conversions), 2) AS gia_tri_don_bq
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-a7-roi-thuong-hieu-cao-bat-thuong] starter
SELECT COUNT(*) AS so_chien_dich,
       ROUND(AVG(roi), 4) AS roi
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-01-01';

-- [mkt-a7-roi-thuong-hieu-cao-bat-thuong] solution
SELECT COUNT(*) AS so_chien_dich,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-01-01';

-- [mkt-a7-roi-thuong-hieu-cao-bat-thuong] wrong: doanh_thu_chia_chi_phi
-- Rớt ở public: doanh thu chia chi phí là ROAS, lớn hơn ROI đúng 1.
SELECT COUNT(*) AS so_chien_dich,
       ROUND(SUM(revenue) / SUM(acquisition_cost * conversions), 4) AS roi
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-01-01';

-- [mkt-a7-roi-thuong-hieu-cao-bat-thuong] wrong: chi_phi_quen_nhan_chuyen_doi
-- Rớt ở public: lấy tổng acquisition_cost (CPA) làm tổng chi phí, ROI ra hàng nghìn.
SELECT COUNT(*) AS so_chien_dich,
       ROUND((SUM(revenue) - SUM(acquisition_cost)) / SUM(acquisition_cost), 4) AS roi
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-07-01' AND start_date < '2025-01-01';

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
