-- solution.sql: GÓI 5 bộ GAME Jelly Trail Academy (jelly). Module 9 Data Quality, Module 10 Query Performance,
-- case jelly-c9, jelly-c10 (Khó, 5 bước). MySQL 8.0; mỗi khối một truy vấn SELECT/WITH.

-- ################################################################ MODULE 9 · DATA QUALITY

-- [jelly-k1-phien-ghi-hai-lan] solution
SELECT user_id, session_start, COUNT(*) AS so_dong
FROM sessions
GROUP BY user_id, session_start
HAVING COUNT(*) > 1
ORDER BY user_id, session_start;

-- [jelly-k1-phien-ghi-hai-lan] wrong: khoa_ky_thuat_ma_phien
-- Gom theo session_id (khoá kỹ thuật, không bao giờ trùng): ra 0 dòng.
SELECT user_id, session_start, COUNT(*) AS so_dong
FROM sessions
GROUP BY session_id, user_id, session_start
HAVING COUNT(*) > 1
ORDER BY user_id, session_start;

-- [jelly-k1-phien-ghi-hai-lan] wrong: gom_theo_ngay
-- Gom theo người chơi và ngày: lẫn mọi người chơi mở game nhiều lần trong ngày.
SELECT user_id, MIN(session_start) AS session_start, COUNT(*) AS so_dong
FROM sessions
GROUP BY user_id, event_date
HAVING COUNT(*) > 1
ORDER BY user_id, session_start;

