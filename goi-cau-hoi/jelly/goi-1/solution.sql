-- solution.sql: gói 1 của bộ GAME Jelly Trail Academy (dulieu=jelly), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên jelly (public) và jelly_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.

-- ======================================================================= MODULE 1 · RETRIEVAL

-- [jelly-r1-cai-moi-29-8-vn] solution
SELECT user_id, platform, channel
FROM users
WHERE install_date = '2026-08-29'
  AND country = 'VN'
ORDER BY user_id;

-- [jelly-r1-cai-moi-29-8-vn] wrong: quen_dieu_kien_quoc_gia
-- Rớt ở public: lấy người cài ngày 29/8 ở mọi thị trường.
SELECT user_id, platform, channel
FROM users
WHERE install_date = '2026-08-29'
ORDER BY user_id;

-- [jelly-r1-cai-moi-29-8-vn] wrong: ghi_ten_quoc_gia
-- Rớt ở public: cột country lưu mã ISO 2 chữ, ghi tên nước ra 0 dòng.
SELECT user_id, platform, channel
FROM users
WHERE install_date = '2026-08-29'
  AND country = 'Vietnam'
ORDER BY user_id;

-- [jelly-r2-giao-dich-season-pass] solution
SELECT transaction_id, user_id, event_time
FROM purchases
WHERE product_type = 'season_pass'
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
ORDER BY event_time, transaction_id;

-- [jelly-r2-giao-dich-season-pass] wrong: loc_ten_goi_sai_chu
-- Rớt ở public: product_name là 'Season Pass', viết theo mã gói ra 0 dòng.
SELECT transaction_id, user_id, event_time
FROM purchases
WHERE product_name = 'season_pass'
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
ORDER BY event_time, transaction_id;

-- [jelly-r2-giao-dich-season-pass] wrong: thieu_can_tren
-- Rớt ở public: lấy cả giao dịch Season Pass tháng 8.
SELECT transaction_id, user_id, event_time
FROM purchases
WHERE product_type = 'season_pass'
  AND event_date >= '2026-07-01'
ORDER BY event_time, transaction_id;

-- [jelly-r3-man-sieu-kho] solution
SELECT level_id, world_name, moves_limit
FROM level_metadata
WHERE difficulty_tag = 'super_hard'
ORDER BY level_id;

-- [jelly-r3-man-sieu-kho] wrong: like_lay_ca_hard
-- Rớt ở public: '%hard%' lấy cả màn có nhãn 'hard'.
SELECT level_id, world_name, moves_limit
FROM level_metadata
WHERE difficulty_tag LIKE '%hard%'
ORDER BY level_id;

-- [jelly-r3-man-sieu-kho] wrong: khac_normal
-- Rớt ở public: mọi màn không phải 'normal' gồm cả 'hard'.
SELECT level_id, world_name, moves_limit
FROM level_metadata
WHERE difficulty_tag <> 'normal'
ORDER BY level_id;

-- [jelly-r4-ngay-chi-cao-social] solution
SELECT `date`, spend_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-SOCIAL-204'
  AND country = 'VN'
  AND target_platform = 'Android'
  AND `date` >= '2026-08-15'
ORDER BY spend_usd DESC, `date`
LIMIT 10;

-- [jelly-r4-ngay-chi-cao-social] wrong: thieu_dieu_kien_nen_tang
-- Rớt ở public: dòng iOS ngày 23/8 lọt vào 10 dòng đầu.
SELECT `date`, spend_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-SOCIAL-204'
  AND country = 'VN'
  AND `date` >= '2026-08-15'
ORDER BY spend_usd DESC, `date`
LIMIT 10;

-- [jelly-r4-ngay-chi-cao-social] wrong: gan_cung_ngay_cuoi
-- Rớt ở hidden-1: chép ngày cuối của dữ liệu Chạy thử (29/8) làm cận trên nên mất ngày chi mới 2026-09-01.
SELECT `date`, spend_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-SOCIAL-204'
  AND country = 'VN'
  AND target_platform = 'Android'
  AND `date` BETWEEN '2026-08-15' AND '2026-08-29'
