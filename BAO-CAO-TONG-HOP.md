# Báo cáo tổng hợp bộ 500 câu Luyện SQL

Ngày lập: 10/11/2026. Người nhận: giảng viên phụ trách.
Phạm vi: 5 bộ dữ liệu (`scm`, `aivb`, `jelly`, `hr`, `mkt`) × 5 gói × 20 câu, ở `goi-cau-hoi/<bo>/goi-<k>/`.

Nguồn đã đọc: `cau-hoi.tex` (đếm câu), `DA-SUA.md` (mục "Chờ giảng viên", "Đã xử lý"), `BANG-PHAN-CONG.md`, `REVIEW-B.md` và `REVIEW-C.md` (chỉ lấy số tổng), `<bo>/RA-SOAT-GIONG.md`, `<bo>/BAN-DO-100-CAU.md`, `style/STYLE-<bo>.md` (mục F, G), `mysql/README*.md`. Không chạy SQL; số liệu kết quả truy vấn trích từ các file trên.

---

## 1. Tổng quan

Đếm từ khoá `hinhthuc=` và `cap=` của 500 khối `\begin{cauhoi}` trong 25 file `cau-hoi.tex`. Mỗi gói đúng 20 câu. Số đếm khớp với dòng "Bản 2 (thật)" của cả 5 `BAN-DO-100-CAU.md`.

### 1.1. Theo bộ và hình thức

| Bộ | write | debug | optimize | case | Cộng |
|---|---:|---:|---:|---:|---:|
| scm (Supply Chain) | 55 | 29 | 6 | 10 | 100 |
| aivb (AIV Bank) | 55 | 29 | 6 | 10 | 100 |
| jelly (Game Jelly Trail) | 54 | 28 | 8 | 10 | 100 |
| hr (HR Analytics) | 56 | 28 | 6 | 10 | 100 |
| mkt (Marketing) | 56 | 28 | 6 | 10 | 100 |
| **Cộng** | **276** | **142** | **32** | **50** | **500** |

### 1.2. Theo bộ và cấp

| Bộ | basic | easy | medium | hard |
|---|---:|---:|---:|---:|
| scm | 15 | 33 | 36 | 16 |
| aivb | 14 | 30 | 39 | 17 |
| jelly | 14 | 34 | 37 | 15 |
| hr | 16 | 30 | 38 | 16 |
| mkt | 14 | 33 | 34 | 19 |
| **Cộng** | **73** | **160** | **184** | **83** |

### 1.3. Bộ × hình thức × cấp

| Bộ · hình thức | basic | easy | medium | hard | Cộng |
|---|---:|---:|---:|---:|---:|
| scm · write | 8 | 19 | 20 | 8 | 55 |
| scm · debug | 3 | 11 | 12 | 3 | 29 |
| scm · optimize | 1 | 1 | 2 | 2 | 6 |
| scm · case | 3 | 2 | 2 | 3 | 10 |
| aivb · write | 7 | 18 | 23 | 7 | 55 |
| aivb · debug | 4 | 10 | 11 | 4 | 29 |
| aivb · optimize | 0 | 0 | 3 | 3 | 6 |
| aivb · case | 3 | 2 | 2 | 3 | 10 |
| jelly · write | 8 | 20 | 20 | 6 | 54 |
| jelly · debug | 3 | 9 | 12 | 4 | 28 |
| jelly · optimize | 0 | 3 | 3 | 2 | 8 |
| jelly · case | 3 | 2 | 2 | 3 | 10 |
| hr · write | 7 | 20 | 22 | 7 | 56 |
| hr · debug | 5 | 8 | 12 | 3 | 28 |
| hr · optimize | 1 | 0 | 2 | 3 | 6 |
| hr · case | 3 | 2 | 2 | 3 | 10 |
| mkt · write | 7 | 21 | 18 | 10 | 56 |
| mkt · debug | 4 | 10 | 11 | 3 | 28 |
| mkt · optimize | 0 | 0 | 3 | 3 | 6 |
| mkt · case | 3 | 2 | 2 | 3 | 10 |
| **Cả bộ: write · debug · optimize · case** | 37 · 19 · 2 · 15 | 98 · 48 · 4 · 10 | 103 · 58 · 13 · 10 | 38 · 17 · 13 · 15 | 276 · 142 · 32 · 50 |

### 1.4. Theo gói (cộng 5 bộ)

| Gói | basic | easy | medium | hard | write | debug | optimize | case |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 47 | 51 | 2 | 0 | 60 | 30 | 0 | 10 |
| 2 | 22 | 62 | 16 | 0 | 60 | 30 | 0 | 10 |
| 3 | 1 | 41 | 58 | 0 | 60 | 30 | 0 | 10 |
| 4 | 0 | 0 | 62 | 38 | 60 | 30 | 0 | 10 |
| 5 | 3 | 6 | 46 | 45 | 36 | 22 | 32 | 10 |

Case theo đúng khung của bản đồ ở cả 5 bộ: gói 1 basic + basic, gói 2 basic + easy, gói 3 easy + medium, gói 4 medium + hard, gói 5 hard + hard.

Câu ngoài khung cấp của module (theo mục "Lệch khung" của bản đồ): scm 6 (n5, n9, s8, k1, p1, p2), aivb 1 (p7), jelly 3 (p1, p2, p7), hr 2 (p2, p8), mkt 1 (q7). jelly còn một ô dạng × mảng × cấp × hình thức trùng trong cùng gói 3 (j4, q5).

---

## 2. Quy trình đã chạy

| Bước | Việc | Kết quả ghi nhận |
|---|---|---|
| 1. Soạn | Người soạn A viết 20 câu mỗi gói theo bản đồ 100 câu và STYLE của bộ; mỗi câu có solution, starter (debug, optimize), wrong | 25 gói v1 |
| 2. Bộ kiểm | `kiem_tra_goi.py` chạy cả gói trên public và hidden-1 | 0 lỗi trước khi giao kiểm |
| 3. Kiểm B/C | B kiểm câu lẻ, C kiểm câu chẵn, 6 bước: (1) tự viết SQL trước khi mở solution; (2) so với solution trên `public` và `hidden-1`; (3) chạy starter, wrong; (4) nghiệp vụ; (5) cấp, module, ERD; (6) giọng văn. Bước 6 là cửa chặn: còn một chỗ giọng AI, dịch máy hay lệch thuật ngữ thì câu là "Cần sửa" | 50 file REVIEW |
| 4. Sửa | A sửa theo REVIEW, ghi `DA-SUA.md`; điểm chưa đủ căn cứ đưa vào mục "Chờ giảng viên" | 25 gói v2 |
| 5. Rà giọng văn cả bộ | Một người rà 100 câu một lượt, chỉ sửa chữ (không đổi SQL, `ma`, khoá chấm, cấp) | `<bo>/RA-SOAT-GIONG.md` |
| 6. Bổ sung biến thể ẩn | File `04_bo_sung_bien_the_<bo>.sql` thêm dòng giả và sửa bảng danh mục, bảng phụ vào `<bo>_hidden_1`; không dựng `hidden_2` | mục "Đã xử lý" của DA-SUA |
| 7. Bộ kiểm cuối | Kiểm tĩnh `--chi-phan-tich` và biên dịch XeLaTeX sau lượt rà giọng văn | 25/25 gói 0 lỗi, 0 lỗi LaTeX |

