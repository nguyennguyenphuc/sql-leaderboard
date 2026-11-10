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

-- [aivb-s4-tai-khoan-mo-giua-nam] solution
SELECT COUNT(*) AS so_tai_khoan
FROM core_account
WHERE open_date <= '2026-06-30'
  AND (close_date IS NULL OR close_date > '2026-06-30');

-- [aivb-s4-tai-khoan-mo-giua-nam] wrong: dung_trang_thai_hien_tai
-- Trạng thái hiện tại không phải trạng thái tại 30/06/2026: mất tài khoản đóng sau ngày đó và tài khoản không hoạt động.
SELECT COUNT(*) AS so_tai_khoan
FROM core_account
WHERE open_date <= '2026-06-30' AND account_status = 'ACTIVE';

-- [aivb-s4-tai-khoan-mo-giua-nam] wrong: bo_sot_close_date_null
-- close_date > '2026-06-30' là NULL với tài khoản chưa đóng, nên các tài khoản này bị loại.
SELECT COUNT(*) AS so_tai_khoan
FROM core_account
WHERE open_date <= '2026-06-30' AND close_date > '2026-06-30';

-- [aivb-s5-giai-ngan-ngay-cuoi-thang] solution
SELECT loan_id, disbursement_date, principal
FROM core_loan_contract
WHERE disbursement_date >= '2025-01-01' AND disbursement_date < '2026-01-01'
  AND disbursement_date = LAST_DAY(disbursement_date)
ORDER BY disbursement_date, loan_id;

-- [aivb-s5-giai-ngan-ngay-cuoi-thang] wrong: ngay_31
-- DAY() = 31 bỏ sót tháng 2 và các tháng có 30 ngày.
SELECT loan_id, disbursement_date, principal
FROM core_loan_contract
WHERE disbursement_date >= '2025-01-01' AND disbursement_date < '2026-01-01'
  AND DAY(disbursement_date) = 31
ORDER BY disbursement_date, loan_id;

-- [aivb-s6-ngay-gia-tri-lech] solution
SELECT payment_order_id, transaction_type, channel_code, amount,
       transaction_date, value_date,
       DATEDIFF(value_date, transaction_date) AS so_ngay_lech,
       DAYOFWEEK(transaction_date) AS thu_giao_dich
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
  AND amount >= 30000000
  AND DATEDIFF(value_date, transaction_date) >= 2
ORDER BY so_ngay_lech DESC, amount DESC, payment_order_id;

-- [aivb-s6-ngay-gia-tri-lech] wrong: dao_thu_tu_datediff
-- DATEDIFF(a, b) = a - b; đảo đối số ra số âm nên điều kiện >= 2 không còn dòng nào.
SELECT payment_order_id, transaction_type, channel_code, amount,
       transaction_date, value_date,
       DATEDIFF(transaction_date, value_date) AS so_ngay_lech,
       DAYOFWEEK(transaction_date) AS thu_giao_dich
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
  AND amount >= 30000000
  AND DATEDIFF(transaction_date, value_date) >= 2
ORDER BY so_ngay_lech DESC, amount DESC, payment_order_id;

-- [aivb-s6-ngay-gia-tri-lech] wrong: moi_lenh_lech_ngay
-- Lấy mọi lệnh có ngày giá trị khác ngày giao dịch, lẫn lệnh chỉ lệch 1 ngày.
SELECT payment_order_id, transaction_type, channel_code, amount,
       transaction_date, value_date,
       DATEDIFF(value_date, transaction_date) AS so_ngay_lech,
       DAYOFWEEK(transaction_date) AS thu_giao_dich
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
  AND amount >= 30000000
  AND value_date <> transaction_date
ORDER BY so_ngay_lech DESC, amount DESC, payment_order_id;

-- [aivb-s7-ma-dang-ky-kinh-doanh] starter
SELECT party_id, registration_number, organization_type
FROM core_organization
WHERE registration_number LIKE '010000012'
ORDER BY registration_number;

-- [aivb-s7-ma-dang-ky-kinh-doanh] solution
SELECT party_id, registration_number, organization_type
FROM core_organization
WHERE registration_number LIKE '010000012%'
ORDER BY registration_number;

-- [aivb-s7-ma-dang-ky-kinh-doanh] wrong: bang_kem_ky_tu_dai_dien
-- Dấu = so sánh nguyên chuỗi, ký tự % chỉ có nghĩa đại diện trong LIKE.
SELECT party_id, registration_number, organization_type
FROM core_organization
WHERE registration_number = '010000012%'
ORDER BY registration_number;

