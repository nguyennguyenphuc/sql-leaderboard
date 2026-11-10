-- solution.sql: gói 3 bộ AIV Bank (aivb). Module 5 Joins, Module 6 Subqueries, case c5, c6.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên aivb (public) và aivb_hidden_1 (hidden-1).

-- ================================================================ MODULE 5 · JOINS

-- [aivb-j1-khach-hang-theo-vung] solution
SELECT b.region,
       COUNT(DISTINCT b.ref_branch_id) AS so_chi_nhanh,
       COUNT(*) AS so_khach
FROM core_customer c
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
WHERE c.customer_status = 'ACTIVE'
GROUP BY b.region
ORDER BY so_khach DESC, b.region;

-- [aivb-j1-khach-hang-theo-vung] wrong: quen_loc_trang_thai
SELECT b.region,
       COUNT(DISTINCT b.ref_branch_id) AS so_chi_nhanh,
       COUNT(*) AS so_khach
FROM core_customer c
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
GROUP BY b.region
ORDER BY so_khach DESC, b.region;

-- [aivb-j1-khach-hang-theo-vung] wrong: noi_theo_branch_code
SELECT b.region,
       COUNT(DISTINCT b.ref_branch_id) AS so_chi_nhanh,
       COUNT(*) AS so_khach
FROM core_customer c
JOIN ref_branch b ON b.branch_code = c.home_branch_id
WHERE c.customer_status = 'ACTIVE'
GROUP BY b.region
ORDER BY so_khach DESC, b.region;

-- [aivb-j2-ho-so-duyet-va-so-tien] solution
SELECT a.application_id, a.product_id, a.application_date, d.decision_date,
       DATEDIFF(d.decision_date, a.application_date) AS so_ngay_xu_ly,
       d.approved_amount
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND a.customer_type = 'PERSONAL'
  AND a.application_date >= '2025-12-01' AND a.application_date < '2026-01-01'
ORDER BY a.application_id;

-- [aivb-j2-ho-so-duyet-va-so-tien] wrong: loc_theo_ngay_quyet_dinh
SELECT a.application_id, a.product_id, a.application_date, d.decision_date,
       DATEDIFF(d.decision_date, a.application_date) AS so_ngay_xu_ly,
       d.approved_amount
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND a.customer_type = 'PERSONAL'
  AND d.decision_date >= '2025-12-01' AND d.decision_date < '2026-01-01'
ORDER BY a.application_id;

-- [aivb-j2-ho-so-duyet-va-so-tien] wrong: thieu_can_tren
SELECT a.application_id, a.product_id, a.application_date, d.decision_date,
       DATEDIFF(d.decision_date, a.application_date) AS so_ngay_xu_ly,
       d.approved_amount
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND a.customer_type = 'PERSONAL'
  AND a.application_date >= '2025-12-01'
ORDER BY a.application_id;

-- [aivb-j3-so-du-casa-theo-phan-khuc] solution
SELECT c.segment_code, s.segment_name,
       COUNT(*) AS so_tai_khoan,
       ROUND(SUM(b.current_balance) / 1000000, 0) AS tong_so_du
FROM core_account_party ap
JOIN core_customer c ON c.party_id = ap.party_id
JOIN ref_segment s ON s.segment_code = c.segment_code
JOIN core_account_balance b ON b.account_id = ap.account_id
WHERE ap.role_code = 'PRIMARY_OWNER'
GROUP BY c.segment_code, s.segment_name
ORDER BY tong_so_du DESC, c.segment_code;

-- [aivb-j3-so-du-casa-theo-phan-khuc] wrong: khong_loc_chu_tai_khoan
SELECT c.segment_code, s.segment_name,
       COUNT(*) AS so_tai_khoan,
       ROUND(SUM(b.current_balance) / 1000000, 0) AS tong_so_du
FROM core_account_party ap
JOIN core_customer c ON c.party_id = ap.party_id
JOIN ref_segment s ON s.segment_code = c.segment_code
JOIN core_account_balance b ON b.account_id = ap.account_id
GROUP BY c.segment_code, s.segment_name
ORDER BY tong_so_du DESC, c.segment_code;

-- [aivb-j4-ty-le-khach-co-ho-so-vay] solution
SELECT c.segment_code,
       COUNT(DISTINCT c.customer_id) AS so_khach,
       COUNT(DISTINCT a.party_id) AS so_khach_co_ho_so,
       ROUND(100 * COUNT(DISTINCT a.party_id) / COUNT(DISTINCT c.customer_id), 2) AS ty_le_pct
