-- solution.sql: gói 2 bộ GAME Jelly Trail Academy (jelly) · Module 3 String & Date, Module 4 Aggregation, case c3, c4.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên jelly (public) và jelly_hidden_1 (hidden-1).
-- Cửa sổ dữ liệu: 2026-07-01 tới 2026-08-29. hidden-1 bỏ người chơi có số thứ tự chia 10 dư 7, thêm dữ liệu các ngày 2026-08-30, 2026-09-01, 2026-09-02
-- và sự kiện LIVE_004 (xem mysql/README-jelly.md, biến thể (a)–(j)).

-- ================================================================ MODULE 3 · STRING & DATE

-- [jelly-s1-arpdau-ngay-su-kien] solution
WITH ngay AS (
  SELECT k.`date`, k.dau, k.iap_revenue + k.ad_revenue AS doanh_thu,
         COALESCE(e.event_name, 'ngay_thuong') AS nhom
  FROM daily_kpi k
  LEFT JOIN liveops_events e ON k.`date` BETWEEN e.start_date AND e.end_date
  WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
), gom AS (
  SELECT nhom, COUNT(*) AS so_ngay, SUM(dau) AS tong_dau,
         SUM(doanh_thu) / SUM(dau) AS arpdau
  FROM ngay
  GROUP BY nhom
)
SELECT g.nhom, g.so_ngay, g.tong_dau,
       ROUND(g.arpdau, 4) AS arpdau_usd,
       ROUND(100 * (g.arpdau - t.arpdau) / t.arpdau, 2) AS chenh_lech_pct
FROM gom g
CROSS JOIN (SELECT arpdau FROM gom WHERE nhom = 'ngay_thuong') t
ORDER BY chenh_lech_pct DESC, g.nhom;

-- [jelly-s1-arpdau-ngay-su-kien] wrong: trung_binh_arpdau_tung_ngay
-- Lấy trung bình cột arpdau của các ngày: ngày ít người chơi được tính nặng ngang ngày đông người chơi.
WITH ngay AS (
  SELECT k.`date`, k.dau, k.arpdau,
         COALESCE(e.event_name, 'ngay_thuong') AS nhom
  FROM daily_kpi k
  LEFT JOIN liveops_events e ON k.`date` BETWEEN e.start_date AND e.end_date
  WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
), gom AS (
  SELECT nhom, COUNT(*) AS so_ngay, SUM(dau) AS tong_dau, AVG(arpdau) AS arpdau
  FROM ngay
  GROUP BY nhom
)
SELECT g.nhom, g.so_ngay, g.tong_dau,
       ROUND(g.arpdau, 4) AS arpdau_usd,
       ROUND(100 * (g.arpdau - t.arpdau) / t.arpdau, 2) AS chenh_lech_pct
FROM gom g
CROSS JOIN (SELECT arpdau FROM gom WHERE nhom = 'ngay_thuong') t
ORDER BY chenh_lech_pct DESC, g.nhom;

-- [jelly-s1-arpdau-ngay-su-kien] wrong: bo_ngay_ket_thuc
-- Coi ngày kết thúc là mốc mở (< end_date): ngày cuối của mỗi sự kiện bị xếp vào ngày thường.
WITH ngay AS (
  SELECT k.`date`, k.dau, k.iap_revenue + k.ad_revenue AS doanh_thu,
         COALESCE(e.event_name, 'ngay_thuong') AS nhom
  FROM daily_kpi k
  LEFT JOIN liveops_events e ON k.`date` >= e.start_date AND k.`date` < e.end_date
  WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
), gom AS (
  SELECT nhom, COUNT(*) AS so_ngay, SUM(dau) AS tong_dau,
         SUM(doanh_thu) / SUM(dau) AS arpdau
  FROM ngay
  GROUP BY nhom
)
SELECT g.nhom, g.so_ngay, g.tong_dau,
       ROUND(g.arpdau, 4) AS arpdau_usd,
       ROUND(100 * (g.arpdau - t.arpdau) / t.arpdau, 2) AS chenh_lech_pct
