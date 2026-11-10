-- solution.sql: gói 3 của bộ Marketing (dulieu=mkt), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên mkt (public) và mkt_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.
-- Mã danh mục: brand_id 1 Nykaa, 2 Purplle, 3 Tira Beauty; type_id 1 Email, 2 Influencer, 3 Paid Ads, 4 SEO,
-- 5 Social Media; channel_id 1 Email, 2 Facebook, 3 Google, 4 Instagram, 5 WhatsApp, 6 YouTube.

-- ================================================ MODULE 5 · JOINS

-- [mkt-j1-tira-doanh-thu-cao-kem-loai] solution
SELECT c.campaign_id, t.type_name, c.revenue
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
WHERE c.brand_id = 3
  AND c.start_date = '2025-03-19'
  AND c.revenue >= 2000000
ORDER BY c.revenue DESC, c.campaign_id;

-- [mkt-j1-tira-doanh-thu-cao-kem-loai] wrong: noi_sai_khoa
-- Rớt ở public: nối loại chiến dịch theo brand_id, mọi dòng đều mang tên loại có mã 3.
SELECT c.campaign_id, t.type_name, c.revenue
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.brand_id
WHERE c.brand_id = 3
  AND c.start_date = '2025-03-19'
  AND c.revenue >= 2000000
ORDER BY c.revenue DESC, c.campaign_id;

-- [mkt-j1-tira-doanh-thu-cao-kem-loai] wrong: tra_ma_loai
-- Rớt ở public: không nối danh mục, trả mã loại thay cho tên loại.
SELECT c.campaign_id, c.type_id AS type_name, c.revenue
FROM campaigns c
WHERE c.brand_id = 3
  AND c.start_date = '2025-03-19'
  AND c.revenue >= 2000000
ORDER BY c.revenue DESC, c.campaign_id;

-- [mkt-j2-doi-tuong-va-phan-khuc] solution
SELECT dt.audience_name AS doi_tuong, pk.audience_name AS phan_khuc, COUNT(*) AS so_chien_dich
FROM campaigns c
JOIN audiences dt ON dt.audience_id = c.target_audience_id
JOIN audiences pk ON pk.audience_id = c.segment_id
WHERE c.start_date >= '2024-07-01' AND c.start_date < '2025-01-01'
GROUP BY dt.audience_name, pk.audience_name
ORDER BY doi_tuong, phan_khuc;

-- [mkt-j2-doi-tuong-va-phan-khuc] wrong: noi_mot_lan_cho_hai_vai
-- Rớt ở public: một lần nối với cả hai điều kiện chỉ giữ chiến dịch có đối tượng trùng phân khúc (5 dòng).
SELECT a.audience_name AS doi_tuong, a.audience_name AS phan_khuc, COUNT(*) AS so_chien_dich
FROM campaigns c
JOIN audiences a ON a.audience_id = c.target_audience_id AND a.audience_id = c.segment_id
WHERE c.start_date >= '2024-07-01' AND c.start_date < '2025-01-01'
GROUP BY a.audience_name
ORDER BY doi_tuong, phan_khuc;

-- [mkt-j2-doi-tuong-va-phan-khuc] wrong: gom_theo_ma_phan_khuc
-- Rớt ở public: cột phân khúc là mã số, không phải tên nhóm.
SELECT dt.audience_name AS doi_tuong, c.segment_id AS phan_khuc, COUNT(*) AS so_chien_dich
FROM campaigns c
JOIN audiences dt ON dt.audience_id = c.target_audience_id
WHERE c.start_date >= '2024-07-01' AND c.start_date < '2025-01-01'
GROUP BY dt.audience_name, c.segment_id
ORDER BY doi_tuong, phan_khuc;

-- [mkt-j3-influencer-nykaa-tren-youtube] solution
SELECT c.campaign_id, c.impressions
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE c.brand_id = 1
  AND c.type_id = 2
  AND c.start_date = '2025-05-15'
  AND cc.channel_id = 6
ORDER BY c.impressions DESC, c.campaign_id;

-- [mkt-j3-influencer-nykaa-tren-youtube] wrong: chi_lay_kenh_dau
-- Rớt ở public: channel_pos = 1 chỉ là kênh viết đầu trong chuỗi gốc, bỏ mất chiến dịch có YouTube ở vị trí 2, 3.
SELECT c.campaign_id, c.impressions
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE c.brand_id = 1
  AND c.type_id = 2
  AND c.start_date = '2025-05-15'
  AND cc.channel_id = 6
  AND cc.channel_pos = 1
ORDER BY c.impressions DESC, c.campaign_id;

-- [mkt-j3-influencer-nykaa-tren-youtube] wrong: noi_khong_loc_kenh
-- Rớt ở public: nối cầu nối mà không lọc kênh, mỗi chiến dịch Influencer hiện một dòng cho mỗi kênh.
SELECT c.campaign_id, c.impressions
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE c.brand_id = 1
  AND c.type_id = 2
  AND c.start_date = '2025-05-15'
ORDER BY c.impressions DESC, c.campaign_id;

-- [mkt-j4-dang-chay-tuan-dau-thang-2] solution
SELECT k.cal_date, COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date <= k.cal_date
 AND k.cal_date <= DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY)
WHERE k.cal_date >= '2025-02-03' AND k.cal_date < '2025-02-10'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j4-dang-chay-tuan-dau-thang-2] wrong: lech_bien_ngay_cuoi
-- Rớt ở public: ngày cuối tính start_date + duration_days, tính thừa một ngày.
SELECT k.cal_date, COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c
  ON c.start_date <= k.cal_date
 AND k.cal_date <= DATE_ADD(c.start_date, INTERVAL c.duration_days DAY)
