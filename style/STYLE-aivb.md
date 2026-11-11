# Bộ chuẩn giọng văn và thuật ngữ · câu hỏi SQL Leaderboard trên bộ dữ liệu AIV Bank

Bản nháp 1 · 10/11/2026 · chờ giảng viên duyệt.

Áp dụng cho mọi phần chữ của một câu trong `cau-hoi.tex` thuộc bộ AIV Bank (ngân hàng thương mại Việt Nam giả lập, MySQL database `aivb`, `dulieu=aivb`): `\tieude`, `\boicanh`, `yeucau`, `rangbuoc`, `nghiepvu` (câu "giúp quyết định gì", `\quytrinh`, `\luuy`), `\goiy`, `\phuongan`, `\khaibaokhainiem`, `\ghichuthietke`. Cú pháp LaTeX và cách chấm theo `quy_chuan/goi-cau-hoi-mau/HUONG_DAN.md` và `quy_chuan/CHOT-FORMAT-CAU-HOI.md`; tài liệu này chỉ quy định chữ.

Cấu trúc giữ đúng `STYLE-scm.md`: 0 (nguồn), A (thuật ngữ), B (giọng văn), C (khuôn cấm), D (câu mẫu trước/sau), E (khái niệm), F (điểm cần chốt), G (quyết định tạm, ánh xạ mảng nghiệp vụ).

Thứ tự ưu tiên khi các nguồn mâu thuẫn:
1. Quyết định của giảng viên ở `STYLE-GUIDE-luyen-sql.md` mục H và các quyết định tạm ở `STYLE-scm.md` mục G. Toàn bộ mục B, C của `STYLE-scm.md` được kế thừa (mục B, C dưới đây chỉ đổi ví dụ sang ngân hàng).
2. Văn bản pháp quy của Quốc hội và Ngân hàng Nhà nước (NHNN) đã đọc được nguyên văn (mã TT31, TT48, TT49 ở mục 0). Chỗ nào văn bản pháp quy có từ thì **giữ từ của văn bản**; từ quen dùng ở ngân hàng ghi ở cột "Ghi chú".
3. Dữ liệu dự án: tên bảng, tên cột, giá trị cột của database `aivb` (mã DA). Tên cột giữ nguyên từ hệ thống nguồn.
4. Giáo trình đại học ngành Tài chính – Ngân hàng (có URL). Đợt này **không mở được toàn văn giáo trình nào** (xem danh sách cuối mục 0), nên chưa có dòng nào lấy giáo trình làm căn cứ.
5. Nguồn báo chí chuyên ngành của ngành ngân hàng (mã TTTC): chỉ khi bốn nguồn trên không có.

---

## 0. Nguồn và mã viết tắt

| Mã | Tài liệu | Trạng thái |
|---|---|---|
| DA | Dữ liệu dự án: database MySQL `aivb`, 26 bảng, mô tả cột và giá trị do người giao việc cung cấp ngày 10/11/2026 | dùng theo mô tả; người soạn kiểm lại bằng truy vấn trước khi ra đề |
| SCM | `style/STYLE-scm.md` (mục B, C, G kế thừa) | đọc trực tiếp |
| TT31 | Thông tư 31/2024/TT-NHNN quy định về phân loại tài sản có trong hoạt động của ngân hàng thương mại, tổ chức tín dụng phi ngân hàng, chi nhánh ngân hàng nước ngoài; ban hành 30/06/2024, hiệu lực 01/07/2024; đã được sửa đổi bởi Thông tư 37/2025/TT-NHNN. https://luatvietnam.vn/tai-chinh/thong-tu-31-2024-tt-nhnn-phan-loai-tai-san-trong-hoat-dong-ngan-hang-thuong-mai-359315-d1.html | mở được; đã đọc Điều 3 (khoản nợ, nợ quá hạn, nợ xấu, nợ cơ cấu lại) và khoản 1 Điều 10 (năm nhóm nợ) |
| TT37 | Thông tư 37/2025/TT-NHNN sửa đổi TT31. https://sbv.gov.vn/en/w/thong-tu-so-37/2025/tt-nhnn | chỉ thấy qua kết quả tìm kiếm; chưa đọc nội dung sửa đổi |
| TT49 | Thông tư 49/2018/TT-NHNN quy định về tiền gửi có kỳ hạn; ngày 31/12/2018, hiệu lực 05/07/2019. https://caselaw.vn/van-ban-phap-luat/340658-thong-tu-so-49-2018-tt-nhnn-ngay-31-12-2018-cua-thong-doc-ngan-hang-nha-nuoc-viet-nam-quy-dinh-ve-tien-gui-co-ky-han | mở được; đọc Điều 4, 5, 6, 9, 10, 11 |
| TT48 | Thông tư 48/2018/TT-NHNN quy định về tiền gửi tiết kiệm; ngày 31/12/2018, hiệu lực 05/07/2019. https://caselaw.vn/van-ban-phap-luat/340668-thong-tu-so-48-2018-tt-nhnn-ngay-31-12-2018-cua-thong-doc-ngan-hang-nha-nuoc-viet-nam-quy-dinh-ve-tien-gui-tiet-kiem | mở được; đọc Điều 5, 6, 7, 15, 17 |
| TT39* | Thông tư 39/2016/TT-NHNN quy định về hoạt động cho vay của tổ chức tín dụng, chi nhánh ngân hàng nước ngoài đối với khách hàng; hiệu lực 15/03/2017; sửa đổi bởi 06/2023/TT-NHNN, 12/2024/TT-NHNN, 29/2026/TT-NHNN (30/06/2026). https://thuvienphapluat.vn/van-ban/Tien-te-Ngan-hang/Thong-tu-39-2016-TT-NHNN-hoat-dong-cho-vay-cua-to-chuc-tin-dung-chi-nhanh-ngan-hang-nuoc-ngoai-338877.aspx ; Thông tư 29/2026 (bản tiếng Anh): https://thuvienphapluat.vn/van-ban/EN/Tien-te-Ngan-hang/Circular-29-2026-TT-NHNN-amendments-Circular-39-2016-TT-NHNN/718494/tieng-anh.aspx | URL xác nhận qua tìm kiếm; **chưa đọc nguyên văn**. Không tìm thấy văn bản thay thế hoàn toàn TT39, chỉ có các thông tư sửa đổi |
| TT17* | Thông tư 17/2024/TT-NHNN quy định việc mở và sử dụng tài khoản thanh toán tại tổ chức cung ứng dịch vụ thanh toán; hiệu lực 01/07/2024; sửa đổi bởi Thông tư 25/2025/TT-NHNN (hiệu lực 31/08/2025). https://thuvienphapluat.vn/van-ban/Tien-te-Ngan-hang/Circular-17-2024-TT-NHNN-on-opening-checking-accounts-at-payment-service-providers-616720.aspx | URL xác nhận qua tìm kiếm; trang trả lỗi 403; **chưa đọc nguyên văn** |
| LTCTD* | Luật Các tổ chức tín dụng số 32/2024/QH15, thông qua 18/01/2024, hiệu lực 01/07/2024. https://thuvienphapluat.vn/van-ban/Tien-te-Ngan-hang/Luat-Cac-to-chuc-tin-dung-32-2024-QH15-577203.aspx ; bản PDF https://www.div.gov.vn/uploads//files/2024/2/luat-cac-to-chuc-tin-dung-32-2024-qh15.pdf | URL xác nhận; trang thuvienphapluat trả 403, PDF tải được nhưng không trích được chữ; **chưa đối chiếu nguyên văn Điều 4** |
| TTTC | Trần Thúy, "Tỷ lệ CASA càng cao có càng tốt?", Tạp chí Thị trường Tài chính Tiền tệ, 24/04/2024. https://thitruongtaichinhtiente.vn/ty-le-casa-cang-cao-co-cang-tot-58571.html | mở được |

Mã có dấu `*` là văn bản đã xác nhận tồn tại và đúng số hiệu nhưng chưa đọc nguyên văn: chỉ dùng để chỉ "từ này là từ của văn bản pháp quy", không trích định nghĩa.

Không mở được hoặc không tìm thấy bản trực tuyến (không dùng làm căn cứ):
- Giáo trình Ngân hàng thương mại, Tô Ngọc Hưng (chủ biên), Học viện Ngân hàng, NXB Dân trí 2014: chỉ thấy bản ghi thư mục https://searchlib.phenikaa-uni.edu.vn/Record/3239 qua kết quả tìm kiếm; máy chủ **từ chối kết nối**.
- Giáo trình Tín dụng ngân hàng (Học viện Ngân hàng, hai phần): chỉ thấy tên trên thư viện số thuvienso.dhv.edu.vn; trang **lỗi chứng chỉ**, không mở được.
- Giáo trình Ngân hàng thương mại, Phan Thị Thu Hà, NXB ĐH Kinh tế Quốc dân: chỉ thấy tên trong danh mục tài liệu của đề cương học phần; **không tìm được bản trực tuyến**.
- Đề cương Tín dụng ngân hàng, ĐH Ngân hàng TP.HCM (clc.hub.edu.vn) và bài giảng Ngân hàng thương mại, ĐH Nha Trang (khoakttc.ntu.edu.vn): PDF không trích được chữ hoặc **lỗi tên miền**.
- ĐH Kinh tế TP.HCM, Học viện Tài chính (Tín dụng ngân hàng, Tài chính doanh nghiệp): **không tìm được bản trực tuyến** trong thời gian dựng bộ.

---

## A. Bảng thuật ngữ

Quy ước:
- Cột "Dùng trong đề" là đúng chữ cần viết, viết thường (trừ đầu câu). Thuật ngữ giữ tiếng Anh hoặc viết tắt thì giải nghĩa ở lần đầu trong mỗi câu hỏi, ví dụ "tỷ lệ nợ trên thu nhập (DTI)".
- Tên bảng, cột viết đúng như DB, trong LaTeX đặt trong `\code{}`; giá trị chuỗi trong nháy đơn: `\code{'OVERDUE'}`, `\code{'CN01'}`. Giá trị trong DB là mã tiếng Anh in hoa; trong văn dùng chữ ở cột "Dùng", trong `yeucau` ghi kèm mã khi cần lọc: "khoản vay đã cơ cấu lại (\code{loan_status = 'RESTRUCTURED'})".
- Tên cột kết quả (alias) viết tiếng Việt không dấu theo cột "Dùng": `du_no`, `ty_le_no_xau_pct`, `so_ngay_qua_han`, `lai_suat_bq_pct`, `so_du`, `ty_le_casa_pct`, `so_hd_tai_tuc`.
- Tiền: mọi cột tiền là số nguyên đồng (VND, BIGINT). Lãi suất, DTI và tỷ lệ chính sách lưu dạng tỷ lệ (0,0723 nghĩa là 7,23%/năm).

