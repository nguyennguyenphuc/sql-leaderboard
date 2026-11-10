# Quyết định 22 điểm "Chờ giảng viên" · bộ HR (`hr`)

Ngày 10/11/2026. Nguồn điểm: `BAO-CAO-TONG-HOP.md` mục 3.1–3.4, 3.6, 3.8 (22 điểm của `hr`) và mục 3.5 (quy ước chung, áp theo `QUYET-DINH-CHUNG.md`, gọi tắt QDC). Chi tiết từng câu ở mục "Quyết định v3 (10/11)" cuối `ho-so/goi-<k>/DA-SUA.md`.

Nguồn domain đã dùng (chỉ đọc):
- DD: `H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\Project 02 HR Analytics\data\data_dictionary.md` (mục 1 bảng tháng, 2 `position_plan`, 3 `recruiting_pipeline`, 4 `engagement_survey`, 5 mức lương thị trường).
- GEN: `…\Project 02 HR Analytics\scripts\augment_datasets.py` (cách sinh dữ liệu: trần giờ làm thêm theo nước dòng 63–66; nghỉ hưu từ 58 tuổi dòng 133, 434–444; thâm niên và số tháng từ lần đề bạt dòng 226–232, 258; tuyển mới từ tháng thứ hai dòng 388; phiếu khảo sát dòng 415–426, 648–660; yêu cầu `'Backfill'` dòng 600–609).
- Bộ luật Lao động 2019 (Điều 35 báo trước, Điều 98 tiền lương làm thêm giờ, Điều 105 giờ làm việc bình thường, Điều 169 tuổi nghỉ hưu): https://thuvienphapluat.vn/van-ban/Lao-dong-Tien-luong/Bo-Luat-lao-dong-2019-333670.aspx
- Nghị định 135/2020 (lộ trình tuổi nghỉ hưu): https://thuvienphapluat.vn/van-ban/bao-hiem/decree-135-2020-nd-cp-on-retirement-age-459280.aspx
- Nghị định 145/2020 Điều 55 (tiền lương giờ làm căn cứ trả lương làm thêm): https://luatvietnam.vn/lao-dong-tien-luong/huong-dan-quy-dinh-moi-ve-tien-luong-562-28487-article.html
- Báo cáo khảo sát gắn kết theo nhóm, ngưỡng nhóm tối thiểu: https://support.cultureamp.com/en/articles/7048607-report-filters

Dữ liệu có 6 nước (Vietnam, Indonesia, Philippines, Thailand, Malaysia, Singapore): luật Việt Nam chỉ dùng cho câu chỉ xét Việt Nam (n9, c8); câu nhiều nước gọi rõ là quy tắc nội bộ (k2) hoặc nói "luật lao động của từng nước" (s4).

## Bảng 22 điểm

