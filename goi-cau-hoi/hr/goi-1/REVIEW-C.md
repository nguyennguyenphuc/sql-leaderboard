# REVIEW-C · gói 1 · HR Analytics (`hr`)

Người kiểm C · 10/11/2026 · nhận câu thứ 2, 4, 6, … theo thứ tự trong `cau-hoi.tex`:
R2, R4, R6, R8, N1, N3, N5, N7, N9, C2 (10 câu).

Cách kiểm: tự viết SQL từ đề (với câu Sửa lỗi chỉ xem truy vấn khởi đầu), chạy trên `hr` và `hr_hidden_1`
(container `sqllb-mysql`, user `sql_runner`), rồi chạy mọi khối `solution`, `starter`, `wrong` của 10 câu trên cả hai
biến thể và so theo luật chấm (vị trí cột, thứ tự khi `thutu=co`, sai số 0,01). Nháp và kết quả thô:
`cong-cu/ket-qua/review/hr-goi-1-C/`.

## Bảng kết quả

| Mã | Phiên bản | Kiểm SQL | Kiểm nội dung | Đề xuất sửa (tóm tắt, chi tiết ở mục dưới) |
|---|---|---|---|---|
| `hr-r2-nghi-tu-nguyen-thang-9` | v1 | **Đạt.** SQL tự giải trùng solution (public 40 dòng, hidden-1 37). `chi_loc_co_nghi` ra 49 dòng, `quen_loc_thang` 629 dòng: rớt ở public. | **Cần sửa.** Bối cảnh lộ đáp án C1; câu chữ ghi chú thiết kế lủng củng. | Bỏ "Tháng 9 số người nghỉ việc tăng"; sửa "lẫn" ở `\ghichuthietke`. |
| `hr-r4-sales-cong-tac-indonesia` | v1 | **Đạt.** Trùng solution, hidden-1 giống public đúng như ghi chú. Hạng 8 tới 11 cùng 7 ngày (E00041, E01433, E02870, E03660); hai bài sai đều rớt ở public. | **Cần sửa.** Tiêu đề ngược với phạm vi đề; ba cách gọi cho phòng Sales; yêu cầu cấp Dễ thiếu cột và giá trị lọc nước, tháng. | Đổi tiêu đề; thống nhất "phòng Kinh doanh (`'Sales'`)"; ghi `country`, `snapshot_month`. |
| `hr-r6-dong-bang-tuyen-thay-the` | v1 | **Đạt.** Trùng solution (16 dòng, hai biến thể như nhau). `so_sanh_voi_so_0` ra 80 dòng, `quen_nam_ke_hoach` ra 25: rớt ở public. | **Cần sửa.** Câu bối cảnh có dạng phủ định dịch máy; khái niệm `vi-tri-then-chot` không dùng trong câu, dễ dẫn học viên lọc thêm vị trí then chốt. | Sửa câu bối cảnh; bỏ `\khainiem{vi-tri-then-chot}`, đưa ghi chú `backfill_allowed` vào `\luuy`. |
| `hr-r8-yeu-cau-thang-3-thieu-ngay` | v1 | **Đạt.** Solution 34 yêu cầu, 100.300 USD (hidden-1: 31; 87.820). Starter 33; 98.700 (hidden-1: 30; 86.220) nên sai đúng chỗ đề muốn (đúng 1 người bắt đầu làm việc ngày 31/3). Bài sai `MONTH()` ra 57, theo ngày duyệt ra 49: rớt ở public. | **Cần sửa.** Tiêu đề nói luôn nguyên nhân lỗi; ba cách gọi cho cùng một mốc ngày. | Đổi tiêu đề thành triệu chứng; thống nhất "bắt đầu làm việc"; thêm vào `\luuy` ý "mỗi yêu cầu tuyển được một người". |
| `hr-n1-vang-mat-binh-quan-thang-6` | v1 | **Đạt.** Trùng solution: 2.936 dòng; 0,56 ngày (hidden-1: 2.631; 0,57). Hai bài sai đều rớt (3.089; 0,54), nhưng ra **cùng một kết quả** trên cả hai biến thể, nên thực chất chỉ có một lỗi. | **Cần sửa.** "Dòng trống" dễ hiểu thành dòng không có dữ liệu nào. | Sửa `\luuy`; nên thay một bài sai bằng một lỗi khác. |
| `hr-n3-nhom-compa-ratio` | v1 | **Đạt.** Trùng solution: cao_hon 517, ngang 1.336, thap_hon 1.260 (hidden-1: 463; 1.203; 1.127). Không có `compa_ratio` trống; 7 người đúng 0,900, 4 người đúng 1,100, nên `sai_bien_nhom` rớt; `hieu_la_phan_tram` ra 1 dòng. | **Cần sửa.** Tiêu đề dùng chữ ngoài bảng thuật ngữ; compa-ratio chưa giải nghĩa ở lần đầu; gợi ý có khuôn "mệnh đề: kết luận". | Xem chi tiết. |
| `hr-n5-co-hieu-suat-cao-thieu-diem` | v1 | **Đạt.** Trùng solution: 148 và 183 (hidden-1: 130 và 165). Hai bài sai đều ra 0 và 0 trên cả hai biến thể: rớt, nhưng là **cùng một kết quả**. | **Cần sửa.** Câu Viết mà tiêu đề là cụm danh từ; ba cách gọi cho "nhân viên có kết quả thực hiện công việc cao"; "số dòng như trên" lủng củng. | Xem chi tiết. |
| `hr-n7-gio-dao-tao-thap` | v1 | **Đạt.** Solution 13,22 (hidden-1: 13,20); starter 12,71 (12,70) nên sai đúng chỗ. Có 149 người 0 giờ ở tháng 12/2025, nên `bo_ca_dong_0_gio` ra 13,92: rớt ở public. | **Cần sửa.** Yêu cầu sắp từ theo trật tự tiếng Anh; bối cảnh lặp "đào tạo", "số". | Xem chi tiết. |
| `hr-n9-tien-lam-them-lech` | v1 | **Đạt.** Solution 10.839 giờ; 177.080,31 USD (hidden-1: 9.864; 159.848,47). Starter lệch 233 USD (hidden-1: 271). Đã thử 6 cách viết khác (nhân trước rồi chia, đưa 1,5 ra ngoài `SUM`, ép kiểu `DOUBLE`, `* 150 / 100`, bảng dẫn xuất): lệch nhau dưới 0,0001, nên không chấm oan vì độ chính xác DECIMAL trung gian. `quen_muc_150` và `lam_tron_tung_nguoi` (lệch 6,31) đều rớt. | **Đạt.** Còn hai chỗ nên sửa (không bắt buộc); mốc 176 giờ cần người nắm luật xem lại (xem chi tiết). | Xem chi tiết. |
| `hr-c2-thieu-diem-gan-ket-theo-phong` | v1 | **Đạt.** b1 trùng solution. Public: Finance 3,74%, Sales 3,70%, Engineering 3,49% (31 dòng thiếu, nhiều nhất)… Hidden-1: Finance 4,13%, Engineering 3,57% (28 dòng thiếu); Customer Support và Operations cùng 2,82%, quy tắc hoà theo `department` xử lý được. Hai bài sai đều rớt ở public. | **Cần sửa.** Lời giải thích phương án 2 sai sự thật trên dữ liệu; "số dòng trống" lủng củng; phương án đúng dài nhất (K32); mở "Chưa đúng." không theo chuẩn B.6. | Xem chi tiết. |

