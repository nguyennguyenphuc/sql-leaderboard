-- solution.sql: GÓI 5 bộ AIV Bank (aivb), MySQL 8.0.
-- Module 9 Data Quality (aivb-k1..k9), Module 10 Query Performance (aivb-p1..p9), case aivb-c9, aivb-c10.
-- Chạy trên aivb (public) và aivb_hidden_1 (hidden-1). Ngày tham chiếu chung: 2026-12-31.

-- ================================================================ MODULE 9 · DATA QUALITY

-- [aivb-k1-ten-phap-ly-dung-chung] solution
SELECT legal_name AS ten_phap_ly,
       COUNT(*) AS so_chu_the
FROM core_party
GROUP BY legal_name
HAVING COUNT(*) >= 4
ORDER BY so_chu_the DESC, ten_phap_ly;

-- [aivb-k1-ten-phap-ly-dung-chung] wrong: bo_moc_4
SELECT legal_name AS ten_phap_ly,
       COUNT(*) AS so_chu_the
FROM core_party
GROUP BY legal_name
HAVING COUNT(*) > 4
ORDER BY so_chu_the DESC, ten_phap_ly;

-- [aivb-k2-phan-bo-thu-no-khong-co-lenh] solution
SELECT YEAR(a.allocation_date) AS nam,
       COUNT(*) AS so_phan_bo,
       COUNT(CASE WHEN p.payment_order_id IS NULL THEN 1 END) AS so_khong_co_lenh,
       ROUND(100 * COUNT(CASE WHEN p.payment_order_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM core_loan_payment_allocation a
LEFT JOIN core_payment_order p ON p.payment_order_id = a.payment_order_id
GROUP BY YEAR(a.allocation_date)
ORDER BY nam;

-- [aivb-k2-phan-bo-thu-no-khong-co-lenh] wrong: loc_null_truoc_khi_gom
SELECT YEAR(a.allocation_date) AS nam,
       COUNT(*) AS so_phan_bo,
       COUNT(*) AS so_khong_co_lenh,
       100.00 AS ty_le_pct
FROM core_loan_payment_allocation a
LEFT JOIN core_payment_order p ON p.payment_order_id = a.payment_order_id
WHERE p.payment_order_id IS NULL
GROUP BY YEAR(a.allocation_date)
ORDER BY nam;

-- [aivb-k2-phan-bo-thu-no-khong-co-lenh] wrong: inner_join
SELECT YEAR(a.allocation_date) AS nam,
       COUNT(*) AS so_phan_bo,
       COUNT(CASE WHEN p.payment_order_id IS NULL THEN 1 END) AS so_khong_co_lenh,
       ROUND(100 * COUNT(CASE WHEN p.payment_order_id IS NULL THEN 1 END) / COUNT(*), 2) AS ty_le_pct
FROM core_loan_payment_allocation a
JOIN core_payment_order p ON p.payment_order_id = a.payment_order_id
GROUP BY YEAR(a.allocation_date)
ORDER BY nam;

-- [aivb-k3-doi-soat-lai-du-thu-tien-gui] solution
WITH du_tra AS (
  SELECT contract_id, COUNT(*) AS so_dong, SUM(accrued_amount) AS lai_du_tra
  FROM core_interest_accrual
  WHERE accrual_date >= '2026-12-01' AND accrual_date < '2027-01-01'
  GROUP BY contract_id
  HAVING MIN(accrual_date) = '2026-12-01' AND MAX(accrual_date) = '2026-12-31'
),
doi_soat AS (
  SELECT t.contract_id, t.so_dong, t.lai_du_tra,
         d.principal * d.interest_rate * 31 / 365 AS lai_hop_dong
  FROM du_tra t
  JOIN core_deposit_contract d ON d.contract_id = t.contract_id
),
khong_co_lai AS (
  SELECT COUNT(*) AS so_hd
  FROM core_deposit_contract d
  WHERE d.deposit_status = 'ACTIVE'
    AND NOT EXISTS (SELECT 1 FROM core_interest_accrual a
                     WHERE a.contract_id = d.contract_id
                       AND a.accrual_date >= '2026-12-01' AND a.accrual_date < '2027-01-01')
)
SELECT COUNT(*) AS so_hop_dong,
       SUM(so_dong) AS so_dong_du_tra,
       SUM(lai_du_tra) AS tong_lai_du_tra,
       ROUND(SUM(lai_hop_dong), 0) AS tong_lai_hop_dong,
       (SELECT so_hd FROM khong_co_lai) AS so_hd_khong_co_lai
FROM doi_soat;

-- [aivb-k3-doi-soat-lai-du-thu-tien-gui] wrong: so_ngay_bang_so_dong
WITH du_tra AS (
  SELECT contract_id, COUNT(*) AS so_dong, SUM(accrued_amount) AS lai_du_tra
  FROM core_interest_accrual
  WHERE accrual_date >= '2026-12-01' AND accrual_date < '2027-01-01'
  GROUP BY contract_id
  HAVING MIN(accrual_date) = '2026-12-01' AND MAX(accrual_date) = '2026-12-31'
),
doi_soat AS (
  SELECT t.contract_id, t.so_dong, t.lai_du_tra,
         d.principal * d.interest_rate * t.so_dong / 365 AS lai_hop_dong
  FROM du_tra t
  JOIN core_deposit_contract d ON d.contract_id = t.contract_id
),
khong_co_lai AS (
  SELECT COUNT(*) AS so_hd
  FROM core_deposit_contract d
  WHERE d.deposit_status = 'ACTIVE'
    AND NOT EXISTS (SELECT 1 FROM core_interest_accrual a
                     WHERE a.contract_id = d.contract_id
                       AND a.accrual_date >= '2026-12-01' AND a.accrual_date < '2027-01-01')
)
SELECT COUNT(*) AS so_hop_dong,
       SUM(so_dong) AS so_dong_du_tra,
       SUM(lai_du_tra) AS tong_lai_du_tra,
       ROUND(SUM(lai_hop_dong), 0) AS tong_lai_hop_dong,
       (SELECT so_hd FROM khong_co_lai) AS so_hd_khong_co_lai
FROM doi_soat;

-- [aivb-k3-doi-soat-lai-du-thu-tien-gui] wrong: khong_loc_du_thang
WITH du_tra AS (
  SELECT contract_id, COUNT(*) AS so_dong, SUM(accrued_amount) AS lai_du_tra
  FROM core_interest_accrual
  WHERE accrual_date >= '2026-12-01' AND accrual_date < '2027-01-01'
  GROUP BY contract_id
),
doi_soat AS (
  SELECT t.contract_id, t.so_dong, t.lai_du_tra,
         d.principal * d.interest_rate * 31 / 365 AS lai_hop_dong
  FROM du_tra t
  JOIN core_deposit_contract d ON d.contract_id = t.contract_id
),
khong_co_lai AS (
  SELECT COUNT(*) AS so_hd
  FROM core_deposit_contract d
  WHERE d.deposit_status = 'ACTIVE'
    AND NOT EXISTS (SELECT 1 FROM core_interest_accrual a
                     WHERE a.contract_id = d.contract_id
                       AND a.accrual_date >= '2026-12-01' AND a.accrual_date < '2027-01-01')
)
SELECT COUNT(*) AS so_hop_dong,
       SUM(so_dong) AS so_dong_du_tra,
       SUM(lai_du_tra) AS tong_lai_du_tra,
       ROUND(SUM(lai_hop_dong), 0) AS tong_lai_hop_dong,
       (SELECT so_hd FROM khong_co_lai) AS so_hd_khong_co_lai
FROM doi_soat;

-- [aivb-k4-thieu-nghe-nghiep-theo-viec-lam] solution
SELECT employment_status,
       COUNT(*) AS so_thieu
FROM core_person
WHERE occupation_code IS NULL
GROUP BY employment_status
ORDER BY so_thieu DESC, employment_status;

-- [aivb-k4-thieu-nghe-nghiep-theo-viec-lam] wrong: so_sanh_bang_null
SELECT employment_status,
       COUNT(*) AS so_thieu
FROM core_person
WHERE occupation_code = NULL
GROUP BY employment_status
ORDER BY so_thieu DESC, employment_status;

-- [aivb-k4-thieu-nghe-nghiep-theo-viec-lam] wrong: count_cot_bo_null
SELECT employment_status,
       COUNT(occupation_code) AS so_thieu
FROM core_person
WHERE occupation_code IS NULL
GROUP BY employment_status
ORDER BY so_thieu DESC, employment_status;

-- [aivb-k5-du-no-lech-lich-tra-no] solution
SELECT l.loan_id, l.loan_status,
       l.outstanding AS du_no,
       SUM(s.principal_due - s.principal_paid) AS goc_con_lai
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status <> 'CANCELLED'
GROUP BY l.loan_id, l.loan_status, l.outstanding
HAVING l.outstanding <> SUM(s.principal_due - s.principal_paid)
ORDER BY l.loan_id;

-- [aivb-k5-du-no-lech-lich-tra-no] wrong: cong_ca_ky_da_huy
SELECT l.loan_id, l.loan_status,
       l.outstanding AS du_no,
       SUM(s.principal_due - s.principal_paid) AS goc_con_lai
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
GROUP BY l.loan_id, l.loan_status, l.outstanding
HAVING l.outstanding <> SUM(s.principal_due - s.principal_paid)
ORDER BY l.loan_id;

-- [aivb-k5-du-no-lech-lich-tra-no] wrong: chi_cong_goc_ky_chua_tra
SELECT l.loan_id, l.loan_status,
       l.outstanding AS du_no,
       SUM(s.principal_due) AS goc_con_lai
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status IN ('DUE', 'OVERDUE')
GROUP BY l.loan_id, l.loan_status, l.outstanding
HAVING l.outstanding <> SUM(s.principal_due)
ORDER BY l.loan_id;

-- [aivb-k6-ho-so-ngoai-hieu-luc-chinh-sach] solution
SELECT a.policy_version_id AS chinh_sach_gan,
       COALESCE(p.policy_version_id, 'KHONG_CO') AS chinh_sach_hieu_luc,
       COUNT(*) AS so_ho_so
FROM core_loan_application a
LEFT JOIN ref_policy_version p
  ON a.application_date >= p.effective_from
 AND (p.effective_to IS NULL OR a.application_date <= p.effective_to)
GROUP BY a.policy_version_id, COALESCE(p.policy_version_id, 'KHONG_CO')
ORDER BY chinh_sach_gan, chinh_sach_hieu_luc;

-- [aivb-k6-ho-so-ngoai-hieu-luc-chinh-sach] wrong: inner_join_mat_ho_so
SELECT a.policy_version_id AS chinh_sach_gan,
       p.policy_version_id AS chinh_sach_hieu_luc,
       COUNT(*) AS so_ho_so
FROM core_loan_application a
JOIN ref_policy_version p
  ON a.application_date >= p.effective_from
 AND (p.effective_to IS NULL OR a.application_date <= p.effective_to)
GROUP BY a.policy_version_id, p.policy_version_id
ORDER BY chinh_sach_gan, chinh_sach_hieu_luc;

-- [aivb-k6-ho-so-ngoai-hieu-luc-chinh-sach] wrong: bo_ngay_het_hieu_luc
SELECT a.policy_version_id AS chinh_sach_gan,
       COALESCE(p.policy_version_id, 'KHONG_CO') AS chinh_sach_hieu_luc,
       COUNT(*) AS so_ho_so
FROM core_loan_application a
LEFT JOIN ref_policy_version p
  ON a.application_date >= p.effective_from
 AND (p.effective_to IS NULL OR a.application_date < p.effective_to)
GROUP BY a.policy_version_id, COALESCE(p.policy_version_id, 'KHONG_CO')
ORDER BY chinh_sach_gan, chinh_sach_hieu_luc;

-- [aivb-k7-ngay-tu-choi-bat-thuong] starter
WITH theo_ngay AS (
  SELECT channel_code, transaction_date, COUNT(*) AS so_lenh_tu_choi
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2026-04-01'
  GROUP BY channel_code, transaction_date
),
binh_quan AS (
  SELECT channel_code, AVG(so_lenh_tu_choi) AS bq_ngay
  FROM theo_ngay
  GROUP BY channel_code
)
SELECT n.channel_code, n.transaction_date, n.so_lenh_tu_choi, ROUND(b.bq_ngay, 2) AS bq_ngay_kenh
FROM theo_ngay n
JOIN binh_quan b ON b.channel_code = n.channel_code
WHERE n.so_lenh_tu_choi > 3 * b.bq_ngay
ORDER BY n.channel_code, n.transaction_date;

-- [aivb-k7-ngay-tu-choi-bat-thuong] solution
WITH theo_ngay AS (
  SELECT channel_code, transaction_date, COUNT(*) AS so_lenh_tu_choi
  FROM core_payment_order
  WHERE payment_status = 'REJECTED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2026-04-01'
  GROUP BY channel_code, transaction_date
),
binh_quan AS (
  SELECT channel_code, AVG(so_lenh_tu_choi) AS bq_ngay
  FROM theo_ngay
  GROUP BY channel_code
)
SELECT n.channel_code, n.transaction_date, n.so_lenh_tu_choi, ROUND(b.bq_ngay, 2) AS bq_ngay_kenh
FROM theo_ngay n
JOIN binh_quan b ON b.channel_code = n.channel_code
WHERE n.so_lenh_tu_choi > 3 * b.bq_ngay
ORDER BY n.channel_code, n.transaction_date;

-- [aivb-k7-ngay-tu-choi-bat-thuong] wrong: gop_ca_lenh_bi_dao
WITH theo_ngay AS (
  SELECT channel_code, transaction_date, COUNT(*) AS so_lenh_tu_choi
  FROM core_payment_order
  WHERE payment_status <> 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2026-04-01'
  GROUP BY channel_code, transaction_date
),
binh_quan AS (
  SELECT channel_code, AVG(so_lenh_tu_choi) AS bq_ngay
  FROM theo_ngay
  GROUP BY channel_code
)
SELECT n.channel_code, n.transaction_date, n.so_lenh_tu_choi, ROUND(b.bq_ngay, 2) AS bq_ngay_kenh
FROM theo_ngay n
JOIN binh_quan b ON b.channel_code = n.channel_code
WHERE n.so_lenh_tu_choi > 3 * b.bq_ngay
ORDER BY n.channel_code, n.transaction_date;

-- [aivb-k8-thoi-gian-xu-ly-kyc] starter
WITH su_kien AS (
  SELECT customer_id, event_type, event_at,
         LAG(event_at) OVER (ORDER BY customer_id, event_sequence) AS thoi_diem_nop
  FROM core_customer_kyc_event
)
SELECT customer_id, thoi_diem_nop, event_at AS thoi_diem_quyet_dinh, event_type AS ket_qua,
       TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) AS so_gio_xu_ly
FROM su_kien
WHERE TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) > 144
ORDER BY so_gio_xu_ly DESC, customer_id;

