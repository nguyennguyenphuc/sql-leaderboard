# Đã sửa · gói 3 AIV Bank (aivb) · v2

Theo REVIEW-B.md, REVIEW-C.md. Không sửa database, không sửa biến thể ẩn.
Kiểm lại:
- Gói tạm `cong-cu/ket-qua/sua/aivb-goi-3` có 15 câu đã sửa SQL hoặc yêu cầu, chạy MySQL: **KIEM TRA: 0 loi**.
- Cả gói (20 câu, 62 khối SQL) chạy `--chi-phan-tich`: **KIEM TRA: 0 loi**.
- XeLaTeX (`cong-cu/ket-qua/bien-dich/aivb-goi-3`): 48 trang, 0 lỗi LaTeX, 0 ký tự thiếu.
- j8, j9 chỉ đổi lời nhắn và động từ mở mục yêu cầu, SQL giữ nguyên, nên chỉ kiểm tĩnh. q1, q6 chỉ sửa chữ.

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| aivb-j1-khach-hang-theo-vung | B: vai trò → "Giám đốc khối vận hành"; lời nhắn "mỗi miền đang có bao nhiêu khách hàng đang hoạt động". Biến thể: đã xử lý (bổ sung biến thể ẩn 10/11). | phân tích tĩnh |
| aivb-j2-ho-so-duyet-va-so-tien | C: tiêu đề → "Hồ sơ vay cá nhân nộp tháng 12/2025 được duyệt bao nhiêu tiền?" (không còn trùng bẫy lọc theo ngày quyết định, bỏ hai bị động); lọc `customer_type = 'PERSONAL'` cho khớp vai Trưởng phòng khách hàng cá nhân (SQL solution và 2 wrong); câu mở tab Nghiệp vụ "số tiền được duyệt". | bộ kiểm 0 lỗi |
| aivb-j3-so-du-casa-theo-phan-khuc | B: tiêu đề → "Số dư tài khoản thanh toán chia theo phân khúc ra sao?"; thống nhất "tài khoản thanh toán"; \luuy "phân khúc của chủ tài khoản"; bỏ khuôn "Xét mọi". | bộ kiểm 0 lỗi |
| aivb-j4-ty-le-khach-co-ho-so-vay | C: tiêu đề → "tỷ lệ khách nộp hồ sơ vay"; "bao nhiêu phần trăm"; "tỷ lệ khách có hồ sơ trên tổng số khách"; chỉ xét phân khúc cá nhân (`ref_segment.party_type = 'PERSON'`), nên `ref_segment` thành bảng phải nối và bỏ dòng INST 2 khách (SQL solution và 2 wrong). | bộ kiểm 0 lỗi |
| aivb-j5-doi-soat-giai-ngan | B: tiêu đề "khớp số tiền vay ban đầu"; câu mở tab Nghiệp vụ bỏ "và"; bỏ "Xét mọi". Thấu chi: xem Chờ giảng viên. | bộ kiểm 0 lỗi |
| aivb-j6-khoan-vay-co-van-de-theo-vung | C: tiêu đề → "Khoản vay quá hạn và cơ cấu lại tập trung ở miền nào?"; bỏ "chưa chắc", bỏ "Xét mọi". Cấp và bẫy dữ liệu thêm: xem Chờ giảng viên. | bộ kiểm 0 lỗi |
| aivb-j7-chu-so-huu-tai-khoan-da-dong | B: tiêu đề → "Danh sách chủ tài khoản của tài khoản đóng năm 2026 bị thừa dòng"; \luuy theo câu B đề xuất (không còn nhận định "đồng chủ tài khoản không đứng tên"); câu mở tab Nghiệp vụ "đúng chủ tài khoản"; lời nhắn đổi cách kết. | bộ kiểm 0 lỗi |
| aivb-j8-dong-tien-rong-theo-kenh | C: vai trò → "Bạn Khoa · Thực tập sinh"; lời nhắn "Báo cáo của em về dòng tiền ròng theo kênh tháng 12/2026…", kết bằng "chỉ giúp em chỗ sai"; câu mở tab Nghiệp vụ bỏ nhân hoá kênh; \luuy "Tháng 12/2026 tính tới hết ngày 31/12/2026". | phân tích tĩnh (SQL không đổi) |
| aivb-j9-lai-du-thu-cho-vay-2026 | B: bối cảnh bỏ chữ "truy vấn", đổi cách kết ("Em dò lại cách tính."). | phân tích tĩnh (SQL không đổi) |
| aivb-q1-khoan-vay-tren-binh-quan | C: lời nhắn bỏ "nhóm này"; \luuy bỏ câu dạy đời. Cách gọi `'ACTIVE'`: xem Chờ giảng viên. | phân tích tĩnh |
| aivb-q2-khach-co-khoan-vay-qua-han | B: `cap=medium` (truy vấn con nối 3 bảng), ERD chỉ ký hiệu; tiêu đề → "Người vay nào có kỳ trả nợ quá hạn?"; lời nhắn "Mỗi người vay chỉ cần có tên một lần." | bộ kiểm 0 lỗi |
| aivb-q3-tien-gui-lai-cao-hon-ky-han | C: bỏ "đang còn hiệu lực" (lệch khái niệm), ghi rõ `'ACTIVE'`, không tính hợp đồng đã tái tục `'RENEWED'`. Phạm vi gồm RENEWED hay không: xem Chờ giảng viên. | bộ kiểm 0 lỗi |
| aivb-q4-ho-so-de-nghi-lon-nhat | B: lời nhắn "số tiền lớn nhất của từng sản phẩm" (bỏ "mức trần" lẫn với "hạn mức"); \luuy bỏ chữ "đề"; câu mở tab Nghiệp vụ sửa theo; bỏ "Xét mọi". | bộ kiểm 0 lỗi |
| aivb-q5-pheu-khach-vay | C: chỉ xét khách hàng cá nhân đang hoạt động (phân khúc `party_type = 'PERSON'`) cho khớp vai người hỏi (SQL solution và 2 wrong); ERD thêm `ref_segment`; tiêu đề không còn "rơi rụng"; bỏ "chưa chắc". | bộ kiểm 0 lỗi |
| aivb-q6-lenh-lon-bat-thuong | B: tiêu đề → "Lệnh nào lớn bất thường so với lệnh cùng loại giao dịch?" (bỏ "nó"). | phân tích tĩnh |
| aivb-q7-khach-chua-nop-ho-so | C: tiêu đề → "Danh sách khách chưa nộp hồ sơ vay ra toàn bộ khách"; ERD thêm giá trị mẫu thật `customer_id='SYN_CUS_0000043'`, `party_id='SYN_PTY_P000043'` ở cả hai bảng, nên gợi ý 1 đã khớp ERD; câu mở tab Nghiệp vụ "chưa từng nộp hồ sơ vay"; lời nhắn đổi cách kết. | bộ kiểm 0 lỗi |
| aivb-q8-chi-nhanh-so-du-tren-binh-quan | B: wrong cũ ra trùng starter, thay bằng `bang_dan_xuat_quen_group_by` (0 dòng, rớt cả hai biến thể); tiêu đề "số dư tài khoản thanh toán"; \luuy câu dữ liệu cụ thể thay câu khẩu hiệu; bỏ "Xét mọi". | bộ kiểm 0 lỗi |
| aivb-q9-chinh-sach-hieu-luc-ngay-nop | C: \luuy → "Câu này gán phiên bản theo ngày nộp hồ sơ, không dùng mã chính sách ghi trên hồ sơ."; khái niệm `chinh-sach-tin-dung` bỏ nhận định "không phải lúc nào cũng khớp", thay bằng sự thật trên dữ liệu (hồ sơ nộp trước phiên bản đầu tiên vẫn mang mã); tiêu đề → "Số hồ sơ theo phiên bản chính sách bị hụt"; lời nhắn đổi cách kết. | bộ kiểm 0 lỗi |
| aivb-c5-kyc-khong-dat-theo-chi-nhanh | B: câu mở tab Nghiệp vụ chỉ còn "Chọn chi nhánh cần đào tạo lại quy trình nhận biết khách hàng (KYC)."; bỏ câu 2 của \luuy (ý "ngẫu nhiên" chuyển vào lời giải thích phương án đúng); phương án đúng rút ngắn, bỏ từ rào "chưa đủ căn cứ", ba phương án dài gần bằng nhau; "Hội sở chính (CN01)"; lời nhắn "cao nhất … tỷ lệ toàn hàng"; \goiy b2 bỏ khuôn "mệnh đề: kết luận"; b2 thêm "Tính hiệu từ hai tỷ lệ chưa làm tròn."; b1 bỏ "Xét mọi". | bộ kiểm 0 lỗi |
| aivb-c6-ban-cheo-tien-gui-va-vay | C: chỉ xét phân khúc cá nhân ở cả 3 bước (SQL solution và mọi wrong), nên đáp án duy nhất (MICRO không còn khớp phương án đúng); thêm `ref_segment` vào ERD và `bang`; tiêu đề → "Khách gửi tiền có kỳ hạn vay nhiều hơn hay ít hơn?"; lời nhắn "so tỷ lệ có khoản vay giữa…"; phương án đúng rút còn khoảng 30 tiếng, không số, không câu rào; viết lại hai phương án sai, dài tương đương (đảo chiều tương quan; chọn nhầm phân khúc ưu tiên); \luuy không còn chép phương án; \goiy b2 bỏ khuôn "mệnh đề: kết luận"; bỏ "Xét mọi". | bộ kiểm 0 lỗi |

