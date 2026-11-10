-- solution.sql: gói 5 của bộ Marketing (dulieu=mkt), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: sai kết quả; optimize: đúng nhưng vi phạm ràng buộc)
--   -- [ma-cau] wrong: ten_loi    bài sai hay gặp
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Phạm vi: Module 9 Data Quality (k1-k9), Module 10 Query Performance (p1-p9), case Khó c9, c10.

-- ======================================================================= MODULE 9 · DATA QUALITY

-- [mkt-k1-ho-so-null] solution
SELECT b.brand_name,
       COUNT(*) AS so_dong,
       SUM(r.impressions IS NULL) AS thieu_impressions,
       SUM(r.clicks IS NULL) AS thieu_clicks,
       SUM(r.leads IS NULL) AS thieu_leads,
       SUM(r.conversions IS NULL) AS thieu_conversions,
       SUM(r.revenue IS NULL) AS thieu_revenue,
       SUM(r.acquisition_cost IS NULL) AS thieu_acquisition_cost
FROM campaigns_raw r
JOIN brands b ON b.brand_id = r.brand_id
GROUP BY b.brand_id, b.brand_name
ORDER BY b.brand_id;

-- [mkt-k1-ho-so-null] wrong: count_cot_dem_o_co_gia_tri
SELECT b.brand_name,
       COUNT(*) AS so_dong,
       COUNT(r.impressions) AS thieu_impressions,
       COUNT(r.clicks) AS thieu_clicks,
       COUNT(r.leads) AS thieu_leads,
       COUNT(r.conversions) AS thieu_conversions,
       COUNT(r.revenue) AS thieu_revenue,
       COUNT(r.acquisition_cost) AS thieu_acquisition_cost
FROM campaigns_raw r
JOIN brands b ON b.brand_id = r.brand_id
GROUP BY b.brand_id, b.brand_name
ORDER BY b.brand_id;

-- [mkt-k1-ho-so-null] wrong: dem_tren_nhat_ky_thay_ban_tho
SELECT b.brand_name,
       COUNT(*) AS so_dong,
       COUNT(CASE WHEN n.column_name = 'Impressions' THEN 1 END) AS thieu_impressions,
       COUNT(CASE WHEN n.column_name = 'Clicks' THEN 1 END) AS thieu_clicks,
       COUNT(CASE WHEN n.column_name = 'Leads' THEN 1 END) AS thieu_leads,
       COUNT(CASE WHEN n.column_name = 'Conversions' THEN 1 END) AS thieu_conversions,
       COUNT(CASE WHEN n.column_name = 'Revenue' THEN 1 END) AS thieu_revenue,
       COUNT(CASE WHEN n.column_name = 'Acquisition_Cost' THEN 1 END) AS thieu_acquisition_cost
FROM noise_log n
JOIN brands b ON b.brand_id = n.brand_id
WHERE n.noise_type = 'NULL'
GROUP BY b.brand_id, b.brand_name
ORDER BY b.brand_id;

-- [mkt-k2-dong-trung-hoan-toan] solution
WITH nhom AS (
  SELECT brand_id, revenue, COUNT(*) AS so_ban
  FROM campaigns_raw
  GROUP BY brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
           impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
           `language`, engagement_score, customer_segment, date_raw
  HAVING COUNT(*) > 1
)
SELECT brand_id,
       SUM(so_ban - 1) AS so_dong_thua,
       SUM((so_ban - 1) * revenue) AS doanh_thu_thua
FROM nhom
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k2-dong-trung-hoan-toan] wrong: dem_ca_dong_goc
WITH nhom AS (
  SELECT brand_id, revenue, COUNT(*) AS so_ban
  FROM campaigns_raw
  GROUP BY brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
           impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
           `language`, engagement_score, customer_segment, date_raw
  HAVING COUNT(*) > 1
)
SELECT brand_id,
       SUM(so_ban) AS so_dong_thua,
       SUM(so_ban * revenue) AS doanh_thu_thua
FROM nhom
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k2-dong-trung-hoan-toan] wrong: gom_ca_cot_vi_tri
WITH nhom AS (
  SELECT brand_id, revenue, COUNT(*) AS so_ban
  FROM campaigns_raw
  GROUP BY raw_id, row_index, brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
           impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
           `language`, engagement_score, customer_segment, date_raw
  HAVING COUNT(*) > 1
)
SELECT brand_id,
       SUM(so_ban - 1) AS so_dong_thua,
       SUM((so_ban - 1) * revenue) AS doanh_thu_thua
FROM nhom
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k2-dong-trung-hoan-toan] wrong: dem_nhom_thay_dong_thua
WITH nhom AS (
  SELECT brand_id, revenue, COUNT(*) AS so_ban
  FROM campaigns_raw
  GROUP BY brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
           impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
           `language`, engagement_score, customer_segment, date_raw
  HAVING COUNT(*) > 1
)
SELECT brand_id,
       COUNT(*) AS so_dong_thua,
       SUM(revenue) AS doanh_thu_thua
FROM nhom
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k3-pheu-vo-ly] solution
SELECT brand_id,
       COUNT(CASE WHEN clicks > impressions THEN 1 END) AS nhap_vuot_hien_thi,
       COUNT(CASE WHEN clicks > impressions AND impressions < 0 THEN 1 END) AS trong_do_hien_thi_am,
       COUNT(CASE WHEN leads > clicks THEN 1 END) AS khtn_vuot_nhap,
       COUNT(CASE WHEN conversions > leads THEN 1 END) AS chuyen_doi_vuot_khtn
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k3-pheu-vo-ly] wrong: count_dem_ca_so_sanh_sai
SELECT brand_id,
       COUNT(clicks > impressions) AS nhap_vuot_hien_thi,
       COUNT(clicks > impressions AND impressions < 0) AS trong_do_hien_thi_am,
       COUNT(leads > clicks) AS khtn_vuot_nhap,
       COUNT(conversions > leads) AS chuyen_doi_vuot_khtn
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k3-pheu-vo-ly] wrong: bo_dong_hien_thi_am
SELECT brand_id,
       COUNT(CASE WHEN clicks > impressions AND impressions >= 0 THEN 1 END) AS nhap_vuot_hien_thi,
       COUNT(CASE WHEN clicks > impressions AND impressions < 0 THEN 1 END) AS trong_do_hien_thi_am,
       COUNT(CASE WHEN leads > clicks THEN 1 END) AS khtn_vuot_nhap,
       COUNT(CASE WHEN conversions > leads THEN 1 END) AS chuyen_doi_vuot_khtn
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-k4-phan-loai-ngay-loi] solution
WITH phan_loai AS (
  SELECT CASE
           WHEN date_raw IS NULL OR TRIM(date_raw) = '' THEN 'trong'
           WHEN date_raw NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN 'sai_dinh_dang'
           WHEN STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL THEN 'khong_ton_tai'
           WHEN STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
             OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01' THEN 'ngoai_ky'
           ELSE 'hop_le'
         END AS loai_ngay
  FROM campaigns_raw
)
SELECT loai_ngay, COUNT(*) AS so_dong
FROM phan_loai
GROUP BY loai_ngay
ORDER BY so_dong DESC, loai_ngay;

