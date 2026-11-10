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

## Quyết định v3 (10/11)

Theo `BRIEF-QUYET-DINH-126.md` và `QUYET-DINH-CHUNG.md`. Mục "Chờ giảng viên" ở trên đã xử lý hết. Sách dự án = `SupplyChain\bai-giang\Final\capnhat_0711\project-supply-chain\main.tex` (eDA2026, bản 07/11).

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `scm-c3-kho-giao-tre` | "Cần ưu tiên" `HUB_PHANTHIET` chưa đủ chắc | Hạ phương án đúng về "chênh nhỏ, chưa đủ để ưu tiên riêng một kho" | Chạy lại trên `scm`: `HUB_PHANTHIET` 4,87% (238/4.891), `DC_HCM` 4,59%, chênh 0,28 điểm phần trăm; sai số chuẩn √(p(1−p)/n) ≈ 0,31 điểm. Cách đọc độ lệch theo độ lệch chuẩn: sách dự án, phần kiểm tra trước thử nghiệm A/B (dòng 4580–4590) | Bốn phương án: phương án đúng mới; "ưu tiên `HUB_PHANTHIET`" (đúng ở v2) thành phương án sai có giải thích; độ dài 19–23 tiếng (tính cả tên kho), phương án đúng không dài nhất, mọi phương án đều nêu lý do (K32). `\ghichuthietke` ghi lý do và dòng QUYET-DINH-CHUNG 1.2 |
| `scm-c4-khuyen-mai-cua-hang-44` | Mức kết luận "thử ưu tiên" | Chấp nhận v2 | Phương án đúng chỉ nêu tương quan, đúng mức dữ liệu cho phép | Không sửa |
| `scm-a3-voucher-theo-loai-kho` | Nhóm `'auto_apply'` luôn có voucher | Đổi chỉ số sang tỷ lệ dùng voucher trong nhóm `'manual'` (đổi SQL) | Sách dự án dòng 4556–4590: nhóm tự động áp mã có tỷ lệ áp mã 100%, nhóm thủ công 4,15% | Tiêu đề, bối cảnh, yêu cầu, ERD (`checkout_group*`), thêm gợi ý nấc 1; solution và hai wrong thêm `checkout_group = 'manual'`; wrong mới `gop_ca_nhom_tu_dong_ap` (= SQL v2, tỷ lệ quanh 50%). Public: kho chính 3,95%, kho vệ tinh 3,87% |
| `scm-s7-gia-tri-nhan-sai-thu-tu` | Giá trị nhận gồm hàng lỗi | Giữ "dòng tiền mua hàng" theo `qty_received` | Hàng lỗi vẫn được nhận và ghi phiếu nhập trước khi xử lý trả; câu dạy lỗi sắp tháng (`sap-ten-thang`), không đo giá trị thanh toán nhà cung cấp | Không sửa |
| `scm-a8-bien-ln-gop-nganh-hang` | `\luuy` gợi cách tính đúng (RS) | Rút về câu định nghĩa trung tính | Trùng ý gợi ý nấc 1 | `\luuy`: "Doanh thu của ngành là tổng doanh thu các mã hàng thuộc ngành trong kỳ." |
| `scm-a8`/`scm-j6`, `scm-a2`/`scm-j4` | Trùng ô giữa gói 2 và 3 | Giữ a8, a2; viết lại j6 ở gói 3 | QUYET-DINH-CHUNG 1.5 | Không sửa gói 2 |
| Chữ "tự áp mã" | khái niệm `voucher` | "tự nhập voucher" / "hệ thống tự áp voucher" | QUYET-DINH-CHUNG 1.7 | Khái niệm `voucher` |

