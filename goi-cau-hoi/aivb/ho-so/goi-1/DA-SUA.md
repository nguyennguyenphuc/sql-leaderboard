# DA-SUA · gói 1 bộ AIV Bank (`aivb`) · bản v2 (10/11/2026)

Sửa theo REVIEW-B.md và REVIEW-C.md. Không sửa database, không sửa biến thể ẩn. Mã câu giữ nguyên.
Kiểm lại:
- **R9** (câu duy nhất đổi SQL): gói tạm `cong-cu/ket-qua/sua/aivb-goi-1/`, bộ kiểm chạy thật, `KIEM TRA: 0 loi`; hai wrong rớt public và hidden-1.
- **Cả gói**: phân tích tĩnh (`--chi-phan-tich`), `KIEM TRA: 0 loi`.
- **Biên dịch**: `bien_dich.sh` ra `aivb-goi-1`, 43 trang, 0 lỗi LaTeX, 0 ký tự thiếu.

| mã | đã sửa gì | kiểm lại |
|---|---|---|
| aivb-r1-chi-nhanh-mien-nam | B(2): viết lại `\luuy` có chủ ngữ ("Cột region ghi miền…"), bỏ vế "không lọc theo thành phố" (giải sẵn bẫy). B(1): ghi chú rõ hidden-1 không đổi `ref_branch`, chuyển Chờ giảng viên | tĩnh |
| aivb-r2-phien-ban-tien-gui-ca-nhan | C(2) "mã của chúng" → "các mã này"; C(3) gợi ý nói đủ cả sản phẩm đã dừng bán (`TD_LEG`); C(1) chuyển Chờ giảng viên | tĩnh |
| aivb-r3-kyc-khong-dat-cn01 | B(2) bối cảnh "bị đánh giá KYC không đạt"; B(3) "mã giao dịch" → "mã chi nhánh dạng 'AIVB_CN01' (branch_code)" ở `\luuy` và khai báo `chi-nhanh`; B(4) dòng mở nghiệp vụ; B(1) chuyển Chờ giảng viên | tĩnh |
| aivb-r4-top-5-khoan-vay-du-no | C(3)(4)(5) sửa `\luuy`, `\goiy`, `yeucau` ("dạng tỷ lệ theo năm, không đổi sang phần trăm"); bỏ khuôn gợi ý "Câu chỉ cần bảng…"; C(1) không có hidden-2 nên ghi chú và chuyển Chờ giảng viên; C(2) bảng ERD không dùng, chuyển Chờ giảng viên | tĩnh |
| aivb-r5-lenh-web-bi-tu-choi | B(1) tiêu đề "trong tháng 12/2026"; B(2) "lệnh chuyển tiền"; B(3) bỏ câu "Hai trạng thái này là hai việc khác nhau."; B(4) `bay` `thieu-can-tren` → `quen-desc`; gợi ý nấc 1 thành hướng nghĩ nghiệp vụ | tĩnh |
| aivb-r6-ho-so-vay-nha-hang-a-2025 | C chấm oan: thống nhất mốc "nộp năm 2025" ở tiêu đề ("Hồ sơ vay mua nhà hạng A nộp năm 2025 nào được duyệt?"), bối cảnh, yêu cầu ("không xét ngày ra quyết định"); C(3) "Xét hồ sơ vay mua nhà"; không viết "hạng tốt nhất" (tỷ lệ duyệt theo hạng của hồ sơ cá nhân không đơn điệu); C(4) chuyển Chờ giảng viên | tĩnh (SQL không đổi) |
| aivb-r7-khach-uu-tien-hoat-dong | Khuôn `\luuy` giải sẵn bẫy (B): đổi thành quy tắc nghiệp vụ, không chỉ chỗ AND/OR; dữ liệu chuyển Chờ giảng viên | tĩnh |
| aivb-r8-tien-gui-lai-suat-tren-6 | C cấp: hạ `cap=easy` → `basic` (một lỗi dễ thấy), ERD còn 1 bảng; C(6) giá trị mẫu thật `0.0520`; C(3) tiêu đề có "có", đổi khuôn "ra 0 dòng" thành "bị trống"; C(4) bối cảnh không chữ kỹ thuật; C(5) `\luuy`; ghi chú nêu "6–12 tháng" thực chất là 12 tháng và hai wrong trùng kết quả starter | tĩnh |
| aivb-r9-but-toan-co-lon-nhat | B(1) 20 → 25 bút toán (bối cảnh, yêu cầu, starter, solution, 2 wrong); ghi chú thiết kế viết lại đúng sự thật; B(2) "trong ngày giao dịch"; B(3) "toàn khoản mười nghìn đồng" (đã kiểm: 25 dòng của starter đều 10.000 đồng) | **chạy thật, gói tạm: 0 lỗi** |
| aivb-n1-ca-nhan-thieu-nghe-nghiep | C tiền đề sai: NULL nghề nghiệp = người nghỉ hưu, học sinh, sinh viên. Đổi bối cảnh (giới thiệu gói tiết kiệm cho người chưa đi làm hoặc đã nghỉ hưu, bỏ "Chi nhánh Huế"), dòng mở nghiệp vụ, `\luuy`; ERD `employment_status*='RETIRED'` | tĩnh |
| aivb-n2-nhom-thu-nhap | B tuỳ chọn: bỏ "do khách khai"; dữ liệu chuyển Chờ giảng viên | tĩnh |
| aivb-n3-so-tien-con-thieu-ky-qua-han | C(2) "Kỳ đã huỷ thì khách không còn phải trả."; C(1) chuyển Chờ giảng viên | tĩnh |
| aivb-n4-ty-le-du-no-con-lai | B(2) bối cảnh thành "rà mức thu hồi nợ gốc của danh mục cho vay" (không còn hứa ước dòng tiền năm tới), dòng mở nghiệp vụ tương ứng; ghi chú làm tròn 4 chữ số của phép chia; B(1) tên nhãn chuyển Chờ giảng viên | tĩnh |
| aivb-n5-so-ngay-tai-khoan-mo | C(1)(2) "đã hoạt động", "gắn bó" → "đã duy trì được"; C(3) chuyển Chờ giảng viên | tĩnh |
| aivb-n6-nhan-kenh-so | B(1) `\luuy` → "Số tiền lưu bằng đồng, không quy đổi sang triệu đồng." (bỏ con số viết sẵn và câu nhắc QR, API); B(2) chuyển Chờ giảng viên | tĩnh |
| aivb-n7-quyet-dinh-thieu-so-tien-duyet | C tiền đề sai: dòng mở nghiệp vụ "Đối chiếu các quyết định từ chối…", `\luuy` "Quyết định từ chối không có số tiền được duyệt…"; C(1) tiêu đề "Danh sách quyết định không có số tiền được duyệt bị trống"; C(2) bối cảnh không "truy vấn"; C(4) `\luuy` NULL | tĩnh |
| aivb-n8-nhom-tuoi | B(1) tiêu đề đúng triệu chứng: "Khách từ 40 tuổi bị xếp vào nhóm 25–39"; B(2) chuyển Chờ giảng viên | tĩnh |
| aivb-n9-dong-so-huu-con-hieu-luc | C(1) bối cảnh không "truy vấn", bỏ "trong khi"; C(2) tiêu đề "Danh sách đồng chủ tài khoản ngày 30/06/2026 bị thiếu"; C(3) chuyển Chờ giảng viên | tĩnh |
| aivb-c1-ho-so-doanh-nghiep-bi-tu-choi | B(1) giá trị mẫu ERD không còn là dòng đáp án (đổi sang hồ sơ `OD_BIZ` được duyệt năm 2025); B(3) phương án đúng chỉ mô tả ("không có hạng điểm thấp hay DTI cao"), bỏ vế "chưa giải thích được"; lời giải thích phương án 4 bỏ khuôn "mệnh đề: kết luận"; DTI cho doanh nghiệp chuyển Chờ giảng viên | tĩnh |
| aivb-c2-tien-gui-sap-dao-han | C(1) b1 thêm mục "Dữ liệu tiền gửi chốt ngày 04/01/2027: hợp đồng đến hạn 01–04/01/2027 đã tái tục hoặc tất toán xong, không xét" (SQL không đổi); C(2) tiêu đề "Tiền gửi đến hạn tháng 1/2027 có lãi suất cao nhất bao nhiêu?"; C(3) bỏ "lô" ở bối cảnh, nghiệp vụ, phương án; bối cảnh và nghiệp vụ chỉ còn mục tiêu chào lãi suất tái tục; C(4)(5) lời giải thích phương án | tĩnh |

