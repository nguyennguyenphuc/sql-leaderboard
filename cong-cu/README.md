# Công cụ kiểm gói câu hỏi SQL Leaderboard

Bộ kiểm đọc một gói câu hỏi (4 file, chuẩn `aio-sql-cauhoi` v0.4) và làm các phép kiểm của
`quy_chuan/CHOT-FORMAT-CAU-HOI.md` mục 4 (chuẩn gói) và mục 6 (chấm, biến thể) trên MySQL 8.0 `sqllb-mysql`
(dựng theo `mysql/README.md`). Máy không có Python: mọi thứ chạy trong image `sqllb-tools`.

| File | Việc |
|---|---|
| `kiem_tra_goi.py` | chương trình chính: đọc gói (thư mục hoặc .zip), kiểm tĩnh, chạy SQL, xuất `bao-cao-import.json` |
| `doc_goi.py` | đọc `cau-hoi.tex` (khoá lồng ngoặc, môi trường, khai báo) và `solution.sql` (khối, câu lệnh) + kiểm tĩnh |
| `may_cham.py` | chạy truy vấn (user chỉ SELECT, có giới hạn thời gian), so kết quả, đo `EXPLAIN ANALYZE` |
| `bien-the.json` | ánh xạ `dulieu` → database theo biến thể (`scm` → `scm`, `scm_hidden_1`; `datathon-2026` → `datathon_2026…`) |
| `tu_kiem_thu.py` | tự kiểm thử bộ kiểm (gói mẫu, gói thử, gói làm hỏng, so kết quả) |
| `bien_dich.sh` | biên dịch thử gói bằng XeLaTeX trong image `texlive/texlive` |
| `va-xelatex.tex` | 2 dòng vá XeLaTeX đặt trong `cau-hoi.tex` (không sửa `.sty`) |
| `Dockerfile` | image `sqllb-tools` = python:3.12-slim + PyMySQL 1.2.4 + sqlglot 30.30.0 |
| `ket-qua/` | báo cáo, PDF biên dịch thử (sinh ra, không đưa vào gói) |

## Chạy

```bash
docker build -t sqllb-tools "C:\Cong viec\ProjectDA\sql-leaderboard\cong-cu"     # một lần

# Git Bash: thêm MSYS_NO_PATHCONV=1 để đường dẫn /w không bị đổi
MSYS_NO_PATHCONV=1 docker run --rm --network sqllb -v "C:\Cong viec\ProjectDA\sql-leaderboard:/w" -w /w sqllb-tools \
  python cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/<tên gói> --ra cong-cu/ket-qua/<tên gói> --host sqllb-mysql --port 3306
```

- `--goi`: thư mục gói hoặc file `.zip`. Với zip: kiểm ≤ 2 MB, phẳng, chỉ 4 file. Với thư mục: ước lượng cỡ zip của 4 file; file lạ chỉ cảnh báo.
- Mật khẩu `sql_runner`: `--password`, hoặc biến `SQLLB_RUNNER_PASSWORD`, hoặc mặc định đọc `SQL_RUNNER_PASSWORD` trong `mysql/.env` (`--env-file`). Không in ra.
- `--chi-phan-tich`: chỉ đọc gói, không cần MySQL. `--timeout 180`: giây tối đa mỗi truy vấn (quá giờ thì `KILL QUERY`).
- `--cau-hinh`: JSON ánh xạ biến thể; không có mục cho `dulieu` thì public = `dulieu` (đổi `-` thành `_`), hidden-N = `<public>_hidden_N`.
- Ra: `<ra>/bao-cao-import.json` và tóm tắt trên màn hình, dòng cuối `KIEM TRA: N loi` (mã thoát 0 khi 0 lỗi). Cảnh báo không tính vào N.

## Các phép kiểm

**Gói:** đủ 4 file, zip ≤ 2 MB phẳng, `solution.sql` ≤ 256 KB, ≤ 20 câu, có ít nhất một câu.