FROM core_customer c
LEFT JOIN core_loan_application a ON a.party_id = c.party_id
JOIN ref_segment s ON s.segment_code = c.segment_code
WHERE s.party_type = 'PERSON'
GROUP BY c.segment_code
ORDER BY ty_le_pct DESC, c.segment_code;

-- [aivb-j4-ty-le-khach-co-ho-so-vay] wrong: inner_join_mat_khach
SELECT c.segment_code,
       COUNT(DISTINCT c.customer_id) AS so_khach,
       COUNT(DISTINCT a.party_id) AS so_khach_co_ho_so,
       ROUND(100 * COUNT(DISTINCT a.party_id) / COUNT(DISTINCT c.customer_id), 2) AS ty_le_pct
FROM core_customer c
JOIN core_loan_application a ON a.party_id = c.party_id
JOIN ref_segment s ON s.segment_code = c.segment_code
WHERE s.party_type = 'PERSON'
GROUP BY c.segment_code
ORDER BY ty_le_pct DESC, c.segment_code;

-- [aivb-j4-ty-le-khach-co-ho-so-vay] wrong: dem_ho_so_thay_khach
SELECT c.segment_code,
       COUNT(DISTINCT c.customer_id) AS so_khach,
       COUNT(a.application_id) AS so_khach_co_ho_so,
       ROUND(100 * COUNT(a.application_id) / COUNT(DISTINCT c.customer_id), 2) AS ty_le_pct
FROM core_customer c
LEFT JOIN core_loan_application a ON a.party_id = c.party_id
JOIN ref_segment s ON s.segment_code = c.segment_code
WHERE s.party_type = 'PERSON'
GROUP BY c.segment_code
ORDER BY ty_le_pct DESC, c.segment_code;

-- [aivb-j5-doi-soat-giai-ngan] solution
SELECT pv.product_id,
       COUNT(*) AS so_khoan_vay,
       SUM(CASE WHEN d.tong_giai_ngan <> l.principal THEN 1 ELSE 0 END) AS so_khoan_lech,
       ROUND(SUM(l.principal) / 1000000, 0) AS tong_goc,
       ROUND(SUM(d.tong_giai_ngan) / 1000000, 0) AS tong_giai_ngan
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version pv ON pv.product_version_id = c.product_version_id
JOIN (SELECT loan_id, SUM(amount) AS tong_giai_ngan
      FROM core_loan_disbursement
      GROUP BY loan_id) d ON d.loan_id = l.loan_id
GROUP BY pv.product_id
ORDER BY pv.product_id;

-- [aivb-j5-doi-soat-giai-ngan] wrong: cong_goc_sau_khi_noi
SELECT pv.product_id,
       COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       COUNT(DISTINCT CASE WHEN l.principal <> (SELECT SUM(x.amount) FROM core_loan_disbursement x WHERE x.loan_id = l.loan_id) THEN l.loan_id END) AS so_khoan_lech,
       ROUND(SUM(l.principal) / 1000000, 0) AS tong_goc,
       ROUND(SUM(d.amount) / 1000000, 0) AS tong_giai_ngan
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version pv ON pv.product_version_id = c.product_version_id
JOIN core_loan_disbursement d ON d.loan_id = l.loan_id
GROUP BY pv.product_id
ORDER BY pv.product_id;

-- [aivb-j6-khoan-vay-co-van-de-theo-vung] solution
SELECT b.region,
       SUM(CASE WHEN l.loan_status = 'DELINQUENT' THEN 1 ELSE 0 END) AS so_qua_han,
       SUM(CASE WHEN l.loan_status = 'RESTRUCTURED' THEN 1 ELSE 0 END) AS so_co_cau_lai,
       SUM(CASE WHEN l.loan_status = 'WRITTEN_OFF' THEN 1 ELSE 0 END) AS so_xu_ly_rui_ro
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
GROUP BY b.region
ORDER BY b.region;

-- [aivb-j6-khoan-vay-co-van-de-theo-vung] wrong: count_case_else_0
SELECT b.region,
       COUNT(CASE WHEN l.loan_status = 'DELINQUENT' THEN 1 ELSE 0 END) AS so_qua_han,
       COUNT(CASE WHEN l.loan_status = 'RESTRUCTURED' THEN 1 ELSE 0 END) AS so_co_cau_lai,
       COUNT(CASE WHEN l.loan_status = 'WRITTEN_OFF' THEN 1 ELSE 0 END) AS so_xu_ly_rui_ro
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
GROUP BY b.region
ORDER BY b.region;

