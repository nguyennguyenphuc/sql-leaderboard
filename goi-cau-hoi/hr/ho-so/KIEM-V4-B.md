# Kiểm độc lập V4 · bộ hr · người kiểm B

Ngày 11/11/2026. Theo `BRIEF-KIEM-V4.md`, danh sách `KIEM-V4-DANH-SACH.md` (36 câu số lẻ). Thứ tự căn cứ: `quy_chuan/` > `QUYET-DINH-CHUNG.md` (QDC) > `style/STYLE-hr.md` > brief.

Cách làm:
- **Bước 1–2.** Với mỗi câu, chỉ đọc khối câu trong `cau-hoi.tex` (câu Sửa lỗi, Tối ưu: đọc thêm khối `starter`, vì học viên cũng thấy khối này), tự viết SQL, chạy trên `hr` và `hr_hidden_1` bằng user `sql_runner`, rồi mới so với `solution` theo luật chấm (vị trí cột, `thutu`, `saiso`, NULL chỉ bằng NULL). Case: tự giải từng bước SQL. SQL tự giải lưu ở nháp `…/scratchpad/kiem-hr-B/toi/`.
- **Bước 3.** Chạy mọi khối `wrong`, `starter` trên hai biến thể. Riêng gói 5 chạy thêm bộ kiểm máy để có số đo câu Tối ưu: `cong-cu/ket-qua/kiem-v4/hr-B-goi-5/` → `KIEM TRA: 0 loi`.
- **Bước 5.** Chấm 5 trục theo QDC 2.2, đối chiếu bài chuẩn cùng module, cùng cấp trong `data.js`. Đếm lại cấp từng module trên cả 100 câu: **M1–M10 đều 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó**; case 3 · 2 · 2 · 3.
- **Bước 6.** Đọc từng chữ của mọi trường. Đếm số tiếng của tiêu đề, bối cảnh bằng máy rồi soát lại bằng tay.

Kết quả chung: **36/36 câu tự giải khớp lời giải ở cả hai biến thể** (case: mọi bước SQL đều khớp). Lời giải của cả 36 câu cho kết quả public khác hidden-1. Lời giải chạy lâu nhất khoảng 2,1 giây (p9). Mọi `wrong`, `starter` đều rớt ở ít nhất một biến thể; câu Tối ưu: `starter` đúng kết quả nhưng vi phạm ràng buộc.

## Bảng kiểm

