# Chuẩn hoá cả bộ 100 câu theo quy chuẩn (quy_chuan.rar)

Thứ tự ưu tiên: `quy_chuan\` (CHOT-FORMAT-CAU-HOI.md, CHOT-LO-TRINH.md, Huong-dan-cho-team-noi-dung.md, goi-cau-hoi-mau\ – HUONG_DAN.md và cau-hoi.tex mẫu, lo-trinh-sql\assets\js\data.js) > QUYET-DINH-CHUNG.md > STYLE > brief. Đọc mục 0 của QUYET-DINH-CHUNG.md trước. Hạn ~30 phút.

Trước đây một số brief nội bộ lệch quy chuẩn; nay áp quy chuẩn cho MỌI câu của bộ (không chỉ câu đã sửa ở v3):
1. **Kết luận case** (mọi case, mọi bước kết luận `\phuongan`): phương án đúng (`\phuongan*`) mở bằng "Đúng: " rồi lời giải thích; phương án sai KHÔNG có tiền tố, nêu thẳng chỗ sai; mỗi lời giải thích ≤ 35 tiếng; ba phương án độ dài cân nhau, không lộ đáp án. Xem 4 case mẫu c1–c4 trong goi-cau-hoi-mau\cau-hoi.tex.
2. **Gợi ý** (`\goiy`): 1–2 nấc như HUONG_DAN; nấc cuối được nêu trọn một biểu thức một dòng (như mẫu w1, w3, o3, o4); không đưa cả câu SQL, không khung nhiều dòng. Gợi ý quá mơ hồ ở nấc cuối thì bổ sung cho bằng mẫu.
3. **Tiêu đề** ≤ 13 tiếng; câu Tối ưu được nêu ràng buộc; bối cảnh vẫn không nhắc kỹ thuật SQL.
4. **ERD cấp Khó**: chỉ khoá – không vẽ `\erdnoi`, cách nối ghi trong `\erdkhoa` (như mẫu w4, d4, o4); số bảng theo CHOT mục 3 (lời giải dùng ≤ 3 bảng thì thêm bảng nhiễu cho đủ 5). ERD các cấp khác giữ đúng CHOT mục 3.
5. **Cấp**: chấm lại theo Huong-dan mục 6 + QUYET-DINH-CHUNG.md mục 2 (bản đã sửa): mọi module có đủ 4 cấp; sửa lỗi một chỗ dễ thấy là Dễ. Chỉ đổi cấp khi rõ ràng lệch; cấp đổi thì ERD phải đổi theo, cập nhật BAN-DO-100-CAU.md, BANG-PHAN-CONG.md.
6. **Thư mục gói đúng 4 file** (CHOT-FORMAT mục 4): chuyển mọi file khác trong goi-cau-hoi\<bo>\goi-<k>\ (BANG-PHAN-CONG.md, DA-SUA.md, REVIEW-*.md, BAN-DO-GOI.md, KIEM-V3…) sang goi-cau-hoi\<bo>\ho-so\goi-<k>\ (giữ nguyên tên). Dùng `git mv` nếu file đã được git theo dõi (repo ở C:\Cong viec\ProjectDA\sql-leaderboard, KHÔNG commit). Sửa đường dẫn nhắc tới các file này trong README/BRIEF nếu có.

Không đổi SQL, mã, khoá chấm trừ khi bước 5 đổi cấp. Văn bản mới qua cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6, trừ các cụm mà gói mẫu dùng).
Kiểm: `--chi-phan-tich` cả 5 gói → 0 lỗi và hết cảnh báo GOI_FILE_LA; biên dịch lại 5 gói (`bash cong-cu/bien_dich.sh <goi> <ra tuyệt đối>`) → 0 lỗi LaTeX. Ghi goi-cau-hoi\<bo>\ho-so\CHUAN-HOA.md: số chỗ sửa theo 6 mục, các câu đổi cấp.

Báo cáo cuối (≤ 100 từ).
