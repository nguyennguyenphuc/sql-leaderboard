# MySQL 8.0 cho SQL Leaderboard · bộ dữ liệu Supply Chain (`scm`)

Dựng ngày 10/11/2026. Máy chủ chấm là container `sqllb-mysql` (MySQL 8.0.46), mạng Docker riêng `sqllb`.
Dữ liệu lấy từ Postgres của lớp (`docker-postgres-1`, DB `scm`, schema `scm`) ở chế độ **chỉ đọc**.

| Thành phần | Giá trị |
|---|---|
| Container | `sqllb-mysql`, image `mysql:8.0`, `--restart unless-stopped` |
| Mạng | `sqllb` (container khác trong mạng gọi `sqllb-mysql:3306`) |
| Cổng máy | `127.0.0.1:3307` |
| Volume dữ liệu | `sqllb-mysql-data` |
| Mount | `mysql/` → `/sqllb` (chỉ đọc; `du-lieu/` cho `LOAD DATA LOCAL INFILE`) |
| Tham số | `--character-set-server=utf8mb4 --collation-server=utf8mb4_0900_ai_ci --local-infile=1 --secure-file-priv="" --innodb-buffer-pool-size=1G` |
| Mật khẩu | `mysql/.env`: `MYSQL_ROOT_PASSWORD`, `SQL_RUNNER_PASSWORD` (sinh ngẫu nhiên, không in ra; container nhận qua `--env-file`) |
| Database | `scm` (public), `scm_hidden_1` (biến thể ẩn) |
| User chấm | `sql_runner`@`%`: chỉ `SELECT` trên `scm`, `scm\_hidden\_%` (và `datathon_2026*` khi có) |

## Dựng lại từ đầu

```bash
# 1. container (một lần), từ thư mục gốc repo. Mật khẩu: mysql/.env (2 dòng KEY=giá trị; khoi-phuc.sh tự tạo)
#    Cách nhanh hơn từ dump: bash scripts/khoi-phuc.sh (README.md gốc). Bộ nhớ đệm mặc định 1G, đặt lớn hơn nếu đủ RAM.
SQLLB_BUFFER_POOL=6G docker compose up -d mysql

# 2. xuất từ PG (chỉ đọc) + tạo bảng (01_tao_bang_scm.sql) + nạp + so số dòng   (~3 phút)
bash mysql/02_nap_scm.sh            # --chi-nap: dùng lại CSV đã có trong mysql/du-lieu/

# 3. biến thể ẩn scm_hidden_1   (~1,5 phút), rồi luôn chạy tiếp 04 (03 dựng lại database từ đầu, xoá phần bổ sung)
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/03_bien_the_an_scm.sql
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/04_bo_sung_bien_the_scm.sql

# 4. user chỉ SELECT (mật khẩu thay ngay trong container, không qua dòng lệnh máy)
docker exec sqllb-mysql sh -c 'sed "s/@@MATKHAU@@/$SQL_RUNNER_PASSWORD/" /sqllb/05_tai_khoan_cham_bai.sql | MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot'
```

Mở client: `docker exec -it sqllb-mysql sh -c 'MYSQL_PWD="$SQL_RUNNER_PASSWORD" mysql -usql_runner -h127.0.0.1 scm'`.

`du-lieu/` (CSV ~455 MB) và `.env` **không** đưa vào gói câu hỏi, không chia sẻ.

## Bản rút gọn: cửa sổ dữ liệu và số dòng

Nguyên tắc: giữ đủ mọi bảng nhỏ; bảng lớn lấy một cửa sổ liền mạch. Tổng **5.841.123 dòng** (Datathon ~2,2 triệu).
Số dòng PG (cùng điều kiện) = MySQL cho cả 20 bảng (`02_nap_scm.sh` in bảng so sánh, file `du-lieu/so-dong-pg.txt`).

