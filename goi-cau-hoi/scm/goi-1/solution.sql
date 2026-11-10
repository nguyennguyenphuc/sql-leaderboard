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

-- [scm-r2-don-mua-loi-cao-thang-7] solution
SELECT po_id, supplier_id, qty_received, qty_defect, defect_rate
FROM purchase_orders
WHERE po_date >= '2017-07-01' AND po_date < '2017-08-01'
  AND defect_rate >= 0.05
ORDER BY defect_rate DESC, po_id;

-- [scm-r2-don-mua-loi-cao-thang-7] wrong: hieu_ty_le_la_phan_tram
-- Rớt ở public: defect_rate là tỷ lệ (0,05 là 5%), so với 5 ra 0 dòng.
SELECT po_id, supplier_id, qty_received, qty_defect, defect_rate
FROM purchase_orders
WHERE po_date >= '2017-07-01' AND po_date < '2017-08-01'
  AND defect_rate >= 5
ORDER BY defect_rate DESC, po_id;

-- [scm-r2-don-mua-loi-cao-thang-7] wrong: nham_voi_lo_truot
-- Rớt ở public: lô trượt là ngưỡng 2%, lấy mọi lô trượt ra gần 900 dòng.
SELECT po_id, supplier_id, qty_received, qty_defect, defect_rate
FROM purchase_orders
WHERE po_date >= '2017-07-01' AND po_date < '2017-08-01'
  AND inspection_result = 'Fail'
ORDER BY defect_rate DESC, po_id;

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

-- [scm-r5-von-ton-cua-hang-51] solution
SELECT item_nbr, on_hand_end, inventory_value AS von_ton
FROM inventory_snapshots
WHERE store_nbr = 51
  AND ym = '2017-07'
ORDER BY inventory_value DESC, item_nbr
LIMIT 10;

-- [scm-r5-von-ton-cua-hang-51] wrong: sap_theo_luong_ton
-- Rớt ở public: mã tồn nhiều đơn vị chưa chắc có vốn tồn lớn.
SELECT item_nbr, on_hand_end, inventory_value AS von_ton
FROM inventory_snapshots
WHERE store_nbr = 51
  AND ym = '2017-07'
ORDER BY on_hand_end DESC, item_nbr
LIMIT 10;

-- [scm-r5-von-ton-cua-hang-51] wrong: ky_thieu_so_0
-- Rớt ở public: ym là chuỗi '2017-07', viết '2017-7' ra 0 dòng.
SELECT item_nbr, on_hand_end, inventory_value AS von_ton
FROM inventory_snapshots
WHERE store_nbr = 51
  AND ym = '2017-7'
ORDER BY inventory_value DESC, item_nbr
LIMIT 10;

-- [scm-r6-giao-dich-cua-hang-24] solution
SELECT `date`, transactions
FROM transactions
WHERE store_nbr = 24
  AND `date` BETWEEN '2017-07-03' AND '2017-07-09'
ORDER BY `date`;

-- [scm-r6-giao-dich-cua-hang-24] wrong: bo_sot_ngay_cuoi
-- Rớt ở public: cận trên mở nên mất Chủ nhật 9/7.
SELECT `date`, transactions
FROM transactions
WHERE store_nbr = 24
  AND `date` >= '2017-07-03' AND `date` < '2017-07-09'
ORDER BY `date`;

-- [scm-r6-giao-dich-cua-hang-24] wrong: bo_sot_ngay_dau
-- Rớt ở public: cận dưới mở nên mất thứ Hai 3/7.
SELECT `date`, transactions
FROM transactions
WHERE store_nbr = 24
  AND `date` > '2017-07-03' AND `date` <= '2017-07-09'
ORDER BY `date`;

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

-- [scm-r8-don-da-nang-thang-7-thieu] starter
SELECT COUNT(*) AS so_don
FROM orders
WHERE dest_city = 'Đà Nẵng'
  AND created_at BETWEEN '2017-07-01' AND '2017-07-31';

