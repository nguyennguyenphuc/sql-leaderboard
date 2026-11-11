# Hướng dẫn chung cho agent dựng một bộ dữ liệu (MySQL + bộ chuẩn + bản đồ)

Hạn chót cứng: ~45 phút. Ưu tiên theo thứ tự: (1) MySQL + biến thể ẩn + README (để 5 agent soạn gói bắt đầu được), (2) STYLE-<bo>.md, (3) BAN-DO-100-CAU.md.

Thư mục gốc: C:\Cong viec\ProjectDA\sql-leaderboard\ . Đọc trước: mysql\README.md (cách bộ Supply Chain đã được dựng – LÀM THEO ĐÚNG KHUÔN ĐÓ), cong-cu\README.md, quy_chuan\CHOT-FORMAT-CAU-HOI.md (mục 6 biến thể), BRIEF-SOAN-GOI.md (mục Phân bổ), style\STYLE-scm.md (mẫu cấu trúc bộ chuẩn).

## (1) MySQL
- Container MySQL dùng chung: `sqllb-mysql` (mạng `sqllb`, root password trong mysql\.env – KHÔNG in ra). Tạo database `<bo>` và `<bo>_hidden_1`, cấp SELECT cho `sql_runner`.
- Nguồn Postgres của lớp: CHỈ ĐỌC, luôn `docker exec -i -e PGOPTIONS='-c default_transaction_read_only=on' docker-postgres-1 psql -U postgres -d <db> ...`. TUYỆT ĐỐI không ghi, không ALTER, không stop/restart/compose bất kỳ container nào của project `docker` (docker-postgres-1, docker-backend-1, docker-redis-1, docker-game-api-1).
- Nguồn trong thư mục `Project DA` (Google Drive): chỉ đọc đúng file cần, KHÔNG quét đệ quy (Google Drive sẽ tải hàng loạt).
- Bản rút gọn: tổng ≲ 6 triệu dòng; giữ đủ bảng nhỏ; bảng sự kiện lớn lấy cửa sổ thời gian liền mạch; giữ PK/FK/index; kiểu MySQL hợp lý. Script đánh số trong mysql\<bo>\ (01_tao_bang, 02_nap, 03_bien_the_an) để chạy lại được; dữ liệu CSV trung gian ở mysql\<bo>\du-lieu\ (không đưa vào gói). Kiểm số dòng nguồn = MySQL.
- `<bo>_hidden_1` theo khuôn Datathon: bỏ ~10% dòng bảng sự kiện chính theo `id % 10 = 7` (giữ FK); thêm 1 dòng ngay sau mốc ngày cuối của bảng sự kiện chính; tạo 1 cặp hoà hạng ở nhóm hay được hỏi top N.
- Ghi mysql\README-<bo>.md: bảng, số dòng, cửa sổ, kiểu cột, quan hệ (ERD dạng chữ), bẫy dữ liệu đã kiểm (số thật), bảng "Biến thể · khác public · bắt lỗi gì".
- Chạy thử bộ kiểm trên một gói nhỏ 1 câu (thư mục nháp `goi-cau-hoi\<bo>\_thu\`) để chắc `dulieu=<bo>` ánh xạ đúng 2 database (sửa cấu hình bộ kiểm nếu cần ánh xạ, KHÔNG phá bộ scm).

## (2) style\STYLE-<bo>.md (cấu trúc như STYLE-scm.md)
A. Bảng thuật ngữ ngành 60–100 dòng: | Tiếng Anh / tên cột | Dùng | Không dùng | Ghi chú | Nguồn | – nguồn ưu tiên giáo trình/bài giảng đại học Việt Nam đúng ngành (WebSearch, ghi URL; không bịa nguồn), văn bản pháp quy nếu có, tài liệu của chính dự án (Blueprint, mô tả dữ liệu). B. Giọng văn từng phần (kế thừa STYLE-scm.md mục B). C. Khuôn cấm (kế thừa STYLE-scm.md mục C). E. 15–25 khái niệm khai báo `\khaibaokhainiem` khớp cột thật. G. Ánh xạ 6 khoá mảng nghiệp vụ chuẩn sang bộ này (không thêm khoá mới; nếu bộ không có mảng nào thì ghi rõ).

## (3) goi-cau-hoi\<bo>\BAN-DO-100-CAU.md
Bảng 100 câu theo Phân bổ trong BRIEF-SOAN-GOI.md: mã | gói | module | hình thức | cấp | dạng | mảng | tiêu đề | đề một câu | bảng dùng | bẫy chính. Mọi câu phải khả thi trên dữ liệu MySQL đã nạp. Cuối file: thống kê phủ dạng × mảng, phân bổ cấp/hình thức. Nếu dữ liệu quá phẳng cho module nào (ví dụ Joins, Cohort) thì đổi dạng bài hợp lý và ghi rõ lý do.

## Báo cáo cuối (≤ 250 từ)
Database, bảng, số dòng, cửa sổ; bẫy hidden-1; nguồn thuật ngữ chính; ghi chú rủi ro cho người soạn.
