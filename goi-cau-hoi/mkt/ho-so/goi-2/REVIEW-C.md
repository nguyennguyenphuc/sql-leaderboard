# REVIEW-C · gói 2 · Marketing (`mkt`)

Người kiểm: C (agent), 10/11/2026. Nhận các câu thứ 2, 4, 6, … trong `cau-hoi.tex`: s2, s4, s6, s8, a1, a3, a5, a7, a9, c4 (10 câu).
Cách làm: tự viết SQL trước khi mở `solution.sql`, chạy trên `mkt` và `mkt_hidden_1` (container `sqllb-mysql`, user `sql_runner`). Sau đó chạy từng khối solution/starter/wrong của 10 câu trên cả hai biến thể và so từng dòng. Không chạy bộ kiểm cho cả gói.
Nháp và kết quả chạy: `cong-cu/ket-qua/review/mkt-goi-2-C/` (`tu-giai.sql`, `tu-giai-*.txt`, `blocks/*.out`).

## Bảng tổng hợp

| Mã | Phiên bản | Kiểm SQL | Kiểm nội dung | Đề xuất sửa chính |
|---|---|---|---|---|
| `mkt-s2-ket-thuc-ngay-14-2` | v1 | **Đạt.** Tự giải khớp solution (public 6 dòng, hidden 4 dòng, khác nhau). Hai wrong rớt ở cả hai biến thể. | **Cần sửa.** Tiêu đề 13 tiếng, "Influencer" để trần; gợi ý 1 khẩu ngữ. | Mục S2 |
| `mkt-s4-ba-kenh-youtube-dau` | v1 | **Đạt.** Khớp (public 3121/3195/3028, hidden 2814/2884/2714). `youtube_moi_vi_tri` ra khoảng 9.200 mỗi thương hiệu; `dem_dong_co_trung` lệch 3–4 dòng ở Nykaa, Purplle. Cả hai rớt ở cả hai biến thể. | **Cần sửa.** Tiêu đề hỏi "chiến dịch nào" nhưng kết quả là số đếm; bối cảnh có câu dài "mà… vì…"; yêu cầu lộ bẫy dòng trùng; gợi ý 2 gần như cả lời giải. | Mục S4 |
| `mkt-s6-so-duoi-ma-lon-nhat` | v1 | **Cần sửa (gần hằng số).** Solution đúng, hai wrong rớt. Nhưng ở public, ba thương hiệu ra **cùng một dòng** 55555 / 1000 / 56554: đáp số là dải mã cố định của bộ sinh dữ liệu, đoán được và không trả lời được câu "có liền mạch không" theo cách có ý nghĩa. Hidden khác (Nykaa 50001 / 56555) nên chép số Chạy thử vẫn rớt. | **Cần sửa.** Bối cảnh dùng "đang chạy" trùng thuật ngữ; câu "liền mạch với số chiến dịch" lủng củng; luuy có "Muốn… thì phải…", khuôn dấu hai chấm, bị động. | Mục S6 |
| `mkt-s8-thang-sap-sai-thu-tu` | v1 | **Đạt.** Khớp. Starter khác solution ở cả hai biến thể; `ten_thang_chu` ('2024-July'…), `giu_nhan_thang_nam` ('07/2024') rớt ở cả hai. | **Cần sửa.** Bối cảnh tả sai triệu chứng: starter đặt 07/2024 ở dòng 7 trên 12 (giữa bảng), không phải "gần cuối". | Mục S8 |
| `mkt-a1-roi-tong-theo-thuong-hieu` | v1 | **Đạt.** Khớp (ROI 1,9545 / 1,9371 / 1,9297). `avg_roi` rớt ở public; `thieu_can_tren` giống ở public, rớt ở hidden (Nykaa 50001). Làm tròn trung gian không gây chấm oan: `chi_phi` làm tròn riêng, ROI tính từ tổng chưa làm tròn, sai số 0,01. | **Cần sửa.** luuy có ẩn dụ "kéo"; yêu cầu mở bằng "Cho từng…". | Mục A1 |
| `mkt-a3-doi-tuong-quy-1` | v1 | **Đạt.** Khớp (public 4, 2, 5, 1, 3; hidden 4, 5, 1, 2, 3). `gom_theo_phan_khuc` đổi nhóm đứng đầu (1 thay 4); `thieu_can_tren` rớt ở public. | **Cần sửa.** luuy "nhóm chiến dịch nhắm tới" đọc nhầm được; tiêu đề 12 tiếng; yêu cầu mở bằng "Cho từng…". | Mục A3 |
| `mkt-a5-ngay-tren-500-chien-dich` | v1 | **Đạt.** Khớp (public 20 ngày, hidden 1 ngày 2025-03-03). Ba wrong đều rớt ở public: `thieu_can_tren` 70 dòng, `having_dem_tat_ca` 31 dòng, `loc_lai_o_where` cột tổng bằng cột lãi. | **Cần sửa + CẦN NGƯỜI NẮM DOMAIN.** Tiêu đề và bối cảnh có trật tự từ kiểu dịch; luuy viết kỹ thuật WHERE/HAVING trong tab Nghiệp vụ. Ngưỡng đặt trên **số** chiến dịch có lãi nên gần như chỉ phản ánh số chiến dịch mở trong ngày (tỷ lệ có lãi khoảng 75–80% mỗi ngày), khó "tìm điểm chung về lịch khởi chạy". Mã nói 500 chiến dịch, đề nói 350 chiến dịch có lãi. | Mục A5 |
| `mkt-a7-roi-thuong-hieu-cao-bat-thuong` | v1 | **Đạt (có ghi chú).** Khớp (55555 / 1,9371; hidden 50000 / 1,9365). Starter `AVG(roi)` = 2,6829, khác solution. `doanh_thu_chia_chi_phi` = 2,9371, rớt. **`avg_roi_tinh_lai` ra đúng bằng starter ở cả hai biến thể** (2,6829 / 2,6853), nên bài sai này không kiểm thêm được gì. Đáp số trùng dòng `brand_id = 2` của A1 trong cùng gói. | **Cần sửa.** luuy có ẩn dụ "một phiếu", câu "phải để" lủng củng. | Mục A7 |
| `mkt-a9-doanh-thu-theo-quy-gop-sai` | v1 | **Đạt.** Khớp (4 dòng 2024-3 … 2025-2). Starter khác ở cả hai biến thể. `them_nam_thieu_can_tren` giống ở public, rớt ở hidden (thêm dòng 2025-3, 1 chiến dịch). `them_can_tren_thieu_nam` rớt ở public. Đúng như thiết kế. | **Cần sửa.** Tiêu đề nêu triệu chứng không thấy trên public; bối cảnh 3 câu khoảng 55 tiếng; luuy dùng "cận dưới, cận trên" và "phải có". | Mục A9 |
| `mkt-c4-loai-roi-duoi-muc-chung` | v1 | **Đạt (có ghi chú).** b1, b2 khớp (ROI chung 1,9405; hidden 1,9383). Influencer và SEO dưới mức chung ở cả hai biến thể, đúng ghi chú thiết kế. Các wrong rớt như mô tả. Ghi chú: wrong b2 tên `binh_quan_roi_cac_loai` nhưng code là `AVG(roi)` của mọi chiến dịch. Lỗi "bình quân năm ROI loại" thật sự ra 1,94048 ≈ 1,9405 (hidden 1,93832 ≈ 1,9383), **trùng đáp án**, nên không bắt được. | **Cần sửa.** Phương án đúng dài nhất (36 tiếng so với 25 và 23) và là phương án **duy nhất có từ rào** (K32). luuy tab Nghiệp vụ nói trước kết luận. "Hai phần trăm" dễ hiểu nhầm với ROI là hệ số. Phương án 3 có "kéo". | Mục C4 |

