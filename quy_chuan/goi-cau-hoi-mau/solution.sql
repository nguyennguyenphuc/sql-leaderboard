-- solution.sql: mọi truy vấn của gói, cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải (bắt buộc với write, debug, optimize)
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: truy vấn lỗi; optimize: truy vấn đúng nhưng chậm)
--   -- [ma-cau] wrong: ten_loi    bài sai (write, debug, optimize: ít nhất 1)
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.

-- ======================================================================= VIẾT TRUY VẤN

-- [w1-don-huy-2022] solution
SELECT COUNT(*) AS so_don_huy
FROM orders
WHERE order_status = 'cancelled'
  AND order_date >= '2022-01-01' AND order_date < '2023-01-01';

-- [w1-don-huy-2022] wrong: quen_loc_nam
SELECT COUNT(*) AS so_don_huy
FROM orders
WHERE order_status = 'cancelled';

-- [w2-don-theo-vung] solution
SELECT g.region, COUNT(*) AS so_don
FROM orders o
JOIN geography g ON g.zip = o.zip
WHERE o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
GROUP BY g.region
ORDER BY so_don DESC;

-- [w2-don-theo-vung] wrong: quen_loc_nam
SELECT g.region, COUNT(*) AS so_don
FROM orders o
JOIN geography g ON g.zip = o.zip
GROUP BY g.region
ORDER BY so_don DESC;

-- [w3-top3-san-pham] solution
WITH dt AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name
), xh AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY category
           ORDER BY doanh_thu DESC, product_id) AS hang
  FROM dt
)
SELECT category, product_name, doanh_thu, hang
FROM xh WHERE hang <= 3
ORDER BY category, hang;

-- [w3-top3-san-pham] wrong: quen_partition_by
WITH dt AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name
)
SELECT category, product_name, doanh_thu, hang FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY doanh_thu DESC, product_id) AS hang
  FROM dt) t
WHERE hang <= 3 ORDER BY category, hang;

-- [w3-top3-san-pham] wrong: quen_loc_trang_thai
SELECT category, product_name, doanh_thu, hang FROM (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu,
         ROW_NUMBER() OVER (PARTITION BY p.category
           ORDER BY SUM(oi.quantity * oi.unit_price) DESC, p.product_id) AS hang
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name) t
WHERE hang <= 3 ORDER BY category, hang;

-- [w3-top3-san-pham] wrong: dung_rank_khi_hoa
-- Rớt ở hidden-1: hai sản phẩm Casual bằng doanh thu ở hạng 3, RANK() trả 4 dòng.
WITH dt AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name
)
SELECT category, product_name, doanh_thu, hang FROM (
  SELECT *, RANK() OVER (PARTITION BY category ORDER BY doanh_thu DESC) AS hang
  FROM dt) t
WHERE hang <= 3 ORDER BY category, hang;

-- [w3-top3-san-pham] wrong: gom_theo_ten_san_pham
-- Rớt ở hidden-2: hai sản phẩm khác nhau cùng tên bị gộp làm một.
WITH dt AS (
  SELECT p.category, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu, MIN(p.product_id) AS product_id
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_name
)
SELECT category, product_name, doanh_thu, hang FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY doanh_thu DESC, product_id) AS hang
  FROM dt) t
WHERE hang <= 3 ORDER BY category, hang;

-- [w4-ty-le-tra-danh-muc-vung] solution
WITH giao AS (
  SELECT p.category, g.region, SUM(oi.quantity) AS sl_giao
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  JOIN geography g    ON g.zip = o.zip
  WHERE o.order_status IN ('delivered', 'returned')
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, g.region
), tra AS (
  SELECT p.category, g.region, SUM(r.return_quantity) AS sl_tra
  FROM returns r
  JOIN orders o     ON o.order_id = r.order_id
  JOIN products p   ON p.product_id = r.product_id
  JOIN geography g  ON g.zip = o.zip
  WHERE o.order_status IN ('delivered', 'returned')
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, g.region
)
SELECT giao.category, giao.region,
       ROUND(100.0 * COALESCE(tra.sl_tra, 0) / giao.sl_giao, 2) AS ty_le_tra
