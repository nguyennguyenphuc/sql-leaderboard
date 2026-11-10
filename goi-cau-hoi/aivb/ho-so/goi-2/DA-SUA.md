# Đã sửa · gói 2 · AIV Bank (`aivb`) · v2 (10/11/2026)

Kiểm lại:
- Gói tạm `cong-cu/ket-qua/sua/aivb-goi-2/` (s6, a2, c3, c4, tức các câu đã sửa SQL hoặc yêu cầu ảnh hưởng tới kết quả) chạy thật trên MySQL: **KIEM TRA: 0 loi**.
- Cả gói phân tích tĩnh (`--chi-phan-tich`): **0 loi**.
- Biên dịch XeLaTeX: 44 trang, 0 lỗi, 0 ký tự thiếu.

| Mã | Đã sửa gì (theo B/C) | Kiểm lại |
|---|---|---|
| `aivb-s1-chi-nhanh-quan` | B: tiêu đề "Chi nhánh nào còn chữ ``Quận'' trong tên?"; bối cảnh đổi sang việc đổi tên chi nhánh sau khi bỏ cấp quận, để không còn bỏ sót chi nhánh nội thành; câu "giúp quyết định gì" mới; `\luuy` bỏ khuôn "…, nên …" và cụm "tên trụ sở". SQL giữ nguyên. | tĩnh |
| `aivb-s2-ho-kinh-doanh-fnb` | C: "gói thanh toán QR" → "dịch vụ thanh toán QR". | tĩnh |
| `aivb-s3-lenh-mobile-theo-thang` | B: tiêu đề "Số lệnh qua ứng dụng di động từng tháng năm 2026"; bỏ "mức dùng"; `\luuy` và gợi ý 1 viết lại (bỏ câu dịch máy "Năm 2026 kết thúc ở đâu?"). | tĩnh |
| `aivb-s4-tai-khoan-mo-giua-nam` | C: tiêu đề còn 10 tiếng; item định nghĩa tài khoản đang mở viết lại, mở bằng động từ; bối cảnh bỏ "từ dữ liệu hiện có"; `\ghichuthietke` ghi rõ câu chỉ sát Module 3 ở phần so sánh ngày. | tĩnh |
| `aivb-s5-giai-ngan-ngay-cuoi-thang` | B: hết mơ hồ, yêu cầu ghi rõ chỉ lấy ngày giải ngân đầu trên hợp đồng vay (`core_loan_contract.disbursement_date`), không xét các lần giải ngân sau (29 khoản, so với 47 nếu xét từng lần); bỏ ngoặc chỉ cách tránh bẫy trong yêu cầu; `domain=finance` → `sales` (STYLE G); "chạy chỉ tiêu" → "đạt chỉ tiêu". SQL giữ nguyên. | tĩnh |
| `aivb-s6-ngay-gia-tri-lech` | C: ngưỡng 50.000.000 → **30.000.000 đồng** (public 40 dòng, hidden-1 38 dòng, nên hai biến thể khác nhau); bối cảnh bỏ "cuối tuần làm việc" (lộ đáp án); `\luuy` "số ngày lệch không âm"; "ghi bằng số"; tiêu đề 9 tiếng; `\ghichuthietke` sửa thông tin sai về H(a). | **gói tạm 0 lỗi** |
| `aivb-s7-ma-dang-ky-kinh-doanh` | B: bối cảnh bỏ "ra 0 dòng" và câu lặp "Anh chị xem giúp em sai ở đâu."; tiêu đề "Tra đầu mã số đăng ký không ra tổ chức nào"; `\luuy` bỏ khuôn "…, nên …". | tĩnh |
| `aivb-s8-lenh-bi-dao-theo-thang` | Phá khuôn lặp: đổi người hỏi (Bạn Khoa), lời nhắn không nhắc "dòng", bỏ "Anh chị xem giúp em sai ở đâu.". Mã giữ nguyên theo BRIEF-SUA mục 3. | tĩnh |
| `aivb-s9-quyet-dinh-kyc-thang-12-2025` | B: `domain=after_sales` → `customer` (STYLE G: KYC theo vòng là `customer`); lời nhắn "Em sửa giúp chị truy vấn" → "Em xem lại giúp chị cách lấy danh sách."; giải nghĩa "nhận biết khách hàng (KYC)" ở lần đầu; giá trị mẫu ERD `'2025-12-31 10:00:02'` (có thật). | tĩnh |
| `aivb-a1-du-no-binh-quan` | C: yêu cầu bỏ định nghĩa vòng ("còn dư nợ: đang còn dư nợ"); đổi vai thành Trưởng phòng quản lý rủi ro tín dụng, "toàn bộ khoản vay của ngân hàng"; `\ghichuthietke` bỏ ẩn dụ "kéo". | tĩnh |
| `aivb-a2-khach-hang-theo-phan-khuc` | B: thêm item chỉ xét phân khúc cá nhân (`ref_segment.party_type = 'PERSON'`), cho khớp vai Trưởng phòng khách hàng cá nhân; câu dùng thật bảng thứ 2, đúng cấp Dễ; thêm wrong `quen_loc_ca_nhan`; tiêu đề "Mỗi phân khúc có bao nhiêu khách hàng theo từng trạng thái?"; KYC giải nghĩa, thống nhất "KYC không đạt". | **gói tạm 0 lỗi** |
| `aivb-a3-ho-so-vay-san-pham-hang-diem` | C: `cap=medium` → **easy** (1 bảng, 1 phép đếm có điều kiện); ERD 2 bảng có chữ trên đường nối; tiêu đề "Mỗi sản phẩm vay có bao nhiêu hồ sơ từng hạng?"; `\luuy` bỏ câu "không so hạng nào tốt hơn". SQL giữ nguyên. | tĩnh |
| `aivb-a4-ty-trong-kenh` | B: "truy vấn con vô hướng" → "truy vấn con trả về đúng một giá trị" (gợi ý và `kynang`). | tĩnh |
| `aivb-a5-nhom-dti-ty-le-duyet` | C: tiêu đề "Tỷ lệ duyệt thay đổi thế nào theo nhóm DTI?"; bối cảnh viết lại; ngưỡng ghi dạng 30\% / 50\% để giữ bẫy thang `dti`; gợi ý "dạng tỷ lệ từ 0 tới 1"; công thức khái niệm `ho-so-vay-va-ty-le-duyet` thống nhất "đã có quyết định". SQL giữ nguyên (ngưỡng 0,3 và 0,5 tương đương). | tĩnh |
| `aivb-a6-ty-le-khoan-vay-co-van-de` | B: tiêu đề "…đang có vấn đề hoặc đã xử lý rủi ro?"; yêu cầu ghi rõ trạng thái tại ngày chốt dữ liệu, khoản từng quá hạn rồi tất toán không tính; `\luuy` bỏ khuôn "…, nên … mới phản ánh…". | tĩnh |
| `aivb-a7-lenh-thanh-cong-2026` | C: tiêu đề "…cao hơn thực tế" (bỏ "thổi phồng"); yêu cầu bỏ "của chúng" và mệnh đề treo; phá khuôn lặp: người hỏi là Kế toán giao dịch, bỏ "Anh chị xem giúp em sai ở đâu.". | tĩnh |
| `aivb-a8-khach-nop-ho-so-theo-nam` | B: `cap=medium` → **easy** (mẫu debug COUNT(*)/COUNT(DISTINCT)); ERD 2 bảng, đường nối cảnh báo có chữ; "khách" → "người"; `\luuy` bỏ câu chỉ cách tránh bẫy. | tĩnh |
| `aivb-a9-thieu-nghe-nghiep-theo-thu-nhap` | C: tiêu đề "…cao bất thường" (bỏ "đếm ngược"); "nhóm thu nhập" → "khoảng thu nhập"; "gần như ai cũng thiếu" → "phần lớn cá nhân đều thiếu"; `cap=medium` → **easy**, ERD 2 bảng có chữ. | tĩnh |
| `aivb-c3-kenh-hoan-lenh-quy-4` | B: chấm oan (API 0,4258\% và ATM 0,4308\% cùng làm tròn 0,43) xử lý bằng **`thutu=khong`**, yêu cầu ghi bước này không xét thứ tự; bài sai `sap_theo_so_lenh` (không còn rớt) thay bằng `quen_can_tren` (rớt ở hidden-1); tiêu đề "Quý 4/2026 nên rà soát kênh giao dịch nào trước?"; `\luuy` bỏ câu cho sẵn đáp án; phương án ghi "ứng dụng di động (MOBILE)", "giao dịch tại quầy (BRANCH)"; "phòng chị". | **gói tạm 0 lỗi** |
| `aivb-c4-ho-so-vay-2025` | C: `\luuy` bỏ câu lộ kết luận; bước 1 đổi thành quy mô cả năm (số hồ sơ, tổng số tiền đề nghị, tỷ lệ duyệt), làm mẫu số cho bước 2; phương án đúng dựa vào bước 1 và bước 2; thêm phương án sai dùng tỷ lệ duyệt bước 1; tiêu đề "Năm 2025 nhu cầu vay tập trung ở sản phẩm nào?". | **gói tạm 0 lỗi** |

