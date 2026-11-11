# Bảng phân công · gói 2 · AIV Bank (`aivb`)

v4 (11/11/2026, đủ 4 cấp mỗi module): 8 câu viết lại đổi cấp (in đậm phiên bản v4). Bộ kiểm đầy đủ cả gói ngày 11/11 (`cong-cu/ket-qua/cap-do/aivb-goi-2/`): **KIEM TRA: 0 loi**, 0 cảnh báo, mọi solution khác nhau giữa public và hidden-1 ở 8 câu v4. Biên dịch XeLaTeX: 49 trang, 0 lỗi, 0 ký tự thiếu. Câu v4 chưa qua người kiểm B/C.

| Mã | Người soạn (A) | Người kiểm (B) | Phiên bản | Kiểm SQL | Kiểm nội dung |
|---|---|---|---|---|---|
| `aivb-s1-chi-nhanh-quan` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-s2-ho-kinh-doanh-fnb` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-s3-lenh-mobile-theo-thang` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-s4-bien-dong-tai-khoan-2026` (mã cũ `aivb-s4-tai-khoan-mo-giua-nam`) | Agent gói 2 | chưa | **v4** (Dễ → Trung bình) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; 4 bài sai rớt ở public) | Viết lại theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 · **Sửa theo KIEM-V4 (11/11/2026):** KIEM-V4 (B) Cần sửa: bỏ "dòng sản phẩm", cột san_pham; bộ kiểm 0 lỗi. Nay Đạt. |
| `aivb-s5-giai-ngan-don-cuoi-thang` (mã cũ `aivb-s5-giai-ngan-ngay-cuoi-thang`) | Agent gói 2 | chưa | **v4** (Dễ → Khó) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; 3 bài sai rớt ở public) | Viết lại theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 · **Sửa theo KIEM-V4 (11/11/2026):** KIEM-V4 (C) Cần sửa giọng ("nó", thêm "rơi", "chúng"): đã sửa. Nay Đạt. |
| `aivb-s6-ngay-gia-tri-sang-thang-sau` (mã cũ `aivb-s6-ngay-gia-tri-lech`) | Agent gói 2 | chưa | **v4** (Dễ → Khó) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; `quen_can_tren` rớt chỉ ở hidden-1) | Viết lại theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 · **Sửa theo KIEM-V4 (11/11/2026):** KIEM-V4 (B) Cần sửa: giọng văn lời nhắn và tốc độ; solution viết lại, cùng kết quả, 11–33 giây → 3,5–5,3 giây; bộ kiểm 0 lỗi. Nay Đạt. |
| `aivb-s7-tham-nien-khach-hang` (mã cũ `aivb-s7-ma-dang-ky-kinh-doanh`) | Agent gói 2 | chưa | **v4** (Cơ bản → Trung bình) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; starter sai ở cả hai biến thể) | Viết lại theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 |
| `aivb-s8-lenh-bi-dao-theo-thang` | Agent gói 2 | B, C | v3 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi) | Đã sửa theo B/C, xem DA-SUA.md · **Sửa theo KIEM-V4 (11/11/2026):** góp ý B: "31 tháng" → "31 dòng". |
| `aivb-s9-quyet-dinh-kyc-thang-12-2025` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-a1-du-no-binh-quan` | Agent gói 2 | B, C | **v4** (Dễ → Cơ bản) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; SQL không đổi) | Hạ cấp theo v4 (ERD 1 bảng có giá trị mẫu), chưa kiểm B/C; xem DA-SUA.md mục v4 · **Sửa theo KIEM-V4 (11/11/2026):** KIEM-V4 (C) Cần sửa: khái niệm trang-thai-khoan-vay bỏ "đang còn dư nợ". Nay Đạt. |
| `aivb-a2-khach-hang-theo-phan-khuc` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-a3-ho-so-vay-san-pham-hang-diem` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-a4-ty-trong-kenh` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-a5-nhom-dti-ty-le-duyet` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-a6-khoan-vay-co-van-de-theo-san-pham` (mã cũ `aivb-a6-ty-le-khoan-vay-co-van-de`) | Agent gói 2 | chưa | **v4** (Trung bình → Khó) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; 4 bài sai rớt ở public) | Viết lại theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 · **Sửa theo KIEM-V4 (11/11/2026):** KIEM-V4 (C) Cần sửa cùng chỗ với a1: đã sửa. Nay Đạt. |
| `aivb-a7-lenh-thanh-cong-2026` | Agent gói 2 | B, C | **v4** (Dễ → Cơ bản) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; starter còn một lỗi) | Hạ cấp theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 |
| `aivb-a8-khach-nop-ho-so-theo-nam` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang` (mã cũ `aivb-a9-thieu-nghe-nghiep-theo-thu-nhap`) | Agent gói 2 | chưa | **v4** (Dễ → Khó) | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; starter 3 lỗi, 4 bài sai rớt ở public) | Viết lại theo v4, chưa kiểm B/C; xem DA-SUA.md mục v4 |
| `aivb-c3-kenh-hoan-lenh-quy-4` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi) | Đã sửa theo B/C, xem DA-SUA.md |
| `aivb-c4-ho-so-vay-2025` | Agent gói 2 | B, C | v2 | Đạt (bộ kiểm đầy đủ 11/11 v4: 0 lỗi; hidden-1 khác public qua file 04) | Đã sửa theo B/C, xem DA-SUA.md |
