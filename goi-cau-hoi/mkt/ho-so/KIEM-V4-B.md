# Kiểm độc lập V4 · bộ mkt · người kiểm B

Ngày 11/11/2026. Làm theo `BRIEF-KIEM-V4.md`, danh sách `KIEM-V4-DANH-SACH.md` (B nhận 27 dòng số lẻ). Thứ tự căn cứ: `quy_chuan/` > `QUYET-DINH-CHUNG.md` (QĐC) > `style/STYLE-mkt.md` > brief.

Cách làm với mỗi câu:
1. Chỉ đọc đề trong `cau-hoi.tex` (và khối `starter` của câu Sửa lỗi, Tối ưu), tự viết SQL, chạy bằng `sql_runner` trên `mkt` và `mkt_hidden_1`.
2. Sau đó mới tách các khối `solution`, `wrong`, `starter` trong `solution.sql`, chạy cả hai biến thể, so theo luật chấm (thứ tự khi `thutu=co`, sai số theo `saiso`, NULL bằng NULL).
3. Mọi `wrong`/`starter` phải lệch solution ở ít nhất một biến thể; solution phải khác nhau giữa public và hidden-1; đo thời gian lúc MySQL đang chạy chung với các agent khác.

SQL tự giải, kết quả và bảng so nằm ở thư mục nháp `kiem-mkt-B` (scratchpad), không đưa vào repo.

Kết quả máy: **27/27 câu tự giải khớp solution ở cả hai biến thể**. Mọi solution khác nhau giữa public và hidden-1. Mọi `wrong` rớt ít nhất một biến thể; các bài sai thiếu cận trên chỉ rớt ở hidden-1 đúng như ghi chú (r6, n4, s9, a6, j9, q4 `lam_tron_truoc_khi_so`, t9 `cat_theo_vi_tri_dong`, p3 `rank_…`, p5). Starter của câu Sửa lỗi lệch solution ở cả hai biến thể. Starter của câu Tối ưu cho đúng kết quả. Solution chậm nhất: s9 khoảng 6,5 giây, t5 6–8 giây, t9 khoảng 5,8 giây, đều dưới 10 giây. Bài sai `lech_bien_ngay_cuoi` của t5 mất 9,2 giây, sát ngưỡng.

Không thấy lỗi chấm oan, solution sai hay wrong không rớt.

## Bảng kết quả

Viết tắt: TS = tự giải; pub/h1 = số dòng public/hidden-1. Cột "Cấp đúng?" xét 5 trục (bảng · bước · mơ hồ · bẫy · nghiệp vụ, QĐC 2.2), ERD theo CHOT mục 3 và lộ trình `data.js`.

