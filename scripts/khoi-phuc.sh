#!/usr/bin/env bash
# khoi-phuc.sh: dựng MySQL của SQL Leaderboard trên máy mới (Linux, macOS, Git Bash trên Windows).
#
#   bash scripts/khoi-phuc.sh                         # tải dump từ GitHub Release v1.0.0 rồi nạp
#   bash scripts/khoi-phuc.sh --tag v1.1.0            # release khác
#   bash scripts/khoi-phuc.sh --repo chu/sql-leaderboard   # khi thư mục không phải bản clone có remote GitHub
#   bash scripts/khoi-phuc.sh --khong-tai             # dùng dump có sẵn trong dist/dumps/ (không gọi gh)
#   bash scripts/khoi-phuc.sh --tu-csv                # dựng từ script gốc + CSV trong mysql/**/du-lieu/
#
# Các bước: kiểm docker -> tạo mysql/.env (mật khẩu ngẫu nhiên) nếu chưa có -> docker compose up -d mysql
# -> chờ sẵn sàng -> tải + kiểm SHA256 -> tạo 10 database và nạp -> tạo user sql_runner (05_tai_khoan_cham_bai.sql)
# -> build image sqllb-tools -> in lệnh chạy bộ kiểm.
# Nạp lại một database đã có sẽ DROP rồi tạo lại database đó. Mật khẩu không in ra màn hình.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CT=sqllb-mysql
TAG=v1.1.0
REPO=""
TU_CSV=0
KHONG_TAI=0
DUMPS="$ROOT/dist/dumps"
DBS=(scm scm_hidden_1 aivb aivb_hidden_1 jelly jelly_hidden_1 hr hr_hidden_1 mkt mkt_hidden_1)

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tag) TAG="$2"; shift 2 ;;
    --repo) REPO="$2"; shift 2 ;;
    --tu-csv) TU_CSV=1; shift ;;
    --khong-tai) KHONG_TAI=1; shift ;;
    -h|--help) sed -n '2,14p' "$0"; exit 0 ;;
    *) echo "Tham số lạ: $1 (xem --help)" >&2; exit 2 ;;
  esac
done

