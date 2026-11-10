-- solution.sql: gói 4 bộ GAME Jelly Trail Academy (jelly) · Module 7 CTE & Set Operations, Module 8 Window Functions, case c7, c8.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chạy trên jelly (public) và jelly_hidden_1 (hidden-1).

-- ===================================================================== MODULE 7 · CTE & SET OPERATIONS

-- [jelly-t1-pheu-huong-dan] solution
WITH nhom AS (
  SELECT user_id
  FROM users
  WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
), buoc AS (
  SELECT t.step_id, t.step_name, COUNT(*) AS so_bat_dau, SUM(t.step_completed) AS so_hoan_thanh
  FROM tutorial_steps t
  JOIN nhom n ON n.user_id = t.user_id
  GROUP BY t.step_id, t.step_name
), tong AS (
  SELECT COUNT(*) AS so_nguoi_cai FROM nhom
)
SELECT b.step_id AS buoc, b.step_name, b.so_bat_dau, b.so_hoan_thanh,
       ROUND(100 * b.so_hoan_thanh / b.so_bat_dau, 2) AS ty_le_hoan_thanh_pct,
       ROUND(100 * b.so_hoan_thanh / tong.so_nguoi_cai, 2) AS ty_le_con_lai_pct
FROM buoc b
CROSS JOIN tong
ORDER BY b.step_id;

-- [jelly-t1-pheu-huong-dan] wrong: mau_so_la_buoc_1
-- Lấy số người bắt đầu bước 1 làm mẫu số cho mọi bước (rớt ở public).
WITH nhom AS (
  SELECT user_id FROM users
  WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
), buoc AS (
  SELECT t.step_id, t.step_name, COUNT(*) AS so_bat_dau, SUM(t.step_completed) AS so_hoan_thanh
  FROM tutorial_steps t JOIN nhom n ON n.user_id = t.user_id
  GROUP BY t.step_id, t.step_name
), dau AS (
  SELECT so_bat_dau AS so_buoc_1 FROM buoc WHERE step_id = 1
)
SELECT b.step_id AS buoc, b.step_name, b.so_bat_dau, b.so_hoan_thanh,
       ROUND(100 * b.so_hoan_thanh / dau.so_buoc_1, 2) AS ty_le_hoan_thanh_pct,
       ROUND(100 * b.so_hoan_thanh / dau.so_buoc_1, 2) AS ty_le_con_lai_pct
FROM buoc b CROSS JOIN dau
ORDER BY b.step_id;

-- [jelly-t1-pheu-huong-dan] wrong: thieu_can_tren_nhom_cai
-- Nhóm cài lấy từ 1/7 trở đi, lẫn người cài tháng 8 (rớt ở public).
WITH nhom AS (
  SELECT user_id FROM users WHERE install_date >= '2026-07-01'
), buoc AS (
  SELECT t.step_id, t.step_name, COUNT(*) AS so_bat_dau, SUM(t.step_completed) AS so_hoan_thanh
  FROM tutorial_steps t JOIN nhom n ON n.user_id = t.user_id
  GROUP BY t.step_id, t.step_name
), tong AS (
  SELECT COUNT(*) AS so_nguoi_cai FROM nhom
)
SELECT b.step_id AS buoc, b.step_name, b.so_bat_dau, b.so_hoan_thanh,
       ROUND(100 * b.so_hoan_thanh / b.so_bat_dau, 2) AS ty_le_hoan_thanh_pct,
       ROUND(100 * b.so_hoan_thanh / tong.so_nguoi_cai, 2) AS ty_le_con_lai_pct
FROM buoc b CROSS JOIN tong
ORDER BY b.step_id;

-- [jelly-t2-so-buoc-hoan-thanh] solution
WITH moi_nguoi AS (
  SELECT user_id, SUM(step_completed) AS so_buoc_hoan_thanh
  FROM tutorial_steps
  WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
  GROUP BY user_id
)
SELECT so_buoc_hoan_thanh, COUNT(*) AS so_nguoi
FROM moi_nguoi
GROUP BY so_buoc_hoan_thanh
ORDER BY so_buoc_hoan_thanh;

-- [jelly-t2-so-buoc-hoan-thanh] wrong: dem_buoc_da_bat_dau
-- Đếm mọi dòng của người chơi, gồm cả bước bắt đầu nhưng bỏ dở (rớt ở public).
WITH moi_nguoi AS (
  SELECT user_id, COUNT(*) AS so_buoc_hoan_thanh
  FROM tutorial_steps
  WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
  GROUP BY user_id
)
SELECT so_buoc_hoan_thanh, COUNT(*) AS so_nguoi
FROM moi_nguoi GROUP BY so_buoc_hoan_thanh ORDER BY so_buoc_hoan_thanh;

-- [jelly-t2-so-buoc-hoan-thanh] wrong: thieu_can_tren_thang_7
-- Lọc ngày cài từ 1/7 trở đi, lẫn người cài tháng 8 (rớt ở public).
WITH moi_nguoi AS (
  SELECT user_id, SUM(step_completed) AS so_buoc_hoan_thanh
  FROM tutorial_steps
  WHERE install_date >= '2026-07-01'
  GROUP BY user_id
)
SELECT so_buoc_hoan_thanh, COUNT(*) AS so_nguoi
FROM moi_nguoi GROUP BY so_buoc_hoan_thanh ORDER BY so_buoc_hoan_thanh;

-- [jelly-t3-mua-tu-3-lan] solution
WITH moi_nguoi AS (
  SELECT user_id, COUNT(*) AS so_lan_mua, SUM(price_usd) AS tong_chi
  FROM purchases
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
  GROUP BY user_id
)
SELECT user_id, so_lan_mua, ROUND(tong_chi, 2) AS tong_chi_usd
FROM moi_nguoi
WHERE so_lan_mua >= 3
ORDER BY so_lan_mua DESC, tong_chi_usd DESC, user_id;

-- [jelly-t3-mua-tu-3-lan] wrong: lon_hon_3
-- Dùng > 3 nên bỏ mất người mua đúng 3 lần (rớt ở public).
WITH moi_nguoi AS (
  SELECT user_id, COUNT(*) AS so_lan_mua, SUM(price_usd) AS tong_chi
  FROM purchases
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
  GROUP BY user_id
)
SELECT user_id, so_lan_mua, ROUND(tong_chi, 2) AS tong_chi_usd
FROM moi_nguoi WHERE so_lan_mua > 3
ORDER BY so_lan_mua DESC, tong_chi_usd DESC, user_id;

-- [jelly-t3-mua-tu-3-lan] wrong: dem_loai_goi
-- Đếm số loại gói khác nhau thay vì số lần mua (rớt ở public).
WITH moi_nguoi AS (
  SELECT user_id, COUNT(DISTINCT product_type) AS so_lan_mua, SUM(price_usd) AS tong_chi
  FROM purchases
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30'
  GROUP BY user_id
)
SELECT user_id, so_lan_mua, ROUND(tong_chi, 2) AS tong_chi_usd
FROM moi_nguoi WHERE so_lan_mua >= 3
ORDER BY so_lan_mua DESC, tong_chi_usd DESC, user_id;

-- [jelly-t3-mua-tu-3-lan] wrong: thieu_can_tren
-- Không chặn ngày cuối cửa sổ: hidden-1 có thêm giao dịch 30/8 và 1/9 của jta_user_000648 (rớt ở hidden-1).
WITH moi_nguoi AS (
  SELECT user_id, COUNT(*) AS so_lan_mua, SUM(price_usd) AS tong_chi
  FROM purchases
  WHERE event_date >= '2026-07-01'
  GROUP BY user_id
)
SELECT user_id, so_lan_mua, ROUND(tong_chi, 2) AS tong_chi_usd
FROM moi_nguoi WHERE so_lan_mua >= 3
ORDER BY so_lan_mua DESC, tong_chi_usd DESC, user_id;

