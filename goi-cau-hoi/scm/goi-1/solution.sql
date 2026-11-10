-- solution.sql: gói 1 của bộ Supply Chain (dulieu=scm), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên scm (public) và scm_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.

-- ================================================ MODULE 1 · RETRIEVAL

-- [scm-r1-cua-hang-tphcm] solution
SELECT store_nbr, type, cluster
FROM stores
WHERE city = 'TP.HCM'
ORDER BY store_nbr;

-- [scm-r1-cua-hang-tphcm] wrong: loc_theo_tinh_thanh
-- Rớt ở public: cửa hàng 35 ở Vũng Tàu có state = 'TP.HCM', ra 9 dòng thay vì 8.
SELECT store_nbr, type, cluster
FROM stores
WHERE state = 'TP.HCM'
ORDER BY store_nbr;

-- [scm-r1-cua-hang-tphcm] wrong: sai_ky_tu_ten_thanh_pho
-- Rớt ở public: thiếu dấu chấm, ra 0 dòng.
SELECT store_nbr, type, cluster
FROM stores
WHERE city = 'TP HCM'
ORDER BY store_nbr;

-- [scm-r2-lo-truot-ve-tre-rau-cu-thang-7] solution
-- Hai nhà cung cấp ngành PRODUCE tra ở suppliers: SUP_061, SUP_062.
SELECT po_id, supplier_id, po_date, promised_date, received_date, defect_rate
FROM purchase_orders
WHERE supplier_id IN ('SUP_061', 'SUP_062')
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
  AND received_date > promised_date
  AND inspection_result = 'Fail'
ORDER BY received_date, po_id;

-- [scm-r2-lo-truot-ve-tre-rau-cu-thang-7] wrong: loc_thang_theo_ngay_dat
-- Rớt ở public: đơn về trong tháng 7 nhiều đơn đặt từ tháng 6, còn đơn đặt
-- tháng 7 phần lớn về tháng 8; danh sách khác hẳn.
SELECT po_id, supplier_id, po_date, promised_date, received_date, defect_rate
FROM purchase_orders
WHERE supplier_id IN ('SUP_061', 'SUP_062')
  AND po_date >= '2017-07-01' AND po_date < '2017-08-01'
  AND received_date > promised_date
  AND inspection_result = 'Fail'
ORDER BY received_date, po_id;

-- [scm-r2-lo-truot-ve-tre-rau-cu-thang-7] wrong: tinh_ca_ngay_hen
-- Rớt ở public: đơn về đúng ngày hẹn vẫn là đúng hạn, so >= lấy thừa một đơn.
SELECT po_id, supplier_id, po_date, promised_date, received_date, defect_rate
FROM purchase_orders
WHERE supplier_id IN ('SUP_061', 'SUP_062')
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
  AND received_date >= promised_date
  AND inspection_result = 'Fail'
ORDER BY received_date, po_id;

-- [scm-r2-lo-truot-ve-tre-rau-cu-thang-7] wrong: chi_mot_nha_cung_cap
-- Rớt ở public: chỉ lấy "NCC Rau củ quả 1", thiếu đơn của SUP_062.
SELECT po_id, supplier_id, po_date, promised_date, received_date, defect_rate
FROM purchase_orders
WHERE supplier_id = 'SUP_061'
  AND received_date >= '2017-07-01' AND received_date < '2017-08-01'
  AND received_date > promised_date
  AND inspection_result = 'Fail'
ORDER BY received_date, po_id;

-- [scm-r3-dong-tra-hang-cua-hang-2-3] solution
SELECT `date`, store_nbr, item_nbr, unit_sales
FROM sales
WHERE store_nbr IN (2, 3)
  AND unit_sales < 0
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`, store_nbr, item_nbr;

-- [scm-r3-dong-tra-hang-cua-hang-2-3] wrong: thieu_ngoac_quanh_or
-- Rớt ở public: AND tính trước OR, nên lấy mọi dòng bán của cửa hàng 2.
SELECT `date`, store_nbr, item_nbr, unit_sales
FROM sales
WHERE store_nbr = 2 OR store_nbr = 3
  AND unit_sales < 0
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`, store_nbr, item_nbr;

-- [scm-r3-dong-tra-hang-cua-hang-2-3] wrong: dung_and_giua_hai_cua_hang
-- Rớt ở public: một dòng không thể thuộc hai cửa hàng, ra 0 dòng.
SELECT `date`, store_nbr, item_nbr, unit_sales
FROM sales
WHERE store_nbr = 2 AND store_nbr = 3
  AND unit_sales < 0
ORDER BY `date`, store_nbr, item_nbr;

