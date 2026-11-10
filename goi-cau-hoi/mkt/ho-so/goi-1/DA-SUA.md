# Đã sửa · Marketing gói 1 (v1 → v2)

Theo `REVIEW-B.md`, `REVIEW-C.md` và `BRIEF-SUA-GOI.md`. Không sửa database hay biến thể ẩn. Không đổi mã câu.

Kiểm lại:
- Gói tạm `cong-cu/ket-qua/sua/mkt-goi-1/` (r2, r5, r8, tức các câu sửa SQL hoặc yêu cầu), chạy thật trên `mkt` và `mkt_hidden_1`: **KIEM TRA: 0 loi**. r2 public 3 dòng, hidden-1 2 dòng; r5 19/18; r8 47/42. Mọi wrong rớt ở cả hai biến thể.
- Cả gói `--chi-phan-tich`: **KIEM TRA: 0 loi**, 20 câu 0 lỗi 0 cảnh báo. Còn cảnh báo `GOI_FILE_LA` vì các file .md ngoài gói.
- Biên dịch: `cong-cu/bien_dich.sh` → PDF 43 trang, 0 lỗi LaTeX, 0 ký tự thiếu (`cong-cu/ket-qua/bien-dich/mkt-goi-1/`).

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| `mkt-r1-influencer-purplle-thang-1` | B(1) tiêu đề "có trên 98.000 lượt hiển thị trong tháng 1/2025"; B(2) dòng mở nghiệp vụ (mở bằng "Quyết định"); B(3) "ký lại hợp đồng"; B(4) giải nghĩa Influencer lần đầu; B(5) gợi ý 1 "điều kiện ngày em đang viết". Phá khuôn "X là …, không phải Y" ở `\luuy`, bỏ câu `\luuy` nói sẵn cận dưới, cận trên. | phân tích tĩnh |
| `mkt-r2-working-women-tamil-tira` | C(1) đổi Tamil sang Hindi (`language_id = 3`) ở tiêu đề, bối cảnh, yêu cầu, ERD, solution, wrong: hidden-1 giờ khác public; C(2) tiêu đề; C(3) dòng mở nghiệp vụ; C(4) `\luuy` "Bảng chiến dịch có hai cột…"; C(5) ghi chú "thu hẹp còn một ngày", ghi lại lý do đổi. | bộ kiểm gói tạm: 0 lỗi |
| `mkt-r3-roi-thap-nhat-nykaa-q4` | B(1) tiêu đề "10 chiến dịch có ROI thấp nhất…"; B(2) gợi ý 1; B(3) ERD bỏ mã chiến dịch mẫu không khớp dòng thật (giữ giá trị mẫu chung). Dòng mở nghiệp vụ đổi sang "Xác định". | phân tích tĩnh |
| `mkt-r4-email-chuyen-doi-cao` | C(1) bối cảnh bỏ "mang về nhiều đơn nhất"; C(2) thống nhất "chiến dịch loại Email" ở tiêu đề, nghiệp vụ, "chiến dịch email" chỉ trong lời nhắn; C(3) gợi ý 1 "Kênh Email có trùng với loại Email không?". | phân tích tĩnh |
| `mkt-r5-chien-dich-30-ngay-cuoi-ky` | B(1) bối cảnh "còn chạy tới gần cuối tháng 6"; B(2) dòng mở nghiệp vụ; B(3) bỏ "kể cả ngày 28/5/2025" khỏi yêu cầu (giữ cấp Dễ, bẫy `>`/`>=` cần tự đọc). Đổi vai trùng: Chị Hạnh giữ "Trưởng phòng marketing số". | bộ kiểm gói tạm: 0 lỗi |
| `mkt-r6-diem-tuong-tac-tu-30` | C(1) `\luuy` bỏ câu lộ bẫy "gồm cả điểm đúng 30", giữ ý nghiệp vụ; Anh Duy đổi vai thành "Giám đốc marketing" (hết hai người cùng vai). C(2) cấp: không hạ được xuống Cơ bản vì trùng ô với r1 (write, basic, A1, marketing), ghi vào "Chờ giảng viên". | phân tích tĩnh |
| `mkt-r7-paid-ads-ra-rong` | Đạt; sửa tuỳ chọn B: "hôm đó Nykaa mở rất nhiều chiến dịch". | phân tích tĩnh |
| `mkt-r8-thang-2-thieu-ngay-cuoi` | C(1) `\luuy` không còn nêu cách sửa (để cho gợi ý 2); C(2) bỏ wrong `van_bo_ngay_28` vì trùng kết quả starter, giữ `between_toi_ngay_1_3`; ghi chú cập nhật. | bộ kiểm gói tạm: 0 lỗi |
| `mkt-r9-youth-hoac-working-women-thua` | B(1) dòng mở nghiệp vụ không còn gọi phụ nữ đi làm là "khách trẻ"; B(2) bối cảnh "Danh sách em gửi chị lẫn cả… của những ngày khác". | phân tích tĩnh |
| `mkt-n1-ctr-seo-nykaa-ngay` | C(1) gợi ý 1 tính tay dòng mẫu, nói rõ đây là dòng mẫu; C(2) ERD ghi giá trị dạng DB (`40000`, `3348`); `\luuy` bỏ câu nói sẵn "làm tròn ở bước cuối" (trả lời sẵn bẫy). | phân tích tĩnh |
| `mkt-n2-thieu-hien-thi-co-nhap` | B(1) `\luuy` "So sánh với NULL…"; B(2) tiêu đề "Dòng nào của dữ liệu thô…"; B(3) ERD dùng dòng thật `NY-CMP-6265` (row_index 5265, clicks 5038). | phân tích tĩnh |
| `mkt-n3-chi-phi-chien-dich-8-3` | C(1) "đối soát" thay "khớp" ở bối cảnh và nghiệp vụ; C(2) giải nghĩa Influencer; C(3) tiêu đề "Chi phí từng chiến dịch Influencer của Tira Beauty ngày 8/3". Giữ một khuôn "không phải tổng tiền" vì đây là khái niệm cần đối chiếu. | phân tích tĩnh |
| `mkt-n4-lai-hoa-lo-quy-1` | Đạt; tiêu đề có động từ "có bao nhiêu… và lỗ". Sửa ghi chú thiết kế: một dòng ba cột để luyện CASE WHEN trong COUNT, gói vẫn cho `GROUP BY` một cột ở n5, n9 và hai case (hết mâu thuẫn với c1). | phân tích tĩnh |
| `mkt-n5-dong-thieu-chi-so-pheu` | Đạt; tuỳ chọn C: "trống ít nhất một trong bốn chỉ số phễu". | phân tích tĩnh |
| `mkt-n6-gia-tri-don-11-11` | B(1) bối cảnh "đơn hàng của từng chiến dịch có giá trị bình quân bao nhiêu"; B(2) `\luuy` bỏ bị động, phá khuôn "không phải khách hàng tiềm năng" thành "tức số đơn hàng". B(3) (thêm wrong đảo quy tắc hoà) không làm: không bắt buộc. | phân tích tĩnh |
| `mkt-n7-doanh-thu-tho-thap-bat-thuong` | Đạt; tuỳ chọn C: thêm câu về dòng trùng vào `\luuy`; phá khuôn "không phải chiến dịch hoàn tiền". | phân tích tĩnh |
| `mkt-n8-roi-tinh-lai-lech` | B: bối cảnh nêu đúng độ lệch "hàng nghìn lần, có dòng tới hàng triệu lần". | phân tích tĩnh |
| `mkt-n9-thieu-chi-phi-ra-0` | C(1)–(3) gọi `acquisition_cost` là CPA ở tiêu đề, bối cảnh, dòng mở nghiệp vụ, gợi ý 1 (STYLE A.3); `\luuy` không còn nêu sẵn `IS NULL` (gợi ý 2 nói). | phân tích tĩnh |
| `mkt-c1-ctr-theo-loai-thang-5` | B(1) K32: phương án đúng ngắn lại, bỏ từ rào; phương án sai 3 mang từ rào ("nhiều khả năng", "có thể cân nhắc"); ba phương án dài gần bằng nhau. B(2) dòng mở nghiệp vụ "Quyết định… ngân sách nội dung trong quý 3". Gợi ý bỏ khuôn "không phải bình quân". GROUP BY: giữ (như case mẫu `c1-kenh-nhieu-don`), ghi trong `\ghichuthietke` c1 và n4. ERD dạng DB. Anh Duy đổi vai "Giám đốc marketing". | phân tích tĩnh |
| `mkt-c2-file-tho-thieu-nhieu-nhat` | C(a) `\luuy` "Ô trống của bản thô chỉ nằm ở sáu cột…" (bản thô còn cột số khác); yêu cầu bỏ chữ "số"; C(b) K32: phương án đúng bớt rào, phương án sai 3 thêm "chưa cần xử lý"; C(c) phương án sai 2 "nhiều dòng trống ở bốn cột phễu nhất". C(d) đổi mã: không làm (BRIEF-SUA mục 3), xem dưới. | phân tích tĩnh |

