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

-- [scm-s3-lo-truot-thang-3-ra-0] starter
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE inspection_result = 'Fail'
  AND DATE_FORMAT(received_date, '%Y-%M') = '2016-03';

-- [scm-s3-lo-truot-thang-3-ra-0] solution
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE inspection_result = 'Fail'
  AND DATE_FORMAT(received_date, '%Y-%m') = '2016-03';

-- [scm-s3-lo-truot-thang-3-ra-0] wrong: quen_loc_nam
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE inspection_result = 'Fail'
  AND MONTH(received_date) = 3;

-- [scm-s4-don-sau-gio-chot-thang-7] solution
SELECT COUNT(*) AS so_don_sau_chot
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND HOUR(created_at) >= 18;

-- [scm-s4-don-sau-gio-chot-thang-7] wrong: lech_moc_gio
-- HOUR(...) > 18 bỏ mất các đơn tạo từ 18:00 tới 18:59.
SELECT COUNT(*) AS so_don_sau_chot
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND HOUR(created_at) > 18;

-- [scm-s4-don-sau-gio-chot-thang-7] wrong: quen_can_tren
SELECT COUNT(*) AS so_don_sau_chot
FROM orders
WHERE order_date >= '2017-07-01'
  AND HOUR(created_at) >= 18;

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
WHERE ym >= '2017-01' AND ym <= '2017-07'
GROUP BY ym
ORDER BY ym;

-- [scm-s8-von-ton-cuoi-ky-2017] wrong: chi_bo_ky_2017_08
-- Rớt ở hidden-1: biến thể có thêm kỳ 2017-09.
SELECT ym, LAST_DAY(STR_TO_DATE(CONCAT(ym, '-01'), '%Y-%m-%d')) AS ngay_chot,
       ROUND(SUM(inventory_value), 0) AS von_ton
FROM inventory_snapshots
WHERE ym >= '2017-01' AND ym <> '2017-08'
GROUP BY ym
ORDER BY ym;

-- [scm-s8-von-ton-cuoi-ky-2017] wrong: lay_ca_thang_chua_du
SELECT ym, LAST_DAY(STR_TO_DATE(CONCAT(ym, '-01'), '%Y-%m-%d')) AS ngay_chot,
       ROUND(SUM(inventory_value), 0) AS von_ton
FROM inventory_snapshots
WHERE ym >= '2017-01' AND ym <= '2017-08'
GROUP BY ym
ORDER BY ym;

-- [scm-s9-huy-cuoi-tuan-kho-ve-tinh] starter
SELECT COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2017-06-01' AND o.order_date < '2017-07-01'
  AND DAYOFWEEK(o.order_date) IN (6, 7);

-- [scm-s9-huy-cuoi-tuan-kho-ve-tinh] solution
SELECT COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2017-06-01' AND o.order_date < '2017-07-01'
  AND DAYOFWEEK(o.order_date) IN (1, 7);

-- [scm-s9-huy-cuoi-tuan-kho-ve-tinh] wrong: weekday_voi_so_cua_dayofweek
-- WEEKDAY đánh số 0 = thứ Hai ... 6 = Chủ nhật; IN (6, 7) chỉ còn Chủ nhật.
SELECT COUNT(*) AS so_don, SUM(o.is_cancelled) AS so_huy,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2017-06-01' AND o.order_date < '2017-07-01'
  AND WEEKDAY(o.order_date) IN (6, 7);

-- ================================================================ MODULE 4 · AGGREGATION

