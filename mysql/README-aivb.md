# MySQL 8.0 cho SQL Leaderboard · bộ dữ liệu Finance · AIV Bank (`aivb`)

Dựng ngày 10/11/2026 trên cùng máy chủ chấm `sqllb-mysql` (MySQL 8.0, mạng `sqllb`, xem `README.md` của bộ `scm`).
Nguồn: Postgres của lớp (`docker-postgres-1`, DB `aivb_student`, schema `aivb`, 77 bảng, ~88 triệu dòng) ở chế độ **chỉ đọc**
(`PGOPTIONS='-c default_transaction_read_only=on'`). AIV Bank là ngân hàng thương mại giả lập: 12 chi nhánh, ~9,1 nghìn khách hàng
(8.880 cá nhân, 400 tổ chức), tài khoản thanh toán (CASA), tiền gửi có kỳ hạn, khoản vay, lệnh thanh toán và bút toán tài khoản.
Mọi số tiền là **đồng (VND), số nguyên `BIGINT`**; lãi suất là **phân số/năm** (`0.0723` = 7,23%/năm).

| Thành phần | Giá trị |
|---|---|
| Database | `aivb` (public), `aivb_hidden_1` (biến thể ẩn) |
| Ánh xạ bộ kiểm | `dulieu=aivb` → public `aivb`, hidden-1 `aivb_hidden_1` (quy tắc mặc định của `kiem_tra_goi.py`, không cần thêm vào `bien-the.json`; đã chạy thử gói `goi-cau-hoi/aivb/_thu`) |
| User chấm | `sql_runner`: thêm `SELECT` trên `aivb`, `aivb\_hidden\_%` (`aivb/04_quyen_aivb.sql`) |
| Script | `mysql/aivb/` (`01_tao_bang_aivb.sql`, `02_nap_aivb.sh`, `03_bien_the_an_aivb.sql`, `04_quyen_aivb.sql`, `04_bo_sung_bien_the_aivb.sql`) |
| CSV trung gian | `mysql/aivb/du-lieu/` (~590 MB, **không** đưa vào gói) |

## Dựng lại

```bash
# container sqllb-mysql đã có (README.md bộ scm, bước 1); mysql/ mount ở /sqllb nên CSV nằm ở /sqllb/aivb/du-lieu/
bash mysql/aivb/02_nap_aivb.sh            # xuất CSV từ PG (chỉ đọc) + tạo bảng + nạp + so số dòng  (~6 phút)
bash mysql/aivb/02_nap_aivb.sh --chi-nap  # dùng lại CSV đã có
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/aivb/03_bien_the_an_aivb.sql   # ~1 phút
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/aivb/04_quyen_aivb.sql
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot --default-character-set=utf8mb4' < mysql/aivb/04_bo_sung_bien_the_aivb.sql   # bổ sung hidden-1, chạy lại được
```

## Bản rút gọn: 26 bảng, cửa sổ và số dòng

Chọn 26/77 bảng: bỏ các bảng `raw_*` (dữ liệu thô trước làm sạch), các bảng học viên chỉ thấy cột khoá (`core_collateral`,
`core_contract_party`, `ref_channel`, `ref_transaction_type`, … chỉ có 1 cột id), sổ cái (`core_gl_entry` 29 triệu, `core_journal`
14 triệu, `core_payment_leg` 15 triệu, `core_payment_settlement`), trả lương, phí/thuế, tái tục tiền gửi, thẩm định doanh nghiệp.
Bảng nhỏ giữ đủ; ba bảng sự kiện lớn lấy **trọn năm 2026** (cửa sổ liền mạch, đủ 12 tháng cho câu theo tháng/MoM).
Tổng **4.821.541 dòng**. Số dòng PG (cùng điều kiện) = MySQL cho cả 26 bảng (`02_nap_aivb.sh` in bảng so sánh, `du-lieu/so-dong-pg.txt`).