-- [aivb-k8-thoi-gian-xu-ly-kyc] solution
WITH su_kien AS (
  SELECT customer_id, event_type, event_at,
         LAG(event_at) OVER (PARTITION BY customer_id, kyc_cycle_no ORDER BY event_sequence) AS thoi_diem_nop
  FROM core_customer_kyc_event
)
SELECT customer_id, thoi_diem_nop, event_at AS thoi_diem_quyet_dinh, event_type AS ket_qua,
       TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) AS so_gio_xu_ly
FROM su_kien
WHERE event_type IN ('KYC_APPROVED', 'KYC_REJECTED')
  AND TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) >= 144
ORDER BY so_gio_xu_ly DESC, customer_id;

-- [aivb-k8-thoi-gian-xu-ly-kyc] wrong: bo_moc_144_gio
WITH su_kien AS (
  SELECT customer_id, event_type, event_at,
         LAG(event_at) OVER (PARTITION BY customer_id, kyc_cycle_no ORDER BY event_sequence) AS thoi_diem_nop
  FROM core_customer_kyc_event
)
SELECT customer_id, thoi_diem_nop, event_at AS thoi_diem_quyet_dinh, event_type AS ket_qua,
       TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) AS so_gio_xu_ly
FROM su_kien
WHERE event_type IN ('KYC_APPROVED', 'KYC_REJECTED')
  AND TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) > 144
