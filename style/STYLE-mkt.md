# Bộ chuẩn giọng văn và thuật ngữ · câu hỏi SQL Leaderboard trên bộ dữ liệu MARKETING

Bản nháp 1 · 10/11/2026 · chờ giảng viên duyệt.

Áp dụng cho mọi phần chữ của một câu trong `cau-hoi.tex` thuộc bộ Marketing (chiến dịch marketing số của ba thương hiệu mỹ phẩm
Nykaa, Purplle, Tira Beauty; MySQL `mkt`, xem `mysql/README-mkt.md`): `\tieude`, `\boicanh`, `yeucau`, `rangbuoc`, `nghiepvu`,
`\goiy`, `\phuongan`, `\khaibaokhainiem`, `\ghichuthietke`. Cú pháp LaTeX theo `quy_chuan/goi-cau-hoi-mau/HUONG_DAN.md`.

Thứ tự ưu tiên khi các nguồn mâu thuẫn:
1. Quyết định của giảng viên ở `STYLE-GUIDE-luyen-sql.md` mục H và `STYLE-scm.md` mục G (giọng văn chung, đã áp dụng cho bộ scm).
2. Bài giảng của dự án: `lesson1_marketing_analytics_foundations.md` (BG) mục II–III và `Plan.md` (PL) của Project 01 Marketing.
   Học viên học theo bài giảng, nên **giữ từ của bài giảng** khi giáo trình đại học gọi khác, ghi từ giáo trình ở cột "Ghi chú".
3. Quy chuẩn ra đề: `quy_chuan/Huong-dan-cho-team-noi-dung.md`, `goi-cau-hoi-mau/cau-hoi.tex` (QC).
4. Bài báo, đề cương của trường đại học Việt Nam; văn bản pháp quy (có URL, mục 0).
5. Nguồn phổ thông: chỉ khi bốn nguồn trên không có.

---

## 0. Nguồn và mã viết tắt

| Mã | Tài liệu | Trạng thái |
|---|---|---|
| BG | `lesson1_marketing_analytics_foundations.md`, Project 01 Marketing (thư mục `Project DA\Project 01 Marketing Analytics Foundations & Data Pipeline`), mục II.A (thuật ngữ), II.B (phễu), II.C (KPI), III.B (từ điển dữ liệu) | đọc trực tiếp |
| PL | `Plan.md`, Project 01 (Lesson 1–2: funnel 4 tầng, KPI CTR, Lead Rate, Conversion Rate, CPA, ROI; Total_Spend) | đọc trực tiếp |
| DB | Cấu trúc và giá trị cột MySQL `mkt`, kiểm ngày 10/11/2026 | `mysql/README-mkt.md` |
| SG | `style/STYLE-GUIDE-luyen-sql.md` (mục A–H, đã duyệt) | đọc trực tiếp |
| SCM | `style/STYLE-scm.md` (mục B, C, G) | đọc trực tiếp |
| QC | `quy_chuan/Huong-dan-cho-team-noi-dung.md`, `goi-cau-hoi-mau/cau-hoi.tex` | đọc trực tiếp |
| NEU-TCCT | Nguyễn Quỳnh Trang (Khoa Marketing, ĐH Kinh tế Quốc dân), Lê Thị Tầm, "Hoàn thiện và thúc đẩy sự phát triển của Digital marketing ở các doanh nghiệp hiện nay", Tạp chí Công Thương số 26, 12/2022. https://tapchicongthuong.vn/hoan-thien-va-thuc-day-su-phat-trien-cua-digital-marketing-o-cac-doanh-nghiep-hien-nay-103977.htm | toàn văn HTML |
| TMU-TCCT | TS. Nguyễn Thu Quỳnh (ĐH Thương mại), "Truyền thông marketing trong tuyển sinh đại học chính quy của các trường đại học Việt Nam", Tạp chí Công Thương số 25, 11/2022. https://tapchicongthuong.vn/truyen-thong-marketing-trong-tuyen-sinh-dai-hoc-chinh-quy-cua-cac-truong-dai-hoc-viet-nam-101920.htm | toàn văn HTML |
| FTU-JIEM | Phạm Đức Anh và cộng sự, "Vai trò của người ảnh hưởng trong việc tạo lập xu hướng tiêu dùng thực phẩm của giới trẻ", Tạp chí Quản lý và Kinh tế quốc tế số 143, 2022. https://vjol.info.vn/jiem/article/view/68774 | chỉ tóm tắt, từ khoá |
| CTU-48 | Ngô Mỹ Trân, Mai Võ Ngọc Thanh, "Phân tích tác động của quảng cáo qua mạng xã hội đến ý định mua sắm…", Tạp chí Khoa học ĐH Cần Thơ số 48, 2017. https://ctujsvn.ctu.edu.vn/index.php/ctujsvn/article/view/2520 | chỉ tóm tắt |
| HIU-DM1002 | Đề cương "Nhập môn Digital Marketing", ĐH Quốc tế Hồng Bàng, 2022. https://docs.google.com/document/d/1y_9BT2sm9cwIubJ0clSZcER_WXC8h87g/export?format=txt | toàn văn |
| HIU-DM2006 | Đề cương "Email Marketing", ĐH Quốc tế Hồng Bàng, 2022. https://docs.google.com/document/d/1Bai9dZxVZnEnr9G6YDIppAZRmq2dIoG9/export?format=txt | toàn văn |
| LQC12 | Luật Quảng cáo số 16/2012/QH13. https://caselaw.vn/van-ban-phap-luat/115754-luat-quang-cao-2012 | toàn văn |
| LQC25 | Luật số 75/2025/QH15 sửa đổi Luật Quảng cáo (hiệu lực 01/01/2026), bài tóm tắt: https://luatvietnam.vn/linh-vuc-khac/diem-moi-cua-luat-quang-cao-sua-doi-2025-883-102813-article.html | chỉ bài tóm tắt thứ cấp |

Các nguồn NEU-TCCT … LQC25 được tra ngày 10/11/2026; trích dẫn nguyên văn ở cột "Nguồn" của mục A là theo bản tra cứu đó, người
duyệt nên mở lại URL khi chốt.