- Kết luận case (QUYET-DINH-CHUNG 1.1, sửa theo quy_chuan 23:05, gói mẫu c1–c4): phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. ", nêu thẳng chỗ sai. Đã đổi ở mọi case của gói.
- Kiểm lại 10/11 (sau mọi sửa v3): bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/kiem-cuoi/scm-goi-<k>/`) → **KIEM TRA: 0 loi**; phân tích tĩnh bản cuối → 0 lỗi; biên dịch `cong-cu/bien_dich.sh` → 0 lỗi LaTeX, 0 ký tự thiếu (chỉ cảnh báo Overfull hbox).

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu = 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug. Căn cứ: `quy_chuan` (`data.js` M3, M4 có đủ 4 cấp; HD mục 5, 6; CHOT mục 3), `QUYET-DINH-CHUNG.md` mục 0–2, `STYLE-scm.md`, sách dự án eDA2026 (`main.tex`).

| Module | Trước (CB · Dễ · TB · Khó) | Sau | Write / debug |
|---|---|---|---|
| M3 String & Date | 4 · 4 · 1 · 0 | 2 · 3 · 2 · 2 | 6 / 3 (giữ) |
| M4 Aggregation | 0 · 6 · 3 · 0 | 2 · 3 · 2 · 2 | 6 / 3 (giữ) |

Số câu viết lại: 7 (tối thiểu: M3 thiếu 1 TB + 2 Khó → 3 câu; M4 thiếu 2 CB + 2 Khó → 4 câu). Case c3, c4 giữ nguyên cấp. Chọn câu đổi: ưu tiên câu đang trùng ô với gói khác (s3/r7, a2/j4, a6/j9 – nay hết trùng), câu có bẫy trùng câu khác trong gói (a9 cùng bẫy trung bình tỷ lệ với a8), câu có nội dung hạ cấp được ngay (a1).

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (số bảng · số bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `scm-s3-lo-truot-thang-3-ra-0` → `scm-s3-huy-kho-ve-tinh-18-thang` | debug Cơ bản → Trung bình | Viết lại: tỷ lệ huỷ theo tháng ở kho vệ tinh, 1/2016–6/2017; starter gom theo `MONTH()` nên tháng cùng số của hai năm dồn một nhóm (nhãn `MIN` che lỗi). Dạng B1, `orders` + `sorting_hubs`. ERD 3 bảng ký hiệu (1 nhiễu). 2 wrong (`%M`, `CONCAT` thiếu số 0) | 2 bảng (TB) · 2 tầng (Dễ) · tỷ lệ ở tab Nghiệp vụ (TB) · 1 bẫy khó thấy (TB) · công thức 2 thành phần (TB) → TB 4/5 |
| `scm-s4-don-sau-gio-chot-thang-7` → `scm-s4-lui-gio-chot-don` | write Cơ bản → Khó | Viết lại: ước tính lead time bình quân mỗi kho xuất nếu lùi giờ chốt 17 → 18 giờ, đơn tháng 7–8/2017. **Sửa sự thật dữ liệu**: giờ chốt là 17 giờ (sách dự án, phần kiểm tra năm cột chặng: mọi đơn tạo từ 17 giờ chờ qua đêm, `t1` không ghi phần chờ; dữ liệu khớp: giờ chờ ≈ 14,5 giờ ở khung 17 giờ, 0 trước 17 giờ), khái niệm `gio-chot-don` cũ ghi 18 giờ. ERD 5 bảng chỉ khoá, `\erdkhoa`. 5 wrong | 1 bảng (chưa đạt, như mẫu o4) · 3 tầng (TB) · giả định kinh doanh, tự suy giờ chờ (Khó) · 4 bẫy, 1 chỉ lộ ở hidden-1 (Khó) · nhiều điều kiện (Khó) → Khó 3/5 |
| `scm-s9-huy-cuoi-tuan-kho-ve-tinh` → `scm-s9-muc-tang-ngay-cao-diem-2016` | debug Dễ → Khó | Viết lại: mức tăng đơn thực tế của ngày cao điểm so với ngày nền, so mức tăng kế hoạch theo quy mô sự kiện 2016. Starter hai lỗi chồng nhau: `` `date` - 2 `` là trừ số (cửa sổ hỏng khi qua đầu tháng), chỉ xét sự kiện trong năm 2016 (bỏ cửa sổ của 1/1/2017). ERD 5 bảng chỉ khoá. 3 wrong (sửa một lỗi; bỏ cửa sổ) | 2 bảng (chưa đạt) · 4 tầng (Khó) · định nghĩa ngày nền, tự dò ngày sai (Khó) · 2 bẫy khó thấy, chưa có bẫy chỉ ở hidden-1 · nhiều điều kiện (Khó) → Khó 3/5 |
| `scm-a1-dung-han-theo-dc-2016` → `scm-a1-chuyen-giao-theo-dc-2016` | write Dễ → Cơ bản | Hạ: bỏ nối `warehouses`, bỏ tỷ lệ; chỉ đếm số chuyến và số chuyến đúng hạn mỗi DC; giá trị lọc ghi rõ (`week` bắt đầu bằng `'2016'`); ERD 1 bảng có giá trị mẫu. 2 wrong (`LIKE '%2016%'`, `COUNT(on_time)`) | 1 bảng · 1 tầng · đề ghi rõ · 0 bẫy · không công thức → CB 5/5 |
| `scm-a2-ty-le-lo-truot-100` → `scm-a2-dai-chi-so-kho-dich-2017` | debug Dễ → Khó | Viết lại theo sách dự án (phần dựng dashboard: thẻ GMV loại đơn huỷ, thẻ lead time và on-time tính trên mọi đơn): dải chỉ số theo kho đích tháng 7–8/2017. Starter ba lỗi chồng nhau: lead time và tỷ lệ đúng hạn tính cả đơn huỷ; thiếu cận trên (chỉ lộ ở hidden-1). Lọc huỷ ở `WHERE` làm sai tỷ lệ huỷ nên phải gom có điều kiện. Thêm khái niệm `gmv`, `lead-time-don`. 4 wrong | 1 bảng (chưa đạt) · 2 tầng (chưa đạt) · mỗi chỉ số một tập đơn (Khó) · 3 bẫy, 1 chỉ ở hidden-1 (Khó) · sai định nghĩa chỉ số (Khó, như bài Khó M4 của `data.js`) → Khó 3/5 |
| `scm-a6-dung-han-theo-mien-thap` → `scm-a6-tong-giao-dich-thang-7-thap` | debug Dễ → Cơ bản | Viết lại: top 10 cửa hàng theo tổng lượt giao dịch tháng 7/2017; starter dùng `AVG` thay `SUM` (lỗi một chỗ dễ thấy, giá trị mẫu trong ERD là manh mối). Domain `customer`. 1 wrong (`COUNT`) | 1 bảng · 1 tầng · đề ghi rõ · 0 bẫy · không công thức → CB 5/5 |
| `scm-a9-ncc-hang-loi-vuot-nguong` → `scm-a9-pheu-don-mua-theo-dc-2016` | write Trung bình → Khó | Viết lại: phễu đơn mua 2016 theo DC (đặt → về đúng hạn → đủ hàng → đạt kiểm định), tỷ lệ qua từng bước trên bước liền trước, chọn bước hụt nhất. Dạng D1 (bộ chưa có). Thêm khái niệm `pheu-don-mua`, `otd-ncc` (chép nguyên văn gói 3); bỏ khái niệm `ty-le-hang-loi` (không còn câu dùng). ERD 5 bảng chỉ khoá. 4 wrong | 2 bảng (chưa đạt) · 4 tầng (Khó) · tự dựng điều kiện lồng nhau (Khó) · 4 bẫy ở public (TB–Khó) · nhiều điều kiện (Khó) → Khó 3/5 |

Ô dạng × mảng × cấp × hình thức của 7 câu mới: s3 B1·after_sales·TB·debug, s4 A2·operations·Khó·write, s9 C3·marketing·Khó·debug, a1 A3·operations·CB·write, a2 A2·operations·Khó·debug, a6 A3·customer·CB·debug, a9 D1·operations·Khó·write. Không trùng ô trong gói, không trùng ô nào trong `BAN-DO-100-CAU.md` lúc sửa (gói khác đang sửa song song nên cần đối chiếu lại khi gộp).

Ghi chú khi sửa v4:
- s4 và a2 dùng kỳ từ 1/7/2017 tới hết tháng 8/2017 (không lấy 8 tháng): khi nhiều gói chạy bộ kiểm cùng lúc, kỳ 8 tháng làm MySQL quét theo chỉ mục kho, mất 14–28 giây; kỳ hai tháng dùng chỉ mục ngày, dưới 1,2 giây. Bẫy thiếu cận trên vẫn giữ (đơn `ORD2_01033328` ngày 2017-09-01 ở hidden-1).
- s9: bỏ câu "hệ số 2 tức mức tăng 100\%" ở lưu ý vì trùng kết quả (cảnh báo `NGHIEPVU_LO_SO`). s3: wrong `thang_khong_so_0` gom theo `CONCAT(...)` để chạy được dưới `ONLY_FULL_GROUP_BY`.
- Starter không có chú thích (chú thích lộ lỗi); chú thích chỉ đặt ở wrong.

Kiểm lại 11/11 (bản cuối): bộ kiểm đầy đủ trên `scm`, `scm_hidden_1` (`cong-cu/ket-qua/cap-do/scm-goi-2/`) → **KIEM TRA: 0 loi**, 0 cảnh báo, 20 câu; mọi wrong rớt đúng biến thể ghi ở `\ghichuthietke` (s4, a2 `quen_can_tren` chỉ rớt ở hidden-1); solution 7 câu mới chạy 0,001–1,5 giây. Biên dịch `cong-cu/bien_dich.sh` (`cong-cu/ket-qua/cap-do/bien-dich-scm-goi-2/`) → PDF 52 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 32 Overfull hbox (trình bày). Thư mục gói đúng 4 file.

Việc còn mở: 7 câu v4 cần một vòng kiểm B/C về nội dung và giọng văn. Phần thống kê cuối `BAN-DO-100-CAU.md` (theo module, theo gói, ô trùng) chưa sinh lại vì brief chỉ cho sửa dòng của gói; ba ô trùng cũ s3/r7, a2/j4, a6/j9 nay đã hết.
