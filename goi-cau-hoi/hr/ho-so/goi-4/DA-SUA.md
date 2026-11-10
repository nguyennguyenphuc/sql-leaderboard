# Đã sửa · gói 4 HR Analytics (hr) · v2 sau kiểm B/C

Kiểm lại: gói tạm `cong-cu/ket-qua/sua/hr-goi-4/` (5 câu sửa SQL: t5, t8, t9, f7, c8) chạy bộ kiểm thật → **KIEM TRA: 0 loi**;
cả gói `--chi-phan-tich` → **0 loi**; biên dịch `cong-cu/ket-qua/bien-dich/hr-goi-4/`. Không sửa database hay biến thể ẩn.

| Mã | Đã sửa (theo B/C) | Kiểm lại |
|---|---|---|
| hr-t1-nghi-viec-yoy-theo-phong | B: bỏ "Năm 2025 có cận trên chưa?" ở gợi ý 1; yêu cầu ghi "trên hai tỷ lệ chưa làm tròn"; sửa ghi chú thiết kế (dòng 2026-01 nằm ở nhóm 2026, không ảnh hưởng). | tĩnh |
| hr-t2-doi-soat-dinh-bien | C: tiêu đề "Kế hoạch định biên có khớp danh sách nhân viên?"; chiều thứ nhất ghi rõ `so_nv_danh_sach` là quân số cuối tháng 12; lời nhắn "xem bên nào thiếu, bên nào thừa". | tĩnh |
| hr-t3-pheu-tuyen-dung | B: `\luuy` sửa đúng dữ liệu ("chưa có người đi làm trong năm, dù có thể đã có người nhận lời"); "truy vấn con trả về một giá trị". | tĩnh |
| hr-t4-cay-duoi-mot-giam-doc | C: yêu cầu ghi rõ tính cả người nghỉ trong tháng 12 (E02172, E03770); lời nhắn "đang tính sắp xếp lại", "cách E01688 mấy cấp", "phòng Tài chính"; ERD bỏ 2 bảng nhiễu (còn 2); bỏ dấu hai chấm nối mệnh đề. | tĩnh |
| hr-t5-chuoi-quan-ly-lap | B: đổi người xuất phát E02456 → E00041 (public vào vòng ba người E02554 – E00975 – E02287, 6 dòng; hidden-1 bỏ E02287 nên 5 dòng): hai biến thể nay khác nhau; tiêu đề "lặp lại ba người"; yêu cầu 2 theo câu B; `\luuy` nói nghiệp vụ, bỏ khuôn "Muốn … thì …" và bỏ lộ cách sửa; lời nhắn đổi cách kết. | bộ kiểm: 0 lỗi, 2 wrong rớt public |
| hr-t7-cohort-tuyen-moi | B: yêu cầu 2 định nghĩa rõ "tháng vào làm cộng thêm k tháng" kèm ví dụ '2024-02' → '2024-05'; tiêu đề, lời nhắn, gợi ý 1 theo B. SQL không đổi. | tĩnh |
| hr-t8-union-mat-dong | C: `\luuy` thành quy tắc nghiệp vụ, chuyển ý "bỏ dòng giống hệt" sang gợi ý nấc 2; tiêu đề "của vài nguồn"; người hỏi đổi sang Trưởng nhóm tuyển dụng (giữ cấp Trung bình); thay wrong yếu bằng `union_all_bo_gom_ngoai` (UNION ALL nhưng bỏ phép cộng ngoài). | bộ kiểm: 0 lỗi, wrong rớt cả hai |
| hr-t9-doi-soat-except | B + điều phối: lỗi chuyển vào phép trừ tập hợp. Starter giữ đúng phạm vi người nghỉ nhưng vế sau ghép (mã, tháng bắt đầu làm việc) thay cho (mã, `attrition_month`), nên không trừ được ai. Yêu cầu không còn nói sẵn cách sửa; `\luuy` nói nghiệp vụ; gợi ý 1 hỏi về nghĩa cột tháng hai vế, gợi ý 2 (NOT IN gặp NULL) nay có ích. Wrong mới `tru_moi_yeu_cau`; giữ `not_in_gap_null`. | bộ kiểm: 0 lỗi, 2 wrong rớt cả hai |
| hr-f1-top3-lam-them-moi-nuoc | Không phải sửa (C: Đạt). | – |
| hr-f2-luy-ke-nghi-viec | B: lời nhắn "số người nghỉ đã bằng một nửa của cả năm". | tĩnh |
| hr-f3-de-bat-theo-thang | C: ghi rõ cách tính "bình quân các lần đề bạt trong cùng tháng (mỗi lần đề bạt một giá trị)". | tĩnh |
| hr-f4-gan-ket-giam-truoc-nghi | B: tiêu đề "Ai có điểm gắn kết giảm liền trước khi nghỉ?" (giữ ≤ 10 tiếng); gợi ý 1 bỏ dấu hai chấm; `kynang` "gom chuỗi liên tiếp". | tĩnh |
| hr-f5-gan-ket-truot-sales-indonesia | C: lời nhắn bỏ "làm mượt"; đảo hai nấc gợi ý (nấc 1 hướng nghĩ, nấc 2 cú pháp); ERD bỏ 2 bảng nhiễu (còn 2). Giữ cấp Khó. | tĩnh |
| hr-f6-yeu-cau-dat-nhat-moi-phong | B: yêu cầu 3 "gấp bao nhiêu lần mức bình quân đó". | tĩnh |
| hr-f7-top3-lam-them-rank | C + điều phối: viết lại câu (giữ mã). Bản cũ có starter đúng ở public và lời nhắn kể thay đổi của biến thể ẩn. Bản mới: ba người làm thêm nhiều nhất mỗi **phòng ban**, starter xếp hạng trên dòng nhân viên – tháng trước khi cộng (public lặp E01039, E01516, giờ chỉ một tháng); kỹ năng gom nhóm trước khi xếp hạng, không lặp hoà hạng của f1. Wrong `tong_bang_ham_cua_so`. | bộ kiểm: 0 lỗi, starter rớt cả hai, wrong rớt cả hai |
| hr-f8-tang-luong-lag-sai | B: tách yêu cầu 1 thành hai ý; "phòng Kỹ thuật (\code{'Engineering'})"; lời nhắn đổi cách kết. | tĩnh |
| hr-f9-luy-ke-khong-reset | Không phải sửa (C: Đạt). | – |
| hr-c7-gan-ket-bao-truoc | B: định nghĩa `so_nguoi` từng bước (b1 số người có ít nhất một dòng; b2 số dòng kể cả điểm trống; b3 chỉ người có phiếu 2025-Q2); phương án 1 đổi khuôn câu, phương án đúng rút gọn; giải thích phương án đúng và phương án 3 theo B; ERD nối n-n theo `employee_id` và quý. SQL không đổi. | tĩnh |
| hr-c8-diem-nong-vn-engineering | C: b2 sắp theo bình quân chưa làm tròn (hết chấm oan Sales/Finance 10,8), cột `ty_le_tu_40_gio_pct`; `\luuy` theo C và thêm câu về bước 1 xếp theo số người; phương án: bỏ "chạm", "ba trong năm phòng còn lại", thêm câu rào vào một phương án sai, rút phương án đúng (K32); thống nhất "phòng Kỹ thuật"; ERD còn 2 bảng nhiễu. | bộ kiểm: 0 lỗi |