WHERE k.cal_date >= '2025-02-03' AND k.cal_date < '2025-02-10'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j4-dang-chay-tuan-dau-thang-2] wrong: noi_bang_ngay_bat_dau
-- Rớt ở public: chỉ đếm chiến dịch khởi chạy đúng ngày đó.
SELECT k.cal_date, COUNT(*) AS so_dang_chay
FROM calendar k
JOIN campaigns c ON c.start_date = k.cal_date
WHERE k.cal_date >= '2025-02-03' AND k.cal_date < '2025-02-10'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j5-ngay-khong-co-chien-dich] solution
SELECT k.cal_date, k.day_name
FROM calendar k
LEFT JOIN campaigns c
  ON c.start_date = k.cal_date
 AND c.brand_id = 3 AND c.type_id = 3
 AND c.language_id = 3 AND c.target_audience_id = 2
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND c.campaign_id IS NULL
ORDER BY k.cal_date;

-- [mkt-j5-ngay-khong-co-chien-dich] wrong: noi_trong
-- Rớt ở public: nối trong bỏ mất chính những ngày không khớp chiến dịch nào, ra 0 dòng.
SELECT k.cal_date, k.day_name
FROM calendar k
JOIN campaigns c
  ON c.start_date = k.cal_date
 AND c.brand_id = 3 AND c.type_id = 3
 AND c.language_id = 3 AND c.target_audience_id = 2
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND c.campaign_id IS NULL
ORDER BY k.cal_date;

-- [mkt-j5-ngay-khong-co-chien-dich] wrong: dieu_kien_o_where
-- Rớt ở public: điều kiện của bảng bên phải đặt ở WHERE loại các dòng NULL, ra 0 dòng.
SELECT k.cal_date, k.day_name
FROM calendar k
LEFT JOIN campaigns c ON c.start_date = k.cal_date
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND c.brand_id = 3 AND c.type_id = 3
  AND c.language_id = 3 AND c.target_audience_id = 2
  AND c.campaign_id IS NULL
ORDER BY k.cal_date;

-- [mkt-j5-ngay-khong-co-chien-dich] wrong: thieu_dieu_kien_ngon_ngu
-- Rớt ở public: bỏ điều kiện ngôn ngữ thì ngày nào cũng có chiến dịch.
SELECT k.cal_date, k.day_name
FROM calendar k
LEFT JOIN campaigns c
  ON c.start_date = k.cal_date
 AND c.brand_id = 3 AND c.type_id = 3
 AND c.target_audience_id = 2
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND c.campaign_id IS NULL
ORDER BY k.cal_date;

-- [mkt-j6-email-lech-kenh-nua-dau-2025] solution
SELECT b.brand_name,
       COUNT(*) AS so_chien_dich_email,
       COUNT(CASE WHEN e.campaign_id IS NULL THEN 1 END) AS so_lech_kenh,
       ROUND(COUNT(CASE WHEN e.campaign_id IS NULL THEN 1 END) * 100 / COUNT(*), 2) AS ty_le_lech_pct,
       SUM(CASE WHEN e.campaign_id IS NULL THEN c.revenue ELSE 0 END) AS doanh_thu_lech
FROM campaigns c
JOIN brands b ON b.brand_id = c.brand_id
JOIN campaign_types t ON t.type_id = c.type_id
LEFT JOIN campaign_channels e ON e.campaign_id = c.campaign_id AND e.channel_id = 1
WHERE t.type_name = 'Email'
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY b.brand_name
ORDER BY b.brand_name;

-- [mkt-j6-email-lech-kenh-nua-dau-2025] wrong: kenh_khac_email_o_where
-- Rớt ở public: lọc dòng kênh khác Email ở WHERE nên tính cả chiến dịch có Email kèm kênh khác, doanh thu cộng theo dòng nối.
SELECT b.brand_name,
       COUNT(DISTINCT c.campaign_id) AS so_chien_dich_email,
       COUNT(DISTINCT c.campaign_id) AS so_lech_kenh,
       ROUND(COUNT(DISTINCT c.campaign_id) * 100 / COUNT(DISTINCT c.campaign_id), 2) AS ty_le_lech_pct,
       SUM(c.revenue) AS doanh_thu_lech
FROM campaigns c
JOIN brands b ON b.brand_id = c.brand_id
JOIN campaign_types t ON t.type_id = c.type_id
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE t.type_name = 'Email' AND cc.channel_id <> 1
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY b.brand_name
ORDER BY b.brand_name;

-- [mkt-j6-email-lech-kenh-nua-dau-2025] wrong: doanh_thu_nhan_dong
-- Rớt ở public: đếm đúng nhờ DISTINCT nhưng doanh thu lấy tổng mọi dòng nối trừ dòng kênh Email, chiến dịch nhiều kênh bị cộng nhiều lần.
SELECT b.brand_name,
       COUNT(DISTINCT c.campaign_id) AS so_chien_dich_email,
       COUNT(DISTINCT c.campaign_id) - COUNT(DISTINCT CASE WHEN cc.channel_id = 1 THEN c.campaign_id END) AS so_lech_kenh,
       ROUND((COUNT(DISTINCT c.campaign_id) - COUNT(DISTINCT CASE WHEN cc.channel_id = 1 THEN c.campaign_id END)) * 100
             / COUNT(DISTINCT c.campaign_id), 2) AS ty_le_lech_pct,
       SUM(c.revenue) - SUM(CASE WHEN cc.channel_id = 1 THEN c.revenue ELSE 0 END) AS doanh_thu_lech
FROM campaigns c
JOIN brands b ON b.brand_id = c.brand_id
JOIN campaign_types t ON t.type_id = c.type_id
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE t.type_name = 'Email'
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY b.brand_name
ORDER BY b.brand_name;

