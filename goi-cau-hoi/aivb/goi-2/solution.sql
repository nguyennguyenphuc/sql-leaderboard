-- solution.sql: gói 2 bộ AIV Bank (aivb) · Module 3 String & Date, Module 4 Aggregation, case c3, c4.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên aivb (public) và aivb_hidden_1 (hidden-1).

-- ================================================================ MODULE 3 · STRING & DATE

-- [aivb-s1-chi-nhanh-quan] solution
SELECT ref_branch_id, branch_name, city
FROM ref_branch
WHERE branch_name LIKE '%Quận%'
ORDER BY ref_branch_id;

-- [aivb-s1-chi-nhanh-quan] wrong: thieu_phan_tram_dau
-- Thiếu % ở đầu: chỉ khớp tên bắt đầu bằng "Quận", trong khi tên chi nhánh bắt đầu bằng "Chi nhánh".
SELECT ref_branch_id, branch_name, city
FROM ref_branch
WHERE branch_name LIKE 'Quận%'
ORDER BY ref_branch_id;

-- [aivb-s1-chi-nhanh-quan] wrong: so_sanh_bang
SELECT ref_branch_id, branch_name, city
FROM ref_branch
WHERE branch_name = 'Quận'
ORDER BY ref_branch_id;

-- [aivb-s2-ho-kinh-doanh-fnb] solution
SELECT party_id, legal_name
FROM core_party
WHERE party_type = 'ORGANIZATION'
  AND legal_name LIKE 'Ho Kinh Doanh%F&B'
ORDER BY party_id;

-- [aivb-s2-ho-kinh-doanh-fnb] wrong: chi_loc_duoi_fnb
-- Chỉ lọc phần đuôi: lẫn doanh nghiệp, công ty ngành ăn uống không phải hộ kinh doanh.
SELECT party_id, legal_name
FROM core_party
WHERE legal_name LIKE '%F&B'
ORDER BY party_id;

-- [aivb-s2-ho-kinh-doanh-fnb] wrong: sap_theo_ten
SELECT party_id, legal_name
FROM core_party
WHERE legal_name LIKE 'Ho Kinh Doanh%F&B'
ORDER BY legal_name;

-- [aivb-s3-lenh-mobile-theo-thang] solution
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang, COUNT(*) AS so_lenh
FROM core_payment_order
WHERE channel_code = 'MOBILE' AND payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-s3-lenh-mobile-theo-thang] wrong: quen_can_tren
-- Thiếu cận trên: trên hidden-1 xuất hiện thêm nhóm 2027-01.
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang, COUNT(*) AS so_lenh
FROM core_payment_order
WHERE channel_code = 'MOBILE' AND payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-s3-lenh-mobile-theo-thang] wrong: quen_loc_thanh_cong
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang, COUNT(*) AS so_lenh
FROM core_payment_order
WHERE channel_code = 'MOBILE'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-s4-bien-dong-tai-khoan-2026] solution
SELECT SUBSTRING_INDEX(product_version_id, '_', 2) AS san_pham,
       SUM(CASE WHEN open_date <= '2025-12-31'
                 AND (close_date IS NULL OR close_date > '2025-12-31') THEN 1 ELSE 0 END) AS so_dau_ky,
       SUM(CASE WHEN open_date >= '2026-01-01' AND open_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_mo_moi,
       SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_dong,
       SUM(CASE WHEN open_date <= '2026-12-31'
                 AND (close_date IS NULL OR close_date > '2026-12-31') THEN 1 ELSE 0 END) AS so_cuoi_ky,
       ROUND(100 * SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END)
             / SUM(CASE WHEN open_date <= '2026-12-31'
                         AND (close_date IS NULL OR close_date >= '2026-01-01') THEN 1 ELSE 0 END), 2) AS ty_le_dong_pct
FROM core_account
GROUP BY SUBSTRING_INDEX(product_version_id, '_', 2)
ORDER BY san_pham;

-- [aivb-s4-bien-dong-tai-khoan-2026] wrong: bo_sot_close_date_null
-- close_date > '2025-12-31' là NULL với tài khoản chưa đóng: đầu kỳ, cuối kỳ chỉ còn tài khoản đã đóng.
SELECT SUBSTRING_INDEX(product_version_id, '_', 2) AS san_pham,
       SUM(CASE WHEN open_date <= '2025-12-31' AND close_date > '2025-12-31' THEN 1 ELSE 0 END) AS so_dau_ky,
       SUM(CASE WHEN open_date >= '2026-01-01' AND open_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_mo_moi,
       SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_dong,
       SUM(CASE WHEN open_date <= '2026-12-31' AND close_date > '2026-12-31' THEN 1 ELSE 0 END) AS so_cuoi_ky,
       ROUND(100 * SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END)
             / SUM(CASE WHEN open_date <= '2026-12-31' AND close_date >= '2026-01-01' THEN 1 ELSE 0 END), 2) AS ty_le_dong_pct
FROM core_account
GROUP BY SUBSTRING_INDEX(product_version_id, '_', 2)
ORDER BY san_pham;

