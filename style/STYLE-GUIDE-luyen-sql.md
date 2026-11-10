# Bộ chuẩn thuật ngữ và giọng văn cho 80 bài "Luyện SQL" (Supply Chain)

Áp dụng cho mọi trường văn bản: `title`, `statement`, `output`, `lesson.concept/formula/why/used_in`, `hints[]`, `takeaway`.
Không đổi SQL, không đổi số liệu, không đổi tên cột output (ví dụ cột `dio`, `du_phong_ngay` giữ nguyên dù văn đổi thuật ngữ).

Thứ tự ưu tiên khi các nguồn mâu thuẫn:
1. Sách dự án `project-supply-chain/main.tex` (ghi "Sách + số dòng"). Bảng thuật ngữ ở dòng 6591–6690.
2. Ngữ nghĩa dữ liệu: theo sách (mục H.3 cho `sold`/`thieu_hut`).
3. BRIEF.md / FIX-RULES.md (phần không trái sách).
4. Nguồn web (có URL), chỉ cho thuật ngữ sách không có.

Giọng mẫu để bắt chước là Mục III.2 "Khám phá dữ liệu" (Sách 3806–4630) và Mục VI.7 (Sách 6522–6570). Không bắt chước các đoạn văn báo cáo nặng ở Sách 4726, 4735, 5665–5706 ("đóng vai trò tích hợp", "bức tranh toàn cảnh", "mối quan hệ biện chứng").

---

## A. Bảng thuật ngữ

Quy ước: cột "Dùng" là đúng chữ cần viết (viết thường như sách, trừ đầu câu). Tên bảng/cột luôn để trong backtick, đúng như DB. Thuật ngữ giữ tiếng Anh thì giải nghĩa tiếng Việt ở lần đầu xuất hiện trong mỗi bài, ví dụ "fill rate (tỷ lệ lấp đầy)".

### A.1 Chuỗi cung ứng và tồn kho

| Tiếng Anh / tên cột DB | Dùng (trong văn) | Không dùng | Nguồn |
|---|---|---|---|
| AQL; ngưỡng lỗi 2% của `inspection_result` | AQL (mức chất lượng chấp nhận), ngưỡng 2% hàng lỗi | "ngưỡng Fail" | Sách 6603 |
| gross margin | biên lợi nhuận gộp | biên lãi gộp, biên lãi, biên gộp, "biên mỏng" | Sách 6604 |
| gross profit | lợi nhuận gộp | lãi gộp, lãi | Sách 6617 |
| bullwhip effect | bullwhip; lần đầu: "bullwhip (dao động lượng nhập lớn hơn dao động lượng bán)" | hiệu ứng roi da (chỉ để trong ngoặc nếu cần) | Sách 6605; https://amis.misa.vn/48956/hieu-ung-bullwhip/ |
| normalized gap / inventory allocation index / capital release opportunity | chênh lệch chuẩn hóa / chỉ số phân bổ tồn kho / cơ hội giải phóng vốn | | Sách 6606–6608 |
| load window; complete month | cửa sổ nạp; tháng đủ | "tháng thiếu" | Sách 6609, 6624 |
| supplier score / scorecard | điểm NCC; bảng điểm NCC | supplier scorecard | Sách 6610 |
| supplier tier | hạng NCC Gold / Silver / Bronze | mức tier | Sách 6613 |
| perishable / non-perishable (`perishable` = 1 / 0) | hàng tươi sống / hàng khô | hàng dễ hỏng, hàng tươi, hàng không dễ hỏng | Sách 6611, 2627 |
| ABC class | hạng ABC; hạng A, hạng B, hạng C | nhóm A, nhóm C | Sách 6612 |
| XYZ, CV | phân loại XYZ; hệ số biến thiên (CV) | | Sách 1186 |
| annualization | hệ số quy năm; "quy ra năm" | | Sách 6614 |
| period, `ym` | kỳ (một kỳ là một tháng); "tháng 7/2017", "kỳ 2017-07" | | Sách 6615 |
| inspection pass / fail | lô đạt / lô trượt; "trượt kiểm định" | lô Fail, PO bị Fail | Sách 6616, 5521 |
| GMROI | GMROI (lợi nhuận gộp trên vốn tồn) | "mỗi đồng vốn nằm trong hàng tồn" (chỉ khi giải thích) | Sách 6618, 909 |
| transfer quantity | lượng cần điều chuyển | | Sách 6619 |
| family | ngành hàng | nhóm hàng | Sách 6620 |
| `received`; `sold` | nhập trong kỳ (`received`); lượng bán trong kỳ (`sold`, lượng bán đã ghi nhận); lượng thiếu hụt (`thieu_hut`) | "nhu cầu thật", "cầu thật" cho `sold`; "`sold` − `thieu_hut`" làm lượng bán | Sách 6621, 3633–3644; quyết định H.3 |
| `thieu_hut` | thiếu hụt (phần nhu cầu không đáp ứng được); dòng thiếu hụt; tỷ lệ dòng thiếu hụt | tỷ lệ thiếu hàng, tỷ lệ hết hàng (stockout rate) | Sách 3919, 3966 |
| stockout | hết hàng | thủng hàng, kệ trống | Sách 710 |
| understock / overstock / adequate | thiếu hàng / dư hàng / đủ hàng (ba trạng thái theo số ngày phủ); nói chung: tồn kho dư thừa, đọng vốn | dùng "thiếu hàng" cho `thieu_hut` > 0; ứ hàng, ôm hàng | Sách 6625, 3772, 712, 3964 |
| days of supply / days of cover | số ngày phủ | ngày phủ, mức phủ | Sách 6623, 993 |
| stock-to-sales ratio | tỷ số tồn trên bán | | Sách 6628 |
| inventory value (`inventory_value`) | vốn tồn kho; vốn tồn | giá trị tồn (khi nói về vốn), "giam vốn" | Sách 6629 |
| inventory turnover | vòng quay tồn kho | ITR trong văn (chỉ giữ ở tên cột `itr`) | Sách 825, 6593 |
| DIO / DSI | số ngày tồn kho (DSI) | DIO trong văn, "số ngày nằm kho" | Sách 848, 6593 |
| COGS | giá vốn hàng bán (COGS); giá vốn | | Sách 704 |
| safety stock / ROP / EOQ; service level, z | tồn kho an toàn (SS) / điểm đặt hàng lại (ROP) / lượng đặt hàng kinh tế (EOQ); mức độ phục vụ | safety stock trong văn, "phần đệm", mức phục vụ | Sách 1345, 1347, 1359, 1368 |
| SKU, `item_nbr` | mã hàng (SKU); "mặt hàng" chỉ khi nói hàng hóa chung | phần tử | Sách 700, 6612 |
| PO, `purchase_orders` | đơn mua (PO); lần đầu có thể viết "đơn đặt hàng (PO)" | lô hàng (PO) | Sách 706, 6616 |
| supplier | nhà cung cấp (NCC) | | Sách 6610 |
| lead time (NCC), `promised_lead_days` | lead time; lead time cam kết; lead time thực tế | "giữ lời" | Sách 702, 953 |
| on-time delivery (đơn mua NCC) | OTD (tỷ lệ giao đúng hạn) | | Sách 935, 1837; FIX-RULES §2 |
| defect rate (`defect_rate`) | tỷ lệ hàng lỗi | "lỗi theo khối lượng" (thay bằng "tính trên số lượng nhận") | Sách 6627, 969 |
| fill rate | fill rate (tỷ lệ lấp đầy) | | Sách 745 |
| forecast accuracy, MAPE, WMAPE | độ chính xác dự báo; MAPE; WMAPE | | Sách 757 |
| forecast bias; naive / seasonal naive | bias dự báo (dự báo lệch cao hay lệch thấp), giải nghĩa lần đầu; dự báo bằng tháng liền trước / bằng cùng kỳ năm trước | naive, seasonal-naive trong văn | Không có trong sách; chưa tìm được giáo trình ĐH VN nên giữ tiếng Anh |
| promo lift | mức tăng lượng bán khi khuyến mãi (lift) | "khuyến mãi kéo cầu", promo lift | "khuyến mãi": Sách 2008; "lift": không có nguồn VN |
| demand; demand forecast | nhu cầu; dự báo nhu cầu; tốc độ bán dự báo | "cầu" đứng một mình (chỉ giữ trong "cung - cầu") | Sách: "nhu cầu" 82 lần; 993, 6623 |

