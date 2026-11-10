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

## Chờ giảng viên (đã quyết hết ở mục "Quyết định v3 (10/11)" bên dưới)

1. **s1, múi giờ:** chưa có nguồn xác nhận `session_start` ghi theo giờ địa phương hay theo một múi giờ chung. Nếu là giờ địa phương thì thêm câu đó vào `\luuy`. Hiện chưa sửa.
2. **a4, lượt sự cố:** khi mục đích là xếp độ khó, có nên tính lượt gặp sự cố vào mẫu số của tỷ lệ thắng không? Đề đang theo định nghĩa ở STYLE mục E (`ty-le-thang-man`, mẫu số gồm lượt sự cố).
3. **Khái niệm `kenh-thu-hut`** (dùng ở s9, a3, c4): chưa có trong 22 khái niệm ở STYLE-jelly mục E. Cần giảng viên duyệt để bổ sung vào bộ chuẩn.
4. **c4, câu rào cỡ mẫu:** đã thêm vào phương án đúng. Người nắm nghiệp vụ thu hút người chơi nên xác nhận mức rào này đủ trước khi dùng số liệu để chia ngân sách.

## Quyết định v3 (10/11)

Căn cứ domain: `Project DA\Game\Jelly_Trail_Academy_v2\docs\data_dictionary.md` (DD), `JELLY_TRAIL_ACADEMY_BUSINESS_ANALYTICS_V2_QA_FINAL.docx` (QA); `QUYET-DINH-CHUNG.md` (QDC).

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| jelly-s1 | `session_start` theo giờ địa phương hay múi giờ chung | Giữ, không nhắc múi giờ | DD mục "Grain and time fields": `session_start` chỉ là tên cũ của `event_time`, không nêu múi giờ; CSV ghi `2026-07-05T20:43:00` không có độ lệch múi giờ. Tài liệu không nói nên đề không được tự thêm | Không đổi |
| jelly-a4 | Lượt sự cố có vào mẫu số tỷ lệ thắng | Giữ định nghĩa STYLE E (mẫu số gồm lượt sự cố) | DD "Win rate = complete attempts / all attempts"; QA mục 3.2 "win rate là số lượt thử thắng trên mọi lượt thử" | Không đổi |
| jelly-c4 | Câu rào cỡ mẫu ở phương án đúng | Giữ rào; K32 đạt vì phương án 1 cũng nói về độ ổn định ("quy mô kênh đủ lớn để con số ổn định") | QA chương II, đoạn ROAS D7 theo kênh (chênh theo kênh cần kiểm thêm trước khi chia ngân sách marginal) | Rút phương án đúng cho gần độ dài hai phương án sai (bỏ "về số lượng", "vài điểm phần trăm") |
| `kenh-thu-hut` (s9, a3, c4) | Khái niệm chưa có trong STYLE | Duyệt | QDC 1.8 | Chép nguyên định nghĩa của gói 2 vào STYLE-jelly mục E; dòng "Riêng jelly" ở STYLE cập nhật |

### Theo quy chuẩn (QUYET-DINH-CHUNG mục 0.1, sửa 23:05)

- Kết luận case: phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. " (theo 4 case mẫu `quy_chuan/goi-cau-hoi-mau`). Đổi máy, chỉ ở lời giải thích, không đổi nội dung phương án.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu có 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (lộ trình `quy_chuan/lo-trinh-sql/assets/js/data.js`: mọi module đủ 4 cấp). Giữ tỷ lệ hình thức (mỗi module 6 write + 3 debug); hai case giữ nguyên cấp. Không sửa database, biến thể ẩn, file 04.

Phân bố cấp trước → sau:

| Module | Trước (Cơ bản / Dễ / TB / Khó) | Sau |
|---|---|---|
| M3 String & Date | 3 / 6 / 0 / 0 (s1, s2, s7 · s3, s4, s5, s6, s8, s9) | 2 / 3 / 2 / 2 (s2, s7 · s3, s5, s9 · s4, s8 · s1, s6) |
| M4 Aggregation | 0 / 6 / 3 / 0 (a1, a2, a3, a4, a6, a7 · a5, a8, a9) | 2 / 3 / 2 / 2 (a2, a3 · a1, a4, a7 · a5, a9 · a6, a8) |

