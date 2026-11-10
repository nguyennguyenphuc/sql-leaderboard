# Đã sửa · gói 4 Supply Chain (scm) · v2

Sửa theo `REVIEW-B.md`, `REVIEW-C.md` (10/11/2026). Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại:
- Câu sửa SQL hoặc yêu cầu chấm (t1, t6, f6, f8, c7) chạy bộ kiểm trên gói tạm `cong-cu/ket-qua/sua/scm-goi-4/`.
- Toàn gói qua phân tích tĩnh (`--chi-phan-tich`).
- Biên dịch ra `cong-cu/ket-qua/bien-dich/scm-goi-4/`.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| scm-t1-ton-tren-ban-nganh-hang | B: hết chấm oan. Solution và hai wrong sắp theo tỷ số **chưa làm tròn**, yêu cầu ghi rõ (in đậm "chưa làm tròn"). Đổi tiêu đề thành câu hỏi. Mốc thời gian sửa thành "đầu tháng 8 duyệt kế hoạch quý 4" (bối cảnh và nghiệp vụ). Sửa `\luuy` ("cộng riêng … rồi mới nối"). Ghi chú thiết kế nêu hai cặp bằng nhau sau làm tròn ở hidden-1. | bộ kiểm gói tạm + tĩnh |
| scm-t2-chuyen-giao-cua-hang-18 | C: đổi tiêu đề (10 tiếng). Gợi ý nấc 1 thành câu hỏi nghiệp vụ; nấc 2 gộp WITH RECURSIVE, LEFT JOIN, COALESCE. Sửa `\luuy`, bỏ "làm khung" và "ghép". | tĩnh (chỉ sửa chữ) |
| scm-t3-ma-hang-can-ra-soat | B: "phép ghép" đổi thành "phép hợp … UNION hay UNION ALL". `yeucau` mục 2 mở bằng động từ "Đếm". Dòng mở `nghiepvu` đổi thành "Chọn ngành hàng cần ưu tiên …". | tĩnh |
| scm-t4-ty-le-lo-truot-ncc | C: sửa `\luuy` (bỏ khuôn K5/K23). Thêm "trong năm 2016 đã về kho". Yêu cầu ghi "giữ nguyên câu ORDER BY" để tránh lệch thứ tự do làm tròn. | tĩnh |
| scm-t5-nhap-xuat-dc | B: bối cảnh bỏ "truy vấn", thêm "giúp anh". Dòng mở `nghiepvu` nêu quyết định ("Chọn DC cần kiểm kê kỹ …"). | tĩnh |
| scm-t6-von-ton-theo-loai-cua-hang | C: thay wrong tự đưa lỗi `ym >=` bằng lỗi sửa dở thật `union_them_cua_hang` (thêm `store_nbr`, giữ UNION). Bối cảnh bỏ "truy vấn". `\luuy` không lộ cách sửa. "giá trị tồn" đổi thành "vốn tồn". "ghép" đổi thành "hợp". | bộ kiểm gói tạm + tĩnh |
| scm-t7-ncc-duoi-chuan | B: bối cảnh rút gọn (dưới 35 tiếng). `yeucau` mục 2 mở bằng "Liệt kê", giải nghĩa lead time ở lần đầu. Bỏ câu `\luuy` cảnh báo bẫy chuẩn không trọng số, vì dữ liệu không phân biệt được bẫy này. Hai wrong hiện có (lọc theo ngày nhận, biên đúng hạn) giữ nguyên. | tĩnh (SQL không đổi; lần chạy cả gói v1 đạt) |
| scm-t8-diem-giao-huy-cao | C: đổi tiêu đề. "miền chứa nó" đổi thành "miền tương ứng". Thêm gợi ý nấc 1 về chuẩn của miền. | tĩnh |
| scm-t9-huy-theo-nhom-ap-ma | B: tiêu đề thành câu hỏi; sửa câu sắp. "ghép" đổi thành "phép hợp". Giữ `saiso=0.001`: cột làm tròn 2 chữ số, solution tất định; ghi lý do trong ghi chú thiết kế. | tĩnh |
| scm-f1-top3-hang-tuoi-song | C: tiêu đề thành câu hỏi. `\luuy` bỏ "Đề yêu cầu". Gợi ý "bằng giá trị" đổi thành "hai mã bằng lượng bán". | tĩnh |
| scm-f2-fill-rate-theo-thang | B: "mức phục vụ" đổi thành "mức độ phục vụ" (bối cảnh, nghiệp vụ); giải nghĩa fill rate trong bối cảnh. Hết trùng với c7.b1: c7.b1 đã đổi đề. | tĩnh |
| scm-f3-luy-ke-cua-hang-44 | C: tiêu đề thành câu hỏi. Bối cảnh "Cửa hàng mình …". `\luuy` thay mẹo cận trên bằng hiểu lầm nghiệp vụ (dòng trả hàng âm). Gợi ý bỏ khuôn "mệnh đề: kết luận". | tĩnh |
| scm-f4-ngay-don-tang-dot-bien | B: `yeucau` mục 2 mở bằng động từ, sửa sai nghĩa "đủ 7 ngày của tháng 9". Thống nhất một cách gọi "tăng đột biến" (bối cảnh, nghiệp vụ, khái niệm). Viết lại "Trong bộ dữ liệu" của `trung-binh-truot`. `\luuy` thành điểm nghiệp vụ. | tĩnh |
| scm-f5-hang-abc-beverages | C: tiêu đề thành câu hỏi (dưới 10 tiếng). Bối cảnh bỏ "hạng hàng". Đảo gợi ý: nấc 1 hỏi hướng, nấc 2 mới đưa khung cửa sổ. | tĩnh |
| scm-f6-giao-dich-cung-ky | B: bỏ khuôn "Với mỗi". Nghiệp vụ: đổi sang tăng trưởng cùng cửa hàng (like-for-like), chỉ tính cửa hàng có giao dịch ở cả tháng 1/2016 và tháng 7/2017, nên loại cửa hàng 52 mở 20/04/2017. Sửa `\luuy`. Thêm wrong `tinh_ca_cua_hang_moi`. | bộ kiểm gói tạm + tĩnh |
| scm-f7-cua-hang-dong-khach-nhat | C: bối cảnh bỏ "truy vấn"; sửa trật tự "cho mỗi loại cửa hàng". | tĩnh |
| scm-f8-luy-ke-nhan-hang-ncc | B: starter không còn ra 0 dòng. Đổi đối tượng sang ba NCC (SUP_027, SUP_053, SUP_063) nhận hàng tháng 7/2017. Hai lỗi đều thấy ngay khi chạy starter: các đơn cùng ngày chung một luỹ kế (khung RANGE mặc định), và luỹ kế cộng nối sang NCC sau (thiếu PARTITION BY). Bối cảnh, tiêu đề, yêu cầu (thêm cột `supplier_id`), `\luuy`, gợi ý viết lại theo đúng triệu chứng. Mỗi wrong sửa một lỗi. | bộ kiểm gói tạm + tĩnh |
| scm-f9-huy-thang-truoc-theo-kho | C: tiêu đề và bối cảnh viết lại. Yêu cầu chỉ nêu triệu chứng, không nói nguyên nhân. Thêm đơn vị "điểm phần trăm". | tĩnh |
| scm-c7-fill-rate-thang-3 | B: b1 đổi đề (fill rate và tỷ lệ dòng thiếu hụt từng kỳ), hết trùng f2; thêm khái niệm `ty-le-dong-thieu-hut`. b2 thêm quy tắc bằng nhau và wrong `lay_tong_thieu_hut_thang_3`. Phương án đúng rút gọn, bỏ "trong khi" và GROCERY I. Ba phương án dài gần bằng nhau, cả ba có "chủ yếu"/"chỉ". Giải thích phương án 3 dẫn đúng bước 2. Bối cảnh "thiếu hàng" đổi thành "hết hàng"; sửa ghi chú thiết kế. | bộ kiểm gói tạm + tĩnh |
| scm-c8-giao-tre-ngay-cao-diem | C: ba phương án cân độ dài, cả ba có "chủ yếu". Phương án 1 ghi "dài nhất ở ngày nền". Phương án 3 bỏ "Mọi kho" ở đầu. Giải thích phương án đúng rút dưới 30 tiếng. `\luuy` không nói trước lời giải. "khâu" đổi thành "chặng". b1 thêm câu về ngày sự kiện đầu năm 2017. b4 mở bằng "Xét", sửa câu dịch máy. Gợi ý b1 bỏ khuôn "X: …". Sửa ghi chú thiết kế. | tĩnh (SQL không đổi) |

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Biến thể ẩn không chống chép số** (trước ở mục Chờ giảng viên): `mysql/04_bo_sung_bien_the_scm.sql` nay sửa `shipments` (chuyến số hiệu đuôi 7 trễ và thiếu hàng, bỏ chuyến `SH_0000168`), bỏ ~10% `transactions`, tăng 15% tải `warehouse_daily_ops` ở ~1/10 số ngày và bỏ mọi kỳ `inventory_snapshots` của mã đuôi 7. Chạy solution trên `scm` và `scm_hidden_1` (user `sql_runner`): t2, t6, f2, f6, f7, c7 (b1–b3) và c8 (b1–b4) đều khác public, chép kết quả Chạy thử nay rớt ở hidden-1. Đã sửa ghi chú thiết kế của t6, f6, f7, c8 theo.

