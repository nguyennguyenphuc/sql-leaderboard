-- solution.sql: gói 4 bộ Supply Chain (scm) · Module 7 CTE & Set Operations, Module 8 Window Functions, case c7, c8.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chạy trên scm (public) và scm_hidden_1 (hidden-1).

-- ===================================================================== MODULE 7 · CTE & SET OPERATIONS

-- [scm-t1-ton-tren-ban-nganh-hang] solution
WITH ton AS (
  SELECT it.family, SUM(i.on_hand_end) AS ton_cuoi_ky
  FROM inventory_snapshots i
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07'
  GROUP BY it.family
), ban AS (
  SELECT it.family, SUM(s.unit_sales) AS luong_ban
  FROM sales s
  JOIN items it ON it.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  GROUP BY it.family
)
SELECT ton.family,
       ROUND(ton.ton_cuoi_ky, 0) AS ton_cuoi_ky,
       ROUND(ban.luong_ban, 0) AS luong_ban,
       ROUND(ton.ton_cuoi_ky / ban.luong_ban, 2) AS ty_so_ton_ban
FROM ton
JOIN ban ON ban.family = ton.family
WHERE ban.luong_ban > 0
ORDER BY ton.ton_cuoi_ky / ban.luong_ban DESC, ton.family;

-- [scm-t1-ton-tren-ban-nganh-hang] wrong: noi_truc_tiep_nhan_dong
-- Ghép CTE tồn theo ngành với từng dòng bán hàng rồi mới cộng: tồn cuối kỳ bị cộng lặp theo số dòng bán (rớt ở public).
WITH ton AS (
  SELECT it.family, SUM(i.on_hand_end) AS ton_cuoi_ky
  FROM inventory_snapshots i
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07'
  GROUP BY it.family
)
SELECT ton.family,
       ROUND(SUM(ton.ton_cuoi_ky), 0) AS ton_cuoi_ky,
       ROUND(SUM(s.unit_sales), 0) AS luong_ban,
       ROUND(SUM(ton.ton_cuoi_ky) / SUM(s.unit_sales), 2) AS ty_so_ton_ban
FROM ton
JOIN items it ON it.family = ton.family
JOIN sales s ON s.item_nbr = it.item_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY ton.family
HAVING SUM(s.unit_sales) > 0
ORDER BY SUM(ton.ton_cuoi_ky) / SUM(s.unit_sales) DESC, ton.family;

-- [scm-t1-ton-tren-ban-nganh-hang] wrong: quen_can_tren
-- Thiếu cận trên của ngày bán: hidden-1 có thêm một dòng ngày 2017-08-01 (rớt ở hidden-1).
WITH ton AS (
  SELECT it.family, SUM(i.on_hand_end) AS ton_cuoi_ky
  FROM inventory_snapshots i
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07'
  GROUP BY it.family
), ban AS (
  SELECT it.family, SUM(s.unit_sales) AS luong_ban
  FROM sales s
  JOIN items it ON it.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01'
  GROUP BY it.family
)
SELECT ton.family,
       ROUND(ton.ton_cuoi_ky, 0) AS ton_cuoi_ky,
       ROUND(ban.luong_ban, 0) AS luong_ban,
       ROUND(ton.ton_cuoi_ky / ban.luong_ban, 2) AS ty_so_ton_ban
FROM ton
JOIN ban ON ban.family = ton.family
WHERE ban.luong_ban > 0
ORDER BY ton.ton_cuoi_ky / ban.luong_ban DESC, ton.family;

-- [scm-t2-chuyen-giao-cua-hang-18] solution
WITH RECURSIVE thang AS (
  SELECT DATE('2016-01-01') AS dau_thang
  UNION ALL
  SELECT DATE_ADD(dau_thang, INTERVAL 1 MONTH) FROM thang WHERE dau_thang < '2016-12-01'
), chuyen AS (
  SELECT LEFT(week, 7) AS thang, COUNT(*) AS so_chuyen, SUM(units_shipped) AS luong_giao
  FROM shipments
  WHERE store_nbr = 18 AND week >= '2016-01-01' AND week < '2017-01-01'
  GROUP BY LEFT(week, 7)
)
SELECT DATE_FORMAT(t.dau_thang, '%Y-%m') AS thang,
       COALESCE(c.so_chuyen, 0) AS so_chuyen,
       ROUND(COALESCE(c.luong_giao, 0), 0) AS luong_giao
FROM thang t
LEFT JOIN chuyen c ON c.thang = DATE_FORMAT(t.dau_thang, '%Y-%m')
ORDER BY thang;

-- [scm-t2-chuyen-giao-cua-hang-18] wrong: khong_sinh_day_thang
-- Chỉ gom nhóm theo tháng có chuyến: tháng không có chuyến biến mất (rớt ở public).
SELECT LEFT(week, 7) AS thang, COUNT(*) AS so_chuyen, ROUND(SUM(units_shipped), 0) AS luong_giao
FROM shipments
WHERE store_nbr = 18 AND week >= '2016-01-01' AND week < '2017-01-01'
GROUP BY LEFT(week, 7)
ORDER BY thang;

-- [scm-t2-chuyen-giao-cua-hang-18] wrong: count_sao_sau_left_join
-- COUNT(*) sau LEFT JOIN đếm cả dòng trống: tháng không có chuyến ra 1 (rớt ở public).
WITH RECURSIVE thang AS (
  SELECT DATE('2016-01-01') AS dau_thang
  UNION ALL
  SELECT DATE_ADD(dau_thang, INTERVAL 1 MONTH) FROM thang WHERE dau_thang < '2016-12-01'
)
SELECT DATE_FORMAT(t.dau_thang, '%Y-%m') AS thang,
       COUNT(*) AS so_chuyen,
       ROUND(COALESCE(SUM(sh.units_shipped), 0), 0) AS luong_giao
FROM thang t
LEFT JOIN shipments sh ON sh.store_nbr = 18 AND LEFT(sh.week, 7) = DATE_FORMAT(t.dau_thang, '%Y-%m')
GROUP BY t.dau_thang
ORDER BY thang;

-- [scm-t3-ma-hang-can-ra-soat] solution
WITH can_ra_soat AS (
  SELECT item_nbr FROM purchase_orders
  WHERE po_date >= '2017-01-01' AND po_date < '2017-07-01' AND inspection_result = 'Fail'
  UNION
  SELECT item_nbr FROM purchase_orders
  WHERE po_date >= '2017-01-01' AND po_date < '2017-07-01' AND received_date > promised_date
)
SELECT it.family, COUNT(*) AS so_ma_hang
FROM can_ra_soat c
JOIN items it ON it.item_nbr = c.item_nbr
GROUP BY it.family
ORDER BY so_ma_hang DESC, it.family;

-- [scm-t3-ma-hang-can-ra-soat] wrong: union_all_dem_trung
-- UNION ALL giữ dòng trùng: mã vừa có lô trượt vừa có đơn trễ, hoặc nhiều đơn, bị đếm nhiều lần (rớt ở public).
WITH can_ra_soat AS (
  SELECT item_nbr FROM purchase_orders
  WHERE po_date >= '2017-01-01' AND po_date < '2017-07-01' AND inspection_result = 'Fail'
  UNION ALL
  SELECT item_nbr FROM purchase_orders
  WHERE po_date >= '2017-01-01' AND po_date < '2017-07-01' AND received_date > promised_date
)
SELECT it.family, COUNT(*) AS so_ma_hang
FROM can_ra_soat c
JOIN items it ON it.item_nbr = c.item_nbr
GROUP BY it.family
ORDER BY so_ma_hang DESC, it.family;

