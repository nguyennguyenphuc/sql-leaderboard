-- solution.sql: gói 2 bộ Supply Chain (scm) · Module 3 String & Date, Module 4 Aggregation, case c3, c4.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên scm (public) và scm_hidden_1 (hidden-1).

-- ================================================================ MODULE 3 · STRING & DATE

-- [scm-s1-don-mua-ve-tre-2016] solution
SELECT po_id, supplier_id, promised_date, received_date,
       DATEDIFF(received_date, promised_date) AS so_ngay_tre
FROM purchase_orders
WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01'
  AND received_date > promised_date
ORDER BY so_ngay_tre DESC, po_id
LIMIT 20;

-- [scm-s1-don-mua-ve-tre-2016] wrong: dao_thu_tu_datediff
-- DATEDIFF(a, b) = a - b; đảo hai đối số ra số âm, sắp giảm dần thành đơn trễ ít nhất.
SELECT po_id, supplier_id, promised_date, received_date,
       DATEDIFF(promised_date, received_date) AS so_ngay_tre
FROM purchase_orders
WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01'
  AND received_date > promised_date
ORDER BY so_ngay_tre DESC, po_id
LIMIT 20;

-- [scm-s2-ngay-cao-diem-2016] solution
SELECT event_name, DATE_FORMAT(`date`, '%d/%m/%Y') AS ngay,
       DAYOFWEEK(`date`) AS thu, tier
FROM event_calendar
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
ORDER BY `date`;

-- [scm-s2-ngay-cao-diem-2016] wrong: sap_theo_chuoi_ngay
-- Sắp theo chuỗi 'dd/mm/yyyy' là sắp theo chữ: 01/12 đứng trước 09/09.
SELECT event_name, DATE_FORMAT(`date`, '%d/%m/%Y') AS ngay,
       DAYOFWEEK(`date`) AS thu, tier
FROM event_calendar
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
ORDER BY ngay;

-- [scm-s2-ngay-cao-diem-2016] wrong: dung_weekday
SELECT event_name, DATE_FORMAT(`date`, '%d/%m/%Y') AS ngay,
       WEEKDAY(`date`) AS thu, tier
FROM event_calendar
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
ORDER BY `date`;

-- [scm-s3-huy-kho-ve-tinh-18-thang] starter
SELECT DATE_FORMAT(MIN(o.order_date), '%Y-%m') AS thang,
       COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-07-01'
GROUP BY MONTH(o.order_date)
ORDER BY thang;

-- [scm-s3-huy-kho-ve-tinh-18-thang] solution
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS thang,
       COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-07-01'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY thang;

-- [scm-s3-huy-kho-ve-tinh-18-thang] wrong: thang_ten_tieng_anh
-- '%M' cho tên tháng tiếng Anh ('2016-January'), sắp theo chữ cái.
SELECT DATE_FORMAT(o.order_date, '%Y-%M') AS thang,
       COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-07-01'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%M')
ORDER BY thang;

-- [scm-s3-huy-kho-ve-tinh-18-thang] wrong: thang_khong_so_0
-- Gom đúng theo năm và tháng nhưng nhãn '2016-1' thiếu số 0, sắp theo chữ cũng lệch.
SELECT CONCAT(YEAR(o.order_date), '-', MONTH(o.order_date)) AS thang,
       COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-07-01'
GROUP BY CONCAT(YEAR(o.order_date), '-', MONTH(o.order_date))
ORDER BY thang;

-- [scm-s4-lui-gio-chot-don] solution
WITH don AS (
  SELECT origin_hub_id, lead_time_total_h,
         CASE WHEN HOUR(created_at) = 17 THEN 1 ELSE 0 END AS khung_17h,
         CASE WHEN HOUR(created_at) = 17
              THEN TIMESTAMPDIFF(SECOND, created_at, picked_at) / 3600 - t1_tao_don_pick_h
              ELSE 0 END AS gio_cho_khung_17h
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
    AND is_cancelled = 0
)
SELECT origin_hub_id, COUNT(*) AS so_don, SUM(khung_17h) AS so_don_khung_17h,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND((SUM(lead_time_total_h) - SUM(gio_cho_khung_17h)) / COUNT(*), 2) AS lead_time_tb_moi
FROM don
GROUP BY origin_hub_id
ORDER BY origin_hub_id;

-- [scm-s4-lui-gio-chot-don] wrong: tinh_ca_don_huy
WITH don AS (
  SELECT origin_hub_id, lead_time_total_h,
         CASE WHEN HOUR(created_at) = 17 THEN 1 ELSE 0 END AS khung_17h,
         CASE WHEN HOUR(created_at) = 17
              THEN TIMESTAMPDIFF(SECOND, created_at, picked_at) / 3600 - t1_tao_don_pick_h
              ELSE 0 END AS gio_cho_khung_17h
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
)
SELECT origin_hub_id, COUNT(*) AS so_don, SUM(khung_17h) AS so_don_khung_17h,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND((SUM(lead_time_total_h) - SUM(gio_cho_khung_17h)) / COUNT(*), 2) AS lead_time_tb_moi
FROM don
GROUP BY origin_hub_id
ORDER BY origin_hub_id;

-- [scm-s4-lui-gio-chot-don] wrong: moi_don_sau_chot_het_cho
-- Coi mọi đơn từ 17 giờ trở đi đều được lấy hàng trong ngày, không chỉ khung 17 giờ.
WITH don AS (
  SELECT origin_hub_id, lead_time_total_h,
         CASE WHEN HOUR(created_at) >= 17 THEN 1 ELSE 0 END AS khung_17h,
         CASE WHEN HOUR(created_at) >= 17
              THEN TIMESTAMPDIFF(SECOND, created_at, picked_at) / 3600 - t1_tao_don_pick_h
              ELSE 0 END AS gio_cho_khung_17h
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
    AND is_cancelled = 0
)
SELECT origin_hub_id, COUNT(*) AS so_don, SUM(khung_17h) AS so_don_khung_17h,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND((SUM(lead_time_total_h) - SUM(gio_cho_khung_17h)) / COUNT(*), 2) AS lead_time_tb_moi
FROM don
GROUP BY origin_hub_id
ORDER BY origin_hub_id;

