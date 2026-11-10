# Trạng thái v4 của mkt goi-1 (chốt 11/11 04:46 – agent bị ngắt giữa chừng vì rate limit)

Mục tiêu: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (BRIEF-CAP-DO-MODULE.md). Thời gian sửa file lần cuối: cau-hoi.tex 10/11 23:41, solution.sql 10/11 22:45.

## Phân bố cấp hiện tại (đếm từ cau-hoi.tex)
- module `c`: Cơ bản 2 · Dễ 0 · Trung bình 0 · Khó 0  (mục tiêu 2·3·2·2)
- module `n`: Cơ bản 3 · Dễ 6 · Trung bình 0 · Khó 0  (mục tiêu 2·3·2·2)
- module `r`: Cơ bản 4 · Dễ 5 · Trung bình 0 · Khó 0  (mục tiêu 2·3·2·2)

## Mã · hình thức · cấp hiện tại (so với ../../BAN-DO-100-CAU.md bản v3: mã hoặc cấp khác = câu đã sửa v4, CÓ THỂ SỬA DỞ)
- `mkt-r1-influencer-purplle-thang-1` · write · basic · marketing
- `mkt-r2-working-women-tamil-tira` · write · basic · customer
- `mkt-r3-roi-thap-nhat-nykaa-q4` · write · basic · finance
- `mkt-r4-email-chuyen-doi-cao` · write · easy · sales
- `mkt-r5-chien-dich-30-ngay-cuoi-ky` · write · easy · operations
- `mkt-r6-diem-tuong-tac-tu-30` · write · easy · marketing
- `mkt-r7-paid-ads-ra-rong` · debug · basic · marketing
- `mkt-r8-thang-2-thieu-ngay-cuoi` · debug · easy · sales
- `mkt-r9-youth-hoac-working-women-thua` · debug · easy · customer
- `mkt-n1-ctr-seo-nykaa-ngay` · write · basic · marketing
- `mkt-n2-thieu-hien-thi-co-nhap` · write · basic · operations
- `mkt-n3-chi-phi-chien-dich-8-3` · write · easy · finance
- `mkt-n4-lai-hoa-lo-quy-1` · write · easy · finance
- `mkt-n5-dong-thieu-chi-so-pheu` · write · easy · operations
- `mkt-n6-gia-tri-don-11-11` · write · easy · sales
- `mkt-n7-doanh-thu-tho-thap-bat-thuong` · debug · basic · sales
- `mkt-n8-roi-tinh-lai-lech` · debug · easy · finance
- `mkt-n9-thieu-chi-phi-ra-0` · debug · easy · operations
- `mkt-c1-ctr-theo-loai-thang-5` · case · basic · marketing
- `mkt-c2-file-tho-thieu-nhieu-nhat` · case · basic · operations

## Resume
1. Chạy kiểm tĩnh (`--chi-phan-tich`) rồi bộ kiểm đầy đủ gói: câu báo lỗi = đang sửa dở, sửa nốt theo brief.
2. Đưa từng module về 2·3·2·2 theo BRIEF-CAP-DO-MODULE.md (đổi câu ở cấp thừa sang cấp thiếu, đủ 5 trục, wrong rớt, public ≠ hidden-1, solution < 10 giây).
3. Xong: bộ kiểm đầy đủ 0 lỗi, biên dịch 0 lỗi, ghi DA-SUA mục v4, cập nhật BANG-PHAN-CONG và dòng gói trong BAN-DO.

## Kết quả kiểm tĩnh lúc chốt: 0 lỗi – gói nhất quán, chỉ chưa bắt đầu đổi cấp (v4 chưa sửa gì).
