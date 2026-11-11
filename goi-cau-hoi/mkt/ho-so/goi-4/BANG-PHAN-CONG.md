# Bảng phân công · gói 4 Marketing (mkt) · cập nhật v4 (11/11/2026)

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| mkt-t1-roas-nua-dau-2025 | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md |
| mkt-t2-pheu-dang-dai | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · hạ TB → Dễ: công thức vào yêu cầu, ERD 2 bảng, xem DA-SUA.md mục v4 |
| mkt-t3-nhom-khach-hai-vai | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md |
| mkt-t4-ngung-kenh-anh-huong-doanh-thu (thay mkt-t4-quy-tac-doi-chieu-nhat-ky) | Agent gói 4 | B, C | v5 (viết lại, sửa V4) | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-4`): 0 lỗi; solution 2,8 giây; 3 wrong rớt đúng biến thể (thiếu cận trên chỉ rớt hidden-1) | Viết lại theo KIEM-V4 (C): t4 cũ chấm oan ở hidden-1 (đếm nhật ký DUPLICATE) và trùng chủ đề với k6; chủ đề mới: tỷ trọng doanh thu bị ảnh hưởng / mất hẳn khi ngừng một kênh, ô C2 · marketing · hard · write; xem DA-SUA |
| mkt-t5-dang-chay-binh-quan-theo-tuan | Agent gói 4 | B, C | v4 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-4`): 0 lỗi | Sửa theo KIEM-V4 (B): gợi ý cuối một biểu thức, `\erdkhoa` bỏ điều kiện nối viết sẵn, thêm 5 trục; thiếu bẫy hidden-1: chờ giảng viên (DA-SUA) |
| mkt-t6-so-chien-dich-theo-so-kenh | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · viết lại Khó → Cơ bản (cũ mkt-t6-phan-nhom-roi-ctr), xem DA-SUA.md mục v4 |
| mkt-t7-union-mat-doanh-thu | Agent gói 4 | B, C | v3 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-4`): 0 lỗi | Sửa theo KIEM-V4 (B): xoá ghi chú cấp cũ mâu thuẫn `cap=easy` |
| mkt-t8-ty-le-roi-pheu-sai-mau | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · hạ TB → Dễ: lỗi một chỗ, công thức vào yêu cầu, ERD 2 bảng, xem DA-SUA.md mục v4 |
| mkt-t9-bo-trung-khong-het | Agent gói 4 | B, C | v4 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-4`): 0 lỗi | KIEM-V4: t9/k9 không trùng chủ đề (ghi lý do ở `\ghichuthietke`), k9 đổi người hỏi |
| mkt-f1-top-3-doanh-thu-moi-thuong-hieu | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md |
| mkt-f2-mom-purplle | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · hạ TB → Dễ: công thức vào yêu cầu, ERD 2 bảng, xem DA-SUA.md mục v4 |
| mkt-f3-hang-luot-nhap-trong-ngay | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · viết lại Khó → Cơ bản (cũ mkt-f3-truot-7-ngay-tira), xem DA-SUA.md mục v4 |
| mkt-f4-pareto-tira | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đạt (B), không sửa |
| mkt-f5-chuoi-ngay-lien-tiep | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md |
| mkt-f6-nhom-gia-tri-don-theo-phan-khuc | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · hạ TB → Dễ: công thức vào yêu cầu, bỏ cột doanh thu, ERD 2 bảng, xem DA-SUA.md mục v4 |
| mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang | Agent gói 4 | B, C | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi | v4 · viết lại TB → Cơ bản (cũ mkt-f7-chi-phi-luy-ke-nhay-bac), xem DA-SUA.md mục v4 |
| mkt-f8-thang-truoc-lay-so-thang-sau | Agent gói 4 | B, C | v4 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-4`): 0 lỗi | Sửa theo KIEM-V4 (C): tiêu đề nêu triệu chứng thay vì nguyên nhân; giữ Dễ, ghi lý do so với f7 |
| mkt-f9-tuong-tac-cao-nhat-moi-loai | Agent gói 4 | B, C | v3 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md · v3: đã kiểm Tira Beauty đủ 5 loại quý 1/2025 trên cả hai biến thể |
| mkt-c7-doanh-thu-nykaa-co-giam | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md |
| mkt-c8-doi-tuong-dang-tang-ngan-sach | Agent gói 4 | B, C | v2 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi (không đổi ở v4) | Đã sửa theo REVIEW-B/C, xem DA-SUA.md |
