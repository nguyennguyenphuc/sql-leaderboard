# Đã sửa · gói 5 GAME Jelly Trail Academy (jelly) · v2

Theo REVIEW-B.md, REVIEW-C.md (10/11/2026). Không đổi `ma`, không sửa database.
- **Kiểm lại SQL** (k2, p3, p7, p9): chạy trên gói tạm `cong-cu/ket-qua/sua/jelly-goi-5/`, kết quả **KIEM TRA: 0 loi**.
- **Kiểm tĩnh cả gói** (`--chi-phan-tich`): **0 lỗi**.
- **Biên dịch** (`cong-cu/ket-qua/bien-dich/jelly-goi-5/`): 57 trang, **0 lỗi LaTeX**, 0 ký tự thiếu.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| jelly-k1-trung-khoa | Đổi tiêu đề thành "Hai bảng nguồn… có dòng ghi trùng không?". Bỏ chữ "bảng" khỏi lời nhắn và đổi câu kết. Bỏ nhãn `:PK` ở hai bảng cần kiểm. `\ghichuthietke` ghi rõ giới hạn: bài viết hằng số vẫn qua. | tĩnh |
| jelly-k2-mo-coi | **Đổi phạm vi kiểm** vì v1 có 0 dòng mồ côi ở cả hai biến thể. Nay kiểm giao dịch gắn màn (`level_id_if_relevant`) không có lượt chơi đúng màn trong cùng phiên; có dòng thiếu cặp thật ở public và hidden-1. Viết lại tiêu đề, bối cảnh (có lời nhờ), yêu cầu, ERD, khái niệm `dong-mo-coi`. Ba bài sai mới đều là lỗi thật: nối thẳng gây nhân dòng, nối thiếu cột màn, INNER JOIN làm mất dòng thiếu cặp. | gói tạm: 0 lỗi, 3 wrong rớt public + hidden-1 |
| jelly-k3-cohort-day-kiem | Sửa lời nhắn theo B ②③. Sửa `\luuy` "tự so với chính nó" thành "không so hai cột trong cùng một bảng". Không sửa database, nên `\ghichuthietke` ghi rõ câu chỉ chấm được `so_dong_kiem` và lỗi đảo `DATEDIFF`. | tĩnh |
| jelly-k4-max-level-giam | **Hạ xuống medium.** ERD 3 bảng có 1-n. Tiêu đề bỏ ẩn dụ "đi lùi". Yêu cầu bỏ "Với mỗi…" và đại từ "nó". `\goiy` 1 không còn đưa sẵn biểu thức đầy đủ. Đổi câu kết của lời nhắn. | tĩnh (SQL không đổi) |
| jelly-k5-extra-moves-doi-soat | Bỏ `booster_events` khỏi ERD, còn 2 bảng nhiễu. Sửa `\luuy` "làm mỗi dòng bị nhân lên". | tĩnh |
| jelly-k6-ad-revenue-lam-tron | Yêu cầu định nghĩa rõ "ngày-người" và chỉ xét ngày-người có xem quảng cáo, trên toàn bộ dữ liệu. `so_ngay_nguoi_doi_soat` ghi là "số ngày-người được ghép". Lời nhắn bỏ "cuối tháng" và nói rõ ngưỡng. Sửa `\luuy`. ERD còn 2 bảng nhiễu. Cách diễn giải ngưỡng: xem mục Chờ giảng viên. | tĩnh (SQL không đổi, đã khớp định nghĩa mới) |
| jelly-k7-bat-thuong-chi | Đổi "tiêu" thành "chi". `\goiy` bỏ "Nó". Viết lại `\luuy`, bỏ giọng tuyệt đối. Yêu cầu và khái niệm `ngoai-lai` đổi thành "cộng thêm hai lần độ lệch chuẩn". Đổi câu kết. `\ghichuthietke` ghi giới hạn: kết quả public và hidden-1 giống nhau. | tĩnh |
| jelly-k8-hoan-tien | Thêm vào `\ghichuthietke` rằng bài ghi hằng `tien_hoan = 0` cũng qua. | tĩnh |
| jelly-k9-phien-hai-dang-ma | Nghiệp vụ đổi "mọi kênh" thành "cả hai nền tảng". Viết lại định nghĩa "vào thẳng phần hướng dẫn". Đổi "hai lỗi chồng nhau" thành "hai lỗi". Sửa lời nhắn (bỏ chữ "vào" lặp). Câu `\luuy` lộ lỗi 1 chuyển sang `\goiy`. ERD còn 2 bảng nhiễu. | tĩnh |
| jelly-p1-dem-ket-qua-mot-lan | **Hạ xuống easy.** ERD 2 bảng, có chữ trên đường nối. Tiêu đề thành câu nghiệp vụ. Lời nhắn bỏ "Nó" và nghĩa kép của "bảng". Yêu cầu bỏ "với mỗi". Bỏ khái niệm `ty-le-thang-man`. | tĩnh (SQL không đổi) |
| jelly-p2-doanh-thu-hai-nguon | **Hạ xuống easy** (đúng khung CHOT). ERD 2 bảng có chữ trên đường nối. `ad_type` thống nhất gọi là "định dạng quảng cáo". Đổi tiêu đề. | tĩnh |
| jelly-p3-tren-tb-the-gioi | **Siết `ngansach` từ 2 xuống 1,5.** Số đo: khởi đầu 705.721 dòng, lời giải 352.965 dòng, nên khởi đầu nay vượt cả ngân sách lẫn số lần quét. Người hỏi đổi sang Data engineer. Tiêu đề thành câu nghiệp vụ. Thêm khái niệm `ty-le-thua` thay cho `ty-le-thang-man`. Viết lại `rangbuoc`. ERD còn 2 bảng nhiễu. `\ghichuthietke` ghi rằng cách CTE + JOIN cũng được chấp nhận. | gói tạm: 0 lỗi |
| jelly-p4-luy-ke-tu-noi | Lời nhắn đổi sang Data engineer, chỉ tả triệu chứng, không gọi tên cú pháp. Sửa `rangbuoc` "2 lần số dòng trung gian…". ERD còn 2 bảng nhiễu. | tĩnh |
| jelly-p5-nguoi-tra-tien-exists | Sửa tiêu đề "theo kênh cho nhẹ hơn". Tách câu dài trong lời nhắn. Sửa `rangbuoc`. | tĩnh |
| jelly-p6-dau-tu-sessions | **Hạ xuống medium.** ERD 3 bảng có 1-n. Sửa tiêu đề "chỉ với một lần đọc". Đổi câu kết. | tĩnh (SQL không đổi) |
| jelly-p7-index-ngay | **Bối cảnh v1 sai dữ liệu** (ngày 20/8 không có sự kiện). Đổi sang ngày 10/8, trong đợt Licorice Rescue 8–12/8. **Đổi sang optimize easy** để ràng buộc chỉ mục chấm được: khởi đầu `DATE(event_time) = …` đọc cả bảng (254.792 dòng), lời giải dùng `idx_attempts_date` (5.015 dòng), `ngansach=2`. Thêm bài sai vẫn bọc hàm, vượt ngân sách. Người hỏi đổi sang Data engineer. | gói tạm: 0 lỗi, khởi đầu vi phạm ngân sách, 3 wrong rớt |
| jelly-p8-ham-tren-cot | Sửa lời nhắn đúng triệu chứng của starter: MAU bằng đúng số ngày-người, mức độ gắn bó hai tháng bằng nhau, DAU bình quân tháng 8 thấp. Đổi tiêu đề thành "ra sai". Bỏ yêu cầu dùng chỉ mục (không chấm được), chuyển ý này vào `\goiy`. Giải nghĩa "ngày-người". Bỏ `\luuy` lộ lỗi. ERD còn 2 bảng nhiễu. | tĩnh (SQL không đổi) |
| jelly-p9-select-distinct-thua | **Lệch module:** đổi sang optimize medium, giữ mã. Khởi đầu lấy danh sách người chơi bằng `SELECT DISTINCT user_id FROM player_daily` thừa, nên đọc khoảng 80 nghìn dòng. `ngansach=1,3`, theo số đo khởi đầu 117.855 so với lời giải 74.790. Người hỏi đổi sang Data engineer. Bỏ "IAP" trong lời nhắn và "nó" ở `\luuy`. | gói tạm: 0 lỗi |
| jelly-c9-ab-mua-them-buoc | Bốn phương án viết thành câu liền, bỏ dấu hai chấm. Phương án đúng rút còn một câu. Sửa giải thích phương án 1 ("đã thua ít nhất một lần"). Đổi câu kết của lời nhắn. ERD còn 2 bảng nhiễu. Nguồn chỉ số chính: xem mục Chờ giảng viên. | tĩnh (SQL không đổi) |
| jelly-c10-man-28-30 | **Tách hai từ:** "sự cố" chỉ dùng cho crash, "vụ việc" cho việc màn 28–30 bị chỉnh quá khó (bối cảnh, nghiệp vụ, phương án; thêm `\luuy` định nghĩa). Viết lại giải thích phương án 3, bỏ suy diễn nhân quả. Thống nhất cách gọi "được mời thêm lượt đi" / "nhận thêm lượt đi". Thêm khái niệm `ty-le-thua`. ERD còn 2 bảng nhiễu. | tĩnh (SQL không đổi) |

