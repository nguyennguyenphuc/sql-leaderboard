-- solution.sql: gói 3 bộ GAME Jelly Trail Academy (jelly). Module 5 Joins, Module 6 Subqueries, case c5, c6.
-- MySQL 8.0. Mỗi khối một truy vấn SELECT/WITH, kết thúc bằng dấu chấm phẩy.
-- Dữ liệu: jelly (public), jelly_hidden_1 (bỏ người chơi id % 10 = 7, thêm ngày 2026-09-01).

-- ################################################################ MODULE 5 · JOINS

-- [jelly-j1-luot-choi-kem-the-gioi] solution
SELECT la.attempt_id, la.event_time, la.level_id, la.result, m.designed_fail_probability
FROM level_attempts la
JOIN level_metadata m ON m.level_id = la.level_id
WHERE la.event_date = '2026-08-29'
ORDER BY la.event_time DESC, la.attempt_id DESC
LIMIT 20;

-- [jelly-j1-luot-choi-kem-the-gioi] wrong: quen_loc_ngay
-- Không lọc ngày 29/8: ở hidden-1 lượt chơi ngày 1/9 và 2/9/2026 lên đầu.
SELECT la.attempt_id, la.event_time, la.level_id, la.result, m.designed_fail_probability
FROM level_attempts la
JOIN level_metadata m ON m.level_id = la.level_id
ORDER BY la.event_time DESC, la.attempt_id DESC
LIMIT 20;

-- [jelly-j1-luot-choi-kem-the-gioi] wrong: hoa_thoi_gian_sai_chieu
SELECT la.attempt_id, la.event_time, la.level_id, la.result, m.designed_fail_probability
FROM level_attempts la
JOIN level_metadata m ON m.level_id = la.level_id
WHERE la.event_date = '2026-08-29'
ORDER BY la.event_time DESC, la.attempt_id
LIMIT 20;

-- [jelly-j2-doanh-thu-theo-kenh-cai] solution
SELECT u.channel AS kenh,
       COUNT(DISTINCT p.user_id) AS so_nguoi_tra_tien,
       ROUND(SUM(p.price_usd), 2) AS doanh_thu_iap_usd
FROM purchases p
JOIN users u ON u.user_id = p.user_id
WHERE p.event_date >= '2026-08-01' AND p.event_date < '2026-09-01'
GROUP BY u.channel
ORDER BY doanh_thu_iap_usd DESC, kenh;

-- [jelly-j2-doanh-thu-theo-kenh-cai] wrong: dem_giao_dich_thay_nguoi
SELECT u.channel AS kenh,
       COUNT(*) AS so_nguoi_tra_tien,
       ROUND(SUM(p.price_usd), 2) AS doanh_thu_iap_usd
FROM purchases p
JOIN users u ON u.user_id = p.user_id
WHERE p.event_date >= '2026-08-01' AND p.event_date < '2026-09-01'
GROUP BY u.channel
ORDER BY doanh_thu_iap_usd DESC, kenh;

-- [jelly-j2-doanh-thu-theo-kenh-cai] wrong: thieu_can_tren
SELECT u.channel AS kenh,
       COUNT(DISTINCT p.user_id) AS so_nguoi_tra_tien,
       ROUND(SUM(p.price_usd), 2) AS doanh_thu_iap_usd
FROM purchases p
JOIN users u ON u.user_id = p.user_id
WHERE p.event_date >= '2026-08-01'
GROUP BY u.channel
ORDER BY doanh_thu_iap_usd DESC, kenh;

