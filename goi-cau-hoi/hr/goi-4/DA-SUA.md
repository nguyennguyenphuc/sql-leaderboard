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
