# Gói câu hỏi SQL: hướng dẫn soạn

Một gói câu hỏi chỉ có 4 file:

| File | Nội dung |
|---|---|
| `HUONG_DAN.md` | File này |
| `cau-hoi.tex` | **Mọi câu hỏi** của gói: khai báo dùng chung ở đầu file, sau đó mỗi câu là một `\begin{cauhoi}…\end{cauhoi}` |
| `solution.sql` | **Mọi SQL** của gói: lời giải, truy vấn khởi đầu, bài sai; nối với câu bằng mã câu |
| `aio-sql-cauhoi.sty` | Gói lệnh soạn câu, không sửa |

Có 4 hình thức câu hỏi, mỗi hình thức có 4 cấp (Cơ bản 10, Dễ 20, Trung bình 30, Khó 50 điểm):

| Hình thức | `hinhthuc` | Học viên làm gì |
|---|---|---|
| Viết truy vấn | `write` | Đọc yêu cầu, viết truy vấn ra đúng bảng kết quả |
| Sửa lỗi | `debug` | Nhận truy vấn cho kết quả sai, sửa cho đúng |
| Tối ưu truy vấn | `optimize` | Nhận truy vấn cho kết quả **đúng nhưng chậm**, viết lại sao cho cùng kết quả và thoả ràng buộc (số lần quét bảng, số dòng trung gian) |
| Case study | `case` | Đi qua nhiều bước viết truy vấn, bước cuối chọn kết luận |

File zip mẫu này có đủ 16 câu (4 hình thức × 4 cấp). Câu đầu tiên `w1-don-huy-2022` có chú thích từng khoá.

Tải zip lên Overleaf (New Project > Upload Project, Menu > Compiler: XeLaTeX) là ra PDF để duyệt. Trong PDF, SQL của từng câu được lấy từ `solution.sql` và in ngay dưới câu đó. Tải cùng file zip lên hệ thống thì các câu vào hàng tự kiểm, chưa xuất bản.

Muốn soạn câu mới:
1. Chép một khối `\begin{cauhoi}…\end{cauhoi}` cùng hình thức, đổi `ma`, sửa nội dung.
2. Thêm SQL của câu vào `solution.sql`.
3. Xem PDF trên Overleaf.
4. Tải zip xuống (Menu > Download > Source), rồi tải lên hệ thống.

## Tải lên

- Zip chỉ chứa 4 file trên, không có thư mục con.
- Tối đa 20 câu một lần, zip tối đa 2 MB, `solution.sql` tối đa 256 KB.
- Câu nào lỗi thì chỉ câu đó báo lỗi, kèm số dòng trong `cau-hoi.tex` hoặc `solution.sql`. Các câu khác vẫn vào hàng tự kiểm.
- Trùng `ma` với câu đang có thì thành **phiên bản mới** của câu đó, lịch sử nộp cũ giữ nguyên.

## solution.sql

Mỗi truy vấn bắt đầu bằng **một dòng đánh dấu**, và kéo dài tới dòng đánh dấu tiếp theo:

```sql
-- [mau-top3-san-pham] solution
WITH dt AS (...)
SELECT ...;

-- [mau-top3-san-pham] wrong: quen_partition_by
SELECT ...;

-- [mau-aov-fanout] starter
SELECT ...;

-- [mau-year-end-sale.b1] solution
SELECT ...;
```

| Dòng đánh dấu | Ý nghĩa | Bắt buộc |
|---|---|---|
| `-- [ma] solution` | Lời giải, phải qua mọi biến thể dữ liệu (với optimize: thoả cả ràng buộc) | write, debug, optimize: đúng 1 |
| `-- [ma] starter` | Truy vấn nạp sẵn vào ô soạn SQL. Debug: truy vấn **sai kết quả**. Optimize: truy vấn **đúng kết quả nhưng vi phạm ràng buộc** | debug, optimize: đúng 1; write: không bắt buộc (bỏ thì ô để trắng) |
| `-- [ma] wrong: ten_loi` | Lời giải sai thường gặp, phải rớt ít nhất một biến thể (optimize: sai kết quả hoặc vi phạm ràng buộc) | write, debug, optimize: ít nhất 1 |
| `-- [ma.b1] solution`, `-- [ma.b1] wrong: ...` | SQL của bước `b1` trong case study | mỗi bước write: đúng 1 solution |

Quy tắc:
- `ma` phải trùng `ma` của một câu trong `cau-hoi.tex`. `ten_loi` gồm chữ, số, `_`, `-`.
- Các dòng trước dòng đánh dấu đầu tiên bị bỏ qua, dùng để ghi chú đầu file.
- Chú thích `--` nằm trong một khối SQL thuộc về khối đó.
- Viết theo cú pháp MySQL 8.0, chỉ dùng `SELECT` hoặc `WITH`. Không dùng hàm riêng của hệ khác (như `strftime`, `FILTER (WHERE …)`, `ILIKE`); dùng `DATE_FORMAT`, `YEAR`, `MONTH`, `COUNT(CASE WHEN … THEN 1 END)`. Cột tên `date`, `Date` viết là `` `date` ``. Mỗi khối một truy vấn, kết thúc bằng `;`.
- Bước kết luận của case không có SQL.

