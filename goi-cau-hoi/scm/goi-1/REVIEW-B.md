# REVIEW-B · Supply Chain gói 1 (người kiểm B, câu lẻ)

Ngày kiểm: 10/11/2026. Phạm vi: câu thứ 1, 3, 5, …, 19 trong `cau-hoi.tex` (10 câu). Chỉ đọc gói; nháp SQL ở `cong-cu/ket-qua/review/scm-goi-1-B/`.
Cách kiểm: bước 1 tự viết SQL (file `my_*.sql`) và chạy trên `scm`, `scm_hidden_1` (user `sql_runner`) trước khi mở `solution.sql`; sau đó chạy từng solution, starter, wrong cần đối chiếu (`chk.sql`). Không chạy bộ kiểm cả gói.

## Bảng tổng hợp

| # | Mã | PB | Kiểm SQL | Kiểm nội dung | Đề xuất sửa (tóm tắt, chi tiết ở mục dưới) |
|---:|---|---|---|---|---|
| 1 | `scm-r1-cua-hang-tphcm` | v1 | **Cần sửa.** Lời giải của tôi khớp solution (8 dòng: 24, 26, 28, 29, 30, 32, 34, 51). Hai wrong rớt (9 dòng / 0 dòng). Nhưng `stores` ở hidden-1 giống hệt public, kết quả hai biến thể **trùng nhau**: chép kết quả Chạy thử vẫn qua. | Đạt | Thêm biến đổi cho `stores` trong biến thể ẩn, hoặc chấp nhận có ghi rõ trong `\ghichuthietke` sau khi giảng viên duyệt. |
| 3 | `scm-r3-dong-tra-hang-cua-hang-2-3` | v1 | Đạt. Khớp solution: public 16 dòng, hidden-1 14 dòng (mất 570917, 2010487). Hai wrong rớt public. | Đạt (góp ý nhỏ) | Mục đích ở `\boicanh` và dòng mở tab Nghiệp vụ lệch nhau (xem chi tiết). |
| 5 | `scm-r5-von-ton-cua-hang-51` | v1 | **Cần sửa.** Khớp solution (đầu danh sách 1239986 · 79.998,36; dòng 10 là 2011032, dòng 11 cách xa, không hoà). Hai wrong rớt. Nhưng hai biến thể ra **cùng 10 dòng** (hidden-1 chỉ thêm một dòng kỳ 2017-09 của cửa hàng 1), `\ghichuthietke` cũng tự ghi vậy. | Cần sửa | Tiêu đề thiếu giới từ; `\ghichuthietke` "trạng thái tồn tại". |
| 7 | `scm-r7-lo-truot-rau-cu-ra-0` | v1 | Đạt. Solution 212 (public) / 192 (hidden-1); starter 0. Wrong `> 0.02` ra 211/191, `>= 0.02` ra 214/194, rớt cả hai biến thể. Đã soát dữ liệu biên: `qty_defect/qty_received` tính lại cho đúng 212 lô, nên `inspection_result` khớp quy tắc "vượt 2%" trên tỷ lệ chưa làm tròn (lô PO_0141576 có tỷ lệ 0,0200038 bị làm tròn thành 0,02). | Cần sửa | "NCC" chưa giải nghĩa ở tiêu đề; `\luuy` lộ cách sửa, trùng khuôn với R1. |
| 9 | `scm-r9-otif-da-nang-lan-tuan-2016` | v1 | **Cần sửa.** Khớp solution (35 chuyến; starter thừa SH_0008589 tuần 2016-12-26/2017-01-01). Wrong `on_time = 0` ra 6 dòng, rớt. Không có cặp (week, store_nbr) trùng nên thứ tự ổn định. Nhưng `shipments` ở hidden-1 giống public, kết quả **trùng nhau**. | Cần sửa | `\boicanh` chủ ngữ dài theo trật tự tiếng Anh; "DC" chưa giải nghĩa. |
| 11 | `scm-n2-hang-chua-ve-thang-8` | v1 | Đạt. Khớp solution: public 553 / 546 / 2.813.052 / 2.812.968; hidden-1 506 / 500 / 2.551.248 / 2.551.176. Ba wrong rớt (`thieu_can_tren` chỉ rớt hidden-1, đúng thiết kế). `received_date` và `qty_received` trống cùng lúc ở mọi dòng. | Cần sửa · CẦN NGƯỜI NẮM DOMAIN | Lẫn "lượng còn thiếu" với "chưa về"; bài cần `SUM`, `COUNT` (module 4) trong module 2. |
| 13 | `scm-n4-fill-rate-cua-hang-52` | v1 | **Cần sửa.** Khớp solution (đầu danh sách 2013931 · 38,44). Hai wrong rớt public. Không chấm oan do làm tròn trung gian (phép chia DECIMAL giữ 7 chữ số). Nhưng `inventory_snapshots` của cửa hàng 52 giống hệt ở hidden-1, kết quả **trùng nhau**. | Cần sửa | `\boicanh` danh từ hoá kiểu dịch máy; "của từng dòng". |
| 15 | `scm-n6-ngay-cao-diem-gap-doi-2016` | v1 | **Cần sửa.** Khớp solution (10 ngày, 250 → 100). Hai wrong rớt public. Phép tính số thực an toàn: (2−1)×100 = 100 đúng, (2,2−1)×100 = 120,00000000000001 làm tròn về 120. Nhưng `event_calendar` ở hidden-1 giống public, kết quả **trùng nhau**. | Cần sửa | Tiêu đề thiếu "có"; `\luuy` so sánh khập khiễng và làm nấc gợi ý 1 vô dụng; khái niệm "cửa sổ". |
| 17 | `scm-n8-dung-han-thai-binh-tron` | v1 | Đạt. Solution 2.217 / 2.118 / 95,53 (public), 1.986 / 1.900 / 95,67 (hidden-1); starter ra 96,00 ở cả hai, lệch > 0,01. Wrong bỏ lọc huỷ ra 2.558 / 95,43, rớt. Các cách viết khác (`AVG(on_time)*100`, `SUM/COUNT*100` rồi mới `ROUND`) cũng ra 95,53 / 95,67, không chấm oan. | Cần sửa | `\luuy` câu chung chung; tiêu đề lệch thuật ngữ "tỷ lệ giao đúng hạn". |
| 19 | `scm-c1-tu-ap-voucher-huy-don` | v1 | Đạt. b1 khớp: manual 136.496 / 16.159 / 11,84; auto_apply 136.331 / 10.919 / 8,01 (hidden-1: 11,85 / 8,00). Chênh 3,83 điểm phần trăm (hidden-1: 3,85), khớp "gần 4 điểm phần trăm". Wrong `voucher_applied` (cột đầu là 0/1) và `thieu_can_tren` (11,82) đều rớt. | Cần sửa | Phương án đúng dài nhất và duy nhất có số; "trên hai nhóm", "cỡ tương đương"; lẫn voucher / mã / phiếu giảm giá. |