Khuôn lặp đã phá:
- **Câu kết "Em … giúp chị/anh"**: khoảng một nửa số câu đã đổi cách kết (k1, k4, k7, k9, p2, p6, c9…).
- **Đại từ "nó" chỉ vật**: đã bỏ ở k2, k4, k7, p1, p3, p9.
- **ERD cấp Khó nhiều bảng nhiễu**: đã đưa về 1–2 bảng nhiễu.
- **Tiêu đề câu tối ưu nêu kỹ thuật**: đã đổi ở p1, p3 thành câu nghiệp vụ.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **k3, k7 – không chấm thật được** (trước ở mục Chờ giảng viên, mục 4): `mysql/jelly/04_bo_sung_bien_the_jelly.sql` (h), (i). Chạy solution trên `jelly` và `jelly_hidden_1` (user `sql_runner`): k3 ra 1 ở cột lệch `cohort_day` và lệch ngày cài (dòng `jta_user_003773` ngày 24/8 ghi ngày cài 14/7, `users` ghi 15/7), bài so hai cột trong `player_daily` ra 0 nên rớt; k7 ra 6 dòng thay vì 4 (Video Network thêm hai ngày chi vượt ngưỡng 11/7, 10/8). Ghi chú thiết kế đã sửa theo. k1 vẫn chờ (xem mục 4 dưới).

