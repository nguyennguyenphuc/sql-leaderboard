# Kiểm độc lập v3 · bộ `jelly` (10/11/2026)

Người kiểm: agent kiểm độc lập (không tham gia sửa). Làm theo `BRIEF-KIEM-V3.md`. Không sửa `cau-hoi.tex` hay `solution.sql`.

Thứ tự ưu tiên khi đối chiếu: `quy_chuan\` > `QUYET-DINH-CHUNG.md` (QDC) > `style/STYLE-jelly.md` > brief.

Danh sách câu đổi lấy từ `QUYET-DINH-126.md`, mục "Quyết định v3" trong `ho-so/goi-*/DA-SUA.md` và `ho-so/CHUAN-HOA.md`. Bỏ qua các mục "Giữ nguyên" không sửa gì: n1, n3 (nội dung), s1, a4, t4, j5. Bỏ qua n5 vì sửa trước v3.

Cách kiểm:
- Tự viết SQL trước khi mở solution: r8, k1, c9 b2, f6, t7. Chạy trên `jelly` và `jelly_hidden_1` bằng user `sql_runner`, rồi so từng dòng với solution.
- Chạy starter và mọi wrong của các câu này trên cả hai biến thể.
- Chạy `kiem_tra_goi.py` cả 5 gói: `--chi-phan-tich` cho ra 0 lỗi ở cả 5 gói. Lượt chạy đủ trên MySQL: xem cuối file.
- Kiểm tĩnh bằng script riêng trên cả 100 câu: số phương án, tiền tố, số tiếng của lời giải thích, tiêu đề, ERD Khó.
- Mở các căn cứ được dẫn: `data_dictionary.md`, `README.md` của Jelly_Trail_Academy_v2, text của `..._QA_FINAL.docx`, HD mục 6, gói mẫu c2, QDC 0.1, 1.x, 2.x.

## 1. Câu đổi SQL, yêu cầu, cấp, mã, mảng

| Mã | Đã đổi gì | Tự giải (public / hidden-1) | Căn cứ | Giọng văn | Kết luận + đề xuất |
|---|---|---|---|---|---|
| jelly-r8-giao-dich-thang-8-thua (g1) | hidden-1 có thêm giao dịch GB 30/8 (`jta_txn_00002664`). Thêm wrong `gan_cung_ngay_cuoi` | **Khớp** (`>= '2026-08-01' AND < '2026-09-01'`): 96 / 81 dòng. Hai biến thể khác nhau. Starter khớp public, rớt hidden-1 (thừa 30/8 và 1/9). Wrong `between` rớt hidden-1, wrong `lon_hon` rớt cả hai, wrong `gan_cung` rớt hidden-1 (thiếu dòng 30/8) | Khớp: QDC 1.10 về mốc thời gian có hai cận. DD: dữ liệu dừng ở 29/8 | Đạt (ghi chú thiết kế có thêm câu v3, đề không đổi) | **Đạt** |
| jelly-k1-trung-khoa (g5) | Bảng thứ hai đổi từ `tutorial_steps` sang `sessions` (khoá `user_id`, `session_start`). Đổi lời nhắn, yêu cầu, ERD, `\luuy`, bẫy, 2 wrong | **Khớp** (`COUNT(DISTINCT user_id, session_start)` + `UNION ALL`): `sessions` thừa 57 / 52 dòng, `player_daily` thừa 0 / 0. Hai biến thể khác nhau. Cả 2 wrong rớt ở cả hai biến thể. Bài trả hằng 0 nay rớt | Khớp: mọi bảng có khoá chính (`01_tao_bang_jelly.sql`), số dòng thừa đúng như ghi | Đạt. `\luuy` về mã phiên gợi bẫy vừa đủ | **Đạt** |
| jelly-c9-ab-mua-them-buoc (g5) | b2 đổi nguồn sang cờ `level_attempts.extra_moves_purchased` (ITT). Thêm wrong `dem_giao_dich_goi_thay_co`. Viết lại các phương án; chuẩn hoá còn 3 | **Khớp** b2 (`LEFT JOIN`, ngày lượt chơi từ D0 tới D0+6): public A 0,0747, B 0,0838; hidden-1 A 0,0729, B 0,0826. Hai biến thể khác nhau, cùng chiều. Wrong `chi_tinh_nguoi_da_tiep_xuc` rớt cả hai. Wrong SQL cũ rớt cả hai (cho ra chiều ngược: A 0,0253 > B 0,0241) | Khớp: QA chương V. Tử số lấy cờ (`level_attempts.extra_moves_purchased`, không lấy SKU), ITT, p = 0,094, CI95 chứa 0. Lời "khoảng một phần mười" khớp số đo (+12%) | 3 phương án, đúng một `\phuongan*`, "Đúng: " 30 tiếng, hai phương án sai 26/28 tiếng, không tiền tố | **Đạt**. Riêng hồ sơ: `QUYET-DINH-126.md` dòng 5 ("4 phương án viết lại") và mục 3.5 ("c9, c10 vẫn 4 phương án") đã lỗi thời so với CHUAN-HOA. Sửa thành "3 phương án (chuẩn hoá 10/11)" |
| jelly-f6-chia-4-nhom-chi (g4) | Viết lại bằng `NTILE(4)`. Đổi mã từ `jelly-f6-nguoi-chi-top-quoc-gia`. Solution và 3 wrong mới | **Khớp** (CTE tổng chi theo `country, user_id`, `< '2026-08-30'`; `NTILE(4) … ORDER BY chi DESC, user_id`): 32 dòng ở cả hai biến thể. Hai biến thể khác nhau. Wrong `thieu_partition_by` và `chia_theo_so_giao_dich` rớt cả hai. Wrong `thieu_can_tren` rớt hidden-1. Không có giao dịch hoàn tiền (`is_refund` = 0 hết) nên "mọi giao dịch" không mơ hồ | Khớp: QDC 2.3 mục 8. Lập luận "kết quả không phụ thuộc quy tắc phụ khi hoà" đúng, vì hai người cùng tổng chi đổi chỗ ở ranh giới nhóm không làm đổi số người, mức chi thấp nhất hay tổng chi | Đạt | **Đạt**. Grep mã cũ: 0 trong `cau-hoi.tex`, `solution.sql`, `BAN-DO`. Còn ở hồ sơ (DA-SUA g4 dòng đổi mã, REVIEW-B g4, QUYET-DINH-126): đây là ghi chép lịch sử hoặc bảng đổi mã cũ → mới, chấp nhận |
| jelly-t7-union-doanh-thu (g4) | Hạ cấp Trung bình → Dễ. ERD còn 2 bảng có giá trị mẫu, bỏ `users`. Cập nhật BAN-DO | **Khớp** (đổi `UNION` thành `UNION ALL`). Starter rớt cả hai (IAP 20,95 thay vì 2.448,37). Wrong thiếu cận trên rớt cả hai | Cấp Dễ khớp HD mục 6 (Sửa lỗi Dễ: `COUNT(*)` thay `COUNT(DISTINCT)`, cùng loại lỗi một từ khoá về dòng trùng) và QDC 0.1 #5, 2.3 #7. **Mâu thuẫn trong QDC:** gạch đầu dòng 3 của mục 2.1 lại lấy "`UNION` bỏ mất dòng trùng hợp lệ" làm ví dụ lỗi Trung bình. Theo quy chuẩn (HD mục 6) thì Dễ đúng | Đạt | **Đạt** (câu). Đề xuất: (1) QDC 2.1 bỏ ví dụ "`UNION` bỏ mất dòng trùng" khỏi nhóm Trung bình, hoặc nói rõ chỉ tính Trung bình khi lỗi khó thấy hơn. (2) DA-SUA g4 bảng "Quyết định v3", dòng t7 vẫn ghi "Giữ Trung bình / Không sửa", trái với mục "Theo quy chuẩn" ngay dưới: sửa thành "Hạ Dễ (chấm lại 23:05)". (3) ERD Dễ không có đường nối vì hai bảng ghép bằng phép hợp, không nối. Không trái CHOT; đã có lý do trong ghi chú thiết kế |
| jelly-f9-ty-trong-goi (g4) | Chấm lại, giữ Trung bình. Ghi lý do ở `\ghichuthietke` | SQL không đổi (bộ kiểm cả gói 4 ở DA-SUA: 20/20 OK) | Khớp: QDC 2.2 dòng Sửa lỗi (Trung bình là sai phạm vi cửa sổ) và 2.3 #3 | Đạt | **Đạt**. DA-SUA g4 dòng f9 trong bảng v3 vẫn dẫn căn cứ cũ "M7, M8 không có Dễ"; đổi thành "lỗi khó thấy, QDC 2.3 mục 3, 7" |
| jelly-n3-nhom-luot-di-du (g1) | Đổi mã từ `nhom-buoc-du` | SQL không đổi | Khớp STYLE-jelly A.2 | – | **Đạt**. Mã cũ: 0 trong tex, sql, BAN-DO. Còn ở BANG-PHAN-CONG, DA-SUA, REVIEW-C g1, QUYET-DINH-126 (ghi chép đổi mã, lịch sử) |
| jelly-n7-crash-khoang-trang (g1) | Đổi mã từ `crash-null` | SQL không đổi | Khớp (bẫy là `'Crash '`) | – | **Đạt** (giống n3) |
| jelly-q4-ngay-dau-tren-tb-thang (g3) | Đổi mã từ `ngay-dau-cao-nhat` | SQL không đổi | Khớp | `\ghichuthietke` sai sự thật | **Cần sửa**. `goi-3/cau-hoi.tex` dòng 446, `\ghichuthietke` vẫn ghi: "Mã giữ `ngay-dau-cao-nhat` dù nội dung là so với bình quân tháng (quy tắc không đổi mã)." Mã cũ còn trong file gói (grep ≠ 0) và câu này trái với v3. Đề xuất thay bằng: "v3 (10/11): đổi mã từ `ngay-dau-cao-nhat` cho khớp nội dung so với bình quân tháng." hoặc bỏ hẳn câu. Thêm: DA-SUA g3 mục "Chờ giảng viên" số 2 bị thay chuỗi máy móc, nay đọc là "đổi mã thành `jelly-q4-ngay-dau-tren-tb-thang` hay không" (mã mới đổi thành chính nó). Khôi phục mã cũ ở câu lịch sử này |
| jelly-n9-nhan-nguoi-tra-tien (g1) | `domain=customer` → `sales` (theo DA-SUA, QUYET-DINH-126 dòng 22) | SQL không đổi | Quyết định khớp STYLE-jelly G | – | **Cần sửa (nặng)**. `goi-1/cau-hoi.tex` dòng 492 **vẫn `domain=customer`** (git diff: dòng này không đổi), trong khi BAN-DO dòng 39 và thống kê A3 đã ghi `sales`. Sửa khoá `domain=sales` trong tex rồi chạy lại `kiem_tra_goi.py` gói 1. Hồ sơ đang báo "Đã sửa" sai |
| jelly-j4-cpi-theo-kenh (g3) | `domain` finance → marketing | SQL không đổi | Khớp QDC 1.5 và STYLE G. Ô C3 · finance · medium · write nay chỉ còn q5 | Đạt | **Đạt** (tex, `\ghichuthietke`, BAN-DO dòng 75 và 221 khớp nhau) |

## 2. Câu chỉ đổi lời

| Mã | Đã đổi gì | Tự giải | Căn cứ | Giọng văn | Kết luận + đề xuất |
|---|---|---|---|---|---|
| jelly-c8-doanh-thu-giam-vi-dau (g4) | Tiêu đề b2 thêm "(cent)" | – (SQL không đổi) | Khớp: QA chương I ghi "ARPDAU toàn kỳ = 0,1199 USD/DAU-ngày" (≈ 12 cent) | Đạt | **Đạt** |
| jelly-c7-android-210 (g4) | Lời giải thích phương án C thêm số iOS 2.1.1; chuẩn hoá rút 63 → 34 tiếng | – | Khớp README ("mostly visible for Android users in SEA") | 3 phương án, "Đúng: " 26 tiếng, hai phương án sai 34/34 tiếng. Câu "iOS 2.1.1 **có** thấp hơn các nhóm iOS khác nhưng…" hơi gượng | **Đạt** (nhẹ). Đề xuất bỏ chữ "có": "iOS 2.1.1 thấp hơn các nhóm iOS khác nhưng…". Lúc rút gọn đã mất số "khoảng 3,4 điểm" và ý "chỉ đáng theo dõi thêm" mà QUYET-DINH-126 dòng 7 và DA-SUA g4 mô tả, nên cập nhật mô tả trong hồ sơ cho khớp bản hiện tại |
| jelly-c10-man-28-30 (g5) | Lời giải thích phương án nhiễu 1 nêu ba lý do; chuẩn hoá còn 3 phương án, viết lại cho cân độ dài | – (SQL không đổi) | Khớp QA mục 3.7 (phục hồi kỹ thuật chưa phải phục hồi kinh doanh). "khoảng 4 điểm" khớp 71,30 − 67,25. "iOS chưa tới 600 lượt" khớp 572 / 497 | 3 phương án 24/27/28 tiếng; lời giải thích 31/26/24 tiếng | **Đạt**. Hồ sơ: QUYET-DINH-126 mục 3.5 ghi "c10 vẫn 4 phương án", đã lỗi thời |
| jelly-c4-kenh-dong-nguoi (g2) | Rút phương án đúng | – | Khớp QA chương II | 34 tiếng, hai phương án sai 32/32 tiếng: cân. Lời giải thích 33 tiếng | **Đạt** |
| jelly-f1-top3-man-quit (g4) | `\luuy` thêm lý do xếp theo số lượt và cách tính tỷ lệ | – | Gần khớp. DD định nghĩa "Fail+quit rate = non-complete attempts / all attempts", còn `\luuy` nêu tỷ lệ bỏ cuộc = lượt `quit` / mọi lượt. Hai chỉ số khác nhau, nhưng `\luuy` không nói là lấy từ DD | Đạt | **Đạt**. Tuỳ chọn: DA-SUA nên ghi đúng tên chỉ số của DD, vì DD không nói Fail+quit rate dùng "để so độ khó" |
| jelly-k6-ad-revenue-lam-tron (g5) | `\ghichuthietke`: lệch do cách làm tròn | – | Khớp (`DECIMAL(10,5)` ở `ad_events`; lệch lớn nhất 0,00007) | Đạt | **Đạt** |
| jelly-c1-quang-cao-co-thuong b1 (g1) | `\ghichuthietke` thêm dòng QDC 1.2 | – | Khớp QDC 1.2, mẫu c1 | Đạt | **Đạt** |
| `roas` (q5, STYLE-jelly E) | Ghi chuẩn cửa sổ D7 = D0–D6, D30 = D0–D29 | – | Khớp DD "D7 ROI proxy = … cohort day 0–6" và QA (trang 6 dùng D0–D7, nên đề phải ghi cửa sổ) | Đạt | **Đạt**. Lệch nhỏ: STYLE thiếu "(\code{iap_revenue} + \code{ad_revenue})" có ở gói 3. Nên chép giống hệt |
| `kenh-thu-hut` (s9, a3, c4; STYLE-jelly E) | Chép định nghĩa gói 2 vào STYLE | – | QDC 1.8: "một định nghĩa duy nhất, chép giống hệt" | – | **Cần sửa** (nhẹ, ngoài gói). `style/STYLE-jelly.md` dòng 330–332: `\khaibaokhainiem{kenh-thu-hut}` chỉ có 3 đối số, thiếu đối số dữ liệu (`users.channel`, `users.campaign_id`, `'Organic'`/`'ORG-000'` không có chi phí, hạt của `campaign_spend`) có ở `goi-2/cau-hoi.tex` dòng 67. Chép đủ đối số thứ tư |

## 3. Vòng chuẩn hoá (CHUAN-HOA.md), kiểm trên cả 100 câu

| Hạng mục | Kết quả |
|---|---|
| Case: đúng 3 phương án, một `\phuongan*` | **Đạt**: 10/10 case (c1–c10) có 3 phương án, đúng một `\phuongan*` |
| "Đúng: " ở phương án đúng; phương án sai không tiền tố | **Đạt**: 10/10 mở bằng "Đúng: ", tiếp theo là chữ thường. 0 phương án sai có "Đúng", "Chưa đúng", "Sai" |
| Lời giải thích ≤ 35 tiếng | **Đạt**: dài nhất 34 tiếng (c7 phương án 1 và 3); 30 lời giải thích đều ≤ 35 |
| Tiêu đề ≤ 13 tiếng | **Đạt**: 100/100, dài nhất 13 tiếng (p3) |
| Câu Tối ưu nêu ràng buộc trong tiêu đề | **Đạt**: p1, p2, p3 "một lần quét"; p4 "không dùng tự nối bảng"; p5, p9 "ít/bớt dòng trung gian"; p6 "một lần đọc bảng hoạt động"; p7 "đọc ít dòng nhất" (p8 là debug) |
| Gợi ý | p9 nấc cuối là một biểu thức một dòng, không khung nhiều dòng: **Đạt** |
| ERD Khó không `\erdnoi`, có `\erdkhoa` | **Đạt**: 15 câu/case Khó (g4: t5, t6, t8, t9, f4, f5, c8; g5: k5, k6, k9, p3, p4, p8, c9, c10), 0 `\erdnoi`, đều có `\erdkhoa`, đều 5 bảng |
| c5 case Dễ, ERD 3 bảng | **Đạt**: khớp mẫu c2 của quy chuẩn (ERD cố định 3 bảng, chữ trên đường nối) |
| Thư mục gói đúng 4 file | **Đạt**: `goi-1`…`goi-5` mỗi thư mục chỉ có `aio-sql-cauhoi.sty`, `cau-hoi.tex`, `HUONG_DAN.md`, `solution.sql` (kể cả file ẩn) |
| `kiem_tra_goi.py --chi-phan-tich` | 5/5 gói: `KIEM TRA: 0 loi` |

## 4. Tổng hợp

Đã kiểm 21 mục: 11 câu đổi SQL/cấp/mã/mảng, 7 câu đổi lời, 2 khái niệm, và vòng chuẩn hoá (10 hạng mục trên cả 100 câu, tính chung là 1 mục).

- **Đạt: 18** (r8, k1, c9, f6, t7, f9, n3, n7, j4, c8, c7, c10, c4, f1, k6, c1, roas, cùng 10/10 hạng mục chuẩn hoá tính chung là 1).
- **Cần sửa: 3**
  1. **jelly-n9 (nặng):** `goi-1/cau-hoi.tex` vẫn `domain=customer`; hồ sơ và BAN-DO báo đã đổi sang `sales`.
  2. **jelly-q4:** `\ghichuthietke` còn mã cũ và câu "Mã giữ … (quy tắc không đổi mã)".
  3. **`kenh-thu-hut` ở STYLE-jelly E:** thiếu đối số dữ liệu, chưa giống hệt gói 2.
- **Hồ sơ cần cập nhật (không tính vào câu):**
  - QUYET-DINH-126 dòng 5 và mục 3.5 còn ghi c9, c10 "4 phương án".
  - DA-SUA g4 dòng t7 ghi "Giữ Trung bình", dòng f9 dẫn căn cứ cũ.
  - DA-SUA g3 mục "Chờ giảng viên" số 2 bị thay chuỗi.
  - Mô tả lời giải thích c7 C trong hồ sơ không còn khớp bản hiện tại.
  - QDC 2.1 tự mâu thuẫn về `UNION` (Trung bình hay Dễ).

Chạy đủ `kiem_tra_goi.py` trên MySQL (public + hidden-1, sau khi có dòng GB 30/8 của file 04): gói 1, 2, 3, 5 do người kiểm chạy lại hôm nay đều ra `KIEM TRA: 0 loi`; gói 4 lấy theo DA-SUA (20/20 OK, 0 lỗi), cộng với lượt tự chạy f6, t7 ở trên. Bộ kiểm không bắt được lỗi `domain` của n9, vì `customer` vẫn là mảng hợp lệ.
