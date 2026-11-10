-- 03_bien_the_an_scm.sql: biến thể ẩn scm_hidden_1 (chấm câu có bokiemtra={public, hidden-1}).
-- Chạy sau 02_nap_scm.sh, trong container sqllb-mysql (thư mục mysql/ mount ở /sqllb):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/03_bien_the_an_scm.sql
-- Khuôn giống datathon_2026_hidden_1 (CHOT-FORMAT-CAU-HOI.md mục 6). Mọi thay đổi ghi ở README.md, bảng "Biến thể".
--   (a) bỏ ~10% dòng của các bảng sự kiện theo khoá chẵn lẻ (không bảng nào tham chiếu tới chúng, FK nguyên vẹn)
--   (b) thêm 1 dòng ngay ngoài cận trên cửa sổ dữ liệu của sales, orders, purchase_orders, inventory_snapshots
--   (c) tạo 1 cặp hoà hạng 3 trong top 3 mặt hàng theo tổng unit_sales của family DAIRY, tháng 7/2017

DROP DATABASE IF EXISTS scm_hidden_1;
CREATE DATABASE scm_hidden_1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE scm_hidden_1;
SOURCE /sqllb/01_tao_bang_scm.sql

-- ------------------------------------------------------------------ chép nguyên scm
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO city_geo            SELECT * FROM scm.city_geo;
INSERT INTO delivery_points     SELECT * FROM scm.delivery_points;
INSERT INTO event_calendar      SELECT * FROM scm.event_calendar;
INSERT INTO holidays            SELECT * FROM scm.holidays;
INSERT INTO items               SELECT * FROM scm.items;
INSERT INTO oil                 SELECT * FROM scm.oil;
INSERT INTO sorting_hubs        SELECT * FROM scm.sorting_hubs;
INSERT INTO stores              SELECT * FROM scm.stores;
INSERT INTO warehouses          SELECT * FROM scm.warehouses;
INSERT INTO suppliers           SELECT * FROM scm.suppliers;
INSERT INTO store_attributes    SELECT * FROM scm.store_attributes;
INSERT INTO item_costs          SELECT * FROM scm.item_costs;
INSERT INTO staffing_plan       SELECT * FROM scm.staffing_plan;
INSERT INTO warehouse_daily_ops SELECT * FROM scm.warehouse_daily_ops;
INSERT INTO transactions        SELECT * FROM scm.transactions;
INSERT INTO shipments           SELECT * FROM scm.shipments;
-- (a) bỏ ~10% theo khoá chẵn lẻ ngay khi chép
INSERT INTO purchase_orders     SELECT * FROM scm.purchase_orders
  WHERE CAST(SUBSTRING(po_id, 4) AS UNSIGNED) % 10 <> 7;            -- PO_0000007, PO_0000017, ...
INSERT INTO orders              SELECT * FROM scm.orders
  WHERE CAST(SUBSTRING(order_id, 6) AS UNSIGNED) % 10 <> 7;         -- ORD2_00000007, ...
INSERT INTO inventory_snapshots SELECT * FROM scm.inventory_snapshots;
INSERT INTO sales               SELECT * FROM scm.sales
  WHERE item_nbr % 10 <> 7;                                          -- mọi dòng của mặt hàng có item_nbr tận cùng 7
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ (b) 1 dòng ngay ngoài cận trên
-- sales: cửa sổ public là 2017-07-01..2017-07-31 -> thêm 1 dòng ngày 2017-08-01 (cửa hàng 44, mặt hàng 2042941)
INSERT INTO sales (`date`, store_nbr, item_nbr, unit_sales, onpromotion)
VALUES ('2017-08-01', 44, 2042941, 500.000, 0);