Quy ước chung sau sửa: tên phòng ban viết tiếng Việt, lần đầu kèm giá trị DB (phòng Kỹ thuật (\code{'Engineering'}), phòng Kinh doanh, phòng Tài chính); lời nhắn câu Sửa lỗi không còn cùng kết "Em sửa giúp anh/chị".

## Chờ giảng viên

1. **t7:** 140 người có `tenure_months = 0` ở tháng 2024-01. Khái niệm `nhan-vien-moi` (STYLE-hr) loại họ; B hỏi có nên coi họ là nhân viên mới. Giữ nguyên định nghĩa hiện tại, chờ chốt.
2. **c7:** nhóm "ở lại" vẫn chọn theo điều kiện còn làm tới 12/2025, nên đo cùng quý (bước 3) chỉ bỏ được phần chênh do khác thời điểm đo, chưa bỏ hết thiên lệch người ở lại. Đã sửa câu giải thích cho đúng mức này; cách chọn nhóm so sánh chờ giảng viên.
3. **c8.b3:** so người nghỉ của cả 24 tháng (dòng tháng nghỉ) với người ở lại tháng 12/2025, khác thời điểm đo. Giữ nguyên, chờ giảng viên chốt cách so.
4. **Cấp và bảng nhiễu:** f5, c8 (C) và t8 sát ranh giới cấp; ERD cấp Khó đã giảm còn 2 bảng nhiễu ở t4, f5, c8. t5, t7, f4, f8 vẫn 4 bảng nhiễu (B chỉ nêu là khuôn lặp, chưa sửa).

