# Đã sửa · gói 2 · Supply Chain (`scm`) · v2

Sửa theo `REVIEW-B.md`, `REVIEW-C.md` (10/11/2026). Không đổi `ma`.
Kiểm lại: gói tạm `cong-cu/ket-qua/sua/scm-goi-2/` (10 câu sửa SQL hoặc yêu cầu) chạy MySQL → **KIEM TRA: 0 loi**, mọi wrong rớt đúng biến thể; cả gói `--chi-phan-tich` → **KIEM TRA: 0 loi**; `bien_dich.sh` → 43 trang, 0 lỗi LaTeX, 0 ký tự thiếu.

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| `scm-s1-don-mua-ve-tre-2016` | Không cần sửa (B: Đạt). | tĩnh |
| `scm-s2-ngay-cao-diem-2016` | C: luuy viết lại (bỏ "ngày thường", bỏ câu kết luận chung); bối cảnh "năm ngoái (2016)"; dòng mở chỉ còn xếp lịch truyền thông. | tĩnh |
| `scm-s3-lo-truot-thang-3-ra-0` | Không sửa; khuôn lặp với a2 sửa ở a2; lỗi trùng với s7 sửa ở s7. | tĩnh |
| `scm-s4-don-sau-gio-chot-thang-7` | C: đổi người hỏi thành Điều phối vận hành (phạm vi mọi kho), domain `operations`; bẫy `> 18` chỉ còn nêu ở khái niệm mới `gio-chot-don` (bỏ ở yêu cầu, lưu ý, gợi ý 1); yêu cầu dẫn chiếu tab Nghiệp vụ; bỏ mệnh đề "mà … sau đó". | MySQL 0 lỗi |
| `scm-s5-ban-theo-thu-cua-hang-44` | B: yêu cầu ghi rõ tổng cả tháng, không chia số ngày; luuy viết lại; bối cảnh "cửa hàng mình (cửa hàng 44)", "theo nhịp bán trong tuần". | MySQL 0 lỗi |
| `scm-s6-chuyen-giao-tre-quy-2` | C: giải nghĩa DC lần đầu, sửa trật tự "chuyến giao trễ từ … tới cửa hàng"; dòng mở "cần nhắc nhở"; luuy "Tuần giao được tính vào quý của ngày đầu tuần." | tĩnh |
| `scm-s7-gia-tri-nhan-sai-thu-tu` | B: đổi lỗi starter sang `CONCAT(YEAR, '-', MONTH)` (khác lỗi `%M` của s3); wrong mới giữ CONCAT nhưng sắp theo `MIN(received_date)`; bối cảnh, yêu cầu ("các tháng xếp sai thứ tự"), tiêu đề; dòng mở "kế hoạch dòng tiền mua hàng". | MySQL 0 lỗi |
| `scm-s8-von-ton-cuoi-ky-2017` | C (chấm oan): yêu cầu ghi rõ lấy tổng `inventory_value`, không tính lại từ `on_hand_end` × giá vốn; bối cảnh viết lại, bỏ "chuỗi vốn tồn kho" và câu lộ bẫy tháng chưa đủ. | MySQL 0 lỗi |
| `scm-s9-huy-cuoi-tuan-kho-ve-tinh` | B: tiêu đề, bối cảnh (bỏ "bảng chấm công", bỏ "cách lọc ngày"), yêu cầu bỏ định ngữ chồng, luuy thành định nghĩa cuối tuần (bỏ mẹo SQL), dòng mở gắn tỷ lệ huỷ. | MySQL 0 lỗi |
| `scm-a1-dung-han-theo-dc-2016` | C: tiêu đề thành câu hỏi; giải nghĩa DC lần đầu; luuy bỏ "vắt qua". | tĩnh |
| `scm-a2-ty-le-lo-truot-100` | B: giải nghĩa DC; bối cảnh khác khuôn s3; luuy thành quy tắc mẫu số (bỏ mẹo SQL); thêm gợi ý nấc 2; "100\%". | MySQL 0 lỗi |
| `scm-a3-voucher-theo-loai-kho` | C: tiêu đề, bối cảnh thống nhất "kho chính và kho vệ tinh" (bỏ "vùng", "loại kho"); wrong mới nối theo `origin_hub_id`; khái niệm `voucher` ghi rõ nhóm `'auto_apply'` luôn có voucher; dòng mở bớt quyết định ngân sách. Chỉ số giữ nguyên, chờ giảng viên. | MySQL 0 lỗi |
| `scm-a4-cua-hang-vang-khach-2016` | B: mẫu số "trên các ngày có số liệu giao dịch"; bối cảnh bỏ "lọc", bỏ định ngữ chồng. | MySQL 0 lỗi |
| `scm-a5-so-ma-ban-cua-hang-44` | C: tiêu đề "Số mã hàng có bán …"; bối cảnh "gần ba mươi nghìn mã … cả chuỗi khoảng bốn nghìn mã hàng". Giữ wrong `dem_ngay_ban` (C ghi "có thể thay"). | tĩnh |
| `scm-a6-dung-han-theo-mien-thap` | B: hạ cấp `medium` → `easy`, ERD còn 2 bảng có điều kiện nối; bối cảnh bỏ "truy vấn", "định nghĩa"; yêu cầu viết lại; khái niệm `giao-dung-han-don` sửa công thức thành "số đơn không huỷ có on\_time = 1 / số đơn không huỷ". | MySQL 0 lỗi |
| `scm-a7-don-mien-theo-quy-2016` | C: tiêu đề thành câu hỏi; bối cảnh "mùa vụ đơn online của ba miền". | tĩnh |
| `scm-a8-bien-ln-gop-nganh-hang` | B: tiêu đề còn 10 tiếng; bối cảnh "tháng 7/2017". | tĩnh |
| `scm-a9-ncc-hang-loi-vuot-nguong` | C: định nghĩa `so_don`; sửa trật tự bối cảnh. | MySQL 0 lỗi |
| `scm-c3-kho-giao-tre` | B: tiêu đề "Kho đích nào cần ưu tiên khắc phục giao trễ?"; bối cảnh bỏ "đang"; luuy bỏ câu lộ cách chọn phương án; phương án A, C viết lại (C thành lỗi gộp nhóm kho vệ tinh). | tĩnh (SQL không đổi) |
| `scm-c4-khuyen-mai-cua-hang-44` | C: tiêu đề và phương án đúng chỉ nói chênh lệch (tương quan), "thử ưu tiên"; bối cảnh "cho ngành hàng nào"; khái niệm `khuyen-mai` "chỉ cho thấy tương quan". | tĩnh (SQL không đổi) |

## Chờ giảng viên

- `scm-a3-voucher-theo-loai-kho`: đơn nhóm `'auto_apply'` luôn có `voucher_applied` = 1, nên tỷ lệ dùng voucher theo kho đích chủ yếu đo tỷ trọng nhóm thử nghiệm A/B. Có đổi chỉ số sang tỷ lệ khách tự áp mã (`checkout_group = 'manual'`) không?
- `scm-c4-khuyen-mai-cua-hang-44`: phương án đúng đã hạ về mức tương quan ("thử ưu tiên"). Cần xác nhận mức kết luận này đủ cho bước kết luận.
- `scm-c3-kho-giao-tre`: HUB_PHANTHIET hơn DC_HCM 0,28 điểm phần trăm trên 4.891 đơn (sai số chuẩn khoảng 0,3 điểm). Kết luận "cần ưu tiên" có đủ chắc không?
- `scm-s7-gia-tri-nhan-sai-thu-tu`: giá trị hàng nhận tính trên `qty_received` (gồm hàng lỗi). Đã đổi dòng mở sang "dòng tiền mua hàng"; nếu muốn đúng nghĩa thanh toán NCC thì cần quy ước trừ hàng lỗi.