-- [jelly-t4-kenh-co-va-khong-chi] solution
WITH cai AS (
  SELECT u.channel, u.campaign_id, u.country, u.platform, u.install_date
  FROM users u
  WHERE u.channel <> 'Organic'
    AND u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
), chi AS (
  SELECT s.channel, s.campaign_id, s.country, s.target_platform, s.`date`, s.spend_usd
  FROM campaign_spend s
  WHERE s.`date` >= '2026-07-01' AND s.`date` < '2026-08-01'
), lech AS (
  SELECT c.channel, 1 AS nguoi_khong_chi, 0 AS dong_khong_cai, 0 AS tien_khong_cai
  FROM cai c
  WHERE NOT EXISTS (SELECT 1 FROM chi s
                    WHERE s.campaign_id = c.campaign_id AND s.country = c.country
                      AND s.target_platform = c.platform AND s.`date` = c.install_date)
  UNION ALL
  SELECT s.channel, 0, 1, s.spend_usd
  FROM chi s
  WHERE NOT EXISTS (SELECT 1 FROM cai c
                    WHERE c.campaign_id = s.campaign_id AND c.country = s.country
                      AND c.platform = s.target_platform AND c.install_date = s.`date`)
)
SELECT channel,
       SUM(nguoi_khong_chi) AS so_nguoi_cai_khong_chi,
       SUM(dong_khong_cai) AS so_dong_chi_khong_cai,
       ROUND(SUM(tien_khong_cai), 2) AS chi_khong_cai_usd
FROM lech
GROUP BY channel
ORDER BY channel;

-- [jelly-t4-kenh-co-va-khong-chi] wrong: union_bo_dong_trung
-- UNION bỏ các dòng giống hệt nhau, mỗi kênh còn rất ít dòng (rớt ở public).
WITH cai AS (
  SELECT u.channel, u.campaign_id, u.country, u.platform, u.install_date FROM users u
  WHERE u.channel <> 'Organic' AND u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
), chi AS (
  SELECT s.channel, s.campaign_id, s.country, s.target_platform, s.`date`, s.spend_usd FROM campaign_spend s
  WHERE s.`date` >= '2026-07-01' AND s.`date` < '2026-08-01'
), lech AS (
  SELECT c.channel, 1 AS nguoi_khong_chi, 0 AS dong_khong_cai, 0 AS tien_khong_cai
  FROM cai c
  WHERE NOT EXISTS (SELECT 1 FROM chi s
                    WHERE s.campaign_id = c.campaign_id AND s.country = c.country
                      AND s.target_platform = c.platform AND s.`date` = c.install_date)
  UNION
  SELECT s.channel, 0, 1, s.spend_usd
  FROM chi s
  WHERE NOT EXISTS (SELECT 1 FROM cai c
                    WHERE c.campaign_id = s.campaign_id AND c.country = s.country
                      AND c.platform = s.target_platform AND c.install_date = s.`date`)
)
SELECT channel, SUM(nguoi_khong_chi) AS so_nguoi_cai_khong_chi, SUM(dong_khong_cai) AS so_dong_chi_khong_cai,
       ROUND(SUM(tien_khong_cai), 2) AS chi_khong_cai_usd
FROM lech GROUP BY channel ORDER BY channel;

-- [jelly-t4-kenh-co-va-khong-chi] wrong: bo_qua_nen_tang
-- Ghép bỏ qua nền tảng nhắm tới: người cài iOS được tính là có chi phí dù ngày đó chiến dịch chỉ nhắm Android (rớt ở public).
WITH cai AS (
  SELECT u.channel, u.campaign_id, u.country, u.platform, u.install_date FROM users u
  WHERE u.channel <> 'Organic' AND u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
), chi AS (
  SELECT s.channel, s.campaign_id, s.country, s.target_platform, s.`date`, s.spend_usd FROM campaign_spend s
  WHERE s.`date` >= '2026-07-01' AND s.`date` < '2026-08-01'
), lech AS (
  SELECT c.channel, 1 AS nguoi_khong_chi, 0 AS dong_khong_cai, 0 AS tien_khong_cai
  FROM cai c
  WHERE NOT EXISTS (SELECT 1 FROM chi s
                    WHERE s.campaign_id = c.campaign_id AND s.country = c.country AND s.`date` = c.install_date)
  UNION ALL
  SELECT s.channel, 0, 1, s.spend_usd
  FROM chi s
  WHERE NOT EXISTS (SELECT 1 FROM cai c
                    WHERE c.campaign_id = s.campaign_id AND c.country = s.country AND c.install_date = s.`date`)
)
SELECT channel, SUM(nguoi_khong_chi) AS so_nguoi_cai_khong_chi, SUM(dong_khong_cai) AS so_dong_chi_khong_cai,
       ROUND(SUM(tien_khong_cai), 2) AS chi_khong_cai_usd
FROM lech GROUP BY channel ORDER BY channel;

-- [jelly-t4-kenh-co-va-khong-chi] wrong: chi_thieu_can_tren
-- Chi phí lấy từ 1/7 trở đi, lẫn tháng 8 (rớt ở public).
WITH cai AS (
  SELECT u.channel, u.campaign_id, u.country, u.platform, u.install_date FROM users u
  WHERE u.channel <> 'Organic' AND u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
), chi AS (
  SELECT s.channel, s.campaign_id, s.country, s.target_platform, s.`date`, s.spend_usd FROM campaign_spend s
  WHERE s.`date` >= '2026-07-01'
), lech AS (
  SELECT c.channel, 1 AS nguoi_khong_chi, 0 AS dong_khong_cai, 0 AS tien_khong_cai
  FROM cai c
  WHERE NOT EXISTS (SELECT 1 FROM chi s
                    WHERE s.campaign_id = c.campaign_id AND s.country = c.country
                      AND s.target_platform = c.platform AND s.`date` = c.install_date)
  UNION ALL
  SELECT s.channel, 0, 1, s.spend_usd
  FROM chi s
  WHERE NOT EXISTS (SELECT 1 FROM cai c
                    WHERE c.campaign_id = s.campaign_id AND c.country = s.country
                      AND c.platform = s.target_platform AND c.install_date = s.`date`)
)
SELECT channel, SUM(nguoi_khong_chi) AS so_nguoi_cai_khong_chi, SUM(dong_khong_cai) AS so_dong_chi_khong_cai,
       ROUND(SUM(tien_khong_cai), 2) AS chi_khong_cai_usd
FROM lech GROUP BY channel ORDER BY channel;

-- [jelly-t5-doi-soat-kpi] solution
WITH tinh AS (
  SELECT activity_date, COUNT(*) AS dau, SUM(sessions) AS phien, SUM(playtime_minutes) AS thoi_gian,
         SUM(iap_revenue) AS iap, SUM(ad_revenue) AS qc_chi_tiet, SUM(crash_count) AS su_co
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
  GROUP BY activity_date
), moi AS (
  SELECT install_date, COUNT(*) AS nguoi_moi
  FROM users
  GROUP BY install_date
), so AS (
  SELECT k.`date`, t.iap, t.qc_chi_tiet,
         CASE WHEN k.ad_revenue <> t.qc_chi_tiet THEN 1 ELSE 0 END AS lech_qc_truc_tiep,
         CASE WHEN k.dau = t.dau AND k.sessions = t.phien AND k.playtime_minutes = t.thoi_gian
                   AND k.iap_revenue = t.iap AND k.ad_revenue = ROUND(t.qc_chi_tiet, 2) AND k.crash_count = t.su_co
                   AND k.new_users = COALESCE(m.nguoi_moi, 0)
              THEN 1 ELSE 0 END AS khop
  FROM daily_kpi k
  LEFT JOIN tinh t ON t.activity_date = k.`date`
  LEFT JOIN moi m ON m.install_date = k.`date`
  WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
)
SELECT COUNT(*) AS so_ngay, SUM(khop) AS so_ngay_khop,
       SUM(lech_qc_truc_tiep) AS so_ngay_qc_lech_neu_so_truc_tiep,
       ROUND(SUM(iap + qc_chi_tiet), 2) AS tong_doanh_thu_tinh_lai_usd
