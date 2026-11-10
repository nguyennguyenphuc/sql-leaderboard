# REVIEW-C · gói 4 Marketing (`mkt`) · người kiểm C

Ngày 10/11/2026. C nhận các câu thứ 2, 4, …, 20 theo thứ tự trong `cau-hoi.tex`: t2, t4, t6, t8, f1, f3, f5, f7, f9, c8 (10 câu).

Cách kiểm:
- Bước 1: tự viết SQL từ đề (chưa mở `solution.sql`), chạy trên `mkt` và `mkt_hidden_1` (user `sql_runner`). Bài tự giải ở `cong-cu\ket-qua\review\mkt-goi-4-C\c_*.sql`.
- Bước 2–3: tách `solution.sql` thành từng khối (`blk\`), chạy solution, starter, mọi wrong trên hai biến thể (`out\*.tsv`) rồi so theo vị trí cột với sai số 0,01 (`cmp.sh`).
- Chỉ chạy SQL từng câu, không chạy bộ kiểm cả gói.
- Kiểm thêm theo yêu cầu: hai biến thể có ra kết quả khác nhau không, làm tròn trung gian có gây chấm oan không, kết quả wrong có trùng starter không, phương án case có khớp số thật không.

Kết quả chung: solution của cả 10 câu ra kết quả khác nhau giữa public và hidden-1, nên chép kết quả Chạy thử không qua được. Bài tự giải của tôi khớp solution ở cả 10 câu, trên cả hai biến thể. Riêng t6, solution và cách viết đầu tiên của tôi cùng dính lỗi làm tròn của MySQL (xem t6).

## Bảng kiểm

| Mã | Phiên bản | Kiểm SQL | Kiểm nội dung | Đề xuất sửa cụ thể |
|---|---|---|---|---|
| mkt-t2-pheu-dang-dai | v1 | **Đạt**. Tự giải khớp 12/12 dòng ở cả hai biến thể. Hai wrong rớt ở public và hidden-1. Làm tròn: `nhap*100/hien_thi` có 4 chữ số thập phân rồi mới làm tròn 2, lệch tối đa 0,01, vẫn trong sai số. | **Đạt** (góp ý nhỏ, không chặn) | Xem mục t2. |
| mkt-t4-luat-phat-hien-so-nhat-ky | v1 | **Đạt**. Tự giải khớp ở cả hai biến thể (public: FUNNEL_ERROR 375/300/300, năm loại kia khớp đủ; hidden-1: INVALID_DATE 78/77/77). Wrong ngày rớt (72 so với 90), wrong thiếu `brand_id` rớt (NULL khớp 606 so với 600). | **Cần sửa** | "nhật ký lỗi bên dữ liệu gửi kèm" (lệch thuật ngữ, tối nghĩa); câu luật DUPLICATE theo trật tự tiếng Anh. Xem mục t4. |
| mkt-t6-phan-nhom-roi-ctr | v1 | **Cần sửa: CHẤM OAN**. Phép chia của MySQL chỉ giữ 4 chữ số thập phân, nên ngưỡng CTR bị cắt thành 0,0850 (thật ra 0,085036) và có 15 chiến dịch bị gắn nhãn sai. Học viên so chính xác (truy vấn con vô hướng, nhân chéo, `CAST AS DOUBLE`) ra 15600/6544/12090/21321, không khớp solution 15608/6536/12097/21314, nên rớt dù làm đúng. Các wrong rớt ở public. | **Cần sửa** | Sửa SQL và đề như mục t6. Bối cảnh sai nghiệp vụ: "nhiều lượt nhấp mà lỗ". Xem thêm "theo nó", "với Purplle" và mảng `customer`. |
| mkt-t8-ty-le-roi-pheu-sai-mau | v1 | **Đạt**. Tự giải khớp ở cả hai biến thể. Ba cách viết (`(1-a/b)*100`, `100-100*a/b`, `DOUBLE`) cùng ra một kết quả. Starter khác solution, hai wrong rớt ở public và không trùng starter. | **Cần sửa** | "so với tầng ngay trước nó" (đại từ "nó" chỉ vật); vai người hỏi lệch với các câu khác trong gói. Xem mục t8. |
| mkt-f1-top-3-doanh-thu-moi-thuong-hieu | v1 | **Đạt**. Tự giải khớp ở cả hai biến thể. `rank_ra_bon_dong` và `hoa_lay_ma_lon_hon` qua public, rớt ở hidden-1, đúng như thiết kế. `thieu_partition` rớt ở public. | **Cần sửa** | Chị Ngân ở f1 là "Trưởng phòng marketing số", nhưng ở t6 và f2 là "Quản lý thương hiệu Purplle". Xem mục f1. |
| mkt-f3-truot-7-ngay-tira | v1 | **Đạt**. Tự giải khớp 31/31 dòng ở cả hai biến thể. Hai wrong rớt ở public. | **Cần sửa** | "không bị nhiễu bởi ngày cao ngày thấp" (bị động "bởi", lại trùng chữ "nhiễu" của dữ liệu thô); "tuần trượt". Xem mục f3. |
| mkt-f5-chuoi-ngay-lien-tiep | v1 | **Đạt**. Tự giải khớp: public 7/12 tới 21/12/2024 (15 ngày); hidden-1 2/1 tới 11/1/2025 (10 ngày, hoà với 20/5 tới 29/5). `danh_so_ca_ngay_trung` rớt ở cả hai biến thể; `hoa_lay_chuoi_muon_hon` rớt ở hidden-1. | **Cần sửa** | Câu bối cảnh sai ngữ pháp; "đội người ảnh hưởng". Xem mục f5. |
| mkt-f7-chi-phi-luy-ke-nhay-bac | v1 | **Cần sửa: WRONG TRÙNG STARTER**. `them_distinct` ra đúng kết quả của starter ở cả hai biến thể (đã `diff`), nên Chạy thử của học viên sẽ lặp lại kết quả starter. Solution và tự giải khớp 85/85 dòng. `chia_cua_so_theo_ngay` rớt ở public; `thieu_can_tren` rớt ở hidden-1 (thừa dòng 1/7/2025). | **Cần sửa** | "mỗi ngày bắt đầu có chiến dịch của Nykaa một dòng" (trật tự từ); "mỗi ngày lặp lại hơn trăm dòng" sai với 16/85 ngày; "giải ngân". Xem mục f7. |
| mkt-f9-tuong-tac-cao-nhat-moi-loai | v1 | **Cần sửa: WRONG TRÙNG STARTER**. `chia_theo_thuong_hieu` ra đúng kết quả của starter ở cả hai biến thể, vì đề chỉ có một thương hiệu nên `PARTITION BY brand_id` không tạo khác biệt. Solution khớp; `gom_max_lay_ma_nho_nhat` rớt ở public. | **Cần sửa** | Tiêu đề viết "tương tác cao nhất", thiếu chữ "điểm". Xem mục f9. |
| mkt-c8-doi-tuong-dang-tang-ngan-sach | v1 | **Đạt**. Tự giải khớp b1–b4 ở cả hai biến thể. Mọi wrong rớt ở public. Số trong ba phương án khớp số thật (bước 3 hidden-1 ghi sai thứ tự, xem mục c8). | **Cần sửa** | Phương án đúng dài gần gấp đôi hai phương án sai và là phương án duy nhất có chữ rào ("chưa đủ căn cứ"), nên lộ đáp án; một số câu chữ cần sửa. Xem mục c8. |

**Tổng: kiểm SQL 7 Đạt / 3 Cần sửa (t6, f7, f9); kiểm nội dung 1 Đạt / 9 Cần sửa; tính cả hai mặt: 1 câu Đạt (t2), 9 câu Cần sửa.**

---

## Chi tiết từng câu

### t2 · mkt-t2-pheu-dang-dai
- SQL: đạt. Kết quả ở hai biến thể khác nhau, ví dụ Nykaa tầng nhận biết 788.815.211 ở public và 706.959.631 ở hidden-1.
- Nghiệp vụ: đúng công thức. Tab Nghiệp vụ không lộ số. Mảng `marketing` hợp lý, cấp Trung bình hợp lý.
- Góp ý nhỏ, không chặn:
  - Đề hỏi "tỷ lệ đi tiếp", nhưng chỉ khai báo khái niệm `ty-le-roi-pheu`, và cụm "tỷ lệ đi tiếp" không có trong STYLE-mkt mục A. Nên thêm vào `\luuy`: "Tỷ lệ đi tiếp bằng 1 trừ tỷ lệ rơi."
  - `\ghichuthietke` viết "\code{calendar} không cần (có thể lọc quý qua lịch)", hai vế tự mâu thuẫn. Sửa thành "\code{calendar} là bảng không cần; lọc quý trực tiếp trên \code{start_date}."

### t4 · mkt-t4-luat-phat-hien-so-nhat-ky
- SQL: đạt. Hidden-1 có thêm dòng 1/7/2025 nằm ngoài kỳ, nên luật ngày bắt 78 dòng còn nhật ký ghi 77, đúng như `\ghichuthietke`. `so_dong_nhat_ky` tính bằng `DISTINCT` hay không đều ra cùng số.
- Giọng văn:
  - "Em đối chiếu giúp anh mỗi luật bắt được bao nhiêu dòng và có khớp với nhật ký lỗi bên dữ liệu gửi kèm không." → "Em đếm giúp anh mỗi luật bắt được bao nhiêu dòng, rồi đối chiếu với nhật ký nhiễu gửi kèm file xem có khớp không." Lý do: STYLE A.5 không dùng "lỗi" để gọi nhiễu, và "bên dữ liệu" tối nghĩa.
  - "\code{'DUPLICATE'} (dòng có một dòng khác cùng thương hiệu, cùng mã chiến dịch nằm ở vị trí sau trong file)" → "\code{'DUPLICATE'} (phía sau dòng đó trong cùng file còn một dòng khác cùng thương hiệu, cùng mã chiến dịch)". Lý do: mệnh đề "nằm ở vị trí sau" đặt theo trật tự tiếng Anh, đọc không rõ nó bổ nghĩa cho dòng nào.

### t6 · mkt-t6-phan-nhom-roi-ctr
- **Lỗi SQL nặng.** Solution viết `SUM(clicks) / SUM(impressions) AS ctr_chung` trong CTE. MySQL lưu giá trị này dạng DECIMAL 4 chữ số, tức 0,0850, trong khi giá trị đúng là 0,0850356. Vế so `c.clicks / c.impressions` cũng chỉ có 4 chữ số. Kết quả là 15 chiến dịch Purplle ở public (16 ở hidden-1) bị gắn nhãn CTR sai.
  - Số đo ở public. Solution ra cao/cao 15608, cao/thap 6536, thap/cao 12097, thap/thap 21314. So chính xác ra 15600, 6544, 12090, 21321.
  - Cách so chính xác gồm: `CAST(... AS DOUBLE)`, ngưỡng viết bằng truy vấn con vô hướng `(SELECT SUM(clicks)/SUM(impressions) …)`, hoặc nhân chéo `clicks*tong_hien_thi > tong_nhap*impressions`.
  - Viết theo phần trăm (`clicks*100/impressions`) lại ra số khác nữa: 15599 / 6545 / 12090 / 21321.
  - Đếm không có sai số nên học viên làm đúng vẫn rớt.
- **Sửa (đã thử):** ghi vào yêu cầu "CTR của chiến dịch và CTR chung tính theo phần trăm, làm tròn 2 chữ số rồi mới so". Solution dùng `ROUND(c.clicks*100/c.impressions, 2) > ROUND(SUM(clicks)*100/SUM(impressions), 2)`. Ba cách viết (DECIMAL, DOUBLE, `/…*100`) đều ra cùng một số: 27.681 chiến dịch CTR cao ở public, 24.860 ở hidden-1. Sau khi sửa phải chạy lại ba bảng số và cập nhật `\ghichuthietke`. Nhãn ROI so cột `roi` (2 chữ số) với ngưỡng DECIMAL 6 chữ số, không lệch.
- Nghiệp vụ:
  - "Chị muốn chia chiến dịch Purplle thành bốn nhóm như nhiều lượt nhấp mà lỗ, ít lượt nhấp mà lãi" → "Chị muốn chia chiến dịch Purplle thành bốn nhóm, kiểu CTR cao mà ROI thấp, CTR thấp mà ROI cao". Lý do: ngưỡng là ROI chung 1,94, nên nhóm "thap" phần lớn vẫn có lãi, trong khi STYLE A.3 định nghĩa "lỗ" là ROI âm. CTR là tỷ lệ, không phải "nhiều lượt nhấp".
  - `domain=customer` không hợp: câu không dùng đối tượng hay phân khúc. Đề xuất `finance`, vì câu phân nhóm theo ROI (STYLE G).
- Giọng văn:
  - `\luuy`: "…cao hơn hẳn ROI chung nên chia nhóm theo nó sẽ lệch." → "…cao hơn hẳn ROI chung, lấy bình quân này làm ngưỡng thì các nhóm bị lệch." Lý do: "nó" chỉ vật.
  - `\goiy`: "Hai số đó khác nhau bao nhiêu với Purplle?" → "Ở Purplle, hai số đó chênh nhau bao nhiêu?" Lý do: giới từ "với" dịch máy.

### t8 · mkt-t8-ty-le-roi-pheu-sai-mau
- SQL: đạt. Kết quả ở hai biến thể khác nhau, ví dụ loại 1 tầng 3 là 60,12 ở public và 59,97 ở hidden-1.
- Giọng văn:
  - `\luuy`: "Tỷ lệ rơi vào một tầng so với tầng ngay trước nó, không so với tầng đầu." → "Tỷ lệ rơi của một tầng tính so với tầng liền trước, không so với tầng đầu." Lý do: "nó" chỉ vật, và "rơi vào một tầng" sai nghĩa.
  - Vai người hỏi: "Anh Duy · Trưởng phòng marketing số" trùng chức vụ với Chị Hạnh (t2, t5) và Chị Ngân (f1). Một phòng chỉ có một trưởng phòng, nên thống nhất một người cho cả gói, ví dụ đổi t8 thành "Chị Hạnh · Trưởng phòng marketing số" và đổi xưng hô thành "chị".

### f1 · mkt-f1-top-3-doanh-thu-moi-thuong-hieu
- SQL: đạt. Bẫy hoà chỉ có ở hidden-1, đúng thiết kế (README-mkt biến thể c).
- Vai người hỏi: `\boicanh[Chị Ngân · Trưởng phòng marketing số]` → `\boicanh[Chị Hạnh · Trưởng phòng marketing số]`. Chị Ngân là Quản lý thương hiệu Purplle ở t6, f2 và trong ví dụ của STYLE-mkt B.2.
- Còn lại đạt. `\goiy` nấc 2 là khung cú pháp một dòng, đúng STYLE-scm G.5.

### f3 · mkt-f3-truot-7-ngay-tira
- SQL: đạt.
- Giọng văn:
  - "Anh muốn theo dõi nhịp mở chiến dịch tháng 3 của Tira Beauty mà không bị nhiễu bởi ngày cao ngày thấp." → "Anh muốn xem nhịp mở chiến dịch tháng 3 của Tira Beauty cho đều, đỡ rối vì ngày cao ngày thấp." Lý do: bị động "bị … bởi"; "nhiễu" là thuật ngữ của dữ liệu thô (STYLE A.5).
  - `nghiepvu`: "Theo dõi nhịp mở chiến dịch theo tuần trượt…" → "Theo dõi nhịp mở chiến dịch trượt 7 ngày…" (STYLE A.4 gọi là "trượt 7 ngày").
  - Vai người hỏi: Anh Quân ở f3 là "Quản lý thương hiệu Tira Beauty", ở c7 là "Giám đốc marketing". Đổi tên ở một trong hai câu.

### f5 · mkt-f5-chuoi-ngay-lien-tiep
- SQL: đạt.
- Giọng văn và thuật ngữ:
  - "Đội người ảnh hưởng của Nykaa nói từng mở chiến dịch tiếng Bengali cho giới trẻ ngày nào cũng có, suốt nhiều ngày liền." → "Đội phụ trách chiến dịch Influencer của Nykaa báo từng có đợt ngày nào cũng mở chiến dịch tiếng Bengali cho giới trẻ, kéo dài nhiều ngày liền." Lý do: câu gốc sai ngữ pháp ("mở chiến dịch … ngày nào cũng có", "ngày nào cũng có" và "suốt nhiều ngày liền" lặp ý). "Đội người ảnh hưởng" hiểu thành một nhóm người nổi tiếng; STYLE A.1 gọi là "marketing người ảnh hưởng (Influencer)".
  - `nghiepvu`: "Đánh giá đội người ảnh hưởng có giữ được…" → "Đánh giá đội phụ trách chiến dịch Influencer có giữ được…"
  - `\ghichuthietke`: "6 bảng chỉ khoá, 1 bảng nhiễu (\code{calendar})" → "6 bảng chỉ khoá, 5 bảng không cần (bốn danh mục đã có mã ở đầu gói và \code{calendar})". Lý do: `\erdkhoa` đã cho học viên dùng thẳng mã, nên bốn danh mục cũng không cần.

### f7 · mkt-f7-chi-phi-luy-ke-nhay-bac
- **Lỗi SQL:** wrong `them_distinct` ra đúng kết quả của starter ở cả `mkt` và `mkt_hidden_1`, vì mỗi dòng của starter đã khác nhau. Bài sai này không đo được lỗi nào mới. Thay bằng lỗi thật hay gặp, ví dụ "cộng dồn từ đầu kỳ dữ liệu rồi mới lọc quý 2": bỏ cận dưới trong CTE, lọc `start_date >= '2025-04-01'` ở truy vấn ngoài. Cách này rớt ở public vì dòng 1/4 mang theo chi phí từ tháng 7/2024. Nếu muốn giữ ý DISTINCT thì ghi rõ trong `\ghichuthietke` là trùng starter, nhưng không nên giữ.
- Giọng văn và số liệu:
  - `yeucau`: "mỗi ngày bắt đầu có chiến dịch của Nykaa một dòng" → "mỗi ngày có chiến dịch Nykaa bắt đầu là một dòng". Lý do: trật tự từ theo tiếng Anh.
  - `\boicanh`: "Bảng em gửi có mỗi ngày lặp lại hơn trăm dòng" → "Bảng em gửi có ngày lặp lại tới hơn trăm dòng". Số thật: 69/85 ngày có ít nhất 100 dòng, các ngày 21–24/6 chỉ 4–14 dòng.
  - `nghiepvu`: "Theo dõi tiến độ giải ngân ngân sách marketing quý 2" → "Theo dõi tiến độ chi ngân sách marketing quý 2". Lý do: "giải ngân" là từ của tín dụng và đầu tư công.

### f9 · mkt-f9-tuong-tac-cao-nhat-moi-loai
- **Lỗi SQL:** wrong `chia_theo_thuong_hieu` ra đúng kết quả của starter ở cả hai biến thể, vì đề lọc `brand_id = 3` nên `PARTITION BY brand_id` không chia gì. Thay bằng lỗi thật hay gặp, ví dụ `RANK()` thay `ROW_NUMBER()` không kèm `campaign_id` trong sắp. Public không có hoà nên cách này qua public, cần kiểm hidden-1; nếu hidden-1 cũng không có hoà thì chọn lỗi khác. Một lựa chọn khác là lọc `hang = 1` nhưng sắp `engagement_score` tăng dần, rớt ở public.
- Giọng văn và thuật ngữ:
  - `\tieude{Chiến dịch tương tác cao nhất mỗi loại ra một dòng}` → `\tieude{Chiến dịch điểm tương tác cao nhất mỗi loại chỉ ra một dòng}`. Lý do: STYLE A.2 gọi là "điểm tương tác"; thêm "chỉ" để tiêu đề nêu đúng triệu chứng (cả gói ra một dòng, không phải mỗi loại một dòng).

### c8 · mkt-c8-doi-tuong-dang-tang-ngan-sach
- SQL: đạt. Số thật ở public:
  - b1: Premium Shoppers 1,9557, Youth 1,9411, Working Women 1,9410; mức chung 1,9405.
  - b3: Premium Shoppers hạng 1 ở Nykaa, hạng 5 ở Purplle, hạng 1 ở Tira Beauty.
  - b4: Premium Shoppers vượt mức chung 6/11 tháng.
- Phương án khớp số ở cả hai biến thể.
- **Lộ đáp án:** phương án đúng (`\phuongan*`) dài khoảng 204 ký tự, hai phương án sai khoảng 112 và 145 ký tự. Phương án đúng cũng là phương án duy nhất có chữ rào ("chỉ hơn … rất ít", "chưa đủ căn cứ"). Rút gọn phương án đúng, thêm chi tiết số cho hai phương án sai để ba phương án dài gần bằng nhau. Ví dụ:
  - Đúng: "Premium Shoppers có ROI tổng cao nhất nhưng chỉ hơn nhóm sau khoảng 0,015, đổi hạng theo thương hiệu và chỉ vượt mức chung 6 trên 11 tháng, nên chưa có nhóm nào hiệu quả hơn hẳn."
  - Sai 1: "Premium Shoppers có ROI cao hơn mức chung khoảng 0,8 và cao nhất ở cả bình quân lẫn tổng, nên là nhóm đáng dồn thêm ngân sách cho cả ba thương hiệu."
- Giọng văn:
  - Lời giải thích phương án 1: "chỉ hơn mức chung vài phần trăm của một đơn vị ROI" → "chỉ hơn mức chung khoảng 0,015". Lý do: cụm gốc dài vòng, dịch máy.
  - Phương án đúng: "không đứng đầu ở mọi thương hiệu" → "không đứng đầu ở cả ba thương hiệu". Lý do: câu gốc mơ hồ, đọc được thành "không đứng đầu ở thương hiệu nào".
  - Phương án 3: "nên nhóm này hiệu quả hơn hẳn và nên nhận thêm ngân sách" → "vì vậy nhóm này hiệu quả hơn hẳn và cần được thêm ngân sách" (chữ "nên" lặp hai lần).
  - Vai người hỏi: Giám đốc marketing là Chị Lan ở c8 nhưng là Anh Quân ở c7. Thống nhất một người.
- `\ghichuthietke`: "(hidden-1: hạng 2, 2, 4)" → "(hidden-1: hạng 2, 4, 2)". Theo thứ tự Nykaa, Purplle, Tira Beauty, đã chạy lại.
- Rủi ro nhỏ ở b4: tại hidden-1, Youth có một tháng ROI chỉ hơn mức chung 0,000053. Học viên làm tròn 4 chữ số trước khi so có thể ra hai số bằng nhau và đếm thiếu một tháng. Thêm vào yêu cầu b4: "so trên ROI chưa làm tròn".

---

## Giọng văn (tổng hợp 10 câu của C)

- **Giọng AI: 0 chỗ.** Không có câu khẩu hiệu, ẩn dụ, dấu "—", hay "Hãy…" dồn dập. Riêng ở c8, phương án đúng là phương án duy nhất có chữ rào ("chỉ hơn … rất ít", "chưa đủ căn cứ"), một khuôn hay gặp ở đề do AI soạn.
- **Dịch máy: 8 chỗ.**
  - Trật tự từ theo tiếng Anh: t4 luật DUPLICATE, f7 "mỗi ngày bắt đầu có chiến dịch của Nykaa một dòng".
  - Đại từ "nó" chỉ vật: t6, t8.
  - Giới từ "với": t6 "khác nhau bao nhiêu với Purplle".
  - Bị động "bị … bởi": f3.
  - Câu sai ngữ pháp: f5 bối cảnh.
  - Cụm dài vòng: c8 "vài phần trăm của một đơn vị ROI".
- **Lệch thuật ngữ hoặc nghiệp vụ: 7 chỗ.**
  - Gọi nhiễu là "lỗi": t4 "nhật ký lỗi".
  - Gọi ROI dưới mức chung là "lỗ", gọi CTR là "nhiều lượt nhấp": t6.
  - "Nhiễu" dùng theo nghĩa thường: f3.
  - "Tuần trượt" thay cho "trượt 7 ngày": f3.
  - "Đội người ảnh hưởng": f5, xuất hiện hai lần.
  - "Giải ngân": f7.
  - "Tương tác cao nhất" thiếu chữ "điểm": f9.
- **Khuôn lặp trên nhiều câu của gói:**
  1. Vai người hỏi không nhất quán.
     - Trưởng phòng marketing số có ba người: Chị Hạnh (t2, t5), Anh Duy (t8), Chị Ngân (f1).
     - Chị Ngân giữ hai vai (t6, f2 và f1).
     - Anh Quân giữ hai vai: Quản lý thương hiệu Tira Beauty (f3), Giám đốc marketing (c7).
     - Giám đốc marketing có hai người: Anh Quân (c7), Chị Lan (c8).
     Đề xuất lập một bảng vai cố định cho gói.
  2. Bối cảnh câu Sửa lỗi hay nối hai vế bằng "mà" hoặc "trong khi" (t6, t8, f9). Mỗi câu riêng chấp nhận được, nhưng đọc liền cả gói thì thấy lặp; nên đổi cách nối ở một vài câu.
  3. Hai wrong ra đúng kết quả của starter (f7, f9). Nên thêm vào quy trình tự kiểm của người soạn bước so kết quả từng wrong với starter.
