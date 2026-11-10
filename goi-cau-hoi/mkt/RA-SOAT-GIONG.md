# Rà soát giọng văn cuối · bộ Marketing (`mkt`, 100 câu, gói 1–5)

Ngày 10/11/2026 · theo `BRIEF-RA-SOAT-GIONG.md`, thuật ngữ theo `style/STYLE-mkt.md`.
Phạm vi: chỉ câu chữ trong `goi-1..5/cau-hoi.tex`. Không đổi SQL, `ma`, khoá chấm, số liệu, cấp, cấu trúc LaTeX; không mở `solution.sql`.

Đối chiếu tự động bản trước/sau (script nháp trong scratchpad): tập `\code{…}` giữ nguyên ở cả 5 gói; mọi dòng `\begin{cauhoi}[…]`,
`\begin{buoc}[…]`, `\erd…`, `\khaibao…`, số dòng file và vị trí `\phuongan*` giữ nguyên. Số mới duy nhất trong chữ: "15" (g2 s7, 20 − 5 loại)
và "5" (g5 k7, 5 nhóm khách của `audiences`), cả hai suy từ dữ liệu, không phải kết quả bài.

## 1. Số chỗ sửa theo loại

| Loại | Số chỗ | Nội dung chính |
|---|---|---|
| Giọng AI | 23 | khuôn "X là …, không phải Y" (22 chỗ), "không chỉ … " (2 chỗ, 1 tính ở thuật ngữ) |
| Dịch máy | 2 | "nhật ký ghi **nó** dưới loại khác" (g4 t4); "gửi lại **họ**" (g2 a8) |
| Thuật ngữ | 48 | "dòng thô" → "dòng (của) dữ liệu thô / bản thô" (25); "luật" → "quy tắc kiểm tra" (13, g4 t4); "Influencer" giải nghĩa "(marketing người ảnh hưởng)" ở lần đầu (5); ROI, CTR, CPA, ROAS giải nghĩa lần đầu ở câu không khai báo khái niệm tương ứng (11); `acquisition_cost` gọi là CPA (1) |
| Vai và tên nhân vật | 23 | xem mục 3 |
| Khuôn lặp giữa các gói | 90 | lời nhắn "Em … giúp anh/chị" (42 chỗ bỏ), "Anh chị xem giúp em" của thực tập sinh (6), "Truy vấn dưới đây (cần) …" (10), "Sửa truy vấn dưới đây để …" (8 đổi cách mở), "Đếm/Tính cho từng X …" (19), "theo tab Nghiệp vụ" (8), "truy vấn" trong lời nhắn (2), "xếp người theo dõi" (2), "Theo từng …" (2) |
| **Tổng** | **186** | trên 5 gói (g1 30, g2 30, g3 41, g4 35, g5 38 dòng đổi) |

## 2. Bảng quét mẫu trước/sau (thân tài liệu, sau `\begin{document}`, bỏ dòng chú thích)

| Mẫu | Trước | Sau | Ghi chú |
|---|---|---|---|
| "—" · "Với mỗi" · "Hãy " · "chìa khoá" · "bức tranh" · "insight" · "đáng chú ý" · "một cách " · "được thực hiện bởi" · "việc thực hiện" · "đếm ngược" · "cả kỳ dữ liệu" · "Sửa để ra đúng" · "Với mỗi cặp" · "Cho từng" | 0 | 0 | |
| "không chỉ" | 2 | 0 | |
| " nó " | 1 | 0 | |
| "giúp anh" | 26 | 3 | |
| "giúp chị" | 24 | 5 | |
| "giúp em" / "xem giúp em" | 6 / 6 | 0 / 0 | |
| "theo tab Nghiệp vụ" | 8 | 0 | |
| "không phải" | 24 | 0 | 4 chỗ còn lại nằm trong `\khaibaokhainiem` (trước `\begin{document}`), xem mục 5 |
| "Truy vấn dưới đây" | 11 | 1 | còn g5 p8 |
| "Truy vấn dưới đây cần" | 5 | 0 | |
| "Sửa truy vấn dưới đây" | 17 | 9 | |
| "Đếm cho từng" / "Tính cho từng" | 9 / 10 | 0 / 0 | |
| "Anh chị xem giúp em" | 6 | 0 | |
| "dòng thô" | 25 | 0 | |
| "luật" | 14 | 1 | còn "quy luật 80/20" (g4 f4, ghi chú thiết kế), đúng nghĩa |
| "truy vấn" trong `\boicanh` | 2 | 0 | |
| "Em " (mọi vị trí) | 51 | 25 | |

## 3. Vai và tên nhân vật

