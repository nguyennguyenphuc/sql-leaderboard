# Bản đồ 100 câu · bộ HR Analytics (`hr`)

**Bản 2 · sinh lại 10/11/2026 từ file thật** (`goi-*/cau-hoi.tex`, `goi-*/solution.sql`): mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá của `\begin{cauhoi}`; gói theo thư mục; module theo tiền tố mã (r n s a j q t f k p = M1…M10, c = case). Cột “Đề một câu” là mục đầu của `yeucau` (case: tên các bước); “Bảng” lấy từ `FROM`/`JOIN` của lời giải (bỏ CTE); “Bẫy chính” là khoá `bay` (case: tên bài sai theo bước). Phần mở đầu giữ từ bản 1; thống kê và chênh lệch so với bản 1 ở cuối file.

Bản nháp 1 · 10/11/2026. Phân bổ theo `BRIEF-SOAN-GOI.md` mục "Phân bổ": gói k = module 2k−1, 2k (9 câu mỗi module) + 2 case.
Dữ liệu, bẫy và biến thể: `mysql/README-hr.md`. Thuật ngữ, giọng văn, khái niệm, mảng: `style/STYLE-hr.md` (mảng mục G).

Viết tắt bảng: **S** `employee_monthly_snapshot` · **K** `engagement_survey` · **T** `recruiting_pipeline` · **P** `position_plan` ·
**B** `country_market_benchmark` · **V** `positions`. Hình thức: W write, D debug, O optimize, C case. Cấp: basic, easy, medium, hard.
Mảng: ops = operations, fin = finance, cus = customer, mkt = marketing, sal = sales, as = after_sales.
"h1" trong cột bẫy = bẫy chỉ lộ ở `hr_hidden_1` (thêm '2026-01' / '2026-Q1' / 2026-01-05; hoà hạng 3 OT 2025; bỏ ~10%).
Mọi câu có mốc thời gian phải có cận trên. Mọi top N phải nêu quy tắc hoà bằng khoá.

