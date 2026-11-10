-- 04_bo_sung_bien_the_aivb.sql: bổ sung biến thể ẩn aivb_hidden_1 cho các câu chỉ dùng bảng danh mục / khách hàng / tín dụng
-- (03_bien_the_an_aivb.sql chỉ đổi lệnh thanh toán, bút toán, lãi dự thu, 1 dư nợ -> ~60 câu cho kết quả public = hidden-1).
-- Chạy SAU 03_bien_the_an_aivb.sql, chỉ trên aivb_hidden_1 (KHÔNG đụng aivb public):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot --default-character-set=utf8mb4' < mysql/aivb/04_bo_sung_bien_the_aivb.sql
-- Chạy lặp lại được: xoá mọi dòng giả theo khoá riêng (chữ H trong khoá: CN13, *_H0000xx, SYN_PTY_PH/OH…, SYN_LON_0000000) rồi chèn lại.
-- Ghi ở ../README-aivb.md, bảng "Biến thể" (d)–(k).
--
-- Một cụm khách hàng giả, đủ quan hệ, khớp bộ lọc các câu đang trùng:
--   (d) chi nhánh CN13 "Chi nhánh Quận 3" (MIEN_NAM, TP. Hồ Chí Minh); phiên bản TD_IND_V2026H2 (TD_IND_V2026 kết thúc 2026-06-30)
--   (e) 4 chủ thể + 4 khách hàng: PH1 Huế, nghỉ hưu, thiếu nghề nghiệp (CN06, không có hồ sơ vay);
--       PH2 Đà Nẵng sinh 1990, PRIORITY, CN08; PH3 KYC không đạt tháng 12/2025, CN01;
--       OH1 hộ kinh doanh "... F&B", mã số đăng ký đơn vị phụ thuộc 0100000125-001, MICRO, CN13
--   (f) 3 tài khoản thanh toán (mở 2024-02, 2024-06, 2025-12; một tài khoản đóng 2026-09-15), số dư, 4 quan hệ chủ tài khoản
--       (có 1 đồng chủ tài khoản JOINT_OWNER còn hiệu lực)
--   (g) 2 tiền gửi ACTIVE 12 tháng: cá nhân lãi 5,70%/năm đến hạn 2027-01-20 (CN08); doanh nghiệp TD_BIZ 4,90% (CN13)
--   (h) 5 hồ sơ vay + quyết định: MORT hạng A duyệt 04/2025; CONS duyệt 12/2025; WC_LOAN duyệt 03/2026; WC_LOAN 5 tỷ bị từ chối
--       11/2026 (quyết định 2026-12-03, approved_amount NULL); CONS duyệt 28/12/2026 chưa có khoản vay
--   (i) khoản vay SYN_LON_0000000 ACTIVE, dư nợ 9.955.838.081 = cặp hoà hạng 5 của biến thể (c) -> nay hoà 3 khoản ở hạng 5,
--       loan_id nhỏ nhất nên vào top 5 khi bằng nhau thì loan_id nhỏ hơn trước; giải ngân 2025-04-30 (ngày cuối tháng)
--   (j) khoản vay SYN_LON_H000003 RESTRUCTURED (CONS 150 triệu, giải ngân 2025-12-31): 2 kỳ OVERDUE (1 kỳ trả một phần)
--   (k) khoản vay SYN_LON_H000004 ACTIVE (WC_LOAN 1,5 tỷ, CN13), giải ngân 2 lần năm 2026; 2 lệnh giải ngân COMPLETED không có bút toán
--   (l) 2 quan hệ JOINT_OWNER đúng biên 30/06/2026: SYN_APT_H000005 (valid_to = 2026-06-30), SYN_APT_H000006 (valid_from = 2026-06-30)
--       Tiền gửi ACTIVE đến hạn đúng 2027-02-01 (biên trên aivb-c2) đã có sẵn ở cả public và hidden-1, không thêm.

