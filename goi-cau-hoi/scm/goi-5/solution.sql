-- solution.sql: gói 5 của bộ Supply Chain (dulieu=scm). Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Module 9 Data Quality (k1–k9), Module 10 Query Performance (p1–p9), case Khó c9, c10.
-- Chạy trên scm (public) và scm_hidden_1 (hidden-1).

-- ======================================================================= MODULE 9 · DATA QUALITY

-- [scm-k1-ban-khong-co-ton-kho] solution
WITH b AS (
  SELECT store_nbr, item_nbr, COUNT(*) AS so_dong, SUM(unit_sales) AS tong_ban
  FROM sales
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY store_nbr, item_nbr
)
SELECT b.store_nbr, b.item_nbr, b.so_dong, b.tong_ban
FROM b
LEFT JOIN inventory_snapshots v
  ON v.store_nbr = b.store_nbr
 AND v.item_nbr  = b.item_nbr
 AND v.ym        = '2017-07'
WHERE v.item_nbr IS NULL
ORDER BY b.store_nbr, b.item_nbr;

-- [scm-k1-ban-khong-co-ton-kho] wrong: dieu_kien_ky_dat_o_where
-- Điều kiện kỳ đặt ở WHERE: dòng không có cặp có ym trống nên bị loại hết, kết quả rỗng.
WITH b AS (
  SELECT store_nbr, item_nbr, COUNT(*) AS so_dong, SUM(unit_sales) AS tong_ban
  FROM sales
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY store_nbr, item_nbr
)
SELECT b.store_nbr, b.item_nbr, b.so_dong, b.tong_ban
FROM b
LEFT JOIN inventory_snapshots v
  ON v.store_nbr = b.store_nbr
 AND v.item_nbr  = b.item_nbr
WHERE v.ym = '2017-07'
  AND v.item_nbr IS NULL
ORDER BY b.store_nbr, b.item_nbr;

-- [scm-k1-ban-khong-co-ton-kho] wrong: noi_moi_ky
-- Bỏ điều kiện kỳ: cặp chỉ có dòng tồn kho ở kỳ khác vẫn được coi là có cặp.
WITH b AS (
  SELECT store_nbr, item_nbr, COUNT(*) AS so_dong, SUM(unit_sales) AS tong_ban
  FROM sales
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY store_nbr, item_nbr
)
SELECT b.store_nbr, b.item_nbr, b.so_dong, b.tong_ban
FROM b
WHERE NOT EXISTS (SELECT 1 FROM inventory_snapshots v
                  WHERE v.store_nbr = b.store_nbr AND v.item_nbr = b.item_nbr)
ORDER BY b.store_nbr, b.item_nbr;

-- [scm-k2-ngay-le-ghi-hai-dong] solution
SELECT `date` AS ngay, locale_name,
       COUNT(*)                    AS so_dong,
       COUNT(DISTINCT description) AS so_mo_ta
FROM holidays
GROUP BY `date`, locale_name
HAVING COUNT(*) > 1
ORDER BY ngay, locale_name;

-- [scm-k2-ngay-le-ghi-hai-dong] wrong: khoa_chi_co_ngay
-- Gom theo ngày: hai địa phương khác nhau cùng ngày cũng bị tính là trùng.
SELECT `date` AS ngay, MIN(locale_name) AS locale_name,
       COUNT(*)                    AS so_dong,
       COUNT(DISTINCT description) AS so_mo_ta
FROM holidays
GROUP BY `date`
HAVING COUNT(*) > 1
ORDER BY ngay, locale_name;

-- [scm-k2-ngay-le-ghi-hai-dong] wrong: khoa_them_loai_ngay
-- Thêm type vào khoá: bỏ sót cặp ngày, địa phương có hai dòng khác loại ngày.
SELECT `date` AS ngay, locale_name,
       COUNT(*)                    AS so_dong,
       COUNT(DISTINCT description) AS so_mo_ta
FROM holidays
GROUP BY `date`, locale_name, type
HAVING COUNT(*) > 1
ORDER BY ngay, locale_name;

-- [scm-k3-co-dung-han-mau-thuan] starter
SELECT order_id, order_date, lead_time_total_h, promised_h, on_time
FROM orders
WHERE is_cancelled = 0
  AND on_time <> (lead_time_total_h < promised_h)
ORDER BY order_id;

-- [scm-k3-co-dung-han-mau-thuan] solution
SELECT order_id, order_date, lead_time_total_h, promised_h, on_time
FROM orders
WHERE is_cancelled = 0
  AND on_time <> (lead_time_total_h <= promised_h)
ORDER BY order_id;

-- [scm-k3-co-dung-han-mau-thuan] wrong: tinh_lai_gio_tu_moc_thoi_gian
-- Tính lại lead time bằng TIMESTAMPDIFF theo giờ nguyên: cắt phần lẻ, báo lệch rất nhiều đơn.
SELECT order_id, order_date, lead_time_total_h, promised_h, on_time
FROM orders
WHERE is_cancelled = 0
  AND on_time <> (TIMESTAMPDIFF(HOUR, created_at, delivered_at) <= promised_h)
ORDER BY order_id;

-- [scm-k4-giao-dich-thap-bat-thuong] solution
WITH tb AS (
  SELECT store_nbr, `date`, transactions,
         AVG(transactions) OVER (PARTITION BY store_nbr) AS tb_cua_hang
  FROM transactions
)
SELECT store_nbr, `date` AS ngay, transactions,
       ROUND(tb_cua_hang, 1)                       AS tb_cua_hang,
       ROUND(100 * transactions / tb_cua_hang, 1)  AS ty_le_pct
FROM tb
WHERE transactions < 0.2 * tb_cua_hang
ORDER BY ty_le_pct, store_nbr;

-- [scm-k4-giao-dich-thap-bat-thuong] wrong: trung_binh_toan_chuoi
-- So với trung bình của cả chuỗi: cửa hàng nhỏ ngày nào cũng bị gắn cờ, cửa hàng lớn thì sót.
WITH tb AS (
  SELECT store_nbr, `date`, transactions,
         AVG(transactions) OVER () AS tb_cua_hang
  FROM transactions
)
SELECT store_nbr, `date` AS ngay, transactions,
       ROUND(tb_cua_hang, 1)                       AS tb_cua_hang,
       ROUND(100 * transactions / tb_cua_hang, 1)  AS ty_le_pct
FROM tb
WHERE transactions < 0.2 * tb_cua_hang
ORDER BY ty_le_pct, store_nbr;

