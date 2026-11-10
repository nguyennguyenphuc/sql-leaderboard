-- solution.sql: gói 1 của bộ Marketing (dulieu=mkt), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên mkt (public) và mkt_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.
-- Mã danh mục: brand_id 1 Nykaa, 2 Purplle, 3 Tira Beauty; type_id 1 Email, 2 Influencer, 3 Paid Ads, 4 SEO,
-- 5 Social Media; audience_id 1 College Students, 2 Premium Shoppers, 4 Working Women, 5 Youth; language_id 3 Hindi.

-- ================================================ MODULE 1 · RETRIEVAL

-- [mkt-r1-influencer-purplle-thang-1] solution
SELECT campaign_id, start_date, impressions
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date >= '2025-01-01' AND start_date < '2025-02-01'
  AND impressions > 98000
ORDER BY impressions DESC, campaign_id;

-- [mkt-r1-influencer-purplle-thang-1] wrong: thieu_can_tren
-- Rớt ở public: lấy cả chiến dịch từ tháng 2 tới tháng 6/2025.
SELECT campaign_id, start_date, impressions
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date >= '2025-01-01'
  AND impressions > 98000
ORDER BY impressions DESC, campaign_id;

-- [mkt-r1-influencer-purplle-thang-1] wrong: sap_tang_dan
-- Rớt ở public: đúng tập dòng nhưng sai thứ tự (thutu=co).
SELECT campaign_id, start_date, impressions
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date >= '2025-01-01' AND start_date < '2025-02-01'
  AND impressions > 98000
ORDER BY impressions, campaign_id;

-- [mkt-r2-qua-8-3-tira-ban-tot] solution
SELECT campaign_id, start_date, target_audience_id, duration_days, conversions
FROM campaigns
WHERE brand_id = 3
  AND start_date BETWEEN '2025-03-01' AND '2025-03-08'
  AND target_audience_id IN (2, 4)
  AND duration_days BETWEEN 7 AND 14
  AND conversions >= 2000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r2-qua-8-3-tira-ban-tot] wrong: bo_hai_bien_thoi_luong
-- Rớt ở public: "từ 7 tới 14 ngày" gồm cả hai đầu; > 7 AND < 14 bỏ chiến dịch đúng 7 hoặc
-- 14 ngày (15 dòng so với 19).
SELECT campaign_id, start_date, target_audience_id, duration_days, conversions
FROM campaigns
WHERE brand_id = 3
  AND start_date BETWEEN '2025-03-01' AND '2025-03-08'
  AND target_audience_id IN (2, 4)
  AND duration_days > 7 AND duration_days < 14
  AND conversions >= 2000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r2-qua-8-3-tira-ban-tot] wrong: loc_theo_phan_khuc
-- Rớt ở public: segment_id là phân khúc khách hàng; nhóm chiến dịch nhắm tới nằm ở
-- target_audience_id (13 dòng).
SELECT campaign_id, start_date, target_audience_id, duration_days, conversions
FROM campaigns
WHERE brand_id = 3
  AND start_date BETWEEN '2025-03-01' AND '2025-03-08'
  AND segment_id IN (2, 4)
  AND duration_days BETWEEN 7 AND 14
  AND conversions >= 2000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r2-qua-8-3-tira-ban-tot] wrong: bo_ngay_8_3
-- Rớt ở public: cận trên < '2025-03-08' bỏ chính ngày 8/3 (17 dòng).
SELECT campaign_id, start_date, target_audience_id, duration_days, conversions
FROM campaigns
WHERE brand_id = 3
  AND start_date >= '2025-03-01' AND start_date < '2025-03-08'
  AND target_audience_id IN (2, 4)
  AND duration_days BETWEEN 7 AND 14
  AND conversions >= 2000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r3-10-lo-nang-thue-ngoai-purplle-q4] solution
SELECT campaign_id, type_id, start_date, roi
FROM campaigns
WHERE brand_id = 2
  AND type_id IN (2, 3)
  AND start_date >= '2024-10-01' AND start_date < '2025-01-01'
ORDER BY roi, campaign_id
LIMIT 10;