### A.1 Khách hàng, chủ thể và KYC

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| party (`core_party`, `party_id`; `party_status`, `valid_from`, `valid_to`, `created_at`) | chủ thể; lần đầu "chủ thể (cá nhân hoặc tổ chức có quan hệ với ngân hàng)"; trạng thái chủ thể; thời gian hiệu lực; ngày tạo | thực thể, đối tác, bên | Chủ thể chưa chắc là khách hàng: người được uỷ quyền ký, người đề nghị vay bị từ chối có thể không có dòng ở `core_customer` | DA |
| `party_type` = 'PERSON' / 'ORGANIZATION' | cá nhân / tổ chức; khách hàng cá nhân / khách hàng tổ chức | thể nhân, pháp nhân (trừ khi trích luật) | Khác `core_loan_application.customer_type` (PERSONAL / BUSINESS) | DA |
| `legal_name` | tên khách hàng (tên pháp lý) | họ tên làm khoá | 2.512 tên bị trùng giữa các chủ thể khác nhau; đếm và gom nhóm theo `party_id`, không theo tên | DA |
| customer (`core_customer`, `customer_id`) | khách hàng | chủ thể (khi đã là khách hàng); user | Nối với chủ thể qua `party_id` | DA |
| `customer_since` | ngày trở thành khách hàng; thâm niên quan hệ (năm) | tuổi khách hàng | | DA |
| `customer_status` = 'ACTIVE' / 'DORMANT' / 'CLOSED' | đang hoạt động / không hoạt động / đã đóng | ngủ đông, khách chết, khách "ngủ" | | DA |
| segment (`segment_code`, `ref_segment`) | phân khúc khách hàng; tên phân khúc lấy đúng `segment_name` | phân đoạn, tệp khách, nhóm khách | | DA |
| 'MASS' / 'UPPER_MASS' / 'AFFLUENT' / 'PRIORITY'; 'MICRO' / 'SME' / 'CORP' / 'INST' | khách hàng đại chúng / khá giả / giàu có / ưu tiên (đúng `segment_name`; v3 10/11: 'AFFLUENT' là "giàu có", 'UPPER_MASS' là "khá giả"); hộ kinh doanh và doanh nghiệp siêu nhỏ / doanh nghiệp nhỏ và vừa (SME) / doanh nghiệp lớn / định chế tài chính | VIP, khách sang, khách xịn, tiểu thương | Chỉ dùng khi `segment_name` không có tên tiếng Việt; có thì theo `segment_name`. `ref_segment.party_type` cho biết phân khúc của cá nhân hay tổ chức | DA |
| `hist_customer_segment` (`valid_from`, `valid_to`) | lịch sử phân khúc; phân khúc tại thời điểm giao dịch | phân khúc hiện tại (khi đề hỏi theo thời điểm) | Đề phải nói rõ lấy phân khúc hiện tại (`core_customer`) hay phân khúc tại ngày giao dịch (bảng lịch sử) | DA |
| KYC (`kyc_status`, `core_customer_kyc_event`) | nhận biết khách hàng (KYC) ở lần đầu, sau đó KYC | xác thực danh tính, eKYC (trừ khi nói kênh điện tử) | | DA |
| `kyc_status` = 'PASS' / 'FAIL' | KYC đạt / KYC không đạt | KYC trượt, rớt KYC | | DA |
| `event_type` = 'KYC_SUBMITTED' / 'APPROVED' / 'REJECTED' | nộp hồ sơ KYC / duyệt / từ chối | | | DA |
| `kyc_cycle_no`, `event_sequence`, `from_status`, `to_status`, `event_at`, `business_date`, `decision_reason`, `rule_version` | vòng KYC; thứ tự sự kiện; trạng thái trước / trạng thái sau; thời điểm sự kiện; ngày làm việc ghi nhận; lý do quyết định; phiên bản quy tắc | | Kết quả của một vòng là sự kiện có `event_sequence` lớn nhất trong vòng đó | DA |
| `core_person`: `income_band`, `employment_status`, `occupation_code`, `marital_status`, `education_level`, `dependents_count`, `residence_province`, `date_of_birth`, `gender` | khoảng thu nhập; tình trạng việc làm; mã nghề nghiệp; tình trạng hôn nhân; trình độ học vấn; số người phụ thuộc; tỉnh cư trú; ngày sinh; giới tính | mức lương (`income_band` là khoảng, không phải số tiền) | Tuổi tính tới ngày tham chiếu ghi trong đề | DA |
| `core_organization`: `organization_type`, `registration_number`, `organization_status`, `employee_size_band`, `employee_count`, `revenue_band` | loại hình tổ chức; mã số đăng ký; trạng thái tổ chức; nhóm quy mô lao động; số lao động; khoảng doanh thu | | | DA |
| `industry_code` (`ref_industry`) | ngành kinh tế (`industry_name`) | ngành hàng (từ của bán lẻ) | | DA |

### A.2 Chi nhánh, sản phẩm, hợp đồng và tài khoản thanh toán

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| branch (`ref_branch`, `ref_branch_id` 'CN01'…'CN12') | chi nhánh; "chi nhánh CN05" hoặc tên ở `branch_name` | phòng giao dịch, điểm giao dịch (khác cấp) | | DA; LTCTD* |
| `home_branch_id` | chi nhánh quản lý (của khách hàng, của hợp đồng) | chi nhánh mẹ, chi nhánh nhà | Khách hàng và hợp đồng đều có `home_branch_id`; đề phải nói lấy cái nào | DA |
| `region` = 'MIEN_BAC' / 'MIEN_TRUNG' / 'MIEN_NAM'; `city`; `opened_date`, `status` (chi nhánh) | miền Bắc / miền Trung / miền Nam; thành phố; ngày khai trương chi nhánh; trạng thái chi nhánh | vùng | | DA |
| product (`ref_product`, `product_family`) | sản phẩm; họ sản phẩm; tên lấy đúng `product_name` | gói, dòng sản phẩm | | DA |
| product version (`ref_product_version`; `product_status`, `eligible_party_type`) | phiên bản sản phẩm; thời gian hiệu lực (`effective_from`, `effective_to`); trạng thái phiên bản; đối tượng khách hàng được áp dụng | | Hợp đồng gắn với phiên bản, không gắn thẳng sản phẩm: muốn ra sản phẩm phải nối qua `ref_product_version` | DA |
| `interest_rule_id`, `fee_rule_set_id`, `accounting_rule_set_id` | mã quy tắc lãi suất; mã bộ quy tắc phí; mã bộ quy tắc hạch toán | | Không có bảng chi tiết; chỉ dùng như mã để gom nhóm | DA |
| contract (`core_contract`, `contract_status`) | hợp đồng; trạng thái hợp đồng | khế ước | | DA |
| `booking_date` / `effective_date` / `maturity_date` | ngày ghi nhận hợp đồng / ngày hiệu lực / ngày đáo hạn | ngày book | Với tiền gửi có kỳ hạn dùng "ngày đến hạn" như TT49 | DA; TT49 |
| `currency` | loại tiền | tiền tệ (khi nói cột) | Người soạn kiểm có giá trị khác 'VND' không trước khi cộng tiền | DA |
| CASA (`product_family` = 'CASA') | tiền gửi không kỳ hạn (CASA) | tài khoản vãng lai, tiền gửi "không thời hạn" | TTTC: "CASA (Current Account Savings Account) là loại tiền gửi không kỳ hạn" | TTTC; DA |
| payment account (`core_account`, `account_id`) | tài khoản thanh toán | tài khoản CASA (trong văn), tài khoản tiền gửi (mơ hồ) | `core_account` chỉ chứa tài khoản thanh toán (CASA); tiền gửi có kỳ hạn nằm ở `core_deposit_contract` | TT17*; DA |
| `account_status` = 'ACTIVE' / 'DORMANT' / 'CLOSED'; `open_date`, `close_date` | đang hoạt động / không hoạt động / đã đóng; ngày mở tài khoản; ngày đóng tài khoản | bị khoá, phong toả (là nghiệp vụ khác) | `close_date` trống là tài khoản chưa đóng | DA |
| `core_account_party`, `role_code` = 'PRIMARY_OWNER' | chủ tài khoản | chủ sở hữu tài khoản | | TT17*; DA |
| 'JOINT_OWNER' | đồng chủ tài khoản (tài khoản thanh toán chung) | | Một tài khoản có thể có nhiều chủ thể: nối `core_account_party` dễ nhân dòng | TT17*; DA |
| 'AUTHORIZED_SIGNER' / 'VIEW_ONLY'; `signing_authority_level`, `transaction_limit` | người được uỷ quyền ký / người chỉ được xem; cấp thẩm quyền ký; hạn mức giao dịch | | | DA |
| 'PAYROLL_SVC'; 'INVEST' | dịch vụ chi lương; sản phẩm đầu tư | | Không có bảng chi tiết riêng cho hai sản phẩm này | DA |

### A.3 Huy động vốn và tiền gửi có kỳ hạn

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| deposit mobilization | huy động vốn; tiền gửi của khách hàng | hút tiền, gom tiền | | TTTC; DA |
| CASA ratio | tỷ lệ CASA | | TTTC: "Tỷ lệ tiền gửi không kỳ hạn/tổng tiền gửi khách hàng (CASA)". Trong bộ dữ liệu: số dư tài khoản thanh toán / (số dư tài khoản thanh toán + số tiền gửi có kỳ hạn còn hiệu lực) | TTTC; DA |
| term deposit ('TD_IND', 'TD_BIZ', 'TD_LEG'; `core_deposit_contract`) | tiền gửi có kỳ hạn | sổ, tiền gửi tiết kiệm (khi gồm cả tổ chức) | TT49 Điều 4: "khoản tiền của khách hàng gửi tại tổ chức tín dụng trong một thời hạn nhất định". "Tiền gửi tiết kiệm" (TT48) chỉ của cá nhân | TT49; TT48 |
| `principal` (tiền gửi) | số tiền gửi (gốc) | vốn gửi | | TT49; DA |
| `term_months` | kỳ hạn gửi (tháng) | thời hạn cho vay (của khoản vay) | TT49 Điều 5 gọi "thời hạn gửi tiền"; ngân hàng quen gọi "kỳ hạn 6 tháng" | TT49; DA |
| `interest_rate` (tiền gửi) | lãi suất tiền gửi (%/năm) | "lãi" đứng một mình chỉ lãi suất | Lưu dạng tỷ lệ | DA |
| `maturity_date` (tiền gửi) | ngày đến hạn | ngày đáo hạn (chấp nhận khi nói hợp đồng chung) | TT49 Điều 6 dùng "ngày đến hạn" | TT49 |
| `deposit_status` = 'ACTIVE' | đang còn hiệu lực | | | DA |
| 'RENEWED' | tái tục; lần đầu "tái tục (kéo dài thời hạn gửi tiền khi đến hạn)" | gia hạn (từ của tín dụng), quay vòng, lăn sổ; "còn hiệu lực" cho 'RENEWED' | Trong bộ dữ liệu, 'RENEWED' là hợp đồng cũ đã tái tục sang hợp đồng mới ('ACTIVE'), không còn hiệu lực; cộng cả hai là tính trùng (quyết 11/11/2026). TT49 Điều 9: "kéo dài thời hạn gửi tiền vào ngày đến hạn"; TT48 Điều 15: "kéo dài thêm một thời hạn mới" | TT49; TT48 |
| 'CLOSED' (tiền gửi) | đã tất toán | đóng sổ, chốt sổ | | DA |
| 'EARLY_TERMINATED' | rút trước hạn | phá sổ, bẻ sổ, tất toán sớm | TT48 Điều 17: "rút trước hạn"; TT49 Điều 10: "chi trả trước hạn" | TT48; TT49 |
| `settlement_account_id` | tài khoản nhận gốc và lãi | tài khoản liên kết | TT49 Điều 9: không kéo dài thì chuyển gốc, lãi vào tài khoản thanh toán của khách hàng | TT49; DA |
| `pledged_flag` | tiền gửi đang làm tài sản bảo đảm (cầm cố) | bị thế chấp, bị giữ | TT49 Điều 11: "Tiền gửi có kỳ hạn được sử dụng để làm tài sản bảo đảm" | TT49 |
| 'TD_PLACEMENT' / 'TD_MATURITY' (`transaction_type`) | lệnh gửi tiền có kỳ hạn / lệnh chi trả tiền gửi đến hạn | | | DA |