Kết quả: **SQL Đạt 9 / Cần sửa 1** (s6). **Nội dung Đạt 0 / Cần sửa 10** (a5 cần thêm người nắm domain). **Toàn câu: Đạt 0 / Cần sửa 10.**
Không có câu nào chấm oan hoặc có solution sai. Mọi wrong đều rớt ít nhất một biến thể. Ở cả 10 câu, kết quả public khác hidden-1, nên chép kết quả Chạy thử không qua được.

---

## Chi tiết từng câu (trích nguyên văn → câu sửa)

### S2 · `mkt-s2-ket-thuc-ngay-14-2` (Viết · Cơ bản)
- SQL: đúng cấp (1 bảng, có giá trị mẫu). Quy tắc hoà theo `campaign_id` cần thiết: có hai chiến dịch cùng bắt đầu 2025-01-21.
- `\tieude`: "Chiến dịch Influencer nào của Tira Beauty kết thúc đúng ngày 14/2/2025?" (13 tiếng, quá 10 tiếng theo B.1; "Influencer" chưa giải nghĩa lần đầu, lệch A.1) → "Chiến dịch nào của Tira Beauty kết thúc ngày 14/2/2025?"
- `yeucau`: "Ngày cuối của chiến dịch là ngày bắt đầu cộng thời lượng trừ 1 ngày; chiến dịch dài 1 ngày bắt đầu và kết thúc cùng ngày." (mục không mở bằng động từ; dữ liệu không có chiến dịch dài 1 ngày vì thời lượng 5–30) → "Tính ngày cuối của chiến dịch bằng ngày bắt đầu cộng thời lượng trừ 1 ngày."
- `\goiy` 1: "Với giá trị mẫu trong ERD, cộng thẳng 14 ngày vào ngày 1/2/2025 ra ngày nào?" (mở bằng "Với…", "cộng thẳng" là khẩu ngữ) → "Chiến dịch mẫu trong ERD bắt đầu ngày 1/2/2025 và dài 14 ngày. Cộng 14 ngày vào ngày bắt đầu thì được ngày nào, đó có phải ngày chạy cuối cùng không?"
- `nghiepvu`: "Chọn đúng các chiến dịch Valentine cần tổng kết ngay sau khi kết thúc." (dữ liệu không ghi chiến dịch nào là "chiến dịch Valentine") → "Chọn các chiến dịch cần tổng kết ngay sau ngày 14/2."