-- [jelly-k2-mo-coi] solution
SELECT p.product_type,
       COUNT(*) AS so_giao_dich_gan_man,
       COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) AS so_thieu_luot_choi,
       ROUND(100 * COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM purchases p
LEFT JOIN (SELECT DISTINCT session_id, level_id FROM level_attempts) a
  ON a.session_id = p.session_id AND a.level_id = p.level_id_if_relevant
WHERE p.level_id_if_relevant IS NOT NULL
GROUP BY p.product_type
ORDER BY p.product_type;

-- [jelly-k2-mo-coi] wrong: noi_thang_nhan_dong
SELECT p.product_type,
       COUNT(*) AS so_giao_dich_gan_man,
       COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) AS so_thieu_luot_choi,
       ROUND(100 * COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM purchases p
LEFT JOIN level_attempts a
  ON a.session_id = p.session_id AND a.level_id = p.level_id_if_relevant
WHERE p.level_id_if_relevant IS NOT NULL
GROUP BY p.product_type
ORDER BY p.product_type;

-- [jelly-k2-mo-coi] wrong: noi_thieu_cot_man
SELECT p.product_type,
       COUNT(*) AS so_giao_dich_gan_man,
       COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) AS so_thieu_luot_choi,
       ROUND(100 * COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM purchases p
LEFT JOIN (SELECT DISTINCT session_id FROM level_attempts) a
  ON a.session_id = p.session_id
WHERE p.level_id_if_relevant IS NOT NULL
GROUP BY p.product_type
ORDER BY p.product_type;

-- [jelly-k2-mo-coi] wrong: inner_join_mat_dong_thieu
SELECT p.product_type,
       COUNT(*) AS so_giao_dich_gan_man,
       COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) AS so_thieu_luot_choi,
       ROUND(100 * COUNT(CASE WHEN a.session_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM purchases p
JOIN (SELECT DISTINCT session_id, level_id FROM level_attempts) a
  ON a.session_id = p.session_id AND a.level_id = p.level_id_if_relevant
WHERE p.level_id_if_relevant IS NOT NULL
GROUP BY p.product_type
ORDER BY p.product_type;

-- [jelly-k3-cohort-day-kiem] solution
SELECT COUNT(*) AS so_dong_kiem,
       COUNT(CASE WHEN pd.install_date <> u.install_date THEN 1 END) AS so_lech_ngay_cai,
       COUNT(CASE WHEN pd.cohort_day <> DATEDIFF(pd.activity_date, u.install_date) THEN 1 END) AS so_lech_cohort_day
FROM player_daily pd
JOIN users u ON u.user_id = pd.user_id;

-- [jelly-k3-cohort-day-kiem] wrong: datediff_dao_doi_so
SELECT COUNT(*) AS so_dong_kiem,
       COUNT(CASE WHEN pd.install_date <> u.install_date THEN 1 END) AS so_lech_ngay_cai,
       COUNT(CASE WHEN pd.cohort_day <> DATEDIFF(u.install_date, pd.activity_date) THEN 1 END) AS so_lech_cohort_day
FROM player_daily pd
JOIN users u ON u.user_id = pd.user_id;

-- [jelly-k3-cohort-day-kiem] wrong: so_trong_mot_bang
-- Không nối users, so hai cột của chính player_daily: ra 0 ở hidden-1 (đáp án 1).
SELECT COUNT(*) AS so_dong_kiem,
       COUNT(CASE WHEN pd.install_date <> pd.install_date THEN 1 END) AS so_lech_ngay_cai,
       COUNT(CASE WHEN pd.cohort_day <> DATEDIFF(pd.activity_date, pd.install_date) THEN 1 END) AS so_lech_cohort_day
FROM player_daily pd;

-- [jelly-k4-max-level-giam] solution
WITH ngay AS (
  SELECT user_id, activity_date, max_level,
         LAG(max_level) OVER (PARTITION BY user_id ORDER BY activity_date) AS max_level_truoc
  FROM player_daily
)
SELECT COUNT(*) AS so_ngay_nguoi_giam,
       COUNT(DISTINCT user_id) AS so_nguoi_choi,
       ROUND(AVG(max_level_truoc - max_level), 2) AS muc_giam_binh_quan
FROM ngay
WHERE max_level < max_level_truoc;

-- [jelly-k4-max-level-giam] wrong: coi_max_level_la_luy_ke
WITH ngay AS (
  SELECT user_id, activity_date, max_level,
         MAX(max_level) OVER (PARTITION BY user_id ORDER BY activity_date
                              ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS max_level_truoc
  FROM player_daily
)
SELECT COUNT(*) AS so_ngay_nguoi_giam,
       COUNT(DISTINCT user_id) AS so_nguoi_choi,
       ROUND(AVG(max_level_truoc - max_level), 2) AS muc_giam_binh_quan
FROM ngay
WHERE max_level < max_level_truoc;

-- [jelly-k4-max-level-giam] wrong: lag_thieu_partition
WITH ngay AS (
  SELECT user_id, activity_date, max_level,
         LAG(max_level) OVER (ORDER BY user_id, activity_date) AS max_level_truoc
  FROM player_daily
)
SELECT COUNT(*) AS so_ngay_nguoi_giam,
       COUNT(DISTINCT user_id) AS so_nguoi_choi,
       ROUND(AVG(max_level_truoc - max_level), 2) AS muc_giam_binh_quan
FROM ngay
WHERE max_level < max_level_truoc;

-- [jelly-k5-extra-moves-doi-soat] solution
WITH luot AS (
  SELECT event_date AS ngay, SUM(extra_moves_purchased) AS so_luot_nhan_them
  FROM level_attempts
  WHERE event_date >= '2026-08-01' AND event_date < '2026-09-01'
  GROUP BY event_date
),
bang_ngay AS (
  SELECT activity_date AS ngay, SUM(extra_moves_purchased) AS so_luot_bang_ngay
  FROM player_daily
  WHERE activity_date >= '2026-08-01' AND activity_date < '2026-09-01'
  GROUP BY activity_date
),
giao_dich AS (
  SELECT event_date AS ngay, COUNT(*) AS so_giao_dich_goi
  FROM purchases
  WHERE product_type = 'extra_moves_pack'
    AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
  GROUP BY event_date
)
SELECT l.ngay, l.so_luot_nhan_them,
       COALESCE(b.so_luot_bang_ngay, 0) AS so_luot_bang_ngay,
       COALESCE(g.so_giao_dich_goi, 0) AS so_giao_dich_goi
FROM luot l
LEFT JOIN bang_ngay b ON b.ngay = l.ngay
LEFT JOIN giao_dich g ON g.ngay = l.ngay
ORDER BY l.ngay;

-- [jelly-k5-extra-moves-doi-soat] wrong: quen_can_tren
WITH luot AS (
  SELECT event_date AS ngay, SUM(extra_moves_purchased) AS so_luot_nhan_them
  FROM level_attempts
  WHERE event_date >= '2026-08-01'
  GROUP BY event_date
),
bang_ngay AS (
  SELECT activity_date AS ngay, SUM(extra_moves_purchased) AS so_luot_bang_ngay
  FROM player_daily
  WHERE activity_date >= '2026-08-01'
  GROUP BY activity_date
),
giao_dich AS (
  SELECT event_date AS ngay, COUNT(*) AS so_giao_dich_goi
  FROM purchases
  WHERE product_type = 'extra_moves_pack' AND event_date >= '2026-08-01'
  GROUP BY event_date
)
SELECT l.ngay, l.so_luot_nhan_them,
       COALESCE(b.so_luot_bang_ngay, 0) AS so_luot_bang_ngay,
       COALESCE(g.so_giao_dich_goi, 0) AS so_giao_dich_goi
FROM luot l
LEFT JOIN bang_ngay b ON b.ngay = l.ngay
LEFT JOIN giao_dich g ON g.ngay = l.ngay
ORDER BY l.ngay;

-- [jelly-k5-extra-moves-doi-soat] wrong: noi_truc_tiep_nhan_dong
SELECT a.event_date AS ngay,
       SUM(a.extra_moves_purchased) AS so_luot_nhan_them,
       SUM(pd.extra_moves_purchased) AS so_luot_bang_ngay,
       COUNT(DISTINCT p.transaction_id) AS so_giao_dich_goi
FROM level_attempts a
JOIN player_daily pd ON pd.activity_date = a.event_date AND pd.user_id = a.user_id
LEFT JOIN purchases p ON p.event_date = a.event_date AND p.user_id = a.user_id
                     AND p.product_type = 'extra_moves_pack'
WHERE a.event_date >= '2026-08-01' AND a.event_date < '2026-09-01'
GROUP BY a.event_date
ORDER BY a.event_date;

-- [jelly-k6-quang-cao-bang-ngay] solution
SELECT k.`date` AS ngay,
       k.ad_revenue AS dt_bang_ngay_usd,
       ROUND(SUM(a.revenue_usd), 2) AS dt_tinh_lai_usd
FROM daily_kpi k
JOIN ad_events a ON a.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
GROUP BY k.`date`, k.ad_revenue
HAVING k.ad_revenue <> ROUND(SUM(a.revenue_usd), 2)
ORDER BY k.`date`;

-- [jelly-k6-quang-cao-bang-ngay] wrong: so_voi_tong_chua_lam_tron
SELECT k.`date` AS ngay,
       k.ad_revenue AS dt_bang_ngay_usd,
       ROUND(SUM(a.revenue_usd), 2) AS dt_tinh_lai_usd
FROM daily_kpi k
JOIN ad_events a ON a.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
GROUP BY k.`date`, k.ad_revenue
HAVING k.ad_revenue <> SUM(a.revenue_usd)
ORDER BY k.`date`;

-- [jelly-k6-quang-cao-bang-ngay] wrong: lam_tron_tung_lan_xem
SELECT k.`date` AS ngay,
       k.ad_revenue AS dt_bang_ngay_usd,
       SUM(ROUND(a.revenue_usd, 2)) AS dt_tinh_lai_usd
FROM daily_kpi k
JOIN ad_events a ON a.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
GROUP BY k.`date`, k.ad_revenue
HAVING k.ad_revenue <> SUM(ROUND(a.revenue_usd, 2))
ORDER BY k.`date`;

-- [jelly-k6-quang-cao-bang-ngay] wrong: cong_bang_ngay_sau_khi_noi
SELECT k.`date` AS ngay,
       SUM(k.ad_revenue) AS dt_bang_ngay_usd,
       ROUND(SUM(a.revenue_usd), 2) AS dt_tinh_lai_usd
FROM daily_kpi k
JOIN ad_events a ON a.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-08-30'
GROUP BY k.`date`
HAVING SUM(k.ad_revenue) <> ROUND(SUM(a.revenue_usd), 2)
ORDER BY k.`date`;

-- [jelly-k7-dau-doi-soat-phien] starter
SELECT k.`date` AS ngay,
       k.dau AS dau_bang_ngay,
       COUNT(s.user_id) AS dau_tinh_lai,
       k.dau - COUNT(s.user_id) AS chenh_lech
FROM daily_kpi k
JOIN sessions s ON s.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-07-08'
GROUP BY k.`date`, k.dau
ORDER BY k.`date`;

-- [jelly-k7-dau-doi-soat-phien] solution
SELECT k.`date` AS ngay,
       k.dau AS dau_bang_ngay,
       COUNT(DISTINCT s.user_id) AS dau_tinh_lai,
       k.dau - COUNT(DISTINCT s.user_id) AS chenh_lech
FROM daily_kpi k
JOIN sessions s ON s.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-07-08'
GROUP BY k.`date`, k.dau
ORDER BY k.`date`;

-- [jelly-k7-dau-doi-soat-phien] wrong: chi_sua_cot_dau_tinh_lai
SELECT k.`date` AS ngay,
       k.dau AS dau_bang_ngay,
       COUNT(DISTINCT s.user_id) AS dau_tinh_lai,
       k.dau - COUNT(s.user_id) AS chenh_lech
FROM daily_kpi k
JOIN sessions s ON s.event_date = k.`date`
WHERE k.`date` >= '2026-07-01' AND k.`date` < '2026-07-08'
GROUP BY k.`date`, k.dau
ORDER BY k.`date`;

-- [jelly-k7-dau-doi-soat-phien] wrong: bo_can_tren_cua_tuan
SELECT k.`date` AS ngay,
       k.dau AS dau_bang_ngay,
       COUNT(DISTINCT s.user_id) AS dau_tinh_lai,
       k.dau - COUNT(DISTINCT s.user_id) AS chenh_lech
FROM daily_kpi k
JOIN sessions s ON s.event_date = k.`date`
WHERE k.`date` >= '2026-07-01'
GROUP BY k.`date`, k.dau
ORDER BY k.`date`;

-- [jelly-k8-thuan-ra-0] starter
SELECT COUNT(*) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_gop_usd,
       SUM(CASE WHEN is_refund = 1 THEN price_usd ELSE 0 END) AS doanh_thu_thuan_usd
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-k8-thuan-ra-0] solution
SELECT COUNT(*) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_gop_usd,
       SUM(CASE WHEN is_refund = 0 THEN price_usd ELSE 0 END) AS doanh_thu_thuan_usd
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-k8-thuan-ra-0] wrong: dao_co_kieu_khac
SELECT COUNT(*) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_gop_usd,
       SUM(CASE WHEN is_refund = 0 THEN 0 ELSE price_usd END) AS doanh_thu_thuan_usd
FROM purchases
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-k8-thuan-ra-0] wrong: bo_can_tren_thang
SELECT COUNT(*) AS so_giao_dich,
       SUM(price_usd) AS doanh_thu_gop_usd,
       SUM(CASE WHEN is_refund = 0 THEN price_usd ELSE 0 END) AS doanh_thu_thuan_usd