Phá khuôn lặp:
- "Anh chị xem giúp em sai ở đâu." còn 0 lần. Ba câu Sửa lỗi kết khác nhau: j7 "Em chưa tìm ra lỗi, nhờ anh chị chỉ giúp.", j8 "Anh chị chỉ giúp em chỗ sai.", q7 "Em đã dò mấy lần mà chưa thấy điều kiện nào sai."
- "Em xem lại giúp chị" ở j9, q9 cũng đã đổi.
- "Xét mọi …" còn 0 lần (thay bằng "Lấy …", "Tính trên toàn bộ …").
- "chưa chắc" còn 1 lần, ở khái niệm dùng chung.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Hai biến thể cho cùng kết quả** ở j1–j7, q2, q3, q4, q5, q7, q8, q9, c5, c6 (trước ở mục Chờ giảng viên): `mysql/aivb/04_bo_sung_bien_the_aivb.sql` đổi đúng các bảng B, C đề xuất bằng một cụm khách hàng giả (d)–(k): `core_customer`, `core_account_party`, `core_account_balance`, `core_loan_disbursement`, `core_loan_application`, `core_loan_schedule`, `core_loan_contract`, `core_deposit_contract`; `bokiemtra` giữ `public, hidden-1`. Chạy solution trên `aivb` và `aivb_hidden_1` (user `sql_runner`): cả 16 câu nay khác public (j2 33/32 dòng, j7 200/199, q2 94/93, q3 22/21, q4 36/35, q7 208/207, c5.b1, c5.b2 13/12; j1, j3–j6, q5, q8, q9, c6.b1–b3 khác giá trị), chép kết quả Chạy thử rớt ở hidden-1.

