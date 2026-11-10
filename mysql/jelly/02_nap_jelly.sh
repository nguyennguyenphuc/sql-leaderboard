#!/usr/bin/env bash
# 02_nap_jelly.sh: xuất bộ GAME Jelly Trail Academy từ Postgres của lớp (CHỈ ĐỌC) rồi nạp vào MySQL `jelly`.
#
#   bash mysql/jelly/02_nap_jelly.sh            # xuất CSV + tạo bảng + nạp + so số dòng
#   bash mysql/jelly/02_nap_jelly.sh --chi-nap  # bỏ bước xuất (dùng CSV có sẵn trong mysql/jelly/du-lieu/)
#
# Nguồn: DB candy_game, CHỈ schema jelly_analytics. KHÔNG đọc schema public (mật khẩu băm, token, IP).
# Không lấy view live_player_wallets (đọc public) và bảng dataset_metadata.
# Bỏ các dòng "live" do tài khoản thật chơi qua web (user_id 'aivb_...', daily_kpi sau 2026-08-29):
# chỉ giữ bộ tổng hợp 60 ngày 2026-07-01 .. 2026-08-29 (khớp manifest dataset_version 3.0).
# Postgres chỉ được đọc: mọi lệnh psql chạy với default_transaction_read_only=on.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

HERE="$(cd "$(dirname "$0")" && pwd)"
DATA="$HERE/du-lieu"
PG_CT=docker-postgres-1
MY_CT=sqllb-mysql
DB=jelly
mkdir -p "$DATA"