| Nhóm | Bảng | Lấy | Số dòng `aivb` | `aivb_hidden_1` |
|---|---|---|---:|---:|
| Thanh toán | `core_account_posting` | **`transaction_date` 2026-01-01 → 2026-12-31** | 2.142.018 | 1.927.813 |
| Thanh toán | `core_payment_order` | **`transaction_date` 2026-01-01 → 2026-12-31** | 1.996.763 | 1.797.081 |
| Tài chính | `core_interest_accrual` | **`accrual_date` 2026-01-01 → 2026-12-31** | 431.528 | 388.379 |
| Tín dụng | `core_loan_schedule` | đủ (`due_date` 2020-02 → 2071-07) | 94.082 | = |
| Tín dụng | `core_loan_payment_allocation` | đủ (2023 → 2026) | 31.950 | = |
| Khách hàng | `core_customer_kyc_event` | đủ | 18.272 | = |
| Hợp đồng | `core_contract` | đủ | 20.027 | = |
| Khách hàng | `core_party` | đủ | 9.280 | = |
| Khách hàng | `core_customer`, `hist_customer_segment` | đủ | 9.136 mỗi bảng | = |
| Tài khoản | `core_account`, `core_account_balance` | đủ | 9.136 mỗi bảng | = |
| Tài khoản | `core_account_party` | đủ | 9.969 | = |
| Khách hàng | `core_person` | đủ | 8.880 | = |
| Huy động | `core_deposit_contract` | đủ | 8.733 | = |
| Tín dụng | `core_loan_disbursement` | đủ | 4.682 | = |
| Tín dụng | `core_loan_application`, `core_credit_decision` | đủ (`application_date` 2019-12 → 2026-12) | 3.128 mỗi bảng | = |
| Tín dụng | `core_loan_contract` | đủ (`disbursement_date` 2020-01 → 2026-12) | 2.089 | = (1 dòng sửa, xem biến thể c) |
| Khách hàng | `core_organization` | đủ | 400 | = |
| Danh mục | `ref_product_version` 18, `ref_product` 14, `ref_branch` 12, `ref_industry` 12, `ref_segment` 8, `ref_policy_version` 4 | đủ | 68 | = |

Vì sao năm 2026: lệnh thanh toán ~160–180 nghìn/tháng và bút toán tương đương, nên 12 tháng của hai bảng (4,1 triệu) cộng lãi dự thu
(0,43 triệu) là cửa sổ tròn lớn nhất để tổng ≲ 6 triệu. Dữ liệu PG chạy 2023-01 → 2027-01-04; trước 2023 chỉ lác đác vài lệnh/tháng.
Người soạn câu cần nhớ:
- **Thanh toán, bút toán, lãi dự thu chỉ có năm 2026**: không có YoY cho các bảng này (MoM, luỹ kế, trượt thì có). Câu nhiều năm/cohort
  dùng `core_loan_application` (2019-12 → 2026-12), `core_loan_contract`, `core_loan_schedule`, `core_loan_payment_allocation` (2023 → 2026),
  `core_deposit_contract`, `core_customer.customer_since` (2018 → 2026), `core_customer_kyc_event`.
- Ngày có lệnh đầu tiên trong cửa sổ là **2026-01-05** (01–04/01/2026 không có lệnh trong nguồn), ngày cuối 2026-12-31.
- `core_loan_disbursement.payment_order_id`, `core_loan_payment_allocation.payment_order_id` trỏ cả tới lệnh ngoài năm 2026 (không có FK);
  JOIN với `core_payment_order` sẽ mất dòng trước 2026.
- Ngày tham chiếu đề nghị cho "hiện tại"/số ngày quá hạn: **2026-12-31** (ghi rõ trong đề).

## Quan hệ (ERD dạng chữ)

