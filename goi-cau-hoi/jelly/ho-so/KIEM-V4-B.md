# Kiểm độc lập V4 · bộ jelly · người kiểm B

Ngày 11/11/2026. Làm theo `BRIEF-KIEM-V4.md`, danh sách `KIEM-V4-DANH-SACH.md` (27 câu số lẻ). Thứ tự căn cứ: `quy_chuan/` > `QUYET-DINH-CHUNG.md` (QDC, mục 0 trước) > `style/STYLE-jelly.md` > brief. Không sửa `cau-hoi.tex`, `solution.sql`, BAN-DO, database.

Cách kiểm:
- Bước 1: đọc đề trong `cau-hoi.tex` (câu Sửa lỗi, Tối ưu đọc thêm khối `starter`), tự viết SQL rồi mới mở khối `solution`. Chạy trên `jelly` và `jelly_hidden_1` bằng `sql_runner`, so từng dòng theo vị trí cột, có xét thứ tự, sai số theo `saiso` của câu (a8 dùng 0,00001). Case: tự giải từng bước SQL.
- Bước 3: `kiem_tra_goi.py` cả 5 gói (`cong-cu/ket-qua/kiem-v4/jelly-B-goi-<k>/`) ra `KIEM TRA: 0 loi` ở cả 5 gói. Mọi `wrong` của 27 câu rớt ít nhất một biến thể. Mọi solution dưới 3 giây.
- Bước 5: đếm lại cấp từ `cau-hoi.tex`: cả 10 module đều đủ 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó.
- Nháp: SQL tự giải ở `scratchpad/kiem-jelly-B/mine/`.

## Bảng kết quả

"Tự giải khớp" là khớp trên cả hai biến thể. "Biến thể khác" là kết quả solution ở hidden-1 khác public.

