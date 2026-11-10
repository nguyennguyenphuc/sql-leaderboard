-- solution.sql: gói 2 bộ GAME Jelly Trail Academy (jelly) · Module 3 String & Date, Module 4 Aggregation, case c3, c4.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên jelly (public) và jelly_hidden_1 (hidden-1).
-- Cửa sổ dữ liệu: 2026-07-01 tới 2026-08-29. hidden-1 bỏ người chơi có số thứ tự chia 10 dư 7 và thêm một ngày 2026-09-01.

-- ================================================================ MODULE 3 · STRING & DATE

-- [jelly-s1-gio-cao-diem] solution
SELECT HOUR(session_start) AS gio, COUNT(*) AS so_phien
FROM sessions
WHERE session_start >= '2026-07-01' AND session_start < '2026-08-01'
GROUP BY HOUR(session_start)
ORDER BY gio;

-- [jelly-s1-gio-cao-diem] wrong: lay_gio_tu_cot_ngay
-- event_date kiểu DATE không có phần giờ, HOUR() trả về 0 cho mọi phiên.
SELECT HOUR(event_date) AS gio, COUNT(*) AS so_phien
FROM sessions
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY HOUR(event_date)
ORDER BY gio;

-- [jelly-s1-gio-cao-diem] wrong: quen_can_tren
SELECT HOUR(session_start) AS gio, COUNT(*) AS so_phien
FROM sessions
WHERE session_start >= '2026-07-01'
GROUP BY HOUR(session_start)
ORDER BY gio;

-- [jelly-s2-tach-the-gioi] solution
SELECT level_id,
       SUBSTRING_INDEX(SUBSTRING_INDEX(screen_context, ' > ', 2), ' > ', -1) AS the_gioi,
       world_name
FROM level_metadata
WHERE difficulty_tag <> 'normal'
ORDER BY level_id;

-- [jelly-s2-tach-the-gioi] wrong: tach_thieu_dau_cach
-- Tách theo '>' không kèm dấu cách: tên thế giới còn dấu cách ở hai đầu.
SELECT level_id,
       SUBSTRING_INDEX(SUBSTRING_INDEX(screen_context, '>', 2), '>', -1) AS the_gioi,
       world_name
FROM level_metadata
WHERE difficulty_tag <> 'normal'
ORDER BY level_id;

-- [jelly-s2-tach-the-gioi] wrong: chi_cat_mot_lan
SELECT level_id,
       SUBSTRING_INDEX(screen_context, ' > ', 2) AS the_gioi,
       world_name
FROM level_metadata
WHERE difficulty_tag <> 'normal'
ORDER BY level_id;

-- [jelly-s3-ngay-trong-tuan] solution
SELECT DAYNAME(install_date) AS thu,
       COUNT(DISTINCT install_date) AS so_ngay,
       COUNT(*) AS so_nguoi_cai,
       ROUND(COUNT(*) / COUNT(DISTINCT install_date), 1) AS tb_moi_ngay
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
GROUP BY DAYNAME(install_date), WEEKDAY(install_date)
ORDER BY WEEKDAY(install_date);

-- [jelly-s3-ngay-trong-tuan] wrong: sap_theo_dayofweek
-- DAYOFWEEK đánh số 1 là Chủ nhật, nên Chủ nhật đứng đầu.
SELECT DAYNAME(install_date) AS thu,
       COUNT(DISTINCT install_date) AS so_ngay,
       COUNT(*) AS so_nguoi_cai,
       ROUND(COUNT(*) / COUNT(DISTINCT install_date), 1) AS tb_moi_ngay
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
GROUP BY DAYNAME(install_date), DAYOFWEEK(install_date)
ORDER BY DAYOFWEEK(install_date);

-- [jelly-s3-ngay-trong-tuan] wrong: chia_cho_so_tuan_co_dinh
-- Chia mọi thứ cho 9 tuần, trong khi cửa sổ chỉ có 8 thứ Hai, 8 thứ Ba và 8 Chủ nhật.
SELECT DAYNAME(install_date) AS thu,
       COUNT(DISTINCT install_date) AS so_ngay,
       COUNT(*) AS so_nguoi_cai,
       ROUND(COUNT(*) / 9, 1) AS tb_moi_ngay
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
GROUP BY DAYNAME(install_date), WEEKDAY(install_date)
ORDER BY WEEKDAY(install_date);