USE aivb_hidden_1;
SET NAMES utf8mb4;

-- ------------------------------------------------------------------ xoá dòng giả cũ (con trước, cha sau)
DELETE FROM core_payment_order           WHERE payment_order_id IN ('SYN_PMO_H0000003', 'SYN_PMO_H0000004');
DELETE FROM core_loan_payment_allocation WHERE loan_id IN ('SYN_LON_0000000', 'SYN_LON_H000003', 'SYN_LON_H000004');
DELETE FROM core_loan_disbursement       WHERE loan_id IN ('SYN_LON_0000000', 'SYN_LON_H000003', 'SYN_LON_H000004');
DELETE FROM core_loan_schedule           WHERE loan_id IN ('SYN_LON_0000000', 'SYN_LON_H000003', 'SYN_LON_H000004');
DELETE FROM core_loan_contract           WHERE loan_id IN ('SYN_LON_0000000', 'SYN_LON_H000003', 'SYN_LON_H000004');
DELETE FROM core_credit_decision         WHERE credit_decision_id LIKE 'SYN\_CRD\_H%';
DELETE FROM core_loan_application        WHERE application_id LIKE 'SYN\_LNA\_H%';
DELETE FROM core_deposit_contract        WHERE deposit_id LIKE 'SYN\_DEP\_H%';
DELETE FROM core_account_balance         WHERE account_id LIKE 'SYN\_ACC\_H%';
DELETE FROM core_account_party           WHERE account_party_id LIKE 'SYN\_APT\_H%';
DELETE FROM core_account                 WHERE account_id LIKE 'SYN\_ACC\_H%';
DELETE FROM core_contract                WHERE contract_id LIKE 'SYN\_CTR\_H%';
DELETE FROM core_customer_kyc_event      WHERE customer_id LIKE 'SYN\_CUS\_H%';
DELETE FROM hist_customer_segment        WHERE customer_id LIKE 'SYN\_CUS\_H%';
DELETE FROM core_customer                WHERE customer_id LIKE 'SYN\_CUS\_H%';
DELETE FROM core_person                  WHERE party_id IN ('SYN_PTY_PH00001', 'SYN_PTY_PH00002', 'SYN_PTY_PH00003');
DELETE FROM core_organization            WHERE party_id = 'SYN_PTY_OH00001';
DELETE FROM core_party                   WHERE party_id IN ('SYN_PTY_PH00001', 'SYN_PTY_PH00002', 'SYN_PTY_PH00003', 'SYN_PTY_OH00001');
DELETE FROM ref_product_version          WHERE product_version_id = 'TD_IND_V2026H2';
DELETE FROM ref_branch                   WHERE ref_branch_id = 'CN13';
UPDATE ref_product_version SET effective_to = NULL WHERE product_version_id = 'TD_IND_V2026';

-- ------------------------------------------------------------------ (d) danh mục
INSERT INTO ref_branch VALUES ('CN13', 'AIVB_CN13', 'Chi nhánh Quận 3', 'MIEN_NAM', 'TP. Hồ Chí Minh', '2024-01-02', 'ACTIVE');
UPDATE ref_product_version SET effective_to = '2026-06-30' WHERE product_version_id = 'TD_IND_V2026';
INSERT INTO ref_product_version VALUES
  ('TD_IND_V2026H2', 'TD_IND', '2026-07-01', NULL, 'ACTIVE', 'PERSON', 'IR.TD.2026H2', 'FEESET.TD', 'ACCSET.DEPOSIT');