Khuôn lặp của gói:
- "X là …, không phải Y": đã bỏ ở r1, n6, n7, c1 (gợi ý), r6 (`\luuy` mới không dùng khuôn). Còn 2 chỗ có chủ ý: khai báo `diem-tuong-tac` (nguyên văn STYLE-mkt E) và n3 (`acquisition_cost` khác tổng chi phí).
- `\luuy` trả lời sẵn `\goiy`: đã sửa r6, r8, n1, n9 (và r1 bỏ câu "lọc đủ cận dưới, cận trên").
- Hai người cùng vai "Trưởng phòng marketing số": Anh Duy (r6, c1) đổi thành "Giám đốc marketing"; Chị Hạnh giữ vai (r5, n9, c2).
- Mở `nghiepvu` bằng "Chọn …": đổi r1, r3, r9, r2, c1 sang "Quyết định / Xác định / So / Đánh giá".
- Ghi chú "hidden-1 bỏ chiến dịch đuôi 7": r2 đã ghi đúng số dòng hai biến thể; các câu khác đã được B, C kiểm là khác nhau.

## Chờ giảng viên (đã quyết ở v3, xem mục "Quyết định v3 (10/11)")

1. **Cấp Dễ của câu dùng một bảng (r4, r5, r6, n3, n5, n9)**: ERD vẽ 2 bảng cho đủ khung Dễ nhưng câu chỉ cần một bảng. r6 không hạ được xuống Cơ bản vì sẽ trùng ô dạng × mảng × cấp × hình thức với r1. Cần chốt: chấp nhận cho Module 1–2, hay hạ một số câu (kèm đổi dạng/mảng để không trùng ô).
2. **Đổi mã `mkt-c2-file-tho-thieu-nhieu-nhat`** (C đề xuất `mkt-c2-file-tho-thieu-nhieu-nhat`): BRIEF-SUA mục 3 không cho đổi mã; câu chưa nhập hệ thống nên đổi được nếu giảng viên đồng ý (sửa cả bản đồ 100 câu).
3. **Case Cơ bản ở gói 1 được dùng `GROUP BY`** (c1, c2) dù Module 4 mới dạy gom nhóm: đang theo case mẫu `c1-kenh-nhieu-don`.