-- [mkt-k4-phan-loai-ngay-loi] wrong: chi_xet_doc_duoc_hay_khong
WITH phan_loai AS (
  SELECT CASE
           WHEN date_raw IS NULL OR TRIM(date_raw) = '' THEN 'trong'
           WHEN date_raw NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN 'sai_dinh_dang'
           WHEN STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL THEN 'khong_ton_tai'
           ELSE 'hop_le'
         END AS loai_ngay
  FROM campaigns_raw
)
SELECT loai_ngay, COUNT(*) AS so_dong
FROM phan_loai
GROUP BY loai_ngay
ORDER BY so_dong DESC, loai_ngay;

-- [mkt-k4-phan-loai-ngay-loi] wrong: sai_thu_tu_nhanh_case
WITH phan_loai AS (
  SELECT CASE
           WHEN date_raw IS NULL OR TRIM(date_raw) = '' THEN 'trong'
           WHEN STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL THEN 'khong_ton_tai'
           WHEN date_raw NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN 'sai_dinh_dang'
           WHEN STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
             OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01' THEN 'ngoai_ky'
           ELSE 'hop_le'
         END AS loai_ngay
  FROM campaigns_raw
)
SELECT loai_ngay, COUNT(*) AS so_dong
FROM phan_loai
GROUP BY loai_ngay
ORDER BY so_dong DESC, loai_ngay;

-- [mkt-k5-doi-soat-doanh-thu-tho-sach] solution
WITH tho AS (
  SELECT DISTINCT brand_id, campaign_id, revenue
  FROM campaigns_raw
  WHERE revenue >= 0
),
tong_tho AS (
  SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
  FROM tho
  GROUP BY brand_id
),
tong_sach AS (
  SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
  FROM campaigns
  GROUP BY brand_id
)
SELECT s.brand_id,
       s.doanh_thu AS dt_ban_sach,
       t.doanh_thu AS dt_tho_lam_sach,
       s.doanh_thu - t.doanh_thu AS chenh_lech,
       s.so_chien_dich - t.so_chien_dich AS so_chien_dich_bi_loai
FROM tong_sach s
JOIN tong_tho t ON t.brand_id = s.brand_id
ORDER BY s.brand_id;

-- [mkt-k5-doi-soat-doanh-thu-tho-sach] wrong: quen_bo_dong_trung
WITH tho AS (
  SELECT brand_id, campaign_id, revenue
  FROM campaigns_raw
  WHERE revenue >= 0
),
tong_tho AS (
  SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
  FROM tho
  GROUP BY brand_id
),
tong_sach AS (
  SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
  FROM campaigns
  GROUP BY brand_id
)
SELECT s.brand_id,
       s.doanh_thu AS dt_ban_sach,
       t.doanh_thu AS dt_tho_lam_sach,
       s.doanh_thu - t.doanh_thu AS chenh_lech,
       s.so_chien_dich - t.so_chien_dich AS so_chien_dich_bi_loai
FROM tong_sach s
JOIN tong_tho t ON t.brand_id = s.brand_id
ORDER BY s.brand_id;

-- [mkt-k5-doi-soat-doanh-thu-tho-sach] wrong: giu_doanh_thu_am
WITH tho AS (
  SELECT DISTINCT brand_id, campaign_id, revenue
  FROM campaigns_raw
  WHERE revenue IS NOT NULL
),
tong_tho AS (
  SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
  FROM tho
  GROUP BY brand_id
),
tong_sach AS (
  SELECT brand_id, COUNT(*) AS so_chien_dich, SUM(revenue) AS doanh_thu
  FROM campaigns
  GROUP BY brand_id
)
SELECT s.brand_id,
       s.doanh_thu AS dt_ban_sach,
       t.doanh_thu AS dt_tho_lam_sach,
       s.doanh_thu - t.doanh_thu AS chenh_lech,
       s.so_chien_dich - t.so_chien_dich AS so_chien_dich_bi_loai
FROM tong_sach s
JOIN tong_tho t ON t.brand_id = s.brand_id
ORDER BY s.brand_id;