FROM so;

-- [jelly-t5-doi-soat-kpi] wrong: so_so_le_khong_lam_tron
-- So doanh thu quảng cáo 4 chữ số lẻ với số đã làm tròn 2 chữ số: gần như ngày nào cũng "lệch" (rớt ở public).
WITH tinh AS (
  SELECT activity_date, COUNT(*) AS dau, SUM(sessions) AS phien, SUM(playtime_minutes) AS thoi_gian,
         SUM(iap_revenue) AS iap, SUM(ad_revenue) AS qc_chi_tiet, SUM(crash_count) AS su_co
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
  GROUP BY activity_date
), moi AS (
  SELECT install_date, COUNT(*) AS nguoi_moi FROM users GROUP BY install_date
), so AS (
  SELECT k.`date`, t.iap, t.qc_chi_tiet,
         CASE WHEN k.ad_revenue <> t.qc_chi_tiet THEN 1 ELSE 0 END AS lech_qc_truc_tiep,
         CASE WHEN k.dau = t.dau AND k.sessions = t.phien AND k.playtime_minutes = t.thoi_gian
                   AND k.iap_revenue = t.iap AND k.ad_revenue = t.qc_chi_tiet AND k.crash_count = t.su_co
                   AND k.new_users = COALESCE(m.nguoi_moi, 0)
              THEN 1 ELSE 0 END AS khop
  FROM daily_kpi k
  LEFT JOIN tinh t ON t.activity_date = k.`date`
  LEFT JOIN moi m ON m.install_date = k.`date`
  WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
)
SELECT COUNT(*) AS so_ngay, SUM(khop) AS so_ngay_khop, SUM(lech_qc_truc_tiep) AS so_ngay_qc_lech_neu_so_truc_tiep,
       ROUND(SUM(iap + qc_chi_tiet), 2) AS tong_doanh_thu_tinh_lai_usd
FROM so;

-- [jelly-t5-doi-soat-kpi] wrong: khong_gioi_han_cua_so
-- Không giới hạn cửa sổ dữ liệu: ở hidden-1 có thêm ngày 2026-09-01 (rớt ở hidden-1).
WITH tinh AS (
  SELECT activity_date, COUNT(*) AS dau, SUM(sessions) AS phien, SUM(playtime_minutes) AS thoi_gian,
         SUM(iap_revenue) AS iap, SUM(ad_revenue) AS qc_chi_tiet, SUM(crash_count) AS su_co
  FROM player_daily GROUP BY activity_date
), moi AS (
  SELECT install_date, COUNT(*) AS nguoi_moi FROM users GROUP BY install_date
), so AS (
  SELECT k.`date`, t.iap, t.qc_chi_tiet,
         CASE WHEN k.ad_revenue <> t.qc_chi_tiet THEN 1 ELSE 0 END AS lech_qc_truc_tiep,
         CASE WHEN k.dau = t.dau AND k.sessions = t.phien AND k.playtime_minutes = t.thoi_gian
                   AND k.iap_revenue = t.iap AND k.ad_revenue = ROUND(t.qc_chi_tiet, 2) AND k.crash_count = t.su_co
                   AND k.new_users = COALESCE(m.nguoi_moi, 0)
              THEN 1 ELSE 0 END AS khop
  FROM daily_kpi k
  LEFT JOIN tinh t ON t.activity_date = k.`date`
  LEFT JOIN moi m ON m.install_date = k.`date`
)
SELECT COUNT(*) AS so_ngay, SUM(khop) AS so_ngay_khop, SUM(lech_qc_truc_tiep) AS so_ngay_qc_lech_neu_so_truc_tiep,
       ROUND(SUM(iap + qc_chi_tiet), 2) AS tong_doanh_thu_tinh_lai_usd
FROM so;

-- [jelly-t5-doi-soat-kpi] wrong: chi_so_dau
-- Chỉ so DAU, bỏ qua sáu chỉ số còn lại; cột lệch quảng cáo đếm sau khi làm tròn (rớt ở public).
WITH tinh AS (
  SELECT activity_date, COUNT(*) AS dau, SUM(iap_revenue) AS iap, SUM(ad_revenue) AS qc_chi_tiet
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
  GROUP BY activity_date
), so AS (
  SELECT k.`date`, t.iap, t.qc_chi_tiet,
         CASE WHEN k.ad_revenue <> ROUND(t.qc_chi_tiet, 2) THEN 1 ELSE 0 END AS lech_qc_truc_tiep,
         CASE WHEN k.dau = t.dau THEN 1 ELSE 0 END AS khop
  FROM daily_kpi k
  LEFT JOIN tinh t ON t.activity_date = k.`date`
  WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
)
SELECT COUNT(*) AS so_ngay, SUM(khop) AS so_ngay_khop, SUM(lech_qc_truc_tiep) AS so_ngay_qc_lech_neu_so_truc_tiep,
       ROUND(SUM(iap + qc_chi_tiet), 2) AS tong_doanh_thu_tinh_lai_usd
FROM so;

-- [jelly-t6-tong-su-co-hai-nguon] solution
WITH luot AS (
  SELECT COUNT(*) AS so_luot_su_co
  FROM level_attempts
  WHERE result = 'crash' AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
), ngay AS (
  SELECT SUM(crash_count) AS tong_crash_count
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01'
)
SELECT l.so_luot_su_co, n.tong_crash_count, l.so_luot_su_co - n.tong_crash_count AS chenh_lech
FROM luot l
CROSS JOIN ngay n;

-- [jelly-t6-tong-su-co-hai-nguon] wrong: noi_truc_tiep_nhan_dong
-- Nối thẳng lượt chơi với bảng hoạt động ngày theo người chơi và ngày: crash_count bị cộng lặp (rớt ở public).
SELECT COUNT(CASE WHEN a.result = 'crash' THEN 1 END) AS so_luot_su_co,
       SUM(p.crash_count) AS tong_crash_count,
       COUNT(CASE WHEN a.result = 'crash' THEN 1 END) - SUM(p.crash_count) AS chenh_lech
FROM player_daily p
LEFT JOIN level_attempts a ON a.user_id = p.user_id AND a.event_date = p.activity_date
WHERE p.activity_date >= '2026-07-01' AND p.activity_date < '2026-08-01';

-- [jelly-t6-tong-su-co-hai-nguon] wrong: dem_ngay_nguoi_co_su_co
-- Đếm số ngày-người có sự cố thay vì cộng crash_count (rớt ở public: có ngày-người ghi 3 sự cố).
WITH luot AS (
  SELECT COUNT(*) AS so_luot_su_co
  FROM level_attempts
  WHERE result = 'crash' AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
), ngay AS (
  SELECT COUNT(*) AS tong_crash_count
  FROM player_daily
  WHERE crash_count > 0 AND activity_date >= '2026-07-01' AND activity_date < '2026-08-01'
)
SELECT l.so_luot_su_co, n.tong_crash_count, l.so_luot_su_co - n.tong_crash_count AS chenh_lech
FROM luot l CROSS JOIN ngay n;