-- [aivb-j7-chu-so-huu-tai-khoan-da-dong] starter
SELECT a.account_id, a.close_date, ap.party_id
FROM core_account a
JOIN core_account_party ap ON ap.account_id = a.account_id
WHERE a.account_status = 'CLOSED'
  AND a.close_date >= '2026-01-01' AND a.close_date < '2027-01-01'
ORDER BY a.close_date, a.account_id;

-- [aivb-j7-chu-so-huu-tai-khoan-da-dong] solution
SELECT a.account_id, a.close_date, ap.party_id
FROM core_account a
JOIN core_account_party ap ON ap.account_id = a.account_id
WHERE a.account_status = 'CLOSED'
  AND a.close_date >= '2026-01-01' AND a.close_date < '2027-01-01'
  AND ap.role_code = 'PRIMARY_OWNER'
ORDER BY a.close_date, a.account_id;

-- [aivb-j7-chu-so-huu-tai-khoan-da-dong] wrong: gom_ca_dong_chu_tai_khoan
SELECT a.account_id, a.close_date, ap.party_id
FROM core_account a
JOIN core_account_party ap ON ap.account_id = a.account_id
WHERE a.account_status = 'CLOSED'
  AND a.close_date >= '2026-01-01' AND a.close_date < '2027-01-01'
  AND ap.role_code IN ('PRIMARY_OWNER', 'JOINT_OWNER')
ORDER BY a.close_date, a.account_id;

-- [aivb-j8-dong-tien-rong-theo-kenh] starter
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(p.amount) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE o.payment_status = 'COMPLETED'
  AND p.transaction_date >= '2026-12-01'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j8-dong-tien-rong-theo-kenh] solution
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE o.payment_status = 'COMPLETED'
  AND p.transaction_date >= '2026-12-01' AND p.transaction_date < '2027-01-01'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j8-dong-tien-rong-theo-kenh] wrong: chi_sua_dau_thieu_can_tren
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE o.payment_status = 'COMPLETED'
  AND p.transaction_date >= '2026-12-01'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j8-dong-tien-rong-theo-kenh] wrong: gom_lenh_bi_dao_tu_choi
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE p.transaction_date >= '2026-12-01' AND p.transaction_date < '2027-01-01'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j9-lai-du-thu-cho-vay-2026] starter
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
LEFT JOIN core_loan_contract l ON l.contract_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01';

-- [aivb-j9-lai-du-thu-cho-vay-2026] solution
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
JOIN core_loan_contract l ON l.contract_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01' AND ia.accrual_date < '2027-01-01';

-- [aivb-j9-lai-du-thu-cho-vay-2026] wrong: inner_join_thieu_can_tren
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
JOIN core_loan_contract l ON l.contract_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01';

-- [aivb-j9-lai-du-thu-cho-vay-2026] wrong: left_join_co_can_tren
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
LEFT JOIN core_loan_contract l ON l.contract_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01' AND ia.accrual_date < '2027-01-01';

-- ================================================================ MODULE 6 · SUBQUERIES

-- [aivb-q1-khoan-vay-tren-binh-quan] solution
SELECT loan_id, outstanding,
       ROUND(interest_rate * 100, 2) AS lai_suat_pct
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
  AND outstanding > (SELECT AVG(outstanding) FROM core_loan_contract WHERE loan_status = 'ACTIVE')
ORDER BY outstanding DESC, loan_id;

-- [aivb-q1-khoan-vay-tren-binh-quan] wrong: binh_quan_moi_khoan_vay
SELECT loan_id, outstanding,
       ROUND(interest_rate * 100, 2) AS lai_suat_pct
FROM core_loan_contract
WHERE loan_status = 'ACTIVE'
  AND outstanding > (SELECT AVG(outstanding) FROM core_loan_contract)
ORDER BY outstanding DESC, loan_id;

-- [aivb-q2-khach-co-khoan-vay-qua-han] solution
SELECT p.party_id, p.legal_name
FROM core_party p
WHERE p.party_id IN (SELECT a.party_id
                     FROM core_loan_application a
                     JOIN core_loan_contract l ON l.application_id = a.application_id
                     JOIN core_loan_schedule s ON s.loan_id = l.loan_id
                     WHERE s.schedule_status = 'OVERDUE')
ORDER BY p.party_id;