ORDER BY so_gio_xu_ly DESC, customer_id;

-- [aivb-k8-thoi-gian-xu-ly-kyc] wrong: lag_theo_thoi_gian_toan_bang
WITH su_kien AS (
  SELECT customer_id, event_type, event_at,
         LAG(event_at) OVER (ORDER BY event_at, kyc_event_id) AS thoi_diem_nop
  FROM core_customer_kyc_event
)
SELECT customer_id, thoi_diem_nop, event_at AS thoi_diem_quyet_dinh, event_type AS ket_qua,
       TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) AS so_gio_xu_ly
FROM su_kien
WHERE event_type IN ('KYC_APPROVED', 'KYC_REJECTED')
  AND TIMESTAMPDIFF(HOUR, thoi_diem_nop, event_at) >= 144
ORDER BY so_gio_xu_ly DESC, customer_id;

-- [aivb-k9-ho-so-duyet-khong-co-khoan-vay] starter
SELECT a.application_id, a.application_date, a.product_id, a.requested_amount
FROM core_loan_application a
LEFT JOIN core_loan_contract l ON l.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND l.loan_status <> 'SETTLED'
  AND l.loan_id IS NULL
ORDER BY a.application_date, a.application_id;

-- [aivb-k9-ho-so-duyet-khong-co-khoan-vay] solution
SELECT a.application_id, a.application_date, a.product_id, a.requested_amount
FROM core_loan_application a
LEFT JOIN core_loan_contract l ON l.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND l.loan_id IS NULL
ORDER BY a.application_date, a.application_id;

