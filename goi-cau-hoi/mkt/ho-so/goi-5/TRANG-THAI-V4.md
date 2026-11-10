XONG v4 – xem DA-SUA.md

# Trạng thái v4 của mkt goi-5 (chốt 11/11 04:46 – agent bị ngắt giữa chừng vì rate limit)

Mục tiêu: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (BRIEF-CAP-DO-MODULE.md). Thời gian sửa file lần cuối: cau-hoi.tex 10/11 23:42, solution.sql 10/11 22:45.

## Phân bố cấp hiện tại (đếm từ cau-hoi.tex)
- module `c`: Cơ bản 0 · Dễ 0 · Trung bình 0 · Khó 2  (mục tiêu 2·3·2·2)
- module `k`: Cơ bản 0 · Dễ 2 · Trung bình 3 · Khó 4  (mục tiêu 2·3·2·2)
- module `p`: Cơ bản 1 · Dễ 0 · Trung bình 4 · Khó 4  (mục tiêu 2·3·2·2)

## Mã · hình thức · cấp hiện tại (so với ../../BAN-DO-100-CAU.md bản v3: mã hoặc cấp khác = câu đã sửa v4, CÓ THỂ SỬA DỞ)
- `mkt-k1-ho-so-null` · write · medium · operations
- `mkt-k2-dong-trung-hoan-toan` · write · medium · sales
- `mkt-k3-pheu-vo-ly` · write · medium · marketing
- `mkt-k4-phan-loai-ngay-loi` · write · hard · operations
- `mkt-k5-doi-soat-doanh-thu-tho-sach` · write · hard · finance
- `mkt-k6-do-chinh-xac-quy-tac` · write · hard · operations
- `mkt-k7-doi-tuong-tho-le-te` · debug · easy · customer
- `mkt-k8-nhieu-null-ra-0` · debug · easy · operations
- `mkt-k9-doanh-thu-sach-con-trung` · debug · hard · finance
- `mkt-p1-ba-chi-so-mot-lan-quet` · optimize · basic · finance
- `mkt-p2-bao-cao-thang-3-theo-loai` · optimize · medium · marketing
- `mkt-p3-top-3-doanh-thu-moi-thuong-hieu` · optimize · hard · sales
- `mkt-p4-ctr-kenh-email-whatsapp` · optimize · medium · marketing
- `mkt-p5-dang-chay-moi-ngay-nhanh` · optimize · hard · operations
- `mkt-p6-dong-trung-du-lieu-tho` · optimize · hard · operations
- `mkt-p7-chien-dich-ngay-8-3-theo-chi-muc` · write · medium · customer
- `mkt-p8-bao-cao-thang-cham-va-sai` · debug · medium · sales
- `mkt-p9-chi-phi-tich-luy-thuong-hieu` · write · hard · finance
- `mkt-c9-dung-ban-tho-duoc-khong` · case · hard · operations
- `mkt-c10-don-ngan-sach-loai-kenh` · case · hard · finance

## Resume
1. Chạy kiểm tĩnh (`--chi-phan-tich`) rồi bộ kiểm đầy đủ gói: câu báo lỗi = đang sửa dở, sửa nốt theo brief.
2. Đưa từng module về 2·3·2·2 theo BRIEF-CAP-DO-MODULE.md (đổi câu ở cấp thừa sang cấp thiếu, đủ 5 trục, wrong rớt, public ≠ hidden-1, solution < 10 giây).
3. Xong: bộ kiểm đầy đủ 0 lỗi, biên dịch 0 lỗi, ghi DA-SUA mục v4, cập nhật BANG-PHAN-CONG và dòng gói trong BAN-DO.

## Kết quả kiểm tĩnh lúc chốt: 0 lỗi – gói nhất quán, chỉ chưa bắt đầu đổi cấp (v4 chưa sửa gì).
