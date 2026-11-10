# Rà soát giọng văn cuối · bộ HR (100 câu, gói 1–5)

Ngày 10/11/2026. Làm theo `BRIEF-RA-SOAT-GIONG.md`; chuẩn: `style/STYLE-hr.md` (A, B, C), `style/STYLE-scm.md` (B, C kế thừa), `BRIEF-KIEM-GOI.md` bước 6.
Lưu ý riêng của bộ: "ứng viên" là thuật ngữ đúng của tuyển dụng (giữ); "thang lương thị trường" → "mức lương thị trường"; "làm tròn 0 chữ số" → "làm tròn đến hàng đơn vị"; khuôn "Em … giúp anh/chị" và "Tính cho từng …" kiểm trên cả bộ.

Phạm vi sửa: chỉ câu chữ trong `goi-1..5/cau-hoi.tex`. Không đổi SQL, `ma`, khoá chấm, số liệu, cấp, cấu trúc LaTeX; không mở `solution.sql`.
Kiểm bằng máy sau khi sửa (so với bản sao trước khi sửa): mọi `\code{…}` giống hệt; mọi dòng mở `\begin{cauhoi}[…]` / `\begin{buoc}[…]` giống hệt; số lệnh LaTeX và số ngoặc `{}` không đổi; số trong văn chỉ mất 9 chữ số "0" (8 chỗ "làm tròn 0 chữ số", 1 chỗ "không phải giá trị 0" ở `\luuy` câu `hr-k5`).

## 1. Số chỗ sửa theo loại

| Loại | Số chỗ | Gồm |
|---|---|---|
| Khuôn lặp giữa các gói | 83 | 42 lời nhắn `\boicanh` (khuôn "Em … giúp anh/chị", "Anh chị xem giúp em", "Anh/Chị cần biết", "thấp hơn hẳn mặt bằng thị trường"); 20 lời giải thích phương án sai mở bằng "Chưa đúng."; 8 `\luuy`/`\goiy` khuôn "X là …, không phải Y" (có "Mẫu số là …, không phải …" lặp ở gói 1, 2, 3); 6 dòng mở tab Nghiệp vụ "Quyết định có … hay không"; 4 "theo tab Nghiệp vụ"; 3 "Tính cho từng …" |
| Thuật ngữ, cách viết thống nhất | 18 | 8 "làm tròn 0 chữ số" → "làm tròn đến hàng đơn vị"; 10 dấu `--` ở gói 1, 2 → "–" như gói 3–5 ("Chuyên viên tiền lương – phúc lợi", "nhân viên – tháng", "nước – phòng ban") |
| Giọng AI | 5 | 3 từ nhấn "hẳn" chỉ có ở phương án đúng (K32); 1 câu lặp ý trong lời giải thích; 1 "rõ ràng" đệm |
| Dịch máy | 2 | "không phải là trường hợp cần đếm"; "bước 3 và bước 2" (đảo thứ tự) |
| Lời nhắn nhắc kỹ thuật | 2 | "truy vấn" trong `\boicanh` (`hr-s8`, `hr-a7`) |
| **Tổng** | **110** | gói 1: 18 · gói 2: 23 · gói 3: 11 · gói 4: 32 · gói 5: 26 |

Theo khuôn lời nhắn trên cả bộ: "giúp anh/chị/em" 38 → 11 (mỗi gói còn 1–5, các động từ khác nhau); "Anh chị xem giúp em" của thực tập sinh 6 → 2; "Anh/Chị cần" sau lượt 1 tăng lên 37 nên lượt 2 đổi tiếp 12 chỗ thành câu hỏi hoặc câu nêu hạn, còn 26 (dàn đều 4–7 mỗi gói).

## 2. Mẫu quét trước / sau

Không có `cong-cu/quet_giong.py`; quét bằng script đếm chuỗi (Python trong image `sqllb-tools`) trên 5 file `cau-hoi.tex`. Mẫu "truy vấn", "SQL" chỉ đếm trong `\boicanh`.