| # | Mã | Gói | Cấp | Tự giải khớp? | Biến thể khác? | Cấp đúng? | Giọng văn | Kết luận + đề xuất |
|---|---|---|---|---|---|---|---|---|
| 1 | hr-r1-lam-them-vn-thang-12 | 1 | basic | Khớp (14 / 13 dòng) | Có | Đúng (1 bảng, giá trị mẫu, đề ghi rõ cột) | Đạt | **Đạt.** Không bắt buộc: tiêu đề "Ai ở Việt Nam làm thêm từ 30 giờ tháng 12/2025?" thiếu "trở lên", đọc hơi cụt → "Tháng 12/2025 ai ở Việt Nam làm thêm từ 30 giờ trở lên?" (13 tiếng). |
| 3 | hr-r3-yeu-cau-tuyen-cham-quy-4 | 1 | hard | Khớp (29 / 26) | Có | Đúng, sát ranh: mơ hồ, bẫy (thiếu cận trên chỉ lộ ở hidden-1), nghiệp vụ đạt Khó; 1 bảng, 1 tầng. Cùng kiểu bài Khó M1 `r6-don-dang-xu-ly` của `data.js` (1 bảng, ngoặc quanh OR). Khác bản Cơ bản cũ thật sự | Đạt | **Đạt.** 4 `wrong` rớt đúng như `\ghichuthietke` ghi (thiếu cận trên chỉ rớt ở hidden-1). |
| 5 | hr-r5-tiem-nang-cao-chua-de-bat | 1 | easy | Khớp (21 / 20) | Có | Đạt nhưng sát ranh: cùng hai bẫy với r1 Cơ bản (quên lọc tháng, biên ngưỡng), chỉ hơn ở số điều kiện lọc và ERD không có giá trị mẫu | Đạt | **Đạt.** Ô A1 · customer · easy · write trùng `hr-s5` (gói 2): xem mục Ô trùng. |
| 7 | hr-r8-phu-cap-di-lai-sales-thieu-nguoi | 1 | hard | Khớp (41 / 37) | Có | Đúng: 3 lỗi chồng nhau, 1 lỗi chỉ lộ ở hidden-1 và bị lỗi 1 che; khác thật bản Cơ bản cũ | Đạt | **Đạt.** Nhẹ, không chặn: bối cảnh 37 tiếng (STYLE B ≤ 35) → "Danh sách xét phụ cấp đi lại quý 4/2025 bạn thực tập gửi lên thiếu nhiều người anh biết chắc đi công tác nhiều. Anh cần danh sách đúng trước khi trình giám đốc." |
| 9 | hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4 | 1 | medium | Khớp | Có | Đúng 3/5 (mơ hồ, bẫy, nghiệp vụ); viết lại thật (công thức 3 thành phần, quy năm) | Đạt | **Đạt.** Thiếu cận trên chỉ rớt ở hidden-1 (`quan_so_bq` lệch 0,33), như ghi. |
| 11 | hr-n7-ty-le-chua-dao-tao-cao | 1 | medium | Khớp | Có | Đúng: lỗi NULL → 0 ở cả tử và mẫu số là lỗi khó thấy | Đạt | **Đạt.** |
| 13 | hr-c1-thang-nghi-nhieu-nhat | 1 | basic (case) | Khớp b1 | Có | Đúng: 2 bước. Bước SQL dùng 3 hàm gom, hơi vượt "một hàm gom" của QDC 1.2 nhưng vẫn 1 bảng, không JOIN/HAVING | Đạt; kết luận đúng quy chuẩn ("Đúng: ", 3 phương án, ≤ 35 tiếng); đã kiểm số: tháng 9 cao nhất ở cả hai biến thể | **Đạt.** Không bắt buộc: thêm vào `\ghichuthietke` dòng QDC 1.2 yêu cầu: "Case Cơ bản: GROUP BY một cột trên một bảng, theo case mẫu c1 (QUYET-DINH-CHUNG 1.2)." |
| 15 | hr-s1-lam-them-quy-so-cung-ky | 2 | medium | Khớp | Có | Đúng 4/5; viết lại thật | Đạt | **Đạt.** Nhẹ: bối cảnh 37 tiếng, bỏ "Từ đầu năm 2025" → "Công ty yêu cầu các trưởng nhóm hạn chế làm thêm giờ từ năm 2025. Chị muốn biết giờ làm thêm bình quân từng quý năm 2025 có giảm so với cùng quý năm 2024 không." |
| 17 | hr-s4-cho-nhan-viec | 2 | easy | Khớp | Có | Đúng | Đạt | **Đạt.** Ô A3 · marketing · easy · write trùng `hr-j1` (gói 3): xem mục Ô trùng. |
| 19 | hr-s7-quy-luong-nam-lech-ke-toan | 2 | medium | Khớp | Có | Đúng (lỗi so chuỗi tháng với mốc dạng ngày, khó thấy) | Đạt | **Cần sửa (nặng: lộ lời giải).** Khối `starter` có hai dòng chú thích nói thẳng chỗ sai. HUONG_DAN: starter là "truy vấn nạp sẵn vào ô soạn SQL", chú thích `--` trong khối thuộc về khối đó, nên học viên đọc được ngay. **Xoá `goi-2/solution.sql` dòng 230–231** ("-- So chuỗi: '2024-01' < '2024-01-01' … nên mất riêng tháng 1/2024;" và "-- chia cho số tháng có dữ liệu …"). Ý này đã có trong `\ghichuthietke`. |
| 21 | hr-a1-nghi-theo-ly-do-2025 | 2 | basic | Khớp | Có | Đúng 5/5; hạ thật (điều kiện loại nghỉ cho sẵn, bỏ bẫy) | Đạt | **Đạt.** |
| 23 | hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu | 2 | hard | Khớp (hidden-1 hoà hạng 3 xử lý đúng) | Có | Đúng 3/5 (mơ hồ, 4 bẫy có 1 chỉ ở hidden-1, nghiệp vụ); cùng kiểu Khó 1 bảng `a6` của `data.js` | Đạt | **Đạt.** |
| 25 | hr-a9-ty-le-nghi-sales-quy-nam | 2 | hard | Khớp | Có | Đúng: 3 lỗi chồng nhau, có sai định nghĩa chỉ số, 1 lỗi chỉ lộ ở hidden-1 | Đạt | **Cần sửa (nặng: lộ lời giải).** Khối `starter` mở bằng chú thích liệt kê đủ ba lỗi ("-- Ba lỗi: đếm mọi loại nghỉ; mẫu số là số người từng có tên…; thiếu cận trên (chỉ lộ ở hidden-1…)"). **Xoá `goi-2/solution.sql` dòng 611–612.** |
| 27 | hr-c4-nguon-tuyen-nhanh-re | 2 | easy (case) | Khớp b1, b2 | Có | Đúng (3 bước) | Đạt; kết luận đúng quy chuẩn; số liệu khớp public (4 nguồn trên 50 yêu cầu; Indeed, Employee Referral thấp hơn 39,3 ngày và 2.491 USD) | **Đạt.** |
| 29 | hr-j4-tin-tuong-quan-ly-cskh-philippines | 3 | basic | Khớp | Có | Đúng: theo bài Cơ bản `j1-don-kem-vung` (nối 2 bảng); ERD 2 bảng có giá trị mẫu, chữ trên đường nối | Đạt (nhẹ) | **Đạt.** Nhẹ, không chặn: (1) bối cảnh 36 tiếng; (2) cả bộ đang gọi `'Customer Support'` hai cách: gói 1 "khối Customer Support", câu này "phòng Chăm sóc khách hàng". Nên thêm một dòng vào STYLE-hr A.1 để chốt một cách gọi. |
| 31 | hr-j9-trang-thai-quan-ly-vuot-100 | 3 | hard | Khớp (3 nhóm, hai biến thể) | Có | Đúng: 2 lỗi chồng nhau, sửa một lỗi vẫn sai; khác thật bản TB cũ | Cần sửa nhẹ | **Cần sửa (gợi ý).** Nấc 2 "Đổi sang `LEFT JOIN` và thêm `m.snapshot_month = e.snapshot_month` vào `ON`." đưa trọn cả hai chỗ sửa. Như vậy câu Khó 50 điểm chỉ mất 10 điểm là có đủ lời giải. QDC 1.4 chỉ cho phép một biểu thức một dòng, và mẫu Sửa lỗi Khó d4 chỉ nêu hướng. Đổi nấc 2 thành "Thêm \code{m.snapshot_month = e.snapshot_month} vào điều kiện nối." để chỗ sửa `LEFT JOIN` cho học viên tự tìm từ nấc 1. |
| 33 | hr-q3-gan-ket-cao-nhat-moi-phong | 3 | medium | Khớp (36 dòng) | Có | Đúng (truy vấn con gom nhóm, hoà điểm, bảng nhiễu nguồn khác) | Cần sửa | **Cần sửa (giọng).** Bối cảnh "Mỗi nước muốn đặt mục tiêu gắn kết…" dùng nước làm chủ ngữ cho "muốn" (lối nói dịch), lại dài 38 tiếng. Sửa thành: "Ban lãnh đạo từng nước sắp đặt mục tiêu gắn kết năm 2026 cho các phòng ban. Chị cần điểm cao nhất của mỗi phòng trong tháng 12/2025 và số người đạt mức đó, không nêu tên ai." |
| 35 | hr-q6-yeu-cau-thang-12-tuyen-lau | 3 | basic | Khớp (19 / 18) | Có | Đúng 5/5, theo `q1-tren-gia-trung-binh`; hạ thật (gỡ bẫy phạm vi bình quân) | Đạt | **Đạt.** Câu "Em lọc giúp chị…" chỉ xuất hiện một lần trong gói, nên được giữ (QDC 0.3). |
| 37 | hr-q9-ly-do-pho-bien-hai-loi | 3 | hard | Khớp (8 / 7, hoà Thái Lan) | Có | Đúng: 2 lỗi chồng nhau, có sai định nghĩa chỉ số | Cần sửa nhẹ | **Cần sửa (gợi ý).** Cùng lỗi như j9: nấc 2 "Thêm `WHERE t2.country = t.country` … và lọc `attrition_type = 'Voluntary'` ở cả hai bảng dẫn xuất" đưa đủ hai chỗ sửa. Giữ một chỗ: "Thêm \code{WHERE t2.country = t.country} vào truy vấn con lấy \code{MAX}." Ghi chú: `wrong chi_sua_tuong_quan` chỉ rớt ở public, vẫn đạt điều kiện ≥ 1 biến thể. |
| 39 | hr-c6-luong-thap-va-nghi-viec | 3 | medium (case) | Khớp b1–b3 | Có | Đúng (4 bước) | Cần sửa nhẹ | **Cần sửa.** (1) ERD: `country_market_benchmark` là bảng nhiễu nhưng không có đường nối. QDC 1.3 yêu cầu bảng nhiễu ở cấp Trung bình có đường nối đúng, nên thêm `\erdnoi[kieu=n-1]{employee_monthly_snapshot.country}{country_market_benchmark.country}`. (2) `saiso=0.05` lệch mặc định 0,01 mà không ghi lý do; lời giải tự giải khớp ở 0,01, nên đổi về 0,01 hoặc ghi lý do ở `\ghichuthietke`. (3) Bối cảnh 39 tiếng, vế "và nước nào cũng vậy hay không" lủng củng → "Anh cần biết nhóm đang được trả thấp hơn thị trường có nghỉ việc tự nguyện nhiều hơn không, ở mọi nước hay chỉ vài nước." Kết luận đã kiểm số: 18,53 % so với 7,61 % (khoảng 2,4 lần), nhóm dưới 0,9 cao hơn ở cả sáu nước. |
| 41 | hr-t3-pheu-tuyen-dung | 4 | easy | Khớp (466/416/388) | Có | Đúng 4/5; hạ thật (bỏ cột tỷ lệ cần hàm cửa sổ); khớp `t2` Dễ (UNION ALL) của `data.js` | Đạt | **Đạt.** Nhẹ: bối cảnh 36 tiếng. |
| 43 | hr-t5-chuoi-quan-ly-lap | 4 | hard (debug) | Khớp (6 / 5) | Có | **Không đạt Khó.** Starter chỉ có **một** lỗi (thiếu chặn chu trình), mà Sửa lỗi Khó cần 2–3 lỗi chồng nhau (HD mục 6, QDC 2.2). Đề nói sẵn cách dừng nên mức mơ hồ chỉ ở TB; 2 bẫy đều lộ ở public. Chỉ trục số tầng đạt Khó. Thêm nữa: ở hidden-1, `starter` ra **đúng bằng lời giải** (E02287 bị bỏ nên mất vòng); cả hai `wrong` cũng chỉ rớt ở public | Đạt | **Cần sửa (cấp).** Không hạ cấp, vì M7 sẽ lệch khỏi 2/2. Thêm lỗi thứ hai vào starter: bỏ `snapshot_month = '2025-12'` ở phần neo (`WHERE employee_id = 'E00041'`). Phần neo khi đó ra một dòng cho mỗi tháng E00041 có tên, mọi bước nhân lên theo. Sửa riêng chu trình vẫn sai, sửa riêng tháng vẫn lặp 10 dòng, và starter rớt ở cả hai biến thể. Bối cảnh, `\ghichuthietke` cập nhật triệu chứng tương ứng; thêm `wrong` "chỉ chặn chu trình, quên tháng ở phần neo". Ghi điểm 5 trục vào `\ghichuthietke` (QDC 2.3 mục 14). |
| 45 | hr-t7-cohort-tuyen-moi | 4 | hard | Khớp (6 cohort) | Có | Đúng (nhiều CTE, cohort, 3 bẫy, nghiệp vụ cohort) | Đạt | **Đạt.** |
| 47 | hr-f2-luy-ke-chi-phi-tuyen-dung | 4 | easy | Khớp | Có | Đúng 5/5; viết lại thật | Đạt | **Đạt.** |
| 49 | hr-f4-gan-ket-giam-truoc-nghi | 4 | hard | Khớp (30 / 24) | Có | Đúng (gom chuỗi liên tiếp, NULL cắt chuỗi) | Đạt | **Đạt.** |
| 51 | hr-f6-thu-tu-yeu-cau-singapore | 4 | basic | Khớp (28 / 27) | Có | Đúng 5/5, theo `f1-thu-tu-don` | Cần sửa nhẹ | **Cần sửa.** (1) `\ghichuthietke` viết "trùng với r3, s2". Sau v4, r3 đã là Khó, khác ô; sửa thành "trùng với s2 (gói 2)". (2) Tiêu đề "Yêu cầu tuyển dụng thứ mấy của phòng ở Singapore năm 2025?" lủng củng, sửa thành "Đánh số yêu cầu tuyển dụng năm 2025 của từng phòng ở Singapore" (12 tiếng). (3) Ô trùng với s2: xem mục Ô trùng. |
| 53 | hr-f9-luy-ke-chay-nguoc | 4 | basic (debug) | Khớp | Có | Đúng: sửa một chữ, triệu chứng thấy ngay; khác thật bản TB cũ (thiếu `PARTITION BY`) | Đạt | **Đạt.** |
| 55 | hr-c8-diem-nong-vn-engineering | 4 | hard (case) | Khớp b1–b4 | Có | Đúng (5 bước) | Đạt; kết luận đúng quy chuẩn; đã kiểm số các phương án (Engineering 14,5 giờ, 0,07 % dòng từ 40 giờ; compa 0,875 so với 0,927; tỷ lệ dưới 55 thấp hơn 3/5 phòng) | **Đạt.** |
| 57 | hr-k2-loai-ly-do-nghi | 5 | easy | Khớp | Có | Đúng (Dễ 4/5, như ghi) | Đạt | **Cần sửa nhẹ.** `\ghichuthietke` mở bằng "Trung bình, E1:" nhưng `cap=easy`, cuối ghi chú lại ghi "hạ Dễ". Đổi chữ mở đầu thành "Dễ, E1:". |
| 59 | hr-k4-bao-cao-vong | 5 | medium | Khớp (17 / 14) | Có | Đúng 4/5 | Đạt | **Cần sửa (ô trùng).** Ô E1 · operations · medium · write trùng `hr-j6` (gói 3). QDC 1.5 yêu cầu đổi ô một câu, kể cả khi khác gói (tiền lệ scm-j6/a8). Đổi `domain=operations` → `domain=customer`: tab Nghiệp vụ của câu đã ghi mục đích là kỳ đánh giá thực hiện công việc, thuộc mảng customer (STYLE-hr G); ô E1 · customer · medium · write đang trống. Cập nhật BAN-DO cùng lúc. |
| 61 | hr-k6-compa-tu-tinh | 5 | medium | Khớp (`saiso=0.001`) | Có | Đúng 4/5 | Đạt | **Cần sửa nhẹ.** (1) `\ghichuthietke` mở bằng "Khó, E2:" nhưng `cap=medium` → "Trung bình, E2:". (2) Báo để giảng viên, dev biết: `wrong noi_thieu_nam`, cũng là lỗi học viên hay mắc, chạy **72–88 giây** mỗi biến thể (kế hoạch: quét `country_market_benchmark` rồi tra chỉ mục `country` của bảng tháng, khoảng 10 triệu lần tra). Học viên mắc lỗi này sẽ gặp hết giờ thay vì thấy sai kết quả. Đo lúc máy bận; lời giải chỉ 0,9 giây. |
| 63 | hr-k8-thieu-quan-ly-ra-0 | 5 | easy (debug) | Khớp | Có | Đúng (lỗi một chỗ, Dễ) | Đạt | **Cần sửa nhẹ.** `\ghichuthietke` mở bằng "Trung bình, E1:" nhưng `cap=easy` → "Dễ, E1:". |
| 65 | hr-p3-loc-ngay-dung-chi-muc | 5 | easy (optimize) | Khớp (7 / 6) | Có | Đúng, theo bài Dễ `p3-dung-chi-muc` của `data.js` | Đạt | **Đạt.** Bộ kiểm đo được: lời giải 140 dòng trung gian (Index range scan), starter 940 dòng → vượt `ngansach=2`; `wrong doi_ham_khac_van_boc_cot` cũng vượt ngân sách. |
| 67 | hr-p6-y-dinh-o-lai-mot-lan-quet | 5 | easy (optimize) | Khớp | Có | Đúng mẫu Dễ của CHOT mục 4 (UNION ALL → GROUP BY) | Đạt | **Đạt, lưu ý thiết kế cho giảng viên.** Bộ kiểm đo: lời giải quét `engagement_survey` 1 lần nhưng sinh **37.696** dòng trung gian, starter quét 4 lần chỉ **12.669** dòng. Câu chỉ chấm số lần quét nên vẫn đúng luật, nhưng học viên mở EXPLAIN ANALYZE sẽ thấy bản "đã tối ưu" đọc nhiều dòng hơn gấp 3. Nếu muốn cả hai số cùng giảm thì cho mỗi nhánh của starter lọc bằng biểu thức không dùng được chỉ mục (ví dụ `RIGHT(survey_quarter, 2) = 'Q1' AND LEFT(survey_quarter, 4) = '2025'`), rồi đo lại. |
| 69 | hr-p9-pareto-quan-ly | 5 | hard | Khớp | Có | Đúng | Đạt | **Đạt.** Lưu ý: `\ghichuthietke` và QDC 2.3 mục 15 giữ câu ở M10 với lý do "khung ROWS/RANGE học ở M8". Sau v4, M8 (gói 4) không còn bài nào dạy `ROWS BETWEEN` nên lý do này hết đúng; xem mục gói 4 bên dưới. |
| 71 | hr-c10-tang-luong-nhom-compa-thap | 5 | hard (case) | Khớp b1–b4 | Có | Đúng (5 bước) | Đạt; kết luận đúng quy chuẩn; đã kiểm số (1.778.876 USD/năm so với 107.993 USD tránh được) | **Đạt.** |