-- [jelly-j3-di-sau-chua-tra-tien] solution
SELECT u.channel AS kenh,
       COUNT(*) AS so_nguoi_di_sau,
       COUNT(CASE WHEN m.user_id IS NULL THEN 1 END) AS so_chua_tra_tien,
       ROUND(100 * COUNT(CASE WHEN m.user_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_chua_tra_tien_pct,
       ROUND(SUM(CASE WHEN m.user_id IS NULL THEN q.doanh_thu_qc ELSE 0 END), 2) AS doanh_thu_qc_usd
FROM users u
JOIN (SELECT DISTINCT la.user_id
      FROM level_attempts la
      JOIN level_metadata lm ON lm.level_id = la.level_id
      WHERE lm.episode >= 3 AND la.event_date <= '2026-08-29') d ON d.user_id = u.user_id
LEFT JOIN (SELECT DISTINCT user_id FROM purchases
           WHERE event_date <= '2026-08-29') m ON m.user_id = u.user_id
LEFT JOIN (SELECT user_id, SUM(ad_revenue) AS doanh_thu_qc FROM player_daily
           WHERE activity_date <= '2026-08-29'
           GROUP BY user_id) q ON q.user_id = u.user_id
GROUP BY u.channel
ORDER BY ty_le_chua_tra_tien_pct DESC, kenh;

-- [jelly-j3-di-sau-chua-tra-tien] wrong: noi_thang_nhan_dong
-- Nối thẳng lượt chơi với hoạt động ngày theo người chơi và ngày: số người đếm DISTINCT nên đúng,
-- nhưng doanh thu quảng cáo của một ngày bị cộng lặp theo số lượt chơi thế giới thứ ba trong ngày đó.
SELECT u.channel AS kenh,
       COUNT(DISTINCT u.user_id) AS so_nguoi_di_sau,
       COUNT(DISTINCT CASE WHEN m.user_id IS NULL THEN u.user_id END) AS so_chua_tra_tien,
       ROUND(100 * COUNT(DISTINCT CASE WHEN m.user_id IS NULL THEN u.user_id END)
             / COUNT(DISTINCT u.user_id), 2) AS ty_le_chua_tra_tien_pct,
       ROUND(SUM(CASE WHEN m.user_id IS NULL THEN pd.ad_revenue ELSE 0 END), 2) AS doanh_thu_qc_usd
FROM users u
JOIN level_attempts la ON la.user_id = u.user_id AND la.episode >= 3 AND la.event_date <= '2026-08-29'
JOIN player_daily pd ON pd.user_id = la.user_id AND pd.activity_date = la.event_date
LEFT JOIN (SELECT DISTINCT user_id FROM purchases
           WHERE event_date <= '2026-08-29') m ON m.user_id = u.user_id
GROUP BY u.channel
ORDER BY ty_le_chua_tra_tien_pct DESC, kenh;

-- [jelly-j3-di-sau-chua-tra-tien] wrong: dieu_kien_ngay_o_where
-- Điều kiện ngày của giao dịch đặt ở WHERE: dòng không có giao dịch (ngày rỗng) bị loại, phép nối giữ dòng thành nối thường.
SELECT u.channel AS kenh,
       COUNT(DISTINCT u.user_id) AS so_nguoi_di_sau,
       COUNT(DISTINCT CASE WHEN p.user_id IS NULL THEN u.user_id END) AS so_chua_tra_tien,
       ROUND(100 * COUNT(DISTINCT CASE WHEN p.user_id IS NULL THEN u.user_id END)
             / COUNT(DISTINCT u.user_id), 2) AS ty_le_chua_tra_tien_pct,
       ROUND(SUM(CASE WHEN p.user_id IS NULL THEN q.doanh_thu_qc ELSE 0 END), 2) AS doanh_thu_qc_usd
FROM users u
JOIN (SELECT DISTINCT user_id FROM level_attempts
      WHERE episode >= 3 AND event_date <= '2026-08-29') d ON d.user_id = u.user_id
LEFT JOIN purchases p ON p.user_id = u.user_id
LEFT JOIN (SELECT user_id, SUM(ad_revenue) AS doanh_thu_qc FROM player_daily
           WHERE activity_date <= '2026-08-29'
           GROUP BY user_id) q ON q.user_id = u.user_id
WHERE p.event_date <= '2026-08-29'
GROUP BY u.channel
ORDER BY ty_le_chua_tra_tien_pct DESC, kenh;

-- [jelly-j3-di-sau-chua-tra-tien] wrong: thieu_can_tren_giao_dich
-- Không giới hạn ngày giao dịch: ở hidden-1 người chơi mua Starter Pack ngày 1/9/2026 bị tính là đã trả tiền.
SELECT u.channel AS kenh,
       COUNT(*) AS so_nguoi_di_sau,
       COUNT(CASE WHEN m.user_id IS NULL THEN 1 END) AS so_chua_tra_tien,
       ROUND(100 * COUNT(CASE WHEN m.user_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_chua_tra_tien_pct,
       ROUND(SUM(CASE WHEN m.user_id IS NULL THEN q.doanh_thu_qc ELSE 0 END), 2) AS doanh_thu_qc_usd
FROM users u
JOIN (SELECT DISTINCT la.user_id
      FROM level_attempts la
      JOIN level_metadata lm ON lm.level_id = la.level_id
      WHERE lm.episode >= 3 AND la.event_date <= '2026-08-29') d ON d.user_id = u.user_id
LEFT JOIN (SELECT DISTINCT user_id FROM purchases) m ON m.user_id = u.user_id
LEFT JOIN (SELECT user_id, SUM(ad_revenue) AS doanh_thu_qc FROM player_daily
           WHERE activity_date <= '2026-08-29'
           GROUP BY user_id) q ON q.user_id = u.user_id
GROUP BY u.channel
ORDER BY ty_le_chua_tra_tien_pct DESC, kenh;

-- [jelly-j4-cpi-thang-8-so-muc-chung] solution
SELECT c.channel AS kenh, c.target_platform AS nen_tang,
       i.so_luot_cai,
       ROUND(c.chi / i.so_luot_cai, 2) AS cpi_usd,
       ROUND(c.chi / i.so_luot_cai - t.chi_tong / t.cai_tong, 2) AS chenh_lech_usd
FROM (SELECT channel, target_platform, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01'
      GROUP BY channel, target_platform) c
JOIN (SELECT channel, platform, COUNT(*) AS so_luot_cai
      FROM users
      WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
      GROUP BY channel, platform) i
  ON i.channel = c.channel AND i.platform = c.target_platform
CROSS JOIN (SELECT (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01') AS chi_tong,
                   (SELECT COUNT(*) FROM users
                    WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
                      AND channel <> 'Organic') AS cai_tong) t
ORDER BY kenh, nen_tang;

-- [jelly-j4-cpi-thang-8-so-muc-chung] wrong: noi_truc_tiep_nhan_dong
-- Nối thẳng người cài với dòng chi phí theo chiến dịch và nền tảng: mỗi người lặp theo số dòng chi nên chi phí bị cộng nhiều lần.
SELECT u.channel AS kenh, u.platform AS nen_tang,
       COUNT(DISTINCT u.user_id) AS so_luot_cai,
       ROUND(SUM(cs.spend_usd) / COUNT(DISTINCT u.user_id), 2) AS cpi_usd,
       ROUND(SUM(cs.spend_usd) / COUNT(DISTINCT u.user_id) - MAX(t.chi_tong / t.cai_tong), 2) AS chenh_lech_usd
FROM users u
JOIN campaign_spend cs ON cs.campaign_id = u.campaign_id AND cs.target_platform = u.platform
CROSS JOIN (SELECT (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01') AS chi_tong,
                   (SELECT COUNT(*) FROM users
                    WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
                      AND channel <> 'Organic') AS cai_tong) t
WHERE u.install_date >= '2026-08-01' AND u.install_date < '2026-09-01'
  AND cs.`date` >= '2026-08-01' AND cs.`date` < '2026-09-01'
GROUP BY u.channel, u.platform
ORDER BY kenh, nen_tang;

-- [jelly-j4-cpi-thang-8-so-muc-chung] wrong: cpi_chung_la_trung_binh_cpi
SELECT c.channel AS kenh, c.target_platform AS nen_tang,
       i.so_luot_cai,
       ROUND(c.chi / i.so_luot_cai, 2) AS cpi_usd,
       ROUND(c.chi / i.so_luot_cai - AVG(c.chi / i.so_luot_cai) OVER (), 2) AS chenh_lech_usd
FROM (SELECT channel, target_platform, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01'
      GROUP BY channel, target_platform) c
JOIN (SELECT channel, platform, COUNT(*) AS so_luot_cai
      FROM users
      WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
      GROUP BY channel, platform) i
  ON i.channel = c.channel AND i.platform = c.target_platform
ORDER BY kenh, nen_tang;

-- [jelly-j4-cpi-thang-8-so-muc-chung] wrong: mau_so_gom_organic
-- Mẫu số CPI chung đếm cả người chơi tự nhiên, không có chi phí nên CPI chung thấp đi.
SELECT c.channel AS kenh, c.target_platform AS nen_tang,
       i.so_luot_cai,
       ROUND(c.chi / i.so_luot_cai, 2) AS cpi_usd,
       ROUND(c.chi / i.so_luot_cai - t.chi_tong / t.cai_tong, 2) AS chenh_lech_usd
FROM (SELECT channel, target_platform, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01'
      GROUP BY channel, target_platform) c
JOIN (SELECT channel, platform, COUNT(*) AS so_luot_cai
      FROM users
      WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
      GROUP BY channel, platform) i
  ON i.channel = c.channel AND i.platform = c.target_platform
CROSS JOIN (SELECT (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-08-01' AND `date` < '2026-09-01') AS chi_tong,
                   (SELECT COUNT(*) FROM users
                    WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01') AS cai_tong) t
ORDER BY kenh, nen_tang;

-- [jelly-j4-cpi-thang-8-so-muc-chung] wrong: thieu_can_tren_chi_phi
-- Chi phí chỉ có cận dưới: ở hidden-1 dòng chi ngày 1/9/2026 (Social Ads, VN, Android) bị cộng vào tháng 8.
SELECT c.channel AS kenh, c.target_platform AS nen_tang,
       i.so_luot_cai,
       ROUND(c.chi / i.so_luot_cai, 2) AS cpi_usd,
       ROUND(c.chi / i.so_luot_cai - t.chi_tong / t.cai_tong, 2) AS chenh_lech_usd
FROM (SELECT channel, target_platform, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-08-01'
      GROUP BY channel, target_platform) c
JOIN (SELECT channel, platform, COUNT(*) AS so_luot_cai
      FROM users
      WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
      GROUP BY channel, platform) i
  ON i.channel = c.channel AND i.platform = c.target_platform
CROSS JOIN (SELECT (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-08-01') AS chi_tong,
                   (SELECT COUNT(*) FROM users
                    WHERE install_date >= '2026-08-01' AND install_date < '2026-09-01'
                      AND channel <> 'Organic') AS cai_tong) t
ORDER BY kenh, nen_tang;

-- [jelly-j5-booster-theo-the-gioi] solution
SELECT m.world_name, b.booster_type, COUNT(*) AS so_lan_dung
FROM booster_events b
JOIN level_metadata m ON m.level_id = b.level_id
GROUP BY m.episode, m.world_name, b.booster_type
ORDER BY m.episode, so_lan_dung DESC, b.booster_type;

-- [jelly-j5-booster-theo-the-gioi] wrong: noi_qua_phien_nhan_dong
-- Đi qua bảng lượt chơi theo phiên và màn: một phiên chơi lại một màn nhiều lần nên mỗi lần dùng bị đếm lặp.
SELECT la.world_name, b.booster_type, COUNT(*) AS so_lan_dung
FROM booster_events b
JOIN level_attempts la ON la.session_id = b.session_id AND la.level_id = b.level_id
GROUP BY la.episode, la.world_name, b.booster_type
ORDER BY la.episode, so_lan_dung DESC, b.booster_type;

-- [jelly-j5-booster-theo-the-gioi] wrong: sap_ten_the_gioi
SELECT m.world_name, b.booster_type, COUNT(*) AS so_lan_dung
FROM booster_events b
JOIN level_metadata m ON m.level_id = b.level_id
GROUP BY m.world_name, b.booster_type
ORDER BY m.world_name, so_lan_dung DESC, b.booster_type;

-- [jelly-j6-phien-co-mua] solution
SELECT s.entry_screen AS man_hinh_vao,
       COUNT(DISTINCT s.session_id) AS so_phien,
       COUNT(DISTINCT p.session_id) AS so_phien_co_mua,
       ROUND(100 * COUNT(DISTINCT p.session_id) / COUNT(DISTINCT s.session_id), 2) AS ty_le_pct
FROM sessions s
LEFT JOIN purchases p ON p.session_id = s.session_id
WHERE s.event_date >= '2026-07-01' AND s.event_date < '2026-08-01'
GROUP BY s.entry_screen
ORDER BY ty_le_pct DESC, man_hinh_vao;

-- [jelly-j6-phien-co-mua] wrong: count_sao_o_tu_so
SELECT s.entry_screen AS man_hinh_vao,
       COUNT(*) AS so_phien,
       COUNT(*) AS so_phien_co_mua,
       ROUND(100 * COUNT(*) / COUNT(*), 2) AS ty_le_pct
FROM sessions s
LEFT JOIN purchases p ON p.session_id = s.session_id
WHERE s.event_date >= '2026-07-01' AND s.event_date < '2026-08-01'
GROUP BY s.entry_screen
ORDER BY ty_le_pct DESC, man_hinh_vao;

-- [jelly-j6-phien-co-mua] wrong: inner_join_mat_mau_so
SELECT s.entry_screen AS man_hinh_vao,
       COUNT(DISTINCT s.session_id) AS so_phien,
       COUNT(DISTINCT p.session_id) AS so_phien_co_mua,
       ROUND(100 * COUNT(DISTINCT p.session_id) / COUNT(DISTINCT s.session_id), 2) AS ty_le_pct
FROM sessions s
JOIN purchases p ON p.session_id = s.session_id
WHERE s.event_date >= '2026-07-01' AND s.event_date < '2026-08-01'
GROUP BY s.entry_screen
ORDER BY ty_le_pct DESC, man_hinh_vao;

-- [jelly-j7-join-nhan-dong] starter
SELECT cs.channel AS kenh, ROUND(SUM(pd.ad_revenue), 2) AS doanh_thu_qc_usd
FROM player_daily pd
JOIN campaign_spend cs ON cs.campaign_id = pd.campaign_id AND cs.`date` = pd.activity_date
WHERE pd.activity_date >= '2026-07-01' AND pd.activity_date < '2026-08-01'
GROUP BY cs.channel
ORDER BY doanh_thu_qc_usd DESC;

-- [jelly-j7-join-nhan-dong] solution
SELECT u.channel AS kenh, ROUND(SUM(pd.ad_revenue), 2) AS doanh_thu_qc_usd
FROM player_daily pd
JOIN users u ON u.user_id = pd.user_id
WHERE pd.activity_date >= '2026-07-01' AND pd.activity_date < '2026-08-01'
GROUP BY u.channel
ORDER BY doanh_thu_qc_usd DESC;

-- [jelly-j7-join-nhan-dong] wrong: sum_distinct
SELECT cs.channel AS kenh, ROUND(SUM(DISTINCT pd.ad_revenue), 2) AS doanh_thu_qc_usd
FROM player_daily pd
JOIN campaign_spend cs ON cs.campaign_id = pd.campaign_id AND cs.`date` = pd.activity_date
WHERE pd.activity_date >= '2026-07-01' AND pd.activity_date < '2026-08-01'
GROUP BY cs.channel
ORDER BY doanh_thu_qc_usd DESC;

-- [jelly-j7-join-nhan-dong] wrong: left_join_van_nhan_dong
SELECT pd.channel AS kenh, ROUND(SUM(pd.ad_revenue), 2) AS doanh_thu_qc_usd
FROM player_daily pd
LEFT JOIN campaign_spend cs ON cs.campaign_id = pd.campaign_id AND cs.`date` = pd.activity_date
WHERE pd.activity_date >= '2026-07-01' AND pd.activity_date < '2026-08-01'
GROUP BY pd.channel
ORDER BY doanh_thu_qc_usd DESC;

-- [jelly-j8-left-join-where] starter
SELECT u.platform AS nen_tang,
       COUNT(DISTINCT u.user_id) AS so_nguoi_choi,
       COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END) AS so_chua_den_buoc_5,
       ROUND(100 * COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END)
             / COUNT(DISTINCT u.user_id), 2) AS ty_le_pct
FROM users u
LEFT JOIN tutorial_steps t ON t.user_id = u.user_id
WHERE t.step_id = 5
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-j8-left-join-where] solution
SELECT u.platform AS nen_tang,
       COUNT(DISTINCT u.user_id) AS so_nguoi_choi,
       COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END) AS so_chua_den_buoc_5,
       ROUND(100 * COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END)
             / COUNT(DISTINCT u.user_id), 2) AS ty_le_pct
FROM users u
LEFT JOIN tutorial_steps t ON t.user_id = u.user_id AND t.step_id = 5
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-j8-left-join-where] wrong: nhom_theo_nen_tang_bang_phai
-- Đã đưa điều kiện vào ON nhưng gom theo t.platform: người không có dòng bước 5 rơi vào nhóm NULL.
SELECT t.platform AS nen_tang,
       COUNT(DISTINCT u.user_id) AS so_nguoi_choi,
       COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END) AS so_chua_den_buoc_5,
       ROUND(100 * COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END)
             / COUNT(DISTINCT u.user_id), 2) AS ty_le_pct
FROM users u
LEFT JOIN tutorial_steps t ON t.user_id = u.user_id AND t.step_id = 5
GROUP BY t.platform
ORDER BY nen_tang;

-- [jelly-j8-left-join-where] wrong: chi_tinh_buoc_5_hoan_thanh
SELECT u.platform AS nen_tang,
       COUNT(DISTINCT u.user_id) AS so_nguoi_choi,
       COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END) AS so_chua_den_buoc_5,
       ROUND(100 * COUNT(DISTINCT CASE WHEN t.user_id IS NULL THEN u.user_id END)
             / COUNT(DISTINCT u.user_id), 2) AS ty_le_pct
FROM users u
LEFT JOIN tutorial_steps t ON t.user_id = u.user_id AND t.step_id = 5 AND t.step_completed = 1
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-j9-noi-sai-khoa] starter
SELECT la.attempt_id, la.level_id, s.session_id, s.entry_screen, s.duration_minutes
FROM level_attempts la
JOIN sessions s ON s.user_id = la.user_id AND s.event_date = la.event_date
WHERE la.result = 'crash' AND la.event_date = '2026-08-28'
ORDER BY la.attempt_id, s.session_id;