### A.2 Cửa hàng, kênh bán và DC

| Tiếng Anh / tên cột DB | Dùng (trong văn) | Không dùng | Nguồn |
|---|---|---|---|
| store type (`stores.type`, A–E) | loại cửa hàng (loại A … loại E) | định dạng cửa hàng, store format, "type A" trong văn | Sách 2553 (`CuaHang.Loại cửa hàng`), 4958 |
| `cluster` | cụm cửa hàng | | Sách 2554 |
| region / `state` | miền; tỉnh, thành | | Sách 2555 |
| `transactions` | lượt giao dịch; "đông khách / vắng khách" khi nói chung | traffic, "lượt khách" làm tên chỉ số | Sách 3888, 3917 |
| basket value | giá trị giỏ hàng (doanh thu / số giao dịch) | giỏ hàng (trơ), basket size | Sách 6725 |
| assortment | số mã hàng có bán | độ rộng danh mục (assortment) | Sách 3809 |
| dead / slow SKU | mã không bán được ở cửa hàng nào; mã bán chậm | mã chết, hàng đứng | Sách 5170, 5732 ("bán chậm") |
| like-for-like | tăng trưởng cùng cửa hàng (like-for-like) | | Sách 3838 |
| MoM / YoY | so kỳ trước / so cùng kỳ | MoM, YoY trong văn | Sách 4745, 4871 |
| seasonality index; weekly pattern | chỉ số mùa vụ; nhịp tuần | "chỉ số thứ" | Sách 3879, 3888 |
| revenue per m²; `rent_month_usd` | doanh thu trên m²; tiền thuê mặt bằng | "gánh nặng thuê" | Sách 4748 |
| DC, `warehouses`, `warehouse_id` | trung tâm phân phối (DC) ở lần đầu, sau đó DC | kho tổng, DC mẹ | Sách 708, 4161 |
| shipment (`shipments`) | chuyến giao; lượt giao | chuyến hàng | Sách 4161, 6626 |
| OTIF | OTIF (giao đúng hạn và đủ hàng) | | Sách 728 |
| `on_time` (chuyến giao, đơn online) | tỷ lệ giao đúng hạn (on-time) | "vế on-time" | Sách 6626; FIX-RULES §2 |
| `in_full` | tỷ lệ đủ hàng; chuyến giao thiếu hàng | đủ số, giao thiếu số, "vế đủ số" | Sách 4188, 4217 |
| distance (`km_to_dc`, `km_supplier_to_dc`) | quãng đường; quãng đường bình quân; khoảng cách | bán kính | Sách 4159; FIX-RULES §2 |
| center of gravity | phương pháp trọng tâm (center of gravity); tọa độ trọng tâm | | Không có trong sách; không tìm được giáo trình VN có công thức |
| holidays, `transferred` | ngày lễ; lễ bị dời; ngày nghỉ bù | | Mô tả bảng `holidays` |
| simulated data | dữ liệu mô phỏng; bộ sinh dữ liệu; giả định dựng sẵn | "dữ liệu sinh", "được cài sẵn" | Sách 6648, 6663, 5726 |

### A.3 Giao hàng chặng cuối

| Tiếng Anh / tên cột DB | Dùng (trong văn) | Không dùng | Nguồn |
|---|---|---|---|
| sorting hub (`sorting_hubs`, `hub_id`) | kho (trung tâm phân loại) | hub | Sách 4229 |
| main / satellite hub (`role`) | kho chính / kho vệ tinh | DC chính, hub vệ tinh | Sách 6638, 4229; giá trị cột `role` |
| `dest_hub_id` / `origin_hub_id` | kho đích / kho xuất | hub đích, hub gốc | Sách 4417 |
| bottleneck hub | kho nghẽn; điểm nghẽn | nút thắt | Sách 6639, 1646 |
| last mile | chặng cuối; kênh giao hàng chặng cuối | last-mile, final mile, "khâu cuối" | Sách 5888, 1655 |
| first mile / middle mile | chặng đầu / middle mile (t3a di chuyển + t3b phân loại) | | Sách 1959, 6640 |
| lead time components | bốn thành phần lead time: t1, t2, middle mile, t4 | | Sách 6633 |
| năm cột `t1_…` tới `t4_…` | chặng; "năm cột chặng" | trộn "công đoạn"/"khâu"/"chặng" trong một bài | Sách 4328 |
| `t3b_sorting_h` | thời gian phân loại | giờ sorting | Sách 5894 |
| lead time − tổng năm cột chặng | thời gian chưa gán (cho chặng nào) | thời gian chờ giữa các khâu, giờ chờ | Sách 4328, 4366 |
| cut-off time | giờ chốt đơn | | Sách 4368 |
| `promised_h`, `promised_days` | cam kết (giờ, ngày); mức cam kết | mức hứa | Sách 4372 |
| event day (`event_calendar`) | ngày cao điểm; mỗi dòng là một sự kiện | ngày sale, đợt sale (trừ tên riêng như "Sale 11.11") | Sách 6642 |
| `tier` (nho / vua / lon / le) | quy mô sự kiện: sự kiện nhỏ, vừa, lớn và ngày lễ | "tier" trơ trong văn, "sale lớn" | Sách 4386 |
| baseline day; baseline; alert margin | ngày nền, ngày thường; baseline (mức nền); biên cảnh báo | ngày sạch | Sách 6643, 6631, 6632 |
| demand multiplier | hệ số nhu cầu | hệ số cầu | Sách 6637 |
| workload ratio | tỷ lệ tải (workload ratio) | hệ số tải | Sách 4462, 6645 |
| daily capacity | năng lực ngày | | Sách 6641 |
| orders per head | đơn cần xử lý trên đầu người | | Sách 6634 |
| backlog (`backlog_dau_ngay`, `backlog_cuoi_ngay`) | đơn tồn đọng (backlog); đơn tồn đầu ngày / cuối ngày | "rã tồn", "tồn đọng đỉnh" | Sách 4265, 1847 |
| `headcount`, `headcount_thuc_te` | nhân sự có mặt (headcount) | quân số | Sách 6636, 4293 |
| `headcount_ke_hoach` | nhân sự kế hoạch; "định biên" chỉ khi nói chính sách nhân sự | quân số kế hoạch | Sách 4293, 6313 |
| cancel rate (`is_cancelled`) | tỷ lệ huỷ | | Sách 6644 |
| GMV | GMV (tổng giá trị đơn hoàn tất) | | Sách 6635 |
| voucher, `checkout_group`; A/B test; conversion | voucher (phiếu giảm giá); nhóm khách tự áp mã / nhóm hệ thống tự áp mã; thử nghiệm A/B; tỷ lệ chuyển đổi | | Sách 2008, 4556, 2009 |
| EDD; delivery point; milk-run | ngày giao dự kiến (EDD); điểm giao; gom tuyến (milk-run) | | Sách 1735, 4227, 2709 |

### A.4 Thống kê

| Tiếng Anh | Dùng (trong văn) | Không dùng | Nguồn |
|---|---|---|---|
| percentage point | điểm phần trăm | "điểm" đứng một mình, pp | Sách 6647 |
| percentile; median | phân vị, phân vị 95 (P95); trung vị | percentile, "phần đuôi" | Sách 6650, 4070 |
| weighted average | trung bình có trọng số | "bình quân gia quyền" | Sách 6651 |
| rolling median / rolling average | trung vị trượt / trung bình trượt | moving average trong văn | Sách 6652 (trung bình trượt đặt theo cùng cách) |
| correlation | hệ số tương quan (Pearson r) | | Sách 6649 |
| confidence interval | khoảng tin cậy 95% | | Sách, bảng `AbTest` (Mục III.1) |
| Simpson's paradox; root cause analysis | nghịch lý Simpson; phân tích nguyên nhân gốc | | Sách 4511, 6677 |

### A.5 Dữ liệu, SQL và Power BI