| # | Mã | Gói | Cấp | Tự giải khớp? | Biến thể khác? | Cấp đúng? | Giọng văn | Kết luận · đề xuất |
|---|---|---|---|---|---|---|---|---|
| 1 | jelly-r2-goi-tam-trung-chau-my | 1 | medium (write) | Khớp (32 / 30 dòng) | Có | Đúng: 3/5 trục TB (tra nhóm gói ở tab Nghiệp vụ, 2 bẫy, điều kiện theo thời điểm có giờ); khớp bài TB M1 của `data.js` (`IN`, `BETWEEN`). ERD 3 bảng ký hiệu n-1 | Khuôn lặp: lý do "gửi quà cảm ơn" trùng t3 (gói 4, cùng vai Quản lý doanh thu, cùng v4) | **Cần sửa (nhẹ)**. Xem mục A.1 |
| 3 | jelly-r6-su-kien-ky-14-ngay | 1 | medium (write) | Khớp (2 / 3 dòng) | Có | Đúng: tự tính ngày cuối kỳ, tự suy ra điều kiện giao hai khoảng ngày từ tab Nghiệp vụ, 2 bẫy, điều kiện theo thời điểm. Khác độ khó thật so với bản Cơ bản cũ | Đạt | **Đạt**. Góp ý (không bắt buộc): dòng 215 `\erdnoi[kieu=1-n]{liveops_events.start_date}{daily_kpi.date}` vẽ như khoá bằng nhau theo `start_date`, trong khi sự kiện ứng với cả khoảng ngày; đổi nhãn đường nối thành `tren={ngày trong khoảng start\_date -- end\_date}` cho đúng nghĩa |
| 5 | jelly-r9-phien-ios-ban-cu | 1 | hard (debug) | Khớp (21 / 22 dòng) | Có | Đúng: dòng Sửa lỗi Khó (3 lỗi chồng nhau, lỗi ngày cuối chỉ lộ ở hidden-1), đúng khuôn bài Khó M1 của `data.js` (`r6-don-dang-xu-ly`: `NOT IN`, thứ tự AND/OR). ERD 5 bảng chỉ khoá, `\erdkhoa` | Đạt. Starter ra 7.119 dòng, khớp "hàng nghìn dòng" | **Đạt** |
| 7 | jelly-n3-nhom-luot-di-du | 1 | easy (write) | Khớp (83 / 70 dòng) | Có | Đúng: Dễ M1–3 = Cơ bản + 1 bẫy (thứ tự nhánh `CASE`) | Đạt | **Đạt**. Trùng ô A3 · operations · easy · write với j5 (khác gói, BAN-DO cho phép). Nếu muốn bỏ trùng: đổi `dang=A3` → `C4` (chia lượt chơi thành nhóm theo số lượt đi dư là phân khúc; ô C4 · operations · easy · write đang trống) và sửa BAN-DO dòng 33, 227 |
| 9 | jelly-n6-ty-trong-iap-man-28-30 | 1 | medium (write) | Khớp (1 dòng) | Có (1,18 / 1,24) | Đúng: 2 tầng, phạm vi "phần còn lại" ở tab Nghiệp vụ, bẫy `NOT BETWEEN` bỏ ô trống thật, công thức 2 thành phần | Đạt | **Đạt** |
| 11 | jelly-n8-ty-le-su-co-tron-chuc | 1 | hard (debug) | Khớp (7 / 10 dòng) | Có | Đúng: 3 lỗi chồng nhau gồm sai định nghĩa chỉ số (chia DAU), lỗi ngày cuối chỉ lộ ở hidden-1. Starter ra đúng triệu chứng "10,00 … 0,00" | Đạt | **Đạt** |
| 13 | jelly-c1-quang-cao-co-thuong | 1 | basic (case) | Khớp b1 | Có | Đúng: case Cơ bản 2 bước, `GROUP BY` một cột (QDC 1.2) | Đạt. Kết luận "Đúng: " 29 tiếng; "gấp khoảng tám lần" (8,07), "chênh chưa tới 0,1 USD" (0,07; hidden 0,094) đúng ở cả hai biến thể | **Đạt** |
| 15 | jelly-s4-lan-mua-dau-sau-cai | 2 | medium (write) | Khớp (3 dòng) | Có | Đúng: 2 bảng, 3 tầng, 2 bẫy, điều kiện theo thời điểm | Đạt | **Đạt**. Wrong thiếu cận trên rớt đúng ở hidden-1 |
| 17 | jelly-s8-su-co-ba-ngay-dau | 2 | medium (debug) | Khớp (2 dòng) | Có | Đúng: lỗi khó thấy (`ngay_phat_hanh + 2` đổi ngày thành số, bản 2.1.0 mất ngày 1/8) | Bối cảnh và tiêu đề mâu thuẫn với kết quả đúng; câu kết "Em dò mãi chưa ra chỗ sai." lặp gần nguyên văn t7 ("Em dò mãi chưa ra chỗ thiếu.") | **Cần sửa**. Xem mục A.2 |
| 19 | jelly-a3-chi-theo-kenh | 2 | basic (write) | Khớp (4 dòng) | Có (Video Network +150 USD) | Đúng: Cơ bản 5/5 trục, ERD 1 bảng giá trị mẫu | Gợi ý xếp ngược: nấc 2 (`SUM(spend_usd)`) cho ít thông tin hơn nấc 1, học viên trả 5 điểm mà không được gì thêm | **Cần sửa (nhẹ)**. Xem mục A.3 |
| 21 | jelly-a8-arpdau-thang-8-nen-tang | 2 | hard (debug) | Khớp (2 dòng, sai số 0,00001) | Có | Đúng: 2 lỗi chồng nhau, một là sai định nghĩa chỉ số (MAU thay tổng DAU), một chỉ lộ ở hidden-1 | Đề mơ hồ ở cận trên (xem A.4) | **Cần sửa**. Bài thêm cận `activity_date <= '2026-08-29'` theo câu "Dữ liệu hiện có tới hết ngày 29/8" khớp public nhưng rớt hidden-1 (Android 3.611,88 thay vì 3.616,87; dòng 30/8 của `jta_user_000648`, file 04 mục j). Xem mục A.4 |
| 23 | jelly-j1-luot-choi-kem-the-gioi | 3 | basic (write) | Khớp (20 dòng) | Có | Đúng: Cơ bản của Joins theo `data.js` `j1` (2 bảng là tối thiểu); ERD 2 bảng có giá trị mẫu, chữ trên đường nối | Lệch thuật ngữ ở tiêu đề: "xác suất thua thiết kế" (STYLE A.2: "xác suất thua theo thiết kế") | **Cần sửa (nhẹ)**. Xem mục A.5 |
| 25 | jelly-j4-cpi-thang-8-so-muc-chung | 3 | hard (write) | Khớp (8 dòng) | Có | Đúng: 4/5 trục Khó, có 4 bẫy, bẫy thiếu cận trên chi phí chỉ lộ ở hidden-1 (dòng chi 1/9). Khác độ khó thật so với bản TB cũ | Đạt | **Đạt**. Trùng ô C3 · marketing · hard · write với s1 (gói 2, v4); xem mục C |
| 27 | jelly-q3-choi-d0-tren-tb-29-8 | 3 | basic (write) | Khớp (97 / 90 dòng) | Có | Đúng: Cơ bản của Subqueries theo `data.js` `q1`, 1 bảng, ERD giá trị mẫu | Đạt | **Đạt** |
| 29 | jelly-q5-roas-duoi-muc-chung | 3 | hard (write) | Khớp (3 dòng) | Có (mọi ROAS đổi) | Đủ Khó theo QDC 2.1 (≥ 3/5): 3 bảng, ≥ 4 tầng, đề bằng ngôn ngữ kinh doanh + `\erdkhoa`, chỉ số nhiều điều kiện; trục bẫy chỉ đạt một nửa (4 bẫy ở public, chưa có bẫy chỉ lộ ở hidden-1) | Đạt | **Đạt**, kèm khuyến nghị thêm bẫy hidden-1 ở mục B |
| 31 | jelly-q8-giao-dich-ngay-gan-nhat-gb | 3 | basic (debug) | Khớp (3 / 1 dòng) | Có (ngày gần nhất 29/8 → 30/8) | Đúng: Sửa lỗi Cơ bản (`MIN` thay `MAX`), như mẫu d1 | Đạt. Góp ý (không bắt buộc): tiêu đề dòng 536 lặp "giao dịch" hai lần; có thể viết "Giao dịch ngày gần nhất ở Anh lại rơi vào ngày 1/8" | **Đạt** |
| 33 | jelly-t3-mua-tu-3-lan | 4 | basic (write) | Khớp (29 / 25 dòng) | Có | Đúng: Cơ bản của M7 theo `data.js` `t1` (gom trong CTE, lọc ngoài) | Lý do "gửi quà cảm ơn" trùng r2 (sửa ở r2, xem A.1) | **Đạt** |
| 35 | jelly-t7-union-doanh-thu | 4 | easy (debug) | Khớp (4 dòng) | Có | Đúng: lỗi một từ khoá (`UNION` khử dòng trùng), ngang mẫu Dễ của HD mục 6 | Đạt | **Đạt** |
| 37 | jelly-f1-top3-man-quit | 4 | medium (write) | Khớp (12 dòng) | Có (hoà hạng 3 Licorice Lagoon) | Đúng: CTE + `ROW_NUMBER` + bẫy hoà chỉ lộ ở hidden-1 | Đạt | **Đạt**. Góp ý (không bắt buộc), dòng 362 gói 4: "Số lượt bỏ cuộc phản ánh số người chơi gặp khó" → "Số lượt bỏ cuộc cho biết người chơi hay bỏ dở ở màn nào" (lượt khác người); bỏ câu "Đề cần đúng ba màn mỗi thế giới." vì đã có ở yêu cầu |
| 39 | jelly-f3-luy-ke-chi-mot-chien-dich | 4 | basic (write) | Khớp (24 dòng) | Có (từ 11/7) | Đúng: Cơ bản M8 theo `data.js` `f1` (một hàm cửa sổ trên bảng đã lọc) | Đạt | **Đạt** |
| 41 | jelly-f7-rank-thay-row-number | 4 | easy (debug) | Khớp (12 dòng) | Có | Đúng: lỗi một chỗ dễ thấy (`RANK` → `ROW_NUMBER`), triệu chứng lộ ở public (starter ra 5 màn Licorice Lagoon, đã chạy lại) | Đạt | **Đạt** |
| 43 | jelly-f9-ty-trong-goi | 4 | medium (debug) | Khớp (5 dòng) | Có | Đúng theo QDC 2.2 (sai phạm vi cửa sổ là lỗi TB) và 2.3 #7; sát ranh giới | Đề mơ hồ ở cận trên; ERD có bảng trôi không đường nối | **Cần sửa (nhẹ)**. Xem mục A.6 |
| 45 | jelly-c8-doanh-thu-giam-vi-dau | 4 | hard (case) | Khớp b1–b4 (b4 hidden lệch 0,01 do làm tròn, trong sai số) | Có | Đúng: case 5 bước, hai nguồn (`daily_kpi`, `player_daily`) | Phương án đúng dài gần gấp đôi hai phương án sai (khoảng 38 tiếng so với 21–22), lộ đáp án qua độ dài | **Cần sửa (nhẹ)**. Xem mục A.7 |
| 47 | jelly-k3-cohort-day-kiem | 5 | easy (write) | Khớp (0/0 public, 1/1 hidden) | Có | Đúng: 2 bảng `JOIN`, 2 tầng, 1 bẫy; ERD 2 bảng chữ trên đường nối | Đạt | **Đạt** |
| 49 | jelly-k7-dau-doi-soat-phien | 5 | easy (debug) | Khớp (7 dòng) | Có | Đúng: Sửa lỗi Dễ (`COUNT` thay `COUNT(DISTINCT)`), ERD 2 bảng đường nối tô cảnh báo | Đạt. Starter lệch 77–166 người ở hai ngày đầu, khớp "vài trăm người" | **Đạt** |
| 51 | jelly-p6-d1-d3-d7-mot-lan-quet | 5 | basic (optimize) | Khớp (1 dòng); bài tự giải đọc `player_daily` 1 lần | Có | Đúng khuôn Tối ưu Cơ bản CHOT mục 4 (mẫu o1). Đo: starter 3 lần quét, solution 1 | Đạt | **Đạt** |
| 53 | jelly-c9-ab-mua-them-buoc | 5 | hard (case) | Khớp b1–b4 | Có | Đúng: case 5 bước, nhiều nguồn | Đạt. Kết luận "Đúng: " 30 tiếng | **Đạt**. Góp ý (không bắt buộc), dòng 654 gói 5: ở hidden-1 doanh thu D0–D6 trên mỗi người của nhánh thử nhỉnh hơn (0,2919 so với 0,2885); đổi "doanh thu D0--D6 không tăng" thành "doanh thu D0--D6 gần như không đổi" để câu đúng ở cả hai biến thể |

