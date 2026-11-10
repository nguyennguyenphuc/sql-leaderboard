# Đã sửa · bộ Marketing (`mkt`) · gói 5 (v2)

Theo `REVIEW-B.md`, `REVIEW-C.md` và lời nhắn điều phối 10/11/2026. Không sửa database hay biến thể ẩn.
Kiểm lại: gói tạm `cong-cu/ket-qua/sua/mkt-goi-5/` (k6, p2, p3, p7: các câu sửa SQL hoặc yêu cầu) chạy bộ kiểm thật;
cả gói chạy `--chi-phan-tich` → **KIEM TRA: 0 loi**; biên dịch `cong-cu/ket-qua/bien-dich/mkt-goi-5/` → 0 lỗi LaTeX.

| Mã | Đã sửa (theo điểm của B/C) | Kiểm lại |
|---|---|---|
| mkt-k1-ho-so-null | B1–3: bỏ "hồ sơ ô trống" ở bối cảnh và `\luuy`; "Chọn những cột…" | tĩnh |
| mkt-k2-dong-trung-hoan-toan | C1: bối cảnh hết sai chiều ("không khớp" thay "cao hơn"; dữ liệu thô thật ra thấp hơn bản sạch); "bị cộng thừa bao nhiêu doanh thu"; C2: tiêu đề "Dữ liệu thô thừa bao nhiêu dòng chép lặp?" | tĩnh |
| mkt-k3-pheu-vo-ly | B1: CTR (tỷ lệ nhấp); B2: "dòng có tầng sau…"; B3: tách yêu cầu đếm thành hai mục, giải nghĩa click, lead; B4: "hai nguyên nhân" | tĩnh |
| mkt-k4-phan-loai-ngay-loi | C: `\luuy` bỏ khuôn "mệnh đề: kết luận"; yêu cầu tách mỗi loại một mục; nêu kỳ là "12 tháng của lịch, 1/7/2024 tới hết 30/6/2025" để khỏi lệch khái niệm kỳ dữ liệu | tĩnh |
| mkt-k5-doi-soat-doanh-thu-tho-sach | B1: `\luuy` bỏ vế nói trước dấu kết quả và cách sửa; B2: bối cảnh nói rõ "bỏ dòng trùng và dòng doanh thu lỗi" | tĩnh |
| mkt-k6-do-chinh-xac-luat | C: "luật" → "quy tắc kiểm tra" (tiêu đề, bối cảnh, yêu cầu, nghiệp vụ, gợi ý, ghi chú); liệt kê sáu cột số; công thức tỷ lệ viết bằng chữ; `\luuy` bỏ bị động; thêm wrong `quy_tac_ngay_bo_nhanh_ngoai_ky` | **bộ kiểm** (gói tạm) |
| mkt-k7-doi-tuong-tho-le-te | B1: tiêu đề "Đối tượng mục tiêu trên file thô ra nhiều nhóm lẻ tẻ"; B2: ví dụ đúng giá trị thật `'Youth  '`, bỏ câu gợi cách sửa | tĩnh |
| mkt-k8-nhieu-null-ra-0 | C1: `\luuy` không nói cách ghi `'NULL'` nữa; C3: bỏ "truy vấn", "hồ sơ ô trống" khỏi bối cảnh. C2 cấp: chờ giảng viên | tĩnh |
| mkt-k9-doanh-thu-sach-con-trung | B1–2: bối cảnh tách câu, "sửa lại cách tính"; `\luuy` không nói thẳng cách khử trùng | tĩnh |
| mkt-p1-ba-chi-so-mot-lan-quet | C: bỏ "nó", phá khuôn "Em viết lại giúp anh"; "làm tròn 4 chữ số thập phân"; `\luuy` không gợi cách gộp. Cấp: chờ giảng viên | tĩnh |
| mkt-p2-loc-thang-khong-dung-ham | B1: `ngansach` 2 → 3 (lời giải nối `calendar` theo `year`, `month` ra 2,03 lần không còn bị chấm oan; starter 12,4 lần và wrong bọc hàm vẫn vượt); rangbuoc ghi 3 lần; B2: tiêu đề "Báo cáo tháng 3/2025 theo loại chiến dịch chỉ đọc phần cần"; B3: bối cảnh tả triệu chứng | **bộ kiểm** (gói tạm) |
| mkt-p3-top-3-khong-dem-tuong-quan | C (lỗi nặng): bỏ phạm vi ngày 8/3 (hai biến thể giống hệt, chép hằng số qua, không có hoà). Nay xét cả kỳ: hidden-1 đổi top 3 Nykaa và có hoà thật ở hạng 3 (`NY-CMP-53612` = `NY-CMP-56543`). Truy vấn con tương quan trên cả kỳ quá giờ, nên truy vấn khởi đầu đổi thành ba nhánh `UNION ALL` theo thương hiệu, ràng buộc `quettoida={campaigns=1}`; wrong `RANK()` rớt hidden-1 (4 dòng Nykaa), `LIMIT 3` rớt public. Viết lại tiêu đề, bối cảnh, `\luuy`, gợi ý. Giữ `ma` | **bộ kiểm** (gói tạm) |
| mkt-p4-exists-thay-join-distinct | B1–2, B4: tiêu đề "CTR của chiến dịch có kênh Email hoặc WhatsApp so với mức chung"; bối cảnh không còn chữ SQL, phá khuôn; "của thương hiệu"; B3: bỏ "nhắn tin trực tiếp", gọi đúng tên kênh; `\luuy` bỏ câu gợi cách làm | tĩnh |
| mkt-p5-dang-chay-moi-ngay-nhanh | C: tiêu đề 10 tiếng; bối cảnh bỏ "truy vấn", phá khuôn; `\luuy` không nói mốc 3/12/2024 (chỉ còn ở gợi ý) | tĩnh |
| mkt-p6-tim-trung-khong-tu-noi | B1–2: bỏ "nó"; bối cảnh tả triệu chứng, phá khuôn; `\luuy` nối hai cách hiểu "cùng mã" và "trùng hoàn toàn" | tĩnh |
| mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | C: tiêu đề thành câu hỏi kinh doanh; mục chỉ mục ghi rõ "máy chỉ chấm bảng kết quả, phần chỉ mục là tự luyện, không chấm"; `\luuy` "Đề hỏi đối tượng mục tiêu…". Cấp: chờ giảng viên | **bộ kiểm** (gói tạm) |
| mkt-p8-bao-cao-thang-cham-va-sai | B1: `\luuy` không nói thẳng hai lỗi; B2: bối cảnh "…chạy lâu mà… lại thấp hơn số chị lọc trên file" | tĩnh |
| mkt-p9-chi-phi-tich-luy-thuong-hieu | C1: "giải ngân" → "chi tiêu"; C2: `\luuy` không nói bẫy chia theo thương hiệu. Cấp: chờ giảng viên | tĩnh |
| mkt-c9-dung-ban-tho-duoc-khong | B1: giải thích phương án đúng sửa số ("khoảng 0,1%", không còn "dưới một phần nghìn"); B2: cân độ dài ba phương án, cả ba cùng có vế "nên có thể…", phương án đúng bớt vế rào; B3: "kéo" → "làm tổng giảm"; B4: `\luuy` "Đây là dữ liệu tổng hợp…" | tĩnh |
| mkt-c10-don-ngan-sach-loai-kenh | C1: viết lại ba phương án cùng khuôn ("… nên có đủ căn cứ / chưa có căn cứ…"), độ dài gần nhau, phương án đúng một câu; dòng mở nghiệp vụ bỏ "hoặc giữ nguyên phân bổ"; `\luuy` bỏ câu gợi kết luận; C2: giải thích bước 4 "loại nào cũng có nhiều tháng dưới mức chung"; C3: "chênh nhau chưa tới 0,05" thay "vài phần trăm"; C4: "Cả kỳ." → "Xét mọi chiến dịch trong kỳ dữ liệu."; bỏ "của tổng của", "nó" | tĩnh |

