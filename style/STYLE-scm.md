# Bộ chuẩn giọng văn và thuật ngữ · câu hỏi SQL Leaderboard trên bộ dữ liệu Supply Chain

Bản nháp 1 · 10/11/2026 · chờ giảng viên duyệt.

Áp dụng cho mọi phần chữ của một câu trong `cau-hoi.tex` thuộc bộ Supply Chain (chuỗi cung ứng bán lẻ và giao hàng chặng cuối, schema `scm`): `\tieude`, `\boicanh`, `yeucau`, `rangbuoc`, `nghiepvu` (câu "giúp quyết định gì", `\quytrinh`, `\luuy`), `\goiy`, `\phuongan`, `\khaibaokhainiem`, `\ghichuthietke`. Cú pháp LaTeX và cách chấm theo `quy_chuan/goi-cau-hoi-mau/HUONG_DAN.md`; tài liệu này chỉ quy định chữ.

Thứ tự ưu tiên khi các nguồn mâu thuẫn:
1. Quyết định của giảng viên ở `STYLE-GUIDE-luyen-sql.md` mục H (07/11/2026). Toàn bộ mục A, C, D của bộ chuẩn đó được kế thừa.
2. Sách dự án `project-supply-chain/main.tex`: Bảng thuật ngữ (dòng 6591–6690), Mục I.1–I.2 (665–1450), Mục II.1 (1638–1930), bảng chú giải cột (2519–2705). Học viên học theo sách, nên chỗ nào giáo trình đại học dùng khác thì **giữ từ của sách** và ghi từ của giáo trình ở cột "Ghi chú giáo trình".
3. Quy chuẩn ra đề: `quy_chuan/Huong-dan-cho-team-noi-dung.md`, `goi-cau-hoi-mau/cau-hoi.tex`.
4. Giáo trình đại học, báo cáo của Bộ Công Thương (có URL): dùng làm từ chính khi sách không có.
5. Nguồn phổ thông (MISA, Microsoft Learn, DataCamp, Viblo): chỉ khi bốn nguồn trên không có.

---

## 0. Nguồn và mã viết tắt

| Mã | Tài liệu | Trạng thái |
|---|---|---|
| S n | Sách dự án, dòng n của `main.tex` | đọc trực tiếp |
| SG | `style/STYLE-GUIDE-luyen-sql.md` (mục A–H, đã duyệt) | đọc trực tiếp |
| QC | `quy_chuan/Huong-dan-cho-team-noi-dung.md`, `goi-cau-hoi-mau/cau-hoi.tex` | đọc trực tiếp |
| DB | Cấu trúc và giá trị cột của schema `scm`, kiểm chỉ đọc ngày 10/11/2026 (`docker-postgres-1`, `default_transaction_read_only=on`) | xem `_nhap-scm/nguon-va-trich-dan.md` |
| TDMU | Giáo trình Quản trị chuỗi cung ứng, Trường ĐH Thủ Dầu Một, 2020. https://elearning.tdmu.edu.vn/pluginfile.php/427205/course/overviewfiles/QUAN%20TRI%20CHUOI%20CUNG%20UNG.pdf?forcedownload=1 | mở được, đọc toàn văn |
| LCB | Giáo trình Quản trị logistics căn bản, GS.TS Đặng Đình Đào, TS Nguyễn Thị Bạch Tuyết (đồng chủ biên), NXB Lao động. https://csdlkhoahoc.hueuni.edu.vn/data/2024/7/OK-Sach_Logistics_can_ban_Final_20_7_2024.pdf | mở được, đọc toàn văn; bìa PDF không ghi trường chủ quản |
| ĐTHV | Giáo trình Logistics, PGS.TS Đoàn Thị Hồng Vân, 2006 (bản đăng lại). https://novaspro.vn/upload/files/giao_trinh_quan_tri_logistics%20ok.pdf | mở được; bìa không ghi trường |
| TMU | Giáo trình Quản trị logistics kinh doanh, Nguyễn Thông Thái, An Thị Thanh Nhàn, NXB Thống kê 2011, ĐH Thương mại. https://dlib.tmu.edu.vn/handle/123456789/11469 | chỉ đọc được metadata và tóm tắt |
| BCT22 | Báo cáo Logistics Việt Nam 2022, Bộ Công Thương. https://nongthonvaphattrien.vn/uploads/images/blog/admin/2023/01/10/b-o-c-o-logistics-vi-t-nam-2022-1672918077-1673342054.pdf | mở được |
| BCT17 | Báo cáo Logistics Việt Nam 2017, Bộ Công Thương. https://moit.gov.vn/upload/2005517/20210707/bao-cao-logistics-viet-nam-20178796.pdf | mở được |
| MISA-VQ | https://amis.misa.vn/67710/vong-quay-hang-ton-kho/ (nguồn phổ thông, cách gọi của kế toán – tài chính) | mở được qua kết quả tìm kiếm |
| MISA-BW | https://amis.misa.vn/48956/hieu-ung-bullwhip/ (đã dùng trong SG) | theo SG |
| MSL | https://learn.microsoft.com/vi-vn/training/modules/write-queries-that-use-window-functions (hàm cửa sổ, đã dùng trong SG) | theo SG |
| DCV | https://www.datacamp.com/vi/tutorial/sql-subquery (truy vấn con, truy vấn con tương quan) | qua kết quả tìm kiếm |
| VBL | https://viblo.asia/p/nhung-kien-thuc-co-ban-ve-sql-4-n1j4lReALwl (hàm tổng hợp, HAVING); https://viblo.asia/p/nhung-kien-thuc-co-ban-ve-sql-7-qPoL72wNJvk (anti-join, theo SG) | qua kết quả tìm kiếm |

Không mở được hoặc không tìm thấy bản trực tuyến (không dùng làm căn cứ):
- Báo cáo Logistics Việt Nam 2024 (congthuong.vn): trang chặn tải, **không mở được**.
- GT Quản trị chuỗi cung ứng, An Thị Thanh Nhàn, ĐH Thương mại 2021 (tailieuso.tnut.edu.vn/handle/123456789/1298): **không mở được** (máy chủ từ chối kết nối).
- NEU: chỉ thấy tên "Quản trị chuỗi cung ứng", Nguyễn Thành Hiếu, NXB ĐH Kinh tế Quốc dân 2015 trong danh mục tài liệu của đề cương HUFLIT; **không tìm được bản trực tuyến**.
- UEH, FTU, ĐH Bách khoa Hà Nội (Quản trị chuỗi cung ứng, logistics, tác nghiệp, kho hàng, mua hàng; Cơ sở dữ liệu): **không tìm được bản trực tuyến**.
- VLA: **không tìm thấy** bảng thuật ngữ công bố.

---

## A. Bảng thuật ngữ

Quy ước:
- Cột "Dùng trong đề" là đúng chữ cần viết, viết thường như sách (trừ đầu câu). Thuật ngữ giữ tiếng Anh thì giải nghĩa tiếng Việt ở lần đầu trong mỗi câu hỏi, ví dụ "fill rate (tỷ lệ lấp đầy)".
- Tên bảng, cột viết đúng như DB, trong LaTeX đặt trong `\code{}`; giá trị chuỗi trong nháy đơn: `\code{'Pass'}`, `\code{'kho vệ tinh'}`.
- Tên cột kết quả (alias) viết tiếng Việt không dấu, theo đúng thuật ngữ ở cột "Dùng": `so_nganh_hang`, `bien_ln_gop_pct`, `luot_gd`, `ty_le_thieu_hut_pct`, `so_ngay_ton_kho` (SG H.7).

