# Đã sửa · gói 4 jelly (v2, sau REVIEW-B và REVIEW-C)

Kiểm lại: gói tạm `cong-cu/ket-qua/sua/jelly-goi-4/` (t4, t5, t6, c8, các câu đổi SQL) → `KIEM TRA: 0 loi`; cả gói `--chi-phan-tich` → `KIEM TRA: 0 loi`, 20/20 OK; biên dịch `cong-cu/ket-qua/bien-dich/jelly-goi-4/` → 55 trang, 0 lỗi LaTeX, 0 ký tự thiếu.

Thống nhất cả gói: `daily_kpi` gọi là "bảng chỉ số ngày" (lần đầu kèm `\code{daily_kpi}`); alias sự cố là `so_luot_su_co` (t6, f7), cột tổng hợp giữ tên `crash_count`.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| jelly-t1-pheu-huong-dan | B: tiêu đề "người chơi mới"; yêu cầu đảo trật tự "Tính Y của từng X"; `\luuy` viết lại và nêu rõ bước cần xem lại là bước có tỷ lệ hoàn thành thấp nhất; gợi ý 1 sửa "vì vậy" | tĩnh |
| jelly-t2-buoc-4-android-210 | C: tiêu đề có "không"; bối cảnh có lời nhờ; "từng nhóm phiên bản (lúc làm bước 4) và nền tảng"; `\luuy` bỏ ẩn dụ | tĩnh |
| jelly-t3-d1-d7-theo-kenh | B: yêu cầu đảo trật tự; bỏ khuôn "không chỉ"; "giá trị rỗng (NULL)" | tĩnh |
| jelly-t4-kenh-co-va-khong-chi | C: bỏ Organic (hiển nhiên không có chi phí); ghép thêm nền tảng (`target_platform` = `users.platform`), nên cả hai phía lệch đều phụ thuộc dữ liệu; tiêu đề, bối cảnh có lời nhờ, "phía lệch" thay "chiều lệch"; thêm wrong `bo_qua_nen_tang` | gói tạm: 0 lỗi, 3 wrong rớt public + hidden-1 |
| jelly-t5-doi-soat-kpi | B: kết quả không còn đoán được, thêm `so_ngay_qc_lech_neu_so_truc_tiep` (public 60, hidden-1 59) và `tong_doanh_thu_tinh_lai_usd`; thêm wrong `chi_so_dau`; tiêu đề, bối cảnh, `\luuy` theo B; một tên cho `daily_kpi`; bớt 1 bảng nhiễu | gói tạm: 0 lỗi |
| jelly-t6-crash-hai-nguon | C: alias `so_luot_su_co`; tiêu đề có "không"; dòng mở Nghiệp vụ và `\luuy` viết lại; bớt bảng nhiễu `level_metadata` | gói tạm: 0 lỗi |
| jelly-t7-union-doanh-thu | B: đạt, không sửa ở v2 (lúc đó giữ Trung bình, xem chờ giảng viên); v3 chấm lại theo quy chuẩn: **hạ Dễ** (mục "Theo quy chuẩn" bên dưới) | – |
| jelly-t8-cte-loc-sai-cho | C: yêu cầu không nói thẳng cách sửa ("Sửa để tỷ lệ đúng định nghĩa ở tab Nghiệp vụ"); `\luuy` chỉ nêu ngày phát hành 2.1.1; câu chỉ lỗi chuyển sang gợi ý 2 (trừ điểm); bớt 1 bảng nhiễu | tĩnh (SQL không đổi) |
| jelly-t9-ab-itt | B: bối cảnh nói rõ "sau 1 lần thua thay vì 3 lần" và có lời nhờ; yêu cầu 1 tách câu; gợi ý 2 thành câu hỏi gợi mở; bớt 1 bảng nhiễu | tĩnh |
| jelly-f1-top3-man-quit | C: tiêu đề chủ động; yêu cầu nêu `result = 'quit'` và nói rõ xếp theo số lượt; bỏ `\khainiem{ty-le-bo-cuoc}`, `\luuy` giải thích số lượt khác tỷ lệ | tĩnh |
| jelly-f2-dau-trot-7-ngay | B: bối cảnh bỏ "DAU", có lời nhờ; yêu cầu đảo trật tự; tên bảng chỉ số ngày | tĩnh |
| jelly-f3-luy-ke-chi | C: thêm đơn vị, làm tròn; bỏ `\khainiem{cpi}` không dùng; "dùng hết hạn mức" | tĩnh |
| jelly-f4-doanh-thu-tuan-wow | B: bỏ "nhịp"; `\luuy` khuôn "nếu … thì"; tên bảng chỉ số ngày; bớt 2 bảng nhiễu | tĩnh |
| jelly-f5-chuoi-ngay-lien-tiep | C: "trong hai tháng qua" thay "hiện nay"; giải nghĩa LiveOps; yêu cầu đảo trật tự; bớt 2 bảng nhiễu; ghi chú hidden-1 đúng thực tế | tĩnh |
| jelly-f6-chia-4-nhom-chi (v2: `jelly-f6-nguoi-chi-top-quoc-gia`) | B: hạ `cap=medium`, ERD 3 bảng có ký hiệu; bối cảnh có lời nhờ; `\luuy` bỏ hai "nên" liền nhau | tĩnh (SQL không đổi) |
| jelly-f7-rank-thay-row-number | C: bỏ `\khainiem{ty-le-su-co}` (đếm `crash_count`), `\luuy` nói rõ đếm lượt `result = 'crash'`; tiêu đề "lại ra năm màn"; "Chị Hạnh bên QA"; đổi khuôn lời nhắn thực tập sinh; gợi ý tách 2 nấc, không nói thẳng ở nấc 1 | tĩnh |
| jelly-f8-lag-khong-partition | B: hạ `cap=medium` (một lỗi), ERD 3 bảng có ký hiệu; yêu cầu 1 viết lại; "chị đoán là có chỗ sai" | tĩnh |
| jelly-f9-ty-trong-goi | C: `\luuy` viết lại theo định nghĩa | tĩnh |
| jelly-c7-android-210 | B: lời giải thích phương án A và C khớp số thật (iOS 2.1.0 ở b1, b2 chênh dưới 1 điểm, D1 có thấp hơn; iOS 2.1.1 thấp hơn các nhóm iOS khác nhưng vẫn cao hơn Android 2.1.0 ở cả ba chỉ số); `\luuy` bỏ "cùng thời điểm", nêu rõ mỗi bản ứng với một khoảng ngày; tiêu đề không khẳng định nhân quả; bối cảnh có lời nhờ; yêu cầu b1–b3 bỏ khuôn "Theo X × Y:" | tĩnh (SQL không đổi) |
| jelly-c8-doanh-thu-giam-vi-dau | C: `saiso` về 0,01; ARPDAU bước 2 tính bằng cent để vẫn phân biệt wrong; bước 1, 2, 3 ghi rõ bảng nguồn; bước 3 gọi đúng "ngày-người" (giải nghĩa), alias `iap_moi_ngay_nguoi_tra_tien_usd`; phương án đúng và lời giải thích viết lại; tiêu đề bỏ chữ viết tắt; tên wrong b4 `doi_goc_tach`; bớt 1 bảng nhiễu | gói tạm: 0 lỗi, 4 wrong rớt public + hidden-1 |