| Tiếng Anh | Dùng (trong văn) | Không dùng | Nguồn |
|---|---|---|---|
| row / column / table | dòng / cột / bảng | phần tử, bản ghi (chấp nhận khi nói "bản ghi trùng") | Sách 3376 |
| NULL | NULL; ô trống | | Sách 3376 |
| GROUP BY; aggregate | gom nhóm (GROUP BY); hàm gộp | | Sách (GROUP BY trong Phụ lục E) |
| JOIN, LEFT JOIN | nối bảng; giữ nguyên LEFT JOIN, INNER JOIN | "ghép kiểu INNER JOIN" | Sách 4293 ("ghép theo kho và ngày") |
| anti-join | tìm dòng không có cặp (anti-join); NOT EXISTS | | https://viblo.asia/p/nhung-kien-thuc-co-ban-ve-sql-7-qPoL72wNJvk |
| subquery | truy vấn con; truy vấn con tương quan | subquery trong văn | https://hackernoon.com/lang/vi/Hướng-dẫn-cho-người-mới-bắt-đầu-hiểu-các-chức-năng-của-cửa-sổ-SQL-phần-2 |
| CTE | CTE (bảng tạm đặt tên bằng WITH); giữ tiếng Anh | "biểu thức bảng chung" | https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql (không tìm được bản tiếng Việt) |
| window function | hàm cửa sổ (window function) | | https://learn.microsoft.com/vi-vn/training/modules/write-queries-that-use-window-functions |
| PERCENTILE_CONT | phân vị nội suy | | Sách 7762 |
| partition (PostgreSQL) | phân vùng | "bảng được chia nhỏ" | Sách 6678 |
| dimension / fact table; star schema; relationship; cardinality; many-to-many | bảng chiều / bảng sự kiện; mô hình hình sao; quan hệ; bản số; nhiều-nhiều | | Sách 6655, 6656, 6661, 6672, 6676, 6679 |
| measure, DAX, card, slicer, visual, refresh, TopN, query folding, summarizeBy, Import mode; measure table | giữ tiếng Anh (measure, DAX, card, slicer, visual, refresh, TopN, query folding, summarizeBy, chế độ Import); bảng measure | | Sách 6659, 6664–6686 |
| semantic model; Power Query M; shared expression; parameter; navigator; native query; credential; client | mô hình dữ liệu; ngôn ngữ M; biểu thức; tham số; bảng điều hướng; câu truy vấn gốc; thông tin đăng nhập; máy khách | | Sách 6657, 6662, 6664, 6670, 6671, 6674, 6682, 6683 |
| filter context; last-period pattern; MTD; secondary axis; event marker; disconnected table | ngữ cảnh lọc; khuôn kỳ cuối; MTD; trục phụ; vạch ngày cao điểm; bảng nhãn rời | | Sách 6660, 6669, 6673, 6675, 6685, 6686 |
| original / operational dashboard; specification; tolerance; data generator | bản gốc / bảng điều khiển; đặc tả; dung sai; bộ sinh dữ liệu | | Sách 6654, 6658, 6663, 6666, 6667 |
| insight | trong bài luyện viết "phát hiện" hoặc nói thẳng kết quả | insight (BRIEF cấm trong văn bài luyện; sách chỉ dùng như thuật ngữ dashboard) | Sách 6668; BRIEF |

---

## B. Giọng văn của sách

Trích nguyên văn (đã bỏ lệnh LaTeX như `\%`, `\textbf{}`, `\code{}`; số dòng của `main.tex`).

Đặt câu hỏi nghiệp vụ
1. "Nhu cầu thay đổi thế nào theo thời gian? Ngành hàng nào đọng vốn lâu? Mã hàng nào mang lại phần lớn doanh thu?" (3807)
2. "Bán được bao nhiêu và lãi bao nhiêu, theo tháng, theo tỉnh và theo ngành hàng." (4728)
3. "Nhà cung cấp nào giao trễ hạn, giao hàng lỗi, và cần siết chặt nhà cung cấp nào." (4730)

Mở một vấn đề
4. "Để biết nhu cầu tăng bao nhiêu qua các năm và mức tăng đến từ đâu, chúng ta đặt sản lượng bán bình quân tháng của từng năm cạnh số cửa hàng và số mã hàng có bán." (3809)
5. "Để biết trễ hạn dồn vào nhà cung cấp nào, chúng ta liệt kê năm nhà cung cấp có tỷ lệ đúng hạn thấp nhất." (4127)
6. "Đơn hàng đi qua sáu trung tâm phân loại (sorting hub), từ đây gọi tắt là kho." (4229)

Nêu số liệu
7. "Lượng bán của mỗi mã vì thế gần như không đổi, 5.919 đơn vị một tháng năm 2013 và 6.191 đơn vị năm 2016." (3838)
8. "Hạng A cần tới 40,06% số mã để đạt 80% doanh thu." (4066)
9. "Ở kho Hà Nội, tỷ lệ đúng hạn giảm khoảng 14 điểm phần trăm khi chuyển sang nhóm này." (4547)
10. "Ở sự kiện lớn, gần một phần ba số đơn giao trễ." (4415)
11. "Tính chung mọi đơn, tỷ lệ đúng hạn mỗi năm chỉ khoảng 81% đến 83%, thấp hơn nhiều so với trung vị 97,30% theo nhà cung cấp." (4127)

Công thức bằng lời
12. "Tỷ lệ tải (workload ratio) là khối lượng việc cần xử lý trong ngày chia cho năng lực xử lý của kho." (4462)
13. "Số dương nghĩa là ngành giữ phần vốn lớn hơn phần doanh thu mang về." (4757)

Kết luận vừa tầm số liệu
14. "Trứng, thịt và sữa quay nhanh. Đồ dùng nhà bếp, thực phẩm đông lạnh và văn phòng phẩm quay chậm." (3964)
15. "Khách không đến cửa hàng ít đi, trong khi hàng trăm mã vắng khỏi dữ liệu bán hàng. Vì vậy các đoạn giảm nhiều khả năng do dữ liệu gốc thiếu ghi nhận, không phải do nhu cầu giảm." (3877)
16. "Khoảng cách ảnh hưởng tới tỷ lệ đúng hạn, không ảnh hưởng tới tỷ lệ đủ hàng." ... "Dữ liệu ở phần này chưa đủ để kết luận." (4217)
17. "Hai mốc này do chúng ta tự đặt, không rút ra từ dữ liệu." (4188)
18. "Nếu quên lọc cột này, lead time và tỷ lệ đúng hạn vẫn ra số trông hợp lý nhưng đã lẫn gần một phần mười số đơn không được giao." (4295)
19. "Đoạn dài nhất là nơi đơn hàng tốn nhiều thời gian nhất trong mọi ngày, còn đoạn tăng nhiều nhất mới là nơi ngày cao điểm làm chậm." (6549)

Tiêu đề mục
20. "Nhu cầu theo thời gian." (3809), "Phân bố lead time theo miền." (4297), "Mức tải của kho và lead time." (4462), "Trang xác định kho phân loại chậm nhất" (6210).

Đặc điểm rút ra
- Câu ngắn, một ý một câu; câu dài nhất thường là câu nêu cách tính. Kết luận đứng đầu đoạn, số đứng ngay sau (14, 7).
- Xưng "chúng ta" khi mô tả việc phân tích ("chúng ta đặt…", "chúng ta liệt kê…"); gần như không dùng "ta" trơn, "bạn" chỉ 3 lần cả sách.
- Mở vấn đề bằng khuôn "Để biết …, chúng ta …" (4, 5) hoặc bằng câu hỏi nghiệp vụ trực tiếp (1–3). Không mở bằng "Với mỗi …, hãy …".
- Động từ nghĩa đen: tăng, giảm, quay nhanh/chậm, dồn vào, đọng vốn, giao trễ, chia, so, đặt cạnh. Rất ít ẩn dụ (có "tăng vọt" 5889, "gánh" 6545, dùng thưa).
- Số: phẩy thập phân, chấm hàng nghìn (5.919; 96,8%), tỷ lệ bằng "x trên y" hoặc "một phần ba", hiệu hai tỷ lệ bằng "điểm phần trăm". Không viết "5/54 cửa hàng".
- Thuật ngữ tiếng Anh để trong ngoặc ở lần đầu, sau đó dùng chữ Việt: "giờ chốt đơn (cut-off time)", "đơn tồn đọng (backlog)".
- Luôn nói giới hạn: "nhiều khả năng", "chưa đủ để kết luận", "do bộ sinh dữ liệu", không quy nguyên nhân khi chỉ thấy tương quan.
- Tên bảng, cột viết đúng như DB (`orders`, `is_cancelled`); tên ngành hàng giữ tiếng Anh in hoa (FROZEN FOODS, GROCERY I).

