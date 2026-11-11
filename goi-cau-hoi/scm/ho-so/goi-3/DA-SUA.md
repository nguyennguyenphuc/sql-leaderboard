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

## Quyết định v3 (10/11)

Theo `BRIEF-QUYET-DINH-126.md` và `QUYET-DINH-CHUNG.md`. Mục "Chờ giảng viên" ở trên đã xử lý hết. Sách dự án = `SupplyChain\bai-giang\Final\capnhat_0711\project-supply-chain\main.tex` (eDA2026, bản 07/11).

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `scm-j6-bien-ln-gop-nganh-hang` → **`scm-j6-gmroi-theo-loai-cua-hang`** | Trùng ô và chủ đề với `scm-a8` (gói 2) | Viết lại sang GMROI theo loại cửa hàng, ô C4 · finance · Trung bình · write; **đổi mã** | QUYET-DINH-CHUNG 1.5; GMROI theo sách dự án Mục I.1.3 (dòng 909–924) và phần vốn tồn, vòng quay, GMROI (dòng 3695–3711: lợi nhuận gộp quy năm 365/31 chia vốn tồn kỳ 2017-07, tử số lấy `sold` của bảng tồn kho) | Viết lại cả câu (đề, ERD 3 bảng, Nghiệp vụ, gợi ý, ghi chú); thêm khái niệm `gmroi`; SQL mới: solution, wrong `quen_loc_ky` (E 2,11 thay 2,52), wrong `trung_binh_ty_le_tung_dong` (B 5,76 đứng đầu). hidden-1 khác public ở `von_ton`, `ln_gop`. Đổi mã đồng bộ ở `cau-hoi.tex`, `solution.sql`, `BANG-PHAN-CONG.md`, `BAN-DO-100-CAU.md` |
| `scm-j4-ncc-co-lo-truot-theo-dc` | Trùng ô với `scm-a2` | Giữ | QUYET-DINH-CHUNG 1.5 | Không sửa |
| `scm-c6-cao-diem-giao-tre` | Mảng `marketing` cho case vận hành ngày cao điểm | Giữ `marketing` | STYLE-scm G.8; sách dự án dòng 7539 (ngày cao điểm là ngày sale hoặc lễ) và dòng 3148 (`Events` là sự kiện hoặc chiến dịch): ngày cao điểm do lịch chiến dịch quyết định | Không sửa |
| `scm-j8-ty-trong-ban-khuyen-mai` | Vai "Trưởng ngành hàng" hỏi mọi ngành | Giữ | Trưởng ngành hàng so ngành mình với các ngành khác khi xin ngân sách khuyến mãi | Không sửa |
| `scm-q2-ncc-co-lo-truot-thang-7` | Vai người gửi thư nhắc chất lượng | Xác nhận Nhân viên mua hàng (v2) | Bộ phận mua hàng là đầu mối làm việc với nhà cung cấp về đơn mua và lô trượt | Không sửa |
| Kết luận case | c5, c6 | "Đúng: " ở phương án đúng, phương án sai không tiền tố | QUYET-DINH-CHUNG 1.1 (sửa theo quy_chuan 23:05) | Đổi tiền tố, xem dòng cuối mục |

- Kết luận case (QUYET-DINH-CHUNG 1.1, sửa theo quy_chuan 23:05, gói mẫu c1–c4): phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Đã đổi ở mọi case của gói.
- Kiểm lại 10/11 (sau mọi sửa v3): bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/kiem-cuoi/scm-goi-<k>/`) → **KIEM TRA: 0 loi**; phân tích tĩnh bản cuối → 0 lỗi; biên dịch `cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu (chỉ cảnh báo Overfull hbox).

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu thành 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug. Căn cứ: `quy_chuan/lo-trinh-sql/assets/js/data.js` (M5: Cơ bản `j1-don-kem-vung` nối hai bảng, Khó `j6-mua-cung-don`; M6: Cơ bản `q1-tren-gia-trung-binh` truy vấn con một giá trị, Khó `q6-don-dau-tien` truy vấn con tương quan có tiêu chí phụ), thang 5 trục ở `QUYET-DINH-CHUNG.md` mục 2.2, ERD theo CHOT-FORMAT mục 3.

