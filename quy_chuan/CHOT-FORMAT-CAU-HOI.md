# CHỐT · Format câu hỏi SQL Leaderboard

Cập nhật: 09/11/2026. File này ghi các quyết định đã chốt về format câu hỏi, chuẩn soạn và cách chấm, để thread khác của dự án dùng tiếp mà không cần đọc lại lịch sử. Lộ trình xem `CHOT-LO-TRINH.md`.

## 1. Bối cảnh

- Leaderboard luyện SQL cho học viên Data Analyst (AIVN), giảng viên yêu cầu. Bộ dữ liệu đầu tiên: **Datathon 2026 Round 1**, công ty thời trang bán online, 14 bảng, 04/07/2012–31/12/2022, khoảng 2,2 triệu dòng. **Dữ liệu private**: `data.zip` + `Data Understanding.pdf` ở thư mục gốc, không đưa ra ngoài.
- **Engine chấm: MySQL 8.0** (chốt 08/11/2026). Mọi SQL trong gói viết theo cú pháp MySQL.

## 2. Hình thức và cấp độ

| Hình thức (`hinhthuc`) | Học viên làm gì | Chấm |
|---|---|---|
| `write` Viết truy vấn | Viết SQL ra đúng bảng kết quả | So kết quả trên mọi biến thể dữ liệu khai báo |
| `debug` Sửa lỗi | Nhận truy vấn chạy được nhưng **sai kết quả**, sửa cho đúng | Như write; truy vấn khởi đầu phải sai |
| `optimize` Tối ưu truy vấn | Nhận truy vấn **đúng nhưng chậm**, viết lại cùng kết quả và thoả ràng buộc | Kết quả + số lần quét bảng + dòng trung gian (EXPLAIN ANALYZE), không đo thời gian |
| `case` Case study | Nhiều bước viết SQL nối nhau, bước cuối chọn kết luận | Cộng điểm từng bước; bước sau mở khi bước trước đúng |

- **Đã loại:** Diễn giải insight (chọn kết luận không viết SQL; phần này chuyển vào bước cuối của case), Đoán kết quả, Điền chỗ trống.
- **Cấp (`cap`):** `basic` Cơ bản 10 · `easy` Dễ 20 · `medium` Trung bình 30 · `hard` Khó 50 điểm. Gợi ý: mỗi nấc −5 điểm, tối đa −50%.
- **Case:** số bước Cơ bản 2 (1 SQL + kết luận) · Dễ 3 · Trung bình 4 · Khó 5; tổng điểm bước = điểm câu.
- **Dạng bài (`dang`, bắt buộc với write/debug/optimize):** 18 dạng A1–E3. A Đo lường: A1 Tra cứu lọc · A2 KPI · A3 Phân rã · A4 Bảng chéo. B Thời gian: B1 Xu hướng · B2 MoM/YoY · B3 Luỹ kế, trượt · B4 Trạng thái tại thời điểm. C So sánh: C1 Top N mỗi nhóm · C2 Tỷ trọng/Pareto · C3 So với chuẩn · C4 Phân khúc. D Hành vi: D1 Phễu · D2 Cohort · D3 Chuỗi liên tiếp. E Kiểm soát: E1 Bất thường · E2 Đối soát · E3 Cấu trúc cây (Datathon chưa có dữ liệu).
- **Domain (`domain`):** `sales`, `marketing`, `customer`, `operations`, `finance`, `after_sales`, khai báo bằng `\khaibaodomain`.

## 3. Khung một câu hỏi (8 phần)

① Nhãn (khoá của `cauhoi`) · ② Tiêu đề `\tieude` · ③ Bối cảnh `\boicanh[Người · vai trò]{lời nhắn}`, không nhắc tên kỹ thuật SQL · ④ Yêu cầu `yeucau` (cột ra, sắp xếp, quy tắc hoà) + `rangbuoc` (optimize) · ⑤ ERD trong câu `erd` · ⑥ Tab Nghiệp vụ `nghiepvu` · ⑦ Vùng trả lời (editor trống / code sai / code chậm / từng bước) · ⑧ Gợi ý `\goiy`, Chạy thử, Nộp.