-- [aivb-s8-lenh-hoan-theo-thang] starter
SELECT DATE_FORMAT(transaction_date, '%Y-%d') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status = 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%d')
ORDER BY thang;

-- [aivb-s8-lenh-hoan-theo-thang] solution
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status = 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-s8-lenh-hoan-theo-thang] wrong: ten_thang_tieng_anh
-- %M cho tên tháng tiếng Anh: chuỗi '2026-April' đứng trước '2026-January' khi sắp.
SELECT DATE_FORMAT(transaction_date, '%Y-%M') AS thang, COUNT(*) AS so_lenh_bi_dao
FROM core_payment_order
WHERE payment_status = 'REVERSED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%M')
ORDER BY thang;

-- [aivb-s8-lenh-hoan-theo-thang] wrong: gom_ca_bi_tu_choi
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

-- [aivb-a6-ty-le-khoan-vay-co-van-de] solution
SELECT COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN principal ELSE 0 END) / SUM(principal), 2) AS ty_le_goc_pct
FROM core_loan_contract;

-- [aivb-a6-ty-le-khoan-vay-co-van-de] wrong: tinh_theo_du_no
-- Dư nợ của khoản đã xử lý rủi ro là 0, nên tỷ lệ theo dư nợ không đo được phần vốn đã gặp vấn đề.
SELECT COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN outstanding ELSE 0 END) / SUM(outstanding), 2) AS ty_le_goc_pct
FROM core_loan_contract;

-- [aivb-a6-ty-le-khoan-vay-co-van-de] wrong: thieu_xu_ly_rui_ro
SELECT COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED') THEN 1 ELSE 0 END) AS so_khoan_co_van_de,
       ROUND(100 * SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED') THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_so_khoan_pct,
       ROUND(100 * SUM(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED') THEN principal ELSE 0 END) / SUM(principal), 2) AS ty_le_goc_pct
FROM core_loan_contract;

-- [aivb-a7-lenh-thanh-cong-2026] starter
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE transaction_date >= '2026-01-01';

-- [aivb-a7-lenh-thanh-cong-2026] solution
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01';

-- [aivb-a7-lenh-thanh-cong-2026] wrong: quen_can_tren
-- Đã lọc trạng thái nhưng thiếu cận trên: trên hidden-1 lẫn lệnh ngày 2027-01-01.
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01';

-- [aivb-a7-lenh-thanh-cong-2026] wrong: chi_bo_bi_tu_choi
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_gia_tri
FROM core_payment_order
WHERE payment_status <> 'REJECTED'
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

-- [aivb-a9-thieu-nghe-nghiep-theo-thu-nhap] starter
SELECT income_band,
       COUNT(*) AS tong_ca_nhan,
       COUNT(occupation_code) AS so_thieu_nghe_nghiep,
       ROUND(100 * COUNT(occupation_code) / COUNT(*), 2) AS ty_le_thieu_pct
FROM core_person
GROUP BY income_band
ORDER BY income_band;

-- [aivb-a9-thieu-nghe-nghiep-theo-thu-nhap] solution
SELECT income_band,
       COUNT(*) AS tong_ca_nhan,
       COUNT(*) - COUNT(occupation_code) AS so_thieu_nghe_nghiep,
       ROUND(100 * (COUNT(*) - COUNT(occupation_code)) / COUNT(*), 2) AS ty_le_thieu_pct
FROM core_person
GROUP BY income_band
ORDER BY income_band;

-- [aivb-a9-thieu-nghe-nghiep-theo-thu-nhap] wrong: count_bieu_thuc_is_null
-- occupation_code IS NULL cho ra 1 hoặc 0, không bao giờ NULL, nên COUNT đếm mọi dòng.
SELECT income_band,
       COUNT(*) AS tong_ca_nhan,
       COUNT(occupation_code IS NULL) AS so_thieu_nghe_nghiep,
       ROUND(100 * COUNT(occupation_code IS NULL) / COUNT(*), 2) AS ty_le_thieu_pct
FROM core_person
GROUP BY income_band
ORDER BY income_band;

-- [aivb-a9-thieu-nghe-nghiep-theo-thu-nhap] wrong: so_sanh_bang_null
-- occupation_code = NULL luôn cho NULL, không bao giờ đúng.
SELECT income_band,
       COUNT(*) AS tong_ca_nhan,
       SUM(CASE WHEN occupation_code = NULL THEN 1 ELSE 0 END) AS so_thieu_nghe_nghiep,
       ROUND(100 * SUM(CASE WHEN occupation_code = NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_thieu_pct
FROM core_person
GROUP BY income_band
ORDER BY income_band;

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
