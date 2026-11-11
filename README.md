# SQL Leaderboard: ngân hàng câu hỏi SQL và máy chủ chấm MySQL

Repo này chứa ngân hàng câu hỏi SQL của SQL Leaderboard (5 bộ dữ liệu, 500 câu) cùng mọi thứ cần để dựng lại
máy chủ chấm MySQL 8.0 và kiểm một gói câu hỏi trên máy khác:

- script tạo bảng, nạp dữ liệu và tạo biến thể ẩn cho 10 database;
- `docker-compose.yml` cho MySQL và image công cụ `sqllb-tools`;
- bộ kiểm gói (`cong-cu/`) và quy chuẩn soạn câu (`quy_chuan/`, `style/`).

Dữ liệu không nằm trong git. Bản dump nén của 10 database được đính kèm GitHub Release `v1.1.0`;
CSV trung gian (~1,2 GB) chỉ có trên máy gốc.

| Bộ | Database (public, ẩn) | Nguồn |
|---|---|---|
| Supply Chain | `scm`, `scm_hidden_1` | Postgres của lớp, rút gọn (`mysql/README.md`) |
| Finance (AIV Bank) | `aivb`, `aivb_hidden_1` | Postgres của lớp, rút gọn (`mysql/README-aivb.md`) |
| GAME Jelly Trail Academy | `jelly`, `jelly_hidden_1` | Postgres của lớp, schema `jelly_analytics` (`mysql/README-jelly.md`) |
| HR Analytics | `hr`, `hr_hidden_1` | CSV Project 02 (`mysql/README-hr.md`) |
| Marketing (Nykaa/Purplle/Tira) | `mkt`, `mkt_hidden_1` | CSV Project 01 (`mysql/README-mkt.md`) |

## Cấu trúc thư mục

```text
.
├── docker-compose.yml        # project "sqllb": dịch vụ mysql (sqllb-mysql) và tools (sqllb-tools)
├── BRIEF-*.md                # hướng dẫn cho từng vai: dựng bộ, soạn gói, kiểm gói, sửa gói, rà soát giọng văn
├── quy_chuan/                # chuẩn định dạng câu hỏi (CHOT-FORMAT-CAU-HOI.md), gói mẫu, lộ trình
├── style/                    # STYLE-GUIDE-luyen-sql.md và STYLE-<bộ>.md
├── goi-cau-hoi/<bộ>/goi-<k>/ # mỗi gói đúng 4 file: cau-hoi.tex, solution.sql, aio-sql-cauhoi.sty, HUONG_DAN.md
├── goi-cau-hoi/<bộ>/ho-so/goi-<k>/ # hồ sơ của gói (BANG-PHAN-CONG.md, DA-SUA.md, REVIEW-*.md …), không đưa vào zip
├── mysql/                    # script dựng database
│   ├── .env.example          # mẫu mysql/.env (mật khẩu root, sql_runner)
│   ├── 01_tao_bang_scm.sql   # tạo bảng
│   ├── 02_nap_scm.sh         # xuất CSV từ nguồn + nạp (--chi-nap: chỉ nạp từ CSV có sẵn)
│   ├── 03_bien_the_an_scm.sql# biến thể ẩn scm_hidden_1
│   ├── 05_tai_khoan_cham_bai.sql  # user sql_runner, chỉ SELECT
│   └── aivb/ hr/ jelly/ mkt/ # cùng khuôn 01, 02, 03 cho từng bộ
├── cong-cu/                  # bộ kiểm gói (kiem_tra_goi.py), biên dịch XeLaTeX (bien_dich.sh), Dockerfile
└── scripts/
    ├── khoi-phuc.sh / .ps1   # dựng MySQL trên máy mới từ dump (hoặc từ CSV)
    ├── xuat-dump.sh          # dump 10 database ra dist/dumps/ để đưa lên Release
    └── zip-overleaf.sh       # đóng gói zip cho Overleaf ra dist/overleaf/
```

Không đưa vào git (xem `.gitignore`): `mysql/.env`, `mysql/**/du-lieu/`, `cong-cu/ket-qua/`, `dist/`.

## Dựng nhanh trên máy mới

Cần Docker (Docker Desktop hoặc Docker Engine có Compose v2), GitHub CLI `gh` đã đăng nhập (`gh auth login`),
khoảng 10 GB trống.

```bash
git clone https://github.com/nguyennguyenphuc/sql-leaderboard.git sql-leaderboard
cd sql-leaderboard
bash scripts/khoi-phuc.sh            # mặc định tải Release v1.1.0; release khác: --tag v1.1.0
```

