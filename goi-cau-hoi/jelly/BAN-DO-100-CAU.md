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
| jelly-r2-goi-tam-trung-chau-my | 1 | M1 | write | medium | A1 | sales | Ai ở Mỹ và Brazil mua gói tầm trung tuần cuối tháng 7? | Xét các giao dịch mua gói tầm trung (định nghĩa ở tab Nghiệp vụ) ở thị trường Mỹ (`'US'`) và Brazil (`'BR'`), có thời điểm giao dịch (`event_time`) từ 0 giờ ngày 25/7/2026 tới hết ngày 31/7/2026. · Trả về … | purchases | between-tren-thoi-diem, thu-tu-and-or, bien-duoi-khoang-gia |
| jelly-r3-luot-bat-thuong-volcano | 1 | M1 | write | hard | A1 | after_sales | Lượt chơi kết thúc bất thường ở Chocolate Volcano trên Android 2.1.1 | Lấy các lượt chơi kết thúc bất thường ở những màn khó trở lên của thế giới Chocolate Volcano, do người chơi Android ở Đông Nam Á chơi trên bản 2.1.1. Các khái niệm này được định nghĩa ở tab Nghiệp vụ. · Trả về … | level_attempts | thu-tu-and-or, bo-dieu-kien-do-kho, chep-danh-sach-man |
| jelly-r4-ngay-chi-cao-social | 1 | M1 | write | easy | A1 | marketing | Mười ngày chi nhiều nhất cho Social Ads ở Việt Nam | Xét chi phí của chiến dịch `'JTA-SOCIAL-204'` (kênh Social Ads), thị trường `'VN'`, nền tảng nhắm tới (`target_platform`) `'Android'`, từ ngày 15/8/2026 tới ngày mới nhất có trong dữ liệu. · Trả về `date`, `spend_usd` … | campaign_spend | quen-dieu-kien-loc, thieu-can-tren |
| jelly-r5-luot-dai-man-30 | 1 | M1 | write | easy | A1 | operations | Lượt chơi màn 30 lâu nhất trên Android 2.1.0 | Xét lượt chơi màn 30 (`level_id`) trên nền tảng `'Android'`, với phiên bản ứng dụng lúc chơi (`app_version`) là `'2.1.0'`. · Trả về `attempt_id`, `user_id`, `event_date`, `duration_sec` (giây), `result`. | level_attempts | phien-ban-luc-cai, quen-dieu-kien-loc |
| jelly-r6-su-kien-ky-14-ngay | 1 | M1 | write | medium | B4 | marketing | Sự kiện LiveOps nào chạy trong kỳ 14 ngày từ 26/7? | Kỳ báo cáo gồm 14 ngày liền nhau, ngày đầu là 26/7/2026. · Lấy các sự kiện LiveOps (sự kiện vận hành trực tiếp trong game) được tính vào kỳ báo cáo theo quy tắc ở tab Nghiệp vụ. | liveops_events | giao-khoang-ngay, hoac-thay-va, can-cuoi-ky |
| jelly-r7-organic-ios-tuan-dau | 1 | M1 | debug | basic | A1 | customer | Danh sách người chơi iOS bị lẫn người chơi Android | Sửa truy vấn dưới đây để chỉ lấy người chơi ở thị trường `'VN'`, nền tảng `'iOS'`, cài từ ngày 1/7/2026 tới hết ngày 7/7/2026, đến từ kênh `'Organic'` hoặc `'Search Ads'`. · Giữ nguyên các cột `user_id`, … | users | thu-tu-and-or |
| jelly-r8-giao-dich-thang-8-thua | 1 | M1 | debug | easy | A1 | sales | Danh sách giao dịch tháng 8 có dòng tháng 9 | Danh sách chỉ được gồm giao dịch của người chơi ở thị trường `'GB'` trong tháng 8/2026; sửa truy vấn dưới đây cho đúng. · Truy vấn vẫn phải đúng khi dữ liệu có thêm ngày sau tháng 8. | purchases | thieu-can-tren, between-gom-dau-mut, lon-hon-thay-lon-hon-bang |
| jelly-r9-phien-ios-ban-cu | 1 | M1 | debug | hard | A1 | operations | Danh sách phiên chưa cập nhật ở Việt Nam dài hàng nghìn dòng | Truy vấn dưới đây cần liệt kê các phiên chơi của người chơi iOS ở Việt Nam chưa cập nhật lên bản 2.1 (phiên còn chạy bản 2.0), vào game từ màn hình chính (`'home'`) hoặc bản đồ (`'map'`), từ ngày 25/8/2026 tới ngày mới nhất … | sessions | thu-tu-and-or, khac-mot-gia-tri, gan-cung-ngay-cuoi |
| jelly-n1-iap-khong-gan-man | 1 | M2 | write | basic | A2 | sales | Bao nhiêu giao dịch không gắn với màn chơi? | Xét mọi giao dịch trong bảng `purchases`. · Đếm các giao dịch có `level_id_if_relevant` trống (NULL). | purchases | bang-null, count-cot-null |
| jelly-n2-ty-le-chua-tiep-xuc-nhanh | 1 | M2 | write | medium | A2 | marketing | Tỷ lệ chưa tiếp xúc ưu đãi của hai nhánh thử nghiệm | Xét mọi người chơi được chia nhánh trong thử nghiệm A/B `'extra_moves_offer_timing'`. · Tính tỷ lệ chưa tiếp xúc ưu đãi của nhánh đối chứng và của nhánh thử theo tab Nghiệp vụ, rồi lấy tỷ lệ của nhánh thử trừ tỷ lệ của nhánh đối chứng. | ab_assignments | count-cot-null, sai-mau-so, bang-null |
| jelly-n3-nhom-luot-di-du | 1 | M2 | write | easy | A3 | operations | Lượt chơi màn 28 còn dư bao nhiêu lượt đi? | Xét các lượt chơi màn 28 (`level_id`) ngày 1/8/2026. · Gán nhóm theo số lượt đi còn dư (`moves_left`): bằng 0 là `'het_luot_di'`; từ 1 tới 2 là `'du_1_2'`; từ 3 trở lên là `'du_tu_3'`. | level_attempts | thu-tu-case, nham-ket-qua-voi-luot-du |
| jelly-n4-tong-doanh-thu-ngay | 1 | M2 | write | easy | B1 | finance | Tổng doanh thu từng ngày tuần đầu tháng 7 | Xét 7 ngày từ 1/7/2026 tới hết 7/7/2026 trong bảng chỉ số ngày `daily_kpi`. · Tính tổng doanh thu bằng doanh thu IAP (`iap_revenue`) cộng doanh thu quảng cáo (`ad_revenue`); tính tỷ trọng quảng cáo bằng doanh thu quảng … | daily_kpi | thu-tu-phep-tinh, sai-mau-so |
| jelly-n5-mo-ta-giao-dich-vn | 1 | M2 | write | hard | A1 | sales | Dòng mô tả cho từng giao dịch của người chơi Việt Nam | Xét giao dịch của người chơi ở thị trường `'VN'` từ ngày 27/8/2026 tới ngày mới nhất có trong dữ liệu. · Lập cột `mo_ta` theo mẫu ở tab Nghiệp vụ. | purchases | noi-chuoi-voi-null, thay-null-sai-cho, bo-nhanh-khuyen-mai, gan-cung-ngay-cuoi |
| jelly-n6-ty-trong-iap-man-28-30 | 1 | M2 | write | medium | C2 | finance | Màn 28–30 đóng góp bao nhiêu phần doanh thu IAP tháng 7? | Xét các giao dịch IAP (mua hàng trong ứng dụng) trong tháng 7/2026. · Chia doanh thu IAP thành hai phần: giao dịch gắn với màn 28, 29 hoặc 30, và phần còn lại theo tab Nghiệp vụ. Tính tỷ trọng … | purchases | not-between-bo-null, lam-tron-som, thieu-can-tren |
| jelly-n7-crash-khoang-trang | 1 | M2 | debug | basic | A2 | after_sales | Số lượt chơi gặp sự cố ra 0 | Sửa truy vấn dưới đây để đếm đúng số lượt chơi có kết quả gặp sự cố trong tháng 7/2026. · Giữ nguyên cột `so_luot_su_co`. | level_attempts | khoang-trang-thua, nham-nguon-dem |
| jelly-n8-ty-le-su-co-tron-chuc | 1 | M2 | debug | hard | B1 | after_sales | Tỷ lệ sự cố ngày nào cũng tròn chục | Truy vấn dưới đây cần tính tỷ lệ sự cố trên 1.000 phiên (theo tab Nghiệp vụ) của từng ngày, từ ngày 23/8/2026 tới ngày mới nhất có trong bảng chỉ số ngày `daily_kpi`. · Truy vấn có ba lỗi chồng nhau … | daily_kpi | sai-mau-so, lam-tron-som, gan-cung-ngay-cuoi |
| jelly-n9-nhan-nguoi-tra-tien | 1 | M2 | debug | easy | A3 | sales | Nhóm trả tiền gồm mọi người chơi | Xét người chơi hoạt động ngày 15/8/2026. · Sửa truy vấn dưới đây để gán nhãn `'tra_tien'` cho người chơi có doanh thu IAP (mua hàng trong ứng dụng) trong ngày (`iap_revenue`) lớn hơn 0, còn lại gán `'khong_tra_tien'`. | player_daily | bien-lon-hon-bang, nham-doanh-thu-quang-cao |
| jelly-c1-quang-cao-co-thuong | 1 | case | case | basic | – | finance | Quảng cáo có tặng thưởng mang lại bao nhiêu? | b1 Doanh thu theo loại quảng cáo; b2 Kết luận | ad_events | b1: thieu_can_tren, dem_nguoi_xem |
| jelly-c2-gia-goi-ban-chay | 1 | case | case | basic | – | sales | Gói rẻ nhất có bán chạy nhất? | b1 Số giao dịch và doanh thu theo gói; b2 Kết luận | purchases | b1: dem_nguoi_mua, khong_gioi_han_ngay |

