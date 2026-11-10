# Bộ chuẩn giọng văn và thuật ngữ · câu hỏi SQL Leaderboard trên bộ dữ liệu GAME Jelly Trail Academy

Bản nháp 1 · 10/11/2026 · chờ giảng viên duyệt.

Áp dụng cho mọi phần chữ của một câu thuộc bộ `jelly` (game giải đố ghép kẹo trên di động, phân tích sản phẩm số): `\tieude`,
`\boicanh`, `yeucau`, `rangbuoc`, `nghiepvu`, `\goiy`, `\phuongan`, `\khaibaokhainiem`, `\ghichuthietke`. Cấu trúc dữ liệu, cửa sổ
thời gian và bẫy: `mysql/README-jelly.md`. Bản đồ câu: `goi-cau-hoi/jelly/BAN-DO-100-CAU.md`.

Thứ tự ưu tiên khi các nguồn mâu thuẫn:
1. Quyết định của giảng viên ở `STYLE-GUIDE-luyen-sql.md` mục H và `STYLE-scm.md` mục G (kế thừa: giọng văn, khuôn cấm, cách gọi kỹ thuật SQL).
2. Tài liệu dự án Game: Blueprint, giới thiệu dataset, bộ câu hỏi (mã BP, DI, Q). Học viên học theo các tài liệu này, nên chỗ nào giáo trình dùng khác thì giữ từ dự án và ghi chú.
3. Văn bản pháp quy (Nghị định 147/2024/NĐ-CP) cho khái niệm vật phẩm ảo, đơn vị ảo, điểm thưởng.
4. Bài báo, tài liệu của trường đại học Việt Nam (UEH, ĐH Thương mại, ĐH Mở TP.HCM, FPT) và cổng cơ quan nhà nước.
5. Giao diện tiếng Việt chính thức của công cụ ngành (Google Analytics, AdMob, Play Console) cho thuật ngữ chưa có trong giáo trình.

---

## 0. Nguồn và mã viết tắt

| Mã | Tài liệu | Trạng thái |
|---|---|---|
| BP | `Project DA/Game/Blueprint_Jelly_Trail_Academy_v2.md` (Blueprint dashboard, bản v2 45 ngày; bộ MySQL là v3 60 ngày) | đọc trực tiếp |
| DI | `Project DA/Game/dataset_intro_nebula_quest.md` (giới thiệu dataset cùng khuôn: Activity → Activation → Retention → Monetization → Product Health) | đọc trực tiếp |
| Q | `Project DA/Game/Question.md` (10 câu hỏi nghiệp vụ Q1–Q10) | đọc trực tiếp |
| DB | Schema `jelly_analytics` của `candy_game` (chỉ đọc, 10/11/2026) và MySQL `jelly` | kiểm bằng truy vấn, số ở README-jelly.md |
| NĐ147 | Nghị định 147/2024/NĐ-CP về quản lý, cung cấp, sử dụng dịch vụ Internet và thông tin trên mạng. Điều 3 k38 (đơn vị ảo): https://hethongphapluat.com/nghi-dinh-147-2024-nd-cp-quan-ly-cung-cap-su-dung-dich-vu-internet-va-thong-tin-tren-mang/dieu-3/khoan-38 ; k39 (vật phẩm ảo): …/dieu-3/khoan-39 ; k40 (điểm thưởng): …/dieu-3/khoan-40 ; k41 (hỗ trợ thanh toán trong trò chơi): …/dieu-3/khoan-41 ; Điều 57: …/dieu-57 | mở được (trang tổng hợp luật; cần đối chiếu bản Công báo) |
| LVN | LuatVietnam, "Trò chơi điện tử là gì" (dẫn NĐ147 Đ37: nhóm G1–G4). https://luatvietnam.vn/linh-vuc-khac/tro-choi-dien-tu-la-gi-883-95390-article.html | mở được |
| TCNH | Tạp chí Ngân hàng, "Tiền ảo, tài sản ảo vẫn nằm ngoài sự điều chỉnh của pháp luật". https://tapchinganhang.gov.vn/tien-ao-tai-san-ao-van-nam-ngoai-su-dieu-chinh-cua-phap-luat-6917.html | chỉ thấy ở kết quả tìm kiếm |
| TMU | Vũ Thị Thanh Huyền (ĐH Thương mại), "Tổng quan về kế toán khách hàng…", Tạp chí Công Thương 2021. https://tapchicongthuong.vn/tong-quan-ve-ke-toan-khach-hang-tren-the-gioi-va-kinh-nghiem-cho-cac-doanh-nghiep-viet-nam-80351.htm | mở được |
| UEH-CLV | UEH (Viện ATD), "Cách đo lường và tăng giá trị vòng đời khách hàng (CLV)". https://atd.ueh.edu.vn/cach-do-luong-va-tang-gia-tri-vong-doi-khach-hang-clv-bi-quyet-giu-chan-toi-uu-loi-nhuan-a259.html | mở được |
| UEH-RET | UEH (Viện ATD), webinar "Vì sao người dùng quay lại mỗi ngày: core loop và thiết kế dữ liệu retention". https://atd.ueh.edu.vn/series-webinar-data-driven-insight-chuyen-de-3-vi-sao-nguoi-dung-quay-lai-moi-ngay-giai-ma-core-loop-va-thiet-ke-du-lieu-retention-a534.html | mở được |
| DHM-1 | Tạp chí Khoa học ĐH Mở TP.HCM, Kinh tế và Quản trị kinh doanh, 2025 (tác giả UEH), khách hàng rời bỏ. https://vjol.info.vn/DHM-KTQTKD/article/view/136523 | mở được |
| DHM-2 | Tạp chí Khoa học ĐH Mở TP.HCM, 2025 (tác giả ĐH Quốc tế, ĐHQG TP.HCM), ý định mua hàng hoá ảo trong game. https://vjol.info.vn/DHM-KTQTKD/article/view/117709 | mở được |
| KTDB | Tạp chí Kinh tế và Dự báo, "Dự đoán tỷ lệ rời bỏ dịch vụ thẻ tín dụng…". https://kinhtevadubao.vn/du-doan-ty-le-roi-bo-dich-vu-the-tin-dung-trong-nganh-ngan-hang-bang-cac-mo-hinh-hoc-may-31553.html | chỉ thấy ở kết quả tìm kiếm |
| FPT | FPT Skillking, "A/B testing". https://skillking.fpt.edu.vn/tin-tuc/ab-testing/ | mở được |
| MST | Cổng Bộ KH&CN, thị trường viễn thông di động (ARPU). https://mst.gov.vn/xu-the-dich-chuyen-cua-thi-truong-vien-thong-di-dong-viet-nam-tu-nha-mang-toi-nha-cung-cap-dich-vu-197101106.htm | mở được |
| GA-STK | Google Analytics, "Sự gắn bó của người dùng" (DAU, MAU, giữ chân). https://support.google.com/analytics/answer/12993725?hl=vi | mở được |
| GA-ENG | Google Analytics, tỷ lệ tương tác, phiên. https://support.google.com/analytics/answer/12195621?hl=vi | mở được |
| GA-COH | Google Analytics, khám phá nhóm thuần tập. https://support.google.com/analytics/answer/9670133?hl=vi | mở được |
| GA-ACQ | Google Analytics, thu nạp người dùng. https://support.google.com/analytics/answer/14731736?hl=vi | mở được |
| ADM-COH | AdMob, báo cáo nhóm thuần tập, giá trị vòng đời. https://support.google.com/admob/answer/9736628?hl=vi | mở được |
| ADM-FMT | AdMob, định dạng quảng cáo (có tặng thưởng, xen kẽ). https://support.google.com/admob/answer/6128738?hl=vi | mở được |
| PLAY-ACQ | Play Console, báo cáo thu nạp, lượt cài đặt, tỷ lệ chuyển đổi. https://support.google.com/googleplay/android-developer/answer/6263332?hl=vi | mở được |
| PLAY-VIT | Play Console, Android vitals, tỷ lệ sự cố. https://support.google.com/googleplay/android-developer/answer/7385505?hl=vi | mở được |
| TT26 | Tuổi Trẻ 28/5/2026 (dẫn Adjust): giữ chân, phiên, IAP, lượt cài đặt. https://tuoitre.vn/voi-1-29-ti-luot-tai-nguoi-dung-viet-choi-game-di-dong-nhieu-va-lau-hang-dau-khu-vuc-20260528141837525.htm | mở được |
| ADP | Adapty docs tiếng Việt, ARPPU. https://adapty.io/docs/vi/arppu | mở được (nguồn nhà cung cấp) |

