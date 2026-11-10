-- solution.sql: GÓI 4 bộ AIV Bank (aivb), MySQL 8.0. Module 7 CTE & Set Operations, Module 8 Window Functions, case c7, c8.
-- Chạy trên aivb (public) và aivb_hidden_1 (hidden-1). Mỗi khối một truy vấn, kết thúc bằng ;

-- ################################################################ MODULE 7 · CTE & SET OPERATIONS

-- [aivb-t1-pheu-ho-so-vay-2025] solution
WITH hs AS (
  SELECT a.application_id, d.decision_status, l.loan_id, l.loan_status
  FROM core_loan_application a
  JOIN core_credit_decision d ON d.application_id = a.application_id
  LEFT JOIN core_loan_contract l ON l.application_id = a.application_id
  WHERE a.application_date >= '2025-01-01' AND a.application_date < '2026-01-01'
), dem AS (
  SELECT COUNT(*) AS n1,
         COUNT(CASE WHEN decision_status = 'APPROVED' THEN 1 END) AS n2,
         COUNT(CASE WHEN decision_status = 'APPROVED' AND loan_id IS NOT NULL THEN 1 END) AS n3,
         COUNT(CASE WHEN decision_status = 'APPROVED' AND loan_status = 'SETTLED' THEN 1 END) AS n4
  FROM hs
)
SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, n1 AS so_ho_so, NULL AS ty_le_chuyen_pct FROM dem
UNION ALL SELECT 2, 'duoc_duyet', n2, ROUND(100 * n2 / n1, 2) FROM dem
UNION ALL SELECT 3, 'da_giai_ngan', n3, ROUND(100 * n3 / n2, 2) FROM dem
UNION ALL SELECT 4, 'da_tat_toan', n4, ROUND(100 * n4 / n3, 2) FROM dem
ORDER BY buoc;

-- [aivb-t1-pheu-ho-so-vay-2025] wrong: ty_le_so_voi_buoc_dau
-- Tỷ lệ chia cho bước 1 thay vì bước liền trước (rớt ở public).
WITH hs AS (
  SELECT a.application_id, d.decision_status, l.loan_id, l.loan_status
  FROM core_loan_application a
  JOIN core_credit_decision d ON d.application_id = a.application_id
  LEFT JOIN core_loan_contract l ON l.application_id = a.application_id
  WHERE a.application_date >= '2025-01-01' AND a.application_date < '2026-01-01'
), dem AS (
  SELECT COUNT(*) AS n1,
         COUNT(CASE WHEN decision_status = 'APPROVED' THEN 1 END) AS n2,
         COUNT(CASE WHEN decision_status = 'APPROVED' AND loan_id IS NOT NULL THEN 1 END) AS n3,
         COUNT(CASE WHEN decision_status = 'APPROVED' AND loan_status = 'SETTLED' THEN 1 END) AS n4
  FROM hs
)
SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, n1 AS so_ho_so, NULL AS ty_le_chuyen_pct FROM dem
UNION ALL SELECT 2, 'duoc_duyet', n2, ROUND(100 * n2 / n1, 2) FROM dem
UNION ALL SELECT 3, 'da_giai_ngan', n3, ROUND(100 * n3 / n1, 2) FROM dem
UNION ALL SELECT 4, 'da_tat_toan', n4, ROUND(100 * n4 / n1, 2) FROM dem
ORDER BY buoc;

-- [aivb-t1-pheu-ho-so-vay-2025] wrong: thieu_can_tren_nam
-- Chỉ có cận dưới nên gồm cả hồ sơ năm 2026 (rớt ở public).
WITH hs AS (
  SELECT a.application_id, d.decision_status, l.loan_id, l.loan_status
  FROM core_loan_application a
  JOIN core_credit_decision d ON d.application_id = a.application_id
  LEFT JOIN core_loan_contract l ON l.application_id = a.application_id
  WHERE a.application_date >= '2025-01-01'
), dem AS (
  SELECT COUNT(*) AS n1,
         COUNT(CASE WHEN decision_status = 'APPROVED' THEN 1 END) AS n2,
         COUNT(CASE WHEN decision_status = 'APPROVED' AND loan_id IS NOT NULL THEN 1 END) AS n3,
         COUNT(CASE WHEN decision_status = 'APPROVED' AND loan_status = 'SETTLED' THEN 1 END) AS n4
  FROM hs
)
SELECT 1 AS buoc, 'nop_ho_so' AS ten_buoc, n1 AS so_ho_so, NULL AS ty_le_chuyen_pct FROM dem
UNION ALL SELECT 2, 'duoc_duyet', n2, ROUND(100 * n2 / n1, 2) FROM dem
UNION ALL SELECT 3, 'da_giai_ngan', n3, ROUND(100 * n3 / n2, 2) FROM dem
UNION ALL SELECT 4, 'da_tat_toan', n4, ROUND(100 * n4 / n3, 2) FROM dem
ORDER BY buoc;

-- [aivb-t2-doi-soat-lenh-but-toan] solution
WITH lenh AS (
  SELECT payment_order_id, payment_status
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
)
SELECT 'lenh_thanh_cong_khong_co_but_toan' AS loai, l.payment_status, COUNT(*) AS so_lenh, 0 AS so_but_toan
FROM lenh l
WHERE l.payment_status = 'COMPLETED'
  AND NOT EXISTS (SELECT 1 FROM core_account_posting p WHERE p.payment_order_id = l.payment_order_id)
GROUP BY l.payment_status
UNION ALL
SELECT 'but_toan_cua_lenh_khong_thanh_cong', l.payment_status, COUNT(DISTINCT l.payment_order_id), COUNT(*)
FROM lenh l
JOIN core_account_posting p ON p.payment_order_id = l.payment_order_id
WHERE l.payment_status <> 'COMPLETED'
GROUP BY l.payment_status
ORDER BY loai, payment_status;

-- [aivb-t2-doi-soat-lenh-but-toan] wrong: chi_kiem_lenh_bi_dao
-- Cho rằng lệnh bị từ chối không thể có bút toán nên chỉ kiểm lệnh bị đảo: mất dòng REJECTED (rớt ở public).
WITH lenh AS (
  SELECT payment_order_id, payment_status
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
)
SELECT 'lenh_thanh_cong_khong_co_but_toan' AS loai, l.payment_status, COUNT(*) AS so_lenh, 0 AS so_but_toan
FROM lenh l
WHERE l.payment_status = 'COMPLETED'
  AND NOT EXISTS (SELECT 1 FROM core_account_posting p WHERE p.payment_order_id = l.payment_order_id)
GROUP BY l.payment_status
UNION ALL
SELECT 'but_toan_cua_lenh_khong_thanh_cong', l.payment_status, COUNT(DISTINCT l.payment_order_id), COUNT(*)
FROM lenh l
JOIN core_account_posting p ON p.payment_order_id = l.payment_order_id
WHERE l.payment_status = 'REVERSED'
GROUP BY l.payment_status
ORDER BY loai, payment_status;

-- [aivb-t2-doi-soat-lenh-but-toan] wrong: inner_join_tim_dong_khong_co_cap
-- Tìm lệnh không có bút toán bằng JOIN rồi lọc IS NULL: không bao giờ ra dòng, nhóm thứ nhất biến mất (rớt ở public).
WITH lenh AS (
  SELECT payment_order_id, payment_status
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
)
SELECT 'lenh_thanh_cong_khong_co_but_toan' AS loai, l.payment_status, COUNT(*) AS so_lenh, 0 AS so_but_toan
FROM lenh l
JOIN core_account_posting p ON p.payment_order_id = l.payment_order_id
WHERE l.payment_status = 'COMPLETED' AND p.posting_id IS NULL
GROUP BY l.payment_status
UNION ALL
SELECT 'but_toan_cua_lenh_khong_thanh_cong', l.payment_status, COUNT(DISTINCT l.payment_order_id), COUNT(*)
FROM lenh l
JOIN core_account_posting p ON p.payment_order_id = l.payment_order_id
WHERE l.payment_status <> 'COMPLETED'
GROUP BY l.payment_status
ORDER BY loai, payment_status;

