-- solution.sql: gói 3 bộ Supply Chain (scm). Module 5 Joins, Module 6 Subqueries, case c5, c6.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên scm (public) và scm_hidden_1 (hidden-1).

-- ================================================================ MODULE 5 · JOINS

-- [scm-j1-ban-theo-loai-cua-hang] solution
SELECT st.type AS loai_cua_hang,
       COUNT(DISTINCT s.store_nbr) AS so_cua_hang,
       ROUND(SUM(s.unit_sales), 0) AS tong_ban
FROM sales s
JOIN stores st ON st.store_nbr = s.store_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY st.type
ORDER BY tong_ban DESC, loai_cua_hang;

-- [scm-j1-ban-theo-loai-cua-hang] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có thêm một dòng bán ngày 2017-08-01.
SELECT st.type AS loai_cua_hang,
       COUNT(DISTINCT s.store_nbr) AS so_cua_hang,
       ROUND(SUM(s.unit_sales), 0) AS tong_ban
FROM sales s
JOIN stores st ON st.store_nbr = s.store_nbr
WHERE s.`date` >= '2017-07-01'
GROUP BY st.type
ORDER BY tong_ban DESC, loai_cua_hang;

-- [scm-j1-ban-theo-loai-cua-hang] wrong: dem_dong_thay_vi_cua_hang
SELECT st.type AS loai_cua_hang,
       COUNT(*) AS so_cua_hang,
       ROUND(SUM(s.unit_sales), 0) AS tong_ban
FROM sales s
JOIN stores st ON st.store_nbr = s.store_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY st.type
ORDER BY tong_ban DESC, loai_cua_hang;

-- [scm-j2-ma-chua-tung-dat-mua] solution
SELECT i.family, COUNT(*) AS so_ma
FROM items i
LEFT JOIN purchase_orders p ON p.item_nbr = i.item_nbr
WHERE p.po_id IS NULL
GROUP BY i.family
ORDER BY so_ma DESC, i.family;

-- [scm-j2-ma-chua-tung-dat-mua] wrong: inner_join_mat_dong
SELECT i.family, COUNT(*) AS so_ma
FROM items i
JOIN purchase_orders p ON p.item_nbr = i.item_nbr
WHERE p.po_id IS NULL
GROUP BY i.family
ORDER BY so_ma DESC, i.family;

-- [scm-j2-ma-chua-tung-dat-mua] wrong: nham_don_chua_ve
-- Lấy cột ngày nhận trống (đơn chưa về) thay cho dấu hiệu không có cặp.
SELECT i.family, COUNT(DISTINCT i.item_nbr) AS so_ma
FROM items i
LEFT JOIN purchase_orders p ON p.item_nbr = i.item_nbr
WHERE p.received_date IS NULL
GROUP BY i.family
ORDER BY so_ma DESC, i.family;

-- [scm-j3-giao-dich-cua-hang-loai-a] solution
SELECT COUNT(DISTINCT t.store_nbr) AS so_cua_hang,
       ROUND(AVG(t.transactions), 1) AS luot_gd_tb_ngay
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE st.type = 'A'
  AND t.`date` >= '2017-07-01' AND t.`date` < '2017-08-01';

-- [scm-j3-giao-dich-cua-hang-loai-a] wrong: thieu_can_tren
SELECT COUNT(DISTINCT t.store_nbr) AS so_cua_hang,
       ROUND(AVG(t.transactions), 1) AS luot_gd_tb_ngay
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE st.type = 'A'
  AND t.`date` >= '2017-07-01';

-- [scm-j3-giao-dich-cua-hang-loai-a] wrong: chia_cho_31_ngay_cua_ca_chuoi
SELECT COUNT(DISTINCT t.store_nbr) AS so_cua_hang,
       ROUND(SUM(t.transactions) / 31, 1) AS luot_gd_tb_ngay
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE st.type = 'A'
  AND t.`date` >= '2017-07-01' AND t.`date` < '2017-08-01';

