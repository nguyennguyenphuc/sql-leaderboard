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
