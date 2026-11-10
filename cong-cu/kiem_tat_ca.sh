#!/usr/bin/env bash
# Chay bo kiem day du (public + hidden-1) cho moi goi, N goi song song.
# Dung: bash cong-cu/kiem_tat_ca.sh [N=3] [bo...]
# Ket qua: cong-cu/ket-qua/kiem-cuoi/<bo>-goi-<k>/ (bao-cao-import.json + log.txt) va TONG-HOP.txt
set -u
R="/c/Cong viec/ProjectDA/sql-leaderboard"
N="${1:-3}"; shift || true
BOS=("$@"); [ ${#BOS[@]} -eq 0 ] && BOS=(scm aivb jelly hr mkt)
OUT="$R/cong-cu/ket-qua/kiem-cuoi"; mkdir -p "$OUT"
chay() {
  local bo="$1" k="$2"; local ra="cong-cu/ket-qua/kiem-cuoi/$bo-goi-$k"
  mkdir -p "$R/$ra"
  local t0=$(date +%s)
  MSYS_NO_PATHCONV=1 docker run --rm --network sqllb -v "C:\\Cong viec\\ProjectDA\\sql-leaderboard:/w" -w /w sqllb-tools \
    python cong-cu/kiem_tra_goi.py --goi "goi-cau-hoi/$bo/goi-$k" --ra "$ra" --host sqllb-mysql --port 3306 \
    > "$R/$ra/log.txt" 2>&1
  local rc=$? t1=$(date +%s)
  echo "$bo-goi-$k rc=$rc $((t1-t0))s | $(grep -a 'KIEM TRA' "$R/$ra/log.txt" | tail -1)" | tee -a "$OUT/TONG-HOP.txt"
}
export -f chay; export R OUT
: > "$OUT/TONG-HOP.txt"
for bo in "${BOS[@]}"; do for k in 1 2 3 4 5; do echo "$bo $k"; done; done \
  | xargs -P "$N" -L 1 bash -c 'chay "$0" "$1"'
echo "== xong $(date '+%H:%M')"; sort "$OUT/TONG-HOP.txt"
