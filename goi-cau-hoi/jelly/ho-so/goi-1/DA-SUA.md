# Đã sửa · bộ `jelly` · gói 1 (v1 → v2)

Theo `REVIEW-B.md`, `REVIEW-C.md` và `BRIEF-SUA-GOI.md`. Không đổi `ma`, không sửa database.

Cách kiểm lại:
- **Bộ kiểm (gói tạm):** `cong-cu/ket-qua/sua/jelly-goi-1/` gồm 6 câu đã sửa SQL hoặc yêu cầu (r4, r6, r7, r8, r9, n7), chạy trên MySQL → `KIEM TRA: 0 loi`. Mọi wrong rớt ≥ 1 biến thể.
- **Phân tích tĩnh:** `--chi-phan-tich` trên cả gói (20 câu, 66 khối SQL) → `KIEM TRA: 0 loi`.
- **Biên dịch:** `bien_dich.sh` → `cong-cu/ket-qua/bien-dich/jelly-goi-1/`.

| Mã | Đã sửa (theo điểm của B/C) | Kiểm lại |
|---|---|---|
| jelly-r1-cai-moi-29-8-vn | B: `\luuy` bỏ liệt kê `'VN'`, `'US'`, `'GB'` (lộ giá trị lọc); mở tab Nghiệp vụ đổi thành "Lập danh sách người chơi đã nhận lời chào mừng mới để theo dõi phản hồi." | tĩnh |
| jelly-r2-giao-dich-season-pass | C: `\boicanh` bỏ "mùa thi đấu" (dịch "season"), tách hai mệnh đề, nói rõ cần danh sách giao dịch; tab Nghiệp vụ theo câu C đề xuất. | tĩnh |
| jelly-r3-man-sieu-kho | B: `yeucau` nói "siêu khó" bằng lời thay cho `'super_hard'`, nên hai wrong (`LIKE '%hard%'`, `<> 'normal'`) thành lỗi thật; "làm" → "thiết kế" thế giới mới; tab Nghiệp vụ mở bằng "Xác định…"; ghi rủi ro chép kết quả vào `\ghichuthietke`. | tĩnh (SQL không đổi) |
| jelly-r4-ngay-chi-cao-social | C: đổi phạm vi thành "từ 15/8/2026 tới ngày mới nhất có trong dữ liệu", nên kết quả đúng ở hidden-1 khác public (dòng chi 2026-09-01 đứng hạng 3); thay wrong `khong_gioi_han_thang` bằng `gan_cung_ngay_cuoi` (`BETWEEN … '2026-08-29'`, rớt hidden-1); `\tieude` "Mười ngày chi nhiều nhất cho Social Ads ở Việt Nam"; `\boicanh` nhắc chiến dịch trước khi gọi "chiến dịch này"; ERD bỏ `kieu=1-n`, ghi "nối logic theo chiến dịch, nhiều -- nhiều"; gợi ý, ghi chú theo phạm vi mới. | bộ kiểm 0 lỗi |
| jelly-r5-luot-dai-man-30 | B: "dựng lại tình huống/lỗi" → "tái hiện lỗi"; lời nhắn thêm lời nhờ ("Em lấy giúp chị…"); tab Nghiệp vụ mở bằng "Lấy…". | tĩnh |
| jelly-r6-su-kien-thang-8 | C (lỗi nặng 1): đổi kỳ xét thành 26/7 -- 9/8/2026 để có hai sự kiện vắt qua mốc đầu (24/7 -- 28/7) và mốc cuối (8/8 -- 12/8); `\tieude`, `\boicanh`, `yeucau`, `\luuy`, `\goiy`, ghi chú viết lại theo kỳ mới; thêm wrong `bat_dau_trong_khoang` (ra 1 dòng) và `nam_tron_trong_khoang` (ra 0 dòng), giữ `hoac_thay_va`; tab Nghiệp vụ mở bằng "Lập danh sách…". | bộ kiểm 0 lỗi |
| jelly-r7-organic-ios-tuan-dau | B: thay wrong `ngoac_sai_cho` (trùng starter) bằng `and_thay_or` (ra 0 dòng, rớt public); lời nhắn nêu đủ hai kênh, phá khuôn kết "Anh chị xem giúp em" → "Anh chị chỉ giúp em chỗ sai."; `\goiy` "đứng riêng với" → "đang được ghép với … như thế nào"; tab Nghiệp vụ mở bằng "Lập nhóm…". | bộ kiểm 0 lỗi |
| jelly-r8-giao-dich-thang-8-thua | C (lỗi nặng 3): bỏ wrong `van_thieu_can_tren` (trùng starter); bỏ điều kiện gói Booster Bundle (xét mọi giao dịch GB tháng 8, thêm cột `product_type`) để public có giao dịch ngày 1/8, nhờ đó wrong `lon_hon_thay_lon_hon_bang` rớt ở public; giữ `between_gom_ca_ngay_1_9` (rớt hidden-1). `\boicanh` bỏ bị động; `yeucau` "Truy vấn vẫn phải đúng…"; `\luuy` theo câu C đề xuất. | bộ kiểm 0 lỗi |
| jelly-r9-phien-dai-15-8 | B: thêm wrong `tieu_chi_phu_nguoc_chieu` (`session_id DESC`, rớt public và hidden-1), bỏ `sap_theo_gio_mo`; `\tieude` "Danh sách phiên dài nhất ngày 15/8 toàn phiên vài phút"; lời nhắn đổi câu kết (nêu hạn gửi chiều nay); tab Nghiệp vụ mở bằng "Gửi…". | bộ kiểm 0 lỗi |
| jelly-n1-iap-khong-gan-man | C (lỗi nặng 2): `\luuy` sửa theo dữ liệu (đã kiểm: 630 giao dịch Booster Bundle ở `'Shop screen'` đều có `level_id_if_relevant`; ô trống chỉ gồm Starter Pack, Piggy Bank, Season Pass) → "Một số gói mua ở cửa hàng vẫn ghi màn chơi đi kèm, nên ô trống không trùng với giao dịch ở cửa hàng."; ERD bỏ dấu `*` ở `screen_context`; `\boicanh` bỏ "hay … hay"; tab Nghiệp vụ bỏ khuôn "mệnh đề: …", mở bằng "Quyết định…". | tĩnh (SQL không đổi) |
| jelly-n2-chua-tiep-xuc-ab | B: thống nhất "tiếp xúc ưu đãi" ở `\tieude`, dòng mở và `\luuy`; lời nhắn "chưa thấy ưu đãi". | tĩnh |
| jelly-n3-nhom-luot-di-du | C: `\boicanh` "xếp … theo" → "chia … thành nhóm theo"; `\luuy` thêm "Lượt bỏ cuộc và lượt gặp sự cố được ghi còn 0 lượt đi." (đã kiểm trên dữ liệu). | tĩnh |
| jelly-n4-tong-doanh-thu-ngay | B: `\luuy` theo câu B đề xuất; `\ghichuthietke` giải thích dạng B1 theo kỹ năng (chuỗi 7 ngày), bỏ lý do "tránh trùng ô". | tĩnh |
| jelly-n5-gia-quy-doi-vnd | C: `\tieude` "Giá các gói vật phẩm quy ra đồng"; "trình duyệt" → "trình lãnh đạo duyệt"; `\goiy` về `ROUND` âm viết lại; ghi rủi ro chép kết quả vào `\ghichuthietke`. | tĩnh |
| jelly-n6-ngay-choi-khong-doanh-thu | B: `yeucau` bỏ phẩy trước "và", sửa trật tự "tổng doanh thu IAP và doanh thu quảng cáo bằng 0"; `\boicanh` bỏ "ngày chơi của người chơi". | tĩnh |
| jelly-n7-crash-khoang-trang | C: thêm wrong `bo_khoang_ngay` (sửa đúng chuỗi nhưng xoá điều kiện tháng, rớt public); lời nhắn đổi câu kết ("Em gửi truy vấn đây, nhờ anh chị kiểm tra lại."), "mà" → "thì". | bộ kiểm 0 lỗi |
| jelly-n8-ty-le-sai-chia | B: `\tieude` thêm "với"; lời nhắn "ARPDAU từng ngày", bỏ "mà" và câu kết "Anh chị xem giúp em". | tĩnh |
| jelly-n9-nhan-nguoi-tra-tien | C: `\tieude` nêu triệu chứng "Nhóm trả tiền gồm mọi người chơi"; `yeucau` đưa phạm vi ngày lên đầu; lời nhắn "mà" → "nhưng", câu kết "Nhờ anh chị xem lại điều kiện gán nhãn giúp em." | tĩnh |
| jelly-c1-quang-cao-co-thuong | B: "vài cent" → "chưa tới 0,1 USD"; bớt lặp "đem lại" (C). | tĩnh |
| jelly-c2-gia-goi-ban-chay | C: bớt lặp "đem về" trong ba phương án. | tĩnh |

