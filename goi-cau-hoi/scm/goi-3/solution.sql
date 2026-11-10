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

-- [scm-j3-giao-dich-loai-a-ngay-15-7] solution
SELECT COUNT(*) AS so_cua_hang,
       SUM(t.transactions) AS tong_luot_gd
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE st.type = 'A'
  AND t.`date` = '2017-07-15';

-- [scm-j3-giao-dich-loai-a-ngay-15-7] wrong: quen_loc_loai
SELECT COUNT(*) AS so_cua_hang,
       SUM(t.transactions) AS tong_luot_gd
FROM transactions t
JOIN stores st ON st.store_nbr = t.store_nbr
WHERE t.`date` = '2017-07-15';

-- [scm-j3-giao-dich-loai-a-ngay-15-7] wrong: dem_cua_hang_trong_danh_muc
-- Đi từ bảng cửa hàng nên đếm cả cửa hàng loại A không có số liệu ngày đó (rớt ở hidden-1).
SELECT COUNT(*) AS so_cua_hang,
       SUM(t.transactions) AS tong_luot_gd
FROM stores st
LEFT JOIN transactions t
       ON t.store_nbr = st.store_nbr AND t.`date` = '2017-07-15'
WHERE st.type = 'A';

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

-- [scm-j6-doanh-thu-m2-theo-loai-cua-hang] solution
WITH dt AS (
  SELECT s.store_nbr, SUM(s.unit_sales * c.unit_price) AS doanh_thu
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  GROUP BY s.store_nbr
),
loai AS (
  SELECT st.type AS loai_cua_hang, COUNT(*) AS so_cua_hang,
         SUM(dt.doanh_thu) AS doanh_thu, SUM(a.area_m2) AS dien_tich
  FROM dt
  JOIN stores st ON st.store_nbr = dt.store_nbr
  JOIN store_attributes a ON a.store_nbr = dt.store_nbr
  GROUP BY st.type
),
chuoi AS (
  SELECT SUM(doanh_thu) / SUM(dien_tich) AS dt_m2_chuoi FROM loai
)
SELECT l.loai_cua_hang, l.so_cua_hang,
       ROUND(l.doanh_thu, 0) AS doanh_thu,
       ROUND(l.doanh_thu / l.dien_tich, 2) AS doanh_thu_m2,
       ROUND(100 * (l.doanh_thu / l.dien_tich / c.dt_m2_chuoi - 1), 2) AS chenh_lech_pct
FROM loai l
CROSS JOIN chuoi c
ORDER BY doanh_thu_m2 DESC, l.loai_cua_hang;

-- [scm-j6-doanh-thu-m2-theo-loai-cua-hang] wrong: cong_dien_tich_tren_tung_dong_ban
-- Nối diện tích vào từng dòng bán rồi cộng: mỗi cửa hàng góp diện tích hàng nghìn lần (fan-out).
WITH loai AS (
  SELECT st.type AS loai_cua_hang, COUNT(DISTINCT s.store_nbr) AS so_cua_hang,
         SUM(s.unit_sales * c.unit_price) AS doanh_thu, SUM(a.area_m2) AS dien_tich
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  JOIN stores st ON st.store_nbr = s.store_nbr
  JOIN store_attributes a ON a.store_nbr = s.store_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  GROUP BY st.type
),
chuoi AS (
  SELECT SUM(doanh_thu) / SUM(dien_tich) AS dt_m2_chuoi FROM loai
)
SELECT l.loai_cua_hang, l.so_cua_hang,
       ROUND(l.doanh_thu, 0) AS doanh_thu,
       ROUND(l.doanh_thu / l.dien_tich, 2) AS doanh_thu_m2,
       ROUND(100 * (l.doanh_thu / l.dien_tich / c.dt_m2_chuoi - 1), 2) AS chenh_lech_pct
FROM loai l
CROSS JOIN chuoi c
ORDER BY doanh_thu_m2 DESC, l.loai_cua_hang;