-- [mkt-j6-email-lech-kenh-nua-dau-2025] wrong: kenh_email_khong_phai_loai_email
-- Rớt ở public: đảo vai loại và kênh, đếm chiến dịch có kênh Email mà không thuộc loại Email.
SELECT b.brand_name,
       COUNT(*) AS so_chien_dich_email,
       COUNT(CASE WHEN c.type_id <> 1 THEN 1 END) AS so_lech_kenh,
       ROUND(COUNT(CASE WHEN c.type_id <> 1 THEN 1 END) * 100 / COUNT(*), 2) AS ty_le_lech_pct,
       SUM(CASE WHEN c.type_id <> 1 THEN c.revenue ELSE 0 END) AS doanh_thu_lech
FROM campaigns c
JOIN brands b ON b.brand_id = c.brand_id
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id AND cc.channel_id = 1
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY b.brand_name
ORDER BY b.brand_name;

-- [mkt-j6-email-lech-kenh-nua-dau-2025] wrong: mau_so_moi_chien_dich
-- Rớt ở public: tỷ lệ chia cho mọi chiến dịch của thương hiệu thay vì chiến dịch loại Email.
SELECT b.brand_name,
       COUNT(CASE WHEN c.type_id = 1 THEN 1 END) AS so_chien_dich_email,
       COUNT(CASE WHEN c.type_id = 1 AND e.campaign_id IS NULL THEN 1 END) AS so_lech_kenh,
       ROUND(COUNT(CASE WHEN c.type_id = 1 AND e.campaign_id IS NULL THEN 1 END) * 100 / COUNT(*), 2) AS ty_le_lech_pct,
       SUM(CASE WHEN c.type_id = 1 AND e.campaign_id IS NULL THEN c.revenue ELSE 0 END) AS doanh_thu_lech
FROM campaigns c
JOIN brands b ON b.brand_id = c.brand_id
LEFT JOIN campaign_channels e ON e.campaign_id = c.campaign_id AND e.channel_id = 1
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY b.brand_name
ORDER BY b.brand_name;

-- [mkt-j7-doanh-thu-instagram-facebook-gap-doi] starter
SELECT COUNT(*) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE c.brand_id = 3
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-04-01'
  AND cc.channel_id IN (2, 4);

-- [mkt-j7-doanh-thu-instagram-facebook-gap-doi] solution
SELECT COUNT(*) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN (SELECT DISTINCT campaign_id
      FROM campaign_channels
      WHERE channel_id IN (2, 4)) k ON k.campaign_id = c.campaign_id
WHERE c.brand_id = 3
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-04-01';

-- [mkt-j7-doanh-thu-instagram-facebook-gap-doi] wrong: chi_sua_cot_dem
-- Rớt ở public: số chiến dịch đã đúng nhưng doanh thu vẫn cộng hai lần ở chiến dịch dùng cả hai kênh.
SELECT COUNT(DISTINCT c.campaign_id) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE c.brand_id = 3
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-04-01'
  AND cc.channel_id IN (2, 4);

-- [mkt-j7-doanh-thu-instagram-facebook-gap-doi] wrong: cong_gia_tri_khac_nhau
-- Rớt ở public: SUM(DISTINCT) bỏ cả chiến dịch khác nhau có cùng doanh thu.
SELECT COUNT(DISTINCT c.campaign_id) AS so_chien_dich, SUM(DISTINCT c.revenue) AS doanh_thu
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
WHERE c.brand_id = 3
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-04-01'
  AND cc.channel_id IN (2, 4);

-- [mkt-j8-phan-khuc-lay-nham-doi-tuong] starter
SELECT a.audience_name AS phan_khuc, COUNT(*) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN audiences a ON a.audience_id = c.target_audience_id
WHERE c.brand_id = 2
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY a.audience_name
ORDER BY phan_khuc;

-- [mkt-j8-phan-khuc-lay-nham-doi-tuong] solution
SELECT a.audience_name AS phan_khuc, COUNT(*) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN audiences a ON a.audience_id = c.segment_id
WHERE c.brand_id = 2
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY a.audience_name
ORDER BY phan_khuc;

-- [mkt-j8-phan-khuc-lay-nham-doi-tuong] wrong: noi_ca_hai_vai
-- Rớt ở public: chỉ giữ chiến dịch có phân khúc trùng đối tượng mục tiêu.
SELECT a.audience_name AS phan_khuc, COUNT(*) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN audiences a ON a.audience_id = c.segment_id AND a.audience_id = c.target_audience_id
WHERE c.brand_id = 2
  AND c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY a.audience_name
ORDER BY phan_khuc;

-- [mkt-j8-phan-khuc-lay-nham-doi-tuong] wrong: sua_ma_quen_pham_vi
-- Rớt ở public: sửa đúng khoá nối nhưng bỏ điều kiện thương hiệu khi viết lại.
SELECT a.audience_name AS phan_khuc, COUNT(*) AS so_chien_dich, SUM(c.revenue) AS doanh_thu
FROM campaigns c
JOIN audiences a ON a.audience_id = c.segment_id
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY a.audience_name
ORDER BY phan_khuc;

-- [mkt-j9-lich-paid-ads-tira-chua-dung-duoc] starter
SELECT k.cal_date, COUNT(*) AS so_chien_dich
FROM calendar k
LEFT JOIN campaigns c ON c.start_date = k.cal_date
WHERE k.cal_date >= '2025-06-01'
  AND c.brand_id = 3 AND c.type_id = 3
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j9-lich-paid-ads-tira-chua-dung-duoc] solution
SELECT k.cal_date, COUNT(c.campaign_id) AS so_chien_dich
FROM calendar k
LEFT JOIN campaigns c
  ON c.start_date = k.cal_date
 AND c.brand_id = 3 AND c.type_id = 3