-- [aivb-t3-phan-nhom-khach-giao-dich] solution
WITH bt AS (
  SELECT account_id, COUNT(*) AS so_bt
  FROM core_account_posting
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY account_id
), kh AS (
  SELECT c.customer_id, COALESCE(SUM(bt.so_bt), 0) AS so_bt
  FROM core_customer c
  LEFT JOIN core_account_party ap ON ap.party_id = c.party_id AND ap.role_code = 'PRIMARY_OWNER'
  LEFT JOIN bt ON bt.account_id = ap.account_id
  GROUP BY c.customer_id
), nhom AS (
  SELECT 1 AS thu_tu, 'khong_giao_dich' AS nhom_khach, 0 AS tu, 0 AS den
  UNION ALL SELECT 2, 'tu_1_den_50', 1, 50
  UNION ALL SELECT 3, 'tu_51_den_200', 51, 200
  UNION ALL SELECT 4, 'tren_200', 201, 999999999
)
SELECT n.thu_tu, n.nhom_khach, COUNT(kh.customer_id) AS so_khach
FROM nhom n
LEFT JOIN kh ON kh.so_bt BETWEEN n.tu AND n.den
GROUP BY n.thu_tu, n.nhom_khach
ORDER BY n.thu_tu;

-- [aivb-t3-phan-nhom-khach-giao-dich] wrong: inner_join_mat_khach_khong_giao_dich
-- Nối thẳng với bút toán nên khách không có bút toán năm 2026 biến mất (rớt ở public).
WITH kh AS (
  SELECT c.customer_id, COUNT(*) AS so_bt
  FROM core_customer c
  JOIN core_account_party ap ON ap.party_id = c.party_id AND ap.role_code = 'PRIMARY_OWNER'
  JOIN core_account_posting p ON p.account_id = ap.account_id
  WHERE p.transaction_date >= '2026-01-01' AND p.transaction_date < '2027-01-01'
  GROUP BY c.customer_id
), nhom AS (
  SELECT 1 AS thu_tu, 'khong_giao_dich' AS nhom_khach, 0 AS tu, 0 AS den
  UNION ALL SELECT 2, 'tu_1_den_50', 1, 50
  UNION ALL SELECT 3, 'tu_51_den_200', 51, 200
  UNION ALL SELECT 4, 'tren_200', 201, 999999999
)
SELECT n.thu_tu, n.nhom_khach, COUNT(kh.customer_id) AS so_khach
FROM nhom n
LEFT JOIN kh ON kh.so_bt BETWEEN n.tu AND n.den
GROUP BY n.thu_tu, n.nhom_khach
ORDER BY n.thu_tu;

-- [aivb-t3-phan-nhom-khach-giao-dich] wrong: moi_vai_tro_tai_khoan
-- Không lọc chủ tài khoản: bút toán của tài khoản đồng sở hữu, uỷ quyền cũng tính cho khách (rớt ở public).
WITH bt AS (
  SELECT account_id, COUNT(*) AS so_bt
  FROM core_account_posting
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY account_id
), kh AS (
  SELECT c.customer_id, COALESCE(SUM(bt.so_bt), 0) AS so_bt
  FROM core_customer c
  LEFT JOIN core_account_party ap ON ap.party_id = c.party_id
  LEFT JOIN bt ON bt.account_id = ap.account_id
  GROUP BY c.customer_id
), nhom AS (
  SELECT 1 AS thu_tu, 'khong_giao_dich' AS nhom_khach, 0 AS tu, 0 AS den
  UNION ALL SELECT 2, 'tu_1_den_50', 1, 50
  UNION ALL SELECT 3, 'tu_51_den_200', 51, 200
  UNION ALL SELECT 4, 'tren_200', 201, 999999999
)
SELECT n.thu_tu, n.nhom_khach, COUNT(kh.customer_id) AS so_khach
FROM nhom n
LEFT JOIN kh ON kh.so_bt BETWEEN n.tu AND n.den
GROUP BY n.thu_tu, n.nhom_khach
ORDER BY n.thu_tu;

-- [aivb-t4-du-no-theo-nhom-no] solution
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay_qua_han
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
), khoan AS (
  SELECT l.loan_id, l.outstanding,
         CASE WHEN q.so_ngay_qua_han IS NULL OR q.so_ngay_qua_han < 10 THEN 1
              WHEN q.so_ngay_qua_han <= 90 THEN 2
              WHEN q.so_ngay_qua_han <= 180 THEN 3
              WHEN q.so_ngay_qua_han <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
), nhom AS (
  SELECT 1 AS nhom_no UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
)
SELECT n.nhom_no,
       COUNT(k.loan_id) AS so_khoan_vay,
       ROUND(COALESCE(SUM(k.outstanding), 0) / 1000000, 0) AS du_no_trieu_dong,
       ROUND(100 * COALESCE(SUM(k.outstanding), 0) / (SELECT SUM(outstanding) FROM khoan), 2) AS ty_trong_du_no_pct
FROM nhom n
LEFT JOIN khoan k ON k.nhom_no = n.nhom_no
GROUP BY n.nhom_no
ORDER BY n.nhom_no;

-- [aivb-t4-du-no-theo-nhom-no] wrong: ky_qua_han_muon_nhat
-- Lấy kỳ quá hạn muộn nhất nên số ngày quá hạn ngắn đi (rớt ở public).
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MAX(due_date)) AS so_ngay_qua_han
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
), khoan AS (
  SELECT l.loan_id, l.outstanding,
         CASE WHEN q.so_ngay_qua_han IS NULL OR q.so_ngay_qua_han < 10 THEN 1
              WHEN q.so_ngay_qua_han <= 90 THEN 2
              WHEN q.so_ngay_qua_han <= 180 THEN 3
              WHEN q.so_ngay_qua_han <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
), nhom AS (
  SELECT 1 AS nhom_no UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
)
SELECT n.nhom_no,
       COUNT(k.loan_id) AS so_khoan_vay,
       ROUND(COALESCE(SUM(k.outstanding), 0) / 1000000, 0) AS du_no_trieu_dong,
       ROUND(100 * COALESCE(SUM(k.outstanding), 0) / (SELECT SUM(outstanding) FROM khoan), 2) AS ty_trong_du_no_pct
FROM nhom n
LEFT JOIN khoan k ON k.nhom_no = n.nhom_no
GROUP BY n.nhom_no
ORDER BY n.nhom_no;

-- [aivb-t4-du-no-theo-nhom-no] wrong: gom_khoan_da_xu_ly_rui_ro
-- Gồm cả khoản vay đã xử lý rủi ro (dư nợ 0) nên số khoản nhóm nợ xấu tăng (rớt ở public).
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay_qua_han
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
), khoan AS (
  SELECT l.loan_id, l.outstanding,
         CASE WHEN q.so_ngay_qua_han IS NULL OR q.so_ngay_qua_han < 10 THEN 1
              WHEN q.so_ngay_qua_han <= 90 THEN 2
              WHEN q.so_ngay_qua_han <= 180 THEN 3
              WHEN q.so_ngay_qua_han <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status <> 'SETTLED'
), nhom AS (
  SELECT 1 AS nhom_no UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
)
SELECT n.nhom_no,
       COUNT(k.loan_id) AS so_khoan_vay,
       ROUND(COALESCE(SUM(k.outstanding), 0) / 1000000, 0) AS du_no_trieu_dong,
       ROUND(100 * COALESCE(SUM(k.outstanding), 0) / (SELECT SUM(outstanding) FROM khoan), 2) AS ty_trong_du_no_pct
FROM nhom n
LEFT JOIN khoan k ON k.nhom_no = n.nhom_no
GROUP BY n.nhom_no
ORDER BY n.nhom_no;

-- [aivb-t4-du-no-theo-nhom-no] wrong: chi_gom_nhom_co_khoan_vay
-- Gom nhóm thẳng trên khoản vay: nhóm không có khoản nào không có dòng (rớt ở public, nhóm 5).
WITH qua_han AS (
  SELECT loan_id, DATEDIFF('2026-12-31', MIN(due_date)) AS so_ngay_qua_han
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
  GROUP BY loan_id
), khoan AS (
  SELECT l.loan_id, l.outstanding,
         CASE WHEN q.so_ngay_qua_han IS NULL OR q.so_ngay_qua_han < 10 THEN 1
              WHEN q.so_ngay_qua_han <= 90 THEN 2
              WHEN q.so_ngay_qua_han <= 180 THEN 3
              WHEN q.so_ngay_qua_han <= 360 THEN 4
              ELSE 5 END AS nhom_no
  FROM core_loan_contract l
  LEFT JOIN qua_han q ON q.loan_id = l.loan_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
)
SELECT nhom_no,
       COUNT(*) AS so_khoan_vay,
       ROUND(SUM(outstanding) / 1000000, 0) AS du_no_trieu_dong,
       ROUND(100 * SUM(outstanding) / (SELECT SUM(outstanding) FROM khoan), 2) AS ty_trong_du_no_pct
