#!/usr/bin/env bash
# 02_nap_aivb.sh: xuất bản rút gọn AIV Bank từ Postgres của lớp (CHỈ ĐỌC) rồi nạp vào MySQL `aivb`.
#
#   bash mysql/aivb/02_nap_aivb.sh            # xuất CSV + tạo bảng + nạp + so số dòng
#   bash mysql/aivb/02_nap_aivb.sh --chi-nap  # bỏ bước xuất (dùng CSV có sẵn trong mysql/aivb/du-lieu/)
#
# Yêu cầu: container docker-postgres-1 (PG của lớp, DB aivb_student, schema aivb) đang chạy; container sqllb-mysql đã
# dựng (xem mysql/README.md), thư mục mysql/ mount vào /sqllb (chỉ đọc) -> CSV ở /sqllb/aivb/du-lieu/.
# Postgres chỉ được đọc: mọi lệnh psql chạy với default_transaction_read_only=on.
# Mật khẩu root MySQL lấy từ biến môi trường trong container, không đi qua dòng lệnh của máy.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

HERE="$(cd "$(dirname "$0")" && pwd)"
DATA="$HERE/du-lieu"
PG_CT=docker-postgres-1
PG_DB=aivb_student
MY_CT=sqllb-mysql
DB=aivb
mkdir -p "$DATA"

# ------------------------------------------------------------ cửa sổ dữ liệu (ghi lại ở README-aivb.md)
# core_payment_order, core_account_posting: transaction_date trong [TU, DEN); core_interest_accrual: accrual_date trong [TU, DEN)
TU='2026-01-01'; DEN='2027-01-01'                   # trọn năm 2026