## Quyết định v3 (10/11)

Nguồn domain: DD = `Project 02 HR Analytics\data\data_dictionary.md`; GEN = `scripts\augment_datasets.py` (chỉ đọc); QDC = `QUYET-DINH-CHUNG.md`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `hr-t7-cohort-tuyen-moi` | 140 người `tenure_months = 0` tháng 2024-01 (hidden-1: 129) bị loại khỏi nhân viên mới | Giữ định nghĩa `nhan-vien-moi` | DD mục 1 ("open cohort", tuyển mới hằng tháng); GEN dòng 226–232, 268–270 (2024-01 là nhóm ban đầu, thâm niên rút ngẫu nhiên rồi làm tròn xuống) và dòng 388 (tuyển mới từ tháng thứ hai) | Ghi chú thiết kế ghi căn cứ và số đo hai biến thể |
| `hr-c7-gan-ket-bao-truoc` | Nhóm ở lại chọn theo điều kiện còn làm tới 12/2025 (thiên lệch người ở lại) | Giữ cách chọn nhóm; lời giải thích nêu giới hạn | BAO-CAO 3.2; lưu ý của câu đã định nghĩa thiên lệch người ở lại | Lời giải thích phương án đúng: bước 3 bỏ được chênh do khác thời điểm đo, chưa bỏ thiên lệch người ở lại |
| `hr-c8-diem-nong-vn-engineering` b3 | So người nghỉ 24 tháng với người ở lại tháng 12/2025 | Giữ; thêm lưu ý | BAO-CAO 3.2; DD mục 5 (mức lương thị trường theo năm) | Lưu ý thêm câu hai nhóm đo ở hai thời điểm; ghi chú thiết kế |
| `hr-c8` · RS | K32 câu rào | Đã cân ở v2: phương án đúng không có rào, rào nằm ở một phương án sai; giữ | Kiểm lại văn bản phương án | Ghi chú thiết kế ghi kết quả kiểm |
| `hr-f5`, `hr-c8`, `hr-t8` | Sát ranh giới cấp | Giữ cấp | QDC 2.3 mục 13 | – |
| `hr-t5`, `hr-t7`, `hr-f4`, `hr-f8`; `hr-t4`, `hr-f5`, `hr-c8` | ERD Khó | Mọi câu Khó vẽ 5 bảng chỉ khoá: t5, t7, f4, f8 giữ 5 bảng như v2 (lời giải 1 bảng, 4 bảng nhiễu); t4, f5, c8 nâng từ 3–4 lên 5 bảng | CHOT-FORMAT mục 3 (Khó 5–7 bảng); QDC 1.3 sửa theo quy_chuan 23:05 (lời giải dùng ít bảng thì thêm bảng nhiễu cho đủ 5, như mẫu d4, o4) | t4, f5, c8: thêm bảng nhiễu, sửa `erdkhoa`, ghi chú thiết kế; t5, t7, f4, f8: ERD không đổi so với v2, ghi chú thiết kế ghi căn cứ |
| `hr-c7`, `hr-c8` | Tiền tố lời giải thích bước kết luận | Theo gói mẫu quy chuẩn: phương án đúng mở bằng "Đúng: ", phương án sai không có tiền tố | QDC 1.1 (sửa theo quy_chuan 23:05; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4) | "Đúng. " → "Đúng: " ở 2 phương án đúng; phương án sai không tiền tố (lượt trước đã thêm "Chưa đúng. ", nay gỡ lại theo quy chuẩn) |

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: lộ trình chuẩn (`quy_chuan/lo-trinh-sql/assets/js/data.js`) cho mỗi module đủ Cơ bản → Khó; mục tiêu mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó, giữ 6 write + 3 debug. Đổi số câu tối thiểu: 5 mỗi module (4 câu Trung bình và 1 câu Khó xuống Cơ bản/Dễ). Năm trục (QUYET-DINH-CHUNG 2.2): số bảng lời giải cần · số tầng xử lý · mức mơ hồ · số bẫy dữ liệu · độ sâu nghiệp vụ; ghi chi tiết ở `\ghichuthietke` từng câu.