FROM khoan
GROUP BY nhom_no
ORDER BY nhom_no;

-- [aivb-t5-kenh-loai-giao-dich-ty-le-hoan] solution
WITH lenh AS (
  SELECT channel_code, transaction_type, payment_status
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
    AND transaction_type IN ('TRANSFER', 'QR_PAY', 'BILLPAY', 'POS_PAY')
), bang AS (
  SELECT 1 AS thu_tu, channel_code AS kenh,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'TRANSFER' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'TRANSFER' THEN 1 END), 0), 2) AS transfer_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'QR_PAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'QR_PAY' THEN 1 END), 0), 2) AS qr_pay_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'BILLPAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'BILLPAY' THEN 1 END), 0), 2) AS billpay_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'POS_PAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'POS_PAY' THEN 1 END), 0), 2) AS pos_pay_pct
  FROM lenh
  GROUP BY channel_code
  UNION ALL
  SELECT 2, 'TONG',
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'TRANSFER' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'TRANSFER' THEN 1 END), 0), 2),
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'QR_PAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'QR_PAY' THEN 1 END), 0), 2),
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'BILLPAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'BILLPAY' THEN 1 END), 0), 2),
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'POS_PAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'POS_PAY' THEN 1 END), 0), 2)
  FROM lenh
)
SELECT kenh, transfer_pct, qr_pay_pct, billpay_pct, pos_pay_pct
FROM bang
ORDER BY thu_tu, kenh;

-- [aivb-t5-kenh-loai-giao-dich-ty-le-hoan] wrong: dong_tong_la_trung_binh_ty_le
-- Dòng tổng lấy trung bình cộng tỷ lệ của các kênh, không tính lại từ số lệnh (rớt ở public).
WITH lenh AS (
  SELECT channel_code, transaction_type, payment_status
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
    AND transaction_type IN ('TRANSFER', 'QR_PAY', 'BILLPAY', 'POS_PAY')
), kenh AS (
  SELECT 1 AS thu_tu, channel_code AS kenh,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'TRANSFER' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'TRANSFER' THEN 1 END), 0), 2) AS transfer_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'QR_PAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'QR_PAY' THEN 1 END), 0), 2) AS qr_pay_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'BILLPAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'BILLPAY' THEN 1 END), 0), 2) AS billpay_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'POS_PAY' AND payment_status = 'REVERSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'POS_PAY' THEN 1 END), 0), 2) AS pos_pay_pct
  FROM lenh
  GROUP BY channel_code
)
SELECT kenh, transfer_pct, qr_pay_pct, billpay_pct, pos_pay_pct FROM (
  SELECT thu_tu, kenh, transfer_pct, qr_pay_pct, billpay_pct, pos_pay_pct FROM kenh
  UNION ALL
  SELECT 2, 'TONG', ROUND(AVG(transfer_pct), 2), ROUND(AVG(qr_pay_pct), 2), ROUND(AVG(billpay_pct), 2), ROUND(AVG(pos_pay_pct), 2) FROM kenh
) x
ORDER BY thu_tu, kenh;

-- [aivb-t5-kenh-loai-giao-dich-ty-le-hoan] wrong: gop_bi_tu_choi_vao_bi_dao
-- Tính cả lệnh bị từ chối vào tử số (rớt ở public).
WITH lenh AS (
  SELECT channel_code, transaction_type, payment_status
  FROM core_payment_order
  WHERE transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
    AND transaction_type IN ('TRANSFER', 'QR_PAY', 'BILLPAY', 'POS_PAY')
), bang AS (
  SELECT 1 AS thu_tu, channel_code AS kenh,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'TRANSFER' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'TRANSFER' THEN 1 END), 0), 2) AS transfer_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'QR_PAY' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'QR_PAY' THEN 1 END), 0), 2) AS qr_pay_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'BILLPAY' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'BILLPAY' THEN 1 END), 0), 2) AS billpay_pct,
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'POS_PAY' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'POS_PAY' THEN 1 END), 0), 2) AS pos_pay_pct
  FROM lenh
  GROUP BY channel_code
  UNION ALL
  SELECT 2, 'TONG',
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'TRANSFER' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'TRANSFER' THEN 1 END), 0), 2),
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'QR_PAY' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'QR_PAY' THEN 1 END), 0), 2),
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'BILLPAY' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'BILLPAY' THEN 1 END), 0), 2),
         ROUND(100 * COUNT(CASE WHEN transaction_type = 'POS_PAY' AND payment_status <> 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN transaction_type = 'POS_PAY' THEN 1 END), 0), 2)
  FROM lenh
)
SELECT kenh, transfer_pct, qr_pay_pct, billpay_pct, pos_pay_pct
FROM bang
ORDER BY thu_tu, kenh;

-- [aivb-t7-khach-co-san-pham] starter
WITH co_tien_gui AS (
  SELECT ap.party_id
  FROM core_deposit_contract d
  JOIN core_account_party ap ON ap.account_id = d.settlement_account_id AND ap.role_code = 'PRIMARY_OWNER'
  WHERE d.deposit_status IN ('ACTIVE', 'RENEWED')
), co_khoan_vay AS (
  SELECT a.party_id
  FROM core_loan_contract l
  JOIN core_loan_application a ON a.application_id = l.application_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
)
SELECT COUNT(*) AS so_chu_the
FROM (
  SELECT party_id FROM co_tien_gui
  UNION ALL
  SELECT party_id FROM co_khoan_vay
) x;

-- [aivb-t7-khach-co-san-pham] solution
WITH co_tien_gui AS (
  SELECT ap.party_id
  FROM core_deposit_contract d
  JOIN core_account_party ap ON ap.account_id = d.settlement_account_id AND ap.role_code = 'PRIMARY_OWNER'
  WHERE d.deposit_status IN ('ACTIVE', 'RENEWED')
), co_khoan_vay AS (
  SELECT a.party_id
  FROM core_loan_contract l
  JOIN core_loan_application a ON a.application_id = l.application_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
)
SELECT COUNT(*) AS so_chu_the
FROM (
  SELECT party_id FROM co_tien_gui
  UNION
  SELECT party_id FROM co_khoan_vay
) x;

-- [aivb-t7-khach-co-san-pham] wrong: distinct_tung_nhanh_van_union_all
-- Bỏ trùng trong từng danh sách nhưng vẫn UNION ALL: chủ thể vừa gửi tiền vừa vay bị đếm hai lần (rớt ở public).
WITH co_tien_gui AS (
  SELECT DISTINCT ap.party_id
  FROM core_deposit_contract d
  JOIN core_account_party ap ON ap.account_id = d.settlement_account_id AND ap.role_code = 'PRIMARY_OWNER'
  WHERE d.deposit_status IN ('ACTIVE', 'RENEWED')
), co_khoan_vay AS (
  SELECT DISTINCT a.party_id
  FROM core_loan_contract l
  JOIN core_loan_application a ON a.application_id = l.application_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
)
SELECT COUNT(*) AS so_chu_the
FROM (
  SELECT party_id FROM co_tien_gui
  UNION ALL
  SELECT party_id FROM co_khoan_vay
) x;

-- [aivb-t7-khach-co-san-pham] wrong: moi_vai_tro_tai_khoan
-- Không lọc chủ tài khoản: người được uỷ quyền, người chỉ xem cũng thành người có tiền gửi (rớt ở public).
WITH co_tien_gui AS (
  SELECT ap.party_id
  FROM core_deposit_contract d
  JOIN core_account_party ap ON ap.account_id = d.settlement_account_id
  WHERE d.deposit_status IN ('ACTIVE', 'RENEWED')
), co_khoan_vay AS (
  SELECT a.party_id
  FROM core_loan_contract l
  JOIN core_loan_application a ON a.application_id = l.application_id
  WHERE l.loan_status IN ('ACTIVE', 'DELINQUENT', 'RESTRUCTURED')
)
SELECT COUNT(*) AS so_chu_the
FROM (
  SELECT party_id FROM co_tien_gui
  UNION
  SELECT party_id FROM co_khoan_vay
) x;