Không tìm được giáo trình đại học Việt Nam bản trực tuyến định nghĩa DAU/MAU, ARPPU, ARPDAU, CPI, ROAS, cohort, funnel, LiveOps, crash rate,
rewarded/interstitial ads (xem mục F.1). Các từ này **giữ tiếng Anh**, giải nghĩa tiếng Việt ở lần đầu trong mỗi câu, theo cách gọi của
giao diện tiếng Việt Google (GA, AdMob, Play Console) và tài liệu dự án.

---

## A. Bảng thuật ngữ

Quy ước (kế thừa STYLE-scm mục A):
- Cột "Dùng" là đúng chữ cần viết. Thuật ngữ giữ tiếng Anh thì giải nghĩa ở lần đầu trong mỗi câu: "DAU (số người chơi hoạt động trong ngày)".
- Tên bảng, cột trong `\code{}`; giá trị chuỗi trong nháy đơn: `\code{'complete'}`, `\code{'Android'}`.
- Alias cột kết quả: tiếng Việt không dấu theo cột "Dùng": `so_nguoi_choi`, `ty_le_giu_chan_d7_pct`, `doanh_thu_iap`, `arpdau`, `cpi`.
- Người dùng của game gọi là **người chơi** (không "user", không "game thủ" trong đề; DHM-2 dùng "game thủ" cho văn phong báo chí).

