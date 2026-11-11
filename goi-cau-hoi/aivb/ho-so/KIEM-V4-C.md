# KIEM-V4-C · bộ aivb · người kiểm C

Ngày 11/11/2026. Làm theo `BRIEF-KIEM-V4.md`, danh sách chung `KIEM-V4-DANH-SACH.md` (28 câu số chẵn, cột "Người kiểm" = C). Căn cứ: `quy_chuan/` (CHOT-FORMAT mục 2, 3, 6; HD mục 5–7; gói mẫu; `lo-trinh-sql/assets/js/data.js`) > `QUYET-DINH-CHUNG.md` > `style/STYLE-aivb.md` > brief. Quy tắc trùng ô áp theo đính chính của điều phối (11/11): trùng ô **giữa các gói được phép**, chỉ cấm trùng trong cùng gói và cặp trùng cả chủ đề.

Cách làm mỗi câu: đọc đề trong `cau-hoi.tex` (với câu debug đọc thêm khối `starter` vì học viên thấy khối này), tự viết SQL, chạy trên `aivb` và `aivb_hidden_1` (user `sql_runner`), rồi máy so với khối `solution` theo vị trí cột, thứ tự, sai số 0,01, NULL bằng NULL. Sau đó mới đọc solution, chạy từng `wrong`/`starter` trên hai biến thể, kiểm cấp (5 trục QUYET-DINH-CHUNG 2.2, ERD theo CHOT mục 3), nghiệp vụ, giọng văn. Nháp: `scratchpad/kiem-aivb-C/` (`chay.py`, `wr.py`, `meta.py`, SQL tự giải từng câu).

Kết quả chung phần C: **28/28 câu tự giải khớp solution ở cả public và hidden-1** (không câu nào đề mơ hồ tới mức ra bảng khác). Mọi `wrong`/`starter` khác solution ở ít nhất một biến thể, đúng biến thể ghi trong `\ghichuthietke`. Mọi câu có kết quả public khác hidden-1. Không starter câu debug nào có chú thích nêu sẵn lỗi. Không câu nào dẫn học viên gắn cứng ngày cuối dữ liệu (các câu có mốc đều ghi ngày tham chiếu bằng giá trị cụ thể, có đủ cận trên).

## Bảng kiểm

Cột "biến thể khác?": public ≠ hidden-1 ở solution, và wrong rớt đúng biến thể. "rớt h1" = chỉ rớt ở hidden-1 (đúng ý đồ ghi trong ghi chú thiết kế).