-- [aivb-s4-bien-dong-tai-khoan-2026] wrong: cuoi_ky_theo_trang_thai
-- Trạng thái 'ACTIVE' là trạng thái tại ngày chốt dữ liệu và bỏ mất tài khoản không hoạt động vẫn đang mở.
SELECT SUBSTRING_INDEX(product_version_id, '_', 2) AS san_pham,
       SUM(CASE WHEN open_date <= '2025-12-31'
                 AND (close_date IS NULL OR close_date > '2025-12-31') THEN 1 ELSE 0 END) AS so_dau_ky,
       SUM(CASE WHEN open_date >= '2026-01-01' AND open_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_mo_moi,
       SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_dong,
       SUM(CASE WHEN account_status = 'ACTIVE' THEN 1 ELSE 0 END) AS so_cuoi_ky,
       ROUND(100 * SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END)
             / SUM(CASE WHEN open_date <= '2026-12-31'
                         AND (close_date IS NULL OR close_date >= '2026-01-01') THEN 1 ELSE 0 END), 2) AS ty_le_dong_pct
FROM core_account
GROUP BY SUBSTRING_INDEX(product_version_id, '_', 2)
ORDER BY san_pham;

-- [aivb-s4-bien-dong-tai-khoan-2026] wrong: cong_dieu_kien_ra_null
-- SUM của phép so sánh ra NULL khi mọi dòng của nhóm có close_date trống: CASA_BIZ ghi NULL thay vì 0.
SELECT SUBSTRING_INDEX(product_version_id, '_', 2) AS san_pham,
       SUM(open_date <= '2025-12-31' AND (close_date IS NULL OR close_date > '2025-12-31')) AS so_dau_ky,
       SUM(open_date >= '2026-01-01' AND open_date <= '2026-12-31') AS so_mo_moi,
       SUM(close_date >= '2026-01-01' AND close_date <= '2026-12-31') AS so_dong,
       SUM(open_date <= '2026-12-31' AND (close_date IS NULL OR close_date > '2026-12-31')) AS so_cuoi_ky,
       ROUND(100 * SUM(close_date >= '2026-01-01' AND close_date <= '2026-12-31')
             / SUM(open_date <= '2026-12-31' AND (close_date IS NULL OR close_date >= '2026-01-01')), 2) AS ty_le_dong_pct
FROM core_account
GROUP BY SUBSTRING_INDEX(product_version_id, '_', 2)
ORDER BY san_pham;

-- [aivb-s4-bien-dong-tai-khoan-2026] wrong: giu_ma_phien_ban
-- Gom theo nguyên mã phiên bản: cột sản phẩm ra 'CASA_IND_V1' thay vì 'CASA_IND'.
SELECT product_version_id AS san_pham,
       SUM(CASE WHEN open_date <= '2025-12-31'
                 AND (close_date IS NULL OR close_date > '2025-12-31') THEN 1 ELSE 0 END) AS so_dau_ky,
       SUM(CASE WHEN open_date >= '2026-01-01' AND open_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_mo_moi,
       SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END) AS so_dong,
       SUM(CASE WHEN open_date <= '2026-12-31'
                 AND (close_date IS NULL OR close_date > '2026-12-31') THEN 1 ELSE 0 END) AS so_cuoi_ky,
       ROUND(100 * SUM(CASE WHEN close_date >= '2026-01-01' AND close_date <= '2026-12-31' THEN 1 ELSE 0 END)
             / SUM(CASE WHEN open_date <= '2026-12-31'
                         AND (close_date IS NULL OR close_date >= '2026-01-01') THEN 1 ELSE 0 END), 2) AS ty_le_dong_pct
FROM core_account
GROUP BY product_version_id
ORDER BY san_pham;

-- [aivb-s5-giai-ngan-don-cuoi-thang] solution
SELECT DATE_FORMAT(disbursement_date, '%Y-%m') AS thang,
       COUNT(*) AS so_lan_giai_ngan,
       ROUND(SUM(amount) / 1000000, 0) AS tong_giai_ngan_trieu,
       ROUND(SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) < 5
                      THEN amount ELSE 0 END) / 1000000, 0) AS giai_ngan_cuoi_thang_trieu,
       ROUND(100 * SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) < 5
                            THEN amount ELSE 0 END) / SUM(amount), 2) AS ty_trong_pct
FROM core_loan_disbursement
WHERE disbursement_date >= '2025-01-01' AND disbursement_date < '2026-01-01'
GROUP BY DATE_FORMAT(disbursement_date, '%Y-%m')
HAVING SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) < 5
                THEN amount ELSE 0 END) / SUM(amount) >= 0.3
ORDER BY ty_trong_pct DESC, thang;

-- [aivb-s5-giai-ngan-don-cuoi-thang] wrong: ngay_co_dinh_tu_27
-- Lấy cố định từ ngày 27: đúng với tháng 31 ngày nhưng sai với tháng 2 và tháng 30 ngày.
SELECT DATE_FORMAT(disbursement_date, '%Y-%m') AS thang,
       COUNT(*) AS so_lan_giai_ngan,
       ROUND(SUM(amount) / 1000000, 0) AS tong_giai_ngan_trieu,
       ROUND(SUM(CASE WHEN DAY(disbursement_date) >= 27 THEN amount ELSE 0 END) / 1000000, 0) AS giai_ngan_cuoi_thang_trieu,
       ROUND(100 * SUM(CASE WHEN DAY(disbursement_date) >= 27 THEN amount ELSE 0 END) / SUM(amount), 2) AS ty_trong_pct