-- [scm-k5-tuan-khong-co-chuyen-giao] solution
WITH t AS (
  SELECT store_nbr,
         MIN(LEFT(week, 10)) AS tuan_dau,
         MAX(LEFT(week, 10)) AS tuan_cuoi,
         COUNT(*)            AS so_tuan_co_chuyen
  FROM shipments
  GROUP BY store_nbr
)
SELECT store_nbr, tuan_dau, tuan_cuoi, so_tuan_co_chuyen,
       DATEDIFF(tuan_cuoi, tuan_dau) DIV 7 + 1 - so_tuan_co_chuyen AS so_tuan_thieu
FROM t
WHERE DATEDIFF(tuan_cuoi, tuan_dau) DIV 7 + 1 > so_tuan_co_chuyen
ORDER BY so_tuan_thieu DESC, store_nbr;

-- [scm-k5-tuan-khong-co-chuyen-giao] wrong: tinh_tu_tuan_dau_cua_bang
-- Đếm từ tuần đầu của cả bảng: cửa hàng mở muộn bị tính thiếu cả những tuần chưa mở cửa.
WITH t AS (
  SELECT store_nbr,
         MIN(LEFT(week, 10)) AS tuan_dau,
         MAX(LEFT(week, 10)) AS tuan_cuoi,
         COUNT(*)            AS so_tuan_co_chuyen
  FROM shipments
  GROUP BY store_nbr
)
SELECT store_nbr, tuan_dau, tuan_cuoi, so_tuan_co_chuyen,
       DATEDIFF(tuan_cuoi, '2012-12-31') DIV 7 + 1 - so_tuan_co_chuyen AS so_tuan_thieu
FROM t
WHERE DATEDIFF(tuan_cuoi, '2012-12-31') DIV 7 + 1 > so_tuan_co_chuyen
ORDER BY so_tuan_thieu DESC, store_nbr;

-- [scm-k6-doi-soat-don-can-xu-ly] solution
WITH d AS (
  SELECT dest_hub_id, order_date,
         COUNT(*)                                 AS so_don,
         COUNT(CASE WHEN is_cancelled = 0 THEN 1 END) AS so_don_khong_huy
  FROM orders
  GROUP BY dest_hub_id, order_date
)
SELECT w.hub_id,
       COUNT(*) AS so_ngay,
       SUM(w.orders_to_process <> COALESCE(d.so_don, 0))           AS ngay_lech_moi_don,
       SUM(w.orders_to_process <> COALESCE(d.so_don_khong_huy, 0)) AS ngay_lech_khong_huy
FROM warehouse_daily_ops w
LEFT JOIN d ON d.dest_hub_id = w.hub_id AND d.order_date = w.`date`
GROUP BY w.hub_id
ORDER BY w.hub_id;

-- [scm-k6-doi-soat-don-can-xu-ly] wrong: inner_join_mat_ngay_khong_co_don
-- INNER JOIN bỏ mất những ngày kho có dòng vận hành nhưng không có đơn nào.
WITH d AS (
  SELECT dest_hub_id, order_date,
         COUNT(*)                                 AS so_don,
         COUNT(CASE WHEN is_cancelled = 0 THEN 1 END) AS so_don_khong_huy
  FROM orders
  GROUP BY dest_hub_id, order_date
)
SELECT w.hub_id,
       COUNT(*) AS so_ngay,
       SUM(w.orders_to_process <> d.so_don)           AS ngay_lech_moi_don,
       SUM(w.orders_to_process <> d.so_don_khong_huy) AS ngay_lech_khong_huy
FROM warehouse_daily_ops w
JOIN d ON d.dest_hub_id = w.hub_id AND d.order_date = w.`date`
GROUP BY w.hub_id
ORDER BY w.hub_id;

-- [scm-k6-doi-soat-don-can-xu-ly] wrong: gan_don_cho_kho_xuat
-- Gán đơn cho kho xuất (origin_hub_id): kho vệ tinh không có đơn nào, kho chính bị cộng cả đơn của kho vệ tinh.
WITH d AS (
  SELECT origin_hub_id, order_date,
         COUNT(*)                                 AS so_don,
         COUNT(CASE WHEN is_cancelled = 0 THEN 1 END) AS so_don_khong_huy
  FROM orders
  GROUP BY origin_hub_id, order_date
)
SELECT w.hub_id,
       COUNT(*) AS so_ngay,
       SUM(w.orders_to_process <> COALESCE(d.so_don, 0))           AS ngay_lech_moi_don,
       SUM(w.orders_to_process <> COALESCE(d.so_don_khong_huy, 0)) AS ngay_lech_khong_huy
FROM warehouse_daily_ops w
LEFT JOIN d ON d.origin_hub_id = w.hub_id AND d.order_date = w.`date`
GROUP BY w.hub_id
ORDER BY w.hub_id;

-- [scm-k7-doi-soat-nhan-su] starter
SELECT w.hub_id,
       COUNT(*)                                  AS so_ngay,
       SUM(w.headcount <> s.headcount_thuc_te)   AS so_ngay_lech,
       ROUND(AVG(w.headcount - s.headcount_thuc_te), 2) AS chenh_tb
FROM warehouse_daily_ops w
JOIN staffing_plan s ON s.hub_id = w.hub_id
WHERE w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01'
GROUP BY w.hub_id
ORDER BY w.hub_id;

-- [scm-k7-doi-soat-nhan-su] solution
SELECT w.hub_id,
       COUNT(*)                                  AS so_ngay,
       SUM(w.headcount <> s.headcount_thuc_te)   AS so_ngay_lech,
       ROUND(AVG(w.headcount - s.headcount_thuc_te), 2) AS chenh_tb
FROM warehouse_daily_ops w
JOIN staffing_plan s ON s.hub_id = w.hub_id AND s.`date` = w.`date`
WHERE w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01'
GROUP BY w.hub_id
ORDER BY w.hub_id;

-- [scm-k7-doi-soat-nhan-su] wrong: so_voi_nhan_su_ke_hoach
-- So với nhân sự kế hoạch thay cho nhân sự thực tế của bảng kế hoạch nhân sự.
SELECT w.hub_id,
       COUNT(*)                                  AS so_ngay,
       SUM(w.headcount <> s.headcount_ke_hoach)  AS so_ngay_lech,
       ROUND(AVG(w.headcount - s.headcount_ke_hoach), 2) AS chenh_tb
FROM warehouse_daily_ops w
JOIN staffing_plan s ON s.hub_id = w.hub_id AND s.`date` = w.`date`
WHERE w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01'
GROUP BY w.hub_id
ORDER BY w.hub_id;

-- [scm-k8-ban-hai-nguon-lech] starter
SELECT s.store_nbr,
       ROUND(SUM(s.unit_sales), 2)                                AS ban_tu_sales,
       ROUND(SUM(v.sold), 2)                                      AS ban_tu_ton_kho,
       ROUND(SUM(v.sold) - SUM(s.unit_sales), 2)                  AS chenh_lech,
       ROUND(-SUM(CASE WHEN s.unit_sales < 0 THEN s.unit_sales END), 2) AS luong_tra
