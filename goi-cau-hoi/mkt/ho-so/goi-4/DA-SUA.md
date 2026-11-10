# Đã sửa · gói 4 Marketing (mkt) · v2

Theo `REVIEW-B.md`, `REVIEW-C.md`. Không đổi mã câu, không sửa database hay biến thể ẩn.
Kiểm lại:
- Câu có sửa SQL (t6, t7, t9, f7, f9) và c8 (đổi yêu cầu b4) được chạy bộ kiểm thật trên gói tạm `cong-cu/ket-qua/sua/mkt-goi-4/`.
- Cả gói được phân tích tĩnh (`--chi-phan-tich`) và biên dịch lại bằng XeLaTeX.

Bảng nhân vật của gói:
- Anh Khánh · Giám đốc marketing (c7, c8)
- Chị Hạnh · Trưởng phòng marketing số (t2, t5, t8, f1)
- Chị Ngân · Quản lý thương hiệu Purplle (t6, f2)
- Anh Quân · Quản lý thương hiệu Tira Beauty (f3)
- Anh Phong · Giám đốc tài chính (t1, f8)
- Chị Mai · Kế toán quản trị (t7, f4, f7)
- Anh Bảo · Chuyên viên phân tích marketing (t4, t9, f6)
- Chị Thảo · Chuyên viên phân tích marketing (t3, f5)
- Bạn Vy · Thực tập sinh (f9)

Câu kết "Em … giúp anh/chị" trước có ở 13/20 lời nhắn, nay chỉ còn câu Thực tập sinh f9 ("Anh chị xem giúp em").