-- [jelly-s4-ngay-tu-cai-den-mua] solution
SELECT p.transaction_id, p.user_id, u.install_date, p.event_date,
       DATEDIFF(p.event_date, u.install_date) AS so_ngay
FROM purchases p
JOIN users u ON u.user_id = p.user_id
WHERE p.product_type = 'starter_pack'
ORDER BY so_ngay DESC, p.transaction_id
LIMIT 20;

-- [jelly-s4-ngay-tu-cai-den-mua] wrong: dao_thu_tu_datediff
-- DATEDIFF(a, b) = a - b; đảo đối số ra số âm, sắp giảm dần lấy nhầm giao dịch mua sớm nhất.
SELECT p.transaction_id, p.user_id, u.install_date, p.event_date,
       DATEDIFF(u.install_date, p.event_date) AS so_ngay
FROM purchases p
JOIN users u ON u.user_id = p.user_id
WHERE p.product_type = 'starter_pack'
ORDER BY so_ngay DESC, p.transaction_id
LIMIT 20;

-- [jelly-s4-ngay-tu-cai-den-mua] wrong: thieu_quy_tac_hoa
SELECT p.transaction_id, p.user_id, u.install_date, p.event_date,
       DATEDIFF(p.event_date, u.install_date) AS so_ngay
FROM purchases p
JOIN users u ON u.user_id = p.user_id
WHERE p.product_type = 'starter_pack'
ORDER BY so_ngay DESC, p.transaction_id DESC
LIMIT 20;

-- [jelly-s5-phien-ban-dang-chuoi] solution
SELECT app_version,
       CAST(SUBSTRING_INDEX(app_version, '.', 1) AS UNSIGNED) AS so_chinh,
       CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(app_version, '.', 2), '.', -1) AS UNSIGNED) AS so_phu,
       CAST(SUBSTRING_INDEX(app_version, '.', -1) AS UNSIGNED) AS so_va,
       COUNT(*) AS so_phien,
       MIN(event_date) AS ngay_dau
FROM sessions
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY app_version
ORDER BY so_chinh DESC, so_phu DESC, so_va DESC;

-- [jelly-s5-phien-ban-dang-chuoi] wrong: lay_so_phu_ca_so_chinh
-- SUBSTRING_INDEX(v, '.', 2) trả về '2.1' chứ không phải '1'; CAST thành số nguyên ra 2.
SELECT app_version,
       CAST(SUBSTRING_INDEX(app_version, '.', 1) AS UNSIGNED) AS so_chinh,
       CAST(SUBSTRING_INDEX(app_version, '.', 2) AS UNSIGNED) AS so_phu,
       CAST(SUBSTRING_INDEX(app_version, '.', -1) AS UNSIGNED) AS so_va,
       COUNT(*) AS so_phien,
       MIN(event_date) AS ngay_dau
FROM sessions
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY app_version
ORDER BY so_chinh DESC, so_phu DESC, so_va DESC;

-- [jelly-s5-phien-ban-dang-chuoi] wrong: quen_cua_so
SELECT app_version,
       CAST(SUBSTRING_INDEX(app_version, '.', 1) AS UNSIGNED) AS so_chinh,
       CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(app_version, '.', 2), '.', -1) AS UNSIGNED) AS so_phu,
       CAST(SUBSTRING_INDEX(app_version, '.', -1) AS UNSIGNED) AS so_va,
       COUNT(*) AS so_phien,
       MIN(event_date) AS ngay_dau
FROM sessions
GROUP BY app_version
ORDER BY so_chinh DESC, so_phu DESC, so_va DESC;

-- [jelly-s6-tuan-iso] solution
SELECT YEARWEEK(install_date, 3) AS tuan,
       DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan,
       COUNT(DISTINCT install_date) AS so_ngay_co_du_lieu,
       COUNT(*) AS so_nguoi_cai
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
GROUP BY YEARWEEK(install_date, 3), DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY)
ORDER BY tuan;

-- [jelly-s6-tuan-iso] wrong: tuan_bat_dau_chu_nhat
-- YEARWEEK mặc định (mode 0) bắt đầu tuần vào Chủ nhật, nên chia tuần lệch một ngày.
SELECT YEARWEEK(install_date) AS tuan,
       DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan,
       COUNT(DISTINCT install_date) AS so_ngay_co_du_lieu,
       COUNT(*) AS so_nguoi_cai
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
GROUP BY YEARWEEK(install_date), DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY)
ORDER BY tuan, ngay_dau_tuan;