-- [scm-r4-hang-khuyen-mai-ban-chay] solution
SELECT item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND `date` = '2017-07-07'
  AND onpromotion = 1
ORDER BY unit_sales DESC, item_nbr
LIMIT 5;

-- [scm-r4-hang-khuyen-mai-ban-chay] wrong: quen_loc_khuyen_mai
-- Rớt ở public: năm mã bán chạy nhất cả cửa hàng phần lớn không khuyến mãi.
SELECT item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND `date` = '2017-07-07'
ORDER BY unit_sales DESC, item_nbr
LIMIT 5;

-- [scm-r4-hang-khuyen-mai-ban-chay] wrong: quen_desc
-- Rớt ở public: sắp tăng dần nên lấy năm mã bán ít nhất.
SELECT item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND `date` = '2017-07-07'
  AND onpromotion = 1
ORDER BY unit_sales, item_nbr
LIMIT 5;

-- [scm-r5-hang-dong-von-cum-14-ha-noi] solution
-- Cửa hàng cụm 14 ở Hà Nội tra ở stores: 46, 47, 48 (cụm 14 còn cửa hàng 50 ở Bắc Kạn).
SELECT store_nbr, item_nbr, on_hand_end, inventory_value AS von_ton
FROM inventory_snapshots
WHERE store_nbr IN (46, 47, 48)
  AND ym = '2017-07'
  AND sold = 0
  AND inventory_value >= 1000
ORDER BY von_ton DESC, store_nbr, item_nbr;

-- [scm-r5-hang-dong-von-cum-14-ha-noi] wrong: lay_ca_cum_14_ngoai_ha_noi
-- Rớt ở public: cụm 14 còn cửa hàng 50 ở Bắc Kạn, số dòng gấp đôi.
SELECT store_nbr, item_nbr, on_hand_end, inventory_value AS von_ton
FROM inventory_snapshots
WHERE store_nbr IN (46, 47, 48, 50)
  AND ym = '2017-07'
  AND sold = 0
  AND inventory_value >= 1000
ORDER BY von_ton DESC, store_nbr, item_nbr;

-- [scm-r5-hang-dong-von-cum-14-ha-noi] wrong: nguong_theo_luong_ton
-- Rớt ở public: ngưỡng 1.000 là vốn tồn, đặt lên lượng tồn ra danh sách khác.
SELECT store_nbr, item_nbr, on_hand_end, inventory_value AS von_ton
FROM inventory_snapshots
WHERE store_nbr IN (46, 47, 48)
  AND ym = '2017-07'
  AND sold = 0
  AND on_hand_end >= 1000
ORDER BY von_ton DESC, store_nbr, item_nbr;

-- [scm-r6-ngay-ban-manh-ba-ma-do-uong] solution
SELECT `date`, item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND item_nbr IN (2042941, 2042947, 1047679)
  AND unit_sales >= 500
  AND onpromotion = 0
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`, item_nbr;

-- [scm-r6-ngay-ban-manh-ba-ma-do-uong] wrong: quen_loai_khuyen_mai
-- Rớt ở public: thêm các ngày mã đang khuyến mãi (cuối tháng 7).
SELECT `date`, item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND item_nbr IN (2042941, 2042947, 1047679)
  AND unit_sales >= 500
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`, item_nbr;

