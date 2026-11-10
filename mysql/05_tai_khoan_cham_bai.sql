-- 05_tai_khoan_cham_bai.sql: user sql_runner chỉ SELECT, dùng để chạy bài và bộ kiểm gói.
-- Mật khẩu không ghi ở đây: @@MATKHAU@@ được thay bằng SQL_RUNNER_PASSWORD (mysql/.env) ngay trong container:
--   docker exec sqllb-mysql sh -c 'sed "s/@@MATKHAU@@/$SQL_RUNNER_PASSWORD/" /sqllb/05_tai_khoan_cham_bai.sql | MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot'
-- Quyền: SELECT trên scm và mọi biến thể scm_hidden_*; thêm bộ dữ liệu mới thì thêm GRANT tương ứng.
-- (EXPLAIN / EXPLAIN ANALYZE chỉ cần SELECT; user tự KILL được truy vấn của chính mình khi quá giờ.)

DROP USER IF EXISTS 'sql_runner'@'%';
CREATE USER 'sql_runner'@'%' IDENTIFIED BY '@@MATKHAU@@'
  WITH MAX_USER_CONNECTIONS 20;
GRANT SELECT ON `scm`.* TO 'sql_runner'@'%';
GRANT SELECT ON `scm\_hidden\_%`.* TO 'sql_runner'@'%';
-- HR Analytics (mysql/hr/, README-hr.md):
GRANT SELECT ON `hr`.* TO 'sql_runner'@'%';
GRANT SELECT ON `hr\_hidden\_%`.* TO 'sql_runner'@'%';
-- GAME Jelly Trail Academy (mysql/jelly/, README-jelly.md):
GRANT SELECT ON `jelly`.* TO 'sql_runner'@'%';
GRANT SELECT ON `jelly\_hidden\_%`.* TO 'sql_runner'@'%';
-- MARKETING Nykaa/Purplle/Tira Beauty (mysql/mkt/, README-mkt.md):
GRANT SELECT ON `mkt`.* TO 'sql_runner'@'%';
GRANT SELECT ON `mkt\_hidden\_%`.* TO 'sql_runner'@'%';
-- Datathon (khi nạp bộ dữ liệu datathon_2026 vào cùng máy chủ):
GRANT SELECT ON `datathon\_2026`.* TO 'sql_runner'@'%';
GRANT SELECT ON `datathon\_2026\_hidden\_%`.* TO 'sql_runner'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'sql_runner'@'%';

-- Finance (AIV Bank) – them 10/11/2026: lan dung lai user luc 17:02 thieu 2 dong nay.
GRANT SELECT ON `aivb`.* TO 'sql_runner'@'%';
GRANT SELECT ON `aivb\_hidden\_%`.* TO 'sql_runner'@'%';