-- [aivb-k9-ho-so-duyet-khong-co-khoan-vay] wrong: dieu_kien_trang_thai_vao_on
SELECT a.application_id, a.application_date, a.product_id, a.requested_amount
FROM core_loan_application a
LEFT JOIN core_loan_contract l
  ON l.application_id = a.application_id AND l.loan_status <> 'SETTLED'
WHERE a.application_status = 'APPROVED'
  AND l.loan_id IS NULL
ORDER BY a.application_date, a.application_id;

-- ================================================================ MODULE 10 · QUERY PERFORMANCE

-- [aivb-p1-qr-thang-12-sargable] starter
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE channel_code = 'QR' AND payment_status = 'COMPLETED'
  AND YEAR(transaction_date) = 2026 AND MONTH(transaction_date) = 12
  AND DAY(transaction_date) >= 25;

-- [aivb-p1-qr-thang-12-sargable] solution
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE channel_code = 'QR' AND payment_status = 'COMPLETED'
  AND transaction_date >= '2026-12-25' AND transaction_date < '2027-01-01';

-- [aivb-p1-qr-thang-12-sargable] wrong: date_format_van_boc_cot
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE channel_code = 'QR' AND payment_status = 'COMPLETED'
  AND DATE_FORMAT(transaction_date, '%Y-%m-%d') >= '2026-12-25'
  AND DATE_FORMAT(transaction_date, '%Y-%m-%d') <= '2026-12-31';

-- [aivb-p1-qr-thang-12-sargable] wrong: thieu_ngay_31
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE channel_code = 'QR' AND payment_status = 'COMPLETED'
  AND transaction_date BETWEEN '2026-12-25' AND '2026-12-30';

-- [aivb-p2-so-but-toan-moi-tai-khoan] starter
SELECT a.account_id,
       (SELECT COUNT(*) FROM core_account_posting p
         WHERE p.account_id = a.account_id AND p.debit_credit = 'DEBIT') AS so_ghi_no,
       (SELECT COUNT(*) FROM core_account_posting p
         WHERE p.account_id = a.account_id AND p.debit_credit = 'CREDIT') AS so_ghi_co
FROM core_account a
WHERE a.account_status = 'DORMANT'
ORDER BY a.account_id;

-- [aivb-p2-so-but-toan-moi-tai-khoan] solution
SELECT a.account_id,
       COUNT(CASE WHEN p.debit_credit = 'DEBIT' THEN 1 END) AS so_ghi_no,
       COUNT(CASE WHEN p.debit_credit = 'CREDIT' THEN 1 END) AS so_ghi_co
FROM core_account a
LEFT JOIN core_account_posting p ON p.account_id = a.account_id
WHERE a.account_status = 'DORMANT'
GROUP BY a.account_id
ORDER BY a.account_id;

-- [aivb-p2-so-but-toan-moi-tai-khoan] wrong: inner_join_mat_tai_khoan
SELECT a.account_id,
       COUNT(CASE WHEN p.debit_credit = 'DEBIT' THEN 1 END) AS so_ghi_no,
       COUNT(CASE WHEN p.debit_credit = 'CREDIT' THEN 1 END) AS so_ghi_co
FROM core_account a
JOIN core_account_posting p ON p.account_id = a.account_id
WHERE a.account_status = 'DORMANT'
GROUP BY a.account_id
ORDER BY a.account_id;

-- [aivb-p3-tien-gui-lon-nhat-moi-chi-nhanh] starter
SELECT c.home_branch_id, d.deposit_id, d.principal
FROM core_deposit_contract d
JOIN core_contract c ON c.contract_id = d.contract_id
WHERE d.deposit_status = 'ACTIVE'
  AND d.principal = (SELECT MAX(d2.principal)
                     FROM core_deposit_contract d2
                     JOIN core_contract c2 ON c2.contract_id = d2.contract_id
                     WHERE d2.deposit_status = 'ACTIVE'
                       AND c2.home_branch_id = c.home_branch_id)
ORDER BY c.home_branch_id, d.deposit_id;

-- [aivb-p3-tien-gui-lon-nhat-moi-chi-nhanh] solution
WITH xep AS (
  SELECT c.home_branch_id, d.deposit_id, d.principal,
         MAX(d.principal) OVER (PARTITION BY c.home_branch_id) AS lon_nhat_chi_nhanh
  FROM core_deposit_contract d
  JOIN core_contract c ON c.contract_id = d.contract_id
  WHERE d.deposit_status = 'ACTIVE'
)
SELECT home_branch_id, deposit_id, principal
FROM xep
WHERE principal = lon_nhat_chi_nhanh
ORDER BY home_branch_id, deposit_id;

-- [aivb-p3-tien-gui-lon-nhat-moi-chi-nhanh] wrong: loc_trang_thai_sau_cua_so
WITH xep AS (
  SELECT c.home_branch_id, d.deposit_id, d.principal, d.deposit_status,
         MAX(d.principal) OVER (PARTITION BY c.home_branch_id) AS lon_nhat_chi_nhanh
  FROM core_deposit_contract d
  JOIN core_contract c ON c.contract_id = d.contract_id
)
SELECT home_branch_id, deposit_id, principal
FROM xep
WHERE principal = lon_nhat_chi_nhanh AND deposit_status = 'ACTIVE'
ORDER BY home_branch_id, deposit_id;