## Quyết định v3 (10/11)

BG = `lesson1_marketing_analytics_foundations.md`, thư mục `Project 01 Marketing Analytics Foundations & Data Pipeline` (ổ H:). QĐC = `QUYET-DINH-CHUNG.md` ở thư mục gốc.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `mkt-r4`, `r5`, `r6`, `n3`, `n5`, `n9` | Cấp Dễ của câu một bảng, ERD 2 bảng | Chấp nhận Dễ; giữ ERD 2 bảng (1 bảng nhiễu). | QĐC 2.3 mục 16, 2.1 (Dễ ở M1–3 = Cơ bản + một bẫy, ERD 2 bảng); QĐC 1.3 (Dễ ≤ 1 bảng nhiễu). Mỗi câu đã có ít nhất một bẫy (khoá `bay`). | Không đổi câu; cập nhật BANG-PHAN-CONG. |
| `mkt-c2-file-tho-thieu-nhieu-nhat` (cũ `mkt-c2-nhieu-don-vao-thuong-hieu-nao`) | Mã lệch nội dung | Đổi mã. | BAO-CAO-TONG-HOP 3.6 (câu chưa nhập hệ thống); nội dung v2 hỏi file thô thiếu nhiều nhất. | Đổi `ma` ở cau-hoi.tex, solution.sql, BANG-PHAN-CONG, DA-SUA, BAN-DO; sửa `\ghichuthietke`. |
| `mkt-c1`, `mkt-c2` | Case Cơ bản dùng `GROUP BY` (Module 4) trong gói M1–2 | Cho phép, giữ SQL (một bảng, một cột gom, không nối, không `HAVING`). | QĐC 1.2 (case mẫu Cơ bản `c1-kenh-nhieu-don` của CHOT). | Thêm câu chuẩn của QĐC 1.2 vào `\ghichuthietke` của c1, c2. |
| Case gói 1 | Tiền tố ở bước kết luận | Theo QĐC 0.1 #1 (bản 23:05, theo case mẫu c1–c4): "Đúng: " ở phương án đúng, phương án sai không tiền tố. | `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4. | Đổi ở c1, c2 (xem mục "Sửa lúc 23:15"). |

