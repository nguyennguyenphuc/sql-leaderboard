# Bảng phân công · gói 4 Supply Chain (scm)

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| scm-t1-ton-tren-ban-nganh-hang | Agent gói 4 | B | v5 | Đạt (bộ kiểm đầy đủ sua-v4 11/11, 0 lỗi) | Đã sửa (V4: thu về cửa hàng 44 cho nhanh), xem DA-SUA |
| scm-t2-chuyen-giao-cua-hang-18 | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo C |
| scm-t3-ma-hang-can-ra-soat | Agent gói 4 | B | v4 | Đạt (KIEM-V4 C, 11/11) | Đạt (KIEM-V4 C, 11/11) |
| scm-t4-nhap-xuat-ton-cua-hang-3 | Agent gói 4 | C | v4 | Đạt (KIEM-V4 B, 11/11) | Đạt (KIEM-V4 B, 11/11) |
| scm-t5-nhap-xuat-dc | Agent gói 4 | B | v5 | Đạt (bộ kiểm đầy đủ sua-v4 11/11, 0 lỗi) | Đã sửa theo KIEM-V4 C (ERD 5 bảng, 2 bảng nhiễu) |
| scm-t6-von-ton-binh-quan-loai-cua-hang | Agent gói 4 | C | v4 | Đạt (KIEM-V4 B, 11/11) | Đạt (KIEM-V4 B, 11/11) |
| scm-t7-ma-thieu-hut-nhieu-ky | Agent gói 4 | B | v5 | Đạt (bộ kiểm đầy đủ sua-v4 11/11, 0 lỗi) | Đạt (KIEM-V4 C); giá trị mẫu ERD lấy số thật |
| scm-t8-diem-giao-huy-cao | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi) | Đã sửa theo C |
| scm-t9-huy-theo-nhom-ap-ma | Agent gói 4 | B | v4 | Đạt (KIEM-V4 B, 11/11) | Đạt (KIEM-V4 B, 11/11) |
| scm-f1-top3-hang-tuoi-song | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi) | Đã sửa theo C |
| scm-f2-fill-rate-theo-thang | Agent gói 4 | B | v2 | Đạt (SQL không đổi; hết trùng c7.b1); biến thể ẩn bổ sung 10/11 | Đã sửa theo B |
| scm-f3-luy-ke-cua-hang-44 | Agent gói 4 | C | v4 | Đạt (KIEM-V4 C, 11/11) | Đạt (KIEM-V4 C, 11/11) |
| scm-f4-don-so-voi-hom-truoc | Agent gói 4 | B | v4 | Đạt (KIEM-V4 B, 11/11) | Đạt (KIEM-V4 B, 11/11) |
| scm-f5-xep-hang-ngay-tai-kho | Agent gói 4 | C | v5 | Đạt (bộ kiểm đầy đủ sua-v4 11/11, 0 lỗi) | Đạt (KIEM-V4 C); giá trị mẫu ERD lấy số thật |
| scm-f6-giao-dich-cung-ky | Agent gói 4 | B | v2 | Đạt sau sửa (bộ kiểm gói tạm: 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo B; tiêu chí cùng cửa hàng giữ (Quyết định v3 (10/11), xem DA-SUA) |
| scm-f7-cua-hang-dong-khach-nhat | Agent gói 4 | C | v4 | Đạt (KIEM-V4 B, 11/11) | Đạt (KIEM-V4 B, 11/11) |
| scm-f8-luy-ke-nhan-hang-ncc | Agent gói 4 | B | v2 | Đạt sau sửa (bộ kiểm gói tạm: 0 lỗi; starter có dòng, thấy cả hai lỗi) | Đã sửa theo B |
| scm-f9-thay-doi-ty-le-huy-thang | Agent gói 4 | C | v4 | Đạt (KIEM-V4 C, 11/11) | Đạt (KIEM-V4 C, 11/11) |
| scm-c7-fill-rate-thang-3 | Agent gói 4 | B | v3 | Đạt (KIEM-V4 B, 11/11) | Đạt (KIEM-V4 B, 11/11) |
| scm-c8-giao-tre-ngay-cao-diem | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo C |

v4 (11/11/2026, `BRIEF-CAP-DO-MODULE.md`): mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó; 10 câu đổi cấp, xem `DA-SUA.md` mục v4. Các câu còn lại giữ phiên bản cũ.