-- [jelly-j9-noi-sai-khoa] solution
SELECT la.attempt_id, la.level_id, s.session_id, s.entry_screen, s.duration_minutes
FROM level_attempts la
JOIN sessions s ON s.session_id = la.session_id
WHERE la.result = 'crash' AND la.event_date = '2026-08-28'
ORDER BY la.attempt_id, s.session_id;

-- [jelly-j9-noi-sai-khoa] wrong: lay_phien_dau_ngay
-- Gom theo lượt chơi để hết lặp dòng, nhưng phiên gắn vào là phiên có mã nhỏ nhất trong ngày, không phải phiên chứa lượt chơi.
SELECT la.attempt_id, la.level_id, MIN(s.session_id) AS session_id,
       MIN(s.entry_screen) AS entry_screen, MIN(s.duration_minutes) AS duration_minutes
FROM level_attempts la
JOIN sessions s ON s.user_id = la.user_id AND s.event_date = la.event_date
WHERE la.result = 'crash' AND la.event_date = '2026-08-28'
GROUP BY la.attempt_id, la.level_id
ORDER BY la.attempt_id;

-- ################################################################ MODULE 6 · SUBQUERIES

-- [jelly-q1-man-thua-tren-tb] solution
SELECT la.level_id, m.difficulty_tag, COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN la.result = 'fail_out_of_moves' THEN 1 END) / COUNT(*), 2) AS ty_le_thua_pct
FROM level_attempts la
JOIN level_metadata m ON m.level_id = la.level_id
WHERE la.event_date <= '2026-08-29'
GROUP BY la.level_id, m.difficulty_tag
HAVING COUNT(CASE WHEN la.result = 'fail_out_of_moves' THEN 1 END) / COUNT(*) >
       (SELECT COUNT(CASE WHEN result = 'fail_out_of_moves' THEN 1 END) / COUNT(*)
        FROM level_attempts
        WHERE event_date <= '2026-08-29')