| Bảng | Lấy | Số dòng `scm` | `scm_hidden_1` |
|---|---|---:|---:|
| `sales` | **`date` 2017-07-01 → 2017-07-31** (tháng 7/2017, cả 54 cửa hàng, 3.847 mặt hàng) | 3.283.161 | 2.925.202 |
| `inventory_snapshots` | **`ym` 2017-01 → 2017-08** (8 tháng) | 1.251.497 | 1.116.091 |
| `orders` | đủ: `order_date` 2015-08-17 → 2017-08-13 | 1.033.327 | 929.995 |
| `purchase_orders` | đủ: `po_date` 2013-01-03 → 2017-08-15 | 158.798 | 142.920 |
| `transactions` | đủ (2013 → 2017-08-15) | 83.488 | 75.140 |
| `shipments` | đủ (tuần 2012-12-31 → 2017-08-20) | 12.060 | 12.059 (1.206 dòng sửa) |
| `staffing_plan` | đủ | 4.368 | = (393 dòng sửa) |
| `warehouse_daily_ops` | đủ | 4.368 | = (437 dòng sửa) |
| `items` | đủ | 4.100 | 4.101 |
| `item_costs` | đủ | 4.100 | 4.101 |
| `oil` | đủ | 1.218 | 1.095 |
| `holidays` | đủ | 350 | 351 |
| `suppliers` | đủ | 66 | = |
| `stores` | đủ | 54 | 55 |
| `store_attributes` | đủ | 54 | = |
| `delivery_points` | đủ | 49 | = |
| `event_calendar` | đủ | 34 | 35 |
| `city_geo` | đủ | 22 | = |
| `sorting_hubs` | đủ | 6 | = |
| `warehouses` | đủ | 3 | = |

Không nạp `item_costs_monthly` (học viên không thấy bảng này).

Vì sao chọn cửa sổ này: `sales` ~105 nghìn dòng/ngày, nên một tháng (3,28 triệu) là cửa sổ tròn lớn nhất để tổng ≲ 6 triệu;
`inventory_snapshots` 2016-01 → 2017-08 là 3,04 triệu dòng (quá ngân sách), 2017-01 → 2017-08 phủ cả tháng của `sales` và
cho câu hỏi theo tháng/so tháng. Người soạn câu cần nhớ:
- **`sales` chỉ có tháng 7/2017**: câu về bán hàng theo ngày/tuần/cửa hàng/mặt hàng chỉ hỏi trong tháng này; câu xu hướng dài hạn dùng `orders` (2015-08 → 2017-08), `transactions`, `inventory_snapshots`, `purchase_orders`.
- `inventory_snapshots.ym` là chuỗi `'YYYY-MM'`, chỉ có 2017-01 … 2017-08.

## Đổi kiểu so với Postgres

DDL ở `01_tao_bang_scm.sql`, sinh từ catalog PG (`information_schema.columns`, `pg_constraint`, `pg_indexes`):
giữ đủ khoá chính, 13 khoá ngoại và các chỉ mục (`idx_orders_date`, `idx_orders_hub`, `idx_po_supplier`, `idx_inv_ym`,
`idx_sales_store_item`). Tên cột giữ nguyên; cột `date` viết `` `date` ``, cột `long` viết `` `long` `` (từ khoá của MySQL).

| PG | MySQL | Cột |
|---|---|---|
| `text` ngày `'YYYY-MM-DD'` (định dạng sạch 100%) | `DATE` | `sales.date`, `orders.order_date`, `purchase_orders.po_date`, `promised_date`, `received_date` |
| `text` `'YYYY-MM'` | `CHAR(7)` (giữ chuỗi) | `inventory_snapshots.ym` |
| `text` `'YYYY-MM-DD/YYYY-MM-DD'` | `VARCHAR(24)` (giữ chuỗi) | `shipments.week` |
| `date` | `DATE` | `oil`, `holidays`, `event_calendar`, `transactions`, `staffing_plan`, `warehouse_daily_ops` |
| `timestamp` | `DATETIME(6)` | `orders.created_at`, `picked_at`, `dispatched_at`, `hub_arrived_at`, `delivered_at` |
| `real` (float4) | `DECIMAL(12,3)` | `sales.unit_sales`, `inventory_snapshots.on_hand_begin/received/sold/on_hand_end/thieu_hut`, `purchase_orders.qty_*` |
| `double precision` | `DOUBLE` | còn lại (`lat`, `long`, `order_value_usd`, `inventory_value`, `defect_rate`, …) |
| `boolean` | `TINYINT(1)` (0/1) | `orders.is_cancelled`, `voucher_applied`, `voucher_manually_applied`, `sales.onpromotion`, `holidays.transferred` |
| `text` | `VARCHAR(n)` (n ≥ 2 × độ dài lớn nhất) | |
| `sales` phân vùng theo năm | thêm chỉ mục `idx_sales_date` | |

- `real` → `DECIMAL(12,3)`: dữ liệu có tối đa 3 chữ số thập phân (đã kiểm), nên tổng chính xác, hoà hạng không lệch do số thực.
  (So `SUM(unit_sales)` với PG thì PG lệch vài phần nghìn vì `real::numeric` làm tròn 6 chữ số; CSV xuất ra là giá trị đúng.)