## Gói 2 · M3 String & Date, M4 Aggregation, case c3 (Cơ bản), c4 (Dễ)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-s1-arpdau-ngay-su-kien | 2 | M3 | write | hard | C3 | marketing | Ngày có sự kiện LiveOps, mỗi người chơi mang về bao nhiêu? | Xét các ngày từ 1/7/2026 tới hết 29/8/2026. Ngày nằm trong thời gian chạy của một sự kiện LiveOps (sự kiện vận hành trực tiếp trong game) thuộc nhóm mang tên sự kiện đó (`event_name`); ngày không có sự kiện nào thuộc nhóm `'ngay_thuong'`. · Với mỗi nhóm: số ngày, tổng DAU … | daily_kpi, liveops_events | bo-ngay-ket-thuc, trung-binh-arpdau-ngay, quen-can-tren, gan-cung-lich-su-kien |
| jelly-s2-tach-the-gioi | 2 | M3 | write | basic | A1 | operations | Tên thế giới trong ngữ cảnh màn hình | Xét các màn có nhãn độ khó khác `'normal'`. · Ngữ cảnh màn hình `screen_context` gồm ba phần, ngăn cách bằng chuỗi `' > '` (dấu cách, dấu lớn hơn, dấu cách). Lấy phần thứ hai làm `the_gioi`, bỏ dấu cách ở hai đầu. | level_metadata | tach-sai-dau-phan-cach |
| jelly-s3-ngay-trong-tuan | 2 | M3 | write | easy | A3 | customer | Người chơi cài game vào thứ mấy nhiều nhất? | Xét người chơi cài từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Tính cho từng thứ trong tuần của ngày cài: số ngày có người cài, số người cài và số người cài bình quân mỗi ngày (số người cài chia số ngày). | users | dayofweek-bat-dau-chu-nhat, so-ngay-moi-thu-khac-nhau |
| jelly-s4-lan-mua-dau-sau-cai | 2 | M3 | write | medium | C4 | sales | Người chơi trả tiền lần đầu sau khi cài bao lâu? | Xét người chơi cài từ 1/7/2026 tới hết 31/7/2026 và có ít nhất một giao dịch không hoàn tiền từ ngày cài tới hết 29/8/2026. · Với mỗi người, tính số ngày từ ngày cài tới ngày của giao dịch đầu tiên, rồi xếp vào một trong ba nhóm … | users, purchases | moi-giao-dich-thay-lan-dau, dao-thu-tu-datediff, quen-can-tren |
| jelly-s5-phien-ban-dang-chuoi | 2 | M3 | write | easy | A1 | operations | Người chơi đang dùng những phiên bản nào? | Xét các phiên chơi trong cửa sổ dữ liệu, từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Phiên bản `app_version` có dạng `'chính.phụ.vá'`. Tách ba phần thành số nguyên `so_chinh`, `so_phu`, `so_va`. | sessions | tach-sai-phan-giua, quen-can-tren |
| jelly-s6-giu-chan-d7-theo-tuan | 2 | M3 | write | hard | D2 | customer | Tuần cài nào giữ chân người chơi mới tốt nhất? | Xét người chơi cài từ 1/7/2026 và đã đủ ngày quan sát cho tỷ lệ giữ chân D7. Cửa sổ dữ liệu kết thúc ngày 29/8/2026. · Gom người chơi theo tuần cài, tuần bắt đầu vào thứ Hai. `tuan` là số nguyên ghép năm và số tuần theo chuẩn ISO … | users, player_daily | tuan-bat-dau-chu-nhat, nhom-chua-du-ngay, noi-trong-mat-mau-so, ngay-cuoi-bang-max |
| jelly-s7-thang-sai-thu-tu | 2 | M3 | debug | basic | B1 | finance | Doanh thu IAP theo tháng sắp ngược thứ tự | Truy vấn dưới đây tính doanh thu IAP theo tháng (giao dịch không hoàn tiền, từ 1/7/2026), nhưng tháng sắp sai thứ tự. · Sửa để `thang` có dạng `'2026-07'` và các tháng sắp đúng thứ tự thời gian. | purchases | sap-ten-thang |
| jelly-s8-su-co-ba-ngay-dau | 2 | M3 | debug | medium | A2 | after_sales | Bản 2.1.0 ít sự cố bất ngờ trong ba ngày đầu | Ngày phát hành của một bản là ngày đầu tiên có người chơi cài bản đó (`users.app_version_install`). Xét hai bản `'2.1.0'` và `'2.1.1'`; ba ngày đầu gồm ngày phát hành và hai ngày kế tiếp. · Truy vấn dưới đây tính số phiên … | users, player_daily | cong-so-vao-ngay, phien-ban-luc-cai |
| jelly-s9-ma-chien-dich | 2 | M3 | debug | easy | A3 | marketing | Báo cáo người mới theo kênh có nhóm không tên | Truy vấn dưới đây đếm người chơi cài trong tháng 7/2026 theo kênh thu hút, nhưng có một nhóm có `kenh` bằng NULL (không có tên kênh). · Sửa để mọi người chơi có đúng tên kênh như cột `channel` (`'Organic'`, `'Search … | users | ma-dai-ngan-khac-nhau |
| jelly-a1-dau-thang-7 | 2 | M4 | write | easy | A2 | customer | DAU bình quân tháng 7 là bao nhiêu? | Xét các ngày hoạt động từ 1/7/2026 tới hết 31/7/2026. · Tính DAU bình quân của tháng bằng tổng DAU các ngày chia số ngày có dữ liệu. | player_daily | mau-chia-31, quen-can-tren |
| jelly-a2-doanh-thu-goi | 2 | M4 | write | basic | A3 | sales | Doanh thu từng gói vật phẩm tháng 7 | Xét các giao dịch có `is_refund` = 0 và ngày giao dịch `event_date` từ 1/7/2026 tới hết 31/7/2026. · Với mỗi gói vật phẩm (`product_name`): đếm số giao dịch và cộng `price_usd`. | purchases | quen-can-tren |
| jelly-a3-chi-theo-kenh | 2 | M4 | write | basic | A3 | marketing | Chi phí quảng cáo tháng 7 của từng kênh | Xét các dòng chi phí có ngày `date` từ 1/7/2026 tới hết 31/7/2026. · Với mỗi kênh (`channel`): cộng `spend_usd`. | campaign_spend | quen-can-tren |
| jelly-a4-ty-le-thang-man | 2 | M4 | write | easy | A2 | operations | Tỷ lệ thắng của từng màn | Xét các lượt chơi từ 1/7/2026 tới hết 29/8/2026. · Tính tỷ lệ thắng của từng màn. | level_attempts | bo-crash-khoi-mau-so, quen-cua-so |
| jelly-a5-arppu | 2 | M4 | write | medium | A2 | finance | ARPPU tháng 7 là bao nhiêu? | Xét các giao dịch không hoàn tiền từ 1/7/2026 tới hết 31/7/2026. · Tính ARPPU (doanh thu IAP bình quân trên một người chơi trả tiền) cho từng nền tảng của giao dịch (`purchases.platform`). | purchases | mau-so-giao-dich, quen-can-tren |
| jelly-a6-su-co-truoc-sau-ban-va | 2 | M4 | write | hard | C3 | after_sales | Bản vá 2.1.1 giảm sự cố ở thị trường nào? | Xét các ngày hoạt động từ 1/7/2026 tới hết 29/8/2026; một ngày hoạt động thuộc bản mà người chơi dùng trong ngày đó. · Với mỗi thị trường (`country`): số phiên và tỷ lệ sự cố trên 1.000 phiên của bản `'2.1.0'`, của bản `'2.1.1'` … | player_daily | phien-ban-luc-cai, so-voi-moi-ban-cu, trung-binh-ty-le, quen-cua-so |
| jelly-a7-dem-nguoi-tra-tien | 2 | M4 | debug | easy | A2 | sales | Số người trả tiền tháng 8 cao bất thường | Truy vấn dưới đây cần đếm số người chơi trả tiền, không phải số giao dịch, của từng nền tảng trong tháng 8/2026 (dữ liệu tới hết ngày 29/8). · Sửa truy vấn để mỗi người chơi chỉ được đếm một lần; giữ nguyên cột … | purchases | dem-giao-dich-thay-nguoi |
| jelly-a8-arpdau-thang-8-nen-tang | 2 | M4 | debug | hard | A2 | finance | ARPDAU tháng 8 theo nền tảng cao bất thường | Truy vấn dưới đây tính cho từng nền tảng của ngày hoạt động (`platform`) trong tháng 8/2026: tổng doanh thu (doanh thu IAP từ mua hàng trong ứng dụng cộng doanh thu quảng cáo), tổng DAU … · Truy vấn có hai lỗi chồng nhau. Sửa cả hai … | player_daily | mau-thay-tong-dau, quen-can-tren |
| jelly-a9-having-where | 2 | M4 | debug | medium | A3 | operations | Lọc màn khó mà cả 60 màn đều lọt | Truy vấn dưới đây cần liệt kê các màn có tỷ lệ thua do hết lượt đi trên 25% trong toàn bộ dữ liệu. Tỷ lệ thua là số lượt `result` = `'fail_out_of_moves'` chia tổng số lượt chơi của màn, kể cả lượt thắng, bỏ cuộc và gặp … | level_attempts | loc-dong-truoc-khi-gom |
| jelly-c3-phien-ban-moi-dai-hon | 2 | case | case | basic | – | operations | Phiên chơi có dài hơn sau bản cập nhật? | b1 Thời lượng phiên theo phiên bản; b2 Kết luận | sessions | b1: bo_cua_so_du_lieu, phien_ban_luc_cai |
| jelly-c4-kenh-dong-nguoi | 2 | case | case | easy | – | marketing | Kênh nào mang về nhiều người chơi trả tiền? | b1 Số người cài tháng 7 theo kênh; b2 Tỷ lệ người chơi trả tiền theo kênh; b3 Kết luận | users, purchases | b1: quen_can_tren; b2: dem_giao_dich_thay_nguoi, sap_theo_so_tuyet_doi |

## Gói 3 · M5 Joins, M6 Subqueries, case c5 (Dễ), c6 (Trung bình)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-j1-luot-choi-kem-the-gioi | 3 | M5 | write | basic | A1 | operations | Lượt chơi cuối ngày 29/8 kèm xác suất thua thiết kế | Xét các lượt chơi có `event_date` là ngày 29/8/2026. · Lấy 20 lượt chơi có `event_time` muộn nhất; xác suất thua theo thiết kế lấy từ màn của từng lượt. | level_attempts, level_metadata | quen-loc-ngay |
| jelly-j2-doanh-thu-theo-kenh-cai | 3 | M5 | write | easy | A3 | marketing | Doanh thu IAP tháng 8 theo kênh thu hút | Xét các giao dịch mua trong ứng dụng (IAP) từ ngày 1/8/2026 tới hết tháng 8 (dữ liệu có tới ngày 29/8). · Tính số người chơi trả tiền và doanh thu IAP của từng kênh thu hút (`users.channel`). | purchases, users | thieu-can-tren, dem-giao-dich |
| jelly-j3-di-sau-chua-tra-tien | 3 | M5 | write | hard | A2 | customer | Người chơi đi sâu mà chưa trả tiền đến từ kênh nào? | Xét dữ liệu tới hết ngày 29/8/2026. · Người chơi đi sâu là người có ít nhất một lượt chơi ở màn thuộc thế giới thứ ba trở đi (Licorice Lagoon, Chocolate Volcano). Trong nhóm này, người chưa trả tiền là … | users, level_attempts, level_metadata, purchases, player_daily | fan-out, where-bien-left-thanh-inner, thieu-can-tren |
| jelly-j4-cpi-thang-8-so-muc-chung | 3 | M5 | write | hard | C3 | marketing | Tháng 8, lượt cài của kênh nào đắt hơn mức chung? | Xét tháng 8/2026; dữ liệu tháng 8 có tới hết ngày 29/8. · Tính CPI (chi phí cho mỗi lượt cài đặt) của từng cặp kênh trả phí và nền tảng, và CPI chung của mọi kênh trả phí trong tháng. | campaign_spend, users | fan-out, trung-binh-ty-le, mau-so-gom-organic, thieu-can-tren |
| jelly-j5-booster-theo-the-gioi | 3 | M5 | write | easy | A3 | operations | Loại vật phẩm hỗ trợ nào được dùng nhiều ở mỗi thế giới? | Xét mọi lần dùng vật phẩm hỗ trợ (booster) trong cửa sổ dữ liệu. · Đếm số lần dùng theo thế giới của màn và loại booster. | booster_events, level_metadata | fan-out, sap-theo-ten |
| jelly-j6-phien-co-mua | 3 | M5 | write | medium | A2 | sales | Phiên vào từ màn hình nào hay phát sinh giao dịch? | Xét các phiên chơi bắt đầu từ ngày 1/7/2026 tới hết ngày 31/7/2026. · Tính số phiên, số phiên có ít nhất một giao dịch và tỷ lệ phiên có giao dịch của từng màn hình vào game (`entry_screen`). | sessions, purchases | count-sao-dem-null, inner-join |
| jelly-j7-join-nhan-dong | 3 | M5 | debug | easy | A2 | finance | Doanh thu quảng cáo theo kênh gấp nhiều lần thực tế | Xét các ngày hoạt động từ 1/7/2026 tới hết 31/7/2026. · Sửa truy vấn khởi đầu để tính đúng doanh thu quảng cáo theo kênh thu hút của người chơi, gồm cả kênh tự nhiên (`'Organic'`). | player_daily, users | fan-out, mat-organic |
| jelly-j8-left-join-where | 3 | M5 | debug | medium | A2 | customer | Số người chưa tới bước hướng dẫn cuối bằng 0 | Xét mọi người chơi trong `users`. · Truy vấn khởi đầu cần đếm số người chơi không có dòng bước 5 (`step_id = 5`) trong `tutorial_steps`, theo từng nền tảng, nhưng đang ra 0. Sửa lại. | users, tutorial_steps | where-bien-left-thanh-inner |
| jelly-j9-noi-sai-khoa | 3 | M5 | debug | basic | A1 | after_sales | Lượt chơi gặp sự cố bị gắn nhầm phiên | Xét các lượt chơi có `result = 'crash'` và `event_date` là ngày 28/8/2026. · Mỗi lượt chơi thuộc đúng một phiên, ghi ở cột `session_id` của lượt chơi. Sửa truy vấn khởi đầu để mỗi lượt chơi chỉ còn một dòng, đi kèm đúng phiên đó. | level_attempts, sessions | noi-sai-khoa |
| jelly-q1-man-thua-tren-tb | 3 | M6 | write | easy | C3 | operations | Màn nào có tỷ lệ thua cao hơn mức chung của game? | Xét mọi lượt chơi tới hết ngày 29/8/2026. · Tỷ lệ thua của một màn bằng số lượt có `result = 'fail_out_of_moves'` chia tổng số lượt chơi màn đó. | level_attempts, level_metadata | trung-binh-ty-le, sai-mau-so |
| jelly-q2-nguoi-mua-season-pass | 3 | M6 | write | easy | A1 | sales | Người mua Season Pass đến từ đâu? | Xét người chơi có ít nhất một giao dịch `product_type = 'season_pass'`. · Đếm số người chơi như vậy theo thị trường (quốc gia, `users.country`) và kênh thu hút (`users.channel`). | users, purchases | join-dem-trung |
| jelly-q3-choi-d0-tren-tb-29-8 | 3 | M6 | write | basic | C3 | customer | Người cài ngày 29/8 nào chơi lâu hơn mức bình quân? | Xét các dòng `player_daily` của người chơi cài ngày 29/8/2026 (`install_date`), ở chính ngày cài (`cohort_day = 0`). · Mức bình quân là trung bình `playtime_minutes` của chính các dòng này. | player_daily | quen-loc-truy-van-con |
| jelly-q4-ngay-dau-tren-tb-thang | 3 | M6 | write | medium | C3 | customer | Ngày nào DAU cao hơn mức bình quân của tháng? | Xét các ngày từ 1/7/2026 tới hết 29/8/2026 trong bảng chỉ số ngày `daily_kpi`. · DAU (số người chơi hoạt động trong ngày) bình quân của tháng là trung bình cột `dau` của các ngày cùng tháng, trong khoảng ngày trên. | daily_kpi | khong-tuong-quan |
| jelly-q5-roas-duoi-muc-chung | 3 | M6 | write | hard | C3 | finance | Chiến dịch nào thu về trên mỗi đồng chi thấp hơn mức chung? | Xét người chơi cài trong tháng 7/2026 qua kênh trả phí và chi phí quảng cáo tháng 7/2026. · Hiệu quả của một chiến dịch đo bằng ROAS D30 (doanh thu trên chi phí quảng cáo) của người cài từ chiến dịch đó. Mức chung là ROAS D30 của cả … | users, player_daily, campaign_spend | trung-binh-ty-le, fan-out, doanh-thu-ca-ky, gop-organic |
| jelly-q6-nguoi-choi-cu-len-210 | 3 | M6 | write | hard | B4 | operations | Người chơi cũ cập nhật lên bản 2.1.0 nhanh đến đâu? | Xét dữ liệu tới hết ngày 29/8/2026. Bản 2.1.0 phát hành ngày 30/7/2026. · Người chơi cũ là người cài game trên bản 2.0.2 và còn hoạt động ít nhất một ngày từ ngày phát hành bản 2.1.0 tới hết 29/8. Người chơi cũ … | users, player_daily | phien-ban-luc-cai, dem-moi-ngay, bo-qua-ban, mau-so-gom-nguoi-da-nghi |
| jelly-q7-exists-quang-cao | 3 | M6 | debug | easy | A2 | marketing | Đếm người xem quảng cáo có tặng thưởng lại ra số người không xem | Xét người chơi cài từ 1/7/2026 tới hết 31/7/2026. · Sửa truy vấn khởi đầu để đếm người chơi có ít nhất một lần xem quảng cáo `ad_type = 'rewarded'` trong tháng 7/2026, theo kênh thu hút. | users, ad_events | dao-dieu-kien |
| jelly-q8-giao-dich-ngay-gan-nhat-gb | 3 | M6 | debug | basic | A1 | sales | Giao dịch ngày gần nhất ở Anh lại là giao dịch ngày 1/8 | Xét các giao dịch có `country = 'GB'` trong tháng 8/2026. · Kết quả cần mọi giao dịch ở thị trường Anh của ngày muộn nhất trong tháng 8 có giao dịch ở thị trường này. Sửa truy vấn khởi đầu cho đúng. | purchases | sai-ham-gom |
| jelly-q9-not-in-null | 3 | M6 | debug | medium | A2 | sales | Không tìm thấy màn nào chưa từng có giao dịch | Xét mọi màn trong `level_metadata`, mọi giao dịch trong `purchases` và các lượt chơi trong cửa sổ dữ liệu (tới hết 29/8/2026). · Sửa truy vấn khởi đầu để liệt kê đúng các màn không có giao dịch nào gắn với màn đó … | level_metadata, level_attempts, purchases | not-in-null |
| jelly-c5-starter-pack-giu-chan | 3 | case | case | easy | – | customer | Người mua Starter Pack có ở lại lâu hơn? | b1 Số ngày hoạt động của người mua và người không mua; b2 Hai nhóm khác nhau từ ngày cài?; b3 Kết luận | users, player_daily, purchases | b1: noi_giao_dich_dem_trung, moi_nguoi_choi_ca_ky; b2: noi_giao_dich_nhan_dong |
| jelly-c6-kenh-dang-cat | 3 | case | case | medium | – | marketing | Có nên cắt kênh Video Network? | b1 Chi phí, lượt cài và CPI theo kênh tháng 7; b2 Doanh thu 7 ngày đầu trên mỗi lượt cài; b3 ROAS 7 ngày đầu theo kênh; b4 Kết luận | campaign_spend, users, player_daily | b1: noi_truc_tiep_nhan_dong; b2: mau_so_nguoi_co_doanh_thu; b3: doanh_thu_ca_ky |

## Gói 4 · M7 CTE & Set Operations, M8 Window Functions, case c7 (Trung bình), c8 (Khó)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-t1-pheu-huong-dan | 4 | M7 | write | medium | D1 | customer | Người chơi mới bỏ phần hướng dẫn ở bước nào nhiều nhất? | Xét người chơi cài game trong tháng 7/2026 (từ ngày 1 tới hết ngày 31). · Tính số người bắt đầu, số người hoàn thành và tỷ lệ hoàn thành của từng bước hướng dẫn. | users, tutorial_steps | mau-so-buoc-1, quen-can-tren |
| jelly-t2-so-buoc-hoan-thanh | 4 | M7 | write | basic | A3 | customer | Người chơi cài tháng 7 hoàn thành mấy bước hướng dẫn? | Xét người chơi cài game trong tháng 7/2026 (`install_date` từ ngày 1 tới hết ngày 31), dùng bảng `tutorial_steps`. · Đếm số bước đã hoàn thành (`step_completed` = 1) của từng người chơi, rồi đếm số người chơi theo số bước hoàn thành. | tutorial_steps | dem-buoc-bat-dau |
| jelly-t3-mua-tu-3-lan | 4 | M7 | write | basic | C4 | sales | Người chơi nào mua từ ba lần trở lên? | Xét các giao dịch mua trong ứng dụng có `event_date` từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Đếm số giao dịch và cộng tiền (`price_usd`) của từng người chơi; chỉ giữ người chơi có từ 3 giao dịch trở lên. | purchases | lon-hon-thay-lon-hon-bang |
| jelly-t4-kenh-co-va-khong-chi | 4 | M7 | write | medium | E2 | marketing | Người cài và chi phí quảng cáo tháng 7 lệch nhau ở kênh nào? | Xét người chơi đến từ các kênh trả phí (bỏ kênh Organic), cài trong tháng 7/2026, và chi phí quảng cáo có ngày trong tháng 7/2026 (từ ngày 1 tới hết ngày 31). · Một người cài “không có chi phí” khi không có dòng chi … | users, campaign_spend | union-bo-dong-trung, quen-can-tren |
| jelly-t5-doi-soat-kpi | 4 | M7 | write | hard | E2 | finance | Bảng chỉ số ngày có khớp với dữ liệu chi tiết không? | Xét 60 ngày của cửa sổ dữ liệu, từ ngày 1/7/2026 tới hết ngày 29/8/2026. · Từ bảng hoạt động ngày của người chơi (`player_daily`) và bảng người chơi, tính lại bảy chỉ số của từng ngày: DAU, số phiên, tổng thời gian … | player_daily, users, daily_kpi | so-so-le-khong-lam-tron, quen-can-tren |
| jelly-t6-tong-su-co-hai-nguon | 4 | M7 | write | easy | E2 | after_sales | Tổng số sự cố tháng 7 ở hai nguồn có khớp nhau không? | Xét tháng 7/2026, từ ngày 1 tới hết ngày 31. · Đếm số lượt chơi kết thúc vì sự cố trong bảng lượt chơi (`level_attempts`, `result` = `'crash'`, lọc theo `event_date`), và cộng cột `crash_count` của bảng hoạt động ngày … | level_attempts, player_daily | fan-out |
| jelly-t7-union-doanh-thu | 4 | M7 | debug | easy | A3 | finance | Doanh thu tháng 7 theo nguồn bị thiếu tiền | Truy vấn dưới đây cộng doanh thu IAP và doanh thu quảng cáo tháng 7/2026 theo nền tảng, nhưng ra thấp hơn thực tế. · Sửa để mọi giao dịch và mọi lần xem quảng cáo trong tháng đều được cộng. | purchases, ad_events | union-khu-trung |
| jelly-t8-cte-loc-sai-cho | 4 | M7 | debug | easy | D2 | customer | Tỷ lệ giữ chân D7 theo phiên bản cài thấp bất thường | Truy vấn dưới đây tính tỷ lệ giữ chân D7 theo phiên bản lúc cài (`users.app_version_install`), nhưng ra thấp bất thường. · Tỷ lệ giữ chân D7 của một phiên bản bằng số người cài tới hết ngày 22/8/2026 có hoạt động đúng ngày thứ 7 sau ngày cài … | users, player_daily | mau-so-thieu-loc |
| jelly-t9-ab-itt | 4 | M7 | debug | hard | C3 | marketing | Kết quả A/B chỉ tính người đã gặp ưu đãi | Truy vấn dưới đây so hai nhánh của thử nghiệm `extra_moves_offer_timing` theo tỷ lệ người mua gói `extra_moves_pack` trong 7 ngày đầu. D0 là ngày được chia nhánh, nên 7 ngày đầu là D0 tới D6. Chỉ xét người được chia … | ab_assignments, purchases | chi-tinh-nguoi-tiep-xuc, cua-so-d0-6 |
| jelly-f1-top3-man-quit | 4 | M8 | write | medium | C1 | operations | Ba màn người chơi bỏ cuộc nhiều nhất ở mỗi thế giới | Xét mọi lượt chơi trong cửa sổ dữ liệu. Lượt bỏ cuộc là lượt có `result` = `'quit'`. Câu này xếp theo số lượt bỏ cuộc, không theo tỷ lệ bỏ cuộc. · Đếm số lượt bỏ cuộc của từng màn, xếp hạng các màn trong từng thế giới, … | level_attempts | trung-hang, thieu-partition |
| jelly-f2-dau-trot-7-ngay | 4 | M8 | write | easy | B3 | customer | DAU trung bình trượt 7 ngày | Xét 60 ngày của cửa sổ dữ liệu, từ ngày 1/7/2026 tới hết ngày 29/8/2026, dùng cột `dau` của bảng chỉ số ngày (`daily_kpi`). · Tính DAU trung bình của 7 ngày gần nhất tính tới từng ngày, gồm chính ngày đó và 6 ngày liền … | daily_kpi | khung-cua-so, quen-can-tren |
| jelly-f3-luy-ke-chi-mot-chien-dich | 4 | M8 | write | basic | B3 | marketing | Chi quảng cáo luỹ kế tháng 7 của Video Network ở Việt Nam | Xét các dòng chi phí của chiến dịch `campaign_id` = `'JTA-VIDEO-330'`, thị trường `country` = `'VN'`, nền tảng nhắm tới `target_platform` = `'Android'`, có ngày trong tháng 7/2026 … · Với mỗi ngày, tính tổng chi từ đầu tháng tới hết ngày đó (cộng dồn). | campaign_spend | cua-so-thieu-order-by |
| jelly-f4-doanh-thu-tuan-wow | 4 | M8 | write | hard | B2 | finance | Doanh thu tuần này so với tuần trước | Tuần tính từ thứ Hai tới Chủ nhật. Chỉ xét các tuần có đủ 7 ngày nằm trong cửa sổ dữ liệu (1/7/2026 tới hết 29/8/2026). · Doanh thu tuần là tổng doanh thu IAP và doanh thu quảng cáo của bảng chỉ số ngày (`daily_kpi`). | daily_kpi | tuan-khong-tron, lag-truoc-khi-loc |
| jelly-f5-chuoi-ngay-lien-tiep | 4 | M8 | write | hard | D3 | customer | Ai có chuỗi ngày chơi liên tiếp dài nhất? | Xét các ngày có hoạt động trong cửa sổ dữ liệu, từ 1/7/2026 tới hết 29/8/2026. · Chuỗi là các ngày hoạt động liền nhau, không bỏ ngày nào. Tìm chuỗi dài nhất của từng người chơi; nếu có nhiều chuỗi cùng dài nhất thì … | player_daily | dem-tong-ngay |
| jelly-f6-chia-4-nhom-ngay-dau | 4 | M8 | write | basic | C4 | customer | Chia các ngày tháng 8 thành bốn nhóm theo số người chơi | Xét các ngày từ 1/8/2026 tới hết ngày 29/8/2026 trong bảng chỉ số ngày (`daily_kpi`), dùng cột `dau`. · Chia các ngày thành 4 nhóm có số ngày chênh nhau không quá 1, theo `dau` giảm dần … | daily_kpi | chieu-sap-xep |
| jelly-f7-rank-thay-row-number | 4 | M8 | debug | easy | C1 | operations | Ba màn gặp sự cố nhiều nhất lại thành năm màn | Truy vấn dưới đây xếp hạng các màn trong từng thế giới theo số lượt chơi kết thúc vì sự cố, nhưng có thế giới trả về hơn 3 màn. · Sửa để mỗi thế giới có đúng 3 màn, `hang` là 1, 2, 3; hai màn bằng số lượt thì màn có … | level_attempts | trung-hang |
| jelly-f8-lag-khong-partition | 4 | M8 | debug | easy | B2 | customer | Khoảng cách giữa hai ngày chơi bị âm | Với người chơi cài ngày 3/7/2026, truy vấn dưới đây tính số ngày từ ngày hoạt động liền trước tới mỗi ngày hoạt động của chính người đó (xét tới hết ngày 29/8/2026), rồi đếm mỗi khoảng cách xuất hiện bao nhiêu lần. · … | player_daily | thieu-partition, quen-can-tren |
| jelly-f9-ty-trong-goi | 4 | M8 | debug | medium | C2 | sales | Tỷ trọng doanh thu từng gói không cộng ra 100% | Truy vấn dưới đây tính doanh thu IAP của từng gói vật phẩm trong tháng 8/2026 (tới hết ngày 29/8) và tỷ trọng của gói trên tổng doanh thu IAP của tháng. · Sửa để tỷ trọng các gói cộng lại bằng 100%. | purchases | sai-pham-vi-cua-so, quen-can-tren |
| jelly-c7-android-210 | 4 | case | case | medium | – | operations | Người chơi Android dùng bản 2.1.0 gặp khó ở đâu? | b1 Bước dùng búa kẹo theo phiên bản và nền tảng; b2 Tỷ lệ thắng màn 28–30; b3 Tỷ lệ giữ chân D1 theo phiên bản lúc cài; b4 Kết luận | tutorial_steps, level_attempts, player_daily, users | b1: mau_so_la_buoc_1; b2: mau_so_bo_luot_su_co; b3: mau_so_tu_bang_hoat_dong |
| jelly-c8-doanh-thu-giam-vi-dau | 4 | case | case | hard | – | finance | Doanh thu tuần 10/8 giảm do ít người chơi hay chi ít? | b1 Doanh thu hai tuần theo nguồn; b2 DAU và ARPDAU của hai tuần; b3 Ít người trả tiền hơn hay mỗi người trả tiền chi ít hơn?; b4 Tách chênh lệch doanh thu; b5 Kết luận | daily_kpi, player_daily | b1: tuan_bat_dau_chu_nhat; b2: trung_binh_cot_arpdau; b3: dem_nguoi_khac_nhau; b4: doi_goc_tach |

## Gói 5 · M9 Data Quality, M10 Query Performance, case c9–c10 (Khó)

| Mã | Gói | Module | Hình thức | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng dùng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| jelly-k1-phien-ghi-hai-lan | 5 | M9 | write | basic | E1 | operations | Phiên chơi nào bị ghi hai lần? | Một phiên bị ghi lặp khi cùng `user_id` và cùng `session_start` xuất hiện ở từ 2 dòng trở lên trong `sessions`, dù `session_id` khác nhau. · Trả về `user_id`, `session_start`, `so_dong` (v4: hạ từ medium, mã cũ `jelly-k1-trung-khoa`) | sessions | khoa-ky-thuat |
| jelly-k2-mo-coi | 5 | M9 | write | medium | E2 | operations | Giao dịch mua trong màn nào không có lượt chơi màn đó? | Chỉ xét giao dịch có `level_id_if_relevant` (mua khi đang ở một màn). · Một giao dịch thiếu lượt chơi khi trong cùng `session_id` không có lượt chơi nào có `level_id` bằng `level_id_if_relevant` của giao dịch. | purchases, level_attempts | fan-out, noi-thieu-cot, inner-join |
| jelly-k3-cohort-day-kiem | 5 | M9 | write | easy | E2 | customer | Số ngày kể từ lúc cài có được tính đúng? | Nối mỗi dòng `player_daily` với người chơi trong `users` theo `user_id`. · Trả về một dòng ba cột: `so_dong_kiem`; `so_lech_ngay_cai`; `so_lech_cohort_day` (v4: hạ từ medium, bỏ cột luôn 0 và bảng nhiễu) | player_daily, users | datediff-dao-doi-so |
| jelly-k4-max-level-giam | 5 | M9 | write | medium | E1 | operations | Màn cao nhất trong ngày có lúc giảm không? | So `max_level` của mỗi ngày hoạt động với ngày hoạt động liền trước của cùng người chơi (ngày gần nhất trước đó có dòng, không nhất thiết là hôm trước). · Trả về một dòng: `so_ngay_nguoi_giam` (số dòng có `max_level` … | player_daily | hieu-sai-cot-luy-ke, lag-thieu-partition |
| jelly-k5-extra-moves-doi-soat | 5 | M9 | write | hard | E2 | sales | Mua thêm lượt đi ở ba nguồn có khớp nhau? | Xét tháng 8/2026 (dữ liệu tới hết ngày 29/8). Mỗi ngày có lượt chơi là một dòng. · Trả về `ngay`; `so_luot_nhan_them` (tổng cờ `extra_moves_purchased` trên các lượt chơi); `so_luot_bang_ngay` (tổng … | level_attempts, player_daily, purchases | co-khong-phai-giao-dich, fan-out, quen-can-tren |
| jelly-k6-quang-cao-bang-ngay | 5 | M9 | write | easy | E2 | finance | Ngày nào doanh thu quảng cáo trên bảng chỉ số ngày bị lệch? | Xét các ngày từ 1/7 tới hết 29/8/2026. Doanh thu tính lại của một ngày là tổng `ad_events.revenue_usd` của các lần xem có `event_date` là ngày đó, làm tròn 2 chữ số. · Chỉ giữ ngày có `daily_kpi.ad_revenue` khác doanh thu tính lại (v4: hạ từ hard, mã cũ `jelly-k6-ad-revenue-lam-tron`) | daily_kpi, ad_events | so-bang-dau-bang-so-le |
| jelly-k7-dau-doi-soat-phien | 5 | M9 | debug | easy | E2 | customer | Số người chơi hoạt động tính lại lệch bảng chỉ số ngày | Xét các ngày từ 1/7 tới hết 7/7/2026. DAU tính lại của một ngày là số người chơi khác nhau có ít nhất một phiên trong `sessions` với `event_date` là ngày đó. · Truy vấn dưới đây cần trả về mỗi ngày một dòng … (v4: hạ từ medium, mã cũ `jelly-k7-bat-thuong-chi`) | daily_kpi, sessions | dem-dong-thay-nguoi |
| jelly-k8-thuan-ra-0 | 5 | M9 | debug | basic | E2 | after_sales | Doanh thu thuần tháng 7 ra 0 | Truy vấn dưới đây tính cho các giao dịch tháng 7/2026: `so_giao_dich`, `doanh_thu_gop_usd`, `doanh_thu_thuan_usd` (tổng `price_usd` của các giao dịch không hoàn tiền). · Cột `doanh_thu_thuan_usd` đang ra 0 (v4: hạ từ medium, mã cũ `jelly-k8-hoan-tien`) | purchases | sai-gia-tri-loc |
| jelly-k9-phien-hai-dang-ma | 5 | M9 | debug | hard | E1 | operations | Không người chơi mới nào bắt đầu bằng phần hướng dẫn? | Người chơi cài trong tháng 7/2026 (1/7 tới hết 31/7). Phiên đầu tiên của một người là phiên có `session_start` sớm nhất của người đó. · Một người “vào thẳng phần hướng dẫn” khi phiên đầu tiên của người đó có … | sessions, users | ma-phien-hai-dang, quen-can-tren |
| jelly-p1-dem-ket-qua-mot-lan | 5 | M10 | optimize | easy | A3 | operations | Kết quả lượt chơi màn 28–30 trong tháng 8 | Giữ nguyên kết quả: mỗi màn 28, 29, 30 một dòng, đếm lượt chơi tháng 8/2026 (tới hết ngày 29/8) theo từng kết quả; trả về `level_id`, `so_thang`, `so_thua`, `so_bo_cuoc`, `so_su_co`; sắp theo `level_id`. | level_attempts | quet-lai-bang |
| jelly-p2-doanh-thu-hai-nguon | 5 | M10 | optimize | easy | A3 | finance | Doanh thu quảng cáo theo nền tảng và định dạng chỉ với một lần quét | Giữ nguyên kết quả: `platform`, `ad_type`, `so_luot_xem`, `doanh_thu_usd` (làm tròn 2 chữ số) cho các lần xem quảng cáo tháng 7/2026; sắp theo `platform`, `ad_type`. | ad_events | union-all-lap |
| jelly-p3-tren-tb-the-gioi | 5 | M10 | optimize | hard | C3 | operations | Màn có tỷ lệ thua cao hơn mặt bằng thế giới chứa màn | Giữ nguyên kết quả: các màn có tỷ lệ thua (tháng 7/2026) cao hơn trung bình thế giới, trong đó trung bình thế giới là bình quân giản đơn tỷ lệ thua của các màn trong thế giới đó. · Trả về `world_name`, `level_id`, … | level_attempts | tinh-lai-hai-lan, trung-binh-sai-nhom |
| jelly-p4-luy-ke-tu-noi | 5 | M10 | optimize | hard | B3 | finance | Doanh thu luỹ kế trong tháng cho biểu đồ tiến độ | Giữ nguyên kết quả: mỗi ngày từ 1/7 tới hết 29/8/2026 một dòng: `ngay`, `doanh_thu` (`iap_revenue + ad_revenue`), `luy_ke_thang` (cộng dồn từ ngày đầu tháng tới ngày đó); sắp theo `ngay`. | daily_kpi | tu-noi-bang, quen-can-tren |
| jelly-p5-nguoi-tra-tien-exists | 5 | M10 | optimize | medium | A2 | sales | Đếm người chơi trả tiền theo kênh cho nhẹ hơn | Giữ nguyên kết quả: `channel`, `so_nguoi_tra_tien` (người có ít nhất một giao dịch từ 1/7 tới hết 29/8/2026); sắp `so_nguoi_tra_tien` giảm dần, bằng nhau thì `channel` theo thứ tự chữ cái. | users, purchases | noi-bang-nhan-dong |
| jelly-p6-d1-d3-d7-mot-lan-quet | 5 | M10 | optimize | basic | D2 | customer | Số người còn chơi D1, D3, D7 chỉ với một lần quét | Giữ nguyên kết quả: một dòng, ba cột `so_con_d1`, `so_con_d3`, `so_con_d7` là số người chơi cài từ 1/7 tới hết 7/7/2026 có hoạt động đúng vào ngày thứ 1, thứ 3, thứ 7 kể từ ngày cài (v4: hạ từ medium, mã cũ `jelly-p6-dau-tu-sessions`) | player_daily | quet-lai-bang |
| jelly-p7-index-ngay | 5 | M10 | optimize | easy | A2 | operations | Màn được chơi nhiều nhất ngày 10/8, đọc ít dòng nhất | Giữ nguyên kết quả: các lượt chơi ngày 10/8/2026 gom theo màn: `level_id`, `so_luot`, `so_thang`, `ty_le_thang_pct` (2 chữ số); 10 màn có `so_luot` lớn nhất, bằng nhau thì `level_id` nhỏ hơn trước. | level_attempts | ham-tren-cot, between-datetime, thieu-can-tren |
| jelly-p8-moc-dau-dot-su-kien | 5 | M10 | debug | basic | A2 | customer | Hoạt động trong đợt Licorice Rescue thấp hơn bản cũ | Đợt Licorice Rescue chạy từ ngày 8/8 tới hết ngày 12/8/2026, gồm cả hai ngày đầu và cuối. · Truy vấn dưới đây cần trả về một dòng: `so_ngay_nguoi`, `so_phien` (v4: hạ từ hard, mã cũ `jelly-p8-ham-tren-cot`) | player_daily | sai-toan-tu |
| jelly-p9-select-distinct-thua | 5 | M10 | optimize | medium | C4 | finance | Báo cáo phân khúc người chơi theo mức chi chạy nhẹ hơn | Giữ nguyên kết quả: mọi người chơi trong `users` chia theo tổng chi (tổng `price_usd` từ 1/7 tới hết 29/8/2026) thành `'khong_chi'` (bằng 0), `'duoi_5'` (dưới 5 USD), `'tu_5_den_20'` (từ 5 tới 20 USD), `'tren_20'` … | users, purchases | distinct-thua, inner-join-mat-nhom, loc-o-where |
| jelly-c9-ab-mua-them-buoc | 5 | case | case | hard | – | marketing | Đưa ưu đãi thêm lượt đi sớm hơn có đáng không? | b1 Cỡ mẫu của hai nhánh; b2 Chỉ số chính trên mọi người được chia; b3 Doanh thu IAP D0–D6 trên mỗi người; b4 Chỉ số bảo vệ: giữ chân D7; b5 Kết luận | ab_assignments, level_attempts, purchases, player_daily | b1: dem_tiep_xuc_bang_is_null; b2: chi_tinh_nguoi_da_tiep_xuc, dem_giao_dich_goi_thay_co; b3: mau_so_nguoi_tra_tien; b4: gom_ca_nguoi_chua_du_ngay |
| jelly-c10-man-28-30 | 5 | case | case | hard | – | after_sales | Bản 2.1.1 đã sửa xong màn 28–30 chưa? | b1 Tỷ lệ thắng màn 28–30 theo phiên bản và nền tảng; b2 Tỷ lệ thua và bỏ cuộc; b3 Lượt chơi được mời thêm lượt đi; b4 Giữ chân D1 theo phiên bản lúc cài; b5 Kết luận | level_attempts, users, player_daily | b1: phien_ban_luc_cai; b4: mau_so_tu_bang_hoat_dong |

## Thống kê (đếm từ bảng trên)

**Hình thức:** write 54 · debug 28 · optimize 8 · case 10 = 100. **Cấp:** basic 14 · easy 35 · medium 36 · hard 15.

### Hình thức × cấp

| Hình thức | basic | easy | medium | hard | Cộng |
|---|---:|---:|---:|---:|---:|
| write | 8 | 20 | 20 | 6 | 54 |
| debug | 3 | 10 | 11 | 4 | 28 |
| optimize | · | 3 | 3 | 2 | 8 |
| case | 3 | 2 | 2 | 3 | 10 |
| **Cộng** | 14 | 35 | 36 | 15 | 100 |

### Theo module: cấp và hình thức

| Module | basic | easy | medium | hard | write | debug | optimize | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| M1 Retrieval | 5 | 4 | · | · | 6 | 3 | · | 9 |
| M2 NULL & Expressions | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M3 String & Date | 3 | 6 | · | · | 6 | 3 | · | 9 |
| M4 Aggregation | · | 6 | 3 | · | 6 | 3 | · | 9 |
| M5 Joins | · | 4 | 5 | · | 6 | 3 | · | 9 |
| M6 Subqueries | · | 3 | 6 | · | 6 | 3 | · | 9 |
| M7 CTE & Set Operations | · | 1 | 4 | 4 | 6 | 3 | · | 9 |
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
| 4 | 12 | 6 | · | 2 | · | 1 | 12 | 7 |
| 5 | 6 | 4 | 8 | 2 | · | 3 | 9 | 8 |

### Phủ dạng × mảng (90 câu module; case không tính)

| Dạng | customer | sales | marketing | operations | finance | after_sales | Cộng |
|---|---:|---:|---:|---:|---:|---:|---:|
| A1 Tra cứu lọc | 2 | 6 | 2 | 7 | · | 1 | 18 |
| A2 KPI | 3 | 5 | 1 | 2 | 5 | 1 | 17 |
| A3 Phân rã | 1 | 2 | 3 | 5 | 2 | 1 | 14 |
| A4 Bảng chéo | · | · | · | · | · | · | 0 |
| B1 Xu hướng | 2 | · | · | · | 2 | · | 4 |
| B2 So kỳ trước | 1 | · | · | · | 1 | · | 2 |
| B3 Luỹ kế, trượt | 1 | · | 1 | · | 1 | · | 3 |
| B4 Trạng thái tại thời điểm | · | · | 1 | 1 | · | · | 2 |
| C1 Top N mỗi nhóm | · | 1 | · | 2 | · | · | 3 |
| C2 Tỷ trọng | · | 1 | · | · | · | · | 1 |
| C3 So với chuẩn | 2 | · | 2 | 2 | 1 | · | 7 |
| C4 Phân khúc | · | · | · | · | 1 | · | 1 |
| D1 Phễu | 2 | · | · | · | · | · | 2 |
| D2 Cohort | 3 | · | · | · | · | · | 3 |
| D3 Chuỗi liên tiếp | 1 | · | · | · | · | · | 1 |
| E1 Bất thường | 1 | · | 1 | 2 | · | · | 4 |
| E2 Đối soát | 1 | 1 | 1 | 1 | 2 | 2 | 8 |
| E3 Cấu trúc cây | · | · | · | · | · | · | 0 |
| **Cộng** | 20 | 16 | 12 | 22 | 15 | 5 | 90 |

Dạng có câu: 16/18; chưa có: A4, E3; chỉ 1 câu: C2, C4, D3.

Mảng trên cả 100 câu (gồm case): customer 21, sales 17, marketing 15, operations 24, finance 17, after_sales 6.

### Kiểm khung phân bổ

Lệch khung (module 9 câu: M1–M9 6 write + 3 debug, M10 ~6 optimize; cấp M1–3 basic/easy, M4–6 easy/medium, M7–10 medium/hard; case gói 1 → 5: basic+basic, basic+easy, easy+medium, medium+hard, hard+hard):

- `jelly-p1-dem-ket-qua-mot-lan` (M10) cấp easy, ngoài khung medium / hard.
- `jelly-p2-doanh-thu-hai-nguon` (M10) cấp easy, ngoài khung medium / hard.
- `jelly-t7-union-doanh-thu` (M7) cấp easy (v3, chấm lại theo QUYET-DINH-CHUNG 2.3 mục 7: quy chuẩn không gắn cấp với module).
- `jelly-p7-index-ngay` (M10) cấp easy, ngoài khung medium / hard.

Ô dạng × mảng × cấp × hình thức trùng **trong cùng một gói**: 
- C3 · finance · medium · write: `jelly-q5-roas-tren-chuan`; C3 · marketing · medium · write: `jelly-j4-cpi-theo-kenh` (v3 đổi mảng)

Ô trùng **giữa các gói** (10 ô; cho phép, ghi để tham khảo): 
- A1 · operations · basic · write: (v4 gói 1: `jelly-r3` đổi sang `jelly-r3-luot-bat-thuong-volcano`, A1 · after_sales · hard · write; ô này nay chỉ còn `jelly-s2-tach-the-gioi`)
- A1 · operations · easy · write: `jelly-r5-luot-dai-man-30`, `jelly-s5-phien-ban-dang-chuoi`, `jelly-j1-luot-choi-kem-the-gioi`
- A1 · operations · easy · debug: (v4 gói 1: `jelly-r9` đổi sang `jelly-r9-phien-ios-ban-cu`, A1 · operations · hard · debug; ô này nay chỉ còn `jelly-s8-gio-chua-doi`)
- A3 · operations · easy · write: `jelly-n3-nhom-luot-di-du`, `jelly-j5-booster-theo-the-gioi`
- A1 · sales · easy · write: `jelly-s4-ngay-tu-cai-den-mua`, `jelly-q2-nguoi-mua-season-pass`
- A2 · finance · easy · debug: (v4 gói 1: `jelly-n8` đổi sang `jelly-n8-ty-le-su-co-tron-chuc`, B1 · after_sales · hard · debug; ô này nay chỉ còn `jelly-j7-join-nhan-dong`)
- A3 · marketing · easy · write: `jelly-a3-chi-theo-kenh`, `jelly-j2-doanh-thu-theo-kenh-cai`
- D1 · customer · medium · write: `jelly-q3-chua-qua-buoc-4`, `jelly-t1-pheu-huong-dan`
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
- `jelly-f6-chia-4-nhom-chi`: cấp hard → medium
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
