-- solution.sql: gói 1 của bộ Marketing (dulieu=mkt), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên mkt (public) và mkt_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.
-- Mã danh mục: brand_id 1 Nykaa, 2 Purplle, 3 Tira Beauty; type_id 1 Email, 2 Influencer, 3 Paid Ads, 4 SEO,
-- 5 Social Media; audience_id 4 Working Women, 5 Youth; language_id 4 Tamil.

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

-- [mkt-r2-working-women-tamil-tira] solution
SELECT campaign_id, start_date, duration_days
FROM campaigns
WHERE brand_id = 3
  AND target_audience_id = 4
  AND language_id = 3
  AND start_date = '2025-03-08'
ORDER BY campaign_id;

-- [mkt-r2-working-women-tamil-tira] wrong: nham_phan_khuc_voi_doi_tuong
-- Rớt ở public: segment_id là phân khúc khách hàng, không phải đối tượng mục tiêu.
SELECT campaign_id, start_date, duration_days
FROM campaigns
WHERE brand_id = 3
  AND segment_id = 4
  AND language_id = 3
  AND start_date = '2025-03-08'
ORDER BY campaign_id;

-- [mkt-r3-roi-thap-nhat-nykaa-q4] solution
SELECT campaign_id, start_date, roi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-10-01' AND start_date < '2025-01-01'
ORDER BY roi, campaign_id
LIMIT 10;

-- [mkt-r3-roi-thap-nhat-nykaa-q4] wrong: sap_giam_dan
-- Rớt ở public: lấy 10 chiến dịch lãi nhiều nhất.
SELECT campaign_id, start_date, roi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-10-01' AND start_date < '2025-01-01'
ORDER BY roi DESC, campaign_id
LIMIT 10;

-- [mkt-r3-roi-thap-nhat-nykaa-q4] wrong: hoa_theo_ma_giam_dan
-- Rớt ở public: 9 chiến dịch cùng roi -0,95 ở hạng 3-11; quy tắc hoà ngược chiều đổi tập 10 dòng.
SELECT campaign_id, start_date, roi
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2024-10-01' AND start_date < '2025-01-01'
ORDER BY roi, campaign_id DESC
LIMIT 10;

-- [mkt-r3-roi-thap-nhat-nykaa-q4] wrong: thieu_can_tren
-- Rớt ở public: xét cả chiến dịch năm 2025.
SELECT campaign_id, start_date, roi
FROM campaigns
WHERE brand_id = 1
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
-- Rớt ở public: lấy chiến dịch có chạy kênh Email (channel_id = 1), không phải loại Email.
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

-- [mkt-r6-diem-tuong-tac-tu-30] solution
SELECT campaign_id, brand_id, engagement_score
FROM campaigns
WHERE engagement_score >= 30
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r6-diem-tuong-tac-tu-30] wrong: lon_hon_bo_dung_30
-- Rớt ở public: có chiến dịch điểm đúng 30,00.
SELECT campaign_id, brand_id, engagement_score
FROM campaigns
WHERE engagement_score > 30
ORDER BY engagement_score DESC, campaign_id;

-- [mkt-r6-diem-tuong-tac-tu-30] wrong: hoa_theo_ma_giam_dan
-- Rớt ở public nếu có hai chiến dịch cùng điểm (quy tắc hoà ngược chiều).
SELECT campaign_id, brand_id, engagement_score
FROM campaigns
WHERE engagement_score >= 30
ORDER BY engagement_score DESC, campaign_id DESC;

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
-- Rớt ở public: xoá điều kiện gây lỗi thay vì sửa, ra mọi loại chiến dịch của Nykaa trong ngày.
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

-- [mkt-r9-youth-hoac-working-women-thua] starter
SELECT campaign_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 3
  AND type_id = 3
  AND start_date = '2025-04-12'
  AND target_audience_id = 5 OR target_audience_id = 4
ORDER BY campaign_id;

-- [mkt-r9-youth-hoac-working-women-thua] solution
SELECT campaign_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 3
  AND type_id = 3
  AND start_date = '2025-04-12'
  AND (target_audience_id = 5 OR target_audience_id = 4)
ORDER BY campaign_id;

-- [mkt-r9-youth-hoac-working-women-thua] wrong: and_thay_or
-- Rớt ở public: một chiến dịch không thể cùng lúc nhắm hai nhóm, ra 0 dòng.
SELECT campaign_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 3
  AND type_id = 3
  AND start_date = '2025-04-12'
  AND target_audience_id = 5 AND target_audience_id = 4
ORDER BY campaign_id;

-- [mkt-r9-youth-hoac-working-women-thua] wrong: loc_theo_phan_khuc
-- Rớt ở public: segment_id là phân khúc khách hàng, không phải đối tượng mục tiêu.
SELECT campaign_id, target_audience_id, start_date
FROM campaigns
WHERE brand_id = 3
  AND type_id = 3
  AND start_date = '2025-04-12'
  AND segment_id IN (4, 5)
ORDER BY campaign_id;

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
-- Rớt ở public: acquisition_cost là chi phí trên một lượt chuyển đổi, không phải tổng chi phí.
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