### A.1 Chuỗi cung ứng, tồn kho và mua hàng

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú giáo trình | Nguồn |
|---|---|---|---|---|
| supply chain; SCM | chuỗi cung ứng; quản trị chuỗi cung ứng | chuỗi cung cấp | TDMU, LCB dùng cùng từ | S 667; TDMU |
| logistics | logistics (giữ nguyên) | hậu cần | LCB, ĐTHV, BCT22 đều giữ "logistics" | S 1643; LCB; BCT22 |
| inventory (khái niệm chung) | tồn kho; hàng tồn kho | dự trữ (chỉ ghi chú khi giải nghĩa) | Giáo trình logistics gọi là "dự trữ", "quản trị dự trữ" (LCB, ĐTHV, TMU); TDMU dùng "tồn kho". Giữ "tồn kho" | S 712, 825; LCB; ĐTHV; TMU; TDMU |
| `on_hand_begin`, `on_hand_end` | tồn đầu kỳ, tồn cuối kỳ | "số dư", tồn đầu/tồn cuối đứng trơ không có "kỳ" | LCB: "tồn kho đầu kỳ", "số tồn kho cuối kỳ" (khớp) | S 6619, 6623; LCB; DB |
| `received`; `sold` | nhập trong kỳ; lượng bán trong kỳ (lượng bán đã ghi nhận); "lượng bán dùng làm thước đo nhu cầu" khi cần | "nhu cầu thật", "cầu thật" cho `sold`; `sold` − `thieu_hut` làm lượng bán | Giáo trình phân biệt nhu cầu với lượng bán; ở bộ dữ liệu `sold` là lượng bán | S 6621, 3633–3644; SG H.3 |
| `thieu_hut` | lượng thiếu hụt; dòng thiếu hụt; tỷ lệ dòng thiếu hụt | tỷ lệ thiếu hàng, tỷ lệ hết hàng | TDMU dùng "thiếu hụt" theo nghĩa chung | S 3919, 3966; SG H.3 |
| stockout | hết hàng | thủng hàng, kệ trống, cháy hàng | LCB, TDMU cùng dùng "hết hàng" | S 710; LCB; TDMU |
| understock / overstock / adequate | thiếu hàng / dư hàng / đủ hàng (ba trạng thái theo số ngày phủ); tồn kho dư thừa, đọng vốn | ứ hàng, ôm hàng; "thiếu hàng" cho dòng có `thieu_hut` > 0 | | S 6625, 712, 1009 |
| inventory value (`inventory_value`) | vốn tồn kho; vốn tồn | "giam vốn"; giá trị tồn khi đang nói về vốn | TDMU: "giá trị hàng tồn kho". Trong DB `inventory_value` = `on_hand_end` × `item_costs.unit_cost` | S 6629; TDMU; DB |
| average inventory | tồn kho bình quân | dự trữ bình quân | LCB, ĐTHV: "dự trữ bình quân"; TDMU: "tồn kho bình quân" | S 830; LCB; TDMU |
| inventory turnover (`itr`) | vòng quay tồn kho | ITR trong văn; "chi phí bán hàng" để chỉ giá vốn | TDMU: "vòng quay tồn kho" nhưng tử số ghi "chi phí bán hàng hàng năm"; kế toán – tài chính: "số vòng quay hàng tồn kho". Trong kế toán VN "chi phí bán hàng" là khoản khác giá vốn, nên không dùng | S 825; TDMU; MISA-VQ |
| DSI / DIO (`dio`) | số ngày tồn kho (DSI) | DIO trong văn; "số ngày nằm kho" | TDMU: "số ngày tồn kho"; kế toán – tài chính: "số ngày một vòng quay hàng tồn kho" | S 848; SG H.4; TDMU; MISA-VQ |
| days of supply; stock-to-sales ratio | số ngày phủ; tỷ số tồn trên bán | ngày phủ, mức phủ, số ngày đủ bán | Không thấy trong các giáo trình đã mở | S 993, 6623, 6628 |
| safety stock (SS) | tồn kho an toàn (SS) | safety stock trong văn; "phần đệm" | LCB, ĐTHV: "dự trữ bảo hiểm"; TDMU: "tồn kho an toàn" (khớp sách) | S 1345; TDMU; LCB; ĐTHV |
| reorder point (ROP) | điểm đặt hàng lại (ROP) | điểm tái đặt hàng | TDMU: "điểm đặt hàng lại" (khớp) | S 1359; TDMU |
| EOQ; ordering / holding cost; cycle stock | lượng đặt hàng kinh tế (EOQ); chi phí đặt hàng; chi phí lưu kho; tồn kho chu kỳ | lượng đặt hàng tối ưu | TDMU: "Lượng đặt hàng kinh tế cơ bản (EOQ)", "tồn kho theo chu kỳ"; TDMU, LCB: "chi phí dự trữ" | S 1368; TDMU; LCB |
| service level; z | mức độ phục vụ; hệ số z | mức phục vụ; service level trong văn | LCB: "trình độ dịch vụ khách hàng"; TDMU: "mức dịch vụ", "mức độ phục vụ khách hàng" | S 1347; LCB; TDMU |
| lead time (NCC); `promised_lead_days` | lead time; lead time cam kết; lead time thực tế; chênh lead time | "giữ lời"; "thời gian chờ" làm tên chỉ số | TDMU: "thời gian chờ hàng" (ký hiệu LT), "tốc độ cung ứng (Lead time)"; LCB: "chu trình đặt hàng". Giữ "lead time"; lần đầu giải nghĩa "lead time (thời gian từ khi đặt hàng tới khi nhận hàng)" | S 702, 953; TDMU; LCB |
| supplier (`suppliers`, `supplier_id`) | nhà cung cấp (NCC) | nhà cung ứng | TDMU, LCB dùng song song "nhà cung ứng" | S 6610; TDMU; LCB |
| supplier score; supplier tier | điểm NCC; hạng NCC Gold / Silver / Bronze | supplier scorecard; mức tier | | S 6610, 6613 |
| PO (`purchase_orders`, `po_id`) | đơn mua (PO); lần đầu có thể viết "đơn đặt hàng (PO)" | lô hàng (PO); đơn mua hàng | TDMU, LCB, ĐTHV: "đơn đặt hàng" | S 706; TDMU; LCB |
| purchasing / procurement | mua hàng; phòng mua hàng; nhân viên mua hàng | thu mua (trừ "giá thu mua" nông sản) | Giáo trình dùng cả "thu mua" và "mua hàng" (LCB: 35 / 14 lần) | LCB; TDMU; ĐTHV |
| `po_date`, `promised_date`, `received_date` | ngày đặt; ngày hẹn giao; ngày nhận hàng; đơn chưa về (`received_date` trống) | đơn treo | | S 951, 6616; DB |
| supplier on-time delivery | tỷ lệ giao đúng hạn (OTD) của NCC: đơn về không muộn hơn ngày hẹn chia số đơn đã về | | TDMU: "giao hàng đúng hạn" | S 935, 951, 6626; TDMU |
| defect rate (`defect_rate`, `qty_defect`); AQL | tỷ lệ hàng lỗi (tính trên số lượng nhận); AQL (mức chất lượng chấp nhận), ngưỡng 2% hàng lỗi | "lỗi theo khối lượng"; "ngưỡng Fail" | | S 969, 6603, 6627 |
| inspection (`inspection_result`) | kiểm định chất lượng khi nhận hàng; lô đạt ('Pass') / lô trượt ('Fail') / đơn chưa về ('Pending') | lô Fail, PO bị Fail | LCB: "kiểm tra chất lượng" | S 6616, 5521; LCB; DB |
| fill rate | fill rate (tỷ lệ lấp đầy) | "tỷ lệ đáp ứng đơn hàng" làm tên chỉ số | TDMU: "Tỷ lệ đầy đủ hàng hóa (Fill Rate)". Sách dùng fill rate cho lượng (S 745) và cho đơn đủ hàng (S 1850); bộ câu theo S 745 và SG H.3 | S 745, 1850; TDMU; SG H.3 |
| OTIF | OTIF (giao đúng hạn và đủ hàng) | | TDMU: "giao hàng đúng hạn và đầy đủ" | S 728, 1838; TDMU |
| bullwhip effect | bullwhip; lần đầu "bullwhip (dao động lượng nhập lớn hơn dao động lượng bán)" | hiệu ứng roi da (chỉ để trong ngoặc) | TDMU: "Hiệu ứng Bullwhip (Hiệu ứng cái roi da)" | S 6605; TDMU; MISA-BW |
| demand; demand forecast | nhu cầu; dự báo nhu cầu; tốc độ bán dự báo | "cầu" đứng một mình (chỉ giữ trong "cung – cầu") | TDMU, LCB: "dự báo nhu cầu" (khớp) | S 993, 6623; TDMU; LCB |
| forecast accuracy / error; MAPE; WMAPE | độ chính xác dự báo; sai số dự báo; MAPE; WMAPE | | TDMU: "sai số dự báo" | S 757; TDMU |
| forecast bias; naive / seasonal naive | bias dự báo (lệch cao hay lệch thấp), giải nghĩa lần đầu; dự báo bằng tháng liền trước / bằng cùng kỳ năm trước | naive trong văn | Không thấy trong giáo trình đã mở | SG A.1, H.5 |
| ABC class | hạng ABC; hạng A, B, C; phân tích ABC | nhóm A, nhóm C | LCB: "Phân tích ABC / Luật Pareto"; giáo trình và S 1172 gọi "nhóm A". Đề dùng "hạng" theo bảng thuật ngữ S 6612 | S 1172, 6612; LCB |
| XYZ; CV | phân loại XYZ; hệ số biến thiên (CV) | | | S 1186 |
| family | ngành hàng (tên ngành giữ tiếng Anh in hoa: FROZEN FOODS) | nhóm hàng | BCT22 dùng lẫn "ngành hàng", "nhóm hàng" | S 6620 |
| `class` (`items`) | lớp hàng (`class`) | "class" trơ trong văn | | S 2615 |
| perishable (`perishable` = 1 / 0) | hàng tươi sống / hàng khô | hàng dễ hỏng, hàng tươi | Chú giải cột của sách (S 2616) còn ghi "hàng dễ hỏng"; theo quyết định SG H.2 | S 6611; SG H.2 |
| SKU, `item_nbr` | mã hàng (SKU); "mặt hàng" chỉ khi nói hàng hoá chung | phần tử; "sản phẩm" cho một `item_nbr` | TDMU: "Đơn vị tồn trữ - SKU" | S 700; TDMU |
| transfer; allocation gap | lượng cần điều chuyển; chênh lệch chuẩn hoá; chỉ số phân bổ tồn kho; cơ hội giải phóng vốn | | | S 1017, 6606–6608, 6619 |
| period (`ym`); complete month; load window; annualization | kỳ (một kỳ là một tháng), "tháng 7/2017", "kỳ 2017-07"; tháng đủ; cửa sổ nạp; hệ số quy năm | "tháng thiếu" | DB: `inventory_snapshots` có cả kỳ 2017-08 (chỉ 15 ngày) | S 6614, 6615, 6624; DB |
| C2C | chu kỳ chuyển đổi tiền mặt (C2C) | | TDMU: "vòng quay tiền mặt" | S 868; TDMU |

### A.2 Bán hàng, cửa hàng và tài chính

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú giáo trình | Nguồn |
|---|---|---|---|---|
| store (`stores`, `store_nbr`) | cửa hàng; "cửa hàng 44" | điểm bán (trừ khi nói chung về kênh bán lẻ) | LCB, TDMU dùng cả "điểm bán" | S 2553 |
| store type (`type`, A–E) | loại cửa hàng (loại A … loại E) | định dạng cửa hàng, store format, "type A" | | S 2553, 4958 |
| `cluster`; region, `state`, `city` | cụm cửa hàng; miền; tỉnh, thành; thành phố | | | S 2554, 2555 |
| sales (`unit_sales`); return line | lượng bán (đơn vị); dòng trả hàng (`unit_sales` < 0) | hàng hoàn (cho kênh cửa hàng) | | S 3758; SG F5 |
| revenue | doanh thu | doanh số khi nói tiền | TDMU dùng "doanh số" (32 lần) song song "doanh thu" | S 4728; TDMU |
| COGS | giá vốn hàng bán (COGS); giá vốn | chi phí bán hàng | Kế toán VN: "giá vốn hàng bán" | S 704 |
| gross profit; gross margin (`margin_pct`) | lợi nhuận gộp; biên lợi nhuận gộp | lãi gộp, lãi, biên lãi gộp, biên gộp, "biên mỏng" | | S 6604, 6617; DB |
| `unit_price`, `unit_cost` | giá bán đơn vị; giá vốn đơn vị (giá cố định ở `item_costs`, giá theo tháng ở `item_costs_monthly`) | đơn giá vốn | | S 2617–2618; DB |
| GMROI | GMROI (lợi nhuận gộp trên vốn tồn) | | | S 909, 6618 |
| `transactions` | lượt giao dịch; "đông khách / vắng khách" khi nói chung | traffic, lượt khách làm tên chỉ số | | S 3888; SG H.5 |
| basket value; assortment | giá trị giỏ hàng (doanh thu / số giao dịch); số mã hàng có bán | basket size; độ rộng danh mục | | S 3809, 6725 |
| dead / slow SKU | mã không bán được ở cửa hàng nào; mã bán chậm | mã chết, hàng đứng | | S 5170, 5732 |
| like-for-like; MoM / YoY | tăng trưởng cùng cửa hàng (like-for-like); so kỳ trước / so cùng kỳ | MoM, YoY trong văn | | S 3838, 4745, 4871 |
| seasonality index; weekly pattern | chỉ số mùa vụ; nhịp tuần | chỉ số thứ | | S 3879, 3888 |
| promotion (`onpromotion`); promo lift | khuyến mãi; mức tăng lượng bán khi khuyến mãi (lift) | khuyến mãi kéo cầu; promo lift | TDMU, LCB dùng cả "khuyến mại" (từ của luật thương mại). Giữ "khuyến mãi" theo sách | S 2008, 3433; TDMU |
| holidays (`transferred`); oil (`dcoilwtico`) | ngày lễ; lễ bị dời; ngày nghỉ bù; giá dầu WTI | | | DB |
| revenue per m²; `rent_month_usd` | doanh thu trên m²; tiền thuê mặt bằng | gánh nặng thuê | | S 4748 |
| simulated data | dữ liệu mô phỏng; bộ sinh dữ liệu; giả định dựng sẵn | dữ liệu sinh, "được cài sẵn" | | S 6648, 6663 |

