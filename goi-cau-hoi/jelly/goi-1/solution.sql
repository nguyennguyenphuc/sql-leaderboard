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

-- [jelly-r2-goi-tam-trung-chau-my] solution
SELECT transaction_id, user_id, country, product_name, event_time
FROM purchases
WHERE country IN ('US', 'BR')
  AND price_usd BETWEEN 2.99 AND 4.99
  AND event_time >= '2026-07-25' AND event_time < '2026-08-01'
ORDER BY event_time, transaction_id;

-- [jelly-r2-goi-tam-trung-chau-my] wrong: between_tren_thoi_diem
-- Rớt ở public: event_time có giờ, BETWEEN ... '2026-07-31' chỉ lấy tới 0 giờ ngày 31/7 nên mất giao dịch trong ngày 31/7.
SELECT transaction_id, user_id, country, product_name, event_time
FROM purchases
WHERE country IN ('US', 'BR')
  AND price_usd BETWEEN 2.99 AND 4.99
  AND event_time BETWEEN '2026-07-25' AND '2026-07-31'
ORDER BY event_time, transaction_id;

-- [jelly-r2-goi-tam-trung-chau-my] wrong: hoac_khong_ngoac
-- Rớt ở public: AND tính trước OR nên lấy mọi giao dịch ở Mỹ, mọi gói, mọi ngày.
SELECT transaction_id, user_id, country, product_name, event_time
FROM purchases
WHERE country = 'US' OR country = 'BR'
  AND price_usd BETWEEN 2.99 AND 4.99
  AND event_time >= '2026-07-25' AND event_time < '2026-08-01'
ORDER BY event_time, transaction_id;

-- [jelly-r2-goi-tam-trung-chau-my] wrong: bo_bien_duoi_gia
-- Rớt ở public: "từ 2,99 USD" gồm cả mức 2,99; dùng > làm mất gói Piggy Bank.
SELECT transaction_id, user_id, country, product_name, event_time
FROM purchases
WHERE country IN ('US', 'BR')
  AND price_usd > 2.99 AND price_usd <= 4.99
  AND event_time >= '2026-07-25' AND event_time < '2026-08-01'
ORDER BY event_time, transaction_id;

-- [jelly-r3-luot-bat-thuong-volcano] solution
SELECT attempt_id, event_time, country, level_id, result
FROM level_attempts
WHERE platform = 'Android'
  AND app_version = '2.1.1'
  AND country IN ('VN', 'TH', 'PH', 'ID')
  AND world_name = 'Chocolate Volcano'
  AND difficulty_tag IN ('hard', 'super_hard')
  AND result IN ('quit', 'crash')
ORDER BY event_time, attempt_id;

-- [jelly-r3-luot-bat-thuong-volcano] wrong: hoac_khong_ngoac
-- Rớt ở public: AND tính trước OR nên lấy mọi lượt bỏ cuộc ở mọi màn, mọi nền tảng, mọi thị trường.
SELECT attempt_id, event_time, country, level_id, result
FROM level_attempts
WHERE result = 'quit' OR result = 'crash'
  AND platform = 'Android'
  AND app_version = '2.1.1'
  AND country IN ('VN', 'TH', 'PH', 'ID')
  AND world_name = 'Chocolate Volcano'
  AND difficulty_tag IN ('hard', 'super_hard')
ORDER BY event_time, attempt_id;

-- [jelly-r3-luot-bat-thuong-volcano] wrong: bo_dieu_kien_do_kho
-- Rớt ở public: lấy cả lượt ở các màn nhãn 'normal' của thế giới.
SELECT attempt_id, event_time, country, level_id, result
FROM level_attempts
WHERE platform = 'Android'
  AND app_version = '2.1.1'
  AND country IN ('VN', 'TH', 'PH', 'ID')
  AND world_name = 'Chocolate Volcano'
  AND result IN ('quit', 'crash')
ORDER BY event_time, attempt_id;