-- [jelly-s6-tuan-iso] wrong: ngay_dau_tuan_la_ngay_som_nhat
SELECT YEARWEEK(install_date, 3) AS tuan,
       MIN(install_date) AS ngay_dau_tuan,
       COUNT(DISTINCT install_date) AS so_ngay_co_du_lieu,
       COUNT(*) AS so_nguoi_cai
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
GROUP BY YEARWEEK(install_date, 3)
ORDER BY tuan;

-- [jelly-s7-thang-sai-thu-tu] starter
SELECT DATE_FORMAT(event_date, '%M %Y') AS thang,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-09-01'
GROUP BY DATE_FORMAT(event_date, '%M %Y')
ORDER BY thang;

-- [jelly-s7-thang-sai-thu-tu] solution
SELECT DATE_FORMAT(event_date, '%Y-%m') AS thang,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-09-01'
GROUP BY DATE_FORMAT(event_date, '%Y-%m')
ORDER BY thang;

-- [jelly-s7-thang-sai-thu-tu] wrong: ten_thang_sau_nam
-- '%Y-%M' vẫn là tên tháng: '2026-August' đứng trước '2026-July'.
SELECT DATE_FORMAT(event_date, '%Y-%M') AS thang,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-09-01'
GROUP BY DATE_FORMAT(event_date, '%Y-%M')
ORDER BY thang;

-- [jelly-s7-thang-sai-thu-tu] wrong: bo_dieu_kien_ngay
-- Bỏ điều kiện ngày vì nghĩ dữ liệu chỉ có tháng 7, 8: dữ liệu mới về thêm tháng 9 thì báo cáo có thêm dòng.
SELECT DATE_FORMAT(event_date, '%Y-%m') AS thang,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd
FROM purchases
WHERE is_refund = 0
GROUP BY DATE_FORMAT(event_date, '%Y-%m')
ORDER BY thang;

-- [jelly-s8-gio-chua-doi] starter
SELECT attempt_id, event_time, platform, level_id, app_version
FROM level_attempts
WHERE result = 'crash'
  AND event_time BETWEEN '2026-08-15 00:00:00' AND '2026-08-15 11:00:00'
ORDER BY event_time, attempt_id;

-- [jelly-s8-gio-chua-doi] solution
SELECT attempt_id, event_time, platform, level_id, app_version
FROM level_attempts
WHERE result = 'crash'
  AND event_time >= '2026-08-15 00:00:00' AND event_time < '2026-08-15 11:00:00'
ORDER BY event_time, attempt_id;

-- [jelly-s8-gio-chua-doi] wrong: loc_theo_phan_gio
-- HOUR(event_time) <= 11 giữ cả các lượt từ 11 giờ tới 11 giờ 59.
SELECT attempt_id, event_time, platform, level_id, app_version
FROM level_attempts
WHERE result = 'crash'
  AND event_date = '2026-08-15' AND HOUR(event_time) <= 11
ORDER BY event_time, attempt_id;

-- [jelly-s8-gio-chua-doi] wrong: chi_con_can_tren
SELECT attempt_id, event_time, platform, level_id, app_version
FROM level_attempts
WHERE result = 'crash'
  AND event_time < '2026-08-15 11:00:00'
ORDER BY event_time, attempt_id;

-- [jelly-s9-ma-chien-dich] starter
SELECT CASE SUBSTRING(campaign_id, 5, 3)
         WHEN 'SEA' THEN 'Search Ads'
         WHEN 'SOC' THEN 'Social Ads'
         WHEN 'VID' THEN 'Video Network'
         WHEN 'CRE' THEN 'Creator Campaign'
         WHEN 'ORG' THEN 'Organic'
       END AS kenh,
       COUNT(*) AS so_nguoi_choi
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
GROUP BY kenh
ORDER BY so_nguoi_choi DESC, kenh;

-- [jelly-s9-ma-chien-dich] solution
SELECT channel AS kenh, COUNT(*) AS so_nguoi_choi
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
GROUP BY channel
ORDER BY so_nguoi_choi DESC, kenh;

-- [jelly-s9-ma-chien-dich] wrong: cat_truoc_gach_ngang_dau
-- Phần trước dấu '-' đầu tiên là 'JTA' cho mọi kênh trả phí.
SELECT SUBSTRING_INDEX(campaign_id, '-', 1) AS kenh, COUNT(*) AS so_nguoi_choi
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
GROUP BY kenh
ORDER BY so_nguoi_choi DESC, kenh;

