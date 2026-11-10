-- 04_bo_sung_bien_the_jelly.sql: bổ sung jelly_hidden_1 để các câu chỉ dùng bảng danh mục / bảng phụ cũng khác public
-- (chép kết quả Chạy thử thành hằng số không còn qua). Chỉ sửa jelly_hidden_1, KHÔNG đụng jelly.
-- Chạy SAU 03_bien_the_an_jelly.sql; chạy lặp lại được (xoá dòng giả theo khoá riêng, đặt lại giá trị từ public rồi áp lại):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/jelly/04_bo_sung_bien_the_jelly.sql
-- Ghi ở README-jelly.md, bảng "Biến thể".
--   (d) giao dịch jta_txn_00002662 (Booster Bundle 2026-09-01 của (b)) gắn màn 58 như mọi Booster Bundle ở public
--       (level_id_if_relevant = max_level của người chơi trong ngày)
--   (e) người chơi CHƯA từng mua jta_user_001174 (iOS, VN, Social Ads, cài 2026-07-05, vẫn bản 2.0.2, đã tới màn 60) có thêm hoạt động
--       2026-09-01 (phiên, lượt chơi màn 59, giao dịch Starter Pack giá khuyến mãi 0,49) và 2026-09-02 (phiên, lượt chơi màn 60)
--       -> bẫy thiếu cận trên bắt được ở câu "người chưa mua", "đã mua Starter Pack", "ngày trên bình quân tháng"
--          (tháng 9 có 2 ngày DAU khác nhau), "màn chưa gắn giao dịch" (màn 59, 60 có lượt sau 29/8); bảng giá có thêm một mức giá
--   (f) đổi nhãn độ khó (level_metadata và mọi lượt chơi của màn đó): màn 45 (Licorice Lagoon) 'hard' -> 'super_hard',
--       màn 59 (Chocolate Volcano, designed_fail_probability 0,268, cao nhất nhóm 'normal') 'normal' -> 'hard'
--   (g) thêm sự kiện LIVE_004 'Jungle Jam Weekend' 2026-07-31 .. 2026-08-02 (không chồng sự kiện khác)
--   (h) campaign_spend: JTA-VIDEO-330 · VN · Android chi thêm 150 USD ở 2 ngày giữa sự kiện (2026-07-11 Weekend Sugar Rush,
--       2026-08-10 Licorice Rescue) -> hai ngày chi bất thường của Video Network, chỉ thấy khi lấy mức nền theo từng chiến dịch
--   (i) player_daily jta_user_003773 · 2026-08-24: install_date ghi lệch 1 ngày (2026-07-14 thay 2026-07-15),
--       cohort_day 41 tính theo ngày ghi lệch -> chỉ đối chiếu với users mới thấy lệch

USE jelly_hidden_1;

-- ------------------------------------------------------------------ xoá dòng giả cũ (theo khoá riêng)
DELETE FROM purchases      WHERE transaction_id = 'jta_txn_00002663';
DELETE FROM level_attempts WHERE attempt_id IN ('jta_attempt_000249779', 'jta_attempt_000249780');
DELETE FROM player_daily   WHERE user_id = 'jta_user_001174' AND activity_date IN ('2026-09-01', '2026-09-02');
DELETE FROM sessions       WHERE session_id IN ('jta_session_00122700', 'jta_session_00122701');
DELETE FROM liveops_events WHERE event_id = 'LIVE_004';
DELETE FROM daily_kpi      WHERE `date` >= '2026-09-01';

-- ------------------------------------------------------------------ (d) gắn màn cho giao dịch Booster Bundle 2026-09-01
UPDATE purchases SET level_id_if_relevant = 58 WHERE transaction_id = 'jta_txn_00002662';

-- ------------------------------------------------------------------ (e) jta_user_001174: 2026-09-01 và 2026-09-02
INSERT INTO sessions VALUES
  ('jta_session_00122700', 'jta_user_001174', '2026-09-01 20:14:00', '2026-09-01', '2026-09-01 20:14:00', 10, 'home', '2.0.2', 'iOS', 'VN'),
  ('jta_session_00122701', 'jta_user_001174', '2026-09-02 21:02:00', '2026-09-02', '2026-09-02 21:02:00', 7, 'map', '2.0.2', 'iOS', 'VN');
INSERT INTO level_attempts
SELECT 'jta_attempt_000249779', 'jta_user_001174', '2026-09-01', '2026-09-01 20:16:40', 'jta_session_00122700',
       level_id, episode, world_name, screen_context, objective_type, difficulty_tag,
       moves_limit, moves_limit, 0, 'fail_out_of_moves', 0, 0, 0, 140, '2.0.2', 'iOS', 'VN'
FROM level_metadata WHERE level_id = 59;
INSERT INTO level_attempts
SELECT 'jta_attempt_000249780', 'jta_user_001174', '2026-09-02', '2026-09-02 21:04:05', 'jta_session_00122701',
       level_id, episode, world_name, screen_context, objective_type, difficulty_tag,
       moves_limit, moves_limit - 3, 3, 'complete', 0, 0, 0, 115, '2.0.2', 'iOS', 'VN'