### A.1 Người chơi, hoạt động và giữ chân (mảng `customer`)

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| user, player; `user_id` | người chơi; mã người chơi | user, khách hàng, game thủ, thuê bao | DHM-2 "game thủ" (báo chí) | DI; DB; NĐ147 Đ57 "người chơi" |
| install; `install_date` | lượt cài đặt; ngày cài (đặt) | tải về, đăng ký | Play Console "lượt cài đặt" | PLAY-ACQ; TT26; DB |
| new users; `daily_kpi.new_users` | người chơi mới (trong ngày) | user mới, khách mới | = số người có `install_date` là ngày đó | DB; BP |
| active user | người chơi hoạt động | người dùng active | có ≥ 1 dòng `player_daily` trong ngày | GA-STK |
| DAU; `dau` | DAU (số người chơi hoạt động trong ngày) | lượt truy cập, traffic | GA: "Số người dùng hoạt động hằng ngày (DAU)" | GA-STK; Q1 |
| WAU / MAU | WAU, MAU (số người chơi hoạt động trong 7 ngày, trong tháng) | | MAU tháng 8 chỉ có 29 ngày | GA-STK |
| stickiness (DAU/MAU) | mức độ gắn bó (DAU trên MAU) | độ dính | GA: "Sự gắn bó của người dùng" | GA-STK |
| engagement | mức độ tương tác; mức độ gắn kết | engagement trong văn | UEH: "mức độ gắn kết của người dùng" | GA-ENG; UEH-RET |
| session; `sessions` | phiên chơi; phiên | lượt truy cập, lần vào | GA: "phiên" | GA-ENG; TT26; DB |
| session length; `duration_minutes` | thời lượng phiên (phút) | độ dài session | | BP 4.1; DB |
| playtime; `playtime_minutes` | thời gian chơi (phút) | playtime trong văn | `player_daily.playtime_minutes` = tổng `duration_minutes` của phiên trong ngày | BP; DB |
| `entry_screen` | màn hình vào game | màn hình chính (chỉ là giá trị `'home'`) | 5 giá trị home, map, event, shop, tutorial | DB |
| cohort | nhóm cài đặt (cohort); nhóm thuần tập | khối, đoàn hệ | GA, AdMob: "nhóm thuần tập"; đề dùng "nhóm người chơi cài cùng ngày (cohort)" | GA-COH; ADM-COH; UEH-RET |
| cohort day; `cohort_day` | số ngày kể từ ngày cài (D0, D1, …) | tuổi người chơi | D0 là ngày cài | DB; BP |
| retention rate; D1/D7 | tỷ lệ giữ chân D1, D7 | tỷ lệ duy trì, tỷ lệ quay lại D7 trong văn chung | TMU, UEH "tỷ lệ giữ chân khách hàng"; GA "tỷ lệ giữ chân người dùng"; D7 = có hoạt động đúng ngày thứ 7 | TMU; GA-STK; UEH-RET; Q5 |
| rolling / unbounded retention | giữ chân "từ ngày N trở đi" | | chỉ dùng khi đề định nghĩa rõ; mặc định là "đúng ngày N" | DB |
| mature cohort | nhóm cài đã đủ ngày quan sát | cohort chín | D7 cần cài ≤ 2026-08-22 | BP 5.5; DB |
| churn; churn rate | rời bỏ; tỷ lệ rời bỏ | tỷ lệ bỏ game, rơi rụng | UEH, KTDB, DHM-1 "tỷ lệ rời bỏ" | UEH-CLV; KTDB; DHM-1 |
| churned player | người chơi rời bỏ (không hoạt động N ngày liên tiếp) | người chơi chết | đề phải nêu N | UEH-CLV |
| reactivation | quay lại sau thời gian nghỉ | hồi sinh | | — |
| streak | chuỗi ngày chơi liên tiếp | streak trong văn | | DB |
| activation; onboarding | kích hoạt; hướng dẫn nhập môn | onboard | DI "Activation" | DI; Q3 |
| tutorial; `tutorial_steps` | phần hướng dẫn chơi; bước hướng dẫn | tutorial trong văn | 5 bước, `step_name` giữ tiếng Anh trong `\code{}` | DB; DI |
| `step_completed` | hoàn thành bước | qua bước | 0 là đã bắt đầu nhưng bỏ dở | DB |
| funnel | phễu (phễu hướng dẫn, phễu chuyển đổi) | ống, funnel trong văn | UEH giữ "Funnel Analytics" | UEH-RET; Q3 |
| drop-off rate | tỷ lệ rơi khỏi phễu ở bước | tỷ lệ rớt, drop | = 1 − hoàn thành / bắt đầu | DI 3.2 |
| conversion rate | tỷ lệ chuyển đổi | | FPT, Play Console | FPT; PLAY-ACQ |
| `platform` | nền tảng (iOS, Android) | hệ điều hành, thiết bị | | DB |
| `device_tier` | phân hạng thiết bị (low, mid, high) | đời máy | | DB |
| `country` | thị trường; quốc gia | vùng (vùng là SEA/Other của view) | 8 mã ISO 2 chữ | DB |
| region (view) | vùng (SEA: VN, TH, PH, ID; Other) | khu vực | chỉ có ở 2 view chẩn đoán | DB |

### A.2 Màn chơi, phiên bản và chất lượng ứng dụng (mảng `operations`, `after_sales`)

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| level; `level_id` | màn chơi; màn | level, ải, cấp độ | "cấp độ" dễ lẫn với cấp câu hỏi | DB; BP |
| episode / world; `episode`, `world_name` | thế giới (Cupcake Meadow, …) | chương, map | 4 thế giới × 15 màn; tên thế giới giữ tiếng Anh | DB |
| attempt; `level_attempts` | lượt chơi (một màn) | lần thử, ván | | BP "lượt thử màn" (dùng "lượt chơi" cho gọn) |
| `result` | kết quả lượt chơi | | `complete` thắng, `fail_out_of_moves` thua do hết lượt đi, `quit` bỏ cuộc, `crash` gặp sự cố | DB |
| win rate | tỷ lệ thắng (hoàn thành màn) | tỷ lệ qua màn, winrate | = lượt `complete` / mọi lượt | BP 4.2; DI |
| fail rate | tỷ lệ thua | tỷ lệ fail | thua = `fail_out_of_moves` | Q9 |
| quit rate | tỷ lệ bỏ cuộc | tỷ lệ thoát | | Q9 |
| moves; `moves_limit`, `moves_used`, `moves_left` | số lượt đi tối đa / đã dùng / còn dư | số bước, nước đi | đã kiểm `moves_used + moves_left = moves_limit` | DB |
| extra moves; `extra_moves_offered/purchased` | ưu đãi thêm lượt đi; mua thêm lượt đi | revive, hồi sinh | cờ trong lượt chơi, **không** phải giao dịch tiền | DB; README-jelly bẫy 9 |
| booster; `booster_events` | vật phẩm hỗ trợ (booster) | bùa, đạo cụ | 5 loại, tên giữ trong `\code{}` | DB; NĐ147 k39 (vật phẩm ảo) |
| `difficulty_tag` | nhãn độ khó (normal, hard, super_hard) | | | DB |
| `designed_fail_probability` | xác suất thua theo thiết kế | | | DB |
| overtuned level | màn bị chỉnh quá khó | màn bị buff, màn lỗi | | DI; Q10 |
| difficulty spike | điểm khó đột ngột (màn 28–30) | | | BP 2.1 |
| `app_version` | phiên bản ứng dụng (lúc chơi) | bản build, version | khác `app_version_install` | DB |
| `app_version_install` | phiên bản lúc cài | | | DB |
| update; release | bản cập nhật; phát hành | update trong văn | 2.1.0 từ 30/7, 2.1.1 từ 15/8 | DB; DI |
| hotfix; rollback | bản vá; quay về bản cũ | | | BP 2.2 |
| crash; `crash_count` | sự cố (ứng dụng tự thoát) | lỗi văng, crash trong văn | Play Console "sự cố" | PLAY-VIT; DB |
| crash rate | tỷ lệ sự cố (trên 1.000 phiên) | | Play Console "Tỷ lệ sự cố" | PLAY-VIT; BP 4.1 |
| LiveOps; `liveops_events` | sự kiện vận hành trực tiếp (LiveOps); sự kiện trong game | live event | 3 sự kiện | DB |
| `screen_context` | ngữ cảnh màn hình | | chuỗi "A > B > C" | DB |