FROM sales s
JOIN stores st ON st.store_nbr = s.store_nbr
JOIN inventory_snapshots v
  ON v.store_nbr = s.store_nbr AND v.item_nbr = s.item_nbr AND v.ym = '2017-07'
WHERE st.type = 'A'
  AND s.`date` >= '2017-07-01'
GROUP BY s.store_nbr
ORDER BY s.store_nbr;

-- [scm-k8-ban-hai-nguon-lech] solution
WITH b AS (
  SELECT s.store_nbr,
         SUM(s.unit_sales)                                              AS ban,
         COALESCE(-SUM(CASE WHEN s.unit_sales < 0 THEN s.unit_sales END), 0) AS tra
  FROM sales s
  JOIN stores st ON st.store_nbr = s.store_nbr
  WHERE st.type = 'A'
    AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
  GROUP BY s.store_nbr
), t AS (
  SELECT v.store_nbr, SUM(v.sold) AS sold
  FROM inventory_snapshots v
  JOIN stores st ON st.store_nbr = v.store_nbr
  WHERE st.type = 'A' AND v.ym = '2017-07'
  GROUP BY v.store_nbr
)
SELECT t.store_nbr,
       ROUND(COALESCE(b.ban, 0), 2)          AS ban_tu_sales,
       ROUND(t.sold, 2)                      AS ban_tu_ton_kho,
       ROUND(t.sold - COALESCE(b.ban, 0), 2) AS chenh_lech,
       ROUND(COALESCE(b.tra, 0), 2)          AS luong_tra
FROM t
LEFT JOIN b ON b.store_nbr = t.store_nbr
ORDER BY t.store_nbr;

-- [scm-k8-ban-hai-nguon-lech] wrong: chi_sua_can_tren
-- Chỉ thêm cận trên, vẫn nối từng dòng bán với dòng tồn kho: lượng bán từ tồn kho nhân theo số ngày bán.
SELECT s.store_nbr,
       ROUND(SUM(s.unit_sales), 2)                                AS ban_tu_sales,
       ROUND(SUM(v.sold), 2)                                      AS ban_tu_ton_kho,
       ROUND(SUM(v.sold) - SUM(s.unit_sales), 2)                  AS chenh_lech,
       ROUND(-SUM(CASE WHEN s.unit_sales < 0 THEN s.unit_sales END), 2) AS luong_tra
FROM sales s
JOIN stores st ON st.store_nbr = s.store_nbr
JOIN inventory_snapshots v
  ON v.store_nbr = s.store_nbr AND v.item_nbr = s.item_nbr AND v.ym = '2017-07'
WHERE st.type = 'A'
  AND s.`date` >= '2017-07-01' AND s.`date` < '2017-08-01'
GROUP BY s.store_nbr
ORDER BY s.store_nbr;

-- [scm-k8-ban-hai-nguon-lech] wrong: chi_sua_nhan_dong
-- Gom hai nguồn riêng đúng cách nhưng quên cận trên của ngày bán: ở hidden-1 lẫn dòng bán ngày 2017-08-01 của cửa hàng 44.
WITH b AS (
  SELECT s.store_nbr,
         SUM(s.unit_sales)                                              AS ban,
         COALESCE(-SUM(CASE WHEN s.unit_sales < 0 THEN s.unit_sales END), 0) AS tra
  FROM sales s
  JOIN stores st ON st.store_nbr = s.store_nbr
  WHERE st.type = 'A'
    AND s.`date` >= '2017-07-01'
  GROUP BY s.store_nbr
), t AS (
  SELECT v.store_nbr, SUM(v.sold) AS sold
  FROM inventory_snapshots v
  JOIN stores st ON st.store_nbr = v.store_nbr
  WHERE st.type = 'A' AND v.ym = '2017-07'
  GROUP BY v.store_nbr
)
SELECT t.store_nbr,
       ROUND(COALESCE(b.ban, 0), 2)          AS ban_tu_sales,
       ROUND(t.sold, 2)                      AS ban_tu_ton_kho,
       ROUND(t.sold - COALESCE(b.ban, 0), 2) AS chenh_lech,
       ROUND(COALESCE(b.tra, 0), 2)          AS luong_tra
FROM t
LEFT JOIN b ON b.store_nbr = t.store_nbr
ORDER BY t.store_nbr;

-- [scm-k9-doanh-thu-hai-nguon] solution
WITH b AS (
  SELECT item_nbr, SUM(unit_sales) AS ban
  FROM sales
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY item_nbr
), dt_b AS (
  SELECT i.family, SUM(b.ban * c.unit_price) AS dt_sales
  FROM b
  JOIN items i      ON i.item_nbr = b.item_nbr
  JOIN item_costs c ON c.item_nbr = b.item_nbr
  GROUP BY i.family
), dt_t AS (
  SELECT i.family, SUM(v.sold * c.unit_price) AS dt_ton_kho
  FROM inventory_snapshots v
  JOIN items i      ON i.item_nbr = v.item_nbr
  JOIN item_costs c ON c.item_nbr = v.item_nbr
  WHERE v.ym = '2017-07'
  GROUP BY i.family
)
SELECT t.family,
       ROUND(COALESCE(b.dt_sales, 0), 0)                                  AS dt_sales,
       ROUND(t.dt_ton_kho, 0)                                             AS dt_ton_kho,
       ROUND(t.dt_ton_kho - COALESCE(b.dt_sales, 0), 0)                   AS chenh_lech,
       ROUND(100 * (t.dt_ton_kho - COALESCE(b.dt_sales, 0)) / t.dt_ton_kho, 3) AS chenh_pct
FROM dt_t t
LEFT JOIN dt_b b ON b.family = t.family
ORDER BY chenh_pct DESC, t.family
LIMIT 5;

-- [scm-k9-doanh-thu-hai-nguon] wrong: dung_gia_von
-- Nhân với giá vốn đơn vị thay cho giá bán: ra chênh lệch giá vốn, không phải doanh thu.
WITH b AS (
  SELECT item_nbr, SUM(unit_sales) AS ban
  FROM sales
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY item_nbr
), dt_b AS (
  SELECT i.family, SUM(b.ban * c.unit_cost) AS dt_sales
  FROM b
  JOIN items i      ON i.item_nbr = b.item_nbr
  JOIN item_costs c ON c.item_nbr = b.item_nbr
  GROUP BY i.family
), dt_t AS (
  SELECT i.family, SUM(v.sold * c.unit_cost) AS dt_ton_kho
  FROM inventory_snapshots v
  JOIN items i      ON i.item_nbr = v.item_nbr
  JOIN item_costs c ON c.item_nbr = v.item_nbr
  WHERE v.ym = '2017-07'
  GROUP BY i.family
)
SELECT t.family,
       ROUND(COALESCE(b.dt_sales, 0), 0)                                  AS dt_sales,
       ROUND(t.dt_ton_kho, 0)                                             AS dt_ton_kho,
       ROUND(t.dt_ton_kho - COALESCE(b.dt_sales, 0), 0)                   AS chenh_lech,
       ROUND(100 * (t.dt_ton_kho - COALESCE(b.dt_sales, 0)) / t.dt_ton_kho, 3) AS chenh_pct