Không mở được hoặc không tìm thấy bản trực tuyến (không dùng làm căn cứ):
- Giáo trình **Marketing căn bản**, GS.TS Trần Minh Đạo, NXB ĐH Kinh tế Quốc dân: chỉ thấy metadata (thư viện số TNUT https://thuvienso.tnut.edu.vn/handle/123456789/1287; lib.hpu.edu.vn), PDF hạn chế.
- Đề cương MKMA1104 Marketing căn bản (khaothi-dbclgd.neu.edu.vn): trang trống. Giáo trình Marketing số / Truyền thông marketing của NEU, UEH, ĐH Thương mại: **không tìm được bản trực tuyến**.
- Đề cương Digital Marketing ĐH Cần Thơ (cse.ctu.edu.vn, PDF nén) và UFM (404): không đọc được.
- Một Google Doc không rõ trường (https://docs.google.com/document/d/1JJWBJG1SPf-5NtarPhJF9giJmnrXK8Ptv8hucS1Qja8) dùng "tỷ lệ nhấp", "chi phí mỗi nhấp chuột", "chi phí trên 1.000 lượt hiển thị", "tỷ suất hoàn vốn": **chỉ ghi chú, không làm căn cứ**.
- CPC, CPM, CPA, ROAS, "lượt hiển thị": không thấy trong nguồn đại học nào mở được. Bộ này dùng cách gọi của BG; CPC, CPM, ROAS không có trong BG nên giữ viết tắt và giải nghĩa theo công thức (mục E).

---

## A. Bảng thuật ngữ

Quy ước:
- Cột "Dùng" là đúng chữ cần viết, viết thường (trừ đầu câu). Thuật ngữ giữ tiếng Anh (CTR, CPA, ROI, ROAS, SEO, email) giải nghĩa
  tiếng Việt ở lần đầu trong mỗi câu: "CTR (tỷ lệ nhấp)".
- Tên bảng, cột viết đúng như DB trong `\code{}`; giá trị chuỗi trong nháy đơn: `\code{'Paid Ads'}`, `\code{'Tira Beauty'}`.
- Tên thương hiệu, loại chiến dịch, kênh, đối tượng giữ nguyên tiếng Anh như dữ liệu (Nykaa, Paid Ads, Working Women); lần đầu được
  kèm nghĩa: "nhóm Working Women (phụ nữ đi làm)".
- Tên cột kết quả (alias) tiếng Việt không dấu theo cột "Dùng": `so_chien_dich`, `ctr_pct`, `ty_le_chuyen_doi_pct`, `chi_phi`, `roi`, `roas`, `doanh_thu`.

### A.1 Chiến dịch, kênh, đối tượng

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| campaign; `campaigns`, `campaign_id` | chiến dịch; mã chiến dịch | campaign (trong văn), đợt chạy | BG: "Campaign (chiến dịch) là một đợt quảng cáo có mục tiêu, thời hạn và ngân sách cụ thể" | BG II.A.1; HIU-DM1002 ("chiến dịch Marketing tổng thể") |
| marketing campaign | chiến dịch marketing | chiến dịch tiếp thị (chỉ ghi chú) | | BG; HIU-DM2006 |
| brand; `brands.brand_name` | thương hiệu | brand, nhãn hàng | ba thương hiệu Nykaa, Purplle, Tira Beauty (không viết "Tira") | BG III.A; DB |
| `campaign_type`, `campaign_types` | loại chiến dịch | kiểu chiến dịch, hình thức | 5 giá trị | BG III.B; DB |
| Email (loại) | chiến dịch email; email marketing (marketing qua thư điện tử) | "thư rác"; "Email" để chỉ kênh khi đang nói loại | Email vừa là loại vừa là kênh: luôn nói rõ "loại Email" / "kênh Email" | HIU-DM2006; LQC12 Điều 24 ("thư điện tử quảng cáo") |
| Influencer | marketing người ảnh hưởng (Influencer) | KOL marketing, "người nổi tiếng" | luật dùng "người có ảnh hưởng" | FTU-JIEM; LQC25 |
| Paid Ads | quảng cáo trả phí (Paid Ads) | quảng cáo trả tiền, ads | NEU-TCCT nêu "Pay Per Click (PPC)" không dịch | NEU-TCCT; HIU-DM1002 ("Paid – Owned – Earned") |
| SEO | SEO (tối ưu hoá công cụ tìm kiếm) | tối ưu Google | | NEU-TCCT; HIU-DM1002 |
| Social Media | marketing mạng xã hội (Social Media) | MXH, social | | FTU-JIEM ("truyền thông mạng xã hội"); HIU-DM1002 |
| channel; `channels`, `campaign_channels` | kênh; kênh quảng cáo | nền tảng, platform | BG: "Channel (kênh) là nền tảng mà campaign chạy trên đó"; một chiến dịch chạy 1–3 kênh | BG II.A.2; TMU-TCCT ("kênh truyền thông") |
| `Channel_Used` đa trị | chiến dịch chạy nhiều kênh | "kênh chính" (dữ liệu không có) | `channel_pos` chỉ là thứ tự trong chuỗi gốc, không phải mức ưu tiên | BG III.B; DB |
| Facebook, Instagram, Google, YouTube, WhatsApp | giữ nguyên tên | FB, IG, GG | | DB |
| `target_audience_id` | đối tượng mục tiêu; nhóm đối tượng mục tiêu | target, tệp khách | giáo trình truyền thông dùng "công chúng mục tiêu"; BG dùng "nhóm đối tượng mục tiêu" | BG III.B; TMU-TCCT |
| `segment_id` (Customer_Segment) | phân khúc khách hàng | segment, phân khúc thị trường (khi nói cột này) | giáo trình gọi quá trình là "phân đoạn/phân khúc thị trường" | BG III.B; TMU-TCCT ("phân đoạn") |
| `audiences` | nhóm khách hàng (dùng chung cho hai vai) | | một danh mục cho hai cột: luôn nói rõ vai | DB |
| College Students | sinh viên (College Students) | học sinh | | DB |
| Premium Shoppers | khách mua sắm cao cấp (Premium Shoppers) | khách VIP | | DB |
| Tier 2 City Customers | khách ở thành phố loại 2 (Tier 2 City Customers) | tỉnh lẻ | phân loại thành phố của Ấn Độ | DB |
| Working Women | phụ nữ đi làm (Working Women) | chị em công sở | | DB |
| Youth | giới trẻ (Youth) | gen Z | | DB; FTU-JIEM ("giới trẻ") |
| `language_id`, `languages` | ngôn ngữ của chiến dịch | ngôn ngữ khách hàng | Bengali, English, Hindi, Tamil | BG III.B; DB |
| `start_date` (cột `Date` gốc) | ngày bắt đầu; ngày khởi chạy | ngày chiến dịch (mơ hồ) | BG: "Ngày bắt đầu campaign" | BG III.B |
| `duration_days` | thời lượng chiến dịch (ngày) | độ dài, thời hạn | 5–30 ngày | BG III.B |
| ngày kết thúc | ngày cuối của chiến dịch = ngày bắt đầu + thời lượng − 1 | ngày hết hạn | dữ liệu không có cột này; đề phải ghi quy ước | DB |
| chiến dịch đang chạy | chiến dịch đang chạy vào ngày d (d nằm từ ngày bắt đầu tới ngày cuối) | đang hoạt động, còn hiệu lực | | DB |
| budget | ngân sách marketing; ngân sách truyền thông | budget | dữ liệu không có ngân sách kế hoạch, chỉ có chi phí thực | TMU-TCCT; NEU-TCCT; PL |
| marketing mix | (không dùng trong đề) | | không có dữ liệu 4P | |

### A.2 Phễu và chỉ số hiệu quả

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| marketing funnel | phễu marketing | funnel, phễu bán hàng | bốn tầng | BG II.B; PL |
| Awareness | tầng nhận biết | | | BG II.B; TMU-TCCT ("nhận biết") |
| Interest | tầng quan tâm | | | BG II.B |
| Consideration | tầng cân nhắc | | | BG II.B |
| Conversion (tầng) | tầng chuyển đổi | | | BG II.B |
| drop-off | tỷ lệ rơi (giữa hai tầng) | rớt, tuột | = 1 − tầng sau / tầng trước | BG II.B |
| `impressions` | lượt hiển thị | impression, lượt xem, lượt tiếp cận | lượt hiển thị khác số người thấy (reach), dữ liệu không có reach | BG II.A.3 |
| reach | (không dùng) | | không có dữ liệu | BG II.A.3 |
| `clicks` | lượt nhấp | lượt click, cú click | BG viết "lượt click"; đề dùng "lượt nhấp" và giải nghĩa "(click)" lần đầu | BG II.A.4; HIU-DM2006 ("lượt nhấp") |
| `leads` | khách hàng tiềm năng (lead) | lead (đứng một mình), khách tiềm năng | BG II.A.5 dùng đúng cụm này | BG; NEU-TCCT |
| `conversions` | lượt chuyển đổi | đơn hàng (chỉ dùng khi giải nghĩa) | BG: "conversion = 1 đơn hàng thành công" | BG II.A.6; NEU-TCCT |
| CTR | CTR (tỷ lệ nhấp) = lượt nhấp / lượt hiển thị | tỷ lệ click, CTR% | | BG II.C.1; HIU-DM2006 |
| Lead Rate | tỷ lệ khách hàng tiềm năng = lead / lượt nhấp | lead rate, tỷ lệ lead | BG viết "Tỷ lệ lead"; đề dùng cụm đủ chữ | BG II.C.2 |
| Conversion Rate | tỷ lệ chuyển đổi = lượt chuyển đổi / khách hàng tiềm năng | CVR | **theo BG**: chia cho leads, không chia cho clicks; câu nào dùng cách khác phải ghi rõ | BG II.C.3; NEU-TCCT |
| tỷ lệ chuyển đổi tổng | tỷ lệ chuyển đổi trên lượt hiển thị = lượt chuyển đổi / lượt hiển thị | | BG II.B ví dụ 4,07% | BG II.B |
| `engagement_score` | điểm tương tác | engagement, mức độ tương tác | thang điểm tổng hợp 2,56–30,99, không phải tỷ lệ | BG III.B; NEU-TCCT ("tương tác") |
| engagement rate | (không dùng) | tỷ lệ tương tác | dữ liệu không có số lượt tương tác | |
| KPI | chỉ số đo lường hiệu quả (KPI) | chỉ tiêu | | BG II.C |
| benchmark | mức tham chiếu | benchmark | | SCM C.1 |

### A.3 Doanh thu, chi phí, hiệu quả đầu tư

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| `revenue` | doanh thu (của chiến dịch) | doanh số, revenue | số nguyên, không rõ đơn vị tiền (BG): viết "đơn vị tiền", không viết "đồng", "rupee" | BG II.A.7 |
| `acquisition_cost` | chi phí trên mỗi chuyển đổi (CPA) | chi phí thu hút, giá vốn, tổng chi phí | BG gọi "Acquisition Cost (Chi phí mỗi khách hàng)" và nói "Acquisition_Cost chính là CPA đã tính sẵn" | BG II.A.8, II.C.4 |
| CPA | CPA (chi phí trên mỗi chuyển đổi) | chi phí mỗi khách hàng (dễ hiểu nhầm là khách duy nhất) | CPA của một nhóm = tổng chi phí / tổng lượt chuyển đổi, không lấy `AVG(acquisition_cost)` | BG II.C.4 |
| Total_Spend | chi phí chiến dịch; tổng chi phí | ngân sách, spend | = `acquisition_cost` × `conversions` (BG); dữ liệu không có cột này | BG II.A.8, III.B nhóm 3; PL |
| `roi` | ROI (lợi tức đầu tư) | tỷ suất hoàn vốn, lợi nhuận | = (doanh thu − chi phí) / chi phí; cột `roi` làm tròn 2 chữ số | BG II.C.5; NEU-TCCT ("lợi tức đầu tư (ROI)") |
| ROI âm | chiến dịch lỗ | "đốt tiền" | | BG II.C.5 |
| ROI = 0 | hoà vốn | | | BG II.C.5 |
| ROAS | ROAS (doanh thu trên chi phí quảng cáo) = doanh thu / chi phí | lợi nhuận trên quảng cáo | không có trong BG; ROAS = ROI + 1 với cách tính chi phí ở đây | DB (công thức) |
| CPC | CPC (chi phí trên mỗi lượt nhấp) = chi phí / lượt nhấp | giá click | không có trong BG; chỉ dùng khi đề định nghĩa | DB (công thức) |
| CPM | CPM (chi phí trên 1.000 lượt hiển thị) = chi phí / lượt hiển thị × 1.000 | | không có trong BG | DB (công thức) |
| AOV | giá trị đơn bình quân = doanh thu / lượt chuyển đổi | giá trị giỏ hàng | BG II.C.4 tính "trung bình mỗi đơn hàng" | BG II.C.4 |
| weighted average | bình quân gia quyền; tỷ lệ của tổng | | BG Lesson 1: "Weighted Average vs Simple Average" | PL |
| simple average | bình quân giản đơn; bình quân của tỷ lệ | trung bình cộng các ROI (khi muốn ROI nhóm) | | PL |
| profit | lợi nhuận của chiến dịch = doanh thu − chi phí | lãi gộp | không trừ giá vốn hàng bán (dữ liệu không có) | BG II.C.5 |
| share | tỷ trọng | thị phần (khi nói trong nội bộ) | | SCM A.2 |

### A.4 Thời gian

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| `calendar` | lịch ngày | bảng ngày | 2024-07-01 → 2025-06-30 | DB |
| `iso_week`, `week_start` | tuần (tuần ISO, bắt đầu thứ Hai) | tuần thứ n (không rõ chuẩn) | tuần 2025-W27 chỉ có 1 ngày trong lịch | DB |
| `is_weekend` | cuối tuần (thứ Bảy, Chủ nhật) | | | DB |
| kỳ dữ liệu | kỳ 7/2024–6/2025; "12 tháng từ tháng 7/2024" | năm tài chính (công ty không công bố) | ngày bắt đầu muộn nhất 24/6/2025 | DB |
| tháng chưa đủ | tháng 6/2025 (dữ liệu tới 24/6) | tháng cuối | | DB |
| MoM | tăng trưởng so với tháng trước | MoM (trong văn) | | SCM A.2 |
| rolling | trượt 7 ngày | rolling | | SCM A.4 |

### A.5 Chất lượng dữ liệu (bản thô `campaigns_raw`, `noise_log`)

| Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| raw data; `campaigns_raw` | dữ liệu thô; bản thô | data bẩn, raw | 3 file CSV có nhiễu | DB |
| clean data; `campaigns` | bản sạch | data chuẩn | | DB |
| noise; `noise_log` | nhiễu; nhật ký nhiễu | lỗi (khi nói chung) | nhiễu là lỗi được chèn có chủ đích để luyện làm sạch | DB |
| missing value | giá trị thiếu; ô trống (NULL) | null value, rỗng | | SG A |
| duplicate | dòng trùng; dòng trùng hoàn toàn | bản ghi lặp, trùng lặp | | SG A |
| funnel error | phễu vô lý (tầng sau lớn hơn tầng trước) | lỗi logic phễu | | DB |
| negative value | giá trị âm | số lỗi | | DB |
| invalid date | ngày không hợp lệ (sai định dạng, không tồn tại, ngoài kỳ) | ngày lỗi | | DB |
| whitespace | khoảng trắng thừa (đầu/cuối chuỗi) | dấu cách thừa | | DB |
| data cleaning | làm sạch dữ liệu | clean data (động từ) | | BG; SG |
| reconciliation | đối soát | khớp số | | SCM |
| `row_index` | vị trí dòng trong file | số thứ tự | 0 là dòng dữ liệu đầu | DB |

### A.6 Dữ liệu và SQL (chỉ dùng trong `yeucau`, `rangbuoc`, `\goiy`, `\luuy`, `\ghichuthietke`; KHÔNG dùng trong `\boicanh`)

Kế thừa nguyên văn `STYLE-scm.md` mục A.5 (truy vấn con, hàm cửa sổ, bảng dẫn xuất, nối ngoài trái, nửa mở…). Bổ sung:

| Tiếng Anh | Dùng | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| bridge table | bảng cầu nối (chiến dịch – kênh) | bảng trung gian, junction | | DB |
| role-playing dimension | danh mục dùng cho hai vai | | `audiences` nối hai lần với hai bí danh | DB |
| fan-out | nhân dòng khi nối | bùng nổ dòng | | SCM |
| collation NO PAD | so chuỗi có tính khoảng trắng cuối | | `'Email  '` khác `'Email'` | DB |

---

## B. Giọng văn cho từng phần của câu hỏi

Kế thừa nguyên văn `STYLE-scm.md` mục B (nguyên tắc chung 1–6, B.1–B.7: quy tắc, độ dài, mức chỉ dẫn theo cấp, cách viết
`yeucau`, `nghiepvu`, `\goiy`, `\phuongan`, `\khaibaokhainiem`). Chỉ khác ở các điểm sau.

**B.0 Đơn vị và số.** Doanh thu, chi phí viết "đơn vị tiền" (dữ liệu không ghi tiền tệ, BG II.A.7). ROI, ROAS là hệ số, viết "ROI 1,94"
(không thêm "lần", không %); CTR, các tỷ lệ phễu viết %, 2 chữ số. Điểm tương tác là điểm, không là %.

**B.1 Tiêu đề.** Không "campaign", "ads", "funnel", "lead" đứng một mình. Ví dụ đạt:
- `\tieude{Loại chiến dịch nào có CTR cao nhất tháng 5/2025?}` (Viết · Cơ bản)
- `\tieude{ROI toàn thương hiệu Purplle cao bất thường}` (Sửa lỗi · Dễ)
- `\tieude{ROI, ROAS, CPA theo thương hiệu chỉ với một lần quét}` (Tối ưu · Trung bình)
- `\tieude{Nhóm đối tượng nào đáng tăng ngân sách?}` (Case · Khó)

**B.2 Bối cảnh.** Vai có thật ở phòng marketing của một chuỗi mỹ phẩm trực tuyến: Giám đốc marketing, Trưởng phòng marketing số,
Trưởng nhóm quảng cáo trả phí, Chuyên viên SEO, Chuyên viên email marketing, Quản lý thương hiệu (Nykaa / Purplle / Tira Beauty),
Chuyên viên phân tích marketing, Kế toán quản trị, Giám đốc tài chính; Data engineer cho câu Tối ưu; Thực tập sinh cho câu Sửa lỗi cấp thấp.
Xưng hô như SCM B.2. Không "chạy ads", "đốt tiền", "booking KOL", "target" trong lời nhắn (K29). Ví dụ đạt:
- `\boicanh[Chị Ngân · Quản lý thương hiệu Purplle]{Tuần sau chị trình kế hoạch quý 3. Em xem giúp chị loại chiến dịch nào của Purplle có ROI dưới mức chung.}`
- `\boicanh[Anh Quân · Trưởng nhóm quảng cáo trả phí]{Báo cáo tháng trước cộng doanh thu theo kênh ra gấp đôi tổng doanh thu. Em kiểm tra giúp anh sai ở đâu.}`
- `\boicanh[Bạn Linh · Thực tập sinh]{Em đếm chiến dịch theo loại trên file thô mà ra 20 loại. Anh chị xem giúp em.}`

**B.3 Yêu cầu.** Như SCM B.3. Bắt buộc ghi rõ: (1) chỉ số tính theo **tỷ lệ của tổng** hay bình quân từng chiến dịch; (2) tỷ lệ chuyển
đổi chia cho khách hàng tiềm năng (BG) trừ khi đề nói khác; (3) quy tắc hoà bằng `campaign_id` (so theo chuỗi) hoặc mã danh mục;
(4) với câu theo kênh: "chiến dịch chạy nhiều kênh được tính ở mỗi kênh"; (5) với khoảng ngày: nửa mở bằng giá trị DB.

**B.4 Tab Nghiệp vụ.** Như SCM B.4. `\quytrinh` gợi ý: phễu marketing (nhận biết, quan tâm, cân nhắc, chuyển đổi); vòng đời chiến dịch
(lên kế hoạch, khởi chạy, đang chạy, kết thúc, đánh giá); làm sạch dữ liệu (nạp, kiểm tra, sửa, đối soát).
`\luuy` hay dùng: "ROI của một nhóm tính từ tổng doanh thu và tổng chi phí, không lấy bình quân cột \code{roi}."; "Một chiến dịch chạy
nhiều kênh nên doanh thu không chia được cho từng kênh."

**B.6 Kết luận case.** Lỗi lập luận hay gặp để làm phương án sai: lấy bình quân ROI thay ROI của tổng; quy doanh thu cho kênh; so tháng
6/2025 chưa đủ; coi chênh lệch rất nhỏ giữa các nhóm là khác biệt thật (dữ liệu tổng hợp, chênh lệch thường dưới 3%); nhầm đối tượng
mục tiêu với phân khúc khách hàng; coi điểm tương tác là tỷ lệ.

**B.7 Khai báo khái niệm.** Như SCM B.7; dùng mã ở mục E.

---

## C. Khuôn cấm

Kế thừa nguyên văn `STYLE-scm.md` mục C (C.1 kế thừa SG C.2, C.3 và C.2 khuôn K16–K32). Bổ sung cho bộ Marketing:

| # | Khuôn | TRƯỚC | SAU |
|---|---|---|---|
| M1 | Tiếng lóng ngành quảng cáo trong văn | "chạy ads", "đốt tiền", "ra số", "camp", "KOL book", "tệp target" | "chạy quảng cáo trả phí", "chi phí cao", "chiến dịch", "người ảnh hưởng", "đối tượng mục tiêu" |
| M2 | Gọi chỉ số bằng tên tiếng Anh trần, không giải nghĩa | "Tính conversion rate và CPA" | "Tính tỷ lệ chuyển đổi và CPA (chi phí trên mỗi chuyển đổi)" |
| M3 | Gán đơn vị tiền không có trong dữ liệu | "doanh thu 85 tỷ đồng", "rupee" | "doanh thu (đơn vị tiền)" |
| M4 | Quy kết quả cho kênh khi chiến dịch đa kênh | "Instagram mang về nhiều doanh thu nhất" | "Chiến dịch có dùng Instagram có tổng doanh thu cao nhất" |
| M5 | Khẳng định nhân quả từ dữ liệu tổng hợp | "Influencer làm ROI giảm" | "ROI của chiến dịch Influencer thấp hơn mức chung một chút" |
| M6 | Ẩn dụ marketing sáo | "bùng nổ doanh số", "phủ sóng", "viral", "thả thính khách hàng", "hút khách" | số đo cụ thể |

---

## E. Khái niệm khai báo cho bộ Marketing

Cột "trong bộ dữ liệu" đã đối chiếu cấu trúc MySQL `mkt` (10/11/2026). Mỗi gói chỉ khai báo khái niệm gói dùng.

| # | Mã | Tên | Bảng chính | Nguồn |
|---|---|---|---|---|
| 1 | `chien-dich` | Chiến dịch marketing | `campaigns` | BG II.A.1 |
| 2 | `chien-dich-dang-chay` | Chiến dịch đang chạy | `campaigns`, `calendar` | DB |
| 3 | `kenh-da-tri` | Kênh của chiến dịch | `campaign_channels`, `channels` | BG II.A.2 |
| 4 | `doi-tuong-va-phan-khuc` | Đối tượng mục tiêu và phân khúc khách hàng | `campaigns`, `audiences` | BG III.B |
| 5 | `pheu-marketing` | Phễu marketing | `campaigns` | BG II.B |
| 6 | `ty-le-roi-pheu` | Tỷ lệ rơi giữa hai tầng | `campaigns` | BG II.B |
| 7 | `ctr` | CTR (tỷ lệ nhấp) | `campaigns` | BG II.C.1 |
| 8 | `ty-le-khtn` | Tỷ lệ khách hàng tiềm năng | `campaigns` | BG II.C.2 |
| 9 | `ty-le-chuyen-doi` | Tỷ lệ chuyển đổi | `campaigns` | BG II.C.3 |
| 10 | `chi-phi-chien-dich` | Chi phí chiến dịch | `campaigns` | BG II.A.8 |
| 11 | `cpa` | CPA (chi phí trên mỗi chuyển đổi) | `campaigns` | BG II.C.4 |
| 12 | `roi` | ROI (lợi tức đầu tư) | `campaigns` | BG II.C.5; NEU-TCCT |
| 13 | `roas` | ROAS | `campaigns` | DB |
| 14 | `cpc-cpm` | CPC và CPM | `campaigns` | DB |
| 15 | `gia-tri-don-bq` | Giá trị đơn bình quân | `campaigns` | BG II.C.4 |
| 16 | `binh-quan-gia-quyen` | Tỷ lệ của tổng và bình quân giản đơn | `campaigns` | PL |
| 17 | `diem-tuong-tac` | Điểm tương tác | `campaigns` | BG III.B |
| 18 | `ky-va-thang-du` | Kỳ dữ liệu và tháng đủ | `campaigns`, `calendar` | DB |
| 19 | `du-lieu-tho` | Dữ liệu thô và bản sạch | `campaigns_raw`, `campaigns` | DB |
| 20 | `nhat-ky-nhieu` | Nhật ký nhiễu | `noise_log` | DB |
| 21 | `dong-trung` | Dòng trùng hoàn toàn | `campaigns_raw` | DB |
| 22 | `ngay-khong-hop-le` | Ngày không hợp lệ | `campaigns_raw.date_raw` | DB |
| 23 | `lan-quet-bang` | Số lần quét bảng | (kế hoạch chạy) | QC |

```latex
\khaibaokhainiem{chien-dich}{Chiến dịch marketing}
  {Chiến dịch marketing là một đợt truyền thông có mục tiêu, thời hạn và ngân sách xác định.}
  {}
  {bảng \code{campaigns}: mỗi dòng là một chiến dịch; \code{start_date} là ngày bắt đầu, \code{duration_days} là thời lượng (ngày). Ba thương hiệu trong \code{brands}.}
\khaibaokhainiem{chien-dich-dang-chay}{Chiến dịch đang chạy}
  {Chiến dịch đang chạy vào một ngày là chiến dịch đã bắt đầu và chưa qua ngày cuối.}
  {start\_date $\le$ ngày xét $\le$ start\_date + duration\_days $-$ 1}
  {dữ liệu không có ngày kết thúc; ngày cuối tính từ \code{start_date} và \code{duration_days}. Lịch ngày ở \code{calendar}.}
\khaibaokhainiem{kenh-da-tri}{Kênh của chiến dịch}
  {Kênh là nền tảng mà chiến dịch xuất hiện. Một chiến dịch có thể chạy đồng thời trên nhiều kênh.}
  {}
  {bảng cầu nối \code{campaign_channels} (một dòng cho mỗi cặp chiến dịch, kênh), tên kênh ở \code{channels}. Mỗi chiến dịch có 1 tới 3 kênh; doanh thu và lượt chuyển đổi chỉ ghi cho cả chiến dịch, không tách được theo kênh.}
\khaibaokhainiem{doi-tuong-va-phan-khuc}{Đối tượng mục tiêu và phân khúc khách hàng}
  {Đối tượng mục tiêu là nhóm người mà chiến dịch nhắm tới. Phân khúc khách hàng là nhóm khách được ghi nhận cho chiến dịch.}
  {}
  {\code{campaigns.target_audience_id} và \code{campaigns.segment_id} cùng tham chiếu bảng \code{audiences} (5 nhóm). Hai cột độc lập nhau; muốn có cả hai tên thì nối \code{audiences} hai lần.}
\khaibaokhainiem{pheu-marketing}{Phễu marketing}
  {Phễu marketing mô tả hành trình khách hàng qua bốn tầng nhận biết, quan tâm, cân nhắc và chuyển đổi; số người giảm dần qua từng tầng.}
  {}
  {bốn cột \code{impressions}, \code{clicks}, \code{leads}, \code{conversions} của \code{campaigns} ứng với bốn tầng.}
\khaibaokhainiem{ty-le-roi-pheu}{Tỷ lệ rơi giữa hai tầng}
  {Tỷ lệ rơi là phần người không đi tiếp từ một tầng của phễu sang tầng kế tiếp.}
  {1 $-$ số lượng tầng sau / số lượng tầng trước}
  {tính trên tổng của nhóm chiến dịch; mẫu số là tầng ngay trước, không phải lượt hiển thị.}
\khaibaokhainiem{ctr}{CTR (tỷ lệ nhấp)}
  {CTR đo phần lượt hiển thị dẫn tới một lượt nhấp vào quảng cáo.}
  {lượt nhấp / lượt hiển thị $\times$ 100\%}
  {\code{clicks} / \code{impressions}. CTR của một nhóm tính từ tổng lượt nhấp chia tổng lượt hiển thị.}
\khaibaokhainiem{ty-le-khtn}{Tỷ lệ khách hàng tiềm năng}
  {Tỷ lệ khách hàng tiềm năng đo phần lượt nhấp trở thành khách hàng tiềm năng, tức người để lại thông tin hoặc đăng ký.}
  {khách hàng tiềm năng / lượt nhấp $\times$ 100\%}
  {\code{leads} / \code{clicks}.}
\khaibaokhainiem{ty-le-chuyen-doi}{Tỷ lệ chuyển đổi}
  {Tỷ lệ chuyển đổi đo phần khách hàng tiềm năng thực hiện mua hàng.}
  {lượt chuyển đổi / khách hàng tiềm năng $\times$ 100\%}
  {\code{conversions} / \code{leads}. Một số tài liệu chia cho lượt nhấp; bộ này theo cách chia cho khách hàng tiềm năng trừ khi đề ghi khác.}
\khaibaokhainiem{chi-phi-chien-dich}{Chi phí chiến dịch}
  {Chi phí chiến dịch là toàn bộ số tiền đã chi cho một chiến dịch.}
  {acquisition\_cost $\times$ conversions}
  {dữ liệu không có cột tổng chi phí; \code{acquisition_cost} là chi phí trên một lượt chuyển đổi. Đơn vị tiền không được ghi.}
\khaibaokhainiem{cpa}{CPA (chi phí trên mỗi chuyển đổi)}
  {CPA là số tiền bình quân phải chi để có một lượt chuyển đổi.}
  {tổng chi phí / tổng lượt chuyển đổi}
  {cột \code{acquisition_cost} là CPA của từng chiến dịch. CPA của một nhóm tính lại từ tổng, không lấy bình quân \code{acquisition_cost}.}
\khaibaokhainiem{roi}{ROI (lợi tức đầu tư)}
  {ROI phản ánh phần lợi nhuận thu về trên mỗi đơn vị chi phí marketing. ROI dương là có lãi, bằng 0 là hoà vốn, âm là lỗ.}
  {(doanh thu $-$ chi phí) / chi phí}
  {cột \code{roi} của \code{campaigns} đã tính sẵn và làm tròn 2 chữ số. ROI của một nhóm tính từ tổng doanh thu và tổng chi phí, không lấy bình quân \code{roi}.}
\khaibaokhainiem{roas}{ROAS}
  {ROAS đo doanh thu thu về trên mỗi đơn vị chi phí quảng cáo.}
  {doanh thu / chi phí}
  {chi phí tính như khái niệm chi phí chiến dịch; với cách tính này ROAS bằng ROI cộng 1.}
\khaibaokhainiem{cpc-cpm}{CPC và CPM}
  {CPC là chi phí bình quân cho một lượt nhấp. CPM là chi phí cho một nghìn lượt hiển thị.}
  {CPC = chi phí / lượt nhấp; CPM = chi phí / lượt hiển thị $\times$ 1.000}
  {chi phí tính từ \code{acquisition_cost} $\times$ \code{conversions}; dữ liệu không ghi giá thầu theo lượt nhấp hay lượt hiển thị.}
\khaibaokhainiem{gia-tri-don-bq}{Giá trị đơn bình quân}
  {Giá trị đơn bình quân là doanh thu bình quân của một lượt chuyển đổi.}
  {doanh thu / lượt chuyển đổi}
  {\code{revenue} / \code{conversions}; mỗi lượt chuyển đổi được coi là một đơn hàng.}
\khaibaokhainiem{binh-quan-gia-quyen}{Tỷ lệ của tổng và bình quân giản đơn}
  {Tỷ lệ của tổng là tỷ số giữa hai tổng của cả nhóm; bình quân giản đơn là trung bình cộng tỷ lệ của từng chiến dịch. Tỷ lệ của tổng là bình quân gia quyền theo mẫu số.}
  {tổng tử số / tổng mẫu số}
  {với ROI, CPA hai cách cho kết quả khác xa nhau; đề nào không ghi khác thì dùng tỷ lệ của tổng.}
\khaibaokhainiem{diem-tuong-tac}{Điểm tương tác}
  {Điểm tương tác là điểm tổng hợp phản ánh mức người xem tương tác với nội dung của chiến dịch.}
  {}
  {\code{engagement_score}, thang điểm từ khoảng 2,5 tới 31; không phải tỷ lệ phần trăm và không cộng dồn giữa các chiến dịch.}
\khaibaokhainiem{ky-va-thang-du}{Kỳ dữ liệu và tháng đủ}
  {Kỳ dữ liệu là khoảng thời gian có ghi nhận chiến dịch. Tháng đủ là tháng có dữ liệu cho mọi ngày.}
  {}
  {\code{start_date} từ 1/7/2024 tới 24/6/2025; tháng 6/2025 chưa đủ. Lịch \code{calendar} phủ 1/7/2024 tới 30/6/2025.}
\khaibaokhainiem{du-lieu-tho}{Dữ liệu thô và bản sạch}
  {Dữ liệu thô là dữ liệu đúng như khi nhận từ nguồn, chưa kiểm tra hay sửa. Bản sạch là dữ liệu đã loại lỗi.}
  {}
  {\code{campaigns_raw} giữ nguyên ba file có nhiễu (chuỗi gốc, ô trống thành NULL, có dòng trùng); \code{campaigns} là bản sạch. Khoá dòng của bản thô là (\code{brand_id}, \code{row_index}).}
\khaibaokhainiem{nhat-ky-nhieu}{Nhật ký nhiễu}
  {Nhật ký nhiễu ghi lại từng lỗi đã được chèn vào dữ liệu thô để luyện làm sạch.}
  {}
  {\code{noise_log}: \code{noise_type} là chuỗi (\code{'NULL'}, \code{'FUNNEL_ERROR'}, \code{'DUPLICATE'}, \code{'INVALID_DATE'}, \code{'NEGATIVE'}, \code{'WHITESPACE'}); \code{old_value}, \code{new_value} là chuỗi. Nối với bản thô theo \code{brand_id} và \code{row_index}.}
\khaibaokhainiem{dong-trung}{Dòng trùng hoàn toàn}
  {Dòng trùng hoàn toàn là dòng giống một dòng khác ở mọi cột nghiệp vụ.}
  {}
  {so mọi cột của \code{campaigns_raw} trừ \code{raw_id} và \code{row_index} (hai cột vị trí luôn khác nhau).}
\khaibaokhainiem{ngay-khong-hop-le}{Ngày không hợp lệ}
  {Ngày không hợp lệ là giá trị ngày trống, sai định dạng, không tồn tại trên lịch hoặc nằm ngoài kỳ dữ liệu.}
  {}
  {\code{campaigns_raw.date_raw} là chuỗi dạng \code{'DD-MM-YYYY'}; đọc bằng \code{STR\_TO\_DATE(date\_raw, '\%d-\%m-\%Y')}.}
\khaibaokhainiem{lan-quet-bang}{Số lần quét bảng}
  {Số lần máy phải đọc một bảng để trả lời truy vấn. Mỗi truy vấn con độc lập thường đọc lại bảng.}
  {}
  {đếm từ kế hoạch chạy (\code{EXPLAIN ANALYZE}) của MySQL.}
```

---

## F. Điểm cần giảng viên chốt

1. Tỷ lệ chuyển đổi chia cho khách hàng tiềm năng (theo BG) hay cho lượt nhấp (nhiều tài liệu phổ thông). Bản nháp theo BG.
2. "lượt nhấp" (đề) hay "lượt click" (BG). Bản nháp dùng "lượt nhấp", giải nghĩa "(click)" lần đầu.
3. CPC, CPM, ROAS không có trong BG: có cho vào đề không (bản nháp: được, kèm định nghĩa trong khái niệm).
4. Thiếu nguồn giáo trình NEU/UEH/TMU mở được toàn văn: cần giảng viên cung cấp bản giáo trình Marketing căn bản / Truyền thông
   marketing để thay các nguồn bài báo ở mục 0.

## G. Ánh xạ 6 khoá mảng nghiệp vụ (`domain`) sang bộ Marketing

Không thêm khoá mới. Marketing là mảng chủ đạo; mỗi câu chọn khoá theo **quyết định mà câu hỏi phục vụ**.

| Khoá | Nhãn đề xuất cho `\khaibaodomain` | Phạm vi trong bộ này | Ví dụ |
|---|---|---|---|
| `marketing` | Marketing | loại chiến dịch, kênh, phễu (CTR, tỷ lệ rơi), điểm tương tác, nhịp mở chiến dịch theo thời gian | CTR theo loại; kênh có mặt trong bao nhiêu chiến dịch |
| `customer` | Khách hàng | đối tượng mục tiêu, phân khúc khách hàng, ngôn ngữ của chiến dịch, giá trị đơn theo phân khúc | doanh thu theo đối tượng; hai vai của `audiences` |
| `finance` | Tài chính | chi phí chiến dịch, CPA, ROI, ROAS, ngân sách, đối soát ROI tính sẵn | ROI tổng theo thương hiệu; Pareto doanh thu |
| `sales` | Bán hàng | doanh thu, lượt chuyển đổi, tỷ lệ chuyển đổi, tăng trưởng doanh thu theo tháng, top chiến dịch theo doanh thu | top 3 doanh thu mỗi thương hiệu; MoM |
| `operations` | Vận hành | vận hành chiến dịch (lịch, thời lượng, chiến dịch đang chạy mỗi ngày), vận hành dữ liệu chiến dịch (làm sạch, dòng trùng, ngày lỗi, đối soát nhật ký nhiễu) | chiến dịch đang chạy theo tuần; hồ sơ NULL |
| `after_sales` | Hậu mãi | **không có dữ liệu** (không có trả hàng, đánh giá, chăm sóc sau mua). Không dùng khoá này cho bộ Marketing | |

### Quyết định chung 5 bộ (theo `QUYET-DINH-CHUNG.md`, 10/11/2026)

Áp chung cho `scm`, `aivb`, `jelly`, `hr`, `mkt`. Lệch với chỗ khác trong file này thì theo các dòng dưới. **Thứ tự ưu tiên: `quy_chuan` (quy_chuan.rar) > `QUYET-DINH-CHUNG.md` > file STYLE này > brief.** Chi tiết, căn cứ và bảng các điểm đã sửa theo quy chuẩn (10/11, 23:05) ở `QUYET-DINH-CHUNG.md` mục 0.

- **Kết luận case** (sửa theo quy_chuan: goi-cau-hoi-mau/cau-hoi.tex, câu c1–c4, lúc 10/11, 23:05): ba phương án, đúng một `\phuongan*`. Lời giải thích của phương án đúng mở bằng **"Đúng: "** rồi nêu căn cứ; phương án sai **không có tiền tố**, nêu thẳng chỗ sai. Không dùng "Chưa đúng.", "Sai:". 1–2 câu, ≤ 35 tiếng (lời giải thích dài nhất của mẫu, c3, khoảng 34 tiếng), nêu bước nào cho thấy điều gì.
- **Case Cơ bản:** được `GROUP BY` một cột + một hàm gom trên **một bảng** (theo case mẫu `c1-kenh-nhieu-don` của CHOT); không `JOIN`, `HAVING`, truy vấn con. Ghi lý do một dòng ở `\ghichuthietke`.
- **Gợi ý** (sửa theo quy_chuan: cau-hoi.tex w1, w3, o3, o4; Huong-dan mục 10 bước 7): 1–2 nấc ở câu, 1 nấc ở mỗi bước case. Nấc đầu nêu hướng (bảng cần dùng, cách tách bước, bẫy); nấc cuối được nêu trọn **một biểu thức một dòng**, kể cả giá trị lọc hoặc tiêu chí hoà, như mẫu w3 `ROW_NUMBER() OVER (PARTITION BY category ORDER BY doanh_thu DESC, product_id)`. Không viết sẵn cả câu SQL, không khung nhiều dòng. **Bỏ** yêu cầu "để trống ít nhất một thành phần".
- **ERD** (sửa một phần theo quy_chuan: CHOT-FORMAT mục 3, Huong-dan mục 5, mẫu w4, d4, o4, c4): số bảng Cơ bản 1 · Dễ 2 · Trung bình 3–4 · Khó 5–7. Bảng nhiễu: Cơ bản 0 · Dễ ≤ 1 · Trung bình ≤ 1 (quy ước bổ sung) · Khó 1–2, bắt buộc có; câu Khó mà lời giải dùng ≤ 3 bảng được thêm bảng nhiễu cho đủ 5 bảng như mẫu d4, o4. ERD Khó **chỉ khoá, không vẽ `\erdnoi`**; cách nối viết trong `\erdkhoa`. Bảng nhiễu ở Dễ, Trung bình có đường nối đúng với bảng dùng; ở Khó nên có cột khoá chung với bảng dùng (mẫu w4) nhưng không bắt buộc (mẫu o4). Bảng nhiễu không làm tăng cấp.
- **Cấp** (sửa một phần theo quy_chuan: Huong-dan mục 6, lo-trinh-sql/assets/js/data.js): theo thang `QUYET-DINH-CHUNG.md` mục 2: cấp = mức mà ≥ 3/5 trục đạt (số bảng lời giải cần, số bước, mức mơ hồ, số bẫy, độ sâu nghiệp vụ). Ở M1–3: Dễ = Cơ bản + một bẫy hoặc một bước. **Bỏ ngoại lệ "M7, M8 không có Dễ"**: lộ trình chuẩn cho mọi module đủ 4 cấp; sửa lỗi một chỗ dễ thấy là Dễ, muốn Trung bình thì lỗi phải khó thấy (nối thừa nhân dòng, sai phạm vi cửa sổ) hoặc thêm lỗi, bẫy thật. Câu Khó không bắt buộc ≥ 4 bảng (mẫu o4 dùng 1 bảng). Optimize lấy cấp theo mẫu kỹ thuật của CHOT mục 4.
- **Yêu cầu (`yeucau`):** thứ tự sắp luôn kết thúc bằng một khoá duy nhất; top N nói rõ lấy đúng N dòng hay lấy cả người hoà; ghi số chữ số và kiểu làm tròn, chỉ làm tròn cột cuối; tỷ lệ trả phần trăm 2 chữ số (tên cột tuỳ: mẫu dùng cả `ty_le_tra` lẫn `thay_doi_pct`), nếu bắt buộc trả 0–1 thì 4 chữ số và đặt `saiso=0.0001`; NULL nói rõ giữ NULL, thay bằng giá trị gì, hay loại dòng; tháng, quý trả chuỗi theo dạng ghi trong đề; năm trả số, trừ khi đề ghi rõ trả chuỗi như mẫu o2; mốc thời gian ghi cả cận dưới và cận trên.
- **Tiêu đề** (sửa theo quy_chuan: tiêu đề mẫu w3, w4, o3, o4 dài 11–13 tiếng): ngắn, **≤ 13 tiếng**. Câu Tối ưu được nêu ràng buộc trong tiêu đề ("… chỉ với một lần quét", "… không dùng tự nối bảng") như mẫu o1, o4; các loại khác không nhắc kỹ thuật SQL ở tiêu đề (quy ước bổ sung). Bối cảnh không nhắc tên kỹ thuật SQL (CHOT-FORMAT mục 3).
- **Riêng mkt:** các câu Dễ ở gói 1 (r4, r5, r6, n3, n5, n9) giữ cấp với ERD 2 bảng có 1 bảng nhiễu, mỗi câu phải có một bẫy hoặc một bước thêm so với Cơ bản. mkt-k8 hạ Dễ; mkt-p1 lấy cấp theo mẫu optimize của CHOT. mkt-t7 chấm lại cấp theo dòng **Cấp** (bỏ ngoại lệ M7, sửa theo quy_chuan lúc 10/11, 23:05).
