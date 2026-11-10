# Rà soát giọng văn cuối · bộ Finance AIV Bank (aivb), 100 câu, gói 1–5

Ngày 10/11/2026. Làm theo `BRIEF-RA-SOAT-GIONG.md`; chuẩn: `style/STYLE-aivb.md` (A thuật ngữ, B giọng văn, C khuôn cấm, G quyết định tạm) và `BRIEF-KIEM-GOI.md` bước 6. Lưu ý riêng của bộ: thuật ngữ theo văn bản NHNN, KYC/CASA/DTI giải nghĩa lần đầu, sản phẩm không gọi "gói", vai người hỏi khớp phạm vi số liệu, các khuôn từng bị review nêu.

Phạm vi sửa: chỉ câu chữ trong `goi-1..5/cau-hoi.tex`. Không đổi SQL, `ma`, khoá chấm (`thutu`, `saiso`, `socot`, tên cột kết quả), số liệu, cấp, cấu trúc LaTeX; không mở `solution.sql`. Mọi chỗ sửa là thay chuỗi chính xác bằng script (94 cặp trước → sau, mỗi cặp phải khớp), chạy thử trên bản sao trước rồi mới chép vào gói. Đã `diff` với bản gốc: không dòng `\begin{cauhoi}[…]` hay `\begin{buoc}[…]` nào đổi.

## 1. Số chỗ sửa theo loại

| Loại | Số chỗ | Gồm |
|---|---|---|
| Giọng AI | 25 | khuôn "X, không phải Y" (13), `\luuy` giảng kỹ thuật SQL hoặc nói sẵn bẫy (10), khuôn "mệnh đề: kết luận" (1), phương án dùng "chứ không phải" (1) |
| Dịch máy | 3 | "nó" chỉ vật (2: `\goiy` gói 2, khái niệm tăng trưởng gói 4), cụm lặp nguyên trong một câu "dư nợ bình quân của các khoản vay đang trả bình thường" (1) |
| Thuật ngữ và vai | 15 | KYC chưa giải nghĩa lần đầu (5) và bỏ giải nghĩa lặp lần hai (2); DTI chưa giải nghĩa trước khi dùng (1); "gói tiết kiệm", "gói ưu đãi" (2); "ra trễ" (1); vai không khớp phạm vi (5, xem dưới) |
| Khuôn lặp | 51 | "Sửa để ra đúng" (12), "Xét mọi …" (11), "Giữ nguyên kết quả: …" (6), câu kết lời nhắn "Anh chị xem giúp em (sai ở đâu)" và biến thể (9), "Em … giúp chị/anh" lặp (6), mở đầu "Truy vấn dưới đây có 2 lỗi. Sửa cả hai" và "sai kết quả. Sửa cho đúng" ở gói 5 (4), lời nhắn lộ cách giải hoặc nhắc kỹ thuật SQL (2), tiêu đề Sửa lỗi trùng khuôn "… bị trống" trong gói 1 (1) |
| **Tổng** | **94** | gói 1: 26 · gói 2: 19 · gói 3: 6 · gói 4: 13 · gói 5: 30 |

Vai người hỏi đổi cho khớp phạm vi (người phụ trách khách hàng cá nhân không hỏi số liệu có cả tổ chức):
- `aivb-n6-nhan-kenh-so` gói 1: Trưởng phòng khách hàng doanh nghiệp hỏi mọi lệnh ≥ 100 triệu đồng của mọi khách → Trưởng phòng phát triển sản phẩm (câu bàn hạn mức kênh số).
- `aivb-a8-khach-nop-ho-so-theo-nam` gói 2: Trưởng phòng khách hàng cá nhân, mà hồ sơ gồm cả vay doanh nghiệp → Chuyên viên thẩm định tín dụng.
- `aivb-t1-pheu-ho-so-vay-2025` gói 4: Trưởng phòng khách hàng cá nhân, mọi hồ sơ → Chuyên viên thẩm định tín dụng.
- `aivb-f5-cohort-khach-vay` gói 4: Trưởng phòng khách hàng cá nhân, "xét mọi khách hàng" → Trưởng phòng phát triển sản phẩm.
- `aivb-k9-ho-so-duyet-khong-co-khoan-vay` gói 5 (Sửa lỗi): Trưởng phòng khách hàng cá nhân, mọi hồ sơ → Chuyên viên quan hệ khách hàng.