## Chờ giảng viên

1. **t5 (domain):** sau khi sửa, DC_HANOI xuất khoảng gấp đôi lượng nhập năm 2016. Cần xác nhận `shipments.units_shipped` và `purchase_orders.qty_received` cùng đơn vị, cùng phạm vi hàng. Nếu đây là dữ liệu mô phỏng không cân thì thêm vào `\luuy`: "Số liệu nhập xuất là dữ liệu mô phỏng, chưa gồm tồn đầu năm."
2. **c7 (domain):** tháng 7 có tỷ lệ nhập trên bán 0,90, gần bằng tháng 3 (0,88), nhưng fill rate tháng 7 chỉ giảm 0,28 điểm phần trăm. Cần xác nhận kết luận "fill rate tháng 3 giảm vì lượng nhập xuống dưới lượng bán" là đủ căn cứ.
3. **f6 (domain):** đã chuyển sang tăng trưởng cùng cửa hàng. Cần xác nhận tiêu chí "có giao dịch ở cả tháng 1/2016 và tháng 7/2017" là cách chọn tập cửa hàng mong muốn.
4. **t7, t9 (bẫy yếu):** t7 bỏ cảnh báo chuẩn không trọng số vì dữ liệu năm 2016 không phân biệt được. t9 giữ `saiso=0.001` vì bẫy trung bình tỷ lệ chỉ lệch 0,01 (hai nhóm A/B gần 50/50 số đơn). Cần chốt có chấp nhận `saiso` chặt hơn chuẩn gói không, hay bỏ wrong này.

