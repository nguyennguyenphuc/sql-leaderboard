-- 01_tao_bang_aivb.sql: 26 bảng AIV Bank (ngân hàng thương mại) cho MySQL 8.0, bản rút gọn của leaderboard.
-- Sinh từ catalog Postgres của lớp (DB aivb_student, schema aivb; information_schema.columns, pg_constraint).
-- Không ghi tên database: chạy sau `USE aivb;` hoặc `USE aivb_hidden_1;` (xem 02_nap_aivb.sh, 03_bien_the_an_aivb.sql).
-- Đổi kiểu so với PG (ghi đủ trong ../README-aivb.md):
--   text -> VARCHAR(n) (n >= 2 x độ dài lớn nhất);  bigint (tiền VND, đồng nguyên) -> BIGINT;  integer -> INT
--   numeric(12,8) (lãi suất dạng phân số/năm, 0.0723 = 7,23%/năm) -> DECIMAL(12,8);  numeric(9,6) -> DECIMAL(9,6)
--   date -> DATE;  timestamp -> DATETIME;  boolean -> TINYINT(1)
-- Khoá: giữ mọi PK/UNIQUE/FK của PG giữa các bảng được chọn; THÊM 3 FK mà PG không khai báo (dữ liệu đã kiểm khớp):
--   core_customer.home_branch_id, core_contract.home_branch_id -> ref_branch;  core_organization.industry_code -> ref_industry.
-- BỎ FK (bảng đích không nạp hoặc bị cắt cửa sổ, giữ nguyên cột):
--   core_loan_disbursement.payment_order_id, core_loan_payment_allocation.payment_order_id (core_payment_order chỉ có năm 2026);
--   core_loan_contract.limit_decision_id (không nạp core_credit_limit_decision); core_interest_accrual.journal_id (không nạp core_journal).
-- Bỏ cột core_customer_kyc_event.seed_uint32 (hạt giống sinh dữ liệu, không có nghĩa nghiệp vụ).

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS core_interest_accrual, core_account_posting, core_payment_order, core_loan_payment_allocation,
  core_loan_disbursement, core_loan_schedule, core_loan_contract, core_credit_decision, core_loan_application,
  core_deposit_contract, core_account_balance, core_account_party, core_account, core_contract,
  core_customer_kyc_event, hist_customer_segment, core_customer, core_organization, core_person, core_party,
  ref_policy_version, ref_industry, ref_product_version, ref_product, ref_segment, ref_branch;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE ref_branch (
  ref_branch_id              VARCHAR(16) NOT NULL,
  branch_code                VARCHAR(24) NOT NULL,
  branch_name                VARCHAR(48) NOT NULL,
  region                     VARCHAR(24) NOT NULL,
  city                       VARCHAR(32) NOT NULL,
  opened_date                DATE NOT NULL,
  status                     VARCHAR(16) NOT NULL,
  PRIMARY KEY (ref_branch_id),
  UNIQUE KEY uq_ref_branch_code (branch_code)
) ENGINE=InnoDB;

CREATE TABLE ref_segment (
  segment_code               VARCHAR(24) NOT NULL,
  segment_name               VARCHAR(48) NOT NULL,
  party_type                 VARCHAR(24) NOT NULL,
  PRIMARY KEY (segment_code)
) ENGINE=InnoDB;

CREATE TABLE ref_product (
  product_id                 VARCHAR(24) NOT NULL,
  product_family             VARCHAR(32) NOT NULL,
  product_name               VARCHAR(80) NOT NULL,
  PRIMARY KEY (product_id)
) ENGINE=InnoDB;

CREATE TABLE ref_product_version (
  product_version_id         VARCHAR(32) NOT NULL,
  product_id                 VARCHAR(24) NOT NULL,
  effective_from             DATE NOT NULL,
  effective_to               DATE NULL,
  product_status             VARCHAR(16) NOT NULL,
  eligible_party_type        VARCHAR(24) NOT NULL,
  interest_rule_id           VARCHAR(24) NULL,
  fee_rule_set_id            VARCHAR(32) NULL,
  accounting_rule_set_id     VARCHAR(32) NOT NULL,
  PRIMARY KEY (product_version_id),
  CONSTRAINT fk_pv_product FOREIGN KEY (product_id) REFERENCES ref_product (product_id)
) ENGINE=InnoDB;