FROM giao
LEFT JOIN tra ON tra.category = giao.category AND tra.region = giao.region
ORDER BY ty_le_tra DESC, giao.category, giao.region;

-- [w4-ty-le-tra-danh-muc-vung] wrong: noi_mot_lan_nhan_dong
SELECT p.category, g.region,
       ROUND(100.0 * COALESCE(SUM(r.return_quantity), 0) / SUM(oi.quantity), 2) AS ty_le_tra
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p     ON p.product_id = oi.product_id
JOIN geography g    ON g.zip = o.zip
LEFT JOIN returns r ON r.order_id = o.order_id
WHERE o.order_status IN ('delivered', 'returned')
  AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
GROUP BY p.category, g.region
ORDER BY ty_le_tra DESC, p.category, g.region;

-- [w4-ty-le-tra-danh-muc-vung] wrong: mau_so_gom_don_huy
WITH giao AS (
  SELECT p.category, g.region, SUM(oi.quantity) AS sl_giao
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  JOIN geography g    ON g.zip = o.zip
  WHERE o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, g.region
), tra AS (
  SELECT p.category, g.region, SUM(r.return_quantity) AS sl_tra
  FROM returns r
  JOIN orders o     ON o.order_id = r.order_id
  JOIN products p   ON p.product_id = r.product_id
  JOIN geography g  ON g.zip = o.zip
  WHERE o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, g.region
)
SELECT giao.category, giao.region,
       ROUND(100.0 * COALESCE(tra.sl_tra, 0) / giao.sl_giao, 2) AS ty_le_tra
FROM giao
LEFT JOIN tra ON tra.category = giao.category AND tra.region = giao.region
ORDER BY ty_le_tra DESC, giao.category, giao.region;

-- ======================================================================= SỬA LỖI

-- [d1-khach-ha-noi] starter
SELECT COUNT(*) AS so_khach
FROM customers
WHERE city = 'Ha Noi';

-- [d1-khach-ha-noi] solution
SELECT COUNT(*) AS so_khach
FROM customers
WHERE city = 'Hanoi';

-- [d1-khach-ha-noi] wrong: like_bat_ca_ha_long
SELECT COUNT(*) AS so_khach
FROM customers
WHERE city LIKE 'Ha%';

-- [d2-khach-mua-2022] starter
SELECT COUNT(*) AS so_khach
FROM orders
WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01';

-- [d2-khach-mua-2022] solution
SELECT COUNT(DISTINCT customer_id) AS so_khach
FROM orders
WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01';

-- [d2-khach-mua-2022] wrong: dem_khach_dang_ky
SELECT COUNT(*) AS so_khach
FROM customers
WHERE signup_date >= '2022-01-01' AND signup_date < '2023-01-01';

-- [d3-doanh-thu-q4] starter
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS thang,
       SUM(p.payment_value) AS doanh_thu
FROM orders o
JOIN payments p     ON p.order_id = o.order_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'cancelled'
  AND o.order_date >= '2022-10-01' AND o.order_date < '2023-01-01'
GROUP BY 1
ORDER BY 1;

-- [d3-doanh-thu-q4] solution
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS thang,
       SUM(p.payment_value) AS doanh_thu
FROM orders o
JOIN payments p ON p.order_id = o.order_id
WHERE o.order_status <> 'cancelled'
  AND o.order_date >= '2022-10-01' AND o.order_date < '2023-01-01'
GROUP BY 1
ORDER BY 1;

-- [d3-doanh-thu-q4] wrong: bo_join_nhung_tinh_ca_don_huy
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS thang,
       SUM(p.payment_value) AS doanh_thu
FROM orders o
JOIN payments p ON p.order_id = o.order_id
WHERE o.order_date >= '2022-10-01' AND o.order_date < '2023-01-01'
GROUP BY 1
ORDER BY 1;

