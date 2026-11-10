# DA-SUA · gói 4 AIV Bank (aivb) · v2 (10/11/2026)

Sửa theo REVIEW-B.md, REVIEW-C.md. Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại: câu sửa SQL (t6, f4) chạy bộ kiểm trên gói tạm `cong-cu/ket-qua/sua/aivb-goi-4/` → **KIEM TRA: 0 loi**; cả gói `--chi-phan-tich` → **0 loi**; biên dịch `cong-cu/ket-qua/bien-dich/aivb-goi-4/` → 0 lỗi LaTeX, 0 ký tự thiếu.

| Mã | Đã sửa (theo B/C) | Kiểm lại |
|---|---|---|
| aivb-t1-pheu-ho-so-vay-2025 | Tiêu đề "dừng lại ở khâu nào"; bối cảnh bỏ "rơi"; \luuy thay bằng lưu ý khoản vay chưa hết thời hạn nên chưa tất toán (không giảng tỷ lệ); ERD hồ sơ → khoản vay `1-1`; khái niệm `pheu-chuyen-doi` bỏ "rơi". | tĩnh |
| aivb-t2-doi-soat-lenh-but-toan | Tách hai `\item` "Ghi `loai` = … cho …"; loại 2 định nghĩa lại: bút toán gốc vẫn còn, chưa có bút toán ngược chiều; khái niệm `giao-dich-bi-dao` thêm "bảng bút toán chỉ giữ bút toán gốc"; \goiy bỏ "nó"; dòng mở Nghiệp vụ thành quyết định. | tĩnh (SQL không đổi) |
| aivb-t3-phan-nhom-khach-giao-dich | Nghiệp vụ "Ước lượng số khách…"; \luuy bỏ kỹ thuật SQL, phủ định kép; bỏ `\khainiem{ghi-no-ghi-co}`. | tĩnh |
| aivb-t4-du-no-theo-nhom-no | "ba cột số bằng 0"; bối cảnh "kể cả nhóm chưa có khoản vay nào"; bỏ bảng nhiễu `core_loan_payment_allocation` (còn 2 bảng nhiễu); \luuy bỏ câu nói sẵn bẫy kỳ muộn nhất; sửa ghi chú hidden-1 (chỉ dư nợ nhóm 1 đổi). | tĩnh |
| aivb-t5-kenh-loai-giao-dich-ty-le-hoan | Hạ `cap=medium`, ERD Trung bình (3 bảng có ký hiệu); tiêu đề "có tỷ lệ bị đảo cao nhất"; \luuy không nói sẵn cách tính dòng tổng; ghi chú. Mã giữ nguyên (đổi mã → phiên bản mới, chờ quyết định). | tĩnh |
| aivb-t6-lai-du-thu-tien-gui-va-vay | **Đổi chỉ số:** bỏ `ty_trong_pct` (cộng chi với thu), trả 3 dòng lãi dự thu cho vay, lãi dự trả tiền gửi, chênh lệch thu − trả; tiêu đề "Lãi dự thu và lãi dự trả năm 2026"; Nghiệp vụ "lãi dự thu của các khoản vay"; \luuy lãi dự trả là chi phí, chênh lệch chưa phải lợi nhuận; wrong mới `chenh_lech_nguoc_chieu` (public), giữ `thieu_can_tren_nam` (hidden-1), bỏ wrong giả tạo. | bộ kiểm gói tạm: 0 lỗi |
| aivb-t7-khach-co-san-pham | Thống nhất "chủ thể" (tiêu đề, yêu cầu, Nghiệp vụ); câu yêu cầu bỏ lặp chữ. | tĩnh |
| aivb-t8-giai-ngan-so-voi-nam-truoc | Bối cảnh: "mất luôn năm gần nhất" (starter mất 2026), "toàn hàng", "giao chỉ tiêu cho các chi nhánh"; \luuy bằng lời nghiệp vụ, không nói cách nối; sửa ghi chú. | tĩnh |
| aivb-t9-qua-han-nhung-khong-delinquent | Hạ `cap=medium`, ERD 3 bảng có ký hiệu; tiêu đề "bị đếm gấp nhiều lần"; yêu cầu viết lại trật tự tiếng Việt; Nghiệp vụ "báo cáo chất lượng danh mục"; \luuy không nói "sau phép nối". | tĩnh |
| aivb-f1-top-3-khoan-vay-moi-chi-nhanh | "khoản vay đang trả bình thường (`loan_status = 'ACTIVE'`)" ở bối cảnh và yêu cầu; Nghiệp vụ "vài khoản vay lớn". | tĩnh |
| aivb-f2-mom-gia-tri-theo-kenh | \luuy "Mỗi kênh chỉ so với chính kênh đó…"; yêu cầu ghi tính từ số tiền chưa làm tròn. | tĩnh |
| aivb-f3-luy-ke-giai-ngan | Tiêu đề "Giải ngân cho vay vốn lưu động luỹ kế năm 2026"; bối cảnh bỏ "sản phẩm … giải ngân"; \luuy bằng lời nghiệp vụ. | tĩnh |
| aivb-f4-chuoi-ky-qua-han | **Đổi đối tượng:** mỗi khoản vay chỉ có một chuỗi kỳ quá hạn nên không chấm được tách chuỗi; v2 tìm chuỗi tháng liên tiếp dài nhất có kỳ quá hạn của từng chi nhánh (7/12 chi nhánh có ≥ 2 chuỗi). Giữ D3, Khó, `ma`. Bỏ "trễ hạn"; wrong mới `khong_tach_chuoi` (GROUP BY thẳng) và `quen_distinct_thang`, cả hai rớt ở public. | bộ kiểm gói tạm: 0 lỗi |
| aivb-f5-cohort-khach-vay | Tiêu đề "Khách mới bao lâu thì nộp hồ sơ vay đầu tiên?"; giải nghĩa cohort trong yêu cầu; "tính cả hồ sơ bị từ chối"; \luuy thêm cửa sổ hồ sơ từ 12/2019. | tĩnh |
| aivb-f6-pareto-so-du-casa | Tiêu đề "80\% tiền gửi không kỳ hạn"; thống nhất "khách"; ghi "theo ngày chốt riêng của từng tài khoản"; \luuy nói rõ là quy ước của câu. | tĩnh |
| aivb-f7-ho-so-moi-nhat | Dòng mở Nghiệp vụ thành quyết định. Giữ `cap=medium` (M8 chỉ gồm Trung bình/Khó theo phân bổ). | tĩnh |
| aivb-f8-top-5-khoan-vay-dung-5-dong | Hạ `cap=medium`, ERD 3 bảng có ký hiệu; bối cảnh bỏ "truy vấn"; "dư nợ bằng nhau"; "N khoản lớn nhất". | tĩnh |
| aivb-f9-so-du-chay-tai-khoan | Tiêu đề "ra cùng một số trong một ngày"; bối cảnh bỏ khuôn "mệnh đề: kết luận"; \luuy không nói sẵn lỗi cận trên. | tĩnh |
| aivb-c7-kenh-so-va-quay | Tiêu đề "Kênh số có đang thay thế kênh vật lý?", bối cảnh và Nghiệp vụ nói rõ quầy, ATM, POS; \luuy không lộ kết luận; ba phương án dài gần bằng nhau, mỗi phương án một số liệu, bỏ từ rào; b3 ghi tính từ tỷ trọng chưa làm tròn. | tĩnh |
| aivb-c8-chat-luong-tin-dung-cohort | Bỏ "khoản vay xấu", bỏ "lứa" (dùng "năm giải ngân"); tiêu đề "Khoản vay giải ngân năm nào có chất lượng tín dụng kém nhất?"; \luuy không nói lập luận; cân độ dài ba phương án, bỏ cấu trúc rào. | tĩnh |

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Biến thể ẩn giống public** (t1, t7, t9, f3, f4, f5, f6, f7, f8, t8, c8; trước ở mục Chờ giảng viên): `mysql/aivb/04_bo_sung_bien_the_aivb.sql` thêm đúng các ý B/C đề xuất: hồ sơ 2025 giả, kỳ OVERDUE (khoản `SYN_LON_H000003` ở CN01), hai lần giải ngân WC\_LOAN 2026, số dư tài khoản giả, khoản `SYN_LON_0000000` (`loan_id` nhỏ hơn `SYN_LON_0000675`) cùng dư nợ hạng 5. Chạy solution trên `aivb` và `aivb_hidden_1` (user `sql_runner`): cả 11 câu (c8 cả 4 bước) nay khác public; f8 starter `RANK` ra 7 dòng ở hidden-1, wrong `DENSE_RANK` và hoà giảm dần rớt ở hidden-1. Ghi chú thiết kế t1, t4, t8, f4, f5, f6, f8 đã sửa theo.