-- orders: dữ liệu public tới 2017-08-13 -> thêm đơn ORD2_01033328 ngày 2017-09-01 (chép từ ORD2_00034910, dời 19 ngày)
INSERT INTO orders
SELECT 'ORD2_01033328', '2017-09-01', region, origin_hub_id, dest_hub_id, dest_city, dest_point_id, family,
       weight_kg, order_value_usd,
       created_at + INTERVAL 19 DAY, picked_at + INTERVAL 19 DAY, dispatched_at + INTERVAL 19 DAY,
       hub_arrived_at + INTERVAL 19 DAY, delivered_at + INTERVAL 19 DAY,
       t1_tao_don_pick_h, t2_pick_xuat_h, t3a_di_chuyen_h, t3b_sorting_h, t4_kho_giao_h,
       lead_time_total_h, promised_h, on_time, checkout_group, voucher_manually_applied, voucher_applied, is_cancelled
FROM scm.orders WHERE order_id = 'ORD2_00034910';

-- purchase_orders: po_date public tới 2017-08-15 -> thêm PO_0158799 ngày 2017-09-01 (chép PO_0158798, dời ngày)
INSERT INTO purchase_orders
SELECT 'PO_0158799', supplier_id, item_nbr, '2017-09-01', qty_ordered, promised_lead_days,
       '2017-09-01' + INTERVAL DATEDIFF(promised_date, po_date) DAY,
       CASE WHEN received_date IS NULL THEN NULL ELSE '2017-09-01' + INTERVAL DATEDIFF(received_date, po_date) DAY END,
       km_supplier_to_dc, qty_received, qty_defect, defect_rate, inspection_result
FROM scm.purchase_orders WHERE po_id = 'PO_0158798';

-- inventory_snapshots: ym public tới '2017-08' -> thêm 1 dòng ym '2017-09' (chép dòng cửa hàng 1, mặt hàng 96995)
INSERT INTO inventory_snapshots
SELECT store_nbr, item_nbr, '2017-09', on_hand_end, 0, 0, on_hand_end, inventory_value, 0
FROM scm.inventory_snapshots WHERE store_nbr = 1 AND item_nbr = 96995 AND ym = '2017-08';

-- ------------------------------------------------------------------ (c) cặp hoà hạng
-- Top 3 mặt hàng theo SUM(unit_sales) trong family DAIRY, tháng 7/2017 (sau bước a):
--   hạng 3: 838216 = 19654, hạng 4: 1963265 = 19624. Cộng 30 vào một dòng của 1963265 -> hai mặt hàng cùng 19654.
--   ROW_NUMBER() ... ORDER BY tong DESC, item_nbr giữ 838216 ở hạng 3; RANK()/DENSE_RANK() trả 4 dòng.
UPDATE sales SET unit_sales = unit_sales + 30
WHERE item_nbr = 1963265 AND `date` = '2017-07-01' AND store_nbr = (
  SELECT m FROM (SELECT MIN(store_nbr) AS m FROM scm.sales WHERE item_nbr = 1963265 AND `date` = '2017-07-01') x)
LIMIT 1;

ANALYZE TABLE purchase_orders, orders, inventory_snapshots, sales;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'orders' AS bang, (SELECT COUNT(*) FROM scm.orders) AS public, COUNT(*) AS hidden_1 FROM orders
UNION ALL SELECT 'purchase_orders', (SELECT COUNT(*) FROM scm.purchase_orders), COUNT(*) FROM purchase_orders
UNION ALL SELECT 'sales', (SELECT COUNT(*) FROM scm.sales), COUNT(*) FROM sales
UNION ALL SELECT 'inventory_snapshots', (SELECT COUNT(*) FROM scm.inventory_snapshots), COUNT(*) FROM inventory_snapshots;

WITH dt AS (
  SELECT s.item_nbr, SUM(s.unit_sales) AS tong
  FROM sales s JOIN items i ON i.item_nbr = s.item_nbr
  WHERE i.family = 'DAIRY' AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  GROUP BY s.item_nbr)
SELECT item_nbr, tong, RANK() OVER (ORDER BY tong DESC) AS hang FROM dt ORDER BY tong DESC, item_nbr LIMIT 5;