```text
ref_branch (ref_branch_id 'CN01'..'CN12') 1─n core_customer.home_branch_id, core_contract.home_branch_id
ref_segment (segment_code) 1─n core_customer.segment_code, hist_customer_segment.segment_code
ref_industry (industry_code) 1─n core_organization.industry_code
ref_product (product_id) 1─n ref_product_version.product_id, core_loan_application.product_id
ref_product_version (product_version_id) 1─n core_contract, core_account
ref_policy_version (policy_version_id) 1─n core_loan_application

core_party (party_id; party_type PERSON|ORGANIZATION)
  1─1 core_person.party_id | core_organization.party_id
  1─1 core_customer.party_id (UNIQUE)           core_customer 1─n hist_customer_segment, core_customer_kyc_event
  1─n core_account_party.party_id ─n─1 core_account   (cầu nối khách hàng ↔ tài khoản; có đồng sở hữu, người được uỷ quyền)
  1─n core_loan_application.party_id

core_contract (contract_id: hợp đồng chung cho CASA, tiền gửi, khoản vay)
  1─n core_account.contract_id                  core_account 1─1 core_account_balance
  1─1 core_deposit_contract.contract_id         core_deposit_contract.settlement_account_id n─1 core_account
  1─1 core_loan_contract.contract_id
  1─n core_interest_accrual.contract_id          (lãi dự thu: cả hợp đồng tiền gửi và hợp đồng vay)

core_loan_application 1─1 core_credit_decision.application_id
core_loan_application 1─(0..1) core_loan_contract.application_id
core_loan_contract 1─n core_loan_schedule, core_loan_disbursement, core_loan_payment_allocation

core_payment_order (payment_order_id) 1─n core_account_posting.payment_order_id ─n─1 core_account
```

Đường đi hay dùng: khách hàng → tài khoản: `core_customer.party_id = core_account_party.party_id` → `core_account`;
khách hàng → khoản vay: `core_customer.party_id = core_loan_application.party_id` → `core_loan_contract.application_id`;
khoản vay/tiền gửi → chi nhánh, sản phẩm: `contract_id` → `core_contract.home_branch_id`, `product_version_id` → `ref_product_version.product_id`.

## Kiểu cột so với Postgres

DDL ở `aivb/01_tao_bang_aivb.sql`, sinh từ catalog PG; tên bảng, tên cột giữ nguyên.

| PG | MySQL | Cột |
|---|---|---|
| `text` | `VARCHAR(n)`, n ≥ 2 × độ dài lớn nhất | mọi khoá dạng `SYN_CUS_0000001`, mã trạng thái, tên |
| `bigint` | `BIGINT` | mọi số tiền (đồng): `amount`, `principal`, `outstanding`, `current_balance`, `running_balance`, `accrued_amount`, `*_due`, `*_paid`, … |
| `numeric(12,8)` | `DECIMAL(12,8)` | `interest_rate` (loan, deposit) |
| `numeric(9,6)` | `DECIMAL(9,6)` | `dti`, `approval_rate`, `dti_cap` |
| `date` | `DATE` | mọi cột ngày (không có ngày dạng chuỗi) |
| `timestamp` | `DATETIME` | `core_party.created_at`, `core_customer_kyc_event.event_at` |
| `boolean` | `TINYINT(1)` (0/1) | `core_deposit_contract.pledged_flag`, `core_loan_contract.opening_book_flag` |

Khoá: giữ mọi PK, UNIQUE (`branch_code`, `registration_number`, `core_customer.party_id`, `idempotency_key`) và FK của PG giữa các bảng chọn;
**thêm** 3 FK PG không khai báo (dữ liệu khớp 100%): `core_customer.home_branch_id`, `core_contract.home_branch_id` → `ref_branch`,
`core_organization.industry_code` → `ref_industry`; **bỏ** FK tới bảng không nạp hoặc bị cắt cửa sổ (giữ cột):
`core_loan_disbursement.payment_order_id`, `core_loan_payment_allocation.payment_order_id`, `core_loan_contract.limit_decision_id`,
`core_interest_accrual.journal_id`. Bỏ cột `core_customer_kyc_event.seed_uint32` (hạt giống sinh dữ liệu).
Chỉ mục thêm cho câu optimize: `core_payment_order(transaction_date)`, `(transaction_type, transaction_date)`;
`core_account_posting(account_id)`, `(payment_order_id)`, `(transaction_date)`; `core_interest_accrual(contract_id)`, `(accrual_date)`;
`core_loan_schedule(loan_id)`, `(due_date)`; các cột FK đều có chỉ mục.

## Bẫy dữ liệu đã kiểm (số thật trên `aivb`)