### A.4 Tín dụng: hồ sơ vay, khoản vay, lịch trả nợ và phân loại nợ

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| loan application (`core_loan_application`; `application_date`, `requested_amount`) | hồ sơ vay; đề nghị vay; ngày nộp hồ sơ; số tiền đề nghị vay | đơn vay, lead | | DA; TT39* |
| `application_status` = 'APPROVED' / 'REJECTED' | được duyệt / bị từ chối | đậu, rớt, pass hồ sơ | | DA |
| approval rate | tỷ lệ duyệt | tỷ lệ đậu | Tỷ lệ duyệt thực tế tính từ hồ sơ; `ref_policy_version.approval_rate` là mức của chính sách, hai số khác nhau | DA |
| `customer_type` = 'PERSONAL' / 'BUSINESS' | vay cá nhân / vay doanh nghiệp | | | DA |
| `score_band` 'A'–'D'; `score_cutoff` | hạng điểm tín dụng; ngưỡng điểm duyệt | điểm tín dụng (khi chỉ có hạng), xếp hạng tín nhiệm, điểm sàn | Chiều tốt – xấu của hạng phải nêu trong đề sau khi người soạn kiểm tỷ lệ duyệt theo hạng | DA |
| DTI (`dti`); `ref_policy_version` (`policy_version_id`, `dti_cap`) | tỷ lệ nợ trên thu nhập (DTI); phiên bản chính sách tín dụng; trần DTI | DTI trơ trong văn | Lưu dạng tỷ lệ; người soạn kiểm thang (0–1 hay phần trăm) | DA |
| credit decision (`core_credit_decision`; `decision_status`, `approved_amount`; `limit_decision_id`) | quyết định cấp tín dụng; trạng thái quyết định; số tiền được duyệt; quyết định hạn mức | phê duyệt (danh từ); hạn mức (khi nói số tiền của một khoản cụ thể) | | DA; LTCTD* |
| loan (`core_loan_contract`, `loan_id`) | khoản vay; hợp đồng vay | món vay, khoản nợ (khi chưa nói tới phân loại nợ) | "Khoản nợ" dùng khi nói phân loại nợ theo TT31 | DA; TT31 |
| disbursement (`core_loan_disbursement`, `disbursement_date`) | giải ngân; ngày giải ngân; lần giải ngân | rót vốn, bơm vốn | TT31 Điều 3: "giải ngân từng lần theo thỏa thuận" | TT31; DA |
| `principal` (khoản vay) | số tiền vay ban đầu (gốc) | | | DA |
| `outstanding` | dư nợ (dư nợ gốc còn lại) | số dư nợ, nợ còn, dư nợ "chưa trả" | TT31 Điều 3: khoản nợ tính trên phần chưa hoàn trả | TT31; DA |
| `tenor_months` | thời hạn cho vay (tháng) | kỳ hạn vay | TT39 dùng "thời hạn cho vay"; "kỳ hạn" để dành cho tiền gửi và kỳ trả nợ | TT39*; DA |
| `interest_rate` (khoản vay) | lãi suất cho vay (%/năm) | | | DA |
| 'CONS' / 'MORT' / 'AUTO' / 'PLEDGE' | cho vay tiêu dùng / cho vay mua nhà / cho vay mua ô tô / cho vay cầm cố | | Tên chính thức theo `product_name` | DA |
| 'OD_IND' / 'OD_BIZ' | thấu chi cá nhân / thấu chi doanh nghiệp | thấu chi "tín dụng" | TT39 có "cho vay theo hạn mức thấu chi" | TT39*; DA |
| 'WC_LOAN' | cho vay bổ sung vốn lưu động | vay vốn kinh doanh | | DA |
| `loan_status` = 'ACTIVE' / 'SETTLED' | đang trả nợ bình thường / đã tất toán | đã đóng; "đang còn dư nợ" cho riêng 'ACTIVE' (khoản quá hạn, cơ cấu lại cũng còn dư nợ) | v3 (10/11): chốt "đang trả nợ bình thường", khớp khái niệm `trang-thai-khoan-vay`. Parameter Book sheet 08.Lending: khoản vay chuyển DELINQUENT khi DPD > 0, trở lại khi DPD = 0 | DA |
| 'DELINQUENT' | khoản vay đang quá hạn | nợ xấu (quá hạn chưa chắc thuộc nhóm 3–5) | | DA; TT31 |
| 'RESTRUCTURED' | khoản vay đã cơ cấu lại thời hạn trả nợ | tái cấu trúc, giãn nợ | TT31 Điều 3: "nợ cơ cấu lại thời hạn trả nợ" | TT31 |
| 'WRITTEN_OFF' | khoản vay đã xử lý rủi ro | bị xoá sổ, mất trắng | Cách gọi của ngành; chưa đối chiếu nguyên văn văn bản | DA |
| `opening_book_flag` | khoản vay đầu kỳ (đã có khi dữ liệu bắt đầu) | | Có thể không có dòng giải ngân trong dữ liệu; người soạn kiểm trước khi đếm giải ngân | DA |
| repayment schedule (`core_loan_schedule`), `installment_no` | lịch trả nợ; kỳ trả nợ thứ n | | TT39 dùng "kỳ hạn trả nợ" | DA; TT39* |
| `due_date` | ngày đến hạn trả nợ | | | DA |
| `principal_due` / `interest_due`; `principal_paid` / `interest_paid` | gốc đến hạn / lãi đến hạn; gốc đã trả / lãi đã trả | lãi phải trả (dễ lẫn với lãi tiền gửi) | | DA |
| `schedule_status` = 'PAID' / 'DUE' / 'OVERDUE' / 'CANCELLED' | đã trả đủ / đến hạn, chưa trả / quá hạn / đã huỷ | | Kỳ 'DUE' có thể có `due_date` sau ngày tham chiếu | DA |
| overdue debt | nợ quá hạn; khoản nợ quá hạn | nợ trễ, nợ trễ hạn | TT31 Điều 3: "khoản nợ mà khách hàng không trả được đúng hạn một phần hoặc toàn bộ nợ gốc và/hoặc lãi" | TT31 |
| days past due (DPD) | số ngày quá hạn | DPD trong văn | Không có cột; tính bằng ngày tham chiếu trừ `due_date` của kỳ quá hạn sớm nhất | TT31; DA |
| loan classification; nhóm 1 … nhóm 5 | nhóm nợ; phân loại nợ; nợ đủ tiêu chuẩn / nợ cần chú ý / nợ dưới tiêu chuẩn / nợ nghi ngờ / nợ có khả năng mất vốn | hạng nợ, cấp nợ | TT31 khoản 1 Điều 10 | TT31 |
| NPL | nợ xấu (nợ nhóm 3, 4, 5); tỷ lệ nợ xấu | NPL trong văn; "nợ khó đòi" | TT31 Điều 3: nợ xấu gồm nợ thuộc nhóm 3, 4 và 5 | TT31 |
| repayment allocation (`core_loan_payment_allocation`; `principal_amount`, `interest_amount`, `fee_amount`, `penalty_amount`) | phân bổ khoản trả nợ; gốc thu được; lãi thu được; phí; tiền phạt chậm trả | lãi phạt (chỉ dùng khi câu nói rõ cách tính phạt) | | DA |

### A.5 Thanh toán, bút toán, số dư và lãi

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| payment order (`core_payment_order`) | lệnh thanh toán; giao dịch (khi nói chung) | lệnh chuyển tiền (khi không phải chuyển khoản) | Chỉ có năm 2026 | DA |
| 'TRANSFER' / 'QR_PAY' / 'BILLPAY' | chuyển khoản / thanh toán QR / thanh toán hoá đơn | | | DA |
| 'CASH_DEPOSIT' / 'CASH_WITHDRAWAL' / 'POS_PAY' / 'SALES_IN' | nộp tiền mặt / rút tiền mặt / thanh toán qua POS / tiền bán hàng về tài khoản | quẹt thẻ | | DA |
| 'PAYROLL' / 'LOAN_REPAYMENT' / 'LOAN_DISBURSEMENT' | chi lương / trả nợ vay / giải ngân | | | DA |
| `channel_code` = 'MOBILE' / 'WEB' / 'BRANCH' / 'ATM' / 'POS' / 'QR' / 'API' | kênh giao dịch: ứng dụng di động / internet banking / tại quầy / ATM / POS / QR / kết nối API | app, online (chung chung) | | DA |
| `transaction_date` / `value_date` | ngày giao dịch / ngày giá trị | | Ngày giá trị là ngày tiền có hiệu lực tính lãi, có thể khác ngày giao dịch | DA |
| `posting_date` / `business_date` | ngày hạch toán / ngày làm việc của ngân hàng | | Đề lọc theo ngày nào phải nói rõ | DA |
| `payment_status` = 'COMPLETED' | thành công | | | DA |
| 'REVERSED' | giao dịch bị đảo (đã đảo bút toán) | huỷ, hoàn tiền | | DA |
| 'REJECTED' | giao dịch bị từ chối | thất bại, lỗi | | DA |
| `idempotency_key`, `source_system`, `source_reference` | khoá chống trùng lệnh; hệ thống nguồn; mã tham chiếu nguồn | | Hai lệnh cùng khoá chống trùng là cùng một yêu cầu | DA |
| posting (`core_account_posting`) | bút toán | dòng sổ, dòng giao dịch | Một lệnh thanh toán có thể sinh nhiều bút toán; chỉ có năm 2026 | DA |
| `debit_credit` = 'DEBIT' / 'CREDIT' | ghi Nợ / ghi Có | "nợ" (nghĩa vay), "trừ tiền / cộng tiền" thay cho thuật ngữ | Trên tài khoản tiền gửi của khách hàng, ghi Có làm số dư tăng, ghi Nợ làm số dư giảm; người soạn kiểm lại bằng `running_balance` | DA |
| `running_balance` | số dư sau bút toán | số dư chạy | | DA |
| `current_balance`, `as_of_business_date` | số dư tài khoản; ngày chốt số dư | số tiền trong tài khoản | Một dòng một tài khoản, chỉ là ảnh chụp tại một ngày | DA |
| interest accrual (`core_interest_accrual`; `accrual_date`, `accrued_amount`, `journal_id`) | lãi dự trả (với tiền gửi) / lãi dự thu (với khoản vay), gọi chung là lãi tính dồn theo ngày; ngày dự thu, dự trả; số lãi trong ngày; mã chứng từ hạch toán | lãi cộng dồn, lãi tích luỹ | Phần lớn dòng là hợp đồng tiền gửi, một phần là khoản vay; chỉ có năm 2026. Cách gọi theo nghiệp vụ kế toán ngân hàng, chưa có nguồn đã mở | DA |

### A.6 Thống kê, dữ liệu và SQL

Kế thừa nguyên văn `STYLE-scm.md` mục A.4 (thống kê) và A.5 (dữ liệu và SQL; chỉ dùng trong `yeucau`, `rangbuoc`, `\goiy`, `\luuy`, `\ghichuthietke`). Bổ sung cho bộ này:

| Tiếng Anh | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| reference date; as-of date | ngày tham chiếu | "hôm nay", `CURDATE()` | Mọi câu tính số ngày quá hạn, tuổi, thâm niên phải ghi ngày tham chiếu bằng giá trị DB | DA |
| weighted average rate | lãi suất bình quân gia quyền theo dư nợ (hoặc theo số tiền gửi) | lãi suất trung bình (khi có trọng số) | Đề nêu rõ trọng số | SCM A.4 |
| basis point | điểm cơ bản (0,01 điểm phần trăm) | bps, bp | Hiệu hai lãi suất ghi "điểm phần trăm" như SCM; chỉ dùng "điểm cơ bản" khi câu cần độ chi tiết đó | SCM A.4 |
| snapshot vs. history | số liệu tại một ngày (ảnh chụp) / lịch sử theo thời gian | | `outstanding`, `current_balance` là ảnh chụp; không dựng lại dư nợ quá khứ từ các cột này | DA |

Tổng số dòng thuật ngữ ở A.1–A.6: 96.

---

## B. Giọng văn cho từng phần của câu hỏi