## Gói 1 · M1 Retrieval, M2 NULL & Expressions

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-r1-lam-them-vn-thang-12 | 1 | M1 | W | basic | A1 | ops | Ai ở Việt Nam làm thêm từ 30 giờ trong tháng 12/2025? | Xét nhân viên làm việc tại Việt Nam (`country` là `'Vietnam'`) có tên trong tháng 12/2025 (`snapshot_month` là `'2025-12'`), kể cả người nghỉ việc trong tháng. · Lọc người có giờ làm thêm trong tháng (`overtime_hours`) … | S | quen-loc-thang, bien-nguong |
| hr-r2-nghi-tu-nguyen-thang-9 | 1 | M1 | W | basic | A1 | as | Những ai nghỉ việc tự nguyện tháng 9/2025? | Xét tháng 9/2025 (`snapshot_month` là `'2025-09'`). · Lọc người nghỉ việc tự nguyện (`attrition_type` là `'Voluntary'`). | S | gop-loai-nghi, quen-loc-thang |
| hr-r3-tuyen-qua-gioi-thieu | 1 | M1 | W | basic | A1 | mkt | Yêu cầu tuyển dụng nào năm 2025 tuyển qua giới thiệu nội bộ? | Xét yêu cầu tuyển dụng có ngày duyệt (`approval_date`) trong năm 2025, từ `'2025-01-01'` tới trước `'2026-01-01'`. · Lọc yêu cầu có nguồn tuyển dụng (`recruitment_source`) là giới thiệu nội bộ. | T | sai-gia-tri-chu, thieu-can-duoi |
| hr-r4-sales-cong-tac-indonesia | 1 | M1 | W | easy | A1 | sal | Account Executive nào ở Indonesia đi công tác nhiều nhất? | Xét tháng 12/2025 (`snapshot_month` là `'2025-12'`), nhân viên làm việc tại Indonesia (`country` là `'Indonesia'`) có nhóm chức danh (`job_family`) là `'Account Executive'`. · Trả về `employee_id`, `job_level`, … | S | nham-phong-ban-voi-chuc-danh, hoa-o-cuoi-danh-sach |
| hr-r5-tiem-nang-cao-chua-de-bat | 1 | M1 | W | easy | A1 | cus | Ai có tiềm năng cao mà hai năm chưa được đề bạt? | Xét tháng 12/2025, nhân viên phòng `'Customer Support'` làm việc tại Indonesia. · Lọc người có tiềm năng (`potential_rating`) là `'High'` và số tháng kể từ lần đề bạt gần nhất (`months_since_promotion`) từ 24 trở lên. | S | quen-loc-thang, bien-nguong |
| hr-r6-dong-bang-tuyen-thay-the | 1 | M1 | W | easy | A1 | ops | Vị trí còn trống nào đang đóng băng tuyển thay thế? | Xét kế hoạch định biên năm 2025 (`plan_period` bằng 2025). · Lọc vị trí đang đóng băng tuyển thay thế (theo `backfill_allowed`) và còn chỗ trống (`vacancy_count` lớn hơn 0). | P | chuoi-yes-no, quen-nam-ke-hoach |
| hr-r7-danh-sach-nghi-huu-rong | 1 | M1 | D | basic | A1 | as | Danh sách nghỉ hưu năm 2025 ra rỗng | Sửa truy vấn dưới đây để liệt kê đúng người nghỉ hưu từ tháng `'2025-01'` tới tháng `'2025-12'`. · Giữ nguyên các cột `employee_id`, `snapshot_month`, `country`, `age` và thứ tự sắp. | S | sai-gia-tri-chu |
| hr-r8-yeu-cau-thang-3-thieu-ngay | 1 | M1 | D | easy | A1 | mkt | Số người bắt đầu làm việc tháng 3/2025 ra thiếu | Sửa truy vấn dưới đây để đếm đúng số yêu cầu tuyển dụng có ngày bắt đầu làm việc (`start_date`) trong tháng 3/2025, tính tới hết ngày cuối tháng. · Giữ nguyên các cột `so_yeu_cau`, `chi_phi_usd` (tổng … | T | can-tren-sai-ngay, quen-nam |
| hr-r9-loc-tp-hcm-ra-0 | 1 | M1 | D | easy | A1 | cus | Lọc nhân viên TP.HCM ra 0 người | Sửa hai lỗi trong truy vấn dưới đây để đếm đúng số nhân viên làm việc tại TP.HCM có tên trong tháng 12/2025 (kể cả người nghỉ việc trong tháng) có điểm gắn kết hằng tháng (`engagement_score`) dưới 40, không tính người … | S | sai-gia-tri-chu, nham-nuoc-voi-thanh-pho |
| hr-n1-vang-mat-binh-quan-thang-6 | 1 | M2 | W | basic | A2 | ops | Tháng 6/2025 mỗi nhân viên vắng bình quân mấy ngày? | Xét tháng 6/2025 (`snapshot_month` là `'2025-06'`). · Tính số ngày vắng mặt bình quân trên các dòng có dữ liệu chấm công (`absence_days` không trống). | S | null-trong-mau-so |
| hr-n2-thieu-diem-gan-ket | 1 | M2 | W | basic | A1 | cus | Ai thiếu điểm gắn kết tháng 12/2025? | Xét nhân viên có tên trong tháng 12/2025 (`snapshot_month` là `'2025-12'`), kể cả người nghỉ việc trong tháng. · Lọc nhân viên có điểm gắn kết hằng tháng (`engagement_score`) trống. | S | bang-null, quen-loc-thang |
| hr-n3-nhom-compa-ratio | 1 | M2 | W | easy | A3 | fin | Bao nhiêu người nhận lương thấp hơn mức thị trường? | Xét mọi nhân viên có tên trong tháng 12/2025. · Gán nhóm theo compa-ratio (tỷ số lương trên mức thị trường trung vị, `compa_ratio`): dưới 0,9 là `'thap_hon'`; từ 0,9 tới 1,1 (gồm cả hai đầu) là `'ngang'`; trên 1,1 là … | S | bien-nhom, ty-so-va-phan-tram |
| hr-n4-ty-le-nghi-tu-nguyen-2024 | 1 | M2 | W | easy | A2 | as | Bao nhiêu phần trăm người nghỉ năm 2024 là tự nguyện? | Xét các tháng từ `'2024-01'` tới `'2024-12'`. · Đếm người nghỉ việc (mọi loại, kể cả nghỉ hưu) và người nghỉ việc tự nguyện. | S | sai-mau-so, gop-loai-nghi |
| hr-n5-co-hieu-suat-cao-thieu-diem | 1 | M2 | W | easy | E1 | cus | Mỗi năm bao nhiêu cờ kết quả cao thiếu điểm đánh giá? | Xét các tháng từ `'2024-01'` tới `'2025-12'`. · Đếm dòng có cờ nhân viên có kết quả thực hiện công việc cao (`high_performer_flag` bằng 1) mà điểm đánh giá thực hiện công việc (`performance_rating`) trống. | S | so-sanh-voi-null |
| hr-n6-nhan-loai-yeu-cau | 1 | M2 | W | easy | A3 | mkt | Năm 2025 tuyển thay thế hay tuyển mới nhiều hơn? | Xét yêu cầu tuyển dụng có ngày duyệt (`approval_date`) trong năm 2025. · Gán nhãn `loai_yeu_cau`: yêu cầu có người nghỉ cần thay (`vacated_employee_id` không trống) là `'tuyen_thay_the'`, còn lại là `'tuyen_moi'`. | T | null-va-chuoi-rong, thieu-can-tren |
| hr-n7-gio-dao-tao-thap | 1 | M2 | D | basic | A2 | ops | Giờ đào tạo bình quân thấp bất thường | Sửa truy vấn dưới đây để tính đúng số giờ đào tạo bình quân của một nhân viên trong 6 tháng gần nhất, tính tại tháng 12/2025, chỉ trên các dòng có dữ liệu đào tạo. · Giữ nguyên cột `gio_dao_tao_bq` (giờ, làm tròn 2 chữ … | S | null-thanh-0 |
| hr-n8-dem-tiem-nang-thieu | 1 | M2 | D | easy | A2 | cus | Số người đủ điều kiện chương trình phát triển bị thiếu | Sửa truy vấn dưới đây để đếm đúng số nhân viên có tên trong tháng 12/2025 đủ điều kiện tham gia chương trình, gồm mọi người trừ người có tiềm năng (`potential_rating`) là `'Low'`. · Tính cả người chưa được đánh giá … | S | so-sanh-voi-null, thieu-ngoac-or |
| hr-n9-tien-lam-them-lech | 1 | M2 | D | easy | A2 | fin | Tiền lương làm thêm giờ ước tính bị lệch | Sửa truy vấn dưới đây để ước tính đúng tiền lương làm thêm giờ của nhân viên làm việc tại Việt Nam, tháng 12/2025. · Ước tính theo giả định sau: tiền lương giờ bằng tiền lương tháng chia 176 giờ; mỗi giờ làm thêm trả … | S | lam-tron-som |
| hr-c1-thang-nghi-nhieu-nhat | 1 | case | C | basic | – | as | Tháng nào năm 2025 nhiều người nghỉ việc nhất? | b1 Người nghỉ việc theo tháng; b2 Kết luận | S | b1: thieu_can_tren, count_dem_ca_so_0 |
| hr-c2-thieu-diem-gan-ket-theo-phong | 1 | case | C | basic | – | cus | Thiếu điểm gắn kết có tập trung ở phòng ban nào? | b1 Tỷ lệ thiếu điểm gắn kết theo phòng ban; b2 Kết luận | S | b1: dem_dong_co_diem, sap_theo_so_dong_thieu |

## Gói 2 · M3 String & Date, M4 Aggregation

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-s1-nghi-viec-theo-nam | 2 | M3 | W | basic | A3 | as | Mỗi năm có bao nhiêu người nghỉ việc? | Xét các tháng dữ liệu từ `'2024-01'` tới hết `'2025-12'`. · Đếm số người nghỉ việc theo năm nghỉ, tính mọi loại nghỉ kể cả nghỉ hưu. Cách nhận biết người nghỉ xem tab Nghiệp vụ. | S | ham-ngay-tren-chuoi |
| hr-s2-nhan-viec-thu-hai | 2 | M3 | W | basic | A1 | mkt | Ai ở Việt Nam đi làm vào thứ Hai? | Xét các yêu cầu tuyển dụng có `country` là `'Vietnam'` và `start_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025. · Giữ các yêu cầu có `start_date` rơi vào thứ Hai. | T | weekday-dayofweek, quen-can-tren |
| hr-s3-yeu-cau-theo-quy | 2 | M3 | W | easy | B1 | mkt | Số yêu cầu tuyển dụng được duyệt mỗi quý | Xét các yêu cầu tuyển dụng có `approval_date` từ ngày 1/1/2024 tới hết ngày 31/12/2025. · Gắn nhãn quý `quy` dạng `'2024-Q1'` theo ngày duyệt; đếm số yêu cầu của từng quý. | T | quen-can-tren, nhan-thieu-nam |
| hr-s4-cho-nhan-viec | 2 | M3 | W | easy | A3 | mkt | Từ nhận lời tới đi làm mất bao lâu? | Xét các yêu cầu tuyển dụng có `approval_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025. · Tính số ngày chờ bình quân theo nước. Số ngày chờ của một yêu cầu tính từ `offer_accept_date` tới `start_date`. | T | dao-thu-tu-datediff |
| hr-s5-y-dinh-o-lai-thap-q3 | 2 | M3 | W | easy | A1 | cus | Ai có ý định ở lại thấp nhất năm 2025? | Xét các phiếu khảo sát từ quý `'2025-Q1'` tới hết quý `'2025-Q4'`, có `intent_to_stay` bằng 1 và `eNPS` từ 0 tới 2. · Tính `thang_dau_quy` là tháng đầu của quý khảo sát, dạng chuỗi `'YYYY-MM'` như `snapshot_month` (ví … | K | thieu-so-0 |
| hr-s6-cong-tac-truong-nhom-sales | 2 | M3 | W | easy | A3 | sal | Trưởng nhóm kinh doanh công tác bao lâu năm 2025? | Xét các dòng của phòng `'Sales'` từ tháng `'2025-01'` tới hết tháng `'2025-12'`. · Gắn vai trò `vai_tro`: `'Truong nhom'` khi `job_family` chứa chuỗi `'Lead'` ở bất kỳ vị trí nào, còn lại là `'Nhan vien'` (viết không … | S | like-thieu-phan-tram, quen-can-tren |
| hr-s7-dem-nghi-theo-nam-null | 2 | M3 | D | basic | A3 | as | Số người nghỉ việc theo năm thiếu cả năm 2025 | Truy vấn dưới đây cần đếm số người nghỉ việc tự nguyện của phòng `'Engineering'` theo năm, từ tháng `'2024-01'` tới hết tháng `'2025-12'`, nhưng kết quả không có dòng năm 2025. · Sửa truy vấn cho đúng; giữ nguyên cột … | S | so-chuoi-thang-voi-nam |
| hr-s8-quy-4-thieu-thang-12 | 2 | M3 | D | basic | B1 | mkt | Yêu cầu tuyển dụng quý 4/2025 mất cả tháng 12 | Truy vấn dưới đây cần đếm số yêu cầu tuyển dụng duyệt từ ngày 1/10/2025 tới hết ngày 31/12/2025, theo tháng duyệt, nhưng kết quả không có tháng 12. · Sửa truy vấn cho đúng; giữ nguyên cột `thang` (dạng `'2025-10'`), … | T | can-tren-ngay-dau-thang, quen-can-tren |
| hr-s9-quan-so-sai-thu-tu | 2 | M3 | D | easy | B1 | ops | Quân số theo tháng sắp sai thứ tự | Truy vấn dưới đây tính quân số cuối tháng từ tháng 7/2024 tới hết tháng 6/2025 (định nghĩa ở tab Nghiệp vụ), nhưng các tháng sắp sai thứ tự. · Sửa để các tháng sắp đúng thứ tự thời gian, sớm trước. | S | sap-chuoi-dinh-dang |
| hr-a1-nghi-theo-ly-do-2025 | 2 | M4 | W | easy | A3 | as | Người nghỉ tự nguyện năm 2025 vì lý do gì? | Xét người nghỉ việc tự nguyện (`attrition_type` là `'Voluntary'`) có tháng nghỉ từ `'2025-01'` tới hết `'2025-12'`. · Đếm số người nghỉ theo lý do nghỉ `attrition_reason`. | S | gop-nghi-huu |
| hr-a2-luong-theo-bac | 2 | M4 | W | easy | A3 | fin | Tiền lương bình quân từng bậc tháng 12/2025 | Xét mọi dòng của tháng `'2025-12'`, gồm cả người nghỉ trong tháng đó. · Tính số nhân viên và tiền lương tháng bình quân theo bậc `job_level`. | S | quen-loc-thang |
| hr-a3-ty-le-nghi-viec-theo-nuoc | 2 | M4 | W | medium | A3 | as | Nước nào có tỷ lệ nghỉ việc cao nhất năm 2025? | Xét các tháng từ `'2025-01'` tới hết `'2025-12'`; người nghỉ việc gồm mọi loại. · Theo nước, tính số người nghỉ, quân số bình quân của 12 tháng và tỷ lệ nghỉ việc năm. Định nghĩa hai chỉ số này xem tab Nghiệp vụ. | S | mau-so-dem-nguoi, quen-can-tren |
| hr-a4-phong-compa-thap | 2 | M4 | W | easy | C3 | fin | Phòng ban nào ở nước nào lương dưới thị trường? | Xét mọi dòng của tháng `'2025-12'`. · Tính compa-ratio bình quân của từng cặp nước – phòng ban; chỉ giữ cặp có mức bình quân dưới 0,9. | S | where-thay-having |
| hr-a5-chi-phi-thoi-gian-tuyen | 2 | M4 | W | easy | A2 | mkt | Chi phí và thời gian tuyển một người năm 2025 | Xét các yêu cầu tuyển dụng có `approval_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025. · Tính theo loại yêu cầu `requisition_type`: số yêu cầu, chi phí tuyển dụng bình quân, thời gian tuyển bình quân. | T | quen-can-tren |
| hr-a6-enps-theo-quy | 2 | M4 | W | medium | B1 | cus | eNPS của công ty thay đổi thế nào qua các quý? | Xét các phiếu khảo sát từ quý `'2024-Q1'` tới hết quý `'2025-Q4'`. · Tính eNPS của từng quý; công thức xem tab Nghiệp vụ. | K | trung-lap-thanh-phan-doi, quen-can-tren |
| hr-a7-dem-nguoi-theo-phong-trung | 2 | M4 | D | easy | A3 | ops | Số người từng làm theo phòng ban ra quá lớn | Truy vấn dưới đây cần đếm, theo phòng ban, số nhân viên có tên ít nhất một tháng từ `'2025-01'` tới hết `'2025-12'`; mỗi người chỉ tính một lần. · Sửa truy vấn cho đúng; giữ nguyên cột `department`, `so_nhan_vien` và … | S | dem-dong-thay-nguoi |
| hr-a8-luong-bq-tu-bq-phong | 2 | M4 | D | medium | A2 | fin | Lương bình quân theo nước lệch số liệu kế toán | Truy vấn dưới đây cần tính tiền lương tháng bình quân của mọi nhân viên có tên trong tháng `'2025-12'`, theo nước, nhưng kết quả bị lệch. · Sửa truy vấn cho đúng (định nghĩa ở tab Nghiệp vụ); giữ nguyên cột `country`, … | S | trung-binh-cua-trung-binh |
| hr-a9-ty-le-thang-cong-tac-sales | 2 | M4 | D | medium | A2 | sal | Tỷ lệ tháng công tác dài ra 100% | Truy vấn dưới đây tính theo nước, cho phòng `'Sales'` từ tháng `'2025-01'` tới hết `'2025-12'`: số dòng nhân viên – tháng và tỷ lệ dòng có từ 10 ngày công tác trở lên. Nước nào cũng ra tỷ lệ 100%. · Sửa truy vấn cho … | S | count-dem-ca-false, quen-can-tren |
| hr-c3-lam-them-malaysia | 2 | case | C | basic | – | ops | Làm thêm giờ ở Malaysia có cao bất thường? | b1 Giờ làm thêm theo nước; b2 Kết luận | S | b1: quen_can_tren |
| hr-c4-nguon-tuyen-nhanh-re | 2 | case | C | easy | – | mkt | Nguồn tuyển nào vừa nhanh vừa rẻ? | b1 Mặt bằng chung năm 2025; b2 Thời gian và chi phí bình quân theo nguồn; b3 Kết luận | T | b1: quen_can_tren, binh_quan_cua_binh_quan_nguon; b2: tong_chi_phi |

## Gói 3 · M5 Joins, M6 Subqueries

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-j1-yeu-cau-theo-bac | 3 | M5 | W | easy | A3 | mkt | Bậc nào cần tuyển nhiều nhất năm 2025? | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Đếm số yêu cầu và tính chi phí tuyển dụng bình quân mỗi yêu cầu theo bậc của vị trí cần tuyển. | T, V | quen-can-tren, noi-thieu-nam |
| hr-j2-vi-tri-ngoai-ke-hoach | 3 | M5 | W | medium | E2 | ops | Vị trí nào có người làm nhưng chưa có định biên? | Xét mọi dòng nhân viên – tháng từ tháng 1/2024 tới hết tháng 12/2025. · Tìm các dòng mà vị trí của nhân viên không có trong kế hoạch định biên của đúng năm đó (năm của `snapshot_month`). | S, P | noi-thieu-nam, inner-join-mat-dong, quen-can-tren |
| hr-j3-tuyen-thay-nguoi-nghi-vi-luong | 3 | M5 | W | easy | A1 | as | Yêu cầu tuyển thay người nghỉ vì lương | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Giữ các yêu cầu tuyển thay thế cho người nghỉ việc vì lý do lương (`attrition_reason = 'Compensation'`). | T, S | noi-sai-cot |
| hr-j4-tin-tuong-quan-ly-theo-phong | 3 | M5 | W | medium | A3 | cus | Phòng ban nào tin tưởng quản lý thấp nhất quý 4/2025? | Xét các phiếu khảo sát gắn kết quý 4/2025 (`survey_quarter = '2025-Q4'`) của nhân viên còn có tên trong tháng 12/2025. · Lấy phòng ban của nhân viên ở tháng 12/2025; theo phòng ban, đếm số phiếu và tính điểm tin tưởng … | K, S | fan-out |
| hr-j5-luong-duoi-thi-truong | 3 | M5 | W | medium | C3 | fin | Nước nào có nhiều người nhận lương dưới 80% thị trường? | Xét nhân viên có tên trong tháng 12/2025. · So tiền lương tháng của từng người với mức lương thị trường P50 cùng năm, cùng nước, cùng chức danh và cùng bậc; giữ người có lương nhỏ hơn 0,8 lần P50. | S, B | noi-thieu-nam, dung-cot-co-san |
| hr-j6-quan-ly-khong-cao-hon | 3 | M5 | W | medium | E1 | ops | Bao nhiêu quản lý không cao bậc hơn cấp dưới? | Xét nhân viên có tên trong tháng 12/2025 và quản lý trực tiếp của họ cũng có tên trong tháng 12/2025. · Giữ các cặp mà bậc của quản lý nhỏ hơn hoặc bằng bậc của nhân viên. | S | thieu-cung-thang |
| hr-j7-phieu-khao-sat-gap-ba | 3 | M5 | D | easy | A3 | cus | Số phiếu khảo sát quý 4/2025 theo phòng ban ra gấp ba | Xét mọi phiếu khảo sát quý 4/2025 (`survey_quarter = '2025-Q4'`); phòng ban lấy từ dòng nhân viên – tháng trong quý. · Sửa truy vấn khởi đầu để mỗi phiếu chỉ được đếm một lần, kể cả phiếu của người đã nghỉ trong quý. | K, S | fan-out |
| hr-j8-nghi-co-tuyen-thay-the | 3 | M5 | D | medium | E2 | as | Tỷ lệ người nghỉ đã có yêu cầu tuyển thay thế ra 100% | Xét mọi lượt nghỉ việc (mọi loại, kể cả nghỉ hưu) từ tháng 1/2024 tới hết tháng 12/2025. · Sửa truy vấn khởi đầu để mẫu số gồm mọi người nghỉ, kể cả người không có yêu cầu tuyển thay thế. | S, T | inner-join-mat-dong, loc-bang-phai-o-where |
| hr-j9-trang-thai-quan-ly | 3 | M5 | D | medium | A3 | ops | Phân loại nhân viên theo quản lý trực tiếp ra thiếu người | Xét mọi nhân viên có tên trong tháng 12/2025. · Xếp mỗi nhân viên vào một nhóm: `'khong_ghi_quan_ly'` (không ghi quản lý), `'quan_ly_khong_con_ten'` (quản lý không có tên trong tháng 12/2025), `'quan_ly_con_ten'` (còn … | S | inner-join-mat-dong, thieu-cung-thang |
| hr-q1-luong-tren-bq-bac | 3 | M6 | W | easy | C3 | fin | Ai nhận lương cao hơn bình quân bậc của mình? | Xét nhân viên phòng `'Finance'` ở `'Vietnam'` có tên trong tháng 12/2025. · So tiền lương tháng của từng người với tiền lương bình quân của mọi nhân viên Việt Nam cùng bậc trong tháng 12/2025; giữ người có lương lớn hơn. | S | thieu-dieu-kien-thang |
| hr-q2-tuyen-khi-het-cho-trong | 3 | M6 | W | easy | A3 | ops | Mỗi nước duyệt bao nhiêu yêu cầu tuyển cho vị trí đã đủ người? | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Giữ yêu cầu của vị trí có số chỗ trống bằng 0 trong kế hoạch định biên năm 2025 (`plan_period = 2025`, `vacancy_count = 0`). | T, P | so-ke-hoach-khac-nam, quen-can-tren |
| hr-q3-gan-ket-cao-nhat-moi-phong | 3 | M6 | W | medium | C1 | cus | Ai có điểm gắn kết cao nhất mỗi phòng ban ở từng nước? | Xét nhân viên có tên trong tháng 12/2025, dùng điểm gắn kết hằng tháng của `employee_monthly_snapshot`. · Lấy mọi nhân viên có điểm bằng điểm cao nhất của nhóm cùng nước, cùng phòng ban trong tháng; nhiều người cùng … | S | khong-tuong-quan, hoa-diem |
| hr-q4-nghi-du-dinh-o-lai-cao | 3 | M6 | W | medium | A1 | as | Ai nghỉ tự nguyện dù khảo sát gần nhất nói muốn ở lại? | Xét người nghỉ việc tự nguyện (`attrition_type = 'Voluntary'`) trong các tháng từ 1/2025 tới hết 12/2025. · Lấy phiếu khảo sát gần nhất của từng người, tính tới hết quý có tháng nghỉ (người nghỉ tháng 5/2025 xét tới … | S, K | quy-lon-nhat-ca-bang, so-chuoi-quy-voi-thang |
| hr-q5-sales-lam-them-tren-bq | 3 | M6 | W | medium | C3 | sal | Bao nhiêu nhân viên kinh doanh làm thêm trên mức bình quân? | Xét các dòng của phòng `'Sales'` từ tháng 1/2025 tới hết tháng 12/2025. · Tính tổng giờ làm thêm cả năm của từng nhân viên (người làm chưa đủ 12 tháng vẫn tính tổng các tháng có tên). | S | sai-hat-binh-quan |
| hr-q6-yeu-cau-tuyen-lau | 3 | M6 | W | easy | A2 | mkt | Bao nhiêu yêu cầu tuyển lâu hơn mức bình quân? | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Tính thời gian tuyển bình quân của các yêu cầu này; đếm số yêu cầu có thời gian tuyển lớn hơn mức bình quân đó. | T | sai-pham-vi-binh-quan |
| hr-q7-chua-quan-ly-ai-ra-rong | 3 | M6 | D | easy | A1 | ops | Danh sách người bậc cao không quản lý ai ra rỗng | Xét nhân viên có tên trong tháng 12/2025, bậc từ 5 trở lên (`job_level >= 5`). · Sửa truy vấn khởi đầu để đếm đúng người không là quản lý trực tiếp của ai trong tháng 12/2025. | S | not-in-null |
| hr-q8-tren-bq-bac-sai-thang | 3 | M6 | D | medium | C3 | fin | Danh sách lương trên bình quân phòng ban, bậc bị thừa người | Xét nhân viên ở `'Singapore'` có tên trong tháng 12/2025. · Sửa truy vấn khởi đầu để mỗi người được so với tiền lương bình quân của nhân viên Singapore cùng phòng ban, cùng bậc, trong tháng 12/2025. | S | thieu-dieu-kien-thang, thieu-tuong-quan |
| hr-q9-ly-do-pho-bien-moi-nuoc | 3 | M6 | D | medium | C1 | as | Bảng lý do nghỉ việc phổ biến nhất chỉ có một nước | Xét người nghỉ việc tự nguyện (`attrition_type = 'Voluntary'`) trong các tháng từ 1/2025 tới hết 12/2025. · Sửa truy vấn khởi đầu để mỗi nước hiện lý do có nhiều người nghỉ nhất của chính nước đó; nhiều lý do bằng nhau … | S | thieu-tuong-quan, hoa-ly-do |
| hr-c5-tuyen-thay-the-kip-khong | 3 | case | C | easy | – | as | Chỗ của người nghỉ có được tuyển người thay kịp không? | b1 Người nghỉ năm 2025 theo loại; b2 Tuyển thay thế và thời gian chờ theo loại nghỉ; b3 Kết luận | S, T | b2: inner_join |
| hr-c6-luong-thap-va-nghi-viec | 3 | case | C | medium | – | fin | Nhóm lương thấp hơn thị trường có nghỉ việc nhiều hơn không? | b1 Quy mô ba nhóm compa-ratio năm 2025; b2 Tỷ lệ nghỉ việc tự nguyện theo nhóm; b3 Tách theo nước; b4 Kết luận | S | b2: mau_so_la_so_dong |

## Gói 4 · M7 CTE & Set Operations, M8 Window Functions

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-t1-nghi-viec-yoy-theo-phong | 4 | M7 | W | medium | B2 | as | Nghỉ việc theo phòng ban năm 2025 so với 2024 | Xét các tháng từ `'2024-01'` tới `'2025-12'`; người nghỉ việc gồm mọi loại, kể cả nghỉ hưu. · Tính tỷ lệ nghỉ việc năm 2024 và năm 2025 của từng phòng ban (cách tính ở tab Nghiệp vụ); quân số bình quân của năm bằng số … | S | chenh-lech-tuong-doi, sai-mau-so |
| hr-t2-doi-soat-dinh-bien | 4 | M7 | W | medium | E2 | ops | Kế hoạch định biên có khớp danh sách nhân viên? | Đối chiếu cho năm kế hoạch 2024 và 2025, theo vị trí. · Chiều thứ nhất: liệt kê vị trí trong kế hoạch có `actual_headcount` khác quân số cuối tháng 12 của năm đó (theo tab Nghiệp vụ; vị trí không có ai tính là 0), với … | P, S | dem-ca-nguoi-nghi, doi-soat-mot-chieu |
| hr-t3-pheu-tuyen-dung | 4 | M7 | W | medium | D1 | mkt | Yêu cầu tuyển dụng năm 2025 dừng ở khâu nào? | Xét yêu cầu tuyển dụng có ngày duyệt trong năm 2025 (từ `'2025-01-01'` tới hết `'2025-12-31'`). · Đếm ba bước của phễu: bước 1 `'duyet'` gồm mọi yêu cầu trên; bước 2 `'nhan_loi'` gồm yêu cầu có ngày nhận lời trước … | T | ngay-sau-cua-so, quen-can-tren |
| hr-t4-cay-duoi-mot-giam-doc | 4 | M7 | W | hard | E3 | ops | Ai nằm dưới quyền quản lý E01688 tháng 12/2025? | Lập cây quản lý tháng 12/2025 bắt đầu từ nhân viên `E01688` (tầng 0). Cấp dưới trực tiếp là tầng 1, cấp dưới của họ là tầng 2, và cứ thế tới hết cây. · Chỉ dùng quan hệ quản lý ghi trong tháng 12/2025; tính mọi người … | S | quen-cung-thang, noi-nguoc-chieu, chu-trinh |
| hr-t5-chuoi-quan-ly-lap | 4 | M7 | D | hard | E3 | ops | Tuyến báo cáo của E00041 lặp lại ba người | Truy vấn dưới đây liệt kê tuyến báo cáo tháng 12/2025 đi từ nhân viên `E00041` lên các cấp quản lý, mỗi dòng một người, nhưng lặp lại khi gặp một vòng báo cáo (người phía trên lại ghi người phía dưới là quản lý). · Sửa … | S | chu-trinh, chi-chan-do-sau |
| hr-t6-ty-trong-quy-luong | 4 | M7 | W | medium | C2 | fin | Mỗi phòng ban chiếm bao nhiêu phần quỹ lương? | Xét tháng 12/2025 (`'2025-12'`); quân số và quỹ lương tính trên mọi nhân viên có tên trong tháng, gồm cả người nghỉ trong tháng. · Tính quân số, quỹ lương của từng phòng ban, rồi tỷ trọng của từng phòng ban so với toàn … | S | mau-so-sai-pham-vi, bo-nguoi-nghi |
| hr-t7-cohort-tuyen-moi | 4 | M7 | W | hard | D2 | cus | Nhân viên mới còn lại bao nhiêu sau ba, sáu tháng? | Xét nhân viên mới (định nghĩa ở tab Nghiệp vụ), nhóm theo quý vào làm (dạng `'2024-Q2'`). · Một người còn làm việc sau k tháng nếu ở tháng vào làm cộng thêm k tháng, người đó có dòng và không nghỉ việc trong tháng đó … | S | cohort-chua-du-quan-sat, dau-cua-so-du-lieu, co-dong-la-con-lam |
| hr-t8-union-mat-dong | 4 | M7 | D | medium | A3 | mkt | Tổng yêu cầu tuyển hai năm của vài nguồn bị thiếu | Truy vấn dưới đây cộng số yêu cầu tuyển dụng duyệt trong năm 2024 và trong năm 2025 theo nguồn tuyển dụng, nhưng có nguồn bị thiếu số. · Sửa để `tong_yeu_cau` bằng số yêu cầu năm 2024 cộng số yêu cầu năm 2025 của từng … | T | union-mat-dong, quen-can-tren |
| hr-t9-doi-soat-except | 4 | M7 | D | medium | E2 | as | Danh sách chưa có người thay vẫn đủ mọi người nghỉ | Truy vấn dưới đây lấy người nghỉ việc tự nguyện và người bị chấm dứt hợp đồng năm 2025, rồi trừ đi người đã có người thay bắt đầu làm việc không muộn hơn ngày 31/12/2025, nhưng phép trừ không bỏ được ai. · Sửa để phép … | S, T | hai-ve-khac-nghia, not-in-gap-null |
| hr-f1-top3-lam-them-moi-nuoc | 4 | M8 | W | medium | C1 | ops | Mỗi nước ai làm thêm giờ nhiều nhất năm 2025? | Cộng giờ làm thêm từ tháng 1/2025 tới tháng 12/2025 của từng nhân viên. · Xếp hạng nhân viên trong từng nước theo tổng giờ giảm dần; bằng nhau thì `employee_id` nhỏ hơn đứng trước. Giữ đúng 3 người mỗi nước. | S | trung-hang, thieu-partition-by |
| hr-f2-luy-ke-nghi-viec | 4 | M8 | W | medium | B3 | as | Luỹ kế người nghỉ việc qua các tháng năm 2025 | Xét các tháng từ `'2025-01'` tới `'2025-12'`; người nghỉ việc gồm mọi loại, kể cả nghỉ hưu. · Tính số người nghỉ của từng tháng, số luỹ kế từ tháng 1 tới tháng đó, và tỷ lệ luỹ kế so với tổng người nghỉ cả năm. | S | quen-can-tren, dem-dong |
| hr-f3-de-bat-theo-thang | 4 | M8 | W | medium | B2 | fin | Mỗi tháng năm 2025 bao nhiêu người được đề bạt? | Một nhân viên được đề bạt trong tháng khi bậc của tháng đó cao hơn bậc ở tháng liền trước của chính người đó (khái niệm đề bạt ở tab Nghiệp vụ). · Xét tháng đề bạt từ `'2025-01'` tới `'2025-12'`. | S | thieu-partition-by, loc-truoc-khi-lag |
| hr-f4-gan-ket-giam-truoc-nghi | 4 | M8 | W | hard | D3 | as | Ai có điểm gắn kết giảm liền trước khi nghỉ? | Xét người nghỉ việc tự nguyện có tháng nghỉ trong năm 2025; dùng điểm gắn kết hằng tháng của ảnh chụp nhân sự, trên mọi tháng có dữ liệu của người đó. · Một tháng là tháng giảm khi điểm gắn kết thấp hơn tháng liền … | S | null-pha-chuoi, dem-khong-lien-tiep |
| hr-f5-gan-ket-truot-sales-indonesia | 4 | M8 | W | hard | B3 | sal | Gắn kết phòng Kinh doanh Indonesia biến động ra sao? | Xét nhân viên phòng `'Sales'` ở `'Indonesia'`, từ tháng 1/2024 tới tháng 12/2025; dùng điểm gắn kết hằng tháng của ảnh chụp nhân sự. · Tính điểm gắn kết bình quân của từng tháng (bỏ ô trống), rồi trung bình trượt 3 … | S | truot-tren-dong-chi-tiet, khung-chua-du |
| hr-f6-yeu-cau-dat-nhat-moi-phong | 4 | M8 | W | medium | C1 | mkt | Yêu cầu tuyển đắt nhất mỗi phòng ban năm 2025 | Xét yêu cầu tuyển dụng có ngày duyệt trong năm 2025. · Chọn yêu cầu có chi phí tuyển dụng cao nhất của từng phòng ban; bằng nhau thì `requisition_id` nhỏ hơn đứng trước. | T | quen-can-tren, avg-over-khong-chia-nhom |
| hr-f7-top3-lam-them-rank | 4 | M8 | D | medium | C1 | ops | Bảng làm thêm nhiều nhất mỗi phòng ban bị lặp tên | Truy vấn dưới đây cần xếp hạng nhân viên trong từng phòng ban theo tổng giờ làm thêm từ tháng 1/2025 tới tháng 12/2025 và giữ 3 người đầu mỗi phòng, nhưng đang xếp hạng trên từng dòng nhân viên – tháng. · Sửa để mỗi … | S | xep-hang-tren-dong-chi-tiet |
| hr-f8-tang-luong-lag-sai | 4 | M8 | D | hard | B2 | fin | Danh sách tăng lương 2025 lẫn người không được tăng | Truy vấn dưới đây liệt kê các lần tiền lương tháng của nhân viên phòng Kỹ thuật (`'Engineering'`) ở `'Vietnam'` tăng từ 8% trở lên so với tháng liền trước của chính người đó, xét tháng tăng từ `'2025-01'` tới … | S | thieu-partition-by, loc-truoc-khi-lag |
| hr-f9-luy-ke-khong-reset | 4 | M8 | D | medium | B3 | as | Luỹ kế nghỉ tự nguyện 2025 cộng cả năm 2024 | Truy vấn dưới đây đếm người nghỉ việc tự nguyện từng tháng từ `'2024-01'` tới `'2025-12'` và tính luỹ kế trong năm, nhưng luỹ kế năm 2025 cộng tiếp từ năm 2024. · Sửa để luỹ kế bắt đầu lại từ tháng 1 của mỗi năm. | S | thieu-partition-by |
| hr-c7-gan-ket-bao-truoc | 4 | case | C | medium | – | cus | Điểm gắn kết có báo trước việc nghỉ việc? | b1 Người nghỉ và người ở lại khác nhau bao nhiêu?; b2 Điểm gắn kết đổi ra sao khi gần tới tháng nghỉ?; b3 Khảo sát quý 2 đo cùng lúc nói gì?; b4 Kết luận | S, K | b1: gom_ca_thang_nghi; b2: tinh_ca_nghi_huu; b3: noi_theo_nam |
| hr-c8-diem-nong-vn-engineering | 4 | case | C | hard | – | as | Vì sao phòng Kỹ thuật ở Việt Nam nghỉ việc nhiều? | b1 Nhóm nào mất nhiều người nhất?; b2 Giờ làm thêm ở Việt Nam theo phòng ban; b3 Người nghỉ có được trả thấp hơn người ở lại?; b4 Năng lực quản lý ở Việt Nam theo phòng ban; b5 Kết luận | S | b1: dung_rank; b3: o_lai_gom_moi_thang; b4: mau_so_gom_o_trong |

## Gói 5 · M9 Data Quality, M10 Query Performance

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-k1-co-lech-diem-danh-gia | 5 | M9 | W | medium | E1 | cus | Cờ kết quả công việc cao có khớp điểm đánh giá? | Xét mọi dòng nhân viên – tháng từ tháng 1/2025 tới hết tháng 12/2025. · Đếm số dòng theo từng cặp giá trị của cờ nhân viên có kết quả thực hiện công việc cao (`high_performer_flag`) và điểm đánh giá thực hiện công … | S | null-so-sanh, quen-can-tren |
| hr-k2-loai-ly-do-nghi | 5 | M9 | W | medium | E1 | as | Lý do nghỉ có nhất quán với loại nghỉ? | Xét các lượt nghỉ việc (mọi loại, kể cả nghỉ hưu) từ tháng 1/2024 tới hết tháng 12/2025. · Coi một lượt nghỉ là hợp quy tắc khi: nghỉ hưu đi với lý do `'Retirement'` và người nghỉ từ 60 tuổi trở lên; không tự nguyện đi … | S | quen-loc-thang-nghi |
| hr-k3-gan-ket-hai-nguon | 5 | M9 | W | medium | E2 | cus | Điểm gắn kết tháng lệch khảo sát quý bao nhiêu? | Xét các dòng nhân viên – tháng từ tháng 1/2024 tới hết tháng 12/2025, ghép mỗi dòng với phiếu khảo sát của cùng nhân viên trong quý chứa tháng đó. · Chỉ so các dòng có điểm gắn kết tháng; coi là lệch khi chênh lệch … | S, K | noi-theo-nam, null-thanh-0 |
| hr-k4-bao-cao-vong | 5 | M9 | W | hard | E1 | ops | Cặp nhân viên nào là quản lý trực tiếp của nhau? | Xét sơ đồ tổ chức tháng 12/2025. · Tìm các cặp nhân viên là quản lý trực tiếp của nhau trong tháng đó. | S | dem-doi-cap, quen-cung-thang |
| hr-k5-ty-le-thieu-du-lieu | 5 | M9 | W | medium | E1 | ops | Chỉ số nào thiếu dữ liệu nhiều nhất năm 2025? | Xét mọi dòng nhân viên – tháng từ tháng 1/2025 tới hết tháng 12/2025. · Đếm số dòng trống (NULL) của sáu cột `absence_days`, `engagement_score`, `training_hours_6m`, `manager_effectiveness_score`, `potential_rating`, … | S | count-cot-dem-null |
| hr-k6-compa-tu-tinh | 5 | M9 | W | hard | E2 | fin | Compa-ratio trong hệ thống có khớp mức lương thị trường? | Xét mọi dòng nhân viên – tháng của năm 2025. · Tính lại compa-ratio (tỷ số lương trên mức thị trường trung vị) bằng cách chia trực tiếp tiền lương tháng cho mức lương thị trường P50 cùng năm, nước, chức danh, bậc; … | S, B | noi-thieu-nam |
| hr-k7-tong-theo-bac-lech | 5 | M9 | D | medium | E2 | as | Tổng người nghỉ theo bậc lớn hơn tổng chung | Truy vấn dưới đây đếm người nghỉ việc năm 2025 (mọi loại, kể cả nghỉ hưu) theo bậc, nhưng tổng các bậc lớn hơn tổng người nghỉ. · Sửa để mỗi người nghỉ được tính đúng một lần, ở bậc của tháng họ nghỉ. | S | doi-bac-dem-hai-lan |
| hr-k8-thieu-quan-ly-ra-0 | 5 | M9 | D | medium | E1 | ops | Số nhân viên thiếu quản lý ra 0 ở mọi phòng | Truy vấn dưới đây đếm, cho từng phòng ban, số nhân viên có tên trong tháng 12/2025 và số người chưa có quản lý trực tiếp, nhưng cột thứ hai luôn ra 0. · Sửa cho đúng; giữ cột `department`, `so_nhan_vien`, … | S | null-va-chuoi-rong |
| hr-k9-backfill-lech-thang | 5 | M9 | D | hard | E2 | mkt | Đối soát tuyển thay thế báo lệch bậc bất thường | Truy vấn dưới đây đối soát, theo nước, các yêu cầu tuyển thay thế được duyệt trong năm 2025: số yêu cầu và số yêu cầu có bậc vị trí tuyển khác bậc của người đã nghỉ tại tháng nghỉ. · Truy vấn có hai lỗi chồng nhau. Sửa … | T, V, S | fan-out, can-tren-dau-thang |
| hr-p1-nghi-ba-loai-mot-lan-quet | 5 | M10 | O | medium | A3 | as | Người nghỉ theo loại và nước chỉ một lần quét | Giữ nguyên kết quả: mỗi nước một dòng, gồm `country`, `tu_nguyen`, `khong_tu_nguyen`, `nghi_huu` là số người nghỉ việc theo từng loại trong năm 2025. · Sắp theo `country`. | S | truy-van-con-quet-lai |
| hr-p2-chi-so-thang-mot-lan-quet | 5 | M10 | O | basic | A2 | ops | Ba chỉ số tháng 12/2025 với một lần quét | Giữ nguyên kết quả: một dòng gồm `quan_so_cuoi_thang`, `so_nguoi_nghi`, `tong_gio_lam_them` của tháng 12/2025. | S | truy-van-con-quet-lai |
| hr-p3-top3-khong-tuong-quan | 5 | M10 | O | hard | C1 | ops | Ba người làm thêm giờ nhiều nhất mỗi nước, ít dòng trung gian | Giữ nguyên kết quả: mỗi nước ba nhân viên có tổng giờ làm thêm năm 2025 cao nhất, gồm `country`, `employee_id`, `tong_gio_lam_them`, `hang` (1 tới 3). · Bằng giờ thì `employee_id` nhỏ hơn xếp trước; sắp theo `country` … | S | tuong-quan-binh-phuong, hoa-hang |
| hr-p4-yeu-cau-ngoai-ke-hoach | 5 | M10 | O | medium | E2 | mkt | Yêu cầu tuyển ngoài kế hoạch chỉ một lần quét | Giữ nguyên kết quả: các yêu cầu tuyển dụng có `attrition_month` từ `'2024-01'` tới `'2025-12'` mà vị trí không có trong kế hoạch định biên của năm của `attrition_month`. · Trả về `requisition_id`, `position_id`, … | T, P | union-all-lap, quen-can-tren |
| hr-p5-tang-luong-khong-tu-noi | 5 | M10 | O | hard | B2 | fin | Mức tăng lương so với tháng trước không tự nối bảng | Giữ nguyên kết quả: mỗi tháng năm 2025 một dòng, gồm `thang`, `so_nguoi_tang_luong` (số nhân viên có tiền lương tháng cao hơn tháng liền trước của chính họ), `muc_tang_bq_pct` (mức tăng bình quân của những người đó, … | S | tu-noi-bang, loc-truoc-lag |
| hr-p6-enps-noi-mot-thang | 5 | M10 | O | hard | A3 | cus | eNPS theo phòng ban không nhân dòng rồi lọc trùng | Giữ nguyên kết quả: eNPS (chỉ số nhân viên sẵn sàng giới thiệu công ty) của từng phòng ban trên mọi phiếu khảo sát từ quý `'2025-Q1'` tới quý `'2025-Q4'`, gồm `department`, `so_phieu`, `enps` (làm tròn 1 chữ số). · Sắp … | K, S | fan-out-che-bang-distinct |
| hr-p7-dem-theo-thang-chi-muc | 5 | M10 | W | medium | A2 | ops | Quân số cuối mỗi tháng của quý 4/2025 | Xét các tháng từ tháng 10/2025 tới hết tháng 12/2025. · Tính quân số cuối tháng như định nghĩa ở tab Nghiệp vụ. | S | loc-thang-thieu-nam |
| hr-p8-chuoi-thang-sai | 5 | M10 | D | basic | A1 | cus | Lọc sáu tháng cuối năm 2025 ra 0 dòng | Truy vấn dưới đây liệt kê nhân viên có tiềm năng `'High'` và điểm gắn kết tháng dưới 30 trong các tháng 7 tới 12/2025, nhưng ra 0 dòng. · Sửa cho đúng; giữ cột `employee_id`, `so_thang` (số tháng thoả điều kiện), … | S | chuoi-thieu-so-0 |
| hr-p9-pareto-quan-ly | 5 | M10 | W | hard | C2 | as | Mấy quản lý chiếm nửa số người nghỉ tự nguyện? | Xét người nghỉ việc tự nguyện từ tháng 1/2024 tới hết tháng 12/2025 và có quản lý trực tiếp, lấy quản lý ghi ở tháng nghỉ. · Xếp quản lý theo số người nghỉ giảm dần; bằng nhau thì `manager_id` nhỏ hơn trước. Một quản … | S | khung-range-mac-dinh, null-quan-ly, hoa-hang |
| hr-c9-chi-phi-tuyen-thay-the | 5 | case | C | hard | C3 | mkt | Nước nào tốn kém nhất khi thay người nghỉ việc? | b1 Năm 2025 mỗi nước có bao nhiêu người nghỉ việc?; b2 Tuyển thay thế tốn bao nhiêu ở mỗi nước?; b3 Thay một người mất bao lâu?; b4 Chi phí tuyển bằng bao nhiêu tháng lương thị trường?; b5 Kết luận | S, T, V, B | b1: chi_dem_tu_nguyen; b2: tinh_ca_tuyen_moi; b3: tinh_toi_ngay_di_lam; b4: noi_thieu_bac |
| hr-c10-tang-luong-nhom-compa-thap | 5 | case | C | hard | C3 | fin | Có nên nâng lương nhóm compa-ratio thấp ở Việt Nam? | b1 Nhóm compa-ratio dưới 0,9 lớn cỡ nào?; b2 Nhóm này nghỉ tự nguyện nhiều hơn bao nhiêu?; b3 Nâng lương nhóm này lên 0,95 lần mức P50 tốn bao nhiêu?; b4 Chi phí tuyển thay thế tránh được là bao nhiêu?; b5 Kết luận | S, B, T | b1: tinh_ca_nguoi_nghi; b2: mau_so_dem_nguoi; b3: noi_thieu_nam; b4: tinh_ca_tuyen_moi |

## Thống kê (đếm từ bảng trên)

**Hình thức:** write 56 · debug 28 · optimize 6 · case 10 = 100. **Cấp:** basic 16 · easy 30 · medium 38 · hard 16.

### Hình thức × cấp

| Hình thức | basic | easy | medium | hard | Cộng |
|---|---:|---:|---:|---:|---:|
| write | 7 | 20 | 22 | 7 | 56 |
| debug | 5 | 8 | 12 | 3 | 28 |
| optimize | 1 | · | 2 | 3 | 6 |
| case | 3 | 2 | 2 | 3 | 10 |
| **Cộng** | 16 | 30 | 38 | 16 | 100 |

### Theo module: cấp và hình thức

| Module | basic | easy | medium | hard | write | debug | optimize | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| M1 Retrieval | 4 | 5 | · | · | 6 | 3 | · | 9 |
| M2 NULL & Expressions | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M3 String & Date | 4 | 5 | · | · | 6 | 3 | · | 9 |
| M4 Aggregation | · | 5 | 4 | · | 6 | 3 | · | 9 |
| M5 Joins | · | 3 | 6 | · | 6 | 3 | · | 9 |
| M6 Subqueries | · | 4 | 5 | · | 6 | 3 | · | 9 |
| M7 CTE & Set Operations | · | · | 6 | 3 | 6 | 3 | · | 9 |
| M8 Window Functions | · | · | 6 | 3 | 6 | 3 | · | 9 |
| M9 Data Quality | · | · | 6 | 3 | 6 | 3 | · | 9 |
| M10 Query Performance | 2 | · | 3 | 4 | 2 | 1 | 6 | 9 |
| Case | 3 | 2 | 2 | 3 | · | · | · | 10 |

### Theo gói

| Gói | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 12 | 6 | · | 2 | 9 | 11 | · | · |
| 2 | 12 | 6 | · | 2 | 5 | 11 | 4 | · |
| 3 | 12 | 6 | · | 2 | · | 8 | 12 | · |
| 4 | 12 | 6 | · | 2 | · | · | 13 | 7 |
| 5 | 8 | 4 | 6 | 2 | 2 | · | 9 | 9 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | operations | finance | customer | marketing | sales | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 Tra cứu lọc | 3 | · | 5 | 3 | 1 | 4 | 16 |
| A2 KPI | 4 | 2 | 1 | 2 | 1 | 1 | 11 |
| A3 Phân rã | 3 | 2 | 3 | 4 | 1 | 5 | 18 |
| A4 Bảng chéo | · | · | · | · | · | · | 0 |
| B1 Xu hướng | 1 | · | 1 | 2 | · | · | 4 |
| B2 So kỳ trước | · | 3 | · | · | · | 1 | 4 |
| B3 Luỹ kế, trượt | · | · | · | · | 1 | 2 | 3 |
| B4 Trạng thái tại thời điểm | · | · | · | · | · | · | 0 |
| C1 Top N mỗi nhóm | 3 | · | 1 | 1 | · | 1 | 6 |
| C2 Tỷ trọng | · | 1 | · | · | · | 1 | 2 |
| C3 So với chuẩn | · | 4 | · | · | 1 | · | 5 |
| C4 Phân khúc | · | · | · | · | · | · | 0 |
| D1 Phễu | · | · | · | 1 | · | · | 1 |
| D2 Cohort | · | · | 1 | · | · | · | 1 |
| D3 Chuỗi liên tiếp | · | · | · | · | · | 1 | 1 |
| E1 Bất thường | 4 | · | 2 | · | · | 1 | 7 |
| E2 Đối soát | 2 | 1 | 1 | 2 | · | 3 | 9 |
| E3 Cấu trúc cây | 2 | · | · | · | · | · | 2 |
| **Cộng** | 22 | 13 | 15 | 15 | 5 | 20 | 90 |

Dạng có câu: 15/18; chưa có: A4, B4, C4; chỉ 1 câu: D1, D2, D3.
Case có khai `dang` (không tính vào bảng): `hr-c9-chi-phi-tuyen-thay-the` C3, `hr-c10-tang-luong-nhom-compa-thap` C3.

Mảng trên cả 100 câu (gồm case): operations 23, finance 15, customer 17, marketing 17, sales 5, after_sales 23.

### Kiểm khung phân bổ

Lệch khung (module 9 câu: M1–M9 6 write + 3 debug, M10 ~6 optimize; cấp M1–3 basic/easy, M4–6 easy/medium, M7–10 medium/hard; case gói 1 → 5: basic+basic, basic+easy, easy+medium, medium+hard, hard+hard):

- `hr-p2-chi-so-thang-mot-lan-quet` (M10) cấp basic, ngoài khung medium / hard.
- `hr-p8-chuoi-thang-sai` (M10) cấp basic, ngoài khung medium / hard.

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: không có.

Ô trùng **giữa các gói** (9 ô; cho phép, ghi để tham khảo): 
- A1 · marketing · basic · write: `hr-r3-tuyen-qua-gioi-thieu`, `hr-s2-nhan-viec-thu-hai`
- A1 · customer · easy · write: `hr-r5-tiem-nang-cao-chua-de-bat`, `hr-s5-y-dinh-o-lai-thap-q3`
- A3 · finance · easy · write: `hr-n3-nhom-compa-ratio`, `hr-a2-luong-theo-bac`
- A3 · marketing · easy · write: `hr-n6-nhan-loai-yeu-cau`, `hr-s4-cho-nhan-viec`, `hr-j1-yeu-cau-theo-bac`
- C3 · finance · easy · write: `hr-a4-phong-compa-thap`, `hr-q1-luong-tren-bq-bac`
- A2 · marketing · easy · write: `hr-a5-chi-phi-thoi-gian-tuyen`, `hr-q6-yeu-cau-tuyen-lau`
- E2 · operations · medium · write: `hr-j2-vi-tri-ngoai-ke-hoach`, `hr-t2-doi-soat-dinh-bien`
- E1 · operations · medium · write: `hr-j6-quan-ly-khong-cao-hon`, `hr-k5-ty-le-thieu-du-lieu`
- E2 · after_sales · medium · debug: `hr-j8-nghi-co-tuyen-thay-the`, `hr-t9-doi-soat-except`, `hr-k7-tong-theo-bac-lech`

### Chênh lệch so với bản đồ bản 1 (phân bổ gốc)

So 100 dòng của bản 1 với 100 câu thật: 0 mã khác, 5 câu đổi hình thức/cấp/dạng/mảng, 73 câu đổi tiêu đề (không liệt kê).

Câu đổi khoá so với bản 1:

- `hr-s8-quy-4-thieu-thang-12`: cấp easy → basic
- `hr-a4-phong-compa-thap`: cấp medium → easy
- `hr-q2-tuyen-khi-het-cho-trong`: dạng A1 → A3
- `hr-p2-chi-so-thang-mot-lan-quet`: cấp medium → basic
- `hr-p8-chuoi-thang-sai`: cấp medium → basic

| | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Bản 1 | 56 | 28 | 6 | 10 | 13 | 30 | 41 | 16 |
| Bản 2 (thật) | 56 | 28 | 6 | 10 | 16 | 30 | 38 | 16 |

## Ghi chú giữ từ bản 1

_Giữ nguyên văn để không mất ý của người lập bản 1; số liệu trong các đoạn này có thể đã cũ, đối chiếu bảng và thống kê ở trên._

**Ghi chú dạng:**
- **E3 (cấu trúc cây)** lần đầu có dữ liệu thật: cây `manager_id` (t4 duyệt xuống từ gốc, t5 chuỗi đi lên gặp chu trình).
- **D1 phễu, D2 cohort, D3 chuỗi** chỉ 1 câu mỗi dạng: dữ liệu tuyển dụng chỉ có 3 mốc ngày (phễu ngắn); cohort chỉ có tuyển mới 2024-02 → 2025-12 (872 người); gaps-and-islands dựa trên chuỗi tháng điểm gắn kết.
- **sales** chỉ 5 câu (r4, s6, a9, q5, f5), đều lọc phòng 'Sales'; không có câu doanh số vì dữ liệu không có.
- Bảng `positions` chỉ dùng ở j1; nếu giấu bảng này khỏi học viên thì j1 nối T với P để lấy bậc (ghi rõ năm).

**Rủi ro cho người soạn:**
- Câu "top N" ở nhóm hoà sẵn trong public (quản lý theo số người nghỉ; nước × phòng ban hạng 3) bắt buộc có quy tắc hoà.
- Câu đếm người theo bậc phải chọn tháng; 566 người đổi bậc.
- Câu nào lọc '2025' bằng `snapshot_month >= '2025-01'` mà thiếu cận trên sẽ chỉ rớt ở h1 khi kết quả chứa E00002 (hidden thêm đúng một dòng): wrong "quen_can_tren" nên dùng câu có số đếm/tổng toàn công ty.
- `actual_headcount` ở h1 không còn khớp số dòng tháng 12 (vì bỏ ~10% nhân viên): t2 kiểm đối soát trên public, ở h1 kết quả khác nhưng solution vẫn tất định.