**Tổng:** kiểm SQL 10/10 Đạt. Kiểm nội dung 1 Đạt (N9), 9 Cần sửa. Không câu nào bị chấm oan, solution không câu nào sai, bài sai nào cũng rớt, tab Nghiệp vụ không câu nào lộ số kết quả.

---

## Chi tiết từng câu

### R2 · `hr-r2-nghi-tu-nguyen-thang-9`

- **Lộ đáp án câu khác trong gói (nặng nhất của câu này).** `\boicanh` mở bằng "Tháng 9 số người nghỉ việc tăng", còn C1 hỏi đúng "Tháng nào năm 2025 nhiều người nghỉ việc nhất?" và có đáp án tháng 9/2025 (dữ liệu: 07 = 38, 08 = 40, **09 = 49**, 10 = 38). Học viên làm R2 trước sẽ biết sẵn đáp án C1.
  - "Tháng 9 số người nghỉ việc tăng, anh cần đối chiếu với biên bản phỏng vấn thôi việc." → "Anh đang đối chiếu danh sách nghỉ việc tháng 9/2025 với biên bản phỏng vấn thôi việc."
- `\ghichuthietke`: "chỉ lọc cờ nghỉ lẫn nghỉ hưu và nghỉ không tự nguyện" ("lẫn" dùng làm động từ, đọc như thiếu chữ) → "chỉ lọc cờ nghỉ thì lẫn cả nghỉ hưu và chấm dứt hợp đồng do công ty".
- Các phần khác đạt: ERD Cơ bản có giá trị mẫu `'Retirement'` làm manh mối, gợi ý 2 nấc đúng chuẩn, cấp và module đúng.

