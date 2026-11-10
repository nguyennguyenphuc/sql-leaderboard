# Đã sửa · gói 2 · GAME Jelly Trail Academy (`jelly`) · v2

Sửa theo `REVIEW-B.md`, `REVIEW-C.md` và tin nhắn điều phối ngày 10/11/2026. Không sửa database hay biến thể ẩn.

Có hai cách kiểm lại:

- **Câu có đổi SQL hoặc yêu cầu** (s3, s7, s8, a7, a9): chạy bộ kiểm trên gói tạm `cong-cu/ket-qua/sua/jelly-goi-2/` (5 câu, 19 khối SQL). Kết quả `KIEM TRA: 0 loi`; mọi wrong rớt đúng biến thể; starter của các câu Sửa lỗi đều sai. Báo cáo ở `cong-cu/ket-qua/sua/jelly-goi-2-bao-cao/`.
- **Mọi câu** (cả gói): phân tích tĩnh `--chi-phan-tich` cho `KIEM TRA: 0 loi`. Cảnh báo duy nhất là `GOI_FILE_LA`, do thư mục gói có thêm các file .md ngoài 4 file chuẩn.

## Từng câu

| Mã | Đã sửa gì (theo điểm của B/C) | Kiểm lại |
|---|---|---|
| `jelly-s1-gio-cao-diem` | B(1) sửa trật tự từ trong `\boicanh`. B(2) sửa `\luuy` thành "cho biết lúc nào game đông". B(3) múi giờ chuyển vào mục Chờ giảng viên. | tĩnh |
| `jelly-s2-tach-the-gioi` | C(1), C(2) sửa `yeucau`: "gồm ba phần, ngăn cách bằng chuỗi…", "Lấy phần thứ hai làm…". C(3) bỏ dấu hai chấm ở `\goiy`. | tĩnh |
| `jelly-s3-ngay-trong-tuan` | B(1) thêm cột `so_ngay` và `tb_moi_ngay`; `\luuy` giải thích thứ có 9 ngày, thứ có 8 ngày. Đổi wrong "sắp theo tên thứ" thành wrong "chia mọi thứ cho 9". B(2) đổi người hỏi sang Quản lý sản phẩm, mục đích xếp ca hỗ trợ người chơi mới, nên hết lập luận vòng về ngân sách. B(3) bỏ "cả kỳ dữ liệu". B(4): với mục đích mới, giữ `customer`. | bộ kiểm |
| `jelly-s4-ngay-tu-cai-den-mua` | C sửa `\goiy` thành "Thứ tự phụ khi bằng số ngày quyết định…". | tĩnh |
| `jelly-s5-phien-ban-dang-chuoi` | B (không bắt buộc) đổi tiêu đề thành "Người chơi đang dùng những phiên bản nào?". | tĩnh |
| `jelly-s6-tuan-iso` | C(1) chống chấm oan: `tuan` là số nguyên như `YEARWEEK` trả về, ghi rõ không trả về chuỗi `'202628'`. C(2) sửa thành "số ngày trong tuần có người cài". C(3) bỏ "cả kỳ dữ liệu" trong `\boicanh`. SQL giữ nguyên. | tĩnh |
| `jelly-s7-thang-sai-thu-tu` | B(1) sửa thuật ngữ thành "doanh thu IAP (mua hàng trong ứng dụng)". B(2) đổi câu lặp thành "Anh chị chỉ giúp em chỗ sai với". B(3) thêm `is_refund = 0` vào starter, solution và 2 wrong; kết quả không đổi. | bộ kiểm |
| `jelly-s8-gio-chua-doi` | C (điều phối ưu tiên): bài sai `BETWEEN` tới 0 giờ hôm sau trước đây vẫn qua vì dữ liệu không có lượt nào lúc đúng 0 giờ. Đổi mốc thành ca sáng 15/8 từ 0 giờ tới trước 11:00:00, mọi nền tảng, vì có đúng một lượt sự cố iOS lúc 11:00:00 ở cả hai biến thể. Starter `BETWEEN … '11:00:00'` thừa lượt đó. Thêm cột `platform`. Wrong mới: lọc `HOUR(event_time) <= 11`, và chỉ có cận trên. Viết lại tiêu đề, `\boicanh`, `yeucau`, `\goiy`. Bỏ "Sửa để ra đúng". | bộ kiểm |
| `jelly-s9-ma-chien-dich` | B(1) sửa tiêu đề thành "Báo cáo người mới theo kênh có nhóm không tên". B(2) ghi rõ `kenh` bằng NULL. B(3) sửa `\boicanh`. B(4) `kenh-thu-hut` chuyển vào mục Chờ giảng viên. | tĩnh |
| `jelly-a1-dau-thang-7` | C(1) sửa tiêu đề thành "bình quân". C(2) bỏ khuôn "mệnh đề: kết luận" và "theo tab Nghiệp vụ". C(3) giải nghĩa MAU. C(4) thêm động từ vào `\goiy`. | tĩnh |
| `jelly-a2-doanh-thu-goi` | B sửa `\boicanh`: "từ đầu tháng 7 tới nay … bán được bao nhiêu lượt". | tĩnh |
| `jelly-a3-chi-theo-kenh` | C(1) sửa tiêu đề thành "Chi phí quảng cáo tháng 8 của từng kênh". C(2) sửa chủ thể trong `\boicanh`: "mình đã chi cho mỗi kênh". | tĩnh |
| `jelly-a4-ty-le-thang-man` | B(1) hạ cấp `medium` xuống `easy`; ERD còn 2 bảng, có chữ trên đường nối. B(2) bỏ "cả kỳ dữ liệu". Đổi "theo tab Nghiệp vụ" thành "bằng công thức ở tab Nghiệp vụ". B(3) chuyển vào mục Chờ giảng viên. SQL giữ nguyên. | tĩnh |
| `jelly-a5-arppu` | C sửa `yeucau`: "cho từng nền tảng của giao dịch (`purchases.platform`) bằng công thức ở tab Nghiệp vụ". | tĩnh |
| `jelly-a6-quoc-gia-nhieu-crash` | B(1) viết lại `\luuy`, phá khuôn "cùng trọng số". B(2) sửa tiêu đề thành "Thị trường nào có tỷ lệ sự cố cao nhất?". B(3) bỏ "cả kỳ dữ liệu" và đổi cách kết lời nhắn. B(4) hạ cấp xuống `easy`; ERD còn 2 bảng. SQL giữ nguyên. | tĩnh |
| `jelly-a7-dem-nguoi-tra-tien` | C sửa `yeucau`, bỏ "Sửa để ra đúng". Thêm `is_refund = 0` vào cả 4 khối để gói thống nhất (C ghi chú). | bộ kiểm |
| `jelly-a8-tb-ty-le` | B(1), B(2) giải nghĩa ARPDAU trong `\boicanh` và bỏ "tổng số người chơi hoạt động". B(3) tách đơn vị riêng cho `arpdau`. B(4) chống lộ cách sửa: bỏ `\khainiem{arpdau}` và `\luuy` cũ; tab còn `dau`, `doanh-thu-quang-cao` và một `\luuy` chỉ định nghĩa ARPDAU một ngày. Xoá khai báo `arpdau` khỏi đầu file vì không câu nào dùng nữa. Giữ cấp `medium`. | tĩnh |
| `jelly-a9-having-where` | C(1), C(2) sửa sai sự thật: v1 ghi "gần hết các màn" nhưng thực tế ra 37/60. C(3) đổi từ số lượt thua tuyệt đối (dồn về màn đầu) sang tỷ lệ thua trên 25\%. Starter lọc `result` ở `WHERE`, nên mẫu số chỉ còn lượt thua và màn nào cũng ra 100\% (60 màn). Solution gom mọi lượt; ngưỡng ở `HAVING`. Wrong mới: bỏ lượt sự cố khỏi mẫu số; gộp cả lượt bỏ cuộc. C(4) bỏ `\khainiem{ty-le-thang-man}`; `\luuy` mới nói vì sao cần tỷ lệ. | bộ kiểm |
| `jelly-c3-phien-ban-moi-dai-hon` | B(1) sửa `\luuy` sai sự thật: khoảng ngày của các bản chồng nhau, chỉ dài ngắn khác nhau. B(2) sửa dòng mục đích. B(3) đổi cách sắp thành "từ bản cũ tới bản mới"; kết quả không đổi. Không thêm `users` vào ERD, để giữ case Cơ bản ở 1 bảng. | tĩnh |
| `jelly-c4-kenh-dong-nguoi` | C(1) sửa `\luuy` thành câu trung tính. C(2) sửa lời giải thích phương án đúng để dẫn đúng bước 2. C(3) viết "kênh tự nhiên (Organic)" thay cho "Organic" trong văn. Điểm domain: thêm câu rào cỡ mẫu vào phương án đúng, vì Creator Campaign có 333 người cài; chênh 1,6 điểm phần trăm so với Social Ads nhỏ hơn sai số chuẩn khoảng 2,3 điểm. Hai phương án sai cũng có từ rào, nên phương án đúng không lộ (K32). | tĩnh |

