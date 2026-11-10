# Bảng phân công · bộ Marketing (`mkt`) · gói 5

Module 9 Data Quality, Module 10 Query Performance, 2 case Khó. Bản v2 sau kiểm B/C (chi tiết `DA-SUA.md`).
Kiểm lại 10/11/2026: gói tạm 4 câu sửa SQL/yêu cầu (k6, p2, p3, p7) **KIEM TRA: 0 loi**; cả gói `--chi-phan-tich` **0 loi**; biên dịch XeLaTeX 0 lỗi.

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| mkt-k1-ho-so-null | A | B | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo B, chờ duyệt |
| mkt-k2-dong-trung-hoan-toan | A | C | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo C, chờ duyệt |
| mkt-k3-pheu-vo-ly | A | B | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo B, chờ duyệt |
| mkt-k4-phan-loai-ngay-loi | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C, chờ duyệt · v3: giữ; sql_mode mặc định ghi ở mysql/README-mkt.md |
| mkt-k5-doi-soat-doanh-thu-tho-sach | A | B | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo B, chờ duyệt |
| mkt-k6-do-chinh-xac-quy-tac | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C, chờ duyệt · v3: đổi mã (cũ mkt-k6-do-chinh-xac-luat) |
| mkt-k7-doi-tuong-tho-le-te | A | B | chuẩn hoá | Bộ kiểm đầy đủ 10/11 (chuẩn hoá): 0 lỗi | Đã sửa theo B, chờ duyệt · chuẩn hoá: hạ Dễ (QĐC 2.1, sửa lỗi một chỗ), ERD 2 bảng có chữ trên đường nối; xem `../CHUAN-HOA.md` |
| mkt-k8-nhieu-null-ra-0 | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C · v3: hạ Dễ (QĐC 2.3 mục 18), ERD 2 bảng |
| mkt-k9-doanh-thu-sach-con-trung | A | B | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo B, chờ duyệt |
| mkt-p1-ba-chi-so-mot-lan-quet | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C · v3: hạ Cơ bản (QĐC 2.3 mục 18), ERD 1 bảng có giá trị mẫu |
| mkt-p2-bao-cao-thang-3-theo-loai | A | B | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo B, chờ duyệt · v3: đổi mã (cũ mkt-p2-loc-thang-khong-dung-ham) |
| mkt-p3-top-3-doanh-thu-moi-thuong-hieu | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C · v3: đổi mã (cũ mkt-p3-top-3-khong-dem-tuong-quan); giữ Khó |
| mkt-p4-ctr-kenh-email-whatsapp | A | B | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo B · v3: đổi mã (cũ mkt-p4-exists-thay-join-distinct); giữ tên hai kênh |
| mkt-p5-dang-chay-moi-ngay-nhanh | A | C | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo C, chờ duyệt |
| mkt-p6-dong-trung-du-lieu-tho | A | B | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo B, chờ duyệt · v3: đổi mã (cũ mkt-p6-tim-trung-khong-tu-noi) |
| mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C · v3: giữ Trung bình (QĐC 2.3 mục 18) |
| mkt-p8-bao-cao-thang-cham-va-sai | A | B | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo B, chờ duyệt |
| mkt-p9-chi-phi-tich-luy-thuong-hieu | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3): 0 lỗi | Đã sửa theo C · v3: giữ Khó (2 bẫy, QĐC 2.3 mục 18) |
| mkt-c9-dung-ban-tho-duoc-khong | A | B | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo B, chờ duyệt |
| mkt-c10-don-ngan-sach-loai-kenh | A | C | v2 | Đạt (v1, SQL không đổi) | Đã sửa theo C, chờ duyệt |