-- [mkt-k6-do-chinh-xac-quy-tac] solution
WITH luat AS (
  SELECT brand_id, row_index, 'NULL' AS loai FROM campaigns_raw
  WHERE impressions IS NULL OR clicks IS NULL OR leads IS NULL
     OR conversions IS NULL OR revenue IS NULL OR acquisition_cost IS NULL
  UNION ALL
  SELECT brand_id, row_index, 'NEGATIVE' FROM campaigns_raw
  WHERE impressions < 0 OR revenue < 0
  UNION ALL
  SELECT brand_id, row_index, 'FUNNEL_ERROR' FROM campaigns_raw
  WHERE clicks > impressions OR leads > clicks OR conversions > leads
  UNION ALL
  SELECT brand_id, row_index, 'WHITESPACE' FROM campaigns_raw
  WHERE campaign_type <> TRIM(campaign_type) OR target_audience <> TRIM(target_audience)
     OR `language` <> TRIM(`language`) OR customer_segment <> TRIM(customer_segment)
  UNION ALL
  SELECT brand_id, row_index, 'INVALID_DATE' FROM campaigns_raw
  WHERE date_raw IS NULL
     OR date_raw NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01'
),
nhat_ky AS (
  SELECT DISTINCT brand_id, row_index, noise_type AS loai
  FROM noise_log
  WHERE noise_type <> 'DUPLICATE'
),
gop AS (
  SELECT loai, brand_id, row_index, 1 AS tu_luat, 0 AS tu_nhat_ky FROM luat
  UNION ALL
  SELECT loai, brand_id, row_index, 0, 1 FROM nhat_ky
),
theo_dong AS (
  SELECT loai, brand_id, row_index,
         MAX(tu_luat) AS luat_bat, MAX(tu_nhat_ky) AS co_nhat_ky
  FROM gop
  GROUP BY loai, brand_id, row_index
)
SELECT loai AS loai_nhieu,
       SUM(luat_bat) AS so_dong_luat_bat,
       SUM(co_nhat_ky) AS so_dong_nhat_ky,
       SUM(luat_bat * co_nhat_ky) AS so_bat_dung,
       ROUND(100 * SUM(luat_bat * co_nhat_ky) / SUM(luat_bat), 2) AS ty_le_dung_pct,
       ROUND(100 * (SUM(co_nhat_ky) - SUM(luat_bat * co_nhat_ky)) / SUM(co_nhat_ky), 2) AS ty_le_bo_sot_pct
FROM theo_dong
GROUP BY loai
ORDER BY loai_nhieu;

-- [mkt-k6-do-chinh-xac-quy-tac] wrong: noi_chi_theo_row_index
WITH luat AS (
  SELECT brand_id, row_index, 'NULL' AS loai FROM campaigns_raw
  WHERE impressions IS NULL OR clicks IS NULL OR leads IS NULL
     OR conversions IS NULL OR revenue IS NULL OR acquisition_cost IS NULL
  UNION ALL
  SELECT brand_id, row_index, 'NEGATIVE' FROM campaigns_raw
  WHERE impressions < 0 OR revenue < 0
  UNION ALL
  SELECT brand_id, row_index, 'FUNNEL_ERROR' FROM campaigns_raw
  WHERE clicks > impressions OR leads > clicks OR conversions > leads
  UNION ALL
  SELECT brand_id, row_index, 'WHITESPACE' FROM campaigns_raw
  WHERE campaign_type <> TRIM(campaign_type) OR target_audience <> TRIM(target_audience)
     OR `language` <> TRIM(`language`) OR customer_segment <> TRIM(customer_segment)
  UNION ALL
  SELECT brand_id, row_index, 'INVALID_DATE' FROM campaigns_raw
  WHERE date_raw IS NULL
     OR date_raw NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') < '2024-07-01'
     OR STR_TO_DATE(date_raw, '%d-%m-%Y') >= '2025-07-01'
),
nhat_ky AS (
  SELECT brand_id, row_index, noise_type AS loai
  FROM noise_log
  WHERE noise_type <> 'DUPLICATE'
),
bat AS (
  SELECT l.loai, COUNT(*) AS so_dong_luat_bat, COUNT(n.row_index) AS so_bat_dung
  FROM luat l
  LEFT JOIN nhat_ky n ON n.row_index = l.row_index AND n.loai = l.loai
  GROUP BY l.loai
),
ghi AS (
  SELECT loai, COUNT(*) AS so_dong_nhat_ky FROM nhat_ky GROUP BY loai
)
SELECT b.loai AS loai_nhieu, b.so_dong_luat_bat, g.so_dong_nhat_ky, b.so_bat_dung,
       ROUND(100 * b.so_bat_dung / b.so_dong_luat_bat, 2) AS ty_le_dung_pct,
       ROUND(100 * (g.so_dong_nhat_ky - b.so_bat_dung) / g.so_dong_nhat_ky, 2) AS ty_le_bo_sot_pct
FROM bat b
JOIN ghi g ON g.loai = b.loai
ORDER BY loai_nhieu;

-- [mkt-k6-do-chinh-xac-quy-tac] wrong: quy_tac_ngay_bo_nhanh_ngoai_ky
WITH luat AS (
  SELECT brand_id, row_index, 'NULL' AS loai FROM campaigns_raw
  WHERE impressions IS NULL OR clicks IS NULL OR leads IS NULL
     OR conversions IS NULL OR revenue IS NULL OR acquisition_cost IS NULL
  UNION ALL
  SELECT brand_id, row_index, 'NEGATIVE' FROM campaigns_raw
  WHERE impressions < 0 OR revenue < 0
  UNION ALL
  SELECT brand_id, row_index, 'FUNNEL_ERROR' FROM campaigns_raw
  WHERE clicks > impressions OR leads > clicks OR conversions > leads
  UNION ALL
  SELECT brand_id, row_index, 'WHITESPACE' FROM campaigns_raw
  WHERE campaign_type <> TRIM(campaign_type) OR target_audience <> TRIM(target_audience)
     OR `language` <> TRIM(`language`) OR customer_segment <> TRIM(customer_segment)
  UNION ALL
  SELECT brand_id, row_index, 'INVALID_DATE' FROM campaigns_raw
  WHERE date_raw IS NULL OR STR_TO_DATE(date_raw, '%d-%m-%Y') IS NULL
),
nhat_ky AS (
  SELECT DISTINCT brand_id, row_index, noise_type AS loai
  FROM noise_log
  WHERE noise_type <> 'DUPLICATE'
),
gop AS (
  SELECT loai, brand_id, row_index, 1 AS tu_luat, 0 AS tu_nhat_ky FROM luat
  UNION ALL
  SELECT loai, brand_id, row_index, 0, 1 FROM nhat_ky
),
theo_dong AS (
  SELECT loai, brand_id, row_index,
         MAX(tu_luat) AS luat_bat, MAX(tu_nhat_ky) AS co_nhat_ky
  FROM gop
  GROUP BY loai, brand_id, row_index
)
SELECT loai AS loai_nhieu,
       SUM(luat_bat) AS so_dong_luat_bat,
       SUM(co_nhat_ky) AS so_dong_nhat_ky,
       SUM(luat_bat * co_nhat_ky) AS so_bat_dung,
       ROUND(100 * SUM(luat_bat * co_nhat_ky) / SUM(luat_bat), 2) AS ty_le_dung_pct,
       ROUND(100 * (SUM(co_nhat_ky) - SUM(luat_bat * co_nhat_ky)) / SUM(co_nhat_ky), 2) AS ty_le_bo_sot_pct
