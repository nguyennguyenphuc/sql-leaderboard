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
| jelly-n3-nhom-buoc-du | C: `\boicanh` "xếp … theo" → "chia … thành nhóm theo"; `\luuy` thêm "Lượt bỏ cuộc và lượt gặp sự cố được ghi còn 0 lượt đi." (đã kiểm trên dữ liệu). | tĩnh |
| jelly-n4-tong-doanh-thu-ngay | B: `\luuy` theo câu B đề xuất; `\ghichuthietke` giải thích dạng B1 theo kỹ năng (chuỗi 7 ngày), bỏ lý do "tránh trùng ô". | tĩnh |
| jelly-n5-gia-quy-doi-vnd | C: `\tieude` "Giá các gói vật phẩm quy ra đồng"; "trình duyệt" → "trình lãnh đạo duyệt"; `\goiy` về `ROUND` âm viết lại; ghi rủi ro chép kết quả vào `\ghichuthietke`. | tĩnh |
| jelly-n6-ngay-choi-khong-doanh-thu | B: `yeucau` bỏ phẩy trước "và", sửa trật tự "tổng doanh thu IAP và doanh thu quảng cáo bằng 0"; `\boicanh` bỏ "ngày chơi của người chơi". | tĩnh |
| jelly-n7-crash-null | C: thêm wrong `bo_khoang_ngay` (sửa đúng chuỗi nhưng xoá điều kiện tháng, rớt public); lời nhắn đổi câu kết ("Em gửi truy vấn đây, nhờ anh chị kiểm tra lại."), "mà" → "thì". | bộ kiểm 0 lỗi |
| jelly-n8-ty-le-sai-chia | B: `\tieude` thêm "với"; lời nhắn "ARPDAU từng ngày", bỏ "mà" và câu kết "Anh chị xem giúp em". | tĩnh |
| jelly-n9-nhan-nguoi-tra-tien | C: `\tieude` nêu triệu chứng "Nhóm trả tiền gồm mọi người chơi"; `yeucau` đưa phạm vi ngày lên đầu; lời nhắn "mà" → "nhưng", câu kết "Nhờ anh chị xem lại điều kiện gán nhãn giúp em." | tĩnh |
| jelly-c1-quang-cao-co-thuong | B: "vài cent" → "chưa tới 0,1 USD"; bớt lặp "đem lại" (C). | tĩnh |
| jelly-c2-gia-goi-ban-chay | C: bớt lặp "đem về" trong ba phương án. | tĩnh |

Khuôn lặp đã phá: lời nhắn câu Sửa lỗi không còn câu kết chung "Anh chị xem giúp em." (r7, r9, n7, n8, n9 mỗi câu một cách); dòng mở tab Nghiệp vụ "Chọn …" còn 0/20 câu (r1, r3, r4, r5, r6, r7, r9, n1 đổi sang Lập, Xác định, Lấy, Gửi, Quyết định).

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **r3, r6, n5 – hai biến thể cùng kết quả** (trước ở mục Chờ giảng viên): `mysql/jelly/04_bo_sung_bien_the_jelly.sql` bổ sung (e)–(g) (xem `mysql/README-jelly.md`). Chạy solution trên `jelly` và `jelly_hidden_1` (user `sql_runner`): r3 ra 5 màn thay vì 4 (màn 45 đổi nhãn `'super_hard'`), r6 ra 3 sự kiện thay vì 2 (thêm Jungle Jam Weekend 31/7 – 2/8), n5 ra 6 dòng thay vì 5 (Starter Pack giá khuyến mãi 0,49 USD). Chép kết quả Chạy thử nay rớt ở hidden-1; ghi chú thiết kế ba câu đã sửa theo. r8 (gắn cứng ngày cuối) vẫn chưa bắt được, giữ ở dưới.

## Chờ giảng viên

1. **n5 – lời đề chưa khớp hidden-1 mới:** hidden-1 có Starter Pack hai mức giá (0,99 và 0,49 USD khuyến mãi) nên solution ra 6 dòng, trong khi bối cảnh nói "năm gói" và yêu cầu "mỗi gói vật phẩm một dòng". Cần chốt sửa lời đề (ví dụ "mỗi cặp tên gói và giá một dòng"); lượt dọn 10/11 chỉ sửa ghi chú, không sửa đề.
2. **r8 – cách gắn cứng `<= '2026-08-29'` chưa bị bắt** vì không biến thể nào có giao dịch GB ngày 30–31/8. Cần dev thêm một giao dịch GB ngày 2026-08-30 vào hidden-1 rồi bổ sung wrong `gan_cung_ngay_cuoi`.
3. **n1 – ý nghĩa `level_id_if_relevant` với Booster Bundle mua ở cửa hàng** (màn sắp chơi hay màn gần nhất): `\luuy` đã sửa theo dữ liệu nhưng không khẳng định ý nghĩa; người nắm domain xác nhận cách diễn đạt.
4. **n3 – lượt bỏ cuộc, gặp sự cố ghi 0 lượt đi** nên bị gán `'het_luot_di'`. Đã nêu trong `\luuy`; giảng viên chốt có giới hạn câu ở lượt `'complete'` và `'fail_out_of_moves'` hay không.
5. **Mã và ô do bản đồ đặt:** n3 `nhom-buoc-du` dùng "bước" cho moves; n7 `crash-null` nhưng bẫy là khoảng trắng; n9 `domain=customer` (STYLE G xếp người chơi trả tiền vào `sales`); c1 bước 1 dùng `GROUP BY` vượt kỹ năng Module 1–2. Không đổi mã theo quy tắc của brief.
