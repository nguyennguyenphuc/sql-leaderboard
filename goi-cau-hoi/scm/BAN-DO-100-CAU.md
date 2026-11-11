# Bản đồ 100 câu · bộ Supply Chain (`scm`)

**Bản 2 · sinh lại 10/11/2026 từ file thật** (`goi-*/cau-hoi.tex`, `goi-*/solution.sql`): mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá của `\begin{cauhoi}`; gói theo thư mục; module theo tiền tố mã (r n s a j q t f k p = M1…M10, c = case). Cột “Đề một câu” là mục đầu của `yeucau` (case: tên các bước); “Bảng” lấy từ `FROM`/`JOIN` của lời giải (bỏ CTE); “Bẫy chính” là khoá `bay` (case: tên bài sai theo bước). Phần mở đầu giữ từ bản 1; thống kê và chênh lệch so với bản 1 ở cuối file.

Cập nhật 10/11/2026 19:20 (giờ Việt Nam). Người lập: A (người soạn gói 1). Trạng thái: chờ giảng viên duyệt cùng lô thử gói 1. Cập nhật v3 10/11/2026 (QUYET-DINH-126): `scm-j6` đổi mã và nội dung sang `scm-j6-gmroi-theo-loai-cua-hang` (C4 · finance); `scm-k3`, `scm-p7` hạ Dễ; `scm-a3` đổi chỉ số sang nhóm `'manual'`.

Cập nhật v4 gói 3 (11/11/2026, BRIEF-CAP-DO-MODULE): M5 và M6 mỗi module đủ 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Đổi cấp 8 câu: `scm-j3` → `scm-j3-giao-dich-loai-a-ngay-15-7` (Cơ bản), `scm-j9` (Cơ bản), `scm-j6` → `scm-j6-doanh-thu-m2-theo-loai-cua-hang` (Khó), `scm-j8` → `scm-j8-giao-dich-ngay-le-dia-phuong` (Khó), `scm-q3` → `scm-q3-hang-tuoi-song-cua-hang-44` (Cơ bản), `scm-q6` → `scm-q6-ty-trong-von-ton-cua-hang-45` (Cơ bản), `scm-q5` → `scm-q5-don-da-ve-gan-nhat-moi-ncc` (Khó), `scm-q8` (Khó). Đã sửa dòng của gói 3, dòng M5, M6 và dòng gói 3 trong thống kê; các tổng của cả bộ (hình thức × cấp, phủ dạng × mảng) chưa đếm lại vì các gói khác đang sửa song song.

Phân bổ đã duyệt: gói k = module 2k−1 và 2k (9 câu mỗi module) + 2 case (gói 1: 2 Cơ bản; gói 2: Cơ bản, Dễ; gói 3: Dễ, Trung bình; gói 4: Trung bình, Khó; gói 5: 2 Khó). Module 1–9 khoảng 6 `write` + 3 `debug`; module 10 khoảng 6 `optimize` + 3 `write`/`debug`. Cấp tăng theo module: M1–3 Cơ bản/Dễ, M4–6 Dễ/Trung bình, M7–10 Trung bình/Khó, mỗi module có ít nhất một câu ở cấp thấp nhất của nó.

Nguồn của bảng: gói 1 do A soạn (khớp `goi-1/cau-hoi.tex`). Gói 2–5 do bốn người soạn khác làm song song, chưa có bản đồ chung lúc soạn nên mỗi gói tự phân bổ theo `BRIEF-SOAN-GOI.md`; bảng dưới đọc thẳng từ `cau-hoi.tex` và `solution.sql` của từng gói tại thời điểm cập nhật (mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá câu; bảng dùng lấy từ `FROM`/`JOIN` của lời giải; bẫy chính lấy từ cột bẫy của `ho-so/goi-<k>/BAN-DO-GOI.md`, gói 2 do A tóm tắt từ khoá `bay` và tên bài sai). Mọi câu đã chạy thật trên MySQL `scm` và `scm_hidden_1` bằng bộ kiểm của từng gói, nên khả thi trên cửa sổ dữ liệu (`sales` chỉ tháng 7/2017; `inventory_snapshots` kỳ 2017-01 tới 2017-08; `orders` 8/2015 tới 8/2017; `purchase_orders` 2013 tới 8/2017). Gói nào sửa câu thì cập nhật lại bảng này.

Cột “Đề một câu”: gói 1 do A viết; gói 2–5 lấy câu yêu cầu chính trong lời nhắn của bối cảnh (câu Viết, Case) hoặc dòng yêu cầu chính (câu Sửa lỗi, Tối ưu); chín câu mà câu trong lời nhắn chưa đủ nghĩa được A viết lại từ phần yêu cầu.

