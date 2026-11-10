# Đã sửa · Marketing gói 1 (v1 → v2)

Theo `REVIEW-B.md`, `REVIEW-C.md` và `BRIEF-SUA-GOI.md`. Không sửa database hay biến thể ẩn. Không đổi mã câu.

Kiểm lại:
- Gói tạm `cong-cu/ket-qua/sua/mkt-goi-1/` (r2, r5, r8, tức các câu sửa SQL hoặc yêu cầu), chạy thật trên `mkt` và `mkt_hidden_1`: **KIEM TRA: 0 loi**. r2 public 3 dòng, hidden-1 2 dòng; r5 19/18; r8 47/42. Mọi wrong rớt ở cả hai biến thể.
- Cả gói `--chi-phan-tich`: **KIEM TRA: 0 loi**, 20 câu 0 lỗi 0 cảnh báo. Còn cảnh báo `GOI_FILE_LA` vì các file .md ngoài gói.
- Biên dịch: `cong-cu/bien_dich.sh` → PDF 43 trang, 0 lỗi LaTeX, 0 ký tự thiếu (`cong-cu/ket-qua/bien-dich/mkt-goi-1/`).

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| `mkt-r1-influencer-purplle-thang-1` | B(1) tiêu đề "có trên 98.000 lượt hiển thị trong tháng 1/2025"; B(2) dòng mở nghiệp vụ (mở bằng "Quyết định"); B(3) "ký lại hợp đồng"; B(4) giải nghĩa Influencer lần đầu; B(5) gợi ý 1 "điều kiện ngày em đang viết". Phá khuôn "X là …, không phải Y" ở `\luuy`, bỏ câu `\luuy` nói sẵn cận dưới, cận trên. | phân tích tĩnh |
| `mkt-r2-working-women-tamil-tira` | C(1) đổi Tamil sang Hindi (`language_id = 3`) ở tiêu đề, bối cảnh, yêu cầu, ERD, solution, wrong: hidden-1 giờ khác public; C(2) tiêu đề; C(3) dòng mở nghiệp vụ; C(4) `\luuy` "Bảng chiến dịch có hai cột…"; C(5) ghi chú "thu hẹp còn một ngày", ghi lại lý do đổi. | bộ kiểm gói tạm: 0 lỗi |
| `mkt-r3-roi-thap-nhat-nykaa-q4` | B(1) tiêu đề "10 chiến dịch có ROI thấp nhất…"; B(2) gợi ý 1; B(3) ERD bỏ mã chiến dịch mẫu không khớp dòng thật (giữ giá trị mẫu chung). Dòng mở nghiệp vụ đổi sang "Xác định". | phân tích tĩnh |
| `mkt-r4-email-chuyen-doi-cao` | C(1) bối cảnh bỏ "mang về nhiều đơn nhất"; C(2) thống nhất "chiến dịch loại Email" ở tiêu đề, nghiệp vụ, "chiến dịch email" chỉ trong lời nhắn; C(3) gợi ý 1 "Kênh Email có trùng với loại Email không?". | phân tích tĩnh |
| `mkt-r5-chien-dich-30-ngay-cuoi-ky` | B(1) bối cảnh "còn chạy tới gần cuối tháng 6"; B(2) dòng mở nghiệp vụ; B(3) bỏ "kể cả ngày 28/5/2025" khỏi yêu cầu (giữ cấp Dễ, bẫy `>`/`>=` cần tự đọc). Đổi vai trùng: Chị Hạnh giữ "Trưởng phòng marketing số". | bộ kiểm gói tạm: 0 lỗi |
| `mkt-r6-diem-tuong-tac-tu-30` | C(1) `\luuy` bỏ câu lộ bẫy "gồm cả điểm đúng 30", giữ ý nghiệp vụ; Anh Duy đổi vai thành "Giám đốc marketing" (hết hai người cùng vai). C(2) cấp: không hạ được xuống Cơ bản vì trùng ô với r1 (write, basic, A1, marketing), ghi vào "Chờ giảng viên". | phân tích tĩnh |
| `mkt-r7-paid-ads-ra-rong` | Đạt; sửa tuỳ chọn B: "hôm đó Nykaa mở rất nhiều chiến dịch". | phân tích tĩnh |
| `mkt-r8-thang-2-thieu-ngay-cuoi` | C(1) `\luuy` không còn nêu cách sửa (để cho gợi ý 2); C(2) bỏ wrong `van_bo_ngay_28` vì trùng kết quả starter, giữ `between_toi_ngay_1_3`; ghi chú cập nhật. | bộ kiểm gói tạm: 0 lỗi |
| `mkt-r9-youth-hoac-working-women-thua` | B(1) dòng mở nghiệp vụ không còn gọi phụ nữ đi làm là "khách trẻ"; B(2) bối cảnh "Danh sách em gửi chị lẫn cả… của những ngày khác". | phân tích tĩnh |
| `mkt-n1-ctr-seo-nykaa-ngay` | C(1) gợi ý 1 tính tay dòng mẫu, nói rõ đây là dòng mẫu; C(2) ERD ghi giá trị dạng DB (`40000`, `3348`); `\luuy` bỏ câu nói sẵn "làm tròn ở bước cuối" (trả lời sẵn bẫy). | phân tích tĩnh |
| `mkt-n2-thieu-hien-thi-co-nhap` | B(1) `\luuy` "So sánh với NULL…"; B(2) tiêu đề "Dòng nào của dữ liệu thô…"; B(3) ERD dùng dòng thật `NY-CMP-6265` (row_index 5265, clicks 5038). | phân tích tĩnh |
| `mkt-n3-chi-phi-chien-dich-8-3` | C(1) "đối soát" thay "khớp" ở bối cảnh và nghiệp vụ; C(2) giải nghĩa Influencer; C(3) tiêu đề "Chi phí từng chiến dịch Influencer của Tira Beauty ngày 8/3". Giữ một khuôn "không phải tổng tiền" vì đây là khái niệm cần đối chiếu. | phân tích tĩnh |
| `mkt-n4-lai-hoa-lo-quy-1` | Đạt; tiêu đề có động từ "có bao nhiêu… và lỗ". Sửa ghi chú thiết kế: một dòng ba cột để luyện CASE WHEN trong COUNT, gói vẫn cho `GROUP BY` một cột ở n5, n9 và hai case (hết mâu thuẫn với c1). | phân tích tĩnh |
| `mkt-n5-dong-thieu-chi-so-pheu` | Đạt; tuỳ chọn C: "trống ít nhất một trong bốn chỉ số phễu". | phân tích tĩnh |
| `mkt-n6-gia-tri-don-11-11` | B(1) bối cảnh "đơn hàng của từng chiến dịch có giá trị bình quân bao nhiêu"; B(2) `\luuy` bỏ bị động, phá khuôn "không phải khách hàng tiềm năng" thành "tức số đơn hàng". B(3) (thêm wrong đảo quy tắc hoà) không làm: không bắt buộc. | phân tích tĩnh |
| `mkt-n7-doanh-thu-tho-thap-bat-thuong` | Đạt; tuỳ chọn C: thêm câu về dòng trùng vào `\luuy`; phá khuôn "không phải chiến dịch hoàn tiền". | phân tích tĩnh |
| `mkt-n8-roi-tinh-lai-lech` | B: bối cảnh nêu đúng độ lệch "hàng nghìn lần, có dòng tới hàng triệu lần". | phân tích tĩnh |
| `mkt-n9-thieu-chi-phi-ra-0` | C(1)–(3) gọi `acquisition_cost` là CPA ở tiêu đề, bối cảnh, dòng mở nghiệp vụ, gợi ý 1 (STYLE A.3); `\luuy` không còn nêu sẵn `IS NULL` (gợi ý 2 nói). | phân tích tĩnh |
| `mkt-c1-ctr-theo-loai-thang-5` | B(1) K32: phương án đúng ngắn lại, bỏ từ rào; phương án sai 3 mang từ rào ("nhiều khả năng", "có thể cân nhắc"); ba phương án dài gần bằng nhau. B(2) dòng mở nghiệp vụ "Quyết định… ngân sách nội dung trong quý 3". Gợi ý bỏ khuôn "không phải bình quân". GROUP BY: giữ (như case mẫu `c1-kenh-nhieu-don`), ghi trong `\ghichuthietke` c1 và n4. ERD dạng DB. Anh Duy đổi vai "Giám đốc marketing". | phân tích tĩnh |
| `mkt-c2-nhieu-don-vao-thuong-hieu-nao` | C(a) `\luuy` "Ô trống của bản thô chỉ nằm ở sáu cột…" (bản thô còn cột số khác); yêu cầu bỏ chữ "số"; C(b) K32: phương án đúng bớt rào, phương án sai 3 thêm "chưa cần xử lý"; C(c) phương án sai 2 "nhiều dòng trống ở bốn cột phễu nhất". C(d) đổi mã: không làm (BRIEF-SUA mục 3), xem dưới. | phân tích tĩnh |