Ghi chú: các file đã đọc ghi kết quả kiểm tĩnh sau lượt rà giọng văn và kết quả chạy solution trên hai biến thể cho từng câu đổi sau bước 6. Bản ghi một lượt bộ kiểm chạy thật cả 25 gói sau bước 6 nằm ngoài các file này (`cong-cu/ket-qua/`), cần đối chiếu trước khi phát hành.

### 2.1. Kết quả kiểm vòng 1 (REVIEW-B, REVIEW-C)

Một câu chỉ "Đạt" khi cả kiểm SQL và kiểm nội dung đều Đạt.

| Bộ | Câu "Cần sửa" | Trong đó phần SQL "Cần sửa" |
|---|---:|---:|
| scm | 97/100 | 34 |
| aivb | 98/100 | 72 |
| jelly | 91/100 | 15 |
| hr | 81/100 | 13 |
| mkt | 93/100 | 18 |
| **Cộng** | **460/500 (92%)** | **152/500 (30%)** |

Tỷ lệ "Cần sửa" cao chủ yếu do cửa chặn giọng văn ở bước 6. Phần SQL "Cần sửa" của scm và aivb gần như toàn bộ do hai biến thể cho cùng kết quả.

### 2.2. Các loại lỗi nặng hay gặp

| Loại lỗi | Ví dụ (mã câu · gói) | Cách đã xử lý |
|---|---|---|
| Hai biến thể cho cùng kết quả: chép kết quả Chạy thử vẫn qua | phần lớn câu "Cần sửa" phần SQL của scm, aivb; jelly-q9 (g3), jelly-t5 (g4); mkt-r2 (g1), mkt-q2, mkt-p3 | Bổ sung biến thể (bước 6). DA-SUA ghi "Đã xử lý" cho scm 26 câu (g1 9, g4 7, g5 10), aivb 69 câu (g1 17, g2 13, g3 16, g4 11, g5 12), jelly 8 câu; hr, mkt sửa qua file 04 và trong thân DA-SUA |
| Chấm oan do làm tròn, thứ tự, đề mơ hồ | scm-q6 (g3, sắp theo giá trị đã làm tròn); scm-s8 (g2); aivb-c3 (g2); aivb-k8 (g5, hồ sơ 120 giờ 1 giây); jelly-s6 (g2, năm-tuần dạng chuỗi); hr-r9 (g1, 152 hay 149); hr-t7, hr-c7 (g4); hr-k6, hr-c10 b3–b4 (g5); mkt-p2 (g5, lời giải hợp lý 2,03 lần ngân sách) | Sửa đề, thêm khoá sắp, nới `ngansach` (mkt-p2: 2 → 3) |
| Lộ phương án đúng (K32: dài nhất, duy nhất có số hoặc có rào) | scm-c1 (g1), scm-c6 (g3), aivb-c5 (g3), aivb-c7, aivb-c8 (g4), aivb-c10 (g5), mkt-c7 (g4) | Cân độ dài, bỏ rào lệch; hr-c6, hr-c8 còn để lại (mục 3.1) |
| Wrong trùng starter hoặc trùng solution | aivb-q8 (g3); aivb-f8 (g4, starter và wrong `DENSE_RANK` trùng solution ở public); jelly-j4, q5, c6 (g3, wrong có hằng số viết tay) | Thay wrong, thêm cặp hoà ở hidden-1 |
| Kỹ năng chính không được chấm | aivb-f4 (g4, không đảo chuỗi vẫn qua); hr-s5 (g2, gõ cứng `'-07'` vẫn qua); hr-k2, jelly-k2 (g5) | Đổi đề hoặc thêm dữ liệu biến thể; jelly-k1 còn mở (mục 3.1) |
| Bối cảnh, đề sai số liệu | mkt-f8 (g4, đề nói "giảm mạnh", starter ra +178%); mkt-c7 (g4, giải thích sai tháng); hr-s8 (g2); hr-t3 (g4); jelly-a9 (g2, "gần hết các màn" thực tế 37/60); mkt-q2 (g3) | Sửa theo số thật |
| Tab Nghiệp vụ lộ cách sửa hoặc kết luận | hr-r7 (g1); hr-s8, hr-a9 (g2); scm-j9, scm-q8 (g3); aivb-c5 (g3); aivb-c7 (g4) | Chuyển ý kỹ thuật sang `\goiy` |
| Chấm rộng | jelly-s8 (g2, `BETWEEN` tới 16/8 vẫn qua) | Sửa dữ liệu, wrong |

### 2.3. Rà giọng văn cả bộ (RA-SOAT-GIONG)

| Bộ | Số chỗ sửa | Giọng AI | Dịch máy | Thuật ngữ, quy ước | Khuôn lặp | Khác |
|---|---:|---:|---:|---:|---:|---|
| scm | 60 | 9 | 0 | 13 | 38 | |
| aivb | 94 | 25 | 3 | 15 | 51 | (vai người hỏi tính trong thuật ngữ) |
| jelly | 84 | 5 | 2 | 9 | 68 | (5 là lời nhắn nhắc kỹ thuật) |
| hr | 110 | 5 | 2 | 18 | 83 | lời nhắn nhắc kỹ thuật 2 |
| mkt | 186 | 23 | 2 | 48 | 90 | vai, tên nhân vật 23 |
| **Cộng** | **534** | | | | | |

Mọi lượt rà đều đối chiếu máy với bản trước: không dòng `\begin{cauhoi}[…]`, `\begin{buoc}[…]` nào đổi khoá; kiểm tĩnh 0 lỗi; biên dịch 0 lỗi LaTeX.

---

## 3. Việc cần giảng viên quyết

Gom 119 mục "Chờ giảng viên" của 25 `DA-SUA.md`, bỏ phần đã chuyển sang "Đã xử lý" (biến thể ẩn), gộp mục trùng giữa các gói, thêm 9 mục còn để lại ở RA-SOAT-GIONG (ghi nguồn "RS": 1 ở 3.1, 8 ở 3.8). Còn **126 mục**, chia 8 nhóm. Nhóm 3.1 và 3.2 ảnh hưởng điểm số, nên quyết trước.