CREATE TABLE ref_industry (
  industry_code              VARCHAR(24) NOT NULL,
  industry_name              VARCHAR(48) NOT NULL,
  PRIMARY KEY (industry_code)
) ENGINE=InnoDB;

CREATE TABLE ref_policy_version (
  policy_version_id          VARCHAR(32) NOT NULL,
  effective_from             DATE NOT NULL,
  effective_to               DATE NOT NULL,
  approval_rate              DECIMAL(9,6) NOT NULL,
  score_cutoff               INT NOT NULL,
  dti_cap                    DECIMAL(9,6) NOT NULL,
  PRIMARY KEY (policy_version_id)
) ENGINE=InnoDB;

CREATE TABLE core_party (
  party_id                   VARCHAR(32) NOT NULL,
  party_type                 VARCHAR(24) NOT NULL,
  legal_name                 VARCHAR(80) NOT NULL,
  party_status               VARCHAR(16) NOT NULL,
  valid_from                 DATE NOT NULL,
  valid_to                   DATE NULL,
  created_at                 DATETIME NOT NULL,
  PRIMARY KEY (party_id)
) ENGINE=InnoDB;

CREATE TABLE core_person (
  party_id                   VARCHAR(32) NOT NULL,
  date_of_birth              DATE NOT NULL,
  gender                     VARCHAR(8) NULL,
  employment_status          VARCHAR(16) NULL,
  occupation_code            VARCHAR(24) NULL,
  marital_status             VARCHAR(16) NOT NULL,
  education_level            VARCHAR(48) NOT NULL,
  dependents_count           INT NOT NULL,
  residence_province         VARCHAR(24) NOT NULL,
  income_band                VARCHAR(24) NOT NULL,
  PRIMARY KEY (party_id),
  CONSTRAINT fk_person_party FOREIGN KEY (party_id) REFERENCES core_party (party_id)
) ENGINE=InnoDB;

CREATE TABLE core_organization (
  party_id                   VARCHAR(32) NOT NULL,
  organization_type          VARCHAR(16) NOT NULL,
  registration_number        VARCHAR(24) NOT NULL,
  employee_size_band         VARCHAR(16) NOT NULL,
  employee_count             INT NOT NULL,
  organization_status        VARCHAR(16) NOT NULL,
  industry_code              VARCHAR(24) NOT NULL,
  revenue_band               VARCHAR(32) NOT NULL,
  PRIMARY KEY (party_id),
  UNIQUE KEY uq_org_registration (registration_number),
  KEY ix_org_industry (industry_code),
  CONSTRAINT fk_org_party FOREIGN KEY (party_id) REFERENCES core_party (party_id),
  CONSTRAINT fk_org_industry FOREIGN KEY (industry_code) REFERENCES ref_industry (industry_code)
) ENGINE=InnoDB;

CREATE TABLE core_customer (
  customer_id                VARCHAR(32) NOT NULL,
  party_id                   VARCHAR(32) NOT NULL,
  customer_since             DATE NOT NULL,
  customer_status            VARCHAR(16) NOT NULL,
  segment_code               VARCHAR(24) NOT NULL,
  home_branch_id             VARCHAR(16) NOT NULL,
  kyc_status                 VARCHAR(16) NOT NULL,
  PRIMARY KEY (customer_id),
  UNIQUE KEY uq_customer_party (party_id),
  KEY ix_customer_segment (segment_code),
  KEY ix_customer_branch (home_branch_id),
  CONSTRAINT fk_customer_party FOREIGN KEY (party_id) REFERENCES core_party (party_id),
  CONSTRAINT fk_customer_segment FOREIGN KEY (segment_code) REFERENCES ref_segment (segment_code),
  CONSTRAINT fk_customer_branch FOREIGN KEY (home_branch_id) REFERENCES ref_branch (ref_branch_id)
) ENGINE=InnoDB;