Trước khi sửa, một chức danh duy nhất có nhiều người giữ và một tên mang hai vai:
Giám đốc marketing (Anh Duy / Chị Thảo / Anh Khánh), Trưởng phòng marketing số (Chị Hạnh / Anh Duy / Chị Thảo), Giám đốc tài chính
(Anh Phong / Anh Hưng), Trưởng nhóm quảng cáo trả phí (Chị Ngọc / Anh Vinh / Anh Quân, trong khi Anh Quân là Quản lý thương hiệu Tira Beauty),
Quản lý thương hiệu Nykaa (Chị Trang / Chị Lan), Chuyên viên SEO (Anh Khoa / Chị Hằng, trong khi Anh Khoa là Data engineer),
Kế toán quản trị (Chị Mai / Chị Thảo), Anh Phong vừa là Giám đốc tài chính vừa là Chuyên viên phân tích (g3 j5).

Sau khi sửa (xưng hô trong lời nhắn đổi theo):

| Vai | Người | Gói |
|---|---|---|
| Giám đốc marketing | Anh Duy | 1, 2, 4 |
| Trưởng phòng marketing số | Chị Hạnh | 1–5 |
| Giám đốc tài chính | Anh Phong | 1, 2, 4, 5 |
| Trưởng nhóm quảng cáo trả phí | Anh Vinh | 1, 2, 3 |
| Quản lý thương hiệu Nykaa / Purplle / Tira Beauty | Chị Trang / Chị Ngân / Anh Quân | 2, 3 / 1–5 / 1, 2, 4 |
| Chuyên viên SEO · Chuyên viên email marketing | Chị Hằng · Chị Thư | 1, 3 · 1, 3 |
| Kế toán quản trị | Chị Mai | 1, 3, 4, 5 |
| Data engineer | Anh Khoa | 5 |
| Chuyên viên phân tích marketing | Anh Bảo, Anh Tùng, Chị Hoa, Anh Khánh, Chị Thảo | vai nhiều người |
| Thực tập sinh | Bạn Linh, Bạn Nam, Bạn Vy | vai nhiều người |

Đổi tại: g1 r9, n1; g2 s8, a2, a3, a5; g3 j1, j3, j4, j5, j7, j9, q3, q9, c5, c6; g4 c7, c8; g5 k5, k9, p8, p9, c10.
Lời nhắn g4 f9 ("Chị Hạnh cần …") và g1 r7 ("anh trưởng nhóm") khớp bảng trên.

## 4. Mười ví dụ trước → sau

1. g1 r9 (vai) · `[Chị Ngọc · Trưởng nhóm quảng cáo trả phí]{Chị cần … Danh sách em gửi chị lẫn cả …}` → `[Anh Vinh · Trưởng nhóm quảng cáo trả phí]{Anh cần … Danh sách em gửi anh lại lẫn cả …}`
2. g3 c5 (khuôn "Em … giúp anh", M4) · "Em xem giúp anh nửa đầu 2025, chiến dịch trên kênh nào có tỷ lệ nhấp cao hơn và có ROI tốt hơn, rồi cho anh một kết luận." → "Anh cần biết trong nửa đầu 2025, chiến dịch có dùng kênh nào có tỷ lệ nhấp cao hơn và ROI tốt hơn, kèm một kết luận ngắn."
3. g4 t7 ("truy vấn" trong lời nhắn) · "Truy vấn gộp sai ở chỗ nào?" → "Em tìm giúp chị phần doanh thu bị hụt nằm ở đâu."
4. g2 s7 (khuôn kết lời nhắn thực tập sinh) · "… trong khi công ty chỉ có 5 loại. Anh chị xem giúp em." → "… trong khi công ty chỉ có 5 loại. Em không biết 15 loại thừa từ đâu ra."
5. g3 j8 (khuôn "Truy vấn dưới đây cần …") · "Truy vấn dưới đây cần tính số chiến dịch và tổng doanh thu theo phân khúc khách hàng …" → "Báo cáo cần số chiến dịch và tổng doanh thu theo phân khúc khách hàng …"
6. g4 t7 (khuôn "cho từng X") · "Sửa truy vấn dưới đây để tính đúng, cho từng thương hiệu, số chiến dịch và tổng doanh thu …" → "Sửa truy vấn dưới đây để mỗi thương hiệu có đúng số chiến dịch và tổng doanh thu …"
7. g4 t4 (thuật ngữ) · `\tieude{Luật kiểm tra bắt được bao nhiêu nhiễu đã ghi?}` → `\tieude{Quy tắc kiểm tra bắt được bao nhiêu nhiễu đã ghi?}`
8. g4 t4 (dịch máy, "không phải") · "Một dòng thô có thể bị một luật bắt dù nhật ký ghi nó dưới loại khác … Nhật ký ghi dòng trùng tại vị trí của dòng gốc, không phải dòng chép thêm." → "Một dòng của dữ liệu thô có thể bị một quy tắc bắt dù nhật ký xếp dòng đó vào loại khác … Với dòng trùng, nhật ký ghi theo vị trí của dòng gốc; vị trí của dòng chép thêm không có trong nhật ký."
9. g1 n3 (CPA, "không phải") · "\code{acquisition_cost} là chi phí cho một lượt chuyển đổi, không phải tổng tiền đã chi cho chiến dịch." → "\code{acquisition_cost} là CPA (chi phí trên mỗi chuyển đổi) của chiến dịch; muốn có tổng tiền đã chi thì nhân với số lượt chuyển đổi."
10. g3 c5 phương án (khuôn "X là …, không phải Y") · "ROI theo kênh là ROI của nhóm chiến dịch có dùng kênh, không phải tác động của kênh" → "ROI theo kênh chỉ là ROI của nhóm chiến dịch có dùng kênh đó, chưa đo được tác động riêng của kênh"
11. g5 p1 (viết tắt chưa giải nghĩa) · "ROI, ROAS và CPA của một thương hiệu đều là tỷ lệ của tổng, không phải bình quân của từng chiến dịch." → "ROI (lợi tức đầu tư), ROAS (doanh thu trên chi phí quảng cáo) và CPA (chi phí trên mỗi chuyển đổi) của một thương hiệu đều tính theo tỷ lệ của tổng; không lấy bình quân của từng chiến dịch."