FROM gom g
CROSS JOIN (SELECT arpdau FROM gom WHERE nhom = 'ngay_thuong') t
ORDER BY chenh_lech_pct DESC, g.nhom;

-- [jelly-s1-arpdau-ngay-su-kien] wrong: thieu_can_tren
-- Không chặn ngày cuối: khi bảng có thêm ngày sau 29/8, các ngày đó lọt vào nhóm ngày thường.
WITH ngay AS (
  SELECT k.`date`, k.dau, k.iap_revenue + k.ad_revenue AS doanh_thu,
         COALESCE(e.event_name, 'ngay_thuong') AS nhom
  FROM daily_kpi k
  LEFT JOIN liveops_events e ON k.`date` BETWEEN e.start_date AND e.end_date
  WHERE k.`date` >= '2026-07-01'
), gom AS (
  SELECT nhom, COUNT(*) AS so_ngay, SUM(dau) AS tong_dau,
         SUM(doanh_thu) / SUM(dau) AS arpdau
  FROM ngay
  GROUP BY nhom
)
SELECT g.nhom, g.so_ngay, g.tong_dau,
       ROUND(g.arpdau, 4) AS arpdau_usd,
       ROUND(100 * (g.arpdau - t.arpdau) / t.arpdau, 2) AS chenh_lech_pct
FROM gom g
CROSS JOIN (SELECT arpdau FROM gom WHERE nhom = 'ngay_thuong') t
ORDER BY chenh_lech_pct DESC, g.nhom;

-- [jelly-s1-arpdau-ngay-su-kien] wrong: gan_cung_lich_su_kien
-- Chép tay lịch ba sự kiện nhìn thấy lúc Chạy thử thay vì đọc bảng sự kiện.
WITH ngay AS (
  SELECT `date`, dau, iap_revenue + ad_revenue AS doanh_thu,
         CASE WHEN `date` BETWEEN '2026-07-10' AND '2026-07-12' THEN 'Weekend Sugar Rush'
              WHEN `date` BETWEEN '2026-07-24' AND '2026-07-28' THEN 'Candy Cup Tournament'
              WHEN `date` BETWEEN '2026-08-08' AND '2026-08-12' THEN 'Licorice Rescue'
              ELSE 'ngay_thuong' END AS nhom
  FROM daily_kpi
  WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
), gom AS (
  SELECT nhom, COUNT(*) AS so_ngay, SUM(dau) AS tong_dau,
         SUM(doanh_thu) / SUM(dau) AS arpdau
  FROM ngay
  GROUP BY nhom
)
SELECT g.nhom, g.so_ngay, g.tong_dau,
       ROUND(g.arpdau, 4) AS arpdau_usd,
       ROUND(100 * (g.arpdau - t.arpdau) / t.arpdau, 2) AS chenh_lech_pct
FROM gom g
CROSS JOIN (SELECT arpdau FROM gom WHERE nhom = 'ngay_thuong') t
ORDER BY chenh_lech_pct DESC, g.nhom;

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

-- [jelly-s4-lan-mua-dau-sau-cai] solution
WITH lan_dau AS (
  SELECT u.user_id, DATEDIFF(MIN(p.event_date), u.install_date) AS so_ngay
  FROM users u
  JOIN purchases p ON p.user_id = u.user_id
  WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
    AND p.is_refund = 0 AND p.event_date < '2026-08-30'
  GROUP BY u.user_id, u.install_date
), xep_nhom AS (
  SELECT CASE WHEN so_ngay = 0 THEN 'D0' WHEN so_ngay <= 6 THEN 'D1-D6' ELSE 'D7+' END AS nhom,
         CASE WHEN so_ngay = 0 THEN 1 WHEN so_ngay <= 6 THEN 2 ELSE 3 END AS thu_tu
  FROM lan_dau
)
SELECT nhom, COUNT(*) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM lan_dau), 2) AS ty_le_pct
FROM xep_nhom
GROUP BY nhom, thu_tu
ORDER BY thu_tu;