FROM theo_dong
GROUP BY loai
ORDER BY loai_nhieu;

-- [mkt-k7-doi-tuong-tho-le-te] starter
SELECT target_audience AS doi_tuong,
       COUNT(DISTINCT campaign_id) AS so_chien_dich
FROM campaigns_raw
GROUP BY target_audience
ORDER BY doi_tuong;

-- [mkt-k7-doi-tuong-tho-le-te] solution
SELECT TRIM(target_audience) AS doi_tuong,
       COUNT(DISTINCT campaign_id) AS so_chien_dich
FROM campaigns_raw
GROUP BY TRIM(target_audience)
ORDER BY doi_tuong;

-- [mkt-k7-doi-tuong-tho-le-te] wrong: dem_dong_thay_chien_dich
SELECT TRIM(target_audience) AS doi_tuong,
       COUNT(*) AS so_chien_dich
FROM campaigns_raw
GROUP BY TRIM(target_audience)
ORDER BY doi_tuong;

-- [mkt-k7-doi-tuong-tho-le-te] wrong: chi_cat_dau_trai
SELECT LTRIM(target_audience) AS doi_tuong,
       COUNT(DISTINCT campaign_id) AS so_chien_dich
FROM campaigns_raw
GROUP BY LTRIM(target_audience)
ORDER BY doi_tuong;

-- [mkt-k8-nhieu-null-ra-0] starter
SELECT b.brand_name, n.column_name, COUNT(*) AS so_o_trong
FROM noise_log n
JOIN brands b ON b.brand_id = n.brand_id
WHERE n.noise_type IS NULL
GROUP BY b.brand_id, b.brand_name, n.column_name
ORDER BY b.brand_id, n.column_name;

-- [mkt-k8-nhieu-null-ra-0] solution
SELECT b.brand_name, n.column_name, COUNT(*) AS so_o_trong
FROM noise_log n
JOIN brands b ON b.brand_id = n.brand_id
WHERE n.noise_type = 'NULL'
GROUP BY b.brand_id, b.brand_name, n.column_name
ORDER BY b.brand_id, n.column_name;

-- [mkt-k8-nhieu-null-ra-0] wrong: so_sanh_bang_null
SELECT b.brand_name, n.column_name, COUNT(*) AS so_o_trong
FROM noise_log n
JOIN brands b ON b.brand_id = n.brand_id
WHERE n.noise_type = NULL
GROUP BY b.brand_id, b.brand_name, n.column_name
ORDER BY b.brand_id, n.column_name;

-- [mkt-k8-nhieu-null-ra-0] wrong: dem_moi_loai_nhieu
SELECT b.brand_name, n.column_name, COUNT(*) AS so_o_trong
FROM noise_log n
JOIN brands b ON b.brand_id = n.brand_id
WHERE n.noise_type IS NOT NULL
GROUP BY b.brand_id, b.brand_name, n.column_name
ORDER BY b.brand_id, n.column_name;

-- [mkt-k9-doanh-thu-sach-con-trung] starter
WITH tho AS (
  SELECT brand_id, SUM(revenue) AS dt_tho
  FROM campaigns_raw
  WHERE revenue >= 0
  GROUP BY brand_id
),
sach AS (
  SELECT c.brand_id, SUM(c.revenue) AS dt_sach
  FROM campaigns c
  WHERE EXISTS (SELECT 1 FROM campaigns_raw r
                WHERE r.campaign_id = c.campaign_id AND r.revenue >= 0)
  GROUP BY c.brand_id
)
SELECT t.brand_id, t.dt_tho, s.dt_sach, t.dt_tho - s.dt_sach AS chenh_lech
FROM tho t
JOIN sach s ON s.brand_id = t.brand_id
ORDER BY t.brand_id;

-- [mkt-k9-doanh-thu-sach-con-trung] solution
WITH dong AS (
  SELECT DISTINCT brand_id, campaign_id, revenue
  FROM campaigns_raw
  WHERE revenue >= 0
),
tho AS (
  SELECT brand_id, SUM(revenue) AS dt_tho
  FROM dong
  GROUP BY brand_id
),
sach AS (
  SELECT c.brand_id, SUM(c.revenue) AS dt_sach
  FROM campaigns c
  WHERE EXISTS (SELECT 1 FROM campaigns_raw r
                WHERE r.campaign_id = c.campaign_id AND r.revenue >= 0)
  GROUP BY c.brand_id
)
SELECT t.brand_id, t.dt_tho, s.dt_sach, t.dt_tho - s.dt_sach AS chenh_lech
FROM tho t
JOIN sach s ON s.brand_id = t.brand_id
ORDER BY t.brand_id;

-- [mkt-k9-doanh-thu-sach-con-trung] wrong: khu_trung_gia_tri_thay_dong
WITH tho AS (
  SELECT brand_id, SUM(DISTINCT revenue) AS dt_tho
  FROM campaigns_raw
  WHERE revenue >= 0
  GROUP BY brand_id
),
sach AS (
  SELECT c.brand_id, SUM(c.revenue) AS dt_sach
  FROM campaigns c
  WHERE EXISTS (SELECT 1 FROM campaigns_raw r
                WHERE r.campaign_id = c.campaign_id AND r.revenue >= 0)
  GROUP BY c.brand_id
)
SELECT t.brand_id, t.dt_tho, s.dt_sach, t.dt_tho - s.dt_sach AS chenh_lech
FROM tho t
JOIN sach s ON s.brand_id = t.brand_id
ORDER BY t.brand_id;

-- [mkt-k9-doanh-thu-sach-con-trung] wrong: noi_tho_sach_nhan_ca_hai_ve
SELECT r.brand_id, SUM(r.revenue) AS dt_tho, SUM(c.revenue) AS dt_sach,
       SUM(r.revenue) - SUM(c.revenue) AS chenh_lech