-- [jelly-t6-tong-su-co-hai-nguon] wrong: luot_thieu_can_tren
-- Nhánh lượt chơi lọc từ 1/7 trở đi, lẫn lượt tháng 8 (rớt ở public).
WITH luot AS (
  SELECT COUNT(*) AS so_luot_su_co
  FROM level_attempts
  WHERE result = 'crash' AND event_date >= '2026-07-01'
), ngay AS (
  SELECT SUM(crash_count) AS tong_crash_count
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-01'
)
SELECT l.so_luot_su_co, n.tong_crash_count, l.so_luot_su_co - n.tong_crash_count AS chenh_lech
FROM luot l CROSS JOIN ngay n;

-- [jelly-t7-union-doanh-thu] starter
WITH nguon AS (
  SELECT platform, 'iap' AS nguon, price_usd AS tien
  FROM purchases
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
  UNION
  SELECT platform, 'quang_cao', revenue_usd
  FROM ad_events
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
)
SELECT platform, nguon, ROUND(SUM(tien), 2) AS doanh_thu_usd
FROM nguon
GROUP BY platform, nguon
ORDER BY platform, nguon;

-- [jelly-t7-union-doanh-thu] solution
WITH nguon AS (
  SELECT platform, 'iap' AS nguon, price_usd AS tien
  FROM purchases
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
  UNION ALL
  SELECT platform, 'quang_cao', revenue_usd
  FROM ad_events
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
)
SELECT platform, nguon, ROUND(SUM(tien), 2) AS doanh_thu_usd
FROM nguon
GROUP BY platform, nguon
ORDER BY platform, nguon;

-- [jelly-t7-union-doanh-thu] wrong: nhanh_quang_cao_thieu_can_tren
-- Sửa thành UNION ALL nhưng nhánh quảng cáo thiếu cận trên (rớt ở public).
WITH nguon AS (
  SELECT platform, 'iap' AS nguon, price_usd AS tien
  FROM purchases
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
  UNION ALL
  SELECT platform, 'quang_cao', revenue_usd
  FROM ad_events
  WHERE event_date >= '2026-07-01'
)
SELECT platform, nguon, ROUND(SUM(tien), 2) AS doanh_thu_usd
FROM nguon GROUP BY platform, nguon ORDER BY platform, nguon;

-- [jelly-t8-cte-loc-sai-cho] starter
WITH nhom AS (
  SELECT app_version_install, COUNT(*) AS so_nguoi_cai
  FROM users
  GROUP BY app_version_install
), d7 AS (
  SELECT u.app_version_install, COUNT(*) AS so_giu_chan
  FROM users u
  JOIN player_daily p ON p.user_id = u.user_id AND p.cohort_day = 7
  WHERE u.install_date <= '2026-08-22'
  GROUP BY u.app_version_install
)
SELECT n.app_version_install, n.so_nguoi_cai, COALESCE(d.so_giu_chan, 0) AS so_giu_chan_d7,
       ROUND(100 * COALESCE(d.so_giu_chan, 0) / n.so_nguoi_cai, 2) AS ty_le_d7_pct
FROM nhom n
LEFT JOIN d7 d ON d.app_version_install = n.app_version_install
ORDER BY n.app_version_install;

-- [jelly-t8-cte-loc-sai-cho] solution
WITH nhom AS (
  SELECT app_version_install, COUNT(*) AS so_nguoi_cai
  FROM users
  WHERE install_date <= '2026-08-22'
  GROUP BY app_version_install
), d7 AS (
  SELECT u.app_version_install, COUNT(*) AS so_giu_chan
  FROM users u
  JOIN player_daily p ON p.user_id = u.user_id AND p.cohort_day = 7
  WHERE u.install_date <= '2026-08-22'
  GROUP BY u.app_version_install
)
SELECT n.app_version_install, n.so_nguoi_cai, COALESCE(d.so_giu_chan, 0) AS so_giu_chan_d7,
       ROUND(100 * COALESCE(d.so_giu_chan, 0) / n.so_nguoi_cai, 2) AS ty_le_d7_pct
FROM nhom n
LEFT JOIN d7 d ON d.app_version_install = n.app_version_install
ORDER BY n.app_version_install;

-- [jelly-t8-cte-loc-sai-cho] wrong: tu_so_theo_phien_ban_luc_choi
-- Tử số chia theo phiên bản lúc chơi ngày D7, khác tập với mẫu số (rớt ở public).
WITH nhom AS (
  SELECT app_version_install, COUNT(*) AS so_nguoi_cai
  FROM users WHERE install_date <= '2026-08-22'
  GROUP BY app_version_install
), d7 AS (
  SELECT p.app_version AS app_version_install, COUNT(*) AS so_giu_chan
  FROM users u
  JOIN player_daily p ON p.user_id = u.user_id AND p.cohort_day = 7
  WHERE u.install_date <= '2026-08-22'
  GROUP BY p.app_version
)
SELECT n.app_version_install, n.so_nguoi_cai, COALESCE(d.so_giu_chan, 0) AS so_giu_chan_d7,
       ROUND(100 * COALESCE(d.so_giu_chan, 0) / n.so_nguoi_cai, 2) AS ty_le_d7_pct
FROM nhom n LEFT JOIN d7 d ON d.app_version_install = n.app_version_install
ORDER BY n.app_version_install;

-- [jelly-t8-cte-loc-sai-cho] wrong: mau_so_bo_ngay_22_8
-- Thêm điều kiện ở mẫu số nhưng viết < '2026-08-22', bỏ mất người cài ngày 22/8 (rớt ở public).
WITH nhom AS (
  SELECT app_version_install, COUNT(*) AS so_nguoi_cai
  FROM users WHERE install_date < '2026-08-22'
  GROUP BY app_version_install
), d7 AS (
  SELECT u.app_version_install, COUNT(*) AS so_giu_chan
  FROM users u
  JOIN player_daily p ON p.user_id = u.user_id AND p.cohort_day = 7
  WHERE u.install_date <= '2026-08-22'
  GROUP BY u.app_version_install
)
SELECT n.app_version_install, n.so_nguoi_cai, COALESCE(d.so_giu_chan, 0) AS so_giu_chan_d7,
       ROUND(100 * COALESCE(d.so_giu_chan, 0) / n.so_nguoi_cai, 2) AS ty_le_d7_pct
FROM nhom n LEFT JOIN d7 d ON d.app_version_install = n.app_version_install
ORDER BY n.app_version_install;

-- [jelly-t9-ab-itt] starter
WITH chia AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing'
    AND assigned_at < '2026-08-23'
    AND exposure_status = 'exposed'
), ket_qua AS (
  SELECT c.variant, COUNT(*) AS so_nguoi_chia,
         SUM(EXISTS (SELECT 1 FROM purchases p
                     WHERE p.user_id = c.user_id AND p.product_type = 'extra_moves_pack'
                       AND p.event_date >= c.ngay_chia AND p.event_date < c.ngay_chia + INTERVAL 7 DAY)) AS so_nguoi_mua
  FROM chia c
  GROUP BY c.variant
), doi_chung AS (
  SELECT 100 * so_nguoi_mua / so_nguoi_chia AS ty_le FROM ket_qua WHERE variant = 'control_after_3_fails'
)
SELECT k.variant, k.so_nguoi_chia, k.so_nguoi_mua,
       ROUND(100 * k.so_nguoi_mua / k.so_nguoi_chia, 2) AS ty_le_mua_pct,
       ROUND(100 * k.so_nguoi_mua / k.so_nguoi_chia - d.ty_le, 2) AS chenh_lech_diem
FROM ket_qua k
CROSS JOIN doi_chung d
ORDER BY k.variant;

