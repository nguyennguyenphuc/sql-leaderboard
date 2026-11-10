# Hướng dẫn chung cho agent kiểm một nửa gói (vai B hoặc C)

Quy chuẩn (DOC_TRUOC.md): mỗi gói có 2 người kiểm, mỗi người nhận một nửa số câu và kiểm CẢ SQL lẫn nội dung/nghiệp vụ. Hạn: ~25 phút. Không bỏ bước nào dưới đây.

Thư mục gốc: C:\Cong viec\ProjectDA\sql-leaderboard\
- B nhận các câu thứ 1, 3, 5, … (theo thứ tự xuất hiện trong cau-hoi.tex); C nhận các câu thứ 2, 4, 6, … Case tính là một câu.
- Đọc trước: quy_chuan\CHOT-FORMAT-CAU-HOI.md, quy_chuan\Huong-dan-cho-team-noi-dung.md, quy_chuan\goi-cau-hoi-mau\HUONG_DAN.md, style\STYLE-<bo>.md (thuật ngữ + giọng văn chuẩn giáo trình + khuôn cấm), mysql\README.md hoặc mysql\README-<bo>.md (dữ liệu, biến thể ẩn), cong-cu\README.md.
- CHỈ ĐỌC gói: không sửa cau-hoi.tex / solution.sql. Ghi DUY NHẤT file goi-cau-hoi\<bo>\goi-<k>\REVIEW-<B|C>.md. Nháp ở cong-cu\ket-qua\review\<bo>-goi-<k>-<B|C>\.

## Với mỗi câu được giao (đủ 6 bước)
1. **Tự giải không xem đáp án:** chỉ đọc đề (tiêu đề, bối cảnh, yêu cầu, ERD, gợi ý), viết SQL MySQL của mình, chạy trên `<bo>` và `<bo>_hidden_1` (container sqllb-mysql, mạng sqllb, user sql_runner; không in mật khẩu).
2. **So với solution** trong solution.sql theo luật chấm (vị trí cột, thứ tự nếu thutu=co, sai số 0,01, NULL). Lệch mà cách hiểu của bạn hợp lý → lỗi đề mơ hồ (ghi cả hai kết quả).
3. **Kiểm wrong/starter:** mỗi `wrong` có phải lỗi thật hay gặp, có rớt ở biến thể nói trong `\ghichuthietke`; debug: starter sai đúng chỗ đề muốn; optimize: starter đúng kết quả nhưng vi phạm ràng buộc, ràng buộc ghi bằng lời rõ ràng.
4. **Nghiệp vụ:** khái niệm/công thức đúng chuẩn giáo trình và khớp cột thật; tab Nghiệp vụ không lộ kết quả; bối cảnh hợp lý với vai trò người hỏi; không nhắc kỹ thuật SQL ở bối cảnh/tiêu đề. Điểm nào không đủ hiểu biết nghiệp vụ → ghi "CẦN NGƯỜI NẮM DOMAIN", không tự xác nhận đạt.
5. **Đúng cấp và đúng module:** cấp (basic/easy/medium/hard) khớp 5 trục độ khó và ERD đúng cấp; câu dạy đúng kỹ năng của module.
6. **Giọng văn & thuật ngữ – CỬA CHẶN BẮT BUỘC** (giảng viên đặc biệt lưu ý giọng AI và dịch máy). Đọc TỪNG câu chữ của mọi trường (\tieude, \boicanh, yeucau, rangbuoc, nghiepvu, \khaibaokhainiem, \goiy, \luuy, \phuongan và lời giải thích, \ghichuthietke) như một giảng viên đại học Việt Nam đọc giáo trình. Đánh dấu NGUYÊN VĂN mọi chỗ:
   - **Giọng AI:** câu khẩu hiệu, câu dạy đời/kết luận chung chung cuối đoạn ("…mới là chìa khoá", "Đây là bước quan trọng…"), khuôn lặp giữa các câu (mở đề giống nhau, "Với mỗi…, hãy…", "Hãy…" mệnh lệnh dồn dập, "không chỉ… mà còn", liệt kê ba vế đều đặn), ẩn dụ ("gánh", "kéo", "bức tranh", "đòn bẩy", "chìa khoá", "insight" trong văn), từ đệm sáo rỗng ("đáng chú ý", "thú vị là", "một cách hiệu quả"), khuôn "mệnh đề: kết luận", dấu gạch ngang dài (—).
   - **Dịch máy:** trật tự từ theo tiếng Anh ("số mã hàng có doanh thu lớn hơn 0 của ngành"), danh từ hoá ("việc thực hiện sự phân tích"), bị động lủng củng ("được thực hiện bởi"), dịch từng chữ thuật ngữ ("định dạng cửa hàng" cho store format, "phần tử", "ứng viên", "cho ta"), đại từ "nó/họ" cho vật, giới từ thừa ("của", "về", "đối với" chồng nhau), câu quá dài nhiều mệnh đề nối bằng "mà", "trong khi".
   - **Lệch thuật ngữ** so với STYLE-<bo>.md mục A (cột "Không dùng"), viết tắt chưa giải nghĩa lần đầu, lẫn hai cách gọi cho cùng một khái niệm trong gói.
   - **Lời nhắn \boicanh** phải là lời nói công sở tự nhiên của người Việt (xưng hô anh/chị/em đúng vai), không văn viết cứng, không nhắc kỹ thuật SQL.
   Mỗi chỗ: trích nguyên văn → câu sửa tự nhiên, đúng chuẩn giáo trình. Câu còn BẤT KỲ chỗ nào thuộc mục này → kiểm nội dung = "Cần sửa" (không được Đạt).

## REVIEW-<B|C>.md
Bảng: mã | phiên bản (v1) | kiểm SQL: Đạt/Cần sửa + ghi chú | kiểm nội dung: Đạt/Cần sửa/CẦN NGƯỜI NẮM DOMAIN + ghi chú | đề xuất sửa cụ thể (trích nguyên văn → câu sửa). Cuối file: số câu Đạt / Cần sửa.

Thêm mục cuối file "Giọng văn": số chỗ giọng AI / dịch máy / lệch thuật ngữ, và các khuôn lặp lại trên nhiều câu của gói.

## Báo cáo cuối (≤ 150 từ)
Số câu Đạt/Cần sửa; lỗi nặng (chấm oan, solution sai, wrong không rớt, lộ kết quả) xếp trước; rồi số chỗ giọng AI/dịch máy kèm 2–3 trích dẫn tiêu biểu.