### S4 · `mkt-s4-ba-kenh-youtube-dau` (Viết · Dễ)
- `\tieude`: "Chiến dịch nào chạy đúng ba kênh, ghi YouTube đầu tiên?" (hai vế; hỏi "nào" nhưng kết quả là số đếm theo thương hiệu) → "Bao nhiêu chiến dịch ba kênh ghi YouTube đầu tiên?"
- `\boicanh`: "Đại lý YouTube đề nghị đối soát các chiến dịch ba kênh mà file gốc ghi YouTube đầu tiên, vì phần mềm của họ chỉ đọc kênh ghi đầu." (câu dài, nối bằng "mà… vì…", kiểu dịch máy) → "Đại lý quảng cáo YouTube đề nghị đối soát các chiến dịch chạy ba kênh có YouTube ghi đầu tiên trong file gốc. Phần mềm bên đại lý chỉ đọc kênh ghi đầu." (Lý do "phần mềm chỉ đọc kênh ghi đầu" hơi gượng. Nên để người nắm domain xem có tình huống thật hơn không.)
- `yeucau`: "Đếm cho từng thương hiệu số chiến dịch; mỗi \code{campaign_id} chỉ đếm một lần, vì bản thô có dòng trùng." (trật tự kiểu dịch; giải thích lý do trong yêu cầu và lộ bẫy `dong-trung`, B.3) → "Đếm số chiến dịch của từng thương hiệu, mỗi \code{campaign_id} tính một lần."
- `\goiy` 2: đưa đủ điều kiện `LIKE`, biểu thức `LENGTH - LENGTH(REPLACE…) = 2` và `COUNT(DISTINCT campaign_id)`, gần như cả lời giải (STYLE-scm G.5) → "Dùng \code{LIKE} để lấy chuỗi bắt đầu bằng \code{'YouTube,'}; số dấu phẩy bằng độ dài chuỗi trừ độ dài sau khi bỏ dấu phẩy (\code{LENGTH}, \code{REPLACE})."
- `\luuy`: "Số kênh của một chuỗi bằng số dấu phẩy cộng 1." là mẹo kỹ thuật, nên chuyển sang gợi ý.