Các câu còn lại có vai khách hàng cá nhân đều đã lọc `party_type = 'PERSON'` hoặc chỉ dùng `core_person` (đã kiểm `yeucau`).

## 2. Quét tự động trước / sau

Không có `cong-cu/quet_giong.py`; đếm bằng grep trên từng `cau-hoi.tex` (mọi dòng, kể cả khai báo và ghi chú thiết kế). Ô ghi `g1 g2 g3 g4 g5`.

| Mẫu | Trước | Sau | Ghi chú |
|---|---|---|---|
| — (gạch dài) | 0 0 0 0 0 | 0 0 0 0 0 | |
| Với mỗi | 0 0 0 0 0 | 0 0 0 0 0 | |
| Hãy | 0 0 0 0 0 | 0 0 0 0 0 | |
| không chỉ | 0 0 0 0 0 | 0 0 0 0 0 | |
| chìa khoá / bức tranh / insight / đáng chú ý | 0 | 0 | |
| một cách | 0 0 0 0 0 | 0 0 0 0 0 | |
| được thực hiện bởi / việc thực hiện | 0 | 0 | |
| " nó " | 0 1 0 1 0 | 0 0 0 0 0 | |
| đếm ngược | 0 0 0 0 0 | 0 0 0 0 0 | |
| giúp anh | 3 3 1 2 6 | 2 3 0 2 6 | |
| giúp chị | 6 5 6 5 7 | 3 5 6 4 5 | để lại, mục 5 |
| giúp em | 3 0 1 2 1 | 0 0 0 0 0 | |
| xem giúp em | 3 0 0 2 1 | 0 0 0 0 0 | |
| sai ở đâu | 2 0 0 0 1 | 0 0 0 0 0 | |
| cả kỳ dữ liệu | 0 0 0 0 0 | 0 0 0 0 0 | |
| theo tab Nghiệp vụ | 0 2 0 6 1 | 0 2 0 6 1 | giữ theo STYLE B.3 |
| Sửa để ra đúng | 6 6 0 0 0 | 0 0 0 0 0 | |
| Xét mọi | 0 4 0 2 5 | 0 0 0 0 0 | |
| Giữ nguyên kết quả | 0 0 0 0 6 | 0 0 0 0 0 | |
| không phải | 7 8 3 3 6 | 4 2 1 1 3 | 11 chỗ còn lại, mục 5 |
| "truy vấn" trong `\boicanh` | 0 0 0 0 1 | 0 0 0 0 0 | |
| trễ hạn / khoản vay xấu / tài khoản vãng lai / NPL / DPD | 0 | 0 | |
| "gói" chỉ sản phẩm (ngoài chú thích `%`, `tacgia`) | 2 0 0 0 0 | 0 0 0 0 0 | |
| cộng dồn / tích luỹ | 0 0 0 2 0 | 0 0 0 2 0 | khái niệm luỹ kế, Pareto; không phải "lãi cộng dồn" |

Kiểm thêm theo câu (awk trên từng `\begin{cauhoi}`): lần đầu KYC, CASA, DTI trong thân câu (ngoài tiêu đề, tên vai, `\code{}`) đều có giải nghĩa "nhận biết khách hàng (KYC)", "tiền gửi không kỳ hạn (CASA)", "tỷ lệ nợ trên thu nhập (DTI)". Trước sửa có 5 câu thiếu (`aivb-r3`, `aivb-c1`, `aivb-s9`, `aivb-c5`, `aivb-k8`), sau sửa 0.

