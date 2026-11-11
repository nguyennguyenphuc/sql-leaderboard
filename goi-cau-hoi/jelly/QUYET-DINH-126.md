# Quyết định 22 điểm "Chờ giảng viên" · bộ `jelly` (v3, 10/11/2026)

Nguồn: `BAO-CAO-TONG-HOP.md` mục 3.1–3.4, 3.6 (22 điểm của jelly) và các mục 3.5 áp vào jelly. Không còn điểm nào "chờ".

Căn cứ domain (thư mục `Project DA\Game\`):
- **DD**: `Jelly_Trail_Academy_v2\docs\data_dictionary.md` (định nghĩa chỉ số: win rate, ARPDAU, D7 ROI proxy = doanh thu cohort day 0–6).
- **RM**: `Jelly_Trail_Academy_v2\README.md` (câu chuyện v2.1.0 Android SEA, bản vá 2.1.1).
- **QA**: `JELLY_TRAIL_ACADEMY_BUSINESS_ANALYTICS_V2_QA_FINAL.docx` (chương II bảng sáu khái niệm hoàn vốn; mục 3.2, 3.7, 4.2; chương V mục 5.2–5.4 thí nghiệm A/B).
- **BP**: `Blueprint_Jelly_Trail_Academy_v2.md`.
- **QDC**: `QUYET-DINH-CHUNG.md` ở thư mục gốc.

| # | Mục BC | Mã câu (gói) | Điểm | Trạng thái | Quyết định và căn cứ | Đã sửa |
|---|---|---|---|---|---|---|
| 1 | 3.1 | jelly-n5 (g1) | "năm gói" lệch hidden-1 | Đã sửa (trước v3) | Sửa 10/11 21:05 | – |
| 2 | 3.1 | jelly-k1 (g5) | Đáp án 0 dòng, bài hằng số vẫn qua | Đã sửa (khác đề xuất mặc định) | Mọi bảng jelly có khoá chính (`mysql/jelly/01_tao_bang_jelly.sql`) nên không thêm được dòng trùng khoá vào hidden-1. Đổi bảng thứ hai sang `sessions`, kiểm theo khoá nghiệp vụ (`user_id`, `session_start`); DD: `sessions` một dòng mỗi phiên, dữ liệu có trùng thật (57 dòng thừa ở public, 52 ở hidden-1) | Lời nhắn, yêu cầu, ERD, `\luuy`, bẫy, `\ghichuthietke`, solution; wrong `khoa_thieu_cot_ngay` sửa, thêm `khoa_ky_thuat_ma_phien`; bài trả hằng 0 nay rớt; BAN-DO cập nhật bảng, bẫy |
| 3 | 3.1 | jelly-r8 (g1) | Gắn cứng `<= '2026-08-29'` vẫn qua | Đã sửa | QDC 1.10 (mốc thời gian ghi đủ hai cận vì biến thể ẩn có dòng ngoài kỳ); DD: dữ liệu dừng 29/8 | File 04 mục (j): giao dịch GB Booster Bundle 2026-08-30 (`jta_txn_00002664`) + phiên + `player_daily` + `daily_kpi` 30/8 ở `jelly_hidden_1`; wrong `gan_cung_ngay_cuoi` (rớt hidden-1) |
| 4 | 3.1 | jelly-c8 (g4) | ARPDAU tính bằng cent | Đã sửa | Chấp nhận cent: QA chương I "ARPDAU toàn kỳ 0,1199 USD/DAU-ngày … xấp xỉ 12 cent" | Tiêu đề bước 2 thêm "(cent)"; tên cột, yêu cầu đã ghi cent; SQL không đổi |
| 5 | 3.2 | jelly-c9 (g5) | Nguồn đo `purchases` hay cờ `extra_moves_purchased` | Đã sửa (khác đề xuất mặc định "giữ `purchases`") | QA mục 5.2: chỉ số chính của thí nghiệm lấy `level_attempts.extra_moves_purchased` D0–D6 / người được phân nhóm (ITT), không lấy SKU `extra_moves_pack` vì chiều kết quả có thể đảo; mục 5.4: CI95 chứa 0, p = 0,094, chưa đủ kết luận. Số đo: public A 0,0747 / B 0,0838, hidden-1 A 0,0729 / B 0,0826 (cùng chiều) | Bước 2 đổi sang cờ (yêu cầu, cột, gợi ý, solution, wrong "đã tiếp xúc"); thêm wrong `dem_giao_dich_goi_thay_co` (SQL cũ); ERD, hai `\luuy`; 4 phương án viết lại, đúng = "chưa nên áp dụng ngay, nhánh thử chỉ nhỉnh hơn"; BAN-DO cập nhật bảng, bẫy |
| 6 | 3.2 | jelly-c10 (g5) | Phương án nhiễu 1 chỉ sai ở "đóng vụ việc" | Giữ nguyên (sửa lời giải thích) | QA mục 3.7 (phục hồi kỹ thuật chưa phải phục hồi kinh doanh); số đo hai biến thể | Lời giải thích phương án nhiễu 1 nêu ba lý do chưa đóng vụ việc (Android 2.1.1 vẫn thấp hơn 2.0.2 khoảng 4 điểm; iOS đi xuống; 2.1.1 mới nửa tháng, iOS 572 lượt); rút phương án đúng và phương án 3 về ≤ 2 câu; SQL không đổi |
| 7 | 3.2 | jelly-c7 (g4) | Có nhắc iOS 2.1.1 giảm D1 | Giữ nguyên + bổ sung lời giải thích | RM (sự cố chủ yếu Android SEA); QA mục 3.7 | Phương án đúng giữ; lời giải thích phương án C thêm số iOS 2.1.1 (nhóm nhỏ, chỉ theo dõi thêm) |
| 8 | 3.2 | jelly-c4 (g2) | Rào cỡ mẫu ở phương án đúng | Đã sửa (nhẹ) | Giữ rào; K32 đạt vì phương án 1 cũng nói độ ổn định; QA chương II (chênh ROAS theo kênh phải kiểm thêm trước khi chia ngân sách) | Rút phương án đúng cho cân độ dài |
| 9 | 3.3 | jelly-q5 (g3) | Cửa sổ ROAS cho cả bộ | Đã sửa (quy ước) | ROAS Dk = doanh thu D0 tới D(k−1): D7 = D0–D6, D30 = D0–D29, chỉ người cài đủ k ngày. DD "D7 ROI proxy = cohort day 0–6"; QA mục 5.2 "D0–D6 là bảy ngày tuổi đầu"; QA chương II ghi trang 6 dashboard dùng D0–D7 nên đề luôn ghi cửa sổ bằng ngày tuổi | Khái niệm `roas` ở STYLE-jelly E và gói 3; q5 giữ D0–D29 |
| 10 | 3.3 | jelly-k6 (g5) | "lệch thật" hay lệch làm tròn | Giữ nguyên SQL | Lệch lớn nhất 0,00007 USD, chỉ vượt ngưỡng 0,00005 một chút; hai nguồn lưu khác số chữ số thập phân | `\ghichuthietke` gọi là "lệch do cách làm tròn" (đề vốn không có chữ "lệch thật") |
| 11 | 3.3 | jelly-a4 (g2) | Lượt sự cố trong mẫu số tỷ lệ thắng | Giữ nguyên | DD "Win rate = complete attempts / all attempts"; QA mục 3.2 "win rate là số lượt thắng trên mọi lượt thử" | – |
| 12 | 3.3 | jelly-n3 (g1) | Lượt bỏ cuộc, sự cố ghi 0 lượt đi | Giữ nguyên | Dữ liệu ghi `moves_left` = 0 cho quit, crash; đã nêu ở `\luuy` | – (mã đổi, dòng 19) |
| 13 | 3.3 | jelly-n1 (g1) | Ý nghĩa `level_id_if_relevant` | Giữ nguyên | DD chỉ nêu tên cột, không định nghĩa; QA mục 4.2 không nói. Không có nguồn thì `\luuy` không khẳng định | – |
| 14 | 3.3 | jelly-s1 (g2) | Múi giờ `session_start` | Giữ nguyên | DD: `session_start` là tên cũ của `event_time`, không nêu múi giờ; CSV không ghi độ lệch múi giờ | – |
| 15 | 3.3 | jelly-f1 (g4) | Số lượt hay tỷ lệ bỏ cuộc | Giữ nguyên + bổ sung `\luuy` | DD có "Fail+quit rate" để so độ khó; câu hỏi chọn màn cần ưu tiên theo khối lượng | `\luuy` nêu lý do chọn số lượt và cách tính tỷ lệ khi cần so độ khó |
| 16 | 3.3 | jelly-t4 (g4) | Bỏ Organic khỏi đối soát | Giữ nguyên | `campaign_spend.csv` không có dòng Organic; QA chương II: ROAS paid không lấy doanh thu organic | – |
| 17 | 3.4 | jelly-j5 (g3) | Hạ Trung bình → Dễ | Giữ nguyên (chấp nhận) | QDC 2.3 mục 6 | – |
| 18 | 3.4 | jelly-t7, f9 (g4) | Debug lỗi một chỗ ở Trung bình | t7 đã sửa (hạ Dễ); f9 giữ Trung bình | QDC 2.3 mục 7 bản sửa theo quy chuẩn 23:05 (bỏ ngoại lệ "M7, M8 không có Dễ"); HD mục 6: Sửa lỗi Dễ = lỗi một chỗ dễ thấy (`COUNT(*)` thay `COUNT(DISTINCT)`). t7 `UNION`/`UNION ALL` cùng kiểu → Dễ; f9 sai phạm vi cửa sổ là lỗi khó thấy, chấm như aivb-f7 (QDC 2.3 mục 3) | t7: `cap=easy`, ERD 2 bảng có giá trị mẫu, bỏ `users`; BAN-DO cấp và thống kê. f9: `\ghichuthietke` ghi lý do |
| 19 | 3.4 | jelly-f6 (g4) | Ba câu top 3 `ROW_NUMBER` ở M8 | Đã sửa | QDC 2.3 mục 8 | Viết lại bằng `NTILE` (chia 4 nhóm theo tổng chi mỗi thị trường); mã `jelly-f6-nguoi-chi-top-quoc-gia` → `jelly-f6-chia-4-nhom-chi`; 3 wrong mới |
| 20 | 3.6 | jelly-q4 (g3) | Mã lệch nội dung | Đã sửa | Nội dung so với bình quân tháng | `jelly-q4-ngay-dau-cao-nhat` → `jelly-q4-ngay-dau-tren-tb-thang` |
| 21 | 3.6 | jelly-n3, n7 (g1) | Mã "buoc", "null" lệch | Đã sửa | STYLE-jelly A.2 (lượt đi); bẫy n7 là khoảng trắng | `jelly-n3-nhom-buoc-du` → `jelly-n3-nhom-luot-di-du`; `jelly-n7-crash-null` → `jelly-n7-crash-khoang-trang` |
| 22 | 3.6 | jelly-n9 (g1) | `domain=customer` | Đã sửa | STYLE-jelly G (`sales`: người chơi trả tiền) | `domain=sales`; BAN-DO cập nhật |

Mục 3.5 áp vào jelly:

| Mục QDC | Câu | Trạng thái | Đã sửa |
|---|---|---|---|
| 1.1 kết luận case (bản sửa theo quy chuẩn 23:05) | 10 case jelly (c1–c10) | Đã sửa | "Đúng: " ở phương án đúng, bỏ "Chưa đúng. " ở phương án sai, theo 4 case mẫu `quy_chuan/goi-cau-hoi-mau`. c9, c10 đã rút còn 3 phương án như 4 case mẫu (chuẩn hoá 10/11: c9 bỏ phương án "hai nhánh không so được vì tỷ lệ tiếp xúc khác nhau", c10 bỏ phương án "cờ thêm lượt đi là doanh thu"; đúng một `\phuongan*`) |
| 1.2 Case Cơ bản dùng `GROUP BY` | jelly-c1 b1 (g1) | Giữ SQL | `\ghichuthietke` thêm dòng theo QDC 1.2 |
| 1.5 Trùng ô j4/q5 (g3) | jelly-j4 | Đã sửa | `domain` finance → marketing (CPI là chi phí thu hút); BAN-DO cập nhật |
| 1.8 Khái niệm `kenh-thu-hut` | g2 s9, a3, c4 | Đã sửa | Định nghĩa chép vào STYLE-jelly E, giống hệt gói 2 |