## A. Đề xuất sửa cụ thể (câu Cần sửa)

### A.1 jelly-r2 (gói 1)

Lý do: r2 và t3 cùng được viết lại ở v4, cùng vai Quản lý doanh thu, cùng mở bằng "gửi quà cảm ơn người chơi … mua …", tab Nghiệp vụ cùng "… người chơi nhận quà cảm ơn". Đây là khuôn lặp. Sửa r2, giữ t3 (t3 hợp lý hơn với tiêu chí "mua nhiều lần"). Đổi lý do sang đối chiếu với cửa hàng ứng dụng, cũng khớp hơn với yêu cầu trả về từng giao dịch (tiêu đề "Ai …" hỏi người, còn kết quả là giao dịch).

- Dòng 97: `\tieude{Ai ở Mỹ và Brazil mua gói tầm trung tuần cuối tháng 7?}` → `\tieude{Giao dịch gói tầm trung ở Mỹ và Brazil tuần cuối tháng 7}` (12 tiếng).
- Dòng 98, lời nhắn: "Anh định gửi quà cảm ơn người chơi ở Mỹ và Brazil đã mua gói tầm trung trong tuần cuối tháng 7. Em lập giúp anh danh sách các giao dịch đó, có cả thời điểm mua để anh đối chiếu với cửa hàng ứng dụng." → "Cửa hàng ứng dụng báo một số giao dịch gói tầm trung ở Mỹ và Brazil trong tuần cuối tháng 7 bị trừ tiền hai lần. Em lập giúp anh danh sách các giao dịch đó, có cả thời điểm mua để anh đối chiếu."
- Dòng 111: `\begin{nghiepvu}{Lập danh sách người chơi nhận quà cảm ơn sau tuần mua sắm cuối tháng 7.}` → `\begin{nghiepvu}{Đối chiếu giao dịch gói tầm trung tuần cuối tháng 7 với báo cáo của cửa hàng ứng dụng.}`
- SQL không đổi. BAN-DO dòng của r2: cập nhật tiêu đề.