| Module | Trước (Cơ bản / Dễ / TB / Khó) | Sau | Hình thức sau |
|---|---|---|---|
| M7 | 0 / 0 / 6 / 3 | 2 / 3 / 2 / 2 | 6 write + 3 debug (debug: t8 Dễ, t9 TB, t5 Khó) |
| M8 | 0 / 0 / 6 / 3 | 2 / 3 / 2 / 2 | 6 write + 3 debug (debug: f9 Cơ bản, f7 TB, f8 Khó) |

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (cấp mới) |
|---|---|---|---|
| `hr-t2-doi-soat-dinh-bien` → `hr-t2-vi-tri-moi-ke-hoach-2025` | TB → Cơ bản | Viết lại: vị trí có trong kế hoạch 2025 mà không có ở 2024, bằng `EXCEPT` trên `position_plan` (phần ghép tập của M7). ERD 1 bảng có giá trị mẫu. Wrong đảo hai vế; wrong so cả `planned_headcount`. Bỏ ô trùng E2 · operations · TB · write với `hr-j2`. | 1 bảng · 1 tầng · đề ghi rõ cột và giá trị lọc · 0 bẫy · 1 khái niệm → 5/5 Cơ bản |
| `hr-t3-pheu-tuyen-dung` (giữ mã) | TB → Dễ | Bỏ cột tỷ lệ so với bước 1 (hàm cửa sổ / truy vấn con); bỏ khoá `saiso`; ERD 2 bảng có chữ trên đường nối; gợi ý 2 nêu CTE + `UNION ALL`. Giữ 2 wrong. | 1 bảng · 2 tầng · đề ghi rõ điều kiện từng bước · 1 bẫy (ngày đi làm sau cửa sổ) · không công thức → 4/5 Dễ |
| `hr-t4-cay-duoi-mot-giam-doc` → `hr-t4-so-cap-duoi-truc-tiep` | Khó → Cơ bản | Viết lại: phân bố quản lý theo số cấp dưới trực tiếp tháng 12/2025, CTE + gom hai lượt (bài Cơ bản "viết lại bảng dẫn xuất thành CTE" của lộ trình). Dạng E3 → A3. CTE đệ quy vẫn có ở t5. Wrong giữ ô trống `manager_id`; wrong quên lọc tháng. | 1 bảng · 1 tầng mỗi lượt gom · đề nêu rõ cách bỏ ô trống, ERD có giá trị mẫu · 0 bẫy · 1 khái niệm → 5/5 Cơ bản |
| `hr-t6-ty-trong-quy-luong` (giữ mã) | TB → Dễ | Bỏ cột quân số và tỷ trọng quân số; công thức tỷ trọng ghi trong đề; cột ra `department`, `quy_luong`, `ty_trong_pct`; ERD 2 bảng có chữ trên đường nối. Giữ 2 wrong (viết lại theo cột mới). | 1 bảng · 2 tầng · công thức trong đề · 1 bẫy (mẫu số khác phạm vi tháng) · 1 phép chia → 5/5 Dễ |
| `hr-t8-union-mat-dong` (giữ mã) | TB → Dễ | SQL không đổi. Theo bài Sửa lỗi Dễ `t3-union-mat-dong` của lộ trình (quy chuẩn đứng trên QDC 2.1). Người hỏi đổi lại thực tập sinh; yêu cầu nêu rõ cách tính tổng; bẫy chỉ còn `union-mat-dong`; ERD 2 bảng có chữ trên đường nối. | 1 bảng · 2 tầng · đề nêu rõ cách tính · 1 lỗi một chỗ (UNION) · 1 khái niệm → 5/5 Dễ |
| `hr-f2-luy-ke-nghi-viec` → `hr-f2-luy-ke-chi-phi-tuyen-dung` | TB → Dễ | Viết lại: chi phí tuyển dụng từng tháng năm 2025 và luỹ kế (`SUM() OVER (ORDER BY)`), bỏ cột tỷ lệ luỹ kế; đổi chủ đề để không lặp luỹ kế người nghỉ ở f9. Mảng after\_sales → marketing. Wrong thiếu cận trên (hidden-1, R0801); wrong bỏ `ORDER BY` trong `OVER`. | 1 bảng · 2 tầng · đề ghi rõ cột, dạng tháng · 1 bẫy (cận trên, chỉ lộ ở hidden-1) · không công thức chia → 5/5 Dễ |
| `hr-f3-de-bat-theo-thang` (giữ mã) | TB → Dễ | Bỏ cột tăng lương bình quân (công thức hai thành phần); định nghĩa đề bạt và mốc so tháng 1/2025 với 12/2024 ghi trong đề; bỏ `saiso`; ERD 2 bảng có chữ trên đường nối. Giữ 2 wrong (bỏ cột lương). | 1 bảng · 2 tầng · đề ghi rõ định nghĩa · 1 bẫy (lọc trước khi LAG) · 1 khái niệm → 5/5 Dễ |
| `hr-f5-gan-ket-truot-sales-indonesia` → `hr-f5-hang-nghi-viec-sales-theo-chuc-danh` | Khó → Dễ | Viết lại: xếp hạng `RANK()` chức danh phòng Kinh doanh trong từng nước theo số người nghỉ tự nguyện 2024–2025 (bài Dễ `f3-hang-nhom-hang` của lộ trình); giữ mảng sales. Dạng B3 → C1. Wrong `ROW_NUMBER` (hoà hạng 2 ở cả hai biến thể); wrong lọc trước khi gom (mất cặp 0 người ở Singapore). Không áp mức luật Việt Nam cho nước khác. | 1 bảng · 2 tầng · đề nêu rõ quy tắc hoà · 1 bẫy (nhóm 0 người) · 1 khái niệm → 5/5 Dễ |
| `hr-f6-yeu-cau-dat-nhat-moi-phong` → `hr-f6-thu-tu-yeu-cau-singapore` | TB → Cơ bản | Viết lại: đánh số `ROW_NUMBER()` các yêu cầu năm 2025 trong từng phòng ban ở Singapore theo ngày duyệt (bài Cơ bản `f1-thu-tu-don`). Dạng C1 → A1. ERD 1 bảng, giá trị mẫu lấy yêu cầu năm 2024 (không lộ dòng kết quả). Wrong thiếu `PARTITION BY`; wrong sắp theo mã yêu cầu. Hidden-1: bỏ R0447, R0787, thêm R9001 (28 → 27 dòng). | 1 bảng · 1 tầng · đề ghi rõ cột, giá trị lọc, tiêu chí phụ · 0 bẫy · 1 khái niệm → 5/5 Cơ bản |
| `hr-f9-luy-ke-khong-reset` → `hr-f9-luy-ke-chay-nguoc` | TB → Cơ bản | Viết lại lỗi: luỹ kế người nghỉ tự nguyện năm 2025 với `ORDER BY thang DESC` trong `OVER` (một chỗ, thấy ngay: tháng 1 bằng cả năm). Lỗi cũ thiếu `PARTITION BY` là sai phạm vi cửa sổ, mức TB theo QDC 2.2, đã có ở f7, f8. ERD 1 bảng có giá trị mẫu; người hỏi là thực tập sinh. Wrong bỏ `ORDER BY` trong `OVER`; wrong sắp theo số người nghỉ. | 1 bảng · khởi đầu 2 tầng, sửa một từ · đề nêu rõ cách tính · 0 bẫy · 1 khái niệm → 4/5 Cơ bản |