| # | mã | gói | cấp | tự giải khớp? | biến thể khác? | cấp đúng? | giọng văn | kết luận + đề xuất |
|---|---|---|---|---|---|---|---|---|
| 2 | aivb-r3-kyc-khong-dat-con-quan-he-ha-noi | 1 | medium | Khớp (82 / 83 dòng) | Có; 3 wrong rớt cả hai | Đạt 4/5 (2 bảng tra mã, mơ hồ, 3 bẫy, điều kiện hai vế); ERD 3 bảng 1-n, 1 bảng nhiễu | 1 chỗ | **Cần sửa (giọng, nhẹ).** `\boicanh`: "các khách không đạt nhận biết khách hàng (KYC)" thiếu danh từ → "các khách không đạt kiểm tra nhận biết khách hàng (KYC)". SQL, cấp giữ. |
| 4 | aivb-r7-khach-uu-tien-hoat-dong | 1 | basic | Khớp (572 / 573) | Có; starter và 2 wrong rớt cả hai | Đạt (Sửa lỗi Cơ bản, thứ tự AND/OR; ERD 1 bảng giá trị mẫu) | Đạt | **Đạt.** |
| 6 | aivb-n2-kha-nang-tich-luy-khach-1990 | 1 | medium | Khớp (197 / 198) | Có; 3 wrong rớt cả hai | Đạt 3/5 (mơ hồ, 3 bẫy, quy tắc hai thành phần); bằng bài Trung bình M2 của `data.js` (n5) | Đạt | **Đạt.** ERD 3 bảng có 2 bảng nhiễu: **đúng CHOT** (xem mục "ERD Trung bình 1 bảng lời giải" cuối file). |
| 8 | aivb-n4-ty-le-thu-hoi-goc | 1 | medium | Khớp (801 / 804) | Có; 4 wrong rớt cả hai | Đạt 3/5 (mơ hồ phạm vi "còn dư nợ", 4 bẫy, công thức hai thành phần) | Đạt | **Đạt.** ERD 2 bảng nhiễu, như n2: đúng CHOT. |
| 10 | aivb-n9-dong-so-huu-con-hieu-luc | 1 | hard | Khớp (224 / 226) | Có; starter 6/7 dòng; 3 wrong chỉ rớt h1 (`chi_them_valid_to_trong`, `tinh_ca_ngay_ket_thuc`, `bo_ngay_bat_dau_dung_moc`), 3 wrong rớt cả hai | Đạt (Sửa lỗi Khó = 3 lỗi chồng nhau; bẫy chỉ lộ ở h1; ERD 5 bảng chỉ khoá, trung tính) | Đạt | **Đạt.** Câu viết lại khó hơn thật: starter cũ 1 lỗi, nay 3 lỗi ngược chiều nhau ở hai biên. |
| 12 | aivb-c2-tien-gui-sap-dao-han | 1 | basic (case) | Khớp b1 (160 / 161) | Có; 3 wrong b1 rớt cả hai (`tinh_ca_ngay_01_02` thêm đúng 1 dòng) | Đạt (case Cơ bản 2 bước) | Đạt; kết luận "Đúng: " đúng mẫu, 3 phương án, ≤ 35 tiếng | **Đạt.** Ghi chú (không chặn): phương án đúng ("các hợp đồng còn lại đều dưới 5,5%/năm") chỉ đúng trên public; hidden-1 có `SYN_DEP_H000001` 5,70%/năm ở dòng 2. Bước kết luận học viên đọc trên public nên không chấm oan. |
| 14 | aivb-s5-giai-ngan-don-cuoi-thang | 2 | hard | Khớp (5 / 5 dòng, tháng 4 khác) | Có; 3 wrong rớt cả hai | Chấp nhận: 1 bảng (mẫu o4), 3 tầng, mơ hồ Khó (chọn bảng mọi lần giải ngân, `\erdkhoa`), 3 bẫy nhưng **không bẫy nào chỉ lộ ở h1**, chỉ số tỷ trọng theo điều kiện ngày. Theo QUYET-DINH-CHUNG 2.2 sát ranh Trung bình; theo `data.js` (bài Khó M3 `s6-khuyen-mai-qua-nam` chỉ YEAR, DATEDIFF trên 1 bảng) thì câu này khó hơn bài chuẩn → giữ Khó | 1 chỗ | **Cần sửa (giọng).** `\erdkhoa`: "mỗi dòng của nó là một lần giải ngân" (đại từ "nó" cho bảng) → "mỗi dòng của bảng này là một lần giải ngân". Cấp giữ Khó; nếu sau này thêm biến thể ẩn thì nên có một lần giải ngân sát ngưỡng chỉ ở hidden-1 để trục bẫy đạt đủ tiêu chí Khó của QUYET-DINH-CHUNG 2.2. |
| 16 | aivb-s7-tham-nien-khach-hang | 2 | medium | Khớp (9 / 9 dòng) | Có; starter, 2 wrong rớt cả hai | Đạt (Sửa lỗi Trung bình: lỗi khó thấy, tổng số khách không đổi; khớp bài debug Trung bình M3 `s5-thang-sai-thu-tu` của `data.js`) | Đạt | **Đạt.** ERD 3 bảng có 2 bảng nhiễu, cùng trường hợp n2/n4 (người soạn không tự khai). |
| 18 | aivb-a1-du-no-binh-quan | 2 | basic | Khớp (1 dòng) | Có; 2 wrong rớt cả hai | Đạt 5/5 Cơ bản | 1 chỗ (khái niệm dùng chung) | **Cần sửa (lệch thuật ngữ).** `goi-2/cau-hoi.tex` dòng 91, `\khaibaokhainiem{trang-thai-khoan-vay}`: "\code{'ACTIVE'} (đang còn dư nợ)" trái STYLE-aivb A.4 (cột "Không dùng": "đang còn dư nợ" cho riêng 'ACTIVE') và khác bản ở gói 1, 3, 4, 5 → bỏ "(đang còn dư nợ)", chép đúng STYLE-aivb mục E. Câu này dùng `\khainiem{trang-thai-khoan-vay}` và tự nói ba trạng thái "còn dư nợ", nên chỗ lệch đọc ra như mâu thuẫn. |
| 20 | aivb-a6-khoan-vay-co-van-de-theo-san-pham | 2 | hard | Khớp (5 dòng; h1 đảo hai dòng đầu) | Có; 4 wrong rớt public (`sap_theo_so_khoan` chỉ rớt public, như ghi chú) | Đạt 4/5 (4 bảng, mơ hồ, 3 bẫy, nhiều điều kiện); ERD 6 bảng chỉ khoá | Như a1 | **Cần sửa (cùng một chỗ với a1)**: khái niệm `trang-thai-khoan-vay` gói 2 dòng 91. Phần còn lại đạt. |
| 22 | aivb-a9-ty-le-thieu-nghe-nghiep-toan-hang | 2 | hard | Khớp (1 dòng) | Có; starter, 4 wrong rớt cả hai | Đạt (Sửa lỗi Khó: 3 lỗi chồng nhau, có sai định nghĩa chỉ số); ERD 5 bảng, 3 nhiễu (lời giải 2 bảng, được bù cho đủ 5 theo 1.3) | Đạt | **Đạt.** |
| 24 | aivb-j5-doi-soat-du-no-khoan-vay | 3 | hard | Khớp (5 dòng; h1 MORT lệch 1 khoản) | Có; 3 wrong rớt cả hai | Đạt 5/5 Khó; ERD 7 bảng, 2 nhiễu, `\erdkhoa` | Đạt | **Đạt.** Ghi chú: public cho `so_khoan_lech` = 0 ở mọi sản phẩm; điểm lệch duy nhất ở h1 đến từ biến thể c. Chấp nhận (đối soát khớp là một kết luận hợp lệ). Gần chủ đề với aivb-k5 (gói 5, khác ô, khác nguồn đối chiếu): giữ. |
| 26 | aivb-j9-lai-du-thu-cho-vay-2026 | 3 | basic | Khớp (1 dòng) | Có; starter, 2 wrong rớt cả hai | Đạt (Sửa lỗi Cơ bản, 1 lỗi dễ thấy) | Đạt | **Đạt.** Ghi chú: ERD Cơ bản 2 bảng (CHOT mục 3 ghi Cơ bản 1 bảng) vì lỗi nằm ở phép nối; bài Cơ bản M5 của `data.js` cũng nối 2 bảng. Chung loại với j3, cần giảng viên xác nhận một lần cho M5. Đường nối có `tren=` ghi đúng điều kiện nối đúng, tức ERD cho sẵn lời sửa; ở Cơ bản chấp nhận được (mẫu d1 cũng chỉ thẳng chỗ sai), người soạn có thể bỏ `tren` nếu muốn học viên tự so giá trị mẫu. Gần chủ đề với aivb-p9 (gói 5, Dễ). |
| 28 | aivb-q3-tien-gui-lon-gap-10-binh-quan | 3 | basic | Khớp (46 / 45) | Có; 2 wrong rớt cả hai | Đạt 5/5 Cơ bản | 1 chỗ (nghiệp vụ) | **Cần sửa (nghiệp vụ, nhẹ).** Dòng quyết định "Nhận diện các khoản tiền gửi lớn để giao chuyên viên chăm sóc riêng." không khớp phạm vi "mọi trạng thái" (gồm hợp đồng đã tất toán, đã tái tục; mẫu ERD là hợp đồng `'CLOSED'`) và lời nhắn "từng nhận". Sửa thành "Đặt ngưỡng nhận diện tiền gửi lớn cần báo cáo riêng, dựa trên các hợp đồng lớn ngân hàng từng nhận." |
| 30 | aivb-q5-pheu-khach-vay-2026 | 3 | hard | Khớp (4 dòng; h1 bước 1–2 khác) | Có; 4 wrong rớt cả hai | Đạt 4/5 Khó (4 bảng, 5 tầng, 4 bẫy, phễu nhiều điều kiện) | Đạt | **Đạt.** Gần chủ đề với aivb-t1 (phễu hồ sơ vay 2025, gói 4, khác ô, đếm hồ sơ chứ không đếm khách): giữ. |
| 32 | aivb-q9-chinh-sach-hieu-luc-ngay-nop | 3 | medium | Khớp (4 dòng) | Có; starter, 2 wrong rớt cả hai | Sát ranh Dễ: yêu cầu ghi nguyên quy tắc "tính cả hai ngày", gợi ý 2 chỉ thẳng hai phép so sánh, nên hai lỗi biên khá dễ thấy. Giữ Trung bình theo QUYET-DINH-CHUNG 2.3 dòng 2 (đã quyết thêm lỗi thứ hai) | Đạt | **Đạt** (ghi chú cấp). Nếu muốn chắc Trung bình: bỏ cụm "tính cả hai ngày" khỏi `yeucau` (đã có ở `\luuy`), để học viên tự suy ra biên. |
| 34 | aivb-t2-cho-vay-moi-va-thu-goc-quy-4 | 4 | easy | Khớp (6 dòng; h1 ba dòng thu gốc khác) | Có; 2 wrong rớt cả hai | Đạt 5/5 Dễ | Đạt | **Đạt.** Solution 0,4 giây. |
| 36 | aivb-t5-lenh-binh-quan-ngay-theo-kenh | 4 | basic | Khớp (7 dòng) | Có (H(a)); 2 wrong rớt cả hai | Đạt 5/5 Cơ bản (theo bài `t1-viet-lai-cte`) | Đạt | **Đạt.** Solution 5–6,5 giây lúc MySQL bận (xem bảng thời gian). |
| 38 | aivb-t7-chu-the-can-ra-soat-dem-trung | 4 | easy | Khớp (1188 / 1190) | Có; starter, 2 wrong rớt cả hai | Đạt 5/5 Dễ (`UNION ALL` → `UNION`, như `t3-union-mat-dong`) | Đạt | **Đạt.** |
| 40 | aivb-f1-ty-trong-du-no-co-cau-lai | 4 | basic | Khớp (24 / 25) | Có; 2 wrong rớt cả hai | Đạt 5/5 Cơ bản | Đạt | **Đạt.** |
| 42 | aivb-f3-lai-du-thu-luy-ke-mot-khoan-vay | 4 | basic | Khớp (12 / 11) | Có; `tong_ca_nam` rớt cả hai, `thieu_can_tren_nam` rớt h1 | Đạt 5/5 Cơ bản | Đạt | **Đạt.** |
| 44 | aivb-f9-dong-tien-luy-ke-chi-tang | 4 | easy | Khớp (33 / 30) | Có; starter, 2 wrong rớt cả hai, `quen_can_tren_thang` rớt h1 | Đạt 4/5 Dễ (bỏ hai lỗi khung, còn một lỗi dấu) | Đạt | **Đạt.** Hạ từ Khó là hạ thật (starter cũ 3 lỗi). |
| 46 | aivb-c8-chat-luong-tin-dung-cohort | 4 | hard (case) | Khớp b1–b4 (7 dòng mỗi bước) | Có ở cả 4 bước; chỉ b3 có wrong (`dem_ky_thay_vi_khoan`, rớt cả hai) | Đạt (case Khó 5 bước; ERD 5 bảng, 3 nhiễu, lời giải 2 bảng) | Kết luận đạt: "Đúng: " + 30 tiếng, phương án sai không tiền tố, ≤ 35 tiếng; số trên public khớp cả 3 phương án | **Đạt** (đề xuất bổ sung, không chặn): b1, b2, b4 chưa có wrong. Thêm b1 `inner_join_mat_khoan_chua_den_han` (`JOIN` thay `LEFT JOIN`, bình quân chỉ trên khoản đã có kỳ); b2 `thieu_xu_ly_rui_ro` (bỏ `'WRITTEN_OFF'`); b4 `tinh_ca_ky_da_huy` (không loại `'CANCELLED'` ở mẫu số). |
| 48 | aivb-k2-phan-bo-thu-no-khong-co-lenh | 5 | medium | Khớp (5 dòng; h1 năm 2026 có 975 dòng thiếu lệnh) | Có; 2 wrong rớt cả hai | Đạt (3 bảng 1-n, `LEFT JOIN … IS NULL` đếm có điều kiện, bẫy cửa sổ dữ liệu) | Đạt | **Đạt.** `\luuy` v3 (chứng từ lưu ở hệ thống lưu trữ) đúng và rõ. |
| 50 | aivb-k5-du-no-lech-lich-tra-no | 5 | easy | Khớp (17 / 19) | Có; `cong_ca_ky_da_huy` rớt cả hai, `chi_cong_goc_ky_chua_tra` rớt h1 | Đạt 5/5 Dễ (2 bảng, nối + gom + `HAVING`, 1 bẫy) | 1 chỗ | **Cần sửa (giọng, nhẹ).** Dòng mở `nghiepvu` "Biết có thể lấy dư nợ trên hợp đồng làm số liệu cho báo cáo chất lượng tín dụng hay phải tính lại từ lịch trả nợ." không phải một quyết định (STYLE-aivb B.4) → "Quyết định dùng dư nợ trên hợp đồng hay tính lại từ lịch trả nợ cho báo cáo chất lượng tín dụng." |
| 52 | aivb-k7-ngay-tu-choi-bat-thuong | 5 | easy | Khớp (3 dòng) | Có; starter 2 dòng, wrong rớt cả hai | Đạt 4/5 Dễ (1 lỗi một chỗ) | Đạt | **Cần sửa (thời gian starter).** Starter quét cả năm 2026 không lọc trạng thái, chạy **48,6 giây public / 38,2 giây hidden-1** (đo riêng, lúc `COUNT(*)` trần cùng bảng mất 4,7 giây); solution 4–5 giây. Học viên bấm Chạy thử starter sẽ chờ gần một phút, có thể quá giới hạn của máy chấm khi bận. Đề xuất: thu phạm vi về quý 1/2026 (`'2026-01-01'` tới trước `'2026-04-01'`): đã thử, starter 6 giây, solution 4 giây, solution ra 2 dòng ở cả hai biến thể (API 27/03, POS 12/02; `bq_ngay_kenh` khác giữa hai biến thể); starter khi đó ra 0 dòng nên đổi tiêu đề, bối cảnh thành triệu chứng "không ra ngày nào" và chạy lại bộ kiểm. Hoặc giữ năm 2026 nhưng thêm vào starter điều kiện kênh (ví dụ `channel_code IN ('API', 'POS', 'QR')`) nếu đo được < 10 giây. |
| 54 | aivb-p8-lenh-tra-no-thang-12-ra-0 | 5 | basic | Khớp (808 / 715 lệnh) | Có; starter ra 0, wrong `LIKE 'LOAN%'` rớt cả hai | Đạt 5/5 Cơ bản (mẫu d1) | Đạt | **Đạt.** Trùng ô A2 · operations · basic · debug với aivb-a7 (gói 2): khác gói nên được phép; chủ đề khác (a7 thiếu lọc trạng thái trên lệnh cả năm, p8 sai mã loại giao dịch tháng 12) dù cùng dáng "đếm lệnh + cộng tiền một dòng". Giữ, ghi vào BAN-DO. Bỏ mất câu D2 cũ: xem mục D2. |
| 56 | aivb-c9-ra-soat-no-xau-2026 | 5 | hard (case) | Khớp b1–b4 | Có ở cả 4 bước; mỗi bước 1 wrong, đều rớt cả hai | Đạt (case Khó 5 bước, 6 bảng chỉ khoá, 1 nhiễu, `\erdkhoa`) | Kết luận đạt ("Đúng: " ~30 tiếng; phương án sai không tiền tố, ≤ 35 tiếng); số public khớp: CONS 5,90% đầu bảng, miền Bắc 0,11% so với 2,34% và 2,12% | **Đạt.** |