-- [jelly-r3-luot-bat-thuong-volcano] wrong: chi_lay_super_hard
-- Rớt ở hidden-1: ở public các màn khó trở lên của Chocolate Volcano đều là 'super_hard'; hidden-1 đổi màn 59 thành 'hard' nên mất lượt bỏ cuộc ở màn 59.
SELECT attempt_id, event_time, country, level_id, result
FROM level_attempts
WHERE platform = 'Android'
  AND app_version = '2.1.1'
  AND country IN ('VN', 'TH', 'PH', 'ID')
  AND world_name = 'Chocolate Volcano'
  AND difficulty_tag = 'super_hard'
  AND result IN ('quit', 'crash')
ORDER BY event_time, attempt_id;

-- [jelly-r3-luot-bat-thuong-volcano] wrong: gan_cung_ma_man
-- Rớt ở hidden-1: chép mã màn 46, 60 từ lần Chạy thử thay vì lọc theo nhãn hiện hành.
SELECT attempt_id, event_time, country, level_id, result
FROM level_attempts
WHERE platform = 'Android'
  AND app_version = '2.1.1'
  AND country IN ('VN', 'TH', 'PH', 'ID')
  AND level_id IN (46, 60)
  AND result IN ('quit', 'crash')
ORDER BY event_time, attempt_id;

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

-- [jelly-r6-su-kien-ky-14-ngay] solution
-- Kỳ 14 ngày từ 26/7 kết thúc ngày 8/8.
SELECT event_id, event_name, start_date, end_date
FROM liveops_events
WHERE start_date <= '2026-08-08'
  AND end_date >= '2026-07-26'
ORDER BY start_date, event_id;

-- [jelly-r6-su-kien-ky-14-ngay] wrong: hoac_thay_va
-- Rớt ở public: nối hai điều kiện bằng OR lấy cả ba sự kiện.
SELECT event_id, event_name, start_date, end_date
FROM liveops_events
WHERE start_date <= '2026-08-08'
   OR end_date >= '2026-07-26'
ORDER BY start_date, event_id;

-- [jelly-r6-su-kien-ky-14-ngay] wrong: bat_dau_trong_ky
-- Rớt ở public: chỉ lấy sự kiện bắt đầu trong kỳ, mất sự kiện 24/7 tới 28/7 đang chạy dở.
SELECT event_id, event_name, start_date, end_date
FROM liveops_events
WHERE start_date >= '2026-07-26'
  AND start_date <= '2026-08-08'
ORDER BY start_date, event_id;

-- [jelly-r6-su-kien-ky-14-ngay] wrong: nam_tron_trong_ky
-- Rớt ở public: đòi sự kiện nằm trọn trong kỳ, mất cả hai sự kiện vắt qua mốc đầu và mốc cuối.
SELECT event_id, event_name, start_date, end_date
FROM liveops_events
WHERE start_date >= '2026-07-26'
  AND end_date <= '2026-08-08'
ORDER BY start_date, event_id;

-- [jelly-r6-su-kien-ky-14-ngay] wrong: can_cuoi_mo_sai
-- Rớt ở public: coi 8/8 là ngày sau kỳ và dùng <, mất sự kiện bắt đầu đúng ngày cuối kỳ.
SELECT event_id, event_name, start_date, end_date
FROM liveops_events
WHERE start_date < '2026-08-08'
  AND end_date >= '2026-07-26'
ORDER BY start_date, event_id;

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

-- [jelly-r8-giao-dich-thang-8-thua] wrong: gan_cung_ngay_cuoi
-- Rớt ở hidden-1: gắn cứng ngày cuối của dữ liệu Chạy thử nên mất giao dịch Booster Bundle ngày 2026-08-30 ở GB.
SELECT transaction_id, user_id, event_date, product_type, price_usd
FROM purchases
WHERE country = 'GB'
  AND event_date >= '2026-08-01' AND event_date <= '2026-08-29'
ORDER BY event_date, transaction_id;

-- [jelly-r9-phien-ios-ban-cu] starter
SELECT session_id, user_id, session_start, app_version, entry_screen
FROM sessions
WHERE country = 'VN'
  AND platform = 'iOS'
  AND app_version <> '2.1.1'
  AND entry_screen = 'home' OR entry_screen = 'map'
  AND event_date BETWEEN '2026-08-25' AND '2026-08-29'
ORDER BY session_start, session_id;