-- [scm-j6-doanh-thu-m2-theo-loai-cua-hang] wrong: trung_binh_ty_so_tung_cua_hang
-- Lấy trung bình doanh thu trên m² của từng cửa hàng: cửa hàng nhỏ và lớn có trọng số như nhau.
WITH dt AS (
  SELECT s.store_nbr, SUM(s.unit_sales * c.unit_price) AS doanh_thu
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  GROUP BY s.store_nbr
),
ch AS (
  SELECT st.type AS loai_cua_hang, dt.doanh_thu, dt.doanh_thu / a.area_m2 AS dt_m2
  FROM dt
  JOIN stores st ON st.store_nbr = dt.store_nbr
  JOIN store_attributes a ON a.store_nbr = dt.store_nbr
),
chuoi AS (
  SELECT AVG(dt_m2) AS dt_m2_chuoi FROM ch
)
SELECT ch.loai_cua_hang, COUNT(*) AS so_cua_hang,
       ROUND(SUM(ch.doanh_thu), 0) AS doanh_thu,
       ROUND(AVG(ch.dt_m2), 2) AS doanh_thu_m2,
       ROUND(100 * (AVG(ch.dt_m2) / MAX(c.dt_m2_chuoi) - 1), 2) AS chenh_lech_pct
FROM ch
CROSS JOIN chuoi c
GROUP BY ch.loai_cua_hang
ORDER BY doanh_thu_m2 DESC, ch.loai_cua_hang;

-- [scm-j6-doanh-thu-m2-theo-loai-cua-hang] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có thêm một dòng bán ngày 2017-08-01 ở cửa hàng 44 (loại A).
WITH dt AS (
  SELECT s.store_nbr, SUM(s.unit_sales * c.unit_price) AS doanh_thu
  FROM sales s
  JOIN item_costs c ON c.item_nbr = s.item_nbr
  WHERE s.`date` >= '2017-07-01'
  GROUP BY s.store_nbr
),
loai AS (
  SELECT st.type AS loai_cua_hang, COUNT(*) AS so_cua_hang,
         SUM(dt.doanh_thu) AS doanh_thu, SUM(a.area_m2) AS dien_tich
  FROM dt
  JOIN stores st ON st.store_nbr = dt.store_nbr
  JOIN store_attributes a ON a.store_nbr = dt.store_nbr
  GROUP BY st.type
),
chuoi AS (
  SELECT SUM(doanh_thu) / SUM(dien_tich) AS dt_m2_chuoi FROM loai
)
SELECT l.loai_cua_hang, l.so_cua_hang,
       ROUND(l.doanh_thu, 0) AS doanh_thu,
       ROUND(l.doanh_thu / l.dien_tich, 2) AS doanh_thu_m2,
       ROUND(100 * (l.doanh_thu / l.dien_tich / c.dt_m2_chuoi - 1), 2) AS chenh_lech_pct
FROM loai l
CROSS JOIN chuoi c
ORDER BY doanh_thu_m2 DESC, l.loai_cua_hang;

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

-- [scm-j8-giao-dich-ngay-le-dia-phuong] solution
WITH ngay_le AS (
  SELECT DISTINCT st.store_nbr, h.`date`
  FROM holidays h
  JOIN stores st ON st.city = h.locale_name
  WHERE h.locale = 'Local' AND h.type = 'Holiday' AND h.transferred = 0
    AND h.`date` >= '2016-01-01' AND h.`date` < '2017-01-01'
),
gd AS (
  SELECT t.store_nbr, t.transactions,
         CASE WHEN l.store_nbr IS NULL THEN 0 ELSE 1 END AS la_ngay_le
  FROM transactions t
  LEFT JOIN ngay_le l ON l.store_nbr = t.store_nbr AND l.`date` = t.`date`
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-01-01'
)
SELECT st.city AS thanh_pho,
       SUM(gd.la_ngay_le) AS so_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END), 0) AS gd_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END), 0) AS gd_ngay_khac,
       ROUND(100 * (AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END)
                    / AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END) - 1), 2) AS muc_tang_pct
FROM gd
JOIN stores st ON st.store_nbr = gd.store_nbr
GROUP BY st.city
HAVING SUM(gd.la_ngay_le) > 0
ORDER BY muc_tang_pct DESC, thanh_pho;