-- [scm-a1-dung-han-theo-dc-2016] solution
SELECT sh.warehouse_id, w.city, COUNT(*) AS so_chuyen,
       ROUND(100 * SUM(sh.on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM shipments sh
JOIN warehouses w ON w.warehouse_id = sh.warehouse_id
WHERE LEFT(sh.week, 4) = '2016'
GROUP BY sh.warehouse_id, w.city
ORDER BY ty_le_dung_han_pct DESC, sh.warehouse_id;

-- [scm-a1-dung-han-theo-dc-2016] wrong: like_2016_lay_tuan_giao_nam
-- '%2016%' lấy cả tuần 2015-12-28/2016-01-03 (bắt đầu năm 2015).
SELECT sh.warehouse_id, w.city, COUNT(*) AS so_chuyen,
       ROUND(100 * SUM(sh.on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM shipments sh
JOIN warehouses w ON w.warehouse_id = sh.warehouse_id
WHERE sh.week LIKE '%2016%'
GROUP BY sh.warehouse_id, w.city
ORDER BY ty_le_dung_han_pct DESC, sh.warehouse_id;

-- [scm-a2-ty-le-lo-truot-100] starter
SELECT po.supplier_id, COUNT(*) AS so_lo,
       ROUND(100 * COUNT(po.inspection_result = 'Fail') / COUNT(*), 2) AS ty_le_lo_truot_pct
FROM purchase_orders po
JOIN suppliers s ON s.supplier_id = po.supplier_id
WHERE s.warehouse_id = 'DC_DANANG'
  AND po.received_date >= '2016-01-01' AND po.received_date < '2017-01-01'
GROUP BY po.supplier_id
ORDER BY po.supplier_id;

-- [scm-a2-ty-le-lo-truot-100] solution
SELECT po.supplier_id, COUNT(*) AS so_lo,
       ROUND(100 * COUNT(CASE WHEN po.inspection_result = 'Fail' THEN 1 END) / COUNT(*), 2) AS ty_le_lo_truot_pct
FROM purchase_orders po
JOIN suppliers s ON s.supplier_id = po.supplier_id
WHERE s.warehouse_id = 'DC_DANANG'
  AND po.received_date >= '2016-01-01' AND po.received_date < '2017-01-01'
GROUP BY po.supplier_id
ORDER BY po.supplier_id;

-- [scm-a2-ty-le-lo-truot-100] wrong: else_0_trong_count
-- COUNT đếm cả số 0, nên ELSE 0 làm tử số bằng mẫu số.
SELECT po.supplier_id, COUNT(*) AS so_lo,
       ROUND(100 * COUNT(CASE WHEN po.inspection_result = 'Fail' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_lo_truot_pct
FROM purchase_orders po
JOIN suppliers s ON s.supplier_id = po.supplier_id
WHERE s.warehouse_id = 'DC_DANANG'
  AND po.received_date >= '2016-01-01' AND po.received_date < '2017-01-01'
GROUP BY po.supplier_id
ORDER BY po.supplier_id;

-- [scm-a3-voucher-theo-loai-kho] solution
SELECT h.role, COUNT(*) AS so_don,
       SUM(o.voucher_applied) AS so_don_voucher,
       ROUND(100 * SUM(o.voucher_applied) / COUNT(*), 2) AS ty_le_voucher_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
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
GROUP BY h.role
ORDER BY h.role;

-- [scm-a3-voucher-theo-loai-kho] wrong: quen_can_tren
SELECT h.role, COUNT(*) AS so_don,
       SUM(o.voucher_applied) AS so_don_voucher,
       ROUND(100 * SUM(o.voucher_applied) / COUNT(*), 2) AS ty_le_voucher_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE o.order_date >= '2017-07-01'
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

-- [scm-a6-dung-han-theo-mien-thap] starter
SELECT region, COUNT(*) AS so_don,
       ROUND(100 * SUM(on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
GROUP BY region
ORDER BY region;

-- [scm-a6-dung-han-theo-mien-thap] solution
SELECT region, COUNT(*) AS so_don,
       ROUND(100 * SUM(on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND is_cancelled = 0
GROUP BY region
ORDER BY region;

-- [scm-a6-dung-han-theo-mien-thap] wrong: count_dem_ca_so_0
-- COUNT(on_time) đếm mọi dòng có giá trị, kể cả 0, nên tỷ lệ ra 100%.
SELECT region, COUNT(*) AS so_don,
       ROUND(100 * COUNT(on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND is_cancelled = 0
GROUP BY region
ORDER BY region;

-- [scm-a6-dung-han-theo-mien-thap] wrong: quen_can_tren
SELECT region, COUNT(*) AS so_don,
       ROUND(100 * SUM(on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01'
  AND is_cancelled = 0
GROUP BY region
ORDER BY region;

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

-- [scm-a9-ncc-hang-loi-vuot-nguong] solution
SELECT supplier_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(qty_defect) / SUM(qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders
WHERE received_date >= '2016-01-01' AND received_date < '2017-01-01'
GROUP BY supplier_id
HAVING SUM(qty_defect) / SUM(qty_received) > 0.02
ORDER BY ty_le_loi_pct DESC, supplier_id;

-- [scm-a9-ncc-hang-loi-vuot-nguong] wrong: trung_binh_defect_rate
-- Trung bình tỷ lệ của từng đơn: đơn nhỏ có trọng số bằng đơn lớn.
SELECT supplier_id, COUNT(*) AS so_don,
       ROUND(100 * AVG(defect_rate), 2) AS ty_le_loi_pct
FROM purchase_orders
WHERE received_date >= '2016-01-01' AND received_date < '2017-01-01'
GROUP BY supplier_id
HAVING AVG(defect_rate) > 0.02
ORDER BY ty_le_loi_pct DESC, supplier_id;

-- [scm-a9-ncc-hang-loi-vuot-nguong] wrong: mau_so_luong_dat
SELECT supplier_id, COUNT(*) AS so_don,
       ROUND(100 * SUM(qty_defect) / SUM(qty_ordered), 2) AS ty_le_loi_pct
FROM purchase_orders
WHERE received_date >= '2016-01-01' AND received_date < '2017-01-01'
GROUP BY supplier_id
HAVING SUM(qty_defect) / SUM(qty_ordered) > 0.02
ORDER BY ty_le_loi_pct DESC, supplier_id;

-- ================================================================ CASE

-- [scm-c3-kho-giao-tre.b1] solution
SELECT dest_hub_id, COUNT(*) AS so_don,
       COUNT(CASE WHEN on_time = 0 THEN 1 END) AS so_don_tre,
       ROUND(100 * COUNT(CASE WHEN on_time = 0 THEN 1 END) / COUNT(*), 2) AS ty_le_tre_pct
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
  AND is_cancelled = 0
GROUP BY dest_hub_id
ORDER BY ty_le_tre_pct DESC, dest_hub_id;

-- [scm-c3-kho-giao-tre.b1] wrong: sap_theo_so_don_tre
SELECT dest_hub_id, COUNT(*) AS so_don,
       COUNT(CASE WHEN on_time = 0 THEN 1 END) AS so_don_tre,
       ROUND(100 * COUNT(CASE WHEN on_time = 0 THEN 1 END) / COUNT(*), 2) AS ty_le_tre_pct
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
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