## Tổng hợp

- **Đạt: 21 câu** – r7, n2, n4, n9, c2, s7, a9, j5, j9, q5, q9, t2, t5, t7, f1, f3, f9, c8, k2, p8, c9 (c2, j9, q9, c8 có ghi chú không chặn).
- **Cần sửa: 7 câu** – r3 (giọng), s5 (giọng "nó"), a1 + a6 (một chỗ chung: khái niệm `trang-thai-khoan-vay` gói 2), q3 (dòng quyết định nghiệp vụ), k5 (dòng mở `nghiepvu`), k7 (starter chạy 38–49 giây).

Đếm lại: 21 Đạt + 7 Cần sửa = 28.

Lỗi nặng: **không có** chấm oan, solution sai, wrong không rớt hay lộ kết quả. Lỗi nặng nhất là k7 (starter gần một phút, rủi ro quá giới hạn máy chấm khi học viên Chạy thử).

Module (đếm từ khoá `cap=` của 100 câu trong 5 `cau-hoi.tex`): M1–M10 đều đúng **2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó**; 10 case: Cơ bản c1, c2, c3 · Dễ c4, c5 · Trung bình c6, c7 · Khó c8, c9, c10.

## ERD Trung bình chỉ cần 1 bảng lời giải (điểm người soạn gói 1 tự khai)

