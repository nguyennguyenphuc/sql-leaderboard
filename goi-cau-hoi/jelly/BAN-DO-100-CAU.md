# Bản đồ 100 câu · bộ GAME Jelly Trail Academy (`jelly`)

**Bản 2 · sinh lại 10/11/2026 từ file thật** (`goi-*/cau-hoi.tex`, `goi-*/solution.sql`): mã, hình thức, cấp, dạng, mảng, tiêu đề lấy từ khoá của `\begin{cauhoi}`; gói theo thư mục; module theo tiền tố mã (r n s a j q t f k p = M1…M10, c = case). Cột “Đề một câu” là mục đầu của `yeucau` (case: tên các bước); “Bảng” lấy từ `FROM`/`JOIN` của lời giải (bỏ CTE); “Bẫy chính” là khoá `bay` (case: tên bài sai theo bước). Phần mở đầu giữ từ bản 1; thống kê và chênh lệch so với bản 1 ở cuối file.

Bản 1 · 10/11/2026. Phân bổ theo `BRIEF-SOAN-GOI.md` (gói k = module 2k−1, 2k; 9 câu/module + 2 case/gói).
Dữ liệu: MySQL `jelly` / `jelly_hidden_1` (xem `mysql/README-jelly.md`), 60 ngày 2026-07-01 → 2026-08-29. Thuật ngữ, giọng văn,
khái niệm: `style/STYLE-jelly.md`. Mảng (`domain`) theo mục G của STYLE: `customer` người chơi, giữ chân, kích hoạt · `sales` mua trong
ứng dụng (IAP), gói vật phẩm · `marketing` kênh thu hút, chiến dịch, sự kiện LiveOps, thử nghiệm A/B · `operations` màn chơi, phiên chơi,
phiên bản, booster · `finance` doanh thu tổng, ARPDAU, ARPPU, CPI, ROAS · `after_sales` sự cố (crash), hoàn tiền, đối soát sau phát hành.

Ký hiệu bẫy hidden-1 có sẵn: **H-a** (bỏ ~10% người chơi, mọi số đổi) · **H-b** (thêm ngày 2026-09-01 ở `sessions`, `level_attempts`,
`purchases`, `ad_events`, `player_daily`, `daily_kpi`, `campaign_spend` → bắt thiếu cận trên / `MAX(ngày)`) · **H-c** (Licorice Lagoon,
lượt `quit`: màn 32 = 34 ở hạng 3 → bắt `RANK()` khi cần đúng 3 dòng). Bẫy "public" là bẫy làm sai ngay trên public.

Người soạn: mọi con số đã kiểm khả thi trên public; trước khi soạn, chạy lại solution để lấy số thật. Câu nào cần tháng trọn thì dùng
tháng 7/2026 (tháng 8 dừng ở 29/8). Cohort D7 chỉ lấy người cài ≤ 2026-08-22.

## Gói 1 · M1 Retrieval, M2 NULL & Expressions, case c1–c2 (Cơ bản)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-r1-cai-moi-29-8-vn | 1 | M1 | write | basic | A1 | customer | Ai cài game ở Việt Nam ngày 29/8? | Xét người chơi có ngày cài (`install_date`) là 29/8/2026 và thị trường (`country`) là Việt Nam. · Trả về `user_id`, `platform`, `channel`. | users | quen-dieu-kien-loc, sai-gia-tri-loc |
| jelly-r2-giao-dich-season-pass | 1 | M1 | write | basic | A1 | sales | Ai mua Season Pass trong tháng 7? | Xét giao dịch gói Season Pass (`product_type` là `'season_pass'`) trong tháng 7/2026. · Trả về `transaction_id`, `user_id`, `event_time`. | purchases | sai-cot-loc, thieu-can-tren |
| jelly-r3-man-sieu-kho | 1 | M1 | write | basic | A1 | operations | Màn nào được gắn nhãn siêu khó? | Xét các màn có nhãn độ khó (`difficulty_tag`) là siêu khó. · Trả về `level_id`, `world_name`, `moves_limit`. | level_metadata | like-rong, sai-gia-tri-loc |
| jelly-r4-ngay-chi-cao-social | 1 | M1 | write | easy | A1 | marketing | Mười ngày chi nhiều nhất cho Social Ads ở Việt Nam | Xét chi phí của chiến dịch `'JTA-SOCIAL-204'` (kênh Social Ads), thị trường `'VN'`, nền tảng nhắm tới (`target_platform`) `'Android'`, từ ngày 15/8/2026 tới ngày mới nhất có trong dữ liệu. · Trả về `date`, `spend_usd` … | campaign_spend | quen-dieu-kien-loc, thieu-can-tren |
| jelly-r5-luot-dai-man-30 | 1 | M1 | write | easy | A1 | operations | Lượt chơi màn 30 lâu nhất trên Android 2.1.0 | Xét lượt chơi màn 30 (`level_id`) trên nền tảng `'Android'`, với phiên bản ứng dụng lúc chơi (`app_version`) là `'2.1.0'`. · Trả về `attempt_id`, `user_id`, `event_date`, `duration_sec` (giây), `result`. | level_attempts | phien-ban-luc-cai, quen-dieu-kien-loc |
| jelly-r6-su-kien-thang-8 | 1 | M1 | write | basic | B4 | marketing | Sự kiện LiveOps nào chạy từ 26/7 tới 9/8? | Xét các sự kiện LiveOps (sự kiện vận hành trực tiếp trong game) có ít nhất một ngày chạy trong khoảng từ 26/7/2026 tới hết 9/8/2026, dựa vào ngày bắt đầu (`start_date`) và ngày kết thúc (`end_date`). · Trả về … | liveops_events | hoac-thay-va, giao-khoang-ngay |
| jelly-r7-organic-ios-tuan-dau | 1 | M1 | debug | basic | A1 | customer | Danh sách người chơi iOS bị lẫn người chơi Android | Sửa truy vấn dưới đây để chỉ lấy người chơi ở thị trường `'VN'`, nền tảng `'iOS'`, cài từ ngày 1/7/2026 tới hết ngày 7/7/2026, đến từ kênh `'Organic'` hoặc `'Search Ads'`. · Giữ nguyên các cột `user_id`, … | users | thu-tu-and-or |
| jelly-r8-giao-dich-thang-8-thua | 1 | M1 | debug | easy | A1 | sales | Danh sách giao dịch tháng 8 có dòng tháng 9 | Danh sách chỉ được gồm giao dịch của người chơi ở thị trường `'GB'` trong tháng 8/2026; sửa truy vấn dưới đây cho đúng. · Truy vấn vẫn phải đúng khi dữ liệu có thêm ngày sau tháng 8. | purchases | thieu-can-tren, between-gom-dau-mut, lon-hon-thay-lon-hon-bang |
| jelly-r9-phien-dai-15-8 | 1 | M1 | debug | easy | A1 | operations | Năm phiên dài nhất ngày 15/8 chỉ dài vài phút | Truy vấn dưới đây cần lấy 5 phiên chơi có thời lượng (`duration_minutes`) dài nhất trong ngày 15/8/2026 nhưng đang lấy sai; sửa lại. · Hai phiên bằng thời lượng thì `session_id` nhỏ hơn đứng trước. | sessions | chieu-sap-xep, thieu-tieu-chi-phu |
| jelly-n1-iap-khong-gan-man | 1 | M2 | write | basic | A2 | sales | Bao nhiêu giao dịch không gắn với màn chơi? | Xét mọi giao dịch trong bảng `purchases`. · Đếm các giao dịch có `level_id_if_relevant` trống (NULL). | purchases | bang-null, count-cot-null |
| jelly-n2-chua-tiep-xuc-ab | 1 | M2 | write | basic | A1 | marketing | Ai được chia nhánh nhưng chưa tiếp xúc ưu đãi? | Xét thử nghiệm A/B `'extra_moves_offer_timing'`. · Lọc người chơi chưa tiếp xúc ưu đãi (`exposed_at` trống). | ab_assignments | bang-null, dao-dieu-kien |
| jelly-n3-nhom-buoc-du | 1 | M2 | write | easy | A3 | operations | Lượt chơi màn 28 còn dư bao nhiêu lượt đi? | Xét các lượt chơi màn 28 (`level_id`) ngày 1/8/2026. · Gán nhóm theo số lượt đi còn dư (`moves_left`): bằng 0 là `'het_luot_di'`; từ 1 tới 2 là `'du_1_2'`; từ 3 trở lên là `'du_tu_3'`. | level_attempts | thu-tu-case, nham-ket-qua-voi-luot-du |
| jelly-n4-tong-doanh-thu-ngay | 1 | M2 | write | easy | B1 | finance | Tổng doanh thu từng ngày tuần đầu tháng 7 | Xét 7 ngày từ 1/7/2026 tới hết 7/7/2026 trong bảng chỉ số ngày `daily_kpi`. · Tính tổng doanh thu bằng doanh thu IAP (`iap_revenue`) cộng doanh thu quảng cáo (`ad_revenue`); tính tỷ trọng quảng cáo bằng doanh thu quảng … | daily_kpi | thu-tu-phep-tinh, sai-mau-so |
| jelly-n5-gia-quy-doi-vnd | 1 | M2 | write | easy | A1 | sales | Giá các gói vật phẩm quy ra đồng | Lấy mỗi gói vật phẩm một dòng từ bảng giao dịch `purchases`. · Quy đổi giá theo tỷ giá 25.400 đồng một USD, làm tròn tới hàng nghìn. | purchases | thieu-distinct, lam-tron-sai |
| jelly-n6-ngay-choi-khong-doanh-thu | 1 | M2 | write | easy | A2 | finance | Bao nhiêu ngày chơi không phát sinh doanh thu? | Xét các dòng `player_daily` có ngày hoạt động (`activity_date`) trong tháng 7/2026; mỗi dòng là một ngày chơi của một người chơi. · Đếm tổng số ngày chơi và số ngày chơi có tổng doanh thu IAP (`iap_revenue`) và doanh … | player_daily | lam-tron-truoc-khi-so, thieu-can-tren |
| jelly-n7-crash-null | 1 | M2 | debug | basic | A2 | after_sales | Số lượt chơi gặp sự cố ra 0 | Sửa truy vấn dưới đây để đếm đúng số lượt chơi có kết quả gặp sự cố trong tháng 7/2026. · Giữ nguyên cột `so_luot_su_co`. | level_attempts | khoang-trang-thua, nham-nguon-dem |
| jelly-n8-ty-le-sai-chia | 1 | M2 | debug | easy | A2 | finance | ARPDAU tự tính lệch với cột có sẵn | Truy vấn dưới đây tính ARPDAU (doanh thu bình quân trên một người chơi hoạt động trong ngày) của từng ngày từ 15/8/2026 tới hết 21/8/2026 nhưng ra số quá lớn. Sửa lại cho đúng công thức ARPDAU. · Giữ nguyên các cột … | daily_kpi | thu-tu-phep-tinh, lam-tron-som |
| jelly-n9-nhan-nguoi-tra-tien | 1 | M2 | debug | easy | A3 | customer | Nhóm trả tiền gồm mọi người chơi | Xét người chơi hoạt động ngày 15/8/2026. · Sửa truy vấn dưới đây để gán nhãn `'tra_tien'` cho người chơi có doanh thu IAP (mua hàng trong ứng dụng) trong ngày (`iap_revenue`) lớn hơn 0, còn lại gán `'khong_tra_tien'`. | player_daily | bien-lon-hon-bang, nham-doanh-thu-quang-cao |
| jelly-c1-quang-cao-co-thuong | 1 | case | case | basic | – | finance | Quảng cáo có tặng thưởng mang lại bao nhiêu? | b1 Doanh thu theo loại quảng cáo; b2 Kết luận | ad_events | b1: thieu_can_tren, dem_nguoi_xem |
| jelly-c2-gia-goi-ban-chay | 1 | case | case | basic | – | sales | Gói rẻ nhất có bán chạy nhất? | b1 Số giao dịch và doanh thu theo gói; b2 Kết luận | purchases | b1: dem_nguoi_mua, khong_gioi_han_ngay |