FROM core_loan_disbursement
WHERE disbursement_date >= '2025-01-01' AND disbursement_date < '2026-01-01'
GROUP BY DATE_FORMAT(disbursement_date, '%Y-%m')
HAVING SUM(CASE WHEN DAY(disbursement_date) >= 27 THEN amount ELSE 0 END) / SUM(amount) >= 0.3
ORDER BY ty_trong_pct DESC, thang;

-- [aivb-s5-giai-ngan-don-cuoi-thang] wrong: thua_mot_ngay
-- DATEDIFF <= 5 lấy 6 ngày cuối tháng.
SELECT DATE_FORMAT(disbursement_date, '%Y-%m') AS thang,
       COUNT(*) AS so_lan_giai_ngan,
       ROUND(SUM(amount) / 1000000, 0) AS tong_giai_ngan_trieu,
       ROUND(SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) <= 5
                      THEN amount ELSE 0 END) / 1000000, 0) AS giai_ngan_cuoi_thang_trieu,
       ROUND(100 * SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) <= 5
                            THEN amount ELSE 0 END) / SUM(amount), 2) AS ty_trong_pct
FROM core_loan_disbursement
WHERE disbursement_date >= '2025-01-01' AND disbursement_date < '2026-01-01'
GROUP BY DATE_FORMAT(disbursement_date, '%Y-%m')
HAVING SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) <= 5
                THEN amount ELSE 0 END) / SUM(amount) >= 0.3
ORDER BY ty_trong_pct DESC, thang;

-- [aivb-s5-giai-ngan-don-cuoi-thang] wrong: chi_lan_giai_ngan_dau
-- Dùng ngày giải ngân đầu và số tiền vay ban đầu trên hợp đồng vay: bỏ sót các lần giải ngân sau.
SELECT DATE_FORMAT(disbursement_date, '%Y-%m') AS thang,
       COUNT(*) AS so_lan_giai_ngan,
       ROUND(SUM(principal) / 1000000, 0) AS tong_giai_ngan_trieu,
       ROUND(SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) < 5
                      THEN principal ELSE 0 END) / 1000000, 0) AS giai_ngan_cuoi_thang_trieu,
       ROUND(100 * SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) < 5
                            THEN principal ELSE 0 END) / SUM(principal), 2) AS ty_trong_pct
FROM core_loan_contract
WHERE disbursement_date >= '2025-01-01' AND disbursement_date < '2026-01-01'
GROUP BY DATE_FORMAT(disbursement_date, '%Y-%m')
HAVING SUM(CASE WHEN DATEDIFF(LAST_DAY(disbursement_date), disbursement_date) < 5
                THEN principal ELSE 0 END) / SUM(principal) >= 0.3
ORDER BY ty_trong_pct DESC, thang;

-- [aivb-s6-ngay-gia-tri-sang-thang-sau] solution
SELECT CONCAT(nam, '-', LPAD(thang_so, 2, '0')) AS thang,
       so_lenh,
       so_lenh_sang_thang_sau,
       ROUND(gia_tri_sang_thang_sau / 1000000, 2) AS gia_tri_sang_thang_sau_trieu,
       ROUND(100 * gia_tri_sang_thang_sau / tong_gia_tri, 2) AS ty_le_gia_tri_pct
FROM (
  SELECT YEAR(transaction_date) AS nam, MONTH(transaction_date) AS thang_so,
         COUNT(*) AS so_lenh,
         SUM(CASE WHEN value_date > LAST_DAY(transaction_date) THEN 1 ELSE 0 END) AS so_lenh_sang_thang_sau,
         SUM(CASE WHEN value_date > LAST_DAY(transaction_date) THEN amount ELSE 0 END) AS gia_tri_sang_thang_sau,
         SUM(amount) AS tong_gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY YEAR(transaction_date), MONTH(transaction_date)
) AS theo_thang
ORDER BY thang;

-- [aivb-s6-ngay-gia-tri-sang-thang-sau] wrong: so_sanh_so_thang
-- So MONTH() bỏ mất lệnh cuối tháng 12 có ngày giá trị tháng 1 năm sau (12 > 1 là sai).
SELECT CONCAT(nam, '-', LPAD(thang_so, 2, '0')) AS thang,
       so_lenh,
       so_lenh_sang_thang_sau,
       ROUND(gia_tri_sang_thang_sau / 1000000, 2) AS gia_tri_sang_thang_sau_trieu,
       ROUND(100 * gia_tri_sang_thang_sau / tong_gia_tri, 2) AS ty_le_gia_tri_pct
FROM (
  SELECT YEAR(transaction_date) AS nam, MONTH(transaction_date) AS thang_so,
         COUNT(*) AS so_lenh,
         SUM(CASE WHEN MONTH(value_date) > MONTH(transaction_date) THEN 1 ELSE 0 END) AS so_lenh_sang_thang_sau,
         SUM(CASE WHEN MONTH(value_date) > MONTH(transaction_date) THEN amount ELSE 0 END) AS gia_tri_sang_thang_sau,
         SUM(amount) AS tong_gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY YEAR(transaction_date), MONTH(transaction_date)
) AS theo_thang
ORDER BY thang;