## Ý kiến về hai điểm người soạn tự khai yếu

**1. Gói 4 không còn bài "Trung bình trượt (ROWS BETWEEN)": nên bổ sung lại.**
- Căn cứ: CHOT-LO-TRINH mục 1 ghi nội dung M8 là "ROW_NUMBER/RANK/DENSE_RANK, LAG/LEAD, SUM/AVG OVER, PARTITION BY, **ROWS BETWEEN**". `data.js` M8 có bài `f5-trung-binh-truot` (medium, kỹ năng ROWS BETWEEN). Sau v4, trong `goi-4/solution.sql` khung `ROWS` chỉ còn ở một bài sai của f4 (`dem_khong_lien_tiep`). Ngoài ra, lý do giữ hr-p9 ở M10 (QDC 2.3 mục 15: "khung ROWS/RANGE học ở M8") không còn đúng.
- Đề xuất: viết lại `hr-f1-top3-lam-them-moi-nuoc` (TB, write) thành bài trung bình trượt. Câu này hiện gần trùng nội dung với `hr-f7-top3-lam-them-rank`: cả hai đều là top 3 làm thêm giờ theo nhóm, dạng C1. Đề gợi ý: "Giờ làm thêm bình quân trượt 3 tháng của phòng Kỹ thuật ở Việt Nam năm 2025" với `AVG(gio) OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)`. Bẫy: tháng 1, 2/2025 cần dữ liệu tháng 11, 12/2024, nên lọc năm sau khi tính cửa sổ. Ô B3 · operations · medium · write hiện trống. M8 vẫn giữ 2/3/2/2.