### A.3 Doanh thu, mua trong ứng dụng và quảng cáo (mảng `sales`, `finance`)

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| in-app purchase (IAP); `purchases` | mua hàng trong ứng dụng (IAP); giao dịch IAP | nạp, top-up | AdMob "doanh thu mua hàng trong ứng dụng"; TT26 "(in-app purchase - IAP)" | ADM-COH; TT26 |
| IAP revenue; `iap_revenue`, `price_usd` | doanh thu IAP (USD) | doanh số | | DB; BP |
| product; `product_type`, `product_name` | gói vật phẩm | sản phẩm, item | 5 gói giá cố định | DB |
| virtual item | vật phẩm ảo | item ảo | NĐ147 Đ3 k39 | NĐ147 |
| virtual currency (coins, gems) | đơn vị ảo (tiền trong game) | **tiền ảo** | pháp luật VN dùng "tiền ảo" cho tiền mã hoá; trò chơi dùng "đơn vị ảo" (NĐ147 k38). Bộ MySQL không có bảng ví (view ví bị loại) | NĐ147; TCNH |
| reward points | điểm thưởng | | NĐ147 k40 | NĐ147 |
| in-game payment | thanh toán trong trò chơi | | NĐ147 k41 | NĐ147 |
| payer / paying user | người chơi trả tiền | payer, cá voi, whale | Adapty "người dùng trả phí"; GA "người mua" | ADP; GA-STK |
| payer rate; conversion to payer | tỷ lệ người chơi trả tiền | | | BP 5.2 |
| `is_refund`; refund | hoàn tiền | refund trong văn | luôn 0 trong kỳ | DB; ADP |
| gross / net revenue | doanh thu gộp / doanh thu thuần (sau hoàn tiền) | | | ADP |
| ad revenue; `ad_revenue`, `revenue_usd` | doanh thu quảng cáo (USD) | | | DB |
| rewarded ad | quảng cáo có tặng thưởng | quảng cáo thưởng | AdMob | ADM-FMT |
| interstitial ad | quảng cáo xen kẽ | quảng cáo toàn màn | AdMob | ADM-FMT |
| `placement` | vị trí đặt quảng cáo | | 4 giá trị | DB |
| `reward_type` | loại phần thưởng | | | DB |
| total revenue | tổng doanh thu (IAP + quảng cáo) | | | BP 4.1 |
| ARPU | ARPU (doanh thu bình quân trên một người chơi) | | Bộ KH&CN "doanh thu bình quân trên từng thuê bao (ARPU)" | MST |
| ARPDAU; `arpdau` | ARPDAU (doanh thu bình quân trên một người chơi hoạt động trong ngày) | | `(iap_revenue + ad_revenue) / dau` | DB; BP; Q7 |
| ARPPU | ARPPU (doanh thu bình quân trên một người chơi trả tiền) | | | ADP; BP |
| LTV / CLV | giá trị vòng đời người chơi (LTV) | | UEH, TMU "giá trị vòng đời khách hàng"; trong kỳ 60 ngày chỉ đo "doanh thu luỹ kế D7/D30" | UEH-CLV; TMU; ADM-COH |
| cumulative revenue per install | doanh thu luỹ kế trên một lượt cài (D7) | | thay LTV khi dữ liệu ngắn | BP; DI |

### A.4 Thu hút người chơi, chiến dịch và thử nghiệm (mảng `marketing`, `finance`)

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| user acquisition (UA) | thu hút người chơi (UA) | mua user | GA, Play "thu nạp"; TMU "giành được khách hàng". Chọn "thu hút" (chưa có nguồn giáo trình, xem F.2) | GA-ACQ; PLAY-ACQ; TMU |
| `channel` | kênh thu hút | nguồn traffic | 5 kênh | DB |
| organic | tự nhiên (không trả phí) | organic trong văn | Play "(Không phải trả tiền)" | PLAY-ACQ; DB |
| paid channel | kênh trả phí | | | DI |
| campaign; `campaign_id` | chiến dịch | | | DB |
| `spend_usd` | chi phí quảng cáo (USD) | ngân sách (ngân sách là kế hoạch) | | DB |
| `target_platform` | nền tảng nhắm tới | | | DB |
| CAC | chi phí thu hút một người chơi (CAC) | | TMU "chi phí giành được khách hàng" | TMU; UEH-CLV |
| CPI | CPI (chi phí cho mỗi lượt cài đặt) | | = chi / lượt cài của kênh trả phí | BP 5.2 |
| ROAS | ROAS (doanh thu trên chi phí quảng cáo) | ROI khi chỉ có doanh thu | = doanh thu của nhóm cài / chi phí | BP 4.4; Q8 |
| ROI | ROI (lợi nhuận trên chi phí) | | dùng khi trừ chi phí; Q8 dùng "ROI" | Q8 |
| A/B test; `ab_assignments` | thử nghiệm A/B | | FPT "thử nghiệm hai phiên bản khác nhau (A và B)" | FPT; DB |
| `variant` | nhánh thử nghiệm | biến thể (đã dùng cho biến thể dữ liệu chấm) | `control_after_3_fails` nhánh đối chứng | DB |
| control / treatment | nhánh đối chứng / nhánh thử | | | FPT |
| `exposure_status`, `exposed_at` | đã tiếp xúc ưu đãi / thời điểm tiếp xúc | | `not_exposed`: được chia nhánh nhưng chưa gặp | DB |
| intention-to-treat | phân tích theo nhánh được chia (mọi người được chia) | ITT trong văn | mặc định cho `primary_metric` | DB |
| `primary_metric`; `guardrail_metric` | chỉ số chính; chỉ số bảo vệ | | `d7_retention` là chỉ số bảo vệ | DB |
| `analysis_window_days` | cửa sổ phân tích (7 ngày, D0–D6) | | | DB |