-- [scm-s4-lui-gio-chot-don] wrong: gio_cho_lam_tron_xuong
-- TIMESTAMPDIFF(HOUR, ...) bỏ phần lẻ của giờ, giờ chờ của mỗi đơn hụt tới gần 1 giờ.
WITH don AS (
  SELECT origin_hub_id, lead_time_total_h,
         CASE WHEN HOUR(created_at) = 17 THEN 1 ELSE 0 END AS khung_17h,
         CASE WHEN HOUR(created_at) = 17
              THEN TIMESTAMPDIFF(HOUR, created_at, picked_at) - t1_tao_don_pick_h
              ELSE 0 END AS gio_cho_khung_17h
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
    AND is_cancelled = 0
)
SELECT origin_hub_id, COUNT(*) AS so_don, SUM(khung_17h) AS so_don_khung_17h,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND((SUM(lead_time_total_h) - SUM(gio_cho_khung_17h)) / COUNT(*), 2) AS lead_time_tb_moi
FROM don
GROUP BY origin_hub_id
ORDER BY origin_hub_id;

-- [scm-s4-lui-gio-chot-don] wrong: chia_cho_don_khung_17h
-- Lấy lead time hiện nay trừ giờ chờ bình quân của riêng đơn khung 17 giờ.
WITH don AS (
  SELECT origin_hub_id, lead_time_total_h,
         CASE WHEN HOUR(created_at) = 17 THEN 1 ELSE 0 END AS khung_17h,
         CASE WHEN HOUR(created_at) = 17
              THEN TIMESTAMPDIFF(SECOND, created_at, picked_at) / 3600 - t1_tao_don_pick_h
              END AS gio_cho_khung_17h
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
    AND is_cancelled = 0
)
SELECT origin_hub_id, COUNT(*) AS so_don, SUM(khung_17h) AS so_don_khung_17h,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND(AVG(lead_time_total_h) - AVG(gio_cho_khung_17h), 2) AS lead_time_tb_moi
FROM don
GROUP BY origin_hub_id
ORDER BY origin_hub_id;

-- [scm-s4-lui-gio-chot-don] wrong: quen_can_tren
-- Rớt ở hidden-1: biến thể có đơn ORD2_01033328 ngày 2017-09-01.
WITH don AS (
  SELECT origin_hub_id, lead_time_total_h,
         CASE WHEN HOUR(created_at) = 17 THEN 1 ELSE 0 END AS khung_17h,
         CASE WHEN HOUR(created_at) = 17
              THEN TIMESTAMPDIFF(SECOND, created_at, picked_at) / 3600 - t1_tao_don_pick_h
              ELSE 0 END AS gio_cho_khung_17h
  FROM orders
  WHERE order_date >= '2017-07-01'
    AND is_cancelled = 0
)
SELECT origin_hub_id, COUNT(*) AS so_don, SUM(khung_17h) AS so_don_khung_17h,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND((SUM(lead_time_total_h) - SUM(gio_cho_khung_17h)) / COUNT(*), 2) AS lead_time_tb_moi
FROM don
GROUP BY origin_hub_id
ORDER BY origin_hub_id;

-- [scm-s5-ban-theo-thu-cua-hang-44] solution
SELECT DAYOFWEEK(s.`date`) AS thu, ROUND(SUM(s.unit_sales), 0) AS luong_ban
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44 AND i.family = 'BEVERAGES'
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY DAYOFWEEK(s.`date`)
ORDER BY thu;

-- [scm-s5-ban-theo-thu-cua-hang-44] wrong: quen_can_tren
-- Rớt ở hidden-1: biến thể có một dòng BEVERAGES của cửa hàng 44 ngày 2017-08-01.
SELECT DAYOFWEEK(s.`date`) AS thu, ROUND(SUM(s.unit_sales), 0) AS luong_ban
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44 AND i.family = 'BEVERAGES'
  AND s.`date` >= '2017-07-01'
GROUP BY DAYOFWEEK(s.`date`)
ORDER BY thu;

-- [scm-s5-ban-theo-thu-cua-hang-44] wrong: dung_weekday
SELECT WEEKDAY(s.`date`) AS thu, ROUND(SUM(s.unit_sales), 0) AS luong_ban
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44 AND i.family = 'BEVERAGES'
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY WEEKDAY(s.`date`)
ORDER BY thu;

-- [scm-s6-chuyen-giao-tre-quy-2] solution
SELECT sh.shipment_id, SUBSTRING_INDEX(sh.week, '/', 1) AS tuan_bat_dau,
       sh.store_nbr, st.city,
       ROUND(sh.actual_days - sh.promised_days, 2) AS so_ngay_tre
FROM shipments sh
JOIN stores st ON st.store_nbr = sh.store_nbr
WHERE sh.on_time = 0
  AND SUBSTRING_INDEX(sh.week, '/', 1) >= '2017-04-01'
  AND SUBSTRING_INDEX(sh.week, '/', 1) < '2017-07-01'
ORDER BY tuan_bat_dau, sh.shipment_id;

-- [scm-s6-chuyen-giao-tre-quy-2] wrong: lay_ngay_cuoi_tuan
-- Lấy phần sau dấu '/' (Chủ nhật cuối tuần) nên lệch một tuần ở hai đầu quý.
SELECT sh.shipment_id, SUBSTRING_INDEX(sh.week, '/', -1) AS tuan_bat_dau,
       sh.store_nbr, st.city,
       ROUND(sh.actual_days - sh.promised_days, 2) AS so_ngay_tre