-- [jelly-t9-ab-itt] solution
WITH chia AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing'
    AND assigned_at < '2026-08-23'
), ket_qua AS (
  SELECT c.variant, COUNT(*) AS so_nguoi_chia,
         SUM(EXISTS (SELECT 1 FROM purchases p
                     WHERE p.user_id = c.user_id AND p.product_type = 'extra_moves_pack'
                       AND p.event_date >= c.ngay_chia AND p.event_date < c.ngay_chia + INTERVAL 7 DAY)) AS so_nguoi_mua
  FROM chia c
  GROUP BY c.variant
), doi_chung AS (
  SELECT 100 * so_nguoi_mua / so_nguoi_chia AS ty_le FROM ket_qua WHERE variant = 'control_after_3_fails'
)
SELECT k.variant, k.so_nguoi_chia, k.so_nguoi_mua,
       ROUND(100 * k.so_nguoi_mua / k.so_nguoi_chia, 2) AS ty_le_mua_pct,
       ROUND(100 * k.so_nguoi_mua / k.so_nguoi_chia - d.ty_le, 2) AS chenh_lech_diem
FROM ket_qua k
CROSS JOIN doi_chung d
ORDER BY k.variant;

-- [jelly-t9-ab-itt] wrong: khong_gioi_han_cua_so_d0_6
-- Đếm mọi lần mua trong cả kỳ, không giới hạn 7 ngày đầu kể từ ngày chia nhánh (rớt ở public).
WITH chia AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
), ket_qua AS (
  SELECT c.variant, COUNT(*) AS so_nguoi_chia,
         SUM(EXISTS (SELECT 1 FROM purchases p
                     WHERE p.user_id = c.user_id AND p.product_type = 'extra_moves_pack')) AS so_nguoi_mua
  FROM chia c GROUP BY c.variant
), doi_chung AS (
  SELECT 100 * so_nguoi_mua / so_nguoi_chia AS ty_le FROM ket_qua WHERE variant = 'control_after_3_fails'
)
SELECT k.variant, k.so_nguoi_chia, k.so_nguoi_mua,
       ROUND(100 * k.so_nguoi_mua / k.so_nguoi_chia, 2) AS ty_le_mua_pct,
       ROUND(100 * k.so_nguoi_mua / k.so_nguoi_chia - d.ty_le, 2) AS chenh_lech_diem
FROM ket_qua k CROSS JOIN doi_chung d
ORDER BY k.variant;

-- ===================================================================== MODULE 8 · WINDOW FUNCTIONS

-- [jelly-f1-top3-man-quit] solution
WITH bo_cuoc AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_bo_cuoc
  FROM level_attempts
  WHERE result = 'quit'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_bo_cuoc,
         ROW_NUMBER() OVER (PARTITION BY world_name ORDER BY so_luot_bo_cuoc DESC, level_id) AS hang
  FROM bo_cuoc
)
SELECT world_name, level_id, so_luot_bo_cuoc, hang
FROM xep
WHERE hang <= 3
ORDER BY world_name, hang;

-- [jelly-f1-top3-man-quit] wrong: rank_ra_thua_dong
-- RANK() cho hai màn bằng nhau cùng hạng 3, Licorice Lagoon ra 4 dòng (rớt ở hidden-1).
WITH bo_cuoc AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_bo_cuoc
  FROM level_attempts WHERE result = 'quit'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_bo_cuoc,
         RANK() OVER (PARTITION BY world_name ORDER BY so_luot_bo_cuoc DESC) AS hang
  FROM bo_cuoc
)
SELECT world_name, level_id, so_luot_bo_cuoc, hang FROM xep WHERE hang <= 3
ORDER BY world_name, hang, level_id;

-- [jelly-f1-top3-man-quit] wrong: thieu_partition_by
-- Xếp hạng trên cả game thay vì trong từng thế giới (rớt ở public).
WITH bo_cuoc AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_bo_cuoc
  FROM level_attempts WHERE result = 'quit'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_bo_cuoc,
         ROW_NUMBER() OVER (ORDER BY so_luot_bo_cuoc DESC, level_id) AS hang
  FROM bo_cuoc
)
SELECT world_name, level_id, so_luot_bo_cuoc, hang FROM xep WHERE hang <= 3
ORDER BY world_name, hang;