-- [jelly-s4-lan-mua-dau-sau-cai] wrong: xep_moi_giao_dich
-- Không lấy lần mua đầu: mỗi giao dịch được xếp một lần, người mua nhiều lần bị đếm nhiều lần.
WITH lan_mua AS (
  SELECT u.user_id, DATEDIFF(p.event_date, u.install_date) AS so_ngay
  FROM users u
  JOIN purchases p ON p.user_id = u.user_id
  WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
    AND p.is_refund = 0 AND p.event_date < '2026-08-30'
), xep_nhom AS (
  SELECT CASE WHEN so_ngay = 0 THEN 'D0' WHEN so_ngay <= 6 THEN 'D1-D6' ELSE 'D7+' END AS nhom,
         CASE WHEN so_ngay = 0 THEN 1 WHEN so_ngay <= 6 THEN 2 ELSE 3 END AS thu_tu
  FROM lan_mua
)
SELECT nhom, COUNT(*) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM lan_mua), 2) AS ty_le_pct
FROM xep_nhom
GROUP BY nhom, thu_tu
ORDER BY thu_tu;

-- [jelly-s4-lan-mua-dau-sau-cai] wrong: dao_thu_tu_datediff
-- DATEDIFF(a, b) = a - b; đảo đối số ra số âm, mọi người dồn vào nhóm D0 và D1-D6.
WITH lan_dau AS (
  SELECT u.user_id, DATEDIFF(u.install_date, MIN(p.event_date)) AS so_ngay
  FROM users u
  JOIN purchases p ON p.user_id = u.user_id
  WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
    AND p.is_refund = 0 AND p.event_date < '2026-08-30'
  GROUP BY u.user_id, u.install_date
), xep_nhom AS (
  SELECT CASE WHEN so_ngay = 0 THEN 'D0' WHEN so_ngay <= 6 THEN 'D1-D6' ELSE 'D7+' END AS nhom,
         CASE WHEN so_ngay = 0 THEN 1 WHEN so_ngay <= 6 THEN 2 ELSE 3 END AS thu_tu
  FROM lan_dau
)
SELECT nhom, COUNT(*) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM lan_dau), 2) AS ty_le_pct
FROM xep_nhom
GROUP BY nhom, thu_tu
ORDER BY thu_tu;

-- [jelly-s4-lan-mua-dau-sau-cai] wrong: thieu_can_tren
-- Không chặn ngày giao dịch: người chơi cài tháng 7 mua lần đầu sau 29/8 bị tính là người trả tiền.
WITH lan_dau AS (
  SELECT u.user_id, DATEDIFF(MIN(p.event_date), u.install_date) AS so_ngay
  FROM users u
  JOIN purchases p ON p.user_id = u.user_id
  WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
    AND p.is_refund = 0
  GROUP BY u.user_id, u.install_date
), xep_nhom AS (
  SELECT CASE WHEN so_ngay = 0 THEN 'D0' WHEN so_ngay <= 6 THEN 'D1-D6' ELSE 'D7+' END AS nhom,
         CASE WHEN so_ngay = 0 THEN 1 WHEN so_ngay <= 6 THEN 2 ELSE 3 END AS thu_tu
  FROM lan_dau
)
SELECT nhom, COUNT(*) AS so_nguoi_tra_tien,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM lan_dau), 2) AS ty_le_pct
FROM xep_nhom
GROUP BY nhom, thu_tu
ORDER BY thu_tu;

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

-- [jelly-s6-giu-chan-d7-theo-tuan] solution
WITH nhom AS (
  SELECT user_id, install_date,
         YEARWEEK(install_date, 3) AS tuan,
         DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan
  FROM users
  WHERE install_date >= '2026-07-01'
    AND DATE_ADD(install_date, INTERVAL 7 DAY) <= '2026-08-29'
), co_d7 AS (
  SELECT n.user_id, n.tuan, n.ngay_dau_tuan,
         MAX(CASE WHEN p.activity_date = DATE_ADD(n.install_date, INTERVAL 7 DAY) THEN 1 ELSE 0 END) AS con_d7
  FROM nhom n
  LEFT JOIN player_daily p ON p.user_id = n.user_id
  GROUP BY n.user_id, n.tuan, n.ngay_dau_tuan
)
SELECT tuan, ngay_dau_tuan, COUNT(*) AS so_nguoi_cai, SUM(con_d7) AS so_con_d7,
       ROUND(100 * SUM(con_d7) / COUNT(*), 2) AS ty_le_d7_pct