-- ------------------------------------------------------------------ (e) chủ thể, khách hàng
INSERT INTO core_party VALUES
  ('SYN_PTY_PH00001', 'PERSON',       'Tran Thi Hoa',                 'ACTIVE', '2026-03-02', NULL, '2026-03-02 09:15:00'),
  ('SYN_PTY_PH00002', 'PERSON',       'Nguyen Minh Quan',             'ACTIVE', '2024-06-14', NULL, '2024-06-14 14:20:00'),
  ('SYN_PTY_PH00003', 'PERSON',       'Le Van Phuc',                  'ACTIVE', '2025-12-10', NULL, '2025-12-10 10:00:00'),
  ('SYN_PTY_OH00001', 'ORGANIZATION', 'Ho Kinh Doanh Phuong Nam F&B', 'ACTIVE', '2024-02-01', NULL, '2024-02-01 08:30:00');
INSERT INTO core_person VALUES
  ('SYN_PTY_PH00001', '1958-03-14', 'F', 'RETIRED',  NULL,       'WIDOWED', 'HIGH_SCHOOL_OR_BELOW', 0, 'HUE',     'UNDER_10M'),
  ('SYN_PTY_PH00002', '1990-08-20', 'M', 'SALARIED', 'CNTT',     'MARRIED', 'BACHELOR',             1, 'DA_NANG', '40M_80M'),
  ('SYN_PTY_PH00003', '2001-11-05', 'M', 'SALARIED', 'BAN_LE',   'SINGLE',  'BACHELOR',             0, 'HA_NOI',  '10M_20M');
INSERT INTO core_organization VALUES
  ('SYN_PTY_OH00001', 'MICRO', '0100000125-001', 'MICRO', 6, 'ACTIVE', 'FNB', 'REV_UNDER_20B');
INSERT INTO core_customer VALUES
  ('SYN_CUS_H000001', 'SYN_PTY_PH00001', '2026-03-02', 'ACTIVE', 'MASS',     'CN06', 'PASS'),
  ('SYN_CUS_H000002', 'SYN_PTY_PH00002', '2024-06-14', 'ACTIVE', 'PRIORITY', 'CN08', 'PASS'),
  ('SYN_CUS_H000003', 'SYN_PTY_PH00003', '2025-12-10', 'ACTIVE', 'MASS',     'CN01', 'FAIL'),
  ('SYN_CUS_H000004', 'SYN_PTY_OH00001', '2024-02-01', 'ACTIVE', 'MICRO',    'CN13', 'PASS');
INSERT INTO hist_customer_segment
SELECT CONCAT('SEG_', customer_id, '_01'), customer_id, segment_code, customer_since, NULL
FROM core_customer WHERE customer_id LIKE 'SYN\_CUS\_H%';
INSERT INTO core_customer_kyc_event VALUES
  ('KYC_SYN_CUS_H000001_01', 'SYN_CUS_H000001', 1, 1, NULL,      'PENDING', 'KYC_SUBMITTED', '2026-03-02 10:00:01', '2026-03-02', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000001_02', 'SYN_CUS_H000001', 1, 2, 'PENDING', 'PASS',    'KYC_APPROVED',  '2026-03-04 10:00:02', '2026-03-04', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000002_01', 'SYN_CUS_H000002', 1, 1, NULL,      'PENDING', 'KYC_SUBMITTED', '2024-06-14 10:00:01', '2024-06-14', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000002_02', 'SYN_CUS_H000002', 1, 2, 'PENDING', 'PASS',    'KYC_APPROVED',  '2024-06-15 10:00:02', '2024-06-15', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000003_01', 'SYN_CUS_H000003', 1, 1, NULL,      'PENDING', 'KYC_SUBMITTED', '2025-12-10 10:00:01', '2025-12-10', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000003_02', 'SYN_CUS_H000003', 1, 2, 'PENDING', 'FAIL',    'KYC_REJECTED',  '2025-12-12 10:00:02', '2025-12-12', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000004_01', 'SYN_CUS_H000004', 1, 1, NULL,      'PENDING', 'KYC_SUBMITTED', '2024-02-01 10:00:01', '2024-02-01', NULL, 'GR.KYC_STATUS_V2'),
  ('KYC_SYN_CUS_H000004_02', 'SYN_CUS_H000004', 1, 2, 'PENDING', 'PASS',    'KYC_APPROVED',  '2024-02-08 15:30:02', '2024-02-08', NULL, 'GR.KYC_STATUS_V2');

