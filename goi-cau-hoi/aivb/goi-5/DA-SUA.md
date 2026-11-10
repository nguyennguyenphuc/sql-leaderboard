# Đã sửa · gói 5 AIV Bank (aivb) · v2 theo REVIEW-B, REVIEW-C

Kiểm lại: câu sửa SQL chạy bộ kiểm trên gói tạm `cong-cu/ket-qua/sua/aivb-goi-5/` (10 câu); cả gói chạy `--chi-phan-tich` (0 lỗi); biên dịch `cong-cu/ket-qua/bien-dich/aivb-goi-5/` (0 lỗi LaTeX). Không sửa database hay biến thể ẩn.

| Mã | Đã sửa (theo điểm của B/C) | Kiểm lại |
|---|---|---|
| aivb-k1-ten-phap-ly-dung-chung | B: bỏ cột hằng `so_loai_chu_the` (luôn 1), thay `so_khach_hang` (LEFT JOIN `core_customer`, 2 bảng); wrong mới: INNER JOIN mất chủ thể chưa là khách hàng, `COUNT(*)`. Lời nhắn, yêu cầu ("tên pháp lý"), `\luuy` theo câu B đề xuất, bỏ ví dụ sai dữ liệu. | bộ kiểm gói tạm |
| aivb-k2-phan-bo-thu-no-khong-co-lenh | C: "lệnh chuyển tiền" → "lệnh thanh toán"; bỏ "của nó" và ngoặc kép rào; tiêu đề hỏi số đếm theo năm; lời nhắn nói kho báo cáo chỉ giữ lệnh năm hiện hành (cửa sổ dữ liệu thành thực tế vận hành); khái niệm `doi-soat-du-lieu` bỏ vế lộ kết luận, "nguyên nhân của nó" → "nguyên nhân chênh lệch". | phân tích tĩnh (chỉ sửa chữ) |
| aivb-k3-doi-soat-lai-du-thu-tien-gui | B: ghi rõ cách làm tròn (cộng lãi chưa làm tròn rồi làm tròn tổng) để không chấm oan; bỏ cột `so_hop_dong_lech` (0 public / 100\% hidden-1), thay `so_hd_khong_co_lai` (tiền gửi ACTIVE không có dòng lãi tháng 12); yêu cầu nói công thức bằng lời; tiêu đề, cụm "quá 1\%" lặp; tab Nghiệp vụ khớp đầu ra; ghichuthietke "3 bảng không cần". | bộ kiểm gói tạm |
| aivb-k4-tinh-thieu-nghe-nghiep | C: tiêu đề, "mặt bằng chung" → "mức chung", `\luuy` bỏ khuôn "mệnh đề: kết luận", ghi rõ `'KHAC'` tính như một nhóm. | phân tích tĩnh |
| aivb-k5-trang-thai-khoan-vay-mau-thuan | B: 6 phép kiểm (4 luôn 0, 2 không phải mâu thuẫn thật) thay bằng bảng đối chiếu theo `loan_status`: số khoản, số có kỳ quá hạn, số dư nợ bằng 0; wrong đếm kỳ, INNER JOIN mất trạng thái; bỏ "nó", lời nhắn "bộ phép kiểm", câu khẩu hiệu. | bộ kiểm gói tạm |
| aivb-k6-ho-so-ngoai-hieu-luc-chinh-sach | C: thống nhất "phiên bản chính sách" ở tiêu đề, lời nhắn, yêu cầu; tiêu đề hỏi số đếm. | phân tích tĩnh |
| aivb-k7-ngay-tu-choi-bat-thuong | B: thêm lỗi thứ hai vào starter (bình quân chia 365 ngày) cho đúng cấp Trung bình; wrong mới chỉ sửa một lỗi; `domain` → `after_sales`; tiêu đề, định nghĩa bình quân, lời nhắn, bỏ câu khẩu hiệu. | bộ kiểm gói tạm |
| aivb-k8-thoi-gian-xu-ly-kyc | C (chấm oan): ngưỡng đổi thành "từ 144 giờ trở lên" và ghi `so_gio_xu_ly` là giờ tròn của `TIMESTAMPDIFF`; vì mọi khoảng là N×24 giờ + 1 giây, tính theo giờ tròn hay theo giây đều ra cùng kết quả. Lỗi thứ hai của starter là `> 144`. Vai "Bạn Trâm · Thực tập sinh", "hàng chục nghìn giờ"; sửa `\luuy` sai dữ liệu. | bộ kiểm gói tạm |
| aivb-k9-ho-so-duyet-khong-co-khoan-vay | B: vai → Trưởng phòng khách hàng cá nhân (30/30 hồ sơ cá nhân); thống nhất "chưa có khoản vay"; bỏ "Truy vấn" trong lời nhắn; `\luuy` thành lưu ý nghiệp vụ. | phân tích tĩnh |
| aivb-p1-qr-thang-12-sargable | C: kế hoạch mong manh (range scan cả tháng chỉ rẻ hơn table scan ~6\%) → thu hẹp phạm vi xuống tuần cuối năm 25--31/12 (chi phí ước ~58\% table scan); ràng buộc viết lại "Không đọc toàn bộ bảng…"; lời nhắn đổi khuôn. Giữ mã. | bộ kiểm gói tạm |
| aivb-p2-so-but-toan-moi-tai-khoan | B: `\luuy` bỏ "chúng"; thêm `ngansach=2` (bắt bài gom cả bảng bút toán); lời nhắn đổi khuôn. | bộ kiểm gói tạm |
| aivb-p3-tien-gui-lon-nhat-moi-chi-nhanh | C: bỏ "với mỗi", lời nhắn, "khách gửi tiền" → "hợp đồng tiền gửi", câu ngân sách. | phân tích tĩnh |
| aivb-p4-mom-tu-noi | B: bỏ "với mỗi"; lời nhắn không nói "bảng". | phân tích tĩnh |
| aivb-p5-ho-so-chua-co-khoan-vay | C: tiêu đề nêu đúng điều dạy (chỉ đọc bảng hồ sơ một lần), `\luuy` không còn dạy NOT IN gặp NULL; thống nhất "chưa có khoản vay"; thay wrong `not_in_gap_null` gượng bằng "quên điều kiện duyệt". | bộ kiểm gói tạm |
| aivb-p6-lich-tra-no-mot-lan-quet | B: wrong `gom_theo_phien_ban` (chỉ rớt vì nhãn) thay bằng đếm không điều kiện; `\luuy` đúng dữ liệu; bỏ "với mỗi"; lời nhắn đổi khuôn. | bộ kiểm gói tạm |
| aivb-p7-but-toan-tuan-cuoi-nam | C: `cap=easy`, ERD 2 bảng có chữ trên đường nối; nói rõ cộng cả ghi Nợ lẫn ghi Có; chuyển ý "không bọc cột" sang `\goiy`. | phân tích tĩnh |
| aivb-p8-cohort-toi-uu-sai | B: tiêu đề "làm mất cohort 2018"; `\luuy` nêu cửa sổ dữ liệu (hồ sơ từ 12/2019, cohort 2026 chưa đủ năm). | phân tích tĩnh |
| aivb-p9-tong-hop-truoc-loc-sau | C: lời nhắn đúng độ lớn ("lớn hơn gần một nửa"); tiêu đề "cộng cả lãi tiền gửi"; "theo từng tháng của năm 2026"; vai → Kế toán giao dịch. | phân tích tĩnh |
| aivb-c9-ra-soat-no-xau-2026 | B: phương án đúng chỉ dựa trên b3, b4 (không ghép sản phẩm × miền, vốn trái số thật); ba phương án dài gần bằng nhau, phương án sai cũng có hai vế; `\luuy` nói hai lát cắt riêng. | phân tích tĩnh (SQL không đổi) |
| aivb-c10-doi-soat-dong-tien-2026 | C: b3 đổi thành dòng tiền ròng theo trạng thái lệnh (bút toán một phía của lệnh bị đảo +21,3 tỷ, bị từ chối −8,9 tỷ); kết luận viết lại "chưa dùng ngay được"; ba phương án cân độ dài, bỏ khuôn dấu hai chấm, bỏ "chúng"; tiêu đề không tu từ; lời nhắn "đủ tin cậy". | bộ kiểm gói tạm |

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Biến thể ẩn (G1 của B, C)** (trước ở mục Chờ giảng viên): không cần `aivb_hidden_2`; `mysql/aivb/04_bo_sung_bien_the_aivb.sql` thêm cụm khách hàng giả (d)–(k): chủ thể trùng tên pháp lý, hồ sơ APPROVED chưa có khoản vay, kỳ OVERDUE của khoản đang trả, khách thiếu nghề nghiệp ở Huế, sự kiện KYC mới, tiền gửi doanh nghiệp ở CN13, hai lệnh giải ngân COMPLETED không có bút toán. Chạy solution trên `aivb` và `aivb_hidden_1` (user `sql_runner`): k1, k4, k5, k6, k8 (189/188 dòng), k9 (31/30), p3 (13/12), p5, p6, p8, c9 (b1 94/93), c10 (b1 10/8) đều khác public; p6 truy vấn trả hằng số nay rớt ở hidden-1. Ghi chú thiết kế k1, k4, k8, p6 đã sửa theo.

## Chờ giảng viên

1. **k5:** diễn giải các ô của bảng đối chiếu: khoản đã cơ cấu lại không còn kỳ quá hạn, khoản đã xử lý rủi ro còn kỳ `'OVERDUE'` có phải mâu thuẫn không.
2. **c10:** bút toán của lệnh `'REVERSED'`, `'REJECTED'` có phải loại khỏi dòng tiền ròng dùng cho kế hoạch vốn không (kết luận v2 giả định là phải loại).
3. **k2:** câu dựa trên cửa sổ dữ liệu (lệnh chỉ có năm 2026); v2 trình bày là kho báo cáo chỉ giữ năm hiện hành. Cần xác nhận còn hợp lý với ngân hàng thật.
4. **k4:** giao chỉ tiêu bổ sung hồ sơ theo tỉnh cư trú hay theo chi nhánh quản lý.
5. **k6:** cấp `hard` (kỹ năng chính ở mức Trung bình, độ khó chủ yếu từ ERD nhiễu) giữ nguyên, chờ xét.
6. **p9:** vai người hỏi (đã đổi sang Kế toán giao dịch).