ORDER BY spend_usd DESC, `date`
LIMIT 10;

-- [jelly-r5-luot-dai-man-30] solution
SELECT attempt_id, user_id, event_date, duration_sec, result
FROM level_attempts
WHERE level_id = 30
  AND platform = 'Android'
  AND app_version = '2.1.0'
ORDER BY duration_sec DESC, attempt_id
LIMIT 20;

-- [jelly-r5-luot-dai-man-30] wrong: phien_ban_luc_cai
-- Rớt ở public: lọc theo phiên bản lúc cài của người chơi, không phải phiên bản lúc chơi lượt đó.
SELECT a.attempt_id, a.user_id, a.event_date, a.duration_sec, a.result
FROM level_attempts a
JOIN users u ON u.user_id = a.user_id
WHERE a.level_id = 30
  AND a.platform = 'Android'
  AND u.app_version_install = '2.1.0'
ORDER BY a.duration_sec DESC, a.attempt_id
LIMIT 20;

-- [jelly-r5-luot-dai-man-30] wrong: quen_dieu_kien_nen_tang
-- Rớt ở public: lẫn lượt chơi trên iOS.
SELECT attempt_id, user_id, event_date, duration_sec, result
FROM level_attempts
WHERE level_id = 30
  AND app_version = '2.1.0'
ORDER BY duration_sec DESC, attempt_id
LIMIT 20;

-- [jelly-r6-su-kien-thang-8] solution
SELECT event_name, start_date, end_date
FROM liveops_events
WHERE start_date <= '2026-08-09'
  AND end_date >= '2026-07-26'
ORDER BY start_date;

-- [jelly-r6-su-kien-thang-8] wrong: hoac_thay_va
-- Rớt ở public: nối hai điều kiện bằng OR lấy cả ba sự kiện.
SELECT event_name, start_date, end_date
FROM liveops_events
WHERE start_date <= '2026-08-09'
   OR end_date >= '2026-07-26'
ORDER BY start_date;

-- [jelly-r6-su-kien-thang-8] wrong: bat_dau_trong_khoang
-- Rớt ở public: chỉ lấy sự kiện bắt đầu trong khoảng, mất sự kiện 24/7 tới 28/7 đang chạy dở.
SELECT event_name, start_date, end_date
FROM liveops_events
WHERE start_date >= '2026-07-26'
  AND start_date <= '2026-08-09'
ORDER BY start_date;

-- [jelly-r6-su-kien-thang-8] wrong: nam_tron_trong_khoang
-- Rớt ở public: đòi sự kiện nằm trọn trong khoảng, mất cả hai sự kiện vắt qua mốc đầu và mốc cuối.
SELECT event_name, start_date, end_date
FROM liveops_events
WHERE start_date >= '2026-07-26'
  AND end_date <= '2026-08-09'
ORDER BY start_date;

-- [jelly-r7-organic-ios-tuan-dau] starter
SELECT user_id, install_date, channel
FROM users
WHERE country = 'VN'
  AND platform = 'iOS'
  AND install_date BETWEEN '2026-07-01' AND '2026-07-07'
  AND channel = 'Organic' OR channel = 'Search Ads'
ORDER BY user_id;

-- [jelly-r7-organic-ios-tuan-dau] solution
SELECT user_id, install_date, channel
FROM users
WHERE country = 'VN'
  AND platform = 'iOS'
  AND install_date BETWEEN '2026-07-01' AND '2026-07-07'
  AND (channel = 'Organic' OR channel = 'Search Ads')
ORDER BY user_id;

-- [jelly-r7-organic-ios-tuan-dau] wrong: bo_kenh_search_ads
-- Rớt ở public: bỏ hẳn điều kiện sau OR nên mất người chơi đến từ Search Ads.
SELECT user_id, install_date, channel
FROM users
WHERE country = 'VN'
  AND platform = 'iOS'
  AND install_date BETWEEN '2026-07-01' AND '2026-07-07'
  AND channel = 'Organic'
ORDER BY user_id;

