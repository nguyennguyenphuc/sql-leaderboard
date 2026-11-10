#!/usr/bin/env bash
# zip-overleaf.sh: đóng mỗi gói goi-cau-hoi/<bộ>/goi-<k>/ thành dist/overleaf/<bộ>-goi-<k>.zip để tải lên Overleaf
# (New Project -> Upload Project). Zip phẳng, đúng 4 file: cau-hoi.tex, solution.sql, aio-sql-cauhoi.sty, HUONG_DAN.md.
# Các file làm việc khác trong thư mục gói (REVIEW-*.md, DA-SUA.md, BANG-PHAN-CONG.md...) không vào zip.
#
#   bash scripts/zip-overleaf.sh              # mọi bộ, mọi gói
#   bash scripts/zip-overleaf.sh hr mkt       # chỉ các bộ nêu tên
#
# Cần `zip` (Linux, macOS) hoặc bsdtar (tar.exe có sẵn trên Windows 10+; macOS tar). Chỉ đọc thư mục gói.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RA="$ROOT/dist/overleaf"
FILES=(cau-hoi.tex solution.sql aio-sql-cauhoi.sty HUONG_DAN.md)

winpath() { if command -v cygpath >/dev/null 2>&1; then cygpath -w "$1"; else echo "$1"; fi; }

# chọn công cụ nén zip
if command -v zip >/dev/null 2>&1; then
  CU=zip
elif [[ -x /c/Windows/System32/tar.exe ]]; then
  CU=wintar
elif tar --version 2>/dev/null | grep -q bsdtar; then
  CU=bsdtar
else
  echo "Không có zip hoặc bsdtar" >&2; exit 1
fi

nen() {  # nen <thư mục gói> <file zip>
  local goi="$1" out="$2"
  rm -f "$out"
  case "$CU" in
    zip)    ( cd "$goi" && zip -q -X "$out" "${FILES[@]}" ) ;;
    wintar) /c/Windows/System32/tar.exe -a -c -f "$(winpath "$out")" -C "$(winpath "$goi")" "${FILES[@]}" ;;
    bsdtar) tar --format zip -c -f "$out" -C "$goi" "${FILES[@]}" ;;
  esac
}

if [[ $# -gt 0 ]]; then BO=("$@"); else
  BO=(); for d in "$ROOT"/goi-cau-hoi/*/; do b=$(basename "$d"); [[ $b == _* ]] || BO+=("$b"); done
fi

mkdir -p "$RA"
n=0; loi=0
for bo in "${BO[@]}"; do
  for goi in "$ROOT/goi-cau-hoi/$bo"/goi-*/; do
    [[ -d "$goi" ]] || continue
    goi="${goi%/}"; k="$(basename "$goi")"
    thieu=()
    for f in "${FILES[@]}"; do [[ -f "$goi/$f" ]] || thieu+=("$f"); done
    if [[ ${#thieu[@]} -gt 0 ]]; then
      echo "BỎ QUA $bo/$k: thiếu ${thieu[*]}" >&2; loi=$((loi + 1)); continue
    fi
    out="$RA/$bo-$k.zip"
    nen "$goi" "$out"
    kb=$(( $(wc -c < "$out") / 1024 ))
    canh_bao=""; [[ $kb -le 2048 ]] || canh_bao="  (quá 2 MB, bộ kiểm sẽ báo lỗi)"
    printf '  %-28s %5d KB%s\n' "$bo-$k.zip" "$kb" "$canh_bao"
    n=$((n + 1))
  done
done
echo "Đã tạo $n file zip trong $RA; $loi gói bị bỏ qua."
[[ $loi == 0 ]]