## Chờ giảng viên (cũ, đã quyết hết ở mục "Quyết định v3 (10/11)")

1. **k6 – ngưỡng và cách diễn giải đối soát.** Câu đếm 243 ngày-người lệch quá 0,00005 USD, nhưng lệch lớn nhất chỉ 0,00007 USD. Phần lệch đó có thể vẫn do làm tròn từng lần xem trước khi cộng. Cần người nắm đối soát doanh thu quảng cáo chốt ngưỡng, và chốt câu này nói về "lệch thật" hay "lệch do cách làm tròn".
2. **c9 – nguồn của chỉ số chính.** `primary_metric = extra_move_purchase_per_assigned_user_d0_6`. Câu đang đo bằng giao dịch `extra_moves_pack` trong `purchases`. Nếu đo bằng cờ `level_attempts.extra_moves_purchased`, nhánh thử cao hơn khoảng 12% và kết luận đảo chiều. Ngoài ra, chênh lệch giữa hai nhánh nhỏ và chưa kiểm ý nghĩa thống kê; ở hidden-1, b3 còn đảo chiều.
3. **c10 – phương án nhiễu 1.** Phương án này nêu đúng hai sự thật về Android, chỉ sai ở kết luận "đóng vụ việc". Cần xác nhận phương án này đủ rõ là sai. Cỡ mẫu iOS ở bản 2.1.1 nhỏ (572 lượt).
4. **k1 – không chấm thật được phần cốt lõi:** đáp án là hằng số 0 dòng thừa ở cả hai biến thể (khoá chính chặn dòng trùng, file 04 không thêm dòng trùng), nên bài viết hằng vẫn qua. Muốn chấm thật cần biến thể có dòng trùng khoá (bảng không khoá chính hoặc `jelly_hidden_2`).