| # | Mã | Gói | Cấp | Tự giải khớp? | Biến thể khác? | Cấp đúng? | Giọng văn | Kết luận + đề xuất |
|---|---|---|---|---|---|---|---|---|
| 1 | mkt-r2-qua-8-3-tira-ban-tot | 1 | TB | Khớp (19/18) | Có; 3 wrong rớt cả hai | Đạt 3/5 TB: mơ hồ, bẫy, nghiệp vụ. Bảng 1 và bước 1 ở mức Dễ, như bài TB M1 "LIKE, IN, BETWEEN" của lộ trình. Viết lại khác độ khó thật: định nghĩa bằng lời ở tab, 3 bẫy. ERD 3 bảng n-1 | Đạt | **Đạt.** Tuỳ chọn: bối cảnh dòng 137 "đợt quà tặng 8/3 … năm ngoái" coi năm hiện tại là 2026, trong khi r6 (dòng 248 "quý 2 vừa rồi") coi là giữa 2025. Có thể đổi "các chiến dịch quà tặng năm ngoái" → "các chiến dịch quà tặng 8/3/2025". |
| 3 | mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2 | 1 | Khó | Khớp (38/37) | Có; `thieu_can_tren` chỉ rớt h1 | Đạt 3/5 Khó (mơ hồ, bẫy, nghiệp vụ), giống bài Khó một bảng của M1 trong lộ trình. ERD 5 bảng chỉ khoá, không `\erdnoi` | Đạt | **Đạt (ghi chú).** Người soạn đã tự khai điểm yếu và tôi xác nhận: r6 trùng phạm vi Nykaa · Hindi · sinh viên với r9 (cùng M1, cùng Khó); r6, r9, n4, n9 cùng một bẫy ẩn (thiếu cận trên, bắt qua `NY-CMP-56555`). Không vi phạm quy tắc ô. Muốn giảm lặp thì có thể đổi điều kiện ngôn ngữ của r6 từ "tiếng Hindi" sang "không phải tiếng English" (`language_id <> 2`). Bẫy h1 vẫn giữ vì `NY-CMP-56555` là Hindi. Cần nâng ngưỡng điểm tương tác cho số dòng vừa phải. |
| 5 | mkt-n4-nhom-lai-lo-nykaa-quy-2 | 1 | Khó | Khớp (4/4, giá trị khác) | Có; `thieu_can_tren` chỉ rớt h1 | Đạt 3/5 Khó: mơ hồ (quy tắc bằng lời, phải tự suy thứ tự nhánh), bẫy (5, có 1 chỉ lộ ở h1), nghiệp vụ (có ngoại lệ, cộng chi phí). Ngang bài Khó M2 "CASE lồng" | Đạt | **Đạt.** |
| 7 | mkt-n7-gia-tri-don-tho-lech | 1 | TB | Khớp (1 dòng: 498,79 / 498,96) | Có; starter và 3 wrong rớt cả hai | Đạt TB: một lỗi khó thấy (`SUM` bỏ ô trống theo từng cột), đúng HD mục 6 | Đạt | **Đạt.** Tuỳ chọn: gợi ý 2 (`WHERE revenue > 0 AND conversions IS NOT NULL`) chính là bản sửa. QĐC 1.4 cho phép, nhưng các câu Sửa lỗi mẫu d1–d4 không đưa bản sửa. Có thể đổi thành "\code{COUNT(revenue)} và \code{COUNT(conversions)} trên cùng tập dòng có bằng nhau không?" |
| 9 | mkt-c1-ctr-theo-loai-thang-5 | 1 | Case CB | Khớp b1 (5/5) | Có | Đạt (case CB theo QĐC 1.2) | Đạt | **Đạt.** Đã kiểm lời giải thích trên cả hai biến thể: Email cao nhất; chênh 0,29 (pub) và 0,34 (h1) điểm %; Email không đông nhất (Social Media 3.025 > 3.019; h1 2.737 > 2.694). Tuỳ chọn: "Đúng: Bước 1 …" (dòng 623) → "Đúng: bước 1 …" (viết thường sau dấu hai chấm như mẫu c1). |
| 11 | mkt-s1-social-nykaa-chay-sang-thang-sau | 2 | TB | Khớp (11/11) | Có; 3 wrong rớt cả hai | Đạt 3/5 TB: mơ hồ (chỉ số ở tab), bẫy (lệch 1 ngày, so `MONTH()` qua năm), nghiệp vụ (điều kiện theo thời điểm). Bước 2 tầng ở mức Dễ. Ngang bài Khó M3 "Khuyến mãi kéo dài qua năm mới" | Đạt | **Đạt.** Ghi chú: bẫy `giu-thang-chua-du` đã bị đề tháo ("tới hết 31/5/2025 (11 tháng đủ)"), nên bài sai này chỉ bắt người không đọc đề. |
| 13 | mkt-s4-ba-kenh-youtube-dau | 2 | Dễ | Khớp (3/3) | Có | Đạt Dễ (M3: CB + bẫy `COUNT(DISTINCT)`/vị trí) | Đạt | **Đạt.** Bối cảnh viết lại ở v3 nghe hợp lý: lấy số đối chiếu trước khi tách cột kênh. |
| 15 | mkt-s9-dang-chay-dau-thang-lech | 2 | Khó | Khớp (11/11) | Có; starter lệch cả hai; `sua_hai_bien_thieu_can_tren` chỉ rớt h1 | Đạt theo dòng Sửa lỗi Khó của HD mục 6 (3 lỗi chồng nhau). Theo 5 trục chỉ có mơ hồ (một phần) và bẫy ở mức Khó; bảng, bước ở mức Dễ; nghiệp vụ TB. Sát ranh, đúng như người soạn tự khai | Đạt | **Cần sửa (lỗi 3: gợi ý nấc cuối đưa trọn lời giải).** Dòng 359 (gói 2): gợi ý 2 nêu cả điều kiện nối đã sửa hai đầu lẫn `k.cal_date <= '2025-06-01'`, tức đủ cả 3 lỗi. Ngoài ra đây là hai biểu thức, trái QĐC 1.4 (một biểu thức). Đổi thành `\goiy{Ngày cuối của chiến dịch là \code{DATE_ADD(c.start_date, INTERVAL c.duration_days - 1 DAY)}.}`: chỉ sửa 1/3 lỗi; gợi ý 1 đã hỏi về ngày bắt đầu và ngày 1/7/2025. |
| 17 | mkt-a3-doi-tuong-quy-1 | 2 | CB | Khớp (5/5) | Có | Đạt CB 5/5. Hạ cấp có đổi đề thật: bỏ `segment_id` và `audiences` khỏi ERD, ghi thẳng cột gom. Không phải đổi nhãn suông | Đạt | **Cần sửa (nhẹ).** Dòng 445 (gói 2) `\luuy` "Mã nhóm khách xem ở đầu gói.": trên nền tảng, học viên chỉ thấy từng câu, không thấy phần đầu gói của PDF. Thay bằng "Mã nhóm khách: 1 College Students, 2 Premium Shoppers, 3 Tier 2 City Customers, 4 Working Women, 5 Youth." |
| 19 | mkt-a6-doanh-thu-nykaa-theo-thang | 2 | CB | Khớp (12/12) | Có; `thieu_can_tren` chỉ rớt h1 | Đạt CB 5/5 (bỏ cột giá trị đơn và bẫy gom tháng bỏ năm: hạ cấp thật) | Đạt | **Đạt.** |
| 21 | mkt-c3-thang-purplle-mo-nhieu-nhat | 2 | Case CB | Khớp b1 (11/11) | Có | Đạt | Đạt | **Đạt.** Đã kiểm lời giải thích: tháng 9/2024 có bình quân mỗi ngày cao nhất (165,23; h1 148,53), hơn tháng thấp nhất (3/2025) 6,9% (h1 6,2%), tức dưới 10%; tháng 2 thấp nhất về tổng nhưng bình quân đứng thứ 4 từ dưới lên, tức nhóm giữa, ở cả hai biến thể. Tuỳ chọn: "Đúng: Bước 1" (dòng 640) → "bước". |
| 23 | mkt-j3-influencer-nykaa-tren-youtube | 3 | CB | Khớp (8/7) | Có | Đạt CB: nối 2 bảng giống bài CB `j1-don-kem-vung` của lộ trình. ERD 2 bảng có giá trị mẫu là bắt buộc vì câu cần nối | Đạt | **Đạt.** Ô trùng với r1, xem mục cuối. |
| 25 | mkt-j9-lich-paid-ads-tira-chua-dung-duoc | 3 | Khó | Khớp (30/30) | Có; starter 24 dòng; `sua_hai_loi_thieu_can_tren` chỉ rớt h1 | Đạt theo dòng Sửa lỗi Khó (3 lỗi chồng nhau, lỗi sau chỉ lộ khi đã sửa lỗi trước). ERD 5 bảng chỉ khoá, trung tính | Đạt | **Cần sửa (lỗi 3).** Dòng 334 (gói 3): gợi ý 2 "Đưa điều kiện thương hiệu, loại vào ON, đếm COUNT(c.campaign_id) và thêm cận trên …" là toàn bộ lời giải của cả 3 lỗi. Gợi ý 1 cũng đã gọi tên cả ba. Đổi gợi ý 2 thành một biểu thức cho lỗi thứ nhất: `\goiy{\code{LEFT JOIN campaigns c ON c.start_date = k.cal_date AND c.brand_id = 3 AND c.type_id = 3}.}` Lỗi đếm và lỗi cận trên để học viên tự sửa theo gợi ý 1. |
| 27 | mkt-q4-thang-roi-tren-muc-quy-1 | 3 | Khó | Khớp (6/6, `saiso=0.0001`) | Có; `lam_tron_truoc_khi_so` chỉ rớt h1 | Sát ranh: bước (3–4 tầng), bẫy (4, có 1 chỉ ở h1) và nghiệp vụ đạt Khó. Mơ hồ chỉ ở mức TB vì yêu cầu và `\luuy` nói sẵn phạm vi so. Lời giải 1 bảng, ra 6 dòng là được phép (mẫu o4) | Đạt | **Đạt.** Nên bỏ câu thứ nhất của `\luuy` dòng 438 ("Mức so sánh … không phải ROI chung của ba thương hiệu hay ROI của cả kỳ dữ liệu.") vì yêu cầu đã ghi "của chính thương hiệu đó trong cả quý 1/2025". Câu này tháo hai bẫy `muc_chung…`, `muc_so_sanh_ca_ky` và kéo mơ hồ xuống TB. |
| 29 | mkt-t2-pheu-dang-dai | 4 | Dễ | Khớp (12/12) | Có | Đạt Dễ. Hạ cấp giữ nguyên SQL nhưng không phải "đổi nhãn": nhãn TB cũ vốn quá cao (1 bảng, 2 tầng, 1 phép chia), nay đề còn ghi rõ công thức. Đúng hướng QĐC 2.1: câu thấp hơn nhãn thì hạ | Đạt | **Đạt.** Ghi chú: bẫy `thu-tu-tang` gần như đã bị tháo vì yêu cầu đã ghi "sắp … `thu_tu` tăng dần". |
| 31 | mkt-t5-dang-chay-binh-quan-theo-tuan | 4 | Khó | Khớp (5/5, `saiso=0.1`) | Có; 4 wrong rớt cả hai | **Chưa đủ 3/5 Khó.** Chỉ bước (CTE theo ngày rồi gom tuần có tuần thiếu ngày) và số bẫy (4) đạt. Không có bẫy nào chỉ lộ ở h1 (QĐC 2.2 bắt buộc với Khó). Mơ hồ chỉ TB vì `\erdkhoa` nêu sẵn điều kiện nối khoảng. Nghiệp vụ TB. `\ghichuthietke` thiếu điểm 5 trục | Đạt | **Cần sửa (cấp + lỗi 3).** (1) Dòng 267 (gói 4) gợi ý 2 đưa trọn khung lời giải (CTE, `LEFT JOIN` với đủ điều kiện, `COUNT`, gom `week_start`). Đổi thành một biểu thức: `\goiy{\code{k.cal_date BETWEEN c.start_date AND c.start_date + INTERVAL c.duration_days - 1 DAY}.}` (2) Dòng 258 `\erdkhoa`: bỏ phần mô tả điều kiện, chỉ ghi "Lịch nối với chiến dịch theo khái niệm chiến dịch đang chạy ở tab Nghiệp vụ, không theo khoá. \code{campaign_channels}, \code{channels}, \code{brands} không cần." Khi đó mơ hồ lên Khó, đủ 3/5. (3) Thêm điểm 5 trục vào `\ghichuthietke` và ghi rõ câu không có bẫy chỉ lộ ở h1: tháng 1 không chạm dòng (b). Bài sai `lech_bien_ngay_cuoi` 9,2 giây lúc máy tải: nên đo lại riêng. |
| 33 | mkt-t7-union-mat-doanh-thu | 4 | Dễ | Khớp (3/3) | Có; starter lệch cả hai | Đạt Dễ (lỗi một từ khoá `UNION`, HD mục 6) | Đạt | **Cần sửa (nhẹ, ghi chú cũ mâu thuẫn).** Dòng 315 (gói 4) `\ghichuthietke` còn câu "Cấp: cách sửa chỉ đổi một từ khoá, người duyệt cân nhắc hạ Dễ." trong khi `cap=easy`. Xoá câu này. Ô trùng với j7, xem mục cuối. |
| 35 | mkt-t9-bo-trung-khong-het | 4 | CB | Khớp (3/3) | Có; `cat_theo_vi_tri_dong` chỉ rớt h1 | Đạt CB 4/5. Hạ cấp có đổi đề thật: định nghĩa dòng trùng nêu trong yêu cầu, ERD có dòng chép mẫu. Không phải đổi nhãn suông | Đạt | **Đạt.** Tuỳ chọn: t9 và k9 (gói 5) cùng nhân vật "Bạn Linh · Thực tập sinh", cùng khuôn lời nhắn "Em … file thô … mà …", cùng chủ đề dòng trùng (xem mục cuối). Nên đổi tên thực tập sinh ở một câu. |
| 37 | mkt-f3-hang-luot-nhap-trong-ngay | 4 | CB | Khớp (21/19) | Có | Đạt CB 5/5, như bài CB "Đơn thứ mấy của khách" của M8 | Đạt | **Đạt.** |
| 39 | mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang | 4 | CB | Khớp (85/85) | Có; starter lệch cả hai | Đạt CB: lỗi một chỗ, triệu chứng thấy ngay (mọi ngày bằng tổng quý). So với f8 (Dễ, `LEAD`/`LAG`): f8 phải hiểu chiều dịch của hàm nên vẫn khó hơn f7 một chút; khoảng cách mỏng nhưng chấp nhận được | Đạt | **Đạt.** Gợi ý duy nhất là câu hỏi, không đưa sẵn bản sửa. |
| 41 | mkt-k1-ho-so-null | 5 | CB | Khớp (3/3) | Có | Đạt CB 5/5 | Đạt | **Đạt.** Nội dung gần c2.b1 (gói 1) và c9.b1: đều đếm ô trống theo thương hiệu, nhưng k1 đếm theo từng cột còn hai case đếm dòng. Không trùng ô. |
| 43 | mkt-k5-dong-doanh-thu-lech-ban-sach | 5 | Dễ | Khớp (3/3) | Có | Đạt Dễ 5/5 (JOIN 2 bảng, gom, bẫy NULL trong phép so; đề đã nêu NULL là dòng lệch) | Đạt | **Đạt.** |
| 45 | mkt-k8-nhieu-null-ra-0 | 5 | Dễ | Khớp (18/18) | Có; starter ra 0 dòng | Đạt Dễ (giống bài Dễ M2 "= NULL và IS NULL" của lộ trình) | Đạt | **Đạt.** Tuỳ chọn: `\luuy` dòng 342 "Ô trống trong dữ liệu thô và loại nhiễu ô trống ghi trong nhật ký là hai thứ khác nhau." nghe mơ hồ. Đổi thành "Mỗi dòng nhật ký ghi một ô đã bị làm nhiễu; loại nhiễu nằm ở cột \code{noise_type}." |
| 47 | mkt-p1-ba-chi-so-mot-lan-quet | 5 | CB | Khớp (3/3) | Có; starter đúng kết quả, quét 3 lần | Đạt CB (mẫu tối ưu CB của CHOT mục 4) | Đạt | **Cần sửa (nhẹ).** Dòng 391 (gói 5) ERD ghi `revenue*=1.867.515`, `conversions*=2.355` (dấu chấm nghìn, dễ đọc thành số thập phân), lệch cách ghi giá trị dạng DB ở các ERD khác (k1 `19944`). Đổi thành `revenue*=1867515`, `acquisition_cost*=111.03`, `conversions*=2355` (đúng dòng `NY-CMP-1000`). |
| 49 | mkt-p3-top-3-doanh-thu-moi-thuong-hieu | 5 | Khó | Khớp (9/9; h1 có hoà hạng 3 Nykaa) | Có; `rank_…` chỉ rớt h1; starter đúng | Đạt theo QĐC 2.3 mục 19 (giữ Khó) | Đạt | **Đạt (ghi chú cho giảng viên).** Lý do giữ Khó ở QĐC 2.3 mục 19 có nhắc `ngansach`, nhưng câu hiện chỉ có `quettoida`. Starter ba nhánh `UNION ALL` là mẫu Dễ của CHOT mục 4; lời giải dùng hàm cửa sổ, cộng bẫy hoà ở h1. Theo QĐC 2.1 (nâng một bậc khi có thêm bẫy) thì câu ở mức TB–Khó. Không đề xuất đổi vì QĐC đã quyết. Tuỳ chọn ở bối cảnh dòng 440: "Bảng vàng … đang chép ba đoạn giống nhau" → "Bảng vàng … đang lấy số bằng ba đoạn giống nhau, mỗi thương hiệu một đoạn" (bảng vàng không tự chép). |
| 51 | mkt-p5-chi-phi-roi-bon-quy-mot-lan-quet | 5 | Dễ | Khớp (4/4) | Có; `thieu_can_tren` chỉ rớt h1; starter đúng | Đạt Dễ (mẫu tối ưu Dễ của CHOT mục 4, như o2) | Đạt | **Đạt.** Ba câu Dễ của M10 (p2, p5, p8) đều là báo cáo theo kỳ (tháng 3, quý, tháng), như người soạn tự khai. Ba câu khác hình thức hoặc mảng, không trùng ô. |
| 53 | mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | 5 | TB | Khớp (36/32) | Có | **Không đạt TB trên trục nào:** 2 bảng, 1 tầng lọc + nối, đề ghi rõ, 1 bẫy (nhầm vai), 1 khái niệm, tức thực chất Dễ. QĐC 2.3 mục 18 giữ TB, nhưng lý do đó trái QĐC 2.1/2.2 (≥ 3/5 trục) và HD mục 6. ERD TB 4 bảng có 2 bảng nhiễu (`audiences`, `brands`), vượt mức ≤ 1 của QĐC 1.3 | Đạt | **Cần sửa (cấp; giảng viên xác nhận vì trái QĐC 2.3 mục 18).** Cách nâng thật mà vẫn giữ M10 2/3/2/2: dòng 557 (gói 5) thêm cột `phan_khuc` (tên `audience_name` của `segment_id`); lọc đối tượng bằng tên `'Working Women'` thay vì mã. Học viên phải nối `audiences` hai lần với hai bí danh (danh mục hai vai, kỹ năng TB). Trả về `campaign_id`, `type_name`, `phan_khuc`, `revenue`, `roi`. ERD giữ 4 bảng, `audiences` thành bảng dùng, chỉ còn 1 bảng nhiễu. Gợi ý 2 dòng 576 đổi thành `JOIN audiences d ON d.audience_id = c.target_audience_id AND d.audience_name = 'Working Women'`. Thêm wrong nối `audiences` một lần theo `segment_id`. Nếu không sửa: hạ Dễ và nâng một câu Dễ khác của M10. |