- **ERD nằm ngay trong câu, to dần theo cấp:** basic 1 bảng + giá trị mẫu (`cot=giatri`); easy 2 bảng + chữ trên đường nối; medium 3–4 bảng, chỉ ký hiệu 1-n; hard 5–7 bảng chỉ khoá, 1–2 bảng nhiễu, cách nối mở bằng gợi ý trả phí `\erdkhoa`. Debug: `canhbao` tô đỏ đường nối gây lỗi (cấp thấp). Case: một ERD, `[hl]` bảng bước đang làm, `[done]` bảng bước trước.
- **Tab Nghiệp vụ:** câu giúp quyết định gì, quy trình (tối đa 1 `\quytrinh`), khái niệm (`\khainiem{ma}` từ từ điển `\khaibaokhainiem` dùng chung, 14 khái niệm), lưu ý. **Không được lộ kết quả của câu** (máy cảnh báo nếu có số ≥100 trùng kết quả).

## 4. Chuẩn gói câu hỏi (LaTeX trên Overleaf, chuẩn v0.4)

Một gói đúng 4 file, zip phẳng (không thư mục con), tối đa 20 câu / 2 MB, `solution.sql` ≤ 256 KB:

| File | Nội dung |
|---|---|
| `cau-hoi.tex` | Khai báo dùng chung (`\khaibaodulieu`, `\khaibaodomain`, `\khaibaokhainiem`) rồi mọi câu `\begin{cauhoi}[...]…\end{cauhoi}` |
| `solution.sql` | Mọi SQL, mỗi khối bắt đầu bằng dòng đánh dấu `-- [ma] solution` · `-- [ma] starter` · `-- [ma] wrong: ten_loi` · case: `-- [ma.b1] solution` |
| `aio-sql-cauhoi.sty` | Gói lệnh (đọc `solution.sql` bằng expl3, in SQL dưới từng câu), không sửa |
| `HUONG_DAN.md` | Hướng dẫn người soạn (đầy đủ cú pháp, đọc file này khi soạn) |

- Overleaf: New Project > Upload Project, Compiler **XeLaTeX**. Chưa biên dịch thử trên máy (không có TeX local).
- Khoá chính của `cauhoi`: `ma` (`^[a-z0-9-]{3,80}$`, trùng mã = phiên bản mới), `dulieu`, `domain`, `hinhthuc`, `cap`, `dang`, `diem?`, `kynang`, `bay`, `tacgia`, `trangthai` (`nhap` bị bỏ qua — mặc định — / `review`), `bokiemtra={public, hidden-1}`, `thutu=co|khong`, `socot=vitri|ten`, `saiso=0.01`; optimize: `quettoida={orders=1}`, `ngansach=2`.
- **Bắt buộc theo hình thức:** write: `dang`, `yeucau`, `erd`, `nghiepvu` + `solution` + ≥1 `wrong`. debug: như write + `starter` (sai). optimize: như write + `rangbuoc` + `quettoida`/`ngansach` + `starter` (đúng nhưng vi phạm ràng buộc). case: `erd`, `nghiepvu`, ≥2 `buoc`, mỗi bước write có `solution`, bước `ketluan` có `luachon` đúng một `\phuongan*`.
- Câu chữ chỉ dùng `\code{}`, `\textbf{}`, `\emph{}`, ``…'', `--`, `\%` `\_` `\&` `\#`.
- **Cú pháp SQL MySQL 8.0:** chỉ `SELECT`/`WITH`, một truy vấn mỗi khối, kết thúc `;`. Dùng `DATE_FORMAT`, `YEAR`, `MONTH`, `COUNT(CASE WHEN … THEN 1 END)`; không dùng `strftime`, `FILTER (WHERE…)`, `ILIKE`, `PERCENTILE_CONT`, `DATE_TRUNC`. Cột `date`/`Date` viết `` `date` ``. Collation `utf8mb4_0900_ai_ci` không phân biệt hoa thường.
- **Optimize, cách tăng độ khó:** basic 3 truy vấn con quét lại bảng → đếm có điều kiện; easy nhiều nhánh UNION ALL → một GROUP BY; medium tính lại cùng phép gom hai lần → `AVG() OVER`; hard tự nối `<=` cộng dồn → `SUM() OVER`, có `ngansach`.