| Bẫy | Số liệu | Hệ quả khi viết SQL |
|---|---|---|
| Trạng thái lệnh thanh toán | 2026: `COMPLETED` 1.977.978, `REVERSED` 13.346 (21,3 tỷ đ), `REJECTED` 5.439 (8,9 tỷ đ) | "giao dịch thành công/doanh số thanh toán" phải lọc `payment_status = 'COMPLETED'` |
| Ghi Nợ / ghi Có | `core_account_posting`: `amount` luôn dương; chiều do `debit_credit` (`DEBIT` ~2/3, `CREDIT` ~1/3) | dòng tiền ròng = Σ CREDIT − Σ DEBIT; `SUM(amount)` trần là sai |
| Ngày hiệu lực khác ngày giao dịch | 325.613 bút toán 2026 có `value_date` ≠ `transaction_date` | đề phải nói rõ lọc theo ngày nào |
| Lãi dồn tích trộn hai loại hợp đồng (lãi dự trả tiền gửi + lãi dự thu cho vay; STYLE-aivb.md F.6) | `core_interest_accrual` tháng 12/2026: 43.548 dòng hợp đồng tiền gửi, 1.023 dòng hợp đồng vay | lãi cho vay phải JOIN `core_loan_contract` (hoặc tiền gửi `core_deposit_contract`) theo `contract_id` |
| Lãi suất là phân số | `interest_rate` vay 0,0286–0,0969 (TB 0,0723); tiền gửi 0,017–0,086 | nhân 100 khi in "%"; bình quân gia quyền theo dư nợ ≠ `AVG` |
| Dư nợ 0 | `SETTLED` 1.271 và `WRITTEN_OFF` 17 khoản có `outstanding` = 0; dư nợ đang có: ACTIVE 714 (656,6 tỷ), DELINQUENT 63 (17,7 tỷ), RESTRUCTURED 24 (11,6 tỷ) | "dư nợ" chỉ tính khoản còn dư nợ; `AVG(outstanding)` toàn bảng bị kéo xuống |
| Nợ quá hạn không có số ngày | 374 kỳ `OVERDUE` của 93 khoản vay (63 DELINQUENT, 13 RESTRUCTURED, 17 WRITTEN_OFF), `due_date` 2023-11-08 → 2026-12-30 | số ngày quá hạn = ngày tham chiếu − `MIN(due_date)` kỳ OVERDUE; nhóm nợ theo TT 31/2024/TT-NHNN |
| Trùng tên | 2.512 tên `legal_name` dùng chung cho > 1 `party_id` | gom nhóm theo khoá, không theo tên |
| Đồng sở hữu tài khoản | 744 tài khoản có > 1 dòng `core_account_party` (`JOINT_OWNER` 273, `AUTHORIZED_SIGNER` 333, `VIEW_ONLY` 227); 661 dòng có `valid_to` | JOIN khách hàng ↔ tài khoản nhân bản tiền; chủ tài khoản là `role_code = 'PRIMARY_OWNER'` (9.136 dòng, đúng 1/tài khoản) |
| NULL | `approved_amount` NULL ở 1.009 quyết định `REJECTED`; `close_date` NULL ở 8.537 tài khoản chưa đóng; `occupation_code` NULL 2.223 người; `limit_decision_id` NULL đa số | `COUNT(cột)` ≠ `COUNT(*)`; `AVG` bỏ NULL |
| Khách hàng không vay | 6.634/9.136 khách hàng không có hồ sơ vay; 528 bên có > 1 hồ sơ | INNER JOIN làm mất khách; đếm khách dùng `COUNT(DISTINCT)` |
| Tài khoản không phát sinh | 952 tài khoản không có bút toán năm 2026 | báo cáo "mọi tài khoản" cần LEFT JOIN |
| Số dư khác ngày | `core_account_balance.as_of_business_date`: ACTIVE 2026-10-27 → 2027-01-04, CLOSED dừng sớm (tới 2026-12-30), DORMANT từ 2022-07-08 | "số dư hiện tại" là số dư tại ngày riêng của từng tài khoản |
| Lịch trả nợ kéo dài | `due_date` tới 2071-07 (vay mua nhà); 277 kỳ `CANCELLED` | lọc kỳ đến hạn theo ngày tham chiếu; bỏ kỳ CANCELLED |
| Phân khúc không có lịch sử | `hist_customer_segment`: đúng 1 dòng/khách, mọi `valid_to` NULL | không ra câu SCD/đổi phân khúc trên bảng này |
| KYC 1 chu kỳ | `kyc_cycle_no` luôn 1; mỗi khách: `KYC_SUBMITTED` → `KYC_APPROVED` (8.862) hoặc `KYC_REJECTED` (274) | phễu 2 bước; thời gian duyệt = `event_at` chênh lệch |

