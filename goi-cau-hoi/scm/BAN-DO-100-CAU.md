# Bản đồ 100 câu · bộ Supply Chain (`scm`)

**Bản 2 · sinh lại 10/11/2026 từ file thật** (`goi-*/cau-hoi.tex`, `goi-*/solution.sql`): mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá của `\begin{cauhoi}`; gói theo thư mục; module theo tiền tố mã (r n s a j q t f k p = M1…M10, c = case). Cột “Đề một câu” là mục đầu của `yeucau` (case: tên các bước); “Bảng” lấy từ `FROM`/`JOIN` của lời giải (bỏ CTE); “Bẫy chính” là khoá `bay` (case: tên bài sai theo bước). Phần mở đầu giữ từ bản 1; thống kê và chênh lệch so với bản 1 ở cuối file.

Cập nhật 10/11/2026 19:20 (giờ Việt Nam). Người lập: A (người soạn gói 1). Trạng thái: chờ giảng viên duyệt cùng lô thử gói 1.

Phân bổ đã duyệt: gói k = module 2k−1 và 2k (9 câu mỗi module) + 2 case (gói 1: 2 Cơ bản; gói 2: Cơ bản, Dễ; gói 3: Dễ, Trung bình; gói 4: Trung bình, Khó; gói 5: 2 Khó). Module 1–9 khoảng 6 `write` + 3 `debug`; module 10 khoảng 6 `optimize` + 3 `write`/`debug`. Cấp tăng theo module: M1–3 Cơ bản/Dễ, M4–6 Dễ/Trung bình, M7–10 Trung bình/Khó, mỗi module có ít nhất một câu ở cấp thấp nhất của nó.

Nguồn của bảng: gói 1 do A soạn (khớp `goi-1/cau-hoi.tex`). Gói 2–5 do bốn người soạn khác làm song song, chưa có bản đồ chung lúc soạn nên mỗi gói tự phân bổ theo `BRIEF-SOAN-GOI.md`; bảng dưới đọc thẳng từ `cau-hoi.tex` và `solution.sql` của từng gói tại thời điểm cập nhật (mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá câu; bảng dùng lấy từ `FROM`/`JOIN` của lời giải; bẫy chính lấy từ cột bẫy của `BAN-DO-GOI.md`, gói 2 do A tóm tắt từ khoá `bay` và tên bài sai). Mọi câu đã chạy thật trên MySQL `scm` và `scm_hidden_1` bằng bộ kiểm của từng gói, nên khả thi trên cửa sổ dữ liệu (`sales` chỉ tháng 7/2017; `inventory_snapshots` kỳ 2017-01 tới 2017-08; `orders` 8/2015 tới 8/2017; `purchase_orders` 2013 tới 8/2017). Gói nào sửa câu thì cập nhật lại bảng này.

Cột “Đề một câu”: gói 1 do A viết; gói 2–5 lấy câu yêu cầu chính trong lời nhắn của bối cảnh (câu Viết, Case) hoặc dòng yêu cầu chính (câu Sửa lỗi, Tối ưu); chín câu mà câu trong lời nhắn chưa đủ nghĩa được A viết lại từ phần yêu cầu.

