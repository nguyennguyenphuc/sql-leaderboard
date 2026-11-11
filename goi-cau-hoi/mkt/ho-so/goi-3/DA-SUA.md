# Đã sửa · Marketing gói 3 (v2, sau kiểm B/C)

Người sửa: A · 10/11/2026. Căn cứ: `REVIEW-B.md`, `REVIEW-C.md`. Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại: gói tạm `cong-cu/ket-qua/sua/mkt-goi-3/` (9 câu đã sửa SQL hoặc yêu cầu) chạy bộ kiểm thật trên public và hidden-1;
cả gói chạy `--chi-phan-tich`; biên dịch lại cả gói bằng `cong-cu/bien_dich.sh` (thư mục ra `mkt-goi-3`).

Chung cho cả gói: `\khaibaodulieu` bỏ ngày dữ liệu cuối (j5 cũ lộ đáp án qua đây). Phá khuôn "Với mỗi …:" thành câu có động từ ("Đếm…", "Tính…", "Theo từng…").
Khuôn "Truy vấn dưới đây cần đếm, theo …, …" đổi về trật tự tiếng Việt. "Sửa để ra đúng" đổi thành "Sửa truy vấn cho đúng yêu cầu". Bỏ chữ "truy vấn" trong mọi `\boicanh`; bỏ "nó" chỉ vật; bỏ dấu × trong câu văn.