## Quyết định v3 (10/11)

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| jelly-k1-trung-khoa | Đáp án 0 dòng thừa ở cả hai biến thể, bài trả hằng số vẫn qua (BAO-CAO 3.1) | Đổi bảng thứ hai từ `tutorial_steps` sang `sessions`, khoá nghiệp vụ (`user_id`, `session_start`). Không thêm được dòng trùng khoá vào biến thể ẩn vì mọi bảng jelly đều có khoá chính (`mysql/jelly/01_tao_bang_jelly.sql`). | Dữ liệu: `sessions` có 57 dòng thừa ở `jelly`, 52 ở `jelly_hidden_1` (cùng người chơi, cùng phút bắt đầu, hai `session_id`, thời lượng khác nhau); data_dictionary.md (Game\Jelly_Trail_Academy_v2\docs): `sessions` một dòng mỗi phiên, `session_start` là thời điểm bắt đầu. | Lời nhắn, yêu cầu, ERD (vẽ `sessions` có `session_id:PK`), nghiệp vụ (thêm `\luuy` về mã phiên), `bay`, `\ghichuthietke`. SQL: solution đổi bảng; wrong `khoa_thieu_cot_ngay` đổi theo; thêm wrong `khoa_ky_thuat_ma_phien` (đếm theo `session_id`, ra 0). Bài hằng 0 nay rớt. |
| jelly-c9-ab-mua-them-buoc | Nguồn đo chỉ số chính: giao dịch `extra_moves_pack` hay cờ `extra_moves_purchased` (BAO-CAO 3.2) | Đổi sang cờ `level_attempts.extra_moves_purchased`, ITT (tổng lượt nhận thêm lượt đi D0–D6 / người được chia). Phương án đúng: nhánh thử nhỉnh hơn nhưng chưa đủ chắc, chưa áp dụng ngay. Khác đề xuất mặc định (giữ `purchases`) vì tài liệu dự án nói ngược lại. | Game\JELLY_TRAIL_ACADEMY_BUSINESS_ANALYTICS_V2_QA_FINAL.docx, chương V mục 5.2–5.4: tử số lấy từ `level_attempts.extra_moves_purchased`, không lấy SKU `extra_moves_pack` (đổi SKU có thể đảo chiều); CI95 của B − A chứa 0, p = 0,094, "tín hiệu đáng quan tâm nhưng chưa kết luận". Số đo (đủ ngày): public A 0,0747, B 0,0838; hidden-1 A 0,0729, B 0,0826 (cùng chiều). | b2: yêu cầu, cột (`so_luot_nhan`, `luot_nhan_moi_nguoi`, `ty_le_nguoi_nhan_pct`), `bang`, gợi ý; SQL b2 solution và wrong đã tiếp xúc đổi nguồn; thêm wrong `dem_giao_dich_goi_thay_co` (SQL cũ). ERD: `level_attempts` thành bảng dùng, còn 1 bảng nhiễu. Nghiệp vụ: sửa `\luuy` chỉ số chính, thêm `\luuy` về `extra_moves_pack`. Viết lại 4 phương án và lời giải thích (≤ 2 câu, theo QUYET-DINH-CHUNG 1.1). |
| jelly-c10-man-28-30 | Phương án nhiễu 1 nêu đúng hai sự thật về Android; cỡ mẫu iOS 2.1.1 nhỏ (BAO-CAO 3.2) | Giữ phương án; lời giải thích nêu rõ vì sao chưa đóng được vụ việc. | Số đo public/hidden-1: Android 2.1.1 tỷ lệ thắng 67,25/67,04% so với 2.0.2 71,30/71,42%; iOS 2.1.1 thấp hơn 2.1.0 cả tỷ lệ thắng và D1; iOS 2.1.1 có 572/497 lượt. QA_FINAL chương III mục 3.7 ("phục hồi kỹ thuật không đồng nghĩa phục hồi"). | Lời giải thích phương án 1, phương án đúng, phương án 3 rút về ≤ 2 câu (QUYET-DINH-CHUNG 1.1); `\ghichuthietke`. SQL không đổi. |
| jelly-k6-ad-revenue-lam-tron | "Lệch thật" hay "lệch do cách làm tròn" (BAO-CAO 3.3) | Diễn giải là lệch do cách làm tròn; giữ SQL. | Lệch lớn nhất 0,00007 USD, chỉ vượt ngưỡng 0,00005 USD một chút; `ad_events.revenue_usd` và `player_daily.ad_revenue` khác số chữ số thập phân (`01_tao_bang_jelly.sql`). | `\ghichuthietke` bỏ "Chờ giảng viên", ghi cách diễn giải. Đề không có chữ "lệch thật". |

