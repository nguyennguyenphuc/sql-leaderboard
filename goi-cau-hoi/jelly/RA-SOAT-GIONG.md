# Rà soát giọng văn cuối · bộ Game Jelly Trail (`jelly`, 100 câu, gói 1–5)

10/11/2026 · theo `BRIEF-RA-SOAT-GIONG.md`. Chuẩn: `style/STYLE-jelly.md` (A, B, C), `BRIEF-KIEM-GOI.md` bước 6.
Phạm vi: chỉ câu chữ trong `goi-1..5/cau-hoi.tex`. Không đổi SQL, `ma`, `thutu`, `saiso`, tên cột kết quả, số liệu, cấp,
cấu trúc LaTeX. Không mở `solution.sql`. Bản gốc trước khi sửa được lưu ngoài thư mục gói (bản sao tạm của người rà soát).

## 1. Số chỗ sửa

84 chỗ trên 81 dòng (gói 1: 11 dòng, gói 2: 11, gói 3: 14, gói 4: 20, gói 5: 25).

| Loại | Số chỗ | Nội dung chính |
|---|---|---|
| Khuôn lặp giữa các gói | 68 | 12 tab Nghiệp vụ mở bằng "Chọn …" (còn 3); 11 câu nhắc "theo tab Nghiệp vụ / công thức ở tab Nghiệp vụ"; câu kết lời nhắn của thực tập sinh ("Anh chị xem giúp em sai ở đâu.", "chỉ giúp em chỗ sai"); "Anh cần biết/xem…", "Chị cần biết…"; 6 dòng yêu cầu mở đầu "Sửa truy vấn dưới đây/khởi đầu để …" (còn 3 mỗi gói); 6 tiêu đề Sửa lỗi dạng "Danh sách … ra …"; 5 câu kết "viết lại/sửa giúp anh" của Data engineer gói 5; 8 lời giải thích phương án gói 5 thống nhất mở đầu "Đúng." / "Chưa đúng." như gói 1–4 |
| Thuật ngữ | 9 | IAP giải nghĩa lần đầu ở 5 câu (n9, a8, t5, c8, c9); "mua hàng trong game" thành "doanh thu IAP (mua hàng trong ứng dụng)" (j2); `daily_kpi` gọi thống nhất "bảng chỉ số ngày" (n4, p4 ×2); "bên LiveOps" thành "bên vận hành sự kiện (LiveOps)" (p7) |
| Giọng / lời nhắn nhắc kỹ thuật | 5 | "Em gửi truy vấn đây/bên dưới" trong lời nhắn thực tập sinh (n7, j7), "Em xem lại truy vấn này" của Quản lý UA (k7); 2 tiêu đề nêu kỹ thuật SQL ("không dùng tự nối bảng", "bỏ bước lọc trùng thừa") |
| Dịch máy | 2 | đại từ "nó" cho vật (r6); "Ở bước b1 và b2 của case" (c7) |

Không gặp: dấu gạch dài, "Với mỗi", "Hãy", "không chỉ… mà còn", "chìa khoá", "bức tranh", "insight", "đáng chú ý",
"được thực hiện bởi", "việc thực hiện", "đếm ngược". "Sự cố" trong cả bộ chỉ dùng cho crash (đã kiểm từng chỗ).

## 2. Mẫu quét trước / sau (cả bộ, bỏ dòng chú thích `%`)

Không có `cong-cu/quet_giong.py`, nên đếm bằng script grep theo danh sách của brief, cộng các khuôn review đã nêu.

| Mẫu | Trước | Sau |
|---|---|---|
| — | 0 | 0 |
| Với mỗi / Hãy / không chỉ / chìa khoá / bức tranh / insight / đáng chú ý | 0 | 0 |
| một cách | 3 | 3 |
| được thực hiện bởi / việc thực hiện | 0 | 0 |
| " nó " | 1 | 0 |
| đếm ngược | 0 | 0 |
| giúp anh | 28 | 26 |
| giúp chị | 25 | 26 |
| giúp em | 8 | 4 |
| xem giúp em ("Anh chị xem giúp em") | 3 | 0 |
| cả kỳ dữ liệu | 1 | 0 |
| theo tab Nghiệp vụ | 7 | 0 |
| tab Nghiệp vụ (mọi cách viết) | 14 | 3 |
| Sửa để ra đúng | 1 | 0 |
| không phải | 19 | 19 |
| Anh cần biết / Anh cần xem | 2 | 0 |
| cần biết (mọi vai) | 8 | 2 |
| mua hàng trong game / mua trong game | 1 | 0 |
| tab Nghiệp vụ mở bằng "Chọn …" | 15 | 3 |
| "Sửa truy vấn dưới đây để" (gói 1) | 6 | 3 |
| "Sửa truy vấn khởi đầu để" (gói 3) | 6 | 3 |
| "sai ở đâu" | 3 | 0 |
| "chỗ sai" | 6 | 2 |
| "truy vấn" trong `\boicanh` | 6 | 3 |

## 3. Mười ví dụ trước → sau