-- [mkt-r3-10-lo-nang-thue-ngoai-purplle-q4] wrong: hoa_theo_ma_giam_dan
-- Rớt ở public: 5 chiến dịch cùng roi -0,91 ở hạng 10-14; quy tắc hoà ngược chiều lấy
-- PU-CMP-55466 thay PU-CMP-14986.
SELECT campaign_id, type_id, start_date, roi
FROM campaigns
WHERE brand_id = 2
  AND type_id IN (2, 3)
  AND start_date >= '2024-10-01' AND start_date < '2025-01-01'
ORDER BY roi, campaign_id DESC
LIMIT 10;

-- [mkt-r3-10-lo-nang-thue-ngoai-purplle-q4] wrong: moi_loai_chien_dich
-- Rớt ở public: không lọc nhóm thuê ngoài, lẫn chiến dịch Email, SEO, Social Media.
SELECT campaign_id, type_id, start_date, roi
FROM campaigns
WHERE brand_id = 2
  AND start_date >= '2024-10-01' AND start_date < '2025-01-01'
ORDER BY roi, campaign_id
LIMIT 10;

-- [mkt-r3-10-lo-nang-thue-ngoai-purplle-q4] wrong: thieu_can_tren
-- Rớt ở public: xét cả chiến dịch năm 2025.
SELECT campaign_id, type_id, start_date, roi
FROM campaigns
WHERE brand_id = 2
  AND type_id IN (2, 3)
  AND start_date >= '2024-10-01'
ORDER BY roi, campaign_id
LIMIT 10;

-- [mkt-r4-email-chuyen-doi-cao] solution
SELECT campaign_id, brand_id, conversions
FROM campaigns
WHERE type_id = 1
  AND conversions >= 6000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r4-email-chuyen-doi-cao] wrong: nham_loai_voi_kenh_email
-- Rớt ở public: lấy chiến dịch có chạy kênh Email (channel_id = 1), không phải loại
-- Email.
SELECT campaign_id, brand_id, conversions
FROM campaigns
WHERE campaign_id IN (SELECT campaign_id FROM campaign_channels WHERE channel_id = 1)
  AND conversions >= 6000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r4-email-chuyen-doi-cao] wrong: quen_loc_loai
-- Rớt ở public: lấy mọi loại chiến dịch.
SELECT campaign_id, brand_id, conversions
FROM campaigns
WHERE conversions >= 6000
ORDER BY conversions DESC, campaign_id;

-- [mkt-r5-chien-dich-30-ngay-cuoi-ky] solution
SELECT campaign_id, start_date
FROM campaigns
WHERE brand_id = 2
  AND duration_days = 30
  AND start_date >= '2025-05-28'
ORDER BY start_date, campaign_id;

-- [mkt-r5-chien-dich-30-ngay-cuoi-ky] wrong: bo_ngay_dau
-- Rớt ở public: dấu > bỏ mất các chiến dịch bắt đầu đúng ngày 28/5/2025.
SELECT campaign_id, start_date
FROM campaigns
WHERE brand_id = 2
  AND duration_days = 30
  AND start_date > '2025-05-28'
ORDER BY start_date, campaign_id;

-- [mkt-r5-chien-dich-30-ngay-cuoi-ky] wrong: chi_sap_theo_ma
-- Rớt ở public: bỏ cột sắp thứ nhất (start_date).
SELECT campaign_id, start_date
FROM campaigns
WHERE brand_id = 2
  AND duration_days = 30
  AND start_date >= '2025-05-28'
ORDER BY campaign_id;