n2, n4 (và s7 gói 2, người soạn không khai) vẽ ERD 3 bảng có 2 bảng nhiễu. **Kết luận: đúng thứ tự ưu tiên.** CHOT-FORMAT mục 3 và HD mục 5 bắt buộc Trung bình 3–4 bảng; giới hạn "Trung bình ≤ 1 bảng nhiễu" của QUYET-DINH-CHUNG 1.3 tự ghi là "quy ước bổ sung, quy chuẩn không nói rõ" (bảng 0.2). Ở M2, M3 chưa học nối bảng, lời giải 1 bảng (như bài Trung bình n5 của `data.js`) thì chỉ có thể đủ 3 bảng bằng 2 bảng nhiễu. Các bảng nhiễu của n2, n4, s7 đều có đường nối đúng (1-1, 1-n, n-1). Đề xuất cho người giữ QUYET-DINH-CHUNG: ghi một ngoại lệ ở 1.3 "Trung bình mà lời giải dùng 1 bảng thì được 2 bảng nhiễu cho đủ 3 bảng", giống câu đã có cho Khó. Cùng loại: ERD Cơ bản 2 bảng của câu nối bảng ở M5 (j3, j9) nên được xác nhận cùng lúc.

## Câu cohort dạng D2 (điểm người soạn gói 5 tự khai)