### A.3 Phân phối và giao hàng chặng cuối

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú giáo trình | Nguồn |
|---|---|---|---|---|
| DC (`warehouses`, `warehouse_id`) | trung tâm phân phối (DC) ở lần đầu, sau đó DC | kho tổng, DC mẹ | BCT17, BCT22, LCB, TDMU: "trung tâm phân phối" (khớp) | S 708; BCT17; BCT22 |
| warehouse (chung) | kho; kho hàng | kho bãi (chỉ khi nói hạ tầng) | LCB: "kho hàng"; BCT22: "kho bãi" cho hạ tầng ngành | LCB; BCT22 |
| shipment (`shipments`) | chuyến giao; lượt giao | chuyến hàng; lô hàng | Sách Mục II gọi shipment là "lô/kiện hàng" (S 1721); bộ câu theo bảng thuật ngữ | S 1721, 4161, 6626 |
| `on_time`; `in_full` | tỷ lệ giao đúng hạn (on-time); tỷ lệ đủ hàng; chuyến giao thiếu hàng | "vế on-time", đủ số, giao thiếu số | | S 4188, 6626; DB |
| distance (`km_to_dc`, `km_supplier_to_dc`) | quãng đường; quãng đường bình quân; khoảng cách | bán kính | | S 4159 |
| center of gravity | phương pháp trọng tâm (center of gravity); toạ độ trọng tâm | | Không thấy trong giáo trình đã mở | SG A.2 |
| sorting hub (`sorting_hubs`, `hub_id`) | kho (trung tâm phân loại) | hub; "trung tâm chia chọn" chỉ để ghi chú | BCT22: "trung tâm chia chọn (sortation center)"; sách Mục II: "trung tâm phân loại" | S 1723, 4229; BCT22 |
| main / satellite hub (`role`); `origin_hub_id`, `dest_hub_id` | kho chính / kho vệ tinh; kho xuất / kho đích | DC chính, hub vệ tinh, hub đích, hub gốc | DB: `role` = 'kho chính', 'kho vệ tinh' | S 4417, 6638; DB |
| bottleneck hub | kho nghẽn; điểm nghẽn | nút thắt, nút cổ chai | BCT22: "tắc nghẽn" (hạ tầng) | S 1646, 6639 |
| last mile | chặng cuối; giao hàng chặng cuối | last-mile, final mile, dặm cuối, "khâu cuối" | BCT22: "giao hàng chặng cuối (last-mile delivery)"; LCB khớp | S 1655, 5888; BCT22; LCB |
| first mile / middle mile | chặng đầu / middle mile (t3a di chuyển + t3b phân loại) | | BCT22: "chặng đầu (first mile)" | S 1646, 6640; BCT22 |
| order lead time (`lead_time_total_h`) | lead time của đơn (giờ), từ lúc tạo đơn tới lúc giao thành công | | Sách Mục II: "Lead time (thời gian giao trọn khâu)"; DB: bằng `delivered_at` − `created_at` | S 1743; DB |
| lead time components; năm cột `t1_…` tới `t4_…` | bốn thành phần lead time (t1, t2, middle mile, t4); "năm cột chặng"; chặng | trộn "công đoạn", "khâu", "chặng" trong một câu | | S 4328, 6633 |
| `t3b_sorting_h` | thời gian phân loại | giờ sorting | Sách Mục II: "thời gian xử lý (handling time)" | S 1747, 5894 |
| lead time − tổng năm cột chặng | thời gian chưa gán (cho chặng nào) | thời gian chờ giữa các khâu, giờ chờ | | S 4328, 4366; SG H.5 |
| cut-off time; EDD | giờ chốt đơn; ngày giao dự kiến (EDD) | | | S 1735, 1749 |
| `promised_h`, `promised_days` | cam kết (giờ, ngày); mức cam kết | mức hứa | | S 4372 |
| event day (`event_calendar`); `tier` | ngày cao điểm; quy mô sự kiện: nhỏ, vừa, lớn và ngày lễ | ngày sale, đợt sale, "tier" trong văn | DB: `tier` = nho, vua, lon, le | S 4386, 6642; DB |
| baseline day; baseline; alert margin; `demand_multiplier` | ngày nền, ngày thường; baseline (mức nền); biên cảnh báo; hệ số nhu cầu | ngày sạch; hệ số cầu | | S 6631, 6632, 6637, 6643 |
| workload ratio (`workload_ratio`) | tỷ lệ tải (workload ratio) | hệ số tải | Sách Mục II: "Capacity Utilization" (khối lượng cần xử lý / năng lực); LCB: "hệ số sử dụng" (công suất) | S 1851, 4462, 6645; LCB |
| daily capacity | năng lực ngày | công suất (cho kho phân loại) | LCB, BCT22 dùng "công suất" cho thiết bị, hạ tầng | S 6641 |
| `orders_to_process`; orders per head | đơn cần xử lý; đơn cần xử lý trên đầu người | | | S 6634 |
| backlog (`backlog_dau_ngay`, `backlog_cuoi_ngay`) | đơn tồn đọng (backlog); đơn tồn đầu ngày / cuối ngày | "rã tồn", "tồn đọng đỉnh" | Sách Mục II: "Backlog / Aging (đơn tồn)" | S 1847, 4265 |
| `headcount`, `headcount_thuc_te`, `headcount_ke_hoach` | nhân sự có mặt (headcount); nhân sự kế hoạch; "định biên" chỉ khi nói chính sách nhân sự | quân số | | S 4293, 6313, 6636 |
| cancel rate (`is_cancelled`); GMV | tỷ lệ huỷ; GMV (tổng giá trị đơn hoàn tất) | | | S 1853, 6635, 6644 |
| voucher, `checkout_group`; A/B test; conversion | voucher (phiếu giảm giá); nhóm khách tự áp mã ('manual') / nhóm hệ thống tự động áp mã ('auto_apply') (theo sách dự án, S 4556; sửa lúc 23:45); thử nghiệm A/B; tỷ lệ chuyển đổi | | | S 2008, 2009, 4556; DB |
| delivery point (`delivery_points`); milk-run | điểm giao; gom tuyến (milk-run) | | | S 2709, 4227 |
| 3PL | doanh nghiệp logistics bên thứ ba (3PL) | | BCT22: "dịch vụ logistics của bên thứ 3" | S 1727; BCT22 |

### A.4 Thống kê

| Tiếng Anh | Dùng trong đề | Không dùng | Ghi chú giáo trình | Nguồn |
|---|---|---|---|---|
| percentage point | điểm phần trăm | "điểm" đứng một mình; pp | | S 6647 |
| percentile; median; P95 | phân vị; phân vị 95 (P95); trung vị; phân vị nội suy | percentile, "phần đuôi" | MySQL 8.0 không có `PERCENTILE_CONT`; câu cần phân vị phải ghi rõ cách lấy (ví dụ "giá trị nhỏ nhất có thứ hạng phần trăm từ 95% trở lên") | S 4070, 6650; QC |
| weighted average; rolling median / average | trung bình có trọng số; trung vị trượt / trung bình trượt | bình quân gia quyền; moving average | | S 6651, 6652 |
| correlation; confidence interval | hệ số tương quan (Pearson r); khoảng tin cậy 95% | | | S 6649 |
| Simpson's paradox; root cause analysis | nghịch lý Simpson; phân tích nguyên nhân gốc | | | S 4511, 6677 |

### A.5 Dữ liệu và SQL (chỉ dùng trong `yeucau`, `rangbuoc`, `\goiy`, `\luuy`, `\ghichuthietke`; KHÔNG dùng trong `\boicanh`)

| Tiếng Anh | Dùng trong đề | Không dùng | Ghi chú giáo trình | Nguồn |
|---|---|---|---|---|
| query; row / column / table; NULL | truy vấn, câu truy vấn; dòng / cột / bảng; NULL, ô trống | phần tử; bản ghi (chỉ chấp nhận trong "bản ghi trùng") | | S 3376; QC |
| WHERE; filter | lọc; điều kiện lọc | | | QC |
| GROUP BY; aggregate function; HAVING | gom nhóm (GROUP BY); hàm gộp; lọc nhóm (HAVING) | | VBL: "hàm tổng hợp" | QC; VBL |
| JOIN; LEFT JOIN | nối bảng, phép nối; giữ nguyên INNER JOIN, LEFT JOIN | "ghép kiểu INNER JOIN" | Giáo trình CSDL tiếng Việt quen gọi "phép kết nối"; chưa mở được giáo trình nào để kiểm | QC; S 4293 |
| fan-out | nhân dòng khi nối (fan-out) | | | QC (`fan-out`) |
| anti-join | tìm dòng không có cặp (anti-join); NOT EXISTS | | | VBL |
| subquery; correlated subquery; derived table | truy vấn con; truy vấn con tương quan; bảng dẫn xuất (truy vấn con đặt trong FROM) | subquery trong văn | DCV: "truy vấn con", "subquery tương quan" | DCV; SG A.5 |
| CTE | CTE (bảng tạm đặt tên bằng WITH) | "biểu thức bảng chung" (theo SG A.5; xem mục F.1) | Microsoft Learn chỉ có bản tiếng Anh cho trang WITH | SG A.5 |
| window function; PARTITION BY | hàm cửa sổ (window function); chia nhóm trong hàm cửa sổ (PARTITION BY) | | | MSL |
| ranking; tie | xếp hạng; bằng nhau; tiêu chí phụ khi bằng nhau | trùng hạng (chỉ dùng trong tên bẫy `bay=`) | QC dùng "Hai sản phẩm bằng doanh thu thì …" | QC |
| running total | luỹ kế; cộng dồn | | | QC (`o4`) |
| index; table scan; intermediate rows; execution plan | chỉ mục; lần quét bảng; dòng trung gian; kế hoạch chạy (`EXPLAIN ANALYZE`) | | | QC (`lan-quet-bang`, `dong-trung-gian`) |
| partition (PostgreSQL) | phân vùng | "bảng được chia nhỏ" | Bảng `sales` chia theo năm | S 6678 |
| dimension / fact table; Power BI terms; insight | bảng chiều / bảng sự kiện; measure, DAX, slicer, visual giữ tiếng Anh; "phát hiện" hoặc nói thẳng kết quả | insight trong văn đề | Ít dùng trong leaderboard SQL | S 6655–6686; SG A.5 |

---

## B. Giọng văn cho từng phần của câu hỏi

Nguyên tắc chung (kế thừa SG C.1):
1. Câu ngắn, một ý một câu. Câu dài nhất là câu nêu điều kiện dữ liệu.
2. Mỗi câu hỏi dùng một bộ từ thống nhất từ tiêu đề tới phương án kết luận (một chặng không lúc là "khâu", lúc là "công đoạn").
3. Số: phẩy thập phân, chấm hàng nghìn (8,03%; 2.389 đơn); hiệu hai tỷ lệ là "điểm phần trăm"; "x trên y" thay "x/y". Trong LaTeX viết `\%`.
4. Ngày tháng: "tháng 7/2017", "ngày 11/11/2016", "kỳ 2017-07", "năm 2016"; giá trị lọc trong `\code{}` giữ đúng dạng DB (`\code{'2017-07-01'}`).
5. Chính tả: "tỷ lệ", "huỷ" (S 6644). Các chữ -oa/-oe chọn một kiểu cho cả câu (khuyến nghị "hoá", "hoà" như QC).
6. Không nhắc "bài giảng", "lab", "sách", "dashboard B" trong đề.

### B.1 Tiêu đề (`\tieude`)

Quy tắc
- Câu hỏi nghiệp vụ ngắn hoặc cụm danh từ như tiêu đề mục của sách. Tối đa 10 tiếng; mốc thời gian tính vào số tiếng.
- Câu Viết truy vấn và Case study: câu hỏi kinh doanh ("Nhà cung cấp nào …?", "Vì sao …?").
- Câu Sửa lỗi: nêu triệu chứng người hỏi thấy ("… ra 0", "… cao bất thường"), như `d1`, `d2` của QC.
- Câu Tối ưu: nêu việc cần giữ và ràng buộc ("… chỉ với một lần quét"); đây là loại duy nhất được nhắc kỹ thuật trong tiêu đề.
- Không dấu hai chấm, không hai vế "… bao nhiêu, … bao nhiêu?", không "sale", "hub", "last-mile", "định dạng".

