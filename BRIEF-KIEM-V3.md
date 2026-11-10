# Kiểm độc lập các câu sửa ở vòng v3 (126 điểm)

Vai: người kiểm độc lập (không phải người sửa). Hạn ~20 phút. Chỉ ghi `goi-cau-hoi\<bo>\KIEM-V3.md`; KHÔNG sửa cau-hoi.tex / solution.sql.

**Thứ tự ưu tiên (sửa theo quy_chuan lúc 23:05): `quy_chuan\` (quy_chuan.rar: CHOT-FORMAT-CAU-HOI.md, CHOT-LO-TRINH.md, DOC_TRUOC.md, Huong-dan-cho-team-noi-dung.md, goi-cau-hoi-mau\HUONG_DAN.md, rồi gói mẫu cau-hoi.tex và lo-trinh-sql\assets\js\data.js) > QUYET-DINH-CHUNG.md > style\STYLE-<bo>.md > brief.** Đọc trước mục 0 của QUYET-DINH-CHUNG.md (8 điểm đã sửa theo quy chuẩn). Riêng các điểm đó, câu theo quy tắc cũ là "Cần sửa":
- Kết luận case: phương án đúng mở bằng "Đúng: "; phương án sai không có tiền tố ("Chưa đúng." là Cần sửa); lời giải thích ≤ 35 tiếng.
- Gợi ý: nấc cuối được nêu trọn biểu thức một dòng (không bắt lỗi "lộ giá trị lọc/tiêu chí hoà"); vẫn cấm cả câu SQL, khung nhiều dòng.
- Tiêu đề ≤ 13 tiếng; câu Tối ưu được nêu ràng buộc trong tiêu đề.
- ERD Khó: chỉ khoá, không `\erdnoi`, cách nối trong `\erdkhoa`.
- Cấp: không còn ngoại lệ "M7, M8 không có Dễ"; sửa lỗi một chỗ dễ thấy là Dễ.

1. Lấy danh sách câu đã đổi ở v3: `goi-cau-hoi\<bo>\QUYET-DINH-126*.md` và mục "Quyết định v3" trong DA-SUA.md từng gói (cột "đã sửa gì"). Bỏ qua mục "Giữ nguyên".
2. Với mỗi câu đã đổi SQL / yêu cầu / cấp / mã:
   - Đọc đề mới, tự viết SQL (không xem solution trước), chạy trên `<bo>` và `<bo>_hidden_1` (user sql_runner, mật khẩu trong mysql\.env – không in), so với solution theo luật chấm (thutu, saiso, NULL). Lệch mà cách hiểu hợp lý → "Cần sửa: đề mơ hồ".
   - Kết quả hai biến thể có khác nhau không; wrong mới có rớt; starter optimize vẫn đúng kết quả.
   - Quyết định có khớp căn cứ đã dẫn không (mở đúng file/URL được dẫn, đọc đoạn liên quan); có mâu thuẫn quy_chuan (trước) và QUYET-DINH-CHUNG.md (sau) không.
   - Mã đổi: grep mã cũ trong cả thư mục goi-cau-hoi\<bo>\ phải còn 0.
   - Cấp đổi: khớp Huong-dan mục 6 và thang trong QUYET-DINH-CHUNG.md mục 2 (bản đã sửa theo quy chuẩn).
3. Câu chỉ đổi lời: đọc phần mới theo cửa chặn giọng văn (BRIEF-KIEM-GOI.md bước 6).
4. KIEM-V3.md: bảng mã | đã đổi gì | kết quả tự giải (khớp/lệch) | căn cứ (khớp/không) | giọng văn | Đạt/Cần sửa + đề xuất cụ thể. Cuối file: số Đạt/Cần sửa.

Báo cáo cuối (≤ 100 từ): số câu kiểm, Đạt/Cần sửa, lỗi nặng.
