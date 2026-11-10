# Hướng dẫn chung cho agent soạn một gói câu hỏi (vai A)

Bạn soạn MỘT gói 20 câu SQL Leaderboard theo đúng quy chuẩn. Hạn chót cứng: xong trong ~60 phút (cả tự kiểm). Chất lượng vẫn phải đạt: 0 lỗi bộ kiểm, biên dịch được, giọng văn chuẩn.

Thư mục gốc: C:\Cong viec\ProjectDA\sql-leaderboard\

## Đọc trước (bắt buộc)
1. quy_chuan\CHOT-FORMAT-CAU-HOI.md; quy_chuan\Huong-dan-cho-team-noi-dung.md (khung 8 phần, ERD to dần theo cấp, tab Nghiệp vụ không lộ số, scale độ khó 5 trục, 18 dạng A1–E3); quy_chuan\goi-cau-hoi-mau\HUONG_DAN.md (cú pháp đầy đủ); quy_chuan\goi-cau-hoi-mau\cau-hoi.tex + solution.sql (CHÉP KHUNG câu mẫu cùng hình thức + cấp); quy_chuan\CHOT-LO-TRINH.md + quy_chuan\lo-trinh-sql\assets\js\data.js (module của gói bạn dạy gì: goals, syntax, mistakes).
2. style\STYLE-<bo>.md – bộ chuẩn thuật ngữ + giọng văn chuẩn giáo trình đại học của bộ dữ liệu (bắt buộc theo; mục khuôn cấm phải tránh tuyệt đối). Nếu chưa có file của bộ bạn thì dùng style\STYLE-scm.md mục B, C, G cho giọng văn và tự tra thuật ngữ ngành trong tài liệu dự án.
3. mysql\README.md (+ mysql\README-<bo>.md nếu có) – cấu trúc database MySQL `<bo>`, cửa sổ dữ liệu, biến thể `<bo>_hidden_1` (bẫy đã có). cong-cu\README.md – lệnh chạy bộ kiểm và biên dịch.
4. goi-cau-hoi\<bo>\BAN-DO-100-CAU.md nếu đã có: soạn đúng các dòng của gói bạn (giữ mã). Nếu chưa có: tự phân bổ theo mục "Phân bổ" dưới đây và ghi phần của gói bạn vào goi-cau-hoi\<bo>\goi-<k>\BAN-DO-GOI.md.

## Phân bổ (đã duyệt)
- Gói k = module 2k−1 và 2k của lộ trình, 9 câu mỗi module, + 2 câu `case`:
  gói1: M1 Retrieval, M2 NULL & Expressions + 2 case Cơ bản · gói2: M3 String & Date, M4 Aggregation + case Cơ bản, Dễ · gói3: M5 Joins, M6 Subqueries + case Dễ, Trung bình · gói4: M7 CTE & Set Operations, M8 Window Functions + case Trung bình, Khó · gói5: M9 Data Quality, M10 Query Performance + 2 case Khó.
- Module 1–9: ~6 `write` + ~3 `debug`; Module 10: ~6 `optimize` + ~3 `write`/`debug`. Không DML.
- Cấp theo module: M1–3 chủ yếu basic/easy; M4–6 easy/medium; M7–10 medium/hard; mỗi module ≥ 1 câu ở cấp thấp nhất của nó. Case: số bước theo cấp (basic 2, easy 3, medium 4, hard 5); tổng điểm bước = điểm câu.
- Mã: `<bo>-<tiền tố module><số>-<slug>` (tiền tố r n s a j q t f k p cho M1…M10), case `<bo>-c<số>-<slug>` (số case: gói1 c1–c2, gói2 c3–c4, gói3 c5–c6, gói4 c7–c8, gói5 c9–c10).
- Dạng (A1–E3) và mảng nghiệp vụ (6 khoá chuẩn `sales marketing customer operations finance after_sales`, ánh xạ theo STYLE của bộ) trải đều; không 2 câu trùng ô dạng×mảng×cấp×hình thức trong gói.

## Mỗi câu
- `\tieude` câu hỏi nghiệp vụ ngắn; `\boicanh[Tên · vai trò]{lời nhắn công sở tự nhiên}` – KHÔNG nhắc kỹ thuật SQL; `yeucau` đủ cột, thứ tự, quy tắc hoà, đơn vị, làm tròn; `erd` đúng cấp; `nghiepvu` (giúp quyết định gì + `\khainiem{}` khai báo dùng chung + `\luuy`) KHÔNG lộ kết quả; 1–2 `\goiy` (không viết sẵn câu SQL); `\ghichuthietke`; `trangthai=review`; `bokiemtra={public, hidden-1}`.
- solution.sql: `solution` (+ `starter` cho debug: chạy được nhưng SAI; optimize: ĐÚNG nhưng vi phạm `quettoida`/`ngansach`, kèm `rangbuoc` bằng lời) + ≥ 1 `wrong` là lỗi THẬT hay gặp, phải rớt ≥ 1 biến thể (dùng bẫy hidden-1 sẵn có hoặc bẫy ngay trên public).
- SQL MySQL 8.0: chỉ SELECT/WITH, một câu mỗi khối, kết thúc `;`, `` `date` ``; không FILTER/ILIKE/PERCENTILE_CONT/DATE_TRUNC/strftime. Chạy THẬT trên MySQL (container `sqllb-mysql`, mạng `sqllb`; không in mật khẩu).
- Câu chữ chỉ dùng `\code{}`, `\textbf{}`, `\emph{}`, ``…'', `--`, `\%` `\_` `\&` `\#`; `_` ngoài `\code{}` phải viết `\_`.
- Khai báo đầu cau-hoi.tex: `\khaibaodulieu` (bộ `<bo>`, biến thể public/hidden-1), `\khaibaodomain` (6 khoá), `\khaibaokhainiem` (chỉ khái niệm gói dùng, định nghĩa chuẩn giáo trình + "trong bộ dữ liệu"); chèn 2 dòng vá XeLaTeX theo cong-cu\va-xelatex.tex (KHÔNG sửa .sty).

## Đầu ra
- goi-cau-hoi\<bo>\goi-<k>\ đúng 4 file: cau-hoi.tex, solution.sql, aio-sql-cauhoi.sty và HUONG_DAN.md (2 file sau chép nguyên từ quy_chuan\goi-cau-hoi-mau\).
- goi-cau-hoi\<bo>\ho-so\goi-<k>\BANG-PHAN-CONG.md: mã | người soạn A | người kiểm (B) | phiên bản v1 | kiểm SQL | kiểm nội dung (2 cột cuối để trống).
- Không viết vào thư mục của gói khác.

## Tự kiểm (bắt buộc, tới khi đạt)
1. Bộ kiểm (lệnh trong cong-cu\README.md) trên gói → dòng cuối "KIEM TRA: 0 loi"; đọc bao-cao-import.json: mỗi wrong rớt đúng biến thể; xử lý mọi cảnh báo.
2. cong-cu\bien_dich.sh trên gói → 0 lỗi LaTeX.
3. Đọc lại mọi câu theo STYLE (khuôn cấm, thuật ngữ).

## Báo cáo cuối (≤ 200 từ)
Danh sách 20 câu (mã | hình thức | cấp | dạng | mảng | tiêu đề); dòng cuối bộ kiểm; kết quả biên dịch; điểm nghiệp vụ chưa chắc.