-- [mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2] solution
SELECT campaign_id, type_id, start_date, duration_days, engagement_score
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  AND target_audience_id = 1
  AND language_id = 3
  AND type_id NOT IN (2, 3)
  AND duration_days >= 14
  AND engagement_score >= 20
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2] wrong: thieu_can_tren
-- Chỉ rớt ở hidden-1: public không có chiến dịch sau 24/6/2025; hidden-1 có NY-CMP-56555
-- (Nykaa, Social Media, sinh viên, Hindi, 21 ngày, điểm 20,98) bắt đầu 1/7/2025.
SELECT campaign_id, type_id, start_date, duration_days, engagement_score
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01'
  AND target_audience_id = 1
  AND language_id = 3
  AND type_id NOT IN (2, 3)
  AND duration_days >= 14
  AND engagement_score >= 20
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2] wrong: loc_theo_phan_khuc
-- Rớt ở public: segment_id là phân khúc khách hàng, không phải nhóm chiến dịch nhắm tới
-- (31 dòng so với 38).
SELECT campaign_id, type_id, start_date, duration_days, engagement_score
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  AND segment_id = 1
  AND language_id = 3
  AND type_id NOT IN (2, 3)
  AND duration_days >= 14
  AND engagement_score >= 20
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2] wrong: giu_noi_dung_thue_ngoai
-- Rớt ở public: không loại Influencer, Paid Ads (nội dung do bên ngoài làm), 62 dòng.
SELECT campaign_id, type_id, start_date, duration_days, engagement_score
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  AND target_audience_id = 1
  AND language_id = 3
  AND duration_days >= 14
  AND engagement_score >= 20
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2] wrong: tren_20_diem
-- Rớt ở public: "từ 20 điểm" gồm điểm đúng 20,00 (NY-CMP-44885).
SELECT campaign_id, type_id, start_date, duration_days, engagement_score
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
  AND target_audience_id = 1
  AND language_id = 3
  AND type_id NOT IN (2, 3)
  AND duration_days >= 14
  AND engagement_score > 20
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r7-paid-ads-ra-rong] starter
SELECT campaign_id, start_date, impressions, clicks
FROM campaigns
WHERE brand_id = 1
  AND type_id = 'Paid Ads'
  AND start_date = '2025-02-14'
ORDER BY campaign_id;

-- [mkt-r7-paid-ads-ra-rong] solution
SELECT campaign_id, start_date, impressions, clicks
FROM campaigns
WHERE brand_id = 1
  AND type_id = 3
  AND start_date = '2025-02-14'
ORDER BY campaign_id;

-- [mkt-r7-paid-ads-ra-rong] wrong: bo_dieu_kien_loai
-- Rớt ở public: xoá điều kiện gây lỗi thay vì sửa, ra mọi loại chiến dịch của Nykaa trong
-- ngày.
SELECT campaign_id, start_date, impressions, clicks
FROM campaigns
WHERE brand_id = 1
  AND start_date = '2025-02-14'
ORDER BY campaign_id;

-- [mkt-r8-thang-2-thieu-ngay-cuoi] starter
SELECT campaign_id, start_date, conversions
FROM campaigns
WHERE brand_id = 3
  AND conversions >= 4000
  AND start_date BETWEEN '2025-02-01' AND '2025-02-27'
ORDER BY start_date, campaign_id;

-- [mkt-r8-thang-2-thieu-ngay-cuoi] solution
SELECT campaign_id, start_date, conversions
FROM campaigns
WHERE brand_id = 3
  AND conversions >= 4000
  AND start_date >= '2025-02-01' AND start_date < '2025-03-01'
ORDER BY start_date, campaign_id;

-- [mkt-r8-thang-2-thieu-ngay-cuoi] wrong: between_toi_ngay_1_3
-- Rớt ở public: BETWEEN lấy cả hai đầu, nên lấy thêm chiến dịch ngày 1/3/2025.
SELECT campaign_id, start_date, conversions
FROM campaigns
WHERE brand_id = 3
  AND conversions >= 4000
  AND start_date BETWEEN '2025-02-01' AND '2025-03-01'
ORDER BY start_date, campaign_id;

-- [mkt-r9-gioi-tre-cuoi-thang-6-thua] starter
SELECT campaign_id, type_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 1
  AND language_id = 3
  AND (type_id <> 1 OR type_id <> 4)
  AND start_date >= '2025-06-16'
  AND target_audience_id = 1 OR target_audience_id = 5
ORDER BY start_date, campaign_id;

-- [mkt-r9-gioi-tre-cuoi-thang-6-thua] solution
SELECT campaign_id, type_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 1
  AND language_id = 3
  AND type_id NOT IN (1, 4)
  AND start_date >= '2025-06-16' AND start_date < '2025-07-01'
  AND (target_audience_id = 1 OR target_audience_id = 5)