-- [scm-t4-ty-le-lo-truot-ncc] starter
WITH ve AS (
  SELECT supplier_id, COUNT(*) AS so_don_ve
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND received_date IS NOT NULL
  GROUP BY supplier_id
), truot AS (
  SELECT supplier_id, COUNT(*) AS so_lo_truot
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND inspection_result = 'Fail'
  GROUP BY supplier_id
)
SELECT ve.supplier_id, ve.so_don_ve, truot.so_lo_truot,
       ROUND(100 * truot.so_lo_truot / ve.so_don_ve, 2) AS ty_le_lo_truot_pct
FROM ve
JOIN truot ON truot.supplier_id = ve.supplier_id
ORDER BY ty_le_lo_truot_pct DESC, ve.supplier_id;

-- [scm-t4-ty-le-lo-truot-ncc] solution
WITH ve AS (
  SELECT supplier_id, COUNT(*) AS so_don_ve
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND received_date IS NOT NULL
  GROUP BY supplier_id
), truot AS (
  SELECT supplier_id, COUNT(*) AS so_lo_truot
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND inspection_result = 'Fail'
  GROUP BY supplier_id
)
SELECT ve.supplier_id, ve.so_don_ve, COALESCE(truot.so_lo_truot, 0) AS so_lo_truot,
       ROUND(100 * COALESCE(truot.so_lo_truot, 0) / ve.so_don_ve, 2) AS ty_le_lo_truot_pct
FROM ve
LEFT JOIN truot ON truot.supplier_id = ve.supplier_id
ORDER BY ty_le_lo_truot_pct DESC, ve.supplier_id;

-- [scm-t4-ty-le-lo-truot-ncc] wrong: left_join_quen_coalesce
-- Đổi sang LEFT JOIN nhưng để NULL thay cho 0 ở nhà cung cấp không có lô trượt (rớt ở public).
WITH ve AS (
  SELECT supplier_id, COUNT(*) AS so_don_ve
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND received_date IS NOT NULL
  GROUP BY supplier_id
), truot AS (
  SELECT supplier_id, COUNT(*) AS so_lo_truot
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND inspection_result = 'Fail'
  GROUP BY supplier_id
)
SELECT ve.supplier_id, ve.so_don_ve, truot.so_lo_truot,
       ROUND(100 * truot.so_lo_truot / ve.so_don_ve, 2) AS ty_le_lo_truot_pct
FROM ve
LEFT JOIN truot ON truot.supplier_id = ve.supplier_id
ORDER BY ty_le_lo_truot_pct DESC, ve.supplier_id;

-- [scm-t5-nhap-xuat-dc] starter
WITH nhap AS (
  SELECT s.warehouse_id, s.supplier_id, SUM(p.qty_received) AS luong_nhap
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
  GROUP BY s.warehouse_id, s.supplier_id
), xuat AS (
  SELECT warehouse_id, SUM(units_shipped) AS luong_xuat
  FROM shipments
  WHERE week >= '2016-01-01' AND week < '2017-01-01'
  GROUP BY warehouse_id
)
SELECT nhap.warehouse_id,
       ROUND(SUM(nhap.luong_nhap), 0) AS luong_nhap,
       ROUND(SUM(xuat.luong_xuat), 0) AS luong_xuat,
       ROUND(SUM(nhap.luong_nhap) - SUM(xuat.luong_xuat), 0) AS chenh_lech
FROM nhap
JOIN xuat ON xuat.warehouse_id = nhap.warehouse_id
GROUP BY nhap.warehouse_id
ORDER BY nhap.warehouse_id;

-- [scm-t5-nhap-xuat-dc] solution
WITH nhap AS (
  SELECT s.warehouse_id, SUM(p.qty_received) AS luong_nhap
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.received_date >= '2016-01-01' AND p.received_date < '2017-01-01'
  GROUP BY s.warehouse_id
), xuat AS (
  SELECT warehouse_id, SUM(units_shipped) AS luong_xuat
  FROM shipments
  WHERE week >= '2016-01-01' AND week < '2017-01-01'
  GROUP BY warehouse_id
)
SELECT nhap.warehouse_id,
       ROUND(nhap.luong_nhap, 0) AS luong_nhap,
       ROUND(xuat.luong_xuat, 0) AS luong_xuat,
       ROUND(nhap.luong_nhap - xuat.luong_xuat, 0) AS chenh_lech
FROM nhap
JOIN xuat ON xuat.warehouse_id = nhap.warehouse_id
ORDER BY nhap.warehouse_id;

-- [scm-t5-nhap-xuat-dc] wrong: chi_sua_nhan_dong
-- Sửa được nhân dòng nhưng vẫn lọc nhập theo ngày đặt thay cho ngày nhận hàng (rớt ở public).
WITH nhap AS (
  SELECT s.warehouse_id, SUM(p.qty_received) AS luong_nhap
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
  GROUP BY s.warehouse_id
), xuat AS (
  SELECT warehouse_id, SUM(units_shipped) AS luong_xuat
  FROM shipments
  WHERE week >= '2016-01-01' AND week < '2017-01-01'
  GROUP BY warehouse_id
)
SELECT nhap.warehouse_id,
       ROUND(nhap.luong_nhap, 0) AS luong_nhap,
       ROUND(xuat.luong_xuat, 0) AS luong_xuat,
       ROUND(nhap.luong_nhap - xuat.luong_xuat, 0) AS chenh_lech
FROM nhap
JOIN xuat ON xuat.warehouse_id = nhap.warehouse_id
ORDER BY nhap.warehouse_id;

-- [scm-t5-nhap-xuat-dc] wrong: chi_sua_ngay_nhan
-- Sửa ngày nhận nhưng vẫn nối lượng xuất của DC vào từng nhà cung cấp rồi cộng (rớt ở public).
WITH nhap AS (
  SELECT s.warehouse_id, s.supplier_id, SUM(p.qty_received) AS luong_nhap
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.received_date >= '2016-01-01' AND p.received_date < '2017-01-01'
  GROUP BY s.warehouse_id, s.supplier_id
), xuat AS (
  SELECT warehouse_id, SUM(units_shipped) AS luong_xuat
  FROM shipments
  WHERE week >= '2016-01-01' AND week < '2017-01-01'
  GROUP BY warehouse_id
)
SELECT nhap.warehouse_id,
       ROUND(SUM(nhap.luong_nhap), 0) AS luong_nhap,
       ROUND(SUM(xuat.luong_xuat), 0) AS luong_xuat,
       ROUND(SUM(nhap.luong_nhap) - SUM(xuat.luong_xuat), 0) AS chenh_lech
FROM nhap
JOIN xuat ON xuat.warehouse_id = nhap.warehouse_id
GROUP BY nhap.warehouse_id
ORDER BY nhap.warehouse_id;

-- [scm-t6-von-ton-theo-loai-cua-hang] starter
WITH von AS (
  SELECT st.type, i.inventory_value
  FROM inventory_snapshots i
  JOIN stores st ON st.store_nbr = i.store_nbr
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07' AND it.perishable = 1
  UNION
  SELECT st.type, i.inventory_value
  FROM inventory_snapshots i
  JOIN stores st ON st.store_nbr = i.store_nbr
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07' AND it.perishable = 0
)
SELECT type, ROUND(SUM(inventory_value), 0) AS von_ton
FROM von
GROUP BY type
ORDER BY type;