ORDER BY ty_le_thua_pct DESC, la.level_id;

-- [jelly-q1-man-thua-tren-tb] wrong: so_voi_trung_binh_cac_man
-- Lấy trung bình của tỷ lệ từng màn làm mức chung: màn ít lượt có trọng số như màn nhiều lượt.
SELECT la.level_id, m.difficulty_tag, COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN la.result = 'fail_out_of_moves' THEN 1 END) / COUNT(*), 2) AS ty_le_thua_pct
FROM level_attempts la
JOIN level_metadata m ON m.level_id = la.level_id
WHERE la.event_date <= '2026-08-29'
GROUP BY la.level_id, m.difficulty_tag
HAVING COUNT(CASE WHEN la.result = 'fail_out_of_moves' THEN 1 END) / COUNT(*) >
       (SELECT AVG(r) FROM (SELECT COUNT(CASE WHEN result = 'fail_out_of_moves' THEN 1 END) / COUNT(*) AS r
                            FROM level_attempts
                            WHERE event_date <= '2026-08-29'
                            GROUP BY level_id) t)
ORDER BY ty_le_thua_pct DESC, la.level_id;

-- [jelly-q1-man-thua-tren-tb] wrong: mau_so_chi_thang_thua
SELECT la.level_id, m.difficulty_tag, COUNT(*) AS so_luot,
       ROUND(100 * COUNT(CASE WHEN la.result = 'fail_out_of_moves' THEN 1 END)
             / COUNT(CASE WHEN la.result IN ('complete', 'fail_out_of_moves') THEN 1 END), 2) AS ty_le_thua_pct
FROM level_attempts la
JOIN level_metadata m ON m.level_id = la.level_id
WHERE la.event_date <= '2026-08-29'
GROUP BY la.level_id, m.difficulty_tag
HAVING COUNT(CASE WHEN la.result = 'fail_out_of_moves' THEN 1 END)
       / COUNT(CASE WHEN la.result IN ('complete', 'fail_out_of_moves') THEN 1 END) >
       (SELECT COUNT(CASE WHEN result = 'fail_out_of_moves' THEN 1 END)
               / COUNT(CASE WHEN result IN ('complete', 'fail_out_of_moves') THEN 1 END)
        FROM level_attempts
        WHERE event_date <= '2026-08-29')
ORDER BY ty_le_thua_pct DESC, la.level_id;

-- [jelly-q2-nguoi-mua-season-pass] solution
SELECT u.country AS quoc_gia, u.channel AS kenh, COUNT(*) AS so_nguoi_choi
FROM users u
WHERE u.user_id IN (SELECT p.user_id FROM purchases p WHERE p.product_type = 'season_pass')
GROUP BY u.country, u.channel
ORDER BY so_nguoi_choi DESC, quoc_gia, kenh;

-- [jelly-q2-nguoi-mua-season-pass] wrong: join_dem_trung
-- Nối thẳng với giao dịch: người mua Season Pass hai lần bị đếm hai lần.
SELECT u.country AS quoc_gia, u.channel AS kenh, COUNT(*) AS so_nguoi_choi
FROM users u
JOIN purchases p ON p.user_id = u.user_id
WHERE p.product_type = 'season_pass'
GROUP BY u.country, u.channel
ORDER BY so_nguoi_choi DESC, quoc_gia, kenh;

-- [jelly-q2-nguoi-mua-season-pass] wrong: quen_dieu_kien_goi
-- Truy vấn con quên điều kiện gói: đếm mọi người chơi trả tiền.
SELECT u.country AS quoc_gia, u.channel AS kenh, COUNT(*) AS so_nguoi_choi
FROM users u
WHERE u.user_id IN (SELECT p.user_id FROM purchases p)
GROUP BY u.country, u.channel
ORDER BY so_nguoi_choi DESC, quoc_gia, kenh;

-- [jelly-q3-choi-d0-tren-tb-29-8] solution
SELECT user_id, platform, playtime_minutes
FROM player_daily
WHERE install_date = '2026-08-29' AND cohort_day = 0
  AND playtime_minutes > (SELECT AVG(playtime_minutes) FROM player_daily
                          WHERE install_date = '2026-08-29' AND cohort_day = 0)
ORDER BY playtime_minutes DESC, user_id;

-- [jelly-q3-choi-d0-tren-tb-29-8] wrong: truy_van_con_thieu_dieu_kien
-- Truy vấn con không lọc nhóm: so với thời gian chơi bình quân của mọi dòng player_daily.
SELECT user_id, platform, playtime_minutes
FROM player_daily
WHERE install_date = '2026-08-29' AND cohort_day = 0
  AND playtime_minutes > (SELECT AVG(playtime_minutes) FROM player_daily)
ORDER BY playtime_minutes DESC, user_id;

-- [jelly-q3-choi-d0-tren-tb-29-8] wrong: loc_ngay_hoat_dong
-- Lọc ngày hoạt động 29/8 thay cho ngày cài: lẫn người chơi cài từ trước.
SELECT user_id, platform, playtime_minutes
FROM player_daily
WHERE activity_date = '2026-08-29'
  AND playtime_minutes > (SELECT AVG(playtime_minutes) FROM player_daily
                          WHERE activity_date = '2026-08-29')
ORDER BY playtime_minutes DESC, user_id;

-- [jelly-q4-ngay-dau-tren-tb-thang] solution
SELECT k.`date` AS ngay, k.dau,
       ROUND((SELECT AVG(k2.dau) FROM daily_kpi k2
              WHERE DATE_FORMAT(k2.`date`, '%Y-%m') = DATE_FORMAT(k.`date`, '%Y-%m')
                AND k2.`date` <= '2026-08-29'), 1) AS dau_tb_thang