## Tổng hợp

- Số câu: 27.
- **Đạt: 20** (r2, r6, n4, n7, c1, s1, s4, a6, c3, j3, q4, t2, t9, f3, f7, k1, k5, k8, p3, p5). Mấy câu trong số này có đề xuất tuỳ chọn, không bắt buộc.
- **Cần sửa: 7.**
  - Nặng hơn: s9, j9 (Khó; gợi ý nấc cuối đưa trọn lời giải cả 3 lỗi), t5 (gợi ý đưa trọn khung; cấp Khó chưa đủ 3/5), p7 (cấp TB không đạt trục nào).
  - Nhẹ: a3 (`\luuy` trỏ tới "đầu gói" học viên không thấy), t7 (ghi chú cũ mâu thuẫn với `cap`), p1 (giá trị mẫu ERD ghi dấu chấm nghìn).
- Không có câu chấm oan, solution sai hay wrong không rớt.

Soi 6 lỗi các vòng trước:
- (1) Starter có chú thích nói thẳng lỗi: không có. Đã xem starter của n7, s9, j9, t7, t9, f7, k8, p1, p3, p5.
- (2) Đề dẫn học viên gắn cứng ngày cuối dữ liệu: không có. Các kỳ đều ghi bằng mốc lịch: 30/6/2025, 31/5/2025, quý 2/2025, 1/6/2025. Gắn `<= '2025-06-24'` vẫn qua cả hai biến thể.
- (3) Gợi ý nấc cuối đưa trọn lời giải: s9, j9, t5 (Cần sửa). Ở câu Sửa lỗi CB/Dễ (n7, t7, t9, k8), gợi ý 2 là đúng một biểu thức sửa. QĐC 1.4 cho phép nên không tính lỗi.
- (4) Câu Sửa lỗi Khó chỉ 1 lỗi, hoặc starter ra đúng ở một biến thể: không có. s9, j9 đều có 3 lỗi, starter lệch cả hai biến thể.
- (5) Bối cảnh, tiêu đề ngầm báo kết quả: không có. Tiêu đề câu Sửa lỗi chỉ tả triệu chứng.
- (6) Lời giải thích phương án case sai với kết quả: không có. Đã đối chiếu c1, c3 trên cả hai biến thể.