Ví dụ đạt
- `\tieude{Nhà cung cấp nào giao trễ nhiều nhất năm 2016?}` (Viết · Dễ)
- `\tieude{Tỷ lệ hàng lỗi theo nhà cung cấp cao bất thường}` (Sửa lỗi · Dễ)
- `\tieude{Vốn tồn theo ngành hàng chỉ với một lần quét}` (Tối ưu · Cơ bản)
- `\tieude{Vì sao lead time tăng vào ngày cao điểm?}` (Case · Khó)

### B.2 Bối cảnh (`\boicanh[Người · Vai trò]{Lời nhắn}`)

Quy tắc
- Một người hỏi, tên Việt thông dụng, vai trò có thật trong công ty bán lẻ hoặc logistics: Trưởng phòng mua hàng, Nhân viên mua hàng, Nhân viên kế hoạch nhu cầu, Trưởng ngành hàng, Quản lý vùng, Quản lý cửa hàng, Trưởng kho, Điều phối vận hành, Kế toán quản trị, Giám đốc tài chính, Giám đốc chuỗi cung ứng; Data engineer cho câu Tối ưu; Thực tập sinh cho câu Sửa lỗi cấp thấp.
- Xưng hô đúng vai: người hỏi cấp trên xưng "anh/chị", gọi học viên là "em"; thực tập sinh xưng "em", gọi "anh chị". Dùng "mình" khi nói về công ty ("kho mình", "năm nay mình"). Không dùng "bạn", "quý vị", "ạ" lặp.
- Một tới hai câu, tối đa khoảng 35 tiếng. Câu đầu nêu việc kinh doanh đang xảy ra hoặc cuộc họp sắp tới; câu sau nêu điều cần biết. Lời nhắn là lời nói công sở tự nhiên, câu đủ chủ vị, không khẩu hiệu.
- Không nhắc tên kỹ thuật SQL, tên bảng, tên cột (QC mục 3, 10). Với câu Tối ưu, Data engineer chỉ nói triệu chứng ("chạy rất lâu", "đọc bảng tồn kho tới ba lần"), không gọi tên cú pháp.
- Không đặt sẵn đáp án hoặc gợi ý cách làm trong lời nhắn.

Ví dụ đạt
- `\boicanh[Chị Hằng · Trưởng phòng mua hàng]{Cuối quý chị họp đánh giá nhà cung cấp. Em xem giúp chị năm 2016 nhà cung cấp nào giao trễ nhiều nhất.}`
- `\boicanh[Anh Phúc · Trưởng kho Hà Nội]{Đợt 11/11 năm ngoái kho mình xử lý không kịp. Anh cần biết đơn tồn đọng dồn cao nhất vào ngày nào để xếp ca cho năm nay.}`
- `\boicanh[Bạn Vy · Thực tập sinh]{Em tính tỷ lệ hàng lỗi của từng nhà cung cấp mà ra cao gần gấp đôi số trên dashboard. Anh chị xem giúp em sai ở đâu.}`

### B.3 Yêu cầu (`yeucau`, `rangbuoc`)

Quy tắc
- Mỗi `\item` là một mệnh lệnh, mở bằng động từ: Tính, Đếm, Liệt kê, Xếp hạng, Trả về, Sắp, Sửa, Giữ nguyên. Không mở bằng "Hãy", "Với mỗi", "Bạn cần".
- Thứ tự các `\item`: (1) phạm vi dữ liệu (kỳ, điều kiện lọc); (2) chỉ số và cách tính, dẫn chiếu "theo tab Nghiệp vụ" nếu đã có khái niệm; (3) cột trả về đúng thứ tự, kèm đơn vị và làm tròn; (4) thứ tự sắp; (5) quy tắc khi bằng nhau.
- Đơn vị và làm tròn viết trong ngoặc ngay sau tên cột: "`\code{ty_le_tre_pct}` (phần trăm, làm tròn 2 chữ số)", "`\code{lead_time_tb}` (ngày, 1 chữ số)".
- Quy tắc bằng nhau luôn nêu bằng khoá: "Hai nhà cung cấp bằng nhau thì `\code{supplier_id}` nhỏ hơn đứng trước."
- Mốc thời gian: "năm 2016", "từ tháng 1/2016 tới hết tháng 6/2016"; khi cần chính xác thì ghi khoảng nửa mở bằng giá trị DB.
- Mức chỉ dẫn theo cấp (QC mục 6): Cơ bản và Dễ ghi rõ cột và giá trị lọc; Trung bình nêu chỉ số bằng tên nghiệp vụ, cột có thể nêu một phần; Khó chỉ dùng ngôn ngữ kinh doanh và tab Nghiệp vụ.
- Không giải thích lý do trong yêu cầu (lý do để ở bối cảnh hoặc tab Nghiệp vụ). `rangbuoc` viết lại ràng buộc máy chấm bằng lời: "Bảng `\code{inventory_snapshots}` chỉ được quét 1 lần."

Ví dụ đạt
```latex
\begin{yeucau}
  \item Xét các đơn mua đặt trong năm 2016 và đã về kho (\code{received_date} không trống).
  \item Tính cho từng nhà cung cấp tỷ lệ giao trễ, theo tab Nghiệp vụ.
  \item Trả về \code{supplier_id}, \code{so_don}, \code{ty_le_tre_pct} (phần trăm, làm tròn 2 chữ số).
  \item Sắp \code{ty_le_tre_pct} giảm dần; bằng nhau thì \code{supplier_id} nhỏ hơn đứng trước.
\end{yeucau}
```
```latex
\begin{yeucau}
  \item Giữ nguyên kết quả: vốn tồn cuối kỳ 2017-07 theo ngành hàng, gồm \code{family}, \code{von_ton} (làm tròn 0 chữ số).
  \item Sắp \code{von_ton} giảm dần.
\end{yeucau}
\begin{rangbuoc}
  \item Bảng \code{inventory_snapshots} chỉ được quét 1 lần.
\end{rangbuoc}
```

### B.4 Tab Nghiệp vụ (`nghiepvu`)

Quy tắc
- Dòng mở `\begin{nghiepvu}{…}` trả lời "câu này giúp quyết định gì": một câu ngắn, mở bằng động từ, nêu quyết định có thật và đúng người có quyền quyết (SG H.8). Ví dụ "Chọn nhà cung cấp cần nhắc nhở hoặc giảm tỷ trọng đơn mua."
- `\quytrinh` tối đa một, ví dụ vòng đời đơn mua (đặt hàng, hàng về, kiểm định; nhánh: chưa về) hoặc hành trình đơn chặng cuối (tạo đơn, lấy hàng, xuất kho, phân loại, giao).
- `\khainiem` dùng mã đã khai báo ở mục E; không định nghĩa lại trong `\luuy`.
- `\luuy` một tới hai câu, nêu hiểu lầm hay gặp. Viết như giáo trình: định nghĩa trước, cách tính sau, điều kiện dữ liệu cuối. Không lộ con số của kết quả (QC mục 4), không "Lưu ý quan trọng:", không câu dạy đời.

Ví dụ đạt
```latex
\begin{nghiepvu}{Chọn nhà cung cấp cần nhắc nhở hoặc giảm tỷ trọng đơn mua.}
  \quytrinh{Vòng đời đơn mua}{đặt hàng, hàng về, kiểm định}{chưa về}
  \khainiem{otd-ncc}
  \luuy{Đơn chưa về không có ngày nhận nên chưa xác định được trễ hay đúng hạn. Mẫu số chỉ gồm đơn đã về.}
\end{nghiepvu}
```
```latex
\begin{nghiepvu}{Quyết định tăng ca hay chuyển bớt đơn sang kho khác trong dịp cao điểm.}
  \khainiem{ty-le-tai}
  \khainiem{don-ton-dong}
  \luuy{Tỷ lệ tải đo trên năng lực của nhân sự có mặt, không phải nhân sự kế hoạch. Ngày vắng người có thể quá tải dù số đơn không tăng.}
\end{nghiepvu}
```

### B.5 Gợi ý (`\goiy`)

Quy tắc
- Mỗi nấc trừ 5 điểm, nên nấc đầu nhẹ, nấc sau cụ thể hơn. Tối đa 2 nấc ở câu và 1 nấc ở mỗi bước case (QC).
- Nấc 1: hướng nghĩ nghiệp vụ hoặc bẫy dữ liệu, viết thành câu hỏi gợi mở hoặc câu khẳng định ngắn.
- Nấc 2: kỹ thuật bằng lời; được dẫn một khung cú pháp ngắn trong `\code{}` (một dòng), không đưa cả truy vấn.
- Tên bảng, cột trong `\code{}`. Không "Hãy", không "Bạn nên".

Ví dụ đạt
- `\goiy{Đơn chưa về có \code{received_date} trống. Đơn như vậy có nên nằm trong mẫu số không?}`
- `\goiy{Tính số đơn và số đơn trễ của từng nhà cung cấp trong cùng một lần gom nhóm, bằng \code{COUNT(CASE WHEN received_date > promised_date THEN 1 END)}.}`

### B.6 Bước kết luận của case (`\phuongan`)

Quy tắc
- Ba phương án, một đúng. Mỗi phương án là một câu kết luận hoàn chỉnh như người phân tích nói trong cuộc họp, dài gần bằng nhau.
- Phương án sai phải là một lỗi lập luận mà người làm thật hay mắc: lấy số tuyệt đối thay tỷ lệ; quy nguyên nhân khi chỉ thấy tương quan; quên đơn chưa về hoặc đơn huỷ trong mẫu số; coi `sold` là nhu cầu; dùng tháng chưa đủ (2017-08); trình bày giả định dựng sẵn của bộ sinh dữ liệu như phát hiện; lấy thành phần dài nhất thay cho thành phần tăng nhiều nhất (S 6582).
- Không để dấu hiệu lộ đáp án: không chỉ phương án đúng mới có "cần thêm số liệu", không chỉ phương án sai mới có "luôn", "chắc chắn".
- Lời giải thích: một tới hai câu, tối đa khoảng 30 tiếng, chỉ ra bước nào cho thấy điều gì. Phương án đúng mở bằng "Đúng." rồi nêu căn cứ; phương án sai nêu thẳng chỗ sai. Không dùng khuôn "Đúng: …", "Sai: …" (xem mục F.4).

Ví dụ đạt
```latex
\phuongan*{Kênh online giao nhanh hơn nhưng tỷ lệ giao đúng hạn thấp hơn kênh cửa hàng, vì cam kết của kênh online ngắn hơn nhiều.}
  {Đúng. Bước 1 cho thấy thời gian giao online ngắn hơn ở cả ba DC, bước 2 cho thấy thời gian dư so với cam kết của online ít hơn.}
\phuongan{Kênh cửa hàng vận hành tốt hơn kênh online vì có tỷ lệ giao đúng hạn cao hơn.}
  {Tỷ lệ đúng hạn phụ thuộc mức cam kết. Kênh cửa hàng giao chậm hơn nhưng có cam kết dài hơn.}
```
```latex
\phuongan{Chặng t4 dài nhất trong bốn thành phần nên là nơi ngày cao điểm làm đơn chậm thêm nhiều nhất.}
  {Thành phần dài nhất chưa chắc tăng nhiều nhất. Bước 3 cho thấy t4 gần như không đổi, còn middle mile tăng mạnh.}
```

### B.7 Khai báo khái niệm (`\khaibaokhainiem{ma}{Tên}{Định nghĩa}{Công thức}{Trong bộ dữ liệu}`)

