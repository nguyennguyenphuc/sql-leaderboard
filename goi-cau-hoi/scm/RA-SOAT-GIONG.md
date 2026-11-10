# Rà soát giọng văn cuối · bộ Supply Chain (scm), 100 câu, gói 1–5

Ngày 10/11/2026. Làm theo `BRIEF-RA-SOAT-GIONG.md`; chuẩn: `style/STYLE-scm.md` (A thuật ngữ, B giọng văn, C khuôn cấm, G quyết định tạm), `BRIEF-KIEM-GOI.md` bước 6.
Phạm vi sửa: chỉ câu chữ trong `goi-1..5/cau-hoi.tex`. Không đổi SQL, `ma`, khoá chấm (`thutu`, `saiso`, `socot`, tên cột kết quả), số liệu, cấp, cấu trúc LaTeX; không mở `solution.sql`. Đã đối chiếu bằng `diff` với bản sao trước khi sửa: không dòng khai báo `\begin{cauhoi}[…]`/`\begin{buoc}[…]` nào đổi khoá (dòng `buoc` duy nhất bị đổi là phần tên bước trong `{}` của c10 bước 1).

## 1. Số chỗ sửa theo loại

| Loại | Số chỗ | Gồm |
|---|---|---|
| Giọng AI | 9 | khuôn "X, không phải / không bằng / không so Y" (7), đảo nhấn "… mới phản ánh" (1), "một cách + tính từ" trong ghi chú thiết kế (1) |
| Dịch máy | 0 | quét " nó ", "được thực hiện bởi", "việc thực hiện" đều 0; đọc lại không thấy trật tự từ kiểu Anh cần sửa |
| Thuật ngữ và quy ước | 13 | DC chưa giải nghĩa "trung tâm phân phối (DC)" ở lần đầu trong thân câu (4), fill rate chưa giải nghĩa "(tỷ lệ lấp đầy)" (3), giải nghĩa lặp hai lần trong một câu (2), "khâu" lẫn với "chặng" trong cùng câu (1), thêm "Chưa đúng." cho phương án sai ở gói 3 (4 – xem mục 3) |
| Khuôn lặp | 38 | tiêu đề (9), mở đầu yêu cầu câu Sửa lỗi (10), câu mở/kết lời nhắn lặp giữa các gói (8), `\luuy` nói sẵn bẫy hoặc lộ kết luận (11) |
| **Tổng** | **60** | gói 1: 5 · gói 2: 13 · gói 3: 14 · gói 4: 14 · gói 5: 14 |

Chi tiết khuôn lặp:
- Tiêu đề cụm danh từ ở câu Viết, đổi thành câu hỏi kinh doanh (B.1): `scm-n5`, `scm-j3`, `scm-j8`.
- Tiêu đề Sửa lỗi lặp "… ra 0" (3 gói) và "… cao bất thường" (4 gói): đổi `scm-s3`, `scm-a5`, `scm-j4`, `scm-t5` sang triệu chứng cụ thể của từng câu.
- Hai case trùng nguyên tiêu đề "Vì sao ngày cao điểm năm 2016 giao trễ nhiều?" (`scm-c6` gói 3, `scm-c8` gói 4): đổi tiêu đề `scm-c6` theo đúng câu hỏi của case (chặng nào).
- Tiêu đề Sửa lỗi nhắc "truy vấn" (`scm-o8`): đổi sang lời nghiệp vụ (chỉ câu Tối ưu được nhắc kỹ thuật).
- Yêu cầu câu Sửa lỗi lặp "Sửa để ra đúng" (7 chỗ ở gói 2, 4) và "Sửa cho đúng" (3 chỗ ở gói 5): viết lại theo đúng việc của từng câu.
- Lời nhắn: `scm-s3` (gói 2) gần như chép `scm-r7` (gói 1); câu kết "Anh chị xem giúp em sai ở đâu" lặp ở 3 gói; "Em xem lại giúp chị" lặp trong gói 2; bốn câu kết của Data engineer gói 5 ("Em viết gọn lại / viết lại giúp anh cho nhẹ hơn …") gần như một khuôn.
- `\luuy` nói sẵn bẫy hoặc lộ kết luận: `scm-r2`, `scm-n4`, `scm-c3`, `scm-c4`, `scm-j7`, `scm-j8`, `scm-c5`, `scm-t1`, `scm-t6`, `scm-c7`, `scm-k10`. Thay bằng câu định nghĩa hoặc điều kiện dữ liệu trung tính (B.4), không chỉ ra bài sai và không nghiêng về phương án nào.