Số câu viết lại: 8 (tối thiểu: M3 thừa 1 Cơ bản và 3 Dễ; M4 thừa 3 Dễ và 1 Trung bình). Hình thức sau: M3 write B/B/E/E/M/H, debug B/E/M; M4 write B/B/E/E/M/H, debug E/M/H.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `jelly-s1-gio-cao-diem` → `jelly-s1-arpdau-ngay-su-kien` | Cơ bản → Khó | Viết lại cả câu (C3 · marketing): ARPDAU từng sự kiện LiveOps so với ngày thường, nối `daily_kpi` với `liveops_events` theo khoảng ngày. ERD 5 bảng chỉ khoá, 3 bảng nhiễu, `\erdkhoa`. Thêm khai báo `arpdau` (chép STYLE E). 4 wrong. | 2 bảng nối theo khoảng (không có khoá chung) · 4 tầng · ngôn ngữ kinh doanh, cách nối ở `\erdkhoa` · 4 bẫy (trung bình cột `arpdau`, bỏ ngày kết thúc: public; thiếu cận trên, chép tay lịch sự kiện: chỉ hidden-1 nhờ ngày 30/8–2/9 và `LIVE_004`) · ARPDAU nhiều ngày là tỷ lệ của tổng, so với mốc. Đạt 4/5 |
| `jelly-s4-ngay-tu-cai-den-mua` → `jelly-s4-lan-mua-dau-sau-cai` | Dễ → Trung bình | Từ 20 giao dịch Starter Pack xa ngày cài nhất sang phân bố số ngày từ cài tới lần mua đầu (D0 / D1-D6 / D7+) của người cài tháng 7, kèm tỷ lệ (C4 · sales). ERD 3 bảng ký hiệu, `sessions` nhiễu. 3 wrong. | 2 bảng · 3 tầng (ngày mua đầu mỗi người, xếp nhóm, tỷ lệ trên tổng) · chỉ số ở tab · 2 bẫy (xếp mọi giao dịch thay lần đầu: public; cận trên: hidden-1, người chơi cài 5/7 mua lần đầu 1/9) · điều kiện theo thời điểm. Đạt 5/5 |
| `jelly-s6-tuan-iso` → `jelly-s6-giu-chan-d7-theo-tuan` | Dễ → Khó | Từ số người cài theo tuần ISO sang tỷ lệ giữ chân D7 theo tuần cài ISO, chỉ nhóm đủ ngày quan sát (D2 · customer). ERD 5 bảng chỉ khoá, 3 bảng nhiễu, `\erdkhoa`. Thêm khai báo `ty-le-giu-chan`, `nhom-du-ngay` (chép STYLE E). 4 wrong. | 2 bảng · 4 tầng · ngôn ngữ kinh doanh, cách nối ở `\erdkhoa` · 4 bẫy (`YEARWEEK` mặc định, tính nhóm chưa đủ ngày, nối trong mất mẫu số: public; ngày cuối bằng `MAX(activity_date)`: chỉ hidden-1) · cohort D7 có điều kiện đủ ngày. Đạt 4/5 |
| `jelly-s8-gio-chua-doi` → `jelly-s8-su-co-ba-ngay-dau` | Dễ → Trung bình | Viết lại câu Sửa lỗi (A2 · after_sales): tỷ lệ sự cố trên 1.000 phiên trong ba ngày đầu của bản 2.1.0 và 2.1.1. Starter dùng `ngay_phat_hanh + 2` (ngày thành số 20260732, so theo kiểu số), bản 2.1.0 mất ngày 1/8; bản 2.1.1 không bị ảnh hưởng. ERD 3 bảng ký hiệu, `sessions` nhiễu. 2 wrong. | 2 bảng · 3 tầng · chỉ số ở tab · 2 bẫy (cộng số vào ngày, phiên bản lúc cài và lúc chơi) · điều kiện theo thời điểm; Sửa lỗi TB: một lỗi khó thấy, sai phạm vi cửa sổ thời gian. Đạt 5/5 |
| `jelly-a2-doanh-thu-goi` (giữ mã) | Dễ → Cơ bản | Chỉ tháng 7 trọn tháng, bỏ cột giá bình quân và cửa sổ 60 ngày; ERD 1 bảng có giá trị mẫu. Wrong mới: thiếu cận trên (public), đếm người mua thay giao dịch. | 1 bảng · 1 tầng (gom một cột, được phép ở M4) · đề ghi rõ cột, giá trị lọc · 0 bẫy · 1 khái niệm. Đạt 5/5 |
| `jelly-a3-chi-theo-kenh` (giữ mã) | Dễ → Cơ bản | Tháng 7 thay tháng 8, bỏ cột chi bình quân một ngày (bẫy `AVG` theo dòng); ERD 1 bảng có giá trị mẫu. Wrong: thiếu cận trên, `AVG` thay tổng. Hidden-1 khác public nhờ biến thể (h) ngày 11/7. | 1 bảng · 1 tầng · đề ghi rõ · 0 bẫy · 1 khái niệm. Đạt 5/5 |
| `jelly-a6-quoc-gia-nhieu-crash` → `jelly-a6-su-co-truoc-sau-ban-va` | Dễ → Khó | Từ tỷ lệ sự cố theo thị trường sang mức chênh tỷ lệ sự cố của bản vá 2.1.1 so với 2.1.0 ở từng thị trường, theo phiên bản lúc chơi (C3 · after_sales). ERD 5 bảng chỉ khoá, 4 bảng nhiễu (lời giải 1 bảng, như mẫu o4). 4 wrong. | 1 bảng · 3 tầng · ngôn ngữ kinh doanh, tự chọn cột phiên bản · 4 bẫy (phiên bản lúc cài, so với mọi bản cũ gồm 2.0.2, trung bình tỷ lệ từng dòng: public; bỏ cửa sổ: chỉ hidden-1, cột `phien_211` của GB) · chỉ số nhiều điều kiện. Đạt 3/5 (mơ hồ, bẫy, nghiệp vụ) |
| `jelly-a8-tb-ty-le` → `jelly-a8-arpdau-thang-8-nen-tang` | Trung bình → Khó | Viết lại câu Sửa lỗi (A2 · finance), theo bài Khó của M4 trong lộ trình (sửa định nghĩa chỉ số): ARPDAU tháng 8 theo nền tảng từ `player_daily`. Starter có hai lỗi chồng nhau: tổng DAU bằng `COUNT(DISTINCT user_id)` (là MAU) và thiếu cận trên. ERD 5 bảng trung tính, chỉ khoá. 3 wrong (chỉ sửa một lỗi mỗi bài; trung bình ARPDAU từng ngày). | 1 bảng · 2 tầng · yêu cầu nêu bằng lời · 2 bẫy, một chỉ ở hidden-1 · ARPDAU nhiều ngày, tháng chưa trọn; Sửa lỗi Khó: hai lỗi chồng nhau, một là sai định nghĩa chỉ số |