### A.2 jelly-s8 (gói 2)

Lý do: sửa xong, bản 2.1.0 vẫn có tỷ lệ sự cố thấp hơn bản vá (public 4,19 so với 5,77; hidden-1 3,61 so với 6,01; số sự cố 23 so với 35). Lời nhắn hiện tại ("Số của em cho thấy bản 2.1.0 ổn hơn bản vá, mà anh Duy bên QA nhớ đợt 2.1.0 nhận nhiều phản ánh ứng dụng tự thoát nhất") và tiêu đề ("Bản 2.1.0 ít sự cố bất ngờ …") ngầm nói kết quả đúng phải cho thấy 2.1.0 tệ hơn. Học viên sửa đúng vẫn thấy 2.1.0 tốt hơn nên dễ nghĩ mình còn sai. Triệu chứng thật của starter là **số phiên** của 2.1.0 thấp bất thường (3.655 so với 5.495 khi sửa đúng; bản vá 6.070), nên dựa lời nhắn vào số phiên.

- Dòng 279: `\tieude{Bản 2.1.0 ít sự cố bất ngờ trong ba ngày đầu}` → `\tieude{Ba ngày đầu của bản 2.1.0 có ít phiên bất thường}` (11 tiếng).
- Dòng 280, lời nhắn → "Em làm báo cáo sự cố ba ngày đầu sau khi phát hành bản 2.1.0 và bản vá 2.1.1. Số phiên ba ngày đầu của bản 2.1.0 em tính ra chỉ bằng khoảng hai phần ba bản vá, anh Duy bên QA bảo không thể chênh nhiều vậy. Em kiểm lại mấy lần vẫn chưa thấy sai ở đâu." (bỏ luôn câu kết lặp với t7).
- SQL, ghi chú thiết kế không đổi.

