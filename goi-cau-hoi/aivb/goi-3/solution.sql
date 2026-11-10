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

-- [aivb-j3-so-du-tai-khoan-mo-thang-12-2025] solution
SELECT a.account_id, a.open_date, a.account_status, b.current_balance
FROM core_account a
JOIN core_account_balance b ON b.account_id = a.account_id
WHERE a.open_date >= '2025-12-01' AND a.open_date < '2026-01-01'
ORDER BY b.current_balance DESC, a.account_id;

-- [aivb-j3-so-du-tai-khoan-mo-thang-12-2025] wrong: thieu_can_tren
SELECT a.account_id, a.open_date, a.account_status, b.current_balance
FROM core_account a
JOIN core_account_balance b ON b.account_id = a.account_id
WHERE a.open_date >= '2025-12-01'
ORDER BY b.current_balance DESC, a.account_id;

-- [aivb-j3-so-du-tai-khoan-mo-thang-12-2025] wrong: noi_contract_id_voi_account_id
SELECT a.account_id, a.open_date, a.account_status, b.current_balance
FROM core_account a
JOIN core_account_balance b ON b.account_id = a.contract_id
WHERE a.open_date >= '2025-12-01' AND a.open_date < '2026-01-01'
ORDER BY b.current_balance DESC, a.account_id;

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

-- [aivb-j5-doi-soat-du-no-khoan-vay] solution
WITH gn AS (SELECT loan_id, SUM(amount) AS tong_giai_ngan
            FROM core_loan_disbursement
            GROUP BY loan_id),
     gt AS (SELECT loan_id, SUM(principal_amount) AS tong_goc_da_thu
            FROM core_loan_payment_allocation
            GROUP BY loan_id)
SELECT pv.product_id,
       COUNT(*) AS so_khoan_vay,
       ROUND(SUM(l.outstanding) / 1000000, 0) AS du_no_hop_dong,
       ROUND(SUM(COALESCE(gn.tong_giai_ngan, 0) - COALESCE(gt.tong_goc_da_thu, 0)) / 1000000, 0) AS du_no_tinh_lai,
       SUM(CASE WHEN COALESCE(gn.tong_giai_ngan, 0) - COALESCE(gt.tong_goc_da_thu, 0) <> l.outstanding THEN 1 ELSE 0 END) AS so_khoan_lech
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version pv ON pv.product_version_id = c.product_version_id
LEFT JOIN gn ON gn.loan_id = l.loan_id
LEFT JOIN gt ON gt.loan_id = l.loan_id
WHERE l.loan_status <> 'SETTLED'
GROUP BY pv.product_id
ORDER BY pv.product_id;

-- [aivb-j5-doi-soat-du-no-khoan-vay] wrong: noi_thang_hai_so
SELECT pv.product_id,
       COUNT(*) AS so_khoan_vay,
       ROUND(SUM(t.outstanding) / 1000000, 0) AS du_no_hop_dong,
       ROUND(SUM(t.du_no_tinh_lai) / 1000000, 0) AS du_no_tinh_lai,
       SUM(CASE WHEN t.du_no_tinh_lai <> t.outstanding THEN 1 ELSE 0 END) AS so_khoan_lech
FROM (SELECT l.loan_id, l.contract_id, l.outstanding,
             COALESCE(SUM(d.amount), 0) - COALESCE(SUM(a.principal_amount), 0) AS du_no_tinh_lai
      FROM core_loan_contract l
      LEFT JOIN core_loan_disbursement d ON d.loan_id = l.loan_id
      LEFT JOIN core_loan_payment_allocation a ON a.loan_id = l.loan_id
      WHERE l.loan_status <> 'SETTLED'
      GROUP BY l.loan_id, l.contract_id, l.outstanding) t
JOIN core_contract c ON c.contract_id = t.contract_id
JOIN ref_product_version pv ON pv.product_version_id = c.product_version_id
GROUP BY pv.product_id
ORDER BY pv.product_id;

-- [aivb-j5-doi-soat-du-no-khoan-vay] wrong: inner_join_so_thu_no
WITH gn AS (SELECT loan_id, SUM(amount) AS tong_giai_ngan
            FROM core_loan_disbursement
            GROUP BY loan_id),
     gt AS (SELECT loan_id, SUM(principal_amount) AS tong_goc_da_thu
            FROM core_loan_payment_allocation
            GROUP BY loan_id)