-- [d4-retention-cohort] starter
WITH coh AS (
  SELECT customer_id, DATE_FORMAT(signup_date, '%Y-%m') AS cohort,
         YEAR(signup_date) * 12 + MONTH(signup_date) AS thang_so
  FROM customers
  WHERE signup_date >= '2022-01-01' AND signup_date < '2022-04-01'
)
SELECT coh.cohort,
       COUNT(DISTINCT coh.customer_id) AS so_khach,
       COUNT(DISTINCT o.customer_id) AS quay_lai,
       ROUND(100.0 * COUNT(DISTINCT o.customer_id) / COUNT(DISTINCT coh.customer_id), 1) AS ty_le
FROM coh
JOIN orders o ON o.customer_id = coh.customer_id
 AND YEAR(o.order_date) * 12 + MONTH(o.order_date) = coh.thang_so + 1
GROUP BY coh.cohort
ORDER BY coh.cohort;

-- [d4-retention-cohort] solution
WITH dau AS (
  SELECT customer_id, MIN(order_date) AS ngay_dau
  FROM orders
  GROUP BY customer_id
), coh AS (
  SELECT customer_id, DATE_FORMAT(ngay_dau, '%Y-%m') AS cohort,
         YEAR(ngay_dau) * 12 + MONTH(ngay_dau) AS thang_so
  FROM dau
  WHERE ngay_dau >= '2022-01-01' AND ngay_dau < '2022-04-01'
)
SELECT cohort,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN EXISTS (
             SELECT 1 FROM orders o
             WHERE o.customer_id = coh.customer_id
               AND YEAR(o.order_date) * 12 + MONTH(o.order_date) = coh.thang_so + 1)
           THEN 1 ELSE 0 END) AS quay_lai,
       ROUND(100.0 * SUM(CASE WHEN EXISTS (
             SELECT 1 FROM orders o
             WHERE o.customer_id = coh.customer_id
               AND YEAR(o.order_date) * 12 + MONTH(o.order_date) = coh.thang_so + 1)
           THEN 1 ELSE 0 END) / COUNT(*), 1) AS ty_le
FROM coh
GROUP BY cohort
ORDER BY cohort;

-- [d4-retention-cohort] wrong: sua_cohort_nhung_van_inner_join
WITH dau AS (
  SELECT customer_id, MIN(order_date) AS ngay_dau
  FROM orders
  GROUP BY customer_id
), coh AS (
  SELECT customer_id, DATE_FORMAT(ngay_dau, '%Y-%m') AS cohort,
         YEAR(ngay_dau) * 12 + MONTH(ngay_dau) AS thang_so
  FROM dau
  WHERE ngay_dau >= '2022-01-01' AND ngay_dau < '2022-04-01'
)
SELECT coh.cohort,
       COUNT(DISTINCT coh.customer_id) AS so_khach,
       COUNT(DISTINCT o.customer_id) AS quay_lai,
       ROUND(100.0 * COUNT(DISTINCT o.customer_id) / COUNT(DISTINCT coh.customer_id), 1) AS ty_le
FROM coh
JOIN orders o ON o.customer_id = coh.customer_id
 AND YEAR(o.order_date) * 12 + MONTH(o.order_date) = coh.thang_so + 1
GROUP BY coh.cohort
ORDER BY coh.cohort;

-- ======================================================================= TỐI ƯU TRUY VẤN
-- starter của câu optimize cho ĐÚNG kết quả nhưng vi phạm ràng buộc (quét bảng nhiều lần, nhiều dòng trung gian).

-- [o1-dem-don-theo-trang-thai] starter
SELECT
  (SELECT COUNT(*) FROM orders WHERE order_status = 'cancelled'
     AND order_date >= '2022-01-01' AND order_date < '2023-01-01') AS so_huy,
  (SELECT COUNT(*) FROM orders WHERE order_status = 'delivered'
     AND order_date >= '2022-01-01' AND order_date < '2023-01-01') AS so_giao,
  (SELECT COUNT(*) FROM orders WHERE order_status = 'returned'
     AND order_date >= '2022-01-01' AND order_date < '2023-01-01') AS so_tra;

-- [o1-dem-don-theo-trang-thai] solution
SELECT COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) AS so_huy,
       COUNT(CASE WHEN order_status = 'delivered' THEN 1 END) AS so_giao,
       COUNT(CASE WHEN order_status = 'returned' THEN 1 END)  AS so_tra
FROM orders
WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01';