-- [scm-r6-ngay-ban-manh-ba-ma-do-uong] wrong: or_khong_ngoac
-- Rớt ở public: AND tính trước OR, lấy mọi dòng bán mạnh không khuyến mãi
-- của mã 1047679 ở mọi cửa hàng và mọi dòng của hai mã kia ở cửa hàng 44.
SELECT `date`, item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND item_nbr = 2042941 OR item_nbr = 2042947 OR item_nbr = 1047679
  AND unit_sales >= 500
  AND onpromotion = 0
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`, item_nbr;

-- [scm-r6-ngay-ban-manh-ba-ma-do-uong] wrong: thieu_can_tren
-- Qua public (sales public chỉ có tháng 7/2017), rớt ở hidden-1:
-- lấy thêm dòng ngày 1/8/2017 của mã 2042941 (500 đơn vị, không khuyến mãi).
SELECT `date`, item_nbr, unit_sales
FROM sales
WHERE store_nbr = 44
  AND item_nbr IN (2042941, 2042947, 1047679)
  AND unit_sales >= 500
  AND onpromotion = 0
  AND `date` >= '2017-07-01'
ORDER BY `date`, item_nbr;

-- [scm-r7-lo-truot-rau-cu-ra-0] starter
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE supplier_id = 'SUP_061'
  AND inspection_result = 'Failed'
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';

-- [scm-r7-lo-truot-rau-cu-ra-0] solution
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE supplier_id = 'SUP_061'
  AND inspection_result = 'Fail'
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';

-- [scm-r7-lo-truot-rau-cu-ra-0] wrong: tu_so_nguong_lon_hon
-- Rớt ở public và hidden-1: lô có tỷ lệ lỗi đúng bằng ngưỡng
-- (đã làm tròn) vẫn có thể là lô trượt.
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE supplier_id = 'SUP_061'
  AND defect_rate > 0.02
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';

-- [scm-r7-lo-truot-rau-cu-ra-0] wrong: tu_so_nguong_tu_2pct
-- Rớt ở public và hidden-1: một số lô đạt có tỷ lệ lỗi đúng bằng ngưỡng.
SELECT COUNT(*) AS so_lo_truot
FROM purchase_orders
WHERE supplier_id = 'SUP_061'
  AND defect_rate >= 0.02
  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';

-- [scm-r8-don-mua-do-uong-cho-hang-thang-8] starter
SELECT COUNT(*) AS so_don_cho_hang
FROM purchase_orders
WHERE supplier_id = 'SUP_007' OR supplier_id = 'SUP_008'
  AND inspection_result = 'Pending'
  AND po_date >= '2017-08-01';

-- [scm-r8-don-mua-do-uong-cho-hang-thang-8] solution
SELECT COUNT(*) AS so_don_cho_hang
FROM purchase_orders
WHERE supplier_id IN ('SUP_007', 'SUP_008')
  AND inspection_result = 'Pending'
  AND po_date >= '2017-08-01' AND po_date < '2017-09-01';

-- [scm-r8-don-mua-do-uong-cho-hang-thang-8] wrong: chi_sua_ngoac
-- Qua public, rớt ở hidden-1: còn thiếu cận trên, đếm thêm đơn PO_0158799
-- của SUP_007 đặt ngày 1/9/2017, chưa về.
SELECT COUNT(*) AS so_don_cho_hang
FROM purchase_orders
WHERE supplier_id IN ('SUP_007', 'SUP_008')
  AND inspection_result = 'Pending'
  AND po_date >= '2017-08-01';

-- [scm-r8-don-mua-do-uong-cho-hang-thang-8] wrong: chi_them_can_tren
-- Rớt ở public: còn thiếu ngoặc quanh OR, đếm mọi đơn của SUP_007 từ trước tới nay.
SELECT COUNT(*) AS so_don_cho_hang
FROM purchase_orders
WHERE supplier_id = 'SUP_007' OR supplier_id = 'SUP_008'
  AND inspection_result = 'Pending'
  AND po_date >= '2017-08-01' AND po_date < '2017-09-01';

-- [scm-r9-otif-da-nang-lan-tuan-2016] starter
SELECT shipment_id, store_nbr, week, on_time, in_full
FROM shipments
WHERE warehouse_id = 'DC_DANANG'
  AND otif = 0
  AND week LIKE '%2017%'
ORDER BY week, store_nbr;

-- [scm-r9-otif-da-nang-lan-tuan-2016] solution
SELECT shipment_id, store_nbr, week, on_time, in_full
FROM shipments
WHERE warehouse_id = 'DC_DANANG'
  AND otif = 0
  AND week LIKE '2017-%'
ORDER BY week, store_nbr;

-- [scm-r9-otif-da-nang-lan-tuan-2016] wrong: chi_xet_dung_han
-- Rớt ở public: chuyến đúng hạn nhưng thiếu hàng cũng không đạt OTIF.
SELECT shipment_id, store_nbr, week, on_time, in_full
FROM shipments
WHERE warehouse_id = 'DC_DANANG'
  AND on_time = 0
  AND week LIKE '2017-%'
ORDER BY week, store_nbr;

-- ================================================ MODULE 2 · NULL & EXPRESSIONS

-- [scm-n1-bien-ln-gop-seafood] solution
SELECT item_nbr, unit_price, unit_cost,
       ROUND((unit_price - unit_cost) / unit_price * 100, 2) AS bien_ln_gop_pct
FROM item_costs
WHERE family = 'SEAFOOD'
ORDER BY bien_ln_gop_pct DESC, item_nbr;

-- [scm-n1-bien-ln-gop-seafood] wrong: chia_cho_gia_von
-- Rớt ở public: chia cho giá vốn ra tỷ lệ cộng thêm trên giá vốn,
-- không phải biên lợi nhuận gộp.
SELECT item_nbr, unit_price, unit_cost,
       ROUND((unit_price - unit_cost) / unit_cost * 100, 2) AS bien_ln_gop_pct
FROM item_costs
WHERE family = 'SEAFOOD'
ORDER BY bien_ln_gop_pct DESC, item_nbr;

-- [scm-n1-bien-ln-gop-seafood] wrong: thieu_ngoac_phep_tru
-- Rớt ở public: phép chia làm trước phép trừ, ra số âm.
SELECT item_nbr, unit_price, unit_cost,
       ROUND(unit_price - unit_cost / unit_price * 100, 2) AS bien_ln_gop_pct
FROM item_costs
WHERE family = 'SEAFOOD'
ORDER BY bien_ln_gop_pct DESC, item_nbr;

-- [scm-n2-hang-chua-ve-thang-8] solution
SELECT po_id, po_date, qty_ordered,
       qty_ordered - COALESCE(qty_received, 0) AS luong_chua_ve,
       CASE WHEN received_date IS NULL THEN 'chua_ve' ELSE 'da_ve' END AS trang_thai
FROM purchase_orders
WHERE supplier_id = 'SUP_007'
  AND po_date >= '2017-08-01' AND po_date < '2017-08-15'
ORDER BY po_date, po_id;

-- [scm-n2-hang-chua-ve-thang-8] wrong: tru_truc_tiep_o_trong
-- Rớt ở public: qty_ordered - NULL là NULL, đơn chưa về có luong_chua_ve trống.
SELECT po_id, po_date, qty_ordered,
       qty_ordered - qty_received AS luong_chua_ve,
       CASE WHEN received_date IS NULL THEN 'chua_ve' ELSE 'da_ve' END AS trang_thai
FROM purchase_orders
WHERE supplier_id = 'SUP_007'
  AND po_date >= '2017-08-01' AND po_date < '2017-08-15'
ORDER BY po_date, po_id;

-- [scm-n2-hang-chua-ve-thang-8] wrong: so_sanh_bang_null
-- Rớt ở public: received_date = NULL không bao giờ đúng, mọi đơn thành 'da_ve'.
SELECT po_id, po_date, qty_ordered,
       qty_ordered - COALESCE(qty_received, 0) AS luong_chua_ve,
       CASE WHEN received_date = NULL THEN 'chua_ve' ELSE 'da_ve' END AS trang_thai
FROM purchase_orders
WHERE supplier_id = 'SUP_007'
  AND po_date >= '2017-08-01' AND po_date < '2017-08-15'
ORDER BY po_date, po_id;

-- [scm-n2-hang-chua-ve-thang-8] wrong: thieu_can_tren
-- Rớt ở public: lấy thêm hơn 500 đơn đặt ngày 15/8.
SELECT po_id, po_date, qty_ordered,
       qty_ordered - COALESCE(qty_received, 0) AS luong_chua_ve,
       CASE WHEN received_date IS NULL THEN 'chua_ve' ELSE 'da_ve' END AS trang_thai
FROM purchase_orders
WHERE supplier_id = 'SUP_007'
  AND po_date >= '2017-08-01'
ORDER BY po_date, po_id;

-- [scm-n3-trang-thai-giao-don-toi-15-7-2016] solution
SELECT order_id, lead_time_total_h, promised_h,
       CASE WHEN is_cancelled = 1 THEN NULL
            ELSE ROUND(promised_h - lead_time_total_h, 2) END AS con_du_h,
       CASE WHEN is_cancelled = 1 THEN 'huy'
            WHEN lead_time_total_h > promised_h THEN 'tre'
            WHEN lead_time_total_h > promised_h - 1 THEN 'sat_han'
            ELSE 'dung_han' END AS trang_thai
FROM orders
WHERE dest_city = 'Hà Nội'
  AND created_at >= '2016-07-15 20:30:00' AND created_at < '2016-07-15 21:00:00'
ORDER BY order_id;

-- [scm-n3-trang-thai-giao-don-toi-15-7-2016] wrong: dung_co_on_time
-- Qua public, rớt ở hidden-1: đơn ORD2_00422150 giao đúng bằng cam kết
-- nhưng cờ on_time bị ghi 0, nên bị xếp 'tre'.
SELECT order_id, lead_time_total_h, promised_h,
       CASE WHEN is_cancelled = 1 THEN NULL
            ELSE ROUND(promised_h - lead_time_total_h, 2) END AS con_du_h,
       CASE WHEN is_cancelled = 1 THEN 'huy'
            WHEN on_time = 0 THEN 'tre'
            WHEN lead_time_total_h > promised_h - 1 THEN 'sat_han'
            ELSE 'dung_han' END AS trang_thai
FROM orders
WHERE dest_city = 'Hà Nội'
  AND created_at >= '2016-07-15 20:30:00' AND created_at < '2016-07-15 21:00:00'
ORDER BY order_id;

-- [scm-n3-trang-thai-giao-don-toi-15-7-2016] wrong: giao_dung_bang_cam_ket_la_tre
-- Rớt ở public: so >= xếp đơn giao đúng bằng 60 giờ cam kết vào 'tre'.
SELECT order_id, lead_time_total_h, promised_h,
       CASE WHEN is_cancelled = 1 THEN NULL
            ELSE ROUND(promised_h - lead_time_total_h, 2) END AS con_du_h,
       CASE WHEN is_cancelled = 1 THEN 'huy'
            WHEN lead_time_total_h >= promised_h THEN 'tre'
            WHEN lead_time_total_h > promised_h - 1 THEN 'sat_han'
            ELSE 'dung_han' END AS trang_thai
FROM orders
WHERE dest_city = 'Hà Nội'
  AND created_at >= '2016-07-15 20:30:00' AND created_at < '2016-07-15 21:00:00'
ORDER BY order_id;

-- [scm-n3-trang-thai-giao-don-toi-15-7-2016] wrong: quen_trang_thai_huy
-- Rớt ở public: chỉ xét số giờ, ba đơn huỷ (lead time khoảng 36 giờ) thành 'dung_han'.
SELECT order_id, lead_time_total_h, promised_h,
       CASE WHEN is_cancelled = 1 THEN NULL
            ELSE ROUND(promised_h - lead_time_total_h, 2) END AS con_du_h,
       CASE WHEN lead_time_total_h > promised_h THEN 'tre'
            WHEN lead_time_total_h > promised_h - 1 THEN 'sat_han'
            ELSE 'dung_han' END AS trang_thai
FROM orders
WHERE dest_city = 'Hà Nội'
  AND created_at >= '2016-07-15 20:30:00' AND created_at < '2016-07-15 21:00:00'
ORDER BY order_id;

-- [scm-n3-trang-thai-giao-don-toi-15-7-2016] wrong: con_du_cua_don_huy
-- Rớt ở public: đơn huỷ vẫn có số giờ, nhưng cột còn dư phải để trống.
SELECT order_id, lead_time_total_h, promised_h,
       ROUND(promised_h - lead_time_total_h, 2) AS con_du_h,
       CASE WHEN is_cancelled = 1 THEN 'huy'
            WHEN lead_time_total_h > promised_h THEN 'tre'
            WHEN lead_time_total_h > promised_h - 1 THEN 'sat_han'
            ELSE 'dung_han' END AS trang_thai
FROM orders
WHERE dest_city = 'Hà Nội'
  AND created_at >= '2016-07-15 20:30:00' AND created_at < '2016-07-15 21:00:00'
ORDER BY order_id;

-- [scm-n4-fill-rate-cua-hang-52] solution
SELECT item_nbr, sold, thieu_hut,
       ROUND(100 * (1 - thieu_hut / sold), 2) AS fill_rate_pct
FROM inventory_snapshots
WHERE store_nbr = 52
  AND ym = '2017-07'
ORDER BY thieu_hut DESC, item_nbr
LIMIT 10;

-- [scm-n4-fill-rate-cua-hang-52] wrong: cong_thieu_hut_vao_mau_so
-- Rớt ở public: thieu_hut đã nằm trong sold; coi nhu cầu = sold + thieu_hut
-- là sai quy ước của bộ dữ liệu.
SELECT item_nbr, sold, thieu_hut,
       ROUND(100 * sold / (sold + thieu_hut), 2) AS fill_rate_pct
FROM inventory_snapshots
WHERE store_nbr = 52
  AND ym = '2017-07'
ORDER BY thieu_hut DESC, item_nbr
LIMIT 10;

-- [scm-n4-fill-rate-cua-hang-52] wrong: nhan_100_truoc_phep_tru
-- Rớt ở public: 1 - thieu_hut / sold * 100 nhân 100 vào phần thiếu hụt rồi mới trừ.
SELECT item_nbr, sold, thieu_hut,
       ROUND(1 - thieu_hut / sold * 100, 2) AS fill_rate_pct
FROM inventory_snapshots
WHERE store_nbr = 52
  AND ym = '2017-07'
ORDER BY thieu_hut DESC, item_nbr
LIMIT 10;

-- [scm-n5-gio-chua-gan-don-hue] solution
SELECT o.order_id, o.lead_time_total_h,
       ROUND(o.t1_tao_don_pick_h + o.t2_pick_xuat_h + o.t3a_di_chuyen_h
             + o.t3b_sorting_h + o.t4_kho_giao_h, 2) AS tong_chang_h,
       ROUND(o.lead_time_total_h - (o.t1_tao_don_pick_h + o.t2_pick_xuat_h
             + o.t3a_di_chuyen_h + o.t3b_sorting_h + o.t4_kho_giao_h), 2) AS chua_gan_h
FROM orders o
JOIN sorting_hubs h ON h.hub_id = o.dest_hub_id
WHERE h.city = 'Huế'
  AND o.order_date = '2017-07-07'
  AND o.is_cancelled = 0
  AND o.lead_time_total_h - (o.t1_tao_don_pick_h + o.t2_pick_xuat_h + o.t3a_di_chuyen_h
      + o.t3b_sorting_h + o.t4_kho_giao_h) >= 50
ORDER BY o.order_id;

-- [scm-n5-gio-chua-gan-don-hue] wrong: thieu_chang_phan_loai
-- Rớt ở public: bỏ t3b (thời gian phân loại) nên thời gian chưa gán bị thổi lên.
SELECT order_id, lead_time_total_h,
       ROUND(t1_tao_don_pick_h + t2_pick_xuat_h + t3a_di_chuyen_h
             + t4_kho_giao_h, 2) AS tong_chang_h,
       ROUND(lead_time_total_h - (t1_tao_don_pick_h + t2_pick_xuat_h + t3a_di_chuyen_h
             + t4_kho_giao_h), 2) AS chua_gan_h
FROM orders
WHERE dest_hub_id = 'HUB_HUE'
  AND order_date = '2017-07-07'
  AND is_cancelled = 0
  AND lead_time_total_h - (t1_tao_don_pick_h + t2_pick_xuat_h + t3a_di_chuyen_h
      + t4_kho_giao_h) >= 50
ORDER BY order_id;

-- [scm-n5-gio-chua-gan-don-hue] wrong: khong_loai_don_huy
-- Rớt ở public: đơn huỷ vẫn có giá trị ở các cột thời gian, lọt thêm hai đơn.
SELECT order_id, lead_time_total_h,
       ROUND(t1_tao_don_pick_h + t2_pick_xuat_h + t3a_di_chuyen_h + t3b_sorting_h
             + t4_kho_giao_h, 2) AS tong_chang_h,
       ROUND(lead_time_total_h - (t1_tao_don_pick_h + t2_pick_xuat_h + t3a_di_chuyen_h
             + t3b_sorting_h + t4_kho_giao_h), 2) AS chua_gan_h
FROM orders
WHERE dest_hub_id = 'HUB_HUE'
  AND order_date = '2017-07-07'
  AND lead_time_total_h - (t1_tao_don_pick_h + t2_pick_xuat_h + t3a_di_chuyen_h
      + t3b_sorting_h + t4_kho_giao_h) >= 50
ORDER BY order_id;

-- [scm-n6-voucher-den-bu-don-tre-bac-giang] solution
SELECT order_id, order_value_usd,
       ROUND(lead_time_total_h - promised_h, 2) AS so_gio_tre,
       CASE WHEN lead_time_total_h - promised_h >= 5 THEN 20
            WHEN lead_time_total_h - promised_h >= 2 THEN 10
            ELSE 0 END AS muc_den_bu_pct,
       ROUND(order_value_usd * CASE WHEN lead_time_total_h - promised_h >= 5 THEN 0.20
                                    WHEN lead_time_total_h - promised_h >= 2 THEN 0.10
                                    ELSE 0 END, 2) AS gia_tri_voucher
FROM orders
WHERE dest_city = 'Bắc Giang'
  AND created_at >= '2017-08-01' AND created_at < '2017-09-01'
  AND is_cancelled = 0
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n6-voucher-den-bu-don-tre-bac-giang] wrong: tinh_ca_don_huy
-- Rớt ở public: đơn huỷ vẫn có số giờ, lọt thêm ba đơn huỷ "giao trễ".
SELECT order_id, order_value_usd,
       ROUND(lead_time_total_h - promised_h, 2) AS so_gio_tre,
       CASE WHEN lead_time_total_h - promised_h >= 5 THEN 20
            WHEN lead_time_total_h - promised_h >= 2 THEN 10
            ELSE 0 END AS muc_den_bu_pct,
       ROUND(order_value_usd * CASE WHEN lead_time_total_h - promised_h >= 5 THEN 0.20
                                    WHEN lead_time_total_h - promised_h >= 2 THEN 0.10
                                    ELSE 0 END, 2) AS gia_tri_voucher
FROM orders
WHERE dest_city = 'Bắc Giang'
  AND created_at >= '2017-08-01' AND created_at < '2017-09-01'
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n6-voucher-den-bu-don-tre-bac-giang] wrong: xet_muc_thap_truoc
-- Rớt ở public: CASE dừng ở điều kiện đúng đầu tiên, đơn trễ từ 5 giờ chỉ được 10%.
SELECT order_id, order_value_usd,
       ROUND(lead_time_total_h - promised_h, 2) AS so_gio_tre,
       CASE WHEN lead_time_total_h - promised_h >= 2 THEN 10
            WHEN lead_time_total_h - promised_h >= 5 THEN 20
            ELSE 0 END AS muc_den_bu_pct,
       ROUND(order_value_usd * CASE WHEN lead_time_total_h - promised_h >= 2 THEN 0.10
                                    WHEN lead_time_total_h - promised_h >= 5 THEN 0.20
                                    ELSE 0 END, 2) AS gia_tri_voucher
FROM orders
WHERE dest_city = 'Bắc Giang'
  AND created_at >= '2017-08-01' AND created_at < '2017-09-01'
  AND is_cancelled = 0
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n6-voucher-den-bu-don-tre-bac-giang] wrong: nhan_so_phan_tram
-- Rớt ở public: nhân giá trị đơn với 10, 20 thay vì 10%, 20%.
SELECT order_id, order_value_usd,
       ROUND(lead_time_total_h - promised_h, 2) AS so_gio_tre,
       CASE WHEN lead_time_total_h - promised_h >= 5 THEN 20
            WHEN lead_time_total_h - promised_h >= 2 THEN 10
            ELSE 0 END AS muc_den_bu_pct,
       ROUND(order_value_usd * CASE WHEN lead_time_total_h - promised_h >= 5 THEN 20
                                    WHEN lead_time_total_h - promised_h >= 2 THEN 10
                                    ELSE 0 END, 2) AS gia_tri_voucher
FROM orders
WHERE dest_city = 'Bắc Giang'
  AND created_at >= '2017-08-01' AND created_at < '2017-09-01'
  AND is_cancelled = 0
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n6-voucher-den-bu-don-tre-bac-giang] wrong: thieu_can_tren
-- Qua public (đơn public tới 13/8/2017), rớt ở hidden-1: thêm đơn ORD2_01033328
-- tới Bắc Giang tạo ngày 1/9/2017, giao trễ.
SELECT order_id, order_value_usd,
       ROUND(lead_time_total_h - promised_h, 2) AS so_gio_tre,
       CASE WHEN lead_time_total_h - promised_h >= 5 THEN 20
            WHEN lead_time_total_h - promised_h >= 2 THEN 10
            ELSE 0 END AS muc_den_bu_pct,
       ROUND(order_value_usd * CASE WHEN lead_time_total_h - promised_h >= 5 THEN 0.20
                                    WHEN lead_time_total_h - promised_h >= 2 THEN 0.10
                                    ELSE 0 END, 2) AS gia_tri_voucher
FROM orders
WHERE dest_city = 'Bắc Giang'
  AND created_at >= '2017-08-01'
  AND is_cancelled = 0
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n7-gia-dau-thang-7-thap] starter
SELECT ROUND(AVG(COALESCE(dcoilwtico, 0)), 2) AS gia_dau_tb
FROM oil
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01';

-- [scm-n7-gia-dau-thang-7-thap] solution
SELECT ROUND(AVG(dcoilwtico), 2) AS gia_dau_tb
FROM oil
WHERE `date` >= '2017-07-01' AND `date` < '2017-08-01';

-- [scm-n7-gia-dau-thang-7-thap] wrong: thieu_can_tren
-- Rớt ở public: sửa đúng hàm nhưng bỏ cận trên, lấy cả giá dầu tháng 8/2017.
SELECT ROUND(AVG(dcoilwtico), 2) AS gia_dau_tb
FROM oil
WHERE `date` >= '2017-07-01';

-- [scm-n8-dung-han-thai-binh-tron] starter
SELECT COUNT(*) AS so_don,
       SUM(on_time) AS so_dung_han,
       ROUND(SUM(on_time) / COUNT(*), 2) * 100 AS ty_le_dung_han_pct
FROM orders
WHERE dest_hub_id = 'HUB_THAIBINH'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND is_cancelled = 0;

-- [scm-n8-dung-han-thai-binh-tron] solution
SELECT COUNT(*) AS so_don,
       SUM(on_time) AS so_dung_han,
       ROUND(100 * SUM(on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM orders
WHERE dest_hub_id = 'HUB_THAIBINH'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND is_cancelled = 0;

-- [scm-n8-dung-han-thai-binh-tron] wrong: tinh_ca_don_huy
-- Rớt ở public: sửa đúng chỗ làm tròn nhưng bỏ điều kiện loại đơn huỷ;
-- đơn huỷ vẫn có giá trị on_time nên lọt vào cả tử số và mẫu số.
SELECT COUNT(*) AS so_don,
       SUM(on_time) AS so_dung_han,
       ROUND(100 * SUM(on_time) / COUNT(*), 2) AS ty_le_dung_han_pct
FROM orders
WHERE dest_hub_id = 'HUB_THAIBINH'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01';

-- [scm-n9-gio-tre-nam-dinh-am] starter
SELECT order_id, lead_time_total_h, promised_h,
       ROUND(promised_h - lead_time_total_h, 1) AS so_gio_tre
FROM orders
WHERE dest_city = 'Nam Định'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n9-gio-tre-nam-dinh-am] solution
SELECT order_id, lead_time_total_h, promised_h,
       ROUND(lead_time_total_h - promised_h, 1) AS so_gio_tre
FROM orders
WHERE dest_city = 'Nam Định'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND lead_time_total_h > promised_h
  AND is_cancelled = 0
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n9-gio-tre-nam-dinh-am] wrong: chi_sua_phep_tru
-- Rớt ở public: còn ba đơn huỷ trong danh sách.
SELECT order_id, lead_time_total_h, promised_h,
       ROUND(lead_time_total_h - promised_h, 1) AS so_gio_tre
FROM orders
WHERE dest_city = 'Nam Định'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND lead_time_total_h > promised_h
ORDER BY so_gio_tre DESC, order_id;

-- [scm-n9-gio-tre-nam-dinh-am] wrong: chi_loai_don_huy
-- Rớt ở public: số giờ trễ vẫn âm và thứ tự bị đảo.
SELECT order_id, lead_time_total_h, promised_h,
       ROUND(promised_h - lead_time_total_h, 1) AS so_gio_tre
FROM orders
WHERE dest_city = 'Nam Định'
  AND order_date >= '2017-07-01' AND order_date < '2017-08-01'
  AND lead_time_total_h > promised_h
  AND is_cancelled = 0
ORDER BY so_gio_tre DESC, order_id;

-- ================================================ CASE STUDY

-- [scm-c1-tu-ap-voucher-huy-don.b1] solution
SELECT checkout_group,
       COUNT(*) AS so_don,
       SUM(is_cancelled) AS so_huy,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders
WHERE order_date >= '2017-01-01' AND order_date < '2017-07-01'
GROUP BY checkout_group
ORDER BY ty_le_huy_pct DESC;

-- [scm-c1-tu-ap-voucher-huy-don.b1] wrong: gom_theo_co_dung_voucher
-- Rớt ở public: voucher_applied cho biết đơn có dùng mã, không phải nhóm thử nghiệm.
SELECT voucher_applied,
       COUNT(*) AS so_don,
       SUM(is_cancelled) AS so_huy,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders
WHERE order_date >= '2017-01-01' AND order_date < '2017-07-01'
GROUP BY voucher_applied
ORDER BY ty_le_huy_pct DESC;

-- [scm-c1-tu-ap-voucher-huy-don.b1] wrong: thieu_can_tren
-- Rớt ở public: lấy cả đơn tháng 7 và tháng 8/2017.
SELECT checkout_group,
       COUNT(*) AS so_don,
       SUM(is_cancelled) AS so_huy,
       ROUND(100 * SUM(is_cancelled) / COUNT(*), 2) AS ty_le_huy_pct
FROM orders
WHERE order_date >= '2017-01-01'
GROUP BY checkout_group
ORDER BY ty_le_huy_pct DESC;

-- [scm-c2-thang-ban-nhieu-nhat-2017.b1] solution
SELECT ym AS ky, SUM(sold) AS luong_ban
FROM inventory_snapshots
GROUP BY ym
ORDER BY ym;

-- [scm-c2-thang-ban-nhieu-nhat-2017.b1] wrong: tru_thieu_hut
-- Rớt ở public: lượng bán trong kỳ là sold, không trừ thieu_hut.
SELECT ym AS ky, SUM(sold - thieu_hut) AS luong_ban
FROM inventory_snapshots
GROUP BY ym
ORDER BY ym;

-- [scm-c2-thang-ban-nhieu-nhat-2017.b1] wrong: cong_ton_cuoi_ky
-- Rớt ở public: nhầm tồn cuối kỳ với lượng bán.
SELECT ym AS ky, SUM(on_hand_end) AS luong_ban
FROM inventory_snapshots
GROUP BY ym
ORDER BY ym;

