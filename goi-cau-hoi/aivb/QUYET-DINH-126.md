# Quyết định 126 điểm – bộ `aivb`, phần gói 1–3

Ngày 10/11/2026. Bộ aivb có 34 điểm trong `BAO-CAO-TONG-HOP.md` mục 3; 19 điểm thuộc gói 1–3 ghi ở đây, 15 điểm gói 4–5 (c10, c7, t9, f6, t1, t2, t6, f5, k5, k2, k4, f7, k6, t5, p9) ở `QUYET-DINH-126-g45.md`. Chi tiết từng điểm (căn cứ, việc đã sửa) ở mục "Quyết định v3 (10/11)" của `goi-<k>/DA-SUA.md`.

Nguồn domain (chỉ đọc): `H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\Finance\05_eDA_parameter_book_mini_core_banking_v5.1.5.xlsx` (PB: sheet 02.Model Contract, 05.Account Ownership, 07.Deposit, 08.Lending, 14.Analytical scenarios), `...\Finance\Bang_phan_loai_datamart_va_data_dictionary_AIVBank_v5.1.6.3.xlsx` (DD); `ref_segment` trong DB; Thông tư 32/2024/TT-NHNN (mạng lưới hoạt động của NHTM, Điều 3); Luật Các TCTD 2024 Điều 4 (https://hethongphapluat.com/luat-cac-to-chuc-tin-dung-2024/dieu-4); TT31/2024/TT-NHNN Điều 3 (đã có trong STYLE-aivb mục 0); `QUYET-DINH-CHUNG.md`.

| # | Mục BAO-CAO | Mã | Điểm | Trạng thái | Quyết định, căn cứ ngắn |
|---|---|---|---|---|---|
| 1 | 3.1 | aivb-n9, aivb-c2 (g1) | dòng đúng biên trong hidden-1 | Đã sửa | File 04 mục (l) thêm 2 quan hệ `JOINT_OWNER` đúng biên 30/06/2026; n9 thêm 2 wrong ở biên (rớt hidden-1). c2: biên 01/02/2027 đã có sẵn ở cả hai biến thể, thêm wrong `BETWEEN` |
| 2 | 3.1 | aivb-c2 (g1) | mốc "hiện tại" | Giữ nguyên | Mốc chốt 04/01/2027 đã ghi trong yêu cầu b1; dữ liệu không có hợp đồng `'ACTIVE'` đến hạn trước 05/01/2027 |
| 3 | 3.2 | aivb-c1 (g1) | DTI cho hồ sơ doanh nghiệp | Đã sửa | Giữ SQL; `\luuy` nêu dữ liệu ghi DTI cho mọi hồ sơ (PB sheet 02, DD) và giới hạn khi thẩm định doanh nghiệp |
| 4 | 3.3 | aivb-n4 (g1) | nhãn giai đoạn | Đã sửa | Đổi SQL: nhãn theo phần dư nợ còn lại, cột `nhom_con_lai`, tiêu đề mới (PB 08.Lending: MORT trả góp đều, WC_LOAN trả gốc cuối kỳ) |
| 5 | 3.3 | aivb-q1 (g3), STYLE A.4 | cách gọi 'ACTIVE' | Đã sửa | STYLE A.4 chốt "đang trả nợ bình thường" (PB 08.Lending: DELINQUENT khi DPD > 0); gói đã dùng đúng |
| 6 | 3.3 | aivb-n6 (g1) | "kênh vật lý" | Giữ nguyên | Lời nhắn đã giải nghĩa quầy, ATM, POS; ghi STYLE mục H; ghi chú thiết kế bỏ chữ "chờ" |
| 7 | 3.3 | aivb-n1, aivb-n7 (g1) | khung "ô trống = không áp dụng" | Giữ nguyên | Dữ liệu: `occupation_code` trống đúng ở RETIRED, STUDENT; số tiền duyệt chỉ có khi duyệt |
| 8 | 3.3 | aivb-a1 (g2) | "dư nợ bình quân" | Đã sửa | Yêu cầu "mỗi khoản vay"; `\luuy` phân biệt với bình quân theo thời gian; SQL giữ |
| 9 | 3.3 | aivb-a3 (g2) | chiều hạng A–D | Giữ nguyên | PB 08.Lending coi A rủi ro thấp nhất, nhưng tỷ lệ duyệt không đơn điệu; câu chỉ đếm |
| 10 | 3.3 | aivb-a6 (g2) | "khoản vay có vấn đề" | Giữ nguyên | Đề đã liệt kê đủ ba trạng thái; PB 08.Lending, TT31 Điều 3 |
| 11 | 3.3 | khái niệm `chi-nhanh` (g1, g2) | đối chiếu luật | Đã sửa | Viết lại theo TT32/2024 Điều 3, chép giống nhau ở g1, g2 |
| 12 | 3.3 | aivb-j5 (g3) | `principal` của thấu chi | Đã sửa | Là hạn mức (PB 08.Lending: revolving, hạn mức bằng 3 lần lương); thêm `\luuy`, giữ SQL |
| 13 | 3.3 | aivb-j7 (g3) | đồng chủ tài khoản | Giữ nguyên | Thư chỉ gửi `'PRIMARY_OWNER'`, câu không nhận định pháp lý (PB 05.Account Ownership: JOINT_OWNER là đồng sở hữu) |
| 14 | 3.3 | aivb-q3 (g3) | `'RENEWED'` | Giữ nguyên | PB 07.Deposit: tái tục tạo hợp đồng mới; lãi suất đang áp ở hợp đồng `'ACTIVE'` |
| 15 | 3.4 | aivb-j6, aivb-q9 (g3) | gần cấp dưới | Đã sửa | Theo QUYET-DINH-CHUNG 2.3: j6 thêm cột tổng và bẫy lọc ở `WHERE`; q9 starter thêm lỗi cận dưới, thêm wrong `chi_sua_can_tren` |
| 16 | 3.4 | aivb-q2 (g3) | Dễ → Trung bình | Giữ nguyên | QUYET-DINH-CHUNG 2.3 dòng 5 (chấp nhận) |
| 17 | 3.6 | aivb-s8 (g2) | mã chứa "hoan" | Đã sửa | Đổi thành `aivb-s8-lenh-bi-dao-theo-thang` ở cau-hoi.tex, solution.sql, BANG-PHAN-CONG.md, DA-SUA.md, BAN-DO-100-CAU.md |
| 18 | 3.8 | `'AFFLUENT'` (g1, g3) | "giàu có" hay "khá giả" | Giữ nguyên (gói); sửa STYLE | DB `segment_name`: AFFLUENT "giàu có", UPPER_MASS "khá giả"; gói đã đúng, STYLE A.1 và F.8 sửa theo DB |
| 19 | 3.8 | tên nhân vật (cả bộ) | một tên nhiều vai | Đã sửa | Mỗi vai một tên, mỗi tên một vai, cùng bảng với `QUYET-DINH-126-g45.md` (chép vào STYLE-aivb mục H); đổi 35 lời nhắn ở g1–3 (g1 15, g2 11, g3 9), đổi giới thì đổi đại từ; sau khi đổi, cả 5 gói có đúng 16 cặp tên – vai |

Áp quyết định chung (`QUYET-DINH-CHUNG.md`) ở gói 1–3: mục 1.3 (ERD Dễ 1 bảng nhiễu: R4, R5, R6, R9, N3–N6, N8, N9 giữ, R4 bỏ chữ "chờ"); mục 1.1 sau khi sửa theo quy chuẩn (0.1 #1, gói mẫu c1–c4): 6 case c1–c6 đổi "Đúng. " thành "Đúng: " ở phương án đúng, bỏ "Chưa đúng. " ở 14 phương án sai; mục 2.3 dòng 2, 5 (j6, q9 thêm bẫy/lỗi; q2 giữ Trung bình; q9 có hai lỗi nên vẫn là Trung bình theo 0.1 #5).

Kiểm: `cong-cu/kiem_tra_goi.py` đầy đủ (public + hidden-1) cho gói 1, 2, 3 sau khi áp file 04; kết quả ở `cong-cu/ket-qua/kiem-cuoi/aivb-goi-<k>/log.txt`.

Kết quả 10/11 (sau mọi sửa đổi): bộ kiểm đầy đủ g1 0 lỗi, g2 0 lỗi, g3 0 lỗi (lượt chạy lẫn với nhiều bộ kiểm song song từng báo aivb-j8 quá 180 giây; chạy riêng 0 lỗi, j8 không sửa); phân tích tĩnh g1–3 0 lỗi; biên dịch XeLaTeX g1–3 0 lỗi, 0 ký tự thiếu.