-- ------------------------------------------------------------------ (f)(g) hợp đồng, tài khoản, tiền gửi
INSERT INTO core_contract VALUES
  ('SYN_CTR_H000001', 'CASA_IND_V1',    '2024-06-15', '2024-06-15', NULL,         'ACTIVE', 'VND', 'CN08'),
  ('SYN_CTR_H000002', 'CASA_IND_V1',    '2025-12-10', '2025-12-10', NULL,         'CLOSED', 'VND', 'CN01'),
  ('SYN_CTR_H000003', 'CASA_BIZ_V1',    '2024-02-01', '2024-02-01', NULL,         'ACTIVE', 'VND', 'CN13'),
  ('SYN_CTR_H000004', 'TD_IND_V2026',   '2026-01-20', '2026-01-20', '2027-01-20', 'ACTIVE', 'VND', 'CN08'),
  ('SYN_CTR_H000005', 'MORT_V1',        '2025-04-25', '2025-04-30', '2045-04-30', 'ACTIVE', 'VND', 'CN08'),
  ('SYN_CTR_H000006', 'CONS_V1',        '2025-12-22', '2025-12-31', '2027-12-31', 'ACTIVE', 'VND', 'CN01'),
  ('SYN_CTR_H000007', 'WC_LOAN_V1',     '2026-03-20', '2026-03-31', '2027-03-31', 'ACTIVE', 'VND', 'CN13'),
  ('SYN_CTR_H000008', 'TD_BIZ_V1',      '2026-05-15', '2026-05-15', '2027-05-15', 'ACTIVE', 'VND', 'CN13');
INSERT INTO core_account VALUES
  ('SYN_ACC_H000001', 'SYN_CTR_H000001', 'CASA_IND_V1', 'VND', '2024-06-15', NULL,         'ACTIVE'),
  ('SYN_ACC_H000002', 'SYN_CTR_H000002', 'CASA_IND_V1', 'VND', '2025-12-10', '2026-09-15', 'CLOSED'),
  ('SYN_ACC_H000003', 'SYN_CTR_H000003', 'CASA_BIZ_V1', 'VND', '2024-02-01', NULL,         'ACTIVE');
INSERT INTO core_account_party VALUES
  ('SYN_APT_H000001', 'SYN_ACC_H000001', 'SYN_PTY_PH00002', 'PRIMARY_OWNER', 'A', NULL, '2024-06-15', NULL),
  ('SYN_APT_H000002', 'SYN_ACC_H000001', 'SYN_PTY_PH00001', 'JOINT_OWNER',   'A', NULL, '2026-03-02', NULL),
  ('SYN_APT_H000003', 'SYN_ACC_H000002', 'SYN_PTY_PH00003', 'PRIMARY_OWNER', 'A', NULL, '2025-12-10', '2026-09-15'),
  ('SYN_APT_H000004', 'SYN_ACC_H000003', 'SYN_PTY_OH00001', 'PRIMARY_OWNER', 'A', NULL, '2024-02-01', NULL),
  -- (l) hai quan hệ đồng chủ tài khoản đúng biên ngày tham chiếu 30/06/2026 (aivb-n9): H000005 kết thúc đúng ngày đó
  --     (không còn hiệu lực), H000006 bắt đầu đúng ngày đó (đã có hiệu lực)
  ('SYN_APT_H000005', 'SYN_ACC_H000001', 'SYN_PTY_PH00003', 'JOINT_OWNER',   'A', NULL, '2025-12-15', '2026-06-30'),
  ('SYN_APT_H000006', 'SYN_ACC_H000002', 'SYN_PTY_PH00002', 'JOINT_OWNER',   'A', NULL, '2026-06-30', '2026-09-15');