WHERE k.cal_date >= '2025-06-01' AND k.cal_date < '2025-07-01'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j9-lich-paid-ads-tira-chua-dung-duoc] wrong: chi_dua_dieu_kien_vao_on
-- Rớt ở public: đã giữ đủ ngày nhưng COUNT(*) cho ngày trống ra 1 (và vẫn thiếu cận trên).
SELECT k.cal_date, COUNT(*) AS so_chien_dich
FROM calendar k
LEFT JOIN campaigns c
  ON c.start_date = k.cal_date
 AND c.brand_id = 3 AND c.type_id = 3
WHERE k.cal_date >= '2025-06-01'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j9-lich-paid-ads-tira-chua-dung-duoc] wrong: chi_sua_cot_dem
-- Rớt ở public: đổi sang COUNT(c.campaign_id) nhưng điều kiện vẫn ở WHERE, ngày không có chiến dịch vẫn mất.
SELECT k.cal_date, COUNT(c.campaign_id) AS so_chien_dich
FROM calendar k
LEFT JOIN campaigns c ON c.start_date = k.cal_date
WHERE k.cal_date >= '2025-06-01' AND k.cal_date < '2025-07-01'
  AND c.brand_id = 3 AND c.type_id = 3
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- [mkt-j9-lich-paid-ads-tira-chua-dung-duoc] wrong: sua_hai_loi_thieu_can_tren
-- Rớt ở hidden-1: sửa ON và cột đếm nhưng giữ lọc lịch không cận trên, lịch có thêm ngày 2025-07-01.
SELECT k.cal_date, COUNT(c.campaign_id) AS so_chien_dich
FROM calendar k
LEFT JOIN campaigns c
  ON c.start_date = k.cal_date
 AND c.brand_id = 3 AND c.type_id = 3
WHERE k.cal_date >= '2025-06-01'
GROUP BY k.cal_date
ORDER BY k.cal_date;

-- ================================================ MODULE 6 · SUBQUERIES

-- [mkt-q1-roi-tren-binh-quan-tira] solution
SELECT COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 3
  AND start_date >= '2025-04-01' AND start_date < '2025-05-01'
  AND roi > (SELECT (SUM(revenue) - SUM(acquisition_cost * conversions))
                    / SUM(acquisition_cost * conversions)
             FROM campaigns
             WHERE brand_id = 3
               AND start_date >= '2025-04-01' AND start_date < '2025-05-01');

-- [mkt-q1-roi-tren-binh-quan-tira] wrong: muc_chung_ca_ky
-- Rớt ở public: mức chung lấy cả ba thương hiệu, cả kỳ.
SELECT COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 3
  AND start_date >= '2025-04-01' AND start_date < '2025-05-01'
  AND roi > (SELECT (SUM(revenue) - SUM(acquisition_cost * conversions))
                    / SUM(acquisition_cost * conversions)
             FROM campaigns);

-- [mkt-q1-roi-tren-binh-quan-tira] wrong: binh_quan_cot_roi
-- Rớt ở public: AVG(roi) là bình quân giản đơn, cao hơn ROI của tổng.
SELECT COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 3
  AND start_date >= '2025-04-01' AND start_date < '2025-05-01'
  AND roi > (SELECT AVG(roi)
             FROM campaigns
             WHERE brand_id = 3
               AND start_date >= '2025-04-01' AND start_date < '2025-05-01');

-- [mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu] solution
SELECT c.brand_id, c.campaign_id, c.revenue
FROM campaigns c
WHERE c.start_date = '2025-03-05'
  AND c.revenue = (SELECT MAX(c2.revenue)
                   FROM campaigns c2
                   WHERE c2.brand_id = c.brand_id
                     AND c2.start_date = '2025-03-05')
ORDER BY c.brand_id, c.campaign_id;

-- [mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu] wrong: khong_tuong_quan
-- Rớt ở public: truy vấn con lấy mức cao nhất chung nên chỉ ra một thương hiệu.
SELECT c.brand_id, c.campaign_id, c.revenue
FROM campaigns c
WHERE c.start_date = '2025-03-05'
  AND c.revenue = (SELECT MAX(c2.revenue)
                   FROM campaigns c2
                   WHERE c2.start_date = '2025-03-05')
ORDER BY c.brand_id, c.campaign_id;

-- [mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu] wrong: gom_nhom_lay_ma_nho_nhat
-- Rớt ở public: GROUP BY lấy MAX(revenue) kèm MIN(campaign_id); mã chiến dịch không phải của dòng có doanh thu cao nhất.
SELECT c.brand_id, MIN(c.campaign_id) AS campaign_id, MAX(c.revenue) AS revenue
FROM campaigns c
WHERE c.start_date = '2025-03-05'
GROUP BY c.brand_id
ORDER BY c.brand_id, campaign_id;

-- [mkt-q3-social-media-purplle-nhap-tren-binh-quan] solution
SELECT campaign_id, clicks
FROM campaigns
WHERE brand_id = 2
  AND type_id = 5
  AND start_date = '2025-05-06'
  AND clicks > (SELECT AVG(clicks) FROM campaigns)
ORDER BY clicks DESC, campaign_id;

-- [mkt-q3-social-media-purplle-nhap-tren-binh-quan] wrong: binh_quan_cung_nhom
-- Rớt ở public: lấy bình quân của chính nhóm Purplle Social Media ngày 6/5 thay vì của mọi chiến dịch.
SELECT campaign_id, clicks
FROM campaigns
WHERE brand_id = 2
  AND type_id = 5
  AND start_date = '2025-05-06'
  AND clicks > (SELECT AVG(clicks) FROM campaigns
                WHERE brand_id = 2 AND type_id = 5 AND start_date = '2025-05-06')
