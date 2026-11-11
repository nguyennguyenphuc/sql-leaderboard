# Đã sửa · bộ HR · gói 5 (theo REVIEW-B, REVIEW-C) · v2

Kiểm lại: gói tạm `cong-cu/ket-qua/sua/hr-goi-5/` (6 câu đã sửa SQL hoặc yêu cầu chấm: k2, k5, k6, p1, p7, c10) → **KIEM TRA: 0 loi**, mọi wrong rớt ở public và hidden-1.
Cả gói `--chi-phan-tich` → **0 loi**. Biên dịch `cong-cu/ket-qua/bien-dich/hr-goi-5/`: 55 trang, 0 lỗi LaTeX, 0 ký tự thiếu.

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| hr-k1-co-lech-diem-danh-gia | B: tiêu đề "Cờ kết quả công việc cao…"; bối cảnh bỏ "cờ", nói "danh sách… điểm đánh giá thực hiện công việc"; yêu cầu gọi đúng "cờ nhân viên có kết quả thực hiện công việc cao (high_performer_flag)" | phân tích tĩnh |
| hr-k2-loai-ly-do-nghi | C: cột `hop_le` luôn 1 nên không được chấm → đổi thành `so_can_ra_soat`, thêm quy tắc nghỉ hưu phải từ 60 tuổi (điểm lạ thật: có người nghỉ hưu dưới 60); thêm wrong `chi_kiem_cap_loai_ly_do`, `nguong_tuoi_lech_bien`; ERD thêm `age`; bối cảnh "tổng hợp… của hai năm qua" | bộ kiểm gói tạm |
| hr-k3-gan-ket-hai-nguon | B: gợi ý 1 bỏ "gặp" → "ghép được với bao nhiêu phiếu"; bối cảnh bỏ "thì" | phân tích tĩnh |
| hr-k4-bao-cao-vong | C: tiêu đề, bối cảnh, yêu cầu 2, dòng quyết định theo câu đề xuất; B: thống nhất Trưởng phòng Nhân sự là "Chị Hạnh" | phân tích tĩnh |
| hr-k5-ty-le-thieu-du-lieu | B: yêu cầu bỏ mở bằng "Với"; bối cảnh; `\luuy` bỏ khái quát; gợi ý 2 và lời giải đổi sang đếm sáu cột trong một CTE một lần đọc rồi xoay dọc (không dạy mẫu quét 6 lần) | bộ kiểm gói tạm |
| hr-k6-compa-tu-tinh | C: ghi rõ "chia trực tiếp… không làm tròn giá trị tính lại", giải nghĩa compa-ratio; `saiso` 0.0001 → 0.001; "thang lương thị trường" → "mức lương thị trường" (tiêu đề, bối cảnh, `\luuy`, gợi ý); gợi ý bỏ "gặp" | bộ kiểm gói tạm |
| hr-k7-tong-theo-bac-lech | B (tuỳ chọn): dòng quyết định "Chọn bậc cần ưu tiên kế hoạch kế nhiệm." | phân tích tĩnh |
| hr-k8-thieu-quan-ly-ra-0 | C: `\luuy` không lộ cách sửa; yêu cầu 1 sửa trật tự từ; gợi ý 2 "so sánh = NULL không bao giờ cho kết quả đúng" | phân tích tĩnh |
| hr-k9-backfill-lech-thang | B: gợi ý 1 bỏ "gặp", "còn giữ"; tiêu đề "…báo lệch bậc bất thường"; `\luuy` bỏ câu nói sẵn cách sửa | phân tích tĩnh |
| hr-p1-nghi-ba-loai-mot-lan-quet | C (tuỳ chọn): thay wrong dạng dài bằng lỗi hay gặp `count_case_else_0` | bộ kiểm gói tạm |
| hr-p2-chi-so-thang-mot-lan-quet | B: hạ `cap=basic` (đúng mẫu o1), ERD 1 bảng có giá trị mẫu; bối cảnh sửa trật tự từ; người hỏi đổi "Chị Vân" để bớt khuôn lặp | phân tích tĩnh (SQL không đổi) |
| hr-p3-top3-khong-tuong-quan | C: tiêu đề, bối cảnh "chưa tới hai chục dòng", `rangbuoc` đủ danh từ, gợi ý 1 tách câu; B: bối cảnh đổi triệu chứng (chạy hằng đêm quá giờ) | phân tích tĩnh |
| hr-p4-yeu-cau-ngoai-ke-hoach | B: "năm của attrition_month" thay "năm đó"; bối cảnh bỏ lặp "thêm" | phân tích tĩnh |
| hr-p5-tang-luong-khong-tu-noi | B/C: bối cảnh đổi người hỏi và triệu chứng ("bớt một lần đọc", không nói giảm dòng); tiêu đề "so với tháng trước" | phân tích tĩnh |
| hr-p6-enps-noi-mot-thang | B: giải nghĩa eNPS ở lần đầu; bối cảnh đổi triệu chứng và người hỏi | phân tích tĩnh |
| hr-p7-dem-theo-thang-chi-muc | C: kế hoạch 6 tháng không cho thấy khác biệt → đổi phạm vi sang quý 4/2025 (đo thật: BETWEEN cho Index range scan 9.325 dòng; LEFT/RIGHT đọc toàn bộ chỉ mục 73.451 dòng); sửa tiêu đề, khái niệm `chi-muc`, `\ghichuthietke`, wrong 1 | bộ kiểm gói tạm |
| hr-p8-chuoi-thang-sai | B: hạ `cap=basic`, ERD 1 bảng giữ giá trị mẫu; `\luuy` không nói sẵn cách sửa; `\ghichuthietke` nêu lý do gắn M10 (điều kiện khoảng trực tiếp trên cột) | phân tích tĩnh (SQL không đổi) |
| hr-p9-pareto-quan-ly | C: yêu cầu 1–3 (bỏ lặp, "người đó", nêu tử số/mẫu số của tỷ lệ); `\luuy` bỏ chữ "khoá" | phân tích tĩnh |
| hr-c9-chi-phi-tuyen-thay-the | B: bối cảnh bỏ lặp "tốn kém nhất"; b4 bỏ "Với mỗi", ghi rõ `so_thang_luong` tính từ bình quân chưa làm tròn; phương án đúng bỏ khuôn "mệnh đề: kết luận"; phương án Thái Lan thêm căn cứ bước 3; Singapore bỏ "chỉ bằng"; gợi ý b2 sửa chủ ngữ; "thang lương" → "mức lương thị trường"; "Trap:" → "Bẫy:" | phân tích tĩnh (SQL không đổi) |
| hr-c10-tang-luong-nhom-compa-thap | C: b3 "12 × tổng phần tăng chưa làm tròn"; b4 "dùng tỷ lệ chưa làm tròn", cột `so_nghi_vuot` → `so_nghi_tranh_duoc` (solution + wrong); phương án đúng bỏ "biện minh"; phương án 2 thêm rào đón; người hỏi "Anh Sơn"; "thang lương" → "mức lương thị trường"; "Trap:" → "Bẫy:" | bộ kiểm gói tạm |

