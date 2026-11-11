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
| mkt-r1-influencer-purplle-thang-1 | 1 | M1 | W | basic | A1 | mkt | Chiến dịch Influencer nào của Purplle vượt 98.000 lượt hiển thị tháng 1/2025? | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu từ ngày 1/1/2025 tới hết ngày 31/1/2025. · Lọc các chiến dịch có lượt hiển thị (`impressions`) lớn … | C | thieu-can-tren, chieu-sap-xep |
| mkt-r2-qua-8-3-tira-ban-tot | 1 | M1 | W | medium | A1 | sal | Chiến dịch quà tặng 8/3 nào của Tira Beauty bán tốt? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`). · Lấy các chiến dịch quà tặng 8/3 bán tốt, theo định nghĩa ở tab Nghiệp vụ. | C | bien-between, nham-doi-tuong-voi-phan-khuc, bo-ngay-cuoi |
| mkt-r3-10-lo-nang-thue-ngoai-purplle-q4 | 1 | M1 | W | medium | A1 | fin | 10 chiến dịch thuê ngoài lỗ nặng nhất của Purplle quý 4/2024 | Xét các chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ ngày 1/10/2024 tới hết ngày 31/12/2024, thuộc nhóm thuê ngoài (xem tab Nghiệp vụ). · Lấy đúng 10 chiến dịch có ROI (lợi tức đầu tư) thấp nhất theo cột `roi`. | C | hoa-hang-o-hang-cuoi, quy-tac-hoa-theo-chuoi, nhom-loai-chi-tra, thieu-can-tren |
| mkt-r4-email-chuyen-doi-cao | 1 | M1 | W | easy | A1 | sal | Chiến dịch loại Email nào đạt từ 6.000 lượt chuyển đổi? | Xét mọi chiến dịch loại Email trong kỳ dữ liệu, của cả ba thương hiệu. · Lọc các chiến dịch có lượt chuyển đổi (`conversions`) từ 6.000 trở lên. | C | nham-loai-voi-kenh |
| mkt-r5-chien-dich-30-ngay-cuoi-ky | 1 | M1 | W | easy | A1 | ops | Purplle mở chiến dịch 30 ngày nào từ 28/5/2025? | Xét các chiến dịch của Purplle (`brand_id = 2`) có thời lượng (`duration_days`) đúng 30 ngày. · Lọc các chiến dịch bắt đầu từ ngày 28/5/2025 tới hết kỳ dữ liệu. | C | bo-ngay-dau, sap-nhieu-cot |
| mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2 | 1 | M1 | W | hard | A1 | mkt | Nội dung nào cho sinh viên của Nykaa quý 2/2025 đáng làm mẫu? | Xét các chiến dịch của Nykaa bắt đầu trong quý 2/2025. · Lấy chiến dịch có nội dung đáng làm mẫu cho sinh viên nói tiếng Hindi, theo tiêu chí ở tab Nghiệp vụ. | C | thieu-can-tren, nham-phan-khuc, giu-thue-ngoai, bien-20-diem, bien-14-ngay |
| mkt-r7-paid-ads-ra-rong | 1 | M1 | D | basic | A1 | mkt | Danh sách chiến dịch Paid Ads của Nykaa ra rỗng | Sửa truy vấn dưới đây để lấy đúng các chiến dịch của Nykaa (`brand_id = 1`), loại Paid Ads (quảng cáo trả phí), bắt đầu ngày 14/2/2025. · Mã loại chiến dịch: 1 Email, 2 Influencer (marketing người ảnh hưởng), 3 Paid … | C | so-ma-voi-ten |
| mkt-r8-thang-2-thieu-ngay-cuoi | 1 | M1 | D | easy | A1 | sal | Chiến dịch tháng 2/2025 của Tira Beauty thiếu ngày cuối tháng | Sửa truy vấn khởi đầu để lấy đủ các chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu trong tháng 2/2025 và có từ 4.000 lượt chuyển đổi trở lên. · Giữ nguyên các cột `campaign_id`, `start_date`, `conversions` và thứ … | C | can-tren-sai-ngay, between-hai-dau |
| mkt-r9-gioi-tre-cuoi-thang-6-thua | 1 | M1 | D | hard | A1 | cus | Chiến dịch cho sinh viên, giới trẻ nửa cuối tháng 6 ra thừa | Sửa truy vấn khởi đầu để lấy đúng các chiến dịch tiếng Hindi (`language_id = 3`) của Nykaa (`brand_id = 1`) bắt đầu từ ngày 16/6/2025 tới hết ngày 30/6/2025, nhắm tới sinh viên (College Students, mã 1) hoặc giới trẻ … | C | thu-tu-and-or, phu-dinh-hai-dieu-kien, thieu-can-tren |
| mkt-n1-ctr-seo-nykaa-ngay | 1 | M2 | W | basic | A2 | mkt | CTR của từng chiến dịch SEO Nykaa ngày 1/1/2025 | Xét các chiến dịch của Nykaa (`brand_id = 1`), loại SEO (`type_id = 4`), bắt đầu ngày 1/1/2025. · Tính CTR (tỷ lệ nhấp) của từng chiến dịch theo công thức trong khái niệm CTR. | C | quen-nhan-100, lam-tron-som |
| mkt-n2-thieu-hien-thi-co-nhap | 1 | M2 | W | basic | A1 | ops | Dòng dữ liệu thô nào có lượt nhấp mà thiếu lượt hiển thị? | Xét mọi dòng của dữ liệu thô `campaigns_raw`. · Lọc các dòng có lượt hiển thị (`impressions`) trống và lượt nhấp (`clicks`) không trống. | R | so-bang-null |
| mkt-n3-chi-phi-chien-dich-8-3 | 1 | M2 | W | easy | A2 | fin | Chi phí từng chiến dịch Influencer của Tira Beauty ngày 8/3 | Xét các chiến dịch của Tira Beauty (`brand_id = 3`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu ngày 8/3/2025. · Tính chi phí của từng chiến dịch bằng công thức chi phí chiến dịch. | C | nham-cpa-voi-tong-chi-phi |
| mkt-n4-nhom-lai-lo-nykaa-quy-2 | 1 | M2 | W | hard | A3 | fin | Chiến dịch Nykaa quý 2/2025 chia theo nhóm lãi lỗ ra sao? | Xét các chiến dịch của Nykaa bắt đầu trong quý 2/2025. · Xếp mỗi chiến dịch vào đúng một nhóm `'xem_lai_hop_dong'`, `'lo'`, `'hoa_von'` hoặc `'co_lai'`, theo quy tắc ở tab Nghiệp vụ. | C | thu-tu-case, bien-0-5, bien-bang-0, nham-cpa-voi-tong-chi-phi, thieu-can-tren |
| mkt-n5-dong-thieu-chi-so-pheu | 1 | M2 | W | easy | E1 | ops | Bao nhiêu dòng dữ liệu thô thiếu ít nhất một chỉ số phễu? | Xét mọi dòng của dữ liệu thô `campaigns_raw`. · Ở mỗi thương hiệu, đếm số dòng có ít nhất một ô trống ở bốn cột `impressions`, `clicks`, `leads`, `conversions`. | R | thieu-cot-trong-or, and-thay-or |
| mkt-n6-ty-le-roi-sau-nhap-11-11 | 1 | M2 | W | medium | A2 | mkt | Tỷ lệ rơi sau lượt nhấp của chiến dịch Influencer Purplle dịp 11/11 | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu ngày 11/11/2024. · Tính tỷ lệ rơi từ tầng quan tâm sang tầng cân nhắc của từng chiến dịch, theo khái niệm ở tab Nghiệp vụ; … | C | quen-1-tru, sai-tang-mau-so, quen-nhan-100 |
| mkt-n7-gia-tri-don-tho-lech | 1 | M2 | D | medium | A2 | sal | Giá trị đơn bình quân trên dữ liệu thô vẫn lệch | Sửa truy vấn khởi đầu để tính đúng giá trị đơn bình quân của toàn bộ `campaigns_raw` theo định nghĩa ở tab Nghiệp vụ. · Giữ nguyên cột `gia_tri_don` (đơn vị tiền, làm tròn 2 chữ số). | R | null-lech-dong-tu-mau, gia-tri-am, binh-quan-gian-don |
| mkt-n8-roi-tinh-lai-lech | 1 | M2 | D | easy | A2 | fin | ROI tính lại lệch xa cột có sẵn | Sửa truy vấn khởi đầu để tính lại đúng ROI (lợi tức đầu tư) của các chiến dịch Purplle (`brand_id = 2`), loại SEO (`type_id = 4`), bắt đầu ngày 1/4/2025. · ROI tính theo công thức trong khái niệm ROI; chi phí tính như … | C | thieu-ngoac, nham-cpa-voi-tong-chi-phi |
| mkt-n9-cpc-cpm-nykaa-thang-6-lech | 1 | M2 | D | hard | A2 | fin | CPC và CPM mạng xã hội Nykaa tháng 6 nhỏ bất thường | Sửa truy vấn khởi đầu để tính đúng CPC (chi phí trên mỗi lượt nhấp) và CPM (chi phí trên 1.000 lượt hiển thị) của các chiến dịch Social Media (marketing mạng xã hội, `type_id = 5`) tiếng Hindi … | C | nham-cpa-voi-tong-chi-phi, lam-tron-som, thieu-can-tren |
| mkt-c1-ctr-theo-loai-thang-5 | 1 | case | C | basic | – | mkt | Loại chiến dịch nào có CTR cao nhất tháng 5/2025? | b1 CTR của từng loại chiến dịch; b2 Kết luận | C | b1: binh_quan_ctr_tung_chien_dich, thieu_can_tren |
| mkt-c2-file-tho-thieu-nhieu-nhat | 1 | case | C | basic | – | ops | Dữ liệu thô của thương hiệu nào thiếu nhiều nhất? | b1 Số dòng thiếu của từng thương hiệu; b2 Kết luận | R | b1: chi_xet_cot_pheu, dem_dong_co_gia_tri |

## Gói 2 · M3 String & Date, M4 Aggregation

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-s1-social-nykaa-chay-sang-thang-sau | 2 | M3 | W | medium | B1 | mkt | Bao nhiêu chiến dịch mạng xã hội Nykaa chạy sang tháng sau? | Xét các chiến dịch của Nykaa (`brand_id = 1`), loại Social Media (marketing mạng xã hội, `type_id = 5`), bắt đầu từ ngày 1/7/2024 tới hết ngày 31/5/2025 (11 tháng đủ). · Theo tháng của ngày bắt đầu, đ … | C | lech-mot-ngay-ngay-cuoi, so-thang-qua-nam, giu-thang-chua-du |
| mkt-s2-ket-thuc-ngay-14-2 | 2 | M3 | W | basic | A1 | ops | Chiến dịch nào của Tira Beauty kết thúc ngày 14/2/2025? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), đối tượng mục tiêu Youth (giới trẻ, `target_audience_id = 5`). · Tính ngày cuối của chiến dịch bằng ngày … | C | lech-mot-ngay |
| mkt-s3-tong-ket-cho-qua-cuoi-tuan | 2 | M3 | W | hard | A3 | ops | Bao nhiêu chiến dịch phải chờ qua cuối tuần mới được tổng kết? | Xét mọi chiến dịch của ba thương hiệu bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Theo loại chiến dịch, tính số chiến dịch, số chiến dịch phải chờ họp tổng kết, tỷ lệ phải chờ và tổng số ngày c … | C | xet-thu-ngay-cuoi, dayofweek-1-la-chu-nhat, dem-ngay-cho-nguoc, thieu-can-tren |
| mkt-s4-ba-kenh-youtube-dau | 2 | M3 | W | easy | A1 | mkt | Bao nhiêu chiến dịch ba kênh ghi YouTube đầu tiên? | Xét cột `channel_used` của dữ liệu thô `campaigns_raw`: tên kênh cách nhau bởi dấu phẩy và một dấu cách, ví dụ `'YouTube, Instagram, Email'`. · Chọn các dòng có đúng ba kênh và kênh ghi đầu tiên là YouTube. | R | like-moi-vi-tri, dong-trung |
| mkt-s5-ngay-tho-khong-doc-duoc | 2 | M3 | W | easy | E1 | ops | Mỗi file thô có mấy dòng mang ngày bắt đầu không hợp lệ? | Xét mọi dòng của dữ liệu thô `campaigns_raw`; ngày bắt đầu nằm ở cột chuỗi `date_raw`, dạng ngày-tháng-năm như `'15-03-2025'`. · Một dòng có ngày không hợp lệ khi `date_raw` trống, không đọc được theo dạng trên (kể cả … | R | ngay-doc-duoc-ngoai-ky, so-sanh-voi-null |
| mkt-s6-so-duoi-ma-lon-nhat | 2 | M3 | W | easy | A1 | ops | Chiến dịch mở ngày 24/6/2025 mang mã số bao nhiêu? | Mã chiến dịch có dạng tiền tố thương hiệu, chữ `CMP` và một số, nối bằng dấu gạch ngang, ví dụ `'NY-CMP-1534'`. · Xét các chiến dịch bắt đầu ngày 24/6/2025. Tách phần số sau dấu gạch ngang cuối cùng và đổi sang kiểu số. | C | so-sanh-chuoi-so |
| mkt-s7-dem-loai-ra-20-nhom | 2 | M3 | D | basic | E1 | mkt | Đếm dữ liệu thô theo loại chiến dịch ra 20 nhóm | Sửa truy vấn dưới đây để đếm số dòng của `campaigns_raw` theo loại chiến dịch, mỗi loại đúng một nhóm. · Tên loại trong cột `loai_chien_dich` không còn khoảng trắng thừa ở đầu và cuối. | R | khoang-trang-thua |
| mkt-s8-tuan-dau-nam-bi-tach-doi | 2 | M3 | D | medium | B1 | mkt | Số chiến dịch theo tuần bị tách đôi ở tuần đầu năm | Truy vấn dưới đây cần đếm số chiến dịch của ba thương hiệu bắt đầu trong từng tuần, tuần tính từ thứ Hai tới hết Chủ nhật, cho 9 tuần từ tuần bắt đầu ngày 2/12/2024 tới tuần bắt đầu ngày 27/1/2025. · … | C | tuan-tach-o-ranh-gioi-nam, dayofweek-1-la-chu-nhat |
| mkt-s9-dang-chay-dau-thang-lech | 2 | M3 | D | hard | B4 | ops | Số chiến dịch đang chạy ngày đầu tháng lệch lịch chạy | Truy vấn dưới đây cần đếm số chiến dịch của ba thương hiệu đang chạy (khái niệm ở tab Nghiệp vụ) vào ngày 1 của từng tháng, từ ngày 1/8/2024 tới ngày 1/6/2025. · Truy vấn có ba lỗi chồng nhau. Sửa cho … | K, C | bo-ngay-bat-dau, lech-mot-ngay-ngay-cuoi, thieu-can-tren |
| mkt-a1-chi-phi-cho-chien-dich-lo | 2 | M4 | W | hard | A2 | fin | Mỗi thương hiệu chi bao nhiêu cho chiến dịch lỗ? | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Theo từng thương hiệu, tính số chiến dịch, số chiến dịch lỗ, tỷ trọng chi phí của các chiến dịch lỗ trong tổng chi phí chiến dịch … | C | lo-theo-cot-roi-lam-tron, nham-cpa-voi-tong-chi-phi, ty-trong-theo-so-dem, avg-cua-ty-le, thieu-can-tren |
| mkt-a2-pheu-theo-loai | 2 | M4 | W | easy | A3 | mkt | Ba tỷ lệ của phễu theo loại chiến dịch, nửa đầu 2025 | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/1/2025 tới hết ngày 30/6/2025. · Tính số chiến dịch, CTR (tỷ lệ nhấp), tỷ lệ khách hàng tiềm năng và tỷ lệ chuyển đổi của từng loại chiến dịch (`type_id`). Cả ba … | C | avg-cua-ty-le, sai-mau-so-chuyen-doi, thieu-can-tren |
| mkt-a3-doi-tuong-quy-1 | 2 | M4 | W | basic | A3 | cus | Nhóm đối tượng nào dẫn đầu doanh thu quý 1/2025? | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Tính số chiến dịch và tổng doanh thu của từng nhóm đối tượng mục tiêu (`target_audience_id`). | C | thieu-can-tren |
| mkt-a4-bang-cheo-ngon-ngu | 2 | M4 | W | easy | A4 | cus | Lượt chuyển đổi theo ngôn ngữ và thương hiệu | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Mỗi dòng là một ngôn ngữ (`language_id`); các cột `nykaa`, `purplle`, `tira_beauty` là tổng lượt chuyển đổi của thương hiệu tương ứng; cột `tong` là … | C | count-thay-sum, thieu-can-tren |
| mkt-a5-ngay-tren-350-co-lai | 2 | M4 | W | medium | A1 | ops | Ngày nào tháng 3/2025 khởi chạy hơn 350 chiến dịch có lãi? | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/3/2025 tới hết ngày 31/3/2025. Chiến dịch có lãi là chiến dịch có `roi` lớn hơn 0. · Đếm tổng số chiến dịch (gồm cả hoà vốn và lỗ) và số chiến dịch có lãi của … | C | loc-dong-o-where, having-sai-dieu-kien, thieu-can-tren |
| mkt-a6-doanh-thu-nykaa-theo-thang | 2 | M4 | W | basic | B1 | sal | Lượt chuyển đổi và doanh thu của Nykaa theo tháng | Xét các chiến dịch của Nykaa (`brand_id = 1`) bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Theo tháng của ngày bắt đầu, đếm số chiến dịch và cộng lượt chuyển đổi (`conversions`), doanh thu (`rev … | C | thieu-can-tren |
| mkt-a7-roi-thang-nykaa-lech-tai-chinh | 2 | M4 | D | hard | B1 | fin | Chi phí và ROI theo tháng của Nykaa lệch số tài chính | Truy vấn dưới đây cần tính, theo tháng của ngày bắt đầu, số chiến dịch, tổng chi phí chiến dịch và ROI (lợi tức đầu tư) theo tỷ lệ của tổng của các chiến dịch Nykaa (`brand_id = 1`), loại Social Media … | C | nham-cpa-voi-tong-chi-phi, avg-cua-ty-le, nham-roi-voi-roas, thieu-can-tren |
| mkt-a8-so-chien-dich-tho-thua | 2 | M4 | D | easy | A2 | ops | Số chiến dịch Tira Beauty trong dữ liệu thô nhiều hơn báo cáo | Kết quả cần có: số dòng và số chiến dịch của Tira Beauty (`brand_id = 3`) trong `campaigns_raw`, mỗi mã chiến dịch chỉ tính một lần. Sửa truy vấn khởi đầu để ra đúng hai số này. · Giữ nguyên các cột `so_dong`, … | R | count-dem-dong-trung |
| mkt-a9-doanh-thu-theo-quy-gop-sai | 2 | M4 | D | medium | B1 | sal | Doanh thu theo quý không ghi năm | Sửa truy vấn dưới đây để tính số chiến dịch và tổng doanh thu theo năm và quý của ngày bắt đầu. · Chỉ xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. | C | quy-thieu-nam, thieu-can-tren |
| mkt-c3-thang-purplle-mo-nhieu-nhat | 2 | case | C | basic | – | mkt | Tháng nào Purplle mở chiến dịch dày nhất? | b1 Số chiến dịch và bình quân mỗi ngày theo tháng; b2 Kết luận | C | b1: giu_thang_chua_du, chia_31_ngay |
| mkt-c4-loai-roi-duoi-muc-chung | 2 | case | C | easy | – | fin | Loại chiến dịch nào có ROI thấp hơn mức chung? | b1 ROI của từng loại chiến dịch; b2 ROI chung của cả ba thương hiệu; b3 Kết luận | C | b1: avg_roi, thieu_can_tren; b2: doanh_thu_chia_chi_phi, thieu_can_tren |