FROM purchases
WHERE event_date >= '2026-07-01';

-- [jelly-k9-phien-hai-dang-ma] starter
WITH phien_dau AS (
  SELECT user_id, MIN(session_id) AS session_id
  FROM sessions
  GROUP BY user_id
)
SELECT u.platform,
       COUNT(*) AS so_nguoi_cai,
       COUNT(CASE WHEN s.entry_screen = 'tutorial' THEN 1 END) AS so_nguoi_vao_huong_dan,
       ROUND(100 * COUNT(CASE WHEN s.entry_screen = 'tutorial' THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM users u
JOIN phien_dau d ON d.user_id = u.user_id
JOIN sessions s ON s.session_id = d.session_id
WHERE u.install_date >= '2026-07-01'
GROUP BY u.platform
ORDER BY u.platform;

-- [jelly-k9-phien-hai-dang-ma] solution
WITH phien_dau AS (
  SELECT user_id, MIN(session_start) AS bat_dau
  FROM sessions
  GROUP BY user_id
),
nguoi AS (
  SELECT u.user_id, u.platform,
         CASE WHEN EXISTS (SELECT 1 FROM sessions s
                           WHERE s.user_id = u.user_id
                             AND s.session_start = d.bat_dau
                             AND s.entry_screen = 'tutorial') THEN 1 ELSE 0 END AS vao_huong_dan
  FROM users u
  JOIN phien_dau d ON d.user_id = u.user_id
  WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
)
SELECT platform,
       COUNT(*) AS so_nguoi_cai,
       SUM(vao_huong_dan) AS so_nguoi_vao_huong_dan,
       ROUND(100 * SUM(vao_huong_dan) / COUNT(*), 2) AS ty_le_pct
FROM nguoi
GROUP BY platform
ORDER BY platform;

-- [jelly-k9-phien-hai-dang-ma] wrong: chi_sua_can_tren
WITH phien_dau AS (
  SELECT user_id, MIN(session_id) AS session_id
  FROM sessions
  GROUP BY user_id
)
SELECT u.platform,
       COUNT(*) AS so_nguoi_cai,
       COUNT(CASE WHEN s.entry_screen = 'tutorial' THEN 1 END) AS so_nguoi_vao_huong_dan,
       ROUND(100 * COUNT(CASE WHEN s.entry_screen = 'tutorial' THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM users u
JOIN phien_dau d ON d.user_id = u.user_id
JOIN sessions s ON s.session_id = d.session_id
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY u.platform
ORDER BY u.platform;

-- [jelly-k9-phien-hai-dang-ma] wrong: chi_sua_thu_tu_phien
WITH phien_dau AS (
  SELECT user_id, MIN(session_start) AS bat_dau
  FROM sessions
  GROUP BY user_id
),
nguoi AS (
  SELECT u.user_id, u.platform,
         CASE WHEN EXISTS (SELECT 1 FROM sessions s
                           WHERE s.user_id = u.user_id
                             AND s.session_start = d.bat_dau
                             AND s.entry_screen = 'tutorial') THEN 1 ELSE 0 END AS vao_huong_dan
  FROM users u
  JOIN phien_dau d ON d.user_id = u.user_id
  WHERE u.install_date >= '2026-07-01'
)
SELECT platform,
       COUNT(*) AS so_nguoi_cai,
       SUM(vao_huong_dan) AS so_nguoi_vao_huong_dan,
       ROUND(100 * SUM(vao_huong_dan) / COUNT(*), 2) AS ty_le_pct
FROM nguoi
GROUP BY platform
ORDER BY platform;

-- ################################################################ MODULE 10 · QUERY PERFORMANCE

-- [jelly-p1-dem-ket-qua-mot-lan] starter
SELECT t.level_id, t.so_thang, f.so_thua, q.so_bo_cuoc, c.so_su_co
FROM (SELECT level_id, COUNT(*) AS so_thang FROM level_attempts
      WHERE level_id BETWEEN 28 AND 30 AND result = 'complete'
        AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
      GROUP BY level_id) t
JOIN (SELECT level_id, COUNT(*) AS so_thua FROM level_attempts
      WHERE level_id BETWEEN 28 AND 30 AND result = 'fail_out_of_moves'
        AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
      GROUP BY level_id) f ON f.level_id = t.level_id
JOIN (SELECT level_id, COUNT(*) AS so_bo_cuoc FROM level_attempts
      WHERE level_id BETWEEN 28 AND 30 AND result = 'quit'
        AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
      GROUP BY level_id) q ON q.level_id = t.level_id
JOIN (SELECT level_id, COUNT(*) AS so_su_co FROM level_attempts
      WHERE level_id BETWEEN 28 AND 30 AND result = 'crash'
        AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
      GROUP BY level_id) c ON c.level_id = t.level_id
ORDER BY t.level_id;

-- [jelly-p1-dem-ket-qua-mot-lan] solution
SELECT level_id,
       COUNT(CASE WHEN result = 'complete' THEN 1 END) AS so_thang,
       COUNT(CASE WHEN result = 'fail_out_of_moves' THEN 1 END) AS so_thua,
       COUNT(CASE WHEN result = 'quit' THEN 1 END) AS so_bo_cuoc,
       COUNT(CASE WHEN result = 'crash' THEN 1 END) AS so_su_co
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY level_id
ORDER BY level_id;

-- [jelly-p1-dem-ket-qua-mot-lan] wrong: group_by_ra_dang_doc
SELECT level_id, result, COUNT(*) AS so_luot
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY level_id, result
ORDER BY level_id, result;

-- [jelly-p1-dem-ket-qua-mot-lan] wrong: dem_count_cot_ket_qua
SELECT level_id,
       COUNT(result = 'complete') AS so_thang,
       COUNT(result = 'fail_out_of_moves') AS so_thua,
       COUNT(result = 'quit') AS so_bo_cuoc,
       COUNT(result = 'crash') AS so_su_co
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-08-01' AND event_date < '2026-09-01'
GROUP BY level_id
ORDER BY level_id;

-- [jelly-p2-doanh-thu-hai-nguon] starter
SELECT 'Android' AS platform, 'interstitial' AS ad_type, COUNT(*) AS so_luot_xem, ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd
FROM ad_events
WHERE platform = 'Android' AND ad_type = 'interstitial' AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
UNION ALL
SELECT 'Android', 'rewarded', COUNT(*), ROUND(SUM(revenue_usd), 2)
FROM ad_events
WHERE platform = 'Android' AND ad_type = 'rewarded' AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
UNION ALL
SELECT 'iOS', 'interstitial', COUNT(*), ROUND(SUM(revenue_usd), 2)
FROM ad_events
WHERE platform = 'iOS' AND ad_type = 'interstitial' AND event_date >= '2026-07-01' AND event_date < '2026-08-01'
UNION ALL
SELECT 'iOS', 'rewarded', COUNT(*), ROUND(SUM(revenue_usd), 2)
FROM ad_events
WHERE platform = 'iOS' AND ad_type = 'rewarded' AND event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- [jelly-p2-doanh-thu-hai-nguon] solution
SELECT platform, ad_type, COUNT(*) AS so_luot_xem, ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd
FROM ad_events
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY platform, ad_type
ORDER BY platform, ad_type;

-- [jelly-p2-doanh-thu-hai-nguon] wrong: gom_thieu_loai_quang_cao
SELECT platform, COUNT(*) AS so_luot_xem, ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd
FROM ad_events
WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
GROUP BY platform
ORDER BY platform;

-- [jelly-p2-doanh-thu-hai-nguon] wrong: quen_loc_thang
SELECT platform, ad_type, COUNT(*) AS so_luot_xem, ROUND(SUM(revenue_usd), 2) AS doanh_thu_usd
FROM ad_events
GROUP BY platform, ad_type
ORDER BY platform, ad_type;

-- [jelly-p3-tren-tb-the-gioi] starter
SELECT l.world_name, l.level_id,
       ROUND(l.ty_le_thua, 2) AS ty_le_thua_pct,
       ROUND(w.tb_the_gioi, 2) AS tb_the_gioi_pct
FROM (SELECT world_name, level_id,
             100 * AVG(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) AS ty_le_thua
      FROM level_attempts
      WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
      GROUP BY world_name, level_id) l
JOIN (SELECT world_name, AVG(ty_le_thua) AS tb_the_gioi
      FROM (SELECT world_name, level_id,
                   100 * AVG(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) AS ty_le_thua
            FROM level_attempts
            WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
            GROUP BY world_name, level_id) x
      GROUP BY world_name) w ON w.world_name = l.world_name
WHERE l.ty_le_thua > w.tb_the_gioi
ORDER BY l.level_id;

-- [jelly-p3-tren-tb-the-gioi] solution
WITH man AS (
  SELECT world_name, level_id,
         100 * AVG(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) AS ty_le_thua
  FROM level_attempts
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
  GROUP BY world_name, level_id
),
so_sanh AS (
  SELECT world_name, level_id, ty_le_thua,
         AVG(ty_le_thua) OVER (PARTITION BY world_name) AS tb_the_gioi
  FROM man
)
SELECT world_name, level_id,
       ROUND(ty_le_thua, 2) AS ty_le_thua_pct,
       ROUND(tb_the_gioi, 2) AS tb_the_gioi_pct
FROM so_sanh
WHERE ty_le_thua > tb_the_gioi
ORDER BY level_id;

-- [jelly-p3-tren-tb-the-gioi] wrong: tb_ca_game_thieu_partition
WITH man AS (
  SELECT world_name, level_id,
         100 * AVG(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) AS ty_le_thua
  FROM level_attempts
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
  GROUP BY world_name, level_id
),
so_sanh AS (
  SELECT world_name, level_id, ty_le_thua,
         AVG(ty_le_thua) OVER () AS tb_the_gioi
  FROM man
)
SELECT world_name, level_id,
       ROUND(ty_le_thua, 2) AS ty_le_thua_pct,
       ROUND(tb_the_gioi, 2) AS tb_the_gioi_pct
FROM so_sanh
WHERE ty_le_thua > tb_the_gioi
ORDER BY level_id;

-- [jelly-p3-tren-tb-the-gioi] wrong: tb_theo_luot_choi
WITH man AS (
  SELECT world_name, level_id, COUNT(*) AS so_luot,
         SUM(CASE WHEN result = 'fail_out_of_moves' THEN 1 ELSE 0 END) AS so_thua
  FROM level_attempts
  WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01'
  GROUP BY world_name, level_id
),
so_sanh AS (
  SELECT world_name, level_id, 100 * so_thua / so_luot AS ty_le_thua,
         100 * SUM(so_thua) OVER (PARTITION BY world_name) / SUM(so_luot) OVER (PARTITION BY world_name) AS tb_the_gioi
  FROM man
)
SELECT world_name, level_id,
       ROUND(ty_le_thua, 2) AS ty_le_thua_pct,
       ROUND(tb_the_gioi, 2) AS tb_the_gioi_pct
FROM so_sanh
WHERE ty_le_thua > tb_the_gioi
ORDER BY level_id;

-- [jelly-p4-luy-ke-tu-noi] starter
SELECT a.`date` AS ngay,
       a.iap_revenue + a.ad_revenue AS doanh_thu,
       SUM(b.iap_revenue + b.ad_revenue) AS luy_ke_thang
FROM daily_kpi a
JOIN daily_kpi b
  ON b.`date` <= a.`date`
 AND b.`date` >= DATE_FORMAT(a.`date`, '%Y-%m-01')
WHERE a.`date` >= '2026-07-01' AND a.`date` < '2026-08-30'
GROUP BY a.`date`, a.iap_revenue, a.ad_revenue
ORDER BY a.`date`;

-- [jelly-p4-luy-ke-tu-noi] solution
SELECT `date` AS ngay,
       iap_revenue + ad_revenue AS doanh_thu,
       SUM(iap_revenue + ad_revenue) OVER (PARTITION BY DATE_FORMAT(`date`, '%Y-%m')
                                           ORDER BY `date`) AS luy_ke_thang
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
ORDER BY `date`;

-- [jelly-p4-luy-ke-tu-noi] wrong: thieu_partition_thang
SELECT `date` AS ngay,
       iap_revenue + ad_revenue AS doanh_thu,
       SUM(iap_revenue + ad_revenue) OVER (ORDER BY `date`) AS luy_ke_thang
FROM daily_kpi
WHERE `date` >= '2026-07-01' AND `date` < '2026-08-30'
ORDER BY `date`;

-- [jelly-p4-luy-ke-tu-noi] wrong: quen_can_tren
SELECT `date` AS ngay,
       iap_revenue + ad_revenue AS doanh_thu,
       SUM(iap_revenue + ad_revenue) OVER (PARTITION BY DATE_FORMAT(`date`, '%Y-%m')
                                           ORDER BY `date`) AS luy_ke_thang
FROM daily_kpi
WHERE `date` >= '2026-07-01'
ORDER BY `date`;

-- [jelly-p5-nguoi-tra-tien-exists] starter
SELECT pd.channel, COUNT(DISTINCT p.user_id) AS so_nguoi_tra_tien
FROM purchases p
JOIN player_daily pd ON pd.user_id = p.user_id
WHERE p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
GROUP BY pd.channel
ORDER BY so_nguoi_tra_tien DESC, pd.channel;

-- [jelly-p5-nguoi-tra-tien-exists] solution
SELECT u.channel, COUNT(*) AS so_nguoi_tra_tien
FROM users u
JOIN (SELECT DISTINCT user_id
      FROM purchases
      WHERE event_date >= '2026-07-01' AND event_date < '2026-08-30') p ON p.user_id = u.user_id
GROUP BY u.channel
ORDER BY so_nguoi_tra_tien DESC, u.channel;

-- [jelly-p5-nguoi-tra-tien-exists] wrong: dem_giao_dich_thay_nguoi
SELECT u.channel, COUNT(*) AS so_nguoi_tra_tien
FROM users u
JOIN purchases p ON p.user_id = u.user_id
WHERE p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
GROUP BY u.channel
ORDER BY so_nguoi_tra_tien DESC, u.channel;

-- [jelly-p6-d1-d3-d7-mot-lan-quet] starter
SELECT
  (SELECT COUNT(*) FROM player_daily
    WHERE install_date >= '2026-07-01' AND install_date < '2026-07-08' AND cohort_day = 1) AS so_con_d1,
  (SELECT COUNT(*) FROM player_daily
    WHERE install_date >= '2026-07-01' AND install_date < '2026-07-08' AND cohort_day = 3) AS so_con_d3,
  (SELECT COUNT(*) FROM player_daily
    WHERE install_date >= '2026-07-01' AND install_date < '2026-07-08' AND cohort_day = 7) AS so_con_d7;

-- [jelly-p6-d1-d3-d7-mot-lan-quet] solution
SELECT COUNT(CASE WHEN cohort_day = 1 THEN 1 END) AS so_con_d1,
       COUNT(CASE WHEN cohort_day = 3 THEN 1 END) AS so_con_d3,
       COUNT(CASE WHEN cohort_day = 7 THEN 1 END) AS so_con_d7
FROM player_daily
WHERE install_date >= '2026-07-01' AND install_date < '2026-07-08';

-- [jelly-p6-d1-d3-d7-mot-lan-quet] wrong: group_by_ra_ba_dong
SELECT cohort_day, COUNT(*) AS so_con
FROM player_daily
WHERE install_date >= '2026-07-01' AND install_date < '2026-07-08'
  AND cohort_day IN (1, 3, 7)
GROUP BY cohort_day
ORDER BY cohort_day;

-- [jelly-p6-d1-d3-d7-mot-lan-quet] wrong: count_bieu_thuc_so_sanh
SELECT COUNT(cohort_day = 1) AS so_con_d1,
       COUNT(cohort_day = 3) AS so_con_d3,
       COUNT(cohort_day = 7) AS so_con_d7
FROM player_daily
WHERE install_date >= '2026-07-01' AND install_date < '2026-07-08';

-- [jelly-p7-index-ngay] starter
SELECT level_id,
       COUNT(*) AS so_luot,
       COUNT(CASE WHEN result = 'complete' THEN 1 END) AS so_thang,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE DATE(event_time) = '2026-08-10'
GROUP BY level_id
ORDER BY so_luot DESC, level_id
LIMIT 10;

-- [jelly-p7-index-ngay] solution
SELECT level_id,
       COUNT(*) AS so_luot,
       COUNT(CASE WHEN result = 'complete' THEN 1 END) AS so_thang,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE event_date = '2026-08-10'
GROUP BY level_id
ORDER BY so_luot DESC, level_id
LIMIT 10;

-- [jelly-p7-index-ngay] wrong: thieu_can_tren_thoi_diem
SELECT level_id,
       COUNT(*) AS so_luot,
       COUNT(CASE WHEN result = 'complete' THEN 1 END) AS so_thang,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE event_time >= '2026-08-10'
GROUP BY level_id
ORDER BY so_luot DESC, level_id
LIMIT 10;

-- [jelly-p7-index-ngay] wrong: between_tren_datetime
SELECT level_id,
       COUNT(*) AS so_luot,
       COUNT(CASE WHEN result = 'complete' THEN 1 END) AS so_thang,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE event_time BETWEEN '2026-08-10' AND '2026-08-10'
GROUP BY level_id
ORDER BY so_luot DESC, level_id
LIMIT 10;

-- [jelly-p7-index-ngay] wrong: van_boc_ham_ngay
SELECT level_id,
       COUNT(*) AS so_luot,
       COUNT(CASE WHEN result = 'complete' THEN 1 END) AS so_thang,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE DATE_FORMAT(event_date, '%Y-%m-%d') = '2026-08-10'
GROUP BY level_id
ORDER BY so_luot DESC, level_id
LIMIT 10;

-- [jelly-p8-moc-dau-dot-su-kien] starter
SELECT COUNT(*) AS so_ngay_nguoi,
       SUM(sessions) AS so_phien
FROM player_daily
WHERE activity_date > '2026-08-08' AND activity_date <= '2026-08-12';

-- [jelly-p8-moc-dau-dot-su-kien] solution
SELECT COUNT(*) AS so_ngay_nguoi,
       SUM(sessions) AS so_phien
FROM player_daily
WHERE activity_date >= '2026-08-08' AND activity_date <= '2026-08-12';

-- [jelly-p8-moc-dau-dot-su-kien] wrong: bo_can_tren
SELECT COUNT(*) AS so_ngay_nguoi,
       SUM(sessions) AS so_phien
FROM player_daily
WHERE activity_date >= '2026-08-08';

-- [jelly-p8-moc-dau-dot-su-kien] wrong: mat_ngay_cuoi
SELECT COUNT(*) AS so_ngay_nguoi,
       SUM(sessions) AS so_phien
FROM player_daily
WHERE activity_date >= '2026-08-08' AND activity_date < '2026-08-12';

-- [jelly-p9-select-distinct-thua] starter
WITH nguoi AS (
  SELECT DISTINCT user_id FROM player_daily
),
chi AS (
  SELECT n.user_id, COALESCE(SUM(p.price_usd), 0) AS tong_chi
  FROM nguoi n
  LEFT JOIN purchases p
    ON p.user_id = n.user_id
   AND p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
  GROUP BY n.user_id
),
nhom AS (
  SELECT CASE WHEN tong_chi = 0 THEN 'khong_chi'
              WHEN tong_chi < 5 THEN 'duoi_5'
              WHEN tong_chi <= 20 THEN 'tu_5_den_20'
              ELSE 'tren_20' END AS phan_khuc,
         tong_chi
  FROM chi
)
SELECT phan_khuc,
       COUNT(*) AS so_nguoi_choi,
       SUM(tong_chi) AS doanh_thu_usd,
       ROUND(100 * SUM(tong_chi) / SUM(SUM(tong_chi)) OVER (), 2) AS ty_trong_doanh_thu_pct
FROM nhom
GROUP BY phan_khuc
ORDER BY MIN(tong_chi);

-- [jelly-p9-select-distinct-thua] solution
WITH chi AS (
  SELECT u.user_id, COALESCE(SUM(p.price_usd), 0) AS tong_chi
  FROM users u
  LEFT JOIN purchases p
    ON p.user_id = u.user_id
   AND p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
  GROUP BY u.user_id
),
nhom AS (
  SELECT CASE WHEN tong_chi = 0 THEN 'khong_chi'
              WHEN tong_chi < 5 THEN 'duoi_5'
              WHEN tong_chi <= 20 THEN 'tu_5_den_20'
              ELSE 'tren_20' END AS phan_khuc,
         tong_chi
  FROM chi
)
SELECT phan_khuc,
       COUNT(*) AS so_nguoi_choi,
       SUM(tong_chi) AS doanh_thu_usd,
       ROUND(100 * SUM(tong_chi) / SUM(SUM(tong_chi)) OVER (), 2) AS ty_trong_doanh_thu_pct
FROM nhom
GROUP BY phan_khuc
ORDER BY MIN(tong_chi);

-- [jelly-p9-select-distinct-thua] wrong: inner_join_mat_nhom_khong_chi
WITH chi AS (
  SELECT u.user_id, SUM(p.price_usd) AS tong_chi
  FROM users u
  JOIN purchases p
    ON p.user_id = u.user_id
   AND p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
  GROUP BY u.user_id
),
nhom AS (
  SELECT CASE WHEN tong_chi = 0 THEN 'khong_chi'
              WHEN tong_chi < 5 THEN 'duoi_5'
              WHEN tong_chi <= 20 THEN 'tu_5_den_20'
              ELSE 'tren_20' END AS phan_khuc,
         tong_chi
  FROM chi
)
SELECT phan_khuc,
       COUNT(*) AS so_nguoi_choi,
       SUM(tong_chi) AS doanh_thu_usd,
       ROUND(100 * SUM(tong_chi) / SUM(SUM(tong_chi)) OVER (), 2) AS ty_trong_doanh_thu_pct
FROM nhom
GROUP BY phan_khuc
ORDER BY MIN(tong_chi);

-- [jelly-p9-select-distinct-thua] wrong: ty_trong_theo_so_nguoi
WITH chi AS (
  SELECT u.user_id, COALESCE(SUM(p.price_usd), 0) AS tong_chi
  FROM users u
  LEFT JOIN purchases p
    ON p.user_id = u.user_id
   AND p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
  GROUP BY u.user_id
),
nhom AS (
  SELECT CASE WHEN tong_chi = 0 THEN 'khong_chi'
              WHEN tong_chi < 5 THEN 'duoi_5'
              WHEN tong_chi <= 20 THEN 'tu_5_den_20'
              ELSE 'tren_20' END AS phan_khuc,
         tong_chi
  FROM chi
)
SELECT phan_khuc,
       COUNT(*) AS so_nguoi_choi,
       SUM(tong_chi) AS doanh_thu_usd,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS ty_trong_doanh_thu_pct
FROM nhom
GROUP BY phan_khuc
ORDER BY MIN(tong_chi);

-- [jelly-p9-select-distinct-thua] wrong: loc_ngay_o_where
WITH chi AS (
  SELECT u.user_id, COALESCE(SUM(p.price_usd), 0) AS tong_chi
  FROM users u
  LEFT JOIN purchases p ON p.user_id = u.user_id
  WHERE p.event_date >= '2026-07-01' AND p.event_date < '2026-08-30'
  GROUP BY u.user_id
),
nhom AS (
  SELECT CASE WHEN tong_chi = 0 THEN 'khong_chi'
              WHEN tong_chi < 5 THEN 'duoi_5'
              WHEN tong_chi <= 20 THEN 'tu_5_den_20'
              ELSE 'tren_20' END AS phan_khuc,
         tong_chi
  FROM chi
)
SELECT phan_khuc,
       COUNT(*) AS so_nguoi_choi,
       SUM(tong_chi) AS doanh_thu_usd,
       ROUND(100 * SUM(tong_chi) / SUM(SUM(tong_chi)) OVER (), 2) AS ty_trong_doanh_thu_pct
FROM nhom
GROUP BY phan_khuc
ORDER BY MIN(tong_chi);

-- ################################################################ CASE STUDY

-- [jelly-c9-ab-mua-them-buoc.b1] solution
SELECT variant,
       COUNT(*) AS so_nguoi_duoc_chia,
       COUNT(CASE WHEN assigned_at < '2026-08-23' THEN 1 END) AS so_nguoi_du_ngay,
       COUNT(CASE WHEN assigned_at < '2026-08-23' AND exposed_at IS NOT NULL THEN 1 END) AS so_da_tiep_xuc
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing'
GROUP BY variant
ORDER BY variant;

-- [jelly-c9-ab-mua-them-buoc.b1] wrong: dem_tiep_xuc_bang_is_null
SELECT variant,
       COUNT(*) AS so_nguoi_duoc_chia,
       COUNT(CASE WHEN assigned_at < '2026-08-23' THEN 1 END) AS so_nguoi_du_ngay,
       COUNT(CASE WHEN assigned_at < '2026-08-23' AND exposed_at = NULL THEN 1 END) AS so_da_tiep_xuc
FROM ab_assignments
WHERE experiment_id = 'extra_moves_offer_timing'
GROUP BY variant
ORDER BY variant;

-- [jelly-c9-ab-mua-them-buoc.b2] solution
WITH nhom AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
),
nhan AS (
  SELECT n.user_id, COALESCE(SUM(a.extra_moves_purchased), 0) AS so_luot_nhan
  FROM nhom n
  LEFT JOIN level_attempts a
    ON a.user_id = n.user_id
   AND a.event_date >= n.ngay_chia
   AND a.event_date <= n.ngay_chia + INTERVAL 6 DAY
  GROUP BY n.user_id
)
SELECT n.variant,
       COUNT(*) AS so_nguoi,
       SUM(m.so_luot_nhan) AS so_luot_nhan,
       ROUND(SUM(m.so_luot_nhan) / COUNT(*), 4) AS luot_nhan_moi_nguoi,
       ROUND(100 * COUNT(CASE WHEN m.so_luot_nhan > 0 THEN 1 END) / COUNT(*), 2) AS ty_le_nguoi_nhan_pct
FROM nhom n
JOIN nhan m ON m.user_id = n.user_id
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c9-ab-mua-them-buoc.b2] wrong: chi_tinh_nguoi_da_tiep_xuc
WITH nhom AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
    AND exposure_status = 'exposed'
),
nhan AS (
  SELECT n.user_id, COALESCE(SUM(a.extra_moves_purchased), 0) AS so_luot_nhan
  FROM nhom n
  LEFT JOIN level_attempts a
    ON a.user_id = n.user_id
   AND a.event_date >= n.ngay_chia
   AND a.event_date <= n.ngay_chia + INTERVAL 6 DAY
  GROUP BY n.user_id
)
SELECT n.variant,
       COUNT(*) AS so_nguoi,
       SUM(m.so_luot_nhan) AS so_luot_nhan,
       ROUND(SUM(m.so_luot_nhan) / COUNT(*), 4) AS luot_nhan_moi_nguoi,
       ROUND(100 * COUNT(CASE WHEN m.so_luot_nhan > 0 THEN 1 END) / COUNT(*), 2) AS ty_le_nguoi_nhan_pct
FROM nhom n
JOIN nhan m ON m.user_id = n.user_id
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c9-ab-mua-them-buoc.b2] wrong: dem_giao_dich_goi_thay_co
WITH nhom AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
),
nhan AS (
  SELECT n.user_id, COUNT(p.transaction_id) AS so_luot_nhan
  FROM nhom n
  LEFT JOIN purchases p
    ON p.user_id = n.user_id
   AND p.product_type = 'extra_moves_pack'
   AND p.event_date >= n.ngay_chia
   AND p.event_date <= n.ngay_chia + INTERVAL 6 DAY
  GROUP BY n.user_id
)
SELECT n.variant,
       COUNT(*) AS so_nguoi,
       SUM(m.so_luot_nhan) AS so_luot_nhan,
       ROUND(SUM(m.so_luot_nhan) / COUNT(*), 4) AS luot_nhan_moi_nguoi,
       ROUND(100 * COUNT(CASE WHEN m.so_luot_nhan > 0 THEN 1 END) / COUNT(*), 2) AS ty_le_nguoi_nhan_pct