-- [mkt-n4-lai-hoa-lo-quy-1] solution
SELECT COUNT(CASE WHEN roi > 0 THEN 1 END) AS so_lai,
       COUNT(CASE WHEN roi = 0 THEN 1 END) AS so_hoa_von,
       COUNT(CASE WHEN roi < 0 THEN 1 END) AS so_lo
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01';

-- [mkt-n4-lai-hoa-lo-quy-1] wrong: hoa_von_tinh_vao_lai
-- Rớt ở public: roi = 0 bị đếm vào nhóm lãi.
SELECT COUNT(CASE WHEN roi >= 0 THEN 1 END) AS so_lai,
       COUNT(CASE WHEN roi = 0 THEN 1 END) AS so_hoa_von,
       COUNT(CASE WHEN roi < 0 THEN 1 END) AS so_lo
FROM campaigns
WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01';

-- [mkt-n4-lai-hoa-lo-quy-1] wrong: thieu_can_tren
-- Rớt ở public: đếm cả chiến dịch từ tháng 4 tới tháng 6/2025.
SELECT COUNT(CASE WHEN roi > 0 THEN 1 END) AS so_lai,
       COUNT(CASE WHEN roi = 0 THEN 1 END) AS so_hoa_von,
       COUNT(CASE WHEN roi < 0 THEN 1 END) AS so_lo
FROM campaigns
WHERE start_date >= '2025-01-01';

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

-- [mkt-n6-gia-tri-don-11-11] solution
SELECT campaign_id, revenue, conversions,
       ROUND(revenue / NULLIF(conversions, 0), 2) AS gia_tri_don
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY gia_tri_don DESC, campaign_id;

-- [mkt-n6-gia-tri-don-11-11] wrong: chia_nguoc
-- Rớt ở public: lượt chuyển đổi chia doanh thu.
SELECT campaign_id, revenue, conversions,
       ROUND(conversions / NULLIF(revenue, 0), 2) AS gia_tri_don
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY gia_tri_don DESC, campaign_id;

-- [mkt-n6-gia-tri-don-11-11] wrong: chia_cho_khach_hang_tiem_nang
-- Rớt ở public: mẫu số là leads thay vì conversions.
SELECT campaign_id, revenue, conversions,
       ROUND(revenue / NULLIF(leads, 0), 2) AS gia_tri_don
FROM campaigns
WHERE brand_id = 2
  AND type_id = 2
  AND start_date = '2024-11-11'
ORDER BY gia_tri_don DESC, campaign_id;

-- [mkt-n7-doanh-thu-tho-thap-bat-thuong] starter
SELECT ROUND(AVG(COALESCE(revenue, 0)), 2) AS doanh_thu_tb
FROM campaigns_raw;

-- [mkt-n7-doanh-thu-tho-thap-bat-thuong] solution
SELECT ROUND(AVG(revenue), 2) AS doanh_thu_tb
FROM campaigns_raw
WHERE revenue > 0;

-- [mkt-n7-doanh-thu-tho-thap-bat-thuong] wrong: con_gia_tri_am
-- Rớt ở public: bỏ COALESCE nên ô trống không còn thành 0, nhưng 75 dòng doanh thu âm vẫn vào bình quân.
SELECT ROUND(AVG(revenue), 2) AS doanh_thu_tb
FROM campaigns_raw;

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

-- [mkt-n9-thieu-chi-phi-ra-0] starter
SELECT brand_id, COUNT(CASE WHEN acquisition_cost = NULL THEN 1 END) AS so_dong_thieu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-n9-thieu-chi-phi-ra-0] solution
SELECT brand_id, COUNT(CASE WHEN acquisition_cost IS NULL THEN 1 END) AS so_dong_thieu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-n9-thieu-chi-phi-ra-0] wrong: dem_bieu_thuc_dieu_kien
-- Rớt ở public: COUNT đếm mọi giá trị khác NULL, mà acquisition_cost IS NULL luôn là 0 hoặc 1.
SELECT brand_id, COUNT(acquisition_cost IS NULL) AS so_dong_thieu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-n9-thieu-chi-phi-ra-0] wrong: dem_o_co_gia_tri
-- Rớt ở public: COUNT(cột) đếm ô có giá trị, ngược với số ô trống.
SELECT brand_id, COUNT(acquisition_cost) AS so_dong_thieu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;

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

-- [mkt-c2-nhieu-don-vao-thuong-hieu-nao.b1] solution
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

-- [mkt-c2-nhieu-don-vao-thuong-hieu-nao.b1] wrong: chi_xet_cot_pheu
-- Rớt ở public: chỉ xét bốn cột phễu, bỏ revenue và acquisition_cost.
SELECT brand_id, COUNT(*) AS so_dong_thieu
FROM campaigns_raw
WHERE impressions IS NULL
   OR clicks IS NULL
   OR leads IS NULL
   OR conversions IS NULL
GROUP BY brand_id
ORDER BY brand_id;

-- [mkt-c2-nhieu-don-vao-thuong-hieu-nao.b1] wrong: dem_dong_co_gia_tri
-- Rớt ở public: COUNT(revenue) đếm dòng có doanh thu, không phải dòng thiếu.
SELECT brand_id, COUNT(revenue) AS so_dong_thieu
FROM campaigns_raw
GROUP BY brand_id
ORDER BY brand_id;
