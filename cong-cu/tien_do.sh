#!/usr/bin/env bash
# Bao tien do soan de: tung bo du lieu, tung goi. Chi doc file, khong chay SQL.
# Dung: bash cong-cu/tien_do.sh
R="/c/Cong viec/ProjectDA/sql-leaderboard"
echo "== $(date '+%H:%M') tien do"
for bo in scm aivb jelly hr mkt; do
  readme="-"; [ -f "$R/mysql/README-$bo.md" ] || [ "$bo" = scm ] && readme="ok"
  [ "$bo" != scm ] && [ ! -f "$R/mysql/README-$bo.md" ] && readme="-"
  style="-"; [ -f "$R/style/STYLE-$bo.md" ] && style="ok"
  bando="-"; [ -f "$R/goi-cau-hoi/$bo/BAN-DO-100-CAU.md" ] && bando="ok"
  printf "%-6s mysql:%-3s style:%-3s ban-do:%-3s |" "$bo" "$readme" "$style" "$bando"
  for k in 1 2 3 4 5; do
    d="$R/goi-cau-hoi/$bo/goi-$k"
    s="."
    if [ -f "$d/cau-hoi.tex" ]; then
      n=$(grep -c '\\begin{cauhoi}' "$d/cau-hoi.tex" 2>/dev/null)
      s="soan:$n"
      kq=$(find "$R/cong-cu/ket-qua" "$d" -name bao-cao-import.json -path "*$bo*goi-$k*" -newer "$d/cau-hoi.tex" 2>/dev/null | head -1)
      [ -z "$kq" ] && kq=$(find "$R/cong-cu/ket-qua" "$d" -name bao-cao-import.json -path "*$bo*goi-$k*" 2>/dev/null | head -1) && [ -n "$kq" ] && s="$s,kiem-may(cu)"
      [ -n "$kq" ] && [[ "$s" != *kiem-may* ]] && s="$s,kiem-may"
      [ -f "$d/REVIEW-B.md" ] && s="$s,B"
      [ -f "$d/REVIEW-C.md" ] && s="$s,C"
      [ -f "$d/DA-SUA.md" ] && s="$s,sua"
      ls "$d"/*.pdf >/dev/null 2>&1 && s="$s,pdf"
    fi
    printf " g%s[%s]" "$k" "$s"
  done
  echo
done