## 2. Quét tự động trước / sau

Không có `cong-cu/quet_giong.py`; đếm bằng grep trên từng `cau-hoi.tex`. Ô ghi `g1 g2 g3 g4 g5`.

| Mẫu | Trước | Sau | Ghi chú |
|---|---|---|---|
| — (gạch dài) | 0 0 0 0 0 | 0 0 0 0 0 | |
| Với mỗi | 0 0 0 0 0 | 0 0 0 0 0 | |
| Hãy | 0 0 0 0 0 | 0 0 0 0 0 | |
| không chỉ | 0 1 0 1 0 | 0 1 0 1 0 | để lại, xem mục 5 |
| chìa khoá / bức tranh / insight / đáng chú ý | 0 | 0 | |
| một cách | 0 0 0 0 1 | 0 0 0 0 0 | |
| được thực hiện bởi / việc thực hiện / " nó " | 0 | 0 | |
| đếm ngược / cả kỳ dữ liệu | 0 | 0 | |
| giúp anh | 3 5 4 4 10 | 3 5 4 4 7 | |
| giúp chị | 2 9 7 4 4 | 2 7 7 4 4 | |
| giúp em | 1 1 1 2 0 | 1 1 1 1 0 | |
| xem giúp em | 1 1 0 2 0 | 1 0 0 1 0 | |
| theo tab Nghiệp vụ | 4 7 5 9 3 | 4 7 5 9 3 | giữ, xem mục 5 |
| Sửa để ra đúng | 0 5 0 2 0 | 0 0 0 0 0 | |
| không phải | 4 2 0 2 0 | 3 1 0 0 0 | còn 4 chỗ định nghĩa, xem mục 5 |
| "truy vấn" trong `\boicanh` | 0 0 0 0 0 | 0 0 0 0 0 | |
| mức phục vụ (cột Không dùng) | 0 0 0 0 0 | 0 0 0 0 0 | |
| `{Đúng.` (phương án đúng) | 2 2 2 2 2 | 2 2 2 2 2 | |
| `Chưa đúng.` (phương án sai) | 4 4 0 4 4 | 4 4 4 4 4 | thống nhất, mục 3 |

Kiểm thêm theo câu: lần đầu "DC" trong thân câu (ngoài tiêu đề và `\code{}`) đều là "trung tâm phân phối (DC)"; lần đầu "fill rate" trong thân câu đều kèm "(tỷ lệ lấp đầy)".

## 3. Quy ước "Đúng." / "Chưa đúng." ở bước kết luận

Chọn **dùng đủ ở mọi case**: phương án đúng mở bằng "Đúng.", phương án sai mở bằng "Chưa đúng.".

Lý do: STYLE-scm G.4 (quyết định tạm 10/11/2026 cho lô thử, mới hơn và cụ thể hơn B.6) ghi "lời giải thích dùng 'Đúng. …' / 'Chưa đúng. …'" như một cặp bắt buộc, không có điều khoản nào cho phép bỏ "Chưa đúng.". B.6 cũ ("phương án sai nêu thẳng chỗ sai") đã được G.4 thay. Gói 3 (`scm-c5`, `scm-c6`) là nơi duy nhất lệch, nên thêm 4 tiền tố ở đó. Sau sửa: 10/10 phương án đúng có "Đúng.", 20/20 phương án sai có "Chưa đúng.". Không dùng "Đúng:" hay "Sai:" ở đâu.