FROM shipments sh
JOIN stores st ON st.store_nbr = sh.store_nbr
WHERE sh.on_time = 0
  AND SUBSTRING_INDEX(sh.week, '/', -1) >= '2017-04-01'
  AND SUBSTRING_INDEX(sh.week, '/', -1) < '2017-07-01'
ORDER BY tuan_bat_dau, sh.shipment_id;

-- [scm-s7-gia-tri-nhan-sai-thu-tu] starter
SELECT CONCAT(YEAR(po.received_date), '-', MONTH(po.received_date)) AS thang,
       ROUND(SUM(po.qty_received * ic.unit_cost), 0) AS gia_tri_nhan
FROM purchase_orders po
JOIN item_costs ic ON ic.item_nbr = po.item_nbr
WHERE po.received_date >= '2016-01-01' AND po.received_date < '2017-01-01'
GROUP BY CONCAT(YEAR(po.received_date), '-', MONTH(po.received_date))
ORDER BY thang;

-- [scm-s7-gia-tri-nhan-sai-thu-tu] solution
SELECT DATE_FORMAT(po.received_date, '%Y-%m') AS thang,
       ROUND(SUM(po.qty_received * ic.unit_cost), 0) AS gia_tri_nhan
FROM purchase_orders po
JOIN item_costs ic ON ic.item_nbr = po.item_nbr
WHERE po.received_date >= '2016-01-01' AND po.received_date < '2017-01-01'
GROUP BY DATE_FORMAT(po.received_date, '%Y-%m')
ORDER BY thang;

-- [scm-s7-gia-tri-nhan-sai-thu-tu] wrong: dung_thu_tu_sai_dang_thang
-- Sắp theo ngày nhận sớm nhất cho đúng thứ tự, nhưng thang vẫn là '2016-1' (không có số 0).
SELECT CONCAT(YEAR(po.received_date), '-', MONTH(po.received_date)) AS thang,
       ROUND(SUM(po.qty_received * ic.unit_cost), 0) AS gia_tri_nhan
FROM purchase_orders po
JOIN item_costs ic ON ic.item_nbr = po.item_nbr
WHERE po.received_date >= '2016-01-01' AND po.received_date < '2017-01-01'
GROUP BY CONCAT(YEAR(po.received_date), '-', MONTH(po.received_date))
ORDER BY MIN(po.received_date);

-- [scm-s8-von-ton-cuoi-ky-2017] solution
SELECT ym, LAST_DAY(STR_TO_DATE(CONCAT(ym, '-01'), '%Y-%m-%d')) AS ngay_chot,
       ROUND(SUM(inventory_value), 0) AS von_ton
FROM inventory_snapshots
WHERE store_nbr = 1 AND ym >= '2017-01' AND ym <= '2017-07'
GROUP BY ym
ORDER BY ym;

-- [scm-s8-von-ton-cuoi-ky-2017] wrong: chi_bo_ky_2017_08
-- Rớt ở hidden-1: biến thể có thêm kỳ 2017-09 ở cửa hàng 1.
SELECT ym, LAST_DAY(STR_TO_DATE(CONCAT(ym, '-01'), '%Y-%m-%d')) AS ngay_chot,
       ROUND(SUM(inventory_value), 0) AS von_ton
FROM inventory_snapshots
WHERE store_nbr = 1 AND ym >= '2017-01' AND ym <> '2017-08'
GROUP BY ym
ORDER BY ym;

-- [scm-s8-von-ton-cuoi-ky-2017] wrong: lay_ca_thang_chua_du
SELECT ym, LAST_DAY(STR_TO_DATE(CONCAT(ym, '-01'), '%Y-%m-%d')) AS ngay_chot,
       ROUND(SUM(inventory_value), 0) AS von_ton
FROM inventory_snapshots
WHERE store_nbr = 1 AND ym >= '2017-01' AND ym <= '2017-08'
GROUP BY ym
ORDER BY ym;

-- [scm-s9-muc-tang-ngay-cao-diem-2016] starter
WITH don_ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  GROUP BY order_date
),
nen AS (
  SELECT AVG(n.so_don) AS don_nen
  FROM don_ngay n
  WHERE NOT EXISTS (
    SELECT 1 FROM event_calendar e
    WHERE e.`date` >= '2016-01-01' AND e.`date` < '2017-01-01'
      AND n.ngay BETWEEN e.`date` - 2 AND e.`date` + 2)
)
SELECT e.tier, COUNT(*) AS so_ngay,
       ROUND(100 * (AVG(e.demand_multiplier) - 1), 2) AS muc_tang_ke_hoach_pct,
       ROUND(100 * (AVG(n.so_don) / nen.don_nen - 1), 2) AS muc_tang_thuc_te_pct
FROM event_calendar e
JOIN don_ngay n ON n.ngay = e.`date`
CROSS JOIN nen
GROUP BY e.tier, nen.don_nen
ORDER BY muc_tang_ke_hoach_pct DESC, e.tier;

-- [scm-s9-muc-tang-ngay-cao-diem-2016] solution
WITH don_ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  GROUP BY order_date
),
nen AS (
  SELECT AVG(n.so_don) AS don_nen
  FROM don_ngay n
  WHERE NOT EXISTS (
    SELECT 1 FROM event_calendar e
    WHERE n.ngay BETWEEN DATE_SUB(e.`date`, INTERVAL 2 DAY) AND DATE_ADD(e.`date`, INTERVAL 2 DAY))
)
SELECT e.tier, COUNT(*) AS so_ngay,
       ROUND(100 * (AVG(e.demand_multiplier) - 1), 2) AS muc_tang_ke_hoach_pct,
       ROUND(100 * (AVG(n.so_don) / nen.don_nen - 1), 2) AS muc_tang_thuc_te_pct
FROM event_calendar e
JOIN don_ngay n ON n.ngay = e.`date`
CROSS JOIN nen
GROUP BY e.tier, nen.don_nen
ORDER BY muc_tang_ke_hoach_pct DESC, e.tier;

