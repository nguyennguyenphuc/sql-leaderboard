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
| mkt-t4-luat-phat-hien-so-nhat-ky | C: bối cảnh đổi "nhật ký lỗi bên dữ liệu" thành "nhật ký nhiễu gửi kèm file"; viết lại câu mô tả luật DUPLICATE theo trật tự tiếng Việt | phân tích tĩnh |
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

## Chờ giảng viên

- **t5:** ba tuần cuối tháng 6/2025 giảm mạnh (từ khoảng 6.661 xuống 0) vì dữ liệu chỉ có chiến dịch bắt đầu tới 24/6/2025, không phải vì số chiến dịch thật giảm. Đã thêm câu cảnh báo vào `\luuy`, giữ bối cảnh "xếp người cho quý 3". Cần giảng viên chốt: giữ như vậy, hay đổi khoảng xét sang quý 1/2025 để tránh các tuần thiếu dữ liệu?
- **Cấp của t7 và t9 (người kiểm B):**
  - t7 chỉ cần sửa một từ khoá (`UNION` → `UNION ALL`), nên có thể hạ xuống Dễ.
  - t9 chỉ dùng một bảng; đã đổi vai cho hợp cấp Khó. Có hạ xuống Trung bình hay không do giảng viên quyết.
  - Hiện giữ nguyên cấp của cả hai câu như bản đồ.
- **f2 trùng f8 (người kiểm B):** kết quả f2 trùng các dòng Purplle của solution f8, và c7.b2 cũng tính tăng trưởng so với tháng trước.
  - Lý do giữ: f2 là câu Viết dạy `LAG`, f8 là câu Sửa lỗi dạy `PARTITION BY` và tháng đủ.
  - Nếu cần tách, có thể đổi f2 sang kỳ quý 3–4/2024.
- **Mảng của t6:** đã đổi customer → finance theo người kiểm C, lệch với bản đồ. Bản đồ cần cập nhật nếu giảng viên đồng ý.