-- [jelly-r9-phien-ios-ban-cu] solution
SELECT session_id, user_id, session_start, app_version, entry_screen
FROM sessions
WHERE country = 'VN'
  AND platform = 'iOS'
  AND app_version NOT IN ('2.1.0', '2.1.1')
  AND entry_screen IN ('home', 'map')
  AND event_date >= '2026-08-25'
ORDER BY session_start, session_id;

-- [jelly-r9-phien-ios-ban-cu] wrong: giu_ngay_cuoi
-- Rớt ở hidden-1: sửa ngoặc và phiên bản nhưng giữ ngày cuối 29/8, mất hai phiên ngày 1/9 và 2/9 của người chơi iOS ở VN còn dùng bản 2.0.2.
SELECT session_id, user_id, session_start, app_version, entry_screen
FROM sessions
WHERE country = 'VN'
  AND platform = 'iOS'
  AND app_version NOT IN ('2.1.0', '2.1.1')
  AND (entry_screen = 'home' OR entry_screen = 'map')
  AND event_date BETWEEN '2026-08-25' AND '2026-08-29'
ORDER BY session_start, session_id;

-- [jelly-r9-phien-ios-ban-cu] wrong: giu_khac_2_1_1
-- Rớt ở public: sửa ngoặc và ngày nhưng <> '2.1.1' vẫn lấy phiên chạy bản 2.1.0.
SELECT session_id, user_id, session_start, app_version, entry_screen
FROM sessions
WHERE country = 'VN'
  AND platform = 'iOS'
  AND app_version <> '2.1.1'
  AND (entry_screen = 'home' OR entry_screen = 'map')
  AND event_date >= '2026-08-25'
ORDER BY session_start, session_id;

-- [jelly-r9-phien-ios-ban-cu] wrong: chi_them_ngoac
-- Rớt ở public và hidden-1: chỉ sửa thứ tự AND/OR, còn hai lỗi kia.
SELECT session_id, user_id, session_start, app_version, entry_screen
FROM sessions
WHERE country = 'VN'
  AND platform = 'iOS'
  AND app_version <> '2.1.1'
  AND (entry_screen = 'home' OR entry_screen = 'map')
  AND event_date BETWEEN '2026-08-25' AND '2026-08-29'
ORDER BY session_start, session_id;

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

-- [jelly-n2-ty-le-chua-tiep-xuc-nhanh] solution
SELECT ROUND(100 * COUNT(CASE WHEN variant = 'control_after_3_fails' AND exposed_at IS NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'control_after_3_fails' THEN 1 END), 2) AS chua_tiep_xuc_doi_chung_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' AND exposed_at IS NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN 1 END), 2) AS chua_tiep_xuc_nhanh_thu_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' AND exposed_at IS NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN 1 END)
           - 100 * COUNT(CASE WHEN variant = 'control_after_3_fails' AND exposed_at IS NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'control_after_3_fails' THEN 1 END), 2) AS chenh_lech_diem_pct
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing';

-- [jelly-n2-ty-le-chua-tiep-xuc-nhanh] wrong: dem_cot_exposed_at
-- Rớt ở public: đếm theo cột exposed_at bỏ qua ô trống, nên tử số là người ĐÃ tiếp xúc (tỷ lệ ngược).
SELECT ROUND(100 * COUNT(CASE WHEN variant = 'control_after_3_fails' THEN exposed_at END)
             / COUNT(CASE WHEN variant = 'control_after_3_fails' THEN 1 END), 2) AS chua_tiep_xuc_doi_chung_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN exposed_at END)
             / COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN 1 END), 2) AS chua_tiep_xuc_nhanh_thu_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN exposed_at END)
             / COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN 1 END)
           - 100 * COUNT(CASE WHEN variant = 'control_after_3_fails' THEN exposed_at END)
             / COUNT(CASE WHEN variant = 'control_after_3_fails' THEN 1 END), 2) AS chenh_lech_diem_pct
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing';

