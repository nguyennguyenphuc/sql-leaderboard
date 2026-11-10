# Bổ sung biến thể ẩn `<bo>_hidden_1` để chép kết quả Chạy thử không qua được

Vấn đề: `<bo>_hidden_1` hiện chỉ đổi bảng sự kiện chính, nên các câu chỉ dùng bảng danh mục / bảng phụ cho kết quả giống hệt public; học viên chép kết quả Chạy thử thành hằng số vẫn qua (cả câu optimize). Giảng viên đã duyệt sửa ngay. Hạn ~35 phút.

## Đầu vào
- Danh sách câu bị trùng: trong goi-cau-hoi\<bo>\goi-*\DA-SUA.md (mục "Chờ giảng viên", "hidden-1 trùng public / biến thể giống hệt") và REVIEW-B/C.md. Tự kiểm lại cho đủ: với MỌI câu của 5 gói, chạy khối `solution` trên `<bo>` và `<bo>_hidden_1` (so md5 kết quả) để có danh sách câu trùng hiện tại. Chạy từng câu, KHÔNG chạy bộ kiểm cả gói.
- mysql\README.md hoặc README-<bo>.md, mysql\<bo>\03_bien_the_an_*.sql (cách dựng hiện tại). Mật khẩu root trong mysql\.env – KHÔNG in ra (dùng `docker exec -e MYSQL_PWD=...`).

## Cách sửa (chỉ trên `<bo>_hidden_1`, KHÔNG đụng `<bo>` public)
1. Viết `mysql\<bo>\04_bo_sung_bien_the_<bo>.sql` (scm: `mysql\04_bo_sung_bien_the_scm.sql`), chạy được lặp lại (idempotent: xoá dòng giả cũ theo khoá riêng rồi chèn lại), và nối lệnh chạy nó vào cuối quy trình dựng hidden trong README.
2. Ưu tiên theo thứ tự:
   - **Thêm dòng danh mục giả hợp lý** (khách hàng, chi nhánh, mặt hàng, kho, nhân viên, chiến dịch…) với khoá dễ nhận (ví dụ tiền tố/hậu tố riêng, id lớn), giá trị khớp các bộ lọc mà câu hỏi dùng (tên chứa 'Quận', NULL ở cột câu hỏi đếm NULL, nhóm/ngành hàng câu hỏi lọc, ngày trong khoảng câu hỏi xét…) để kết quả câu đó đổi. Dòng giả không có giao dịch thì không phá khoá ngoại; nếu câu cần dòng sự kiện thì thêm dòng sự kiện trỏ tới dòng giả.
   - **Bảng phụ không có bảng nào trỏ tới** (vd. scm: transactions, oil, holidays, warehouse_daily_ops, staffing_plan, shipments; aivb: tiền gửi/khách hàng…; xem FK thật): được bỏ một phần nhỏ dòng theo quy tắc cố định (vd. khoá % 10 = 7) hoặc sửa nhẹ giá trị ở vài dòng.
   - Không phá cặp hoà hạng và dòng ngoài cận trên đã có. Không làm solution của câu nào ra 0 dòng. Không đổi kiểu cột, không tạo bảng mới. View (jelly) phải còn chạy.
3. Áp dụng vào `<bo>_hidden_1`. Rồi chạy lại khối solution của MỌI câu trên hai biến thể: liệt kê câu còn trùng và lý do (vd. câu đếm theo bảng lịch cố định). Mục tiêu: không còn câu nào trùng, trừ khi không thể làm tự nhiên – ghi rõ.
4. Với các câu có `wrong` thiết kế "chỉ rớt ở hidden-1": chạy lại wrong đó trên hai biến thể để chắc vẫn rớt; câu nào hỏng thì ghi tên (người điều phối sẽ cho sửa).
5. Cập nhật bảng "Biến thể · khác public · bắt lỗi gì" trong README tương ứng (thêm các thay đổi mới, số dòng thật). KHÔNG sửa cau-hoi.tex / solution.sql.

## Báo cáo cuối (≤ 150 từ)
Các thay đổi đã thêm (bảng · số dòng), số câu trùng trước → sau, các câu còn trùng và lý do, wrong nào không còn rớt.