-- [jelly-f2-dau-trot-7-ngay] solution
SELECT `date` AS ngay, dau,
       CASE WHEN COUNT(*) OVER w = 7 THEN ROUND(AVG(dau) OVER w, 2) END AS dau_tb_7_ngay
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
WINDOW w AS (ORDER BY `date` ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
ORDER BY ngay;

-- [jelly-f2-dau-trot-7-ngay] wrong: sau_ngay_dau_khong_de_trong
-- Sáu ngày đầu lấy trung bình của ít hơn 7 ngày thay vì để trống (rớt ở public).
SELECT `date` AS ngay, dau,
       ROUND(AVG(dau) OVER (ORDER BY `date` ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS dau_tb_7_ngay
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
ORDER BY ngay;

-- [jelly-f2-dau-trot-7-ngay] wrong: khung_8_ngay
-- Khung 7 PRECEDING lấy 8 ngày (rớt ở public).
SELECT `date` AS ngay, dau,
       CASE WHEN COUNT(*) OVER w = 8 THEN ROUND(AVG(dau) OVER w, 2) END AS dau_tb_7_ngay
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
WINDOW w AS (ORDER BY `date` ROWS BETWEEN 7 PRECEDING AND CURRENT ROW)
ORDER BY ngay;

-- [jelly-f2-dau-trot-7-ngay] wrong: thieu_can_tren
-- Không giới hạn ngày cuối của cửa sổ dữ liệu: hidden-1 có thêm dòng 2026-09-01 (rớt ở hidden-1).
SELECT `date` AS ngay, dau,
       CASE WHEN COUNT(*) OVER w = 7 THEN ROUND(AVG(dau) OVER w, 2) END AS dau_tb_7_ngay
FROM daily_kpi
WHERE `date` >= '2026-07-01'
WINDOW w AS (ORDER BY `date` ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
ORDER BY ngay;

-- [jelly-f3-luy-ke-chi-mot-chien-dich] solution
SELECT `date` AS ngay, spend_usd AS chi_ngay_usd,
       SUM(spend_usd) OVER (ORDER BY `date`) AS chi_luy_ke_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-VIDEO-330' AND country = 'VN' AND target_platform = 'Android'
  AND `date` >= '2026-07-01' AND `date` < '2026-08-01'
ORDER BY ngay;

-- [jelly-f3-luy-ke-chi-mot-chien-dich] wrong: cua_so_thieu_order_by
-- OVER () không có ORDER BY nên dòng nào cũng ra tổng cả tháng (rớt ở public).
SELECT `date` AS ngay, spend_usd AS chi_ngay_usd,
       SUM(spend_usd) OVER () AS chi_luy_ke_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-VIDEO-330' AND country = 'VN' AND target_platform = 'Android'
  AND `date` >= '2026-07-01' AND `date` < '2026-08-01'
ORDER BY ngay;

-- [jelly-f3-luy-ke-chi-mot-chien-dich] wrong: quen_loc_nen_tang
-- Quên lọc nền tảng: lẫn các dòng nhắm tới iOS ở Việt Nam (rớt ở public).
SELECT `date` AS ngay, spend_usd AS chi_ngay_usd,
       SUM(spend_usd) OVER (ORDER BY `date`) AS chi_luy_ke_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-VIDEO-330' AND country = 'VN'
  AND `date` >= '2026-07-01' AND `date` < '2026-08-01'
ORDER BY ngay, target_platform;

-- [jelly-f3-luy-ke-chi-mot-chien-dich] wrong: cong_don_theo_tien
-- Sắp cửa sổ theo số tiền thay vì theo ngày (rớt ở public).
SELECT `date` AS ngay, spend_usd AS chi_ngay_usd,
       SUM(spend_usd) OVER (ORDER BY spend_usd) AS chi_luy_ke_usd
FROM campaign_spend
WHERE campaign_id = 'JTA-VIDEO-330' AND country = 'VN' AND target_platform = 'Android'
  AND `date` >= '2026-07-01' AND `date` < '2026-08-01'
ORDER BY ngay;

-- [jelly-f4-doanh-thu-tuan-wow] solution
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
         COUNT(*) AS so_ngay, SUM(iap_revenue + ad_revenue) AS doanh_thu
  FROM daily_kpi
  WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
  GROUP BY tuan_bat_dau
), du AS (
  SELECT tuan_bat_dau, doanh_thu FROM tuan WHERE so_ngay = 7
)
SELECT tuan_bat_dau, ROUND(doanh_thu, 2) AS doanh_thu_usd,
       ROUND(LAG(doanh_thu) OVER w, 2) AS doanh_thu_tuan_truoc_usd,
       ROUND(100 * (doanh_thu - LAG(doanh_thu) OVER w) / LAG(doanh_thu) OVER w, 2) AS thay_doi_pct
FROM du
WINDOW w AS (ORDER BY tuan_bat_dau)
ORDER BY tuan_bat_dau;

-- [jelly-f4-doanh-thu-tuan-wow] wrong: giu_tuan_khong_tron
-- Giữ cả tuần đầu và tuần cuối không đủ 7 ngày (rớt ở public).
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
         SUM(iap_revenue + ad_revenue) AS doanh_thu
  FROM daily_kpi
  WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
  GROUP BY tuan_bat_dau
)
SELECT tuan_bat_dau, ROUND(doanh_thu, 2) AS doanh_thu_usd,
       ROUND(LAG(doanh_thu) OVER w, 2) AS doanh_thu_tuan_truoc_usd,
       ROUND(100 * (doanh_thu - LAG(doanh_thu) OVER w) / LAG(doanh_thu) OVER w, 2) AS thay_doi_pct
FROM tuan
WINDOW w AS (ORDER BY tuan_bat_dau)
ORDER BY tuan_bat_dau;

-- [jelly-f4-doanh-thu-tuan-wow] wrong: lag_truoc_khi_loc_tuan
-- Tính LAG trước khi bỏ tuần không trọn: tuần trọn đầu tiên bị so với tuần 5 ngày (rớt ở public).
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
         COUNT(*) AS so_ngay, SUM(iap_revenue + ad_revenue) AS doanh_thu
  FROM daily_kpi
  WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
  GROUP BY tuan_bat_dau
), co_lag AS (
  SELECT tuan_bat_dau, so_ngay, doanh_thu, LAG(doanh_thu) OVER (ORDER BY tuan_bat_dau) AS truoc
  FROM tuan
)
SELECT tuan_bat_dau, ROUND(doanh_thu, 2) AS doanh_thu_usd, ROUND(truoc, 2) AS doanh_thu_tuan_truoc_usd,
       ROUND(100 * (doanh_thu - truoc) / truoc, 2) AS thay_doi_pct
FROM co_lag WHERE so_ngay = 7
ORDER BY tuan_bat_dau;

-- [jelly-f5-chuoi-ngay-lien-tiep] solution
WITH ngay AS (
  SELECT user_id, activity_date,
         DATE_SUB(activity_date, INTERVAL ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY activity_date) DAY) AS moc
  FROM player_daily
  WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
), chuoi AS (
  SELECT user_id, moc, COUNT(*) AS so_ngay, MIN(activity_date) AS ngay_bat_dau, MAX(activity_date) AS ngay_ket_thuc
  FROM ngay
  GROUP BY user_id, moc
), dai_nhat AS (
  SELECT user_id, so_ngay, ngay_bat_dau, ngay_ket_thuc,
         ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY so_ngay DESC, ngay_bat_dau) AS thu_tu
  FROM chuoi
)
SELECT user_id, so_ngay AS chuoi_dai_nhat, ngay_bat_dau, ngay_ket_thuc
FROM dai_nhat
WHERE thu_tu = 1
ORDER BY chuoi_dai_nhat DESC, user_id
LIMIT 10;

-- [jelly-f5-chuoi-ngay-lien-tiep] wrong: dem_tong_so_ngay
-- Đếm tổng số ngày có hoạt động, không xét liên tiếp (rớt ở public).
SELECT user_id, COUNT(*) AS chuoi_dai_nhat, MIN(activity_date) AS ngay_bat_dau, MAX(activity_date) AS ngay_ket_thuc
FROM player_daily
WHERE activity_date >= '2026-07-01' AND activity_date < '2026-08-30'
GROUP BY user_id
ORDER BY chuoi_dai_nhat DESC, user_id
LIMIT 10;

-- [jelly-f6-chia-4-nhom-ngay-dau] solution
SELECT `date` AS ngay, dau,
       NTILE(4) OVER (ORDER BY dau DESC, `date`) AS nhom
FROM daily_kpi
WHERE `date` >= '2026-08-01' AND `date` < '2026-08-30'
ORDER BY ngay;

-- [jelly-f6-chia-4-nhom-ngay-dau] wrong: xep_dau_tang_dan
-- Xếp DAU tăng dần nên nhóm 1 là nhóm vắng người chơi nhất (rớt ở public).
SELECT `date` AS ngay, dau,
       NTILE(4) OVER (ORDER BY dau, `date`) AS nhom
FROM daily_kpi
WHERE `date` >= '2026-08-01' AND `date` < '2026-08-30'
ORDER BY ngay;

-- [jelly-f6-chia-4-nhom-ngay-dau] wrong: chia_theo_ngay
-- Chia nhóm theo thứ tự ngày thay vì theo DAU (rớt ở public).
SELECT `date` AS ngay, dau,
       NTILE(4) OVER (ORDER BY `date`) AS nhom
FROM daily_kpi
WHERE `date` >= '2026-08-01' AND `date` < '2026-08-30'
ORDER BY ngay;

-- [jelly-f6-chia-4-nhom-ngay-dau] wrong: thieu_can_tren
-- Lọc từ 1/8 trở đi, không chặn ngày cuối: hidden-1 có thêm ngày 30/8, 1/9, 2/9 (rớt ở hidden-1).
SELECT `date` AS ngay, dau,
       NTILE(4) OVER (ORDER BY dau DESC, `date`) AS nhom
FROM daily_kpi
WHERE `date` >= '2026-08-01'
ORDER BY ngay;

-- [jelly-f7-rank-thay-row-number] starter
WITH su_co AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_su_co
  FROM level_attempts
  WHERE result = 'crash'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_su_co,
         RANK() OVER (PARTITION BY world_name ORDER BY so_luot_su_co DESC) AS hang
  FROM su_co
)
SELECT world_name, level_id, so_luot_su_co, hang
FROM xep
WHERE hang <= 3
ORDER BY world_name, hang, level_id;

-- [jelly-f7-rank-thay-row-number] solution
WITH su_co AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_su_co
  FROM level_attempts
  WHERE result = 'crash'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_su_co,
         ROW_NUMBER() OVER (PARTITION BY world_name ORDER BY so_luot_su_co DESC, level_id) AS hang
  FROM su_co
)
SELECT world_name, level_id, so_luot_su_co, hang
FROM xep
WHERE hang <= 3
ORDER BY world_name, hang;

-- [jelly-f7-rank-thay-row-number] wrong: dense_rank_van_thua
-- DENSE_RANK() vẫn để các màn bằng nhau chung hạng (rớt ở public).
WITH su_co AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_su_co
  FROM level_attempts WHERE result = 'crash'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_su_co,
         DENSE_RANK() OVER (PARTITION BY world_name ORDER BY so_luot_su_co DESC) AS hang
  FROM su_co
)
SELECT world_name, level_id, so_luot_su_co, hang FROM xep WHERE hang <= 3
ORDER BY world_name, hang, level_id;

