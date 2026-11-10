# Rà soát giọng văn cuối cho một bộ (100 câu, 5 gói)

Vai: biên tập viên giáo trình đại học Việt Nam đọc lần cuối trước khi phát hành. Hạn ~30 phút.

Đọc trước: style\STYLE-<bo>.md (A thuật ngữ, B giọng văn, C khuôn cấm), BRIEF-KIEM-GOI.md bước 6 (danh sách giọng AI / dịch máy).

Phạm vi: CHỈ câu chữ trong goi-cau-hoi\<bo>\goi-1..5\cau-hoi.tex (tiêu đề, bối cảnh, yêu cầu, ràng buộc, nghiệp vụ, khái niệm, gợi ý, lưu ý, phương án và lời giải thích, ghi chú thiết kế). KHÔNG đổi SQL, `ma`, khoá chấm (`thutu`, `saiso`, tên cột kết quả), số liệu, cấp, cấu trúc LaTeX. Không mở solution.sql để sửa.

Việc làm:
1. Chạy quét tự động trước: `python cong-cu/quet_giong.py --bo <bo>` (nếu có) hoặc grep các mẫu: "—", "Với mỗi", "Hãy ", "không chỉ", "chìa khoá", "bức tranh", "insight", "đáng chú ý", "một cách ", "được thực hiện bởi", "việc thực hiện", " nó ", "đếm ngược", "giúp anh", "giúp chị", "giúp em", "xem giúp em", "cả kỳ dữ liệu", "theo tab Nghiệp vụ", "Sửa để ra đúng", "không phải", "truy vấn" trong \boicanh. Ghi số lần trước/sau.
2. Đọc lần lượt 100 câu theo thứ tự gói. Ưu tiên KHUÔN LẶP GIỮA CÁC GÓI (5 gói do 5 người soạn): cùng một câu mở/kết lời nhắn, cùng mở đầu yêu cầu, cùng cách viết tiêu đề; tách cho đa dạng, tự nhiên.
3. Thống nhất thuật ngữ trên cả bộ theo STYLE mục A: một khái niệm một cách gọi; viết tắt giải nghĩa ở lần đầu mỗi câu khi cần.
4. Lời nhắn \boicanh: lời nói công sở tự nhiên, xưng hô đúng vai, không văn viết cứng, không nhắc kỹ thuật SQL, không lộ cách giải.
5. Sau khi sửa, cho mỗi gói chạy bộ kiểm tĩnh `--chi-phan-tich` (lệnh trong cong-cu\README.md) → "KIEM TRA: 0 loi", và biên dịch lại cong-cu\bien_dich.sh (thư mục ra `<bo>-goi-<k>`) → 0 lỗi LaTeX.
6. Ghi goi-cau-hoi\<bo>\RA-SOAT-GIONG.md: số chỗ sửa theo loại (giọng AI / dịch máy / thuật ngữ / khuôn lặp), bảng số lần các mẫu quét trước/sau, 10 ví dụ trước → sau tiêu biểu, chỗ còn để lại kèm lý do.

Báo cáo cuối (≤ 120 từ): số chỗ đã sửa theo loại, kết quả kiểm tĩnh 5 gói, kết quả biên dịch, điểm còn lại.