-- [aivb-q2-khach-co-khoan-vay-qua-han] wrong: join_lap_dong
SELECT p.party_id, p.legal_name
FROM core_party p
JOIN core_loan_application a ON a.party_id = p.party_id
JOIN core_loan_contract l ON l.application_id = a.application_id
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status = 'OVERDUE'
ORDER BY p.party_id;

-- [aivb-q2-khach-co-khoan-vay-qua-han] wrong: chi_xet_trang_thai_delinquent
SELECT p.party_id, p.legal_name
FROM core_party p
WHERE p.party_id IN (SELECT a.party_id
                     FROM core_loan_application a
                     JOIN core_loan_contract l ON l.application_id = a.application_id
                     WHERE l.loan_status = 'DELINQUENT')
ORDER BY p.party_id;

-- [aivb-q3-tien-gui-lai-cao-hon-ky-han] solution
SELECT d.deposit_id, d.term_months,
       ROUND(d.interest_rate * 100, 2) AS lai_suat_pct,
       ROUND((SELECT AVG(x.interest_rate) FROM core_deposit_contract x
              WHERE x.deposit_status = 'ACTIVE' AND x.term_months = d.term_months) * 100, 2) AS lai_suat_bq_pct
FROM core_deposit_contract d
WHERE d.deposit_status = 'ACTIVE'
  AND d.interest_rate >= 0.005 + (SELECT AVG(x.interest_rate) FROM core_deposit_contract x
                                  WHERE x.deposit_status = 'ACTIVE' AND x.term_months = d.term_months)
ORDER BY d.term_months, d.deposit_id;

-- [aivb-q3-tien-gui-lai-cao-hon-ky-han] wrong: khong_tuong_quan_ky_han
SELECT d.deposit_id, d.term_months,
       ROUND(d.interest_rate * 100, 2) AS lai_suat_pct,
       ROUND((SELECT AVG(x.interest_rate) FROM core_deposit_contract x
              WHERE x.deposit_status = 'ACTIVE') * 100, 2) AS lai_suat_bq_pct
FROM core_deposit_contract d
WHERE d.deposit_status = 'ACTIVE'
  AND d.interest_rate >= 0.005 + (SELECT AVG(x.interest_rate) FROM core_deposit_contract x
                                  WHERE x.deposit_status = 'ACTIVE')
ORDER BY d.term_months, d.deposit_id;

-- [aivb-q4-ho-so-de-nghi-lon-nhat] solution
SELECT a.product_id, a.application_id, a.application_date, a.requested_amount
FROM core_loan_application a
WHERE a.requested_amount = (SELECT MAX(b.requested_amount)
                            FROM core_loan_application b
                            WHERE b.product_id = a.product_id)
ORDER BY a.product_id, a.application_id;

-- [aivb-q4-ho-so-de-nghi-lon-nhat] wrong: max_toan_bang
SELECT a.product_id, a.application_id, a.application_date, a.requested_amount
FROM core_loan_application a
WHERE a.requested_amount = (SELECT MAX(b.requested_amount) FROM core_loan_application b)
ORDER BY a.product_id, a.application_id;

-- [aivb-q4-ho-so-de-nghi-lon-nhat] wrong: mot_ho_so_moi_san_pham
SELECT t.product_id,
       (SELECT MIN(a.application_id) FROM core_loan_application a
        WHERE a.product_id = t.product_id AND a.requested_amount = t.mx) AS application_id,
       (SELECT MIN(a.application_date) FROM core_loan_application a
        WHERE a.product_id = t.product_id AND a.requested_amount = t.mx) AS application_date,
       t.mx AS requested_amount
FROM (SELECT product_id, MAX(requested_amount) AS mx
      FROM core_loan_application
      GROUP BY product_id) t
ORDER BY t.product_id, application_id;

-- [aivb-q5-pheu-khach-vay] solution
SELECT 1 AS buoc, 'khach_hoat_dong' AS ten_buoc, COUNT(*) AS so_khach
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
UNION ALL
SELECT 2, 'co_ho_so_vay', COUNT(*)
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
  AND EXISTS (SELECT 1 FROM core_loan_application a WHERE a.party_id = c.party_id)
UNION ALL
SELECT 3, 'co_ho_so_duoc_duyet', COUNT(*)
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
  AND EXISTS (SELECT 1 FROM core_loan_application a
              WHERE a.party_id = c.party_id AND a.application_status = 'APPROVED')
UNION ALL
SELECT 4, 'co_khoan_vay', COUNT(*)
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
  AND EXISTS (SELECT 1 FROM core_loan_application a
              JOIN core_loan_contract l ON l.application_id = a.application_id
              WHERE a.party_id = c.party_id)
