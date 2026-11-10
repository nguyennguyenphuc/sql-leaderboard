-- solution.sql: gói thử bộ kiểm, cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên scm (public) và scm_hidden_1 (hidden-1).

-- [t1-ban-cua-hang-44] solution
SELECT SUM(unit_sales) AS tong_ban
FROM sales
WHERE store_nbr = 44
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01';

-- [t1-ban-cua-hang-44] wrong: quen_can_tren
-- Rớt ở hidden-1: biến thể có thêm một dòng của cửa hàng 44 ngày 2017-08-01.
SELECT SUM(unit_sales) AS tong_ban
FROM sales
WHERE store_nbr = 44
  AND `date` >= '2017-07-01';

-- [t2-po-giao-tre-2016] starter
SELECT COUNT(*) AS so_po_tre
FROM purchase_orders
WHERE received_date > promised_date
  AND po_date >= '2016-01-01';

-- [t2-po-giao-tre-2016] solution
SELECT COUNT(*) AS so_po_tre
FROM purchase_orders
WHERE received_date > promised_date
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';

-- [t2-po-giao-tre-2016] wrong: tinh_ca_giao_dung_hen
SELECT COUNT(*) AS so_po_tre
FROM purchase_orders
WHERE received_date >= promised_date
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';

-- [t3-don-theo-mien-thang-7] starter
SELECT
  (SELECT COUNT(*) FROM orders WHERE region = 'BAC'
     AND order_date >= '2017-07-01' AND order_date < '2017-08-01') AS bac,
  (SELECT COUNT(*) FROM orders WHERE region = 'TRUNG'
     AND order_date >= '2017-07-01' AND order_date < '2017-08-01') AS trung,
  (SELECT COUNT(*) FROM orders WHERE region = 'NAM'
     AND order_date >= '2017-07-01' AND order_date < '2017-08-01') AS nam;

-- [t3-don-theo-mien-thang-7] solution
SELECT COUNT(CASE WHEN region = 'BAC' THEN 1 END)   AS bac,
       COUNT(CASE WHEN region = 'TRUNG' THEN 1 END) AS trung,
       COUNT(CASE WHEN region = 'NAM' THEN 1 END)   AS nam
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01';

-- [t3-don-theo-mien-thang-7] wrong: group_by_ra_nhieu_dong
SELECT region, COUNT(*) AS so_don
FROM orders
WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01'
GROUP BY region;

-- [t4-mien-huy-nhieu.b1] solution
SELECT region, COUNT(*) AS so_don, SUM(is_cancelled) AS so_huy,
       ROUND(100.0 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
GROUP BY region
ORDER BY ty_le_huy DESC;

-- [t4-mien-huy-nhieu.b1] wrong: sap_theo_so_huy
SELECT region, COUNT(*) AS so_don, SUM(is_cancelled) AS so_huy,
       ROUND(100.0 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy
FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'
GROUP BY region
ORDER BY so_huy DESC;
