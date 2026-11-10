# Đã sửa · gói 2 · Marketing (`mkt`) · v2

Theo `REVIEW-B.md`, `REVIEW-C.md` và lời nhắn điều phối 10/11/2026. Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại: gói tạm `cong-cu/ket-qua/sua/mkt-goi-2/` (7 câu có sửa SQL hoặc yêu cầu: s6, a2, a6, a7, a8, c3, c4) chạy bộ kiểm thật; cả gói chạy `--chi-phan-tich`; biên dịch lại cả gói ra `cong-cu/ket-qua/bien-dich/mkt-goi-2/`.

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| `mkt-s1-social-nykaa-theo-thang` | B(1)(2): `\luuy` bỏ vế nói thẳng cận trên và câu lặp "tháng 6/2025 chưa đủ"; gợi ý 2 giữ vai trò đó. | tĩnh |
| `mkt-s2-ket-thuc-ngay-14-2` | C: tiêu đề còn 10 tiếng, bỏ "Influencer" trần; mục yêu cầu mở bằng động từ, bỏ câu về chiến dịch 1 ngày (không có trong dữ liệu); gợi ý 1 bỏ "cộng thẳng"; câu nghiệp vụ không gọi "chiến dịch Valentine". | tĩnh |
| `mkt-s3-bat-dau-cuoi-tuan` | B(1) tiêu đề "Mỗi loại chiến dịch có bao nhiêu phần trăm bắt đầu vào cuối tuần?"; B(2) `\luuy` bỏ "đáng chú ý", dùng mốc hai phần bảy; phá khuôn "Cho từng X". | tĩnh |
| `mkt-s4-ba-kenh-youtube-dau` | C: tiêu đề thành câu hỏi số đếm; bối cảnh tách câu, bỏ "mà… vì…"; yêu cầu bỏ lý do lộ bẫy dòng trùng, phá khuôn "Đếm cho từng"; mẹo đếm dấu phẩy chuyển từ `\luuy` sang gợi ý 1; gợi ý 2 chỉ nêu hàm, không viết sẵn biểu thức. | tĩnh |
| `mkt-s5-ngay-tho-khong-doc-duoc` | B(1) bối cảnh có câu nhờ, bỏ "mà"; B(2)(3) `\luuy` chỉ còn câu chung "ngày đọc được vẫn có thể nằm ngoài kỳ"; giá trị cụ thể và câu về NULL chuyển sang gợi ý 1 (viết lại "luôn ra NULL, không đúng cũng không sai"). | tĩnh |
| `mkt-s6-so-duoi-ma-lon-nhat` | C (gần hằng số): thu phạm vi về chiến dịch bắt đầu ngày 24/6/2025, ngày cuối có dữ liệu; kết quả khác nhau giữa các thương hiệu (public 4/2/10 chiến dịch, dải số khác nhau) và trả lời câu "mã có cấp theo ngày mở không" (không). Wrong `max_theo_chuoi` giờ sai cả giá trị ('5403' lớn hơn '38888' theo chữ). Bối cảnh bỏ "đang chạy", "liền mạch"; `\luuy` bỏ bị động, bỏ "Muốn… thì phải…"; tiêu đề bỏ "số mấy"; phá khuôn "Cho từng". | bộ kiểm (gói tạm) |
| `mkt-s7-dem-loai-ra-20-nhom` | B(1) tiêu đề "Đếm dòng thô theo loại chiến dịch ra 20 nhóm"; B(2) "MySQL so chuỗi có tính cả khoảng trắng". Trùng TRIM với a8: xử lý ở a8. | tĩnh |
| `mkt-s8-thang-sap-sai-thu-tu` | C: bối cảnh tả đúng triệu chứng (7/2024 nằm giữa bảng), có câu nhờ, "báo cáo 12 tháng" thay "báo cáo năm"; `\luuy` bỏ bị động và bỏ câu cho sẵn cách sửa. | tĩnh |
| `mkt-s9-dang-chay-ngay-1-1` | B (không bắt buộc): `\luuy` không còn nói cách sửa, chỉ nêu quy ước lịch chạy; phá khuôn "cho từng thương hiệu" ở yêu cầu. Giữ hai wrong (so ngày cuối với '2024-12-31' bằng `>` cho đúng kết quả nên không dùng làm wrong). | tĩnh |
| `mkt-a1-roi-tong-theo-thuong-hieu` | C: `\luuy` bỏ ẩn dụ "kéo"; yêu cầu mở bằng động từ. | tĩnh |
| `mkt-a2-pheu-theo-loai` | B(1) tiêu đề không còn hỏi loại "tốt nhất"; B(2) bối cảnh; B(3) yêu cầu bớt lặp "tỷ lệ"; cận trên chưa được kiểm → thêm cột `so_chien_dich` và wrong `thieu_can_tren` (rớt ở hidden-1). | bộ kiểm (gói tạm) |
| `mkt-a3-doi-tuong-quy-1` | C: tiêu đề "Nhóm đối tượng nào dẫn đầu doanh thu quý 1/2025?"; `\luuy` viết lại định nghĩa không đọc nhầm; phá khuôn "Cho từng". | tĩnh |
| `mkt-a4-bang-cheo-ngon-ngu` | B(1) hạ `medium` → `easy`, ERD 2 bảng có chữ trên đường nối; B(2) bối cảnh có câu nhờ, "lượt chuyển đổi" thay "đơn". SQL không đổi. | tĩnh |
| `mkt-a5-ngay-tren-350-co-lai` | C: tiêu đề và bối cảnh sửa trật tự từ ("khởi chạy hơn 350 chiến dịch có lãi"); phá khuôn "Cho từng"; `\luuy` chỉ còn quy tắc nghiệp vụ hoà vốn, phần WHERE/HAVING chuyển sang gợi ý 1. Ngưỡng và mã: Chờ giảng viên (ghi trong `\ghichuthietke`). SQL không đổi. | tĩnh |
| `mkt-a6-doanh-thu-nykaa-theo-thang` | B: wrong mắc hai lỗi một lúc → đề v2 lấy "từ 1/7/2024 tới hết dữ liệu hiện có" (không mốc cuối), wrong `gom_theo_thang_bo_nam` chỉ còn lỗi bỏ năm, trùng lời giải ở public và rớt ở hidden-1; thêm wrong bình quân giản đơn giá trị đơn (rớt ở public). Đổi chủ đề sang giá trị đơn bình quân, bỏ cột số chiến dịch (không trùng s1, c3). Hạ `medium` → `easy`, ERD 2 bảng. `\luuy` bỏ câu khẩu hiệu; bối cảnh "gửi đối tác", có câu nhờ. Thêm khái niệm `gia-tri-don-bq`. | bộ kiểm (gói tạm) |
| `mkt-a7-roi-thuong-hieu-cao-bat-thuong` | C: wrong `avg_roi_tinh_lai` trùng starter → thay bằng `chi_phi_quen_nhan_chuyen_doi`; kỳ đổi sang nửa cuối 2024 để đáp số không trùng a1; `\luuy` bỏ ẩn dụ "một phiếu", "phải để". | bộ kiểm (gói tạm) |
| `mkt-a8-so-chien-dich-tho-thua` | B(1) hạ `medium` → `easy`; B(2) bỏ phần gom `TRIM(campaign_type)` (không trùng s7), trả một dòng `so_dong`, `so_chien_dich`; starter `COUNT(campaign_id)`; B(3) thay `bo_trim` bằng `COUNT(DISTINCT campaign_type)`. ERD 2 bảng. | bộ kiểm (gói tạm) |
| `mkt-a9-doanh-thu-theo-quy-gop-sai` | C: tiêu đề "Doanh thu theo quý không ghi năm" (thấy được trên public); bối cảnh 2 câu; `\luuy` bỏ "cận dưới, cận trên", "phải có", bỏ câu khẩu hiệu. SQL không đổi. | tĩnh |
| `mkt-c3-thang-purplle-mo-nhieu-nhat` | B: K32 → ba phương án dài gần bằng nhau, từ rào "có thể" có ở cả phương án đúng và một phương án sai; số trong phương án đúng chính xác (chênh bình quân mỗi ngày chưa tới 10\%). Trùng s1/a6 → đổi thương hiệu sang Purplle (mã giữ nguyên, tiêu đề đổi); `\luuy` không lặp "tháng 6/2025 chưa đủ"; phá khuôn "Cho từng". | bộ kiểm (gói tạm) |
| `mkt-c4-loai-roi-duoi-muc-chung` | C: K32 → phương án theo đề xuất của C (dài gần bằng nhau, phương án sai thứ ba có từ rào, bỏ "kéo"); "chưa tới 0,03" thay "hai phần trăm"; `\luuy` bỏ câu nói trước kết luận; b2 wrong `AVG(roi)` không bắt được lỗi bình quân năm loại → thay bằng `doanh_thu_chia_chi_phi` (ROAS) và `thieu_can_tren`; ghi chú thiết kế ghi rõ vì sao không dùng bình quân năm ROI loại; phá khuôn "Cho từng". | bộ kiểm (gói tạm) |