FROM co_d7
GROUP BY tuan, ngay_dau_tuan
ORDER BY tuan;

-- [jelly-s6-giu-chan-d7-theo-tuan] wrong: tuan_bat_dau_chu_nhat
-- YEARWEEK mặc định (mode 0) bắt đầu tuần vào Chủ nhật: người cài Chủ nhật bị xếp sang tuần sau.
WITH nhom AS (
  SELECT user_id, install_date,
         YEARWEEK(install_date) AS tuan,
         DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan
  FROM users
  WHERE install_date >= '2026-07-01'
    AND DATE_ADD(install_date, INTERVAL 7 DAY) <= '2026-08-29'
), co_d7 AS (
  SELECT n.user_id, n.tuan, n.ngay_dau_tuan,
         MAX(CASE WHEN p.activity_date = DATE_ADD(n.install_date, INTERVAL 7 DAY) THEN 1 ELSE 0 END) AS con_d7
  FROM nhom n
  LEFT JOIN player_daily p ON p.user_id = n.user_id
  GROUP BY n.user_id, n.tuan, n.ngay_dau_tuan
)
SELECT tuan, MIN(ngay_dau_tuan) AS ngay_dau_tuan, COUNT(*) AS so_nguoi_cai, SUM(con_d7) AS so_con_d7,
       ROUND(100 * SUM(con_d7) / COUNT(*), 2) AS ty_le_d7_pct
FROM co_d7
GROUP BY tuan
ORDER BY tuan;

-- [jelly-s6-giu-chan-d7-theo-tuan] wrong: tinh_ca_nhom_chua_du_ngay
-- Không loại người cài sau 22/8: họ chưa tới ngày thứ 7 nên làm tỷ lệ tuần cuối thấp giả.
WITH nhom AS (
  SELECT user_id, install_date,
         YEARWEEK(install_date, 3) AS tuan,
         DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan
  FROM users
  WHERE install_date >= '2026-07-01' AND install_date < '2026-08-30'
), co_d7 AS (
  SELECT n.user_id, n.tuan, n.ngay_dau_tuan,
         MAX(CASE WHEN p.activity_date = DATE_ADD(n.install_date, INTERVAL 7 DAY) THEN 1 ELSE 0 END) AS con_d7
  FROM nhom n
  LEFT JOIN player_daily p ON p.user_id = n.user_id
  GROUP BY n.user_id, n.tuan, n.ngay_dau_tuan
)
SELECT tuan, ngay_dau_tuan, COUNT(*) AS so_nguoi_cai, SUM(con_d7) AS so_con_d7,
       ROUND(100 * SUM(con_d7) / COUNT(*), 2) AS ty_le_d7_pct
FROM co_d7
GROUP BY tuan, ngay_dau_tuan
ORDER BY tuan;

-- [jelly-s6-giu-chan-d7-theo-tuan] wrong: noi_trong_mat_mau_so
-- Nối trong với dòng hoạt động ngày thứ 7: người không quay lại biến mất khỏi mẫu số, tỷ lệ thành 100%.
WITH nhom AS (
  SELECT user_id, install_date,
         YEARWEEK(install_date, 3) AS tuan,
         DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan
  FROM users
  WHERE install_date >= '2026-07-01'
    AND DATE_ADD(install_date, INTERVAL 7 DAY) <= '2026-08-29'
)
SELECT n.tuan, n.ngay_dau_tuan, COUNT(*) AS so_nguoi_cai, COUNT(p.user_id) AS so_con_d7,
       ROUND(100 * COUNT(p.user_id) / COUNT(*), 2) AS ty_le_d7_pct
FROM nhom n
JOIN player_daily p ON p.user_id = n.user_id
                   AND p.activity_date = DATE_ADD(n.install_date, INTERVAL 7 DAY)
GROUP BY n.tuan, n.ngay_dau_tuan
ORDER BY n.tuan;