## Chờ giảng viên

- **t9:** khoản vay đã cơ cấu lại hoặc đã xử lý rủi ro còn kỳ quá hạn có phải điểm cần rà không; khung nghiệp vụ hiện là báo cáo chất lượng danh mục.
- **f6:** quy ước số dư tài khoản chung tính hết cho chủ tài khoản (pháp lý: đồng chủ tài khoản cùng sở hữu).
- **t1:** bước 4 "đã tất toán" có nên giữ trong phễu không (đề xuất thay "chưa từng có kỳ quá hạn").
- **t2:** định nghĩa lệch loại 2 (lệnh bị đảo mà bút toán gốc chưa có bút toán ngược chiều) và câu bổ sung trong khái niệm `giao-dich-bi-dao`.
- **t6:** chỉ số chênh lệch lãi dự thu − lãi dự trả có đủ nghĩa không, hay dùng tỷ lệ lãi dự trả / lãi dự thu.
- **f5:** cohort 2018, 2019 bị cửa sổ dữ liệu cắt; có nên chỉ xét cohort từ 2020.
- **c7:** đo theo giá trị (bị lệnh lớn qua API chi phối) hay theo số lệnh; gộp ATM, POS vào kênh vật lý.
- **t5:** đổi mã sang `…-ty-le-bi-dao` (thành câu mới) hay giữ mã.
- **f7:** C đề xuất hạ Dễ; giữ Trung bình vì Module 8 chỉ có cấp Trung bình/Khó.