| Nhóm | scm | aivb | jelly | hr | mkt | Chung | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| 3.1. Ảnh hưởng trực tiếp tới chấm | 1 | 2 | 4 | 3 | 1 | | 11 |
| 3.2. Kết luận case (phương án đúng) | 4 | 3 | 4 | 2 | | | 13 |
| 3.3. Định nghĩa nghiệp vụ, công thức | 8 | 20 | 8 | 8 | 6 | | 50 |
| 3.4. Cấp độ và module | 1 | 4 | 3 | 7 | 4 | | 19 |
| 3.5. Quy ước chung | | | | | | 9 | 9 |
| 3.6. Mã câu lệch nội dung | | 2 | 3 | 1 | 4 | | 10 |
| 3.7. Vai người hỏi, mảng, bối cảnh | 3 | 1 | | | 2 | | 6 |
| 3.8. Còn để lại sau rà giọng văn (RS) | 1 | 2 | | 1 | 4 | | 8 |
| **Cộng** | **18** | **34** | **22** | **22** | **21** | **9** | **126** |

Nếu giảng viên chấp nhận "đề xuất mặc định" của một mục, người soạn làm theo cột đó; mục có chữ "đổi SQL" phải chạy lại bộ kiểm của câu.

### 3.1. Ảnh hưởng trực tiếp tới chấm điểm

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| jelly-n5 (g1) | ĐÃ SỬA 10/11 21:05: yêu cầu đổi thành "mỗi cặp gói vật phẩm – mức giá đã bán một dòng", bỏ "năm gói"; \luuy và ghi chú thiết kế cập nhật. | – |
| jelly-k1 (g5) | Đáp án là 0 dòng thừa ở cả hai biến thể (khoá chính chặn dòng trùng), bài trả hằng số vẫn qua. | Thêm biến thể có dòng trùng khoá (bảng không khoá chính hoặc `jelly_hidden_2`); trong lúc chờ, ghi rõ giới hạn ở `\ghichuthietke`. |
| jelly-r8 (g1) | Bài gắn cứng `<= '2026-08-29'` vẫn qua vì không biến thể nào có giao dịch GB ngày 30–31/8. | Thêm một giao dịch GB ngày 2026-08-30 vào `jelly_hidden_1` (file 04) và wrong `gan_cung_ngay_cuoi`. |
| aivb-n9, aivb-c2 (g1) | File 04 chưa có dòng đúng biên (`valid_to`/`valid_from` = 2026-06-30; tiền gửi `ACTIVE` đến hạn đúng 2027-02-01), bài sai ở biên chưa bị bắt riêng. | Thêm các dòng biên vào `04_bo_sung_bien_the_aivb.sql`, chạy lại solution mọi câu dùng hai bảng này. |
| aivb-c2 (g1) | Mốc "hiện tại" là ngày chốt dữ liệu tiền gửi 04/01/2027; theo ngày tham chiếu chung 31/12/2026 thì thêm 19 hợp đồng đến hạn 01–04/01/2027. | Giữ mốc 04/01/2027 (đã ghi trong yêu cầu b1). |
| scm-t7, scm-t9 (g4) | t7 đã bỏ wrong chuẩn không trọng số vì dữ liệu 2016 không phân biệt được; t9 dùng `saiso=0.001`, chặt hơn chuẩn gói, vì bẫy trung bình tỷ lệ chỉ lệch 0,01. | Chấp nhận `saiso=0.001` riêng t9 (đề ghi số chữ số làm tròn); t7 giữ, ghi bẫy yếu vào `\ghichuthietke`. |
| jelly-c8 (g4) | ARPDAU bước 2 tính bằng cent (khác quy ước 4 chữ số USD của STYLE) để dùng sai số chung 0,01. | Chấp nhận; tên cột và yêu cầu ghi rõ đơn vị cent. |
| mkt-k4 (g5) | Kết quả nhánh `'00-00-0000'` phụ thuộc `sql_mode` mặc định (có `NO_ZERO_DATE`) của máy chấm. | Giữ câu; cố định `sql_mode` mặc định MySQL 8.0 trên máy chấm và ghi vào `mysql/README.md`. |
| hr-p7 (g5) | Câu write không chấm kế hoạch chạy; bài học về chỉ mục chỉ hiện khi học viên tự chạy `EXPLAIN ANALYZE`. | Giữ hình thức write; ghi rõ trong `\ghichuthietke` là câu không chấm kế hoạch chạy. |
| hr-p5 (g5) | Lời giải ít lần quét hơn nhưng sinh nhiều dòng trung gian hơn starter; câu chỉ chấm số lần quét. | Giữ ràng buộc số lần quét, không thêm ngân sách dòng. |
| hr-c6, hr-c8 (g3, g4) · RS | Phương án đúng có câu rào "theo dõi thêm / cần xác nhận thêm" mà phương án sai không có (K32): đoán được đáp án. | Người soạn gói 3, 4 cân lại: thêm rào tương ứng cho một phương án sai hoặc bỏ rào ở phương án đúng. |

