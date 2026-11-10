# Đã sửa · gói 3 HR Analytics (hr) · v2

Sửa theo REVIEW-B.md và REVIEW-C.md (10/11/2026). Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/hr-goi-3/`: 6 câu có sửa SQL hoặc yêu cầu (j2, j5, q3, q6, c5, c6). Kết quả `KIEM TRA: 0 loi`; báo cáo ở `hr-goi-3-ket-qua/`.
- **Cả gói** chạy `--chi-phan-tich`: `KIEM TRA: 0 loi`.
- **Biên dịch** `bien_dich.sh`: PDF 45 trang, 0 lỗi LaTeX, 0 ký tự thiếu. Bản PDF chép vào `cong-cu/ket-qua/bien-dich/hr-goi-3/`.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| hr-j1-yeu-cau-theo-bac | B: bối cảnh hỏi "chi phí bình quân mỗi yêu cầu" thay cho "tốn bao nhiêu"; yêu cầu đổi thành "Đếm số yêu cầu và tính chi phí … theo bậc" (phá khuôn "Tính cho từng"). | phân tích tĩnh |
| hr-j2-vi-tri-ngoai-ke-hoach | C: thêm cột `so_dong_ca_nam` (bảng dẫn xuất đếm dòng theo năm, nối theo năm) để kết quả hidden-1 khác public. Thêm wrong `thieu_can_tren`: dòng năm 2026 của E00002 lọt vào, nên rớt ở hidden-1. Tiêu đề đổi thành "Vị trí nào có người làm nhưng chưa có định biên?". Sửa câu bối cảnh và gợi ý 1 theo đề xuất. | gói tạm: 0 lỗi; 3 wrong cũ rớt cả hai biến thể, `thieu_can_tren` rớt hidden-1 |
| hr-j3-tuyen-thay-nguoi-nghi-vi-luong | B: sửa "tuyển thay vì" thành "tuyển người thay thế vì"; sửa "với lý do lương" thành "vì lý do lương"; giải nghĩa compa-ratio ở lần đầu. | phân tích tĩnh |
| hr-j4-tin-tuong-quan-ly-theo-phong | C (tuỳ chọn): bối cảnh chuyển sang câu hỏi; yêu cầu bỏ khuôn "tính cho từng". | phân tích tĩnh |
| hr-j5-luong-duoi-thi-truong | B (chấm oan): bỏ `\khainiem{compa-ratio}` khỏi câu. Lưu ý viết lại: so trực tiếp với 0,8 × P50, không dùng `compa_ratio` vì tiền lương được làm tròn **sau** khi tính cột này. Thẻ compa-ratio dùng chung thêm "trừ khi yêu cầu ghi rõ so trực tiếp với P50" và sửa lý do lệch. Yêu cầu, thẻ và wrong `dung_compa_ratio` nay khớp nhau. Tiêu đề đổi thành "Nước nào có nhiều người nhận lương dưới 80\% thị trường?". Sửa câu bối cảnh, "Theo từng nước, đếm…", "thang lương" thành "mức lương thị trường". ERD nối nhiễu theo `position_id` thay cho `country`. | gói tạm: 0 lỗi |
| hr-j6-quan-ly-khong-cao-hon | C: tiêu đề đổi thành "Bao nhiêu quản lý không cao bậc hơn cấp dưới?"; bối cảnh chuyển sang câu hỏi; yêu cầu "Đếm theo nước của nhân viên…". | phân tích tĩnh |
| hr-j7-phieu-khao-sat-gap-ba | Không sửa (B: Đạt). | – |
| hr-j8-nghi-co-tuyen-thay-the | Không sửa (C: Đạt). | – |
| hr-j9-trang-thai-quan-ly | B: tiêu đề đổi thành "Phân loại nhân viên theo quản lý trực tiếp ra thiếu người"; bối cảnh đổi "Em sửa giúp anh" thành "Em xem lỗi ở đâu". | phân tích tĩnh |
| hr-q1-luong-tren-bq-bac | C (tuỳ chọn): bối cảnh bỏ lặp "ở Việt Nam", chuyển sang câu hỏi. | phân tích tĩnh |
| hr-q2-tuyen-khi-het-cho-trong | B: tiêu đề đổi thành "Mỗi nước duyệt bao nhiêu yêu cầu tuyển cho vị trí đã đủ người?". Bối cảnh bỏ khẳng định sai "các vị trí đều đủ người", thay bằng "Nhiều vị trí cuối năm đã đủ người…". `dang` A1 đổi thành A3 (không trùng ô trong gói). Yêu cầu đổi thành "Theo từng nước, đếm…". Ghi chú thiết kế bỏ chữ "nếu". | phân tích tĩnh (SQL không đổi) |
| hr-q3-gan-ket-cao-nhat-moi-phong | C (chấm oan): phạm vi đổi sang nước × phòng ban. Bản truy vấn con tương quan nay dùng chỉ mục `idx_snap_country_dept`, chạy khoảng 20 giây khi máy chấm tải nặng (trước là 1 phút 42 giây). Có hoà điểm cao nhất: public 1 nhóm, hidden-1 2 nhóm. Thêm wrong `moi_nhom_mot_nguoi` (lấy MIN, mất người hoà), rớt cả hai biến thể. Wrong `max_toan_cong_ty` đổi thành `max_ca_nuoc`. Gợi ý 2 bỏ câu "truy vấn con tương quan … cho cùng kết quả". Tiêu đề, bối cảnh, yêu cầu, ERD, lưu ý cập nhật theo phạm vi mới. | gói tạm: 0 lỗi; 3 wrong rớt cả hai biến thể |
| hr-q4-nghi-du-dinh-o-lai-cao | B: yêu cầu "phiếu khảo sát gần nhất … tính tới hết quý có tháng nghỉ"; giải nghĩa `intent_to_stay` (thang 1 tới 5); bối cảnh ngắn lại, bỏ "trước đó". | phân tích tĩnh |
| hr-q5-sales-lam-them-tren-bq | C: tiêu đề đổi thành "Bao nhiêu nhân viên kinh doanh làm thêm trên mức bình quân?"; bối cảnh bỏ chữ "đội"; yêu cầu bỏ khuôn "Tính cho từng"; lưu ý "tổng giờ làm thêm cả năm bình quân trên một người". | phân tích tĩnh |
| hr-q6-yeu-cau-tuyen-lau | B: cột `tg_bq` đổi tên thành `so_ngay_tuyen_bq` (SQL và yêu cầu); gợi ý đổi "đặt nó" thành "đặt con số này". | gói tạm: 0 lỗi |
| hr-q7-chua-quan-ly-ai-ra-rong | C: tiêu đề đổi thành "Danh sách người bậc cao không quản lý ai ra rỗng". Lưu ý viết lại theo ý nghiệp vụ (người đứng đầu nhánh không có quản lý); phần kỹ thuật NOT IN gặp NULL chuyển sang gợi ý 1. | phân tích tĩnh |
| hr-q8-tren-bq-bac-sai-thang | B: bối cảnh tả đúng triệu chứng ("có cả người đang nhận thấp hơn mức bình quân của nhóm trong tháng 12"). Tiêu đề đổi thành "Danh sách lương trên bình quân phòng ban, bậc bị thừa người". Lưu ý "24 dòng tháng, mỗi dòng một mức lương". ERD bỏ nét nối n-1 sai (`country`). | phân tích tĩnh |
| hr-q9-ly-do-pho-bien-moi-nuoc | C: tiêu đề đổi thành "Bảng lý do nghỉ việc phổ biến nhất chỉ có một nước". Yêu cầu "mỗi nước hiện lý do có nhiều người nghỉ nhất". Lưu ý thay bằng ý nghiệp vụ, không nói chỗ sửa. Ghi chú thiết kế và chú thích SQL bỏ chữ "chen vào". | phân tích tĩnh |
| hr-c5-tuyen-thay-the-kip-khong | B (chấm oan): b2 ghi rõ nhóm không có yêu cầu thì `so_ngay_bq` là NULL, `so_di_lam_sau_2025` bằng 0. Phương án đúng viết "phần lớn" để đúng cả ở hidden-1 (nghỉ tự nguyện khoảng 90\%). Phương án 3 cũ đúng ở hidden-1 nên thay bằng lỗi đọc NULL thành 0 ngày; phương án này sai ở cả hai biến thể. Sửa tiêu đề và bối cảnh ("chỗ của người nghỉ có được tuyển người thay"). | gói tạm: 0 lỗi |
| hr-c6-luong-thap-va-nghi-viec | C: b2 và b3 ghi "không làm tròn quân số bình quân trước khi chia". Sửa tiêu đề, bối cảnh, lưu ý theo đề xuất. Giải thích phương án đúng đổi thành "hai lần rưỡi". ERD bỏ nét nối n-1 sai (`country`). | gói tạm: 0 lỗi |

## Chờ giảng viên

- **q2:** 260/317 yêu cầu trong kết quả là tuyển thay thế (`'Backfill'`). Chỗ trống bằng 0 ở tháng 12 có thể chính là kết quả của các yêu cầu này. Cần quyết định có tách hay loại yêu cầu `'Backfill'` không. Hiện giữ nguyên SQL, chỉ sửa bối cảnh cho đúng số liệu.
- **q4:** phiếu khảo sát cùng quý với tháng nghỉ có thể được làm sau ngày nghỉ. Cần xác nhận phiếu cùng quý có được coi là "phiếu gần nhất" trước khi nghỉ không. Hiện giữ cách tính tới hết quý có tháng nghỉ và đã bỏ chữ "trước đó" trong bối cảnh.
- **q3:** câu nêu `employee_id` của người có điểm gắn kết hằng tháng cao nhất (điểm ước lượng, có sai số đo) để mời chia sẻ. Cần xác nhận điều này có trái nguyên tắc bảo mật khảo sát không. Nếu trái, đổi mục đích thành "mức gắn kết cao nhất mỗi nhóm" và bỏ `employee_id`.
- Khuôn "Em … giúp anh/chị" và yêu cầu mở bằng "Xét …" đã giảm ở 9 câu (j1, j4, j6, j9, q1, q2, q4, c5, j2) nhưng chưa thay hết; nếu muốn giảm thêm, chờ giảng viên chốt.