**Tổng: Đạt cả hai mặt 1 câu (R3) · Cần sửa 9 câu.** Kiểm SQL: Đạt 5, Cần sửa 5 (cả 5 đều do hai biến thể trùng kết quả). Kiểm nội dung: Đạt 2 (R1, R3), Cần sửa 8 (N2 kèm CẦN NGƯỜI NẮM DOMAIN).

Không thấy lỗi nặng loại solution sai, wrong không rớt, chấm oan do làm tròn hay tab Nghiệp vụ lộ con số kết quả.

---

## Chi tiết từng câu

### 1 · `scm-r1-cua-hang-tphcm` (Viết · Cơ bản · A1)
- Bước 1–2: lời giải tự viết `WHERE city = 'TP.HCM' ORDER BY store_nbr` trùng solution ở cả hai biến thể.
- Bước 3: `state = 'TP.HCM'` thừa cửa hàng 35 (Vũng Tàu), `'TP HCM'` ra 0 dòng. Cả hai rớt.
- **Biến thể:** `stores` ở hidden-1 chép nguyên, kết quả trùng public. Học viên chép kết quả Chạy thử vẫn qua. Đề xuất: (a) thêm vào `03_bien_the_an_scm.sql` một thay đổi trên `stores` (ví dụ đổi `cluster` của một cửa hàng TP.HCM ở hidden-1), hoặc (b) giảng viên chấp nhận câu Cơ bản một bảng nhỏ không có biến thể khác và ghi rõ trong `\ghichuthietke`.
- Bước 4–5: nghiệp vụ hợp lý (cột `state` = TP.HCM cho Vũng Tàu khớp địa giới sau sáp nhập 2025). Cấp Cơ bản, ERD 1 bảng có giá trị mẫu, đúng Module 1.
- Bước 6: không thấy giọng AI hay dịch máy. Góp ý nhỏ, không bắt buộc: "cột \code{state} là tỉnh, thành quản lý" → "cột \code{state} là tỉnh, thành phố quản lý địa bàn của cửa hàng".

