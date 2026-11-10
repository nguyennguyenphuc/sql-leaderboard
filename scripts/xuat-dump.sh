#!/usr/bin/env bash
# xuat-dump.sh: mysqldump từng database của SQL Leaderboard ra <thư mục ra>/<db>.sql.gz + SHA256SUMS
# (để đưa lên GitHub Release, khôi phục bằng scripts/khoi-phuc.sh / khoi-phuc.ps1).
#
#   bash scripts/xuat-dump.sh                       # cả 10 database -> dist/dumps/
#   bash scripts/xuat-dump.sh hr hr_hidden_1        # chỉ các database nêu tên
#   bash scripts/xuat-dump.sh --ra /tmp/thu hr      # thư mục ra khác
#   SQLLB_CT=ten-container bash scripts/xuat-dump.sh   # container khác sqllb-mysql
#
# Mật khẩu root đọc từ mysql/.env, chuyển vào container qua biến MYSQL_PWD (docker exec -e MYSQL_PWD),
# không nằm trên dòng lệnh, không in ra. Dump không kèm CREATE DATABASE: lúc khôi phục tự tạo database
# (utf8mb4_0900_ai_ci) rồi nạp, nên nạp được vào tên database khác khi cần.
# --single-transaction: không khoá bảng, đọc một ảnh nhất quán; vẫn nên chạy lúc máy chủ rảnh.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CT="${SQLLB_CT:-sqllb-mysql}"
RA="$ROOT/dist/dumps"
TAT_CA=(scm scm_hidden_1 aivb aivb_hidden_1 jelly jelly_hidden_1 hr hr_hidden_1 mkt mkt_hidden_1)

DBS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --ra) RA="$2"; shift 2 ;;
    -h|--help) sed -n '2,14p' "$0"; exit 0 ;;
    -*) echo "Tham số lạ: $1" >&2; exit 2 ;;
    *) DBS+=("$1"); shift ;;
  esac
done
[[ ${#DBS[@]} -gt 0 ]] || DBS=("${TAT_CA[@]}")

ENV_FILE="$ROOT/mysql/.env"
[[ -f "$ENV_FILE" ]] || { echo "Không có $ENV_FILE" >&2; exit 1; }
MYSQL_PWD="$(grep -E '^MYSQL_ROOT_PASSWORD=' "$ENV_FILE" | head -1 | cut -d= -f2- | tr -d '\r')"
[[ -n "$MYSQL_PWD" ]] || { echo "Thiếu MYSQL_ROOT_PASSWORD trong $ENV_FILE" >&2; exit 1; }
export MYSQL_PWD

docker inspect -f '{{.State.Running}}' "$CT" 2>/dev/null | grep -q true \
  || { echo "Container $CT không chạy" >&2; exit 1; }

mkdir -p "$RA"
for db in "${DBS[@]}"; do
  co=$(docker exec -e MYSQL_PWD "$CT" mysql -uroot -N -e \
       "SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name='$db'")
  [[ "$co" == 1 ]] || { echo "Không có database $db" >&2; exit 1; }

  echo ">> $db"
  tam="$RA/$db.sql.gz.tam"
  docker exec -e MYSQL_PWD "$CT" mysqldump -uroot \
      --single-transaction --quick --routines --triggers --events --no-tablespaces \
      --default-character-set=utf8mb4 --set-gtid-purged=OFF --hex-blob \
      "$db" | gzip -n -6 > "$tam"
  # pipefail bắt lỗi mysqldump; dump hoàn chỉnh luôn kết thúc bằng dòng "-- Dump completed"
  gzip -dc "$tam" | tail -1 | grep -q '^-- Dump completed' \
    || { echo "Dump $db không hoàn chỉnh" >&2; rm -f "$tam"; exit 1; }
  mv -f "$tam" "$RA/$db.sql.gz"
  echo "   $(du -h "$RA/$db.sql.gz" | cut -f1)  $RA/$db.sql.gz"
done

# SHA256SUMS cho mọi dump đang có trong thư mục (định dạng của sha256sum -c)
( cd "$RA" && sha256sum -b -- *.sql.gz | sed 's/ \*/  /' > SHA256SUMS )
echo ">> $RA/SHA256SUMS"
cat "$RA/SHA256SUMS"