---

## C. Quy tắc giọng văn cho bộ bài

### C.1 Quy tắc chung
1. Viết như giảng viên nói với lớp: câu ngắn xen câu dài, mỗi câu một ý. Câu dài nhất chỉ dùng cho điều kiện dữ liệu.
2. Xưng hô: đề bài viết dạng việc cần làm, không chủ ngữ ("Tính…", "Liệt kê…", "Tìm…"), hoặc "bạn" khi nói tới bản sao/thao tác của học viên. `concept`, `why` có thể dùng "chúng ta". Không dùng "ta" trơn.
3. Mỗi bài dùng thuật ngữ theo mục A, thống nhất từ đầu tới cuối bài (một chặng không lúc là "khâu", lúc là "công đoạn").
4. Tên bảng/cột trong backtick ở mọi trường văn, kể cả hints và takeaway (`sold`, `family`, `inventory_snapshots`). Giá trị chuỗi trong nháy đơn: 'Pass', 'kho vệ tinh'.
5. Số: 8,03%; 2.389 đơn; 1,32 ngày; "x trên y" (5 trên 54 cửa hàng); hiệu tỷ lệ là "điểm phần trăm"; khoảng là "từ a tới b" hoặc "a–b". Không viết tắt TB, SL, KH trong văn.
6. Ngày tháng: "tháng 7/2017", "ngày 11/11/2016", "kỳ 2017-07"; chuỗi lọc giữ nguyên dạng DB ('2017-07-01').
7. Không nhắc "bài giảng", "lab", "sách" trong đề, `why`, `used_in`, takeaway. Nếu số khác tài liệu cũ, một mệnh đề duy nhất: "khác số trong bài giảng vì bài giảng dùng bản dữ liệu cũ" (FIX-RULES §4). Mốc tham chiếu viết "mốc thường dùng trong bán lẻ".
8. Chính tả: "tỷ lệ", "huỷ" (Sách 6644). Các chữ -oa/-oe khác (hóa/hoá) chọn một kiểu cho cả bài.

### C.2 Cấm (cụm và khuôn)
- Cụm cũ: "ứng viên", "cho ta", "mức tier", "phần tử", "So sánh có kiểm soát", "đóng vai trò quan trọng", "hãy cùng", "chìa khoá", "insight", "không chỉ… mà còn", "bức tranh", "đòn bẩy", "bỏ tiền qua cửa sổ", "khớp bài giảng", "Bài giảng đã chỉ ra", "Khuyến nghị:".
- Dấu gạch ngang dài "—" trong văn (dùng dấu phẩy hoặc tách câu).
- Khuôn "mệnh đề: kết luận" (ví dụ "Chỉ số mùa vụ theo thứ: tách…"). Dấu hai chấm chỉ dùng trước một danh sách cột hoặc danh sách điều kiện.
- Câu khẩu hiệu ở cuối takeaway ("Cam kết là chính sách, không phải năng lực.").
- Ẩn dụ động từ: gánh, kéo (lệch/lên/xuống/khách), ăn (thẳng/hết) vào lãi, giam vốn, ôm hàng, thủng hàng, hút khách, phình, nhích, tụt, rơi, chạm mốc/chạm trần, rã tồn, đỡ, cứu. Thay bằng: chiếm, làm lệch, tăng/giảm, đọng vốn, hết hàng, ít lượt giao dịch, đạt mốc, xử lý hết.
- Danh từ dịch máy: phần dự phòng, khoảng hở, phần đuôi (của phân phối), định dạng (cửa hàng), benchmark, scorecard, what-if, forward fill, final mile, traffic, hub đích, mã chết, hàng đứng, độ rộng danh mục, rủi ro tập trung, lập hồ sơ, giữ lời, soi riêng.

### C.3 Khuôn AI / dịch máy còn sót trong baseline-r3 (đếm theo số bài có ít nhất một lần)

