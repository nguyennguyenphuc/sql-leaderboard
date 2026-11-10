# Đã sửa · gói 5 GAME Jelly Trail Academy (jelly) · v2

Theo REVIEW-B.md, REVIEW-C.md (10/11/2026). Không đổi `ma`, không sửa database.
- **Kiểm lại SQL** (k2, p3, p7, p9): chạy trên gói tạm `cong-cu/ket-qua/sua/jelly-goi-5/`, kết quả **KIEM TRA: 0 loi**.
- **Kiểm tĩnh cả gói** (`--chi-phan-tich`): **0 lỗi**.
- **Biên dịch** (`cong-cu/ket-qua/bien-dich/jelly-goi-5/`): 57 trang, **0 lỗi LaTeX**, 0 ký tự thiếu.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| jelly-k1-trung-khoa | Đổi tiêu đề thành "Hai bảng nguồn… có dòng ghi trùng không?". Bỏ chữ "bảng" khỏi lời nhắn và đổi câu kết. Bỏ nhãn `:PK` ở hai bảng cần kiểm. `\ghichuthietke` ghi rõ giới hạn: bài viết hằng số vẫn qua. | tĩnh |
| jelly-k2-mo-coi | **Đổi phạm vi kiểm** vì v1 có 0 dòng mồ côi ở cả hai biến thể. Nay kiểm giao dịch gắn màn (`level_id_if_relevant`) không có lượt chơi đúng màn trong cùng phiên; có dòng thiếu cặp thật ở public và hidden-1. Viết lại tiêu đề, bối cảnh (có lời nhờ), yêu cầu, ERD, khái niệm `dong-mo-coi`. Ba bài sai mới đều là lỗi thật: nối thẳng gây nhân dòng, nối thiếu cột màn, INNER JOIN làm mất dòng thiếu cặp. | gói tạm: 0 lỗi, 3 wrong rớt public + hidden-1 |
| jelly-k3-cohort-day-kiem | Sửa lời nhắn theo B ②③. Sửa `\luuy` "tự so với chính nó" thành "không so hai cột trong cùng một bảng". Không sửa database, nên `\ghichuthietke` ghi rõ câu chỉ chấm được `so_dong_kiem` và lỗi đảo `DATEDIFF`. | tĩnh |
| jelly-k4-max-level-giam | **Hạ xuống medium.** ERD 3 bảng có 1-n. Tiêu đề bỏ ẩn dụ "đi lùi". Yêu cầu bỏ "Với mỗi…" và đại từ "nó". `\goiy` 1 không còn đưa sẵn biểu thức đầy đủ. Đổi câu kết của lời nhắn. | tĩnh (SQL không đổi) |
| jelly-k5-extra-moves-doi-soat | Bỏ `booster_events` khỏi ERD, còn 2 bảng nhiễu. Sửa `\luuy` "làm mỗi dòng bị nhân lên". | tĩnh |
| jelly-k6-ad-revenue-lam-tron | Yêu cầu định nghĩa rõ "ngày-người" và chỉ xét ngày-người có xem quảng cáo, trên toàn bộ dữ liệu. `so_ngay_nguoi_doi_soat` ghi là "số ngày-người được ghép". Lời nhắn bỏ "cuối tháng" và nói rõ ngưỡng. Sửa `\luuy`. ERD còn 2 bảng nhiễu. Cách diễn giải ngưỡng: xem mục Chờ giảng viên. | tĩnh (SQL không đổi, đã khớp định nghĩa mới) |
| jelly-k7-bat-thuong-chi | Đổi "tiêu" thành "chi". `\goiy` bỏ "Nó". Viết lại `\luuy`, bỏ giọng tuyệt đối. Yêu cầu và khái niệm `ngoai-lai` đổi thành "cộng thêm hai lần độ lệch chuẩn". Đổi câu kết. `\ghichuthietke` ghi giới hạn: kết quả public và hidden-1 giống nhau. | tĩnh |
| jelly-k8-hoan-tien | Thêm vào `\ghichuthietke` rằng bài ghi hằng `tien_hoan = 0` cũng qua. | tĩnh |
| jelly-k9-phien-hai-dang-ma | Nghiệp vụ đổi "mọi kênh" thành "cả hai nền tảng". Viết lại định nghĩa "vào thẳng phần hướng dẫn". Đổi "hai lỗi chồng nhau" thành "hai lỗi". Sửa lời nhắn (bỏ chữ "vào" lặp). Câu `\luuy` lộ lỗi 1 chuyển sang `\goiy`. ERD còn 2 bảng nhiễu. | tĩnh |
| jelly-p1-dem-ket-qua-mot-lan | **Hạ xuống easy.** ERD 2 bảng, có chữ trên đường nối. Tiêu đề thành câu nghiệp vụ. Lời nhắn bỏ "Nó" và nghĩa kép của "bảng". Yêu cầu bỏ "với mỗi". Bỏ khái niệm `ty-le-thang-man`. | tĩnh (SQL không đổi) |
| jelly-p2-doanh-thu-hai-nguon | **Hạ xuống easy** (đúng khung CHOT). ERD 2 bảng có chữ trên đường nối. `ad_type` thống nhất gọi là "định dạng quảng cáo". Đổi tiêu đề. | tĩnh |
| jelly-p3-tren-tb-the-gioi | **Siết `ngansach` từ 2 xuống 1,5.** Số đo: khởi đầu 705.721 dòng, lời giải 352.965 dòng, nên khởi đầu nay vượt cả ngân sách lẫn số lần quét. Người hỏi đổi sang Data engineer. Tiêu đề thành câu nghiệp vụ. Thêm khái niệm `ty-le-thua` thay cho `ty-le-thang-man`. Viết lại `rangbuoc`. ERD còn 2 bảng nhiễu. `\ghichuthietke` ghi rằng cách CTE + JOIN cũng được chấp nhận. | gói tạm: 0 lỗi |
| jelly-p4-luy-ke-tu-noi | Lời nhắn đổi sang Data engineer, chỉ tả triệu chứng, không gọi tên cú pháp. Sửa `rangbuoc` "2 lần số dòng trung gian…". ERD còn 2 bảng nhiễu. | tĩnh |
| jelly-p5-nguoi-tra-tien-exists | Sửa tiêu đề "theo kênh cho nhẹ hơn". Tách câu dài trong lời nhắn. Sửa `rangbuoc`. | tĩnh |
| jelly-p6-dau-tu-sessions | **Hạ xuống medium.** ERD 3 bảng có 1-n. Sửa tiêu đề "chỉ với một lần đọc". Đổi câu kết. | tĩnh (SQL không đổi) |
| jelly-p7-index-ngay | **Bối cảnh v1 sai dữ liệu** (ngày 20/8 không có sự kiện). Đổi sang ngày 10/8, trong đợt Licorice Rescue 8–12/8. **Đổi sang optimize easy** để ràng buộc chỉ mục chấm được: khởi đầu `DATE(event_time) = …` đọc cả bảng (254.792 dòng), lời giải dùng `idx_attempts_date` (5.015 dòng), `ngansach=2`. Thêm bài sai vẫn bọc hàm, vượt ngân sách. Người hỏi đổi sang Data engineer. | gói tạm: 0 lỗi, khởi đầu vi phạm ngân sách, 3 wrong rớt |
| jelly-p8-ham-tren-cot | Sửa lời nhắn đúng triệu chứng của starter: MAU bằng đúng số ngày-người, mức độ gắn bó hai tháng bằng nhau, DAU bình quân tháng 8 thấp. Đổi tiêu đề thành "ra sai". Bỏ yêu cầu dùng chỉ mục (không chấm được), chuyển ý này vào `\goiy`. Giải nghĩa "ngày-người". Bỏ `\luuy` lộ lỗi. ERD còn 2 bảng nhiễu. | tĩnh (SQL không đổi) |
| jelly-p9-select-distinct-thua | **Lệch module:** đổi sang optimize medium, giữ mã. Khởi đầu lấy danh sách người chơi bằng `SELECT DISTINCT user_id FROM player_daily` thừa, nên đọc khoảng 80 nghìn dòng. `ngansach=1,3`, theo số đo khởi đầu 117.855 so với lời giải 74.790. Người hỏi đổi sang Data engineer. Bỏ "IAP" trong lời nhắn và "nó" ở `\luuy`. | gói tạm: 0 lỗi |
| jelly-c9-ab-mua-them-buoc | Bốn phương án viết thành câu liền, bỏ dấu hai chấm. Phương án đúng rút còn một câu. Sửa giải thích phương án 1 ("đã thua ít nhất một lần"). Đổi câu kết của lời nhắn. ERD còn 2 bảng nhiễu. Nguồn chỉ số chính: xem mục Chờ giảng viên. | tĩnh (SQL không đổi) |
| jelly-c10-man-28-30 | **Tách hai từ:** "sự cố" chỉ dùng cho crash, "vụ việc" cho việc màn 28–30 bị chỉnh quá khó (bối cảnh, nghiệp vụ, phương án; thêm `\luuy` định nghĩa). Viết lại giải thích phương án 3, bỏ suy diễn nhân quả. Thống nhất cách gọi "được mời thêm lượt đi" / "nhận thêm lượt đi". Thêm khái niệm `ty-le-thua`. ERD còn 2 bảng nhiễu. | tĩnh (SQL không đổi) |