-- [jelly-s6-giu-chan-d7-theo-tuan] wrong: ngay_cuoi_bang_max
-- Lấy ngày cuối của dữ liệu bằng MAX(activity_date): khi bảng có thêm ngày sau 29/8, nhóm chưa đủ ngày lọt vào.
WITH nhom AS (
  SELECT user_id, install_date,
         YEARWEEK(install_date, 3) AS tuan,
         DATE_SUB(install_date, INTERVAL WEEKDAY(install_date) DAY) AS ngay_dau_tuan
  FROM users
  WHERE install_date >= '2026-07-01'
    AND DATE_ADD(install_date, INTERVAL 7 DAY) <= (SELECT MAX(activity_date) FROM player_daily)
), co_d7 AS (
  SELECT n.user_id, n.tuan, n.ngay_dau_tuan,
         MAX(CASE WHEN p.activity_date = DATE_ADD(n.install_date, INTERVAL 7 DAY) THEN 1 ELSE 0 END) AS con_d7
  FROM nhom n
  LEFT JOIN player_daily p ON p.user_id = n.user_id
  GROUP BY n.user_id, n.tuan, n.ngay_dau_tuan
)
SELECT tuan, ngay_dau_tuan, COUNT(*) AS so_nguoi_cai, SUM(con_d7) AS so_con_d7,
       ROUND(100 * SUM(con_d7) / COUNT(*), 2) AS ty_le_d7_pct
FROM co_d7
GROUP BY tuan, ngay_dau_tuan
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

-- [jelly-s8-su-co-ba-ngay-dau] starter
WITH phat_hanh AS (
  SELECT app_version_install AS app_version, MIN(install_date) AS ngay_phat_hanh
  FROM users
  WHERE app_version_install IN ('2.1.0', '2.1.1')
  GROUP BY app_version_install
)
SELECT ph.app_version, ph.ngay_phat_hanh,
       SUM(p.sessions) AS so_phien, SUM(p.crash_count) AS so_su_co,
       ROUND(1000 * SUM(p.crash_count) / SUM(p.sessions), 2) AS su_co_tren_1000_phien
FROM phat_hanh ph
JOIN player_daily p ON p.app_version = ph.app_version
WHERE p.activity_date >= ph.ngay_phat_hanh
  AND p.activity_date <= ph.ngay_phat_hanh + 2
GROUP BY ph.app_version, ph.ngay_phat_hanh
ORDER BY ph.ngay_phat_hanh;

-- [jelly-s8-su-co-ba-ngay-dau] solution
WITH phat_hanh AS (
  SELECT app_version_install AS app_version, MIN(install_date) AS ngay_phat_hanh
  FROM users
  WHERE app_version_install IN ('2.1.0', '2.1.1')
  GROUP BY app_version_install
)
SELECT ph.app_version, ph.ngay_phat_hanh,
       SUM(p.sessions) AS so_phien, SUM(p.crash_count) AS so_su_co,
       ROUND(1000 * SUM(p.crash_count) / SUM(p.sessions), 2) AS su_co_tren_1000_phien
FROM phat_hanh ph
JOIN player_daily p ON p.app_version = ph.app_version
WHERE p.activity_date >= ph.ngay_phat_hanh
  AND p.activity_date < DATE_ADD(ph.ngay_phat_hanh, INTERVAL 3 DAY)
GROUP BY ph.app_version, ph.ngay_phat_hanh
ORDER BY ph.ngay_phat_hanh;

-- [jelly-s8-su-co-ba-ngay-dau] wrong: lay_bon_ngay
-- Đổi sang DATE_ADD nhưng giữ dấu <= với 3 ngày: lấy cả ngày thứ tư.
WITH phat_hanh AS (
  SELECT app_version_install AS app_version, MIN(install_date) AS ngay_phat_hanh
  FROM users
  WHERE app_version_install IN ('2.1.0', '2.1.1')
  GROUP BY app_version_install
)
SELECT ph.app_version, ph.ngay_phat_hanh,
       SUM(p.sessions) AS so_phien, SUM(p.crash_count) AS so_su_co,
       ROUND(1000 * SUM(p.crash_count) / SUM(p.sessions), 2) AS su_co_tren_1000_phien
