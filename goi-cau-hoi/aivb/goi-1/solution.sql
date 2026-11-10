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

-- [aivb-r2-ho-so-vay-co-tai-san-bao-dam] solution
SELECT application_id, product_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id IN ('MORT', 'AUTO', 'PLEDGE')
  AND application_status = 'APPROVED'
  AND application_date >= '2025-01-01' AND application_date < '2026-01-01'
  AND requested_amount >= 1000000000
ORDER BY product_id, requested_amount DESC, application_id;

-- [aivb-r2-ho-so-vay-co-tai-san-bao-dam] wrong: lay_ca_vay_von_luu_dong
SELECT application_id, product_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id <> 'CONS'
  AND application_status = 'APPROVED'
  AND application_date >= '2025-01-01' AND application_date < '2026-01-01'
  AND requested_amount >= 1000000000
ORDER BY product_id, requested_amount DESC, application_id;

-- [aivb-r2-ho-so-vay-co-tai-san-bao-dam] wrong: thieu_can_tren_nam_nop
SELECT application_id, product_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id IN ('MORT', 'AUTO', 'PLEDGE')
  AND application_status = 'APPROVED'
  AND application_date >= '2025-01-01'
  AND requested_amount >= 1000000000
ORDER BY product_id, requested_amount DESC, application_id;

-- [aivb-r2-ho-so-vay-co-tai-san-bao-dam] wrong: quen_loc_duyet
SELECT application_id, product_id, application_date, requested_amount
FROM core_loan_application
WHERE product_id IN ('MORT', 'AUTO', 'PLEDGE')
  AND application_date >= '2025-01-01' AND application_date < '2026-01-01'
  AND requested_amount >= 1000000000
ORDER BY product_id, requested_amount DESC, application_id;

-- [aivb-r3-kyc-khong-dat-con-quan-he-ha-noi] solution
SELECT customer_id, home_branch_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id IN ('CN01', 'CN02', 'CN03')
  AND kyc_status = 'FAIL'
  AND customer_status <> 'CLOSED'
ORDER BY home_branch_id, customer_id;

-- [aivb-r3-kyc-khong-dat-con-quan-he-ha-noi] wrong: lay_ca_mien_bac
SELECT customer_id, home_branch_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id IN ('CN01', 'CN02', 'CN03', 'CN04')
  AND kyc_status = 'FAIL'
  AND customer_status <> 'CLOSED'
ORDER BY home_branch_id, customer_id;

-- [aivb-r3-kyc-khong-dat-con-quan-he-ha-noi] wrong: chi_lay_khach_dang_hoat_dong
SELECT customer_id, home_branch_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id IN ('CN01', 'CN02', 'CN03')
  AND kyc_status = 'FAIL'
  AND customer_status = 'ACTIVE'
ORDER BY home_branch_id, customer_id;

-- [aivb-r3-kyc-khong-dat-con-quan-he-ha-noi] wrong: quen_loai_khach_da_dong
SELECT customer_id, home_branch_id, segment_code, customer_status
FROM core_customer
WHERE home_branch_id IN ('CN01', 'CN02', 'CN03')
  AND kyc_status = 'FAIL'
ORDER BY home_branch_id, customer_id;

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

-- [aivb-r6-khoan-vay-xet-giam-lai-suat] solution
SELECT loan_id, loan_status, interest_rate, outstanding
FROM core_loan_contract
WHERE loan_status IN ('ACTIVE', 'RESTRUCTURED')
  AND interest_rate >= 0.09
ORDER BY interest_rate DESC, outstanding DESC, loan_id;

-- [aivb-r6-khoan-vay-xet-giam-lai-suat] wrong: chi_lay_dang_tra_no_binh_thuong
SELECT loan_id, loan_status, interest_rate, outstanding
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
  AND interest_rate >= 0.09
ORDER BY interest_rate DESC, outstanding DESC, loan_id;

-- [aivb-r6-khoan-vay-xet-giam-lai-suat] wrong: lay_ca_khoan_dang_qua_han
SELECT loan_id, loan_status, interest_rate, outstanding
FROM core_loan_contract
WHERE outstanding > 0
  AND interest_rate >= 0.09
ORDER BY interest_rate DESC, outstanding DESC, loan_id;

-- [aivb-r6-khoan-vay-xet-giam-lai-suat] wrong: chi_loai_khoan_dang_qua_han
SELECT loan_id, loan_status, interest_rate, outstanding
FROM core_loan_contract
WHERE loan_status <> 'DELINQUENT'
  AND interest_rate >= 0.09
ORDER BY interest_rate DESC, outstanding DESC, loan_id;