ORDER BY buoc;

-- [aivb-q5-pheu-khach-vay] wrong: dem_ho_so_thay_khach
SELECT 1 AS buoc, 'khach_hoat_dong' AS ten_buoc, COUNT(*) AS so_khach
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
UNION ALL
SELECT 2, 'co_ho_so_vay', COUNT(*)
FROM core_loan_application a
WHERE a.party_id IN (SELECT party_id FROM core_customer WHERE customer_status = 'ACTIVE' AND segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON'))
UNION ALL
SELECT 3, 'co_ho_so_duoc_duyet', COUNT(*)
FROM core_loan_application a
WHERE a.application_status = 'APPROVED'
  AND a.party_id IN (SELECT party_id FROM core_customer WHERE customer_status = 'ACTIVE' AND segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON'))
UNION ALL
SELECT 4, 'co_khoan_vay', COUNT(*)
FROM core_loan_contract l
JOIN core_loan_application a ON a.application_id = l.application_id
WHERE a.party_id IN (SELECT party_id FROM core_customer WHERE customer_status = 'ACTIVE' AND segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON'))
ORDER BY buoc;

-- [aivb-q5-pheu-khach-vay] wrong: buoc_4_bang_buoc_3
SELECT 1 AS buoc, 'khach_hoat_dong' AS ten_buoc, COUNT(*) AS so_khach
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
UNION ALL
SELECT 2, 'co_ho_so_vay', COUNT(*)
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
  AND EXISTS (SELECT 1 FROM core_loan_application a WHERE a.party_id = c.party_id)
UNION ALL
SELECT 3, 'co_ho_so_duoc_duyet', COUNT(*)
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
  AND EXISTS (SELECT 1 FROM core_loan_application a
              WHERE a.party_id = c.party_id AND a.application_status = 'APPROVED')
UNION ALL
SELECT 4, 'co_khoan_vay', COUNT(*)
FROM core_customer c
WHERE c.customer_status = 'ACTIVE'
  AND c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
  AND EXISTS (SELECT 1 FROM core_loan_application a
              WHERE a.party_id = c.party_id AND a.application_status = 'APPROVED')
ORDER BY buoc;

-- [aivb-q6-lenh-lon-bat-thuong] solution
SELECT o.payment_order_id, o.transaction_type, o.channel_code, o.amount,
       ROUND(t.bq, 0) AS bq_loai,
       ROUND(o.amount / t.bq, 1) AS boi_so
FROM core_payment_order o
JOIN (SELECT transaction_type, AVG(amount) AS bq
      FROM core_payment_order
      WHERE payment_status = 'COMPLETED'
        AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
      GROUP BY transaction_type) t ON t.transaction_type = o.transaction_type
WHERE o.payment_status = 'COMPLETED'
  AND o.transaction_date = '2026-12-31'
  AND o.amount > 10 * t.bq
ORDER BY o.amount DESC, o.payment_order_id;

-- [aivb-q6-lenh-lon-bat-thuong] wrong: binh_quan_moi_loai_giao_dich
SELECT o.payment_order_id, o.transaction_type, o.channel_code, o.amount,
       ROUND(t.bq, 0) AS bq_loai,
       ROUND(o.amount / t.bq, 1) AS boi_so
FROM core_payment_order o
CROSS JOIN (SELECT AVG(amount) AS bq
            FROM core_payment_order
            WHERE payment_status = 'COMPLETED'
              AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01') t
WHERE o.payment_status = 'COMPLETED'
  AND o.transaction_date = '2026-12-31'
  AND o.amount > 10 * t.bq
ORDER BY o.amount DESC, o.payment_order_id;

-- [aivb-q6-lenh-lon-bat-thuong] wrong: binh_quan_thieu_can_tren
SELECT o.payment_order_id, o.transaction_type, o.channel_code, o.amount,
       ROUND(t.bq, 0) AS bq_loai,
       ROUND(o.amount / t.bq, 1) AS boi_so
FROM core_payment_order o
JOIN (SELECT transaction_type, AVG(amount) AS bq
      FROM core_payment_order
      WHERE payment_status = 'COMPLETED'
        AND transaction_date >= '2026-01-01'
      GROUP BY transaction_type) t ON t.transaction_type = o.transaction_type
WHERE o.payment_status = 'COMPLETED'
  AND o.transaction_date = '2026-12-31'
  AND o.amount > 10 * t.bq
ORDER BY o.amount DESC, o.payment_order_id;

-- [aivb-q7-khach-chua-nop-ho-so] starter
SELECT c.customer_id, c.segment_code
FROM core_customer c
WHERE c.home_branch_id = 'CN06'
  AND c.customer_status = 'ACTIVE'
  AND c.customer_id NOT IN (SELECT a.party_id FROM core_loan_application a)
ORDER BY c.customer_id;

-- [aivb-q7-khach-chua-nop-ho-so] solution
SELECT c.customer_id, c.segment_code
FROM core_customer c
WHERE c.home_branch_id = 'CN06'
  AND c.customer_status = 'ACTIVE'
  AND c.party_id NOT IN (SELECT a.party_id FROM core_loan_application a)
ORDER BY c.customer_id;

-- [aivb-q7-khach-chua-nop-ho-so] wrong: chi_loai_ho_so_duoc_duyet
SELECT c.customer_id, c.segment_code
FROM core_customer c
WHERE c.home_branch_id = 'CN06'
  AND c.customer_status = 'ACTIVE'
  AND c.party_id NOT IN (SELECT a.party_id FROM core_loan_application a
                         WHERE a.application_status = 'APPROVED')
ORDER BY c.customer_id;

-- [aivb-q8-chi-nhanh-so-du-tren-binh-quan] starter
SELECT ct.home_branch_id AS ref_branch_id,
       ROUND(SUM(b.current_balance) / 1000000, 0) AS tong_so_du
FROM core_account_balance b
JOIN core_account a ON a.account_id = b.account_id
JOIN core_contract ct ON ct.contract_id = a.contract_id
GROUP BY ct.home_branch_id
HAVING SUM(b.current_balance) > (SELECT AVG(current_balance) FROM core_account_balance)
ORDER BY tong_so_du DESC, ref_branch_id;

-- [aivb-q8-chi-nhanh-so-du-tren-binh-quan] solution
SELECT ct.home_branch_id AS ref_branch_id,
       ROUND(SUM(b.current_balance) / 1000000, 0) AS tong_so_du
FROM core_account_balance b
JOIN core_account a ON a.account_id = b.account_id
JOIN core_contract ct ON ct.contract_id = a.contract_id
GROUP BY ct.home_branch_id
HAVING SUM(b.current_balance) > (SELECT AVG(t.tong)
                                 FROM (SELECT SUM(b2.current_balance) AS tong
                                       FROM core_account_balance b2
                                       JOIN core_account a2 ON a2.account_id = b2.account_id
                                       JOIN core_contract ct2 ON ct2.contract_id = a2.contract_id
                                       GROUP BY ct2.home_branch_id) t)
ORDER BY tong_so_du DESC, ref_branch_id;

-- [aivb-q8-chi-nhanh-so-du-tren-binh-quan] wrong: bang_dan_xuat_quen_group_by
SELECT ct.home_branch_id AS ref_branch_id,
       ROUND(SUM(b.current_balance) / 1000000, 0) AS tong_so_du
FROM core_account_balance b
JOIN core_account a ON a.account_id = b.account_id
JOIN core_contract ct ON ct.contract_id = a.contract_id
GROUP BY ct.home_branch_id
HAVING SUM(b.current_balance) > (SELECT AVG(t.tong)
                                 FROM (SELECT SUM(b2.current_balance) AS tong
                                       FROM core_account_balance b2
                                       JOIN core_account a2 ON a2.account_id = b2.account_id
                                       JOIN core_contract ct2 ON ct2.contract_id = a2.contract_id) t)
ORDER BY tong_so_du DESC, ref_branch_id;

-- [aivb-q9-chinh-sach-hieu-luc-ngay-nop] starter
SELECT t.policy_version_id,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN t.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct,
       ROUND(MAX(p.approval_rate) * 100, 2) AS ty_le_duyet_chinh_sach_pct
FROM (SELECT a.application_id, a.application_status,
             (SELECT pv.policy_version_id FROM ref_policy_version pv
              WHERE a.application_date >= pv.effective_from
                AND a.application_date < pv.effective_to) AS policy_version_id
      FROM core_loan_application a) t
JOIN ref_policy_version p ON p.policy_version_id = t.policy_version_id
GROUP BY t.policy_version_id
ORDER BY t.policy_version_id;

-- [aivb-q9-chinh-sach-hieu-luc-ngay-nop] solution
SELECT t.policy_version_id,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN t.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct,
       ROUND(MAX(p.approval_rate) * 100, 2) AS ty_le_duyet_chinh_sach_pct
FROM (SELECT a.application_id, a.application_status,
             (SELECT pv.policy_version_id FROM ref_policy_version pv
              WHERE a.application_date >= pv.effective_from
                AND a.application_date <= pv.effective_to) AS policy_version_id
      FROM core_loan_application a) t
JOIN ref_policy_version p ON p.policy_version_id = t.policy_version_id
GROUP BY t.policy_version_id
ORDER BY t.policy_version_id;

-- [aivb-q9-chinh-sach-hieu-luc-ngay-nop] wrong: dung_ma_gan_tren_ho_so
SELECT a.policy_version_id,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN a.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct,
       ROUND(MAX(p.approval_rate) * 100, 2) AS ty_le_duyet_chinh_sach_pct
FROM core_loan_application a
JOIN ref_policy_version p ON p.policy_version_id = a.policy_version_id
GROUP BY a.policy_version_id
ORDER BY a.policy_version_id;

-- ================================================================ CASE STUDY

-- [aivb-c5-kyc-khong-dat-theo-chi-nhanh.b1] solution
SELECT b.ref_branch_id, b.branch_name,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) AS so_kyc_khong_dat
FROM core_customer c
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
GROUP BY b.ref_branch_id, b.branch_name
ORDER BY b.ref_branch_id;

-- [aivb-c5-kyc-khong-dat-theo-chi-nhanh.b1] wrong: noi_theo_branch_code
SELECT b.ref_branch_id, b.branch_name,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) AS so_kyc_khong_dat
FROM core_customer c
JOIN ref_branch b ON b.branch_code = c.home_branch_id
GROUP BY b.ref_branch_id, b.branch_name
ORDER BY b.ref_branch_id;

-- [aivb-c5-kyc-khong-dat-theo-chi-nhanh.b2] solution
SELECT c.home_branch_id AS ref_branch_id,
       ROUND(100 * SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_khong_dat_pct,
       ROUND(100 * SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) / COUNT(*)
             - (SELECT 100 * SUM(CASE WHEN x.kyc_status = 'FAIL' THEN 1 ELSE 0 END) / COUNT(*) FROM core_customer x), 2) AS chenh_lech_diem_pct
FROM core_customer c
GROUP BY c.home_branch_id
ORDER BY ty_le_khong_dat_pct DESC, ref_branch_id;

-- [aivb-c5-kyc-khong-dat-theo-chi-nhanh.b2] wrong: mau_so_chi_khach_hoat_dong
SELECT c.home_branch_id AS ref_branch_id,
       ROUND(100 * SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) / SUM(CASE WHEN c.customer_status = 'ACTIVE' THEN 1 ELSE 0 END), 2) AS ty_le_khong_dat_pct,
       ROUND(100 * SUM(CASE WHEN c.kyc_status = 'FAIL' THEN 1 ELSE 0 END) / SUM(CASE WHEN c.customer_status = 'ACTIVE' THEN 1 ELSE 0 END)
             - (SELECT 100 * SUM(CASE WHEN x.kyc_status = 'FAIL' THEN 1 ELSE 0 END) / SUM(CASE WHEN x.customer_status = 'ACTIVE' THEN 1 ELSE 0 END) FROM core_customer x), 2) AS chenh_lech_diem_pct
FROM core_customer c
GROUP BY c.home_branch_id
ORDER BY ty_le_khong_dat_pct DESC, ref_branch_id;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b1] solution
SELECT c.segment_code,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN c.party_id IN (SELECT ap.party_id
                                    FROM core_deposit_contract d
                                    JOIN core_account_party ap ON ap.account_id = d.settlement_account_id
                                    WHERE ap.role_code = 'PRIMARY_OWNER') THEN 1 ELSE 0 END) AS so_khach_co_tien_gui
