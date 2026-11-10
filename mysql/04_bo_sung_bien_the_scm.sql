-- 04_bo_sung_bien_the_scm.sql: bổ sung biến thể ẩn scm_hidden_1 cho các câu chỉ dùng bảng danh mục / bảng phụ
-- (trước đây hidden-1 chỉ đổi bảng sự kiện nên các câu này ra kết quả giống hệt public: chép kết quả Chạy thử vẫn qua).
-- Chạy SAU 03_bien_the_an_scm.sql, chỉ đụng scm_hidden_1 (đọc scm để lấy giá trị gốc):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/04_bo_sung_bien_the_scm.sql
-- Chạy lặp lại được: dòng giả xoá theo khoá riêng rồi chèn lại; giá trị sửa tính lại từ scm (không cộng dồn);
-- phép bỏ dòng theo quy tắc cố định (chạy lần hai không bỏ thêm).
-- Mọi thay đổi ghi ở README.md, bảng "Biến thể", nhóm (d).
--   (d1) danh mục giả: cửa hàng 99 (TP.HCM), mã hàng 9000001 (SEAFOOD), ngày cao điểm 2016-09-02
--   (d2) bảng phụ bỏ dòng theo quy tắc: transactions, oil, inventory_snapshots (mặt hàng tận cùng 7, như sales)
--   (d3) bảng phụ sửa nhẹ giá trị theo quy tắc: shipments, warehouse_daily_ops, staffing_plan
--   (d4) vài dòng chọn tay: 1 chuyến giao bị thiếu, 1 dòng ngày lễ nhập trùng, 1 kỳ tồn kho bị thiếu, 1 lô trượt thêm, 1 đơn gắn cờ sai

USE scm_hidden_1;

-- ------------------------------------------------------------------ (d1) danh mục giả
-- cửa hàng mới mở ở TP.HCM, chưa có giao dịch/bán hàng/tồn kho (không bảng nào trỏ tới nó)
DELETE FROM stores WHERE store_nbr = 99;
INSERT INTO stores (store_nbr, city, state, type, cluster) VALUES (99, 'TP.HCM', 'TP.HCM', 'B', 6);

-- mã hàng hải sản mới, có giá bán/giá vốn nhưng chưa có đơn mua, bán hàng, tồn kho; biên lãi gộp 17,68%
DELETE FROM item_costs WHERE item_nbr = 9000001;
DELETE FROM items      WHERE item_nbr = 9000001;
INSERT INTO items      (item_nbr, family, class, perishable)                   VALUES (9000001, 'SEAFOOD', 2806, 1);
INSERT INTO item_costs (item_nbr, family, perishable, unit_price, unit_cost)   VALUES (9000001, 'SEAFOOD', 1, 8.20, 6.75);

-- ngày cao điểm Quốc khánh 2/9/2016, nhóm 'le', hệ số 2 (như Tết, Noel)
DELETE FROM event_calendar WHERE `date` = '2016-09-02';
INSERT INTO event_calendar (`date`, event_name, tier, demand_multiplier)
VALUES ('2016-09-02', CONVERT(X'5175E1BB9163206B68C3A16E68' USING utf8mb4), 'le', 2);

-- ------------------------------------------------------------------ (d2) bỏ dòng theo quy tắc cố định
-- transactions: bỏ ngày-cửa hàng có (TO_DAYS(date) + store_nbr) % 10 = 7  (~10%; vd. cửa hàng 24 mất ngày 2017-07-08)
DELETE FROM transactions WHERE (TO_DAYS(`date`) + store_nbr) % 10 = 7;

-- oil: bỏ ngày có TO_DAYS(date) % 10 = 7  (~10%; tháng 7/2017 mất ngày 2017-07-12)
DELETE FROM oil WHERE TO_DAYS(`date`) % 10 = 7;

-- inventory_snapshots: bỏ mọi kỳ của mặt hàng có item_nbr tận cùng 7 (khớp phép bỏ của sales ở 03)
DELETE FROM inventory_snapshots WHERE item_nbr % 10 = 7;

-- ------------------------------------------------------------------ (d3) sửa nhẹ giá trị theo quy tắc (tính từ scm)
-- shipments: chuyến có số hiệu tận cùng 7 thành giao trễ và thiếu hàng: trễ nửa ngày so với cam kết (nếu đang sớm hơn),
-- giao 95% lượng, on_time = in_full = otif = 0
UPDATE shipments h JOIN scm.shipments p ON p.shipment_id = h.shipment_id
SET h.actual_days   = GREATEST(p.actual_days, p.promised_days + 0.5),
    h.units_shipped = ROUND(p.units_shipped * 0.95, 3),
    h.on_time = 0, h.in_full = 0, h.otif = 0
WHERE CAST(SUBSTRING(p.shipment_id, 4) AS UNSIGNED) % 10 = 7;