**`cau-hoi.tex` (tĩnh):** đọc `\khaibaodulieu`, `\khaibaodomain`, `\khaibaokhainiem`; mỗi `\begin{cauhoi}[…]` lấy khoá
(giá trị có `{}` lồng, dấu phẩy trong `{}` không tách). Kiểm: `ma` khớp `^[a-z0-9-]{3,80}$` và không trùng; `dulieu`,
`domain` đã khai báo; `hinhthuc`, `cap`, `dang` (A1–E3), `trangthai`, `thutu`, `socot`, `saiso`, `diem`, `bokiemtra`
(`public|hidden-N`), `quettoida={bang=n,…}`, `ngansach` hợp lệ; khoá lạ thì cảnh báo; `\tieude` có.
Bắt buộc theo hình thức (CHOT mục 4): write `dang` + `yeucau` + `erd` + `nghiepvu` + 1 `solution` + ≥ 1 `wrong`;
debug thêm 1 `starter`; optimize thêm `rangbuoc` + (`quettoida` hoặc `ngansach`) + `starter`; case `erd` + `nghiepvu` +
≥ 2 `buoc`, mã bước không trùng, mỗi bước write có đúng 1 `solution`, bước `ketluan` có `luachon` với đúng một
`\phuongan*`, tổng `diem` các bước = điểm câu. Tab Nghiệp vụ tối đa 1 `\quytrinh`; mọi `\khainiem{ma}` phải đã khai báo.
Lệnh ngoài danh sách được dùng → cảnh báo. Dấu `_` trần ngoài `\code{}` (ví dụ trong `tren=` của `\erdnoi`) → cảnh báo
`LATEX_GACH_DUOI` vì XeLaTeX sẽ lỗi.
`trangthai=nhap` (mặc định của `.sty`) → câu bị bỏ qua, lỗi của câu chỉ ghi thành cảnh báo.

**`solution.sql` (tĩnh):** khối bắt đầu bằng `-- [ma] solution|starter|wrong: ten` (case `-- [ma.b1] …`), cùng regex với `.sty`;
dòng trông như dòng đánh dấu mà sai cú pháp → lỗi; khối phải thuộc câu có thật (bước có thật, không phải bước ketluan).
Mỗi khối: đúng một câu lệnh bắt đầu bằng `SELECT`/`WITH`, kết thúc `;`; cấm `UPDATE DELETE CREATE ALTER DROP TRUNCATE
RENAME GRANT REVOKE LOAD CALL LOCK INTO OUTFILE …`, `INSERT`/`REPLACE` (trừ hàm chuỗi cùng tên), `SLEEP()`,
`BENCHMARK()`, `GET_LOCK()`, `LOAD_FILE()`, biến `@…`. User `sql_runner` chỉ có SELECT nên đây là lớp chặn thứ hai.

**Trên MySQL (user `sql_runner`, mọi biến thể trong `bokiemtra`):**
- biến thể phải có database; bảng/cột trong ERD (`\erdbang`, `\erdnoi`), bảng trong `quettoida` và `bang=` của bước phải có trong schema public;
- `solution` chạy được, chạy 2 lần cùng kết quả; 0 dòng → cảnh báo;
- debug: `starter` chạy được và khác `solution` trên ít nhất một biến thể;
- optimize: `starter` **đúng** kết quả trên mọi biến thể nhưng vi phạm `quettoida`/`ngansach`; `solution` thoả;
- mỗi `wrong` rớt ≥ 1 biến thể (optimize: hoặc vi phạm ràng buộc); wrong báo lỗi MySQL vẫn tính rớt nhưng có cảnh báo;
- case: như write cho từng bước write;
- tab Nghiệp vụ: số ≥ 100 (đọc cả kiểu Việt `3.384`, `1,5` và kiểu Anh) trùng một giá trị số trong kết quả `solution` public → cảnh báo `NGHIEPVU_LO_SO`.

**So kết quả:** theo vị trí cột (`socot=ten`: theo tên, không phân biệt hoa thường), số cột/số dòng phải bằng, xét thứ tự
nếu `thutu=co` (mặc định); số (int/float/Decimal) so với sai số `saiso` (mặc định 0,01); NULL chỉ bằng NULL; chuỗi chỉ
bằng chuỗi (`'2019'` ≠ `2019`); ngày giờ so đúng kiểu. Lý do sai chỉ ghi vị trí (dòng, cột), không in giá trị.

