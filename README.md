# SQL Leaderboard: ngân hàng câu hỏi SQL và máy chủ chấm MySQL

Repo này chứa ngân hàng câu hỏi SQL của SQL Leaderboard (5 bộ dữ liệu, 500 câu) cùng mọi thứ cần để dựng lại
máy chủ chấm MySQL 8.0 và kiểm một gói câu hỏi trên máy khác:

- script tạo bảng, nạp dữ liệu và tạo biến thể ẩn cho 10 database;
- `docker-compose.yml` cho MySQL và image công cụ `sqllb-tools`;
- bộ kiểm gói (`cong-cu/`) và quy chuẩn soạn câu (`quy_chuan/`, `style/`).

Dữ liệu không nằm trong git. Bản dump nén của 10 database được đính kèm GitHub Release `v1.0.0`;
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
bash scripts/khoi-phuc.sh            # mặc định tải Release v1.0.0; release khác: --tag v1.0.0
```

Trên Windows không có Git Bash:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1 -Tag v1.0.0
```

Script làm lần lượt: kiểm Docker; tạo `mysql/.env` với mật khẩu ngẫu nhiên nếu chưa có; `docker compose up -d mysql`;
chờ máy chủ sẵn sàng; tải 10 file `*.sql.gz` và `SHA256SUMS` từ Release vào `dist/dumps/`, kiểm SHA256; tạo từng
database (utf8mb4, `utf8mb4_0900_ai_ci`) và nạp; tạo user `sql_runner` bằng `mysql/05_tai_khoan_cham_bai.sql`;
build image `sqllb-tools`. Thời gian chủ yếu nằm ở bước nạp, khoảng 10–20 phút.

Tuỳ chọn:

| `khoi-phuc.sh` | `khoi-phuc.ps1` | Tác dụng |
|---|---|---|
| `--tag <tag>` | `-Tag <tag>` | release cần tải (mặc định `v1.0.0`) |
| `--repo <chủ>/<tên>` | `-Repo <chủ>/<tên>` | repo GitHub, khi thư mục hiện tại không phải bản clone |
| `--khong-tai` | `-KhongTai` | không gọi `gh`, dùng dump đã chép sẵn vào `dist/dumps/` |
| `--tu-csv` | `-TuCsv` | dựng từ script gốc (`02_nap_*.sh --chi-nap`, `03_bien_the_an_*.sql`); cần CSV trong `mysql/**/du-lieu/` |

Sau khi dựng: MySQL nghe ở `127.0.0.1:3307`; container khác trong mạng Docker `sqllb` gọi `sqllb-mysql:3306`.
Volume dữ liệu là `sqllb-mysql-data`, nên `docker compose down` không mất dữ liệu (`down -v` thì mất).

Lưu ý:

- Mật khẩu trong `mysql/.env` chỉ gồm chữ và số: `SQL_RUNNER_PASSWORD` được thay vào file SQL bằng `sed`.
- Volume `sqllb-mysql-data` đã có từ lần dựng trước thì MySQL giữ mật khẩu root cũ, không đọc lại `mysql/.env`.
  Hai giá trị lệch nhau thì sửa `.env` cho khớp, hoặc xoá volume rồi dựng lại.
- Trên máy gốc, container `sqllb-mysql` được dựng bằng `docker run` (xem `mysql/README.md`). Không chạy
  `docker compose up` ở đó: trùng tên container. Script khôi phục kiểm điều này và dừng lại.
- Dump của `jelly` và `jelly_hidden_1` có view ghi đủ tên database, nên phải nạp đúng tên database gốc.

### Cập nhật dump trên Release

Trên máy gốc, lúc MySQL rảnh:

```bash
bash scripts/xuat-dump.sh                         # 10 database -> dist/dumps/*.sql.gz + SHA256SUMS
gh release create v1.0.0 dist/dumps/*.sql.gz dist/dumps/SHA256SUMS --title "Dữ liệu MySQL v1.0.0" --notes "..."
```

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

Hiện có 25 gói, 500 câu (cập nhật 10/11/2026).

## Kết quả kiểm và báo cáo

- `BAO-CAO-TONG-HOP.md`: thống kê 500 câu, quy trình đã chạy và danh sách việc chờ giảng viên quyết.
- `bao-cao/kiem-cuoi/<bộ>-goi-<k>.json`: báo cáo bộ kiểm lần cuối (public + hidden-1) của từng gói, 25/25 gói `0 loi`.
- Chạy lại bộ kiểm cho mọi gói: `bash cong-cu/kiem_tat_ca.sh 4` (4 gói song song; thêm tên bộ để chỉ chạy bộ đó).
- PDF đề và zip tải lên Overleaf của 25 gói được đính kèm Release cùng bản dump.