-- [jelly-s9-ma-chien-dich] wrong: quen_can_tren
SELECT channel AS kenh, COUNT(*) AS so_nguoi_choi
FROM users
WHERE install_date >= '2026-07-01'
GROUP BY channel
ORDER BY so_nguoi_choi DESC, kenh;

-- ================================================================ MODULE 4 · AGGREGATION

-- [jelly-a1-dau-thang-7] solution
SELECT COUNT(DISTINCT activity_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT activity_date), 1) AS dau_tb
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01';

-- [jelly-a1-dau-thang-7] wrong: dem_nguoi_khac_nhau_ca_thang
-- Số người khác nhau trong cả tháng là MAU; chia 31 không ra DAU bình quân.
SELECT COUNT(DISTINCT activity_date) AS so_ngay,
       ROUND(COUNT(DISTINCT user_id) / 31, 1) AS dau_tb
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01';

-- [jelly-a1-dau-thang-7] wrong: quen_can_tren
SELECT COUNT(DISTINCT activity_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT activity_date), 1) AS dau_tb
FROM player_daily
WHERE activity_date >= '2026-07-01';

-- [jelly-a2-doanh-thu-goi] solution
SELECT product_name,
       COUNT(*) AS so_giao_dich,
       ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(AVG(price_usd), 2) AS gia_tb_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-a2-doanh-thu-goi] wrong: bo_cua_so_du_lieu
SELECT product_name,
       COUNT(*) AS so_giao_dich,
       ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(AVG(price_usd), 2) AS gia_tb_usd
FROM purchases
WHERE is_refund = 0
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-a2-doanh-thu-goi] wrong: dem_nguoi_thay_giao_dich
SELECT product_name,
       COUNT(DISTINCT user_id) AS so_giao_dich,
       ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(AVG(price_usd), 2) AS gia_tb_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-a3-chi-theo-kenh] solution
SELECT channel,
       ROUND(SUM(spend_usd), 2) AS tong_chi_usd,
       ROUND(SUM(spend_usd) / COUNT(DISTINCT `date`), 2) AS chi_tb_ngay_usd
FROM campaign_spend
WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01'
GROUP BY channel
ORDER BY tong_chi_usd DESC;

-- [jelly-a3-chi-theo-kenh] wrong: quen_can_tren
SELECT channel,
       ROUND(SUM(spend_usd), 2) AS tong_chi_usd,
       ROUND(SUM(spend_usd) / COUNT(DISTINCT `date`), 2) AS chi_tb_ngay_usd
FROM campaign_spend
WHERE `date` >= '2026-08-01'
GROUP BY channel
ORDER BY tong_chi_usd DESC;

-- [jelly-a3-chi-theo-kenh] wrong: avg_theo_dong
-- Mỗi dòng là một ngày × quốc gia × nền tảng, AVG(spend_usd) là chi bình quân một dòng, không phải một ngày.
SELECT channel,
       ROUND(SUM(spend_usd), 2) AS tong_chi_usd,
       ROUND(AVG(spend_usd), 2) AS chi_tb_ngay_usd
FROM campaign_spend
WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01'
GROUP BY channel
ORDER BY tong_chi_usd DESC;

-- [jelly-a4-ty-le-thang-man] solution
SELECT level_id, world_name,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result = 'complete' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY level_id, world_name
ORDER BY ty_le_thang_pct, level_id;

-- [jelly-a4-ty-le-thang-man] wrong: bo_luot_su_co_khoi_mau_so
SELECT level_id, world_name,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result = 'complete' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
  AND result <> 'crash'
GROUP BY level_id, world_name
ORDER BY ty_le_thang_pct, level_id;

-- [jelly-a4-ty-le-thang-man] wrong: bo_cua_so_du_lieu
SELECT level_id, world_name,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result = 'complete' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
GROUP BY level_id, world_name
ORDER BY ty_le_thang_pct, level_id;

-- [jelly-a5-arppu] solution
SELECT platform,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd,
       COUNT(DISTINCT user_id) AS so_nguoi_tra_tien,
       ROUND(SUM(price_usd) / COUNT(DISTINCT user_id), 2) AS arppu_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a5-arppu] wrong: chia_cho_so_giao_dich