-- [jelly-r7-organic-ios-tuan-dau] wrong: and_thay_or
-- Rớt ở public: đổi OR thành AND, một người chơi không thể thuộc hai kênh nên ra 0 dòng.
SELECT user_id, install_date, channel
FROM users
WHERE country = 'VN'
  AND platform = 'iOS'
  AND install_date BETWEEN '2026-07-01' AND '2026-07-07'
  AND channel = 'Organic' AND channel = 'Search Ads'
ORDER BY user_id;

-- [jelly-r8-giao-dich-thang-8-thua] starter
SELECT transaction_id, user_id, event_date, product_type, price_usd
FROM purchases
WHERE country = 'GB'
  AND event_date >= '2026-08-01'
ORDER BY event_date, transaction_id;

-- [jelly-r8-giao-dich-thang-8-thua] solution
SELECT transaction_id, user_id, event_date, product_type, price_usd
FROM purchases
WHERE country = 'GB'
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
ORDER BY event_date, transaction_id;

-- [jelly-r8-giao-dich-thang-8-thua] wrong: between_gom_ca_ngay_1_9
-- Rớt ở hidden-1: BETWEEN lấy cả hai đầu mút nên vẫn gồm giao dịch ngày 2026-09-01.
SELECT transaction_id, user_id, event_date, product_type, price_usd
FROM purchases
WHERE country = 'GB'
  AND event_date BETWEEN '2026-08-01' AND '2026-09-01'
ORDER BY event_date, transaction_id;

-- [jelly-r8-giao-dich-thang-8-thua] wrong: lon_hon_thay_lon_hon_bang
-- Rớt ở public: thêm cận trên nhưng đổi cận dưới thành > nên mất các giao dịch ngày 1/8.
SELECT transaction_id, user_id, event_date, product_type, price_usd
FROM purchases
WHERE country = 'GB'
  AND event_date > '2026-08-01' AND event_date < '2026-09-01'
ORDER BY event_date, transaction_id;

-- [jelly-r9-phien-dai-15-8] starter
SELECT session_id, user_id, session_start, duration_minutes
FROM sessions
WHERE event_date = '2026-08-15'
ORDER BY duration_minutes
LIMIT 5;

-- [jelly-r9-phien-dai-15-8] solution
SELECT session_id, user_id, session_start, duration_minutes
FROM sessions
WHERE event_date = '2026-08-15'
ORDER BY duration_minutes DESC, session_id
LIMIT 5;

-- [jelly-r9-phien-dai-15-8] wrong: tieu_chi_phu_nguoc_chieu
-- Rớt ở public: đổi cả hai cột sang giảm dần, hai phiên 41 phút ở hạng 5 đổi chỗ nhau.
SELECT session_id, user_id, session_start, duration_minutes
FROM sessions
WHERE event_date = '2026-08-15'
ORDER BY duration_minutes DESC, session_id DESC
LIMIT 5;

-- [jelly-r9-phien-dai-15-8] wrong: loc_thoi_diem_bang_ngay
-- Rớt ở public: session_start có giờ, so bằng '2026-08-15' chỉ khớp phiên mở đúng 0 giờ.
SELECT session_id, user_id, session_start, duration_minutes
FROM sessions
WHERE session_start = '2026-08-15'
ORDER BY duration_minutes DESC, session_id
LIMIT 5;

-- ======================================================================= MODULE 2 · NULL & EXPRESSIONS

-- [jelly-n1-iap-khong-gan-man] solution
SELECT COUNT(*) AS so_giao_dich
FROM purchases
WHERE level_id_if_relevant IS NULL;

-- [jelly-n1-iap-khong-gan-man] wrong: bang_null
-- Rớt ở public: so = NULL không bao giờ đúng, ra 0.
SELECT COUNT(*) AS so_giao_dich
FROM purchases
WHERE level_id_if_relevant = NULL;

-- [jelly-n1-iap-khong-gan-man] wrong: dem_cot_null
-- Rớt ở public: COUNT(cột) bỏ qua ô trống nên đếm ra 0.
SELECT COUNT(level_id_if_relevant) AS so_giao_dich
FROM purchases
WHERE level_id_if_relevant IS NULL;