## Gói 3 · M5 Joins, M6 Subqueries

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-j1-tira-doanh-thu-cao-kem-loai | 3 | M5 | W | basic | A1 | sal | Chiến dịch nào của Tira Beauty ngày 19/3/2025 có doanh thu từ 2.000.000? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu ngày 19/3/2025 có doanh thu (`revenue`) từ 2.000.000 trở lên. · Nối `campaigns` với `campaign_types` theo `type_id` để lấy tên loại chiến dị … | C, T | noi-sai-khoa |
| mkt-j2-doi-tuong-va-phan-khuc | 3 | M5 | W | easy | A3 | cus | Đối tượng mục tiêu và phân khúc khách hàng khớp nhau đến đâu? | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 31/12/2024. · Đếm số chiến dịch theo từng cặp đối tượng mục tiêu và phân khúc khách hàng (ghi bằng tên nhóm). | C, AU | noi-mot-lan-cho-hai-vai |
| mkt-j3-influencer-nykaa-tren-youtube | 3 | M5 | W | basic | A1 | mkt | Chiến dịch Influencer nào của Nykaa ngày 15/5/2025 có chạy trên YouTube? | Xét các chiến dịch của Nykaa (`brand_id = 1`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu ngày 15/5/2025. · Nối `campaigns` với bảng cầu nối `campaign_channels` theo `campaign … | C, CC | chi-lay-kenh-dau |
| mkt-j4-dang-chay-tuan-dau-thang-2 | 3 | M5 | W | medium | B4 | ops | Mỗi ngày tuần 3–9/2/2025 có bao nhiêu chiến dịch đang chạy? | Đếm số chiến dịch đang chạy của từng ngày trong lịch ngày, từ 3/2/2025 tới hết 9/2/2025. · Chiến dịch đang chạy vào ngày d khi d nằm trong khoảng từ ngày bắt đầu tới ngày cuối, tính cả hai đầu; ngày cuối = `start_date` … | K, C | lech-bien-ngay-cuoi, noi-bang |
| mkt-j5-ngay-khong-co-chien-dich | 3 | M5 | W | medium | A1 | ops | Ngày nào tháng 5/2025 Tira Beauty không mở Paid Ads cho Premium Shoppers? | Xét mọi ngày từ 1/5/2025 tới hết 31/5/2025 trong lịch ngày `calendar`. · Liệt kê các ngày không có chiến dịch nào của Tira Beauty (`brand_id = 3`), loại Paid Ads (`type_id = 3`), ngôn ngữ Hindi (`language_id = 3`), đối … | K, C | noi-trong, dieu-kien-o-where |
| mkt-j6-email-lech-kenh-nua-dau-2025 | 3 | M5 | W | hard | E2 | mkt | Bao nhiêu chiến dịch loại Email nửa đầu 2025 không chạy kênh Email? | Xét các chiến dịch loại Email bắt đầu từ 1/1/2025 tới hết 30/6/2025. · Theo từng thương hiệu, tính số chiến dịch loại Email, số chiến dịch email lệch kênh (định nghĩa ở tab Nghiệp vụ), tỷ lệ lệch kênh … | C, B, T, CC | nham-loai-voi-kenh, fan-out, dieu-kien-kenh-o-where, sai-mau-so |
| mkt-j7-doanh-thu-instagram-facebook-gap-doi | 3 | M5 | D | easy | A3 | sal | Doanh thu chiến dịch dùng Instagram hoặc Facebook bị cộng hai lần | Truy vấn khởi đầu đếm số chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu từ 1/1/2025 tới hết 31/3/2025 có dùng kênh Facebook (`channel_id = 2`) hoặc Instagram (`channel_id = 4`). · Truy vấn cũng cộng doanh thu của … | C, CC | fan-out |
| mkt-j8-phan-khuc-lay-nham-doi-tuong | 3 | M5 | D | easy | A3 | cus | Doanh thu theo phân khúc giống hệt doanh thu theo đối tượng | Báo cáo cần số chiến dịch và tổng doanh thu theo phân khúc khách hàng của Purplle (`brand_id = 2`), xét các chiến dịch bắt đầu từ 1/1/2025 tới hết 30/6/2025. · Sửa truy vấn cho đúng yêu cầu; giữ các cột `phan_khuc`, … | C, AU | nham-vai-khoa-ngoai |
| mkt-j9-lich-paid-ads-tira-chua-dung-duoc | 3 | M5 | D | hard | B1 | ops | Lịch khởi chạy Paid Ads tháng 6/2025 của Tira Beauty chưa dùng được | Kết quả cần đúng một dòng cho mỗi ngày từ 1/6/2025 tới hết 30/6/2025 trong lịch ngày, kèm số chiến dịch Paid Ads (`type_id = 3`) của Tira Beauty (`brand_id = 3`) bắt đầu ngày đó; ngày không có chiến d … | K, C | dieu-kien-o-where, count-sao, thieu-can-tren |
| mkt-q1-roi-tren-binh-quan-tira | 3 | M6 | W | easy | C3 | fin | Bao nhiêu chiến dịch Tira Beauty tháng 4/2025 có ROI trên mức chung? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`) bắt đầu từ 1/4/2025 tới hết 30/4/2025. · Mức chung là ROI (lợi tức đầu tư) của cả nhóm chiến dịch này, tính theo tỷ lệ của tổng: (tổng doanh thu - tổng chi phí) / … | C | muc-chung-sai-pham-vi, avg-cua-ty-le |
| mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu | 3 | M6 | W | easy | C1 | sal | Chiến dịch nào doanh thu cao nhất của mỗi thương hiệu ngày 5/3/2025? | Xét các chiến dịch bắt đầu ngày 5/3/2025. · Lấy chiến dịch có doanh thu (`revenue`) cao nhất của từng thương hiệu; nếu nhiều chiến dịch cùng mức cao nhất thì lấy hết. | C | khong-tuong-quan, gom-nhom-lay-ma-sai |
| mkt-q3-social-media-purplle-nhap-tren-binh-quan | 3 | M6 | W | basic | C3 | mkt | Chiến dịch Social Media nào của Purplle có lượt nhấp trên bình quân? | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Social Media (marketing mạng xã hội, `type_id = 5`), bắt đầu ngày 6/5/2025. · Lọc các chiến dịch có lượt nhấp (click, cột `clicks`) lớn hơn bình q … | C | binh-quan-sai-pham-vi |
| mkt-q4-thang-roi-tren-muc-quy-1 | 3 | M6 | W | hard | C3 | fin | Tháng nào quý 1/2025 thương hiệu đạt ROI trên mức cả quý? | Xét các chiến dịch bắt đầu từ 1/1/2025 tới hết 31/3/2025. · Với mỗi thương hiệu, lấy các tháng có ROI (lợi tức đầu tư) của tháng cao hơn ROI của chính thương hiệu đó trong cả quý 1/2025. ROI của tháng … | C | avg-cua-ty-le, khong-tuong-quan, muc-chung-sai-pham-vi, lam-tron-truoc-khi-so |
| mkt-q5-ty-trong-loai-purplle | 3 | M6 | W | easy | C2 | sal | Mỗi loại chiến dịch đóng góp bao nhiêu phần trăm doanh thu Purplle? | Xét mọi chiến dịch của Purplle (`brand_id = 2`) trong kỳ dữ liệu. · Tính tổng doanh thu và tỷ trọng của từng loại chiến dịch, với tỷ trọng = doanh thu của loại × 100 / tổng doanh thu của Purplle. | C, T | sai-mau-so, thieu-loc-ngoai |
| mkt-q6-ngay-purplle-khong-seo | 3 | M6 | W | medium | A1 | mkt | Ngày nào tháng 5/2025 Purplle không mở chiến dịch SEO cho giới trẻ? | Xét mọi ngày từ 1/5/2025 tới hết 31/5/2025 trong lịch ngày. · Lấy các ngày không có chiến dịch nào của Purplle (`brand_id = 2`), loại SEO (`type_id = 4`), ngôn ngữ Tamil (`language_id = 4`), đối tượng mục tiêu Youth … | K, C | khong-tuong-quan, thieu-can-tren, nham-doi-tuong-voi-phan-khuc |
| mkt-q7-shoppers-ra-rong | 3 | M6 | D | basic | A1 | cus | Chiến dịch nhắm nhóm “Shoppers” không ra dòng nào | Mục đích của truy vấn khởi đầu: đếm số chiến dịch của từng thương hiệu bắt đầu từ 1/5/2025 tới hết 31/5/2025 mà đối tượng mục tiêu có tên chứa chữ `Shoppers`. · Sửa truy vấn cho đúng yêu cầu; giữ cột `brand_id`, … | C, AU | mau-like-sai-vi-tri |
| mkt-q8-dong-sach-khong-nhieu-sai | 3 | M6 | D | medium | E2 | ops | Số dòng dữ liệu thô không có trong nhật ký nhiễu bị sai | Truy vấn khởi đầu phải đếm số dòng `campaigns_raw` của từng thương hiệu không bị nhật ký nhiễu nhắc tới, tức không có dòng `noise_log` nào cùng thương hiệu và cùng vị trí dòng. · Sửa truy vấn cho đúng yêu cầu; giữ cột … | R, N | khoa-kep, row-index-lap-giua-thuong-hieu |
| mkt-q9-tuong-tac-tren-binh-quan-hai-loi | 3 | M6 | D | hard | C3 | mkt | Chiến dịch tương tác tốt dịp 8/3 của Nykaa bị đếm sai | Cần đếm số chiến dịch của Nykaa (`brand_id = 1`) theo từng loại, xét các chiến dịch bắt đầu từ 7/3/2025 tới hết 8/3/2025 có `engagement_score` lớn hơn bình quân `engagement_score` của các chiến dịch N … | C | tuong-quan-sai-bi-danh, binh-quan-sai-pham-vi |
| mkt-c5-kenh-hieu-qua-hon | 3 | case | C | easy | – | mkt | Kênh nào gắn với chiến dịch hiệu quả hơn? | b1 Số chiến dịch và CTR theo kênh; b2 ROI tổng theo kênh; b3 Kết luận | C, CC, CH | b1: binh_quan_ctr_tung_chien_dich, thieu_can_tren; b2: binh_quan_cot_roi, chi_phi_la_acquisition_cost |
| mkt-c6-tho-va-sach-lech-o-dau | 3 | case | C | medium | – | ops | Bản thô và bản sạch lệch nhau ở đâu? | b1 Số dòng và số mã của hai bản; b2 Dòng thô có chỉ số khác bản sạch; b3 Đối chiếu với nhật ký nhiễu; b4 Kết luận | R, C, N | b1: dem_ma_khong_distinct; b2: so_khac_bo_qua_null; b3: noi_theo_campaign_id, noi_chi_theo_vi_tri |

