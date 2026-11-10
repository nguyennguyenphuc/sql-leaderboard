#!/usr/bin/env bash
# 02_nap_scm.sh: xuất bản rút gọn Supply Chain từ Postgres của lớp (CHỈ ĐỌC) rồi nạp vào MySQL `scm`.
#
#   bash mysql/02_nap_scm.sh            # xuất CSV + tạo bảng + nạp + so số dòng
#   bash mysql/02_nap_scm.sh --chi-nap  # bỏ bước xuất (dùng CSV có sẵn trong mysql/du-lieu/)
#
# Yêu cầu: container docker-postgres-1 (PG của lớp) đang chạy; container sqllb-mysql đã dựng
# (xem README.md), thư mục mysql/ được mount vào /sqllb (chỉ đọc).
# Postgres chỉ được đọc: mọi lệnh psql chạy với default_transaction_read_only=on.
# Mật khẩu root MySQL lấy từ biến môi trường trong container, không đi qua dòng lệnh của máy.
set -euo pipefail
export MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'

HERE="$(cd "$(dirname "$0")" && pwd)"
DATA="$HERE/du-lieu"
PG_CT=docker-postgres-1
MY_CT=sqllb-mysql
DB=scm
mkdir -p "$DATA"

# ------------------------------------------------------------ cửa sổ dữ liệu (ghi lại ở README.md)
SALES_TU='2017-07-01'; SALES_DEN='2017-08-01'      # sales: [2017-07-01, 2017-08-01) = tháng 7/2017
INV_TU='2017-01';      INV_DEN='2017-08'           # inventory_snapshots: ym 2017-01 .. 2017-08

