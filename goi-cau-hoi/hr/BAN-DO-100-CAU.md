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
| hr-r1-lam-them-vn-thang-12 | 1 | M1 | W | basic | A1 | ops | Ai ở Việt Nam làm thêm từ 30 giờ tháng 12/2025? | Xét nhân viên làm việc tại Việt Nam (`country` là `'Vietnam'`) có tên trong tháng 12/2025 (`snapshot_month` là `'2025-12'`), kể cả người nghỉ việc trong tháng. · Lọc người có giờ làm thêm trong tháng (`overtime_hours`) … | S | quen-loc-thang, bien-nguong |
| hr-r2-nghi-tu-nguyen-can-giu-quy-3 | 1 | M1 | W | medium | A1 | cus | Ai nghỉ tự nguyện quý 3/2025 mà công ty muốn giữ? | Xét các tháng từ `'2025-07'` tới `'2025-09'`. · Lấy người nghỉ việc mà công ty muốn giữ, theo định nghĩa ở tab Nghiệp vụ. | S | thieu-ngoac-or, bo-loc-ly-do, nham-muc-ket-qua-cao |
| hr-r3-yeu-cau-tuyen-cham-quy-4 | 1 | M1 | W | hard | A1 | mkt | Yêu cầu tuyển nào quý 4/2025 chậm hơn chuẩn dịch vụ? | Xét yêu cầu tuyển dụng được duyệt trong quý 4/2025. · Lấy yêu cầu tuyển qua trang tuyển dụng mà chậm hơn chuẩn dịch vụ (xem tab Nghiệp vụ). | T | thieu-can-tren, mot-chuan-cho-moi-loai, thieu-ngoac-or, lay-moi-nguon |
| hr-r4-sales-cong-tac-indonesia | 1 | M1 | W | easy | A1 | sal | Account Executive nào ở Indonesia đi công tác nhiều nhất? | Xét tháng 12/2025 (`snapshot_month` là `'2025-12'`), nhân viên làm việc tại Indonesia (`country` là `'Indonesia'`) có nhóm chức danh (`job_family`) là `'Account Executive'`. · Trả về `employee_id`, `job_level`, … | S | nham-phong-ban-voi-chuc-danh, hoa-o-cuoi-danh-sach |
| hr-r5-tiem-nang-cao-chua-de-bat | 1 | M1 | W | easy | A1 | cus | Ai có tiềm năng cao mà hai năm chưa được đề bạt? | Xét tháng 12/2025, nhân viên phòng `'Customer Support'` làm việc tại Indonesia. · Lọc người có tiềm năng (`potential_rating`) là `'High'` và số tháng kể từ lần đề bạt gần nhất (`months_since_promotion`) từ 24 trở lên. | S | quen-loc-thang, bien-nguong |
| hr-r6-dong-bang-tuyen-thay-the | 1 | M1 | W | easy | A1 | ops | Vị trí còn trống nào đang đóng băng tuyển thay thế? | Xét kế hoạch định biên năm 2025 (`plan_period` bằng 2025). · Lọc vị trí đang đóng băng tuyển thay thế (theo `backfill_allowed`) và còn chỗ trống (`vacancy_count` lớn hơn 0). | P | chuoi-yes-no, quen-nam-ke-hoach |
| hr-r7-danh-sach-nghi-huu-rong | 1 | M1 | D | basic | A1 | as | Danh sách nghỉ hưu năm 2025 ra rỗng | Sửa truy vấn dưới đây để liệt kê đúng người nghỉ hưu từ tháng `'2025-01'` tới tháng `'2025-12'`. · Giữ nguyên các cột `employee_id`, `snapshot_month`, `country`, `age` và thứ tự sắp. | S | sai-gia-tri-chu |
| hr-r8-phu-cap-di-lai-sales-thieu-nguoi | 1 | M1 | D | hard | A1 | sal | Danh sách xét phụ cấp đi lại quý 4/2025 bị thiếu người | Sửa truy vấn dưới đây để liệt kê đúng các dòng nhân viên – tháng được xét phụ cấp đi lại trong quý 4/2025, theo quy định ở tab Nghiệp vụ. · Giữ nguyên các cột `employee_id`, … | S | nham-chuc-danh-voi-phong-ban, thieu-can-tren, bien-nguong |
| hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu | 1 | M1 | D | medium | A1 | cus | Số nhân viên TP.HCM cần trò chuyện riêng ra quá nhiều | Sửa truy vấn dưới đây để đếm đúng số nhân viên làm việc tại TP.HCM có tên trong tháng 12/2025 (kể cả người nghỉ việc trong tháng) thuộc nhóm cần trò chuyện riêng, … | S | thieu-ngoac-or, nham-nuoc-voi-thanh-pho, bien-nguong |
| hr-n1-vang-mat-binh-quan-thang-6 | 1 | M2 | W | basic | A2 | ops | Tháng 6/2025 mỗi nhân viên vắng bình quân mấy ngày? | Xét tháng 6/2025 (`snapshot_month` là `'2025-06'`). · Tính số ngày vắng mặt bình quân trên các dòng có dữ liệu chấm công (`absence_days` không trống). | S | null-trong-mau-so |
| hr-n2-thieu-diem-gan-ket | 1 | M2 | W | basic | A1 | cus | Ai thiếu điểm gắn kết tháng 12/2025? | Xét nhân viên có tên trong tháng 12/2025 (`snapshot_month` là `'2025-12'`), kể cả người nghỉ việc trong tháng. · Lọc nhân viên có điểm gắn kết hằng tháng (`engagement_score`) trống. | S | bang-null, quen-loc-thang |
| hr-n3-nhom-compa-ratio | 1 | M2 | W | easy | A3 | fin | Bao nhiêu người nhận lương thấp hơn mức thị trường? | Xét mọi nhân viên có tên trong tháng 12/2025. · Gán nhóm theo compa-ratio (tỷ số lương trên mức thị trường trung vị, `compa_ratio`): dưới 0,9 là `'thap_hon'`; từ 0,9 tới 1,1 (gồm cả hai đầu) là `'ngang'`; trên 1,1 là … | S | bien-nhom, ty-so-va-phan-tram |
| hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4 | 1 | M2 | W | medium | A2 | as | Quý 4/2025 tỷ lệ nghỉ tự nguyện quy năm là bao nhiêu? | Xét các tháng từ `'2025-10'` tới `'2025-12'`. · Tính số người nghỉ việc tự nguyện, quân số bình quân của quý và tỷ lệ nghỉ việc tự nguyện quy năm, theo định nghĩa ở tab Nghiệp vụ. | S | mau-so-la-so-dong, quen-quy-nam, thieu-can-tren |
| hr-n5-co-hieu-suat-cao-thieu-diem | 1 | M2 | W | easy | E1 | cus | Mỗi năm bao nhiêu cờ kết quả cao thiếu điểm đánh giá? | Xét các tháng từ `'2024-01'` tới `'2025-12'`. · Đếm dòng có cờ nhân viên có kết quả thực hiện công việc cao (`high_performer_flag` bằng 1) mà điểm đánh giá thực hiện công việc (`performance_rating`) trống. | S | so-sanh-voi-null |
| hr-n6-phan-loai-thieu-nguoi-2025 | 1 | M2 | W | hard | C4 | ops | Các vị trí năm 2025 thiếu người ở mức nào? | Xét kế hoạch định biên năm 2025. · Xếp mỗi vị trí vào đúng một nhóm `'chua_co_nguoi'`, `'thieu_nhieu'`, `'thieu_it'` hoặc `'du_nguoi'`, theo quy tắc ở tab Nghiệp vụ. | P | thu-tu-case, bien-ty-le, quen-nam-ke-hoach |
| hr-n7-ty-le-chua-dao-tao-cao | 1 | M2 | D | medium | A2 | ops | Tỷ lệ nhân viên chưa được đào tạo cao bất thường | Sửa truy vấn dưới đây để tính đúng tỷ lệ nhân viên chưa được đào tạo trong 6 tháng gần nhất, tính tại tháng 12/2025, theo định nghĩa ở tab Nghiệp vụ. · Giữ nguyên các cột … | S | null-thanh-0, mau-so-gom-o-trong |
| hr-n8-dem-tiem-nang-thieu | 1 | M2 | D | easy | A2 | cus | Số người đủ điều kiện chương trình phát triển bị thiếu | Sửa truy vấn dưới đây để đếm đúng số nhân viên có tên trong tháng 12/2025 đủ điều kiện tham gia chương trình, gồm mọi người trừ người có tiềm năng (`potential_rating`) là `'Low'`. · Tính cả người chưa được đánh giá … | S | so-sanh-voi-null, thieu-ngoac-or |
| hr-n9-tien-lam-them-quy-4-lech | 1 | M2 | D | hard | A2 | fin | Tiền lương làm thêm giờ quý 4/2025 ở Việt Nam bị lệch | Sửa truy vấn dưới đây để ước tính đúng tổng giờ làm thêm và tiền lương làm thêm giờ của nhân viên làm việc tại Việt Nam trong quý 4/2025, theo cách ước tính ở tab Nghiệp vụ. · … | S | sai-he-so-150, lam-tron-som, thieu-can-tren |
| hr-c1-thang-nghi-nhieu-nhat | 1 | case | C | basic | – | as | Tháng nào năm 2025 nhiều người nghỉ việc nhất? | b1 Người nghỉ việc theo tháng; b2 Kết luận | S | b1: thieu_can_tren, count_dem_ca_so_0 |
| hr-c2-thieu-diem-gan-ket-theo-phong | 1 | case | C | basic | – | cus | Thiếu điểm gắn kết có tập trung ở phòng ban nào? | b1 Tỷ lệ thiếu điểm gắn kết theo phòng ban; b2 Kết luận | S | b1: dem_dong_co_diem, sap_theo_so_dong_thieu |