FROM nhom n
JOIN nhan m ON m.user_id = n.user_id
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c9-ab-mua-them-buoc.b3] solution
WITH nhom AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
),
chi AS (
  SELECT n.user_id, COALESCE(SUM(p.price_usd), 0) AS doanh_thu
  FROM nhom n
  LEFT JOIN purchases p
    ON p.user_id = n.user_id
   AND p.event_date >= n.ngay_chia
   AND p.event_date <= n.ngay_chia + INTERVAL 6 DAY
  GROUP BY n.user_id
)
SELECT n.variant,
       COUNT(*) AS so_nguoi,
       SUM(c.doanh_thu) AS doanh_thu_iap_usd,
       ROUND(SUM(c.doanh_thu) / COUNT(*), 4) AS doanh_thu_moi_nguoi_usd
FROM nhom n
JOIN chi c ON c.user_id = n.user_id
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c9-ab-mua-them-buoc.b3] wrong: mau_so_nguoi_tra_tien
WITH nhom AS (
  SELECT user_id, variant, DATE(assigned_at) AS ngay_chia
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
)
SELECT n.variant,
       COUNT(DISTINCT n.user_id) AS so_nguoi,
       SUM(p.price_usd) AS doanh_thu_iap_usd,
       ROUND(SUM(p.price_usd) / COUNT(DISTINCT n.user_id), 4) AS doanh_thu_moi_nguoi_usd