## Biến thể ẩn `aivb_hidden_1` (`aivb/03_bien_the_an_aivb.sql`)

Bản sao `aivb` rồi đổi như sau (khuôn `datathon_2026_hidden_1`, `scm_hidden_1`):

| Biến thể · thay đổi | Khác public ở đâu | Bắt lỗi gì |
|---|---|---|
| (a) bỏ lệnh `RIGHT(payment_order_id,1) = '7'` cùng mọi bút toán của chúng | `core_payment_order` −199.683 dòng (10,0%); `core_account_posting` −214.206 | bài chép số từ lần Chạy thử public; mọi con số về thanh toán, bút toán đều khác |
| (a) bỏ lãi dự thu `RIGHT(interest_accrual_id,1) = '7'` | `core_interest_accrual` −43.150 dòng | như trên, cho câu về lãi |
| (b) thêm lệnh `SYN_PMO_Z0000001` ngày **2027-01-01** (MOBILE, TRANSFER, COMPLETED, 475.000 đ; chép `SYN_PMO_C006968466`) + bút toán `SYN_POS_0007815461` (DEBIT tài khoản `SYN_ACC_0003225`) | 1 dòng sau ngày cuối 2026-12-31 ở mỗi bảng | **thiếu cận trên** khi lọc năm 2026 / tháng 12/2026 / "từ ngày X" (`transaction_date >= '2026-12-01'` không có `< '2027-01-01'`); lấy "ngày mới nhất" bằng `MAX` |
| (b) thêm lãi dự thu `SYN_INA_001542188` ngày **2027-01-01** (hợp đồng vay `SYN_CTR_0018613`) | 1 dòng sau 2026-12-31 | thiếu cận trên với `accrual_date` |
| (c) đặt `outstanding` của `SYN_LON_0001621` = 9.955.838.081 (public 9.934.027.410) | **top 5 khoản vay ACTIVE theo dư nợ**: hạng 5 `SYN_LON_0000675` = hạng 6 `SYN_LON_0001621` = 9.955.838.081 (sau (i): hoà 3 khoản ở hạng 5) | dùng `RANK()`/`DENSE_RANK()` khi đề yêu cầu đúng 5 dòng (ra 7 dòng sau (i)); thiếu quy tắc hoà (đề nên ghi "bằng nhau thì `loan_id` nhỏ hơn trước"); tổng dư nợ ACTIVE hidden-1 lớn hơn public |

**Bổ sung `aivb/04_bo_sung_bien_the_aivb.sql`** (chạy sau `03`, lặp lại được: xoá dòng giả theo khoá rồi chèn lại). Lý do: (a)–(c) chỉ đổi
thanh toán, bút toán, lãi dự thu, 1 dư nợ nên ~60 câu chỉ dùng danh mục/khách hàng/tín dụng cho kết quả public = hidden-1 (chép kết quả
Chạy thử vẫn qua). Thêm **một cụm khách hàng giả đủ quan hệ**, khoá có chữ `H` (`CN13`, `SYN_PTY_PH0000x`, `SYN_PTY_OH00001`,
`SYN_CUS_H00000x`, `SYN_CTR_H00000x`, `SYN_ACC_H00000x`, `SYN_APT_H00000x`, `SYN_DEP_H00000x`, `SYN_LNA_H00000x`, `SYN_CRD_H00000x`,
`SYN_LON_H00000x`, `SYN_LSC_H*`, `SYN_LDS_H*`, `SYN_LAL_H*`, `SYN_PMO_H000000x`) trừ `SYN_LON_0000000` (cần `loan_id` nhỏ nhất cho cặp hoà):

