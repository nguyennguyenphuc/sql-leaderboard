# Bảng phân công · bộ HR · gói 5 (M9 Data Quality, M10 Query Performance, case c9–c10)

v4 (11/11/2026, BRIEF-CAP-DO-MODULE): M9 và M10 mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. 5 câu viết lại (k1, k3, k7, p3, p6), 15 câu còn lại giữ nguyên nội dung và cấp; cả gói qua bộ kiểm đầy đủ (`cong-cu/ket-qua/cap-do/hr-goi-5`, KIEM TRA: 0 loi) và biên dịch XeLaTeX 0 lỗi.

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| hr-k1-de-bat-vuot-tham-nien | Agent A (gói 5) | chờ kiểm | v4 | Đạt (bộ kiểm đầy đủ 11/11, 0 lỗi) | v4: viết lại từ `hr-k1-co-lech-diem-danh-gia` (medium → basic), xem DA-SUA mục "v4 – đủ 4 cấp mỗi module" |
| hr-k2-loai-ly-do-nghi | Agent A (gói 5) | B/C (KIEM-V4) | v4.1 | Đạt: bộ kiểm đầy đủ cả gói 11/11/2026 (`cong-cu/ket-qua/sua-v4/hr-goi-5`), 0 lỗi | Sửa theo KIEM-V4: ghi chú đúng cấp Dễ (xem DA-SUA mục KIEM-V4) |
| hr-k3-gan-ket-lech-so-cong-ty | Agent A (gói 5) | chờ kiểm | v4 | Đạt (bộ kiểm đầy đủ 11/11, 0 lỗi) | v4: viết lại từ `hr-k3-gan-ket-hai-nguon` (medium → hard), xem DA-SUA mục "v4 – đủ 4 cấp mỗi module" |
| hr-k4-bao-cao-vong | Agent A (gói 5) | C | v3 | Đạt (kiểm C; tĩnh sau sửa 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-C (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |
| hr-k5-ty-le-thieu-du-lieu | Agent A (gói 5) | B/C (KIEM-V4) | v4.1 | Đạt: bộ kiểm đầy đủ cả gói 11/11/2026 (`cong-cu/ket-qua/sua-v4/hr-goi-5`), 0 lỗi | Sửa theo KIEM-V4: ghi chú đúng cấp Dễ (xem DA-SUA mục KIEM-V4) |
| hr-k6-compa-tu-tinh | Agent A (gói 5) | B/C (KIEM-V4) | v4.1 | Đạt: bộ kiểm đầy đủ cả gói 11/11/2026 (`cong-cu/ket-qua/sua-v4/hr-goi-5`), 0 lỗi | Sửa theo KIEM-V4: ghi chú đúng cấp Trung bình, ghi thời gian wrong chậm (xem DA-SUA mục KIEM-V4) |
| hr-k7-doi-bac-thua-nguoi | Agent A (gói 5) | chờ kiểm | v4 | Đạt (bộ kiểm đầy đủ 11/11, 0 lỗi) | v4: viết lại từ `hr-k7-tong-theo-bac-lech` (debug medium → basic), xem DA-SUA mục "v4 – đủ 4 cấp mỗi module" |
| hr-k8-thieu-quan-ly-ra-0 | Agent A (gói 5) | B/C (KIEM-V4) | v4.1 | Đạt: bộ kiểm đầy đủ cả gói 11/11/2026 (`cong-cu/ket-qua/sua-v4/hr-goi-5`), 0 lỗi | Sửa theo KIEM-V4: ghi chú đúng cấp Dễ (xem DA-SUA mục KIEM-V4) |
| hr-k9-backfill-lech-thang | Agent A (gói 5) | B | v2 | Đạt (kiểm B; tĩnh sau sửa 0 lỗi) | Đã sửa theo REVIEW-B (xem DA-SUA.md) |
| hr-p1-nghi-ba-loai-mot-lan-quet | Agent A (gói 5) | C | v3 | Đạt (bộ kiểm gói tạm sau sửa, 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-C (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |
| hr-p2-chi-so-thang-mot-lan-quet | Agent A (gói 5) | B | v2 | Đạt (kiểm B; tĩnh sau sửa 0 lỗi) | Đã sửa theo REVIEW-B (xem DA-SUA.md) |
| hr-p3-loc-ngay-dung-chi-muc | Agent A (gói 5) | chờ kiểm | v4 | Đạt (bộ kiểm đầy đủ 11/11, 0 lỗi) | v4: viết lại từ `hr-p3-top3-khong-tuong-quan` (hard → easy), xem DA-SUA mục "v4 – đủ 4 cấp mỗi module" |
| hr-p4-yeu-cau-ngoai-ke-hoach | Agent A (gói 5) | B | v2 | Đạt (kiểm B; tĩnh sau sửa 0 lỗi) | Đã sửa theo REVIEW-B (xem DA-SUA.md) |
| hr-p5-tang-luong-khong-tu-noi | Agent A (gói 5) | C | v3 | Đạt (kiểm C; tĩnh sau sửa 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-C (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |
| hr-p6-y-dinh-o-lai-mot-lan-quet | Agent A (gói 5) | chờ kiểm | v4 | Đạt (bộ kiểm đầy đủ 11/11, 0 lỗi) | v4: viết lại từ `hr-p6-enps-noi-mot-thang` (hard → easy), xem DA-SUA mục "v4 – đủ 4 cấp mỗi module" |
| hr-p7-dem-theo-thang-chi-muc | Agent A (gói 5) | C | v3 | Đạt (bộ kiểm gói tạm sau sửa, 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-C (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |
| hr-p8-chuoi-thang-sai | Agent A (gói 5) | B | v2 | Đạt (kiểm B; tĩnh sau sửa 0 lỗi) | Đã sửa theo REVIEW-B (xem DA-SUA.md) |
| hr-p9-pareto-quan-ly | Agent A (gói 5) | C | v3 | Đạt (kiểm C; tĩnh sau sửa 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-C (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |
| hr-c9-chi-phi-tuyen-thay-the | Agent A (gói 5) | B | v3 | Đạt (kiểm B; tĩnh sau sửa 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-B (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |
| hr-c10-tang-luong-nhom-compa-thap | Agent A (gói 5) | C | v3 | Đạt (bộ kiểm gói tạm sau sửa, 0 lỗi); v3: bộ kiểm đầy đủ 10/11 (xem QUYET-DINH-126) | Đã sửa theo REVIEW-C (xem DA-SUA.md); v3: quyết định 126 điểm, xem DA-SUA mục "Quyết định v3 (10/11)" |

KIEM-V4 (11/11/2026): sửa 4 câu theo `ho-so/KIEM-V4-B.md`, `KIEM-V4-C.md`; không đổi cấp. Bộ kiểm đầy đủ cả gói (`cong-cu/ket-qua/sua-v4/hr-goi-5`): KIEM TRA 0 lỗi; biên dịch XeLaTeX 0 lỗi.