Ngoài ra: mọi `\ghichuthietke` có câu "… ở hidden-1 giống public" đổi thành "Hidden-1 không đổi <bảng>; chờ hidden-2 (DA-SUA.md)".

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Biến thể hidden-2 đổi bảng danh mục, khách hàng, hồ sơ** (trước ở mục Chờ giảng viên): không cần `aivb_hidden_2`; `mysql/aivb/04_bo_sung_bien_the_aivb.sql` thêm vào `aivb_hidden_1` một cụm khách hàng giả đủ quan hệ (d)–(k) (xem `mysql/README-aivb.md`). Chạy solution trên `aivb` và `aivb_hidden_1` (user `sql_runner`): cả 17 câu trước đây trùng public nay khác, chép kết quả Chạy thử rớt ở hidden-1. R1 7/6 dòng (chi nhánh CN13); R2 6/5 (phiên bản `TD_IND_V2026H2`); R3 37/36, R7 573/572 (khách giả KYC không đạt ở CN01, khách ưu tiên); R4 hạng 5 đổi sang `SYN_LON_0000000` (ba khoản hoà dư nợ, bài sai khoá phụ giảm dần và chép ngưỡng rớt ở hidden-1); R6 6/5, C1.b1 18/17 (hồ sơ giả); R8 480/479, C2.b1 161/160 (tiền gửi giả); N1 75/74, N2 198/197, N8 465/464 (cá nhân giả); N3 376/374 (kỳ quá hạn đã trả một phần, bài quên trừ phần đã trả nay rớt); N4 716/714; N5 746/744; N7 29/28; N9 225/224. Ghi chú thiết kế các câu trên đã sửa theo.