-- [scm-t6-von-ton-theo-loai-cua-hang] solution
WITH von AS (
  SELECT st.type, i.inventory_value
  FROM inventory_snapshots i
  JOIN stores st ON st.store_nbr = i.store_nbr
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07' AND it.perishable = 1
  UNION ALL
  SELECT st.type, i.inventory_value
  FROM inventory_snapshots i
  JOIN stores st ON st.store_nbr = i.store_nbr
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07' AND it.perishable = 0
)
SELECT type, ROUND(SUM(inventory_value), 0) AS von_ton
FROM von
GROUP BY type
ORDER BY type;

-- [scm-t6-von-ton-theo-loai-cua-hang] wrong: union_them_cua_hang
-- Thêm store_nbr vào hai vế nhưng vẫn dùng UNION: hai mã cùng cửa hàng, cùng vốn tồn vẫn bị gộp (rớt ở public).
WITH von AS (
  SELECT st.type, i.store_nbr, i.inventory_value
  FROM inventory_snapshots i
  JOIN stores st ON st.store_nbr = i.store_nbr
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07' AND it.perishable = 1
  UNION
  SELECT st.type, i.store_nbr, i.inventory_value
  FROM inventory_snapshots i
  JOIN stores st ON st.store_nbr = i.store_nbr
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-07' AND it.perishable = 0
)
SELECT type, ROUND(SUM(inventory_value), 0) AS von_ton
FROM von
GROUP BY type
ORDER BY type;

-- [scm-t7-ncc-duoi-chuan] solution
WITH po AS (
  SELECT supplier_id,
         CASE WHEN received_date <= promised_date THEN 1 ELSE 0 END AS dung_han,
         DATEDIFF(received_date, po_date) AS lead_time
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND received_date IS NOT NULL
), ncc AS (
  SELECT supplier_id, COUNT(*) AS so_don_ve,
         100 * AVG(dung_han) AS otd, AVG(lead_time) AS lead_time_tb
  FROM po
  GROUP BY supplier_id
), chuoi AS (
  SELECT 100 * AVG(dung_han) AS otd_chuoi FROM po
)
SELECT ncc.supplier_id, s.supplier_name, ncc.so_don_ve,
       ROUND(ncc.otd, 2) AS otd_pct,
       ROUND(ncc.lead_time_tb, 1) AS lead_time_tb,
       s.promised_lead_days AS lead_time_cam_ket
FROM ncc
JOIN suppliers s ON s.supplier_id = ncc.supplier_id
CROSS JOIN chuoi
WHERE ncc.otd < chuoi.otd_chuoi
  AND ncc.lead_time_tb > s.promised_lead_days
ORDER BY otd_pct, ncc.supplier_id;

-- [scm-t7-ncc-duoi-chuan] wrong: loc_nam_theo_ngay_nhan
-- Lọc năm 2016 theo ngày nhận hàng thay cho ngày đặt (rớt ở public).
WITH po AS (
  SELECT supplier_id,
         CASE WHEN received_date <= promised_date THEN 1 ELSE 0 END AS dung_han,
         DATEDIFF(received_date, po_date) AS lead_time
  FROM purchase_orders
  WHERE received_date >= '2016-01-01' AND received_date < '2017-01-01'
), ncc AS (
  SELECT supplier_id, COUNT(*) AS so_don_ve,
         100 * AVG(dung_han) AS otd, AVG(lead_time) AS lead_time_tb
  FROM po
  GROUP BY supplier_id
), chuoi AS (
  SELECT 100 * AVG(dung_han) AS otd_chuoi FROM po
)
SELECT ncc.supplier_id, s.supplier_name, ncc.so_don_ve,
       ROUND(ncc.otd, 2) AS otd_pct,
       ROUND(ncc.lead_time_tb, 1) AS lead_time_tb,
       s.promised_lead_days AS lead_time_cam_ket
FROM ncc
JOIN suppliers s ON s.supplier_id = ncc.supplier_id
CROSS JOIN chuoi
WHERE ncc.otd < chuoi.otd_chuoi
  AND ncc.lead_time_tb > s.promised_lead_days
ORDER BY otd_pct, ncc.supplier_id;

-- [scm-t7-ncc-duoi-chuan] wrong: tre_tinh_ca_dung_ngay_hen
-- Coi đơn về đúng ngày hẹn là trễ (dùng < thay cho <=) (rớt ở public).
WITH po AS (
  SELECT supplier_id,
         CASE WHEN received_date < promised_date THEN 1 ELSE 0 END AS dung_han,
         DATEDIFF(received_date, po_date) AS lead_time
  FROM purchase_orders
  WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01' AND received_date IS NOT NULL
), ncc AS (
  SELECT supplier_id, COUNT(*) AS so_don_ve,
         100 * AVG(dung_han) AS otd, AVG(lead_time) AS lead_time_tb
  FROM po
  GROUP BY supplier_id
), chuoi AS (
  SELECT 100 * AVG(dung_han) AS otd_chuoi FROM po
)
SELECT ncc.supplier_id, s.supplier_name, ncc.so_don_ve,
       ROUND(ncc.otd, 2) AS otd_pct,
       ROUND(ncc.lead_time_tb, 1) AS lead_time_tb,
       s.promised_lead_days AS lead_time_cam_ket
FROM ncc
JOIN suppliers s ON s.supplier_id = ncc.supplier_id
CROSS JOIN chuoi
WHERE ncc.otd < chuoi.otd_chuoi
  AND ncc.lead_time_tb > s.promised_lead_days
ORDER BY otd_pct, ncc.supplier_id;

-- [scm-t8-diem-giao-huy-cao] solution
WITH don AS (
  SELECT region, dest_point_id, is_cancelled
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
), diem AS (
  SELECT region, dest_point_id, COUNT(*) AS so_don, 100 * AVG(is_cancelled) AS ty_le_huy
  FROM don
  GROUP BY region, dest_point_id
), mien AS (
  SELECT region, 100 * AVG(is_cancelled) AS ty_le_huy_mien
  FROM don
  GROUP BY region
)
SELECT diem.region, diem.dest_point_id, diem.so_don,
       ROUND(diem.ty_le_huy, 2) AS ty_le_huy_pct,
       ROUND(mien.ty_le_huy_mien, 2) AS ty_le_huy_mien_pct
FROM diem
JOIN mien ON mien.region = diem.region
WHERE diem.ty_le_huy > mien.ty_le_huy_mien
ORDER BY diem.region, ty_le_huy_pct DESC, diem.dest_point_id;

-- [scm-t8-diem-giao-huy-cao] wrong: quen_can_tren
-- Thiếu cận trên: cộng cả đơn tháng 8/2017 (rớt ở public và hidden-1).
WITH don AS (
  SELECT region, dest_point_id, is_cancelled
  FROM orders
  WHERE order_date >= '2017-07-01'
), diem AS (
  SELECT region, dest_point_id, COUNT(*) AS so_don, 100 * AVG(is_cancelled) AS ty_le_huy
  FROM don
  GROUP BY region, dest_point_id
), mien AS (
  SELECT region, 100 * AVG(is_cancelled) AS ty_le_huy_mien
  FROM don
  GROUP BY region
)
SELECT diem.region, diem.dest_point_id, diem.so_don,
       ROUND(diem.ty_le_huy, 2) AS ty_le_huy_pct,
       ROUND(mien.ty_le_huy_mien, 2) AS ty_le_huy_mien_pct
FROM diem
JOIN mien ON mien.region = diem.region
WHERE diem.ty_le_huy > mien.ty_le_huy_mien
ORDER BY diem.region, ty_le_huy_pct DESC, diem.dest_point_id;