| Mã | Đã sửa (theo B/C) | Kiểm lại |
|---|---|---|
| mkt-t1-roas-nua-dau-2025 | B: giải nghĩa ROI, ROAS ở lần đầu, bỏ "theo … theo"; gợi ý bỏ "nặng ký" | phân tích tĩnh |
| mkt-t2-pheu-dang-dai | C: `\luuy` thêm "tỷ lệ đi tiếp bằng 1 trừ tỷ lệ rơi"; sửa ghi chú `calendar`; bối cảnh viết lại, bỏ khuôn "Em … giúp chị" | phân tích tĩnh |
| mkt-t3-nhom-khach-hai-vai | B: bối cảnh và dòng mở tab Nghiệp vụ bỏ "chạm tới", "nhóm khách ghi nhận"; viết lại gợi ý 1; tiêu đề đổi thành "nhóm khách hàng" | phân tích tĩnh |
| mkt-t4-quy-tac-doi-chieu-nhat-ky | C: bối cảnh đổi "nhật ký lỗi bên dữ liệu" thành "nhật ký nhiễu gửi kèm file"; viết lại câu mô tả luật DUPLICATE theo trật tự tiếng Việt | phân tích tĩnh |
| mkt-t5-dang-chay-binh-quan-theo-tuan | B: `\luuy` đổi "ngày làm việc" thành "ngày của tuần"; thêm câu: dữ liệu chỉ có chiến dịch bắt đầu tới 24/6/2025 nên các tuần cuối tháng 6 thấp hơn thực tế; yêu cầu viết "như định nghĩa ở tab Nghiệp vụ" | phân tích tĩnh |
| mkt-t6-phan-nhom-roi-ctr | C, chấm oan: yêu cầu ghi "CTR của chiến dịch và CTR chung tính theo phần trăm, làm tròn 2 chữ số rồi mới so"; solution và hai bài sai đổi theo; kết quả public mới 15591 / 6553 / 12090 / 21321 (CTR cao 27.681, khớp số C thử); bối cảnh bỏ "nhiều lượt nhấp mà lỗ" (dùng CTR cao/thấp, ROI cao/thấp); bỏ "theo nó", "với Purplle"; mảng customer → finance; cập nhật ghi chú thiết kế | **bộ kiểm gói tạm** |
| mkt-t7-union-mat-doanh-thu | B: thay bài sai `dem_khac_nhau_sau_union_all` bằng `union_them_ngay_bat_dau` (giữ UNION, thêm `start_date`; public mất 9/10/9 dòng); bối cảnh thêm vế so sánh "so với khi"; người hỏi đổi Chị Thư → Chị Mai | **bộ kiểm gói tạm** |
| mkt-t8-ty-le-roi-pheu-sai-mau | C: `\luuy` bỏ "nó", sửa "rơi vào một tầng"; người hỏi đổi Anh Duy → Chị Hạnh, xưng "chị"; yêu cầu viết "như định nghĩa ở tab Nghiệp vụ" | phân tích tĩnh |
| mkt-t9-bo-trung-khong-het | B: thay bài sai trùng starter (`bo_raw_id_giu_row_index`) bằng `dem_khac_nhau_thay_bo_trung` (`COUNT(DISTINCT campaign_id)` và `SUM(DISTINCT revenue)`); vai Thực tập sinh → Anh Bảo · Chuyên viên phân tích (giữ cấp Khó); yêu cầu mở bằng động từ | **bộ kiểm gói tạm** |
| mkt-f1-top-3-doanh-thu-moi-thuong-hieu | C: người hỏi Chị Ngân → Chị Hạnh · Trưởng phòng marketing số | phân tích tĩnh |
| mkt-f2-mom-purplle | B: bối cảnh bỏ "chỉ tính các tháng có đủ số liệu" (lộ bẫy); yêu cầu viết "theo tháng của ngày bắt đầu chiến dịch … như định nghĩa ở tab Nghiệp vụ"; "nhịp doanh thu" → "biến động doanh thu"; `\luuy` bỏ "dù không có gì thay đổi" | phân tích tĩnh |
| mkt-f3-truot-7-ngay-tira | C: bối cảnh bỏ "bị nhiễu bởi"; tab Nghiệp vụ đổi "tuần trượt" → "trượt 7 ngày"; bỏ chữ "nhịp" | phân tích tĩnh |
| mkt-f4-pareto-tira | B: Đạt, không sửa | phân tích tĩnh |
| mkt-f5-chuoi-ngay-lien-tiep | C: viết lại bối cảnh cho đúng ngữ pháp, "đội người ảnh hưởng" → "đội phụ trách chiến dịch Influencer" (cả ở tab Nghiệp vụ); ghi chú đổi thành "5 bảng không cần"; người hỏi Chị Trang → Chị Thảo | phân tích tĩnh |
| mkt-f6-nhom-gia-tri-don-theo-phan-khuc | B: tiêu đề → "Nhóm chiến dịch giá trị đơn cao nhất của từng phân khúc"; "bốn nhóm bằng nhau" → "bốn nhóm có số chiến dịch gần bằng nhau"; người hỏi Anh Tùng → Anh Bảo | phân tích tĩnh |
| mkt-f7-chi-phi-luy-ke-nhay-bac | C: thay bài sai trùng starter (`them_distinct`) bằng `luy_ke_tu_dau_ky_roi_moi_loc`; yêu cầu sửa trật tự từ; bối cảnh đổi thành "có ngày lặp lại tới hơn trăm dòng"; "giải ngân" → "chi ngân sách" | **bộ kiểm gói tạm** |
| mkt-f8-lag-khong-chia-thuong-hieu | B, lỗi nặng: bối cảnh sửa theo số thật ("tháng 7/2024 của Purplle tăng gần gấp ba", starter ra +178,37%); tab Nghiệp vụ dùng "biến động doanh thu theo tháng"; yêu cầu mở bằng động từ | phân tích tĩnh (SQL không đổi) |
| mkt-f9-tuong-tac-cao-nhat-moi-loai | C: thay bài sai trùng starter (`chia_theo_thuong_hieu`) bằng `chia_loai_nhung_sap_tang_dan`; tiêu đề thêm "điểm" và "chỉ"; bối cảnh bỏ nối "mà" | **bộ kiểm gói tạm** |
| mkt-c7-doanh-thu-nykaa-co-giam | B: cân độ dài ba phương án (đúng 154, hai phương án sai 145 và 136 ký tự; cả ba đều có số hoặc mức độ); sửa lời giải thích phương án 3 (doanh thu mỗi chiến dịch tháng 2 thấp hơn tháng 3 một chút, nên giải thích chỉ so số chiến dịch mỗi ngày); bối cảnh đổi "do cách đếm" → "do tháng đó ít ngày, ít chiến dịch"; b3 viết "mỗi ngày có chiến dịch bắt đầu"; người hỏi Anh Quân → Anh Khánh | phân tích tĩnh (SQL không đổi) |
| mkt-c8-doi-tuong-dang-tang-ngan-sach | C: cân độ dài ba phương án (146, đúng 157, 150 ký tự), bỏ chữ rào chỉ có ở phương án đúng; đổi "vài phần trăm của một đơn vị ROI" thành "chưa tới 0,02"; bỏ "không đứng đầu ở mọi thương hiệu", thay bằng "đổi hạng theo thương hiệu"; bỏ chữ "nên" lặp ở phương án 3; ghi chú sửa hạng ở hidden-1 thành 2, 4, 2; b4 thêm "so trên ROI chưa làm tròn"; người hỏi Chị Lan → Anh Khánh | **bộ kiểm gói tạm** |

