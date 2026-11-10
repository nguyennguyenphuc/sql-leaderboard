# Viết lại để MỖI module có đủ 4 cấp (theo quy chuẩn)

Giảng viên đã chốt: theo `quy_chuan\lo-trinh-sql\assets\js\data.js` (62 bài), mỗi module đi đủ Cơ bản → Dễ → Trung bình → Khó. Bộ đề hiện chia cấp theo module (M1–3 chỉ Cơ bản/Dễ, M7–10 chỉ Trung bình/Khó) – lệch quy chuẩn. Thứ tự ưu tiên: `quy_chuan\` > QUYET-DINH-CHUNG.md (mục 0 trước) > STYLE-<bo>.md > brief. Hạn ~60 phút.

## Phạm vi của bạn: MỘT gói (2 module × 9 câu + 2 case). Không sửa gói khác, không sửa database/biến thể ẩn/file 04.

## Mục tiêu cấp cho mỗi module (9 câu, không tính case)
**2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó.** Giữ tỷ lệ hình thức của module (M1–9: ~6 write + 3 debug; M10: optimize theo CHOT mục 4 – optimize có mẫu Cơ bản/Trung bình/Khó). Case giữ nguyên cấp.

## Cách làm
1. Đọc: CHOT-FORMAT-CAU-HOI.md (mục 3 ERD theo cấp, mục 4 optimize), Huong-dan-cho-team-noi-dung.md (mục 5 ERD, mục 6 năm trục độ khó), gói mẫu cau-hoi.tex, và trong data.js các bài của ĐÚNG module bạn làm ở từng cấp (đề, kỹ năng, bảng) để biết "Khó của Retrieval", "Cơ bản của Window"… trông thế nào. Đọc QUYET-DINH-CHUNG.md mục 0–2.
2. Đếm cấp hiện tại của 2 module. Chọn số câu tối thiểu phải đổi: câu ở cấp thừa → viết lại thành cấp thiếu. Ưu tiên câu có nội dung dễ nâng/hạ (thêm bảng, thêm bẫy thật, thêm bước; hoặc bỏ bớt bảng, bỏ bẫy, một lỗi dễ thấy). Câu đổi cấp phải thật sự khác độ khó theo 5 trục (≥ 3/5 trục khớp cấp mới), KHÔNG chỉ đổi nhãn.
3. Viết lại mỗi câu được chọn đủ 8 phần như câu gốc: tiêu đề (≤ 13 tiếng), bối cảnh, yêu cầu (nêu rõ thứ tự + tiêu chí phụ, làm tròn, NULL), ERD đúng CHOT mục 3 cho cấp mới (Cơ bản: bảng có giá trị mẫu; Dễ: 2 bảng chữ trên đường nối; Trung bình: 3–4 bảng ký hiệu; Khó: 5–7 bảng chỉ khoá, không `\erdnoi`, cách nối ở `\erdkhoa`), nghiệp vụ không lộ kết quả, gợi ý 1–2 nấc (nấc cuối một biểu thức), ghi chú thiết kế (cấp, 5 trục, bẫy, biến thể). solution/starter/wrong mới trong solution.sql: mỗi wrong là lỗi thật hay gặp, rớt ≥ 1 biến thể; kết quả public ≠ hidden-1 (dùng dữ liệu biến thể hiện có – xem README biến thể); solution và cách giải tự nhiên chạy < 10 giây.
4. Mã `ma`: giữ tiền tố module và số; đổi slug nếu nội dung đổi, đồng bộ ở cau-hoi.tex, solution.sql, ho-so\goi-<k>\BANG-PHAN-CONG.md, ho-so\goi-<k>\DA-SUA.md, ..\BAN-DO-100-CAU.md (chỉ dòng của gói bạn).
5. Không trùng ô (dạng × mảng × cấp × hình thức) trong gói; kiểm với BAN-DO-100-CAU.md của bộ và tránh trùng gói khác nếu thấy (agent khác đang sửa song song – ghi chú nếu nghi trùng).
6. Văn bản mới qua cửa chặn giọng văn (BRIEF-KIEM-GOI bước 6, trừ các cụm gói mẫu dùng) và đúng STYLE-<bo>.md.
7. Kiểm: bộ kiểm ĐẦY ĐỦ cho gói (lệnh một gói trong cong-cu\README.md, `--ra cong-cu/ket-qua/cap-do/<bo>-goi-<k>`) → "KIEM TRA: 0 loi"; biên dịch `bash cong-cu/bien_dich.sh <gói> <ra tuyệt đối>` → 0 lỗi LaTeX. Thư mục gói vẫn đúng 4 file.
8. Ghi `ho-so\goi-<k>\DA-SUA.md` mục "v4 – đủ 4 cấp mỗi module": bảng mã cũ → mã mới | cấp cũ → mới | đổi gì | 5 trục. Cập nhật BANG-PHAN-CONG.md (v4).

Báo cáo cuối (≤ 120 từ): phân bố cấp mỗi module trước → sau, số câu viết lại, kết quả bộ kiểm, biên dịch, câu nghi trùng ô.