Trên Windows không có Git Bash:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1 -Tag v1.1.0
```

Script làm lần lượt: kiểm Docker; tạo `mysql/.env` với mật khẩu ngẫu nhiên nếu chưa có; `docker compose up -d mysql`;
chờ máy chủ sẵn sàng; tải 10 file `*.sql.gz` và `SHA256SUMS` từ Release vào `dist/dumps/`, kiểm SHA256; tạo từng
database (utf8mb4, `utf8mb4_0900_ai_ci`) và nạp; tạo user `sql_runner` bằng `mysql/05_tai_khoan_cham_bai.sql`;
build image `sqllb-tools`. Thời gian chủ yếu nằm ở bước nạp, khoảng 10–20 phút.

Tuỳ chọn:

| `khoi-phuc.sh` | `khoi-phuc.ps1` | Tác dụng |
|---|---|---|
| `--tag <tag>` | `-Tag <tag>` | release cần tải (mặc định `v1.1.0`) |
| `--repo <chủ>/<tên>` | `-Repo <chủ>/<tên>` | repo GitHub, khi thư mục hiện tại không phải bản clone |
| `--khong-tai` | `-KhongTai` | không gọi `gh`, dùng dump đã chép sẵn vào `dist/dumps/` |
| `--tu-csv` | `-TuCsv` | dựng từ script gốc (`02_nap_*.sh --chi-nap`, `03_bien_the_an_*.sql`); cần CSV trong `mysql/**/du-lieu/` |

Sau khi dựng: MySQL nghe ở `127.0.0.1:3307`; container khác trong mạng Docker `sqllb` gọi `sqllb-mysql:3306`.
Volume dữ liệu là `sqllb-mysql-data`, nên `docker compose down` không mất dữ liệu (`down -v` thì mất).

Lưu ý:

- Mật khẩu trong `mysql/.env` chỉ gồm chữ và số: `SQL_RUNNER_PASSWORD` được thay vào file SQL bằng `sed`.
- Volume `sqllb-mysql-data` đã có từ lần dựng trước thì MySQL giữ mật khẩu root cũ, không đọc lại `mysql/.env`.
  Hai giá trị lệch nhau thì sửa `.env` cho khớp, hoặc xoá volume rồi dựng lại.
- Bộ nhớ đệm InnoDB mặc định 1 GB. Máy đủ RAM thì đặt lớn hơn trước khi dựng, ví dụ WSL 10 GB:
  `SQLLB_BUFFER_POOL=6G bash scripts/khoi-phuc.sh`. Bộ kiểm cả 25 gói chạy khoảng 15 phút với 6 GB.
- Sau khi dựng, tắt adaptive hash index (MySQL từng crash khi nhiều truy vấn song song):
  `docker exec sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot -e "SET PERSIST innodb_adaptive_hash_index=OFF"'`.
- Đã có sẵn 10 dump (ví dụ chép từ máy khác): đặt vào `dist/dumps/` cùng `SHA256SUMS` rồi chạy `--khong-tai`;
  script vẫn kiểm SHA256.
- Nếu đã có container `sqllb-mysql` dựng tay bằng `docker run` (không qua compose), không chạy `docker compose up`:
  trùng tên container. Script khôi phục kiểm điều này và dừng lại.
- Dump của `jelly` và `jelly_hidden_1` có view ghi đủ tên database, nên phải nạp đúng tên database gốc.

### Cập nhật dump trên Release

Trên máy gốc, lúc MySQL rảnh:

Chỉ cần khi database đổi (sửa `mysql/**`, biến thể ẩn). Sửa câu hỏi không làm đổi database.

```bash
bash scripts/xuat-dump.sh                         # 10 database -> dist/dumps/*.sql.gz + SHA256SUMS
gh release create v1.2.0 dist/dumps/*.sql.gz dist/dumps/SHA256SUMS --title "SQL Leaderboard v1.2.0" --notes "..."
```

Rồi đổi tag mặc định `TAG=` trong `scripts/khoi-phuc.sh` và `scripts/khoi-phuc.ps1`.

`xuat-dump.sh` chạy `mysqldump --single-transaction --routines --no-tablespaces` qua `docker exec sqllb-mysql`, mật
khẩu root đọc từ `mysql/.env` và chuyển vào container qua biến `MYSQL_PWD`. Dump `hr` nén khoảng 1,7 MB; tổng 10 dump
khoảng 411 MB (10 file .sql.gz).

## Chạy bộ kiểm một gói

```bash
docker compose run --rm tools python cong-cu/kiem_tra_goi.py \
  --goi goi-cau-hoi/<bộ>/goi-<k> --ra cong-cu/ket-qua/<bộ>-goi-<k> --host sqllb-mysql --port 3306
```