| # | Khuôn | Số bài | TRƯỚC (nguyên văn, id) | SAU (giọng sách) |
|---|---|---|---|---|
| K1 | Mở yêu cầu bằng "Với mỗi/Với từng …, tính …" | 22 | e19: "Với mỗi kho, tính trên toàn bộ giai đoạn trong bảng: số ngày có ít nhất một người vắng, và tỷ lệ vắng mặt (%) bằng tổng số người vắng chia tổng quân số kế hoạch." | "Kho nào hay thiếu người? Tính cho từng kho, trên toàn bộ giai đoạn của bảng, số ngày có ít nhất một người vắng và tỷ lệ vắng mặt (%), bằng tổng số người vắng chia tổng nhân sự kế hoạch." (mỗi bài mở một kiểu: câu hỏi, tình huống, "Để biết…") |
| K2 | Mệnh lệnh "Hãy …" | 20 | a04: "Trước khi giao, hãy kiểm tra các định dạng có thật sự khác nhau không." | "Trước khi giao chỉ tiêu, cần kiểm tra vòng quay tồn kho của các loại cửa hàng có khác nhau thật không." |
| K3 | "trong khi" nối hai vế đối lập, nhiều lần trong một bài | 19 | a07: "Gộp chín nhóm, 14,03 trên 20,61 triệu USD tồn hàng dễ hỏng (khoảng 68%) nằm trên định mức 14 ngày, trong khi tỷ lệ dòng thiếu hàng chỉ từ 0,46% tới 2,61%." | "Gộp chín ngành hàng tươi sống, 14,03 trên 20,61 triệu USD vốn tồn (khoảng 68%) nằm trên định mức 14 ngày. Tỷ lệ dòng thiếu hụt của các ngành này chỉ từ 0,46% tới 2,61%." (tối đa một "trong khi" mỗi bài; thường thay bằng "còn" hoặc tách câu) |
| K4 | Ẩn dụ động từ (gánh, kéo, ăn, giam, thủng, hút, nhích, vọt, tụt, chạm) | 38 | e20: "Biên mỏng thì bán nhiều mà lãi ít, và mỗi đơn vị hàng hỏng hay giảm giá ăn thẳng vào lãi." / m12: "Tiền thuê trên mỗi lượt khách cho biết mỗi người bước vào cửa hàng phải gánh bao nhiêu chi phí mặt bằng." | "Biên lợi nhuận gộp thấp thì bán nhiều mà lợi nhuận gộp ít, và mỗi đơn vị hàng hỏng hay giảm giá làm lợi nhuận gộp giảm ngay." / "Tiền thuê trên mỗi lượt giao dịch cho biết mỗi lượt thanh toán ứng với bao nhiêu tiền thuê mặt bằng." |
| K5 | Khuôn chốt đối lập "X là …, chưa phải/chứ chưa phải Y" | 15 | d09: "1.188 mã hạng C góp 5% doanh thu là danh sách để rà, chưa phải danh sách cắt." | "1.188 mã hạng C mang về 5% doanh thu. Đây là danh sách để rà soát; muốn cắt mã nào còn cần thêm số liệu về mã đó." (mỗi bài tối đa một câu nêu giới hạn, nói thẳng điều còn thiếu) |
| K6 | Câu dạy đời cuối takeaway "Muốn … thì phải …", "Vì vậy báo cáo nên kèm …" lặp ở nhiều bài | 16 | m03: "Muốn chọn nhóm cần sửa trước thì phải xem cả tỷ lệ lẫn lượng thiếu." | "Xếp theo tỷ lệ dòng thiếu hụt và xếp theo tổng thiếu hụt cho hai thứ tự khác nhau." (câu cuối nêu điều số liệu cho thấy; khuyên hành động chỉ khi gắn với một con số trong bài) |
| K7 | Danh từ dịch máy / tiếng Anh dịch từng chữ | 24 | d04: "Phân vị (percentile) cho biết phần đuôi chậm của phân phối mà số trung bình che mất." | "Phân vị cho biết những đơn chậm nhất chậm tới đâu, điều mà số trung bình không cho thấy." Các cặp khác: d03 "phần dự phòng" → "thời gian dư so với cam kết"; d04 "khoảng hở" → "cam kết trừ P95"; d01 "benchmark trong nhóm" → "so với các cửa hàng cùng loại"; d06 "Supplier scorecard" → "điểm NCC"; m14 "(forward fill)" → "lấp bằng giá gần nhất trước đó"; d12 "(final mile)" → bỏ; e12 "Traffic" → "lượt giao dịch"; m16 "Độ rộng danh mục (assortment)" → "số mã hàng có bán"; d10 "thủng hàng" → "hết hàng"; d20 "rã tồn đọng" → "xử lý hết đơn tồn đọng"; a05 "lập hồ sơ" → "lập bảng" |
| K8 | `concept` mở bằng câu cụt không vị ngữ hoặc khuôn "X: giải thích" | 12 | d15: "Rủi ro tập trung trong mạng lưới phân phối." / d07: "Chỉ số mùa vụ theo thứ: tách nhịp tuần ra khỏi xu hướng bằng cách chia số thực tế cho đường trung bình trượt 7 ngày." | "Khi mỗi vùng chỉ có một DC, sự cố ở DC đó buộc cửa hàng phải nhận hàng từ vùng khác." / "Chỉ số mùa vụ theo thứ tách nhịp tuần ra khỏi xu hướng. Cách tính là chia lượt giao dịch thực tế cho trung bình trượt 7 ngày." |
| K9 | Nhắc bài giảng, lab, "mốc bài giảng" | 12 | m01: "Bài giảng phải loại cửa hàng 52 trước khi tính ITR, vì với 118 ngày dữ liệu nó ra ITR 33,7." / e14: "Mốc tham chiếu trong bài giảng là từ 95% trở lên." | "Cửa hàng 52 chỉ có 118 ngày dữ liệu; quy ra năm mà không loại cửa hàng này thì vòng quay tồn kho lên tới 33,7." / "Mốc thường dùng trong bán lẻ là từ 95% trở lên." |
| K10 | "cầu" đứng một mình thay "nhu cầu" | 18 | a11: "Cầu là tổng `sold` (cầu thật, chưa trừ phần thiếu)" | "Nhu cầu là tổng `sold` (chưa trừ phần thiếu hụt)" |
| K11 | Chuỗi giải thích nối dài bằng "tức/nghĩa là/nên… nên…" (27 bài có, cần rà từng câu) | 27 | e08: "…cách Đà Nẵng (108,20) gần 1,7 độ về phía tây, tức đã sang đất Lào." | "…lệch gần 1,7 độ về phía tây so với kinh độ của Đà Nẵng (108,20). Điểm này đã nằm trên đất Lào." (mỗi câu tối đa một "nên"; "tức là" chỉ dùng để đổi đơn vị hoặc diễn lại một con số) |
| K12 | Tiếng Anh lẫn trong văn: sale, tier, lift, last-mile, traffic | 15 | m04 (tiêu đề): "Ngày sale, kho thêm bao nhiêu người?" | "Ngày cao điểm, kho thêm bao nhiêu người?" |
| K13 | Ký hiệu thay chữ: "5/54", "TB", "điểm" thiếu "phần trăm" | 16 | m06: "Chỉ 5/54 cửa hàng có OTIF dưới 80%" / a15: "vế đúng hạn chỉ hụt 1,29 điểm còn vế đủ số hụt 7,33 điểm" / m01: "Lượt khách TB/ngày = tổng lượt khách / số ngày có giao dịch." | "Chỉ 5 trên 54 cửa hàng có OTIF dưới 80%" / "tỷ lệ đúng hạn chỉ thiếu 1,29 điểm phần trăm so với 100%, còn tỷ lệ đủ hàng thiếu 7,33 điểm phần trăm" / "Lượt giao dịch trung bình mỗi ngày = tổng lượt giao dịch / số ngày có giao dịch." |
| K14 | Bị động "bị coi là" và đảo nhấn "… mới biết/mới là" | 3 + 13 | m10: "Một PO bị coi là trễ khi lead time thực tế lớn hơn `promised_lead_days` của NCC." / m06: "Tách hai vế ra mới biết phải sửa khâu vận chuyển hay khâu soạn hàng." | "Đơn mua giao trễ khi lead time thực tế lớn hơn `promised_lead_days` của NCC." / "Tách hai vế thì biết cần sửa khâu vận chuyển hay khâu soạn hàng." |
| K15 | Thuật ngữ lệch sách (nhóm hàng, hàng dễ hỏng, định dạng, lãi gộp, hub vệ tinh, DC chính, đủ số, quân số, hệ số cầu, ITR/DIO, lượt khách) | 49 | e02: "Ba kho là DC chính, ba kho còn lại là hub vệ tinh đặt ở thành phố khác và trực thuộc một DC (cột `dc_parent`)." | "Ba kho chính đặt ở Hà Nội, Đà Nẵng và TP.HCM; ba kho vệ tinh đặt ở thành phố khác, mỗi kho trực thuộc một kho chính (cột `dc_parent`)." |

### C.4 Việc của từng trường
- `statement`: 1–2 câu tình huống (ai cần gì, vì sao), rồi điều kiện dữ liệu (bảng, cột, khoảng thời gian, cách hiểu chỉ số), rồi yêu cầu bằng một động từ. Nêu rõ cột nào là nhu cầu, cột nào là lượng bán (FIX-RULES §1).
- `output`: chỉ kỹ thuật: số cột, tên cột, làm tròn, thứ tự, tiêu chí phụ. Không văn giải thích.
- `concept`: 1–2 câu đầy đủ chủ ngữ, vị ngữ, định nghĩa khái niệm nghiệp vụ.
- `formula`: công thức nghiệp vụ "A = B / C" hoặc bằng lời như Sách 4462, không chứa mẹo SQL.
- `why`: vì sao doanh nghiệp quan tâm, 1–2 câu, không nhắc bài giảng.
- `used_in`: xem mục E.
- `hints`: gợi ý 1 hướng nghĩ nghiệp vụ, gợi ý 2 bẫy dữ liệu, gợi ý 3 kỹ thuật bằng lời; không viết sẵn SQL.
- `takeaway`: 1–3 câu; câu đầu nêu kết quả chính có số; câu sau so sánh hoặc nêu ngoại lệ; tối đa một câu nêu giới hạn. Không khẩu hiệu, không câu dạy đời lặp khuôn.

---

## D. Quy tắc tiêu đề bài

- Dạng câu hỏi nghiệp vụ ngắn ("Kho nào thiếu người vào ngày cao điểm?") hoặc cụm danh từ tự nhiên như tiêu đề mục của sách ("Lead time theo loại ngày", "Đánh giá nhà cung cấp").
- Tối đa 10 tiếng (đếm theo khoảng trắng). Không dấu hai chấm, không hai vế "…bao nhiêu, …bao nhiêu?".
- Dùng thuật ngữ mục A; không "sale", "hub", "định dạng", "last-mile" trong tiêu đề. Mã kho, số cửa hàng giữ khi cần (cửa hàng 44).
- Không dịch từng chữ từ tiếng Anh; không chuỗi "của mỗi … của …".

| id | TRƯỚC | SAU |
|---|---|---|
| e02 | Hub vệ tinh của từng DC | Kho vệ tinh trực thuộc kho chính nào? |
| e03 | Điểm giao gánh gần hết đơn của thành phố | Điểm giao nhận từ 90% số đơn của thành phố |
| e05 | Đếm cửa hàng theo định dạng | Mỗi loại cửa hàng có bao nhiêu cửa hàng? |
| e20 | Biên lãi gộp của các nhóm hàng lớn | Biên lợi nhuận gộp của các ngành hàng lớn |
| m17 | Khuyến mãi kéo cầu lên bao nhiêu? | Khuyến mãi làm lượng bán tăng bao nhiêu? |
| d02 | Ba mặt hàng chủ lực của mỗi nhóm hàng dễ hỏng | Mỗi ngành hàng tươi sống dựa vào mấy mã hàng? |
| d04 | Lead time last-mile: P95 so với mức cam kết | P95 lead time chặng cuối có vượt cam kết? |
| d12 | Điểm giao xa hub: khâu cuối dài thêm bao nhiêu, cam kết nới thêm bao nhiêu? | Giao càng xa kho, cam kết có nới theo kịp? |
| d13 | Định dạng cửa hàng nào khuếch đại dao động khi nhập hàng? | Bullwhip theo loại cửa hàng năm 2016 |
| d20 | DC Hà Nội mất bao lâu để rã tồn đọng sau ngày sale? | Bao lâu kho Hà Nội hết đơn tồn đọng? |