-- [aivb-t8-giai-ngan-so-voi-nam-truoc] starter
WITH nam AS (
  SELECT YEAR(disbursement_date) AS nam, SUM(principal) AS tong_goc
  FROM core_loan_contract
  GROUP BY YEAR(disbursement_date)
)
SELECT nay.nam,
       ROUND(nay.tong_goc / 1000000000, 2) AS cho_vay_moi_ty_dong,
       ROUND(100 * (nay.tong_goc - truoc.tong_goc) / truoc.tong_goc, 2) AS tang_truong_pct
FROM nam nay
JOIN nam truoc ON truoc.nam = nay.nam + 1
ORDER BY nay.nam;

-- [aivb-t8-giai-ngan-so-voi-nam-truoc] solution
WITH nam AS (
  SELECT YEAR(disbursement_date) AS nam, SUM(principal) AS tong_goc
  FROM core_loan_contract
  GROUP BY YEAR(disbursement_date)
)
SELECT nay.nam,
       ROUND(nay.tong_goc / 1000000000, 2) AS cho_vay_moi_ty_dong,
       ROUND(100 * (nay.tong_goc - truoc.tong_goc) / truoc.tong_goc, 2) AS tang_truong_pct
FROM nam nay
LEFT JOIN nam truoc ON truoc.nam = nay.nam - 1
ORDER BY nay.nam;

-- [aivb-t8-giai-ngan-so-voi-nam-truoc] wrong: dung_chieu_nhung_inner_join
-- Sửa chiều nối nhưng giữ JOIN: năm 2020 không có năm trước nên bị loại (rớt ở public).
WITH nam AS (
  SELECT YEAR(disbursement_date) AS nam, SUM(principal) AS tong_goc
  FROM core_loan_contract
  GROUP BY YEAR(disbursement_date)
)
SELECT nay.nam,
       ROUND(nay.tong_goc / 1000000000, 2) AS cho_vay_moi_ty_dong,
       ROUND(100 * (nay.tong_goc - truoc.tong_goc) / truoc.tong_goc, 2) AS tang_truong_pct
FROM nam nay
JOIN nam truoc ON truoc.nam = nay.nam - 1
ORDER BY nay.nam;

-- [aivb-t8-giai-ngan-so-voi-nam-truoc] wrong: left_join_van_nguoc_chieu
-- Đổi sang LEFT JOIN nhưng giữ chiều nối cũ: mỗi năm bị so với năm sau (rớt ở public).
WITH nam AS (
  SELECT YEAR(disbursement_date) AS nam, SUM(principal) AS tong_goc
  FROM core_loan_contract
  GROUP BY YEAR(disbursement_date)
)
SELECT nay.nam,
       ROUND(nay.tong_goc / 1000000000, 2) AS cho_vay_moi_ty_dong,
       ROUND(100 * (nay.tong_goc - truoc.tong_goc) / truoc.tong_goc, 2) AS tang_truong_pct
FROM nam nay
LEFT JOIN nam truoc ON truoc.nam = nay.nam + 1
ORDER BY nay.nam;

-- [aivb-t9-qua-han-nhung-khong-delinquent] starter
SELECT l.loan_status,
       COUNT(*) AS so_khoan_vay,
       SUM(l.outstanding) AS du_no
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status = 'OVERDUE' AND l.loan_status <> 'DELINQUENT'
GROUP BY l.loan_status
ORDER BY l.loan_status;

-- [aivb-t9-qua-han-nhung-khong-delinquent] solution
WITH co_qua_han AS (
  SELECT DISTINCT loan_id
  FROM core_loan_schedule
  WHERE schedule_status = 'OVERDUE'
)
SELECT l.loan_status,
       COUNT(*) AS so_khoan_vay,
       SUM(l.outstanding) AS du_no
FROM core_loan_contract l
JOIN co_qua_han q ON q.loan_id = l.loan_id
WHERE l.loan_status <> 'DELINQUENT'
GROUP BY l.loan_status
ORDER BY l.loan_status;

-- [aivb-t9-qua-han-nhung-khong-delinquent] wrong: chi_sua_count_distinct
-- Đếm đúng số khoản nhưng dư nợ vẫn bị cộng một lần cho mỗi kỳ quá hạn (rớt ở public).
SELECT l.loan_status,
       COUNT(DISTINCT l.loan_id) AS so_khoan_vay,
       SUM(l.outstanding) AS du_no
FROM core_loan_contract l
JOIN core_loan_schedule s ON s.loan_id = l.loan_id
WHERE s.schedule_status = 'OVERDUE' AND l.loan_status <> 'DELINQUENT'
GROUP BY l.loan_status
ORDER BY l.loan_status;

-- ################################################################ MODULE 8 · WINDOW FUNCTIONS

-- [aivb-f1-top-3-khoan-vay-moi-chi-nhanh] solution
WITH xep AS (
  SELECT c.home_branch_id, l.loan_id, l.outstanding,
         ROW_NUMBER() OVER (PARTITION BY c.home_branch_id ORDER BY l.outstanding DESC, l.loan_id) AS hang
  FROM core_loan_contract l
  JOIN core_contract c ON c.contract_id = l.contract_id
  WHERE l.loan_status = 'ACTIVE'
)
SELECT home_branch_id, hang, loan_id, outstanding AS du_no
FROM xep
WHERE hang <= 3
ORDER BY home_branch_id, hang;

-- [aivb-f1-top-3-khoan-vay-moi-chi-nhanh] wrong: thieu_partition_by
-- Xếp hạng trên toàn ngân hàng: chỉ còn 3 khoản vay (rớt ở public).
WITH xep AS (
  SELECT c.home_branch_id, l.loan_id, l.outstanding,
         ROW_NUMBER() OVER (ORDER BY l.outstanding DESC, l.loan_id) AS hang
  FROM core_loan_contract l
  JOIN core_contract c ON c.contract_id = l.contract_id
  WHERE l.loan_status = 'ACTIVE'
)
SELECT home_branch_id, hang, loan_id, outstanding AS du_no
FROM xep
WHERE hang <= 3
ORDER BY home_branch_id, hang;

-- [aivb-f1-top-3-khoan-vay-moi-chi-nhanh] wrong: xep_theo_so_tien_vay_ban_dau
-- Xếp theo số tiền vay ban đầu thay cho dư nợ (rớt ở public).
WITH xep AS (
  SELECT c.home_branch_id, l.loan_id, l.outstanding,
         ROW_NUMBER() OVER (PARTITION BY c.home_branch_id ORDER BY l.principal DESC, l.loan_id) AS hang
  FROM core_loan_contract l
  JOIN core_contract c ON c.contract_id = l.contract_id
  WHERE l.loan_status = 'ACTIVE'
)
SELECT home_branch_id, hang, loan_id, outstanding AS du_no
FROM xep
WHERE hang <= 3
ORDER BY home_branch_id, hang;

-- [aivb-f2-mom-gia-tri-theo-kenh] solution
WITH thang AS (
  SELECT channel_code, DATE_FORMAT(transaction_date, '%Y-%m') AS thang, SUM(amount) AS gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY channel_code, DATE_FORMAT(transaction_date, '%Y-%m')
)
SELECT channel_code, thang,
       ROUND(gia_tri / 1000000, 0) AS gia_tri_trieu_dong,
       ROUND(100 * (gia_tri - LAG(gia_tri) OVER (PARTITION BY channel_code ORDER BY thang))
             / LAG(gia_tri) OVER (PARTITION BY channel_code ORDER BY thang), 2) AS thay_doi_pct
FROM thang
ORDER BY channel_code, thang;

-- [aivb-f2-mom-gia-tri-theo-kenh] wrong: lag_thieu_partition_by
-- LAG không chia theo kênh: tháng 1 của mỗi kênh bị so với tháng 12 của kênh trước (rớt ở public).
WITH thang AS (
  SELECT channel_code, DATE_FORMAT(transaction_date, '%Y-%m') AS thang, SUM(amount) AS gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY channel_code, DATE_FORMAT(transaction_date, '%Y-%m')
)
SELECT channel_code, thang,
       ROUND(gia_tri / 1000000, 0) AS gia_tri_trieu_dong,
       ROUND(100 * (gia_tri - LAG(gia_tri) OVER (ORDER BY channel_code, thang))
             / LAG(gia_tri) OVER (ORDER BY channel_code, thang), 2) AS thay_doi_pct
