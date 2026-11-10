# Bảng phân công · gói 4 Supply Chain (scm)

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| scm-t1-ton-tren-ban-nganh-hang | Agent gói 4 | B | v2 | Đạt sau sửa (bộ kiểm gói tạm: 0 lỗi) | Đã sửa theo B |
| scm-t2-chuyen-giao-cua-hang-18 | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo C |
| scm-t3-ma-hang-can-ra-soat | Agent gói 4 | B | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: hạ Trung bình → Dễ (dạng A1 → A3, ERD 2 bảng, đề ghi rõ giá trị); chờ người kiểm vòng v4 |
| scm-t4-nhap-xuat-ton-cua-hang-3 | Agent gói 4 | C | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: viết mới, Trung bình → Cơ bản (thay scm-t4-ty-le-lo-truot-ncc); chờ người kiểm vòng v4 |
| scm-t5-nhap-xuat-dc | Agent gói 4 | B | v3 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi) | Đã sửa theo B; Quyết định v3 (10/11), xem DA-SUA (thêm lưu ý dữ liệu mô phỏng) |
| scm-t6-von-ton-binh-quan-loai-cua-hang | Agent gói 4 | C | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: viết lại, Trung bình → Dễ (thay scm-t6-von-ton-theo-loai-cua-hang); chờ người kiểm vòng v4 |
| scm-t7-ma-thieu-hut-nhieu-ky | Agent gói 4 | B | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: viết mới, Khó → Cơ bản (thay scm-t7-ncc-duoi-chuan); chờ người kiểm vòng v4 |
| scm-t8-diem-giao-huy-cao | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi) | Đã sửa theo C |
| scm-t9-huy-theo-nhom-ap-ma | Agent gói 4 | B | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi); saiso 0,001 giữ (Quyết định v3) | v4: hạ Trung bình → Dễ (công thức, dòng tổng nêu trong đề; bỏ cột thứ tự phụ; ERD 2 bảng); chờ người kiểm vòng v4 |
| scm-f1-top3-hang-tuoi-song | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi) | Đã sửa theo C |
| scm-f2-fill-rate-theo-thang | Agent gói 4 | B | v2 | Đạt (SQL không đổi; hết trùng c7.b1); biến thể ẩn bổ sung 10/11 | Đã sửa theo B |
| scm-f3-luy-ke-cua-hang-44 | Agent gói 4 | C | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi); SQL không đổi | v4: hạ Trung bình → Dễ (ERD 2 bảng, đề ghi rõ giá trị lọc); chờ người kiểm vòng v4 |
| scm-f4-don-so-voi-hom-truoc | Agent gói 4 | B | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: viết lại cùng chủ đề, Khó → Dễ (thay scm-f4-ngay-don-tang-dot-bien); chờ người kiểm vòng v4 |
| scm-f5-xep-hang-ngay-tai-kho | Agent gói 4 | C | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: viết mới, Khó → Cơ bản (thay scm-f5-hang-abc-beverages); chờ người kiểm vòng v4 |
| scm-f6-giao-dich-cung-ky | Agent gói 4 | B | v2 | Đạt sau sửa (bộ kiểm gói tạm: 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo B; tiêu chí cùng cửa hàng giữ (Quyết định v3 (10/11), xem DA-SUA) |
| scm-f7-cua-hang-dong-khach-nhat | Agent gói 4 | C | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi); SQL không đổi | v4: hạ Trung bình → Dễ (QUYET-DINH-CHUNG 0.1 #5; ERD 2 bảng, thêm gợi ý nấc 2); chờ người kiểm vòng v4 |
| scm-f8-luy-ke-nhan-hang-ncc | Agent gói 4 | B | v2 | Đạt sau sửa (bộ kiểm gói tạm: 0 lỗi; starter có dòng, thấy cả hai lỗi) | Đã sửa theo B |
| scm-f9-thay-doi-ty-le-huy-thang | Agent gói 4 | C | v4 | Đạt (v4: bộ kiểm đầy đủ `cong-cu/ket-qua/cap-do/scm-goi-4`, 0 lỗi) | v4: viết lại cùng chủ đề, Trung bình → Cơ bản (thay scm-f9-huy-thang-truoc-theo-kho); chờ người kiểm vòng v4 |
| scm-c7-fill-rate-thang-3 | Agent gói 4 | B | v3 | Đạt sau sửa (bộ kiểm gói tạm: 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo B; Quyết định v3 (10/11), xem DA-SUA (phương án đúng chỉ nêu tương quan) |
| scm-c8-giao-tre-ngay-cao-diem | Agent gói 4 | C | v2 | Đạt (SQL không đổi; phân tích tĩnh 0 lỗi); biến thể ẩn bổ sung 10/11 | Đã sửa theo C |

v4 (11/11/2026, `BRIEF-CAP-DO-MODULE.md`): mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó; 10 câu đổi cấp, xem `DA-SUA.md` mục v4. Các câu còn lại giữ phiên bản cũ.