## Chờ giảng viên

1. **j5 thấu chi.** Mọi khoản "lệch" đều là OD_IND, OD_BIZ. Cần xác nhận `principal` của thấu chi là hạn mức. Nếu đúng, thêm \luuy về hạn mức hoặc loại thấu chi khỏi phạm vi.
2. **j7 đồng chủ tài khoản.** Theo TT17, đồng chủ tài khoản có được coi là "đứng tên" không. \luuy hiện chỉ nói thư gửi `'PRIMARY_OWNER'`, không còn nhận định.
3. **q3 ACTIVE và tái tục.** Hợp đồng `'RENEWED'` (4.478) có thuộc mặt bằng lãi suất "còn hiệu lực" không. Hiện đề ghi rõ chỉ xét `'ACTIVE'`.
4. **q1 cách gọi `'ACTIVE'` của khoản vay.** STYLE A.4 gọi "đang còn dư nợ", mục E gọi "đang được trả bình thường". Cần chốt một cách gọi cho cả bộ.
5. **j6 cấp.** C cho rằng câu gần mức Dễ. Hiện giữ Trung bình. Nếu giữ cấp này, cần thêm một bẫy dữ liệu, ví dụ cột dư nợ nhóm quá hạn. **q9 cấp:** lỗi một ký tự, gần mức Cơ bản. Có thể thêm lỗi thứ hai cho starter.
6. **Đổi cấp ảnh hưởng thống kê bản đồ.** q2 đổi sang Trung bình. Gói 3 còn easy 6, medium 14. M6 vẫn có câu Dễ (q1, q7). Cần cập nhật BAN-DO-100-CAU.md.