## Gói 2 · M3 String & Date, M4 Aggregation

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-s1-lam-them-quy-so-cung-ky | 2 | M3 | W | medium | B2 | ops | Giờ làm thêm mỗi quý năm 2025 so với cùng kỳ năm trước | Xét các dòng từ tháng `'2024-01'` tới hết tháng `'2025-12'`. · Gắn quý theo tháng dữ liệu, nhãn `quy` dạng `'Q1'` tới `'Q4'` (không kèm năm), để quý của hai năm nằm trên cùng một dòng. | S | ham-ngay-tren-chuoi, else-0-trong-avg, sai-ky-goc |
| hr-s2-nhan-viec-thu-hai | 2 | M3 | W | basic | A1 | mkt | Ai ở Việt Nam đi làm vào thứ Hai? | Xét các yêu cầu tuyển dụng có `country` là `'Vietnam'` và `start_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025. · Giữ các yêu cầu có `start_date` rơi vào thứ Hai. | T | weekday-dayofweek, quen-can-tren |
| hr-s3-cho-hoi-nhap-thu-hai | 2 | M3 | W | hard | A3 | mkt | Đón người mới vào thứ Hai thì họ phải chờ bao lâu? | Xét các yêu cầu tuyển dụng có `approval_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025; mỗi yêu cầu ứng với một người mới, ngày đi làm là `start_date`. · Theo nước, tính số người mới, số người phải chờ buổi hội nhập và số ngày chờ bình quân … | T | weekday-dayofweek, thu-hai-cho-7-ngay, binh-quan-gom-nguoi-khong-cho, quen-can-tren (h1) |
| hr-s4-cho-nhan-viec | 2 | M3 | W | easy | A3 | mkt | Từ nhận lời tới đi làm mất bao lâu? | Xét các yêu cầu tuyển dụng có `approval_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025. · Tính số ngày chờ bình quân theo nước. Số ngày chờ của một yêu cầu tính từ `offer_accept_date` tới `start_date`. | T | dao-thu-tu-datediff |
| hr-s5-y-dinh-o-lai-thap-2025 | 2 | M3 | W | easy | A1 | cus | Ai có ý định ở lại thấp nhất năm 2025? | Xét các phiếu khảo sát từ quý `'2025-Q1'` tới hết quý `'2025-Q4'`, có `intent_to_stay` bằng 1 và `eNPS` từ 0 tới 2. · Tính `thang_dau_quy` là tháng đầu của quý khảo sát, dạng chuỗi `'YYYY-MM'` như `snapshot_month` (ví … | K | thieu-so-0 |
| hr-s6-cong-tac-truong-nhom-sales | 2 | M3 | W | easy | A3 | sal | Trưởng nhóm kinh doanh công tác bao lâu năm 2025? | Xét các dòng của phòng `'Sales'` từ tháng `'2025-01'` tới hết tháng `'2025-12'`. · Gắn vai trò `vai_tro`: `'Truong nhom'` khi `job_family` chứa chuỗi `'Lead'` ở bất kỳ vị trí nào, còn lại là `'Nhan vien'` (viết không … | S | like-thieu-phan-tram, quen-can-tren |
| hr-s7-quy-luong-nam-lech-ke-toan | 2 | M3 | D | medium | E2 | fin | Quỹ lương năm 2024 thấp hơn sổ lương kế toán | Truy vấn dưới đây cần tính, theo năm, quỹ lương năm và quỹ lương bình quân tháng từ tháng `'2024-01'` tới hết tháng `'2025-12'` (định nghĩa ở tab Nghiệp vụ), nhưng quỹ lương năm 2024 thấp hơn số đúng. · Sửa truy vấn … | S | moc-ngay-day-du-tren-chuoi-thang, quen-can-tren (h1) |
| hr-s8-quy-4-thieu-thang-12 | 2 | M3 | D | basic | B1 | mkt | Yêu cầu tuyển dụng quý 4/2025 mất cả tháng 12 | Truy vấn dưới đây cần đếm số yêu cầu tuyển dụng duyệt từ ngày 1/10/2025 tới hết ngày 31/12/2025, theo tháng duyệt, nhưng kết quả không có tháng 12. · Sửa truy vấn cho đúng; giữ nguyên cột `thang` (dạng `'2025-10'`), … | T | can-tren-ngay-dau-thang, quen-can-tren |
| hr-s9-quan-so-cuoi-thang-lech | 2 | M3 | D | hard | B1 | ops | Quân số cuối tháng vừa sai thứ tự vừa lệch số chốt | Truy vấn dưới đây cần tính quân số cuối tháng (định nghĩa ở tab Nghiệp vụ) của từng tháng từ tháng 7/2024 tới hết tháng 12/2025, tháng sớm đứng trước. · Truy vấn có ba lỗi chồng nhau. Sửa truy vấn cho đúng; … | S | sap-chuoi-nhan-thang, dem-ca-nguoi-nghi, quen-can-tren (h1) |
| hr-a1-nghi-theo-ly-do-2025 | 2 | M4 | W | basic | A3 | as | Người nghỉ tự nguyện năm 2025 vì lý do gì? | Xét các dòng có `attrition_type` là `'Voluntary'` và `snapshot_month` từ `'2025-01'` tới hết `'2025-12'`; mỗi dòng như vậy là một người nghỉ việc tự nguyện. · Đếm số người nghỉ theo lý do nghỉ `attrition_reason`. | S | quen-loc-nam |
| hr-a2-luong-theo-bac | 2 | M4 | W | basic | A3 | fin | Tiền lương bình quân từng bậc tháng 12/2025 | Xét mọi dòng của tháng `'2025-12'`, gồm cả người nghỉ trong tháng đó. · Tính số nhân viên và tiền lương tháng bình quân theo bậc `job_level`. | S | quen-loc-thang |
| hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu | 2 | M4 | W | hard | C1 | as | Ba nhóm chức danh có nhiều người nghỉ tự nguyện nhất năm 2025 | Xét các tháng từ `'2025-01'` tới hết `'2025-12'`. · Theo nhóm chức danh `job_family`, tính số người nghỉ việc tự nguyện, số người trong đó có kết quả thực hiện công việc cao và tỷ lệ nghỉ việc tự nguyện của năm. … | S | co-nghi-gom-moi-loai, mau-so-dem-nguoi, co-va-diem-danh-gia, hoa-hang-3 (h1) |
| hr-a4-phong-compa-thap | 2 | M4 | W | easy | C3 | fin | Phòng ban nào ở nước nào lương dưới thị trường? | Xét mọi dòng của tháng `'2025-12'`. · Tính compa-ratio bình quân của từng cặp nước – phòng ban; chỉ giữ cặp có mức bình quân dưới 0,9. | S | where-thay-having |
| hr-a5-chi-phi-thoi-gian-tuyen | 2 | M4 | W | easy | A2 | mkt | Chi phí và thời gian tuyển một người năm 2025 | Xét các yêu cầu tuyển dụng có `approval_date` từ ngày 1/1/2025 tới hết ngày 31/12/2025. · Tính theo loại yêu cầu `requisition_type`: số yêu cầu, chi phí tuyển dụng bình quân, thời gian tuyển bình quân. | T | quen-can-tren |
| hr-a6-enps-theo-quy | 2 | M4 | W | medium | B1 | cus | eNPS của công ty thay đổi thế nào qua các quý? | Xét các phiếu khảo sát từ quý `'2024-Q1'` tới hết quý `'2025-Q4'`. · Tính eNPS của từng quý; công thức xem tab Nghiệp vụ. | K | trung-lap-thanh-phan-doi, quen-can-tren |
| hr-a7-dem-nguoi-theo-phong-trung | 2 | M4 | D | easy | A3 | ops | Số người từng làm theo phòng ban ra quá lớn | Truy vấn dưới đây cần đếm, theo phòng ban, số nhân viên có tên ít nhất một tháng từ `'2025-01'` tới hết `'2025-12'`; mỗi người chỉ tính một lần. · Sửa truy vấn cho đúng; giữ nguyên cột `department`, `so_nhan_vien` và … | S | dem-dong-thay-nguoi |
| hr-a8-luong-bq-tu-bq-phong | 2 | M4 | D | medium | A2 | fin | Lương bình quân theo nước lệch số liệu kế toán | Truy vấn dưới đây cần tính tiền lương tháng bình quân của mọi nhân viên có tên trong tháng `'2025-12'`, theo nước, nhưng kết quả bị lệch. · Sửa truy vấn cho đúng (định nghĩa ở tab Nghiệp vụ); giữ nguyên cột `country`, … | S | trung-binh-cua-trung-binh |
| hr-a9-ty-le-nghi-sales-quy-nam | 2 | M4 | D | hard | A2 | sal | Tỷ lệ nghỉ việc tự nguyện của đội kinh doanh bị lệch | Truy vấn dưới đây cần tính theo nước, cho phòng `'Sales'` từ tháng `'2025-07'` tới hết tháng `'2025-12'`: số người nghỉ việc tự nguyện, quân số bình quân của 6 tháng và tỷ lệ nghỉ việc tự nguyện quy năm … | S | co-nghi-gom-moi-loai, mau-so-dem-nguoi, quen-can-tren (h1) |
| hr-c3-lam-them-malaysia | 2 | case | C | basic | – | ops | Làm thêm giờ ở Malaysia có cao bất thường? | b1 Giờ làm thêm theo nước; b2 Kết luận | S | b1: quen_can_tren |
| hr-c4-nguon-tuyen-nhanh-re | 2 | case | C | easy | – | mkt | Nguồn tuyển nào vừa nhanh vừa rẻ? | b1 Mặt bằng chung năm 2025; b2 Thời gian và chi phí bình quân theo nguồn; b3 Kết luận | T | b1: quen_can_tren, binh_quan_cua_binh_quan_nguon; b2: tong_chi_phi |

## Gói 3 · M5 Joins, M6 Subqueries

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-j1-yeu-cau-theo-bac | 3 | M5 | W | easy | A3 | mkt | Bậc nào cần tuyển nhiều nhất năm 2025? | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Đếm số yêu cầu và tính chi phí tuyển dụng bình quân mỗi yêu cầu theo bậc của vị trí cần tuyển. | T, V | quen-can-tren, noi-thieu-nam |
| hr-j2-ngoai-dinh-bien-van-tuyen | 3 | M5 | W | hard | E2 | ops | Vị trí nằm ngoài định biên có còn được duyệt tuyển? | Xét các tháng dữ liệu từ tháng 1/2024 tới hết tháng 12/2025. · Tìm vị trí có nhân viên làm việc trong một năm mà không có trong kế hoạch định biên của chính năm đó. | S, P, T | noi-thieu-nam, fan-out, cot-null-sau-left-join, inner-join-mat-dong, quen-can-tren (h1) |
| hr-j3-tuyen-thay-nguoi-nghi-vi-luong | 3 | M5 | W | easy | A1 | as | Yêu cầu tuyển thay người nghỉ vì lương | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Giữ các yêu cầu tuyển thay thế cho người nghỉ việc vì lý do lương (`attrition_reason = 'Compensation'`). | T, S | noi-sai-cot |
| hr-j4-tin-tuong-quan-ly-cskh-philippines | 3 | M5 | W | basic | A2 | cus | Điểm tin tưởng quản lý ở phòng Chăm sóc khách hàng Philippines | Xét các phiếu khảo sát gắn kết quý 4/2025 (`survey_quarter = '2025-Q4'`). · Nối mỗi phiếu với dòng tháng 12/2025 của cùng nhân viên (`employee_id` bằng nhau, `snapshot_month = '2025-12'`); giữ phiếu có `country = 'Philippines'` và … | K, S | – |
| hr-j5-luong-duoi-thi-truong | 3 | M5 | W | medium | C3 | fin | Nước nào có nhiều người nhận lương dưới 80% thị trường? | Xét nhân viên có tên trong tháng 12/2025. · So tiền lương tháng của từng người với mức lương thị trường P50 cùng năm, cùng nước, cùng chức danh và cùng bậc; giữ người có lương nhỏ hơn 0,8 lần P50. | S, B | noi-thieu-nam, dung-cot-co-san |
| hr-j6-quan-ly-khong-cao-hon | 3 | M5 | W | medium | E1 | ops | Bao nhiêu quản lý không cao bậc hơn cấp dưới? | Xét nhân viên có tên trong tháng 12/2025 và quản lý trực tiếp của họ cũng có tên trong tháng 12/2025. · Giữ các cặp mà bậc của quản lý nhỏ hơn hoặc bằng bậc của nhân viên. | S | thieu-cung-thang |
| hr-j7-phieu-khao-sat-gap-ba | 3 | M5 | D | easy | A3 | cus | Số phiếu khảo sát quý 4/2025 theo phòng ban ra gấp ba | Xét mọi phiếu khảo sát quý 4/2025 (`survey_quarter = '2025-Q4'`); phòng ban lấy từ dòng nhân viên – tháng trong quý. · Sửa truy vấn khởi đầu để mỗi phiếu chỉ được đếm một lần, kể cả phiếu của người đã nghỉ trong quý. | K, S | fan-out |
| hr-j8-nghi-thang-11-ra-rong | 3 | M5 | D | basic | A1 | mkt | Người nghỉ tháng 11/2025 không khớp được yêu cầu tuyển thay thế nào | Truy vấn khởi đầu cần liệt kê nhân viên phòng `'Engineering'` nghỉ việc trong tháng 11/2025 (`snapshot_month = '2025-11'`, `attrition_this_month = 1`) đã có yêu cầu tuyển thay thế, kèm mã yêu cầu và ngày người mới bắt đầu … | S, T | noi-sai-cot |
| hr-j9-trang-thai-quan-ly-vuot-100 | 3 | M5 | D | hard | A3 | ops | Phân loại theo quản lý trực tiếp ra tỷ lệ quá 100% | Truy vấn khởi đầu cần xếp mỗi nhân viên có tên trong tháng 12/2025 vào đúng một nhóm theo tình trạng quản lý trực tiếp trong chính tháng đó: `'khong_ghi_quan_ly'`, `'quan_ly_khong_con_ten'`, `'quan_ly_con_ten'` … · Truy vấn có hai lỗi chồng nhau. Sửa cả hai để mỗi nhân viên được đếm đúng một lần. | S | inner-join-mat-dong, thieu-cung-thang, fan-out |
| hr-q1-luong-tren-bq-bac | 3 | M6 | W | easy | C3 | fin | Ai nhận lương cao hơn bình quân bậc của mình? | Xét nhân viên phòng `'Finance'` ở `'Vietnam'` có tên trong tháng 12/2025. · So tiền lương tháng của từng người với tiền lương bình quân của mọi nhân viên Việt Nam cùng bậc trong tháng 12/2025; giữ người có lương lớn hơn. | S | thieu-dieu-kien-thang |
| hr-q2-tuyen-khi-het-cho-trong | 3 | M6 | W | easy | A3 | ops | Mỗi nước duyệt bao nhiêu yêu cầu tuyển cho vị trí đủ người? | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/1/2025 tới hết 31/12/2025. · Giữ yêu cầu của vị trí có số chỗ trống bằng 0 trong kế hoạch định biên năm 2025 (`plan_period = 2025`, `vacancy_count = 0`). | T, P | so-ke-hoach-khac-nam, quen-can-tren |
| hr-q3-gan-ket-cao-nhat-moi-phong | 3 | M6 | W | medium | C1 | cus | Điểm gắn kết cao nhất từng phòng ban mỗi nước | Xét nhân viên có tên trong tháng 12/2025, dùng điểm gắn kết hằng tháng của `employee_monthly_snapshot`; bỏ người có điểm trống. · Lấy mọi nhân viên có điểm bằng điểm cao nhất của nhóm cùng nước, cùng phòng ban trong tháng; nhiều người cùng … | S | khong-tuong-quan, hoa-diem |
| hr-q4-khao-sat-khong-bao-truoc | 3 | M6 | W | hard | E2 | as | Nước nào có nhiều người nghỉ mà khảo sát không báo trước? | Xét người nghỉ việc tự nguyện có tháng nghỉ từ tháng 1/2025 tới hết tháng 12/2025. · Tính theo nước số người nghỉ tự nguyện, số người khảo sát không báo trước và tỷ lệ của nhóm này trên số người nghỉ tự nguyện (định nghĩa ở tab Nghiệp vụ). | S, K | quy-lon-nhat-ca-bang, so-chuoi-quy-voi-thang, loc-truoc-khi-dem, dinh-nghia-nguoi-nghi |
| hr-q5-sales-lam-them-tren-bq | 3 | M6 | W | medium | C3 | sal | Bao nhiêu nhân viên kinh doanh làm thêm trên mức bình quân? | Xét các dòng của phòng `'Sales'` từ tháng 1/2025 tới hết tháng 12/2025. · Tính tổng giờ làm thêm cả năm của từng nhân viên (người làm chưa đủ 12 tháng vẫn tính tổng các tháng có tên). | S | sai-hat-binh-quan |
| hr-q6-yeu-cau-thang-12-tuyen-lau | 3 | M6 | W | basic | C3 | mkt | Yêu cầu tuyển nào của tháng 12/2025 lâu hơn mức bình quân? | Xét các yêu cầu tuyển dụng có ngày duyệt từ 1/12/2025 tới hết 31/12/2025. · Giữ yêu cầu có `time_to_fill_days` lớn hơn thời gian tuyển bình quân của mọi yêu cầu trong bảng `recruiting_pipeline` (không lọc ngày khi tính bình quân). | T | – |
| hr-q7-chua-quan-ly-ai-ra-rong | 3 | M6 | D | easy | A1 | ops | Danh sách người bậc cao không quản lý ai ra rỗng | Xét nhân viên có tên trong tháng 12/2025, bậc từ 5 trở lên (`job_level >= 5`). · Sửa truy vấn khởi đầu để đếm đúng người không là quản lý trực tiếp của ai trong tháng 12/2025. | S | not-in-null |
| hr-q8-tren-bq-phong-sai-nam | 3 | M6 | D | basic | C3 | fin | Danh sách lương trên bình quân phòng Tài chính Singapore bị thừa người | Truy vấn khởi đầu cần liệt kê nhân viên phòng `'Finance'` ở `'Singapore'` có tên trong tháng 12/2025 (`snapshot_month = '2025-12'`) nhận tiền lương tháng lớn hơn tiền lương bình quân của phòng `'Finance'` ở … | S | sai-gia-tri-loc |
| hr-q9-ly-do-pho-bien-hai-loi | 3 | M6 | D | hard | C1 | as | Bảng lý do nghỉ việc phổ biến nhất chỉ có một nước | Truy vấn khởi đầu cần tìm lý do có nhiều người nghỉ việc tự nguyện nhất ở từng nước, xét tháng nghỉ từ tháng 1/2025 tới hết tháng 12/2025; nhiều lý do bằng nhau thì lấy đủ. · Truy vấn có hai lỗi chồng nhau. Sửa cả hai; giữ nguyên cột … | S | thieu-tuong-quan, sai-dinh-nghia-nguoi-nghi, hoa-ly-do |
| hr-c5-tuyen-thay-the-kip-khong | 3 | case | C | easy | – | as | Chỗ của người nghỉ có được tuyển người thay kịp không? | b1 Người nghỉ năm 2025 theo loại; b2 Tuyển thay thế và thời gian chờ theo loại nghỉ; b3 Kết luận | S, T | b2: inner_join |
| hr-c6-luong-thap-va-nghi-viec | 3 | case | C | medium | – | fin | Nhóm lương thấp hơn thị trường có nghỉ việc nhiều hơn không? | b1 Quy mô ba nhóm compa-ratio năm 2025; b2 Tỷ lệ nghỉ việc tự nguyện theo nhóm; b3 Tách theo nước; b4 Kết luận | S | b2: mau_so_la_so_dong |

## Gói 4 · M7 CTE & Set Operations, M8 Window Functions

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-t1-nghi-viec-yoy-theo-phong | 4 | M7 | W | medium | B2 | as | Nghỉ việc theo phòng ban năm 2025 so với 2024 | Xét các tháng từ `'2024-01'` tới `'2025-12'`; người nghỉ việc gồm mọi loại, kể cả nghỉ hưu. · Tính tỷ lệ nghỉ việc năm 2024 và năm 2025 của từng phòng ban (cách tính ở tab Nghiệp vụ); quân số bình quân của năm bằng số … | S | chenh-lech-tuong-doi, sai-mau-so |
| hr-t2-vi-tri-moi-ke-hoach-2025 | 4 | M7 | W | basic | E2 | ops | Kế hoạch định biên 2025 có thêm vị trí nào? | Lấy các vị trí có trong kế hoạch năm 2025 (`plan_period` = 2025) mà không có trong kế hoạch năm 2024 (`plan_period` = 2024). | P | dao-hai-ve |
| hr-t3-pheu-tuyen-dung | 4 | M7 | W | easy | D1 | mkt | Yêu cầu tuyển dụng năm 2025 dừng ở khâu nào? | Xét yêu cầu tuyển dụng có ngày duyệt trong năm 2025 (từ `'2025-01-01'` tới hết `'2025-12-31'`). · Đếm ba bước của phễu trên cùng tập yêu cầu đó: bước 1 `'duyet'` gồm mọi yêu cầu; bước 2 `'nhan_loi'` gồm yêu cầu có ngày nhận lời trước … | T | ngay-sau-cua-so |
| hr-t4-so-cap-duoi-truc-tiep | 4 | M7 | W | basic | A3 | ops | Quản lý thường phụ trách bao nhiêu cấp dưới trực tiếp? | Xét tháng 12/2025 (`snapshot_month` = `'2025-12'`), tính mọi nhân viên có tên trong tháng, gồm cả người nghỉ trong tháng. Bỏ dòng có `manager_id` trống. · Đếm số cấp dưới trực tiếp của từng quản lý (số dòng có … | S | giu-quan-ly-trong |
| hr-t5-chuoi-quan-ly-lap | 4 | M7 | D | hard | E3 | ops | Tuyến báo cáo của E00041 ra cả trăm dòng lặp lại | Truy vấn dưới đây cần liệt kê tuyến báo cáo tháng 12/2025 đi từ nhân viên `E00041` lên các cấp quản lý, mỗi dòng một người, nhưng kết quả có rất nhiều dòng lặp lại. · Truy vấn có hai lỗi chồng nhau … | S | chu-trinh, neo-thieu-thang, chi-chan-do-sau |
| hr-t6-ty-trong-quy-luong | 4 | M7 | W | easy | C2 | fin | Mỗi phòng ban chiếm bao nhiêu phần quỹ lương? | Xét tháng 12/2025 (`'2025-12'`); quỹ lương tính trên mọi nhân viên có tên trong tháng, gồm cả người nghỉ trong tháng. · Tính quỹ lương của từng phòng ban, rồi tỷ trọng bằng quỹ lương của phòng chia tổng quỹ lương toàn … | S | mau-so-sai-pham-vi |
| hr-t7-cohort-tuyen-moi | 4 | M7 | W | hard | D2 | cus | Nhân viên mới còn lại bao nhiêu sau ba, sáu tháng? | Xét nhân viên mới (định nghĩa ở tab Nghiệp vụ), nhóm theo quý vào làm (dạng `'2024-Q2'`). · Một người còn làm việc sau k tháng nếu ở tháng vào làm cộng thêm k tháng, người đó có dòng và không nghỉ việc trong tháng đó … | S | cohort-chua-du-quan-sat, dau-cua-so-du-lieu, co-dong-la-con-lam |
| hr-t8-union-mat-dong | 4 | M7 | D | easy | A3 | mkt | Tổng yêu cầu tuyển hai năm của vài nguồn bị thiếu | Truy vấn dưới đây đếm số yêu cầu tuyển dụng duyệt trong năm 2024 và trong năm 2025 theo nguồn tuyển dụng, ghép hai kết quả rồi cộng theo nguồn, nhưng có nguồn bị thiếu số. · Sửa để `tong_yeu_cau` bằng số … | T | union-mat-dong |
| hr-t9-doi-soat-except | 4 | M7 | D | medium | E2 | as | Danh sách chưa có người thay vẫn đủ mọi người nghỉ | Truy vấn dưới đây lấy người nghỉ việc tự nguyện và người bị chấm dứt hợp đồng năm 2025, rồi trừ đi người đã có người thay bắt đầu làm việc không muộn hơn ngày 31/12/2025, nhưng phép trừ không bỏ được ai. · Sửa để phép … | S, T | hai-ve-khac-nghia, not-in-gap-null |
| hr-f1-top3-lam-them-moi-nuoc | 4 | M8 | W | medium | C1 | ops | Mỗi nước ai làm thêm giờ nhiều nhất năm 2025? | Cộng giờ làm thêm từ tháng 1/2025 tới tháng 12/2025 của từng nhân viên. · Xếp hạng nhân viên trong từng nước theo tổng giờ giảm dần; bằng nhau thì `employee_id` nhỏ hơn đứng trước. Giữ đúng 3 người mỗi nước. | S | trung-hang, thieu-partition-by |
| hr-f2-luy-ke-chi-phi-tuyen-dung | 4 | M8 | W | easy | B3 | mkt | Chi phí tuyển dụng luỹ kế qua các tháng năm 2025 | Xét yêu cầu tuyển dụng có ngày duyệt trong năm 2025 (từ `'2025-01-01'` tới hết `'2025-12-31'`); chi phí của một yêu cầu tính vào tháng duyệt. · Tính chi phí tuyển dụng của từng tháng, và chi phí luỹ kế từ tháng 1 … | T | quen-can-tren |
| hr-f3-de-bat-theo-thang | 4 | M8 | W | easy | B2 | fin | Mỗi tháng năm 2025 bao nhiêu người được đề bạt? | Một nhân viên được đề bạt trong tháng khi `job_level` của tháng đó cao hơn `job_level` ở tháng liền trước của chính người đó. · Xét tháng đề bạt từ `'2025-01'` tới `'2025-12'`; tháng 1/2025 so với tháng 12/2024. | S | loc-truoc-khi-lag |
| hr-f4-gan-ket-giam-truoc-nghi | 4 | M8 | W | hard | D3 | as | Ai có điểm gắn kết giảm liền trước khi nghỉ? | Xét người nghỉ việc tự nguyện có tháng nghỉ trong năm 2025; dùng điểm gắn kết hằng tháng của ảnh chụp nhân sự, trên mọi tháng có dữ liệu của người đó. · Một tháng là tháng giảm khi điểm gắn kết thấp hơn tháng liền … | S | null-pha-chuoi, dem-khong-lien-tiep |
| hr-f5-nghi-viec-sales-binh-quan-truot | 4 | M8 | W | easy | B3 | sal | Bình quân ba tháng số người nghỉ của đội kinh doanh | Xét nhân viên phòng `'Sales'`; chỉ tính người nghỉ việc tự nguyện (`attrition_type` = `'Voluntary'`). · Với mỗi tháng từ `'2025-01'` tới `'2025-12'`, tính `so_nghi` và `bq_3_thang` là bình quân của tháng đó cùng hai tháng liền trước … | S | loc-nam-truoc-cua-so |
| hr-f6-thu-tu-yeu-cau-singapore | 4 | M8 | W | basic | A1 | mkt | Đánh số yêu cầu tuyển dụng năm 2025 của từng phòng ở Singapore | Xét yêu cầu tuyển dụng ở `'Singapore'` có ngày duyệt trong năm 2025 (từ `'2025-01-01'` tới hết `'2025-12-31'`). · Đánh số thứ tự các yêu cầu trong từng phòng ban, bắt đầu từ 1, theo `approval_date` tăng dần; … | T | sap-theo-ma |
| hr-f7-top3-lam-them-rank | 4 | M8 | D | medium | C1 | ops | Bảng làm thêm nhiều nhất mỗi phòng ban bị lặp tên | Truy vấn dưới đây cần xếp hạng nhân viên trong từng phòng ban theo tổng giờ làm thêm từ tháng 1/2025 tới tháng 12/2025 và giữ 3 người đầu mỗi phòng, nhưng đang xếp hạng trên từng dòng nhân viên – tháng. · Sửa để mỗi … | S | xep-hang-tren-dong-chi-tiet |
| hr-f8-tang-luong-lag-sai | 4 | M8 | D | hard | B2 | fin | Danh sách tăng lương 2025 lẫn người không được tăng | Truy vấn dưới đây liệt kê các lần tiền lương tháng của nhân viên phòng Kỹ thuật (`'Engineering'`) ở `'Vietnam'` tăng từ 8% trở lên so với tháng liền trước của chính người đó, xét tháng tăng từ `'2025-01'` tới … | S | thieu-partition-by, loc-truoc-khi-lag |
| hr-f9-luy-ke-chay-nguoc | 4 | M8 | D | basic | B3 | as | Luỹ kế nghỉ tự nguyện tháng 1/2025 lại bằng cả năm | Truy vấn dưới đây đếm người nghỉ việc tự nguyện từng tháng từ `'2025-01'` tới `'2025-12'` và tính luỹ kế từ tháng 1, nhưng tháng 1 ra bằng tổng cả năm. · Sửa để `luy_ke` của mỗi tháng bằng tổng số … | S | sap-nguoc-trong-over |
| hr-c7-gan-ket-bao-truoc | 4 | case | C | medium | – | cus | Điểm gắn kết có báo trước việc nghỉ việc? | b1 Người nghỉ và người ở lại khác nhau bao nhiêu?; b2 Điểm gắn kết đổi ra sao khi gần tới tháng nghỉ?; b3 Khảo sát quý 2 đo cùng lúc nói gì?; b4 Kết luận | S, K | b1: gom_ca_thang_nghi; b2: tinh_ca_nghi_huu; b3: noi_theo_nam |
| hr-c8-diem-nong-vn-engineering | 4 | case | C | hard | – | as | Vì sao phòng Kỹ thuật ở Việt Nam nghỉ việc nhiều? | b1 Nhóm nào mất nhiều người nhất?; b2 Giờ làm thêm ở Việt Nam theo phòng ban; b3 Người nghỉ có được trả thấp hơn người ở lại?; b4 Năng lực quản lý ở Việt Nam theo phòng ban; b5 Kết luận | S | b1: dung_rank; b3: o_lai_gom_moi_thang; b4: mau_so_gom_o_trong |

## Gói 5 · M9 Data Quality, M10 Query Performance

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| hr-k1-de-bat-vuot-tham-nien | 5 | M9 | W | basic | E1 | cus | Bao nhiêu người có số tháng từ lần đề bạt vượt thâm niên? | Xét mọi dòng của tháng 12/2025 (`snapshot_month` là `'2025-12'`), kể cả người nghỉ việc trong tháng. · Đếm số nhân viên có số tháng kể từ lần đề bạt gần nhất (`months_since_promotion`) lớn hơn thâm niên (`tenure_months`). | S | lon-hon-hoac-bang |
| hr-k2-loai-ly-do-nghi | 5 | M9 | W | easy | E1 | as | Lý do nghỉ có nhất quán với loại nghỉ? | Xét các lượt nghỉ việc (mọi loại, kể cả nghỉ hưu) từ tháng 1/2024 tới hết tháng 12/2025. · Coi một lượt nghỉ là hợp quy tắc khi: nghỉ hưu đi với lý do `'Retirement'` và người nghỉ từ 60 tuổi trở lên; không tự nguyện đi … | S | quen-loc-thang-nghi |
| hr-k3-gan-ket-lech-so-cong-ty | 5 | M9 | W | hard | E2 | cus | Phòng nào có điểm gắn kết tháng lệch khảo sát hơn mức chung? | Xét các tháng từ tháng 1/2024 tới hết tháng 12/2025, chỉ những dòng nhân viên – tháng có điểm gắn kết hằng tháng. · So điểm gắn kết hằng tháng của mỗi dòng với điểm gắn kết trong phiếu khảo sát của chính nhân viên đó ở quý chứa tháng đó … | S, K | noi-theo-nam, null-thanh-0, quen-can-tren (h1), binh-quan-cac-ty-le |
| hr-k4-bao-cao-vong | 5 | M9 | W | medium | E1 | ops | Cặp nhân viên nào là quản lý trực tiếp của nhau? | Xét sơ đồ tổ chức tháng 12/2025. · Tìm các cặp nhân viên là quản lý trực tiếp của nhau trong tháng đó. | S | dem-doi-cap, quen-cung-thang |
| hr-k5-ty-le-thieu-du-lieu | 5 | M9 | W | easy | E1 | ops | Chỉ số nào thiếu dữ liệu nhiều nhất năm 2025? | Xét mọi dòng nhân viên – tháng từ tháng 1/2025 tới hết tháng 12/2025. · Đếm số dòng trống (NULL) của sáu cột `absence_days`, `engagement_score`, `training_hours_6m`, `manager_effectiveness_score`, `potential_rating`, … | S | count-cot-dem-null |
| hr-k6-compa-tu-tinh | 5 | M9 | W | medium | E2 | fin | Compa-ratio trong hệ thống có khớp mức lương thị trường? | Xét mọi dòng nhân viên – tháng của năm 2025 thuộc nhóm chức danh `job_family = 'Software Engineer'`. · Tính lại compa-ratio (tỷ số lương trên mức thị trường trung vị) bằng cách chia trực tiếp tiền lương tháng cho mức lương thị trường P50 cùng năm, nước, chức danh, bậc; … | S, B | noi-thieu-nam |
| hr-k7-doi-bac-thua-nguoi | 5 | M9 | D | basic | E1 | fin | Danh sách người đổi bậc năm 2025 có cả người giữ nguyên bậc | Truy vấn dưới đây cần liệt kê nhân viên có từ hai bậc (`job_level`) khác nhau trở lên trong các tháng từ `'2025-01'` tới `'2025-12'`, nhưng danh sách có cả người giữ nguyên một bậc cả năm. · Sửa cho đúng; giữ cột … | S | sai-toan-tu |
| hr-k8-thieu-quan-ly-ra-0 | 5 | M9 | D | easy | E1 | ops | Số nhân viên thiếu quản lý ra 0 ở mọi phòng | Truy vấn dưới đây đếm, cho từng phòng ban, số nhân viên có tên trong tháng 12/2025 và số người chưa có quản lý trực tiếp, nhưng cột thứ hai luôn ra 0. · Sửa cho đúng; giữ cột `department`, `so_nhan_vien`, … | S | null-va-chuoi-rong |
| hr-k9-backfill-lech-thang | 5 | M9 | D | hard | E2 | mkt | Đối soát tuyển thay thế báo lệch bậc bất thường | Truy vấn dưới đây đối soát, theo nước, các yêu cầu tuyển thay thế được duyệt trong năm 2025: số yêu cầu và số yêu cầu có bậc vị trí tuyển khác bậc của người đã nghỉ tại tháng nghỉ. · Truy vấn có hai lỗi chồng nhau. Sửa … | T, V, S | fan-out, can-tren-dau-thang |
| hr-p1-nghi-ba-loai-mot-lan-quet | 5 | M10 | O | easy | A3 | as | Người nghỉ theo loại và nước chỉ một lần quét | Giữ nguyên kết quả: mỗi nước một dòng, gồm `country`, `tu_nguyen`, `khong_tu_nguyen`, `nghi_huu` là số người nghỉ việc theo từng loại trong năm 2025. · Sắp theo `country`. | S | truy-van-con-quet-lai |
| hr-p2-chi-so-thang-mot-lan-quet | 5 | M10 | O | basic | A2 | ops | Ba chỉ số tháng 12/2025 với một lần quét | Giữ nguyên kết quả: một dòng gồm `quan_so_cuoi_thang`, `so_nguoi_nghi`, `tong_gio_lam_them` của tháng 12/2025. | S | truy-van-con-quet-lai |
| hr-p3-loc-ngay-dung-chi-muc | 5 | M10 | O | easy | A3 | mkt | Chi phí tuyển theo nguồn quý 4/2025, lọc ngày dùng được chỉ mục | Giữ nguyên kết quả: mỗi nguồn tuyển dụng một dòng, tính trên các yêu cầu tuyển dụng có ngày duyệt (`approval_date`) từ ngày 1/10/2025 tới hết ngày 31/12/2025, gồm `recruitment_source`, `so_yeu_cau`, `chi_phi_bq_usd` … | T | ham-boc-cot, quen-can-tren (h1) |
| hr-p4-yeu-cau-ngoai-ke-hoach | 5 | M10 | O | medium | E2 | mkt | Yêu cầu tuyển ngoài kế hoạch chỉ một lần quét | Giữ nguyên kết quả: các yêu cầu tuyển dụng có `attrition_month` từ `'2024-01'` tới `'2025-12'` mà vị trí không có trong kế hoạch định biên của năm của `attrition_month`. · Trả về `requisition_id`, `position_id`, … | T, P | union-all-lap, quen-can-tren |
| hr-p5-tang-luong-khong-tu-noi | 5 | M10 | O | hard | B2 | fin | Mức tăng lương so với tháng trước không tự nối bảng | Giữ nguyên kết quả: mỗi tháng năm 2025 một dòng, gồm `thang`, `so_nguoi_tang_luong` (số nhân viên có tiền lương tháng cao hơn tháng liền trước của chính họ), `muc_tang_bq_pct` (mức tăng bình quân của những người đó, … | S | tu-noi-bang, loc-truoc-lag |
| hr-p6-y-dinh-o-lai-mot-lan-quet | 5 | M10 | O | easy | B1 | cus | Ý định ở lại theo quý năm 2025 gộp vào một truy vấn | Giữ nguyên kết quả: mỗi quý khảo sát từ `'2025-Q1'` tới `'2025-Q4'` một dòng, gồm `quy`, `so_phieu`, `y_dinh_o_lai_bq`, `ty_le_diem_1_pct` … | K | union-all-lap, quen-can-tren (h1) |
| hr-p7-dem-theo-thang-chi-muc | 5 | M10 | W | medium | A2 | ops | Quân số cuối mỗi tháng của quý 4/2025 | Xét các tháng từ tháng 10/2025 tới hết tháng 12/2025. · Tính quân số cuối tháng như định nghĩa ở tab Nghiệp vụ. | S | loc-thang-thieu-nam |
| hr-p8-chuoi-thang-sai | 5 | M10 | D | basic | A1 | cus | Lọc sáu tháng cuối năm 2025 ra 0 dòng | Truy vấn dưới đây liệt kê nhân viên có tiềm năng `'High'` và điểm gắn kết tháng dưới 30 trong các tháng 7 tới 12/2025, nhưng ra 0 dòng. · Sửa cho đúng; giữ cột `employee_id`, `so_thang` (số tháng thoả điều kiện), … | S | chuoi-thieu-so-0 |
| hr-p9-pareto-quan-ly | 5 | M10 | W | hard | C2 | as | Mấy quản lý chiếm nửa số người nghỉ tự nguyện? | Xét người nghỉ việc tự nguyện từ tháng 1/2024 tới hết tháng 12/2025 và có quản lý trực tiếp, lấy quản lý ghi ở tháng nghỉ. · Xếp quản lý theo số người nghỉ giảm dần; bằng nhau thì `manager_id` nhỏ hơn trước. Một quản … | S | khung-range-mac-dinh, null-quan-ly, hoa-hang |
| hr-c9-chi-phi-tuyen-thay-the | 5 | case | C | hard | C3 | mkt | Nước nào tốn kém nhất khi thay người nghỉ việc? | b1 Năm 2025 mỗi nước có bao nhiêu người nghỉ việc?; b2 Tuyển thay thế tốn bao nhiêu ở mỗi nước?; b3 Thay một người mất bao lâu?; b4 Chi phí tuyển bằng bao nhiêu tháng lương thị trường?; b5 Kết luận | S, T, V, B | b1: chi_dem_tu_nguyen; b2: tinh_ca_tuyen_moi; b3: tinh_toi_ngay_di_lam; b4: noi_thieu_bac |
| hr-c10-tang-luong-nhom-compa-thap | 5 | case | C | hard | C3 | fin | Có nên nâng lương nhóm compa-ratio thấp ở Việt Nam? | b1 Nhóm compa-ratio dưới 0,9 lớn cỡ nào?; b2 Nhóm này nghỉ tự nguyện nhiều hơn bao nhiêu?; b3 Nâng lương nhóm này lên 0,95 lần mức P50 tốn bao nhiêu?; b4 Chi phí tuyển thay thế tránh được là bao nhiêu?; b5 Kết luận | S, B, T | b1: tinh_ca_nguoi_nghi; b2: mau_so_dem_nguoi; b3: noi_thieu_nam; b4: tinh_ca_tuyen_moi |

## Thống kê (sinh lại tự động từ cau-hoi.tex, 100 câu)

### Module × cấp

| Tiền tố | Cơ bản | Dễ | Trung bình | Khó |
|---|---:|---:|---:|---:|
| `a` | 2 | 3 | 2 | 2 |
| `c` | 3 | 2 | 2 | 3 |
| `f` | 2 | 3 | 2 | 2 |
| `j` | 2 | 3 | 2 | 2 |
| `k` | 2 | 3 | 2 | 2 |
| `n` | 2 | 3 | 2 | 2 |
| `p` | 2 | 3 | 2 | 2 |
| `q` | 2 | 3 | 2 | 2 |
| `r` | 2 | 3 | 2 | 2 |
| `s` | 2 | 3 | 2 | 2 |
| `t` | 2 | 3 | 2 | 2 |

### Hình thức × cấp

| Hình thức | Cơ bản | Dễ | Trung bình | Khó | Cộng |
|---|---:|---:|---:|---:|---:|
| Viết | 12 | 21 | 13 | 10 | 56 |
| Sửa lỗi | 7 | 6 | 6 | 9 | 28 |
| Tối ưu | 1 | 3 | 1 | 1 | 6 |
| Case | 3 | 2 | 2 | 3 | 10 |

### Hình thức × mảng

| Hình thức | Hậu mãi | Khách hàng | Tài chính | Marketing | Vận hành | Bán hàng |
|---|---:|---:|---:|---:|---:|---:|
| Viết | 9 | 11 | 8 | 10 | 14 | 4 |
| Sửa lỗi | 4 | 4 | 6 | 4 | 8 | 2 |
| Tối ưu | 1 | 1 | 1 | 2 | 1 | 0 |
| Case | 3 | 2 | 2 | 2 | 1 | 0 |

### Theo gói

| Gói | Cơ bản | Dễ | Trung bình | Khó | Cộng |
|---|---:|---:|---:|---:|---:|
| goi-1 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | A | B | A | 7 | 1 | B | C | A | 9 | 0 | > | 20 |
| goi-2 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | A | B | A | 7 | 1 | B | C | A | 9 | 0 | > | 20 |
| goi-3 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | A | B | A | 7 | 1 | B | C | A | 9 | 0 | > | 20 |
| goi-4 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | A | B | A | 7 | 1 | B | C | A | 9 | 0 | > | 20 |
| goi-5 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | A | B | A | 7 | 1 | B | C | A | 9 | 0 | > | 20 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | sales | marketing | customer | operations | finance | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 | 2 | 4 | 6 | 3 | · | 2 | 17 |
| A2 | 1 | 1 | 2 | 4 | 2 | 1 | 11 |
| A3 | 1 | 5 | 1 | 4 | 2 | 2 | 15 |
| A4 | · | · | · | · | · | · | 0 |
| B1 | · | 1 | 2 | 1 | · | · | 4 |
| B2 | · | · | · | 1 | 3 | 1 | 5 |
| B3 | 1 | 1 | · | · | · | 1 | 3 |
| B4 | · | · | · | · | · | · | 0 |
| C1 | · | · | 1 | 2 | · | 2 | 5 |
| C2 | · | · | · | · | 1 | 1 | 2 |
| C3 | 1 | 1 | · | · | 4 | · | 6 |
| C4 | · | · | · | 1 | · | · | 1 |
| D1 | · | 1 | · | · | · | · | 1 |
| D2 | · | · | 1 | · | · | · | 1 |
| D3 | · | · | · | · | · | 1 | 1 |
| E1 | · | · | 2 | 4 | 1 | 1 | 8 |
| E2 | · | 2 | 1 | 2 | 2 | 2 | 9 |
| E3 | · | · | · | 1 | · | · | 1 |
| **Cộng** | 6 | 16 | 16 | 23 | 15 | 14 | 90 |

Dạng có câu: 16/18; chưa có: A4, B4; chỉ 1 câu: C4, D1, D2, D3, E3.

Mảng trên cả 100 câu (gồm case): sales 6, marketing 18, customer 18, operations 24, finance 17, after_sales 17.

### Ô trùng (dạng × mảng × cấp × hình thức)

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: không có.

Ô trùng **giữa các gói** (5 ô, rà lại từ `cau-hoi.tex` lúc sửa theo KIEM-V4, 11/11/2026; cho phép, ghi để tham khảo; mỗi cặp khác chủ đề):
- A1 · customer · easy · write: `hr-r5-tiem-nang-cao-chua-de-bat`, `hr-s5-y-dinh-o-lai-thap-2025`
- A1 · marketing · basic · write: `hr-s2-nhan-viec-thu-hai`, `hr-f6-thu-tu-yeu-cau-singapore`
- A3 · marketing · easy · write: `hr-s4-cho-nhan-viec`, `hr-j1-yeu-cau-theo-bac`
- C3 · finance · easy · write: `hr-a4-phong-compa-thap`, `hr-q1-luong-tren-bq-bac`
- E1 · operations · medium · write: `hr-j6-quan-ly-khong-cao-hon`, `hr-k4-bao-cao-vong`

Đã gỡ ở KIEM-V4: A1 · after_sales · basic · debug (`hr-r7-danh-sach-nghi-huu-rong`, `hr-j8-nghi-thang-11-ra-rong`) trùng cả ô lẫn chủ đề "danh sách người nghỉ ra rỗng", nên `hr-j8` đổi mảng sang marketing (tuyển thay thế), tiêu đề bỏ khuôn "ra rỗng". Ô trùng trong cùng một gói (kể cả case): không có.

### Chênh lệch so với bản đồ bản 1 (phân bổ gốc)

So 100 dòng của bản 1 với 100 câu thật: 0 mã khác, 5 câu đổi hình thức/cấp/dạng/mảng, 73 câu đổi tiêu đề (không liệt kê).

Câu đổi khoá so với bản 1:

- `hr-s8-quy-4-thieu-thang-12`: cấp easy → basic
- `hr-a4-phong-compa-thap`: cấp medium → easy
- `hr-q2-tuyen-khi-het-cho-trong`: dạng A1 → A3
- `hr-p2-chi-so-thang-mot-lan-quet`: cấp medium → basic
- `hr-p8-chuoi-thang-sai`: cấp medium → basic
- v3 (10/11/2026, QUYET-DINH-126): `hr-r8-yeu-cau-thang-3-thieu-ngay` easy → basic; `hr-a3-ty-le-nghi-viec-theo-nuoc` medium → easy; `hr-k2-loai-ly-do-nghi`, `hr-k5-ty-le-thieu-du-lieu`, `hr-k8-thieu-quan-ly-ra-0`, `hr-p1-nghi-ba-loai-mot-lan-quet` medium → easy; `hr-k4-bao-cao-vong`, `hr-k6-compa-tu-tinh` hard → medium. Đổi mã: `hr-s5-y-dinh-o-lai-thap-q3` → `hr-s5-y-dinh-o-lai-thap-2025`, `hr-s7-dem-nghi-theo-nam-null` → `hr-s7-dem-nghi-theo-nam-thieu-2025`. Đổi tiêu đề r1, r3 (≤ 10 tiếng), q3 (bỏ `employee_id`).
- Chuẩn hoá (10/11/2026, BRIEF-CHUAN-HOA, ghi ở `ho-so/CHUAN-HOA.md`): `hr-a9-ty-le-thang-cong-tac-sales` medium → easy (sửa lỗi một chỗ dễ thấy, HD mục 6); tiêu đề `hr-q2-tuyen-khi-het-cho-trong` rút còn 13 tiếng.
- v4 gói 5 (11/11/2026, BRIEF-CAP-DO-MODULE, ghi ở `ho-so/goi-5/DA-SUA.md`): M9, M10 mỗi module đủ 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Viết lại 5 câu, đổi mã: `hr-k1-co-lech-diem-danh-gia` (medium) → `hr-k1-de-bat-vuot-tham-nien` (basic); `hr-k3-gan-ket-hai-nguon` (medium) → `hr-k3-gan-ket-lech-so-cong-ty` (hard); `hr-k7-tong-theo-bac-lech` (debug medium, E2 as) → `hr-k7-doi-bac-thua-nguoi` (debug basic, E1 fin); `hr-p3-top3-khong-tuong-quan` (hard, C1 ops) → `hr-p3-loc-ngay-dung-chi-muc` (easy, A3 mkt); `hr-p6-enps-noi-mot-thang` (hard, A3 cus) → `hr-p6-y-dinh-o-lai-mot-lan-quet` (easy, B1 cus). Chỉ sửa dòng của gói 5 (bảng gói 5, dòng M9, M10, dòng gói 5); các bảng tổng toàn bộ (hình thức × cấp, dạng × mảng, dòng Bản 1–4) chưa cộng lại vì agent các gói khác đang sửa song song. Gói 5 đổi: basic +2, easy +2, medium −3, hard −1; write basic +1, medium −2, hard +1; debug basic +1, medium −1; optimize easy +2, hard −2; dạng × mảng: E2·as −1, E1·fin +1, C1·ops −1, A3·mkt +1, A3·cus −1, B1·cus +1. Không trùng ô trong gói; ô mới không trùng gói khác.
- v4 gói 1 (11/11/2026, BRIEF-CAP-DO-MODULE, ghi ở `ho-so/goi-1/DA-SUA.md`): M1, M2 mỗi module đủ 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (trước: M1 5/4/0/0, M2 3/6/0/0). Viết lại 8 câu, đổi mã: `hr-r2-nghi-tu-nguyen-thang-9` (basic, A1 as) → `hr-r2-nghi-tu-nguyen-can-giu-quy-3` (medium, A1 cus); `hr-r3-tuyen-qua-gioi-thieu` (basic) → `hr-r3-yeu-cau-tuyen-cham-quy-4` (hard); `hr-r8-yeu-cau-thang-3-thieu-ngay` (debug basic, A1 mkt) → `hr-r8-phu-cap-di-lai-sales-thieu-nguoi` (debug hard, A1 sal); `hr-r9-loc-tp-hcm-ra-0` (debug easy) → `hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu` (debug medium); `hr-n4-ty-le-nghi-tu-nguyen-2024` (easy) → `hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4` (medium); `hr-n6-nhan-loai-yeu-cau` (easy, A3 mkt) → `hr-n6-phan-loai-thieu-nguoi-2025` (hard, C4 ops); `hr-n7-gio-dao-tao-thap` (debug basic) → `hr-n7-ty-le-chua-dao-tao-cao` (debug medium); `hr-n9-tien-lam-them-lech` (debug easy) → `hr-n9-tien-lam-them-quy-4-lech` (debug hard). Chỉ sửa dòng của gói 1 (bảng gói 1, dòng M1, M2, dòng gói 1, hai dòng ô trùng có mã gói 1); bảng tổng toàn bộ chưa cộng lại vì agent các gói khác đang sửa song song. Gói 1 đổi: basic −4, easy −4, medium +4, hard +4; write basic −2, easy −2, medium +2, hard +2; debug basic −2, easy −2, medium +2, hard +2; dạng × mảng: A1·as −1, A1·cus +1, A3·mkt −1, C4·ops +1, A1·mkt −1, A1·sal +1. Không trùng ô trong gói; ô mới không trùng gói khác (r2 đổi sang mảng customer vì A1·as·medium·write đã có `hr-q4`).
- v4 gói 2 (11/11/2026, BRIEF-CAP-DO-MODULE, ghi ở `ho-so/goi-2/DA-SUA.md`): M3 từ 4 basic · 5 easy, M4 từ 7 easy · 2 medium thành mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Viết lại 6 câu, đổi mã: `hr-s1-nghi-viec-theo-nam` (basic, A3 as) → `hr-s1-lam-them-quy-so-cung-ky` (medium, B2 ops); `hr-s3-yeu-cau-theo-quy` (easy, B1 mkt) → `hr-s3-cho-hoi-nhap-thu-hai` (hard, A3 mkt); `hr-s7-dem-nghi-theo-nam-thieu-2025` (debug basic, A3 as) → `hr-s7-quy-luong-nam-lech-ke-toan` (debug medium, E2 fin); `hr-s9-quan-so-sai-thu-tu` (debug easy) → `hr-s9-quan-so-cuoi-thang-lech` (debug hard, B1 ops); `hr-a3-ty-le-nghi-viec-theo-nuoc` (easy, A3 as) → `hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu` (hard, C1 as); `hr-a9-ty-le-thang-cong-tac-sales` (debug easy) → `hr-a9-ty-le-nghi-sales-quy-nam` (debug hard, A2 sal). Hạ 2 câu, giữ mã: `hr-a1-nghi-theo-ly-do-2025`, `hr-a2-luong-theo-bac` easy → basic. Chỉ sửa dòng của gói 2 (bảng gói 2, dòng M3, M4, dòng gói 2); các bảng tổng toàn bộ chưa cộng lại vì các gói khác đang sửa song song. Gói 2 đổi: basic 0, easy −6, medium +2, hard +4; write basic +1, easy −4, medium +1, hard +2; debug basic −1, easy −2, medium +1, hard +2; dạng × mảng: A3·as −3, B1·mkt −1, B2·ops +1, A3·mkt +1, E2·fin +1, C1·as +1. Không trùng ô trong gói; 8 ô mới (B2·ops·medium·W, A3·mkt·hard·W, E2·fin·medium·D, B1·ops·hard·D, A3·as·basic·W, A3·fin·basic·W, C1·as·hard·W, A2·sal·hard·D) không trùng gói khác tại thời điểm sửa.

| | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Bản 1 | 56 | 28 | 6 | 10 | 13 | 30 | 41 | 16 |
| Bản 2 (thật) | 56 | 28 | 6 | 10 | 16 | 30 | 38 | 16 |
| Bản 3 (v3, quyết định 126 điểm) | 56 | 28 | 6 | 10 | 17 | 34 | 35 | 14 |
| Bản 4 (chuẩn hoá theo quy_chuan) | 56 | 28 | 6 | 10 | 17 | 35 | 34 | 14 |

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