ORDER BY clicks DESC, campaign_id;

-- [mkt-q3-social-media-purplle-nhap-tren-binh-quan] wrong: thieu_loc_loai
-- Rớt ở public: quên lọc loại Social Media, lấy chiến dịch của cả năm loại.
SELECT campaign_id, clicks
FROM campaigns
WHERE brand_id = 2
  AND start_date = '2025-05-06'
  AND clicks > (SELECT AVG(clicks) FROM campaigns)
ORDER BY clicks DESC, campaign_id;

-- [mkt-q4-thang-roi-tren-muc-quy-1] solution
SELECT m.brand_id, m.thang,
       ROUND(m.roi_thang, 4) AS roi_thang,
       ROUND(q.roi_quy, 4) AS roi_quy
FROM (SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_thang
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')) m
JOIN (SELECT brand_id,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_quy
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id) q ON q.brand_id = m.brand_id
WHERE m.roi_thang > q.roi_quy
ORDER BY m.brand_id, m.thang;

-- [mkt-q4-thang-roi-tren-muc-quy-1] wrong: binh_quan_cot_roi
-- Rớt ở public: ROI tháng và ROI quý đều lấy bình quân cột roi, không phải tỷ lệ của tổng.
SELECT m.brand_id, m.thang,
       ROUND(m.roi_thang, 4) AS roi_thang,
       ROUND(q.roi_quy, 4) AS roi_quy
FROM (SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang, AVG(roi) AS roi_thang
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')) m
JOIN (SELECT brand_id, AVG(roi) AS roi_quy
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id) q ON q.brand_id = m.brand_id
WHERE m.roi_thang > q.roi_quy
ORDER BY m.brand_id, m.thang;

-- [mkt-q4-thang-roi-tren-muc-quy-1] wrong: muc_chung_ca_ba_thuong_hieu
-- Rớt ở public: mức so sánh là ROI quý 1 của cả ba thương hiệu (truy vấn con không gắn với thương hiệu).
SELECT m.brand_id, m.thang,
       ROUND(m.roi_thang, 4) AS roi_thang,
       ROUND((SELECT (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions)
              FROM campaigns
              WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'), 4) AS roi_quy
FROM (SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_thang
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')) m
WHERE m.roi_thang > (SELECT (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions)
                     FROM campaigns
                     WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01')
ORDER BY m.brand_id, m.thang;

-- [mkt-q4-thang-roi-tren-muc-quy-1] wrong: muc_so_sanh_ca_ky
-- Rớt ở public: mức so sánh là ROI của thương hiệu trong cả kỳ dữ liệu, không phải riêng quý 1.
SELECT m.brand_id, m.thang,
       ROUND(m.roi_thang, 4) AS roi_thang,
       ROUND(q.roi_quy, 4) AS roi_quy
FROM (SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_thang
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')) m
JOIN (SELECT brand_id,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_quy
      FROM campaigns
      GROUP BY brand_id) q ON q.brand_id = m.brand_id
WHERE m.roi_thang > q.roi_quy
ORDER BY m.brand_id, m.thang;

-- [mkt-q4-thang-roi-tren-muc-quy-1] wrong: lam_tron_truoc_khi_so
-- Rớt ở hidden-1: so hai ROI đã làm tròn 2 chữ số; tháng 1 của Tira Beauty chỉ cao hơn ROI quý chưa tới 0,001 nên bị loại.
SELECT m.brand_id, m.thang,
       ROUND(m.roi_thang, 4) AS roi_thang,
       ROUND(q.roi_quy, 4) AS roi_quy
FROM (SELECT brand_id, DATE_FORMAT(start_date, '%Y-%m') AS thang,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_thang
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id, DATE_FORMAT(start_date, '%Y-%m')) m
JOIN (SELECT brand_id,
             (SUM(revenue) - SUM(acquisition_cost * conversions)) / SUM(acquisition_cost * conversions) AS roi_quy
      FROM campaigns
      WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
      GROUP BY brand_id) q ON q.brand_id = m.brand_id
WHERE ROUND(m.roi_thang, 2) > ROUND(q.roi_quy, 2)
ORDER BY m.brand_id, m.thang;

-- [mkt-q5-ty-trong-loai-purplle] solution
SELECT t.type_name, SUM(c.revenue) AS doanh_thu,
       ROUND(SUM(c.revenue) * 100 / (SELECT SUM(revenue) FROM campaigns WHERE brand_id = 2), 2) AS ty_trong_pct
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
WHERE c.brand_id = 2
GROUP BY t.type_id, t.type_name
ORDER BY doanh_thu DESC;

-- [mkt-q5-ty-trong-loai-purplle] wrong: mau_so_ca_ba_thuong_hieu
-- Rớt ở public: mẫu số là doanh thu của cả ba thương hiệu, các tỷ trọng cộng lại chỉ khoảng một phần ba.
SELECT t.type_name, SUM(c.revenue) AS doanh_thu,
       ROUND(SUM(c.revenue) * 100 / (SELECT SUM(revenue) FROM campaigns), 2) AS ty_trong_pct
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
WHERE c.brand_id = 2
GROUP BY t.type_id, t.type_name
ORDER BY doanh_thu DESC;

-- [mkt-q5-ty-trong-loai-purplle] wrong: thieu_loc_thuong_hieu_ngoai
-- Rớt ở public: tử số lấy doanh thu loại của cả ba thương hiệu, các tỷ trọng cộng lại khoảng 300 phần trăm.
SELECT t.type_name, SUM(c.revenue) AS doanh_thu,
       ROUND(SUM(c.revenue) * 100 / (SELECT SUM(revenue) FROM campaigns WHERE brand_id = 2), 2) AS ty_trong_pct
FROM campaigns c
JOIN campaign_types t ON t.type_id = c.type_id
GROUP BY t.type_id, t.type_name
ORDER BY doanh_thu DESC;

-- [mkt-q6-ngay-purplle-khong-seo] solution
SELECT k.cal_date, k.day_name
FROM calendar k
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND NOT EXISTS (SELECT 1
                  FROM campaigns c
                  WHERE c.brand_id = 2 AND c.type_id = 4
                    AND c.language_id = 4 AND c.target_audience_id = 5
                    AND c.start_date = k.cal_date)
ORDER BY k.cal_date;

-- [mkt-q6-ngay-purplle-khong-seo] wrong: khong_tuong_quan
-- Rớt ở public: truy vấn con không gắn với ngày đang xét nên luôn có dòng, ra 0 ngày.
SELECT k.cal_date, k.day_name
FROM calendar k
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND NOT EXISTS (SELECT 1
                  FROM campaigns c
                  WHERE c.brand_id = 2 AND c.type_id = 4
                    AND c.language_id = 4 AND c.target_audience_id = 5
                    AND c.start_date >= '2025-05-01' AND c.start_date < '2025-06-01')
ORDER BY k.cal_date;

-- [mkt-q6-ngay-purplle-khong-seo] wrong: thieu_can_tren
-- Rớt ở public: lịch không có cận trên nên lấy cả các ngày từ tháng 6/2025.
SELECT k.cal_date, k.day_name
FROM calendar k
WHERE k.cal_date >= '2025-05-01'
  AND NOT EXISTS (SELECT 1
                  FROM campaigns c
                  WHERE c.brand_id = 2 AND c.type_id = 4
                    AND c.language_id = 4 AND c.target_audience_id = 5
                    AND c.start_date = k.cal_date)
ORDER BY k.cal_date;

-- [mkt-q6-ngay-purplle-khong-seo] wrong: nham_phan_khuc
-- Rớt ở public: lọc Youth theo phân khúc khách hàng thay vì đối tượng mục tiêu.
SELECT k.cal_date, k.day_name
FROM calendar k
WHERE k.cal_date >= '2025-05-01' AND k.cal_date < '2025-06-01'
  AND NOT EXISTS (SELECT 1
                  FROM campaigns c
                  WHERE c.brand_id = 2 AND c.type_id = 4
                    AND c.language_id = 4 AND c.segment_id = 5
                    AND c.start_date = k.cal_date)
ORDER BY k.cal_date;

-- [mkt-q7-shoppers-ra-rong] starter
SELECT c.brand_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.start_date >= '2025-05-01' AND c.start_date < '2025-06-01'
  AND c.target_audience_id IN (SELECT a.audience_id
                               FROM audiences a
                               WHERE a.audience_name LIKE 'Shoppers%')
GROUP BY c.brand_id
ORDER BY c.brand_id;

-- [mkt-q7-shoppers-ra-rong] solution
SELECT c.brand_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.start_date >= '2025-05-01' AND c.start_date < '2025-06-01'
  AND c.target_audience_id IN (SELECT a.audience_id
                               FROM audiences a
                               WHERE a.audience_name LIKE '%Shoppers%')
GROUP BY c.brand_id
ORDER BY c.brand_id;

-- [mkt-q7-shoppers-ra-rong] wrong: sua_mau_bo_can_tren
-- Rớt ở public: sửa đúng mẫu nhưng viết lại điều kiện ngày thiếu cận trên.
SELECT c.brand_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.start_date >= '2025-05-01'
  AND c.target_audience_id IN (SELECT a.audience_id
                               FROM audiences a
                               WHERE a.audience_name LIKE '%Shoppers%')
GROUP BY c.brand_id
ORDER BY c.brand_id;

-- [mkt-q7-shoppers-ra-rong] wrong: loc_theo_phan_khuc
-- Rớt ở public: sửa mẫu tên nhưng lọc theo phân khúc khách hàng thay vì đối tượng mục tiêu.
SELECT c.brand_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.start_date >= '2025-05-01' AND c.start_date < '2025-06-01'
  AND c.segment_id IN (SELECT a.audience_id
                       FROM audiences a
                       WHERE a.audience_name LIKE '%Shoppers%')
GROUP BY c.brand_id
ORDER BY c.brand_id;

-- [mkt-q8-dong-sach-khong-nhieu-sai] starter
SELECT r.brand_id, COUNT(*) AS so_dong
FROM campaigns_raw r
WHERE r.row_index NOT IN (SELECT n.row_index FROM noise_log n)
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-q8-dong-sach-khong-nhieu-sai] solution
SELECT r.brand_id, COUNT(*) AS so_dong
FROM campaigns_raw r
WHERE NOT EXISTS (SELECT 1
                  FROM noise_log n
                  WHERE n.brand_id = r.brand_id
                    AND n.row_index = r.row_index)
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-q8-dong-sach-khong-nhieu-sai] wrong: theo_ma_chien_dich
-- Rớt ở public: so theo campaign_id loại luôn bản chép của dòng trùng (cùng mã với dòng gốc).
SELECT r.brand_id, COUNT(*) AS so_dong
FROM campaigns_raw r
WHERE r.campaign_id NOT IN (SELECT n.campaign_id FROM noise_log n)
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-q8-dong-sach-khong-nhieu-sai] wrong: tuong_quan_theo_ma_va_thuong_hieu
-- Rớt ở public: NOT EXISTS theo brand_id và campaign_id, vẫn loại bản chép của dòng trùng.
SELECT r.brand_id, COUNT(*) AS so_dong
FROM campaigns_raw r
WHERE NOT EXISTS (SELECT 1
                  FROM noise_log n
                  WHERE n.brand_id = r.brand_id
                    AND n.campaign_id = r.campaign_id)
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-q9-tuong-tac-tren-binh-quan-hai-loi] starter
SELECT c.type_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.brand_id = 1
  AND c.start_date >= '2025-03-07' AND c.start_date < '2025-03-09'
  AND c.engagement_score > (SELECT AVG(engagement_score)
                            FROM campaigns
                            WHERE start_date >= '2025-03-07' AND start_date < '2025-03-09'
                              AND type_id = type_id)
GROUP BY c.type_id
ORDER BY c.type_id;

-- [mkt-q9-tuong-tac-tren-binh-quan-hai-loi] solution
SELECT c.type_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.brand_id = 1
  AND c.start_date >= '2025-03-07' AND c.start_date < '2025-03-09'
  AND c.engagement_score > (SELECT AVG(c2.engagement_score)
                            FROM campaigns c2
                            WHERE c2.brand_id = 1
                              AND c2.start_date >= '2025-03-07' AND c2.start_date < '2025-03-09'
                              AND c2.type_id = c.type_id)
GROUP BY c.type_id
ORDER BY c.type_id;

-- [mkt-q9-tuong-tac-tren-binh-quan-hai-loi] wrong: chi_sua_bi_danh
-- Rớt ở public: truy vấn con đã gắn với loại nhưng vẫn lấy cả ba thương hiệu.
SELECT c.type_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.brand_id = 1
  AND c.start_date >= '2025-03-07' AND c.start_date < '2025-03-09'
  AND c.engagement_score > (SELECT AVG(c2.engagement_score)
                            FROM campaigns c2
                            WHERE c2.start_date >= '2025-03-07' AND c2.start_date < '2025-03-09'
                              AND c2.type_id = c.type_id)
GROUP BY c.type_id
ORDER BY c.type_id;

-- [mkt-q9-tuong-tac-tren-binh-quan-hai-loi] wrong: chi_them_loc_thuong_hieu
-- Rớt ở public: truy vấn con đã lọc Nykaa nhưng type_id = type_id vẫn so cột với chính nó, ra bình quân mọi loại.
SELECT c.type_id, COUNT(*) AS so_chien_dich
FROM campaigns c
WHERE c.brand_id = 1
  AND c.start_date >= '2025-03-07' AND c.start_date < '2025-03-09'
  AND c.engagement_score > (SELECT AVG(engagement_score)
                            FROM campaigns
                            WHERE brand_id = 1
                              AND start_date >= '2025-03-07' AND start_date < '2025-03-09'
                              AND type_id = type_id)
GROUP BY c.type_id
ORDER BY c.type_id;

-- ================================================ CASE STUDY

-- [mkt-c5-kenh-hieu-qua-hon.b1] solution
SELECT ch.channel_name, COUNT(*) AS so_chien_dich,
       ROUND(SUM(c.clicks) * 100 / SUM(c.impressions), 2) AS ctr_pct
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY ch.channel_id, ch.channel_name
ORDER BY ctr_pct DESC, ch.channel_name;

-- [mkt-c5-kenh-hieu-qua-hon.b1] wrong: binh_quan_ctr_tung_chien_dich
-- Rớt ở public: CTR là bình quân giản đơn của từng chiến dịch.
SELECT ch.channel_name, COUNT(*) AS so_chien_dich,
       ROUND(AVG(c.clicks * 100 / c.impressions), 2) AS ctr_pct
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY ch.channel_id, ch.channel_name
ORDER BY ctr_pct DESC, ch.channel_name;

-- [mkt-c5-kenh-hieu-qua-hon.b1] wrong: thieu_can_tren
-- Rớt ở hidden-1: chiến dịch ngày 2025-07-01 cộng thêm vào WhatsApp và YouTube.
SELECT ch.channel_name, COUNT(*) AS so_chien_dich,
       ROUND(SUM(c.clicks) * 100 / SUM(c.impressions), 2) AS ctr_pct
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
WHERE c.start_date >= '2025-01-01'
GROUP BY ch.channel_id, ch.channel_name
ORDER BY ctr_pct DESC, ch.channel_name;

-- [mkt-c5-kenh-hieu-qua-hon.b2] solution
SELECT ch.channel_name,
       SUM(c.revenue) AS doanh_thu,
       ROUND(SUM(c.acquisition_cost * c.conversions), 2) AS chi_phi,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost * c.conversions))
             / SUM(c.acquisition_cost * c.conversions), 4) AS roi
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY ch.channel_id, ch.channel_name
ORDER BY roi DESC, ch.channel_name;