### R4 · `hr-r4-sales-cong-tac-indonesia`

- **Tiêu đề ngược với phạm vi đề.** "Nhân viên kinh doanh Indonesia nào đi công tác nhiều nhất?" làm học viên hiểu là cả phòng Kinh doanh, mà lọc theo phòng lại chính là bài sai `loc_theo_phong_ban`. Tiêu đề cũng nói "nhiều nhất" trong khi đề lấy 10 người. → "Account Executive nào ở Indonesia đi công tác nhiều nhất?"
- **Ba cách gọi cho cùng một phòng ban** trong một câu: "Nhân viên kinh doanh" (tiêu đề), "Trưởng phòng Kinh doanh" (vai trò), "Phòng Sales" (`\luuy`).
  - "Phòng Sales gồm nhiều nhóm chức danh, Account Executive chỉ là một nhóm trong đó." → "Phòng Kinh doanh (\code{'Sales'}) gồm nhiều nhóm chức danh; Account Executive là một trong số đó."
- **Mức chỉ dẫn cấp Dễ** (STYLE-scm B.3: "Cơ bản và Dễ ghi rõ cột và giá trị lọc"): "Xét tháng 12/2025, nhân viên làm việc tại Indonesia có nhóm chức danh…" chưa nêu `country` và `snapshot_month`. → "Xét tháng 12/2025 (\code{snapshot_month} là \code{'2025-12'}), nhân viên làm việc tại Indonesia (\code{country} là \code{'Indonesia'}) có nhóm chức danh (\code{job_family}) là \code{'Account Executive'}."
- `\ghichuthietke`: "lọc theo phòng Sales lẫn Country Sales Lead, Sales Development Rep" → "lọc theo phòng Sales thì lẫn cả Country Sales Lead và Sales Development Rep".
- Cấp: câu chỉ dùng 1 bảng, không `JOIN`, không `GROUP BY`. Cấp Dễ chỉ dựa vào ERD 2 bảng, bẫy quy tắc hoà và bẫy phòng ban / nhóm chức danh. Chấp nhận được trong Module 1 (chưa học `JOIN`), nhưng nên ghi lý do vào `\ghichuthietke` để người duyệt khỏi hỏi lại.

### R6 · `hr-r6-dong-bang-tuyen-thay-the`

- `\boicanh`: "các vị trí năm 2025 còn thiếu người nhưng đang không được tuyển thay thế" (phủ định tiếp diễn, dịch từ "are not being allowed") → "các vị trí năm 2025 còn thiếu người mà đang bị dừng tuyển thay thế".
- `nghiepvu`: `\khainiem{vi-tri-then-chot}` không dùng trong câu (đề không lọc `critical_role_flag`). Định nghĩa "cần ưu tiên tuyển thay thế" còn làm học viên nghĩ phải lọc thêm vị trí then chốt. → Bỏ khái niệm này; thêm vào `\luuy`: "Cột \code{backfill_allowed} lưu chữ \code{'Yes'} hoặc \code{'No'}."
- `\ghichuthietke`: "quên năm kế hoạch lẫn vị trí năm 2024" → "quên năm kế hoạch thì lẫn cả vị trí của năm 2024".
- Cấp Dễ chỉ dùng 1 bảng, giống R4; nên ghi lý do như R4.

### R8 · `hr-r8-yeu-cau-thang-3-thieu-ngay`