FROM campaigns_raw r
JOIN campaigns c ON c.campaign_id = r.campaign_id
WHERE r.revenue >= 0
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- ======================================================================= MODULE 10 · QUERY PERFORMANCE

-- [mkt-p1-ba-chi-so-mot-lan-quet] starter
SELECT b.brand_id,
       (SELECT ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
                     / SUM(c.acquisition_cost * c.conversions), 4)
        FROM campaigns c WHERE c.brand_id = b.brand_id) AS roi,
       (SELECT ROUND(SUM(c.revenue) / SUM(c.acquisition_cost * c.conversions), 4)
        FROM campaigns c WHERE c.brand_id = b.brand_id) AS roas,
       (SELECT ROUND(SUM(c.acquisition_cost * c.conversions) / SUM(c.conversions), 2)
        FROM campaigns c WHERE c.brand_id = b.brand_id) AS cpa
FROM brands b
ORDER BY b.brand_id;

-- [mkt-p1-ba-chi-so-mot-lan-quet] solution
SELECT brand_id,
       ROUND((SUM(revenue) - SUM(acquisition_cost * conversions))
             / SUM(acquisition_cost * conversions), 4) AS roi,
       ROUND(SUM(revenue) / SUM(acquisition_cost * conversions), 4) AS roas,
       ROUND(SUM(acquisition_cost * conversions) / SUM(conversions), 2) AS cpa
FROM campaigns
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-p1-ba-chi-so-mot-lan-quet] wrong: binh_quan_cot_tinh_san
SELECT brand_id,
       ROUND(AVG(roi), 4) AS roi,
       ROUND(AVG(roi) + 1, 4) AS roas,
       ROUND(AVG(acquisition_cost), 2) AS cpa
FROM campaigns
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-p1-ba-chi-so-mot-lan-quet] wrong: ba_cte_noi_lai
WITH a AS (
  SELECT brand_id, SUM(revenue) AS dt FROM campaigns GROUP BY brand_id
),
b AS (
  SELECT brand_id, SUM(acquisition_cost * conversions) AS cp FROM campaigns GROUP BY brand_id
),
c AS (
  SELECT brand_id, SUM(conversions) AS cd FROM campaigns GROUP BY brand_id
)
SELECT a.brand_id,
       ROUND((a.dt - b.cp) / b.cp, 4) AS roi,
       ROUND(a.dt / b.cp, 4) AS roas,
       ROUND(b.cp / c.cd, 2) AS cpa
FROM a
JOIN b ON b.brand_id = a.brand_id
JOIN c ON c.brand_id = a.brand_id
ORDER BY a.brand_id;

-- [mkt-p2-bao-cao-thang-3-theo-loai] starter
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(100 * SUM(clicks) / SUM(impressions), 2) AS ctr_pct
FROM campaigns
WHERE YEAR(start_date) = 2025 AND MONTH(start_date) = 3
GROUP BY type_id
ORDER BY type_id;

-- [mkt-p2-bao-cao-thang-3-theo-loai] solution
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(100 * SUM(clicks) / SUM(impressions), 2) AS ctr_pct
FROM campaigns
WHERE start_date >= '2025-03-01' AND start_date < '2025-04-01'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-p2-bao-cao-thang-3-theo-loai] wrong: van_boc_ham_date_format
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(100 * SUM(clicks) / SUM(impressions), 2) AS ctr_pct
FROM campaigns
WHERE DATE_FORMAT(start_date, '%Y-%m') = '2025-03'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-p2-bao-cao-thang-3-theo-loai] wrong: between_thieu_ngay_cuoi
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu,
       ROUND(100 * SUM(clicks) / SUM(impressions), 2) AS ctr_pct
FROM campaigns
WHERE start_date BETWEEN '2025-03-01' AND '2025-03-30'
GROUP BY type_id
ORDER BY type_id;

-- [mkt-p3-top-3-doanh-thu-moi-thuong-hieu] starter
SELECT *
FROM (
  (SELECT brand_id, campaign_id, revenue FROM campaigns
   WHERE brand_id = 1 ORDER BY revenue DESC, campaign_id LIMIT 3)
  UNION ALL
  (SELECT brand_id, campaign_id, revenue FROM campaigns
   WHERE brand_id = 2 ORDER BY revenue DESC, campaign_id LIMIT 3)
  UNION ALL
  (SELECT brand_id, campaign_id, revenue FROM campaigns
   WHERE brand_id = 3 ORDER BY revenue DESC, campaign_id LIMIT 3)
) t
ORDER BY brand_id, revenue DESC, campaign_id;

-- [mkt-p3-top-3-doanh-thu-moi-thuong-hieu] solution
WITH xep_hang AS (
  SELECT brand_id, campaign_id, revenue,
         ROW_NUMBER() OVER (PARTITION BY brand_id ORDER BY revenue DESC, campaign_id) AS hang
  FROM campaigns
)
SELECT brand_id, campaign_id, revenue
FROM xep_hang
WHERE hang <= 3
ORDER BY brand_id, revenue DESC, campaign_id;

-- [mkt-p3-top-3-doanh-thu-moi-thuong-hieu] wrong: rank_ra_bon_dong_khi_hoa
WITH xep_hang AS (
  SELECT brand_id, campaign_id, revenue,
         RANK() OVER (PARTITION BY brand_id ORDER BY revenue DESC) AS hang
  FROM campaigns
)
SELECT brand_id, campaign_id, revenue
FROM xep_hang
WHERE hang <= 3
ORDER BY brand_id, revenue DESC, campaign_id;

-- [mkt-p3-top-3-doanh-thu-moi-thuong-hieu] wrong: limit_3_toan_bo
SELECT brand_id, campaign_id, revenue
FROM campaigns
ORDER BY revenue DESC, campaign_id
LIMIT 3;

-- [mkt-p4-ctr-kenh-email-whatsapp] starter
WITH nhom AS (
  SELECT t.brand_id, COUNT(*) AS so_chien_dich, SUM(t.clicks) AS nhap, SUM(t.impressions) AS hien_thi
  FROM (SELECT DISTINCT c.campaign_id, c.brand_id, c.clicks, c.impressions
        FROM campaigns c
        JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
        WHERE cc.channel_id IN (1, 5)) t
  GROUP BY t.brand_id
),
chung AS (
  SELECT brand_id, SUM(clicks) AS nhap, SUM(impressions) AS hien_thi
  FROM campaigns
  GROUP BY brand_id
)
SELECT n.brand_id,
       n.so_chien_dich AS so_chien_dich_nhom,
       ROUND(100 * n.nhap / n.hien_thi, 2) AS ctr_nhom_pct,
       ROUND(100 * ch.nhap / ch.hien_thi, 2) AS ctr_chung_pct