FROM thang
ORDER BY channel_code, thang;

-- [aivb-f2-mom-gia-tri-theo-kenh] wrong: thieu_can_tren_nam
-- Chỉ có cận dưới: lệnh MOBILE ngày 2027-01-01 thành một dòng tháng 2027-01 (rớt ở hidden-1).
WITH thang AS (
  SELECT channel_code, DATE_FORMAT(transaction_date, '%Y-%m') AS thang, SUM(amount) AS gia_tri
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01'
  GROUP BY channel_code, DATE_FORMAT(transaction_date, '%Y-%m')
)
SELECT channel_code, thang,
       ROUND(gia_tri / 1000000, 0) AS gia_tri_trieu_dong,
       ROUND(100 * (gia_tri - LAG(gia_tri) OVER (PARTITION BY channel_code ORDER BY thang))
             / LAG(gia_tri) OVER (PARTITION BY channel_code ORDER BY thang), 2) AS thay_doi_pct
FROM thang
ORDER BY channel_code, thang;

-- [aivb-f3-luy-ke-giai-ngan] solution
WITH RECURSIVE thang AS (
  SELECT DATE('2026-01-01') AS dau_thang
  UNION ALL
  SELECT DATE_ADD(dau_thang, INTERVAL 1 MONTH) FROM thang WHERE dau_thang < '2026-12-01'
), gn AS (
  SELECT DATE_FORMAT(d.disbursement_date, '%Y-%m') AS thang, SUM(d.amount) AS so_tien
  FROM core_loan_disbursement d
  JOIN core_loan_contract l ON l.loan_id = d.loan_id
  JOIN core_contract c ON c.contract_id = l.contract_id
  JOIN ref_product_version v ON v.product_version_id = c.product_version_id
  WHERE v.product_id = 'WC_LOAN'
    AND d.disbursement_date >= '2026-01-01' AND d.disbursement_date < '2027-01-01'
  GROUP BY DATE_FORMAT(d.disbursement_date, '%Y-%m')
), du AS (
  SELECT DATE_FORMAT(t.dau_thang, '%Y-%m') AS thang, COALESCE(gn.so_tien, 0) AS so_tien
  FROM thang t LEFT JOIN gn ON gn.thang = DATE_FORMAT(t.dau_thang, '%Y-%m')
)
SELECT thang,
       ROUND(so_tien / 1000000, 0) AS giai_ngan_trieu_dong,
       ROUND(SUM(so_tien) OVER (ORDER BY thang ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) / 1000000, 0) AS luy_ke_trieu_dong,
       CASE WHEN ROW_NUMBER() OVER (ORDER BY thang) >= 3
            THEN ROUND(AVG(so_tien) OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) / 1000000, 0)
       END AS tb_truot_3_thang_trieu_dong
FROM du
ORDER BY thang;

-- [aivb-f3-luy-ke-giai-ngan] wrong: thieu_thang_khong_giai_ngan
-- Chỉ gom nhóm: tháng không có giải ngân biến mất, bình quân trượt lấy nhầm tháng (rớt ở public).
WITH gn AS (
  SELECT DATE_FORMAT(d.disbursement_date, '%Y-%m') AS thang, SUM(d.amount) AS so_tien
  FROM core_loan_disbursement d
  JOIN core_loan_contract l ON l.loan_id = d.loan_id
  JOIN core_contract c ON c.contract_id = l.contract_id
  JOIN ref_product_version v ON v.product_version_id = c.product_version_id
  WHERE v.product_id = 'WC_LOAN'
    AND d.disbursement_date >= '2026-01-01' AND d.disbursement_date < '2027-01-01'
  GROUP BY DATE_FORMAT(d.disbursement_date, '%Y-%m')
)
SELECT thang,
       ROUND(so_tien / 1000000, 0) AS giai_ngan_trieu_dong,
       ROUND(SUM(so_tien) OVER (ORDER BY thang ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) / 1000000, 0) AS luy_ke_trieu_dong,
       CASE WHEN ROW_NUMBER() OVER (ORDER BY thang) >= 3
            THEN ROUND(AVG(so_tien) OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) / 1000000, 0)
       END AS tb_truot_3_thang_trieu_dong
FROM gn
ORDER BY thang;

-- [aivb-f3-luy-ke-giai-ngan] wrong: tb_truot_hai_thang_dau
-- Hai tháng đầu vẫn ra bình quân của 1 và 2 tháng, đề yêu cầu để trống (rớt ở public).
WITH RECURSIVE thang AS (
  SELECT DATE('2026-01-01') AS dau_thang
  UNION ALL
  SELECT DATE_ADD(dau_thang, INTERVAL 1 MONTH) FROM thang WHERE dau_thang < '2026-12-01'
), gn AS (
  SELECT DATE_FORMAT(d.disbursement_date, '%Y-%m') AS thang, SUM(d.amount) AS so_tien
  FROM core_loan_disbursement d
  JOIN core_loan_contract l ON l.loan_id = d.loan_id
  JOIN core_contract c ON c.contract_id = l.contract_id
  JOIN ref_product_version v ON v.product_version_id = c.product_version_id
  WHERE v.product_id = 'WC_LOAN'
    AND d.disbursement_date >= '2026-01-01' AND d.disbursement_date < '2027-01-01'
  GROUP BY DATE_FORMAT(d.disbursement_date, '%Y-%m')
), du AS (
  SELECT DATE_FORMAT(t.dau_thang, '%Y-%m') AS thang, COALESCE(gn.so_tien, 0) AS so_tien
  FROM thang t LEFT JOIN gn ON gn.thang = DATE_FORMAT(t.dau_thang, '%Y-%m')
)
SELECT thang,
       ROUND(so_tien / 1000000, 0) AS giai_ngan_trieu_dong,
       ROUND(SUM(so_tien) OVER (ORDER BY thang ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) / 1000000, 0) AS luy_ke_trieu_dong,
       ROUND(AVG(so_tien) OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) / 1000000, 0) AS tb_truot_3_thang_trieu_dong
FROM du
ORDER BY thang;

-- [aivb-f5-cohort-khach-vay] solution
WITH ho_so AS (
  SELECT party_id, application_date,
         ROW_NUMBER() OVER (PARTITION BY party_id ORDER BY application_date, application_id) AS thu_tu
  FROM core_loan_application
), dau_tien AS (
  SELECT party_id, application_date FROM ho_so WHERE thu_tu = 1
), kh AS (
  SELECT YEAR(c.customer_since) AS nam_bat_dau,
         YEAR(f.application_date) - YEAR(c.customer_since) AS khoang_nam
  FROM core_customer c
  LEFT JOIN dau_tien f ON f.party_id = c.party_id
)
SELECT nam_bat_dau,
       COUNT(*) AS so_khach,
       ROUND(100 * COUNT(CASE WHEN khoang_nam = 0 THEN 1 END) / COUNT(*), 2) AS vay_cung_nam_pct,
       ROUND(100 * COUNT(CASE WHEN khoang_nam = 1 THEN 1 END) / COUNT(*), 2) AS vay_nam_thu_2_pct,
       ROUND(100 * COUNT(CASE WHEN khoang_nam >= 2 THEN 1 END) / COUNT(*), 2) AS vay_tu_nam_thu_3_pct
FROM kh
GROUP BY nam_bat_dau
ORDER BY nam_bat_dau;

-- [aivb-f5-cohort-khach-vay] wrong: ho_so_bat_ky
-- Lấy mọi hồ sơ thay vì hồ sơ đầu tiên: khách có nhiều hồ sơ được tính vào nhiều khoảng (rớt ở public).
WITH kh AS (
  SELECT c.customer_id, YEAR(c.customer_since) AS nam_bat_dau,
         YEAR(a.application_date) - YEAR(c.customer_since) AS khoang_nam
  FROM core_customer c
  LEFT JOIN core_loan_application a ON a.party_id = c.party_id
)
SELECT nam_bat_dau,
       COUNT(DISTINCT customer_id) AS so_khach,
       ROUND(100 * COUNT(DISTINCT CASE WHEN khoang_nam = 0 THEN customer_id END) / COUNT(DISTINCT customer_id), 2) AS vay_cung_nam_pct,
       ROUND(100 * COUNT(DISTINCT CASE WHEN khoang_nam = 1 THEN customer_id END) / COUNT(DISTINCT customer_id), 2) AS vay_nam_thu_2_pct,
       ROUND(100 * COUNT(DISTINCT CASE WHEN khoang_nam >= 2 THEN customer_id END) / COUNT(DISTINCT customer_id), 2) AS vay_tu_nam_thu_3_pct
