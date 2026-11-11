# Bản đồ gói 5 · Supply Chain (`scm`)

Chưa có `goi-cau-hoi/scm/BAN-DO-100-CAU.md` khi soạn (10/11/2026), nên gói tự phân bổ theo BRIEF-SOAN-GOI.md mục "Phân bổ":
gói 5 = Module 9 Data Quality (tiền tố `k`) + Module 10 Query Performance (tiền tố `p`) + 2 case cấp Khó (`c9`, `c10`).

| # | Mã | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Điểm lạ / kỹ thuật chính |
|---|---|---|---|---|---|---|---|---|
| 1 | `scm-k1-ban-khong-co-ton-kho` | 9 | write | easy | E2 | sales | Mã hàng nào có bán nhưng thiếu số tồn kho kỳ 2017-07? | cửa hàng 47, 51: cặp 47/205209 chỉ có dòng trả hàng, không có tồn kho kỳ 2017-07 (dòng thiếu cặp); hidden-1 thêm 51/903285 |
| 2 | `scm-k2-ngay-le-ghi-hai-dong` | 9 | write | medium | E1 | marketing | Ngày nào có hai dòng lễ ở cùng địa phương? | `holidays` trùng theo (ngày, địa phương) |
| 3 | `scm-k3-co-dung-han-mau-thuan` | 9 | debug | medium | E1 | customer | Kiểm tra cờ đúng hạn báo nhầm đơn | 2 đơn giao bằng cam kết mà `on_time` = 0; starter dùng `<` |
| 4 | `scm-k4-giao-dich-thap-bat-thuong` | 9 | write | medium | E1 | customer | Lượt giao dịch thấp bất thường vào ngày nào? | ngoại lai so với trung bình riêng của cửa hàng |
| 5 | `scm-k5-tuan-khong-co-chuyen-giao` | 9 | write | medium | D3 | operations | Cửa hàng nào có tuần không nhận chuyến giao nào? | 6 cửa hàng có tuần trống giữa giai đoạn hoạt động |
| 6 | `scm-k6-doi-soat-don-can-xu-ly` | 9 | write | hard | E2 | operations | Đơn cần xử lý của kho có khớp sổ đơn? | `orders_to_process` = mọi đơn kể cả huỷ; 2 ngày không có đơn |
| 7 | `scm-k7-doi-soat-nhan-su` | 9 | debug | medium | E2 | operations | Đối soát nhân sự kho ra số ngày quá lớn | nối thiếu cột ngày; DC_HANOI ghi `headcount` thấp hơn `staffing_plan` |
| 8 | `scm-k8-ban-hai-nguon-lech` | 9 | debug | hard | E2 | sales | Lượng bán tháng 7 của hai nguồn lệch rất xa | fan-out + thiếu cận trên; `sold` không trừ hàng trả |
| 9 | `scm-k9-doanh-thu-hai-nguon` | 9 | write | hard | E2 | finance | Ngành hàng nào có doanh thu hai nguồn lệch nhau nhiều nhất? | đối soát theo tiền, gom `sales` theo mã hàng trước |
| 10 | `scm-p1-po-theo-kiem-dinh` | 10 | optimize | basic | A2 | after_sales | Đơn mua theo kết quả kiểm định với một lần quét | 3 truy vấn con → đếm có điều kiện; `purchase_orders=1` |
| 11 | `scm-p2-don-kho-ve-tinh-theo-nam` | 10 | optimize | easy | B1 | after_sales | Tỷ lệ huỷ đơn của kho vệ tinh theo năm chỉ với một lần quét | UNION ALL 3 nhánh → GROUP BY; `orders=1, sorting_hubs=1` |
| 12 | `scm-p3-ncc-cham-hon-nganh` | 10 | optimize | medium | C3 | operations | Nhà cung cấp chậm hơn mức ngành chỉ với một lần quét | tính lại phép gom → `AVG() OVER`; `purchase_orders=1` |
| 13 | `scm-p4-ty-trong-von-ton-nganh` | 10 | optimize | medium | C2 | finance | Tỷ trọng vốn tồn theo ngành hàng chỉ với một lần quét | quét lại để lấy tổng → `SUM(SUM()) OVER ()` |
| 14 | `scm-p5-luy-ke-giao-dich-thang-7` | 10 | optimize | hard | B3 | customer | Luỹ kế giao dịch tháng 7 không tự nối bảng | tự nối `<=` → `SUM() OVER`; `transactions=1`, ngansach=2 |
| 15 | `scm-p6-don-truot-7-ngay` | 10 | optimize | hard | B3 | operations | Tổng đơn cần xử lý 7 ngày gần nhất chỉ với một lần quét | tự nối BETWEEN → `ROWS BETWEEN 6 PRECEDING`; ngansach=2 |
| 16 | `scm-p7-ty-le-dung-han-sau-khi-gop` | 10 | debug | medium | A2 | operations | Tỷ lệ giao đúng hạn theo miền lệch báo cáo cũ | gộp lần quét sai mẫu số (đơn huỷ) |
| 17 | `scm-p8-voucher-dem-hai-lan` | 10 | debug | medium | A3 | marketing | Đơn có voucher bị đếm hai lần sau khi tách truy vấn | tách OR thành hai nhánh: UNION ALL đếm hai lần đơn thoả cả hai điều kiện |
| 18 | `scm-p9-bao-cao-kho-thang-7` | 10 | write | hard | A3 | operations | Từng kho vận hành ra sao trong tháng 7/2017? | gộp hai báo cáo, gom trước khi nối |
| 19 | `scm-c9-kho-ha-noi-qua-tai` | case | case | hard (5 bước) | – | operations | Vì sao kho Hà Nội quá tải năm 2016? | vận hành + kế hoạch nhân sự + lịch sự kiện |
| 20 | `scm-c10-do-dung-hoc-tap-thieu-hut` | case | case | hard (5 bước) | – | sales | Vì sao đồ dùng học tập thiếu hụt tháng 7/2017? | tồn kho + đơn mua + nhà cung cấp |

Module 9: 6 write + 3 debug (1 Dễ, 5 Trung bình, 3 Khó). Module 10: 6 optimize (Cơ bản, Dễ, 2 Trung bình, 2 Khó) + 2 debug + 1 write.
Không có hai câu trùng ô dạng × mảng × cấp × hình thức.

Sửa sau khi đối chiếu `BAN-DO-100-CAU.md` (17:44): `scm-p7` đổi mảng `after_sales` → `operations` (ô A2 · after_sales · Trung bình · Sửa lỗi đã có `scm-t4` của gói 4);
câu `scm-p8-don-thang-7-bi-hut` (BETWEEN trên `created_at` mất ngày 31/7) trùng bẫy với `scm-r8` của gói 1 nên thay bằng `scm-p8-voucher-dem-hai-lan`. |  |  |  |  |  |  | Đơn có voucher bị đếm hai lần sau khi tách truy vấn