FROM nhom n
JOIN chung ch ON ch.brand_id = n.brand_id
ORDER BY n.brand_id;

-- [mkt-p4-ctr-kenh-email-whatsapp] solution
WITH co_danh_dau AS (
  SELECT c.brand_id, c.clicks, c.impressions,
         EXISTS (SELECT 1 FROM campaign_channels cc
                 WHERE cc.campaign_id = c.campaign_id AND cc.channel_id IN (1, 5)) AS co_kenh
  FROM campaigns c
)
SELECT brand_id,
       SUM(co_kenh) AS so_chien_dich_nhom,
       ROUND(100 * SUM(co_kenh * clicks) / SUM(co_kenh * impressions), 2) AS ctr_nhom_pct,
       ROUND(100 * SUM(clicks) / SUM(impressions), 2) AS ctr_chung_pct
FROM co_danh_dau
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-p4-ctr-kenh-email-whatsapp] wrong: noi_khong_khu_trung
SELECT c.brand_id,
       COUNT(cc.campaign_id) AS so_chien_dich_nhom,
       ROUND(100 * SUM(CASE WHEN cc.campaign_id IS NOT NULL THEN c.clicks END)
             / SUM(CASE WHEN cc.campaign_id IS NOT NULL THEN c.impressions END), 2) AS ctr_nhom_pct,
       ROUND(100 * SUM(c.clicks) / SUM(c.impressions), 2) AS ctr_chung_pct
FROM campaigns c
LEFT JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id AND cc.channel_id IN (1, 5)
GROUP BY c.brand_id
ORDER BY c.brand_id;

-- [mkt-p5-dang-chay-moi-ngay-nhanh] starter
SELECT k.cal_date AS ngay,
       (SELECT COUNT(*)
        FROM campaigns c
        WHERE c.start_date <= k.cal_date
          AND DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY) >= k.cal_date) AS so_dang_chay
FROM calendar k
WHERE k.cal_date >= '2025-01-01' AND k.cal_date < '2025-02-01'
ORDER BY k.cal_date;

-- [mkt-p5-dang-chay-moi-ngay-nhanh] solution
WITH ung_vien AS (
  SELECT start_date,
         DATE_ADD(start_date, INTERVAL duration_days - 1 DAY) AS ngay_cuoi
  FROM campaigns
  WHERE start_date >= '2024-12-03' AND start_date < '2025-02-01'
)
SELECT k.cal_date AS ngay, COUNT(u.start_date) AS so_dang_chay
FROM calendar k
LEFT JOIN ung_vien u ON u.start_date <= k.cal_date AND u.ngay_cuoi >= k.cal_date
WHERE k.cal_date >= '2025-01-01' AND k.cal_date < '2025-02-01'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-p5-dang-chay-moi-ngay-nhanh] wrong: ngay_cuoi_thua_mot_ngay
WITH ung_vien AS (
  SELECT start_date,
         DATE_ADD(start_date, INTERVAL duration_days DAY) AS ngay_cuoi
  FROM campaigns
  WHERE start_date >= '2024-12-03' AND start_date < '2025-02-01'
)
SELECT k.cal_date AS ngay, COUNT(u.start_date) AS so_dang_chay
FROM calendar k
LEFT JOIN ung_vien u ON u.start_date <= k.cal_date AND u.ngay_cuoi >= k.cal_date
WHERE k.cal_date >= '2025-01-01' AND k.cal_date < '2025-02-01'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-p5-dang-chay-moi-ngay-nhanh] wrong: can_duoi_theo_tung_ngay
SELECT k.cal_date AS ngay, COUNT(c.campaign_id) AS so_dang_chay
FROM calendar k
LEFT JOIN campaigns c
  ON c.start_date <= k.cal_date
 AND c.start_date >= k.cal_date - INTERVAL 29 DAY
 AND DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY) >= k.cal_date
WHERE k.cal_date >= '2025-01-01' AND k.cal_date < '2025-02-01'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-p6-dong-trung-du-lieu-tho] starter
SELECT b.brand_id, b.campaign_id,
       a.row_index AS row_index_goc,
       b.row_index AS row_index_ban_sao
FROM campaigns_raw a
JOIN campaigns_raw b ON b.campaign_id = a.campaign_id AND b.row_index > a.row_index
WHERE NOT EXISTS (SELECT 1 FROM campaigns_raw c
                  WHERE c.campaign_id = a.campaign_id AND c.row_index < a.row_index)
ORDER BY b.brand_id, b.row_index;

-- [mkt-p6-dong-trung-du-lieu-tho] solution
WITH danh_dau AS (
  SELECT brand_id, campaign_id, row_index,
         MIN(row_index) OVER (PARTITION BY campaign_id) AS row_index_goc
  FROM campaigns_raw
)
SELECT brand_id, campaign_id, row_index_goc, row_index AS row_index_ban_sao
FROM danh_dau
WHERE row_index > row_index_goc
ORDER BY brand_id, row_index_ban_sao;

-- [mkt-p6-dong-trung-du-lieu-tho] wrong: lay_ca_dong_goc
WITH danh_dau AS (
  SELECT brand_id, campaign_id, row_index,
         MIN(row_index) OVER (PARTITION BY campaign_id) AS row_index_goc,
         COUNT(*) OVER (PARTITION BY campaign_id) AS so_ban
  FROM campaigns_raw
)
SELECT brand_id, campaign_id, row_index_goc, row_index AS row_index_ban_sao
FROM danh_dau
WHERE so_ban > 1
ORDER BY brand_id, row_index_ban_sao;

-- [mkt-p7-chien-dich-ngay-8-3-theo-chi-muc] solution
SELECT c.campaign_id, t.type_name, c.revenue, c.roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
WHERE c.brand_id = 2
  AND c.start_date = '2025-03-08'
  AND c.target_audience_id = 4