-- [mkt-c5-kenh-hieu-qua-hon.b2] wrong: binh_quan_cot_roi
-- Rớt ở public: AVG(roi) là bình quân giản đơn, cao hơn hẳn ROI của tổng.
SELECT ch.channel_name,
       SUM(c.revenue) AS doanh_thu,
       ROUND(SUM(c.acquisition_cost * c.conversions), 2) AS chi_phi,
       ROUND(AVG(c.roi), 4) AS roi
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY ch.channel_id, ch.channel_name
ORDER BY roi DESC, ch.channel_name;

-- [mkt-c5-kenh-hieu-qua-hon.b2] wrong: chi_phi_la_acquisition_cost
-- Rớt ở public: coi acquisition_cost là chi phí cả chiến dịch.
SELECT ch.channel_name,
       SUM(c.revenue) AS doanh_thu,
       ROUND(SUM(c.acquisition_cost), 2) AS chi_phi,
       ROUND((SUM(c.revenue) - SUM(c.acquisition_cost)) / SUM(c.acquisition_cost), 4) AS roi
FROM campaigns c
JOIN campaign_channels cc ON cc.campaign_id = c.campaign_id
JOIN channels ch ON ch.channel_id = cc.channel_id
WHERE c.start_date >= '2025-01-01' AND c.start_date < '2025-07-01'
GROUP BY ch.channel_id, ch.channel_name
ORDER BY roi DESC, ch.channel_name;