Quy tắc
- Mã: chữ thường, không dấu, gạch ngang (`otif-chuyen-giao`). Kiểm mục E trước khi tạo mã mới.
- Tên: thuật ngữ ở mục A, kèm viết tắt trong ngoặc khi có: "Số ngày tồn kho (DSI)".
- Định nghĩa: một tới hai câu đủ chủ vị theo giọng giáo trình, mở bằng "X là …", "X phản ánh …", "X đo …". Không "chúng ta", không ví dụ số.
- Công thức: công thức nghiệp vụ "A / B" bằng chữ; được dùng tên cột khi cần chỉ đúng cột (theo mẫu `doanh-thu-gop` của QC, gạch dưới viết `\_`). Không chứa mẹo SQL. Để trống `{}` khi khái niệm không có công thức.
- Trong bộ dữ liệu: bảng, cột, giá trị, quy ước và bẫy, mở bằng chữ thường như QC. Không ghi số kết quả của câu nào.

Ví dụ đạt
```latex
\khaibaokhainiem{ty-le-hang-loi}{Tỷ lệ hàng lỗi}
  {Tỷ lệ hàng lỗi phản ánh phần hàng không đạt tiêu chuẩn chất lượng tại thời điểm nhận hàng.}
  {tổng qty\_defect / tổng qty\_received của các đơn mua đã về}
  {bảng \code{purchase_orders}; tỷ lệ của từng đơn có sẵn ở \code{defect_rate}. Tỷ lệ của một nhà cung cấp tính lại từ tổng số lượng, không lấy trung bình \code{defect_rate}.}
\khaibaokhainiem{so-ngay-phu}{Số ngày phủ}
  {Số ngày phủ là số ngày lượng tồn hiện có đáp ứng được lượng bán dự báo nếu không nhập thêm hàng.}
  {tồn cuối kỳ / tốc độ bán dự báo mỗi ngày}
  {\code{inventory_snapshots.on_hand_end}; tốc độ bán dự báo lấy bằng bình quân \code{sold} ba kỳ trước chia số ngày. Đây là chỉ số nhìn về phía trước, khác số ngày tồn kho.}
```

---

## C. Khuôn cấm

### C.1 Kế thừa nguyên văn từ SG mục C.2 và C.3

- Cụm cấm: "ứng viên", "cho ta", "mức tier", "phần tử", "So sánh có kiểm soát", "đóng vai trò quan trọng", "hãy cùng", "chìa khoá", "insight", "không chỉ… mà còn", "bức tranh", "đòn bẩy", "bỏ tiền qua cửa sổ", "khớp bài giảng", "Bài giảng đã chỉ ra", "Khuyến nghị:".
- Dấu gạch ngang dài "—" trong văn. Khuôn "mệnh đề: kết luận"; dấu hai chấm chỉ đứng trước danh sách cột hoặc danh sách điều kiện.
- Câu khẩu hiệu cuối đoạn. Ẩn dụ động từ: gánh, kéo, ăn vào lãi, giam vốn, ôm hàng, thủng hàng, hút khách, phình, nhích, tụt, rơi, chạm mốc, rã tồn, đỡ, cứu.
- Danh từ dịch máy: phần dự phòng, khoảng hở, phần đuôi, định dạng (cửa hàng), benchmark, scorecard, what-if, forward fill, final mile, traffic, hub đích, mã chết, hàng đứng, độ rộng danh mục, rủi ro tập trung, lập hồ sơ, giữ lời, soi riêng.
- Khuôn K1–K15 của SG C.3 (mở bằng "Với mỗi"; "Hãy"; "trong khi" quá một lần; ẩn dụ động từ; "X là …, chưa phải Y"; câu dạy đời "Muốn … thì phải …"; danh từ dịch máy; khái niệm mở bằng câu cụt; nhắc bài giảng; "cầu" đứng một mình; chuỗi "tức là / nên … nên"; tiếng Anh lẫn trong văn; ký hiệu thay chữ "5/54", "TB"; bị động "bị coi là" và đảo nhấn "mới biết"; thuật ngữ lệch sách). Ví dụ trước/sau xem SG C.3.

### C.2 Khuôn bổ sung cho đề thi tiếng Việt ("mùi AI" và dịch máy)

| # | Khuôn | TRƯỚC | SAU |
|---|---|---|---|
| K16 | Mở bối cảnh bằng câu sáo về thời đại | "Trong bối cảnh thương mại điện tử ngày càng phát triển mạnh mẽ, việc tối ưu hoá chuỗi cung ứng trở nên vô cùng cấp thiết." | "Đợt 11/11 năm ngoái kho mình xử lý không kịp." |
| K17 | Tự giới thiệu vai trò trong lời nhắn | "Với vai trò là Trưởng phòng mua hàng, chị muốn đánh giá các nhà cung cấp." | "Cuối quý chị họp đánh giá nhà cung cấp." (vai trò đã có trong ngoặc vuông) |
| K18 | Động từ rỗng "thực hiện / tiến hành" + danh từ | "Thực hiện việc tính toán tỷ lệ giao trễ và tiến hành sắp xếp kết quả." | "Tính tỷ lệ giao trễ. Sắp kết quả theo tỷ lệ giảm dần." |
| K19 | Bị động dịch từ tiếng Anh "được … bởi" | "Tỷ lệ tải được tính toán bởi số đơn cần xử lý chia cho năng lực." | "Tỷ lệ tải bằng đơn cần xử lý chia năng lực ngày." |
| K20 | "một cách + tính từ" | "giúp đánh giá nhà cung cấp một cách toàn diện và chính xác" | "giúp chọn nhà cung cấp cần nhắc nhở" |
| K21 | Từ nối liệt kê đầu mọi câu | "Đầu tiên, lọc năm 2016. Tiếp theo, nối hai bảng. Cuối cùng, sắp xếp." | Mỗi ý một `\item`, không từ nối. |
| K22 | Tiêu đề hỏi tu từ "Liệu … có thực sự …?" | "Liệu khuyến mãi có thực sự hiệu quả?" | "Khuyến mãi làm lượng bán tăng bao nhiêu?" |
| K23 | Tính từ khen chê không đo được | "nhà cung cấp có hiệu suất vượt trội", "kết quả rất ấn tượng" | "nhà cung cấp có tỷ lệ giao đúng hạn cao nhất" |
| K24 | Nhấn mạnh bằng chữ in hoa, chấm than, in đậm | "LƯU Ý: KHÔNG tính đơn huỷ!!!" | `\luuy{Đơn huỷ không vào mẫu số vì không được giao.}` |
| K25 | Lặp "các", "những" trước mọi danh từ | "Tính các tỷ lệ của các nhà cung cấp trong các tháng" | "Tính tỷ lệ của từng nhà cung cấp theo tháng" |
| K26 | Khuôn đề thi trường cũ, lộ kỹ thuật trong bối cảnh | "Cho bảng purchase_orders. Viết câu lệnh SQL để …" | Bối cảnh là lời nhắn của người hỏi; yêu cầu mới nói bảng, cột. |
| K27 | Liên từ chồng | "Vì vậy nên", "Do đó cho nên", "Tuy nhiên nhưng" | "Vì vậy", "Do đó", "Tuy nhiên" (một liên từ) |
| K28 | Hán Việt hoá thừa | "nhằm mục đích", "trên cơ sở đó", "đối với việc", "tiến hành triển khai" | "để", "từ đó", "khi", "làm" |
| K29 | Tiếng Anh văn phòng trong lời nhắn | "Em check giúp chị report này, fix trước deadline nhé." | "Em kiểm tra giúp chị báo cáo này, sửa xong trước thứ sáu nhé." ("dashboard" được giữ vì sách dùng) |
| K30 | Ngoặc kép rào đón quanh từ thường | "kho có hiệu quả "tốt" hơn" | "kho có tỷ lệ tải thấp hơn" |
| K31 | Đại từ "nó" chỉ dữ liệu, chỉ số | "Nó cho thấy kho Hà Nội quá tải." | "Tỷ lệ tải cho thấy kho Hà Nội quá tải." |
| K32 | Phương án kết luận lộ đáp án bằng độ dài hoặc từ rào | Phương án đúng dài gấp đôi, duy nhất có "cần thêm số liệu" | Ba phương án dài gần bằng nhau; từ rào xuất hiện ở cả phương án sai. |

---

## D. Mười câu mẫu trước / sau

Bốn câu đầu lấy từ `cau-hoi.tex` (chỉ minh hoạ cách sửa giọng; không sửa file mẫu). Sáu câu sau tự đặt trên dữ liệu Supply Chain.

| # | Phần | TRƯỚC | SAU | Lý do |
|---|---|---|---|---|
| 1 | nghiepvu (`c4`) | "Chọn hướng ưu tiên năm tới: kéo thêm traffic, tăng chuyển đổi hay giữ chân khách cũ." | "Chọn hướng ưu tiên năm tới, giữa tăng lượt truy cập, tăng tỷ lệ chuyển đổi và giữ chân khách cũ." | dấu hai chấm giữa câu; "kéo"; "traffic" |
| 2 | phuongan (`c4`) | "Số đơn giảm trong khi traffic còn tăng: khách mới giảm mạnh và khách mua ít đơn hơn. Ưu tiên tăng chuyển đổi và giữ chân, không phải kéo thêm traffic." | "Số đơn giảm dù lượt truy cập vẫn tăng. Khách mới giảm mạnh và khách cũ mua ít đơn hơn, nên cần ưu tiên tăng chuyển đổi và giữ chân khách." | hai chấm; khuôn "X, không phải Y"; ẩn dụ "kéo" |
| 3 | phuongan, giải thích (`c2`) | "Đúng: hai kỳ đều có khuyến mãi, so với nhau chỉ thấy tăng trưởng chung." | "Đúng. Hai kỳ đều có khuyến mãi nên so với nhau chỉ thấy mức tăng trưởng chung." | khuôn "Đúng:" |
| 4 | boicanh (`d4`) | "\boicanh[Chị Hoa · Growth]{Báo cáo retention quý 1/2022 cho thấy cohort nào cũng giữ chân 100\% khách sau 1 tháng. Không thể tốt vậy được.}" | "\boicanh[Chị Hoa · Trưởng nhóm tăng trưởng]{Báo cáo tỷ lệ giữ chân khách quý 1/2022 ghi nhóm khách nào cũng quay lại đủ 100\% sau một tháng. Chị thấy không thể tốt vậy được.}" | vai trò và thuật ngữ tiếng Anh; câu cụt không chủ ngữ |
| 5 | tieude | "Phân tích hiệu suất giao hàng của các nhà cung cấp trong năm 2016" | "Nhà cung cấp nào giao trễ nhiều nhất năm 2016?" | cụm dài 13 tiếng; "hiệu suất" không đo được; "các" thừa |
| 6 | boicanh | "\boicanh[Chị Hằng · Trưởng phòng mua hàng]{Với vai trò là trưởng phòng mua hàng, chị muốn em hãy viết truy vấn SQL để phân tích dữ liệu bảng purchase\_orders một cách toàn diện.}" | "\boicanh[Chị Hằng · Trưởng phòng mua hàng]{Cuối quý chị họp đánh giá nhà cung cấp. Em xem giúp chị năm 2016 nhà cung cấp nào giao trễ nhiều nhất.}" | K17, K2, K20, K26 |
| 7 | yeucau | "Với mỗi ngành hàng, hãy tính DIO và ITR của kỳ 2017-07, trong đó DIO thể hiện số ngày hàng nằm kho." | "\item Tính vòng quay tồn kho và số ngày tồn kho (DSI) của từng ngành hàng trong kỳ 2017-07, theo tab Nghiệp vụ." | K1, K2; DIO, ITR trong văn; giải thích lẫn vào yêu cầu |
| 8 | luuy | "Lưu ý quan trọng: cột sold chính là nhu cầu thật của khách hàng, đã trừ đi phần thiếu hụt." | "\luuy{\code{sold} là lượng bán trong kỳ, không phải nhu cầu. Lượng bán dùng làm thước đo nhu cầu khi dự báo.}" | sai ngữ nghĩa (SG H.3); "Lưu ý quan trọng:" |
| 9 | goiy | "Hãy nhớ rằng hub đích có thể bị nghẽn vào ngày sale nên giờ sorting sẽ tăng vọt." | "\goiy{So thời gian phân loại của từng kho đích giữa ngày cao điểm và ngày nền.}" | K2; hub, sale, sorting; ẩn dụ "tăng vọt"; lộ kết luận |
| 10 | khaibaokhainiem, định nghĩa | "Fill rate: chỉ số cực kỳ quan trọng đo lường khả năng đáp ứng nhu cầu một cách nhanh chóng của doanh nghiệp." | "Fill rate (tỷ lệ lấp đầy) phản ánh phần lượng bán được phục vụ trực tiếp từ hàng sẵn có trong kho." | khuôn "X: giải thích"; K20, K23; định nghĩa không khớp công thức |