## Chờ giảng viên (v2; cả 6 mục đã quyết ở "Quyết định v3 (10/11)" bên dưới)

1. c7: có cần nhắc trong kết luận việc nhóm iOS cài 2.1.1 cũng thấp hơn các nhóm iOS khác (D1 giảm khoảng 3,4 điểm so với iOS 2.0.2) không. Bản v2 giữ phương án đúng chỉ nói Android 2.1.0, lời giải thích phương án C đã nêu số đúng.
2. f1: để chọn màn cần chỉnh độ khó, xếp theo số lượt bỏ cuộc (đề hiện tại, theo bản đồ) hay theo tỷ lệ bỏ cuộc. Bản v2 nói rõ là xếp theo số lượt và giải thích ở `\luuy`.
3. t4: cách đối soát người cài với chi phí theo chiến dịch × thị trường × ngày × nền tảng (bản v2 có ghép nền tảng) có đúng thực tế của bên thu hút người chơi (UA) không; bỏ Organic khỏi đối soát có được không.
4. t7, f9: cấp Trung bình cho lỗi một chỗ (UNION, `PARTITION BY`) hay hạ Dễ. Bản v2 giữ Trung bình. (Đã quyết theo quy chuẩn: t7 hạ Dễ, f9 giữ Trung bình; xem bảng dưới và mục "Theo quy chuẩn".)
5. Module 8 có ba câu top 3 bằng `ROW_NUMBER` (f1, f6, f7); B đề nghị đổi f6 sang kỹ năng khác (`NTILE`, `FIRST_VALUE`). Bản v2 chỉ hạ cấp f6, chưa đổi kỹ năng.
6. c8: ARPDAU ở bước 2 tính bằng cent (khác quy ước 4 chữ số USD của STYLE) để dùng sai số chung 0,01.