-- [o1-dem-don-theo-trang-thai] wrong: group_by_ra_nhieu_dong
SELECT order_status, COUNT(*) AS so_don
FROM orders
WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01'
  AND order_status IN ('cancelled', 'delivered', 'returned')
GROUP BY order_status;

-- [o2-doanh-thu-theo-nam] starter
SELECT '2019' AS nam, SUM(oi.quantity * oi.unit_price) AS doanh_thu_gop
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2019-01-01' AND o.order_date < '2020-01-01'
UNION ALL
SELECT '2020', SUM(oi.quantity * oi.unit_price)
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2020-01-01' AND o.order_date < '2021-01-01'
UNION ALL
SELECT '2021', SUM(oi.quantity * oi.unit_price)
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2021-01-01' AND o.order_date < '2022-01-01'
UNION ALL
SELECT '2022', SUM(oi.quantity * oi.unit_price)
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
ORDER BY nam;

-- [o2-doanh-thu-theo-nam] solution
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       SUM(oi.quantity * oi.unit_price) AS doanh_thu_gop
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2019-01-01' AND o.order_date < '2023-01-01'
GROUP BY 1
ORDER BY 1;

-- [o2-doanh-thu-theo-nam] wrong: quen_gioi_han_nam
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       SUM(oi.quantity * oi.unit_price) AS doanh_thu_gop
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY 1
ORDER BY 1;

-- [o3-san-pham-tren-trung-binh] starter
WITH dt AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name
), tb AS (
  SELECT category, AVG(doanh_thu) AS tb_nhom
  FROM (
    SELECT p.category, p.product_id, SUM(oi.quantity * oi.unit_price) AS doanh_thu
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.order_status = 'delivered'
      AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
    GROUP BY p.category, p.product_id) x
  GROUP BY category
)
SELECT dt.category, dt.product_name, dt.doanh_thu, tb.tb_nhom
FROM dt JOIN tb ON tb.category = dt.category
WHERE dt.doanh_thu > tb.tb_nhom
ORDER BY dt.category, dt.doanh_thu DESC, dt.product_id;

-- [o3-san-pham-tren-trung-binh] solution
WITH dt AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name
), kq AS (
  SELECT *, AVG(doanh_thu) OVER (PARTITION BY category) AS tb_nhom
  FROM dt
)
SELECT category, product_name, doanh_thu, tb_nhom
FROM kq
WHERE doanh_thu > tb_nhom
ORDER BY category, doanh_thu DESC, product_id;

-- [o3-san-pham-tren-trung-binh] wrong: trung_binh_toan_bang
WITH dt AS (
  SELECT p.category, p.product_id, p.product_name,
         SUM(oi.quantity * oi.unit_price) AS doanh_thu
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status = 'delivered'
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category, p.product_id, p.product_name
), kq AS (
  SELECT *, AVG(doanh_thu) OVER () AS tb_nhom
  FROM dt
)
SELECT category, product_name, doanh_thu, tb_nhom
FROM kq
WHERE doanh_thu > tb_nhom
ORDER BY category, doanh_thu DESC, product_id;

-- [o4-luy-ke-doanh-thu] starter
SELECT a.Date AS ngay, a.Revenue AS doanh_thu, SUM(b.Revenue) AS luy_ke_nam
FROM sales a
JOIN sales b
  ON YEAR(b.Date) = YEAR(a.Date)
 AND b.Date <= a.Date
WHERE a.Date >= '2019-01-01' AND a.Date < '2023-01-01'
GROUP BY a.Date, a.Revenue
ORDER BY a.Date;

-- [o4-luy-ke-doanh-thu] solution
SELECT s.Date AS ngay, s.Revenue AS doanh_thu,
       SUM(s.Revenue) OVER (PARTITION BY YEAR(s.Date) ORDER BY s.Date) AS luy_ke_nam
FROM sales s
WHERE s.Date >= '2019-01-01' AND s.Date < '2023-01-01'
ORDER BY s.Date;

-- [o4-luy-ke-doanh-thu] wrong: quen_partition_theo_nam
SELECT s.Date AS ngay, s.Revenue AS doanh_thu,
       SUM(s.Revenue) OVER (ORDER BY s.Date) AS luy_ke_nam