SELECT pv.product_id,
       COUNT(*) AS so_khoan_vay,
       ROUND(SUM(l.outstanding) / 1000000, 0) AS du_no_hop_dong,
       ROUND(SUM(gn.tong_giai_ngan - gt.tong_goc_da_thu) / 1000000, 0) AS du_no_tinh_lai,
       SUM(CASE WHEN gn.tong_giai_ngan - gt.tong_goc_da_thu <> l.outstanding THEN 1 ELSE 0 END) AS so_khoan_lech
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version pv ON pv.product_version_id = c.product_version_id
JOIN gn ON gn.loan_id = l.loan_id
JOIN gt ON gt.loan_id = l.loan_id
WHERE l.loan_status <> 'SETTLED'
GROUP BY pv.product_id
ORDER BY pv.product_id;

-- [aivb-j5-doi-soat-du-no-khoan-vay] wrong: tru_khong_coalesce
WITH gn AS (SELECT loan_id, SUM(amount) AS tong_giai_ngan
            FROM core_loan_disbursement
            GROUP BY loan_id),
     gt AS (SELECT loan_id, SUM(principal_amount) AS tong_goc_da_thu
            FROM core_loan_payment_allocation
            GROUP BY loan_id)
SELECT pv.product_id,
       COUNT(*) AS so_khoan_vay,
       ROUND(SUM(l.outstanding) / 1000000, 0) AS du_no_hop_dong,
       ROUND(SUM(gn.tong_giai_ngan - gt.tong_goc_da_thu) / 1000000, 0) AS du_no_tinh_lai,
       SUM(CASE WHEN gn.tong_giai_ngan - gt.tong_goc_da_thu <> l.outstanding THEN 1 ELSE 0 END) AS so_khoan_lech
FROM core_loan_contract l
JOIN core_contract c ON c.contract_id = l.contract_id
JOIN ref_product_version pv ON pv.product_version_id = c.product_version_id
LEFT JOIN gn ON gn.loan_id = l.loan_id
LEFT JOIN gt ON gt.loan_id = l.loan_id
WHERE l.loan_status <> 'SETTLED'
GROUP BY pv.product_id
ORDER BY pv.product_id;

-- [aivb-j6-cap-san-pham-vay-cung-khach] solution
WITH sp AS (SELECT DISTINCT party_id, product_id
            FROM core_loan_application
            WHERE application_status = 'APPROVED')
SELECT a.product_id AS san_pham_1, b.product_id AS san_pham_2, COUNT(*) AS so_khach
FROM sp a
JOIN sp b ON b.party_id = a.party_id AND a.product_id < b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY so_khach DESC, san_pham_1, san_pham_2;

-- [aivb-j6-cap-san-pham-vay-cung-khach] wrong: cap_dao_chieu
WITH sp AS (SELECT DISTINCT party_id, product_id
            FROM core_loan_application
            WHERE application_status = 'APPROVED')
SELECT a.product_id AS san_pham_1, b.product_id AS san_pham_2, COUNT(*) AS so_khach
FROM sp a
JOIN sp b ON b.party_id = a.party_id AND a.product_id <> b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY so_khach DESC, san_pham_1, san_pham_2;

-- [aivb-j6-cap-san-pham-vay-cung-khach] wrong: dem_trung_ho_so
SELECT a.product_id AS san_pham_1, b.product_id AS san_pham_2, COUNT(*) AS so_khach
FROM core_loan_application a
JOIN core_loan_application b ON b.party_id = a.party_id AND a.product_id < b.product_id
WHERE a.application_status = 'APPROVED' AND b.application_status = 'APPROVED'
GROUP BY a.product_id, b.product_id
ORDER BY so_khach DESC, san_pham_1, san_pham_2;

-- [aivb-j6-cap-san-pham-vay-cung-khach] wrong: gom_ho_so_bi_tu_choi
WITH sp AS (SELECT DISTINCT party_id, product_id
            FROM core_loan_application)
SELECT a.product_id AS san_pham_1, b.product_id AS san_pham_2, COUNT(*) AS so_khach
FROM sp a
JOIN sp b ON b.party_id = a.party_id AND a.product_id < b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY so_khach DESC, san_pham_1, san_pham_2;

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
  AND p.transaction_date >= '2026-12-31'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j8-dong-tien-rong-theo-kenh] solution
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE o.payment_status = 'COMPLETED'
  AND p.transaction_date >= '2026-12-31' AND p.transaction_date < '2027-01-01'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j8-dong-tien-rong-theo-kenh] wrong: chi_sua_dau_thieu_can_tren
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE o.payment_status = 'COMPLETED'
  AND p.transaction_date >= '2026-12-31'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j8-dong-tien-rong-theo-kenh] wrong: gom_lenh_bi_dao_tu_choi