-- [aivb-p3-tien-gui-lon-nhat-moi-chi-nhanh] wrong: cua_so_khong_chia_chi_nhanh
WITH xep AS (
  SELECT c.home_branch_id, d.deposit_id, d.principal,
         MAX(d.principal) OVER () AS lon_nhat_chi_nhanh
  FROM core_deposit_contract d
  JOIN core_contract c ON c.contract_id = d.contract_id
  WHERE d.deposit_status = 'ACTIVE'
)
SELECT home_branch_id, deposit_id, principal
FROM xep
WHERE principal = lon_nhat_chi_nhanh
ORDER BY home_branch_id, deposit_id;

-- [aivb-p4-mom-tu-noi] starter
SELECT t.channel_code, t.thang, t.so_lenh,
       tr.so_lenh AS so_lenh_thang_truoc,
       ROUND(100 * (t.so_lenh - tr.so_lenh) / tr.so_lenh, 1) AS thay_doi_pct
FROM (SELECT channel_code, MONTH(transaction_date) AS thang, COUNT(*) AS so_lenh
      FROM core_payment_order
      WHERE transaction_type = 'TRANSFER' AND payment_status = 'COMPLETED'
        AND transaction_date >= '2026-07-01' AND transaction_date < '2027-01-01'
      GROUP BY channel_code, MONTH(transaction_date)) t
LEFT JOIN (SELECT channel_code, MONTH(transaction_date) AS thang, COUNT(*) AS so_lenh
           FROM core_payment_order
           WHERE transaction_type = 'TRANSFER' AND payment_status = 'COMPLETED'
             AND transaction_date >= '2026-07-01' AND transaction_date < '2027-01-01'
           GROUP BY channel_code, MONTH(transaction_date)) tr
  ON tr.channel_code = t.channel_code AND tr.thang = t.thang - 1
ORDER BY t.channel_code, t.thang;

-- [aivb-p4-mom-tu-noi] solution
WITH theo_thang AS (
  SELECT channel_code, MONTH(transaction_date) AS thang, COUNT(*) AS so_lenh
  FROM core_payment_order
  WHERE transaction_type = 'TRANSFER' AND payment_status = 'COMPLETED'
    AND transaction_date >= '2026-07-01' AND transaction_date < '2027-01-01'
  GROUP BY channel_code, MONTH(transaction_date)
),
co_thang_truoc AS (
  SELECT channel_code, thang, so_lenh,
         LAG(so_lenh) OVER (PARTITION BY channel_code ORDER BY thang) AS so_lenh_thang_truoc
  FROM theo_thang
)
SELECT channel_code, thang, so_lenh, so_lenh_thang_truoc,
       ROUND(100 * (so_lenh - so_lenh_thang_truoc) / so_lenh_thang_truoc, 1) AS thay_doi_pct
FROM co_thang_truoc
ORDER BY channel_code, thang;

-- [aivb-p4-mom-tu-noi] wrong: thieu_can_tren_nam
WITH theo_thang AS (
  SELECT channel_code, MONTH(transaction_date) AS thang, COUNT(*) AS so_lenh
  FROM core_payment_order
  WHERE transaction_type = 'TRANSFER' AND payment_status = 'COMPLETED'
    AND transaction_date >= '2026-07-01'
  GROUP BY channel_code, MONTH(transaction_date)
),
co_thang_truoc AS (
  SELECT channel_code, thang, so_lenh,
         LAG(so_lenh) OVER (PARTITION BY channel_code ORDER BY thang) AS so_lenh_thang_truoc
  FROM theo_thang
)
SELECT channel_code, thang, so_lenh, so_lenh_thang_truoc,
       ROUND(100 * (so_lenh - so_lenh_thang_truoc) / so_lenh_thang_truoc, 1) AS thay_doi_pct
FROM co_thang_truoc
ORDER BY channel_code, thang;

-- [aivb-p4-mom-tu-noi] wrong: lag_khong_chia_kenh
WITH theo_thang AS (
  SELECT channel_code, MONTH(transaction_date) AS thang, COUNT(*) AS so_lenh
  FROM core_payment_order
  WHERE transaction_type = 'TRANSFER' AND payment_status = 'COMPLETED'
    AND transaction_date >= '2026-07-01' AND transaction_date < '2027-01-01'
  GROUP BY channel_code, MONTH(transaction_date)
),
co_thang_truoc AS (
  SELECT channel_code, thang, so_lenh,
         LAG(so_lenh) OVER (ORDER BY channel_code, thang) AS so_lenh_thang_truoc
  FROM theo_thang
)
SELECT channel_code, thang, so_lenh, so_lenh_thang_truoc,
       ROUND(100 * (so_lenh - so_lenh_thang_truoc) / so_lenh_thang_truoc, 1) AS thay_doi_pct
FROM co_thang_truoc
ORDER BY channel_code, thang;

-- [aivb-p5-ho-so-chua-co-khoan-vay] starter
SELECT a.product_id,
       COUNT(*) AS so_ho_so,
       SUM(d.approved_amount) AS tong_duoc_duyet
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND a.application_id NOT IN (SELECT a2.application_id
                               FROM core_loan_application a2
                               JOIN core_loan_contract l ON l.application_id = a2.application_id)
GROUP BY a.product_id
ORDER BY a.product_id;

-- [aivb-p5-ho-so-chua-co-khoan-vay] solution
SELECT a.product_id,
       COUNT(*) AS so_ho_so,
       SUM(d.approved_amount) AS tong_duoc_duyet
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND NOT EXISTS (SELECT 1 FROM core_loan_contract l WHERE l.application_id = a.application_id)
GROUP BY a.product_id
ORDER BY a.product_id;