-- [jelly-f7-rank-thay-row-number] wrong: tieu_chi_phu_nguoc
-- ROW_NUMBER() nhưng màn bằng nhau xếp level_id lớn trước (rớt ở public).
WITH su_co AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot_su_co
  FROM level_attempts WHERE result = 'crash'
  GROUP BY world_name, level_id
), xep AS (
  SELECT world_name, level_id, so_luot_su_co,
         ROW_NUMBER() OVER (PARTITION BY world_name ORDER BY so_luot_su_co DESC, level_id DESC) AS hang
  FROM su_co
)
SELECT world_name, level_id, so_luot_su_co, hang FROM xep WHERE hang <= 3
ORDER BY world_name, hang;

-- [jelly-f8-lag-khong-partition] starter
WITH ngay AS (
  SELECT user_id, activity_date,
         DATEDIFF(activity_date, LAG(activity_date) OVER (ORDER BY user_id, activity_date)) AS khoang_cach
  FROM player_daily
  WHERE install_date = '2026-07-03' AND activity_date < '2026-08-30'
)
SELECT khoang_cach AS khoang_cach_ngay, COUNT(*) AS so_lan
FROM ngay
WHERE khoang_cach IS NOT NULL
GROUP BY khoang_cach
ORDER BY khoang_cach;

-- [jelly-f8-lag-khong-partition] solution
WITH ngay AS (
  SELECT user_id, activity_date,
         DATEDIFF(activity_date, LAG(activity_date) OVER (PARTITION BY user_id ORDER BY activity_date)) AS khoang_cach
  FROM player_daily
  WHERE install_date = '2026-07-03' AND activity_date < '2026-08-30'
)
SELECT khoang_cach AS khoang_cach_ngay, COUNT(*) AS so_lan
FROM ngay
WHERE khoang_cach IS NOT NULL
GROUP BY khoang_cach
ORDER BY khoang_cach;

-- [jelly-f8-lag-khong-partition] wrong: bo_can_tren_cua_so
-- Sửa PARTITION BY nhưng bỏ giới hạn ngày cuối: hidden-1 có thêm ngày 2026-09-01 của một người cài 3/7 (rớt ở hidden-1).
WITH ngay AS (
  SELECT user_id, activity_date,
         DATEDIFF(activity_date, LAG(activity_date) OVER (PARTITION BY user_id ORDER BY activity_date)) AS khoang_cach
  FROM player_daily
  WHERE install_date = '2026-07-03'
)
SELECT khoang_cach AS khoang_cach_ngay, COUNT(*) AS so_lan
FROM ngay WHERE khoang_cach IS NOT NULL
GROUP BY khoang_cach ORDER BY khoang_cach;

-- [jelly-f8-lag-khong-partition] wrong: dem_ca_ngay_dau
-- Đếm cả ngày đầu của mỗi người (khoảng cách rỗng) thành một nhóm (rớt ở public).
WITH ngay AS (
  SELECT user_id, activity_date,
         DATEDIFF(activity_date, LAG(activity_date) OVER (PARTITION BY user_id ORDER BY activity_date)) AS khoang_cach
  FROM player_daily
  WHERE install_date = '2026-07-03' AND activity_date < '2026-08-30'
)
SELECT khoang_cach AS khoang_cach_ngay, COUNT(*) AS so_lan
FROM ngay GROUP BY khoang_cach ORDER BY khoang_cach;

-- [jelly-f9-ty-trong-goi] starter
SELECT product_name, ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(100 * SUM(price_usd) / SUM(SUM(price_usd)) OVER (PARTITION BY product_name), 2) AS ty_trong_pct
FROM purchases
WHERE event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-f9-ty-trong-goi] solution
SELECT product_name, ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(100 * SUM(price_usd) / SUM(SUM(price_usd)) OVER (), 2) AS ty_trong_pct
FROM purchases
WHERE event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-f9-ty-trong-goi] wrong: thieu_can_tren
-- Sửa OVER () nhưng lọc tháng 8 thiếu cận trên: hidden-1 lẫn giao dịch ngày 2026-09-01 (rớt ở hidden-1).
SELECT product_name, ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(100 * SUM(price_usd) / SUM(SUM(price_usd)) OVER (), 2) AS ty_trong_pct
FROM purchases
WHERE event_date >= '2026-08-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- [jelly-f9-ty-trong-goi] wrong: ty_trong_theo_so_giao_dich
-- Tỷ trọng tính theo số giao dịch thay vì doanh thu (rớt ở public).
SELECT product_name, ROUND(SUM(price_usd), 2) AS doanh_thu_usd,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS ty_trong_pct
FROM purchases
WHERE event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY product_name
ORDER BY doanh_thu_usd DESC, product_name;

-- ===================================================================== CASE

-- [jelly-c7-android-210.b1] solution
SELECT app_version, platform, COUNT(*) AS so_bat_dau,
       ROUND(100 * AVG(step_completed), 2) AS ty_le_hoan_thanh_pct
FROM tutorial_steps
WHERE step_id = 4
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c7-android-210.b1] wrong: mau_so_la_buoc_1
-- Chia số người hoàn thành bước 4 cho số người bắt đầu bước 1 (phần còn lại tích luỹ), không phải tỷ lệ của bước 4 (rớt ở public).
SELECT app_version, platform,
       SUM(step_id = 4) AS so_bat_dau,
       ROUND(100 * SUM(step_id = 4 AND step_completed = 1) / SUM(step_id = 1), 2) AS ty_le_hoan_thanh_pct
FROM tutorial_steps
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c7-android-210.b2] solution
SELECT app_version, platform, COUNT(*) AS so_luot,
       ROUND(100 * AVG(result = 'complete'), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c7-android-210.b2] wrong: mau_so_bo_luot_su_co
-- Mẫu số chỉ gồm lượt thắng và thua, bỏ lượt bỏ cuộc và sự cố (rớt ở public).
SELECT app_version, platform, COUNT(*) AS so_luot,
       ROUND(100 * AVG(result = 'complete'), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30 AND result IN ('complete', 'fail_out_of_moves')
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c7-android-210.b3] solution
WITH nhom AS (
  SELECT user_id, app_version_install, platform
  FROM users
  WHERE install_date <= '2026-08-22'
)
SELECT n.app_version_install, n.platform, COUNT(*) AS so_nguoi_cai,
       ROUND(100 * COUNT(p.user_id) / COUNT(*), 2) AS ty_le_d1_pct
FROM nhom n
LEFT JOIN player_daily p ON p.user_id = n.user_id AND p.cohort_day = 1
GROUP BY n.app_version_install, n.platform
ORDER BY n.app_version_install, n.platform;

-- [jelly-c7-android-210.b3] wrong: mau_so_tu_bang_hoat_dong
-- Mẫu số đếm trên bảng hoạt động ngày D1, nên tỷ lệ luôn 100% (rớt ở public).
SELECT u.app_version_install, u.platform, COUNT(*) AS so_nguoi_cai,
       ROUND(100 * COUNT(p.user_id) / COUNT(*), 2) AS ty_le_d1_pct
FROM users u
JOIN player_daily p ON p.user_id = u.user_id AND p.cohort_day = 1
WHERE u.install_date <= '2026-08-22'
GROUP BY u.app_version_install, u.platform
ORDER BY u.app_version_install, u.platform;