## cau-hoi.tex

### Khai báo dùng chung (đầu file, trước `\begin{document}`)

```latex
\khaibaodulieu{ma}{Tên}{Mô tả}
\khaibaodomain{ma}{Tên}{Mô tả mảng nghiệp vụ}
\khaibaokhainiem{ma}{Tên}{Định nghĩa}{Công thức, có thể rỗng}{Trong bộ dữ liệu}
```

Câu hỏi chỉ được dùng mã đã khai báo ở đây. Bộ dữ liệu còn phải có sẵn trên hệ thống (file dữ liệu, schema, biến thể kiểm tra do dev quản lý).

### Khoá của `\begin{cauhoi}[...]`

- `ma`: chữ thường, số, gạch ngang, dài 3 tới 80 ký tự.
- `dulieu`, `domain`: mã đã khai báo.
- `hinhthuc`: `write`, `debug`, `optimize` hoặc `case`.
- `cap`: `basic`, `easy`, `medium` hoặc `hard`, ứng với 10, 20, 30, 50 điểm.
- `dang`: `A1` tới `E3`, bắt buộc với write, debug, optimize.
- `diem`: không bắt buộc, ghi đè điểm mặc định. Với case, `diem` bằng tổng điểm các bước.
- `kynang`, `bay`, `tacgia`: không bắt buộc. Giá trị có dấu phẩy thì bọc `{}`: `kynang={CTE, JOIN}`.
- `trangthai`: `nhap` (máy bỏ qua khi tải lên) hoặc `review` (đưa vào hàng tự kiểm).
- Cách chấm kết quả:
  - `bokiemtra={public, hidden-1}`: các biến thể dữ liệu dùng để chấm; mặc định `public`.
  - `thutu=co|khong`: có xét thứ tự dòng không; mặc định `co`.
  - `socot=vitri|ten`: so cột theo vị trí hay theo tên; mặc định `vitri`.
  - `saiso=0.01`: sai số tuyệt đối cho số thực.
- Ràng buộc của câu optimize (cần ít nhất một khoá):
  - `quettoida={orders=1, order_items=1}`: mỗi bảng được quét tối đa bao nhiêu lần.
  - `ngansach=2`: tổng số dòng trung gian không quá 2 lần của lời giải mẫu.
  - Hai số này máy đo từ kế hoạch chạy `EXPLAIN ANALYZE` của MySQL, không đo bằng thời gian. Mỗi bước đọc bảng trong kế hoạch (Table scan, Index range scan, Index lookup…) tính là một lần quét.

### Nội dung câu

| Lệnh | Nội dung |
|---|---|
| `\tieude{...}` | Tiêu đề, bắt buộc |
| `\boicanh[Người hỏi · vai trò]{lời nhắn}` | Bối cảnh |
| `\begin{yeucau} \item ... \end{yeucau}` | Yêu cầu, mỗi `\item` một dòng |
| `\begin{rangbuoc} \item ... \end{rangbuoc}` | Ràng buộc viết bằng lời cho học viên (optimize), khớp với khoá `quettoida`, `ngansach` |
| `\begin{erd} ... \end{erd}` | ERD trong câu |
| `\begin{luachon} \phuongan{...}{giải thích} \phuongan*{...}{...} \end{luachon}` | Phương án của bước kết luận (case). Dấu `*` là đáp án đúng, đúng một phương án |
| `\begin{nghiepvu}{Câu này giúp quyết định gì} ... \end{nghiepvu}` | Tab Nghiệp vụ |
| `\goiy{...}` | Gợi ý, mở từng nấc theo thứ tự, mỗi nấc trừ 5 điểm |
| `\ghichuthietke{...}` | Ghi chú cho người duyệt, học viên không thấy |
| `\code{...}` | Tên bảng, cột, giá trị trong câu chữ; không cần escape dấu `_` |

**ERD**

```latex
\begin{erd}
  \erdbang[hl|done]{bảng}{cột,hàng}{cot:PK, cot:FK, cot*, cot=giatrimau}
  \erdnoi[kieu=1-1|1-n|n-1, tren=chữ trên đường nối, canhbao]{bảng.cột}{bảng.cột}
  \erdkhoa{quan hệ ẩn, mở bằng gợi ý trả phí (cấp hard)}
\end{erd}
```

- `{cột,hàng}` là vị trí trên lưới, đếm từ 0.
- `cot*` đánh dấu cột câu hỏi cần dùng. `cot=giatri` là giá trị mẫu, dùng ở cấp basic.
- `canhbao` tô đỏ đường nối, dùng ở câu debug.
- Bảng không có khoá (như `sales`, `web_traffic`) vẫn vẽ được; ghi cột bình thường, không có `:PK`.
- `[hl]` và `[done]` dùng trong case: bảng đang dùng ở bước này, và bảng đã xong.
- Bảng và cột phải có thật trong schema.