| Module | Trước (B · D · TB · K) | Sau | Hình thức sau |
|---|---|---|---|
| M5 Joins | 0 · 5 · 4 · 0 | 2 · 3 · 2 · 2 | 6 write + 3 debug (debug: j9 Cơ bản, j4 Dễ, j7 Trung bình) |
| M6 Subqueries | 0 · 5 · 4 · 0 | 2 · 3 · 2 · 2 | 6 write + 3 debug (debug: q7 Dễ, q9 Trung bình, q8 Khó) |

Đổi 8 câu (số tối thiểu: mỗi module 2 câu Dễ xuống Cơ bản, 2 câu Trung bình lên Khó). Giữ nguyên j1, j2, j4, j5, j7, q1, q2, q4, q7, q9 và hai case.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `scm-j3-giao-dich-cua-hang-loai-a` → `scm-j3-giao-dich-loai-a-ngay-15-7` | Dễ → Cơ bản | Từ lượt giao dịch bình quân cả tháng 7 sang tổng lượt giao dịch của cửa hàng loại A trong một ngày (15/7/2017); A2 · customer giữ. ERD 2 bảng có giá trị mẫu (`date`, `type`) và chữ trên đường nối (phép nối cần đủ hai bảng, như bài Cơ bản j1 của lộ trình). SQL mới; wrong `quen_loc_loai` (public), `dem_cua_hang_trong_danh_muc` (hidden-1: một cửa hàng loại A mất số liệu ngày 15/7) | 2 bảng · 1 tầng (nối, lọc, đếm, cộng) · đề ghi rõ cột và giá trị · 0 bẫy (một ngày, hết cận trên) · 1 khái niệm, không công thức → 4/5 Cơ bản |
| `scm-j9-don-mua-thang-7-moi-ncc` (giữ mã) | Dễ → Cơ bản | Starter còn một lỗi dễ thấy: INNER JOIN thay cho LEFT JOIN (điều kiện ngày đã trong `ON`, đã đếm `COUNT(p.po_id)`). Hai lỗi cũ của starter (ngày trong WHERE, COUNT(*)) thành hai wrong, cùng rớt ở public. Gợi ý viết lại; bối cảnh, ERD cảnh báo giữ | Lỗi một chỗ dễ thấy (mức Sửa lỗi Cơ bản) · đề ghi rõ, ERD tô đỏ đường nối · 0 bẫy ngoài lỗi được chỉ · 1 khái niệm → Cơ bản (số bảng 2, số tầng 2 vẫn ở mức Dễ). Gỡ ô trùng A3 · operations · easy · debug với `scm-a6` |
| `scm-j6-gmroi-theo-loai-cua-hang` → `scm-j6-doanh-thu-m2-theo-loai-cua-hang` | Trung bình → Khó | Viết lại: doanh thu trên m² theo loại cửa hàng tháng 7/2017 và mức chênh so với cả chuỗi (A3 · sales). GMROI tính trọn trên bảng tồn kho nên không nâng được bằng bẫy nối thật; câu mới nối hai nguồn khác mức chi tiết (dòng bán và diện tích cửa hàng). Thêm khái niệm `doanh-thu-tren-m2`, bỏ khai báo `gmroi` (không còn câu nào dùng), `fan-out` thêm ví dụ bảng bán hàng. ERD 6 bảng chỉ khoá, 2 bảng nhiễu, `\erdkhoa`. Wrong: cộng diện tích trên từng dòng bán (public), trung bình tỷ số từng cửa hàng (public), thiếu cận trên (chỉ hidden-1) | 4 bảng · 4 tầng (doanh thu theo cửa hàng, ghép diện tích, gom loại, so cả chuỗi) · ngôn ngữ kinh doanh + `\erdkhoa` · 3 bẫy, một bẫy chỉ ở hidden-1 · chỉ số hai thành phần + so chuẩn → 5/5 Khó |
| `scm-j8-ty-trong-ban-khuyen-mai` → `scm-j8-giao-dich-ngay-le-dia-phuong` | Trung bình → Khó | Viết lại: mức tăng lượt giao dịch ngày lễ địa phương 2016 so với các ngày còn lại, theo thành phố (C3 · marketing). Nối `holidays` theo hai điều kiện không qua khoá (ngày và `locale_name = stores.city`), loại lễ bị dời, gộp cặp cửa hàng – ngày. Thêm khái niệm `ngay-le-dia-phuong`. ERD 5 bảng chỉ khoá, 2 bảng nhiễu, `\erdkhoa`. Wrong: nối chỉ theo ngày (public), tính cả lễ bị dời (public, TP.HCM 25/7/2016), không gộp dòng lễ trùng (chỉ hidden-1, Phan Thiết 2/3/2016) | 3 bảng · 4 tầng · ngôn ngữ kinh doanh + `\erdkhoa` · 3 bẫy, một bẫy chỉ ở hidden-1 · chỉ số nhiều điều kiện (loại lễ, địa bàn, lễ bị dời) → 5/5 Khó |
| `scm-q3-ban-hang-kho-thang-7` → `scm-q3-hang-tuoi-song-cua-hang-44` | Dễ → Cơ bản | Từ hàng khô cả chuỗi tháng 7 (bẫy cận trên) sang hàng tươi sống của cửa hàng 44 ngày 1/7/2017; vẫn `IN (SELECT …)`. ERD 2 bảng có giá trị mẫu (`date`, `store_nbr`, `perishable`). Wrong: nhầm hàng khô, quên lọc cửa hàng (cùng rớt ở public); hidden-1 bỏ dòng bán mã đuôi 7 nên tổng khác | 2 bảng · 1 tầng · đề ghi rõ cột và giá trị · 0 bẫy · 1 khái niệm → 4/5 Cơ bản |
| `scm-q6-ty-trong-von-ton-nganh-hang` → `scm-q6-ty-trong-von-ton-cua-hang-45` | Dễ → Cơ bản | Từ tỷ trọng vốn tồn của mọi ngành hàng (nối `items`, gom nhóm) sang tỷ trọng vốn tồn của một cửa hàng trên cả chuỗi, kỳ 2017-07; một bảng, truy vấn con một giá trị như bài Cơ bản q1 của lộ trình. ERD 1 bảng có giá trị mẫu. Wrong: mẫu số cộng mọi kỳ, trả tỷ lệ 0–1 (cùng rớt ở public) | 1 bảng · 1 tầng · đề ghi rõ cột, giá trị và cách lấy mẫu số · 0 bẫy ngoài điều đề đã ghi · 1 khái niệm → 5/5 Cơ bản |
| `scm-q5-don-mua-gan-nhat-moi-ncc` → `scm-q5-don-da-ve-gan-nhat-moi-ncc` | Trung bình → Khó | Từ đơn gần nhất sang đơn đã về gần nhất của mỗi NCC, thêm thành phố DC nhận hàng và số ngày trễ so với ngày hẹn; sắp theo số ngày trễ. Cùng mẫu với bài Khó q6 của lộ trình. ERD 5 bảng chỉ khoá, 2 bảng nhiễu, `\erdkhoa`. Wrong: lấy cả đơn chưa về (33/66 NCC có đơn mới nhất đang chờ), nối theo ngày lớn nhất (nhiều dòng), MAX từng cột (cùng rớt ở public). hidden-1 có cặp đơn cùng ngày của `SUP_002` (`PO_9000001` trượt kiểm định) | 3 bảng · 4 tầng (truy vấn con tương quan có lọc và sắp, nối đơn, nối DC, số ngày trễ) · ngôn ngữ kinh doanh + `\erdkhoa` · 3 bẫy public + 1 cặp hoà chỉ ở hidden-1 · chỉ số nhiều điều kiện → 5/5 Khó |
| `scm-q8-ncc-loi-cao-hon-nganh` (giữ mã) | Trung bình → Khó | Starter thêm lỗi thứ hai chồng lên lỗi cũ: tỷ lệ hàng lỗi lấy trung bình `defect_rate` (sai định nghĩa chỉ số), cùng với truy vấn con không tương quan. Yêu cầu nói rõ hai lỗi như mẫu d4. ERD trung tính 5 bảng chỉ khoá, 3 bảng nhiễu (lời giải dùng 2 bảng), `\erdkhoa`. Wrong mới: chỉ sửa tương quan, chỉ sửa định nghĩa tỷ lệ; giữ wrong tương quan theo `supplier_id` | 2–3 lỗi chồng nhau (mức Sửa lỗi Khó) · 3 tầng · ngôn ngữ kinh doanh, ERD trung tính · chỉ số so chuẩn của chính ngành, định nghĩa từ tổng số lượng → Khó (số bảng 2 như mẫu d4) |