## Chờ giảng viên (đã quyết ở v3, xem mục "Quyết định v3 (10/11)")

- **t5:** ba tuần cuối tháng 6/2025 giảm mạnh (từ khoảng 6.661 xuống 0) vì dữ liệu chỉ có chiến dịch bắt đầu tới 24/6/2025, không phải vì số chiến dịch thật giảm. Đã thêm câu cảnh báo vào `\luuy`, giữ bối cảnh "xếp người cho quý 3". Cần giảng viên chốt: giữ như vậy, hay đổi khoảng xét sang quý 1/2025 để tránh các tuần thiếu dữ liệu?
- **Cấp của t7 và t9 (người kiểm B):**
  - t7 chỉ cần sửa một từ khoá (`UNION` → `UNION ALL`), nên có thể hạ xuống Dễ.
  - t9 chỉ dùng một bảng; đã đổi vai cho hợp cấp Khó. Có hạ xuống Trung bình hay không do giảng viên quyết.
  - Hiện giữ nguyên cấp của cả hai câu như bản đồ.
- **f2 trùng f8 (người kiểm B):** kết quả f2 trùng các dòng Purplle của solution f8, và c7.b2 cũng tính tăng trưởng so với tháng trước.
  - Lý do giữ: f2 là câu Viết dạy `LAG`, f8 là câu Sửa lỗi dạy `PARTITION BY` và tháng đủ.
  - Nếu cần tách, có thể đổi f2 sang kỳ quý 3–4/2024.
- **Mảng của t6:** đã đổi customer → finance theo người kiểm C, lệch với bản đồ. Bản đồ cần cập nhật nếu giảng viên đồng ý.

## Quyết định v3 (10/11)

BG = `lesson1_marketing_analytics_foundations.md`, thư mục `Project 01 Marketing Analytics Foundations & Data Pipeline` (ổ H:). QĐC = `QUYET-DINH-CHUNG.md`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `mkt-t5-dang-chay-binh-quan-theo-tuan` | Tuần cuối tháng 6/2025 giảm về 0 do dữ liệu dừng ở ngày bắt đầu 24/6/2025 | Đổi khoảng xét sang quý 1/2025 (1/1–31/3/2025); bối cảnh thành "xếp người cho quý 2/2025". | BG III.B: cột Date là "Ngày bắt đầu campaign", dữ liệu không có chiến dịch mở sau 24/6/2025 (mysql/README-mkt.md "Cửa sổ thời gian"), nên số đang chạy cuối tháng 6 là do dữ liệu bị cắt, không phải thực tế. Quý 1 đủ dữ liệu và có chiến dịch mở từ tháng 12/2024 chạy sang. | **Đổi SQL**: lời giải theo quý 1; bỏ bài sai nối trong (quý 1 ngày nào cũng có chiến dịch, bài này không còn rớt); thêm `chi_chien_dich_bat_dau_trong_quy` và `chia_bay_ngay`; `thieu_can_tren`, `lech_bien_ngay_cuoi` theo khoảng mới. Khoá `bay`, yêu cầu 1, `\luuy`, gợi ý 1, `\ghichuthietke` viết lại. ERD giữ 5 bảng (QĐC 1.3 bản 23:05). |
| `mkt-t4-quy-tac-doi-chieu-nhat-ky` (cũ `mkt-t4-luat-phat-hien-so-nhat-ky`) | Mã còn chữ "luat" | Đổi mã theo lượt đổi mã của 3.6. | BAO-CAO 3.8; STYLE-mkt dùng "quy tắc kiểm tra". | Đổi `ma` đồng bộ. |
| `mkt-t6-phan-nhom-roi-ctr` | Mảng customer → finance | Chấp nhận finance. | STYLE-mkt G: ROI, chi phí thuộc `finance`; bản đồ v2 đã cập nhật. | Không đổi. |
| `mkt-t7-union-mat-doanh-thu` | Sửa một từ khoá | **Hạ Dễ** (QĐC bản 23:05 bỏ ngoại lệ "M7, M8 không có Dễ"). | QĐC 0.1 #5, 2.3 mục 17; HD mục 6 (Sửa lỗi Dễ = lỗi bỏ trùng kiểu `COUNT(*)`/`COUNT(DISTINCT)`, ở đây `UNION`/`UNION ALL`). | `cap=easy`; ERD 2 bảng có chữ trên đường nối (bỏ `campaign_types`); `\ghichuthietke`; bản đồ. |
| `mkt-t9-bo-trung-khong-het` | Một bảng, cấp Khó | Giữ Khó: lỗi của starter là sai định nghĩa "dòng trùng" (so cả cột vị trí), đúng điều kiện của QĐC; bài sai cắt cứng theo vị trí chỉ lộ ở hidden-1. | QĐC 2.3 mục 17. | ERD giữ 5 bảng chỉ khoá (QĐC 1.3 bản 23:05 cho thêm bảng nhiễu khi lời giải dùng ít bảng); `\ghichuthietke` ghi lý do. |
| `mkt-f2-mom-purplle` / `mkt-f8` | f2 trùng một phần kết quả f8 | Giữ cả hai. | QĐC 1.6 (f2 dạy `LAG`, f8 dạy `PARTITION BY`). | Thêm câu chuẩn vào `\ghichuthietke` f2. |
| `mkt-f9-tuong-tac-cao-nhat-moi-loai` | "Tira Beauty có đủ năm loại chiến dịch" quý 1/2025 cần xác nhận | Giữ lời nhắn: đã kiểm. | Truy vấn đếm 10/11: Tira Beauty, `start_date` 1/1–31/3/2025: `COUNT(DISTINCT type_id)` = 5 ở cả `mkt` (14.445 chiến dịch) và `mkt_hidden_1` (12.990); `campaign_types` có 5 loại. | Không đổi. |