### 3.2. Kết luận case: phương án đúng cần xác nhận

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| jelly-c9 (g5) | Đo bằng giao dịch `extra_moves_pack` hay bằng cờ `extra_moves_purchased` cho kết luận ngược nhau (nhánh thử cao hơn khoảng 12% theo cờ); chênh nhỏ, chưa kiểm ý nghĩa; hidden-1 b3 đảo chiều. | Giữ nguồn `purchases` (khớp tên chỉ số chính có chữ "purchase"); đổi phương án đúng thành "chênh lệch nhỏ, chưa đủ để kết luận nhánh nào tốt hơn". |
| scm-c3 (g2) | HUB_PHANTHIET hơn DC_HCM 0,28 điểm phần trăm trên 4.891 đơn, sai số chuẩn khoảng 0,3 điểm: kết luận "cần ưu tiên" chưa đủ chắc. | Hạ phương án đúng về "chênh nhỏ, chưa đủ để ưu tiên riêng một kho"; rà lại K32 sau khi sửa. |
| scm-c7 (g4) | Tháng 7 có tỷ lệ nhập trên bán 0,90, gần tháng 3 (0,88), nhưng fill rate chỉ giảm 0,28 điểm: căn cứ "fill rate tháng 3 giảm vì nhập dưới bán" yếu. | Phương án đúng chỉ nêu tương quan ("tháng 3 nhập thấp hơn bán và fill rate giảm"), không khẳng định nguyên nhân. |
| aivb-c10 (g5) | Kết luận v2 giả định bút toán của lệnh `'REVERSED'`, `'REJECTED'` phải loại khỏi dòng tiền ròng dùng cho kế hoạch vốn. | Xác nhận giả định của v2 (loại). |
| jelly-c10 (g5) | Phương án nhiễu 1 nêu đúng hai sự thật về Android, chỉ sai ở "đóng vụ việc"; cỡ mẫu iOS 2.1.1 nhỏ (572 lượt). | Giữ; lời giải thích phương án nhiễu 1 nêu rõ vì sao chưa thể đóng vụ việc. |
| scm-c4 (g2) | Phương án đúng đã hạ về mức tương quan ("thử ưu tiên"). | Chấp nhận mức kết luận của v2. |
| scm-c10 (g5) | Lượng bán đồ dùng học tập đạt đỉnh tháng 4, khó giải thích bằng mùa tựu trường ở Việt Nam (mẫu hình của dữ liệu gốc). | Giữ v2: phương án đúng chỉ nói "lượng bán tăng theo mùa", không gắn tháng. |
| aivb-c7 (g4) | Chưa chốt đo theo giá trị (bị vài lệnh lớn qua API chi phối) hay theo số lệnh; gộp ATM, POS vào kênh vật lý. | Giữ cách đo của v2; tên nhóm kênh chốt cùng aivb-n6 (mục 3.3). |
| aivb-c1 (g1) | Dùng DTI cho hồ sơ vay doanh nghiệp, trong khi thẩm định doanh nghiệp thường xem cơ cấu nợ và dòng tiền. | Giữ SQL; thêm `\luuy` "dữ liệu ghi DTI cho mọi hồ sơ". |
| jelly-c7 (g4) | Có cần nhắc nhóm iOS cài 2.1.1 cũng giảm (D1 thấp hơn iOS 2.0.2 khoảng 3,4 điểm). | Giữ phương án đúng chỉ nói Android 2.1.0; ý iOS để ở lời giải thích phương án C (như v2). |
| jelly-c4 (g2) | Câu rào cỡ mẫu đã thêm vào phương án đúng; cần xác nhận mức rào đủ trước khi dùng số chia ngân sách. | Giữ rào; kiểm K32 (phương án đúng không được là phương án duy nhất có rào). |
| hr-c7 (g4) | Nhóm "ở lại" chọn theo điều kiện còn làm tới 12/2025, đo cùng quý chưa bỏ hết thiên lệch người ở lại. | Giữ cách chọn nhóm; lời giải thích nêu giới hạn (như v2). |
| hr-c8 b3 (g4) | So người nghỉ của cả 24 tháng (dòng tháng nghỉ) với người ở lại tháng 12/2025, khác thời điểm đo. | Giữ; thêm `\luuy` nêu hai nhóm đo ở hai thời điểm khác nhau. |

### 3.3. Định nghĩa nghiệp vụ, công thức, phạm vi

**scm**

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| scm-r4 (g1) | `unit_sales` trộn hàng bán theo kg (số lẻ) với hàng bán theo đơn vị khi xếp "bán chạy". | Giữ SQL; thêm `\luuy` nêu lượng bán gồm cả hàng cân theo kg. |
| scm-n2 (g1) | "Lượng chưa về" có tính phần giao thiếu của đơn đã về không (v2 ghi có); dữ liệu 1–14/8 của `SUP_007` không có đơn giao thiếu nên kết quả không đổi. | Giữ định nghĩa v2. |
| scm-a3 (g2) | Đơn nhóm `'auto_apply'` luôn có `voucher_applied` = 1, nên tỷ lệ dùng voucher theo kho chủ yếu đo tỷ trọng nhóm thử nghiệm A/B. | Đổi chỉ số sang tỷ lệ dùng voucher trong nhóm `'manual'` (đổi SQL). |
| scm-s7 (g2) | Giá trị hàng nhận tính trên `qty_received` (gồm hàng lỗi). | Giữ "dòng tiền mua hàng" (v2); không trừ hàng lỗi. |
| scm-t5 (g4) | DC_HANOI xuất khoảng gấp đôi lượng nhập năm 2016; chưa rõ `units_shipped` và `qty_received` cùng đơn vị, cùng phạm vi. | Thêm `\luuy`: "Số liệu nhập xuất là dữ liệu mô phỏng, chưa gồm tồn đầu năm." |
| scm-f6 (g4) | Tăng trưởng cùng cửa hàng chọn tập cửa hàng "có giao dịch ở cả tháng 1/2016 và tháng 7/2017". | Giữ tiêu chí v2. |
| scm-p2 (g5) | Quyết định dùng tỷ lệ huỷ của kho vệ tinh đã đổi thành "có rà soát quy trình giao của kho vệ tinh hay không". | Giữ v2. |
| scm-p8 (g5) | Điều kiện "kho Huế hoặc có khách tự áp voucher" là danh sách rà soát do người soạn đặt. | Giữ v2. |