Kiểm (10/11): bộ kiểm gói 5 (MySQL, public + hidden-1) "KIEM TRA: 0 loi"; k1 hai wrong rớt public, hidden-1; c9 b2 hai wrong rớt public, hidden-1. Biên dịch XeLaTeX: 0 lỗi LaTeX, 0 ký tự thiếu font, 57 trang.

### Theo quy chuẩn (QUYET-DINH-CHUNG mục 0.1, sửa 23:05)

- Kết luận case: phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. " (theo 4 case mẫu `quy_chuan/goi-cau-hoi-mau`). Đổi máy, chỉ ở lời giải thích, không đổi nội dung phương án.

## v4 – đủ 4 cấp mỗi module (11/11, theo BRIEF-CAP-DO-MODULE)

Căn cứ: `quy_chuan/lo-trinh-sql/assets/js/data.js` (Module 9: basic `k1-dong-trung` `GROUP BY … HAVING COUNT(*) > 1`; easy `LEFT JOIN … IS NULL`, `NOT EXISTS`; medium `MIN, JOIN`, ngoại lai; hard đối soát ba bảng. Module 10: basic o1 đếm có điều kiện; easy o2 `UNION ALL`, dùng chỉ mục; medium o3 `AVG() OVER`; hard o4 `SUM() OVER`), CHOT-FORMAT mục 3 (ERD theo cấp), mục 4 (optimize), HD mục 5, 6, QUYET-DINH-CHUNG mục 0–2.

Phân bố cấp (9 câu mỗi module, không tính case):

| Module | Trước (v3) | Sau (v4) | Hình thức sau |
|---|---|---|---|
| M9 Data Quality | 0 Cơ bản · 0 Dễ · 6 Trung bình · 3 Khó | 2 Cơ bản (k1, k8) · 3 Dễ (k3, k6, k7) · 2 Trung bình (k2, k4) · 2 Khó (k5, k9) | 6 write + 3 debug (giữ) |
| M10 Query Performance | 0 Cơ bản · 3 Dễ · 3 Trung bình · 3 Khó | 2 Cơ bản (p6, p8) · 3 Dễ (p1, p2, p7) · 2 Trung bình (p5, p9) · 2 Khó (p3, p4) | 8 optimize + 1 debug (giữ) |

