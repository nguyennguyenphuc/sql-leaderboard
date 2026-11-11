# MySQL 8.0 cho SQL Leaderboard · bộ dữ liệu MARKETING (`mkt`)

Dựng ngày 10/11/2026 trên container dùng chung `sqllb-mysql` (xem `README.md`: mạng, cổng, mật khẩu, user `sql_runner`).
Nguồn: **Multi-Brand Marketing Campaign Performance Dataset** (Kaggle, sshriya08, CC BY 4.0, dữ liệu tổng hợp), bộ dữ liệu
của Project 01 Marketing Analytics (`Project DA\Project 01 Marketing Analytics Foundations & Data Pipeline\dataset\`,
mô tả ở `lesson1_marketing_analytics_foundations.md` mục II–III và `Plan.md`). Chiến dịch marketing số của ba thương hiệu
mỹ phẩm Ấn Độ **Nykaa, Purplle, Tira Beauty**, mỗi thương hiệu 55.555 chiến dịch.

| Thành phần | Giá trị |
|---|---|
| Database | `mkt` (public), `mkt_hidden_1` (biến thể ẩn) |
| Quyền | `sql_runner`: `SELECT` trên `mkt`, `mkt\_hidden\_%` (đã GRANT, ghi thêm vào `05_tai_khoan_cham_bai.sql`) |
| Bộ kiểm | `dulieu=mkt` → `mkt` / `mkt_hidden_1` theo luật mặc định (không cần sửa `bien-the.json`); gói thử `goi-cau-hoi/mkt/_thu` (1 câu): **KIEM TRA: 0 loi**, wrong thiếu cận trên rớt đúng ở hidden-1 |
| Cỡ | 10 bảng, **668.779 dòng** ở `mkt` (rất nhỏ so với ngân sách 6 triệu: lấy **đủ**, không rút gọn) |

## Dựng lại

```bash
# CSV gốc (chép nguyên, không đưa vào gói): mysql/mkt/du-lieu/
#   {nykaa,purplle,tira}_campaign_data.csv (có nhiễu), *_original.csv (sạch), noise_log.csv, inject_noise.py,
#   CreatDatabase.sql / ImportDatabase.sql / EDA.sql (script bài giảng, để tham khảo)
bash mysql/mkt/02_nap_mkt.sh     # tạo mkt + 01_tao_bang_mkt.sql + 02_nap_mkt.sql + so số dòng (~2 phút)
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/mkt/03_bien_the_an_mkt.sql   # ~3 phút
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/mkt/04_bo_sung_bien_the_mkt.sql   # bổ sung (d), vài giây, chạy lặp lại được
```

| File | Việc |
|---|---|
| `mkt/01_tao_bang_mkt.sql` | 10 bảng, PK/FK/index; không ghi tên database (dùng cho cả `mkt` và `mkt_hidden_1`) |
| `mkt/02_nap_mkt.sql` | `LOAD DATA LOCAL INFILE` (CSV là **CRLF**, `LINES TERMINATED BY '\r\n'`), chuẩn hoá bằng SQL (danh mục, tách kênh bằng `JSON_TABLE`), lịch bằng CTE đệ quy |
| `mkt/02_nap_mkt.sh` | tạo database, chạy 01 + 02, so số dòng CSV = MySQL (ghi `du-lieu/so-dong.txt`) |
| `mkt/03_bien_the_an_mkt.sql` | tạo `mkt_hidden_1`, in số dòng và cặp hoà |
| `mkt/04_bo_sung_bien_the_mkt.sql` | bổ sung `mkt_hidden_1` (chạy sau 03, idempotent theo khoá riêng `raw_id` 900001, `log_id` 60001): nhóm trùng 3 dòng ở bản thô |

## Thiết kế: từ 3 file phẳng sang 10 bảng có quan hệ

Mỗi file nguồn có 16 cột: `Campaign_ID, Campaign_Type, Target_Audience, Duration, Channel_Used` (đa trị "WhatsApp, YouTube"),
`Impressions, Clicks, Leads, Conversions, Revenue, Acquisition_Cost, ROI, Language, Engagement_Score, Customer_Segment, Date` (`DD-MM-YYYY`).
Bài giảng gộp thành một bảng phẳng `campaigns` + cột `Brand`. Ở đây tách thành:

- **Bản sạch, chuẩn hoá** (từ `*_original.csv`): `campaigns` (bảng sự kiện) + 5 danh mục + bảng cầu nối kênh + lịch.
  Đủ cho Joins (nối 3–6 bảng, một danh mục hai vai, cầu nối nhiều-nhiều), Subqueries, CTE, hàm cửa sổ, theo tuần/tháng.
- **Bản có nhiễu, phẳng như CSV** (`campaigns_raw`, từ `*.csv`) + **nhật ký nhiễu** (`noise_log`): cho module Data Quality
  (trùng dòng, NULL, số âm, phễu vô lý, ngày sai, khoảng trắng thừa) và đối chiếu "đáp án" nhiễu bằng JOIN/anti-join.

Tên bảng/cột tiếng Anh snake_case như bộ `scm`. Không cột nào trùng từ khoá cần backtick trừ `calendar.year/quarter/month`
và `campaigns_raw.language` (viết `` `year` ``, `` `language` `` cho chắc; MySQL vẫn chấp nhận không backtick).

### ERD dạng chữ

```text
brands (brand_id PK) ──1:n── campaigns (campaign_id PK) ──1:n── campaign_channels (campaign_id, channel_id PK) ──n:1── channels (channel_id PK)
campaign_types (type_id PK) ──1:n── campaigns.type_id
audiences (audience_id PK) ──1:n── campaigns.target_audience_id      (vai 1: đối tượng mục tiêu)
audiences (audience_id PK) ──1:n── campaigns.segment_id              (vai 2: phân khúc khách hàng)
languages (language_id PK) ──1:n── campaigns.language_id
calendar (cal_date PK) ──1:n── campaigns.start_date
brands ──1:n── campaigns_raw.brand_id          (campaigns_raw.campaign_id ~ campaigns.campaign_id, KHÔNG có FK: có dòng trùng)
brands ──1:n── noise_log.brand_id              (noise_log (brand_id,row_index) ~ campaigns_raw (brand_id,row_index); noise_log.campaign_id ~ campaigns.campaign_id)
```

### Bảng, số dòng, kiểu cột

| Bảng | Số dòng `mkt` | `mkt_hidden_1` | Cột (kiểu) |
|---|---:|---:|---|
| `campaigns` | 166.665 | 150.001 | `campaign_id` VARCHAR(12) PK (`NY-CMP-1000` … `TI-CMP-56554`), `brand_id`, `type_id`, `target_audience_id`, `segment_id`, `language_id` (TINYINT FK), `start_date` DATE FK→calendar, `duration_days` TINYINT (5–30), `impressions`, `clicks`, `leads`, `conversions`, `revenue` INT, `acquisition_cost` DECIMAL(10,2), `roi` DECIMAL(6,2), `engagement_score` DECIMAL(5,2) |
| `campaign_channels` | 333.381 | 299.873 | `campaign_id` FK, `channel_id` FK (PK kép), `channel_pos` TINYINT (thứ tự trong chuỗi gốc 1–3) |
| `campaigns_raw` | 166.815 | 150.138 | `raw_id` INT PK (thứ tự nạp), `brand_id` FK, `row_index` INT (vị trí trong file, 0 = dòng dữ liệu đầu; UNIQUE với `brand_id`), `campaign_id`, `campaign_type`, `target_audience`, `duration`, `channel_used`, `impressions`…`revenue` INT **NULL được**, `acquisition_cost` DECIMAL NULL, `roi`, `language`, `engagement_score`, `customer_segment`, `date_raw` VARCHAR(12) (chuỗi gốc) |
| `noise_log` | 1.530 | 1.396 | `log_id` PK, `brand_id` FK, `row_index`, `campaign_id`, `noise_type` (`'NULL'`, `'FUNNEL_ERROR'`, `'DUPLICATE'`, `'INVALID_DATE'`, `'NEGATIVE'`, `'WHITESPACE'`), `column_name` (tên cột CSV gốc, ví dụ `Revenue`), `old_value`, `new_value` VARCHAR(60) |
| `calendar` | 365 | 366 | `cal_date` PK (2024-07-01 → 2025-06-30, 12 tháng tròn), `year`, `quarter`, `month`, `month_name`, `iso_year`, `iso_week`, `week_start` (thứ Hai), `day_of_week` (1 = thứ Hai), `day_name`, `is_weekend` |
| `brands` | 3 | = | `brand_id` (1 Nykaa, 2 Purplle, 3 Tira Beauty), `brand_name`, `id_prefix` (NY/PU/TI), `source_file` |
| `campaign_types` | 5 | = | 1 Email, 2 Influencer, 3 Paid Ads, 4 SEO, 5 Social Media |
| `audiences` | 5 | = | 1 College Students, 2 Premium Shoppers, 3 Tier 2 City Customers, 4 Working Women, 5 Youth |
| `languages` | 4 | = | 1 Bengali, 2 English, 3 Hindi, 4 Tamil |
| `channels` | 6 | = | 1 Email, 2 Facebook, 3 Google, 4 Instagram, 5 WhatsApp, 6 YouTube |

Số dòng CSV = MySQL: sạch 3 × 55.555 = 166.665; có nhiễu 3 × 55.605 = 166.815; `noise_log` 1.530 (`du-lieu/so-dong.txt`).
Kiểm thêm: `campaigns_raw` khác bản sạch đúng 1.191 dòng (600 NULL + 300 phễu + 90 ngày + 150 số âm + 51 khoảng trắng ở `campaign_type`) + 150 dòng trùng chép thêm; `campaigns_raw` có đúng 166.665 `campaign_id` khác nhau.

### Cửa sổ thời gian

- `start_date` từ **2024-07-01 tới 2025-06-24**; ngày kết thúc muộn nhất (`start_date + duration_days − 1`) là 2025-06-28.
  Mỗi tháng 13.559–14.996 chiến dịch, **riêng 2025-06 chỉ 5.462 (tháng chưa đủ, dữ liệu tới 24/6)**. Mỗi ngày 16–550 chiến dịch bắt đầu.
- `calendar` 365 ngày; 6 ngày 2025-06-25 → 2025-06-30 **không có chiến dịch nào bắt đầu** (câu LEFT JOIN lịch ra 0).
  Tuần ISO 2025-W27 chỉ có 1 ngày (2025-06-30) trong lịch: tuần chưa đủ. 2024-07-01 là thứ Hai nên tuần đầu đủ 7 ngày.
- Không có cột giờ; không có ngày kết thúc (tự tính từ `duration_days`; quy ước trong đề: ngày cuối = `start_date + duration_days − 1`).

## Bẫy dữ liệu đã kiểm (số thật trên `mkt`)

**Bản sạch `campaigns`**

| Bẫy | Số kiểm |
|---|---|
| Trung bình cộng của tỷ lệ ≠ tỷ lệ của tổng (bài giảng nhấn mạnh "weighted vs simple average") | `AVG(roi)` = 2,6906 nhưng ROI tổng = (Σrevenue − Σchi phí)/Σchi phí = 1,9405. CTR thì gần nhau (8,5023% và 8,5040%) nên chỉ ROI/CPA mới lộ |
| Không có cột tổng chi phí: chi phí = `acquisition_cost × conversions` (bài giảng: Total_Spend) | Σ chi phí theo thương hiệu ≈ 9,70–9,72 tỷ; Σ doanh thu ≈ 28,45–28,66 tỷ |
| `roi` tính sẵn làm tròn 2 chữ số, khớp công thức ±0,01 ở 166.634/166.665 dòng; 31 dòng lệch tới ~0,03 (ví dụ `NY-CMP-13007`: cột 74,42, tính lại 74,44) | đề phải nói rõ dùng cột `roi` hay tính lại |
| ROI âm (chiến dịch lỗ) | 39.523 chiến dịch `roi < 0`, `MIN(roi)` = −0,99 |
| **Email vừa là loại chiến dịch vừa là kênh** | 33.493 chiến dịch loại Email, chỉ 11.133 trong số đó có kênh Email |
| **Cầu nối nhiều-nhiều nhân dòng** | 55.523 chiến dịch 1 kênh, 55.568 hai kênh, 55.574 ba kênh; Σ`revenue` sau JOIN `campaign_channels` = 171.360.853.040, gấp ~2 lần Σ thật 85.650.246.071 (doanh thu không chia được theo kênh) |
| Một danh mục hai vai | `audiences` nối 2 lần (`target_audience_id`, `segment_id`); trùng nhau ở 33.213 chiến dịch (~20%) |
| Tháng chưa đủ | 2025-06 chỉ tới 24/6 |
| Không có 0 ở mẫu số | không dòng nào có `impressions`, `clicks`, `leads`, `conversions` = 0 (vẫn nên dùng `NULLIF` như bài giảng) |
| Không hoà ở top doanh thu/ROI/điểm tương tác/chuyển đổi trên public | hoà chỉ có ở hidden-1 (c) |
| Dữ liệu tổng hợp, chênh lệch giữa nhóm rất nhỏ | ROI trung bình theo loại chiến dịch 2,649–2,715; kết luận case nên dựa vào tỷ lệ của tổng và nêu "khác biệt nhỏ" |

**Bản có nhiễu `campaigns_raw` (đối chiếu `noise_log`)**

| Nhiễu | `noise_log` | Phát hiện trên `campaigns_raw` |
|---|---:|---|
| Ô trống → NULL | 600 (`Impressions` 96, `Clicks` 100, `Leads` 93, `Conversions` 100, `Revenue` 93, `Acquisition_Cost` 118) | `COUNT(*)` ≠ `COUNT(col)`; `AVG` bỏ qua NULL; `SUM(a)/SUM(b)` lệch nếu không lọc cùng dòng |
| Số âm | 150 (`Revenue` 75, `Impressions` 75) | `impressions < 0`: 75; `revenue < 0`: 75 |
| Phễu vô lý | 300 (`Clicks` 102, `Leads` 99, `Conversions` 99) | `clicks > impressions`: **177** = 102 cố ý + 75 do `impressions` âm; `leads > clicks`: 99; `conversions > leads`: 99 |
| Ngày sai | 90 | `date_raw`: NULL 8, `'N/A'` 11, `'TBD'` 8, `'00-00-0000'` 7, `'31-13-2025'` 12, `'29-02-2025'` 9, `'01-01-1999'` 12, `'15-06-2030'` 6, `'2025-04-15'` 8, `'15/06/2025'` 9 (STR_TO_DATE trả NULL hoặc ra ngoài cửa sổ) |
| Khoảng trắng thừa | 240 (`Campaign_Type` 51, `Language` 76, `Target_Audience` 66, `Customer_Segment` 47) | 240 dòng `col <> TRIM(col)`. Collation `utf8mb4_0900_ai_ci` là **NO PAD**: `'Email  '` ≠ `'Email'`, `GROUP BY campaign_type` ra 20 nhóm thay vì 5 |
| Dòng trùng | 150 | 150 dòng trùng **hoàn toàn** (mọi cột), nằm ở `row_index` 55555–55604; `noise_log.row_index` của DUPLICATE là vị trí dòng **gốc** bị chép |

Bẫy riêng của `noise_log`: `noise_type = 'NULL'` là **chuỗi** (600 dòng), `WHERE noise_type IS NULL` ra 0; `old_value` dạng
`'1228654.0'`, `'Clicks=3613.0, Imp=30448.0'` (chuỗi, không so số trực tiếp); 1.530 dòng ứng với 1.530 `campaign_id` khác nhau.

## Biến thể ẩn `mkt_hidden_1` (`03_bien_the_an_mkt.sql` + `04_bo_sung_bien_the_mkt.sql`)

| Biến thể · thay đổi | Khác public ở đâu | Bắt lỗi gì |
|---|---|---|
| (a) bỏ chiến dịch có số đuôi `CAST(SUBSTRING_INDEX(campaign_id,'-',-1) AS UNSIGNED) % 10 = 7` (kèm kênh, dòng thô, nhật ký nhiễu của chiến dịch đó) | `campaigns` −16.665 (10%), `campaign_channels` −33.508, `campaigns_raw` −16.679, `noise_log` −135 | chép số từ lần Chạy thử public; hằng số cứng (`= 166665`, `LIMIT` theo số đếm) |
| (b) thêm chiến dịch `NY-CMP-56555` (chép `NY-CMP-1000`), `start_date` **2025-07-01**, kèm 2 kênh, 1 dòng `campaigns_raw` (`row_index` 55605, `date_raw` `'01-07-2025'`) và 1 ngày lịch 2025-07-01 | 1 dòng ngay sau cửa sổ 12 tháng (2024-07-01 → 2025-06-30); `calendar` 366 dòng | **thiếu cận trên**: "6 tháng đầu 2025", "quý 2/2025", "năm tài chính 7/2024–6/2025" lọc `>= ...` không có `< '2025-07-01'`; lấy "ngày/tháng mới nhất" bằng `MAX(start_date)`; câu đếm ngày lịch |
| (c) đặt `revenue` của `NY-CMP-53612` = 4.119.654 (bằng `NY-CMP-56543`), tính lại `roi` (41,26) ở `campaigns` và dòng thô | **Nykaa, top 3 chiến dịch theo `revenue`** (cả toàn kỳ, sau bước a): hạng 3 `NY-CMP-53612` = hạng 4 `NY-CMP-56543` = 4.119.654 | `RANK()`/`DENSE_RANK()` khi đề đòi đúng 3 dòng (ra 4); thiếu quy tắc hoà (đề ghi "bằng nhau thì `campaign_id` nhỏ hơn đứng trước": `'NY-CMP-53612'` < `'NY-CMP-56543'` theo chuỗi); câu top N theo thương hiệu (PARTITION BY brand) |
| (d) `04_bo_sung`: chép thêm dòng thô `PU-CMP-31194` (Purplle, đã trùng 1 lần ở `row_index` 55559) thành bản thứ ba `row_index` 55605, `raw_id` 900001; thêm 1 dòng `noise_log` DUPLICATE (`log_id` 60001, `row_index` gốc 30194) | `campaigns_raw` +1 (150.138), `noise_log` +1 (1.396; `PU-CMP-31194` có 2 dòng nhật ký). Purplle: 46 nhóm trùng nhưng **47 dòng thừa** (Nykaa 43/43, Tira 47/47) | đếm **số nhóm trùng** (`COUNT(*)` các nhóm `HAVING COUNT(*) > 1`) thay vì số dòng thừa `SUM(so_ban − 1)`; doanh thu thừa không nhân `so_ban − 1` (k2). Luật DUPLICATE kiểu "còn bản sau" bắt 2 dòng của nhóm này |

Top 5 Nykaa theo doanh thu ở hidden-1: 38379 (4.326.120), 6741 (4.264.178), 53612 = 56543 (4.119.654), 13914 (4.066.764).
Ở public top 4 Nykaa là 13007, 44157, 38379, 6741 (13007 và 44157 bị bỏ ở hidden vì đuôi 7).

Kiểm 10/11/2026 (sau 04, chạy từng khối, so md5 kết quả đã sắp): **115/115 khối `solution` của 5 gói khác nhau giữa `mkt` và `mkt_hidden_1`** (trước 04 cũng đã 115/115: các câu từng trùng như r2, j5, q2, q6, p3 đã được sửa đề). (d) chỉ thêm để k2 bắt được lỗi đếm số nhóm trùng. Mọi `wrong` "chỉ rớt ở hidden-1" (24 khối) vẫn rớt.

Lưu ý cho người soạn:
- `campaign_id` so theo **chuỗi**: `'NY-CMP-10000'` < `'NY-CMP-9999'`. Quy tắc hoà theo `campaign_id` là theo chuỗi; muốn theo số thì đề phải nói.
- Câu Data Quality dùng `campaigns_raw` hoặc so `campaigns_raw` với `campaigns`; câu nghiệp vụ dùng `campaigns`.
- `campaigns_raw` không có FK tới `campaigns` (vì trùng); nối bằng `campaign_id` sẽ nhân dòng ở 150 chiến dịch trùng.
- Bỏ dòng ở (a) không làm mồ côi khoá: mọi bảng con bị lọc cùng điều kiện; dòng thêm ở (b) chép khoá có sẵn.
- Muốn bẫy mới (ví dụ chuỗi có khoảng trắng ở bản sạch, NULL ở `campaigns`) thì thêm `mkt_hidden_2` theo cùng cách và ghi vào bảng này.

## Chế độ SQL (`sql_mode`) của máy chấm

Quyết định v3 (10/11/2026, câu `mkt-k4-phan-loai-ngay-loi`): máy chấm chạy với **`sql_mode` mặc định của MySQL 8.0**, không đặt lại
ở mức máy chủ hay phiên:

```text
ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
```

- Kiểm ngày 10/11/2026 trên `sqllb-mysql` (MySQL 8.0.46): `SELECT @@GLOBAL.sql_mode;` ra đúng chuỗi trên. `docker-compose.yml`
  không truyền `--sql-mode`, nên dựng lại vẫn giữ mặc định. Nếu sau này thêm `--sql-mode` vào `command`, phải giữ nguyên chuỗi trên.
- Vì sao cần: với `NO_ZERO_DATE`/`NO_ZERO_IN_DATE`, `STR_TO_DATE('00-00-0000', '%d-%m-%Y')` trả `NULL`, nên 7 dòng `date_raw =
  '00-00-0000'` rơi vào nhánh `'khong_ton_tai'` của k4. Đặt `sql_mode = ''` thì hàm trả `0000-00-00`, các dòng này chuyển sang
  nhánh `'ngoai_ky'` và lời giải k4 đổi kết quả (đã thử trên phiên riêng). Câu khác của bộ không phụ thuộc chế độ này.
- Môi trường chấm thật (nếu khác container này) phải chạy cùng `sql_mode`; kiểm bằng câu `SELECT` ở trên trước khi nhập gói 5.
