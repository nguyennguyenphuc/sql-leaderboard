# Chuẩn hoá bộ Marketing (`mkt`) theo quy chuẩn

Ngày 10/11/2026, theo `BRIEF-CHUAN-HOA.md` (căn cứ: `quy_chuan\` > `QUYET-DINH-CHUNG.md` > `style/STYLE-mkt.md`). Không đổi SQL, mã, khoá chấm, trừ khoá `cap` của k7 (mục 5).

Lượt trước (QĐC bản 23:05, xem `../QUYET-DINH-126.md`) đã làm: tiền tố "Đúng: " ở 10 case, bỏ "Chưa đúng." ở 20 phương án sai; ERD Khó t5, t9, p3; đổi 9 mã (a5, c2, c3, p3, t4, k6, p2, p4, p6); hạ t7, k8 về Dễ, p1 về Cơ bản. Lượt này kiểm lại: không còn mã cũ trong `goi-cau-hoi\mkt\` ngoài `REVIEW-*.md` và các ghi chú "(cũ …)" trong hồ sơ.

## Số chỗ sửa theo 6 mục

| Mục | Kiểm | Sửa | Chi tiết |
|---|---|---|---|
| 1. Kết luận case | 30 phương án của 10 case | 4 lời giải thích | Tiền tố đã đúng ở cả 30 (10 "Đúng: ", 20 không tiền tố). Rút ngắn c5 (đúng 36 → 28 tiếng; sai 35 → 27) và c6 (đúng 39 → 27; sai 33 → 27) để ≤ 35 tiếng và ba phương án dài gần bằng nhau. |
| 2. Gợi ý | 100 câu, 10 case (từng bước) | 3 nấc cuối | Nấc cuối chỉ tả bằng lời nay nêu trọn một biểu thức: c1.b1 và c5.b1 (`ROUND(SUM(clicks) * 100 / SUM(impressions), 2)`), c6.b1 (truy vấn con tương quan đếm bản sạch). Không câu nào đưa cả câu SQL hay khung nhiều dòng. Gợi ý dạng câu hỏi ở câu sửa lỗi Cơ bản, Dễ (r7, j8, q7) giữ, như mẫu d1, d2. |
| 3. Tiêu đề | 100 tiêu đề | 11 | Rút còn ≤ 13 tiếng: r1, r2, n2 (gói 1); s3, s5 (gói 2); j5, j9, q5, q6, q9 (gói 3); p3 (gói 5, giữ ràng buộc "quét một lần"). Cột Tiêu đề của `BAN-DO-100-CAU.md` đổi theo. |
| 4. ERD | 19 ERD Khó; ERD các cấp khác | 0 ERD Khó; 5 ERD cấp khác | 19 ERD Khó (16 câu, 3 case) đều 5–7 bảng, không `\erdnoi`, có `\erdkhoa`. Cấp khác theo CHOT mục 3: j4, j5, j9, q9 (Trung bình, đang 2 bảng) thêm 1 bảng nhiễu có đường nối đúng (`campaign_types` cho j4, `brands` cho j5, j9, q9); k7 đổi theo cấp mới (mục 5). |
| 5. Cấp | 100 câu | 1 câu | `mkt-k7-doi-tuong-tho-le-te`: Trung bình → **Dễ**. Starter chỉ thiếu `TRIM` ở một chỗ, triệu chứng (nhóm trùng tên) hiện ngay trên kết quả: sửa lỗi một chỗ dễ thấy là Dễ (HD mục 6, QĐC 2.1); câu tương tự s7 đang ở Cơ bản. ERD 4 bảng → 2 bảng (`campaigns_raw`, `brands` nhiễu, chữ trên đường nối). Đã cập nhật `BAN-DO-100-CAU.md` (dòng k7, 3 bảng thống kê đếm lại từ 100 dòng, mục Kiểm khung) và `ho-so/goi-5/BANG-PHAN-CONG.md`. |
| 6. Thư mục gói | 5 gói | 20 file | `git mv` BANG-PHAN-CONG.md, DA-SUA.md, REVIEW-B.md, REVIEW-C.md của từng gói sang `ho-so/goi-<k>/`. Mỗi `goi-<k>\` còn đúng 4 file. Sửa đường dẫn ở `../QUYET-DINH-126.md`; README gốc đã ghi `ho-so/`. |

Phân bố cấp sau chuẩn hoá: basic 15 · easy 36 · medium 30 · hard 19.

## Câu đổi cấp

| Mã | Cũ | Mới | Lý do |
|---|---|---|---|
| `mkt-k7-doi-tuong-tho-le-te` | medium | easy | Sửa lỗi một chỗ dễ thấy (thêm `TRIM`), 1 bảng, gom một tầng. |

## Còn lệch, giữ có lý do

- `mkt-j1-doanh-thu-loai-thuong-hieu` (Dễ, ERD 3 bảng): lời giải cần cả `brands`, `campaigns`, `campaign_types`; Dễ vẫn đạt 4/5 trục. Bớt bảng thì thiếu bảng lời giải.
- `mkt-q7-shoppers-ra-rong` (Cơ bản, ERD 2 bảng): lỗi nằm trong truy vấn con trên `audiences`, nên ERD phải có hai bảng; lỗi một chỗ ở giá trị lọc là Cơ bản.
- Brief mục 5 ghi "mọi module có đủ 4 cấp". Ở đây hiểu như QĐC 2.1: cấp do 5 trục quyết định, không bị module giới hạn. Phân bổ hiện tại chưa đủ 4 cấp trong từng module (ví dụ M1–M3 chưa có Trung bình, Khó). Muốn đủ thì phải soạn lại nhiều câu, ngoài phạm vi "chỉ đổi cấp khi rõ ràng lệch". Cần giảng viên quyết định.

## Kiểm

- `kiem_tra_goi.py --chi-phan-tich`, 5 gói: **0 lỗi**, không còn cảnh báo `GOI_FILE_LA` (báo cáo `cong-cu/ket-qua/chuan-hoa/mkt-goi-<k>/`).
- Bộ kiểm đầy đủ (MySQL, public + hidden-1) cho các gói đổi ERD hoặc cấp: gói 3 **0 lỗi** (`cong-cu/ket-qua/chuan-hoa/mkt-goi-3-day-du/`), gói 5 xem `cong-cu/ket-qua/chuan-hoa/mkt-goi-5-day-du/`.
- Biên dịch XeLaTeX (`cong-cu/bien_dich.sh`, ra `cong-cu/ket-qua/bien-dich/chuan-hoa-mkt-goi-<k>/`): 5 gói 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo của gói lệnh.
