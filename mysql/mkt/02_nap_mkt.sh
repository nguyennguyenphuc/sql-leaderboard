#!/usr/bin/env bash
# 02_nap_mkt.sh: tạo database `mkt` trên sqllb-mysql, tạo bảng (01_tao_bang_mkt.sql), nạp + chuẩn hoá
# (02_nap_mkt.sql) từ CSV trong mysql/mkt/du-lieu/, rồi so số dòng CSV với MySQL.
#
#   bash mysql/mkt/02_nap_mkt.sh
#
# CSV chép nguyên từ thư mục dataset của Project 01 Marketing (ổ H:, chỉ đọc đúng file):
#   {nykaa,purplle,tira}_campaign_data.csv (có nhiễu), *_original.csv (sạch), noise_log.csv.
# Mật khẩu root lấy từ biến môi trường trong container, không đi qua dòng lệnh của máy.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

HERE="$(cd "$(dirname "$0")" && pwd)"
DATA="$HERE/du-lieu"
MY_CT=sqllb-mysql
DB=mkt

my() { docker exec -i "$MY_CT" sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -uroot --local-infile=1 --default-character-set=utf8mb4 "$@"' mysql "$@"; }

echo ">> tạo database $DB"
my -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
my "$DB" < "$HERE/01_tao_bang_mkt.sql"
echo ">> nạp + chuẩn hoá"
my "$DB" < "$HERE/02_nap_mkt.sql" > /dev/null

# ------------------------------------------------------------ so số dòng
n() { echo $(( $(wc -l < "$DATA/$1") - 1 )); }
SACH=$(( $(n nykaa_campaign_data_original.csv) + $(n purplle_campaign_data_original.csv) + $(n tira_campaign_data_original.csv) ))
NHIEU=$(( $(n nykaa_campaign_data.csv) + $(n purplle_campaign_data.csv) + $(n tira_campaign_data.csv) ))
LOG=$(n noise_log.csv)
echo ">> so số dòng (CSV | MySQL)"
my -N "$DB" -e "
SELECT 'campaigns (= *_original.csv)', $SACH, COUNT(*) FROM campaigns
UNION ALL SELECT 'campaigns_raw (= *.csv có nhiễu)', $NHIEU, COUNT(*) FROM campaigns_raw
UNION ALL SELECT 'noise_log', $LOG, COUNT(*) FROM noise_log
UNION ALL SELECT 'campaign_channels (= tổng số kênh)', NULL, COUNT(*) FROM campaign_channels
UNION ALL SELECT 'calendar', NULL, COUNT(*) FROM calendar
UNION ALL SELECT 'brands', NULL, COUNT(*) FROM brands
UNION ALL SELECT 'campaign_types', NULL, COUNT(*) FROM campaign_types
UNION ALL SELECT 'audiences', NULL, COUNT(*) FROM audiences
UNION ALL SELECT 'languages', NULL, COUNT(*) FROM languages
UNION ALL SELECT 'channels', NULL, COUNT(*) FROM channels;" | tee "$DATA/so-dong.txt"