## Quyết định v3 (10/11)

Căn cứ domain (Google Drive `Project DA\Game\`): `JELLY_TRAIL_ACADEMY_BUSINESS_ANALYTICS_V2_QA_FINAL.docx` (gọi tắt QA), `Jelly_Trail_Academy_v2\README.md`, `Jelly_Trail_Academy_v2\docs\data_dictionary.md`; quy ước chung: `QUYET-DINH-CHUNG.md` mục 2.1, 2.3.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| jelly-c8-doanh-thu-giam-vi-dau | ARPDAU bước 2 tính bằng cent | Chấp nhận đơn vị cent | QA mục 2 (Chương I): "ARPDAU toàn kỳ = 0,1199 USD/DAU-ngày … xấp xỉ 12 cent"; Blueprint ghi ARPDAU định dạng `$0.000` nên 2 chữ số USD không đủ phân biệt | Tên cột `arpdau_cent`, `arpdau_iap_cent`, `arpdau_qc_cent` và yêu cầu b2 đã ghi "đơn vị cent USD, 1 USD = 100 cent" từ v2; v3 thêm "(cent)" vào tiêu đề bước 2. SQL không đổi |
| jelly-c7-android-210 | Có nhắc iOS 2.1.1 trong kết luận không | Giữ phương án đúng chỉ nói Android 2.1.0; ý iOS 2.1.1 để ở lời giải thích phương án C | README dataset ("The issue is mostly visible for Android users in SEA countries"); QA mục 3.7 (không suy phục hồi hay sự cố từ nhóm nhỏ, chưa đủ tuổi) | Lời giải thích C thêm số: D1 iOS 2.1.1 thấp hơn iOS 2.0.2 khoảng 3,4 điểm phần trăm; nhóm nhỏ (583 người cài, 572 lượt màn 28--30), chỉ đáng theo dõi thêm. Bốn phương án không đổi (K32 giữ nguyên). SQL không đổi |
| jelly-t4-kenh-co-va-khong-chi | Ghép 4 khoá (chiến dịch × thị trường × ngày × nền tảng), bỏ Organic | Giữ v2 | `campaign_spend` có khoá `date, campaign_id, country, target_platform` và không có dòng Organic (đã đếm trên `Data\campaign_spend.csv`: 0 dòng); QA mục 2 (Chương II): ROAS paid cohort không lấy doanh thu organic chia chi phí paid | Không sửa (`\luuy` đã nêu Organic không có chi phí) |
| jelly-f1-top3-man-quit | Xếp theo số lượt hay tỷ lệ bỏ cuộc | Giữ số lượt | Mục đích câu là chọn màn làm nhiều người chơi bỏ dở nhất cho đợt chỉnh; data_dictionary.md định nghĩa "Fail+quit rate" là chỉ số so độ khó, dùng khi so màn có lượng người tới khác nhau | `\luuy` thêm lý do chọn số lượt và cách tính tỷ lệ bỏ cuộc khi cần so độ khó. SQL không đổi |
| jelly-t7-union-doanh-thu | Cấp TB cho lỗi một chỗ | **Hạ Dễ** (sửa theo quy chuẩn; bản ghi đầu của dòng này là "Giữ Trung bình" theo ngoại lệ cũ "M7, M8 không có Dễ", ngoại lệ đó đã bỏ ở QUYET-DINH-CHUNG 0.1 #5) | HD mục 6 (Sửa lỗi Dễ = lỗi một chỗ, như `COUNT(*)` thay `COUNT(DISTINCT)`); `data.js` bài `t3-union-mat-dong` (M7, Sửa lỗi, **easy**: UNION làm mất dòng trùng giá trị); QUYET-DINH-CHUNG 2.3 mục 7 (bản 23:05) | `cap=easy`, ERD 2 bảng (`purchases`, `ad_events`) có giá trị mẫu, bỏ `users`; chi tiết ở mục "Theo quy chuẩn". SQL không đổi |
| jelly-f9-ty-trong-goi | Cấp TB cho lỗi một chỗ | Giữ Trung bình, chấm lại theo quy chuẩn (không còn dựa vào ngoại lệ "M7, M8 không có Dễ") | Sai phạm vi cửa sổ trên kết quả đã gom (hàm gộp lồng hàm cửa sổ) là lỗi khó thấy: QUYET-DINH-CHUNG 2.1 và 2.2 dòng Sửa lỗi Trung bình (bản 23:05), 2.3 mục 3 (cùng cách chấm aivb-f7) và mục 7; HD mục 6 | `\ghichuthietke` ghi lý do. SQL không đổi |
| jelly-f6-chia-4-nhom-chi | M8 có ba câu top 3 bằng `ROW_NUMBER` (f1, f6, f7) | Đổi kỹ năng sang `NTILE`; đổi mã từ `jelly-f6-nguoi-chi-top-quoc-gia` | QUYET-DINH-CHUNG 2.3 mục 8; REVIEW-B mục 5 | Viết lại đề: chia người chơi trả tiền mỗi thị trường thành 4 nhóm theo tổng chi (`NTILE(4)`), trả `country, nhom, so_nguoi, chi_thap_nhat_usd, tong_chi_usd`; kết quả không phụ thuộc quy tắc phụ khi hoà. Solution mới; 3 wrong: `thieu_partition_by`, `chia_theo_so_giao_dich` (rớt public, hidden-1), `thieu_can_tren` (rớt hidden-1, giao dịch 2026-09-01). Giữ write, Trung bình, C1, `sales` |

Kiểm lại v3: cả gói trên `jelly` + `jelly_hidden_1` (đã có dòng GB 30/8 của file 04) → `cong-cu/ket-qua/v3-jelly-goi-4/`, 20/20 OK, `KIEM TRA: 0 loi`.

### Theo quy chuẩn (QUYET-DINH-CHUNG mục 0.1, sửa 23:05)

- Kết luận case: phương án đúng mở bằng "Đúng: ", phương án sai bỏ tiền tố "Chưa đúng. " (theo 4 case mẫu `quy_chuan/goi-cau-hoi-mau`). Đổi máy, chỉ ở lời giải thích, không đổi nội dung phương án.
- jelly-t7: chấm lại theo QUYET-DINH-CHUNG 2.3 mục 7 và HD mục 6 (Sửa lỗi Dễ = lỗi một chỗ dễ thấy, như `COUNT(*)` thay `COUNT(DISTINCT)`): `UNION` thay `UNION ALL` là lỗi một từ khoá về dòng trùng → **Dễ**. ERD rút còn 2 bảng (`purchases`, `ad_events`), có giá trị mẫu cùng nền tảng, cùng số tiền làm manh mối; bỏ bảng `users`. BAN-DO cập nhật cấp và thống kê.
- jelly-f9: chấm lại, **giữ Trung bình**: sai phạm vi cửa sổ là lỗi khó thấy (cùng cách chấm aivb-f7, QUYET-DINH-CHUNG 2.3 mục 3). `\ghichuthietke` ghi lý do.

### Ghi chú: QUYET-DINH-CHUNG 2.1 mâu thuẫn với t7 (không sửa file chung)

QUYET-DINH-CHUNG 2.1 (bản 23:05) lấy "`UNION` bỏ mất dòng trùng hợp lệ" làm ví dụ lỗi khó thấy của Sửa lỗi Trung bình, trong khi t7 (lỗi đúng loại đó) đã hạ Dễ. Gói giữ t7 ở **Dễ** vì quy chuẩn đứng trên QUYET-DINH-CHUNG (mục 0): lộ trình `data.js` xếp bài `t3-union-mat-dong` (M7, Sửa lỗi, UNION thay UNION ALL làm mất dòng trùng giá trị) ở cấp **easy**, và HD mục 6 xếp lỗi logic một chỗ vào Dễ. Ở t7, lỗi là một từ khoá, ERD có sẵn giá trị mẫu cùng nền tảng, cùng số tiền làm manh mối. Ví dụ ở QUYET-DINH-CHUNG 2.1 chỉ hợp khi dòng trùng khó nhận ra (như t4, phép hợp nằm giữa nhiều bước). Đề nghị người giữ file chung sửa ví dụ ở 2.1; agent gói 4 không sửa file chung.

## v4 – đủ 4 cấp mỗi module (11/11, theo BRIEF-CAP-DO-MODULE)

Mục tiêu mỗi module: 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó; giữ 6 write + 3 debug. Căn cứ: `data.js` (mọi module đủ 4 cấp; M7 Cơ bản `t1-viet-lai-cte`, Dễ `t2-hoat-dong-khach`, `t3-union-mat-dong`; M8 Cơ bản `f1-thu-tu-don`, Dễ `f2-doanh-thu-hom-truoc`, `f3-hang-nhom-hang`), CHOT mục 3 (ERD theo cấp), HD mục 5, 6, QUYET-DINH-CHUNG 2.1–2.2 (cấp = ≥ 3/5 trục).

**Phân bố trước → sau**

| Module | Cơ bản | Dễ | Trung bình | Khó |
|---|---|---|---|---|
| M7 trước | 0 | 1 (t7) | 4 (t1–t4) | 4 (t5, t6, t8, t9) |
| M7 sau | 2 (t2, t3) | 3 (t6, t7, t8) | 2 (t1, t4) | 2 (t5, t9) |
| M8 trước | 0 | 0 | 7 (f1–f3, f6–f9) | 2 (f4, f5) |
| M8 sau | 2 (f3, f6) | 3 (f2, f7, f8) | 2 (f1, f9) | 2 (f4, f5) |

Số câu đổi cấp là tối thiểu: M7 thừa 2 Trung bình, 2 Khó → 4 câu; M8 thừa 5 Trung bình → 5 câu. Câu giữ Trung bình chọn theo mẫu của lộ trình và thang 2.2: f1 (top 3 mỗi nhóm, hoà hạng ở hidden-1, như `w3`), f9 (sai phạm vi cửa sổ, lỗi khó thấy), t1 (phễu nhiều CTE), t4 (đối soát hai phía bằng `NOT EXISTS` và phép hợp). Case c7, c8 giữ cấp. Hình thức giữ: M7 6 write (t1–t6) + 3 debug (t7–t9); M8 6 write (f1–f6) + 3 debug (f7–f9).

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục ở cấp mới (bảng · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `jelly-t2-buoc-4-android-210` → `jelly-t2-so-buoc-hoan-thanh` | TB → Cơ bản | Viết lại (chủ đề bước 4 theo phiên bản đã có ở c7 bước 1): đếm số bước hướng dẫn hoàn thành của từng người cài tháng 7 trong CTE, rồi đếm số người theo số bước; dạng C3 → A3. ERD 1 bảng có giá trị mẫu. Solution mới; wrong `dem_buoc_da_bat_dau`, `thieu_can_tren_thang_7` (rớt public, hidden-1) | 1 bảng · một CTE và một lần đếm (khuôn `t1-viet-lai-cte`) · đề ghi rõ cột, giá trị · không bẫy · một khái niệm |
| `jelly-t3-d1-d7-theo-kenh` → `jelly-t3-mua-tu-3-lan` | TB → Cơ bản | Viết lại (giữ chân D7 đã có ở t8, D1 ở c7 bước 3): người chơi mua từ 3 lần trở lên trong cửa sổ, gom trong CTE rồi lọc ở truy vấn ngoài; mảng customer → sales, dạng D2 → C4 (ô A1 · sales · Cơ bản · write đã có r2 ở gói 1). ERD 1 bảng có giá trị mẫu. Solution mới; wrong `lon_hon_3`, `dem_loai_goi` (rớt public), `thieu_can_tren` (rớt hidden-1: giao dịch 30/8, 1/9 của `jta_user_000648`) | 1 bảng · một CTE và một điều kiện lọc · đề ghi rõ cột, ngưỡng, mốc ngày · không bẫy · một khái niệm |
| `jelly-t6-crash-hai-nguon` → `jelly-t6-tong-su-co-hai-nguon` | Khó → Dễ | Bỏ phần so từng ngày và 3 bảng nhiễu: chỉ còn tổng tháng 7 của hai nguồn (hai CTE một dòng, ghép bằng `CROSS JOIN`), đề nêu rõ cột và cách đếm từng nguồn. ERD 2 bảng, chữ trên đường nối. Solution mới; wrong `noi_truc_tiep_nhan_dong`, `dem_ngay_nguoi_co_su_co`, `luot_thieu_can_tren` (đều rớt public, hidden-1) | 2 bảng · hai phép gom rồi ghép · đề nêu rõ cách đếm · 1 bẫy (nối thẳng nhân dòng) · một khái niệm |
| `jelly-t8-cte-loc-sai-cho` (giữ mã) | Khó → Dễ | Yêu cầu ghi thẳng định nghĩa D7 và mốc 22/8 cho cả tử số lẫn mẫu số; bỏ 3 bảng nhiễu, ERD 2 bảng có chữ trên đường nối và giá trị mẫu (người cài 25/8 bản 2.1.1); gợi ý 2 nấc, nấc cuối là điều kiện cần thêm. Starter, solution giữ (lỗi một chỗ: CTE mẫu số thiếu điều kiện nhóm đủ ngày); thêm wrong `mau_so_bo_ngay_22_8` (rớt public, hidden-1) | 2 bảng · hai CTE có sẵn, thêm một điều kiện · định nghĩa nằm trong đề · 1 bẫy (thiếu cận ở mẫu số) · một công thức một phép chia |
| `jelly-f2-dau-trot-7-ngay` (giữ mã) | TB → Dễ | ERD 3 → 2 bảng, chữ trên đường nối (`daily_kpi` với `player_daily`, không có khoá); gợi ý gộp còn 2 nấc, nấc cuối là biểu thức `CASE WHEN COUNT(*) OVER w = 7 …`; `\luuy` thêm ý cột `dau` đã tổng hợp sẵn. SQL giữ (3 wrong rớt như cũ) | 1 bảng · một hàm cửa sổ và một điều kiện · đề nêu sẵn khung 7 ngày và cách xử lý ngày chưa đủ · 1 bẫy loại NULL (6 ngày đầu để trống) · một khái niệm. Lộ trình xếp bài trượt `f5` ở Trung bình; ở đây đề nêu sẵn khung nên 5/5 trục ở Dễ |
| `jelly-f3-luy-ke-chi` → `jelly-f3-luy-ke-chi-mot-chien-dich` | TB → Cơ bản | Lọc một chiến dịch (Video Network), một thị trường (VN), một nền tảng (Android) nên mỗi ngày một dòng: bỏ bước gom ngày và `PARTITION BY`, chỉ còn `SUM() OVER (ORDER BY date)`. ERD 1 bảng có giá trị mẫu. Solution mới; wrong `cua_so_thieu_order_by`, `quen_loc_nen_tang`, `cong_don_theo_tien` (rớt public, hidden-1); hidden-1 khác public nhờ biến thể (h) (+150 USD ngày 11/7) | 1 bảng · một hàm cửa sổ · đề ghi rõ cột, giá trị lọc · không bẫy · một ý nghiệp vụ |
| `jelly-f6-chia-4-nhom-chi` → `jelly-f6-chia-4-nhom-ngay-dau` | TB → Cơ bản | Giữ kỹ năng `NTILE` (quyết định v3), bỏ gom theo người chơi, `PARTITION BY` và bước gom sau khi chia: chia 29 ngày tháng 8 thành 4 nhóm theo DAU (`daily_kpi`); mảng sales → customer, dạng C1 → C4. ERD 1 bảng có giá trị mẫu. Solution mới; wrong `xep_dau_tang_dan`, `chia_theo_ngay` (rớt public, hidden-1), `thieu_can_tren` (rớt hidden-1: ngày 30/8, 1/9, 2/9) | 1 bảng · một hàm cửa sổ · đề ghi rõ cột, chiều sắp, quy tắc hoà · không bẫy · một khái niệm |
| `jelly-f7-rank-thay-row-number` (giữ mã) | TB → Dễ | ERD 3 → 2 bảng, chữ trên đường nối, giá trị mẫu chỉ tới thế giới bị lỗi (`'Licorice Lagoon'`, `'crash'`); gợi ý nấc cuối là biểu thức `ROW_NUMBER() OVER (...)`. SQL giữ (lỗi một từ khoá `RANK()`, lộ ngay ở public) | 1 bảng · CTE có sẵn, đổi hàm xếp hạng · đề ghi rõ số dòng, quy tắc hoà · 1 bẫy (hoà hạng) · một khái niệm |
| `jelly-f8-lag-khong-partition` (giữ mã) | TB → Dễ | ERD 3 → 2 bảng, chữ trên đường nối, tô `user_id` và giá trị mẫu ngày cài 3/7; `\ghichuthietke` nêu khác f9 (f9 phải bỏ phạm vi của cửa sổ chạy trên kết quả đã gom). SQL giữ | 1 bảng · CTE có sẵn, thêm một mệnh đề · đề ghi rõ cột, cách bỏ ngày đầu · 1 bẫy (thiếu `PARTITION BY`) · một khái niệm |

**Trùng ô:** trong gói không có ô dạng × mảng × cấp × hình thức trùng (đã đếm lại 18 câu). Với gói khác: t3 đổi dạng A1 → C4 để không trùng ô A1 · sales · Cơ bản · write của `jelly-r2-giao-dich-season-pass` (gói 1); t2 (A3 · customer · Cơ bản), t6 (E2 · after_sales · Dễ), f3 (B3 · marketing · Cơ bản), f6 (C4 · customer · Cơ bản) chưa có ở gói khác theo `BAN-DO-100-CAU.md` lúc sửa. Agent gói khác đang sửa song song nên cần đếm lại khi gộp. Ô C3 · customer · Trung bình · write không còn trùng giữa gói 3 và gói 4 (t2 cũ đã viết lại); đã bỏ dòng đó khỏi danh sách ô trùng của bản đồ. Phần thống kê của bản đồ (dùng chung 5 gói) chưa đếm lại.

**Nghi chồng nội dung (không trùng ô):** f3 mới (chi luỹ kế một chiến dịch) và `jelly-p4-luy-ke-tu-noi` (gói 5, doanh thu luỹ kế) cùng kỹ năng cộng dồn nhưng khác bảng, khác hình thức. f6 mới (nhóm ngày theo DAU) gần chủ đề `jelly-q4-ngay-dau-tren-tb-thang` (gói 3, ngày có DAU trên bình quân tháng) nhưng khác kỹ năng và kết quả.

**Kiểm lại v4:** bộ kiểm đầy đủ cả gói trên `jelly` + `jelly_hidden_1` → `cong-cu/ket-qua/cap-do/jelly-goi-4/`, 20/20 OK, `KIEM TRA: 0 loi`, 0 cảnh báo; solution của 9 câu đổi cấp cho kết quả public khác hidden-1 (so md5 kết quả). Biên dịch → `cong-cu/ket-qua/cap-do/jelly-goi-4-pdf/`: 0 lỗi LaTeX, 0 ký tự thiếu. Thư mục gói vẫn đúng 4 file.

## Sửa theo KIEM-V4 (11/11/2026)

Căn cứ: `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`. Không đổi cấp, không đổi mã câu nào. Trùng ô giữa các gói được phép (đính chính của người điều phối 11/11), nên không đổi mảng, dạng của câu nào; trong gói không có ô trùng.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| `jelly-f9-ty-trong-goi` | B A.6: "(tới hết ngày 29/8)" đọc như định nghĩa kỳ, bài gắn cứng rớt hidden-1; ERD có bảng trôi | "(tới hết ngày 29/8)" → "(tính trọn tháng; dữ liệu Chạy thử có tới hết ngày 29/8)"; ERD thêm `level_id_if_relevant:FK` vào `purchases` và đường nối n-1 sang `level_metadata`. SQL giữ. Không đổi wrong `thieu_can_tren` (B ghi không bắt buộc). | Chỉ sửa chữ |
| `jelly-c8-doanh-thu-giam-vi-dau` | B A.7: phương án đúng dài gần gấp đôi hai phương án sai | Phương án đúng rút còn khoảng 30 tiếng: "Doanh thu giảm vì ARPDAU phần IAP giảm, do tỷ lệ trả tiền và số tiền mỗi ngày-người trả tiền đều thấp hơn; DAU tăng chỉ bù được một phần." (giữ đúng hai chỉ số của bước 3, không dùng "mỗi lần chi" như đề xuất vì bước 3 đo theo ngày-người, không theo lần mua). Lời giải thích giữ. | Chỉ sửa chữ |
| `jelly-c7-android-210` | C (ghi chú nhẹ, còn từ KIEM-V3) | Lời giải thích phương án 3: bỏ chữ "có" ("iOS 2.1.1 thấp hơn các nhóm iOS khác …"). Trùng bước c7.b2 / c10.b1 xử lý ở c10 (gói 5). | Chỉ sửa chữ |

Kiểm:

- Bộ kiểm đầy đủ cả gói: `docker compose run --rm tools python cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/jelly/goi-4 --ra cong-cu/ket-qua/sua-v4/jelly-goi-4 --host sqllb-mysql --port 3306` → 20 câu, 78 khối SQL, `KIEM TRA: 0 loi`, 0 cảnh báo, mọi wrong rớt ít nhất một biến thể, mọi solution ra kết quả public khác hidden-1.
- Biên dịch: `bash cong-cu/bien_dich.sh goi-cau-hoi/jelly/goi-4 <ra>` → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo gói lệnh; PDF ở `cong-cu/ket-qua/sua-v4/jelly-goi-4/bien-dich/`.
- Thư mục gói vẫn đúng 4 file.