INSERT INTO core_account_balance VALUES
  ('SYN_ACC_H000001', 2486500000, '2026-12-31'),
  ('SYN_ACC_H000002',          0, '2026-09-15'),
  ('SYN_ACC_H000003',  731250000, '2026-12-31');
INSERT INTO core_deposit_contract VALUES
  ('SYN_DEP_H000001', 'SYN_CTR_H000004', 'SYN_ACC_H000001', 500000000, 0.05700000, 12, '2027-01-20', 'ACTIVE', 0),
  ('SYN_DEP_H000002', 'SYN_CTR_H000008', 'SYN_ACC_H000003', 800000000, 0.04900000, 12, '2027-05-15', 'ACTIVE', 0);

-- ------------------------------------------------------------------ (h) hồ sơ vay, quyết định
INSERT INTO core_loan_application VALUES
  ('SYN_LNA_H000001', 'SYN_PTY_PH00002', 'MORT',    'PV_2024_STD', '2025-04-10', 11000000000, 'A', 0.350000, 'APPROVED', 'PERSONAL'),
  ('SYN_LNA_H000002', 'SYN_PTY_OH00001', 'WC_LOAN', 'PV_2024_STD', '2026-11-05',  5000000000, 'C', 0.620000, 'REJECTED', 'BUSINESS'),
  ('SYN_LNA_H000003', 'SYN_PTY_PH00003', 'CONS',    'PV_2024_STD', '2025-12-15',   150000000, 'D', 0.450000, 'APPROVED', 'PERSONAL'),
  ('SYN_LNA_H000004', 'SYN_PTY_OH00001', 'WC_LOAN', 'PV_2024_STD', '2026-03-10',  1500000000, 'B', 0.400000, 'APPROVED', 'BUSINESS'),
  ('SYN_LNA_H000005', 'SYN_PTY_PH00002', 'CONS',    'PV_2024_STD', '2026-12-20',   200000000, 'A', 0.280000, 'APPROVED', 'PERSONAL');
INSERT INTO core_credit_decision VALUES
  ('SYN_CRD_H000001', 'SYN_LNA_H000001', '2025-04-25', 'APPROVED', 11000000000),
  ('SYN_CRD_H000002', 'SYN_LNA_H000002', '2026-12-03', 'REJECTED', NULL),
  ('SYN_CRD_H000003', 'SYN_LNA_H000003', '2025-12-22', 'APPROVED', 150000000),
  ('SYN_CRD_H000004', 'SYN_LNA_H000004', '2026-03-20', 'APPROVED', 1500000000),
  ('SYN_CRD_H000005', 'SYN_LNA_H000005', '2026-12-28', 'APPROVED', 200000000);

-- ------------------------------------------------------------------ (i)(j) khoản vay, lịch trả nợ, giải ngân, phân bổ trả nợ
INSERT INTO core_loan_contract VALUES
  ('SYN_LON_0000000', 'SYN_CTR_H000005', 'SYN_LNA_H000001', NULL, '2025-04-30', 11000000000, 9955838081, 0.06500000, 240, 'ACTIVE',     0),
  ('SYN_LON_H000003', 'SYN_CTR_H000006', 'SYN_LNA_H000003', NULL, '2025-12-31',   150000000,   91750000, 0.09500000,  24, 'RESTRUCTURED', 0),
  ('SYN_LON_H000004', 'SYN_CTR_H000007', 'SYN_LNA_H000004', NULL, '2026-03-31',  1500000000, 1500000000, 0.09000000,  12, 'ACTIVE',     0);

INSERT INTO core_loan_disbursement VALUES
  ('SYN_LDS_H000001', 'SYN_LON_0000000', 11000000000, '2025-04-30', 'SYN_PMO_H0000001'),
  ('SYN_LDS_H000002', 'SYN_LON_H000003',   150000000, '2025-12-31', 'SYN_PMO_H0000002'),
  ('SYN_LDS_H000003', 'SYN_LON_H000004',  1000000000, '2026-03-31', 'SYN_PMO_H0000003'),
  ('SYN_LDS_H000004', 'SYN_LON_H000004',   500000000, '2026-06-30', 'SYN_PMO_H0000004');