-- [aivb-s6-ngay-gia-tri-sang-thang-sau] wrong: moi_lenh_lech_ngay
-- Đếm mọi lệnh có ngày giá trị sau ngày giao dịch, kể cả lệnh vẫn trong cùng tháng.
SELECT CONCAT(nam, '-', LPAD(thang_so, 2, '0')) AS thang,
       so_lenh,
       so_lenh_sang_thang_sau,
       ROUND(gia_tri_sang_thang_sau / 1000000, 2) AS gia_tri_sang_thang_sau_trieu,
       ROUND(100 * gia_tri_sang_thang_sau / tong_gia_tri, 2) AS ty_le_gia_tri_pct
FROM (
  SELECT YEAR(transaction_date) AS nam, MONTH(transaction_date) AS thang_so,
         COUNT(*) AS so_lenh,
         SUM(CASE WHEN value_date > transaction_date THEN 1 ELSE 0 END) AS so_lenh_sang_thang_sau,
         SUM(CASE WHEN value_date > transaction_date THEN amount ELSE 0 END) AS gia_tri_sang_thang_sau,
         SUM(amount) AS tong_gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY YEAR(transaction_date), MONTH(transaction_date)
) AS theo_thang
ORDER BY thang;

-- [aivb-s6-ngay-gia-tri-sang-thang-sau] wrong: quen_can_tren
-- Thiếu cận trên: trên hidden-1 có thêm nhóm 2027-01.
SELECT CONCAT(nam, '-', LPAD(thang_so, 2, '0')) AS thang,
       so_lenh,
       so_lenh_sang_thang_sau,
       ROUND(gia_tri_sang_thang_sau / 1000000, 2) AS gia_tri_sang_thang_sau_trieu,
       ROUND(100 * gia_tri_sang_thang_sau / tong_gia_tri, 2) AS ty_le_gia_tri_pct
FROM (
  SELECT YEAR(transaction_date) AS nam, MONTH(transaction_date) AS thang_so,
         COUNT(*) AS so_lenh,
         SUM(CASE WHEN value_date > LAST_DAY(transaction_date) THEN 1 ELSE 0 END) AS so_lenh_sang_thang_sau,
         SUM(CASE WHEN value_date > LAST_DAY(transaction_date) THEN amount ELSE 0 END) AS gia_tri_sang_thang_sau,
         SUM(amount) AS tong_gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01'
  GROUP BY YEAR(transaction_date), MONTH(transaction_date)
) AS theo_thang
ORDER BY thang;

-- [aivb-s6-ngay-gia-tri-sang-thang-sau] wrong: quen_loc_thanh_cong
SELECT CONCAT(nam, '-', LPAD(thang_so, 2, '0')) AS thang,
       so_lenh,
       so_lenh_sang_thang_sau,
       ROUND(gia_tri_sang_thang_sau / 1000000, 2) AS gia_tri_sang_thang_sau_trieu,
       ROUND(100 * gia_tri_sang_thang_sau / tong_gia_tri, 2) AS ty_le_gia_tri_pct
FROM (
  SELECT YEAR(transaction_date) AS nam, MONTH(transaction_date) AS thang_so,
         COUNT(*) AS so_lenh,
         SUM(CASE WHEN value_date > LAST_DAY(transaction_date) THEN 1 ELSE 0 END) AS so_lenh_sang_thang_sau,
         SUM(CASE WHEN value_date > LAST_DAY(transaction_date) THEN amount ELSE 0 END) AS gia_tri_sang_thang_sau,
         SUM(amount) AS tong_gia_tri
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY YEAR(transaction_date), MONTH(transaction_date)
) AS theo_thang
ORDER BY thang;

-- [aivb-s7-tham-nien-khach-hang] starter
SELECT YEAR('2026-06-30') - YEAR(customer_since) AS tham_nien, COUNT(*) AS so_khach
FROM core_customer
WHERE customer_status = 'ACTIVE' AND customer_since <= '2026-06-30'
GROUP BY YEAR('2026-06-30') - YEAR(customer_since)
ORDER BY tham_nien;

-- [aivb-s7-tham-nien-khach-hang] solution
SELECT TIMESTAMPDIFF(YEAR, customer_since, '2026-06-30') AS tham_nien, COUNT(*) AS so_khach
FROM core_customer
WHERE customer_status = 'ACTIVE' AND customer_since <= '2026-06-30'
GROUP BY TIMESTAMPDIFF(YEAR, customer_since, '2026-06-30')
ORDER BY tham_nien;

-- [aivb-s7-tham-nien-khach-hang] wrong: chia_365_ngay
-- Chia số ngày cho 365 bỏ qua năm nhuận: khách sát ngày kỷ niệm bị tính thừa một năm.
SELECT FLOOR(DATEDIFF('2026-06-30', customer_since) / 365) AS tham_nien, COUNT(*) AS so_khach
FROM core_customer
WHERE customer_status = 'ACTIVE' AND customer_since <= '2026-06-30'
GROUP BY FLOOR(DATEDIFF('2026-06-30', customer_since) / 365)
ORDER BY tham_nien;

-- [aivb-s7-tham-nien-khach-hang] wrong: lam_tron_so_nam
-- ROUND làm tròn lên khi đã qua nửa năm, không phải số năm tròn.
SELECT ROUND(DATEDIFF('2026-06-30', customer_since) / 365.25) AS tham_nien, COUNT(*) AS so_khach
FROM core_customer
WHERE customer_status = 'ACTIVE' AND customer_since <= '2026-06-30'
GROUP BY ROUND(DATEDIFF('2026-06-30', customer_since) / 365.25)
ORDER BY tham_nien;

