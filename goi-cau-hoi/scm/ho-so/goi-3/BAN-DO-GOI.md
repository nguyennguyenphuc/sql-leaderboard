# Bản đồ gói 3 · Supply Chain (scm)

Tự phân bổ (chưa có `goi-cau-hoi/scm/BAN-DO-100-CAU.md` lúc soạn) theo `BRIEF-SOAN-GOI.md` mục "Phân bổ":
gói 3 = Module 5 Joins (tiền tố `j`) + Module 6 Subqueries (tiền tố `q`), mỗi module 6 write + 3 debug, cấp Dễ/Trung bình,
+ case c5 (Dễ, 3 bước) và c6 (Trung bình, 4 bước). Không hai câu trùng ô dạng × mảng × cấp × hình thức.

| Mã | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|
| scm-j1-ban-theo-loai-cua-hang | 5 | write | easy | A3 | sales | Loại cửa hàng nào bán nhiều nhất tháng 7/2017? | sales, stores | đếm dòng thay cửa hàng; thiếu cận trên (hidden-1) |
| scm-j2-ma-chua-tung-dat-mua | 5 | write | easy | E1 | operations | Mã hàng nào chưa từng có đơn mua? | items, purchase_orders | INNER JOIN; lọc nhầm received_date trống |
| scm-j3-giao-dich-cua-hang-loai-a | 5 | write | easy | A2 | customer | Lượt giao dịch mỗi ngày của cửa hàng loại A | transactions, stores | thiếu cận trên; chia 31 |
| scm-j4-ncc-co-lo-truot-theo-dc | 5 | debug | easy | A3 | after_sales | Số nhà cung cấp có lô trượt cao bất thường | purchase_orders, suppliers | COUNT(*) thay COUNT(DISTINCT) |
| scm-j5-lead-time-theo-tuyen-kho | 5 | write | medium | A3 | operations | Tuyến kho nào có lead time dài nhất tháng 7/2017? | orders, sorting_hubs ×2 | nối một bảng hai lần; đơn huỷ |
| scm-j6-bien-ln-gop-nganh-hang | 5 | write | medium | A3 | finance | Ngành hàng nào có biên lợi nhuận gộp cao nhất? | sales, item_costs | trung bình tỷ lệ; thiếu cận trên |
| scm-j7-hang-loi-theo-dc-gap-doi | 5 | debug | medium | E2 | after_sales | Hàng lỗi theo DC cộng lại bị gấp đôi | purchase_orders, items, suppliers | nối theo family (fan-out) |
| scm-j8-ty-trong-ban-khuyen-mai | 5 | write | medium | A4 | marketing | Tỷ trọng bán khuyến mãi theo ngành hàng | sales, items | tỷ trọng theo số dòng; thiếu cận trên |
| scm-j9-don-mua-thang-7-moi-ncc | 5 | debug | easy | A3 | operations | Bảng đơn mua tháng 7/2017 thiếu nhà cung cấp | suppliers, purchase_orders | WHERE biến LEFT JOIN thành INNER; COUNT(*) |
| scm-q1-ncc-lead-time-tren-binh-quan | 6 | write | easy | C3 | operations | Nhà cung cấp nào giao chậm hơn bình quân 2016? | purchase_orders | phạm vi truy vấn con lệch truy vấn ngoài |
| scm-q2-ncc-co-lo-truot-thang-7 | 6 | write | easy | A1 | after_sales | Nhà cung cấp nào có đơn tháng 7/2017 bị trượt? | suppliers, purchase_orders | JOIN lặp dòng; thiếu cận trên |
| scm-q3-ban-hang-kho-thang-7 | 6 | write | easy | A2 | sales | Tháng 7/2017 chuỗi bán được bao nhiêu hàng khô? | sales, items | thiếu cận trên (hidden-1) |
| scm-q4-cua-hang-tren-binh-quan-loai | 6 | write | medium | C3 | sales | Cửa hàng nào bán vượt bình quân cùng loại? | sales, stores | chuẩn cả chuỗi; bình quân theo dòng |
| scm-q5-don-mua-gan-nhat-moi-ncc | 6 | write | medium | B4 | operations | Đơn gần nhất của mỗi nhà cung cấp về chưa? | suppliers, purchase_orders | nhiều đơn cùng ngày; MAX từng cột |
| scm-q6-ty-trong-von-ton-nganh-hang | 6 | write | easy | C2 | finance | Vốn tồn kỳ 2017-07 nằm ở ngành hàng nào? | inventory_snapshots, items | mẫu số cộng mọi kỳ |
| scm-q7-ma-khong-ban-duoc-ra-0 | 6 | debug | easy | E1 | sales | Số mã hàng không bán được tháng 7/2017 ra 0 | items, sales | cột không bí danh trong truy vấn con |
| scm-q8-ncc-loi-cao-hon-nganh | 6 | debug | medium | C3 | after_sales | Danh sách NCC lỗi cao thiếu ngành hàng ít lỗi | purchase_orders, suppliers | thiếu tương quan theo family |
| scm-q9-diem-giao-theo-nhom-gia-tri | 6 | debug | medium | C4 | customer | Hai nhóm điểm giao cộng lại vượt tổng số điểm | orders | phân nhóm ở mức đơn thay mức điểm giao |
| scm-c5-dc-nhan-hang-tre | case | case | easy (3 bước, 20 đ) | – | operations | Vì sao DC TP.HCM nhận hàng trễ nhiều? | purchase_orders, suppliers | quy mô thay tỷ lệ; nhầm khoảng cách với mức cam kết |
| scm-c6-cao-diem-giao-tre | case | case | medium (4 bước, 30 đ) | – | marketing | Vì sao ngày cao điểm năm 2016 giao trễ nhiều? | orders, event_calendar, sorting_hubs, warehouse_daily_ops | INNER JOIN mất ngày thường; thành phần dài nhất |