-- [jelly-n2-chua-tiep-xuc-ab] solution
SELECT user_id, variant
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing'
  AND exposed_at IS NULL
ORDER BY user_id
LIMIT 20;

-- [jelly-n2-chua-tiep-xuc-ab] wrong: bang_null
-- Rớt ở public: exposed_at = NULL ra 0 dòng.
SELECT user_id, variant
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing'
  AND exposed_at = NULL
ORDER BY user_id
LIMIT 20;

-- [jelly-n2-chua-tiep-xuc-ab] wrong: dao_dieu_kien
-- Rớt ở public: IS NOT NULL lấy người đã tiếp xúc.
SELECT user_id, variant
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing'
  AND exposed_at IS NOT NULL
ORDER BY user_id
LIMIT 20;

-- [jelly-n3-nhom-buoc-du] solution
SELECT attempt_id, result, moves_left,
       CASE WHEN moves_left = 0 THEN 'het_luot_di'
            WHEN moves_left <= 2 THEN 'du_1_2'
            ELSE 'du_tu_3' END AS nhom_luot_du
FROM level_attempts
WHERE level_id = 28
  AND event_date = '2026-08-01'
ORDER BY attempt_id;

-- [jelly-n3-nhom-buoc-du] wrong: sai_thu_tu_nhanh
-- Rớt ở public: nhánh <= 2 đứng trước nên lượt còn 0 lượt đi bị gán 'du_1_2'.
SELECT attempt_id, result, moves_left,
       CASE WHEN moves_left <= 2 THEN 'du_1_2'
            WHEN moves_left = 0 THEN 'het_luot_di'
            ELSE 'du_tu_3' END AS nhom_luot_du
FROM level_attempts
WHERE level_id = 28
  AND event_date = '2026-08-01'
ORDER BY attempt_id;

-- [jelly-n3-nhom-buoc-du] wrong: gan_theo_ket_qua
-- Rớt ở public: lượt thắng còn 0 lượt đi bị gán 'du_1_2' vì nhóm theo kết quả thay vì theo số lượt còn dư.
SELECT attempt_id, result, moves_left,
       CASE WHEN result <> 'complete' THEN 'het_luot_di'
            WHEN moves_left <= 2 THEN 'du_1_2'
            ELSE 'du_tu_3' END AS nhom_luot_du
FROM level_attempts
WHERE level_id = 28
  AND event_date = '2026-08-01'
ORDER BY attempt_id;

-- [jelly-n4-tong-doanh-thu-ngay] solution
SELECT `date`,
       iap_revenue + ad_revenue AS tong_doanh_thu,
       ROUND(100 * ad_revenue / (iap_revenue + ad_revenue), 2) AS ty_trong_quang_cao_pct
FROM daily_kpi
WHERE `date` BETWEEN '2026-07-01' AND '2026-07-07'
ORDER BY `date`;

-- [jelly-n4-tong-doanh-thu-ngay] wrong: thieu_ngoac_mau_so
-- Rớt ở public: phép chia làm trước phép cộng.
SELECT `date`,
       iap_revenue + ad_revenue AS tong_doanh_thu,
       ROUND(100 * ad_revenue / iap_revenue + ad_revenue, 2) AS ty_trong_quang_cao_pct
FROM daily_kpi
WHERE `date` BETWEEN '2026-07-01' AND '2026-07-07'
ORDER BY `date`;

-- [jelly-n4-tong-doanh-thu-ngay] wrong: chia_cho_iap
-- Rớt ở public: mẫu số là doanh thu IAP thay vì tổng doanh thu.
SELECT `date`,
       iap_revenue + ad_revenue AS tong_doanh_thu,
       ROUND(100 * ad_revenue / iap_revenue, 2) AS ty_trong_quang_cao_pct
FROM daily_kpi
WHERE `date` BETWEEN '2026-07-01' AND '2026-07-07'
ORDER BY `date`;

-- [jelly-n5-gia-quy-doi-vnd] solution
SELECT DISTINCT product_name, price_usd,
       ROUND(price_usd * 25400, -3) AS gia_vnd