Khuôn lặp đã phá:
- **Câu kết "Em … giúp chị/anh"**: khoảng một nửa số câu đã đổi cách kết (k1, k4, k7, k9, p2, p6, c9…).
- **Đại từ "nó" chỉ vật**: đã bỏ ở k2, k4, k7, p1, p3, p9.
- **ERD cấp Khó nhiều bảng nhiễu**: đã đưa về 1–2 bảng nhiễu.
- **Tiêu đề câu tối ưu nêu kỹ thuật**: đã đổi ở p1, p3 thành câu nghiệp vụ.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **k3, k7 – không chấm thật được** (trước ở mục Chờ giảng viên, mục 4): `mysql/jelly/04_bo_sung_bien_the_jelly.sql` (h), (i). Chạy solution trên `jelly` và `jelly_hidden_1` (user `sql_runner`): k3 ra 1 ở cột lệch `cohort_day` và lệch ngày cài (dòng `jta_user_003773` ngày 24/8 ghi ngày cài 14/7, `users` ghi 15/7), bài so hai cột trong `player_daily` ra 0 nên rớt; k7 ra 6 dòng thay vì 4 (Video Network thêm hai ngày chi vượt ngưỡng 11/7, 10/8). Ghi chú thiết kế đã sửa theo. k1 vẫn chờ (xem mục 4 dưới).