## Quyết định v3 (10/11)

Theo `BRIEF-QUYET-DINH-126.md` và `QUYET-DINH-CHUNG.md`. Mục "Chờ giảng viên" ở trên đã xử lý hết.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `scm-t5-nhap-xuat-dc` | DC_HANOI xuất khoảng gấp đôi lượng nhập | Thêm `\luuy` về dữ liệu mô phỏng | `SupplyChain\docs\PHU-LUC_xay-dung-du-lieu_vn.md` dòng 71–73, 95: `purchase_orders`, `shipments` sinh bằng chính sách mô phỏng riêng, không cân với nhau | `\luuy`: "Số liệu nhập xuất là dữ liệu mô phỏng, chưa gồm tồn đầu năm, nên lượng nhập và lượng xuất của một DC không cần bằng nhau." |
| `scm-c7-fill-rate-thang-3` | Kết luận nhân quả "vì nhập dưới bán" yếu | Phương án đúng chỉ nêu tương quan | Tháng 7 tỷ lệ nhập trên bán 0,90 (tháng 3: 0,88) mà fill rate chỉ giảm 0,28 điểm phần trăm | Tiêu đề "Fill rate tháng 3/2017 giảm do bán tăng hay nhập giảm?"; phương án đúng "… đúng lúc fill rate giảm …, nhưng chưa đủ để khẳng định đây là nguyên nhân"; phương án sai 1 thêm "có thể" để từ rào không chỉ có ở phương án đúng (K32); ghi chú thiết kế |
| `scm-f6-giao-dich-cung-ky` | Tiêu chí tập cửa hàng cùng kỳ | Giữ "có giao dịch ở cả tháng 1/2016 và tháng 7/2017" | Tăng trưởng cùng cửa hàng chỉ so các cửa hàng hoạt động ở cả hai kỳ | Không sửa |
| `scm-t7-ncc-duoi-chuan` | Bỏ wrong chuẩn không trọng số, bẫy yếu | Giữ câu, ghi bẫy yếu | BAO-CAO-TONG-HOP 3.1 | `\ghichuthietke` ghi lý do |
| `scm-t9-huy-theo-nhom-ap-ma` | `saiso=0.001` chặt hơn chuẩn gói | Chấp nhận riêng t9 | Đề ghi rõ "làm tròn 2 chữ số"; trung bình hai tỷ lệ chỉ lệch 0,01 | Không sửa |
| Chữ "tự áp mã" | khái niệm thử nghiệm A/B, t9 | "tự nhập voucher" / "hệ thống tự áp voucher" | QUYET-DINH-CHUNG 1.7 | Khái niệm A/B, bối cảnh và dòng mở Nghiệp vụ của t9 |