## Chờ giảng viên (đã quyết ở v3, xem mục "Quyết định v3 (10/11)")

1. `mkt-a5-ngay-tren-350-co-lai`: mã nói 500 chiến dịch, đề nói 350 chiến dịch có lãi (tháng 3/2025 chỉ 2 ngày trên 500). Ngưỡng đặt trên số đếm gần như chỉ phản ánh số chiến dịch mở trong ngày (tỷ lệ có lãi mỗi ngày 75–80\%). Cần chốt: giữ số đếm để dạy HAVING, thêm cột tỷ lệ, hay đổi mã (nếu mã chưa công bố). Cấp Trung bình cũng sát Dễ (review C).
2. `mkt-s4-ba-kenh-youtube-dau`: lý do "đại lý YouTube đối soát theo kênh ghi đầu" hơi gượng (review C); chưa có tình huống thật hơn.
3. `mkt-c3-thang-purplle-mo-nhieu-nhat`: mã còn chữ "nykaa" nhưng v2 hỏi Purplle (không đổi mã theo BRIEF-SUA-GOI mục 3).

## Quyết định v3 (10/11)

BG = `lesson1_marketing_analytics_foundations.md`, thư mục `Project 01 Marketing Analytics Foundations & Data Pipeline` (ổ H:). QĐC = `QUYET-DINH-CHUNG.md`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `mkt-a5-ngay-tren-350-co-lai` (cũ `mkt-a5-ngay-tren-500-chien-dich`) | Ngưỡng 350 chiến dịch có lãi; mã còn "500" | Giữ ngưỡng trên số đếm (câu dạy `HAVING` trên đếm có điều kiện, M4); không thêm cột tỷ lệ. Đổi mã cho khớp đề. Giữ Trung bình (gom + đếm có điều kiện + `HAVING` + cận trên). | BAO-CAO 3.3, 3.6; BG IV.D (ba thương hiệu và các loại chiến dịch chênh nhau rất nhỏ, nên tỷ lệ có lãi theo ngày cũng ít khác nhau, ghi rõ trong ghi chú là câu không dùng để so hiệu quả giữa các ngày). | Đổi `ma` đồng bộ 5 file; `\ghichuthietke` thay đoạn "Chờ giảng viên" bằng quyết định. SQL không đổi. |
| `mkt-c3-thang-purplle-mo-nhieu-nhat` (cũ `…-nykaa-…`) | Mã còn "nykaa", đề hỏi Purplle | Đổi mã. | BAO-CAO 3.6. | Đổi `ma` đồng bộ. |
| `mkt-s4-ba-kenh-youtube-dau` | Lý do "đại lý YouTube đối soát theo kênh ghi đầu" gượng | Viết lại bối cảnh: lấy số đối chiếu trước khi dùng bảng đã tách chuỗi kênh thành từng kênh. SQL, yêu cầu, bẫy giữ. | BG III.B, lưu ý "Channel_Used là multi-value": "Khi phân tích theo từng kênh riêng lẻ ở Lesson 2, chúng ta sẽ cần tách cột này ra". Tách cột là bước có thật của dự án; thứ tự ghi trong chuỗi không mang nghĩa ưu tiên (STYLE-mkt A.1) nên không dựng lý do nghiệp vụ trên kênh ghi đầu. | `\boicanh` và câu mục đích của tab Nghiệp vụ. |