Khuôn lặp đã phá: lời nhắn câu Sửa lỗi không còn câu kết chung "Anh chị xem giúp em." (r7, r9, n7, n8, n9 mỗi câu một cách); dòng mở tab Nghiệp vụ "Chọn …" còn 0/20 câu (r1, r3, r4, r5, r6, r7, r9, n1 đổi sang Lập, Xác định, Lấy, Gửi, Quyết định).

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **r3, r6, n5 – hai biến thể cùng kết quả** (trước ở mục Chờ giảng viên): `mysql/jelly/04_bo_sung_bien_the_jelly.sql` bổ sung (e)–(g) (xem `mysql/README-jelly.md`). Chạy solution trên `jelly` và `jelly_hidden_1` (user `sql_runner`): r3 ra 5 màn thay vì 4 (màn 45 đổi nhãn `'super_hard'`), r6 ra 3 sự kiện thay vì 2 (thêm Jungle Jam Weekend 31/7 – 2/8), n5 ra 6 dòng thay vì 5 (Starter Pack giá khuyến mãi 0,49 USD). Chép kết quả Chạy thử nay rớt ở hidden-1; ghi chú thiết kế ba câu đã sửa theo. r8 (gắn cứng ngày cuối) vẫn chưa bắt được, giữ ở dưới.