FROM core_customer c
WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
GROUP BY c.segment_code
ORDER BY c.segment_code;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b1] wrong: gom_moi_vai_tro_tai_khoan
SELECT c.segment_code,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN c.party_id IN (SELECT ap.party_id
                                    FROM core_deposit_contract d
                                    JOIN core_account_party ap ON ap.account_id = d.settlement_account_id) THEN 1 ELSE 0 END) AS so_khach_co_tien_gui
FROM core_customer c
WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
GROUP BY c.segment_code
ORDER BY c.segment_code;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b1] wrong: dem_hop_dong_thay_khach
SELECT c.segment_code,
       COUNT(DISTINCT c.customer_id) AS so_khach,
       COUNT(d.deposit_id) AS so_khach_co_tien_gui
FROM core_customer c
LEFT JOIN core_account_party ap ON ap.party_id = c.party_id AND ap.role_code = 'PRIMARY_OWNER'
LEFT JOIN core_deposit_contract d ON d.settlement_account_id = ap.account_id
WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
GROUP BY c.segment_code
ORDER BY c.segment_code;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b2] solution
SELECT c.segment_code,
       SUM(CASE WHEN c.party_id IN (SELECT a.party_id
                                    FROM core_loan_application a
                                    JOIN core_loan_contract l ON l.application_id = a.application_id) THEN 1 ELSE 0 END) AS so_khach_co_khoan_vay