ORDER BY start_date, campaign_id;

-- [mkt-r9-gioi-tre-cuoi-thang-6-thua] wrong: quen_can_tren
-- Chỉ rớt ở hidden-1: sửa ngoặc và điều kiện loại nhưng vẫn thiếu cận trên; hidden-1 có
-- NY-CMP-56555
-- (Nykaa, Social Media, sinh viên, Hindi) bắt đầu 1/7/2025.
SELECT campaign_id, type_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 1
  AND language_id = 3
  AND type_id NOT IN (1, 4)
  AND start_date >= '2025-06-16'
  AND (target_audience_id = 1 OR target_audience_id = 5)
ORDER BY start_date, campaign_id;

-- [mkt-r9-gioi-tre-cuoi-thang-6-thua] wrong: giu_or_loai_tru
-- Rớt ở public: (type_id <> 1 OR type_id <> 4) luôn đúng nên vẫn lấy Email và SEO (33
-- dòng so với 17).
SELECT campaign_id, type_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 1
  AND language_id = 3
  AND (type_id <> 1 OR type_id <> 4)
  AND start_date >= '2025-06-16' AND start_date < '2025-07-01'
  AND (target_audience_id = 1 OR target_audience_id = 5)
ORDER BY start_date, campaign_id;

-- [mkt-r9-gioi-tre-cuoi-thang-6-thua] wrong: nham_ma_seo
-- Rớt ở public: loại mã 5 (Social Media) thay vì mã 4 (SEO), 23 dòng.
SELECT campaign_id, type_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 1
  AND language_id = 3
  AND type_id NOT IN (1, 5)
  AND start_date >= '2025-06-16' AND start_date < '2025-07-01'
  AND (target_audience_id = 1 OR target_audience_id = 5)
ORDER BY start_date, campaign_id;

-- ================================================ MODULE 2 · NULL & EXPRESSIONS

-- [mkt-n1-ctr-seo-nykaa-ngay] solution
SELECT campaign_id, impressions, clicks,
       ROUND(clicks * 100 / impressions, 2) AS ctr_pct
FROM campaigns
WHERE brand_id = 1
  AND type_id = 4
  AND start_date = '2025-01-01'
ORDER BY ctr_pct DESC, campaign_id;

-- [mkt-n1-ctr-seo-nykaa-ngay] wrong: quen_nhan_100
-- Rớt ở public: ra tỷ lệ (0,08) thay vì phần trăm (8,37).
SELECT campaign_id, impressions, clicks,
       ROUND(clicks / impressions, 2) AS ctr_pct
FROM campaigns
WHERE brand_id = 1
  AND type_id = 4
  AND start_date = '2025-01-01'
ORDER BY ctr_pct DESC, campaign_id;

-- [mkt-n1-ctr-seo-nykaa-ngay] wrong: lam_tron_truoc_khi_nhan
-- Rớt ở public: làm tròn tỷ lệ 2 chữ số rồi mới nhân 100, mất phần lẻ.
SELECT campaign_id, impressions, clicks,
       ROUND(clicks / impressions, 2) * 100 AS ctr_pct
FROM campaigns
WHERE brand_id = 1
  AND type_id = 4
  AND start_date = '2025-01-01'
ORDER BY ctr_pct DESC, campaign_id;

-- [mkt-n2-thieu-hien-thi-co-nhap] solution
SELECT brand_id, row_index, campaign_id
FROM campaigns_raw
WHERE impressions IS NULL
  AND clicks IS NOT NULL
ORDER BY brand_id, row_index;

-- [mkt-n2-thieu-hien-thi-co-nhap] wrong: so_bang_null
-- Rớt ở public: so sánh = NULL không bao giờ đúng, ra 0 dòng.
SELECT brand_id, row_index, campaign_id
FROM campaigns_raw
WHERE impressions = NULL
  AND clicks IS NOT NULL
ORDER BY brand_id, row_index;

