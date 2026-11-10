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
| mkt-k6-do-chinh-xac-quy-tac | C: "luật" → "quy tắc kiểm tra" (tiêu đề, bối cảnh, yêu cầu, nghiệp vụ, gợi ý, ghi chú); liệt kê sáu cột số; công thức tỷ lệ viết bằng chữ; `\luuy` bỏ bị động; thêm wrong `quy_tac_ngay_bo_nhanh_ngoai_ky` | **bộ kiểm** (gói tạm) |
| mkt-k7-doi-tuong-tho-le-te | B1: tiêu đề "Đối tượng mục tiêu trên file thô ra nhiều nhóm lẻ tẻ"; B2: ví dụ đúng giá trị thật `'Youth  '`, bỏ câu gợi cách sửa | tĩnh |
| mkt-k8-nhieu-null-ra-0 | C1: `\luuy` không nói cách ghi `'NULL'` nữa; C3: bỏ "truy vấn", "hồ sơ ô trống" khỏi bối cảnh. C2 cấp: chờ giảng viên | tĩnh |
| mkt-k9-doanh-thu-sach-con-trung | B1–2: bối cảnh tách câu, "sửa lại cách tính"; `\luuy` không nói thẳng cách khử trùng | tĩnh |
| mkt-p1-ba-chi-so-mot-lan-quet | C: bỏ "nó", phá khuôn "Em viết lại giúp anh"; "làm tròn 4 chữ số thập phân"; `\luuy` không gợi cách gộp. Cấp: chờ giảng viên | tĩnh |
| mkt-p2-bao-cao-thang-3-theo-loai | B1: `ngansach` 2 → 3 (lời giải nối `calendar` theo `year`, `month` ra 2,03 lần không còn bị chấm oan; starter 12,4 lần và wrong bọc hàm vẫn vượt); rangbuoc ghi 3 lần; B2: tiêu đề "Báo cáo tháng 3/2025 theo loại chiến dịch chỉ đọc phần cần"; B3: bối cảnh tả triệu chứng | **bộ kiểm** (gói tạm) |
| mkt-p3-top-3-doanh-thu-moi-thuong-hieu | C (lỗi nặng): bỏ phạm vi ngày 8/3 (hai biến thể giống hệt, chép hằng số qua, không có hoà). Nay xét cả kỳ: hidden-1 đổi top 3 Nykaa và có hoà thật ở hạng 3 (`NY-CMP-53612` = `NY-CMP-56543`). Truy vấn con tương quan trên cả kỳ quá giờ, nên truy vấn khởi đầu đổi thành ba nhánh `UNION ALL` theo thương hiệu, ràng buộc `quettoida={campaigns=1}`; wrong `RANK()` rớt hidden-1 (4 dòng Nykaa), `LIMIT 3` rớt public. Viết lại tiêu đề, bối cảnh, `\luuy`, gợi ý. Giữ `ma` | **bộ kiểm** (gói tạm) |
| mkt-p4-ctr-kenh-email-whatsapp | B1–2, B4: tiêu đề "CTR của chiến dịch có kênh Email hoặc WhatsApp so với mức chung"; bối cảnh không còn chữ SQL, phá khuôn; "của thương hiệu"; B3: bỏ "nhắn tin trực tiếp", gọi đúng tên kênh; `\luuy` bỏ câu gợi cách làm | tĩnh |
| mkt-p5-dang-chay-moi-ngay-nhanh | C: tiêu đề 10 tiếng; bối cảnh bỏ "truy vấn", phá khuôn; `\luuy` không nói mốc 3/12/2024 (chỉ còn ở gợi ý) | tĩnh |
| mkt-p6-dong-trung-du-lieu-tho | B1–2: bỏ "nó"; bối cảnh tả triệu chứng, phá khuôn; `\luuy` nối hai cách hiểu "cùng mã" và "trùng hoàn toàn" | tĩnh |
| mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | C: tiêu đề thành câu hỏi kinh doanh; mục chỉ mục ghi rõ "máy chỉ chấm bảng kết quả, phần chỉ mục là tự luyện, không chấm"; `\luuy` "Đề hỏi đối tượng mục tiêu…". Cấp: chờ giảng viên | **bộ kiểm** (gói tạm) |
| mkt-p8-bao-cao-thang-cham-va-sai | B1: `\luuy` không nói thẳng hai lỗi; B2: bối cảnh "…chạy lâu mà… lại thấp hơn số chị lọc trên file" | tĩnh |
| mkt-p9-chi-phi-tich-luy-thuong-hieu | C1: "giải ngân" → "chi tiêu"; C2: `\luuy` không nói bẫy chia theo thương hiệu. Cấp: chờ giảng viên | tĩnh |
| mkt-c9-dung-ban-tho-duoc-khong | B1: giải thích phương án đúng sửa số ("khoảng 0,1%", không còn "dưới một phần nghìn"); B2: cân độ dài ba phương án, cả ba cùng có vế "nên có thể…", phương án đúng bớt vế rào; B3: "kéo" → "làm tổng giảm"; B4: `\luuy` "Đây là dữ liệu tổng hợp…" | tĩnh |
| mkt-c10-don-ngan-sach-loai-kenh | C1: viết lại ba phương án cùng khuôn ("… nên có đủ căn cứ / chưa có căn cứ…"), độ dài gần nhau, phương án đúng một câu; dòng mở nghiệp vụ bỏ "hoặc giữ nguyên phân bổ"; `\luuy` bỏ câu gợi kết luận; C2: giải thích bước 4 "loại nào cũng có nhiều tháng dưới mức chung"; C3: "chênh nhau chưa tới 0,05" thay "vài phần trăm"; C4: "Cả kỳ." → "Xét mọi chiến dịch trong kỳ dữ liệu."; bỏ "của tổng của", "nó" | tĩnh |