-- Lệnh giải ngân 2026 của khoản WC_LOAN (khuôn lệnh SYN_LENDING thật), CHƯA có bút toán: lệnh COMPLETED thiếu bút toán
INSERT INTO core_payment_order VALUES
  ('SYN_PMO_H0000003', 'SYN_LENDING', 'SYN_LON_H000004', 'SYN_LON_H000004|LOAN_DISBURSEMENT|2026-03-31|1000000000', 'LOAN_DISBURSEMENT', 'BRANCH', '2026-03-31', '2026-03-31', 1000000000, 'VND', 'COMPLETED'),
  ('SYN_PMO_H0000004', 'SYN_LENDING', 'SYN_LON_H000004', 'SYN_LON_H000004|LOAN_DISBURSEMENT|2026-06-30|500000000',  'LOAN_DISBURSEMENT', 'BRANCH', '2026-06-30', '2026-06-30',  500000000, 'VND', 'COMPLETED');

-- MORT: 20 kỳ đã trả (05/2025 -> 12/2026, gốc trả = 11.000.000.000 - 9.955.838.081), kỳ 21 DUE 01/2027
INSERT INTO core_loan_schedule
WITH RECURSIVE k(n) AS (SELECT 1 UNION ALL SELECT n + 1 FROM k WHERE n < 21)
SELECT CONCAT('SYN_LSC_H0', LPAD(n, 6, '0')), 'SYN_LON_0000000', n,
       LAST_DAY(DATE_ADD('2025-05-01', INTERVAL n - 1 MONTH)),
       CASE WHEN n = 20 THEN 52208114 ELSE 52208095 END,
       CASE WHEN n = 21 THEN 53927990 ELSE 59000000 END,
       CASE WHEN n <= 19 THEN 52208095 WHEN n = 20 THEN 52208114 ELSE 0 END,
       CASE WHEN n <= 20 THEN 59000000 ELSE 0 END,
       CASE WHEN n <= 20 THEN 'PAID' ELSE 'DUE' END
FROM k;
-- CONS: 24 kỳ từ 01/2026; kỳ 1-9 PAID, kỳ 10 OVERDUE trả một phần, kỳ 11 OVERDUE chưa trả, kỳ 12-24 DUE
INSERT INTO core_loan_schedule
WITH RECURSIVE k(n) AS (SELECT 1 UNION ALL SELECT n + 1 FROM k WHERE n < 24)
SELECT CONCAT('SYN_LSC_H1', LPAD(n, 6, '0')), 'SYN_LON_H000003', n,
       LAST_DAY(DATE_ADD('2026-01-01', INTERVAL n - 1 MONTH)),
       6250000, 1187500,
       CASE WHEN n <= 9 THEN 6250000 WHEN n = 10 THEN 2000000 ELSE 0 END,
       CASE WHEN n <= 10 THEN 1187500 ELSE 0 END,
       CASE WHEN n <= 9 THEN 'PAID' WHEN n <= 11 THEN 'OVERDUE' ELSE 'DUE' END
FROM k;
-- WC_LOAN: 12 kỳ từ 04/2026, trả lãi hằng tháng, gốc cuối kỳ (kỳ 12); kỳ 1-9 PAID, 10-12 DUE
INSERT INTO core_loan_schedule
WITH RECURSIVE k(n) AS (SELECT 1 UNION ALL SELECT n + 1 FROM k WHERE n < 12)
SELECT CONCAT('SYN_LSC_H2', LPAD(n, 6, '0')), 'SYN_LON_H000004', n,
       LAST_DAY(DATE_ADD('2026-04-01', INTERVAL n - 1 MONTH)),
       CASE WHEN n = 12 THEN 1500000000 ELSE 0 END, 11250000,
       0, CASE WHEN n <= 9 THEN 11250000 ELSE 0 END,
       CASE WHEN n <= 9 THEN 'PAID' ELSE 'DUE' END
