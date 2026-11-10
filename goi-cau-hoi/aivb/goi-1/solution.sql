-- solution.sql: gói 1 bộ AIV Bank (dulieu=aivb), MySQL 8.0.
-- Chạy trên aivb (public) và aivb_hidden_1 (hidden-1). Mỗi khối một truy vấn SELECT/WITH, kết thúc bằng ;

-- ================================================================ MODULE 1 · RETRIEVAL

-- [aivb-r1-chi-nhanh-mien-nam] solution
SELECT branch_code, branch_name, city
FROM ref_branch
WHERE region = 'MIEN_NAM'
ORDER BY branch_code;

-- [aivb-r1-chi-nhanh-mien-nam] wrong: viet_chu_co_dau
SELECT branch_code, branch_name, city
FROM ref_branch
WHERE region = 'Miền Nam'
ORDER BY branch_code;

-- [aivb-r1-chi-nhanh-mien-nam] wrong: loc_theo_thanh_pho
SELECT branch_code, branch_name, city
FROM ref_branch
WHERE city = 'TP. Hồ Chí Minh'
ORDER BY branch_code;

-- [aivb-r2-phien-ban-tien-gui-ca-nhan] solution
SELECT product_version_id, effective_from, effective_to, product_status
FROM ref_product_version
WHERE product_id = 'TD_IND'
ORDER BY effective_from;

-- [aivb-r2-phien-ban-tien-gui-ca-nhan] wrong: like_lay_ca_doanh_nghiep
SELECT product_version_id, effective_from, effective_to, product_status
FROM ref_product_version
WHERE product_id LIKE 'TD%'
ORDER BY effective_from;

-- [aivb-r2-phien-ban-tien-gui-ca-nhan] wrong: sap_theo_ngay_het_hieu_luc
SELECT product_version_id, effective_from, effective_to, product_status
FROM ref_product_version
WHERE product_id = 'TD_IND'
ORDER BY effective_to;

-- [aivb-r3-kyc-khong-dat-cn01] solution
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id = 'CN01'
  AND kyc_status = 'FAIL'
ORDER BY customer_id;

-- [aivb-r3-kyc-khong-dat-cn01] wrong: nham_ma_giao_dich_chi_nhanh
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id = 'AIVB_CN01'
  AND kyc_status = 'FAIL'
ORDER BY customer_id;

-- [aivb-r3-kyc-khong-dat-cn01] wrong: sai_gia_tri_trang_thai
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id = 'CN01'
  AND kyc_status = 'FAILED'
ORDER BY customer_id;

-- [aivb-r4-top-5-khoan-vay-du-no] solution
SELECT loan_id, outstanding, interest_rate
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
ORDER BY outstanding DESC, loan_id
LIMIT 5;

-- [aivb-r4-top-5-khoan-vay-du-no] wrong: hoa_sai_chieu_khoa_phu
SELECT loan_id, outstanding, interest_rate
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
ORDER BY outstanding DESC, loan_id DESC
LIMIT 5;

-- [aivb-r4-top-5-khoan-vay-du-no] wrong: chep_nguong_tu_chay_thu
SELECT loan_id, outstanding, interest_rate
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
  AND outstanding >= 9955838081
ORDER BY outstanding DESC, loan_id;

-- [aivb-r4-top-5-khoan-vay-du-no] wrong: quen_desc
SELECT loan_id, outstanding, interest_rate
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
ORDER BY outstanding, loan_id
LIMIT 5;

-- [aivb-r5-lenh-web-bi-tu-choi] solution
SELECT payment_order_id, transaction_type, amount
FROM core_payment_order
WHERE channel_code = 'WEB'
  AND payment_status = 'REJECTED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
ORDER BY amount DESC, payment_order_id;

-- [aivb-r5-lenh-web-bi-tu-choi] wrong: nham_lenh_bi_dao
SELECT payment_order_id, transaction_type, amount
FROM core_payment_order
WHERE channel_code = 'WEB'
  AND payment_status = 'REVERSED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
ORDER BY amount DESC, payment_order_id;

-- [aivb-r5-lenh-web-bi-tu-choi] wrong: gop_hai_trang_thai_loi
SELECT payment_order_id, transaction_type, amount
FROM core_payment_order
WHERE channel_code = 'WEB'
  AND payment_status IN ('REJECTED', 'REVERSED')
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
ORDER BY amount DESC, payment_order_id;