| Mã | Đã sửa (theo điểm của B/C) | Kiểm lại |
|---|---|---|
| mkt-j1-doanh-thu-loai-thuong-hieu | B(1) yêu cầu viết lại thành câu "Đếm… và cộng… theo từng thương hiệu và từng loại"; B(2) bối cảnh "ghi rõ tên thương hiệu và tên loại"; B(3) lưu ý nêu cụ thể cột nối; B(4) thêm "tháng 6/2025 chỉ có dữ liệu tới 24/6". | phân tích tĩnh, biên dịch |
| mkt-j2-doi-tuong-va-phan-khuc | C(1) "khách ghi nhận" thành "khách thực tế mua hàng"; C(2) bỏ dấu ×, "(ghi bằng tên nhóm)". | phân tích tĩnh, biên dịch |
| mkt-j3-hien-thi-theo-kenh | B(1) "nền tảng quảng cáo" thành "đối tác kênh quảng cáo"; mục đích đổi thành "ưu tiên người theo dõi và làm việc với đối tác kênh" (điểm domain: xem Chờ giảng viên); B(2) bỏ "nó"; B(3) yêu cầu thành câu có động từ; B(4) gợi ý bỏ "--". | phân tích tĩnh, biên dịch |
| mkt-j4-dang-chay-tuan-dau-thang-2 | C(1) "không sau d / không trước d" thành "d nằm trong khoảng từ ngày bắt đầu tới ngày cuối, tính cả hai đầu"; C(2) bỏ "Với mỗi ngày". | phân tích tĩnh, biên dịch |
| mkt-j5-ngay-khong-co-chien-dich | B: câu cũ ra hằng số (6 ngày 25–30/6, hết dữ liệu; hai biến thể giống nhau; lộ qua `\khaibaodulieu`). Đổi phạm vi theo đề xuất của B: Tira Beauty, Paid Ads, Hindi, Premium Shoppers, tháng 5/2025 (tháng đủ), LEFT JOIN có điều kiện trong ON. Public 3 ngày, hidden-1 5 ngày. Wrong mới: nối trong, điều kiện ở WHERE, bỏ điều kiện ngôn ngữ. Lưu ý "ngày không khớp với chiến dịch nào"; bỏ "(của cả ba thương hiệu)". Tiêu đề, bối cảnh, nghiệp vụ, ghi chú viết lại. | bộ kiểm (gói tạm) |
| mkt-j6-loai-email-khong-kenh-email | C(1) tiêu đề "Bao nhiêu chiến dịch loại Email không chạy trên kênh Email?"; C(2) "không có dòng nào với" thành "không có kênh Email"; C(3) "Theo từng thương hiệu, đếm…". | phân tích tĩnh, biên dịch |
| mkt-j7-doanh-thu-instagram-facebook-gap-doi | B(1) bối cảnh "cao hơn thực tế… số sai ở đâu" (bỏ "truy vấn", bỏ "cả"); B(2) bỏ "Hãy"; B(3) tách gạch đầu dòng dài thành hai ý. | phân tích tĩnh, biên dịch |
| mkt-j8-phan-khuc-lay-nham-doi-tuong | C: hạ cấp medium thành easy (một lỗi khoá nối); tiêu đề "giống hệt"; yêu cầu viết lại trật tự tiếng Việt; ghi chú sửa "n-1"; bỏ "Em sửa giúp chị". | phân tích tĩnh, biên dịch |
| mkt-j9-lich-thieu-ngay-trong | B: chọn cách 1, giữ tháng 6; nghiệp vụ đổi thành "lịch đủ 30 ngày để vẽ biểu đồ", lưu ý nói rõ các ngày ra 0 cuối tháng là ngoài kỳ dữ liệu chứ không phải bị bỏ trống; bối cảnh "Bạn thực tập lập bảng nhưng bị thiếu ngày", "quảng cáo trả phí (Paid Ads)" lần đầu; tiêu đề bỏ "ngày trống". SQL không đổi. | phân tích tĩnh, biên dịch |
| mkt-q1-roi-tren-binh-quan-tira | C(1) bỏ ẩn dụ "kéo bình quân lên"; C(2) "ROI (lợi tức đầu tư)" lần đầu; gợi ý bỏ "nó". | phân tích tĩnh, biên dịch |
| mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu | B: hai biến thể cũ giống hệt, bối cảnh "rất nhiều chiến dịch" sai số liệu. Đổi phạm vi thành 1–8/3/2025 (hidden-1 khác ở doanh thu NY-CMP-53612); bối cảnh, yêu cầu theo câu B đề xuất. Wrong `tuong_quan_thieu_ngay` (chạy ~70 giây) thay bằng `top_3_chung`. | bộ kiểm (gói tạm) |
| mkt-q3-loai-ctr-tren-chung | C: wrong bình quân giản đơn (trùng solution ở hidden-1) thay bằng `quen_nhan_100`; bối cảnh và nghiệp vụ bỏ ý ưu tiên/ra quyết định từ chênh < 0,1 điểm % (STYLE B.6), "Đây là dữ liệu tổng hợp". | bộ kiểm (gói tạm) |
| mkt-q4-doi-soat-roi-tinh-san | B: ngưỡng 0,01 sát biên (NY-CMP-48235 đúng 0,010000; DECIMAL 116 / DOUBLE 117 / làm tròn trung gian 113) đổi thành > 0,02 (public 11, hidden-1 9); bối cảnh bỏ "lệch thật chứ không phải do làm tròn"; lưu ý thêm ý ngưỡng do người hỏi chọn, làm tròn chỉ gây lệch tối đa 0,005; wrong `so_bang_khac` (166.519 dòng) thay bằng `lam_tron_trung_gian`; ghi chú nêu rõ README đếm 31 bằng cách nào. | bộ kiểm (gói tạm) |
| mkt-q5-ty-trong-loai-purplle | C: hạ cấp medium thành easy; ERD 2 bảng có chữ trên đường nối; wrong `chia_cho_so_loai` thay bằng `thieu_loc_thuong_hieu_ngoai`; bỏ "Với mỗi loại". | bộ kiểm (gói tạm) |
| mkt-q6-ngay-purplle-khong-seo | B: câu cũ ra 7 ngày cuối tháng 6 sau khi hết dữ liệu, hai biến thể giống nhau. Đổi theo đề xuất của B: Purplle, SEO, Tamil, Youth, tháng 5/2025 (public 10 ngày, hidden-1 thêm 30/5). Wrong: không tương quan, thiếu cận trên (nay rớt public), nhầm phân khúc; bỏ wrong lấy ngày từ `campaigns` (tháng 5 trùng lời giải). Nghiệp vụ, lưu ý, ghi chú viết lại. | bộ kiểm (gói tạm) |
| mkt-q7-shoppers-ra-rong | C: wrong `= 'Shoppers'` (trùng starter) thay bằng `sua_mau_bo_can_tren`; bỏ `canhbao` ở đường nối; hạ cấp easy thành basic; yêu cầu viết lại trật tự tiếng Việt; "rỗng" thành "không ra dòng nào"; gợi ý bỏ "nó". | bộ kiểm (gói tạm) |
| mkt-q8-dong-sach-khong-nhieu-sai | B: nghiệp vụ bỏ "dùng được ngay", thêm lưu ý bản chép của dòng trùng không bị nhật ký nhắc tới; bối cảnh "Bảng hiện tại…", bỏ "Em sửa giúp anh"; wrong `tuong_quan_chi_vi_tri` (trùng starter) thay bằng `tuong_quan_theo_ma_va_thuong_hieu`; yêu cầu viết lại trật tự tiếng Việt. | bộ kiểm (gói tạm) |
| mkt-q9-tuong-tac-tren-binh-quan-loai | C: wrong `bi_danh_ngoai_ca_hai_ve` (trùng starter) thay bằng `bo_loc_thuong_hieu_ngoai`; quy tắc phân giải tên cột chuyển từ lưu ý sang gợi ý 1; bối cảnh chỉ nêu triệu chứng, bỏ "truy vấn", "nó"; "tuần đầu" thành "7 ngày đầu tháng 3"; tiêu đề theo câu C đề xuất; bỏ câu "điểm tương tác chỉ so được trong cùng loại" khỏi lưu ý. | bộ kiểm (gói tạm) |
| mkt-c5-kenh-hieu-qua-hon | B(1) b1, b2 ghi rõ sắp theo giá trị đã làm tròn (hết nguy cơ chấm oan do Instagram/WhatsApp đổi chỗ); B(2) cân độ dài ba phương án, phương án sai cũng có từ rào (K32); B(3) bỏ "nó"; B(4) "Theo từng kênh, …"; B(5) "có tỷ lệ nhấp cao hơn". SQL không đổi. | phân tích tĩnh, biên dịch |
| mkt-c6-tho-va-sach-lech-o-dau | C(1) lưu ý "NULL <> 5 cho NULL chứ không cho đúng…"; C(2) "Theo từng thương hiệu, đếm…"; C(3) rút phương án đúng, cân độ dài, phương án sai 3 dựa vào số liệu bước 2; ghi chú sửa: hidden-1 lệch 321/323/315, không còn "như nhau". | phân tích tĩnh, biên dịch |