Ô dạng × mảng × cấp × hình thức của 8 câu mới không trùng trong gói và không trùng ô nào đang có trong `BAN-DO-100-CAU.md` (đọc lúc 11/11): A2 · customer · basic · write; A3 · operations · basic · debug; A3 · sales · hard · write; C3 · marketing · hard · write; A2 · sales · basic · write; C2 · finance · basic · write; B4 · operations · hard · write; C3 · after_sales · hard · debug. Các gói khác đang đổi cấp song song nên có thể sinh trùng mới; người gộp bản đồ cần đối chiếu lại.

Kiểm v4 (11/11): bộ kiểm đầy đủ cả gói trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/cap-do/scm-goi-3/bao-cao-import.json`) → **KIEM TRA: 0 loi**, 0 cảnh báo; mọi wrong mới rớt đúng biến thể ghi ở trên; solution của 8 câu mới đều khác nhau giữa public và hidden-1. Phân tích tĩnh lại sau ba chỗ sửa chữ cuối → 0 lỗi. Biên dịch `cong-cu/bien_dich.sh` (`cong-cu/ket-qua/cap-do/scm-goi-3/bien-dich/`) → PDF 52 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 33 cảnh báo Overfull hbox. Thời gian chạy đo lúc máy MySQL đang chạy bộ kiểm của nhiều gói cùng lúc: j6 khoảng 29 giây (cùng kiểu quét cả tháng `sales` như j1 cùng lúc 21 giây, q4 131 giây); các câu mới khác dưới 8 giây. Cần đo lại j6 khi máy rảnh.

Chủ đề cần lưu ý (không trùng ô): `scm-n6` (gói 1) và `scm-k2` (gói 5) cùng dùng lịch ngày lễ, sự kiện nhưng hỏi chỉ số khác; `scm-q3` mới dùng cửa hàng 44 như `scm-r4`, `scm-s5`, `scm-a5`, `scm-c4`.

## Sửa theo KIEM-V4 (11/11/2026)

Đầu vào: `../KIEM-V4-B.md`, `../KIEM-V4-C.md`. Quy tắc trùng ô theo đính chính 11/11: cấm trùng trong cùng gói; khác gói được phép, trừ khi trùng cả chủ đề. Không đổi cấp câu nào; không sửa database, biến thể ẩn.

**Cách chữa câu chậm.** Không dùng `IGNORE INDEX` hay gợi ý chỉ mục như B đề xuất: học viên viết tự nhiên sẽ không có gợi ý nên vẫn chậm. Thay vào đó thu phạm vi dữ liệu để MySQL tự chọn kế hoạch nhanh: lọc một cửa hàng (dùng khoá chính `inventory_snapshots` hoặc chỉ mục cửa hàng của `sales`), hoặc thu kỳ đủ ngắn để dùng chỉ mục ngày (`sales` ≤ 3 ngày, `orders` ≤ 1 quý; với kỳ dài hơn, MySQL ước lượng sai và quét theo chỉ mục cột gom). Đo bằng `docker exec … mysql` (gồm cả khởi động client), 3 lần mỗi biến thể, lúc 2 bộ kiểm khác đang chạy song song; "tự nhiên" là bài viết lại không nhìn solution (`BETWEEN`, `USING`, `AVG() OVER`…), kết quả khớp solution.

Khái niệm dùng chung đồng bộ ở cả 5 gói (và `style/STYLE-scm.md`): `ngay-cao-diem` → "Ngày cao điểm, ngày nền và ngày thường" (định nghĩa cả ba loại ngày, "mỗi dòng là một ngày sự kiện"); `lead-time-don` → bản bốn thành phần, ô dữ liệu gộp ghi chú của gói 3 (kho xuất, kho đích) và gói 5 (giờ có phần lẻ, mốc thời gian).

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm, thời gian đo |
|---|---|---|---|
| `scm-j6-doanh-thu-m2-theo-loai-cua-hang` | B: solution 19,5–34,4 giây (quét 3,3 triệu dòng `sales`); đề xuất gom trước + `IGNORE INDEX (idx_sales_store_item)` (vẫn 9,8–12,1 giây) | **Không áp gợi ý chỉ mục.** Bảng `sales` chỉ có tháng 7/2017, nên "cả tháng 7" là cả bảng. Thu kỳ về 29–31/7/2017 (≈ 320 nghìn dòng, MySQL dùng chỉ mục ngày; kỳ 5 ngày trở lên MySQL lại đi theo chỉ mục cửa hàng). Kỳ vẫn kết thúc 31/7 nên wrong thiếu cận trên vẫn chỉ rớt hidden-1 (dòng 2017-08-01 cửa hàng 44); thứ tự năm loại (E, D, A, B, C) giữ nguyên. Sửa tiêu đề ("Loại cửa hàng nào tạo doanh thu trên m² cao nhất?"), bối cảnh, yêu cầu 1, ghi chú; solution và 3 wrong đổi cận dưới `'2017-07-29'` | Trước: 12,7 giây (máy vừa), 28,6–34,4 (máy bận). Sau: solution 2,9–3,2 / 2,4–2,6 giây; bài viết thêm hai truy vấn con cho mức chuỗi 5,5–7,2. Wrong fan-out, trung bình tỷ số rớt public; thiếu cận trên rớt hidden-1. bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-3/`) → KIEM TRA: 0 loi, 0 cảnh báo |
| `scm-j1-ban-theo-loai-cua-hang` | Coordinator: đo thêm (HANDOFF 31 giây; B đo 21–36,6) | Cùng cách với j6: thu về 29–31/7/2017. Sửa tiêu đề "Loại cửa hàng nào bán nhiều nhất ba ngày cuối tháng 7/2017?", bối cảnh, yêu cầu 1, `\luuy`, ghi chú; solution và 2 wrong | Trước: 11,7 giây (máy vừa), 21–36,6 (máy bận). Sau: solution 2,1–2,3 / 1,9–2,2 giây; bài tự nhiên (`USING`, `BETWEEN`) 1,8–2,7. bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-3/`) → KIEM TRA: 0 loi, 0 cảnh báo |
| `scm-q4-cua-hang-tren-binh-quan-loai` | Ngoài B/C: bộ kiểm V4 của B đo 157,7 / 89,9 giây, đo lại 46 giây (đọc cả bảng `sales` hai lần) | Thu kỳ về 29–31/7/2017; sửa bối cảnh, yêu cầu 1, ghi chú; solution và 2 wrong | Sau: solution 4,4–4,7 / 4,0–4,5 giây; bài tự nhiên (một CTE + `AVG() OVER`) 2,4–3,4. 2 wrong rớt public. bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-3/`) → KIEM TRA: 0 loi, 0 cảnh báo |
| `scm-j8-giao-dich-ngay-le-dia-phuong` | C: tiêu đề 14 tiếng | "Ngày lễ địa phương 2016 làm lượt giao dịch đổi ra sao?" (12 tiếng) | Chỉ sửa chữ |
| `scm-q5-don-da-ve-gan-nhat-moi-ncc` | B: tiêu đề 14 tiếng | "Đơn về gần nhất của mỗi nhà cung cấp có trễ hẹn không?" (13 tiếng). Giữ mã | Chỉ sửa chữ |
| `scm-q8-ncc-loi-cao-hon-nganh` | B: viết tắt "NCC" ở tiêu đề | "Danh sách nhà cung cấp lỗi cao thiếu ngành hàng ít lỗi" (12 tiếng) | Chỉ sửa chữ |
| Khái niệm `ngay-cao-diem`, `lead-time-don` | C (s9, lỗi lặp nhiều gói) | Đồng bộ bản dùng chung; c6 dùng "ngày thường", khớp định nghĩa mới | Phân tích tĩnh 0 lỗi |

Không áp: C tuỳ chọn đổi j8 sang mảng `customer` (ô trùng n6/j8 khác chủ đề, được phép; giữ `marketing`); C tuỳ chọn tiêu đề q6, ghi chú ERD 2 bảng của q3 (không bắt buộc).

- Kiểm cả gói sau sửa: bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-3/`) → KIEM TRA: 0 loi, 0 cảnh báo; phân tích tĩnh (`scm-goi-3-tinh`) 0 lỗi; biên dịch `cong-cu/bien_dich.sh` (`cong-cu/ket-qua/sua-v4/scm-goi-3/bien-dich/`) → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo aio-sql-cauhoi. Thư mục gói vẫn đúng 4 file. Module vẫn 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó; 0 ô trùng trong cùng gói.
