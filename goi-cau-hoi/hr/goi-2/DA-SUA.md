# Đã sửa · gói 2 · HR Analytics (`hr`) · v2 (10/11/2026)

Theo `REVIEW-B.md`, `REVIEW-C.md` và `BRIEF-SUA-GOI.md`. Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/hr-goi-2/` (6 câu đã sửa SQL hoặc cấp: s5, s6, s7, s8, a4, c4), chạy trên MySQL: `KIEM TRA: 0 loi`.
- **Cả gói, kiểm tĩnh** (`--chi-phan-tich`): 20 câu, 66 khối SQL, `KIEM TRA: 0 loi`.
- **Biên dịch** XeLaTeX: PDF 44 trang, 0 lỗi LaTeX, 0 ký tự thiếu (`cong-cu/ket-qua/bien-dich/hr-goi-2/`).

Sửa chung cho cả gói: "làm tròn 0 chữ số" thành "làm tròn đến hàng đơn vị", các chỗ khác thành "làm tròn N chữ số thập phân";
"Sửa để ra đúng" thành "Sửa truy vấn cho đúng"; bỏ khuôn "Em … giúp anh/chị" ở 10 lời nhắn (còn 1, ở a6); "theo tab Nghiệp vụ" tách thành mệnh đề riêng;
thống nhất "yêu cầu tuyển dụng"; tiêu đề tối đa 10 tiếng (trừ a3, a6 giữ nguyên vì người kiểm đánh giá đạt).

| Mã | Đã sửa (theo B/C) | Kiểm lại |
|---|---|---|
| `hr-s1-nghi-viec-theo-nam` | B: tiêu đề "Mỗi năm có bao nhiêu người nghỉ việc?"; yêu cầu 2 viết lại, tách "xem tab Nghiệp vụ"; `\luuy` ghi rõ `attrition_this_month` = 1; lời nhắn bỏ khuôn "Em … giúp" | tĩnh 0 lỗi |
| `hr-s2-nhan-viec-thu-hai` | C: tiêu đề thành câu hỏi; lời nhắn nói rõ mục đích (xem năm 2025 có bao nhiêu trường hợp), "yêu cầu tuyển dụng"; dòng quyết định; gợi ý 1 viết lại | tĩnh 0 lỗi |
| `hr-s3-yeu-cau-theo-quy` | B: tiêu đề "Số yêu cầu tuyển dụng được duyệt mỗi quý"; lời nhắn bỏ "nhịp", dạng câu hỏi; `\luuy` bỏ câu lộ gợi ý (thay bằng định nghĩa quý) | tĩnh 0 lỗi |
| `hr-s4-cho-nhan-viec` | C: yêu cầu 1 ghi cận dưới, cận trên tường minh; yêu cầu 2 bỏ khuôn "Tính X là Y"; dòng quyết định đổi "rút ngắn thời hạn báo trước" thành "hẹn ngày đi làm sớm hơn" (chờ giảng viên); lời nhắn dạng câu hỏi | tĩnh 0 lỗi |
| `hr-s5-y-dinh-o-lai-thap-q3` | B: đổi kỳ thành bốn quý năm 2025, bỏ "(quý 3 bắt đầu từ tháng 7)", ví dụ Q1 ứng '2025-01', nên phải dùng 3q − 2 + `LPAD` (thêm wrong `go_cung_thang` gõ cứng '-07', rớt public + hidden-1); tiêu đề, lời nhắn (bỏ "rời công ty"); `\luuy` nêu thang `intent_to_stay` 1–5; bỏ `\khainiem{diem-gan-ket}` không dùng; sửa `\ghichuthietke`. Mã giữ chữ q3 | gói tạm 0 lỗi |
| `hr-s6-cong-tac-truong-nhom-sales` | C: nhãn `vai_tro` không dấu ('Truong nhom', 'Nhan vien') để tránh lệch chuẩn hoá Unicode; "chuỗi 'Lead'"; gợi ý 2 không còn đưa sẵn biểu thức; lời nhắn dạng câu hỏi; tiêu đề 10 tiếng | gói tạm 0 lỗi |
| `hr-s7-dem-nghi-theo-nam-null` | B: đổi bẫy cho khác s1: starter lọc `snapshot_month BETWEEN '2024' AND '2025'` (so chuỗi, mất cả năm 2025); wrong `moc_dang_ngay_day_du` ('2024-01-01' bỏ tháng 1/2024) và `dung_year_tren_chuoi`; tiêu đề không còn "NULL"; lời nhắn đổi câu kết; `\luuy` kỹ thuật bỏ khỏi tab Nghiệp vụ. Mã giữ nguyên (chữ "null" trong mã không còn khớp nghĩa) | gói tạm 0 lỗi |
| `hr-s8-quy-4-thieu-thang-12` | C: tiêu đề, lời nhắn đúng dữ liệu (starter **không có** dòng tháng 12 trên public); `\luuy` bỏ phần BETWEEN (chuyển vào gợi ý 2), thay bằng định nghĩa quý 4; "yêu cầu tuyển dụng"; hạ cấp Dễ → Cơ bản, ERD còn 1 bảng có giá trị mẫu; lời nhắn đổi câu kết | gói tạm 0 lỗi |
| `hr-s9-quan-so-sai-thu-tu` | B (không bắt buộc): "năm tài chính" → "12 tháng từ tháng 7/2024"; lời nhắn bỏ "Em sửa giúp chị"; tách "định nghĩa ở tab Nghiệp vụ" | tĩnh 0 lỗi |
| `hr-a1-nghi-theo-ly-do-2025` | C: tiêu đề nói rõ loại nghỉ ("Người nghỉ tự nguyện năm 2025 vì lý do gì?"); lời nhắn bỏ khuôn | tĩnh 0 lỗi |
| `hr-a2-luong-theo-bac` | B: "làm tròn đến hàng đơn vị"; lời nhắn bỏ khuôn | tĩnh 0 lỗi |
| `hr-a3-ty-le-nghi-viec-theo-nuoc` | C: bỏ "(số dòng chia 12)" khỏi yêu cầu (học viên lấy công thức từ khái niệm), giữ cấp Trung bình; lời nhắn bỏ "mất người", dạng câu hỏi | tĩnh 0 lỗi |
| `hr-a4-phong-compa-thap` | B: hạ cấp Trung bình → Dễ; ERD còn 2 bảng có điều kiện nối (bỏ nối `job_family` → `job_role` thiếu khoá); tiêu đề nói rõ nước × phòng ban; "3 chữ số thập phân" | gói tạm 0 lỗi |
| `hr-a5-chi-phi-thoi-gian-tuyen` | C (tuỳ chọn): lời nhắn "Anh đang lập…", "tách riêng"; "làm tròn đến hàng đơn vị" | tĩnh 0 lỗi |
| `hr-a6-enps-theo-quy` | B: cột `enps` ghi rõ thang −100 tới +100 (ví dụ 25,5 chứ không phải 0,255); lời nhắn "diễn biến eNPS qua từng quý"; tách "công thức xem tab Nghiệp vụ". Cấp giữ Trung bình (chờ giảng viên) | tĩnh 0 lỗi |
| `hr-a7-dem-nguoi-theo-phong-trung` | C: yêu cầu bỏ "số nhân viên khác nhau", thêm "mỗi người chỉ tính một lần"; dòng quyết định "đối chiếu số tài khoản đã cấp"; lời nhắn đổi câu kết | tĩnh 0 lỗi |
| `hr-a8-luong-bq-tu-bq-phong` | B: "bảng lương" → "số liệu (chi trả) lương bên kế toán" ở tiêu đề, lời nhắn, dòng quyết định; "kết quả bị lệch"; "làm tròn đến hàng đơn vị"; ERD bỏ nối `country` sai ký hiệu, thay bảng nhiễu `position_plan` (n-1) | tĩnh 0 lỗi |
| `hr-a9-ty-le-thang-cong-tac-sales` | C: yêu cầu 1 viết lại, "tỷ lệ 100\%"; `\luuy` bỏ phần lộ lỗi, thay bằng định nghĩa tháng công tác dài; dòng quyết định thêm "hay không"; lời nhắn bỏ khuôn; tiêu đề 8 tiếng | tĩnh 0 lỗi |
| `hr-c3-lam-them-malaysia` | B (không bắt buộc): mô tả `so_dong_tren_40` rõ hơn; lời giải thích phương án đúng thêm giới hạn 104 giờ/tháng của Malaysia (B đã đối chiếu); lời nhắn bỏ khuôn | tĩnh 0 lỗi |
| `hr-c4-nguon-tuyen-nhanh-re` | C: bước 1 đổi thành "Mặt bằng chung năm 2025" (1 dòng: số yêu cầu, thời gian, chi phí bình quân), thêm wrong bình quân của bình quân theo nguồn; phương án đúng có ngưỡng "bốn nguồn có trên 50 yêu cầu" và so với mặt bằng ở bước 1; phương án 3 bỏ "mang về", "nhiều yêu cầu thứ hai"; `\luuy` không còn nêu sẵn lý do loại phương án 1; lời nhắn dạng câu hỏi | gói tạm 0 lỗi |

## Chờ giảng viên

1. **a6 (eNPS theo quý), cấp Trung bình:** chỉ 1 bảng và `SUM(CASE)`; độ sâu nghiệp vụ eNPS bù được một phần. Giữ Trung bình hay hạ Dễ?
2. **a3 (tỷ lệ nghỉ việc theo nước), cấp Trung bình:** đã bỏ chỉ dẫn công thức trong yêu cầu nhưng vẫn là 1 bảng, 1 lần gom; gợi ý trả phí nấc 2 còn công thức `COUNT(*) / 12`.
3. **s4, dòng quyết định:** đã đổi "rút ngắn thời hạn báo trước" (thuật ngữ BLLĐ Điều 35, sai chủ thể) thành "hẹn ngày đi làm sớm hơn trong thư mời làm việc"; cần người nắm domain xác nhận.
4. **ERD cấp Dễ/Trung bình vẽ thêm bảng không cần nối** (`positions`, `position_plan`) ở hầu hết câu Module 3–4 để đúng cỡ ERD theo cấp; giảng viên chấp nhận hay cho phép ERD 1 bảng ở hai module này.
5. **Mã s5 (`…-q3`) và s7 (`…-null`)** không còn khớp hẳn nội dung sau khi sửa; giữ mã theo quy định, đổi mã nếu giảng viên muốn.
6. Phân bổ cấp sau sửa: Module 3 có 4 câu Cơ bản (s1, s2, s7, s8) và 5 câu Dễ; Module 4 có 5 câu Dễ (a1, a2, a4, a5, a7) và 4 câu Trung bình (a3, a6, a8, a9); bản đồ 100 câu (M3: 3 basic, 6 easy; M4: 4 easy, 5 medium) cần cập nhật nếu giảng viên đồng ý.