1. g2 s9 `\boicanh`: "…mà nhóm đông nhất lại không có tên. Anh chị xem giúp em sai ở đâu." → "…mà nhóm đông nhất lại không có tên kênh. Mai em phải nộp báo cáo rồi, em chưa biết sai ở bước nào."
2. g4 f9 `\boicanh`: "…mà gói nào cũng ra 100\%. Anh chị xem giúp em sai ở đâu." → "…mà gói nào cũng ra 100\%. Em chưa hiểu sao lại như vậy."
3. g4 f4 `\boicanh`: "Em lập giúp anh bảng cho cả kỳ để anh xem doanh thu tăng giảm thế nào từ đầu tháng 7." → "Em lập giúp anh bảng từng tuần từ đầu tháng 7 tới nay, để anh xem doanh thu lên xuống ra sao."
4. g1 r4 `\boicanh`: "Anh cần mười ngày chiến dịch này tốn nhiều tiền nhất kể từ hôm đó tới nay." → "Em lấy giúp anh mười ngày chiến dịch này tốn nhiều tiền nhất, tính từ hôm đó tới nay."
5. g3 j2 `\boicanh`: "…có bao nhiêu người mua hàng trong game và mua hết bao nhiêu tiền." → "…mỗi kênh có bao nhiêu người chơi trả tiền và mang về bao nhiêu doanh thu IAP (mua hàng trong ứng dụng)."
6. g4 t3 yêu cầu: "Tính số người cài, tỷ lệ giữ chân D1 và D7 của từng kênh thu hút, theo tab Nghiệp vụ." → "Tính số người cài, tỷ lệ giữ chân D1 và D7 (phần người cài còn hoạt động đúng ngày thứ 1, ngày thứ 7 sau ngày cài) của từng kênh thu hút."
7. g5 k8 yêu cầu: "Sửa để ra đúng. Giữ tên cột; …" → "Truy vấn đang tính sai; sửa lại và giữ tên cột; …"
8. g4 c8 tab Nghiệp vụ: "Chọn hướng xử lý cho tháng 9, giữa tăng số người chơi hoạt động và tăng doanh thu trên mỗi người chơi." → "Quyết định tháng 9 nên ưu tiên tăng số người chơi hoạt động hay tăng doanh thu trên mỗi người chơi."
9. g5 p4 tiêu đề: "Doanh thu luỹ kế trong tháng không dùng tự nối bảng" → "Doanh thu luỹ kế trong tháng cho biểu đồ tiến độ" (tiêu đề không nêu kỹ thuật SQL).
10. g1 r6 gợi ý: "Ngày bắt đầu của nó có nằm trong kỳ không?" → "Ngày bắt đầu của sự kiện đó có nằm trong kỳ không?"

Thêm: g3 q8 "Anh cần danh sách giao dịch gần nhất của từng người chơi trả tiền ở Việt Nam để gửi ưu đãi mua lại." → "Anh đang soạn ưu đãi mua lại cho người chơi trả tiền ở Việt Nam, dựa trên giao dịch gần nhất của từng người."; g5 k7 yêu cầu "(theo tab Nghiệp vụ)" → "hai lần độ lệch chuẩn tổng thể của chi ngày" (giữ ý dùng độ lệch chuẩn tổng thể, khớp khái niệm và lời giải).

## 4. Chỗ còn để lại, kèm lý do

- "một cách" (3): cả 3 nằm trong khái niệm `thu-nghiem-ab` ("mỗi nhánh nhận một cách thiết kế khác nhau"), nghĩa là "một phương án thiết kế", không phải trạng từ đệm. Khái niệm chép nguyên từ STYLE-jelly mục E.
- "không phải" (19): đều là câu phân biệt khái niệm cần thiết ("thua do hết lượt đi … không phải bỏ cuộc", "cờ … không phải giao dịch tiền", "ROAS chung là tổng chia tổng, không phải trung bình bốn ROAS"). Không phải khuôn kết luận.
- "giúp anh/chị/em" (56): lời nhờ tự nhiên của người Việt nơi công sở, khớp ví dụ đạt ở STYLE-jelly B.4. Đã bỏ các câu kết giống hệt nhau giữa gói (mục 1); phần còn lại nằm trong câu khác nhau.
- "truy vấn" trong `\boicanh` (3, cộng 4 chỗ "Truy vấn …" ở đầu câu): đều là lời của Data engineer (câu Tối ưu, STYLE-jelly B.3) hoặc Trưởng nhóm phân tích dữ liệu (p8), nói về truy vấn đang chạy cần tối ưu. Không nêu tên kỹ thuật SQL.
- "tab Nghiệp vụ" (3): 2 trong `\ghichuthietke` (ghi chú cho người duyệt); 1 ở g2 a6 "(công thức ở tab Nghiệp vụ)" để chỉ tỷ lệ sự cố trên 1.000 phiên.
- "Chọn …" ở tab Nghiệp vụ (3): g2 a2, g4 f1, g5 k7. Mỗi gói còn tối đa 1 chỗ, động từ hợp nghĩa (chọn gói, chọn ba màn, chọn ngày).
- "QA" (đội QA, nhóm QA, Kỹ sư QA): tên vai trò và tên đội trong studio (STYLE-jelly B.3), không giải nghĩa thêm.
- Lời nhắn của Data engineer ở g5 p5, p9 có nêu nguyên nhân chậm ("lấy kênh từ bảng hoạt động ngày", "lọc trùng trên bảng hoạt động ngày"). Đây là nội dung đề câu Tối ưu, đã qua 2 vòng review, nên không đổi.

## 5. Kiểm sau khi sửa

- Kiểm tĩnh `kiem_tra_goi.py --chi-phan-tich` (ra `cong-cu/ket-qua/jelly-goi-<k>-giong/`): gói 1–5 đều "KIEM TRA: 0 loi".
- Biên dịch XeLaTeX `bien_dich.sh` (ra `cong-cu/ket-qua/bien-dich/jelly-goi-<k>/`): cả 5 gói **0 lỗi LaTeX, 0 ký tự thiếu trong font**. Số trang PDF: 43, 45, 49, 55, 57. Gói 5 được biên dịch lại sau lần sửa cuối. Còn các cảnh báo Overfull hbox (dòng SQL hoặc ERD dài, chỉ ảnh hưởng trình bày), giống như trước khi sửa.