### S6 · `mkt-s6-so-duoi-ma-lon-nhat` (Viết · Dễ)
- **Gần hằng số:** kết quả public là ba dòng giống hệt nhau (55555, 1000, 56554). Dải mã 1000–56554 do bộ sinh dữ liệu cố định, nên câu "mã có liền mạch không" luôn ra "có" với cả ba thương hiệu. Đề xuất: (a) chuyển sang `campaigns_raw`, đếm số dòng và số mã khác nhau để lộ 150 dòng trùng; hoặc (b) tính dải mã theo thương hiệu và tháng bắt đầu, để kết quả thay đổi theo nhóm. Nếu giữ nguyên, ghi rõ trong `\ghichuthietke` rằng public ra hằng số theo thương hiệu.
- `\boicanh`: "Anh cần biết phần số cuối của mã chiến dịch mỗi thương hiệu đang chạy từ bao nhiêu tới bao nhiêu, và có liền mạch với số chiến dịch không." ("đang chạy" trùng thuật ngữ "chiến dịch đang chạy"; "của… mỗi…" chồng giới từ; "liền mạch với số chiến dịch" lủng củng) → "Em xem giúp anh phần số cuối trong mã chiến dịch của từng thương hiệu đang nằm trong khoảng nào, và số mã có khớp với số chiến dịch không."
- `\luuy`: "Mã chiến dịch là chuỗi nên được so theo từng ký tự từ trái sang phải: chuỗi có chữ số 9 ở một vị trí đứng sau chuỗi có chữ số 1 ở cùng vị trí, dù số đầy đủ nhỏ hơn. Muốn so theo giá trị thì phải tách phần số và đổi kiểu." (bị động "được so"; khuôn "mệnh đề: kết luận"; câu dạy đời K6 "Muốn… thì phải…"; ba câu) → "Mã chiến dịch là chuỗi nên máy so từng ký tự từ trái sang phải, vì vậy \code{'NY-CMP-9999'} đứng sau \code{'NY-CMP-10000'}. Dải mã liền mạch khi số lớn nhất trừ số nhỏ nhất cộng 1 bằng số chiến dịch."
- `yeucau`: "Cho từng thương hiệu, trả về…" (khuôn lặp) → "Trả về cho từng thương hiệu \code{brand_id}, …".
- `\tieude`: "…là số mấy?" là khẩu ngữ → "Số lớn nhất trong mã chiến dịch của mỗi thương hiệu là bao nhiêu?"

### S8 · `mkt-s8-thang-sap-sai-thu-tu` (Sửa lỗi · Dễ)
- `\boicanh`: "…để tháng 1/2025 lên đầu, còn tháng 7/2024 lại nằm gần cuối." (**sai với kết quả starter**: 07/2024 ở dòng 7 trên 12, ngay sau 06/2025) → "Bảng doanh thu theo tháng em gửi để tháng 1/2025 lên đầu, tháng 7/2024 lại nằm giữa bảng."
- `\boicanh`: "Chị cần bảng chạy đúng từ tháng 7/2024 tới tháng 6/2025 để đưa vào báo cáo năm." ("bảng chạy đúng" là khẩu ngữ; kỳ 7/2024–6/2025 không phải năm dương lịch) → "Chị cần bảng xếp đúng thứ tự từ tháng 7/2024 tới tháng 6/2025 để đưa vào báo cáo 12 tháng."
- `\luuy`: "Chuỗi được sắp theo từng ký tự từ trái sang phải. Nhãn đặt năm trước, tháng sau và tháng luôn có hai chữ số thì sắp theo chữ cũng đúng trình tự thời gian." (bị động; câu 2 cho sẵn cách sửa ở tab miễn phí, trùng gợi ý 2) → "Nhãn tháng là chuỗi, máy sắp từng ký tự từ trái sang phải chứ không theo thời gian."