CREATE TABLE hist_customer_segment (
  hist_customer_segment_id   VARCHAR(48) NOT NULL,
  customer_id                VARCHAR(32) NOT NULL,
  segment_code               VARCHAR(24) NOT NULL,
  valid_from                 DATE NOT NULL,
  valid_to                   DATE NULL,
  PRIMARY KEY (hist_customer_segment_id),
  KEY ix_hcs_customer (customer_id),
  CONSTRAINT fk_hcs_customer FOREIGN KEY (customer_id) REFERENCES core_customer (customer_id),
  CONSTRAINT fk_hcs_segment FOREIGN KEY (segment_code) REFERENCES ref_segment (segment_code)
) ENGINE=InnoDB;

CREATE TABLE core_customer_kyc_event (
  kyc_event_id               VARCHAR(48) NOT NULL,
  customer_id                VARCHAR(32) NOT NULL,
  kyc_cycle_no               INT NOT NULL,
  event_sequence             INT NOT NULL,
  from_status                VARCHAR(16) NULL,
  to_status                  VARCHAR(16) NOT NULL,
  event_type                 VARCHAR(32) NOT NULL,
  event_at                   DATETIME NOT NULL,
  business_date              DATE NOT NULL,
  decision_reason            VARCHAR(64) NULL,
  rule_version               VARCHAR(32) NOT NULL,
  PRIMARY KEY (kyc_event_id),
  KEY ix_kyc_customer (customer_id),
  CONSTRAINT fk_kyc_customer FOREIGN KEY (customer_id) REFERENCES core_customer (customer_id)
) ENGINE=InnoDB;

CREATE TABLE core_contract (
  contract_id                VARCHAR(32) NOT NULL,
  product_version_id         VARCHAR(32) NOT NULL,
  booking_date               DATE NOT NULL,
  effective_date             DATE NOT NULL,
  maturity_date              DATE NULL,
  contract_status            VARCHAR(16) NOT NULL,
  currency                   VARCHAR(8) NOT NULL,
  home_branch_id             VARCHAR(16) NULL,
  PRIMARY KEY (contract_id),
  KEY ix_contract_pv (product_version_id),
  KEY ix_contract_branch (home_branch_id),
  CONSTRAINT fk_contract_pv FOREIGN KEY (product_version_id) REFERENCES ref_product_version (product_version_id),
  CONSTRAINT fk_contract_branch FOREIGN KEY (home_branch_id) REFERENCES ref_branch (ref_branch_id)
) ENGINE=InnoDB;

CREATE TABLE core_account (
  account_id                 VARCHAR(32) NOT NULL,
  contract_id                VARCHAR(32) NOT NULL,
  product_version_id         VARCHAR(24) NOT NULL,
  currency                   VARCHAR(8) NOT NULL,
  open_date                  DATE NOT NULL,
  close_date                 DATE NULL,
  account_status             VARCHAR(16) NOT NULL,
  PRIMARY KEY (account_id),
  KEY ix_account_contract (contract_id),
  KEY ix_account_pv (product_version_id),
  CONSTRAINT fk_account_contract FOREIGN KEY (contract_id) REFERENCES core_contract (contract_id),
  CONSTRAINT fk_account_pv FOREIGN KEY (product_version_id) REFERENCES ref_product_version (product_version_id)
) ENGINE=InnoDB;

CREATE TABLE core_account_party (
  account_party_id           VARCHAR(32) NOT NULL,
  account_id                 VARCHAR(32) NOT NULL,
  party_id                   VARCHAR(32) NOT NULL,
  role_code                  VARCHAR(48) NOT NULL,
  signing_authority_level    VARCHAR(8) NULL,
  transaction_limit          BIGINT NULL,
  valid_from                 DATE NOT NULL,
  valid_to                   DATE NULL,
  PRIMARY KEY (account_party_id),
  KEY ix_ap_account (account_id),
  KEY ix_ap_party (party_id),
  CONSTRAINT fk_ap_account FOREIGN KEY (account_id) REFERENCES core_account (account_id),
  CONSTRAINT fk_ap_party FOREIGN KEY (party_id) REFERENCES core_party (party_id)
) ENGINE=InnoDB;

CREATE TABLE core_account_balance (
  account_id                 VARCHAR(32) NOT NULL,
  current_balance            BIGINT NOT NULL,
  as_of_business_date        DATE NOT NULL,
  PRIMARY KEY (account_id),
  CONSTRAINT fk_balance_account FOREIGN KEY (account_id) REFERENCES core_account (account_id)
) ENGINE=InnoDB;