Viết lại 7 câu (tối thiểu: M9 thừa 4 Trung bình + 1 Khó, thiếu 2 Cơ bản + 3 Dễ; M10 thừa 1 Trung bình + 1 Khó, thiếu 2 Cơ bản). Case c9, c10 giữ cấp.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `jelly-k1-trung-khoa` → `jelly-k1-phien-ghi-hai-lan` | Trung bình → Cơ bản | Bỏ `player_daily`, `UNION ALL`, dòng tóm tắt; chỉ liệt kê cặp (`user_id`, `session_start`) có từ 2 dòng trong `sessions` (theo bài `k1-dong-trung` của lộ trình). Mảng customer → operations (phiên chơi). ERD 1 bảng có giá trị mẫu. Wrong: gom theo `session_id` (0 dòng), gom theo người chơi và ngày. | 1 · 1 tầng (gom, lọc nhóm) · đề ghi rõ cột, khoá · 0 · 1 khái niệm → Cơ bản 5/5 |
| `jelly-k3-cohort-day-kiem` (giữ mã) | Trung bình → Dễ | Bỏ cột `so_hoat_dong_truoc_ngay_cai` (luôn 0 ở hai biến thể) và bảng nhiễu `sessions`; ERD 2 bảng, chữ trên đường nối; gợi ý 2 nấc (đếm có điều kiện, biểu thức `DATEDIFF`). Thêm wrong không nối `users` (rớt hidden-1). | 2 có `JOIN` · 2 tầng · đề ghi rõ cột và công thức · 1 (đảo đối số `DATEDIFF`) · 1 công thức → Dễ 5/5 |
| `jelly-k6-ad-revenue-lam-tron` → `jelly-k6-quang-cao-bang-ngay` | Khó → Dễ | Đối soát ở mức ngày: `daily_kpi.ad_revenue` với tổng `ad_events.revenue_usd` làm tròn 2 chữ số, liệt kê ngày lệch (public 1 ngày, hidden-1 6 ngày). Bỏ ngưỡng 0,00005 USD, `saiso=0.00001`, CTE theo ngày-người. ERD 2 bảng, chữ trên đường nối. Wrong: so với tổng chưa làm tròn, làm tròn từng lần xem, cộng `ad_revenue` sau khi nối. | 2 có `JOIN` · 2 tầng (nối và gom, `HAVING`) · đề ghi rõ cột, mức làm tròn · 1 (so hai số khác số chữ số thập phân) · 1 công thức → Dễ 5/5 |
| `jelly-k7-bat-thuong-chi` → `jelly-k7-dau-doi-soat-phien` | Trung bình → Dễ | Sửa lỗi Dễ theo HD mục 6: đối soát DAU tuần 1–7/7 giữa `daily_kpi` và `sessions`, starter đếm `COUNT(s.user_id)` (đếm phiên) thay `COUNT(DISTINCT s.user_id)`. Mảng marketing → customer. ERD 2 bảng, đường nối có chữ, tô cảnh báo. Wrong: chỉ sửa một cột, bỏ cận trên của tuần. | 2 có `JOIN` · 2 tầng · đề ghi rõ cột và cách tính lại · 1 (đếm phiên thay người) · 1 công thức → Dễ 5/5; Sửa lỗi: 1 lỗi logic một chỗ |
| `jelly-k8-hoan-tien` → `jelly-k8-thuan-ra-0` | Trung bình → Cơ bản | Một dòng tháng 7: `so_giao_dich`, doanh thu gộp, doanh thu thuần; starter lọc cờ `is_refund = 1` thay `= 0` (một lỗi dễ thấy, như mẫu d1). Bỏ gom theo gói, cột tiền hoàn, bẫy thiếu `ELSE 0`. ERD 1 bảng có giá trị mẫu `is_refund = 0`. Người hỏi: thực tập sinh. | 1 · 1 tầng · đề ghi rõ cột · 0 · 1 khái niệm → Cơ bản 5/5; Sửa lỗi: 1 lỗi dễ thấy |
| `jelly-p6-dau-tu-sessions` → `jelly-p6-d1-d3-d7-mot-lan-quet` | Trung bình → Cơ bản | Đúng khung optimize Cơ bản của CHOT mục 4 (mẫu o1): ba truy vấn con quét lại `player_daily` → một lần đếm có điều kiện; một dòng ba cột D1, D3, D7 của nhóm cài 1–7/7. Bỏ mẫu số từ `users`, tỷ lệ, gom theo nền tảng. `quettoida={player_daily=1}`. ERD 1 bảng có giá trị mẫu. | 1 · 1 tầng · đề ghi rõ cột, giá trị `cohort_day` · 0 · 1 khái niệm → Cơ bản 5/5 |
| `jelly-p8-ham-tren-cot` → `jelly-p8-moc-dau-dot-su-kien` | Khó → Cơ bản | Giữ hình thức debug của M10. Bản viết lại để dùng chỉ mục (`idx_daily_activity`) đặt `>` thay `>=` ở mốc đầu đợt Licorice Rescue 8–12/8, mất ngày 8/8 (sai toán tử, dễ thấy). Bỏ MAU, ba lỗi chồng nhau. ERD 1 bảng có giá trị mẫu. Wrong: bỏ cận trên, mất ngày cuối. | 1 · 1 tầng · đề ghi rõ cột và khoảng ngày · 0 · 1 khái niệm → Cơ bản 5/5; Sửa lỗi: 1 lỗi dễ thấy |