## Quyết định v3 (10/11)

Xử lý các điểm "Chờ giảng viên" theo BRIEF-QUYET-DINH-126 (bảng chung: `../QUYET-DINH-126-g45.md`). Nguồn: Parameter Book `Project DA\Finance\05_eDA_parameter_book_mini_core_banking_v5.1.5.xlsx` (PB), các văn bản pháp quy ghi URL. Không đổi SQL, không cần thêm dòng ẩn.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| aivb-t9 | Khoản cơ cấu lại, xử lý rủi ro còn kỳ quá hạn có phải điểm cần rà | Giữ khung báo cáo chất lượng danh mục | TT31/2024/TT-NHNN Điều 10 khoản 4 điểm d (nợ cơ cấu lại quá hạn theo lịch mới chuyển nhóm cao hơn; https://baolamdong.vn/can-cu-phan-loai-nhom-no-doi-voi-khoan-vay-da-co-cau-419186.html); NĐ 86/2024/NĐ-CP (xử lý rủi ro = hạch toán ngoại bảng, vẫn thu hồi; https://luatvietnam.vn/tai-chinh/nghi-dinh-86-2024-nd-cp-phuong-phap-trich-lap-du-phong-rui-ro-cua-to-chuc-tin-dung-359985-d1.html); PB mục 4 (WRITTEN_OFF khi nhóm 5 ≥ 6 tháng; POST.RECOV.1). DB: 17 khoản WRITTEN_OFF có kỳ quá hạn đều dư nợ 0 | `\luuy` thêm hai câu nghiệp vụ (cơ cấu lại còn quá hạn bị chuyển nhóm; xử lý rủi ro dư nợ 0 nhưng vẫn thu hồi); `\ghichuthietke` ghi căn cứ |
| aivb-f6 | Số dư tài khoản chung tính hết cho chủ tài khoản | Giữ quy ước v2 | PB mục 5: `PRIMARY_OWNER` / `JOINT_OWNER` (đồng sở hữu), "sở hữu số dư ≠ quyền ký"; TT17/2024/TT-NHNN: tài khoản thanh toán chung do từ hai chủ thể cùng đứng tên (https://thuvienphapluat.vn/van-ban/Tien-te-Ngan-hang/Circular-17-2024-TT-NHNN-on-opening-checking-accounts-at-payment-service-providers-616720.aspx). DB: mọi tài khoản đúng 1 `PRIMARY_OWNER`; 273 tài khoản chung giữ 9,8/395,7 tỷ (2,5%) | Không sửa (`\luuy` v2 đã nói rõ là quy ước của câu) |
| aivb-t1 | Có giữ bước "đã tất toán" | Giữ v2 | PB mục 4: vòng đời khoản vay kết thúc ở `SETTLED` (final_payment, outstanding = 0) | `\ghichuthietke` ghi căn cứ; tên người hỏi |
| aivb-t2 | Định nghĩa lệch loại 2 và câu bổ sung trong `giao-dich-bi-dao` | Duyệt, đưa vào STYLE-aivb mục E | PB mục 6B: `POST.REVERSAL.1` (MIRROR, ORIGINAL_POSTING_PRESENT), `POST.REJECT.1` (hoàn ORIGINAL_DEBIT_CASA): lệnh bị đảo, bị từ chối phải có bút toán ngược chiều; bảng bút toán của bộ chỉ giữ bút toán gốc | STYLE-aivb mục E `giao-dich-bi-dao` thêm câu; gói 5 chép cùng câu |
| aivb-t6 | Chênh lệch thu − trả hay tỷ lệ | Giữ chênh lệch (đơn vị tiền) | Chỉ tiêu "Thu nhập lãi thuần" = thu nhập lãi − chi phí lãi trên báo cáo kết quả kinh doanh của TCTD (mẫu B03/TCTD, TT49/2014/TT-NHNN) | `\ghichuthietke` ghi căn cứ |
| aivb-f5 | Cohort 2018, 2019 bị cửa sổ cắt | Giữ SQL và `\luuy` v2 | DB: hồ sơ vay sớm nhất 2019-12-15; cohort 2018 (1.228 khách), 2019 (1.248) vẫn là khách thật, bỏ đi làm sai mẫu số toàn bộ khách; `\luuy` v2 đã nêu | Không sửa |
| aivb-c7 | Đo theo giá trị hay số lệnh; ATM, POS là kênh vật lý | Giữ đo theo giá trị; giữ "kênh vật lý" = quầy, ATM, POS (chốt cùng aivb-n6) | DB: theo số lệnh, tỷ trọng kênh số 71,5–72,1% mỗi tháng, cũng không đi một chiều → phương án đúng không đổi; API chỉ 11–14% giá trị. Khái niệm `kenh-giao-dich` cho phép đo theo số tiền | `\ghichuthietke` ghi kiểm chéo |
| aivb-t5 | Đổi mã chữ "hoan" | Đổi mã → `aivb-t5-kenh-loai-giao-dich-ty-le-bi-dao` | STYLE-aivb A.5 (bị đảo); BAO-CAO 3.6; câu chưa nhập hệ thống | Đổi ở cau-hoi.tex, solution.sql (3 nhãn), BANG-PHAN-CONG.md, BAN-DO-100-CAU.md; `\ghichuthietke` |
| aivb-f7 | Hạ Dễ? | Hạ Dễ (sửa lúc 23:20 theo QUYET-DINH-CHUNG 0.1 mục 5, bỏ ngoại lệ "M8 không có Dễ") | quy_chuan HD mục 6: Sửa lỗi Dễ = lỗi logic một chỗ; `lo-trinh-sql` mọi module đủ 4 cấp. Starter chỉ sai chiều sắp trong `ROW_NUMBER` | `cap=easy`; ERD 2 bảng (`core_loan_application`, `core_party`) có chữ trên đường nối, bỏ `ref_product`; `ghichuthietke`; BAN-DO (dòng, thống kê, mục chênh lệch) |
| aivb-c7, aivb-c8 | Lời giải thích bước kết luận (QUYET-DINH-CHUNG 1.1, sửa theo quy_chuan) | Áp | Gói mẫu c1–c4 | "Đúng. " → "Đúng: " (chữ thường sau dấu hai chấm), bỏ "Chưa đúng. " ở phương án sai |
| (tên nhân vật) | Một tên nhiều vai (BAO-CAO 3.8) | Bảng vai – tên cố định (xem `../QUYET-DINH-126-g45.md`) | STYLE-aivb B (danh sách vai) | Gói 4: t1 Anh Hải, t2 Anh Quang, t3 Anh Bảo, t5 + f2 Chị Hạnh, t7 Bạn Vy, f3 Anh Tuấn, f8 Chị Lan, f9 Anh Khánh, c7 Anh Hưng; đổi đại từ theo tên |

Mã đã đổi: `aivb-t5-kenh-loai-giao-dich-ty-le-hoan` → `aivb-t5-kenh-loai-giao-dich-ty-le-bi-dao` (dòng bảng v2 phía trên dùng mã cũ).

## Chuẩn hoá theo quy_chuan (BRIEF-CHUAN-HOA, 11/11)

| Mục | Câu | Việc |
|---|---|---|
| 1 kết luận case | aivb-c8 | Hai lời giải thích 40 và 39 tiếng rút còn 32 và 33 tiếng (≤ 35); c7 đã đạt (23/24/23 tiếng). Cả hai case đúng 3 phương án, "Đúng: " ở phương án đúng, phương án sai không tiền tố |
| 2 gợi ý | aivb-t8 | Nấc cuối (câu hỏi) đổi thành biểu thức một dòng `LEFT JOIN nam truoc ON truoc.nam = nay.nam - 1` |
| 2 gợi ý | aivb-t7 | Thêm nấc 2: `UNION` thay cho `UNION ALL` (trước chỉ có một nấc dạng câu hỏi) |
| 3 tiêu đề | – | 20 tiêu đề đều ≤ 13 tiếng; gói không có câu Tối ưu. t2 đổi "năm 2026" → "quý 2/2026" theo việc thu phạm vi |
| 4 ERD Khó | aivb-t4 | 4 → 5 bảng (thêm bảng nhiễu `core_loan_disbursement`, lời giải dùng 2 bảng, như mẫu d4) |
| 4 ERD Khó | aivb-t8, aivb-f9 | Thêm `\erdkhoa` (trước chỉ có 5 bảng khoá, không có cách nối) |
| 4 ERD khác | aivb-f2 | Bảng nhiễu `core_account` chưa nối: thêm `account_id` vào `core_account_posting` và đường nối n-1 |
| 5 cấp | – | Chấm lại 20 câu, không câu nào lệch rõ; không đổi cấp |
| Thời gian | aivb-t2 | Cả năm 2026: 20,6 giây (kiem-cuoi), 47–53 giây khi MySQL bận. Thu về quý 2/2026 (01/04–30/06): khoảng 11 giây lúc MySQL bận (≈ 4 lần nhanh hơn cả năm cùng lúc). Public 2 / 1.360 / 3.260 lệnh, hidden-1 3 / 1.225 / 2.928 (lệnh giải ngân `SYN_PMO_H0000004` ngày 30/06 thành cận trên) |


## v4 – đủ 4 cấp mỗi module (BRIEF-CAP-DO-MODULE, 11/11)

Căn cứ: `quy_chuan/lo-trinh-sql/assets/js/data.js` (M7, M8 đều có bài Cơ bản, Dễ, Trung bình, Khó), CHOT-FORMAT mục 3 (ERD theo cấp), Huong-dan mục 5, 6, QUYET-DINH-CHUNG mục 0, 2. Mỗi câu đổi cấp viết lại đủ 8 phần, SQL mới (solution, wrong, starter), ERD theo cấp mới; `ma` giữ tiền tố và số, đổi slug.

**Phân bổ cấp trước → sau** (không tính case; mỗi module vẫn 6 write + 3 debug):

| Module | Trước (CB · Dễ · TB · Khó) | Sau |
|---|---|---|
| M7 CTE & Set Operations | 0 · 0 · 7 · 2 | 2 · 3 · 2 · 2 |
| M8 Window Functions | 0 · 1 · 4 · 4 | 2 · 3 · 2 · 2 |

Giữ nguyên: t1 (TB), t4 (Khó), t8 (Khó), t9 (TB), f4 (Khó), f5 (Khó, giữ vì là câu D2 cohort duy nhất của 90 câu module), f6 (TB), f7 (Dễ), f8 (TB), c7, c8.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `aivb-t2-doi-soat-lenh-but-toan` → `aivb-t2-cho-vay-moi-va-thu-goc-quy-4` | TB → Dễ | Viết lại: cho vay mới (`core_loan_contract`) và thu gốc (`core_loan_payment_allocation`) từng tháng quý 4/2026, hai CTE ghép bằng `UNION ALL`. Ô E2 · operations → B1 · finance (B1 · operations · Dễ · write đã có `aivb-p7`). Bản cũ chạy ~20 giây, bản mới < 0,1 giây | 2 (Dễ) · 2 tầng (Dễ) · định nghĩa trong đề (Dễ) · 1, cộng cả lãi, phí, phạt (Dễ) · 1 khái niệm dư nợ giảm theo gốc (Dễ) → Dễ 5/5 |
| `aivb-t3-phan-nhom-khach-giao-dich` → `aivb-t3-nguoi-vay-theo-so-khoan-vay` | TB → Dễ | Viết lại: số người vay theo số khoản vay còn dư nợ (nối khoản vay với hồ sơ vay, gom hai tầng). Bản cũ chạy ~19 giây, bản mới < 0,1 giây | 2 (Dễ) · 2 tầng (Dễ) · cột, cách gom ghi rõ (Dễ) · 1, tính cả khoản dư nợ 0 (Dễ) · 1 khái niệm dư nợ (Dễ) → Dễ 5/5 |
| `aivb-t5-kenh-loai-giao-dich-ty-le-bi-dao` → `aivb-t5-lenh-binh-quan-ngay-theo-kenh` | TB → CB | Viết lại theo bài mẫu `t1-viet-lai-cte`: một CTE đếm lệnh thành công theo kênh và ngày tháng 12/2026, truy vấn ngoài lấy bình quân. ERD 1 bảng có giá trị mẫu. Ô A4 → A2 · marketing | 1 (CB) · CTE + bình quân (CB) · cột, giá trị lọc ghi rõ (CB) · 0 (CB) · 1 khái niệm kênh (CB) → CB 5/5 |
| `aivb-t6-lai-du-thu-tien-gui-va-vay` → `aivb-t6-ky-han-tien-gui-tu-200-ty` | TB → CB | Viết lại: kỳ hạn có từ 200 tỷ đồng tiền gửi còn hiệu lực, CTE gom rồi lọc ở truy vấn ngoài. ERD 1 bảng có giá trị mẫu. Giữ ô A3 · finance, đổi cấp | 1 (CB) · CTE + lọc (CB) · mã trạng thái, ngưỡng ghi rõ (CB) · 0 (CB) · 1 khái niệm (CB) → CB 5/5 |
| `aivb-t7-khach-co-san-pham` → `aivb-t7-chu-the-can-ra-soat-dem-trung` | TB → Dễ | Viết lại trên 2 bảng (bản cũ 4 bảng): chủ thể có KYC không đạt hoặc hồ sơ vay bị từ chối; starter `UNION ALL` đếm trùng, sửa một chỗ thành `UNION` (như bài `t3-union-mat-dong` của lộ trình). ERD 2 bảng, đường nối tô cảnh báo. Ô A2 · customer → A2 · after_sales (KYC không đạt thuộc after\_sales theo STYLE-aivb G). Thêm khai báo khái niệm `kyc` (định nghĩa chép giống gói 1–3) | 2 (Dễ) · ghép rồi đếm (Dễ) · điều kiện ghi mã (Dễ) · 1, `UNION ALL` giữ dòng trùng (Dễ) · sửa lỗi một chỗ (Dễ) → Dễ 5/5 |
| `aivb-f1-top-3-khoan-vay-moi-chi-nhanh` → `aivb-f1-ty-trong-du-no-co-cau-lai` | TB → CB | Viết lại: tỷ trọng dư nợ của từng khoản vay đã cơ cấu lại, `SUM() OVER ()` trên 1 bảng. ERD 1 bảng có giá trị mẫu. Ô C1 · finance → C2 · after\_sales (chủ đề khoản vay lớn nhất còn ở f8) | 1 (CB) · 1 tầng (CB) · công thức ghi rõ (CB) · 0 (CB) · 1 khái niệm (CB) → CB 5/5 |
| `aivb-f2-mom-gia-tri-theo-kenh` → `aivb-f2-mom-gia-tri-ung-dung-di-dong` | TB → Dễ | Bỏ chia theo kênh (bỏ `PARTITION BY`), chỉ kênh ứng dụng di động; công thức thay đổi ghi ngay trong đề. ERD 2 bảng (1 bảng nhiễu), chữ trên đường nối. Giữ ô B2 · marketing | 1 (CB) · gom + `LAG` (Dễ) · công thức trong đề (Dễ) · 1, cận trên (Dễ) · 1 phép chia (Dễ) → Dễ 4/5 |
| `aivb-f3-luy-ke-giai-ngan` → `aivb-f3-lai-du-thu-luy-ke-mot-khoan-vay` | Khó → CB | Viết lại: lãi dự thu luỹ kế năm 2026 của một khoản vay (`SUM() OVER (ORDER BY accrual_date)` trên từng dòng, không gom). ERD 1 bảng có giá trị mẫu. Ô B3 · sales → B3 · finance | 1 (CB) · 1 tầng (CB) · hợp đồng, năm ghi rõ (CB) · 0, cận trên là bình thường (CB) · 1 khái niệm (CB) → CB 5/5 |
| `aivb-f9-so-du-chay-tai-khoan` → `aivb-f9-dong-tien-luy-ke-chi-tang` | Khó → Dễ | Hạ bằng cách bỏ hai trong ba lỗi chồng nhau: starter giữ khung `ROWS` có `posting_id` và đủ hai cận, chỉ còn lỗi không xét dấu ghi Nợ, ghi Có. ERD 2 bảng (1 bảng nhiễu) có giá trị mẫu `debit_credit`, `amount`. Người hỏi đổi sang Bạn Vy (Sửa lỗi cấp thấp). Giữ ô B3 · operations | 1 (CB) · đổi dấu trong hàm cửa sổ có sẵn (Dễ) · quy tắc dấu ghi rõ (Dễ) · 1, `amount` luôn dương (Dễ) · sửa lỗi một chỗ (Dễ) → Dễ 4/5 |

Wrong của 9 câu (mỗi câu ≥ 2, đều là lỗi hay gặp): t2 cộng cả lãi, phí, phạt; đếm khoản vay thay lần phân bổ · t3 không lọc dư nợ; chỉ tính `'ACTIVE'` · t5 chia 31 ngày lịch; đếm mọi trạng thái · t6 chỉ `'ACTIVE'`; ngưỡng thiếu ba chữ số 0 · t7 `DISTINCT` từng nhánh vẫn `UNION ALL`; hiểu "hoặc" thành "và" · f1 chia dư nợ toàn danh mục; `ORDER BY` trong `OVER` · f2 thiếu cận trên (hidden-1); `LAG` sắp giảm dần · f3 `OVER ()` tổng cả năm; thiếu cận trên (hidden-1) · f9 dấu ngược; bỏ khung `ROWS` và `posting_id`; thiếu cận trên (hidden-1). Kết quả public khác hidden-1 ở cả 9 câu (H(a), H(e), H(g), H(h), H(i)–H(k) của `04_bo_sung_bien_the_aivb.sql`; không thêm dòng ẩn).

Trùng ô: không có trong gói; 9 ô mới không trùng ô câu nào của gói 1–5 lúc kiểm (11/11). `BAN-DO-100-CAU.md`: 9 dòng, dòng M7, M8, gói 4, và chênh lệch gói 4 cộng vào thống kê chung (basic +4, easy +5, medium −7, hard −2; dạng × mảng: A2 +1, A4 −1, B1 +1, C1 −1, C2 +1, E2 −1); ghi t2, t3, t6 rời ô trùng giữa các gói.

**Kiểm (11/11):** bộ kiểm đầy đủ cả gói (`--ra cong-cu/ket-qua/cap-do/aivb-goi-4`) → **KIEM TRA: 0 loi** (20 câu); 1 cảnh báo `NGHIEPVU_LO_SO` ở f5 (câu không đổi: "2018, 2019" trong `\luuy` là năm cohort, không phải số kết quả). Mọi wrong rớt đúng biến thể ghi ở `\ghichuthietke`; f9 starter khác solution ở cả hai biến thể. Biên dịch `bash cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu. Thư mục gói đúng 4 file.

**Thời gian solution:** t2 0,08 giây, t3 0,02 giây (bản cũ 19–20 giây). Các câu mới khác dưới 0,1 giây, trừ hai câu quét `core_payment_order`: t5 (tháng 12) 2,8–3,5 giây, f2 (cả năm, quét toàn bảng như f2 cũ) 3,9–4,5 giây ở lượt kiểm cuối (các lượt trước, khi máy chạy song song bộ kiểm của nhiều gói, tới 6,5 và 9,1 giây); lúc máy rất bận một lượt đo tay lên 15–30 giây (c7 không đổi cũng lên 12–18 giây cùng lúc).
