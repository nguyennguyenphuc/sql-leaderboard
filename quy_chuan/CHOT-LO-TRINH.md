# CHỐT · Lộ trình luyện SQL (trang roadmap)

Cập nhật: 09/11/2026. File này ghi các quyết định đã chốt về trang lộ trình, để thread khác của dự án dùng tiếp mà không cần đọc lại lịch sử. Format câu hỏi xem `CHOT-FORMAT-CAU-HOI.md`.

## 1. Đã chốt

- **Học SQL theo kỹ thuật trước, domain nằm trong bài tập.** Không còn "giai đoạn 2 theo domain", không còn khung "10 bước / 6 chặng" hay chia track Supply Chain / TMĐT như trang cũ (lo-trinh-sql.vercel.app, của người khác, không sửa).
- **Một lộ trình liền mạch 10 module** (không chia "chặng"), học theo thứ tự:

  | # | Module | Nội dung chính |
  |---|---|---|
  | 1 | Retrieval | SELECT, DISTINCT, WHERE (AND/OR/NOT, IN, BETWEEN, LIKE), ORDER BY, LIMIT |
  | 2 | NULL & Expressions | IS NULL, COALESCE, NULLIF, phép tính, ROUND, CASE WHEN, CAST |
  | 3 | String & Date | CONCAT, TRIM, SUBSTRING_INDEX, YEAR/MONTH, DATE_FORMAT, DAYOFWEEK, DATEDIFF, DATE_ADD |
  | 4 | Aggregation | COUNT/SUM/AVG/MIN/MAX, COUNT(DISTINCT), GROUP BY, HAVING, SUM(CASE…) |
  | 5 | Joins | INNER/LEFT JOIN, nhiều bảng, tự nối, LEFT JOIN … IS NULL, fan-out |
  | 6 | Subqueries | truy vấn con một giá trị, IN/EXISTS/NOT EXISTS, bảng dẫn xuất, tương quan |
  | 7 | CTE & Set Operations | WITH, nhiều CTE, WITH RECURSIVE, UNION / UNION ALL |
  | 8 | Window Functions | ROW_NUMBER/RANK/DENSE_RANK, LAG/LEAD, SUM/AVG OVER, PARTITION BY, ROWS BETWEEN |
  | 9 | Data Quality | dòng trùng, dòng thiếu cặp, ngoại lai, đối soát hai nguồn |
  | 10 | Query Performance | EXPLAIN / EXPLAIN ANALYZE, chỉ mục, gộp lần quét, hàm cửa sổ thay tự nối |

- **Không dạy DML** (INSERT/UPDATE/DELETE): học viên DA chủ yếu đọc dữ liệu, máy chấm chỉ cho SELECT.
- **Sửa lỗi là hình thức bài dùng ở mọi module; Tối ưu truy vấn chỉ ở module 10.**
- **Thẻ module trên lộ trình (phương án A + tab):** SQL là chính. Mỗi thẻ hiện: tên, mô tả, các câu lệnh SQL (chip), và khối **"Ví dụ theo mảng nghiệp vụ"** dạng tab: mỗi mảng có bài trong module là một tab (3–5 tab), mỗi tab = câu hỏi kinh doanh + câu lệnh SQL giải nó. Tab tự chuyển khi thẻ hiện trên màn hình (~5,2 s, có thanh chạy), dừng khi rê chuột hoặc khi người dùng tự chọn; phím mũi tên chuyển tab. Bấm thẻ → ngăn chi tiết mở sẵn bài của tab đang chọn.
- **Đã bỏ (đã thử, người dùng không chọn):** dải chip domain ở đầu trang, thanh màu chia domain + nhãn đếm số bài trên thẻ, thanh lọc domain dính khi cuộn, ô "Tình huống".
- **6 mảng nghiệp vụ (domain):** `sales` Bán hàng · `marketing` Marketing · `customer` Khách hàng · `operations` Vận hành · `finance` Tài chính · `after_sales` Hậu mãi. Mỗi bài gắn đúng một mảng (nhãn màu); ngăn chi tiết lọc được theo mảng.
- **Cấp độ / điểm:** Cơ bản 10 · Dễ 20 · Trung bình 30 · Khó 50 (cùng thang với gói câu hỏi).

## 2. Trang hiện có

- Bản đang chạy (tài khoản Vercel của người dùng, `thehaodev`, nhóm "NguyenTheHao's projects", project `lo-trinh-sql`): **https://lo-trinh-sql-ten.vercel.app** · công khai · gói Hobby.
- Không nối GitHub (người dùng nói chỉ dùng để giao tiếp, không cập nhật code thêm). Repo git cục bộ đã có commit đầu ở `lo-trinh-sql/` (nhánh `main`, chưa có remote).
- **Cập nhật lại khi cần:** sửa file trong `lo-trinh-sql/` rồi chạy `vercel deploy --prod` trong thư mục đó (CLI 65.x đã cài, máy đã đăng nhập; thư mục đã link qua `.vercel/project.json`). Sau đó chép bản mới vào `ban-giao/03-lo-trinh/lo-trinh-sql/` và đóng lại zip.