Ô dạng × mảng × cấp × hình thức sau v4: không trùng trong gói. Đã so `BAN-DO-100-CAU.md` (bản đọc lúc 11/11 ~01:45): bảy ô mới (E1·operations·basic·write, E2·customer·easy·write, E2·finance·easy·write, E2·customer·easy·debug, E2·after_sales·basic·debug, D2·customer·basic·optimize, A2·customer·basic·debug) chưa có ở gói khác; ô cũ trùng giữa gói E2·finance·hard·write (t5, k6) nay hết trùng. Gần về chủ đề (khác ô): k7 và `jelly-a1-dau-thang-7` (DAU), k6 và `jelly-t5-doi-soat-kpi` (đối soát `daily_kpi`, Khó), p8 và `jelly-p7-index-ngay` (khoảng ngày có chỉ mục, khác bảng, khác hình thức).

Giọng văn: văn bản mới đọc theo BRIEF-KIEM-GOI bước 6 và STYLE-jelly (A, B, C, K33–K37): không nhắc kỹ thuật SQL ở bối cảnh; người hỏi câu Sửa lỗi Cơ bản là thực tập sinh phân tích (STYLE-jelly B.3); tiêu đề ≤ 13 tiếng.

## Sửa theo KIEM-V4 (11/11/2026)

Căn cứ: `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`. Không đổi cấp, không đổi mã câu nào. Trùng ô giữa các gói được phép (đính chính của người điều phối 11/11), nên không đổi mảng, dạng của câu nào; trong gói không có ô trùng.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| `jelly-c10-man-28-30` | C: b1 trùng hẳn c7.b2 (cùng truy vấn, cùng kết quả ở hai biến thể); bước 3 không được dùng | b1 so trong khoảng ba bản cùng chạy, từ ngày bản vá ra (15/8) tới hết 29/8, thêm một nấc gợi ý; lời giải b1 đổi cận dưới; wrong `phien_ban_luc_cai` chuyển sang kỳ mới; wrong mới `ca_cua_so_du_lieu` (cả cửa sổ 1/7–29/8, rớt public). b2, b3 ghi rõ "cả cửa sổ dữ liệu", SQL giữ. Lời giải thích phương án 1: "khoảng 4 điểm" → "khoảng 2 điểm" (Android 2.1.1 67,25% so với 2.0.2 69,48%); phương án 3 dẫn thêm bước 3 (lượt được mời thêm lượt đi ở 2.1.0 giảm mạnh). Kết luận giữ chiều ở cả hai biến thể. Không thêm bẫy thiếu cận trên ở b1 vì hidden-1 không có lượt màn 28–30 sau 29/8. | Bộ kiểm cả gói: c10 0 lỗi; 2 wrong b1 rớt public + hidden-1 |
| `jelly-c9-ab-mua-them-buoc` | B (góp ý không bắt buộc): "doanh thu D0–D6 không tăng" sai ở hidden-1 | Phương án đúng: "doanh thu D0--D6 gần như không đổi" để đúng ở cả hai biến thể. | Chỉ sửa chữ |

Kiểm:

- Bộ kiểm đầy đủ cả gói: `docker compose run --rm tools python cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/jelly/goi-5 --ra cong-cu/ket-qua/sua-v4/jelly-goi-5 --host sqllb-mysql --port 3306` → 20 câu, 85 khối SQL, `KIEM TRA: 0 loi`, 0 cảnh báo, mọi wrong rớt ít nhất một biến thể, mọi solution ra kết quả public khác hidden-1.
- Biên dịch: `bash cong-cu/bien_dich.sh goi-cau-hoi/jelly/goi-5 <ra>` → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo gói lệnh; PDF ở `cong-cu/ket-qua/sua-v4/jelly-goi-5/bien-dich/`.
- Thư mục gói vẫn đúng 4 file.