### 3 · `scm-r3-dong-tra-hang-cua-hang-2-3` (Viết · Dễ · A1)
- Bước 1–3: khớp; hidden-1 khác public 2 dòng. `thieu_ngoac_quanh_or` lấy mọi dòng của cửa hàng 2; `dung_and_giua_hai_cua_hang` ra 0 dòng.
- Bước 4: `\boicanh` nêu mục đích "để kiểm tra với quầy thu ngân" (đối soát trả hàng), còn dòng mở tab Nghiệp vụ là "Chọn mã hàng cần kiểm tra lại chất lượng hoặc cách tư vấn tại quầy". Hai mục đích khác nhau. Đề xuất cho khớp, ví dụ đổi dòng mở thành "Đối soát các lượt trả hàng với quầy thu ngân."
- Bước 5–6: đúng cấp, đúng module; giọng văn đạt.

### 5 · `scm-r5-von-ton-cua-hang-51` (Viết · Cơ bản · B4)
- Bước 1–3: khớp; wrong sắp theo `on_hand_end` ra danh sách khác (1239986, 1642399, 1430040, …), wrong `'2017-7'` ra 0 dòng.
- **Biến thể:** hai biến thể ra cùng 10 dòng (đề tự ghi trong `\ghichuthietke`). Cần sửa như R1. Lưu ý nếu định bỏ dòng `inventory_snapshots` có `item_nbr % 10 = 7` ở hidden-1 thì câu này vẫn không đổi, vì không mã nào trong 10 dòng đầu tận cùng 7. Phải đổi giá trị của chính cửa hàng 51 kỳ 2017-07.
- Bước 6:
  - `\tieude`: "Mã nào có vốn tồn lớn nhất cửa hàng 51?" → "Mã nào có vốn tồn lớn nhất ở cửa hàng 51?" (thiếu giới từ; 10 tiếng).
  - `\ghichuthietke`: "Dạng B4 vì hỏi trạng thái tồn tại cuối kỳ." (dịch máy, "trạng thái tồn tại") → "Dạng B4 vì hỏi số liệu tại thời điểm cuối kỳ."

### 7 · `scm-r7-lo-truot-rau-cu-ra-0` (Sửa lỗi · Cơ bản · A2)
- Bước 1–3: đúng như mô tả. Hai wrong lệch 1 và 2 lô ở cả hai biến thể. Starter sai đúng một chỗ (`'Failed'`).
- Bước 4: khái niệm ghi "lô trượt khi tỷ lệ hàng lỗi vượt 2%", còn `\luuy` cấm so `defect_rate` với ngưỡng nhưng không nói lý do. Đề xuất nêu lý do: "\code{defect_rate} đã làm tròn 5 chữ số, nên lô sát ngưỡng 2% không phân định được bằng cột này; lô trượt lấy theo \code{inspection_result}."
- Bước 5: cấp, ERD đúng. Bài dùng `COUNT(*)` (module 4), nhưng `COUNT` nằm sẵn trong starter nên chấp nhận được.
- Bước 6:
  - `\tieude`: "Số lô trượt của NCC rau củ ra 0" (viết tắt "NCC" chưa giải nghĩa ở lần đầu) → "Số lô trượt của nhà cung cấp rau củ ra 0".
  - `\luuy`: "Giá trị trong cột chữ phải khớp từng ký tự với giá trị lưu trong bảng." Câu này ở tab Nghiệp vụ (xem miễn phí) nói thẳng cách sửa, làm nấc `\goiy` 1 (trừ 5 điểm) mất giá trị. Câu cũng là ý kỹ thuật, lặp gần nguyên văn `\luuy` của R1 ("Giá trị chữ phải khớp từng ký tự"). Đề xuất: bỏ câu này, chỉ giữ câu về `inspection_result` (đã sửa như trên).