-- [aivb-r6-khoan-vay-xet-giam-lai-suat] wrong: bo_sot_dung_9_phan_tram
SELECT loan_id, loan_status, interest_rate, outstanding
FROM core_loan_contract
WHERE loan_status IN ('ACTIVE', 'RESTRUCTURED')
  AND interest_rate > 0.09
ORDER BY interest_rate DESC, outstanding DESC, loan_id;

-- [aivb-r6-khoan-vay-xet-giam-lai-suat] wrong: nham_thang_ty_le
SELECT loan_id, loan_status, interest_rate, outstanding
FROM core_loan_contract
WHERE loan_status IN ('ACTIVE', 'RESTRUCTURED')
  AND interest_rate >= 9
ORDER BY interest_rate DESC, outstanding DESC, loan_id;

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

-- [aivb-r8-tien-gui-lon-ky-han-6-12-thang] starter
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status <> 'CLOSED'
  AND term_months > 6 AND term_months < 12
  AND principal > 500000000
  AND interest_rate >= 0.045
ORDER BY principal DESC, deposit_id;

-- [aivb-r8-tien-gui-lon-ky-han-6-12-thang] solution
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND term_months BETWEEN 6 AND 12
  AND principal >= 500000000
  AND interest_rate >= 0.045
ORDER BY principal DESC, deposit_id;

-- [aivb-r8-tien-gui-lon-ky-han-6-12-thang] wrong: chi_sua_bien_ky_han
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status <> 'CLOSED'
  AND term_months BETWEEN 6 AND 12
  AND principal > 500000000
  AND interest_rate >= 0.045
ORDER BY principal DESC, deposit_id;

-- [aivb-r8-tien-gui-lon-ky-han-6-12-thang] wrong: con_lan_hop_dong_da_tai_tuc
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status NOT IN ('CLOSED', 'EARLY_TERMINATED')
  AND term_months BETWEEN 6 AND 12
  AND principal >= 500000000
  AND interest_rate >= 0.045
ORDER BY principal DESC, deposit_id;

-- [aivb-r8-tien-gui-lon-ky-han-6-12-thang] wrong: bo_sot_khoan_dung_500_trieu
SELECT deposit_id, term_months, interest_rate, principal
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND term_months BETWEEN 6 AND 12
  AND principal > 500000000
  AND interest_rate >= 0.045
ORDER BY principal DESC, deposit_id;

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

-- [aivb-n2-kha-nang-tich-luy-khach-1990] solution
SELECT party_id, income_band, dependents_count,
       CASE
         WHEN income_band IN ('20M_40M', '40M_80M', 'OVER_80M') AND dependents_count <= 1 THEN 'Cao'
         WHEN income_band IN ('UNDER_10M', '10M_20M') AND dependents_count >= 2 THEN 'Thấp'
         ELSE 'Trung bình'
       END AS kha_nang_tich_luy
FROM core_person
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '1991-01-01'
ORDER BY party_id;

-- [aivb-n2-kha-nang-tich-luy-khach-1990] wrong: so_sanh_chuoi_ma_thu_nhap
SELECT party_id, income_band, dependents_count,
       CASE
         WHEN income_band >= '20M_40M' AND dependents_count <= 1 THEN 'Cao'
         WHEN income_band < '20M_40M' AND dependents_count >= 2 THEN 'Thấp'
         ELSE 'Trung bình'
       END AS kha_nang_tich_luy
FROM core_person
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '1991-01-01'
ORDER BY party_id;

-- [aivb-n2-kha-nang-tich-luy-khach-1990] wrong: bien_mot_nguoi_phu_thuoc
SELECT party_id, income_band, dependents_count,
       CASE
         WHEN income_band IN ('20M_40M', '40M_80M', 'OVER_80M') AND dependents_count < 1 THEN 'Cao'
         WHEN income_band IN ('UNDER_10M', '10M_20M') AND dependents_count >= 2 THEN 'Thấp'
         ELSE 'Trung bình'
       END AS kha_nang_tich_luy
FROM core_person
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '1991-01-01'
ORDER BY party_id;

-- [aivb-n2-kha-nang-tich-luy-khach-1990] wrong: thieu_nhanh_con_lai
SELECT party_id, income_band, dependents_count,
       CASE
         WHEN income_band IN ('20M_40M', '40M_80M', 'OVER_80M') AND dependents_count <= 1 THEN 'Cao'
         WHEN income_band IN ('UNDER_10M', '10M_20M') AND dependents_count >= 2 THEN 'Thấp'
       END AS kha_nang_tich_luy
FROM core_person
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '1991-01-01'
ORDER BY party_id;