## Chờ giảng viên (đã quyết ở v3, xem mục "Quyết định v3 (10/11)")

- **j3** (B): số liệu theo kênh là lượt hiển thị của cả chiến dịch, không của riêng kênh. Đã đổi mục đích từ "đàm phán giá với nền tảng" sang "ưu tiên người theo dõi và làm việc với đối tác kênh", nhưng cần người nắm domain xác nhận số liệu này có hợp với việc làm việc với đối tác kênh (Email, WhatsApp) hay không.
- **q3** (C): câu có nên phục vụ quyết định duyệt nội dung theo loại khi CTR các loại chênh dưới 0,1 điểm phần trăm hay không. Đã giảm nhẹ thành "xem kỹ hơn", ghi rõ là không dùng riêng kết quả này để chuyển ngân sách.
- **q9** (C): ý "điểm tương tác chỉ so được giữa các chiến dịch cùng loại" không có nguồn trong bài giảng. Đã bỏ khỏi lưu ý, chỉ giữ yêu cầu so trong cùng loại là ý của người hỏi. Cần xác nhận cách đặt vấn đề.

## Sửa thêm (v2.1) · mkt-q2 chạy quá giờ

- Vấn đề: bản tuần 1–8/3/2025 chạy hơn 200 giây trên `mkt_hidden_1`. Kế hoạch chạy cho thấy truy vấn con tương quan dò lại khoảng ngày theo chỉ mục ngày cho từng dòng ngoài ("re-planned for each iteration"); ngay cả phạm vi 2 ngày cũng mất 7–17 giây lúc máy tải.
- Sửa: thu phạm vi về **một ngày 5/3/2025**; điều kiện ngày ở truy vấn con là phép bằng, nên MySQL tra theo chỉ mục `(brand_id, start_date)`. Kỹ năng Module 6 giữ nguyên (truy vấn con tương quan `MAX`). Tiêu đề, bối cảnh ("đợt chiến dịch chuẩn bị cho dịp 8/3"), yêu cầu, gợi ý và ghi chú thiết kế viết lại theo ngày mới.
- Đo lúc máy đang tải: lời giải 0,8 giây (public) và 1,3 giây (hidden-1); cách học viên hay viết (khoảng nửa mở trong truy vấn con) khoảng 2 giây. Trong bộ kiểm, lời giải chạy 0,35 và 0,27 giây.
- Hai biến thể khác nhau: ngày 5/3 có NY-CMP-53612, ở hidden-1 doanh thu là 4.119.654, ở public là 4.067.481 (biến thể c).
- Bài sai: giữ `khong_tuong_quan`; thay `top_3_chung` (một ngày có thể trùng lời giải) bằng `gom_nhom_lay_ma_nho_nhat` (gom nhóm lấy `MIN(campaign_id)` kèm `MAX(revenue)`). Cả hai rớt ở public và hidden-1.
- Kiểm lại: gói tạm `cong-cu/ket-qua/sua/mkt-goi-3-q2/` chỉ gồm q2 → **KIEM TRA: 0 loi**; cả gói `--chi-phan-tich` 0 lỗi; biên dịch lại 49 trang, 0 lỗi LaTeX, 0 ký tự thiếu. Không đụng câu khác.

