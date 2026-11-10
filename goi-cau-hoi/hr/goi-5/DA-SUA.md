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
