# Quy chuẩn soạn câu hỏi SQL

Bộ tài liệu cho team nội dung. Các file được chép từ project hiện có; tài liệu gốc và gói mẫu giữ nguyên nội dung.

## Đọc theo thứ tự

1. [CHOT-FORMAT-CAU-HOI.md](CHOT-FORMAT-CAU-HOI.md): quyết định về 4 hình thức, cấp độ, điểm, chuẩn gói và cách kiểm.
2. [Huong-dan-cho-team-noi-dung.md](Huong-dan-cho-team-noi-dung.md): cách thiết kế đề, bối cảnh, yêu cầu, ERD, nghiệp vụ, độ khó và bẫy.
3. [goi-cau-hoi-mau/HUONG_DAN.md](goi-cau-hoi-mau/HUONG_DAN.md): cú pháp LaTeX, khối SQL và cách đóng gói.
4. Mở `goi-cau-hoi-mau/cau-hoi.tex` và `solution.sql` để tham khảo 16 câu mẫu.

`goi-cau-hoi-mau/` có đủ 4 file, gồm cả `aio-sql-cauhoi.sty`. Khi dùng Overleaf, zip riêng 4 file này thành một gói phẳng, tải lên và chọn compiler **XeLaTeX**. Không tải toàn bộ folder `quy_chuan` như một gói câu hỏi.

`hinh/` chứa hình minh hoạ được tài liệu nội dung tham chiếu.

## Phân công hiện hành của team 3 người

- **A:** tạo cả lô, tự kiểm và sửa bản nguồn.
- **B:** nhận khoảng một nửa số câu, kiểm cả SQL và nội dung/nghiệp vụ.
- **C:** nhận nửa còn lại, thực hiện cùng các việc như B.
- Mỗi câu ghi rõ người nhận kiểm, phiên bản, kết quả kiểm SQL và kết quả kiểm nội dung. Người nhận kiểm lại bản sửa của câu mình phụ trách.
- Điểm chưa đủ hiểu biết nghiệp vụ cần hỏi người nắm domain, không tự xác nhận đạt. Câu chưa đủ căn cứ được giữ lại.

Đây là cách chia việc mới, thay cho cách hiểu B chỉ kiểm SQL còn C chỉ kiểm nghiệp vụ. Mục 10 trong tài liệu hướng dẫn gốc chưa đồng bộ toàn bộ với cách chia mới; áp dụng phân công ở file này.

Trang hướng dẫn theo từng bước và 4 format minh hoạ: https://quy-trinh-sql.vercel.app

## Nếu soạn bài thuộc lộ trình

Đọc thêm [CHOT-LO-TRINH.md](CHOT-LO-TRINH.md). Danh sách module và bài dự kiến nằm ở `lo-trinh-sql/assets/js/data.js`; giữ mã bài khi soạn.

## Phạm vi gói tài liệu

Folder này là bộ tài liệu và mẫu soạn, không phải môi trường chấm. Dữ liệu gốc và công cụ MySQL/Python không nằm trong folder này; việc chạy kiểm cần môi trường của project.
