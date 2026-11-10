# Quyết định 18 điểm "Chờ giảng viên" · bộ Supply Chain (`scm`)

Ngày 10/11/2026. Theo `BRIEF-QUYET-DINH-126.md`, áp `QUYET-DINH-CHUNG.md` (mục 1, 2.3). Chi tiết căn cứ và việc đã sửa ở mục "Quyết định v3 (10/11)" của `ho-so/goi-<k>/DA-SUA.md`. Sách dự án = `H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\SupplyChain\bai-giang\Final\capnhat_0711\project-supply-chain\main.tex` (eDA2026, bản 07/11).

## 18 điểm của bộ (BAO-CAO-TONG-HOP mục 3.1–3.4, 3.7, 3.8)

| # | Nhóm | Mã | Gói | Trạng thái | Quyết định | Căn cứ chính |
|---|---|---|---|---|---|---|
| 1 | 3.1 | scm-t7, scm-t9 | 4 | Đã sửa | t7 giữ, ghi bẫy yếu ở `\ghichuthietke`; t9 giữ `saiso=0.001` (đề ghi làm tròn 2 chữ số) | BAO-CAO 3.1; đề t9 |
| 2 | 3.2 | scm-c3 | 2 | Đã sửa | Phương án đúng: "các kho đứng đầu có tỷ lệ trễ rất sát nhau, chưa đủ căn cứ ưu tiên riêng một kho"; "ưu tiên HUB_PHANTHIET" thành phương án sai | Chênh 0,28 điểm % trên 4.891 đơn, sai số chuẩn ≈ 0,31 điểm (chạy lại trên `scm`); sách dự án dòng 4580–4590 |
| 3 | 3.2 | scm-c7 | 4 | Đã sửa | Phương án đúng chỉ nêu tương quan; đổi tiêu đề; cân từ rào (K32) | Tháng 7 nhập/bán 0,90 mà fill rate chỉ giảm 0,28 điểm % |
| 4 | 3.2 | scm-c4 | 2 | Giữ nguyên | Mức "thử ưu tiên" của v2 đã là mức tương quan | Kết quả bước SQL của câu |
| 5 | 3.2 | scm-c10 | 5 | Giữ nguyên | Phương án đúng "tăng theo mùa", không gắn tháng | Dữ liệu bán gốc Favorita (Ecuador), mùa vụ không theo lịch Việt Nam |
| 6 | 3.3 | scm-r4 | 1 | Đã sửa | Giữ SQL, thêm `\luuy` hàng bán theo cân (kg) | Sách dự án dòng 4662 (dòng thập phân là hàng bán theo cân) |
| 7 | 3.3 | scm-n2 | 1 | Giữ nguyên | Lượng chưa về = lượng đặt − lượng đã nhận, gồm phần giao thiếu | Định nghĩa lượng còn mở của đơn mua; sách dự án dòng 3455; dữ liệu không đổi kết quả |
| 8 | 3.3 | scm-a3 | 2 | Đã sửa (đổi SQL) | Tỷ lệ dùng voucher trong nhóm `'manual'`; thêm wrong gộp cả nhóm tự động áp | Sách dự án dòng 4556–4590 (auto_apply 100%, manual 4,15%) |
| 9 | 3.3 | scm-s7 | 2 | Giữ nguyên | "Dòng tiền mua hàng" theo `qty_received`, không trừ hàng lỗi | Hàng lỗi vẫn ghi phiếu nhập; câu dạy lỗi sắp tháng |
| 10 | 3.3 | scm-t5 | 4 | Đã sửa | Thêm `\luuy` số liệu nhập xuất là dữ liệu mô phỏng, chưa gồm tồn đầu năm | `SupplyChain\docs\PHU-LUC_xay-dung-du-lieu_vn.md` dòng 71–73, 95 |
| 11 | 3.3 | scm-f6 | 4 | Giữ nguyên | Tập cửa hàng có giao dịch ở cả hai kỳ | Định nghĩa tăng trưởng cùng cửa hàng |
| 12 | 3.3 | scm-p2 | 5 | Giữ nguyên | "Có rà soát quy trình giao của kho vệ tinh hay không" | Sách dự án dòng 2009 (tỷ lệ huỷ gắn khâu thanh toán, giao) |
| 13 | 3.3 | scm-p8 | 5 | Giữ nguyên (sửa chữ) | Danh sách rà soát do người hỏi đặt, đề nêu rõ; đổi "tự áp" thành "tự nhập voucher" | Câu dạy `UNION` khử trùng; QUYET-DINH-CHUNG 1.7 |
| 14 | 3.4 | scm-k3, p7, k6, k2, k1, p1, p2 | 5 | Đã sửa | Hạ k3, p7 xuống Dễ (ERD 2 bảng, chữ trên đường nối); giữ k6, k2, k1, p1, p2 | QUYET-DINH-CHUNG 2.3 mục 1 |
| 15 | 3.7 | scm-c6 | 3 | Giữ nguyên | Mảng `marketing` | STYLE-scm G.8; sách dự án dòng 7539, 3148 (ngày cao điểm = ngày sale, lễ; sự kiện, chiến dịch) |
| 16 | 3.7 | scm-j8 | 3 | Giữ nguyên | Vai Trưởng ngành hàng | Trưởng ngành hàng so ngành mình với các ngành khác |
| 17 | 3.7 | scm-q2 | 3 | Giữ nguyên (xác nhận v2) | Vai Nhân viên mua hàng | Mua hàng là đầu mối với nhà cung cấp |
| 18 | 3.8 | scm-a8 | 2 | Đã sửa | `\luuy` rút về câu định nghĩa trung tính | RA-SOAT-GIONG |