## Bổ sung sau khi `mkt_hidden_1` có nhóm trùng 3 dòng

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| mkt-k2-dong-trung-hoan-toan | `mkt_hidden_1` có thêm bản chép thứ ba của `PU-CMP-31194` (Purplle 47 dòng thừa trong 46 nhóm trùng). Thêm wrong `dem_nhom_thay_dong_thua` (đếm số nhóm trùng thay vì số dòng thừa, cộng doanh thu mỗi nhóm một lần): trùng solution ở public, rớt ở hidden-1. Sửa `\ghichuthietke` cho đúng (bỏ câu "không dùng làm bài sai"). SQL solution và hai wrong cũ không đổi | **bộ kiểm** gói tạm `cong-cu/ket-qua/sua/mkt-goi-5-k2/` (chỉ k2): **KIEM TRA: 0 loi**; biên dịch lại cả gói: 59 trang, 0 lỗi LaTeX |

## Chờ giảng viên (đã quyết ở v3, xem mục "Quyết định v3 (10/11)")

- **Cấp** p1 (kỹ thuật bậc Cơ bản của CHOT mục 4, đang Trung bình), k8 (sửa một toán tử, đang Trung bình), p9 (đang Khó, độ khó gần Trung bình), p7 (một phép lọc và một phép nối, đang Trung bình). Giữ nguyên cấp theo bản đồ.
- **p3**: kỹ thuật của truy vấn khởi đầu đổi từ "đếm tương quan" sang "ba nhánh theo thương hiệu" (gần bậc Dễ của CHOT mục 4) để có hoà thật ở hidden-1 mà không quá giờ; giữ cấp Khó nhờ bẫy hoà và hàm cửa sổ. Mã câu giữ theo bản đồ dù tên mã còn chữ "tuong-quan".
- **p4**: Email và WhatsApp có xếp chung là "kênh liên hệ trực tiếp" được không (B3); bản v2 gọi đúng tên hai kênh.
- **k4**: kết quả nhánh `'00-00-0000'` phụ thuộc `sql_mode` mặc định có NO_ZERO_DATE của máy chấm.

## Quyết định v3 (10/11)