## 3. Mười ví dụ trước → sau

| # | Câu · phần | Trước | Sau | Loại |
|---|---|---|---|---|
| 1 | `aivb-r7` · lời nhắn | … mà danh sách vẫn có khách đã đóng quan hệ. Anh chị xem giúp em sai ở đâu. | … mà danh sách vẫn có khách đã đóng quan hệ. Em chưa tìm ra mình lọc sai chỗ nào. | câu kết lặp ở 6 câu |
| 2 | `aivb-r7` · yêu cầu | Sửa để ra đúng danh sách. Giữ nguyên cột … | Sửa để danh sách chỉ còn khách đang hoạt động của hai phân khúc này. Giữ nguyên cột … | khuôn "Sửa để ra đúng" (12 chỗ) |
| 3 | `aivb-n1` · lời nhắn | … chưa đi làm hoặc đã nghỉ hưu để giới thiệu gói tiết kiệm. Em lọc giúp anh những người … | … để giới thiệu sản phẩm tiền gửi tiết kiệm. Anh cần những người … | sản phẩm gọi "gói" |
| 4 | `aivb-n5` · `\luuy` | Phép tính có một vế NULL thì kết quả cũng là NULL. | Tài khoản chưa đóng vẫn được duy trì tới ngày tham chiếu. | `\luuy` giảng kỹ thuật SQL |
| 5 | `aivb-n2` · `\luuy` | `income_band` là khoảng thu nhập mỗi tháng, không phải số tiền. Mỗi khoảng phải vào đúng một nhóm; khoảng nào bị bỏ sót sẽ ra ô trống. | `income_band` ghi khoảng thu nhập mỗi tháng dưới dạng mã. Mỗi khoảng thu nhập thuộc đúng một nhóm. | "X, không phải Y" và nói sẵn bẫy |
| 6 | `aivb-a8` · vai | Chị Phương · Trưởng phòng khách hàng cá nhân (hồ sơ gồm cả vay doanh nghiệp) | Chị Phương · Chuyên viên thẩm định tín dụng | vai không khớp phạm vi |
| 7 | gói 4 · ba khoản vay lớn nhất mỗi chi nhánh · `\luuy` | Dư nợ khác số tiền vay ban đầu: khoản vay lớn lúc giải ngân có thể đã trả bớt nhiều. | Khoản vay lớn lúc giải ngân có thể đã trả bớt nhiều, nên dư nợ có thể nhỏ hơn hẳn số tiền vay ban đầu. | khuôn "mệnh đề: kết luận" |
| 8 | gói 5 · Tối ưu hồ sơ duyệt chưa có khoản vay · `\luuy` | Mã hồ sơ đã có sẵn trong bảng khoản vay, nên kiểm "đã có khoản vay chưa" không cần đi qua bảng hồ sơ lần nữa. | Mỗi khoản vay ghi mã hồ sơ vay mà khoản vay đó được giải ngân theo. | `\luuy` nói sẵn cách giải |
| 9 | gói 5 · Tối ưu lệnh QR · yêu cầu | Giữ nguyên kết quả: một dòng, `so_lenh` và `tong_tien` … | Kết quả vẫn là một dòng gồm `so_lenh` và `tong_tien` … | khuôn "Giữ nguyên kết quả:" (6 câu Tối ưu) |
| 10 | `aivb-k8` · lời nhắn | Em lập danh sách hồ sơ KYC xử lý quá lâu … Anh chị xem giúp em sai ở đâu. | Em lập danh sách hồ sơ nhận biết khách hàng (KYC) xử lý quá lâu … (bỏ câu kết) | KYC chưa giải nghĩa; câu kết lặp |

Ví dụ khác: lời nhắn Data engineer gói 5 "Anh thấy truy vấn con đọc lại cả danh sách hồ sơ" → "Anh thấy báo cáo đọc danh sách hồ sơ thêm một lượt chỉ để kiểm hồ sơ đã có khoản vay chưa" (bỏ thuật ngữ SQL trong lời nhắn); "Anh nhờ em xem lại điều kiện lọc ngày" → "Anh nhờ em xem vì sao chậm" (không lộ chỗ sửa).