### 9 · `scm-r9-otif-da-nang-lan-tuan-2016` (Sửa lỗi · Dễ · C3)
- Bước 1–3: khớp; starter thừa đúng một chuyến của tuần 2016-12-26/2017-01-01. Wrong chỉ xét `on_time = 0` ra 6 dòng (29 trong 35 chuyến không đạt OTIF là do thiếu hàng, khớp `\ghichuthietke`).
- **Biến thể:** `shipments` ở hidden-1 giống public, kết quả trùng. Cần sửa như R1.
- Bước 6:
  - `\boicanh`: "Danh sách chuyến giao từ trung tâm phân phối Đà Nẵng không đạt OTIF (đúng hạn và đủ hàng) năm 2017 lại lẫn một tuần năm 2016." Chủ ngữ hơn 15 tiếng, xếp định ngữ theo trật tự tiếng Anh (dịch máy). → "Anh lọc các chuyến giao năm 2017 của trung tâm phân phối (DC) Đà Nẵng không đạt OTIF (vừa đúng hạn vừa đủ hàng), nhưng danh sách lại lẫn một tuần năm 2016. Em sửa giúp anh."
  - Dòng mở tab Nghiệp vụ: "Chọn tuyến từ DC tới cửa hàng …". "DC" chưa được giải nghĩa trong câu này (STYLE A.3: lần đầu "trung tâm phân phối (DC)"). Sửa ở `\boicanh` như trên là đủ.

### 11 · `scm-n2-hang-chua-ve-thang-8` (Viết · Dễ · B4)
- Bước 1–3: khớp ở cả hai biến thể. Ba wrong rớt đúng chỗ thiết kế.
- Bước 4 · **CẦN NGƯỜI NẮM DOMAIN:** đề gọi cùng một đại lượng là "chưa về" (`\tieude`, `\boicanh`: "còn bao nhiêu hàng chưa về để báo kho chuẩn bị chỗ") và "lượng còn thiếu" (`yeucau`: "lượng đặt trừ lượng đã nhận"). Với đơn đã về nhưng giao thiếu, phần chênh thường không về nữa (đơn đã đóng), nên không cần chỗ trong kho. Trong dữ liệu tháng 8/2017 của SUP_007, cả 7 đơn đã về đều nhận đủ, nên con số không đổi; chỉ định nghĩa là chưa chặt. Cần người nắm nghiệp vụ mua hàng chốt: "lượng chưa về" chỉ tính đơn chưa về, hay tính cả phần giao thiếu.
- Bước 5: câu thuộc Module 2 nhưng cần `COUNT` và `SUM` (Module 4 theo `CHOT-LO-TRINH.md`). Bẫy chính "SUM bỏ qua NULL" cũng là kiến thức hàm gộp. Đề xuất: chuyển sang Module 4, hoặc đổi thành câu theo dòng (liệt kê từng đơn kèm `luong_chua_ve` bằng `qty_ordered - COALESCE(qty_received, 0)`).
- Bước 6:
  - Lẫn hai cách gọi: "lượng còn thiếu" và "chưa về"; chữ "thiếu" còn dễ nhầm với "thiếu hụt", "thiếu hàng" của STYLE A.1, A.3. → `yeucau`: "Tính lượng chưa về của từng đơn bằng lượng đặt trừ lượng đã nhận; đơn chưa về coi lượng đã nhận bằng 0." Đổi alias thành `luong_chua_ve` (sửa đồng bộ `solution.sql`).