FROM kh
GROUP BY nam_bat_dau
ORDER BY nam_bat_dau;

-- [aivb-f5-cohort-khach-vay] wrong: mau_so_chi_khach_co_vay
-- INNER JOIN làm mẫu số chỉ còn khách đã có hồ sơ vay (rớt ở public).
WITH ho_so AS (
  SELECT party_id, application_date,
         ROW_NUMBER() OVER (PARTITION BY party_id ORDER BY application_date, application_id) AS thu_tu
  FROM core_loan_application
), dau_tien AS (
  SELECT party_id, application_date FROM ho_so WHERE thu_tu = 1
), kh AS (
  SELECT YEAR(c.customer_since) AS nam_bat_dau,
         YEAR(f.application_date) - YEAR(c.customer_since) AS khoang_nam
  FROM core_customer c
  JOIN dau_tien f ON f.party_id = c.party_id
)
SELECT nam_bat_dau,
       COUNT(*) AS so_khach,
       ROUND(100 * COUNT(CASE WHEN khoang_nam = 0 THEN 1 END) / COUNT(*), 2) AS vay_cung_nam_pct,
       ROUND(100 * COUNT(CASE WHEN khoang_nam = 1 THEN 1 END) / COUNT(*), 2) AS vay_nam_thu_2_pct,
       ROUND(100 * COUNT(CASE WHEN khoang_nam >= 2 THEN 1 END) / COUNT(*), 2) AS vay_tu_nam_thu_3_pct
FROM kh
GROUP BY nam_bat_dau
ORDER BY nam_bat_dau;