## Chờ giảng viên (đã quyết hết ở mục "Quyết định v3 (10/11)" bên dưới)

1. **n5 – lời đề chưa khớp hidden-1 mới:** hidden-1 có Starter Pack hai mức giá (0,99 và 0,49 USD khuyến mãi) nên solution ra 6 dòng, trong khi bối cảnh nói "năm gói" và yêu cầu "mỗi gói vật phẩm một dòng". Cần chốt sửa lời đề (ví dụ "mỗi cặp tên gói và giá một dòng"); lượt dọn 10/11 chỉ sửa ghi chú, không sửa đề.
2. **r8 – cách gắn cứng `<= '2026-08-29'` chưa bị bắt** vì không biến thể nào có giao dịch GB ngày 30–31/8. Cần dev thêm một giao dịch GB ngày 2026-08-30 vào hidden-1 rồi bổ sung wrong `gan_cung_ngay_cuoi`.
3. **n1 – ý nghĩa `level_id_if_relevant` với Booster Bundle mua ở cửa hàng** (màn sắp chơi hay màn gần nhất): `\luuy` đã sửa theo dữ liệu nhưng không khẳng định ý nghĩa; người nắm domain xác nhận cách diễn đạt.
4. **n3 – lượt bỏ cuộc, gặp sự cố ghi 0 lượt đi** nên bị gán `'het_luot_di'`. Đã nêu trong `\luuy`; giảng viên chốt có giới hạn câu ở lượt `'complete'` và `'fail_out_of_moves'` hay không.
5. **Mã và ô do bản đồ đặt:** n3 `nhom-buoc-du` dùng "bước" cho moves; n7 `crash-null` nhưng bẫy là khoảng trắng; n9 `domain=customer` (STYLE G xếp người chơi trả tiền vào `sales`); c1 bước 1 dùng `GROUP BY` vượt kỹ năng Module 1–2. Không đổi mã theo quy tắc của brief.

## Quyết định v3 (10/11)