### 13 · `scm-n4-fill-rate-cua-hang-52` (Viết · Dễ · C1)
- Bước 1–3: khớp, không hoà ở 10 dòng đầu; hai wrong rớt.
- **Biến thể:** kết quả hai biến thể trùng nhau. Cần sửa như R1.
- Bước 4: "Cửa hàng 52 mới mở từ tháng 4" khớp `transactions` (ngày đầu 20/4/2017), dù `inventory_snapshots` có từ kỳ 2017-03 (hàng nhập trước khai trương). Chấp nhận.
- Bước 6:
  - `\boicanh`: "Chị cần mười mã hàng thiếu hụt nhiều nhất tháng 7 và phần lượng bán được phục vụ từ hàng có sẵn của từng mã." Cụm danh từ dài, bị động "được phục vụ", dịch nguyên định nghĩa fill rate vào lời nói (dịch máy). → "Chị cần mười mã hàng thiếu hụt nhiều nhất tháng 7, kèm tỷ lệ lấp đầy của từng mã."
  - `yeucau`: "Tính fill rate (tỷ lệ lấp đầy) của từng dòng" → "Tính fill rate (tỷ lệ lấp đầy) của từng mã hàng" (lấy theo chủ thể nghiệp vụ, không theo "dòng" của bảng).

### 15 · `scm-n6-ngay-cao-diem-gap-doi-2016` (Viết · Dễ · C3)
- Bước 1–3: khớp; hai wrong rớt.
- **Biến thể:** `event_calendar` ở hidden-1 giống public, kết quả trùng. Cần sửa như R1.
- Bước 6:
  - `\tieude`: "Ngày cao điểm nào năm 2016 nhu cầu gấp đôi?" (thiếu động từ) → "Ngày cao điểm nào năm 2016 có nhu cầu gấp đôi?"
  - `\luuy`: "Hệ số nhu cầu 1,6 nghĩa là nhu cầu bằng 1,6 lần ngày nền, tức tăng 60\% so với ngày nền." So nhu cầu với "ngày nền" là so khập khiễng. → "Hệ số nhu cầu 1,6 nghĩa là nhu cầu bằng 1,6 lần nhu cầu ngày nền, tức tăng 60\% so với ngày nền." Câu này đã nêu cả cách đổi hệ số ra mức tăng, nên `\goiy` 1 ("Hệ số 2 nghĩa là nhu cầu bằng mấy lần ngày nền, và tăng bao nhiêu phần trăm?") lặp lại nội dung miễn phí mà vẫn trừ 5 điểm. Đề xuất bỏ ví dụ số trong `\luuy` (chỉ giữ định nghĩa hệ số), hoặc đổi `\goiy` 1 sang ý khác (cận năm 2016).
  - Khái niệm `ngay-cao-diem` (khai báo dùng chung): "…trong lịch sự kiện, khi lượng đơn tăng mạnh" (mệnh đề "khi" treo) → "…trong lịch sự kiện, có lượng đơn tăng mạnh so với ngày thường"; "Ngày nền là ngày nằm ngoài cửa sổ hai ngày trước và sau mỗi ngày cao điểm" ("cửa sổ" dịch từ *window*) → "Ngày nền là ngày cách mọi ngày cao điểm hơn hai ngày."

### 17 · `scm-n8-dung-han-thai-binh-tron` (Sửa lỗi · Dễ · A2)
- Bước 1–3: khớp; starter sai đúng một chỗ (làm tròn trước khi nhân 100), lệch 0,47 và 0,33 điểm phần trăm ở hai biến thể, vượt sai số 0,01. Wrong bỏ lọc huỷ rớt.
- Bước 5: cấp, ERD đúng; `SUM`, `COUNT` có sẵn trong starter.
- Bước 6:
  - `\luuy`: "Làm tròn giữa chừng làm mất chữ số của kết quả." Câu chung chung kiểu khẩu hiệu (giọng AI), nói kỹ thuật chứ không nói nghiệp vụ, "mất chữ số" mơ hồ. → "Tỷ lệ làm tròn tới 2 chữ số thập phân rồi mới đổi ra phần trăm chỉ còn chính xác tới 1 điểm phần trăm, nên báo cáo luôn ra số tròn."
  - `\tieude`: "Tỷ lệ đúng hạn kho Thái Bình ra số tròn" (lệch tên khái niệm "tỷ lệ giao đúng hạn", thiếu "của") → "Tỷ lệ giao đúng hạn của kho Thái Bình ra số tròn" (10 tiếng).

