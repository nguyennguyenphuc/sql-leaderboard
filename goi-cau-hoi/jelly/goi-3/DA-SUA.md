# Đã sửa · gói 3 bộ GAME Jelly Trail Academy (`jelly`) · v2

Sửa theo `REVIEW-B.md` và `REVIEW-C.md` (10/11/2026). Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/jelly-goi-3/`: chứa 7 câu đã sửa SQL hoặc yêu cầu (j4, j8, q2, q5, q8, q9, c6). Chạy thật bộ kiểm trên public và hidden-1; kết quả ở `jelly-goi-3-kq2/`.
- **Cả gói**, kiểm tĩnh (`--chi-phan-tich`): `KIEM TRA: 0 loi`.
- **Biên dịch:** 0 lỗi LaTeX; PDF ở `cong-cu/ket-qua/bien-dich/jelly-goi-3/`.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| jelly-j1-luot-choi-kem-the-gioi | (B) Đổi người hỏi sang Kỹ sư QA kiểm dữ liệu ngày cuối; đổi dòng quyết định của tab Nghiệp vụ; bỏ `\khainiem{ty-le-thang-man}`; "kỳ báo cáo" thành "cửa sổ dữ liệu" | tĩnh |
| jelly-j2-doanh-thu-theo-kenh-cai | (C) Đổi dòng quyết định thành báo cáo doanh thu IAP theo kênh, không còn chọn kênh tăng ngân sách; lời nhắn hỏi đủ số người mua và số tiền; yêu cầu viết lại thành "Tính … của từng kênh", bỏ "theo tab Nghiệp vụ" | tĩnh |
| jelly-j3-nguoi-chua-mua | (B) Ghi chú thiết kế: "điều kiện lọc bảng giao dịch (bảng bên phải) đặt trong ON"; sửa câu sai về hidden-1 (giao dịch 2026-09-01 không đổi số người chưa mua); lời nhắn "chiếm bao nhiêu phần trăm số người chơi" | tĩnh |
| jelly-j4-cpi-theo-kenh | (C) Wrong `noi_truc_tiep_nhan_dong` bỏ hằng số gõ tay, dùng đúng `CROSS JOIN` của solution, chỉ còn lỗi nhân dòng; ERD đổi nối chi phí–người chơi thành `n-n`, có chữ và tô cảnh báo; giải nghĩa CPI; "từng nhóm" thành "từng cặp kênh, nền tảng"; "đắt hay rẻ hơn"; "mỗi người chơi khớp với bao nhiêu dòng"; đổi dòng quyết định | bộ kiểm (gói tạm) |
| jelly-j5-booster-theo-the-gioi | (B) Tiêu đề "Loại vật phẩm hỗ trợ nào…"; hạ cấp xuống `easy`, ERD còn 2 bảng có chữ trên đường nối; "kỳ dữ liệu" thành "cửa sổ dữ liệu". SQL không đổi | tĩnh |
| jelly-j6-phien-co-mua | (C) Viết lại lời nhắn; thống nhất "nút cửa hàng"; viết lại yêu cầu thành "Tính … của từng màn hình vào game"; đổi dòng quyết định | tĩnh |
| jelly-j7-join-nhan-dong | (B) ERD thêm bảng `users` (nơi lấy kênh) và đường nối; "Organic" thành "kênh tự nhiên (`'Organic'`)"; đổi câu kết lời nhắn | tĩnh |
| jelly-j8-left-join-where | (C) Tab Nghiệp vụ đổi thành "chưa tới bước cuối", khớp với chỉ số đếm; `\luuy` bỏ cách sửa, thay bằng quy ước "người bỏ dở bước 5 vẫn tính là đã tới bước 5"; bỏ chữ sáo "kinh điển"; thay wrong `or_is_null_trong_where` (trùng kết quả starter) bằng `nhom_theo_nen_tang_bang_phai`; đổi câu kết lời nhắn | bộ kiểm (gói tạm) |
| jelly-j9-noi-sai-khoa | (B) "dựng lại lỗi" thành "tái hiện lỗi"; bỏ "chứa nó"; sửa luôn khái niệm dùng chung `phien-choi`; dòng quyết định "Lập danh sách…" | tĩnh |
| jelly-q1-man-thua-tren-tb | (C) Tiêu đề "Màn nào có tỷ lệ thua cao hơn mức chung của game?"; gợi ý bỏ "nó"; định nghĩa tỷ lệ thua viết thành câu, không dùng dấu hai chấm; đổi dòng quyết định | tĩnh |
| jelly-q2-nguoi-mua-season-pass | (B) Thay wrong `quoc_gia_noi_mua` (lọc nền tảng tự đặt) bằng `quen_dieu_kien_goi`, tức truy vấn con thiếu điều kiện gói; viết "thị trường (quốc gia, `users.country`)"; sửa ghi chú thiết kế và dòng quyết định | bộ kiểm (gói tạm) |
| jelly-q3-chua-qua-buoc-4 | (C) Tiêu đề "Bao nhiêu người chơi mới dừng ở bước dùng búa kẹo mút?"; "booster" thành "vật phẩm hỗ trợ"; "búa kẹo mút" khớp với `step_name`; bỏ "theo tab Nghiệp vụ"; gợi ý bỏ khuôn "với mỗi dòng"; viết lại yêu cầu thành "Tính … của từng nền tảng" | tĩnh |
| jelly-q4-ngay-dau-cao-nhat | (B) Đổi lý do sang "lượng người chơi tăng đều hay dồn về cuối tháng" và sửa dòng quyết định cho khớp; giải nghĩa DAU; bỏ `thieu-can-tren` khỏi `bay` và khỏi gợi ý 2; ghi chú thiết kế nói rõ ngày 2026-09-01 không đổi kết quả. Giữ nguyên mã | tĩnh |
| jelly-q5-roas-tren-chuan | (C) Cửa sổ doanh thu đổi sang D0--D29 (`cohort_day` từ 0 tới 29), không còn mâu thuẫn với c6; tiêu đề bỏ "hoàn vốn"; giải nghĩa ROAS; thêm quy tắc khi bằng nhau; ERD đổi thành `n-n`; wrong `ghep_hai_muc_hat` bỏ hằng 6.46, ROAS chung tính bằng truy vấn con, chỉ còn lỗi nhân dòng theo chiến dịch; wrong trung bình tỷ lệ viết gọn bằng `AVG() OVER ()` | bộ kiểm (gói tạm) |
| jelly-q6-phien-ban-dau-tien | (B) Lời nhắn và dòng quyết định nói rõ có tính cả người cài mới (cách 2 review đề xuất); gợi ý 1 bỏ khuôn "Với mỗi". SQL không đổi | tĩnh |
| jelly-q7-exists-quang-cao | (C) Tiêu đề "Đếm người xem quảng cáo có tặng thưởng lại ra số người không xem"; viết lại lời nhắn (bỏ lặp "có", thêm chủ ngữ, đổi câu kết) | tĩnh |
| jelly-q8-subquery-nhieu-dong | (B) Yêu cầu "còn đúng một dòng, là giao dịch…"; truy vấn con của solution giữ thêm `p2.country = 'VN'` cho khớp starter và gợi ý 2; đổi dòng quyết định | bộ kiểm (gói tạm) |
| jelly-q9-not-in-null | (C) Thêm cột `so_luot_choi` (lượt chơi tới hết 29/8). Hai biến thể giờ cho kết quả khác nhau; `level_attempts` có vai trò thật. Tiêu đề, yêu cầu, ERD, starter, solution, hai wrong cũ đều sửa theo; thêm wrong `thieu_can_tren` (rớt ở hidden-1) | bộ kiểm (gói tạm) |
| jelly-c5-starter-pack-giu-chan | (B) `\luuy` bỏ khuôn dạy đời; phương án đúng dùng "bình quân mua sau gần hai tuần"; lời giải thích thay câu cụt "nên đây là tương quan"; tách yêu cầu b2 thành hai `\item`; ghi chú thiết kế ghi dòng 2026-09-01 không đổi kết quả. SQL đã sửa ở v1 (wrong b1) | tĩnh |
| jelly-c6-kenh-dang-cat | (C) Wrong b2 đổi thành `mau_so_nguoi_co_doanh_thu`: giữ D0--D6, mẫu số là người có doanh thu, khớp tên lỗi; b2 nêu rõ mẫu số là số lượt cài; b3 giải nghĩa ROAS D7 và bỏ dấu hai chấm; sửa lời giải thích hai phương án; ERD đổi thành `n-n`; "Organic" thành "kênh tự nhiên" | bộ kiểm (gói tạm) |

Chung cho cả gói:
- Dòng quyết định của tab Nghiệp vụ không còn mở bằng "Chọn …".
- Câu kết lời nhắn của thực tập sinh đổi theo từng tình huống.
- "kỳ báo cáo", "kỳ dữ liệu", "trong kỳ" thống nhất thành "cửa sổ dữ liệu".
- Bỏ "theo tab Nghiệp vụ" ở cuối các mục yêu cầu.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Bẫy thiếu cận trên ở hidden-1 không bắt được ở j3, q4 và c5.b1** (trước ở mục Chờ giảng viên): `mysql/jelly/04_bo_sung_bien_the_jelly.sql` (e) thêm người chơi chưa từng mua `jta_user_001174` có phiên, lượt chơi, giao dịch Starter Pack ngày 1/9/2026 và hoạt động 1–2/9 (`daily_kpi` tháng 9 có hai ngày). Đã chạy trên `jelly_hidden_1` (user `sql_runner`) bản bỏ cận trên: j3 ra 3.276 người iOS chưa mua thay vì 3.277; q4 ra thêm dòng 1/9/2026 (DAU 2 > bình quân 1,5); c5.b1 nhóm mua 432 người thay vì 431. Cả ba nay rớt ở hidden-1; ghi chú thiết kế đã sửa theo.
- **Giao dịch `jta_txn_00002662` (Booster Bundle) có `level_id_if_relevant` rỗng** (trước ở mục Chờ giảng viên): (d) của file 04 gắn màn 58, khớp quy luật public (mọi Booster Bundle đều gắn màn).

## Chờ giảng viên

1. **q5, cửa sổ doanh thu cho ROAS:** đã đổi sang D0--D29 theo đề xuất của C. C ghi mục này là "CẦN NGƯỜI NẮM DOMAIN", nên cần giảng viên chốt cửa sổ chuẩn (D7 hay D30) cho cả bộ.
2. **Mã `jelly-q4-ngay-dau-cao-nhat` không còn khớp nội dung** (câu đã đổi sang so với bình quân tháng). Giữ mã theo quy tắc; đổi mã thành `jelly-q4-ngay-dau-tren-tb-thang` hay không là quyết định của giảng viên.
3. **j5 đã hạ từ Trung bình xuống Dễ**, lệch với bản đồ 100 câu. Module 5 vẫn có 5 câu Trung bình. Cần cập nhật `BAN-DO-100-CAU.md` (ngoài thư mục gói).
