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
