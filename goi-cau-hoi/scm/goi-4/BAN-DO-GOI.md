# Bản đồ gói 4 · Supply Chain (scm)

Tự phân bổ (chưa có `goi-cau-hoi/scm/BAN-DO-100-CAU.md` lúc soạn) theo `BRIEF-SOAN-GOI.md` mục "Phân bổ":
gói 4 = Module 7 CTE & Set Operations (tiền tố `t`) + Module 8 Window Functions (tiền tố `f`), mỗi module 6 write + 3 debug,
cấp Trung bình/Khó (mỗi module có câu Trung bình), + case c7 (Trung bình, 4 bước) và c8 (Khó, 5 bước).
Không hai câu trùng ô dạng × mảng × cấp × hình thức.

| Mã | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|
| scm-t1-ton-tren-ban-nganh-hang | 7 | write | medium | A3 | sales | Ngành hàng nào tồn nhiều so với lượng bán tháng 7/2017? | inventory_snapshots, sales, items | nối thẳng hai mức chi tiết (fan-out); thiếu cận trên (hidden-1) |
| scm-t2-chuyen-giao-cua-hang-18 | 7 | write | hard | B1 | operations | Tháng nào năm 2016 cửa hàng 18 không nhận hàng? | shipments | WITH RECURSIVE sinh tháng; COUNT(*) sau LEFT JOIN |
| scm-t3-ma-hang-can-ra-soat | 7 | write | medium | A1 | after_sales | Ngành hàng nào có nhiều mã cần rà soát nhất? | purchase_orders, items | UNION ALL đếm trùng |
| scm-t4-ty-le-lo-truot-ncc | 7 | debug | medium | A2 | after_sales | Bảng tỷ lệ lô trượt năm 2016 thiếu nhà cung cấp | purchase_orders | INNER JOIN hai CTE mất dòng; quên COALESCE |
| scm-t5-nhap-xuat-dc | 7 | debug | hard | E2 | operations | Lượng xuất của DC năm 2016 cao bất thường | purchase_orders, suppliers, shipments | nhân dòng theo NCC + lọc nhầm po_date (2 lỗi) |
| scm-t6-von-ton-theo-loai-cua-hang | 7 | debug | medium | A3 | finance | Vốn tồn theo loại cửa hàng thấp hơn sổ kế toán | inventory_snapshots, stores, items | UNION bỏ dòng trùng; sửa dở (thêm store_nbr, giữ UNION) |
| scm-t7-ncc-duoi-chuan | 7 | write | hard | C3 | operations | Nhà cung cấp nào kém chuẩn giao hàng năm 2016? | purchase_orders, suppliers | chuẩn không trọng số; biên đúng hạn |
| scm-t8-diem-giao-huy-cao | 7 | write | medium | C3 | customer | Điểm giao nào có tỷ lệ huỷ cao hơn cả miền? | orders | thiếu cận trên; chuẩn miền là trung bình tỷ lệ |
| scm-t9-huy-theo-nhom-ap-ma | 7 | write | medium | A2 | marketing | Nhóm áp mã nào huỷ đơn nhiều hơn trong tháng 7/2017? | orders | dòng tổng bằng trung bình tỷ lệ; thiếu cận trên |
| scm-f1-top3-hang-tuoi-song | 8 | write | medium | C1 | sales | Ba mã hàng tươi sống nào bán chạy nhất mỗi ngành? | sales, items | RANK hoà hạng DAIRY (hidden-1); thiếu PARTITION BY |
| scm-f2-fill-rate-theo-thang | 8 | write | medium | B2 | operations | Fill rate từng tháng năm 2017 thay đổi ra sao? | inventory_snapshots | gồm kỳ chưa đủ 2017-08; trung bình tỷ lệ dòng |
| scm-f3-luy-ke-cua-hang-44 | 8 | write | medium | B3 | sales | Cửa hàng 44 đạt chỉ tiêu tháng 7/2017 tới đâu? | sales | thiếu cận trên (hidden-1); OVER () |
| scm-f4-ngay-don-tang-dot-bien | 8 | write | hard | B3 | marketing | Ngày nào quý 4/2016 có số đơn tăng đột biến? | orders | khung gồm ngày hiện tại; lọc trước khi trượt |
| scm-f5-hang-abc-beverages | 8 | write | hard | C2 | finance | Mỗi hạng ABC của ngành BEVERAGES có bao nhiêu mã? | sales, item_costs | thiếu cận trên (hidden-1); luỹ kế tăng dần |
| scm-f6-giao-dich-cung-ky | 8 | write | hard | B2 | customer | Lượt giao dịch năm 2017 tăng bao nhiêu so cùng kỳ? | transactions, stores | LAG 1 thay LAG 12; lọc trước khi LAG; không loại cửa hàng mở trong kỳ |
| scm-f7-cua-hang-dong-khach-nhat | 8 | debug | medium | C1 | customer | Danh sách cửa hàng đông khách nhất chỉ ra một dòng | transactions, stores | thiếu PARTITION BY |
| scm-f8-luy-ke-nhan-hang-ncc | 8 | debug | hard | B3 | operations | Luỹ kế nhận hàng tháng 7/2017 lệch phiếu nhập | purchase_orders | khung RANGE mặc định khi trùng ngày + thiếu PARTITION BY (2 lỗi) |
| scm-f9-huy-thang-truoc-theo-kho | 8 | debug | medium | B2 | after_sales | Mức thay đổi tỷ lệ huỷ tháng 1 của các kho bị sai | orders | LAG thiếu PARTITION BY |
| scm-c7-fill-rate-thang-3 | case | case | medium (4 bước) | – | operations | Vì sao fill rate tháng 3/2017 giảm mạnh? | inventory_snapshots, items | LAG; bình quân ngày (tháng 2 ít ngày); quy mô thay tỷ lệ |
| scm-c8-giao-tre-ngay-cao-diem | case | case | hard (5 bước) | – | marketing | Vì sao ngày cao điểm năm 2016 giao trễ nhiều? | orders, event_calendar, warehouse_daily_ops | thành phần dài nhất ≠ tăng nhiều nhất; kho nhỏ |

Phân bố mảng: operations 6 (gồm c7), sales 3, after_sales 3, customer 3, marketing 3 (gồm c8), finance 2.
Phân bố cấp (18 câu module): medium 11, hard 7.