## Bổ sung sau khi `mkt_hidden_1` có nhóm trùng 3 dòng

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| mkt-k2-dong-trung-hoan-toan | `mkt_hidden_1` có thêm bản chép thứ ba của `PU-CMP-31194` (Purplle 47 dòng thừa trong 46 nhóm trùng). Thêm wrong `dem_nhom_thay_dong_thua` (đếm số nhóm trùng thay vì số dòng thừa, cộng doanh thu mỗi nhóm một lần): trùng solution ở public, rớt ở hidden-1. Sửa `\ghichuthietke` cho đúng (bỏ câu "không dùng làm bài sai"). SQL solution và hai wrong cũ không đổi | **bộ kiểm** gói tạm `cong-cu/ket-qua/sua/mkt-goi-5-k2/` (chỉ k2): **KIEM TRA: 0 loi**; biên dịch lại cả gói: 59 trang, 0 lỗi LaTeX |

## Chờ giảng viên

- **Cấp** p1 (kỹ thuật bậc Cơ bản của CHOT mục 4, đang Trung bình), k8 (sửa một toán tử, đang Trung bình), p9 (đang Khó, độ khó gần Trung bình), p7 (một phép lọc và một phép nối, đang Trung bình). Giữ nguyên cấp theo bản đồ.
- **p3**: kỹ thuật của truy vấn khởi đầu đổi từ "đếm tương quan" sang "ba nhánh theo thương hiệu" (gần bậc Dễ của CHOT mục 4) để có hoà thật ở hidden-1 mà không quá giờ; giữ cấp Khó nhờ bẫy hoà và hàm cửa sổ. Mã câu giữ theo bản đồ dù tên mã còn chữ "tuong-quan".
- **p4**: Email và WhatsApp có xếp chung là "kênh liên hệ trực tiếp" được không (B3); bản v2 gọi đúng tên hai kênh.
- **k4**: kết quả nhánh `'00-00-0000'` phụ thuộc `sql_mode` mặc định có NO_ZERO_DATE của máy chấm.
