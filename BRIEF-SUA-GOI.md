# Hướng dẫn sửa gói sau kiểm B/C (vai A)

Bạn là người đã soạn gói này. Hai người kiểm đã ghi `REVIEW-B.md` và `REVIEW-C.md` trong thư mục gói. Hạn: ~25 phút.

1. Đọc cả hai file review. Sửa MỌI mục "Cần sửa" – nội dung trước (chấm oan, đề mơ hồ, lộ kết quả/lộ lời giải ở tab Nghiệp vụ hay bối cảnh, wrong trùng kết quả, sai cấp, ghi chú thiết kế sai), rồi giọng văn (giọng AI, dịch máy, lệch thuật ngữ, lời nhắn sai vai) theo câu sửa người kiểm đề xuất hoặc tốt hơn, đúng style\STYLE-<bo>.md. Phá các khuôn lặp mà review nêu.
2. Mục "CẦN NGƯỜI NẮM DOMAIN": không tự xác nhận đạt; sửa nếu chắc, còn không thì giữ nguyên và ghi vào DA-SUA.md mục "Chờ giảng viên".
3. Không đổi `ma` (trừ khi review chỉ ra lỗi định dạng mã), không làm hỏng câu đang đạt.
4. Kiểm lại – CHỈ trên các câu đã sửa SQL hoặc yêu cầu (MySQL đang rất tải; cả gói chạy ~25 phút): dựng gói tạm ở cong-cu\ket-qua\sua\<bo>-goi-<k>\ chứa phần khai báo đầu cau-hoi.tex + các câu đã sửa + khối SQL tương ứng, chạy bộ kiểm (lệnh trong cong-cu\README.md) → "KIEM TRA: 0 loi". Câu chỉ sửa chữ thì chạy bộ kiểm với `--chi-phan-tich` trên cả gói (kiểm tĩnh). Biên dịch lại gói bằng cong-cu\bien_dich.sh → 0 lỗi LaTeX (thư mục ra đặt tên `<bo>-goi-<k>`).
5. Ghi `DA-SUA.md` trong thư mục gói: mỗi câu một dòng – mã | đã sửa gì (theo từng điểm của B/C) | kiểm lại (bộ kiểm/phân tích tĩnh) ; mục "Chờ giảng viên". Cập nhật BANG-PHAN-CONG.md: phiên bản v2, cột kiểm SQL / kiểm nội dung = kết quả sau sửa.

Báo cáo cuối (≤ 120 từ): số câu đã sửa, dòng cuối bộ kiểm (gói tạm) và phân tích tĩnh, kết quả biên dịch, điểm chờ giảng viên.