Đổi cấp làm phân bổ cấp của gói khác bản đồ: basic 4, easy 13, medium 3 (bản đồ: 4/10/6). M4 vẫn có ≥ 1 câu Dễ. Không ô dạng × mảng × cấp × hình thức nào trùng.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Hai biến thể cho cùng kết quả** ở s1, s2, s4, s5, s7, s9, a2, a3, a5, a6, a8, a9, c4 (trước ở mục Chờ giảng viên): `mysql/aivb/04_bo_sung_bien_the_aivb.sql` thêm cụm khách hàng giả (d)–(k): chi nhánh "Quận 3" (CN13), hộ kinh doanh "…F\&B" mã `0100000125-001`, tài khoản đóng 15/9/2026, khách thiếu nghề nghiệp, KYC tháng 12/2025, hồ sơ, quyết định, khoản vay giải ngân ngày cuối tháng. Chạy solution trên `aivb` và `aivb_hidden_1` (user `sql_runner`): cả 13 câu nay khác public (s1 3/2 dòng, s2 19/18, s5 31/29, s7 11/10, s9 62/61; s4, a2, a3, a5, a6, a8, a9, c4.b1, c4.b2 khác giá trị), chép kết quả Chạy thử rớt ở hidden-1.

## Chờ giảng viên