- Ngày dạng `DATE`: học viên viết `` `date` >= '2017-07-01' `` (MySQL tự ép), `DATE_FORMAT`, `YEAR`, `MONTH` như bộ Datathon. Bẫy "ngày là chuỗi" của PG **không còn** ở MySQL, trừ `ym` và `week`.
- `holidays`, `sales` không có khoá chính (như PG).

## Biến thể ẩn `scm_hidden_1` (`03_bien_the_an_scm.sql`)

Bản sao `scm` rồi đổi như sau (khuôn `datathon_2026_hidden_1`):

| Biến thể · thay đổi | Khác public ở đâu | Bắt lỗi gì |
|---|---|---|
| (a) bỏ đơn `CAST(SUBSTRING(order_id,6) AS UNSIGNED) % 10 = 7` | `orders` −103.333 dòng (~10%) | bài chép số từ lần Chạy thử public; mọi con số về đơn đều khác |
| (a) bỏ PO `CAST(SUBSTRING(po_id,4) AS UNSIGNED) % 10 = 7` | `purchase_orders` −15.880 dòng | như trên, cho câu về mua hàng |
| (a) bỏ mọi dòng `sales` có `item_nbr % 10 = 7` | `sales` −357.960 dòng (~10,9%) | như trên, cho câu về bán hàng |
| (b) thêm `sales` ngày **2017-08-01**, cửa hàng 44, mặt hàng 2042941, `unit_sales` 500 | 1 dòng ngay sau cửa sổ tháng 7 | **thiếu cận trên** khi lọc tháng 7/2017 (`` `date` >= '2017-07-01' `` không có `< '2017-08-01'`) |
| (b) thêm đơn `ORD2_01033328` ngày **2017-09-01** (chép `ORD2_00034910`, dời 19 ngày) | 1 dòng sau ngày cuối 2017-08-13 | thiếu cận trên khi lọc tháng 8/2017 hoặc "từ ngày X" |
| (b) thêm PO `PO_0158799` ngày **2017-09-01** (chép `PO_0158798`, dời ngày) | 1 dòng sau ngày cuối 2017-08-15 | thiếu cận trên với `po_date` |
| (b) thêm tồn kho `ym = '2017-09'` (cửa hàng 1, mặt hàng 96995) | 1 dòng sau tháng cuối 2017-08 | thiếu cận trên với `ym`, lấy "tháng mới nhất" bằng `MAX(ym)` |
| (c) cộng 30 vào `unit_sales` của mặt hàng 1963265 (cửa hàng nhỏ nhất bán ngày 2017-07-01) | **family `DAIRY`, top 3 mặt hàng theo `SUM(unit_sales)` tháng 7/2017**: hạng 3 `838216` = hạng 4 `1963265` = 19.654 | dùng `RANK()`/`DENSE_RANK()` khi đề yêu cầu đúng 3 dòng (ra 4 dòng); thiếu quy tắc hoà (đề nên ghi "bằng nhau thì `item_nbr` nhỏ hơn trước") |
| (d1) thêm cửa hàng **99** (`city` = `state` = 'TP.HCM', loại B, cụm 6), chưa có giao dịch | `stores` +1 dòng | chép kết quả Chạy thử ở câu chỉ đọc danh mục cửa hàng (vd. cửa hàng ở TP.HCM: 9 dòng thay vì 8) |
| (d1) thêm mã hàng **9000001** (`SEAFOOD`, giá 8,20, vốn 6,75, biên 17,68%) vào `items` + `item_costs`, chưa có mua/bán/tồn | `items`, `item_costs` +1 dòng | chép kết quả ở câu đọc `item_costs` / đếm mã theo ngành |
| (d1) thêm ngày cao điểm **2016-09-02** "Quốc khánh", nhóm `le`, hệ số 2 | `event_calendar` +1 dòng | chép kết quả ở câu liệt kê/lọc ngày cao điểm 2016 |
| (d2) bỏ `transactions` có `(TO_DAYS(date) + store_nbr) % 10 = 7` | −8.348 dòng (~10%; cửa hàng 24 mất ngày 2017-07-08) | chép kết quả ở câu về lượt giao dịch |
| (d2) bỏ `oil` có `TO_DAYS(date) % 10 = 7` | −123 dòng (tháng 7/2017 mất ngày 12/7) | chép kết quả giá dầu |
| (d2) bỏ mọi kỳ `inventory_snapshots` của mặt hàng `item_nbr % 10 = 7` (khớp phép bỏ của `sales`) | −135.406 dòng (~10,8%) | chép kết quả ở câu tồn kho, fill rate, vốn tồn mọi kỳ |
| (d3) `shipments` số hiệu `% 10 = 7`: giao trễ (`actual_days` ≥ cam kết + 0,5) và thiếu hàng (95% lượng), `on_time` = `in_full` = `otif` = 0 | 1.206 dòng sửa | chép kết quả ở câu chuyến giao, OTIF, lượng xuất |
| (d3) `warehouse_daily_ops` ngày `TO_DAYS(date) % 10 = 7`: `orders_to_process`, `total_weight_kg`, `workload_ratio` × 1,15 | 437 dòng đổi giá trị (438 ngày theo quy tắc, 1 ngày 0 đơn) | chép kết quả ở câu tải kho, đơn cần xử lý |
| (d3) `staffing_plan` ngày `TO_DAYS(date) % 10 = 3`: `headcount_thuc_te` − 1 | 393 dòng sửa | chép kết quả ở câu đối soát nhân sự |
| (d4) bỏ chuyến `SH_0000168` (cửa hàng 1, tuần 2016-03-14) | `shipments` −1 dòng | cửa hàng 1 có 1 tuần không có chuyến |
| (d4) dòng ngày lễ 2016-03-02 (Phan Thiết, `Local`) nhập hai lần | `holidays` +1 dòng chép y hệt | chép kết quả ở câu tìm ngày lễ ghi trùng |
| (d4) bỏ kỳ 2017-07 của cửa hàng 51, mặt hàng 903285 (vẫn có bán tháng 7) | `inventory_snapshots` −1 dòng | top vốn tồn cửa hàng 51 đổi; thêm 1 cặp bán mà không có tồn kho |
| (d4) thêm PO `PO_9000001` của `SUP_002` (chép `PO_0002941`, đặt 2017-07-31), `Fail`, 19/468 hàng lỗi (4,06%) | `purchase_orders` +1 dòng | thêm 1 nhà cung cấp có lô trượt tháng 7/2017 |
| (d4) đơn `ORD2_00422150` (giao 60 giờ = cam kết) gắn `on_time` = 0 | `orders` 1 dòng sửa | thêm 1 đơn có cờ đúng hạn mâu thuẫn |