ERD tăng dần theo cấp:

| Cấp | ERD |
|---|---|
| basic | 1 bảng, có giá trị mẫu |
| easy | 2 bảng, chữ trên đường nối |
| medium | 3–4 bảng, có ký hiệu 1-n |
| hard | 5–7 bảng, chỉ khoá, thêm bảng nhiễu, quan hệ mở bằng `\erdkhoa` |

**Tab Nghiệp vụ**

```latex
\begin{nghiepvu}{Câu này giúp quyết định gì}
  \quytrinh{Tên quy trình}{bước 1, bước 2}{nhánh 1, nhánh 2}
  \khainiem{ma-khai-niem}
  \luuy{...}
\end{nghiepvu}
```

- Tab chỉ giải thích khái niệm và quy tắc. **Không được lộ kết quả của câu.**
- Mỗi câu có tối đa một `\quytrinh`.

**Case study**

```latex
\begin{buoc}[ma=b1, diem=20, hinhthuc=write, bang={orders, order_items}]{Tiêu đề bước}
  \begin{yeucau} ... \end{yeucau}
  \goiy{...}
\end{buoc}
```

- SQL của bước nằm trong `solution.sql` với dòng đánh dấu `-- [ma-cau.b1] ...`.
- `hinhthuc` của bước là `write` hoặc `ketluan`. Bước ketluan dùng `luachon`, không có SQL; thường là bước cuối, học viên chọn kết luận dựa trên kết quả các bước trước.
- Số bước tăng theo cấp: Cơ bản 2 (1 SQL + kết luận), Dễ 3, Trung bình 4, Khó 5.
- `bang` liệt kê các bảng được tô sáng ở bước đó.
- Học viên làm theo thứ tự: bước sau mở khi bước trước đúng.

**Bắt buộc theo hình thức**

| Hình thức | Trong `cau-hoi.tex` | Trong `solution.sql` |
|---|---|---|
| write | `dang`, `yeucau`, `erd`, `nghiepvu` | `solution`, ít nhất một `wrong` |
| debug | như write | `solution`, `starter`, ít nhất một `wrong` |
| optimize | như write, thêm `rangbuoc` và khoá `quettoida` hoặc `ngansach` | `solution`, `starter`, ít nhất một `wrong` |
| case | `erd`, `nghiepvu`, ít nhất 2 `buoc` | mỗi bước write có `solution` |

**Tối ưu truy vấn: cách tăng độ khó**

| Cấp | Truy vấn khởi đầu (đúng nhưng chậm) | Cách viết lại |
|---|---|---|
| basic | 3 truy vấn con, mỗi cái quét lại cùng một bảng | Đếm có điều kiện trong 1 lần quét (`FILTER`, `CASE WHEN`) |
| easy | Nhiều nhánh `UNION ALL`, mỗi năm một nhánh | Một lần `GROUP BY` theo năm |
| medium | Tính cùng một CTE hai lần để lấy trung bình nhóm | Hàm cửa sổ `AVG() OVER (PARTITION BY ...)` |
| hard | Tự nối bảng với điều kiện `<=` để cộng dồn (số dòng tăng theo bình phương) | `SUM() OVER (PARTITION BY ... ORDER BY ...)`, có ngân sách dòng |

**Câu chữ**

Câu chữ chỉ được dùng các lệnh định dạng sau:
- `\code{}`, `\textbf{}`, `\emph{}`;
- ` ``…'' ` (ngoặc kép), `--` (gạch nối dài);
- `\%`, `\_`, `\&`, `\#`.

Lệnh nào khác sẽ bị cảnh báo. Không dùng công thức toán, ảnh hay màu tự chọn.

## Sau khi tải lên

Máy tự kiểm mỗi câu:

- khoá, mã, bảng, cột đều hợp lệ; đủ các phần bắt buộc;
- mỗi khối trong `solution.sql` thuộc về một câu có thật; mỗi câu có đủ khối SQL bắt buộc;
- lời giải chạy được trên mọi biến thể trong `bokiemtra`, và chạy lặp lại vẫn ra cùng kết quả;
- `starter` của câu debug phải rớt;
- `starter` của câu optimize phải ra **đúng** kết quả nhưng vi phạm ít nhất một ràng buộc; `solution` phải thoả mọi ràng buộc;
- mỗi `wrong` phải rớt ít nhất một biến thể (optimize: hoặc vi phạm ràng buộc);
- mỗi bước kết luận có đúng một `\phuongan*`; case có tổng điểm các bước bằng điểm câu;
- tab Nghiệp vụ không chứa con số trùng với kết quả lời giải (chỉ cảnh báo).

Bẫy chỉ lộ ra trên dữ liệu đặc biệt (ví dụ hai sản phẩm bằng doanh thu) phải nằm ở biến thể `hidden-*`. Nếu đặt ở `public`, bài sai có thể cho đúng kết quả và bị báo lỗi.

Đạt hết thì câu thành "Chờ duyệt", kèm kết quả lời giải đã tính sẵn. Giảng viên phụ trách bấm "Duyệt và xuất bản".