FROM sales s
WHERE s.Date >= '2019-01-01' AND s.Date < '2023-01-01'
ORDER BY s.Date;

-- ======================================================================= CASE STUDY

-- [c1-kenh-nhieu-don.b1] solution
SELECT order_source, COUNT(*) AS so_don
FROM orders
WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01'
GROUP BY order_source
ORDER BY so_don DESC;

-- [c1-kenh-nhieu-don.b1] wrong: quen_loc_nam
SELECT order_source, COUNT(*) AS so_don
FROM orders
GROUP BY order_source
ORDER BY so_don DESC;

-- [c2-year-end-sale.b1] solution
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       COUNT(DISTINCT o.order_id) AS so_don,
       SUM(oi.quantity * oi.unit_price - oi.discount_amount) AS doanh_thu_thuan
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'cancelled'
  AND ((o.order_date >= '2021-11-18' AND o.order_date < '2022-01-01')
    OR (o.order_date >= '2022-11-18' AND o.order_date < '2023-01-01'))
GROUP BY 1
ORDER BY 1;

-- [c2-year-end-sale.b1] wrong: dem_dong_thay_vi_don
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       COUNT(*) AS so_don,
       SUM(oi.quantity * oi.unit_price - oi.discount_amount) AS doanh_thu_thuan
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'cancelled'
  AND ((o.order_date >= '2021-11-18' AND o.order_date < '2022-01-01')
    OR (o.order_date >= '2022-11-18' AND o.order_date < '2023-01-01'))
GROUP BY 1
ORDER BY 1;

-- [c2-year-end-sale.b2] solution
SELECT promo_id, promo_name, discount_value, start_date, end_date
FROM promotions
WHERE promo_name LIKE 'Year-End Sale%'
  AND start_date >= '2021-01-01'
ORDER BY start_date;

-- [c3-genz-tra-hang.b1] solution
WITH giao AS (
  SELECT p.category, SUM(oi.quantity) AS sl_giao
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_status IN ('delivered', 'returned')
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category
), tra AS (
  SELECT p.category, SUM(r.return_quantity) AS sl_tra
  FROM returns r
  JOIN orders o   ON o.order_id = r.order_id
  JOIN products p ON p.product_id = r.product_id
  WHERE o.order_status IN ('delivered', 'returned')
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.category
)
SELECT giao.category, ROUND(100.0 * tra.sl_tra / giao.sl_giao, 2) AS ty_le_tra
FROM giao JOIN tra ON tra.category = giao.category
ORDER BY ty_le_tra DESC;

-- [c3-genz-tra-hang.b1] wrong: so_tuyet_doi_thay_vi_ty_le
SELECT p.category, SUM(r.return_quantity) AS ty_le_tra
FROM returns r
JOIN orders o   ON o.order_id = r.order_id
JOIN products p ON p.product_id = r.product_id
WHERE o.order_status IN ('delivered', 'returned')
  AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
GROUP BY p.category
ORDER BY ty_le_tra DESC;

-- [c3-genz-tra-hang.b2] solution
SELECT r.return_reason, COUNT(*) AS so_lan_tra
FROM returns r
JOIN orders o   ON o.order_id = r.order_id
JOIN products p ON p.product_id = r.product_id
WHERE p.category = 'GenZ'
  AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
GROUP BY r.return_reason
ORDER BY so_lan_tra DESC;

-- [c3-genz-tra-hang.b3] solution
WITH giao AS (
  SELECT p.size, SUM(oi.quantity) AS sl_giao
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE p.category = 'GenZ' AND o.order_status IN ('delivered', 'returned')
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.size
), tra AS (
  SELECT p.size, SUM(r.return_quantity) AS sl_tra
  FROM returns r
  JOIN orders o   ON o.order_id = r.order_id
  JOIN products p ON p.product_id = r.product_id
  WHERE p.category = 'GenZ' AND o.order_status IN ('delivered', 'returned')
    AND o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
  GROUP BY p.size
)
SELECT giao.size, ROUND(100.0 * tra.sl_tra / giao.sl_giao, 2) AS ty_le_tra
FROM giao JOIN tra ON tra.size = giao.size
ORDER BY ty_le_tra DESC;

