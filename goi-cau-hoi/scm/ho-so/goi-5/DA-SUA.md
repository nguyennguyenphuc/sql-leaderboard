# Đã sửa · gói 5 Supply Chain (v2, 10/11/2026)

Theo `REVIEW-B.md`, `REVIEW-C.md` và lời nhắn điều phối. Không sửa database, không sửa biến thể ẩn, không đổi `ma`.
Kiểm lại: gói tạm `cong-cu/ket-qua/sua/scm-goi-5/` (k8, k9, p4, p9, c9: các câu đổi SQL hoặc yêu cầu có nghĩa) chạy bộ kiểm trên MySQL; cả gói chạy `--chi-phan-tich` → `KIEM TRA: 0 loi`; biên dịch `cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu (`cong-cu/ket-qua/bien-dich/scm-goi-5/`).

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| `scm-k1-ban-khong-co-ton-kho` | Tiêu đề "Mã hàng nào có bán nhưng thiếu số tồn kho kỳ 2017-07?"; bối cảnh "báo cáo fill rate…", bỏ "dòng" trong lời nhắn; nghiệp vụ giải nghĩa fill rate (tỷ lệ lấp đầy); `\luuy` "Phần lớn cặp… có một dòng cho mỗi kỳ" (đúng số thật). Khái niệm `dong-thieu-cap`: bỏ mẹo SQL khỏi ô "Trong bộ dữ liệu" (B.7). | phân tích tĩnh |
| `scm-k2-ngay-le-ghi-hai-dong` | Tiêu đề "Ngày nào có hai dòng lễ ở cùng địa phương?"; bối cảnh và `\luuy` "ngày lễ" thay "ngày nghỉ", bỏ đảo nhấn "mới bị tính thừa"; `\goiy` bỏ khẩu hiệu "không thừa không thiếu cột"; ghi chú thiết kế nêu dữ liệu không có dòng chép y hệt. | phân tích tĩnh |
| `scm-k3-co-dung-han-mau-thuan` | `\luuy` bỏ câu nói thẳng lời sửa ("kể cả dấu bằng ở biên"); bối cảnh viết lại cho rõ người nói; nghiệp vụ "cờ đúng hạn có sẵn" thay "cột cờ"; bỏ dấu phẩy trước "và"; ghi chú thiết kế nêu đề nghị cân nhắc hạ Dễ. | phân tích tĩnh |
| `scm-k4-giao-dich-thap-bat-thuong` | Vai người hỏi đổi thành Nhân viên kế hoạch nhu cầu; "lượt khách" → "lượt giao dịch" (2 chỗ); "gần như không có giao dịch" → "lượt giao dịch thấp bất thường" (khớp ngưỡng 20\%). | phân tích tĩnh |
| `scm-k5-tuan-khong-co-chuyen-giao` | Giải nghĩa DC lần đầu; `yeucau` mục 1 mở bằng "Xét bảng…", mục 2 bỏ khuôn "Với từng"; thay khái niệm `dong-thieu-cap` bằng khái niệm mới `khoang-trong-thoi-gian`; `\luuy` bỏ khuôn "không phải". | phân tích tĩnh |
| `scm-k6-doi-soat-don-can-xu-ly` | Bỏ "nó" (2 chỗ); `yeucau` mục 1 viết lại ("So số đơn cần xử lý… theo hai cách"); `\luuy` bỏ đảo nhấn; thống nhất tên nguồn "bảng/báo cáo vận hành kho" (bỏ "hệ thống vận hành", "sổ vận hành"); khái niệm `don-can-xu-ly` "phân loại rồi giao đi tiếp". | phân tích tĩnh |
| `scm-k7-doi-soat-nhan-su` | `\luuy` bỏ câu nói thẳng lời sửa; bối cảnh bỏ "bảng", sửa "gấp mấy trăm lần số ngày của cả năm"; ERD đường nối ghi rõ khoá ghép `hub_id, date`. | phân tích tĩnh |
| `scm-k8-ban-hai-nguon-lech` | **Chấm oan (C):** `yeucau` không còn nói "hai lỗi"; thêm mục 2 nói rõ \code{ban_tu_sales}, \code{luong_tra} gồm mọi dòng bán của cửa hàng, kể cả mã hàng không có dòng tồn kho (mã 205209 ở cửa hàng 47 chỉ có dòng trả −1,44). Solution vốn đã tính như vậy, nên SQL giữ nguyên. Bối cảnh bỏ "truy vấn"; ghi chú thiết kế nêu lỗi thứ ba của starter (INNER JOIN). | bộ kiểm gói tạm |
| `scm-k9-doanh-thu-hai-nguon` | `yeucau`: mục 1 mở bằng "Tính…"; ghi rõ chênh lệch và \code{chenh_pct} tính từ doanh thu chưa làm tròn; mục 3 ghi chiều sắp "giảm dần" rồi mới lấy 5 dòng; tiêu đề "…có doanh thu hai nguồn lệch nhau nhiều nhất?"; `\luuy` bỏ khuôn "không phải" (không chỉ thẳng vào wrong). | bộ kiểm gói tạm |
| `scm-p1-po-theo-kiem-dinh` | Bối cảnh bỏ "truy vấn", bỏ "Nó"; tiêu đề "Đơn mua theo kết quả kiểm định với một lần quét". | phân tích tĩnh |
| `scm-p2-don-kho-ve-tinh-theo-nam` | Tiêu đề không còn đọc thành mệnh lệnh: "Tỷ lệ huỷ đơn của kho vệ tinh theo năm chỉ với một lần quét"; câu quyết định đổi theo đề xuất của B (xem Chờ giảng viên). | phân tích tĩnh |
| `scm-p3-ncc-cham-hon-nganh` | Người hỏi đổi thành Data engineer, bỏ "Truy vấn" khỏi lời nhắn; tiêu đề bỏ viết tắt NCC; `yeucau` tách ba mục; `\luuy` bỏ "một phiếu", khuôn "không phải"; ghi chú thiết kế nêu mỗi ngành có đúng 2 nhà cung cấp và ràng buộc không ép được `AVG() OVER`. | phân tích tĩnh |
| `scm-p4-ty-trong-von-ton-nganh` | **Hai biến thể giống hệt (B):** đổi phạm vi từ kỳ cố định 2017-07 sang kỳ mới nhất (`ym` lớn nhất, `MAX(ym)` tính từ chỉ mục, không thành lần quét). Hidden-1 có kỳ 2017-09 nên kết quả khác public; bài ghi 33 dòng hằng số không qua. Starter, solution viết lại; wrong mới `ghi_cung_ky_2017_08` (rớt ở hidden-1), giữ wrong mẫu số mọi kỳ (`tong_moi_ky`). Người hỏi đổi thành Data engineer; tiêu đề "theo ngành hàng chỉ với một lần quét"; `\luuy` viết lại, thêm khái niệm `ky-va-thang-du`. | bộ kiểm gói tạm |
| `scm-p5-luy-ke-giao-dich-thang-7` | "lượt khách" → "lượt giao dịch" (2 chỗ). | phân tích tĩnh |
| `scm-p6-don-truot-7-ngay` | `\luuy` "Sáu ngày đầu năm 2016…" (sửa số); bỏ câu nhắc kỹ thuật trùng `\goiy`; tiêu đề "Tổng đơn cần xử lý 7 ngày gần nhất chỉ với một lần quét"; bối cảnh viết lại. | phân tích tĩnh |
| `scm-p7-ty-le-dung-han-sau-khi-gop` | Bối cảnh: "gộp ba báo cáo số đơn, tỷ lệ huỷ và tỷ lệ giao đúng hạn theo miền làm một", bỏ "truy vấn"; tiêu đề "Tỷ lệ giao đúng hạn theo miền lệch báo cáo cũ"; `\luuy` bỏ câu dạy đời, nêu mẫu số của từng chỉ số. | phân tích tĩnh |
| `scm-p8-voucher-dem-hai-lan` | Bối cảnh bỏ kỹ thuật ("tách điều kiện hoặc… chỉ mục"); câu quyết định đổi thành "Lập danh sách đơn cần rà soát…" cho khớp điều kiện "kho Huế hoặc có voucher". | phân tích tĩnh |
| `scm-p9-bao-cao-kho-thang-7` | Tiêu đề thành câu hỏi kinh doanh "Từng kho vận hành ra sao trong tháng 7/2017?"; bối cảnh "Đầu tháng…", bỏ "truy vấn"; `yeucau` mở bằng "Tính…", ghi rõ số đơn kể cả đơn huỷ; nghiệp vụ "mỗi tháng"; `\luuy` viết lại. | bộ kiểm gói tạm |
| `scm-c9-kho-ha-noi-qua-tai` | **K32:** ba phương án viết lại cùng độ dài, cùng một câu, không còn từ tuyệt đối riêng ở phương án sai; lời giải thích đúng ≤ 30 tiếng. Bước 3 "ngày không quá tải" thay "ngày thường" (tránh hai nghĩa). Đổi tên wrong b1 thành `nguong_0_9` cho khớp mã. | bộ kiểm gói tạm |
| `scm-c10-do-dung-hoc-tap-thieu-hut` | **K32:** ba phương án cùng một câu, dài gần bằng nhau; bỏ "gấp đôi". Tiêu đề, phương án dùng "thiếu hụt" thay "thiếu hàng"; bối cảnh viết lại; tiêu đề b3, b4 bỏ ẩn dụ; b2 bỏ `\goiy` về đơn chưa về (vô tác dụng vì mọi đơn đã về), thay bằng gợi ý ngành hàng ở `items.family` và cách tính lead time; thêm khái niệm `lead-time-ncc`. | phân tích tĩnh |

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Biến thể ẩn giống public** (trước ở mục Chờ giảng viên): không cần `scm_hidden_2`; `mysql/04_bo_sung_bien_the_scm.sql` đưa thẳng vào `scm_hidden_1` các thay đổi B, C đề xuất: `holidays` chép y hệt dòng 2/3/2016 Phan Thiết; bỏ ~10% `transactions`, `oil`; sửa `shipments` (chuyến đuôi 7), `warehouse_daily_ops` (× 1,15), `staffing_plan` (`headcount_thuc_te` − 1); bỏ mọi kỳ tồn kho của mã đuôi 7 và kỳ 2017-07 của một cặp có bán (cửa hàng 51, mã 903285); `on_time` = 0 cho đơn `ORD2_00422150` giao đúng cam kết. Chạy solution trên `scm` và `scm_hidden_1` (user `sql_runner`): k1 4 dòng thay vì 3, k2 14 thay vì 13, k3 3 thay vì 2, k5 7 thay vì 6, p5 1.506 thay vì 1.674; k4, k7, p6, c9 (b1–b4), c10 (b1–b4) khác giá trị. Chép kết quả Chạy thử nay rớt ở hidden-1. Đã sửa ghi chú thiết kế của k2 theo.

## Chờ giảng viên

- `scm-p2`: dùng tỷ lệ huỷ của kho vệ tinh để quyết định gì (đã đổi thành "có rà soát quy trình giao của kho vệ tinh hay không" theo B), cần người nắm domain xác nhận.
- `scm-p8`: điều kiện "kho Huế hoặc có khách tự áp voucher" là danh sách rà soát tự đặt; cần người nắm domain xác nhận có hợp lý không.
- `scm-c10`: lượng bán đồ dùng học tập đạt đỉnh tháng 4 khó giải thích bằng "mùa tựu trường" ở Việt Nam (mẫu hình của dữ liệu gốc); phương án đúng chỉ nói "lượng bán tăng theo mùa", không gắn tháng.
- Cấp: k3, p7 (Sửa lỗi, chỉ sửa một biểu thức trên 1 bảng) có thể hạ Dễ; k6 Khó hơi nhẹ; k2 Trung bình hơi cao. k1 Dễ, p1 Cơ bản, p2 Dễ nằm ngoài khung Trung bình/Khó của M9, M10 (theo thang optimize của CHOT).

## Quyết định v3 (10/11)

Theo `BRIEF-QUYET-DINH-126.md` và `QUYET-DINH-CHUNG.md`. Mục "Chờ giảng viên" ở trên đã xử lý hết.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `scm-p2-don-kho-ve-tinh-theo-nam` | Dùng tỷ lệ huỷ kho vệ tinh để quyết định gì | Giữ v2 ("có rà soát quy trình giao của kho vệ tinh hay không") | Sách dự án dòng 2009 gắn tỷ lệ huỷ với khâu thanh toán và giao | Không sửa |
| `scm-p8-voucher-dem-hai-lan` | Danh sách rà soát "kho Huế hoặc khách tự nhập voucher" | Giữ v2 | Câu dạy `UNION` khử trùng; điều kiện là danh sách rà soát do người hỏi đặt, đề nêu rõ | Đổi "tự áp voucher" thành "tự nhập voucher" (QUYET-DINH-CHUNG 1.7) |
| `scm-c10-do-dung-hoc-tap-thieu-hut` | Đỉnh tháng 4 không khớp mùa tựu trường Việt Nam | Giữ v2: phương án đúng chỉ nói "tăng theo mùa", không gắn tháng | Lượng bán lấy từ dữ liệu bán lẻ gốc (Corporación Favorita, Ecuador), mùa vụ không theo lịch Việt Nam | Không sửa |
| `scm-k3-co-dung-han-mau-thuan` | Cấp | **Hạ Dễ** | QUYET-DINH-CHUNG 2.3 mục 1 | `cap=easy`; ERD 2 bảng, chữ trên đường nối (bỏ `delivery_points`); ghi chú thiết kế; bản đồ |
| `scm-p7-ty-le-dung-han-sau-khi-gop` | Cấp | **Hạ Dễ** | QUYET-DINH-CHUNG 2.3 mục 1 | `cap=easy`; ERD 2 bảng, chữ trên đường nối (bỏ `delivery_points`); ghi chú thiết kế; bản đồ |
| `scm-k6`, `scm-k2`, `scm-k1`, `scm-p1`, `scm-p2` | Cấp | Giữ | QUYET-DINH-CHUNG 2.3 mục 1 (p1, p2 là mẫu optimize Cơ bản, Dễ của CHOT mục 4) | Không sửa |
| Chữ "tự áp mã" | khái niệm `voucher`, p8 | "tự nhập voucher" | QUYET-DINH-CHUNG 1.7 | Khái niệm `voucher`, đề và gợi ý p8 |

- Kết luận case (QUYET-DINH-CHUNG 1.1, sửa theo quy_chuan 23:05, gói mẫu c1–c4): phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Đã đổi ở mọi case của gói.
- Kiểm lại 10/11 (sau mọi sửa v3): bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/kiem-cuoi/scm-goi-<k>/`) → **KIEM TRA: 0 loi**; phân tích tĩnh bản cuối → 0 lỗi; biên dịch `cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu (chỉ cảnh báo Overfull hbox).

## v4 – đủ 4 cấp mỗi module (11/11)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu chia **2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó** như lộ trình chuẩn (`quy_chuan/lo-trinh-sql/assets/js/data.js`, Module 9 có `k1-dong-trung` Cơ bản, Module 10 có `o1` Cơ bản, `o2`/`p3-dung-chi-muc` Dễ). Case giữ nguyên cấp.

| Module | Trước (CB · Dễ · TB · Khó) | Sau | Hình thức (không đổi) |
|---|---|---|---|
| M9 Data Quality | 0 · 2 · 4 · 3 | 2 · 3 · 2 · 2 | 6 write + 3 debug |
| M10 Query Performance | 1 · 2 · 3 · 3 | 2 · 3 · 2 · 2 | 6 optimize + 2 debug + 1 write |

Số câu tối thiểu phải đổi: M9 thừa 2 TB, 1 Khó → 3 câu; M10 thừa 1 TB, 1 Khó → 2 câu. Chọn câu dễ hạ nhất: k2 (đã gần Cơ bản, chỉ bỏ cột đếm mô tả); k6 (lời giải chỉ dùng 2 bảng, giữ được chủ đề cũ); k4, p4, p5 viết lại theo đúng mẫu của cấp mới. Giữ k5, k7 (TB), k8, k9 (Khó: lời giải 3–4 bảng, khó hạ mà không viết lại hết); giữ p3 (mẫu TB `AVG() OVER` của CHOT), p8 (debug TB), p6 (Khó có thêm bẫy lọc trước cửa sổ), p9 (write Khó duy nhất của M10). Bản Cơ bản của k4 không dùng ngưỡng cố định "dưới N lượt" vì các dòng đó giống hệt nhau ở public và hidden-1; miền giá trị (số dòng, trung bình) thì khác.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `scm-k2-ngay-le-ghi-hai-dong` (giữ mã, cùng chủ đề) | Trung bình → **Cơ bản** | Bỏ cột `so_mo_ta` (`COUNT(DISTINCT)`), ERD 3 bảng → 1 bảng có giá trị mẫu, đề ghi sẵn hai cột của khoá; gợi ý nấc 2 là `HAVING COUNT(*) > 1`. Wrong mới `loc_theo_so_mo_ta` (bỏ sót dòng chép y hệt, rớt hidden-1), giữ `khoa_chi_co_ngay`; bỏ wrong gom thêm `type`. | 1 bảng · một lần gom có lọc nhóm (như `k1-dong-trung` Cơ bản của lộ trình) · rõ khoá, rõ cột · 0 bẫy · 1 khái niệm: **5/5 Cơ bản** |
| `scm-k4-giao-dich-thap-bat-thuong` → `scm-k4-mien-gia-tri-giao-dich-2016` | Trung bình → **Cơ bản** | Viết lại: miền giá trị lượt giao dịch năm 2016 (số dòng, nhỏ nhất, lớn nhất, trung bình) trước khi dò ngoại lai; bỏ hàm cửa sổ, bỏ mức thường thấy theo cửa hàng. ERD 1 bảng có giá trị mẫu. Wrong thiếu cận trên; wrong đếm ngày thay dòng. Public 18.999 dòng, hidden-1 17.097. | 1 bảng · 1 tầng (bốn hàm gộp) · rõ cột, rõ năm · 0 bẫy (cận trên tính bình thường) · 1 khái niệm (ngoại lai): **5/5 Cơ bản** |
| `scm-k6-doi-soat-don-can-xu-ly` → `scm-k6-don-can-xu-ly-kho-hue` | Khó → **Dễ** | Thu hẹp còn kho Huế, tháng 7/2017, mỗi ngày một dòng: đơn cần xử lý, số đơn mọi đơn, số đơn không huỷ. Bỏ đếm ngày lệch, `LEFT JOIN`/`COALESCE`, 4 bảng nhiễu và `\erdkhoa`; ERD 2 bảng, chữ trên đường nối nêu đủ hai cặp cột nối. Người hỏi đổi thành Anh Bảo · Trưởng kho Huế. Wrong `ELSE 0` trong `COUNT`; wrong nối theo kho xuất (ra rỗng). | 2 bảng có nối · nối rồi gom · đề ghi rõ cột, kho, kỳ · 1 bẫy (đếm có điều kiện) · 1 khái niệm chính: **5/5 Dễ** |
| `scm-p4-ty-trong-von-ton-nganh` → `scm-p4-von-ton-hang-khong-ban` | Trung bình → **Cơ bản** | Viết lại theo mẫu o1 (CHOT mục 4): ba truy vấn con quét lại `inventory_snapshots` → một lần quét với `SUM(CASE …)`, `COUNT(CASE …)`; kỳ 2017-07, ba cột vốn tồn, vốn tồn của dòng `sold = 0`, số dòng `sold = 0`. ERD 1 bảng có giá trị mẫu. Đo: starter 3 lần quét / 464.497 dòng, solution 1 / 153.400. Wrong quên lọc kỳ; wrong cộng tồn cuối kỳ thay vốn tồn. | 1 bảng · 1 tầng · rõ cột, kỳ, điều kiện · 0 bẫy · 1 khái niệm (vốn tồn): **5/5 Cơ bản** |
| `scm-p5-luy-ke-giao-dich-thang-7` → `scm-p5-giao-dich-theo-loai-cua-hang` | Khó → **Dễ** | Viết lại theo mẫu o2 (CHOT mục 4): năm nhánh `UNION ALL` (mỗi loại cửa hàng A–E một nhánh) → một `GROUP BY type`; năm 2016, cột số cửa hàng có giao dịch, lượt giao dịch trung bình của một cửa hàng trong một ngày. ERD 2 bảng, chữ trên đường nối. `quettoida={transactions=1, stores=1}`; đo: starter 5 + 5 lần quét, solution 1 + 1. Dạng A3 (khác p2 B1). Wrong `COUNT(*)` thay `COUNT(DISTINCT)`; wrong thiếu cận trên. | 2 bảng có nối · nối rồi gom · rõ cột, năm · 1 bẫy (đếm cửa hàng khác nhau) · 1 công thức một phép chia: **5/5 Dễ** |

- Sau v4, Khó optimize còn `p6` (tự nối cửa sổ trượt, có bẫy lọc trước cửa sổ, `ngansach=2`), Khó M10 còn `p9` (write); Khó M9 còn `k8` (debug), `k9` (write).
- Ô dạng × mảng × cấp × hình thức của 5 câu mới (E1·marketing·basic·write, E1·customer·basic·write, E2·operations·easy·write, A2·finance·basic·optimize, A3·customer·easy·optimize) không trùng câu nào của 5 gói scm (đối chiếu `\begin{cauhoi}` của cả 5 gói lúc 11/11).
- **Nghi trùng ô (không do v4):** `scm-p7-ty-le-dung-han-sau-khi-gop` (gói 5) và `scm-n8-dung-han-thai-binh-tron` (gói 1) cùng ô A2 · operations · easy · debug (khác gói, giống loại ô trùng giữa gói đã ghi ở bản đồ). `scm-k8` và `scm-k9` vẫn cùng điểm lạ (`sold` không trừ hàng trả), khác hình thức và mảng.
- Cập nhật cùng lúc: `cau-hoi.tex`, `solution.sql`, `BANG-PHAN-CONG.md`, dòng gói 5 và hai dòng M9, M10 cùng dòng "Gói 5" ở thống kê của `../../BAN-DO-100-CAU.md` (các dòng tổng và bảng dạng × mảng của cả bộ chưa sinh lại, vì gói khác đang sửa song song).
- Kiểm: bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/cap-do/scm-goi-5/`) → **KIEM TRA: 0 loi**, 0 cảnh báo; mọi wrong mới rớt ≥ 1 biến thể; 5 câu mới có kết quả public khác hidden-1; solution chạy ≤ 1,3 giây. Biên dịch `cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu (chỉ cảnh báo Overfull hbox). Thư mục gói vẫn đúng 4 file.

## Sửa theo KIEM-V4 (11/11/2026)

Đầu vào: `../KIEM-V4-B.md`, `../KIEM-V4-C.md`. Quy tắc trùng ô theo đính chính 11/11: cấm trùng trong cùng gói; khác gói được phép, trừ khi trùng cả chủ đề. Không đổi cấp câu nào; không sửa database, biến thể ẩn.

**Cách chữa câu chậm.** Không dùng `IGNORE INDEX` hay gợi ý chỉ mục như B đề xuất: học viên viết tự nhiên sẽ không có gợi ý nên vẫn chậm. Thay vào đó thu phạm vi dữ liệu để MySQL tự chọn kế hoạch nhanh: lọc một cửa hàng (dùng khoá chính `inventory_snapshots` hoặc chỉ mục cửa hàng của `sales`), hoặc thu kỳ đủ ngắn để dùng chỉ mục ngày (`sales` ≤ 3 ngày, `orders` ≤ 1 quý; với kỳ dài hơn, MySQL ước lượng sai và quét theo chỉ mục cột gom). Đo bằng `docker exec … mysql` (gồm cả khởi động client), 3 lần mỗi biến thể, lúc 2 bộ kiểm khác đang chạy song song; "tự nhiên" là bài viết lại không nhìn solution (`BETWEEN`, `USING`, `AVG() OVER`…), kết quả khớp solution.

Khái niệm dùng chung đồng bộ ở cả 5 gói (và `style/STYLE-scm.md`): `ngay-cao-diem` → "Ngày cao điểm, ngày nền và ngày thường" (định nghĩa cả ba loại ngày, "mỗi dòng là một ngày sự kiện"); `lead-time-don` → bản bốn thành phần, ô dữ liệu gộp ghi chú của gói 3 (kho xuất, kho đích) và gói 5 (giờ có phần lẻ, mốc thời gian).

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm, thời gian đo |
|---|---|---|---|
| `scm-p7-ty-le-dung-han-sau-khi-gop` → `scm-p7-don-moi-diem-giao-sau-khi-gop` | C: trùng ô A2 · operations · Dễ · Sửa lỗi **và trùng chủ đề** tỷ lệ giao đúng hạn với `scm-n8` (gói 1), lặp lỗi đơn huỷ trong mẫu số và hai wrong của `scm-a2`; vai "Data engineer" chỉ dành cho câu Tối ưu | Viết lại theo đề xuất của C, đổi mã: ô **A2 · customer · Dễ · Sửa lỗi** (cả bộ chưa có câu nào). Giữ Module 10, hình thức Sửa lỗi, cấp Dễ, khung "gộp ba báo cáo theo miền làm một". Đơn đặt tháng 7/2017 theo `region`: `so_don`, `so_diem_giao`, `don_moi_diem`. Starter đếm `COUNT(dest_point_id)` (không chú thích lộ lỗi) nên số điểm giao bằng số đơn, bình quân ra 1,00; solution `COUNT(DISTINCT dest_point_id)`. Wrong: chỉ sửa cột số điểm giao (bình quân vẫn 1,00); đếm cả danh mục 49 điểm giao. Vai "Bạn Linh · Thực tập sinh" (STYLE-scm B.2: Sửa lỗi cấp thấp). ERD 2 bảng, chữ trên đường nối, `delivery_points` là bảng nhiễu. Đồng bộ mã ở `solution.sql`, `BANG-PHAN-CONG.md`, `BAN-DO-100-CAU.md` (dòng câu, mục lệch khung, mục ô trùng) | Starter ≠ solution ở cả hai biến thể; 2 wrong rớt public; public ≠ hidden-1 (BAC 1585,91 / 1427,27). Solution 0,6–0,8 giây. bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-5/`) → KIEM TRA: 0 loi, 0 cảnh báo |
| `scm-p8-voucher-dem-hai-lan` | B: (1) tiêu đề nêu luôn chẩn đoán "bị đếm hai lần"; (2) `delivery_points` là bảng nhiễu không có đường nối | (1) "Số đơn kho Huế tăng sau khi sửa báo cáo". (2) Thêm `dest_point_id:FK` vào `orders` và `\erdnoi[kieu=n-1]{orders.dest_point_id}{delivery_points.point_id}`. Không bỏ bảng: ERD Trung bình cần 3 bảng (CHOT mục 3) mà lời giải chỉ dùng `orders`, nên giữ hai bảng nhiễu (ghi ở ghi chú). Giữ mã | Chỉ sửa chữ, ERD; bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-5/`) → KIEM TRA: 0 loi, 0 cảnh báo |
| Khái niệm `ngay-cao-diem`, `lead-time-don` | C (s9; `lead-time-don` của gói 5 ngắn hơn bốn gói kia) | Đồng bộ bản dùng chung; ô dữ liệu của `lead-time-don` giữ ghi chú giờ có phần lẻ, mốc thời gian của gói 5 | Phân tích tĩnh 0 lỗi |

- Kiểm cả gói sau sửa: bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/sua-v4/scm-goi-5/`) → KIEM TRA: 0 loi, 0 cảnh báo; phân tích tĩnh (`scm-goi-5-tinh`) 0 lỗi; biên dịch `cong-cu/bien_dich.sh` (`cong-cu/ket-qua/sua-v4/scm-goi-5/bien-dich/`) → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo aio-sql-cauhoi. Thư mục gói vẫn đúng 4 file. Module vẫn 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó; 0 ô trùng trong cùng gói.