FROM nhom n
JOIN purchases p
  ON p.user_id = n.user_id
 AND p.event_date >= n.ngay_chia
 AND p.event_date <= n.ngay_chia + INTERVAL 6 DAY
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c9-ab-mua-them-buoc.b4] solution
WITH nhom AS (
  SELECT user_id, variant
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing' AND assigned_at < '2026-08-23'
)
SELECT n.variant,
       COUNT(*) AS so_nguoi,
       COUNT(d.user_id) AS so_con_d7,
       ROUND(100 * COUNT(d.user_id) / COUNT(*), 2) AS ty_le_giu_chan_d7_pct
FROM nhom n
LEFT JOIN player_daily d ON d.user_id = n.user_id AND d.cohort_day = 7
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c9-ab-mua-them-buoc.b4] wrong: gom_ca_nguoi_chua_du_ngay
WITH nhom AS (
  SELECT user_id, variant
  FROM ab_assignments
  WHERE experiment_id = 'extra_moves_offer_timing'
)
SELECT n.variant,
       COUNT(*) AS so_nguoi,
       COUNT(d.user_id) AS so_con_d7,
       ROUND(100 * COUNT(d.user_id) / COUNT(*), 2) AS ty_le_giu_chan_d7_pct
FROM nhom n
LEFT JOIN player_daily d ON d.user_id = n.user_id AND d.cohort_day = 7
GROUP BY n.variant
ORDER BY n.variant;