-- [scm-j8-giao-dich-ngay-le-dia-phuong] wrong: noi_chi_theo_ngay
-- Chỉ nối theo ngày: lễ của thành phố này bị gán cho cửa hàng ở mọi thành phố.
WITH ngay_le AS (
  SELECT DISTINCT h.`date`
  FROM holidays h
  WHERE h.locale = 'Local' AND h.type = 'Holiday' AND h.transferred = 0
    AND h.`date` >= '2016-01-01' AND h.`date` < '2017-01-01'
),
gd AS (
  SELECT t.store_nbr, t.transactions,
         CASE WHEN l.`date` IS NULL THEN 0 ELSE 1 END AS la_ngay_le
  FROM transactions t
  LEFT JOIN ngay_le l ON l.`date` = t.`date`
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-01-01'
)
SELECT st.city AS thanh_pho,
       SUM(gd.la_ngay_le) AS so_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END), 0) AS gd_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END), 0) AS gd_ngay_khac,
       ROUND(100 * (AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END)
                    / AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END) - 1), 2) AS muc_tang_pct
FROM gd
JOIN stores st ON st.store_nbr = gd.store_nbr
GROUP BY st.city
HAVING SUM(gd.la_ngay_le) > 0
ORDER BY muc_tang_pct DESC, thanh_pho;

-- [scm-j8-giao-dich-ngay-le-dia-phuong] wrong: tinh_ca_le_bi_doi
-- Không loại dòng transferred = 1: ngày 25/7/2016 của TP.HCM bị tính là ngày lễ.
WITH ngay_le AS (
  SELECT DISTINCT st.store_nbr, h.`date`
  FROM holidays h
  JOIN stores st ON st.city = h.locale_name
  WHERE h.locale = 'Local' AND h.type = 'Holiday'
    AND h.`date` >= '2016-01-01' AND h.`date` < '2017-01-01'
),
gd AS (
  SELECT t.store_nbr, t.transactions,
         CASE WHEN l.store_nbr IS NULL THEN 0 ELSE 1 END AS la_ngay_le
  FROM transactions t
  LEFT JOIN ngay_le l ON l.store_nbr = t.store_nbr AND l.`date` = t.`date`
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-01-01'
)
SELECT st.city AS thanh_pho,
       SUM(gd.la_ngay_le) AS so_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END), 0) AS gd_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END), 0) AS gd_ngay_khac,
       ROUND(100 * (AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END)
                    / AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END) - 1), 2) AS muc_tang_pct
FROM gd
JOIN stores st ON st.store_nbr = gd.store_nbr
GROUP BY st.city
HAVING SUM(gd.la_ngay_le) > 0
ORDER BY muc_tang_pct DESC, thanh_pho;

-- [scm-j8-giao-dich-ngay-le-dia-phuong] wrong: khong_bo_dong_le_trung
-- Nối thẳng bảng ngày lễ, không gộp cặp cửa hàng – ngày: rớt ở hidden-1, nơi lễ Phan Thiết 2/3/2016 ghi hai dòng.
WITH gd AS (
  SELECT t.store_nbr, t.transactions,
         CASE WHEN h.`date` IS NULL THEN 0 ELSE 1 END AS la_ngay_le
  FROM transactions t
  JOIN stores st ON st.store_nbr = t.store_nbr
  LEFT JOIN holidays h
         ON h.`date` = t.`date` AND h.locale_name = st.city
        AND h.locale = 'Local' AND h.type = 'Holiday' AND h.transferred = 0
  WHERE t.`date` >= '2016-01-01' AND t.`date` < '2017-01-01'
)
SELECT st.city AS thanh_pho,
       SUM(gd.la_ngay_le) AS so_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END), 0) AS gd_ngay_le,
       ROUND(AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END), 0) AS gd_ngay_khac,
       ROUND(100 * (AVG(CASE WHEN gd.la_ngay_le = 1 THEN gd.transactions END)
                    / AVG(CASE WHEN gd.la_ngay_le = 0 THEN gd.transactions END) - 1), 2) AS muc_tang_pct
FROM gd
JOIN stores st ON st.store_nbr = gd.store_nbr
GROUP BY st.city
HAVING SUM(gd.la_ngay_le) > 0
ORDER BY muc_tang_pct DESC, thanh_pho;