**Đo optimize:** `EXPLAIN ANALYZE <truy vấn>` (MySQL 8.0 trả dạng TREE) trên biến thể public. Số lần quét bảng = số dòng
toán tử đọc bảng: `Table scan on`, `Index scan on`, `Index range scan on`, `Index lookup on`, `Single-row index lookup on`,
`Covering index …`, `Index skip scan …`, `Full-text index search on`, và `Count rows in` (COUNT(*) không WHERE đọc thẳng
số dòng của bảng). Tên trong kế hoạch (bí danh) đổi về tên bảng bằng sqlglot (dialect mysql); bỏ CTE, bảng dẫn xuất,
`<temporary>`, tra cứu `<auto_key…>`. Dòng trung gian = Σ `rows × loops` (actual) trên mọi dòng của kế hoạch
(`never executed` = 0). `ngansach=k`: dòng trung gian ≤ k × của `solution`. Bí danh trùng cho hai bảng khác nhau → cảnh báo
`DO_KE_HOACH_KHONG_RO`.

## bao-cao-import.json

```text
{ goi, thoi_gian, may_chu, khai_bao{dulieu,domain,khainiem}, so_khoi_sql, loi_goi[], canh_bao_goi[],
  cau: [ { ma, dong, tieu_de, hinhthuc, cap, dang, domain, dulieu, diem, trangthai, bo_qua,
           cham{bokiemtra, thutu, socot, saiso, quettoida, ngansach}, buoc[{ma, hinhthuc, diem, bang, phuongan_dung}],
           khoi_sql{khoa: {solution|starter|wrong: [ten]}}, bien_the{public: db, hidden-1: db},
           loi[{ma_loi, thong_diep, file, dong}], canh_bao[…],
           kiem_tra[{phep, ket_qua: dat|loi|canh_bao|bo_qua, chi_tiet}],
           solution{khoa: {bien_the: {so_dong, cot, giay, dong_dau[5 dòng]}}},
           starter{bien_the: "khớp"|lý do}, wrong{ten: {bien_the{v: "qua"|"rot (lý do)"}, rot_o[], vi_pham_rang_buoc[]}},
           optimize{rang_buoc, solution{quet, dong_trung_gian}, starter{quet, dong_trung_gian, vi_pham}, wrong{…}},
           buoc_wrong{b1: {wrong{…}}} } ],
  tong{so_cau, so_cau_bo_qua, so_loi, so_canh_bao} }
```

Mã lỗi hay gặp: `THIEU_KHOA`, `THIEU_PHAN`, `GIA_TRI_SAI`, `MA_SAI`, `MA_TRUNG`, `DULIEU_CHUA_KHAI_BAO`,
`DOMAIN_CHUA_KHAI_BAO`, `KHAINIEM_CHUA_KHAI_BAO`, `PHUONGAN_DUNG_SAI`, `DIEM_CASE_LECH`, `SQL_DANH_DAU_SAI`,
`SQL_KHONG_HOP_LE`, `SQL_THIEU`, `SQL_THUA`, `SQL_KHONG_CO_CAU`, `BIEN_THE_KHONG_CO`, `ERD_BANG_KHONG_CO`,
`ERD_COT_KHONG_CO`, `SOLUTION_LOI`, `SOLUTION_KHONG_TAT_DINH`, `SOLUTION_VI_PHAM`, `STARTER_LOI`,
`STARTER_DEBUG_KHONG_SAI`, `STARTER_OPT_SAI_KET_QUA`, `STARTER_OPT_KHONG_VI_PHAM`, `WRONG_KHONG_ROT`.
Cảnh báo: `SOLUTION_0_DONG`, `NGHIEPVU_LO_SO`, `WRONG_LOI_CHAY`, `LATEX_GACH_DUOI`, `LENH_LA`, `KHOA_LA`, `GOI_FILE_LA`.