-- warehouse_daily_ops: ngày có TO_DAYS(date) % 10 = 7 dồn thêm 15% đơn (khối lượng và tỷ lệ tải tăng theo)
UPDATE warehouse_daily_ops h JOIN scm.warehouse_daily_ops p ON p.hub_id = h.hub_id AND p.`date` = h.`date`
SET h.orders_to_process = ROUND(p.orders_to_process * 1.15),
    h.total_weight_kg   = ROUND(p.total_weight_kg * 1.15, 1),
    h.workload_ratio    = ROUND(p.workload_ratio * 1.15, 3)
WHERE TO_DAYS(p.`date`) % 10 = 7;

-- staffing_plan: ngày có TO_DAYS(date) % 10 = 3 vắng 1 người so với số thực tế đã ghi
UPDATE staffing_plan h JOIN scm.staffing_plan p ON p.hub_id = h.hub_id AND p.`date` = h.`date`
SET h.headcount_thuc_te = p.headcount_thuc_te - 1
WHERE TO_DAYS(p.`date`) % 10 = 3 AND p.headcount_thuc_te > 1;

-- ------------------------------------------------------------------ (d4) vài dòng chọn tay
-- shipments: cửa hàng 1 thiếu chuyến tuần 2016-03-14/2016-03-20 (SH_0000168) -> có 1 tuần trống
DELETE FROM shipments WHERE shipment_id = 'SH_0000168';

-- holidays: ngày thành lập Phan Thiết 2016-03-02 bị nhập hai lần (chép y hệt dòng có sẵn)
DELETE FROM holidays WHERE `date` = '2016-03-02' AND locale = 'Local';
INSERT INTO holidays SELECT * FROM scm.holidays WHERE `date` = '2016-03-02' AND locale = 'Local';
INSERT INTO holidays SELECT * FROM scm.holidays WHERE `date` = '2016-03-02' AND locale = 'Local';

-- inventory_snapshots: thiếu kỳ 2017-07 của cửa hàng 51, mặt hàng 903285 (vẫn có bán trong tháng 7)
DELETE FROM inventory_snapshots WHERE store_nbr = 51 AND item_nbr = 903285 AND ym = '2017-07';

-- purchase_orders: thêm PO_9000001 của SUP_002 (chép PO_0002941 đặt 2017-07-31), lô trượt: 19/468 hàng lỗi (4,06%)
-- -> SUP_002 có lô trượt trong tháng 7/2017
DELETE FROM purchase_orders WHERE po_id = 'PO_9000001';
INSERT INTO purchase_orders
SELECT 'PO_9000001', supplier_id, item_nbr, po_date, qty_ordered, promised_lead_days, promised_date, received_date,
       km_supplier_to_dc, qty_received, 19.000, 0.0406, 'Fail'
FROM scm.purchase_orders WHERE po_id = 'PO_0002941';

-- orders: đơn ORD2_00422150 giao đúng bằng cam kết (60 giờ) nhưng bị gắn on_time = 0
UPDATE orders SET on_time = 0 WHERE order_id = 'ORD2_00422150';

ANALYZE TABLE stores, items, item_costs, event_calendar, transactions, oil, inventory_snapshots,
              shipments, warehouse_daily_ops, staffing_plan, holidays, orders, purchase_orders;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'transactions' AS bang, (SELECT COUNT(*) FROM scm.transactions) AS public, COUNT(*) AS hidden_1 FROM transactions
UNION ALL SELECT 'oil', (SELECT COUNT(*) FROM scm.oil), COUNT(*) FROM oil
UNION ALL SELECT 'inventory_snapshots', (SELECT COUNT(*) FROM scm.inventory_snapshots), COUNT(*) FROM inventory_snapshots
UNION ALL SELECT 'shipments', (SELECT COUNT(*) FROM scm.shipments), COUNT(*) FROM shipments
UNION ALL SELECT 'holidays', (SELECT COUNT(*) FROM scm.holidays), COUNT(*) FROM holidays
UNION ALL SELECT 'stores', (SELECT COUNT(*) FROM scm.stores), COUNT(*) FROM stores
UNION ALL SELECT 'items', (SELECT COUNT(*) FROM scm.items), COUNT(*) FROM items
UNION ALL SELECT 'item_costs', (SELECT COUNT(*) FROM scm.item_costs), COUNT(*) FROM item_costs
UNION ALL SELECT 'event_calendar', (SELECT COUNT(*) FROM scm.event_calendar), COUNT(*) FROM event_calendar;

SELECT 'shipments_sua' AS thay_doi, COUNT(*) AS so_dong FROM shipments h JOIN scm.shipments p USING (shipment_id)
  WHERE NOT (h.on_time <=> p.on_time AND h.units_shipped <=> p.units_shipped AND h.actual_days <=> p.actual_days)
UNION ALL SELECT 'warehouse_daily_ops_sua', COUNT(*) FROM warehouse_daily_ops h JOIN scm.warehouse_daily_ops p USING (hub_id, `date`)
  WHERE NOT (h.orders_to_process <=> p.orders_to_process AND h.workload_ratio <=> p.workload_ratio)
UNION ALL SELECT 'staffing_plan_sua', COUNT(*) FROM staffing_plan h JOIN scm.staffing_plan p USING (hub_id, `date`)
  WHERE NOT (h.headcount_thuc_te <=> p.headcount_thuc_te);