**aivb**

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| aivb-n4 (g1) | Nhãn "Mới giải ngân / Giữa kỳ / Sắp tất toán" sai với vay mua nhà giải ngân từ 2020 và `WC_LOAN` trả gốc cuối kỳ (vẫn còn trên 80% dư nợ). | Đổi nhãn thành "Còn từ 80% dư nợ / Còn 20–80% / Còn dưới 20%" (đổi SQL, giá trị kết quả đổi). |
| aivb-q1 (g3), STYLE A.4 (g1) | `'ACTIVE'` của khoản vay đang gọi hai cách: "đang còn dư nợ" (STYLE A.4) và "đang trả nợ bình thường" (mục E, các gói). | Chốt "đang trả nợ bình thường" cho cả bộ, sửa STYLE A.4. |
| aivb-n6 (g1) | Cách gọi "kênh vật lý", "kênh truyền thống" hay "kênh tại điểm giao dịch". | Giữ "kênh vật lý", giải nghĩa lần đầu (quầy, ATM, POS); dùng chung với aivb-c7. |
| aivb-n1, aivb-n7 (g1) | Đã đổi khung nghiệp vụ theo dữ liệu (ô trống nghĩa là "không áp dụng"). | Xác nhận khung v2. |
| aivb-a1 (g2) | "Dư nợ bình quân" ở ngân hàng thường hiểu là bình quân theo thời gian; câu dùng bình quân một khoản vay. | Giữ cột `du_no_bq`; đổi chữ trong đề thành "dư nợ bình quân mỗi khoản vay". |
| aivb-a3 (g2) | Chiều tốt – xấu của hạng điểm A–D chưa chốt; tỷ lệ duyệt theo hạng không đơn điệu (A 70,9%, B 65,8%, C 68,0%, D 66,7%). | Giữ v2: đề không nêu chiều của hạng. |
| aivb-a6 (g2) | Gộp đang quá hạn, đã cơ cấu lại, đã xử lý rủi ro thành "khoản vay có vấn đề". | Giữ; yêu cầu liệt kê đủ ba trạng thái. |
| Khái niệm `chi-nhanh` (g2) | Định nghĩa do người soạn viết, chưa đối chiếu Luật Các tổ chức tín dụng. | Đối chiếu Luật Các TCTD 2024 trước khi phát hành; trong lúc chờ giữ nguyên. |
| aivb-j5 (g3) | Mọi khoản "lệch" đều là thấu chi (OD_IND, OD_BIZ); chưa xác nhận `principal` của thấu chi là hạn mức. | Nếu đúng là hạn mức: thêm `\luuy` nêu điều này, giữ SQL. |
| aivb-j7 (g3) | Theo TT17, đồng chủ tài khoản có được coi là "đứng tên" không. | Giữ v2: thư chỉ gửi `'PRIMARY_OWNER'`, không nhận định. |
| aivb-q3 (g3) | Hợp đồng `'RENEWED'` (4.478) có thuộc mặt bằng lãi suất "còn hiệu lực" không. | Giữ v2: chỉ xét `'ACTIVE'`, đề ghi rõ. |
| aivb-t9 (g4) | Khoản vay đã cơ cấu lại, đã xử lý rủi ro còn kỳ quá hạn có phải điểm cần rà không. | Giữ khung báo cáo chất lượng danh mục. |
| aivb-f6 (g4) | Số dư tài khoản chung tính hết cho chủ tài khoản. | Giữ quy ước v2 (đồng chủ cùng sở hữu). |
| aivb-t1 (g4) | Bước 4 "đã tất toán" có nên giữ trong phễu. | Giữ v2; phương án thay ("chưa từng có kỳ quá hạn") để bản sau. |
| aivb-t2 (g4) | Định nghĩa lệch loại 2 (lệnh bị đảo mà bút toán gốc chưa có bút toán ngược chiều) và câu bổ sung trong khái niệm `giao-dich-bi-dao`. | Duyệt câu bổ sung, đưa vào STYLE-aivb mục E. |
| aivb-t6 (g4) | Chênh lệch lãi dự thu − lãi dự trả có đủ nghĩa, hay dùng tỷ lệ lãi dự trả / lãi dự thu. | Giữ chênh lệch (đơn vị tiền). |
| aivb-f5 (g4) | Cohort 2018, 2019 bị cửa sổ dữ liệu cắt. | Giữ SQL; thêm `\luuy` nêu cohort đầu bị cắt. |
| aivb-k5 (g5) | Diễn giải bảng đối chiếu: khoản cơ cấu lại không còn kỳ quá hạn, khoản đã xử lý rủi ro còn kỳ `'OVERDUE'`. | Xác nhận diễn giải v2. |
| aivb-k2 (g5) | Câu dựa trên cửa sổ dữ liệu (lệnh chỉ có năm 2026), trình bày là kho báo cáo chỉ giữ năm hiện hành. | Giữ v2. |
| aivb-k4 (g5) | Giao chỉ tiêu bổ sung hồ sơ theo tỉnh cư trú hay theo chi nhánh quản lý. | Giữ v2. |

**jelly**

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| jelly-q5 (g3) | Cửa sổ doanh thu cho ROAS đã đổi sang D0–D29; cần chuẩn chung cho cả bộ. | Chốt D0–D29 (D30) cho cả bộ, ghi vào STYLE-jelly mục E. |
| jelly-k6 (g5) | Đếm 243 ngày-người lệch quá 0,00005 USD, lệch lớn nhất chỉ 0,00007 USD; có thể vẫn do làm tròn từng lần xem. | Giữ SQL; diễn giải là "lệch do cách làm tròn", bỏ chữ "lệch thật". |
| jelly-a4 (g2) | Khi xếp độ khó, có tính lượt gặp sự cố vào mẫu số của tỷ lệ thắng không. | Giữ định nghĩa STYLE mục E (mẫu số gồm lượt sự cố). |
| jelly-n3 (g1) | Lượt bỏ cuộc, gặp sự cố ghi 0 lượt đi nên bị gán `'het_luot_di'`. | Giữ v2 (đã nêu trong `\luuy`). |
| jelly-n1 (g1) | Ý nghĩa `level_id_if_relevant` với Booster Bundle mua ở cửa hàng (màn sắp chơi hay màn gần nhất). | Giữ `\luuy` trung tính của v2. |
| jelly-s1 (g2) | Chưa rõ `session_start` ghi theo giờ địa phương hay một múi giờ chung. | Giữ, không nhắc múi giờ cho tới khi có nguồn. |
| jelly-f1 (g4) | Chọn màn cần chỉnh độ khó theo số lượt bỏ cuộc hay tỷ lệ bỏ cuộc. | Giữ số lượt (v2, đã giải thích ở `\luuy`). |
| jelly-t4 (g4) | Đối soát người cài với chi phí theo chiến dịch × thị trường × ngày × nền tảng; bỏ Organic khỏi đối soát. | Giữ v2. |

**hr**

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| hr-q3 (g3) | Câu nêu `employee_id` của người có điểm gắn kết cao nhất để mời chia sẻ, có thể trái nguyên tắc bảo mật khảo sát. | Đổi mục đích thành "mức gắn kết cao nhất mỗi nhóm", bỏ `employee_id` (đổi SQL). |
| hr-q2 (g3) | 260/317 yêu cầu trong kết quả là tuyển thay thế (`'Backfill'`); chỗ trống bằng 0 tháng 12 có thể chính là kết quả của các yêu cầu này. | Giữ SQL; thêm `\luuy` nêu tỷ trọng `'Backfill'`. |
| hr-q4 (g3) | Phiếu khảo sát cùng quý với tháng nghỉ có thể làm sau ngày nghỉ. | Giữ cách tính tới hết quý có tháng nghỉ (v2). |
| hr-t7 (g4) | 140 người `tenure_months = 0` tháng 2024-01 bị khái niệm `nhan-vien-moi` loại. | Giữ định nghĩa STYLE-hr. |
| hr-k2 (g5) | Ngưỡng rà soát nghỉ hưu "từ 60 tuổi" là quy tắc nội bộ; dữ liệu 6 nước, BLLĐ 2019 Điều 169 có lộ trình riêng nam, nữ. | Giữ ngưỡng, đề gọi rõ là "quy tắc nội bộ của công ty". |
| hr-r5 (g1) | 18.981 dòng có `months_since_promotion > tenure_months`; kết quả câu không bị ảnh hưởng. | Giữ đề. |
| hr-n9 (g1) | Mốc 176 giờ là giả định; NĐ 145/2020 Điều 55 tính theo số ngày làm việc của doanh nghiệp. | Giữ (đề đã ghi là giả định). |
| hr-s4 (g2) | Dòng quyết định đổi thành "hẹn ngày đi làm sớm hơn trong thư mời làm việc". | Xác nhận v2. |

