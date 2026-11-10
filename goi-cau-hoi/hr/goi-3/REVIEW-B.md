# REVIEW-B · gói 3 HR Analytics (hr)

Người kiểm B · 10/11/2026 · nhận câu thứ 1, 3, 5, … theo thứ tự trong `cau-hoi.tex`:
j1, j3, j5, j7, j9, q2, q4, q6, q8, c5.

Cách làm:
- Bước 1: tự viết SQL cho 10 câu (cả 2 bước SQL của c5) **trước** khi mở `solution.sql`, chạy trên `hr` và `hr_hidden_1` (user `sql_runner`).
- Bước 2: so với solution theo luật chấm. Kết quả của tôi **trùng từng dòng, từng giá trị** với solution ở cả hai biến thể, cho cả 11 khối.
- Bước 3: chạy bộ kiểm `kiem_tra_goi.py`: `KIEM TRA: 0 loi`. Mọi wrong rớt đúng biến thể ghi trong `\ghichuthietke`; mọi starter debug khác solution.
- Nháp ở `cong-cu/ket-qua/review/hr-goi-3-B/` (khối SQL tách, kết quả, `kiem/bao-cao-import.json`).

Kiểm thêm theo yêu cầu:
- **Hai biến thể cho kết quả khác nhau ở cả 10 câu.** Bài chép kết quả Chạy thử sẽ rớt hidden-1.
  - q6: `tg_bq` hai biến thể đều là 39,3, nhưng `so_yeu_cau_lau` khác (187 và 168), nên vẫn bắt được bài chép.
  - c5.b1: ba loại nghỉ có số khác nhau (378/52/19 và 338/43/17).
- **Làm tròn trung gian:** không câu nào có nguy cơ bị chấm oan vì làm tròn.
  - j5 dùng `saiso=0.5` cho cột làm tròn 0 chữ số, nên nộp bản không làm tròn vẫn qua.
  - q6 so số nguyên `time_to_fill_days` với 39,31. Làm tròn trước thành 39,3 vẫn cho cùng kết quả.
  - Rủi ro chấm oan còn lại nằm ở c5.b2: chưa nói NULL hay 0 (xem bảng).

## Bảng kiểm