### A1 · `mkt-a1-roi-tong-theo-thuong-hieu` (Viết · Dễ)
- `\luuy`: "Chiến dịch chi ít mà ROI cao kéo bình quân giản đơn lên dù đóng góp rất ít tiền." (ẩn dụ "kéo", K4; "đóng góp rất ít tiền" mơ hồ) → "Chiến dịch chi ít mà ROI cao làm bình quân giản đơn tăng lên, dù doanh thu và chi phí của chiến dịch đó rất nhỏ."
- `yeucau`: "Cho từng thương hiệu, tính số chiến dịch, tổng doanh thu, tổng chi phí chiến dịch và ROI…" → "Tính số chiến dịch, tổng doanh thu, tổng chi phí chiến dịch và ROI (lợi tức đầu tư) của từng thương hiệu, theo tỷ lệ của tổng."
- Ghi chú: `roi` làm tròn 4 chữ số nhưng sai số chấm là 0,01. Không gây chấm oan, chỉ cần biết rằng chữ số thứ 3–4 không được chấm.

### A3 · `mkt-a3-doi-tuong-quy-1` (Viết · Dễ)
- `\luuy`: "Đối tượng mục tiêu là nhóm chiến dịch nhắm tới, khác với phân khúc khách hàng được ghi nhận." (đọc được thành "nhóm chiến dịch"; định nghĩa lại khái niệm trong luuy, B.4) → "Đối tượng mục tiêu là nhóm người mà chiến dịch nhắm tới, còn phân khúc khách hàng là nhóm khách được ghi nhận cho chiến dịch."
- `\tieude`: "Quý 1/2025 nhóm đối tượng nào mang về nhiều doanh thu nhất?" (12 tiếng) → "Nhóm đối tượng nào dẫn đầu doanh thu quý 1/2025?"
- `yeucau`: "Cho từng nhóm đối tượng mục tiêu, tính số chiến dịch và tổng doanh thu." → "Tính số chiến dịch và tổng doanh thu của từng nhóm đối tượng mục tiêu."

### A5 · `mkt-a5-ngay-tren-500-chien-dich` (Viết · Trung bình)
- `\tieude`: "Ngày nào tháng 3/2025 có trên 350 chiến dịch có lãi khởi chạy?" (13 tiếng; động từ dồn cuối câu theo trật tự tiếng Anh; lặp "có") → "Ngày nào tháng 3/2025 khởi chạy hơn 350 chiến dịch có lãi?"
- `\boicanh`: "Em lấy giúp anh các ngày có trên 350 chiến dịch có lãi bắt đầu." (cùng lỗi trật tự từ) → "Em lọc giúp anh những ngày khởi chạy hơn 350 chiến dịch có lãi."
- `yeucau`: "Cho từng ngày bắt đầu, đếm tổng số chiến dịch (gồm cả hoà vốn và lỗ) và số chiến dịch có lãi." → "Đếm tổng số chiến dịch (gồm cả hoà vốn và lỗ) và số chiến dịch có lãi của từng ngày bắt đầu."
- `\luuy`: "Điều kiện trên từng chiến dịch lọc dòng trước khi đếm; điều kiện trên số đếm của cả ngày chỉ xét được sau khi đã đếm. Bỏ chiến dịch lỗ ngay từ đầu thì cột tổng số chiến dịch cũng mất các chiến dịch đó." (giảng WHERE/HAVING trong tab Nghiệp vụ; "chiến dịch lỗ" chưa gồm hoà vốn, trong khi yêu cầu loại cả hai) → chuyển ý kỹ thuật sang `\goiy`. luuy nghiệp vụ: "Chiến dịch hoà vốn (ROI bằng 0) không tính là có lãi nhưng vẫn tính vào tổng số chiến dịch của ngày."
- **CẦN NGƯỜI NẮM DOMAIN:** số chiến dịch có lãi mỗi ngày tăng giảm gần như theo số chiến dịch mở trong ngày. Muốn "tìm điểm chung về lịch khởi chạy" thì tỷ lệ có lãi hợp lý hơn số đếm. Đề nghị cân nhắc giữ ngưỡng trên số đếm (để dạy HAVING) nhưng thêm cột tỷ lệ, hoặc đổi lời bối cảnh thành nhu cầu chỉ cần số lượng.
- Mã `ngay-tren-500-chien-dich` không còn khớp đề (350 chiến dịch có lãi). Nếu mã chưa công bố thì nên đổi, ví dụ `mkt-a5-ngay-tren-350-chien-dich-lai`.
- Cấp: chỉ dùng 1 bảng, `SUM(CASE)` + `HAVING`, sát mức Dễ. Cấp Trung bình chỉ dựa vào ERD 3 bảng.