-- [mkt-n2-thieu-hien-thi-co-nhap] wrong: dao_vai_hai_cot
-- Rớt ở public: lấy dòng thiếu lượt nhấp mà có lượt hiển thị.
SELECT brand_id, row_index, campaign_id
FROM campaigns_raw
WHERE impressions IS NOT NULL
  AND clicks IS NULL
ORDER BY brand_id, row_index;

-- [mkt-n3-chi-phi-chien-dich-8-3] solution
SELECT campaign_id, conversions, acquisition_cost,
       ROUND(acquisition_cost * conversions, 2) AS chi_phi,
       revenue
FROM campaigns
WHERE brand_id = 3
  AND type_id = 2
  AND start_date = '2025-03-08'
ORDER BY chi_phi DESC, campaign_id;

-- [mkt-n3-chi-phi-chien-dich-8-3] wrong: coi_cpa_la_chi_phi
-- Rớt ở public: acquisition_cost là chi phí trên một lượt chuyển đổi, không phải tổng chi
-- phí.
SELECT campaign_id, conversions, acquisition_cost,
       acquisition_cost AS chi_phi,
       revenue
FROM campaigns
WHERE brand_id = 3
  AND type_id = 2
  AND start_date = '2025-03-08'
ORDER BY chi_phi DESC, campaign_id;

-- [mkt-n3-chi-phi-chien-dich-8-3] wrong: chi_phi_bang_doanh_thu_chia
-- Rớt ở public: lấy doanh thu chia lượt chuyển đổi (giá trị đơn bình quân) làm chi phí.
SELECT campaign_id, conversions, acquisition_cost,
       ROUND(revenue / conversions, 2) AS chi_phi,
       revenue
FROM campaigns
WHERE brand_id = 3
  AND type_id = 2
  AND start_date = '2025-03-08'
ORDER BY chi_phi DESC, campaign_id;

-- [mkt-n4-nhom-lai-lo-nykaa-quy-2] solution
SELECT CASE WHEN type_id IN (2, 3) AND roi < 0.5 THEN 'xem_lai_hop_dong'
            WHEN roi < 0 THEN 'lo'
            WHEN roi = 0 THEN 'hoa_von'
            ELSE 'co_lai' END AS nhom_roi,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS tong_chi_phi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
GROUP BY nhom_roi
ORDER BY nhom_roi;

-- [mkt-n4-nhom-lai-lo-nykaa-quy-2] wrong: xet_lo_truoc_ngoai_le
-- Rớt ở public: nhánh lỗ đứng trước nhánh xem lại hợp đồng, chiến dịch Influencer, Paid
-- Ads lỗ rơi vào nhóm lỗ.
SELECT CASE WHEN roi < 0 THEN 'lo'
            WHEN type_id IN (2, 3) AND roi < 0.5 THEN 'xem_lai_hop_dong'
            WHEN roi = 0 THEN 'hoa_von'
            ELSE 'co_lai' END AS nhom_roi,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS tong_chi_phi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
GROUP BY nhom_roi
ORDER BY nhom_roi;

-- [mkt-n4-nhom-lai-lo-nykaa-quy-2] wrong: tu_0_5_van_xem_lai
-- Rớt ở public: "dưới 0,5" không gồm ROI đúng 0,50 (5 chiến dịch Influencer, Paid Ads).
SELECT CASE WHEN type_id IN (2, 3) AND roi <= 0.5 THEN 'xem_lai_hop_dong'
            WHEN roi < 0 THEN 'lo'
            WHEN roi = 0 THEN 'hoa_von'
            ELSE 'co_lai' END AS nhom_roi,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS tong_chi_phi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
GROUP BY nhom_roi
ORDER BY nhom_roi;

-- [mkt-n4-nhom-lai-lo-nykaa-quy-2] wrong: chi_phi_la_cpa
-- Rớt ở public: cộng acquisition_cost (chi phí trên một lượt chuyển đổi) thay vì chi phí
-- chiến dịch.
SELECT CASE WHEN type_id IN (2, 3) AND roi < 0.5 THEN 'xem_lai_hop_dong'
            WHEN roi < 0 THEN 'lo'
            WHEN roi = 0 THEN 'hoa_von'
            ELSE 'co_lai' END AS nhom_roi,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost), 2) AS tong_chi_phi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01' AND start_date < '2025-07-01'