## Quyết định v3 (10/11)

BG = `lesson1_marketing_analytics_foundations.md`, thư mục `Project DA\Project 01 Marketing Analytics Foundations & Data Pipeline`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `mkt-j3-hien-thi-theo-kenh` | Số liệu theo kênh là lượt hiển thị của cả chiến dịch | Xác nhận v2: câu đếm số chiến dịch có mặt trên kênh và cộng lượt hiển thị của các chiến dịch đó, dùng để ưu tiên người theo dõi, làm việc với đối tác kênh; không dùng để chia hiệu quả cho từng kênh. | BG II.A.2 ("một campaign có thể chạy trên nhiều kênh cùng lúc"), III.B (Channel_Used đa trị; Impressions là số của cả chiến dịch). Khái niệm `kenh-da-tri` đã ghi doanh thu, lượt chuyển đổi không tách được theo kênh. | Không đổi. |
| `mkt-q3-loai-ctr-tren-chung` | CTR các loại chênh dưới 0,1 điểm phần trăm | Xác nhận v2: kết quả chỉ để "xem kỹ hơn", không chuyển ngân sách. | BG IV.D: "CTR trung bình cả 3 brand đều khoảng 8.5%", "Sự chênh lệch giữa các loại campaign khá nhỏ"; BG II.C.1 mẹo "CTR phụ thuộc vào kênh … Đừng so sánh CTR cross-channel mà không tính đến bối cảnh". | Không đổi. |
| `mkt-q9-tuong-tac-tren-binh-quan-loai` | Ý "điểm tương tác chỉ so được trong cùng loại" không có nguồn | Xác nhận v2: so trong cùng loại là yêu cầu của người hỏi, không viết thành quy tắc nghiệp vụ. | BG III.B nhóm 4 chỉ định nghĩa Engagement_Score là "Điểm tương tác (thang điểm tổng hợp)", không nêu cách so. | Không đổi. |
| Khái niệm `kenh-da-tri` | Ghi "không phải kênh chính", lệch STYLE-mkt | Dùng đúng chữ của STYLE-mkt A.1: "không phải mức ưu tiên". | STYLE-mkt A.1 dòng `Channel_Used` đa trị; mục E #3. | `\khaibaokhainiem{kenh-da-tri}` (dòng 41). |

Kiểm: bộ kiểm đầy đủ gói 3 **KIEM TRA: 0 loi** (chỉ đổi chữ khai báo khái niệm); biên dịch lại (xem cuối mục).

### Sửa lúc 23:15 theo QUYET-DINH-CHUNG bản 23:05 (đối chiếu quy chuẩn)

