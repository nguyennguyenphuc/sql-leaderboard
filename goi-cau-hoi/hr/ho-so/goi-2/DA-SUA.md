# Đã sửa · gói 2 · HR Analytics (`hr`) · v2 (10/11/2026)

Theo `REVIEW-B.md`, `REVIEW-C.md` và `BRIEF-SUA-GOI.md`. Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/hr-goi-2/` (6 câu đã sửa SQL hoặc cấp: s5, s6, s7, s8, a4, c4), chạy trên MySQL: `KIEM TRA: 0 loi`.
- **Cả gói, kiểm tĩnh** (`--chi-phan-tich`): 20 câu, 66 khối SQL, `KIEM TRA: 0 loi`.
- **Biên dịch** XeLaTeX: PDF 44 trang, 0 lỗi LaTeX, 0 ký tự thiếu (`cong-cu/ket-qua/bien-dich/hr-goi-2/`).

Sửa chung cho cả gói: "làm tròn 0 chữ số" thành "làm tròn đến hàng đơn vị", các chỗ khác thành "làm tròn N chữ số thập phân";
"Sửa để ra đúng" thành "Sửa truy vấn cho đúng"; bỏ khuôn "Em … giúp anh/chị" ở 10 lời nhắn (còn 1, ở a6); "theo tab Nghiệp vụ" tách thành mệnh đề riêng;
thống nhất "yêu cầu tuyển dụng"; tiêu đề tối đa 10 tiếng (trừ a3, a6 giữ nguyên vì người kiểm đánh giá đạt).

| Mã | Đã sửa (theo B/C) | Kiểm lại |
|---|---|---|
| `hr-s1-nghi-viec-theo-nam` | B: tiêu đề "Mỗi năm có bao nhiêu người nghỉ việc?"; yêu cầu 2 viết lại, tách "xem tab Nghiệp vụ"; `\luuy` ghi rõ `attrition_this_month` = 1; lời nhắn bỏ khuôn "Em … giúp" | tĩnh 0 lỗi |
| `hr-s2-nhan-viec-thu-hai` | C: tiêu đề thành câu hỏi; lời nhắn nói rõ mục đích (xem năm 2025 có bao nhiêu trường hợp), "yêu cầu tuyển dụng"; dòng quyết định; gợi ý 1 viết lại | tĩnh 0 lỗi |
| `hr-s3-yeu-cau-theo-quy` | B: tiêu đề "Số yêu cầu tuyển dụng được duyệt mỗi quý"; lời nhắn bỏ "nhịp", dạng câu hỏi; `\luuy` bỏ câu lộ gợi ý (thay bằng định nghĩa quý) | tĩnh 0 lỗi |
| `hr-s4-cho-nhan-viec` | C: yêu cầu 1 ghi cận dưới, cận trên tường minh; yêu cầu 2 bỏ khuôn "Tính X là Y"; dòng quyết định đổi "rút ngắn thời hạn báo trước" thành "hẹn ngày đi làm sớm hơn" (chờ giảng viên); lời nhắn dạng câu hỏi | tĩnh 0 lỗi |
| `hr-s5-y-dinh-o-lai-thap-2025` | B: đổi kỳ thành bốn quý năm 2025, bỏ "(quý 3 bắt đầu từ tháng 7)", ví dụ Q1 ứng '2025-01', nên phải dùng 3q − 2 + `LPAD` (thêm wrong `go_cung_thang` gõ cứng '-07', rớt public + hidden-1); tiêu đề, lời nhắn (bỏ "rời công ty"); `\luuy` nêu thang `intent_to_stay` 1–5; bỏ `\khainiem{diem-gan-ket}` không dùng; sửa `\ghichuthietke`. Mã giữ chữ q3 | gói tạm 0 lỗi |
| `hr-s6-cong-tac-truong-nhom-sales` | C: nhãn `vai_tro` không dấu ('Truong nhom', 'Nhan vien') để tránh lệch chuẩn hoá Unicode; "chuỗi 'Lead'"; gợi ý 2 không còn đưa sẵn biểu thức; lời nhắn dạng câu hỏi; tiêu đề 10 tiếng | gói tạm 0 lỗi |
| `hr-s7-dem-nghi-theo-nam-thieu-2025` | B: đổi bẫy cho khác s1: starter lọc `snapshot_month BETWEEN '2024' AND '2025'` (so chuỗi, mất cả năm 2025); wrong `moc_dang_ngay_day_du` ('2024-01-01' bỏ tháng 1/2024) và `dung_year_tren_chuoi`; tiêu đề không còn "NULL"; lời nhắn đổi câu kết; `\luuy` kỹ thuật bỏ khỏi tab Nghiệp vụ. Mã giữ nguyên (chữ "null" trong mã không còn khớp nghĩa) | gói tạm 0 lỗi |
| `hr-s8-quy-4-thieu-thang-12` | C: tiêu đề, lời nhắn đúng dữ liệu (starter **không có** dòng tháng 12 trên public); `\luuy` bỏ phần BETWEEN (chuyển vào gợi ý 2), thay bằng định nghĩa quý 4; "yêu cầu tuyển dụng"; hạ cấp Dễ → Cơ bản, ERD còn 1 bảng có giá trị mẫu; lời nhắn đổi câu kết | gói tạm 0 lỗi |
| `hr-s9-quan-so-sai-thu-tu` | B (không bắt buộc): "năm tài chính" → "12 tháng từ tháng 7/2024"; lời nhắn bỏ "Em sửa giúp chị"; tách "định nghĩa ở tab Nghiệp vụ" | tĩnh 0 lỗi |
| `hr-a1-nghi-theo-ly-do-2025` | C: tiêu đề nói rõ loại nghỉ ("Người nghỉ tự nguyện năm 2025 vì lý do gì?"); lời nhắn bỏ khuôn | tĩnh 0 lỗi |
| `hr-a2-luong-theo-bac` | B: "làm tròn đến hàng đơn vị"; lời nhắn bỏ khuôn | tĩnh 0 lỗi |
| `hr-a3-ty-le-nghi-viec-theo-nuoc` | C: bỏ "(số dòng chia 12)" khỏi yêu cầu (học viên lấy công thức từ khái niệm), giữ cấp Trung bình; lời nhắn bỏ "mất người", dạng câu hỏi | tĩnh 0 lỗi |
| `hr-a4-phong-compa-thap` | B: hạ cấp Trung bình → Dễ; ERD còn 2 bảng có điều kiện nối (bỏ nối `job_family` → `job_role` thiếu khoá); tiêu đề nói rõ nước × phòng ban; "3 chữ số thập phân" | gói tạm 0 lỗi |
| `hr-a5-chi-phi-thoi-gian-tuyen` | C (tuỳ chọn): lời nhắn "Anh đang lập…", "tách riêng"; "làm tròn đến hàng đơn vị" | tĩnh 0 lỗi |
| `hr-a6-enps-theo-quy` | B: cột `enps` ghi rõ thang −100 tới +100 (ví dụ 25,5 chứ không phải 0,255); lời nhắn "diễn biến eNPS qua từng quý"; tách "công thức xem tab Nghiệp vụ". Cấp giữ Trung bình (chờ giảng viên) | tĩnh 0 lỗi |
| `hr-a7-dem-nguoi-theo-phong-trung` | C: yêu cầu bỏ "số nhân viên khác nhau", thêm "mỗi người chỉ tính một lần"; dòng quyết định "đối chiếu số tài khoản đã cấp"; lời nhắn đổi câu kết | tĩnh 0 lỗi |
| `hr-a8-luong-bq-tu-bq-phong` | B: "bảng lương" → "số liệu (chi trả) lương bên kế toán" ở tiêu đề, lời nhắn, dòng quyết định; "kết quả bị lệch"; "làm tròn đến hàng đơn vị"; ERD bỏ nối `country` sai ký hiệu, thay bảng nhiễu `position_plan` (n-1) | tĩnh 0 lỗi |
| `hr-a9-ty-le-thang-cong-tac-sales` | C: yêu cầu 1 viết lại, "tỷ lệ 100\%"; `\luuy` bỏ phần lộ lỗi, thay bằng định nghĩa tháng công tác dài; dòng quyết định thêm "hay không"; lời nhắn bỏ khuôn; tiêu đề 8 tiếng | tĩnh 0 lỗi |
| `hr-c3-lam-them-malaysia` | B (không bắt buộc): mô tả `so_dong_tren_40` rõ hơn; lời giải thích phương án đúng thêm giới hạn 104 giờ/tháng của Malaysia (B đã đối chiếu); lời nhắn bỏ khuôn | tĩnh 0 lỗi |
| `hr-c4-nguon-tuyen-nhanh-re` | C: bước 1 đổi thành "Mặt bằng chung năm 2025" (1 dòng: số yêu cầu, thời gian, chi phí bình quân), thêm wrong bình quân của bình quân theo nguồn; phương án đúng có ngưỡng "bốn nguồn có trên 50 yêu cầu" và so với mặt bằng ở bước 1; phương án 3 bỏ "mang về", "nhiều yêu cầu thứ hai"; `\luuy` không còn nêu sẵn lý do loại phương án 1; lời nhắn dạng câu hỏi | gói tạm 0 lỗi |

## Chờ giảng viên

1. **a6 (eNPS theo quý), cấp Trung bình:** chỉ 1 bảng và `SUM(CASE)`; độ sâu nghiệp vụ eNPS bù được một phần. Giữ Trung bình hay hạ Dễ?
2. **a3 (tỷ lệ nghỉ việc theo nước), cấp Trung bình:** đã bỏ chỉ dẫn công thức trong yêu cầu nhưng vẫn là 1 bảng, 1 lần gom; gợi ý trả phí nấc 2 còn công thức `COUNT(*) / 12`.
3. **s4, dòng quyết định:** đã đổi "rút ngắn thời hạn báo trước" (thuật ngữ BLLĐ Điều 35, sai chủ thể) thành "hẹn ngày đi làm sớm hơn trong thư mời làm việc"; cần người nắm domain xác nhận.
4. **ERD cấp Dễ/Trung bình vẽ thêm bảng không cần nối** (`positions`, `position_plan`) ở hầu hết câu Module 3–4 để đúng cỡ ERD theo cấp; giảng viên chấp nhận hay cho phép ERD 1 bảng ở hai module này.
5. **Mã s5 (`…-q3`) và s7 (`…-null`)** không còn khớp hẳn nội dung sau khi sửa; giữ mã theo quy định, đổi mã nếu giảng viên muốn.
6. Phân bổ cấp sau sửa: Module 3 có 4 câu Cơ bản (s1, s2, s7, s8) và 5 câu Dễ; Module 4 có 5 câu Dễ (a1, a2, a4, a5, a7) và 4 câu Trung bình (a3, a6, a8, a9); bản đồ 100 câu (M3: 3 basic, 6 easy; M4: 4 easy, 5 medium) cần cập nhật nếu giảng viên đồng ý.

## Quyết định v3 (10/11)

Nguồn domain: DD = `Project 02 HR Analytics\data\data_dictionary.md`; GEN = `scripts\augment_datasets.py`; QDC = `QUYET-DINH-CHUNG.md`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `hr-s4-cho-nhan-viec` | Dòng quyết định "hẹn ngày đi làm sớm hơn trong thư mời làm việc" | Xác nhận v2 (không dùng "rút ngắn thời hạn báo trước") | BLLĐ 2019 Điều 35: thời hạn báo trước là nghĩa vụ của người lao động với nơi làm cũ khi đơn phương chấm dứt hợp đồng (https://thuvienphapluat.vn/van-ban/Lao-dong-Tien-luong/Bo-Luat-lao-dong-2019-333670.aspx); dữ liệu có 6 nước nên không áp riêng luật Việt Nam; DD mục 3 (`start_date` = ngày nhận lời + thời gian chờ) | `\luuy` thêm câu: trong khoảng chờ người được tuyển thường phải báo trước cho nơi làm cũ, thời hạn theo luật từng nước, công ty tuyển không rút ngắn được |
| `hr-s5` | Mã `…-q3` lệch nội dung (bốn quý) | Đổi mã | BAO-CAO 3.6 | `hr-s5-y-dinh-o-lai-thap-q3` → `hr-s5-y-dinh-o-lai-thap-2025` (cau-hoi.tex, solution.sql, BANG-PHAN-CONG, DA-SUA, bản đồ); `\ghichuthietke` |
| `hr-s7` | Mã `…-null` lệch nội dung (bẫy so chuỗi tháng với năm) | Đổi mã | BAO-CAO 3.6 | `hr-s7-dem-nghi-theo-nam-null` → `hr-s7-dem-nghi-theo-nam-thieu-2025` (cùng các file trên) |
| `hr-a3-ty-le-nghi-viec-theo-nuoc` | Cấp Trung bình | Hạ Dễ | QDC 2.3 mục 11 (1 bảng, 1 lần gom, một phép chia: Dễ 4/5 trục) | `cap=easy`; ERD 2 bảng có chữ trên đường nối (1 bảng nhiễu, QDC 1.3); `\ghichuthietke`; bản đồ |
| `hr-a6-enps-theo-quy` | Cấp Trung bình | Giữ Trung bình | QDC 2.3 mục 10 (công thức eNPS hai thành phần) | `\ghichuthietke` ghi lý do |
| M3, M4 | Phân bổ cấp sau sửa | Chấp nhận | QDC 2.3 mục 12 | Bản đồ cập nhật theo a3 (M4: 6 Dễ, 3 Trung bình) |
| `hr-c3`, `hr-c4` | Tiền tố lời giải thích bước kết luận | Theo gói mẫu quy chuẩn: phương án đúng mở bằng "Đúng: ", phương án sai không có tiền tố | QDC 1.1 (sửa theo quy_chuan 23:05; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4) | "Đúng. " → "Đúng: " ở 2 phương án đúng; phương án sai không tiền tố (lượt trước đã thêm "Chưa đúng. ", nay gỡ lại theo quy chuẩn) |

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md` (quy chuẩn `data.js`: mọi module đủ Cơ bản → Khó). Mục tiêu mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug; case c3, c4 giữ cấp.