-- [scm-j4-ncc-co-lo-truot-theo-dc] starter
SELECT s.warehouse_id, COUNT(*) AS so_ncc
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.inspection_result = 'Fail'
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j4-ncc-co-lo-truot-theo-dc] solution
SELECT s.warehouse_id, COUNT(DISTINCT p.supplier_id) AS so_ncc
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.inspection_result = 'Fail'
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j4-ncc-co-lo-truot-theo-dc] wrong: bo_dieu_kien_lo_truot
SELECT s.warehouse_id, COUNT(DISTINCT p.supplier_id) AS so_ncc
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j4-ncc-co-lo-truot-theo-dc] wrong: dem_ncc_cua_dc
-- Đếm mọi NCC của DC trong danh mục, không xét lô trượt.
SELECT s.warehouse_id, COUNT(*) AS so_ncc
FROM suppliers s
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j5-lead-time-theo-tuyen-kho] solution
SELECT kx.city AS kho_xuat, kd.city AS kho_dich,
       COUNT(*) AS so_don,
       ROUND(AVG(o.lead_time_total_h), 1) AS lead_time_tb
FROM orders o
JOIN sorting_hubs kx ON kx.hub_id = o.origin_hub_id
JOIN sorting_hubs kd ON kd.hub_id = o.dest_hub_id
WHERE o.is_cancelled = 0
  AND o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
GROUP BY kx.city, kd.city
ORDER BY lead_time_tb DESC, kho_xuat, kho_dich;

-- [scm-j5-lead-time-theo-tuyen-kho] wrong: tinh_ca_don_huy
SELECT kx.city AS kho_xuat, kd.city AS kho_dich,
       COUNT(*) AS so_don,
       ROUND(AVG(o.lead_time_total_h), 1) AS lead_time_tb
FROM orders o
JOIN sorting_hubs kx ON kx.hub_id = o.origin_hub_id
JOIN sorting_hubs kd ON kd.hub_id = o.dest_hub_id
WHERE o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
GROUP BY kx.city, kd.city
ORDER BY lead_time_tb DESC, kho_xuat, kho_dich;

-- [scm-j5-lead-time-theo-tuyen-kho] wrong: noi_mot_lan_cho_hai_kho
-- Chỉ nối kho đích rồi lấy thành phố của kho đích cho cả hai cột.
SELECT kd.city AS kho_xuat, kd.city AS kho_dich,
       COUNT(*) AS so_don,
       ROUND(AVG(o.lead_time_total_h), 1) AS lead_time_tb
FROM orders o
JOIN sorting_hubs kd ON kd.hub_id = o.dest_hub_id
WHERE o.is_cancelled = 0
  AND o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
GROUP BY kd.city
ORDER BY lead_time_tb DESC, kho_xuat, kho_dich;

-- [scm-j6-bien-ln-gop-nganh-hang] solution
SELECT c.family,
       ROUND(SUM(s.unit_sales * c.unit_price), 0) AS doanh_thu,
       ROUND(100 * SUM(s.unit_sales * (c.unit_price - c.unit_cost))
                 / SUM(s.unit_sales * c.unit_price), 2) AS bien_ln_gop_pct
FROM sales s
JOIN item_costs c ON c.item_nbr = s.item_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY c.family
ORDER BY bien_ln_gop_pct DESC, c.family;

-- [scm-j6-bien-ln-gop-nganh-hang] wrong: thieu_can_tren
SELECT c.family,
       ROUND(SUM(s.unit_sales * c.unit_price), 0) AS doanh_thu,
       ROUND(100 * SUM(s.unit_sales * (c.unit_price - c.unit_cost))
                 / SUM(s.unit_sales * c.unit_price), 2) AS bien_ln_gop_pct
FROM sales s
JOIN item_costs c ON c.item_nbr = s.item_nbr
WHERE s.`date` >= '2017-07-01'
GROUP BY c.family
ORDER BY bien_ln_gop_pct DESC, c.family;

-- [scm-j6-bien-ln-gop-nganh-hang] wrong: trung_binh_bien_tung_dong
SELECT c.family,
       ROUND(SUM(s.unit_sales * c.unit_price), 0) AS doanh_thu,
       ROUND(100 * AVG((c.unit_price - c.unit_cost) / c.unit_price), 2) AS bien_ln_gop_pct
FROM sales s
JOIN item_costs c ON c.item_nbr = s.item_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY c.family
ORDER BY bien_ln_gop_pct DESC, c.family;