### A7 · `mkt-a7-roi-thuong-hieu-cao-bat-thuong` (Sửa lỗi · Dễ)
- SQL: nên thay `avg_roi_tinh_lai` (ra trùng starter ở cả hai biến thể) bằng một lỗi khác. Ví dụ: tính chi phí bằng `SUM(acquisition_cost)` không nhân `conversions`, hoặc bỏ cận dưới. Đáp số (55555; 1,9371) trùng dòng Purplle của A1. Trong gói, ba câu A1, A7, C4 cùng dạy lỗi `AVG(roi)`.
- `\luuy`: "Bình quân cột \code{roi} cho mỗi chiến dịch một phiếu bằng nhau, dù chiến dịch chi rất ít hay rất nhiều. ROI của cả thương hiệu phải để chiến dịch chi nhiều có trọng số lớn hơn." (ẩn dụ "một phiếu"; "phải để" lủng củng) → "Bình quân cột \code{roi} coi mọi chiến dịch nặng như nhau, dù chi phí của chiến dịch rất nhỏ hay rất lớn. ROI của cả thương hiệu tính từ tổng doanh thu và tổng chi phí, nên chiến dịch chi nhiều có trọng số lớn hơn."

### A9 · `mkt-a9-doanh-thu-theo-quy-gop-sai` (Sửa lỗi · Trung bình)
- `\tieude`: "Doanh thu quý 3 cộng lẫn hai năm" (trên public, quý 3 chỉ có 2024 nên học viên không thấy triệu chứng này) → "Doanh thu theo quý không ghi năm"
- `\boicanh`: "Báo cáo doanh thu theo quý em làm không ghi năm, quý 1 lại đứng trên quý 3 năm ngoái. Đầu tháng 7 có chiến dịch mới về thì quý 3 sẽ cộng lẫn hai năm. Em sửa giúp anh để báo cáo chỉ gồm 12 tháng từ tháng 7/2024." (3 câu, khoảng 55 tiếng, quá B.2; "chiến dịch mới về" lệch nghĩa) → "Báo cáo doanh thu theo quý em làm không ghi năm, quý 1 lại đứng trên quý 3 năm ngoái. Em sửa giúp anh để báo cáo chỉ gồm 12 tháng từ tháng 7/2024, kể cả khi dữ liệu tháng 7/2025 đã về."
- `\luuy`: "Báo cáo theo kỳ phải có cả cận dưới và cận trên." (từ kỹ thuật lọc trong tab Nghiệp vụ; câu dạy đời; luuy 3 câu) → "Báo cáo theo kỳ chỉ gồm chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025."

### C4 · `mkt-c4-loai-roi-duoi-muc-chung` (Case · Dễ)
- **Lộ đáp án bước kết luận (K32):** phương án đúng dài 36 tiếng, hai phương án sai 25 và 23 tiếng. Chỉ phương án đúng có từ rào ("chỉ lệch", "chưa tới", "khác biệt nhỏ", "chưa đủ"); hai phương án sai đều khẳng định mạnh ("Cả năm loại", "chuyển toàn bộ"). Đề xuất ba phương án dài gần bằng nhau và cho từ rào vào một phương án sai:
  - `\phuongan*`: "Influencer và SEO có ROI thấp hơn mức chung, nhưng chỉ thấp hơn chưa tới 0,03 nên chưa đủ căn cứ để cắt ngân sách hai loại này."
  - `\phuongan`: "Cả năm loại đều có ROI thấp hơn mức chung khoảng 2,69, nên cần xem lại ngân sách của mọi loại chiến dịch."
  - `\phuongan`: "Influencer có ROI thấp nhất; chưa có số liệu về nguyên nhân, nhưng nên chuyển dần ngân sách Influencer sang Paid Ads có ROI cao nhất."