FROM core_customer c
WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
GROUP BY c.segment_code
ORDER BY c.segment_code;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b2] wrong: chi_can_co_ho_so_vay
SELECT c.segment_code,
       SUM(CASE WHEN c.party_id IN (SELECT a.party_id FROM core_loan_application a) THEN 1 ELSE 0 END) AS so_khach_co_khoan_vay
FROM core_customer c
WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')
GROUP BY c.segment_code
ORDER BY c.segment_code;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b3] solution
SELECT t.segment_code,
       SUM(CASE WHEN t.co_gui = 1 AND t.co_vay = 0 THEN 1 ELSE 0 END) AS chi_gui,
       SUM(CASE WHEN t.co_gui = 0 AND t.co_vay = 1 THEN 1 ELSE 0 END) AS chi_vay,
       SUM(CASE WHEN t.co_gui = 1 AND t.co_vay = 1 THEN 1 ELSE 0 END) AS ca_hai,
       ROUND(100 * SUM(CASE WHEN t.co_gui = 1 AND t.co_vay = 1 THEN 1 ELSE 0 END)
             / SUM(CASE WHEN t.co_gui = 1 THEN 1 ELSE 0 END), 2) AS ty_le_vay_co_gui_pct,
       ROUND(100 * SUM(CASE WHEN t.co_gui = 0 AND t.co_vay = 1 THEN 1 ELSE 0 END)
             / SUM(CASE WHEN t.co_gui = 0 THEN 1 ELSE 0 END), 2) AS ty_le_vay_khong_gui_pct