-- [jelly-c10-man-28-30.b1] solution
SELECT app_version, platform,
       COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-08-15' AND event_date < '2026-08-30'
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c10-man-28-30.b1] wrong: phien_ban_luc_cai
SELECT u.app_version_install AS app_version, a.platform,
       COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN a.result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts a
JOIN users u ON u.user_id = a.user_id
WHERE a.level_id BETWEEN 28 AND 30
  AND a.event_date >= '2026-08-15' AND a.event_date < '2026-08-30'
GROUP BY u.app_version_install, a.platform
ORDER BY app_version, a.platform;

-- [jelly-c10-man-28-30.b1] wrong: ca_cua_so_du_lieu
-- So trên cả cửa sổ 1/7–29/8 thay cho khoảng ba bản cùng chạy: bản 2.0.2, 2.1.0 có thêm những ngày chưa có bản vá.
SELECT app_version, platform,
       COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN result = 'complete' THEN 1 END) / COUNT(*), 2) AS ty_le_thang_pct
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c10-man-28-30.b2] solution
SELECT app_version, platform,
       COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN result = 'fail_out_of_moves' THEN 1 END) / COUNT(*), 2) AS ty_le_thua_pct,
       ROUND(100 * COUNT(CASE WHEN result = 'quit' THEN 1 END) / COUNT(*), 2) AS ty_le_bo_cuoc_pct
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c10-man-28-30.b3] solution
SELECT app_version, platform,
       COUNT(*) AS so_luot,
       ROUND(100 * SUM(extra_moves_offered) / COUNT(*), 2) AS ty_le_duoc_moi_pct,
       ROUND(100 * SUM(extra_moves_purchased) / COUNT(*), 2) AS ty_le_nhan_them_pct