-- [jelly-n2-ty-le-chua-tiep-xuc-nhanh] wrong: mau_so_ca_hai_nhanh
-- Rớt ở public: chia cho mọi người được chia của cả hai nhánh, tỷ lệ còn khoảng một nửa.
SELECT ROUND(100 * COUNT(CASE WHEN variant = 'control_after_3_fails' AND exposed_at IS NULL THEN 1 END)
             / COUNT(*), 2) AS chua_tiep_xuc_doi_chung_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' AND exposed_at IS NULL THEN 1 END)
             / COUNT(*), 2) AS chua_tiep_xuc_nhanh_thu_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' AND exposed_at IS NULL THEN 1 END) / COUNT(*)
           - 100 * COUNT(CASE WHEN variant = 'control_after_3_fails' AND exposed_at IS NULL THEN 1 END) / COUNT(*), 2) AS chenh_lech_diem_pct
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing';

-- [jelly-n2-ty-le-chua-tiep-xuc-nhanh] wrong: bang_null
-- Rớt ở public: exposed_at = NULL không đúng với dòng nào, mọi tỷ lệ ra 0.
SELECT ROUND(100 * COUNT(CASE WHEN variant = 'control_after_3_fails' AND exposed_at = NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'control_after_3_fails' THEN 1 END), 2) AS chua_tiep_xuc_doi_chung_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' AND exposed_at = NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN 1 END), 2) AS chua_tiep_xuc_nhanh_thu_pct,
       ROUND(100 * COUNT(CASE WHEN variant = 'early_offer_after_1_fail' AND exposed_at = NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'early_offer_after_1_fail' THEN 1 END)
           - 100 * COUNT(CASE WHEN variant = 'control_after_3_fails' AND exposed_at = NULL THEN 1 END)
             / COUNT(CASE WHEN variant = 'control_after_3_fails' THEN 1 END), 2) AS chenh_lech_diem_pct
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing';

-- [jelly-n3-nhom-luot-di-du] solution
SELECT attempt_id, result, moves_left,
       CASE WHEN moves_left = 0 THEN 'het_luot_di'
            WHEN moves_left <= 2 THEN 'du_1_2'
            ELSE 'du_tu_3' END AS nhom_luot_du
FROM level_attempts
WHERE level_id = 28
  AND event_date = '2026-08-01'
ORDER BY attempt_id;

-- [jelly-n3-nhom-luot-di-du] wrong: sai_thu_tu_nhanh
-- Rớt ở public: nhánh <= 2 đứng trước nên lượt còn 0 lượt đi bị gán 'du_1_2'.
SELECT attempt_id, result, moves_left,
       CASE WHEN moves_left <= 2 THEN 'du_1_2'
            WHEN moves_left = 0 THEN 'het_luot_di'
            ELSE 'du_tu_3' END AS nhom_luot_du
FROM level_attempts
WHERE level_id = 28
  AND event_date = '2026-08-01'
ORDER BY attempt_id;

-- [jelly-n3-nhom-luot-di-du] wrong: gan_theo_ket_qua
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

-- [jelly-n5-mo-ta-giao-dich-vn] solution
SELECT transaction_id, event_time,
       CONCAT(product_name, ' - ',
              COALESCE(CONCAT('man ', level_id_if_relevant), 'khong gan man'), ' - ',
              CASE WHEN price_usd < CASE product_type
                                        WHEN 'starter_pack'     THEN 0.99
                                        WHEN 'extra_moves_pack' THEN 1.99
                                        WHEN 'piggy_bank'       THEN 2.99
                                        WHEN 'booster_bundle'   THEN 4.99
                                        WHEN 'season_pass'      THEN 9.99
                                    END
                   THEN 'khuyen mai' ELSE 'gia goc' END) AS mo_ta
FROM purchases
WHERE country = 'VN'
  AND event_date >= '2026-08-27'
ORDER BY event_time, transaction_id;

-- [jelly-n5-mo-ta-giao-dich-vn] wrong: noi_chuoi_voi_null
-- Rớt ở public: CONCAT có một phần NULL thì cả chuỗi là NULL, mô tả của giao dịch không gắn màn bị trống.
SELECT transaction_id, event_time,
       CONCAT(product_name, ' - man ', level_id_if_relevant, ' - ',
              CASE WHEN price_usd < CASE product_type
                                        WHEN 'starter_pack'     THEN 0.99
                                        WHEN 'extra_moves_pack' THEN 1.99
                                        WHEN 'piggy_bank'       THEN 2.99
                                        WHEN 'booster_bundle'   THEN 4.99
                                        WHEN 'season_pass'      THEN 9.99
                                    END
                   THEN 'khuyen mai' ELSE 'gia goc' END) AS mo_ta
