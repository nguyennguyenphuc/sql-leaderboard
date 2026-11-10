# Chuẩn hoá bộ HR (`hr`) theo quy chuẩn · 10/11/2026

Theo `BRIEF-CHUAN-HOA.md`. Thứ tự căn cứ: `quy_chuan\` > `QUYET-DINH-CHUNG.md` (QDC) > `style/STYLE-hr.md` > brief. Không đổi SQL, mã, khoá chấm. Lượt trước (v3, `QUYET-DINH-126.md`) đã làm: "Đúng: " ở 10 case, khôi phục bảng nhiễu ERD Khó (5 bảng), đổi mã s5, s7, đổi cấp r8, a3, k2, k5, k8, p1, k4, k6. Lượt này rà lại cả 100 câu theo 6 mục và sửa phần còn lệch.

## Số chỗ sửa theo 6 mục

| # | Mục | Số chỗ | Câu và nội dung |
|---|---|---:|---|
| 1 | Kết luận case | 2 | Cả 10 case đã đúng khuôn (phương án đúng "Đúng: ", phương án sai không tiền tố, lời giải thích ≤ 31 tiếng). Cân độ dài: `hr-c3` phương án đúng 31 → 28 tiếng, `hr-c5` 37 → 31 tiếng (trước đó dài nhất rõ rệt, lộ đáp án) |
| 2 | Gợi ý | 8 | Nấc cuối nêu trọn một biểu thức như mẫu w1, w3: `hr-s3` (`CONCAT(YEAR(...), '-Q', QUARTER(...))`), `hr-s4` thêm nấc 2 (`DATEDIFF(start_date, offer_accept_date)`), `hr-s6` (`CASE WHEN job_family LIKE '%Lead%' ...`), `hr-a1` thêm nấc 2, `hr-a2` thêm nấc 2, `hr-a5` thêm nấc 2 (khoảng nửa mở của ngày duyệt), `hr-t6` thêm nấc 2 (tỷ trọng từ CTE), `hr-k3` (biểu thức nhãn quý trong điều kiện nối). Câu Sửa lỗi có gợi ý dạng câu hỏi như mẫu d1, d2 giữ nguyên |
| 3 | Tiêu đề | 1 | `hr-q2` 14 → 13 tiếng ("Mỗi nước duyệt bao nhiêu yêu cầu tuyển cho vị trí đủ người?"). 6 câu Tối ưu (p1–p6) đều đã nêu ràng buộc; không \boicanh nào nhắc kỹ thuật SQL |
| 4 | ERD Khó | 3 | Thêm `\erdkhoa` (chỉ nêu khoá, như mẫu d4) cho 3 câu Sửa lỗi Khó trước để "ERD trung tính" không có khoá: `hr-t5`, `hr-f8` (gói 4), `hr-k9` (gói 5; không nêu điều kiện tháng để không lộ lỗi). Cả 14 câu Khó nay: 5–6 bảng chỉ khoá, 0 `\erdnoi`, có `\erdkhoa`. ERD cấp khác khớp CHOT mục 3 (Cơ bản 1 bảng, Dễ 2 bảng có chữ trên đường nối, Trung bình 3 bảng có ký hiệu) |
| 5 | Cấp | 1 | `hr-a9` Trung bình → Dễ (xem dưới) |
| 6 | Thư mục gói 4 file | 20 file | `git mv` `BANG-PHAN-CONG.md`, `DA-SUA.md`, `REVIEW-B.md`, `REVIEW-C.md` của gói 1–5 sang `ho-so/goi-<k>/`. Sửa đường dẫn trong `QUYET-DINH-126.md`. README, BRIEF đã dùng `ho-so\` từ trước |

## Câu đổi cấp

| Mã | Cũ → mới | Căn cứ | Đi kèm |
|---|---|---|---|
| `hr-a9-ty-le-thang-cong-tac-sales` | medium → easy | HD mục 6 (Sửa lỗi Dễ = lỗi logic một chỗ, ví dụ `COUNT(*)` thay `COUNT(DISTINCT)`); QDC 2.1, 2.2: 1 bảng, lọc + gom, quy tắc ghi trong đề, một lỗi `COUNT(điều kiện)` đếm cả 0 | ERD 3 → 2 bảng, chữ trên đường nối; `\ghichuthietke`; `BAN-DO-100-CAU.md` (dòng câu, bảng thống kê, mục chênh lệch); `ho-so/goi-2/BANG-PHAN-CONG.md` |

Đã xét, giữ cấp: `hr-a8` (bình quân của bình quân là lỗi khó thấy), `hr-j8`, `hr-j9` (nối làm rơi dòng), `hr-q8`, `hr-q9` (sai phạm vi truy vấn con tương quan), `hr-t8` (`UNION` bỏ dòng trùng hợp lệ, QDC 2.1 nêu là Trung bình), `hr-f7`, `hr-f9` (sai phạm vi cửa sổ). Phân bổ cấp theo module: M1–M3 chỉ có Cơ bản, Dễ; M7, M8 chỉ có Trung bình, Khó. QDC 2.1 chỉ bỏ ràng buộc cấp theo module (mọi module được có đủ 4 cấp), không bắt viết thêm câu; không câu nào lệch rõ nên không đổi.

## Gói 4: đối chiếu khôi phục từ git HEAD

`git diff HEAD -- goi-cau-hoi/hr/goi-4/cau-hoi.tex` so với `ho-so/goi-4/DA-SUA.md`: HEAD (b4d9cae, 22:18) đã chứa đủ v2 (kiểm 15 chuỗi đặc trưng: tiêu đề t2, t5, t8, f4; E00041; ví dụ '2024-05' của t7; các wrong mới của t8, t9, f7; `ty_le_tu_40_gio_pct`…). Diff chỉ gồm các mục v3 (ERD 5 bảng t4, f5, c8; ghi chú ERD t5, t7, f4, f8; "Đúng: " và lời giải thích c7, c8; câu lưu ý hai thời điểm đo của c8). Không câu nào bị quay về bản cũ.

## Kiểm

- `--chi-phan-tich` gói 1–5: 0 lỗi, 0 cảnh báo, hết `GOI_FILE_LA`.
- Bộ kiểm đầy đủ (public + hidden-1): gói 5 `cong-cu/ket-qua/kiem-cuoi/hr-goi-5-chuan-hoa/log.txt` 0 lỗi; gói 2, 4 (ERD đổi) `…/hr-goi-2-chuan-hoa/`, `…/hr-goi-4-chuan-hoa/` đều 0 lỗi. Sau đó chỉ gỡ 7 ký tự điều khiển lọt vào ba dòng `\erdkhoa` mới (t5, f8, k9; làm XeLaTeX báo lỗi), kiểm tĩnh lại gói 4, 5: 0 lỗi.
- Biên dịch XeLaTeX `cong-cu/ket-qua/bien-dich/hr-goi-<k>-chuan-hoa/`: 0 lỗi LaTeX, 0 ký tự thiếu font (còn cảnh báo Overfull hbox về trình bày).