`DA-SUA` gói 5 (dòng p8) ghi "bộ aivb không còn câu module nào dạng D2 (aivb-f5 gói 4 nay là C1)". **Ghi chú này sai.** `goi-4/cau-hoi.tex` dòng 492: `aivb-f5-cohort-khach-vay`, `dang=D2`, `cap=hard`, `domain=customer`, write ("Khách mới bao lâu thì nộp hồ sơ vay đầu tiên?", cohort theo năm trở thành khách hàng); `BAN-DO-100-CAU.md` dòng f5 cũng ghi D2. DA-SUA gói 4 v4 ghi rõ giữ f5 "vì là câu D2 cohort duy nhất". Ngoài ra case aivb-c8 (gói 4) là phân tích cohort theo năm giải ngân.

Kết luận: **giữ p8 như bản viết lại, không cần bù.** Bộ vẫn phủ D2 bằng 1 câu module (f5, Khó) + 1 case (c8), ở mảng `customer` là mảng HD mục 7 đánh dấu cho D2. Việc cần làm: sửa câu ghi chú ở `ho-so/goi-5/DA-SUA.md` (dòng p8) thành "dạng D2 còn ở aivb-f5 (gói 4, Khó) và case c8". Nếu giảng viên muốn D2 ở cấp thấp hơn thì chỗ ít phá cân bằng nhất là đổi dạng một câu Trung bình write ở M8 (f6 Pareto C2 · finance) sang cohort, nhưng việc này không cần cho v4.