FROM phat_hanh ph
JOIN player_daily p ON p.app_version = ph.app_version
WHERE p.activity_date >= ph.ngay_phat_hanh
  AND p.activity_date <= DATE_ADD(ph.ngay_phat_hanh, INTERVAL 3 DAY)
GROUP BY ph.app_version, ph.ngay_phat_hanh
ORDER BY ph.ngay_phat_hanh;

-- [jelly-s8-su-co-ba-ngay-dau] wrong: phien_ban_luc_cai
-- Lấy phiên bản lúc cài của người chơi thay cho phiên bản dùng trong ngày hoạt động.
WITH phat_hanh AS (
  SELECT app_version_install AS app_version, MIN(install_date) AS ngay_phat_hanh
  FROM users
  WHERE app_version_install IN ('2.1.0', '2.1.1')
  GROUP BY app_version_install
)
SELECT ph.app_version, ph.ngay_phat_hanh,
       SUM(p.sessions) AS so_phien, SUM(p.crash_count) AS so_su_co,
       ROUND(1000 * SUM(p.crash_count) / SUM(p.sessions), 2) AS su_co_tren_1000_phien
FROM phat_hanh ph
JOIN users u ON u.app_version_install = ph.app_version
JOIN player_daily p ON p.user_id = u.user_id
WHERE p.activity_date >= ph.ngay_phat_hanh
  AND p.activity_date < DATE_ADD(ph.ngay_phat_hanh, INTERVAL 3 DAY)
GROUP BY ph.app_version, ph.ngay_phat_hanh
ORDER BY ph.ngay_phat_hanh;

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
       ROUND(SUM(price_usd), 2) AS doanh_thu_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-a2-doanh-thu-goi] wrong: quen_can_tren
-- Chỉ có cận dưới: giao dịch tháng 8 lẫn vào.
SELECT product_name,
       COUNT(*) AS so_giao_dich,
       ROUND(SUM(price_usd), 2) AS doanh_thu_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-a2-doanh-thu-goi] wrong: dem_nguoi_mua_thay_giao_dich
SELECT product_name,
       COUNT(DISTINCT user_id) AS so_giao_dich,
       ROUND(SUM(price_usd), 2) AS doanh_thu_usd
FROM purchases
WHERE is_refund = 0
  AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-a3-chi-theo-kenh] solution
SELECT channel,
       ROUND(SUM(spend_usd), 2) AS tong_chi_usd
FROM campaign_spend
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
GROUP BY channel
ORDER BY tong_chi_usd DESC, channel;

-- [jelly-a3-chi-theo-kenh] wrong: quen_can_tren
SELECT channel,
       ROUND(SUM(spend_usd), 2) AS tong_chi_usd
FROM campaign_spend
WHERE `date` >= '2026-07-01'
GROUP BY channel
ORDER BY tong_chi_usd DESC, channel;

-- [jelly-a3-chi-theo-kenh] wrong: avg_thay_sum
-- AVG(spend_usd) là chi bình quân một dòng, không phải tổng chi của kênh.
SELECT channel,
       ROUND(AVG(spend_usd), 2) AS tong_chi_usd
FROM campaign_spend
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
GROUP BY channel
ORDER BY tong_chi_usd DESC, channel;

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

-- [jelly-a6-su-co-truoc-sau-ban-va] solution
WITH gom AS (
  SELECT country,
         SUM(CASE WHEN app_version = '2.1.0' THEN sessions ELSE 0 END) AS phien_210,
         SUM(CASE WHEN app_version = '2.1.0' THEN crash_count ELSE 0 END) AS su_co_210,
         SUM(CASE WHEN app_version = '2.1.1' THEN sessions ELSE 0 END) AS phien_211,
         SUM(CASE WHEN app_version = '2.1.1' THEN crash_count ELSE 0 END) AS su_co_211
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
  GROUP BY country
)
SELECT country,
       phien_210, ROUND(1000 * su_co_210 / phien_210, 2) AS ty_le_210,
       phien_211, ROUND(1000 * su_co_211 / phien_211, 2) AS ty_le_211,
       ROUND(1000 * su_co_211 / phien_211 - 1000 * su_co_210 / phien_210, 2) AS chenh_lech