### A.5 Dữ liệu và SQL

Kế thừa nguyên STYLE-scm mục A.5 và G.1, G.5 (chỉ dùng trong `yeucau`, `rangbuoc`, `\goiy`, `\luuy`, `\ghichuthietke`; không dùng trong
`\boicanh`). Thêm cho bộ này:

| Từ | Dùng | Ghi chú |
|---|---|---|
| grain | hạt dữ liệu ("mỗi dòng là một người chơi trong một ngày có hoạt động") | nêu ở `\luuy` khi dễ hiểu nhầm |
| pre-aggregated table | bảng tổng hợp sẵn (`daily_kpi`) | |
| reconciliation | đối soát | dạng E2 |
| window (data) | cửa sổ dữ liệu (2026-07-01 tới 2026-08-29) | khác "hàm cửa sổ" |

---

## B. Giọng văn cho từng phần

Kế thừa nguyên STYLE-scm mục B (nguyên tắc chung, B.1–B.7). Điều chỉnh cho bộ game:

1. **Số, tiền:** tiền USD viết "4,99 USD", alias `_usd`; tỷ lệ phần trăm 1–2 chữ số; ARPDAU 4 chữ số (đúng `daily_kpi.arpdau`).
2. **Ngày:** "ngày 15/8/2026", "tháng 7/2026"; trong `\code{}` giữ `'2026-07-01'`. Tháng 8/2026 phải ghi "tới hết ngày 29/8" hoặc nêu là tháng chưa trọn.
3. **Người hỏi (`\boicanh`):** vai trò có thật ở studio game: Quản lý sản phẩm (Product Manager), Trưởng nhóm LiveOps, Thiết kế màn chơi
   (Game Designer), Quản lý thu hút người chơi (UA), Quản lý doanh thu (Monetization), Trưởng nhóm phân tích dữ liệu, Kỹ sư QA, Kế toán
   quản trị, Giám đốc studio; Data engineer cho câu Tối ưu; Thực tập sinh phân tích cho câu Sửa lỗi cấp thấp (BP 2.2).
   Chức danh tiếng Anh chỉ đặt trong ngoặc vuông nếu studio thật gọi vậy, ví dụ `\boicanh[Anh Khoa · Thiết kế màn chơi]`.
4. **Ví dụ đạt:**
   - `\tieude{Bước hướng dẫn nào làm người chơi mới bỏ đi nhiều nhất?}`
   - `\boicanh[Chị Mai · Quản lý sản phẩm]{Sau bản 2.1.0 đội hỗ trợ báo người chơi Android than khó ở đầu game. Em xem giúp chị người mới rơi khỏi phần hướng dẫn ở bước nào.}`
   - `\boicanh[Anh Tuấn · Quản lý thu hút người chơi]{Tháng sau anh phải cắt bớt ngân sách quảng cáo. Em cho anh biết mỗi lượt cài của từng kênh tốn bao nhiêu.}`
   - `\luuy{Bảng hoạt động ngày chỉ có ngày người chơi có mở game. Mẫu số của tỷ lệ giữ chân lấy từ số người cài, không đếm trên bảng này.}`
5. **Bước kết luận:** lỗi lập luận hay gặp trong phân tích game: so ngày lịch thay vì so theo ngày kể từ cài (cohort); dùng cohort chưa đủ
   ngày; lấy trung bình ARPDAU theo ngày thay vì tổng doanh thu / tổng DAU; coi người mua gói là nguyên nhân giữ chân (tương quan); chỉ tính
   người đã tiếp xúc ưu đãi khi đánh giá A/B; trình bày quan hệ dựng sẵn của bộ dữ liệu tổng hợp như phát hiện về game thật (BP 5.5).

---

## C. Khuôn cấm

Kế thừa nguyên STYLE-scm mục C (C.1 cụm cấm, K1–K15; C.2 K16–K32). Bổ sung cho bộ game:

| # | Khuôn | TRƯỚC | SAU |
|---|---|---|---|
| K33 | Tiếng lóng game, cộng đồng | "màn này bị buff quá tay", "người chơi bị hành", "cá voi nạp nhiều" | "màn này bị chỉnh quá khó", "người chơi thua liên tục", "người chơi chi nhiều nhất" |
| K34 | Tiếng Anh sản phẩm trong lời nhắn | "Em check retention D7 của cohort Android sau update giúp chị." | "Em xem giúp chị tỷ lệ giữ chân ngày thứ 7 của người chơi Android cài sau bản cập nhật." |
| K35 | "tiền ảo" cho tiền trong game | "người chơi tiêu tiền ảo" | "người chơi dùng đơn vị ảo (xu trong game)" |
| K36 | Gọi cờ trong lượt chơi là giao dịch | "lượt chơi có mua thêm lượt đi là doanh thu" | "lượt chơi có nhận ưu đãi thêm lượt đi" (doanh thu chỉ ở `purchases`) |
| K37 | Kết luận nhân quả từ bộ dữ liệu tổng hợp | "Bản 2.1.0 chắc chắn làm người chơi bỏ game." | "Sau bản 2.1.0, tỷ lệ hoàn thành bước 4 trên Android thấp hơn các nhóm khác." |

