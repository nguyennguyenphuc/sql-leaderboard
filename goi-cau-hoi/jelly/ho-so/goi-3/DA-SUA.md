# Đã sửa · gói 3 bộ GAME Jelly Trail Academy (`jelly`) · v2

Sửa theo `REVIEW-B.md` và `REVIEW-C.md` (10/11/2026). Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/jelly-goi-3/`: chứa 7 câu đã sửa SQL hoặc yêu cầu (j4, j8, q2, q5, q8, q9, c6). Chạy thật bộ kiểm trên public và hidden-1; kết quả ở `jelly-goi-3-kq2/`.
- **Cả gói**, kiểm tĩnh (`--chi-phan-tich`): `KIEM TRA: 0 loi`.
- **Biên dịch:** 0 lỗi LaTeX; PDF ở `cong-cu/ket-qua/bien-dich/jelly-goi-3/`.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| jelly-j1-luot-choi-kem-the-gioi | (B) Đổi người hỏi sang Kỹ sư QA kiểm dữ liệu ngày cuối; đổi dòng quyết định của tab Nghiệp vụ; bỏ `\khainiem{ty-le-thang-man}`; "kỳ báo cáo" thành "cửa sổ dữ liệu" | tĩnh |
| jelly-j2-doanh-thu-theo-kenh-cai | (C) Đổi dòng quyết định thành báo cáo doanh thu IAP theo kênh, không còn chọn kênh tăng ngân sách; lời nhắn hỏi đủ số người mua và số tiền; yêu cầu viết lại thành "Tính … của từng kênh", bỏ "theo tab Nghiệp vụ" | tĩnh |
| jelly-j3-nguoi-chua-mua | (B) Ghi chú thiết kế: "điều kiện lọc bảng giao dịch (bảng bên phải) đặt trong ON"; sửa câu sai về hidden-1 (giao dịch 2026-09-01 không đổi số người chưa mua); lời nhắn "chiếm bao nhiêu phần trăm số người chơi" | tĩnh |
| jelly-j4-cpi-theo-kenh | (C) Wrong `noi_truc_tiep_nhan_dong` bỏ hằng số gõ tay, dùng đúng `CROSS JOIN` của solution, chỉ còn lỗi nhân dòng; ERD đổi nối chi phí–người chơi thành `n-n`, có chữ và tô cảnh báo; giải nghĩa CPI; "từng nhóm" thành "từng cặp kênh, nền tảng"; "đắt hay rẻ hơn"; "mỗi người chơi khớp với bao nhiêu dòng"; đổi dòng quyết định | bộ kiểm (gói tạm) |
| jelly-j5-booster-theo-the-gioi | (B) Tiêu đề "Loại vật phẩm hỗ trợ nào…"; hạ cấp xuống `easy`, ERD còn 2 bảng có chữ trên đường nối; "kỳ dữ liệu" thành "cửa sổ dữ liệu". SQL không đổi | tĩnh |
| jelly-j6-phien-co-mua | (C) Viết lại lời nhắn; thống nhất "nút cửa hàng"; viết lại yêu cầu thành "Tính … của từng màn hình vào game"; đổi dòng quyết định | tĩnh |
| jelly-j7-join-nhan-dong | (B) ERD thêm bảng `users` (nơi lấy kênh) và đường nối; "Organic" thành "kênh tự nhiên (`'Organic'`)"; đổi câu kết lời nhắn | tĩnh |
| jelly-j8-left-join-where | (C) Tab Nghiệp vụ đổi thành "chưa tới bước cuối", khớp với chỉ số đếm; `\luuy` bỏ cách sửa, thay bằng quy ước "người bỏ dở bước 5 vẫn tính là đã tới bước 5"; bỏ chữ sáo "kinh điển"; thay wrong `or_is_null_trong_where` (trùng kết quả starter) bằng `nhom_theo_nen_tang_bang_phai`; đổi câu kết lời nhắn | bộ kiểm (gói tạm) |
| jelly-j9-noi-sai-khoa | (B) "dựng lại lỗi" thành "tái hiện lỗi"; bỏ "chứa nó"; sửa luôn khái niệm dùng chung `phien-choi`; dòng quyết định "Lập danh sách…" | tĩnh |
| jelly-q1-man-thua-tren-tb | (C) Tiêu đề "Màn nào có tỷ lệ thua cao hơn mức chung của game?"; gợi ý bỏ "nó"; định nghĩa tỷ lệ thua viết thành câu, không dùng dấu hai chấm; đổi dòng quyết định | tĩnh |
| jelly-q2-nguoi-mua-season-pass | (B) Thay wrong `quoc_gia_noi_mua` (lọc nền tảng tự đặt) bằng `quen_dieu_kien_goi`, tức truy vấn con thiếu điều kiện gói; viết "thị trường (quốc gia, `users.country`)"; sửa ghi chú thiết kế và dòng quyết định | bộ kiểm (gói tạm) |
| jelly-q3-chua-qua-buoc-4 | (C) Tiêu đề "Bao nhiêu người chơi mới dừng ở bước dùng búa kẹo mút?"; "booster" thành "vật phẩm hỗ trợ"; "búa kẹo mút" khớp với `step_name`; bỏ "theo tab Nghiệp vụ"; gợi ý bỏ khuôn "với mỗi dòng"; viết lại yêu cầu thành "Tính … của từng nền tảng" | tĩnh |
| jelly-q4-ngay-dau-tren-tb-thang | (B) Đổi lý do sang "lượng người chơi tăng đều hay dồn về cuối tháng" và sửa dòng quyết định cho khớp; giải nghĩa DAU; bỏ `thieu-can-tren` khỏi `bay` và khỏi gợi ý 2; ghi chú thiết kế nói rõ ngày 2026-09-01 không đổi kết quả. Giữ nguyên mã | tĩnh |
| jelly-q5-roas-tren-chuan | (C) Cửa sổ doanh thu đổi sang D0--D29 (`cohort_day` từ 0 tới 29), không còn mâu thuẫn với c6; tiêu đề bỏ "hoàn vốn"; giải nghĩa ROAS; thêm quy tắc khi bằng nhau; ERD đổi thành `n-n`; wrong `ghep_hai_muc_hat` bỏ hằng 6.46, ROAS chung tính bằng truy vấn con, chỉ còn lỗi nhân dòng theo chiến dịch; wrong trung bình tỷ lệ viết gọn bằng `AVG() OVER ()` | bộ kiểm (gói tạm) |
| jelly-q6-phien-ban-dau-tien | (B) Lời nhắn và dòng quyết định nói rõ có tính cả người cài mới (cách 2 review đề xuất); gợi ý 1 bỏ khuôn "Với mỗi". SQL không đổi | tĩnh |
| jelly-q7-exists-quang-cao | (C) Tiêu đề "Đếm người xem quảng cáo có tặng thưởng lại ra số người không xem"; viết lại lời nhắn (bỏ lặp "có", thêm chủ ngữ, đổi câu kết) | tĩnh |
| jelly-q8-subquery-nhieu-dong | (B) Yêu cầu "còn đúng một dòng, là giao dịch…"; truy vấn con của solution giữ thêm `p2.country = 'VN'` cho khớp starter và gợi ý 2; đổi dòng quyết định | bộ kiểm (gói tạm) |
| jelly-q9-not-in-null | (C) Thêm cột `so_luot_choi` (lượt chơi tới hết 29/8). Hai biến thể giờ cho kết quả khác nhau; `level_attempts` có vai trò thật. Tiêu đề, yêu cầu, ERD, starter, solution, hai wrong cũ đều sửa theo; thêm wrong `thieu_can_tren` (rớt ở hidden-1) | bộ kiểm (gói tạm) |
| jelly-c5-starter-pack-giu-chan | (B) `\luuy` bỏ khuôn dạy đời; phương án đúng dùng "bình quân mua sau gần hai tuần"; lời giải thích thay câu cụt "nên đây là tương quan"; tách yêu cầu b2 thành hai `\item`; ghi chú thiết kế ghi dòng 2026-09-01 không đổi kết quả. SQL đã sửa ở v1 (wrong b1) | tĩnh |
| jelly-c6-kenh-dang-cat | (C) Wrong b2 đổi thành `mau_so_nguoi_co_doanh_thu`: giữ D0--D6, mẫu số là người có doanh thu, khớp tên lỗi; b2 nêu rõ mẫu số là số lượt cài; b3 giải nghĩa ROAS D7 và bỏ dấu hai chấm; sửa lời giải thích hai phương án; ERD đổi thành `n-n`; "Organic" thành "kênh tự nhiên" | bộ kiểm (gói tạm) |

Chung cho cả gói:
- Dòng quyết định của tab Nghiệp vụ không còn mở bằng "Chọn …".
- Câu kết lời nhắn của thực tập sinh đổi theo từng tình huống.
- "kỳ báo cáo", "kỳ dữ liệu", "trong kỳ" thống nhất thành "cửa sổ dữ liệu".
- Bỏ "theo tab Nghiệp vụ" ở cuối các mục yêu cầu.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Bẫy thiếu cận trên ở hidden-1 không bắt được ở j3, q4 và c5.b1** (trước ở mục Chờ giảng viên): `mysql/jelly/04_bo_sung_bien_the_jelly.sql` (e) thêm người chơi chưa từng mua `jta_user_001174` có phiên, lượt chơi, giao dịch Starter Pack ngày 1/9/2026 và hoạt động 1–2/9 (`daily_kpi` tháng 9 có hai ngày). Đã chạy trên `jelly_hidden_1` (user `sql_runner`) bản bỏ cận trên: j3 ra 3.276 người iOS chưa mua thay vì 3.277; q4 ra thêm dòng 1/9/2026 (DAU 2 > bình quân 1,5); c5.b1 nhóm mua 432 người thay vì 431. Cả ba nay rớt ở hidden-1; ghi chú thiết kế đã sửa theo.
- **Giao dịch `jta_txn_00002662` (Booster Bundle) có `level_id_if_relevant` rỗng** (trước ở mục Chờ giảng viên): (d) của file 04 gắn màn 58, khớp quy luật public (mọi Booster Bundle đều gắn màn).

## Chờ giảng viên (đã quyết hết ở mục "Quyết định v3 (10/11)" bên dưới)

1. **q5, cửa sổ doanh thu cho ROAS:** đã đổi sang D0--D29 theo đề xuất của C. C ghi mục này là "CẦN NGƯỜI NẮM DOMAIN", nên cần giảng viên chốt cửa sổ chuẩn (D7 hay D30) cho cả bộ.
2. **Mã `jelly-q4-ngay-dau-cao-nhat` không còn khớp nội dung** (câu đã đổi sang so với bình quân tháng). Giữ mã theo quy tắc; đổi mã `jelly-q4-ngay-dau-cao-nhat` thành `jelly-q4-ngay-dau-tren-tb-thang` hay không là quyết định của giảng viên.
3. **j5 đã hạ từ Trung bình xuống Dễ**, lệch với bản đồ 100 câu. Module 5 vẫn có 5 câu Trung bình. Cần cập nhật `BAN-DO-100-CAU.md` (ngoài thư mục gói).

## Quyết định v3 (10/11)

Căn cứ domain: `Project DA\Game\Jelly_Trail_Academy_v2\docs\data_dictionary.md` (DD), `JELLY_TRAIL_ACADEMY_BUSINESS_ANALYTICS_V2_QA_FINAL.docx` (QA); `QUYET-DINH-CHUNG.md` (QDC).

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| jelly-q5 | Cửa sổ doanh thu ROAS cho cả bộ | Chốt "ROAS Dk = doanh thu D0 tới D(k−1)": D7 = D0–D6, D30 = D0–D29; chỉ xét người cài đủ k ngày quan sát. q5 giữ D0–D29 (SQL không đổi) | DD "D7 ROI proxy = net revenue cohort day 0–6 / spend − 1"; QA mục 5.2 "D0–D6 bao gồm bảy ngày tuổi đầu tiên"; QA chương II, bảng sáu khái niệm hoàn vốn: trang 6 dashboard tính ROAS D7 bằng D0–D7, lệch quy ước nên đề luôn ghi cửa sổ bằng số ngày tuổi | Khái niệm `roas` (gói 3 và STYLE-jelly E) ghi chuẩn cửa sổ |
| jelly-q4 | Mã lệch nội dung | Đổi mã | Nội dung so với bình quân tháng | `jelly-q4-ngay-dau-cao-nhat` → `jelly-q4-ngay-dau-tren-tb-thang` ở cau-hoi.tex, solution.sql, BANG-PHAN-CONG, DA-SUA, BAN-DO; `\ghichuthietke` cập nhật |
| jelly-j5 | Đã hạ Trung bình → Dễ | Chấp nhận | QDC 2.3 mục 6 | Không đổi (bản đồ v2 đã cập nhật) |
| jelly-j4/q5 | Trùng ô C3 · finance · Trung bình · write | Đổi mảng j4 sang `marketing`, giữ q5 | QDC 1.5; STYLE-jelly G (`marketing`: thu hút người chơi, CPI là chi phí thu hút) | Khoá `domain` của j4, `\ghichuthietke`; BAN-DO (dòng j4, bảng C3: marketing 1→2, finance 2→1, tổng mảng) |

### Theo quy chuẩn (QUYET-DINH-CHUNG mục 0.1, sửa 23:05)

- Kết luận case: phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. " (theo 4 case mẫu `quy_chuan/goi-cau-hoi-mau`). Đổi máy, chỉ ở lời giải thích, không đổi nội dung phương án.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`, `quy_chuan/lo-trinh-sql/assets/js/data.js` (M5, M6 mỗi module có bài Cơ bản, Dễ, Trung bình, Khó) và QUYET-DINH-CHUNG mục 2. Mục tiêu mỗi module: 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug.