FROM level_metadata WHERE level_id = 60;
INSERT INTO purchases VALUES ('jta_txn_00002663', 'jta_user_001174', '2026-09-01', '2026-09-01 20:21:30',
  'jta_session_00122700', 'starter_pack', 'Starter Pack', 0.49, NULL, 'Shop screen', 'USD', 0, '2.0.2', 'iOS', 'VN');
INSERT INTO player_daily VALUES
  ('jta_user_001174', '2026-07-05', '2026-09-01', 58, 'iOS', 'VN', 'Social Ads', 'JTA-SOCIAL-204',
   '2.0.2', 1, 10, 60, 0, 0, 0, 0.49, 0.0000),
  ('jta_user_001174', '2026-07-05', '2026-09-02', 59, 'iOS', 'VN', 'Social Ads', 'JTA-SOCIAL-204',
   '2.0.2', 1, 7, 60, 0, 0, 0, 0.00, 0.0000);

-- ------------------------------------------------------------------ (f) đổi nhãn độ khó màn 45, 59
UPDATE level_metadata SET difficulty_tag = 'super_hard' WHERE level_id = 45;
UPDATE level_attempts SET difficulty_tag = 'super_hard' WHERE level_id = 45;
UPDATE level_metadata SET difficulty_tag = 'hard' WHERE level_id = 59;
UPDATE level_attempts SET difficulty_tag = 'hard' WHERE level_id = 59;

-- ------------------------------------------------------------------ (g) sự kiện LiveOps thứ tư
INSERT INTO liveops_events VALUES ('LIVE_004', 'Jungle Jam Weekend', '2026-07-31', '2026-08-02',
  'Home screen event banner', 'Bonus stars for Jelly Jungle levels');

-- ------------------------------------------------------------------ (h) ngày chi bất thường của Video Network
UPDATE campaign_spend h
JOIN jelly.campaign_spend p ON p.`date` = h.`date` AND p.campaign_id = h.campaign_id
                           AND p.country = h.country AND p.target_platform = h.target_platform
SET h.spend_usd = p.spend_usd + 150.00
WHERE h.`date` IN ('2026-07-11', '2026-08-10') AND h.campaign_id = 'JTA-VIDEO-330' AND h.country = 'VN' AND h.target_platform = 'Android';

-- ------------------------------------------------------------------ (i) một dòng player_daily ghi lệch ngày cài
UPDATE player_daily SET install_date = '2026-07-14', cohort_day = 41
WHERE user_id = 'jta_user_003773' AND activity_date = '2026-08-24';

-- ------------------------------------------------------------------ daily_kpi tháng 9 tính lại (công thức của public / 03)
INSERT INTO daily_kpi (`date`, dau, new_users, sessions, playtime_minutes, iap_revenue, ad_revenue, crash_count, arpdau)
SELECT p.activity_date, COUNT(*), COALESCE(MAX(u.n), 0), SUM(p.sessions), SUM(p.playtime_minutes),
       ROUND(SUM(p.iap_revenue), 2), ROUND(SUM(p.ad_revenue), 2), SUM(p.crash_count),
       ROUND((SUM(p.iap_revenue) + SUM(p.ad_revenue)) / COUNT(*), 4)
FROM player_daily p
LEFT JOIN (SELECT install_date, COUNT(*) AS n FROM users GROUP BY install_date) u ON u.install_date = p.activity_date
WHERE p.activity_date >= '2026-09-01'
GROUP BY p.activity_date;

ANALYZE TABLE sessions, level_attempts, purchases, player_daily, level_metadata, liveops_events, campaign_spend, daily_kpi;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'sessions' AS bang, (SELECT COUNT(*) FROM jelly.sessions) AS public, COUNT(*) AS hidden_1 FROM sessions
UNION ALL SELECT 'player_daily', (SELECT COUNT(*) FROM jelly.player_daily), COUNT(*) FROM player_daily
UNION ALL SELECT 'level_attempts', (SELECT COUNT(*) FROM jelly.level_attempts), COUNT(*) FROM level_attempts
UNION ALL SELECT 'purchases', (SELECT COUNT(*) FROM jelly.purchases), COUNT(*) FROM purchases
UNION ALL SELECT 'liveops_events', (SELECT COUNT(*) FROM jelly.liveops_events), COUNT(*) FROM liveops_events
UNION ALL SELECT 'daily_kpi', (SELECT COUNT(*) FROM jelly.daily_kpi), COUNT(*) FROM daily_kpi;
SELECT `date`, dau, sessions, iap_revenue FROM daily_kpi WHERE `date` >= '2026-08-29' ORDER BY `date`;
SELECT difficulty_tag, COUNT(*) AS so_man FROM level_metadata GROUP BY difficulty_tag ORDER BY difficulty_tag;
SELECT COUNT(*) AS view_buoc4 FROM tutorial_step4_health;
SELECT COUNT(*) AS view_man_28_30 FROM level_28_30_health;