Kiểm: bộ kiểm đầy đủ (public + hidden-1) gói 1 **KIEM TRA: 0 loi**; biên dịch lại (xem cuối mục).

### Sửa lúc 23:15 theo QUYET-DINH-CHUNG bản 23:05 (đối chiếu quy chuẩn)

- Kết luận case (QĐC 0.1 #1, theo `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4): lời giải thích của phương án đúng mở bằng "Đúng: "; phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Áp cho mọi case của gói.

### Chuẩn hoá theo quy chuẩn (10/11, BRIEF-CHUAN-HOA)

Xem `../CHUAN-HOA.md` (tiêu đề ≤ 13 tiếng, gợi ý nấc cuối, kết luận case ≤ 35 tiếng, ERD theo CHOT mục 3, cấp). File hồ sơ chuyển từ `goi-1/` sang `ho-so/goi-1/`.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu gồm 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug; case giữ nguyên. Thang 5 trục theo QUYET-DINH-CHUNG (QDC) mục 2.2; lộ trình chuẩn `data.js` M1 có Trung bình (LIKE, IN, BETWEEN) và Khó (sửa lỗi NOT IN, thứ tự AND/OR), M2 có Trung bình (tỷ lệ, NULLIF, ROUND) và Khó (COALESCE, CASE lồng). Cách làm theo mẫu `hr/ho-so/goi-1/DA-SUA.md` mục v4.

- **Trước:** M1 4 Cơ bản · 5 Dễ · 0 · 0; M2 3 Cơ bản · 6 Dễ · 0 · 0.
- **Sau:** M1 Cơ bản r1, r7 · Dễ r4, r5, r8 · Trung bình r2, r3 · Khó r6, r9; M2 Cơ bản n1, n2 · Dễ n3, n5, n8 · Trung bình n6, n7 · Khó n4, n9. Hình thức không đổi (mỗi module 6 write + 3 debug). Case c1, c2 giữ Cơ bản.
- **Viết lại 8 câu** (số tối thiểu: M1 thừa 2 Cơ bản + 2 Dễ, M2 thừa 1 Cơ bản + 3 Dễ). Câu còn lại, case, `aio-sql-cauhoi.sty`, `HUONG_DAN.md` không sửa. Khái niệm: thêm `ty-le-roi-pheu` (chép giống hệt gói 4, theo STYLE-mkt E) và `cpc-cpm` (STYLE-mkt E); không bỏ khái niệm nào (mọi khái niệm cũ vẫn có câu dùng).
- **ERD:** Trung bình 3 bảng chỉ ký hiệu n-1 (CHOT mục 3); lời giải 1 bảng (Module 1–2 chưa học nối bảng) nên có 2 bảng nhiễu, vượt giới hạn 1 bảng nhiễu của QDC 1.3 (quy ước bổ sung, xếp sau CHOT; như hr gói 1). Khó 5 bảng chỉ khoá, không `\erdnoi`, cách nối ở `\erdkhoa`, 4 bảng nhiễu (QDC 1.3, mẫu o4); bảng `campaigns` đứng một cột riêng để không chồng hàng dưới.
- **Câu Khó dùng 1 bảng** (mẫu o4 cho phép); bù bằng mơ hồ (ngôn ngữ kinh doanh), bẫy (mỗi câu Khó có một bẫy chỉ lộ ở hidden-1: thiếu cận trên, bắt qua `NY-CMP-56555` ngày 1/7/2025 – Nykaa · Social Media · sinh viên · Hindi · ROI 6,14 · điểm tương tác 20,98) và nghiệp vụ nhiều điều kiện; hai câu Sửa lỗi Khó có 3 lỗi chồng nhau.
- `solution.sql`: ngắt các dòng chú thích dài sau dòng đánh dấu đầu tiên (biên dịch trước đó 21 cảnh báo Overfull, nay 3, đều là dòng SQL cũ của n8 và giá trị mẫu ERD của n2).

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `mkt-r2-working-women-tamil-tira` → `mkt-r2-qua-8-3-tira-ban-tot` | Cơ bản → Trung bình (write) | Từ chiến dịch tiếng Hindi nhắm phụ nữ đi làm ngày 8/3 sang chiến dịch quà tặng 8/3 bán tốt của Tira Beauty, định nghĩa ở tab Nghiệp vụ: mở từ 1/3 tới hết 8/3/2025, nhắm Working Women hoặc Premium Shoppers, chạy 7–14 ngày, từ 2.000 lượt chuyển đổi (`BETWEEN`, `IN`). Mảng customer → sales (ô A1·cus·medium·W đã có `mkt-p7`). Bài sai: `> 7 AND < 14` (15 dòng); lọc `segment_id` (13); cận trên `< '2025-03-08'` (17). Public 19 dòng, hidden-1 18 | 1 bảng · 1 tầng · TB (định nghĩa ở tab) · TB (3 bẫy) · TB (thời điểm + nhóm khách + ngưỡng) → TB 3/5 |
| `mkt-r3-roi-thap-nhat-nykaa-q4` → `mkt-r3-10-lo-nang-thue-ngoai-purplle-q4` | Cơ bản → Trung bình (write) | 10 chiến dịch ROI thấp nhất của nhóm thuê ngoài (Influencer, Paid Ads, định nghĩa ở tab) của Purplle quý 4/2024. Đổi Nykaa → Purplle để có hoà thật ở hạng 10 (5 chiến dịch cùng −0,91 ở hạng 10–14; hidden-1 ở hạng 9–13); quy tắc hoà theo chuỗi (`'PU-CMP-24390'` trước `'PU-CMP-9267'`). Bài sai: hoà ngược chiều; mọi loại; thiếu cận trên | 1 bảng · 1 tầng · TB (nhóm loại ở tab) · TB (hoà hạng + so chuỗi + cận trên) · TB (nhóm khoản chi + kỳ) → TB 3/5 |
| `mkt-r6-diem-tuong-tac-tu-30` → `mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2` | Dễ → Khó (write) | Nội dung Nykaa quý 2/2025 đáng làm mẫu cho sinh viên nói tiếng Hindi, nêu bằng lời: Nykaa tự làm (loại Influencer, Paid Ads: `NOT IN`), nhắm sinh viên, tiếng Hindi, chạy từ hai tuần, điểm tương tác từ 20. Bẫy chỉ lộ ở hidden-1: thiếu cận trên. Bài sai ở public: lọc `segment_id` (31 dòng so với 38); giữ thuê ngoài (62); `> 20` bỏ `NY-CMP-44885` điểm đúng 20,00 (37). Ô A1·mkt·easy·W cũ trùng `mkt-s4` nay hết trùng | 1 bảng · 1 tầng · Khó (ngôn ngữ kinh doanh) · Khó (5 bẫy, 1 chỉ ở hidden-1) · Khó (5 điều kiện có loại trừ) → Khó 3/5 |
| `mkt-r9-youth-hoac-working-women-thua` → `mkt-r9-gioi-tre-cuoi-thang-6-thua` | Dễ → Khó (debug) | Chiến dịch tiếng Hindi của Nykaa 16–30/6/2025 cho sinh viên hoặc giới trẻ, trừ email và SEO. Ba lỗi chồng nhau: thiếu ngoặc quanh `OR` (starter 33.375 dòng so với 17); `type_id <> 1 OR type_id <> 4` luôn đúng (phủ định hai điều kiện); thiếu cận trên (chỉ lộ ở hidden-1). Bài sai: sửa hai lỗi quên cận trên (chỉ rớt ở hidden-1); giữ `OR` ở điều kiện loại (33); loại nhầm mã 5 (23). Đúng bài Khó M1 của lộ trình (NOT IN, AND/OR) | 1 bảng · 1 tầng · TB · Khó (3 bẫy, 1 chỉ ở hidden-1) · TB; Sửa lỗi Khó (3 lỗi chồng nhau) → Khó |
| `mkt-n4-lai-hoa-lo-quy-1` → `mkt-n4-nhom-lai-lo-nykaa-quy-2` | Dễ → Khó (write) | Từ đếm lãi/hoà/lỗ quý 1 sang xếp chiến dịch Nykaa quý 2/2025 vào 4 nhóm bằng `CASE` có ngoại lệ đứng trước (Influencer, Paid Ads có ROI dưới 0,5 → xem lại hợp đồng, dù lỗ hay lãi), gom theo nhãn, thêm tổng chi phí chiến dịch. Bẫy chỉ ở hidden-1: thiếu cận trên (nhóm có lãi thêm 1). Bài sai ở public: nhánh lỗ đặt trước; `roi <= 0.5` (5 chiến dịch đúng 0,50); cộng `acquisition_cost`. Gom theo nhãn như `hr-n6` | 1 bảng · 2 tầng · Khó (quy tắc bằng lời) · Khó (5 bẫy, 1 chỉ ở hidden-1) · Khó (quy tắc có ngoại lệ + chi phí) → Khó 3/5 |
| `mkt-n6-gia-tri-don-11-11` → `mkt-n6-ty-le-roi-sau-nhap-11-11` | Dễ → Trung bình (write) | Từ giá trị đơn bình quân sang tỷ lệ rơi từ lượt nhấp sang khách hàng tiềm năng = (1 − leads/clicks) × 100, có `NULLIF`; cùng phạm vi Purplle Influencer 11/11/2024 (15 dòng, hidden-1 14). Mảng sales → marketing (chỉ số phễu, STYLE-mkt G). Bài sai: quên 1 trừ; mẫu số lượt hiển thị; quên nhân 100. Đúng bài TB M2 của lộ trình (tỷ lệ, NULLIF, ROUND) | 1 bảng · 1 tầng · TB (công thức ở khái niệm, tự ghép tầng với cột) · TB (2–3 bẫy) · TB (công thức hai thành phần) → TB 3/5 |
| `mkt-n7-doanh-thu-tho-thap-bat-thuong` → `mkt-n7-gia-tri-don-tho-lech` | Cơ bản → Trung bình (debug) | Giá trị đơn bình quân của cả bản thô (tổng doanh thu / tổng lượt chuyển đổi, trên dòng đủ hai số và doanh thu dương). Một lỗi khó thấy: starter đã lọc `revenue > 0` nhưng dòng trống lượt chuyển đổi vẫn góp doanh thu vào tử số (`SUM` bỏ ô trống theo từng cột); lệch 0,31. Bài sai: bỏ `revenue > 0`; `COALESCE(conversions, 0)`; bình quân giản đơn | 1 bảng · 1 tầng gom · TB (định nghĩa ở tab) · TB (2 bẫy) · TB (tỷ lệ của tổng); Sửa lỗi TB (1 lỗi khó thấy) → TB |
| `mkt-n9-thieu-chi-phi-ra-0` → `mkt-n9-cpc-cpm-nykaa-thang-6-lech` | Dễ → Khó (debug) | Từ đếm ô trống CPA sang CPC, CPM của chiến dịch Social Media tiếng Hindi Nykaa 15–30/6/2025. Ba lỗi chồng nhau: lấy `acquisition_cost` (CPA) làm chi phí (sai định nghĩa chỉ số); làm tròn trước khi nhân 1.000; thiếu cận trên (chỉ lộ ở hidden-1). Mảng operations → finance, dạng E1 → A2 (ô E1·ops·hard·D đã có `mkt-t9`). Mốc 15/6 để public có `NY-CMP-6357` (đuôi 7): public 17 dòng, hidden-1 16. Bài sai: sửa hai lỗi quên cận trên; giữ làm tròn sớm; giữ CPA | 1 bảng · 1 tầng · TB · Khó (3 bẫy, 1 chỉ ở hidden-1) · Khó (hai đơn giá dựng trên chi phí chiến dịch); Sửa lỗi Khó (3 lỗi, có sai định nghĩa chỉ số) → Khó |

Kiểm lại (11/11/2026):
- Kiểm tĩnh `--chi-phan-tich` → 0 lỗi. Bộ kiểm đầy đủ cả gói: `kiem_tra_goi.py --goi goi-cau-hoi/mkt/goi-1 --ra cong-cu/ket-qua/cap-do/mkt-goi-1 --host sqllb-mysql --port 3306` → **KIEM TRA: 0 loi**, 0 cảnh báo; 20/20 câu, mọi `wrong` rớt ≥ 1 biến thể; 4 bài sai chỉ rớt ở hidden-1 (r6, n4 `thieu_can_tren`; r9, n9 `quen_can_tren`). Lời giải mọi câu (kể cả bước 1 của hai case) có kết quả public khác hidden-1 (so md5 từng khối); lời giải chạy ≤ 0,7 giây.
- Biên dịch `bash cong-cu/bien_dich.sh goi-cau-hoi/mkt/goi-1 <ra>` → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo `aio-sql-cauhoi`; 3 Overfull (dòng SQL cũ của n8, giá trị mẫu ERD của n2). PDF và log ở `cong-cu/ket-qua/cap-do/mkt-goi-1/bien-dich/`. Đã xem trang ERD Trung bình (r2) và Khó (r6): bảng không chồng nhau.
- Đếm cấp từ `cau-hoi.tex`: M1 2/3/2/2, M2 2/3/2/2; mỗi module 6 W + 3 D. Thư mục gói vẫn đúng 4 file.

Cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6) cho chữ mới: bối cảnh ≤ 35 tiếng, xưng hô đúng vai (Quản lý thương hiệu, Kế toán quản trị, Giám đốc tài chính, Trưởng nhóm quảng cáo trả phí, Chuyên viên phân tích marketing, Thực tập sinh), không nhắc kỹ thuật SQL; tiêu đề ≤ 13 tiếng, không tên kỹ thuật SQL; không "—", "Em lọc giúp", khuôn "mệnh đề: kết luận" (`\luuy` n4 viết "Ban tài chính xếp nhóm như sau."); thuật ngữ theo STYLE-mkt A (marketing người ảnh hưởng, quảng cáo trả phí, đối tượng mục tiêu, phân khúc khách hàng, khách hàng tiềm năng, tỷ lệ rơi, chi phí chiến dịch; CPC, CPM giải nghĩa lần đầu; "đơn vị tiền", không tiền tệ). Còn cụm "không phải lượt hiển thị" trong khái niệm `ty-le-roi-pheu`: giữ vì chép nguyên văn STYLE-mkt E và gói 4.

Nghi trùng ô / trùng nội dung:
- 8 ô mới (A1·sal·medium·W, A1·fin·medium·W, A1·mkt·hard·W, A1·cus·hard·D, A3·fin·hard·W, A2·mkt·medium·W, A2·sal·medium·D, A2·fin·hard·D) đều trống trong `BAN-DO-100-CAU.md` lúc sửa. Dòng bản đồ mới ở `BAN-DO-V4-DONG.md` (không sửa thẳng bản đồ vì gói 2–5 đang sửa song song); cần đối chiếu lại khi cộng bảng tổng.
- r6, r9, n9 cùng phạm vi Nykaa · tiếng Hindi (quý 2 hoặc nửa cuối tháng 6) vì đó là cách để bẫy thiếu cận trên bắt được dòng thêm `NY-CMP-56555` ở hidden-1; ba câu khác kỹ năng và câu hỏi, nhưng người duyệt có thể thấy bối cảnh lặp.
- n4 (A3·fin·Khó, phân nhóm theo ROI) gần chủ đề `mkt-t6-phan-nhom-roi-ctr` (C4·fin·Khó) ở gói 4; khác ô và khác kỹ năng (M2 `CASE` có ngoại lệ).