SELECT o.channel_code,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE p.transaction_date >= '2026-12-31' AND p.transaction_date < '2027-01-01'
GROUP BY o.channel_code
ORDER BY o.channel_code;

-- [aivb-j9-lai-du-thu-cho-vay-2026] starter
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
JOIN core_loan_contract l ON l.loan_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01' AND ia.accrual_date < '2027-01-01';

-- [aivb-j9-lai-du-thu-cho-vay-2026] solution
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
JOIN core_loan_contract l ON l.contract_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01' AND ia.accrual_date < '2027-01-01';

-- [aivb-j9-lai-du-thu-cho-vay-2026] wrong: chi_doi_sang_left_join
SELECT COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(ia.accrued_amount) AS tong_lai_du_thu
FROM core_interest_accrual ia
LEFT JOIN core_loan_contract l ON l.loan_id = ia.contract_id
WHERE ia.accrual_date >= '2026-01-01' AND ia.accrual_date < '2027-01-01';

-- [aivb-j9-lai-du-thu-cho-vay-2026] wrong: left_join_dung_khoa
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

-- [aivb-q2-khoan-vay-co-ky-qua-han] solution
SELECT l.loan_id, l.loan_status, l.outstanding
FROM core_loan_contract l
WHERE l.loan_id IN (SELECT s.loan_id
                    FROM core_loan_schedule s
                    WHERE s.schedule_status = 'OVERDUE')
ORDER BY l.loan_id;

-- [aivb-q2-khoan-vay-co-ky-qua-han] wrong: join_lap_dong
SELECT l.loan_id, l.loan_status, l.outstanding
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status = 'OVERDUE'
ORDER BY l.loan_id;

-- [aivb-q2-khoan-vay-co-ky-qua-han] wrong: chi_xet_trang_thai_delinquent
SELECT l.loan_id, l.loan_status, l.outstanding
FROM core_loan_contract l
WHERE l.loan_status = 'DELINQUENT'
ORDER BY l.loan_id;

-- [aivb-q3-tien-gui-lon-gap-10-binh-quan] solution
SELECT deposit_id, term_months, deposit_status, principal
FROM core_deposit_contract
WHERE principal > 10 * (SELECT AVG(principal) FROM core_deposit_contract)
ORDER BY principal DESC, deposit_id;

-- [aivb-q3-tien-gui-lon-gap-10-binh-quan] wrong: quen_he_so_10
SELECT deposit_id, term_months, deposit_status, principal
FROM core_deposit_contract
WHERE principal > (SELECT AVG(principal) FROM core_deposit_contract)
ORDER BY principal DESC, deposit_id;

-- [aivb-q3-tien-gui-lon-gap-10-binh-quan] wrong: binh_quan_chi_hop_dong_active
SELECT deposit_id, term_months, deposit_status, principal
FROM core_deposit_contract
WHERE principal > 10 * (SELECT AVG(principal) FROM core_deposit_contract WHERE deposit_status = 'ACTIVE')
ORDER BY principal DESC, deposit_id;

-- [aivb-q4-ho-so-vay-dau-tien] solution
SELECT f.product_id,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) AS so_duoc_duyet,
       ROUND(100 * SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application f
WHERE f.application_id = (SELECT b.application_id
                          FROM core_loan_application b
                          WHERE b.party_id = f.party_id
                          ORDER BY b.application_date, b.application_id
                          LIMIT 1)
GROUP BY f.product_id
ORDER BY so_khach DESC, f.product_id;

-- [aivb-q4-ho-so-vay-dau-tien] wrong: min_ma_ho_so
SELECT f.product_id,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) AS so_duoc_duyet,
       ROUND(100 * SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application f
WHERE f.application_id = (SELECT MIN(b.application_id)
                          FROM core_loan_application b
                          WHERE b.party_id = f.party_id)
GROUP BY f.product_id
ORDER BY so_khach DESC, f.product_id;

-- [aivb-q4-ho-so-vay-dau-tien] wrong: dau_tien_theo_chu_the_va_san_pham
SELECT f.product_id,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) AS so_duoc_duyet,
       ROUND(100 * SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application f
WHERE f.application_date = (SELECT MIN(b.application_date)
                            FROM core_loan_application b
                            WHERE b.party_id = f.party_id AND b.product_id = f.product_id)
GROUP BY f.product_id
ORDER BY so_khach DESC, f.product_id;

-- [aivb-q4-ho-so-vay-dau-tien] wrong: khong_tuong_quan
SELECT f.product_id,
       COUNT(*) AS so_khach,
       SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) AS so_duoc_duyet,
       ROUND(100 * SUM(CASE WHEN f.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct
FROM core_loan_application f
WHERE f.application_date = (SELECT MIN(b.application_date) FROM core_loan_application b)
GROUP BY f.product_id
ORDER BY so_khach DESC, f.product_id;

-- [aivb-q5-pheu-khach-vay-2026] solution
WITH kh AS (SELECT c.party_id
            FROM core_customer c
            JOIN ref_segment s ON s.segment_code = c.segment_code
            WHERE s.party_type = 'PERSON'),
     hs AS (SELECT application_id, party_id, application_status
            FROM core_loan_application
            WHERE application_date >= '2026-01-01' AND application_date < '2027-01-01'),
     buoc AS (
       SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, COUNT(*) AS so_khach
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 2, 'duoc_duyet', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id AND hs.application_status = 'APPROVED')
       UNION ALL
       SELECT 3, 'co_khoan_vay', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
                             WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 4, 'tra_no_binh_thuong', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
                             WHERE hs.party_id = kh.party_id AND l.loan_status = 'ACTIVE'))
