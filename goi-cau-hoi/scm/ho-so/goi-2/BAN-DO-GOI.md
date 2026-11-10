# Bản đồ gói 2 · Supply Chain (`scm`)

Tự phân bổ ngày 10/11/2026 theo mục "Phân bổ" của `BRIEF-SOAN-GOI.md` (chưa có `goi-cau-hoi/scm/BAN-DO-100-CAU.md` khi soạn).
Gói 2 = Module 3 String & Date + Module 4 Aggregation + case c3 (Cơ bản, 2 bước), c4 (Dễ, 3 bước).

| Mã | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Bảng |
|---|---|---|---|---|---|---|---|
| `scm-s1-don-mua-ve-tre-2016` | M3 | write | basic | A1 | operations | Đơn mua nào về trễ hạn nhất năm 2016? | purchase_orders |
| `scm-s2-ngay-cao-diem-2016` | M3 | write | basic | A1 | marketing | Ngày cao điểm năm 2016 rơi vào thứ mấy? | event_calendar |
| `scm-s3-lo-truot-thang-3-ra-0` | M3 | debug | basic | A2 | after_sales | Số lô trượt tháng 3/2016 ra 0 | purchase_orders |
| `scm-s4-don-sau-gio-chot-thang-7` | M3 | write | basic | A2 | operations | Bao nhiêu đơn tháng 7/2017 tạo sau giờ chốt? | orders |
| `scm-s5-ban-theo-thu-cua-hang-44` | M3 | write | easy | B1 | sales | Cửa hàng 44 bán BEVERAGES nhiều nhất vào thứ nào? | sales, items |
| `scm-s6-chuyen-giao-tre-quy-2` | M3 | write | easy | A1 | operations | Chuyến giao nào trễ hạn trong quý 2/2017? | shipments, stores |
| `scm-s7-gia-tri-nhan-sai-thu-tu` | M3 | debug | easy | B1 | finance | Báo cáo giá trị hàng nhận sắp sai thứ tự tháng | purchase_orders, item_costs |
| `scm-s8-von-ton-cuoi-ky-2017` | M3 | write | medium | B1 | finance | Vốn tồn cuối mỗi kỳ năm 2017 là bao nhiêu? | inventory_snapshots |
| `scm-s9-huy-cuoi-tuan-kho-ve-tinh` | M3 | debug | easy | A2 | after_sales | Tỷ lệ huỷ cuối tuần ở kho vệ tinh lệch báo cáo | orders, sorting_hubs |
| `scm-a1-dung-han-theo-dc-2016` | M4 | write | easy | A3 | operations | DC nào giao đúng hạn tốt nhất năm 2016? | shipments, warehouses |
| `scm-a2-ty-le-lo-truot-100` | M4 | debug | easy | A3 | after_sales | Tỷ lệ lô trượt nhà cung cấp nào cũng 100% | purchase_orders, suppliers |
| `scm-a3-voucher-theo-loai-kho` | M4 | write | easy | C2 | marketing | Đơn dùng voucher chiếm bao nhiêu theo loại kho đích? | orders, sorting_hubs |
| `scm-a4-cua-hang-vang-khach-2016` | M4 | write | easy | C3 | customer | Cửa hàng nào vắng khách năm 2016? | transactions, stores |
| `scm-a5-so-ma-ban-cua-hang-44` | M4 | debug | easy | A3 | sales | Cửa hàng 44 có số mã bán cao bất thường | sales, items |
| `scm-a6-dung-han-theo-mien-thap` | M4 | debug | easy | A3 | operations | Tỷ lệ giao đúng hạn theo miền thấp hơn thực tế | orders |
| `scm-a7-don-mien-theo-quy-2016` | M4 | write | medium | A4 | customer | Mỗi miền có bao nhiêu đơn trong từng quý 2016? | orders |
| `scm-a8-bien-ln-gop-nganh-hang` | M4 | write | medium | A3 | finance | Ngành hàng lớn nào có biên lợi nhuận gộp thấp nhất? | inventory_snapshots, item_costs |
| `scm-a9-ncc-hang-loi-vuot-nguong` | M4 | write | medium | E1 | after_sales | Nhà cung cấp nào có tỷ lệ hàng lỗi vượt 2%? | purchase_orders |
| `scm-c3-kho-giao-tre` | case | case | basic (2 bước) | – | operations | Kho đích nào cần ưu tiên khắc phục giao trễ? | orders |
| `scm-c4-khuyen-mai-cua-hang-44` | case | case | easy (3 bước) | – | marketing | Khi có khuyến mãi, lượng bán ở cửa hàng 44 cao hơn bao nhiêu? | sales, items |

Tổng (v2): M3 6 write + 3 debug (4 basic, 4 easy, 1 medium); M4 6 write + 3 debug (6 easy, 3 medium; a6 hạ xuống easy sau kiểm B). Mảng: operations 5 + 1 case, after_sales 4, finance 3, customer 2, marketing 2 + 1 case, sales 2.