- Kết luận case (QĐC 0.1 #1, theo `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4): lời giải thích của phương án đúng mở bằng "Đúng: "; phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Áp cho mọi case của gói.

### Chuẩn hoá theo quy chuẩn (10/11, BRIEF-CHUAN-HOA)

Xem `../CHUAN-HOA.md` (tiêu đề ≤ 13 tiếng, gợi ý nấc cuối, kết luận case ≤ 35 tiếng, ERD theo CHOT mục 3, cấp). File hồ sơ chuyển từ `goi-3/` sang `ho-so/goi-3/`.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (không tính case), theo lộ trình `quy_chuan/lo-trinh-sql/assets/js/data.js` (Joins: `j1-don-kem-vung` basic, `j3-khach-chua-mua` easy, `j5-doanh-thu-nhom-hang` medium, `j6-mua-cung-don` hard; Subqueries: `q1-tren-gia-trung-binh` basic, `q2`, `q3` easy, `q4`, `q5` medium, `q6-don-dau-tien` hard). Case c5 (Dễ), c6 (Trung bình) giữ nguyên cấp. Agent v4 trước dừng vì giới hạn lượt trước khi sửa gì (`TRANG-THAI-V4.md` (file trạng thái tạm, đã xoá sau khi xong v4)); bản này làm từ đầu.

| Module | Trước (Cơ bản/Dễ/TB/Khó) | Sau | Hình thức sau (write/debug) |
|---|---|---|---|
| M5 Joins | 0 / 4 / 5 / 0 | 2 / 3 / 2 / 2 | 6 / 3 (debug: j7 Dễ, j8 Dễ, j9 Khó) |
| M6 Subqueries | 1 / 3 / 5 / 0 | 2 / 3 / 2 / 2 | 6 / 3 (debug: q7 Cơ bản, q8 Trung bình, q9 Khó) |

Số câu viết lại tối thiểu: M5 thừa 1 Dễ và 3 Trung bình (1 Dễ + 1 TB → Cơ bản, 2 TB → Khó); M6 thừa 3 Trung bình (1 → Cơ bản, 2 → Khó). Tổng **7 câu**. Giữ j2, j7, j8 (Dễ), j4, j5 (TB), q1, q2, q5 (Dễ), q6, q8 (TB), q7 (Cơ bản). Không hạ j8 (sửa lỗi Dễ) xuống Cơ bản vì ô A1 · customer · basic · debug đã có q7; hạ j1 thay.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `mkt-j1-doanh-thu-loai-thuong-hieu` → `mkt-j1-tira-doanh-thu-cao-kem-loai` | Dễ → Cơ bản | Bỏ gom theo thương hiệu × loại quý 2; liệt kê chiến dịch Tira Beauty ngày 19/3/2025 có doanh thu từ 2.000.000, kèm tên loại. Yêu cầu ghi rõ khoá nối. ERD 2 bảng có giá trị mẫu (chiến dịch ngày 18/3, không thuộc kết quả) và chữ trên đường nối, bỏ `brands`. Đổi mảng marketing → sales, dạng A3 → A1. 2 wrong. | 2 bảng (Cơ bản của Joins là nối 2 bảng) · 1 tầng · ghi rõ cột, giá trị lọc, khoá nối · 0 bẫy · 1 khái niệm. Đạt Cơ bản 5/5 |
| `mkt-j3-hien-thi-theo-kenh` → `mkt-j3-influencer-nykaa-tren-youtube` | Trung bình → Cơ bản | Bỏ đếm và cộng lượt hiển thị theo kênh; liệt kê chiến dịch Influencer của Nykaa ngày 15/5/2025 có kênh YouTube, kèm lượt hiển thị. Ý "vị trí kênh không phải mức ưu tiên" nói thẳng trong yêu cầu. ERD 2 bảng có giá trị mẫu (YouTube ở vị trí 3) và chữ trên đường nối, bỏ `channels`. Dạng A3 → A1. 2 wrong. | 2 bảng · 1 tầng · ghi rõ cột, giá trị lọc, khoá nối · 0 bẫy · 1 khái niệm. Đạt Cơ bản 5/5 |
| `mkt-j6-loai-email-khong-kenh-email` → `mkt-j6-email-lech-kenh-nua-dau-2025` | Trung bình → Khó | Thêm chỉ số "chiến dịch email lệch kênh" (định nghĩa ở tab Nghiệp vụ), tỷ lệ lệch kênh và doanh thu của nhóm lệch kênh theo tên thương hiệu, nửa đầu 2025. Lời nhắn nói bằng ngôn ngữ báo cáo; ERD 6 bảng chỉ khoá, 2 bảng nhiễu, cách nối ở `\erdkhoa`. 4 wrong. | 4 bảng · 4 tầng (đánh dấu từng chiến dịch, gom, tỷ lệ, doanh thu có điều kiện) · chỉ số ở tab Nghiệp vụ, nối ở `\erdkhoa` · 4 bẫy (kênh khác Email ở WHERE, doanh thu nhân theo số kênh, đảo vai loại và kênh, sai mẫu số) · chỉ số nhiều điều kiện. Đạt Khó 4/5 (trục bẫy thiếu bẫy chỉ lộ ở hidden-1) |
| `mkt-j9-lich-thieu-ngay-trong` → `mkt-j9-lich-paid-ads-tira-chua-dung-duoc` | Trung bình → Khó | Starter có ba lỗi chồng nhau: điều kiện bảng phải ở WHERE, `COUNT(*)`, lọc lịch thiếu cận trên. Sửa lỗi thứ nhất mới lộ lỗi thứ hai; lỗi thứ ba chỉ lộ ở hidden-1 (lịch có thêm 2025-07-01). Yêu cầu không chỉ chỗ sai; ERD 5 bảng chỉ khoá, 3 bảng nhiễu. 3 wrong. | 2 bảng (mẫu d4) · 3 tầng · không nêu chỗ sai, ERD trung tính · 3 bẫy, 1 chỉ lộ ở hidden-1 · lịch đủ ngày cho tháng chưa đủ. Đạt Khó 3/5 + trục sửa lỗi (3 lỗi chồng nhau) |
| `mkt-q3-loai-ctr-tren-chung` → `mkt-q3-social-media-purplle-nhap-tren-binh-quan` | Trung bình → Cơ bản | Đổi sang truy vấn con một giá trị không lọc (đúng mẫu `q1-tren-gia-trung-binh`): chiến dịch Social Media của Purplle ngày 6/5/2025 có lượt nhấp trên bình quân của mọi chiến dịch. ERD 1 bảng có giá trị mẫu, bỏ 2 bảng. 2 wrong. | 1 bảng · 1 tầng · ghi rõ cột, giá trị lọc, phạm vi bình quân · 0 bẫy · 1 khái niệm. Đạt Cơ bản 5/5 |
| `mkt-q4-doi-soat-roi-tinh-san` → `mkt-q4-thang-roi-tren-muc-quy-1` | Trung bình → Khó | Viết mới: với mỗi thương hiệu, tháng nào của quý 1/2025 có ROI (tỷ lệ của tổng) cao hơn ROI cả quý của chính thương hiệu đó. Truy vấn con tương quan hoặc hai bảng dẫn xuất; `saiso=0.0001`. ERD 5 bảng chỉ khoá, 4 bảng nhiễu. Dạng E2 → C3. 4 wrong. | 1 bảng (mẫu o4) · 4 tầng · ngôn ngữ báo cáo, công thức ở tab Nghiệp vụ · 4 bẫy (bình quân cột `roi`, mức của ba thương hiệu, mức của cả kỳ, làm tròn trước khi so – chỉ lộ ở hidden-1) · ROI của tổng, so trong từng thương hiệu. Đạt Khó 4/5 |
| `mkt-q9-tuong-tac-tren-binh-quan-loai` → `mkt-q9-tuong-tac-tren-binh-quan-hai-loi` | Trung bình → Khó | Starter thêm lỗi thứ hai (truy vấn con thiếu lọc Nykaa) chồng lên `type_id = type_id`; sửa một lỗi vẫn sai. Thu phạm vi 1–7/3 → 7–8/3 vì chậm (xem dưới). ERD 5 bảng chỉ khoá. 2 wrong (mỗi wrong là một lỗi được sửa một mình). | 1 bảng đọc hai lần · 3 tầng · không nêu chỗ sai, ERD trung tính · 3 bẫy · so trong nhóm theo ba điều kiện. Đạt Khó 3/5 + trục sửa lỗi (2 lỗi chồng nhau) |

Câu giữ nguyên chỉ sửa chú thích tiêu đề khối (`% ==== J8 · … Dễ`, `Q5 · … Dễ`, `Q7 · … Cơ bản`) cho khớp `cap` đã đổi ở v2.

### Thời gian chạy (đo lúc 4 agent khác cùng dùng `sqllb-mysql`, gồm khoảng 0,15 giây gọi `docker exec`)

- Mọi solution của gói, cả hai biến thể: chậm nhất **`mkt-q4-thang-roi-tren-muc-quy-1` 3,9 giây** (public; hidden-1 3,0 giây), tiếp theo `mkt-c5-kenh-hieu-qua-hon.b2` 3,9 giây, `mkt-j7` 3,6 giây; các câu mới khác dưới 1,7 giây.
- Cách giải tự nhiên đã đo: q4 truy vấn con tương quan ở SELECT và HAVING 3,6–4,3 giây, CTE hai tầng 0,4 giây; q9 truy vấn con tương quan có `BETWEEN` 2,1 giây, bảng dẫn xuất 0,2 giây; j6 `NOT EXISTS` 0,6 giây, `NOT IN` 0,9 giây, bảng dẫn xuất `MAX(channel_id = 1)` 1,9 giây. Mọi cách cho cùng kết quả với solution.
- Thu phạm vi vì chậm: q9 bản 7 ngày (1–7/3) lời giải 7,7 giây, bài sai chỉ sửa bí danh 23,5 giây → 2 ngày (7–8/3): 0,8 giây và 2,1 giây. q4 bản 5 tháng đầu 2025 (có bẫy tháng 6 chưa đủ) truy vấn con tương quan ở HAVING 7,5 giây → một quý: 3,6–4,3 giây; bản đầu tiên (11 tháng, tương quan ở SELECT) 14 giây.

### Kiểm lại

- Kiểm tĩnh (`--chi-phan-tich`): 20 câu, 0 lỗi, 0 cảnh báo.
- Bộ kiểm đầy đủ (`cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/mkt/goi-3 --ra cong-cu/ket-qua/cap-do/mkt-goi-3 --host sqllb-mysql --port 3306`): 20 câu, 80 khối SQL, `KIEM TRA: 0 loi`, 0 cảnh báo. Mọi wrong mới rớt ≥ 1 biến thể; `mkt-j9…sua_hai_loi_thieu_can_tren`, `mkt-q4…lam_tron_truoc_khi_so` chỉ rớt ở hidden-1 như thiết kế. Solution của 7 câu mới khác nhau giữa public và hidden-1 (md5 kết quả).
- Biên dịch `bash cong-cu/bien_dich.sh goi-cau-hoi/mkt/goi-3 <ra>`: 53 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo `aio-sql-cauhoi` (PDF ở `cong-cu/ket-qua/cap-do/mkt-goi-3/bien-dich/`). Đã xem PDF: ERD Cơ bản của j1 lúc đầu chồng hai bảng, đã dời bảng thứ hai sang cột 2 (cả j3).
- Thư mục gói vẫn đúng 4 file.

### Cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6) trên chữ mới

Đã đọc lại mọi trường của 7 câu. Sửa trước khi chốt:
- j1 lời nhắn: "danh sách chiến dịch đạt từ 2 triệu đơn vị tiền doanh thu" (trật tự từ kiểu dịch) → "danh sách chiến dịch có doanh thu từ 2 triệu (đơn vị tiền) trở lên".
- j3 lời nhắn: "khởi chạy ngày 15/5 có chạy trên YouTube" (lặp "chạy") → "khởi chạy ngày 15/5 có dùng kênh YouTube".
- j6 lời nhắn: "Chị cần số liệu …: bao nhiêu …, chiếm bao nhiêu phần, và doanh thu … là bao nhiêu" (khuôn hai chấm, ba vế) → "Em tính giúp chị, cho nửa đầu 2025 và theo từng thương hiệu, có bao nhiêu …, chiếm tỷ lệ bao nhiêu và mang về bao nhiêu doanh thu."
- j6 gợi ý 1: "chỉ cần biết một điều: bảng cầu nối có …" (khuôn "mệnh đề: kết luận") → "Ở mỗi chiến dịch loại Email, chỉ cần biết bảng cầu nối có dòng kênh Email của chiến dịch đó hay không."

Không có tên kỹ thuật SQL trong lời nhắn; thuật ngữ theo STYLE-mkt A ("loại Email"/"kênh Email", "lượt nhấp (click)", "marketing mạng xã hội (Social Media)", "đơn vị tiền", ROI là hệ số). Sau khi sửa: 0 chỗ giọng AI, 0 chỗ dịch máy theo người sửa; cần người kiểm đọc độc lập.

### Ô dạng × mảng × cấp × hình thức

Không trùng trong gói (đã đối chiếu cả 20 câu). Giữa các gói: `mkt-j3-influencer-nykaa-tren-youtube` (A1 · marketing · basic · write) cùng ô với `mkt-r1-influencer-purplle-thang-1` (gói 1, M1, lọc một bảng): khác module, được phép, ghi để tham khảo. Nội dung gần: q4 và q1 cùng ý "ROI trên mức chung" (khác cấp Khó/Dễ, khác đơn vị so: tháng so với quý, chiến dịch so với tháng); q3 (Cơ bản, Viết) và q9 (Khó, Sửa lỗi) cùng dạng C3 · marketing nhưng khác cấp, hình thức. Các gói 1, 2, 4, 5 đang được sửa song song nên chỉ đối chiếu được bản trên đĩa lúc 11/11.

Dòng bản đồ mới: `BAN-DO-V4-DONG.md` (đã gộp vào `BAN-DO-100-CAU.md` ngày 11/11, file đã xoá) (7 dòng, kèm mã cũ). `../../BAN-DO-100-CAU.md` không sửa theo brief v4.

Điểm tự thấy yếu: j6 chưa có bẫy chỉ lộ ở hidden-1; q4 Khó chỉ dùng một bảng và ra 6 dòng (đúng mẫu o4 nhưng ít dòng); ERD Khó của j9, q4, q9 phải thêm 3–4 bảng nhiễu cho đủ 5 bảng (QUYET-DINH-CHUNG 1.3).

## Sửa theo KIEM-V4 (11/11/2026)

Căn cứ: `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md` (gói 3: 1 câu "Cần sửa"). Chỉ sửa chữ, không đổi SQL, cấp, mã.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| mkt-j9-lich-paid-ads-tira-chua-dung-duoc | B: gợi ý 2 ("Đưa điều kiện thương hiệu, loại vào ON, đếm COUNT(c.campaign_id) và thêm cận trên …") là trọn lời giải của cả 3 lỗi | Gợi ý 2 còn một biểu thức cho lỗi thứ nhất: `LEFT JOIN campaigns c ON c.start_date = k.cal_date AND c.brand_id = 3 AND c.type_id = 3`; lỗi đếm và lỗi cận trên để học viên tự sửa theo gợi ý 1. Gợi ý 1: "cho nó số 1" → "cho ngày đó số 1" (đại từ "nó" chỉ vật) | Bộ kiểm đầy đủ cả gói (`cong-cu/ket-qua/sua-v4/mkt-goi-3`): KIEM TRA: 0 loi; biên dịch 0 lỗi LaTeX |

Không áp (đề xuất tuỳ chọn, B/C ghi "Đạt"): j3 (đổi sang Paid Ads cho bớt na ná r1), q4 (bỏ câu đầu của `\luuy`), q9 (thêm lỗi thứ ba vào truy vấn con), j6 (bẫy hidden-1 cần `mkt_hidden_2`). Không câu nào của gói 3 đổi cấp; 0 ô trùng trong gói.