Giữ nguyên (cấp đã đúng chỗ trống): M7 t1, t9 (TB), t5, t7 (Khó); M8 f1, f7 (TB), f4, f8 (Khó); case c7, c8 giữ cấp.

Kỹ năng sau v4: M7 có `EXCEPT` (t2, t9), CTE (t1, t3, t4, t6, t7), `UNION`/`UNION ALL` (t3, t8), CTE đệ quy (t5); M8 có `ROW_NUMBER` (f6, f1), `RANK` (f5), `LAG` (f3, f8), luỹ kế (f2, f9), gom chuỗi (f4), gom trước khi xếp hạng (f7). Trung bình trượt `ROWS BETWEEN` (f5 cũ) không còn trong gói.

Ô dạng × mảng × cấp × hình thức: không trùng trong gói. Trùng khác gói: `hr-f6` A1 · marketing · Cơ bản · write với `hr-r3` (gói 1), `hr-s2` (gói 2), cho phép, đã ghi ở `\ghichuthietke`. Ô E2 · operations · TB · write (`hr-j2` / `hr-t2` cũ) không còn trùng. Các gói khác đang sửa song song, cần rà lại khi ghép bản đồ.

Kiểm: bộ kiểm đầy đủ cả gói `cong-cu/ket-qua/cap-do/hr-goi-4/` → **KIEM TRA: 0 loi**, 0 cảnh báo; mọi wrong rớt ≥ 1 biến thể; 10 câu đổi đều cho kết quả public khác hidden-1; solution chậm nhất khoảng 2 giây. Biên dịch XeLaTeX `cong-cu/ket-qua/cap-do/hr-goi-4/bien-dich/`: 0 lỗi LaTeX, 0 ký tự thiếu. Thư mục gói vẫn đúng 4 file. Bản đồ `../BAN-DO-100-CAU.md`: đã cập nhật 10 dòng của gói 4; phần thống kê cuối file chưa sinh lại (dùng chung 5 gói).