Cấp và module:
- Đếm `cap=` trong 5 file `cau-hoi.tex`: cả 10 module đều 2 Cơ bản · 3 Dễ · 2 TB · 2 Khó.
- Kiểm hình thức theo cấp: ERD đúng CHOT mục 3 ở 27/27 câu.
  - Khó: 5 bảng chỉ khoá, không có `\erdnoi`.
  - Dễ: 2 bảng có chữ trên đường nối.
  - TB: 3–4 bảng chỉ có ký hiệu.
  - CB: 1 bảng có giá trị mẫu; riêng j3 2 bảng vì câu cần nối.
- Riêng TB r2, n7, s1, p7 có 2 bảng nhiễu, vượt quy ước bổ sung QĐC 1.3, nhưng hợp CHOT. Với p7 nên sửa như trên.
- Câu viết lại hoặc hạ cấp trong phần của tôi đều có đổi đề thật (định nghĩa, ERD, bẫy, số bước), không chỉ đổi nhãn. Hạ cấp giữ SQL (t2, t9, a3) là vì nhãn cũ cao hơn 5 trục, đúng QĐC 2.1.
- Tiêu đề: 27/27 câu ≤ 13 tiếng (dài nhất 13: r6, j9, f7, p3, p7).

## Ô trùng

**Trong cùng gói:** không có. Đã đếm lại từ khoá `dang`, `domain`, `cap`, `hinhthuc` của 90 câu module trong 5 file `cau-hoi.tex`.