FROM k;
INSERT INTO core_loan_payment_allocation
SELECT CONCAT('SYN_LAL_H', SUBSTRING(schedule_id, 10)), loan_id, CONCAT('SYN_PMO_H1', SUBSTRING(schedule_id, 10)),
       due_date, principal_paid, interest_paid, 0, 0
FROM core_loan_schedule
WHERE loan_id IN ('SYN_LON_0000000', 'SYN_LON_H000003', 'SYN_LON_H000004') AND principal_paid + interest_paid > 0;

ANALYZE TABLE ref_branch, ref_product_version, core_party, core_person, core_organization, core_customer,
              hist_customer_segment, core_customer_kyc_event, core_contract, core_account, core_account_party,
              core_account_balance, core_deposit_contract, core_loan_application, core_credit_decision,
              core_loan_contract, core_loan_schedule, core_loan_disbursement, core_loan_payment_allocation;

-- ------------------------------------------------------------------ kiểm tra nhanh: số dòng hidden-1 so với public
SELECT 'ref_branch' AS bang, (SELECT COUNT(*) FROM aivb.ref_branch) AS public, (SELECT COUNT(*) FROM ref_branch) AS hidden_1
UNION ALL SELECT 'ref_product_version', (SELECT COUNT(*) FROM aivb.ref_product_version), (SELECT COUNT(*) FROM ref_product_version)
UNION ALL SELECT 'core_party', (SELECT COUNT(*) FROM aivb.core_party), (SELECT COUNT(*) FROM core_party)
UNION ALL SELECT 'core_customer', (SELECT COUNT(*) FROM aivb.core_customer), (SELECT COUNT(*) FROM core_customer)
UNION ALL SELECT 'core_customer_kyc_event', (SELECT COUNT(*) FROM aivb.core_customer_kyc_event), (SELECT COUNT(*) FROM core_customer_kyc_event)
UNION ALL SELECT 'core_contract', (SELECT COUNT(*) FROM aivb.core_contract), (SELECT COUNT(*) FROM core_contract)
UNION ALL SELECT 'core_account', (SELECT COUNT(*) FROM aivb.core_account), (SELECT COUNT(*) FROM core_account)
UNION ALL SELECT 'core_account_party', (SELECT COUNT(*) FROM aivb.core_account_party), (SELECT COUNT(*) FROM core_account_party)
UNION ALL SELECT 'core_deposit_contract', (SELECT COUNT(*) FROM aivb.core_deposit_contract), (SELECT COUNT(*) FROM core_deposit_contract)
UNION ALL SELECT 'core_loan_application', (SELECT COUNT(*) FROM aivb.core_loan_application), (SELECT COUNT(*) FROM core_loan_application)
UNION ALL SELECT 'core_loan_contract', (SELECT COUNT(*) FROM aivb.core_loan_contract), (SELECT COUNT(*) FROM core_loan_contract)
UNION ALL SELECT 'core_loan_schedule', (SELECT COUNT(*) FROM aivb.core_loan_schedule), (SELECT COUNT(*) FROM core_loan_schedule)
UNION ALL SELECT 'core_loan_disbursement', (SELECT COUNT(*) FROM aivb.core_loan_disbursement), (SELECT COUNT(*) FROM core_loan_disbursement)
UNION ALL SELECT 'core_loan_payment_allocation', (SELECT COUNT(*) FROM aivb.core_loan_payment_allocation), (SELECT COUNT(*) FROM core_loan_payment_allocation);

SELECT loan_id, outstanding, RANK() OVER (ORDER BY outstanding DESC) AS hang
FROM core_loan_contract WHERE loan_status = 'ACTIVE' ORDER BY outstanding DESC, loan_id LIMIT 7;