FROM dt_t t
LEFT JOIN dt_b b ON b.family = t.family
ORDER BY chenh_pct DESC, t.family
LIMIT 5;

-- [scm-k9-doanh-thu-hai-nguon] wrong: quen_loc_ky_ton_kho
-- Quên lọc kỳ ở phía tồn kho: cộng lượng bán của cả tám kỳ.
WITH b AS (
  SELECT item_nbr, SUM(unit_sales) AS ban
  FROM sales
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY item_nbr
), dt_b AS (
  SELECT i.family, SUM(b.ban * c.unit_price) AS dt_sales
  FROM b
  JOIN items i      ON i.item_nbr = b.item_nbr
  JOIN item_costs c ON c.item_nbr = b.item_nbr
  GROUP BY i.family
), dt_t AS (
  SELECT i.family, SUM(v.sold * c.unit_price) AS dt_ton_kho
  FROM inventory_snapshots v
  JOIN items i      ON i.item_nbr = v.item_nbr
  JOIN item_costs c ON c.item_nbr = v.item_nbr
  GROUP BY i.family
)
SELECT t.family,
       ROUND(COALESCE(b.dt_sales, 0), 0)                                  AS dt_sales,
       ROUND(t.dt_ton_kho, 0)                                             AS dt_ton_kho,
       ROUND(t.dt_ton_kho - COALESCE(b.dt_sales, 0), 0)                   AS chenh_lech,
       ROUND(100 * (t.dt_ton_kho - COALESCE(b.dt_sales, 0)) / t.dt_ton_kho, 3) AS chenh_pct
FROM dt_t t
LEFT JOIN dt_b b ON b.family = t.family
ORDER BY chenh_pct DESC, t.family
LIMIT 5;

-- ======================================================================= MODULE 10 · QUERY PERFORMANCE

-- [scm-p1-po-theo-kiem-dinh] starter
SELECT
  (SELECT COUNT(*) FROM purchase_orders WHERE inspection_result = 'Pass'
     AND po_date >= '2017-01-01' AND po_date < '2018-01-01') AS so_lo_dat,
  (SELECT COUNT(*) FROM purchase_orders WHERE inspection_result = 'Fail'
     AND po_date >= '2017-01-01' AND po_date < '2018-01-01') AS so_lo_truot,
  (SELECT COUNT(*) FROM purchase_orders WHERE inspection_result = 'Pending'
     AND po_date >= '2017-01-01' AND po_date < '2018-01-01') AS so_chua_ve;

-- [scm-p1-po-theo-kiem-dinh] solution
SELECT COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END)    AS so_lo_dat,
       COUNT(CASE WHEN inspection_result = 'Fail' THEN 1 END)    AS so_lo_truot,
       COUNT(CASE WHEN inspection_result = 'Pending' THEN 1 END) AS so_chua_ve
FROM purchase_orders
WHERE po_date >= '2017-01-01' AND po_date < '2018-01-01';

-- [scm-p1-po-theo-kiem-dinh] wrong: group_by_ra_nhieu_dong
SELECT inspection_result, COUNT(*) AS so_po
FROM purchase_orders
WHERE po_date >= '2017-01-01' AND po_date < '2018-01-01'
GROUP BY inspection_result;

-- [scm-p1-po-theo-kiem-dinh] wrong: count_dieu_kien_dem_moi_dong
-- COUNT(điều kiện) đếm mọi dòng có giá trị 0 hoặc 1, nên ba cột đều bằng tổng số đơn.
SELECT COUNT(inspection_result = 'Pass')    AS so_lo_dat,
       COUNT(inspection_result = 'Fail')    AS so_lo_truot,
       COUNT(inspection_result = 'Pending') AS so_chua_ve
FROM purchase_orders
WHERE po_date >= '2017-01-01' AND po_date < '2018-01-01';

-- [scm-p2-don-kho-ve-tinh-theo-nam] starter
SELECT 2015 AS nam, COUNT(*) AS so_don,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh' AND o.order_date >= '2015-01-01' AND o.order_date < '2016-01-01'
UNION ALL
SELECT 2016, COUNT(*), ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2)
FROM orders o JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh' AND o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
UNION ALL
SELECT 2017, COUNT(*), ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2)
FROM orders o JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh' AND o.order_date >= '2017-01-01' AND o.order_date < '2018-01-01'
ORDER BY nam;

-- [scm-p2-don-kho-ve-tinh-theo-nam] solution
SELECT YEAR(o.order_date) AS nam, COUNT(*) AS so_don,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2015-01-01' AND o.order_date < '2018-01-01'
GROUP BY YEAR(o.order_date)
ORDER BY nam;

-- [scm-p2-don-kho-ve-tinh-theo-nam] wrong: quen_loc_kho_ve_tinh
SELECT YEAR(o.order_date) AS nam, COUNT(*) AS so_don,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
WHERE o.order_date >= '2015-01-01' AND o.order_date < '2018-01-01'
GROUP BY YEAR(o.order_date)
ORDER BY nam;