## Gói 1 · M1 Retrieval + M2 NULL & Expressions + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-r1-cua-hang-tphcm` | 1 | M1 | Viết | Cơ bản | A1 | sales | Cửa hàng nào đặt tại TP.HCM? | Xét các cửa hàng có thành phố (cột `city`) là TP.HCM. · Trả về `store_nbr`, `type`, `cluster`. | stores | sai-cot-loc, sai-ky-tu |
| `scm-r2-lo-truot-ve-tre-rau-cu-thang-7` | 1 | M1 | Viết | Trung bình | C3 | after_sales | Đơn mua rau củ nào về trễ và trượt kiểm định tháng 7/2017? | Xét các đơn mua của hai nhà cung cấp ngành `PRODUCE` (rau củ quả), có ngày nhận hàng trong tháng 7/2017. · Lọc các đơn vừa về trễ so với ngày hẹn giao (theo tab Nghiệp vụ) vừa là lô trượt. | purchase_orders | nham-ngay-dat-ngay-nhan, bien-ngay-hen, thieu-nha-cung-cap |
| `scm-r3-dong-tra-hang-cua-hang-2-3` | 1 | M1 | Viết | Dễ | A1 | sales | Cửa hàng 2 và 3 có dòng trả hàng nào? | Xét các dòng bán của cửa hàng 2 và cửa hàng 3 trong tháng 7/2017. · Lọc các dòng trả hàng (`unit_sales` âm). | sales | thu-tu-and-or |
| `scm-r4-hang-khuyen-mai-ban-chay` | 1 | M1 | Viết | Dễ | A1 | marketing | Mã hàng khuyến mãi nào bán chạy ngày 7/7/2017? | Xét các dòng bán của cửa hàng 44 ngày 7/7/2017 có khuyến mãi (`onpromotion` bằng 1). · Trả về `item_nbr`, `unit_sales`. | sales | quen-dieu-kien-loc, chieu-sap-xep |
| `scm-r5-hang-dong-von-cum-14-ha-noi` | 1 | M1 | Viết | Trung bình | B4 | finance | Mã nào đọng vốn ở cửa hàng cụm 14 Hà Nội kỳ 2017-07? | Xét tồn kho kỳ 2017-07 của các cửa hàng thuộc cụm 14 đặt tại Hà Nội. · Lọc các dòng hàng đọng vốn (theo tab Nghiệp vụ) có vốn tồn từ 1.000 trở lên. | inventory_snapshots | cum-nhieu-thanh-pho, sai-cot-nguong |
| `scm-r6-ngay-ban-manh-ba-ma-do-uong` | 1 | M1 | Viết | Khó | E1 | sales | Ngày nào ba mã đồ uống bán mạnh không nhờ khuyến mãi? | Xét ba mã hàng ngành `BEVERAGES` (đồ uống) 2042941, 2042947 và 1047679 của cửa hàng 44 trong tháng 7/2017. · Liệt kê những ngày mỗi mã bán mạnh không nhờ khuyến mãi, theo tab Nghiệp vụ. | sales | quen-loai-khuyen-mai, thu-tu-and-or, thieu-can-tren |
| `scm-r7-lo-truot-rau-cu-ra-0` | 1 | M1 | Sửa lỗi | Cơ bản | A2 | after_sales | Lô trượt của nhà cung cấp rau củ ra 0 | Sửa truy vấn dưới đây để đếm đúng số lô trượt của nhà cung cấp `SUP_061`, xét các đơn mua đặt trong năm 2016. · Giữ nguyên cột `so_lo_truot`. | purchase_orders | sai-gia-tri-loc, tu-so-nguong |
| `scm-r8-don-mua-do-uong-cho-hang-thang-8` | 1 | M1 | Sửa lỗi | Khó | A2 | operations | Số đơn mua đồ uống chờ hàng tháng 8/2017 lớn bất thường | Truy vấn dưới đây đếm số đơn mua đang chờ hàng của hai nhà cung cấp ngành `BEVERAGES` (đồ uống), đặt trong tháng 8/2017, nhưng có hai lỗi chồng nhau. Sửa cả hai. · Xác định đơn chờ hàng theo tab Nghiệp vụ. | purchase_orders | thu-tu-and-or, thieu-can-tren |
| `scm-r9-otif-da-nang-lan-tuan-2016` | 1 | M1 | Sửa lỗi | Dễ | C3 | operations | Chuyến giao không đạt OTIF năm 2017 lẫn tuần 2016 | Sửa truy vấn dưới đây để chỉ lấy các chuyến của những tuần bắt đầu trong năm 2017 (ngày đầu của `week` thuộc năm 2017). · Giữ nguyên các điều kiện còn lại, các cột `shipment_id`, `store_nbr`, `week`, `on_time`, … | shipments | like-hai-dau, nham-otif-voi-dung-han |
| `scm-n1-bien-ln-gop-seafood` | 1 | M2 | Viết | Cơ bản | A2 | finance | Mã hàng SEAFOOD nào có biên lợi nhuận gộp cao? | Xét các mã hàng thuộc ngành `SEAFOOD` trong bảng giá cố định `item_costs`. · Tính biên lợi nhuận gộp của từng mã theo tab Nghiệp vụ, đổi ra phần trăm. | item_costs | sai-mau-so, thu-tu-phep-tinh |
| `scm-n2-hang-chua-ve-thang-8` | 1 | M2 | Viết | Dễ | B4 | operations | Đơn mua đầu tháng 8 còn bao nhiêu hàng chưa về? | Xét các đơn mua của nhà cung cấp `SUP_007` đặt từ ngày 1/8/2017 tới hết ngày 14/8/2017. · Tính `luong_chua_ve` của từng đơn bằng lượng đặt trừ lượng đã nhận; đơn chưa về coi lượng đã nhận bằng 0. | purchase_orders | null-trong-phep-tinh, bang-null, thieu-can-tren |
| `scm-n3-trang-thai-giao-don-toi-15-7-2016` | 1 | M2 | Viết | Khó | C4 | operations | Đơn tối 15/7/2016 ở Hà Nội giao sát cam kết ra sao? | Xét các đơn giao tới thành phố Hà Nội, tạo từ 20 giờ 30 tới trước 21 giờ ngày 15/7/2016. · Gán trạng thái giao của từng đơn theo tab Nghiệp vụ, nhận một trong bốn giá trị `'huy'`, `'tre'`, `'sat_han'`, `'dung_han'`. | orders | don-huy, bien-cam-ket, co-on-time-lech |
| `scm-n4-fill-rate-cua-hang-52` | 1 | M2 | Viết | Dễ | C1 | sales | Mã nào ở cửa hàng 52 thiếu hụt nhiều nhất? | Xét tồn kho kỳ 2017-07 của cửa hàng 52. · Tính fill rate (tỷ lệ lấp đầy) của từng mã hàng theo tab Nghiệp vụ, đổi ra phần trăm. | inventory_snapshots | quy-uoc-sold, thu-tu-phep-tinh |
| `scm-n5-gio-chua-gan-don-hue` | 1 | M2 | Viết | Trung bình | E2 | operations | Đơn nào về kho Huế ngày 7/7 có nhiều giờ chưa gán? | Xét các đơn giao thành công, đặt ngày 7/7/2017, có kho đích là kho vệ tinh ở Huế (lọc theo kho đích; thành phố nhận hàng có thể khác Huế). · Tính tổng năm cột chặng và thời gian chưa gán của từng đơn theo tab Nghiệp vụ. | orders, sorting_hubs | thieu-thanh-phan, don-huy |
| `scm-n6-voucher-den-bu-don-tre-bac-giang` | 1 | M2 | Viết | Khó | C3 | marketing | Đơn trễ tới Bắc Giang tháng 8/2017 được đền bù voucher bao nhiêu? | Xét các đơn giao tới thành phố Bắc Giang, tạo trong tháng 8/2017. · Liệt kê các đơn được xét đền bù và tính mức đền bù của từng đơn theo tab Nghiệp vụ. | orders | don-huy, thu-tu-case, phan-tram-va-ty-le, thieu-can-tren |
| `scm-n7-gia-dau-thang-7-thap` | 1 | M2 | Sửa lỗi | Cơ bản | A2 | finance | Giá dầu bình quân tháng 7/2017 thấp bất thường | Sửa truy vấn dưới đây để tính đúng giá dầu WTI bình quân của các ngày có giá trong tháng 7/2017. · Giữ nguyên cột `gia_dau_tb` (làm tròn 2 chữ số). | oil | null-thanh-0 |
| `scm-n8-dung-han-thai-binh-tron` | 1 | M2 | Sửa lỗi | Dễ | A2 | operations | Tỷ lệ giao đúng hạn ở Thái Bình ra số tròn | Sửa truy vấn dưới đây để tính đúng tỷ lệ giao đúng hạn của các đơn có kho đích `HUB_THAIBINH`, đặt trong tháng 7/2017. · Giữ nguyên các cột `so_don`, `so_dung_han`, `ty_le_dung_han_pct` (phần trăm, làm tròn 2 chữ số). | orders | lam-tron-giua-chung, don-huy-trong-mau-so |
| `scm-n9-gio-tre-nam-dinh-am` | 1 | M2 | Sửa lỗi | Trung bình | C3 | customer | Giờ trễ của đơn tới Nam Định ra số âm | Sửa hai lỗi trong truy vấn dưới đây. Kết quả cần liệt kê các đơn tới Nam Định đặt trong tháng 7/2017, đã giao tới khách nhưng trễ so với cam kết. · Tính `so_gio_tre` bằng số giờ giao muộn hơn cam kết (số dương, làm … | orders | dao-phep-tru, don-huy |
| `scm-c1-tu-ap-voucher-huy-don` | 1 | case | Case | Cơ bản | – | marketing | Tự động áp mã có làm khách huỷ đơn ít hơn? | b1 Tỷ lệ huỷ của hai nhóm; b2 Kết luận | orders | b1: gom_theo_co_dung_voucher, thieu_can_tren |
| `scm-c2-thang-ban-nhieu-nhat-2017` | 1 | case | Case | Cơ bản | – | sales | Tháng nào năm 2017 cửa hàng 43 bán được nhiều hàng nhất? | b1 Lượng bán của cửa hàng 43 theo kỳ; b2 Kết luận | inventory_snapshots | b1: tru_thieu_hut, cong_ton_cuoi_ky |

## Gói 2 · M3 String & Date + M4 Aggregation + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-s1-don-mua-ve-tre-2016` | 2 | M3 | Viết | Cơ bản | A1 | operations | Đơn mua nào về trễ hạn nhất năm 2016? | Xét các đơn mua có `po_date` trong năm 2016 và về sau ngày hẹn giao (`received_date` lớn hơn `promised_date`). · Tính `so_ngay_tre` là số ngày từ `promised_date` tới `received_date` (số dương). | purchase_orders | dao-thu-tu-datediff |
| `scm-s2-ngay-cao-diem-2016` | 2 | M3 | Viết | Cơ bản | A1 | marketing | Ngày cao điểm năm 2016 rơi vào thứ mấy? | Xét các ngày cao điểm có `date` trong năm 2016. · Trả về `event_name`; `ngay` là chuỗi dạng `'dd/mm/yyyy'` (ví dụ `'09/09/2016'`); `thu` là thứ trong tuần dạng số, 1 là Chủ nhật, 2 là thứ Hai, …, 7 là thứ Bảy; `tier`. | event_calendar | sap-theo-chuoi-ngay |
| `scm-s3-huy-kho-ve-tinh-18-thang` | 2 | M3 | Sửa lỗi | Trung bình | B1 | after_sales | Báo cáo tỷ lệ huỷ 18 tháng chỉ còn 12 dòng | Truy vấn dưới đây tính số đơn, số đơn huỷ và tỷ lệ huỷ theo tháng đặt đơn, cho các đơn có kho đích là kho vệ tinh, đặt từ tháng 1/2016 tới hết tháng 6/2017. Kết quả chỉ có 12 dòng. · Sửa để mỗi tháng trong 18 tháng là một dòng; giữ nguyên cột `thang`, `so_don`, `so_huy`, … | orders, sorting_hubs | gom-theo-thang-mat-nam |
| `scm-s4-lui-gio-chot-don` | 2 | M3 | Viết | Khó | A2 | operations | Lead time giảm bao nhiêu nếu lùi giờ chốt đơn? | Xét các đơn không huỷ, đặt từ ngày 1/7/2017 tới hết tháng 8/2017. · Giả định khi lùi giờ chốt sang 18 giờ, đơn tạo trong khung 17 giờ được lấy hàng ngay trong ngày; tính lead time bình quân hiện nay và sau khi lùi giờ chốt của từng kho xuất. | orders | khung-gio-chot, tinh-ca-don-huy, gio-lam-tron, quen-can-tren |
| `scm-s5-ban-theo-thu-cua-hang-44` | 2 | M3 | Viết | Dễ | B1 | sales | Cửa hàng 44 bán BEVERAGES nhiều nhất vào thứ nào? | Xét các dòng bán của cửa hàng 44, ngành hàng `'BEVERAGES'`, từ ngày 1/7/2017 tới hết ngày 31/7/2017. · Tính tổng lượng bán của từng thứ trong tuần cho cả tháng (không chia cho số ngày), theo tab Nghiệp vụ. | sales, items | quen-can-tren |
| `scm-s6-chuyen-giao-tre-quy-2` | 2 | M3 | Viết | Dễ | A1 | operations | Chuyến giao nào trễ hạn trong quý 2/2017? | Xét các chuyến giao có `on_time` bằng 0 và ngày đầu tuần giao từ `'2017-04-01'` tới hết `'2017-06-30'`. · Ngày đầu tuần giao `tuan_bat_dau` là phần trước dấu `/` của cột `week`, giữ dạng chuỗi `'YYYY-MM-DD'`. | shipments, stores | lay-sai-phan-chuoi |
| `scm-s7-gia-tri-nhan-sai-thu-tu` | 2 | M3 | Sửa lỗi | Dễ | B1 | finance | Báo cáo giá trị hàng nhận xếp sai thứ tự tháng | Truy vấn dưới đây tính giá trị hàng nhận theo giá vốn cho từng tháng nhận hàng năm 2016, nhưng các tháng xếp sai thứ tự. · Sửa để `thang` có dạng `'2016-01'` và các dòng xếp đúng thứ tự thời gian. | purchase_orders, item_costs | sap-ten-thang |
| `scm-s8-von-ton-cuoi-ky-2017` | 2 | M3 | Viết | Trung bình | B1 | finance | Cửa hàng 1 tồn bao nhiêu vốn cuối mỗi kỳ năm 2017? | Xét các kỳ từ 2017-01 trở đi, chỉ giữ tháng đủ theo tab Nghiệp vụ. · Tính vốn tồn kho cuối kỳ của cửa hàng 1 cho từng kỳ, bằng tổng cột `inventory_value` có sẵn (không tính lại từ `on_hand_end` và giá vốn). | inventory_snapshots | thang-chua-du, quen-can-tren |
| `scm-s9-muc-tang-ngay-cao-diem-2016` | 2 | M3 | Sửa lỗi | Khó | C3 | marketing | Mức tăng đơn ngày cao điểm 2016 bị tính thấp | Xét các ngày trong năm 2016; so mức tăng số đơn thực tế của ngày cao điểm (so với ngày nền) với mức tăng kế hoạch, theo quy mô sự kiện. · Truy vấn dưới đây có hai lỗi chồng nhau ở tập ngày nền. Sửa cả hai; giữ nguyên các cột `tier`, `so_ngay`, … | orders, event_calendar | cong-tru-so-vao-ngay, bo-su-kien-ngoai-nam |
| `scm-a1-chuyen-giao-theo-dc-2016` | 2 | M4 | Viết | Cơ bản | A3 | operations | Mỗi DC chạy bao nhiêu chuyến giao năm 2016? | Xét các chuyến giao có `week` bắt đầu bằng `'2016'`. · Đếm cho từng DC (`warehouse_id`) số chuyến và số chuyến đúng hạn (`on_time` bằng 1). | shipments | – |
| `scm-a2-dai-chi-so-kho-dich-2017` | 2 | M4 | Sửa lỗi | Khó | A2 | operations | Bảng chỉ số kho đích lệch số đội giao hàng báo | Bảng chỉ số của mỗi kho đích gồm số đơn tạo, tỷ lệ huỷ, GMV, lead time bình quân và tỷ lệ giao đúng hạn, đơn đặt từ 1/7/2017 tới hết tháng 8/2017. · Truy vấn dưới đây có ba lỗi chồng nhau. Sửa cả ba; giữ nguyên các cột … | orders | hai-tap-don, else-0-trong-avg, quen-can-tren |
| `scm-a3-voucher-theo-loai-kho` | 2 | M4 | Viết | Dễ | C2 | marketing | Khách tự áp mã ở kho chính hay kho vệ tinh nhiều hơn? | Xét các đơn có `order_date` trong tháng 7/2017 thuộc nhóm thử nghiệm `checkout_group = 'manual'`. · Tính cho kho chính và kho vệ tinh (cột `role` của kho đích) số đơn, số đơn có voucher và tỷ lệ đơn dùng voucher, theo tab Nghiệp vụ. | orders, sorting_hubs | mau-so-sai, quen-can-tren |
| `scm-a4-cua-hang-vang-khach-2016` | 2 | M4 | Viết | Dễ | C3 | customer | Cửa hàng nào vắng khách năm 2016? | Xét các ngày trong năm 2016. · Tính lượt giao dịch bình quân mỗi ngày của từng cửa hàng, trên các ngày có số liệu giao dịch; chỉ giữ cửa hàng có mức bình quân dưới 1.000. | transactions, stores | where-thay-having |
| `scm-a5-so-ma-ban-cua-hang-44` | 2 | M4 | Sửa lỗi | Dễ | A3 | sales | Số mã hàng có bán ở cửa hàng 44 vượt cả danh mục | Truy vấn dưới đây cần đếm số mã hàng (SKU) khác nhau có dòng bán ở cửa hàng 44 trong tháng 7/2017, theo ngành hàng. · Sửa lại cho đúng; giữ nguyên cột `family`, `so_ma` và thứ tự sắp. | sales, items | dem-dong-thay-vi-ma |
| `scm-a6-tong-giao-dich-thang-7-thap` | 2 | M4 | Sửa lỗi | Cơ bản | A3 | customer | Tổng lượt giao dịch tháng 7 của cửa hàng thấp bất thường | Truy vấn dưới đây cần trả về 10 cửa hàng có tổng lượt giao dịch cao nhất từ ngày 1/7/2017 tới hết ngày 31/7/2017, nhưng số ra quá thấp. · Sửa lại; giữ nguyên cột `store_nbr`, `tong_gd`, thứ tự sắp và số dòng. | transactions | sai-ham-gop |
| `scm-a7-don-mien-theo-quy-2016` | 2 | M4 | Viết | Trung bình | A4 | customer | Mỗi miền có bao nhiêu đơn trong từng quý 2016? | Xét các đơn không huỷ, đặt trong năm 2016. · Đếm số đơn của từng miền trong mỗi quý. | orders | count-else-0, tinh-ca-don-huy |
| `scm-a8-bien-ln-gop-nganh-hang` | 2 | M4 | Viết | Trung bình | A3 | finance | Ngành hàng lớn nào có biên lợi nhuận gộp thấp? | Xét kỳ 2017-07. · Tính doanh thu và biên lợi nhuận gộp của từng ngành hàng theo tab Nghiệp vụ; chỉ giữ ngành có doanh thu từ 1.000.000 trở lên. | inventory_snapshots, item_costs | trung-binh-ty-le |
| `scm-a9-pheu-don-mua-theo-dc-2016` | 2 | M4 | Viết | Khó | D1 | operations | Đơn mua năm 2016 của mỗi DC hụt nhiều nhất ở bước nào? | Xét các đơn mua đặt trong năm 2016, xếp vào DC mà nhà cung cấp giao hàng về. · Dựng phễu đơn mua theo tab Nghiệp vụ và tính tỷ lệ qua từng bước cho mỗi DC; bước hụt nhiều nhất là bước có tỷ lệ qua thấp nhất. | purchase_orders, suppliers | buoc-khong-long-nhau, sai-mau-so-buoc, count-dem-ca-false, can-ngay-hen |
| `scm-c3-kho-giao-tre` | 2 | case | Case | Cơ bản | – | operations | Kho đích nào cần ưu tiên khắc phục giao trễ? | b1 Tỷ lệ trễ theo kho đích; b2 Kết luận | orders | b1: sap_theo_so_don_tre |
| `scm-c4-khuyen-mai-cua-hang-44` | 2 | case | Case | Dễ | – | marketing | Hàng khuyến mãi ở cửa hàng 44 bán cao hơn bao nhiêu? | b1 Lượng bán bình quân mỗi dòng khi có và không có khuyến mãi; b2 Mức tăng theo ngành hàng; b3 Kết luận | sales, items | b1: quen_can_tren; b2: else_0_trong_avg |

## Gói 3 · M5 Joins + M6 Subqueries + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-j1-ban-theo-loai-cua-hang` | 3 | M5 | Viết | Dễ | A3 | sales | Loại cửa hàng nào bán nhiều nhất ba ngày cuối tháng 7/2017? | Xét các dòng bán từ ngày 29/7/2017 tới hết ngày 31/7/2017. · Tính số cửa hàng có bán và tổng lượng bán của từng loại cửa hàng (`stores.type`), kể cả dòng trả hàng. | sales, stores | quen-can-tren |
| `scm-j2-ma-chua-tung-dat-mua` | 3 | M5 | Viết | Dễ | E1 | operations | Mã hàng nào chưa từng có đơn mua? | Xét mọi mã hàng trong `items` và mọi đơn mua (PO) trong `purchase_orders`, không giới hạn thời gian. · Đếm cho từng ngành hàng số mã hàng không có đơn mua nào. | items, purchase_orders | inner-join-mat-dong |
| `scm-j3-giao-dich-loai-a-ngay-15-7` | 3 | M5 | Viết | Cơ bản | A2 | customer | Ngày 15/7/2017 cửa hàng loại A có bao nhiêu lượt giao dịch? | Xét các cửa hàng có `type = 'A'` và ngày `'2017-07-15'`. · Đếm số cửa hàng có số liệu giao dịch trong ngày đó và cộng lượt giao dịch của các cửa hàng này. | transactions, stores | quen-loc-loai |
| `scm-j4-ncc-co-lo-truot-theo-dc` | 3 | M5 | Sửa lỗi | Dễ | A3 | after_sales | Số nhà cung cấp có lô trượt lên tới hàng nghìn | Xét các đơn mua đặt trong năm 2016 có kết quả kiểm định là lô trượt. · Sửa truy vấn khởi đầu để đếm đúng số nhà cung cấp (NCC) có ít nhất một lô trượt, theo từng trung tâm phân phối (DC) nhận hàng. | purchase_orders, suppliers | dem-dong-thay-vi-ncc |
| `scm-j5-lead-time-theo-tuyen-kho` | 3 | M5 | Viết | Trung bình | A3 | operations | Tuyến kho nào có lead time dài nhất tháng 7/2017? | Xét các đơn tạo từ ngày 1/7/2017 tới hết ngày 31/7/2017, không tính đơn huỷ. · Tính số đơn và lead time bình quân (giờ, từ lúc tạo đơn tới lúc giao thành công) của từng cặp kho xuất – kho đích. | orders, sorting_hubs | don-huy, noi-mot-lan |
| `scm-j6-doanh-thu-m2-theo-loai-cua-hang` | 3 | M5 | Viết | Khó | A3 | sales | Loại cửa hàng nào tạo doanh thu trên m² cao nhất? | Xét lượng bán từ ngày 29/7/2017 tới hết ngày 31/7/2017 của mọi cửa hàng có bán trong kỳ, kể cả dòng trả hàng. · Tính doanh thu trên m² của từng loại cửa hàng theo tab Nghiệp vụ, và mức chênh so với doanh thu trên m² của cả chuỗi. | sales, item_costs, stores, store_attributes | fan-out, trung-binh-ty-le, quen-can-tren |
| `scm-j7-hang-loi-theo-dc-gap-doi` | 3 | M5 | Sửa lỗi | Trung bình | E2 | after_sales | Hàng lỗi theo DC cộng lại bị gấp đôi | Xét các đơn mua đặt trong năm 2016 và đã về kho. · Sửa truy vấn khởi đầu để mỗi đơn mua chỉ tính một lần, vào đúng DC của nhà cung cấp giao đơn đó. | purchase_orders, suppliers | fan-out, noi-sai-cot |
| `scm-j8-giao-dich-ngay-le-dia-phuong` | 3 | M5 | Viết | Khó | C3 | marketing | Ngày lễ địa phương 2016 làm lượt giao dịch đổi ra sao? | Xét lượt giao dịch của các cửa hàng trong năm 2016. · Tính lượt giao dịch bình quân một cửa hàng trong một ngày của từng thành phố, tách ngày lễ địa phương và các ngày còn lại của năm, rồi tính mức tăng theo tab Nghiệp vụ. | transactions, stores, holidays | noi-chi-theo-ngay, le-bi-doi, dong-le-trung |
| `scm-j9-don-mua-thang-7-moi-ncc` | 3 | M5 | Sửa lỗi | Cơ bản | A3 | operations | Bảng đơn mua tháng 7/2017 thiếu nhà cung cấp | Xét các đơn mua đặt từ ngày 1/7/2017 tới hết ngày 31/7/2017. · Sửa truy vấn khởi đầu để mọi nhà cung cấp trong `suppliers` đều có một dòng; nhà cung cấp không có đơn nào có `so_don` bằng 0. | suppliers, purchase_orders | inner-join-mat-dong |
| `scm-q1-ncc-lead-time-tren-binh-quan` | 3 | M6 | Viết | Dễ | C3 | operations | Nhà cung cấp nào giao chậm hơn bình quân 2016? | Xét các đơn mua đặt trong năm 2016 và đã về kho. · Tính lead time (thời gian từ khi đặt hàng tới khi nhận hàng) thực tế bình quân, tính bằng ngày, của từng nhà cung cấp và của toàn bộ các đơn đó, theo tab Nghiệp vụ. | purchase_orders | pham-vi-truy-van-con |
| `scm-q2-ncc-co-lo-truot-thang-7` | 3 | M6 | Viết | Dễ | A1 | after_sales | Nhà cung cấp nào có đơn tháng 7/2017 bị trượt? | Xét các đơn mua có ngày đặt (`po_date`) từ 1/7/2017 tới hết 31/7/2017. · Liệt kê nhà cung cấp có ít nhất một lô trượt (`inspection_result = 'Fail'`) trong các đơn đó, mỗi nhà cung cấp một dòng. | suppliers, purchase_orders | join-lap-dong, quen-can-tren |
| `scm-q3-hang-tuoi-song-cua-hang-44` | 3 | M6 | Viết | Cơ bản | A2 | sales | Ngày 1/7/2017 cửa hàng 44 bán được bao nhiêu hàng tươi sống? | Xét các dòng bán của cửa hàng 44 (`store_nbr = 44`) ngày `'2017-07-01'`, chỉ lấy mã hàng tươi sống (`perishable = 1` trong `items`). · Tính tổng lượng bán, kể cả dòng trả hàng. | sales, items | nham-hang-kho |
| `scm-q4-cua-hang-tren-binh-quan-loai` | 3 | M6 | Viết | Trung bình | C3 | sales | Cửa hàng nào bán vượt bình quân cùng loại? | Xét các dòng bán từ ngày 29/7/2017 tới hết ngày 31/7/2017. · Tính tổng lượng bán của từng cửa hàng và lượng bán bình quân một cửa hàng của từng loại cửa hàng. | sales, stores | chuan-sai-nhom, binh-quan-sai-muc |
| `scm-q5-don-da-ve-gan-nhat-moi-ncc` | 3 | M6 | Viết | Khó | B4 | operations | Đơn về gần nhất của mỗi nhà cung cấp có trễ hẹn không? | Xét mọi đơn mua đã về kho, không giới hạn thời gian. · Tìm cho từng nhà cung cấp đúng một đơn đã về gần nhất theo ngày đặt; nhiều đơn cùng ngày đặt thì lấy đơn có `po_id` lớn nhất. | suppliers, warehouses, purchase_orders | don-chua-ve, trung-ngay, max-tung-cot |
| `scm-q6-ty-trong-von-ton-cua-hang-45` | 3 | M6 | Viết | Cơ bản | C2 | finance | Cửa hàng 45 giữ bao nhiêu phần vốn tồn kỳ 2017-07? | Xét các dòng tồn kho của kỳ `ym = '2017-07'`. · Tính vốn tồn của cửa hàng 45 (`store_nbr = 45`) và tỷ trọng vốn tồn đó trên tổng vốn tồn của cả chuỗi trong cùng kỳ. | inventory_snapshots | mau-so-sai-ky |
| `scm-q7-ma-khong-ban-duoc-ra-0` | 3 | M6 | Sửa lỗi | Dễ | E1 | sales | Số mã hàng không bán được tháng 7/2017 ra 0 | Xét mọi mã hàng trong `items` và các dòng bán trong tháng 7/2017. · Sửa truy vấn khởi đầu để đếm đúng số mã hàng không có dòng bán nào trong tháng ở bất kỳ cửa hàng nào. | items, sales | tuong-quan-sai-bi-danh |
| `scm-q8-ncc-loi-cao-hon-nganh` | 3 | M6 | Sửa lỗi | Khó | C3 | after_sales | Danh sách nhà cung cấp lỗi cao thiếu ngành hàng ít lỗi | Xét các đơn mua đặt trong năm 2016 và đã về kho. · Truy vấn khởi đầu có hai lỗi chồng nhau. Sửa cả hai để giữ lại nhà cung cấp có tỷ lệ hàng lỗi lớn hơn tỷ lệ hàng lỗi của chính ngành hàng mình; cả hai tỷ lệ tính theo tab Nghiệp vụ, trên … | purchase_orders, suppliers | thieu-tuong-quan, trung-binh-ty-le |
| `scm-q9-diem-giao-theo-nhom-gia-tri` | 3 | M6 | Sửa lỗi | Trung bình | C4 | customer | Hai nhóm điểm giao cộng lại vượt tổng số điểm | Xét các đơn tạo trong tháng 7/2017, không tính đơn huỷ. · Xếp mỗi điểm giao vào đúng một nhóm theo giá trị đơn bình quân của điểm đó: `'cao'` khi từ 24 USD trở lên, `'thap'` khi dưới 24 USD. | orders | phan-nhom-sai-muc |
| `scm-c5-dc-nhan-hang-tre` | 3 | case | Case | Dễ | – | operations | Vì sao DC TP.HCM nhận hàng trễ nhiều? | b1 Tỷ lệ giao đúng hạn theo DC năm 2016; b2 Nhà cung cấp của DC TP.HCM; b3 Kết luận | purchase_orders, suppliers | b1: dem_tre_thay_vi_dung_han; b2: quen_loc_nam |
| `scm-c6-cao-diem-giao-tre` | 3 | case | Case | Trung bình | – | marketing | Đơn ngày cao điểm năm 2016 chậm ở chặng nào? | b1 Đơn bình quân và tỷ lệ đúng hạn theo loại ngày; b2 Chặng nào chậm thêm vào ngày cao điểm?; b3 Kho nào phân loại chậm nhất vào ngày cao điểm?; b4 Kết luận | orders, event_calendar, sorting_hubs | b1: inner_join_mat_ngay_thuong; b2: noi_kho_xuat; b3: theo_kho_xuat |

## Gói 4 · M7 CTE & Set Operations + M8 Window Functions + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-t1-ton-tren-ban-nganh-hang` | 4 | M7 | Viết | Trung bình | A3 | sales | Ngành hàng nào ở cửa hàng 44 tồn nhiều so với lượng bán? | Chỉ xét cửa hàng 44. Tính tồn cuối kỳ 2017-07 của từng ngành hàng (tổng `on_hand_end`) và lượng bán tháng 7/2017 (tổng `unit_sales`, từ ngày 1 tới hết ngày 31). · Tính tỷ số tồn trên bán theo tab Nghiệp vụ; chỉ giữ ngành hàng có lượng bán … | inventory_snapshots, items, sales | fan-out, quen-can-tren |
| `scm-t2-chuyen-giao-cua-hang-18` | 4 | M7 | Viết | Khó | B1 | operations | Tháng nào năm 2016 cửa hàng 18 không nhận hàng? | Xét các chuyến giao tới cửa hàng 18 có tuần bắt đầu trong năm 2016; tháng của chuyến theo tab Nghiệp vụ. · Trả về đủ 12 dòng: `thang` (chuỗi `'2016-01'` tới `'2016-12'`), `so_chuyen`, `luong_giao` (tổng số lượng giao, … | shipments | thang-trong-bien-mat |
| `scm-t3-ma-hang-can-ra-soat` | 4 | M7 | Viết | Dễ | A3 | after_sales | Ngành hàng nào có nhiều mã cần rà soát nhất? | Xét các đơn mua có `po_date` từ `'2017-01-01'` tới trước `'2017-07-01'`. · Lấy tập mã hàng có lô trượt (`inspection_result = 'Fail'`) và tập mã hàng có đơn về trễ, rồi hợp hai tập; mỗi mã chỉ tính một lần. | items, purchase_orders | union-all-dem-trung |
| `scm-t4-nhap-xuat-ton-cua-hang-3` | 4 | M7 | Sửa lỗi | Cơ bản | A2 | operations | Lượng nhập tháng 7 của cửa hàng 3 bằng đúng lượng bán | Truy vấn dưới đây lập báo cáo nhập xuất tồn kỳ 2017-07 của cửa hàng 3, mỗi chỉ tiêu một dòng: tồn đầu kỳ, nhập trong kỳ, lượng bán trong kỳ, tồn cuối kỳ. Dòng nhập trong kỳ đang ra bằng dòng lượng bán. · Sửa để dòng nhập trong kỳ lấy đúng lượng nhập. | inventory_snapshots | sai-cot-cong |
| `scm-t5-nhap-xuat-dc` | 4 | M7 | Sửa lỗi | Khó | E2 | operations | Lượng xuất của DC năm 2016 gấp nhiều lần sổ kho | Truy vấn dưới đây đối chiếu lượng nhập và lượng xuất năm 2016 của từng DC theo tab Nghiệp vụ, nhưng có hai lỗi chồng nhau. Sửa cả hai. · Lượng nhập tính theo ngày nhận hàng trong năm 2016; lượng xuất tính theo tuần bắt … | purchase_orders, suppliers, shipments | fan-out, sai-cot-ngay |
| `scm-t6-von-ton-binh-quan-loai-cua-hang` | 4 | M7 | Sửa lỗi | Dễ | A3 | finance | Vốn tồn bình quân theo loại cửa hàng thấp hơn sổ kế toán | Truy vấn dưới đây tính vốn tồn bình quân tháng 7/2017 của từng loại cửa hàng, bằng (vốn tồn cuối kỳ 2017-06 + vốn tồn cuối kỳ 2017-07) / 2, nhưng ra thấp hơn sổ kế toán. · Sửa cho khớp sổ kế toán. | inventory_snapshots, stores | union-mat-dong |
| `scm-t7-ma-thieu-hut-nhieu-ky` | 4 | M7 | Viết | Cơ bản | C4 | operations | Mã hàng ở cửa hàng 44 thiếu hụt trong mấy kỳ? | Xét tồn kho của cửa hàng 44 từ kỳ `'2017-01'` tới hết kỳ `'2017-07'`. · Tính số kỳ thiếu hụt (`thieu_hut` > 0) của từng mã hàng, rồi đếm số mã hàng theo số kỳ thiếu hụt. | inventory_snapshots | quen-can-tren |
| `scm-t8-diem-giao-huy-cao` | 4 | M7 | Viết | Trung bình | C3 | customer | Điểm giao nào có tỷ lệ huỷ cao hơn cả miền? | Xét các đơn đặt từ ngày 01/07/2017 tới hết ngày 31/07/2017. · Tính tỷ lệ huỷ của từng điểm giao và của từng miền, theo tab Nghiệp vụ; chỉ giữ điểm giao có tỷ lệ huỷ cao hơn tỷ lệ huỷ của miền tương ứng. | orders | quen-can-tren, chuan-khong-trong-so |
| `scm-t9-huy-theo-nhom-ap-ma` | 4 | M7 | Viết | Dễ | A2 | marketing | Nhóm áp mã nào huỷ đơn nhiều hơn trong tháng 7/2017? | Xét các đơn có `order_date` từ `'2017-07-01'` tới trước `'2017-08-01'`. · Tính cho từng nhóm áp mã số đơn, số đơn huỷ và tỷ lệ huỷ, thêm dòng tổng `'tong'` tính từ tổng số đơn của tháng. | orders | dong-tong-sai-trong-so |
| `scm-f1-top3-hang-tuoi-song` | 4 | M8 | Viết | Trung bình | C1 | sales | Ba mã hàng tươi sống nào bán chạy nhất mỗi ngành? | Xét hàng tươi sống bán ở cửa hàng 23 (`store_nbr` bằng 23), từ ngày 01/07/2017 tới hết ngày 31/07/2017. · Xếp hạng mã hàng trong từng ngành hàng theo tổng `unit_sales` giảm dần; lấy đúng 3 mã mỗi ngành. | sales, items | trung-hang |
| `scm-f2-fill-rate-theo-thang` | 4 | M8 | Viết | Trung bình | B2 | operations | Fill rate từng tháng năm 2017 thay đổi ra sao? | Xét các kỳ tháng đủ từ 2017-01 tới 2017-07. · Tính fill rate của từng kỳ theo tab Nghiệp vụ, và chênh lệch so với kỳ liền trước (điểm phần trăm). | inventory_snapshots | thang-chua-du, trung-binh-ty-le |
| `scm-f3-luy-ke-cua-hang-44` | 4 | M8 | Viết | Dễ | B3 | sales | Cửa hàng 44 đạt chỉ tiêu tháng 7/2017 tới đâu? | Xét các dòng bán của cửa hàng 44 có `date` từ `'2017-07-01'` tới trước `'2017-08-01'`. · Tính lượng bán từng ngày và lượng bán luỹ kế từ ngày 01/07 tới hết ngày đó. | sales | quen-can-tren |
| `scm-f4-don-so-voi-hom-truoc` | 4 | M8 | Viết | Dễ | B2 | marketing | Số đơn tháng 11/2016 thay đổi ra sao so với hôm trước? | Xét đơn không huỷ; số đơn của một ngày đếm theo `order_date`. · Tính cho mỗi ngày từ 01/11/2016 tới 30/11/2016 số đơn, số đơn hôm trước và mức thay đổi (%); ngày 01/11 so với 31/10. | orders | loc-truoc-khi-lag |
| `scm-f5-xep-hang-ngay-tai-kho` | 4 | M8 | Viết | Cơ bản | C1 | operations | Trong tuần 12/12/2016, mỗi kho tải nặng nhất vào ngày nào? | Xét các dòng có `date` từ `'2016-12-12'` tới hết ngày `'2016-12-18'`. · Xếp hạng các ngày trong từng kho theo `workload_ratio` giảm dần; bằng nhau thì ngày sớm hơn xếp trước, hạng không trùng. | warehouse_daily_ops | tieu-chi-phu-khi-bang-nhau |
| `scm-f6-giao-dich-cung-ky` | 4 | M8 | Viết | Khó | B2 | customer | Lượt giao dịch năm 2017 tăng bao nhiêu so cùng kỳ? | Tính tổng lượt giao dịch theo loại cửa hàng và tháng. · Chỉ tính cửa hàng có giao dịch ở cả tháng 1/2016 và tháng 7/2017 (tăng trưởng cùng cửa hàng). | transactions, stores | lag-sai-buoc, loc-truoc-khi-lag |
| `scm-f7-cua-hang-dong-khach-nhat` | 4 | M8 | Sửa lỗi | Dễ | C1 | customer | Danh sách cửa hàng đông khách nhất chỉ ra một dòng | Truy vấn dưới đây cần trả về cửa hàng có tổng lượt giao dịch tháng 7/2017 cao nhất của từng loại cửa hàng (`stores.type`), nhưng chỉ ra một dòng. · Sửa để mỗi loại cửa hàng có đúng một cửa hàng; hai cửa hàng bằng nhau thì `store_nbr` … | transactions, stores | thieu-partition-by |
| `scm-f8-luy-ke-nhan-hang-ncc` | 4 | M8 | Sửa lỗi | Khó | B3 | operations | Luỹ kế nhận hàng tháng 7/2017 lệch phiếu nhập | Truy vấn dưới đây liệt kê đơn mua của ba nhà cung cấp `'SUP_027'`, `'SUP_053'`, `'SUP_063'` nhận hàng trong tháng 7/2017, kèm lượng nhận luỹ kế, nhưng có hai lỗi chồng nhau. Sửa cả hai. · Luỹ kế tính riêng cho từng nhà … | purchase_orders | khung-range-mac-dinh, sai-cot-ngay |
| `scm-f9-thay-doi-ty-le-huy-thang` | 4 | M8 | Sửa lỗi | Cơ bản | B2 | after_sales | Tháng đầu năm 2017 lại có mức thay đổi tỷ lệ huỷ | Truy vấn dưới đây tính tỷ lệ huỷ của toàn chuỗi từng tháng, từ tháng 1 tới tháng 7/2017, và mức thay đổi so với tháng trước, nhưng tháng 1 có số còn tháng 7 để trống. · Sửa để mỗi tháng so với tháng liền trước. | orders | sai-chieu-sap-trong-cua-so |
| `scm-c7-fill-rate-thang-3` | 4 | case | Case | Trung bình | – | operations | Vì sao fill rate tháng 3/2017 giảm mạnh? | b1 Fill rate và tỷ lệ dòng thiếu hụt từng kỳ; b2 Ngành hàng nào thiếu hụt tăng nhiều nhất?; b3 Bán tăng hay nhập giảm?; b4 Kết luận | inventory_snapshots, items | b1: gom_ca_ky_chua_du; b2: lay_tong_thieu_hut_thang_3; b3: khong_chia_so_ngay |
| `scm-c8-giao-tre-ngay-cao-diem` | 4 | case | Case | Khó | – | marketing | Vì sao ngày cao điểm cuối năm 2016 giao trễ nhiều? | b1 Ngày cao điểm giao đúng hạn kém bao nhiêu?; b2 Chặng nào chậm thêm?; b3 Kho đích nào phân loại chậm vào ngày cao điểm?; b4 Kho có quá tải vào ngày cao điểm không?; b5 Kết luận | orders, event_calendar, warehouse_daily_ops | b1: tinh_ca_don_huy |

## Gói 5 · M9 Data Quality + M10 Query Performance + 2 case

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| `scm-k1-ban-khong-co-ton-kho` | 5 | M9 | Viết | Dễ | E2 | sales | Mã hàng nào có bán nhưng thiếu số tồn kho kỳ 2017-07? | Xét các dòng bán của cửa hàng 47 và 51 trong tháng 7/2017 ở `sales` (từ `'2017-07-01'` tới trước `'2017-08-01'`). · Tìm các cặp (`store_nbr`, `item_nbr`) có dòng bán nhưng không có dòng nào trong `inventory_snapshots` ở kỳ `'2017-07'`. | inventory_snapshots, sales | dieu-kien-noi-dat-o-where |
| `scm-k2-ngay-le-ghi-hai-dong` | 5 | M9 | Viết | Cơ bản | E1 | marketing | Ngày nào có hai dòng lễ ở cùng địa phương? | Xét toàn bộ bảng `holidays`. Mỗi cặp ngày (`date`) và địa phương (`locale_name`) chỉ được có một dòng. · Liệt kê các cặp ngày, địa phương có từ hai dòng trở lên. | holidays | khoa-thieu-cot |
| `scm-k3-co-dung-han-mau-thuan` | 5 | M9 | Sửa lỗi | Dễ | E1 | customer | Kiểm tra cờ đúng hạn báo nhầm đơn | Truy vấn dưới đây tìm các đơn không huỷ có `on_time` mâu thuẫn với quy tắc đúng hạn trong tab Nghiệp vụ, nhưng ra sai danh sách. Sửa cho đúng. · Giữ nguyên các cột `order_id`, `order_date`, `lead_time_total_h`, … | orders | so-sanh-bien |
| `scm-k4-mien-gia-tri-giao-dich-2016` | 5 | M9 | Viết | Cơ bản | E1 | customer | Lượt giao dịch năm 2016 nằm trong khoảng nào? | Xét các dòng của bảng `transactions` có ngày trong năm 2016. · Trả về một dòng gồm `so_dong` (số dòng), `gd_nho_nhat`, `gd_lon_nhat` (lượt giao dịch nhỏ nhất, lớn nhất của một dòng), `gd_trung_binh` … | transactions | quen-can-tren |
| `scm-k5-tuan-khong-co-chuyen-giao` | 5 | M9 | Viết | Trung bình | D3 | operations | Cửa hàng nào có tuần không nhận chuyến giao nào? | Xét bảng `shipments`: mỗi dòng là chuyến giao của một tuần cho một cửa hàng; `week` có dạng `'YYYY-MM-DD/YYYY-MM-DD'`, mười ký tự đầu là ngày thứ Hai của tuần. · Lấy tuần đầu và tuần cuối có chuyến giao của từng cửa … | shipments | moc-dau-chung |
| `scm-k6-don-can-xu-ly-kho-hue` | 5 | M9 | Viết | Dễ | E2 | operations | Đơn cần xử lý của kho Huế có tính đơn huỷ? | Xét kho `'HUB_HUE'`, các ngày trong tháng 7/2017. Đơn thuộc kho theo kho đích `dest_hub_id`, thuộc ngày theo `order_date`. · Trả về mỗi ngày một dòng: `ngay`, `don_can_xu_ly` (`orders_to_process` của ngày), `so_don` … | warehouse_daily_ops, orders | dem-co-dieu-kien-else-0 |
| `scm-k7-doi-soat-nhan-su` | 5 | M9 | Sửa lỗi | Trung bình | E2 | operations | Đối soát nhân sự kho ra số ngày quá lớn | Truy vấn dưới đây so `headcount` của `warehouse_daily_ops` với `headcount_thuc_te` của `staffing_plan` cho từng kho, các ngày năm 2016, nhưng số ngày ra quá lớn. Tìm chỗ sai và sửa. · Giữ nguyên các cột `hub_id`, … | warehouse_daily_ops, staffing_plan | thieu-khoa-noi |
| `scm-k8-ban-hai-nguon-lech` | 5 | M9 | Sửa lỗi | Khó | E2 | sales | Lượng bán tháng 7 của hai nguồn lệch rất xa | Truy vấn dưới đây cho số sai. Sửa để mỗi cửa hàng loại A có một dòng đối soát lượng bán tháng 7/2017 giữa `sales` và kỳ `'2017-07'` của `inventory_snapshots`. · Mỗi nguồn tính trên toàn bộ dòng của chính nó: … | sales, stores, inventory_snapshots | fan-out, quen-can-tren |
| `scm-k9-doanh-thu-hai-nguon` | 5 | M9 | Viết | Khó | E2 | finance | Ngành hàng nào có doanh thu hai nguồn lệch nhau nhiều nhất? | Tính doanh thu tháng 7/2017 của từng ngành hàng theo hai nguồn, cùng nhân với giá bán đơn vị: lượng bán hằng ngày tháng 7/2017 và lượng bán kỳ 2017-07 của báo cáo tồn kho. · Trả về `family`, `dt_sales`, `dt_ton_kho`, … | sales, items, item_costs, inventory_snapshots | gia-von-thay-gia-ban, quen-loc-ky |
| `scm-p1-po-theo-kiem-dinh` | 5 | M10 | Tối ưu | Cơ bản | A2 | after_sales | Đơn mua theo kết quả kiểm định với một lần quét | Giữ nguyên kết quả: một dòng, ba cột `so_lo_dat`, `so_lo_truot`, `so_chua_ve` là số đơn mua đặt trong năm 2017 có `inspection_result` lần lượt bằng `'Pass'`, `'Fail'`, `'Pending'`. | purchase_orders | quet-lai-bang |
| `scm-p2-don-kho-ve-tinh-theo-nam` | 5 | M10 | Tối ưu | Dễ | B1 | after_sales | Tỷ lệ huỷ kho vệ tinh theo năm chỉ với một lần quét | Giữ nguyên kết quả: `nam` (số), `so_don`, `ty_le_huy_pct` (phần trăm, làm tròn 2 chữ số) của các đơn giao tới kho có `role = 'kho vệ tinh'`, năm 2015 tới 2017; sắp theo `nam`. | orders, sorting_hubs | union-all-lap |
| `scm-p3-ncc-cham-hon-nganh` | 5 | M10 | Tối ưu | Trung bình | C3 | operations | Nhà cung cấp chậm hơn mức ngành chỉ với một lần quét | Giữ nguyên kết quả. Phạm vi: đơn mua đặt năm 2016 đã về. · Cột: `family`, `supplier_id`, `lt_tb` (lead time trung bình của nhà cung cấp, ngày), `tb_nganh` (trung bình các `lt_tb` của ngành hàng); cả hai làm tròn 2 chữ … | purchase_orders, suppliers | tinh-lai-cte |
| `scm-p4-von-ton-hang-khong-ban` | 5 | M10 | Tối ưu | Cơ bản | A2 | finance | Vốn tồn của mã hàng không bán được chỉ với một lần quét | Giữ nguyên kết quả: một dòng cho kỳ `'2017-07'`, ba cột `von_ton` (tổng vốn tồn), `von_ton_khong_ban` (vốn tồn của các dòng có `sold = 0`), `so_dong_khong_ban` (số dòng có `sold = 0`); … | inventory_snapshots | quet-lai-bang |
| `scm-p5-giao-dich-theo-loai-cua-hang` | 5 | M10 | Tối ưu | Dễ | A3 | customer | Lượt giao dịch theo loại cửa hàng chỉ với một lần quét | Giữ nguyên kết quả: các ngày năm 2016, mỗi loại cửa hàng (`type` từ `'A'` tới `'E'`) một dòng, gồm `type`, `so_cua_hang` (số cửa hàng có giao dịch), `gd_tb` … · Sắp theo `type`. | transactions, stores | union-all-lap |
| `scm-p6-don-truot-7-ngay` | 5 | M10 | Tối ưu | Khó | B3 | operations | Đơn cần xử lý 7 ngày gần nhất chỉ với một lần quét | Giữ nguyên kết quả: mỗi kho, mỗi ngày năm 2016 một dòng, gồm `hub_id`, `ngay`, `don_can_xu_ly`, `don_7_ngay` (tổng đơn cần xử lý của ngày đó và sáu ngày liền trước, kể cả ngày cuối năm 2015). · Sắp theo `hub_id`, rồi … | warehouse_daily_ops | tu-noi-bang, loc-truoc-cua-so |
| `scm-p7-don-moi-diem-giao-sau-khi-gop` | 5 | M10 | Sửa lỗi | Dễ | A2 | customer | Số điểm giao theo miền bằng đúng số đơn | Truy vấn dưới đây tính cho từng miền (`region`), trên các đơn đặt trong tháng 7/2017: `so_don` (mọi đơn), `so_diem_giao` (số điểm giao khác nhau đã nhận đơn), `don_moi_diem` (số đơn bình quân mỗi điểm giao, làm tròn 2 chữ số). Hai cột sau ra sai; sửa lại. · Giữ nguyên tên … | orders | dem-dong-thay-gia-tri-khac-nhau |
| `scm-p8-voucher-dem-hai-lan` | 5 | M10 | Sửa lỗi | Trung bình | A3 | marketing | Số đơn kho Huế tăng sau khi sửa báo cáo | Truy vấn dưới đây lấy các đơn đặt trong tháng 7/2017 giao tới kho `'HUB_HUE'` hoặc có khách tự áp mã (`voucher_manually_applied = 1`), rồi đếm theo kho đích, nhưng ra sai. Sửa lại nhưng vẫn giữ cách tách hai … | orders | union-all-dem-trung |
| `scm-p9-bao-cao-kho-thang-7` | 5 | M10 | Viết | Khó | A3 | operations | Từng kho vận hành ra sao trong tháng 7/2017? | Tính cho từng kho trong danh sách kho, tháng 7/2017: số đơn có kho đích là kho đó (kể cả đơn huỷ), tỷ lệ huỷ, lead time trung bình của đơn không huỷ, số ngày quá tải theo tab Nghiệp vụ. · Trả về `hub_id`, `role`, … | sorting_hubs, orders, warehouse_daily_ops | fan-out, lead-time-gom-don-huy |
| `scm-c9-kho-ha-noi-qua-tai` | 5 | case | Case | Khó | – | operations | Vì sao kho Hà Nội quá tải năm 2016? | b1 Kho nào quá tải nhiều nhất năm 2016?; b2 Quá tải có tập trung ở ngày cao điểm?; b3 Ngày quá tải khác ngày không quá tải ở đơn hay ở người?; b4 Số nhân sự của hai nguồn có khớp nhau?; b5 Kết luận | warehouse_daily_ops, event_calendar, staffing_plan | b1: nguong_0_9; b2: inner_join_chi_con_ngay_cao_diem; b3: quen_loc_kho; b4: noi_thieu_ngay |
| `scm-c10-do-dung-hoc-tap-thieu-hut` | 5 | case | Case | Khó | – | sales | Vì sao đồ dùng học tập thiếu hụt tháng 7/2017? | b1 Ngành hàng nào có fill rate (tỷ lệ lấp đầy) thấp nhất kỳ 2017-07?; b2 Nhà cung cấp có giao trễ, giao thiếu không?; b3 Lượng nhập có theo kịp lượng bán không?; b4 Lượng đặt mỗi tháng gần với lượng bán của tháng nào?; … | inventory_snapshots, items, purchase_orders | b1: trung_binh_ty_le_tung_dong; b2: tinh_ca_don_chua_ve; b3: lay_ca_ky_chua_du; b4: noi_truoc_khi_gom |

## Thống kê (sinh lại tự động từ cau-hoi.tex, 100 câu)

### Module × cấp

| Tiền tố | Cơ bản | Dễ | Trung bình | Khó |
|---|---:|---:|---:|---:|
| `a` | 2 | 3 | 2 | 2 |
| `c` | 3 | 2 | 2 | 3 |
| `f` | 2 | 3 | 2 | 2 |
| `j` | 2 | 3 | 2 | 2 |
| `k` | 2 | 3 | 2 | 2 |
| `n` | 2 | 3 | 2 | 2 |
| `p` | 2 | 3 | 2 | 2 |
| `q` | 2 | 3 | 2 | 2 |
| `r` | 2 | 3 | 2 | 2 |
| `s` | 2 | 3 | 2 | 2 |
| `t` | 2 | 3 | 2 | 2 |

### Hình thức × cấp

| Hình thức | Cơ bản | Dễ | Trung bình | Khó | Cộng |
|---|---:|---:|---:|---:|---:|
| Viết | 12 | 18 | 13 | 12 | 55 |
| Sửa lỗi | 6 | 10 | 6 | 7 | 29 |
| Tối ưu | 2 | 2 | 1 | 1 | 6 |
| Case | 3 | 2 | 2 | 3 | 10 |

### Hình thức × mảng

| Hình thức | Hậu mãi | Khách hàng | Tài chính | Marketing | Vận hành | Bán hàng |
|---|---:|---:|---:|---:|---:|---:|
| Viết | 3 | 6 | 6 | 8 | 19 | 13 |
| Sửa lỗi | 6 | 6 | 3 | 2 | 9 | 3 |
| Tối ưu | 2 | 1 | 1 | 0 | 2 | 0 |
| Case | 0 | 0 | 0 | 4 | 4 | 2 |

### Theo gói

| Gói | Cơ bản | Dễ | Trung bình | Khó | Cộng |
|---|---:|---:|---:|---:|---:|
| goi-1 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 1 | 7 | 5 | 2 | E | 4 | 4 | C | A | 9 | 0 | > | 20 |
| goi-2 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 1 | 7 | 5 | 2 | E | 4 | 4 | C | A | 9 | 0 | > | 20 |
| goi-3 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 1 | 7 | 5 | 2 | E | 4 | 4 | C | A | 9 | 0 | > | 20 |
| goi-4 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 1 | 7 | 5 | 2 | E | 4 | 4 | C | A | 9 | 0 | > | 20 |
| goi-5 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 1 | 7 | 5 | 2 | E | 4 | 4 | C | A | 9 | 0 | > | 20 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | sales | marketing | customer | operations | finance | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 | 2 | 2 | · | 2 | · | 1 | 7 |
| A2 | 1 | 1 | 2 | 5 | 3 | 2 | 14 |
| A3 | 4 | 1 | 2 | 4 | 2 | 2 | 15 |
| A4 | · | · | 1 | · | · | · | 1 |
| B1 | 1 | · | · | 1 | 2 | 2 | 6 |
| B2 | · | 1 | 1 | 1 | · | 1 | 4 |
| B3 | 1 | · | · | 2 | · | · | 3 |
| B4 | · | · | · | 2 | 1 | · | 3 |
| C1 | 2 | · | 1 | 1 | · | · | 4 |
| C2 | · | 1 | · | · | 1 | · | 2 |
| C3 | 1 | 3 | 3 | 3 | · | 2 | 12 |
| C4 | · | · | 1 | 2 | · | · | 3 |
| D1 | · | · | · | 1 | · | · | 1 |
| D2 | · | · | · | · | · | · | 0 |
| D3 | · | · | · | 1 | · | · | 1 |
| E1 | 2 | 1 | 2 | 1 | · | · | 6 |
| E2 | 2 | · | · | 4 | 1 | 1 | 8 |
| E3 | · | · | · | · | · | · | 0 |
| **Cộng** | 16 | 10 | 13 | 30 | 10 | 11 | 90 |

Dạng có câu: 16/18; chưa có: D2, E3; chỉ 1 câu: A4, D1, D3.

Mảng trên cả 100 câu (gồm case): sales 18, marketing 14, customer 13, operations 34, finance 10, after_sales 11.

### Ô trùng (dạng × mảng × cấp × hình thức)

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: không có.

Ô trùng **giữa các gói** (cập nhật sau sửa KIEM-V4, 11/11/2026, quét khoá của 100 câu; cho phép, ghi để tham khảo vì khác gói và khác chủ đề; trùng cả chủ đề thì phải gỡ): 2 ô.
- A2 · operations · hard · debug: `scm-r8-don-mua-do-uong-cho-hang-thang-8` (gói 1, số đơn mua chờ hàng của nhà cung cấp đồ uống) · `scm-a2-dai-chi-so-kho-dich-2017` (gói 2, bảng chỉ số giao hàng theo kho đích). Khác bảng, khác chỉ số: giữ.
- C3 · marketing · hard · write: `scm-n6-voucher-den-bu-don-tre-bac-giang` (gói 1, voucher đền bù đơn giao trễ) · `scm-j8-giao-dich-ngay-le-dia-phuong` (gói 3, lượt giao dịch ngày lễ địa phương). Khác chủ đề: giữ.
- Đã gỡ ở V4: ô A2 · operations · easy · debug (`scm-n8-dung-han-thai-binh-tron` · `scm-p7-ty-le-dung-han-sau-khi-gop`, trùng cả chủ đề tỷ lệ giao đúng hạn): `scm-p7` đổi sang `scm-p7-don-moi-diem-giao-sau-khi-gop` (A2 · customer · easy · debug, ô chưa có câu nào). Hai cặp cũ (`scm-r7`/`scm-s3-lo-truot-thang-3-ra-0`, `scm-a2-ty-le-lo-truot-100`/`scm-j4`) không còn vì các câu đó đã đổi ở v3, v4.

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