## Tự kiểm thử (10/11/2026: 13/13 đạt)

```bash
MSYS_NO_PATHCONV=1 docker run --rm --network sqllb -v "C:\Cong viec\ProjectDA\sql-leaderboard:/w" -w /w sqllb-tools \
  python cong-cu/tu_kiem_thu.py
```

1. Gói mẫu 16 câu (`quy_chuan/goi-cau-hoi-mau`, chỉ phân tích vì không có dữ liệu Datathon): 16 câu (4 × 4 hình thức),
   51 khối SQL, 14 bước case, **0 lỗi**; 1 cảnh báo thật `LATEX_GACH_DUOI` ở o2 dòng 360 (xem phần XeLaTeX).
2. Gói thử `goi-cau-hoi/_thu-bo-kiem` (4 câu Cơ bản trên `scm`) chạy thật: **0 lỗi** (~8 giây).
   t1 write: wrong `quen_can_tren` rớt đúng ở hidden-1; t2 debug: starter thiếu cận trên rớt cả hai biến thể;
   t3 optimize: `orders` quét 3 lần / 186.548 dòng trung gian (starter) so với 1 lần / 46.637 (solution);
   t4 case 2 bước, bước ketluan một `\phuongan*`.
3. Làm hỏng gói thử, mỗi lỗi bị bắt đúng mã, đúng câu: wrong không rớt → `WRONG_KHONG_ROT`; starter optimize sai kết quả
   → `STARTER_OPT_SAI_KET_QUA`; thiếu `dang` → `THIEU_KHOA`; `\khainiem` chưa khai báo → `KHAINIEM_CHUA_KHAI_BAO`;
   nghiệp vụ ghi "7.657" → cảnh báo `NGHIEPVU_LO_SO`; thêm: starter debug đúng → `STARTER_DEBUG_KHONG_SAI`, starter optimize
   không vi phạm → `STARTER_OPT_KHONG_VI_PHAM`, hai `\phuongan*` → `PHUONGAN_DUNG_SAI`, `DELETE` trong khối →
   `SQL_KHONG_HOP_LE`, bước write mất solution → `SQL_THIEU`.
4. So kết quả: 10 trường hợp (`'2019'` ≠ 2019, Decimal/float trong sai số, NULL, thứ tự, `socot=ten`, số dòng).

## Biên dịch thử XeLaTeX (texlive/texlive:latest = TeX Live 2026, XeTeX 0.999998)

```bash
bash cong-cu/bien_dich.sh quy_chuan/goi-cau-hoi-mau          # bản gốc
bash cong-cu/bien_dich.sh --va goi-cau-hoi/_thu-bo-kiem      # chèn va-xelatex.tex vào bản sao tạm
```

Chạy `xelatex -interaction=nonstopmode cau-hoi.tex` 2 lần trong bản sao tạm trong container (gói không bị ghi),
PDF + log ra `cong-cu/ket-qua/bien-dich/<gói>[-va]/`. Font `texgyreheros` (.otf) và `DejaVuSansMono` (.ttf) mà `.sty`
gọi đều có sẵn trong TeX Live (Overleaf cũng có); `.sty` đọc `solution.sql` bằng expl3 chạy đúng (khối SQL in dưới từng câu/bước,
không có cảnh báo `missing-sql`).

| Gói | Kết quả |
|---|---|
| Gói mẫu, bản gốc | PDF 37 trang nhưng **25 lỗi LaTeX** + 443 ký tự mất (nullfont) + 27 chữ Việt thiếu trong font mono |
| Gói mẫu, `--va` | PDF 38 trang, 0 ký tự thiếu, còn 25 lỗi (do nội dung o2, xem 1) |
| Gói mẫu, `--va` + sửa o2 (bản sao) | PDF 39 trang, **0 lỗi, 0 ký tự thiếu** |
| Gói thử, bản gốc | PDF 7 trang, 0 lỗi, 9 chữ Việt thiếu trong font mono |
| Gói thử, `--va` | PDF 7 trang, **0 lỗi, 0 ký tự thiếu** |