ORDER BY c.revenue DESC, c.campaign_id;

-- [mkt-p7-chien-dich-ngay-8-3-theo-chi-muc] wrong: nham_cot_phan_khuc
SELECT c.campaign_id, t.type_name, c.revenue, c.roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
WHERE c.brand_id = 2
  AND c.start_date = '2025-03-08'
  AND c.segment_id = 4
ORDER BY c.revenue DESC, c.campaign_id;

-- [mkt-p7-chien-dich-ngay-8-3-theo-chi-muc] wrong: quen_loc_thuong_hieu
SELECT c.campaign_id, t.type_name, c.revenue, c.roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
WHERE c.start_date = '2025-03-08'
  AND c.target_audience_id = 4
ORDER BY c.revenue DESC, c.campaign_id;

-- [mkt-p8-bao-cao-thang-cham-va-sai] starter
SELECT m.thang,
       (SELECT COUNT(*) FROM campaigns c
        WHERE c.start_date >= m.ngay_dau AND c.start_date < m.ngay_dau + INTERVAL 30 DAY) AS so_chien_dich,
       (SELECT SUM(c.revenue) FROM campaigns c
        WHERE c.start_date >= m.ngay_dau AND c.start_date < m.ngay_dau + INTERVAL 30 DAY) AS doanh_thu
FROM (SELECT DATE_FORMAT(cal_date, '%Y-%m') AS thang, MIN(cal_date) AS ngay_dau
      FROM calendar
      WHERE cal_date >= '2024-07-01'
      GROUP BY DATE_FORMAT(cal_date, '%Y-%m')) m
ORDER BY m.thang;

-- [mkt-p8-bao-cao-thang-cham-va-sai] solution
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-p8-bao-cao-thang-cham-va-sai] wrong: thieu_can_tren
SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang,
       COUNT(*) AS so_chien_dich,
       SUM(revenue) AS doanh_thu
FROM campaigns
WHERE start_date >= '2024-07-01'
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY thang;

-- [mkt-p8-bao-cao-thang-cham-va-sai] wrong: thang_30_ngay
SELECT DATE_FORMAT(m.ngay_dau, '%Y-%m') AS thang,
       COUNT(c.campaign_id) AS so_chien_dich,
       SUM(c.revenue) AS doanh_thu
FROM (SELECT MIN(cal_date) AS ngay_dau
      FROM calendar
      WHERE cal_date >= '2024-07-01' AND cal_date < '2025-07-01'
      GROUP BY DATE_FORMAT(cal_date, '%Y-%m')) m
JOIN campaigns c ON c.start_date >= m.ngay_dau AND c.start_date < m.ngay_dau + INTERVAL 30 DAY
GROUP BY m.ngay_dau
ORDER BY thang;

-- [mkt-p9-chi-phi-tich-luy-thuong-hieu] solution
WITH theo_thang AS (
  SELECT brand_id,
         DATE_FORMAT(start_date, '%Y-%m') AS thang,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang,
       ROUND(chi_phi, 2) AS chi_phi,
       ROUND(SUM(chi_phi) OVER (PARTITION BY brand_id ORDER BY thang), 2) AS chi_phi_luy_ke
FROM theo_thang
ORDER BY brand_id, thang;

-- [mkt-p9-chi-phi-tich-luy-thuong-hieu] wrong: quen_chia_theo_thuong_hieu
WITH theo_thang AS (
  SELECT brand_id,
         DATE_FORMAT(start_date, '%Y-%m') AS thang,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-07-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang,
       ROUND(chi_phi, 2) AS chi_phi,
       ROUND(SUM(chi_phi) OVER (ORDER BY brand_id, thang), 2) AS chi_phi_luy_ke
FROM theo_thang
ORDER BY brand_id, thang;

-- [mkt-p9-chi-phi-tich-luy-thuong-hieu] wrong: thieu_can_tren
WITH theo_thang AS (
  SELECT brand_id,
         DATE_FORMAT(start_date, '%Y-%m') AS thang,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2024-07-01'
  GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')
)
SELECT brand_id, thang,
       ROUND(chi_phi, 2) AS chi_phi,
       ROUND(SUM(chi_phi) OVER (PARTITION BY brand_id ORDER BY thang), 2) AS chi_phi_luy_ke
FROM theo_thang
ORDER BY brand_id, thang;

-- ======================================================================= CASE STUDY

-- [mkt-c9-dung-ban-tho-duoc-khong.b1] solution
SELECT brand_id,
       COUNT(*) AS so_dong,
       COUNT(CASE WHEN impressions IS NULL OR clicks IS NULL OR leads IS NULL
                    OR conversions IS NULL OR revenue IS NULL OR acquisition_cost IS NULL
                  THEN 1 END) AS so_dong_thieu,
       ROUND(100 * COUNT(CASE WHEN impressions IS NULL OR clicks IS NULL OR leads IS NULL
                                OR conversions IS NULL OR revenue IS NULL OR acquisition_cost IS NULL
                              THEN 1 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b1] wrong: chi_xet_bon_cot_pheu
SELECT brand_id,
       COUNT(*) AS so_dong,
       COUNT(CASE WHEN impressions IS NULL OR clicks IS NULL OR leads IS NULL OR conversions IS NULL
                  THEN 1 END) AS so_dong_thieu,
       ROUND(100 * COUNT(CASE WHEN impressions IS NULL OR clicks IS NULL OR leads IS NULL OR conversions IS NULL
                              THEN 1 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b2] solution
WITH nhom AS (
  SELECT brand_id, COUNT(*) AS so_ban
  FROM campaigns_raw
  GROUP BY brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
           impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
           `language`, engagement_score, customer_segment, date_raw
  HAVING COUNT(*) > 1
)
SELECT brand_id, SUM(so_ban - 1) AS so_dong_thua
FROM nhom
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b2] wrong: dem_ca_dong_goc
WITH nhom AS (
  SELECT brand_id, COUNT(*) AS so_ban
  FROM campaigns_raw
  GROUP BY brand_id, campaign_id, campaign_type, target_audience, duration, channel_used,
           impressions, clicks, leads, conversions, revenue, acquisition_cost, roi,
           `language`, engagement_score, customer_segment, date_raw
  HAVING COUNT(*) > 1
)
SELECT brand_id, SUM(so_ban) AS so_dong_thua
FROM nhom
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b3] solution
SELECT brand_id,
       COUNT(CASE WHEN impressions < 0 OR revenue < 0 THEN 1 END) AS so_dong_am,
       COUNT(CASE WHEN (clicks > impressions OR leads > clicks OR conversions > leads)
                   AND NOT (impressions < 0 OR revenue < 0) THEN 1 END) AS so_dong_pheu_vo_ly
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b3] wrong: tinh_dong_am_vao_pheu
SELECT brand_id,
       COUNT(CASE WHEN impressions < 0 OR revenue < 0 THEN 1 END) AS so_dong_am,
       COUNT(CASE WHEN clicks > impressions OR leads > clicks OR conversions > leads THEN 1 END) AS so_dong_pheu_vo_ly
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b4] solution
WITH tho AS (
  SELECT brand_id, SUM(revenue) AS dt
  FROM (SELECT DISTINCT brand_id, campaign_id, revenue
        FROM campaigns_raw
        WHERE revenue >= 0) d
  GROUP BY brand_id
),
sach AS (
  SELECT brand_id, SUM(revenue) AS dt
  FROM campaigns
  GROUP BY brand_id
)
SELECT s.brand_id,
       s.dt AS dt_ban_sach,
       t.dt AS dt_tho_lam_sach,
       ROUND(100 * (t.dt - s.dt) / s.dt, 2) AS chenh_lech_pct