---

## E. Trường mới `lesson.used_in` ("Dùng ở đâu")

- 1–2 câu, đủ ba ý: AI dùng (vai trò cụ thể trong công ty bán lẻ hoặc logistics Việt Nam: nhân viên mua hàng, trưởng phòng mua hàng, nhân viên kế hoạch nhu cầu, trưởng ngành hàng, quản lý vùng, quản lý cửa hàng, trưởng kho, điều phối vận hành, kế toán quản trị, giám đốc tài chính); Ở ĐÂU (báo cáo tuần hoặc tháng, trang tồn kho hay trang nhà cung cấp của dashboard, họp S&OP hằng tháng, đánh giá NCC cuối quý, họp giao ban kho, họp kế hoạch dịp cao điểm); ĐỂ QUYẾT ĐỊNH GÌ (đặt thêm hay giảm đơn mua, đổi NCC, tăng ca, điều chuyển hàng, giữ hay đổi cách dự báo).
- Không lặp ý của `why` (`why` trả lời "vì sao quan trọng", `used_in` trả lời "ai, ở đâu, quyết gì").
- Không nhắc lab, sách, bài giảng; không số liệu; không tên công ty thật.

Ví dụ
1. m10 (lead time NCC): "Nhân viên mua hàng đưa bảng này vào buổi đánh giá nhà cung cấp cuối quý, để quyết định NCC nào bị nhắc nhở, NCC nào giảm tỷ trọng đơn mua, và lead time cam kết nào cần ghi lại trong hợp đồng."
2. m05 (ngày quá tải kho): "Trưởng kho và điều phối vận hành xem số ngày quá tải của từng kho trong họp giao ban kho hằng tuần, để quyết định tăng ca, thuê thời vụ hay chuyển bớt đơn sang kho khác."
3. d14 (dự báo tháng trước hay cùng kỳ): "Nhân viên kế hoạch nhu cầu trình WMAPE và bias của từng ngành hàng trong họp S&OP hằng tháng, để chọn cách dự báo cho mỗi ngành và chỉ ra ngành nào cần người duyệt tay trước khi đặt hàng."

---

## F. Năm bài viết lại hoàn chỉnh (để giảng viên duyệt hướng viết)

Chỉ đổi văn. Điều kiện lọc, số liệu, tên cột output giữ nguyên.

### F1. scm-e05 (Easy)
TRƯỚC
- Tiêu đề: Đếm cửa hàng theo định dạng
- Đề: Công ty xếp mỗi cửa hàng vào một định dạng (cột `type`, từ A tới E) theo quy mô và cách vận hành. Đếm số cửa hàng của từng định dạng trong bảng `stores`.
- Takeaway: Định dạng D đông nhất với 18 cửa hàng, E chỉ có 4. Trung bình của nhóm E dựa trên 4 cửa hàng, nên chỉ một cửa hàng bất thường cũng đủ kéo lệch cả nhóm. Khi so doanh thu hay lượt khách giữa các định dạng, luôn ghi kèm số cửa hàng của từng nhóm.

SAU
- Tiêu đề: Mỗi loại cửa hàng có bao nhiêu cửa hàng?
- Đề: Công ty chia cửa hàng thành năm loại, từ A tới E, theo quy mô và cách vận hành (cột `type` của bảng `stores`). Trước khi so doanh thu hay lượt giao dịch giữa các loại, chúng ta cần biết mỗi loại có bao nhiêu cửa hàng. Đếm số cửa hàng của từng loại.
- Takeaway: Loại D có nhiều cửa hàng nhất, 18 cửa hàng, còn loại E chỉ có 4. Trung bình của loại E chỉ dựa trên 4 cửa hàng, nên một cửa hàng có tháng bất thường đủ làm số của cả loại thay đổi. Bảng so sánh giữa các loại cửa hàng vì vậy cần ghi kèm số cửa hàng.

### F2. scm-m17 (Medium)
TRƯỚC
- Tiêu đề: Khuyến mãi kéo cầu lên bao nhiêu?
- Đề: Cột `onpromotion` của `sales` cho biết mặt hàng có đang khuyến mãi tại cửa hàng đó vào ngày đó không. Trong tháng 7/2017, chỉ tính dòng `unit_sales` > 0, so số lượng bán trung bình mỗi dòng (một mặt hàng ở một cửa hàng trong một ngày) giữa dòng có và không có khuyến mãi, theo từng nhóm hàng. Chỉ giữ các nhóm có ít nhất 500 dòng khuyến mãi, để kết quả không bị vài dòng lẻ quyết định.
- Takeaway: Lift chênh nhau rất xa giữa các nhóm. CLEANING tăng 264,9%, BEVERAGES 163,9%, GROCERY I 100,1%, trong khi DAIRY chỉ 6,8%, DELI 1,9% và HOME AND KITCHEN I còn âm 7,6%. HOME AND KITCHEN II cao nhất (504,5%) nhưng chỉ dựa trên 965 dòng khuyến mãi, nên con số này kém chắc hơn các nhóm lớn.

SAU
- Tiêu đề: Khuyến mãi làm lượng bán tăng bao nhiêu?
- Đề: Phòng marketing muốn biết khuyến mãi làm lượng bán của từng ngành hàng tăng bao nhiêu. Cột `onpromotion` của `sales` cho biết một mã hàng có đang khuyến mãi tại một cửa hàng trong một ngày hay không. Lấy tháng 7/2017 và chỉ tính các dòng có `unit_sales` > 0. Tính cho từng ngành hàng (`family`) số lượng bán trung bình mỗi dòng (một mã hàng, một cửa hàng, một ngày) ở các dòng có khuyến mãi và ở các dòng không khuyến mãi. Chỉ giữ ngành hàng có ít nhất 500 dòng khuyến mãi, để kết quả không phụ thuộc vào vài dòng lẻ.
- Takeaway: Mức tăng lượng bán khi khuyến mãi (lift) khác nhau rất xa giữa các ngành hàng. CLEANING tăng 264,9%, BEVERAGES 163,9% và GROCERY I 100,1%; DAIRY chỉ tăng 6,8%, DELI 1,9%, còn HOME AND KITCHEN I giảm 7,6%. HOME AND KITCHEN II có lift cao nhất, 504,5%, nhưng chỉ tính trên 965 dòng khuyến mãi, nên con số này kém chắc hơn số của các ngành lớn.

### F3. scm-d02 (Difficult)
TRƯỚC
- Tiêu đề: Ba mặt hàng chủ lực của mỗi nhóm hàng dễ hỏng
- Đề: Phòng mua hàng muốn biết mỗi nhóm hàng dễ hỏng phụ thuộc vào vài mặt hàng chủ lực tới mức nào. Xét năm 2016 (`ym` từ '2016-01' đến '2016-12'), chỉ các mặt hàng có `items.perishable = 1`. Trong `inventory_snapshots`, `sold` là cầu của tháng (đã bỏ phần trả hàng), còn phần cầu không đáp ứng được vì hết hàng nằm ở `thieu_hut`. Doanh thu chỉ tính trên hàng bán được, nên doanh thu năm của một mặt hàng = tổng (`sold` − `thieu_hut`) cả mạng trong năm × `item_costs.unit_price` (giá cố định của mặt hàng). Chỉ xét mặt hàng có doanh thu năm 2016 lớn hơn 0. Trong mỗi nhóm hàng, xếp mặt hàng theo doanh thu giảm dần (bằng nhau thì item_nbr nhỏ trước) và lấy 3 mặt hàng đầu.
- Takeaway: Ba nhóm SEAFOOD, EGGS và PREPARED FOODS tập trung rất cao, ba mặt hàng đầu chiếm 66,55%, 41,85% và 44,14% doanh thu nhóm; riêng mặt hàng số 1 của EGGS đã chiếm 27,82%. Ngược lại ở DAIRY (233 mặt hàng), BREAD/BAKERY (134) và PRODUCE (304), ba mặt hàng đầu chỉ góp 10,51–14,03%. Cùng là hàng dễ hỏng mà mức phụ thuộc vào vài mặt hàng chủ lực khác nhau rất xa giữa các nhóm.