pg() { docker exec -i -e "PGOPTIONS=-c default_transaction_read_only=on" "$PG_CT" psql -U postgres -d candy_game -X -v ON_ERROR_STOP=1 "$@"; }
my() { docker exec -i "$MY_CT" sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -uroot --local-infile=1 --default-character-set=utf8mb4 "$@"' mysql "$@"; }

ts() { echo "replace($1,'T',' ') AS $1"; }   # 'YYYY-MM-DDTHH:MM:SS' -> 'YYYY-MM-DD HH:MM:SS'
JTA="user_id LIKE 'jta\\_user\\_%'"           # bỏ người chơi live 'aivb_...'

# bảng | cột MySQL | biểu thức SELECT trên PG | điều kiện WHERE   (bảng cha trước)
BANG=(
"users|user_id,install_date,platform,country,channel,campaign_id,app_version_install,device_tier|user_id, install_date, platform, country, channel, campaign_id, app_version_install, device_tier|$JTA"
"level_metadata|level_id,episode,world_name,screen_context,objective_type,difficulty_tag,moves_limit,designed_fail_probability,teaching_note|level_id, episode, world_name, screen_context, objective_type, difficulty_tag, moves_limit, designed_fail_probability, teaching_note|"
"liveops_events|event_id,event_name,start_date,end_date,screen_context,mechanic|event_id, event_name, start_date, end_date, screen_context, mechanic|"
"campaign_spend|\`date\`,campaign_id,channel,country,spend_usd,target_platform|date, campaign_id, channel, country, spend_usd, target_platform|"
"daily_kpi|\`date\`,dau,new_users,sessions,playtime_minutes,iap_revenue,ad_revenue,crash_count,arpdau|date, dau, new_users, sessions, playtime_minutes, iap_revenue, ad_revenue, crash_count, arpdau|date <= '2026-08-29'"
"sessions|session_id,user_id,session_start,event_date,event_time,duration_minutes,entry_screen,app_version,platform,country|session_id, user_id, $(ts session_start), event_date, $(ts event_time), duration_minutes, entry_screen, app_version, platform, country|$JTA"
"player_daily|user_id,install_date,activity_date,cohort_day,platform,country,channel,campaign_id,app_version,sessions,playtime_minutes,max_level,boosters_used,extra_moves_purchased,crash_count,iap_revenue,ad_revenue|user_id, install_date, activity_date, cohort_day, platform, country, channel, campaign_id, app_version, sessions, playtime_minutes, max_level, boosters_used, extra_moves_purchased, crash_count, iap_revenue, ad_revenue|$JTA"
"tutorial_steps|user_id,install_date,event_time,event_date,session_id,step_id,step_name,screen_context,step_completed,platform,country,channel,app_version|user_id, install_date, $(ts event_time), event_date, session_id, step_id, step_name, screen_context, step_completed, platform, country, channel, app_version|$JTA"
"ab_assignments|user_id,experiment_id,variant,assigned_at,platform,country,eligible_at,exposed_at,exposure_status,eligibility_rule,primary_metric,guardrail_metric,analysis_window_days|user_id, experiment_id, variant, $(ts assigned_at), platform, country, $(ts eligible_at), $(ts exposed_at), exposure_status, eligibility_rule, primary_metric, guardrail_metric, analysis_window_days|$JTA"
"level_attempts|attempt_id,user_id,event_date,event_time,session_id,level_id,episode,world_name,screen_context,objective_type,difficulty_tag,moves_limit,moves_used,moves_left,result,booster_used,extra_moves_offered,extra_moves_purchased,duration_sec,app_version,platform,country|attempt_id, user_id, event_date, $(ts event_time), session_id, level_id, episode, world_name, screen_context, objective_type, difficulty_tag, moves_limit, moves_used, moves_left, result, booster_used, extra_moves_offered, extra_moves_purchased, duration_sec, app_version, platform, country|$JTA"
"booster_events|booster_event_id,attempt_id,user_id,event_date,event_time,session_id,level_id,booster_type,action,screen_context,app_version,platform,country|booster_event_id, attempt_id, user_id, event_date, $(ts event_time), session_id, level_id, booster_type, action, screen_context, app_version, platform, country|$JTA"
"purchases|transaction_id,user_id,event_date,event_time,session_id,product_type,product_name,price_usd,level_id_if_relevant,screen_context,currency,is_refund,app_version,platform,country|transaction_id, user_id, event_date, $(ts event_time), session_id, product_type, product_name, price_usd, (level_id_if_relevant::numeric)::int AS level_id_if_relevant, screen_context, currency, is_refund, app_version, platform, country|$JTA"
"ad_events|ad_id,user_id,event_date,event_time,session_id,ad_type,placement,reward_type,revenue_usd,screen_context,app_version,platform,country|ad_id, user_id, event_date, $(ts event_time), session_id, ad_type, placement, reward_type, revenue_usd, screen_context, app_version, platform, country|$JTA"
)

CHI_NAP=0; [[ "${1:-}" == "--chi-nap" ]] && CHI_NAP=1

# ------------------------------------------------------------ 1. xuất từ PG (chỉ đọc, chỉ jelly_analytics)
if [[ $CHI_NAP == 0 ]]; then
  : > "$DATA/so-dong-pg.txt"
  for row in "${BANG[@]}"; do
    IFS='|' read -r t cols sel where <<< "$row"
    w=""; [[ -n "$where" ]] && w="WHERE $where"
    echo ">> xuất $t ${where:+($where)}"
    pg -c "COPY (SELECT $sel FROM jelly_analytics.$t $w) TO STDOUT WITH (FORMAT csv, HEADER true, NULL '\\N')" > "$DATA/$t.csv"
    n=$(pg -At -c "SELECT count(*) FROM jelly_analytics.$t $w" | tr -d '\r')
    echo "$t $n" >> "$DATA/so-dong-pg.txt"
  done
fi

# ------------------------------------------------------------ 2. tạo database + bảng
echo ">> tạo database $DB"
my -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
my "$DB" < "$HERE/01_tao_bang_jelly.sql"

# ------------------------------------------------------------ 3. nạp
for row in "${BANG[@]}"; do
  IFS='|' read -r t cols sel where <<< "$row"
  echo ">> nạp $t"
  my "$DB" -e "SET FOREIGN_KEY_CHECKS=0; SET UNIQUE_CHECKS=0;
    LOAD DATA LOCAL INFILE '/sqllb/jelly/du-lieu/$t.csv' INTO TABLE $t CHARACTER SET utf8mb4
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
  printf '%-16s PG=%9s  MySQL=%9s  %s\n' "$t" "$n" "$m" "$st"
done < "$DATA/so-dong-pg.txt"
[[ $loi == 0 ]] && echo "NAP JELLY: khop so dong" || { echo "NAP JELLY: CO BANG LECH"; exit 1; }