| Module | Trước (Cơ bản · Dễ · TB · Khó) | Sau |
|---|---|---|
| M5 Joins | 0 · 4 · 5 · 0 | 2 · 3 · 2 · 2 (write 6, debug 3) |
| M6 Subqueries | 0 · 3 · 6 · 0 | 2 · 3 · 2 · 2 (write 6, debug 3) |

Tám câu đổi cấp (số câu tối thiểu: M5 thừa 1 Dễ và 3 Trung bình, M6 thừa 4 Trung bình). Case c5, c6 giữ nguyên.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · tầng · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `jelly-j1-luot-choi-kem-the-gioi` (giữ) | Dễ → Cơ bản | Lọc đúng ngày 29/8 (bản cũ: “trong cửa sổ dữ liệu”, phải tự đặt cận trên); ERD 2 bảng có giá trị mẫu và điều kiện nối trên đường nối; gợi ý nêu bảng nối và cách sắp; wrong thiếu cận trên thành wrong quên lọc ngày | 2 (Joins cần tối thiểu 2, như data.js `j1-don-kem-vung`) · 1 tầng · đề ghi rõ cột, giá trị lọc · 0 bẫy · 1 khái niệm → Cơ bản 4/5 |
| `jelly-j3-nguoi-chua-mua` → `jelly-j3-di-sau-chua-tra-tien` | Trung bình → Khó | Viết lại: người chơi đã tới thế giới thứ ba mà chưa trả tiền, theo kênh, kèm tổng doanh thu quảng cáo của nhóm này; ERD 6 bảng chỉ khoá, 1 bảng nhiễu, `\erdkhoa`; 3 wrong (nối thẳng nhân dòng, điều kiện ngày ở WHERE, thiếu cận trên giao dịch) | 4 bảng · 4 tầng (3 bảng dẫn xuất, ghép giữ dòng, gom) · ngôn ngữ kinh doanh · 3 bẫy, bẫy thiếu cận trên chỉ lộ ở hidden-1 (`jta_user_001174` mua ngày 1/9) · chỉ số nhiều điều kiện → Khó 5/5 |
| `jelly-j4-cpi-theo-kenh` → `jelly-j4-cpi-thang-8-so-muc-chung` | Trung bình → Khó | Đổi sang tháng 8 chưa trọn; mẫu số CPI chung chỉ lượt cài trả phí; quy tắc nền tảng chuyển sang tab Nghiệp vụ; ERD 5 bảng chỉ khoá (lời giải 2 bảng + 3 bảng nhiễu, QDC 1.3), `\erdkhoa`; sắp theo kênh, nền tảng (ở hidden-1 hai cặp bằng nhau sau làm tròn); 4 wrong | 2 bảng (Khó không bắt buộc ≥ 3) · 4 tầng · ngôn ngữ kinh doanh · 4 bẫy (nhân dòng, trung bình các CPI, gộp người chơi tự nhiên vào mẫu số, thiếu cận trên chi phí chỉ lộ ở hidden-1) · nhiều điều kiện → Khó 4/5 |
| `jelly-j9-noi-sai-khoa` (giữ) | Trung bình → Cơ bản | ERD còn 2 bảng (bỏ bảng nhiễu `users`), cùng một mã phiên làm giá trị mẫu ở hai bảng, điều kiện nối ghi trên đường nối; yêu cầu nói rõ mỗi lượt chơi thuộc đúng một phiên ghi ở `session_id`; bỏ khái niệm `ty-le-su-co`. SQL không đổi | 2 bảng · 1 tầng · đề ghi rõ cột khoá · lỗi một chỗ dễ thấy, 0 bẫy · 1 khái niệm → Cơ bản 4/5 |
| `jelly-q3-chua-qua-buoc-4` → `jelly-q3-choi-d0-tren-tb-29-8` | Trung bình → Cơ bản | Viết lại theo data.js `q1-tren-gia-trung-binh`: người cài 29/8 có thời gian chơi ngày đầu trên mức bình quân của nhóm, 1 bảng `player_daily`, truy vấn con một giá trị; ERD 1 bảng có giá trị mẫu. (Bài cũ dùng NOT EXISTS; ở dữ liệu này “không có dòng bước 5” trùng với “bước 4 bỏ dở”, nên không giữ làm bài Cơ bản cho truy vấn con) | 1 · 1 tầng · đề ghi rõ · 0 bẫy · 1 khái niệm → Cơ bản 5/5 |
| `jelly-q5-roas-tren-chuan` → `jelly-q5-roas-duoi-muc-chung` | Trung bình → Khó | Thêm bước lọc chiến dịch dưới mức chung và cột chênh lệch (điểm phần trăm); đề chỉ nêu ROAS D30, cửa sổ D0–D29 lấy từ khái niệm `roas`; ERD 5 bảng chỉ khoá, 2 bảng nhiễu, `\erdkhoa`; 4 wrong | 3 bảng · 5 tầng · ngôn ngữ kinh doanh · 4 bẫy (nhân dòng, trung bình bốn ROAS, doanh thu cả kỳ, gộp doanh thu người chơi tự nhiên) · nhiều điều kiện → Khó 4/5 (chưa có bẫy chỉ lộ ở hidden-1) |
| `jelly-q6-phien-ban-dau-tien` → `jelly-q6-nguoi-choi-cu-len-210` | Trung bình → Khó | Viết lại: tỷ lệ người chơi cũ (cài bản 2.0.2, còn hoạt động từ 30/7) đã lên bản 2.1.0 và số ngày chờ bình quân, theo nền tảng; ERD 5 bảng chỉ khoá (2 bảng + 3 bảng nhiễu); 4 wrong | 2 bảng · 4 tầng (EXISTS, MIN trong bảng dẫn xuất, ghép giữ dòng, gom) · ngôn ngữ kinh doanh · 4 bẫy (người cài mới, người lên thẳng 2.1.1, mẫu số gồm người đã nghỉ, đếm mọi ngày) · nhiều điều kiện → Khó 4/5 (chưa có bẫy chỉ lộ ở hidden-1) |
| `jelly-q8-subquery-nhieu-dong` → `jelly-q8-giao-dich-ngay-gan-nhat-gb` | Trung bình → Cơ bản | Viết lại: giao dịch ở thị trường Anh của ngày gần nhất trong tháng 8; starter dùng `MIN` thay cho `MAX` trong truy vấn con một giá trị (lỗi một chỗ dễ thấy, như mẫu `d1`); ERD 1 bảng có giá trị mẫu. Chọn GB vì ở hidden-1 ngày gần nhất là 30/8, bài gắn cứng 29/8 rớt | 1 · 1 tầng · đề ghi rõ · 0 bẫy (cận trên của tháng là bình thường) · 1 khái niệm → Cơ bản 5/5 |