## 4. Mười ví dụ trước → sau

| # | Câu · phần | Trước | Sau | Loại |
|---|---|---|---|---|
| 1 | `scm-j3` · tiêu đề (Viết) | Lượt giao dịch mỗi ngày của cửa hàng loại A | Cửa hàng loại A có bao nhiêu lượt giao dịch mỗi ngày? | tiêu đề cụm danh từ |
| 2 | `scm-s3` · lời nhắn | Em đếm số lô trượt nhận trong tháng 3/2016 mà ra 0, trong khi phòng kiểm định nói tháng đó có nhiều lô trượt. Anh chị xem giúp em sai ở đâu. | Phòng kiểm định báo tháng 3/2016 có nhiều lô trượt, mà em đếm đi đếm lại vẫn ra 0. Anh chị chỉ giúp em với. | lời nhắn chép khuôn `scm-r7` |
| 3 | `scm-a6` · yêu cầu | Sửa để ra đúng; giữ nguyên cột … | Sửa theo đúng định nghĩa đó; giữ nguyên cột … | khuôn "Sửa để ra đúng" |
| 4 | `scm-j7` · `\luuy` | Mỗi ngành hàng có hai nhà cung cấp, nên biết ngành hàng vẫn chưa biết đơn do nhà cung cấp nào giao. Đơn mua đã ghi sẵn nhà cung cấp giao đơn đó. | Mỗi nhà cung cấp giao hàng về một DC, nên tổng hàng lỗi của các DC cộng lại phải bằng tổng hàng lỗi của mọi đơn mua đã về. | `\luuy` nói sẵn bẫy và cách sửa |
| 5 | `scm-c7` · `\luuy` (case) | Các tháng có số ngày khác nhau. So lượng bán giữa các tháng cần quy về bình quân mỗi ngày. | Thiếu hụt tăng có thể do lượng bán tăng hoặc do lượng nhập giảm. Hai nguyên nhân dẫn tới hai cách xử lý khác nhau. | `\luuy` loại sẵn phương án sai |
| 6 | `scm-f2` · `\luuy` | Chênh lệch của hai tỷ lệ tính bằng điểm phần trăm, không phải phần trăm thay đổi. | Chênh lệch giữa hai tỷ lệ đo bằng điểm phần trăm, bằng fill rate kỳ này trừ fill rate kỳ trước. | khuôn "X, không phải Y" |
| 7 | `scm-o6` · lời nhắn (Tối ưu) | … đọc bảng vận hành kho hai lần. Em viết lại giúp anh cho nhẹ hơn, số liệu giữ nguyên. | … đọc bảng vận hành kho hai lần. Anh cần bản nhẹ hơn mà số liệu không đổi. | câu kết lặp ở 4 câu Tối ưu |
| 8 | `scm-t5` · lời nhắn | … ghi lượng xuất của DC cao gấp nhiều lần sổ kho … | … ghi lượng xuất của trung tâm phân phối (DC) cao gấp nhiều lần sổ kho … | DC chưa giải nghĩa |
| 9 | `scm-c6` · tiêu đề (case) | Vì sao ngày cao điểm năm 2016 giao trễ nhiều? (trùng nguyên `scm-c8` gói 4) | Đơn ngày cao điểm năm 2016 chậm ở chặng nào? | tiêu đề trùng giữa gói |
| 10 | `scm-c8` · giải thích phương án | Chưa đúng. … thành phần dài nhất không phải thành phần tăng. | Chưa đúng. … thành phần dài nhất chưa chắc là thành phần tăng nhiều nhất. | khuôn "X không phải Y", đúng ý S 6582 |

## 5. Chỗ để lại và lý do