-- [scm-t8-diem-giao-huy-cao] wrong: chuan_mien_trung_binh_cac_diem
-- Tỷ lệ của miền lấy trung bình tỷ lệ các điểm giao, không tính lại từ số đơn (rớt ở public).
WITH don AS (
  SELECT region, dest_point_id, is_cancelled
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
), diem AS (
  SELECT region, dest_point_id, COUNT(*) AS so_don, 100 * AVG(is_cancelled) AS ty_le_huy
  FROM don
  GROUP BY region, dest_point_id
), mien AS (
  SELECT region, AVG(ty_le_huy) AS ty_le_huy_mien
  FROM diem
  GROUP BY region
)
SELECT diem.region, diem.dest_point_id, diem.so_don,
       ROUND(diem.ty_le_huy, 2) AS ty_le_huy_pct,
       ROUND(mien.ty_le_huy_mien, 2) AS ty_le_huy_mien_pct
FROM diem
JOIN mien ON mien.region = diem.region
WHERE diem.ty_le_huy > mien.ty_le_huy_mien
ORDER BY diem.region, ty_le_huy_pct DESC, diem.dest_point_id;

-- [scm-t9-huy-theo-nhom-ap-ma] solution
WITH don AS (
  SELECT checkout_group, is_cancelled
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
)
SELECT nhom, so_don, so_huy, ty_le_huy_pct
FROM (
  SELECT checkout_group AS nhom, 1 AS thu_tu, COUNT(*) AS so_don, SUM(is_cancelled) AS so_huy,
         ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
  FROM don
  GROUP BY checkout_group
  UNION ALL
  SELECT 'tong', 2, COUNT(*), SUM(is_cancelled), ROUND(100 * SUM(is_cancelled) / COUNT(*), 2)
  FROM don
) bc
ORDER BY thu_tu, nhom;

-- [scm-t9-huy-theo-nhom-ap-ma] wrong: dong_tong_la_trung_binh_ty_le
-- Dòng tổng lấy trung bình tỷ lệ của hai nhóm (không trọng số theo số đơn) (rớt ở public).
WITH don AS (
  SELECT checkout_group, is_cancelled
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
), nhom AS (
  SELECT checkout_group AS nhom, COUNT(*) AS so_don, SUM(is_cancelled) AS so_huy,
         100 * SUM(is_cancelled) / COUNT(*) AS ty_le
  FROM don
  GROUP BY checkout_group
)
SELECT nhom, so_don, so_huy, ty_le_huy_pct
FROM (
  SELECT nhom, 1 AS thu_tu, so_don, so_huy, ROUND(ty_le, 2) AS ty_le_huy_pct FROM nhom
  UNION ALL
  SELECT 'tong', 2, SUM(so_don), SUM(so_huy), ROUND(AVG(ty_le), 2) FROM nhom
) bc
ORDER BY thu_tu, nhom;

-- [scm-t9-huy-theo-nhom-ap-ma] wrong: quen_can_tren
-- Thiếu cận trên: cộng cả đơn tháng 8/2017 (rớt ở public).
WITH don AS (
  SELECT checkout_group, is_cancelled
  FROM orders
  WHERE order_date >= '2017-07-01'
)
SELECT nhom, so_don, so_huy, ty_le_huy_pct
FROM (
  SELECT checkout_group AS nhom, 1 AS thu_tu, COUNT(*) AS so_don, SUM(is_cancelled) AS so_huy,
         ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
  FROM don
  GROUP BY checkout_group
  UNION ALL
  SELECT 'tong', 2, COUNT(*), SUM(is_cancelled), ROUND(100 * SUM(is_cancelled) / COUNT(*), 2)
  FROM don
) bc
ORDER BY thu_tu, nhom;

-- ===================================================================== MODULE 8 · WINDOW FUNCTIONS

-- [scm-f1-top3-hang-tuoi-song] solution
WITH ban AS (
  SELECT it.family, s.item_nbr, SUM(s.unit_sales) AS luong_ban
  FROM sales s
  JOIN items it ON it.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01' AND it.perishable = 1
  GROUP BY it.family, s.item_nbr
), xep AS (
  SELECT family, item_nbr, luong_ban,
         ROW_NUMBER() OVER (PARTITION BY family ORDER BY luong_ban DESC, item_nbr) AS hang
  FROM ban
)
SELECT family, item_nbr, ROUND(luong_ban, 0) AS luong_ban, hang
FROM xep
WHERE hang <= 3
ORDER BY family, hang;

-- [scm-f1-top3-hang-tuoi-song] wrong: dung_rank
-- RANK cho hai mã bằng lượng bán cùng hạng 3: ngành DAIRY ra 4 dòng ở hidden-1.
WITH ban AS (
  SELECT it.family, s.item_nbr, SUM(s.unit_sales) AS luong_ban
  FROM sales s
  JOIN items it ON it.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01' AND it.perishable = 1
  GROUP BY it.family, s.item_nbr
), xep AS (
  SELECT family, item_nbr, luong_ban,
         RANK() OVER (PARTITION BY family ORDER BY luong_ban DESC) AS hang
  FROM ban
)
SELECT family, item_nbr, ROUND(luong_ban, 0) AS luong_ban, hang
FROM xep
WHERE hang <= 3
ORDER BY family, hang, item_nbr;

-- [scm-f1-top3-hang-tuoi-song] wrong: thieu_partition_by
-- Xếp hạng trên toàn bộ hàng tươi sống thay cho từng ngành hàng (rớt ở public).
WITH ban AS (
  SELECT it.family, s.item_nbr, SUM(s.unit_sales) AS luong_ban
  FROM sales s
  JOIN items it ON it.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01' AND it.perishable = 1
  GROUP BY it.family, s.item_nbr
), xep AS (
  SELECT family, item_nbr, luong_ban,
         ROW_NUMBER() OVER (ORDER BY luong_ban DESC, item_nbr) AS hang
  FROM ban
)
SELECT family, item_nbr, ROUND(luong_ban, 0) AS luong_ban, hang
FROM xep
WHERE hang <= 3
ORDER BY family, hang;

-- [scm-f2-fill-rate-theo-thang] solution
WITH ky AS (
  SELECT ym, 100 * (1 - SUM(thieu_hut) / SUM(sold)) AS fill_rate
  FROM inventory_snapshots
  WHERE ym >= '2017-01' AND ym <= '2017-07'
  GROUP BY ym
)
SELECT ym AS ky,
       ROUND(fill_rate, 2) AS fill_rate_pct,
       ROUND(fill_rate - LAG(fill_rate) OVER (ORDER BY ym), 2) AS thay_doi_diem
FROM ky
ORDER BY ky;

-- [scm-f2-fill-rate-theo-thang] wrong: gom_ca_ky_chua_du
-- Không loại kỳ 2017-08 (chỉ có nửa tháng) (rớt ở public).
WITH ky AS (
  SELECT ym, 100 * (1 - SUM(thieu_hut) / SUM(sold)) AS fill_rate
  FROM inventory_snapshots
  WHERE ym >= '2017-01'
  GROUP BY ym
)
SELECT ym AS ky,
       ROUND(fill_rate, 2) AS fill_rate_pct,
       ROUND(fill_rate - LAG(fill_rate) OVER (ORDER BY ym), 2) AS thay_doi_diem
FROM ky
ORDER BY ky;

-- [scm-f2-fill-rate-theo-thang] wrong: trung_binh_ty_le_tung_dong
-- Lấy trung bình fill rate của từng dòng thay cho tính trên tổng số lượng (rớt ở public).
WITH ky AS (
  SELECT ym, 100 * AVG(1 - thieu_hut / sold) AS fill_rate
  FROM inventory_snapshots
  WHERE ym >= '2017-01' AND ym <= '2017-07' AND sold > 0
  GROUP BY ym
)
SELECT ym AS ky,
       ROUND(fill_rate, 2) AS fill_rate_pct,
       ROUND(fill_rate - LAG(fill_rate) OVER (ORDER BY ym), 2) AS thay_doi_diem
