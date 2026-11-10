# Bản đồ 100 câu · bộ MARKETING (`mkt`)

**Bản 2 · sinh lại 10/11/2026 từ file thật** (`goi-*/cau-hoi.tex`, `goi-*/solution.sql`): mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá của `\begin{cauhoi}`; gói theo thư mục; module theo tiền tố mã (r n s a j q t f k p = M1…M10, c = case). Cột “Đề một câu” là mục đầu của `yeucau` (case: tên các bước); “Bảng” lấy từ `FROM`/`JOIN` của lời giải (bỏ CTE); “Bẫy chính” là khoá `bay` (case: tên bài sai theo bước). Phần mở đầu giữ từ bản 1; thống kê và chênh lệch so với bản 1 ở cuối file.

Bản nháp 1 · 10/11/2026. Phân bổ theo `BRIEF-SOAN-GOI.md` mục "Phân bổ": gói k = module 2k−1, 2k (9 câu mỗi module) + 2 case.
Dữ liệu, bẫy và biến thể: `mysql/README-mkt.md`. Thuật ngữ, giọng văn, khái niệm, mảng: `style/STYLE-mkt.md` (mảng mục G).

Viết tắt bảng: **C** `campaigns` · **CC** `campaign_channels` · **CH** `channels` · **B** `brands` · **T** `campaign_types` ·
**AU** `audiences` · **L** `languages` · **K** `calendar` · **R** `campaigns_raw` · **N** `noise_log`.
Hình thức: W write, D debug, O optimize, C case. Cấp: basic, easy, medium, hard.
Mảng: mkt = marketing, cus = customer, fin = finance, sal = sales, ops = operations (`after_sales` không có dữ liệu, xem STYLE-mkt G).
"h1" = bẫy chỉ lộ ở `mkt_hidden_1`: (b) chiến dịch `NY-CMP-56555` ngày **2025-07-01** (Nykaa · Social Media · College Students/College Students · Hindi · WhatsApp + YouTube);
(c) **Nykaa top 3 theo `revenue`** hoà hạng 3–4; (a) bỏ ~10% chiến dịch.
Wrong "thiếu cận trên" chỉ rớt khi nhóm kết quả chứa dòng (b): chọn phạm vi có Nykaa / Social Media / Hindi / College Students hoặc toàn bộ.
Mọi câu có mốc thời gian phải có cận trên. Mọi top N phải nêu quy tắc hoà bằng khoá (`campaign_id` so theo chuỗi).
Dữ liệu sạch (`C`) không có NULL: module NULL và Data Quality dùng `R`/`N`.