FROM purchases
ORDER BY price_usd;

-- [jelly-n5-gia-quy-doi-vnd] wrong: thieu_distinct
-- Rớt ở public: mỗi giao dịch một dòng, ra hàng nghìn dòng.
SELECT product_name, price_usd,
       ROUND(price_usd * 25400, -3) AS gia_vnd
FROM purchases
ORDER BY price_usd;

-- [jelly-n5-gia-quy-doi-vnd] wrong: lam_tron_sai_chieu
-- Rớt ở public: ROUND(x, 3) giữ 3 chữ số thập phân, không làm tròn tới hàng nghìn.
SELECT DISTINCT product_name, price_usd,
       ROUND(price_usd * 25400, 3) AS gia_vnd
FROM purchases
ORDER BY price_usd;

-- [jelly-n6-ngay-choi-khong-doanh-thu] solution
SELECT COUNT(*) AS so_ngay_choi,
       COUNT(CASE WHEN iap_revenue + ad_revenue = 0 THEN 1 END) AS so_ngay_khong_doanh_thu
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01';

-- [jelly-n6-ngay-choi-khong-doanh-thu] wrong: lam_tron_truoc_khi_so
-- Rớt ở public: làm tròn 2 chữ số biến doanh thu quảng cáo rất nhỏ thành 0.
SELECT COUNT(*) AS so_ngay_choi,
       COUNT(CASE WHEN ROUND(iap_revenue + ad_revenue, 2) = 0 THEN 1 END) AS so_ngay_khong_doanh_thu
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01';

-- [jelly-n6-ngay-choi-khong-doanh-thu] wrong: thieu_can_tren
-- Rớt ở public: lấy cả tháng 8.
SELECT COUNT(*) AS so_ngay_choi,
       COUNT(CASE WHEN iap_revenue + ad_revenue = 0 THEN 1 END) AS so_ngay_khong_doanh_thu
FROM player_daily
WHERE activity_date >= '2026-07-01';

-- [jelly-n7-crash-null] starter
SELECT COUNT(*) AS so_luot_su_co
FROM level_attempts
WHERE result = 'Crash '
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n7-crash-null] solution
SELECT COUNT(*) AS so_luot_su_co
FROM level_attempts
WHERE result = 'crash'
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n7-crash-null] wrong: bo_khoang_ngay
-- Rớt ở public: sửa đúng chuỗi nhưng xoá luôn điều kiện tháng, đếm cả tháng 8.
SELECT COUNT(*) AS so_luot_su_co
FROM level_attempts
WHERE result = 'crash';

-- [jelly-n7-crash-null] wrong: lay_crash_count
-- Rớt ở public: crash_count của bảng hoạt động ngày là nguồn đếm khác, không khớp số lượt chơi gặp sự cố.
SELECT SUM(crash_count) AS so_luot_su_co
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01';

-- [jelly-n8-ty-le-sai-chia] starter
SELECT `date`, dau,
       ROUND(iap_revenue + ad_revenue / dau, 4) AS arpdau_tinh,
       arpdau
FROM daily_kpi
WHERE `date` BETWEEN '2026-08-15' AND '2026-08-21'
ORDER BY `date`;

-- [jelly-n8-ty-le-sai-chia] solution
SELECT `date`, dau,
       ROUND((iap_revenue + ad_revenue) / dau, 4) AS arpdau_tinh,
       arpdau
FROM daily_kpi
WHERE `date` BETWEEN '2026-08-15' AND '2026-08-21'
ORDER BY `date`;

-- [jelly-n8-ty-le-sai-chia] wrong: lam_tron_2_chu_so
-- Rớt ở public (saiso 0,0001): làm tròn 2 chữ số làm mất phần lẻ của ARPDAU.
SELECT `date`, dau,
       ROUND((iap_revenue + ad_revenue) / dau, 2) AS arpdau_tinh,
       arpdau
FROM daily_kpi
WHERE `date` BETWEEN '2026-08-15' AND '2026-08-21'
ORDER BY `date`;