---

## E. Khái niệm khai báo cho bộ Supply Chain

Cột "trong bộ dữ liệu" đã đối chiếu cấu trúc schema `scm` (DB, chỉ đọc, 10/11/2026). Các quan hệ giữa cột được kiểm bằng truy vấn và ghi ở `_nhap-scm/nguon-va-trich-dan.md`. Bảng tóm tắt trước, khối LaTeX để dán sau.

| # | Mã | Tên | Bảng chính | Nguồn định nghĩa |
|---|---|---|---|---|
| 1 | `ky-va-thang-du` | Kỳ và tháng đủ | `inventory_snapshots.ym` | S 6615, 6624 |
| 2 | `luong-ban-va-nhu-cau` | Lượng bán trong kỳ và nhu cầu | `inventory_snapshots` | S 3633–3644; SG H.3 |
| 3 | `fill-rate` | Fill rate (tỷ lệ lấp đầy) | `inventory_snapshots` | S 745; TDMU |
| 4 | `ty-le-dong-thieu-hut` | Tỷ lệ dòng thiếu hụt | `inventory_snapshots` | S 3919; SG H.3 |
| 5 | `von-ton-kho` | Vốn tồn kho | `inventory_snapshots`, `item_costs` | S 6629; DB |
| 6 | `vong-quay-ton-kho` | Vòng quay tồn kho | `inventory_snapshots`, `item_costs` | S 825; TDMU |
| 7 | `dsi` | Số ngày tồn kho (DSI) | như trên | S 848; TDMU |
| 8 | `so-ngay-phu` | Số ngày phủ | `inventory_snapshots` | S 993, 6623 |
| 9 | `bien-ln-gop` | Biên lợi nhuận gộp | `item_costs`, `item_costs_monthly` | S 6604, 6617 |
| 10 | `gmroi` | GMROI | `inventory_snapshots`, `item_costs` | S 909, 6618 |
| 11 | `hang-abc` | Hạng ABC | `inventory_snapshots` hoặc `sales`, `item_costs` | S 1172, 6612; LCB |
| 12 | `phan-loai-xyz` | Phân loại XYZ | `inventory_snapshots` | S 1186 |
| 13 | `ton-kho-an-toan` | Tồn kho an toàn (SS) | `purchase_orders`, `inventory_snapshots` | S 1345; TDMU |
| 14 | `rop` | Điểm đặt hàng lại (ROP) | như trên | S 1359; TDMU |
| 15 | `bullwhip` | Bullwhip | `inventory_snapshots` | S 6605; TDMU |
| 16 | `lead-time-ncc` | Lead time của nhà cung cấp | `purchase_orders`, `suppliers` | S 702, 953; TDMU |
| 17 | `otd-ncc` | Tỷ lệ giao đúng hạn của nhà cung cấp (OTD) | `purchase_orders` | S 935, 951 |
| 18 | `ty-le-hang-loi` | Tỷ lệ hàng lỗi | `purchase_orders` | S 969, 6627 |
| 19 | `lo-dat-lo-truot` | Lô đạt, lô trượt | `purchase_orders` | S 6603, 6616 |
| 20 | `diem-ncc` | Điểm NCC và hạng NCC | `purchase_orders`, `suppliers` | S 6610, 6613 |
| 21 | `otif-chuyen-giao` | OTIF của chuyến giao | `shipments` | S 728; TDMU |
| 22 | `giao-dung-han-don` | Tỷ lệ giao đúng hạn của đơn chặng cuối | `orders` | S 6626 |
| 23 | `lead-time-don` | Lead time của đơn và bốn thành phần | `orders` | S 1743, 6633 |
| 24 | `thoi-gian-chua-gan` | Thời gian chưa gán | `orders` | S 4328 |
| 25 | `ty-le-huy` | Tỷ lệ huỷ | `orders` | S 1853, 6644 |
| 26 | `ngay-cao-diem` | Ngày cao điểm và ngày nền | `event_calendar` | S 6642, 6643 |
| 27 | `nang-luc-ngay` | Năng lực ngày | `warehouse_daily_ops`, `staffing_plan` | S 6641 |
| 28 | `ty-le-tai` | Tỷ lệ tải (workload ratio) | `warehouse_daily_ops` | S 1851, 4462, 6645 |
| 29 | `don-ton-dong` | Đơn tồn đọng (backlog) | `warehouse_daily_ops` | S 1847, 4265 |
| 30 | `phan-vi-p95` | Phân vị 95 (P95) | `orders` và các bảng thời gian | S 1845, 6650 |