-- [aivb-p5-ho-so-chua-co-khoan-vay] wrong: quen_dieu_kien_duyet
SELECT a.product_id,
       COUNT(*) AS so_ho_so,
       SUM(d.approved_amount) AS tong_duoc_duyet
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE NOT EXISTS (SELECT 1 FROM core_loan_contract l WHERE l.application_id = a.application_id)
GROUP BY a.product_id
ORDER BY a.product_id;

-- [aivb-p5-ho-so-chua-co-khoan-vay] wrong: not_exists_khong_tuong_quan
SELECT a.product_id,
       COUNT(*) AS so_ho_so,
       SUM(d.approved_amount) AS tong_duoc_duyet
FROM core_loan_application a
JOIN core_credit_decision d ON d.application_id = a.application_id
WHERE a.application_status = 'APPROVED'
  AND NOT EXISTS (SELECT 1 FROM core_loan_contract l)
GROUP BY a.product_id
ORDER BY a.product_id;

-- [aivb-p6-ky-tra-no-2026-mot-lan-quet] starter
SELECT
  (SELECT COUNT(*) FROM core_loan_schedule WHERE schedule_status = 'PAID'
     AND due_date >= '2026-01-01' AND due_date < '2027-01-01') AS so_ky_da_tra,
  (SELECT COUNT(*) FROM core_loan_schedule WHERE schedule_status = 'DUE'
     AND due_date >= '2026-01-01' AND due_date < '2027-01-01') AS so_ky_den_han,
  (SELECT COUNT(*) FROM core_loan_schedule WHERE schedule_status = 'OVERDUE'
     AND due_date >= '2026-01-01' AND due_date < '2027-01-01') AS so_ky_qua_han,
  (SELECT COUNT(*) FROM core_loan_schedule WHERE schedule_status = 'CANCELLED'
     AND due_date >= '2026-01-01' AND due_date < '2027-01-01') AS so_ky_da_huy;

-- [aivb-p6-ky-tra-no-2026-mot-lan-quet] solution
SELECT COUNT(CASE WHEN schedule_status = 'PAID' THEN 1 END) AS so_ky_da_tra,
       COUNT(CASE WHEN schedule_status = 'DUE' THEN 1 END) AS so_ky_den_han,
       COUNT(CASE WHEN schedule_status = 'OVERDUE' THEN 1 END) AS so_ky_qua_han,
       COUNT(CASE WHEN schedule_status = 'CANCELLED' THEN 1 END) AS so_ky_da_huy
FROM core_loan_schedule
WHERE due_date >= '2026-01-01' AND due_date < '2027-01-01';

-- [aivb-p6-ky-tra-no-2026-mot-lan-quet] wrong: group_by_ra_nhieu_dong
SELECT schedule_status, COUNT(*) AS so_ky
FROM core_loan_schedule
WHERE due_date >= '2026-01-01' AND due_date < '2027-01-01'
GROUP BY schedule_status;

-- [aivb-p6-ky-tra-no-2026-mot-lan-quet] wrong: thieu_can_tren
SELECT COUNT(CASE WHEN schedule_status = 'PAID' THEN 1 END) AS so_ky_da_tra,
       COUNT(CASE WHEN schedule_status = 'DUE' THEN 1 END) AS so_ky_den_han,
       COUNT(CASE WHEN schedule_status = 'OVERDUE' THEN 1 END) AS so_ky_qua_han,
       COUNT(CASE WHEN schedule_status = 'CANCELLED' THEN 1 END) AS so_ky_da_huy
FROM core_loan_schedule
WHERE due_date >= '2026-01-01';

-- [aivb-p7-but-toan-tuan-cuoi-nam] solution
SELECT business_date AS ngay_lam_viec,
       COUNT(*) AS so_but_toan,
       SUM(amount) AS tong_so_tien
FROM core_account_posting
WHERE business_date >= '2026-12-25' AND business_date <= '2026-12-31'
GROUP BY business_date
ORDER BY business_date;

-- [aivb-p7-but-toan-tuan-cuoi-nam] wrong: thieu_can_tren
SELECT business_date AS ngay_lam_viec,
       COUNT(*) AS so_but_toan,
       SUM(amount) AS tong_so_tien
FROM core_account_posting
WHERE business_date >= '2026-12-25'
GROUP BY business_date
ORDER BY business_date;

-- [aivb-p7-but-toan-tuan-cuoi-nam] wrong: nham_ngay_gia_tri
SELECT value_date AS ngay_lam_viec,
       COUNT(*) AS so_but_toan,
       SUM(amount) AS tong_so_tien
FROM core_account_posting
WHERE value_date >= '2026-12-25' AND value_date <= '2026-12-31'
GROUP BY value_date
ORDER BY value_date;

-- [aivb-p8-lenh-tra-no-thang-12-ra-0] starter
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE transaction_type = 'LOAN_PAYMENT'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
  AND payment_status = 'COMPLETED';

-- [aivb-p8-lenh-tra-no-thang-12-ra-0] solution
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE transaction_type = 'LOAN_REPAYMENT'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
  AND payment_status = 'COMPLETED';

-- [aivb-p8-lenh-tra-no-thang-12-ra-0] wrong: like_bat_ca_giai_ngan
SELECT COUNT(*) AS so_lenh, SUM(amount) AS tong_tien
FROM core_payment_order
WHERE transaction_type LIKE 'LOAN%'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
  AND payment_status = 'COMPLETED';

-- [aivb-p9-lai-du-thu-cho-vay-theo-thang] starter
SELECT MONTH(a.accrual_date) AS thang, SUM(a.accrued_amount) AS lai_du_thu
FROM core_interest_accrual a
JOIN core_contract c ON c.contract_id = a.contract_id
WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
GROUP BY MONTH(a.accrual_date)
ORDER BY thang;