---

## E. Khái niệm khai báo cho bộ `jelly` (22 khái niệm)

Mọi cột đã đối chiếu MySQL `jelly`. Người soạn chỉ chép khái niệm gói mình dùng.

| # | Mã | Tên | Bảng chính |
|---|---|---|---|
| 1 | `dau` | DAU | `player_daily`, `daily_kpi` |
| 2 | `mau` | MAU và mức độ gắn bó | `player_daily` |
| 3 | `nhom-cai-dat` | Nhóm cài đặt (cohort) | `users`, `player_daily` |
| 4 | `ty-le-giu-chan` | Tỷ lệ giữ chân Dn | `users`, `player_daily` |
| 5 | `nhom-du-ngay` | Nhóm cài đã đủ ngày quan sát | `users` |
| 6 | `ty-le-roi-bo` | Tỷ lệ rời bỏ | `player_daily` |
| 7 | `pheu-huong-dan` | Phễu hướng dẫn | `tutorial_steps` |
| 8 | `phien-choi` | Phiên chơi và thời lượng phiên | `sessions` |
| 9 | `ty-le-thang-man` | Tỷ lệ thắng màn | `level_attempts` |
| 10 | `ty-le-bo-cuoc` | Tỷ lệ bỏ cuộc | `level_attempts` |
| 11 | `ty-le-su-co` | Tỷ lệ sự cố trên 1.000 phiên | `player_daily` |
| 12 | `phien-ban-luc-choi` | Phiên bản lúc chơi và lúc cài | `player_daily`, `users` |
| 13 | `doanh-thu-iap` | Doanh thu IAP | `purchases` |
| 14 | `doanh-thu-quang-cao` | Doanh thu quảng cáo | `ad_events`, `player_daily` |
| 15 | `nguoi-choi-tra-tien` | Người chơi trả tiền | `purchases` |
| 16 | `arpdau` | ARPDAU | `daily_kpi` |
| 17 | `arppu` | ARPPU | `purchases` |
| 18 | `cpi` | CPI | `campaign_spend`, `users` |
| 19 | `roas` | ROAS | `campaign_spend`, `users`, `player_daily` |
| 20 | `thu-nghiem-ab` | Thử nghiệm A/B theo nhánh được chia | `ab_assignments` |
| 21 | `vat-pham-ho-tro` | Vật phẩm hỗ trợ (booster) | `booster_events` |
| 22 | `doi-soat-tong-hop` | Đối soát bảng tổng hợp | `daily_kpi`, `player_daily` |