## 5. Gói mẫu 16 câu (4 hình thức × 4 cấp), đã đạt 16/16 trên MySQL

| | Cơ bản | Dễ | Trung bình | Khó |
|---|---|---|---|---|
| write | `w1-don-huy-2022` | `w2-don-theo-vung` | `w3-top3-san-pham` | `w4-ty-le-tra-danh-muc-vung` |
| debug | `d1-khach-ha-noi` | `d2-khach-mua-2022` | `d3-doanh-thu-q4` | `d4-retention-cohort` |
| optimize | `o1-dem-don-theo-trang-thai` | `o2-doanh-thu-theo-nam` | `o3-san-pham-tren-trung-binh` | `o4-luy-ke-doanh-thu` |
| case | `c1-kenh-nhieu-don` | `c2-year-end-sale` | `c3-genz-tra-hang` | `c4-doanh-thu-2019-giam` |

Bản chuẩn: `ban-giao/02-team-dev/goi-cau-hoi-mau/` (bản sao giống hệt ở `ban-giao/01-team-noi-dung/goi-cau-hoi-mau/` + `goi-cau-hoi-mau-overleaf.zip`). Sửa thì sửa bản 02 rồi chép sang 01 và đóng lại zip.

## 6. Chấm trên MySQL và biến thể dữ liệu

- **Biến thể:** `public` = `datathon_2026` (học viên Chạy thử); `hidden-1` = `datathon_2026_hidden_1` (bỏ đơn `order_id % 10 = 7`; thêm đơn huỷ 2023-01-01 bắt lỗi thiếu cận trên; thêm đơn 900001 làm sản phẩm 3 hoà sản phẩm 1908 ở hạng 3 Casual 2022 → bắt `RANK()`); `hidden-2` = `datathon_2026_hidden_2` (sản phẩm 1908 đổi tên trùng sản phẩm 26 → bắt gom theo `product_name`). Hiện chỉ w1, w2, w3, w4, d3, d4 khai báo hidden.
- **Kiểm tra lúc import (mục 12.3 đặc tả):** solution chạy được mọi biến thể và chạy lại cùng kết quả; debug: starter khác solution; optimize: starter **đúng** kết quả nhưng vi phạm ràng buộc, solution thoả; mỗi `wrong` rớt ≥1 biến thể (optimize: hoặc vi phạm ràng buộc); solution 0 dòng → cảnh báo.
- **Đo câu optimize:** `EXPLAIN ANALYZE` dạng TREE; số lần quét = số dòng toán tử đọc bảng (`Table scan on`, `Index range scan on`, `Index lookup on`, `Single-row index lookup on`, `Covering index …`) đổi bí danh về tên bảng bằng sqlglot, bỏ CTE / bảng dẫn xuất / `<temporary>`; dòng trung gian = Σ `rows × loops`. Số đo mẫu: o1 orders 1 vs 3 · o2 orders/order_items 1,1 vs 4,4 · o3 1,1 vs 2,2 · o4 sales 1 lần, 10.227 dòng vs 2 lần, 5.075.697 dòng.
- **So kết quả:** theo vị trí cột (mặc định), xét thứ tự nếu `thutu=co`, sai số 0,01, NULL chỉ bằng NULL; chuỗi '2019' khác số 2019. Lỗi trả về không lộ dữ liệu biến thể ẩn.

