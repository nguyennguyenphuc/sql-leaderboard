# Kiểm độc lập vòng cuối (v3 + chuẩn hoá + v4 đủ 4 cấp)

Vai: người kiểm B hoặc C (không phải người soạn). Thứ tự ưu tiên: `quy_chuan\` > QUYET-DINH-CHUNG.md (mục 0 trước) > STYLE-<bo>.md > brief. Hạn ~30 phút. Chỉ ghi `goi-cau-hoi\<bo>\ho-so\KIEM-V4-<B|C>.md`; KHÔNG sửa cau-hoi.tex / solution.sql.

## Danh sách câu phải kiểm
Gom từ `ho-so\goi-*\DA-SUA.md`: mục "v4 – đủ 4 cấp mỗi module" (câu viết lại / đổi cấp) + mục "Quyết định v3" (câu đổi SQL/yêu cầu/cấp/mã; bỏ "giữ nguyên"). Sắp theo gói rồi theo thứ tự trong cau-hoi.tex, đánh số 1, 2, 3…; **B nhận số lẻ, C nhận số chẵn**.

## Với mỗi câu (đủ 6 bước như BRIEF-KIEM-GOI.md)
1. Tự giải không xem đáp án (chạy trên `<bo>` và `<bo>_hidden_1`, user sql_runner, mật khẩu trong mysql\.env – không in).
2. So với solution theo luật chấm (thutu, saiso, NULL). Lệch hợp lý → "đề mơ hồ".
3. Wrong/starter: lỗi thật hay gặp, rớt đúng biến thể; optimize: starter đúng kết quả, vi phạm ràng buộc; kết quả public ≠ hidden-1; solution < 10 giây.
4. Nghiệp vụ đúng (STYLE, tài liệu dự án), không lộ kết quả.
5. **Cấp**: khớp ≥ 3/5 trục của cấp ghi (Huong-dan mục 6), ERD đúng CHOT mục 3 cho cấp đó; câu viết lại phải thật sự khác độ khó, không chỉ đổi nhãn. Module vẫn đủ 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó.
6. Giọng văn (cửa chặn BRIEF-KIEM-GOI bước 6, trừ cụm gói mẫu dùng); kết luận case đúng quy chuẩn ("Đúng: ", 3 phương án, ≤ 35 tiếng); gợi ý nấc cuối một biểu thức; tiêu đề ≤ 13 tiếng.
Thêm: kiểm trùng ô (dạng × mảng × cấp × hình thức) trong cả bộ của các câu mình nhận.

## KIEM-V4-<B|C>.md
Bảng: mã | gói | cấp | tự giải khớp? | biến thể khác? | cấp đúng? | giọng văn | Đạt/Cần sửa + đề xuất cụ thể. Cuối: số Đạt/Cần sửa, các ô trùng.

Báo cáo cuối (≤ 100 từ): số câu, Đạt/Cần sửa, lỗi nặng.
