# REVIEW-B · bộ `jelly` · gói 1

Người kiểm B · 10/11/2026 · các câu thứ 1, 3, 5, …, 19 theo thứ tự trong `cau-hoi.tex` (10 câu, kể cả case c1).
Đã làm đủ 6 bước của `BRIEF-KIEM-GOI.md`. Bộ chuẩn: `style/STYLE-jelly.md` (kế thừa khuôn cấm STYLE-scm mục C). Dữ liệu: `mysql/README-jelly.md`.
Chạy trên `sqllb-mysql`, user `sql_runner`, CSDL `jelly` và `jelly_hidden_1`. Nháp, SQL tự giải và kết quả từng khối: `cong-cu/ket-qua/review/jelly-goi-1-B/` (`my/` bài tự giải, `blk/` từng khối của `solution.sql`, `cmp.sh` so kết quả).

## Tóm tắt kiểm SQL (bước 1–3)

| Mã | Bài tự giải so với solution (public / hidden-1) | Số dòng solution (public / hidden-1) | Starter, wrong |
|---|---|---|---|
| r1 | khớp / khớp | 38 / 32 | 2 wrong rớt cả hai biến thể |
| r3 | khớp / khớp | 4 / 4 (hai biến thể giống hệt) | 2 wrong rớt cả hai biến thể |
| r5 | khớp / khớp | 20 / 20 | 2 wrong rớt cả hai biến thể |
| r7 | khớp / khớp | 68 / 64 | starter rớt (3.219 dòng); `ngoac_sai_cho` ra **đúng y starter** (3.219 / 2.924 dòng) |
| r9 | khớp / khớp | 5 / 5 | starter rớt; 2 wrong rớt; không wrong nào kiểm tiêu chí phụ |
| n2 | khớp / khớp | 20 / 20 | 2 wrong rớt cả hai biến thể |
| n4 | khớp / khớp | 7 / 7 | 2 wrong rớt cả hai biến thể |
| n6 | khớp / khớp | 1 / 1 (33.125 · 6.599 ở public) | `lam_tron_truoc_khi_so` ra 10.540; `thieu_can_tren` ra 79.628 · 15.156; rớt cả hai |
| n8 | khớp / khớp | 7 / 7 | starter rớt; 2 wrong rớt (làm tròn 2 chữ số lệch > 0,0001) |
| c1.b1 | khớp / khớp | 2 / 2 | 2 wrong rớt cả hai biến thể |

Không có câu nào chấm oan, không có solution sai. Đã kiểm thêm: `event_date` của `sessions` luôn bằng `DATE(session_start)` (0 dòng lệch); ngày cài sớm nhất 2026-07-01 và DAU ngày 1/7 bằng số người chơi mới (215 = 215), nên câu n4 gọi 1/7 là ngày ra mắt là hợp lý; số trong phương án c1 khớp kết quả (lượt xem có tặng thưởng gấp 8,07 lần, chiếm 89,1% doanh thu quảng cáo; doanh thu trên 1.000 lượt 5,97 và 5,90 USD; ở hidden-1 là 89,1%, 5,97 và 5,87 USD, kết luận vẫn đúng).

## Bảng kiểm