FROM ky
ORDER BY ky;

-- [scm-f3-luy-ke-cua-hang-44] solution
WITH ngay AS (
  SELECT `date` AS ngay, SUM(unit_sales) AS luong_ban
  FROM sales
  WHERE store_nbr = 44 AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY `date`
)
SELECT ngay, ROUND(luong_ban, 0) AS luong_ban,
       ROUND(SUM(luong_ban) OVER (ORDER BY ngay), 0) AS luy_ke
FROM ngay
ORDER BY ngay;

-- [scm-f3-luy-ke-cua-hang-44] wrong: quen_can_tren
-- Thiếu cận trên: hidden-1 có thêm dòng của cửa hàng 44 ngày 2017-08-01 (rớt ở hidden-1).
WITH ngay AS (
  SELECT `date` AS ngay, SUM(unit_sales) AS luong_ban
  FROM sales
  WHERE store_nbr = 44 AND `date` >= '2017-07-01'
  GROUP BY `date`
)
SELECT ngay, ROUND(luong_ban, 0) AS luong_ban,
       ROUND(SUM(luong_ban) OVER (ORDER BY ngay), 0) AS luy_ke
FROM ngay
ORDER BY ngay;

-- [scm-f3-luy-ke-cua-hang-44] wrong: over_thieu_order_by
-- OVER () không có ORDER BY: mọi dòng ra tổng cả tháng (rớt ở public).
WITH ngay AS (
  SELECT `date` AS ngay, SUM(unit_sales) AS luong_ban
  FROM sales
  WHERE store_nbr = 44 AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY `date`
)
SELECT ngay, ROUND(luong_ban, 0) AS luong_ban,
       ROUND(SUM(luong_ban) OVER (), 0) AS luy_ke
FROM ngay
ORDER BY ngay;

-- [scm-f4-ngay-don-tang-dot-bien] solution
WITH ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE is_cancelled = 0 AND order_date >= '2016-09-24' AND order_date < '2017-01-01'
  GROUP BY order_date
), truot AS (
  SELECT ngay, so_don,
         AVG(so_don) OVER (ORDER BY ngay ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING) AS tb_7_ngay_truoc
  FROM ngay
)
SELECT ngay, so_don,
       ROUND(tb_7_ngay_truoc, 1) AS tb_7_ngay_truoc,
       ROUND(so_don / tb_7_ngay_truoc, 2) AS he_so
FROM truot
WHERE ngay >= '2016-10-01' AND so_don > 1.5 * tb_7_ngay_truoc
ORDER BY ngay;