SELECT t.buoc, t.ten_buoc, t.so_khach,
       ROUND(100 * t.so_khach / p.so_khach, 2) AS ty_le_chuyen_doi_pct
FROM buoc t
LEFT JOIN buoc p ON p.buoc = t.buoc - 1
ORDER BY t.buoc;

-- [aivb-q5-pheu-khach-vay-2026] wrong: dem_ho_so_thay_khach
WITH kh AS (SELECT c.party_id
            FROM core_customer c
            JOIN ref_segment s ON s.segment_code = c.segment_code
            WHERE s.party_type = 'PERSON'),
     hs AS (SELECT application_id, party_id, application_status
            FROM core_loan_application
            WHERE application_date >= '2026-01-01' AND application_date < '2027-01-01'
              AND party_id IN (SELECT party_id FROM kh)),
     buoc AS (
       SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, COUNT(*) AS so_khach FROM hs
       UNION ALL
       SELECT 2, 'duoc_duyet', COUNT(*) FROM hs WHERE hs.application_status = 'APPROVED'
       UNION ALL
       SELECT 3, 'co_khoan_vay', COUNT(*) FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
       UNION ALL
       SELECT 4, 'tra_no_binh_thuong', COUNT(*) FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
       WHERE l.loan_status = 'ACTIVE')
SELECT t.buoc, t.ten_buoc, t.so_khach,
       ROUND(100 * t.so_khach / p.so_khach, 2) AS ty_le_chuyen_doi_pct
FROM buoc t
LEFT JOIN buoc p ON p.buoc = t.buoc - 1
ORDER BY t.buoc;

-- [aivb-q5-pheu-khach-vay-2026] wrong: khoan_vay_cua_ho_so_bat_ky
WITH kh AS (SELECT c.party_id
            FROM core_customer c
            JOIN ref_segment s ON s.segment_code = c.segment_code
            WHERE s.party_type = 'PERSON'),
     hs AS (SELECT application_id, party_id, application_status
            FROM core_loan_application
            WHERE application_date >= '2026-01-01' AND application_date < '2027-01-01'),
     buoc AS (
       SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, COUNT(*) AS so_khach
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 2, 'duoc_duyet', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id AND hs.application_status = 'APPROVED')
       UNION ALL
       SELECT 3, 'co_khoan_vay', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id AND hs.application_status = 'APPROVED')
                 AND EXISTS (SELECT 1 FROM core_loan_application a JOIN core_loan_contract l ON l.application_id = a.application_id
                             WHERE a.party_id = kh.party_id)
       UNION ALL
       SELECT 4, 'tra_no_binh_thuong', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id AND hs.application_status = 'APPROVED')
                 AND EXISTS (SELECT 1 FROM core_loan_application a JOIN core_loan_contract l ON l.application_id = a.application_id
                             WHERE a.party_id = kh.party_id AND l.loan_status = 'ACTIVE'))
SELECT t.buoc, t.ten_buoc, t.so_khach,
       ROUND(100 * t.so_khach / p.so_khach, 2) AS ty_le_chuyen_doi_pct
FROM buoc t
LEFT JOIN buoc p ON p.buoc = t.buoc - 1
ORDER BY t.buoc;

-- [aivb-q5-pheu-khach-vay-2026] wrong: con_du_no_thay_tra_binh_thuong
WITH kh AS (SELECT c.party_id
            FROM core_customer c
            JOIN ref_segment s ON s.segment_code = c.segment_code
            WHERE s.party_type = 'PERSON'),
     hs AS (SELECT application_id, party_id, application_status
            FROM core_loan_application
            WHERE application_date >= '2026-01-01' AND application_date < '2027-01-01'),
     buoc AS (
       SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, COUNT(*) AS so_khach
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 2, 'duoc_duyet', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id AND hs.application_status = 'APPROVED')
       UNION ALL
       SELECT 3, 'co_khoan_vay', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
                             WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 4, 'tra_no_binh_thuong', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
                             WHERE hs.party_id = kh.party_id AND l.outstanding > 0))
