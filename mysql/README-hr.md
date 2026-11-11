# MySQL cho SQL Leaderboard · bộ dữ liệu HR Analytics (`hr`)

Dựng ngày 10/11/2026 trên container dùng chung `sqllb-mysql` (MySQL 8.0, mạng `sqllb`; xem `README.md` cho container,
mật khẩu, user chấm). Nguồn: dự án **Project 02 HR Analytics** (`Project DA\Project 02 HR Analytics`),
5 file `data\generated\*.csv` (Revision 3, sinh ngày 2026-06-21; mô tả cột: `data\data_dictionary.md`; lịch sử sửa:
`data\CHANGELOG_data_fixes.md`). Dữ liệu **tổng hợp** (synthetic) mô phỏng "SEA Digital Operations Group": ~3.000 nhân viên,
6 nước Đông Nam Á, 24 ảnh chụp tháng.

| Thành phần | Giá trị |
|---|---|
| Database | `hr` (public), `hr_hidden_1` (biến thể ẩn) |
| Bộ kiểm | `dulieu=hr` → `hr`, `hidden-1` → `hr_hidden_1` theo quy tắc mặc định của `cong-cu/kiem_tra_goi.py` (không cần thêm vào `bien-the.json`; đã chạy thử, xem cuối file) |
| User chấm | `sql_runner`: `SELECT` trên `hr`, `hr\_hidden\_%` (đã thêm vào `05_tai_khoan_cham_bai.sql`) |
| Script | `mysql/hr/01_tao_bang_hr.sql`, `02_nap_hr.sh`, `03_bien_the_an_hr.sql`, `04_bo_sung_bien_the_hr.sql` |
| CSV trung gian | `mysql/hr/du-lieu/` (~14,8 MB, **không** đưa vào gói) |

```bash
bash mysql/hr/02_nap_hr.sh             # chép 5 CSV từ thư mục Project DA (đặt SQLLB_PROJECT_DA) + tạo bảng + nạp + so số dòng  (~10 giây)
bash mysql/hr/02_nap_hr.sh --chi-nap   # dùng CSV đã có trong mysql/hr/du-lieu/
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/hr/03_bien_the_an_hr.sql
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/hr/04_bo_sung_bien_the_hr.sql   # sau 03; chạy lặp lại được
# quyền: chạy lại 05_tai_khoan_cham_bai.sql (README.md bước 4) hoặc chỉ 2 lệnh GRANT cho hr trong file đó
```

## Bảng và số dòng (nạp đủ, không rút gọn)

Tổng **101.408 dòng** (5 bảng nguồn 100.982 + `positions` 426). Số dòng CSV = MySQL cho cả 5 bảng
(`02_nap_hr.sh` in bảng so sánh, file `du-lieu/so-dong-csv.txt`). `LOAD DATA` không có cảnh báo nào.

| Bảng | Hạt (1 dòng là) | Cửa sổ | `hr` | `hr_hidden_1` |
|---|---|---|---:|---:|
| `employee_monthly_snapshot` | 1 nhân viên × 1 tháng còn trong danh sách (kể cả tháng nghỉ việc) | `snapshot_month` **'2024-01' → '2025-12'** (24 tháng) | 73.451 | 65.966 |
| `engagement_survey` | 1 nhân viên × 1 quý khảo sát | `survey_quarter` '2024-Q1' → '2025-Q4' | 25.039 | 22.489 |
| `recruiting_pipeline` | 1 yêu cầu tuyển dụng | `approval_date` 2024-01-06 → 2025-12-22; `start_date` tới **2026-04-07** | 800 | 722 |
| `country_market_benchmark` | 1 nước × job_role × bậc × năm | `benchmark_year` 2024, 2025 | 852 | 853 |
| `position_plan` | 1 vị trí × năm kế hoạch (chốt tháng 12) | `plan_period` 2024 (418), 2025 (422) | 840 | 841 |
| `positions` | 1 vị trí (nước, phòng ban, job_family, bậc) — **suy ra** | — | 426 | 427 |

Quy mô: 3.872 nhân viên (3.000 có mặt từ 2024-01; tuyển mới 377 người năm 2024, 495 người năm 2025, tháng đầu có
`tenure_months = 0`); 798 lượt nghỉ việc; 6 nước, 6 phòng ban, 19 `job_family`, bậc L1–L7; 700 người từng là quản lý.

