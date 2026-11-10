# Đã sửa · gói 3 Supply Chain (scm) · v2 (10/11/2026)

Theo `REVIEW-B.md`, `REVIEW-C.md` và `BRIEF-SUA-GOI.md`. Không đổi `ma`, không sửa database hay biến thể ẩn.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| scm-j1-ban-theo-loai-cua-hang | B: yêu cầu viết "Tính Y của từng X" và thêm "kể cả dòng trả hàng"; dòng mở tab Nghiệp vụ dùng "phân bổ hàng" cho khớp bối cảnh; viết lại `\luuy`. Cảnh báo `WRONG_LOI_CHAY` do máy bận (đã chạy tay, rớt hidden-1) | tĩnh |
| scm-j2-ma-chua-tung-dat-mua | C: bối cảnh bỏ "đặt nhà cung cấp" | tĩnh |
| scm-j3-giao-dich-cua-hang-loai-a | B: tiêu đề 10 tiếng; vai đổi sang Quản lý vùng; bối cảnh bỏ "đón"; `\luuy` định nghĩa bằng lời, bỏ chữ "dòng" | tĩnh |
| scm-j4-ncc-co-lo-truot-theo-dc | C: tiêu đề 9 tiếng; bối cảnh viết "trung tâm phân phối"; câu kết bối cảnh đổi khác ví dụ của STYLE. Giữ wrong `dem_ncc_cua_dc` (C chỉ nói "có thể thay") | tĩnh |
| scm-j5-lead-time-theo-tuyen-kho | B: bối cảnh gọi "em" và nói "lead time của đơn"; yêu cầu giải nghĩa lead time; quy tắc bằng nhau ghi theo thứ tự chữ cái; `\luuy` bỏ cách nói "hai vai của cùng bảng" | tĩnh |
| scm-j6-bien-ln-gop-nganh-hang | C: tiêu đề 9 tiếng; bỏ "nặng ký"; ghi rõ sắp theo giá trị đã làm tròn (chặn chấm oan khi hoà ở hidden-1); bỏ khuôn "Tính cho từng X". Còn trùng chủ đề với scm-a8 (gói 2), chưa đổi (xem dưới) | tĩnh |
| scm-j7-hang-loi-theo-dc-gap-doi | B: tiêu đề 9 tiếng; giải nghĩa DC ở yêu cầu; bối cảnh "Em xem giúp chị"; viết lại `\luuy` | tĩnh |
| scm-j8-ty-trong-ban-khuyen-mai | C: tiêu đề bỏ "nhờ" (không còn ý nhân quả); bối cảnh dùng "tỷ trọng lượng bán khuyến mãi"; `\luuy` bỏ dấu hai chấm và "nặng như nhau"; sắp theo giá trị đã làm tròn | tĩnh |
| scm-j9-don-mua-thang-7-moi-ncc | B: `\luuy` bỏ phần kỹ thuật LEFT JOIN/WHERE (đã có ở gợi ý trả điểm), chỉ giữ quy tắc nghiệp vụ; dòng mở tab Nghiệp vụ đổi quyết định; tiêu đề 9 tiếng | tĩnh |
| scm-q1-ncc-lead-time-tren-binh-quan | C: tiêu đề 10 tiếng "bình quân"; bối cảnh viết lại (bỏ câu chép ví dụ STYLE, sửa trật tự từ); yêu cầu giải nghĩa lead time | tĩnh |
| scm-q2-ncc-co-lo-truot-thang-7 | B: tiêu đề và bối cảnh nói "đơn đặt trong tháng 7 bị trượt", khớp lọc `po_date`; yêu cầu ghi rõ `po_date`; `\luuy` nói rõ xét theo tháng đặt; vai đổi sang Nhân viên mua hàng (người gửi thư cho nhà cung cấp) | tĩnh |
| scm-q3-ban-hang-kho-thang-7 | C: vai đổi sang Điều phối vận hành, bối cảnh "xe chở hàng khô" | tĩnh |
| scm-q4-cua-hang-tren-binh-quan-loai | B: tiêu đề "bán vượt bình quân"; bối cảnh gọi "em"; yêu cầu bỏ phần mô tả cách làm hai tầng; `\luuy` định nghĩa thẳng, bỏ "không phải …" và câu đệm | tĩnh |
| scm-q5-don-mua-gan-nhat-moi-ncc | C: tiêu đề 10 tiếng; `\luuy` đúng chủ thể ("công ty đặt nhiều đơn với một nhà cung cấp"); ERD thêm `item_nbr:FK`. B (khuôn lặp): đổi người hỏi sang Anh Long, bối cảnh mới | tĩnh |
| scm-q6-ty-trong-von-ton-nganh-hang | B: **chấm oan**. Đổi quy tắc sắp thành `von_ton` giảm dần (33 giá trị khác nhau); solution và wrong `ORDER BY SUM(v.inventory_value) DESC`. Tiêu đề 8 tiếng; `\luuy` bỏ "không phải …"; đổi người hỏi (tránh lặp "Giám đốc tài chính hỏi" với j6) | bộ kiểm gói tạm: 0 lỗi, wrong rớt public + hidden-1 |
| scm-q7-ma-khong-ban-duoc-ra-0 | C: nhãn ERD bỏ chỗ chỉ cách sửa (thành "một mã, nhiều dòng bán"); `\luuy` thành định nghĩa nghiệp vụ "mã không bán được"; luật bí danh chuyển sang gợi ý nấc 2. Giữ wrong cũ (C chỉ đề xuất thay) | tĩnh |
| scm-q8-ncc-loi-cao-hon-nganh | B: tiêu đề nói đúng triệu chứng ("thiếu ngành hàng ít lỗi"); bối cảnh mô tả triệu chứng, không nói cách sửa; `\luuy` bỏ "truy vấn con"; yêu cầu ghi rõ phạm vi mẫu chuẩn; đổi người hỏi. Không thêm wrong trung bình `defect_rate` vì mỗi ngành chỉ 2 NCC nên wrong đó ra cùng kết quả | tĩnh |
| scm-q9-diem-giao-theo-nhom-gia-tri | C: tiêu đề 10 tiếng | tĩnh |
| scm-c5-dc-nhan-hang-tre | B: bối cảnh giải nghĩa DC, gọi "giúp chị"; b1 thêm dòng chỉ số OTD; `\luuy` "số đơn"; phương án đúng ghi "cách DC từ 70 tới 130 km"; lời giải thích phương án 1 bỏ khẳng định không có căn cứ; bỏ khuôn "Chưa đúng." ở hai phương án sai | tĩnh |
| scm-c6-cao-diem-giao-tre | C: **bước 3 đổi chỉ số**, từ tỷ lệ tải (`warehouse_daily_ops`, giống hệt nhau ở hai biến thể) sang thời gian phân loại theo kho đích tính từ `orders` (khác ở hidden-1); wrong b3 mới `theo_kho_xuat`. b2 ghi làm tròn cho `ty_le_dung_han_pct`. Viết lại 3 phương án, dài gần bằng nhau: phương án 1 giải thích đúng thứ tự (lớn thấp nhất; lễ và vừa gần bằng nhau); phương án 3 thay bằng nhầm chặng giao với chặng phân loại, có số liệu ở bước 2; phương án đúng dựa vào bước 2 và 3. Bỏ "Chưa đúng."; thống nhất "chặng"; `\luuy` bỏ gợi ý kỹ thuật; bối cảnh bỏ liệt kê ba vế. Bỏ khái niệm `ty-le-tai` (không còn dùng), thêm `lead-time-don` | bộ kiểm gói tạm: 0 lỗi, 3 wrong rớt public + hidden-1 |