GROUP BY nhom_roi
ORDER BY nhom_roi;

-- [mkt-n4-nhom-lai-lo-nykaa-quy-2] wrong: thieu_can_tren
-- Chỉ rớt ở hidden-1: hidden-1 có NY-CMP-56555 (Nykaa, Social Media, ROI 6,14) bắt đầu
-- 1/7/2025,
-- nhóm có lãi thêm 1 chiến dịch.
SELECT CASE WHEN type_id IN (2, 3) AND roi < 0.5 THEN 'xem_lai_hop_dong'
            WHEN roi < 0 THEN 'lo'
            WHEN roi = 0 THEN 'hoa_von'
            ELSE 'co_lai' END AS nhom_roi,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(acquisition_cost * conversions), 2) AS tong_chi_phi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-04-01'
GROUP BY nhom_roi
ORDER BY nhom_roi;

-- [mkt-n5-dong-thieu-chi-so-pheu] solution
SELECT brand_id, COUNT(*) AS so_dong_thieu
FROM campaigns_raw
WHERE impressions IS NULL
   OR clicks IS NULL
   OR leads IS NULL
   OR conversions IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-n5-dong-thieu-chi-so-pheu] wrong: thieu_mot_cot
-- Rớt ở public: quên cột leads.
SELECT brand_id, COUNT(*) AS so_dong_thieu
FROM campaigns_raw
WHERE impressions IS NULL
   OR clicks IS NULL
   OR conversions IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-n5-dong-thieu-chi-so-pheu] wrong: and_thay_or
-- Rớt ở public: đòi thiếu cả bốn cột cùng lúc, không dòng nào thoả.
SELECT brand_id, COUNT(*) AS so_dong_thieu
FROM campaigns_raw
WHERE impressions IS NULL
  AND clicks IS NULL
  AND leads IS NULL
  AND conversions IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-n6-ty-le-roi-sau-nhap-11-11] solution
SELECT campaign_id, clicks, leads,
       ROUND((1 - leads / NULLIF(clicks, 0)) * 100, 2) AS ty_le_roi_pct
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY ty_le_roi_pct DESC, campaign_id;

-- [mkt-n6-ty-le-roi-sau-nhap-11-11] wrong: tinh_ty_le_giu_lai
-- Rớt ở public: quên lấy 1 trừ, ra tỷ lệ khách hàng tiềm năng (phần đi tiếp) thay vì tỷ
-- lệ rơi.
SELECT campaign_id, clicks, leads,
       ROUND(leads / NULLIF(clicks, 0) * 100, 2) AS ty_le_roi_pct
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY ty_le_roi_pct DESC, campaign_id;

-- [mkt-n6-ty-le-roi-sau-nhap-11-11] wrong: mau_so_luot_hien_thi
-- Rớt ở public: lấy lượt hiển thị (tầng nhận biết) làm mẫu số thay vì tầng ngay trước.
SELECT campaign_id, clicks, leads,
       ROUND((1 - leads / NULLIF(impressions, 0)) * 100, 2) AS ty_le_roi_pct
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY ty_le_roi_pct DESC, campaign_id;

-- [mkt-n6-ty-le-roi-sau-nhap-11-11] wrong: quen_nhan_100
-- Rớt ở public: trả tỷ số 0-1 thay vì phần trăm.
SELECT campaign_id, clicks, leads,
       ROUND(1 - leads / NULLIF(clicks, 0), 2) AS ty_le_roi_pct
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY ty_le_roi_pct DESC, campaign_id;

-- [mkt-n7-gia-tri-don-tho-lech] starter
SELECT ROUND(SUM(revenue) / SUM(conversions), 2) AS gia_tri_don
FROM campaigns_raw
WHERE revenue > 0;

-- [mkt-n7-gia-tri-don-tho-lech] solution
SELECT ROUND(SUM(revenue) / SUM(conversions), 2) AS gia_tri_don
FROM campaigns_raw
WHERE revenue > 0
  AND conversions IS NOT NULL;