## Rà trùng ô toàn bộ aivb (dạng × mảng × cấp × hình thức)

Đếm từ khoá `\begin{cauhoi}[...]` của 90 câu module trong 5 `cau-hoi.tex` hiện tại (không dựa vào BAN-DO); case không tính.

**Trùng trong cùng một gói: không có.**

**Trùng giữa các gói (được phép, ghi tham khảo): 4 ô**

| ô | câu | chủ đề có trùng? | đề xuất |
|---|---|---|---|
| A1 · operations · basic · write | aivb-r1-chi-nhanh-mien-nam (g1), aivb-s1-chi-nhanh-quan (g2) | Gần: cùng liệt kê chi nhánh trên `ref_branch`, nhưng khác điều kiện và kỹ năng (lọc `region =` / `LIKE '%Quận%'`). Không trùng chủ đề | Giữ |
| A1 · customer · basic · write | aivb-n1-ca-nhan-thieu-nghe-nghiep (g1), aivb-s2-ho-kinh-doanh-fnb (g2) | Không | Giữ |
| A1 · customer · easy · debug | aivb-s9-quyet-dinh-kyc-thang-12-2025 (g2), aivb-j7-chu-so-huu-tai-khoan-da-dong (g3) | Không | Giữ |
| A2 · operations · basic · debug | aivb-a7-lenh-thanh-cong-2026 (g2), aivb-p8-lenh-tra-no-thang-12-ra-0 (g5) | Gần (cùng bảng lệnh, cùng dáng một dòng `COUNT` + `SUM(amount)`, cùng lỗi ở điều kiện lọc) nhưng khác chủ đề và khác lỗi | Giữ. Nếu giảng viên coi là trùng chủ đề: đổi p8 sang dạng A1 (liệt kê lệnh trả nợ ngày 31/12/2026 thay vì đếm); ô A1 · operations · basic · debug đang trống, không sinh trùng mới |