-- [scm-j9-don-mua-thang-7-moi-ncc] starter
SELECT s.supplier_id, COUNT(p.po_id) AS so_don
FROM suppliers s
JOIN purchase_orders p
  ON p.supplier_id = s.supplier_id
 AND p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
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
-- Đã đổi sang LEFT JOIN nhưng đếm COUNT(*): NCC không có đơn nào ra 1.
SELECT s.supplier_id, COUNT(*) AS so_don
FROM suppliers s
LEFT JOIN purchase_orders p
       ON p.supplier_id = s.supplier_id
      AND p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
GROUP BY s.supplier_id
ORDER BY so_don DESC, s.supplier_id;

-- [scm-j9-don-mua-thang-7-moi-ncc] wrong: loc_ngay_trong_where
-- Đổi sang LEFT JOIN nhưng chuyển điều kiện ngày xuống WHERE: dòng NCC không có đơn bị lọc mất.
SELECT s.supplier_id, COUNT(p.po_id) AS so_don
FROM suppliers s
LEFT JOIN purchase_orders p ON p.supplier_id = s.supplier_id
WHERE p.po_date >= '2017-07-01' AND p.po_date < '2017-08-01'
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

-- [scm-q3-hang-tuoi-song-cua-hang-44] solution
SELECT ROUND(SUM(unit_sales), 0) AS tong_ban
FROM sales
WHERE store_nbr = 44
  AND `date` = '2017-07-01'
  AND item_nbr IN (SELECT item_nbr FROM items WHERE perishable = 1);

-- [scm-q3-hang-tuoi-song-cua-hang-44] wrong: nham_hang_kho
SELECT ROUND(SUM(unit_sales), 0) AS tong_ban
FROM sales
WHERE store_nbr = 44
  AND `date` = '2017-07-01'
  AND item_nbr IN (SELECT item_nbr FROM items WHERE perishable = 0);

-- [scm-q3-hang-tuoi-song-cua-hang-44] wrong: quen_loc_cua_hang
SELECT ROUND(SUM(unit_sales), 0) AS tong_ban
FROM sales
WHERE `date` = '2017-07-01'
  AND item_nbr IN (SELECT item_nbr FROM items WHERE perishable = 1);

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

-- [scm-q5-don-da-ve-gan-nhat-moi-ncc] solution
SELECT s.supplier_id, w.city AS dc_nhan,
       p.po_id, p.po_date,
       DATEDIFF(p.received_date, p.promised_date) AS so_ngay_tre,
       p.inspection_result
FROM suppliers s
JOIN warehouses w ON w.warehouse_id = s.warehouse_id
JOIN purchase_orders p
  ON p.po_id = (SELECT p2.po_id
                FROM purchase_orders p2
                WHERE p2.supplier_id = s.supplier_id
                  AND p2.received_date IS NOT NULL
                ORDER BY p2.po_date DESC, p2.po_id DESC
                LIMIT 1)
ORDER BY so_ngay_tre DESC, s.supplier_id;

-- [scm-q5-don-da-ve-gan-nhat-moi-ncc] wrong: lay_ca_don_chua_ve
-- Không loại đơn chưa về: nhà cung cấp có đơn mới nhất đang chờ ra số ngày trễ NULL.
SELECT s.supplier_id, w.city AS dc_nhan,
       p.po_id, p.po_date,
       DATEDIFF(p.received_date, p.promised_date) AS so_ngay_tre,
       p.inspection_result
FROM suppliers s
JOIN warehouses w ON w.warehouse_id = s.warehouse_id
JOIN purchase_orders p
  ON p.po_id = (SELECT p2.po_id
                FROM purchase_orders p2
                WHERE p2.supplier_id = s.supplier_id
                ORDER BY p2.po_date DESC, p2.po_id DESC
                LIMIT 1)
ORDER BY so_ngay_tre DESC, s.supplier_id;

-- [scm-q5-don-da-ve-gan-nhat-moi-ncc] wrong: noi_theo_ngay_lon_nhat
-- Lấy mọi đơn đã về có ngày đặt bằng ngày lớn nhất: NCC đặt nhiều đơn cùng ngày ra nhiều dòng.
SELECT s.supplier_id, w.city AS dc_nhan,
       p.po_id, p.po_date,
       DATEDIFF(p.received_date, p.promised_date) AS so_ngay_tre,
       p.inspection_result
