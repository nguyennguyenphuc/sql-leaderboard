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
| jelly-t7-union-doanh-thu | B: đạt, không sửa (cấp Trung bình giữ, xem chờ giảng viên) | – |
| jelly-t8-cte-loc-sai-cho | C: yêu cầu không nói thẳng cách sửa ("Sửa để tỷ lệ đúng định nghĩa ở tab Nghiệp vụ"); `\luuy` chỉ nêu ngày phát hành 2.1.1; câu chỉ lỗi chuyển sang gợi ý 2 (trừ điểm); bớt 1 bảng nhiễu | tĩnh (SQL không đổi) |
| jelly-t9-ab-itt | B: bối cảnh nói rõ "sau 1 lần thua thay vì 3 lần" và có lời nhờ; yêu cầu 1 tách câu; gợi ý 2 thành câu hỏi gợi mở; bớt 1 bảng nhiễu | tĩnh |
| jelly-f1-top3-man-quit | C: tiêu đề chủ động; yêu cầu nêu `result = 'quit'` và nói rõ xếp theo số lượt; bỏ `\khainiem{ty-le-bo-cuoc}`, `\luuy` giải thích số lượt khác tỷ lệ | tĩnh |
| jelly-f2-dau-trot-7-ngay | B: bối cảnh bỏ "DAU", có lời nhờ; yêu cầu đảo trật tự; tên bảng chỉ số ngày | tĩnh |
| jelly-f3-luy-ke-chi | C: thêm đơn vị, làm tròn; bỏ `\khainiem{cpi}` không dùng; "dùng hết hạn mức" | tĩnh |
| jelly-f4-doanh-thu-tuan-wow | B: bỏ "nhịp"; `\luuy` khuôn "nếu … thì"; tên bảng chỉ số ngày; bớt 2 bảng nhiễu | tĩnh |
| jelly-f5-chuoi-ngay-lien-tiep | C: "trong hai tháng qua" thay "hiện nay"; giải nghĩa LiveOps; yêu cầu đảo trật tự; bớt 2 bảng nhiễu; ghi chú hidden-1 đúng thực tế | tĩnh |
| jelly-f6-nguoi-chi-top-quoc-gia | B: hạ `cap=medium`, ERD 3 bảng có ký hiệu; bối cảnh có lời nhờ; `\luuy` bỏ hai "nên" liền nhau | tĩnh (SQL không đổi) |
| jelly-f7-rank-thay-row-number | C: bỏ `\khainiem{ty-le-su-co}` (đếm `crash_count`), `\luuy` nói rõ đếm lượt `result = 'crash'`; tiêu đề "lại ra năm màn"; "Chị Hạnh bên QA"; đổi khuôn lời nhắn thực tập sinh; gợi ý tách 2 nấc, không nói thẳng ở nấc 1 | tĩnh |
| jelly-f8-lag-khong-partition | B: hạ `cap=medium` (một lỗi), ERD 3 bảng có ký hiệu; yêu cầu 1 viết lại; "chị đoán là có chỗ sai" | tĩnh |
| jelly-f9-ty-trong-goi | C: `\luuy` viết lại theo định nghĩa | tĩnh |
| jelly-c7-android-210 | B: lời giải thích phương án A và C khớp số thật (iOS 2.1.0 ở b1, b2 chênh dưới 1 điểm, D1 có thấp hơn; iOS 2.1.1 thấp hơn các nhóm iOS khác nhưng vẫn cao hơn Android 2.1.0 ở cả ba chỉ số); `\luuy` bỏ "cùng thời điểm", nêu rõ mỗi bản ứng với một khoảng ngày; tiêu đề không khẳng định nhân quả; bối cảnh có lời nhờ; yêu cầu b1–b3 bỏ khuôn "Theo X × Y:" | tĩnh (SQL không đổi) |
| jelly-c8-doanh-thu-giam-vi-dau | C: `saiso` về 0,01; ARPDAU bước 2 tính bằng cent để vẫn phân biệt wrong; bước 1, 2, 3 ghi rõ bảng nguồn; bước 3 gọi đúng "ngày-người" (giải nghĩa), alias `iap_moi_ngay_nguoi_tra_tien_usd`; phương án đúng và lời giải thích viết lại; tiêu đề bỏ chữ viết tắt; tên wrong b4 `doi_goc_tach`; bớt 1 bảng nhiễu | gói tạm: 0 lỗi, 4 wrong rớt public + hidden-1 |

## Chờ giảng viên

1. c7: có cần nhắc trong kết luận việc nhóm iOS cài 2.1.1 cũng thấp hơn các nhóm iOS khác (D1 giảm khoảng 3,4 điểm so với iOS 2.0.2) không. Bản v2 giữ phương án đúng chỉ nói Android 2.1.0, lời giải thích phương án C đã nêu số đúng.
2. f1: để chọn màn cần chỉnh độ khó, xếp theo số lượt bỏ cuộc (đề hiện tại, theo bản đồ) hay theo tỷ lệ bỏ cuộc. Bản v2 nói rõ là xếp theo số lượt và giải thích ở `\luuy`.
3. t4: cách đối soát người cài với chi phí theo chiến dịch × thị trường × ngày × nền tảng (bản v2 có ghép nền tảng) có đúng thực tế của bên thu hút người chơi (UA) không; bỏ Organic khỏi đối soát có được không.
4. t7, f9: cấp Trung bình cho lỗi một chỗ (UNION, `PARTITION BY`) hay hạ Dễ. Bản v2 giữ Trung bình.
5. Module 8 có ba câu top 3 bằng `ROW_NUMBER` (f1, f6, f7); B đề nghị đổi f6 sang kỹ năng khác (`NTILE`, `FIRST_VALUE`). Bản v2 chỉ hạ cấp f6, chưa đổi kỹ năng.
6. c8: ARPDAU ở bước 2 tính bằng cent (khác quy ước 4 chữ số USD của STYLE) để dùng sai số chung 0,01.