**Mục "Ô trùng giữa các gói" của `BAN-DO-100-CAU.md` (dòng 201–209) đã cũ**: còn ghi s5-ngay-cuoi-thang/j2 (s5 nay E1 · sales · hard), r7/s7-ma-dang-ky-kinh-doanh (s7 nay C4 · customer · medium), j3-so-du-casa/t6, j4/t3, k2/t2 (các câu đã rời ô); **thiếu** cặp a7/p8. Thay danh sách bằng 4 dòng ở bảng trên. Mục "Lệch khung" ngay trên (p7 easy "ngoài khung medium/hard") cũng theo khung cấp cũ đã bỏ ở QUYET-DINH-CHUNG 0.1 #5, nên xoá.

Cặp gần chủ đề khác ô (tham khảo, không phải sửa): j9/p9 (lãi dự thu cho vay, trộn lãi tiền gửi), j5/k5 (đối soát dư nợ khoản vay với hai nguồn khác nhau), a6/c8.b2 (tỷ lệ khoản vay có vấn đề, theo sản phẩm / theo năm giải ngân), q5/t1 (phễu vay, đếm khách / đếm hồ sơ).

## Bảng thời gian câu chậm

Đo bằng `chay.py`, mỗi truy vấn một lần, tuần tự, user `sql_runner`. MySQL dùng chung đang rất bận lúc đo (PROCESSLIST có 7 truy vấn chạy song song; `SELECT COUNT(*) FROM core_payment_order` mất 4,7 giây), nên các số dưới đây là trần, không phải thời gian lúc máy rảnh.

| câu | phần | public | hidden-1 | ghi chú |
|---|---|---|---|---|
| aivb-t5 solution | C | 5,6–6,7 giây | 4,2–5,3 giây | < 10 giây |
| aivb-k7 solution | C | 2,3–5,5 giây | 1,9–5,0 giây | < 10 giây |
| **aivb-k7 starter** | C | **48,6–53,7 giây** | **31,8–38,2 giây** | Cần sửa (xem bảng kiểm) |
| aivb-c8 b1, b3 | C | 1,6–3,3 giây | 1,8–2,5 giây | |
| aivb-c9 b2–b4 | C | 1,9–3,3 giây | 2,1–3,1 giây | |
| Các câu C khác | C | ≤ 1,2 giây | ≤ 1,2 giây | wrong `left_join_dung_khoa` của j9 3,5 giây |
| aivb-s6 solution | B | 24,5–31,4 giây | 33,3 giây | thuộc phần B; đo thêm một lần lúc `COUNT(*)` trần còn 1,6 giây vẫn 24,5 giây → **vượt 10 giây** |
| aivb-t3 solution | B | 0,4 giây | 0,4 giây | bản v4 đã viết lại, hết chậm |
| aivb-c10 b1 | B | 49,0–64,6 giây | 66,2 giây | thuộc phần B; **vượt 10 giây** cả khi `COUNT(*)` trần 1,1 giây |
| aivb-c10 b2 | B | 9,2 giây | 12,2 giây | sát / vượt 10 giây |
| aivb-c10 b3 | B | 49,8 giây | 54,0 giây | **vượt 10 giây** |
| aivb-c10 b4 | B | 59,2 giây | 54,4 giây | **vượt 10 giây** |

Ghi chú đo: trong suốt lúc đo PROCESSLIST luôn có khoảng 7 truy vấn của agent khác chạy cùng, nên số tuyệt đối cao hơn lúc máy rảnh. Nhưng tỷ lệ so với `COUNT(*)` trần (1,1–4,7 giây) cho thấy s6 và c10 b1, b3, b4 chậm thật chứ không chỉ do máy bận; đề nghị người kiểm B đo lại lúc máy rảnh trước khi kết luận. Phần C chỉ có starter k7 vượt ngưỡng.