| Biến thể · thay đổi | Khác public ở đâu (số dòng thật) | Bắt lỗi gì / câu đổi kết quả |
|---|---|---|
| (d) chi nhánh `CN13` "Chi nhánh Quận 3" (`MIEN_NAM`, TP. Hồ Chí Minh); phiên bản `TD_IND_V2026H2` từ 2026-07-01, `TD_IND_V2026` kết thúc 2026-06-30 | `ref_branch` +1 (13); `ref_product_version` +1 (19), 1 dòng sửa `effective_to` | chép kết quả câu danh mục (chi nhánh miền Nam, tên có "Quận", phiên bản tiền gửi); nhóm theo chi nhánh/vùng có thêm dòng |
| (e) 4 chủ thể, 4 khách hàng: PH1 Huế, `RETIRED`, `occupation_code` NULL, CN06, không có hồ sơ vay; PH2 Đà Nẵng sinh 1990, `PRIORITY`, CN08 (Quận 1); PH3 `kyc_status = 'FAIL'`, CN01, KYC nộp 10/12/2025 – từ chối 12/12/2025; OH1 "Ho Kinh Doanh Phuong Nam F&B", mã số đăng ký `0100000125-001` (đơn vị phụ thuộc), `MICRO`, CN13, KYC duyệt sau 7 ngày | `core_party` +4, `core_person` +3, `core_organization` +1, `core_customer` +4, `hist_customer_segment` +4, `core_customer_kyc_event` +8 | đếm/lọc khách theo chi nhánh, phân khúc, KYC, tỉnh, năm sinh, thiếu nghề nghiệp, tên `LIKE`, mã đăng ký `LIKE` |
| (f) 3 tài khoản thanh toán: `SYN_ACC_H000001` (PH2, mở 2024-06-15, số dư 2.486.500.000 đ), `SYN_ACC_H000002` (PH3, mở 2025-12-10, **đóng 2026-09-15**), `SYN_ACC_H000003` (OH1, mở 2024-02-01); PH1 là `JOINT_OWNER` còn hiệu lực của `SYN_ACC_H000001` | `core_contract` +8 (cả hợp đồng tiền gửi, vay), `core_account` +3, `core_account_balance` +3, `core_account_party` +4 | tài khoản mở năm 2024, đang mở ngày 30/06/2026, đóng năm 2026, số dư theo phân khúc/chi nhánh, Pareto số dư, đồng chủ tài khoản |
| (g) tiền gửi `SYN_DEP_H000001` ACTIVE 12 tháng, 500 triệu đ, lãi 0,057 (cao hơn bình quân kỳ hạn 12 tháng ≥ 0,5 điểm), đến hạn 2027-01-20 (PH2, CN08); `SYN_DEP_H000002` TD_BIZ 12 tháng, 800 triệu đ, lãi 0,049 (OH1, CN13) | `core_deposit_contract` +2 | lãi suất > 5%, đến hạn tháng 1/2027, bình quân lãi theo kỳ hạn, bán chéo tiền gửi – vay |
| (h) 5 hồ sơ + quyết định: `SYN_LNA_H000001` MORT hạng A duyệt (nộp 2025-04-10); `SYN_LNA_H000003` CONS duyệt (nộp 2025-12-15); `SYN_LNA_H000004` WC_LOAN doanh nghiệp duyệt (nộp 2026-03-10); `SYN_LNA_H000002` WC_LOAN doanh nghiệp xin 5 tỷ đ (= mức lớn nhất WC_LOAN) bị từ chối (nộp 2026-11-05, quyết định 2026-12-03, `approved_amount` NULL); `SYN_LNA_H000005` CONS của PH2 duyệt 28/12/2026, **chưa có khoản vay** | `core_loan_application` +5, `core_credit_decision` +5 | hồ sơ năm 2025/2026, theo hạng, DTI, sản phẩm, tỷ lệ duyệt, hồ sơ mới nhất, hồ sơ lớn nhất theo sản phẩm, quyết định thiếu số tiền duyệt tháng 12/2026, hồ sơ duyệt chưa có khoản vay |
| (i) khoản vay `SYN_LON_0000000` (PH2, MORT, CN08) ACTIVE, giải ngân **2025-04-30** (ngày cuối tháng) 11 tỷ đ, dư nợ **9.955.838.081** = cặp hoà (c); 20 kỳ PAID 05/2025–12/2026, kỳ 21 DUE | `core_loan_contract` +1, `core_loan_schedule` +21, `core_loan_disbursement` +1, `core_loan_payment_allocation` +20 | top 5 có quy tắc hoà `loan_id` nhỏ hơn trước: hidden-1 vào `SYN_LON_0000000` thay `SYN_LON_0000675` (bài chép kết quả rớt); `RANK() <= 5` ra 7 dòng |
| (j) khoản vay `SYN_LON_H000003` (PH3, CONS 150 triệu đ, CN01) **RESTRUCTURED**, giải ngân 2025-12-31, 24 kỳ: 1–9 PAID, kỳ 10 (2026-10-31) **OVERDUE trả một phần**, kỳ 11 OVERDUE chưa trả, 12–24 DUE; dư nợ 91.750.000 | `core_loan_contract` +1, `core_loan_schedule` +24, `core_loan_disbursement` +1, `core_loan_payment_allocation` +10 | kỳ quá hạn, số tiền còn thiếu, nhóm nợ, người vay quá hạn, tỷ lệ khoản vay có vấn đề |
| (k) khoản vay `SYN_LON_H000004` (OH1, WC_LOAN 1,5 tỷ đ, CN13) ACTIVE, giải ngân 2 lần 2026-03-31 (1 tỷ) và 2026-06-30 (0,5 tỷ), trả lãi hằng tháng, gốc cuối kỳ; 2 lệnh giải ngân `SYN_PMO_H0000003`, `SYN_PMO_H0000004` (`LOAN_DISBURSEMENT`, COMPLETED, khuôn lệnh `SYN_LENDING`) **không có bút toán** | `core_loan_contract` +1, `core_loan_schedule` +12, `core_loan_disbursement` +2, `core_loan_payment_allocation` +9, `core_payment_order` +2 | giải ngân WC_LOAN 2026 luỹ kế, giải ngân theo năm, top 3 theo chi nhánh, lệnh COMPLETED thiếu bút toán |