Cách chạy tương đương không qua compose (lệnh trong `cong-cu/README.md`):

```bash
docker build -t sqllb-tools cong-cu
MSYS_NO_PATHCONV=1 docker run --rm --network sqllb -v "$PWD:/w" -w /w sqllb-tools \
  python cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/<bộ>/goi-<k> --ra cong-cu/ket-qua/<bộ>-goi-<k> \
  --host sqllb-mysql --port 3306
```

`MSYS_NO_PATHCONV=1` chỉ cần trong Git Bash. Mật khẩu `sql_runner` mặc định đọc từ `mysql/.env`. Dòng cuối
`KIEM TRA: N loi`, mã thoát 0 khi không có lỗi; báo cáo chi tiết ở `<ra>/bao-cao-import.json`. Danh sách phép kiểm,
mã lỗi và tự kiểm thử bộ kiểm (`tu_kiem_thu.py`): `cong-cu/README.md`.

## Biên dịch PDF và tải lên Overleaf

Biên dịch thử bằng XeLaTeX trong image `texlive/texlive` (không ghi vào thư mục gói):

```bash
bash cong-cu/bien_dich.sh goi-cau-hoi/<bộ>/goi-<k>          # bản gốc
bash cong-cu/bien_dich.sh --va goi-cau-hoi/<bộ>/goi-<k>     # chèn cong-cu/va-xelatex.tex vào bản sao tạm
```

PDF và log ra `cong-cu/ket-qua/bien-dich/<gói>[-va]/`. Lần chạy đầu tải image TeX Live (vài GB). Ý nghĩa của `--va`
(font chữ đơn cách đủ chữ Việt, `\erdkhoa` trong ERD) và các lỗi hay gặp: `cong-cu/README.md`, mục biên dịch thử.

Tải lên Overleaf:

```bash
bash scripts/zip-overleaf.sh            # mọi gói -> dist/overleaf/<bộ>-goi-<k>.zip
bash scripts/zip-overleaf.sh hr         # chỉ bộ hr
```

Mỗi zip phẳng, gồm đúng 4 file `cau-hoi.tex`, `solution.sql`, `aio-sql-cauhoi.sty`, `HUONG_DAN.md`. Trên Overleaf:
New Project → Upload Project → chọn file zip, rồi Menu → Compiler: **XeLaTeX**, file chính `cau-hoi.tex`.

### Đóng gói bàn giao (PDF + Overleaf của 25 gói)

```bash
# 1. biên dịch 25 gói, chép PDF ra dist/pdf/<bộ>-goi-<k>.pdf
for bo in scm aivb jelly hr mkt; do for k in 1 2 3 4 5; do
  bash cong-cu/bien_dich.sh goi-cau-hoi/$bo/goi-$k "$PWD/cong-cu/ket-qua/bien-dich/$bo-goi-$k" \
    && mkdir -p dist/pdf && cp "cong-cu/ket-qua/bien-dich/$bo-goi-$k/cau-hoi.pdf" "dist/pdf/$bo-goi-$k.pdf"
done; done
# 2. zip Overleaf từng gói, rồi gom thành 2 file (Windows: tar.exe; Linux/macOS: zip)
bash scripts/zip-overleaf.sh
(cd dist/pdf && tar.exe -a -c -f ../pdf-25-goi.zip *.pdf)
(cd dist/overleaf && tar.exe -a -c -f ../overleaf-25-goi.zip *.zip)
# 3. đính vào Release hiện hành (ghi đè file cùng tên)
gh release upload v1.1.0 dist/pdf-25-goi.zip dist/overleaf-25-goi.zip --clobber
```

Mỗi gói biên dịch khoảng 40 giây. Bàn giao qua 2 file zip này trên GitHub Release.

## Thêm câu hỏi mới

1. Đọc `quy_chuan/DOC_TRUOC.md` và `quy_chuan/CHOT-FORMAT-CAU-HOI.md` (định dạng gói, khoá của `\begin{cauhoi}`,
   cách chấm, biến thể ẩn); xem gói mẫu `quy_chuan/goi-cau-hoi-mau/`.
2. Đọc `style/STYLE-GUIDE-luyen-sql.md` và `style/STYLE-<bộ>.md` (thuật ngữ, giọng văn, bảng và cột dùng được),
   cùng `goi-cau-hoi/<bộ>/BAN-DO-100-CAU.md` để biết dạng câu nào đã có.