## Quyết định v3 (10/11)

Thay cho mục "Chờ giảng viên" ở trên (giữ lại làm lịch sử). PB = `05_eDA_parameter_book_mini_core_banking_v5.1.5.xlsx` (thư mục `Project DA\Finance\`). Bảng tổng của bộ: `../QUYET-DINH-126.md`.

| mã | điểm | quyết định | căn cứ | đã sửa gì |
|---|---|---|---|---|
| aivb-j5 | `principal` của thấu chi có phải hạn mức | Đúng là hạn mức; thêm lưu ý, giữ SQL | PB sheet 08.Lending: OD_IND "revolving, hạn mức = 3× lương", OD_BIZ vốn lưu động quay vòng; dữ liệu: mọi khoản OD_IND, OD_BIZ có `outstanding` = 0, mọi khoản "lệch" là thấu chi | `\luuy` thêm câu về hạn mức thấu chi; `\ghichuthietke` |
| aivb-j6 | gần mức Dễ | Giữ Trung bình, thêm một bẫy | QUYET-DINH-CHUNG mục 2.3 dòng 2 | Thêm cột `so_khoan_vay` (mọi trạng thái); wrong mới `loc_trang_thai_o_where` (lọc ba trạng thái ở `WHERE` làm cột tổng sai); wrong cũ thêm cột; gợi ý nấc 2 không còn viết sẵn cả biểu thức cột tổng; thêm bẫy `loc-where-mat-mau` |
| aivb-q9 | lỗi một ký tự, gần mức Cơ bản | Giữ Trung bình, thêm lỗi thứ hai vào starter | QUYET-DINH-CHUNG mục 2.3 dòng 2; dữ liệu: 12 hồ sơ nộp đúng ngày đầu phiên bản | Starter cận dưới `>` thay `>=`; wrong mới `chi_sua_can_tren` (rớt public); hai nấc gợi ý viết lại (nấc cuối không viết sẵn phép so sánh) |
| aivb-j7 | đồng chủ tài khoản có "đứng tên" không | Giữ v2: thư cảm ơn chỉ gửi `'PRIMARY_OWNER'`; đây là lựa chọn của tình huống, câu không nhận định pháp lý | PB sheet 05.Account Ownership: `JOINT_OWNER` là đồng sở hữu số dư, khác `PRIMARY_OWNER`; Thông tư 17/2024/TT-NHNN cho phép tài khoản thanh toán chung nhiều chủ | Không sửa |
| aivb-q3 | hợp đồng `'RENEWED'` có thuộc mặt bằng "còn hiệu lực" | Giữ v2: chỉ `'ACTIVE'` | PB sheet 07.Deposit: tái tục tự động (TD.RENEW) tạo hợp đồng mới và liên kết; hợp đồng `'RENEWED'` là hợp đồng cũ đã thay, lãi suất đang áp nằm ở hợp đồng mới `'ACTIVE'` | Không sửa |
| aivb-q1 | 'ACTIVE' gọi hai cách | Chốt "đang trả nợ bình thường" (q1 đã dùng) | PB sheet 08.Lending (DPD = 0); STYLE-aivb A.4 đã sửa | Không sửa gói |
| aivb-q2 | Dễ → Trung bình | Chấp nhận | QUYET-DINH-CHUNG mục 2.3 dòng 5 | Không sửa |
| aivb-c6 (`'AFFLUENT'`) | "giàu có" hay "khá giả" | Giữ: 'UPPER_MASS' "khá giả", 'AFFLUENT' "giàu có" | DB `ref_segment.segment_name` | Không sửa gói |
| tên nhân vật | một tên nhiều vai | Mỗi vai một tên, mỗi tên một vai, chung cả bộ (STYLE-aivb mục H) | BAO-CAO 3.8 | j5, j9 Chị Thu → Anh Khánh; q2 Anh Tùng → Anh Tâm; q3 Chị Hoa → Chị Hạnh; q4 Anh Đức → Anh Hải; q6 Anh Hải → Anh Quang; q9 Chị Hạnh → Chị Lan; j7, j8 thực tập sinh → Bạn Vy. Đổi giới thì đổi đại từ trong lời nhắn |
| c5, c6 | tiền tố lời giải thích bước kết luận | Theo quy chuẩn | QUYET-DINH-CHUNG 0.1 #1; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4 | Phương án đúng mở bằng "Đúng: ", phương án sai bỏ "Chưa đúng. " |

## Chuẩn hoá theo quy chuẩn (10/11/2026, BRIEF-CHUAN-HOA)

- **aivb-j8 (thời gian chạy):** solution nối 182.348 bút toán tháng 12/2026 với lệnh thanh toán, chạy 64–87 giây (có lúc quá 180 giây khi MySQL bận). Thu phạm vi từ cả tháng 12/2026 về ngày giao dịch 31/12/2026 (6.769 bút toán ở public): sửa tiêu đề, bối cảnh, yêu cầu, `\luuy`, `\ghichuthietke`; SQL đổi `'2026-12-01'` → `'2026-12-31'` ở starter, solution, hai wrong (cận trên `'2027-01-01'` giữ nguyên). Kỹ năng, bẫy giữ: wrong 1 (thiếu cận trên) rớt ở hidden-1 (bút toán ghi Nợ 2027-01-01 của lệnh MOBILE), wrong 2 (bỏ trạng thái lệnh) rớt ở public. Solution còn khoảng 3 giây trên mỗi biến thể; cách viết tự nhiên `transaction_date = '2026-12-31'` cùng tốc độ.
- **ERD Trung bình đủ 3 bảng (CHOT mục 3):** j8 thêm `core_account` (nhiễu, nối `account_id`); q6 thêm `core_account` nối qua `core_account_posting.account_id` (q6 lời giải dùng 1 bảng, nên có 2 bảng nhiễu).
- **Gợi ý nấc cuối nêu trọn biểu thức:** j1, j4, j6, q1, q3 (bỏ `...`, ghi đủ cột, giá trị).
- **Tiêu đề ≤ 13 tiếng:** q8 (14 → 11 tiếng).
- **Kết luận case:** c5.b3, c6.b4 rút lời giải thích phương án đúng về ≤ 35 tiếng ("Đúng: " + chữ thường như mẫu); mỗi bước đúng 3 phương án.
- Khái niệm `giao-dich-bi-dao` chép lại đúng STYLE-aivb mục E. Không câu nào đổi cấp; gói không có câu Khó, Tối ưu.
- **aivb-q4 (thời gian chạy):** truy vấn con tương quan trên cả 3.104 hồ sơ chạy 34–49 giây khi MySQL bận (chỉ mục `product_id` chỉ có 7 giá trị). Thu phạm vi về hồ sơ nộp năm 2026 (719 hồ sơ public), cả truy vấn ngoài lẫn truy vấn con; sửa tiêu đề (13 tiếng), bối cảnh, yêu cầu, gợi ý 2, ERD (`application_date*`), ghi chú. Bẫy hoà giữ: OD\_IND 5 hồ sơ, WC\_LOAN 5 (public) / 6 (hidden-1). Thêm wrong `max_ca_lich_su` (MAX của sản phẩm tính trên mọi năm). Solution còn 6–7,5 giây lúc MySQL đang bận.
- **aivb-q6 (thời gian chạy):** mức thông thường tính trên cả năm 2026 (= toàn bảng 2 triệu lệnh) chạy 34–35 giây lúc bận. Thu về bình quân tháng 12/2026 (169.793 lệnh); solution 2,8–3,2 giây; 51 dòng public, 45 dòng hidden-1. Wrong thiếu cận trên vẫn dựa vào lệnh TRANSFER 2027-01-01 ở hidden-1.

## v4 – đủ 4 cấp mỗi module (11/11/2026, BRIEF-CAP-DO-MODULE)

Căn cứ: `quy_chuan/lo-trinh-sql/assets/js/data.js` (M5: j1 basic `INNER JOIN` 2 bảng, j3 easy `LEFT JOIN … IS NULL`, j5 medium nối 3 bảng, j6 hard tự nối bảng; M6: q1 basic truy vấn con một giá trị, q2/q3 easy `IN`/`NOT EXISTS`, q4/q5 medium, q6 hard truy vấn con tương quan có tiêu chí hoà), QUYET-DINH-CHUNG mục 0–2, CHOT-FORMAT mục 3, Huong-dan mục 5–6.

Phân bố cấp (9 câu mỗi module, không tính case):

| Module | Trước (v3) | Sau (v4) |
|---|---|---|
| M5 Joins | Cơ bản 0 · Dễ 3 (j1, j2, j7) · Trung bình 6 (j3, j4, j5, j6, j8, j9) · Khó 0 | Cơ bản 2 (j3, j9) · Dễ 3 (j1, j2, j7) · Trung bình 2 (j4, j8) · Khó 2 (j5, j6) |
| M6 Subqueries | Cơ bản 0 · Dễ 2 (q1, q7) · Trung bình 7 (q2–q6, q8, q9) · Khó 0 | Cơ bản 2 (q3, q6) · Dễ 3 (q1, q2, q7) · Trung bình 2 (q8, q9) · Khó 2 (q4, q5) |

Số câu viết lại: 9 (số tối thiểu: M5 thừa 4 Trung bình, thiếu 2 Cơ bản, 2 Khó; M6 thừa 5 Trung bình, thiếu 2 Cơ bản, 1 Dễ, 2 Khó). Hình thức giữ 6 write + 3 debug mỗi module. Case c5, c6 giữ cấp. Mọi câu viết lại có `\ghichuthietke` ghi cấp, 5 trục, bẫy, biến thể.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| aivb-j3-so-du-casa-theo-phan-khuc → aivb-j3-so-du-tai-khoan-mo-thang-12-2025 | Trung bình → Cơ bản | Thay câu số dư theo phân khúc (4 bảng, nhân dòng) bằng danh sách tài khoản mở tháng 12/2025 kèm số dư chốt; ERD 2 bảng kèm giá trị mẫu (nối không làm được trên 1 bảng; bài basic j1 của lộ trình cũng 2 bảng); A3 → A1 | 2 bảng nối 1-1 · 1 tầng · đề ghi rõ cột, khoảng ngày · chỉ cận trên (bình thường ở Cơ bản) · 1 khái niệm → Cơ bản 4/5 |
| aivb-j5-doi-soat-giai-ngan → aivb-j5-doi-soat-du-no-khoan-vay | Trung bình → Khó | Đối soát dư nợ trên hợp đồng với tổng giải ngân trừ gốc đã thu (thêm sổ phân bổ thu nợ); ERD 7 bảng chỉ khoá, 2 nhiễu, `\erdkhoa`; khái niệm `du-no` thêm công thức, thêm khái niệm `lich-tra-no` (chép STYLE-aivb E); mảng finance → operations (ô E2 finance hard đã có aivb-k3 gói 5) | 5 bảng · 4 tầng (2 CTE, LEFT JOIN, gom) · ngôn ngữ nghiệp vụ, công thức ở tab Nghiệp vụ · 3 bẫy: nhân dòng hai sổ, 43 khoản chưa thu nợ (INNER JOIN, NULL khi trừ), hidden-1 có 1 khoản MORT lệch (H(c)) còn public lệch 0 · công thức hai thành phần, phạm vi chưa tất toán → Khó 5/5 |
| aivb-j6-khoan-vay-co-van-de-theo-vung → aivb-j6-cap-san-pham-vay-cung-khach | Trung bình → Khó | Thay câu đếm trạng thái theo miền bằng cặp sản phẩm vay cùng được duyệt cho một chủ thể (tự nối bảng, như bài hard j6 của lộ trình); ERD 5 bảng chỉ khoá, 4 nhiễu; after_sales A4 → sales A4 | 1 bảng tự nối (Khó không bắt buộc nhiều bảng, mẫu o4) · 4 tầng · ngôn ngữ nghiệp vụ, tự suy ra tự nối · 3 bẫy (cặp đảo chiều, đếm lặp chủ thể nhiều hồ sơ cùng sản phẩm, hồ sơ bị từ chối); hidden-1 CONS–MORT 22 so với 21 · cặp không thứ tự, mỗi chủ thể một lần → Khó 4/5 |
| aivb-j9-lai-du-thu-cho-vay-2026 (giữ mã) | Trung bình → Cơ bản | Starter còn một lỗi dễ thấy: nối `l.loan_id = ia.contract_id` (ra 0 khoản vay); bỏ hai lỗi chồng (LEFT JOIN, thiếu cận trên) và bảng nhiễu; ERD 2 bảng có giá trị mẫu, đường nối tô đỏ | 2 bảng · 1 tầng · đề ghi rõ khoảng ngày · 0 bẫy · 1 khái niệm; Sửa lỗi Cơ bản = 1 lỗi dễ thấy → Cơ bản 5/5 |
| aivb-q2-khach-co-khoan-vay-qua-han → aivb-q2-khoan-vay-co-ky-qua-han | Trung bình → Dễ | Dừng ở khoản vay (bỏ đi tiếp về chủ thể qua hồ sơ vay); ERD 2 bảng chữ trên đường nối | 2 bảng · 2 tầng (`IN (SELECT …)`) · đề ghi rõ cột, giá trị · 1 bẫy (nối thẳng lặp dòng, 67 khoản ≥ 2 kỳ quá hạn) · 1 khái niệm → Dễ 5/5 |
| aivb-q3-tien-gui-lai-cao-hon-ky-han → aivb-q3-tien-gui-lon-gap-10-binh-quan | Trung bình → Cơ bản | Thay so sánh tương quan theo kỳ hạn bằng hợp đồng có số tiền gửi lớn hơn 10 lần bình quân toàn bảng; ERD 1 bảng giá trị mẫu | 1 bảng · 1 tầng · đề ghi rõ hệ số, phạm vi · 0 bẫy · 1 khái niệm → Cơ bản 5/5 |
| aivb-q4-ho-so-de-nghi-lon-nhat → aivb-q4-ho-so-vay-dau-tien | Trung bình → Khó | Hồ sơ vay đầu tiên của mỗi chủ thể (truy vấn con tương quan `ORDER BY … LIMIT 1`, tiêu chí hoà), gom theo sản phẩm, tỷ lệ duyệt; ERD 5 bảng chỉ khoá, 4 nhiễu | 1 bảng · 4 tầng · ngôn ngữ nghiệp vụ · 3 bẫy (mã hồ sơ nhỏ nhất thay ngày sớm nhất: 4 chủ thể public, thêm OH1 ở hidden-1; tìm theo cặp chủ thể–sản phẩm; không tương quan) · nhiều điều kiện → Khó 4/5 |
| aivb-q5-pheu-khach-vay → aivb-q5-pheu-khach-vay-2026 | Trung bình → Khó | Phễu khách cá nhân nộp hồ sơ năm 2026, bước 3–4 gắn đúng hồ sơ năm 2026, bước 4 trạng thái khoản vay, thêm tỷ lệ chuyển đổi so với bước liền trước (tự nối CTE); ERD 6 bảng chỉ khoá, 2 nhiễu | 4 bảng · 5 tầng · mơ hồ mức Trung bình (tên bước nêu rõ) · 4 bẫy (đếm hồ sơ, khoản vay của hồ sơ khác: 2 khách public + PH2 ở hidden-1, còn dư nợ thay trả bình thường, tỷ lệ so bước 1) · phễu nhiều điều kiện → Khó 4/5 |
| aivb-q6-lenh-lon-bat-thuong (giữ mã) | Trung bình → Cơ bản | So lệnh chuyển khoản thành công ngày 31/12/2026 với 5 lần bình quân của chính nhóm này (truy vấn con một giá trị, 1 bảng); bỏ bảng dẫn xuất theo loại giao dịch; hệ số 5 vì hệ số 10 cho cùng 14 lệnh ở hai biến thể | 1 bảng · 1 tầng · đề ghi rõ ba điều kiện và hệ số · bẫy quên điều kiện trong truy vấn con (như mẫu w1) · 1 khái niệm → Cơ bản 5/5 |

Kiểm lại:
- Bộ kiểm đầy đủ cả gói (`--ra cong-cu/ket-qua/cap-do/aivb-goi-3`, MySQL `sqllb-mysql`, public + hidden-1): **KIEM TRA: 0 loi**, 0 cảnh báo; 20 câu, 72 khối SQL; mọi wrong mới rớt ở public và hidden-1 (j8 wrong 1 chỉ rớt hidden-1, như cũ).
- Kết quả public ≠ hidden-1 ở cả 9 câu viết lại: j3 62/63 dòng, j5 MORT 1 khoản lệch, j6 CONS–MORT 21/22, j9 tổng lãi khác (H(a)), q2 93/94, q3 46/45, q4 CONS, MORT, WC_LOAN khác, q5 bước 1–2 khác, q6 69/64.
- Thời gian solution (lúc kiểm): mọi câu dưới 1,2 giây (j5 1,16 giây; j8 0,9 giây; q4 0,15 giây; q6 0,11 giây). Cách giải tự nhiên (truy vấn con tương quan có chỉ mục `party_id`, CTE gom trước khi nối) cùng cỡ.
- Thư mục gói vẫn đúng 4 file.

Ô trùng: trong gói không trùng (dạng × mảng × cấp × hình thức). Ngoài gói: q2 (A1 · after_sales · easy · write) trùng ô aivb-n3 (gói 1, M2, kỹ năng khác). Các ô mới khác (E2 operations hard, A4 sales hard, C1 sales hard, D1 customer hard, A1 finance basic write, A2 finance basic debug, C3 sales basic, E1 operations basic) chưa có trong `BAN-DO-100-CAU.md` lúc sửa; agent khác đang sửa song song nên có thể trùng sau.

`BAN-DO-100-CAU.md`: sửa 9 dòng của câu viết lại và dòng j8 (tiêu đề, phạm vi ngày 31/12/2026 theo chuẩn hoá 10/11). Phần thống kê cuối file chưa sinh lại.

## Sửa theo KIEM-V4 (11/11/2026)

Căn cứ `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`. Không đổi SQL, cấp, mã.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| aivb-q3-tien-gui-lon-gap-10-binh-quan | C: dòng quyết định "Nhận diện các khoản tiền gửi lớn để giao chuyên viên chăm sóc riêng." không khớp phạm vi "mọi trạng thái" | → "Đặt ngưỡng nhận diện tiền gửi lớn cần báo cáo riêng, dựa trên các hợp đồng lớn ngân hàng từng nhận." | Chỉ sửa chữ |
| aivb-q2-khoan-vay-co-ky-qua-han | B (góp ý): câu cuối `\ghichuthietke` nói trùng ô với n3 đã cũ | Xoá câu "Ô A1 after\_sales easy write trùng aivb-n3 (gói 1)…" (n3 nay là Khó) | Chỉ sửa chữ |
| aivb-j3-so-du-tai-khoan-mo-thang-12-2025 | B (góp ý): lẫn "số dư hiện tại" / "số dư chốt" | Lời nhắn → "kèm số dư chốt của từng tài khoản" | Chỉ sửa chữ |

Kiểm cả gói: bộ kiểm đầy đủ `cong-cu/ket-qua/sua-v4/aivb-goi-3`: KIEM TRA: 0 loi; biên dịch `cong-cu/ket-qua/sua-v4/aivb-goi-3/bien-dich`: 54 trang, 0 lỗi LaTeX.