pg() { docker exec -i -e "PGOPTIONS=-c default_transaction_read_only=on" "$PG_CT" psql -U postgres -d "$PG_DB" -X -v ON_ERROR_STOP=1 "$@"; }
my() { docker exec -i "$MY_CT" sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -uroot --local-infile=1 --default-character-set=utf8mb4 "$@"' mysql "$@"; }

b() { echo "CASE WHEN $1 THEN 1 WHEN NOT $1 THEN 0 END AS $1"; }   # boolean -> 0/1

# bảng | danh sách cột (thứ tự cột MySQL) | biểu thức SELECT trên PG | điều kiện WHERE
# Thứ tự = thứ tự nạp (bảng cha trước).
BANG=(
"ref_branch|ref_branch_id,branch_code,branch_name,region,city,opened_date,status|ref_branch_id, branch_code, branch_name, region, city, opened_date, status|"
"ref_segment|segment_code,segment_name,party_type|segment_code, segment_name, party_type|"
"ref_product|product_id,product_family,product_name|product_id, product_family, product_name|"
"ref_product_version|product_version_id,product_id,effective_from,effective_to,product_status,eligible_party_type,interest_rule_id,fee_rule_set_id,accounting_rule_set_id|product_version_id, product_id, effective_from, effective_to, product_status, eligible_party_type, interest_rule_id, fee_rule_set_id, accounting_rule_set_id|"
"ref_industry|industry_code,industry_name|industry_code, industry_name|"
"ref_policy_version|policy_version_id,effective_from,effective_to,approval_rate,score_cutoff,dti_cap|policy_version_id, effective_from, effective_to, approval_rate, score_cutoff, dti_cap|"
"core_party|party_id,party_type,legal_name,party_status,valid_from,valid_to,created_at|party_id, party_type, legal_name, party_status, valid_from, valid_to, created_at|"
"core_person|party_id,date_of_birth,gender,employment_status,occupation_code,marital_status,education_level,dependents_count,residence_province,income_band|party_id, date_of_birth, gender, employment_status, occupation_code, marital_status, education_level, dependents_count, residence_province, income_band|"
"core_organization|party_id,organization_type,registration_number,employee_size_band,employee_count,organization_status,industry_code,revenue_band|party_id, organization_type, registration_number, employee_size_band, employee_count, organization_status, industry_code, revenue_band|"
"core_customer|customer_id,party_id,customer_since,customer_status,segment_code,home_branch_id,kyc_status|customer_id, party_id, customer_since, customer_status, segment_code, home_branch_id, kyc_status|"
"hist_customer_segment|hist_customer_segment_id,customer_id,segment_code,valid_from,valid_to|hist_customer_segment_id, customer_id, segment_code, valid_from, valid_to|"
"core_customer_kyc_event|kyc_event_id,customer_id,kyc_cycle_no,event_sequence,from_status,to_status,event_type,event_at,business_date,decision_reason,rule_version|kyc_event_id, customer_id, kyc_cycle_no, event_sequence, from_status, to_status, event_type, event_at, business_date, decision_reason, rule_version|"
"core_contract|contract_id,product_version_id,booking_date,effective_date,maturity_date,contract_status,currency,home_branch_id|contract_id, product_version_id, booking_date, effective_date, maturity_date, contract_status, currency, home_branch_id|"
"core_account|account_id,contract_id,product_version_id,currency,open_date,close_date,account_status|account_id, contract_id, product_version_id, currency, open_date, close_date, account_status|"
"core_account_party|account_party_id,account_id,party_id,role_code,signing_authority_level,transaction_limit,valid_from,valid_to|account_party_id, account_id, party_id, role_code, signing_authority_level, transaction_limit, valid_from, valid_to|"
"core_account_balance|account_id,current_balance,as_of_business_date|account_id, current_balance, as_of_business_date|"
"core_deposit_contract|deposit_id,contract_id,settlement_account_id,principal,interest_rate,term_months,maturity_date,deposit_status,pledged_flag|deposit_id, contract_id, settlement_account_id, principal, interest_rate, term_months, maturity_date, deposit_status, $(b pledged_flag)|"
"core_loan_application|application_id,party_id,product_id,policy_version_id,application_date,requested_amount,score_band,dti,application_status,customer_type|application_id, party_id, product_id, policy_version_id, application_date, requested_amount, score_band, dti, application_status, customer_type|"
"core_credit_decision|credit_decision_id,application_id,decision_date,decision_status,approved_amount|credit_decision_id, application_id, decision_date, decision_status, approved_amount|"
"core_loan_contract|loan_id,contract_id,application_id,limit_decision_id,disbursement_date,principal,outstanding,interest_rate,tenor_months,loan_status,opening_book_flag|loan_id, contract_id, application_id, limit_decision_id, disbursement_date, principal, outstanding, interest_rate, tenor_months, loan_status, $(b opening_book_flag)|"
"core_loan_schedule|schedule_id,loan_id,installment_no,due_date,principal_due,interest_due,principal_paid,interest_paid,schedule_status|schedule_id, loan_id, installment_no, due_date, principal_due, interest_due, principal_paid, interest_paid, schedule_status|"
"core_loan_disbursement|disbursement_id,loan_id,amount,disbursement_date,payment_order_id|disbursement_id, loan_id, amount, disbursement_date, payment_order_id|"
"core_loan_payment_allocation|allocation_id,loan_id,payment_order_id,allocation_date,principal_amount,interest_amount,fee_amount,penalty_amount|allocation_id, loan_id, payment_order_id, allocation_date, principal_amount, interest_amount, fee_amount, penalty_amount|"
"core_payment_order|payment_order_id,source_system,source_reference,idempotency_key,transaction_type,channel_code,transaction_date,value_date,amount,currency,payment_status|payment_order_id, source_system, source_reference, idempotency_key, transaction_type, channel_code, transaction_date, value_date, amount, currency, payment_status|transaction_date >= '$TU' AND transaction_date < '$DEN'"
"core_account_posting|posting_id,payment_order_id,account_id,debit_credit,amount,transaction_date,value_date,posting_date,business_date,running_balance|posting_id, payment_order_id, account_id, debit_credit, amount, transaction_date, value_date, posting_date, business_date, running_balance|transaction_date >= '$TU' AND transaction_date < '$DEN'"
"core_interest_accrual|interest_accrual_id,contract_id,accrual_date,accrued_amount,journal_id|interest_accrual_id, contract_id, accrual_date, accrued_amount, journal_id|accrual_date >= '$TU' AND accrual_date < '$DEN'"
)

CHI_NAP=0; [[ "${1:-}" == "--chi-nap" ]] && CHI_NAP=1

# ------------------------------------------------------------ 1. xuất từ PG (chỉ đọc)
if [[ $CHI_NAP == 0 ]]; then
  : > "$DATA/so-dong-pg.txt"
  for row in "${BANG[@]}"; do
    IFS='|' read -r t cols sel where <<< "$row"
    w=""; [[ -n "$where" ]] && w="WHERE $where"
    echo ">> xuất $t ${where:+($where)}"
    pg -c "COPY (SELECT $sel FROM aivb.$t $w) TO STDOUT WITH (FORMAT csv, HEADER true, NULL '\N')" > "$DATA/$t.csv"
    n=$(pg -At -c "SELECT count(*) FROM aivb.$t $w" | tr -d '\r')
    echo "$t $n" >> "$DATA/so-dong-pg.txt"
  done
fi

# ------------------------------------------------------------ 2. tạo database + bảng
echo ">> tạo database $DB"
my -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
my "$DB" < "$HERE/01_tao_bang_aivb.sql"

# ------------------------------------------------------------ 3. nạp
for row in "${BANG[@]}"; do
  IFS='|' read -r t cols sel where <<< "$row"
  echo ">> nạp $t"
  my "$DB" -e "SET FOREIGN_KEY_CHECKS=0; SET UNIQUE_CHECKS=0;
    LOAD DATA LOCAL INFILE '/sqllb/aivb/du-lieu/$t.csv' INTO TABLE $t CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\\\'
    LINES TERMINATED BY '\\n' IGNORE 1 LINES ($cols);
    SHOW WARNINGS LIMIT 5;"
done
my "$DB" -e "ANALYZE TABLE $(printf '%s\n' "${BANG[@]}" | cut -d'|' -f1 | paste -sd, -);" > /dev/null

# ------------------------------------------------------------ 4. so số dòng PG = MySQL
echo ">> so số dòng PG (cùng điều kiện) với MySQL"
loi=0
while read -r t n; do
  m=$(my -N "$DB" -e "SELECT COUNT(*) FROM $t" < /dev/null | tr -d '\r')
  st=OK; [[ "$m" != "$n" ]] && { st=LECH; loi=1; }
  printf '%-30s PG=%10s  MySQL=%10s  %s\n' "$t" "$n" "$m" "$st"
done < "$DATA/so-dong-pg.txt"
[[ $loi == 0 ]] && echo "NAP AIVB: khop so dong" || { echo "NAP AIVB: CO BANG LECH"; exit 1; }