Kiểm: bộ kiểm đầy đủ gói 2 **KIEM TRA: 0 loi**; biên dịch lại (xem cuối mục).

### Sửa lúc 23:15 theo QUYET-DINH-CHUNG bản 23:05 (đối chiếu quy chuẩn)

- Kết luận case (QĐC 0.1 #1, theo `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4): lời giải thích của phương án đúng mở bằng "Đúng: "; phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Áp cho mọi case của gói.

### Chuẩn hoá theo quy chuẩn (10/11, BRIEF-CHUAN-HOA)

Xem `../CHUAN-HOA.md` (tiêu đề ≤ 13 tiếng, gợi ý nấc cuối, kết luận case ≤ 35 tiếng, ERD theo CHOT mục 3, cấp). File hồ sơ chuyển từ `goi-2/` sang `ho-so/goi-2/`.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md` (quy chuẩn `data.js`: mọi module đủ Cơ bản → Khó). Mục tiêu mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug; case c3 (Cơ bản), c4 (Dễ) giữ cấp. Agent v4 trước dừng vì giới hạn lượt gọi trước khi sửa gì (`TRANG-THAI-V4.md`); lần này làm từ đầu trên bản v3.

Phân bổ (đếm lại từ `cau-hoi.tex`): **M3** trước 3 Cơ bản (s1, s2, s7) · 6 Dễ → sau 2 Cơ bản (s2, s7) · 3 Dễ (s4, s5, s6) · 2 Trung bình (s1, s8) · 2 Khó (s3, s9). **M4** trước 7 Dễ · 2 Trung bình (a5, a9) → sau 2 Cơ bản (a3, a6) · 3 Dễ (a2, a4, a8) · 2 Trung bình (a5, a9) · 2 Khó (a1, a7). Số câu đổi cấp: 8, là số tối thiểu (M3 phải bỏ 1 Cơ bản và 3 Dễ để có 2 Trung bình, 2 Khó; M4 phải bỏ 4 Dễ để có 2 Cơ bản, 2 Khó). Viết lại 6 câu (đổi mã), hạ 2 câu (giữ mã: a3 giữ SQL; a6 bỏ cột giá trị đơn, thêm cận trên). Hình thức mỗi module vẫn 6 write + 3 debug; debug trải đều Cơ bản, Trung bình, Khó (M3: s7, s8, s9) và Dễ, Trung bình, Khó (M4: a8, a9, a7).

5 trục ghi theo thứ tự: số bảng lời giải · số bước · mơ hồ · bẫy · nghiệp vụ (B = Cơ bản, D = Dễ, T = Trung bình, K = Khó). Chi tiết từng trục ở `\ghichuthietke` của câu.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục |
|---|---|---|---|
| `mkt-s1-social-nykaa-theo-thang` → `mkt-s1-social-nykaa-chay-sang-thang-sau` | basic → medium (write; B1 mkt giữ) | Viết lại: mỗi tháng 7/2024–5/2025, số chiến dịch Social Media của Nykaa, số chạy sang tháng sau (ngày cuối sau ngày cuối của tháng bắt đầu) và tỷ lệ. Chỉ số định nghĩa ở tab Nghiệp vụ. ERD 3 bảng chỉ ký hiệu n-1. Bài sai quên trừ 1, so `MONTH()` (tháng 12 chạy sang tháng 1 ra 0), giữ tháng 6/2025 chưa đủ | B · T · T · T (2 bẫy) · T → 4/5 T |
| `mkt-s3-bat-dau-cuoi-tuan` → `mkt-s3-tong-ket-cho-qua-cuoi-tuan` | easy → hard (write; A3 ops giữ) | Viết lại: họp tổng kết vào ngày làm việc đầu tiên sau ngày cuối; theo loại, số chiến dịch phải chờ qua cuối tuần, tỷ lệ và tổng số ngày chờ. ERD 5 bảng chỉ khoá, `\erdkhoa`. Bài sai xét thứ của ngày cuối, `DAYOFWEEK IN (6, 7)`, đếm ngày chờ ngược (public); thiếu cận trên (hidden-1, loại 5) | B · K · K · K (4 bẫy, 1 ở hidden-1) · K → 4/5 K |
| `mkt-s8-thang-sap-sai-thu-tu` → `mkt-s8-tuan-dau-nam-bi-tach-doi` | easy → medium (debug; B1 sal → B1 mkt) | Viết lại: số chiến dịch mở theo tuần (thứ Hai tới Chủ nhật) 2/12/2024–2/2/2025; starter gom `YEAR`, `WEEK(…, 1)` tách tuần 30/12/2024–5/1/2025 thành hai dòng (lỗi khó thấy, chỉ ở tuần vắt năm). Đổi mảng sang marketing để không trùng ô B1 · sal · medium · D với a9. ERD 3 bảng chỉ ký hiệu. Bài sai `YEARWEEK` không ghi chế độ, lùi theo `DAYOFWEEK` | B · D · T · T · T; sửa lỗi: 1 lỗi khó thấy → 3/5 T (4 tính cả dòng Sửa lỗi) |
| `mkt-s9-dang-chay-ngay-1-1` → `mkt-s9-dang-chay-dau-thang-lech` | easy → hard (debug; B4 ops giữ) | Viết lại: số chiến dịch đang chạy vào ngày 1 mỗi tháng 8/2024–6/2025 (nối `calendar` theo khoảng ngày); ba lỗi chồng nhau: `start_date < cal_date` bỏ chiến dịch bắt đầu ngày 1, ngày cuối không trừ 1 (hai lỗi bù trừ một phần, tháng thừa tháng thiếu), thiếu cận trên (chỉ lộ ở hidden-1, dòng 2025-07). ERD 5 bảng chỉ khoá, trung tính. Bài sai sửa một đầu (public), sửa hai đầu thiếu cận trên (hidden-1) | D · D · K · K (3 bẫy, 1 ở hidden-1) · T; sửa lỗi: 3 lỗi chồng nhau → 3/5 K |
| `mkt-a1-roi-tong-theo-thuong-hieu` → `mkt-a1-chi-phi-cho-chien-dich-lo` | easy → hard (write; A2 fin giữ) | Viết lại: theo thương hiệu, số chiến dịch lỗ, tỷ trọng chi phí của chiến dịch lỗ và tỷ lệ thu hồi (doanh thu chia chi phí của nhóm lỗ). Lỗ xác định bằng doanh thu nhỏ hơn chi phí; cột `roi` làm tròn nên 198 chiến dịch lỗ rất ít ghi 0,00 (bẫy kiểm trên public). ERD 5 bảng chỉ khoá. Bài sai `roi < 0`, cộng CPA, tỷ trọng theo số chiến dịch, bình quân tỷ lệ thu hồi (public); thiếu cận trên (hidden-1) | B · T · K · K (5 bẫy, 1 ở hidden-1) · K → 3/5 K |
| `mkt-a3-doi-tuong-quy-1` (giữ) | easy → basic | ERD 1 bảng có giá trị mẫu (bỏ `audiences`, cột `segment_id`); đề ghi thẳng cột gom; gợi ý 1 nấc; bỏ bẫy nhầm đối tượng với phân khúc khỏi phần đề (bài sai `segment_id` giữ vì vẫn là lỗi hay gặp). SQL giữ | B · B · B · B · B → 5/5 B |
| `mkt-a6-doanh-thu-nykaa-theo-thang` (giữ) | easy → basic | Bỏ cột giá trị đơn bình quân và bẫy gom tháng bỏ năm; thêm cận trên 30/6/2025; ERD 1 bảng có giá trị mẫu; gợi ý 1 nấc. Mã giữ vì vẫn là doanh thu Nykaa theo tháng. Bài sai `AVG`, `COUNT(cột)` (public), thiếu cận trên (hidden-1) | B · B · B · B · B → 5/5 B |
| `mkt-a7-roi-thuong-hieu-cao-bat-thuong` → `mkt-a7-roi-thang-nykaa-lech-tai-chinh` | easy → hard (debug; A2 fin → B1 fin) | Viết lại theo bài Khó a6 của Module 4 trong lộ trình (bình quân tỷ lệ → tổng chia tổng): chi phí và ROI theo tháng của Nykaa Social Media nửa đầu 2025; ba lỗi chồng nhau: cộng CPA làm chi phí (sai định nghĩa), `AVG(roi)`, thiếu cận trên (hidden-1, dòng 2025-07). Dạng B1 để không trùng ô A2 · fin · hard · D với `mkt-n9-cpc-cpm-nykaa-thang-6-lech` (gói 1). ERD 5 bảng chỉ khoá. Bài sai chỉ sửa ROI, ROI từ tổng CPA, ROAS (public), sửa hai lỗi thiếu cận trên (hidden-1) | B · D · K · K (4 bẫy, 1 ở hidden-1) · T; sửa lỗi: 3 lỗi chồng nhau + sai định nghĩa → 3/5 K |

Kiểm lại:
- Bộ kiểm đầy đủ trên MySQL (`--ra cong-cu/ket-qua/cap-do/mkt-goi-2`): 20 câu, 79 khối SQL, `KIEM TRA: 0 loi`, 0 cảnh báo. Mọi `wrong` của 8 câu rớt đúng biến thể ghi trong `\ghichuthietke` (bài sai thiếu cận trên của s3, s9, a1, a6, a7 chỉ rớt ở hidden-1). Sau lần sửa chữ cuối ở bối cảnh s8: kiểm tĩnh lại 0 lỗi.
- Đo riêng bằng `docker exec … sql_runner` (máy dùng chung với 4 agent): mọi solution và bài sai của 8 câu chạy 0,2–2,0 giây trên mỗi biến thể; md5 kết quả solution public ≠ hidden-1 ở cả 8 câu; không bài sai nào trùng starter.
- Biên dịch XeLaTeX (`cong-cu/ket-qua/cap-do/mkt-goi-2/bien-dich/`): 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo `aio-sql-cauhoi` (58 overfull hbox của dòng SQL dài, chỉ là cảnh báo trình bày như trước).
- Thư mục gói vẫn đúng 4 file; `cau-hoi.tex`, `solution.sql` giữ CRLF như cũ.

Cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6), tự rà mọi trường của 8 câu:
- Đã sửa trong lúc viết: s8 bối cảnh "… ngày 1/1/2025, trong khi hôm đó là thứ Tư" (câu dài nối "trong khi") → tách câu "… ngày 1/1/2025. Hôm đó là thứ Tư."; "ít hẳn các tuần khác" → "ít hẳn so với các tuần khác". a1 tránh "ngân sách" cho chi phí chiến dịch (STYLE-mkt A.3, cột "Không dùng"), dùng "chi phí"; bối cảnh không dùng ẩn dụ ("chảy vào") mà viết "dành … cho".
- Bối cảnh không nhắc kỹ thuật SQL; xưng hô anh/chị/em đúng vai (Chị Trang, Chị Hạnh, Anh Phong như các câu cũ của gói). Tiêu đề ≤ 13 tiếng (s3 đúng 13). Không dấu gạch ngang dài, không khuôn "mệnh đề: kết luận" trong lời nhắn.
- Còn để giảng viên xem: tiêu đề s3 "… mới được tổng kết?" và câu "để tính xem có nên họp bù vào thứ Bảy không" là cách nói công sở, không phải thuật ngữ; nếu muốn gọn có thể đổi "họp tổng kết" thành "tổng kết".

Nghi trùng ô, trùng nội dung:
- Ô (dạng · mảng · cấp · hình thức) của 8 câu không trùng trong gói và không trùng `cau-hoi.tex` các gói 1, 3, 4, 5 đọc lúc 11/11 (các gói này đang được sửa song song, cần đối chiếu lại khi gộp bản đồ). Lần đối chiếu đầu thấy a7 (A2 · fin · hard · D) trùng n9 gói 1 và bản hạ a2 về Cơ bản (A3 · mkt · basic · W) trùng t6 gói 4, nên a7 đổi sang B1 và a2 giữ Dễ (hạ a6 thay).
- Trùng nội dung gần: s9 (đang chạy ngày đầu tháng, Sửa lỗi · Khó) cùng chủ đề "chiến dịch đang chạy" với j4 (gói 3, Viết · Trung bình) và t5 (gói 4, Viết · Khó), khác ô và khác kỹ năng chính; a6 (Nykaa theo tháng) gần c3 (Purplle theo tháng, bình quân mỗi ngày) nhưng khác thương hiệu và chỉ số. Dòng bản đồ mới ở `BAN-DO-V4-DONG.md`.
