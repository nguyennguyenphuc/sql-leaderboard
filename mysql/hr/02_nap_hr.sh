#!/usr/bin/env bash
# 02_nap_hr.sh: nạp bộ HR Analytics (5 CSV của dự án Project 02 HR Analytics) vào MySQL `hr`.
#
#   bash mysql/hr/02_nap_hr.sh            # chép CSV từ thư mục Project DA (biến SQLLB_PROJECT_DA; chỉ đọc đúng 5 file) + tạo bảng + nạp + so số dòng
#   bash mysql/hr/02_nap_hr.sh --chi-nap  # dùng CSV có sẵn trong mysql/hr/du-lieu/
#
# Dữ liệu nhỏ (~101 nghìn dòng) nên nạp ĐỦ, không rút gọn. CSV không có dấu ngoặc kép, ô trống = thiếu dữ liệu -> NULL.
# Một số cột số nguyên được pandas ghi dạng '74.0' (vì có NaN): nạp qua biến, ép DECIMAL rồi gán (đã kiểm: phần lẻ luôn .0).
# Yêu cầu: container sqllb-mysql (mysql/README.md), thư mục mysql/ mount ở /sqllb (chỉ đọc).
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

HERE="$(cd "$(dirname "$0")" && pwd)"
DATA="$HERE/du-lieu"
NGUON="${SQLLB_PROJECT_DA:-}/Project 02 HR Analytics/data/generated"   # SQLLB_PROJECT_DA = thư mục Project DA
MY_CT=sqllb-mysql
DB=hr
FILES=(country_market_benchmark employee_monthly_snapshot engagement_survey position_plan recruiting_pipeline)
mkdir -p "$DATA"

