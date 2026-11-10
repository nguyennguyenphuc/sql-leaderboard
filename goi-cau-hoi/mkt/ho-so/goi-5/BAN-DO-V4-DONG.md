# Dòng bản đồ mới của gói 5 sau v4 (11/11/2026)

Chép vào mục "Gói 5 · M9 Data Quality, M10 Query Performance" của `../../BAN-DO-100-CAU.md`: mỗi dòng mới thay đúng dòng có mã cũ ghi ở bảng thứ nhất (agent v4 không sửa `BAN-DO-100-CAU.md`). 13 dòng còn lại của gói 5 giữ nguyên. Cột theo đúng định dạng bản đồ: "Đề một câu" là hai mục đầu của `yeucau`, "Bảng" lấy từ `FROM`/`JOIN` của lời giải (bỏ CTE), "Bẫy chính" là khoá `bay`.

| Mã mới | Thay dòng có mã cũ | HT, cấp cũ → mới |
|---|---|---|
| `mkt-k1-ho-so-null` | `mkt-k1-ho-so-null` | W medium → W basic |
| `mkt-k5-dong-doanh-thu-lech-ban-sach` | `mkt-k5-doi-soat-doanh-thu-tho-sach` | W hard → W easy |
| `mkt-k9-ma-lap-ra-ca-file` | `mkt-k9-doanh-thu-sach-con-trung` | D hard → D basic |
| `mkt-p2-bao-cao-thang-3-theo-loai` | `mkt-p2-bao-cao-thang-3-theo-loai` | O medium → O easy |
| `mkt-p5-chi-phi-roi-bon-quy-mot-lan-quet` | `mkt-p5-dang-chay-moi-ngay-nhanh` | O hard → O easy |
| `mkt-p6-thoi-luong-purplle-mot-lan-quet` | `mkt-p6-dong-trung-du-lieu-tho` | O hard → O basic |
| `mkt-p8-so-chien-dich-theo-thang-lech` | `mkt-p8-bao-cao-thang-cham-va-sai` | D medium → D easy |

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-k1-ho-so-null | 5 | M9 | W | basic | E1 | ops | Mỗi cột số của dữ liệu thô thiếu bao nhiêu ô? | Xét mọi dòng của bản thô `campaigns_raw`, kể cả dòng trùng. · Ở mỗi thương hiệu (`brand_id`), đếm tổng số dòng và số ô trống (NULL) của từng cột `impressions`, `clicks`, `leads`, `conversions`, … | R | count-cot-nguoc-nghia |
| mkt-k5-dong-doanh-thu-lech-ban-sach | 5 | M9 | W | easy | E2 | fin | Bao nhiêu dòng thô ghi doanh thu khác bản sạch? | Ghép mỗi dòng của bản thô `campaigns_raw` với chiến dịch cùng `campaign_id` trong bản sạch `campaigns`. · Một dòng thô là dòng lệch khi `revenue` của dòng đó khác `revenue` của bản sạch. Dòng thô … | R, C | null-trong-so-sanh |
| mkt-k9-ma-lap-ra-ca-file | 5 | M9 | D | basic | E1 | ops | Danh sách mã chiến dịch lặp của Purplle ra gần cả file | Truy vấn dưới đây cần liệt kê các mã chiến dịch (`campaign_id`) xuất hiện hơn một lần trong bản thô `campaigns_raw` của Purplle (`brand_id = 2`), kèm số dòng của mỗi mã. · Giữ tên cột … | R | sai-toan-tu-having |
| mkt-p2-bao-cao-thang-3-theo-loai | 5 | M10 | O | easy | A3 | mkt | Báo cáo tháng 3/2025 theo loại chiến dịch chỉ đọc phần cần | Giữ nguyên kết quả: các chiến dịch bắt đầu trong tháng 3/2025, theo loại chiến dịch: `type_id`, `so_chien_dich`, `doanh_thu` (đơn vị tiền), `ctr_pct` (CTR của nhóm, phần trăm, 2 chữ số). · Sắp … | C | boc-ham-cot-ngay, can-tren-thang |
| mkt-p5-chi-phi-roi-bon-quy-mot-lan-quet | 5 | M10 | O | easy | B1 | fin | Chi phí và ROI bốn quý gộp trong một lần quét | Giữ nguyên kết quả: mỗi quý của kỳ 7/2024 tới 6/2025 một dòng, gồm `quy` (chuỗi dạng `'2024-Q3'`), `so_chien_dich`, `chi_phi` (đơn vị tiền, làm tròn 2 chữ số), `roi` (tỷ lệ của tổng, làm tròn 4 … | C | union-all-lap, thieu-can-tren |
| mkt-p6-thoi-luong-purplle-mot-lan-quet | 5 | M10 | O | basic | A3 | ops | Đếm chiến dịch Purplle theo thời lượng chỉ với một lần quét | Giữ nguyên kết quả: một dòng gồm `so_ngan` (5 tới 10 ngày), `so_vua` (11 tới 20 ngày), `so_dai` (21 tới 30 ngày), là số chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ 1/5/2025 tới hết … | C | truy-van-con-quet-lai |
| mkt-p8-so-chien-dich-theo-thang-lech | 5 | M10 | D | easy | B1 | mkt | Số chiến dịch theo tháng lệch số lọc trên file | Đếm số chiến dịch theo tháng của ngày bắt đầu, mỗi tháng của kỳ 7/2024 tới 6/2025 một dòng. · Giữ tên cột `thang` (chuỗi `'YYYY-MM'`), `so_chien_dich`; sắp `thang` tăng dần. | C | thang-30-ngay |

Dòng thống kê cần cộng lại khi chép (agent gói khác đang sửa song song, chưa cộng): gói 5 trước v4 có M9 basic 0 · easy 2 · medium 3 · hard 4 và M10 basic 1 · easy 0 · medium 4 · hard 4; sau v4 mỗi module basic 2 · easy 3 · medium 2 · hard 2. Hình thức không đổi (M9: 6 W + 3 D; M10: 6 O + 2 W + 1 D).