-- [scm-f4-ngay-don-tang-dot-bien] wrong: khung_gom_ca_ngay_dang_xet
-- Khung trượt gồm cả ngày đang xét (6 PRECEDING AND CURRENT ROW): ngày tăng vọt tự kéo trung bình lên (rớt ở public).
WITH ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE is_cancelled = 0 AND order_date >= '2016-09-24' AND order_date < '2017-01-01'
  GROUP BY order_date
), truot AS (
  SELECT ngay, so_don,
         AVG(so_don) OVER (ORDER BY ngay ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS tb_7_ngay_truoc
  FROM ngay
)
SELECT ngay, so_don,
       ROUND(tb_7_ngay_truoc, 1) AS tb_7_ngay_truoc,
       ROUND(so_don / tb_7_ngay_truoc, 2) AS he_so
FROM truot
WHERE ngay >= '2016-10-01' AND so_don > 1.5 * tb_7_ngay_truoc
ORDER BY ngay;

-- [scm-f4-ngay-don-tang-dot-bien] wrong: loc_quy_truoc_khi_truot
-- Lọc quý 4 trước khi tính trung bình trượt: các ngày đầu tháng 10 thiếu ngày tháng 9 (rớt ở public).
WITH ngay AS (
  SELECT order_date AS ngay, COUNT(*) AS so_don
  FROM orders
  WHERE is_cancelled = 0 AND order_date >= '2016-10-01' AND order_date < '2017-01-01'
  GROUP BY order_date
), truot AS (
  SELECT ngay, so_don,
         AVG(so_don) OVER (ORDER BY ngay ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING) AS tb_7_ngay_truoc
  FROM ngay
)
SELECT ngay, so_don,
       ROUND(tb_7_ngay_truoc, 1) AS tb_7_ngay_truoc,
       ROUND(so_don / tb_7_ngay_truoc, 2) AS he_so
FROM truot
WHERE so_don > 1.5 * tb_7_ngay_truoc
ORDER BY ngay;

-- [scm-f5-hang-abc-beverages] solution
WITH dt AS (
  SELECT s.item_nbr, SUM(s.unit_sales) * c.unit_price AS doanh_thu
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01' AND c.family = 'BEVERAGES'
  GROUP BY s.item_nbr, c.unit_price
  HAVING SUM(s.unit_sales) > 0
), luy_ke AS (
  SELECT item_nbr, doanh_thu,
         SUM(doanh_thu) OVER (ORDER BY doanh_thu DESC, item_nbr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
           / SUM(doanh_thu) OVER () AS ty_trong_luy_ke
  FROM dt
), xep AS (
  SELECT item_nbr, doanh_thu,
         CASE WHEN ty_trong_luy_ke <= 0.80 THEN 'A'
              WHEN ty_trong_luy_ke <= 0.95 THEN 'B'
              ELSE 'C' END AS hang
  FROM luy_ke
)
SELECT hang, COUNT(*) AS so_ma_hang,
       ROUND(SUM(doanh_thu), 0) AS doanh_thu,
       ROUND(100 * SUM(doanh_thu) / SUM(SUM(doanh_thu)) OVER (), 2) AS ty_trong_pct
FROM xep
GROUP BY hang
ORDER BY hang;

-- [scm-f5-hang-abc-beverages] wrong: quen_can_tren
-- Thiếu cận trên: hidden-1 có thêm 500 đơn vị của một mã BEVERAGES ngày 2017-08-01 (rớt ở hidden-1).
WITH dt AS (
  SELECT s.item_nbr, SUM(s.unit_sales) * c.unit_price AS doanh_thu
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND c.family = 'BEVERAGES'
  GROUP BY s.item_nbr, c.unit_price
  HAVING SUM(s.unit_sales) > 0
), luy_ke AS (
  SELECT item_nbr, doanh_thu,
         SUM(doanh_thu) OVER (ORDER BY doanh_thu DESC, item_nbr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
           / SUM(doanh_thu) OVER () AS ty_trong_luy_ke
  FROM dt
), xep AS (
  SELECT item_nbr, doanh_thu,
         CASE WHEN ty_trong_luy_ke <= 0.80 THEN 'A'
              WHEN ty_trong_luy_ke <= 0.95 THEN 'B'
              ELSE 'C' END AS hang
  FROM luy_ke
)
SELECT hang, COUNT(*) AS so_ma_hang,
       ROUND(SUM(doanh_thu), 0) AS doanh_thu,
       ROUND(100 * SUM(doanh_thu) / SUM(SUM(doanh_thu)) OVER (), 2) AS ty_trong_pct
FROM xep
GROUP BY hang
ORDER BY hang;

-- [scm-f5-hang-abc-beverages] wrong: luy_ke_sap_tang_dan
-- Cộng dồn theo doanh thu tăng dần: mã bán ít nhất lại vào hạng A (rớt ở public).
WITH dt AS (
  SELECT s.item_nbr, SUM(s.unit_sales) * c.unit_price AS doanh_thu
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01' AND c.family = 'BEVERAGES'
  GROUP BY s.item_nbr, c.unit_price
  HAVING SUM(s.unit_sales) > 0
), luy_ke AS (
  SELECT item_nbr, doanh_thu,
         SUM(doanh_thu) OVER (ORDER BY doanh_thu, item_nbr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
           / SUM(doanh_thu) OVER () AS ty_trong_luy_ke
  FROM dt
), xep AS (
  SELECT item_nbr, doanh_thu,
         CASE WHEN ty_trong_luy_ke <= 0.80 THEN 'A'
              WHEN ty_trong_luy_ke <= 0.95 THEN 'B'
              ELSE 'C' END AS hang
  FROM luy_ke
)
SELECT hang, COUNT(*) AS so_ma_hang,
       ROUND(SUM(doanh_thu), 0) AS doanh_thu,
       ROUND(100 * SUM(doanh_thu) / SUM(SUM(doanh_thu)) OVER (), 2) AS ty_trong_pct
FROM xep
GROUP BY hang
ORDER BY hang;

-- [scm-f6-giao-dich-cung-ky] solution
WITH cua_hang AS (
  SELECT store_nbr
  FROM transactions
  GROUP BY store_nbr
  HAVING SUM(`date` >= '2016-01-01' AND `date` < '2016-02-01') > 0
     AND SUM(`date` >= '2017-07-01' AND `date` < '2017-08-01') > 0
), thang AS (
  SELECT st.type, DATE_FORMAT(t.`date`, '%Y-%m') AS thang, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN cua_hang c ON c.store_nbr = t.store_nbr
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, DATE_FORMAT(t.`date`, '%Y-%m')
), so_sanh AS (
  SELECT type, thang, luot_gd,
         LAG(luot_gd, 12) OVER (PARTITION BY type ORDER BY thang) AS luot_gd_cung_ky
  FROM thang
)
SELECT type AS loai_cua_hang, thang, luot_gd, luot_gd_cung_ky,
       ROUND(100 * (luot_gd - luot_gd_cung_ky) / luot_gd_cung_ky, 1) AS thay_doi_pct
FROM so_sanh
WHERE thang >= '2017-01'
ORDER BY loai_cua_hang, thang;

-- [scm-f6-giao-dich-cung-ky] wrong: lag_mot_thang
-- LAG(luot_gd) lấy tháng liền trước thay cho cùng tháng năm trước (rớt ở public).
WITH cua_hang AS (
  SELECT store_nbr
  FROM transactions
  GROUP BY store_nbr
  HAVING SUM(`date` >= '2016-01-01' AND `date` < '2016-02-01') > 0
     AND SUM(`date` >= '2017-07-01' AND `date` < '2017-08-01') > 0
), thang AS (
  SELECT st.type, DATE_FORMAT(t.`date`, '%Y-%m') AS thang, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN cua_hang c ON c.store_nbr = t.store_nbr
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, DATE_FORMAT(t.`date`, '%Y-%m')
), so_sanh AS (
  SELECT type, thang, luot_gd,
         LAG(luot_gd) OVER (PARTITION BY type ORDER BY thang) AS luot_gd_cung_ky
  FROM thang
)
SELECT type AS loai_cua_hang, thang, luot_gd, luot_gd_cung_ky,
       ROUND(100 * (luot_gd - luot_gd_cung_ky) / luot_gd_cung_ky, 1) AS thay_doi_pct
FROM so_sanh
WHERE thang >= '2017-01'
ORDER BY loai_cua_hang, thang;

-- [scm-f6-giao-dich-cung-ky] wrong: loc_nam_truoc_khi_lag
-- Lọc năm 2017 ngay từ đầu nên LAG 12 không còn dữ liệu năm 2016 (rớt ở public).
WITH cua_hang AS (
  SELECT store_nbr
  FROM transactions
  GROUP BY store_nbr
  HAVING SUM(`date` >= '2016-01-01' AND `date` < '2016-02-01') > 0
     AND SUM(`date` >= '2017-07-01' AND `date` < '2017-08-01') > 0
), thang AS (
  SELECT st.type, DATE_FORMAT(t.`date`, '%Y-%m') AS thang, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN cua_hang c ON c.store_nbr = t.store_nbr
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2017-01-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, DATE_FORMAT(t.`date`, '%Y-%m')
), so_sanh AS (
  SELECT type, thang, luot_gd,
         LAG(luot_gd, 12) OVER (PARTITION BY type ORDER BY thang) AS luot_gd_cung_ky
  FROM thang
)
SELECT type AS loai_cua_hang, thang, luot_gd, luot_gd_cung_ky,
       ROUND(100 * (luot_gd - luot_gd_cung_ky) / luot_gd_cung_ky, 1) AS thay_doi_pct
FROM so_sanh
ORDER BY loai_cua_hang, thang;

-- [scm-f6-giao-dich-cung-ky] wrong: tinh_ca_cua_hang_moi
-- Không loại cửa hàng mở trong kỳ: loại A cộng thêm cửa hàng 52 mở tháng 4/2017 (rớt ở public).
WITH thang AS (
  SELECT st.type, DATE_FORMAT(t.`date`, '%Y-%m') AS thang, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, DATE_FORMAT(t.`date`, '%Y-%m')
), so_sanh AS (
  SELECT type, thang, luot_gd,
         LAG(luot_gd, 12) OVER (PARTITION BY type ORDER BY thang) AS luot_gd_cung_ky
  FROM thang
)
SELECT type AS loai_cua_hang, thang, luot_gd, luot_gd_cung_ky,
       ROUND(100 * (luot_gd - luot_gd_cung_ky) / luot_gd_cung_ky, 1) AS thay_doi_pct
FROM so_sanh
WHERE thang >= '2017-01'
ORDER BY loai_cua_hang, thang;

-- [scm-f7-cua-hang-dong-khach-nhat] starter
WITH gd AS (
  SELECT st.type, st.store_nbr, st.city, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2017-07-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, st.store_nbr, st.city
), xep AS (
  SELECT type, store_nbr, city, luot_gd,
         ROW_NUMBER() OVER (ORDER BY luot_gd DESC, store_nbr) AS hang
  FROM gd
)
SELECT type, store_nbr, city, luot_gd
FROM xep
WHERE hang = 1
ORDER BY type;

-- [scm-f7-cua-hang-dong-khach-nhat] solution
WITH gd AS (
  SELECT st.type, st.store_nbr, st.city, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2017-07-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, st.store_nbr, st.city
), xep AS (
  SELECT type, store_nbr, city, luot_gd,
         ROW_NUMBER() OVER (PARTITION BY type ORDER BY luot_gd DESC, store_nbr) AS hang
  FROM gd
)
SELECT type, store_nbr, city, luot_gd
FROM xep
WHERE hang = 1
ORDER BY type;

-- [scm-f7-cua-hang-dong-khach-nhat] wrong: chia_nhom_theo_thanh_pho
-- Chia nhóm theo thành phố thay cho loại cửa hàng (rớt ở public).
WITH gd AS (
  SELECT st.type, st.store_nbr, st.city, SUM(t.transactions) AS luot_gd
  FROM transactions t
  JOIN stores st ON st.store_nbr = t.store_nbr
  WHERE t.`date` >= '2017-07-01' AND t.`date` < '2017-08-01'
  GROUP BY st.type, st.store_nbr, st.city
), xep AS (
  SELECT type, store_nbr, city, luot_gd,
         ROW_NUMBER() OVER (PARTITION BY city ORDER BY luot_gd DESC, store_nbr) AS hang
  FROM gd
)
SELECT type, store_nbr, city, luot_gd
FROM xep
WHERE hang = 1
ORDER BY type;

-- [scm-f8-luy-ke-nhan-hang-ncc] starter
SELECT supplier_id, po_id, received_date, qty_received,
       SUM(qty_received) OVER (ORDER BY received_date) AS luy_ke
FROM purchase_orders
WHERE supplier_id IN ('SUP_027', 'SUP_053', 'SUP_063')
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
ORDER BY supplier_id, received_date, po_id;

-- [scm-f8-luy-ke-nhan-hang-ncc] solution
SELECT supplier_id, po_id, received_date, qty_received,
       SUM(qty_received) OVER (PARTITION BY supplier_id ORDER BY received_date, po_id
                               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS luy_ke
FROM purchase_orders
WHERE supplier_id IN ('SUP_027', 'SUP_053', 'SUP_063')
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
ORDER BY supplier_id, received_date, po_id;

-- [scm-f8-luy-ke-nhan-hang-ncc] wrong: chi_them_partition
-- Chỉ thêm PARTITION BY, giữ khung mặc định: các đơn về cùng ngày có chung một số luỹ kế (rớt ở public).
SELECT supplier_id, po_id, received_date, qty_received,
       SUM(qty_received) OVER (PARTITION BY supplier_id ORDER BY received_date) AS luy_ke
FROM purchase_orders
WHERE supplier_id IN ('SUP_027', 'SUP_053', 'SUP_063')
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
ORDER BY supplier_id, received_date, po_id;

-- [scm-f8-luy-ke-nhan-hang-ncc] wrong: chi_sua_khung
-- Sửa khung và tiêu chí phụ nhưng không chia nhóm theo nhà cung cấp: luỹ kế cộng nối sang nhà cung cấp sau (rớt ở public).
SELECT supplier_id, po_id, received_date, qty_received,
       SUM(qty_received) OVER (ORDER BY supplier_id, received_date, po_id
                               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS luy_ke
FROM purchase_orders
WHERE supplier_id IN ('SUP_027', 'SUP_053', 'SUP_063')
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
ORDER BY supplier_id, received_date, po_id;

-- [scm-f9-huy-thang-truoc-theo-kho] starter
WITH thang AS (
  SELECT dest_hub_id, DATE_FORMAT(order_date, '%Y-%m') AS thang,
         100 * AVG(is_cancelled) AS ty_le_huy
  FROM orders
  WHERE order_date >= '2017-01-01' AND order_date < '2017-08-01'
  GROUP BY dest_hub_id, DATE_FORMAT(order_date, '%Y-%m')
)
SELECT dest_hub_id, thang,
       ROUND(ty_le_huy, 2) AS ty_le_huy_pct,
       ROUND(ty_le_huy - LAG(ty_le_huy) OVER (ORDER BY dest_hub_id, thang), 2) AS thay_doi_diem
FROM thang
ORDER BY dest_hub_id, thang;

-- [scm-f9-huy-thang-truoc-theo-kho] solution
WITH thang AS (
  SELECT dest_hub_id, DATE_FORMAT(order_date, '%Y-%m') AS thang,
         100 * AVG(is_cancelled) AS ty_le_huy
  FROM orders
  WHERE order_date >= '2017-01-01' AND order_date < '2017-08-01'
  GROUP BY dest_hub_id, DATE_FORMAT(order_date, '%Y-%m')
)
SELECT dest_hub_id, thang,
       ROUND(ty_le_huy, 2) AS ty_le_huy_pct,
       ROUND(ty_le_huy - LAG(ty_le_huy) OVER (PARTITION BY dest_hub_id ORDER BY thang), 2) AS thay_doi_diem
FROM thang
ORDER BY dest_hub_id, thang;

-- [scm-f9-huy-thang-truoc-theo-kho] wrong: dung_lead_thay_lag
-- Dùng LEAD (tháng sau) thay cho LAG (tháng trước) (rớt ở public).
WITH thang AS (
  SELECT dest_hub_id, DATE_FORMAT(order_date, '%Y-%m') AS thang,
         100 * AVG(is_cancelled) AS ty_le_huy
  FROM orders
  WHERE order_date >= '2017-01-01' AND order_date < '2017-08-01'
  GROUP BY dest_hub_id, DATE_FORMAT(order_date, '%Y-%m')
)
SELECT dest_hub_id, thang,
       ROUND(ty_le_huy, 2) AS ty_le_huy_pct,
       ROUND(LEAD(ty_le_huy) OVER (PARTITION BY dest_hub_id ORDER BY thang) - ty_le_huy, 2) AS thay_doi_diem
FROM thang
ORDER BY dest_hub_id, thang;

-- ===================================================================== CASE STUDY

-- [scm-c7-fill-rate-thang-3.b1] solution
SELECT ym AS ky,
       ROUND(100 * (1 - SUM(thieu_hut) / SUM(sold)), 2) AS fill_rate_pct,
       ROUND(100 * COUNT(CASE WHEN thieu_hut > 0 THEN 1 END) / COUNT(*), 2) AS ty_le_dong_thieu_hut_pct
FROM inventory_snapshots
WHERE ym >= '2017-01' AND ym <= '2017-07'
GROUP BY ym
ORDER BY ky;

-- [scm-c7-fill-rate-thang-3.b1] wrong: gom_ca_ky_chua_du
-- Không loại kỳ 2017-08 (chỉ có nửa tháng) (rớt ở public).
SELECT ym AS ky,
       ROUND(100 * (1 - SUM(thieu_hut) / SUM(sold)), 2) AS fill_rate_pct,
       ROUND(100 * COUNT(CASE WHEN thieu_hut > 0 THEN 1 END) / COUNT(*), 2) AS ty_le_dong_thieu_hut_pct
FROM inventory_snapshots
WHERE ym >= '2017-01'
GROUP BY ym
ORDER BY ky;

-- [scm-c7-fill-rate-thang-3.b2] solution
WITH nganh AS (
  SELECT it.family, i.ym, SUM(i.sold) AS ban, SUM(i.thieu_hut) AS thieu
  FROM inventory_snapshots i
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym IN ('2017-02', '2017-03')
  GROUP BY it.family, i.ym
), so_sanh AS (
  SELECT family,
         SUM(CASE WHEN ym = '2017-02' THEN thieu END) AS thieu_t2,
         SUM(CASE WHEN ym = '2017-03' THEN thieu END) AS thieu_t3,
         100 * (1 - SUM(CASE WHEN ym = '2017-03' THEN thieu END) / SUM(CASE WHEN ym = '2017-03' THEN ban END)) AS fr_t3
  FROM nganh
  GROUP BY family
)
SELECT family,
       ROUND(thieu_t3 - thieu_t2, 0) AS thieu_hut_tang,
       ROUND(fr_t3, 2) AS fill_rate_t3_pct
FROM so_sanh
ORDER BY thieu_hut_tang DESC, family
LIMIT 5;

-- [scm-c7-fill-rate-thang-3.b2] wrong: lay_tong_thieu_hut_thang_3
-- Lấy tổng thiếu hụt của tháng 3 thay cho phần tăng so với tháng 2 (rớt ở public).
WITH nganh AS (
  SELECT it.family, SUM(i.sold) AS ban, SUM(i.thieu_hut) AS thieu
  FROM inventory_snapshots i
  JOIN items it ON it.item_nbr = i.item_nbr
  WHERE i.ym = '2017-03'
  GROUP BY it.family
)
SELECT family,
       ROUND(thieu, 0) AS thieu_hut_tang,
       ROUND(100 * (1 - thieu / ban), 2) AS fill_rate_t3_pct
FROM nganh
ORDER BY thieu_hut_tang DESC, family
LIMIT 5;

-- [scm-c7-fill-rate-thang-3.b3] solution
SELECT ym AS ky,
       ROUND(SUM(sold) / DAY(LAST_DAY(CONCAT(ym, '-01'))), 0) AS ban_binh_quan_ngay,
       ROUND(SUM(received) / SUM(sold), 2) AS ty_le_nhap_tren_ban
FROM inventory_snapshots
WHERE ym >= '2017-01' AND ym <= '2017-07'
GROUP BY ym
ORDER BY ky;

-- [scm-c7-fill-rate-thang-3.b3] wrong: khong_chia_so_ngay
-- So lượng bán cả tháng: tháng 2 có 28 ngày nên trông như nhu cầu tháng 3 tăng (rớt ở public).
SELECT ym AS ky,
       ROUND(SUM(sold), 0) AS ban_binh_quan_ngay,
       ROUND(SUM(received) / SUM(sold), 2) AS ty_le_nhap_tren_ban
FROM inventory_snapshots
WHERE ym >= '2017-01' AND ym <= '2017-07'
GROUP BY ym
ORDER BY ky;

-- [scm-c8-giao-tre-ngay-cao-diem.b1] solution
WITH don AS (
  SELECT o.*,
         CASE WHEN EXISTS (SELECT 1 FROM event_calendar e WHERE e.`date` = o.order_date) THEN 'cao_diem'
              WHEN NOT EXISTS (SELECT 1 FROM event_calendar e
                               WHERE ABS(DATEDIFF(e.`date`, o.order_date)) <= 2) THEN 'nen'
         END AS loai_ngay
  FROM orders o
  WHERE o.is_cancelled = 0 AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
)
SELECT loai_ngay, COUNT(*) AS so_don,
       ROUND(100 * AVG(on_time), 2) AS ty_le_dung_han_pct,
       ROUND(AVG(lead_time_total_h), 1) AS lead_time_tb_h
FROM don
WHERE loai_ngay IS NOT NULL
GROUP BY loai_ngay
ORDER BY loai_ngay;

-- [scm-c8-giao-tre-ngay-cao-diem.b1] wrong: tinh_ca_don_huy
-- Không loại đơn huỷ (rớt ở public).
WITH don AS (
  SELECT o.*,
         CASE WHEN EXISTS (SELECT 1 FROM event_calendar e WHERE e.`date` = o.order_date) THEN 'cao_diem'
              WHEN NOT EXISTS (SELECT 1 FROM event_calendar e
                               WHERE ABS(DATEDIFF(e.`date`, o.order_date)) <= 2) THEN 'nen'
         END AS loai_ngay
  FROM orders o
  WHERE o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
)
SELECT loai_ngay, COUNT(*) AS so_don,
       ROUND(100 * AVG(on_time), 2) AS ty_le_dung_han_pct,
       ROUND(AVG(lead_time_total_h), 1) AS lead_time_tb_h
FROM don
WHERE loai_ngay IS NOT NULL
GROUP BY loai_ngay
ORDER BY loai_ngay;

-- [scm-c8-giao-tre-ngay-cao-diem.b2] solution
WITH don AS (
  SELECT o.*,
         CASE WHEN EXISTS (SELECT 1 FROM event_calendar e WHERE e.`date` = o.order_date) THEN 'cao_diem'
              WHEN NOT EXISTS (SELECT 1 FROM event_calendar e
                               WHERE ABS(DATEDIFF(e.`date`, o.order_date)) <= 2) THEN 'nen'
         END AS loai_ngay
  FROM orders o
  WHERE o.is_cancelled = 0 AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
), tp AS (
  SELECT loai_ngay,
         AVG(t1_tao_don_pick_h) AS t1, AVG(t2_pick_xuat_h) AS t2,
         AVG(t3a_di_chuyen_h) AS t3a, AVG(t3b_sorting_h) AS t3b, AVG(t4_kho_giao_h) AS t4
  FROM don
  WHERE loai_ngay IS NOT NULL
  GROUP BY loai_ngay
)
SELECT 't1_tao_don_pick_h' AS chang, ROUND(MAX(CASE WHEN loai_ngay = 'nen' THEN t1 END), 2) AS gio_nen,
       ROUND(MAX(CASE WHEN loai_ngay = 'cao_diem' THEN t1 END), 2) AS gio_cao_diem FROM tp
UNION ALL
SELECT 't2_pick_xuat_h', ROUND(MAX(CASE WHEN loai_ngay = 'nen' THEN t2 END), 2),
       ROUND(MAX(CASE WHEN loai_ngay = 'cao_diem' THEN t2 END), 2) FROM tp
UNION ALL
SELECT 't3a_di_chuyen_h', ROUND(MAX(CASE WHEN loai_ngay = 'nen' THEN t3a END), 2),
       ROUND(MAX(CASE WHEN loai_ngay = 'cao_diem' THEN t3a END), 2) FROM tp
UNION ALL
SELECT 't3b_sorting_h', ROUND(MAX(CASE WHEN loai_ngay = 'nen' THEN t3b END), 2),
       ROUND(MAX(CASE WHEN loai_ngay = 'cao_diem' THEN t3b END), 2) FROM tp
UNION ALL
SELECT 't4_kho_giao_h', ROUND(MAX(CASE WHEN loai_ngay = 'nen' THEN t4 END), 2),
       ROUND(MAX(CASE WHEN loai_ngay = 'cao_diem' THEN t4 END), 2) FROM tp;

-- [scm-c8-giao-tre-ngay-cao-diem.b3] solution
WITH don AS (
  SELECT o.dest_hub_id, o.on_time, o.t3b_sorting_h
  FROM orders o
  JOIN event_calendar e ON e.`date` = o.order_date
  WHERE o.is_cancelled = 0 AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
), kho AS (
  SELECT dest_hub_id, COUNT(*) AS so_don,
         100 * AVG(on_time) AS ty_le_dung_han, AVG(t3b_sorting_h) AS phan_loai_tb
  FROM don
  GROUP BY dest_hub_id
)
SELECT dest_hub_id, so_don,
       ROUND(ty_le_dung_han, 2) AS ty_le_dung_han_pct,
       ROUND(phan_loai_tb, 1) AS phan_loai_tb_h,
       ROUND(100 * so_don / SUM(so_don) OVER (), 1) AS ty_trong_don_pct
FROM kho
ORDER BY phan_loai_tb_h DESC, dest_hub_id;

-- [scm-c8-giao-tre-ngay-cao-diem.b4] solution
WITH ngay AS (
  SELECT w.hub_id, w.workload_ratio,
         CASE WHEN e.`date` IS NOT NULL THEN 1 ELSE 0 END AS la_cao_diem
  FROM warehouse_daily_ops w
  LEFT JOIN event_calendar e ON e.`date` = w.`date`
  WHERE w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01'
)
SELECT hub_id,
       ROUND(AVG(CASE WHEN la_cao_diem = 0 THEN workload_ratio END), 2) AS ty_le_tai_ngay_khac,
       ROUND(AVG(CASE WHEN la_cao_diem = 1 THEN workload_ratio END), 2) AS ty_le_tai_cao_diem,
       COUNT(CASE WHEN la_cao_diem = 1 AND workload_ratio > 1 THEN 1 END) AS so_ngay_qua_tai_cao_diem
FROM ngay
GROUP BY hub_id
ORDER BY ty_le_tai_cao_diem DESC, hub_id;