Phân bổ: **M3** trước 4 Cơ bản (s1, s2, s7, s8) · 5 Dễ → sau 2 Cơ bản (s2, s8) · 3 Dễ (s4, s5, s6) · 2 Trung bình (s1, s7) · 2 Khó (s3, s9). **M4** trước 7 Dễ · 2 Trung bình (a6, a8) → sau 2 Cơ bản (a1, a2) · 3 Dễ (a4, a5, a7) · 2 Trung bình (a6, a8) · 2 Khó (a3, a9). Số câu đổi cấp: 8 (tối thiểu: M3 phải bỏ 2 Cơ bản, 2 Dễ; M4 phải bỏ 4 Dễ). Viết lại 6 câu (đổi mã), hạ 2 câu (giữ mã vì nội dung, SQL giữ nguyên).

5 trục ghi theo thứ tự: số bảng lời giải · số bước · mơ hồ · bẫy · nghiệp vụ (B = Cơ bản, D = Dễ, T = Trung bình, K = Khó). Chi tiết từng trục ở `\ghichuthietke` của câu.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục |
|---|---|---|---|
| `hr-s1-nghi-viec-theo-nam` → `hr-s1-lam-them-quy-so-cung-ky` | basic → medium (write; A3 as → B2 ops) | Viết lại: giờ làm thêm bình quân từng quý 2025 so với cùng quý 2024 (bảng chéo hai năm theo nhãn `'Q1'`…`'Q4'`). ERD 3 bảng chỉ ký hiệu. Bài sai `QUARTER` trên chuỗi tháng, `ELSE 0` trong `AVG`, nhãn quý kèm năm | B · T · T · T (2 bẫy) · T (so cùng kỳ) → 4/5 T |
| `hr-s3-yeu-cau-theo-quy` → `hr-s3-cho-hoi-nhap-thu-hai` | easy → hard (write; B1 mkt → A3 mkt) | Viết lại: hội nhập vào thứ Hai, theo nước số người phải chờ và số ngày chờ bình quân (người mới duyệt 2025). ERD 5 bảng chỉ khoá, `\erdkhoa`. Bài sai `DAYOFWEEK` theo số của `WEEKDAY`, thứ Hai chờ 7 ngày, bình quân gồm cả người không chờ (public), thiếu cận trên (hidden-1, R0801) | B · D · K · K (4 bẫy, 1 ở hidden-1) · K (quy tắc nhiều điều kiện) → 3/5 K |
| `hr-s7-dem-nghi-theo-nam-thieu-2025` → `hr-s7-quy-luong-nam-lech-ke-toan` | basic → medium (debug; A3 as → E2 fin) | Viết lại: quỹ lương năm và bình quân tháng; starter `BETWEEN '2024-01-01' AND '2025-12-31'` trên chuỗi tháng mất riêng tháng 1/2024 (lỗi khó thấy; chia số tháng có dữ liệu nên bình quân tháng vẫn hợp lý). ERD 3 bảng chỉ ký hiệu. Bài sai bỏ cận trên (hidden-1), giữ mốc cũ chia 12, `YEAR` trên chuỗi | B · D · T · T · T; sửa lỗi: 1 lỗi khó thấy → 3/5 T |
| `hr-s9-quan-so-sai-thu-tu` → `hr-s9-quan-so-cuoi-thang-lech` | easy → hard (debug; B1 ops giữ) | Viết lại: quân số cuối tháng 7/2024–12/2025, nhãn `'2024-7'`; ba lỗi chồng nhau: sắp theo nhãn, `COUNT(*)` gồm người nghỉ (sai định nghĩa), thiếu cận trên (chỉ lộ ở hidden-1). ERD 5 bảng chỉ khoá, trung tính. Bài sai chỉ sửa thứ tự, sắp theo độ dài nhãn, đổi nhãn hai chữ số (public); sửa hai lỗi thiếu cận trên (hidden-1) | B · D · K · K (3 bẫy, 1 ở hidden-1) · T; sửa lỗi: 3 lỗi chồng nhau + sai định nghĩa → 3/5 K |
| `hr-a1-nghi-theo-ly-do-2025` (giữ) | easy → basic | Đề ghi thẳng điều kiện `attrition_type`, mỗi dòng là một người; ERD 1 bảng có giá trị mẫu (bỏ `positions`); gợi ý 1 nấc; bỏ bẫy cờ nghỉ khỏi phần đề. SQL giữ | B · B · B · B (0 bẫy) · B → 5/5 B |
| `hr-a2-luong-theo-bac` (giữ) | easy → basic | ERD 1 bảng có giá trị mẫu `'2025-12'` (bỏ `positions`); `\luuy` bỏ cảnh báo lấy 24 tháng; gợi ý 1 nấc. SQL giữ | B · B · B · B · B → 5/5 B |
| `hr-a3-ty-le-nghi-viec-theo-nuoc` → `hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu` | easy → hard (write; A3 as → C1 as) | Viết lại: ba nhóm chức danh có nhiều người nghỉ tự nguyện nhất 2025, kèm số người có kết quả cao (cờ) và tỷ lệ nghỉ tự nguyện năm; thêm khái niệm `hieu-suat-cao` (chép từ STYLE-hr E). ERD 5 bảng chỉ khoá. Bài sai cờ nghỉ, mẫu số đếm người, `performance_rating = 4` (public); hoà hạng 3 xếp `job_family` giảm dần (hidden-1, README-hr (c')) | B · D · K · K (4 bẫy, 1 ở hidden-1) · K → 3/5 K |
| `hr-a9-ty-le-thang-cong-tac-sales` → `hr-a9-ty-le-nghi-sales-quy-nam` | easy → hard (debug; A2 sal giữ) | Viết lại: tỷ lệ nghỉ việc tự nguyện quy năm 6 tháng cuối 2025 của phòng Sales theo nước; ba lỗi: mọi loại nghỉ, mẫu số đếm người (sai định nghĩa), thiếu cận trên (hidden-1, E00002). ERD 5 bảng chỉ khoá. Bài sai chỉ sửa loại nghỉ, không quy năm, chia 12 tháng (public); sửa hai lỗi thiếu cận trên (hidden-1) | B · D · K · K (3 bẫy, 1 ở hidden-1) · K; sửa lỗi: 3 lỗi chồng nhau → 3/5 K |

Kiểm:
- Bộ kiểm đầy đủ trên MySQL (`--ra cong-cu/ket-qua/cap-do/hr-goi-2`): 20 câu, `KIEM TRA: 0 loi`, 0 cảnh báo. Mọi `wrong` mới rớt đúng biến thể dự kiến; kết quả public ≠ hidden-1 ở cả 8 câu; solution chạy ≤ 1,5 giây.
- Biên dịch XeLaTeX (`cong-cu/ket-qua/cap-do/hr-goi-2-pdf/`): 0 lỗi LaTeX, 0 ký tự thiếu.
- Ô dạng × mảng × cấp × hình thức: không trùng trong gói; 8 ô mới không trùng gói 1, 3, 4, 5 (đọc `cau-hoi.tex` các gói lúc 11/11). Ô cũ của s1 (B2·as·medium·W) trùng `hr-t1-nghi-viec-yoy-theo-phong` nên s1 chuyển sang làm thêm giờ (B2·ops).
- Ghi chú: s1, s7 (Trung bình) dùng ERD 3 bảng mà lời giải chỉ cần 1 bảng (2 bảng nhiễu), theo CHOT mục 3 (Trung bình 3–4 bảng) và tiền lệ a6, a8; lệch quy ước bổ sung QDC 1.3 "Trung bình ≤ 1 bảng nhiễu" (quy chuẩn đứng trên).
