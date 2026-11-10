-- 03_bien_the_an_jelly.sql: biến thể ẩn jelly_hidden_1 (chấm câu có bokiemtra={public, hidden-1}).
-- Chạy sau 02_nap_jelly.sh, trong container sqllb-mysql (thư mục mysql/ mount ở /sqllb):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/jelly/03_bien_the_an_jelly.sql
-- Khuôn datathon_2026_hidden_1 / scm_hidden_1 (CHOT-FORMAT-CAU-HOI.md mục 6). Ghi ở README-jelly.md, bảng "Biến thể".
--   (a) bỏ người chơi có số hiệu jta_user_NNNNNN % 10 = 7 (~10%) cùng MỌI sự kiện của họ (FK nguyên vẹn);
--       daily_kpi tính lại từ player_daily/users đúng công thức của public (đã kiểm 60/60 ngày khớp)
--   (b) thêm 1 ngày hoạt động 2026-09-01 (ngay sau tháng cuối của cửa sổ 2026-07-01..2026-08-29):
--       1 phiên + 1 lượt chơi + 1 giao dịch IAP + 1 quảng cáo + 1 dòng player_daily (người chơi jta_user_000648),
--       1 dòng campaign_spend; daily_kpi vì tính lại nên có thêm dòng 2026-09-01
--   (c) cặp hoà hạng 3: top 3 màn có nhiều lượt bỏ cuộc (result = 'quit') nhất của thế giới Licorice Lagoon

DROP DATABASE IF EXISTS jelly_hidden_1;
CREATE DATABASE jelly_hidden_1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE jelly_hidden_1;
SOURCE /sqllb/jelly/01_tao_bang_jelly.sql

-- ------------------------------------------------------------------ chép jelly, (a) bỏ người chơi % 10 = 7
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO level_metadata SELECT * FROM jelly.level_metadata;
INSERT INTO liveops_events SELECT * FROM jelly.liveops_events;
INSERT INTO campaign_spend SELECT * FROM jelly.campaign_spend;
INSERT INTO users          SELECT * FROM jelly.users          WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO sessions       SELECT * FROM jelly.sessions       WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO player_daily   SELECT * FROM jelly.player_daily   WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO tutorial_steps SELECT * FROM jelly.tutorial_steps WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO ab_assignments SELECT * FROM jelly.ab_assignments WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO level_attempts SELECT * FROM jelly.level_attempts WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO booster_events SELECT * FROM jelly.booster_events WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO purchases      SELECT * FROM jelly.purchases      WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
INSERT INTO ad_events      SELECT * FROM jelly.ad_events      WHERE CAST(SUBSTRING(user_id, 10) AS UNSIGNED) % 10 <> 7;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ (b) 1 ngày ngay sau cửa sổ: 2026-09-01
-- jta_user_000648 (Organic, GB, Android, cài 2026-07-03, hoạt động 19 ngày, ngày cuối 2026-08-29, phiên bản 2.1.1)
INSERT INTO sessions VALUES ('jta_session_00122699', 'jta_user_000648', '2026-09-01 08:05:00', '2026-09-01',
  '2026-09-01 08:05:00', 12, 'map', '2.1.1', 'Android', 'GB');
INSERT INTO level_attempts
SELECT 'jta_attempt_000249778', 'jta_user_000648', '2026-09-01', '2026-09-01 08:07:30', 'jta_session_00122699',
       level_id, episode, world_name, screen_context, objective_type, difficulty_tag,
       moves_limit, moves_limit - 3, 3, 'complete', 0, 0, 0, 120, '2.1.1', 'Android', 'GB'
FROM level_metadata WHERE level_id = 58;
INSERT INTO purchases VALUES ('jta_txn_00002662', 'jta_user_000648', '2026-09-01', '2026-09-01 08:12:10',
  'jta_session_00122699', 'booster_bundle', 'Booster Bundle', 4.99, NULL, 'Shop screen', 'USD', 0, '2.1.1', 'Android', 'GB');
INSERT INTO ad_events VALUES ('jta_ad_000175229', 'jta_user_000648', '2026-09-01', '2026-09-01 08:10:05',
  'jta_session_00122699', 'rewarded', 'daily_reward', 'coins', 0.00600, 'Ad popup > daily_reward', '2.1.1', 'Android', 'GB');