| Mã | Phiên bản | Kiểm SQL | Kiểm nội dung | Đề xuất sửa cụ thể (trích nguyên văn → câu sửa) |
|---|---|---|---|---|
| jelly-r1-cai-moi-29-8-vn | v1 | **Đạt.** Solution khớp bài tự giải ở hai biến thể; hai wrong là lỗi hay gặp, rớt cả hai biến thể. | **Đạt.** Lời nhắn tự nhiên, đúng vai; tab Nghiệp vụ không lộ kết quả; cấp Cơ bản, Module 1 đúng. | Không bắt buộc. (1) `\luuy` liệt kê sẵn \code{'VN'} nên bài sai \code{'Vietnam'} và gợi ý 1 gần như mất tác dụng: "Cột \code{country} lưu mã quốc gia hai chữ cái (\code{'VN'}, \code{'US'}, \code{'GB'}), không lưu tên nước." → "Cột \code{country} lưu mã quốc gia hai chữ cái, không lưu tên nước." (2) Đợt chạy thử đã diễn ra ngày 29/8 nên mục đích nên ở thì đã xảy ra: "Chọn người chơi nhận lời chào mừng trong đợt chạy thử." → "Lập danh sách người chơi đã nhận lời chào mừng mới để theo dõi phản hồi." |
| jelly-r3-man-sieu-kho | v1 | **Cần sửa.** Solution đúng, hai wrong rớt. Nhưng `yeucau` đã cho sẵn giá trị \code{'super_hard'}, nên \code{LIKE '%hard%'} và \code{<> 'normal'} không còn là lỗi hay gặp. Ngoài ra `level_metadata` của hidden-1 giống hệt public, kết quả chỉ 4 dòng: học viên chép kết quả Chạy thử (ví dụ \code{WHERE level_id IN (15, 31, 46, 60)}) vẫn qua. | **Đạt.** Câu chữ tự nhiên, không lộ kết quả. Lời nhắn có một chữ khẩu ngữ (xem cột sửa). | (1) "Xét các màn có nhãn độ khó (\code{difficulty_tag}) là \code{'super_hard'}." → "Xét các màn có nhãn độ khó (\code{difficulty_tag}) là siêu khó." (giữ `\luuy` liệt kê ba giá trị; khi đó hai bài sai mới là lỗi thật). (2) Ghi rủi ro chép kết quả vào `\ghichuthietke`, hoặc nhờ người dựng dữ liệu đổi nhãn một màn \code{'hard'} thành \code{'super_hard'} trong `jelly_hidden_1` (cần kiểm ảnh hưởng tới câu khác dùng `difficulty_tag`). (3) Tuỳ chọn: "Trước khi làm thế giới mới" → "Trước khi thiết kế thế giới mới". |
| jelly-r5-luot-dai-man-30 | v1 | **Đạt.** Solution khớp; tiêu chí phụ \code{attempt_id} cần thiết (hạng 8–9, 10–12 có lượt bằng thời lượng). Ghi chú: `yeucau` đã nêu tên cột \code{app_version} nên bài sai `phien_ban_luc_cai` khó xảy ra, vẫn chấp nhận. Cấp Dễ chỉ hơn Cơ bản ở \code{LIMIT} và tiêu chí phụ, chấp nhận trong phạm vi Module 1. | **Cần sửa** (dịch máy). | (1) "dựng lại tình huống" (`\boicanh`) và "dựng lại lỗi" (`nghiepvu`) dịch chữ "reproduce" → "tái hiện lỗi". (2) Lời nhắn thiếu lời nhờ: "Chị cần hai mươi lượt chơi lâu nhất trên bản này để dựng lại tình huống." → "Em lấy giúp chị hai mươi lượt chơi lâu nhất trên bản này để nhóm tái hiện lỗi." (3) "Chọn lượt chơi để nhóm QA dựng lại lỗi trên đúng phiên bản." → "Chọn lượt chơi để nhóm QA tái hiện lỗi trên đúng phiên bản." |
| jelly-r7-organic-ios-tuan-dau | v1 | **Cần sửa.** Solution đúng, starter sai đúng chỗ (thiếu ngoặc). Bài sai `ngoac_sai_cho` (\code{(... AND channel = 'Organic') OR channel = 'Search Ads'}) tương đương logic với starter, ra đúng 3.219 / 2.924 dòng như starter, nên không kiểm thêm lỗi nào. | **Cần sửa** (lời nhắn lệch yêu cầu; gợi ý dịch máy). | (1) Lời nhắn nói một kênh, yêu cầu là hai kênh: "cài tuần đầu tháng 7 qua kênh tìm kiếm" → "cài tuần đầu tháng 7, tự tìm thấy game hoặc qua quảng cáo tìm kiếm". (2) Thay `ngoac_sai_cho` bằng lỗi người mới hay mắc khi sửa \code{OR}: \code{AND channel = 'Organic' AND channel = 'Search Ads'} (ra 0 dòng, rớt public). (3) `\goiy`: "Điều kiện \code{channel = 'Search Ads'} đang đứng riêng với những điều kiện nào?" → "Điều kiện \code{channel = 'Search Ads'} đang được ghép với các điều kiện còn lại như thế nào?" |
| jelly-r9-phien-dai-15-8 | v1 | **Cần sửa.** Solution đúng; starter có hai lỗi như ghi chú (hạng 5 ở public có hai phiên 41 phút: \code{jta_session_00091221}, \code{jta_session_00107599}). Câu khai báo `bay=thieu-tieu-chi-phu` nhưng không wrong nào kiểm tiêu chí phụ. Hai wrong hiện có không phải lỗi hay gặp: starter đã lọc \code{event_date} đúng nên học viên không có lý do đổi sang \code{session_start = '2026-08-15'}; sắp theo giờ mở phiên cũng không liên quan tới lỗi của starter. | **Cần sửa** (tiêu đề tự mâu thuẫn). | (1) Thêm wrong \code{ORDER BY duration_minutes DESC, session_id DESC} (tiêu chí phụ ngược chiều): rớt public ở hạng 5 và rớt hidden-1 ở hạng 3–4 (hai phiên 41 phút đổi chỗ). Bỏ hoặc giữ làm phụ `loc_thoi_diem_bang_ngay`. (2) `\tieude`: "Năm phiên dài nhất ngày 15/8 lại là phiên ngắn" → "Danh sách phiên dài nhất ngày 15/8 toàn phiên vài phút". |
| jelly-n2-chua-tiep-xuc-ab | v1 | **Đạt.** Solution khớp; hai wrong rớt; 20 dòng đầu ở hidden-1 khác public. | **Cần sửa** (lẫn ba cách gọi cho một khái niệm). Nghiệp vụ đúng: người chưa tiếp xúc vẫn thuộc nhánh được chia. | Trong một câu dùng "chưa từng thấy ưu đãi" (`\boicanh`), "chưa gặp ưu đãi" (`\tieude`, `\luuy`), "chưa tiếp xúc ưu đãi" (`yeucau`). STYLE A.4 chọn "tiếp xúc". Sửa: `\tieude` "Ai được chia nhánh nhưng chưa gặp ưu đãi?" → "Ai được chia nhánh nhưng chưa tiếp xúc ưu đãi?"; `\luuy` "Người chơi chỉ gặp ưu đãi khi … Người chưa gặp ưu đãi vẫn thuộc nhánh được chia." → "Người chơi chỉ tiếp xúc ưu đãi khi … Người chưa tiếp xúc ưu đãi vẫn thuộc nhánh được chia." Lời nhắn giữ "chưa thấy ưu đãi" được (khẩu ngữ), bỏ chữ "từng". |
| jelly-n4-tong-doanh-thu-ngay | v1 | **Đạt.** Solution khớp; hai wrong rớt cả hai biến thể. | **Cần sửa** (giọng AI nhẹ, câu lủng củng). Ghi chú cấp/dạng: `\ghichuthietke` nói gắn `dang=B1` "để không trùng ô"; dạng nên theo kỹ năng của câu chứ không theo ô trống. Chuỗi 7 ngày vẫn chấp nhận được là B1. | `\luuy`: "Tỷ trọng là phần của một thành phần trong tổng, nên mẫu số là tổng doanh thu, không phải doanh thu IAP." (lặp "phần", khuôn "X, không phải Y") → "Tỷ trọng quảng cáo là phần doanh thu quảng cáo trong tổng doanh thu, nên mẫu số là tổng doanh thu IAP và quảng cáo." |
| jelly-n6-ngay-choi-khong-doanh-thu | v1 | **Đạt.** Solution khớp; hai wrong là lỗi thật, rớt cả hai biến thể. | **Cần sửa** (dịch máy). | (1) `yeucau`: "Đếm tổng số ngày chơi, và số ngày chơi có doanh thu IAP (\code{iap_revenue}) cộng doanh thu quảng cáo (\code{ad_revenue}) bằng 0." (phẩy trước "và", trật tự "có A cộng B bằng 0" theo tiếng Anh) → "Đếm tổng số ngày chơi và số ngày chơi có tổng doanh thu IAP (\code{iap_revenue}) và doanh thu quảng cáo (\code{ad_revenue}) bằng 0." (2) `\boicanh`: "có bao nhiêu ngày chơi của người chơi không đem lại doanh thu nào, kể cả từ quảng cáo" → "có bao nhiêu ngày chơi không đem lại đồng doanh thu nào, kể cả doanh thu quảng cáo". |
| jelly-n8-ty-le-sai-chia | v1 | **Đạt.** Solution khớp; starter sai đúng chỗ (thiếu ngoặc); hai wrong rớt với `saiso=0.0001`. | **Cần sửa** (lời nhắn mơ hồ, tiêu đề thiếu giới từ). | (1) `\boicanh`: "Em tính lại ARPDAU tuần từ 15/8 tới 21/8" đọc được là một số ARPDAU cho cả tuần, trong khi yêu cầu tính từng ngày → "Em tính lại ARPDAU từng ngày từ 15/8 tới 21/8". (2) `\tieude`: "ARPDAU tự tính lệch cột có sẵn" → "ARPDAU tự tính lệch với cột có sẵn". |
| jelly-c1-quang-cao-co-thuong | v1 | **Đạt.** b1 khớp; hai wrong rớt cả hai biến thể; phương án đúng vẫn đúng ở hidden-1. Ghi chú module: b1 cần \code{GROUP BY}, \code{SUM}, vượt kỹ năng Module 1–2 của gói; nhờ người soạn xác nhận vị trí case trong lộ trình. | **Cần sửa** (lẫn tiếng Anh). Nghiệp vụ đúng (định nghĩa hai loại quảng cáo khớp AdMob); ba phương án dài gần bằng nhau, không lộ đáp án. | Lời giải thích phương án đúng: "còn doanh thu trên 1.000 lượt của hai loại chỉ chênh vài cent." → "còn doanh thu trên 1.000 lượt của hai loại chỉ chênh chưa tới 0,1 USD." |