FROM purchases
WHERE country = 'VN'
  AND event_date >= '2026-08-27'
ORDER BY event_time, transaction_id;

-- [jelly-n5-mo-ta-giao-dich-vn] wrong: thay_null_truoc_khi_noi
-- Rớt ở public: thay ô trống trước khi nối với 'man ' nên ra 'man khong gan man'.
SELECT transaction_id, event_time,
       CONCAT(product_name, ' - man ', COALESCE(level_id_if_relevant, 'khong gan man'), ' - ',
              CASE WHEN price_usd < CASE product_type
                                        WHEN 'starter_pack'     THEN 0.99
                                        WHEN 'extra_moves_pack' THEN 1.99
                                        WHEN 'piggy_bank'       THEN 2.99
                                        WHEN 'booster_bundle'   THEN 4.99
                                        WHEN 'season_pass'      THEN 9.99
                                    END
                   THEN 'khuyen mai' ELSE 'gia goc' END) AS mo_ta
FROM purchases
WHERE country = 'VN'
  AND event_date >= '2026-08-27'
ORDER BY event_time, transaction_id;

-- [jelly-n5-mo-ta-giao-dich-vn] wrong: luon_gia_goc
-- Rớt ở hidden-1: public không có giao dịch giá khuyến mãi nên bỏ nhánh này vẫn khớp; hidden-1 có Starter Pack 0,49 USD ngày 1/9 ở VN.
SELECT transaction_id, event_time,
       CONCAT(product_name, ' - ',
              COALESCE(CONCAT('man ', level_id_if_relevant), 'khong gan man'), ' - gia goc') AS mo_ta
FROM purchases
WHERE country = 'VN'
  AND event_date >= '2026-08-27'
ORDER BY event_time, transaction_id;

-- [jelly-n5-mo-ta-giao-dich-vn] wrong: gan_cung_ngay_cuoi
-- Rớt ở hidden-1: chép ngày cuối 29/8 của lần Chạy thử làm cận trên, mất giao dịch ngày 1/9.
SELECT transaction_id, event_time,
       CONCAT(product_name, ' - ',
              COALESCE(CONCAT('man ', level_id_if_relevant), 'khong gan man'), ' - ',
              CASE WHEN price_usd < CASE product_type
                                        WHEN 'starter_pack'     THEN 0.99
                                        WHEN 'extra_moves_pack' THEN 1.99
                                        WHEN 'piggy_bank'       THEN 2.99
                                        WHEN 'booster_bundle'   THEN 4.99
                                        WHEN 'season_pass'      THEN 9.99
                                    END
                   THEN 'khuyen mai' ELSE 'gia goc' END) AS mo_ta
FROM purchases
WHERE country = 'VN'
  AND event_date BETWEEN '2026-08-27' AND '2026-08-29'
ORDER BY event_time, transaction_id;

-- [jelly-n6-ty-trong-iap-man-28-30] solution
-- CASE đưa giao dịch có level_id_if_relevant trống vào nhánh ELSE, nên phần còn lại gồm cả giao dịch không gắn màn.
SELECT SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END) AS doanh_thu_man_28_30,
       SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN 0 ELSE price_usd END) AS doanh_thu_con_lai,
       ROUND(100 * SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END)
             / SUM(price_usd), 2) AS ty_trong_man_28_30_pct
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n6-ty-trong-iap-man-28-30] wrong: not_between_bo_null
-- Rớt ở public: NOT BETWEEN với ô trống cho NULL, mất giao dịch không gắn màn ở phần còn lại và ở mẫu số.
SELECT SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END) AS doanh_thu_man_28_30,
       SUM(CASE WHEN level_id_if_relevant NOT BETWEEN 28 AND 30 THEN price_usd ELSE 0 END) AS doanh_thu_con_lai,
       ROUND(100 * SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END)
             / (SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END)
                + SUM(CASE WHEN level_id_if_relevant NOT BETWEEN 28 AND 30 THEN price_usd ELSE 0 END)), 2) AS ty_trong_man_28_30_pct
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n6-ty-trong-iap-man-28-30] wrong: lam_tron_truoc_khi_nhan
-- Rớt ở public: làm tròn tỷ lệ 2 chữ số trước khi nhân 100 làm mất phần lẻ của phần trăm.
SELECT SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END) AS doanh_thu_man_28_30,
       SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN 0 ELSE price_usd END) AS doanh_thu_con_lai,
       100 * ROUND(SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END)
                   / SUM(price_usd), 2) AS ty_trong_man_28_30_pct
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n6-ty-trong-iap-man-28-30] wrong: thieu_can_tren
-- Rớt ở public: lấy cả giao dịch tháng 8.
SELECT SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END) AS doanh_thu_man_28_30,
       SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN 0 ELSE price_usd END) AS doanh_thu_con_lai,
       ROUND(100 * SUM(CASE WHEN level_id_if_relevant BETWEEN 28 AND 30 THEN price_usd ELSE 0 END)
             / SUM(price_usd), 2) AS ty_trong_man_28_30_pct