-- [mkt-c6-tho-va-sach-lech-o-dau.b1] solution
SELECT r.brand_id,
       COUNT(*) AS so_dong_tho,
       COUNT(DISTINCT r.campaign_id) AS so_ma_tho,
       (SELECT COUNT(*) FROM campaigns c WHERE c.brand_id = r.brand_id) AS so_chien_dich_sach
FROM campaigns_raw r
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-c6-tho-va-sach-lech-o-dau.b1] wrong: dem_ma_khong_distinct
-- Rớt ở public: COUNT(campaign_id) đếm cả bản chép của dòng trùng.
SELECT r.brand_id,
       COUNT(*) AS so_dong_tho,
       COUNT(r.campaign_id) AS so_ma_tho,
       (SELECT COUNT(*) FROM campaigns c WHERE c.brand_id = r.brand_id) AS so_chien_dich_sach
FROM campaigns_raw r
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-c6-tho-va-sach-lech-o-dau.b2] solution
SELECT r.brand_id, COUNT(*) AS so_dong_lech
FROM campaigns_raw r
JOIN campaigns c ON c.campaign_id = r.campaign_id
WHERE NOT (r.impressions <=> c.impressions)
   OR NOT (r.clicks <=> c.clicks)
   OR NOT (r.leads <=> c.leads)
   OR NOT (r.conversions <=> c.conversions)
   OR NOT (r.revenue <=> c.revenue)
   OR NOT (r.acquisition_cost <=> c.acquisition_cost)
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-c6-tho-va-sach-lech-o-dau.b2] wrong: so_khac_bo_qua_null
-- Rớt ở public: NULL <> giá trị cho NULL (không đúng), bỏ sót mọi ô trống.
SELECT r.brand_id, COUNT(*) AS so_dong_lech
FROM campaigns_raw r
JOIN campaigns c ON c.campaign_id = r.campaign_id
WHERE r.impressions <> c.impressions
   OR r.clicks <> c.clicks
   OR r.leads <> c.leads
   OR r.conversions <> c.conversions
   OR r.revenue <> c.revenue
   OR r.acquisition_cost <> c.acquisition_cost