Kiểm:

- Bộ kiểm đầy đủ cả gói: `python cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/jelly/goi-2 --ra cong-cu/ket-qua/cap-do/jelly-goi-2` → 20 câu, 76 khối SQL, `KIEM TRA: 0 loi`, 0 cảnh báo. Mọi wrong rớt ≥ 1 biến thể (rớt đúng biến thể ghi ở `\ghichuthietke`); starter của s8, a8 sai ở cả hai biến thể; solution của 8 câu mới ra kết quả public khác hidden-1. Lời giải chậm nhất 1,3 giây (s6 trên hidden-1).
- Biên dịch: `bash cong-cu/bien_dich.sh goi-cau-hoi/jelly/goi-2 <ra>` → PDF 53 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo gói lệnh (54 Overfull hbox, chỉ là trình bày). PDF ở `cong-cu/ket-qua/cap-do/jelly-goi-2/bien-dich/`.
- Thư mục gói vẫn đúng 4 file.

Ô dạng × mảng × cấp × hình thức mới: C3·marketing·hard·write (s1), C4·sales·medium·write (s4), D2·customer·hard·write (s6), A2·after_sales·medium·debug (s8), A3·sales·basic·write (a2), A3·marketing·basic·write (a3), C3·after_sales·hard·write (a6), A2·finance·hard·debug (a8). Không trùng ô trong gói và không trùng ô nào của gói khác trong `BAN-DO-100-CAU.md` lúc 11/11 (đã đối chiếu cả bản gói 1 vừa sửa song song). Gần chủ đề, khác ô: s6 và `jelly-t8` (D2·customer·hard·debug, cùng giữ chân D7), a6 với `jelly-n8`, `jelly-r3` mới của gói 1 (sự cố theo phiên bản, khác ô).

Khác:

- `BAN-DO-100-CAU.md`: chỉ thay 8 dòng của gói 2. Phần thống kê và danh sách ô trùng cuối file chưa sinh lại (dòng "A3 · marketing · easy · write: a3, j2" nay không còn trùng vì a3 thành Cơ bản); cần sinh lại khi các gói xong.
- `style/STYLE-jelly.md` mục E: `kenh-thu-hut` chép đủ 4 đối số, giống hệt khai báo ở `cau-hoi.tex` (việc tồn từ KIEM-V3); thêm dòng 23 vào bảng khái niệm.
- Sửa chú thích đầu khối câu a4 (ghi "Trung bình" trong khi `cap=easy`).