-- [scm-r8-don-da-nang-thang-7-thieu] solution
SELECT COUNT(*) AS so_don
FROM orders
WHERE dest_city = 'Đà Nẵng'
  AND created_at >= '2017-07-01' AND created_at < '2017-08-01';

-- [scm-r8-don-da-nang-thang-7-thieu] wrong: loc_theo_kho_dich
-- Rớt ở public: kho Đà Nẵng còn nhận đơn của các thành phố lân cận.
SELECT COUNT(*) AS so_don
FROM orders
WHERE dest_hub_id = 'DC_DANANG'
  AND created_at >= '2017-07-01' AND created_at < '2017-08-01';

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

-- [scm-n3-muc-tai-kho-ha-noi] solution
SELECT `date`, workload_ratio,
       CASE WHEN workload_ratio > 1 THEN 'qua_tai'
            WHEN workload_ratio >= 0.8 THEN 'sat_nguong'
            ELSE 'binh_thuong' END AS muc_tai
FROM warehouse_daily_ops
WHERE hub_id = 'DC_HANOI'
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`;

-- [scm-n3-muc-tai-kho-ha-noi] wrong: dieu_kien_rong_dat_truoc
-- Rớt ở public: CASE dừng ở điều kiện đúng đầu tiên, ngày quá tải bị gán 'sat_nguong'.
SELECT `date`, workload_ratio,
       CASE WHEN workload_ratio >= 0.8 THEN 'sat_nguong'
            WHEN workload_ratio > 1 THEN 'qua_tai'
            ELSE 'binh_thuong' END AS muc_tai
FROM warehouse_daily_ops
WHERE hub_id = 'DC_HANOI'
  AND `date` >= '2017-07-01' AND `date` < '2017-08-01'
ORDER BY `date`;

-- [scm-n3-muc-tai-kho-ha-noi] wrong: thieu_can_tren
-- Rớt ở public: lấy cả các ngày của tháng 8/2017.
SELECT `date`, workload_ratio,
       CASE WHEN workload_ratio > 1 THEN 'qua_tai'
            WHEN workload_ratio >= 0.8 THEN 'sat_nguong'
            ELSE 'binh_thuong' END AS muc_tai
FROM warehouse_daily_ops
WHERE hub_id = 'DC_HANOI'
  AND `date` >= '2017-07-01'
ORDER BY `date`;

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

-- [scm-n6-ngay-cao-diem-gap-doi-2016] solution
SELECT `date`, event_name, tier,
       ROUND((demand_multiplier - 1) * 100, 0) AS muc_tang_pct
FROM event_calendar
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
  AND (demand_multiplier - 1) * 100 >= 100
ORDER BY muc_tang_pct DESC, `date`;

-- [scm-n6-ngay-cao-diem-gap-doi-2016] wrong: lay_he_so_lam_muc_tang
-- Rớt ở public: hệ số 1,6 nhân 100 ra 160, không phải mức tăng 60%;
-- mọi ngày đều lọt.
SELECT `date`, event_name, tier,
       ROUND(demand_multiplier * 100, 0) AS muc_tang_pct
FROM event_calendar
WHERE `date` >= '2016-01-01' AND `date` < '2017-01-01'
  AND demand_multiplier * 100 >= 100
ORDER BY muc_tang_pct DESC, `date`;

-- [scm-n6-ngay-cao-diem-gap-doi-2016] wrong: thieu_can_tren_nam
-- Rớt ở public: lấy cả ngày cao điểm năm 2017.
SELECT `date`, event_name, tier,
       ROUND((demand_multiplier - 1) * 100, 0) AS muc_tang_pct
FROM event_calendar
WHERE `date` >= '2016-01-01'
  AND (demand_multiplier - 1) * 100 >= 100
ORDER BY muc_tang_pct DESC, `date`;

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