## Chờ giảng viên

1. **N9, C2 · ca biên chưa có trong biến thể ẩn.** File 04 chưa thêm quan hệ đúng biên `valid_to = '2026-06-30'` / `valid_from = '2026-06-30'` (N9) và tiền gửi `ACTIVE` đến hạn đúng `'2027-02-01'` (C2); hai câu đã khác public nhưng bài sai đúng ở biên chưa bị bắt riêng.
2. **N4 · tên nhãn "Mới giải ngân / Giữa kỳ / Sắp tất toán".** Vay mua nhà giải ngân từ 2020 và `WC_LOAN` trả gốc cuối kỳ vẫn còn trên 80% dư nợ. Đề xuất của B là đổi thành "Còn từ 80% dư nợ / Còn 20–80% / Còn dưới 20%". Việc này đổi SQL nên chưa làm.
3. **N6 · cách gọi "kênh vật lý"**, hay "kênh truyền thống", "kênh tại điểm giao dịch".
4. **C1 · dùng DTI cho hồ sơ vay doanh nghiệp.** Thẩm định doanh nghiệp thường xem cơ cấu nợ và dòng tiền. Cột `dti` có cho mọi hồ sơ trong dữ liệu.
5. **C2 · mốc "hiện tại".** Câu đang theo mốc chốt dữ liệu tiền gửi 04/01/2027. Nếu theo ngày tham chiếu chung 31/12/2026 thì cần tính cả 19 hợp đồng đến hạn 01–04/01/2027 (đã `RENEWED`/`CLOSED`).
6. **ERD cấp Dễ có một bảng không dùng tới** để đủ "2 bảng" (R4, R5, R6, R9, N3, N4, N5, N6, N8, N9): cấp Dễ thực chất là Cơ bản cộng một bẫy. Cần người dựng bộ chốt có cho phép ở Module 1–2 không.
7. **STYLE A.4**: gói gọi `'ACTIVE'` là "đang trả nợ bình thường" (khớp khái niệm `trang-thai-khoan-vay`), STYLE ghi "đang còn dư nợ". Đề nghị sửa STYLE cho khớp.
8. **N1, N7**: đã đổi khung nghiệp vụ cho đúng dữ liệu (ô trống nghĩa là "không áp dụng"). Cần người nắm domain xác nhận khung mới.

## Quyết định v3 (10/11)

