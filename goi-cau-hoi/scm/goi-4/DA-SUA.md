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