-- [jelly-n8-ty-le-sai-chia] wrong: chi_doanh_thu_iap
-- Rớt ở public: bỏ doanh thu quảng cáo khỏi tử số.
SELECT `date`, dau,
       ROUND(iap_revenue / dau, 4) AS arpdau_tinh,
       arpdau
FROM daily_kpi
WHERE `date` BETWEEN '2026-08-15' AND '2026-08-21'
ORDER BY `date`;

-- [jelly-n9-nhan-nguoi-tra-tien] starter
SELECT CASE WHEN iap_revenue >= 0 THEN 'tra_tien' ELSE 'khong_tra_tien' END AS nhom,
       COUNT(*) AS so_nguoi_choi
FROM player_daily
WHERE activity_date = '2026-08-15'
GROUP BY nhom
ORDER BY nhom;

-- [jelly-n9-nhan-nguoi-tra-tien] solution
SELECT CASE WHEN iap_revenue > 0 THEN 'tra_tien' ELSE 'khong_tra_tien' END AS nhom,
       COUNT(*) AS so_nguoi_choi
FROM player_daily
WHERE activity_date = '2026-08-15'
GROUP BY nhom
ORDER BY nhom;

-- [jelly-n9-nhan-nguoi-tra-tien] wrong: tinh_ca_doanh_thu_quang_cao
-- Rớt ở public: người chỉ xem quảng cáo cũng bị gán 'tra_tien'.
SELECT CASE WHEN iap_revenue + ad_revenue > 0 THEN 'tra_tien' ELSE 'khong_tra_tien' END AS nhom,
       COUNT(*) AS so_nguoi_choi
FROM player_daily
WHERE activity_date = '2026-08-15'
GROUP BY nhom
ORDER BY nhom;

-- ======================================================================= CASE STUDY · CƠ BẢN

-- [jelly-c1-quang-cao-co-thuong.b1] solution
SELECT ad_type,
       COUNT(*) AS so_luot_xem,
       ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd,
       ROUND(1000 * SUM(revenue_usd) / COUNT(*), 2) AS doanh_thu_1000_luot_usd
FROM ad_events
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY ad_type
ORDER BY doanh_thu_usd DESC;

-- [jelly-c1-quang-cao-co-thuong.b1] wrong: thieu_can_tren
-- Rớt ở public: lấy cả quảng cáo tháng 8.
SELECT ad_type,
       COUNT(*) AS so_luot_xem,
       ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd,
       ROUND(1000 * SUM(revenue_usd) / COUNT(*), 2) AS doanh_thu_1000_luot_usd
FROM ad_events
WHERE event_date >= '2026-07-01'
GROUP BY ad_type
ORDER BY doanh_thu_usd DESC;

-- [jelly-c1-quang-cao-co-thuong.b1] wrong: dem_nguoi_xem
-- Rớt ở public: đếm người xem thay vì lượt xem.
SELECT ad_type,
       COUNT(DISTINCT user_id) AS so_luot_xem,
       ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd,
       ROUND(1000 * SUM(revenue_usd) / COUNT(DISTINCT user_id), 2) AS doanh_thu_1000_luot_usd
FROM ad_events
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY ad_type
ORDER BY doanh_thu_usd DESC;

-- [jelly-c2-gia-goi-ban-chay.b1] solution
SELECT product_type,
       COUNT(*) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_usd
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date <= '2026-08-29'
GROUP BY product_type
ORDER BY doanh_thu_usd DESC;

-- [jelly-c2-gia-goi-ban-chay.b1] wrong: dem_nguoi_mua
-- Rớt ở public: đếm người mua thay vì số giao dịch.
SELECT product_type,
       COUNT(DISTINCT user_id) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_usd
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date <= '2026-08-29'
GROUP BY product_type
ORDER BY doanh_thu_usd DESC;

-- [jelly-c2-gia-goi-ban-chay.b1] wrong: khong_gioi_han_ngay
-- Rớt ở hidden-1: lấy cả giao dịch Booster Bundle ngày 2026-09-01.
SELECT product_type,
       COUNT(*) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_usd
FROM purchases
GROUP BY product_type
ORDER BY doanh_thu_usd DESC;