FROM gom
ORDER BY chenh_lech DESC, country;

-- [jelly-a6-su-co-truoc-sau-ban-va] wrong: phien_ban_luc_cai
-- Xếp phiên theo phiên bản lúc cài của người chơi: người cài 2.1.0 rồi cập nhật lên bản vá vẫn bị tính cho 2.1.0.
WITH gom AS (
  SELECT p.country,
         SUM(CASE WHEN u.app_version_install = '2.1.0' THEN p.sessions ELSE 0 END) AS phien_210,
         SUM(CASE WHEN u.app_version_install = '2.1.0' THEN p.crash_count ELSE 0 END) AS su_co_210,
         SUM(CASE WHEN u.app_version_install = '2.1.1' THEN p.sessions ELSE 0 END) AS phien_211,
         SUM(CASE WHEN u.app_version_install = '2.1.1' THEN p.crash_count ELSE 0 END) AS su_co_211
  FROM player_daily p
  JOIN users u ON u.user_id = p.user_id
  WHERE p.activity_date >= '2026-07-01' AND p.activity_date < '2026-08-30'
  GROUP BY p.country
)
SELECT country,
       phien_210, ROUND(1000 * su_co_210 / phien_210, 2) AS ty_le_210,
       phien_211, ROUND(1000 * su_co_211 / phien_211, 2) AS ty_le_211,
       ROUND(1000 * su_co_211 / phien_211 - 1000 * su_co_210 / phien_210, 2) AS chenh_lech
FROM gom
ORDER BY chenh_lech DESC, country;

-- [jelly-a6-su-co-truoc-sau-ban-va] wrong: so_voi_moi_ban_cu
-- So bản vá với mọi bản khác, gồm cả 2.0.2 không có sự cố, thay vì với bản 2.1.0.
WITH gom AS (
  SELECT country,
         SUM(CASE WHEN app_version <> '2.1.1' THEN sessions ELSE 0 END) AS phien_210,
         SUM(CASE WHEN app_version <> '2.1.1' THEN crash_count ELSE 0 END) AS su_co_210,
         SUM(CASE WHEN app_version = '2.1.1' THEN sessions ELSE 0 END) AS phien_211,
         SUM(CASE WHEN app_version = '2.1.1' THEN crash_count ELSE 0 END) AS su_co_211
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
  GROUP BY country
)
SELECT country,
       phien_210, ROUND(1000 * su_co_210 / phien_210, 2) AS ty_le_210,
       phien_211, ROUND(1000 * su_co_211 / phien_211, 2) AS ty_le_211,
       ROUND(1000 * su_co_211 / phien_211 - 1000 * su_co_210 / phien_210, 2) AS chenh_lech
FROM gom
ORDER BY chenh_lech DESC, country;

-- [jelly-a6-su-co-truoc-sau-ban-va] wrong: trung_binh_ty_le_tung_dong
-- Trung bình tỷ lệ của từng người-ngày: ngày một phiên được tính nặng ngang ngày nhiều phiên.
WITH gom AS (
  SELECT country,
         SUM(CASE WHEN app_version = '2.1.0' THEN sessions ELSE 0 END) AS phien_210,
         AVG(CASE WHEN app_version = '2.1.0' THEN 1000 * crash_count / sessions END) AS ty_le_210,
         SUM(CASE WHEN app_version = '2.1.1' THEN sessions ELSE 0 END) AS phien_211,
         AVG(CASE WHEN app_version = '2.1.1' THEN 1000 * crash_count / sessions END) AS ty_le_211
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
  GROUP BY country
)
SELECT country,
       phien_210, ROUND(ty_le_210, 2) AS ty_le_210,
       phien_211, ROUND(ty_le_211, 2) AS ty_le_211,
       ROUND(ty_le_211 - ty_le_210, 2) AS chenh_lech