## 7. Bộ dựng MySQL cho dev: `ban-giao/02-team-dev/mysql/`

`01_tao_bang.sql` (13 bảng, PK/FK/index; CSV gốc xuống dòng CRLF) → `02_nap_du_lieu.sql` (LOAD DATA từ `du-lieu/`, `--local-infile=1`) → `03_bien_the_an.sql` → `ket-qua/04_nap_cau_hoi.sql` (CSDL `sql_leaderboard`: datasets + schema_json, dataset_variants, domains, terms, questions JSON, expected_results) → `05_tai_khoan_cham_bai.sql` (user `sql_runner` chỉ SELECT).
`cong-cu/`: `goi_cau_hoi.py` (đọc gói → JSON, kiểm tra 12.2), `may_cham.py` (chạy, so, đo), `kiem_tra_goi.py` (kiểm tra 12.3 + xuất `ket-qua/`), `xuat_schema.py`, `cham_thu.py` (mô phỏng Nộp). Cần `pip install pymysql sqlglot`.
Chạy lại khi có gói mới: `python cong-cu/kiem_tra_goi.py --goi <thư mục gói> --ra ket-qua --user root --password … --schema-json ket-qua/schema.json`.
Đã kiểm thử từ đầu bằng `gui-dev.zip` trên MySQL 8.0.46 (máy người dùng có MySQL80 service nhưng không biết mật khẩu root; khi thử dùng mysqld riêng cổng 3307, datadir trong scratchpad).

## 8. Tài liệu và bàn giao

- `ban-giao/02-team-dev/Dac-ta-cho-team-dev.md` (v3, hệ thống, chấm, API), `Dac-ta-doc-goi-cau-hoi.md` (v0.4, trình import, JSON mục 11). Gửi dev: `ban-giao/gui-dev.zip` + `data.zip` gửi riêng.
- `ban-giao/01-team-noi-dung/Huong-dan-cho-team-noi-dung.md` (v2, cho người soạn: hình thức, khung, ERD, scale độ khó, 18 dạng × 6 domain, 16 câu mẫu, bẫy dữ liệu, quy trình 10 bước).
- Canvas thiết kế: https://claude.ai/artifact/GeR5vUysXruXvte6iMoJPW · tài liệu dev online: https://claude.ai/artifact/DAaFsnA1iRmqLEjGHUBgBE (bản online teammate H9Uy9umKvKP43sqtFF5maW đã lỗi thời).
- `ban-giao/delete/`: bản cũ, quy ước của người dùng là dời vào `delete/` chứ không xoá.

## 9. Sự thật dữ liệu đã kiểm chứng (dùng khi soạn đáp án, bẫy)

- `sales.Revenue` = Σ quantity × unit_price của **mọi** đơn kể cả huỷ, chưa trừ chiết khấu (khớp 3.833/3.833 ngày). `payment_value` = Σ(quantity × unit_price − discount_amount) theo đơn, không gồm phí ship.
- `signup_date` muộn hơn đơn đầu tiên ở ~89% khách mua (80.623/90.246): cohort dùng MIN(order_date).
- 66.457 đơn nhiều dòng (fan-out); 2.412 sản phẩm / 2.172 tên (gom theo product_id); 16 cặp (order_id, product_id) trùng; 80 đơn returned không có bản ghi trả; 524 đơn delivered không có shipment; 31.684 khách chưa mua; `days_of_supply` tới 68.100, `reorder_flag` luôn 0; `web_traffic` mỗi ngày 1 nguồn. Khoá ngoại không có dòng mồ côi.
- Số thật hay dùng: đơn huỷ 2022 = 3.384; 2022 huỷ/giao/trả = 3.384 / 27.688 / 2.022; khách ở Hanoi = 4.240.

