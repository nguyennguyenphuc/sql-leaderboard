#!/usr/bin/env bash
# bien_dich.sh: biên dịch thử một gói câu hỏi bằng XeLaTeX (image texlive/texlive), không ghi vào thư mục gói.
#
#   bash cong-cu/bien_dich.sh [--va] <thư mục gói> [thư mục ra]
#   ví dụ: bash cong-cu/bien_dich.sh quy_chuan/goi-cau-hoi-mau
#          bash cong-cu/bien_dich.sh --va goi-cau-hoi/_thu-bo-kiem
#
# Chép cau-hoi.tex, solution.sql, aio-sql-cauhoi.sty vào thư mục tạm trong container, chạy
# `xelatex -interaction=nonstopmode cau-hoi.tex` 2 lần (lần 2 cho mục lục), rồi chép cau-hoi.pdf + cau-hoi.log
# ra <thư mục ra> (mặc định cong-cu/ket-qua/bien-dich/<tên gói>[-va]/). In tóm tắt: lỗi LaTeX, ký tự thiếu
# trong font, cảnh báo của gói lệnh.
# --va: chèn cong-cu/va-xelatex.tex ngay sau \usepackage{aio-sql-cauhoi} trong BẢN SAO TẠM (xem README.md):
#       đổi font chữ đơn cách có đủ chữ Việt, và vẽ \erdkhoa thành node để không mất chữ. Không sửa .sty, không sửa gói.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

VA=0
if [[ "${1:-}" == "--va" ]]; then VA=1; shift; fi
[[ $# -ge 1 ]] || { sed -n '2,15p' "$0"; exit 2; }
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GOI="$(cd "$1" && pwd)"
TEN="$(basename "$GOI")$([[ $VA == 1 ]] && echo -va || true)"
RA="${2:-$ROOT/cong-cu/ket-qua/bien-dich/$TEN}"
mkdir -p "$RA"
IMAGE="${TEXLIVE_IMAGE:-texlive/texlive:latest}"

winpath() { if command -v cygpath >/dev/null 2>&1; then cygpath -w "$1"; else echo "$1"; fi; }

docker run --rm -e VA="$VA" \
  -v "$(winpath "$GOI"):/goi:ro" \
  -v "$(winpath "$ROOT/cong-cu/va-xelatex.tex"):/va.tex:ro" \
  -v "$(winpath "$RA"):/ra" \
  "$IMAGE" sh -c '
    set -e
    mkdir -p /tmp/b && cd /tmp/b
    for f in cau-hoi.tex solution.sql aio-sql-cauhoi.sty; do cp "/goi/$f" .; done
    if [ "$VA" = 1 ]; then
      sed -i "/^.usepackage{aio-sql-cauhoi}/r /va.tex" cau-hoi.tex
      echo "Da chen va-xelatex.tex vao ban sao tam ($(grep -c . /va.tex) dong)"
    fi
    for i in 1 2; do
      xelatex -interaction=nonstopmode cau-hoi.tex > xelatex-lan$i.txt 2>&1 || echo "xelatex lan $i: ma thoat $?"
    done
    cp cau-hoi.log /ra/ 2>/dev/null || true
    cp cau-hoi.pdf /ra/ 2>/dev/null || true
    echo "== ket qua"
    if [ -f cau-hoi.pdf ]; then
      echo "PDF: $(grep -o "Output written on .*" cau-hoi.log | head -1)"
    else
      echo "PDF: KHONG TAO DUOC"
    fi
    echo "Loi LaTeX (dong bat dau bang !): $(grep -c "^!" cau-hoi.log || true)"
    grep -A3 "^!" cau-hoi.log | head -24 || true
    echo "Ky tu thieu trong font: $(grep -c "Missing character" cau-hoi.log || true)"
    grep "Missing character" cau-hoi.log | sed "s/ in font .*nullfont.*/ (nullfont: chu nam ngoai node trong tikzpicture)/" | sort | uniq -c | sort -rn | head -8 || true
    echo "Canh bao aio-sql-cauhoi: $(grep -c "Package aio-sql-cauhoi Warning" cau-hoi.log || true)"
    grep -A1 "Package aio-sql-cauhoi Warning" cau-hoi.log | head -20 || true
    echo "Overfull hbox (dong SQL/ERD qua dai, chi la canh bao trinh bay): $(grep -c "Overfull" cau-hoi.log || true)"
  '
echo "Da chep PDF + log vao: $RA"