-- [aivb-r5-lenh-web-bi-tu-choi] wrong: quen_desc
SELECT payment_order_id, transaction_type, amount
FROM core_payment_order
WHERE channel_code = 'WEB'
  AND payment_status = 'REJECTED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
ORDER BY amount, payment_order_id;

-- [aivb-r6-ho-so-vay-nha-hang-a-2025] solution
SELECT application_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id = 'MORT'
  AND score_band = 'A'
  AND application_status = 'APPROVED'
  AND application_date >= '2025-01-01' AND application_date < '2026-01-01'
ORDER BY application_date, application_id;

-- [aivb-r6-ho-so-vay-nha-hang-a-2025] wrong: thieu_can_tren
SELECT application_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id = 'MORT'
  AND score_band = 'A'
  AND application_status = 'APPROVED'
  AND application_date >= '2025-01-01'
ORDER BY application_date, application_id;

-- [aivb-r6-ho-so-vay-nha-hang-a-2025] wrong: quen_loc_duyet
SELECT application_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id = 'MORT'
  AND score_band = 'A'
  AND application_date >= '2025-01-01' AND application_date < '2026-01-01'
ORDER BY application_date, application_id;

-- [aivb-r7-khach-uu-tien-hoat-dong] starter
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE segment_code = 'PRIORITY' OR segment_code = 'AFFLUENT' AND customer_status = 'ACTIVE'
ORDER BY customer_id;

-- [aivb-r7-khach-uu-tien-hoat-dong] solution
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE segment_code IN ('PRIORITY', 'AFFLUENT')
  AND customer_status = 'ACTIVE'
ORDER BY customer_id;

-- [aivb-r7-khach-uu-tien-hoat-dong] wrong: chi_bo_khach_da_dong
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE (segment_code = 'PRIORITY' OR segment_code = 'AFFLUENT')
  AND customer_status <> 'CLOSED'
ORDER BY customer_id;

-- [aivb-r7-khach-uu-tien-hoat-dong] wrong: and_giua_hai_phan_khuc
SELECT customer_id, segment_code, customer_status
FROM core_customer
WHERE segment_code = 'PRIORITY' AND segment_code = 'AFFLUENT' AND customer_status = 'ACTIVE'
ORDER BY customer_id;

-- [aivb-r8-tien-gui-lai-suat-tren-6] starter
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND term_months BETWEEN 6 AND 12
  AND interest_rate > 5
ORDER BY deposit_id;

-- [aivb-r8-tien-gui-lai-suat-tren-6] solution
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND term_months BETWEEN 6 AND 12
  AND interest_rate > 0.05
ORDER BY deposit_id;

-- [aivb-r8-tien-gui-lai-suat-tren-6] wrong: doi_sai_thang_ty_le
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND term_months BETWEEN 6 AND 12
  AND interest_rate > 0.5
ORDER BY deposit_id;

-- [aivb-r8-tien-gui-lai-suat-tren-6] wrong: bo_hai_bien_ky_han
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND term_months > 6 AND term_months < 12
  AND interest_rate > 0.05
ORDER BY deposit_id;

-- [aivb-r9-but-toan-co-lon-nhat] starter
SELECT posting_id, account_id, amount
FROM core_account_posting
WHERE transaction_date = '2026-06-30'
ORDER BY amount, posting_id
LIMIT 25;

-- [aivb-r9-but-toan-co-lon-nhat] solution
SELECT posting_id, account_id, amount
FROM core_account_posting
WHERE transaction_date = '2026-06-30'
  AND debit_credit = 'CREDIT'
ORDER BY amount DESC, posting_id
LIMIT 25;

-- [aivb-r9-but-toan-co-lon-nhat] wrong: chi_sua_chieu_sap
SELECT posting_id, account_id, amount
FROM core_account_posting
WHERE transaction_date = '2026-06-30'
ORDER BY amount DESC, posting_id
LIMIT 25;

-- [aivb-r9-but-toan-co-lon-nhat] wrong: chi_loc_ghi_co
SELECT posting_id, account_id, amount
FROM core_account_posting
WHERE transaction_date = '2026-06-30'
  AND debit_credit = 'CREDIT'
ORDER BY amount, posting_id
LIMIT 25;


-- [aivb-n1-ca-nhan-thieu-nghe-nghiep] solution
SELECT party_id, employment_status, income_band
FROM core_person
WHERE residence_province = 'HUE'
  AND occupation_code IS NULL
ORDER BY party_id;

