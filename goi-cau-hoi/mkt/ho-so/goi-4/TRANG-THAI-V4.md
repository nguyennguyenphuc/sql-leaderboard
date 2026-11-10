XONG v4 – xem DA-SUA.md

# Trạng thái v4 của mkt goi-4 (chốt 11/11 04:46 – agent bị ngắt giữa chừng vì rate limit)

Mục tiêu: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (BRIEF-CAP-DO-MODULE.md). Thời gian sửa file lần cuối: cau-hoi.tex 10/11 23:11, solution.sql 11/11 04:05.

## Phân bố cấp hiện tại (đếm từ cau-hoi.tex)
- module `c`: Cơ bản 0 · Dễ 0 · Trung bình 1 · Khó 1  (mục tiêu 2·3·2·2)
- module `f`: Cơ bản 0 · Dễ 0 · Trung bình 5 · Khó 4  (mục tiêu 2·3·2·2)
- module `t`: Cơ bản 0 · Dễ 1 · Trung bình 4 · Khó 4  (mục tiêu 2·3·2·2)

## Mã · hình thức · cấp hiện tại (so với ../../BAN-DO-100-CAU.md bản v3: mã hoặc cấp khác = câu đã sửa v4, CÓ THỂ SỬA DỞ)
- `mkt-t1-roas-nua-dau-2025` · write · medium · finance
- `mkt-t2-pheu-dang-dai` · write · medium · marketing
- `mkt-t3-nhom-khach-hai-vai` · write · medium · customer
- `mkt-t4-quy-tac-doi-chieu-nhat-ky` · write · hard · operations
- `mkt-t5-dang-chay-binh-quan-theo-tuan` · write · hard · operations
- `mkt-t6-phan-nhom-roi-ctr` · write · hard · finance
- `mkt-t7-union-mat-doanh-thu` · debug · easy · sales
- `mkt-t8-ty-le-roi-pheu-sai-mau` · debug · medium · marketing
- `mkt-t9-bo-trung-khong-het` · debug · hard · operations
- `mkt-f1-top-3-doanh-thu-moi-thuong-hieu` · write · medium · sales
- `mkt-f2-mom-purplle` · write · medium · sales
- `mkt-f3-truot-7-ngay-tira` · write · hard · marketing
- `mkt-f4-pareto-tira` · write · hard · finance
- `mkt-f5-chuoi-ngay-lien-tiep` · write · hard · marketing
- `mkt-f6-nhom-gia-tri-don-theo-phan-khuc` · write · medium · customer
- `mkt-f7-chi-phi-luy-ke-nhay-bac` · debug · medium · finance
- `mkt-f8-lag-khong-chia-thuong-hieu` · debug · hard · sales
- `mkt-f9-tuong-tac-cao-nhat-moi-loai` · debug · medium · marketing
- `mkt-c7-doanh-thu-nykaa-co-giam` · case · medium · sales
- `mkt-c8-doi-tuong-dang-tang-ngan-sach` · case · hard · customer

## Resume
1. Chạy kiểm tĩnh (`--chi-phan-tich`) rồi bộ kiểm đầy đủ gói: câu báo lỗi = đang sửa dở, sửa nốt theo brief.
2. Đưa từng module về 2·3·2·2 theo BRIEF-CAP-DO-MODULE.md (đổi câu ở cấp thừa sang cấp thiếu, đủ 5 trục, wrong rớt, public ≠ hidden-1, solution < 10 giây).
3. Xong: bộ kiểm đầy đủ 0 lỗi, biên dịch 0 lỗi, ghi DA-SUA mục v4, cập nhật BANG-PHAN-CONG và dòng gói trong BAN-DO.

## Kết quả kiểm tĩnh lúc chốt (11/11 ~05:5x)

- Gói đang vỡ ở **4 câu** (agent sửa dở solution.sql lúc 04:05): `mkt-t6`, `mkt-f3` (mỗi câu thiếu khối solution + wrong), `mkt-f7`, `mkt-f8` (thiếu cả solution, wrong, starter). 16 câu còn lại OK.
- Mã trong cau-hoi.tex của 4 câu này có thể cũng đã đổi hướng (kiểm đề trước khi viết lại SQL). Làm lại 4 câu theo BRIEF-CAP-DO-MODULE.md rồi chạy bộ kiểm đầy đủ cả gói.