### A.3 jelly-a3 (gói 2)

- Dòng 398–399 hiện là nấc 1 "Gom theo `channel` và cộng `spend_usd`; lọc tháng 7 có cả cận dưới và cận trên." rồi nấc 2 `SUM(spend_usd)`. Nấc 2 ít thông tin hơn nấc 1 và lặp yêu cầu ("cộng `spend_usd`").
- Đề xuất: dòng 398 → `\goiy{Tháng 7 có 31 ngày. Điều kiện ngày cần cả cận dưới và cận trên.}`; dòng 399 → `\goiy{\code{date >= '2026-07-01' AND date < '2026-08-01'}.}` (một biểu thức, QDC 1.4; viết `date` không dấu nháy ngược như gợi ý r4 ở gói 1). Hoặc bỏ hẳn dòng 399, giữ một nấc.

### A.4 jelly-a8 (gói 2) – đề mơ hồ cận trên

- Lỗi thứ hai của starter là thiếu cận trên, nên học viên phải tự thêm cận. Dòng 518 kết thúc bằng "Dữ liệu hiện có tới hết ngày 29/8." Bài thêm `activity_date <= '2026-08-29'` (hoặc `< '2026-08-30'`) đọc đúng câu này, khớp public nhưng rớt hidden-1 vì solution lấy cả ngày 30/8 (`< '2026-09-01'`). Đã chạy thử: Android 3.611,88 / 29.093 / 0,1241 so với đáp án 3.616,87 / 29.094 / 0,1243.
- Đề xuất dòng 518: "Dữ liệu hiện có tới hết ngày 29/8." → "Tháng 8 tính trọn tháng; dữ liệu dùng khi Chạy thử mới có tới hết ngày 29/8." (cùng cách nói của r8: "Dữ liệu dùng khi Chạy thử chỉ tới ngày 29/8/2026, còn báo cáo thật chạy trên dữ liệu có thêm ngày mới").
- SQL không đổi.

### A.5 jelly-j1 (gói 3)

- Dòng 94: `\tieude{Lượt chơi cuối ngày 29/8 kèm xác suất thua thiết kế}` → `\tieude{Lượt chơi cuối ngày 29/8 kèm xác suất thua theo thiết kế}` (12 tiếng, đúng thuật ngữ STYLE A.2 và cách gọi trong yêu cầu, lời nhắn của chính câu). BAN-DO dòng 72 cập nhật tiêu đề.
- Trùng ô A1 · operations · basic · write với s2 (khác gói, xem mục C). Không bắt buộc sửa.

### A.6 jelly-f9 (gói 4)