**Kết quả:** 1 câu Đạt (r1) / 9 câu Cần sửa (r3, r5, r7, r9, n2, n4, n6, n8, c1).
Trong 9 câu Cần sửa: 3 câu có lỗi SQL/thiết kế bài sai (r3, r7, r9), 8 câu có lỗi câu chữ (r5, r7, r9, n2, n4, n6, n8, c1). Không có lỗi nặng loại chấm oan, solution sai, wrong không rớt hay lộ kết quả.

## Giọng văn

Số chỗ trên 10 câu được giao:

| Loại | Số chỗ | Vị trí |
|---|---:|---|
| Giọng AI | 1 | n4 `\luuy` ("phần của một thành phần …, không phải doanh thu IAP") |
| Dịch máy | 6 | r5 "dựng lại tình huống", "dựng lại lỗi"; r7 `\goiy` "đứng riêng với"; r9 `\tieude` "lại là phiên ngắn"; n6 `yeucau` trật tự câu; n6 `\boicanh` "ngày chơi của người chơi" |
| Lệch thuật ngữ, lẫn cách gọi | 3 | n2 thấy / gặp / tiếp xúc ưu đãi; c1 "cent"; r7 "kênh tìm kiếm" cho hai kênh Organic và Search Ads |
| Câu mơ hồ | 1 | n8 "ARPDAU tuần" |