-- [aivb-n3-ky-qua-han-can-goi-nhac-truoc] solution
SELECT loan_id, installment_no,
       principal_due + interest_due - principal_paid - interest_paid AS so_tien_con_thieu,
       DATEDIFF('2026-12-31', due_date) AS so_ngay_qua_han,
       CASE
         WHEN DATEDIFF('2026-12-31', due_date) < 10 THEN 'Dưới 10 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 90 THEN '10-90 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 180 THEN '91-180 ngày'
         ELSE 'Trên 180 ngày'
       END AS muc_qua_han
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY so_ngay_qua_han DESC, loan_id, installment_no;

-- [aivb-n3-ky-qua-han-can-goi-nhac-truoc] wrong: quen_tru_phan_da_tra
SELECT loan_id, installment_no,
       principal_due + interest_due AS so_tien_con_thieu,
       DATEDIFF('2026-12-31', due_date) AS so_ngay_qua_han,
       CASE
         WHEN DATEDIFF('2026-12-31', due_date) < 10 THEN 'Dưới 10 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 90 THEN '10-90 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 180 THEN '91-180 ngày'
         ELSE 'Trên 180 ngày'
       END AS muc_qua_han
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY so_ngay_qua_han DESC, loan_id, installment_no;

-- [aivb-n3-ky-qua-han-can-goi-nhac-truoc] wrong: chi_tinh_goc
SELECT loan_id, installment_no,
       principal_due - principal_paid AS so_tien_con_thieu,
       DATEDIFF('2026-12-31', due_date) AS so_ngay_qua_han,
       CASE
         WHEN DATEDIFF('2026-12-31', due_date) < 10 THEN 'Dưới 10 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 90 THEN '10-90 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 180 THEN '91-180 ngày'
         ELSE 'Trên 180 ngày'
       END AS muc_qua_han
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY so_ngay_qua_han DESC, loan_id, installment_no;

-- [aivb-n3-ky-qua-han-can-goi-nhac-truoc] wrong: bien_10_ngay_vao_muc_duoi
SELECT loan_id, installment_no,
       principal_due + interest_due - principal_paid - interest_paid AS so_tien_con_thieu,
       DATEDIFF('2026-12-31', due_date) AS so_ngay_qua_han,
       CASE
         WHEN DATEDIFF('2026-12-31', due_date) <= 10 THEN 'Dưới 10 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 90 THEN '10-90 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 180 THEN '91-180 ngày'
         ELSE 'Trên 180 ngày'
       END AS muc_qua_han
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY so_ngay_qua_han DESC, loan_id, installment_no;

-- [aivb-n3-ky-qua-han-can-goi-nhac-truoc] wrong: bien_90_ngay_vao_muc_tren
SELECT loan_id, installment_no,
       principal_due + interest_due - principal_paid - interest_paid AS so_tien_con_thieu,
       DATEDIFF('2026-12-31', due_date) AS so_ngay_qua_han,
       CASE
         WHEN DATEDIFF('2026-12-31', due_date) < 10 THEN 'Dưới 10 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) < 90 THEN '10-90 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 180 THEN '91-180 ngày'
         ELSE 'Trên 180 ngày'
       END AS muc_qua_han
FROM core_loan_schedule
WHERE schedule_status = 'OVERDUE'
ORDER BY so_ngay_qua_han DESC, loan_id, installment_no;

-- [aivb-n3-ky-qua-han-can-goi-nhac-truoc] wrong: lan_ky_da_huy
SELECT loan_id, installment_no,
       principal_due + interest_due - principal_paid - interest_paid AS so_tien_con_thieu,
       DATEDIFF('2026-12-31', due_date) AS so_ngay_qua_han,
       CASE
         WHEN DATEDIFF('2026-12-31', due_date) < 10 THEN 'Dưới 10 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 90 THEN '10-90 ngày'
         WHEN DATEDIFF('2026-12-31', due_date) <= 180 THEN '91-180 ngày'
         ELSE 'Trên 180 ngày'
       END AS muc_qua_han
FROM core_loan_schedule
WHERE schedule_status <> 'PAID'
  AND due_date <= '2026-12-31'
ORDER BY so_ngay_qua_han DESC, loan_id, installment_no;

-- [aivb-n4-ty-le-thu-hoi-goc] solution
SELECT loan_id, loan_status, principal, outstanding,
       ROUND((principal - outstanding) * 100 / NULLIF(principal, 0), 2) AS ty_le_thu_hoi_goc,
       CASE
         WHEN principal = outstanding THEN 'Chưa thu hồi'
         WHEN (principal - outstanding) * 100 / NULLIF(principal, 0) < 50 THEN 'Dưới 50%'
         ELSE 'Từ 50% trở lên'
       END AS nhom_thu_hoi
FROM core_loan_contract
WHERE outstanding > 0
ORDER BY loan_id;