-- [aivb-s8-lenh-bi-dao-theo-thang] starter
SELECT DATE_FORMAT(transaction_date, '%Y-%d') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status = 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%d')
ORDER BY thang;

-- [aivb-s8-lenh-bi-dao-theo-thang] solution
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status = 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-s8-lenh-bi-dao-theo-thang] wrong: ten_thang_tieng_anh
-- %M cho tên tháng tiếng Anh: chuỗi '2026-April' đứng trước '2026-January' khi sắp.
SELECT DATE_FORMAT(transaction_date, '%Y-%M') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status = 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%M')
ORDER BY thang;

-- [aivb-s8-lenh-bi-dao-theo-thang] wrong: gom_ca_bi_tu_choi
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status IN ('REVERSED', 'REJECTED')
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-s9-quyet-dinh-kyc-thang-12-2025] starter
SELECT kyc_event_id, customer_id, event_type, event_at
FROM core_customer_kyc_event
WHERE event_type IN ('KYC_APPROVED', 'KYC_REJECTED')
  AND event_at BETWEEN '2025-12-01' AND '2025-12-31'
ORDER BY event_at, kyc_event_id;

-- [aivb-s9-quyet-dinh-kyc-thang-12-2025] solution
SELECT kyc_event_id, customer_id, event_type, event_at
FROM core_customer_kyc_event
WHERE event_type IN ('KYC_APPROVED', 'KYC_REJECTED')
  AND event_at >= '2025-12-01' AND event_at < '2026-01-01'
ORDER BY event_at, kyc_event_id;

-- [aivb-s9-quyet-dinh-kyc-thang-12-2025] wrong: chi_loc_thang
-- MONTH() = 12 không giữ năm: lẫn sự kiện tháng 12 của các năm khác.
SELECT kyc_event_id, customer_id, event_type, event_at
FROM core_customer_kyc_event
WHERE event_type IN ('KYC_APPROVED', 'KYC_REJECTED')
  AND MONTH(event_at) = 12
ORDER BY event_at, kyc_event_id;

-- ================================================================ MODULE 4 · AGGREGATION

-- [aivb-a1-du-no-binh-quan] solution
SELECT COUNT(*) AS so_khoan_vay,
       SUM(outstanding) AS tong_du_no,
       ROUND(AVG(outstanding), 0) AS du_no_bq
FROM core_loan_contract
WHERE loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED');

-- [aivb-a1-du-no-binh-quan] wrong: tinh_ca_khoan_du_no_0
-- Gồm cả khoản đã tất toán và đã xử lý rủi ro (dư nợ 0) nên bình quân thấp hẳn.
SELECT COUNT(*) AS so_khoan_vay,
       SUM(outstanding) AS tong_du_no,
       ROUND(AVG(outstanding), 0) AS du_no_bq
FROM core_loan_contract;

-- [aivb-a1-du-no-binh-quan] wrong: chi_khoan_active
SELECT COUNT(*) AS so_khoan_vay,
       SUM(outstanding) AS tong_du_no,
       ROUND(AVG(outstanding), 0) AS du_no_bq
FROM core_loan_contract
WHERE loan_status = 'ACTIVE';

-- [aivb-a2-khach-hang-theo-phan-khuc] solution
SELECT c.segment_code, c.customer_status,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) AS so_khach_kyc_khong_dat
FROM core_customer c
JOIN ref_segment s ON s.segment_code = c.segment_code
WHERE s.party_type = 'PERSON'
GROUP BY c.segment_code, c.customer_status
ORDER BY c.segment_code, c.customer_status;

-- [aivb-a2-khach-hang-theo-phan-khuc] wrong: count_bieu_thuc_so_sanh
-- COUNT đếm mọi giá trị khác NULL, kể cả 0 của phép so sánh sai.
SELECT c.segment_code, c.customer_status,
       COUNT(*) AS so_khach,
       COUNT(c.kyc_status = 'FAIL') AS so_khach_kyc_khong_dat
FROM core_customer c
JOIN ref_segment s ON s.segment_code = c.segment_code
WHERE s.party_type = 'PERSON'
GROUP BY c.segment_code, c.customer_status
ORDER BY c.segment_code, c.customer_status;

-- [aivb-a2-khach-hang-theo-phan-khuc] wrong: quen_loc_ca_nhan
-- Không lọc phân khúc cá nhân: lẫn các phân khúc tổ chức (CORP, INST, MICRO, SME).
SELECT segment_code, customer_status,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN kyc_status = 'FAIL' THEN 1 ELSE 0 END) AS so_khach_kyc_khong_dat
FROM core_customer
GROUP BY segment_code, customer_status
ORDER BY segment_code, customer_status;

-- [aivb-a3-ho-so-vay-san-pham-hang-diem] solution
SELECT product_id,
       SUM(CASE WHEN score_band = 'A' THEN 1 ELSE 0 END) AS hang_a,
       SUM(CASE WHEN score_band = 'B' THEN 1 ELSE 0 END) AS hang_b,
       SUM(CASE WHEN score_band = 'C' THEN 1 ELSE 0 END) AS hang_c,
       SUM(CASE WHEN score_band = 'D' THEN 1 ELSE 0 END) AS hang_d,
       COUNT(*) AS tong
FROM core_loan_application
GROUP BY product_id
ORDER BY product_id;