Kiểm: bộ kiểm đầy đủ gói 4 (public + hidden-1) **KIEM TRA: 0 loi**, mọi bài sai mới của t5 rớt; biên dịch lại (xem cuối mục).

### Sửa lúc 23:15 theo QUYET-DINH-CHUNG bản 23:05 (đối chiếu quy chuẩn)

- Kết luận case (QĐC 0.1 #1, theo `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4): lời giải thích của phương án đúng mở bằng "Đúng: "; phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Áp cho mọi case của gói.
- ERD Khó (QĐC 0.1 #4): t5, t9 trả lại các bảng nhiễu đã bỏ lúc đầu lượt v3, giữ đủ 5 bảng chỉ khoá theo CHOT-FORMAT mục 3.
- t7 hạ Dễ (QĐC 0.1 #5), xem bảng trên.

### Chuẩn hoá theo quy chuẩn (10/11, BRIEF-CHUAN-HOA)

Không sửa nội dung gói 4 (ERD Khó đã đạt, tiêu đề ≤ 13 tiếng). File hồ sơ chuyển sang `ho-so/goi-4/`. Xem `../CHUAN-HOA.md`.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: lộ trình chuẩn (`quy_chuan/lo-trinh-sql/assets/js/data.js`) cho mỗi module đủ Cơ bản → Khó; mục tiêu mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug. Đổi số câu tối thiểu: M7 đổi 4 câu (2 Khó, 2 Trung bình xuống Cơ bản/Dễ), M8 đổi 5 câu (2 Khó, 3 Trung bình xuống Cơ bản/Dễ; module không có câu Cơ bản, Dễ nào nên 5 là tối thiểu). Năm trục (QUYET-DINH-CHUNG 2.2): số bảng lời giải cần · số tầng xử lý · mức mơ hồ · số bẫy dữ liệu · độ sâu nghiệp vụ; điểm từng trục ghi ở `\ghichuthietke` của từng câu. Mẫu làm theo: mục v4 của `../../../hr/ho-so/goi-4/DA-SUA.md` (cùng hai module).

### Gói vỡ dở lúc nhận việc

Lượt v4 trước dừng giữa chừng (xem `TRANG-THAI-V4.md`): `solution.sql` đã có khối SQL cho bốn câu theo hướng mới với mã mới (`mkt-t6-so-chien-dich-theo-so-kenh`, `mkt-f3-hang-luot-nhap-trong-ngay`, `mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang`, `mkt-f8-thang-truoc-lay-so-thang-sau`), còn `cau-hoi.tex` vẫn là đề v3 với mã cũ, nên kiểm tĩnh báo 24 lỗi (thiếu khối của mã cũ). Đề của bốn câu này chưa được viết lại (`git log -p`: lần sửa `cau-hoi.tex` cuối cùng là v3). Quyết định: **hoàn thiện theo hướng đó** (bốn hướng đều khớp bài Cơ bản, Dễ của M7, M8 trên lộ trình và lấp đúng ô cấp còn thiếu): viết đủ 8 phần đề cho bốn mã mới; giữ SQL đã có, riêng f3 thêm điều kiện ngôn ngữ English để kết quả còn 21 dòng (bản dở cho 58 dòng). Năm câu còn lại để đủ 2/3/2/2 (t2, t8, t9, f2, f6) chọn trong lượt này.

### Phân bố cấp

| Module | Trước (Cơ bản / Dễ / TB / Khó) | Sau | Hình thức sau |
|---|---|---|---|
| M7 CTE & Set Operations | 0 / 1 / 4 / 4 | 2 / 3 / 2 / 2 | 6 write + 3 debug (debug: t9 Cơ bản, t7 Dễ, t8 Dễ) |
| M8 Window Functions | 0 / 0 / 5 / 4 | 2 / 3 / 2 / 2 | 6 write + 3 debug (debug: f7 Cơ bản, f8 Dễ, f9 TB) |
| Case | c7 TB · c8 Khó | giữ nguyên | |

Sau v4: M7 Cơ bản t6, t9 · Dễ t2, t7, t8 · TB t1, t3 · Khó t4, t5. M8 Cơ bản f3, f7 · Dễ f2, f6, f8 · TB f1, f9 · Khó f4, f5.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (cấp mới) |
|---|---|---|---|
| `mkt-t2-pheu-dang-dai` (giữ mã) | TB → Dễ | Câu đạt cấp thấp hơn nhãn nên hạ (QĐC 2.1). Cách lấy số lượng từng tầng (cột nào) và công thức tỷ lệ đi tiếp ghi ngay trong yêu cầu, bỏ khái niệm tỷ lệ rơi ở tab Nghiệp vụ; sắp theo `thu_tu`; ERD 2 bảng có chữ trên đường nối (bỏ `calendar`); `bay` còn `thu-tu-tang`. SQL không đổi. | 1 bảng · 2 tầng (CTE bốn tổng, bốn nhánh `UNION ALL`) · đề ghi rõ cột và công thức · 1 bẫy (thứ tự tầng là chuỗi) · 1 phép chia → 5/5 Dễ |
| `mkt-t6-phan-nhom-roi-ctr` → `mkt-t6-so-chien-dich-theo-so-kenh` | Khó → Cơ bản | Viết lại (hướng của lượt trước): số chiến dịch theo số kênh, CTE gom hai lượt trên `campaign_channels` (bài Cơ bản "viết lại bảng dẫn xuất thành CTE" của lộ trình). Dạng C4 → A3, mảng finance → marketing. ERD 1 bảng có giá trị mẫu. Wrong đếm theo `channel_pos`; wrong cộng số kênh thay vì đếm chiến dịch. Bỏ khai báo khái niệm CTR (không câu nào dùng nữa). | 1 bảng · 1 tầng mỗi lượt gom · đề ghi rõ cách đếm, ERD có giá trị mẫu · 0 bẫy · 1 khái niệm → 5/5 Cơ bản |
| `mkt-t8-ty-le-roi-pheu-sai-mau` (giữ mã) | TB → Dễ | Truy vấn khởi đầu vốn chỉ sai mẫu số của tầng 4 (lỗi logic một chỗ, Sửa lỗi Dễ theo HD mục 6); ghi chú cũ nói sai "tầng 3, 4". Công thức tỷ lệ rơi và thứ tự bốn cột ghi ngay trong yêu cầu; gợi ý 2 chỉ đúng một chỗ sửa; ERD 2 bảng có chữ trên đường nối (bỏ `brands`); `bay` còn `mau-so-tang-dau`. SQL không đổi. | 1 bảng · 2 tầng · đề ghi rõ công thức · 1 lỗi một chỗ · 1 phép chia → 5/5 Dễ |
| `mkt-t9-bo-trung-khong-het` (giữ mã) | Khó → Cơ bản | Định nghĩa dòng trùng (mọi cột trừ `raw_id`, `row_index`) ghi ngay trong yêu cầu nên lỗi còn lại là một chỗ dễ thấy (`DISTINCT *`). ERD 1 bảng đủ 19 cột, giá trị mẫu là một dòng chép (`raw_id` 55585, `row_index` 55584) và `\luuy` chỉ dòng gốc; bỏ bốn bảng nhiễu. Người hỏi đổi Anh Bảo → Bạn Linh · Thực tập sinh (Sửa lỗi cấp thấp, STYLE-mkt B.2). SQL không đổi (wrong cắt cứng vị trí vẫn rớt ở hidden-1). Lý do giữ Khó ở v3 (QĐC 2.3 mục 17: sai định nghĩa dòng trùng) không còn vì đề đã nêu định nghĩa. | 1 bảng · khởi đầu 2 tầng, sửa danh sách cột · đề ghi rõ cột cần bỏ, ERD có giá trị mẫu · 0 bẫy trong đề · 1 khái niệm → 4/5 Cơ bản |
| `mkt-f2-mom-purplle` (giữ mã) | TB → Dễ | Câu đạt cấp thấp hơn nhãn nên hạ (bài Dễ "doanh thu so với hôm trước" của lộ trình). Công thức mức thay đổi ghi ngay trong yêu cầu; tháng đầu nêu rõ là 2024-07; ERD 2 bảng có chữ trên đường nối (bỏ `calendar`); `bay` còn `mau-so-thang-truoc`; bỏ ghi chú trùng với f8 (f8 đã đổi). SQL không đổi. | 1 bảng · 2 tầng (gom tháng, `LAG` và phép chia) · đề ghi rõ kỳ, cột, công thức · 1 bẫy (mẫu số) · 1 phép chia → 5/5 Dễ |
| `mkt-f3-truot-7-ngay-tira` → `mkt-f3-hang-luot-nhap-trong-ngay` | Khó → Cơ bản | Viết lại (hướng của lượt trước): đánh số `ROW_NUMBER()` chiến dịch Social Media tiếng Anh của Purplle trong từng ngày 3/3, 4/3/2025 theo lượt nhấp (bài Cơ bản "đơn thứ mấy của khách"). Thêm `language_id = 2` vào SQL (58 → 21 dòng; hidden-1 19 dòng). Dạng B3 → C1. ERD 1 bảng, giá trị mẫu lấy chiến dịch ngày 1/3 (không nằm trong kết quả). Wrong thiếu `PARTITION BY`; wrong sắp tăng dần. Tổng trượt `ROWS BETWEEN` không còn trong gói. | 1 bảng · 1 tầng · đề ghi rõ cột, giá trị lọc, tiêu chí phụ · 0 bẫy · 1 khái niệm → 5/5 Cơ bản |
| `mkt-f6-nhom-gia-tri-don-theo-phan-khuc` (giữ mã) | TB → Dễ | Công thức giá trị đơn bình quân ghi ngay trong yêu cầu; bỏ cột tổng doanh thu của nhóm (SQL ba khối bỏ `SUM(revenue)`, bỏ `NULLIF` vì không có chiến dịch 0 lượt chuyển đổi); ERD 2 bảng có chữ trên đường nối, `audiences` một vai (bỏ đường nối đối tượng mục tiêu và `brands`); `bay` còn `ntile-nhom-le`. | 1 bảng · 2 tầng (`NTILE` trong CTE, lọc và gom) · đề ghi rõ công thức, tiêu chí phụ · 1 bẫy (nhóm lệch) · 1 phép chia → 5/5 Dễ |
| `mkt-f7-chi-phi-luy-ke-nhay-bac` → `mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang` | TB → Cơ bản | Viết lại (hướng của lượt trước): truy vấn khởi đầu đã gom theo ngày nhưng `SUM(...) OVER ()` thiếu `ORDER BY start_date`, mọi ngày bằng tổng quý (lỗi một chỗ, triệu chứng thấy ngay). ERD 1 bảng có giá trị mẫu (chiến dịch ngày 31/3, ngoài kỳ). Người hỏi Bạn Tú · Thực tập sinh. Wrong `PARTITION BY start_date`; wrong `ORDER BY start_date DESC`. Lỗi "gom trước khi cộng dồn" của bản cũ không còn trong gói. | 1 bảng · khởi đầu 2 tầng, sửa một chỗ · đề nêu rõ cách tính luỹ kế · 0 bẫy · 1 khái niệm → 4/5 Cơ bản |
| `mkt-f8-lag-khong-chia-thuong-hieu` → `mkt-f8-thang-truoc-lay-so-thang-sau` | Khó → Dễ | Viết lại (hướng của lượt trước): số chiến dịch Tira Beauty theo tháng 7/2024–5/2025, truy vấn khởi đầu dùng `LEAD` thay `LAG` (lỗi logic một chỗ: nhầm chiều). Mảng sales → marketing. ERD 2 bảng có chữ trên đường nối. Wrong `LAG` sắp theo số chiến dịch; wrong `LAG` độ lệch 2. Lỗi thiếu `PARTITION BY` vẫn có ở f9 (TB). | 1 bảng · 2 tầng · đề ghi rõ kỳ, cột, tháng đầu để trống · 1 lỗi một chỗ · không công thức → 4/5 Dễ |

Sửa thêm, không đổi cấp: `mkt-t5-dang-chay-binh-quan-theo-tuan` (Khó, giữ mã). Đo lại riêng khi MySQL gần rảnh (CPU container 10–18%): lời giải v3 (quý 1/2025, 90 ngày lịch) mất 13–15 giây, vượt mức 10 giây; `EXPLAIN ANALYZE` cho thấy mỗi ngày lịch đọc lại 166.665 dòng `campaigns` qua chỉ mục `start_date`, nên mọi cách giải nối khoảng ngày tự nhiên đều chậm như vậy. Rút khoảng xét về tháng 1/2025 (31 ngày): lời giải còn khoảng 4,8 giây (public), 3,2 giây (hidden-1). Bối cảnh, yêu cầu, `\luuy`, tab Nghiệp vụ đổi "quý" thành "tháng"; bốn bẫy giữ được (chiến dịch bắt đầu cuối tháng 12/2024 còn chạy sang tháng 1; ngày cuối thừa một ngày; tuần 30/12/2024 và 27/1/2025 chỉ có 5 ngày). Wrong `thieu_can_tren` (lịch tới 30/6/2025, chạy rất lâu) thay bằng `can_tren_lay_ca_ngay_1_2` (`BETWEEN` tới 1/2/2025, tuần cuối ra 6 ngày); wrong `chi_chien_dich_bat_dau_trong_quy` đổi tên `..._trong_ky`. Khoá `bay` đổi `thieu-can-tren` → `can-tren-lay-them-ngay`.

Giữ nguyên (cấp đã đúng chỗ): M7 t1, t3 (TB), t4, t5 (Khó, xem trên), t7 (Dễ); M8 f1, f9 (TB), f4, f5 (Khó); case c7, c8. Không hạ f1 xuống Dễ vì ô C1 · sales · Dễ · write đã có `mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu` (gói 3, nội dung gần giống); không hạ f9 vì thiếu `PARTITION BY` là sai phạm vi cửa sổ, mức TB theo QĐC 2.2.

Kỹ năng sau v4: M7 có CTE gom hai lượt (t6), CTE + `JOIN` (t1), `UNION ALL` dạng dài (t2, t3), `UNION`/`UNION ALL` (t7), nhiều CTE + `EXISTS` (t4), nối khoảng ngày (t5), `DISTINCT` (t9), phép chia trong CTE (t8). M8 có `ROW_NUMBER` (f3, f1, f9), `LAG`/`LEAD` (f2, f8), luỹ kế (f7, f4), `NTILE` (f6), chuỗi liên tiếp (f5). `WITH RECURSIVE` và `ROWS BETWEEN` trượt không có trong gói.

Nhân vật mới: Bạn Linh · Thực tập sinh (t9), Bạn Tú · Thực tập sinh (f7). Chị Hạnh thêm t6, Chị Ngân thêm f3, Anh Quân hỏi f8 (thay f3 cũ), Anh Phong không còn ở f8.

### Kiểm lại

- Bộ kiểm đầy đủ cả gói (`cong-cu/ket-qua/cap-do/mkt-goi-4/`): **KIEM TRA: 0 loi**, 0 cảnh báo, 20 câu, 79 khối SQL. Mọi wrong rớt ≥ 1 biến thể (wrong của 9 câu đổi rớt cả public và hidden-1, trừ t9 `cat_theo_vi_tri_dong` chỉ rớt ở hidden-1 như thiết kế). Starter của t8, t9, f7, f8 khác solution.
- Kết quả public ≠ hidden-1 ở mọi khối solution (số dòng hoặc giá trị): t6 3/3 dòng (55.523/55.568/55.574 so với 50.089/49.952/49.960), f3 21/19 dòng, f7 85/85, f8 11/11, f2 11/11, f6 5/5, t2 12/12, t8 5/5, t9 3/3.
- Thời gian solution (bộ kiểm chạy lúc MySQL đang phục vụ thêm bốn gói khác, CPU container 100–290%): câu đổi chậm nhất t9 khoảng 5–6 giây, t4 (không đổi) 5–6 giây, các câu đổi khác dưới 1,4 giây. t5 sau khi rút về tháng 1: 4,7 giây (public), 3,5 giây (hidden-1) trong bộ kiểm lần cuối; đo riêng lúc máy gần rảnh 4,8 và 3,2 giây.
- Biên dịch XeLaTeX (`cong-cu/ket-qua/cap-do/mkt-goi-4/bien-dich/`): 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo `aio-sql-cauhoi`.
- Đếm lại cấp từ `cau-hoi.tex`: M7 2/3/2/2, M8 2/3/2/2; c7 medium, c8 hard. Thư mục gói vẫn đúng 4 file.
- Bản đồ: không sửa `BAN-DO-100-CAU.md`; 10 dòng mới (9 câu đổi cấp và t5) kèm mã cũ ở `BAN-DO-V4-DONG.md`.

### Cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6)

Đọc lại mọi trường mới hoặc sửa của 9 câu. Đã sửa trước khi chốt:
- Khuôn "Em … giúp chị/anh" lặp ở 4 lời nhắn mới → t6 "Chị cần biết có bao nhiêu chiến dịch chạy một kênh, bao nhiêu chạy hai kênh, bao nhiêu chạy ba kênh."; f3 "Trong từng ngày, chị cần thứ tự các chiến dịch từ nhiều lượt nhấp nhất trở xuống."; f8 "Anh cần bản đúng trước buổi họp tuần sau."; f7 "Em chưa tìm ra mình sai ở đâu." Chỉ t9 (thực tập sinh) giữ "Anh chị xem giúp em", như mẫu d1.
- Khuôn "mệnh đề: kết luận" ở `\luuy` f3 ("Thứ hạng tính riêng trong từng ngày: mỗi ngày…") → "Thứ hạng tính riêng trong từng ngày, nên mỗi ngày có một chiến dịch số 1; …".
- `\luuy` f3 bản nháp nêu một nhận xét về số liệu không đúng (chiến dịch đứng đầu ngày 4/3 ít lượt nhấp hơn nhiều chiến dịch ngày 3/3; thật ra chỉ thua một chiến dịch) → bỏ, chỉ giữ quy tắc.
- Tên Bạn Duy (f7) trùng tên Anh Duy · Giám đốc marketing (c7, c8) → Bạn Tú.
Không còn chỗ giọng AI, dịch máy hay lệch thuật ngữ STYLE-mkt A mà tôi thấy; thuật ngữ dùng đúng bảng A ("lượt nhấp", "khách hàng tiềm năng", "chi phí chiến dịch", "marketing mạng xã hội (Social Media)", "kênh quảng cáo"). Dấu hai chấm còn lại chỉ dùng để mở danh sách (t2 "bốn tầng: nhận biết là…").

### Nghi trùng ô

- Trong gói: không trùng ô dạng × mảng × cấp × hình thức. Cặp gần nhau: t2 (D1 · marketing · Dễ · write) và t8 (D1 · marketing · Dễ · debug), f2 (B2 · sales · Dễ · write) và f8 (B2 · marketing · Dễ · debug), khác hình thức (và mảng).
- Với bản đồ bộ (bản 2) và các gói đang sửa song song (đọc `cau-hoi.tex` gói 1, 2, 3, 5 lúc 11/11): 9 ô mới không trùng dòng nào. Nghi trùng nội dung, không trùng ô: t2 với `mkt-a2-pheu-theo-loai` (gói 2, A3 · marketing · Dễ · write, phễu theo loại); f8 với `mkt-s1-social-nykaa-theo-thang` (gói 2, đếm chiến dịch theo tháng, Cơ bản). Các gói khác đang sửa song song, cần rà lại khi ghép bản đồ.