-- [aivb-p9-lai-du-thu-cho-vay-theo-thang] solution
SELECT MONTH(a.accrual_date) AS thang, SUM(a.accrued_amount) AS lai_du_thu
FROM core_interest_accrual a
JOIN core_loan_contract l ON l.contract_id = a.contract_id
WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
GROUP BY MONTH(a.accrual_date)
ORDER BY thang;

-- [aivb-p9-lai-du-thu-cho-vay-theo-thang] wrong: left_join_giu_moi_dong
SELECT MONTH(a.accrual_date) AS thang, SUM(a.accrued_amount) AS lai_du_thu
FROM core_interest_accrual a
LEFT JOIN core_loan_contract l ON l.contract_id = a.contract_id
WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
GROUP BY MONTH(a.accrual_date)
ORDER BY thang;

-- ================================================================ CASE

-- [aivb-c9-ra-soat-no-xau-2026.b1] solution
SELECT l.loan_id, l.loan_status,
       DATEDIFF('2026-12-31', MIN(s.due_date)) AS so_ngay_qua_han
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status = 'OVERDUE'
GROUP BY l.loan_id, l.loan_status
ORDER BY so_ngay_qua_han DESC, l.loan_id;

-- [aivb-c9-ra-soat-no-xau-2026.b1] wrong: ky_qua_han_muon_nhat
SELECT l.loan_id, l.loan_status,
       DATEDIFF('2026-12-31', MAX(s.due_date)) AS so_ngay_qua_han
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status = 'OVERDUE'
GROUP BY l.loan_id, l.loan_status
ORDER BY so_ngay_qua_han DESC, l.loan_id;

-- [aivb-c9-ra-soat-no-xau-2026.b2] solution
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
),
phan_loai AS (
  SELECT l.loan_id, l.outstanding,
         CASE WHEN COALESCE(q.so_ngay, 0) < 10 THEN 1
              WHEN q.so_ngay <= 90 THEN 2
              WHEN q.so_ngay <= 180 THEN 3
              WHEN q.so_ngay <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'WRITTEN_OFF' AND l.outstanding > 0
)
SELECT nhom_no, COUNT(*) AS so_khoan_vay, SUM(outstanding) AS du_no
FROM phan_loai
GROUP BY nhom_no
ORDER BY nhom_no;

-- [aivb-c9-ra-soat-no-xau-2026.b2] wrong: inner_join_mat_nhom_1
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
),
phan_loai AS (
  SELECT l.loan_id, l.outstanding,
         CASE WHEN q.so_ngay < 10 THEN 1
              WHEN q.so_ngay <= 90 THEN 2
              WHEN q.so_ngay <= 180 THEN 3
              WHEN q.so_ngay <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'WRITTEN_OFF' AND l.outstanding > 0
)
SELECT nhom_no, COUNT(*) AS so_khoan_vay, SUM(outstanding) AS du_no
FROM phan_loai
GROUP BY nhom_no
ORDER BY nhom_no;

-- [aivb-c9-ra-soat-no-xau-2026.b3] solution
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
),
phan_loai AS (
  SELECT l.loan_id, l.contract_id, l.outstanding,
         CASE WHEN COALESCE(q.so_ngay, 0) < 10 THEN 1
              WHEN q.so_ngay <= 90 THEN 2
              WHEN q.so_ngay <= 180 THEN 3
              WHEN q.so_ngay <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'WRITTEN_OFF' AND l.outstanding > 0
)
SELECT v.product_id,
       SUM(k.outstanding) AS du_no,
       SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) AS du_no_xau,
       ROUND(100 * SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) / SUM(k.outstanding), 2) AS ty_le_no_xau_pct
FROM phan_loai k
JOIN core_contract c ON c.contract_id = k.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
GROUP BY v.product_id
ORDER BY ty_le_no_xau_pct DESC, v.product_id;

-- [aivb-c9-ra-soat-no-xau-2026.b3] wrong: ty_le_theo_so_khoan
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
),
phan_loai AS (
  SELECT l.loan_id, l.contract_id, l.outstanding,
         CASE WHEN COALESCE(q.so_ngay, 0) < 10 THEN 1
              WHEN q.so_ngay <= 90 THEN 2
              WHEN q.so_ngay <= 180 THEN 3
              WHEN q.so_ngay <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'WRITTEN_OFF' AND l.outstanding > 0
)
SELECT v.product_id,
       SUM(k.outstanding) AS du_no,
       SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) AS du_no_xau,
       ROUND(100 * COUNT(CASE WHEN k.nhom_no >= 3 THEN 1 END) / COUNT(*), 2) AS ty_le_no_xau_pct
FROM phan_loai k
JOIN core_contract c ON c.contract_id = k.contract_id
JOIN ref_product_version v ON v.product_version_id = c.product_version_id
GROUP BY v.product_id
ORDER BY ty_le_no_xau_pct DESC, v.product_id;

-- [aivb-c9-ra-soat-no-xau-2026.b4] solution
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
),
phan_loai AS (
  SELECT l.loan_id, l.contract_id, l.outstanding,
         CASE WHEN COALESCE(q.so_ngay, 0) < 10 THEN 1
              WHEN q.so_ngay <= 90 THEN 2
              WHEN q.so_ngay <= 180 THEN 3
              WHEN q.so_ngay <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'WRITTEN_OFF' AND l.outstanding > 0
)
SELECT b.region,
       SUM(k.outstanding) AS du_no,
       SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) AS du_no_xau,
       ROUND(100 * SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) / SUM(k.outstanding), 2) AS ty_le_no_xau_pct