-- [scm-j7-hang-loi-theo-dc-gap-doi] starter
SELECT s.warehouse_id,
       COUNT(*) AS so_don,
       ROUND(SUM(p.qty_defect), 0) AS hang_loi,
       ROUND(100 * SUM(p.qty_defect) / SUM(p.qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN items i ON i.item_nbr = p.item_nbr
JOIN suppliers s ON s.family = i.family
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j7-hang-loi-theo-dc-gap-doi] solution
SELECT s.warehouse_id,
       COUNT(*) AS so_don,
       ROUND(SUM(p.qty_defect), 0) AS hang_loi,
       ROUND(100 * SUM(p.qty_defect) / SUM(p.qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j7-hang-loi-theo-dc-gap-doi] wrong: chi_dem_distinct_don
-- Sửa số đơn bằng COUNT(DISTINCT) nhưng giữ cách nối theo ngành hàng: tổng hàng lỗi vẫn bị cộng hai lần.
SELECT s.warehouse_id,
       COUNT(DISTINCT p.po_id) AS so_don,
       ROUND(SUM(p.qty_defect), 0) AS hang_loi,
       ROUND(100 * SUM(p.qty_defect) / SUM(p.qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN items i ON i.item_nbr = p.item_nbr
JOIN suppliers s ON s.family = i.family
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY s.warehouse_id;

-- [scm-j8-ty-trong-ban-khuyen-mai] solution
SELECT i.family,
       ROUND(SUM(CASE WHEN s.onpromotion = 1 THEN s.unit_sales ELSE 0 END), 0) AS ban_km,
       ROUND(SUM(CASE WHEN s.onpromotion = 0 THEN s.unit_sales ELSE 0 END), 0) AS ban_thuong,
       ROUND(100 * SUM(CASE WHEN s.onpromotion = 1 THEN s.unit_sales ELSE 0 END)
                 / SUM(s.unit_sales), 2) AS ty_trong_km_pct
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY i.family
ORDER BY ty_trong_km_pct DESC, i.family;

-- [scm-j8-ty-trong-ban-khuyen-mai] wrong: thieu_can_tren
SELECT i.family,
       ROUND(SUM(CASE WHEN s.onpromotion = 1 THEN s.unit_sales ELSE 0 END), 0) AS ban_km,
       ROUND(SUM(CASE WHEN s.onpromotion = 0 THEN s.unit_sales ELSE 0 END), 0) AS ban_thuong,
       ROUND(100 * SUM(CASE WHEN s.onpromotion = 1 THEN s.unit_sales ELSE 0 END)
                 / SUM(s.unit_sales), 2) AS ty_trong_km_pct
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.`date` >= '2017-07-01'
GROUP BY i.family
ORDER BY ty_trong_km_pct DESC, i.family;

-- [scm-j8-ty-trong-ban-khuyen-mai] wrong: ty_trong_theo_so_dong
SELECT i.family,
       ROUND(SUM(CASE WHEN s.onpromotion = 1 THEN s.unit_sales ELSE 0 END), 0) AS ban_km,
       ROUND(SUM(CASE WHEN s.onpromotion = 0 THEN s.unit_sales ELSE 0 END), 0) AS ban_thuong,
       ROUND(100 * COUNT(CASE WHEN s.onpromotion = 1 THEN 1 END) / COUNT(*), 2) AS ty_trong_km_pct
FROM sales s
JOIN items i ON i.item_nbr = s.item_nbr
WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY i.family
ORDER BY ty_trong_km_pct DESC, i.family;

-- [scm-j9-don-mua-thang-7-moi-ncc] starter
SELECT s.supplier_id, COUNT(*) AS so_don
FROM suppliers s
LEFT JOIN purchase_orders p ON p.supplier_id = s.supplier_id
WHERE p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
GROUP BY s.supplier_id
ORDER BY so_don DESC, s.supplier_id;

-- [scm-j9-don-mua-thang-7-moi-ncc] solution
SELECT s.supplier_id, COUNT(p.po_id) AS so_don
FROM suppliers s
LEFT JOIN purchase_orders p
       ON p.supplier_id = s.supplier_id
      AND p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
GROUP BY s.supplier_id
ORDER BY so_don DESC, s.supplier_id;

-- [scm-j9-don-mua-thang-7-moi-ncc] wrong: dem_sao_tinh_ncc_trong_la_1
-- Đã chuyển điều kiện vào ON nhưng vẫn đếm COUNT(*): NCC không có đơn nào ra 1.
SELECT s.supplier_id, COUNT(*) AS so_don
FROM suppliers s
LEFT JOIN purchase_orders p
       ON p.supplier_id = s.supplier_id
      AND p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
GROUP BY s.supplier_id
ORDER BY so_don DESC, s.supplier_id;

-- ================================================================ MODULE 6 · SUBQUERIES

-- [scm-q1-ncc-lead-time-tren-binh-quan] solution
SELECT supplier_id,
       COUNT(*) AS so_don,
       ROUND(AVG(DATEDIFF(received_date, po_date)), 2) AS lead_time_tb
FROM purchase_orders
WHERE received_date IS NOT NULL
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01'
GROUP BY supplier_id
HAVING AVG(DATEDIFF(received_date, po_date)) >
       (SELECT AVG(DATEDIFF(received_date, po_date))
        FROM purchase_orders
        WHERE received_date IS NOT NULL
          AND po_date >= '2016-01-01' AND po_date < '2017-01-01')
ORDER BY lead_time_tb DESC, supplier_id;

-- [scm-q1-ncc-lead-time-tren-binh-quan] wrong: chi_loc_nam_trong_truy_van_con
SELECT supplier_id,
       COUNT(*) AS so_don,
       ROUND(AVG(DATEDIFF(received_date, po_date)), 2) AS lead_time_tb
FROM purchase_orders
WHERE received_date IS NOT NULL
GROUP BY supplier_id
HAVING AVG(DATEDIFF(received_date, po_date)) >
       (SELECT AVG(DATEDIFF(received_date, po_date))
        FROM purchase_orders
        WHERE received_date IS NOT NULL
          AND po_date >= '2016-01-01' AND po_date < '2017-01-01')
ORDER BY lead_time_tb DESC, supplier_id;

-- [scm-q1-ncc-lead-time-tren-binh-quan] wrong: so_voi_lead_time_cam_ket
SELECT supplier_id,
       COUNT(*) AS so_don,
       ROUND(AVG(DATEDIFF(received_date, po_date)), 2) AS lead_time_tb
FROM purchase_orders
WHERE received_date IS NOT NULL
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01'
GROUP BY supplier_id
HAVING AVG(DATEDIFF(received_date, po_date)) >
       (SELECT AVG(promised_lead_days)
        FROM purchase_orders
        WHERE po_date >= '2016-01-01' AND po_date < '2017-01-01')
ORDER BY lead_time_tb DESC, supplier_id;

-- [scm-q2-ncc-co-lo-truot-thang-7] solution
SELECT s.supplier_id, s.supplier_name, s.family
FROM suppliers s
WHERE EXISTS (SELECT 1
              FROM purchase_orders p
              WHERE p.supplier_id = s.supplier_id
                AND p.inspection_result = 'Fail'
                AND p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01')
ORDER BY s.supplier_id;

-- [scm-q2-ncc-co-lo-truot-thang-7] wrong: join_lap_dong
SELECT s.supplier_id, s.supplier_name, s.family
FROM suppliers s
JOIN purchase_orders p ON p.supplier_id = s.supplier_id
WHERE p.inspection_result = 'Fail'
  AND p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
ORDER BY s.supplier_id;

-- [scm-q2-ncc-co-lo-truot-thang-7] wrong: thieu_can_tren
SELECT s.supplier_id, s.supplier_name, s.family
FROM suppliers s
WHERE s.supplier_id IN (SELECT p.supplier_id
                        FROM purchase_orders p
                        WHERE p.inspection_result = 'Fail'
                          AND p.po_date >= '2017-07-01')
ORDER BY s.supplier_id;

-- [scm-q3-ban-hang-kho-thang-7] solution
SELECT ROUND(SUM(unit_sales), 0) AS tong_ban
FROM sales
WHERE item_nbr IN (SELECT item_nbr FROM items WHERE perishable = 0)
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01';

-- [scm-q3-ban-hang-kho-thang-7] wrong: thieu_can_tren
SELECT ROUND(SUM(unit_sales), 0) AS tong_ban
FROM sales
WHERE item_nbr IN (SELECT item_nbr FROM items WHERE perishable = 0)
  AND `date` >= '2017-07-01';

-- [scm-q3-ban-hang-kho-thang-7] wrong: nham_hang_tuoi_song
SELECT ROUND(SUM(unit_sales), 0) AS tong_ban
FROM sales
WHERE item_nbr IN (SELECT item_nbr FROM items WHERE perishable = 1)
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01';

-- [scm-q4-cua-hang-tren-binh-quan-loai] solution
SELECT t.store_nbr, t.type AS loai_cua_hang,
       ROUND(t.tong_ban, 0) AS tong_ban,
       ROUND(b.tb_loai, 0) AS tb_loai
FROM (SELECT s.store_nbr, st.type, SUM(s.unit_sales) AS tong_ban
      FROM sales s
      JOIN stores st ON st.store_nbr = s.store_nbr
      WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
      GROUP BY s.store_nbr, st.type) t
JOIN (SELECT x.type, AVG(x.tong_ban) AS tb_loai
      FROM (SELECT s.store_nbr, st.type, SUM(s.unit_sales) AS tong_ban
            FROM sales s
            JOIN stores st ON st.store_nbr = s.store_nbr
            WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
            GROUP BY s.store_nbr, st.type) x
      GROUP BY x.type) b ON b.type = t.type
WHERE t.tong_ban > b.tb_loai
ORDER BY loai_cua_hang, tong_ban DESC, t.store_nbr;

-- [scm-q4-cua-hang-tren-binh-quan-loai] wrong: so_voi_binh_quan_ca_chuoi
SELECT t.store_nbr, t.type AS loai_cua_hang,
       ROUND(t.tong_ban, 0) AS tong_ban,
       ROUND(b.tb_loai, 0) AS tb_loai
FROM (SELECT s.store_nbr, st.type, SUM(s.unit_sales) AS tong_ban
      FROM sales s
      JOIN stores st ON st.store_nbr = s.store_nbr
      WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
      GROUP BY s.store_nbr, st.type) t
JOIN (SELECT AVG(x.tong_ban) AS tb_loai
      FROM (SELECT s.store_nbr, SUM(s.unit_sales) AS tong_ban
            FROM sales s
            WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
            GROUP BY s.store_nbr) x) b
WHERE t.tong_ban > b.tb_loai
ORDER BY loai_cua_hang, tong_ban DESC, t.store_nbr;

-- [scm-q4-cua-hang-tren-binh-quan-loai] wrong: binh_quan_theo_dong_ban
-- Lấy bình quân của từng dòng bán trong loại cửa hàng thay cho bình quân tổng của từng cửa hàng.
SELECT t.store_nbr, t.type AS loai_cua_hang,
       ROUND(t.tong_ban, 0) AS tong_ban,
       ROUND(b.tb_loai, 0) AS tb_loai
FROM (SELECT s.store_nbr, st.type, SUM(s.unit_sales) AS tong_ban
      FROM sales s
      JOIN stores st ON st.store_nbr = s.store_nbr
      WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
      GROUP BY s.store_nbr, st.type) t
JOIN (SELECT st.type, AVG(s.unit_sales) AS tb_loai
      FROM sales s
      JOIN stores st ON st.store_nbr = s.store_nbr
      WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
      GROUP BY st.type) b ON b.type = t.type
WHERE t.tong_ban > b.tb_loai
ORDER BY loai_cua_hang, tong_ban DESC, t.store_nbr;

-- [scm-q5-don-mua-gan-nhat-moi-ncc] solution
SELECT s.supplier_id, p.po_id, p.po_date, p.inspection_result
FROM suppliers s
JOIN purchase_orders p
  ON p.po_id = (SELECT p2.po_id
                FROM purchase_orders p2
                WHERE p2.supplier_id = s.supplier_id
                ORDER BY p2.po_date DESC, p2.po_id DESC
                LIMIT 1)
ORDER BY s.supplier_id;

-- [scm-q5-don-mua-gan-nhat-moi-ncc] wrong: noi_theo_ngay_lon_nhat
-- Lấy mọi đơn có ngày đặt bằng ngày lớn nhất: NCC đặt nhiều đơn cùng ngày ra nhiều dòng.
SELECT p.supplier_id, p.po_id, p.po_date, p.inspection_result
FROM purchase_orders p
JOIN (SELECT supplier_id, MAX(po_date) AS ngay_cuoi
      FROM purchase_orders
      GROUP BY supplier_id) m
  ON m.supplier_id = p.supplier_id AND m.ngay_cuoi = p.po_date
ORDER BY p.supplier_id, p.po_id;

-- [scm-q5-don-mua-gan-nhat-moi-ncc] wrong: max_tung_cot_rieng
-- Lấy MAX của từng cột riêng: mã đơn và kết quả kiểm định không cùng một đơn.
SELECT supplier_id, MAX(po_id) AS po_id, MAX(po_date) AS po_date, MAX(inspection_result) AS inspection_result
FROM purchase_orders
GROUP BY supplier_id
ORDER BY supplier_id;

-- [scm-q6-ty-trong-von-ton-nganh-hang] solution
SELECT i.family,
       ROUND(SUM(v.inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(v.inventory_value)
                 / (SELECT SUM(inventory_value) FROM inventory_snapshots WHERE ym = '2017-07'), 2) AS ty_trong_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = '2017-07'
GROUP BY i.family
ORDER BY SUM(v.inventory_value) DESC;

-- [scm-q6-ty-trong-von-ton-nganh-hang] wrong: mau_so_tat_ca_cac_ky
SELECT i.family,
       ROUND(SUM(v.inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(v.inventory_value)
                 / (SELECT SUM(inventory_value) FROM inventory_snapshots), 2) AS ty_trong_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = '2017-07'
GROUP BY i.family
ORDER BY SUM(v.inventory_value) DESC;

-- [scm-q7-ma-khong-ban-duoc-ra-0] starter
SELECT COUNT(*) AS so_ma
FROM items i
WHERE NOT EXISTS (SELECT 1
                  FROM sales s
                  WHERE s.item_nbr = item_nbr
                    AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01');

-- [scm-q7-ma-khong-ban-duoc-ra-0] solution
SELECT COUNT(*) AS so_ma
FROM items i
WHERE NOT EXISTS (SELECT 1
                  FROM sales s
                  WHERE s.item_nbr = i.item_nbr
                    AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01');

-- [scm-q7-ma-khong-ban-duoc-ra-0] wrong: dem_dong_ton_kho_khong_ban
-- Đếm mã có dòng tồn kho không bán ở một cửa hàng nào đó, khác với mã không bán được ở cửa hàng nào.
SELECT COUNT(DISTINCT item_nbr) AS so_ma
FROM inventory_snapshots
WHERE ym = '2017-07' AND sold = 0;

-- [scm-q8-ncc-loi-cao-hon-nganh] starter
SELECT s.supplier_id, s.family,
       ROUND(100 * SUM(p.qty_defect) / SUM(p.qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.supplier_id, s.family
HAVING SUM(p.qty_defect) / SUM(p.qty_received) >
       (SELECT SUM(p2.qty_defect) / SUM(p2.qty_received)
        FROM purchase_orders p2
        JOIN suppliers s2 ON s2.supplier_id = p2.supplier_id
        WHERE p2.received_date IS NOT NULL
          AND p2.po_date >= '2016-01-01' AND p2.po_date < '2017-01-01')
ORDER BY s.family, s.supplier_id;

-- [scm-q8-ncc-loi-cao-hon-nganh] solution
SELECT s.supplier_id, s.family,
       ROUND(100 * SUM(p.qty_defect) / SUM(p.qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.supplier_id, s.family
HAVING SUM(p.qty_defect) / SUM(p.qty_received) >
       (SELECT SUM(p2.qty_defect) / SUM(p2.qty_received)
        FROM purchase_orders p2
        JOIN suppliers s2 ON s2.supplier_id = p2.supplier_id
        WHERE s2.family = s.family
          AND p2.received_date IS NOT NULL
          AND p2.po_date >= '2016-01-01' AND p2.po_date < '2017-01-01')
ORDER BY s.family, s.supplier_id;

-- [scm-q8-ncc-loi-cao-hon-nganh] wrong: tuong_quan_nham_cot
-- Nối truy vấn con theo supplier_id: mỗi NCC so với chính nó nên không NCC nào lọt.
SELECT s.supplier_id, s.family,
       ROUND(100 * SUM(p.qty_defect) / SUM(p.qty_received), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.supplier_id, s.family
HAVING SUM(p.qty_defect) / SUM(p.qty_received) >
       (SELECT SUM(p2.qty_defect) / SUM(p2.qty_received)
        FROM purchase_orders p2
        JOIN suppliers s2 ON s2.supplier_id = p2.supplier_id
        WHERE s2.supplier_id = s.supplier_id
          AND p2.received_date IS NOT NULL
          AND p2.po_date >= '2016-01-01' AND p2.po_date < '2017-01-01')
ORDER BY s.family, s.supplier_id;

-- [scm-q9-diem-giao-theo-nhom-gia-tri] starter
SELECT CASE WHEN order_value_usd >= 24 THEN 'cao' ELSE 'thap' END AS nhom,
       COUNT(DISTINCT dest_point_id) AS so_diem_giao,
       COUNT(*) AS so_don
FROM orders
WHERE is_cancelled = 0
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
GROUP BY nhom
ORDER BY nhom;

-- [scm-q9-diem-giao-theo-nhom-gia-tri] solution
SELECT CASE WHEN d.gia_tri_tb >= 24 THEN 'cao' ELSE 'thap' END AS nhom,
       COUNT(*) AS so_diem_giao,
       SUM(d.so_don) AS so_don
FROM (SELECT dest_point_id,
             COUNT(*) AS so_don,
             AVG(order_value_usd) AS gia_tri_tb
      FROM orders
      WHERE is_cancelled = 0
        AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
      GROUP BY dest_point_id) d
GROUP BY nhom
ORDER BY nhom;

-- [scm-q9-diem-giao-theo-nhom-gia-tri] wrong: binh_quan_gom_don_huy
SELECT CASE WHEN d.gia_tri_tb >= 24 THEN 'cao' ELSE 'thap' END AS nhom,
       COUNT(*) AS so_diem_giao,
       SUM(d.so_don) AS so_don
FROM (SELECT dest_point_id,
             COUNT(*) AS so_don,
             AVG(order_value_usd) AS gia_tri_tb
      FROM orders
      WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
      GROUP BY dest_point_id) d
GROUP BY nhom
ORDER BY nhom;

-- ================================================================ CASE

-- [scm-c5-dc-nhan-hang-tre.b1] solution
SELECT s.warehouse_id,
       COUNT(*) AS so_don,
       ROUND(100 * SUM(p.received_date <= p.promised_date) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY ty_le_dung_han_pct, s.warehouse_id;

-- [scm-c5-dc-nhan-hang-tre.b1] wrong: dem_tre_thay_vi_dung_han
SELECT s.warehouse_id,
       COUNT(*) AS so_don,
       ROUND(100 * SUM(p.received_date > p.promised_date) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.warehouse_id
ORDER BY ty_le_dung_han_pct, s.warehouse_id;

-- [scm-c5-dc-nhan-hang-tre.b2] solution
SELECT p.supplier_id, s.city,
       COUNT(*) AS so_don,
       ROUND(AVG(p.km_supplier_to_dc), 0) AS km_tb,
       ROUND(AVG(p.promised_lead_days), 1) AS cam_ket_tb,
       ROUND(100 * SUM(p.received_date <= p.promised_date) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE s.warehouse_id = 'DC_HCM'
  AND p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY p.supplier_id, s.city
ORDER BY ty_le_dung_han_pct, p.supplier_id;

-- [scm-c5-dc-nhan-hang-tre.b2] wrong: quen_loc_nam
SELECT p.supplier_id, s.city,
       COUNT(*) AS so_don,
       ROUND(AVG(p.km_supplier_to_dc), 0) AS km_tb,
       ROUND(AVG(p.promised_lead_days), 1) AS cam_ket_tb,
       ROUND(100 * SUM(p.received_date <= p.promised_date) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE s.warehouse_id = 'DC_HCM'
  AND p.received_date IS NOT NULL
GROUP BY p.supplier_id, s.city
ORDER BY ty_le_dung_han_pct, p.supplier_id;

-- [scm-c6-cao-diem-giao-tre.b1] solution
SELECT COALESCE(e.tier, 'thuong') AS loai_ngay,
       COUNT(DISTINCT o.order_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT o.order_date), 0) AS don_tb_ngay,
       ROUND(100 * AVG(o.on_time), 2) AS ty_le_dung_han_pct
FROM orders o
LEFT JOIN event_calendar e ON e.`date` = o.order_date
WHERE o.is_cancelled = 0
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
GROUP BY loai_ngay
ORDER BY don_tb_ngay DESC, loai_ngay;

-- [scm-c6-cao-diem-giao-tre.b1] wrong: inner_join_mat_ngay_thuong
SELECT COALESCE(e.tier, 'thuong') AS loai_ngay,
       COUNT(DISTINCT o.order_date) AS so_ngay,
       ROUND(COUNT(*) / COUNT(DISTINCT o.order_date), 0) AS don_tb_ngay,
       ROUND(100 * AVG(o.on_time), 2) AS ty_le_dung_han_pct
FROM orders o
JOIN event_calendar e ON e.`date` = o.order_date
WHERE o.is_cancelled = 0
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
GROUP BY loai_ngay
ORDER BY don_tb_ngay DESC, loai_ngay;

-- [scm-c6-cao-diem-giao-tre.b2] solution
SELECT h.role AS loai_kho,
       CASE WHEN o.order_date IN (SELECT `date` FROM event_calendar) THEN 'cao_diem' ELSE 'thuong' END AS loai_ngay,
       COUNT(*) AS so_don,
       ROUND(100 * AVG(o.on_time), 2) AS ty_le_dung_han_pct,
       ROUND(AVG(o.t3b_sorting_h), 2) AS phan_loai_tb,
       ROUND(AVG(o.t4_kho_giao_h), 2) AS giao_tb
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE o.is_cancelled = 0
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
GROUP BY loai_kho, loai_ngay
ORDER BY loai_kho, loai_ngay;

-- [scm-c6-cao-diem-giao-tre.b2] wrong: noi_kho_xuat
SELECT h.role AS loai_kho,
       CASE WHEN o.order_date IN (SELECT `date` FROM event_calendar) THEN 'cao_diem' ELSE 'thuong' END AS loai_ngay,
       COUNT(*) AS so_don,
       ROUND(100 * AVG(o.on_time), 2) AS ty_le_dung_han_pct,
       ROUND(AVG(o.t3b_sorting_h), 2) AS phan_loai_tb,
       ROUND(AVG(o.t4_kho_giao_h), 2) AS giao_tb
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.origin_hub_id
WHERE o.is_cancelled = 0
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
GROUP BY loai_kho, loai_ngay
ORDER BY loai_kho, loai_ngay;

-- [scm-c6-cao-diem-giao-tre.b3] solution
SELECT o.dest_hub_id AS hub_id,
       ROUND(AVG(CASE WHEN o.order_date NOT IN (SELECT `date` FROM event_calendar) THEN o.t3b_sorting_h END), 2) AS phan_loai_thuong,
       ROUND(AVG(CASE WHEN o.order_date IN (SELECT `date` FROM event_calendar) THEN o.t3b_sorting_h END), 2) AS phan_loai_cao_diem
FROM orders o
WHERE o.is_cancelled = 0
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
GROUP BY o.dest_hub_id
ORDER BY phan_loai_cao_diem DESC, hub_id;

-- [scm-c6-cao-diem-giao-tre.b3] wrong: theo_kho_xuat
-- Gom theo kho xuất: kho vệ tinh không xuất đơn nào nên chỉ còn ba kho chính.
SELECT o.origin_hub_id AS hub_id,
       ROUND(AVG(CASE WHEN o.order_date NOT IN (SELECT `date` FROM event_calendar) THEN o.t3b_sorting_h END), 2) AS phan_loai_thuong,
       ROUND(AVG(CASE WHEN o.order_date IN (SELECT `date` FROM event_calendar) THEN o.t3b_sorting_h END), 2) AS phan_loai_cao_diem
FROM orders o
WHERE o.is_cancelled = 0
  AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
GROUP BY o.origin_hub_id
ORDER BY phan_loai_cao_diem DESC, hub_id;