BG = `lesson1_marketing_analytics_foundations.md`, thư mục `Project 01 Marketing Analytics Foundations & Data Pipeline` (ổ H:). QĐC = `QUYET-DINH-CHUNG.md`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `mkt-k4-phan-loai-ngay-loi` | Nhánh `'00-00-0000'` phụ thuộc `sql_mode` | Giữ câu; máy chấm chạy `sql_mode` mặc định MySQL 8.0 (có `NO_ZERO_DATE`, `NO_ZERO_IN_DATE`). | BG IV.B.7 liệt kê `00-00-0000` là ngày không hợp lệ (không parse được). Kiểm 10/11: `@@GLOBAL.sql_mode` của `sqllb-mysql` là mặc định; `STR_TO_DATE('00-00-0000','%d-%m-%Y')` ra NULL, đặt `sql_mode=''` thì ra `0000-00-00`. | Thêm mục "Chế độ SQL (`sql_mode`) của máy chấm" vào `mysql/README-mkt.md`. |
| `mkt-k8-nhieu-null-ra-0` | Sửa một toán tử, đang Trung bình | **Hạ Dễ.** | QĐC 2.3 mục 18 (Sửa lỗi Dễ = lỗi logic một chỗ). | `cap=easy`; ERD còn 2 bảng có chữ trên đường nối (bỏ `campaigns_raw`); `\ghichuthietke`; bản đồ. |
| `mkt-p1-ba-chi-so-mot-lan-quet` | Kỹ thuật bậc Cơ bản, đang Trung bình | **Hạ Cơ bản.** | QĐC 2.3 mục 18; CHOT mục 4 (gộp nhiều lần quét vào một lần gom = mẫu Cơ bản); không có bẫy dữ liệu riêng, một bảng, nên không đủ điều kiện nâng Dễ (QĐC 2.1). | `cap=basic`; ERD 1 bảng có giá trị mẫu (dòng `NY-CMP-1000`); `\ghichuthietke`; bản đồ. |
| `mkt-p9-chi-phi-tich-luy-thuong-hieu` | Khó gần Trung bình | Giữ Khó (2 bẫy: thiếu `PARTITION BY`, thiếu cận trên ở hidden-1). | QĐC 2.3 mục 18. | Không đổi. |
| `mkt-p7-chien-dich-ngay-8-3-theo-chi-muc` | Một lọc, một nối | Giữ Trung bình. | QĐC 2.3 mục 18. | `\ghichuthietke` bỏ "chờ giảng viên", ghi lý do. |
| `mkt-p3-top-3-doanh-thu-moi-thuong-hieu` (cũ `mkt-p3-top-3-khong-dem-tuong-quan`) | Starter đổi sang ba nhánh; mã còn "tuong-quan" | Giữ Khó; đổi mã. | QĐC 2.3 mục 19; BAO-CAO 3.6. | Đổi `ma` đồng bộ; ERD giữ 5 bảng chỉ khoá (QĐC 1.3 bản 23:05, như mẫu o4); `\ghichuthietke`. |
| `mkt-p4-ctr-kenh-email-whatsapp` (cũ `mkt-p4-exists-thay-join-distinct`) | "Kênh liên hệ trực tiếp" cho Email và WhatsApp; mã tên kỹ thuật | Giữ v2: gọi đúng tên hai kênh, không gộp tên nhóm. Đổi mã. | BG II.A.2 mô tả hai kênh khác nhau: WhatsApp "tin nhắn marketing trực tiếp", Email "gửi email khuyến mãi đến khách hàng hiện có"; bài giảng không có nhóm "kênh liên hệ trực tiếp". | Đổi `ma` đồng bộ. |
| `mkt-k6`, `mkt-p2`, `mkt-p6` | Mã còn tên kỹ thuật (`luat`, `khong-dung-ham`, `tim-trung-khong-tu-noi`) | Đổi mã theo nội dung: `mkt-k6-do-chinh-xac-quy-tac`, `mkt-p2-bao-cao-thang-3-theo-loai`, `mkt-p6-dong-trung-du-lieu-tho`. | BAO-CAO 3.8 (gộp vào lượt đổi mã 3.6). | Đổi `ma` đồng bộ. |
| Lời nhắn "Sửa truy vấn dưới đây để …" (9 chỗ cả bộ) | Khung câu Sửa lỗi | Giữ. | Gói mẫu CHOT dùng khung này cho câu debug; đã giảm 8 chỗ ở lượt rà giọng. | Không đổi. |

Kiểm: bộ kiểm đầy đủ gói 5 (public + hidden-1) **KIEM TRA: 0 loi**; biên dịch lại (xem cuối mục).

### Sửa lúc 23:15 theo QUYET-DINH-CHUNG bản 23:05 (đối chiếu quy chuẩn)