- **Tiêu đề nói luôn nguyên nhân lỗi.** Theo STYLE-scm B.1, tiêu đề câu Sửa lỗi chỉ nêu triệu chứng. "Số người nhận việc tháng 3/2025 thiếu ngày cuối tháng" → "Số người mới vào làm tháng 3/2025 ra thiếu". Yêu cầu đã có "tính tới hết ngày cuối tháng", để một chỗ là đủ.
- **Ba cách gọi cho cùng một mốc**: "người nhận việc" (tiêu đề, `\luuy`), "người mới bắt đầu đi làm" (bối cảnh), "ngày bắt đầu làm việc" (yêu cầu, đúng STYLE A.5). "Nhận việc" còn dễ lẫn với "ngày nhận lời" của khái niệm `thoi-gian-tuyen` trong cùng tab. Nên dùng "bắt đầu làm việc" ở mọi chỗ.
  - `\luuy` "Số người nhận việc trong tháng tính theo ngày bắt đầu làm việc." → "Số người bắt đầu làm việc trong tháng tính theo \code{start_date}. Mỗi yêu cầu tuyển dụng trong bảng đã tuyển được một người." (Ý thứ hai giải thích vì sao "số người" lại đếm bằng `so_yeu_cau`; R3 có ý này, R8 chưa có.)
- `\begin{nghiepvu}{Đối chiếu số người mới nhận việc với danh sách đưa vào bảng chấm công.}`: dòng này nêu thao tác, chưa nêu quyết định (STYLE-scm B.4). → "Chốt danh sách người mới đưa vào bảng chấm công tháng 3/2025."
- Đã kiểm "ba mốc ngày thường rơi vào ba tháng khác nhau": đúng với 78,6% số yêu cầu.
- Cấp: lỗi là một giá trị lọc sai, đúng mẫu Sửa lỗi · Cơ bản ("sai giá trị lọc"). Cấp Dễ chỉ dựa vào ERD 2 bảng. Không bắt buộc sửa, nhưng nên xem lại.

### N1 · `hr-n1-vang-mat-binh-quan-thang-6`

- `\luuy`: "Dòng trống không góp vào tử số, nên cũng không được đưa vào mẫu số." ("dòng trống" nghe như dòng không có dữ liệu nào) → "Dòng thiếu dữ liệu chấm công không có mặt ở tử số, nên cũng không đưa vào mẫu số."
- SQL: `chia_cho_moi_dong` và `coi_o_trong_la_0` ra cùng kết quả (3.089; 0,54) trên cả hai biến thể. Hai cách viết khác nhau nhưng là một lỗi. Nên thay một bài bằng lỗi khác, ví dụ quên lọc tháng (`AVG` trên cả 24 tháng). Cũng lưu ý: riêng cột bình quân chỉ lệch 0,02 so với sai số 0,01. Bài sai rớt chắc chắn là nhờ cột đếm `so_dong_co_du_lieu`.

### N3 · `hr-n3-nhom-compa-ratio`

- Tiêu đề, lệch thuật ngữ (STYLE A.3 dùng "thấp hơn mức thị trường"): "Tháng 12/2025 bao nhiêu người nhận lương dưới thị trường?" → "Bao nhiêu người nhận lương thấp hơn mức thị trường?" (tháng đã có ở bối cảnh và yêu cầu).
- Thuật ngữ tiếng Anh chưa giải nghĩa ở lần đầu trong câu (STYLE A, quy ước 1): "Gán nhóm theo compa-ratio (\code{compa_ratio}):" → "Gán nhóm theo compa-ratio (tỷ số lương trên mức thị trường trung vị, \code{compa_ratio}):".
- `\goiy` nấc 2, khuôn "mệnh đề: kết luận": "\code{CASE WHEN} dừng ở điều kiện đúng đầu tiên: xét … trước, rồi …" → "\code{CASE WHEN} dừng ở điều kiện đúng đầu tiên, nên xét \code{compa_ratio < 0.9} trước rồi tới \code{compa_ratio <= 1.1}; gom nhóm theo nhãn."
- `\luuy`: "Có người có compa-ratio đúng bằng ngưỡng, nên…" (lặp "có") → "Một số nhân viên có compa-ratio đúng bằng ngưỡng, nên mỗi ngưỡng phải thuộc đúng một nhóm."

### N5 · `hr-n5-co-hieu-suat-cao-thieu-diem`

