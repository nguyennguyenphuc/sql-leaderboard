# Đã sửa · gói 1 · HR Analytics (`hr`) · v2

Theo `REVIEW-B.md`, `REVIEW-C.md` (10/11/2026). Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/hr-goi-1/`: gồm 10 câu có sửa SQL hoặc sửa yêu cầu (r1, r4, r9, n1, n2, n3, n5, n7, n9, c2). Kết quả chạy thật: **KIEM TRA: 0 loi**.
- **Cả gói** chạy `--chi-phan-tich`: **KIEM TRA: 0 loi**.
- Không đổi `ma` nào.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| `hr-r1-lam-them-vn-thang-12` | (B1) `\ghichuthietke` sửa cho đúng dữ liệu: hidden-1 bỏ E03307. (B2) `\luuy` bỏ câu về giá trị chữ, thay bằng giới hạn 40 giờ/tháng (BLLĐ 2019, Điều 107). (B3) Tiêu đề đổi thành "… làm thêm từ 30 giờ trong tháng 12/2025?". (B4) Bối cảnh viết lại theo dạng hỏi thẳng. (B.8) Yêu cầu thêm "kể cả người nghỉ việc trong tháng". Dòng mục đích của tab Nghiệp vụ không còn mở bằng "Chọn". | gói tạm |
| `hr-r2-nghi-tu-nguyen-thang-9` | (C) Bối cảnh bỏ ý "tháng 9 số người nghỉ tăng", vì ý này lộ đáp án của C1. Câu nhờ chuyển từ "Em lọc giúp anh" sang nêu thẳng nhu cầu. `\ghichuthietke` sửa chữ "lẫn". | tĩnh |
| `hr-r3-tuyen-qua-gioi-thieu` | (B) Tiêu đề đổi thành "Yêu cầu tuyển dụng nào năm 2025 tuyển qua giới thiệu nội bộ?". Bối cảnh viết lại theo dạng hỏi thẳng. | tĩnh |
| `hr-r4-sales-cong-tac-indonesia` | (C) Tiêu đề đổi thành "Account Executive nào ở Indonesia đi công tác nhiều nhất?". Thống nhất cách gọi "phòng Kinh doanh (`'Sales'`)". Yêu cầu ghi rõ `snapshot_month`, `country`. `\ghichuthietke` sửa chữ "lẫn" và ghi lý do giữ cấp Dễ. Bối cảnh mở bằng hạn chốt. | gói tạm |
| `hr-r5-tiem-nang-cao-chua-de-bat` | (B1, B2) Tiêu đề thêm "có". Lời nhắn viết lại thành "những người có tiềm năng cao nhưng đã hai năm trở lên chưa được đề bạt"; câu nhờ không dùng "Em lọc giúp". Dòng mục đích không còn mở bằng "Chọn". Điểm B3 chuyển sang mục "Chờ giảng viên". | tĩnh |
| `hr-r6-dong-bang-tuyen-thay-the` | (C) Bối cảnh đổi "đang không được tuyển thay thế" thành "đang bị dừng tuyển thay thế", viết theo dạng hỏi. Bỏ `\khainiem{vi-tri-then-chot}` và bỏ luôn khai báo của khái niệm này (gói không còn câu nào dùng). `\ghichuthietke` sửa chữ "lẫn" và ghi lý do giữ cấp Dễ. Không đưa "`backfill_allowed` lưu chữ" vào `\luuy`, để gợi ý 1 vẫn có giá trị (theo mục chung của B: `\luuy` không trả lời trước gợi ý). | tĩnh |
| `hr-r7-danh-sach-nghi-huu-rong` | (B1) `\luuy` bỏ giá trị `'Retired'` để không lộ lời giải, thay bằng ý nghiệp vụ. (B2) Bỏ các chữ "Bảng không phân biệt…". Bối cảnh đổi câu kết, không còn "Anh chị xem giúp em". `\ghichuthietke` sửa chữ "lẫn". | tĩnh |
| `hr-r8-yeu-cau-thang-3-thieu-ngay` | (C) Tiêu đề chỉ nêu triệu chứng: "Số người bắt đầu làm việc tháng 3/2025 ra thiếu". Mọi chỗ thống nhất dùng "bắt đầu làm việc". `\luuy` thêm ý "mỗi yêu cầu tuyển được một người". Dòng mục đích đổi thành "Chốt danh sách … bảng chấm công tháng 3/2025". Bối cảnh viết lại. Cấp chuyển sang mục "Chờ giảng viên". | tĩnh |
| `hr-r9-loc-tp-hcm-ra-0` | (B2, nguy cơ chấm oan) Yêu cầu ghi "có tên trong tháng 12/2025 (kể cả người nghỉ việc trong tháng)" và "không tính người đúng 40 điểm". (B1, sai cấp) Giữ cấp Dễ nhưng starter thêm lỗi thứ hai `engagement_score <= 40`; thêm `\goiy` nấc 2; yêu cầu ghi "Sửa hai lỗi". Bối cảnh viết lại; dòng mục đích không còn mở bằng "Chọn". | gói tạm (starter 166 so với solution 152 ở public) |
| `hr-n1-vang-mat-binh-quan-thang-6` | (C) `\luuy` đổi "dòng trống" thành "dòng thiếu dữ liệu chấm công". Bài sai `coi_o_trong_la_0` ra trùng kết quả với `chia_cho_moi_dong`, nên thay bằng `quen_loc_thang`. Bối cảnh viết lại theo dạng hỏi thẳng. | gói tạm |
| `hr-n2-thieu-diem-gan-ket` | (B, nhẹ) Ý "so sánh bằng với NULL không bao giờ đúng" chuyển từ `\luuy` sang `\goiy` 2; `\luuy` chỉ còn ý nghiệp vụ. (B.8) Yêu cầu thêm "kể cả người nghỉ việc trong tháng". Bối cảnh mở bằng hạn nộp. Dòng mục đích không còn mở bằng "Chọn". | gói tạm |
| `hr-n3-nhom-compa-ratio` | (C) Tiêu đề đổi thành "… thấp hơn mức thị trường". Giải nghĩa compa-ratio ở lần đầu nhắc trong yêu cầu. `\goiy` 2 bỏ khuôn "mệnh đề: kết luận". `\luuy` bỏ chữ "có" bị lặp. | gói tạm |
| `hr-n4-ty-le-nghi-tu-nguyen-2024` | (B, nhẹ) Lời nhắn đổi thành "tỷ lệ người nghỉ tự nguyện trên tổng số người nghỉ năm 2024". | tĩnh |
| `hr-n5-co-hieu-suat-cao-thieu-diem` | (C) Tiêu đề đổi thành câu hỏi. Bối cảnh dùng tên đầy đủ của cờ, đổi "dòng" thành "trường hợp". Yêu cầu đổi thành "số dòng thoả điều kiện trên, lần lượt của năm 2024 và năm 2025". Bài sai `so_bang_null` ra trùng kết quả với `<> 4`, nên thay bằng `quen_loc_co` (743/726 so với 148/183). `\luuy` bỏ phần giảng NULL; ý này chuyển vào `\goiy` 1. | gói tạm |
| `hr-n6-nhan-loai-yeu-cau` | (B1) Lời nhắn hỏi đúng "chi phí bình quân một yêu cầu". (B2) `\ghichuthietke` ghi đúng: dùng `requisition_type` cũng ra cùng kết quả. `\luuy` bỏ phần giảng NULL và chuỗi rỗng; ý này chuyển vào `\goiy` 1. | tĩnh |
| `hr-n7-gio-dao-tao-thap` | (C) Yêu cầu sắp lại trật tự từ: "số giờ đào tạo bình quân của một nhân viên trong 6 tháng gần nhất, tính tại tháng 12/2025". Bối cảnh bỏ các chữ lặp "đào tạo", "số". | gói tạm |
| `hr-n8-dem-tiem-nang-thieu` | (B1) Tiêu đề đổi thành "Số người đủ điều kiện chương trình phát triển bị thiếu". (B2) `\luuy` đổi sang ý nghiệp vụ (ba mức tiềm năng, người chưa đánh giá vẫn đủ điều kiện); ý `AND` tính trước `OR` chuyển sang `\goiy` 2. Bối cảnh bỏ câu "em kiểm tra lại giúp chị". | tĩnh |
| `hr-n9-tien-lam-them-lech` | (C, không bắt buộc) "giả định của đề" đổi thành "giả định sau". Dòng mục đích bỏ chữ "chi phí" bị lặp. Mốc 176 giờ chuyển sang mục "Chờ giảng viên". | gói tạm |
| `hr-c1-thang-nghi-nhieu-nhat` | (B1) `\luuy` bỏ khuôn "Muốn … phải …" và chữ "rời đi". (B2) Lời giải thích phương án 2 đổi "Quân số tháng 12" thành "Tháng 12 có nhiều nhân viên có tên nhất". Dòng mục đích không còn mở bằng "Chọn". | tĩnh |
| `hr-c2-thieu-diem-gan-ket-theo-phong` | (C, sai số liệu) Lời giải thích phương án 2 đổi thành "tỷ lệ thiếu của phòng này nằm giữa các phòng khác". Yêu cầu b1 đổi thành "số dòng thiếu điểm chia tổng số dòng của phòng ban". (K32) Rút ngắn phương án đúng còn một vế; hai phương án sai cũng rút ngắn để ba phương án dài gần bằng nhau. Phương án 3 giải thích thêm rằng điểm hằng tháng không lấy từ khảo sát. Đổi "dồn vào" thành "tập trung ở". `\luuy` rút còn "Mỗi phòng ban có quy mô khác nhau." | gói tạm |

Khuôn lặp đã phá:
- **Bối cảnh:** mười câu (r1, r2, r3, r4, r5, r6, n1, n2, n3, n5) không còn kết bằng "Em lọc / tính / đếm giúp…". Các câu này đổi sang dạng hỏi thẳng, hoặc nêu hạn chốt, cuộc họp.
- **Câu Sửa lỗi:** chỉ n7 còn kết bằng "Anh chị xem giúp em sai ở đâu" (review đề xuất); r7, r8, r9 đổi cách kết.
- **Dòng mục đích của tab Nghiệp vụ:** chỉ còn r2 mở bằng "Chọn" (trước có 8 câu).
- **`\luuy` giảng SQL:** ở r1, r7, n2, n5, n6, n8, phần giảng kỹ thuật SQL chuyển sang `\goiy`.

## Chờ giảng viên

1. **r5 · cách hiểu "hai năm chưa được đề bạt" (B, CẦN NGƯỜI NẮM DOMAIN).** Có 18.981 dòng `months_since_promotion > tenure_months`, tức là số tháng này tính cả thời gian trước khi vào công ty. Kết quả của câu không bị ảnh hưởng, vì 0 người có thâm niên dưới 24 tháng. Giữ nguyên đề.
2. **n9 · mốc 176 giờ (C, CẦN NGƯỜI NẮM DOMAIN).** NĐ 145/2020 Điều 55 tính theo số ngày làm việc bình thường của doanh nghiệp (thường 24–26 ngày). Đề đã ghi rõ đây là giả định. Giữ nguyên.
3. **Cấp Dễ ở Module 1–2 (B, mục chung; C ở r4, r6, r8).** Các câu này chỉ dùng 1 bảng, không `JOIN`, vì module chưa học nối bảng. Đã ghi lý do vào `\ghichuthietke` của r4, r6, r8. Giảng viên cần chốt có chấp nhận cách hiểu này không, và có hạ r8 xuống Cơ bản không.
4. **"Chưa đúng." ở phương án sai (C).** Reviewer đề nghị bỏ, nhưng STYLE-scm G.4 (quyết định tạm, ưu tiên 1 theo STYLE-hr) quy định "Đúng. …" / "Chưa đúng. …". Vì vậy C1, C2 giữ "Chưa đúng.", chờ giảng viên chốt.
5. **Tiêu đề r1, r3 dài 12 tiếng** (theo câu sửa của B), vượt giới hạn 10 tiếng của B.1. Nếu cần rút thì có thể đổi thành "Ai ở Việt Nam làm thêm từ 30 giờ tháng 12/2025?".