## 5. Chỗ còn để lại và lý do

- **8 lời nhắn còn "… giúp anh/chị"** (g1 n9; g2 s4, a1; g3 j5, q1; g4 t7; g5 k2, k9): mỗi gói tối đa 2, câu nói công sở tự nhiên; bỏ hết thì lời nhắn lại thành một khuôn "Anh/Chị cần …" khác.
- **9 "Sửa truy vấn dưới đây để …"** (g1 3, g2 3, g4 3) và 1 "Truy vấn dưới đây có hai lỗi …" (g5 p8): cách mở câu Sửa lỗi theo gói mẫu QC; đã đổi 8 chỗ sang "Sửa truy vấn khởi đầu …", "Kết quả đúng là … Sửa truy vấn khởi đầu để ra kết quả này", "Cần …" để không còn lặp đều ở mọi câu.
- **g3: "Sửa truy vấn cho đúng yêu cầu; giữ các cột …"** lặp ở 6 câu Sửa lỗi cùng gói: chỉ là dòng ràng buộc cột kết quả, lặp trong một gói, không lặp giữa các gói.
- **`\khaibaokhainiem` còn "không phải"** (diem-tuong-tac, ty-le-roi-pheu ở 3 gói; kenh-da-tri g2, g3): văn bản lấy nguyên từ `STYLE-mkt.md` mục E; muốn đổi phải đổi STYLE trước. Riêng g3 `kenh-da-tri` ghi "không phải kênh chính", lệch nhẹ với mục E ("không phải mức ưu tiên"): đề nghị người duyệt thống nhất.
- **ROAS chưa giải nghĩa trong `\ghichuthietke`** (g1 n8, g2 a7, c4): ghi chú cho người duyệt, học viên không thấy.
- **Mã câu có chữ "luat", "khong-dung-ham", "khong-dem-tuong-quan", "tim-trung-khong-tu-noi", "exists-thay-join-distinct"**: `ma` là khoá, không đổi; tiêu đề hiển thị của các câu này đã không nhắc kỹ thuật SQL.
- **g5 p5 tiêu đề "… với ít dòng trung gian"**: câu Tối ưu, giữ như ví dụ STYLE B.1 ("… chỉ với một lần quét").
- **"2 Influencer" trong dòng "Mã danh mục dùng trong đề"** đầu mỗi gói: danh sách mã cấp gói, không phải phần chữ của câu.
- **Chi tiết thêm vào lời nhắn** để thay câu kết "Anh chị xem giúp em": "15 loại thừa" (g2 s7), "danh mục chỉ có 5 nhóm khách" (g5 k7), "Tira Beauty có đủ năm loại chiến dịch" (g4 f9), "tháng nào phòng mình cũng chạy chiến dịch cho nhóm khách này" (g3 q7). Đều là sự kiện của danh mục, không lộ cách sửa; người duyệt nắm dữ liệu xác nhận lại g4 f9 (đủ 5 loại trong quý 1/2025 của Tira Beauty).

## 6. Kiểm sau khi sửa

- Kiểm tĩnh `kiem_tra_goi.py --chi-phan-tich` (ra `cong-cu/ket-qua/mkt-goi-<k>-giong/`): gói 1–5 đều **KIEM TRA: 0 loi**.
- Biên dịch `cong-cu/bien_dich.sh` (ra `cong-cu/ket-qua/bien-dich/mkt-goi-<k>/`): gói 1–5 lần lượt 43, 47, 49, 61, 59 trang;
  mỗi gói **0 lỗi LaTeX, 0 ký tự thiếu trong font, 0 cảnh báo aio-sql-cauhoi**. Gói 3 được kiểm và biên dịch lại sau chỗ sửa cuối ở q7.
