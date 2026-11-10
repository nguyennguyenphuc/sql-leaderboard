# Chuẩn hoá bộ jelly theo quy chuẩn (BRIEF-CHUAN-HOA, 10/11/2026)

Căn cứ: `quy_chuan\` (CHOT-FORMAT-CAU-HOI.md, Huong-dan-cho-team-noi-dung.md, goi-cau-hoi-mau\cau-hoi.tex, HUONG_DAN.md) > QUYET-DINH-CHUNG.md > STYLE-jelly.md. Không đổi SQL, mã, khoá chấm.

| Mục | Số chỗ sửa | Chi tiết |
|---|---|---|
| 1. Kết luận case | 19 chỗ trong 10 case (+2 ghi chú thiết kế) | c9, c10 có 4 phương án: bỏ một phương án sai để còn **ba** như cả 4 case mẫu c1–c4 và QUYET-DINH-CHUNG 1.1 (c9 bỏ "hai nhánh không so được"; c10 bỏ "cờ thêm lượt đi là doanh thu"); c10 viết lại 3 phương án cho cân (24/27/28 tiếng, trước 38/42/18), c9 rút phương án đúng (32 → 28). Lời giải thích > 35 tiếng rút lại: c4 đúng (39 → 33), c5 đúng (47 → 31), c6 sai 1 (36 → 32), c7 sai 1 (41 → 34), c7 sai 3 (63 → 34). Sau "Đúng: " viết chữ thường như mẫu ("Đúng: bước 1 …"): c1–c10. Phương án sai không tiền tố (đã đúng từ trước). |
| 2. Gợi ý | 1 | p9 nấc cuối "Bảng nào đã có sẵn mỗi người chơi một dòng?" → nêu trọn một biểu thức một dòng (thay CTE `SELECT DISTINCT` bằng `FROM users u LEFT JOIN purchases p`). Các gợi ý khác đã 1–2 nấc, không có khung nhiều dòng. |
| 3. Tiêu đề | 9 | Rút về ≤ 13 tiếng: q7 (14), t4 (14), p2 (15), p6 (17). Câu Tối ưu nêu ràng buộc: p1, p2, p3 ("một lần quét"), p4 ("không dùng tự nối bảng", như mẫu o4), p5, p9 ("ít/bớt dòng trung gian"), p6 ("một lần đọc bảng hoạt động"); p7 đã có. |
| 4. ERD cấp Khó | 11 ERD (+10 ghi chú) | Mọi ERD Khó đã chỉ khoá, không `\erdnoi`, có `\erdkhoa`. ERD dưới 5 bảng được thêm bảng nhiễu cho đủ 5 (lời giải dùng ≤ 3 bảng, như mẫu d4, o4), `\erdkhoa` ghi thêm bảng không cần: t6, t8, t9, c8, k6, k9 (4 → 5 bảng); f4, f5, p3, p4, p8 (3 → 5 bảng). `\ghichuthietke` cập nhật số bảng, số bảng nhiễu. |
| 5. Cấp | 0 câu đổi cấp | t7 đã là Dễ từ v3; f9 giữ Trung bình (sai phạm vi cửa sổ là lỗi khó thấy, QUYET-DINH-CHUNG 2.1). Không câu nào lệch rõ ràng. BAN-DO-100-CAU.md không đổi. |
| 6. Thư mục gói 4 file | 20 file | `git mv` BANG-PHAN-CONG.md, DA-SUA.md, REVIEW-B.md, REVIEW-C.md của goi-1..5 sang `ho-so\goi-<k>\`. Sửa đường dẫn: README.md (cây thư mục), BRIEF-BIEN-THE-AN-BO-SUNG.md, BRIEF-SOAN-GOI.md. |

Kiểm: `kiem_tra_goi.py --chi-phan-tich` cả 5 gói → 0 lỗi, 0 cảnh báo (hết GOI_FILE_LA). `bien_dich.sh` cả 5 gói → 0 lỗi LaTeX, 0 cảnh báo aio-sql-cauhoi (chỉ còn Overfull hbox trình bày).

Chốt c5 (case Dễ, ERD 3 bảng; theo điều phối, quy chuẩn thắng): cả hai bước SQL đều cần đủ `users`, `purchases`, `player_daily` (b1 xếp nhóm theo giao dịch và đếm ngày hoạt động; b2 lấy ngày cài, giao dịch đầu, phút chơi ngày cài), nên không bỏ được bảng nào. Gói mẫu có case Dễ c2 với "ERD cố định 3 bảng có chữ trên đường nối" (một ERD chung cho mọi bước, mỗi bước tô bảng riêng). ERD của c5 khớp mẫu này: 3 bảng, 2 đường nối `1-n` có chữ, không bảng nhiễu. Giữ cấp Dễ: 3 bước theo CHOT, `IN`, truy vấn con, nối 1-n, 1 bẫy (nối thẳng nhân dòng), nên chưa đủ các trục để lên Trung bình. Đã ghi căn cứ (mẫu c2) vào `\ghichuthietke` của c5. Gói 3 kiểm lại: `--chi-phan-tich` ra 0 lỗi, 0 cảnh báo; biên dịch ra 0 lỗi LaTeX.