| # | Mục báo cáo | Mã câu (gói) | Điểm | Trạng thái | Quyết định và căn cứ |
|---|---|---|---|---|---|
| 1 | 3.1 | hr-p7 (g5) | Câu write không chấm kế hoạch chạy | Đã sửa | Giữ write, giữ Trung bình; `\ghichuthietke` ghi rõ không chấm kế hoạch chạy (QDC 2.3 mục 14) |
| 2 | 3.1 | hr-p5 (g5) | Lời giải nhiều dòng trung gian hơn starter | Đã sửa | Giữ ràng buộc số lần quét, không thêm `ngansach`; ghi lý do ở `\ghichuthietke` |
| 3 | 3.1 · RS | hr-c6 (g3), hr-c8 (g4) | K32: chỉ phương án đúng có câu rào | Đã sửa (c6) / Giữ nguyên (c8) | c6: bỏ rào "theo dõi thêm" ở phương án đúng, ý tương quan chuyển vào lời giải thích. c8: kiểm lại, v2 đã cân (phương án đúng không có rào, rào ở một phương án sai) |
| 4 | 3.2 | hr-c7 (g4) | Thiên lệch người ở lại | Đã sửa | Giữ cách chọn nhóm; lời giải thích phương án đúng nêu bước 3 chưa bỏ được thiên lệch người ở lại |
| 5 | 3.2 | hr-c8 b3 (g4) | Hai nhóm đo ở hai thời điểm | Đã sửa | Giữ cách so; `\luuy` thêm câu nêu hai thời điểm đo (DD mục 5: mức lương thị trường theo năm) |
| 6 | 3.3 | hr-q3 (g3) | `employee_id` người gắn kết cao nhất (bảo mật khảo sát) | Đã sửa (đổi SQL) | Đổi sang mức cao nhất và số người đạt mỗi nước × phòng ban, bỏ `employee_id`; đổi tiêu đề, lời nhắn, mục đích, lưu ý, wrong. Căn cứ: DD mục 1 (điểm hằng tháng có sai số đo), thông lệ báo cáo theo nhóm (Culture Amp) |
| 7 | 3.3 | hr-q2 (g3) | 260/317 yêu cầu là `'Backfill'` | Đã sửa | Giữ SQL; `\luuy` nêu vai trò yêu cầu thay thế (DD mục 2, 3; GEN 600–609) |
| 8 | 3.3 | hr-q4 (g3) | Phiếu cùng quý có thể sau ngày nghỉ | Đã sửa | Giữ tính tới hết quý nghỉ: phiếu quý ghi ở tháng đầu người đó còn làm trong quý nên luôn trước hoặc cùng tháng nghỉ (DD mục 4; GEN 415–426, 648–660); thêm câu `\luuy` |
| 9 | 3.3 | hr-t7 (g4) | 140 người thâm niên 0 tháng 2024-01 | Giữ nguyên (có căn cứ) | 2024-01 là nhóm ban đầu, không phải tuyển trong kỳ (GEN 226–232, 268–270, 388); hidden-1 129 người; ghi ở `\ghichuthietke` |
| 10 | 3.3 | hr-k2 (g5) | Ngưỡng 60 tuổi | Đã sửa | Giữ ngưỡng, yêu cầu ghi "Theo quy tắc rà soát nội bộ của công ty"; BLLĐ 2019 Điều 169, NĐ 135/2020 (2025: nam 61 tuổi 3 tháng, nữ 56 tuổi 8 tháng) chỉ áp Việt Nam; dữ liệu sinh nghỉ hưu từ 58 tuổi (17/120 người nghỉ hưu dưới 60) |
| 11 | 3.3 | hr-r5 (g1) | "Hai năm chưa đề bạt" với người mới | Giữ nguyên (có căn cứ) | Trong kết quả không ai thâm niên dưới 24 tháng ở cả hai biến thể; số tháng từ lần đề bạt của nhóm ban đầu gồm thời gian trước khi vào (GEN 258); ghi ở `\ghichuthietke` |
| 12 | 3.3 | hr-n9 (g1) | Mốc 176 giờ | Đã sửa | Giữ giả định; `\luuy` thêm câu: 22 ngày × 8 giờ, thực tế chia theo ngày làm việc của doanh nghiệp (NĐ 145/2020 Điều 55; BLLĐ Điều 98, 105) |
| 13 | 3.3 | hr-s4 (g2) | "Hẹn ngày đi làm sớm hơn trong thư mời" | Đã sửa | Xác nhận v2 (thời hạn báo trước là nghĩa vụ với nơi làm cũ, BLLĐ Điều 35; luật từng nước khác nhau); `\luuy` thêm câu về khoảng chờ |
| 14 | 3.4 | hr-r4, r6, r8 (g1) | Cấp Dễ ở M1–2 | Đã sửa | Giữ r4, r6 Dễ; hạ r8 Cơ bản, ERD 1 bảng có giá trị mẫu (QDC 2.1, 2.3 mục 9) |
| 15 | 3.4 | hr-a6 (g2) | eNPS Trung bình | Đã sửa | Giữ Trung bình (QDC 2.3 mục 10); ghi lý do |
| 16 | 3.4 | hr-a3 (g2) | Cấp Trung bình | Đã sửa | Hạ Dễ (QDC 2.3 mục 11); ERD 2 bảng có chữ trên đường nối |
| 17 | 3.4 | hr M3, M4 (g2) | Phân bổ cấp | Giữ nguyên (có căn cứ) | Chấp nhận (QDC 2.3 mục 12); bản đồ cập nhật theo a3 |
| 18 | 3.4 | hr-f5, c8, t8 (g4) | Sát ranh giới cấp | Giữ nguyên (có căn cứ) | Đạt 3/5 trục (QDC 2.3 mục 13) |
| 19 | 3.4 | hr-k2, k5, k8, p1, p7, k4, k6 (g5) | Cấp M9, M10 | Đã sửa | Chấm lại theo QDC 2.2 (≥ 3/5 trục): k2, k5, k8 → Dễ (Dễ 4/5 trục); p1 → Dễ (mẫu optimize Cơ bản + 1 bẫy); k4, k6 → Trung bình (Trung bình 4/5 trục); p7 giữ Trung bình. ERD đổi theo cấp, điểm từng trục ghi ở `\ghichuthietke`; bản đồ ghi lệch khung M9, M10 |
| 20 | 3.4 | hr-p9 (g5) | Khung `ROWS`/`RANGE` | Đã sửa | Giữ ở M10 (QDC 2.3 mục 15); ghi lý do |
| 21 | 3.6 | hr-s5, hr-s7 (g2) | Mã lệch nội dung | Đã sửa | `hr-s5-y-dinh-o-lai-thap-q3` → `hr-s5-y-dinh-o-lai-thap-2025`; `hr-s7-dem-nghi-theo-nam-null` → `hr-s7-dem-nghi-theo-nam-thieu-2025` (cau-hoi.tex, solution.sql, BANG-PHAN-CONG, DA-SUA, bản đồ) |
| 22 | 3.8 | hr-r4 (g1) | Tiêu đề "Account Executive" | Đã sửa | Giữ tiêu đề (giá trị `job_family`); lời nhắn giải nghĩa "(nhân viên phụ trách khách hàng)" |