## Chờ giảng viên

1. **k6 – ngưỡng và cách diễn giải đối soát.** Câu đếm 243 ngày-người lệch quá 0,00005 USD, nhưng lệch lớn nhất chỉ 0,00007 USD. Phần lệch đó có thể vẫn do làm tròn từng lần xem trước khi cộng. Cần người nắm đối soát doanh thu quảng cáo chốt ngưỡng, và chốt câu này nói về "lệch thật" hay "lệch do cách làm tròn".
2. **c9 – nguồn của chỉ số chính.** `primary_metric = extra_move_purchase_per_assigned_user_d0_6`. Câu đang đo bằng giao dịch `extra_moves_pack` trong `purchases`. Nếu đo bằng cờ `level_attempts.extra_moves_purchased`, nhánh thử cao hơn khoảng 12% và kết luận đảo chiều. Ngoài ra, chênh lệch giữa hai nhánh nhỏ và chưa kiểm ý nghĩa thống kê; ở hidden-1, b3 còn đảo chiều.
3. **c10 – phương án nhiễu 1.** Phương án này nêu đúng hai sự thật về Android, chỉ sai ở kết luận "đóng vụ việc". Cần xác nhận phương án này đủ rõ là sai. Cỡ mẫu iOS ở bản 2.1.1 nhỏ (572 lượt).
4. **k1 – không chấm thật được phần cốt lõi:** đáp án là hằng số 0 dòng thừa ở cả hai biến thể (khoá chính chặn dòng trùng, file 04 không thêm dòng trùng), nên bài viết hằng vẫn qua. Muốn chấm thật cần biến thể có dòng trùng khoá (bảng không khoá chính hoặc `jelly_hidden_2`).