- Dòng 555: "trong tháng 8/2026 (tới hết ngày 29/8)" đọc như định nghĩa kỳ. Solution (giữ cận `< '2026-09-01'` của starter) lấy cả giao dịch 30/8 ở hidden-1. Bài đổi cận thành `<= '2026-08-29'` theo câu chữ ở ngoặc rớt hidden-1 (Booster Bundle 1.646,70 so với 1.651,69; đã chạy thử). Rủi ro thấp hơn a8 vì lỗi cần sửa không nằm ở điều kiện ngày, nhưng câu chữ nên khớp đáp án. Đề xuất: "(tới hết ngày 29/8)" → "(tính trọn tháng; dữ liệu Chạy thử có tới hết ngày 29/8)".
- Dòng 560–562 (ERD): `level_metadata` nằm trôi, không có đường nối, `purchases` không hiện cột nối. ERD Trung bình là "3–4 bảng, ký hiệu 1-n". Đề xuất: dòng 560 thêm cột `level_id_if_relevant:FK` vào `purchases`; thêm sau dòng 563 `\erdnoi[kieu=n-1]{purchases.level_id_if_relevant}{level_metadata.level_id}`.
- Bài sai `thieu_can_tren` (bỏ cận trên có sẵn trong starter) là lỗi ít gặp ở câu Sửa lỗi; không bắt buộc đổi vì đã rớt hidden-1.

### A.7 jelly-c8 (gói 4)

- Dòng 681, phương án đúng khoảng 38 tiếng, hai phương án sai (dòng 679, 683) khoảng 21–22 tiếng; độ dài lộ đáp án (QDC 1.1: phương án dài gần bằng nhau). Đề xuất dòng 681: `\phuongan*{Doanh thu giảm vì ARPDAU phần IAP giảm, do ít ngày-người trả tiền hơn và mỗi lần chi ít hơn; DAU tăng chỉ bù được một phần.}` (khoảng 27 tiếng). Lời giải thích giữ nguyên.

## B. jelly-q5 (gói 3, Khó): có đủ Khó không, bẫy hidden-1 đề xuất

**Đánh giá:** đủ Khó theo QDC 2.1 (cấp = cấp có ít nhất 3/5 trục): số bảng 3 (`users`, `player_daily`, `campaign_spend`); số bước ≥ 4 tầng (hai bảng dẫn xuất, hai mức chung, ghép, lọc); đề bằng ngôn ngữ kinh doanh, cửa sổ D0–D29 phải tự lấy từ khái niệm `roas`, cách ghép mở bằng `\erdkhoa`; nghiệp vụ nhiều điều kiện (cửa sổ ngày tuổi, chỉ kênh trả phí, mức chung gộp). Trục bẫy chỉ đạt một nửa: có 4 bẫy rớt ở public nhưng thiếu bẫy chỉ lộ ở hidden-1. Không cần hạ cấp. Tôi chỉ kiểm q5; q6 do người kiểm C nhận.

**Vì sao chưa có bẫy hidden-1 tự nhiên với chỉ số hiện tại (đã kiểm trên dữ liệu):** cửa sổ D0–D29 của người cài tháng 7 kết thúc chậm nhất 29/8, trước mọi dòng chỉ có ở hidden-1 (30/8, 1/9, 2/9). Người chơi kênh trả phí duy nhất có doanh thu sau 29/8 là `jta_user_001174` (Social Ads, cài 5/7, mua Starter Pack 0,49 USD ngày 1/9, file 04 mục e); khoản này nằm ở `cohort_day` 58, và nếu có tính vào thì ROAS Social Ads chỉ đổi khoảng 0,002 điểm phần trăm, dưới sai số 0,01. Biến thể (h) (+150 USD Video Network ngày 11/7) làm đổi số của mọi bài như nhau, không tách được bài đúng và bài sai.

