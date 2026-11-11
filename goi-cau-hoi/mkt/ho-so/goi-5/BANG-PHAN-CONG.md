# Bảng phân công · bộ Marketing (`mkt`) · gói 5

Module 9 Data Quality, Module 10 Query Performance, 2 case Khó. Bản v2 sau kiểm B/C (chi tiết `DA-SUA.md`).
Kiểm lại 10/11/2026: gói tạm 4 câu sửa SQL/yêu cầu (k6, p2, p3, p7) **KIEM TRA: 0 loi**; cả gói `--chi-phan-tich` **0 loi**; biên dịch XeLaTeX 0 lỗi.
v4 (11/11/2026, BRIEF-CAP-DO-MODULE): đổi 7 câu để mỗi module có 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (k1, k5, k9, p2, p5, p6, p8; chi tiết mục v4 của `DA-SUA.md`, dòng bản đồ mới ở `BAN-DO-V4-DONG.md`). Bộ kiểm đầy đủ cả gói (public + hidden-1) 11/11: **KIEM TRA: 0 loi**, 0 cảnh báo; biên dịch XeLaTeX 59 trang, 0 lỗi LaTeX, 0 ký tự thiếu.

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| mkt-k1-ho-so-null | A | B | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi; 2 wrong rớt public, hidden-1; solution 0,9 giây | v4: hạ Cơ bản (bỏ nối `brands`, `noise_log`; ERD 1 bảng có giá trị mẫu), chờ duyệt |
| mkt-k2-dong-trung-hoan-toan | A | C | v2 | Đạt (v1, SQL không đổi); bộ kiểm đầy đủ 11/11: 0 lỗi | Đã sửa theo C, chờ duyệt |
| mkt-k3-pheu-vo-ly | A | B | v2 | Đạt (v1, SQL không đổi); bộ kiểm đầy đủ 11/11: 0 lỗi | Đã sửa theo B, chờ duyệt |
| mkt-k4-phan-loai-ngay-loi | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3) và 11/11: 0 lỗi | Đã sửa theo C, chờ duyệt · v3: giữ; sql_mode mặc định ghi ở mysql/README-mkt.md · v4: giữ nguyên |
| mkt-k5-dong-doanh-thu-lech-ban-sach | A | – | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi; 2 wrong rớt public, hidden-1; solution 1,9 giây | v4: viết lại từ `mkt-k5-doi-soat-doanh-thu-tho-sach` (Khó → Dễ), chờ kiểm và duyệt |
| mkt-k6-do-chinh-xac-quy-tac | A | C | v3 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-5`): 0 lỗi | Sửa theo KIEM-V4 (C): quy tắc ngày ghi rõ mốc 1/7/2024–30/6/2025 (hết chấm oan hidden-1), thêm wrong `ky_theo_lich` |
| mkt-k7-doi-tuong-tho-le-te | A | B | chuẩn hoá | Bộ kiểm đầy đủ 10/11 (chuẩn hoá) và 11/11: 0 lỗi | Đã sửa theo B, chờ duyệt · chuẩn hoá: hạ Dễ (QĐC 2.1, sửa lỗi một chỗ), ERD 2 bảng có chữ trên đường nối; xem `../CHUAN-HOA.md` |
| mkt-k8-nhieu-null-ra-0 | A | C | v3 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-5`): 0 lỗi | Sửa theo KIEM-V4 (B, tuỳ chọn): `\luuy` viết lại cho rõ |
| mkt-k9-ma-lap-ra-ca-file | A | – | v4 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-5`): 0 lỗi | KIEM-V4: không trùng chủ đề với t9; đổi người hỏi (Bạn Hiếu), lời nhắn nêu việc dùng danh sách |
| mkt-p1-ba-chi-so-mot-lan-quet | A | C | v3 + sửa V4 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-5`): 0 lỗi | Sửa theo KIEM-V4 (B): giá trị mẫu ERD ghi dạng DB (1867515, 111.03, 2355) |
| mkt-p2-bao-cao-thang-3-theo-loai | A | B | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi; starter 181.251 so với 14.596 dòng trung gian (ngân sách 3) | Đã sửa theo B · v3: đổi mã (cũ mkt-p2-loc-thang-khong-dung-ham) · v4: hạ Dễ (ERD 2 bảng, đề và SQL giữ), chờ duyệt |
| mkt-p3-top-3-doanh-thu-moi-thuong-hieu | A | C | v3 | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-5`): 0 lỗi | Sửa theo KIEM-V4 (B, tuỳ chọn): bối cảnh "bảng vàng … đang chép" → "đang lấy số bằng ba đoạn" |
| mkt-p4-ctr-kenh-email-whatsapp | A | B | v3 | Bộ kiểm đầy đủ 10/11 (v3) và 11/11: 0 lỗi | Đã sửa theo B · v3: đổi mã (cũ mkt-p4-exists-thay-join-distinct); giữ tên hai kênh |
| mkt-p5-chi-phi-roi-bon-quy-mot-lan-quet | A | – | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi; starter quét `campaigns` 4 lần, solution 1 lần; wrong thiếu cận trên rớt hidden-1 | v4: viết lại từ `mkt-p5-dang-chay-moi-ngay-nhanh` (Khó → Dễ), chờ kiểm và duyệt |
| mkt-p6-thoi-luong-purplle-mot-lan-quet | A | – | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi; starter quét `campaigns` 3 lần, solution 1 lần; 2 wrong rớt public, hidden-1 | v4: viết lại từ `mkt-p6-dong-trung-du-lieu-tho` (Khó → Cơ bản), chờ kiểm và duyệt |
| mkt-p7-chien-dich-ngay-8-3-theo-chi-muc | A | C | v5 (sửa V4) | Bộ kiểm đầy đủ cả gói 11/11 (sửa V4, `cong-cu/ket-qua/sua-v4/mkt-goi-5`): 0 lỗi | Sửa theo KIEM-V4 (B): nâng thật Trung bình bằng so với ROI chung (không áp đề xuất nối `audiences` hai vai, trái QĐC 2.3 mục 18), dạng A1 → C3, ERD 3 bảng; xem DA-SUA |
| mkt-p8-so-chien-dich-theo-thang-lech | A | B | v4 | Bộ kiểm đầy đủ 11/11 (v4): 0 lỗi; starter sai cả hai biến thể; wrong thiếu cận trên rớt hidden-1, 2 wrong rớt cả hai | Đã sửa theo B · v4: hạ Dễ từ `mkt-p8-bao-cao-thang-cham-va-sai` (bỏ lỗi thứ hai, bỏ cột doanh thu, mảng sales → marketing), chờ duyệt |
| mkt-p9-chi-phi-tich-luy-thuong-hieu | A | C | v3 | Bộ kiểm đầy đủ 10/11 (v3) và 11/11: 0 lỗi | Đã sửa theo C · v3: giữ Khó (2 bẫy, QĐC 2.3 mục 18) |
| mkt-c9-dung-ban-tho-duoc-khong | A | B | v2 | Đạt (v1, SQL không đổi); bộ kiểm đầy đủ 11/11: 0 lỗi | Đã sửa theo B, chờ duyệt |
| mkt-c10-don-ngan-sach-loai-kenh | A | C | v2 | Đạt (v1, SQL không đổi); bộ kiểm đầy đủ 11/11: 0 lỗi | Đã sửa theo C, chờ duyệt |