| Mã | Phiên bản | Kiểm SQL | Kiểm nội dung | Đề xuất sửa cụ thể (nguyên văn → câu sửa) |
|---|---|---|---|---|
| hr-j1-yeu-cau-theo-bac | v1 | **Đạt**. Tự giải trùng solution (7 bậc, public 120/94/88…, hidden 108/84/83…). Không có hoà ở `so_yeu_cau`. Wrong `thieu_can_tren` rớt hidden-1 (R0801). Wrong `noi_ke_hoach_thieu_nam` rớt cả hai biến thể. | **Cần sửa** (dịch máy, mơ hồ). Cấp Dễ, ERD 2 bảng có chữ trên đường nối, đúng module Joins. Tab Nghiệp vụ không lộ số. | (1) Bối cảnh: "mỗi bậc có bao nhiêu yêu cầu tuyển và tốn bao nhiêu" (đọc thành tổng chi phí, trong khi đề hỏi bình quân) → "mỗi bậc có bao nhiêu yêu cầu tuyển và chi phí bình quân mỗi yêu cầu là bao nhiêu". (2) Yêu cầu: "Tính cho từng bậc của vị trí cần tuyển số yêu cầu và chi phí tuyển dụng bình quân một yêu cầu." (trật tự tiếng Anh; cụm "vị trí cần tuyển số yêu cầu" đọc dính) → "Đếm số yêu cầu và tính chi phí tuyển dụng bình quân mỗi yêu cầu theo bậc của vị trí cần tuyển." |
| hr-j3-tuyen-thay-nguoi-nghi-vi-luong | v1 | **Đạt**. Tự giải trùng solution (public 84 dòng, hidden 72). `saiso=0.001` hợp với `compa_ratio` 3 chữ số. Wrong `noi_theo_vi_tri` rớt cả hai biến thể. | **Cần sửa** (câu mơ hồ, dịch máy, thuật ngữ chưa giải nghĩa). | (1) Bối cảnh: "những chỗ phải tuyển thay vì người cũ nghỉ do lương" (đọc thành "thay vì" = *instead of*) → "những chỗ phải tuyển người thay thế vì người cũ nghỉ do lương". (2) Yêu cầu: "Giữ yêu cầu tuyển thay người đã nghỉ việc với lý do lương" → "Giữ các yêu cầu tuyển thay thế cho người nghỉ việc vì lý do lương". (3) "Lấy bậc và compa-ratio của người nghỉ": câu này không có `\khainiem{compa-ratio}`, nên phải giải nghĩa ở lần đầu (STYLE A) → "Lấy bậc và compa-ratio (tỷ số lương trên mức thị trường) của người nghỉ ở tháng nghỉ việc." |
| hr-j5-luong-duoi-thi-truong | v1 | **Đạt**. Tự giải trùng solution (6 nước, Vietnam 204/651…). Wrong `noi_thieu_nam` và `dung_compa_ratio` (16 dòng tháng 12/2025 lệch giữa hai cách lọc) rớt cả hai biến thể. ERD: đường nối nhiễu `employee_monthly_snapshot.country → positions.country` ghi `kieu=n-1`, thực tế là n-n (nên bỏ nét nối, hoặc nối theo `position_id`). | **Cần sửa** (lỗi nặng: mâu thuẫn có thể gây chấm oan; tiêu đề lệch kết quả; lệch thuật ngữ). Tab Nghiệp vụ gọi `\khainiem{compa-ratio}`, mà thẻ này ghi "có sẵn ở `compa_ratio`; **câu hỏi dùng cột này**". Học viên làm theo thẻ sẽ lọc `compa_ratio < 0.8`, đúng như wrong `dung_compa_ratio`. Ngoài ra lưu ý viết "cột compa-ratio đã làm tròn" là sai sự thật: theo README-hr, tiền lương mới là số làm tròn sau khi tính compa-ratio. | (1) Bỏ `\khainiem{compa-ratio}` khỏi câu này, hoặc sửa lưu ý: "Thang lương thị trường có một dòng cho mỗi năm. Ngưỡng 0,8 lần P50 so trực tiếp tiền lương với P50, không dùng cột compa-ratio đã làm tròn." → "Mức lương thị trường có một dòng cho mỗi năm, nước, chức danh và bậc. Câu này so trực tiếp tiền lương tháng với 0,8 lần P50, không dùng cột `compa_ratio`, vì tiền lương đã được làm tròn sau khi tính cột này." ("Thang lương" là thang lương nội bộ theo BLLĐ Điều 93, không dùng cho mức lương thị trường.) (2) Tiêu đề: "Ai nhận lương thấp hơn thị trường quá 20%?" (kết quả là số người theo nước, không phải danh sách người) → "Nước nào có nhiều người nhận lương dưới 80\% thị trường?" (3) Bối cảnh: "và thiếu bình quân bao nhiêu" → "và bình quân mỗi người thấp hơn thị trường bao nhiêu". (4) Yêu cầu: "Tính cho từng nước số người và khoảng thiếu bình quân (P50 trừ tiền lương tháng)." → "Theo từng nước, đếm số người và tính mức chênh lệch bình quân (P50 trừ tiền lương tháng)." |
| hr-j7-phieu-khao-sat-gap-ba | v1 | **Đạt**. Tự giải trùng solution (public tổng 3.186 phiếu bằng số phiếu quý 4). Starter `COUNT(*)` ra 9.325 dòng, gấp 2,93 lần, đúng triệu chứng "gần gấp ba". Wrong `chi_noi_thang_12` rớt cả hai biến thể. | **Đạt**. Debug Dễ đúng thang độ khó (`COUNT(*)` thay vì `COUNT(DISTINCT)`), có đường nối cảnh báo. Vai thực tập sinh xưng "em" với "anh chị" đúng. Không thấy giọng AI hay dịch máy. | — |
| hr-j9-trang-thai-quan-ly | v1 | **Đạt**. Tự giải trùng solution (public 28/2.446/639; hidden 25/1.950/818). Starter INNER JOIN chỉ ra một nhóm, đúng chỗ đề muốn. Wrong `left_join_thieu_cung_thang` rớt cả hai biến thể. | **Cần sửa** (tiêu đề mơ hồ). Gợi ý 2 gần như đưa luôn lời sửa; với cấp Trung bình chấp nhận được. | Tiêu đề: "Đếm nhân viên theo tình trạng quản lý bị hụt" ("quản lý bị hụt" đọc thành tình trạng của người quản lý) → "Phân loại nhân viên theo quản lý trực tiếp ra thiếu người". |
| hr-q2-tuyen-khi-het-cho-trong | v1 | **Đạt**. Tự giải trùng solution (6 nước, Indonesia 39/81…). Wrong `ke_hoach_moi_nam` rớt cả hai biến thể. Wrong `thieu_can_tren` rớt hidden-1 (bộ kiểm xác nhận). Nên bỏ chữ "nếu" trong `\ghichuthietke`: "chỉ rớt ở hidden-1 nếu vị trí của R0801…" → "rớt ở hidden-1 (vị trí của R0801 thuộc danh sách)". | **Cần sửa · CẦN NGƯỜI NẮM DOMAIN**. (a) Bối cảnh khẳng định sai dữ liệu: "Cuối năm các vị trí đều đủ người theo kế hoạch", nhưng năm 2025 chỉ 80/422 vị trí có `vacancy_count = 0`. (b) Tiền đề nghiệp vụ yếu: 260/317 yêu cầu trong kết quả là tuyển thay thế (Backfill). Chỗ trống bằng 0 ở tháng 12 rất có thể là kết quả của chính các yêu cầu tuyển thay thế trong năm, nên "vẫn tuyển dù kế hoạch không còn chỗ trống" không chứng tỏ quy trình duyệt sai. (c) Tiêu đề lệch kết quả. (d) `dang=A1` (tra cứu lọc), trong khi kết quả gom theo nước; A3 hợp hơn. | (1) Tiêu đề: "Vị trí nào vẫn tuyển dù kế hoạch không còn chỗ trống?" → "Mỗi nước duyệt bao nhiêu yêu cầu tuyển cho vị trí đã đủ người?" (2) Bối cảnh: "Cuối năm các vị trí đều đủ người theo kế hoạch, nhưng anh thấy trong năm vẫn duyệt nhiều yêu cầu tuyển." → "Nhiều vị trí cuối năm đã đủ người theo kế hoạch, nhưng trong năm vẫn có yêu cầu tuyển được duyệt." Người nắm domain cần quyết định có tách hay loại yêu cầu `'Backfill'` không. (3) Yêu cầu: "Tính cho từng nước số vị trí khác nhau và số yêu cầu." → "Theo từng nước, đếm số vị trí khác nhau và số yêu cầu." |
| hr-q4-nghi-du-dinh-o-lai-cao | v1 | **Đạt**. Tự giải trùng solution (public 10 dòng, hidden 6). Hai wrong rớt cả hai biến thể. Ghi chú cho tác giả: mọi người nghỉ tự nguyện năm 2025 đều có phiếu đúng quý nghỉ (0 người thiếu). Vì vậy "quý lớn nhất không sau quý nghỉ" luôn bằng chính quý nghỉ, và nối thẳng theo quý nghỉ cũng ra đúng kết quả. Không gây chấm oan, nhưng truy vấn con tương quan không bắt buộc. | **Cần sửa · CẦN NGƯỜI NẮM DOMAIN**. (a) Bối cảnh nói "lần khảo sát gần nhất **trước đó**", trong khi phiếu cùng quý có thể làm sau ngày nghỉ. Cần người nắm domain xác nhận phiếu cùng quý có được coi là "trước khi nghỉ" không. (b) Dịch máy. (c) `intent_to_stay` chưa giải nghĩa. (d) Bối cảnh khoảng 37 tiếng, quá mức 35. | (1) Yêu cầu: "Lấy phiếu khảo sát của từng người có quý lớn nhất nhưng không sau quý của tháng nghỉ (tháng 5/2025 thuộc quý '2025-Q2')." → "Với mỗi người, lấy phiếu khảo sát gần nhất tính tới hết quý có tháng nghỉ (người nghỉ tháng 5/2025 xét tới quý '2025-Q2')." (2) "Giữ người có `intent_to_stay` ở phiếu đó từ 4 trở lên." → "Giữ người có điểm ý định ở lại (`intent_to_stay`, thang 1–5) ở phiếu đó từ 4 trở lên." (3) Bối cảnh, câu 2: "Em tìm giúp chị những người nghỉ tự nguyện năm 2025 mà lần khảo sát gần nhất trước đó vẫn chấm ý định ở lại cao." → "Em tìm giúp chị người nghỉ tự nguyện năm 2025 mà phiếu khảo sát gần nhất vẫn chấm ý định ở lại cao." |
| hr-q6-yeu-cau-tuyen-lau | v1 | **Đạt**. Tự giải trùng solution (public 187 / 39,3; hidden 168 / 39,3). Wrong `bq_ca_hai_nam` chỉ rớt public, đúng như ghi chú thiết kế. Thiếu cận trên không đổi kết quả, như ghi chú thiết kế đã nêu. | **Cần sửa** (đại từ "nó" chỉ vật). Cấp Dễ, ERD 2 bảng có giá trị mẫu, đúng module (truy vấn con vô hướng). | (1) Gợi ý: "Mức bình quân là một con số duy nhất. Có thể đặt nó ngay trong điều kiện lọc không?" → "Mức bình quân là một con số duy nhất. Có thể đặt con số này ngay trong điều kiện lọc không?" (2) Tuỳ chọn: tên cột `tg_bq` viết tắt khó đoán → `so_ngay_tuyen_bq` (tên STYLE A nêu làm ví dụ). |
| hr-q8-tren-bq-bac-sai-thang | v1 | **Đạt**. Tự giải trùng solution (public 158 dòng, hidden 144). Starter thiếu điều kiện tháng, đúng chỗ đề muốn. Wrong `thieu_tuong_quan_phong` rớt cả hai biến thể. ERD: nét nối nhiễu `positions.country → country_market_benchmark.country` ghi `kieu=n-1`, thực tế là n-n. | **Cần sửa** (triệu chứng trong bối cảnh không khớp dữ liệu; tiêu đề lệch yêu cầu). Starter thêm 9 người so với solution. Chỉ 1 trong 9 người nhận đúng mức bình quân tháng 12 của nhóm (nhóm 1 người); 8 người còn lại nhận **thấp hơn** mức bình quân. Ghi chú thêm: lỗi chỉ ở một điều kiện, nên câu hơi nhẹ so với debug Trung bình. | (1) Bối cảnh: "Danh sách em gửi có cả người đang nhận đúng mức bình quân của nhóm." → "Danh sách em gửi có cả người đang nhận thấp hơn mức bình quân của nhóm trong tháng 12." (2) Tiêu đề: "Danh sách lương trên bình quân bậc bị sai" → "Danh sách lương trên bình quân phòng ban, bậc bị thừa người". (3) Lưu ý: "Mỗi nhân viên có tới 24 dòng lương." → "Mỗi nhân viên có tới 24 dòng tháng, mỗi dòng một mức lương." |
| hr-c5-tuyen-thay-the-kip-khong | v1 | **Cần sửa** (nhẹ, rủi ro chấm oan). b1, b2 tự giải trùng solution ở cả hai biến thể. Wrong `inner_join` của b2 rớt cả hai biến thể. Rủi ro: nhóm Retirement không có yêu cầu. Solution trả `so_di_lam_sau_2025 = 0` (`COUNT(CASE…)`) và `so_ngay_bq = NULL`. Học viên viết theo lối MySQL quen thuộc `SUM(r.start_date >= '2026-01-01')` sẽ ra NULL, nên bị chấm sai. Học viên dùng `IFNULL(…, 0)` cho `so_ngay_bq` cũng bị chấm sai. | **Cần sửa** (sai nghĩa ở tiêu đề và bối cảnh). Ba bước, tổng 8+6+6 = 20, đúng case Dễ. Phương án đúng khớp số public (100% / 0%, 51,7 và 49,7 ngày). Lưu ý cho tác giả: ở hidden-1, biến thể (a) bỏ yêu cầu theo `requisition_id` nhưng giữ người nghỉ, nên Voluntary chỉ còn 304/338 có yêu cầu (89,94%). Trên dữ liệu ẩn, phương án 3 lại thành đúng. Bước kết luận không chấm theo dữ liệu nên không chấm oan, nhưng nên biết. | (1) b2, yêu cầu, thêm: "Nhóm không có yêu cầu thì `so_ngay_bq` để trống (NULL) và `so_di_lam_sau_2025` bằng 0." (2) Tiêu đề: "Người nghỉ có được tuyển thay thế kịp không?" (người nghỉ không phải người "được tuyển") → "Chỗ của người nghỉ có được tuyển người thay kịp không?" (3) Bối cảnh: "Em kiểm tra giúp chị năm 2025 người nghỉ có được tuyển thay thế không và bao lâu thì có người mới đi làm." → "Em kiểm tra giúp chị năm 2025 chỗ của người nghỉ có được tuyển người thay không, và bao lâu thì người mới đi làm." |