SAU
- Tiêu đề: Mỗi ngành hàng tươi sống dựa vào mấy mã hàng?
- Đề: Phòng mua hàng muốn biết doanh thu của mỗi ngành hàng tươi sống tập trung vào vài mã hàng dẫn đầu tới mức nào. Xét năm 2016 (`ym` từ '2016-01' đến '2016-12') và chỉ các mã hàng có `items.perishable = 1`. Trong `inventory_snapshots`, `sold` là nhu cầu của tháng (đã bỏ phần trả hàng), còn phần nhu cầu không đáp ứng được vì hết hàng nằm ở `thieu_hut`. Doanh thu chỉ tính trên lượng bán được: doanh thu năm của một mã hàng bằng tổng (`sold` − `thieu_hut`) của cả mạng trong năm nhân `item_costs.unit_price` (giá cố định của mã hàng). Chỉ xét mã hàng có doanh thu năm 2016 lớn hơn 0. Trong mỗi ngành hàng, xếp mã hàng theo doanh thu giảm dần (bằng nhau thì `item_nbr` nhỏ đứng trước) và lấy 3 mã đầu.
- Takeaway: Ở SEAFOOD, EGGS và PREPARED FOODS, ba mã hàng đầu chiếm 66,55%, 41,85% và 44,14% doanh thu của ngành; riêng mã số 1 của EGGS đã chiếm 27,82%. Ở DAIRY (233 mã hàng), BREAD/BAKERY (134) và PRODUCE (304), ba mã đầu chỉ chiếm 10,51–14,03%. Cùng là hàng tươi sống, nhưng mức tập trung doanh thu vào vài mã dẫn đầu khác nhau rất xa giữa các ngành.

### F4. scm-d03 (Difficult)
TRƯỚC
- Tiêu đề: Kênh cửa hàng và kênh online: ai giao đúng hạn hơn?
- Đề: Công ty giao hàng từ 3 DC theo hai kênh: kênh cửa hàng (bảng `shipments`, DC giao cho cửa hàng theo tuần, cam kết `promised_days`) và kênh online (bảng `orders`, DC giao tới khách, cam kết `promised_h` giờ). Hãy đặt hai kênh cạnh nhau cho nửa đầu năm 2017. Kênh cửa hàng: các tuần có `week` bắt đầu từ 2017-01-02 đến 2017-06-26, DC là `warehouse_id`, thời gian giao là `actual_days`. Kênh online: đơn có `order_date` từ 2017-01-01 đến 2017-06-30, không huỷ, DC là `origin_hub_id`, thời gian giao là `lead_time_total_h` / 24, cam kết là `promised_h` / 24. Với mỗi DC và mỗi kênh, tính số lượt giao, tỷ lệ đúng hạn (trung bình `on_time`), thời gian giao trung bình, cam kết trung bình và phần dự phòng = cam kết trung bình − thời gian giao trung bình. Cuối cùng, trong mỗi kênh, xếp hạng ba DC theo tỷ lệ đúng hạn giảm dần (dùng RANK, cao nhất là hạng 1).
- Takeaway: Ở cả ba DC, kênh online giao nhanh hơn kênh cửa hàng (Hà Nội 1,32 so với 1,46 ngày) nhưng tỷ lệ đúng hạn lại thấp hơn (95,88% so với 97,82%), vì cam kết online trung bình chỉ 2,61–2,77 ngày nên phần dự phòng còn 1,21–1,31 ngày, mỏng hơn kênh cửa hàng (1,41–1,54 ngày). Thứ hạng DC cũng đảo chiều giữa hai kênh, DC_DANANG đứng cuối kênh cửa hàng (trên 182 chuyến) nhưng đứng đầu kênh online. Vì thế muốn so hai kênh phải đặt tỷ lệ đúng hạn cạnh mức cam kết.

SAU
- Tiêu đề: Kênh cửa hàng hay kênh online giao đúng hạn hơn?
- Đề: Công ty giao hàng từ 3 DC theo hai kênh. Kênh cửa hàng nằm ở bảng `shipments`: DC giao cho cửa hàng theo tuần, cam kết là `promised_days`. Kênh online nằm ở bảng `orders`: DC giao tới khách, cam kết là `promised_h` giờ. Để so hai kênh trong nửa đầu năm 2017, lấy dữ liệu như sau. Kênh cửa hàng: các tuần có `week` bắt đầu từ 2017-01-02 đến 2017-06-26, DC là `warehouse_id`, thời gian giao là `actual_days`. Kênh online: đơn có `order_date` từ 2017-01-01 đến 2017-06-30, không huỷ, DC là `origin_hub_id`, thời gian giao là `lead_time_total_h` / 24, cam kết là `promised_h` / 24. Tính cho từng DC trong từng kênh: số lượt giao, tỷ lệ giao đúng hạn (trung bình `on_time`), thời gian giao trung bình, cam kết trung bình và thời gian dư so với cam kết, bằng cam kết trung bình trừ thời gian giao trung bình. Cuối cùng, xếp hạng ba DC trong mỗi kênh theo tỷ lệ giao đúng hạn giảm dần (dùng RANK, cao nhất là hạng 1).
- Takeaway: Ở cả ba DC, kênh online giao nhanh hơn kênh cửa hàng (Hà Nội 1,32 so với 1,46 ngày) nhưng tỷ lệ giao đúng hạn lại thấp hơn (95,88% so với 97,82%). Cam kết online trung bình chỉ 2,61–2,77 ngày, nên thời gian dư còn 1,21–1,31 ngày, ít hơn kênh cửa hàng (1,41–1,54 ngày). Thứ hạng DC cũng đảo chiều giữa hai kênh. DC_DANANG đứng cuối kênh cửa hàng (tính trên 182 chuyến) nhưng đứng đầu kênh online.

### F5. scm-a05 (Advanced)
TRƯỚC
- Tiêu đề: Có nên đóng các cửa hàng doanh thu/m² thấp nhất?
- Đề: Một thành viên hội đồng quản trị đề xuất đóng các cửa hàng có doanh thu trên mỗi mét vuông thấp nhất. Bài giảng dặn chỉ đóng khi hội đủ ba điều: thua sâu trong cụm, tiền thuê chiếm phần lớn doanh thu, và nguyên nhân là thiếu khách. Bài này dùng một biến thể: so lượt khách với các cửa hàng cùng `type` thay cho cụm K-Means, và đo gánh nặng thuê bằng tiền thuê trên lãi gộp, chặt hơn tiền thuê trên doanh thu. Hãy lập hồ sơ tháng 7/2017 cho 5 cửa hàng có doanh thu/m² thấp nhất. Doanh thu và lãi gộp tính từ `sales` tháng 7/2017 với `unit_price`, `unit_cost` của `item_costs`, tính cả dòng trả hàng; `area_m2`, `rent_month_usd`, `city` và `type` lấy từ `store_attributes`; lượt khách lấy từ `transactions` tháng 7/2017.
- Takeaway: Năm cửa hàng thấp nhất là 35, 32, 30, 13 (`type` C) và 18 (`type` B), nhưng tiền thuê chỉ bằng 5,73% tới 8,10% lãi gộp (khoảng 1,5% tới 2,1% doanh thu), nên điều kiện thuê nặng không thoả, vì đóng cửa chỉ tiết kiệm chưa tới một phần mười lãi gộp mà mất cả phần còn lại. Cửa hàng 35, 32, 30 ít khách hơn trung vị `type` C (891,8 lượt/ngày) từ 19,6% tới 31,5% và cửa hàng 18 ít hơn trung vị `type` B 19,9%, còn cửa hàng 13 đông đúng bằng trung vị `type`, nên bốn nơi đầu cần kéo khách, riêng cửa hàng 13 cần xem lại trưng bày và danh mục. Bảng mới có một tháng và chưa có chi phí nhân sự, điện nước, nên đây là căn cứ để rà soát chứ chưa đủ để quyết đóng.