FROM level_attempts
WHERE level_id BETWEEN 28 AND 30
  AND event_date >= '2026-07-01' AND event_date < '2026-08-30'
GROUP BY app_version, platform
ORDER BY app_version, platform;

-- [jelly-c10-man-28-30.b4] solution
SELECT u.app_version_install, u.platform,
       COUNT(*) AS so_nguoi_cai,
       COUNT(d.user_id) AS so_con_d1,
       ROUND(100 * COUNT(d.user_id) / COUNT(*), 2) AS ty_le_giu_chan_d1_pct
FROM users u
LEFT JOIN player_daily d ON d.user_id = u.user_id AND d.cohort_day = 1
WHERE u.install_date >= '2026-07-01' AND u.install_date <= '2026-08-28'
GROUP BY u.app_version_install, u.platform
ORDER BY u.app_version_install, u.platform;

-- [jelly-c10-man-28-30.b4] wrong: mau_so_tu_bang_hoat_dong
SELECT pd.app_version AS app_version_install, pd.platform,
       COUNT(DISTINCT pd.user_id) AS so_nguoi_cai,
       COUNT(DISTINCT CASE WHEN pd.cohort_day = 1 THEN pd.user_id END) AS so_con_d1,
       ROUND(100 * COUNT(DISTINCT CASE WHEN pd.cohort_day = 1 THEN pd.user_id END) / COUNT(DISTINCT pd.user_id), 2) AS ty_le_giu_chan_d1_pct
FROM player_daily pd
WHERE pd.install_date >= '2026-07-01' AND pd.install_date <= '2026-08-28'
GROUP BY pd.app_version, pd.platform
ORDER BY app_version_install, pd.platform;