pg() { docker exec -i -e "PGOPTIONS=-c default_transaction_read_only=on" "$PG_CT" psql -U postgres -d scm -X -v ON_ERROR_STOP=1 "$@"; }
my() { docker exec -i "$MY_CT" sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -uroot --local-infile=1 --default-character-set=utf8mb4 "$@"' mysql "$@"; }

b() { echo "CASE WHEN $1 THEN 1 WHEN NOT $1 THEN 0 END AS $1"; }   # boolean -> 0/1

# bảng | danh sách cột (thứ tự cột MySQL) | biểu thức SELECT trên PG | điều kiện WHERE
# Thứ tự = thứ tự nạp (bảng cha trước).
BANG=(
"city_geo|city,lat,\`long\`|city, lat, long|"
"delivery_points|point_id,city,lat,\`long\`,weight|point_id, city, lat, long, weight|"
"event_calendar|\`date\`,event_name,tier,demand_multiplier|date, event_name, tier, demand_multiplier|"
"holidays|\`date\`,type,locale,locale_name,description,transferred|date, type, locale, locale_name, description, $(b transferred)|"
"items|item_nbr,family,class,perishable|item_nbr, family, class, perishable|"
"oil|\`date\`,dcoilwtico|date, dcoilwtico|"
"sorting_hubs|hub_id,dc_parent,city,role,lat,\`long\`|hub_id, dc_parent, city, role, lat, long|"
"stores|store_nbr,city,state,type,cluster|store_nbr, city, state, type, cluster|"
"warehouses|warehouse_id,city,lat,\`long\`|warehouse_id, city, lat, long|"
"suppliers|supplier_id,supplier_name,family,city,lat,\`long\`,promised_lead_days,warehouse_id|supplier_id, supplier_name, family, city, lat, long, promised_lead_days, warehouse_id|"
"store_attributes|store_nbr,city,state,type,cluster,lat,\`long\`,area_m2,rent_month_usd|store_nbr, city, state, type, cluster, lat, long, area_m2, rent_month_usd|"
"item_costs|item_nbr,family,perishable,unit_price,unit_cost|item_nbr, family, perishable, unit_price, unit_cost|"
"staffing_plan|hub_id,\`date\`,headcount_ke_hoach,headcount_thuc_te|hub_id, date, headcount_ke_hoach, headcount_thuc_te|"
"warehouse_daily_ops|hub_id,\`date\`,orders_to_process,backlog_dau_ngay,backlog_cuoi_ngay,headcount,total_weight_kg,avg_sort_time_min,workload_ratio,headcount_ke_hoach|hub_id, date, orders_to_process, backlog_dau_ngay, backlog_cuoi_ngay, headcount, total_weight_kg, avg_sort_time_min, workload_ratio, headcount_ke_hoach|"
"transactions|\`date\`,store_nbr,transactions|date, store_nbr, transactions|"
"shipments|shipment_id,warehouse_id,store_nbr,week,km_to_dc,units_shipped,promised_days,actual_days,on_time,in_full,otif|shipment_id, warehouse_id, store_nbr, week, km_to_dc, units_shipped, promised_days, actual_days, on_time, in_full, otif|"
"purchase_orders|po_id,supplier_id,item_nbr,po_date,qty_ordered,promised_lead_days,promised_date,received_date,km_supplier_to_dc,qty_received,qty_defect,defect_rate,inspection_result|po_id, supplier_id, item_nbr, po_date, qty_ordered, promised_lead_days, promised_date, received_date, km_supplier_to_dc, qty_received, qty_defect, defect_rate, inspection_result|"
"orders|order_id,order_date,region,origin_hub_id,dest_hub_id,dest_city,dest_point_id,family,weight_kg,order_value_usd,created_at,picked_at,dispatched_at,hub_arrived_at,delivered_at,t1_tao_don_pick_h,t2_pick_xuat_h,t3a_di_chuyen_h,t3b_sorting_h,t4_kho_giao_h,lead_time_total_h,promised_h,on_time,checkout_group,voucher_manually_applied,voucher_applied,is_cancelled|order_id, order_date, region, origin_hub_id, dest_hub_id, dest_city, dest_point_id, family, weight_kg, order_value_usd, created_at, picked_at, dispatched_at, hub_arrived_at, delivered_at, t1_tao_don_pick_h, t2_pick_xuat_h, t3a_di_chuyen_h, t3b_sorting_h, t4_kho_giao_h, lead_time_total_h, promised_h, on_time, checkout_group, $(b voucher_manually_applied), $(b voucher_applied), $(b is_cancelled)|"
"inventory_snapshots|store_nbr,item_nbr,ym,on_hand_begin,received,sold,on_hand_end,inventory_value,thieu_hut|store_nbr, item_nbr, ym, on_hand_begin, received, sold, on_hand_end, inventory_value, thieu_hut|ym >= '$INV_TU' AND ym <= '$INV_DEN'"
"sales|\`date\`,store_nbr,item_nbr,unit_sales,onpromotion|\"date\", store_nbr, item_nbr, unit_sales, $(b onpromotion)|\"date\" >= '$SALES_TU' AND \"date\" < '$SALES_DEN'"
)

CHI_NAP=0; [[ "${1:-}" == "--chi-nap" ]] && CHI_NAP=1

# ------------------------------------------------------------ 1. xuất từ PG (chỉ đọc)
if [[ $CHI_NAP == 0 ]]; then
  : > "$DATA/so-dong-pg.txt"
  for row in "${BANG[@]}"; do
    IFS='|' read -r t cols sel where <<< "$row"
    w=""; [[ -n "$where" ]] && w="WHERE $where"
    echo ">> xuất $t ${where:+($where)}"
    pg -c "COPY (SELECT $sel FROM scm.$t $w) TO STDOUT WITH (FORMAT csv, HEADER true, NULL '\\N')" > "$DATA/$t.csv"
    n=$(pg -At -c "SELECT count(*) FROM scm.$t $w" | tr -d '\r')
    echo "$t $n" >> "$DATA/so-dong-pg.txt"
  done
fi

# ------------------------------------------------------------ 2. tạo database + bảng
echo ">> tạo database $DB"
my -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
my "$DB" < "$HERE/01_tao_bang_scm.sql"

# ------------------------------------------------------------ 3. nạp
for row in "${BANG[@]}"; do
  IFS='|' read -r t cols sel where <<< "$row"
  echo ">> nạp $t"
  my "$DB" -e "SET FOREIGN_KEY_CHECKS=0; SET UNIQUE_CHECKS=0;
    LOAD DATA LOCAL INFILE '/sqllb/du-lieu/$t.csv' INTO TABLE $t CHARACTER SET utf8mb4
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
  printf '%-22s PG=%10s  MySQL=%10s  %s\n' "$t" "$n" "$m" "$st"
done < "$DATA/so-dong-pg.txt"
[[ $loi == 0 ]] && echo "NAP SCM: khop so dong" || { echo "NAP SCM: CO BANG LECH"; exit 1; }