FROM daily_kpi k
WHERE k.`date` <= '2026-08-29'
  AND k.dau > (SELECT AVG(k2.dau) FROM daily_kpi k2
               WHERE DATE_FORMAT(k2.`date`, '%Y-%m') = DATE_FORMAT(k.`date`, '%Y-%m')
                 AND k2.`date` <= '2026-08-29')
ORDER BY ngay;

-- [jelly-q4-ngay-dau-tren-tb-thang] wrong: binh_quan_ca_ky
-- Truy vấn con không tương quan: so mọi ngày với bình quân của cả hai tháng.
SELECT k.`date` AS ngay, k.dau,
       ROUND((SELECT AVG(k2.dau) FROM daily_kpi k2 WHERE k2.`date` <= '2026-08-29'), 1) AS dau_tb_thang
FROM daily_kpi k
WHERE k.`date` <= '2026-08-29'
  AND k.dau > (SELECT AVG(k2.dau) FROM daily_kpi k2 WHERE k2.`date` <= '2026-08-29')
ORDER BY ngay;

-- [jelly-q5-roas-duoi-muc-chung] solution
SELECT r.campaign_id, r.channel AS kenh,
       ROUND(100 * r.doanh_thu / c.chi, 2) AS roas_d30_pct,
       ROUND(100 * g.doanh_thu / g.chi, 2) AS roas_chung_pct,
       ROUND(100 * r.doanh_thu / c.chi - 100 * g.doanh_thu / g.chi, 2) AS chenh_lech_diem
FROM (SELECT u.campaign_id, u.channel, SUM(pd.iap_revenue + pd.ad_revenue) AS doanh_thu
      FROM users u
      JOIN player_daily pd ON pd.user_id = u.user_id
      WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
        AND u.channel <> 'Organic' AND pd.cohort_day BETWEEN 0 AND 29
      GROUP BY u.campaign_id, u.channel) r
JOIN (SELECT campaign_id, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
      GROUP BY campaign_id) c ON c.campaign_id = r.campaign_id