**Đề xuất cụ thể (không sửa database):** thêm một cột tiền tuyệt đối dùng mục (e).
- `yeucau` dòng 456: thêm cột `doanh_thu_luy_ke_usd` sau `kenh`: "doanh thu từ ngày cài tới ngày mới nhất có trong dữ liệu của người cài từ chiến dịch, USD, làm tròn 2 chữ số". Lọc vẫn theo ROAS D30. Dòng 471 đổi "Mọi người cài tháng 7 đều đủ 30 ngày quan sát tới 29/8." thành "Mọi người cài tháng 7 đều đủ 30 ngày quan sát; dữ liệu chạy hằng ngày có thêm ngày mới."
- Solution: thêm vào bảng dẫn xuất doanh thu `SUM(pd.iap_revenue + pd.ad_revenue)` không giới hạn `cohort_day` và không cận trên (người cài tháng 7 qua kênh trả phí).
- Wrong mới `luy_ke_gan_cung_29_8`: giống solution nhưng cột luỹ kế thêm `pd.activity_date <= '2026-08-29'`. Đã chạy thử: public khớp (Social Ads 1.376,53), hidden-1 rớt (1.202,81 so với 1.203,30, lệch 0,49 > 0,01). Social Ads nằm trong kết quả ở cả hai biến thể nên dòng lệch luôn hiện.
- Lợi thêm về nghiệp vụ: học viên phân biệt ROAS D30 (cửa sổ cố định, so được giữa các nhóm cài) với doanh thu luỹ kế tới nay. Ghi lại 5 trục ở `\ghichuthietke` (trục bẫy đạt đủ: 5 bẫy, một chỉ lộ ở hidden-1).
- Nếu không muốn thêm cột, giữ nguyên câu ở Khó (4/5 trục) vẫn đúng quy chuẩn.

## C. Ô trùng (dạng × mảng × cấp × hình thức) của 27 câu trong cả bộ

Đếm lại từ khoá `\begin{cauhoi}` của 5 gói (case không có dạng nên không tính). Không có ô trùng trong cùng một gói. Có 3 ô trùng giữa các gói (BAN-DO ghi là "cho phép, để tham khảo"):

| Ô | Câu | Ghi chú, đề xuất |
|---|---|---|
| A3 · operations · easy · write | n3 (g1), j5 (g3) | BAN-DO dòng 227 đã ghi. Nếu muốn bỏ trùng: n3 đổi `dang=A3` → `C4` (ô trống) |
| C3 · marketing · hard · write | j4 (g3, v3+v4), s1 (g2, v4) | **Mới ở v4, BAN-DO chưa ghi.** Không đổi j4 được: chuyển j4 sang `finance` sẽ trùng lại q5 (C3 · finance · hard · write, đúng ô QDC 1.5 đã tách). Nếu muốn bỏ trùng thì đổi s1 (người kiểm C), ví dụ `dang=C3` → `A2` (ô A2 · marketing · hard · write đang trống) |
| A1 · operations · basic · write | j1 (g3, v4), s2 (g2) | **Mới ở v4, BAN-DO chưa ghi đúng:** dòng 224 viết "ô này nay chỉ còn `jelly-s2-tach-the-gioi`", dòng 225 còn xếp j1 ở ô A1 · operations · easy. Nếu muốn bỏ trùng: j1 đổi `domain=operations` → `after_sales` (ô trống; lời nhắn thêm "sau bản vá 2.1.1" cho hợp mảng đối soát sau phát hành) |

Mục "Ô trùng giữa các gói" của BAN-DO (dòng 223–233) đã cũ so với v4: cần thêm j4/s1, sửa dòng j1 từ easy sang basic (trùng s2), bỏ dòng A3 · marketing · easy (a3 nay là basic) và D1 · customer · medium (q3 nay là basic, mã mới).

## Tổng kết

- 27 câu: **Đạt 20**, **Cần sửa 7** (r2, s8, a3, a8, j1, f9, c8).
- Tự giải khớp solution 27/27 câu (cả 8 bước SQL của c8, c9 và bước 1 của c1), trên cả `jelly` và `jelly_hidden_1`. Không có solution sai, không có wrong không rớt, không có câu sai cấp. Module đủ 2/3/2/2 ở cả 10 module.
- Lỗi nặng hơn cả: s8 (bối cảnh, tiêu đề ngầm báo kết quả ngược với kết quả đúng) và a8 (câu "dữ liệu hiện có tới hết ngày 29/8" dẫn tới bài gắn cứng ngày cuối, rớt hidden-1: chấm oan được). Còn lại là sửa chữ.
- q5: đủ Khó (4/5 trục); có đề xuất bẫy hidden-1 cụ thể dùng biến thể (e), đã chạy thử.
- Ô trùng: 3 ô giữa các gói (n3/j5, j4/s1, j1/s2), không có ô trùng trong một gói; BAN-DO cần cập nhật mục ô trùng.