-- [jelly-c8-doanh-thu-giam-vi-dau.b1] solution
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
         COUNT(*) AS so_ngay, SUM(iap_revenue) AS iap, SUM(ad_revenue) AS qc
  FROM daily_kpi
  WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
  GROUP BY tuan_bat_dau
)
SELECT tuan_bat_dau, ROUND(iap, 2) AS doanh_thu_iap_usd, ROUND(qc, 2) AS doanh_thu_qc_usd,
       ROUND(iap + qc, 2) AS doanh_thu_usd
FROM tuan
WHERE tuan_bat_dau IN ('2026-08-03', '2026-08-10')
ORDER BY tuan_bat_dau;

-- [jelly-c8-doanh-thu-giam-vi-dau.b1] wrong: tuan_bat_dau_chu_nhat
-- Tuần tính từ Chủ nhật (DAYOFWEEK) thay vì thứ Hai (rớt ở public).
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL DAYOFWEEK(`date`) - 1 DAY) AS tuan_bat_dau,
         SUM(iap_revenue) AS iap, SUM(ad_revenue) AS qc
  FROM daily_kpi
  WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
  GROUP BY tuan_bat_dau
)
SELECT tuan_bat_dau, ROUND(iap, 2) AS doanh_thu_iap_usd, ROUND(qc, 2) AS doanh_thu_qc_usd,
       ROUND(iap + qc, 2) AS doanh_thu_usd
FROM tuan
WHERE tuan_bat_dau IN ('2026-08-02', '2026-08-09')
ORDER BY tuan_bat_dau;

-- [jelly-c8-doanh-thu-giam-vi-dau.b2] solution
SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
       ROUND(AVG(dau), 1) AS dau_binh_quan,
       ROUND(100 * SUM(iap_revenue + ad_revenue) / SUM(dau), 2) AS arpdau_cent,
       ROUND(100 * SUM(iap_revenue) / SUM(dau), 2) AS arpdau_iap_cent,
       ROUND(100 * SUM(ad_revenue) / SUM(dau), 2) AS arpdau_qc_cent
FROM daily_kpi
WHERE `date` >= '2026-08-03' AND `date` < '2026-08-17'
GROUP BY tuan_bat_dau
ORDER BY tuan_bat_dau;

-- [jelly-c8-doanh-thu-giam-vi-dau.b2] wrong: trung_binh_cot_arpdau
-- ARPDAU tuần lấy trung bình cột arpdau theo ngày (rớt ở public).
SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
       ROUND(AVG(dau), 1) AS dau_binh_quan,
       ROUND(100 * AVG(arpdau), 2) AS arpdau_cent,
       ROUND(100 * AVG(iap_revenue / dau), 2) AS arpdau_iap_cent,
       ROUND(100 * AVG(ad_revenue / dau), 2) AS arpdau_qc_cent
FROM daily_kpi
WHERE `date` >= '2026-08-03' AND `date` < '2026-08-17'
GROUP BY tuan_bat_dau
ORDER BY tuan_bat_dau;

-- [jelly-c8-doanh-thu-giam-vi-dau.b3] solution
WITH ngay AS (
  SELECT DATE_SUB(activity_date, INTERVAL WEEKDAY(activity_date) DAY) AS tuan_bat_dau,
         COUNT(*) AS nguoi_ngay,
         SUM(iap_revenue > 0) AS nguoi_ngay_tra_tien,
         SUM(iap_revenue) AS iap
  FROM player_daily
  WHERE activity_date >= '2026-08-03' AND activity_date < '2026-08-17'
  GROUP BY tuan_bat_dau
)
SELECT tuan_bat_dau,
       ROUND(100 * nguoi_ngay_tra_tien / nguoi_ngay, 2) AS ty_le_tra_tien_pct,
       ROUND(iap / nguoi_ngay_tra_tien, 2) AS iap_moi_ngay_nguoi_tra_tien_usd
FROM ngay
ORDER BY tuan_bat_dau;

-- [jelly-c8-doanh-thu-giam-vi-dau.b3] wrong: dem_nguoi_khac_nhau
-- Đếm người khác nhau trong tuần làm mẫu số thay vì ngày-người (rớt ở public).
WITH ngay AS (
  SELECT DATE_SUB(activity_date, INTERVAL WEEKDAY(activity_date) DAY) AS tuan_bat_dau,
         COUNT(DISTINCT user_id) AS nguoi_ngay,
         SUM(iap_revenue > 0) AS nguoi_ngay_tra_tien,
         SUM(iap_revenue) AS iap
  FROM player_daily
  WHERE activity_date >= '2026-08-03' AND activity_date < '2026-08-17'
  GROUP BY tuan_bat_dau
)
SELECT tuan_bat_dau,
       ROUND(100 * nguoi_ngay_tra_tien / nguoi_ngay, 2) AS ty_le_tra_tien_pct,
       ROUND(iap / nguoi_ngay_tra_tien, 2) AS iap_moi_ngay_nguoi_tra_tien_usd
FROM ngay ORDER BY tuan_bat_dau;

-- [jelly-c8-doanh-thu-giam-vi-dau.b4] solution
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
         SUM(dau) AS dau_tuan, SUM(iap_revenue + ad_revenue) AS doanh_thu
  FROM daily_kpi
  WHERE `date` >= '2026-08-03' AND `date` < '2026-08-17'
  GROUP BY tuan_bat_dau
), hai_tuan AS (
  SELECT tuan_bat_dau, dau_tuan, doanh_thu, doanh_thu / dau_tuan AS arpdau,
         LAG(dau_tuan) OVER (ORDER BY tuan_bat_dau) AS dau_truoc,
         LAG(doanh_thu / dau_tuan) OVER (ORDER BY tuan_bat_dau) AS arpdau_truoc,
         LAG(doanh_thu) OVER (ORDER BY tuan_bat_dau) AS doanh_thu_truoc
  FROM tuan
)
SELECT ROUND(doanh_thu - doanh_thu_truoc, 2) AS chenh_lech_usd,
       ROUND((dau_tuan - dau_truoc) * arpdau_truoc, 2) AS phan_do_dau_usd,
       ROUND(dau_tuan * (arpdau - arpdau_truoc), 2) AS phan_do_arpdau_usd
FROM hai_tuan
WHERE dau_truoc IS NOT NULL;

-- [jelly-c8-doanh-thu-giam-vi-dau.b4] wrong: doi_goc_tach
-- Đổi gốc tách: phần do DAU nhân ARPDAU tuần sau, phần do ARPDAU nhân DAU tuần trước, khác công thức đề nêu (rớt ở public).
WITH tuan AS (
  SELECT DATE_SUB(`date`, INTERVAL WEEKDAY(`date`) DAY) AS tuan_bat_dau,
         SUM(dau) AS dau_tuan, SUM(iap_revenue + ad_revenue) AS doanh_thu
  FROM daily_kpi
  WHERE `date` >= '2026-08-03' AND `date` < '2026-08-17'
  GROUP BY tuan_bat_dau
), hai_tuan AS (
  SELECT tuan_bat_dau, dau_tuan, doanh_thu, doanh_thu / dau_tuan AS arpdau,
         LAG(dau_tuan) OVER (ORDER BY tuan_bat_dau) AS dau_truoc,
         LAG(doanh_thu / dau_tuan) OVER (ORDER BY tuan_bat_dau) AS arpdau_truoc,
         LAG(doanh_thu) OVER (ORDER BY tuan_bat_dau) AS doanh_thu_truoc
  FROM tuan
)
SELECT ROUND(doanh_thu - doanh_thu_truoc, 2) AS chenh_lech_usd,
       ROUND((dau_tuan - dau_truoc) * arpdau, 2) AS phan_do_dau_usd,
       ROUND(dau_truoc * (arpdau - arpdau_truoc), 2) AS phan_do_arpdau_usd
FROM hai_tuan WHERE dau_truoc IS NOT NULL;