1. **a1:** tên "dư nợ bình quân" (`du_no_bq`) ở ngân hàng thường hiểu là bình quân theo thời gian; câu dùng "bình quân một khoản vay". Cần xác nhận cách gọi.
2. **a3:** chiều tốt – xấu của hạng điểm A–D chưa chốt. Tỷ lệ duyệt theo hạng không đơn điệu (A 70,9\%, B 65,8\%, C 68,0\%, D 66,7\%), nên chưa ghi "A là rủi ro thấp nhất" vào đề.
3. **a6:** gộp đang quá hạn, đã cơ cấu lại và đã xử lý rủi ro thành "khoản vay có vấn đề" có phải cách báo cáo quen dùng không.
4. **Khái niệm `chi-nhanh`:** định nghĩa do người soạn viết, chưa đối chiếu Luật Các tổ chức tín dụng.
5. **s8:** mã chứa "hoan" (`aivb-s8-lenh-hoan-theo-thang`) lệch STYLE A.5; không đổi mã theo BRIEF-SUA mục 3. Có đổi thành `…-lenh-bi-dao-theo-thang` không.

## Quyết định v3 (10/11)

Thay cho mục "Chờ giảng viên" ở trên (giữ lại làm lịch sử). PB = `05_eDA_parameter_book_mini_core_banking_v5.1.5.xlsx` (thư mục `Project DA\Finance\`). Bảng tổng của bộ: `../QUYET-DINH-126.md`.

| mã | điểm | quyết định | căn cứ | đã sửa gì |
|---|---|---|---|---|
| aivb-a1 | "dư nợ bình quân" | Giữ cột `du_no_bq`, đề nói rõ "dư nợ bình quân mỗi khoản vay" và phân biệt với bình quân theo thời gian | Báo cáo ngân hàng dùng dư nợ bình quân theo thời gian (bình quân số dư cuối ngày trong kỳ); PB dùng "bình quân kỳ" theo nghĩa thời gian (sheet 03, "Active bình quân kỳ") | Yêu cầu "dư nợ bình quân mỗi khoản vay"; `\luuy` thêm câu phân biệt hai cách tính; SQL không đổi |
| aivb-a3 | chiều tốt – xấu của hạng A–D | Giữ v2: đề không nêu chiều | PB sheet 08.Lending (hệ số chuyển nhóm nợ xấu đi: hạng A 0,5; C 2,0; D 3,5) coi A rủi ro thấp nhất; nhưng tỷ lệ duyệt theo hạng trên dữ liệu không đơn điệu, câu chỉ đếm | `\ghichuthietke` ghi căn cứ, bỏ chữ "chờ" |
| aivb-a6 | "khoản vay có vấn đề" | Giữ; yêu cầu đã liệt kê đủ ba trạng thái | PB sheet 08.Lending: DELINQUENT khi DPD > 0, RESTRUCTURED cho khoản nhóm 3 trở lên được cơ cấu, WRITTEN_OFF khi nhóm 5 từ 6 tháng; TT31/2024 Điều 3 (nợ cơ cấu lại); `\luuy` đã nói "chưa chắc là nợ xấu" | Không sửa |
| khái niệm `chi-nhanh` | định nghĩa chưa đối chiếu luật | Viết lại, chép giống gói 1 | Thông tư 32/2024/TT-NHNN Điều 3 (chi nhánh là đơn vị phụ thuộc, hạch toán phụ thuộc, thực hiện một phần nghiệp vụ); Luật Các TCTD 2024 Điều 4 chỉ định nghĩa chi nhánh ngân hàng nước ngoài (https://hethongphapluat.com/luat-cac-to-chuc-tin-dung-2024/dieu-4) | Sửa `\khaibaokhainiem{chi-nhanh}` |
| aivb-s8 | mã chứa "hoan" | Đổi mã `aivb-s8-lenh-hoan-theo-thang` thành `aivb-s8-lenh-bi-dao-theo-thang` | STYLE-aivb A.5 ('REVERSED' = "bị đảo"); BAO-CAO 3.6 | Đổi ở `cau-hoi.tex`, `solution.sql`, `BANG-PHAN-CONG.md`, bảng đầu tệp này, `../BAN-DO-100-CAU.md` |
| tên nhân vật | một tên nhiều vai | Mỗi vai một tên, mỗi tên một vai, chung cả bộ (STYLE-aivb mục H) | BAO-CAO 3.8 | s1 Chị Mai → Anh Quang; s9, a9 Chị Thu → Chị Mai; a2 Chị Phương → Chị Ngân; a3 Anh Quang → Anh Hải; a6 Anh Đức → Anh Tâm; a8 Chị Phương → Anh Hải; c3 Chị Mai → Anh Quang; c4 Anh Hùng → Anh Hưng; s7, s8 thực tập sinh → Bạn Vy. Đổi giới thì đổi đại từ trong lời nhắn |
| c3, c4 | tiền tố lời giải thích bước kết luận | Theo quy chuẩn | QUYET-DINH-CHUNG 0.1 #1; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4 | Phương án đúng mở bằng "Đúng: ", phương án sai bỏ "Chưa đúng. " |

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu có 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (lộ trình `quy_chuan/lo-trinh-sql/assets/js/data.js`: mọi module đủ 4 cấp; QUYET-DINH-CHUNG 0.1 mục 5, 2.1). Giữ tỷ lệ 6 write + 3 debug mỗi module; case c3, c4 giữ nguyên cấp. Đổi 8 câu (tối thiểu: M3 thừa 1 Cơ bản, 3 Dễ; M4 thừa 3 Dễ, 1 Trung bình, thiếu 2 Cơ bản, 2 Khó).

| Module | Trước (Cơ bản/Dễ/TB/Khó) | Sau |
|---|---|---|
| M3 String & Date | 3 / 6 / 0 / 0 (s1, s2, s7 · s3–s6, s8, s9) | 2 / 3 / 2 / 2 (s1, s2 · s3, s8, s9 · s4, s7 · s5, s6) |
| M4 Aggregation | 0 / 6 / 3 / 0 (a1–a3, a7–a9 · a4–a6) | 2 / 3 / 2 / 2 (a1, a7 · a2, a3, a8 · a4, a5 · a6, a9) |

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (số bảng lời giải · số bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `aivb-s4-tai-khoan-mo-giua-nam` → `aivb-s4-bien-dong-tai-khoan-2026` | Dễ → Trung bình (write, B4, operations) | Viết lại: biến động tài khoản thanh toán năm 2026 theo dòng sản phẩm (tách từ `product_version_id` bằng `SUBSTRING_INDEX`): đầu kỳ, mở mới, đóng, cuối kỳ, tỷ lệ đóng. Thêm khái niệm `bien-dong-tai-khoan`. ERD 3 bảng ký hiệu 1-n. Vai Anh Quang. 4 bài sai mới (thiếu `close_date IS NULL`; cuối kỳ theo `account_status = 'ACTIVE'`; `SUM` phép so sánh ra NULL ở `CASA_BIZ`; giữ mã phiên bản) | 1 bảng (Cơ bản) · 2 tầng (Dễ) · chỉ số định nghĩa ở tab Nghiệp vụ (TB) · 2 bẫy: NULL ở ba phép đếm, SUM ra NULL (TB) · công thức 2 thành phần, điều kiện theo thời điểm (TB) → 3/5 TB |
| `aivb-s5-giai-ngan-ngay-cuoi-thang` → `aivb-s5-giai-ngan-don-cuoi-thang` | Dễ → Khó (write, A1 → E1, sales) | Viết lại: tháng nào năm 2025 có tỷ trọng số tiền giải ngân trong 5 ngày cuối tháng từ 30% trở lên, tính trên mọi lần giải ngân (`core_loan_disbursement`), `LAST_DAY` + `DATEDIFF`, `HAVING`. ERD 5 bảng chỉ khoá, `\erdkhoa`. 3 bài sai mới (cố định từ ngày 27; lấy 6 ngày; chỉ lần giải ngân đầu trên hợp đồng) | 1 bảng (như mẫu o4) · 4 tầng: gắn cờ, gom tháng, tỷ trọng, lọc nhóm (Khó) · ngôn ngữ kinh doanh, định nghĩa ở tab Nghiệp vụ, tự chọn bảng (Khó) · 3 bẫy: độ dài tháng, lệch một ngày, bảng chỉ có lần đầu (Khó) · chỉ số nhiều điều kiện (Khó) → 4/5 Khó |
| `aivb-s6-ngay-gia-tri-lech` → `aivb-s6-ngay-gia-tri-sang-thang-sau` | Dễ → Khó (write, E1 → B1, operations) | Viết lại: cắt kỳ khoá sổ, mỗi tháng 2026 bao nhiêu lệnh thành công có ngày giá trị sang tháng sau, số tiền và tỷ lệ trên giá trị tháng (`value_date > LAST_DAY(transaction_date)`). ERD 5 bảng chỉ khoá. 4 bài sai (so `MONTH` bỏ mất tháng 12 → năm 2027; đếm mọi lệnh lệch ngày; thiếu cận trên chỉ rớt ở hidden-1; quên lọc thành công) | 1 bảng · 3 tầng (TB) · ngôn ngữ khoá sổ, không ghi mã trạng thái (Khó) · 3 bẫy, 1 chỉ lộ ở hidden-1 (Khó) · cắt kỳ + trạng thái + tỷ lệ theo giá trị (Khó) → 3/5 Khó (thêm số bước sát Khó) |
| `aivb-s7-ma-dang-ky-kinh-doanh` → `aivb-s7-tham-nien-khach-hang` | Cơ bản → Trung bình (debug, A1 → C4, customer) | Viết lại: đếm khách hàng đang hoạt động theo thâm niên tại 30/06/2026; starter `YEAR(...) - YEAR(customer_since)` dời khách chưa tới ngày kỷ niệm lên một mức (lỗi khó thấy: đủ các mức, tổng không đổi). Sửa bằng `TIMESTAMPDIFF`. ERD 3 bảng ký hiệu 1-n. Vai Anh Bảo. 2 bài sai (chia 365 ngày; làm tròn số năm) | 1 bảng · 2 tầng · thâm niên định nghĩa ở tab Nghiệp vụ (TB) · 1 lỗi khó thấy (Sửa lỗi TB theo HD mục 6) · điều kiện theo thời điểm (TB) → 3/5 TB |
| `aivb-a1-du-no-binh-quan` (giữ mã) | Dễ → Cơ bản (write, A2, finance) | ERD còn 1 bảng có giá trị mẫu (bỏ `core_contract`); gợi ý còn 1 nấc nêu thẳng điều kiện lọc và hàm; bỏ gợi ý dẫn tới bẫy mẫu số; `\luuy` gọn lại. SQL không đổi | 1 bảng · 1 tầng · đề ghi rõ cột và mã trạng thái · 0 bẫy (dư nợ 0 bị loại nhờ điều kiện ghi sẵn) · 1 khái niệm → 5/5 Cơ bản |
| `aivb-a6-ty-le-khoan-vay-co-van-de` → `aivb-a6-khoan-vay-co-van-de-theo-san-pham` | Trung bình → Khó (write, A2 → A3, after_sales) | Viết lại: tỷ lệ khoản vay có vấn đề theo từng sản phẩm cho vay theo món (loại thấu chi vì `principal` là hạn mức), theo số khoản và theo số tiền vay ban đầu; nối 4 bảng. Thêm khái niệm `san-pham-cho-vay`. ERD 6 bảng chỉ khoá. Vai Chị Hạnh. 4 bài sai (theo dư nợ; thiếu `'WRITTEN_OFF'`; gộp thấu chi; sắp theo tỷ lệ số khoản làm đảo hai dòng đầu) | 4 bảng (Khó) · 3 tầng (TB) · không ghi mã, định nghĩa ở tab Nghiệp vụ, cách nối ở `\erdkhoa` (Khó) · 3 bẫy (Khó) · chỉ số nhiều điều kiện (Khó) → 4/5 Khó |
| `aivb-a7-lenh-thanh-cong-2026` (giữ mã) | Dễ → Cơ bản (debug, A2, operations) | Starter còn một lỗi dễ thấy (thiếu `payment_status = 'COMPLETED'`, đã có đủ hai cận ngày); yêu cầu ghi mã trạng thái; ERD 1 bảng giá trị mẫu tô `'REVERSED'`; vai Bạn Vy (thực tập sinh, sửa lỗi cấp thấp); bài sai `quen_can_tren` thay bằng `chi_bo_bi_dao` | 1 bảng · 1 tầng · đề ghi rõ giá trị lọc · 1 lỗi dễ thấy (Sửa lỗi Cơ bản) · 1 khái niệm → 5/5 Cơ bản |
| `aivb-a9-thieu-nghe-nghiep-theo-thu-nhap` → `aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang` | Dễ → Khó (debug, A3 → A2, customer) | Viết lại theo bài Khó `a6-trung-binh-ty-le` của lộ trình (tỷ lệ của tổng): tỷ lệ thiếu nghề nghiệp chung của khách cá nhân đang hoạt động; starter 3 lỗi chồng nhau (`COUNT(occupation_code)` đếm số đã có; `AVG` các tỷ lệ theo khoảng thu nhập; không giới hạn khách đang hoạt động). ERD 5 bảng chỉ khoá. 4 bài sai, mỗi bài sửa thiếu một lỗi hoặc nối trái từ bảng khách hàng | 2 bảng · 3 tầng (CTE) · không ghi mã, cách nối ở `\erdkhoa` (Khó) · 3 bẫy (Khó) · sai định nghĩa chỉ số, 3 lỗi chồng nhau (Sửa lỗi Khó theo HD mục 6) → Khó |

Đồng bộ mã mới ở `cau-hoi.tex`, `solution.sql`, `BANG-PHAN-CONG.md`, `../../BAN-DO-100-CAU.md` (8 dòng câu của gói 2, dòng M3, M4 ở bảng "Theo module" và dòng gói 2 ở bảng "Theo gói"; các dòng tổng chưa đếm lại vì agent khác đang sửa song song: gói 2 đổi basic +1, easy −6, medium +1, hard +4).

Ô dạng × mảng × cấp × hình thức: không trùng trong gói. So bản đồ: các ô mới (B4·operations·medium·write; E1·sales·hard·write; B1·operations·hard·write; C4·customer·medium·debug; A2·finance·basic·write; A3·after_sales·hard·write; A2·operations·basic·debug; A2·customer·hard·debug) không trùng gói khác; bỏ được ô trùng cũ A1·customer·basic·debug (s7 với r7). Gần chủ đề (không trùng ô): a6 với `aivb-j6-khoan-vay-co-van-de-theo-vung` (gói 3, cùng khái niệm "khoản vay có vấn đề", khác chiều phân rã và cấp).

Kiểm: bộ kiểm đầy đủ cả gói `--ra cong-cu/ket-qua/cap-do/aivb-goi-2` **KIEM TRA: 0 loi**, 0 cảnh báo; mỗi bài sai rớt ≥ 1 biến thể; solution public ≠ hidden-1 ở cả 8 câu. Biên dịch `bash cong-cu/bien_dich.sh goi-cau-hoi/aivb/goi-2 <ra>`: 49 trang, 0 lỗi LaTeX, 0 ký tự thiếu. Thời gian: các solution trên bảng lệnh thanh toán (s6, như s3, a4, c3 có sẵn) đọc trọn 2 triệu lệnh một lần; đo 7,5–12 giây khi máy chủ đang chạy bộ kiểm của nhiều agent cùng lúc (truy vấn quét bảng đơn giản nhất cùng lúc mất 2–5 giây); các câu v4 khác dưới 1 giây.
