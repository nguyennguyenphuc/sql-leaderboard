-- 04_quyen_aivb.sql: cấp SELECT trên bộ AIV Bank cho user chấm bài sql_runner (user tạo ở ../05_tai_khoan_cham_bai.sql).
-- Chạy sau 02 và 03, KHÔNG tạo lại user (không đổi mật khẩu, không đụng quyền bộ scm):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/aivb/04_quyen_aivb.sql
-- Khi dựng lại cả máy chủ bằng 05_tai_khoan_cham_bai.sql (DROP USER), chạy lại file này.
GRANT SELECT ON `aivb`.* TO 'sql_runner'@'%';
GRANT SELECT ON `aivb\_hidden\_%`.* TO 'sql_runner'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'sql_runner'@'%';
