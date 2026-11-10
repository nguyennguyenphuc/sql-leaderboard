# Trạng thái v4 của mkt goi-3 (chốt 11/11 04:46 – agent bị ngắt giữa chừng vì rate limit)

Mục tiêu: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (BRIEF-CAP-DO-MODULE.md). Thời gian sửa file lần cuối: cau-hoi.tex 10/11 23:34, solution.sql 10/11 22:45.

## Phân bố cấp hiện tại (đếm từ cau-hoi.tex)
- module `c`: Cơ bản 0 · Dễ 1 · Trung bình 1 · Khó 0  (mục tiêu 2·3·2·2)
- module `j`: Cơ bản 0 · Dễ 4 · Trung bình 5 · Khó 0  (mục tiêu 2·3·2·2)
- module `q`: Cơ bản 1 · Dễ 3 · Trung bình 5 · Khó 0  (mục tiêu 2·3·2·2)

## Mã · hình thức · cấp hiện tại (so với ../../BAN-DO-100-CAU.md bản v3: mã hoặc cấp khác = câu đã sửa v4, CÓ THỂ SỬA DỞ)
- `mkt-j1-doanh-thu-loai-thuong-hieu` · write · easy · marketing
- `mkt-j2-doi-tuong-va-phan-khuc` · write · easy · customer
- `mkt-j3-hien-thi-theo-kenh` · write · medium · marketing
- `mkt-j4-dang-chay-tuan-dau-thang-2` · write · medium · operations
- `mkt-j5-ngay-khong-co-chien-dich` · write · medium · operations
- `mkt-j6-loai-email-khong-kenh-email` · write · medium · marketing
- `mkt-j7-doanh-thu-instagram-facebook-gap-doi` · debug · easy · sales
- `mkt-j8-phan-khuc-lay-nham-doi-tuong` · debug · easy · customer
- `mkt-j9-lich-thieu-ngay-trong` · debug · medium · operations
- `mkt-q1-roi-tren-binh-quan-tira` · write · easy · finance
- `mkt-q2-doanh-thu-cao-nhat-moi-thuong-hieu` · write · easy · sales
- `mkt-q3-loai-ctr-tren-chung` · write · medium · marketing
- `mkt-q4-doi-soat-roi-tinh-san` · write · medium · finance
- `mkt-q5-ty-trong-loai-purplle` · write · easy · sales
- `mkt-q6-ngay-purplle-khong-seo` · write · medium · marketing
- `mkt-q7-shoppers-ra-rong` · debug · basic · customer
- `mkt-q8-dong-sach-khong-nhieu-sai` · debug · medium · operations
- `mkt-q9-tuong-tac-tren-binh-quan-loai` · debug · medium · marketing
- `mkt-c5-kenh-hieu-qua-hon` · case · easy · marketing
- `mkt-c6-tho-va-sach-lech-o-dau` · case · medium · operations

## Resume
1. Chạy kiểm tĩnh (`--chi-phan-tich`) rồi bộ kiểm đầy đủ gói: câu báo lỗi = đang sửa dở, sửa nốt theo brief.
2. Đưa từng module về 2·3·2·2 theo BRIEF-CAP-DO-MODULE.md (đổi câu ở cấp thừa sang cấp thiếu, đủ 5 trục, wrong rớt, public ≠ hidden-1, solution < 10 giây).
3. Xong: bộ kiểm đầy đủ 0 lỗi, biên dịch 0 lỗi, ghi DA-SUA mục v4, cập nhật BANG-PHAN-CONG và dòng gói trong BAN-DO.

## Kết quả kiểm tĩnh lúc chốt: 0 lỗi – gói nhất quán, chỉ chưa bắt đầu đổi cấp (v4 chưa sửa gì).