my() { docker exec -i "$MY_CT" sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -uroot --local-infile=1 --default-character-set=utf8mb4 "$@"' mysql "$@"; }

if [[ "${1:-}" != "--chi-nap" ]]; then
  [[ -n "${SQLLB_PROJECT_DA:-}" && -d "$NGUON" ]] || {
    echo "LỖI: đặt SQLLB_PROJECT_DA = thư mục Project DA (chứa 'Project 02 HR Analytics'), hoặc chạy --chi-nap" >&2; exit 1; }
  for f in "${FILES[@]}"; do cp "$NGUON/$f.csv" "$DATA/$f.csv"; done
fi
# số dòng dữ liệu trong CSV (trừ dòng tiêu đề) = số dòng nguồn
: > "$DATA/so-dong-csv.txt"
for f in "${FILES[@]}"; do echo "$f $(( $(wc -l < "$DATA/$f.csv") - 1 ))" >> "$DATA/so-dong-csv.txt"; done

echo ">> tạo database $DB"
my -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
my "$DB" < "$HERE/01_tao_bang_hr.sql"

L="FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n' IGNORE 1 LINES"
P=/sqllb/hr/du-lieu

echo ">> nạp"
my "$DB" <<SQL
SET FOREIGN_KEY_CHECKS = 0;

LOAD DATA LOCAL INFILE '$P/country_market_benchmark.csv' INTO TABLE country_market_benchmark CHARACTER SET utf8mb4 $L
  (benchmark_year, country, job_role, job_level, market_salary_p50_usd, market_salary_p75_usd, unemployment_proxy, hiring_difficulty);
SHOW WARNINGS LIMIT 5;

LOAD DATA LOCAL INFILE '$P/position_plan.csv' INTO TABLE position_plan CHARACTER SET utf8mb4 $L
  (plan_period, position_id, country, department, job_role, job_level, actual_headcount, planned_headcount,
   vacancy_count, critical_role_flag, backfill_allowed, business_priority);
SHOW WARNINGS LIMIT 5;

LOAD DATA LOCAL INFILE '$P/employee_monthly_snapshot.csv' INTO TABLE employee_monthly_snapshot CHARACTER SET utf8mb4 $L
  (employee_id, snapshot_month, country, city, department, job_role, job_family, job_level, age, age_band, gender,
   employment_type, work_model, monthly_salary_usd, compa_ratio, @perf, @pot, high_performer_flag, @eng, @mgr,
   overtime_hours, @abs, @train, business_travel_days, tenure_months, months_since_promotion, internal_move_last_12m,
   attrition_this_month, @atype, @areason, @mgr_id, position_id, attrition_next_3m, attrition_next_5m, attrition_next_6m)
  SET performance_rating          = CAST(NULLIF(@perf, '')  AS DECIMAL(6,1)),
      potential_rating            = NULLIF(@pot, ''),
      engagement_score            = CAST(NULLIF(@eng, '')   AS DECIMAL(6,1)),
      manager_effectiveness_score = CAST(NULLIF(@mgr, '')   AS DECIMAL(6,1)),
      absence_days                = CAST(NULLIF(@abs, '')   AS DECIMAL(6,1)),
      training_hours_6m           = CAST(NULLIF(@train, '') AS DECIMAL(6,1)),
      attrition_type              = NULLIF(@atype, ''),
      attrition_reason            = NULLIF(@areason, ''),
      manager_id                  = NULLIF(@mgr_id, '');
SHOW WARNINGS LIMIT 5;

LOAD DATA LOCAL INFILE '$P/engagement_survey.csv' INTO TABLE engagement_survey CHARACTER SET utf8mb4 $L
  (employee_id, survey_quarter, engagement_score, manager_trust_score, workload_score, career_growth_score, eNPS, intent_to_stay);
SHOW WARNINGS LIMIT 5;

LOAD DATA LOCAL INFILE '$P/recruiting_pipeline.csv' INTO TABLE recruiting_pipeline CHARACTER SET utf8mb4 $L
  (requisition_id, position_id, @vac, country, department, job_role, attrition_month, requisition_type,
   recruitment_source, approval_date, time_to_fill_days, offer_accept_date, start_date, recruiting_cost_usd)
  SET vacated_employee_id = NULLIF(@vac, '');
SHOW WARNINGS LIMIT 5;

-- chiều vị trí suy ra: mọi position_id của snapshot, position_plan, recruiting_pipeline.
-- Thuộc tính lấy từ snapshot (bản ghi gốc), rồi position_plan, rồi recruiting (job_level không có ở recruiting).
INSERT INTO positions (position_id, country, department, job_family, job_level)
SELECT position_id, MIN(country), MIN(department), MIN(job_family), MIN(job_level)
FROM (SELECT position_id, country, department, job_family, job_level FROM employee_monthly_snapshot
      UNION ALL
      SELECT position_id, country, department, job_role, job_level FROM position_plan) x
GROUP BY position_id;
SELECT COUNT(*) AS recruiting_position_khong_co_trong_positions
FROM recruiting_pipeline r LEFT JOIN positions p ON p.position_id = r.position_id WHERE p.position_id IS NULL;

SET FOREIGN_KEY_CHECKS = 1;
ANALYZE TABLE positions, country_market_benchmark, position_plan, employee_monthly_snapshot, engagement_survey, recruiting_pipeline;
SQL

echo ">> so số dòng CSV với MySQL"
loi=0
while read -r t n; do
  m=$(my -N "$DB" -e "SELECT COUNT(*) FROM $t" < /dev/null | tr -d '\r')
  st=OK; [[ "$m" != "$n" ]] && { st=LECH; loi=1; }
  printf '%-28s CSV=%8s  MySQL=%8s  %s\n' "$t" "$n" "$m" "$st"
done < "$DATA/so-dong-csv.txt"
echo "positions (suy ra)           MySQL=$(my -N "$DB" -e 'SELECT COUNT(*) FROM positions' < /dev/null | tr -d '\r')"
[[ $loi == 0 ]] && echo "NAP HR: khop so dong" || { echo "NAP HR: CO BANG LECH"; exit 1; }