-- COUNT(user_id) đếm giao dịch, kết quả là giá bình quân một giao dịch.
SELECT platform,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd,
       COUNT(user_id) AS so_nguoi_tra_tien,
       ROUND(SUM(price_usd) / COUNT(user_id), 2) AS arppu_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a5-arppu] wrong: quen_can_tren
SELECT platform,
       ROUND(SUM(price_usd), 2) AS doanh_thu_iap_usd,
       COUNT(DISTINCT user_id) AS so_nguoi_tra_tien,
       ROUND(SUM(price_usd) / COUNT(DISTINCT user_id), 2) AS arppu_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a6-quoc-gia-nhieu-crash] solution
SELECT country,
       SUM(crash_count) AS so_su_co,
       SUM(sessions) AS so_phien,
       ROUND(1000 * SUM(crash_count) / SUM(sessions), 2) AS su_co_tren_1000_phien
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
GROUP BY country
ORDER BY su_co_tren_1000_phien DESC, country;

-- [jelly-a6-quoc-gia-nhieu-crash] wrong: trung_binh_ty_le_tung_ngay
-- Trung bình của tỷ lệ từng người-ngày khác tỷ lệ của tổng.
SELECT country,
       SUM(crash_count) AS so_su_co,
       SUM(sessions) AS so_phien,
       ROUND(AVG(1000 * crash_count / sessions), 2) AS su_co_tren_1000_phien
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
GROUP BY country
ORDER BY su_co_tren_1000_phien DESC, country;

-- [jelly-a6-quoc-gia-nhieu-crash] wrong: bo_cua_so_du_lieu
SELECT country,
       SUM(crash_count) AS so_su_co,
       SUM(sessions) AS so_phien,
       ROUND(1000 * SUM(crash_count) / SUM(sessions), 2) AS su_co_tren_1000_phien
FROM player_daily
GROUP BY country
ORDER BY su_co_tren_1000_phien DESC, country;

-- [jelly-a7-dem-nguoi-tra-tien] starter
SELECT platform, COUNT(user_id) AS so_nguoi_tra_tien
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a7-dem-nguoi-tra-tien] solution
SELECT platform, COUNT(DISTINCT user_id) AS so_nguoi_tra_tien
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a7-dem-nguoi-tra-tien] wrong: dem_ma_giao_dich
SELECT platform, COUNT(DISTINCT transaction_id) AS so_nguoi_tra_tien
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a7-dem-nguoi-tra-tien] wrong: quen_can_tren
SELECT platform, COUNT(DISTINCT user_id) AS so_nguoi_tra_tien
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-08-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a8-tb-ty-le] starter
SELECT ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       SUM(dau) AS tong_dau,
       ROUND(AVG(arpdau), 4) AS arpdau
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01';

-- [jelly-a8-tb-ty-le] solution
SELECT ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       SUM(dau) AS tong_dau,
       ROUND(SUM(iap_revenue + ad_revenue) / SUM(dau), 4) AS arpdau
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01';

-- [jelly-a8-tb-ty-le] wrong: quen_doanh_thu_quang_cao
SELECT ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       SUM(dau) AS tong_dau,
       ROUND(SUM(iap_revenue) / SUM(dau), 4) AS arpdau
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01';

-- [jelly-a8-tb-ty-le] wrong: chia_cho_so_ngay
-- Tổng doanh thu chia số ngày là doanh thu bình quân một ngày, không phải trên một người chơi.
SELECT ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       SUM(dau) AS tong_dau,
       ROUND(SUM(iap_revenue + ad_revenue) / COUNT(*), 4) AS arpdau
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01';

-- [jelly-a9-having-where] starter
SELECT level_id,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thua_pct
FROM level_attempts
WHERE result = 'fail_out_of_moves'
GROUP BY level_id
HAVING ty_le_thua_pct > 25
ORDER BY ty_le_thua_pct DESC, level_id;

-- [jelly-a9-having-where] solution
SELECT level_id,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thua_pct
FROM level_attempts
GROUP BY level_id
HAVING ty_le_thua_pct > 25
ORDER BY ty_le_thua_pct DESC, level_id;

-- [jelly-a9-having-where] wrong: bo_su_co_khoi_mau_so
-- Chuyển điều kiện từ WHERE ra nhưng vẫn lọc bớt lượt gặp sự cố trước khi gom, mẫu số thiếu.
SELECT level_id,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thua_pct
FROM level_attempts
WHERE result <> 'crash'
GROUP BY level_id
HAVING ty_le_thua_pct > 25
ORDER BY ty_le_thua_pct DESC, level_id;