## 10. Quy trình tạo câu mới (thread khác làm theo đúng thứ tự)

1. **Đọc đủ 3 nguồn:** file này; `ban-giao/02-team-dev/goi-cau-hoi-mau/HUONG_DAN.md` (cú pháp đầy đủ); và câu mẫu cùng hình thức + cấp trong `goi-cau-hoi-mau/cau-hoi.tex` + `solution.sql` để chép khung. Nếu câu nằm trên lộ trình, lấy `ma`, `domain`, đề một câu, bảng dùng từ `lo-trinh-sql/assets/js/data.js` (giữ nguyên `ma`).
2. **Soạn vào một gói riêng** (thư mục mới, 4 file: chép `aio-sql-cauhoi.sty` + phần khai báo dùng chung đầu `cau-hoi.tex`), không sửa gói mẫu 16 câu trừ khi người dùng bảo. Câu mới đặt `trangthai=review`, khai báo `bokiemtra={public, hidden-1}`; mỗi câu có ≥1 `wrong` thể hiện một lỗi hay gặp thật.
3. **Viết SQL theo MySQL 8.0** (mục 4), chạy thật trên dữ liệu; bối cảnh và tab Nghiệp vụ không lộ kết quả.
4. **Dựng MySQL nếu chưa có** (máy có MySQL 8.0 ở `C:\Program Files\MySQL\MySQL Server 8.0\bin`; không biết mật khẩu root của service MySQL80, nên chạy một mysqld riêng):
   `mysqld --initialize-insecure --datadir=<scratchpad>/mysql/data` rồi `mysqld --no-defaults --datadir=… --port=3307 --mysqlx=OFF --local-infile=1 --secure-file-priv=""` (chạy nền), giải nén `data.zip` vào `<thư mục chạy>/du-lieu/`, chạy `01_tao_bang.sql`, `02_nap_du_lieu.sql` (từ thư mục chứa `du-lieu/`, `--local-infile=1`), `03_bien_the_an.sql`. Khoảng 3 phút.
5. **Kiểm tra:** `pip install pymysql sqlglot` rồi `python ban-giao/02-team-dev/mysql/cong-cu/kiem_tra_goi.py --goi <gói mới> --ra <thư mục ra> --port 3307`. Chỉ báo "xong" khi **0 lỗi**; đọc `bao-cao-import.json` để chắc mỗi `wrong` rớt đúng biến thể mong muốn. Cần bẫy dữ liệu mới thì thêm vào `03_bien_the_an.sql` và ghi lại ở mục 6.
6. **Báo người dùng:** danh sách câu, kết quả kiểm tra, và nếu câu thuộc lộ trình thì đổi `co_san: true` trong `data.js` (rồi `vercel deploy --prod` nếu người dùng muốn cập nhật trang).

Câu lệnh gợi ý cho thread mới: *"Đọc CHOT-FORMAT-CAU-HOI.md rồi soạn câu cho Module 5 (Joins) theo các bài dự kiến trong data.js, làm đủ quy trình mục 10."*

## 11. Việc còn mở

- [ ] Khai báo ít nhất `hidden-1` cho mọi câu (d1, d2, o1… hiện có thể bị chép số từ lần Chạy thử).
- [ ] Soạn 50 bài "Dự kiến" của lộ trình theo chuẩn này.
- [ ] Dev chốt: trình import viết mới hay dùng chung; thêm mức `basic` vào hệ thống 3 mức hiện có; cơ chế mở bước case; đăng nhập, bảng xếp hạng chung hay theo lớp; có cho "bỏ cuộc" xem lời giải không.
- [ ] Biên dịch thử gói trên Overleaf (XeLaTeX) để chắc `.sty` chạy.
- [ ] Câu hỏi mở: có dùng bản dữ liệu "nhiễu" (mục I.6 Data Understanding) để có thêm bẫy cấp Khó không.