- Tiêu đề: câu Viết phải là câu hỏi nghiệp vụ (STYLE-scm B.1). "Cờ kết quả cao mà không có điểm đánh giá" → "Mỗi năm bao nhiêu cờ kết quả cao thiếu điểm đánh giá?"
- **Ba cách gọi cho một khái niệm**: "Cờ kết quả cao" (tiêu đề), "cờ nhân viên có kết quả cao" (bối cảnh), "cờ nhân viên có kết quả thực hiện công việc cao" (yêu cầu, đúng STYLE A.4). Tiêu đề được rút gọn vì giới hạn 10 tiếng, còn bối cảnh nên dùng tên đầy đủ.
- `\boicanh`: "Em đếm giúp anh mỗi năm có bao nhiêu dòng gắn cờ nhưng thiếu điểm đánh giá." ("dòng" là chữ của bảng dữ liệu, không hợp lời nhắn) → "Em đếm giúp anh mỗi năm có bao nhiêu trường hợp được gắn cờ mà thiếu điểm đánh giá thực hiện công việc."
- Yêu cầu: "(số dòng như trên của từng năm)" → "(số dòng thoả điều kiện trên, lần lượt của năm 2024 và năm 2025)".
- SQL: hai bài sai (`<> 4`, `= NULL`) cùng ra 0 và 0 trên cả hai biến thể, nên thực chất là một lỗi. Nên thay một bài, ví dụ đếm theo `performance_rating < 4` (cũng bỏ sót ô trống nhưng nghe hợp lý hơn) hoặc quên lọc cờ (chỉ lọc điểm trống).

### N7 · `hr-n7-gio-dao-tao-thap`

- **Yêu cầu sắp từ theo trật tự tiếng Anh**: "để tính đúng giờ đào tạo trong 6 tháng gần nhất bình quân một nhân viên, tháng 12/2025, chỉ trên các dòng có dữ liệu đào tạo" → "để tính đúng số giờ đào tạo bình quân của một nhân viên trong 6 tháng gần nhất, tính tại tháng 12/2025, chỉ trên các dòng có dữ liệu đào tạo."
- `\boicanh`: "Em tính giờ đào tạo bình quân tháng 12/2025 cho báo cáo đào tạo, mà số ra thấp hơn số của chị phụ trách đào tạo." ("đào tạo" 3 lần, "số" 2 lần) → "Em tính giờ đào tạo bình quân tháng 12/2025 cho báo cáo, nhưng kết quả thấp hơn số của chị phụ trách đào tạo. Anh chị xem giúp em sai ở đâu."

### N9 · `hr-n9-tien-lam-them-lech` (Đạt; các ý dưới không bắt buộc)

- Yêu cầu: "Ước tính theo giả định của đề:" (nhắc "đề" trong đề) → "Ước tính theo giả định sau:".
- Dòng mở `nghiepvu`: "Trích trước chi phí tiền lương làm thêm giờ vào chi phí nhân sự tháng 12." (lặp "chi phí") → "Trích trước tiền lương làm thêm giờ vào chi phí nhân sự tháng 12/2025."
- **CẦN NGƯỜI NẮM DOMAIN (không chặn):** mốc 176 giờ (22 ngày × 8 giờ). Theo hiểu biết của tôi, NĐ 145/2020 Điều 55 tính tiền lương giờ từ số ngày làm việc bình thường của doanh nghiệp (tối đa 26 ngày), và nhiều công ty Việt Nam dùng 24 hoặc 26 ngày. Đề đã ghi rõ đây là giả định nên không sai, nhưng người nắm luật lao động nên xác nhận có cần thêm một câu vào `\luuy` hay không. Trích Điều 98 về mức 150% ngày thường là đúng.

### C2 · `hr-c2-thieu-diem-gan-ket-theo-phong`

