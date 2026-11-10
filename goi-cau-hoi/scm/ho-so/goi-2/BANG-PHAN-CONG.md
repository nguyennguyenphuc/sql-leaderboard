# Bảng phân công · gói 2 · Supply Chain (`scm`)

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| `scm-s1-don-mua-ve-tre-2016` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-s2-ngay-cao-diem-2016` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-s3-huy-kho-ve-tinh-18-thang` (cũ `scm-s3-lo-truot-thang-3-ra-0`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: viết lại Cơ bản → Trung bình, xem DA-SUA; cần kiểm lại nội dung |
| `scm-s4-lui-gio-chot-don` (cũ `scm-s4-don-sau-gio-chot-thang-7`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: viết lại Cơ bản → Khó, giờ chốt 17 giờ theo sách, xem DA-SUA; cần kiểm lại nội dung |
| `scm-s5-ban-theo-thu-cua-hang-44` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-s6-chuyen-giao-tre-quy-2` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-s7-gia-tri-nhan-sai-thu-tu` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-s8-von-ton-cuoi-ky-2017` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-s9-muc-tang-ngay-cao-diem-2016` (cũ `scm-s9-huy-cuoi-tuan-kho-ve-tinh`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: viết lại Dễ → Khó, xem DA-SUA; cần kiểm lại nội dung |
| `scm-a1-chuyen-giao-theo-dc-2016` (cũ `scm-a1-dung-han-theo-dc-2016`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: hạ Dễ → Cơ bản, xem DA-SUA; cần kiểm lại nội dung |
| `scm-a2-dai-chi-so-kho-dich-2017` (cũ `scm-a2-ty-le-lo-truot-100`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: viết lại Dễ → Khó, xem DA-SUA; cần kiểm lại nội dung |
| `scm-a3-voucher-theo-loai-kho` | Agent gói 2 | B, C | v3 | Đạt (MySQL 0 lỗi) | Quyết định v3 (10/11), xem DA-SUA (đổi SQL: nhóm 'manual') |
| `scm-a4-cua-hang-vang-khach-2016` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-a5-so-ma-ban-cua-hang-44` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-a6-tong-giao-dich-thang-7-thap` (cũ `scm-a6-dung-han-theo-mien-thap`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: viết lại Dễ → Cơ bản, xem DA-SUA; cần kiểm lại nội dung |
| `scm-a7-don-mien-theo-quy-2016` | Agent gói 2 | B, C | v2 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C |
| `scm-a8-bien-ln-gop-nganh-hang` | Agent gói 2 | B, C | v3 | Đạt (MySQL 0 lỗi hoặc tĩnh 0 lỗi) | Đã sửa theo B/C; Quyết định v3 (10/11), xem DA-SUA (lưu ý trung tính) |
| `scm-a9-pheu-don-mua-theo-dc-2016` (cũ `scm-a9-ncc-hang-loi-vuot-nguong`) | Agent gói 2 | B, C | v4 | Đạt (MySQL 0 lỗi) | v4: viết lại Trung bình → Khó, xem DA-SUA; cần kiểm lại nội dung |
| `scm-c3-kho-giao-tre` | Agent gói 2 | B, C | v3 | Đạt (tĩnh 0 lỗi) | Quyết định v3 (10/11), xem DA-SUA (hạ phương án đúng) |
| `scm-c4-khuyen-mai-cua-hang-44` | Agent gói 2 | B, C | v2 | Đạt (tĩnh 0 lỗi) | Quyết định v3 (10/11), xem DA-SUA (giữ mức kết luận v2) |

v4 (11/11/2026, `BRIEF-CAP-DO-MODULE.md`): 7 câu viết lại để mỗi module đủ 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (M3: s3, s4, s9; M4: a1, a2, a6, a9), đổi mã theo nội dung mới (giữ tiền tố và số). Chi tiết ở `DA-SUA.md` mục "v4 – đủ 4 cấp mỗi module". Bảy câu này cần một vòng kiểm B/C mới về nội dung và giọng văn.
