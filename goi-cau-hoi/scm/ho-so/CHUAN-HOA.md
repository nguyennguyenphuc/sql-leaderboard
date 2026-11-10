# Chuẩn hoá bộ scm theo quy chuẩn (BRIEF-CHUAN-HOA, 10/11/2026)

Căn cứ: `quy_chuan\` (CHOT-FORMAT-CAU-HOI.md, Huong-dan-cho-team-noi-dung.md, goi-cau-hoi-mau\cau-hoi.tex, HUONG_DAN.md) > QUYET-DINH-CHUNG.md > STYLE-scm.md. Riêng cách gọi: với bộ scm, sách dự án eDA2026 là chuẩn (`H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\SupplyChain\bai-giang\Final\capnhat_0711\project-supply-chain\main.tex`). Không đổi SQL, mã, khoá chấm.

Việc agent trước đã làm (không tính lại ở bảng dưới): đổi 10 case sang "Đúng: ", khôi phục nấc cuối gợi ý r1, n4, n6, n8, hạ k3, p7 xuống Dễ, đổi mã j6 thành `scm-j6-gmroi-theo-loai-cua-hang`.

| Mục | Số chỗ sửa | Chi tiết |
|---|---|---|
| 1. Kết luận case | 3 | Rà 30 phương án của c1–c10: phương án đúng đều mở bằng "Đúng: " rồi viết chữ thường như mẫu; phương án sai không có tiền tố. Lời giải thích > 35 tiếng rút lại: c5 đúng (40 → 33), c7 đúng (55 → 33). c5 rút phương án đúng cho cân (33 → 28 tiếng; ba phương án 20/28/25). Các case khác ≤ 35 tiếng, độ dài cân. |
| 2. Gợi ý | 6 | Nấc cuối nêu trọn một biểu thức một dòng: n9 (`is_cancelled = 0`), q7 (`s.item_nbr = i.item_nbr`), f8 (`OVER (PARTITION BY supplier_id ORDER BY received_date, po_id ROWS …)`, thay câu hỏi), c9 b4 (nối theo `hub_id` và `date`, thay "Hai bảng nối theo cả kho và ngày"). a4 thêm nấc 2 (`HAVING AVG(t.transactions) < 1000`). Không câu nào có khung nhiều dòng hay cả câu SQL. |
| 3. Tiêu đề | 4 | Rút về ≤ 13 tiếng: c4 (14 → 11, "Hàng khuyến mãi ở cửa hàng 44 bán cao hơn bao nhiêu?"), p2 (15 → 12), p6 (14 → 12). c1 đổi cách gọi theo sách ("Tự động áp mã có làm khách huỷ đơn ít hơn?"). Sáu câu Tối ưu p1–p6 đều nêu ràng buộc ("một lần quét", "không tự nối bảng"). |
| 4. ERD cấp Khó | 3 ERD (+ 4 ghi chú) | Mọi ERD Khó không có `\erdnoi`. Thêm `\erdkhoa` cho ba câu Sửa lỗi Khó còn thiếu (như mẫu d4): t5, f8, k8; `\ghichuthietke` bỏ chữ "ERD trung tính", ghi số bảng nhiễu. k6 sửa số bảng nhiễu trong ghi chú (3 → 4). Số bảng: mọi câu Khó có 5–6 bảng; câu có lời giải ≤ 3 bảng đều đã đủ 5. **t7**: lời giải dùng 2 bảng (`purchase_orders`, `suppliers`), ERD 5 bảng với 3 bảng nhiễu (`items`, `warehouses`, `item_costs`) đúng CHOT mục 3 (lời giải ≤ 3 bảng thì thêm cho đủ 5), không chỉnh. |
| 5. Cấp | 0 câu đổi cấp | Rà 13 câu Sửa lỗi Trung bình, Khó: mỗi câu Trung bình có lỗi khó thấy (nối nhân dòng j7, k7; sai phạm vi cửa sổ f7, f9; `UNION` bỏ dòng trùng hợp lệ t6; `UNION ALL` đếm trùng p8; thiếu truy vấn con tương quan q8; …) hoặc hai lỗi (n9); câu Khó t5, f8, k8 có hai lỗi chồng nhau. k3, p7 đã là Dễ. BAN-DO-100-CAU.md chỉ cập nhật tiêu đề (c1, c4, a3, p2, p6) và chữ của p8. |
| 6. Thư mục gói 4 file | 24 file | `git mv` BANG-PHAN-CONG.md, DA-SUA.md, REVIEW-B.md, REVIEW-C.md (gói 1–5) và BAN-DO-GOI.md (gói 2–5) sang `ho-so\goi-<k>\`. Sửa đường dẫn trong `QUYET-DINH-126.md`, `BAN-DO-100-CAU.md`; README.md, BRIEF-SOAN-GOI.md đã ghi `ho-so\goi-<k>\` từ trước. |

## Cách gọi nhóm `checkout_group` theo sách dự án

Sách dự án (main.tex dòng 4556): "nhóm khách tự áp mã (\code{manual}) và nhóm được hệ thống tự động áp mã (\code{auto\_apply})". Đã khôi phục trong 5 gói: "tự nhập voucher" → "tự áp mã", "hệ thống tự áp voucher" → "hệ thống tự động áp mã" (30 chỗ: gói 1: 8, gói 2: 7, gói 4: 6, gói 5: 9; gồm khái niệm `voucher`, `nhom-ap-ma`, c1, a3, t9, p8). Không còn chữ "tự nhập voucher" trong 5 gói. Mã câu `scm-c1-tu-ap-voucher-huy-don` giữ nguyên. Đã sửa STYLE-scm (dòng thuật ngữ A.3 và dòng "Riêng scm" ở G), QUYET-DINH-CHUNG 1.7 và `QUYET-DINH-126.md`, đều ghi "theo sách dự án".

## Kiểm

`kiem_tra_goi.py --chi-phan-tich` cả 5 gói → 0 lỗi, 0 cảnh báo (hết GOI_FILE_LA). `bien_dich.sh` cả 5 gói → 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo aio-sql-cauhoi (chỉ còn Overfull hbox trình bày).

## Để ngỏ (quy ước bổ sung, không thuộc quy chuẩn)

ERD Trung bình t4, t9, p8 có một bảng nhiễu không vẽ đường nối; k2 có 3 bảng, chỉ `holidays` dùng, không đường nối (bảng `holidays` không có khoá). CHOT mục 3 chỉ quy định 3–4 bảng, ký hiệu 1-n, nên chưa sửa; QUYET-DINH-CHUNG 1.3 (quy ước bổ sung) muốn bảng nhiễu Trung bình có đường nối và tối đa 1 bảng.