-- [aivb-a3-ho-so-vay-san-pham-hang-diem] wrong: count_else_0
-- COUNT đếm cả số 0 của nhánh ELSE, nên mọi cột hạng bằng cột tổng.
SELECT product_id,
       COUNT(CASE WHEN score_band = 'A' THEN 1 ELSE 0 END) AS hang_a,
       COUNT(CASE WHEN score_band = 'B' THEN 1 ELSE 0 END) AS hang_b,
       COUNT(CASE WHEN score_band = 'C' THEN 1 ELSE 0 END) AS hang_c,
       COUNT(CASE WHEN score_band = 'D' THEN 1 ELSE 0 END) AS hang_d,
       COUNT(*) AS tong
FROM core_loan_application
GROUP BY product_id
ORDER BY product_id;

-- [aivb-a4-ty-trong-kenh] solution
SELECT channel_code,
       SUM(amount) AS tong_gia_tri,
       ROUND(100 * SUM(amount) / (SELECT SUM(amount)
                                  FROM core_payment_order
                                  WHERE payment_status = 'COMPLETED'
                                    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'), 2) AS ty_trong_pct
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY channel_code
ORDER BY ty_trong_pct DESC, channel_code;

-- [aivb-a4-ty-trong-kenh] wrong: gom_lenh_khong_thanh_cong
-- Cộng cả lệnh bị đảo và bị từ chối vào giá trị giao dịch.
SELECT channel_code,
       SUM(amount) AS tong_gia_tri,
       ROUND(100 * SUM(amount) / (SELECT SUM(amount)
                                  FROM core_payment_order
                                  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'), 2) AS ty_trong_pct
FROM core_payment_order
WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY channel_code
ORDER BY ty_trong_pct DESC, channel_code;

-- [aivb-a4-ty-trong-kenh] wrong: quen_can_tren
-- Thiếu cận trên: trên hidden-1 cộng thêm lệnh MOBILE ngày 2027-01-01.
SELECT channel_code,
       SUM(amount) AS tong_gia_tri,
       ROUND(100 * SUM(amount) / (SELECT SUM(amount)
                                  FROM core_payment_order
                                  WHERE payment_status = 'COMPLETED'
                                    AND transaction_date >= '2026-01-01'), 2) AS ty_trong_pct
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01'
GROUP BY channel_code
ORDER BY ty_trong_pct DESC, channel_code;

-- [aivb-a5-nhom-dti-ty-le-duyet] solution
SELECT CASE WHEN dti < 0.3 THEN 1
            WHEN dti <= 0.5 THEN 2
            ELSE 3 END AS nhom_dti,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application
GROUP BY nhom_dti
ORDER BY nhom_dti;

-- [aivb-a5-nhom-dti-ty-le-duyet] wrong: dti_theo_phan_tram
-- dti lưu dạng tỷ lệ 0–1; so với 30 và 50 thì mọi hồ sơ rơi vào nhóm 1.
SELECT CASE WHEN dti < 30 THEN 1
            WHEN dti <= 50 THEN 2
            ELSE 3 END AS nhom_dti,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application
GROUP BY nhom_dti
ORDER BY nhom_dti;

-- [aivb-a5-nhom-dti-ty-le-duyet] wrong: mau_so_toan_bo_ho_so
-- Chia số hồ sơ được duyệt của nhóm cho tổng số hồ sơ của mọi nhóm.
SELECT CASE WHEN dti < 0.3 THEN 1
            WHEN dti <= 0.5 THEN 2
            ELSE 3 END AS nhom_dti,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN application_status = 'APPROVED' THEN 1 ELSE 0 END)
             / (SELECT COUNT(*) FROM core_loan_application), 2) AS ty_le_duyet_pct
FROM core_loan_application
GROUP BY nhom_dti
ORDER BY nhom_dti;

-- [aivb-a6-khoan-vay-co-van-de-theo-san-pham] solution
SELECT p.product_id, p.product_name,
       COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN l.principal ELSE 0 END)
             / SUM(l.principal), 2) AS ty_le_goc_pct
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
JOIN ref_product p ON p.product_id = v.product_id
WHERE p.product_family = 'LOAN'
GROUP BY p.product_id, p.product_name
ORDER BY ty_le_goc_pct DESC, p.product_id;

-- [aivb-a6-khoan-vay-co-van-de-theo-san-pham] wrong: tinh_theo_du_no
-- Dư nợ của khoản đã xử lý rủi ro bằng 0, nên tỷ lệ theo dư nợ bỏ mất phần vốn đã gặp vấn đề.
SELECT p.product_id, p.product_name,
       COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN l.outstanding ELSE 0 END)
             / SUM(l.outstanding), 2) AS ty_le_goc_pct
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
JOIN ref_product p ON p.product_id = v.product_id
WHERE p.product_family = 'LOAN'
GROUP BY p.product_id, p.product_name
ORDER BY ty_le_goc_pct DESC, p.product_id;

-- [aivb-a6-khoan-vay-co-van-de-theo-san-pham] wrong: thieu_xu_ly_rui_ro
SELECT p.product_id, p.product_name,
       COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED') THEN l.principal ELSE 0 END)
             / SUM(l.principal), 2) AS ty_le_goc_pct
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
JOIN ref_product p ON p.product_id = v.product_id
WHERE p.product_family = 'LOAN'
GROUP BY p.product_id, p.product_name
ORDER BY ty_le_goc_pct DESC, p.product_id;

