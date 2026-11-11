# Bản đồ gói 4 · Supply Chain (scm)

Tự phân bổ (chưa có `goi-cau-hoi/scm/BAN-DO-100-CAU.md` lúc soạn) theo `BRIEF-SOAN-GOI.md` mục "Phân bổ":
gói 4 = Module 7 CTE & Set Operations (tiền tố `t`) + Module 8 Window Functions (tiền tố `f`), mỗi module 6 write + 3 debug,
+ case c7 (Trung bình, 4 bước) và c8 (Khó, 5 bước).
Không hai câu trùng ô dạng × mảng × cấp × hình thức.

**v4 (11/11/2026, `BRIEF-CAP-DO-MODULE.md`):** mỗi module đủ 4 cấp theo lộ trình chuẩn: 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Đổi 10 câu (t3, t4, t6, t7, t9, f3, f4, f5, f7, f9), chi tiết ở `DA-SUA.md` mục v4.

| Mã | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|
| scm-t1-ton-tren-ban-nganh-hang | 7 | write | medium | A3 | sales | Ngành hàng nào tồn nhiều so với lượng bán tháng 7/2017? | inventory_snapshots, sales, items | nối thẳng hai mức chi tiết (fan-out); thiếu cận trên (hidden-1) |
| scm-t2-chuyen-giao-cua-hang-18 | 7 | write | hard | B1 | operations | Tháng nào năm 2016 cửa hàng 18 không nhận hàng? | shipments | WITH RECURSIVE sinh tháng; COUNT(*) sau LEFT JOIN |
| scm-t3-ma-hang-can-ra-soat | 7 | write | easy | A3 | after_sales | Ngành hàng nào có nhiều mã cần rà soát nhất? | purchase_orders, items | UNION ALL đếm trùng; thiếu cận trên |
| scm-t4-nhap-xuat-ton-cua-hang-3 | 7 | debug | basic | A2 | operations | Lượng nhập tháng 7 của cửa hàng 3 bằng đúng lượng bán | inventory_snapshots | vế nhập cộng nhầm cột `sold` |
| scm-t5-nhap-xuat-dc | 7 | debug | hard | E2 | operations | Lượng xuất của DC năm 2016 gấp nhiều lần sổ kho | purchase_orders, suppliers, shipments | nhân dòng theo NCC + lọc nhầm po_date (2 lỗi) |
| scm-t6-von-ton-binh-quan-loai-cua-hang | 7 | debug | easy | A3 | finance | Vốn tồn bình quân theo loại cửa hàng thấp hơn sổ kế toán | inventory_snapshots, stores | UNION bỏ dòng trùng; sửa dở (thêm ym, giữ UNION) |
| scm-t7-ma-thieu-hut-nhieu-ky | 7 | write | basic | C4 | operations | Mã hàng ở cửa hàng 44 thiếu hụt trong mấy kỳ? | inventory_snapshots | thiếu cận trên (kỳ 2017-08); `thieu_hut >= 0` |
| scm-t8-diem-giao-huy-cao | 7 | write | medium | C3 | customer | Điểm giao nào có tỷ lệ huỷ cao hơn cả miền? | orders | thiếu cận trên; chuẩn miền là trung bình tỷ lệ |
| scm-t9-huy-theo-nhom-ap-ma | 7 | write | easy | A2 | marketing | Nhóm áp mã nào huỷ đơn nhiều hơn trong tháng 7/2017? | orders | dòng tổng bằng trung bình tỷ lệ; thiếu cận trên |
| scm-f1-top3-hang-tuoi-song | 8 | write | medium | C1 | sales | Ba mã hàng tươi sống nào bán chạy nhất mỗi ngành? | sales, items | RANK hoà hạng DAIRY (hidden-1); thiếu PARTITION BY |
| scm-f2-fill-rate-theo-thang | 8 | write | medium | B2 | operations | Fill rate từng tháng năm 2017 thay đổi ra sao? | inventory_snapshots | gồm kỳ chưa đủ 2017-08; trung bình tỷ lệ dòng |
| scm-f3-luy-ke-cua-hang-44 | 8 | write | easy | B3 | sales | Cửa hàng 44 đạt chỉ tiêu tháng 7/2017 tới đâu? | sales | thiếu cận trên (hidden-1); OVER () |
| scm-f4-don-so-voi-hom-truoc | 8 | write | easy | B2 | marketing | Số đơn tháng 11/2016 thay đổi ra sao so với hôm trước? | orders | lọc trước khi LAG; đếm cả đơn huỷ |
| scm-f5-xep-hang-ngay-tai-kho | 8 | write | basic | C1 | operations | Trong tuần 12/12/2016, mỗi kho tải nặng nhất vào ngày nào? | warehouse_daily_ops | RANK khi hai ngày bằng nhau; thiếu PARTITION BY |
| scm-f6-giao-dich-cung-ky | 8 | write | hard | B2 | customer | Lượt giao dịch năm 2017 tăng bao nhiêu so cùng kỳ? | transactions, stores | LAG 1 thay LAG 12; lọc trước khi LAG; không loại cửa hàng mở trong kỳ |
| scm-f7-cua-hang-dong-khach-nhat | 8 | debug | easy | C1 | customer | Danh sách cửa hàng đông khách nhất chỉ ra một dòng | transactions, stores | thiếu PARTITION BY |
| scm-f8-luy-ke-nhan-hang-ncc | 8 | debug | hard | B3 | operations | Luỹ kế nhận hàng tháng 7/2017 lệch phiếu nhập | purchase_orders | khung RANGE mặc định khi trùng ngày + thiếu PARTITION BY (2 lỗi) |
| scm-f9-thay-doi-ty-le-huy-thang | 8 | debug | basic | B2 | after_sales | Tháng đầu năm 2017 lại có mức thay đổi tỷ lệ huỷ | orders | sắp giảm dần trong OVER (so với tháng sau) |
| scm-c7-fill-rate-thang-3 | case | case | medium (4 bước) | – | operations | Fill rate tháng 3/2017 giảm do bán tăng hay nhập giảm? | inventory_snapshots, items | LAG; bình quân ngày (tháng 2 ít ngày); quy mô thay tỷ lệ |
| scm-c8-giao-tre-ngay-cao-diem | case | case | hard (5 bước) | – | marketing | Vì sao ngày cao điểm cuối năm 2016 giao trễ nhiều? | orders, event_calendar, warehouse_daily_ops | thành phần dài nhất ≠ tăng nhiều nhất; kho nhỏ |

Phân bố mảng (20 câu): operations 8 (gồm c7), sales 3, customer 3, marketing 3 (gồm c8), after_sales 2, finance 1.
Phân bố cấp (18 câu module, v4): basic 4, easy 6, medium 4, hard 4; mỗi module 2 · 3 · 2 · 2.