FROM purchases
WHERE event_date >= '2026-07-01';

-- [jelly-n7-crash-khoang-trang] starter
SELECT COUNT(*) AS so_luot_su_co
FROM level_attempts
WHERE result = 'Crash '
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n7-crash-khoang-trang] solution
SELECT COUNT(*) AS so_luot_su_co
FROM level_attempts
WHERE result = 'crash'
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-n7-crash-khoang-trang] wrong: bo_khoang_ngay
-- Rớt ở public: sửa đúng chuỗi nhưng xoá luôn điều kiện tháng, đếm cả tháng 8.
SELECT COUNT(*) AS so_luot_su_co
FROM level_attempts
WHERE result = 'crash';

-- [jelly-n7-crash-khoang-trang] wrong: lay_crash_count
-- Rớt ở public: crash_count của bảng hoạt động ngày là nguồn đếm khác, không khớp số lượt chơi gặp sự cố.
SELECT SUM(crash_count) AS so_luot_su_co
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01';

-- [jelly-n8-ty-le-su-co-tron-chuc] starter
SELECT `date`, sessions, crash_count,
       ROUND(crash_count / dau, 2) * 1000 AS ty_le_su_co
FROM daily_kpi
WHERE `date` BETWEEN '2026-08-23' AND '2026-08-29'
ORDER BY `date`;

-- [jelly-n8-ty-le-su-co-tron-chuc] solution
SELECT `date`, sessions, crash_count,
       ROUND(1000 * crash_count / sessions, 2) AS ty_le_su_co
FROM daily_kpi
WHERE `date` >= '2026-08-23'
ORDER BY `date`;

-- [jelly-n8-ty-le-su-co-tron-chuc] wrong: lam_tron_truoc_khi_nhan
-- Rớt ở public: sửa mẫu số và ngày nhưng vẫn làm tròn 2 chữ số trước khi nhân 1.000, chỉ ra bội của 10.
SELECT `date`, sessions, crash_count,
       ROUND(crash_count / sessions, 2) * 1000 AS ty_le_su_co
FROM daily_kpi
WHERE `date` >= '2026-08-23'
ORDER BY `date`;

-- [jelly-n8-ty-le-su-co-tron-chuc] wrong: van_chia_cho_dau
-- Rớt ở public: sửa cách làm tròn và ngày nhưng vẫn chia cho DAU (sai định nghĩa: tỷ lệ tính trên 1.000 phiên).
SELECT `date`, sessions, crash_count,
       ROUND(1000 * crash_count / dau, 2) AS ty_le_su_co
FROM daily_kpi
WHERE `date` >= '2026-08-23'
ORDER BY `date`;

-- [jelly-n8-ty-le-su-co-tron-chuc] wrong: giu_ngay_cuoi
-- Rớt ở hidden-1: sửa công thức nhưng giữ ngày cuối 29/8 của lần Chạy thử, mất các ngày 30/8, 1/9, 2/9 của biến thể.
SELECT `date`, sessions, crash_count,
       ROUND(1000 * crash_count / sessions, 2) AS ty_le_su_co
FROM daily_kpi
WHERE `date` BETWEEN '2026-08-23' AND '2026-08-29'
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