### 19 · `scm-c1-tu-ap-voucher-huy-don` (Case · Cơ bản)
- Bước 1–3: b1 khớp; hai wrong rớt public. Đã soát số ở phương án: "gần 4 điểm phần trăm" (3,83 / 3,85) và "số đơn gần bằng nhau" (lệch 165 đơn) đúng ở cả hai biến thể.
- Bước 4: thử nghiệm A/B chia nhóm từ đầu nên kết luận nhân quả ở phương án đúng chấp nhận được.
- Bước 5: case Cơ bản nhưng b1 cần `GROUP BY`, `SUM` (Module 4). Đề nghị giảng viên xác nhận case Cơ bản được dùng kỹ năng gom nhóm.
- Bước 6:
  - **Lộ phương án đúng (K32):** phương án đúng dài khoảng 31 tiếng, hai phương án sai khoảng 21 và 24 tiếng. Phương án đúng cũng là phương án duy nhất có số cụ thể. Phương án sai thứ hai ("Hai nhóm có số đơn gần như bằng nhau, nên việc tự áp voucher không làm thay đổi số đơn bị huỷ.") là lỗi lập luận ít người mắc. Đề xuất thay bằng lỗi mà wrong của b1 dạy, dài gần bằng và cũng có số: "Đơn có dùng voucher có tỷ lệ huỷ thấp hơn đơn không dùng khoảng 4 điểm phần trăm, nên dùng voucher làm khách huỷ đơn ít hơn." Giải thích: "Chưa đúng. Phương án này so theo việc đơn có dùng mã, không theo nhóm thử nghiệm; khách tự chọn dùng mã nên hai nhóm không so được với nhau." (Tôi đã chạy kiểm: theo `voucher_applied` ra 12,01% và 7,99%, nên phương án này đúng là một cám dỗ có thật.)
  - `\phuongan*`: "…gần 4 điểm phần trăm, trên hai nhóm có số đơn gần bằng nhau." ("trên hai nhóm" dịch từ *on two groups*) → "Tỷ lệ huỷ của nhóm hệ thống tự áp voucher thấp hơn nhóm khách tự nhập voucher gần 4 điểm phần trăm, với số đơn hai nhóm gần bằng nhau."
  - Lời giải thích phương án đúng: "hai nhóm có cỡ tương đương và tỷ lệ huỷ của nhóm \code{'auto_apply'} thấp hơn rõ" ("cỡ" dịch từ *size*; "thấp hơn rõ" lửng) → "Đúng. Bước 1 cho thấy hai nhóm có số đơn gần bằng nhau, và tỷ lệ huỷ của nhóm \code{'auto_apply'} thấp hơn gần 4 điểm phần trăm."
  - Phương án sai 2: "việc tự áp voucher" (danh từ hoá bằng "việc"). Nếu giữ phương án này thì sửa thành "tự áp voucher không làm thay đổi số đơn bị huỷ".
  - `\luuy`: "Nhóm \code{'manual'} là khách tự nhập mã, nhóm \code{'auto_apply'} là nhóm hệ thống tự áp mã; hai nhóm được chia từ đầu." Câu lặp "nhóm … là nhóm", còn "được chia từ đầu" mơ hồ. → "Nhóm \code{'manual'} gồm khách tự nhập mã, nhóm \code{'auto_apply'} gồm khách được hệ thống tự áp mã; khách được chia vào hai nhóm ngay khi bắt đầu thử nghiệm."
  - **Lẫn cách gọi** trong cùng câu: "tự áp voucher" (tiêu đề, phương án), "voucher (phiếu giảm giá)" (bối cảnh), "tự nhập mã", "tự áp mã" (`\luuy`, phương án). STYLE A.3 ghi "nhóm khách tự áp mã ('manual') / nhóm hệ thống tự áp mã ('auto_apply')". Đề xuất chọn một: giải nghĩa "voucher (phiếu giảm giá)" ở lần đầu, sau đó dùng thống nhất "tự nhập voucher" / "hệ thống tự áp voucher" (hoặc thống nhất "mã"). Báo lại người giữ STYLE: chữ "tự áp mã" cho nhóm `'manual'` ở A.3 dễ hiểu nhầm, nên đổi thành "tự nhập mã".