**Tổng: 1 câu Đạt (j7) / 9 câu Cần sửa.**
- Kiểm SQL: 9 Đạt, 1 Cần sửa (c5, nhẹ).
- Kiểm nội dung: 1 Đạt, 9 Cần sửa; trong đó q2 và q4 cần thêm người nắm domain.
- Không có solution sai. Không có wrong nào không rớt. Tab Nghiệp vụ không lộ kết quả.

Lỗi nặng xếp trước:
1. **j5:** thẻ khái niệm compa-ratio bảo dùng cột `compa_ratio`, trong khi wrong lại phạt đúng cách này. Lưu ý còn giải thích sai lý do lệch.
2. **c5.b2:** chưa ghi rõ NULL hay 0 cho nhóm nghỉ hưu, có thể chấm oan bài dùng `SUM(điều kiện)`.
3. **q2:** bối cảnh khẳng định sai dữ liệu, tiền đề nghiệp vụ yếu (83% là tuyển thay thế).
4. **q8:** triệu chứng trong bối cảnh không khớp dữ liệu.

## Giọng văn

Đếm trên 10 câu được giao:

- **Giọng AI: 0 chỗ.** Không có câu khẩu hiệu, ẩn dụ, từ đệm sáo rỗng hay dấu "—".
- **Dịch máy: 7 chỗ.**
  - j1 "Tính cho từng bậc của vị trí cần tuyển số yêu cầu…"
  - j3 "với lý do lương"
  - j5 "Tính cho từng nước số người và khoảng thiếu bình quân"
  - q2 "Tính cho từng nước số vị trí khác nhau và số yêu cầu"
  - q4 "phiếu khảo sát của từng người có quý lớn nhất nhưng không sau quý của tháng nghỉ"
  - q6 "đặt nó ngay trong điều kiện lọc"
  - q8 "24 dòng lương"