**mkt**

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| mkt-t5 (g4) | Ba tuần cuối tháng 6/2025 giảm về 0 vì dữ liệu chỉ có chiến dịch bắt đầu tới 24/6/2025, trong khi bối cảnh là xếp người cho quý 3. | Đổi khoảng xét sang quý 1/2025 (đổi SQL). |
| mkt-a5 (g2) | Ngưỡng đặt trên số chiến dịch có lãi gần như chỉ phản ánh số chiến dịch mở trong ngày (tỷ lệ có lãi 75–80%). | Giữ số đếm để dạy `HAVING`; thêm cột tỷ lệ ở bản sau. Mã: xem 3.6. |
| mkt-j3 (g3) | Số liệu theo kênh là lượt hiển thị của cả chiến dịch, dùng cho việc làm việc với đối tác kênh. | Xác nhận v2. |
| mkt-q3 (g3) | CTR các loại chênh dưới 0,1 điểm phần trăm, chưa đủ cho quyết định duyệt nội dung. | Giữ v2 ("xem kỹ hơn", không chuyển ngân sách). |
| mkt-q9 (g3) | Ý "điểm tương tác chỉ so được giữa các chiến dịch cùng loại" không có nguồn. | Giữ v2 (ý của người hỏi, đã bỏ khỏi `\luuy`). |
| mkt-p4 (g5) | Email và WhatsApp có xếp chung "kênh liên hệ trực tiếp" được không. | Giữ v2: gọi đúng tên hai kênh. |

### 3.4. Cấp độ và module

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| scm-k3, p7, k6, k2, k1, p1, p2 (g5) | k3, p7 (sửa một biểu thức trên 1 bảng) có thể hạ Dễ; k6 Khó hơi nhẹ; k2 Trung bình hơi cao; k1 Dễ, p1 Cơ bản, p2 Dễ nằm ngoài khung M9, M10. | Hạ k3, p7 xuống Dễ; giữ các câu còn lại; chấp nhận optimize Cơ bản/Dễ ở M10. |
| aivb-j6, aivb-q9 (g3) | j6 gần mức Dễ; q9 lỗi một ký tự, gần mức Cơ bản. | Giữ cấp, thêm một bẫy dữ liệu cho j6 và một lỗi thứ hai cho starter q9. |
| aivb-f7 (g4) | C đề xuất hạ Dễ; M8 chỉ có cấp Trung bình, Khó. | Giữ Trung bình. |
| aivb-k6 (g5) | Cấp Khó, kỹ năng chính ở mức Trung bình, độ khó chủ yếu từ ERD nhiễu. | Hạ Trung bình. |
| aivb-q2 (g3) | Đã đổi Dễ → Trung bình; M6 vẫn có câu Dễ (q1, q7). | Chấp nhận (bản đồ v2 đã cập nhật). |
| jelly-j5 (g3) | Đã hạ Trung bình → Dễ. | Chấp nhận (bản đồ v2 đã cập nhật). |
| jelly-t7, jelly-f9 (g4) | Lỗi một chỗ (`UNION`, `PARTITION BY`) đang ở Trung bình. | Giữ Trung bình (M7, M8 không có Dễ). |
| jelly-f6 (g4) | M8 có ba câu top 3 bằng `ROW_NUMBER` (f1, f6, f7). | Đổi kỹ năng f6 sang `NTILE` hoặc `FIRST_VALUE` (đổi SQL). |
| hr-r4, r6, r8 (g1) | Cấp Dễ ở M1–2 chỉ dùng 1 bảng, không `JOIN` (module chưa học nối bảng). | Chấp nhận cách hiểu "Dễ = Cơ bản + một bẫy" ở M1–2; hạ r8 về Cơ bản. |
| hr-a6 (g2) | eNPS theo quý: 1 bảng, `SUM(CASE)`, đang Trung bình. | Giữ Trung bình (độ sâu nghiệp vụ eNPS). |
| hr-a3 (g2) | 1 bảng, 1 lần gom, gợi ý nấc 2 còn công thức `COUNT(*) / 12`. | Hạ Dễ. |
| hr M3, M4 (g2) | Sau sửa: M3 có 4 Cơ bản, 5 Dễ; M4 có 5 Dễ, 4 Trung bình. | Chấp nhận (bản đồ v2 đã cập nhật). |
| hr-f5, hr-c8, hr-t8 (g4) | Sát ranh giới cấp. | Giữ cấp bản đồ. |
| hr-k2, k5, k8, p1, p7, k4, k6 (g5) | k2, k5, k8, p1, p7 ở Trung bình nhưng gần Cơ bản/Dễ; k4, k6 ở Khó nhưng gần Trung bình. | Giữ cấp bản đồ; ghi lý do ở `\ghichuthietke`. |
| hr-p9 (g5) | Kỹ năng chính (khung `ROWS`/`RANGE`) gần module hàm cửa sổ hơn M10. | Giữ ở M10. |
| mkt-r4, r5, r6, n3, n5, n9 (g1) | ERD vẽ 2 bảng cho đủ khung Dễ nhưng câu chỉ cần 1 bảng; r6 hạ Cơ bản sẽ trùng ô với r1. | Chấp nhận cho M1–2 (cùng quyết định với hr-r4…r8). |
| mkt-t7, mkt-t9 (g4) | t7 chỉ sửa một từ khoá (`UNION` → `UNION ALL`); t9 chỉ dùng 1 bảng. | Giữ cấp bản đồ. |
| mkt-p1, k8, p9, p7 (g5) | p1 kỹ thuật bậc Cơ bản đang Trung bình; k8 sửa một toán tử; p9 Khó gần Trung bình; p7 một lọc, một nối. | Giữ cấp bản đồ. |
| mkt-p3 (g5) | Starter đổi sang "ba nhánh theo thương hiệu" (gần bậc Dễ) để có hoà thật ở hidden-1 mà không quá giờ. | Giữ Khó (bẫy hoà, hàm cửa sổ). |