FROM phan_loai k
JOIN core_contract c ON c.contract_id = k.contract_id
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
GROUP BY b.region
ORDER BY ty_le_no_xau_pct DESC, b.region;

-- [aivb-c9-ra-soat-no-xau-2026.b4] wrong: chia_tong_du_no_toan_hang
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
),
phan_loai AS (
  SELECT l.loan_id, l.contract_id, l.outstanding,
         CASE WHEN COALESCE(q.so_ngay, 0) < 10 THEN 1
              WHEN q.so_ngay <= 90 THEN 2
              WHEN q.so_ngay <= 180 THEN 3
              WHEN q.so_ngay <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'WRITTEN_OFF' AND l.outstanding > 0
)
SELECT b.region,
       SUM(k.outstanding) AS du_no,
       SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) AS du_no_xau,
       ROUND(100 * SUM(CASE WHEN k.nhom_no >= 3 THEN k.outstanding ELSE 0 END) / SUM(SUM(k.outstanding)) OVER (), 2) AS ty_le_no_xau_pct
FROM phan_loai k
JOIN core_contract c ON c.contract_id = k.contract_id
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
GROUP BY b.region
ORDER BY ty_le_no_xau_pct DESC, b.region;

-- [aivb-c10-doi-soat-dong-tien-2026.b1] solution
SELECT o.payment_order_id, o.transaction_date, o.transaction_type, o.channel_code, o.amount
FROM core_payment_order o
WHERE o.payment_status = 'COMPLETED'
  AND o.transaction_date >= '2026-03-01' AND o.transaction_date < '2026-04-01'
  AND NOT EXISTS (SELECT 1 FROM core_account_posting p WHERE p.payment_order_id = o.payment_order_id)
ORDER BY o.payment_order_id;

-- [aivb-c10-doi-soat-dong-tien-2026.b1] wrong: chi_do_but_toan_ghi_no
-- Chỉ dò bút toán ghi Nợ: lệnh chỉ có bút toán ghi Có cũng bị coi là thiếu bút toán.
SELECT o.payment_order_id, o.transaction_date, o.transaction_type, o.channel_code, o.amount
FROM core_payment_order o
WHERE o.payment_status = 'COMPLETED'
  AND o.transaction_date >= '2026-03-01' AND o.transaction_date < '2026-04-01'
  AND NOT EXISTS (SELECT 1 FROM core_account_posting p
                   WHERE p.payment_order_id = o.payment_order_id AND p.debit_credit = 'DEBIT')
ORDER BY o.payment_order_id;

-- [aivb-c10-doi-soat-dong-tien-2026.b2] solution
SELECT transaction_date AS ngay,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE 0 END) AS tong_ghi_co,
       SUM(CASE WHEN debit_credit = 'DEBIT' THEN amount ELSE 0 END) AS tong_ghi_no,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE -amount END) AS dong_tien_rong
FROM core_account_posting
WHERE transaction_date >= '2026-03-01' AND transaction_date < '2026-04-01'
GROUP BY transaction_date
ORDER BY ngay;

-- [aivb-c10-doi-soat-dong-tien-2026.b2] wrong: bo_sot_ngay_cuoi_thang
-- Bỏ sót ngày 31/3: cận trên viết thành trước ngày cuối tháng.
SELECT transaction_date AS ngay,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE 0 END) AS tong_ghi_co,
       SUM(CASE WHEN debit_credit = 'DEBIT' THEN amount ELSE 0 END) AS tong_ghi_no,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE -amount END) AS dong_tien_rong
FROM core_account_posting
WHERE transaction_date >= '2026-03-01' AND transaction_date < '2026-03-31'
GROUP BY transaction_date
ORDER BY ngay;

-- [aivb-c10-doi-soat-dong-tien-2026.b3] solution
SELECT o.payment_status,
       COUNT(*) AS so_but_toan,
       SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE p.transaction_date >= '2026-03-01' AND p.transaction_date < '2026-04-01'
GROUP BY o.payment_status
ORDER BY o.payment_status;

-- [aivb-c10-doi-soat-dong-tien-2026.b3] wrong: cong_tran_so_tien
SELECT o.payment_status,
       COUNT(*) AS so_but_toan,
       SUM(p.amount) AS dong_tien_rong
FROM core_account_posting p
JOIN core_payment_order o ON o.payment_order_id = p.payment_order_id
WHERE p.transaction_date >= '2026-03-01' AND p.transaction_date < '2026-04-01'
GROUP BY o.payment_status
ORDER BY o.payment_status;

-- [aivb-c10-doi-soat-dong-tien-2026.b4] solution
SELECT b.region, c.home_branch_id,
       ROUND(SUM(CASE WHEN p.debit_credit = 'CREDIT' THEN p.amount ELSE -p.amount END) / 1000000, 0) AS dong_tien_rong_trieu
FROM core_account_posting p
JOIN core_account a ON a.account_id = p.account_id
JOIN core_contract c ON c.contract_id = a.contract_id
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
WHERE p.transaction_date >= '2026-03-01' AND p.transaction_date < '2026-04-01'
GROUP BY b.region, c.home_branch_id
ORDER BY dong_tien_rong_trieu DESC, c.home_branch_id;

-- [aivb-c10-doi-soat-dong-tien-2026.b4] wrong: cong_tran_so_tien
SELECT b.region, c.home_branch_id,
       ROUND(SUM(p.amount) / 1000000, 0) AS dong_tien_rong_trieu
FROM core_account_posting p
JOIN core_account a ON a.account_id = p.account_id
JOIN core_contract c ON c.contract_id = a.contract_id
JOIN ref_branch b ON b.ref_branch_id = c.home_branch_id
WHERE p.transaction_date >= '2026-03-01' AND p.transaction_date < '2026-04-01'
GROUP BY b.region, c.home_branch_id
ORDER BY dong_tien_rong_trieu DESC, c.home_branch_id;