| Mẫu | Trước g1 | g2 | g3 | g4 | g5 | **Tổng trước** | Sau g1 | g2 | g3 | g4 | g5 | **Tổng sau** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `—` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `Với mỗi` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `Hãy ` / `hãy ` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `không chỉ` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `chìa khoá` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `bức tranh` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `insight` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `đáng chú ý` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `một cách ` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `được thực hiện bởi` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `việc thực hiện` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| ` nó ` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `đếm ngược` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `giúp anh` | 1 | 1 | 1 | 8 | 6 | **17** | 0 | 1 | 1 | 2 | 2 | **6** |
| `giúp chị` | 3 | 0 | 0 | 7 | 5 | **15** | 1 | 0 | 0 | 1 | 1 | **3** |
| `giúp em` | 1 | 0 | 2 | 1 | 2 | **6** | 0 | 0 | 1 | 0 | 1 | **2** |
| `xem giúp em` | 1 | 0 | 2 | 1 | 2 | **6** | 0 | 0 | 1 | 0 | 1 | **2** |
| `cả kỳ dữ liệu` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `theo tab Nghiệp vụ` | 0 | 0 | 0 | 4 | 1 | **5** | 0 | 0 | 0 | 1 | 0 | **1** |
| `Sửa để ra đúng` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `không phải` | 7 | 5 | 2 | 4 | 4 | **22** | 3 | 2 | 1 | 4 | 3 | **13** |
| `truy vấn` trong `\boicanh` | 0 | 2 | 0 | 0 | 0 | **2** | 0 | 0 | 0 | 0 | 0 | **0** |
| `SQL` trong `\boicanh` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `thang lương thị trường` | 0 | 0 | 0 | 0 | 0 | **0** | 0 | 0 | 0 | 0 | 0 | **0** |
| `làm tròn 0 chữ số` | 1 | 0 | 2 | 1 | 4 | **8** | 0 | 0 | 0 | 0 | 0 | **0** |
| `Tính cho từng` | 2 | 1 | 0 | 0 | 0 | **3** | 0 | 0 | 0 | 0 | 0 | **0** |
| `Em xem giúp` | 1 | 0 | 0 | 2 | 1 | **4** | 0 | 0 | 0 | 0 | 0 | **0** |
| `Chưa đúng` (phương án) | 4 | 4 | 4 | 4 | 4 | **20** | 0 | 0 | 0 | 0 | 0 | **0** |
| `Quyết định có` (tab Nghiệp vụ) | 2 | 3 | 1 | 3 | 3 | **12** | 0 | 1 | 1 | 1 | 3 | **6** |
| ` -- ` | 1 | 9 | 0 | 0 | 0 | **10** | 0 | 0 | 0 | 0 | 0 | **0** |
| `hẳn` | 0 | 3 | 2 | 3 | 4 | **12** | 0 | 2 | 0 | 1 | 4 | **7** |
| `ứng viên` (giữ, đúng nghĩa) | 1 | 0 | 1 | 1 | 3 | **6** | 1 | 0 | 1 | 1 | 3 | **6** |

## 3. Mười ví dụ trước → sau

| # | Câu · phần | Trước | Sau | Lý do |
|---|---|---|---|---|
| 1 | `hr-t6` · boicanh | Anh đang lập ngân sách lương năm 2026. Em tính giúp anh tháng 12/2025 mỗi phòng ban chiếm bao nhiêu phần quỹ lương và bao nhiêu phần quân số. | Anh đang lập ngân sách lương năm 2026. Tháng 12/2025 mỗi phòng ban chiếm bao nhiêu phần quỹ lương và bao nhiêu phần quân số? | Gói 4 có 15/20 lời nhắn theo khuôn "Em [động từ] giúp anh/chị …" |
| 2 | `hr-t4` · boicanh | Em lập giúp anh danh sách mọi người nằm dưới quyền nhân viên E01688, ghi rõ mỗi người cách E01688 mấy cấp. | Những ai đang nằm dưới quyền nhân viên E01688, và mỗi người cách E01688 mấy cấp? | khuôn lặp "Em … giúp anh" |
| 3 | `hr-p4` · boicanh | … sang năm mới lại phải chép thêm một đoạn. Em gộp lại giúp anh. | … sang năm mới lại phải chép thêm một đoạn. Anh muốn báo cáo tự chạy được cho năm mới mà không cần sửa. | khuôn lặp; "gộp" gợi sẵn cách giải |
| 4 | `hr-a7` · boicanh | Em gửi kèm truy vấn để anh chị kiểm tra. | Em gửi kèm bản tính để anh chị kiểm tra. | lời nhắn không nhắc kỹ thuật SQL |
| 5 | `hr-n7` · boicanh (thực tập sinh) | … thấp hơn số của chị phụ trách đào tạo. Anh chị xem giúp em sai ở đâu. | … thấp hơn số của chị phụ trách đào tạo. Em không biết mình tính lệch ở bước nào. | "Anh chị xem giúp em (sai ở đâu)" lặp 6 lần ở 4 gói |
| 6 | `hr-c1` (và 19 phương án sai khác) · phuongan | {Chưa đúng. Tháng 12 có nhiều nhân viên có tên nhất nhưng số người nghỉ không cao nhất; …} | {Tháng 12 có nhiều nhân viên có tên nhất nhưng số người nghỉ không cao nhất; …} | STYLE B.6: phương án sai nêu thẳng chỗ sai; 20/20 phương án sai mở cùng một khuôn |
| 7 | `hr-c8` · phuongan* | Người nghỉ ở phòng Kỹ thuật có compa-ratio thấp hơn hẳn người ở lại … | Người nghỉ ở phòng Kỹ thuật có compa-ratio thấp hơn người ở lại … | K32: từ nhấn chỉ xuất hiện ở phương án đúng (cũng sửa ở `hr-c6`, `hr-c7`) |
| 8 | `hr-a3` · goiy | Mẫu số là quân số bình quân của 12 tháng, không phải số người khác nhau. | Đếm số người khác nhau trong năm sẽ cho mẫu số lớn hơn quân số bình quân của 12 tháng. | khuôn "Mẫu số là X, không phải Y" lặp ở `hr-n4`, `hr-a3`, `hr-c6` |
| 9 | `hr-c2` · yeucau | Tính cho từng phòng ban số dòng, số dòng thiếu điểm gắn kết hằng tháng (…) và tỷ lệ thiếu bằng … | Đếm số dòng và số dòng thiếu điểm gắn kết hằng tháng (…) của từng phòng ban; tỷ lệ thiếu bằng … | trật tự "Tính cho từng X [danh sách dài]" khó đọc, lặp ở 3 câu |
| 10 | `hr-c9` · yeucau | \code{luong_p50_bq} (USD, làm tròn 0 chữ số) | \code{luong_p50_bq} (USD, làm tròn đến hàng đơn vị) | cách nói chuẩn của sách giáo khoa toán; 8 chỗ ở gói 1, 3, 4, 5 |