(d) nằm ở `04_bo_sung_bien_the_scm.sql`, chạy sau 03, lặp lại được (dòng giả xoá theo khoá rồi chèn lại, giá trị sửa tính
lại từ `scm`). Không bảng nào tham chiếu tới `orders`, `purchase_orders`, `sales`, `inventory_snapshots`, `transactions`,
`oil`, `shipments`, `warehouse_daily_ops`, `staffing_plan`, `holidays`, `event_calendar`, nên bỏ dòng không làm mồ côi khoá
ngoại; dòng danh mục giả (cửa hàng 99, mã 9000001) không có dòng sự kiện trỏ tới; các dòng thêm khác chép khoá từ dòng có sẵn. Muốn có bẫy mới (ví dụ trùng tên) thì thêm `scm_hidden_2` theo cùng cách và
ghi vào bảng này.

## File

| File | Việc |
|---|---|
| `01_tao_bang_scm.sql` | 20 bảng, PK/FK/index; không ghi tên database (dùng cho cả `scm` và `scm_hidden_1`) |
| `02_nap_scm.sh` | xuất CSV từ PG (`COPY … TO STDOUT WITH CSV HEADER`, `NULL '\N'`, boolean → 0/1), tạo `scm`, `LOAD DATA LOCAL INFILE`, `ANALYZE`, so số dòng |
| `03_bien_the_an_scm.sql` | tạo `scm_hidden_1` (gọi `SOURCE /sqllb/01_tao_bang_scm.sql`), in số dòng và cặp hoà |
| `04_bo_sung_bien_the_scm.sql` | bổ sung `scm_hidden_1` cho bảng danh mục / bảng phụ (nhóm d), in số dòng và số dòng sửa |
| `05_tai_khoan_cham_bai.sql` | user `sql_runner` chỉ SELECT |
| `du-lieu/` | CSV xuất từ PG + `so-dong-pg.txt` (không đưa vào gói) |
| `.env` | mật khẩu (không đưa vào gói) |