## Gói 2 · M3 String & Date, M4 Aggregation, case c3 (Cơ bản), c4 (Dễ)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-s1-gio-cao-diem | 2 | M3 | write | basic | A3 | operations | Người chơi mở game nhiều nhất vào giờ nào? | Xét các phiên chơi bắt đầu từ ngày 1/7/2026 tới hết ngày 31/7/2026. · Đếm số phiên theo giờ bắt đầu phiên (phần giờ của `session_start`, từ 0 tới 23). | sessions | gio-tu-cot-ngay, quen-can-tren |
| jelly-s2-tach-the-gioi | 2 | M3 | write | basic | A1 | operations | Tên thế giới trong ngữ cảnh màn hình | Xét các màn có nhãn độ khó khác `'normal'`. · Ngữ cảnh màn hình `screen_context` gồm ba phần, ngăn cách bằng chuỗi `' > '` (dấu cách, dấu lớn hơn, dấu cách). Lấy phần thứ hai làm `the_gioi`, bỏ dấu cách ở hai đầu. | level_metadata | tach-sai-dau-phan-cach |
| jelly-s3-ngay-trong-tuan | 2 | M3 | write | easy | A3 | customer | Người chơi cài game vào thứ mấy nhiều nhất? | Xét người chơi cài từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Tính cho từng thứ trong tuần của ngày cài: số ngày có người cài, số người cài và số người cài bình quân mỗi ngày (số người cài chia số ngày). | users | dayofweek-bat-dau-chu-nhat, so-ngay-moi-thu-khac-nhau |
| jelly-s4-ngay-tu-cai-den-mua | 2 | M3 | write | easy | A1 | sales | Người chơi mua Starter Pack sau khi cài bao lâu? | Xét các giao dịch có `product_type` = `'starter_pack'`. · Tính `so_ngay` là số ngày từ ngày cài của người chơi (`users.install_date`) tới ngày giao dịch (`purchases.event_date`), số không âm. | purchases, users | dao-thu-tu-datediff, thieu-quy-tac-hoa |
| jelly-s5-phien-ban-dang-chuoi | 2 | M3 | write | easy | A1 | operations | Người chơi đang dùng những phiên bản nào? | Xét các phiên chơi trong cửa sổ dữ liệu, từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Phiên bản `app_version` có dạng `'chính.phụ.vá'`. Tách ba phần thành số nguyên `so_chinh`, `so_phu`, `so_va`. | sessions | tach-sai-phan-giua, quen-can-tren |
| jelly-s6-tuan-iso | 2 | M3 | write | easy | B1 | customer | Số người cài game theo tuần | Xét người chơi cài từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Tuần bắt đầu vào thứ Hai. `tuan` là số nguyên ghép năm và số thứ tự tuần theo chuẩn ISO, như `YEARWEEK` trả về (ví dụ số 202628 là tuần 28 năm 2026; không … | users | tuan-bat-dau-chu-nhat, tuan-khong-tron |
| jelly-s7-thang-sai-thu-tu | 2 | M3 | debug | basic | B1 | finance | Doanh thu IAP theo tháng sắp ngược thứ tự | Truy vấn dưới đây tính doanh thu IAP theo tháng (giao dịch không hoàn tiền, từ 1/7/2026), nhưng tháng sắp sai thứ tự. · Sửa để `thang` có dạng `'2026-07'` và các tháng sắp đúng thứ tự thời gian. | purchases | sap-ten-thang |
| jelly-s8-gio-chua-doi | 2 | M3 | debug | easy | A1 | operations | Ca sáng 15/8 bị tính thừa một lượt sự cố | Truy vấn dưới đây cần liệt kê lượt chơi có kết quả `'crash'` (mọi nền tảng) từ 0 giờ ngày 15/8/2026 tới trước 11 giờ 00 phút 00 giây cùng ngày. Lượt lúc đúng 11 giờ 00 phút 00 giây thuộc ca sau. · Sửa điều kiện thời … | level_attempts | between-tren-datetime |
| jelly-s9-ma-chien-dich | 2 | M3 | debug | easy | A3 | marketing | Báo cáo người mới theo kênh có nhóm không tên | Truy vấn dưới đây đếm người chơi cài trong tháng 7/2026 theo kênh thu hút, nhưng có một nhóm có `kenh` bằng NULL (không có tên kênh). · Sửa để mọi người chơi có đúng tên kênh như cột `channel` (`'Organic'`, `'Search … | users | ma-dai-ngan-khac-nhau |
| jelly-a1-dau-thang-7 | 2 | M4 | write | easy | A2 | customer | DAU bình quân tháng 7 là bao nhiêu? | Xét các ngày hoạt động từ 1/7/2026 tới hết 31/7/2026. · Tính DAU bình quân của tháng bằng tổng DAU các ngày chia số ngày có dữ liệu. | player_daily | mau-chia-31, quen-can-tren |
| jelly-a2-doanh-thu-goi | 2 | M4 | write | easy | A3 | sales | Doanh thu từng gói vật phẩm | Xét các giao dịch không hoàn tiền trong cửa sổ dữ liệu, từ 1/7/2026 tới hết 29/8/2026. · Tính cho từng gói vật phẩm (`product_name`) số giao dịch, doanh thu IAP và giá bình quân một giao dịch. | purchases | quen-cua-so, dem-nguoi-thay-giao-dich |
| jelly-a3-chi-theo-kenh | 2 | M4 | write | easy | A3 | marketing | Chi phí quảng cáo tháng 8 của từng kênh | Xét chi phí từ ngày 1/8/2026 tới hết tháng 8/2026 (dữ liệu tháng 8 có tới hết ngày 29/8). · Tính cho từng kênh tổng chi phí và chi phí bình quân một ngày (tổng chi chia số ngày có chi phí). | campaign_spend | quen-can-tren, avg-theo-dong |
| jelly-a4-ty-le-thang-man | 2 | M4 | write | easy | A2 | operations | Tỷ lệ thắng của từng màn | Xét các lượt chơi từ 1/7/2026 tới hết 29/8/2026. · Tính tỷ lệ thắng của từng màn. | level_attempts | bo-crash-khoi-mau-so, quen-cua-so |
| jelly-a5-arppu | 2 | M4 | write | medium | A2 | finance | ARPPU tháng 7 là bao nhiêu? | Xét các giao dịch không hoàn tiền từ 1/7/2026 tới hết 31/7/2026. · Tính ARPPU (doanh thu IAP bình quân trên một người chơi trả tiền) cho từng nền tảng của giao dịch (`purchases.platform`). | purchases | mau-so-giao-dich, quen-can-tren |
| jelly-a6-quoc-gia-nhieu-crash | 2 | M4 | write | easy | A3 | after_sales | Thị trường nào có tỷ lệ sự cố cao nhất? | Xét các ngày hoạt động từ 1/7/2026 tới hết 29/8/2026. · Tính cho từng thị trường (`country`) số sự cố, số phiên và tỷ lệ sự cố trên 1.000 phiên (công thức ở tab Nghiệp vụ). | player_daily | trung-binh-ty-le, quen-cua-so |
| jelly-a7-dem-nguoi-tra-tien | 2 | M4 | debug | easy | A2 | sales | Số người trả tiền tháng 8 cao bất thường | Truy vấn dưới đây cần đếm số người chơi trả tiền, không phải số giao dịch, của từng nền tảng trong tháng 8/2026 (dữ liệu tới hết ngày 29/8). · Sửa truy vấn để mỗi người chơi chỉ được đếm một lần; giữ nguyên cột … | purchases | dem-giao-dich-thay-nguoi |
| jelly-a8-tb-ty-le | 2 | M4 | debug | medium | A2 | finance | ARPDAU cả tháng 7 bị sai | Truy vấn dưới đây tính tổng doanh thu (doanh thu IAP từ mua hàng trong ứng dụng cộng doanh thu quảng cáo), tổng DAU và ARPDAU của cả tháng 7/2026 từ bảng chỉ số ngày, nhưng ARPDAU của tháng ra sai. · Sửa cột `arpdau` … | daily_kpi | trung-binh-ty-le |
| jelly-a9-having-where | 2 | M4 | debug | medium | A3 | operations | Lọc màn khó mà cả 60 màn đều lọt | Truy vấn dưới đây cần liệt kê các màn có tỷ lệ thua do hết lượt đi trên 25% trong toàn bộ dữ liệu. Tỷ lệ thua là số lượt `result` = `'fail_out_of_moves'` chia tổng số lượt chơi của màn, kể cả lượt thắng, bỏ cuộc và gặp … | level_attempts | loc-dong-truoc-khi-gom |
| jelly-c3-phien-ban-moi-dai-hon | 2 | case | case | basic | – | operations | Phiên chơi có dài hơn sau bản cập nhật? | b1 Thời lượng phiên theo phiên bản; b2 Kết luận | sessions | b1: bo_cua_so_du_lieu, phien_ban_luc_cai |
| jelly-c4-kenh-dong-nguoi | 2 | case | case | easy | – | marketing | Kênh nào mang về nhiều người chơi trả tiền? | b1 Số người cài tháng 7 theo kênh; b2 Tỷ lệ người chơi trả tiền theo kênh; b3 Kết luận | users, purchases | b1: quen_can_tren; b2: dem_giao_dich_thay_nguoi, sap_theo_so_tuyet_doi |

## Gói 3 · M5 Joins, M6 Subqueries, case c5 (Dễ), c6 (Trung bình)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-j1-luot-choi-kem-the-gioi | 3 | M5 | write | easy | A1 | operations | Lượt chơi gần nhất kèm độ khó thiết kế | Xét các lượt chơi trong cửa sổ dữ liệu (1/7 tới 29/8/2026). · Lấy 20 lượt chơi có `event_time` muộn nhất. | level_attempts, level_metadata | thieu-can-tren, hoa-thoi-gian |
| jelly-j2-doanh-thu-theo-kenh-cai | 3 | M5 | write | easy | A3 | marketing | Doanh thu IAP tháng 8 theo kênh thu hút | Xét các giao dịch mua trong ứng dụng (IAP) từ ngày 1/8/2026 tới hết tháng 8 (dữ liệu có tới ngày 29/8). · Tính số người chơi trả tiền và doanh thu IAP của từng kênh thu hút (`users.channel`). | purchases, users | thieu-can-tren, dem-giao-dich |
| jelly-j3-nguoi-chua-mua | 3 | M5 | write | medium | A2 | customer | Bao nhiêu người chơi chưa từng mua? | Xét mọi người chơi trong `users` và các giao dịch tới hết ngày 29/8/2026. · Tính cho từng nền tảng số người chơi, số người chưa có giao dịch nào và tỷ lệ của nhóm này. | users, purchases | inner-join-mat-dong, dem-ca-giao-dich |
| jelly-j4-cpi-theo-kenh | 3 | M5 | write | medium | C3 | finance | Mỗi lượt cài của từng kênh trả phí tốn bao nhiêu? | Xét chi phí quảng cáo và người chơi cài từ ngày 1/7/2026 tới hết ngày 31/7/2026; chỉ các kênh trả phí. · Tính CPI (chi phí cho mỗi lượt cài đặt) của từng cặp kênh, nền tảng; chi phí lấy theo `target_platform`, lượt cài … | campaign_spend, users | fan-out, trung-binh-ty-le |
| jelly-j5-booster-theo-the-gioi | 3 | M5 | write | easy | A3 | operations | Loại vật phẩm hỗ trợ nào được dùng nhiều ở mỗi thế giới? | Xét mọi lần dùng vật phẩm hỗ trợ (booster) trong cửa sổ dữ liệu. · Đếm số lần dùng theo thế giới của màn và loại booster. | booster_events, level_metadata | fan-out, sap-theo-ten |
| jelly-j6-phien-co-mua | 3 | M5 | write | medium | A2 | sales | Phiên vào từ màn hình nào hay phát sinh giao dịch? | Xét các phiên chơi bắt đầu từ ngày 1/7/2026 tới hết ngày 31/7/2026. · Tính số phiên, số phiên có ít nhất một giao dịch và tỷ lệ phiên có giao dịch của từng màn hình vào game (`entry_screen`). | sessions, purchases | count-sao-dem-null, inner-join |
| jelly-j7-join-nhan-dong | 3 | M5 | debug | easy | A2 | finance | Doanh thu quảng cáo theo kênh gấp nhiều lần thực tế | Xét các ngày hoạt động từ 1/7/2026 tới hết 31/7/2026. · Sửa truy vấn khởi đầu để tính đúng doanh thu quảng cáo theo kênh thu hút của người chơi, gồm cả kênh tự nhiên (`'Organic'`). | player_daily, users | fan-out, mat-organic |
| jelly-j8-left-join-where | 3 | M5 | debug | medium | A2 | customer | Số người chưa tới bước hướng dẫn cuối bằng 0 | Xét mọi người chơi trong `users`. · Truy vấn khởi đầu cần đếm số người chơi không có dòng bước 5 (`step_id = 5`) trong `tutorial_steps`, theo từng nền tảng, nhưng đang ra 0. Sửa lại. | users, tutorial_steps | where-bien-left-thanh-inner |
| jelly-j9-noi-sai-khoa | 3 | M5 | debug | medium | A1 | after_sales | Lượt chơi gặp sự cố bị gắn nhầm phiên | Xét các lượt chơi có `result = 'crash'` ngày 28/8/2026. · Mỗi lượt chơi phải đi kèm đúng phiên chơi của lượt đó; sửa truy vấn khởi đầu cho đúng. | level_attempts, sessions | noi-sai-khoa, fan-out |
| jelly-q1-man-thua-tren-tb | 3 | M6 | write | easy | C3 | operations | Màn nào có tỷ lệ thua cao hơn mức chung của game? | Xét mọi lượt chơi tới hết ngày 29/8/2026. · Tỷ lệ thua của một màn bằng số lượt có `result = 'fail_out_of_moves'` chia tổng số lượt chơi màn đó. | level_attempts, level_metadata | trung-binh-ty-le, sai-mau-so |
| jelly-q2-nguoi-mua-season-pass | 3 | M6 | write | easy | A1 | sales | Người mua Season Pass đến từ đâu? | Xét người chơi có ít nhất một giao dịch `product_type = 'season_pass'`. · Đếm số người chơi như vậy theo thị trường (quốc gia, `users.country`) và kênh thu hút (`users.channel`). | users, purchases | join-dem-trung |
| jelly-q3-chua-qua-buoc-4 | 3 | M6 | write | medium | D1 | customer | Bao nhiêu người chơi mới dừng ở bước dùng búa kẹo mút? | Xét người chơi đã bắt đầu bước hướng dẫn 4 (`step_id = 4`, dùng vật phẩm hỗ trợ búa kẹo mút). · Người dừng ở bước 4 là người đã bắt đầu bước 4 nhưng không có dòng bước 5. | tutorial_steps, users | hieu-sai-buoc-co-dong |
| jelly-q4-ngay-dau-cao-nhat | 3 | M6 | write | medium | C3 | customer | Ngày nào DAU cao hơn mức bình quân của tháng? | Xét các ngày từ 1/7/2026 tới hết 29/8/2026 trong bảng chỉ số ngày `daily_kpi`. · DAU (số người chơi hoạt động trong ngày) bình quân của tháng là trung bình cột `dau` của các ngày cùng tháng, trong khoảng ngày trên. | daily_kpi | khong-tuong-quan |
| jelly-q5-roas-tren-chuan | 3 | M6 | write | medium | C3 | finance | Chiến dịch nào thu về trên mỗi đồng chi nhiều hơn mức chung? | Xét người chơi cài từ ngày 1/7/2026 tới hết 31/7/2026 qua kênh trả phí, và chi phí quảng cáo của tháng 7/2026. · Doanh thu của một chiến dịch là tổng `iap_revenue + ad_revenue` của người chơi cài từ chiến dịch đó trong … | users, player_daily, campaign_spend | trung-binh-ty-le, fan-out |
| jelly-q6-phien-ban-dau-tien | 3 | M6 | write | medium | B4 | operations | Người chơi lên bản 2.1.0 vào ngày nào? | Ngày lên bản 2.1.0 của một người chơi là ngày hoạt động sớm nhất có `app_version = '2.1.0'` trong `player_daily`. · Đếm số người chơi theo ngày lên bản 2.1.0. | player_daily | phien-ban-luc-cai, dem-moi-ngay |
| jelly-q7-exists-quang-cao | 3 | M6 | debug | easy | A2 | marketing | Đếm người xem quảng cáo có tặng thưởng lại ra số người không xem | Xét người chơi cài từ 1/7/2026 tới hết 31/7/2026. · Sửa truy vấn khởi đầu để đếm người chơi có ít nhất một lần xem quảng cáo `ad_type = 'rewarded'` trong tháng 7/2026, theo kênh thu hút. | users, ad_events | dao-dieu-kien |
| jelly-q8-subquery-nhieu-dong | 3 | M6 | debug | medium | A1 | sales | Giao dịch gần nhất của mỗi người chơi chỉ còn một dòng | Xét các giao dịch có `country = 'VN'`. · Kết quả cần mỗi người chơi trả tiền đúng một dòng, là giao dịch có `event_time` muộn nhất của người đó. Sửa truy vấn khởi đầu cho đúng. | purchases | truy-van-con-khong-tuong-quan |
| jelly-q9-not-in-null | 3 | M6 | debug | medium | A2 | sales | Không tìm thấy màn nào chưa từng có giao dịch | Xét mọi màn trong `level_metadata`, mọi giao dịch trong `purchases` và các lượt chơi trong cửa sổ dữ liệu (tới hết 29/8/2026). · Sửa truy vấn khởi đầu để liệt kê đúng các màn không có giao dịch nào gắn với màn đó … | level_metadata, level_attempts, purchases | not-in-null |
| jelly-c5-starter-pack-giu-chan | 3 | case | case | easy | – | customer | Người mua Starter Pack có ở lại lâu hơn? | b1 Số ngày hoạt động của người mua và người không mua; b2 Hai nhóm khác nhau từ ngày cài?; b3 Kết luận | users, player_daily, purchases | b1: noi_giao_dich_dem_trung, moi_nguoi_choi_ca_ky; b2: noi_giao_dich_nhan_dong |
| jelly-c6-kenh-dang-cat | 3 | case | case | medium | – | marketing | Có nên cắt kênh Video Network? | b1 Chi phí, lượt cài và CPI theo kênh tháng 7; b2 Doanh thu 7 ngày đầu trên mỗi lượt cài; b3 ROAS 7 ngày đầu theo kênh; b4 Kết luận | campaign_spend, users, player_daily | b1: noi_truc_tiep_nhan_dong; b2: mau_so_nguoi_co_doanh_thu; b3: doanh_thu_ca_ky |

## Gói 4 · M7 CTE & Set Operations, M8 Window Functions, case c7 (Trung bình), c8 (Khó)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-t1-pheu-huong-dan | 4 | M7 | write | medium | D1 | customer | Người chơi mới bỏ phần hướng dẫn ở bước nào nhiều nhất? | Xét người chơi cài game trong tháng 7/2026 (từ ngày 1 tới hết ngày 31). · Tính số người bắt đầu, số người hoàn thành và tỷ lệ hoàn thành của từng bước hướng dẫn. | users, tutorial_steps | mau-so-buoc-1, quen-can-tren |
| jelly-t2-buoc-4-android-210 | 4 | M7 | write | medium | C3 | customer | Bước 4 trên Android bản 2.1.0 có thấp hơn mức chung không? | Xét mọi dòng của bước hướng dẫn 4 (`step_id` = 4). · Tính tỷ lệ hoàn thành bước 4 của từng nhóm phiên bản (lúc làm bước 4) và nền tảng, và tỷ lệ hoàn thành chung của mọi người bắt đầu bước 4. | tutorial_steps | trung-binh-cua-ty-le |
| jelly-t3-d1-d7-theo-kenh | 4 | M7 | write | medium | D2 | customer | Tỷ lệ giữ chân D1, D7 theo kênh thu hút | Xét nhóm người chơi cài game từ đầu cửa sổ dữ liệu tới hết ngày 22/8/2026. · Tính số người cài, tỷ lệ giữ chân D1 và D7 (phần người cài còn hoạt động đúng ngày thứ 1, ngày thứ 7 sau ngày cài) của từng kênh thu hút. | users, player_daily | cohort-chua-du-ngay, inner-join-mat-mau-so |
| jelly-t4-kenh-co-va-khong-chi | 4 | M7 | write | medium | E2 | marketing | Người cài và chi phí quảng cáo tháng 7 lệch nhau ở kênh nào? | Xét người chơi đến từ các kênh trả phí (bỏ kênh Organic), cài trong tháng 7/2026, và chi phí quảng cáo có ngày trong tháng 7/2026 (từ ngày 1 tới hết ngày 31). · Một người cài “không có chi phí” khi không có dòng chi … | users, campaign_spend | union-bo-dong-trung, quen-can-tren |
| jelly-t5-doi-soat-kpi | 4 | M7 | write | hard | E2 | finance | Bảng chỉ số ngày có khớp với dữ liệu chi tiết không? | Xét 60 ngày của cửa sổ dữ liệu, từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Từ bảng hoạt động ngày của người chơi (`player_daily`) và bảng người chơi, tính lại bảy chỉ số của từng ngày: DAU, số phiên, tổng thời gian … | player_daily, users, daily_kpi | so-so-le-khong-lam-tron, quen-can-tren |
| jelly-t6-crash-hai-nguon | 4 | M7 | write | hard | E2 | after_sales | Hai nguồn đếm sự cố tháng 7 có khớp nhau không? | Xét các ngày trong tháng 7/2026 có người chơi hoạt động. · Theo từng ngày: số lượt chơi kết thúc vì sự cố, và tổng số sự cố ghi ở bảng hoạt động ngày của người chơi. | level_attempts, player_daily | fan-out, union-mat-dong |
| jelly-t7-union-doanh-thu | 4 | M7 | debug | medium | A3 | finance | Doanh thu tháng 7 theo nguồn bị thiếu tiền | Truy vấn dưới đây cộng doanh thu IAP và doanh thu quảng cáo tháng 7/2026 theo nền tảng, nhưng ra thấp hơn thực tế. · Sửa để mọi giao dịch và mọi lần xem quảng cáo trong tháng đều được cộng. | purchases, ad_events | union-khu-trung |
| jelly-t8-cte-loc-sai-cho | 4 | M7 | debug | hard | D2 | customer | Tỷ lệ giữ chân D7 theo phiên bản cài thấp bất thường | Truy vấn dưới đây tính tỷ lệ giữ chân D7 theo phiên bản lúc cài cho nhóm người cài đã đủ 7 ngày quan sát, nhưng ra thấp bất thường. · Sửa để tỷ lệ tính đúng định nghĩa giữ chân D7. | users, player_daily | mau-so-tu-so-khac-tap, phien-ban-luc-cai |
| jelly-t9-ab-itt | 4 | M7 | debug | hard | C3 | marketing | Kết quả A/B chỉ tính người đã gặp ưu đãi | Truy vấn dưới đây so hai nhánh của thử nghiệm `extra_moves_offer_timing` theo tỷ lệ người mua gói `extra_moves_pack` trong 7 ngày đầu. D0 là ngày được chia nhánh, nên 7 ngày đầu là D0 tới D6. Chỉ xét người được chia … | ab_assignments, purchases | chi-tinh-nguoi-tiep-xuc, cua-so-d0-6 |
| jelly-f1-top3-man-quit | 4 | M8 | write | medium | C1 | operations | Ba màn người chơi bỏ cuộc nhiều nhất ở mỗi thế giới | Xét mọi lượt chơi trong cửa sổ dữ liệu. Lượt bỏ cuộc là lượt có `result` = `'quit'`. Câu này xếp theo số lượt bỏ cuộc, không theo tỷ lệ bỏ cuộc. · Đếm số lượt bỏ cuộc của từng màn, xếp hạng các màn trong từng thế giới, … | level_attempts | trung-hang, thieu-partition |
| jelly-f2-dau-trot-7-ngay | 4 | M8 | write | medium | B3 | customer | DAU trung bình trượt 7 ngày | Xét 60 ngày của cửa sổ dữ liệu, từ ngày 1/7/2026 tới hết ngày 29/8/2026, dùng cột `dau` của bảng chỉ số ngày (`daily_kpi`). · Tính DAU trung bình của 7 ngày gần nhất tính tới từng ngày, gồm chính ngày đó và 6 ngày liền … | daily_kpi | khung-cua-so, quen-can-tren |
| jelly-f3-luy-ke-chi | 4 | M8 | write | medium | B3 | marketing | Chi quảng cáo luỹ kế theo kênh tháng 7 | Xét chi phí quảng cáo có ngày trong tháng 7/2026 (từ ngày 1 tới hết ngày 31). · Tính tổng chi của từng kênh trong từng ngày (cộng mọi thị trường và nền tảng), rồi cộng dồn trong từng kênh từ đầu tháng tới ngày đó. | campaign_spend | gom-ngay-truoc, thieu-partition |
| jelly-f4-doanh-thu-tuan-wow | 4 | M8 | write | hard | B2 | finance | Doanh thu tuần này so với tuần trước | Tuần tính từ thứ Hai tới Chủ nhật. Chỉ xét các tuần có đủ 7 ngày nằm trong cửa sổ dữ liệu (1/7/2026 tới hết 29/8/2026). · Doanh thu tuần là tổng doanh thu IAP và doanh thu quảng cáo của bảng chỉ số ngày (`daily_kpi`). | daily_kpi | tuan-khong-tron, lag-truoc-khi-loc |
| jelly-f5-chuoi-ngay-lien-tiep | 4 | M8 | write | hard | D3 | customer | Ai có chuỗi ngày chơi liên tiếp dài nhất? | Xét các ngày có hoạt động trong cửa sổ dữ liệu, từ 1/7/2026 tới hết 29/8/2026. · Chuỗi là các ngày hoạt động liền nhau, không bỏ ngày nào. Tìm chuỗi dài nhất của từng người chơi; nếu có nhiều chuỗi cùng dài nhất thì … | player_daily | dem-tong-ngay |
| jelly-f6-nguoi-chi-top-quoc-gia | 4 | M8 | write | medium | C1 | sales | Ba người chơi chi nhiều nhất mỗi thị trường | Xét mọi giao dịch mua trong ứng dụng trong cửa sổ dữ liệu, từ 1/7/2026 tới hết 29/8/2026. · Tính tổng tiền đã chi của từng người chơi; xếp hạng người chơi trong từng thị trường, giữ đúng 3 người mỗi thị trường. | purchases | trung-hang, dem-giao-dich |
| jelly-f7-rank-thay-row-number | 4 | M8 | debug | medium | C1 | operations | Ba màn gặp sự cố nhiều nhất lại thành năm màn | Truy vấn dưới đây xếp hạng các màn trong từng thế giới theo số lượt chơi kết thúc vì sự cố, nhưng có thế giới trả về hơn 3 màn. · Sửa để mỗi thế giới có đúng 3 màn, `hang` là 1, 2, 3; hai màn bằng số lượt thì màn có … | level_attempts | trung-hang |
| jelly-f8-lag-khong-partition | 4 | M8 | debug | medium | B2 | customer | Khoảng cách giữa hai ngày chơi bị âm | Với người chơi cài ngày 3/7/2026, truy vấn dưới đây tính số ngày từ ngày hoạt động liền trước tới mỗi ngày hoạt động của chính người đó (xét tới hết ngày 29/8/2026), rồi đếm mỗi khoảng cách xuất hiện bao nhiêu lần. · … | player_daily | thieu-partition, quen-can-tren |
| jelly-f9-ty-trong-goi | 4 | M8 | debug | medium | C2 | sales | Tỷ trọng doanh thu từng gói không cộng ra 100% | Truy vấn dưới đây tính doanh thu IAP của từng gói vật phẩm trong tháng 8/2026 (tới hết ngày 29/8) và tỷ trọng của gói trên tổng doanh thu IAP của tháng. · Sửa để tỷ trọng các gói cộng lại bằng 100%. | purchases | sai-pham-vi-cua-so, quen-can-tren |
| jelly-c7-android-210 | 4 | case | case | medium | – | operations | Người chơi Android dùng bản 2.1.0 gặp khó ở đâu? | b1 Bước dùng búa kẹo theo phiên bản và nền tảng; b2 Tỷ lệ thắng màn 28–30; b3 Tỷ lệ giữ chân D1 theo phiên bản lúc cài; b4 Kết luận | tutorial_steps, level_attempts, player_daily, users | b1: mau_so_la_buoc_1; b2: mau_so_bo_luot_su_co; b3: mau_so_tu_bang_hoat_dong |
| jelly-c8-doanh-thu-giam-vi-dau | 4 | case | case | hard | – | finance | Doanh thu tuần 10/8 giảm do ít người chơi hay chi ít? | b1 Doanh thu hai tuần theo nguồn; b2 DAU và ARPDAU của hai tuần; b3 Ít người trả tiền hơn hay mỗi người trả tiền chi ít hơn?; b4 Tách chênh lệch doanh thu; b5 Kết luận | daily_kpi, player_daily | b1: tuan_bat_dau_chu_nhat; b2: trung_binh_cot_arpdau; b3: dem_nguoi_khac_nhau; b4: doi_goc_tach |

## Gói 5 · M9 Data Quality, M10 Query Performance, case c9–c10 (Khó)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-k1-trung-khoa | 5 | M9 | write | medium | E1 | customer | Hai bảng nguồn của báo cáo giữ chân có dòng ghi trùng không? | Kiểm hai bảng: `player_daily` theo khoá (`user_id`, `activity_date`) và `tutorial_steps` theo khoá (`user_id`, `step_id`). · Mỗi bảng một dòng, kể cả khi không có dòng trùng: `bang` (tên bảng), `so_dong`, … | player_daily, tutorial_steps | khoa-thieu-cot, ket-qua-0-dong |
| jelly-k2-mo-coi | 5 | M9 | write | medium | E2 | operations | Giao dịch mua trong màn nào không có lượt chơi màn đó? | Chỉ xét giao dịch có `level_id_if_relevant` (mua khi đang ở một màn). · Một giao dịch thiếu lượt chơi khi trong cùng `session_id` không có lượt chơi nào có `level_id` bằng `level_id_if_relevant` của giao dịch. | purchases, level_attempts | fan-out, noi-thieu-cot, inner-join |
| jelly-k3-cohort-day-kiem | 5 | M9 | write | medium | E2 | customer | Số ngày kể từ lúc cài có được tính đúng? | Nối mỗi dòng `player_daily` với người chơi trong `users`. · Trả về một dòng: `so_dong_kiem`; `so_lech_cohort_day` (dòng có `cohort_day` khác số ngày từ `users.install_date` tới `activity_date`); `so_lech_ngay_cai` … | player_daily, users | datediff-dao-doi-so |
| jelly-k4-max-level-giam | 5 | M9 | write | medium | E1 | operations | Màn cao nhất trong ngày có lúc giảm không? | So `max_level` của mỗi ngày hoạt động với ngày hoạt động liền trước của cùng người chơi (ngày gần nhất trước đó có dòng, không nhất thiết là hôm trước). · Trả về một dòng: `so_ngay_nguoi_giam` (số dòng có `max_level` … | player_daily | hieu-sai-cot-luy-ke, lag-thieu-partition |
| jelly-k5-extra-moves-doi-soat | 5 | M9 | write | hard | E2 | sales | Mua thêm lượt đi ở ba nguồn có khớp nhau? | Xét tháng 8/2026 (dữ liệu tới hết ngày 29/8). Mỗi ngày có lượt chơi là một dòng. · Trả về `ngay`; `so_luot_nhan_them` (tổng cờ `extra_moves_purchased` trên các lượt chơi); `so_luot_bang_ngay` (tổng … | level_attempts, player_daily, purchases | co-khong-phai-giao-dich, fan-out, quen-can-tren |
| jelly-k6-ad-revenue-lam-tron | 5 | M9 | write | hard | E2 | finance | Doanh thu quảng cáo ở hai nguồn lệch nhau bao nhiêu? | Ngày-người là một người chơi trong một ngày. Chỉ xét các ngày-người có ít nhất một lần xem quảng cáo trong `ad_events`, trên toàn bộ dữ liệu. · Gom `ad_events.revenue_usd` theo người chơi và ngày, ghép với dòng … | player_daily, ad_events | so-bang-dau-bang-so-le, lam-tron-roi-so |
| jelly-k7-bat-thuong-chi | 5 | M9 | debug | medium | E1 | marketing | Ngày chi quảng cáo bất thường không hiện ra | Chi phí của một chiến dịch trong một ngày là tổng `spend_usd` trên mọi quốc gia và nền tảng. Xét ngày 1/7 tới hết ngày 29/8/2026. · Một ngày là bất thường khi chi trong ngày lớn hơn trung bình chi ngày của chính chiến … | campaign_spend | chuan-sai-nhom, quen-can-tren |
| jelly-k8-hoan-tien | 5 | M9 | debug | medium | E2 | after_sales | Doanh thu thuần của các gói vật phẩm ra số âm | Truy vấn dưới đây tính cho từng gói vật phẩm trong tháng 7/2026: `so_giao_dich`, `doanh_thu_gop`, `tien_hoan` (tổng giá của giao dịch hoàn tiền), `doanh_thu_thuan` (doanh thu gộp trừ tiền hoàn). · Truy vấn đang tính … | purchases | dao-co, case-thieu-else |
| jelly-k9-phien-hai-dang-ma | 5 | M9 | debug | hard | E1 | operations | Không người chơi mới nào bắt đầu bằng phần hướng dẫn? | Người chơi cài trong tháng 7/2026 (1/7 tới hết 31/7). Phiên đầu tiên của một người là phiên có `session_start` sớm nhất của người đó. · Một người “vào thẳng phần hướng dẫn” khi phiên đầu tiên của người đó có … | sessions, users | ma-phien-hai-dang, quen-can-tren |
| jelly-p1-dem-ket-qua-mot-lan | 5 | M10 | optimize | easy | A3 | operations | Kết quả lượt chơi màn 28–30 trong tháng 8 | Giữ nguyên kết quả: mỗi màn 28, 29, 30 một dòng, đếm lượt chơi tháng 8/2026 (tới hết ngày 29/8) theo từng kết quả; trả về `level_id`, `so_thang`, `so_thua`, `so_bo_cuoc`, `so_su_co`; sắp theo `level_id`. | level_attempts | quet-lai-bang |
| jelly-p2-doanh-thu-hai-nguon | 5 | M10 | optimize | easy | A3 | finance | Doanh thu quảng cáo theo nền tảng và định dạng chỉ với một lần quét | Giữ nguyên kết quả: `platform`, `ad_type`, `so_luot_xem`, `doanh_thu_usd` (làm tròn 2 chữ số) cho các lần xem quảng cáo tháng 7/2026; sắp theo `platform`, `ad_type`. | ad_events | union-all-lap |
| jelly-p3-tren-tb-the-gioi | 5 | M10 | optimize | hard | C3 | operations | Màn có tỷ lệ thua cao hơn mặt bằng thế giới chứa màn | Giữ nguyên kết quả: các màn có tỷ lệ thua (tháng 7/2026) cao hơn trung bình thế giới, trong đó trung bình thế giới là bình quân giản đơn tỷ lệ thua của các màn trong thế giới đó. · Trả về `world_name`, `level_id`, … | level_attempts | tinh-lai-hai-lan, trung-binh-sai-nhom |
| jelly-p4-luy-ke-tu-noi | 5 | M10 | optimize | hard | B3 | finance | Doanh thu luỹ kế trong tháng cho biểu đồ tiến độ | Giữ nguyên kết quả: mỗi ngày từ 1/7 tới hết 29/8/2026 một dòng: `ngay`, `doanh_thu` (`iap_revenue + ad_revenue`), `luy_ke_thang` (cộng dồn từ ngày đầu tháng tới ngày đó); sắp theo `ngay`. | daily_kpi | tu-noi-bang, quen-can-tren |
| jelly-p5-nguoi-tra-tien-exists | 5 | M10 | optimize | medium | A2 | sales | Đếm người chơi trả tiền theo kênh cho nhẹ hơn | Giữ nguyên kết quả: `channel`, `so_nguoi_tra_tien` (người có ít nhất một giao dịch từ 1/7 tới hết 29/8/2026); sắp `so_nguoi_tra_tien` giảm dần, bằng nhau thì `channel` theo thứ tự chữ cái. | users, purchases | noi-bang-nhan-dong |
| jelly-p6-dau-tu-sessions | 5 | M10 | optimize | medium | D2 | customer | Tỷ lệ giữ chân D1, D7 theo nền tảng chỉ với một lần đọc bảng hoạt động | Giữ nguyên kết quả: người chơi cài từ 1/7 tới hết 22/8/2026, theo `platform`: `so_nguoi_cai`, `so_con_d1`, `so_con_d7`, `ty_le_d1_pct`, `ty_le_d7_pct` (2 chữ số); sắp theo `platform`. | users, player_daily | doc-lai-bang, nhom-chua-du-ngay |
| jelly-p7-index-ngay | 5 | M10 | optimize | easy | A2 | operations | Màn được chơi nhiều nhất ngày 10/8, đọc ít dòng nhất | Giữ nguyên kết quả: các lượt chơi ngày 10/8/2026 gom theo màn: `level_id`, `so_luot`, `so_thang`, `ty_le_thang_pct` (2 chữ số); 10 màn có `so_luot` lớn nhất, bằng nhau thì `level_id` nhỏ hơn trước. | level_attempts | ham-tren-cot, between-datetime, thieu-can-tren |
| jelly-p8-ham-tren-cot | 5 | M10 | debug | hard | B1 | customer | MAU và mức độ gắn bó theo tháng ra sai | Xét tháng 7/2026 và tháng 8/2026 (tháng 8 có dữ liệu tới hết ngày 29/8). Mỗi tháng một dòng. · `mau`: số người chơi khác nhau hoạt động trong tháng. `dau_binh_quan`: số ngày-người của tháng (mỗi người chơi trong mỗi … | player_daily | ham-tren-cot, thang-chua-tron, dem-dong |
| jelly-p9-select-distinct-thua | 5 | M10 | optimize | medium | C4 | finance | Báo cáo phân khúc người chơi theo mức chi chạy nhẹ hơn | Giữ nguyên kết quả: mọi người chơi trong `users` chia theo tổng chi (tổng `price_usd` từ 1/7 tới hết 29/8/2026) thành `'khong_chi'` (bằng 0), `'duoi_5'` (dưới 5 USD), `'tu_5_den_20'` (từ 5 tới 20 USD), `'tren_20'` … | users, purchases | distinct-thua, inner-join-mat-nhom, loc-o-where |
| jelly-c9-ab-mua-them-buoc | 5 | case | case | hard | – | marketing | Đưa ưu đãi thêm lượt đi sớm hơn có đáng không? | b1 Cỡ mẫu của hai nhánh; b2 Chỉ số chính trên mọi người được chia; b3 Doanh thu IAP D0–D6 trên mỗi người; b4 Chỉ số bảo vệ: giữ chân D7; b5 Kết luận | ab_assignments, purchases, player_daily | b1: dem_tiep_xuc_bang_is_null; b2: chi_tinh_nguoi_da_tiep_xuc; b3: mau_so_nguoi_tra_tien; b4: gom_ca_nguoi_chua_du_ngay |
| jelly-c10-man-28-30 | 5 | case | case | hard | – | after_sales | Bản 2.1.1 đã sửa xong màn 28–30 chưa? | b1 Tỷ lệ thắng màn 28–30 theo phiên bản và nền tảng; b2 Tỷ lệ thua và bỏ cuộc; b3 Lượt chơi được mời thêm lượt đi; b4 Giữ chân D1 theo phiên bản lúc cài; b5 Kết luận | level_attempts, users, player_daily | b1: phien_ban_luc_cai; b4: mau_so_tu_bang_hoat_dong |

## Thống kê (đếm từ bảng trên)

**Hình thức:** write 54 · debug 28 · optimize 8 · case 10 = 100. **Cấp:** basic 14 · easy 34 · medium 37 · hard 15.

### Hình thức × cấp

| Hình thức | basic | easy | medium | hard | Cộng |
|---|---:|---:|---:|---:|---:|
| write | 8 | 20 | 20 | 6 | 54 |
| debug | 3 | 9 | 12 | 4 | 28 |
| optimize | · | 3 | 3 | 2 | 8 |
| case | 3 | 2 | 2 | 3 | 10 |
| **Cộng** | 14 | 34 | 37 | 15 | 100 |

### Theo module: cấp và hình thức

| Module | basic | easy | medium | hard | write | debug | optimize | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| M1 Retrieval | 5 | 4 | · | · | 6 | 3 | · | 9 |
| M2 NULL & Expressions | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M3 String & Date | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M4 Aggregation | · | 6 | 3 | · | 6 | 3 | · | 9 |
| M5 Joins | · | 4 | 5 | · | 6 | 3 | · | 9 |
| M6 Subqueries | · | 3 | 6 | · | 6 | 3 | · | 9 |
| M7 CTE & Set Operations | · | · | 5 | 4 | 6 | 3 | · | 9 |
| M8 Window Functions | · | · | 7 | 2 | 6 | 3 | · | 9 |
| M9 Data Quality | · | · | 6 | 3 | 6 | 3 | · | 9 |
| M10 Query Performance | · | 3 | 3 | 3 | · | 1 | 8 | 9 |
| Case | 3 | 2 | 2 | 3 | · | · | · | 10 |

### Theo gói

| Gói | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 12 | 6 | · | 2 | 10 | 10 | · | · |
| 2 | 12 | 6 | · | 2 | 4 | 13 | 3 | · |
| 3 | 12 | 6 | · | 2 | · | 8 | 12 | · |
| 4 | 12 | 6 | · | 2 | · | · | 13 | 7 |
| 5 | 6 | 4 | 8 | 2 | · | 3 | 9 | 8 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | customer | sales | marketing | operations | finance | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 Tra cứu lọc | 2 | 6 | 2 | 7 | · | 1 | 18 |
| A2 KPI | 3 | 5 | 1 | 2 | 5 | 1 | 17 |
| A3 Phân rã | 2 | 1 | 3 | 5 | 2 | 1 | 14 |
| A4 Bảng chéo | · | · | · | · | · | · | 0 |
| B1 Xu hướng | 2 | · | · | · | 2 | · | 4 |
| B2 So kỳ trước | 1 | · | · | · | 1 | · | 2 |
| B3 Luỹ kế, trượt | 1 | · | 1 | · | 1 | · | 3 |
| B4 Trạng thái tại thời điểm | · | · | 1 | 1 | · | · | 2 |
| C1 Top N mỗi nhóm | · | 1 | · | 2 | · | · | 3 |
| C2 Tỷ trọng | · | 1 | · | · | · | · | 1 |
| C3 So với chuẩn | 2 | · | 1 | 2 | 2 | · | 7 |
| C4 Phân khúc | · | · | · | · | 1 | · | 1 |
| D1 Phễu | 2 | · | · | · | · | · | 2 |
| D2 Cohort | 3 | · | · | · | · | · | 3 |
| D3 Chuỗi liên tiếp | 1 | · | · | · | · | · | 1 |
| E1 Bất thường | 1 | · | 1 | 2 | · | · | 4 |
| E2 Đối soát | 1 | 1 | 1 | 1 | 2 | 2 | 8 |
| E3 Cấu trúc cây | · | · | · | · | · | · | 0 |
| **Cộng** | 21 | 15 | 11 | 22 | 16 | 5 | 90 |

Dạng có câu: 16/18; chưa có: A4, E3; chỉ 1 câu: C2, C4, D3.

Mảng trên cả 100 câu (gồm case): customer 22, sales 16, marketing 14, operations 24, finance 18, after_sales 6.

### Kiểm khung phân bổ

Lệch khung (module 9 câu: M1–M9 6 write + 3 debug, M10 ~6 optimize; cấp M1–3 basic/easy, M4–6 easy/medium, M7–10 medium/hard; case gói 1 → 5: basic+basic, basic+easy, easy+medium, medium+hard, hard+hard):

- `jelly-p1-dem-ket-qua-mot-lan` (M10) cấp easy, ngoài khung medium / hard.
- `jelly-p2-doanh-thu-hai-nguon` (M10) cấp easy, ngoài khung medium / hard.
- `jelly-p7-index-ngay` (M10) cấp easy, ngoài khung medium / hard.

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: 
- C3 · finance · medium · write: `jelly-j4-cpi-theo-kenh`, `jelly-q5-roas-tren-chuan`

Ô trùng **giữa các gói** (10 ô; cho phép, ghi để tham khảo): 
- A1 · operations · basic · write: `jelly-r3-man-sieu-kho`, `jelly-s2-tach-the-gioi`
- A1 · operations · easy · write: `jelly-r5-luot-dai-man-30`, `jelly-s5-phien-ban-dang-chuoi`, `jelly-j1-luot-choi-kem-the-gioi`
- A1 · operations · easy · debug: `jelly-r9-phien-dai-15-8`, `jelly-s8-gio-chua-doi`
- A3 · operations · easy · write: `jelly-n3-nhom-buoc-du`, `jelly-j5-booster-theo-the-gioi`
- A1 · sales · easy · write: `jelly-n5-gia-quy-doi-vnd`, `jelly-s4-ngay-tu-cai-den-mua`, `jelly-q2-nguoi-mua-season-pass`
- A2 · finance · easy · debug: `jelly-n8-ty-le-sai-chia`, `jelly-j7-join-nhan-dong`
- A3 · marketing · easy · write: `jelly-a3-chi-theo-kenh`, `jelly-j2-doanh-thu-theo-kenh-cai`
- D1 · customer · medium · write: `jelly-q3-chua-qua-buoc-4`, `jelly-t1-pheu-huong-dan`
- C3 · customer · medium · write: `jelly-q4-ngay-dau-cao-nhat`, `jelly-t2-buoc-4-android-210`
- E2 · finance · hard · write: `jelly-t5-doi-soat-kpi`, `jelly-k6-ad-revenue-lam-tron`

### Chênh lệch so với bản đồ bản 1 (phân bổ gốc)

So 100 dòng của bản 1 với 100 câu thật: 2 mã khác, 13 câu đổi hình thức/cấp/dạng/mảng, 73 câu đổi tiêu đề (không liệt kê).

Mã có ở bản 1 nhưng không còn: `jelly-s6-tuan-ISO`.
Mã mới (không có ở bản 1): `jelly-s6-tuan-iso`.

Câu đổi khoá so với bản 1:

- `jelly-r6-su-kien-thang-8`: dạng A1 → B4
- `jelly-n4-tong-doanh-thu-ngay`: dạng A2 → B1
- `jelly-a4-ty-le-thang-man`: cấp medium → easy
- `jelly-a6-quoc-gia-nhieu-crash`: cấp medium → easy
- `jelly-j5-booster-theo-the-gioi`: cấp medium → easy
- `jelly-f6-nguoi-chi-top-quoc-gia`: cấp hard → medium
- `jelly-f8-lag-khong-partition`: cấp hard → medium
- `jelly-k4-max-level-giam`: cấp hard → medium
- `jelly-p1-dem-ket-qua-mot-lan`: cấp medium → easy
- `jelly-p2-doanh-thu-hai-nguon`: cấp medium → easy
- `jelly-p6-dau-tu-sessions`: cấp hard → medium
- `jelly-p7-index-ngay`: hình thức write → optimize; cấp medium → easy
- `jelly-p9-select-distinct-thua`: hình thức write → optimize; cấp hard → medium

| | write | debug | optimize | case | basic | easy | medium | hard |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Bản 1 | 56 | 28 | 6 | 10 | 14 | 28 | 38 | 20 |
| Bản 2 (thật) | 54 | 28 | 8 | 10 | 14 | 34 | 37 | 15 |

## Ghi chú giữ từ bản 1

_Giữ nguyên văn để không mất ý của người lập bản 1; số liệu trong các đoạn này có thể đã cũ, đối chiếu bảng và thống kê ở trên._

**Dạng không phủ và lý do:**
- **E3 Cấu trúc cây:** dữ liệu không có quan hệ cha–con tự tham chiếu (không có người giới thiệu, không có cây danh mục). Thay bằng E2 đối
  soát (dữ liệu có nhiều cặp bảng tổng hợp ↔ sự kiện: `daily_kpi`↔`player_daily`, `crash_count`↔lượt crash, `extra_moves`↔giao dịch).
- **A4 Bảng chéo:** chưa xếp riêng; người soạn gói 2 có thể đổi `jelly-s3` hoặc `jelly-a6` thành bảng chéo (`platform` × `country` bằng
  `SUM(CASE…)`) nếu cần phủ.
- **after_sales** mỏng vì dữ liệu không có hoàn tiền thật (`is_refund` luôn 0) và không có ticket hỗ trợ; dùng sự cố (crash) và đối soát
  sau phát hành bản vá (2.1.1). Câu `jelly-f8` dùng hoàn tiền phải nói rõ trong nghiệp vụ là kỳ này chưa có hoàn tiền.