Khuôn lặp của gói:
- "X là …, không phải Y": đã bỏ ở r1, n6, n7, c1 (gợi ý), r6 (`\luuy` mới không dùng khuôn). Còn 2 chỗ có chủ ý: khai báo `diem-tuong-tac` (nguyên văn STYLE-mkt E) và n3 (`acquisition_cost` khác tổng chi phí).
- `\luuy` trả lời sẵn `\goiy`: đã sửa r6, r8, n1, n9 (và r1 bỏ câu "lọc đủ cận dưới, cận trên").
- Hai người cùng vai "Trưởng phòng marketing số": Anh Duy (r6, c1) đổi thành "Giám đốc marketing"; Chị Hạnh giữ vai (r5, n9, c2).
- Mở `nghiepvu` bằng "Chọn …": đổi r1, r3, r9, r2, c1 sang "Quyết định / Xác định / So / Đánh giá".
- Ghi chú "hidden-1 bỏ chiến dịch đuôi 7": r2 đã ghi đúng số dòng hai biến thể; các câu khác đã được B, C kiểm là khác nhau.

## Chờ giảng viên

1. **Cấp Dễ của câu dùng một bảng (r4, r5, r6, n3, n5, n9)**: ERD vẽ 2 bảng cho đủ khung Dễ nhưng câu chỉ cần một bảng. r6 không hạ được xuống Cơ bản vì sẽ trùng ô dạng × mảng × cấp × hình thức với r1. Cần chốt: chấp nhận cho Module 1–2, hay hạ một số câu (kèm đổi dạng/mảng để không trùng ô).
2. **Đổi mã `mkt-c2-nhieu-don-vao-thuong-hieu-nao`** (C đề xuất `mkt-c2-file-tho-thieu-nhieu-nhat`): BRIEF-SUA mục 3 không cho đổi mã; câu chưa nhập hệ thống nên đổi được nếu giảng viên đồng ý (sửa cả bản đồ 100 câu).
3. **Case Cơ bản ở gói 1 được dùng `GROUP BY`** (c1, c2) dù Module 4 mới dạy gom nhóm: đang theo case mẫu `c1-kenh-nhieu-don`.