- Phương án đúng: "…mọi loại chỉ lệch mức chung chưa tới hai phần trăm…" (ROI là hệ số theo B.0; "hai phần trăm" dễ đọc thành 0,02 điểm ROI. Số thật: lệch tương đối lớn nhất 1,33%, lệch tuyệt đối 0,026) → "chưa tới 0,03" hoặc "chưa tới 2% so với mức chung".
- `\luuy`: "Dữ liệu là dữ liệu tổng hợp nên các nhóm thường rất gần nhau; chênh lệch nhỏ không đủ để kết luận về nguyên nhân." (tab Nghiệp vụ nói trước kết luận đúng; lặp "dữ liệu là dữ liệu"; phá khung nghiệp vụ) → bỏ câu này, giữ "Mức chung là ROI của mọi chiến dịch gộp lại, tính từ tổng doanh thu và tổng chi phí."
- Phương án 3: "Influencer kéo ROI chung xuống…" (ẩn dụ "kéo") → "Influencer làm ROI chung giảm…" (nếu giữ phương án này).
- `yeucau` b1: "Cho từng loại chiến dịch (\code{type_id}), tính…" → "Tính số chiến dịch và ROI theo tỷ lệ của tổng của từng loại chiến dịch (\code{type_id})…".
- SQL: đổi tên wrong b2 thành `avg_roi` cho đúng code. Ghi vào `\ghichuthietke` rằng bình quân năm ROI loại trùng ROI chung ở 4 chữ số, vì năm loại có quy mô gần bằng nhau, nên không bắt được lỗi này.

---

## Giọng văn

Đếm trên 10 câu của C (mỗi chỗ trích ở trên tính một lần):
- **Giọng AI: 8 chỗ.** Ẩn dụ "kéo" (a1 luuy, c4 phương án 3), "một phiếu" (a7); câu dạy đời "Muốn… thì phải…" (s6), "phải có cả cận dưới và cận trên" (a9); khuôn "mệnh đề: kết luận" (s6 luuy); câu kết luận chung ở luuy "chênh lệch nhỏ không đủ để kết luận về nguyên nhân" (c4); phương án đúng lộ bằng độ dài và từ rào (c4, K32).
- **Dịch máy: 8 chỗ.** Câu dài "mà… vì…" (s4 bối cảnh); trật tự "Đếm cho từng thương hiệu số chiến dịch" (s4); "phần số cuối của mã chiến dịch mỗi thương hiệu… liền mạch với số chiến dịch" (s6); bị động "được so" (s6), "Chuỗi được sắp" (s8); động từ dồn cuối "có trên 350 chiến dịch có lãi khởi chạy / bắt đầu" (a5 tiêu đề, bối cảnh); "nhóm chiến dịch nhắm tới" (a3).
- **Lệch thuật ngữ, quy tắc: 6 chỗ.** "Influencer" để trần trong tiêu đề (s2); "đang chạy" cho dải mã (s6, trùng khái niệm `chien-dich-dang-chay`); "báo cáo năm" cho kỳ 7/2024–6/2025 (s8); "chiến dịch lỗ" khi ý là "không có lãi" (a5); "cận dưới, cận trên" trong tab Nghiệp vụ (a9); "hai phần trăm" cho ROI là hệ số (c4).
- **Sai sự thật trong lời văn: 1 chỗ.** s8 "tháng 7/2024 lại nằm gần cuối".

Khuôn lặp trên nhiều câu của gói:
1. Yêu cầu mở bằng **"Cho từng X, tính/đếm/trả về…"** (tương đương khuôn K1 "Với mỗi…"): s6, a1, a3, a5, c4.b1; s4 có biến thể "Đếm cho từng…". Nên mở bằng động từ: "Tính … của từng X".
2. **Tiêu đề quá 10 tiếng:** s2 (13), a3 (12), a5 (13).
3. **luuy ở tab Nghiệp vụ giảng kỹ thuật SQL** thay cho hiểu lầm nghiệp vụ: s4 (đếm dấu phẩy), s6 (so chuỗi), s8 (sắp chuỗi), a5 (WHERE/HAVING), a9 (cận dưới, cận trên). Nhiều luuy dài 3 câu (s6, a9), quá mức 1–2 câu.
4. **Gợi ý 2 viết gần đủ biểu thức lời giải:** s2, s4, a1, a9. Với s4 thì gần như cả truy vấn.
5. Cùng một bài học `AVG(roi)` so với tỷ lệ của tổng lặp ở ba câu a1, a7, c4 (a7 còn trùng đáp số với a1).