Ví dụ khác cùng loại: tab Nghiệp vụ `hr-r3` "Quyết định có tăng thưởng giới thiệu để mở rộng kênh tuyển này hay không." → "Cân nhắc tăng thưởng giới thiệu để mở rộng kênh tuyển này."; `hr-t7` "Xét nhân viên mới theo tab Nghiệp vụ, …" → "Xét nhân viên mới (định nghĩa ở tab Nghiệp vụ), …".

## 4. Chỗ còn để lại và lý do

- **"ứng viên" (6 chỗ):** đúng nghĩa người dự tuyển (khái niệm `thoi-gian-tuyen`, `\quytrinh` và `\goiy` của `hr-c9`), được STYLE-hr A.5 cho phép.
- **"thang lương" (2 chỗ, `hr-a2`):** nghĩa bảng/thang lương của công ty (BLLĐ Điều 93), không phải "thang lương thị trường". Cả bộ không có chỗ "thang lương thị trường".
- **"không phải" (13 chỗ):** còn ở khai báo khái niệm (ô trống không phải 0 ngày; chỉ mục giúp không phải đọc cả bảng), `\luuy` về điểm phần trăm, ngưỡng 60 tuổi, `\ghichuthietke` và một phương án sai. Đây là phân biệt khái niệm cần thiết, mỗi gói tối đa 4, không cùng một câu mở.
- **"giúp anh/chị" (9) và "Anh/Chị cần" (26) trong lời nhắn:** giữ vì là lời nói công sở tự nhiên; đã dàn đều, không gói nào còn quá 2 "giúp anh" hay 1 "giúp chị".
- **"Quyết định có … hay không" (6 dòng mở tab Nghiệp vụ):** đúng mẫu của STYLE-scm B.4; chỉ đổi phần lặp nhiều.
- **"theo tab Nghiệp vụ" (1 chỗ, `hr-t2`):** câu dẫn chiếu định nghĩa quân số cuối tháng 12, đúng mẫu STYLE-scm B.3.
- **"hẳn" (7 chỗ):** ở lời nhắn ("thấp hơn hẳn thị trường"), `\ghichuthietke`, khai báo khái niệm điểm nóng; không còn ở phương án.
- **Tiêu đề `hr-r4` "Account Executive nào ở Indonesia đi công tác nhiều nhất?":** giữ vì là giá trị `job_role` trong DB và STYLE-hr chưa có tên tiếng Việt cho chức danh này. Cần giảng viên chốt.
- **Phương án đúng của `hr-c6`, `hr-c8` có câu rào "theo dõi thêm / cần xác nhận thêm" mà phương án sai không có (K32):** chưa sửa vì thêm hay bớt ý rào làm đổi nội dung kết luận. Đề nghị người soạn gói 3, 4 cân lại.
- **`\ghichuthietke`:** ghi chú cho người duyệt, còn từ chuyên môn tiếng Anh (starter, wrong, hidden-1, LAG, PARTITION BY); không hiện cho học viên nên không sửa.

## 5. Kiểm sau khi sửa

- Kiểm tĩnh `kiem_tra_goi.py --chi-phan-tich` (ra `cong-cu/ket-qua/hr-goi-<k>-giong/`): gói 1–5 đều `KIEM TRA: 0 loi`.
- Biên dịch `cong-cu/bien_dich.sh` (ra `cong-cu/ket-qua/bien-dich/hr-goi-<k>/`): cả 5 gói tạo PDF (43, 44, 45, 57, 55 trang), 0 lỗi LaTeX, 0 ký tự thiếu trong font, 0 cảnh báo `aio-sql-cauhoi`.
- Bản trước khi sửa và các script quét/sửa nằm ở scratchpad của phiên (không đưa vào gói); các thay đổi đều là thay chuỗi chính xác, mỗi chuỗi được kiểm khớp đúng số lần trước khi ghi.