-- [aivb-n1-ca-nhan-thieu-nghe-nghiep] wrong: so_sanh_bang_null
SELECT party_id, employment_status, income_band
FROM core_person
WHERE residence_province = 'HUE'
  AND occupation_code = NULL
ORDER BY party_id;

-- [aivb-n1-ca-nhan-thieu-nghe-nghiep] wrong: so_sanh_chuoi_rong
SELECT party_id, employment_status, income_band
FROM core_person
WHERE residence_province = 'HUE'
  AND occupation_code = ''
ORDER BY party_id;

-- [aivb-n2-nhom-thu-nhap] solution
SELECT party_id, income_band,
       CASE
         WHEN income_band IN ('UNDER_10M', '10M_20M') THEN 'Thấp'
         WHEN income_band = '20M_40M' THEN 'Trung bình'
         WHEN income_band IN ('40M_80M', 'OVER_80M') THEN 'Cao'
       END AS nhom_thu_nhap
FROM core_person
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '1991-01-01'
ORDER BY party_id;

-- [aivb-n2-nhom-thu-nhap] wrong: case_thieu_muc_cao_nhat
SELECT party_id, income_band,
       CASE
         WHEN income_band IN ('UNDER_10M', '10M_20M') THEN 'Thấp'
         WHEN income_band = '20M_40M' THEN 'Trung bình'
         WHEN income_band = '40M_80M' THEN 'Cao'
       END AS nhom_thu_nhap
FROM core_person
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '1991-01-01'
ORDER BY party_id;

-- [aivb-n2-nhom-thu-nhap] wrong: thieu_can_tren_nam_sinh
SELECT party_id, income_band,
       CASE
         WHEN income_band IN ('UNDER_10M', '10M_20M') THEN 'Thấp'
         WHEN income_band = '20M_40M' THEN 'Trung bình'
         WHEN income_band IN ('40M_80M', 'OVER_80M') THEN 'Cao'
       END AS nhom_thu_nhap
FROM core_person
WHERE date_of_birth >= '1990-01-01'
ORDER BY party_id;

-- [aivb-n3-so-tien-con-thieu-ky-qua-han] solution
SELECT loan_id, installment_no, due_date,
       principal_due + interest_due - principal_paid - interest_paid AS so_tien_con_thieu
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY due_date, loan_id, installment_no;

-- [aivb-n3-so-tien-con-thieu-ky-qua-han] wrong: chi_tinh_goc
SELECT loan_id, installment_no, due_date,
       principal_due - principal_paid AS so_tien_con_thieu
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY due_date, loan_id, installment_no;

-- [aivb-n3-so-tien-con-thieu-ky-qua-han] wrong: lan_ky_chua_den_han_va_da_huy
SELECT loan_id, installment_no, due_date,
       principal_due + interest_due - principal_paid - interest_paid AS so_tien_con_thieu
FROM core_loan_schedule
WHERE schedule_status <> 'PAID'
ORDER BY due_date, loan_id, installment_no;

-- [aivb-n4-ty-le-du-no-con-lai] solution
SELECT loan_id, principal, outstanding,
       ROUND(outstanding / NULLIF(principal, 0), 4) AS ty_le_con_lai,
       CASE
         WHEN outstanding / NULLIF(principal, 0) >= 0.8 THEN 'Mới giải ngân'
         WHEN outstanding / NULLIF(principal, 0) >= 0.2 THEN 'Giữa kỳ'
         ELSE 'Sắp tất toán'
       END AS giai_doan
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
ORDER BY loan_id;

-- [aivb-n4-ty-le-du-no-con-lai] wrong: sai_thu_tu_when
SELECT loan_id, principal, outstanding,
       ROUND(outstanding / NULLIF(principal, 0), 4) AS ty_le_con_lai,
       CASE
         WHEN outstanding / NULLIF(principal, 0) >= 0.2 THEN 'Giữa kỳ'
         WHEN outstanding / NULLIF(principal, 0) >= 0.8 THEN 'Mới giải ngân'
         ELSE 'Sắp tất toán'
       END AS giai_doan
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
ORDER BY loan_id;

-- [aivb-n4-ty-le-du-no-con-lai] wrong: lan_khoan_da_tat_toan
SELECT loan_id, principal, outstanding,
       ROUND(outstanding / NULLIF(principal, 0), 4) AS ty_le_con_lai,
       CASE
         WHEN outstanding / NULLIF(principal, 0) >= 0.8 THEN 'Mới giải ngân'
         WHEN outstanding / NULLIF(principal, 0) >= 0.2 THEN 'Giữa kỳ'
         ELSE 'Sắp tất toán'
       END AS giai_doan