-- [scm-s9-muc-tang-ngay-cao-diem-2016] wrong: chi_sua_cong_tru_ngay
-- Sửa phép cộng trừ ngày nhưng vẫn chỉ xét sự kiện năm 2016: ngày 30, 31/12/2016 còn là ngày nền.
WITH don_ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  GROUP BY order_date
),
nen AS (
  SELECT AVG(n.so_don) AS don_nen
  FROM don_ngay n
  WHERE NOT EXISTS (
    SELECT 1 FROM event_calendar e
    WHERE e.`date` >= '2016-01-01' AND e.`date` < '2017-01-01'
      AND n.ngay BETWEEN DATE_SUB(e.`date`, INTERVAL 2 DAY) AND DATE_ADD(e.`date`, INTERVAL 2 DAY))
)
SELECT e.tier, COUNT(*) AS so_ngay,
       ROUND(100 * (AVG(e.demand_multiplier) - 1), 2) AS muc_tang_ke_hoach_pct,
       ROUND(100 * (AVG(n.so_don) / nen.don_nen - 1), 2) AS muc_tang_thuc_te_pct
FROM event_calendar e
JOIN don_ngay n ON n.ngay = e.`date`
CROSS JOIN nen
GROUP BY e.tier, nen.don_nen
ORDER BY muc_tang_ke_hoach_pct DESC, e.tier;

-- [scm-s9-muc-tang-ngay-cao-diem-2016] wrong: chi_bo_gioi_han_nam
-- Xét mọi sự kiện nhưng vẫn cộng trừ số vào ngày: cửa sổ quanh 2/2/2016 và 1/1/2017 vẫn hỏng.
WITH don_ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  GROUP BY order_date
),
nen AS (
  SELECT AVG(n.so_don) AS don_nen
  FROM don_ngay n
  WHERE NOT EXISTS (
    SELECT 1 FROM event_calendar e
    WHERE n.ngay BETWEEN e.`date` - 2 AND e.`date` + 2)
)
SELECT e.tier, COUNT(*) AS so_ngay,
       ROUND(100 * (AVG(e.demand_multiplier) - 1), 2) AS muc_tang_ke_hoach_pct,
       ROUND(100 * (AVG(n.so_don) / nen.don_nen - 1), 2) AS muc_tang_thuc_te_pct
FROM event_calendar e
JOIN don_ngay n ON n.ngay = e.`date`
CROSS JOIN nen
GROUP BY e.tier, nen.don_nen
ORDER BY muc_tang_ke_hoach_pct DESC, e.tier;

-- [scm-s9-muc-tang-ngay-cao-diem-2016] wrong: nen_la_moi_ngay_khong_su_kien
-- Bỏ hẳn cửa sổ hai ngày: ngày nền gồm cả những ngày sát sự kiện.
WITH don_ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  GROUP BY order_date
),
nen AS (
  SELECT AVG(n.so_don) AS don_nen
  FROM don_ngay n
  WHERE NOT EXISTS (
    SELECT 1 FROM event_calendar e
    WHERE n.ngay = e.`date`)
)
SELECT e.tier, COUNT(*) AS so_ngay,
       ROUND(100 * (AVG(e.demand_multiplier) - 1), 2) AS muc_tang_ke_hoach_pct,
       ROUND(100 * (AVG(n.so_don) / nen.don_nen - 1), 2) AS muc_tang_thuc_te_pct
FROM event_calendar e
JOIN don_ngay n ON n.ngay = e.`date`
CROSS JOIN nen
GROUP BY e.tier, nen.don_nen
ORDER BY muc_tang_ke_hoach_pct DESC, e.tier;

-- ================================================================ MODULE 4 · AGGREGATION

-- [scm-a1-chuyen-giao-theo-dc-2016] solution
SELECT warehouse_id, COUNT(*) AS so_chuyen, SUM(on_time) AS so_chuyen_dung_han
FROM shipments
WHERE week LIKE '2016%'
GROUP BY warehouse_id
ORDER BY warehouse_id;

-- [scm-a1-chuyen-giao-theo-dc-2016] wrong: like_hai_dau
-- '%2016%' lấy thêm tuần 2015-12-28/2016-01-03 (bắt đầu năm 2015).
SELECT warehouse_id, COUNT(*) AS so_chuyen, SUM(on_time) AS so_chuyen_dung_han
FROM shipments
WHERE week LIKE '%2016%'
GROUP BY warehouse_id
ORDER BY warehouse_id;

-- [scm-a1-chuyen-giao-theo-dc-2016] wrong: count_dem_ca_chuyen_tre
-- COUNT(on_time) đếm mọi chuyến có giá trị, kể cả on_time = 0.
SELECT warehouse_id, COUNT(*) AS so_chuyen, COUNT(on_time) AS so_chuyen_dung_han
FROM shipments
WHERE week LIKE '2016%'
GROUP BY warehouse_id
ORDER BY warehouse_id;