- Kết luận case (QUYET-DINH-CHUNG 1.1, sửa theo quy_chuan 23:05, gói mẫu c1–c4): phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Đã đổi ở mọi case của gói.
- Kiểm lại 10/11 (sau mọi sửa v3): bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/kiem-cuoi/scm-goi-<k>/`) → **KIEM TRA: 0 loi**; phân tích tĩnh bản cuối → 0 lỗi; biên dịch `cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu (chỉ cảnh báo Overfull hbox).

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu = 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (như `quy_chuan/lo-trinh-sql/assets/js/data.js`), giữ 6 write + 3 debug. Case c7, c8 giữ nguyên cấp.

| Module | Trước (Cơ bản · Dễ · TB · Khó) | Sau | Write theo cấp (sau) | Debug theo cấp (sau) |
|---|---|---|---|---|
| M7 CTE & Set Operations | 0 · 0 · 6 · 3 | 2 · 3 · 2 · 2 | t7 · t3, t9 · t1, t8 · t2 | t4 · t6 · – · t5 |
| M8 Window Functions | 0 · 0 · 5 · 4 | 2 · 3 · 2 · 2 | f5 · f3, f4 · f1, f2 · f6 | f9 · f7 · – · f8 |

Đổi 10 câu, số tối thiểu (mỗi module 3 câu Khó/Trung bình thừa phải xuống Cơ bản/Dễ thì còn 5 chỗ trống). Giữ nguyên: t1, t2, t5, t8, f1, f2, f6, f8 và hai case. Năm trục ghi theo thứ tự số bảng lời giải · số bước · mức mơ hồ · số bẫy · độ sâu nghiệp vụ (QUYET-DINH-CHUNG 2.2); mỗi câu đạt cấp mới ở ≥ 3/5 trục, ghi đủ ở `\ghichuthietke`.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (cấp mới) |
|---|---|---|---|
| `scm-t3-ma-hang-can-ra-soat` (giữ mã) | Trung bình → Dễ | Dạng A1 → A3 (đếm theo ngành hàng; gỡ trùng ô A1 · after_sales · Dễ · Viết với `scm-q2`). Yêu cầu ghi rõ giá trị lọc (`'Fail'`, `received_date` sau `promised_date`), cách hợp và cột `items.family`. ERD 3 bảng ký hiệu → 2 bảng, chữ trên đường nối (bỏ `suppliers`). Gợi ý nấc 2 nêu trọn cách làm. Thêm wrong `quen_can_tren`. | 2 bảng JOIN · 2 bước (hợp tập, nối + gom) · đề ghi rõ · 1 bẫy (đếm trùng mã) · 1 khái niệm: 5/5 Dễ |
| `scm-t4-ty-le-lo-truot-ncc` → `scm-t4-nhap-xuat-ton-cua-hang-3` | Trung bình → Cơ bản | Viết mới (debug): báo cáo nhập xuất tồn kỳ 2017-07 của cửa hàng 3, bốn chỉ tiêu ghép dọc bằng `UNION ALL`; starter cộng nhầm `sold` ở vế nhập. Mảng after_sales → operations, dạng A2 giữ. ERD 1 bảng có giá trị mẫu. Wrong: sửa nhầm vế bán; tự suy nhập bằng tồn cuối − tồn đầu + bán. | 1 bảng · lỗi một chỗ dễ thấy · đề nêu đủ chỉ tiêu, ERD có tên cột · 0 bẫy · 1 khái niệm: 5/5 Cơ bản |
| `scm-t6-von-ton-theo-loai-cua-hang` → `scm-t6-von-ton-binh-quan-loai-cua-hang` | Trung bình → Dễ | Giữ lỗi `UNION` bỏ dòng trùng nhưng đổi cách hợp: hợp hai kỳ tồn kho 2017-06 và 2017-07 để tính vốn tồn bình quân (công thức nêu trong đề), không tách hàng tươi sống/hàng khô qua `items` nữa, nên còn 2 bảng. ERD 2 bảng, chữ trên đường nối. Wrong sửa dở mới: thêm `ym`, giữ UNION. | 2 bảng JOIN · lỗi logic một chỗ · công thức trong đề · 1 bẫy · 1 công thức: 5/5 Dễ |
| `scm-t7-ncc-duoi-chuan` → `scm-t7-ma-thieu-hut-nhieu-ky` | Khó → Cơ bản | Viết mới theo khuôn bài Cơ bản M7 của lộ trình (đếm theo số lần, viết bằng CTE): số mã hàng của cửa hàng 44 theo số kỳ thiếu hụt (2017-01 tới 2017-07). Mảng operations giữ, dạng C3 → C4. ERD 1 bảng có giá trị mẫu. Wrong: thiếu cận trên (lấy cả kỳ 2017-08); `thieu_hut >= 0`. | 1 bảng · 1 CTE + 1 lần gom, đề tách bước · đề ghi rõ cột, giá trị · 0 bẫy (cận trên bình thường) · 1 khái niệm: 5/5 Cơ bản |
| `scm-t9-huy-theo-nhom-ap-ma` (giữ mã) | Trung bình → Dễ | Yêu cầu nêu sẵn công thức tỷ lệ huỷ, cách tính dòng tổng; sắp theo thứ tự chữ cái (`'tong'` tự đứng cuối) nên bỏ cột thứ tự phụ; solution và wrong viết gọn theo đó. ERD 3 bảng → 2 bảng, chữ trên đường nối (`delivery_points` nhiễu). Giữ `saiso=0.001` (quyết định v3). | 1 bảng · 2 bước (gom, hợp dòng tổng) · đề ghi rõ công thức · 1 bẫy (trung bình tỷ lệ) · 1 công thức: 5/5 Dễ |
| `scm-f3-luy-ke-cua-hang-44` (giữ mã) | Trung bình → Dễ | Yêu cầu ghi rõ giá trị lọc `'2017-07-01'`, `'2017-08-01'` và cách tính lượng bán ngày. ERD 3 bảng → 2 bảng, chữ trên đường nối (`stores` nhiễu). SQL không đổi. | 1 bảng · 2 bước (gom ngày, cộng dồn) · đề ghi rõ · 1 bẫy (cận trên ở hidden-1) · 1 khái niệm: 4/5 Dễ (nghiệp vụ ở mức Cơ bản) |
| `scm-f4-ngay-don-tang-dot-bien` → `scm-f4-don-so-voi-hom-truoc` | Khó → Dễ | Viết lại cùng chủ đề (marketing, đợt 11/11): số đơn không huỷ từng ngày tháng 11/2016 so với hôm trước bằng `LAG`, ngày 01/11 so với 31/10; bỏ khung trượt 7 ngày, ngưỡng 1,5 lần. Dạng B3 → B2. ERD 5 bảng chỉ khoá → 2 bảng, chữ trên đường nối. Wrong: lọc trước khi LAG; đếm cả đơn huỷ. | 1 bảng · 2 bước (gom ngày, LAG) · công thức và mốc so trong đề · 1 bẫy (lọc trước khi LAG) · 1 công thức: 5/5 Dễ |
| `scm-f5-hang-abc-beverages` → `scm-f5-xep-hang-ngay-tai-kho` | Khó → Cơ bản | Viết mới theo khuôn bài Cơ bản M8 của lộ trình (đánh số trong từng nhóm, một bảng, không gom): xếp hạng 7 ngày của tuần 12/12/2016 theo tỷ lệ tải trong từng kho, `ROW_NUMBER` với tiêu chí phụ ngày. Mảng finance → operations, dạng C2 → C1. ERD 1 bảng có giá trị mẫu. Wrong: RANK (HUB_THAIBINH có hai ngày bằng tỷ lệ tải); thiếu PARTITION BY. | 1 bảng · 1 tầng · đề ghi rõ chiều sắp, tiêu chí phụ · 0 bẫy ngoài quy tắc đã ghi · 1 khái niệm, cột có sẵn: 5/5 Cơ bản |
| `scm-f7-cua-hang-dong-khach-nhat` (giữ mã) | Trung bình → Dễ | Chấm lại theo QUYET-DINH-CHUNG 0.1 #5, 2.2 (sửa lỗi một chỗ dễ thấy là Dễ). ERD 3 bảng → 2 bảng, chữ trên đường nối (bỏ `store_attributes`); yêu cầu nêu `stores.type`; thêm gợi ý nấc 2. SQL không đổi. | 2 bảng JOIN · thiếu một mệnh đề · triệu chứng lộ ngay · 1 bẫy (thiếu PARTITION BY) · 1 khái niệm: 4/5 Dễ |
| `scm-f9-huy-thang-truoc-theo-kho` → `scm-f9-thay-doi-ty-le-huy-thang` | Trung bình → Cơ bản | Viết lại cùng chủ đề (tỷ lệ huỷ theo tháng 2017, so tháng trước) nhưng cho toàn chuỗi, bỏ chia theo kho; lỗi mới dễ thấy: `ORDER BY thang DESC` trong `OVER` (tháng 1 có số, tháng 7 trống). ERD 3 bảng → 1 bảng có giá trị mẫu. Wrong: đổi sang LEAD; trừ ngược chiều. | 1 bảng · lỗi một chỗ dễ thấy · đề ghi rõ cách tính · 0 bẫy · 1 khái niệm: 5/5 Cơ bản |