-- [aivb-n4-ty-le-thu-hoi-goc] wrong: chi_xet_khoan_tra_no_binh_thuong
SELECT loan_id, loan_status, principal, outstanding,
       ROUND((principal - outstanding) * 100 / NULLIF(principal, 0), 2) AS ty_le_thu_hoi_goc,
       CASE
         WHEN principal = outstanding THEN 'Chưa thu hồi'
         WHEN (principal - outstanding) * 100 / NULLIF(principal, 0) < 50 THEN 'Dưới 50%'
         ELSE 'Từ 50% trở lên'
       END AS nhom_thu_hoi
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
ORDER BY loan_id;

-- [aivb-n4-ty-le-thu-hoi-goc] wrong: nhanh_duoi_50_dat_truoc
SELECT loan_id, loan_status, principal, outstanding,
       ROUND((principal - outstanding) * 100 / NULLIF(principal, 0), 2) AS ty_le_thu_hoi_goc,
       CASE
         WHEN (principal - outstanding) * 100 / NULLIF(principal, 0) < 50 THEN 'Dưới 50%'
         WHEN principal = outstanding THEN 'Chưa thu hồi'
         ELSE 'Từ 50% trở lên'
       END AS nhom_thu_hoi
FROM core_loan_contract
WHERE outstanding > 0
ORDER BY loan_id;

-- [aivb-n4-ty-le-thu-hoi-goc] wrong: tinh_phan_du_no_con_lai
SELECT loan_id, loan_status, principal, outstanding,
       ROUND(outstanding * 100 / NULLIF(principal, 0), 2) AS ty_le_thu_hoi_goc,
       CASE
         WHEN principal = outstanding THEN 'Chưa thu hồi'
         WHEN outstanding * 100 / NULLIF(principal, 0) < 50 THEN 'Dưới 50%'
         ELSE 'Từ 50% trở lên'
       END AS nhom_thu_hoi
FROM core_loan_contract
WHERE outstanding > 0
ORDER BY loan_id;

-- [aivb-n4-ty-le-thu-hoi-goc] wrong: xep_nhom_tren_ty_le_da_lam_tron
SELECT loan_id, loan_status, principal, outstanding,
       ROUND((principal - outstanding) * 100 / NULLIF(principal, 0), 2) AS ty_le_thu_hoi_goc,
       CASE
         WHEN principal = outstanding THEN 'Chưa thu hồi'
         WHEN ROUND((principal - outstanding) * 100 / NULLIF(principal, 0), 2) < 50 THEN 'Dưới 50%'
         ELSE 'Từ 50% trở lên'
       END AS nhom_thu_hoi
FROM core_loan_contract
WHERE outstanding > 0
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
  AND valid_from < '2026-06-30'
  AND valid_to >= '2026-06-30'
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] solution
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from <= '2026-06-30'
  AND (valid_to IS NULL OR valid_to > '2026-06-30')
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] wrong: chi_them_valid_to_trong
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from < '2026-06-30'
  AND (valid_to IS NULL OR valid_to >= '2026-06-30')
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] wrong: thieu_ngoac_quanh_or
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from <= '2026-06-30'
  AND valid_to IS NULL OR valid_to > '2026-06-30'
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

-- [aivb-n9-dong-so-huu-con-hieu-luc] wrong: tinh_ca_ngay_ket_thuc
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from <= '2026-06-30'
  AND (valid_to IS NULL OR valid_to >= '2026-06-30')
ORDER BY account_party_id;

-- [aivb-n9-dong-so-huu-con-hieu-luc] wrong: bo_ngay_bat_dau_dung_moc
SELECT account_party_id, account_id, party_id, valid_from, valid_to
FROM core_account_party
WHERE role_code = 'JOINT_OWNER'
  AND valid_from < '2026-06-30'
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

-- [aivb-c2-tien-gui-sap-dao-han.b1] wrong: tinh_ca_ngay_01_02
SELECT deposit_id, term_months, principal,
       ROUND(interest_rate * 100, 2) AS lai_suat_pct,
       maturity_date
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND maturity_date BETWEEN '2027-01-01' AND '2027-02-01'
ORDER BY lai_suat_pct DESC, deposit_id;

-- [aivb-c2-tien-gui-sap-dao-han.b1] wrong: lai_suat_de_dang_ty_le
SELECT deposit_id, term_months, principal,
       ROUND(interest_rate, 2) AS lai_suat_pct,
       maturity_date
FROM core_deposit_contract
WHERE deposit_status = 'ACTIVE'
  AND maturity_date >= '2027-01-01' AND maturity_date < '2027-02-01'
ORDER BY lai_suat_pct DESC, deposit_id;