Căn cứ domain: thư mục `Project DA\Game\` – `Jelly_Trail_Academy_v2\docs\data_dictionary.md` (DD), `Jelly_Trail_Academy_v2\README.md`, `JELLY_TRAIL_ACADEMY_BUSINESS_ANALYTICS_V2_QA_FINAL.docx` (QA); quy ước chung `QUYET-DINH-CHUNG.md` (QDC).

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| jelly-n5 | Lời đề "năm gói" lệch hidden-1 | Đã sửa trước (10/11 21:05) | BAO-CAO-TONG-HOP 3.1 | – (không đổi thêm) |
| jelly-r8 | Gắn cứng `<= '2026-08-29'` vẫn qua | Thêm giao dịch GB 30/8 vào hidden-1 và wrong mới | QDC 1.10 "Mốc thời gian: ghi cả cận dưới và cận trên (biến thể ẩn có dòng ngoài kỳ)"; DD: dữ liệu dừng 29/8 | File 04 mục (j): `jta_user_000648` có phiên `jta_session_00122702`, giao dịch `jta_txn_00002664` (Booster Bundle 4,99, 2026-08-30, màn 57), dòng `player_daily`, `daily_kpi` 30/8; thêm wrong `gan_cung_ngay_cuoi` (rớt hidden-1), thêm bẫy `gan-cung-ngay-cuoi`, `\ghichuthietke` bỏ "chờ giảng viên" |
| jelly-n1 | Ý nghĩa `level_id_if_relevant` với Booster Bundle mua ở cửa hàng | Giữ `\luuy` trung tính v2 | DD (`purchases.csv`: chỉ nêu tên cột, không định nghĩa màn nào); QA mục 4.2 chỉ xếp gói theo doanh thu | Không đổi |
| jelly-n3 | Lượt bỏ cuộc, gặp sự cố ghi 0 lượt đi | Giữ v2 (đã nêu ở `\luuy`) | Data Intro docx mục luồng chơi: "win/fail/quit/crash" là kết quả lượt; dữ liệu ghi `moves_left` = 0 cho quit, crash | Không đổi nội dung; mã đổi (dòng dưới) |
| jelly-n3 | Mã dùng "bước" cho lượt đi | Đổi mã | STYLE-jelly A.2 (lượt đi = moves) | `jelly-n3-nhom-buoc-du` → `jelly-n3-nhom-luot-di-du` ở cau-hoi.tex, solution.sql, BANG-PHAN-CONG, DA-SUA, BAN-DO |
| jelly-n7 | Mã ghi `null`, bẫy là khoảng trắng | Đổi mã | Nội dung câu (bẫy `'Crash '`) | `jelly-n7-crash-null` → `jelly-n7-crash-khoang-trang`; `\ghichuthietke` cập nhật |
| jelly-n9 | `domain=customer` | Đổi sang `sales` | STYLE-jelly G (`sales`: người chơi trả tiền) | Khoá `domain`; BAN-DO dòng n9 và bảng dạng × mảng (A3: customer 2→1, sales 1→2), tổng mảng |
| jelly-c1 b1 | Case Cơ bản dùng `GROUP BY`, `SUM` | Cho phép, giữ SQL | QDC 1.2 | `\ghichuthietke` thêm dòng "Case Cơ bản: GROUP BY một cột trên một bảng, theo case mẫu c1 (QUYET-DINH-CHUNG 1.2)." |

### Theo quy chuẩn (QUYET-DINH-CHUNG mục 0.1, sửa 23:05)

- Kết luận case: phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. " (theo 4 case mẫu `quy_chuan/goi-cau-hoi-mau`). Đổi máy, chỉ ở lời giải thích, không đổi nội dung phương án.

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu gồm 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug; case giữ cấp. Căn cứ: `quy_chuan/lo-trinh-sql/assets/js/data.js` (M1: Trung bình = `LIKE, IN, BETWEEN` gộp; Khó = sửa lỗi `NOT IN` + thứ tự AND/OR. M2: Trung bình = `NULLIF, ROUND`; Khó = `COALESCE` + `CASE` lồng, ghép chuỗi), CHOT-FORMAT mục 3 (ERD theo cấp), HD mục 5–6, QUYET-DINH-CHUNG mục 0–2.

**Phân bố cấp** (không tính case):

| Module | Trước (v3) | Sau (v4) |
|---|---|---|
| M1 Retrieval | 5 Cơ bản (r1, r2, r3, r6, r7) · 4 Dễ (r4, r5, r8, r9) | 2 Cơ bản (r1, r7) · 3 Dễ (r4, r5, r8) · 2 Trung bình (r2, r6) · 2 Khó (r3, r9) |
| M2 NULL & Expressions | 3 Cơ bản (n1, n2, n7) · 6 Dễ (n3, n4, n5, n6, n8, n9) | 2 Cơ bản (n1, n7) · 3 Dễ (n3, n4, n9) · 2 Trung bình (n2, n6) · 2 Khó (n5, n8) |

Số câu viết lại: 8 (số tối thiểu: mỗi module 3 câu ở cấp thừa phải lên Trung bình/Khó, cộng 1 câu nữa vì cần 4 câu ở hai cấp mới). Hình thức giữ nguyên từng câu (write vẫn write, debug vẫn debug), nên mỗi module vẫn 6 write + 3 debug.

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (số bảng lời giải · số bước · mức mơ hồ · số bẫy · độ sâu nghiệp vụ) |
|---|---|---|---|
| `jelly-r2-giao-dich-season-pass` → `jelly-r2-goi-tam-trung-chau-my` | Cơ bản → Trung bình | Viết lại: giao dịch gói tầm trung ở Mỹ và Brazil tuần cuối tháng 7, lọc theo `event_time` (có giờ). Nhóm gói tầm trung và giá niêm yết ở tab Nghiệp vụ. ERD 3 bảng ký hiệu n-1. 3 wrong mới | 1 bảng (Cơ bản) · 1 tầng (Cơ bản) · tra nhóm gói ở tab Nghiệp vụ (TB) · 2 bẫy: `BETWEEN` trên cột có giờ mất ngày 31/7, `OR` không ngoặc (TB) · điều kiện theo thời điểm (TB) → 3/5 TB |
| `jelly-r3-man-sieu-kho` → `jelly-r3-luot-bat-thuong-volcano` | Cơ bản → Khó | Viết lại: lượt chơi kết thúc bất thường (quit, crash) ở màn khó trở lên của Chocolate Volcano, Android, Đông Nam Á, bản 2.1.1. Mảng operations → after_sales. ERD 5 bảng chỉ khoá, `\erdkhoa`. 4 wrong mới | 1 bảng · 1 tầng · đề nói bằng lời nghiệp vụ, tự đổi sáu khái niệm ra cột, giá trị (Khó) · 3 bẫy, bẫy `= 'super_hard'`/chép mã màn 46, 60 chỉ lộ ở hidden-1 (màn 59 đổi nhãn, file 04 mục f) (Khó) · định nghĩa nhiều điều kiện (Khó) → 3/5 Khó |
| `jelly-r6-su-kien-thang-8` → `jelly-r6-su-kien-ky-14-ngay` | Cơ bản → Trung bình | Đề chỉ cho ngày đầu (26/7) và độ dài kỳ (14 ngày); học viên tự tính ngày cuối 8/8; quy tắc ``có ít nhất một ngày chạy trong kỳ'' chuyển sang tab Nghiệp vụ. Thêm `event_id` vào cột ra và tiêu chí phụ. ERD 3 bảng ký hiệu 1-n. Thêm wrong `can_cuoi_mo_sai` | 1 bảng · 1 tầng · tự suy ra ngày cuối kỳ và điều kiện giao hai khoảng (TB) · 2 bẫy: sự kiện vắt qua mốc đầu, sự kiện bắt đầu đúng ngày cuối kỳ (TB) · điều kiện theo thời điểm (TB) → 3/5 TB |
| `jelly-r9-phien-dai-15-8` → `jelly-r9-phien-ios-ban-cu` | Dễ → Khó (debug) | Viết lại: phiên iOS ở VN chưa cập nhật lên bản 2.1, vào từ `home`/`map`, từ 25/8 tới ngày mới nhất. Starter 3 lỗi chồng nhau (thiếu ngoặc quanh OR, `<> '2.1.1'` còn lấy 2.1.0, gắn cứng ngày cuối 29/8). ERD 5 bảng trung tính. 3 wrong mới | 1 bảng · 1 tầng · ``chưa cập nhật lên bản 2.1'' phải tự đổi ra phiên bản (Khó) · 3 lỗi chồng nhau, lỗi ngày cuối chỉ lộ ở hidden-1 (phiên 1/9, 2/9 của người chơi iOS VN bản 2.0.2, file 04 mục e) (Khó, dòng Sửa lỗi của QDC 2.2) · nhiều điều kiện (Khó) → 3/5 Khó |
| `jelly-n2-chua-tiep-xuc-ab` → `jelly-n2-ty-le-chua-tiep-xuc-nhanh` | Cơ bản → Trung bình | Viết lại: tỷ lệ chưa tiếp xúc ưu đãi của từng nhánh và chênh lệch điểm phần trăm (một dòng). Dạng A1 → A2. ERD 3 bảng. 3 wrong mới | 1 bảng · 2 tầng (đếm có điều kiện, chia rồi trừ) (Dễ/TB) · công thức ở tab Nghiệp vụ (TB) · 2 bẫy: `COUNT(exposed_at)` bỏ ô trống, mẫu số cả hai nhánh (TB) · công thức hai thành phần (TB) → 3/5 TB |
| `jelly-n5-gia-quy-doi-vnd` → `jelly-n5-mo-ta-giao-dich-vn` | Dễ → Khó | Viết lại: dòng mô tả `'<gói> - <nơi mua> - <mức giá>'` cho giao dịch ở VN từ 27/8 tới ngày mới nhất, dùng `CONCAT`, `COALESCE`, `CASE` lồng so với giá niêm yết. ERD 5 bảng chỉ khoá. 4 wrong mới | 1 bảng · biểu thức lồng ba tầng (TB) · mẫu mô tả, giá niêm yết chỉ ở tab Nghiệp vụ (Khó) · 4 bẫy, hai bẫy chỉ lộ ở hidden-1: nhánh khuyến mãi và ngày 1/9 (Starter Pack 0,49 USD, file 04 mục e) (Khó) · nhãn nhiều điều kiện (Khó) → 3/5 Khó |
| `jelly-n6-ngay-choi-khong-doanh-thu` → `jelly-n6-ty-trong-iap-man-28-30` | Dễ → Trung bình | Viết lại: doanh thu IAP tháng 7 của giao dịch gắn màn 28–30, phần còn lại (kể cả giao dịch không gắn màn) và tỷ trọng. Dạng A2 → C2. ERD 3 bảng. 3 wrong mới | 1 bảng · 2 tầng (cộng có điều kiện, rồi chia) · phạm vi phần còn lại ở tab Nghiệp vụ (TB) · 2 bẫy: `NOT BETWEEN` bỏ ô trống, làm tròn trước khi nhân 100 (TB) · công thức hai thành phần (TB) → 3/5 TB |
| `jelly-n8-ty-le-sai-chia` → `jelly-n8-ty-le-su-co-tron-chuc` | Dễ → Khó (debug) | Viết lại: tỷ lệ sự cố trên 1.000 phiên theo ngày từ 23/8 tới ngày mới nhất trên `daily_kpi`. Starter 3 lỗi chồng nhau (chia cho DAU, làm tròn trước khi nhân 1.000, gắn cứng ngày cuối). Mảng finance → after_sales, dạng A2 → B1. Câu cũ cho phép chép thẳng cột `arpdau`; chỉ số mới không có cột tính sẵn. ERD 5 bảng trung tính. 3 wrong mới | 1 bảng · 1 tầng · công thức chỉ ở khái niệm (Khó) · 3 lỗi chồng nhau, lỗi ngày cuối chỉ lộ ở hidden-1 (`daily_kpi` có 30/8, 1/9, 2/9) (Khó) · sai định nghĩa chỉ số (Khó, dòng Sửa lỗi QDC 2.2) → 3/5 Khó |

**Việc tồn từ KIEM-V3:** `jelly-n9-nhan-nguoi-tra-tien` đổi khoá `domain=customer` thành `domain=sales` trong `cau-hoi.tex` (hồ sơ và BAN-DO đã ghi `sales` từ v3).

**Đi kèm:** bỏ 3 khai báo khái niệm không còn câu nào dùng (`dau`, `phien-choi`, `arpdau`). Mã mới đồng bộ ở `cau-hoi.tex`, `solution.sql`, `BANG-PHAN-CONG.md`, `BAN-DO-100-CAU.md` (8 dòng của gói 1; 4 dòng ``Ô trùng giữa các gói'' nhắc mã cũ của gói 1 đã ghi lại). ERD Trung bình 3 bảng có 2 bảng nhiễu vì Module 1–2 chưa học nối bảng (lời giải 1 bảng); theo CHOT mục 3 (3–4 bảng), đứng trên hạn mức ``Trung bình ≤ 1 bảng nhiễu'' của QDC 1.3, giống cách gói scm-1 (n5, n9) làm.

**Trùng ô:** 18 câu của gói không trùng ô dạng × mảng × cấp × hình thức. 8 ô mới (A1·sales·medium·write, A1·after_sales·hard·write, B4·marketing·medium·write, A1·operations·hard·debug, A2·marketing·medium·write, A1·sales·hard·write, C2·finance·medium·write, B1·after_sales·hard·debug) không có ở gói 2–5 lúc kiểm (11/11); các gói khác đang được sửa song song nên cần kiểm lại khi gộp.

**Kiểm:**
- Bộ kiểm đầy đủ trên MySQL (public + hidden-1): `cong-cu/ket-qua/cap-do/jelly-goi-1/bao-cao-import.json` → 20 câu, `KIEM TRA: 0 loi`, 0 cảnh báo. Mọi wrong rớt ≥ 1 biến thể; mọi solution mới ra kết quả hidden-1 khác public; solution chậm nhất 1,0 giây (r3).
- Biên dịch XeLaTeX: `cong-cu/ket-qua/cap-do/jelly-goi-1/bien-dich/` → 0 lỗi LaTeX, 0 ký tự thiếu.
- Thư mục gói vẫn đúng 4 file.