**2. `hr-t8-union-mat-dong` xếp Dễ: đồng ý giữ Dễ.**
- Căn cứ: quy chuẩn đứng trên QDC. `data.js` M7 có đúng bài này: `t3-union-mat-dong`, level `easy`, form `debug`, kỹ năng "UNION và UNION ALL". HD mục 6 xếp sửa lỗi Dễ là lỗi logic một chỗ. QDC 0.1 mục 5 cũng đã bỏ ngoại lệ "M7, M8 không có Dễ".
- Chỗ mâu thuẫn còn lại là ở QDC: 2.1 nêu "`UNION` bỏ mất dòng trùng hợp lệ" làm ví dụ lỗi Trung bình, và 2.3 mục 13 còn ghi "t8 (debug TB) giữ cấp". Đề nghị sửa QDC 2.1: bỏ cụm này khỏi ví dụ TB, hoặc ghi "chỉ là TB khi lỗi UNION bị che, không thấy ngay trên kết quả". Đánh dấu 2.3 mục 13 phần t8 là "thay bằng data.js t3".

## Phát hiện ngoài phần được giao (để người kiểm C, người sửa gói 2 biết)

- `hr-s9-quan-so-cuoi-thang-lech` (gói 2, phần C): `starter` cũng có chú thích lộ cả ba lỗi, ở `goi-2/solution.sql` dòng 302–303. Cần xoá như s7, a9. Đã quét starter của cả 5 gói: chỉ gói 2 có chú thích trong starter (s7, s9, a9).