**Giữa các gói:** đúng 8 ô như danh sách đã chốt (r1/j3, n2/s2, r5/s6, a5/j5, j7/t7, t9/k9, n5/s5, t4/k6). Kết luận cho các cặp thuộc phần tôi:

| Ô | Cặp | Trùng chủ đề? |
|---|---|---|
| A1 · marketing · basic · write | r1 (g1) / j3 (g3) | **Không.** Cả hai liệt kê chiến dịch Influencer kèm lượt hiển thị, nhưng khác mục đích (ký lại hợp đồng người ảnh hưởng / làm việc với đối tác YouTube), khác kỹ năng (lọc một bảng / nối bảng cầu nối), khác thương hiệu và kỳ. Tuỳ chọn: đổi j3 sang loại Paid Ads hoặc trả `clicks` để hai câu bớt na ná. |
| A3 · sales · easy · debug | j7 (g3) / t7 (g4) | **Không.** j7 sai do nối bảng cầu nối làm doanh thu nhân đôi; t7 sai do `UNION` bỏ dòng trùng làm hụt doanh thu. Khác cơ chế lỗi, khác kỹ năng. |
| E1 · operations · basic · debug | t9 (g4) / k9 (g5) | **Gần trùng chủ đề, chưa tới mức phải viết lại.** Cùng chủ đề dòng trùng của `campaigns_raw`, cùng nhân vật Bạn Linh · Thực tập sinh. Nhưng câu hỏi và kết quả khác nhau: t9 bỏ trùng bằng `DISTINCT` theo danh sách cột rồi đếm, cộng theo thương hiệu; k9 liệt kê mã lặp của Purplle bằng `HAVING COUNT(*) > 1`. Kỹ năng của hai module cũng khác. Nên đổi nhân vật ở một câu. |