Không đổi cấp nhưng có sửa: `jelly-q4-ngay-dau-tren-tb-thang` (việc tồn từ kiểm V3): `\ghichuthietke` bỏ mã cũ `ngay-dau-cao-nhat` và câu “quy tắc không đổi mã”, ghi rõ mã đổi ở v3 thành `jelly-q4-ngay-dau-tren-tb-thang`. Mục “Chờ giảng viên” số 2 ở trên sửa lại chuỗi mã cũ → mã mới (trước bị thay thành chính mã mới).

Ô dạng × mảng × cấp × hình thức: không trùng trong gói. Trùng giữa gói (được phép): `jelly-j1` (A1 · operations · basic · write) cùng ô với `jelly-r3-man-sieu-kho`, `jelly-s2-tach-the-gioi`. `jelly-q8` cùng thị trường GB, tháng 8 với `jelly-r8-giao-dich-thang-8-thua` (gói 1) nhưng khác ô (r8 là A1 · sales · easy · debug) và khác kỹ năng.

Kiểm:
- **Bộ kiểm đầy đủ cả gói** (`--ra cong-cu/ket-qua/cap-do/jelly-goi-3`): `KIEM TRA: 0 loi`, 0 cảnh báo; mọi wrong rớt ≥ 1 biến thể (wrong thiếu cận trên của j1, j3, j4, q8 rớt đúng ở hidden-1); kết quả public khác hidden-1 ở cả 8 câu; solution mỗi câu < 1 giây khi máy rảnh.
- **Biên dịch** (`bash cong-cu/bien_dich.sh`, ra `cong-cu/ket-qua/cap-do/jelly-goi-3-bien-dich/`): 0 lỗi LaTeX, 0 ký tự thiếu, 54 trang. Thư mục gói vẫn đúng 4 file.
- **Bản đồ:** `BAN-DO-100-CAU.md` chỉ sửa 8 dòng của gói 3; các bảng thống kê, ô trùng ở cuối file chưa sinh lại (agent khác đang sửa song song), còn ghi mã cũ của q3, q5.