---

## Giọng văn

Trên 10 câu của B: **3 chỗ giọng AI, 8 chỗ dịch máy, 5 chỗ lệch thuật ngữ hoặc viết tắt**, cộng 3 chỗ diễn đạt thiếu từ (R5, N6 tiêu đề; C1 `\luuy`).
- Giọng AI: R7 `\luuy` khuôn "Giá trị … phải khớp từng ký tự" (lặp R1); N8 "Làm tròn giữa chừng làm mất chữ số của kết quả."; C1 phương án đúng dài nhất, duy nhất có số (K32).
- Dịch máy: R5 "trạng thái tồn tại cuối kỳ"; R9 chủ ngữ dài trong `\boicanh`; N4 "phần lượng bán được phục vụ từ hàng có sẵn của từng mã"; N6 "bằng 1,6 lần ngày nền"; khái niệm `ngay-cao-diem` "khi lượng đơn tăng mạnh", "cửa sổ hai ngày"; C1 "trên hai nhóm có số đơn gần bằng nhau", "cỡ tương đương … thấp hơn rõ", "việc tự áp voucher".
- Lệch thuật ngữ, viết tắt: R7 "NCC" ở tiêu đề; R9 "DC" chưa giải nghĩa; N2 "lượng còn thiếu" và "chưa về"; N8 "tỷ lệ đúng hạn"; C1 voucher, mã, phiếu giảm giá.

Khuôn lặp trên nhiều câu của gói (gồm cả câu chẵn tôi chỉ đọc lướt):
1. **Câu cuối lời nhắn ở câu Sửa lỗi** gần như một khuôn: "Anh chị xem giúp em (sai ở đâu)" (R7, N7), "Em kiểm tra lại cách đếm/cách tính giúp anh" (R8, N8), "Em sửa giúp anh" (R9). Nên đổi cách kết, ví dụ nêu thời hạn hoặc việc dùng số ("…để chiều nay anh gửi phòng kế toán").
2. **Câu mở yêu cầu ở câu Viết** gần như luôn là "Em lấy giúp anh/chị …", "Em gửi anh …", "Em tính giúp chị …", "Em liệt kê giúp anh …" (R1, R5, R6, N1, N6). Chấp nhận được về giọng, nhưng đọc liền 20 câu thấy đều một khuôn.
3. **`\luuy` kỹ thuật lặp**: "Giá trị chữ phải khớp từng ký tự" (R1, R7).
4. **Nấc `\goiy` 2 viết gần trọn biểu thức đáp án** (R1 "Lọc \code{city = 'TP.HCM'}", N4, N6, N8 đưa cả biểu thức `ROUND(...)`). Đúng giới hạn "một dòng" của STYLE G.5, nhưng nấc 2 thành đáp án. Giảng viên nên chốt mức chấp nhận.
5. **Biến thể ẩn không đổi bảng** (ghi ở đây vì lặp trên nhiều câu): R1, R5, R9, N4, N6 (và theo bảng số dòng trong `mysql/README.md`, cả R6, N3, N7 thuộc phần của C) dùng bảng mà hidden-1 không đổi, nên chép kết quả Chạy thử vẫn qua. Nên sửa một lần ở `03_bien_the_an_scm.sql` (hoặc thêm `scm_hidden_2`) thay vì sửa từng câu.