loi() { echo "LỖI: $*" >&2; exit 1; }
buoc() { echo; echo "== $*"; }
dc() { docker compose -f "$ROOT/docker-compose.yml" "$@"; }
# chạy lệnh mysql root trong container; mật khẩu lấy từ biến môi trường của container
root_sql() { docker exec -i "$CT" sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -uroot --default-character-set=utf8mb4 "$@"' mysql "$@"; }

# ------------------------------------------------------------------ 1. docker
buoc "1. Kiểm Docker"
command -v docker >/dev/null || loi "chưa cài Docker (Docker Desktop hoặc Docker Engine + compose plugin)"
docker info >/dev/null 2>&1 || loi "Docker daemon chưa chạy"
docker compose version >/dev/null 2>&1 || loi "thiếu 'docker compose' (Compose v2)"
echo "$(docker --version); $(docker compose version)"

if docker inspect "$CT" >/dev/null 2>&1; then
  du_an=$(docker inspect -f '{{index .Config.Labels "com.docker.compose.project"}}' "$CT")
  [[ "$du_an" == sqllb ]] || loi "đã có container $CT không do compose project 'sqllb' tạo (dựng tay bằng docker run?). \
Dừng/xoá nó trước, hoặc dùng nguyên container đó và nạp tay theo README.md."
fi

# ------------------------------------------------------------------ 2. mysql/.env
buoc "2. mysql/.env"
ENV_FILE="$ROOT/mysql/.env"
sinh_mk() { local s; s=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 24 || true); [[ ${#s} -eq 24 ]] || loi "không sinh được mật khẩu"; echo "$s"; }
if [[ -f "$ENV_FILE" ]]; then
  grep -q '^MYSQL_ROOT_PASSWORD=.' "$ENV_FILE" && grep -q '^SQL_RUNNER_PASSWORD=.' "$ENV_FILE" \
    || loi "$ENV_FILE thiếu MYSQL_ROOT_PASSWORD hoặc SQL_RUNNER_PASSWORD (mẫu: mysql/.env.example)"
  echo "Dùng $ENV_FILE có sẵn"
else
  ( umask 077; printf 'MYSQL_ROOT_PASSWORD=%s\nSQL_RUNNER_PASSWORD=%s\n' "$(sinh_mk)" "$(sinh_mk)" > "$ENV_FILE" )
  echo "Đã tạo $ENV_FILE với mật khẩu ngẫu nhiên (không in ra; file này không đưa vào git)"
fi

# ------------------------------------------------------------------ 3. kiểm nguồn dữ liệu trước khi dựng
if [[ $TU_CSV == 1 ]]; then
  buoc "3. Kiểm CSV cho --tu-csv"
  thieu=0
  for d in du-lieu aivb/du-lieu hr/du-lieu jelly/du-lieu mkt/du-lieu; do
    n=$(ls "$ROOT/mysql/$d"/*.csv 2>/dev/null | wc -l)
    printf '  mysql/%-15s %3s file CSV\n' "$d" "$n"
    [[ $n -gt 0 ]] || thieu=1
  done
  [[ $thieu == 0 ]] || loi "thiếu CSV; chép mysql/**/du-lieu/ từ máy gốc, hoặc bỏ --tu-csv để nạp từ dump"
else
  buoc "3. Tải dump ($TAG) vào dist/dumps/"
  mkdir -p "$DUMPS"
  if [[ $KHONG_TAI == 0 ]]; then
    command -v gh >/dev/null || loi "chưa cài GitHub CLI (gh); hoặc tải tay 10 file *.sql.gz + SHA256SUMS vào dist/dumps/ rồi chạy với --khong-tai"
    ( cd "$ROOT" && gh release download "$TAG" ${REPO:+-R "$REPO"} -p '*.sql.gz' -p SHA256SUMS -D "$DUMPS" --clobber )
  fi
  [[ -f "$DUMPS/SHA256SUMS" ]] || loi "không có $DUMPS/SHA256SUMS"
  for db in "${DBS[@]}"; do [[ -f "$DUMPS/$db.sql.gz" ]] || loi "thiếu $DUMPS/$db.sql.gz"; done
  ( cd "$DUMPS" && sha256sum -c --quiet SHA256SUMS ) || loi "SHA256 không khớp, tải lại"
  echo "SHA256 khớp ($(wc -l < "$DUMPS/SHA256SUMS") file)"
fi

# ------------------------------------------------------------------ 4. khởi động MySQL
buoc "4. docker compose up -d mysql"
dc up -d mysql
echo -n "Chờ MySQL sẵn sàng"
for i in $(seq 1 120); do
  tt=$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{end}}' "$CT" 2>/dev/null || true)
  [[ "$tt" == healthy ]] && break
  [[ $i == 120 ]] && { echo; loi "quá 10 phút chưa sẵn sàng; xem 'docker logs $CT'. Nếu volume sqllb-mysql-data có từ trước với mật khẩu root khác thì sửa mysql/.env cho khớp hoặc xoá volume."; }
  echo -n "."; sleep 5
done
echo " ok"

# ------------------------------------------------------------------ 5. nạp dữ liệu
if [[ $TU_CSV == 1 ]]; then
  buoc "5. Dựng từ script gốc + CSV"
  bash "$ROOT/mysql/02_nap_scm.sh" --chi-nap
  root_sql < "$ROOT/mysql/03_bien_the_an_scm.sql" > /dev/null
  root_sql < "$ROOT/mysql/04_bo_sung_bien_the_scm.sql" > /dev/null   # luôn sau 03 (03 dựng lại database, xoá phần bổ sung)
  for bo in aivb hr jelly; do
    bash "$ROOT/mysql/$bo/02_nap_$bo.sh" --chi-nap
    root_sql < "$ROOT/mysql/$bo/03_bien_the_an_$bo.sql" > /dev/null
    root_sql < "$ROOT/mysql/$bo/04_bo_sung_bien_the_$bo.sql" > /dev/null
  done
  bash "$ROOT/mysql/mkt/02_nap_mkt.sh"            # luôn đọc CSV trong mysql/mkt/du-lieu/
  root_sql < "$ROOT/mysql/mkt/03_bien_the_an_mkt.sql" > /dev/null
  root_sql < "$ROOT/mysql/mkt/04_bo_sung_bien_the_mkt.sql" > /dev/null
else
  buoc "5. Nạp 10 database từ dump"
  for db in "${DBS[@]}"; do
    echo "  $db ($(du -h "$DUMPS/$db.sql.gz" | cut -f1) nén)"
    root_sql -e "DROP DATABASE IF EXISTS \`$db\`; CREATE DATABASE \`$db\` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
    # giải nén trong container: không phụ thuộc gzip/mã hoá của máy chủ
    docker exec -i "$CT" sh -c 'gunzip -c | MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot --default-character-set=utf8mb4 "$1"' sh "$db" \
      < "$DUMPS/$db.sql.gz"
  done
fi

# ------------------------------------------------------------------ 6. user chấm bài
buoc "6. User sql_runner (mysql/05_tai_khoan_cham_bai.sql)"
quyen=$(docker exec "$CT" sh -c 'sed "s/@@MATKHAU@@/$SQL_RUNNER_PASSWORD/" /sqllb/05_tai_khoan_cham_bai.sql | MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot -N')
echo "  sql_runner: $(grep -c '^GRANT' <<< "$quyen" || true) dòng GRANT"

echo "  Số bảng/view theo database:"
root_sql -N -e "SELECT CONCAT('    ', table_schema, ': ', COUNT(*)) FROM information_schema.tables
  WHERE table_schema REGEXP '^(scm|aivb|jelly|hr|mkt)(_hidden_1)?$' GROUP BY table_schema ORDER BY table_schema"

# ------------------------------------------------------------------ 7. image công cụ
buoc "7. Build image sqllb-tools"
dc --profile tools build tools

# ------------------------------------------------------------------ 8. hướng dẫn
buoc "Xong. MySQL: 127.0.0.1:3307 (trong mạng docker 'sqllb': sqllb-mysql:3306)"
cat <<'EOF'
Chạy bộ kiểm cho một gói (ví dụ gói 1 bộ HR), từ thư mục gốc repo:

  docker compose run --rm tools python cong-cu/kiem_tra_goi.py \
    --goi goi-cau-hoi/hr/goi-1 --ra cong-cu/ket-qua/hr-goi-1 --host sqllb-mysql --port 3306

Dòng cuối "KIEM TRA: 0 loi" là gói đạt; báo cáo chi tiết ở cong-cu/ket-qua/hr-goi-1/bao-cao-import.json.
Mật khẩu sql_runner được đọc từ mysql/.env. Xem thêm cong-cu/README.md.
EOF