- Kết luận case (QĐC 0.1 #1, theo `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4): lời giải thích của phương án đúng mở bằng "Đúng: "; phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Áp cho mọi case của gói.
- ERD Khó (QĐC 0.1 #4): p3 trả lại hai bảng nhiễu, giữ đủ 5 bảng chỉ khoá như mẫu o4.

### Chuẩn hoá theo quy chuẩn (10/11, BRIEF-CHUAN-HOA)

Xem `../CHUAN-HOA.md` (tiêu đề ≤ 13 tiếng, gợi ý nấc cuối, kết luận case ≤ 35 tiếng, ERD theo CHOT mục 3, cấp). File hồ sơ chuyển từ `goi-5/` sang `ho-so/goi-5/`.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Căn cứ: `BRIEF-CAP-DO-MODULE.md`; `quy_chuan/lo-trinh-sql/assets/js/data.js` (Module 9: Cơ bản "HAVING COUNT > 1", Dễ "LEFT JOIN … IS NULL", "NOT EXISTS"; Module 10: Cơ bản "đếm có điều kiện", Dễ "GROUP BY thay UNION ALL", "lọc năm dùng được chỉ mục"); CHOT-FORMAT mục 3 (ERD theo cấp), mục 4 (optimize: Cơ bản ba truy vấn con → đếm có điều kiện, Dễ nhiều nhánh `UNION ALL` → một `GROUP BY`); HD mục 5, 6; QUYET-DINH-CHUNG 1.3, 2.1–2.2. Mục tiêu mỗi module: 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Mẫu làm theo: mục v4 của `goi-cau-hoi/hr/ho-so/goi-5/DA-SUA.md`.

| Module | Trước (CB · Dễ · TB · Khó) | Sau |
|---|---|---|
| M9 Data Quality | 0 · 2 · 3 · 4 (k7, k8 Dễ; k1, k2, k3 TB; k4, k5, k6, k9 Khó) | 2 · 3 · 2 · 2 (k1, k9 · k5, k7, k8 · k2, k3 · k4, k6) |
| M10 Query Performance | 1 · 0 · 4 · 4 (p1 · – · p2, p4, p7, p8 · p3, p5, p6, p9) | 2 · 3 · 2 · 2 (p1, p6 · p2, p5, p8 · p4, p7 · p3, p9) |

Đổi 7 câu, đúng số tối thiểu (M9 thừa 1 TB, 2 Khó, thiếu 2 CB, 1 Dễ → 3 câu; M10 thừa 2 TB, 2 Khó, thiếu 1 CB, 3 Dễ → 4 câu). Trong đó viết lại nội dung 4 câu (k5, k9, p5, p6), hạ cấp có sửa đề và SQL 2 câu (k1, p8), hạ cấp chỉ sửa ERD, gợi ý, ghi chú 1 câu (p2). Tỷ lệ hình thức giữ nguyên: M9 6 write + 3 debug; M10 6 optimize + 2 write + 1 debug. Case c9, c10 giữ nguyên (Khó). k4 giữ nguyên, kể cả ghi chú phụ thuộc `sql_mode` mặc định (mục "Chế độ SQL" của `mysql/README-mkt.md`).

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `mkt-k1-ho-so-null` (giữ mã) | write TB → CB (E1, operations) | Giữ câu hỏi đếm ô trống sáu cột số theo thương hiệu; bỏ nối `brands` (trả `brand_id` thay `brand_name`) và bảng `noise_log`; ERD 1 bảng có giá trị mẫu (dòng `NY-CMP-1936` trống `revenue`); lưu ý nói ô trống nạp thành NULL; gợi ý 2 nấc. Wrong: `COUNT(cot)` đếm ô có giá trị; `COUNT(DISTINCT campaign_id)` làm số dòng (bỏ dòng trùng) | 1 bảng · 1 tầng gom theo một cột (như bài CB "HAVING COUNT > 1" của M9) · cột, cách đếm ghi rõ, ERD có giá trị mẫu · 0 bẫy dữ liệu · 1 khái niệm: CB 5/5 |
| `mkt-k5-doi-soat-doanh-thu-tho-sach` → `mkt-k5-dong-doanh-thu-lech-ban-sach` | write Khó → Dễ (E2, finance) | Nội dung mới: ghép từng dòng thô với bản sạch theo `campaign_id`, đếm dòng ghi doanh thu khác bản sạch (kể cả doanh thu trống) và cộng doanh thu bản sạch của các dòng đó, theo thương hiệu. Đối soát tổng sau làm sạch vẫn có ở c9 bước 4. ERD 2 bảng, chữ trên đường nối. Wrong: chỉ so `<>` (mất dòng doanh thu trống), cộng doanh thu thô | 2 bảng có `JOIN` · 2 tầng (nối và lọc, gom) · định nghĩa dòng lệch ghi trong đề · 1 bẫy (NULL trong phép so) · 1 phép cộng: Dễ 5/5 |
| `mkt-k9-doanh-thu-sach-con-trung` → `mkt-k9-ma-lap-ra-ca-file` | debug Khó → CB (E2 finance → E1 operations) | Nội dung mới, bài CB "dòng trùng" của M9 ở dạng Sửa lỗi: starter liệt kê mã lặp của Purplle nhưng viết `HAVING COUNT(*) >= 1` (ra 55.555 mã); sửa thành `> 1`. ERD 1 bảng có giá trị mẫu (`PU-CMP-11110` ở vị trí 55586). Wrong: `> 2` (public 0 dòng, hidden-1 còn `PU-CMP-31194` 3 dòng), gom cả `row_index`, quên lọc Purplle | sửa một lỗi dễ thấy (sai toán tử) · 1 bảng · 1 tầng gom có điều kiện nhóm · 0 bẫy · 1 khái niệm: CB 5/5 |
| `mkt-p2-bao-cao-thang-3-theo-loai` (giữ mã) | optimize TB → Dễ (A3, marketing) | Đúng bài Dễ "lọc năm dùng được chỉ mục" của M10, áp cho một tháng; đề và SQL giữ nguyên (đã đạt Dễ trên 4/5 trục, nhãn TB trước đây đến từ ERD 3 bảng). ERD 3 → 2 bảng, chữ trên đường nối (bỏ `campaign_types`); gợi ý 1 hỏi thêm số ngày của tháng 3; thêm `can-tren-thang` vào khoá `bay` (wrong `BETWEEN` tới 30/3 đã có) | 1 bảng (mức CB) · 2 tầng (lọc, gom) · cột, tháng ghi rõ · 1 bẫy (cận trên của tháng) · 1 phép chia (CTR của nhóm): Dễ 4/5 |
| `mkt-p5-dang-chay-moi-ngay-nhanh` → `mkt-p5-chi-phi-roi-bon-quy-mot-lan-quet` | optimize Khó → Dễ (B4 operations → B1 finance) | Nội dung mới đúng mẫu Dễ CHOT mục 4 (như o2): starter bốn nhánh `UNION ALL`, mỗi quý một nhánh, tính số chiến dịch, chi phí, ROI của tổng; lời giải lọc cả kỳ một lần và gom theo chuỗi quý. `quettoida={campaigns=1}` (starter 4 lần). ERD 2 bảng (`calendar` dùng được để lấy quý). Wrong: thiếu cận trên (rớt hidden-1, thêm `'2025-Q3'`), `AVG(roi)` | 1 bảng · 2 tầng · cột, dạng quý, làm tròn ghi rõ · 1 bẫy (cận trên, hidden-1) · 1 công thức một phép chia: Dễ 5/5 |
| `mkt-p6-dong-trung-du-lieu-tho` → `mkt-p6-thoi-luong-purplle-mot-lan-quet` | optimize Khó → CB (E1 → A3, operations) | Nội dung mới đúng mẫu CB CHOT mục 4 (như o1): starter ba truy vấn con đếm chiến dịch Purplle tháng 5/2025 theo nhóm thời lượng ngắn, vừa, dài; lời giải đếm có điều kiện trong một lần đọc. `quettoida={campaigns=1}` (starter 3 lần). ERD 1 bảng có giá trị mẫu (`PU-CMP-10740`). Bỏ chủ đề dòng trùng vì M9 đã có k2, k9. Wrong: nhóm vừa từ 10 ngày (đếm hai lần), quên lọc Purplle | 1 bảng · 1 tầng đếm · cột, khoảng ghi rõ, ERD có giá trị mẫu · 0 bẫy · 1 khái niệm: CB 5/5 |
| `mkt-p8-bao-cao-thang-cham-va-sai` → `mkt-p8-so-chien-dich-theo-thang-lech` | debug TB → Dễ (B1, sales → marketing) | Starter cũ hai lỗi (tháng 30 ngày; lịch không có cận trên) → nay lịch có cận trên, còn một lỗi logic một chỗ (tháng 30 ngày, thấy ngay trên public: tháng 31 ngày thiếu, tháng 2 thừa); bỏ cột doanh thu, mảng đổi sang `marketing` (nhịp mở chiến dịch) để tránh ô B1 · sales · easy · debug của `mkt-s8`; viết lại tiêu đề, lời nhắn; ERD 2 bảng, đường nối `canhbao`. Wrong: gom một lần thiếu cận trên (rớt hidden-1), khoảng 31 ngày, nối lịch với tháng 30 ngày | sửa một lỗi logic một chỗ · 2 bảng · 2 tầng · cột, kỳ ghi rõ · 1 bẫy (độ dài tháng) · 1 khái niệm: Dễ 5/5 |

Kiểm lại: bộ kiểm đầy đủ cả gói (`cong-cu/ket-qua/cap-do/mkt-goi-5/`, public + hidden-1) → **KIEM TRA: 0 loi**, 0 cảnh báo, chạy ba lần (lần 2, 3 sau khi sửa ghi chú p5, rút ngắn chữ trên đường nối ERD của k5, p2, p5, p8 và xuống dòng SQL dài của p8). Mọi wrong mới rớt đúng biến thể ghi trong `\ghichuthietke` (thiếu cận trên của p5, p8 chỉ rớt hidden-1; các wrong khác rớt cả hai). Kết quả public khác hidden-1 ở cả 7 câu đổi (biến thể (a) bỏ chiến dịch đuôi 7; k9 thêm `PU-CMP-31194` 3 dòng). Optimize đo được: p5 starter quét `campaigns` 4 lần / 833.341 dòng trung gian, lời giải 1 lần / 333.342; p6 starter 3 lần / 19.768, lời giải 1 lần / 4.942; p2 starter 181.251 so với lời giải 14.596 dòng trung gian (ngân sách 3 lần). Mọi solution mới chạy dưới 2 giây (k5 1,9 giây, các câu khác dưới 1 giây). Biên dịch XeLaTeX `cong-cu/ket-qua/cap-do/mkt-goi-5/bien-dich/`: 59 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo `aio-sql-cauhoi` (37 overfull hbox của dòng SQL, ERD dài có từ trước, chỉ là cảnh báo trình bày). Thư mục gói vẫn đúng 4 file. Đếm lại `cap=` trong `cau-hoi.tex`: k 2 · 3 · 2 · 2, p 2 · 3 · 2 · 2, case 2 Khó.

Sửa kèm: dòng chú thích đầu khối của K7 ghi đúng cấp Dễ (cũ còn "Trung bình").

Cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6), tự đọc lại mọi trường của 7 câu đổi: không có "Hãy…", "đáng chú ý", "một cách…", ẩn dụ, dấu gạch ngang dài; lời nhắn đúng vai, xưng anh/chị/em (thực tập sinh ở câu Sửa lỗi Cơ bản k9, Data engineer ở câu Tối ưu, kế toán quản trị ở câu đối soát doanh thu); bối cảnh không nhắc tên kỹ thuật SQL (p5 nói "ghép bốn đoạn giống nhau", không nói `UNION ALL`; p6 nói "ba lần đọc bảng"). Thuật ngữ theo STYLE-mkt mục A: "bản thô", "bản sạch", "ô trống (NULL)", "dòng trùng hoàn toàn", "đơn vị tiền", "tỷ lệ của tổng"; ROI giải nghĩa ở khái niệm. Còn một chỗ bị động nhẹ, giữ vì tự nhiên: `\luuy` của k1 "được nạp vào bản thô thành NULL".

Ô (dạng × mảng × cấp × hình thức) của 7 câu đổi: E1·ops·basic·W (k1), E2·fin·easy·W (k5), E1·ops·basic·D (k9), A3·mkt·easy·O (p2), B1·fin·easy·O (p5), A3·ops·basic·O (p6), B1·mkt·easy·D (p8). Không trùng ô nào trong gói, cũng không trùng gói 1–4 theo bản đồ hiện có (p8 đổi mảng để tránh trùng `mkt-s8`). Gần nội dung, không trùng ô: k1 với `mkt-n9` (gói 1, Sửa lỗi Dễ đếm ô trống CPA theo thương hiệu) và c9 bước 1; k9 với k2 (cùng chủ đề dòng trùng: k9 tìm mã, k2 tính dòng thừa và doanh thu thừa) và `mkt-a8`; k5 với c9 bước 4 và `mkt-c6`; p8 với `mkt-s8` (cùng báo cáo theo tháng, lỗi khác); p5 với `mkt-a9` (doanh thu theo quý, Sửa lỗi TB). Ô trùng có sẵn từ trước, không do v4: k6 cùng ô E2·ops·hard·W với `mkt-t4` (gói 4), k8 cùng ô E1·ops·easy·D với `mkt-n9` (gói 1). Dòng bản đồ mới (đủ cột, kèm mã cũ) ở `BAN-DO-V4-DONG.md`; `BAN-DO-100-CAU.md` không sửa (agent gói khác đang sửa song song).