`positions` không có trong CSV: là chiều vị trí lấy từ mọi `position_id` của `employee_monthly_snapshot` và `position_plan`
(đã kiểm mỗi `position_id` ứng đúng một bộ nước/phòng ban/job_family/bậc ở cả 3 bảng; `recruiting_pipeline` không có vị trí lạ).
Làm vậy để có khoá ngoại và để vị trí **P0107** (có nhân viên nhưng vắng trong `position_plan`) vẫn có thuộc tính — cùng cách
`dim_position` của dbt trong dự án gốc phục hồi "vị trí đến muộn". Người soạn có thể không cho học viên thấy bảng này nếu muốn giữ bẫy P0107.

## Kiểu cột và quan hệ

| CSV | MySQL | Cột |
|---|---|---|
| `'YYYY-MM'` | `CHAR(7)` (giữ chuỗi) | `snapshot_month`, `recruiting_pipeline.attrition_month` |
| `'YYYY-QN'` | `CHAR(7)` (giữ chuỗi) | `survey_quarter` |
| `'YYYY-MM-DD'` | `DATE` | `approval_date`, `offer_accept_date`, `start_date` |
| số nguyên ghi `'74.0'` (pandas, vì có NaN), ô trống | `TINYINT`/`SMALLINT` `NULL` (phần lẻ luôn `.0`, đã kiểm) | `performance_rating`, `engagement_score`, `manager_effectiveness_score`, `absence_days`, `training_hours_6m` |
| `1.309` | `DECIMAL(5,3)` | `compa_ratio` (0,416 → 1,492) |
| 0/1 | `TINYINT(1)` | `high_performer_flag`, `internal_move_last_12m`, `attrition_this_month`, `attrition_next_3m/5m/6m`, `critical_role_flag` |
| `Yes`/`No` | `VARCHAR(4)` (chuỗi, **không** phải 0/1) | `position_plan.backfill_allowed` |
| ô trống (chuỗi) | `NULL` | `potential_rating`, `attrition_type`, `attrition_reason`, `manager_id`, `vacated_employee_id` |
| năm | `SMALLINT` | `benchmark_year`, `plan_period` |

Tên cột giữ nguyên CSV (có `eNPS` viết hoa; MySQL không phân biệt hoa thường tên cột).
**Không cột nào `UNSIGNED`**: với `UNSIGNED`, phép trừ ra âm (ví dụ `monthly_salary_usd - market_salary_p50_usd`,
điểm gắn kết tháng trừ điểm khảo sát) báo lỗi 1690 thay vì ra số âm.
`compa_ratio` **không** bằng đúng `monthly_salary_usd / market_salary_p50_usd` (lệch > 0,0015 ở 37.042 dòng, lệch lớn nhất
0,0403, do lương bị làm tròn sau khi tính): câu cần compa-ratio dùng cột có sẵn, câu đối soát dùng ngưỡng ≥ 0,05 (0 dòng) hoặc 0,02.

```text
positions (position_id PK)
  ├─< position_plan            (plan_period, position_id) PK      FK position_id
  ├─< employee_monthly_snapshot (employee_id, snapshot_month) PK  FK position_id
  └─< recruiting_pipeline      (requisition_id) PK                FK position_id

Nối không có khoá ngoại (khai báo trong \erdnoi khi dùng):
  employee_monthly_snapshot.manager_id      → employee_monthly_snapshot.employee_id   (tự nối; nên nối thêm cùng snapshot_month)
  engagement_survey (employee_id, survey_quarter) PK
      → employee_monthly_snapshot.employee_id; quý = CONCAT(LEFT(snapshot_month,4),'-Q',QUARTER(CONCAT(snapshot_month,'-01')))
  recruiting_pipeline.vacated_employee_id   → employee_monthly_snapshot.employee_id (dòng attrition_this_month = 1,
                                               snapshot_month = attrition_month: khớp 678/678)
  employee_monthly_snapshot ↔ position_plan  : position_id + plan_period = LEFT(snapshot_month,4)
  employee_monthly_snapshot ↔ country_market_benchmark :
      benchmark_year = LEFT(snapshot_month,4), country, job_role = job_family, job_level   (khớp 73.451/73.451)
  recruiting_pipeline ↔ position_plan        : position_id + plan_period = LEFT(attrition_month,4)
```