## Gói 1 · M1 Retrieval + M2 NULL & Expressions + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-r1-cua-hang-tphcm` | 1 | M1 | Viết | Cơ bản | A1 | sales | Cửa hàng nào đặt tại TP.HCM? | Xét các cửa hàng có thành phố (cột `city`) là TP.HCM. · Trả về `store_nbr`, `type`, `cluster`. | stores | sai-cot-loc, sai-ky-tu |
| `scm-r2-don-mua-loi-cao-thang-7` | 1 | M1 | Viết | Cơ bản | E1 | after_sales | Đơn mua tháng 7 nào có tỷ lệ hàng lỗi cao? | Xét các đơn mua có ngày đặt (`po_date`) trong tháng 7/2017. · Lọc các đơn có tỷ lệ hàng lỗi (`defect_rate`) từ 5% trở lên. | purchase_orders | ty-le-va-phan-tram, nham-khai-niem |
| `scm-r3-dong-tra-hang-cua-hang-2-3` | 1 | M1 | Viết | Dễ | A1 | sales | Cửa hàng 2 và 3 có dòng trả hàng nào? | Xét các dòng bán của cửa hàng 2 và cửa hàng 3 trong tháng 7/2017. · Lọc các dòng trả hàng (`unit_sales` âm). | sales | thu-tu-and-or |
| `scm-r4-hang-khuyen-mai-ban-chay` | 1 | M1 | Viết | Dễ | A1 | marketing | Mã hàng khuyến mãi nào bán chạy ngày 7/7/2017? | Xét các dòng bán của cửa hàng 44 ngày 7/7/2017 có khuyến mãi (`onpromotion` bằng 1). · Trả về `item_nbr`, `unit_sales`. | sales | quen-dieu-kien-loc, chieu-sap-xep |
| `scm-r5-von-ton-cua-hang-51` | 1 | M1 | Viết | Cơ bản | B4 | finance | Mã nào có vốn tồn lớn nhất ở cửa hàng 51? | Xét tồn kho cuối kỳ 2017-07 của cửa hàng 51. · Trả về `item_nbr`, `on_hand_end`, `von_ton` (lấy từ `inventory_value`). | inventory_snapshots | sai-cot-sap-xep, sai-dinh-dang-ky |
| `scm-r6-giao-dich-cua-hang-24` | 1 | M1 | Viết | Cơ bản | A1 | customer | Cửa hàng 24 đông khách vào ngày nào trong tuần? | Xét cửa hàng 24, từ ngày 3/7/2017 tới hết ngày 9/7/2017 (đủ 7 ngày). · Trả về `date`, `transactions`. | transactions | can-ngay |
| `scm-r7-lo-truot-rau-cu-ra-0` | 1 | M1 | Sửa lỗi | Cơ bản | A2 | after_sales | Lô trượt của nhà cung cấp rau củ ra 0 | Sửa truy vấn dưới đây để đếm đúng số lô trượt của nhà cung cấp `SUP_061`, xét các đơn mua đặt trong năm 2016. · Giữ nguyên cột `so_lo_truot`. | purchase_orders | sai-gia-tri-loc, tu-so-nguong |
| `scm-r8-don-da-nang-thang-7-thieu` | 1 | M1 | Sửa lỗi | Dễ | A2 | customer | Số đơn tới Đà Nẵng tháng 7/2017 bị đếm thiếu | Sửa truy vấn dưới đây để đếm đúng số đơn giao tới thành phố Đà Nẵng (`dest_city`) được tạo trong tháng 7/2017, kể cả đơn huỷ. · Giữ nguyên cột `so_don`. | orders | between-ngay-gio, nham-kho-dich |
| `scm-r9-otif-da-nang-lan-tuan-2016` | 1 | M1 | Sửa lỗi | Dễ | C3 | operations | Chuyến giao không đạt OTIF năm 2017 lẫn tuần 2016 | Sửa truy vấn dưới đây để chỉ lấy các chuyến của những tuần bắt đầu trong năm 2017 (ngày đầu của `week` thuộc năm 2017). · Giữ nguyên các điều kiện còn lại, các cột `shipment_id`, `store_nbr`, `week`, `on_time`, … | shipments | like-hai-dau, nham-otif-voi-dung-han |
| `scm-n1-bien-ln-gop-seafood` | 1 | M2 | Viết | Cơ bản | A2 | finance | Mã hàng SEAFOOD nào có biên lợi nhuận gộp cao? | Xét các mã hàng thuộc ngành `SEAFOOD` trong bảng giá cố định `item_costs`. · Tính biên lợi nhuận gộp của từng mã theo tab Nghiệp vụ, đổi ra phần trăm. | item_costs | sai-mau-so, thu-tu-phep-tinh |
| `scm-n2-hang-chua-ve-thang-8` | 1 | M2 | Viết | Dễ | B4 | operations | Đơn mua đầu tháng 8 còn bao nhiêu hàng chưa về? | Xét các đơn mua của nhà cung cấp `SUP_007` đặt từ ngày 1/8/2017 tới hết ngày 14/8/2017. · Tính `luong_chua_ve` của từng đơn bằng lượng đặt trừ lượng đã nhận; đơn chưa về coi lượng đã nhận bằng 0. | purchase_orders | null-trong-phep-tinh, bang-null, thieu-can-tren |
| `scm-n3-muc-tai-kho-ha-noi` | 1 | M2 | Viết | Dễ | C4 | operations | Kho Hà Nội quá tải những ngày nào tháng 7/2017? | Xét kho `DC_HANOI`, các ngày trong tháng 7/2017. · Gán mức tải theo tỷ lệ tải (`workload_ratio`): lớn hơn 1 là `'qua_tai'`; từ 0,8 tới 1 là `'sat_nguong'`; còn lại là `'binh_thuong'`. | warehouse_daily_ops | thu-tu-case, thieu-can-tren |
| `scm-n4-fill-rate-cua-hang-52` | 1 | M2 | Viết | Dễ | C1 | sales | Mã nào ở cửa hàng 52 thiếu hụt nhiều nhất? | Xét tồn kho kỳ 2017-07 của cửa hàng 52. · Tính fill rate (tỷ lệ lấp đầy) của từng mã hàng theo tab Nghiệp vụ, đổi ra phần trăm. | inventory_snapshots | quy-uoc-sold, thu-tu-phep-tinh |
| `scm-n5-gio-chua-gan-don-hue` | 1 | M2 | Viết | Trung bình | E2 | operations | Đơn nào về kho Huế ngày 7/7 có nhiều giờ chưa gán? | Xét các đơn giao thành công, đặt ngày 7/7/2017, có kho đích là kho vệ tinh ở Huế (lọc theo kho đích; thành phố nhận hàng có thể khác Huế). · Tính tổng năm cột chặng và thời gian chưa gán của từng đơn theo tab Nghiệp vụ. | orders, sorting_hubs | thieu-thanh-phan, don-huy |
| `scm-n6-ngay-cao-diem-gap-doi-2016` | 1 | M2 | Viết | Dễ | C3 | marketing | Ngày cao điểm 2016 nào có nhu cầu gấp đôi? | Xét các ngày cao điểm trong năm 2016. · Tính mức tăng nhu cầu so với ngày nền (phần trăm) từ hệ số nhu cầu `demand_multiplier`, theo tab Nghiệp vụ. | event_calendar | he-so-va-muc-tang, thieu-can-tren |
| `scm-n7-gia-dau-thang-7-thap` | 1 | M2 | Sửa lỗi | Cơ bản | A2 | finance | Giá dầu bình quân tháng 7/2017 thấp bất thường | Sửa truy vấn dưới đây để tính đúng giá dầu WTI bình quân của các ngày có giá trong tháng 7/2017. · Giữ nguyên cột `gia_dau_tb` (làm tròn 2 chữ số). | oil | null-thanh-0 |
| `scm-n8-dung-han-thai-binh-tron` | 1 | M2 | Sửa lỗi | Dễ | A2 | operations | Tỷ lệ giao đúng hạn ở Thái Bình ra số tròn | Sửa truy vấn dưới đây để tính đúng tỷ lệ giao đúng hạn của các đơn có kho đích `HUB_THAIBINH`, đặt trong tháng 7/2017. · Giữ nguyên các cột `so_don`, `so_dung_han`, `ty_le_dung_han_pct` (phần trăm, làm tròn 2 chữ số). | orders | lam-tron-giua-chung, don-huy-trong-mau-so |
| `scm-n9-gio-tre-nam-dinh-am` | 1 | M2 | Sửa lỗi | Trung bình | C3 | customer | Giờ trễ của đơn tới Nam Định ra số âm | Sửa hai lỗi trong truy vấn dưới đây. Kết quả cần liệt kê các đơn tới Nam Định đặt trong tháng 7/2017, đã giao tới khách nhưng trễ so với cam kết. · Tính `so_gio_tre` bằng số giờ giao muộn hơn cam kết (số dương, làm … | orders | dao-phep-tru, don-huy |
| `scm-c1-tu-ap-voucher-huy-don` | 1 | case | Case | Cơ bản | – | marketing | Tự áp voucher có làm khách huỷ đơn ít hơn? | b1 Tỷ lệ huỷ của hai nhóm; b2 Kết luận | orders | b1: gom_theo_co_dung_voucher, thieu_can_tren |
| `scm-c2-thang-ban-nhieu-nhat-2017` | 1 | case | Case | Cơ bản | – | sales | Tháng nào năm 2017 bán được nhiều hàng nhất? | b1 Lượng bán toàn chuỗi theo kỳ; b2 Kết luận | inventory_snapshots | b1: tru_thieu_hut, cong_ton_cuoi_ky |

## Gói 2 · M3 String & Date + M4 Aggregation + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-s1-don-mua-ve-tre-2016` | 2 | M3 | Viết | Cơ bản | A1 | operations | Đơn mua nào về trễ hạn nhất năm 2016? | Xét các đơn mua có `po_date` trong năm 2016 và về sau ngày hẹn giao (`received_date` lớn hơn `promised_date`). · Tính `so_ngay_tre` là số ngày từ `promised_date` tới `received_date` (số dương). | purchase_orders | dao-thu-tu-datediff |
| `scm-s2-ngay-cao-diem-2016` | 2 | M3 | Viết | Cơ bản | A1 | marketing | Ngày cao điểm năm 2016 rơi vào thứ mấy? | Xét các ngày cao điểm có `date` trong năm 2016. · Trả về `event_name`; `ngay` là chuỗi dạng `'dd/mm/yyyy'` (ví dụ `'09/09/2016'`); `thu` là thứ trong tuần dạng số, 1 là Chủ nhật, 2 là thứ Hai, …, 7 là thứ Bảy; `tier`. | event_calendar | sap-theo-chuoi-ngay |
| `scm-s3-lo-truot-thang-3-ra-0` | 2 | M3 | Sửa lỗi | Cơ bản | A2 | after_sales | Tháng 3/2016 không đếm được lô trượt nào | Truy vấn dưới đây đếm số lô trượt có ngày nhận hàng trong tháng 3/2016 nhưng ra 0. Tìm chỗ sai và sửa. · Giữ nguyên cột `so_lo_truot`. | purchase_orders | dinh-dang-thang-sai |
| `scm-s4-don-sau-gio-chot-thang-7` | 2 | M3 | Viết | Cơ bản | A2 | operations | Bao nhiêu đơn tháng 7/2017 tạo sau giờ chốt? | Xét các đơn có `order_date` trong tháng 7/2017 ở mọi kho, gồm cả đơn huỷ. · Đếm các đơn tạo sau giờ chốt, theo tab Nghiệp vụ. | orders | lech-moc-gio, quen-can-tren |
| `scm-s5-ban-theo-thu-cua-hang-44` | 2 | M3 | Viết | Dễ | B1 | sales | Cửa hàng 44 bán BEVERAGES nhiều nhất vào thứ nào? | Xét các dòng bán của cửa hàng 44, ngành hàng `'BEVERAGES'`, từ ngày 1/7/2017 tới hết ngày 31/7/2017. · Tính tổng lượng bán của từng thứ trong tuần cho cả tháng (không chia cho số ngày), theo tab Nghiệp vụ. | sales, items | quen-can-tren |
| `scm-s6-chuyen-giao-tre-quy-2` | 2 | M3 | Viết | Dễ | A1 | operations | Chuyến giao nào trễ hạn trong quý 2/2017? | Xét các chuyến giao có `on_time` bằng 0 và ngày đầu tuần giao từ `'2017-04-01'` tới hết `'2017-06-30'`. · Ngày đầu tuần giao `tuan_bat_dau` là phần trước dấu `/` của cột `week`, giữ dạng chuỗi `'YYYY-MM-DD'`. | shipments, stores | lay-sai-phan-chuoi |
| `scm-s7-gia-tri-nhan-sai-thu-tu` | 2 | M3 | Sửa lỗi | Dễ | B1 | finance | Báo cáo giá trị hàng nhận xếp sai thứ tự tháng | Truy vấn dưới đây tính giá trị hàng nhận theo giá vốn cho từng tháng nhận hàng năm 2016, nhưng các tháng xếp sai thứ tự. · Sửa để `thang` có dạng `'2016-01'` và các dòng xếp đúng thứ tự thời gian. | purchase_orders, item_costs | sap-ten-thang |
| `scm-s8-von-ton-cuoi-ky-2017` | 2 | M3 | Viết | Trung bình | B1 | finance | Vốn tồn cuối mỗi kỳ năm 2017 là bao nhiêu? | Xét các kỳ từ 2017-01 trở đi, chỉ giữ tháng đủ theo tab Nghiệp vụ. · Tính vốn tồn kho cuối kỳ của toàn chuỗi cho từng kỳ, bằng tổng cột `inventory_value` có sẵn (không tính lại từ `on_hand_end` và giá vốn). | inventory_snapshots | thang-chua-du, quen-can-tren |
| `scm-s9-huy-cuoi-tuan-kho-ve-tinh` | 2 | M3 | Sửa lỗi | Dễ | A2 | after_sales | Số đơn cuối tuần ở kho vệ tinh bị lệch | Truy vấn dưới đây tính số đơn, số đơn huỷ và tỷ lệ huỷ của đơn có kho đích là kho vệ tinh, đặt vào thứ Bảy hoặc Chủ nhật trong tháng 6/2017. Kết quả đang sai. · Sửa lại và giữ nguyên cột `so_don`, `so_huy`, … | orders, sorting_hubs | sai-so-thu |
| `scm-a1-dung-han-theo-dc-2016` | 2 | M4 | Viết | Dễ | A3 | operations | DC nào giao đúng hạn tốt nhất năm 2016? | Xét các chuyến giao có ngày đầu tuần giao (phần trước dấu `/` của `week`) trong năm 2016. · Tính cho từng DC số chuyến và tỷ lệ giao đúng hạn, theo tab Nghiệp vụ. | shipments, warehouses | loc-chuoi-tuan |
| `scm-a2-ty-le-lo-truot-100` | 2 | M4 | Sửa lỗi | Dễ | A3 | after_sales | Tỷ lệ lô trượt nhà cung cấp nào cũng 100% | Truy vấn dưới đây tính số lô đã về và tỷ lệ lô trượt năm 2016 (theo ngày nhận hàng) của từng nhà cung cấp thuộc DC `'DC_DANANG'`, nhưng tỷ lệ nào cũng ra 100%. · Sửa để mỗi nhà cung cấp có đúng tỷ lệ lô trượt; giữ … | purchase_orders, suppliers | count-dem-ca-false |
| `scm-a3-voucher-theo-loai-kho` | 2 | M4 | Viết | Dễ | C2 | marketing | Đơn dùng voucher ở kho chính và kho vệ tinh chiếm bao nhiêu? | Xét mọi đơn có `order_date` trong tháng 7/2017. · Tính cho kho chính và kho vệ tinh (cột `role` của kho đích) số đơn, số đơn có voucher và tỷ lệ đơn dùng voucher, theo tab Nghiệp vụ. | orders, sorting_hubs | mau-so-sai, quen-can-tren |
| `scm-a4-cua-hang-vang-khach-2016` | 2 | M4 | Viết | Dễ | C3 | customer | Cửa hàng nào vắng khách năm 2016? | Xét các ngày trong năm 2016. · Tính lượt giao dịch bình quân mỗi ngày của từng cửa hàng, trên các ngày có số liệu giao dịch; chỉ giữ cửa hàng có mức bình quân dưới 1.000. | transactions, stores | where-thay-having |
| `scm-a5-so-ma-ban-cua-hang-44` | 2 | M4 | Sửa lỗi | Dễ | A3 | sales | Số mã hàng có bán ở cửa hàng 44 vượt cả danh mục | Truy vấn dưới đây cần đếm số mã hàng (SKU) khác nhau có dòng bán ở cửa hàng 44 trong tháng 7/2017, theo ngành hàng. · Sửa lại cho đúng; giữ nguyên cột `family`, `so_ma` và thứ tự sắp. | sales, items | dem-dong-thay-vi-ma |
| `scm-a6-dung-han-theo-mien-thap` | 2 | M4 | Sửa lỗi | Dễ | A3 | operations | Tỷ lệ giao đúng hạn theo miền thấp hơn thực tế | Truy vấn dưới đây tính số đơn và tỷ lệ giao đúng hạn theo miền cho đơn chặng cuối đặt trong tháng 7/2017, nhưng chưa đúng định nghĩa ở tab Nghiệp vụ. · Sửa theo đúng định nghĩa đó; giữ nguyên cột `region`, `so_don`, … | orders | tinh-ca-don-huy |
| `scm-a7-don-mien-theo-quy-2016` | 2 | M4 | Viết | Trung bình | A4 | customer | Mỗi miền có bao nhiêu đơn trong từng quý 2016? | Xét các đơn không huỷ, đặt trong năm 2016. · Đếm số đơn của từng miền trong mỗi quý. | orders | count-else-0, tinh-ca-don-huy |
| `scm-a8-bien-ln-gop-nganh-hang` | 2 | M4 | Viết | Trung bình | A3 | finance | Ngành hàng lớn nào có biên lợi nhuận gộp thấp? | Xét kỳ 2017-07. · Tính doanh thu và biên lợi nhuận gộp của từng ngành hàng theo tab Nghiệp vụ; chỉ giữ ngành có doanh thu từ 1.000.000 trở lên. | inventory_snapshots, item_costs | trung-binh-ty-le |
| `scm-a9-ncc-hang-loi-vuot-nguong` | 2 | M4 | Viết | Trung bình | E1 | after_sales | Nhà cung cấp nào có tỷ lệ hàng lỗi vượt 2%? | Xét các đơn mua có ngày nhận hàng trong năm 2016. · Tính tỷ lệ hàng lỗi của từng nhà cung cấp theo tab Nghiệp vụ; chỉ giữ nhà cung cấp có tỷ lệ lớn hơn 2%. | purchase_orders | trung-binh-ty-le, mau-so-sai |
| `scm-c3-kho-giao-tre` | 2 | case | Case | Cơ bản | – | operations | Kho đích nào cần ưu tiên khắc phục giao trễ? | b1 Tỷ lệ trễ theo kho đích; b2 Kết luận | orders | b1: sap_theo_so_don_tre |
| `scm-c4-khuyen-mai-cua-hang-44` | 2 | case | Case | Dễ | – | marketing | Khi có khuyến mãi, lượng bán ở cửa hàng 44 cao hơn bao nhiêu? | b1 Lượng bán bình quân mỗi dòng khi có và không có khuyến mãi; b2 Mức tăng theo ngành hàng; b3 Kết luận | sales, items | b1: quen_can_tren; b2: else_0_trong_avg |

## Gói 3 · M5 Joins + M6 Subqueries + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-j1-ban-theo-loai-cua-hang` | 3 | M5 | Viết | Dễ | A3 | sales | Loại cửa hàng nào bán nhiều nhất tháng 7/2017? | Xét các dòng bán từ ngày 1/7/2017 tới hết ngày 31/7/2017. · Tính số cửa hàng có bán và tổng lượng bán của từng loại cửa hàng (`stores.type`), kể cả dòng trả hàng. | sales, stores | quen-can-tren |
| `scm-j2-ma-chua-tung-dat-mua` | 3 | M5 | Viết | Dễ | E1 | operations | Mã hàng nào chưa từng có đơn mua? | Xét mọi mã hàng trong `items` và mọi đơn mua (PO) trong `purchase_orders`, không giới hạn thời gian. · Đếm cho từng ngành hàng số mã hàng không có đơn mua nào. | items, purchase_orders | inner-join-mat-dong |
| `scm-j3-giao-dich-cua-hang-loai-a` | 3 | M5 | Viết | Dễ | A2 | customer | Cửa hàng loại A có bao nhiêu lượt giao dịch mỗi ngày? | Xét các cửa hàng có `type = 'A'` và các ngày từ 1/7/2017 tới hết 31/7/2017. · Tính lượt giao dịch bình quân của một cửa hàng trong một ngày, theo tab Nghiệp vụ. | transactions, stores | quen-can-tren |
| `scm-j4-ncc-co-lo-truot-theo-dc` | 3 | M5 | Sửa lỗi | Dễ | A3 | after_sales | Số nhà cung cấp có lô trượt lên tới hàng nghìn | Xét các đơn mua đặt trong năm 2016 có kết quả kiểm định là lô trượt. · Sửa truy vấn khởi đầu để đếm đúng số nhà cung cấp (NCC) có ít nhất một lô trượt, theo từng trung tâm phân phối (DC) nhận hàng. | purchase_orders, suppliers | dem-dong-thay-vi-ncc |
| `scm-j5-lead-time-theo-tuyen-kho` | 3 | M5 | Viết | Trung bình | A3 | operations | Tuyến kho nào có lead time dài nhất tháng 7/2017? | Xét các đơn tạo từ ngày 1/7/2017 tới hết ngày 31/7/2017, không tính đơn huỷ. · Tính số đơn và lead time bình quân (giờ, từ lúc tạo đơn tới lúc giao thành công) của từng cặp kho xuất – kho đích. | orders, sorting_hubs | don-huy, noi-mot-lan |
| `scm-j6-bien-ln-gop-nganh-hang` | 3 | M5 | Viết | Trung bình | A3 | finance | Ngành hàng nào có biên lợi nhuận gộp cao nhất? | Xét các dòng bán trong tháng 7/2017, kể cả dòng trả hàng. · Tính doanh thu và biên lợi nhuận gộp của từng ngành hàng, theo tab Nghiệp vụ. | sales, item_costs | quen-can-tren, trung-binh-ty-le |
| `scm-j7-hang-loi-theo-dc-gap-doi` | 3 | M5 | Sửa lỗi | Trung bình | E2 | after_sales | Hàng lỗi theo DC cộng lại bị gấp đôi | Xét các đơn mua đặt trong năm 2016 và đã về kho. · Sửa truy vấn khởi đầu để mỗi đơn mua chỉ tính một lần, vào đúng DC của nhà cung cấp giao đơn đó. | purchase_orders, suppliers | fan-out, noi-sai-cot |
| `scm-j8-ty-trong-ban-khuyen-mai` | 3 | M5 | Viết | Trung bình | A4 | marketing | Ngành hàng nào có tỷ trọng bán khuyến mãi cao nhất? | Xét các dòng bán trong tháng 7/2017. · Tính lượng bán khi mã hàng đang khuyến mãi, lượng bán khi không khuyến mãi, và tỷ trọng lượng bán khuyến mãi trên tổng lượng bán của từng ngành hàng. | sales, items | quen-can-tren, dem-dong |
| `scm-j9-don-mua-thang-7-moi-ncc` | 3 | M5 | Sửa lỗi | Dễ | A3 | operations | Bảng đơn mua tháng 7/2017 thiếu nhà cung cấp | Xét các đơn mua đặt từ ngày 1/7/2017 tới hết ngày 31/7/2017. · Sửa truy vấn khởi đầu để mọi nhà cung cấp trong `suppliers` đều có một dòng; nhà cung cấp không có đơn nào có `so_don` bằng 0. | suppliers, purchase_orders | where-bien-left-join |
| `scm-q1-ncc-lead-time-tren-binh-quan` | 3 | M6 | Viết | Dễ | C3 | operations | Nhà cung cấp nào giao chậm hơn bình quân 2016? | Xét các đơn mua đặt trong năm 2016 và đã về kho. · Tính lead time (thời gian từ khi đặt hàng tới khi nhận hàng) thực tế bình quân, tính bằng ngày, của từng nhà cung cấp và của toàn bộ các đơn đó, theo tab Nghiệp vụ. | purchase_orders | pham-vi-truy-van-con |
| `scm-q2-ncc-co-lo-truot-thang-7` | 3 | M6 | Viết | Dễ | A1 | after_sales | Nhà cung cấp nào có đơn tháng 7/2017 bị trượt? | Xét các đơn mua có ngày đặt (`po_date`) từ 1/7/2017 tới hết 31/7/2017. · Liệt kê nhà cung cấp có ít nhất một lô trượt (`inspection_result = 'Fail'`) trong các đơn đó, mỗi nhà cung cấp một dòng. | suppliers, purchase_orders | join-lap-dong, quen-can-tren |
| `scm-q3-ban-hang-kho-thang-7` | 3 | M6 | Viết | Dễ | A2 | sales | Tháng 7/2017 chuỗi bán được bao nhiêu hàng khô? | Xét các dòng bán từ ngày 1/7/2017 tới hết ngày 31/7/2017 của mã hàng khô (`perishable = 0` trong `items`). · Tính tổng lượng bán, kể cả dòng trả hàng. | sales, items | quen-can-tren |
| `scm-q4-cua-hang-tren-binh-quan-loai` | 3 | M6 | Viết | Trung bình | C3 | sales | Cửa hàng nào bán vượt bình quân cùng loại? | Xét các dòng bán trong tháng 7/2017. · Tính tổng lượng bán của từng cửa hàng và lượng bán bình quân một cửa hàng của từng loại cửa hàng. | sales, stores | chuan-sai-nhom, binh-quan-sai-muc |
| `scm-q5-don-mua-gan-nhat-moi-ncc` | 3 | M6 | Viết | Trung bình | B4 | operations | Đơn gần nhất của mỗi nhà cung cấp về chưa? | Xét mọi đơn mua trong `purchase_orders`, không giới hạn thời gian. · Tìm cho từng nhà cung cấp đúng một đơn mua gần nhất: đơn có `po_date` lớn nhất; nhiều đơn cùng ngày thì lấy đơn có `po_id` lớn nhất. | suppliers, purchase_orders | trung-ngay, max-tung-cot |
| `scm-q6-ty-trong-von-ton-nganh-hang` | 3 | M6 | Viết | Dễ | C2 | finance | Vốn tồn kỳ 2017-07 nằm ở ngành hàng nào? | Xét các dòng tồn kho của kỳ `ym = '2017-07'`. · Tính vốn tồn của từng ngành hàng và tỷ trọng trên tổng vốn tồn của cả kỳ, theo tab Nghiệp vụ. | inventory_snapshots, items | mau-so-sai-ky |
| `scm-q7-ma-khong-ban-duoc-ra-0` | 3 | M6 | Sửa lỗi | Dễ | E1 | sales | Số mã hàng không bán được tháng 7/2017 ra 0 | Xét mọi mã hàng trong `items` và các dòng bán trong tháng 7/2017. · Sửa truy vấn khởi đầu để đếm đúng số mã hàng không có dòng bán nào trong tháng ở bất kỳ cửa hàng nào. | items, sales | tuong-quan-sai-bi-danh |
| `scm-q8-ncc-loi-cao-hon-nganh` | 3 | M6 | Sửa lỗi | Trung bình | C3 | after_sales | Danh sách NCC lỗi cao thiếu ngành hàng ít lỗi | Xét các đơn mua đặt trong năm 2016 và đã về kho. · Sửa truy vấn khởi đầu để giữ lại nhà cung cấp có tỷ lệ hàng lỗi lớn hơn tỷ lệ hàng lỗi của chính ngành hàng mình (tính trên mọi đơn mua năm 2016 đã về của ngành hàng … | purchase_orders, suppliers | thieu-tuong-quan |
| `scm-q9-diem-giao-theo-nhom-gia-tri` | 3 | M6 | Sửa lỗi | Trung bình | C4 | customer | Hai nhóm điểm giao cộng lại vượt tổng số điểm | Xét các đơn tạo trong tháng 7/2017, không tính đơn huỷ. · Xếp mỗi điểm giao vào đúng một nhóm theo giá trị đơn bình quân của điểm đó: `'cao'` khi từ 24 USD trở lên, `'thap'` khi dưới 24 USD. | orders | phan-nhom-sai-muc |
| `scm-c5-dc-nhan-hang-tre` | 3 | case | Case | Dễ | – | operations | Vì sao DC TP.HCM nhận hàng trễ nhiều? | b1 Tỷ lệ giao đúng hạn theo DC năm 2016; b2 Nhà cung cấp của DC TP.HCM; b3 Kết luận | purchase_orders, suppliers | b1: dem_tre_thay_vi_dung_han; b2: quen_loc_nam |
| `scm-c6-cao-diem-giao-tre` | 3 | case | Case | Trung bình | – | marketing | Đơn ngày cao điểm năm 2016 chậm ở chặng nào? | b1 Đơn bình quân và tỷ lệ đúng hạn theo loại ngày; b2 Chặng nào chậm thêm vào ngày cao điểm?; b3 Kho nào phân loại chậm nhất vào ngày cao điểm?; b4 Kết luận | orders, event_calendar, sorting_hubs | b1: inner_join_mat_ngay_thuong; b2: noi_kho_xuat; b3: theo_kho_xuat |

## Gói 4 · M7 CTE & Set Operations + M8 Window Functions + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-t1-ton-tren-ban-nganh-hang` | 4 | M7 | Viết | Trung bình | A3 | sales | Ngành hàng nào tồn nhiều so với lượng bán tháng 7/2017? | Tính tồn cuối kỳ 2017-07 của từng ngành hàng (tổng `on_hand_end`) và lượng bán tháng 7/2017 (tổng `unit_sales`, từ ngày 1 tới hết ngày 31). · Tính tỷ số tồn trên bán theo tab Nghiệp vụ; chỉ giữ ngành hàng có lượng bán … | inventory_snapshots, items, sales | fan-out, quen-can-tren |
| `scm-t2-chuyen-giao-cua-hang-18` | 4 | M7 | Viết | Khó | B1 | operations | Tháng nào năm 2016 cửa hàng 18 không nhận hàng? | Xét các chuyến giao tới cửa hàng 18 có tuần bắt đầu trong năm 2016; tháng của chuyến theo tab Nghiệp vụ. · Trả về đủ 12 dòng: `thang` (chuỗi `'2016-01'` tới `'2016-12'`), `so_chuyen`, `luong_giao` (tổng số lượng giao, … | shipments | thang-trong-bien-mat |
| `scm-t3-ma-hang-can-ra-soat` | 4 | M7 | Viết | Trung bình | A1 | after_sales | Ngành hàng nào có nhiều mã cần rà soát nhất? | Xét các đơn mua đặt từ ngày 01/01/2017 tới hết ngày 30/06/2017. · Đếm mã hàng cần rà soát, là mã có ít nhất một lô trượt hoặc ít nhất một đơn về trễ (`received_date` sau `promised_date`). Mỗi mã chỉ tính một lần. | items, purchase_orders | union-all-dem-trung |
| `scm-t4-ty-le-lo-truot-ncc` | 4 | M7 | Sửa lỗi | Trung bình | A2 | after_sales | Bảng tỷ lệ lô trượt năm 2016 thiếu nhà cung cấp | Truy vấn dưới đây tính cho từng nhà cung cấp số đơn mua đặt trong năm 2016 đã về kho, số lô trượt và tỷ lệ lô trượt, nhưng bỏ sót nhà cung cấp. · Sửa để mọi nhà cung cấp có đơn đã về đều có mặt; nhà cung cấp không có … | purchase_orders | inner-join-mat-dong |
| `scm-t5-nhap-xuat-dc` | 4 | M7 | Sửa lỗi | Khó | E2 | operations | Lượng xuất của DC năm 2016 gấp nhiều lần sổ kho | Truy vấn dưới đây đối chiếu lượng nhập và lượng xuất năm 2016 của từng DC theo tab Nghiệp vụ, nhưng có hai lỗi chồng nhau. Sửa cả hai. · Lượng nhập tính theo ngày nhận hàng trong năm 2016; lượng xuất tính theo tuần bắt … | purchase_orders, suppliers, shipments | fan-out, sai-cot-ngay |
| `scm-t6-von-ton-theo-loai-cua-hang` | 4 | M7 | Sửa lỗi | Trung bình | A3 | finance | Vốn tồn theo loại cửa hàng thấp hơn sổ kế toán | Truy vấn dưới đây hợp vốn tồn của hàng tươi sống và hàng khô kỳ 2017-07, rồi cộng theo loại cửa hàng, nhưng ra thấp hơn tổng vốn tồn thật. · Sửa cho khớp tổng vốn tồn thật; giữ nguyên cột `type`, `von_ton` (làm tròn 0 … | inventory_snapshots, stores, items | union-mat-dong |
| `scm-t7-ncc-duoi-chuan` | 4 | M7 | Viết | Khó | C3 | operations | Nhà cung cấp nào kém chuẩn giao hàng năm 2016? | Xét các đơn mua đặt trong năm 2016 đã về kho. · Liệt kê nhà cung cấp có tỷ lệ giao đúng hạn (OTD) thấp hơn OTD của toàn chuỗi và có lead time (thời gian từ khi đặt hàng tới khi nhận hàng) thực tế bình quân dài hơn lead … | suppliers, purchase_orders | sai-cot-ngay, dung-han-bien |
| `scm-t8-diem-giao-huy-cao` | 4 | M7 | Viết | Trung bình | C3 | customer | Điểm giao nào có tỷ lệ huỷ cao hơn cả miền? | Xét các đơn đặt từ ngày 01/07/2017 tới hết ngày 31/07/2017. · Tính tỷ lệ huỷ của từng điểm giao và của từng miền, theo tab Nghiệp vụ; chỉ giữ điểm giao có tỷ lệ huỷ cao hơn tỷ lệ huỷ của miền tương ứng. | orders | quen-can-tren, chuan-khong-trong-so |
| `scm-t9-huy-theo-nhom-ap-ma` | 4 | M7 | Viết | Trung bình | A2 | marketing | Nhóm áp mã nào huỷ đơn nhiều hơn trong tháng 7/2017? | Xét các đơn đặt từ ngày 01/07/2017 tới hết ngày 31/07/2017. · Tính số đơn, số đơn huỷ và tỷ lệ huỷ cho từng nhóm áp mã, thêm một dòng tổng của cả tháng có `nhom` là `'tong'`. | orders | dong-tong-sai-trong-so, quen-can-tren |
| `scm-f1-top3-hang-tuoi-song` | 4 | M8 | Viết | Trung bình | C1 | sales | Ba mã hàng tươi sống nào bán chạy nhất mỗi ngành? | Xét hàng tươi sống, lượng bán từ ngày 01/07/2017 tới hết ngày 31/07/2017, cộng mọi cửa hàng. · Xếp hạng mã hàng trong từng ngành hàng theo tổng `unit_sales` giảm dần; lấy đúng 3 mã mỗi ngành. | sales, items | trung-hang |
| `scm-f2-fill-rate-theo-thang` | 4 | M8 | Viết | Trung bình | B2 | operations | Fill rate từng tháng năm 2017 thay đổi ra sao? | Xét các kỳ tháng đủ từ 2017-01 tới 2017-07. · Tính fill rate của từng kỳ theo tab Nghiệp vụ, và chênh lệch so với kỳ liền trước (điểm phần trăm). | inventory_snapshots | thang-chua-du, trung-binh-ty-le |
| `scm-f3-luy-ke-cua-hang-44` | 4 | M8 | Viết | Trung bình | B3 | sales | Cửa hàng 44 đạt chỉ tiêu tháng 7/2017 tới đâu? | Xét lượng bán của cửa hàng 44 từ ngày 01/07/2017 tới hết ngày 31/07/2017. · Tính lượng bán từng ngày và lượng bán luỹ kế từ đầu tháng tới hết ngày đó. | sales | quen-can-tren |
| `scm-f4-ngay-don-tang-dot-bien` | 4 | M8 | Viết | Khó | B3 | marketing | Ngày nào quý 4/2016 có số đơn tăng đột biến? | Xét đơn không huỷ; mỗi ngày từ 01/10/2016 tới 31/12/2016 là một dòng. · Lấy mức nền của một ngày bằng trung bình số đơn của 7 ngày liền trước, không gồm ngày đó; các ngày đầu tháng 10 vẫn lấy đủ 7 ngày liền trước, kể … | orders | khung-gom-ngay-hien-tai, loc-truoc-khi-truot |
| `scm-f5-hang-abc-beverages` | 4 | M8 | Viết | Khó | C2 | finance | Mỗi hạng ABC của ngành BEVERAGES có bao nhiêu mã? | Xét mã hàng ngành `'BEVERAGES'` có tổng lượng bán dương từ ngày 01/07/2017 tới hết ngày 31/07/2017. · Xếp hạng ABC theo tab Nghiệp vụ; tỷ trọng luỹ kế của một mã gồm cả doanh thu của chính mã đó. | sales, item_costs | quen-can-tren, sap-sai-chieu |
| `scm-f6-giao-dich-cung-ky` | 4 | M8 | Viết | Khó | B2 | customer | Lượt giao dịch năm 2017 tăng bao nhiêu so cùng kỳ? | Tính tổng lượt giao dịch theo loại cửa hàng và tháng. · Chỉ tính cửa hàng có giao dịch ở cả tháng 1/2016 và tháng 7/2017 (tăng trưởng cùng cửa hàng). | transactions, stores | lag-sai-buoc, loc-truoc-khi-lag |
| `scm-f7-cua-hang-dong-khach-nhat` | 4 | M8 | Sửa lỗi | Trung bình | C1 | customer | Danh sách cửa hàng đông khách nhất chỉ ra một dòng | Truy vấn dưới đây cần trả về cửa hàng có tổng lượt giao dịch tháng 7/2017 cao nhất của từng loại cửa hàng, nhưng chỉ ra một dòng. · Sửa để mỗi loại cửa hàng có đúng một cửa hàng; hai cửa hàng bằng nhau thì `store_nbr` … | transactions, stores | thieu-partition-by |
| `scm-f8-luy-ke-nhan-hang-ncc` | 4 | M8 | Sửa lỗi | Khó | B3 | operations | Luỹ kế nhận hàng tháng 7/2017 lệch phiếu nhập | Truy vấn dưới đây liệt kê đơn mua của ba nhà cung cấp `'SUP_027'`, `'SUP_053'`, `'SUP_063'` nhận hàng trong tháng 7/2017, kèm lượng nhận luỹ kế, nhưng có hai lỗi chồng nhau. Sửa cả hai. · Luỹ kế tính riêng cho từng nhà … | purchase_orders | khung-range-mac-dinh, sai-cot-ngay |
| `scm-f9-huy-thang-truoc-theo-kho` | 4 | M8 | Sửa lỗi | Trung bình | B2 | after_sales | Mức thay đổi tỷ lệ huỷ tháng 1 của các kho bị sai | Truy vấn dưới đây tính tỷ lệ huỷ của từng kho đích theo tháng, từ tháng 1 tới tháng 7/2017, và mức thay đổi so với tháng trước. Tháng 1 của nhiều kho ra số lạ. · Sửa để mỗi kho chỉ so với tháng trước của chính nó; … | orders | thieu-partition-by |
| `scm-c7-fill-rate-thang-3` | 4 | case | Case | Trung bình | – | operations | Vì sao fill rate tháng 3/2017 giảm mạnh? | b1 Fill rate và tỷ lệ dòng thiếu hụt từng kỳ; b2 Ngành hàng nào thiếu hụt tăng nhiều nhất?; b3 Bán tăng hay nhập giảm?; b4 Kết luận | inventory_snapshots, items | b1: gom_ca_ky_chua_du; b2: lay_tong_thieu_hut_thang_3; b3: khong_chia_so_ngay |
| `scm-c8-giao-tre-ngay-cao-diem` | 4 | case | Case | Khó | – | marketing | Vì sao ngày cao điểm năm 2016 giao trễ nhiều? | b1 Ngày cao điểm giao đúng hạn kém bao nhiêu?; b2 Chặng nào chậm thêm?; b3 Kho đích nào phân loại chậm vào ngày cao điểm?; b4 Kho có quá tải vào ngày cao điểm không?; b5 Kết luận | orders, event_calendar, warehouse_daily_ops | b1: tinh_ca_don_huy |

## Gói 5 · M9 Data Quality + M10 Query Performance + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-k1-ban-khong-co-ton-kho` | 5 | M9 | Viết | Dễ | E2 | sales | Mã hàng nào có bán nhưng thiếu số tồn kho kỳ 2017-07? | Xét các dòng bán của tháng 7/2017 trong `sales` (từ `'2017-07-01'` tới trước `'2017-08-01'`). · Tìm các cặp (`store_nbr`, `item_nbr`) có dòng bán nhưng không có dòng nào trong `inventory_snapshots` ở kỳ `'2017-07'`. | inventory_snapshots, sales | dieu-kien-noi-dat-o-where |
| `scm-k2-ngay-le-ghi-hai-dong` | 5 | M9 | Viết | Trung bình | E1 | marketing | Ngày nào có hai dòng lễ ở cùng địa phương? | Xét toàn bộ bảng `holidays`. Khoá nghiệp vụ của một ngày lễ là cặp (ngày, địa phương `locale_name`). · Tìm các cặp có từ hai dòng trở lên. | holidays | chon-sai-khoa-nghiep-vu |
| `scm-k3-co-dung-han-mau-thuan` | 5 | M9 | Sửa lỗi | Trung bình | E1 | customer | Kiểm tra cờ đúng hạn báo nhầm đơn | Truy vấn dưới đây tìm các đơn không huỷ có `on_time` mâu thuẫn với quy tắc đúng hạn trong tab Nghiệp vụ, nhưng ra sai danh sách. Sửa cho đúng. · Giữ nguyên các cột `order_id`, `order_date`, `lead_time_total_h`, … | orders | so-sanh-bien |
| `scm-k4-giao-dich-thap-bat-thuong` | 5 | M9 | Viết | Trung bình | E1 | customer | Lượt giao dịch thấp bất thường vào ngày nào? | Xét toàn bộ bảng `transactions`. Mức thường thấy của một cửa hàng là lượt giao dịch trung bình mỗi ngày của chính cửa hàng đó trên toàn bộ dữ liệu. · Tìm các ngày có lượt giao dịch nhỏ hơn 20% mức thường thấy của cửa … | transactions | chuan-ca-chuoi |
| `scm-k5-tuan-khong-co-chuyen-giao` | 5 | M9 | Viết | Trung bình | D3 | operations | Cửa hàng nào có tuần không nhận chuyến giao nào? | Xét bảng `shipments`: mỗi dòng là chuyến giao của một tuần cho một cửa hàng; `week` có dạng `'YYYY-MM-DD/YYYY-MM-DD'`, mười ký tự đầu là ngày thứ Hai của tuần. · Lấy tuần đầu và tuần cuối có chuyến giao của từng cửa … | shipments | moc-dau-chung |
| `scm-k6-doi-soat-don-can-xu-ly` | 5 | M9 | Viết | Khó | E2 | operations | Đơn cần xử lý của kho có khớp sổ đơn? | So số đơn cần xử lý của từng kho trong từng ngày ở bảng vận hành kho với số đơn đếm từ sổ đơn, theo hai cách: tính mọi đơn và chỉ tính đơn không huỷ. · Ngày kho có dòng vận hành mà sổ đơn không có đơn nào thì số đơn … | warehouse_daily_ops, orders | inner-join-mat-ngay, sai-kho |
| `scm-k7-doi-soat-nhan-su` | 5 | M9 | Sửa lỗi | Trung bình | E2 | operations | Đối soát nhân sự kho ra số ngày quá lớn | Truy vấn dưới đây so `headcount` của `warehouse_daily_ops` với `headcount_thuc_te` của `staffing_plan` cho từng kho, các ngày năm 2016, nhưng số ngày ra quá lớn. Tìm chỗ sai và sửa. · Giữ nguyên các cột `hub_id`, … | warehouse_daily_ops, staffing_plan | thieu-khoa-noi |
| `scm-k8-ban-hai-nguon-lech` | 5 | M9 | Sửa lỗi | Khó | E2 | sales | Lượng bán tháng 7 của hai nguồn lệch rất xa | Truy vấn dưới đây cho số sai. Sửa để mỗi cửa hàng loại A có một dòng đối soát lượng bán tháng 7/2017 giữa `sales` và kỳ `'2017-07'` của `inventory_snapshots`. · Mỗi nguồn tính trên toàn bộ dòng của chính nó: … | sales, stores, inventory_snapshots | fan-out, quen-can-tren |
| `scm-k9-doanh-thu-hai-nguon` | 5 | M9 | Viết | Khó | E2 | finance | Ngành hàng nào có doanh thu hai nguồn lệch nhau nhiều nhất? | Tính doanh thu tháng 7/2017 của từng ngành hàng theo hai nguồn, cùng nhân với giá bán đơn vị: lượng bán hằng ngày tháng 7/2017 và lượng bán kỳ 2017-07 của báo cáo tồn kho. · Trả về `family`, `dt_sales`, `dt_ton_kho`, … | sales, items, item_costs, inventory_snapshots | gia-von-thay-gia-ban, quen-loc-ky |
| `scm-p1-po-theo-kiem-dinh` | 5 | M10 | Tối ưu | Cơ bản | A2 | after_sales | Đơn mua theo kết quả kiểm định với một lần quét | Giữ nguyên kết quả: một dòng, ba cột `so_lo_dat`, `so_lo_truot`, `so_chua_ve` là số đơn mua đặt trong năm 2017 có `inspection_result` lần lượt bằng `'Pass'`, `'Fail'`, `'Pending'`. | purchase_orders | quet-lai-bang |
| `scm-p2-don-kho-ve-tinh-theo-nam` | 5 | M10 | Tối ưu | Dễ | B1 | after_sales | Tỷ lệ huỷ đơn của kho vệ tinh theo năm chỉ với một lần quét | Giữ nguyên kết quả: `nam` (số), `so_don`, `ty_le_huy_pct` (phần trăm, làm tròn 2 chữ số) của các đơn giao tới kho có `role = 'kho vệ tinh'`, năm 2015 tới 2017; sắp theo `nam`. | orders, sorting_hubs | union-all-lap |
| `scm-p3-ncc-cham-hon-nganh` | 5 | M10 | Tối ưu | Trung bình | C3 | operations | Nhà cung cấp chậm hơn mức ngành chỉ với một lần quét | Giữ nguyên kết quả. Phạm vi: đơn mua đặt năm 2016 đã về. · Cột: `family`, `supplier_id`, `lt_tb` (lead time trung bình của nhà cung cấp, ngày), `tb_nganh` (trung bình các `lt_tb` của ngành hàng); cả hai làm tròn 2 chữ … | purchase_orders, suppliers | tinh-lai-cte |
| `scm-p4-ty-trong-von-ton-nganh` | 5 | M10 | Tối ưu | Trung bình | C2 | finance | Tỷ trọng vốn tồn theo ngành hàng chỉ với một lần quét | Giữ nguyên kết quả. Phạm vi: kỳ tồn kho mới nhất có trong bảng (giá trị `ym` lớn nhất), để báo cáo tự sang kỳ mới khi có số liệu. · Cột: `family`, `von_ton` (vốn tồn kho của kỳ đó, làm tròn 0 chữ số), `ty_trong_pct` … | inventory_snapshots, items | quet-lai-de-lay-tong |
| `scm-p5-luy-ke-giao-dich-thang-7` | 5 | M10 | Tối ưu | Khó | B3 | customer | Luỹ kế giao dịch tháng 7 không tự nối bảng | Giữ nguyên kết quả: mỗi cửa hàng, mỗi ngày của tháng 7/2017 một dòng, gồm `store_nbr`, `ngay`, `giao_dich` (lượt giao dịch của ngày), `luy_ke` (cộng dồn từ ngày 1/7 tới ngày đó của cửa hàng). · Sắp theo `store_nbr`, … | transactions | tu-noi-bang |
| `scm-p6-don-truot-7-ngay` | 5 | M10 | Tối ưu | Khó | B3 | operations | Tổng đơn cần xử lý 7 ngày gần nhất chỉ với một lần quét | Giữ nguyên kết quả: mỗi kho, mỗi ngày năm 2016 một dòng, gồm `hub_id`, `ngay`, `don_can_xu_ly`, `don_7_ngay` (tổng đơn cần xử lý của ngày đó và sáu ngày liền trước, kể cả ngày cuối năm 2015). · Sắp theo `hub_id`, rồi … | warehouse_daily_ops | tu-noi-bang, loc-truoc-cua-so |
| `scm-p7-ty-le-dung-han-sau-khi-gop` | 5 | M10 | Sửa lỗi | Trung bình | A2 | operations | Tỷ lệ giao đúng hạn theo miền lệch báo cáo cũ | Truy vấn dưới đây tính cho từng miền, đơn đặt trong tháng 7/2017: `so_don` (mọi đơn), `ty_le_huy_pct`, `ty_le_dung_han_pct` (theo tab Nghiệp vụ). Riêng cột cuối lệch báo cáo cũ; sửa cột này. · Giữ nguyên tên cột, làm … | orders | gop-sai-mau-so |
| `scm-p8-voucher-dem-hai-lan` | 5 | M10 | Sửa lỗi | Trung bình | A3 | marketing | Đơn có voucher bị đếm hai lần sau khi sửa báo cáo | Truy vấn dưới đây lấy các đơn đặt trong tháng 7/2017 giao tới kho `'HUB_HUE'` hoặc có khách tự áp voucher (`voucher_manually_applied = 1`), rồi đếm theo kho đích, nhưng ra sai. Sửa lại nhưng vẫn giữ cách tách hai … | orders | union-all-dem-trung |
| `scm-p9-bao-cao-kho-thang-7` | 5 | M10 | Viết | Khó | A3 | operations | Từng kho vận hành ra sao trong tháng 7/2017? | Tính cho từng kho trong danh sách kho, tháng 7/2017: số đơn có kho đích là kho đó (kể cả đơn huỷ), tỷ lệ huỷ, lead time trung bình của đơn không huỷ, số ngày quá tải theo tab Nghiệp vụ. · Trả về `hub_id`, `role`, … | sorting_hubs, orders, warehouse_daily_ops | fan-out, lead-time-gom-don-huy |
| `scm-c9-kho-ha-noi-qua-tai` | 5 | case | Case | Khó | – | operations | Vì sao kho Hà Nội quá tải năm 2016? | b1 Kho nào quá tải nhiều nhất năm 2016?; b2 Quá tải có tập trung ở ngày cao điểm?; b3 Ngày quá tải khác ngày không quá tải ở đơn hay ở người?; b4 Số nhân sự của hai nguồn có khớp nhau?; b5 Kết luận | warehouse_daily_ops, event_calendar, staffing_plan | b1: nguong_0_9; b2: inner_join_chi_con_ngay_cao_diem; b3: quen_loc_kho; b4: noi_thieu_ngay |
| `scm-c10-do-dung-hoc-tap-thieu-hut` | 5 | case | Case | Khó | – | sales | Vì sao đồ dùng học tập thiếu hụt tháng 7/2017? | b1 Ngành hàng nào có fill rate (tỷ lệ lấp đầy) thấp nhất kỳ 2017-07?; b2 Nhà cung cấp có giao trễ, giao thiếu không?; b3 Lượng nhập có theo kịp lượng bán không?; b4 Lượng đặt mỗi tháng gần với lượng bán của tháng nào?; … | inventory_snapshots, items, purchase_orders | b1: trung_binh_ty_le_tung_dong; b2: tinh_ca_don_chua_ve; b3: lay_ca_ky_chua_du; b4: noi_truoc_khi_gom |

## Thống kê (đếm từ bảng trên)

**Hình thức:** write 55 · debug 29 · optimize 6 · case 10 = 100. **Cấp:** basic 15 · easy 33 · medium 36 · hard 16.

### Hình thức × cấp

| Hình thức | basic | easy | medium | hard | Cộng |
|---|---:|---:|---:|---:|---:|
| write | 8 | 19 | 20 | 8 | 55 |
| debug | 3 | 11 | 12 | 3 | 29 |
| optimize | 1 | 1 | 2 | 2 | 6 |
| case | 3 | 2 | 2 | 3 | 10 |
| **Cộng** | 15 | 33 | 36 | 16 | 100 |

### Theo module: cấp và hình thức

| Module | basic | easy | medium | hard | write | debug | optimize | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| M1 Retrieval | 5 | 4 | · | · | 6 | 3 | · | 9 |
| M2 NULL & Expressions | 2 | 5 | 2 | · | 6 | 3 | · | 9 |
| M3 String & Date | 4 | 4 | 1 | · | 6 | 3 | · | 9 |
| M4 Aggregation | · | 6 | 3 | · | 6 | 3 | · | 9 |
| M5 Joins | · | 5 | 4 | · | 6 | 3 | · | 9 |
| M6 Subqueries | · | 5 | 4 | · | 6 | 3 | · | 9 |
| M7 CTE & Set Operations | · | · | 6 | 3 | 6 | 3 | · | 9 |
| M8 Window Functions | · | · | 5 | 4 | 6 | 3 | · | 9 |
| M9 Data Quality | · | 1 | 5 | 3 | 6 | 3 | · | 9 |
| M10 Query Performance | 1 | 1 | 4 | 3 | 1 | 2 | 6 | 9 |
| Case | 3 | 2 | 2 | 3 | · | · | · | 10 |

### Theo gói

| Gói | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 12 | 6 | · | 2 | 9 | 9 | 2 | · |
| 2 | 12 | 6 | · | 2 | 5 | 11 | 4 | · |
| 3 | 12 | 6 | · | 2 | · | 11 | 9 | · |
| 4 | 12 | 6 | · | 2 | · | · | 12 | 8 |
| 5 | 7 | 5 | 6 | 2 | 1 | 2 | 9 | 8 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | sales | marketing | customer | operations | finance | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 Tra cứu lọc | 2 | 2 | 1 | 2 | · | 2 | 9 |
| A2 KPI | 1 | 1 | 2 | 3 | 2 | 5 | 14 |
| A3 Phân rã | 3 | 1 | · | 5 | 3 | 2 | 14 |
| A4 Bảng chéo | · | 1 | 1 | · | · | · | 2 |
| B1 Xu hướng | 1 | · | · | 1 | 2 | 1 | 5 |
| B2 So kỳ trước | · | · | 1 | 1 | · | 1 | 3 |
| B3 Luỹ kế, trượt | 1 | 1 | 1 | 2 | · | · | 5 |
| B4 Trạng thái tại thời điểm | · | · | · | 2 | 1 | · | 3 |
| C1 Top N mỗi nhóm | 2 | · | 1 | · | · | · | 3 |
| C2 Tỷ trọng | · | 1 | · | · | 3 | · | 4 |
| C3 So với chuẩn | 1 | 1 | 3 | 4 | · | 1 | 10 |
| C4 Phân khúc | · | · | 1 | 1 | · | · | 2 |
| D1 Phễu | · | · | · | · | · | · | 0 |
| D2 Cohort | · | · | · | · | · | · | 0 |
| D3 Chuỗi liên tiếp | · | · | · | 1 | · | · | 1 |
| E1 Bất thường | 1 | 1 | 2 | 1 | · | 2 | 7 |
| E2 Đối soát | 2 | · | · | 4 | 1 | 1 | 8 |
| E3 Cấu trúc cây | · | · | · | · | · | · | 0 |
| **Cộng** | 14 | 9 | 13 | 27 | 12 | 15 | 90 |

Dạng có câu: 15/18; chưa có: D1, D2, E3; chỉ 1 câu: D3.

Mảng trên cả 100 câu (gồm case): sales 16, marketing 13, customer 13, operations 31, finance 12, after_sales 15.

### Kiểm khung phân bổ

Lệch khung (module 9 câu: M1–M9 6 write + 3 debug, M10 ~6 optimize; cấp M1–3 basic/easy, M4–6 easy/medium, M7–10 medium/hard; case gói 1 → 5: basic+basic, basic+easy, easy+medium, medium+hard, hard+hard):

- `scm-n5-gio-chua-gan-don-hue` (M2) cấp medium, ngoài khung basic / easy.
- `scm-n9-gio-tre-nam-dinh-am` (M2) cấp medium, ngoài khung basic / easy.
- `scm-s8-von-ton-cuoi-ky-2017` (M3) cấp medium, ngoài khung basic / easy.
- `scm-k1-ban-khong-co-ton-kho` (M9) cấp easy, ngoài khung medium / hard.
- `scm-p1-po-theo-kiem-dinh` (M10) cấp basic, ngoài khung medium / hard.
- `scm-p2-don-kho-ve-tinh-theo-nam` (M10) cấp easy, ngoài khung medium / hard.

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: không có.

Ô trùng **giữa các gói** (4 ô; cho phép, ghi để tham khảo): 
- A2 · after_sales · basic · debug: `scm-r7-lo-truot-rau-cu-ra-0`, `scm-s3-lo-truot-thang-3-ra-0`
- A3 · after_sales · easy · debug: `scm-a2-ty-le-lo-truot-100`, `scm-j4-ncc-co-lo-truot-theo-dc`
- A3 · operations · easy · debug: `scm-a6-dung-han-theo-mien-thap`, `scm-j9-don-mua-thang-7-moi-ncc`
- A3 · finance · medium · write: `scm-a8-bien-ln-gop-nganh-hang`, `scm-j6-bien-ln-gop-nganh-hang`

### Chênh lệch so với bản đồ bản 1 (phân bổ gốc)

So 100 dòng của bản 1 với 100 câu thật: 0 mã khác, 0 câu đổi hình thức/cấp/dạng/mảng, 29 câu đổi tiêu đề (không liệt kê).

| | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Bản 1 | 55 | 29 | 6 | 10 | 15 | 33 | 36 | 16 |
| Bản 2 (thật) | 55 | 29 | 6 | 10 | 15 | 33 | 36 | 16 |

## Ghi chú giữ từ bản 1

_Giữ nguyên văn để không mất ý của người lập bản 1; số liệu trong các đoạn này có thể đã cũ, đối chiếu bảng và thống kê ở trên._

### Đề xuất cho vòng duyệt

- Ô trùng giữa các gói: giữ câu của gói đứng trước trên lộ trình, câu của gói sau đổi mảng hoặc dạng khi sửa v2. `scm-a8` và `scm-j6` trùng cả chủ đề (biên lợi nhuận gộp theo ngành hàng), nên đổi hẳn chủ đề một câu. `scm-r7` (gói 1) và `scm-s3` (gói 2) cùng triệu chứng “số lô trượt ra 0” với hai bẫy khác nhau (giá trị chữ, định dạng tháng); đề xuất `scm-s3` chuyển bẫy định dạng tháng sang bảng khác (ví dụ `orders` hoặc `shipments`).
- Dạng chưa có câu, đều làm được trên cửa sổ dữ liệu: D1 phễu (đơn mua đặt → đã về → lô đạt, theo nhà cung cấp, M4 hoặc M7); D2 cohort (mã hàng theo kỳ đầu tiên có bán trong 2017-01 tới 2017-07 và tỷ lệ còn bán ở kỳ sau, M8); E3 cấu trúc cây (kho chính và kho vệ tinh qua `sorting_hubs.dc_parent`, `WITH RECURSIVE`, M7).
- Mảng `operations` chiếm nhiều nhất vì bộ dữ liệu thiên về kho, giao hàng và nhà cung cấp; `marketing` và `finance` ít nhất. Khi sửa v2 có thể chuyển một số câu về chi phí (vốn tồn, tiền thuê trên lượt giao dịch, doanh thu) sang `finance`.