-- [scm-p2-don-kho-ve-tinh-theo-nam] wrong: count_co_huy
-- COUNT(is_cancelled) đếm mọi đơn (0 cũng là giá trị), tỷ lệ huỷ thành 100%.
SELECT YEAR(o.order_date) AS nam, COUNT(*) AS so_don,
       ROUND(100 * COUNT(o.is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.role = 'kho vệ tinh'
  AND o.order_date >= '2015-01-01' AND o.order_date < '2018-01-01'
GROUP BY YEAR(o.order_date)
ORDER BY nam;

-- [scm-p3-ncc-cham-hon-nganh] starter
WITH ncc AS (
  SELECT s.family, p.supplier_id,
         AVG(DATEDIFF(p.received_date, p.po_date)) AS lt_tb
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.received_date IS NOT NULL
    AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
  GROUP BY s.family, p.supplier_id
), nganh AS (
  SELECT family, AVG(lt_tb) AS tb_nganh
  FROM (
    SELECT s.family, p.supplier_id, AVG(DATEDIFF(p.received_date, p.po_date)) AS lt_tb
    FROM purchase_orders p
    JOIN suppliers s ON s.supplier_id = p.supplier_id
    WHERE p.received_date IS NOT NULL
      AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
    GROUP BY s.family, p.supplier_id) x
  GROUP BY family
)
SELECT ncc.family, ncc.supplier_id,
       ROUND(ncc.lt_tb, 2) AS lt_tb, ROUND(nganh.tb_nganh, 2) AS tb_nganh
FROM ncc JOIN nganh ON nganh.family = ncc.family
WHERE ncc.lt_tb > nganh.tb_nganh
ORDER BY ncc.family, ncc.lt_tb DESC, ncc.supplier_id;

-- [scm-p3-ncc-cham-hon-nganh] solution
WITH ncc AS (
  SELECT s.family, p.supplier_id,
         AVG(DATEDIFF(p.received_date, p.po_date)) AS lt_tb
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.received_date IS NOT NULL
    AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
  GROUP BY s.family, p.supplier_id
), kq AS (
  SELECT family, supplier_id, lt_tb,
         AVG(lt_tb) OVER (PARTITION BY family) AS tb_nganh
  FROM ncc
)
SELECT family, supplier_id, ROUND(lt_tb, 2) AS lt_tb, ROUND(tb_nganh, 2) AS tb_nganh
FROM kq
WHERE lt_tb > tb_nganh
ORDER BY family, lt_tb DESC, supplier_id;

-- [scm-p3-ncc-cham-hon-nganh] wrong: trung_binh_ca_chuoi
WITH ncc AS (
  SELECT s.family, p.supplier_id,
         AVG(DATEDIFF(p.received_date, p.po_date)) AS lt_tb
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.received_date IS NOT NULL
    AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
  GROUP BY s.family, p.supplier_id
), kq AS (
  SELECT family, supplier_id, lt_tb,
         AVG(lt_tb) OVER () AS tb_nganh
  FROM ncc
)
SELECT family, supplier_id, ROUND(lt_tb, 2) AS lt_tb, ROUND(tb_nganh, 2) AS tb_nganh
FROM kq
WHERE lt_tb > tb_nganh
ORDER BY family, lt_tb DESC, supplier_id;

-- [scm-p3-ncc-cham-hon-nganh] wrong: trung_binh_theo_don_mua
-- Trung bình ngành tính trên từng đơn mua: nhà cung cấp nhiều đơn lấn át nhà cung cấp ít đơn.
WITH ncc AS (
  SELECT s.family, p.supplier_id,
         AVG(DATEDIFF(p.received_date, p.po_date)) AS lt_tb,
         SUM(DATEDIFF(p.received_date, p.po_date)) AS tong_lt,
         COUNT(*) AS so_don
  FROM purchase_orders p
  JOIN suppliers s ON s.supplier_id = p.supplier_id
  WHERE p.received_date IS NOT NULL
    AND p.po_date >= '2016-01-01' AND p.po_date < '2017-01-01'
  GROUP BY s.family, p.supplier_id
), kq AS (
  SELECT family, supplier_id, lt_tb,
         SUM(tong_lt) OVER (PARTITION BY family) / SUM(so_don) OVER (PARTITION BY family) AS tb_nganh
  FROM ncc
)
SELECT family, supplier_id, ROUND(lt_tb, 2) AS lt_tb, ROUND(tb_nganh, 2) AS tb_nganh
FROM kq
WHERE lt_tb > tb_nganh
ORDER BY family, lt_tb DESC, supplier_id;

-- [scm-p4-ty-trong-von-ton-nganh] starter
SELECT i.family,
       ROUND(SUM(v.inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(v.inventory_value)
             / (SELECT SUM(inventory_value) FROM inventory_snapshots
                WHERE ym = (SELECT MAX(ym) FROM inventory_snapshots)), 2) AS ty_trong_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = (SELECT MAX(ym) FROM inventory_snapshots)
GROUP BY i.family
ORDER BY von_ton DESC, i.family;

-- [scm-p4-ty-trong-von-ton-nganh] solution
SELECT i.family,
       ROUND(SUM(v.inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(v.inventory_value) / SUM(SUM(v.inventory_value)) OVER (), 2) AS ty_trong_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = (SELECT MAX(ym) FROM inventory_snapshots)
GROUP BY i.family
ORDER BY von_ton DESC, i.family;

-- [scm-p4-ty-trong-von-ton-nganh] wrong: ghi_cung_ky_2017_08
-- Ghi cứng kỳ đang thấy khi Chạy thử: báo cáo không tự sang kỳ mới (rớt ở hidden-1, có kỳ 2017-09).
SELECT i.family,
       ROUND(SUM(v.inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(v.inventory_value) / SUM(SUM(v.inventory_value)) OVER (), 2) AS ty_trong_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = '2017-08'
GROUP BY i.family
ORDER BY von_ton DESC, i.family;

-- [scm-p4-ty-trong-von-ton-nganh] wrong: tong_moi_ky
-- Mẫu số lấy tổng vốn tồn của mọi kỳ: tỷ trọng cộng lại không ra 100%.
SELECT i.family,
       ROUND(SUM(v.inventory_value), 0) AS von_ton,
       ROUND(100 * SUM(v.inventory_value)
             / (SELECT SUM(inventory_value) FROM inventory_snapshots), 2) AS ty_trong_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = (SELECT MAX(ym) FROM inventory_snapshots)
GROUP BY i.family
ORDER BY von_ton DESC, i.family;

-- [scm-p5-luy-ke-giao-dich-thang-7] starter
SELECT a.store_nbr, a.`date` AS ngay, a.transactions AS giao_dich,
       SUM(b.transactions) AS luy_ke
FROM transactions a
JOIN transactions b
  ON b.store_nbr = a.store_nbr
 AND b.`date` >= '2017-07-01'
 AND b.`date` <= a.`date`
WHERE a.`date` >= '2017-07-01' AND a.`date` < '2017-08-01'
GROUP BY a.store_nbr, a.`date`, a.transactions
ORDER BY a.store_nbr, ngay;

-- [scm-p5-luy-ke-giao-dich-thang-7] solution
SELECT store_nbr, `date` AS ngay, transactions AS giao_dich,
       SUM(transactions) OVER (PARTITION BY store_nbr ORDER BY `date`) AS luy_ke
FROM transactions
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY store_nbr, ngay;

-- [scm-p5-luy-ke-giao-dich-thang-7] wrong: quen_partition_theo_cua_hang
SELECT store_nbr, `date` AS ngay, transactions AS giao_dich,
       SUM(transactions) OVER (ORDER BY `date`) AS luy_ke
FROM transactions
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY store_nbr, ngay;

-- [scm-p6-don-truot-7-ngay] starter
SELECT a.hub_id, a.`date` AS ngay, a.orders_to_process AS don_can_xu_ly,
       SUM(b.orders_to_process) AS don_7_ngay
FROM warehouse_daily_ops a
JOIN warehouse_daily_ops b
  ON b.hub_id = a.hub_id
 AND b.`date` BETWEEN a.`date` - INTERVAL 6 DAY AND a.`date`
WHERE a.`date` >= '2016-01-01' AND a.`date` < '2017-01-01'
GROUP BY a.hub_id, a.`date`, a.orders_to_process
ORDER BY a.hub_id, ngay;

-- [scm-p6-don-truot-7-ngay] solution
WITH t AS (
  SELECT hub_id, `date`, orders_to_process,
         SUM(orders_to_process) OVER (PARTITION BY hub_id ORDER BY `date`
                                      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS don_7_ngay
  FROM warehouse_daily_ops
  WHERE `date` >= '2015-12-26' AND `date` < '2017-01-01'
)
SELECT hub_id, `date` AS ngay, orders_to_process AS don_can_xu_ly, don_7_ngay
FROM t
WHERE `date` >= '2016-01-01'
ORDER BY hub_id, ngay;

-- [scm-p6-don-truot-7-ngay] wrong: loc_nam_truoc_khi_tinh_cua_so
-- Lọc năm 2016 trước khi tính: sáu ngày đầu năm thiếu các ngày cuối năm 2015 trong khung bảy ngày.
SELECT hub_id, `date` AS ngay, orders_to_process AS don_can_xu_ly,
       SUM(orders_to_process) OVER (PARTITION BY hub_id ORDER BY `date`
                                    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS don_7_ngay
FROM warehouse_daily_ops
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
ORDER BY hub_id, ngay;

-- [scm-p7-ty-le-dung-han-sau-khi-gop] starter
SELECT region,
       COUNT(*)                                       AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2)   AS ty_le_huy_pct,
       ROUND(100 * AVG(on_time), 2)                   AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
GROUP BY region
ORDER BY region;

-- [scm-p7-ty-le-dung-han-sau-khi-gop] solution
SELECT region,
       COUNT(*)                                       AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2)   AS ty_le_huy_pct,
       ROUND(100 * AVG(CASE WHEN is_cancelled = 0 THEN on_time END), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
GROUP BY region
ORDER BY region;

-- [scm-p7-ty-le-dung-han-sau-khi-gop] wrong: loc_huy_cho_ca_truy_van
-- Loại đơn huỷ ở WHERE: tỷ lệ đúng hạn đúng nhưng số đơn và tỷ lệ huỷ sai.
SELECT region,
       COUNT(*)                                       AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2)   AS ty_le_huy_pct,
       ROUND(100 * AVG(on_time), 2)                   AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND is_cancelled = 0
GROUP BY region
ORDER BY region;

-- [scm-p7-ty-le-dung-han-sau-khi-gop] wrong: case_else_0
-- CASE trả 0 cho đơn huỷ: đơn huỷ vẫn nằm trong mẫu số của trung bình.
SELECT region,
       COUNT(*)                                       AS so_don,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2)   AS ty_le_huy_pct,
       ROUND(100 * AVG(CASE WHEN is_cancelled = 0 THEN on_time ELSE 0 END), 2) AS ty_le_dung_han_pct
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
GROUP BY region
ORDER BY region;

-- [scm-p8-voucher-dem-hai-lan] starter
WITH d AS (
  SELECT order_id, dest_hub_id, order_value_usd
  FROM orders
  WHERE dest_hub_id = 'HUB_HUE'
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  UNION ALL
  SELECT order_id, dest_hub_id, order_value_usd
  FROM orders
  WHERE voucher_manually_applied = 1
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
)
SELECT dest_hub_id,
       COUNT(*)                        AS so_don,
       ROUND(AVG(order_value_usd), 2)  AS gia_tri_tb
FROM d
GROUP BY dest_hub_id
ORDER BY so_don DESC, dest_hub_id;

-- [scm-p8-voucher-dem-hai-lan] solution
WITH d AS (
  SELECT order_id, dest_hub_id, order_value_usd
  FROM orders
  WHERE dest_hub_id = 'HUB_HUE'
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  UNION
  SELECT order_id, dest_hub_id, order_value_usd
  FROM orders
  WHERE voucher_manually_applied = 1
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
)
SELECT dest_hub_id,
       COUNT(*)                        AS so_don,
       ROUND(AVG(order_value_usd), 2)  AS gia_tri_tb
FROM d
GROUP BY dest_hub_id
ORDER BY so_don DESC, dest_hub_id;

-- [scm-p8-voucher-dem-hai-lan] wrong: union_bo_ma_don
-- UNION bỏ cột order_id: hai đơn khác nhau cùng kho, cùng giá trị bị gộp làm một.
WITH d AS (
  SELECT dest_hub_id, order_value_usd
  FROM orders
  WHERE dest_hub_id = 'HUB_HUE'
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  UNION
  SELECT dest_hub_id, order_value_usd
  FROM orders
  WHERE voucher_manually_applied = 1
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
)
SELECT dest_hub_id,
       COUNT(*)                        AS so_don,
       ROUND(AVG(order_value_usd), 2)  AS gia_tri_tb
FROM d
GROUP BY dest_hub_id
ORDER BY so_don DESC, dest_hub_id;

-- [scm-p8-voucher-dem-hai-lan] wrong: doi_hoac_thanh_va
-- Gộp hai nhánh bằng AND thay cho "hoặc": chỉ còn đơn thoả cả hai điều kiện.
WITH d AS (
  SELECT order_id, dest_hub_id, order_value_usd
  FROM orders
  WHERE dest_hub_id = 'HUB_HUE' AND voucher_manually_applied = 1
    AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
)
SELECT dest_hub_id,
       COUNT(*)                        AS so_don,
       ROUND(AVG(order_value_usd), 2)  AS gia_tri_tb
FROM d
GROUP BY dest_hub_id
ORDER BY so_don DESC, dest_hub_id;

-- [scm-p9-bao-cao-kho-thang-7] solution
WITH d AS (
  SELECT dest_hub_id,
         COUNT(*)                                     AS so_don,
         SUM(is_cancelled)                            AS so_huy,
         AVG(CASE WHEN is_cancelled = 0 THEN lead_time_total_h END) AS lead_time_tb
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  GROUP BY dest_hub_id
), w AS (
  SELECT hub_id, COUNT(CASE WHEN workload_ratio > 1 THEN 1 END) AS so_ngay_qua_tai
  FROM warehouse_daily_ops
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY hub_id
)
SELECT h.hub_id, h.role,
       COALESCE(d.so_don, 0)                          AS so_don,
       ROUND(100 * d.so_huy / d.so_don, 2)            AS ty_le_huy_pct,
       ROUND(d.lead_time_tb, 2)                       AS lead_time_tb_h,
       COALESCE(w.so_ngay_qua_tai, 0)                 AS so_ngay_qua_tai
FROM sorting_hubs h
LEFT JOIN d ON d.dest_hub_id = h.hub_id
LEFT JOIN w ON w.hub_id = h.hub_id
ORDER BY so_don DESC, h.hub_id;

-- [scm-p9-bao-cao-kho-thang-7] wrong: noi_don_voi_ngay_van_hanh
-- Nối từng đơn với dòng vận hành của ngày đó rồi đếm: số ngày quá tải thành số đơn của các ngày quá tải.
SELECT h.hub_id, h.role,
       COUNT(o.order_id)                              AS so_don,
       ROUND(100 * SUM(o.is_cancelled) / COUNT(o.order_id), 2) AS ty_le_huy_pct,
       ROUND(AVG(CASE WHEN o.is_cancelled = 0 THEN o.lead_time_total_h END), 2) AS lead_time_tb_h,
       COUNT(CASE WHEN w.workload_ratio > 1 THEN 1 END) AS so_ngay_qua_tai
FROM sorting_hubs h
LEFT JOIN orders o
  ON o.dest_hub_id = h.hub_id AND o.order_date >= '2017-07-01' AND o.order_date < '2017-08-01'
LEFT JOIN warehouse_daily_ops w
  ON w.hub_id = h.hub_id AND w.`date` = o.order_date
GROUP BY h.hub_id, h.role
ORDER BY so_don DESC, h.hub_id;

-- [scm-p9-bao-cao-kho-thang-7] wrong: lead_time_gom_ca_don_huy
-- Lead time trung bình tính cả đơn huỷ.
WITH d AS (
  SELECT dest_hub_id,
         COUNT(*)                AS so_don,
         SUM(is_cancelled)       AS so_huy,
         AVG(lead_time_total_h)  AS lead_time_tb
  FROM orders
  WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
  GROUP BY dest_hub_id
), w AS (
  SELECT hub_id, COUNT(CASE WHEN workload_ratio > 1 THEN 1 END) AS so_ngay_qua_tai
  FROM warehouse_daily_ops
  WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01'
  GROUP BY hub_id
)
SELECT h.hub_id, h.role,
       COALESCE(d.so_don, 0)                          AS so_don,
       ROUND(100 * d.so_huy / d.so_don, 2)            AS ty_le_huy_pct,
       ROUND(d.lead_time_tb, 2)                       AS lead_time_tb_h,
       COALESCE(w.so_ngay_qua_tai, 0)                 AS so_ngay_qua_tai
FROM sorting_hubs h
LEFT JOIN d ON d.dest_hub_id = h.hub_id
LEFT JOIN w ON w.hub_id = h.hub_id
ORDER BY so_don DESC, h.hub_id;

-- ======================================================================= CASE STUDY · KHÓ

-- [scm-c9-kho-ha-noi-qua-tai.b1] solution
SELECT hub_id,
       COUNT(*)                                          AS so_ngay,
       COUNT(CASE WHEN workload_ratio > 1 THEN 1 END)    AS so_ngay_qua_tai,
       ROUND(100 * COUNT(CASE WHEN workload_ratio > 1 THEN 1 END) / COUNT(*), 2) AS ty_le_qua_tai_pct
FROM warehouse_daily_ops
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
GROUP BY hub_id
ORDER BY ty_le_qua_tai_pct DESC, hub_id;

-- [scm-c9-kho-ha-noi-qua-tai.b1] wrong: nguong_0_9
SELECT hub_id,
       COUNT(*)                                          AS so_ngay,
       COUNT(CASE WHEN workload_ratio >= 0.9 THEN 1 END) AS so_ngay_qua_tai,
       ROUND(100 * COUNT(CASE WHEN workload_ratio >= 0.9 THEN 1 END) / COUNT(*), 2) AS ty_le_qua_tai_pct
FROM warehouse_daily_ops
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
GROUP BY hub_id
ORDER BY ty_le_qua_tai_pct DESC, hub_id;

-- [scm-c9-kho-ha-noi-qua-tai.b2] solution
SELECT CASE WHEN e.`date` IS NULL THEN 'ngay thuong' ELSE 'cao diem' END AS loai_ngay,
       COUNT(*)                                          AS so_ngay,
       COUNT(CASE WHEN w.workload_ratio > 1 THEN 1 END)  AS so_ngay_qua_tai,
       ROUND(AVG(w.orders_to_process), 1)                AS don_tb
FROM warehouse_daily_ops w
LEFT JOIN event_calendar e ON e.`date` = w.`date`
WHERE w.hub_id = 'DC_HANOI'
  AND w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01'
GROUP BY loai_ngay
ORDER BY loai_ngay;

-- [scm-c9-kho-ha-noi-qua-tai.b2] wrong: inner_join_chi_con_ngay_cao_diem
SELECT CASE WHEN e.`date` IS NULL THEN 'ngay thuong' ELSE 'cao diem' END AS loai_ngay,
       COUNT(*)                                          AS so_ngay,
       COUNT(CASE WHEN w.workload_ratio > 1 THEN 1 END)  AS so_ngay_qua_tai,
       ROUND(AVG(w.orders_to_process), 1)                AS don_tb
FROM warehouse_daily_ops w
JOIN event_calendar e ON e.`date` = w.`date`
WHERE w.hub_id = 'DC_HANOI'
  AND w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01'
GROUP BY loai_ngay
ORDER BY loai_ngay;

-- [scm-c9-kho-ha-noi-qua-tai.b3] solution
SELECT CASE WHEN workload_ratio > 1 THEN 'qua tai' ELSE 'khong qua tai' END AS trang_thai,
       COUNT(*)                            AS so_ngay,
       ROUND(AVG(orders_to_process), 1)    AS don_tb,
       ROUND(AVG(headcount), 2)            AS nhan_su_tb,
       ROUND(AVG(headcount_ke_hoach), 2)   AS nhan_su_ke_hoach_tb
FROM warehouse_daily_ops
WHERE hub_id = 'DC_HANOI'
  AND `date` >= '2016-01-01' AND `date` < '2017-01-01'
GROUP BY trang_thai
ORDER BY trang_thai DESC;

-- [scm-c9-kho-ha-noi-qua-tai.b3] wrong: quen_loc_kho
SELECT CASE WHEN workload_ratio > 1 THEN 'qua tai' ELSE 'khong qua tai' END AS trang_thai,
       COUNT(*)                            AS so_ngay,
       ROUND(AVG(orders_to_process), 1)    AS don_tb,
       ROUND(AVG(headcount), 2)            AS nhan_su_tb,
       ROUND(AVG(headcount_ke_hoach), 2)   AS nhan_su_ke_hoach_tb
FROM warehouse_daily_ops
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
GROUP BY trang_thai
ORDER BY trang_thai DESC;

-- [scm-c9-kho-ha-noi-qua-tai.b4] solution
SELECT COUNT(*)                                         AS so_ngay,
       SUM(w.headcount <> s.headcount_thuc_te)          AS so_ngay_lech,
       ROUND(AVG(w.headcount), 2)                       AS nhan_su_van_hanh_tb,
       ROUND(AVG(s.headcount_thuc_te), 2)               AS nhan_su_thuc_te_tb,
       ROUND(AVG(s.headcount_ke_hoach), 2)              AS nhan_su_ke_hoach_tb
FROM warehouse_daily_ops w
JOIN staffing_plan s ON s.hub_id = w.hub_id AND s.`date` = w.`date`
WHERE w.hub_id = 'DC_HANOI'
  AND w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01';

-- [scm-c9-kho-ha-noi-qua-tai.b4] wrong: noi_thieu_ngay
SELECT COUNT(*)                                         AS so_ngay,
       SUM(w.headcount <> s.headcount_thuc_te)          AS so_ngay_lech,
       ROUND(AVG(w.headcount), 2)                       AS nhan_su_van_hanh_tb,
       ROUND(AVG(s.headcount_thuc_te), 2)               AS nhan_su_thuc_te_tb,
       ROUND(AVG(s.headcount_ke_hoach), 2)              AS nhan_su_ke_hoach_tb
FROM warehouse_daily_ops w
JOIN staffing_plan s ON s.hub_id = w.hub_id
WHERE w.hub_id = 'DC_HANOI'
  AND w.`date` >= '2016-01-01' AND w.`date` < '2017-01-01';

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b1] solution
SELECT i.family,
       COUNT(*)                                          AS so_dong,
       ROUND(100 * (1 - SUM(v.thieu_hut) / SUM(v.sold)), 2) AS fill_rate_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = '2017-07'
GROUP BY i.family
ORDER BY fill_rate_pct, i.family
LIMIT 5;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b1] wrong: trung_binh_ty_le_tung_dong
SELECT i.family,
       COUNT(*)                                          AS so_dong,
       ROUND(100 * (1 - AVG(v.thieu_hut / NULLIF(v.sold, 0))), 2) AS fill_rate_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE v.ym = '2017-07'
GROUP BY i.family
ORDER BY fill_rate_pct, i.family
LIMIT 5;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b2] solution
SELECT p.supplier_id,
       COUNT(*)                                                  AS so_don,
       ROUND(100 * AVG(p.received_date <= p.promised_date), 2)   AS otd_pct,
       ROUND(AVG(DATEDIFF(p.received_date, p.po_date)), 2)       AS lead_time_tb,
       ROUND(100 * SUM(p.qty_received) / SUM(p.qty_ordered), 2) AS ty_le_nhan_pct
FROM purchase_orders p
JOIN items i ON i.item_nbr = p.item_nbr
WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
  AND p.received_date IS NOT NULL
  AND p.po_date >= '2017-01-01' AND p.po_date < '2017-08-01'
GROUP BY p.supplier_id
ORDER BY p.supplier_id;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b2] wrong: tinh_ca_don_chua_ve
SELECT p.supplier_id,
       COUNT(*)                                                  AS so_don,
       ROUND(100 * AVG(COALESCE(p.received_date <= p.promised_date, 0)), 2) AS otd_pct,
       ROUND(AVG(DATEDIFF(p.received_date, p.po_date)), 2)       AS lead_time_tb,
       ROUND(100 * SUM(COALESCE(p.qty_received, 0)) / SUM(p.qty_ordered), 2) AS ty_le_nhan_pct