Chỉ mục: PK như trên; `idx_snap_month`, `idx_snap_position`, `idx_snap_manager`, `idx_snap_country_dept`,
`idx_survey_quarter`, `idx_plan_position`, `idx_req_position`, `idx_req_vacated`, `idx_req_approval`, `idx_pos_country_dept`.

## Bẫy dữ liệu đã kiểm (số thật trên `hr`)

| Bẫy | Số thật | Hệ quả khi viết SQL |
|---|---|---|
| Tháng nghỉ việc **vẫn có dòng** (`attrition_this_month = 1`) | 2025-12: 3.113 dòng, 39 người nghỉ trong tháng, 3.074 còn làm cuối tháng | "Số nhân viên cuối tháng" phải trừ người nghỉ; `COUNT(*)` theo tháng là quân số **đầu kỳ + tuyển mới** |
| `position_plan.actual_headcount` đếm **cả người nghỉ trong tháng 12** | Σ 2024 = 3.059 = số dòng 2024-12 (không phải 3.028 người còn làm) | so định biên với snapshot phải theo đúng định nghĩa này |
| Vị trí mồ côi **P0107** + lệch năm kế hoạch | snapshot nối `position_plan` cùng năm hụt **32 dòng** (P0107 năm 2024; P0125, P0239, P0327 năm 2025); `recruiting_pipeline` hụt **4 dòng** | `JOIN` làm rơi dòng, `LEFT JOIN` ra phòng ban NULL nếu lấy cột từ `position_plan` |
| NULL có chủ đích | `absence_days` 3.673; `engagement_score` 2.571; `training_hours_6m` 2.938; `manager_effectiveness_score` 2.204; `potential_rating` 2.204; `performance_rating` 1.469; `manager_id` 735 | `AVG` bỏ NULL, `COUNT(cột)` ≠ `COUNT(*)`; `potential_rating = 'High'` không tính NULL |
| `high_performer_flag = 1` mà `performance_rating` NULL | 331 dòng (cờ tính trước khi xoá điểm) | "nhân viên hiệu suất cao" theo cờ (16.629) ≠ theo `performance_rating >= 4` (16.298) — đề phải nói rõ dùng cột nào |
| Quản lý đã nghỉ vẫn ở `manager_id` | 7.270 dòng có `manager_id` không còn dòng snapshot **cùng tháng** (quản lý đã nghỉ trước đó); mọi `manager_id` đều có trong bảng (0 mồ côi tuyệt đối) | tự nối cùng `snapshot_month` bằng `JOIN` làm rơi 7.270 dòng |
| Cây quản lý **có chu trình** và đứt gãy | 800 dòng (24 tháng) A báo cáo B và B báo cáo A cùng tháng; riêng 2025-12: 17 cặp (ví dụ E00027 L5 ↔ E01414 L7), 639 dòng có quản lý đã nghỉ, 28 dòng `manager_id` NULL, 376 dòng quản lý cùng bậc hoặc thấp hơn. Duyệt đệ quy từ 28 gốc 2025-12 chỉ tới 147 người, sâu 6 tầng | CTE đệ quy (dạng E3) **bắt buộc** chặn độ sâu hoặc giữ đường đi (`path NOT LIKE`), nếu không sẽ lặp tới `cte_max_recursion_depth` (1000) và báo lỗi; câu cây nên giới hạn trong một tháng và một nhánh |
| `attrition_type`/`attrition_reason` chỉ có ở tháng nghỉ | 798 dòng; Voluntary 629, Retirement 120, Involuntary 49; lý do Compensation 156 cao nhất | lọc `attrition_type = 'Voluntary'` đã ngầm lọc tháng nghỉ; "nghỉ việc" chung gồm cả nghỉ hưu |
| Nhân viên đổi bậc (đề bạt) | 566 người có > 1 `job_level` / `position_id`; không ai đổi phòng ban, nước, job_family, quản lý, giới tính | đếm người theo bậc phải chọn tháng (cuối kỳ) hoặc `COUNT(DISTINCT)` sẽ đếm một người ở 2 bậc |
| Vietnam có 2 thành phố | Hanoi, Ho Chi Minh City (các nước khác 1) | nhóm theo `city` ≠ theo `country` |
| `gender` có nhóm thứ ba | Male 2.339, Female 1.480, **Non-disclosed 53** người | câu so sánh nam/nữ phải lọc rõ |
| Hai nguồn "gắn kết" khác nhau | `employee_monthly_snapshot.engagement_score` (tháng, có nhiễu, có NULL) ≠ `engagement_survey.engagement_score` (quý, không NULL) | đề phải chỉ rõ bảng |
| `job_role` = `job_family` trong snapshot | 0 dòng khác nhau; `position_plan`, `country_market_benchmark`, `recruiting_pipeline` chỉ có `job_role` | nối benchmark bằng `job_role = job_family` |
| Tháng/quý là chuỗi | `snapshot_month` '2024-01'; `survey_quarter` '2024-Q1'; nối với năm `SMALLINT` qua `LEFT(…,4)` (MySQL tự ép) | không dùng `YEAR(snapshot_month)` (NULL + cảnh báo); dùng `LEFT`, `CONCAT(snapshot_month,'-01')` |
| `start_date` vượt cửa sổ snapshot | tới 2026-04-07 | người nhận việc sau 2025-12 không có trong snapshot |
| Tuyển dụng: 2 loại yêu cầu | Backfill 678 (luôn có `vacated_employee_id`), New headcount 122 (NULL) | tỷ lệ tuyển thay thế, chi phí theo loại |
| Trần làm thêm theo nước | `MAX(overtime_hours)`: Vietnam 40, Indonesia 18, Thailand 36, Philippines 60, Singapore 72, Malaysia 104 | Vietnam đúng trần 40 giờ/tháng của BLLĐ 2019 Điều 107 |
| Hoà hạng tự nhiên ngay trong public | số người nghỉ tự nguyện theo quản lý: E01020 = E02237 = 7, rồi **4 quản lý cùng 6** (E00043, E00289, E00960, E01088); theo nước × phòng ban: Vietnam·Engineering 102, Indonesia·Engineering 38, **Philippines·Customer Support = Indonesia·Sales = 37** | top 3 ở hai nhóm này luôn cần quy tắc hoà trong đề |
| Mỗi dòng snapshot đều có khảo sát cùng quý | nối theo quý (công thức ở phần quan hệ) khớp 73.451/73.451 | nối sai quý (ví dụ `LEFT(survey_quarter,4)` = năm) nhân dòng ×4 |