## Tổng kết

- **36 câu: 24 Đạt · 12 Cần sửa.**
  - Nặng (lộ lời giải qua chú thích starter): **hr-s7, hr-a9**.
  - Cấp sai: **hr-t5** (Sửa lỗi Khó chỉ có một lỗi; starter ở hidden-1 ra đúng lời giải).
  - Gợi ý nấc cuối đưa trọn lời giải câu Sửa lỗi Khó: **hr-j9, hr-q9**.
  - Giọng văn: **hr-q3**.
  - ERD, `saiso`, giọng văn: **hr-c6**.
  - Ghi chú, tiêu đề, ô trùng: **hr-f6**.
  - `\ghichuthietke` ghi sai cấp: **hr-k2, hr-k6, hr-k8**.
  - Ô trùng: **hr-k4**.
- **Không có** câu sai kết quả, không có `wrong` nào không rớt, không có lời giải chạy quá 10 giây.
- Nhẹ, không chặn: bối cảnh vượt 35 tiếng ở r8 (37), s1 (37), j4 (36), t3 (36), t5 (37); q3 (38) và c6 (39) đã có câu sửa ở bảng trên.

### Ô trùng (dạng × mảng × cấp × hình thức) có câu của B, tính trên cả 100 câu

| Ô | Câu | Đề xuất |
|---|---|---|
| A1 · customer · easy · write | hr-r5 (gói 1) · hr-s5 (gói 2) | Giữ r5, vì M1 chỉ có dạng A1. Đổi ô ở s5 ("Ai có ý định ở lại thấp nhất năm 2025?"), ví dụ đổi dạng nếu câu chọn nhóm thấp nhất. Ô C4 · customer · easy · write đang trống. |
| A1 · marketing · basic · write | hr-f6 (gói 4) · hr-s2 (gói 2) | Đổi ô một câu theo QDC 1.5. Ô A3 · marketing · basic · write và B4 · marketing · basic · write đang trống. |
| A3 · marketing · easy · write | hr-s4 (gói 2) · hr-j1 (gói 3) | Đổi ô một câu theo QDC 1.5. Ô B1 · marketing · easy · write đang trống. |
| E1 · operations · medium · write | hr-k4 (gói 5) · hr-j6 (gói 3) | Đổi k4 sang mảng customer (xem bảng). |

Ô trùng còn lại trong bộ, không có câu của B: A1 · after_sales · basic · debug (r7, j8); C3 · finance · easy · write (a4, q1).

Lưu ý: DA-SUA gói 3, gói 4 ghi "trùng khác gói được phép". QDC 1.5 lấy scm-j6 (gói 3) và a8 (gói 2), khác gói, làm ví dụ phải viết lại, nên trùng khác gói cũng phải xử lý.