-- [aivb-a6-khoan-vay-co-van-de-theo-san-pham] wrong: gom_ca_thau_chi
-- Không loại thấu chi: số tiền vay ban đầu của thấu chi là hạn mức, không phải vốn đã cho vay.
SELECT p.product_id, p.product_name,
       COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN l.principal ELSE 0 END)
             / SUM(l.principal), 2) AS ty_le_goc_pct
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
JOIN ref_product p ON p.product_id = v.product_id
GROUP BY p.product_id, p.product_name
ORDER BY ty_le_goc_pct DESC, p.product_id;

-- [aivb-a6-khoan-vay-co-van-de-theo-san-pham] wrong: sap_theo_so_khoan
-- Sắp theo tỷ lệ số khoản: thứ tự vay mua xe và vay tiêu dùng đảo nhau.
SELECT p.product_id, p.product_name,
       COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN l.loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN l.principal ELSE 0 END)
             / SUM(l.principal), 2) AS ty_le_goc_pct
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
JOIN ref_product p ON p.product_id = v.product_id
WHERE p.product_family = 'LOAN'
GROUP BY p.product_id, p.product_name
ORDER BY ty_le_so_khoan_pct DESC, p.product_id;

-- [aivb-a7-lenh-thanh-cong-2026] starter
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01';

-- [aivb-a7-lenh-thanh-cong-2026] solution
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01';

-- [aivb-a7-lenh-thanh-cong-2026] wrong: chi_bo_bi_tu_choi
-- Chỉ bỏ lệnh bị từ chối: lệnh bị đảo vẫn bị cộng vào.
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE payment_status <> 'REJECTED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01';

-- [aivb-a7-lenh-thanh-cong-2026] wrong: chi_bo_bi_dao
-- Chỉ bỏ lệnh bị đảo: lệnh bị từ chối vẫn bị cộng vào.
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE payment_status <> 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01';

-- [aivb-a8-khach-nop-ho-so-theo-nam] starter
SELECT YEAR(application_date) AS nam, COUNT(*) AS so_chu_the
FROM core_loan_application
GROUP BY YEAR(application_date)
ORDER BY nam;

-- [aivb-a8-khach-nop-ho-so-theo-nam] solution
SELECT YEAR(application_date) AS nam, COUNT(DISTINCT party_id) AS so_chu_the
FROM core_loan_application
GROUP BY YEAR(application_date)
ORDER BY nam;

-- [aivb-a8-khach-nop-ho-so-theo-nam] wrong: distinct_ma_ho_so
-- Mỗi hồ sơ có một mã riêng, nên đếm mã hồ sơ khác nhau vẫn là đếm hồ sơ.
SELECT YEAR(application_date) AS nam, COUNT(DISTINCT application_id) AS so_chu_the
FROM core_loan_application
GROUP BY YEAR(application_date)
ORDER BY nam;

-- [aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang] starter
WITH theo_khoang AS (
  SELECT income_band,
         COUNT(*) AS tong,
         COUNT(occupation_code) AS thieu
  FROM core_person
  GROUP BY income_band
)
SELECT SUM(tong) AS so_khach,
       SUM(thieu) AS so_thieu,
       ROUND(AVG(100 * thieu / tong), 2) AS ty_le_thieu_pct
FROM theo_khoang;

-- [aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang] solution
WITH theo_khoang AS (
  SELECT p.income_band,
         COUNT(*) AS tong,
         COUNT(*) - COUNT(p.occupation_code) AS thieu
  FROM core_person p
  JOIN core_customer c ON c.party_id = p.party_id
  WHERE c.customer_status = 'ACTIVE'
  GROUP BY p.income_band
)
SELECT SUM(tong) AS so_khach,
       SUM(thieu) AS so_thieu,
       ROUND(100 * SUM(thieu) / SUM(tong), 2) AS ty_le_thieu_pct
FROM theo_khoang;

-- [aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang] wrong: binh_quan_cac_ty_le
-- Đã sửa phạm vi và cách đếm nhưng vẫn lấy bình quân tỷ lệ các khoảng thu nhập: khoảng ít khách nặng ngang khoảng đông khách.
WITH theo_khoang AS (
  SELECT p.income_band,
         COUNT(*) AS tong,
         COUNT(*) - COUNT(p.occupation_code) AS thieu
  FROM core_person p
  JOIN core_customer c ON c.party_id = p.party_id
  WHERE c.customer_status = 'ACTIVE'
  GROUP BY p.income_band
)
SELECT SUM(tong) AS so_khach,
       SUM(thieu) AS so_thieu,
       ROUND(AVG(100 * thieu / tong), 2) AS ty_le_thieu_pct
FROM theo_khoang;

-- [aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang] wrong: quen_pham_vi_dang_hoat_dong
-- Tính trên mọi cá nhân, lẫn khách không hoạt động và đã đóng.
WITH theo_khoang AS (
  SELECT income_band,
         COUNT(*) AS tong,
         COUNT(*) - COUNT(occupation_code) AS thieu
  FROM core_person
  GROUP BY income_band
)
SELECT SUM(tong) AS so_khach,
       SUM(thieu) AS so_thieu,
       ROUND(100 * SUM(thieu) / SUM(tong), 2) AS ty_le_thieu_pct
FROM theo_khoang;