-- [c4-doanh-thu-2019-giam.b1] solution
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       SUM(p.payment_value) AS doanh_thu,
       COUNT(*) AS so_don,
       SUM(p.payment_value) / COUNT(*) AS aov
FROM orders o
JOIN payments p ON p.order_id = o.order_id
WHERE o.order_status <> 'cancelled'
  AND o.order_date >= '2018-01-01' AND o.order_date < '2020-01-01'
GROUP BY 1
ORDER BY 1;

-- [c4-doanh-thu-2019-giam.b1] wrong: tinh_ca_don_huy
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       SUM(p.payment_value) AS doanh_thu,
       COUNT(*) AS so_don,
       SUM(p.payment_value) / COUNT(*) AS aov
FROM orders o
JOIN payments p ON p.order_id = o.order_id
WHERE o.order_date >= '2018-01-01' AND o.order_date < '2020-01-01'
GROUP BY 1
ORDER BY 1;

-- [c4-doanh-thu-2019-giam.b2] solution
WITH v AS (
  SELECT g.region,
         SUM(CASE WHEN o.order_date < '2019-01-01' THEN p.payment_value END) AS dt_2018,
         SUM(CASE WHEN o.order_date >= '2019-01-01' THEN p.payment_value END) AS dt_2019
  FROM orders o
  JOIN payments p  ON p.order_id = o.order_id
  JOIN geography g ON g.zip = o.zip
  WHERE o.order_status <> 'cancelled'
    AND o.order_date >= '2018-01-01' AND o.order_date < '2020-01-01'
  GROUP BY g.region
)
SELECT region, dt_2018, dt_2019,
       ROUND(100.0 * (dt_2019 - dt_2018) / dt_2018, 1) AS thay_doi_pct
FROM v
ORDER BY thay_doi_pct;

-- [c4-doanh-thu-2019-giam.b3] solution
WITH wt AS (
  SELECT DATE_FORMAT(`date`, '%Y') AS nam, SUM(sessions) AS sessions
  FROM web_traffic
  WHERE `date` >= '2018-01-01' AND `date` < '2020-01-01'
  GROUP BY 1
), dau AS (
  SELECT customer_id, MIN(order_date) AS ngay_dau
  FROM orders
  GROUP BY customer_id
), km AS (
  SELECT DATE_FORMAT(ngay_dau, '%Y') AS nam, COUNT(*) AS khach_moi
  FROM dau
  WHERE ngay_dau >= '2018-01-01' AND ngay_dau < '2020-01-01'
  GROUP BY 1
)
SELECT wt.nam, wt.sessions, km.khach_moi
FROM wt JOIN km ON km.nam = wt.nam
ORDER BY wt.nam;

-- [c4-doanh-thu-2019-giam.b3] wrong: khach_moi_theo_signup_date
WITH wt AS (
  SELECT DATE_FORMAT(`date`, '%Y') AS nam, SUM(sessions) AS sessions
  FROM web_traffic
  WHERE `date` >= '2018-01-01' AND `date` < '2020-01-01'
  GROUP BY 1
), km AS (
  SELECT DATE_FORMAT(signup_date, '%Y') AS nam, COUNT(*) AS khach_moi
  FROM customers
  WHERE signup_date >= '2018-01-01' AND signup_date < '2020-01-01'
  GROUP BY 1
)
SELECT wt.nam, wt.sessions, km.khach_moi
FROM wt JOIN km ON km.nam = wt.nam
ORDER BY wt.nam;

-- [c4-doanh-thu-2019-giam.b4] solution
SELECT DATE_FORMAT(o.order_date, '%Y') AS nam,
       COUNT(*) AS so_don,
       COUNT(DISTINCT o.customer_id) AS so_khach,
       ROUND(1.0 * COUNT(*) / COUNT(DISTINCT o.customer_id), 2) AS don_moi_khach
FROM orders o
WHERE o.order_status <> 'cancelled'
  AND o.order_date >= '2018-01-01' AND o.order_date < '2020-01-01'
GROUP BY 1
ORDER BY 1;