CREATE TABLE core_deposit_contract (
  deposit_id                 VARCHAR(32) NOT NULL,
  contract_id                VARCHAR(32) NOT NULL,
  settlement_account_id      VARCHAR(32) NOT NULL,
  principal                  BIGINT NOT NULL,
  interest_rate              DECIMAL(12,8) NOT NULL,
  term_months                INT NOT NULL,
  maturity_date              DATE NOT NULL,
  deposit_status             VARCHAR(32) NOT NULL,
  pledged_flag               TINYINT(1) NOT NULL,
  PRIMARY KEY (deposit_id),
  KEY ix_deposit_contract (contract_id),
  KEY ix_deposit_settlement (settlement_account_id),
  CONSTRAINT fk_deposit_contract FOREIGN KEY (contract_id) REFERENCES core_contract (contract_id),
  CONSTRAINT fk_deposit_account FOREIGN KEY (settlement_account_id) REFERENCES core_account (account_id)
) ENGINE=InnoDB;

CREATE TABLE core_loan_application (
  application_id             VARCHAR(32) NOT NULL,
  party_id                   VARCHAR(32) NOT NULL,
  product_id                 VARCHAR(16) NOT NULL,
  policy_version_id          VARCHAR(32) NOT NULL,
  application_date           DATE NOT NULL,
  requested_amount           BIGINT NOT NULL,
  score_band                 VARCHAR(8) NOT NULL,
  dti                        DECIMAL(9,6) NOT NULL,
  application_status         VARCHAR(16) NOT NULL,
  customer_type              VARCHAR(16) NOT NULL,
  PRIMARY KEY (application_id),
  KEY ix_app_party (party_id),
  KEY ix_app_product (product_id),
  CONSTRAINT fk_app_party FOREIGN KEY (party_id) REFERENCES core_party (party_id),
  CONSTRAINT fk_app_product FOREIGN KEY (product_id) REFERENCES ref_product (product_id),
  CONSTRAINT fk_app_policy FOREIGN KEY (policy_version_id) REFERENCES ref_policy_version (policy_version_id)
) ENGINE=InnoDB;

CREATE TABLE core_credit_decision (
  credit_decision_id         VARCHAR(32) NOT NULL,
  application_id             VARCHAR(32) NOT NULL,
  decision_date              DATE NOT NULL,
  decision_status            VARCHAR(16) NOT NULL,
  approved_amount            BIGINT NULL,
  PRIMARY KEY (credit_decision_id),
  KEY ix_decision_app (application_id),
  CONSTRAINT fk_decision_app FOREIGN KEY (application_id) REFERENCES core_loan_application (application_id)
) ENGINE=InnoDB;

CREATE TABLE core_loan_contract (
  loan_id                    VARCHAR(32) NOT NULL,
  contract_id                VARCHAR(32) NOT NULL,
  application_id             VARCHAR(32) NOT NULL,
  limit_decision_id          VARCHAR(32) NULL,
  disbursement_date          DATE NOT NULL,
  principal                  BIGINT NOT NULL,
  outstanding                BIGINT NOT NULL,
  interest_rate              DECIMAL(12,8) NOT NULL,
  tenor_months               INT NOT NULL,
  loan_status                VARCHAR(24) NOT NULL,
  opening_book_flag          TINYINT(1) NOT NULL,
  PRIMARY KEY (loan_id),
  KEY ix_loan_contract (contract_id),
  KEY ix_loan_app (application_id),
  CONSTRAINT fk_loan_contract FOREIGN KEY (contract_id) REFERENCES core_contract (contract_id),
  CONSTRAINT fk_loan_app FOREIGN KEY (application_id) REFERENCES core_loan_application (application_id)
) ENGINE=InnoDB;

CREATE TABLE core_loan_schedule (
  schedule_id                VARCHAR(32) NOT NULL,
  loan_id                    VARCHAR(32) NOT NULL,
  installment_no             INT NOT NULL,
  due_date                   DATE NOT NULL,
  principal_due              BIGINT NOT NULL,
  interest_due               BIGINT NOT NULL,
  principal_paid             BIGINT NOT NULL,
  interest_paid              BIGINT NOT NULL,
  schedule_status            VARCHAR(24) NOT NULL,
  PRIMARY KEY (schedule_id),
  KEY ix_schedule_loan (loan_id),
  KEY ix_schedule_due (due_date),
  CONSTRAINT fk_schedule_loan FOREIGN KEY (loan_id) REFERENCES core_loan_contract (loan_id)
) ENGINE=InnoDB;