Toàn gói: "thang lương thị trường" → "mức lương thị trường" cả ở `\khaibaodulieu` và chú thích SQL; không còn chữ "thang lương".

## Chờ giảng viên

- **k2:** ngưỡng rà soát nghỉ hưu "từ 60 tuổi" là quy tắc nội bộ do người soạn đặt (dữ liệu 6 nước, tuổi nghỉ hưu theo luật khác nhau; BLLĐ 2019 Điều 169 có lộ trình riêng cho nam/nữ). Cần giảng viên duyệt ngưỡng hoặc cách nói.
- **Cấp sàn M9/M10:** k2, k5, k8, p1, p7 ở medium nhưng theo thang mục 6 gần Cơ bản/Dễ; k4, k6 ở hard nhưng gần Trung bình (C). Đã hạ p2, p8 xuống basic theo yêu cầu điều phối; các câu còn lại giữ cấp của bản đồ, chờ trưởng nhóm chốt.
- **p9:** kỹ năng chính (khung ROWS/RANGE) gần module hàm cửa sổ hơn M10; bản đồ đặt ở M10.
- **p5:** lời giải ít lần quét hơn nhưng nhiều dòng trung gian hơn starter; câu chỉ chấm số lần quét (đã chỉnh bối cảnh cho đúng).
- **p7:** câu write không chấm kế hoạch chạy; bài học chỉ mục chỉ hiện khi học viên tự chạy `EXPLAIN ANALYZE`.