GROUP BY r.brand_id
ORDER BY r.brand_id;

-- [mkt-c6-tho-va-sach-lech-o-dau.b3] solution
SELECT n.noise_type,
       COUNT(*) AS so_dong_nhat_ky,
       COUNT(CASE WHEN NOT (r.impressions <=> c.impressions)
                    OR NOT (r.clicks <=> c.clicks)
                    OR NOT (r.leads <=> c.leads)
                    OR NOT (r.conversions <=> c.conversions)
                    OR NOT (r.revenue <=> c.revenue)
                    OR NOT (r.acquisition_cost <=> c.acquisition_cost)
                  THEN 1 END) AS so_dong_lech_chi_so
FROM noise_log n
JOIN campaigns_raw r ON r.brand_id = n.brand_id AND r.row_index = n.row_index
JOIN campaigns c ON c.campaign_id = r.campaign_id
GROUP BY n.noise_type
ORDER BY n.noise_type;

-- [mkt-c6-tho-va-sach-lech-o-dau.b3] wrong: noi_theo_campaign_id
-- Rớt ở public: nối nhật ký với bản thô theo campaign_id, dòng DUPLICATE khớp cả dòng gốc lẫn bản chép.
SELECT n.noise_type,
       COUNT(*) AS so_dong_nhat_ky,
       COUNT(CASE WHEN NOT (r.impressions <=> c.impressions)
                    OR NOT (r.clicks <=> c.clicks)
                    OR NOT (r.leads <=> c.leads)
                    OR NOT (r.conversions <=> c.conversions)
                    OR NOT (r.revenue <=> c.revenue)
                    OR NOT (r.acquisition_cost <=> c.acquisition_cost)
                  THEN 1 END) AS so_dong_lech_chi_so
FROM noise_log n
JOIN campaigns_raw r ON r.campaign_id = n.campaign_id
JOIN campaigns c ON c.campaign_id = r.campaign_id
GROUP BY n.noise_type
ORDER BY n.noise_type;

-- [mkt-c6-tho-va-sach-lech-o-dau.b3] wrong: noi_chi_theo_vi_tri
-- Rớt ở public: row_index lặp ở cả ba file nên mỗi dòng nhật ký khớp ba dòng thô.
SELECT n.noise_type,
       COUNT(*) AS so_dong_nhat_ky,
       COUNT(CASE WHEN NOT (r.impressions <=> c.impressions)
                    OR NOT (r.clicks <=> c.clicks)
                    OR NOT (r.leads <=> c.leads)
                    OR NOT (r.conversions <=> c.conversions)
                    OR NOT (r.revenue <=> c.revenue)
                    OR NOT (r.acquisition_cost <=> c.acquisition_cost)
                  THEN 1 END) AS so_dong_lech_chi_so
FROM noise_log n
JOIN campaigns_raw r ON r.row_index = n.row_index
JOIN campaigns c ON c.campaign_id = r.campaign_id
GROUP BY n.noise_type
ORDER BY n.noise_type;