```latex
\khaibaokhainiem{dau}{DAU (số người chơi hoạt động trong ngày)}
  {DAU là số người chơi khác nhau có mở game ít nhất một lần trong một ngày.}
  {số user\_id khác nhau có hoạt động trong ngày}
  {bảng \code{player_daily}: mỗi dòng là một người chơi trong một ngày có hoạt động; \code{daily_kpi.dau} là số tổng hợp sẵn, khớp với cách đếm này.}
\khaibaokhainiem{mau}{MAU và mức độ gắn bó}
  {MAU là số người chơi khác nhau hoạt động ít nhất một lần trong tháng. Mức độ gắn bó là DAU bình quân chia MAU.}
  {DAU bình quân / MAU}
  {\code{player_daily}; tháng 8/2026 chỉ có dữ liệu tới ngày 29, không so trực tiếp với tháng 7.}
\khaibaokhainiem{nhom-cai-dat}{Nhóm cài đặt (cohort)}
  {Nhóm cài đặt là tập người chơi cài game trong cùng một khoảng thời gian, được theo dõi theo số ngày kể từ ngày cài.}
  {}
  {\code{users.install_date}; \code{player_daily.cohort_day} = số ngày từ ngày cài tới ngày hoạt động, D0 là ngày cài.}
\khaibaokhainiem{ty-le-giu-chan}{Tỷ lệ giữ chân Dn}
  {Tỷ lệ giữ chân Dn là phần người chơi của một nhóm cài đặt còn hoạt động đúng vào ngày thứ n sau ngày cài.}
  {số người có hoạt động với cohort\_day = n / số người cài của nhóm}
  {mẫu số lấy từ \code{users}; tử số từ \code{player_daily}. Bảng hoạt động không có dòng cho ngày người chơi vắng mặt.}
\khaibaokhainiem{nhom-du-ngay}{Nhóm cài đã đủ ngày quan sát}
  {Một nhóm cài đặt đủ ngày quan sát cho chỉ số Dn khi ngày cài cộng n ngày còn nằm trong cửa sổ dữ liệu.}
  {install\_date + n ngày ≤ ngày cuối của dữ liệu}
  {dữ liệu kết thúc ngày 2026-08-29; nhóm chưa đủ ngày làm tỷ lệ giữ chân thấp giả.}
\khaibaokhainiem{ty-le-roi-bo}{Tỷ lệ rời bỏ}
  {Tỷ lệ rời bỏ là phần người chơi không còn hoạt động trong một khoảng thời gian định trước so với số người chơi đầu kỳ.}
  {số người không hoạt động N ngày liên tiếp / số người chơi đầu kỳ}
  {\code{player_daily}; đề phải nêu N và ngày mốc. Người chưa đủ N ngày kể từ ngày cài không tính.}
\khaibaokhainiem{pheu-huong-dan}{Phễu hướng dẫn}
  {Phễu hướng dẫn mô tả số người chơi mới đi qua từng bước của phần hướng dẫn chơi và phần rơi khỏi phễu ở mỗi bước.}
  {tỷ lệ hoàn thành bước k = số người hoàn thành bước k / số người bắt đầu bước k}
  {\code{tutorial_steps}: mỗi dòng là một người chơi ở một bước đã bắt đầu; bước sau chỉ có dòng khi bước trước hoàn thành; \code{step_completed} = 0 là bỏ dở.}
\khaibaokhainiem{phien-choi}{Phiên chơi và thời lượng phiên}
  {Phiên chơi là một lần người chơi mở game cho tới khi rời đi. Thời lượng phiên là số phút của phiên đó.}
  {thời lượng phiên bình quân = tổng duration\_minutes / số phiên}
  {\code{sessions}; mã phiên có hai dạng, phiên hướng dẫn có \code{entry_screen} = \code{'tutorial'}.}
\khaibaokhainiem{ty-le-thang-man}{Tỷ lệ thắng màn}
  {Tỷ lệ thắng màn là phần lượt chơi hoàn thành mục tiêu của màn trên tổng số lượt chơi màn đó.}
  {số lượt result = 'complete' / tổng số lượt}
  {\code{level_attempts}; mẫu số gồm cả lượt thua, bỏ cuộc và gặp sự cố.}
\khaibaokhainiem{ty-le-bo-cuoc}{Tỷ lệ bỏ cuộc}
  {Tỷ lệ bỏ cuộc là phần lượt chơi mà người chơi tự thoát khi màn chưa kết thúc.}
  {số lượt result = 'quit' / tổng số lượt}
  {\code{level_attempts}; thua do hết lượt đi là \code{'fail_out_of_moves'}, không phải bỏ cuộc.}
\khaibaokhainiem{ty-le-su-co}{Tỷ lệ sự cố trên 1.000 phiên}
  {Tỷ lệ sự cố đo số lần ứng dụng tự thoát do lỗi trên mỗi 1.000 phiên chơi.}
  {tổng crash\_count / tổng sessions × 1000}
  {\code{player_daily.crash_count}, \code{player_daily.sessions}. Số lượt chơi có \code{result} = \code{'crash'} là nguồn đếm khác, không khớp với \code{crash_count}.}
\khaibaokhainiem{phien-ban-luc-choi}{Phiên bản lúc chơi và lúc cài}
  {Phiên bản lúc chơi là phiên bản ứng dụng người chơi dùng trong ngày hoạt động; người chơi có thể cập nhật sau khi cài.}
  {}
  {\code{player_daily.app_version}, \code{sessions.app_version}, \code{level_attempts.app_version} là phiên bản lúc chơi; \code{users.app_version_install} là phiên bản lúc cài. Bản 2.1.0 có từ 30/7, 2.1.1 từ 15/8.}
\khaibaokhainiem{doanh-thu-iap}{Doanh thu IAP}
  {Doanh thu IAP là tiền người chơi trả để mua gói vật phẩm ảo trong ứng dụng.}
  {tổng price\_usd của giao dịch không hoàn tiền}
  {bảng \code{purchases}: mỗi dòng là một giao dịch, giá theo USD; trong kỳ chưa có giao dịch hoàn tiền (\code{is_refund} = 0).}
\khaibaokhainiem{doanh-thu-quang-cao}{Doanh thu quảng cáo}
  {Doanh thu quảng cáo là tiền mạng quảng cáo trả cho game khi người chơi xem quảng cáo.}
  {tổng revenue\_usd}
  {\code{ad_events} (từng lần xem, 5 chữ số thập phân); \code{player_daily.ad_revenue} là tổng theo ngày đã làm tròn 4 chữ số.}
\khaibaokhainiem{nguoi-choi-tra-tien}{Người chơi trả tiền}
  {Người chơi trả tiền là người có ít nhất một giao dịch mua trong ứng dụng trong kỳ xét.}
  {số user\_id khác nhau có giao dịch}
  {\code{purchases}; một người có thể có nhiều giao dịch.}
\khaibaokhainiem{arpdau}{ARPDAU}
  {ARPDAU là doanh thu bình quân trên một người chơi hoạt động trong ngày.}
  {(doanh thu IAP + doanh thu quảng cáo) / DAU}
  {\code{daily_kpi.arpdau} làm tròn 4 chữ số. ARPDAU của nhiều ngày tính bằng tổng doanh thu chia tổng DAU, không lấy trung bình cột \code{arpdau}.}
\khaibaokhainiem{arppu}{ARPPU}
  {ARPPU là doanh thu IAP bình quân trên một người chơi trả tiền.}
  {doanh thu IAP / số người chơi trả tiền}
  {\code{purchases}; khác ARPU, có mẫu số là mọi người chơi.}
\khaibaokhainiem{cpi}{CPI (chi phí cho mỗi lượt cài đặt)}
  {CPI là chi phí quảng cáo bình quân để có một lượt cài đặt từ một kênh trả phí.}
  {tổng spend\_usd / số người cài của kênh}
  {\code{campaign_spend} chia theo ngày, chiến dịch, quốc gia, nền tảng; kênh Organic không có chi phí nên không có CPI.}
\khaibaokhainiem{roas}{ROAS}
  {ROAS là doanh thu thu về trên mỗi đồng chi cho quảng cáo thu hút người chơi.}
  {doanh thu của nhóm người cài từ kênh / chi phí của kênh}
  {doanh thu lấy từ \code{player_daily} của người chơi cùng \code{campaign_id}; đề phải nêu cửa sổ doanh thu (ví dụ D0–D6).}
\khaibaokhainiem{thu-nghiem-ab}{Thử nghiệm A/B theo nhánh được chia}
  {Thử nghiệm A/B so sánh hai nhánh người chơi được chia ngẫu nhiên, mỗi nhánh nhận một cách thiết kế khác nhau.}
  {chỉ số của nhánh thử − chỉ số của nhánh đối chứng}
  {\code{ab_assignments}: thử nghiệm \code{extra_moves_offer_timing}, nhánh đối chứng \code{control_after_3_fails}; chỉ số chính tính trên mọi người được chia, kể cả người chưa tiếp xúc (\code{exposed_at} rỗng).}
\khaibaokhainiem{vat-pham-ho-tro}{Vật phẩm hỗ trợ (booster)}
  {Vật phẩm hỗ trợ là vật phẩm ảo người chơi dùng trong màn để dễ đạt mục tiêu hơn.}
  {}
  {\code{booster_events}: mỗi dòng là một lần dùng, gắn với một lượt chơi qua \code{attempt_id}.}
\khaibaokhainiem{doi-soat-tong-hop}{Đối soát bảng tổng hợp}
  {Đối soát là so số liệu của bảng tổng hợp sẵn với số tính lại từ dữ liệu chi tiết để phát hiện chênh lệch.}
  {chênh lệch = số tổng hợp − số tính lại}
  {\code{daily_kpi} tính từ \code{player_daily} và \code{users}; so số thập phân cần cùng mức làm tròn.}
```