- **Lời giải thích phương án 2 sai sự thật trên dữ liệu**: "tỷ lệ thiếu của phòng này không cao hơn các phòng khác". Engineering (3,49%) cao hơn Operations, HR và Customer Support ở public, và đứng thứ hai ở hidden-1 (3,57%). → "Số dòng thiếu lớn vì Engineering đông người nhất; tỷ lệ thiếu của phòng này nằm giữa các phòng khác."
- Yêu cầu b1: "tỷ lệ thiếu bằng số dòng trống chia số dòng" → "tỷ lệ thiếu bằng số dòng thiếu điểm chia tổng số dòng của phòng ban".
- K32 (phương án đúng lộ đáp án vì dài nhất): phương án đúng có hai vế, dài hơn hẳn hai phương án kia. → "Tỷ lệ thiếu điểm của sáu phòng ban gần nhau, nên dữ liệu thiếu không tập trung ở phòng nào."
- Phương án sai mở bằng "Chưa đúng." không theo STYLE-scm B.6 ("phương án sai nêu thẳng chỗ sai"). C1 cũng mở như vậy (lặp trong gói). → bỏ "Chưa đúng.", mở thẳng bằng căn cứ.
- Phương án 3 "nhân viên Finance ít quan tâm tới khảo sát gắn kết": `engagement_score` của ảnh chụp tháng là ước lượng hằng tháng, không phải khảo sát (khái niệm `diem-gan-ket`). Phương án sai thì được phép sai, nhưng lời giải thích nên chỉ thêm chỗ này: "…và điểm gắn kết hằng tháng không lấy từ khảo sát."
- Tiêu đề, bối cảnh, dòng mở nghiệp vụ dùng "dồn vào" (khẩu ngữ, chấp nhận được). Nếu muốn giọng giáo trình hơn, đổi thành "tập trung ở".
- `\luuy` "Số dòng thiếu của một phòng ban phụ thuộc cả số người của phòng ban đó." gần như nói trước lập luận của bước kết luận. Chấp nhận được ở cấp Cơ bản; nếu muốn bớt, dùng "Mỗi phòng ban có quy mô khác nhau."

---

## Giọng văn

Đếm trên 10 câu được giao (mỗi chỗ đã trích ở trên):

| Loại | Số chỗ | Ví dụ |
|---|---|---|
| Giọng AI | 3 | N3 `\goiy` khuôn "mệnh đề: kết luận"; C2 phương án đúng dài hơn hẳn (K32); C2 "Chưa đúng." mở mọi phương án sai |
| Dịch máy / câu lủng củng | 6 | N7 "giờ đào tạo trong 6 tháng gần nhất bình quân một nhân viên, tháng 12/2025"; R6 "đang không được tuyển thay thế"; N5 "số dòng như trên của từng năm"; "lẫn" dùng làm động từ ở `\ghichuthietke` R2, R4, R6 |
| Lệch thuật ngữ / lẫn cách gọi | 7 | N3 "dưới thị trường" và compa-ratio chưa giải nghĩa; R4 Kinh doanh / Sales; R8 nhận việc / bắt đầu đi làm / bắt đầu làm việc; N5 ba tên cho cờ kết quả cao; N1, C2 "dòng trống" |

Không thấy dấu "—", "chìa khoá", "bức tranh", "không chỉ… mà còn", ẩn dụ động từ trong danh sách cấm, hay bối cảnh mở bằng câu sáo. Lời nhắn `\boicanh` nói chung tự nhiên, xưng hô đúng vai.

Khuôn lặp trên nhiều câu của gói:
1. **Bối cảnh cùng một khuôn** "[việc đang làm]. Em [lọc/tính/đếm/liệt kê/lấy] giúp [anh/chị] …" ở cả 20 câu, câu Sửa lỗi kết bằng "Anh chị xem giúp em (sai ở đâu)." (R7, R9, N7). Khuôn này đúng mẫu STYLE, nhưng đọc liền 20 câu thì đơn điệu. Nên đổi cách mở ở vài câu (hỏi thẳng, nêu hạn, nêu cuộc họp).
2. **"lẫn" dùng làm động từ** trong `\ghichuthietke` (R2, R4, R6, và R7 "lẫn mọi loại nghỉ").
3. **"Chưa đúng." mở phương án sai** ở C1 và C2.
4. **Hai bài sai cùng ra một kết quả** (N1, N5): mỗi câu thực chất chỉ kiểm một lỗi.
5. **Cách gọi dòng có ô trống chưa thống nhất**: "dòng trống" (N1, C2), "dòng thiếu", "ô trống". Nên chốt "dòng thiếu dữ liệu" cho dòng và "ô trống" cho ô.
6. **Bối cảnh của câu này lộ đáp án câu khác** (R2 với C1): khi soạn gói nên rà chéo bối cảnh với các bước kết luận của case.