FROM purchase_orders p
JOIN items i ON i.item_nbr = p.item_nbr
WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
  AND p.po_date >= '2017-01-01'
GROUP BY p.supplier_id
ORDER BY p.supplier_id;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b3] solution
SELECT v.ym,
       ROUND(SUM(v.sold), 0)       AS luong_ban,
       ROUND(SUM(v.received), 0)   AS luong_nhap,
       ROUND(SUM(v.thieu_hut), 0)  AS luong_thieu_hut,
       ROUND(100 * (1 - SUM(v.thieu_hut) / SUM(v.sold)), 2) AS fill_rate_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
  AND v.ym >= '2017-01' AND v.ym <= '2017-07'
GROUP BY v.ym
ORDER BY v.ym;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b3] wrong: lay_ca_ky_chua_du
SELECT v.ym,
       ROUND(SUM(v.sold), 0)       AS luong_ban,
       ROUND(SUM(v.received), 0)   AS luong_nhap,
       ROUND(SUM(v.thieu_hut), 0)  AS luong_thieu_hut,
       ROUND(100 * (1 - SUM(v.thieu_hut) / SUM(v.sold)), 2) AS fill_rate_pct
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
  AND v.ym >= '2017-01'
GROUP BY v.ym
ORDER BY v.ym;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b4] solution
WITH dat AS (
  SELECT DATE_FORMAT(p.po_date, '%Y-%m') AS ky, SUM(p.qty_ordered) AS luong_dat
  FROM purchase_orders p
  JOIN items i ON i.item_nbr = p.item_nbr
  WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
    AND p.po_date >= '2017-01-01' AND p.po_date < '2017-08-01'
  GROUP BY ky
), ban AS (
  SELECT v.ym AS ky, SUM(v.sold) AS luong_ban
  FROM inventory_snapshots v
  JOIN items i ON i.item_nbr = v.item_nbr
  WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
    AND v.ym >= '2017-01' AND v.ym <= '2017-07'
  GROUP BY v.ym
)
SELECT ban.ky,
       ROUND(ban.luong_ban, 0)                     AS luong_ban,
       ROUND(COALESCE(dat.luong_dat, 0), 0)        AS luong_dat,
       ROUND(COALESCE(dat.luong_dat, 0) / ban.luong_ban, 2) AS dat_tren_ban
FROM ban
LEFT JOIN dat ON dat.ky = ban.ky
ORDER BY ban.ky;

-- [scm-c10-do-dung-hoc-tap-thieu-hut.b4] wrong: noi_truoc_khi_gom
SELECT v.ym AS ky,
       ROUND(SUM(v.sold), 0)                  AS luong_ban,
       ROUND(SUM(p.qty_ordered), 0)           AS luong_dat,
       ROUND(SUM(p.qty_ordered) / SUM(v.sold), 2) AS dat_tren_ban
FROM inventory_snapshots v
JOIN items i ON i.item_nbr = v.item_nbr
JOIN purchase_orders p
  ON p.item_nbr = v.item_nbr AND DATE_FORMAT(p.po_date, '%Y-%m') = v.ym
WHERE i.family = 'SCHOOL AND OFFICE SUPPLIES'
  AND v.ym >= '2017-01' AND v.ym <= '2017-07'
GROUP BY v.ym
ORDER BY v.ym;