SELECT t.buoc, t.ten_buoc, t.so_khach,
       ROUND(100 * t.so_khach / p.so_khach, 2) AS ty_le_chuyen_doi_pct
FROM buoc t
LEFT JOIN buoc p ON p.buoc = t.buoc - 1
ORDER BY t.buoc;

-- [aivb-q5-pheu-khach-vay-2026] wrong: ty_le_so_voi_buoc_1
WITH kh AS (SELECT c.party_id
            FROM core_customer c
            JOIN ref_segment s ON s.segment_code = c.segment_code
            WHERE s.party_type = 'PERSON'),
     hs AS (SELECT application_id, party_id, application_status
            FROM core_loan_application
            WHERE application_date >= '2026-01-01' AND application_date < '2027-01-01'),
     buoc AS (
       SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, COUNT(*) AS so_khach
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 2, 'duoc_duyet', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs WHERE hs.party_id = kh.party_id AND hs.application_status = 'APPROVED')
       UNION ALL
       SELECT 3, 'co_khoan_vay', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
                             WHERE hs.party_id = kh.party_id)
       UNION ALL
       SELECT 4, 'tra_no_binh_thuong', COUNT(*)
       FROM kh WHERE EXISTS (SELECT 1 FROM hs JOIN core_loan_contract l ON l.application_id = hs.application_id
                             WHERE hs.party_id = kh.party_id AND l.loan_status = 'ACTIVE'))
SELECT t.buoc, t.ten_buoc, t.so_khach,
       CASE WHEN t.buoc = 1 THEN NULL
            ELSE ROUND(100 * t.so_khach / (SELECT so_khach FROM buoc WHERE buoc = 1), 2) END AS ty_le_chuyen_doi_pct
FROM buoc t
ORDER BY t.buoc;

-- [aivb-q6-lenh-lon-bat-thuong] solution
SELECT o.payment_order_id, o.channel_code, o.amount
FROM core_payment_order o
WHERE o.transaction_type = 'TRANSFER'
  AND o.payment_status = 'COMPLETED'
  AND o.transaction_date = '2026-12-31'
  AND o.amount > 5 * (SELECT AVG(x.amount)
                       FROM core_payment_order x
                       WHERE x.transaction_type = 'TRANSFER'
                         AND x.payment_status = 'COMPLETED'
                         AND x.transaction_date = '2026-12-31')
ORDER BY o.amount DESC, o.payment_order_id;

-- [aivb-q6-lenh-lon-bat-thuong] wrong: binh_quan_moi_loai_giao_dich
SELECT o.payment_order_id, o.channel_code, o.amount
FROM core_payment_order o
WHERE o.transaction_type = 'TRANSFER'
  AND o.payment_status = 'COMPLETED'
  AND o.transaction_date = '2026-12-31'
  AND o.amount > 5 * (SELECT AVG(x.amount)
                       FROM core_payment_order x
                       WHERE x.payment_status = 'COMPLETED'
                         AND x.transaction_date = '2026-12-31')
ORDER BY o.amount DESC, o.payment_order_id;

-- [aivb-q6-lenh-lon-bat-thuong] wrong: quen_loc_ngay_trong_truy_van_con
SELECT o.payment_order_id, o.channel_code, o.amount
FROM core_payment_order o
WHERE o.transaction_type = 'TRANSFER'
  AND o.payment_status = 'COMPLETED'
  AND o.transaction_date = '2026-12-31'
  AND o.amount > 5 * (SELECT AVG(x.amount)
                       FROM core_payment_order x
                       WHERE x.transaction_type = 'TRANSFER'
                         AND x.payment_status = 'COMPLETED')
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
              WHERE a.application_date > pv.effective_from
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

-- [aivb-q9-chinh-sach-hieu-luc-ngay-nop] wrong: chi_sua_can_tren
SELECT t.policy_version_id,
       COUNT(*) AS so_ho_so,
       ROUND(100 * SUM(CASE WHEN t.application_status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ty_le_duyet_pct,
       ROUND(MAX(p.approval_rate) * 100, 2) AS ty_le_duyet_chinh_sach_pct
FROM (SELECT a.application_id, a.application_status,
             (SELECT pv.policy_version_id FROM ref_policy_version pv
              WHERE a.application_date > pv.effective_from
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