-- [mkt-n7-gia-tri-don-tho-lech] wrong: bo_loc_doanh_thu_duong
-- Rớt ở public: lọc conversions IS NOT NULL nhưng bỏ revenue > 0, nên doanh thu âm vào tử
-- số
-- và lượt chuyển đổi của dòng trống doanh thu vào mẫu số.
SELECT ROUND(SUM(revenue) / SUM(conversions), 2) AS gia_tri_don
FROM campaigns_raw
WHERE conversions IS NOT NULL;

-- [mkt-n7-gia-tri-don-tho-lech] wrong: coalesce_mau_so
-- Rớt ở public: COALESCE(conversions, 0) không đổi tổng mẫu số, tử số vẫn còn doanh thu
-- của dòng trống lượt chuyển đổi.
SELECT ROUND(SUM(revenue) / SUM(COALESCE(conversions, 0)), 2) AS gia_tri_don
FROM campaigns_raw
WHERE revenue > 0;

-- [mkt-n7-gia-tri-don-tho-lech] wrong: binh_quan_gian_don
-- Rớt ở public: bình quân giá trị đơn của từng dòng, không phải tỷ lệ của tổng.
SELECT ROUND(AVG(revenue / conversions), 2) AS gia_tri_don
FROM campaigns_raw
WHERE revenue > 0
  AND conversions IS NOT NULL;

-- [mkt-n8-roi-tinh-lai-lech] starter
SELECT campaign_id, roi,
       ROUND(revenue - acquisition_cost * conversions / (acquisition_cost * conversions), 2) AS roi_tinh_lai
FROM campaigns
WHERE brand_id = 2
  AND type_id = 4
  AND start_date = '2025-04-01'
ORDER BY campaign_id;

-- [mkt-n8-roi-tinh-lai-lech] solution
SELECT campaign_id, roi,
       ROUND((revenue - acquisition_cost * conversions) / (acquisition_cost * conversions), 2) AS roi_tinh_lai
FROM campaigns
WHERE brand_id = 2
  AND type_id = 4
  AND start_date = '2025-04-01'
ORDER BY campaign_id;

-- [mkt-n8-roi-tinh-lai-lech] wrong: coi_cpa_la_chi_phi
-- Rớt ở public: lấy acquisition_cost (chi phí trên một lượt chuyển đổi) làm tổng chi phí.
SELECT campaign_id, roi,
       ROUND((revenue - acquisition_cost) / acquisition_cost, 2) AS roi_tinh_lai
FROM campaigns
WHERE brand_id = 2
  AND type_id = 4
  AND start_date = '2025-04-01'
ORDER BY campaign_id;

-- [mkt-n8-roi-tinh-lai-lech] wrong: thanh_roas
-- Rớt ở public: doanh thu chia chi phí là ROAS, lớn hơn ROI đúng 1.
SELECT campaign_id, roi,
       ROUND(revenue / (acquisition_cost * conversions), 2) AS roi_tinh_lai
FROM campaigns
WHERE brand_id = 2
  AND type_id = 4
  AND start_date = '2025-04-01'
ORDER BY campaign_id;

-- [mkt-n9-cpc-cpm-nykaa-thang-6-lech] starter
SELECT campaign_id, clicks, impressions,
       ROUND(acquisition_cost / clicks, 2) AS cpc,
       ROUND(acquisition_cost / impressions, 2) * 1000 AS cpm
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND language_id = 3
  AND start_date >= '2025-06-15'
ORDER BY cpc DESC, campaign_id;

-- [mkt-n9-cpc-cpm-nykaa-thang-6-lech] solution
SELECT campaign_id, clicks, impressions,
       ROUND(acquisition_cost * conversions / clicks, 2) AS cpc,
       ROUND(acquisition_cost * conversions / impressions * 1000, 2) AS cpm
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND language_id = 3
  AND start_date >= '2025-06-15' AND start_date < '2025-07-01'
ORDER BY cpc DESC, campaign_id;