FROM core_loan_contract
ORDER BY loan_id;

-- [aivb-n5-so-ngay-tai-khoan-mo] solution
SELECT account_id, open_date, close_date,
       DATEDIFF(COALESCE(close_date, '2026-12-31'), open_date) AS so_ngay
FROM core_account
WHERE open_date >= '2024-01-01' AND open_date < '2025-01-01'
ORDER BY account_id;

-- [aivb-n5-so-ngay-tai-khoan-mo] wrong: quen_coalesce
SELECT account_id, open_date, close_date,
       DATEDIFF(close_date, open_date) AS so_ngay
FROM core_account
WHERE open_date >= '2024-01-01' AND open_date < '2025-01-01'
ORDER BY account_id;

-- [aivb-n5-so-ngay-tai-khoan-mo] wrong: bo_qua_ngay_dong
SELECT account_id, open_date, close_date,
       DATEDIFF('2026-12-31', open_date) AS so_ngay
FROM core_account
WHERE open_date >= '2024-01-01' AND open_date < '2025-01-01'
ORDER BY account_id;

-- [aivb-n6-nhan-kenh-so] solution
SELECT payment_order_id, channel_code, amount,
       CASE
         WHEN channel_code IN ('MOBILE', 'WEB', 'QR', 'API') THEN 'Kênh số'
         WHEN channel_code IN ('BRANCH', 'ATM', 'POS') THEN 'Kênh vật lý'
       END AS nhom_kenh
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date = '2026-12-31'
  AND amount >= 100000000
ORDER BY amount DESC, payment_order_id;

-- [aivb-n6-nhan-kenh-so] wrong: kenh_so_thieu_qr_api
SELECT payment_order_id, channel_code, amount,
       CASE
         WHEN channel_code IN ('MOBILE', 'WEB') THEN 'Kênh số'
         ELSE 'Kênh vật lý'
       END AS nhom_kenh
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date = '2026-12-31'
  AND amount >= 100000000
ORDER BY amount DESC, payment_order_id;

-- [aivb-n6-nhan-kenh-so] wrong: nguong_thieu_mot_so_0
SELECT payment_order_id, channel_code, amount,
       CASE
         WHEN channel_code IN ('MOBILE', 'WEB', 'QR', 'API') THEN 'Kênh số'
         ELSE 'Kênh vật lý'
       END AS nhom_kenh
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date = '2026-12-31'
  AND amount >= 10000000
ORDER BY amount DESC, payment_order_id;

-- [aivb-n7-quyet-dinh-thieu-so-tien-duyet] starter
SELECT credit_decision_id, application_id, decision_date, decision_status
FROM core_credit_decision
WHERE approved_amount = NULL
  AND decision_date >= '2026-12-01' AND decision_date < '2027-01-01'
ORDER BY credit_decision_id;

-- [aivb-n7-quyet-dinh-thieu-so-tien-duyet] solution
SELECT credit_decision_id, application_id, decision_date, decision_status
FROM core_credit_decision
WHERE approved_amount IS NULL
  AND decision_date >= '2026-12-01' AND decision_date < '2027-01-01'
ORDER BY credit_decision_id;

-- [aivb-n7-quyet-dinh-thieu-so-tien-duyet] wrong: so_sanh_bang_0
SELECT credit_decision_id, application_id, decision_date, decision_status
FROM core_credit_decision
WHERE approved_amount = 0
  AND decision_date >= '2026-12-01' AND decision_date < '2027-01-01'
ORDER BY credit_decision_id;

-- [aivb-n7-quyet-dinh-thieu-so-tien-duyet] wrong: lay_nguoc_is_not_null
SELECT credit_decision_id, application_id, decision_date, decision_status
FROM core_credit_decision
WHERE approved_amount IS NOT NULL
  AND decision_date >= '2026-12-01' AND decision_date < '2027-01-01'
ORDER BY credit_decision_id;

-- [aivb-n8-nhom-tuoi] starter
SELECT party_id,
       TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') AS tuoi,
       CASE
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') < 25 THEN 'Dưới 25'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 25 THEN '25-39'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 40 THEN '40-59'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 60 THEN 'Từ 60'
       END AS nhom_tuoi