3. Làm theo brief của vai tương ứng: `BRIEF-SOAN-GOI.md` (soạn gói), `BRIEF-KIEM-GOI.md` (kiểm),
   `BRIEF-SUA-GOI.md` (sửa sau kiểm), `BRIEF-RA-SOAT-GIONG.md` (rà soát giọng văn). Thêm bộ dữ liệu mới:
   `BRIEF-DUNG-BO.md`, rồi thêm `GRANT` cho database mới vào `mysql/05_tai_khoan_cham_bai.sql` và tên database vào
   `scripts/xuat-dump.sh`, `scripts/khoi-phuc.sh`, `scripts/khoi-phuc.ps1`.
4. Gói chỉ được coi là xong khi bộ kiểm báo `KIEM TRA: 0 loi` và `bien_dich.sh` cho PDF không lỗi.

Hiện có 25 gói, 500 câu, bản v1.1.0 (cập nhật 11/11/2026).

## Quy tắc đang áp dụng

- **Thứ tự ưu tiên:** `quy_chuan/` > `QUYET-DINH-CHUNG.md` (mục 0 trước) > `style/STYLE-<bộ>.md` > `BRIEF-*.md`.
  HackerRank và tài liệu dự án (thư mục `Project DA` của giảng viên) chỉ lấp chỗ quy chuẩn không nói.
- **Cấp độ:** mỗi module (9 câu, không tính case) đủ **2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó** theo lộ trình
  `quy_chuan/lo-trinh-sql`. Câu đổi cấp phải khác độ khó thật (≥ 3/5 trục, QUYET-DINH-CHUNG 2.2), không chỉ đổi nhãn.
  Câu Khó có ít nhất một bẫy chỉ lộ ở hidden-1; câu Sửa lỗi Khó có ≥ 2 lỗi chồng nhau.
- **Trùng ô** (dạng × mảng × cấp × hình thức): cấm trong cùng một gói, và cấm khi hai câu trùng cả chủ đề. Trùng ô giữa
  hai gói khác chủ đề được giữ, ghi ở mục "Ô trùng" của `BAN-DO-100-CAU.md`.
- **Thời gian chạy:** solution, mọi wrong/starter và cách giải tự nhiên của học viên < 10 giây (nên ≤ 5 giây khi
  MySQL rảnh). Câu chậm thì thu phạm vi dữ liệu nếu giữ được độ khó, không dùng gợi ý chỉ mục. Nếu không giữ được độ
  khó: giữ câu, ghi chú câu chậm vào đề (`\luuy`) và ghi thời gian cần nới ở `\ghichuthietke` để nền tảng đặt giới
  hạn riêng cho câu đó.
- **Starter, gợi ý:** starter không có chú thích nói thẳng lỗi; gợi ý nấc cuối chỉ một biểu thức; đề không dẫn học viên
  gắn cứng ngày cuối dữ liệu (đúng public, rớt hidden-1).
- **Sau khi sửa câu:** cập nhật dòng câu trong `BAN-DO-100-CAU.md`, ghi `ho-so/goi-<k>/DA-SUA.md` và
  `BANG-PHAN-CONG.md`, rồi sinh lại số liệu thống kê: `python -X utf8 cong-cu/sinh_thong_ke.py <bộ>` (thay phần số
  liệu của khối "## Thống kê", giữ phần ô trùng ghi tay).

## Kết quả kiểm và báo cáo

- `BAO-CAO-TONG-HOP.md`: mục 0 là trạng thái v1.1.0 (số câu, các vòng v3, v4, kiểm độc lập V4, kiểm máy cuối,
  quyết định của giảng viên); mục 1–5 giữ bản 10/11.
- `bao-cao/kiem-cuoi/<bộ>-goi-<k>.json`, `TONG-HOP.txt`: báo cáo bộ kiểm lần cuối (11/11/2026) của từng gói,
  25/25 gói `0 loi`.
- `goi-cau-hoi/<bộ>/ho-so/`: hồ sơ từng gói (`DA-SUA.md` ghi mọi vòng sửa) và kiểm độc lập V4 của bộ
  (`KIEM-V4-DANH-SACH.md`, `KIEM-V4-B.md`, `KIEM-V4-C.md`).
- Chạy lại bộ kiểm cho mọi gói: `bash cong-cu/kiem_tat_ca.sh 4` (4 gói song song; thêm tên bộ để chỉ chạy bộ đó).
  Kết quả ở `cong-cu/ket-qua/kiem-cuoi/`; mỗi báo cáo có số giây của từng truy vấn (`solution.*.giay`).
- Release v1.1.0: 10 dump + `SHA256SUMS`, `pdf-25-goi.zip` (25 PDF), `overleaf-25-goi.zip` (25 zip Overleaf).