-- [scm-a2-dai-chi-so-kho-dich-2017] starter
SELECT dest_hub_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct,
       ROUND(SUM(CASE WHEN is_cancelled = 0 THEN order_value_usd END), 0) AS gmv,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND(100 * AVG(on_time), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01'
GROUP BY dest_hub_id
ORDER BY dest_hub_id;

-- [scm-a2-dai-chi-so-kho-dich-2017] solution
SELECT dest_hub_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct,
       ROUND(SUM(CASE WHEN is_cancelled = 0 THEN order_value_usd END), 0) AS gmv,
       ROUND(AVG(CASE WHEN is_cancelled = 0 THEN lead_time_total_h END), 2) AS lead_time_tb,
       ROUND(100 * AVG(CASE WHEN is_cancelled = 0 THEN on_time END), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
GROUP BY dest_hub_id
ORDER BY dest_hub_id;

-- [scm-a2-dai-chi-so-kho-dich-2017] wrong: loc_don_huy_o_where
-- Lọc đơn huỷ cho mọi chỉ số: tỷ lệ huỷ về 0, số đơn thành số đơn không huỷ.
SELECT dest_hub_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct,
       ROUND(SUM(order_value_usd), 0) AS gmv,
       ROUND(AVG(lead_time_total_h), 2) AS lead_time_tb,
       ROUND(100 * AVG(on_time), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
  AND is_cancelled = 0
GROUP BY dest_hub_id
ORDER BY dest_hub_id;

-- [scm-a2-dai-chi-so-kho-dich-2017] wrong: else_0_trong_avg
-- ELSE 0 đưa đơn huỷ vào mẫu số của AVG với giá trị 0.
SELECT dest_hub_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct,
       ROUND(SUM(CASE WHEN is_cancelled = 0 THEN order_value_usd END), 0) AS gmv,
       ROUND(AVG(CASE WHEN is_cancelled = 0 THEN lead_time_total_h ELSE 0 END), 2) AS lead_time_tb,
       ROUND(100 * AVG(CASE WHEN is_cancelled = 0 THEN on_time ELSE 0 END), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
GROUP BY dest_hub_id
ORDER BY dest_hub_id;

-- [scm-a2-dai-chi-so-kho-dich-2017] wrong: chi_sua_lead_time
SELECT dest_hub_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct,
       ROUND(SUM(CASE WHEN is_cancelled = 0 THEN order_value_usd END), 0) AS gmv,
       ROUND(AVG(CASE WHEN is_cancelled = 0 THEN lead_time_total_h END), 2) AS lead_time_tb,
       ROUND(100 * AVG(on_time), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-09-01'
GROUP BY dest_hub_id
ORDER BY dest_hub_id;

-- [scm-a2-dai-chi-so-kho-dich-2017] wrong: quen_can_tren
-- Sửa đủ hai chỉ số nhưng giữ khoảng ngày mở: rớt ở hidden-1 (đơn ORD2_01033328 ngày 2017-09-01).
SELECT dest_hub_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct,
       ROUND(SUM(CASE WHEN is_cancelled = 0 THEN order_value_usd END), 0) AS gmv,
       ROUND(AVG(CASE WHEN is_cancelled = 0 THEN lead_time_total_h END), 2) AS lead_time_tb,
       ROUND(100 * AVG(CASE WHEN is_cancelled = 0 THEN on_time END), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01'
GROUP BY dest_hub_id
ORDER BY dest_hub_id;

-- [scm-a3-voucher-theo-loai-kho] solution
SELECT h.role, COUNT(*) AS so_don,
       SUM(o.voucher_applied) AS so_don_voucher,
       ROUND(100 * SUM(o.voucher_applied) / COUNT(*), 2) AS ty_le_voucher_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
  AND o.checkout_group = 'manual'
GROUP BY h.role
ORDER BY h.role;

-- [scm-a3-voucher-theo-loai-kho] wrong: noi_theo_kho_xuat
-- Nối theo kho xuất (origin_hub_id) thay kho đích: đơn được xếp sai nhóm.
SELECT h.role, COUNT(*) AS so_don,
       SUM(o.voucher_applied) AS so_don_voucher,
       ROUND(100 * SUM(o.voucher_applied) / COUNT(*), 2) AS ty_le_voucher_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.origin_hub_id
WHERE o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
  AND o.checkout_group = 'manual'
GROUP BY h.role
ORDER BY h.role;

-- [scm-a3-voucher-theo-loai-kho] wrong: quen_can_tren
SELECT h.role, COUNT(*) AS so_don,
       SUM(o.voucher_applied) AS so_don_voucher,
       ROUND(100 * SUM(o.voucher_applied) / COUNT(*), 2) AS ty_le_voucher_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE o.order_date >= '2017-07-01'
  AND o.checkout_group = 'manual'
GROUP BY h.role
ORDER BY h.role;

-- [scm-a3-voucher-theo-loai-kho] wrong: gop_ca_nhom_tu_dong_ap
-- Không lọc nhóm 'manual': nhóm 'auto_apply' luôn có voucher nên tỷ lệ quanh 50%.
SELECT h.role, COUNT(*) AS so_don,
       SUM(o.voucher_applied) AS so_don_voucher,
       ROUND(100 * SUM(o.voucher_applied) / COUNT(*), 2) AS ty_le_voucher_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
GROUP BY h.role
ORDER BY h.role;

-- [scm-a4-cua-hang-vang-khach-2016] solution
SELECT t.store_nbr, st.city, ROUND(AVG(t.transactions), 0) AS gd_tb_ngay
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-01-01'
GROUP BY t.store_nbr, st.city
HAVING AVG(t.transactions) < 1000
ORDER BY gd_tb_ngay, t.store_nbr;

-- [scm-a4-cua-hang-vang-khach-2016] wrong: loc_ngay_bang_where
-- Lọc từng ngày dưới 1.000 trước khi gom: mất ngày đông khách, cửa hàng nào cũng lọt.
SELECT t.store_nbr, st.city, ROUND(AVG(t.transactions), 0) AS gd_tb_ngay
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-01-01'
  AND t.transactions < 1000
GROUP BY t.store_nbr, st.city
ORDER BY gd_tb_ngay, t.store_nbr;

-- [scm-a5-so-ma-ban-cua-hang-44] starter
SELECT i.family, COUNT(*) AS so_ma
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY i.family
ORDER BY so_ma DESC, i.family;

-- [scm-a5-so-ma-ban-cua-hang-44] solution
SELECT i.family, COUNT(DISTINCT s.item_nbr) AS so_ma
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY i.family
ORDER BY so_ma DESC, i.family;

-- [scm-a5-so-ma-ban-cua-hang-44] wrong: dem_ngay_ban
-- Đếm số ngày có bán thay cho số mã hàng.
SELECT i.family, COUNT(DISTINCT s.`date`) AS so_ma
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY i.family
ORDER BY so_ma DESC, i.family;

-- [scm-a6-tong-giao-dich-thang-7-thap] starter
SELECT store_nbr, ROUND(AVG(transactions), 0) AS tong_gd
FROM transactions
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
GROUP BY store_nbr
ORDER BY tong_gd DESC, store_nbr
LIMIT 10;

-- [scm-a6-tong-giao-dich-thang-7-thap] solution
SELECT store_nbr, SUM(transactions) AS tong_gd
FROM transactions
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
GROUP BY store_nbr
ORDER BY tong_gd DESC, store_nbr
LIMIT 10;

-- [scm-a6-tong-giao-dich-thang-7-thap] wrong: dem_so_ngay
-- COUNT(transactions) đếm số ngày có số liệu, không cộng lượt giao dịch.
SELECT store_nbr, COUNT(transactions) AS tong_gd
FROM transactions
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
GROUP BY store_nbr
ORDER BY tong_gd DESC, store_nbr
LIMIT 10;

-- [scm-a7-don-mien-theo-quy-2016] solution
SELECT region,
       SUM(CASE WHEN QUARTER(order_date) = 1 THEN 1 ELSE 0 END) AS quy_1,
       SUM(CASE WHEN QUARTER(order_date) = 2 THEN 1 ELSE 0 END) AS quy_2,
       SUM(CASE WHEN QUARTER(order_date) = 3 THEN 1 ELSE 0 END) AS quy_3,
       SUM(CASE WHEN QUARTER(order_date) = 4 THEN 1 ELSE 0 END) AS quy_4
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  AND is_cancelled = 0
GROUP BY region
ORDER BY region;

-- [scm-a7-don-mien-theo-quy-2016] wrong: count_else_0
-- COUNT đếm cả số 0, nên mỗi cột quý ra tổng số đơn cả năm.
SELECT region,
       COUNT(CASE WHEN QUARTER(order_date) = 1 THEN 1 ELSE 0 END) AS quy_1,
       COUNT(CASE WHEN QUARTER(order_date) = 2 THEN 1 ELSE 0 END) AS quy_2,
       COUNT(CASE WHEN QUARTER(order_date) = 3 THEN 1 ELSE 0 END) AS quy_3,
       COUNT(CASE WHEN QUARTER(order_date) = 4 THEN 1 ELSE 0 END) AS quy_4
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  AND is_cancelled = 0
GROUP BY region
ORDER BY region;

-- [scm-a7-don-mien-theo-quy-2016] wrong: tinh_ca_don_huy
SELECT region,
       SUM(CASE WHEN QUARTER(order_date) = 1 THEN 1 ELSE 0 END) AS quy_1,
       SUM(CASE WHEN QUARTER(order_date) = 2 THEN 1 ELSE 0 END) AS quy_2,
       SUM(CASE WHEN QUARTER(order_date) = 3 THEN 1 ELSE 0 END) AS quy_3,
       SUM(CASE WHEN QUARTER(order_date) = 4 THEN 1 ELSE 0 END) AS quy_4
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
GROUP BY region
ORDER BY region;

-- [scm-a8-bien-ln-gop-nganh-hang] solution
SELECT ic.family,
       ROUND(SUM(inv.sold * ic.unit_price), 0) AS doanh_thu,
       ROUND(100 * SUM(inv.sold * (ic.unit_price - ic.unit_cost)) / SUM(inv.sold * ic.unit_price), 2) AS bien_ln_gop_pct
FROM inventory_snapshots inv
JOIN item_costs ic ON ic.item_nbr = inv.item_nbr
WHERE inv.ym = '2017-07'
GROUP BY ic.family
HAVING SUM(inv.sold * ic.unit_price) >= 1000000
ORDER BY bien_ln_gop_pct, ic.family;

-- [scm-a8-bien-ln-gop-nganh-hang] wrong: trung_binh_bien_tung_ma
-- Trung bình biên của từng dòng khác biên của tổng (không có trọng số theo doanh thu).
SELECT ic.family,
       ROUND(SUM(inv.sold * ic.unit_price), 0) AS doanh_thu,
       ROUND(100 * AVG((ic.unit_price - ic.unit_cost) / ic.unit_price), 2) AS bien_ln_gop_pct
FROM inventory_snapshots inv
JOIN item_costs ic ON ic.item_nbr = inv.item_nbr
WHERE inv.ym = '2017-07'
GROUP BY ic.family
HAVING SUM(inv.sold * ic.unit_price) >= 1000000
ORDER BY bien_ln_gop_pct, ic.family;

-- [scm-a8-bien-ln-gop-nganh-hang] wrong: loc_doanh_thu_bang_where
SELECT ic.family,
       ROUND(SUM(inv.sold * ic.unit_price), 0) AS doanh_thu,
       ROUND(100 * SUM(inv.sold * (ic.unit_price - ic.unit_cost)) / SUM(inv.sold * ic.unit_price), 2) AS bien_ln_gop_pct
FROM inventory_snapshots inv
JOIN item_costs ic ON ic.item_nbr = inv.item_nbr
WHERE inv.ym = '2017-07'
  AND inv.sold * ic.unit_price >= 1000000
GROUP BY ic.family
ORDER BY bien_ln_gop_pct, ic.family;

-- [scm-a9-pheu-don-mua-theo-dc-2016] solution
WITH buoc AS (
  SELECT s.warehouse_id,
         COUNT(*) AS so_don_dat,
         COUNT(CASE WHEN po.received_date <= po.promised_date THEN 1 END) AS so_dung_han,
         COUNT(CASE WHEN po.received_date <= po.promised_date
                     AND po.qty_received = po.qty_ordered THEN 1 END) AS so_du_hang,
         COUNT(CASE WHEN po.received_date <= po.promised_date
                     AND po.qty_received = po.qty_ordered
                     AND po.inspection_result = 'Pass' THEN 1 END) AS so_dat
  FROM purchase_orders po
  JOIN suppliers s ON s.supplier_id = po.supplier_id
  WHERE po.po_date >= '2016-01-01' AND po.po_date < '2017-01-01'
  GROUP BY s.warehouse_id
),
ty_le AS (
  SELECT warehouse_id, so_don_dat,
         100 * so_dung_han / so_don_dat AS tl_dung_han,
         100 * so_du_hang / so_dung_han AS tl_du_hang,
         100 * so_dat / so_du_hang AS tl_dat
  FROM buoc
)
SELECT warehouse_id, so_don_dat,
       ROUND(tl_dung_han, 2) AS ty_le_dung_han_pct,
       ROUND(tl_du_hang, 2) AS ty_le_du_hang_pct,
       ROUND(tl_dat, 2) AS ty_le_dat_pct,
       CASE LEAST(tl_dung_han, tl_du_hang, tl_dat)
            WHEN tl_dung_han THEN 'dung_han'
            WHEN tl_du_hang THEN 'du_hang'
            ELSE 'dat_kiem_dinh' END AS buoc_hut_nhat
FROM ty_le
ORDER BY warehouse_id;

-- [scm-a9-pheu-don-mua-theo-dc-2016] wrong: chia_cho_so_don_dat
-- Mọi tỷ lệ chia cho số đơn đặt, không chia cho bước liền trước.
WITH buoc AS (
  SELECT s.warehouse_id,
         COUNT(*) AS so_don_dat,
         COUNT(CASE WHEN po.received_date <= po.promised_date THEN 1 END) AS so_dung_han,
         COUNT(CASE WHEN po.received_date <= po.promised_date
                     AND po.qty_received = po.qty_ordered THEN 1 END) AS so_du_hang,
         COUNT(CASE WHEN po.received_date <= po.promised_date
                     AND po.qty_received = po.qty_ordered
                     AND po.inspection_result = 'Pass' THEN 1 END) AS so_dat
  FROM purchase_orders po
  JOIN suppliers s ON s.supplier_id = po.supplier_id
  WHERE po.po_date >= '2016-01-01' AND po.po_date < '2017-01-01'
  GROUP BY s.warehouse_id
),
ty_le AS (
  SELECT warehouse_id, so_don_dat,
         100 * so_dung_han / so_don_dat AS tl_dung_han,
         100 * so_du_hang / so_don_dat AS tl_du_hang,
         100 * so_dat / so_don_dat AS tl_dat
  FROM buoc
)
SELECT warehouse_id, so_don_dat,
       ROUND(tl_dung_han, 2) AS ty_le_dung_han_pct,
       ROUND(tl_du_hang, 2) AS ty_le_du_hang_pct,
       ROUND(tl_dat, 2) AS ty_le_dat_pct,
       CASE LEAST(tl_dung_han, tl_du_hang, tl_dat)
            WHEN tl_dung_han THEN 'dung_han'
            WHEN tl_du_hang THEN 'du_hang'
            ELSE 'dat_kiem_dinh' END AS buoc_hut_nhat
FROM ty_le
ORDER BY warehouse_id;

-- [scm-a9-pheu-don-mua-theo-dc-2016] wrong: buoc_khong_long_nhau
-- Mỗi bước chỉ xét điều kiện của riêng nó, không giữ điều kiện của bước trước.
WITH buoc AS (
  SELECT s.warehouse_id,
         COUNT(*) AS so_don_dat,
         COUNT(CASE WHEN po.received_date <= po.promised_date THEN 1 END) AS so_dung_han,
         COUNT(CASE WHEN po.qty_received = po.qty_ordered THEN 1 END) AS so_du_hang,
         COUNT(CASE WHEN po.inspection_result = 'Pass' THEN 1 END) AS so_dat
  FROM purchase_orders po
  JOIN suppliers s ON s.supplier_id = po.supplier_id
  WHERE po.po_date >= '2016-01-01' AND po.po_date < '2017-01-01'
  GROUP BY s.warehouse_id
),
ty_le AS (
  SELECT warehouse_id, so_don_dat,
         100 * so_dung_han / so_don_dat AS tl_dung_han,
         100 * so_du_hang / so_dung_han AS tl_du_hang,
         100 * so_dat / so_du_hang AS tl_dat
  FROM buoc
)
SELECT warehouse_id, so_don_dat,
       ROUND(tl_dung_han, 2) AS ty_le_dung_han_pct,
       ROUND(tl_du_hang, 2) AS ty_le_du_hang_pct,
       ROUND(tl_dat, 2) AS ty_le_dat_pct,
       CASE LEAST(tl_dung_han, tl_du_hang, tl_dat)
            WHEN tl_dung_han THEN 'dung_han'
            WHEN tl_du_hang THEN 'du_hang'
            ELSE 'dat_kiem_dinh' END AS buoc_hut_nhat
FROM ty_le
ORDER BY warehouse_id;

-- [scm-a9-pheu-don-mua-theo-dc-2016] wrong: count_dem_ca_so_0
-- COUNT(điều kiện) đếm cả kết quả 0, mọi bước đều ra 100%.
WITH buoc AS (
  SELECT s.warehouse_id,
         COUNT(*) AS so_don_dat,
         COUNT(po.received_date <= po.promised_date) AS so_dung_han,
         COUNT(po.received_date <= po.promised_date
               AND po.qty_received = po.qty_ordered) AS so_du_hang,
         COUNT(po.received_date <= po.promised_date
               AND po.qty_received = po.qty_ordered
               AND po.inspection_result = 'Pass') AS so_dat
  FROM purchase_orders po
  JOIN suppliers s ON s.supplier_id = po.supplier_id
  WHERE po.po_date >= '2016-01-01' AND po.po_date < '2017-01-01'
  GROUP BY s.warehouse_id
),
ty_le AS (
  SELECT warehouse_id, so_don_dat,
         100 * so_dung_han / so_don_dat AS tl_dung_han,
         100 * so_du_hang / so_dung_han AS tl_du_hang,
         100 * so_dat / so_du_hang AS tl_dat
  FROM buoc
)
SELECT warehouse_id, so_don_dat,
       ROUND(tl_dung_han, 2) AS ty_le_dung_han_pct,
       ROUND(tl_du_hang, 2) AS ty_le_du_hang_pct,
       ROUND(tl_dat, 2) AS ty_le_dat_pct,
       CASE LEAST(tl_dung_han, tl_du_hang, tl_dat)
            WHEN tl_dung_han THEN 'dung_han'
            WHEN tl_du_hang THEN 'du_hang'
            ELSE 'dat_kiem_dinh' END AS buoc_hut_nhat
FROM ty_le
ORDER BY warehouse_id;

-- [scm-a9-pheu-don-mua-theo-dc-2016] wrong: dung_han_nho_hon_ngay_hen
-- Về đúng ngày hẹn vẫn là đúng hạn; '<' loại nhầm các đơn này.
WITH buoc AS (
  SELECT s.warehouse_id,
         COUNT(*) AS so_don_dat,
         COUNT(CASE WHEN po.received_date < po.promised_date THEN 1 END) AS so_dung_han,
         COUNT(CASE WHEN po.received_date < po.promised_date
                     AND po.qty_received = po.qty_ordered THEN 1 END) AS so_du_hang,
         COUNT(CASE WHEN po.received_date < po.promised_date
                     AND po.qty_received = po.qty_ordered
                     AND po.inspection_result = 'Pass' THEN 1 END) AS so_dat
  FROM purchase_orders po
  JOIN suppliers s ON s.supplier_id = po.supplier_id
  WHERE po.po_date >= '2016-01-01' AND po.po_date < '2017-01-01'
  GROUP BY s.warehouse_id
),
ty_le AS (
  SELECT warehouse_id, so_don_dat,
         100 * so_dung_han / so_don_dat AS tl_dung_han,
         100 * so_du_hang / so_dung_han AS tl_du_hang,
         100 * so_dat / so_du_hang AS tl_dat
  FROM buoc
)
SELECT warehouse_id, so_don_dat,
       ROUND(tl_dung_han, 2) AS ty_le_dung_han_pct,
       ROUND(tl_du_hang, 2) AS ty_le_du_hang_pct,
       ROUND(tl_dat, 2) AS ty_le_dat_pct,
       CASE LEAST(tl_dung_han, tl_du_hang, tl_dat)
            WHEN tl_dung_han THEN 'dung_han'
            WHEN tl_du_hang THEN 'du_hang'
            ELSE 'dat_kiem_dinh' END AS buoc_hut_nhat
FROM ty_le
ORDER BY warehouse_id;

-- ================================================================ CASE

-- [scm-c3-kho-giao-tre.b1] solution
SELECT dest_hub_id, COUNT(*) AS so_don,
       COUNT(CASE WHEN on_time = 0 THEN 1 END) AS so_don_tre,
       ROUND(100 * COUNT(CASE WHEN on_time = 0 THEN 1 END) / COUNT(*), 2) AS ty_le_tre_pct
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2016-04-01'
  AND is_cancelled = 0
GROUP BY dest_hub_id
ORDER BY ty_le_tre_pct DESC, dest_hub_id;

-- [scm-c3-kho-giao-tre.b1] wrong: sap_theo_so_don_tre
SELECT dest_hub_id, COUNT(*) AS so_don,
       COUNT(CASE WHEN on_time = 0 THEN 1 END) AS so_don_tre,
       ROUND(100 * COUNT(CASE WHEN on_time = 0 THEN 1 END) / COUNT(*), 2) AS ty_le_tre_pct
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2016-04-01'
  AND is_cancelled = 0
GROUP BY dest_hub_id
ORDER BY so_don_tre DESC, dest_hub_id;

-- [scm-c4-khuyen-mai-cua-hang-44.b1] solution
SELECT onpromotion, COUNT(*) AS so_dong,
       ROUND(AVG(unit_sales), 2) AS luong_ban_tb
FROM sales
WHERE store_nbr = 44
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
GROUP BY onpromotion
ORDER BY onpromotion;

-- [scm-c4-khuyen-mai-cua-hang-44.b1] wrong: quen_can_tren
SELECT onpromotion, COUNT(*) AS so_dong,
       ROUND(AVG(unit_sales), 2) AS luong_ban_tb
FROM sales
WHERE store_nbr = 44
  AND `date` >= '2017-07-01'
GROUP BY onpromotion
ORDER BY onpromotion;

-- [scm-c4-khuyen-mai-cua-hang-44.b2] solution
SELECT i.family,
       ROUND(AVG(CASE WHEN s.onpromotion = 1 THEN s.unit_sales END), 2) AS tb_co_km,
       ROUND(AVG(CASE WHEN s.onpromotion = 0 THEN s.unit_sales END), 2) AS tb_khong_km
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  AND i.family IN ('BEVERAGES', 'CLEANING', 'DAIRY', 'DELI', 'GROCERY I', 'PRODUCE')
GROUP BY i.family
ORDER BY i.family;

-- [scm-c4-khuyen-mai-cua-hang-44.b2] wrong: else_0_trong_avg
-- ELSE 0 đưa các dòng của nhóm kia vào mẫu số của AVG.
SELECT i.family,
       ROUND(AVG(CASE WHEN s.onpromotion = 1 THEN s.unit_sales ELSE 0 END), 2) AS tb_co_km,
       ROUND(AVG(CASE WHEN s.onpromotion = 0 THEN s.unit_sales ELSE 0 END), 2) AS tb_khong_km
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.store_nbr = 44
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  AND i.family IN ('BEVERAGES', 'CLEANING', 'DAIRY', 'DELI', 'GROCERY I', 'PRODUCE')
GROUP BY i.family
ORDER BY i.family;