INSERT INTO player_daily VALUES ('jta_user_000648', '2026-07-03', '2026-09-01', 60, 'Android', 'GB', 'Organic', 'ORG-000',
  '2.1.1', 1, 12, 58, 0, 0, 0, 4.99, 0.0060);
INSERT INTO campaign_spend
SELECT '2026-09-01', campaign_id, channel, country, spend_usd, target_platform
FROM jelly.campaign_spend WHERE `date` = '2026-08-29' AND campaign_id = 'JTA-SOCIAL-204' AND country = 'VN' AND target_platform = 'Android';

-- ------------------------------------------------------------------ (c) cặp hoà hạng 3
-- Lượt bỏ cuộc (result='quit') thế giới Licorice Lagoon sau bước (a): màn 31 = 179, 33 = 95, 34 = 71, 32 = 70.
-- Đổi 1 lượt thua hết lượt đi của màn 32 thành bỏ cuộc -> màn 32 = màn 34 = 71 ở hạng 3.
-- ROW_NUMBER() ... ORDER BY so_luot DESC, level_id giữ màn 32 ở hạng 3; RANK()/DENSE_RANK() trả 4 dòng.
UPDATE level_attempts SET result = 'quit'
WHERE attempt_id = (SELECT a FROM (
  SELECT MIN(attempt_id) AS a FROM level_attempts WHERE level_id = 32 AND result = 'fail_out_of_moves') x);

-- ------------------------------------------------------------------ daily_kpi tính lại (công thức của public)
INSERT INTO daily_kpi (`date`, dau, new_users, sessions, playtime_minutes, iap_revenue, ad_revenue, crash_count, arpdau)
SELECT p.activity_date, COUNT(*), COALESCE(MAX(u.n), 0), SUM(p.sessions), SUM(p.playtime_minutes),
       ROUND(SUM(p.iap_revenue), 2), ROUND(SUM(p.ad_revenue), 2), SUM(p.crash_count),
       ROUND((SUM(p.iap_revenue) + SUM(p.ad_revenue)) / COUNT(*), 4)
FROM player_daily p
LEFT JOIN (SELECT install_date, COUNT(*) AS n FROM users GROUP BY install_date) u ON u.install_date = p.activity_date
GROUP BY p.activity_date;

ANALYZE TABLE users, sessions, player_daily, tutorial_steps, ab_assignments, level_attempts, booster_events,
  purchases, ad_events, campaign_spend, daily_kpi;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'users' AS bang, (SELECT COUNT(*) FROM jelly.users) AS public, COUNT(*) AS hidden_1 FROM users
UNION ALL SELECT 'sessions', (SELECT COUNT(*) FROM jelly.sessions), COUNT(*) FROM sessions
UNION ALL SELECT 'player_daily', (SELECT COUNT(*) FROM jelly.player_daily), COUNT(*) FROM player_daily
UNION ALL SELECT 'tutorial_steps', (SELECT COUNT(*) FROM jelly.tutorial_steps), COUNT(*) FROM tutorial_steps
UNION ALL SELECT 'ab_assignments', (SELECT COUNT(*) FROM jelly.ab_assignments), COUNT(*) FROM ab_assignments
UNION ALL SELECT 'level_attempts', (SELECT COUNT(*) FROM jelly.level_attempts), COUNT(*) FROM level_attempts
UNION ALL SELECT 'booster_events', (SELECT COUNT(*) FROM jelly.booster_events), COUNT(*) FROM booster_events
UNION ALL SELECT 'purchases', (SELECT COUNT(*) FROM jelly.purchases), COUNT(*) FROM purchases
UNION ALL SELECT 'ad_events', (SELECT COUNT(*) FROM jelly.ad_events), COUNT(*) FROM ad_events
UNION ALL SELECT 'campaign_spend', (SELECT COUNT(*) FROM jelly.campaign_spend), COUNT(*) FROM campaign_spend
UNION ALL SELECT 'daily_kpi', (SELECT COUNT(*) FROM jelly.daily_kpi), COUNT(*) FROM daily_kpi;

SELECT level_id, COUNT(*) AS so_luot_quit, RANK() OVER (ORDER BY COUNT(*) DESC) AS hang
FROM level_attempts WHERE world_name = 'Licorice Lagoon' AND result = 'quit'
GROUP BY level_id ORDER BY so_luot_quit DESC, level_id LIMIT 5;