-- [aivb-f6-pareto-so-du-casa] solution
WITH kh AS (
  SELECT ap.party_id, SUM(b.current_balance) AS so_du
  FROM core_account_balance b
  JOIN core_account_party ap ON ap.account_id = b.account_id AND ap.role_code = 'PRIMARY_OWNER'
  GROUP BY ap.party_id
  HAVING SUM(b.current_balance) > 0
), luy_ke AS (
  SELECT party_id, so_du,
         SUM(so_du) OVER (ORDER BY so_du DESC, party_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS so_du_luy_ke,
         SUM(so_du) OVER () AS tong_so_du,
         ROW_NUMBER() OVER (ORDER BY so_du DESC, party_id) AS thu_tu,
         COUNT(*) OVER () AS so_khach
  FROM kh
)
SELECT MIN(so_khach) AS so_khach_co_so_du,
       MIN(thu_tu) AS so_khach_dat_80,
       ROUND(100 * MIN(thu_tu) / MIN(so_khach), 2) AS ty_le_khach_pct
FROM luy_ke
WHERE so_du_luy_ke >= 0.8 * tong_so_du;

-- [aivb-f6-pareto-so-du-casa] wrong: moi_vai_tro_tai_khoan
-- Không lọc chủ tài khoản: số dư tài khoản đồng sở hữu được cộng cho nhiều chủ thể (rớt ở public).
WITH kh AS (
  SELECT ap.party_id, SUM(b.current_balance) AS so_du
  FROM core_account_balance b
  JOIN core_account_party ap ON ap.account_id = b.account_id
  GROUP BY ap.party_id
  HAVING SUM(b.current_balance) > 0
), luy_ke AS (
  SELECT party_id, so_du,
         SUM(so_du) OVER (ORDER BY so_du DESC, party_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS so_du_luy_ke,
         SUM(so_du) OVER () AS tong_so_du,
         ROW_NUMBER() OVER (ORDER BY so_du DESC, party_id) AS thu_tu,
         COUNT(*) OVER () AS so_khach
  FROM kh
)
SELECT MIN(so_khach) AS so_khach_co_so_du,
       MIN(thu_tu) AS so_khach_dat_80,
       ROUND(100 * MIN(thu_tu) / MIN(so_khach), 2) AS ty_le_khach_pct
FROM luy_ke
WHERE so_du_luy_ke >= 0.8 * tong_so_du;

-- [aivb-f6-pareto-so-du-casa] wrong: luy_ke_tang_dan
-- Cộng dồn từ khách số dư nhỏ nhất (rớt ở public).
WITH kh AS (
  SELECT ap.party_id, SUM(b.current_balance) AS so_du
  FROM core_account_balance b
  JOIN core_account_party ap ON ap.account_id = b.account_id AND ap.role_code = 'PRIMARY_OWNER'
  GROUP BY ap.party_id
  HAVING SUM(b.current_balance) > 0
), luy_ke AS (
  SELECT party_id, so_du,
         SUM(so_du) OVER (ORDER BY so_du, party_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS so_du_luy_ke,
         SUM(so_du) OVER () AS tong_so_du,
         ROW_NUMBER() OVER (ORDER BY so_du, party_id) AS thu_tu,
         COUNT(*) OVER () AS so_khach
  FROM kh
)
SELECT MIN(so_khach) AS so_khach_co_so_du,
       MIN(thu_tu) AS so_khach_dat_80,
       ROUND(100 * MIN(thu_tu) / MIN(so_khach), 2) AS ty_le_khach_pct
FROM luy_ke
WHERE so_du_luy_ke >= 0.8 * tong_so_du;

-- [aivb-f7-ho-so-moi-nhat] starter
WITH xep AS (
  SELECT party_id, application_id, application_date, product_id, application_status,
         ROW_NUMBER() OVER (PARTITION BY party_id ORDER BY application_date) AS thu_tu,
         COUNT(*) OVER (PARTITION BY party_id) AS so_ho_so
  FROM core_loan_application
)
SELECT party_id, application_id, application_date, product_id, application_status
FROM xep
WHERE thu_tu = 1 AND so_ho_so > 1
ORDER BY party_id;

-- [aivb-f7-ho-so-moi-nhat] solution
WITH xep AS (
  SELECT party_id, application_id, application_date, product_id, application_status,
         ROW_NUMBER() OVER (PARTITION BY party_id ORDER BY application_date DESC, application_id DESC) AS thu_tu,
         COUNT(*) OVER (PARTITION BY party_id) AS so_ho_so
  FROM core_loan_application
)
SELECT party_id, application_id, application_date, product_id, application_status
FROM xep
WHERE thu_tu = 1 AND so_ho_so > 1
ORDER BY party_id;

-- [aivb-f7-ho-so-moi-nhat] wrong: chia_nhom_ca_san_pham
-- Chia nhóm theo cả chủ thể và sản phẩm: khách vay nhiều sản phẩm ra nhiều dòng (rớt ở public).
WITH xep AS (
  SELECT party_id, application_id, application_date, product_id, application_status,
         ROW_NUMBER() OVER (PARTITION BY party_id, product_id ORDER BY application_date DESC, application_id DESC) AS thu_tu,
         COUNT(*) OVER (PARTITION BY party_id) AS so_ho_so
  FROM core_loan_application
)
SELECT party_id, application_id, application_date, product_id, application_status
FROM xep
WHERE thu_tu = 1 AND so_ho_so > 1
ORDER BY party_id;

-- [aivb-f8-top-5-khoan-vay-dung-5-dong] starter
WITH xep AS (
  SELECT loan_id, outstanding, interest_rate,
         RANK() OVER (ORDER BY outstanding DESC) AS hang
  FROM core_loan_contract
  WHERE loan_status = 'ACTIVE'
)
SELECT hang, loan_id, outstanding AS du_no, ROUND(100 * interest_rate, 2) AS lai_suat_pct
FROM xep
WHERE hang <= 5
ORDER BY hang;

-- [aivb-f8-top-5-khoan-vay-dung-5-dong] solution
WITH xep AS (
  SELECT loan_id, outstanding, interest_rate,
         ROW_NUMBER() OVER (ORDER BY outstanding DESC, loan_id) AS hang
  FROM core_loan_contract
  WHERE loan_status = 'ACTIVE'
)
SELECT hang, loan_id, outstanding AS du_no, ROUND(100 * interest_rate, 2) AS lai_suat_pct
FROM xep
WHERE hang <= 5
ORDER BY hang;

-- [aivb-f8-top-5-khoan-vay-dung-5-dong] wrong: dense_rank
-- DENSE_RANK vẫn cho hai khoản vay bằng dư nợ cùng hạng 5: ra 6 dòng (rớt ở hidden-1).
WITH xep AS (
  SELECT loan_id, outstanding, interest_rate,
         DENSE_RANK() OVER (ORDER BY outstanding DESC) AS hang
  FROM core_loan_contract
  WHERE loan_status = 'ACTIVE'
)
SELECT hang, loan_id, outstanding AS du_no, ROUND(100 * interest_rate, 2) AS lai_suat_pct
FROM xep
WHERE hang <= 5
ORDER BY hang;

-- [aivb-f8-top-5-khoan-vay-dung-5-dong] wrong: hoa_loan_id_giam_dan
-- Bằng dư nợ thì lấy loan_id lớn hơn, ngược quy tắc của đề (rớt ở hidden-1).
WITH xep AS (
  SELECT loan_id, outstanding, interest_rate,
         ROW_NUMBER() OVER (ORDER BY outstanding DESC, loan_id DESC) AS hang
  FROM core_loan_contract
  WHERE loan_status = 'ACTIVE'
)
SELECT hang, loan_id, outstanding AS du_no, ROUND(100 * interest_rate, 2) AS lai_suat_pct
FROM xep
WHERE hang <= 5
ORDER BY hang;

-- [aivb-f9-so-du-chay-tai-khoan] starter
SELECT posting_id, transaction_date, debit_credit, amount,
       SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date) AS dong_tien_luy_ke
FROM core_account_posting
WHERE account_id = 'SYN_ACC_0003225' AND transaction_date >= '2026-12-01'
ORDER BY transaction_date, posting_id;

-- [aivb-f9-so-du-chay-tai-khoan] solution
SELECT posting_id, transaction_date, debit_credit, amount,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE -amount END)
         OVER (PARTITION BY account_id ORDER BY transaction_date, posting_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS dong_tien_luy_ke
FROM core_account_posting
WHERE account_id = 'SYN_ACC_0003225'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
ORDER BY transaction_date, posting_id;

-- [aivb-f9-so-du-chay-tai-khoan] wrong: van_khung_range_mac_dinh
-- Sửa dấu và cận trên nhưng giữ khung mặc định: các bút toán cùng ngày nhận chung một số luỹ kế (rớt ở public).
SELECT posting_id, transaction_date, debit_credit, amount,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE -amount END)
         OVER (PARTITION BY account_id ORDER BY transaction_date) AS dong_tien_luy_ke
FROM core_account_posting
WHERE account_id = 'SYN_ACC_0003225'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01'
ORDER BY transaction_date, posting_id;

-- [aivb-f9-so-du-chay-tai-khoan] wrong: quen_can_tren_thang
-- Sửa dấu và khung nhưng giữ điều kiện ngày chỉ có cận dưới: bút toán ngày 2027-01-01 lọt vào (rớt ở hidden-1).
SELECT posting_id, transaction_date, debit_credit, amount,
       SUM(CASE WHEN debit_credit = 'CREDIT' THEN amount ELSE -amount END)
         OVER (PARTITION BY account_id ORDER BY transaction_date, posting_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS dong_tien_luy_ke
FROM core_account_posting
WHERE account_id = 'SYN_ACC_0003225' AND transaction_date >= '2026-12-01'
ORDER BY transaction_date, posting_id;

-- ################################################################ CASE

-- [aivb-c7-kenh-so-va-quay.b1] solution
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang,
       ROUND(SUM(CASE WHEN channel_code IN ('MOBILE', 'WEB', 'QR', 'API') THEN amount ELSE 0 END) / 1000000000, 2) AS kenh_so_ty_dong,
       ROUND(SUM(CASE WHEN channel_code IN ('BRANCH', 'ATM', 'POS') THEN amount ELSE 0 END) / 1000000000, 2) AS kenh_vat_ly_ty_dong
FROM core_payment_order
WHERE payment_status = 'COMPLETED'
  AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-c7-kenh-so-va-quay.b1] wrong: thieu_can_tren_nam
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang,
       ROUND(SUM(CASE WHEN channel_code IN ('MOBILE', 'WEB', 'QR', 'API') THEN amount ELSE 0 END) / 1000000000, 2) AS kenh_so_ty_dong,
       ROUND(SUM(CASE WHEN channel_code IN ('BRANCH', 'ATM', 'POS') THEN amount ELSE 0 END) / 1000000000, 2) AS kenh_vat_ly_ty_dong
FROM core_payment_order
WHERE payment_status = 'COMPLETED' AND transaction_date >= '2026-01-01'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY thang;

-- [aivb-c7-kenh-so-va-quay.b2] solution
WITH thang AS (
  SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang,
         SUM(CASE WHEN channel_code IN ('MOBILE', 'WEB', 'QR', 'API') THEN amount ELSE 0 END) AS kenh_so,
         SUM(amount) AS tong
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
)
SELECT thang, ROUND(100 * kenh_so / tong, 2) AS ty_trong_kenh_so_pct
FROM thang
ORDER BY thang;

-- [aivb-c7-kenh-so-va-quay.b3] solution
WITH thang AS (
  SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS thang,
         100 * SUM(CASE WHEN channel_code IN ('MOBILE', 'WEB', 'QR', 'API') THEN amount ELSE 0 END) / SUM(amount) AS ty_trong
  FROM core_payment_order
  WHERE payment_status = 'COMPLETED'
    AND transaction_date >= '2026-01-01' AND transaction_date < '2027-01-01'
  GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
)
SELECT thang,
       ROUND(ty_trong, 2) AS ty_trong_kenh_so_pct,
       ROUND(ty_trong - LAG(ty_trong) OVER (ORDER BY thang), 2) AS thay_doi_diem
FROM thang
ORDER BY thang;

-- [aivb-c8-chat-luong-tin-dung-cohort.b1] solution
WITH den_han AS (
  SELECT loan_id, COUNT(*) AS so_ky
  FROM core_loan_schedule
  WHERE due_date <= '2026-12-31' AND schedule_status <> 'CANCELLED'
  GROUP BY loan_id
)
SELECT YEAR(l.disbursement_date) AS nam_giai_ngan,
       COUNT(*) AS so_khoan_vay,
       ROUND(SUM(l.principal) / 1000000000, 2) AS tong_goc_ty_dong,
       ROUND(AVG(COALESCE(d.so_ky, 0)), 1) AS so_ky_den_han_bq
FROM core_loan_contract l
LEFT JOIN den_han d ON d.loan_id = l.loan_id
GROUP BY YEAR(l.disbursement_date)
ORDER BY nam_giai_ngan;

-- [aivb-c8-chat-luong-tin-dung-cohort.b2] solution
SELECT YEAR(disbursement_date) AS nam_giai_ngan,
       COUNT(*) AS so_khoan_vay,
       COUNT(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 END) AS so_khoan_co_van_de,
       ROUND(100 * COUNT(CASE WHEN loan_status IN ('DELINQUENT', 'RESTRUCTURED', 'WRITTEN_OFF') THEN 1 END) / COUNT(*), 2) AS ty_le_co_van_de_pct
FROM core_loan_contract
GROUP BY YEAR(disbursement_date)
ORDER BY nam_giai_ngan;

-- [aivb-c8-chat-luong-tin-dung-cohort.b3] solution
WITH co_qua_han AS (
  SELECT DISTINCT loan_id FROM core_loan_schedule WHERE schedule_status = 'OVERDUE'
)
SELECT YEAR(l.disbursement_date) AS nam_giai_ngan,
       COUNT(q.loan_id) AS so_khoan_co_ky_qua_han,
       ROUND(100 * COUNT(q.loan_id) / COUNT(*), 2) AS ty_le_khoan_qua_han_pct
FROM core_loan_contract l
LEFT JOIN co_qua_han q ON q.loan_id = l.loan_id
GROUP BY YEAR(l.disbursement_date)
ORDER BY nam_giai_ngan;

-- [aivb-c8-chat-luong-tin-dung-cohort.b3] wrong: dem_ky_thay_vi_khoan
SELECT YEAR(l.disbursement_date) AS nam_giai_ngan,
       COUNT(s.schedule_id) AS so_khoan_co_ky_qua_han,
       ROUND(100 * COUNT(s.schedule_id) / COUNT(DISTINCT l.loan_id), 2) AS ty_le_khoan_qua_han_pct
FROM core_loan_contract l
LEFT JOIN core_loan_schedule s ON s.loan_id = l.loan_id AND s.schedule_status = 'OVERDUE'
GROUP BY YEAR(l.disbursement_date)
ORDER BY nam_giai_ngan;

-- [aivb-c8-chat-luong-tin-dung-cohort.b4] solution
WITH ky AS (
  SELECT YEAR(l.disbursement_date) AS nam_giai_ngan,
         COUNT(*) AS so_ky_den_han,
         COUNT(CASE WHEN s.schedule_status = 'OVERDUE' THEN 1 END) AS so_ky_qua_han
  FROM core_loan_schedule s
  JOIN core_loan_contract l ON l.loan_id = s.loan_id
  WHERE s.due_date <= '2026-12-31' AND s.schedule_status <> 'CANCELLED'
  GROUP BY YEAR(l.disbursement_date)
)
SELECT nam_giai_ngan, so_ky_den_han, so_ky_qua_han,
       ROUND(100 * so_ky_qua_han / so_ky_den_han, 2) AS ty_le_ky_qua_han_pct,
       RANK() OVER (ORDER BY so_ky_qua_han / so_ky_den_han DESC) AS hang
FROM ky
ORDER BY hang, nam_giai_ngan;

-- ################################################################ PHIÊN BẢN 2 (sửa sau kiểm B/C)

-- [aivb-t6-lai-du-thu-tien-gui-va-vay] solution
WITH thu AS (
  SELECT SUM(a.accrued_amount) AS so_tien
  FROM core_interest_accrual a
  JOIN core_loan_contract l ON l.contract_id = a.contract_id
  WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
), tra AS (
  SELECT SUM(a.accrued_amount) AS so_tien
  FROM core_interest_accrual a
  JOIN core_deposit_contract d ON d.contract_id = a.contract_id
  WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
)
SELECT 1 AS thu_tu, 'lai_du_thu_cho_vay' AS chi_tieu, thu.so_tien AS so_tien FROM thu
UNION ALL
SELECT 2, 'lai_du_tra_tien_gui', tra.so_tien FROM tra
UNION ALL
SELECT 3, 'chenh_lech_thu_tra', thu.so_tien - tra.so_tien FROM thu CROSS JOIN tra
ORDER BY thu_tu;

-- [aivb-f4-chuoi-ky-qua-han] solution
WITH thang AS (
  SELECT DISTINCT c.home_branch_id,
         DATE_FORMAT(s.due_date, '%Y-%m') AS thang,
         YEAR(s.due_date) * 12 + MONTH(s.due_date) AS so_thu_tu_thang
  FROM core_loan_schedule s
  JOIN core_loan_contract l ON l.loan_id = s.loan_id
  JOIN core_contract c ON c.contract_id = l.contract_id
  WHERE s.schedule_status = 'OVERDUE'
), dan AS (
  SELECT home_branch_id, thang,
         so_thu_tu_thang - CAST(ROW_NUMBER() OVER (PARTITION BY home_branch_id ORDER BY so_thu_tu_thang) AS SIGNED) AS nhom_chuoi
  FROM thang
), chuoi AS (
  SELECT home_branch_id, COUNT(*) AS so_thang, MIN(thang) AS thang_dau, MAX(thang) AS thang_cuoi,
         ROW_NUMBER() OVER (PARTITION BY home_branch_id ORDER BY COUNT(*) DESC, MIN(thang)) AS thu_tu
  FROM dan
  GROUP BY home_branch_id, nhom_chuoi
)
SELECT home_branch_id, so_thang, thang_dau, thang_cuoi
FROM chuoi
WHERE thu_tu = 1
ORDER BY so_thang DESC, home_branch_id;

-- [aivb-f4-chuoi-ky-qua-han] wrong: khong_tach_chuoi
-- Đếm mọi tháng có kỳ quá hạn của chi nhánh, coi như một chuỗi từ tháng đầu tới tháng cuối (rớt ở public).
SELECT c.home_branch_id,
       COUNT(DISTINCT DATE_FORMAT(s.due_date, '%Y-%m')) AS so_thang,
       MIN(DATE_FORMAT(s.due_date, '%Y-%m')) AS thang_dau,
       MAX(DATE_FORMAT(s.due_date, '%Y-%m')) AS thang_cuoi
FROM core_loan_schedule s
JOIN core_loan_contract l ON l.loan_id = s.loan_id
JOIN core_contract c ON c.contract_id = l.contract_id
WHERE s.schedule_status = 'OVERDUE'
GROUP BY c.home_branch_id
ORDER BY so_thang DESC, c.home_branch_id;

-- [aivb-f4-chuoi-ky-qua-han] wrong: quen_distinct_thang
-- Không gộp các kỳ cùng tháng: một tháng có nhiều kỳ quá hạn làm đứt chuỗi (rớt ở public).
WITH thang AS (
  SELECT c.home_branch_id,
         DATE_FORMAT(s.due_date, '%Y-%m') AS thang,
         YEAR(s.due_date) * 12 + MONTH(s.due_date) AS so_thu_tu_thang
  FROM core_loan_schedule s
  JOIN core_loan_contract l ON l.loan_id = s.loan_id
  JOIN core_contract c ON c.contract_id = l.contract_id
  WHERE s.schedule_status = 'OVERDUE'
), dan AS (
  SELECT home_branch_id, thang,
         so_thu_tu_thang - CAST(ROW_NUMBER() OVER (PARTITION BY home_branch_id ORDER BY so_thu_tu_thang) AS SIGNED) AS nhom_chuoi
  FROM thang
), chuoi AS (
  SELECT home_branch_id, COUNT(*) AS so_thang, MIN(thang) AS thang_dau, MAX(thang) AS thang_cuoi,
         ROW_NUMBER() OVER (PARTITION BY home_branch_id ORDER BY COUNT(*) DESC, MIN(thang)) AS thu_tu
  FROM dan
  GROUP BY home_branch_id, nhom_chuoi
)
SELECT home_branch_id, so_thang, thang_dau, thang_cuoi
FROM chuoi
WHERE thu_tu = 1
ORDER BY so_thang DESC, home_branch_id;

-- [aivb-t6-lai-du-thu-tien-gui-va-vay] wrong: thieu_can_tren_nam
-- Chỉ có cận dưới: dòng lãi dự thu ngày 2027-01-01 lọt vào (rớt ở hidden-1).
WITH thu AS (
  SELECT SUM(a.accrued_amount) AS so_tien
  FROM core_interest_accrual a
  JOIN core_loan_contract l ON l.contract_id = a.contract_id
  WHERE a.accrual_date >= '2026-01-01'
), tra AS (
  SELECT SUM(a.accrued_amount) AS so_tien
  FROM core_interest_accrual a
  JOIN core_deposit_contract d ON d.contract_id = a.contract_id
  WHERE a.accrual_date >= '2026-01-01'
)
SELECT 1 AS thu_tu, 'lai_du_thu_cho_vay' AS chi_tieu, thu.so_tien AS so_tien FROM thu
UNION ALL
SELECT 2, 'lai_du_tra_tien_gui', tra.so_tien FROM tra
UNION ALL
SELECT 3, 'chenh_lech_thu_tra', thu.so_tien - tra.so_tien FROM thu CROSS JOIN tra
ORDER BY thu_tu;

-- [aivb-t6-lai-du-thu-tien-gui-va-vay] wrong: chenh_lech_nguoc_chieu
-- Lấy lãi dự trả trừ lãi dự thu: chênh lệch ngược dấu (rớt ở public).
WITH thu AS (
  SELECT SUM(a.accrued_amount) AS so_tien
  FROM core_interest_accrual a
  JOIN core_loan_contract l ON l.contract_id = a.contract_id
  WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
), tra AS (
  SELECT SUM(a.accrued_amount) AS so_tien
  FROM core_interest_accrual a
  JOIN core_deposit_contract d ON d.contract_id = a.contract_id
  WHERE a.accrual_date >= '2026-01-01' AND a.accrual_date < '2027-01-01'
)
SELECT 1 AS thu_tu, 'lai_du_thu_cho_vay' AS chi_tieu, thu.so_tien AS so_tien FROM thu
UNION ALL
SELECT 2, 'lai_du_tra_tien_gui', tra.so_tien FROM tra
UNION ALL
SELECT 3, 'chenh_lech_thu_tra', tra.so_tien - thu.so_tien FROM thu CROSS JOIN tra
ORDER BY thu_tu;