Ba vấn đề và cách khắc phục (không sửa `aio-sql-cauhoi.sty`):

1. **Lỗi biên dịch thật ở gói mẫu, câu o2 (`cau-hoi.tex` dòng 360):**
   `\erdnoi[kieu=1-n, tren={orders.order_id = order_items.order_id}]` — chữ trong `tren=`/`duoi=` không được `\detokenize`,
   nên `_` thành chỉ số dưới toán học → `Missing $ inserted`, kéo theo hỏng tikzpicture và môi trường `erd`/`cauhoi` (25 lỗi).
   Sửa nội dung: `tren={\code{orders.order_id = order_items.order_id}}` (hoặc `\_`). Bộ kiểm cảnh báo `LATEX_GACH_DUOI`
   cho mọi `_` trần ngoài `\code{}`. Gói mẫu nằm trong `quy_chuan/` (chỉ đọc) nên chưa sửa; cần sửa ở bản chuẩn
   `ban-giao/02-team-dev/goi-cau-hoi-mau/` rồi chép sang bản 01 và zip.
2. **`\erdkhoa` trong `\begin{erd}` mất chữ:** `erd` là `tikzpicture`, còn `\erdkhoa` in đoạn văn thường (`\par…`), nên chữ rơi
   vào `nullfont` (log: "Missing character … in font nullfont", 443 lần ở w4, d4, o4, c4) — dòng "Khoá: …" không hiện trong PDF.
   Vá trong `cau-hoi.tex` (dòng 2 của `va-xelatex.tex`): vẽ lại `\erdkhoa` thành node dưới ERD:
   `\renewcommand{\erdkhoa}[1]{\node[font=\small, color=cqMuted, anchor=north west, align=left, text width=14cm] at ([yshift=-1mm]current bounding box.south west) {\textbf{Khoá:} #1};}`
   (chỉ dùng khi `\erdkhoa` nằm trong `erd`, như HUONG_DAN hướng dẫn). Cách khác: đặt `\erdkhoa{…}` ngay sau `\end{erd}`.
3. **DejaVu Sans Mono thiếu chữ Việt dựng sẵn** (ở ả ẩ ỷ ủ ố ổ ử ể ế…): mất chữ trong SQL có chú thích tiếng Việt và trong
   `\texttt` (kỹ năng, bẫy). Vá (dòng 1 của `va-xelatex.tex`) đặt sau `\usepackage{aio-sql-cauhoi}`:
   `\setmonofont{NotoSansMono}[Extension=.ttf, UprightFont=*-Regular, BoldFont=*-Bold, Scale=0.86]`
   (đã thử: Noto Sans Mono, FreeMono, TeX Gyre Cursor, Latin Modern Mono đều đủ chữ Việt; Noto giữ dáng gần DejaVu nhất).
   Font chữ thường `texgyreheros` đủ chữ Việt.

Ngoài ra 11 cảnh báo `Overfull \hbox` (dòng SQL dài hơn khung, chỉ là trình bày). Đề nghị chủ `.sty` đưa hai dòng vá vào
v0.5 (`\setmonofont` và `\erdkhoa` dạng node, `\detokenize` cho `tren`/`duoi`) để người soạn khỏi phải chép.

## Giới hạn đã biết

- Đo optimize chỉ trên biến thể public; kế hoạch MySQL có thể đổi theo thống kê (`ANALYZE TABLE` đã chạy khi nạp).
- Bí danh trùng nhau cho hai bảng khác nhau ở hai phạm vi được gán theo tên bảng đầu tiên (có cảnh báo).
- CTE dùng hai lần chỉ materialize một lần trong MySQL: số lần quét bảng gốc là 1; dùng `ngansach` để bắt kiểu chậm này.
- So kết quả `thutu=khong` sắp theo giá trị làm tròn theo `saiso`; hai dòng gần bằng nhau sát ngưỡng có thể so lệch cặp.
- Kiểm `nghiepvu` có thể báo nhầm năm (2016, 2017) nếu kết quả có cột năm dạng số; đây chỉ là cảnh báo.