## Quyết định v3 (10/11)

Nguồn domain: DD = `Project 02 HR Analytics\data\data_dictionary.md`; GEN = `scripts\augment_datasets.py` (chỉ đọc); QDC = `QUYET-DINH-CHUNG.md` (thang cấp mục 2: cấp = cấp đạt ≥ 3/5 trục).

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `hr-k2-loai-ly-do-nghi` | Ngưỡng "từ 60 tuổi" | Giữ ngưỡng, đề gọi rõ là quy tắc rà soát nội bộ của công ty | Dữ liệu 6 nước (DD mục 1); BLLĐ 2019 Điều 169 (https://thuvienphapluat.vn/van-ban/Lao-dong-Tien-luong/Bo-Luat-lao-dong-2019-333670.aspx) và NĐ 135/2020 Điều 4 (https://thuvienphapluat.vn/van-ban/bao-hiem/decree-135-2020-nd-cp-on-retirement-age-459280.aspx): năm 2025 nam 61 tuổi 3 tháng, nữ 56 tuổi 8 tháng, nên không có tuổi luật chung; GEN dòng 133, 434–444 (nghỉ hưu sinh từ 58 tuổi) | Yêu cầu 2 mở bằng "Theo quy tắc rà soát nội bộ của công ty"; ghi chú thiết kế |
| `hr-k2` (cấp) | Trung bình gần Dễ | Hạ Dễ | QDC 2.2: 1 bảng; 2 tầng (lọc + gom, đếm có điều kiện); quy tắc ghi trong đề; 1–2 bẫy; chỉ độ sâu nghiệp vụ ở Trung bình → Dễ 4/5 | `cap=easy`; ERD 2 bảng có chữ trên đường nối, 1 bảng nhiễu; bản đồ (QDC 0.1 #5: mọi module có đủ 4 cấp, không tính lệch khung) |
| `hr-k5-ty-le-thieu-du-lieu` | Trung bình gần Dễ | Hạ Dễ | QDC 2.2: 1 bảng, đề ghi rõ sáu cột, 1 bẫy (`COUNT(cột)`), một phép chia → Dễ 4/5; chỉ trục số bước ở Trung bình | `cap=easy`; ERD 2 bảng có chữ trên đường nối; ghi chú thiết kế; bản đồ |
| `hr-k8-thieu-quan-ly-ra-0` | Trung bình gần Dễ | Hạ Dễ | QDC 2.2: sửa lỗi logic một chỗ (so chuỗi rỗng thay `IS NULL`), 1 bảng, lọc + gom, 1 bẫy, 1 khái niệm → Dễ 4/5; DD mục 1 (`manager_id` khoảng 1% trống) | `cap=easy`; ERD 2 bảng; ghi chú thiết kế; bản đồ |
| `hr-k4-bao-cao-vong` | Khó gần Trung bình | Hạ Trung bình | QDC 2.2: 1 bảng tự nối, tự nối ba điều kiện, 2 bẫy đều lộ ở public, điều kiện theo thời điểm → Trung bình 4/5; chỉ mức mơ hồ ở Khó. Không thêm được bẫy chỉ lộ ở hidden-1 nếu không đổi dữ liệu | `cap=medium`; ERD 3 bảng chỉ ký hiệu, bỏ `erdkhoa`; ghi chú thiết kế chấm từng trục; bản đồ |
| `hr-k6-compa-tu-tinh` | Khó gần Trung bình | Hạ Trung bình | QDC 2.2: 2 bảng, nối nhiều cột rồi gom, 1–2 bẫy, công thức compa-ratio → Trung bình 4/5 | `cap=medium`; ERD 3 bảng chỉ ký hiệu (nối `job_family` – `job_role`), bỏ `erdkhoa`; ghi chú thiết kế; bản đồ |
| `hr-p1-nghi-ba-loai-mot-lan-quet` | Optimize Trung bình | Hạ Dễ | QDC 2.1 (optimize theo mẫu CHOT mục 4: gộp nhiều lần quét = Cơ bản, nâng một bậc khi có ≥ 1 bẫy dữ liệu) và 2.3 mục 14; bẫy `COUNT(điều kiện)` | `cap=easy`; ERD 2 bảng; ghi chú thiết kế; bản đồ |
| `hr-p7-dem-theo-thang-chi-muc` | Câu write không chấm kế hoạch chạy | Giữ write, giữ Trung bình | BAO-CAO 3.1; QDC 2.3 mục 14 | Ghi chú thiết kế ghi rõ không chấm kế hoạch chạy và lý do giữ cấp |
| `hr-p5-tang-luong-khong-tu-noi` | Lời giải ít lần quét hơn nhưng nhiều dòng trung gian hơn starter | Giữ ràng buộc số lần quét, không thêm `ngansach` | BAO-CAO 3.1 | Ghi chú thiết kế |
| `hr-p9-pareto-quan-ly` | Khung `ROWS`/`RANGE` gần M8 | Giữ ở M10 | QDC 2.3 mục 15 | Ghi chú thiết kế |
| `hr-p3`, `hr-p5`, `hr-p6`, `hr-p9` | ERD Khó 3–4 bảng nhiễu | Giữ 5 bảng chỉ khoá như v2 | CHOT-FORMAT mục 3; QDC 1.3 sửa theo quy_chuan 23:05 (lời giải dùng ít bảng thì thêm bảng nhiễu cho đủ 5) | ERD không đổi so với v2; ghi chú thiết kế ghi căn cứ |
| `hr-c9`, `hr-c10` | Tiền tố lời giải thích bước kết luận | Theo gói mẫu quy chuẩn: phương án đúng mở bằng "Đúng: ", phương án sai không có tiền tố | QDC 1.1 (sửa theo quy_chuan 23:05; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4) | "Đúng. " → "Đúng: " ở 2 phương án đúng; phương án sai không tiền tố (lượt trước đã thêm "Chưa đúng. ", nay gỡ lại theo quy chuẩn) |

## v4 – đủ 4 cấp mỗi module (11/11/2026, BRIEF-CAP-DO-MODULE)

Căn cứ: `quy_chuan/lo-trinh-sql/assets/js/data.js` (mọi module đủ 4 cấp; M9 Cơ bản "HAVING COUNT > 1", M10 Dễ "GROUP BY thay UNION ALL", "lọc năm dùng được chỉ mục"), CHOT-FORMAT mục 3 (ERD theo cấp), mục 4 (optimize), HD mục 5, 6, QUYET-DINH-CHUNG 1.3, 2.1–2.2. Mục tiêu mỗi module: 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó.

| Module | Trước (CB · Dễ · TB · Khó) | Sau |
|---|---|---|
| M9 Data Quality | 0 · 3 · 5 · 1 (k2, k5, k8 Dễ; k1, k3, k4, k6, k7 TB; k9 Khó) | 2 · 3 · 2 · 2 (k1, k7 · k2, k5, k8 · k4, k6 · k3, k9) |
| M10 Query Performance | 2 · 1 · 2 · 4 (p2, p8 · p1 · p4, p7 · p3, p5, p6, p9) | 2 · 3 · 2 · 2 (p2, p8 · p1, p3, p6 · p4, p7 · p5, p9) |

Viết lại 5 câu (tối thiểu: M9 thừa 3 TB, thiếu 2 CB và 1 Khó; M10 thừa 2 Khó, thiếu 2 Dễ). Tỷ lệ hình thức giữ nguyên: M9 6 write + 3 debug; M10 6 optimize + 2 write + 1 debug. Case c9, c10 giữ nguyên.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `hr-k1-co-lech-diem-danh-gia` → `hr-k1-de-bat-vuot-tham-nien` | write TB → CB (E1, customer) | Nội dung mới: đếm nhân viên tháng 12/2025 có `months_since_promotion > tenure_months` (điểm lạ thật: nhân viên mới có hai số cùng bắt đầu từ 0). Không giữ chủ đề "cờ kết quả cao có điểm trống" vì làm Cơ bản sẽ trùng nội dung hr-n5 (gói 1). ERD 1 bảng có giá trị mẫu; 2 gợi ý; wrong `>=`, không lọc tháng | 1 bảng · 1 tầng lọc + đếm · cột và giá trị ghi rõ, ERD có giá trị mẫu · 0 bẫy · 1 khái niệm (đề bạt): CB 5/5 |
| `hr-k3-gan-ket-hai-nguon` → `hr-k3-gan-ket-lech-so-cong-ty` | write TB → Khó (E2, customer) | Giữ đối soát điểm gắn kết tháng với khảo sát quý; thêm so với mặt bằng công ty (`chenh_so_cong_ty`, mức chung tính trên mọi dòng, hàm cửa sổ trên kết quả gom); ngưỡng 15 → 10 để tỷ lệ lệch đủ lớn; đề nói bằng lời, cách ghép quý ở `\erdkhoa`; ERD 5 bảng chỉ khoá, không `\erdnoi`, 3 bảng nhiễu; 4 wrong (nối theo năm, ô trống thành 0, thiếu cận trên chỉ rớt ở hidden-1, mức chung là bình quân tỷ lệ các phòng) | 2 bảng (TB) · 4 tầng (Khó) · lời kinh doanh + erdkhoa (Khó) · 4 bẫy, 1 chỉ lộ ở hidden-1 (Khó) · chỉ số nhiều điều kiện so với mức chung (Khó): Khó 4/5 |
| `hr-k7-tong-theo-bac-lech` → `hr-k7-doi-bac-thua-nguoi` | debug TB → CB (E2 after_sales → E1 finance) | Starter liệt kê người có hơn một bậc năm 2025 nhưng viết `HAVING COUNT(DISTINCT job_level) >= 1` (sai toán tử, ra gần đủ công ty); sửa thành `> 1`. ERD 1 bảng có giá trị mẫu; wrong bỏ DISTINCT, bỏ điều kiện tháng | sửa một lỗi dễ thấy · 1 bảng · 1 tầng gom có điều kiện nhóm (như bài CB của M9 trên lộ trình) · 0 bẫy · 1 khái niệm: CB 5/5 |
| `hr-p3-top3-khong-tuong-quan` → `hr-p3-loc-ngay-dung-chi-muc` | optimize Khó → Dễ (C1 operations → A3 marketing) | Theo bài Dễ "lọc năm dùng được chỉ mục" của M10: starter `YEAR(approval_date) = 2025 AND QUARTER(...) = 4` đọc hết bảng; lời giải khoảng ngày nửa mở dùng `idx_req_approval`. `ngansach=2` (đo public: 940 so với 140 dòng trung gian, cùng 1 lần quét). Thêm chỉ mục của `recruiting_pipeline.approval_date` vào khái niệm `chi-muc`. ERD 2 bảng, chữ trên đường nối; wrong thiếu cận trên (hidden-1, R0801), wrong `DATE_FORMAT` vẫn bọc cột (vượt ngân sách) | 1 bảng · 2 tầng lọc + gom · cột, khoảng ngày ghi rõ · 1 bẫy (cận trên, hidden-1) · 1 phép bình quân: Dễ |
| `hr-p6-enps-noi-mot-thang` → `hr-p6-y-dinh-o-lai-mot-lan-quet` | optimize Khó → Dễ (A3 → B1, customer) | Đúng mẫu Dễ CHOT mục 4 (UNION ALL mỗi quý một nhánh → một GROUP BY, như o2) trên `engagement_survey`: số phiếu, ý định ở lại bình quân, tỷ lệ phiếu 1 điểm theo quý 2025. `quettoida={engagement_survey=1}` (starter 4 lần). Không dùng eNPS theo quý để tránh trùng nội dung hr-a6 (gói 2). Ghi chú: lời giải đọc hết chỉ mục nên nhiều dòng trung gian hơn starter, chỉ chấm số lần quét như p5. ERD 2 bảng; wrong thiếu cận trên (hidden-1, '2026-Q1'), `COUNT(điều kiện)` | 1 bảng · 2 tầng · cột, cách tính ghi rõ · 1 bẫy (cận trên, hidden-1) · 1 phép chia: Dễ |

Kiểm lại: bộ kiểm đầy đủ cả gói `cong-cu/ket-qua/cap-do/hr-goi-5/` → **KIEM TRA: 0 loi**, 0 cảnh báo; mọi wrong mới rớt đúng biến thể ghi trong `\ghichuthietke`; kết quả public khác hidden-1 ở cả 5 câu mới; mọi solution < 1,3 giây. Biên dịch XeLaTeX `cong-cu/ket-qua/cap-do/hr-goi-5/bien-dich/`: 56 trang, 0 lỗi LaTeX, 0 ký tự thiếu. Thư mục gói vẫn đúng 4 file.

Sửa kèm: dòng chú thích đầu khối của k2, k4, k5, k6, k8, p1, p2, p8 ghi đúng cấp hiện tại (cũ còn ghi cấp trước v3); khai báo thêm khái niệm `de-bat` (chép từ STYLE-hr mục E). `BAN-DO-100-CAU.md`: chỉ sửa 5 dòng của gói 5, dòng M9, M10, dòng gói 5, bỏ k7 khỏi ô trùng E2 · after_sales · medium · debug, thêm ghi chú v4; các bảng tổng toàn bộ chưa cộng lại (agent gói khác đang sửa song song).

Ô trùng: 5 ô mới (E1·customer·basic·write, E2·customer·hard·write, E1·finance·basic·debug, A3·marketing·easy·optimize, B1·customer·easy·optimize) không trùng ô nào trong gói, cũng không trùng gói 1–4 theo bản đồ. Gần nội dung (không trùng ô): p3 với p7 (cùng bài học chỉ mục; p7 là write trên cột chuỗi, không chấm kế hoạch) và p8; p6 với hr-s5 (gói 2, cùng cột `intent_to_stay`, khác câu hỏi).


## Sửa theo KIEM-V4 (11/11/2026)

Đầu vào: `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`. Không đổi cấp câu nào; mỗi module vẫn 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Quy tắc ô (đính chính của người điều phối 11/11): trùng ô giữa hai gói được phép, chỉ gỡ khi trùng trong cùng gói hoặc trùng cả chủ đề.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| hr-k2-loai-ly-do-nghi | B: `\ghichuthietke` mở bằng ``Trung bình'' trong khi `cap=easy` | Đổi thành ``Dễ, E1: …''. | Bộ kiểm cả gói 0 lỗi |
| hr-k5-ty-le-thieu-du-lieu | C: ghi chú mở bằng ``Trung bình'' rồi cuối lại ghi hạ Dễ | Đổi thành ``Dễ (v3 hạ từ Trung bình), E1: …''. | Bộ kiểm cả gói 0 lỗi |
| hr-k6-compa-tu-tinh | B: ghi chú mở bằng ``Khó'' trong khi `cap=medium`; wrong `noi_thieu_nam` chạy 72–88 giây | Đổi thành ``Trung bình, E2: …''; ghi thời gian chạy của wrong vào `\ghichuthietke` và mục chờ giảng viên bên dưới. | Bộ kiểm cả gói 0 lỗi |
| hr-k8-thieu-quan-ly-ra-0 | B: ghi chú mở bằng ``Trung bình'' trong khi `cap=easy` | Đổi thành ``Dễ, E1: …''. | Bộ kiểm cả gói 0 lỗi |
| hr-k4-bao-cao-vong | B: ô E1 · operations · medium · write trùng j6 (gói 3), đề xuất đổi mảng sang customer | Không áp: trùng giữa hai gói và khác chủ đề (vòng báo cáo / quản lý không cao bậc hơn cấp dưới), được phép theo đính chính của người điều phối. Mảng operations đúng STYLE-hr G (cây quản lý). | – |

Bộ kiểm đầy đủ cả gói `cong-cu/ket-qua/sua-v4/hr-goi-5/` → **KIEM TRA: 0 loi**; biên dịch XeLaTeX `cong-cu/ket-qua/sua-v4/hr-goi-5/bien-dich/`: 0 lỗi LaTeX. Thư mục gói vẫn đúng 4 file.

**Chờ giảng viên (KIEM-V4):** wrong `noi_thieu_nam` của k6 là lỗi học viên hay mắc nhưng chạy 72–88 giây mỗi biến thể (B đo lúc máy bận). Nếu máy chấm có giới hạn thời gian, học viên mắc lỗi này sẽ gặp hết giờ thay vì thấy sai kết quả. Cần giảng viên/dev chọn: giữ, hay đổi dữ liệu mẫu, hay báo lỗi thời gian rõ hơn.

**Đã quyết 11/11: fix.** Nguyên nhân: khi nối thiếu `benchmark_year`, khoá chính của `country_market_benchmark` (bắt đầu bằng năm) không dùng được, MySQL chọn quét 852 dòng mức lương thị trường rồi với mỗi dòng tra chỉ mục `idx_snap_country_dept` theo nước (khoảng 12 nghìn dòng mọi tháng). Phạm vi cũ → mới: mọi nhóm chức danh, năm 2025 (37.077 dòng) → chỉ nhóm chức danh `job_family = 'Software Engineer'`, năm 2025 (2.452 dòng public); bảng mức lương thị trường khớp nhóm còn vài chục dòng. Giữ mã, cấp Trung bình, hình thức write, dạng E2, mảng finance, bẫy nối thiếu năm và bẫy làm tròn (làm tròn 3 chữ số vẫn đổi `so_dong_lech`: Indonesia 38 → 35). Đã sửa: bối cảnh, yêu cầu 1 (thêm nhóm chức danh), câu hỏi tab Nghiệp vụ, gợi ý 1, `\ghichuthietke` (bỏ ghi chú 72–88 giây, ghi lý do phạm vi), solution và wrong `noi_thieu_nam` (thêm `AND s.job_family = 'Software Engineer'`). Giây trước → sau (đo tay, gồm khoảng 0,4 giây khởi động `docker exec`): wrong `noi_thieu_nam` 35–37 giây (máy rảnh; B đo 72–88 lúc máy bận) → 0,5 giây mỗi biến thể; solution (`do_gio.py`, min) 0,3 → 0,2–0,3 giây (bộ kiểm 0,07 / 0,05 giây). Cách học viên mắc lỗi tự nhiên khác cũng đo dưới 0,6 giây: lọc năm bằng `LEFT(snapshot_month, 4) = '2025'`, `LIKE '2025%'`, `>= '2025-01'`, lọc nhóm ở `b.job_role` hoặc bằng `LIKE 'Software%'` (đã thử và bỏ phương án chỉ xét tháng 12/2025 cho mọi nhóm chức danh: lọc tháng bằng `=` chạy 0,5 giây, nhưng lọc bằng hàm như `LEFT(snapshot_month, 7)` vẫn 10–18 giây). Wrong rớt public và hidden-1; public ≠ hidden-1 (`so_dong` khác, Thailand `so_dong_lech` 24 / 21). Bộ kiểm cả gói `cong-cu/ket-qua/quyet-gv/hr-goi-5/` → **KIEM TRA: 0 loi** (20 câu, 0 cảnh báo); biên dịch `cong-cu/ket-qua/quyet-gv/hr-goi-5/bien-dich/`: 56 trang, 0 lỗi LaTeX. Ghi chú: `hr-c10` b3 cũng có wrong `noi_thieu_nam` nhưng chạy 0,4 giây, không cần sửa.