Cộng: 18 đã sửa (#3 tính là đã sửa vì sửa c6; phần c8 giữ), 4 giữ nguyên có căn cứ (#9, #11, #17, #18). Không còn mục "chờ".

## Quy ước chung đã áp (mục 3.5, theo QDC bản sửa theo quy chuẩn lúc 23:05)

Thứ tự ưu tiên: `quy_chuan` > QDC > STYLE > brief. Đã đọc lại bảng QDC 0.1 ("Các điểm đã sửa theo quy chuẩn") và chỉnh các câu đã áp quy tắc cũ.

| QDC | Áp vào hr | Đã sửa gì |
|---|---|---|
| 1.1 kết luận case (0.1 #1) | 10 case | Phương án đúng "Đúng. " → "Đúng: " (10 chỗ, như gói mẫu c1–c4); phương án sai không tiền tố. "Chưa đúng. " thêm ở lượt trước đã gỡ lại. Lời giải thích ≤ 35 tiếng |
| 1.3 ERD Khó (0.1 #4) | Mọi câu Khó | Khó vẽ 5 bảng chỉ khoá, không `\erdnoi`: t5, t7, f4, f8, p3, p5, p6, p9 giữ 5 bảng như v2 (lượt trước đã rút, nay khôi phục); t4, f5, c8 nâng từ 3–4 lên 5 bảng. Câu hạ cấp: a3, k2, k5, k8, p1 (Dễ, 2 bảng, 1 bảng nhiễu, chữ trên đường nối); k4, k6, q3 (Trung bình, 3 bảng, chỉ ký hiệu) |
| 1.9 tiêu đề (0.1 #3, ≤ 13 tiếng) | r1, r3 (g1) | Đã rút ở lượt trước; QDC 1.9 bản mới: "câu nào đã rút về ≤ 10 tiếng thì giữ". r1 "Ai ở Việt Nam làm thêm từ 30 giờ tháng 12/2025?"; r3 "Yêu cầu tuyển qua giới thiệu nội bộ năm 2025" |
| 2.1 khung cấp module (0.1 #5) | k2, k5, k8 (M9 Dễ), p1 (M10 Dễ) | Mọi module có đủ 4 cấp: không còn ghi "ngoài khung" ở bản đồ và ghi chú thiết kế |

## Kiểm

Bộ kiểm đầy đủ (public + hidden-1, `cong-cu/ket-qua/kiem-cuoi/hr-goi-<k>/log.txt`), chạy lại sau mọi lần sửa: gói 1–5 đều "KIEM TRA: 0 loi" (gói 5 sửa thêm một chữ trong ghi chú thiết kế sau lượt chạy đầy đủ, đã kiểm tĩnh lại: 0 lỗi). q3 có SQL mới: solution chạy được trên hai biến thể, cả 3 wrong đều rớt (bộ kiểm 0 lỗi).

Biên dịch XeLaTeX (`cong-cu/ket-qua/bien-dich/hr-goi-<k>-v3/`): 5 gói 0 lỗi LaTeX, 0 ký tự thiếu font (chỉ còn cảnh báo Overfull hbox về trình bày như trước).