```latex
% ---------------------------------------------------------------- khái niệm · Supply Chain
% \khaibaokhainiem{ma}{Tên}{Định nghĩa}{Công thức}{Trong bộ dữ liệu}

% --- Kỳ, lượng bán, tồn kho
\khaibaokhainiem{ky-va-thang-du}{Kỳ và tháng đủ}
  {Kỳ là đơn vị thời gian của số liệu tồn kho, mỗi kỳ là một tháng. Tháng đủ là tháng có dữ liệu tới ngày cuối tháng.}
  {}
  {\code{inventory_snapshots.ym} dạng \code{'2017-07'}. Kỳ 2017-08 chỉ có dữ liệu nửa tháng, nên không dùng khi so các tháng với nhau.}
\khaibaokhainiem{luong-ban-va-nhu-cau}{Lượng bán trong kỳ và nhu cầu}
  {Nhu cầu là lượng khách muốn mua; lượng bán là lượng đã ghi nhận bán ra. Khi hết hàng, lượng bán nhỏ hơn nhu cầu.}
  {}
  {\code{sold} là lượng bán trong kỳ, \code{received} là lượng nhập trong kỳ, \code{thieu_hut} là phần bán vượt lượng hàng sẵn có của tồn kho mô phỏng. Doanh thu, giá vốn tính trên \code{sold}, không trừ \code{thieu_hut}.}
\khaibaokhainiem{fill-rate}{Fill rate (tỷ lệ lấp đầy)}
  {Fill rate phản ánh phần lượng bán được phục vụ trực tiếp từ hàng sẵn có trong kho.}
  {1 - tổng thieu\_hut / tổng sold}
  {bảng \code{inventory_snapshots}; tính trên tổng số lượng của các dòng (cửa hàng, mã hàng, kỳ), không lấy trung bình tỷ lệ của từng dòng.}
\khaibaokhainiem{ty-le-dong-thieu-hut}{Tỷ lệ dòng thiếu hụt}
  {Tỷ lệ dòng thiếu hụt là phần các dòng tồn kho có lượng thiếu hụt trong tổng số dòng.}
  {số dòng có thieu\_hut > 0 / tổng số dòng}
  {mỗi dòng của \code{inventory_snapshots} là một cửa hàng, một mã hàng, một kỳ.}
\khaibaokhainiem{von-ton-kho}{Vốn tồn kho}
  {Vốn tồn kho là giá trị hàng còn trong kho cuối kỳ, tính theo giá vốn.}
  {tồn cuối kỳ × giá vốn đơn vị}
  {có sẵn ở \code{inventory_snapshots.inventory_value}, bằng \code{on_hand_end} nhân \code{item_costs.unit_cost}.}
\khaibaokhainiem{vong-quay-ton-kho}{Vòng quay tồn kho}
  {Vòng quay tồn kho phản ánh số lần hàng tồn kho được bán hết và bổ sung lại trong một kỳ.}
  {giá vốn hàng bán / tồn kho bình quân theo giá vốn}
  {giá vốn hàng bán bằng tổng \code{sold} nhân \code{item_costs.unit_cost}; vốn tồn lấy từ \code{inventory_value}. Cách lấy tồn kho bình quân và hệ số quy năm ghi trong yêu cầu của từng câu. Tên cột kết quả cũ \code{itr} giữ nguyên.}
\khaibaokhainiem{dsi}{Số ngày tồn kho (DSI)}
  {Số ngày tồn kho phản ánh số ngày trung bình hàng nằm trong kho trước khi được bán. Đây là chỉ số nhìn lại quá khứ.}
  {365 / vòng quay tồn kho quy năm (hoặc số ngày của kỳ / vòng quay của kỳ)}
  {tính từ \code{inventory_snapshots} và \code{item_costs}; tên cột kết quả có thể là \code{dio}.}
\khaibaokhainiem{so-ngay-phu}{Số ngày phủ}
  {Số ngày phủ là số ngày lượng tồn hiện có đáp ứng được lượng bán dự báo nếu không nhập thêm hàng. Đây là chỉ số nhìn về phía trước.}
  {tồn cuối kỳ / tốc độ bán dự báo mỗi ngày}
  {\code{on_hand_end}; tốc độ bán dự báo là bình quân \code{sold} của ba kỳ trước, chia số ngày.}

% --- Tài chính hàng hoá
\khaibaokhainiem{bien-ln-gop}{Biên lợi nhuận gộp}
  {Biên lợi nhuận gộp là phần lợi nhuận gộp trên mỗi đồng doanh thu. Lợi nhuận gộp bằng doanh thu trừ giá vốn hàng bán.}
  {(doanh thu - giá vốn hàng bán) / doanh thu}
  {giá cố định ở \code{item_costs} (\code{unit_price}, \code{unit_cost}); giá và biên theo tháng ở \code{item_costs_monthly} (\code{margin_pct} là tỷ lệ, không phải phần trăm).}
\khaibaokhainiem{gmroi}{GMROI (lợi nhuận gộp trên vốn tồn)}
  {GMROI phản ánh số đồng lợi nhuận gộp tạo ra trên mỗi đồng vốn nằm trong tồn kho.}
  {lợi nhuận gộp quy năm / vốn tồn kho bình quân}
  {lợi nhuận gộp tính trên \code{sold} với \code{item_costs}; vốn tồn lấy từ \code{inventory_value}.}

% --- Phân loại mã hàng
\khaibaokhainiem{hang-abc}{Hạng ABC}
  {Phân tích ABC chia mã hàng theo tỷ trọng doanh thu luỹ kế, dựa trên nguyên lý Pareto.}
  {hạng A: luỹ kế tới 80\%; hạng B: trên 80\% tới 95\%; hạng C: phần còn lại}
  {doanh thu từng mã bằng tổng lượng bán nhân \code{item_costs.unit_price}; xếp mã theo doanh thu giảm dần, bằng nhau thì \code{item_nbr} nhỏ hơn đứng trước.}
\khaibaokhainiem{phan-loai-xyz}{Phân loại XYZ}
  {Phân loại XYZ chia mã hàng theo mức biến động của lượng bán qua các kỳ, đo bằng hệ số biến thiên.}
  {CV = độ lệch chuẩn / trung bình của lượng bán theo kỳ; X: CV ≤ 0,2; Y: 0,2 < CV ≤ 0,5; Z: CV > 0,5}
  {lượng bán theo kỳ là \code{sold} của \code{inventory_snapshots}; câu hỏi ghi rõ độ lệch chuẩn mẫu hay tổng thể.}

% --- Mô hình tồn kho
\khaibaokhainiem{ton-kho-an-toan}{Tồn kho an toàn (SS)}
  {Tồn kho an toàn là lượng hàng dự phòng để ứng phó với nhu cầu tăng đột ngột hoặc nhà cung cấp giao trễ.}
  {SS = z × căn(LT × σ\_D\textsuperscript{2} + D\textsuperscript{2} × σ\_LT\textsuperscript{2})}
  {D và σ\_D lấy từ lượng bán; LT và σ\_LT lấy từ lead time thực tế của đơn mua đã về; z theo mức độ phục vụ ghi trong yêu cầu.}
\khaibaokhainiem{rop}{Điểm đặt hàng lại (ROP)}
  {Điểm đặt hàng lại là mức tồn kho mà khi giảm tới đó thì phải phát đơn mua mới.}
  {ROP = nhu cầu bình quân mỗi ngày × lead time bình quân + tồn kho an toàn}
  {như \code{ton-kho-an-toan}; lead time cam kết ở \code{suppliers.promised_lead_days}, lead time thực tế tính từ \code{purchase_orders}.}
\khaibaokhainiem{bullwhip}{Bullwhip}
  {Bullwhip là hiện tượng dao động của lượng nhập lớn hơn dao động của lượng bán khi đi ngược lên đầu chuỗi cung ứng.}
  {hệ số biến thiên của lượng nhập / hệ số biến thiên của lượng bán; lớn hơn 1 là có bullwhip}
  {lượng nhập là \code{received}, lượng bán là \code{sold} của \code{inventory_snapshots}, cùng tập kỳ và cùng mức gộp.}

% --- Nhà cung cấp
\khaibaokhainiem{lead-time-ncc}{Lead time của nhà cung cấp}
  {Lead time là khoảng thời gian từ khi phát đơn mua tới khi hàng về kho.}
  {ngày nhận hàng - ngày đặt}
  {\code{purchase_orders}: \code{received_date} trừ \code{po_date} (hai cột dạng chữ \code{'YYYY-MM-DD'}); cam kết ở \code{promised_lead_days}. Đơn chưa về không có lead time thực tế.}
\khaibaokhainiem{otd-ncc}{Tỷ lệ giao đúng hạn của nhà cung cấp (OTD)}
  {Tỷ lệ giao đúng hạn là phần đơn mua về không muộn hơn ngày hẹn trong số đơn đã về.}
  {số đơn có received\_date ≤ promised\_date / số đơn đã về}
  {\code{purchase_orders}; đơn chưa về có \code{received_date} trống và \code{inspection_result = 'Pending'}, không vào mẫu số.}
\khaibaokhainiem{ty-le-hang-loi}{Tỷ lệ hàng lỗi}
  {Tỷ lệ hàng lỗi phản ánh phần hàng không đạt tiêu chuẩn chất lượng tại thời điểm nhận hàng.}
  {tổng qty\_defect / tổng qty\_received của các đơn mua đã về}
  {tỷ lệ của từng đơn có sẵn ở \code{defect_rate}. Tỷ lệ của một nhà cung cấp tính lại từ tổng số lượng, không lấy trung bình \code{defect_rate}.}
\khaibaokhainiem{lo-dat-lo-truot}{Lô đạt, lô trượt}
  {Kiểm định khi nhận hàng xếp mỗi đơn mua đã về thành lô đạt hoặc lô trượt theo ngưỡng hàng lỗi cho phép (AQL).}
  {lô trượt khi tỷ lệ hàng lỗi vượt 2\%}
  {\code{purchase_orders.inspection_result}: \code{'Pass'} (lô đạt), \code{'Fail'} (lô trượt), \code{'Pending'} (đơn chưa về).}
\khaibaokhainiem{diem-ncc}{Điểm NCC và hạng NCC}
  {Điểm NCC là điểm tổng hợp từ 0 tới 100 dùng để xếp hạng nhà cung cấp.}
  {tổng có trọng số của năm thành phần: đúng hạn, hàng lỗi, chênh lead time, sản lượng, khoảng cách; Gold từ 75, Silver từ 60, còn lại Bronze}
  {thành phần lấy từ \code{purchase_orders} và \code{suppliers} (\code{km_supplier_to_dc}); trọng số và cách chuẩn hoá ghi trong yêu cầu của từng câu.}

% --- Phân phối, chặng cuối
\khaibaokhainiem{otif-chuyen-giao}{OTIF của chuyến giao}
  {OTIF là tỷ lệ chuyến giao vừa đúng hạn vừa đủ số lượng. Một chuyến đúng hạn mà thiếu hàng không đạt OTIF.}
  {số chuyến đúng hạn và đủ hàng / tổng số chuyến}
  {\code{shipments}: \code{on_time} bằng 1 khi \code{actual_days} không vượt \code{promised_days}; \code{in_full} bằng 1 khi giao đủ; \code{otif} bằng \code{on_time} nhân \code{in_full}.}
\khaibaokhainiem{giao-dung-han-don}{Tỷ lệ giao đúng hạn của đơn chặng cuối}
  {Tỷ lệ giao đúng hạn là phần đơn được giao không muộn hơn mức cam kết.}
  {số đơn có on\_time = 1 / số đơn không huỷ}
  {\code{orders.on_time} bằng 1 khi \code{lead_time_total_h} không vượt \code{promised_h}. Đơn huỷ (\code{is_cancelled}) vẫn có giá trị ở các cột thời gian, nên phải loại trước khi tính.}
\khaibaokhainiem{lead-time-don}{Lead time của đơn và bốn thành phần}
  {Lead time của đơn là thời gian từ lúc tạo đơn tới lúc giao thành công. Bốn thành phần là t1 (tạo đơn tới lấy hàng), t2 (lấy hàng tới xuất kho), middle mile (t3a di chuyển cộng t3b phân loại) và t4 (kho tới giao thành công).}
  {lead time = delivered\_at - created\_at (giờ)}
  {\code{orders.lead_time_total_h}; năm cột chặng \code{t1_tao_don_pick_h}, \code{t2_pick_xuat_h}, \code{t3a_di_chuyen_h}, \code{t3b_sorting_h}, \code{t4_kho_giao_h}.}
\khaibaokhainiem{thoi-gian-chua-gan}{Thời gian chưa gán}
  {Thời gian chưa gán là phần lead time không thuộc chặng nào trong năm cột chặng.}
  {lead time - tổng năm cột chặng}
  {tính trên \code{orders}; tổng năm cột chặng không bằng \code{lead_time_total_h}, nên không được cộng các chặng để thay lead time.}
\khaibaokhainiem{ty-le-huy}{Tỷ lệ huỷ}
  {Tỷ lệ huỷ là phần đơn bị huỷ trong tổng số đơn được tạo.}
  {số đơn huỷ / tổng số đơn tạo}
  {\code{orders.is_cancelled}.}
\khaibaokhainiem{ngay-cao-diem}{Ngày cao điểm và ngày nền}
  {Ngày cao điểm là ngày khuyến mãi hoặc ngày lễ trong lịch sự kiện, khi lượng đơn tăng mạnh. Ngày nền là ngày nằm ngoài cửa sổ hai ngày trước và sau mỗi ngày cao điểm.}
  {}
  {\code{event_calendar}: mỗi dòng là một sự kiện; \code{tier} là quy mô (\code{'nho'}, \code{'vua'}, \code{'lon'}, \code{'le'}); \code{demand_multiplier} là hệ số nhu cầu.}
\khaibaokhainiem{nang-luc-ngay}{Năng lực ngày}
  {Năng lực ngày là số đơn một kho xử lý được trong ngày với nhân sự có mặt.}
  {nhân sự có mặt × 130 × 0,93}
  {\code{warehouse_daily_ops.headcount}; nhân sự kế hoạch ở \code{headcount_ke_hoach} (cũng có ở \code{staffing_plan}).}
\khaibaokhainiem{ty-le-tai}{Tỷ lệ tải (workload ratio)}
  {Tỷ lệ tải là khối lượng việc cần xử lý trong ngày chia cho năng lực xử lý của kho. Tỷ lệ lớn hơn 1 là quá tải.}
  {đơn cần xử lý / năng lực ngày}
  {có sẵn ở \code{warehouse_daily_ops.workload_ratio}; câu hỏi dùng cột này, không tự tính lại từ \code{headcount}.}
\khaibaokhainiem{don-ton-dong}{Đơn tồn đọng (backlog)}
  {Đơn tồn đọng là số đơn chưa xử lý xong, chuyển sang ngày sau.}
  {đơn tồn cuối ngày = đơn tồn đầu ngày + đơn mới - đơn đã xử lý}
  {\code{warehouse_daily_ops}: \code{backlog_dau_ngay}, \code{backlog_cuoi_ngay}; một dòng là một kho trong một ngày.}

% --- Thống kê
\khaibaokhainiem{phan-vi-p95}{Phân vị 95 (P95)}
  {Phân vị 95 là giá trị mà 95\% số quan sát không vượt quá. P95 của lead time cho biết những đơn chậm nhất chậm tới đâu, điều mà trung bình không cho thấy.}
  {}
  {MySQL 8.0 không có hàm phân vị; câu hỏi ghi rõ cách lấy, ví dụ giá trị nhỏ nhất có \code{PERCENT_RANK} từ 0,95 trở lên.}
```

Ghi chú cho người soạn khi dùng mục E:
- Ngưỡng 2% của lô trượt: trong DB, lô trượt có `defect_rate` từ 0,02 tới 0,25, lô đạt từ 0 tới 0,02 (làm tròn ở biên). Câu nào lọc theo ngưỡng phải lấy `inspection_result`, không tự so `defect_rate` với 0,02.
- `on_hand_end` không luôn bằng `on_hand_begin` + `received` − `sold` + `thieu_hut` (khớp khoảng 88% dòng kỳ 2017-07): không đưa đẳng thức này vào tab Nghiệp vụ.
- `workload_ratio` không khớp chính xác công thức headcount × 130 × 0,93: dùng cột có sẵn.

---

## F. Điểm cần giảng viên chốt