Ghi chú cho người soạn (số ở `mysql/README-jelly.md`, không đưa vào tab Nghiệp vụ): `max_level` là màn cao nhất trong ngày, không luỹ kế;
`extra_moves_purchased` ở lượt chơi không phải giao dịch tiền; `crash_count` không khớp lượt `crash`.

---

## F. Điểm cần giảng viên chốt

1. Nhiều chỉ số (DAU, ARPDAU, ARPPU, CPI, ROAS, cohort, funnel) không tìm được giáo trình đại học Việt Nam trực tuyến; bộ chuẩn dùng tiếng Anh
   kèm giải nghĩa, theo giao diện tiếng Việt của Google. Nếu giảng viên có giáo trình Marketing số / TMĐT (NEU, UEH, TMU) bản giấy, cần đối
   chiếu lại A.1, A.3, A.4.
2. "Thu hút người chơi" (UA): Google dùng "thu nạp", ĐH Thương mại dùng "giành được khách hàng". Bộ chuẩn chọn "thu hút" cho tự nhiên. Có đổi không?
3. "Tiền ảo": yêu cầu ban đầu có từ này, nhưng pháp luật VN dùng "tiền ảo" cho tiền mã hoá (TCNH); trò chơi dùng "đơn vị ảo" (NĐ147). Bộ chuẩn
   dùng "đơn vị ảo". Bộ MySQL không có bảng ví nên ít câu chạm tới.
4. Giữ chân mặc định "đúng ngày n" (classic). Nếu giảng viên muốn "từ ngày n trở đi" thì mỗi câu phải ghi rõ.
5. Blueprint là bản v2 (45 ngày, chỉ VN, 2.0.3/2.1.0); bộ MySQL là v3 (60 ngày, 8 thị trường, 2.0.2/2.1.0/2.1.1). Đề không dẫn số của Blueprint.

---

## G. Ánh xạ 6 khoá mảng nghiệp vụ (`domain`)

Không thêm khoá mới.

| Khoá | Tên hiển thị gợi ý | Phạm vi trong bộ `jelly` | Bảng chính |
|---|---|---|---|
| `customer` | Người chơi | người chơi, hoạt động (DAU/MAU), giữ chân, rời bỏ, nhóm cài đặt, phễu hướng dẫn, chuỗi ngày chơi | users, player_daily, tutorial_steps, sessions |
| `sales` | Mua trong ứng dụng | giao dịch IAP, gói vật phẩm, người chơi trả tiền, mua thêm lượt đi | purchases, level_attempts |
| `marketing` | Thu hút và sự kiện | kênh thu hút, chiến dịch, chi phí quảng cáo, sự kiện LiveOps, thử nghiệm A/B | campaign_spend, users, liveops_events, ab_assignments |
| `operations` | Vận hành game | màn chơi, độ khó, lượt chơi, booster, phiên chơi, phiên bản ứng dụng | level_attempts, level_metadata, booster_events, sessions |
| `finance` | Doanh thu | tổng doanh thu, doanh thu quảng cáo, ARPU/ARPDAU/ARPPU, CPI, ROAS, LTV ngắn hạn | daily_kpi, player_daily, ad_events, campaign_spend |
| `after_sales` | Chất lượng sau phát hành | sự cố (crash), hoàn tiền (kỳ này bằng 0), đối soát sau bản vá; dữ liệu không có ticket hỗ trợ nên mảng này mỏng | player_daily, level_attempts, purchases |

Khai báo gợi ý (`cau-hoi.tex`):

```latex
\khaibaodulieu{jelly}{GAME · Jelly Trail Academy}
  {Game giải đố ghép kẹo trên di động (iOS, Android, 8 thị trường): người chơi, phiên chơi, lượt chơi màn, mua trong ứng dụng, quảng cáo, chi phí thu hút; 60 ngày từ 2026-07-01 tới 2026-08-29.}
\khaibaodomain{customer}{Người chơi}{Hoạt động, giữ chân, phễu hướng dẫn, nhóm cài đặt.}
\khaibaodomain{sales}{Mua trong ứng dụng}{Giao dịch IAP, gói vật phẩm, người chơi trả tiền.}
\khaibaodomain{marketing}{Thu hút và sự kiện}{Kênh, chiến dịch, chi phí, sự kiện LiveOps, thử nghiệm A/B.}
\khaibaodomain{operations}{Vận hành game}{Màn chơi, độ khó, booster, phiên chơi, phiên bản.}
\khaibaodomain{finance}{Doanh thu}{Tổng doanh thu, ARPDAU, ARPPU, CPI, ROAS.}
\khaibaodomain{after_sales}{Chất lượng sau phát hành}{Sự cố, hoàn tiền, đối soát sau bản vá.}
```