FROM gom
ORDER BY chenh_lech DESC, country;

-- [jelly-a6-su-co-truoc-sau-ban-va] wrong: bo_cua_so_du_lieu
SELECT country,
       SUM(CASE WHEN app_version = '2.1.0' THEN sessions ELSE 0 END) AS phien_210,
       ROUND(1000 * SUM(CASE WHEN app_version = '2.1.0' THEN crash_count ELSE 0 END)
                  / SUM(CASE WHEN app_version = '2.1.0' THEN sessions ELSE 0 END), 2) AS ty_le_210,
       SUM(CASE WHEN app_version = '2.1.1' THEN sessions ELSE 0 END) AS phien_211,
       ROUND(1000 * SUM(CASE WHEN app_version = '2.1.1' THEN crash_count ELSE 0 END)
                  / SUM(CASE WHEN app_version = '2.1.1' THEN sessions ELSE 0 END), 2) AS ty_le_211,
       ROUND(1000 * SUM(CASE WHEN app_version = '2.1.1' THEN crash_count ELSE 0 END)
                  / SUM(CASE WHEN app_version = '2.1.1' THEN sessions ELSE 0 END)
           - 1000 * SUM(CASE WHEN app_version = '2.1.0' THEN crash_count ELSE 0 END)
                  / SUM(CASE WHEN app_version = '2.1.0' THEN sessions ELSE 0 END), 2) AS chenh_lech
FROM player_daily
GROUP BY country
ORDER BY chenh_lech DESC, country;

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

-- [jelly-a8-arpdau-thang-8-nen-tang] starter
SELECT platform,
       ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       COUNT(DISTINCT user_id) AS tong_dau,
       ROUND(SUM(iap_revenue + ad_revenue) / COUNT(DISTINCT user_id), 4) AS arpdau_usd
FROM player_daily
WHERE activity_date >= '2026-08-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a8-arpdau-thang-8-nen-tang] solution
SELECT platform,
       ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       COUNT(*) AS tong_dau,
       ROUND(SUM(iap_revenue + ad_revenue) / COUNT(*), 4) AS arpdau_usd
FROM player_daily
WHERE activity_date >= '2026-08-01' AND activity_date < '2026-09-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a8-arpdau-thang-8-nen-tang] wrong: chi_sua_can_tren
-- Thêm cận trên nhưng vẫn đếm người chơi khác nhau cả tháng (MAU) làm tổng DAU.
SELECT platform,
       ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       COUNT(DISTINCT user_id) AS tong_dau,
       ROUND(SUM(iap_revenue + ad_revenue) / COUNT(DISTINCT user_id), 4) AS arpdau_usd
FROM player_daily
WHERE activity_date >= '2026-08-01' AND activity_date < '2026-09-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a8-arpdau-thang-8-nen-tang] wrong: chi_sua_tong_dau
-- Sửa tổng DAU nhưng vẫn thiếu cận trên: dữ liệu tháng 9 lẫn vào tháng 8.
SELECT platform,
       ROUND(SUM(iap_revenue + ad_revenue), 2) AS tong_doanh_thu_usd,
       COUNT(*) AS tong_dau,
       ROUND(SUM(iap_revenue + ad_revenue) / COUNT(*), 4) AS arpdau_usd
FROM player_daily
WHERE activity_date >= '2026-08-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-a8-arpdau-thang-8-nen-tang] wrong: trung_binh_arpdau_tung_ngay
-- Trung bình ARPDAU của từng ngày: ngày ít người chơi được tính nặng ngang ngày đông người chơi.
SELECT platform,
       ROUND(SUM(doanh_thu), 2) AS tong_doanh_thu_usd,
       SUM(dau) AS tong_dau,
       ROUND(AVG(doanh_thu / dau), 4) AS arpdau_usd
FROM (
  SELECT platform, activity_date,
         SUM(iap_revenue + ad_revenue) AS doanh_thu, COUNT(*) AS dau
  FROM player_daily
  WHERE activity_date >= '2026-08-01' AND activity_date < '2026-09-01'
  GROUP BY platform, activity_date
) t
GROUP BY platform
ORDER BY platform;

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