## Sửa theo KIEM-V4 (11/11/2026)

Đầu vào: `ho-so/KIEM-V4-B.md`, `ho-so/KIEM-V4-C.md`. Không đổi cấp câu nào; mỗi module vẫn 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó. Quy tắc ô (đính chính của người điều phối 11/11): trùng ô giữa hai gói được phép, chỉ gỡ khi trùng trong cùng gói hoặc trùng cả chủ đề.

| Mã | Điểm B/C | Đã sửa gì | Kết quả kiểm |
|---|---|---|---|
| hr-t5-chuoi-quan-ly-lap | B: Sửa lỗi Khó mà starter chỉ 1 lỗi; ở hidden-1 starter ra đúng bằng lời giải; bối cảnh 37 tiếng | Thêm lỗi thứ hai theo đề xuất của B: phần neo bỏ `snapshot_month = '2025-12'`, lấy mọi tháng của E00041 (24 dòng). Starter nay ra 231 dòng ở public, 116 dòng ở hidden-1, khác lời giải ở cả hai biến thể; sửa riêng một lỗi vẫn sai. Thêm wrong `chi_chan_chu_trinh_quen_thang_neo` (rớt cả hai biến thể). Tiêu đề ``Tuyến báo cáo của E00041 ra cả trăm dòng lặp lại''; lời nhắn 33 tiếng nêu triệu chứng mới; yêu cầu ghi ``hai lỗi chồng nhau''; gợi ý nấc 1 thêm câu hỏi về số dòng của phần neo; bẫy thêm `neo-thieu-thang`; `\ghichuthietke` ghi điểm 5 trục (QDC 2.3 mục 14). Lời giải không đổi. | Bộ kiểm cả gói 0 lỗi; lời giải < 1 giây; wrong mới rớt public và hidden-1 |
| hr-f5-hang-nghi-viec-sales-theo-chuc-danh → hr-f5-nghi-viec-sales-binh-quan-truot | B, C: M8 mất ``Trung bình trượt (ROWS BETWEEN)''; C: f5 thêm một câu xếp hạng trong nhóm (M8 đã có f1, f6, f7) | Viết lại theo đề xuất của C, giữ cấp Dễ, hình thức write, mảng sales (phân bố 2/3/2/2 và tỷ lệ hình thức của M8 không đổi): số người nghỉ tự nguyện phòng Sales từng tháng năm 2025 và bình quân ba tháng gần nhất bằng `AVG() OVER (ORDER BY thang ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)`. Dạng C1 → B3 (ô B3 · sales · easy · write trống). Bẫy: lọc năm trước khi tính cửa sổ làm tháng 1, 2 thiếu tháng 11, 12/2024. Wrong: lọc năm trước cửa sổ, khung mặc định (bình quân luỹ kế), thiếu cận trên. Đổi mã vì nội dung đổi hẳn. Lý do giữ hr-p9 ở M10 (``khung ROWS/RANGE học ở M8'', QDC 2.3 mục 15) đúng trở lại. | Bộ kiểm cả gói 0 lỗi; lời giải < 1 giây; public khác hidden-1 (tháng 3, 11, 12); hai wrong rớt cả hai biến thể, wrong thiếu cận trên rớt hidden-1 |
| hr-f6-thu-tu-yeu-cau-singapore | B: `\ghichuthietke` ghi trùng ô với r3, s2 (r3 nay Khó); tiêu đề lủng củng; ô trùng với s2. C: đề xuất trả về dạng C1 | Sửa ghi chú: chỉ còn trùng ô với s2 (gói 2), khác gói và khác chủ đề nên giữ. Tiêu đề theo B: ``Đánh số yêu cầu tuyển dụng năm 2025 của từng phòng ở Singapore''. Không đổi dạng (đề xuất của C chỉ nhằm gỡ trùng ô khác gói, đã được phép). | Bộ kiểm cả gói 0 lỗi |
| hr-c7-gan-ket-bao-truoc | C: ERD case Trung bình có chữ trên đường nối; lời giải thích phương án đúng có cụm cụt | Bỏ `tren=` khỏi đường nối n-n; lời giải thích theo câu sửa của C (``…người nghỉ có điểm thấp hơn rõ từ sáu tháng trước; bước 3 so cùng quý nên bớt được lệch thời điểm, nhưng chưa bỏ được thiên lệch người ở lại.''); ghi lý do ở `\ghichuthietke`. | Bộ kiểm cả gói 0 lỗi |

Bộ kiểm đầy đủ cả gói `cong-cu/ket-qua/sua-v4/hr-goi-4/` → **KIEM TRA: 0 loi**, 0 cảnh báo; biên dịch XeLaTeX `cong-cu/ket-qua/sua-v4/hr-goi-4/bien-dich/`: 0 lỗi LaTeX. Thư mục gói vẫn đúng 4 file.