Kế thừa nguyên văn `STYLE-scm.md` mục B (nguyên tắc chung 1–6, B.1–B.7). Dưới đây nhắc lại quy tắc ở dạng ngắn và đổi ví dụ sang ngân hàng.

Nguyên tắc chung:
1. Câu ngắn, một ý một câu. Câu dài nhất là câu nêu điều kiện dữ liệu.
2. Mỗi câu hỏi dùng một bộ từ thống nhất từ tiêu đề tới phương án kết luận (không lúc "dư nợ", lúc "số dư nợ"; không lúc "rút trước hạn", lúc "tất toán sớm").
3. Số: phẩy thập phân, chấm hàng nghìn (7,23%/năm; 2.389 khoản vay; 1.250.000.000 đồng). Tiền lớn được ghi "tỷ đồng", "triệu đồng" nhưng yêu cầu làm tròn phải ghi rõ đơn vị của cột kết quả. Hiệu hai tỷ lệ hoặc hai lãi suất là "điểm phần trăm". Trong LaTeX viết `\%`.
4. Lãi suất luôn kèm "/năm" khi viết số ("7,23\%/năm"). Cột kết quả lãi suất ghi rõ là tỷ lệ hay phần trăm.
5. Ngày tháng: "tháng 3/2026", "ngày 15/06/2026", "quý 2/2026", "năm 2026"; giá trị lọc trong `\code{}` giữ đúng dạng DB (`\code{'2026-06-30'}`).
6. Chính tả: "tỷ lệ", "huỷ", "uỷ quyền", "hoá đơn" (chọn kiểu -oá, -uỷ cho cả câu). Không nhắc "bài giảng", "lab", "sách", "dashboard" trong đề.

### B.1 Tiêu đề (`\tieude`)

Quy tắc như SCM B.1: câu hỏi nghiệp vụ hoặc cụm danh từ, tối đa 10 tiếng; câu Sửa lỗi nêu triệu chứng; câu Tối ưu được nhắc kỹ thuật; không dấu hai chấm, không hai vế, không "NPL", "DPD", "CASA ratio" trong tiêu đề (được viết "tỷ lệ CASA").

Ví dụ đạt
- `\tieude{Chi nhánh nào có tỷ lệ nợ xấu cao nhất?}` (Viết · Dễ)
- `\tieude{Dư nợ theo phân khúc bị đếm gấp đôi}` (Sửa lỗi · Dễ)
- `\tieude{Số dư cuối ngày chỉ với một lần quét bút toán}` (Tối ưu · Cơ bản)
- `\tieude{Vì sao tỷ lệ CASA ở miền Nam giảm?}` (Case · Khó)

### B.2 Bối cảnh (`\boicanh[Người · Vai trò]{Lời nhắn}`)

Quy tắc như SCM B.2. Vai trò có thật trong ngân hàng thương mại: Giám đốc chi nhánh, Trưởng phòng khách hàng cá nhân, Trưởng phòng khách hàng doanh nghiệp, Chuyên viên quan hệ khách hàng, Chuyên viên thẩm định tín dụng, Trưởng phòng quản lý rủi ro tín dụng, Chuyên viên xử lý nợ, Trưởng phòng vận hành thanh toán, Kế toán giao dịch, Chuyên viên tuân thủ (KYC), Trưởng phòng phát triển sản phẩm, Giám đốc khối nguồn vốn; Data engineer cho câu Tối ưu; Thực tập sinh cho câu Sửa lỗi cấp thấp. Xưng hô "anh/chị – em"; "mình" khi nói về ngân hàng ("chi nhánh mình", "danh mục cho vay của mình"). Một tới hai câu, tối đa khoảng 35 tiếng. Không tên bảng, cột, kỹ thuật SQL; không đặt sẵn đáp án.

Ví dụ đạt
- `\boicanh[Chị Lan · Trưởng phòng quản lý rủi ro tín dụng]{Tuần sau chị báo cáo chất lượng danh mục cho Ban điều hành. Em xem giúp chị chi nhánh nào đang có tỷ lệ nợ xấu cao nhất.}`
- `\boicanh[Anh Minh · Giám đốc khối nguồn vốn]{Chi phí vốn quý này tăng mà lãi suất niêm yết không đổi. Anh cần biết tiền gửi không kỳ hạn của từng miền thay đổi thế nào.}`
- `\boicanh[Bạn Thảo · Thực tập sinh]{Em cộng dư nợ theo phân khúc mà tổng lớn hơn số của phòng rủi ro gần gấp đôi. Anh chị xem giúp em sai ở đâu.}`

### B.3 Yêu cầu (`yeucau`, `rangbuoc`)

Quy tắc như SCM B.3: mỗi `\item` mở bằng động từ (Tính, Đếm, Liệt kê, Xếp hạng, Trả về, Sắp, Sửa, Giữ nguyên); thứ tự phạm vi → chỉ số → cột trả về (đơn vị, làm tròn) → thứ tự sắp → quy tắc bằng nhau; không "Hãy", "Với mỗi". Bổ sung cho ngân hàng:
- Câu có số ngày quá hạn, tuổi, thâm niên: item đầu ghi ngày tham chiếu.
- Câu có tiền: ghi đơn vị cột kết quả ("đồng", "triệu đồng, làm tròn 0 chữ số").
- Câu có lãi suất: ghi "phần trăm/năm, làm tròn 2 chữ số" hoặc "tỷ lệ, làm tròn 4 chữ số".
- Câu có trạng thái: ghi mã DB trong ngoặc ở cấp Cơ bản và Dễ.

Ví dụ đạt
```latex
\begin{yeucau}
  \item Lấy ngày tham chiếu \code{'2026-06-30'}. Xét các khoản vay chưa xử lý rủi ro (\code{loan_status} khác \code{'WRITTEN_OFF'}).
  \item Xếp mỗi khoản vay vào nhóm nợ theo số ngày quá hạn, theo tab Nghiệp vụ.
  \item Tính cho từng chi nhánh tổng dư nợ và tỷ lệ nợ xấu.
  \item Trả về \code{ref_branch_id}, \code{du_no} (triệu đồng, làm tròn 0 chữ số), \code{ty_le_no_xau_pct} (phần trăm, làm tròn 2 chữ số).
  \item Sắp \code{ty_le_no_xau_pct} giảm dần; bằng nhau thì \code{ref_branch_id} nhỏ hơn đứng trước.
\end{yeucau}
```

### B.4 Tab Nghiệp vụ (`nghiepvu`)

Quy tắc như SCM B.4: dòng mở là quyết định có thật của đúng người có quyền; tối đa một `\quytrinh`; `\khainiem` dùng mã ở mục E; `\luuy` một tới hai câu, không lộ số.

Ví dụ đạt
```latex
\begin{nghiepvu}{Chọn chi nhánh cần siết điều kiện cho vay và tăng cán bộ xử lý nợ.}
  \quytrinh{Vòng đời khoản vay}{nộp hồ sơ, duyệt, giải ngân, trả nợ theo kỳ, tất toán}{quá hạn, cơ cấu lại, xử lý rủi ro}
  \khainiem{nhom-no}
  \khainiem{ty-le-no-xau}
  \luuy{Khoản vay quá hạn dưới 91 ngày chưa phải nợ xấu. Tỷ lệ nợ xấu tính trên dư nợ, không tính trên số khoản vay.}
\end{nghiepvu}
```

### B.5 Gợi ý (`\goiy`)

Quy tắc như SCM B.5 và quyết định SCM G.5: nấc 1 hướng nghĩ nghiệp vụ hoặc bẫy dữ liệu; nấc 2 kỹ thuật bằng lời, được nêu tên hàm hoặc mệnh đề, không viết sẵn cả câu SQL.

Ví dụ đạt
- `\goiy{Một tài khoản có thể có nhiều chủ tài khoản. Nối thẳng sang bảng chủ thể thì số dư bị cộng mấy lần?}`
- `\goiy{Lấy ngày đến hạn sớm nhất của các kỳ quá hạn trong từng khoản vay bằng \code{MIN(due_date)}, rồi dùng \code{DATEDIFF} với ngày tham chiếu.}`

### B.6 Bước kết luận của case (`\phuongan`)

Quy tắc như SCM B.6 và quyết định SCM G.4 (sửa theo quy_chuan lúc 23:05: "Đúng: …" ở phương án đúng, phương án sai không tiền tố). Lỗi lập luận hay gặp ở ngân hàng, dùng làm phương án sai: lấy số khoản vay thay cho dư nợ; coi mọi khoản quá hạn là nợ xấu; cộng cả khoản đã xử lý rủi ro vào dư nợ; so lãi suất danh nghĩa mà bỏ qua kỳ hạn; coi số dư cuối kỳ là số dư bình quân; quy nguyên nhân cho kênh giao dịch khi chỉ thấy tương quan; trình bày giả định của bộ sinh dữ liệu như phát hiện.

Ví dụ đạt
```latex
\phuongan*{Tỷ lệ CASA giảm vì khách hàng chuyển tiền sang tiền gửi có kỳ hạn, còn tổng tiền gửi gần như không đổi.}
  {Đúng: bước 1 cho thấy tổng tiền gửi ổn định, bước 2 cho thấy lệnh gửi tiền có kỳ hạn tăng đúng các tháng số dư không kỳ hạn giảm.}
\phuongan{Tỷ lệ CASA giảm vì khách hàng rút tiền khỏi ngân hàng, nên cần tăng lãi suất tiền gửi có kỳ hạn ngay.}
  {Tổng tiền gửi ở bước 1 không giảm, tiền chỉ chuyển giữa hai loại tiền gửi.}
```

### B.7 Khai báo khái niệm (`\khaibaokhainiem{ma}{Tên}{Định nghĩa}{Công thức}{Trong bộ dữ liệu}`)

Quy tắc như SCM B.7. Bổ sung: định nghĩa có văn bản pháp quy đã đọc thì bám theo câu chữ của văn bản (TT31, TT48, TT49) nhưng không trích số điều trong đề; công thức có tiền ghi rõ đơn vị khi cần.

---

## C. Khuôn cấm

### C.1 Kế thừa nguyên văn từ SG mục C.2, C.3 (qua `STYLE-scm.md` C.1)

- Cụm cấm: "ứng viên", "cho ta", "mức tier", "phần tử", "So sánh có kiểm soát", "đóng vai trò quan trọng", "hãy cùng", "chìa khoá", "insight", "không chỉ… mà còn", "bức tranh", "đòn bẩy", "bỏ tiền qua cửa sổ", "khớp bài giảng", "Bài giảng đã chỉ ra", "Khuyến nghị:".
- Dấu gạch ngang dài "—" trong văn. Khuôn "mệnh đề: kết luận"; dấu hai chấm chỉ đứng trước danh sách cột hoặc danh sách điều kiện.
- Câu khẩu hiệu cuối đoạn. Ẩn dụ động từ: gánh, kéo, ăn vào lãi, giam vốn, phình, nhích, tụt, rơi, chạm mốc, đỡ, cứu. Bổ sung cho ngân hàng: hút tiền, gom tiền, bơm vốn, rót vốn, đốt tiền, "ôm" nợ, "ngấm" nợ xấu, "chảy máu" tiền gửi.
- Danh từ dịch máy (SCM) và bổ sung cho ngân hàng: tài khoản vãng lai (cho CASA), thực thể (cho party), tệp khách, khoản vay xấu, tỷ lệ vỡ nợ (khi không có mô hình PD), số dư chạy, lead (cho hồ sơ vay).
- Khuôn K1–K15 của SG C.3, ví dụ trước/sau xem SG C.3.

### C.2 Khuôn K16–K32 (giữ quy tắc của SCM, đổi ví dụ sang ngân hàng)