## Gói 1 · M1 Retrieval, M2 NULL & Expressions

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-r1-influencer-purplle-thang-1 | 1 | M1 | W | basic | A1 | mkt | Chiến dịch Influencer nào của Purplle có trên 98.000 lượt hiển thị trong tháng 1/2025? | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu từ ngày 1/1/2025 tới hết ngày 31/1/2025. · Lọc các chiến dịch có lượt hiển thị (`impressions`) lớn … | C | thieu-can-tren, chieu-sap-xep |
| mkt-r2-working-women-tamil-tira | 1 | M1 | W | basic | A1 | cus | Chiến dịch tiếng Hindi nào của Tira Beauty dành cho phụ nữ đi làm? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu ngày 8/3/2025. · Lọc các chiến dịch có đối tượng mục tiêu là Working Women (phụ nữ đi làm, mã 4) và ngôn ngữ Hindi (`language_id = 3`). | C | nham-doi-tuong-voi-phan-khuc |
| mkt-r3-roi-thap-nhat-nykaa-q4 | 1 | M1 | W | basic | A1 | fin | 10 chiến dịch có ROI thấp nhất của Nykaa quý 4/2024 | Xét các chiến dịch của Nykaa (`brand_id = 1`) bắt đầu từ ngày 1/10/2024 tới hết ngày 31/12/2024. · Trả về `campaign_id`, `start_date`, `roi`. | C | quy-tac-hoa, chieu-sap-xep, thieu-can-tren |
| mkt-r4-email-chuyen-doi-cao | 1 | M1 | W | easy | A1 | sal | Chiến dịch loại Email nào đạt từ 6.000 lượt chuyển đổi? | Xét mọi chiến dịch loại Email trong kỳ dữ liệu, của cả ba thương hiệu. · Lọc các chiến dịch có lượt chuyển đổi (`conversions`) từ 6.000 trở lên. | C | nham-loai-voi-kenh |
| mkt-r5-chien-dich-30-ngay-cuoi-ky | 1 | M1 | W | easy | A1 | ops | Purplle mở chiến dịch 30 ngày nào từ 28/5/2025? | Xét các chiến dịch của Purplle (`brand_id = 2`) có thời lượng (`duration_days`) đúng 30 ngày. · Lọc các chiến dịch bắt đầu từ ngày 28/5/2025 tới hết kỳ dữ liệu. | C | bo-ngay-dau, sap-nhieu-cot |
| mkt-r6-diem-tuong-tac-tu-30 | 1 | M1 | W | easy | A1 | mkt | Chiến dịch nào có điểm tương tác từ 30 trở lên? | Xét mọi chiến dịch trong kỳ dữ liệu, của cả ba thương hiệu. · Lọc các chiến dịch có điểm tương tác (`engagement_score`) từ 30 trở lên. | C | lon-hon-va-tu, quy-tac-hoa |
| mkt-r7-paid-ads-ra-rong | 1 | M1 | D | basic | A1 | mkt | Danh sách chiến dịch Paid Ads của Nykaa ra rỗng | Sửa truy vấn dưới đây để lấy đúng các chiến dịch của Nykaa (`brand_id = 1`), loại Paid Ads (quảng cáo trả phí), bắt đầu ngày 14/2/2025. · Mã loại chiến dịch: 1 Email, 2 Influencer (marketing người ảnh hưởng), 3 Paid … | C | so-ma-voi-ten |
| mkt-r8-thang-2-thieu-ngay-cuoi | 1 | M1 | D | easy | A1 | sal | Chiến dịch tháng 2/2025 của Tira Beauty thiếu ngày cuối tháng | Sửa truy vấn khởi đầu để lấy đủ các chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu trong tháng 2/2025 và có từ 4.000 lượt chuyển đổi trở lên. · Giữ nguyên các cột `campaign_id`, `start_date`, `conversions` và thứ … | C | can-tren-sai-ngay, between-hai-dau |
| mkt-r9-youth-hoac-working-women-thua | 1 | M1 | D | easy | A1 | cus | Lọc chiến dịch Youth hoặc Working Women của Tira Beauty ra thừa | Sửa truy vấn dưới đây để chỉ lấy các chiến dịch của Tira Beauty (`brand_id = 3`), loại Paid Ads (`type_id = 3`), bắt đầu ngày 12/4/2025, có đối tượng mục tiêu là Youth (giới trẻ, mã 5) hoặc Working Women (phụ nữ đi … | C | thu-tu-and-or, nham-doi-tuong-voi-phan-khuc |
| mkt-n1-ctr-seo-nykaa-ngay | 1 | M2 | W | basic | A2 | mkt | CTR của từng chiến dịch SEO Nykaa ngày 1/1/2025 | Xét các chiến dịch của Nykaa (`brand_id = 1`), loại SEO (`type_id = 4`), bắt đầu ngày 1/1/2025. · Tính CTR (tỷ lệ nhấp) của từng chiến dịch theo công thức trong khái niệm CTR. | C | quen-nhan-100, lam-tron-som |
| mkt-n2-thieu-hien-thi-co-nhap | 1 | M2 | W | basic | A1 | ops | Dòng nào của dữ liệu thô có lượt nhấp mà thiếu lượt hiển thị? | Xét mọi dòng của dữ liệu thô `campaigns_raw`. · Lọc các dòng có lượt hiển thị (`impressions`) trống và lượt nhấp (`clicks`) không trống. | R | so-bang-null |
| mkt-n3-chi-phi-chien-dich-8-3 | 1 | M2 | W | easy | A2 | fin | Chi phí từng chiến dịch Influencer của Tira Beauty ngày 8/3 | Xét các chiến dịch của Tira Beauty (`brand_id = 3`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu ngày 8/3/2025. · Tính chi phí của từng chiến dịch bằng công thức chi phí chiến dịch. | C | nham-cpa-voi-tong-chi-phi |
| mkt-n4-lai-hoa-lo-quy-1 | 1 | M2 | W | easy | A3 | fin | Quý 1/2025 có bao nhiêu chiến dịch lãi, hoà vốn và lỗ? | Xét mọi chiến dịch của ba thương hiệu bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Xếp mỗi chiến dịch vào một nhóm theo cột `roi`: có lãi khi `roi` lớn hơn 0, hoà vốn khi bằng 0, lỗ khi nhỏ hơn 0. | C | bien-bang-0, thieu-can-tren |
| mkt-n5-dong-thieu-chi-so-pheu | 1 | M2 | W | easy | E1 | ops | Bao nhiêu dòng dữ liệu thô thiếu ít nhất một chỉ số phễu? | Xét mọi dòng của dữ liệu thô `campaigns_raw`. · Ở mỗi thương hiệu, đếm số dòng có ít nhất một ô trống ở bốn cột `impressions`, `clicks`, `leads`, `conversions`. | R | thieu-cot-trong-or, and-thay-or |
| mkt-n6-gia-tri-don-11-11 | 1 | M2 | W | easy | A2 | sal | Giá trị đơn bình quân của chiến dịch Influencer Purplle dịp 11/11 | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu ngày 11/11/2024. · Tính giá trị đơn bình quân của từng chiến dịch; nếu chiến dịch không có lượt … | C | chia-nguoc, sai-mau-so |
| mkt-n7-doanh-thu-tho-thap-bat-thuong | 1 | M2 | D | basic | A2 | sal | Doanh thu bình quân trên dữ liệu thô thấp hơn bản sạch | Kết quả đúng là doanh thu bình quân một dòng của `campaigns_raw`, chỉ tính các dòng có doanh thu dương; bỏ dòng có doanh thu trống và dòng có doanh thu âm. Sửa truy vấn khởi đầu để ra kết quả này. · Giữ nguyên cột … | R | null-thanh-0, gia-tri-am |
| mkt-n8-roi-tinh-lai-lech | 1 | M2 | D | easy | A2 | fin | ROI tính lại lệch xa cột có sẵn | Sửa truy vấn khởi đầu để tính lại đúng ROI (lợi tức đầu tư) của các chiến dịch Purplle (`brand_id = 2`), loại SEO (`type_id = 4`), bắt đầu ngày 1/4/2025. · ROI tính theo công thức trong khái niệm ROI; chi phí tính như … | C | thieu-ngoac, nham-cpa-voi-tong-chi-phi |
| mkt-n9-thieu-chi-phi-ra-0 | 1 | M2 | D | easy | E1 | ops | Đếm dòng trống CPA trong dữ liệu thô ra 0 | Sửa truy vấn dưới đây để đếm đúng số dòng của `campaigns_raw` có `acquisition_cost` (CPA) trống ở mỗi thương hiệu. · Giữ nguyên các cột `brand_id`, `so_dong_thieu` và thứ tự sắp. | R | so-bang-null, count-bieu-thuc |
| mkt-c1-ctr-theo-loai-thang-5 | 1 | case | C | basic | – | mkt | Loại chiến dịch nào có CTR cao nhất tháng 5/2025? | b1 CTR của từng loại chiến dịch; b2 Kết luận | C | b1: binh_quan_ctr_tung_chien_dich, thieu_can_tren |
| mkt-c2-nhieu-don-vao-thuong-hieu-nao | 1 | case | C | basic | – | ops | Dữ liệu thô của thương hiệu nào thiếu nhiều nhất? | b1 Số dòng thiếu của từng thương hiệu; b2 Kết luận | R | b1: chi_xet_cot_pheu, dem_dong_co_gia_tri |

## Gói 2 · M3 String & Date, M4 Aggregation

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-s1-social-nykaa-theo-thang | 2 | M3 | W | basic | B1 | mkt | Mỗi tháng Nykaa mở bao nhiêu chiến dịch mạng xã hội? | Xét các chiến dịch của Nykaa (`brand_id = 1`), loại Social Media (marketing mạng xã hội, `type_id = 5`), bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Đếm số chiến dịch theo tháng của ngày bắt đầu. | C | thieu-can-tren, ten-thang-chu |
| mkt-s2-ket-thuc-ngay-14-2 | 2 | M3 | W | basic | A1 | ops | Chiến dịch nào của Tira Beauty kết thúc ngày 14/2/2025? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), đối tượng mục tiêu Youth (giới trẻ, `target_audience_id = 5`). · Tính ngày cuối của chiến dịch bằng ngày … | C | lech-mot-ngay |
| mkt-s3-bat-dau-cuoi-tuan | 2 | M3 | W | easy | A3 | ops | Mỗi loại chiến dịch có bao nhiêu phần trăm bắt đầu vào cuối tuần? | Xét mọi chiến dịch của ba thương hiệu bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Cuối tuần là thứ Bảy và Chủ nhật. | C | dayofweek-1-la-chu-nhat, thieu-can-tren |
| mkt-s4-ba-kenh-youtube-dau | 2 | M3 | W | easy | A1 | mkt | Bao nhiêu chiến dịch ba kênh ghi YouTube đầu tiên? | Xét cột `channel_used` của dữ liệu thô `campaigns_raw`: tên kênh cách nhau bởi dấu phẩy và một dấu cách, ví dụ `'YouTube, Instagram, Email'`. · Chọn các dòng có đúng ba kênh và kênh ghi đầu tiên là YouTube. | R | like-moi-vi-tri, dong-trung |
| mkt-s5-ngay-tho-khong-doc-duoc | 2 | M3 | W | easy | E1 | ops | Mỗi file thô có bao nhiêu dòng mang ngày bắt đầu không hợp lệ? | Xét mọi dòng của dữ liệu thô `campaigns_raw`; ngày bắt đầu nằm ở cột chuỗi `date_raw`, dạng ngày-tháng-năm như `'15-03-2025'`. · Một dòng có ngày không hợp lệ khi `date_raw` trống, không đọc được theo dạng trên (kể cả … | R | ngay-doc-duoc-ngoai-ky, so-sanh-voi-null |
| mkt-s6-so-duoi-ma-lon-nhat | 2 | M3 | W | easy | A1 | ops | Chiến dịch mở ngày 24/6/2025 mang mã số bao nhiêu? | Mã chiến dịch có dạng tiền tố thương hiệu, chữ `CMP` và một số, nối bằng dấu gạch ngang, ví dụ `'NY-CMP-1534'`. · Xét các chiến dịch bắt đầu ngày 24/6/2025. Tách phần số sau dấu gạch ngang cuối cùng và đổi sang kiểu số. | C | so-sanh-chuoi-so |
| mkt-s7-dem-loai-ra-20-nhom | 2 | M3 | D | basic | E1 | mkt | Đếm dữ liệu thô theo loại chiến dịch ra 20 nhóm | Sửa truy vấn dưới đây để đếm số dòng của `campaigns_raw` theo loại chiến dịch, mỗi loại đúng một nhóm. · Tên loại trong cột `loai_chien_dich` không còn khoảng trắng thừa ở đầu và cuối. | R | khoang-trang-thua |
| mkt-s8-thang-sap-sai-thu-tu | 2 | M3 | D | easy | B1 | sal | Doanh thu theo tháng sắp sai thứ tự | Sửa truy vấn khởi đầu để cột `thang` có dạng năm-tháng (ví dụ `'2024-07'`) và các dòng sắp đúng trình tự thời gian. · Giữ nguyên phạm vi ngày, các cột `thang`, `so_chien_dich`, `doanh_thu` (đơn vị tiền). | C | sap-chuoi-thang-nam, ten-thang-chu |
| mkt-s9-dang-chay-ngay-1-1 | 2 | M3 | D | easy | B4 | ops | Số chiến dịch đang chạy ngày 1/1/2025 bị thiếu | Cần số chiến dịch đang chạy vào ngày 1/1/2025 của từng thương hiệu, theo khái niệm chiến dịch đang chạy. Sửa truy vấn khởi đầu để ra đúng số này. · Giữ nguyên các cột `brand_id`, `so_dang_chay` và thứ tự sắp. | C | lech-mot-ngay-ngay-cuoi |
| mkt-a1-roi-tong-theo-thuong-hieu | 2 | M4 | W | easy | A2 | fin | ROI của từng thương hiệu cả kỳ là bao nhiêu? | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Tính số chiến dịch, tổng doanh thu, tổng chi phí chiến dịch và ROI (lợi tức đầu tư) của từng thương hiệu, ROI theo tỷ lệ của tổng. | C | avg-cua-ty-le, thieu-can-tren |
| mkt-a2-pheu-theo-loai | 2 | M4 | W | easy | A3 | mkt | Ba tỷ lệ của phễu theo loại chiến dịch, nửa đầu 2025 | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/1/2025 tới hết ngày 30/6/2025. · Tính số chiến dịch, CTR (tỷ lệ nhấp), tỷ lệ khách hàng tiềm năng và tỷ lệ chuyển đổi của từng loại chiến dịch (`type_id`). Cả ba … | C | avg-cua-ty-le, sai-mau-so-chuyen-doi, thieu-can-tren |
| mkt-a3-doi-tuong-quy-1 | 2 | M4 | W | easy | A3 | cus | Nhóm đối tượng nào dẫn đầu doanh thu quý 1/2025? | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Tính số chiến dịch và tổng doanh thu của từng nhóm đối tượng mục tiêu. | C | nham-doi-tuong-voi-phan-khuc, thieu-can-tren |
| mkt-a4-bang-cheo-ngon-ngu | 2 | M4 | W | easy | A4 | cus | Lượt chuyển đổi theo ngôn ngữ và thương hiệu | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Mỗi dòng là một ngôn ngữ (`language_id`); các cột `nykaa`, `purplle`, `tira_beauty` là tổng lượt chuyển đổi của thương hiệu tương ứng; cột `tong` là … | C | count-thay-sum, thieu-can-tren |
| mkt-a5-ngay-tren-500-chien-dich | 2 | M4 | W | medium | A1 | ops | Ngày nào tháng 3/2025 khởi chạy hơn 350 chiến dịch có lãi? | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/3/2025 tới hết ngày 31/3/2025. Chiến dịch có lãi là chiến dịch có `roi` lớn hơn 0. · Đếm tổng số chiến dịch (gồm cả hoà vốn và lỗ) và số chiến dịch có lãi của … | C | loc-dong-o-where, having-sai-dieu-kien, thieu-can-tren |
| mkt-a6-doanh-thu-nykaa-theo-thang | 2 | M4 | W | easy | B1 | sal | Giá trị đơn bình quân của Nykaa theo tháng | Xét các chiến dịch của Nykaa (`brand_id = 1`) bắt đầu từ ngày 1/7/2024 tới hết dữ liệu hiện có (không đặt mốc cuối). · Tính tổng lượt chuyển đổi, tổng doanh thu và giá trị đơn bình quân theo tỷ lệ của tổng của từng … | C | gom-thang-bo-nam, avg-cua-ty-le |
| mkt-a7-roi-thuong-hieu-cao-bat-thuong | 2 | M4 | D | easy | A2 | fin | ROI toàn thương hiệu Purplle cao bất thường | Sửa truy vấn dưới đây để tính ROI (lợi tức đầu tư) của toàn bộ chiến dịch Purplle (`brand_id = 2`) bắt đầu từ ngày 1/7/2024 tới hết ngày 31/12/2024, theo tỷ lệ của tổng. · Chi phí tính theo khái niệm chi phí chiến dịch. | C | avg-cua-ty-le, nham-roi-voi-roas, nham-cpa-voi-tong-chi-phi |
| mkt-a8-so-chien-dich-tho-thua | 2 | M4 | D | easy | A2 | ops | Số chiến dịch Tira Beauty trong dữ liệu thô nhiều hơn báo cáo | Kết quả cần có: số dòng và số chiến dịch của Tira Beauty (`brand_id = 3`) trong `campaigns_raw`, mỗi mã chiến dịch chỉ tính một lần. Sửa truy vấn khởi đầu để ra đúng hai số này. · Giữ nguyên các cột `so_dong`, … | R | count-dem-dong-trung |
| mkt-a9-doanh-thu-theo-quy-gop-sai | 2 | M4 | D | medium | B1 | sal | Doanh thu theo quý không ghi năm | Sửa truy vấn dưới đây để tính số chiến dịch và tổng doanh thu theo năm và quý của ngày bắt đầu. · Chỉ xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. | C | quy-thieu-nam, thieu-can-tren |
| mkt-c3-thang-nykaa-mo-nhieu-nhat | 2 | case | C | basic | – | mkt | Tháng nào Purplle mở chiến dịch dày nhất? | b1 Số chiến dịch và bình quân mỗi ngày theo tháng; b2 Kết luận | C | b1: giu_thang_chua_du, chia_31_ngay |
| mkt-c4-loai-roi-duoi-muc-chung | 2 | case | C | easy | – | fin | Loại chiến dịch nào có ROI thấp hơn mức chung? | b1 ROI của từng loại chiến dịch; b2 ROI chung của cả ba thương hiệu; b3 Kết luận | C | b1: avg_roi, thieu_can_tren; b2: doanh_thu_chia_chi_phi, thieu_can_tren |

## Gói 3 · M5 Joins, M6 Subqueries

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-j1-doanh-thu-loai-thuong-hieu | 3 | M5 | W | easy | A3 | mkt | Doanh thu theo loại chiến dịch của từng thương hiệu quý 2/2025 | Xét các chiến dịch bắt đầu từ ngày 1/4/2025 tới hết ngày 30/6/2025. · Đếm số chiến dịch và cộng doanh thu (`revenue`, đơn vị tiền) theo từng thương hiệu và từng loại chiến dịch. | C, B, T | noi-sai-khoa, thieu-can-tren |
| mkt-j2-doi-tuong-va-phan-khuc | 3 | M5 | W | easy | A3 | cus | Đối tượng mục tiêu và phân khúc khách hàng khớp nhau đến đâu? | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 31/12/2024. · Đếm số chiến dịch theo từng cặp đối tượng mục tiêu và phân khúc khách hàng (ghi bằng tên nhóm). | C, AU | noi-mot-lan-cho-hai-vai |
| mkt-j3-hien-thi-theo-kenh | 3 | M5 | W | medium | A3 | mkt | Mỗi kênh có mặt trong bao nhiêu chiến dịch của Nykaa quý 2/2025? | Xét các chiến dịch của Nykaa (`brand_id = 1`) bắt đầu từ ngày 1/4/2025 tới hết ngày 30/6/2025. · Đếm theo từng kênh số chiến dịch có dùng kênh đó và cộng lượt hiển thị (`impressions`) của các chiến dịch đó. Chiến dịch … | C, CC, CH | kenh-dau-khong-phai-kenh-chinh, thieu-can-tren |
| mkt-j4-dang-chay-tuan-dau-thang-2 | 3 | M5 | W | medium | B4 | ops | Mỗi ngày tuần 3–9/2/2025 có bao nhiêu chiến dịch đang chạy? | Đếm số chiến dịch đang chạy của từng ngày trong lịch ngày, từ 3/2/2025 tới hết 9/2/2025. · Chiến dịch đang chạy vào ngày d khi d nằm trong khoảng từ ngày bắt đầu tới ngày cuối, tính cả hai đầu; ngày cuối = `start_date` … | K, C | lech-bien-ngay-cuoi, noi-bang |
| mkt-j5-ngay-khong-co-chien-dich | 3 | M5 | W | medium | A1 | ops | Tháng 5/2025 ngày nào Tira Beauty không mở chiến dịch Paid Ads tiếng Hindi cho Premium Shoppers? | Xét mọi ngày từ 1/5/2025 tới hết 31/5/2025 trong lịch ngày `calendar`. · Liệt kê các ngày không có chiến dịch nào của Tira Beauty (`brand_id = 3`), loại Paid Ads (`type_id = 3`), ngôn ngữ Hindi (`language_id = 3`), đối … | K, C | noi-trong, dieu-kien-o-where |
| mkt-j6-loai-email-khong-kenh-email | 3 | M5 | W | medium | E2 | mkt | Bao nhiêu chiến dịch loại Email không chạy trên kênh Email? | Xét mọi chiến dịch loại Email (tên loại `'Email'` trong `campaign_types`) trong kỳ dữ liệu. · Theo từng thương hiệu, đếm số chiến dịch loại Email và số chiến dịch loại Email không có kênh Email (`channel_id = 1`) trong … | C, T, CC | nham-loai-voi-kenh, fan-out |
| mkt-j7-doanh-thu-instagram-facebook-gap-doi | 3 | M5 | D | easy | A3 | sal | Doanh thu chiến dịch dùng Instagram hoặc Facebook bị cộng hai lần | Truy vấn khởi đầu đếm số chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu từ 1/1/2025 tới hết 31/3/2025 có dùng kênh Facebook (`channel_id = 2`) hoặc Instagram (`channel_id = 4`). · Truy vấn cũng cộng doanh thu của … | C, CC | fan-out |
| mkt-j8-phan-khuc-lay-nham-doi-tuong | 3 | M5 | D | easy | A3 | cus | Doanh thu theo phân khúc giống hệt doanh thu theo đối tượng | Báo cáo cần số chiến dịch và tổng doanh thu theo phân khúc khách hàng của Purplle (`brand_id = 2`), xét các chiến dịch bắt đầu từ 1/1/2025 tới hết 30/6/2025. · Sửa truy vấn cho đúng yêu cầu; giữ các cột `phan_khuc`, … | C, AU | nham-vai-khoa-ngoai |
| mkt-j9-lich-thieu-ngay-trong | 3 | M5 | D | medium | B1 | ops | Lịch chiến dịch quảng cáo trả phí của Tira Beauty theo ngày bị thiếu ngày | Bảng cần đúng một dòng cho mỗi ngày từ 1/6/2025 tới hết 30/6/2025 trong lịch ngày, kèm số chiến dịch Paid Ads (`type_id = 3`) của Tira Beauty (`brand_id = 3`) bắt đầu ngày đó; ngày không có chiến dịch ghi 0. · Sửa truy … | K, C | dieu-kien-o-where, count-sao, thieu-can-tren |
| mkt-q1-roi-tren-binh-quan-tira | 3 | M6 | W | easy | C3 | fin | Bao nhiêu chiến dịch Tira Beauty tháng 4/2025 có ROI trên mức chung? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu từ 1/4/2025 tới hết 30/4/2025. · Mức chung là ROI (lợi tức đầu tư) của cả nhóm chiến dịch này, tính theo tỷ lệ của tổng: (tổng doanh thu - tổng chi phí) / … | C | muc-chung-sai-pham-vi, avg-cua-ty-le |
| mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu | 3 | M6 | W | easy | C1 | sal | Chiến dịch nào doanh thu cao nhất của mỗi thương hiệu ngày 5/3/2025? | Xét các chiến dịch bắt đầu ngày 5/3/2025. · Lấy chiến dịch có doanh thu (`revenue`) cao nhất của từng thương hiệu; nếu nhiều chiến dịch cùng mức cao nhất thì lấy hết. | C | khong-tuong-quan, gom-nhom-lay-ma-sai |
| mkt-q3-loai-ctr-tren-chung | 3 | M6 | W | medium | C3 | mkt | Loại chiến dịch nào có CTR cao hơn CTR chung? | Xét mọi chiến dịch trong kỳ dữ liệu. · CTR (tỷ lệ nhấp) của một loại và CTR chung đều tính theo tỷ lệ của tổng: tổng `clicks` × 100 / tổng `impressions`. | C, T | where-thay-having, don-vi-phan-tram |
| mkt-q4-doi-soat-roi-tinh-san | 3 | M6 | W | medium | E2 | fin | Chiến dịch nào có ROI ghi sẵn lệch công thức? | ROI tính lại = (`revenue` - chi phí) / chi phí, với chi phí = `acquisition_cost` × `conversions`; không làm tròn ROI tính lại trước khi so. · Chênh lệch = giá trị tuyệt đối của (`roi` - ROI tính lại). Lấy các chiến … | C | so-bang-voi-so-da-lam-tron |
| mkt-q5-ty-trong-loai-purplle | 3 | M6 | W | easy | C2 | sal | Mỗi loại chiến dịch đóng góp bao nhiêu phần trăm doanh thu của Purplle? | Xét mọi chiến dịch của Purplle (`brand_id = 2`) trong kỳ dữ liệu. · Tính tổng doanh thu và tỷ trọng của từng loại chiến dịch, với tỷ trọng = doanh thu của loại × 100 / tổng doanh thu của Purplle. | C, T | sai-mau-so, thieu-loc-ngoai |
| mkt-q6-ngay-purplle-khong-seo | 3 | M6 | W | medium | A1 | mkt | Ngày nào tháng 5/2025 Purplle không mở chiến dịch SEO tiếng Tamil cho giới trẻ? | Xét mọi ngày từ 1/5/2025 tới hết 31/5/2025 trong lịch ngày. · Lấy các ngày không có chiến dịch nào của Purplle (`brand_id = 2`), loại SEO (`type_id = 4`), ngôn ngữ Tamil (`language_id = 4`), đối tượng mục tiêu Youth … | K, C | khong-tuong-quan, thieu-can-tren, nham-doi-tuong-voi-phan-khuc |
| mkt-q7-shoppers-ra-rong | 3 | M6 | D | basic | A1 | cus | Chiến dịch nhắm nhóm “Shoppers” không ra dòng nào | Mục đích của truy vấn khởi đầu: đếm số chiến dịch của từng thương hiệu bắt đầu từ 1/5/2025 tới hết 31/5/2025 mà đối tượng mục tiêu có tên chứa chữ `Shoppers`. · Sửa truy vấn cho đúng yêu cầu; giữ cột `brand_id`, … | C, AU | mau-like-sai-vi-tri |
| mkt-q8-dong-sach-khong-nhieu-sai | 3 | M6 | D | medium | E2 | ops | Số dòng dữ liệu thô không có trong nhật ký nhiễu bị sai | Truy vấn khởi đầu phải đếm số dòng `campaigns_raw` của từng thương hiệu không bị nhật ký nhiễu nhắc tới, tức không có dòng `noise_log` nào cùng thương hiệu và cùng vị trí dòng. · Sửa truy vấn cho đúng yêu cầu; giữ cột … | R, N | khoa-kep, row-index-lap-giua-thuong-hieu |
| mkt-q9-tuong-tac-tren-binh-quan-loai | 3 | M6 | D | medium | C3 | mkt | Đếm sai số chiến dịch có điểm tương tác trên bình quân của loại | Cần đếm số chiến dịch của Nykaa (`brand_id = 1`) theo từng loại, xét các chiến dịch bắt đầu từ 1/3/2025 tới hết 7/3/2025 có `engagement_score` lớn hơn bình quân `engagement_score` của các chiến dịch Nykaa cùng loại … | C | tuong-quan-sai-bi-danh |
| mkt-c5-kenh-hieu-qua-hon | 3 | case | C | easy | – | mkt | Kênh nào gắn với chiến dịch hiệu quả hơn? | b1 Số chiến dịch và CTR theo kênh; b2 ROI tổng theo kênh; b3 Kết luận | C, CC, CH | b1: binh_quan_ctr_tung_chien_dich, thieu_can_tren; b2: binh_quan_cot_roi, chi_phi_la_acquisition_cost |
| mkt-c6-tho-va-sach-lech-o-dau | 3 | case | C | medium | – | ops | Bản thô và bản sạch lệch nhau ở đâu? | b1 Số dòng và số mã của hai bản; b2 Dòng thô có chỉ số khác bản sạch; b3 Đối chiếu với nhật ký nhiễu; b4 Kết luận | R, C, N | b1: dem_ma_khong_distinct; b2: so_khac_bo_qua_null; b3: noi_theo_campaign_id, noi_chi_theo_vi_tri |

## Gói 4 · M7 CTE & Set Operations, M8 Window Functions

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-t1-roas-nua-dau-2025 | 4 | M7 | W | medium | A2 | fin | ROAS của từng thương hiệu nửa đầu 2025 là bao nhiêu? | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 30/6/2025. · Tính tổng doanh thu, tổng chi phí chiến dịch, ROI (lợi tức đầu tư) và ROAS (doanh thu trên chi phí quảng cáo) của từng thương hiệu; ROI và ROAS tính … | B, C | thieu-can-tren, binh-quan-ty-le, nham-roi-voi-roas |
| mkt-t2-pheu-dang-dai | 4 | M7 | W | medium | D1 | mkt | Phễu bốn tầng của từng thương hiệu quý 1/2025 | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Tính, theo thương hiệu, tổng số lượng ở bốn tầng của phễu marketing và tỷ lệ đi tiếp của mỗi tầng so với tầng ngay trước (tầng sau chia tầng trước). | C | thu-tu-tang, mau-so-tang-truoc |
| mkt-t3-nhom-khach-hai-vai | 4 | M7 | W | medium | A3 | cus | Mỗi nhóm khách hàng có mặt trong bao nhiêu chiến dịch? | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Ở mỗi nhóm khách của `audiences`, đếm số chiến dịch có nhóm này là đối tượng mục tiêu, số chiến dịch có nhóm này là phân khúc khách hàng, và số … | AU, C | dem-doi-hai-vai, thieu-can-tren |
| mkt-t4-luat-phat-hien-so-nhat-ky | 4 | M7 | W | hard | E2 | ops | Quy tắc kiểm tra bắt được bao nhiêu nhiễu đã ghi? | Xét mọi dòng của dữ liệu thô và mọi dòng của nhật ký nhiễu. · Đánh dấu các dòng của dữ liệu thô theo sáu quy tắc kiểm tra, mỗi quy tắc mang tên một loại nhiễu: `'NULL'` (trống ít nhất một trong sáu cột số … | N, R | khoa-kep, ngay-ngoai-ky, pheu-bat-ca-so-am |
| mkt-t5-dang-chay-binh-quan-theo-tuan | 4 | M7 | W | hard | B4 | ops | Bình quân mỗi ngày có bao nhiêu chiến dịch đang chạy? | Xét mọi ngày trong lịch từ ngày 1/4/2025 tới hết ngày 30/6/2025, kể cả ngày không có chiến dịch nào đang chạy. · Đếm cho mỗi ngày số chiến dịch đang chạy (cả ba thương hiệu) như định nghĩa ở tab Nghiệp vụ, rồi gom các … | K, C | ngay-trong, lech-bien-ngay-cuoi, thieu-can-tren, tuan-chua-du |
| mkt-t6-phan-nhom-roi-ctr | 4 | M7 | W | hard | C4 | fin | Chiến dịch Purplle chia bốn nhóm theo ROI và CTR | Xét mọi chiến dịch của Purplle trong kỳ dữ liệu. · Lấy mức chung của Purplle làm ngưỡng: ROI chung và CTR chung tính theo tỷ lệ của tổng trên mọi chiến dịch của Purplle. | C | nguong-binh-quan-gian-don, pham-vi-nguong |
| mkt-t7-union-mat-doanh-thu | 4 | M7 | D | medium | A3 | sal | Doanh thu gộp quý 4/2024 và quý 1/2025 bị thiếu | Sửa truy vấn dưới đây để mỗi thương hiệu có đúng số chiến dịch và tổng doanh thu của các chiến dịch bắt đầu trong quý 4/2024 và quý 1/2025. · Giữ nguyên các cột `brand_id`, `so_chien_dich`, `doanh_thu` và thứ tự sắp. | C | union-bo-trung |
| mkt-t8-ty-le-roi-pheu-sai-mau | 4 | M7 | D | medium | D1 | mkt | Tỷ lệ rơi ở tầng cuối của phễu gần 100% | Sửa truy vấn khởi đầu để tính đúng tỷ lệ rơi giữa hai tầng kề nhau của phễu marketing (khái niệm ở tab Nghiệp vụ) ở mỗi loại chiến dịch bắt đầu trong tháng 5/2025. · Tính mỗi tỷ lệ theo tỷ lệ của tổng trong từng loại. | C | mau-so-tang-dau, binh-quan-ty-le |
| mkt-t9-bo-trung-khong-het | 4 | M7 | D | hard | E1 | ops | Bỏ dòng trùng xong số dòng dữ liệu thô vẫn không đổi | Sửa truy vấn dưới đây để bỏ đúng các dòng trùng hoàn toàn của dữ liệu thô (mỗi nhóm dòng trùng giữ lại một dòng), rồi đếm số dòng và cộng doanh thu theo thương hiệu. · Cộng doanh thu như ghi trong file, bỏ qua ô trống. | R | cot-ky-thuat, cat-cung-vi-tri |
| mkt-f1-top-3-doanh-thu-moi-thuong-hieu | 4 | M8 | W | medium | C1 | sal | Ba chiến dịch doanh thu cao nhất của mỗi thương hiệu | Xét mọi chiến dịch trong kỳ dữ liệu. · Xếp hạng chiến dịch trong từng thương hiệu theo doanh thu giảm dần; hai chiến dịch bằng doanh thu thì `campaign_id` nhỏ hơn (so theo chuỗi) đứng trước. Mỗi thương hiệu lấy đúng 3 … | C | trung-hang, quy-tac-hoa, thieu-partition |
| mkt-f2-mom-purplle | 4 | M8 | W | medium | B2 | sal | Doanh thu Purplle tăng giảm bao nhiêu so với tháng trước? | Xét các chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ ngày 1/7/2024 tới hết ngày 31/5/2025 (các tháng đủ). · Tính doanh thu theo tháng của ngày bắt đầu chiến dịch, và tăng trưởng so với tháng trước như định nghĩa … | C | thang-chua-du, mau-so-thang-truoc |
| mkt-f3-truot-7-ngay-tira | 4 | M8 | W | hard | B3 | mkt | Số chiến dịch Tira Beauty trượt 7 ngày tháng 3/2025 | Xét các ngày từ 1/3/2025 tới hết 31/3/2025 và các chiến dịch của Tira Beauty. · Tính cho mỗi ngày số chiến dịch bắt đầu trong ngày và số chiến dịch trượt 7 ngày: tổng số chiến dịch bắt đầu trong ngày đó và sáu ngày … | K, C | loc-truoc-khi-truot, khung-cua-so |
| mkt-f4-pareto-tira | 4 | M8 | W | hard | C2 | fin | Bao nhiêu chiến dịch tạo 80% doanh thu Tira Beauty? | Xét mọi chiến dịch của Tira Beauty trong kỳ dữ liệu. · Xếp chiến dịch theo doanh thu giảm dần; bằng nhau thì `campaign_id` nhỏ hơn (so theo chuỗi) đứng trước. Cộng dồn doanh thu theo thứ tự đó. | C | dem-thieu-mot, chieu-sap-xep |
| mkt-f5-chuoi-ngay-lien-tiep | 4 | M8 | W | hard | D3 | mkt | Đợt mở chiến dịch liền mạch dài nhất của Nykaa | Xét các chiến dịch của Nykaa, loại Influencer (marketing người ảnh hưởng), ngôn ngữ Bengali, đối tượng mục tiêu Youth (giới trẻ) trong kỳ dữ liệu. · Tìm chuỗi ngày liên tiếp dài nhất mà ngày nào cũng có ít nhất một … | C | ngay-trung, quy-tac-hoa |
| mkt-f6-nhom-gia-tri-don-theo-phan-khuc | 4 | M8 | W | medium | C4 | cus | Nhóm chiến dịch giá trị đơn cao nhất của từng phân khúc | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Chia chiến dịch của từng phân khúc khách hàng thành bốn nhóm có số chiến dịch gần bằng nhau theo giá trị đơn bình quân giảm dần; bằng nhau thì … | C | thieu-partition, ntile-nhom-le |
| mkt-f7-chi-phi-luy-ke-nhay-bac | 4 | M8 | D | medium | B3 | fin | Chi phí luỹ kế của Nykaa lặp nhiều dòng mỗi ngày | Cần chi phí chiến dịch cộng dồn từ ngày 1/4/2025 tới hết 30/6/2025, mỗi ngày có chiến dịch Nykaa bắt đầu là một dòng. Sửa truy vấn khởi đầu để ra bảng này. · Lấy giá trị của mỗi ngày bằng tổng chi phí của mọi chiến … | C | luy-ke-tung-dong, thieu-can-tren |
| mkt-f8-lag-khong-chia-thuong-hieu | 4 | M8 | D | hard | B2 | sal | Tăng trưởng tháng đầu của Purplle lấy số Nykaa | Truy vấn khởi đầu có hai lỗi chồng nhau. Sửa cả hai để ra doanh thu theo tháng bắt đầu và tăng trưởng so với tháng trước của từng thương hiệu, chỉ gồm các tháng đủ trong kỳ dữ liệu. · Để trống cột tăng trưởng ở tháng … | C | thieu-partition, thang-chua-du |
| mkt-f9-tuong-tac-cao-nhat-moi-loai | 4 | M8 | D | medium | C1 | mkt | Chiến dịch điểm tương tác cao nhất mỗi loại chỉ ra một dòng | Sửa truy vấn dưới đây để mỗi loại chiến dịch chỉ còn đúng một chiến dịch Tira Beauty bắt đầu trong quý 1/2025 có điểm tương tác cao nhất; bằng điểm thì `campaign_id` nhỏ hơn (so theo chuỗi) được chọn. · Giữ nguyên các … | C | thieu-partition, gom-lay-ma-roi |
| mkt-c7-doanh-thu-nykaa-co-giam | 4 | case | C | medium | – | sal | Doanh thu Nykaa có giảm trong nửa đầu 2025? | b1 Doanh thu Nykaa theo tháng; b2 Tăng trưởng so với tháng trước; b3 Số ngày, số chiến dịch mỗi ngày và doanh thu mỗi chiến dịch; b4 Kết luận | C | b1: thieu_can_tren; b2: chia_cho_thang_nay; b3: so_ngay_theo_lich |
| mkt-c8-doi-tuong-dang-tang-ngan-sach | 4 | case | C | hard | – | cus | Nhóm đối tượng nào đáng tăng ngân sách? | b1 ROI của từng nhóm đối tượng; b2 CPA theo đối tượng và loại chiến dịch; b3 Thứ hạng ROI của đối tượng trong từng thương hiệu; b4 Độ ổn định theo tháng; b5 Kết luận | C, AU | b1: binh_quan_cot_roi, noi_theo_phan_khuc; b2: binh_quan_acquisition_cost; b3: xep_hang_chung_ba_thuong_hieu; b4: tinh_ca_thang_chua_du |

## Gói 5 · M9 Data Quality, M10 Query Performance

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-k1-ho-so-null | 5 | M9 | W | medium | E1 | ops | Mỗi cột số của dữ liệu thô thiếu bao nhiêu ô? | Xét mọi dòng của bản thô `campaigns_raw`, kể cả dòng trùng. · Ở mỗi thương hiệu, đếm tổng số dòng và số ô trống (NULL) của sáu cột số `impressions`, `clicks`, `leads`, `conversions`, `revenue`, `acquisition_cost`. | R, B | count-cot-nguoc-nghia |
| mkt-k2-dong-trung-hoan-toan | 5 | M9 | W | medium | E1 | sal | Dữ liệu thô thừa bao nhiêu dòng chép lặp? | Xét mọi dòng của bản thô `campaigns_raw`. Hai dòng là trùng hoàn toàn khi giống nhau ở mọi cột nghiệp vụ (xem khái niệm dòng trùng hoàn toàn). · Tính số dòng thừa của mỗi thương hiệu (mỗi nhóm trùng giữ lại một dòng) … | R | gom-ca-cot-vi-tri, dem-ca-dong-goc |
| mkt-k3-pheu-vo-ly | 5 | M9 | W | medium | E1 | mkt | Dữ liệu thô có bao nhiêu dòng phễu vô lý? | Xét mọi dòng của bản thô `campaigns_raw`. · Ở mỗi thương hiệu, đếm số dòng có lượt nhấp (click) lớn hơn lượt hiển thị, và trong các dòng này có bao nhiêu dòng có lượt hiển thị âm. | R | count-bieu-thuc-so-sanh, null-trong-so-sanh |
| mkt-k4-phan-loai-ngay-loi | 5 | M9 | W | hard | E1 | ops | Ngày trong dữ liệu thô sai theo những kiểu nào? | Xếp mỗi dòng của `campaigns_raw` vào đúng một loại theo chuỗi ngày gốc `date_raw`. Xét các loại theo đúng thứ tự dưới đây; mỗi dòng thuộc loại đầu tiên khớp với dòng đó. · Loại `'trong'` gồm dòng không có giá trị hoặc … | R | ngay-doc-duoc-nhung-ngoai-ky, thu-tu-nhanh-case |
| mkt-k5-doi-soat-doanh-thu-tho-sach | 5 | M9 | W | hard | E2 | fin | Doanh thu thô sau làm sạch lệch bản sạch bao nhiêu? | Làm sạch doanh thu thô: bỏ dòng thừa của dòng trùng hoàn toàn, bỏ dòng có doanh thu trống hoặc âm. · Tính doanh thu của bản sạch `campaigns`, doanh thu thô sau làm sạch, chênh lệch (bản sạch trừ bản thô) và số chiến … | R, C | quen-bo-trung, giu-so-am |
| mkt-k6-do-chinh-xac-luat | 5 | M9 | W | hard | E2 | ops | Quy tắc kiểm tra lỗi bắt đúng bao nhiêu phần trăm? | Áp năm quy tắc kiểm tra cho từng dòng của `campaigns_raw`: `'NULL'` (trống ở một trong sáu cột `impressions`, `clicks`, `leads`, `conversions`, `revenue`, `acquisition_cost`); `'NEGATIVE'` (lượt hiển thị hoặc doanh thu … | N, R | noi-thieu-khoa, luat-bat-thua |
| mkt-k7-doi-tuong-tho-le-te | 5 | M9 | D | medium | E1 | cus | Đối tượng mục tiêu trên file thô ra nhiều nhóm lẻ tẻ | Đếm số chiến dịch khác nhau của bản thô theo từng nhóm đối tượng mục tiêu (`target_audience`); cả kỳ, ba thương hiệu. · Giữ tên cột `doi_tuong`, `so_chien_dich`; sắp `doi_tuong` theo thứ tự chữ cái. | R | khoang-trang-thua, collation-no-pad |
| mkt-k8-nhieu-null-ra-0 | 5 | M9 | D | medium | E1 | ops | Đếm nhiễu loại ô trống trong nhật ký ra 0 | Đếm số dòng nhật ký nhiễu thuộc loại ô trống, theo thương hiệu và tên cột gốc. · Giữ tên cột `brand_name`, `column_name`, `so_o_trong`; sắp theo `brand_id`, rồi `column_name` theo thứ tự chữ cái. | N, B | chu-null-la-chuoi |
| mkt-k9-doanh-thu-sach-con-trung | 5 | M9 | D | hard | E2 | fin | Doanh thu thô đã làm sạch vẫn cao hơn bản sạch | Đối soát theo thương hiệu, chỉ trên các chiến dịch có doanh thu thô không trống và không âm: doanh thu thô, doanh thu bản sạch của cùng các chiến dịch đó, chênh lệch (thô trừ sạch). · Giữ tên cột `brand_id`, `dt_tho`, … | R, C | dong-trung, khu-trung-gia-tri |
| mkt-p1-ba-chi-so-mot-lan-quet | 5 | M10 | O | medium | A2 | fin | ROI, ROAS, CPA theo thương hiệu chỉ với một lần quét | Giữ nguyên kết quả: mỗi thương hiệu một dòng gồm `brand_id`, `roi`, `roas` (làm tròn 4 chữ số thập phân), `cpa` (đơn vị tiền, làm tròn 2 chữ số), tính theo tỷ lệ của tổng trên cả kỳ. · Sắp `brand_id` tăng dần. | C | truy-van-con-quet-lai |
| mkt-p2-loc-thang-khong-dung-ham | 5 | M10 | O | medium | A3 | mkt | Báo cáo tháng 3/2025 theo loại chiến dịch chỉ đọc phần cần | Giữ nguyên kết quả: các chiến dịch bắt đầu trong tháng 3/2025, theo loại chiến dịch: `type_id`, `so_chien_dich`, `doanh_thu` (đơn vị tiền), `ctr_pct` (CTR của nhóm, phần trăm, 2 chữ số). · Sắp `type_id` tăng dần. | C | boc-ham-cot-ngay |
| mkt-p3-top-3-khong-dem-tuong-quan | 5 | M10 | O | hard | C1 | sal | Ba chiến dịch dẫn đầu doanh thu mỗi thương hiệu với một lần quét | Giữ nguyên kết quả: ba chiến dịch có doanh thu cao nhất của từng thương hiệu trong cả kỳ; doanh thu bằng nhau thì `campaign_id` nhỏ hơn (so theo chuỗi) xếp trên. · Trả về `brand_id`, `campaign_id`, `revenue`; sắp … | C | quet-lai-tung-thuong-hieu, quy-tac-hoa |
| mkt-p4-exists-thay-join-distinct | 5 | M10 | O | medium | C3 | mkt | CTR của chiến dịch có kênh Email hoặc WhatsApp so với mức chung | Giữ nguyên kết quả: theo từng thương hiệu, số chiến dịch có dùng kênh Email hoặc kênh WhatsApp (`channel_id` 1 hoặc 5), CTR của nhóm chiến dịch đó và CTR của mọi chiến dịch của thương hiệu. · Trả về `brand_id`, … | C, CC | noi-nhan-dong, quet-lai-bang |
| mkt-p5-dang-chay-moi-ngay-nhanh | 5 | M10 | O | hard | B4 | ops | Chiến dịch đang chạy mỗi ngày tháng 1/2025 với ít dòng trung gian | Giữ nguyên kết quả: mỗi ngày từ 1/1/2025 tới hết 31/1/2025 một dòng, gồm `ngay`, `so_dang_chay` (số chiến dịch đang chạy vào ngày đó). · Sắp `ngay` tăng dần. | K, C | truy-van-con-tuong-quan, lech-bien-ngay-cuoi |
| mkt-p6-tim-trung-khong-tu-noi | 5 | M10 | O | hard | E1 | ops | Tìm dòng trùng trong dữ liệu thô chỉ với một lần quét | Giữ nguyên kết quả: mọi dòng của `campaigns_raw` có cùng mã chiến dịch với một dòng đứng trước trong file, gồm `brand_id`, `campaign_id`, `row_index_goc` (vị trí dòng đầu tiên của mã đó), `row_index_ban_sao` (vị trí … | R | tu-noi-bang |
| mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | 5 | M10 | W | medium | A1 | cus | Purplle mở những chiến dịch nào cho phụ nữ đi làm ngày 8/3/2025? | Xét chiến dịch của Purplle bắt đầu ngày 8/3/2025, đối tượng mục tiêu Working Women (phụ nữ đi làm). · Trả về `campaign_id`, `type_name`, `revenue` (đơn vị tiền), `roi` (cột có sẵn). | C, T | nham-vai-doi-tuong |
| mkt-p8-bao-cao-thang-cham-va-sai | 5 | M10 | D | medium | B1 | sal | Báo cáo doanh thu theo tháng chạy chậm và sai | Tính theo tháng bắt đầu của chiến dịch trong kỳ 7/2024 tới 6/2025: số chiến dịch và tổng doanh thu. · Giữ tên cột `thang` (chuỗi `'YYYY-MM'`), `so_chien_dich`, `doanh_thu` (đơn vị tiền); sắp `thang` tăng dần. | C | thang-30-ngay, thieu-can-tren |
| mkt-p9-chi-phi-tich-luy-thuong-hieu | 5 | M10 | W | hard | B3 | fin | Chi phí luỹ kế theo tháng của từng thương hiệu | Xét chiến dịch bắt đầu trong kỳ 7/2024 tới 6/2025. · Tính chi phí chiến dịch của từng tháng và chi phí luỹ kế từ tháng 7/2024 tới tháng đó, riêng cho mỗi thương hiệu. | C | thieu-partition, thieu-can-tren |
| mkt-c9-dung-ban-tho-duoc-khong | 5 | case | C | hard | – | ops | Có dùng được bản thô để báo cáo không? | b1 Ô trống theo thương hiệu; b2 Dòng trùng hoàn toàn; b3 Số âm và phễu vô lý; b4 Doanh thu thô sau làm sạch so với bản sạch; b5 Kết luận | R, C | b1: chi_xet_bon_cot_pheu; b2: dem_ca_dong_goc; b3: tinh_dong_am_vao_pheu; b4: quen_bo_dong_trung |
| mkt-c10-don-ngan-sach-loai-kenh | 5 | case | C | hard | – | fin | Nên dồn ngân sách cho loại chiến dịch và kênh nào? | b1 ROI theo loại chiến dịch; b2 ROI theo kênh; b3 ROI theo loại và đối tượng mục tiêu; b4 Độ ổn định qua các tháng đủ; b5 Kết luận | C, T, CC, CH, AU | b1: binh_quan_cot_roi; b2: chi_lay_kenh_dau_chuoi; b3: nham_vai_phan_khuc; b4: tinh_ca_thang_chua_du |

## Thống kê (đếm từ bảng trên)

**Hình thức:** write 56 · debug 28 · optimize 6 · case 10 = 100. **Cấp:** basic 14 · easy 33 · medium 34 · hard 19.

### Hình thức × cấp

| Hình thức | basic | easy | medium | hard | Cộng |
|---|---:|---:|---:|---:|---:|
| write | 7 | 21 | 18 | 10 | 56 |
| debug | 4 | 10 | 11 | 3 | 28 |
| optimize | · | · | 3 | 3 | 6 |
| case | 3 | 2 | 2 | 3 | 10 |
| **Cộng** | 14 | 33 | 34 | 19 | 100 |

### Theo module: cấp và hình thức

| Module | basic | easy | medium | hard | write | debug | optimize | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| M1 Retrieval | 4 | 5 | · | · | 6 | 3 | · | 9 |
| M2 NULL & Expressions | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M3 String & Date | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M4 Aggregation | · | 7 | 2 | · | 6 | 3 | · | 9 |
| M5 Joins | · | 4 | 5 | · | 6 | 3 | · | 9 |
| M6 Subqueries | 1 | 3 | 5 | · | 6 | 3 | · | 9 |
| M7 CTE & Set Operations | · | · | 5 | 4 | 6 | 3 | · | 9 |
| M8 Window Functions | · | · | 5 | 4 | 6 | 3 | · | 9 |
| M9 Data Quality | · | · | 5 | 4 | 6 | 3 | · | 9 |
| M10 Query Performance | · | · | 5 | 4 | 2 | 1 | 6 | 9 |
| Case | 3 | 2 | 2 | 3 | · | · | · | 10 |

### Theo gói

| Gói | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 12 | 6 | · | 2 | 9 | 11 | · | · |
| 2 | 12 | 6 | · | 2 | 4 | 14 | 2 | · |
| 3 | 12 | 6 | · | 2 | 1 | 8 | 11 | · |
| 4 | 12 | 6 | · | 2 | · | · | 11 | 9 |
| 5 | 8 | 4 | 6 | 2 | · | · | 10 | 10 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | operations | finance | customer | marketing | sales | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 Tra cứu lọc | 6 | 1 | 4 | 5 | 2 | · | 18 |
| A2 KPI | 1 | 6 | · | 1 | 2 | · | 10 |
| A3 Phân rã | 1 | 1 | 4 | 4 | 2 | · | 12 |
| A4 Bảng chéo | · | · | 1 | · | · | · | 1 |
| B1 Xu hướng | 1 | · | · | 1 | 4 | · | 6 |
| B2 So kỳ trước | · | · | · | · | 2 | · | 2 |
| B3 Luỹ kế, trượt | · | 2 | · | 1 | · | · | 3 |
| B4 Trạng thái tại thời điểm | 4 | · | · | · | · | · | 4 |
| C1 Top N mỗi nhóm | · | · | · | 1 | 3 | · | 4 |
| C2 Tỷ trọng | · | 1 | · | · | 1 | · | 2 |
| C3 So với chuẩn | · | 1 | · | 3 | · | · | 4 |
| C4 Phân khúc | · | 1 | 1 | · | · | · | 2 |
| D1 Phễu | · | · | · | 2 | · | · | 2 |
| D2 Cohort | · | · | · | · | · | · | 0 |
| D3 Chuỗi liên tiếp | · | · | · | 1 | · | · | 1 |
| E1 Bất thường | 8 | · | 1 | 2 | 1 | · | 12 |
| E2 Đối soát | 3 | 3 | · | 1 | · | · | 7 |
| E3 Cấu trúc cây | · | · | · | · | · | · | 0 |
| **Cộng** | 24 | 16 | 11 | 22 | 17 | 0 | 90 |

Dạng có câu: 16/18; chưa có: D2, E3; chỉ 1 câu: A4, D3.

Mảng trên cả 100 câu (gồm case): operations 27, finance 18, customer 12, marketing 25, sales 18, after_sales 0.

### Kiểm khung phân bổ

Lệch khung (module 9 câu: M1–M9 6 write + 3 debug, M10 ~6 optimize; cấp M1–3 basic/easy, M4–6 easy/medium, M7–10 medium/hard; case gói 1 → 5: basic+basic, basic+easy, easy+medium, medium+hard, hard+hard):

- `mkt-q7-shoppers-ra-rong` (M6) cấp basic, ngoài khung easy / medium.

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: không có.

Ô trùng **giữa các gói** (11 ô; cho phép, ghi để tham khảo): 
- A1 · operations · easy · write: `mkt-r5-chien-dich-30-ngay-cuoi-ky`, `mkt-s6-so-duoi-ma-lon-nhat`
- A1 · marketing · easy · write: `mkt-r6-diem-tuong-tac-tu-30`, `mkt-s4-ba-kenh-youtube-dau`
- A1 · operations · basic · write: `mkt-n2-thieu-hien-thi-co-nhap`, `mkt-s2-ket-thuc-ngay-14-2`
- A2 · finance · easy · write: `mkt-n3-chi-phi-chien-dich-8-3`, `mkt-a1-roi-tong-theo-thuong-hieu`
- E1 · operations · easy · write: `mkt-n5-dong-thieu-chi-so-pheu`, `mkt-s5-ngay-tho-khong-doc-duoc`
- A2 · finance · easy · debug: `mkt-n8-roi-tinh-lai-lech`, `mkt-a7-roi-thuong-hieu-cao-bat-thuong`
- A3 · marketing · easy · write: `mkt-a2-pheu-theo-loai`, `mkt-j1-doanh-thu-loai-thuong-hieu`
- A3 · customer · easy · write: `mkt-a3-doi-tuong-quy-1`, `mkt-j2-doi-tuong-va-phan-khuc`
- A1 · operations · medium · write: `mkt-a5-ngay-tren-500-chien-dich`, `mkt-j5-ngay-khong-co-chien-dich`
- B1 · sales · medium · debug: `mkt-a9-doanh-thu-theo-quy-gop-sai`, `mkt-p8-bao-cao-thang-cham-va-sai`
- E2 · operations · hard · write: `mkt-t4-luat-phat-hien-so-nhat-ky`, `mkt-k6-do-chinh-xac-luat`

### Chênh lệch so với bản đồ bản 1 (phân bổ gốc)

So 100 dòng của bản 1 với 100 câu thật: 0 mã khác, 7 câu đổi hình thức/cấp/dạng/mảng, 68 câu đổi tiêu đề (không liệt kê).

Câu đổi khoá so với bản 1:

- `mkt-a4-bang-cheo-ngon-ngu`: cấp medium → easy
- `mkt-a6-doanh-thu-nykaa-theo-thang`: cấp medium → easy
- `mkt-a8-so-chien-dich-tho-thua`: cấp medium → easy
- `mkt-j8-phan-khuc-lay-nham-doi-tuong`: cấp medium → easy
- `mkt-q5-ty-trong-loai-purplle`: cấp medium → easy
- `mkt-q7-shoppers-ra-rong`: cấp easy → basic
- `mkt-t6-phan-nhom-roi-ctr`: mảng customer → finance

| | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Bản 1 | 56 | 28 | 6 | 10 | 13 | 29 | 39 | 19 |
| Bản 2 (thật) | 56 | 28 | 6 | 10 | 14 | 33 | 34 | 19 |

## Ghi chú giữ từ bản 1

_Giữ nguyên văn để không mất ý của người lập bản 1; số liệu trong các đoạn này có thể đã cũ, đối chiếu bảng và thống kê ở trên._

**Ghi chú dạng (dữ liệu phẳng, đổi dạng có lý do):**
- **E3 cấu trúc cây**: không có dữ liệu phân cấp (không có chiến dịch cha–con, không có cây kênh). 0 câu.
- **D2 cohort, retention**: không có mã khách hàng hay lần mua lặp lại; "cohort theo tháng khởi chạy" chỉ là gom tháng. 0 câu; thay bằng B2/B3/B4 trên lịch.
- **D1 phễu** có thật (4 tầng, bài giảng dùng) nhưng chỉ ở mức tổng theo chiến dịch, không có hành trình từng người.
- **D3 chuỗi**: chỉ làm được trên ngày khởi chạy của một nhóm hẹp (f5); nhóm rộng thì ngày nào cũng có chiến dịch.
- **Joins**: bản gốc phẳng; đã chuẩn hoá thành 10 bảng (danh mục, cầu nối kênh, lịch, bản thô, nhật ký nhiễu) nên M5 có nối 3–4 bảng, nối hai vai, nối khoảng ngày, anti-join.
- **after_sales**: không có dữ liệu trả hàng, đánh giá, chăm sóc sau mua. 0 câu (STYLE-mkt G).

**Rủi ro cho người soạn:**
- Dữ liệu tổng hợp, các nhóm rất giống nhau (ROI bình quân theo loại 2,649–2,715): kết luận case phải nêu "khác biệt nhỏ", không dựng câu chuyện nhân quả.
- `campaigns` sạch không có NULL, không có 0 ở mẫu số: câu NULL dùng `campaigns_raw`.
- Wrong thiếu cận trên chỉ rớt ở h1 khi phạm vi chứa `NY-CMP-56555` (Nykaa, Social Media, Hindi, College Students, WhatsApp/YouTube, 2025-07-01).
- Câu top N doanh thu Nykaa (f1, p3, r3 nếu đổi sang doanh thu) bắt buộc ghi quy tắc hoà; r3 có hoà thật ở public (`roi` −0,99).
- `campaign_id` so theo chuỗi: hoà theo `campaign_id` là theo chuỗi; s6 chủ ý bắt lỗi này.
- Số dòng theo kênh (j3, c5, c10): ghi rõ một chiến dịch được tính ở mỗi kênh nó dùng; không cộng doanh thu các kênh thành tổng.
- Câu trên `R` nối với `C` hoặc `N`: khoá dòng là (`brand_id`, `row_index`); `campaign_id` lặp ở 150 chiến dịch trùng.
- p3: solution và starter optimize phải cùng kết quả trên mọi biến thể, kể cả cặp hoà ở h1 (đề ghi quy tắc hoà, starter đếm `revenue >` cộng điều kiện hoà theo `campaign_id`).