SAU
- Tiêu đề: Có nên đóng các cửa hàng doanh thu/m² thấp nhất? (giữ nguyên, đã đạt quy tắc D)
- Đề: Một thành viên hội đồng quản trị đề xuất đóng các cửa hàng có doanh thu trên mỗi m² thấp nhất. Một cửa hàng chỉ nên được cân nhắc đóng khi hội đủ ba điều kiện: kém hẳn các cửa hàng tương đồng, tiền thuê chiếm phần lớn doanh thu, và nguyên nhân là thiếu khách. Bài này đo ba điều kiện theo cách riêng: so lượt giao dịch với các cửa hàng cùng `type` (thay cho cụm K-Means), và đo áp lực tiền thuê bằng tiền thuê trên lợi nhuận gộp, chặt hơn tiền thuê trên doanh thu. Lập bảng tháng 7/2017 cho 5 cửa hàng có doanh thu/m² thấp nhất. Doanh thu và lợi nhuận gộp tính từ `sales` tháng 7/2017 với `unit_price`, `unit_cost` của `item_costs`, tính cả dòng trả hàng; `area_m2`, `rent_month_usd`, `city` và `type` lấy từ `store_attributes`; lượt giao dịch lấy từ `transactions` tháng 7/2017.
- Takeaway: Năm cửa hàng thấp nhất là 35, 32, 30, 13 (loại C) và 18 (loại B), nhưng tiền thuê chỉ bằng 5,73% tới 8,10% lợi nhuận gộp (khoảng 1,5% tới 2,1% doanh thu), nên điều kiện tiền thuê cao không thoả; đóng cửa hàng chỉ tiết kiệm chưa tới một phần mười lợi nhuận gộp và mất luôn phần còn lại. Cửa hàng 35, 32 và 30 có ít lượt giao dịch hơn trung vị loại C (891,8 lượt/ngày) từ 19,6% tới 31,5%, cửa hàng 18 ít hơn trung vị loại B 19,9%, còn cửa hàng 13 đúng bằng trung vị của loại mình, nên bốn cửa hàng đầu cần thêm khách, riêng cửa hàng 13 cần xem lại trưng bày và danh mục. Bảng mới có một tháng và chưa tính chi phí nhân sự, điện nước, nên chỉ đủ làm căn cứ rà soát, chưa đủ để quyết định đóng cửa hàng.

---

## G. Điểm còn phân vân (cần giảng viên chốt)
1. `sold`: Sách 6621 gọi là "bán trong kỳ"; FIX-RULES §1 và MO-TA v2 (dòng 186) nói `sold` là nhu cầu thật. Bộ chuẩn này theo FIX-RULES vì đó là ngữ nghĩa cột đã kiểm trên DB.
2. "hàng tươi sống" cho cả 9 ngành `perishable` = 1 (có BREAD/BAKERY, DAIRY, EGGS): theo Sách 6611, trái FIX-RULES §2 ("hàng dễ hỏng"). Cách gọi "NCC cam kết 3 ngày" vẫn giữ.
3. "thời gian chưa gán" (Sách 4328) thay cho "thời gian chờ giữa các khâu" của bộ bài.
4. "lượt giao dịch" (sách) thay "lượt khách" làm tên chỉ số; "đông khách" vẫn dùng khi nói chung.
5. Số ngày tồn kho viết là DSI (sách), trong khi tên cột output của bộ bài là `dio`, `dio_trung_vi`.
6. bias dự báo, lift, phương pháp trọng tâm: không tìm được giáo trình ĐH Việt Nam (NEU, UEH, FTU) trực tuyến; tạm giữ tiếng Anh kèm giải nghĩa.
7. "trong khi" sách dùng 33 lần: bộ chuẩn chỉ giới hạn một lần mỗi bài, không cấm. "ứng viên" sách có dùng (4068) nhưng vẫn cấm theo BRIEF.

---

## H. QUYẾT ĐỊNH CỦA GIẢNG VIÊN (07/11/2026) – GHI ĐÈ mục G và mọi chỗ mâu thuẫn trong BRIEF.md / FIX-RULES.md

1. Hướng viết ở mục A–F: ĐÃ DUYỆT. Viết lại cả 80 bài theo bộ chuẩn này.
2. `perishable = 1` (9 ngành, kể cả DAIRY, BREAD/BAKERY, EGGS): gọi là **hàng tươi sống**; còn lại là **hàng khô** (theo sách). "NCC cam kết 3 ngày" giữ nguyên cách gọi.
3. Cột `sold` = **lượng bán trong kỳ** (lượng bán đã ghi nhận), theo sách dòng 3633–3644: tổng `sold` chỉ hơn bảng `sales` 1.274 đơn vị, nên `sold` KHÔNG phải nhu cầu. Cột `thieu_hut` = **lượng thiếu hụt**: phần bán vượt quá lượng hàng sẵn có trong phần tồn kho mô phỏng, được cộng bù để tồn cuối kỳ không âm.
   - THAY FIX-RULES §1. Doanh thu, giá vốn, vòng quay, DSI, GMROI, ABC theo doanh thu, tăng trưởng doanh thu tính trên `sold` (KHÔNG trừ `thieu_hut`), đúng như sách.
   - Dự báo, CV/XYZ, bullwhip, số ngày phủ: dùng `sold` và gọi là lượng bán (không gọi là "nhu cầu thật"). Có thể nói "lượng bán dùng làm thước đo nhu cầu" khi cần.
   - Fill rate (d10): 1 − tổng `thieu_hut` / tổng `sold` = phần lượng bán được phục vụ từ hàng sẵn có. Tỷ lệ dòng thiếu hụt = số dòng có `thieu_hut` > 0 / số dòng.
   - BÀI PHẢI ĐỔI ĐÁP ÁN (bỏ "− thieu_hut" trong reference_sql, chạy lại, cập nhật số trong takeaway): m19, d02, d08, d16, a04, a06.
   - BÀI CHỈ SỬA CHỮ (đang viết `sold` là nhu cầu): d10, d13, a07, a08, a11 (và mọi chỗ khác gặp).
4. Số ngày tồn kho: trong văn viết "số ngày tồn kho (DSI)"; tên cột output vẫn là `dio`, `dio_trung_vi` (không đổi SQL vì việc này).
5. "thời gian chưa gán" (sách) thay cho "thời gian chờ giữa các khâu"; "lượt giao dịch" là tên chỉ số (thay "lượt khách"); bias / lift / phương pháp trọng tâm: giữ tiếng Anh, giải nghĩa tiếng Việt ở lần đầu trong bài; "trong khi" tối đa một lần mỗi bài; "ứng viên" vẫn cấm.
6. Dòng cuối tab Nghiệp vụ: `lesson.used_in` ("Dùng ở đâu") theo mục E. XOÁ `lesson.lab`. Không nhắc lab, sách, bài giảng ở bất cứ trường nào.
7. (Sau review vòng 3) ĐƯỢC đổi TÊN CỘT kết quả còn dùng từ cũ (ví dụ `so_nhom_hang` → `so_nganh_hang`, `bien_lai_pct` → `bien_ln_gop_pct`, `luot_khach_*` → `luot_gd_*`, `ty_le_het_hang_pct` → `ty_le_thieu_hut_pct`): đổi CÙNG LÚC alias trong `reference_sql`/`expected_state_sql`/`sample_sql` và trong `output`. Máy chấm không so tên cột; GIÁ TRỊ, số cột, thứ tự cột, thứ tự dòng phải giữ nguyên – kiểm bằng check_same_answers.py. Bài dml: tên cột bảng mẫu học viên dùng trong DML (ví dụ `qua_tai`, `inspection_result`) KHÔNG đổi.
8. `used_in`: tránh khuôn đúc "<vai trò> xem … trong <họp> …, để quyết định …" lặp trên nhiều bài; viết đa dạng (có bài nói quyết định trước, có bài nói người dùng, có câu ngắn), đúng người có quyền quyết (kế toán không quyết giảm đơn mua; quyết đầu tư không đặt ở họp giao ban tuần).