-- [aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang] wrong: noi_trai_tu_khach_hang
-- Đi từ bảng khách hàng và nối trái sang cá nhân: khách tổ chức không có dòng cá nhân nên bị đếm là thiếu nghề nghiệp.
SELECT COUNT(*) AS so_khach,
       COUNT(*) - COUNT(p.occupation_code) AS so_thieu,
       ROUND(100 * (COUNT(*) - COUNT(p.occupation_code)) / COUNT(*), 2) AS ty_le_thieu_pct
FROM core_customer c
LEFT JOIN core_person p ON p.party_id = c.party_id
WHERE c.customer_status = 'ACTIVE';

-- [aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang] wrong: dem_so_da_co
-- Sửa phạm vi và cách gộp nhưng COUNT(occupation_code) vẫn đếm số khách đã có nghề nghiệp.
WITH theo_khoang AS (
  SELECT p.income_band,
         COUNT(*) AS tong,
         COUNT(p.occupation_code) AS thieu
  FROM core_person p
  JOIN core_customer c ON c.party_id = p.party_id
  WHERE c.customer_status = 'ACTIVE'
  GROUP BY p.income_band
)
SELECT SUM(tong) AS so_khach,
       SUM(thieu) AS so_thieu,
       ROUND(100 * SUM(thieu) / SUM(tong), 2) AS ty_le_thieu_pct
FROM theo_khoang;

-- ================================================================ CASE STUDY

-- [aivb-c3-kenh-hoan-lenh-quy-4.b1] solution
SELECT channel_code,
       COUNT(*) AS tong_lenh,
       SUM(CASE WHEN payment_status = 'REVERSED' THEN 1 ELSE 0 END) AS so_lenh_bi_dao,
       ROUND(100 * SUM(CASE WHEN payment_status = 'REVERSED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_bi_dao_pct
FROM core_payment_order
WHERE transaction_date >= '2026-10-01' AND transaction_date < '2027-01-01'
GROUP BY channel_code
ORDER BY ty_le_bi_dao_pct DESC, channel_code;

-- [aivb-c3-kenh-hoan-lenh-quy-4.b1] wrong: gom_ca_bi_tu_choi
-- Gộp lệnh bị từ chối (chưa từng được ghi nhận) vào lệnh bị đảo.
SELECT channel_code,
       COUNT(*) AS tong_lenh,
       SUM(CASE WHEN payment_status <> 'COMPLETED' THEN 1 ELSE 0 END) AS so_lenh_bi_dao,
       ROUND(100 * SUM(CASE WHEN payment_status <> 'COMPLETED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_bi_dao_pct
FROM core_payment_order
WHERE transaction_date >= '2026-10-01' AND transaction_date < '2027-01-01'
GROUP BY channel_code
ORDER BY ty_le_bi_dao_pct DESC, channel_code;

-- [aivb-c3-kenh-hoan-lenh-quy-4.b1] wrong: quen_can_tren
-- Thiếu cận trên: trên hidden-1 lẫn lệnh MOBILE ngày 2027-01-01.
SELECT channel_code,
       COUNT(*) AS tong_lenh,
       SUM(CASE WHEN payment_status = 'REVERSED' THEN 1 ELSE 0 END) AS so_lenh_bi_dao,
       ROUND(100 * SUM(CASE WHEN payment_status = 'REVERSED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_bi_dao_pct
FROM core_payment_order
WHERE transaction_date >= '2026-10-01'
GROUP BY channel_code
ORDER BY ty_le_bi_dao_pct DESC, channel_code;

-- [aivb-c4-ho-so-vay-2025.b1] solution
SELECT COUNT(*) AS so_ho_so,
       ROUND(SUM(requested_amount) / 1000000, 0) AS tong_de_nghi_trieu,
       ROUND(100 * SUM(CASE WHEN application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application
WHERE application_date >= '2025-01-01' AND application_date < '2026-01-01';

-- [aivb-c4-ho-so-vay-2025.b1] wrong: khong_loc_nam
-- Tính trên mọi năm, không phải năm 2025.
SELECT COUNT(*) AS so_ho_so,
       ROUND(SUM(requested_amount) / 1000000, 0) AS tong_de_nghi_trieu,
       ROUND(100 * SUM(CASE WHEN application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application;

-- [aivb-c4-ho-so-vay-2025.b2] solution
SELECT a.product_id, p.product_name,
       COUNT(*) AS so_ho_so,
       ROUND(SUM(a.requested_amount) / 1000000, 0) AS tong_de_nghi_trieu
FROM core_loan_application a
JOIN ref_product p ON p.product_id = a.product_id
WHERE a.application_date >= '2025-01-01' AND a.application_date < '2026-01-01'
GROUP BY a.product_id, p.product_name
ORDER BY tong_de_nghi_trieu DESC, a.product_id;

-- [aivb-c4-ho-so-vay-2025.b2] wrong: quen_can_tren
-- Thiếu cận trên: lẫn hồ sơ năm 2026.
SELECT a.product_id, p.product_name,
       COUNT(*) AS so_ho_so,
       ROUND(SUM(a.requested_amount) / 1000000, 0) AS tong_de_nghi_trieu
FROM core_loan_application a
JOIN ref_product p ON p.product_id = a.product_id
WHERE a.application_date >= '2025-01-01'
GROUP BY a.product_id, p.product_name
ORDER BY tong_de_nghi_trieu DESC, a.product_id;