Biên dịch lại cả gói: PDF 46 trang, 0 lỗi LaTeX, 0 ký tự thiếu. Phân tích tĩnh cả gói: 0 lỗi (cảnh báo duy nhất là file .md ngoài 4 file chuẩn).

## Chờ giảng viên

- **c6:** mảng `marketing` cho một case về vận hành ngày cao điểm (C hỏi). Đang giữ theo STYLE G.8 (ngày cao điểm thuộc marketing).
- **j8:** vai "Trưởng ngành hàng" hỏi so sánh mọi ngành hàng (C hỏi). Đang giữ.
- **q2:** B hỏi vai người gửi thư nhắc chất lượng. Đã đổi sang Nhân viên mua hàng, xin xác nhận.
- **j6 và scm-a8 (gói 2), j4 và scm-a2 (gói 2):** trùng ô dạng × mảng × cấp × hình thức giữa hai gói (ghi ở `BAN-DO-100-CAU.md`). j6 còn trùng cả chủ đề biên lợi nhuận gộp theo ngành hàng. Chưa đổi ở v2 vì phải viết lại cả câu; cần chốt gói nào đổi.
- **Quy ước "Chưa đúng."** trong lời giải thích phương án: STYLE G.4 cho phép, C đề nghị bỏ theo B.6. v2 đã bỏ ở c5, c6.