Mọi câu đổi: public ≠ hidden-1 (dùng biến thể có sẵn: bỏ ~10% đơn, PO, mã đuôi 7 ở `sales`/`inventory_snapshots`, tăng 15% tải `warehouse_daily_ops` ở ngày theo `TO_DAYS`); mỗi wrong là lỗi hay gặp và rớt ở public; solution chạy dưới 2 giây trên `scm`.

Trùng ô: trong gói không có. So với `BAN-DO-100-CAU.md` lúc sửa: 10 ô mới đều chưa có câu nào khác của bộ (t3 đổi A1 → A3 để tránh trùng `scm-q2`). Các gói khác đang sửa song song nên cần dò lại khi gộp bản đồ; ô dễ đụng nhất: A2 · operations · Cơ bản · Sửa lỗi (t4), C1 · operations · Cơ bản · Viết (f5), C4 · operations · Cơ bản · Viết (t7).

Kiểm lại (11/11, sau mọi sửa v4; gói vẫn đúng 4 file): bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/cap-do/scm-goi-4/bao-cao-import.json`, chạy xong 02:30, sau lần sửa cuối 02:02) → **KIEM TRA: 0 loi**, 0 cảnh báo; mọi wrong mới rớt ở public và hidden-1 (riêng `scm-f3` quen_can_tren chỉ rớt ở hidden-1, như thiết kế). Solution của 10 câu đổi cho kết quả public khác hidden-1 (so md5 kết quả). Biên dịch `bash cong-cu/bien_dich.sh goi-cau-hoi/scm/goi-4 …/cong-cu/ket-qua/cap-do/scm-goi-4-pdf` → PDF 51 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo gói lệnh (40 Overfull hbox, chỉ là trình bày).