FROM (SELECT c.segment_code,
             CASE WHEN c.party_id IN (SELECT ap.party_id
                                      FROM core_deposit_contract d
                                      JOIN core_account_party ap ON ap.account_id = d.settlement_account_id
                                      WHERE ap.role_code = 'PRIMARY_OWNER') THEN 1 ELSE 0 END AS co_gui,
             CASE WHEN c.party_id IN (SELECT a.party_id
                                      FROM core_loan_application a
                                      JOIN core_loan_contract l ON l.application_id = a.application_id) THEN 1 ELSE 0 END AS co_vay
      FROM core_customer c
      WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')) t
GROUP BY t.segment_code
ORDER BY t.segment_code;

-- [aivb-c6-ban-cheo-tien-gui-va-vay.b3] wrong: mau_so_toan_phan_khuc
SELECT t.segment_code,
       SUM(CASE WHEN t.co_gui = 1 AND t.co_vay = 0 THEN 1 ELSE 0 END) AS chi_gui,
       SUM(CASE WHEN t.co_gui = 0 AND t.co_vay = 1 THEN 1 ELSE 0 END) AS chi_vay,
       SUM(CASE WHEN t.co_gui = 1 AND t.co_vay = 1 THEN 1 ELSE 0 END) AS ca_hai,
       ROUND(100 * SUM(CASE WHEN t.co_gui = 1 AND t.co_vay = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_vay_co_gui_pct,
       ROUND(100 * SUM(CASE WHEN t.co_gui = 0 AND t.co_vay = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_vay_khong_gui_pct
FROM (SELECT c.segment_code,
             CASE WHEN c.party_id IN (SELECT ap.party_id
                                      FROM core_deposit_contract d
                                      JOIN core_account_party ap ON ap.account_id = d.settlement_account_id
                                      WHERE ap.role_code = 'PRIMARY_OWNER') THEN 1 ELSE 0 END AS co_gui,
             CASE WHEN c.party_id IN (SELECT a.party_id
                                      FROM core_loan_application a
                                      JOIN core_loan_contract l ON l.application_id = a.application_id) THEN 1 ELSE 0 END AS co_vay
      FROM core_customer c
      WHERE c.segment_code IN (SELECT segment_code FROM ref_segment WHERE party_type = 'PERSON')) t
GROUP BY t.segment_code
ORDER BY t.segment_code;