**Bản đồ `BAN-DO-100-CAU.md` chưa cập nhật phần tổng hợp.** Các dòng bảng chính đã đúng mã và cấp mới (đã đối chiếu 27 câu của tôi), nhưng còn ba chỗ cũ:
- Mục "Ô trùng giữa các gói" (dòng 222–233) vẫn ghi "11 ô" với mã cũ: `mkt-r6-diem-tuong-tac-tu-30`, `mkt-a1-roi-tong-theo-thuong-hieu`, `mkt-a7-roi-thuong-hieu-cao-bat-thuong`, `mkt-j1-doanh-thu-loai-thuong-hieu`, `mkt-a9`/`mkt-p8-bao-cao-thang-cham-va-sai`… Mục này thiếu r1/j3, j7/t7, t9/k9. Cần thay bằng 8 ô hiện có ở trên.
- Bảng "Theo hình thức", "Theo module" (dòng 161–170) và "Theo gói" (dòng 173 trở đi) vẫn là số trước v4 (ví dụ M1 4 · 5 · · · ·). Cần sinh lại: mọi module 2 · 3 · 2 · 2.
- Mục "Kiểm khung phân bổ" (dòng 211–218) còn nhắc khung cấp cũ (M1–3 basic/easy …), đã bỏ từ QĐC 0.1 #5.