| # | Khuôn | TRƯỚC | SAU |
|---|---|---|---|
| K16 | Mở bối cảnh bằng câu sáo về thời đại | "Trong bối cảnh chuyển đổi số ngân hàng diễn ra mạnh mẽ, việc quản lý nợ xấu trở nên vô cùng cấp thiết." | "Tuần sau chị báo cáo chất lượng danh mục cho Ban điều hành." |
| K17 | Tự giới thiệu vai trò trong lời nhắn | "Với vai trò là Trưởng phòng rủi ro, chị muốn đánh giá danh mục cho vay." | "Cuối quý chị rà danh mục cho vay." |
| K18 | Động từ rỗng "thực hiện / tiến hành" | "Thực hiện việc tính toán dư nợ và tiến hành sắp xếp." | "Tính dư nợ. Sắp kết quả theo dư nợ giảm dần." |
| K19 | Bị động "được … bởi" | "Tỷ lệ nợ xấu được tính toán bởi dư nợ nhóm 3–5 chia cho tổng dư nợ." | "Tỷ lệ nợ xấu bằng dư nợ nhóm 3 tới 5 chia tổng dư nợ." |
| K20 | "một cách + tính từ" | "giúp đánh giá chất lượng tín dụng một cách toàn diện" | "giúp chọn chi nhánh cần siết điều kiện cho vay" |
| K21 | Từ nối liệt kê đầu mọi câu | "Đầu tiên, lọc khoản vay. Tiếp theo, nối bảng lịch trả nợ. Cuối cùng, sắp xếp." | Mỗi ý một `\item`, không từ nối. |
| K22 | Tiêu đề hỏi tu từ | "Liệu kênh ứng dụng di động có thực sự hiệu quả?" | "Kênh nào có tỷ lệ giao dịch bị từ chối cao nhất?" |
| K23 | Tính từ khen chê không đo được | "chi nhánh có chất lượng tín dụng vượt trội" | "chi nhánh có tỷ lệ nợ xấu thấp nhất" |
| K24 | In hoa, chấm than, in đậm để nhấn | "LƯU Ý: KHÔNG tính khoản đã xoá nợ!!!" | `\luuy{Khoản vay đã xử lý rủi ro không còn trong dư nợ.}` |
| K25 | Lặp "các", "những" | "Tính các dư nợ của các chi nhánh trong các tháng" | "Tính dư nợ của từng chi nhánh theo tháng" |
| K26 | Khuôn đề thi trường cũ | "Cho bảng core_loan_contract. Viết câu lệnh SQL để …" | Bối cảnh là lời nhắn; yêu cầu mới nói bảng, cột. |
| K27 | Liên từ chồng | "Vì vậy nên", "Do đó cho nên" | "Vì vậy", "Do đó" |
| K28 | Hán Việt hoá thừa | "nhằm mục đích", "trên cơ sở đó", "tiến hành triển khai" | "để", "từ đó", "làm" |
| K29 | Tiếng Anh văn phòng trong lời nhắn | "Em check giúp chị report NPL, fix trước deadline nhé." | "Em kiểm tra giúp chị báo cáo nợ xấu, sửa xong trước thứ sáu nhé." |
| K30 | Ngoặc kép rào đón | "khách hàng "tốt" hơn" | "khách hàng có hạng điểm tín dụng cao hơn" |
| K31 | Đại từ "nó" chỉ chỉ số | "Nó cho thấy chi nhánh CN05 có vấn đề." | "Tỷ lệ nợ xấu cho thấy chi nhánh CN05 …" |
| K32 | Phương án lộ đáp án bằng độ dài, từ rào | Phương án đúng dài gấp đôi, duy nhất có "cần thêm số liệu" | Ba phương án dài gần bằng nhau. |

### C.3 Khuôn bổ sung riêng cho bộ ngân hàng

| # | Khuôn | TRƯỚC | SAU |
|---|---|---|---|
| K33 | "Nợ" mơ hồ giữa khoản vay và ghi Nợ | "Tính tổng nợ của tài khoản trong tháng 3." | "Tính tổng số tiền ghi Nợ của tài khoản trong tháng 3/2026." |
| K34 | "Lãi" đứng một mình thay lãi suất hoặc tiền lãi | "Khoản vay có lãi cao nhất." | "Khoản vay có lãi suất cao nhất." hoặc "… có tiền lãi đến hạn lớn nhất." |
| K35 | Tiếng lóng nghiệp vụ | "phá sổ", "bẻ sổ", "đáo nợ", "giãn nợ", "ôm nợ" | "rút trước hạn"; "cơ cấu lại thời hạn trả nợ" |
| K36 | Gọi mọi khoản quá hạn là nợ xấu | "Khoản vay quá hạn 30 ngày là nợ xấu." | "Khoản vay quá hạn 30 ngày thuộc nợ cần chú ý (nhóm 2)." |
| K37 | Lãi suất không kèm kỳ tính | "lãi suất 7,23%" | "lãi suất 7,23%/năm" |
| K38 | Tiền không kèm đơn vị hoặc lẫn thang | "dư nợ 1.250" | "dư nợ 1.250 triệu đồng" |
| K39 | Gán ý định cho khách hàng khi chỉ thấy giao dịch | "Khách hàng chán ứng dụng nên quay lại quầy." | "Tỷ trọng giao dịch tại quầy của nhóm khách này tăng." |
| K40 | Lời nhắn đặt sẵn đáp án hoặc chỉ cách làm | "Em lấy dư nợ nhóm 3–5 chia tổng dư nợ giúp chị." | "Em xem giúp chị chi nhánh nào có tỷ lệ nợ xấu cao nhất." |

---

## D. Tám câu mẫu trước / sau

| # | Phần | TRƯỚC | SAU | Lý do |
|---|---|---|---|---|
| 1 | tieude | "Phân tích tình hình nợ xấu của các chi nhánh trong năm 2026" | "Chi nhánh nào có tỷ lệ nợ xấu cao nhất?" | cụm dài; "tình hình"; "các" thừa |
| 2 | boicanh | "\boicanh[Chị Lan · Risk Manager]{Với vai trò quản lý rủi ro, chị muốn em hãy viết SQL phân tích NPL một cách toàn diện.}" | "\boicanh[Chị Lan · Trưởng phòng quản lý rủi ro tín dụng]{Tuần sau chị báo cáo chất lượng danh mục cho Ban điều hành. Em xem giúp chị chi nhánh nào đang có tỷ lệ nợ xấu cao nhất.}" | K17, K2, K20, K26; vai trò tiếng Anh; NPL |
| 3 | yeucau | "Với mỗi khoản vay, hãy tính DPD và phân loại nhóm nợ." | "\item Tính số ngày quá hạn của từng khoản vay tại ngày tham chiếu \code{'2026-06-30'}, theo tab Nghiệp vụ." | K1, K2; DPD trong văn; thiếu ngày tham chiếu |
| 4 | luuy | "Lưu ý quan trọng: khoản vay DELINQUENT chính là nợ xấu." | "\luuy{Khoản vay đang quá hạn chưa chắc là nợ xấu. Nợ xấu chỉ gồm nợ nhóm 3 tới 5.}" | sai nghiệp vụ (TT31); "Lưu ý quan trọng:" |
| 5 | goiy | "Hãy nhớ CASA là tài khoản vãng lai nên số dư sẽ tụt khi lãi suất tăng." | "\goiy{So số dư tài khoản thanh toán với số tiền gửi có kỳ hạn còn hiệu lực ở cùng ngày.}" | K2; dịch máy; ẩn dụ "tụt"; lộ kết luận |
| 6 | yeucau | "Tính tổng tiền giao dịch theo kênh, tính cả giao dịch lỗi." | "\item Chỉ tính lệnh thanh toán thành công (\code{payment_status = 'COMPLETED'})." | "lỗi" mơ hồ giữa bị đảo và bị từ chối |
| 7 | phuongan | "Đúng: khách hàng phá sổ nhiều vì lãi suất thấp." | "Đúng. Tỷ lệ rút trước hạn cao nhất ở kỳ hạn có lãi suất thấp nhất." | khuôn "Đúng:"; tiếng lóng "phá sổ" |
| 8 | khaibaokhainiem | "Dư nợ: số tiền khách còn nợ ngân hàng, rất quan trọng với ngân hàng." | "Dư nợ là phần nợ gốc khách hàng chưa hoàn trả của khoản vay tại một ngày." | khuôn "X: giải thích"; K23 |

---

## E. Khái niệm khai báo cho bộ AIV Bank

Cột "trong bộ dữ liệu" dựa trên mô tả 26 bảng của database `aivb` (DA). Người soạn chạy truy vấn kiểm trước khi đưa khái niệm vào gói (các điểm cần kiểm ghi ở cuối mục). Bảng tóm tắt trước, khối LaTeX để dán sau.

| # | Mã | Tên | Bảng chính | Nguồn định nghĩa |
|---|---|---|---|---|
| 1 | `tien-va-lai-suat` | Quy ước tiền và lãi suất | mọi bảng có tiền, lãi suất | DA |
| 2 | `ngay-tham-chieu` | Ngày tham chiếu và cửa sổ dữ liệu | `core_payment_order`, `core_account_posting`, `core_interest_accrual` | DA |
| 3 | `chu-the-va-khach-hang` | Chủ thể và khách hàng | `core_party`, `core_customer` | DA |
| 4 | `phan-khuc-khach-hang` | Phân khúc khách hàng | `core_customer`, `hist_customer_segment`, `ref_segment` | DA |
| 5 | `kyc` | Nhận biết khách hàng (KYC) | `core_customer`, `core_customer_kyc_event` | DA |
| 6 | `casa` | Tiền gửi không kỳ hạn (CASA) | `core_account`, `core_account_balance` | TTTC; DA |
| 7 | `ty-le-casa` | Tỷ lệ CASA | `core_account_balance`, `core_deposit_contract` | TTTC |
| 8 | `tien-gui-co-ky-han` | Tiền gửi có kỳ hạn | `core_deposit_contract` | TT49 |
| 9 | `tai-tuc` | Tái tục | `core_deposit_contract` | TT49; TT48 |
| 10 | `rut-truoc-han` | Rút trước hạn và tất toán | `core_deposit_contract` | TT48; TT49 |
| 11 | `so-du` | Số dư tài khoản | `core_account_balance`, `core_account_posting` | DA |
| 12 | `ghi-no-ghi-co` | Ghi Nợ, ghi Có | `core_account_posting` | DA |
| 13 | `giao-dich-bi-dao` | Giao dịch bị đảo, bị từ chối | `core_payment_order` | DA |
| 14 | `kenh-giao-dich` | Kênh giao dịch | `core_payment_order` | DA |
| 15 | `ho-so-vay-va-ty-le-duyet` | Hồ sơ vay và tỷ lệ duyệt | `core_loan_application`, `core_credit_decision` | DA |
| 16 | `hang-diem-tin-dung` | Hạng điểm tín dụng | `core_loan_application`, `ref_policy_version` | DA |
| 17 | `dti` | Tỷ lệ nợ trên thu nhập (DTI) | `core_loan_application`, `ref_policy_version` | DA |
| 18 | `giai-ngan` | Giải ngân | `core_loan_disbursement`, `core_loan_contract` | TT31; DA |
| 19 | `du-no` | Dư nợ | `core_loan_contract` | TT31; DA |
| 20 | `lich-tra-no` | Lịch trả nợ và phân bổ khoản trả | `core_loan_schedule`, `core_loan_payment_allocation` | DA |
| 21 | `no-qua-han` | Nợ quá hạn và số ngày quá hạn | `core_loan_schedule` | TT31 |
| 22 | `nhom-no` | Nhóm nợ | `core_loan_schedule`, `core_loan_contract` | TT31 |
| 23 | `ty-le-no-xau` | Tỷ lệ nợ xấu | `core_loan_contract`, `core_loan_schedule` | TT31 |
| 24 | `trang-thai-khoan-vay` | Trạng thái khoản vay | `core_loan_contract` | TT31; DA |
| 25 | `lai-du-thu-du-tra` | Lãi dự thu, lãi dự trả | `core_interest_accrual` | DA |