-- [jelly-a9-having-where] wrong: dem_ca_bo_cuoc
SELECT level_id,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(CASE WHEN result IN ('fail_out_of_moves', 'quit') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thua_pct
FROM level_attempts
GROUP BY level_id
HAVING ty_le_thua_pct > 25
ORDER BY ty_le_thua_pct DESC, level_id;

-- ================================================================ CASE

-- [jelly-c3-phien-ban-moi-dai-hon.b1] solution
SELECT app_version,
       COUNT(*) AS so_phien,
       ROUND(AVG(duration_minutes), 2) AS thoi_luong_tb,
       MIN(event_date) AS ngay_dau,
       MAX(event_date) AS ngay_cuoi
FROM sessions
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY app_version
ORDER BY app_version;

-- [jelly-c3-phien-ban-moi-dai-hon.b1] wrong: bo_cua_so_du_lieu
SELECT app_version,
       COUNT(*) AS so_phien,
       ROUND(AVG(duration_minutes), 2) AS thoi_luong_tb,
       MIN(event_date) AS ngay_dau,
       MAX(event_date) AS ngay_cuoi
FROM sessions
GROUP BY app_version
ORDER BY app_version;

-- [jelly-c3-phien-ban-moi-dai-hon.b1] wrong: phien_ban_luc_cai
SELECT u.app_version_install AS app_version,
       COUNT(*) AS so_phien,
       ROUND(AVG(s.duration_minutes), 2) AS thoi_luong_tb,
       MIN(s.event_date) AS ngay_dau,
       MAX(s.event_date) AS ngay_cuoi
FROM sessions s
JOIN users u ON u.user_id = s.user_id
WHERE s.event_date >= '2026-07-01' AND s.event_date < '2026-08-30'
GROUP BY u.app_version_install
ORDER BY app_version;

-- [jelly-c4-kenh-dong-nguoi.b1] solution
SELECT channel, COUNT(*) AS so_nguoi_cai
FROM users
WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
GROUP BY channel
ORDER BY so_nguoi_cai DESC, channel;

-- [jelly-c4-kenh-dong-nguoi.b1] wrong: quen_can_tren
SELECT channel, COUNT(*) AS so_nguoi_cai
FROM users
WHERE install_date >= '2026-07-01'
GROUP BY channel
ORDER BY so_nguoi_cai DESC, channel;

-- [jelly-c4-kenh-dong-nguoi.b2] solution
SELECT u.channel,
       COUNT(DISTINCT u.user_id) AS so_nguoi_cai,
       COUNT(DISTINCT p.user_id) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(DISTINCT p.user_id) / COUNT(DISTINCT u.user_id), 2) AS ty_le_tra_tien_pct
FROM users u
LEFT JOIN purchases p
       ON p.user_id = u.user_id AND p.is_refund = 0 AND p.event_date < '2026-08-30'
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY u.channel
ORDER BY ty_le_tra_tien_pct DESC, u.channel;

-- [jelly-c4-kenh-dong-nguoi.b2] wrong: dem_giao_dich_thay_nguoi
-- COUNT(p.user_id) đếm mọi giao dịch, người mua nhiều lần bị tính nhiều lần.
SELECT u.channel,
       COUNT(DISTINCT u.user_id) AS so_nguoi_cai,
       COUNT(p.user_id) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(p.user_id) / COUNT(DISTINCT u.user_id), 2) AS ty_le_tra_tien_pct
FROM users u
LEFT JOIN purchases p
       ON p.user_id = u.user_id AND p.is_refund = 0 AND p.event_date < '2026-08-30'
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY u.channel
ORDER BY ty_le_tra_tien_pct DESC, u.channel;

-- [jelly-c4-kenh-dong-nguoi.b2] wrong: sap_theo_so_tuyet_doi
SELECT u.channel,
       COUNT(DISTINCT u.user_id) AS so_nguoi_cai,
       COUNT(DISTINCT p.user_id) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(DISTINCT p.user_id) / COUNT(DISTINCT u.user_id), 2) AS ty_le_tra_tien_pct
FROM users u
LEFT JOIN purchases p
       ON p.user_id = u.user_id AND p.is_refund = 0 AND p.event_date < '2026-08-30'
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY u.channel
ORDER BY so_nguoi_tra_tien DESC, u.channel;
