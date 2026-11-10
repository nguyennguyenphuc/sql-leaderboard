# Trạng thái v4 của mkt goi-2 (chốt 11/11 04:46 – agent bị ngắt giữa chừng vì rate limit)

Mục tiêu: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (BRIEF-CAP-DO-MODULE.md). Thời gian sửa file lần cuối: cau-hoi.tex 10/11 23:34, solution.sql 10/11 22:45.

## Phân bố cấp hiện tại (đếm từ cau-hoi.tex)
- module `a`: Cơ bản 0 · Dễ 7 · Trung bình 2 · Khó 0  (mục tiêu 2·3·2·2)
- module `c`: Cơ bản 1 · Dễ 1 · Trung bình 0 · Khó 0  (mục tiêu 2·3·2·2)
- module `s`: Cơ bản 3 · Dễ 6 · Trung bình 0 · Khó 0  (mục tiêu 2·3·2·2)

## Mã · hình thức · cấp hiện tại (so với ../../BAN-DO-100-CAU.md bản v3: mã hoặc cấp khác = câu đã sửa v4, CÓ THỂ SỬA DỞ)
- `mkt-s1-social-nykaa-theo-thang` · write · basic · marketing
- `mkt-s2-ket-thuc-ngay-14-2` · write · basic · operations
- `mkt-s3-bat-dau-cuoi-tuan` · write · easy · operations
- `mkt-s4-ba-kenh-youtube-dau` · write · easy · marketing
- `mkt-s5-ngay-tho-khong-doc-duoc` · write · easy · operations
- `mkt-s6-so-duoi-ma-lon-nhat` · write · easy · operations
- `mkt-s7-dem-loai-ra-20-nhom` · debug · basic · marketing
- `mkt-s8-thang-sap-sai-thu-tu` · debug · easy · sales
- `mkt-s9-dang-chay-ngay-1-1` · debug · easy · operations
- `mkt-a1-roi-tong-theo-thuong-hieu` · write · easy · finance
- `mkt-a2-pheu-theo-loai` · write · easy · marketing
- `mkt-a3-doi-tuong-quy-1` · write · easy · customer
- `mkt-a4-bang-cheo-ngon-ngu` · write · easy · customer
- `mkt-a5-ngay-tren-350-co-lai` · write · medium · operations
- `mkt-a6-doanh-thu-nykaa-theo-thang` · write · easy · sales
- `mkt-a7-roi-thuong-hieu-cao-bat-thuong` · debug · easy · finance
- `mkt-a8-so-chien-dich-tho-thua` · debug · easy · operations
- `mkt-a9-doanh-thu-theo-quy-gop-sai` · debug · medium · sales
- `mkt-c3-thang-purplle-mo-nhieu-nhat` · case · basic · marketing
- `mkt-c4-loai-roi-duoi-muc-chung` · case · easy · finance

## Resume
1. Chạy kiểm tĩnh (`--chi-phan-tich`) rồi bộ kiểm đầy đủ gói: câu báo lỗi = đang sửa dở, sửa nốt theo brief.
2. Đưa từng module về 2·3·2·2 theo BRIEF-CAP-DO-MODULE.md (đổi câu ở cấp thừa sang cấp thiếu, đủ 5 trục, wrong rớt, public ≠ hidden-1, solution < 10 giây).
3. Xong: bộ kiểm đầy đủ 0 lỗi, biên dịch 0 lỗi, ghi DA-SUA mục v4, cập nhật BANG-PHAN-CONG và dòng gói trong BAN-DO.

## Kết quả kiểm tĩnh lúc chốt: 0 lỗi – gói nhất quán, chỉ chưa bắt đầu đổi cấp (v4 chưa sửa gì).
