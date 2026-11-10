# Quyết định chung cho bộ 500 câu Luyện SQL

Ngày: 10/11/2026, bản đầu ghi lúc 22:50. Phạm vi: 5 bộ `scm`, `aivb`, `jelly`, `hr`, `mkt`. Thay cho cột "Đề xuất mặc định" của `BAO-CAO-TONG-HOP.md` mục 3.4 (19 mục) và 3.5 (9 mục).

**Thứ tự ưu tiên: `quy_chuan` (quy_chuan.rar) > `QUYET-DINH-CHUNG.md` > `style/STYLE-<bo>.md` > brief** (sửa theo quy_chuan lúc 23:05, theo yêu cầu giảng viên). Trong `quy_chuan`: văn bản (`CHOT-FORMAT-CAU-HOI.md`, `CHOT-LO-TRINH.md` – gọi tắt **CHOT**; `DOC_TRUOC.md`; `Huong-dan-cho-team-noi-dung.md` – **HD**; `goi-cau-hoi-mau/HUONG_DAN.md`) quy định thì theo văn bản; chỗ văn bản không nói thì gói mẫu (`goi-cau-hoi-mau/cau-hoi.tex`, `solution.sql`) và lộ trình (`lo-trinh-sql/assets/js/data.js`) là chuẩn. HackerRank (**HR-x**, nguồn ở mục 4) chỉ là tham khảo bổ sung khi quy chuẩn để ngỏ.

Người áp dụng: 5 agent theo bộ sửa file câu hỏi; mục G của 5 file STYLE đã chép lại các quyết định này. Đổi quyết định nào thì ghi "sửa lúc hh:mm" ngay tại dòng đó.

---

## 0. Thứ tự ưu tiên và đối chiếu với quy chuẩn (10/11/2026, 23:05)

**Thứ tự ưu tiên: quy_chuan (quy_chuan.rar) > QUYET-DINH-CHUNG.md > STYLE-<bo>.md > brief.**