-- [mkt-n9-cpc-cpm-nykaa-thang-6-lech] wrong: quen_can_tren
-- Chỉ rớt ở hidden-1: sửa chi phí và làm tròn nhưng vẫn thiếu cận trên; hidden-1 có
-- NY-CMP-56555
-- (Nykaa, Social Media, Hindi) bắt đầu 1/7/2025.
SELECT campaign_id, clicks, impressions,
       ROUND(acquisition_cost * conversions / clicks, 2) AS cpc,
       ROUND(acquisition_cost * conversions / impressions * 1000, 2) AS cpm
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND language_id = 3
  AND start_date >= '2025-06-15'
ORDER BY cpc DESC, campaign_id;

-- [mkt-n9-cpc-cpm-nykaa-thang-6-lech] wrong: giu_lam_tron_som
-- Rớt ở public: làm tròn chi phí trên một lượt hiển thị trước khi nhân 1.000, CPM lệch
-- tới vài đơn vị tiền.
SELECT campaign_id, clicks, impressions,
       ROUND(acquisition_cost * conversions / clicks, 2) AS cpc,
       ROUND(acquisition_cost * conversions / impressions, 2) * 1000 AS cpm
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND language_id = 3
  AND start_date >= '2025-06-15' AND start_date < '2025-07-01'
ORDER BY cpc DESC, campaign_id;

-- [mkt-n9-cpc-cpm-nykaa-thang-6-lech] wrong: giu_cpa_lam_chi_phi
-- Rớt ở public: vẫn lấy acquisition_cost (CPA) làm chi phí chiến dịch.
SELECT campaign_id, clicks, impressions,
       ROUND(acquisition_cost / clicks, 2) AS cpc,
       ROUND(acquisition_cost / impressions * 1000, 2) AS cpm
FROM campaigns
WHERE brand_id = 1
  AND type_id = 5
  AND language_id = 3
  AND start_date >= '2025-06-15' AND start_date < '2025-07-01'
ORDER BY cpc DESC, campaign_id;

-- ================================================ CASE STUDY · CƠ BẢN

-- [mkt-c1-ctr-theo-loai-thang-5.b1] solution
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_pct
FROM campaigns
WHERE start_date >= '2025-05-01' AND start_date < '2025-06-01'
GROUP BY type_id
ORDER BY ctr_pct DESC, type_id;

-- [mkt-c1-ctr-theo-loai-thang-5.b1] wrong: binh_quan_ctr_tung_chien_dich
-- Rớt ở public: bình quân giản đơn CTR của từng chiến dịch, khác tỷ lệ của tổng.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(AVG(clicks * 100 / impressions), 2) AS ctr_pct
FROM campaigns
WHERE start_date >= '2025-05-01' AND start_date < '2025-06-01'
GROUP BY type_id
ORDER BY ctr_pct DESC, type_id;

-- [mkt-c1-ctr-theo-loai-thang-5.b1] wrong: thieu_can_tren
-- Rớt ở public: gộp cả tháng 6/2025.
SELECT type_id,
       COUNT(*) AS so_chien_dich,
       ROUND(SUM(clicks) * 100 / SUM(impressions), 2) AS ctr_pct
FROM campaigns
WHERE start_date >= '2025-05-01'
GROUP BY type_id
ORDER BY ctr_pct DESC, type_id;

-- [mkt-c2-file-tho-thieu-nhieu-nhat.b1] solution
SELECT brand_id, COUNT(*) AS so_dong_thieu
FROM campaigns_raw
WHERE impressions IS NULL
   OR clicks IS NULL
   OR leads IS NULL
   OR conversions IS NULL
   OR revenue IS NULL
   OR acquisition_cost IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c2-file-tho-thieu-nhieu-nhat.b1] wrong: chi_xet_cot_pheu
-- Rớt ở public: chỉ xét bốn cột phễu, bỏ revenue và acquisition_cost.
SELECT brand_id, COUNT(*) AS so_dong_thieu
FROM campaigns_raw
WHERE impressions IS NULL
   OR clicks IS NULL
   OR leads IS NULL
   OR conversions IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c2-file-tho-thieu-nhieu-nhat.b1] wrong: dem_dong_co_gia_tri
-- Rớt ở public: COUNT(revenue) đếm dòng có doanh thu, không phải dòng thiếu.
SELECT brand_id, COUNT(revenue) AS so_dong_thieu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;