FROM core_person
WHERE residence_province = 'DA_NANG'
ORDER BY party_id;

-- [aivb-n8-nhom-tuoi] solution
SELECT party_id,
       TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') AS tuoi,
       CASE
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 60 THEN 'Từ 60'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 40 THEN '40-59'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 25 THEN '25-39'
         ELSE 'Dưới 25'
       END AS nhom_tuoi
FROM core_person
WHERE residence_province = 'DA_NANG'
ORDER BY party_id;

-- [aivb-n8-nhom-tuoi] wrong: bien_25_vao_nhom_duoi
SELECT party_id,
       TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') AS tuoi,
       CASE
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') <= 25 THEN 'Dưới 25'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 60 THEN 'Từ 60'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 40 THEN '40-59'
         ELSE '25-39'
       END AS nhom_tuoi
FROM core_person
WHERE residence_province = 'DA_NANG'
ORDER BY party_id;

-- [aivb-n8-nhom-tuoi] wrong: bien_60_vao_nhom_duoi
SELECT party_id,
       TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') AS tuoi,
       CASE
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') > 60 THEN 'Từ 60'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 40 THEN '40-59'
         WHEN TIMESTAMPDIFF(YEAR, date_of_birth, '2026-12-31') >= 25 THEN '25-39'
         ELSE 'Dưới 25'
       END AS nhom_tuoi
FROM core_person
WHERE residence_province = 'DA_NANG'
ORDER BY party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] starter
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from <= '2026-06-30'
  AND valid_to > '2026-06-30'
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] solution
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from <= '2026-06-30'
  AND (valid_to IS NULL OR valid_to > '2026-06-30')
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] wrong: chi_lay_valid_to_trong
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from <= '2026-06-30'
  AND valid_to IS NULL
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] wrong: bo_dieu_kien_valid_from
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND (valid_to IS NULL OR valid_to > '2026-06-30')
ORDER BY account_party_id;


-- [aivb-c1-ho-so-doanh-nghiep-bi-tu-choi.b1] solution
SELECT application_id, product_id, score_band,
       ROUND(dti * 100, 2) AS dti_pct,
       requested_amount
FROM core_loan_application
WHERE customer_type = 'BUSINESS'
  AND application_status = 'REJECTED'
  AND application_date >= '2026-01-01' AND application_date < '2027-01-01'
ORDER BY application_id;

-- [aivb-c1-ho-so-doanh-nghiep-bi-tu-choi.b1] wrong: quen_loc_doanh_nghiep
SELECT application_id, product_id, score_band,
       ROUND(dti * 100, 2) AS dti_pct,
       requested_amount
FROM core_loan_application
WHERE application_status = 'REJECTED'
  AND application_date >= '2026-01-01' AND application_date < '2027-01-01'
ORDER BY application_id;

-- [aivb-c1-ho-so-doanh-nghiep-bi-tu-choi.b1] wrong: dti_de_dang_ty_le
SELECT application_id, product_id, score_band,
       ROUND(dti, 2) AS dti_pct,
       requested_amount
FROM core_loan_application
WHERE customer_type = 'BUSINESS'
  AND application_status = 'REJECTED'
  AND application_date >= '2026-01-01' AND application_date < '2027-01-01'
ORDER BY application_id;

-- [aivb-c2-tien-gui-sap-dao-han.b1] solution
SELECT deposit_id, term_months, principal,
       ROUND(interest_rate * 100, 2) AS lai_suat_pct,
       maturity_date
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND maturity_date >= '2027-01-01' AND maturity_date < '2027-02-01'
ORDER BY lai_suat_pct DESC, deposit_id;

-- [aivb-c2-tien-gui-sap-dao-han.b1] wrong: quen_loc_con_hieu_luc
SELECT deposit_id, term_months, principal,
       ROUND(interest_rate * 100, 2) AS lai_suat_pct,
       maturity_date
FROM core_deposit_contract
WHERE maturity_date >= '2027-01-01' AND maturity_date < '2027-02-01'
ORDER BY lai_suat_pct DESC, deposit_id;

-- [aivb-c2-tien-gui-sap-dao-han.b1] wrong: lai_suat_de_dang_ty_le
SELECT deposit_id, term_months, principal,
       ROUND(interest_rate, 2) AS lai_suat_pct,
       maturity_date
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND maturity_date >= '2027-01-01' AND maturity_date < '2027-02-01'
ORDER BY lai_suat_pct DESC, deposit_id;