## Gói 4 · M7 CTE & Set Operations, M8 Window Functions

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-t1-roas-nua-dau-2025 | 4 | M7 | W | medium | A2 | fin | ROAS của từng thương hiệu nửa đầu 2025 là bao nhiêu? | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 30/6/2025. · Tính tổng doanh thu, tổng chi phí chiến dịch, ROI (lợi tức đầu tư) và ROAS (doanh thu trên chi phí quảng cáo) của từng thương hiệu; ROI và ROAS tính … | B, C | thieu-can-tren, binh-quan-ty-le, nham-roi-voi-roas |
| mkt-t2-pheu-dang-dai | 4 | M7 | W | easy | D1 | mkt | Phễu bốn tầng của từng thương hiệu quý 1/2025 | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Ở mỗi thương hiệu, tính tổng số lượng của bốn tầng: nhận biết là tổng `impressions`, quan tâm là tổng `clicks`, cân nhắc là tổng ` … | C | thu-tu-tang |
| mkt-t3-nhom-khach-hai-vai | 4 | M7 | W | medium | A3 | cus | Mỗi nhóm khách hàng có mặt trong bao nhiêu chiến dịch? | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Ở mỗi nhóm khách của `audiences`, đếm số chiến dịch có nhóm này là đối tượng mục tiêu, số chiến dịch có nhóm này là phân khúc khách hàng, và số … | AU, C | dem-doi-hai-vai, thieu-can-tren |
| mkt-t4-ngung-kenh-anh-huong-doanh-thu | 4 | M7 | W | hard | C2 | mkt | Ngừng một kênh thì bao nhiêu doanh thu quý 2 bị ảnh hưởng? | Xét các chiến dịch bắt đầu từ ngày 1/4/2025 tới hết ngày 30/6/2025. · Ở mỗi thương hiệu và mỗi kênh, tính số chiến dịch có chạy kênh đó, tỷ trọng doanh thu bị ảnh hưởng và tỷ trọng doanh thu mất hẳn khi kênh đó ngừng, theo định nghĩa ở tab Nghiệp vụ… | C, CC, CH | mau-so-nhan-dong, kenh-dau-chuoi-la-kenh-duy-nhat, thieu-can-tren |
| mkt-t5-chi-phi-quy-2-theo-ngay-chay | 4 | M7 | W | hard | E2 | fin | Ghi theo ngày chạy, chi phí quý 2 của Nykaa chênh bao nhiêu? | Xét chi phí chiến dịch của Nykaa (`brand_id = 1`) trong quý 2/2025, từ ngày 1/4/2025 tới hết ngày 30/6/2025. · Ở mỗi loại chiến dịch, tính chi phí của quý theo hai cách ghi ở tab Nghiệp vụ (ghi theo ngày bắt đầu và ghi theo ngày chạy). Chênh lệch bằ … | C, K, T | tinh-hai-cach-tren-mot-lan-noi, bo-chien-dich-bat-dau-truoc-quy, ngay-cuoi-thua-mot-ngay, thieu-can-tren |
| mkt-t6-so-chien-dich-theo-so-kenh | 4 | M7 | W | basic | A3 | mkt | Bao nhiêu chiến dịch chạy trên một, hai hay ba kênh? | Xét mọi dòng của `campaign_channels`; mỗi dòng là một kênh của một chiến dịch. · Số kênh của một chiến dịch là số dòng có cùng `campaign_id`. Đếm số kênh của từng chiến dịch, rồi đếm số chiến dịch the … | CC | nham-thu-tu-kenh-voi-so-kenh |
| mkt-t7-union-mat-doanh-thu | 4 | M7 | D | easy | A3 | sal | Doanh thu gộp quý 4/2024 và quý 1/2025 bị thiếu | Sửa truy vấn dưới đây để mỗi thương hiệu có đúng số chiến dịch và tổng doanh thu của các chiến dịch bắt đầu trong quý 4/2024 và quý 1/2025. · Giữ nguyên các cột `brand_id`, `so_chien_dich`, `doanh_thu` và thứ tự sắp. | C | union-bo-trung |
| mkt-t8-ty-le-roi-pheu-sai-mau | 4 | M7 | D | easy | D1 | mkt | Tỷ lệ rơi ở tầng cuối của phễu gần 100% | Truy vấn dưới đây tính tỷ lệ rơi của ba tầng quan tâm, cân nhắc, chuyển đổi ở mỗi loại chiến dịch bắt đầu trong tháng 5/2025, trên tổng của từng loại. · Tỷ lệ rơi của một tầng bằng 1 trừ (tổng tầng đó … | C | mau-so-tang-dau |
| mkt-t9-bo-trung-khong-het | 4 | M7 | D | basic | E1 | ops | Bỏ dòng trùng xong số dòng dữ liệu thô vẫn không đổi | Truy vấn dưới đây bỏ dòng trùng của `campaigns_raw` trong CTE rồi đếm số dòng, cộng doanh thu theo thương hiệu, nhưng không bỏ được dòng nào. · Hai dòng trùng hoàn toàn khi giống nhau ở mọi cột trừ `r … | R | cot-vi-tri |
| mkt-f1-top-3-doanh-thu-moi-thuong-hieu | 4 | M8 | W | medium | C1 | sal | Ba chiến dịch doanh thu cao nhất của mỗi thương hiệu | Xét mọi chiến dịch trong kỳ dữ liệu. · Xếp hạng chiến dịch trong từng thương hiệu theo doanh thu giảm dần; hai chiến dịch bằng doanh thu thì `campaign_id` nhỏ hơn (so theo chuỗi) đứng trước. Mỗi thương hiệu lấy đúng 3 … | C | trung-hang, quy-tac-hoa, thieu-partition |
| mkt-f2-mom-purplle | 4 | M8 | W | easy | B2 | sal | Doanh thu Purplle tăng giảm bao nhiêu so với tháng trước? | Xét các chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ ngày 1/7/2024 tới hết ngày 31/5/2025. · Tính doanh thu theo tháng của ngày bắt đầu chiến dịch. Mức thay đổi so với tháng trước bằng (doanh th … | C | mau-so-thang-truoc |
| mkt-f3-hang-luot-nhap-trong-ngay | 4 | M8 | W | basic | C1 | mkt | Thứ hạng lượt nhấp trong ngày của chiến dịch Social Media Purplle | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Social Media (marketing mạng xã hội, `type_id = 5`), ngôn ngữ English (`language_id = 2`), bắt đầu ngày 3/3/2025 hoặc ngày 4/3/2025. · Đánh số thứ … | C | thieu-partition |
| mkt-f4-pareto-tira | 4 | M8 | W | hard | C2 | fin | Bao nhiêu chiến dịch tạo 80% doanh thu Tira Beauty? | Xét mọi chiến dịch của Tira Beauty trong kỳ dữ liệu. · Xếp chiến dịch theo doanh thu giảm dần; bằng nhau thì `campaign_id` nhỏ hơn (so theo chuỗi) đứng trước. Cộng dồn doanh thu theo thứ tự đó. | C | dem-thieu-mot, chieu-sap-xep |
| mkt-f5-chuoi-ngay-lien-tiep | 4 | M8 | W | hard | D3 | mkt | Đợt mở chiến dịch liền mạch dài nhất của Nykaa | Xét các chiến dịch của Nykaa, loại Influencer (marketing người ảnh hưởng), ngôn ngữ Bengali, đối tượng mục tiêu Youth (giới trẻ) trong kỳ dữ liệu. · Tìm chuỗi ngày liên tiếp dài nhất mà ngày nào cũng có ít nhất một … | C | ngay-trung, quy-tac-hoa |
| mkt-f6-nhom-gia-tri-don-theo-phan-khuc | 4 | M8 | W | easy | C4 | cus | Nhóm chiến dịch giá trị đơn cao nhất của từng phân khúc | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Giá trị đơn bình quân của một chiến dịch bằng `revenue` chia `conversions`. | C | ntile-nhom-le |
| mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang | 4 | M8 | D | basic | B3 | fin | Chi phí luỹ kế quý 2 của Nykaa ngày nào cũng bằng nhau | Truy vấn dưới đây gom chi phí chiến dịch theo ngày bắt đầu của các chiến dịch Nykaa từ ngày 1/4/2025 tới hết ngày 30/6/2025, rồi tính chi phí luỹ kế, nhưng mọi ngày ra cùng một số. · Sửa để `chi_phi_l … | C | thieu-order-by-trong-over |
| mkt-f8-thang-truoc-lay-so-thang-sau | 4 | M8 | D | easy | B2 | mkt | Tháng đầu kỳ của Tira Beauty lại có số tháng trước | Truy vấn dưới đây đếm số chiến dịch Tira Beauty bắt đầu trong từng tháng từ tháng 7/2024 tới hết tháng 5/2025, rồi lấy số của tháng liền trước, nhưng cột tháng trước đang lấy nhầm tháng. · Sửa để `so_ … | C | nham-lag-lead |
| mkt-f9-tuong-tac-cao-nhat-moi-loai | 4 | M8 | D | medium | C1 | mkt | Chiến dịch điểm tương tác cao nhất mỗi loại chỉ ra một dòng | Sửa truy vấn dưới đây để mỗi loại chiến dịch chỉ còn đúng một chiến dịch Tira Beauty bắt đầu trong quý 1/2025 có điểm tương tác cao nhất; bằng điểm thì `campaign_id` nhỏ hơn (so theo chuỗi) được chọn. · Giữ nguyên các … | C | thieu-partition, gom-lay-ma-roi |
| mkt-c7-doanh-thu-nykaa-co-giam | 4 | case | C | medium | – | sal | Doanh thu Nykaa có giảm trong nửa đầu 2025? | b1 Doanh thu Nykaa theo tháng; b2 Tăng trưởng so với tháng trước; b3 Số ngày, số chiến dịch mỗi ngày và doanh thu mỗi chiến dịch; b4 Kết luận | C | b1: thieu_can_tren; b2: chia_cho_thang_nay; b3: so_ngay_theo_lich |
| mkt-c8-doi-tuong-dang-tang-ngan-sach | 4 | case | C | hard | – | cus | Nhóm đối tượng nào đáng tăng ngân sách? | b1 ROI của từng nhóm đối tượng; b2 CPA theo đối tượng và loại chiến dịch; b3 Thứ hạng ROI của đối tượng trong từng thương hiệu; b4 Độ ổn định theo tháng; b5 Kết luận | C, AU | b1: binh_quan_cot_roi, noi_theo_phan_khuc; b2: binh_quan_acquisition_cost; b3: xep_hang_chung_ba_thuong_hieu; b4: tinh_ca_thang_chua_du |

## Gói 5 · M9 Data Quality, M10 Query Performance

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-k1-ho-so-null | 5 | M9 | W | basic | E1 | ops | Mỗi cột số của dữ liệu thô thiếu bao nhiêu ô? | Xét mọi dòng của bản thô `campaigns_raw`, kể cả dòng trùng. · Ở mỗi thương hiệu (`brand_id`), đếm tổng số dòng và số ô trống (NULL) của từng cột `impressions`, `clicks`, `leads`, `conversions`, … | R | count-cot-nguoc-nghia |
| mkt-k2-dong-trung-hoan-toan | 5 | M9 | W | medium | E1 | sal | Dữ liệu thô thừa bao nhiêu dòng chép lặp? | Xét mọi dòng của bản thô `campaigns_raw`. Hai dòng là trùng hoàn toàn khi giống nhau ở mọi cột nghiệp vụ (xem khái niệm dòng trùng hoàn toàn). · Tính số dòng thừa của mỗi thương hiệu (mỗi nhóm trùng giữ lại một dòng) … | R | gom-ca-cot-vi-tri, dem-ca-dong-goc |
| mkt-k3-pheu-vo-ly | 5 | M9 | W | medium | E1 | mkt | Dữ liệu thô có bao nhiêu dòng phễu vô lý? | Xét mọi dòng của bản thô `campaigns_raw`. · Ở mỗi thương hiệu, đếm số dòng có lượt nhấp (click) lớn hơn lượt hiển thị, và trong các dòng này có bao nhiêu dòng có lượt hiển thị âm. | R | count-bieu-thuc-so-sanh, null-trong-so-sanh |
| mkt-k4-phan-loai-ngay-loi | 5 | M9 | W | hard | E1 | ops | Ngày trong dữ liệu thô sai theo những kiểu nào? | Xếp mỗi dòng của `campaigns_raw` vào đúng một loại theo chuỗi ngày gốc `date_raw`. Xét các loại theo đúng thứ tự dưới đây; mỗi dòng thuộc loại đầu tiên khớp với dòng đó. · Loại `'trong'` gồm dòng không có giá trị hoặc … | R | ngay-doc-duoc-nhung-ngoai-ky, thu-tu-nhanh-case |
| mkt-k5-dong-doanh-thu-lech-ban-sach | 5 | M9 | W | easy | E2 | fin | Bao nhiêu dòng thô ghi doanh thu khác bản sạch? | Ghép mỗi dòng của bản thô `campaigns_raw` với chiến dịch cùng `campaign_id` trong bản sạch `campaigns`. · Một dòng thô là dòng lệch khi `revenue` của dòng đó khác `revenue` của bản sạch. Dòng thô … | R, C | null-trong-so-sanh |
| mkt-k6-do-chinh-xac-quy-tac | 5 | M9 | W | hard | E2 | ops | Quy tắc kiểm tra lỗi bắt đúng bao nhiêu phần trăm? | Áp năm quy tắc kiểm tra cho từng dòng của `campaigns_raw`: `'NULL'` (trống ở một trong sáu cột `impressions`, `clicks`, `leads`, `conversions`, `revenue`, `acquisition_cost`); `'NEGATIVE'` (lượt hiển thị hoặc doanh thu … | N, R | noi-thieu-khoa, luat-bat-thua, ky-theo-lich |
| mkt-k7-doi-tuong-tho-le-te | 5 | M9 | D | easy | E1 | cus | Đối tượng mục tiêu trên file thô ra nhiều nhóm lẻ tẻ | Đếm số chiến dịch khác nhau của bản thô theo từng nhóm đối tượng mục tiêu (`target_audience`); cả kỳ, ba thương hiệu. · Giữ tên cột `doi_tuong`, `so_chien_dich`; sắp `doi_tuong` theo thứ tự chữ cái. | R | khoang-trang-thua, collation-no-pad |
| mkt-k8-nhieu-null-ra-0 | 5 | M9 | D | easy | E1 | ops | Đếm nhiễu loại ô trống trong nhật ký ra 0 | Đếm số dòng nhật ký nhiễu thuộc loại ô trống, theo thương hiệu và tên cột gốc. · Giữ tên cột `brand_name`, `column_name`, `so_o_trong`; sắp theo `brand_id`, rồi `column_name` theo thứ tự chữ cái. | N, B | chu-null-la-chuoi |
| mkt-k9-ma-lap-ra-ca-file | 5 | M9 | D | basic | E1 | ops | Danh sách mã chiến dịch lặp của Purplle ra gần cả file | Truy vấn dưới đây cần liệt kê các mã chiến dịch (`campaign_id`) xuất hiện hơn một lần trong bản thô `campaigns_raw` của Purplle (`brand_id = 2`), kèm số dòng của mỗi mã. · Giữ tên cột … | R | sai-toan-tu-having |
| mkt-p1-ba-chi-so-mot-lan-quet | 5 | M10 | O | basic | A2 | fin | ROI, ROAS, CPA theo thương hiệu chỉ với một lần quét | Giữ nguyên kết quả: mỗi thương hiệu một dòng gồm `brand_id`, `roi`, `roas` (làm tròn 4 chữ số thập phân), `cpa` (đơn vị tiền, làm tròn 2 chữ số), tính theo tỷ lệ của tổng trên cả kỳ. · Sắp `brand_id` tăng dần. | C | truy-van-con-quet-lai |
| mkt-p2-bao-cao-thang-3-theo-loai | 5 | M10 | O | easy | A3 | mkt | Báo cáo tháng 3/2025 theo loại chiến dịch chỉ đọc phần cần | Giữ nguyên kết quả: các chiến dịch bắt đầu trong tháng 3/2025, theo loại chiến dịch: `type_id`, `so_chien_dich`, `doanh_thu` (đơn vị tiền), `ctr_pct` (CTR của nhóm, phần trăm, 2 chữ số). · Sắp … | C | boc-ham-cot-ngay, can-tren-thang |
| mkt-p3-top-3-doanh-thu-moi-thuong-hieu | 5 | M10 | O | hard | C1 | sal | Ba chiến dịch dẫn đầu doanh thu mỗi thương hiệu, quét một lần | Giữ nguyên kết quả: ba chiến dịch có doanh thu cao nhất của từng thương hiệu trong cả kỳ; doanh thu bằng nhau thì `campaign_id` nhỏ hơn (so theo chuỗi) xếp trên. · Trả về `brand_id`, `campaign_id`, `revenue`; sắp … | C | quet-lai-tung-thuong-hieu, quy-tac-hoa |
| mkt-p4-ctr-kenh-email-whatsapp | 5 | M10 | O | medium | C3 | mkt | CTR của chiến dịch có kênh Email hoặc WhatsApp so với mức chung | Giữ nguyên kết quả: theo từng thương hiệu, số chiến dịch có dùng kênh Email hoặc kênh WhatsApp (`channel_id` 1 hoặc 5), CTR của nhóm chiến dịch đó và CTR của mọi chiến dịch của thương hiệu. · Trả về `brand_id`, … | C, CC | noi-nhan-dong, quet-lai-bang |
| mkt-p5-chi-phi-roi-bon-quy-mot-lan-quet | 5 | M10 | O | easy | B1 | fin | Chi phí và ROI bốn quý gộp trong một lần quét | Giữ nguyên kết quả: mỗi quý của kỳ 7/2024 tới 6/2025 một dòng, gồm `quy` (chuỗi dạng `'2024-Q3'`), `so_chien_dich`, `chi_phi` (đơn vị tiền, làm tròn 2 chữ số), `roi` (tỷ lệ của tổng, làm tròn 4 … | C | union-all-lap, thieu-can-tren |
| mkt-p6-thoi-luong-purplle-mot-lan-quet | 5 | M10 | O | basic | A3 | ops | Đếm chiến dịch Purplle theo thời lượng chỉ với một lần quét | Giữ nguyên kết quả: một dòng gồm `so_ngan` (5 tới 10 ngày), `so_vua` (11 tới 20 ngày), `so_dai` (21 tới 30 ngày), là số chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ 1/5/2025 tới hết … | C | truy-van-con-quet-lai |
| mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | 5 | M10 | W | medium | C3 | cus | Chiến dịch 8/3 nào của Purplle cho phụ nữ đi làm vượt ROI chung? | Xét các chiến dịch của Purplle bắt đầu ngày 8/3/2025. · Mức chung là ROI (lợi tức đầu tư) của mọi chiến dịch Purplle bắt đầu ngày đó, thuộc mọi đối tượng, tính theo tỷ lệ của tổng như ở tab Nghiệp vụ. … | C, T | nham-vai-doi-tuong, binh-quan-cot-roi, muc-chung-sai-pham-vi |
| mkt-p8-so-chien-dich-theo-thang-lech | 5 | M10 | D | easy | B1 | mkt | Số chiến dịch theo tháng lệch số lọc trên file | Đếm số chiến dịch theo tháng của ngày bắt đầu, mỗi tháng của kỳ 7/2024 tới 6/2025 một dòng. · Giữ tên cột `thang` (chuỗi `'YYYY-MM'`), `so_chien_dich`; sắp `thang` tăng dần. | C | thang-30-ngay |
| mkt-p9-chi-phi-tich-luy-thuong-hieu | 5 | M10 | W | hard | B3 | fin | Chi phí luỹ kế theo tháng của từng thương hiệu | Xét chiến dịch bắt đầu trong kỳ 7/2024 tới 6/2025. · Tính chi phí chiến dịch của từng tháng và chi phí luỹ kế từ tháng 7/2024 tới tháng đó, riêng cho mỗi thương hiệu. | C | thieu-partition, thieu-can-tren |
| mkt-c9-dung-ban-tho-duoc-khong | 5 | case | C | hard | – | ops | Có dùng được bản thô để báo cáo không? | b1 Ô trống theo thương hiệu; b2 Dòng trùng hoàn toàn; b3 Số âm và phễu vô lý; b4 Doanh thu thô sau làm sạch so với bản sạch; b5 Kết luận | R, C | b1: chi_xet_bon_cot_pheu; b2: dem_ca_dong_goc; b3: tinh_dong_am_vao_pheu; b4: quen_bo_dong_trung |
| mkt-c10-don-ngan-sach-loai-kenh | 5 | case | C | hard | – | fin | Nên dồn ngân sách cho loại chiến dịch và kênh nào? | b1 ROI theo loại chiến dịch; b2 ROI theo kênh; b3 ROI theo loại và đối tượng mục tiêu; b4 Độ ổn định qua các tháng đủ; b5 Kết luận | C, T, CC, CH, AU | b1: binh_quan_cot_roi; b2: chi_lay_kenh_dau_chuoi; b3: nham_vai_phan_khuc; b4: tinh_ca_thang_chua_du |

## Thống kê (sinh lại tự động từ cau-hoi.tex, 100 câu)

### Module × cấp

| Tiền tố | Cơ bản | Dễ | Trung bình | Khó |
|---|---:|---:|---:|---:|
| `a` | 2 | 3 | 2 | 2 |
| `c` | 3 | 2 | 2 | 3 |
| `f` | 2 | 3 | 2 | 2 |
| `j` | 2 | 3 | 2 | 2 |
| `k` | 2 | 3 | 2 | 2 |
| `n` | 2 | 3 | 2 | 2 |
| `p` | 2 | 3 | 2 | 2 |
| `q` | 2 | 3 | 2 | 2 |
| `r` | 2 | 3 | 2 | 2 |
| `s` | 2 | 3 | 2 | 2 |
| `t` | 2 | 3 | 2 | 2 |

### Hình thức × cấp

| Hình thức | Cơ bản | Dễ | Trung bình | Khó | Cộng |
|---|---:|---:|---:|---:|---:|
| Viết | 12 | 17 | 14 | 13 | 56 |
| Sửa lỗi | 6 | 11 | 5 | 6 | 28 |
| Tối ưu | 2 | 2 | 1 | 1 | 6 |
| Case | 3 | 2 | 2 | 3 | 10 |

### Hình thức × mảng

| Hình thức | Khách hàng | Tài chính | Marketing | Vận hành | Bán hàng |
|---|---:|---:|---:|---:|---:|
| Viết | 6 | 11 | 17 | 13 | 9 |
| Sửa lỗi | 4 | 4 | 8 | 7 | 5 |
| Tối ưu | 0 | 2 | 2 | 1 | 1 |
| Case | 1 | 2 | 3 | 3 | 1 |

### Theo gói

| Gói | Cơ bản | Dễ | Trung bình | Khó | Cộng |
|---|---:|---:|---:|---:|---:|
| goi-1 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | 8 | F | 9 | 3 | 6 | F | C | A | 9 | 0 | > | 20 |
| goi-2 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | 8 | F | 9 | 3 | 6 | F | C | A | 9 | 0 | > | 20 |
| goi-3 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | 8 | F | 9 | 3 | 6 | F | C | A | 9 | 0 | > | 20 |
| goi-4 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | 8 | F | 9 | 3 | 6 | F | C | A | 9 | 0 | > | 20 |
| goi-5 | < | g | e | n | e | r | a | t | o | r |   | o | b | j | e | c | t |   | m | a | i | n | . | < | l | o | c | a | l | s | > | . | < | g | e | n | e | x | p | r | > |   | a | t |   | 0 | x | 0 | 0 | 0 | 0 | 0 | 2 | 8 | F | 9 | 3 | 6 | F | C | A | 9 | 0 | > | 20 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | sales | marketing | customer | operations | finance | Cộng |
|---|---:|---:|---:|---:|---:|---:|
| A1 | 4 | 6 | 2 | 6 | 1 | 19 |
| A2 | 1 | 2 | · | 1 | 6 | 10 |
| A3 | 2 | 3 | 4 | 2 | 1 | 12 |
| A4 | · | · | 1 | · | · | 1 |
| B1 | 2 | 3 | · | 1 | 2 | 8 |
| B2 | 1 | 1 | · | · | · | 2 |
| B3 | · | · | · | · | 2 | 2 |
| B4 | · | · | · | 2 | · | 2 |
| C1 | 3 | 2 | · | · | · | 5 |
| C2 | 1 | 1 | · | · | 1 | 3 |
| C3 | · | 3 | 1 | · | 2 | 6 |
| C4 | · | · | 1 | · | · | 1 |
| D1 | · | 2 | · | · | · | 2 |
| D2 | · | · | · | · | · | 0 |
| D3 | · | 1 | · | · | · | 1 |
| E1 | 1 | 2 | 1 | 7 | · | 11 |
| E2 | · | 1 | · | 2 | 2 | 5 |
| E3 | · | · | · | · | · | 0 |
| **Cộng** | 15 | 27 | 10 | 21 | 17 | 90 |

Dạng có câu: 16/18; chưa có: D2, E3; chỉ 1 câu: A4, C4, D3.

Mảng trên cả 100 câu (gồm case): sales 16, marketing 30, customer 11, operations 24, finance 19.

### Ô trùng (dạng × mảng × cấp × hình thức)

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: không có.

Ô trùng **giữa các gói** (7 ô; cho phép, ghi để tham khảo; cập nhật theo kiểm V4 ngày 11/11/2026, không cặp nào trùng chủ đề): 
- A1 · marketing · basic · write: `mkt-r1-influencer-purplle-thang-1`, `mkt-j3-influencer-nykaa-tren-youtube` (khác mục đích, kỹ năng: lọc một bảng / nối bảng cầu nối)
- A1 · operations · basic · write: `mkt-n2-thieu-hien-thi-co-nhap`, `mkt-s2-ket-thuc-ngay-14-2`
- A1 · operations · easy · write: `mkt-r5-chien-dich-30-ngay-cuoi-ky`, `mkt-s6-so-duoi-ma-lon-nhat`
- E1 · operations · easy · write: `mkt-n5-dong-thieu-chi-so-pheu`, `mkt-s5-ngay-tho-khong-doc-duoc`
- A1 · operations · medium · write: `mkt-a5-ngay-tren-350-co-lai`, `mkt-j5-ngay-khong-co-chien-dich` (đếm ngày có trên 350 chiến dịch có lãi / tìm ngày không có chiến dịch)
- A3 · sales · easy · debug: `mkt-j7-doanh-thu-instagram-facebook-gap-doi`, `mkt-t7-union-mat-doanh-thu` (lỗi nhân dòng qua bảng cầu nối / `UNION` bỏ dòng trùng)
- E1 · operations · basic · debug: `mkt-t9-bo-trung-khong-het`, `mkt-k9-ma-lap-ra-ca-file` (cùng mảng dòng trùng nhưng khác câu hỏi, lỗi, kỹ năng: bỏ trùng rồi đếm, cộng / liệt kê mã lặp bằng `HAVING`; k9 đổi người hỏi)

Ô `E2 · operations · hard · write` không còn trùng: `mkt-t4-quy-tac-doi-chieu-nhat-ky` (trùng chủ đề với `mkt-k6-do-chinh-xac-quy-tac`) được viết lại thành `mkt-t4-ngung-kenh-anh-huong-doanh-thu` (C2 · marketing · hard · write). `mkt-p7` đổi dạng A1 → C3 (C3 · customer · medium · write, ô mới).

Quyết định giảng viên 11/11/2026 (`ho-so/goi-4/DA-SUA.md`): `mkt-t5-dang-chay-binh-quan-theo-tuan` (B4 · operations · hard · write) viết lại thành `mkt-t5-chi-phi-quy-2-theo-ngay-chay`, ô mới **E2 · finance · hard · write**: không trùng câu nào trong gói 4 và trong bộ (`mkt-k5-dong-doanh-thu-lech-ban-sach` là E2 · finance · easy). Dạng B4 · operations · hard nay chỉ còn `mkt-s9-dang-chay-dau-thang-lech` (debug). Danh sách 7 ô trùng ở trên không đổi.

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

Đổi ở v3 (10/11, quyết định giảng viên, xem `QUYET-DINH-126.md`): mã a5, c2, c3, p3, t4, k6, p2, p4, p6 đổi theo nội dung; `mkt-k8`, `mkt-t7` cấp medium → easy; `mkt-p1` cấp medium → basic; `mkt-t5` khoảng xét quý 2 → quý 1/2025.

Đổi khi chuẩn hoá theo quy chuẩn (10/11, `BRIEF-CHUAN-HOA.md`, chi tiết `ho-so/CHUAN-HOA.md`): `mkt-k7` cấp medium → easy; 11 tiêu đề rút còn ≤ 13 tiếng (r1, r2, n2, s3, s5, j5, j9, q5, q6, q9, p3).

Đổi theo kiểm V4 (11/11/2026, `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`): `mkt-t4-quy-tac-doi-chieu-nhat-ky` (trùng chủ đề với k6) viết lại thành `mkt-t4-ngung-kenh-anh-huong-doanh-thu`, ô E2 · operations → C2 · marketing, cấp giữ hard; `mkt-p7-chien-dich-ngay-8-3-theo-chi-muc` dạng A1 → C3 (thêm so với ROI chung), cấp giữ medium; tiêu đề f8, p7 đổi. Không câu nào đổi cấp.

Đổi theo quyết định giảng viên (11/11/2026, `ho-so/goi-4/DA-SUA.md` mục "Viết lại mkt-t5 cho đủ Khó"): `mkt-t5-dang-chay-binh-quan-theo-tuan` viết lại thành `mkt-t5-chi-phi-quy-2-theo-ngay-chay` (chi phí quý 2/2025 của Nykaa ghi theo ngày chạy so với ghi theo ngày bắt đầu), ô B4 · operations → E2 · finance, cấp giữ hard; thống kê dạng × mảng, hình thức × mảng, mảng trên 100 câu đã cập nhật.

| | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Bản 1 | 56 | 28 | 6 | 10 | 13 | 29 | 39 | 19 |
| Bản 2 (thật) | 56 | 28 | 6 | 10 | 14 | 33 | 34 | 19 |
| Bản 3 (v3, 10/11) | 56 | 28 | 6 | 10 | 15 | 35 | 31 | 19 |
| Chuẩn hoá (10/11) | 56 | 28 | 6 | 10 | 15 | 36 | 30 | 19 |

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