## Giọng văn

- Đã đọc mọi trường của 27 câu: tiêu đề, bối cảnh, yêu cầu, tab Nghiệp vụ, khái niệm dùng, gợi ý, `\luuy`, phương án case.
- Không thấy giọng AI: không có câu khẩu hiệu, ẩn dụ sáo, "Hãy…" dồn dập, dấu gạch ngang dài. Không thấy dịch máy rõ rệt. Không lệch thuật ngữ STYLE-mkt mục A: dùng đúng "marketing người ảnh hưởng", "quảng cáo trả phí", "đối tượng mục tiêu", "phân khúc khách hàng", "lượt nhấp", "chi phí chiến dịch", "đơn vị tiền". Lời nhắn đúng vai, xưng hô anh/chị/em tự nhiên, không nhắc kỹ thuật SQL.
- Kết luận case (c1, c3) đúng chuẩn: ba phương án, "Đúng: " chỉ ở phương án đúng, ≤ 35 tiếng.

Chỗ nên chỉnh, không chặn:
- Thời điểm "bây giờ" không thống nhất trong gói 1: r2 "năm ngoái" và r6 "quý 2 vừa rồi" (xem dòng 1, 3 của bảng).
- p3, dòng 440: "Bảng vàng … đang chép ba đoạn giống nhau" (chủ ngữ sai vật).
- k8, dòng 342: `\luuy` nói chung chung "là hai thứ khác nhau".
- "Đúng: Bước 1" viết hoa sau dấu hai chấm (c1 dòng 623 ở gói 1, c3 dòng 640 ở gói 2; c2, c4 cũng vậy). Mẫu c1 viết thường.
- Khuôn mở tab Nghiệp vụ bằng "Chọn …" quay lại ở các câu viết mới: r2 "Chọn cách làm…", r6 "Chọn nội dung…", q4 "Chọn tháng…". v2 đã đổi khuôn này ở gói 1. Không sai, chỉ lặp.