```latex
% ---------------------------------------------------------------- khái niệm · AIV Bank
% \khaibaokhainiem{ma}{Tên}{Định nghĩa}{Công thức}{Trong bộ dữ liệu}

% --- Quy ước chung
\khaibaokhainiem{tien-va-lai-suat}{Quy ước tiền và lãi suất}
  {Số tiền trong bộ dữ liệu tính bằng đồng Việt Nam. Lãi suất là lãi suất danh nghĩa tính theo năm.}
  {lãi suất (\%/năm) = interest\_rate × 100}
  {mọi cột tiền là số nguyên đồng (\code{BIGINT}); \code{interest_rate}, \code{dti}, \code{approval_rate}, \code{dti_cap} lưu dạng tỷ lệ, ví dụ \code{0.0723} là 7,23\%/năm. Cột \code{currency} cần kiểm trước khi cộng tiền của nhiều hợp đồng.}
\khaibaokhainiem{ngay-tham-chieu}{Ngày tham chiếu và cửa sổ dữ liệu}
  {Ngày tham chiếu là ngày chốt số liệu dùng để tính số ngày quá hạn, tuổi, thâm niên và các số dư tại một thời điểm.}
  {}
  {lệnh thanh toán, bút toán và lãi tính dồn chỉ có năm 2026; lịch trả nợ có cả kỳ đến hạn sau năm 2026. Mỗi câu ghi ngày tham chiếu bằng giá trị cụ thể, không dùng \code{CURDATE()}.}

% --- Khách hàng
\khaibaokhainiem{chu-the-va-khach-hang}{Chủ thể và khách hàng}
  {Chủ thể là cá nhân hoặc tổ chức có quan hệ với ngân hàng. Khách hàng là chủ thể đã thiết lập quan hệ khách hàng với ngân hàng.}
  {}
  {\code{core_party} (\code{party_type} = \code{'PERSON'} hoặc \code{'ORGANIZATION'}), chi tiết ở \code{core_person}, \code{core_organization}; \code{core_customer} nối qua \code{party_id}. Tên trong \code{legal_name} có thể trùng giữa các chủ thể khác nhau, nên đếm theo \code{party_id}.}
\khaibaokhainiem{phan-khuc-khach-hang}{Phân khúc khách hàng}
  {Phân khúc khách hàng là nhóm khách hàng có đặc điểm và nhu cầu tương tự, được ngân hàng phục vụ bằng chính sách sản phẩm riêng.}
  {}
  {phân khúc hiện tại ở \code{core_customer.segment_code}, tên ở \code{ref_segment.segment_name}; phân khúc theo thời gian ở \code{hist_customer_segment} (\code{valid_from}, \code{valid_to}). Câu hỏi ghi rõ dùng phân khúc hiện tại hay phân khúc tại ngày giao dịch.}
\khaibaokhainiem{kyc}{Nhận biết khách hàng (KYC)}
  {Nhận biết khách hàng là quy trình ngân hàng thu thập và xác minh thông tin của khách hàng trước và trong khi thiết lập quan hệ.}
  {}
  {kết quả hiện tại ở \code{core_customer.kyc_status} (\code{'PASS'}, \code{'FAIL'}); lịch sử ở \code{core_customer_kyc_event}, mỗi vòng có \code{kyc_cycle_no}, các sự kiện theo \code{event_sequence} (\code{'KYC_SUBMITTED'}, \code{'APPROVED'}, \code{'REJECTED'}). Kết quả của một vòng là sự kiện có \code{event_sequence} lớn nhất.}

% --- Huy động vốn
\khaibaokhainiem{casa}{Tiền gửi không kỳ hạn (CASA)}
  {Tiền gửi không kỳ hạn là tiền khách hàng gửi trên tài khoản thanh toán, rút hoặc chuyển được bất cứ lúc nào.}
  {}
  {tài khoản ở \code{core_account} (chỉ gồm tài khoản thanh toán, sản phẩm \code{'CASA_IND'}, \code{'CASA_BIZ'}); số dư ở \code{core_account_balance.current_balance} tại \code{as_of_business_date}.}
\khaibaokhainiem{ty-le-casa}{Tỷ lệ CASA}
  {Tỷ lệ CASA là phần tiền gửi không kỳ hạn trong tổng tiền gửi của khách hàng.}
  {số dư tiền gửi không kỳ hạn / (số dư tiền gửi không kỳ hạn + số tiền gửi có kỳ hạn còn hiệu lực)}
  {tử số từ \code{core_account_balance}; tiền gửi có kỳ hạn còn hiệu lực là \code{core_deposit_contract.principal} với \code{deposit_status = 'ACTIVE'} (\code{'RENEWED'} là hợp đồng cũ đã tái tục sang hợp đồng mới, không tính vào để khỏi trùng). Hai phần phải lấy cùng một ngày.}
\khaibaokhainiem{tien-gui-co-ky-han}{Tiền gửi có kỳ hạn}
  {Tiền gửi có kỳ hạn là khoản tiền của khách hàng gửi tại tổ chức tín dụng trong một thời hạn nhất định, với nguyên tắc hoàn trả đầy đủ tiền gốc và lãi.}
  {}
  {\code{core_deposit_contract}: \code{principal} (số tiền gửi), \code{interest_rate}, \code{term_months} (kỳ hạn), \code{maturity_date} (ngày đến hạn), \code{deposit_status} (\code{'ACTIVE'} là đang còn hiệu lực), \code{settlement_account_id} (tài khoản nhận gốc và lãi), \code{pledged_flag} (đang làm tài sản bảo đảm). Sản phẩm qua \code{core_contract.product_version_id}.}
\khaibaokhainiem{tai-tuc}{Tái tục}
  {Tái tục là việc kéo dài thời hạn gửi tiền vào ngày đến hạn của khoản tiền gửi có kỳ hạn, theo thoả thuận giữa ngân hàng và khách hàng.}
  {tỷ lệ tái tục = số hợp đồng tái tục / số hợp đồng đã đến hạn}
  {\code{deposit_status = 'RENEWED'}. Mẫu số chỉ gồm hợp đồng có \code{maturity_date} không muộn hơn ngày tham chiếu; câu hỏi ghi rõ có tính hợp đồng rút trước hạn hay không.}
\khaibaokhainiem{rut-truoc-han}{Rút trước hạn và tất toán}
  {Rút trước hạn là việc khách hàng nhận lại tiền gửi trước ngày đến hạn. Tất toán là việc kết thúc hợp đồng tiền gửi và chi trả gốc, lãi cho khách hàng.}
  {tỷ lệ rút trước hạn = số hợp đồng rút trước hạn / số hợp đồng trong phạm vi xét}
  {\code{deposit_status}: \code{'EARLY_TERMINATED'} (rút trước hạn), \code{'CLOSED'} (đã tất toán), \code{'ACTIVE'} (đang còn hiệu lực), \code{'RENEWED'} (hợp đồng cũ đã tái tục sang hợp đồng mới, không còn hiệu lực). Lệnh chi trả tiền gửi đến hạn có \code{transaction_type = 'TD_MATURITY'}.}

% --- Tài khoản, thanh toán
\khaibaokhainiem{so-du}{Số dư tài khoản}
  {Số dư là số tiền còn lại trên tài khoản tại một thời điểm, sau khi đã ghi nhận mọi bút toán tới thời điểm đó.}
  {số dư cuối ngày = số dư đầu ngày + tổng ghi Có - tổng ghi Nợ trong ngày}
  {số dư chốt ở \code{core_account_balance} (một dòng một tài khoản, tại \code{as_of_business_date}); số dư sau từng bút toán ở \code{core_account_posting.running_balance}. Số dư cuối ngày là \code{running_balance} của bút toán cuối cùng trong ngày; câu hỏi ghi rõ khoá sắp khi nhiều bút toán cùng ngày.}
\khaibaokhainiem{ghi-no-ghi-co}{Ghi Nợ, ghi Có}
  {Ghi Có là bút toán làm tăng số dư tài khoản tiền gửi của khách hàng; ghi Nợ là bút toán làm giảm số dư đó.}
  {}
  {\code{core_account_posting.debit_credit} = \code{'CREDIT'} hoặc \code{'DEBIT'}; \code{amount} luôn là số dương. "Nợ" ở đây là phía của bút toán, không phải khoản vay.}
\khaibaokhainiem{giao-dich-bi-dao}{Giao dịch bị đảo, bị từ chối}
  {Giao dịch bị đảo là giao dịch đã được ghi nhận rồi bị huỷ bỏ bằng bút toán ngược chiều. Giao dịch bị từ chối là lệnh không được hệ thống chấp nhận thực hiện.}
  {tỷ lệ bị từ chối = số lệnh bị từ chối / tổng số lệnh}
  {\code{core_payment_order.payment_status}: \code{'COMPLETED'}, \code{'REVERSED'}, \code{'REJECTED'}. Doanh số giao dịch chỉ tính lệnh \code{'COMPLETED'}; câu hỏi ghi rõ bút toán của lệnh bị đảo có được tính vào số dư hay không. Bảng bút toán chỉ giữ bút toán gốc của lệnh, không có bút toán ngược chiều cho lệnh bị đảo.} % v3 10/11: câu bổ sung duyệt theo aivb-t2 (Parameter Book: POST.REVERSAL.1 MIRROR, POST.REJECT.1)
\khaibaokhainiem{kenh-giao-dich}{Kênh giao dịch}
  {Kênh giao dịch là phương tiện khách hàng dùng để gửi lệnh tới ngân hàng.}
  {tỷ trọng kênh = số lệnh (hoặc số tiền) qua kênh / tổng của mọi kênh}
  {\code{core_payment_order.channel_code}: \code{'MOBILE'}, \code{'WEB'}, \code{'BRANCH'}, \code{'ATM'}, \code{'POS'}, \code{'QR'}, \code{'API'}. Không có bảng chiến dịch tiếp thị; kênh là thông tin tiếp thị duy nhất.}

% --- Cấp tín dụng
\khaibaokhainiem{ho-so-vay-va-ty-le-duyet}{Hồ sơ vay và tỷ lệ duyệt}
  {Tỷ lệ duyệt là phần hồ sơ vay được ngân hàng chấp thuận trong tổng số hồ sơ đã có quyết định.}
  {số hồ sơ được duyệt / tổng số hồ sơ}
  {\code{core_loan_application.application_status} (\code{'APPROVED'}, \code{'REJECTED'}); số tiền được duyệt ở \code{core_credit_decision.approved_amount}. \code{ref_policy_version.approval_rate} là mức của chính sách, không phải tỷ lệ duyệt thực tế.}
\khaibaokhainiem{hang-diem-tin-dung}{Hạng điểm tín dụng}
  {Hạng điểm tín dụng là nhóm rủi ro của người vay do ngân hàng xếp từ kết quả chấm điểm tín dụng.}
  {}
  {\code{core_loan_application.score_band} từ \code{'A'} tới \code{'D'}; ngưỡng điểm duyệt của từng phiên bản chính sách ở \code{ref_policy_version.score_cutoff}. Bộ dữ liệu không có điểm số chi tiết.}
\khaibaokhainiem{dti}{Tỷ lệ nợ trên thu nhập (DTI)}
  {Tỷ lệ nợ trên thu nhập phản ánh phần thu nhập của người vay dùng để trả các khoản nợ.}
  {tổng nghĩa vụ trả nợ định kỳ / thu nhập định kỳ}
  {có sẵn ở \code{core_loan_application.dti} (dạng tỷ lệ); trần DTI của chính sách ở \code{ref_policy_version.dti_cap}, nối qua \code{policy_version_id}.}
\khaibaokhainiem{giai-ngan}{Giải ngân}
  {Giải ngân là việc ngân hàng chuyển tiền vay cho khách hàng hoặc bên thụ hưởng theo hợp đồng vay. Một khoản vay có thể giải ngân nhiều lần.}
  {}
  {\code{core_loan_disbursement} (\code{amount}, \code{disbursement_date}, \code{payment_order_id}); ngày giải ngân đầu ở \code{core_loan_contract.disbursement_date}. Khoản vay có \code{opening_book_flag} là khoản vay đầu kỳ, có thể không có dòng giải ngân.}
\khaibaokhainiem{du-no}{Dư nợ}
  {Dư nợ là phần nợ gốc khách hàng chưa hoàn trả của khoản vay tại một ngày.}
  {dư nợ = số tiền đã giải ngân - gốc đã thu}
  {có sẵn ở \code{core_loan_contract.outstanding}, là số liệu tại ngày chốt dữ liệu, không phải chuỗi theo thời gian. Câu hỏi cần dư nợ tại ngày khác phải tự tính và ghi rõ cách tính.}
\khaibaokhainiem{lich-tra-no}{Lịch trả nợ và phân bổ khoản trả}
  {Lịch trả nợ là các kỳ trả nợ của khoản vay, mỗi kỳ có ngày đến hạn, số gốc và số lãi phải trả. Khoản tiền khách hàng trả được phân bổ vào gốc, lãi, phí và tiền phạt.}
  {}
  {\code{core_loan_schedule}: \code{installment_no}, \code{due_date}, \code{principal_due}, \code{interest_due}, \code{principal_paid}, \code{interest_paid}, \code{schedule_status} (\code{'PAID'}, \code{'DUE'}, \code{'OVERDUE'}, \code{'CANCELLED'}); phân bổ ở \code{core_loan_payment_allocation}.}

% --- Chất lượng tín dụng
\khaibaokhainiem{no-qua-han}{Nợ quá hạn và số ngày quá hạn}
  {Khoản nợ quá hạn là khoản nợ mà khách hàng không trả được đúng hạn một phần hoặc toàn bộ nợ gốc hoặc lãi. Số ngày quá hạn đếm từ ngày đến hạn đầu tiên chưa trả tới ngày tham chiếu.}
  {số ngày quá hạn = ngày tham chiếu - ngày đến hạn sớm nhất của các kỳ quá hạn}
  {bộ dữ liệu không có cột số ngày quá hạn. Kỳ quá hạn là dòng \code{core_loan_schedule} có \code{schedule_status = 'OVERDUE'}; câu hỏi chọn một cách xác định kỳ quá hạn (theo trạng thái hoặc theo \code{due_date} so ngày tham chiếu và số đã trả) và không trộn hai cách.}
\khaibaokhainiem{nhom-no}{Nhóm nợ}
  {Nhóm nợ là kết quả phân loại khoản nợ theo mức rủi ro, từ nhóm 1 (nợ đủ tiêu chuẩn), nhóm 2 (nợ cần chú ý), nhóm 3 (nợ dưới tiêu chuẩn), nhóm 4 (nợ nghi ngờ) tới nhóm 5 (nợ có khả năng mất vốn).}
  {theo số ngày quá hạn: nhóm 1 dưới 10 ngày; nhóm 2 từ 10 tới 90 ngày; nhóm 3 từ 91 tới 180 ngày; nhóm 4 từ 181 tới 360 ngày; nhóm 5 trên 360 ngày}
  {số ngày quá hạn tính như \code{no-qua-han}; khoản vay không có kỳ quá hạn thuộc nhóm 1. Bộ câu chỉ phân loại theo số ngày quá hạn; quy định đầy đủ còn xếp nhóm theo việc cơ cấu lại, gia hạn nợ, không mô phỏng ở đây.}
\khaibaokhainiem{ty-le-no-xau}{Tỷ lệ nợ xấu}
  {Nợ xấu là nợ thuộc nhóm 3, 4 và 5. Tỷ lệ nợ xấu là phần dư nợ xấu trong tổng dư nợ.}
  {dư nợ nhóm 3, 4, 5 / tổng dư nợ}
  {dư nợ lấy \code{core_loan_contract.outstanding}; khoản vay \code{'WRITTEN_OFF'} không vào cả tử số lẫn mẫu số. Tính trên dư nợ, không trên số khoản vay.}
\khaibaokhainiem{trang-thai-khoan-vay}{Trạng thái khoản vay}
  {Trạng thái khoản vay cho biết khoản vay đang được trả bình thường, đang quá hạn, đã cơ cấu lại thời hạn trả nợ, đã xử lý rủi ro hay đã tất toán.}
  {}
  {\code{core_loan_contract.loan_status}: \code{'ACTIVE'}, \code{'DELINQUENT'} (đang quá hạn), \code{'RESTRUCTURED'} (đã cơ cấu lại), \code{'WRITTEN_OFF'} (đã xử lý rủi ro), \code{'SETTLED'} (đã tất toán). \code{'DELINQUENT'} không đồng nghĩa với nợ xấu.}

% --- Lãi
\khaibaokhainiem{lai-du-thu-du-tra}{Lãi dự thu, lãi dự trả}
  {Lãi dự thu là tiền lãi của khoản vay ngân hàng đã tính cho từng ngày nhưng chưa thu. Lãi dự trả là tiền lãi của khoản tiền gửi ngân hàng đã tính cho từng ngày nhưng chưa trả.}
  {lãi một ngày ≈ số tiền gốc × lãi suất năm / số ngày quy ước của năm}
  {\code{core_interest_accrual} (\code{contract_id}, \code{accrual_date}, \code{accrued_amount}, \code{journal_id}); phần lớn là hợp đồng tiền gửi, một phần là khoản vay, chỉ có năm 2026. Phân biệt hai loại bằng cách nối \code{contract_id} sang \code{core_deposit_contract} hoặc \code{core_loan_contract}. Số ngày quy ước của năm ghi trong yêu cầu.}
```