Tỷ lệ nghỉ việc năm (Σ người nghỉ / quân số bình quân tháng, 24 tháng gộp) theo nước: Vietnam 30,1 %, Philippines 29,7 %,
Indonesia 26,8 %, Thailand 20,9 %, Malaysia 20,7 %, Singapore 17,2 % (chia đôi để ra mức năm ≈ 13 % như data_dictionary).

## Biến thể ẩn `hr_hidden_1` (`03_bien_the_an_hr.sql`, rồi `04_bo_sung_bien_the_hr.sql`)

| Biến thể · thay đổi | Khác public ở đâu | Bắt lỗi gì |
|---|---|---|
| (a) bỏ mọi dòng của nhân viên `CAST(SUBSTRING(employee_id,2) AS UNSIGNED) % 10 = 7` | `employee_monthly_snapshot` −7.489 dòng (~10,2 %), `engagement_survey` −2.552 | bài chép số từ lần Chạy thử public; mọi con số về nhân sự đều khác |
| (a) bỏ yêu cầu tuyển dụng `CAST(SUBSTRING(requisition_id,2) AS UNSIGNED) % 10 = 7` | `recruiting_pipeline` −80 | như trên, cho câu tuyển dụng |
| (b) thêm snapshot **'2026-01'** cho `E00002` (chép 2025-12, `tenure_months` +1, cờ nghỉ = 0) | 1 dòng sau tháng cuối '2025-12' | thiếu cận trên (`snapshot_month >= '2025-01'` không có `<= '2025-12'`); "tháng mới nhất" bằng `MAX(snapshot_month)` ra 1 người |
| (b) thêm khảo sát **'2026-Q1'** cho `E00002` | 1 dòng sau quý cuối '2025-Q4' | thiếu cận trên với `survey_quarter`; quý mới nhất |
| (b) thêm yêu cầu `R0801` (chép R0800, New headcount) duyệt **2026-01-05**, `attrition_month` '2026-01' | 1 dòng sau 2025-12-22 | thiếu cận trên với `approval_date` / `attrition_month` |
| (c) cộng 9 giờ vào `overtime_hours` của `E01799` tháng 2025-02 (41 → 50, Malaysia) | **top 3 nhân viên theo `SUM(overtime_hours)` năm 2025**: hạng 3 `E01799` = hạng 4 `E02682` = 849 (public: 849 vs 840) | `RANK()`/`DENSE_RANK()` khi đề cần đúng 3 dòng (ra 4); thiếu quy tắc hoà (đề ghi "bằng nhau thì `employee_id` nhỏ hơn trước") |
| (d) `04`: thêm nhân viên giả **`E09001`** (Account Executive bậc 3, Jakarta · Indonesia, vào làm 2025-10, quản lý `E00743`, vị trí `P0064`): 3 dòng snapshot 2025-10 … 2025-12 (`tenure_months` 0, 1, 2; `business_travel_days` 6, 8, **10**; không nghỉ việc, làm thêm 5/6/4 giờ) + 1 dòng khảo sát 2025-Q4 | `employee_monthly_snapshot` +3, `engagement_survey` +1; top 10 công tác của Account Executive Indonesia tháng 2025-12 có `E09001` ở hạng 4 (public: không) | câu chỉ dựa vào người không bị (a) bỏ (ví dụ `hr-r4-sales-cong-tac-indonesia`) vẫn khác public: chép kết quả Chạy thử thành hằng số thì rớt |
| (e) `04`: thêm vị trí giả **`P0901`** (Vietnam · Engineering · Data Engineer bậc 6, mở mới năm 2025, chưa có người) | `positions` +1, `position_plan` +1 (2025: định biên 2, thực tế 0, chỗ trống 2, `backfill_allowed = 'No'`, `critical_role_flag = 1`, High), `country_market_benchmark` +1 (2025, P50 5.900, P75 7.375) | câu chỉ đọc `position_plan` (ví dụ `hr-r6-dong-bang-tuyen-thay-the`: 17 dòng thay vì 16) |
| (f) `04`: thêm yêu cầu tuyển giả **`R9001`** (New headcount, `P0239` Singapore · Software Engineer bậc 4, `attrition_month` '2025-08', duyệt 2025-08-14, LinkedIn, 41 ngày, 3.870 USD) | `recruiting_pipeline` +1, trong cửa sổ; `P0239` vắng trong kế hoạch 2025 nên có thêm 1 yêu cầu "ngoài kế hoạch" | `hr-p4-yeu-cau-ngoai-ke-hoach`: 5 dòng thay vì 4; câu tuyển dụng theo nước/nguồn/loại cũng khác public |
| (c') hoà tự nhiên sau bước (a) | top 3 `job_family` theo số người nghỉ **tự nguyện năm 2025**: Data Engineer 31, QA Engineer 30, **Backend Engineer 26 = Support Specialist 26** (public: Support Specialist 29, Backend Engineer 27 — không hoà) | như (c), cho câu đếm người nghỉ |

Bảng chiều (`positions`, `position_plan`, `country_market_benchmark`) giữ nguyên dòng public, chỉ thêm dòng giả ở (e); dòng giả
(d), (f) trỏ tới vị trí có thật, nên không mồ côi khoá ngoại. Khoá giả dễ nhận: `E09001`, `P0901`, `R9001` (public tối đa `E03872`,
`P0426`, `R0800`). Các cặp hoà (c), (c') không đổi sau `04` (đã kiểm).
Sau (a), `position_plan.actual_headcount` không còn khớp số dòng snapshot tháng 12 ở hidden-1 — không nên ra câu kiểm
"định biên = đếm snapshot" bằng đẳng thức trên hidden. Một số `manager_id` trỏ tới người đã bị bỏ ở (a): tự nối bằng
`JOIN` sẽ rơi thêm dòng ở hidden-1 (đúng tinh thần bẫy quản lý vắng mặt).

## Chạy thử bộ kiểm (10/11/2026)

Gói nháp 1 câu `goi-cau-hoi/hr/_thu/` (write, top 3 nhân viên làm thêm giờ năm 2025, `bokiemtra={public, hidden-1}`):

```text
OK   hr-thu-top3-lam-them-2025   write   basic   0 loi, 0 canh bao
     · wrong dung_rank: rot o hidden-1
KIEM TRA: 0 loi
```

`dulieu=hr` ánh xạ đúng `hr`/`hr_hidden_1` bằng quy tắc mặc định; `bien-the.json` và bộ `scm` không bị sửa.