## 4. Kiểm tra sau khi sửa

- Kiểm tĩnh `kiem_tra_goi.py --chi-phan-tich` (image `sqllb-tools`): gói 1–5 đều **KIEM TRA: 0 loi**, 0 cảnh báo ở các câu. Báo cáo ở `cong-cu/ket-qua/aivb-goi-<k>-giong/`.
- Biên dịch `cong-cu/bien_dich.sh` ra `cong-cu/ket-qua/bien-dich/aivb-goi-<k>`: gói 1–5 đều **0 lỗi LaTeX**, 0 ký tự thiếu font, 0 cảnh báo `aio-sql-cauhoi` (PDF 43 / 44 / 48 / 59 / 61 trang). Còn cảnh báo trình bày Overfull hbox (dòng SQL/ERD dài): 27 / 51 / 59 / 119 / 57, không thuộc phần chữ đã sửa.

## 5. Chỗ để lại và lý do

- **"không phải" (11 lần):** 4 lần trong `\khaibaokhainiem` chép nguyên từ STYLE-aivb mục E (ghi Nợ "không phải khoản vay", kỳ `'DUE'` "không phải kỳ quá hạn", `approval_rate` "không phải tỷ lệ duyệt thực tế"); 6 lần trong `\ghichuthietke` (ghi chú cho người duyệt, không hiện với học viên); 1 lần trong lời nhắn gói 4 ("trạng thái không phải đang quá hạn", mô tả đúng điều kiện lọc khác `'DELINQUENT'`).
- **"Em … giúp chị/anh" (33 lần):** lời nhờ tự nhiên ở công sở, động từ đi kèm đã đa dạng (lọc, tính, đếm, đối chiếu, đối soát, rà, lấy …). Chỉ sửa chỗ lặp cả câu hoặc dồn nhiều lần trong một gói.
- **"theo tab Nghiệp vụ" (9 lần):** STYLE B.3 quy định dẫn chiếu khi chỉ số đã có khái niệm khai báo.
- **Mở đầu yêu cầu câu Sửa lỗi "Truy vấn dưới đây cần …"** (gói 1, 2, 4) và **"Sửa truy vấn khởi đầu …"** (gói 3): là khung câu của dạng Sửa lỗi; vế sau đã nêu triệu chứng riêng của từng câu, nên giữ.
- **`\luuy` còn chỉ dẫn ở cấp Cơ bản:** `aivb-r1` (mã miền không dấu, viết hoa), `aivb-r3` (mã chi nhánh dạng `'CN01'`), gói 3 câu miền nhiều khách nhất. QC cho phép chỉ dẫn rõ ở cấp này.
- **Tên phân khúc "giàu có", "đại chúng", "khá giả":** gói 1 và gói 3 gọi `'AFFLUENT'` là "giàu có", trong khi bảng gợi ý ở STYLE A.1 ghi "khá giả". STYLE nói ưu tiên `ref_segment.segment_name`; chưa đối chiếu giá trị DB trong lần rà này nên giữ nguyên. **CẦN NGƯỜI NẮM DOMAIN** xác nhận theo `segment_name`.
- **Tên nhân vật lặp với vai khác nhau giữa các gói** (ví dụ "Chị Hạnh" là Trưởng phòng phát triển sản phẩm, Trưởng phòng quản lý rủi ro tín dụng, Chuyên viên thẩm định tín dụng ở các gói khác nhau): không sai vai trong từng câu; đổi tên không thuộc giọng văn nên để lại, đề nghị người duyệt quyết.
- **"cộng dồn" (2 lần, gói 4):** dùng trong định nghĩa luỹ kế và phân tích Pareto (tổng tích luỹ), không phải cách gọi lãi bị STYLE A.5 cấm.