### 3.5. Quy ước chung

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| Case cả 5 bộ (scm g3; hr g1) | "Đúng. …" / "Chưa đúng. …" ở bước kết luận: scm, aivb, jelly, mkt dùng đủ cặp (20–22 phương án sai mở bằng "Chưa đúng."); hr đã bỏ cả 20 theo STYLE B.6, trong khi STYLE-hr kế thừa STYLE-scm G.4. | Dùng đủ cặp ở cả 5 bộ theo G.4; thêm lại 20 tiền tố ở hr. |
| scm-c1, c2; mkt-c1, c2; jelly-c1 b1 (g1) | Case Cơ bản dùng `GROUP BY`, `SUM` (Module 4) trong gói Module 1–2. | Cho phép case vượt module ở bước SQL; ghi lý do ở `\ghichuthietke`. |
| ERD có bảng không dùng (aivb g1: R4, R5, R6, R9, N3, N4, N5, N6, N8, N9; hr g2: M3–4; hr g4: t5, t7, f4, f8 còn 4 bảng nhiễu) | Vẽ thêm bảng không cần nối để đủ cỡ ERD theo cấp. | Chấp nhận bảng nhiễu từ cấp Dễ; ở Khó giữ tối đa 2 bảng nhiễu. |
| scm-r1, n4, n6, n8 (g1) | Gợi ý nấc 2 đưa gần trọn biểu thức đáp án; gợi ý trả phí nên ảnh hưởng điểm. | Chấp nhận một khung một dòng ở nấc cuối (STYLE-scm G.5). |
| scm-j6/a8, scm-j4/a2 (g2, g3) | Trùng ô dạng × mảng × cấp × hình thức giữa hai gói; j6 trùng cả chủ đề biên lợi nhuận gộp theo ngành hàng. | Viết lại j6 sang chủ đề khác; giữ j4. |
| mkt-f2/f8 (g4) | f2 trùng kết quả các dòng Purplle của f8; c7.b2 cũng tính tăng trưởng so tháng trước. | Giữ (f2 dạy `LAG`, f8 dạy `PARTITION BY`). |
| STYLE-scm A.3 (g1) | Chữ "tự áp mã" cho nhóm `'manual'` dễ hiểu nhầm; các gói dùng "tự nhập voucher". | Sửa STYLE-scm A.3 thành "tự nhập voucher". |
| Khái niệm `kenh-thu-hut` (jelly g2: s9, a3, c4) | Chưa có trong 22 khái niệm của STYLE-jelly mục E. | Duyệt và bổ sung vào STYLE-jelly mục E. |
| hr-r1, hr-r3 (g1) | Tiêu đề 12 tiếng, vượt giới hạn 10 tiếng của B.1. | Rút, ví dụ "Ai ở Việt Nam làm thêm từ 30 giờ tháng 12/2025?". |

Mục "khuôn Em … giúp anh/chị" của hr g3 đã xử lý ở lượt rà giọng văn (38 → 11 chỗ), không cần quyết.

### 3.6. Mã câu lệch nội dung

Quy tắc hiện tại (BRIEF-SUA mục 3): không đổi `ma`. Các câu chưa nhập hệ thống.

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| mkt-a5-ngay-tren-500-chien-dich (g2) | Mã nói 500 chiến dịch, đề nói 350 chiến dịch có lãi. | Đổi mã (ví dụ `…-ngay-tren-350-co-lai`). |
| mkt-c3-thang-nykaa-mo-nhieu-nhat (g2) | v2 hỏi Purplle. | Đổi `nykaa` thành `purplle`. |
| mkt-c2-nhieu-don-vao-thuong-hieu-nao (g1) | Nội dung đã đổi sang file thô thiếu nhiều nhất. | Đổi thành `mkt-c2-file-tho-thieu-nhieu-nhat`. |
| mkt-p3-top-3-khong-dem-tuong-quan (g5) | Starter đã đổi sang "ba nhánh theo thương hiệu". | Đổi mã, bỏ chữ "tuong-quan". |
| aivb-s8-lenh-hoan-theo-thang (g2) | "hoan" lệch STYLE A.5. | Đổi thành `aivb-s8-lenh-bi-dao-theo-thang`. |
| aivb-t5-kenh-loai-giao-dich-ty-le-hoan (g4) | Cùng lỗi chữ "hoan". | Đổi thành `…-ty-le-bi-dao`. |
| jelly-q4-ngay-dau-cao-nhat (g3) | Câu đã đổi sang so với bình quân tháng. | Đổi thành `jelly-q4-ngay-dau-tren-tb-thang`. |
| jelly-n3-nhom-buoc-du, jelly-n7-…-crash-null (g1) | n3 dùng "bước" cho lượt đi; n7 bẫy là khoảng trắng, mã ghi null. | Đổi `buoc` thành `luot-di`; n7 đổi `null` thành `khoang-trang`. |
| jelly-n9 (g1) | `domain=customer`, trong khi STYLE-jelly G xếp người chơi trả tiền vào `sales`. | Đổi `domain` sang `sales`, cập nhật bản đồ. |
| hr-s5 (`…-q3`), hr-s7 (`…-null`) (g2) | Mã không còn khớp hẳn nội dung sau khi sửa. | Đổi mã theo nội dung v2. |

Đề xuất chung: đổi một lượt cho mọi mã trên trước khi nhập hệ thống, cập nhật `BAN-DO-100-CAU.md` cùng lúc; sau khi nhập thì khoá `ma`.

### 3.7. Vai người hỏi, mảng, bối cảnh

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| scm-c6 (g3) | Mảng `marketing` cho case vận hành ngày cao điểm. | Giữ theo STYLE-scm G.8 (ngày cao điểm thuộc marketing). |
| scm-j8 (g3) | Vai "Trưởng ngành hàng" hỏi so sánh mọi ngành hàng. | Giữ. |
| scm-q2 (g3) | Vai người gửi thư nhắc chất lượng đã đổi sang Nhân viên mua hàng. | Xác nhận v2. |
| aivb-p9 (g5) | Vai người hỏi đã đổi sang Kế toán giao dịch. | Xác nhận v2. |
| mkt-s4 (g2) | Lý do "đại lý YouTube đối soát theo kênh ghi đầu" hơi gượng. | Giữ đến khi có tình huống thật hơn. |
| mkt-t6 (g4) | Mảng đổi customer → finance theo người kiểm C. | Chấp nhận (bản đồ v2 đã cập nhật). |

### 3.8. Còn để lại sau rà giọng văn (RS, ngoài DA-SUA)

| Mã câu | Vấn đề | Đề xuất mặc định |
|---|---|---|
| aivb g1, g3 (phân khúc `'AFFLUENT'`) | Gói gọi "giàu có", STYLE A.1 gợi ý "khá giả"; STYLE ưu tiên `ref_segment.segment_name`, chưa đối chiếu DB. | Dùng đúng `segment_name`; nếu là tiếng Anh thì dùng "khá giả". |
| aivb (tên nhân vật) | Một tên giữ vai khác nhau giữa các gói (ví dụ "Chị Hạnh" ở ba vai). | Lập bảng vai – tên cố định như mkt đã làm. |
| hr-r4 (g1) | Tiêu đề giữ "Account Executive" (giá trị `job_role`); STYLE-hr chưa có tên tiếng Việt. | Giữ, giải nghĩa "(nhân viên phụ trách khách hàng)" ở lời nhắn. |
| scm-a8 (g2) | `\luuy` vẫn gợi cách tính đúng, trùng ý `\goiy` nấc 1. | Rút `\luuy` về câu định nghĩa trung tính. |
| mkt g3 (`kenh-da-tri`) | Khái niệm ghi "không phải kênh chính", lệch STYLE-mkt mục E ("không phải mức ưu tiên"). | Chép đúng văn bản mục E. |
| mkt-f9 (g4) | Lời nhắn mới nêu "Tira Beauty có đủ năm loại chiến dịch" quý 1/2025, cần người nắm dữ liệu xác nhận. | Kiểm bằng một truy vấn đếm trước khi phát hành. |
| mkt (mã còn tên kỹ thuật) | Mã có `luat`, `khong-dung-ham`, `tim-trung-khong-tu-noi`, `exists-thay-join-distinct`; tiêu đề hiển thị đã sạch. | Gộp vào lượt đổi mã ở 3.6 nếu giảng viên đồng ý đổi. |
| mkt (lời nhắn còn "Sửa truy vấn dưới đây để …", 9 chỗ) | Khung câu Sửa lỗi theo gói mẫu, đã giảm 8 chỗ. | Giữ. |