- **"theo tab Nghiệp vụ" (28 lần):** STYLE-scm B.3 quy định yêu cầu dẫn chiếu "theo tab Nghiệp vụ" khi chỉ số đã có khái niệm khai báo. Không thay bằng cách nói khác để khỏi lệch chuẩn.
- **"giúp anh / giúp chị" (40 lần):** đây là lời nhờ tự nhiên ở công sở, động từ đi kèm đã đa dạng (lấy, tính, lọc, xếp, rà, kiểm tra …). Chỉ sửa chỗ cả câu lặp nguyên văn.
- **"không phải" (4 lần còn lại):** đều là câu định nghĩa phân biệt hai khái niệm, không phải khuôn kết luận. Gồm khái niệm `bien-ln-gop` gói 1 (`margin_pct` là tỷ lệ, không phải phần trăm), khái niệm kỳ gói 2 (`ym` là chuỗi, không phải kiểu ngày), `\luuy` của `scm-r6` (lượt giao dịch, không phải số khách) và `scm-n3` (chép nguyên câu mẫu STYLE-scm B.4).
- **"không chỉ" (2 lần):** `scm-s8` ("chặn cả phía trên, không chỉ bỏ riêng một kỳ") và giải thích phương án `scm-c7`. Cả hai không phải khuôn "không chỉ … mà còn".
- **Tiêu đề có "DC", "Fill rate" chưa giải nghĩa:** `scm-a1`, `scm-j7`, `scm-c5`, `scm-t5`, `scm-f2`, `scm-c7`. Tiêu đề giới hạn 10 tiếng. Câu đầu tiên của thân câu (lời nhắn hoặc yêu cầu) đã giải nghĩa đầy đủ.
- **"mức độ phục vụ" ở `scm-f2`:** đây là cách gọi thuộc cột "Dùng" của STYLE-scm A.1, không phải "mức phục vụ" (cột Không dùng). Giữ nguyên.
- **Nhân vật lặp:** "Bạn Vy · Thực tập sinh" có ở 4 gói và "Anh Tuấn · Data engineer" ở 9 câu gói 5. Vai đúng STYLE B.2 và lời nhắn của từng câu đã khác nhau, nên giữ tên.
- **`\luuy` còn hướng dẫn ở cấp thấp:** `scm-r5` (lượng tồn lớn chưa chắc vốn tồn lớn) ở cấp Cơ bản, mà QC mục 6 cho phép chỉ dẫn rõ ở cấp này. `scm-a8` ("mã bán nhiều phải có trọng số lớn hơn …") vẫn gợi ý cách tính đúng; đề nghị người duyệt nội dung quyết có rút gọn hay không, vì câu này trùng ý với `\goiy` nấc 1.
- **Tiêu đề case mở bằng "Vì sao …?" (5 câu ở gói 3–5):** đây là dạng B.1 khuyến nghị cho Case, nội dung từng câu khác nhau, nên giữ.

## 6. Kiểm tra sau khi sửa

- Kiểm tĩnh `kiem_tra_goi.py --chi-phan-tich` (image `sqllb-tools`): gói 1–5 đều **KIEM TRA: 0 loi** (0 cảnh báo ở các câu). Báo cáo ở `cong-cu/ket-qua/scm-goi-<k>-giong/`.
- Biên dịch `cong-cu/bien_dich.sh` (XeLaTeX, image `texlive/texlive`) ra `cong-cu/ket-qua/bien-dich/scm-goi-<k>` (truyền đường dẫn ra tuyệt đối; đường dẫn tương đối làm `docker -v` báo lỗi tên volume): gói 1–5 đều **0 lỗi LaTeX**, 0 ký tự thiếu font, 0 cảnh báo `aio-sql-cauhoi`. Còn cảnh báo trình bày Overfull hbox (dòng SQL/ERD dài): 3 / 17 / 25 / 51 / 35, không thuộc phần chữ đã sửa.