### Bố cục trang
Thanh trên (logo, điểm, số bài, nút sáng/tối) → đầu trang (tiêu đề "Từ câu SELECT đầu tiên đến truy vấn phân tích", câu giới thiệu có nhắc mảng nghiệp vụ, 4 số liệu tự đếm: 10 module · 62 bài · 6 mảng · 1.640 điểm, thanh tiến độ, ô SQL tự gõ 3 truy vấn có kết quả thật: 4.240 / 3.384 / 3.384·27.688·2.022) → lộ trình 10 module dạng zig-zag, đường nối tự vẽ khi cuộn, nút tròn hiện tiến độ / ✓ khi xong → "Cách tính điểm". Ngăn chi tiết trượt từ phải (điện thoại: từ dưới): học xong làm được, cú pháp chính, ví dụ SQL (nút Chép), lỗi hay gặp, bài luyện (lọc cấp / chưa giải / mảng, bấm bài xem đề, kỹ năng, bảng), nút sang module trước/sau. Chế độ demo: bấm vòng tròn để đánh dấu đã giải (localStorage `lotrinh-sql.v4`).

### File (thư mục `lo-trinh-sql/`, trang tĩnh, không build)
| File | Nội dung |
|---|---|
| `index.html` | Khung trang, icon SVG |
| `assets/js/data.js` | **Toàn bộ nội dung** (`window.LOTRINH`) |
| `assets/js/site.js` | Vẽ trang, hiệu ứng, tab, ngăn chi tiết, tiến độ |
| `assets/css/site.css` | Giao diện, bản tối, bản điện thoại, chuyển động (tắt khi `prefers-reduced-motion`; font code tắt ligature để `>=` không thành `≥`) |
| `README.md` | Hướng dẫn sửa nội dung, nối tiến độ thật |

### Cấu trúc `data.js`
`window.LOTRINH = { title, eyebrow, headline, subtitle, storageKey, dataset, levels, forms, domains, demo, modules }`
- `modules[]`: `{ so, id, icon, name, vi, vidu, desc, goals[], syntax[], example: {task, sql}, mistakes[], exercises[] }`
- `vidu[]`: `{ ma, domain, q, how }` · mỗi mảng có bài trong module một ví dụ (35 ví dụ / 10 module); `ma` phải là bài của module, đúng `domain`; tab đầu hiện trước.
- `exercises[]`: `{ ma, domain, title, level, form, skill, tables[], task, co_san? }` · `form`: `write` | `debug` | `optimize`.
- Nối tiến độ thật: đặt `window.LOTRINH_PROGRESS = { solved: { "<ma>": <điểm> } }` trước `site.js`. `#m4` mở thẳng Module 4.

### Bài luyện: 62 bài (6–7 bài/module)
- **12 bài "Có sẵn"** = câu đã có trong gói câu hỏi mẫu, `ma` trùng: d1, w1, d2, w2, d3, w4, d4, w3, o1, o2, o3, o4 (mã đầy đủ trong `data.js`). 4 case study c1–c4 của gói không nằm trên lộ trình.
- **50 bài "Dự kiến"**: mới có tiêu đề + đề một câu + bảng dùng, cần team nội dung soạn đầy đủ vào gói câu hỏi (LaTeX + MySQL) theo `CHOT-FORMAT-CAU-HOI.md`, giữ nguyên `ma`, rồi đặt `co_san: true`.
- Tiền tố mã theo module: r (1), n (2), s (3), a (4), j (5), q (6), t (7), f (8), k (9), p (10); bài của gói giữ mã gốc (w/d/o).

## 3. Bàn giao

- `ban-giao/gui-dev-lo-trinh-sql.zip` (~9,3 MB, đóng từ `ban-giao/03-lo-trinh/`): `DOC-TRUOC.md` (ghi chú cho dev), `video-demo-lo-trinh.mp4` (~2 phút 55 giây, phụ đề tiếng Việt), `lo-trinh-sql/`.
- Video quay bằng script CDP + ffmpeg trong scratchpad của phiên cũ (`quay/quay.mjs`), không còn ở thread mới: muốn quay lại thì viết lại theo cách: Chrome headless `--remote-debugging-port`, `Page.startScreencast`, chèn con trỏ giả + phụ đề bằng `Runtime.evaluate`, ghép khung bằng ffmpeg concat (ffmpeg ở `C:\Tools\ffmpeg\bin`).

## 4. Việc còn mở

- [ ] Soạn 50 bài "Dự kiến" thành câu hỏi đầy đủ, chạy `kiem_tra_goi.py` trên MySQL.
- [ ] Nếu muốn link lo-trinh-sql.vercel.app hiện bản mới: người giữ project đó (có lẽ dev) phải thay file.
- [ ] Khi nối hệ thống thật: API tiến độ (`solved` theo mã bài), nút "Làm bài" trong `exItem` (site.js) trỏ tới trang câu hỏi, ẩn chế độ demo.
- [ ] Gói Hobby là phi thương mại; nếu thành trang chính thức của khoá có phí thì chuyển sang project công ty / gói Pro.