Thay cho mục "Chờ giảng viên" ở trên (giữ lại làm lịch sử). Nguồn domain ở `H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\Finance\`: `05_eDA_parameter_book_mini_core_banking_v5.1.5.xlsx` (gọi tắt PB), `Bang_phan_loai_datamart_va_data_dictionary_AIVBank_v5.1.6.3.xlsx` (gọi tắt DD); quy ước chung ở `QUYET-DINH-CHUNG.md`. Bảng tổng của bộ: `../QUYET-DINH-126.md`.

| mã | điểm | quyết định | căn cứ | đã sửa gì |
|---|---|---|---|---|
| aivb-n9 | ca biên chưa có trong biến thể ẩn | Thêm 2 quan hệ đúng biên vào hidden-1 | BAO-CAO 3.1; QUYET-DINH-CHUNG 1.10 (mốc thời gian) | File 04 mục (l): `SYN_APT_H000005` (`valid_to` = 2026-06-30), `SYN_APT_H000006` (`valid_from` = 2026-06-30); hidden-1 ra 226 dòng. Thêm 2 wrong `tinh_ca_ngay_ket_thuc`, `bo_ngay_bat_dau_dung_moc` (rớt hidden-1); thêm bẫy `bien-ngay-tham-chieu`; cập nhật `\ghichuthietke` |
| aivb-c2 | ca biên 01/02/2027 | Không thêm dòng: cả public và hidden-1 đã có 1 hợp đồng `'ACTIVE'` đến hạn đúng 2027-02-01 | Truy vấn đếm trên hai biến thể (10/11) | Thêm wrong b1 `tinh_ca_ngay_01_02` (`BETWEEN … '2027-02-01'`), rớt cả hai biến thể; ghi chú ở đầu file 04 |
| aivb-c2 | mốc "hiện tại" | Giữ mốc chốt dữ liệu tiền gửi 04/01/2027 | Dữ liệu: mọi hợp đồng `'ACTIVE'` đến hạn từ 05/01/2027; đề b1 đã ghi mốc | `\ghichuthietke` bỏ chữ "chờ" |
| aivb-c1 | DTI cho hồ sơ doanh nghiệp | Giữ SQL, thêm lưu ý | PB sheet 02.Model Contract, bảng `core_loan_application` có `dti` cho mọi hồ sơ; DD cột `dti` "Thuộc tính dti của hồ sơ đề nghị vay"; dữ liệu: 181 hồ sơ BUSINESS đều có DTI | `\luuy` thêm "Dữ liệu ghi DTI cho mọi hồ sơ, kể cả hồ sơ doanh nghiệp; thẩm định doanh nghiệp còn xem báo cáo tài chính và dòng tiền…"; `\ghichuthietke` |
| aivb-n4 | nhãn "Mới giải ngân / Giữa kỳ / Sắp tất toán" | Đổi nhãn theo phần dư nợ còn lại | PB sheet 08.Lending: MORT trả góp đều (annuity), WC_LOAN trả gốc cuối kỳ (bullet), nên tỷ lệ dư nợ không chỉ ra giai đoạn của khoản vay | SQL (solution, 2 wrong): nhãn `'Từ 80% trở lên'`, `'Từ 20% tới dưới 80%'`, `'Dưới 20%'`, cột `giai_doan` thành `nhom_con_lai`; tiêu đề "Khoản vay còn lại bao nhiêu phần dư nợ?"; `\luuy` thêm câu về trả gốc cuối kỳ |
| aivb-n6 | "kênh vật lý" | Giữ "kênh vật lý"; lời nhắn đã giải nghĩa (quầy, ATM, POS) | PB sheet 14.Analytical scenarios ("Digital migration & chi phí": kênh quầy đối lập kênh số) | `\ghichuthietke` bỏ chữ "chờ"; ghi STYLE-aivb mục H |
| aivb-n1, aivb-n7 | khung "ô trống = không áp dụng" | Xác nhận khung v2 | Dữ liệu: `occupation_code` trống ở đúng 1.583 người `RETIRED` và 640 người `STUDENT`; PB sheet 02: `approved_amount` chỉ có khi duyệt | Không sửa |
| STYLE A.4 | 'ACTIVE' của khoản vay | Chốt "đang trả nợ bình thường" | PB sheet 08.Lending (khoản vay chuyển DELINQUENT khi DPD > 0, trở lại khi DPD = 0) | Sửa STYLE-aivb A.4, thêm mục H |
| aivb-r7 (`'AFFLUENT'`) | "giàu có" hay "khá giả" | Giữ "giàu có" | DB `ref_segment.segment_name`: AFFLUENT = "Khách hàng giàu có", UPPER_MASS = "Khách hàng khá giả" | Gói không đổi; sửa STYLE A.1 và mục F.8 |
| R4, R5, R6, R9, N3–N6, N8, N9 | ERD cấp Dễ có 1 bảng nhiễu | Giữ | QUYET-DINH-CHUNG mục 1.3 (Dễ tối đa 1 bảng nhiễu) | `\ghichuthietke` R4 bỏ chữ "chờ" |
| khái niệm `chi-nhanh` | định nghĩa chưa đối chiếu luật | Viết lại theo văn bản NHNN, chép giống gói 2 | Thông tư 32/2024/TT-NHNN (mạng lưới hoạt động của NHTM) Điều 3: chi nhánh là đơn vị phụ thuộc, hạch toán phụ thuộc, có con dấu, thực hiện một phần nghiệp vụ theo uỷ quyền; Luật Các TCTD 2024 Điều 4 chỉ định nghĩa chi nhánh ngân hàng nước ngoài (https://hethongphapluat.com/luat-cac-to-chuc-tin-dung-2024/dieu-4) | Sửa `\khaibaokhainiem{chi-nhanh}` |
| tên nhân vật | một tên nhiều vai | Mỗi vai một tên, mỗi tên một vai, chung cả bộ (STYLE-aivb mục H, khớp `../QUYET-DINH-126-g45.md`) | BAO-CAO 3.8 | r1 Anh Phong → Anh Quang; r2 Chị Thu → Chị Hạnh; r4 Anh Tuấn → Chị Lan; r6 Anh Khánh → Anh Hải; r9 Chị Oanh → Anh Khánh; n2 Chị Trang → Chị Ngân; n3 Chị Dung → Anh Tâm; n4 Anh Hải → Anh Minh; n5 Chị Hoa → Anh Hưng; n6 Chị Yến → Chị Hạnh; n8 Anh Khoa → Anh Bảo; n9 Anh Sơn → Chị Mai; c1 Chị Ngọc → Anh Tuấn; r8, n7 thực tập sinh → Bạn Vy. Đổi giới thì đổi đại từ trong lời nhắn |
| c1, c2 | tiền tố lời giải thích bước kết luận | Theo quy chuẩn | QUYET-DINH-CHUNG 0.1 #1; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4 | Phương án đúng mở bằng "Đúng: ", phương án sai bỏ "Chưa đúng. " |

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 9 câu chia 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (lộ trình `quy_chuan/lo-trinh-sql/assets/js/data.js`: M1 Trung bình r5 `LIKE, IN, BETWEEN` một bảng, Khó r6 sửa lỗi `NOT IN`, thứ tự `AND/OR`; M2 Trung bình n5 `NULLIF, ROUND`, Khó n6 `COALESCE, CASE` lồng). Giữ 6 write + 3 debug mỗi module; hai case giữ Cơ bản.

Trước → sau: **M1** Cơ bản 5 · Dễ 4 → Cơ bản 2 · Dễ 3 · Trung bình 2 · Khó 2. **M2** Cơ bản 3 · Dễ 6 → Cơ bản 2 · Dễ 3 · Trung bình 2 · Khó 2. Viết lại 8 câu (số tối thiểu: M1 thừa 3 Cơ bản + 1 Dễ, M2 thừa 1 Cơ bản + 3 Dễ). Giữ nguyên R1, R4, R5, R7, R9, N1, N5, N6, N7, N8, C1, C2.

Năm trục (QUYET-DINH-CHUNG 2.2): B = số bảng lời giải cần, S = số bước, M = mức mơ hồ, T = số bẫy, D = độ sâu nghiệp vụ; ✓ là đạt cấp mới.

| mã cũ → mã mới | cấp cũ → mới | đổi gì | 5 trục (cấp mới) |
|---|---|---|---|
| aivb-r2-phien-ban-tien-gui-ca-nhan → aivb-r2-ho-so-vay-co-tai-san-bao-dam | Cơ bản → Trung bình | Viết lại: hồ sơ vay có tài sản bảo đảm (MORT, AUTO, PLEDGE, học viên tra mã ở `ref_product`) được duyệt, nộp năm 2025, từ 1 tỷ đồng; sắp ba tầng. ERD 3 bảng ký hiệu, 1 bảng nhiễu. 3 wrong (lấy cả vay vốn lưu động, thiếu cận trên, quên lọc duyệt) rớt public. Public 64, hidden-1 65 dòng | B ✓ (2, tra mã) · S – · M ✓ · T ✓ (3) · D – → 3/5 |
| aivb-r3-kyc-khong-dat-cn01 → aivb-r3-kyc-khong-dat-con-quan-he-ha-noi | Cơ bản → Trung bình | Viết lại: khách KYC không đạt mà còn quan hệ (chưa đóng, gồm cả không hoạt động) ở các chi nhánh tại Hà Nội (tra `ref_branch`). Dạng A1 → E1 để tránh trùng ô với aivb-q2. 3 wrong (lấy cả miền Bắc, chỉ `'ACTIVE'`, lẫn khách đã đóng) rớt public. Public 82, hidden-1 83 | B ✓ (2) · S – · M ✓ · T ✓ (3) · D ✓ → 4/5 |
| aivb-r6-ho-so-vay-nha-hang-a-2025 → aivb-r6-khoan-vay-xet-giam-lai-suat | Dễ → Khó | Viết lại (mảng sales → finance): khoản vay đủ điều kiện chương trình giảm lãi suất (còn dư nợ, trừ đang quá hạn, đã cơ cấu lại vẫn xét, lãi suất từ 9%/năm), đề nói bằng lời nghiệp vụ. ERD 5 bảng chỉ khoá, `\erdkhoa`. 5 wrong; `> 0.09` chỉ rớt hidden-1 (`SYN_LON_H000004` đúng 9%/năm). Public 18, hidden-1 20 | B – (1, cho phép theo mẫu o4) · S – · M ✓ · T ✓ (4, một chỉ ở hidden-1) · D ✓ → 3/5 |
| aivb-r8-tien-gui-lai-suat-tren-6 → aivb-r8-tien-gui-lon-ky-han-6-12-thang | Cơ bản → Khó | Viết lại: tiền gửi còn hiệu lực, kỳ hạn 6–12 tháng, từ 500 triệu đồng, lãi suất từ 4,5%/năm; starter 3 lỗi chồng nhau (`<> 'CLOSED'` lẫn hợp đồng đã tái tục; mất hai biên kỳ hạn; `> 500000000`). Người hỏi đổi Bạn Vy → Anh Minh (Sửa lỗi cấp cao). ERD 5 bảng chỉ khoá, trung tính. 3 wrong, `> 500000000` chỉ rớt hidden-1. Public 59, hidden-1 61 | B – · S – · M ✓ · T ✓ (3, một chỉ ở hidden-1) · D ✓ → 3/5; Sửa lỗi Khó = 2–3 lỗi chồng nhau |
| aivb-n2-nhom-thu-nhap → aivb-n2-kha-nang-tich-luy-khach-1990 | Cơ bản → Trung bình | Viết lại (mảng customer → marketing, tránh trùng ô C4 · customer · Trung bình với j4, t3): khả năng tích luỹ theo hai thành phần (khoảng thu nhập, số người phụ thuộc), quy tắc ở tab Nghiệp vụ. ERD 3 bảng ký hiệu, 2 bảng nhiễu (xem ghi chú dưới). 3 wrong (so chuỗi mã thu nhập, biên 1 người phụ thuộc, thiếu ELSE) rớt public. Public 197, hidden-1 198 | B – · S – · M ✓ · T ✓ (3) · D ✓ → 3/5 |
| aivb-n3-so-tien-con-thieu-ky-qua-han → aivb-n3-ky-qua-han-can-goi-nhac-truoc | Dễ → Khó | Viết lại: số tiền còn phải trả (học viên tự dựng từ 4 cột), số ngày quá hạn tại 31/12/2026, bốn mức quá hạn theo ngưỡng 10, 90, 180 ngày; bỏ công thức khỏi yêu cầu. ERD 5 bảng chỉ khoá. 5 wrong; quên trừ phần đã trả chỉ rớt hidden-1. Public 374, hidden-1 376 | B – · S ✓ (gần, hai biểu thức + CASE trên biểu thức) · M ✓ · T ✓ (5, một chỉ ở hidden-1) · D ✓ → 3–4/5 |
| aivb-n4-ty-le-du-no-con-lai → aivb-n4-ty-le-thu-hoi-goc | Dễ → Trung bình | Viết lại: tỷ lệ thu hồi gốc (phần trăm, 2 chữ số) của khoản vay còn dư nợ (học viên tự suy ra 3 trạng thái), nhóm "Chưa thu hồi / Dưới 50% / Từ 50% trở lên" trên tỷ lệ chưa làm tròn. `saiso` về mặc định 0,01. 4 wrong (chỉ `'ACTIVE'`, nhánh dưới 50% đặt trước nhánh bằng 0, tính phần dư nợ còn lại, xếp nhóm trên số đã làm tròn) rớt public. Public 801, hidden-1 804 | B – · S – · M ✓ · T ✓ (4) · D ✓ → 3/5 |
| aivb-n9-dong-so-huu-con-hieu-luc (giữ mã) | Dễ → Khó | Lời giải giữ nguyên; starter đổi thành 3 lỗi chồng nhau (`valid_to >= …` loại dòng trống và tính cả ngày kết thúc; `valid_from < …`). Định nghĩa khoảng hiệu lực chuyển sang tab Nghiệp vụ; ERD 5 bảng chỉ khoá, trung tính. Thêm 2 wrong (`chi_them_valid_to_trong` chỉ rớt hidden-1; `thieu_ngoac_quanh_or` rớt public). Public 224, hidden-1 226 | B – · S – · M ✓ · T ✓ (4, hai chỉ ở hidden-1) · D ✓ → 3/5; Sửa lỗi Khó = 2–3 lỗi chồng nhau |

Ghi chú:
- **ERD Trung bình M2 có 2 bảng nhiễu** (N2, N4): CHOT mục 3 bắt buộc 3–4 bảng; M2 chưa học nối bảng nên lời giải chỉ 1 bảng (như bài Trung bình n5 của `data.js`, chỉ dùng `order_items`). Quy chuẩn đứng trên quy ước bổ sung "Trung bình tối đa 1 bảng nhiễu" của QUYET-DINH-CHUNG 1.3 (chính mục đó ghi "quy chuẩn không nói rõ"). R2, R3 (M1) tránh được nhờ bảng tra mã. Cần giảng viên xác nhận.
- **Câu Khó dùng 1 bảng** (R6, R8, N3, N9): theo QUYET-DINH-CHUNG 0.1 #6 (mẫu o4 Khó 1 bảng), ERD thêm 4 bảng nhiễu cho đủ 5 bảng (QUYET-DINH-CHUNG 1.3, mẫu d4, o4).
- Khái niệm `phien-ban-san-pham` bỏ khỏi khai báo vì không còn câu nào dùng.
- Tên nhân vật theo bảng vai – tên của `../../QUYET-DINH-126-g45.md`: Anh Hải (thẩm định), Chị Mai (KYC), Chị Hạnh (phát triển sản phẩm), Anh Minh (nguồn vốn), Chị Ngân (KH cá nhân), Anh Tâm (xử lý nợ). Thực tập sinh chỉ còn ở câu Sửa lỗi Cơ bản (R7, N7).
- Ô trùng: trong gói không có. Giữa các gói đã tránh (R3 đổi dạng E1, N2 đổi mảng marketing). N4 (C4 · finance · Trung bình · write) và R2 (A1 · sales · Trung bình · write) chưa có câu nào ở gói khác trong bản đồ lúc 11/11 01:30; agent gói 2–4 sửa song song, cần soát lại khi gộp.
- Đã kiểm thêm trên MySQL: N4 so nhóm theo phần trăm, theo tỷ lệ 0–1, theo 1 − outstanding/principal đều trùng phép so chính xác bằng số nguyên (chỉ cách so trên số đã làm tròn lệch, đã dùng làm wrong).

Kiểm:
- Bộ kiểm đầy đủ cả gói (`--ra cong-cu/ket-qua/cap-do/aivb-goi-1`): **KIEM TRA: 0 loi**, 0 cảnh báo; 20 câu; mọi wrong rớt ≥ 1 biến thể; mọi câu kết quả public ≠ hidden-1; solution chậm nhất 5,2 giây (R5, không đổi).
- Biên dịch `bash cong-cu/bien_dich.sh goi-cau-hoi/aivb/goi-1 <…>/cong-cu/ket-qua/cap-do/aivb-goi-1-bien-dich`: 50 trang, 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo gói lệnh (28 overfull hbox, chỉ trình bày).
- Thư mục gói vẫn đúng 4 file.