FROM purchase_orders p
JOIN (SELECT supplier_id, MAX(po_date) AS ngay_cuoi
      FROM purchase_orders
      WHERE received_date IS NOT NULL
      GROUP BY supplier_id) m
  ON m.supplier_id = p.supplier_id AND m.ngay_cuoi = p.po_date
JOIN suppliers s ON s.supplier_id = p.supplier_id
JOIN warehouses w ON w.warehouse_id = s.warehouse_id
WHERE p.received_date IS NOT NULL
ORDER BY so_ngay_tre DESC, s.supplier_id;

-- [scm-q5-don-da-ve-gan-nhat-moi-ncc] wrong: max_tung_cot_rieng
-- Lấy MAX của từng cột riêng: mã đơn, số ngày trễ và kết quả kiểm định không cùng một đơn.
SELECT s.supplier_id, w.city AS dc_nhan,
       MAX(p.po_id) AS po_id, MAX(p.po_date) AS po_date,
       MAX(DATEDIFF(p.received_date, p.promised_date)) AS so_ngay_tre,
       MAX(p.inspection_result) AS inspection_result
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
JOIN warehouses w ON w.warehouse_id = s.warehouse_id
WHERE p.received_date IS NOT NULL
GROUP BY s.supplier_id, w.city
ORDER BY so_ngay_tre DESC, s.supplier_id;

-- [scm-q6-ty-trong-von-ton-cua-hang-45] solution
SELECT ROUND(SUM(inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(inventory_value)
                 / (SELECT SUM(inventory_value) FROM inventory_snapshots WHERE ym = '2017-07'), 2) AS ty_trong_pct
FROM inventory_snapshots
WHERE ym = '2017-07' AND store_nbr = 45;

-- [scm-q6-ty-trong-von-ton-cua-hang-45] wrong: mau_so_tat_ca_cac_ky
SELECT ROUND(SUM(inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(inventory_value)
                 / (SELECT SUM(inventory_value) FROM inventory_snapshots), 2) AS ty_trong_pct
FROM inventory_snapshots
WHERE ym = '2017-07' AND store_nbr = 45;

-- [scm-q6-ty-trong-von-ton-cua-hang-45] wrong: ty_le_0_1
-- Quên nhân 100: trả tỷ lệ 0–1 thay cho phần trăm.
SELECT ROUND(SUM(inventory_value), 0) AS von_ton,
       ROUND(SUM(inventory_value)
             / (SELECT SUM(inventory_value) FROM inventory_snapshots WHERE ym = '2017-07'), 2) AS ty_trong_pct
FROM inventory_snapshots
WHERE ym = '2017-07' AND store_nbr = 45;

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
       ROUND(100 * AVG(p.defect_rate), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.supplier_id, s.family
HAVING AVG(p.defect_rate) >
       (SELECT AVG(p2.defect_rate)
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

-- [scm-q8-ncc-loi-cao-hon-nganh] wrong: chi_sua_tuong_quan
-- Đã so với ngành của mình nhưng vẫn lấy trung bình defect_rate của từng đơn: tỷ lệ lệch với tỷ lệ tính từ tổng số lượng.
SELECT s.supplier_id, s.family,
       ROUND(100 * AVG(p.defect_rate), 2) AS ty_le_loi_pct
FROM purchase_orders p
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.received_date IS NOT NULL
  AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
GROUP BY s.supplier_id, s.family
HAVING AVG(p.defect_rate) >
       (SELECT AVG(p2.defect_rate)
        FROM purchase_orders p2
        JOIN suppliers s2 ON s2.supplier_id = p2.supplier_id
        WHERE s2.family = s.family
          AND p2.received_date IS NOT NULL
          AND p2.po_date >= '2016-01-01' AND p2.po_date < '2017-01-01')
ORDER BY s.family, s.supplier_id;

-- [scm-q8-ncc-loi-cao-hon-nganh] wrong: chi_sua_dinh_nghia_ty_le
-- Đã tính tỷ lệ từ tổng số lượng nhưng truy vấn con vẫn không tương quan: so với mức của cả công ty.
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