Cộng: 10 đã sửa, 8 giữ nguyên có căn cứ (p8 giữ nội dung, chỉ đổi chữ).

## Quy ước chung áp vào bộ (mục 3.5, QUYET-DINH-CHUNG mục 1)

| Mục | Câu | Trạng thái | Việc làm |
|---|---|---|---|
| 1.1 kết luận case (sửa theo quy_chuan 23:05) | case c1–c10 | Đã sửa | "Đúng: " ở 10 phương án đúng; bỏ "Chưa đúng. " ở 21 phương án sai (gói mẫu c1–c4) |
| 1.2 Case Cơ bản dùng `GROUP BY` | c1, c2 (g1), c3 (g2) | Đã sửa | Thêm dòng `\ghichuthietke` theo 1.2 |
| 1.4 Gợi ý nấc 2 (sửa theo quy_chuan 23:05) | r1, n4, n6, n8 (g1) | Giữ nguyên | Nấc cuối được nêu trọn một biểu thức một dòng (gói mẫu w1, w3); bản để trống làm lúc 22:50 đã khôi phục |
| 1.5 Trùng ô | j6 (g3), j4 (g3) | Đã sửa j6, giữ j4 | j6 viết lại sang GMROI theo loại cửa hàng, **đổi mã** `scm-j6-bien-ln-gop-nganh-hang` → `scm-j6-gmroi-theo-loai-cua-hang`, ô C4 · finance |
| 1.7 "tự áp mã" | khái niệm `voucher` (g2, g5), khái niệm A/B và t9 (g4), p8 (g5) | Đã sửa, rồi khôi phục theo sách dự án (23:45, QUYET-DINH-CHUNG 1.7) | "khách tự áp mã" / "hệ thống tự động áp mã" như sách dự án dòng 4556; không còn chữ "tự nhập voucher" trong 5 gói (xem ho-so/CHUAN-HOA.md) |

## Kiểm

Bộ kiểm đầy đủ (public + hidden-1, MySQL `sqllb-mysql`) cả 5 gói: **KIEM TRA: 0 loi**; phân tích tĩnh bản cuối (sau khi đổi theo quy_chuan 23:05): 0 lỗi; biên dịch `cong-cu/bien_dich.sh`: 0 lỗi LaTeX, 0 ký tự thiếu ở cả 5 gói. Mã đã đổi: `scm-j6-bien-ln-gop-nganh-hang` → `scm-j6-gmroi-theo-loai-cua-hang`.