Khuôn lặp đã phá:

- "cả kỳ dữ liệu" trong `\boicanh`: còn 0 chỗ.
- ", theo tab Nghiệp vụ": còn 0 chỗ; chỉ giữ "bằng công thức ở tab Nghiệp vụ" ở những câu mà tab có công thức.
- "Sửa để ra đúng": còn 0 chỗ.
- "Anh chị xem giúp em sai ở đâu": còn 1 chỗ (s9).
- "trung bình" trong tiêu đề: đổi thành "bình quân".

## Chờ giảng viên

1. **s1, múi giờ:** chưa có nguồn xác nhận `session_start` ghi theo giờ địa phương hay theo một múi giờ chung. Nếu là giờ địa phương thì thêm câu đó vào `\luuy`. Hiện chưa sửa.
2. **a4, lượt sự cố:** khi mục đích là xếp độ khó, có nên tính lượt gặp sự cố vào mẫu số của tỷ lệ thắng không? Đề đang theo định nghĩa ở STYLE mục E (`ty-le-thang-man`, mẫu số gồm lượt sự cố).
3. **Khái niệm `kenh-thu-hut`** (dùng ở s9, a3, c4): chưa có trong 22 khái niệm ở STYLE-jelly mục E. Cần giảng viên duyệt để bổ sung vào bộ chuẩn.
4. **c4, câu rào cỡ mẫu:** đã thêm vào phương án đúng. Người nắm nghiệp vụ thu hút người chơi nên xác nhận mức rào này đủ trước khi dùng số liệu để chia ngân sách.