Phân bổ trả nợ giả trỏ tới lệnh `SYN_PMO_H1…`, giải ngân (i), (j) tới `SYN_PMO_H0000001`, `SYN_PMO_H0000002`: các lệnh này không có trong `core_payment_order`
(như dữ liệu thật trước 2026, không có FK). Cụm giả không có bút toán, lãi dự thu; lệnh thanh toán chỉ có 2 lệnh giải ngân (k).

Không bảng nào tham chiếu tới `core_payment_order` ngoài `core_account_posting` (bỏ cùng lệnh) nên FK nguyên vẹn; `running_balance`
của bút toán còn lại không được tính lại (đừng ra câu đối soát `running_balance` liên tiếp trên hidden-1). Muốn bẫy mới thì thêm
`aivb_hidden_2` theo cùng cách và ghi vào bảng này.

## File

| File | Việc |
|---|---|
| `aivb/01_tao_bang_aivb.sql` | 26 bảng, PK/UNIQUE/FK/index; không ghi tên database (dùng cho `aivb` và `aivb_hidden_1`) |
| `aivb/02_nap_aivb.sh` | xuất CSV từ PG (`COPY … TO STDOUT WITH CSV HEADER`, `NULL '\N'`, boolean → 0/1), tạo `aivb`, `LOAD DATA LOCAL INFILE`, `ANALYZE`, so số dòng |
| `aivb/03_bien_the_an_aivb.sql` | tạo `aivb_hidden_1` (gọi `SOURCE /sqllb/aivb/01_tao_bang_aivb.sql`), in số dòng và cặp hoà |
| `aivb/04_quyen_aivb.sql` | `GRANT SELECT` cho `sql_runner` trên `aivb`, `aivb\_hidden\_%` (không tạo lại user) |
| `aivb/04_bo_sung_bien_the_aivb.sql` | bổ sung `aivb_hidden_1`: cụm khách hàng giả (d)–(j), chạy sau `03`, lặp lại được |
| `aivb/du-lieu/` | CSV xuất từ PG + `so-dong-pg.txt` (không đưa vào gói) |
| `../style/STYLE-aivb.md`, `../goi-cau-hoi/aivb/BAN-DO-100-CAU.md` | bộ chuẩn thuật ngữ, bản đồ 100 câu |
