-- 03_bien_the_an_aivb.sql: biến thể ẩn aivb_hidden_1 (chấm câu có bokiemtra={public, hidden-1}).
-- Chạy sau 02_nap_aivb.sh, trong container sqllb-mysql (thư mục mysql/ mount ở /sqllb):
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/aivb/03_bien_the_an_aivb.sql
-- Khuôn datathon_2026_hidden_1 / scm_hidden_1 (CHOT-FORMAT-CAU-HOI.md mục 6). Mọi thay đổi ghi ở ../README-aivb.md, bảng "Biến thể".
--   (a) bỏ ~10% dòng của bảng sự kiện chính theo chữ số cuối của khoá = 7:
--       core_payment_order (+ mọi bút toán core_account_posting của các lệnh đó, giữ FK), core_interest_accrual
--   (b) thêm 1 dòng ngay sau ngày cuối 2026-12-31: lệnh thanh toán + bút toán của nó, 1 dòng lãi dự thu, ngày 2027-01-01
--   (c) tạo 1 cặp hoà hạng 5/6 trong top 5 khoản vay ACTIVE theo dư nợ (outstanding)

DROP DATABASE IF EXISTS aivb_hidden_1;
CREATE DATABASE aivb_hidden_1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE aivb_hidden_1;
SOURCE /sqllb/aivb/01_tao_bang_aivb.sql

-- ------------------------------------------------------------------ chép nguyên aivb
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO ref_branch                   SELECT * FROM aivb.ref_branch;
INSERT INTO ref_segment                  SELECT * FROM aivb.ref_segment;
INSERT INTO ref_product                  SELECT * FROM aivb.ref_product;
INSERT INTO ref_product_version          SELECT * FROM aivb.ref_product_version;
INSERT INTO ref_industry                 SELECT * FROM aivb.ref_industry;
INSERT INTO ref_policy_version           SELECT * FROM aivb.ref_policy_version;
INSERT INTO core_party                   SELECT * FROM aivb.core_party;
INSERT INTO core_person                  SELECT * FROM aivb.core_person;
INSERT INTO core_organization            SELECT * FROM aivb.core_organization;
INSERT INTO core_customer                SELECT * FROM aivb.core_customer;
INSERT INTO hist_customer_segment        SELECT * FROM aivb.hist_customer_segment;
INSERT INTO core_customer_kyc_event      SELECT * FROM aivb.core_customer_kyc_event;
INSERT INTO core_contract                SELECT * FROM aivb.core_contract;
INSERT INTO core_account                 SELECT * FROM aivb.core_account;
INSERT INTO core_account_party           SELECT * FROM aivb.core_account_party;
INSERT INTO core_account_balance         SELECT * FROM aivb.core_account_balance;
INSERT INTO core_deposit_contract        SELECT * FROM aivb.core_deposit_contract;
INSERT INTO core_loan_application        SELECT * FROM aivb.core_loan_application;
INSERT INTO core_credit_decision         SELECT * FROM aivb.core_credit_decision;
INSERT INTO core_loan_contract           SELECT * FROM aivb.core_loan_contract;
INSERT INTO core_loan_schedule           SELECT * FROM aivb.core_loan_schedule;
INSERT INTO core_loan_disbursement       SELECT * FROM aivb.core_loan_disbursement;
INSERT INTO core_loan_payment_allocation SELECT * FROM aivb.core_loan_payment_allocation;
-- (a) bỏ ~10% theo chữ số cuối của khoá ngay khi chép (SYN_PMO_C006000007, SYN_INA_000000017, ...)
INSERT INTO core_payment_order    SELECT * FROM aivb.core_payment_order    WHERE RIGHT(payment_order_id, 1) <> '7';
INSERT INTO core_account_posting  SELECT * FROM aivb.core_account_posting  WHERE RIGHT(payment_order_id, 1) <> '7';
INSERT INTO core_interest_accrual SELECT * FROM aivb.core_interest_accrual WHERE RIGHT(interest_accrual_id, 1) <> '7';
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ (b) 1 dòng ngay ngoài cận trên (2026-12-31)
-- Lệnh SYN_PMO_Z0000001 ngày 2027-01-01: chép lệnh SYN_PMO_C006968466 (MOBILE, TRANSFER, COMPLETED, 475.000 đ, 1 bút toán).
INSERT INTO core_payment_order
SELECT 'SYN_PMO_Z0000001', source_system, CONCAT(source_reference, '-H1'), CONCAT(idempotency_key, '-H1'),
       transaction_type, channel_code, '2027-01-01', '2027-01-01', amount, currency, payment_status
FROM aivb.core_payment_order WHERE payment_order_id = 'SYN_PMO_C006968466';

INSERT INTO core_account_posting
SELECT 'SYN_POS_0007815461', 'SYN_PMO_Z0000001', account_id, debit_credit, amount,
       '2027-01-01', '2027-01-01', '2027-01-01', '2027-01-01',
       running_balance - CASE debit_credit WHEN 'DEBIT' THEN amount ELSE -amount END
FROM aivb.core_account_posting WHERE posting_id = 'SYN_POS_0003190444';

-- Lãi dự thu ngày 2027-01-01 của hợp đồng vay SYN_CTR_0018613 (chép dòng SYN_INA_000018773 ngày 2026-12-31).
INSERT INTO core_interest_accrual
SELECT 'SYN_INA_001542188', contract_id, '2027-01-01', accrued_amount, NULL
FROM aivb.core_interest_accrual WHERE interest_accrual_id = 'SYN_INA_000018773';

-- ------------------------------------------------------------------ (c) cặp hoà hạng
-- Top 5 khoản vay ACTIVE theo outstanding (public): hạng 5 SYN_LON_0000675 = 9.955.838.081, hạng 6 SYN_LON_0001621 = 9.934.027.410.
-- Đặt SYN_LON_0001621 = 9.955.838.081 -> hoà hạng 5. ROW_NUMBER() ... ORDER BY outstanding DESC, loan_id giữ SYN_LON_0000675;
-- RANK()/DENSE_RANK() <= 5 trả 6 dòng; ORDER BY outstanding DESC LIMIT 5 không có quy tắc hoà thì kết quả không tất định.
UPDATE core_loan_contract SET outstanding = 9955838081 WHERE loan_id = 'SYN_LON_0001621';

ANALYZE TABLE core_payment_order, core_account_posting, core_interest_accrual, core_loan_contract;

-- ------------------------------------------------------------------ kiểm tra nhanh
SELECT 'core_payment_order' AS bang, (SELECT COUNT(*) FROM aivb.core_payment_order) AS public, COUNT(*) AS hidden_1 FROM core_payment_order
UNION ALL SELECT 'core_account_posting', (SELECT COUNT(*) FROM aivb.core_account_posting), COUNT(*) FROM core_account_posting
UNION ALL SELECT 'core_interest_accrual', (SELECT COUNT(*) FROM aivb.core_interest_accrual), COUNT(*) FROM core_interest_accrual;

SELECT loan_id, outstanding, RANK() OVER (ORDER BY outstanding DESC) AS hang
FROM core_loan_contract WHERE loan_status = 'ACTIVE' ORDER BY outstanding DESC, loan_id LIMIT 7;