Không thấy câu khẩu hiệu, ẩn dụ cấm, dấu gạch dài, "Hãy…", "Với mỗi…" hay "không chỉ… mà còn" trong 10 câu.

Khuôn lặp trên nhiều câu của gói (cần người soạn đổi bớt cho cả gói, không chỉ phần B):
1. Lời nhắn của thực tập sinh cùng một khuôn "Em [làm X] …, mà/nhưng [kết quả lạ]. Anh chị xem giúp em.": r7, r9, n8 (phần B) và n7, n9 (phần C), 5/5 câu Sửa lỗi có người hỏi là thực tập sinh. Gợi ý đổi câu kết, ví dụ "Anh chị chỉ giúp em chỗ sai.", "Em gửi truy vấn đây, nhờ anh chị xem lại.", hoặc bỏ câu nhờ khi ý đã rõ.
2. Mục đích tab Nghiệp vụ mở bằng "Chọn …": r1, r3, r5, r7, r9 (phần B) và r4, r6, n1 (phần C), 8/20 câu. Gợi ý đổi động từ theo việc thật: "Lập danh sách …", "Xác định …", "Quyết định …".
3. Nối hai vế bằng "mà" kiểu khẩu ngữ trong lời nhắn: r7 "mà danh sách có cả…", n8 "mà số em tính…" (thêm n7, n9 ở phần C). Một hai câu thì tự nhiên, năm câu liền thì thành khuôn.