FROM sach s
JOIN tho t ON t.brand_id = s.brand_id
ORDER BY s.brand_id;

-- [mkt-c9-dung-ban-tho-duoc-khong.b4] wrong: quen_bo_dong_trung
WITH tho AS (
  SELECT brand_id, SUM(revenue) AS dt
  FROM campaigns_raw
  WHERE revenue >= 0
  GROUP BY brand_id
),
sach AS (
  SELECT brand_id, SUM(revenue) AS dt
  FROM campaigns
  GROUP BY brand_id
)
SELECT s.brand_id,
       s.dt AS dt_ban_sach,
       t.dt AS dt_tho_lam_sach,
       ROUND(100 * (t.dt - s.dt) / s.dt, 2) AS chenh_lech_pct
FROM sach s
JOIN tho t ON t.brand_id = s.brand_id
ORDER BY s.brand_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b1] solution
SELECT t.type_id, t.type_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
GROUP BY t.type_id, t.type_name
ORDER BY roi DESC, t.type_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b1] wrong: binh_quan_cot_roi
SELECT t.type_id, t.type_name,
       COUNT(*) AS so_chien_dich,
       ROUND(AVG(c.roi), 4) AS roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
GROUP BY t.type_id, t.type_name
ORDER BY roi DESC, t.type_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b2] solution
SELECT ch.channel_id, ch.channel_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
GROUP BY ch.channel_id, ch.channel_name
ORDER BY roi DESC, ch.channel_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b2] wrong: chi_lay_kenh_dau_chuoi
SELECT ch.channel_id, ch.channel_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id AND cc.channel_pos = 1
JOIN channels ch ON ch.channel_id = cc.channel_id
GROUP BY ch.channel_id, ch.channel_name
ORDER BY roi DESC, ch.channel_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b3] solution
SELECT t.type_name, a.audience_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
JOIN audiences a ON a.audience_id = c.target_audience_id
GROUP BY t.type_id, t.type_name, a.audience_id, a.audience_name
ORDER BY roi DESC, t.type_id, a.audience_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b3] wrong: nham_vai_phan_khuc
SELECT t.type_name, a.audience_name,
       COUNT(*) AS so_chien_dich,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
JOIN audiences a ON a.audience_id = c.segment_id
GROUP BY t.type_id, t.type_name, a.audience_id, a.audience_name
ORDER BY roi DESC, t.type_id, a.audience_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b4] solution
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, type_id,
         SUM(revenue) AS doanh_thu,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2024-07-01' AND start_date < '2025-06-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m'), type_id
),
so_sanh AS (
  SELECT thang, type_id,
         (doanh_thu - chi_phi) / chi_phi AS roi,
         (SUM(doanh_thu) OVER (PARTITION BY thang) - SUM(chi_phi) OVER (PARTITION BY thang))
           / SUM(chi_phi) OVER (PARTITION BY thang) AS roi_chung
  FROM theo_thang
)
SELECT type_id,
       COUNT(CASE WHEN roi > roi_chung THEN 1 END) AS so_thang_tren_muc_chung,
       ROUND(MIN(roi - roi_chung), 4) AS chenh_thap_nhat,
       ROUND(MAX(roi - roi_chung), 4) AS chenh_cao_nhat
FROM so_sanh
GROUP BY type_id
ORDER BY type_id;

-- [mkt-c10-don-ngan-sach-loai-kenh.b4] wrong: tinh_ca_thang_chua_du
WITH theo_thang AS (
  SELECT DATE_FORMAT(start_date, '%Y-%m') AS thang, type_id,
         SUM(revenue) AS doanh_thu,
         SUM(acquisition_cost * conversions) AS chi_phi
  FROM campaigns
  WHERE start_date >= '2024-07-01'
  GROUP BY DATE_FORMAT(start_date, '%Y-%m'), type_id
),
so_sanh AS (
  SELECT thang, type_id,
         (doanh_thu - chi_phi) / chi_phi AS roi,
         (SUM(doanh_thu) OVER (PARTITION BY thang) - SUM(chi_phi) OVER (PARTITION BY thang))
           / SUM(chi_phi) OVER (PARTITION BY thang) AS roi_chung
  FROM theo_thang
)
SELECT type_id,
       COUNT(CASE WHEN roi > roi_chung THEN 1 END) AS so_thang_tren_muc_chung,
       ROUND(MIN(roi - roi_chung), 4) AS chenh_thap_nhat,
       ROUND(MAX(roi - roi_chung), 4) AS chenh_cao_nhat
FROM so_sanh
GROUP BY type_id
ORDER BY type_id;
