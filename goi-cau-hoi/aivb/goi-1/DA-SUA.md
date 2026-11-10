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