1. CTE: đề bài giao gợi ý "biểu thức bảng chung (CTE)"; SG A.5 (đã duyệt) cấm "biểu thức bảng chung" và giữ "CTE (bảng tạm đặt tên bằng WITH)". Bộ chuẩn này theo SG. Có đổi không?
2. Tỷ lệ tải: đề bài giao và giáo trình dùng "hệ số" ("hệ số tải", LCB "hệ số sử dụng"); sách và SG dùng "tỷ lệ tải". Bộ chuẩn theo sách.
3. Fill rate: sách dùng cho hai nghĩa (lượng phục vụ từ tồn kho ở S 745; đơn giao đủ ở S 1850). Bộ câu chỉ dùng nghĩa S 745 với công thức SG H.3; chuyến giao đủ hàng gọi là "tỷ lệ đủ hàng". Xin xác nhận.
4. Lời giải thích phương án: QC mẫu dùng "Đúng: …"; SG C.2 cấm khuôn "mệnh đề: kết luận". Đề xuất "Đúng. …". Có sửa cả 16 câu mẫu không, hay chỉ áp dụng cho bộ SCM?
5. Gợi ý nấc 2: SG C.4 cấm viết sẵn SQL, QC mẫu (`w3`, `o3`, `o4`) đưa một khung cú pháp. Đề xuất cho phép một khung một dòng ở nấc cuối.
6. Hạng ABC hay nhóm ABC: bảng thuật ngữ của sách (S 6612) và SG dùng "hạng"; thân sách (S 1172) và LCB dùng "nhóm A". Bộ chuẩn theo bảng thuật ngữ.
7. Tồn kho / dự trữ, tồn kho an toàn / dự trữ bảo hiểm, nhà cung cấp / nhà cung ứng, lead time / thời gian chờ hàng: giữ từ của sách; từ giáo trình chỉ ghi chú. Có cần thêm một dòng "còn gọi là" trong `\khaibaokhainiem` để học viên nhận ra từ của giáo trình không?
8. Phân vị: MySQL 8.0 không có `PERCENTILE_CONT`. Cần chốt một quy ước P95 dùng chung cho mọi câu (đề xuất ở `phan-vi-p95`).
9. Domain của bộ SCM: QC hiện khai báo 6 domain của Datathon. Bộ SCM cần `\khaibaodulieu` và danh sách domain riêng (đề xuất: tồn kho, mua hàng và NCC, bán hàng, phân phối, giao hàng chặng cuối, tài chính hàng hoá). Ngoài phạm vi tài liệu này, ghi lại để quyết.
10. Giáo trình NEU, UEH, FTU, ĐH Bách khoa Hà Nội không có bản trực tuyến; cột "Ghi chú giáo trình" hiện dựa trên giáo trình ĐH Thủ Dầu Một, giáo trình logistics căn bản (Đặng Đình Đào, Nguyễn Thị Bạch Tuyết), giáo trình của Đoàn Thị Hồng Vân, metadata giáo trình ĐH Thương mại và báo cáo Bộ Công Thương. Nếu giảng viên có bản giấy của giáo trình NEU hoặc UEH, cần đối chiếu lại các dòng ở mục 7.

---

## G. Quyết định tạm (10/11/2026) cho lô thử – chờ giảng viên duyệt cùng gói 1

1. "CTE": trong `yeucau`/`\goiy` được gọi tên kỹ thuật SQL như bản gốc ("CTE", "hàm cửa sổ"), lần đầu trong câu kèm giải nghĩa ngắn nếu cần. Bối cảnh (`\boicanh`) không nhắc tên kỹ thuật SQL (CHOT-FORMAT mục 3); tiêu đề cũng không, trừ câu Tối ưu được nêu ràng buộc như mẫu o1, o4 (sửa theo quy_chuan: cau-hoi.tex o1, o3, o4, lúc 10/11, 23:05; khớp B.1).
2. `workload_ratio`: gọi "tỷ lệ tải" (theo sách dự án); dùng thẳng cột có sẵn, không tự tính lại.
3. Fill rate: mỗi câu định nghĩa rõ ngay trong `yeucau`/khái niệm: 1 − tổng `thieu_hut` / tổng `sold` (phần lượng bán được phục vụ từ hàng sẵn có).
4. Bước kết luận của case (sửa theo quy_chuan: cau-hoi.tex c1–c4, lúc 10/11, 23:05): phương án đúng mở bằng "Đúng: …" (dấu hai chấm, như mẫu); phương án sai không tiền tố, nêu thẳng chỗ sai (như B.6 gốc). Không dùng "Chưa đúng.", "Sai:". Câu "Không dùng khuôn 'Đúng: …'" của B.6 hết hiệu lực; độ dài lời giải thích ≤ 35 tiếng.
5. Gợi ý (sửa theo quy_chuan: cau-hoi.tex w1, w3, o3, o4, lúc 10/11, 23:05): được nêu tên hàm/mệnh đề (ví dụ `COUNT(DISTINCT …)`, `LEFT JOIN`), KHÔNG viết sẵn cả câu SQL hay một khung nhiều dòng. Nấc cuối được nêu trọn **một biểu thức một dòng**, kể cả giá trị lọc hoặc tiêu chí hoà, như mẫu; không bắt buộc để trống thành phần nào.
6. ABC: "hạng ABC", "hạng A/B/C" (theo Bảng thuật ngữ sách).
7. P95 trên MySQL (không có `PERCENTILE_CONT`): đề nêu quy tắc cụ thể "giá trị nhỏ nhất có tỷ lệ tích luỹ (CUME_DIST) ≥ 0,95" hoặc "giá trị ở vị trí CEIL(0,95 × n) khi sắp tăng dần"; mỗi câu chỉ dùng một quy tắc và ghi rõ.
8. Mảng nghiệp vụ (`domain`) dùng 6 khoá chuẩn, ánh xạ: `operations` (kho, tồn kho, giao hàng, NCC, nhân sự kho), `sales` (doanh thu, lượng bán, cửa hàng, ngành hàng), `finance` (giá vốn, biên lợi nhuận gộp, GMROI, vốn tồn), `marketing` (khuyến mãi, ngày cao điểm, voucher), `customer` (lượt giao dịch, đơn online theo khách/điểm giao), `after_sales` (hàng lỗi, lô trượt, huỷ đơn). Không thêm khoá mới.

### Quyết định chung 5 bộ (theo `QUYET-DINH-CHUNG.md`, 10/11/2026)

Áp chung cho `scm`, `aivb`, `jelly`, `hr`, `mkt`. Lệch với chỗ khác trong file này thì theo các dòng dưới. **Thứ tự ưu tiên: `quy_chuan` (quy_chuan.rar) > `QUYET-DINH-CHUNG.md` > file STYLE này > brief.** Chi tiết, căn cứ và bảng các điểm đã sửa theo quy chuẩn (10/11, 23:05) ở `QUYET-DINH-CHUNG.md` mục 0.

- **Kết luận case** (sửa theo quy_chuan: goi-cau-hoi-mau/cau-hoi.tex, câu c1–c4, lúc 10/11, 23:05): ba phương án, đúng một `\phuongan*`. Lời giải thích của phương án đúng mở bằng **"Đúng: "** rồi nêu căn cứ; phương án sai **không có tiền tố**, nêu thẳng chỗ sai. Không dùng "Chưa đúng.", "Sai:". 1–2 câu, ≤ 35 tiếng (lời giải thích dài nhất của mẫu, c3, khoảng 34 tiếng), nêu bước nào cho thấy điều gì.
- **Case Cơ bản:** được `GROUP BY` một cột + một hàm gom trên **một bảng** (theo case mẫu `c1-kenh-nhieu-don` của CHOT); không `JOIN`, `HAVING`, truy vấn con. Ghi lý do một dòng ở `\ghichuthietke`.
- **Gợi ý** (sửa theo quy_chuan: cau-hoi.tex w1, w3, o3, o4; Huong-dan mục 10 bước 7): 1–2 nấc ở câu, 1 nấc ở mỗi bước case. Nấc đầu nêu hướng (bảng cần dùng, cách tách bước, bẫy); nấc cuối được nêu trọn **một biểu thức một dòng**, kể cả giá trị lọc hoặc tiêu chí hoà, như mẫu w3 `ROW_NUMBER() OVER (PARTITION BY category ORDER BY doanh_thu DESC, product_id)`. Không viết sẵn cả câu SQL, không khung nhiều dòng. **Bỏ** yêu cầu "để trống ít nhất một thành phần".
- **ERD** (sửa một phần theo quy_chuan: CHOT-FORMAT mục 3, Huong-dan mục 5, mẫu w4, d4, o4, c4): số bảng Cơ bản 1 · Dễ 2 · Trung bình 3–4 · Khó 5–7. Bảng nhiễu: Cơ bản 0 · Dễ ≤ 1 · Trung bình ≤ 1 (quy ước bổ sung) · Khó 1–2, bắt buộc có; câu Khó mà lời giải dùng ≤ 3 bảng được thêm bảng nhiễu cho đủ 5 bảng như mẫu d4, o4. ERD Khó **chỉ khoá, không vẽ `\erdnoi`**; cách nối viết trong `\erdkhoa`. Bảng nhiễu ở Dễ, Trung bình có đường nối đúng với bảng dùng; ở Khó nên có cột khoá chung với bảng dùng (mẫu w4) nhưng không bắt buộc (mẫu o4). Bảng nhiễu không làm tăng cấp.
- **Cấp** (sửa một phần theo quy_chuan: Huong-dan mục 6, lo-trinh-sql/assets/js/data.js): theo thang `QUYET-DINH-CHUNG.md` mục 2: cấp = mức mà ≥ 3/5 trục đạt (số bảng lời giải cần, số bước, mức mơ hồ, số bẫy, độ sâu nghiệp vụ). Ở M1–3: Dễ = Cơ bản + một bẫy hoặc một bước. **Bỏ ngoại lệ "M7, M8 không có Dễ"**: lộ trình chuẩn cho mọi module đủ 4 cấp; sửa lỗi một chỗ dễ thấy là Dễ, muốn Trung bình thì lỗi phải khó thấy (nối thừa nhân dòng, sai phạm vi cửa sổ) hoặc thêm lỗi, bẫy thật. Câu Khó không bắt buộc ≥ 4 bảng (mẫu o4 dùng 1 bảng). Optimize lấy cấp theo mẫu kỹ thuật của CHOT mục 4.
- **Yêu cầu (`yeucau`):** thứ tự sắp luôn kết thúc bằng một khoá duy nhất; top N nói rõ lấy đúng N dòng hay lấy cả người hoà; ghi số chữ số và kiểu làm tròn, chỉ làm tròn cột cuối; tỷ lệ trả phần trăm 2 chữ số (tên cột tuỳ: mẫu dùng cả `ty_le_tra` lẫn `thay_doi_pct`), nếu bắt buộc trả 0–1 thì 4 chữ số và đặt `saiso=0.0001`; NULL nói rõ giữ NULL, thay bằng giá trị gì, hay loại dòng; tháng, quý trả chuỗi theo dạng ghi trong đề; năm trả số, trừ khi đề ghi rõ trả chuỗi như mẫu o2; mốc thời gian ghi cả cận dưới và cận trên.
- **Tiêu đề** (sửa theo quy_chuan: tiêu đề mẫu w3, w4, o3, o4 dài 11–13 tiếng): ngắn, **≤ 13 tiếng**. Câu Tối ưu được nêu ràng buộc trong tiêu đề ("… chỉ với một lần quét", "… không dùng tự nối bảng") như mẫu o1, o4; các loại khác không nhắc kỹ thuật SQL ở tiêu đề (quy ước bổ sung). Bối cảnh không nhắc tên kỹ thuật SQL (CHOT-FORMAT mục 3).
- **Riêng scm:** A.3 giữ cách gọi theo sách dự án (S 4556): nhóm `'manual'` là "khách tự áp mã", nhóm `'auto_apply'` là "hệ thống tự động áp mã" (sửa lúc 23:45 theo sách dự án; bỏ "tự nhập voucher" của bản trước). scm-j6 viết lại sang chủ đề và ô khác (không trùng scm-a8); giữ scm-j4. Hạ scm-k3, scm-p7 xuống Dễ.