Ghi chú cho người soạn khi dùng mục E (cần kiểm bằng truy vấn chỉ đọc trước khi ra đề):
- Ngưỡng nhóm 2: TT31 ghi nhóm 1 là "quá hạn dưới 10 ngày" và nhóm 2 là "quá hạn đến 90 ngày", nên công thức ghi nhóm 2 "từ 10 tới 90 ngày". Không dùng nhóm 2 cho khoản đang trong hạn.
- `schedule_status = 'OVERDUE'` và cách tính theo `due_date` có thể không khớp nhau (trạng thái được sinh tại một ngày cố định). Kiểm độ khớp, ghi số khớp vào `mysql/README-aivb.md`.
- `loan_status = 'DELINQUENT'` và việc có kỳ `'OVERDUE'`: kiểm mỗi khoản DELINQUENT có ít nhất một kỳ quá hạn không.
- `outstanding` của khoản `'WRITTEN_OFF'` và `'SETTLED'`: kiểm có bằng 0 không trước khi quy định trong `ty-le-no-xau`.
- Thang của `dti`, chiều tốt – xấu của `score_band`, giá trị `currency`, và việc lệnh `'REVERSED'` có bút toán ở `core_account_posting` hay không: kiểm và ghi vào README trước khi soạn.
- Số dư CASA và tiền gửi có kỳ hạn phải lấy cùng một ngày; `core_account_balance` chỉ có một ngày chốt, nên câu tỷ lệ CASA theo tháng phải dựng số dư từ `running_balance`.

---

## F. Điểm cần giảng viên chốt

1. Giáo trình: đợt này không mở được toàn văn giáo trình nào của Học viện Ngân hàng, ĐH Kinh tế Quốc dân, ĐH Kinh tế TP.HCM, Học viện Tài chính. Bảng thuật ngữ đang dựa trên văn bản NHNN đọc được (TT31, TT48, TT49), dữ liệu dự án và một bài của Tạp chí Thị trường Tài chính Tiền tệ. Nếu giảng viên có bản giấy giáo trình Ngân hàng thương mại hoặc Tín dụng ngân hàng, cần đối chiếu các dòng chỉ có nguồn DA.
2. Văn bản cho vay: đề bài giao nhắc "Thông tư 39/2016 và văn bản thay thế". Tìm kiếm chỉ thấy các thông tư sửa đổi (06/2023, 12/2024, 29/2026), chưa thấy văn bản thay thế hoàn toàn. TT39 và TT17 chưa đọc được nguyên văn (trang trả 403); các dòng có `*` chỉ dựa vào tên văn bản.
3. Tiền gửi có kỳ hạn: đề bài giao gọi Thông tư 48/2018 là thông tư về tiền gửi có kỳ hạn; thực tế TT48 là tiền gửi tiết kiệm, còn tiền gửi có kỳ hạn là Thông tư 49/2018. Bộ chuẩn dùng cả hai, gọi chung "tiền gửi có kỳ hạn" vì dữ liệu có cả tổ chức.
4. "Tái tục" hay "kéo dài thời hạn gửi tiền": văn bản dùng "kéo dài"; ngân hàng quen dùng "tái tục". Bộ chuẩn chọn "tái tục" có giải nghĩa lần đầu.
5. "Rút trước hạn" hay "tất toán trước hạn": bộ chuẩn theo TT48 ("rút trước hạn").
6. Lãi tính dồn theo ngày: chọn "lãi dự thu" (khoản vay) và "lãi dự trả" (tiền gửi). Đề bài giao gộp cả hai là "lãi dự thu" ở mảng `finance`; gộp như vậy sai với phần tiền gửi. Xin xác nhận cách gọi.
7. Nhóm nợ: bộ câu chỉ dùng tiêu chí số ngày quá hạn (định lượng một phần của TT31 khoản 1 Điều 10), không mô phỏng nợ cơ cấu lại, gia hạn, hay nguyên tắc xếp mọi khoản của một khách hàng vào cùng nhóm. Có cần một câu Khó về nguyên tắc xếp cùng nhóm không?
8. Tên phân khúc: nếu `ref_segment.segment_name` đã có tên tiếng Việt thì dùng tên đó; v3 (10/11): DB có tên tiếng Việt cho cả 8 phân khúc (đại chúng, khá giả, giàu có, ưu tiên; siêu nhỏ, vừa và nhỏ, doanh nghiệp lớn, định chế), dùng đúng tên này.

---

## G. Quyết định tạm (10/11/2026) cho lô thử – chờ giảng viên duyệt

1. Các quyết định tạm 1–7 của `STYLE-scm.md` mục G (gọi tên kỹ thuật SQL trong `yeucau`, `\goiy`; "Đúng: …" ở phương án đúng, phương án sai không tiền tố; gợi ý nấc cuối được nêu trọn một biểu thức một dòng (G.4, G.5 của STYLE-scm sửa theo quy_chuan lúc 10/11, 23:05); quy ước P95 trên MySQL) áp dụng nguyên cho bộ AIV Bank.
2. Mọi câu có số ngày quá hạn, tuổi, thâm niên ghi ngày tham chiếu bằng giá trị DB.
3. Mọi câu có tiền ghi đơn vị cột kết quả; mọi câu có lãi suất ghi "%/năm" hoặc "tỷ lệ".
4. Mảng nghiệp vụ (`domain`) dùng 6 khoá chuẩn, không thêm khoá mới:

| Khoá | Ánh xạ sang bộ AIV Bank | Bảng chính | Ghi chú |
|---|---|---|---|
| `customer` | khách hàng, chủ thể, phân khúc, lịch sử phân khúc, KYC (trạng thái và các vòng KYC), thâm niên, đặc điểm cá nhân và tổ chức | `core_party`, `core_person`, `core_organization`, `core_customer`, `hist_customer_segment`, `core_customer_kyc_event`, `ref_segment`, `ref_industry` | |
| `finance` | dư nợ, lãi suất bình quân, số dư tài khoản, tỷ lệ CASA, lãi dự thu và lãi dự trả, cơ cấu tiền gửi | `core_loan_contract`, `core_account_balance`, `core_deposit_contract`, `core_interest_accrual`, `core_account_posting` | Không có bảng thu nhập, chi phí, bảng cân đối: không tính được NIM, lợi nhuận đầy đủ |
| `sales` | sản phẩm và phiên bản sản phẩm, huy động tiền gửi mới, tái tục, hồ sơ vay, tỷ lệ duyệt, số tiền được duyệt, giải ngân, hạng điểm tín dụng, DTI | `ref_product`, `ref_product_version`, `core_contract`, `core_deposit_contract`, `core_loan_application`, `core_credit_decision`, `core_loan_disbursement`, `ref_policy_version` | |
| `operations` | lệnh thanh toán, bút toán, ghi Nợ và ghi Có, ngày giá trị và ngày hạch toán, khoá chống trùng, chi nhánh, tài khoản và người đồng sở hữu, lịch trả nợ, phân bổ khoản trả | `core_payment_order`, `core_account_posting`, `core_account`, `core_account_party`, `ref_branch`, `core_loan_schedule`, `core_loan_payment_allocation` | |
| `marketing` | kênh giao dịch (`channel_code`) và loại giao dịch theo phân khúc, chi nhánh, miền | `core_payment_order`, `core_customer`, `ref_segment`, `ref_branch` | **Bộ dữ liệu không có bảng chiến dịch, khuyến mãi hay tiếp thị.** Câu `marketing` chỉ hỏi về kênh và phân khúc, không đặt ra hiệu quả chiến dịch |
| `after_sales` | nợ quá hạn, nhóm nợ, tỷ lệ nợ xấu, khoản vay `'DELINQUENT'`, `'RESTRUCTURED'`, `'WRITTEN_OFF'`, giao dịch bị đảo và bị từ chối, rút trước hạn, KYC không đạt | `core_loan_schedule`, `core_loan_contract`, `core_payment_order`, `core_deposit_contract`, `core_customer_kyc_event` | **Bộ dữ liệu không có bảng khiếu nại hay yêu cầu hỗ trợ.** "Sau bán" ở đây là chất lượng tín dụng và giao dịch lỗi |

Ranh giới khi một câu chạm hai mảng: chất lượng tín dụng (quá hạn, nợ xấu) luôn là `after_sales` dù có dư nợ; quy mô dư nợ, số dư, lãi là `finance`; số lượng hồ sơ, hợp đồng mới là `sales`; KYC theo vòng và trạng thái là `customer`, riêng câu hỏi về KYC không đạt và lý do từ chối là `after_sales`.

### Quyết định chung 5 bộ (theo `QUYET-DINH-CHUNG.md`, 10/11/2026)

Áp chung cho `scm`, `aivb`, `jelly`, `hr`, `mkt`. Lệch với chỗ khác trong file này thì theo các dòng dưới. **Thứ tự ưu tiên: `quy_chuan` (quy_chuan.rar) > `QUYET-DINH-CHUNG.md` > file STYLE này > brief.** Chi tiết, căn cứ và bảng các điểm đã sửa theo quy chuẩn (10/11, 23:05) ở `QUYET-DINH-CHUNG.md` mục 0.

- **Kết luận case** (sửa theo quy_chuan: goi-cau-hoi-mau/cau-hoi.tex, câu c1–c4, lúc 10/11, 23:05): ba phương án, đúng một `\phuongan*`. Lời giải thích của phương án đúng mở bằng **"Đúng: "** rồi nêu căn cứ; phương án sai **không có tiền tố**, nêu thẳng chỗ sai. Không dùng "Chưa đúng.", "Sai:". 1–2 câu, ≤ 35 tiếng (lời giải thích dài nhất của mẫu, c3, khoảng 34 tiếng), nêu bước nào cho thấy điều gì.
- **Case Cơ bản:** được `GROUP BY` một cột + một hàm gom trên **một bảng** (theo case mẫu `c1-kenh-nhieu-don` của CHOT); không `JOIN`, `HAVING`, truy vấn con. Ghi lý do một dòng ở `\ghichuthietke`.
- **Gợi ý** (sửa theo quy_chuan: cau-hoi.tex w1, w3, o3, o4; Huong-dan mục 10 bước 7): 1–2 nấc ở câu, 1 nấc ở mỗi bước case. Nấc đầu nêu hướng (bảng cần dùng, cách tách bước, bẫy); nấc cuối được nêu trọn **một biểu thức một dòng**, kể cả giá trị lọc hoặc tiêu chí hoà, như mẫu w3 `ROW_NUMBER() OVER (PARTITION BY category ORDER BY doanh_thu DESC, product_id)`. Không viết sẵn cả câu SQL, không khung nhiều dòng. **Bỏ** yêu cầu "để trống ít nhất một thành phần".
- **ERD** (sửa một phần theo quy_chuan: CHOT-FORMAT mục 3, Huong-dan mục 5, mẫu w4, d4, o4, c4): số bảng Cơ bản 1 · Dễ 2 · Trung bình 3–4 · Khó 5–7. Bảng nhiễu: Cơ bản 0 · Dễ ≤ 1 · Trung bình ≤ 1 (quy ước bổ sung) · Khó 1–2, bắt buộc có; câu Khó mà lời giải dùng ≤ 3 bảng được thêm bảng nhiễu cho đủ 5 bảng như mẫu d4, o4. ERD Khó **chỉ khoá, không vẽ `\erdnoi`**; cách nối viết trong `\erdkhoa`. Bảng nhiễu ở Dễ, Trung bình có đường nối đúng với bảng dùng; ở Khó nên có cột khoá chung với bảng dùng (mẫu w4) nhưng không bắt buộc (mẫu o4). Bảng nhiễu không làm tăng cấp.
- **Cấp** (sửa một phần theo quy_chuan: Huong-dan mục 6, lo-trinh-sql/assets/js/data.js): theo thang `QUYET-DINH-CHUNG.md` mục 2: cấp = mức mà ≥ 3/5 trục đạt (số bảng lời giải cần, số bước, mức mơ hồ, số bẫy, độ sâu nghiệp vụ). Ở M1–3: Dễ = Cơ bản + một bẫy hoặc một bước. **Bỏ ngoại lệ "M7, M8 không có Dễ"**: lộ trình chuẩn cho mọi module đủ 4 cấp; sửa lỗi một chỗ dễ thấy là Dễ, muốn Trung bình thì lỗi phải khó thấy (nối thừa nhân dòng, sai phạm vi cửa sổ) hoặc thêm lỗi, bẫy thật. Câu Khó không bắt buộc ≥ 4 bảng (mẫu o4 dùng 1 bảng). Optimize lấy cấp theo mẫu kỹ thuật của CHOT mục 4.
- **Yêu cầu (`yeucau`):** thứ tự sắp luôn kết thúc bằng một khoá duy nhất; top N nói rõ lấy đúng N dòng hay lấy cả người hoà; ghi số chữ số và kiểu làm tròn, chỉ làm tròn cột cuối; tỷ lệ trả phần trăm 2 chữ số (tên cột tuỳ: mẫu dùng cả `ty_le_tra` lẫn `thay_doi_pct`), nếu bắt buộc trả 0–1 thì 4 chữ số và đặt `saiso=0.0001`; NULL nói rõ giữ NULL, thay bằng giá trị gì, hay loại dòng; tháng, quý trả chuỗi theo dạng ghi trong đề; năm trả số, trừ khi đề ghi rõ trả chuỗi như mẫu o2; mốc thời gian ghi cả cận dưới và cận trên.
- **Tiêu đề** (sửa theo quy_chuan: tiêu đề mẫu w3, w4, o3, o4 dài 11–13 tiếng): ngắn, **≤ 13 tiếng**. Câu Tối ưu được nêu ràng buộc trong tiêu đề ("… chỉ với một lần quét", "… không dùng tự nối bảng") như mẫu o1, o4; các loại khác không nhắc kỹ thuật SQL ở tiêu đề (quy ước bổ sung). Bối cảnh không nhắc tên kỹ thuật SQL (CHOT-FORMAT mục 3).
- **Riêng aivb:** G.1 ở trên dẫn G.4, G.5 của STYLE-scm theo bản sửa theo quy_chuan lúc 10/11, 23:05 ("Đúng: " ở phương án đúng, phương án sai không tiền tố; nấc cuối được nêu trọn biểu thức một dòng). aivb-f7 chấm lại cấp theo dòng **Cấp** (bỏ ngoại lệ M8). ERD gói 1 (R4, R5, R6, R9, N3, N4, N5, N6, N8, N9, cấp Dễ) giữ đúng 1 bảng nhiễu. aivb-k6 hạ Trung bình.

## H. Quyết định v3 của bộ aivb (10/11/2026, gói 1–3)

- **'ACTIVE' của khoản vay** = "đang trả nợ bình thường" (sửa A.4; khớp khái niệm `trang-thai-khoan-vay`).
- **Phân khúc**: dùng đúng `ref_segment.segment_name`: 'MASS' đại chúng, 'UPPER_MASS' khá giả, 'AFFLUENT' giàu có, 'PRIORITY' ưu tiên (sửa A.1).
- **Kênh**: "kênh số" (MOBILE, WEB, QR, API) và "kênh vật lý" (quầy, ATM, POS); lần đầu trong câu giải nghĩa "quầy, ATM, POS".
- **Thấu chi**: `principal` của 'OD_IND', 'OD_BIZ' là hạn mức thấu chi (Parameter Book sheet 08.Lending: revolving, hạn mức bằng 3 lần lương), không phải số đã rút.
- **Chi nhánh** (khái niệm `chi-nhanh`, chép giống hệt ở mọi gói): "Chi nhánh là đơn vị phụ thuộc của ngân hàng, hạch toán phụ thuộc, thực hiện một phần nghiệp vụ của ngân hàng và quản lý khách hàng, hợp đồng trên một địa bàn." Căn cứ Thông tư 32/2024/TT-NHNN (mạng lưới hoạt động của NHTM), Điều 3.
- **Tên nhân vật cố định**: mỗi vai đúng một tên, mỗi tên đúng một vai, dùng chung cho cả 5 gói (khớp bảng ở `goi-cau-hoi/aivb/QUYET-DINH-126-g45.md`). Đổi tên khác giới thì đổi cả đại từ trong lời nhắn.

| Vai | Tên |
|---|---|
| Trưởng phòng quản lý rủi ro tín dụng | Chị Lan |
| Giám đốc khối nguồn vốn | Anh Minh |
| Trưởng phòng phát triển sản phẩm | Chị Hạnh |
| Chuyên viên thẩm định tín dụng | Anh Hải |
| Trưởng phòng vận hành thanh toán | Anh Quang |
| Trưởng phòng khách hàng cá nhân | Chị Ngân |
| Trưởng phòng khách hàng doanh nghiệp | Anh Tuấn |
| Chuyên viên quan hệ khách hàng | Anh Bảo |
| Chuyên viên tuân thủ (KYC) | Chị Mai |
| Kế toán giao dịch | Anh Khánh |
| Giám đốc chi nhánh | Anh Hưng |
| Chuyên viên xử lý nợ | Anh Tâm |
| Data engineer (câu Tối ưu) | Anh Sơn |
| Thực tập sinh (Sửa lỗi cấp thấp) | Bạn Vy |
| Giám đốc khối bán lẻ / Giám đốc khối vận hành | Anh Phong / Anh Quân |