Bản quy chuẩn dùng: `quy_chuan\` ở thư mục gốc. Đã so với `H:\My Drive\09._PC\Giang-day\Soan bai\Ra de SQL\quy_chuan.rar` (sửa 10/11 15:39, 3.640.339 byte, mới hơn bản giải nén): giải nén lại vào thư mục nháp bằng 7-Zip, 20 file giống hệt từng byte, không có gì mới.

### 0.1. Các điểm đã sửa theo quy chuẩn lúc 23:05

| # | Mục | Cũ | Mới | Căn cứ trong quy_chuan |
|---|---|---|---|---|
| 1 | 1.1 kết luận case | "Đúng. " / "Chưa đúng. " ở mọi phương án; cấm "Đúng:"; ≤ 30 tiếng | "Đúng: " ở phương án đúng; phương án sai **không tiền tố**, nêu thẳng chỗ sai; ≤ 35 tiếng | `goi-cau-hoi-mau/cau-hoi.tex` c1–c4 (cả 4 case mẫu) |
| 2 | 1.4 gợi ý | Nấc cuối phải để trống ≥ 1 thành phần (giá trị lọc, mẫu số, tiêu chí hoà) | Nấc cuối được nêu trọn một biểu thức một dòng, kể cả giá trị lọc, tiêu chí hoà; vẫn cấm cả câu SQL, khung nhiều dòng | `cau-hoi.tex` w1 (giá trị lọc), w3 (tiêu chí hoà `product_id`), o3, o4 |
| 3 | 1.9 tiêu đề | ≤ 10 tiếng; STYLE-scm G.1 cấm kỹ thuật SQL ở tiêu đề "(quy chuẩn)" | ≤ 13 tiếng; câu Tối ưu được nêu ràng buộc trong tiêu đề; cấm tên kỹ thuật SQL chỉ là luật của quy chuẩn ở **bối cảnh** | `cau-hoi.tex` w3, w4, o4 (11 tiếng), o3 (13 tiếng), o1, o4 (có kỹ thuật); CHOT-FORMAT mục 3 ③ |
| 4 | 1.3 ERD Khó | Bảng nhiễu phải có đường nối đúng; Khó luôn 1–2 bảng nhiễu | Khó chỉ khoá, **không vẽ `\erdnoi`**, cách nối trong `\erdkhoa`; bảng nhiễu nên (không bắt buộc) có khoá chung; lời giải dùng ≤ 3 bảng thì được thêm bảng nhiễu cho đủ 5 bảng | CHOT-FORMAT mục 3; HD mục 5; `cau-hoi.tex` w4 ("không vẽ đường nối"), d4 (3 bảng nhiễu), o4 (4 bảng nhiễu, không nối `sales`) |
| 5 | 2.1; 2.3 #3, #7, #17 | "M7, M8 không có Dễ": sửa lỗi một chỗ tính Trung bình; cấp phải nằm trong khung cấp module | Bỏ ngoại lệ: sửa lỗi một chỗ dễ thấy là Dễ, Trung bình cần lỗi khó thấy hoặc thêm lỗi, bẫy thật. aivb-f7, jelly-t7, jelly-f9, mkt-t7 chấm lại | HD mục 6 (Sửa lỗi Dễ = `COUNT(*)` thay `COUNT(DISTINCT)`; "lên cấp phải khó hơn thật"); `lo-trinh-sql/assets/js/data.js`: cả 10 module đều có bài basic, easy, medium, hard |
| 6 | 2.2 số bảng Khó, kỹ năng chính | Khó ≥ 4 bảng lời giải; Cơ bản M1–4 … Khó M7–10 | Khó không bắt buộc ≥ 4 bảng; bỏ gắn cấp với module | `cau-hoi.tex` o4 (Khó, 1 bảng `sales`), d4 (2 bảng); `data.js` |
| 7 | 1.10 tỷ lệ, kiểu giá trị | Cột tỷ lệ bắt buộc đuôi `_pct`; năm trả số | Tên cột tuỳ; năm trả số trừ khi đề ghi rõ chuỗi | `cau-hoi.tex` w4 (`ty_le_tra` là phần trăm), c4 (`thay_doi_pct`), o2 (`nam` là chuỗi) |
| 8 | Thứ bậc căn cứ | CHOT > HD > file này > STYLE; HackerRank khi CHOT để ngỏ | quy_chuan (văn bản, rồi gói mẫu và lộ trình) > file này > STYLE > brief; HackerRank chỉ tham khảo | Yêu cầu giảng viên 10/11 |

Các dòng tương ứng ở mục G của 5 file `style/STYLE-<bo>.md` (khối "Quyết định chung 5 bộ", STYLE-scm G.1, G.4, G.5, aivb G.1, dòng "Riêng" của aivb, jelly, hr, mkt) đã sửa cùng lúc, ghi "sửa theo quy_chuan".

### 0.2. Đối chiếu từng quyết định

| Quyết định | Kết quả | Ghi chú |
|---|---|---|
| 1.1 kết luận case | Mâu thuẫn → đã sửa (0.1 #1) | Ba phương án, đúng một `\phuongan*`: khớp mẫu và HUONG_DAN |
| 1.2 case Cơ bản dùng `GROUP BY` | Khớp | Mẫu c1 |
| 1.3 số bảng ERD theo cấp | Khớp | CHOT-FORMAT mục 3 |
| 1.3 bảng nhiễu Dễ ≤ 1, Trung bình ≤ 1 | Quy chuẩn không nói rõ → giữ, quy ước bổ sung | HD mục 5 để người soạn chọn bảng nhiễu; chỉ cấp Khó ghi số bảng nhiễu |
| 1.3 bảng nhiễu và đường nối ở Khó | Mâu thuẫn → đã sửa (0.1 #4) | |
| 1.4 gợi ý | Mâu thuẫn → đã sửa (0.1 #2) | Số nấc 1–2 khớp HD mục 10 bước 7 |
| 1.5 trùng ô | Khớp | HD mục 10 bước 1 |
| 1.6, 1.7, 1.8 | Quy chuẩn không nói → giữ, quy ước bổ sung | `kenh-thu-hut` trùng mã khái niệm của gói mẫu; bộ jelly giữ định nghĩa riêng |
| 1.9 tiêu đề | Mâu thuẫn → đã sửa (0.1 #3) | |
| 1.10 thứ tự, tiêu chí phụ, hoà ở top N | Khớp (chặt hơn mẫu w2, c1) | CHOT-FORMAT mục 3 ④ "quy tắc hoà", mục 6 |
| 1.10 làm tròn, sai số, cột, mốc thời gian | Khớp | Mẫu w4, d4; "trong năm 2022" như mẫu w1 là đủ hai cận |
| 1.10 cột `_pct`, năm trả số | Mâu thuẫn nhẹ → đã sửa (0.1 #7) | |
| 1.10 NULL, tỷ lệ 0–1 với `saiso=0.0001` | Quy chuẩn không nói → giữ, quy ước bổ sung | |
| 2.1 cấp ≥ 3/5 trục; M1–3 Dễ = Cơ bản + bẫy/bước | Quy chuẩn không nói → giữ, quy ước bổ sung | HD mục 6 chỉ nêu 5 trục; `data.js` M1–3 có bài Dễ một bảng |
| 2.1 khung cấp module, ngoại lệ M7, M8 | Mâu thuẫn → đã sửa (0.1 #5) | |
| 2.1 optimize, case | Khớp | CHOT-FORMAT mục 2, 4 |
| 2.2 bảng tiêu chí | Khớp, trừ dòng số bảng Khó và kỹ năng chính (0.1 #6) | Dòng Sửa lỗi, ERD khớp HD mục 5, 6 |
| 2.3 quyết định theo câu | Khớp, trừ #3, #7, #17 (0.1 #5) | |
| Mục 3 quy tắc HackerRank | Khớp hoặc bổ sung | 3.7 khớp ERD Dễ (chữ trên đường nối) |
| STYLE G dòng chung (5 bộ) | Kết luận case, gợi ý, ERD, cấp, tỷ lệ, tiêu đề: đã sửa như 0.1; case Cơ bản, thứ tự, làm tròn, NULL: khớp hoặc bổ sung | |
| STYLE-scm G.1 "tiêu đề tuyệt đối không nhắc kỹ thuật SQL (quy chuẩn)" | Mâu thuẫn → đã sửa | Quy chuẩn chỉ cấm ở bối cảnh; mẫu o1, o4 có kỹ thuật ở tiêu đề |
| STYLE-scm G.2, G.3, G.6, G.7, G.8; aivb G.2–G.4; ánh xạ 6 khoá của jelly, hr, mkt | Khớp (6 khoá CHOT-FORMAT mục 2; cấm `PERCENTILE_CONT` mục 4) hoặc bổ sung | Tên hiển thị domain khác "Bán hàng"… của CHOT-LO-TRINH là quy ước bổ sung cho bộ ngoài Datathon |

### 0.3. Quy tắc trong brief cũ mâu thuẫn quy chuẩn (brief cũ không sửa; câu đã soạn theo các quy tắc này cần rà)

| Brief | Quy tắc | Quy chuẩn | Ảnh hưởng có thể có |
|---|---|---|---|
| BRIEF-KIEM-GOI bước 6 | Khuôn "mệnh đề: kết luận" là giọng AI | Cả 4 case mẫu viết "Đúng: …" | Người kiểm đề xuất bỏ "Đúng:" → nay dùng lại "Đúng: " |
| BRIEF-KIEM-GOI bước 4, 6 | Không nhắc kỹ thuật SQL ở **tiêu đề** | Chỉ cấm ở bối cảnh; tiêu đề mẫu o1, o4 có | Tiêu đề câu Tối ưu bị bỏ ràng buộc (không sai, không cần sửa lại) |
| BRIEF-SOAN-GOI "Phân bổ" | Cấp theo module: M1–3 chủ yếu basic/easy, M4–6 easy/medium, M7–10 medium/hard | `data.js`: mọi module đủ 4 cấp | Nguồn của ngoại lệ "M7, M8 không có Dễ"; câu sửa lỗi một chỗ bị nâng Trung bình suông |
| BRIEF-SOAN-GOI "Đầu ra"; BRIEF-KIEM-GOI; BRIEF-SUA-GOI | `BANG-PHAN-CONG.md`, `BAN-DO-GOI.md`, `REVIEW-*.md`, `DA-SUA.md` nằm trong thư mục gói | Gói đúng 4 file, zip phẳng (CHOT-FORMAT mục 4; HUONG_DAN "Tải lên") | Khi đóng zip chỉ lấy `cau-hoi.tex`, `solution.sql`, `aio-sql-cauhoi.sty`, `HUONG_DAN.md` |
| BRIEF-RA-SOAT-GIONG bước 1 | Quét "giúp anh/chị/em", "Sửa để ra đúng", "theo tab Nghiệp vụ", "không phải", "truy vấn" trong `\boicanh` như dấu hiệu giọng AI | Các cụm này có trong gói mẫu (o1, o3, d2, w4) | Chỉ giảm khi lặp; chỗ đã đổi không cần khôi phục |
| BRIEF-SUA-GOI bước 4 | Kiểm lại chỉ các câu đã sửa (gói tạm) | CHOT-FORMAT mục 10 bước 5: chỉ báo xong khi bộ kiểm cả gói 0 lỗi | Đã bù ở BRIEF-QUYET-DINH-126 bước 5 (chạy cả gói) |
| BRIEF-QUYET-DINH-126, BRIEF-KIEM-V3 | Lấy QUYET-DINH-CHUNG.md làm chuẩn cao nhất | quy_chuan đứng trên | Câu sửa ở v3 theo 1.1, 1.4, 1.9, ngoại lệ M7/M8 cũ cần rà theo 0.1. BRIEF-KIEM-V3 đã sửa |

BRIEF-BIEN-THE-AN-BO-SUNG: khớp (bẫy đặt ở biến thể ẩn, không đụng `public`, solution không ra 0 dòng: CHOT-FORMAT mục 6, HUONG_DAN "Sau khi tải lên").

---

## 1. Quy ước chung (9 mục của 3.5)

| # (1.x) | Mục | Quyết định | Căn cứ | Cách áp dụng |
|---|---|---|---|---|
| 1 | Lời giải thích ở bước kết luận case | **sửa theo quy_chuan lúc 23:05** (cau-hoi.tex c1–c4): ba phương án, đúng một `\phuongan*`. Phương án đúng mở bằng **"Đúng: "** (dấu hai chấm, như cả 4 case mẫu); phương án sai **không có tiền tố**, nêu thẳng chỗ sai. Không dùng "Chưa đúng.", "Sai:". Cũ: "Đúng. " / "Chưa đúng. " ở mọi phương án, cấm "Đúng:". | Gói mẫu c1: "Đúng: đứng đầu bảng kết quả bước 1."; phương án sai: "\code{direct} đứng cuối bảng." (không tiền tố). Lời giải thích chỉ hiện sau khi chọn. | Mọi bộ: đổi "Đúng. " thành "Đúng: ", bỏ "Chưa đúng. " ở phương án sai (hr: huỷ việc thêm lại vào 20 phương án sai). Sau tiền tố 1–2 câu, ≤ 35 tiếng (lời giải thích dài nhất của mẫu, c3, khoảng 34 tiếng), nêu bước nào cho thấy điều gì; phương án dài gần bằng nhau, không lộ đáp án (B.6). |
| 2 | Case Cơ bản dùng `GROUP BY`, `SUM` trong gói Module 1–2 | **Cho phép.** Case không thuộc module nào trên lộ trình; case Cơ bản được dùng `GROUP BY` một cột + một hàm gom trên **một bảng**, không `JOIN`, không `HAVING`, không truy vấn con. | CHOT-LO-TRINH mục 2 (4 case c1–c4 không nằm trên lộ trình); case mẫu Cơ bản `c1-kenh-nhieu-don` của CHOT chính là `GROUP BY order_source` + `COUNT(*)`; HR-1 (SQL Basic có hàm gom), HR-6 (The Blunder: gom ở mức Easy). | scm-c1, c2; mkt-c1, c2; jelly-c1.b1 giữ SQL. Ghi một dòng `\ghichuthietke`: "Case Cơ bản: GROUP BY một cột trên một bảng, theo case mẫu c1 (QUYET-DINH-CHUNG 1.2)." Case Cơ bản dùng `JOIN` thì đổi cấp hoặc bỏ nối. |
| 3 | ERD có bảng không dùng (bảng nhiễu) | **Số bảng vẽ theo CHOT mục 3** (Cơ bản 1 · Dễ 2 · Trung bình 3–4 · Khó 5–7). Bảng nhiễu: Cơ bản 0 · Dễ ≤ 1 · Trung bình ≤ 1 (quy ước bổ sung, quy chuẩn không nói rõ) · Khó 1–2, bắt buộc. **sửa theo quy_chuan lúc 23:05** (HD mục 5; cau-hoi.tex w4, d4, o4, c4): ERD Khó chỉ khoá, **không vẽ `\erdnoi`**, cách nối viết trong `\erdkhoa`; bảng nhiễu Khó nên có cột khoá chung với bảng dùng (mẫu w4) nhưng không bắt buộc (mẫu o4); câu Khó mà lời giải dùng ≤ 3 bảng được thêm bảng nhiễu cho đủ 5 bảng (mẫu d4: 3, o4: 4 bảng nhiễu). Cũ: bảng nhiễu "phải có đường nối đúng" ở mọi cấp. Bảng nhiễu ở Dễ, Trung bình có đường nối đúng với bảng dùng. Bảng nhiễu **không** làm tăng cấp. | CHOT mục 3; HD mục 5 ("Khó: chỉ khoá; thêm 1–2 bảng nhiễu; cách nối mở bằng `\erdkhoa`"); `\ghichuthietke` của w4: "không vẽ đường nối". | aivb g1 (R4, R5, R6, R9, N3, N4, N5, N6, N8, N9, cấp Dễ): giữ, mỗi câu đúng 1 bảng nhiễu. hr g2 M3–4: rà theo hạn mức trên. hr g4 t5, t7, f4, f8 (Khó, đang 4 bảng nhiễu): rút còn tối đa 2, trừ câu lời giải dùng ≤ 3 bảng. Mọi ERD Khó có `\erdnoi`: bỏ đường nối, chuyển cách nối vào `\erdkhoa`. |
| 4 | Gợi ý nấc 2 đưa gần trọn biểu thức đáp án (scm-r1, n4, n6, n8) | **sửa theo quy_chuan lúc 23:05** (cau-hoi.tex w1, w3, o3, o4): 1–2 nấc ở câu, 1 nấc ở mỗi bước case. Nấc cuối **được nêu trọn một biểu thức một dòng**, kể cả giá trị lọc hoặc tiêu chí hoà (mẫu w1: "Lọc `order_status = 'cancelled'`"; w3: `ROW_NUMBER() OVER (PARTITION BY category ORDER BY doanh_thu DESC, product_id)`). Không viết sẵn cả câu SQL, không khung nhiều dòng. Cũ: khung phải để trống ≥ 1 thành phần quyết định đúng sai. | Gói mẫu; CHOT mục 2 (gợi ý trả phí −5 điểm mỗi nấc, tối đa −50%); HD mục 10 bước 7 (1–2 gợi ý). | scm-r1, n4, n6, n8 và mọi câu đã bỏ bớt thành phần khỏi khung: giữ nguyên hoặc khôi phục đều được, không bắt buộc sửa lại. |
| 5 | Trùng ô dạng × mảng × cấp × hình thức (scm-j6/a8, scm-j4/a2) | **Viết lại scm-j6** sang chủ đề khác (không phải biên lợi nhuận gộp theo ngành hàng) và ô khác; **giữ scm-j4**. Cùng quy tắc cho jelly-j4/q5 (trùng ô trong gói 3): agent jelly đổi ô của một câu (đổi mảng hoặc dạng), câu còn lại giữ. | HD mục 10 bước 1 (chọn ô còn trống). | Agent scm cập nhật `BAN-DO-100-CAU.md` cùng lúc. Viết lại = đổi SQL, chạy lại bộ kiểm. |
| 6 | mkt-f2 trùng kết quả một phần với mkt-f8 | **Giữ cả hai.** | Hai câu dạy hai kỹ năng khác nhau (`LAG` và `PARTITION BY`); trùng một phần kết quả không phải trùng ô. | Ghi `\ghichuthietke` ở f2: "Trùng một phần kết quả với f8, giữ vì kỹ năng khác." |
| 7 | STYLE-scm A.3 "tự áp mã" | **sửa lúc 23:45, theo sách dự án**: **giữ "tự áp mã"** cho nhóm `'manual'` ("khách tự áp mã") và "hệ thống tự động áp mã" cho nhóm `'auto_apply'`. Cũ: đổi thành "tự nhập voucher". | Sách dự án eDA2026 (main.tex dòng 4556): "nhóm khách tự áp mã (\code{manual}) và nhóm được hệ thống tự động áp mã (\code{auto\_apply})"; với bộ scm, sách dự án là chuẩn cách gọi (giảng viên đã chốt). | Ghi ở STYLE-scm A.3 và G. Agent scm đổi mọi chỗ "tự nhập voucher" trong 5 gói về cách gọi của sách (đã làm 10/11). |
| 8 | Khái niệm `kenh-thu-hut` (jelly g2: s9, a3, c4) | **Duyệt.** | Ba câu đã dùng; nằm trong mảng `marketing` của STYLE-jelly G. | Ghi ở STYLE-jelly G; một định nghĩa duy nhất, chép giống hệt ở mọi gói jelly. |
| 9 | Tiêu đề 12 tiếng (hr-r1, hr-r3) | **sửa theo quy_chuan lúc 23:05**: tiêu đề ngắn, **≤ 13 tiếng** (cũ: ≤ 10). Câu Tối ưu được nêu ràng buộc trong tiêu đề. | Tiêu đề mẫu w3, w4, o4 dài 11 tiếng, o3 dài 13 tiếng; o1 "… chỉ với một lần quét", o4 "… không dùng tự nối bảng". CHOT mục 3 chỉ cấm tên kỹ thuật SQL ở **bối cảnh**. | hr-r1, hr-r3 giữ được; câu nào đã rút về ≤ 10 tiếng thì giữ. |

### 1.10. Quy ước trình bày và chấm kết quả (áp cho mọi câu write, debug, optimize và bước SQL của case)

CHOT mục 6 đã chốt cách so: theo vị trí cột, xét thứ tự khi `thutu=co` (mặc định), sai số tuyệt đối 0,01, NULL chỉ bằng NULL, chuỗi `'2019'` khác số `2019`. Máy chấm của HackerRank cũng so cả bảng kết quả với đáp án và cho đủ điểm hoặc 0 (HR-2), nên đề phải đủ chặt để chỉ một bảng kết quả đúng.

| Việc | Quy ước |
|---|---|
| Thứ tự dòng | Giữ `thutu=co`. Mọi câu nói rõ cột sắp và chiều sắp, và **luôn có tiêu chí phụ cuối cùng là khoá duy nhất** (ví dụ `supplier_id` tăng dần), để thứ tự xác định hoàn toàn. Chỉ đặt `thutu=khong` cho bước case chỉ trả 1 dòng hoặc khi đề nói rõ "không xét thứ tự". |
| Hoà ở top N | Nói rõ lấy đúng N dòng (tiêu chí phụ chọn ai) hay lấy cả người hoà (có thể hơn N dòng). Câu dạy `RANK`/`DENSE_RANK` phải nói "hoà thì cùng hạng". |
| Làm tròn | Nói số chữ số và **thời điểm làm tròn: chỉ làm tròn ở cột kết quả cuối**, không làm tròn bước trung gian (trừ khi đề nói khác). Viết trong ngoặc sau tên cột theo STYLE-scm B.3: "(phần trăm, làm tròn 2 chữ số)". Làm tròn kiểu khác `ROUND` (lên, xuống) thì nói rõ, như HackerRank ghi "round up to the next integer" (HR-6). |
| Tỷ lệ | Mặc định trả **phần trăm, 2 chữ số**; tên cột tuỳ (**sửa theo quy_chuan lúc 23:05**: bỏ bắt buộc đuôi `_pct`; mẫu w4 dùng `ty_le_tra`, c4 dùng `thay_doi_pct`). Với `saiso=0.01`, tỷ lệ dạng 0–1 quá lỏng (0,052 và 0,058 đều qua); câu nào bắt buộc trả 0–1 thì làm tròn 4 chữ số và đặt `saiso=0.0001` (quy ước bổ sung). |
| Sai số | Mặc định `saiso=0.01` (CHOT). Cột tiền lớn không cần nới; câu có cột tỷ lệ 0–1 theo dòng trên. |
| NULL | Nói rõ dòng NULL được **giữ và hiện NULL**, **thay** bằng giá trị nào (`0`, `'Không rõ'`), hay **loại**. Nếu giữ NULL ở cột sắp, nói NULL đứng đầu hay cuối (MySQL xếp NULL đầu khi tăng dần). Ví dụ của HackerRank The Report: "Print NULL as the name if the grade is less than 8" (HR-4). |
| Kiểu giá trị | Tháng, quý trả chuỗi theo dạng nêu trong đề (`'2025-12'`, `'2025-Q3'`); năm trả số, trừ khi đề ghi rõ trả chuỗi như mẫu o2 (`nam` là `'2019'`…`'2022'`; sửa theo quy_chuan lúc 23:05). Đề nói rõ. |
| Cột | Liệt kê cột trả về đúng thứ tự (so theo vị trí); tên cột chỉ để đọc. |
| Mốc thời gian | Ghi cả cận dưới và cận trên (biến thể ẩn có dòng ngoài kỳ); "trong năm 2022" như mẫu w1 là đã đủ hai cận. Câu có tuổi, thâm niên, số ngày quá hạn ghi ngày tham chiếu bằng giá trị trong DB. |

---

## 2. Thang cấp độ áp dụng chung

### 2.1. Nguyên tắc

- Khung của CHOT (HD mục 5, 6) giữ nguyên. Bảng 2.2 chỉ cụ thể hoá thành tiêu chí đếm được trên **5 trục** của HD: số bảng, số bước xử lý, mức mơ hồ của đề, số bẫy dữ liệu, độ sâu nghiệp vụ; cộng thêm trục phụ "kỹ năng chính".
- **Cấp của câu = cấp mà ít nhất 3/5 trục đạt**, trong đó trục "số bảng" đếm **bảng lời giải cần**, không đếm bảng nhiễu. ERD vẽ theo cấp đã chọn.
- Cấp do 5 trục quyết định, không do module: lộ trình chuẩn (`data.js`) cho **mọi module đủ 4 cấp**, kể cả M1 có bài Khó, M7, M8 có bài Cơ bản, Dễ (sửa theo quy_chuan lúc 23:05). Khung cấp ở `BAN-DO-100-CAU.md` chỉ để phân bổ: câu đạt cấp thấp hơn nhãn thì **thêm bẫy hoặc bước thật** cho đạt, hoặc hạ cấp và cập nhật bản đồ; không giữ nhãn cao suông. **Bỏ ngoại lệ cũ "M7, M8 không có Dễ: sửa lỗi một chỗ tính Trung bình"**: theo HD mục 6, sửa lỗi một chỗ dễ thấy là Dễ; Trung bình cần lỗi khó thấy (nối thừa nhân dòng, sai phạm vi cửa sổ, `UNION` bỏ mất dòng trùng hợp lệ).
- Ở M1–M3 chưa học nối bảng: **Dễ = Cơ bản + một bẫy hoặc một bước** trên 1 bảng; ERD vẫn 2 bảng (1 bảng nhiễu, theo 1.3).
- Optimize: cấp theo mẫu kỹ thuật viết lại của CHOT mục 4 (Cơ bản gộp nhiều lần quét thành đếm có điều kiện · Dễ `UNION ALL` → một `GROUP BY` · Trung bình gom hai lần → `AVG() OVER` · Khó tự nối cộng dồn → `SUM() OVER` + `ngansach`). Nâng một bậc so với mẫu chỉ khi có thêm ≥ 1 bẫy dữ liệu hoặc ≥ 2 bảng phải gộp quét.
- Case: số bước theo CHOT (2/3/4/5); cấp từng bước SQL không vượt cấp case.

### 2.2. Bảng tiêu chí

| Trục | Cơ bản · 10 | Dễ · 20 | Trung bình · 30 | Khó · 50 |
|---|---|---|---|---|
| Số bảng lời giải cần | 1 | 1 (M1–3) hoặc 2 có `JOIN` | 2–4 | thường ≥ 3; không bắt buộc (mẫu o4 Khó dùng 1 bảng, d4 dùng 2; sửa theo quy_chuan lúc 23:05) – ERD vẫn 5–7 bảng |
| Số bước xử lý | 1 tầng: lọc, chọn cột, tính biểu thức, đếm; `GROUP BY` một cột chỉ ở M4 và case | 2 tầng: lọc + gom; gom + `HAVING`; nối + gom | 3 tầng: CTE hoặc truy vấn con, hàm cửa sổ, `LEFT JOIN … IS NULL` | ≥ 4 tầng: nhiều CTE nối nhau, cửa sổ trên kết quả gom, nhiều nguồn |
| Mức mơ hồ của đề | Đề ghi rõ cột, giá trị lọc; ERD có giá trị mẫu | Đề ghi rõ cột; chỉ số định nghĩa ngay trong đề | Chỉ số định nghĩa ở tab Nghiệp vụ; học viên tự chọn cách | Đề nói bằng ngôn ngữ kinh doanh; học viên tự suy ra phép tính, cách nối (`\erdkhoa`) |
| Số bẫy dữ liệu | 0 (riêng cận trên của kỳ được tính là bình thường) | 1 (NULL, khoảng trắng, `COUNT(DISTINCT)`, cận trên, chia nguyên) | 1–2 (hoà hạng, trùng tên, nhân dòng khi nối) | ≥ 2, có ít nhất một chỉ lộ ở `hidden-1` |
| Độ sâu nghiệp vụ | 1 khái niệm, không công thức | 1 công thức một phép chia | Công thức 2 thành phần hoặc điều kiện theo thời điểm | Chỉ số nhiều điều kiện (định nghĩa người nghỉ, nợ quá hạn theo kỳ, cohort) |
| Kỹ năng chính (tham chiếu) | Một kỹ năng của module | Hai kỹ năng kết hợp | Kỹ năng chính của module + một bẫy | Kết hợp nhiều kỹ năng. Mọi module đều có đủ 4 cấp (`data.js`; sửa theo quy_chuan lúc 23:05, bỏ cách gắn Cơ bản M1–4 … Khó M7–10) |
| Sửa lỗi | 1 lỗi dễ thấy (sai giá trị lọc, sai toán tử) | 1 lỗi logic một chỗ (`COUNT(*)` thay `COUNT(DISTINCT)`, thiếu cận) | 1 lỗi khó thấy (nối thừa nhân dòng, sai phạm vi cửa sổ) | 2–3 lỗi chồng nhau hoặc sai định nghĩa chỉ số |
| ERD (CHOT) | 1 bảng + giá trị mẫu | 2 bảng + chữ trên đường nối | 3–4 bảng, ký hiệu 1-n | 5–7 bảng, chỉ khoá, 1–2 bảng nhiễu, `\erdkhoa` |
| Tương ứng HackerRank (tham khảo) | Easy · Basic Select (HR-3) | Easy · Aggregation, Basic Join (HR-5, HR-6); chứng chỉ SQL (Basic) gồm hàm gom và JOIN (HR-1) | Medium · Top Competitors, The Report (HR-4, HR-7); chứng chỉ SQL (Intermediate): truy vấn con, `GROUP BY`/`HAVING` | Hard · Advanced Join; chứng chỉ SQL (Advanced): CTE, hàm cửa sổ, truy vấn con tương quan, tối ưu (HR-1) |

HackerRank gộp Cơ bản và Dễ của bộ này vào một mức Easy, và đưa `JOIN` vào mức Basic. Bộ này giữ 4 cấp và điểm 10/20/30/50 của CHOT; HackerRank chỉ dùng để xác nhận `JOIN` 2 bảng, gom một tầng thuộc mức thấp, còn CTE, hàm cửa sổ, truy vấn con tương quan thuộc mức cao.

### 2.3. Quyết định cho 19 mục của 3.4

| # | Mã câu | Quyết định | Lý do theo thang |
|---|---|---|---|
| 1 | scm-k3, p7 (debug TB), k6 (write Khó), k2 (write TB), k1 (write Dễ), p1 (optimize Cơ bản), p2 (optimize Dễ), g5 | **Hạ k3, p7 xuống Dễ.** Giữ k6, k2, k1. Giữ p1 Cơ bản, p2 Dễ. | k3, p7: sửa một biểu thức trên 1 bảng = Sửa lỗi Dễ. k6: thêm 1 bẫy nếu chưa đủ ≥ 2 bẫy. p1, p2: optimize Cơ bản, Dễ là mẫu của CHOT mục 4, M10 là module duy nhất có optimize nên không coi là ngoài khung. k1 ở M9 Dễ: chấp nhận. |
| 2 | aivb-j6 (write TB), aivb-q9 (debug TB), g3 | **Giữ TB**, j6 thêm một bẫy dữ liệu, q9 thêm một lỗi thứ hai vào starter. | Hiện đạt < 3 trục TB; thêm bẫy/lỗi cho đạt thay vì hạ (khung M6). |
| 3 | aivb-f7 (debug TB), g4 | **Chấm lại** (sửa theo quy_chuan lúc 23:05): lỗi một chỗ dễ thấy → Dễ (cập nhật bản đồ); lỗi khó thấy (sai phạm vi cửa sổ) → giữ TB. Cũ: giữ TB vì "M8 không có Dễ". | HD mục 6; `data.js` M8 có bài Dễ. |
| 4 | aivb-k6 (write Khó), g5 | **Hạ TB.** | Kỹ năng chính ở mức TB; bảng nhiễu không làm tăng cấp (1.3). ERD rút còn 3–4 bảng, bỏ `\erdkhoa`. |
| 5 | aivb-q2 (Dễ → TB), g3 | **Chấp nhận.** | Đã cập nhật bản đồ v2. |
| 6 | jelly-j5 (TB → Dễ), g3 | **Chấp nhận.** | Đã cập nhật bản đồ v2. |
| 7 | jelly-t7, f9 (debug TB), g4 | **Chấm lại** như mục 3 (sửa theo quy_chuan lúc 23:05). Cũ: giữ TB vì "M7, M8 không có Dễ". | HD mục 6; `data.js` M7, M8 có bài Dễ. |
| 8 | jelly-f6 (write TB), g4 | **Đổi kỹ năng sang `FIRST_VALUE` hoặc `NTILE`** (đổi SQL). | Ba câu top 3 bằng `ROW_NUMBER` trong một module là trùng kỹ năng. |
| 9 | hr-r4, r6 (write Dễ), r8 (debug Dễ), g1 | **Giữ r4, r6 Dễ; hạ r8 về Cơ bản.** Áp chung cho M1–2 của 5 bộ. | Dễ ở M1–3 = Cơ bản + một bẫy hoặc một bước (2.1). r8 chỉ là lỗi lọc dễ thấy = Sửa lỗi Cơ bản. |
| 10 | hr-a6 (write TB), g2 | **Giữ TB.** | Độ sâu nghiệp vụ eNPS (công thức 2 thành phần) + `SUM(CASE)` theo quý: đạt trục nghiệp vụ, bước, mơ hồ. |
| 11 | hr-a3 (write TB), g2 | **Hạ Dễ.** | 1 bảng, 1 lần gom, 1 công thức một phép chia: đạt Dễ trên 4/5 trục. |
| 12 | hr M3 (4 Cơ bản, 5 Dễ), M4 (5 Dễ, 4 TB), g2 | **Chấp nhận.** | Đã cập nhật bản đồ v2. |
| 13 | hr-f5 (write Khó), c8 (case), t8 (debug TB), g4 | **Giữ cấp.** | Sát ranh giới nhưng đạt 3/5 trục; ghi điểm từng trục ở `\ghichuthietke`. |
| 14 | hr-k2, k5, k8 (TB), p1 (optimize TB), p7 (write TB), k4, k6 (Khó), g5 | **Chấm lại theo 2.2:** câu đạt < 3/5 trục cấp hiện tại thì hạ một bậc. Mặc định tạm: **hạ k2, k5, k8 về Dễ**; **p1 hạ về cấp mẫu CHOT** (gộp nhiều lần quét = Cơ bản, nâng Dễ nếu đủ điều kiện ở 2.1); **giữ p7 TB** nếu dùng chỉ mục + gom theo tháng; **k4, k6 giữ Khó** nếu thêm được bẫy thứ hai, nếu không thì hạ TB. | Thang 2.2; optimize theo CHOT mục 4. Ghi điểm 5 trục ở `\ghichuthietke`. |
| 15 | hr-p9 (write Khó), g5 | **Giữ ở M10.** | Khung `ROWS`/`RANGE` dùng trong bài kết hợp; M10 cho phép bài kết hợp. |
| 16 | mkt-r4, r5, r6, n3, n5 (write Dễ), n9 (debug Dễ), g1 | **Chấp nhận.** | Cùng quyết định với hr-r4, r6 (mục 9); ERD 2 bảng có 1 bảng nhiễu hợp lệ theo 1.3. Mỗi câu phải có một bẫy hoặc một bước thêm so với Cơ bản. |
| 17 | mkt-t7 (debug TB), mkt-t9 (debug Khó), g4 | **t7 chấm lại** như mục 3 (sửa theo quy_chuan lúc 23:05; cũ: giữ TB vì M7 không có Dễ). **t9 giữ Khó chỉ khi** starter có ≥ 2 lỗi chồng nhau hoặc sai định nghĩa "dòng trùng"; nếu không thì thêm lỗi thứ hai. | Sửa lỗi theo HD mục 6 và 2.2. |
| 18 | mkt-p1 (optimize TB), k8 (debug TB), p9 (write Khó), p7 (write TB), g5 | **p1 hạ về cấp mẫu CHOT** (như hr-p1). **k8 hạ Dễ** (sửa một toán tử). **p9 giữ Khó** nếu có ≥ 2 bẫy, nếu không thì hạ TB. **p7 giữ TB.** | Optimize theo CHOT mục 4; Sửa lỗi Dễ = lỗi logic một chỗ. |
| 19 | mkt-p3 (optimize Khó), g5 | **Giữ Khó.** | Bẫy hoà ở hidden-1 + hàm cửa sổ + `ngansach`, đúng mẫu optimize Khó. |

Hạ hoặc nâng cấp thì cập nhật cùng lúc `cap=`, ERD (theo 1.3, CHOT mục 3), số nấc gợi ý và `BAN-DO-100-CAU.md`. Mã câu (`ma`) không đổi.

---

## 3. Quy tắc viết đề rút từ HackerRank

1. Mọi câu nói rõ thứ tự sắp và chiều sắp; luôn kết thúc bằng một tiêu chí phụ là khoá duy nhất khi có thể hoà (HR-3: "choose the one that comes first when ordered alphabetically"; HR-7: "sort them by ascending hacker_id").
2. Nhiều tầng sắp thì nêu đủ từng tầng, kể cả tầng chỉ áp cho một nhóm dòng (HR-4 The Report: lớp 8–10 sắp theo tên, lớp 1–7 sắp theo điểm).
3. Nói rõ số chữ số làm tròn, kiểu làm tròn (thường, lên, xuống) và làm tròn ở bước nào; mặc định chỉ làm tròn cột cuối (HR-5, HR-6).
4. Nói rõ NULL hiển thị thế nào: giữ NULL, thay bằng giá trị gì, hay loại dòng (HR-4: "Print NULL as the name…").
5. Nói rõ điều kiện loại dòng bằng con số cụ thể ("từ 2 thử thách trở lên"), không viết "nhiều", "đáng kể" (HR-7).
6. Liệt kê cột ra đúng thứ tự máy so; nói rõ kiểu của cột dễ nhầm (tháng là chuỗi `'2025-12'`, năm là số).
7. Nêu khoá nối khi đề cho phép gợi ý ở cấp thấp (HR-5: "CITY.CountryCode and COUNTRY.Code are matching key columns"); ở bộ này việc đó do ERD Dễ (chữ trên đường nối) đảm nhận, cấp Khó thì không nêu.
8. Máy chấm cho đủ điểm hoặc 0 theo cả bảng kết quả (HR-2), nên đề không được để hai cách hiểu cho ra hai bảng khác nhau: người giải thử (HD mục 10 bước 9) phải ra đúng bảng mà không xem đáp án.

---

## 4. Nguồn HackerRank đã dùng

| Mã | Nguồn | Dùng cho |
|---|---|---|
| HR-1 | https://www.hackerrank.com/skills-directory/sql_basic · https://www.hackerrank.com/skills-directory/sql_intermediate · https://www.hackerrank.com/skills-directory/sql_advanced · trang chứng chỉ https://www.hackerrank.com/skills-verification/sql_basic (2 câu, 30 phút, "Simple Queries"), …/sql_intermediate (2 câu, 35 phút, "Complex Joins"), …/sql_advanced (2 câu, 1 giờ, "Query Optimization") | Chủ đề từng mức: Basic gồm `SELECT`/`WHERE`, hàm gom, `ORDER BY`/`LIMIT`, `JOIN`; Intermediate gồm truy vấn con, `GROUP BY`/`HAVING`, chỉ mục, view; Advanced gồm `JOIN` nâng cao và phép tập hợp, truy vấn con tương quan, tối ưu truy vấn, CTE (kể cả đệ quy), hàm cửa sổ |
| HR-2 | https://hackerrank-knowledge-base.help.usepylon.com/articles/8826242281-database-engineer-questions | Cách chấm: so kết quả với đáp án, đủ điểm hoặc 0; tuỳ chọn bỏ qua thứ tự dòng theo từng câu; điểm gợi ý Easy 50 · Medium 75 · Hard 100 |
| HR-3 | https://www.hackerrank.com/challenges/weather-observation-station-5/problem | Tiêu chí phụ khi hoà (Easy) |
| HR-4 | https://www.hackerrank.com/challenges/the-report/problem | NULL hiển thị, sắp nhiều tầng (Medium) |
| HR-5 | https://www.hackerrank.com/challenges/asian-population/problem · https://www.hackerrank.com/challenges/weather-observation-station-2/problem · https://www.hackerrank.com/challenges/weather-observation-station-15/problem | `JOIN` ở mức Easy, nêu khoá nối; làm tròn số chữ số |
| HR-6 | https://www.hackerrank.com/challenges/the-blunder/problem | Gom ở mức Easy; kiểu làm tròn "round up to the next integer" |
| HR-7 | https://www.hackerrank.com/challenges/full-score/problem | `JOIN` + gom + điều kiện loại + tiêu chí phụ (Medium, Basic Join) |
| HR-8 | https://www.hackerrank.com/domains/sql | Phân nhóm Basic Select, Advanced Select, Aggregation, Basic Join, Advanced Join, Alternative Queries; lọc Easy/Medium/Hard; nhãn kỹ năng SQL (Basic/Intermediate/Advanced) |