CREATE TABLE core_loan_disbursement (
  disbursement_id            VARCHAR(32) NOT NULL,
  loan_id                    VARCHAR(32) NOT NULL,
  amount                     BIGINT NOT NULL,
  disbursement_date          DATE NOT NULL,
  payment_order_id           VARCHAR(48) NOT NULL,
  PRIMARY KEY (disbursement_id),
  KEY ix_disb_loan (loan_id),
  KEY ix_disb_po (payment_order_id),
  CONSTRAINT fk_disb_loan FOREIGN KEY (loan_id) REFERENCES core_loan_contract (loan_id)
) ENGINE=InnoDB;

CREATE TABLE core_loan_payment_allocation (
  allocation_id              VARCHAR(32) NOT NULL,
  loan_id                    VARCHAR(32) NOT NULL,
  payment_order_id           VARCHAR(48) NOT NULL,
  allocation_date            DATE NOT NULL,
  principal_amount           BIGINT NOT NULL,
  interest_amount            BIGINT NOT NULL,
  fee_amount                 BIGINT NOT NULL,
  penalty_amount             BIGINT NOT NULL,
  PRIMARY KEY (allocation_id),
  KEY ix_alloc_loan (loan_id),
  KEY ix_alloc_po (payment_order_id),
  CONSTRAINT fk_alloc_loan FOREIGN KEY (loan_id) REFERENCES core_loan_contract (loan_id)
) ENGINE=InnoDB;

CREATE TABLE core_payment_order (
  payment_order_id           VARCHAR(48) NOT NULL,
  source_system              VARCHAR(48) NOT NULL,
  source_reference           VARCHAR(48) NOT NULL,
  idempotency_key            VARCHAR(128) NOT NULL,
  transaction_type           VARCHAR(48) NOT NULL,
  channel_code               VARCHAR(16) NOT NULL,
  transaction_date           DATE NOT NULL,
  value_date                 DATE NOT NULL,
  amount                     BIGINT NOT NULL,
  currency                   VARCHAR(8) NOT NULL,
  payment_status             VARCHAR(24) NOT NULL,
  PRIMARY KEY (payment_order_id),
  UNIQUE KEY uq_po_idempotency (idempotency_key),
  KEY ix_po_date (transaction_date),
  KEY ix_po_type_date (transaction_type, transaction_date)
) ENGINE=InnoDB;

CREATE TABLE core_account_posting (
  posting_id                 VARCHAR(48) NOT NULL,
  payment_order_id           VARCHAR(48) NOT NULL,
  account_id                 VARCHAR(32) NOT NULL,
  debit_credit               VARCHAR(16) NOT NULL,
  amount                     BIGINT NOT NULL,
  transaction_date           DATE NOT NULL,
  value_date                 DATE NOT NULL,
  posting_date               DATE NOT NULL,
  business_date              DATE NOT NULL,
  running_balance            BIGINT NOT NULL,
  PRIMARY KEY (posting_id),
  KEY ix_posting_account (account_id),
  KEY ix_posting_po (payment_order_id),
  KEY ix_posting_date (transaction_date),
  CONSTRAINT fk_posting_po FOREIGN KEY (payment_order_id) REFERENCES core_payment_order (payment_order_id),
  CONSTRAINT fk_posting_account FOREIGN KEY (account_id) REFERENCES core_account (account_id)
) ENGINE=InnoDB;

CREATE TABLE core_interest_accrual (
  interest_accrual_id        VARCHAR(48) NOT NULL,
  contract_id                VARCHAR(32) NOT NULL,
  accrual_date               DATE NOT NULL,
  accrued_amount             BIGINT NOT NULL,
  journal_id                 VARCHAR(48) NULL,
  PRIMARY KEY (interest_accrual_id),
  KEY ix_accrual_contract (contract_id),
  KEY ix_accrual_date (accrual_date),
  CONSTRAINT fk_accrual_contract FOREIGN KEY (contract_id) REFERENCES core_contract (contract_id)
) ENGINE=InnoDB;