- **Lệch thuật ngữ, câu mơ hồ: 8 chỗ.**
  - j5 "Thang lương thị trường" (thang lương là khái niệm nội bộ theo BLLĐ Điều 93)
  - j5 "khoảng thiếu"
  - j3 compa-ratio chưa giải nghĩa
  - q4 `intent_to_stay` chưa giải nghĩa
  - j3 "tuyển thay vì người cũ nghỉ" (đọc thành "thay vì")
  - j9 "quản lý bị hụt"
  - c5 "người nghỉ có được tuyển thay thế"
  - j1 "tốn bao nhiêu"
- **Tiêu đề lệch dạng kết quả: 3 câu.** j5 và q2 hỏi "Ai…" hoặc "Vị trí nào…" nhưng trả số đếm theo nước; tiêu đề q8 bỏ mất "phòng ban".

Khuôn lặp trên nhiều câu của gói:
1. **"Tính cho từng <nhóm> <chỉ số>…"**, trật tự tiếng Anh *compute for each X the Y*: 6 lần trong gói (j1, j5, j6, q2, q5, c6.b3). Nên đổi luân phiên thành "Theo từng nước, đếm…" hoặc "Đếm … theo nước".
2. **"Em <động từ> giúp anh/chị …"** ở 13/20 lời nhắn. Lời nói tự nhiên, nhưng lặp đều thành khuôn; nên đổi vài câu ("Em xem…", "Gửi chị trước thứ Sáu…").
3. **Yêu cầu nào cũng mở bằng "Xét …"** (20 lần). Không sai, nhưng đơn điệu.