## Sửa theo KIEM-V4 (11/11/2026)

Căn cứ: `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`. Không đổi cấp, không đổi mã câu nào. Trùng ô giữa các gói được phép (đính chính của người điều phối 11/11), nên không đổi mảng, dạng của câu nào; trong gói không có ô trùng.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| `jelly-j1-luot-choi-kem-the-gioi` | B A.5: lệch thuật ngữ "xác suất thua thiết kế" | Tiêu đề → "Lượt chơi cuối ngày 29/8 kèm xác suất thua theo thiết kế". Ô trùng A1 · operations · basic · write với s2 (gói 2) là trùng giữa các gói, được phép, khác chủ đề: giữ. | Chỉ sửa chữ |
| `jelly-q5-roas-duoi-muc-chung` | B mục B: đủ Khó nhưng chưa có bẫy chỉ lộ ở hidden-1; đề xuất cột doanh thu luỹ kế dùng biến thể (e) | Áp đề xuất: thêm cột `doanh_thu_luy_ke_usd` (doanh thu từ ngày cài tới ngày mới nhất có trong dữ liệu, không giới hạn 30 ngày) sau `kenh`; lời giải thêm bảng dẫn xuất luỹ kế không cận trên; `\luuy` phân biệt ROAS D30 (cửa sổ cố định) với luỹ kế (tăng theo ngày mới); wrong mới `luy_ke_gan_cung_29_8` khớp public (Social Ads 1.376,53), rớt hidden-1 (1.202,81 so với 1.203,30). Bốn wrong cũ thêm cùng cột. Nay 5 bẫy, đủ 5/5 trục. | Bộ kiểm cả gói: q5 0 lỗi; 4 wrong cũ rớt public + hidden-1, wrong mới rớt hidden-1; lời giải dưới 1,1 giây |
| `jelly-q6-nguoi-choi-cu-len-210` | C: 2/5 trục Khó, chưa có bẫy chỉ lộ ở hidden-1; nấc gợi ý 2 quá dài | Áp đề xuất của C: thêm cột `so_len_truoc_su_kien` (số người chơi cũ lên bản trước ngày bắt đầu của sự kiện LiveOps đầu tiên từ ngày phát hành 2.1.0); bối cảnh thêm lý do (gắn lời nhắc cập nhật vào sự kiện); ba định nghĩa chuyển từ yêu cầu sang `\luuy`; ERD thay bảng nhiễu `tutorial_steps` bằng `liveops_events`, `\erdkhoa` ghi so theo ngày; nấc gợi ý 2 rút còn `MIN(activity_date)` trên ngày có `app_version = '2.1.0'`. Lời giải thêm `CROSS JOIN` lấy `MIN(start_date)` từ 30/7; wrong mới `gan_cung_ngay_su_kien` (`< '2026-08-08'`). Số: public Android 2.200, iOS 921 (sự kiện 8/8); hidden-1 598, 237 (`LIVE_004` 31/7); wrong mới ra 1.996, 829 ở hidden-1. Nay 5/5 trục Khó. | Bộ kiểm cả gói: q6 0 lỗi; 4 wrong cũ rớt public + hidden-1, wrong mới rớt hidden-1; lời giải dưới 1,1 giây |

Kiểm:

- Bộ kiểm đầy đủ cả gói: `docker compose run --rm tools python cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/jelly/goi-3 --ra cong-cu/ket-qua/sua-v4/jelly-goi-3 --host sqllb-mysql --port 3306` → 20 câu, 79 khối SQL, `KIEM TRA: 0 loi`, 0 cảnh báo, mọi wrong rớt ít nhất một biến thể, mọi solution ra kết quả public khác hidden-1.
- Biên dịch: `bash cong-cu/bien_dich.sh goi-cau-hoi/jelly/goi-3 <ra>` → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo gói lệnh; PDF ở `cong-cu/ket-qua/sua-v4/jelly-goi-3/bien-dich/`.
- Thư mục gói vẫn đúng 4 file.