CROSS JOIN (SELECT (SELECT SUM(pd.iap_revenue + pd.ad_revenue)
                    FROM player_daily pd
                    JOIN users u ON u.user_id = pd.user_id
                    WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
                      AND u.channel <> 'Organic' AND pd.cohort_day BETWEEN 0 AND 29) AS doanh_thu,
                   (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01') AS chi) g
WHERE r.doanh_thu / c.chi < g.doanh_thu / g.chi
ORDER BY chenh_lech_diem, r.campaign_id;

-- [jelly-q5-roas-duoi-muc-chung] wrong: muc_chung_trung_binh_ty_le
-- Mức chung lấy trung bình ROAS của bốn chiến dịch, không phải tổng doanh thu chia tổng chi phí.
SELECT t.campaign_id, t.kenh,
       ROUND(t.roas, 2) AS roas_d30_pct,
       ROUND(t.muc_chung, 2) AS roas_chung_pct,
       ROUND(t.roas - t.muc_chung, 2) AS chenh_lech_diem
FROM (SELECT r.campaign_id, r.channel AS kenh,
             100 * r.doanh_thu / c.chi AS roas,
             AVG(100 * r.doanh_thu / c.chi) OVER () AS muc_chung
      FROM (SELECT u.campaign_id, u.channel, SUM(pd.iap_revenue + pd.ad_revenue) AS doanh_thu
            FROM users u
            JOIN player_daily pd ON pd.user_id = u.user_id
            WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
              AND u.channel <> 'Organic' AND pd.cohort_day BETWEEN 0 AND 29
            GROUP BY u.campaign_id, u.channel) r
      JOIN (SELECT campaign_id, SUM(spend_usd) AS chi
            FROM campaign_spend
            WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
            GROUP BY campaign_id) c ON c.campaign_id = r.campaign_id) t
WHERE t.roas < t.muc_chung
ORDER BY chenh_lech_diem, t.campaign_id;

-- [jelly-q5-roas-duoi-muc-chung] wrong: ghep_hai_muc_hat
-- Gom doanh thu D0--D29 theo người chơi rồi nối thẳng với từng dòng chi phí của chiến dịch:
-- chi phí bị cộng lặp theo số người cài, doanh thu bị cộng lặp theo số dòng chi.
SELECT u.campaign_id, u.channel AS kenh,
       ROUND(100 * SUM(pd.doanh_thu) / SUM(cs.spend_usd), 2) AS roas_d30_pct,
       ROUND(100 * MAX(g.doanh_thu / g.chi), 2) AS roas_chung_pct,
       ROUND(100 * SUM(pd.doanh_thu) / SUM(cs.spend_usd) - 100 * MAX(g.doanh_thu / g.chi), 2) AS chenh_lech_diem
FROM users u
JOIN (SELECT user_id, SUM(iap_revenue + ad_revenue) AS doanh_thu
      FROM player_daily
      WHERE cohort_day BETWEEN 0 AND 29
      GROUP BY user_id) pd ON pd.user_id = u.user_id
JOIN campaign_spend cs ON cs.campaign_id = u.campaign_id
CROSS JOIN (SELECT (SELECT SUM(pd2.iap_revenue + pd2.ad_revenue)
                    FROM player_daily pd2
                    JOIN users u2 ON u2.user_id = pd2.user_id
                    WHERE u2.install_date >= '2026-07-01' AND u2.install_date < '2026-08-01'
                      AND u2.channel <> 'Organic' AND pd2.cohort_day BETWEEN 0 AND 29) AS doanh_thu,
                   (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01') AS chi) g
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
  AND cs.`date` >= '2026-07-01' AND cs.`date` < '2026-08-01'
GROUP BY u.campaign_id, u.channel
HAVING SUM(pd.doanh_thu) / SUM(cs.spend_usd) < MAX(g.doanh_thu / g.chi)
ORDER BY chenh_lech_diem, u.campaign_id;

-- [jelly-q5-roas-duoi-muc-chung] wrong: doanh_thu_ca_ky
-- Doanh thu lấy mọi ngày tới 29/8, không giới hạn D0--D29 (người cài đầu tháng 7 được tính gần 60 ngày).
SELECT r.campaign_id, r.channel AS kenh,
       ROUND(100 * r.doanh_thu / c.chi, 2) AS roas_d30_pct,
       ROUND(100 * g.doanh_thu / g.chi, 2) AS roas_chung_pct,
       ROUND(100 * r.doanh_thu / c.chi - 100 * g.doanh_thu / g.chi, 2) AS chenh_lech_diem
FROM (SELECT u.campaign_id, u.channel, SUM(pd.iap_revenue + pd.ad_revenue) AS doanh_thu
      FROM users u
      JOIN player_daily pd ON pd.user_id = u.user_id
      WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
        AND u.channel <> 'Organic' AND pd.activity_date <= '2026-08-29'
      GROUP BY u.campaign_id, u.channel) r
JOIN (SELECT campaign_id, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
      GROUP BY campaign_id) c ON c.campaign_id = r.campaign_id
CROSS JOIN (SELECT (SELECT SUM(pd.iap_revenue + pd.ad_revenue)
                    FROM player_daily pd
                    JOIN users u ON u.user_id = pd.user_id
                    WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
                      AND u.channel <> 'Organic' AND pd.activity_date <= '2026-08-29') AS doanh_thu,
                   (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01') AS chi) g
WHERE r.doanh_thu / c.chi < g.doanh_thu / g.chi
ORDER BY chenh_lech_diem, r.campaign_id;

-- [jelly-q5-roas-duoi-muc-chung] wrong: muc_chung_gom_organic
-- Tử số của mức chung cộng cả doanh thu người chơi tự nhiên (không có chi phí): mức chung cao lên, cả bốn chiến dịch bị giữ.
SELECT r.campaign_id, r.channel AS kenh,
       ROUND(100 * r.doanh_thu / c.chi, 2) AS roas_d30_pct,
       ROUND(100 * g.doanh_thu / g.chi, 2) AS roas_chung_pct,
       ROUND(100 * r.doanh_thu / c.chi - 100 * g.doanh_thu / g.chi, 2) AS chenh_lech_diem
FROM (SELECT u.campaign_id, u.channel, SUM(pd.iap_revenue + pd.ad_revenue) AS doanh_thu
      FROM users u
      JOIN player_daily pd ON pd.user_id = u.user_id
      WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
        AND u.channel <> 'Organic' AND pd.cohort_day BETWEEN 0 AND 29
      GROUP BY u.campaign_id, u.channel) r
JOIN (SELECT campaign_id, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
      GROUP BY campaign_id) c ON c.campaign_id = r.campaign_id
CROSS JOIN (SELECT (SELECT SUM(pd.iap_revenue + pd.ad_revenue)
                    FROM player_daily pd
                    JOIN users u ON u.user_id = pd.user_id
                    WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
                      AND pd.cohort_day BETWEEN 0 AND 29) AS doanh_thu,
                   (SELECT SUM(spend_usd) FROM campaign_spend
                    WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01') AS chi) g
WHERE r.doanh_thu / c.chi < g.doanh_thu / g.chi
ORDER BY chenh_lech_diem, r.campaign_id;

-- [jelly-q6-nguoi-choi-cu-len-210] solution
SELECT u.platform AS nen_tang,
       COUNT(*) AS so_nguoi_choi_cu,
       COUNT(l.ngay_len) AS so_len_210,
       ROUND(100 * COUNT(l.ngay_len) / COUNT(*), 2) AS ty_le_len_210_pct,
       ROUND(AVG(DATEDIFF(l.ngay_len, '2026-07-30')), 2) AS so_ngay_cho_tb
FROM users u
LEFT JOIN (SELECT user_id, MIN(activity_date) AS ngay_len
           FROM player_daily
           WHERE app_version = '2.1.0' AND activity_date <= '2026-08-29'
           GROUP BY user_id) l ON l.user_id = u.user_id
WHERE u.app_version_install = '2.0.2'
  AND EXISTS (SELECT 1 FROM player_daily p
              WHERE p.user_id = u.user_id
                AND p.activity_date >= '2026-07-30' AND p.activity_date <= '2026-08-29')
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-q6-nguoi-choi-cu-len-210] wrong: tinh_ca_nguoi_cai_moi
-- Không lọc phiên bản lúc cài: người cài mới trên bản 2.1.0, 2.1.1 cũng thành người chơi cũ.
SELECT u.platform AS nen_tang,
       COUNT(*) AS so_nguoi_choi_cu,
       COUNT(l.ngay_len) AS so_len_210,
       ROUND(100 * COUNT(l.ngay_len) / COUNT(*), 2) AS ty_le_len_210_pct,
       ROUND(AVG(DATEDIFF(l.ngay_len, '2026-07-30')), 2) AS so_ngay_cho_tb
FROM users u
LEFT JOIN (SELECT user_id, MIN(activity_date) AS ngay_len
           FROM player_daily
           WHERE app_version = '2.1.0' AND activity_date <= '2026-08-29'
           GROUP BY user_id) l ON l.user_id = u.user_id
WHERE EXISTS (SELECT 1 FROM player_daily p
              WHERE p.user_id = u.user_id
                AND p.activity_date >= '2026-07-30' AND p.activity_date <= '2026-08-29')
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-q6-nguoi-choi-cu-len-210] wrong: len_ban_bat_ky
-- Coi mọi bản khác 2.0.2 là đã lên 2.1.0: người lên thẳng 2.1.1 cũng bị đếm.
SELECT u.platform AS nen_tang,
       COUNT(*) AS so_nguoi_choi_cu,
       COUNT(l.ngay_len) AS so_len_210,
       ROUND(100 * COUNT(l.ngay_len) / COUNT(*), 2) AS ty_le_len_210_pct,
       ROUND(AVG(DATEDIFF(l.ngay_len, '2026-07-30')), 2) AS so_ngay_cho_tb
FROM users u
LEFT JOIN (SELECT user_id, MIN(activity_date) AS ngay_len
           FROM player_daily
           WHERE app_version <> '2.0.2' AND activity_date <= '2026-08-29'
           GROUP BY user_id) l ON l.user_id = u.user_id
WHERE u.app_version_install = '2.0.2'
  AND EXISTS (SELECT 1 FROM player_daily p
              WHERE p.user_id = u.user_id
                AND p.activity_date >= '2026-07-30' AND p.activity_date <= '2026-08-29')
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-q6-nguoi-choi-cu-len-210] wrong: mau_so_gom_nguoi_da_nghi
-- Mẫu số là mọi người cài bản 2.0.2, kể cả người đã nghỉ trước ngày bản mới ra.
SELECT u.platform AS nen_tang,
       COUNT(*) AS so_nguoi_choi_cu,
       COUNT(l.ngay_len) AS so_len_210,
       ROUND(100 * COUNT(l.ngay_len) / COUNT(*), 2) AS ty_le_len_210_pct,
       ROUND(AVG(DATEDIFF(l.ngay_len, '2026-07-30')), 2) AS so_ngay_cho_tb
FROM users u
LEFT JOIN (SELECT user_id, MIN(activity_date) AS ngay_len
           FROM player_daily
           WHERE app_version = '2.1.0' AND activity_date <= '2026-08-29'
           GROUP BY user_id) l ON l.user_id = u.user_id
WHERE u.app_version_install = '2.0.2'
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-q6-nguoi-choi-cu-len-210] wrong: dem_moi_ngay_choi_210
-- Nối mọi ngày chơi bản 2.1.0 thay cho ngày sớm nhất: số người đếm DISTINCT nên đúng, nhưng ngày chờ bình quân tính trên mọi ngày.
SELECT u.platform AS nen_tang,
       COUNT(DISTINCT u.user_id) AS so_nguoi_choi_cu,
       COUNT(DISTINCT p2.user_id) AS so_len_210,
       ROUND(100 * COUNT(DISTINCT p2.user_id) / COUNT(DISTINCT u.user_id), 2) AS ty_le_len_210_pct,
       ROUND(AVG(DATEDIFF(p2.activity_date, '2026-07-30')), 2) AS so_ngay_cho_tb
FROM users u
LEFT JOIN player_daily p2 ON p2.user_id = u.user_id AND p2.app_version = '2.1.0'
                         AND p2.activity_date <= '2026-08-29'
WHERE u.app_version_install = '2.0.2'
  AND EXISTS (SELECT 1 FROM player_daily p
              WHERE p.user_id = u.user_id
                AND p.activity_date >= '2026-07-30' AND p.activity_date <= '2026-08-29')
GROUP BY u.platform
ORDER BY nen_tang;

-- [jelly-q7-exists-quang-cao] starter
SELECT u.channel AS kenh, COUNT(*) AS so_nguoi_xem
FROM users u
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
  AND NOT EXISTS (SELECT 1 FROM ad_events a
                  WHERE a.user_id = u.user_id AND a.ad_type = 'rewarded'
                    AND a.event_date >= '2026-07-01' AND a.event_date < '2026-08-01')
GROUP BY u.channel
ORDER BY so_nguoi_xem DESC, kenh;

-- [jelly-q7-exists-quang-cao] solution
SELECT u.channel AS kenh, COUNT(*) AS so_nguoi_xem
FROM users u
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
  AND EXISTS (SELECT 1 FROM ad_events a
              WHERE a.user_id = u.user_id AND a.ad_type = 'rewarded'
                AND a.event_date >= '2026-07-01' AND a.event_date < '2026-08-01')
GROUP BY u.channel
ORDER BY so_nguoi_xem DESC, kenh;

-- [jelly-q7-exists-quang-cao] wrong: bo_loai_quang_cao
SELECT u.channel AS kenh, COUNT(*) AS so_nguoi_xem
FROM users u
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
  AND EXISTS (SELECT 1 FROM ad_events a
              WHERE a.user_id = u.user_id
                AND a.event_date >= '2026-07-01' AND a.event_date < '2026-08-01')
GROUP BY u.channel
ORDER BY so_nguoi_xem DESC, kenh;

-- [jelly-q7-exists-quang-cao] wrong: join_dem_luot_xem
SELECT u.channel AS kenh, COUNT(*) AS so_nguoi_xem
FROM users u
JOIN ad_events a ON a.user_id = u.user_id
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
  AND a.ad_type = 'rewarded' AND a.event_date >= '2026-07-01' AND a.event_date < '2026-08-01'
GROUP BY u.channel
ORDER BY so_nguoi_xem DESC, kenh;

-- [jelly-q8-giao-dich-ngay-gan-nhat-gb] starter
SELECT p.user_id, p.transaction_id, p.event_time, p.product_name, p.price_usd
FROM purchases p
WHERE p.country = 'GB'
  AND p.event_date = (SELECT MIN(p2.event_date) FROM purchases p2
                      WHERE p2.country = 'GB'
                        AND p2.event_date >= '2026-08-01' AND p2.event_date < '2026-09-01')
ORDER BY p.event_time, p.transaction_id;

-- [jelly-q8-giao-dich-ngay-gan-nhat-gb] solution
SELECT p.user_id, p.transaction_id, p.event_time, p.product_name, p.price_usd
FROM purchases p
WHERE p.country = 'GB'
  AND p.event_date = (SELECT MAX(p2.event_date) FROM purchases p2
                      WHERE p2.country = 'GB'
                        AND p2.event_date >= '2026-08-01' AND p2.event_date < '2026-09-01')
ORDER BY p.event_time, p.transaction_id;

-- [jelly-q8-giao-dich-ngay-gan-nhat-gb] wrong: thieu_can_tren
-- Truy vấn con chỉ có cận dưới: ở hidden-1 ngày muộn nhất thành 1/9/2026.
SELECT p.user_id, p.transaction_id, p.event_time, p.product_name, p.price_usd
FROM purchases p
WHERE p.country = 'GB'
  AND p.event_date = (SELECT MAX(p2.event_date) FROM purchases p2
                      WHERE p2.country = 'GB' AND p2.event_date >= '2026-08-01')
ORDER BY p.event_time, p.transaction_id;

-- [jelly-q8-giao-dich-ngay-gan-nhat-gb] wrong: gio_muon_nhat
-- So theo thời điểm muộn nhất thay cho ngày muộn nhất: chỉ còn một giao dịch.
SELECT p.user_id, p.transaction_id, p.event_time, p.product_name, p.price_usd
FROM purchases p
WHERE p.country = 'GB'
  AND p.event_time = (SELECT MAX(p2.event_time) FROM purchases p2
                      WHERE p2.country = 'GB'
                        AND p2.event_date >= '2026-08-01' AND p2.event_date < '2026-09-01')
ORDER BY p.event_time, p.transaction_id;

-- [jelly-q9-not-in-null] starter
SELECT m.level_id, COUNT(la.attempt_id) AS so_luot_choi
FROM level_metadata m
LEFT JOIN level_attempts la ON la.level_id = m.level_id AND la.event_date <= '2026-08-29'
WHERE m.level_id NOT IN (SELECT p.level_id_if_relevant FROM purchases p)
GROUP BY m.level_id
ORDER BY m.level_id;

-- [jelly-q9-not-in-null] solution
SELECT m.level_id, COUNT(la.attempt_id) AS so_luot_choi
FROM level_metadata m
LEFT JOIN level_attempts la ON la.level_id = m.level_id AND la.event_date <= '2026-08-29'
WHERE NOT EXISTS (SELECT 1 FROM purchases p WHERE p.level_id_if_relevant = m.level_id)
GROUP BY m.level_id
ORDER BY m.level_id;

-- [jelly-q9-not-in-null] wrong: chi_xet_goi_them_luot_di
SELECT m.level_id, COUNT(la.attempt_id) AS so_luot_choi
FROM level_metadata m
LEFT JOIN level_attempts la ON la.level_id = m.level_id AND la.event_date <= '2026-08-29'
WHERE m.level_id NOT IN (SELECT p.level_id_if_relevant FROM purchases p
                         WHERE p.product_type = 'extra_moves_pack')
GROUP BY m.level_id
ORDER BY m.level_id;

-- [jelly-q9-not-in-null] wrong: not_exists_khong_tuong_quan
SELECT m.level_id, COUNT(la.attempt_id) AS so_luot_choi
FROM level_metadata m
LEFT JOIN level_attempts la ON la.level_id = m.level_id AND la.event_date <= '2026-08-29'
WHERE NOT EXISTS (SELECT 1 FROM purchases p WHERE p.level_id_if_relevant IS NOT NULL)
GROUP BY m.level_id
ORDER BY m.level_id;

-- [jelly-q9-not-in-null] wrong: thieu_can_tren
SELECT m.level_id, COUNT(la.attempt_id) AS so_luot_choi
FROM level_metadata m
LEFT JOIN level_attempts la ON la.level_id = m.level_id
WHERE NOT EXISTS (SELECT 1 FROM purchases p WHERE p.level_id_if_relevant = m.level_id)
GROUP BY m.level_id
ORDER BY m.level_id;

-- ################################################################ CASE STUDY

-- [jelly-c5-starter-pack-giu-chan.b1] solution
SELECT CASE WHEN u.user_id IN (SELECT p.user_id FROM purchases p
                               WHERE p.product_type = 'starter_pack' AND p.event_date <= '2026-08-29')
            THEN 'mua' ELSE 'khong_mua' END AS nhom,
       COUNT(*) AS so_nguoi_choi,
       ROUND(AVG((SELECT COUNT(*) FROM player_daily pd
                  WHERE pd.user_id = u.user_id AND pd.activity_date <= '2026-08-29')), 2) AS so_ngay_hoat_dong_tb
FROM users u
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY nhom
ORDER BY nhom DESC;

-- [jelly-c5-starter-pack-giu-chan.b1] wrong: noi_giao_dich_dem_trung
-- Nối thẳng người chơi với giao dịch Starter Pack: người mua hai lần bị tính hai lần cả ở số người lẫn số ngày.
SELECT CASE WHEN p.user_id IS NULL THEN 'khong_mua' ELSE 'mua' END AS nhom,
       COUNT(*) AS so_nguoi_choi,
       ROUND(AVG((SELECT COUNT(*) FROM player_daily pd
                  WHERE pd.user_id = u.user_id AND pd.activity_date <= '2026-08-29')), 2) AS so_ngay_hoat_dong_tb
FROM users u
LEFT JOIN purchases p ON p.user_id = u.user_id AND p.product_type = 'starter_pack'
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY nhom
ORDER BY nhom DESC;

-- [jelly-c5-starter-pack-giu-chan.b1] wrong: moi_nguoi_choi_ca_ky
-- Không giới hạn nhóm cài tháng 7: người cài cuối tháng 8 có rất ít ngày quan sát.
SELECT CASE WHEN u.user_id IN (SELECT p.user_id FROM purchases p
                               WHERE p.product_type = 'starter_pack' AND p.event_date <= '2026-08-29')
            THEN 'mua' ELSE 'khong_mua' END AS nhom,
       COUNT(*) AS so_nguoi_choi,
       ROUND(AVG((SELECT COUNT(*) FROM player_daily pd
                  WHERE pd.user_id = u.user_id AND pd.activity_date <= '2026-08-29')), 2) AS so_ngay_hoat_dong_tb
FROM users u
GROUP BY nhom
ORDER BY nhom DESC;

-- [jelly-c5-starter-pack-giu-chan.b2] solution
SELECT CASE WHEN s.user_id IS NULL THEN 'khong_mua' ELSE 'mua' END AS nhom,
       COUNT(*) AS so_nguoi_choi,
       ROUND(AVG(d0.playtime_minutes), 2) AS phut_choi_d0_tb,
       ROUND(AVG(DATEDIFF(s.ngay_mua_dau, u.install_date)), 2) AS ngay_mua_sau_cai_tb
FROM users u
JOIN player_daily d0 ON d0.user_id = u.user_id AND d0.cohort_day = 0
LEFT JOIN (SELECT user_id, MIN(event_date) AS ngay_mua_dau
           FROM purchases
           WHERE product_type = 'starter_pack' AND event_date <= '2026-08-29'
           GROUP BY user_id) s ON s.user_id = u.user_id
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY nhom
ORDER BY nhom DESC;

-- [jelly-c5-starter-pack-giu-chan.b2] wrong: noi_giao_dich_nhan_dong
-- Nối thẳng với giao dịch Starter Pack: người mua hai lần bị đếm hai lần.
SELECT CASE WHEN p.user_id IS NULL THEN 'khong_mua' ELSE 'mua' END AS nhom,
       COUNT(*) AS so_nguoi_choi,
       ROUND(AVG(d0.playtime_minutes), 2) AS phut_choi_d0_tb,
       ROUND(AVG(DATEDIFF(p.event_date, u.install_date)), 2) AS ngay_mua_sau_cai_tb
FROM users u
JOIN player_daily d0 ON d0.user_id = u.user_id AND d0.cohort_day = 0
LEFT JOIN purchases p ON p.user_id = u.user_id AND p.product_type = 'starter_pack'
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY nhom
ORDER BY nhom DESC;

-- [jelly-c6-kenh-dang-cat.b1] solution
SELECT c.channel AS kenh, ROUND(c.chi, 2) AS chi_phi_usd, i.so_luot_cai,
       ROUND(c.chi / i.so_luot_cai, 2) AS cpi_usd
FROM (SELECT channel, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
      GROUP BY channel) c
JOIN (SELECT channel, COUNT(*) AS so_luot_cai
      FROM users
      WHERE install_date >= '2026-07-01' AND install_date < '2026-08-01'
      GROUP BY channel) i ON i.channel = c.channel
ORDER BY cpi_usd DESC;

-- [jelly-c6-kenh-dang-cat.b1] wrong: noi_truc_tiep_nhan_dong
SELECT u.channel AS kenh, ROUND(SUM(cs.spend_usd), 2) AS chi_phi_usd, COUNT(DISTINCT u.user_id) AS so_luot_cai,
       ROUND(SUM(cs.spend_usd) / COUNT(DISTINCT u.user_id), 2) AS cpi_usd
FROM users u
JOIN campaign_spend cs ON cs.campaign_id = u.campaign_id
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
  AND cs.`date` >= '2026-07-01' AND cs.`date` < '2026-08-01'
GROUP BY u.channel
ORDER BY cpi_usd DESC;

-- [jelly-c6-kenh-dang-cat.b2] solution
SELECT u.channel AS kenh, COUNT(*) AS so_luot_cai,
       ROUND(SUM(COALESCE(r.doanh_thu, 0)) / COUNT(*), 4) AS doanh_thu_d7_moi_luot_cai_usd
FROM users u
LEFT JOIN (SELECT user_id, SUM(iap_revenue + ad_revenue) AS doanh_thu
           FROM player_daily
           WHERE cohort_day BETWEEN 0 AND 6
           GROUP BY user_id) r ON r.user_id = u.user_id
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY u.channel
ORDER BY doanh_thu_d7_moi_luot_cai_usd DESC;

-- [jelly-c6-kenh-dang-cat.b2] wrong: mau_so_nguoi_co_doanh_thu
-- Chỉ một lỗi: mẫu số là số người có doanh thu trong D0 tới D6 thay cho số lượt cài.
SELECT u.channel AS kenh,
       COUNT(DISTINCT CASE WHEN pd.iap_revenue + pd.ad_revenue > 0 THEN pd.user_id END) AS so_luot_cai,
       ROUND(SUM(pd.iap_revenue + pd.ad_revenue)
             / COUNT(DISTINCT CASE WHEN pd.iap_revenue + pd.ad_revenue > 0 THEN pd.user_id END), 4) AS doanh_thu_d7_moi_luot_cai_usd
FROM users u
JOIN player_daily pd ON pd.user_id = u.user_id AND pd.cohort_day BETWEEN 0 AND 6
WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
GROUP BY u.channel
ORDER BY doanh_thu_d7_moi_luot_cai_usd DESC;

-- [jelly-c6-kenh-dang-cat.b3] solution
SELECT c.channel AS kenh,
       ROUND(c.chi, 2) AS chi_phi_usd,
       ROUND(r.doanh_thu, 2) AS doanh_thu_d7_usd,
       ROUND(100 * r.doanh_thu / c.chi, 2) AS roas_d7_pct
FROM (SELECT channel, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
      GROUP BY channel) c
JOIN (SELECT u.channel, SUM(pd.iap_revenue + pd.ad_revenue) AS doanh_thu
      FROM users u
      JOIN player_daily pd ON pd.user_id = u.user_id AND pd.cohort_day BETWEEN 0 AND 6
      WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
      GROUP BY u.channel) r ON r.channel = c.channel
ORDER BY roas_d7_pct DESC;

-- [jelly-c6-kenh-dang-cat.b3] wrong: doanh_thu_ca_ky
-- Lấy doanh thu tới hết dữ liệu: người cài đầu tháng có nhiều ngày hơn người cài cuối tháng, và ở hidden-1 có thêm ngày 2026-09-01.
SELECT c.channel AS kenh,
       ROUND(c.chi, 2) AS chi_phi_usd,
       ROUND(r.doanh_thu, 2) AS doanh_thu_d7_usd,
       ROUND(100 * r.doanh_thu / c.chi, 2) AS roas_d7_pct
FROM (SELECT channel, SUM(spend_usd) AS chi
      FROM campaign_spend
      WHERE `date` >= '2026-07-01' AND `date` < '2026-08-01'
      GROUP BY channel) c
JOIN (SELECT u.channel, SUM(pd.iap_revenue + pd.ad_revenue) AS doanh_thu
      FROM users u
      JOIN player_daily pd ON pd.user_id = u.user_id
      WHERE u.install_date >= '2026-07-01' AND u.install_date < '2026-08-01'
      GROUP BY u.channel) r ON r.channel = c.channel
ORDER BY roas_d7_pct DESC;