---

## 4. Quyết định tạm trong STYLE mục G

| Bộ | Nội dung mục G | Trạng thái |
|---|---|---|
| scm | G.1 gọi tên kỹ thuật SQL ("CTE", "hàm cửa sổ") trong `yeucau`, `\goiy`; bối cảnh và tiêu đề không nhắc. G.2 `workload_ratio` gọi "tỷ lệ tải", dùng cột có sẵn. G.3 fill rate = 1 − tổng `thieu_hut` / tổng `sold`, định nghĩa trong từng câu. G.4 bước kết luận dùng "Đúng. …" / "Chưa đúng. …". G.5 gợi ý được nêu tên hàm, mệnh đề; không viết sẵn câu SQL hay khung nhiều dòng. G.6 "hạng ABC". G.7 P95 trên MySQL theo một quy tắc ghi rõ (CUME_DIST ≥ 0,95 hoặc vị trí CEIL(0,95 × n)). G.8 ánh xạ 6 khoá `domain` (ngày cao điểm, voucher thuộc `marketing`). | Tạm 10/11/2026, chờ duyệt cùng gói 1 |
| aivb | G.1 áp dụng nguyên G.1–G.7 của scm. G.2 câu có số ngày quá hạn, tuổi, thâm niên ghi ngày tham chiếu bằng giá trị DB. G.3 câu có tiền ghi đơn vị cột kết quả; lãi suất ghi "%/năm" hoặc "tỷ lệ". G.4 ánh xạ 6 khoá `domain` (`marketing` chỉ hỏi kênh và phân khúc; `after_sales` = chất lượng tín dụng và giao dịch lỗi). | Tạm 10/11/2026, chờ duyệt |
| hr | Mục G là ánh xạ 6 khoá `domain` mượn tên (operations = vận hành nhân sự, finance = tiền lương, customer = nhân viên và giữ chân, marketing = tuyển dụng, sales = khối Kinh doanh, after_sales = nghỉ việc). Quyết định giọng văn kế thừa STYLE-scm G. | Ghi "CẦN DEV DUYỆT"; `sales` mỏng (chỉ phòng `'Sales'`) |
| jelly | Mục G là ánh xạ 6 khoá `domain` (customer = người chơi, sales = mua trong ứng dụng, marketing = thu hút và sự kiện, operations = vận hành game, finance = doanh thu, after_sales = chất lượng sau phát hành). Kế thừa STYLE-scm G.1, G.5. | `after_sales` mỏng (hoàn tiền bằng 0, không có ticket) |
| mkt | Mục G là ánh xạ 6 khoá `domain` theo quyết định mà câu phục vụ; `after_sales` không dùng (không có dữ liệu). Kế thừa STYLE-scm G. | |

Mục F (điểm cần giảng viên chốt về thuật ngữ) của 5 file STYLE vẫn mở, chủ yếu do thiếu giáo trình bản giấy (NEU, UEH, TMU, Học viện Ngân hàng, ULSA) để đối chiếu. Một số điểm F đã có quyết định tạm ở G của scm (CTE, tỷ lệ tải, fill rate, "Đúng.", gợi ý nấc 2, hạng ABC, P95).

---

## 5. Giới hạn đã biết

| Giới hạn | Ảnh hưởng | Ghi chú |
|---|---|---|
| Ràng buộc optimize (`quettoida`, `ngansach`) đo bằng `EXPLAIN ANALYZE` trên `public` | Kế hoạch chạy có thể khác trên `hidden-1` hoặc máy chấm khác | aivb-p1: Index range scan chỉ rẻ hơn Table scan khoảng 6% theo ước lượng; mkt-p2 đã nới `ngansach` 2 → 3 sau khi lời giải hợp lý ra 2,03 lần |
| Máy chấm cần `sql_mode` mặc định MySQL 8.0 (có `NO_ZERO_DATE`) | mkt-k4 đổi kết quả nếu `sql_mode` khác | Máy dựng: MySQL 8.0.46, `utf8mb4_0900_ai_ci`; `EXCEPT`/`INTERSECT` chỉ có từ 8.0.31 |
| Dữ liệu tổng hợp, các nhóm rất gần nhau | Kết luận case chỉ nêu "chênh nhỏ", không quy nguyên nhân | STYLE-mkt M5, STYLE-jelly K37, STYLE-hr H5; mkt: ROI bình quân theo loại 2,649–2,715 |
| Chỉ có một biến thể ẩn (`<bo>_hidden_1`), không có `hidden_2` | Một số bẫy chưa bắt được | jelly-r8, jelly-k1, aivb-n9/c2 ở biên (mục 3.1) |
| aivb hidden-1: `running_balance` của bút toán còn lại không tính lại | Không ra câu đối soát `running_balance` liên tiếp | `mysql/README-aivb.md` |
| hr hidden-1: `position_plan.actual_headcount` không khớp số dòng tháng 12; một số `manager_id` trỏ người đã bị bỏ | Câu đối soát định biên chỉ đúng trên public; tự nối rơi thêm dòng ở hidden-1 | `mysql/README-hr.md` |
| Cửa sổ dữ liệu rút gọn hoặc thiếu | scm: `sales` chỉ tháng 7/2017, tồn kho 2017-01 → 2017-08; mkt: 2025-06 chỉ tới 24/6, tuần 2025-W27 có 1 ngày; jelly: 60 ngày 2026-07-01 → 2026-08-29; aivb: lệnh chỉ năm 2026 | Ảnh hưởng mkt-t5, aivb-k2, aivb-f5 (mục 3.3) |
| Mảng nghiệp vụ mỏng | hr `sales`, jelly `after_sales`, aivb `marketing`; mkt không dùng `after_sales` | Báo cáo theo mảng trên giao diện lệch số câu |
| `BANG-PHAN-CONG.md` chưa cập nhật sau bước 6 | scm g1, scm g4, aivb g1, aivb g2, aivb g5 còn ghi "chờ hidden-2" hoặc "hai biến thể giống, chờ GV" dù DA-SUA đã chuyển sang "Đã xử lý" | Cần sửa cột trạng thái trước khi bàn giao |
| Bộ kiểm chạy thật cả 25 gói sau bước 6 | Các file đã đọc chỉ ghi kiểm tĩnh và chạy solution theo câu | Đối chiếu `cong-cu/ket-qua/` trước khi phát hành |
