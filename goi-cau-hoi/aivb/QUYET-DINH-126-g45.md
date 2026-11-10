# Quyết định 126 · aivb gói 4, 5 (10/11/2026)

Phạm vi: các điểm "Chờ giảng viên" của aivb gói 4, 5 trong `BAO-CAO-TONG-HOP.md` mục 3 (gói 1–3 do agent khác làm, xem `QUYET-DINH-126.md` của agent đó). Chi tiết từng điểm (căn cứ, việc đã sửa) ở mục "Quyết định v3 (10/11)" của `ho-so/goi-4/DA-SUA.md`, `ho-so/goi-5/DA-SUA.md`.

Nguồn domain:
- PB: `H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\Finance\05_eDA_parameter_book_mini_core_banking_v5.1.5.xlsx` (mục 4 vòng đời khoản vay, mục 5 vai chủ thể – tài khoản, mục 6B bút toán nguyên tử).
- `...\Finance\Bang_phan_loai_datamart_va_data_dictionary_AIVBank_v5.1.6.3.xlsx` (tên bảng, cột); `...\Finance\Tra_loi_18_mau_thuan_20260804.docx` (câu 8: xếp hạng rủi ro theo giá trị dư nợ là chuẩn ngành).
- `...\Finnance_Accounting\` chỉ có Blueprint ngân sách – thực hiện, không dùng cho điểm nào ở đây.
- Pháp quy: TT31/2024/TT-NHNN Điều 10 (https://baolamdong.vn/can-cu-phan-loai-nhom-no-doi-voi-khoan-vay-da-co-cau-419186.html); NĐ 86/2024/NĐ-CP (https://luatvietnam.vn/tai-chinh/nghi-dinh-86-2024-nd-cp-phuong-phap-trich-lap-du-phong-rui-ro-cua-to-chuc-tin-dung-359985-d1.html); TT17/2024/TT-NHNN (https://thuvienphapluat.vn/van-ban/Tien-te-Ngan-hang/Circular-17-2024-TT-NHNN-on-opening-checking-accounts-at-payment-service-providers-616720.aspx); Luật Kế toán 2015 Điều 41, NĐ 174/2016/NĐ-CP Điều 12–13 (https://caselaw.vn/van-ban-phap-luat/116303-nghi-dinh-174-2016-nd-cp-huong-dan-luat-ke-toan); TT49/2014/TT-NHNN mẫu B03/TCTD (chỉ tiêu thu nhập lãi thuần).
- Số liệu kiểm bằng truy vấn chỉ đọc trên `aivb` (MySQL `sqllb-mysql`).

## Bảng điểm

| # | Mục BAO-CAO | Mã | Điểm | Trạng thái | Quyết định (căn cứ ngắn) |
|---|---|---|---|---|---|
| 1 | 3.2 | aivb-c10 (g5) | Loại bút toán lệnh REVERSED, REJECTED khỏi dòng tiền ròng | Đã sửa (ghi chú, khái niệm) | Xác nhận loại: PB 6B có bút toán đối ứng cho lệnh bị đảo, bị từ chối; dữ liệu chỉ giữ bút toán gốc |
| 2 | 3.2 | aivb-c7 (g4) | Đo theo giá trị hay số lệnh; ATM, POS | Giữ nguyên (có căn cứ) + ghi chú | Theo số lệnh tỷ trọng kênh số 71,5–72,1%, kết luận không đổi; API 11–14% giá trị; "kênh vật lý" = quầy, ATM, POS |
| 3 | 3.3 | aivb-t9 (g4) | Khoản cơ cấu lại, xử lý rủi ro còn kỳ quá hạn | Đã sửa (`\luuy`, ghi chú) | Giữ khung; TT31/2024 Điều 10 khoản 4 điểm d, NĐ 86/2024 |
| 4 | 3.3 | aivb-f6 (g4) | Số dư tài khoản chung tính cho chủ tài khoản | Giữ nguyên (có căn cứ) | PB mục 5, TT17/2024; tài khoản chung chỉ 2,5% số dư |
| 5 | 3.3 | aivb-t1 (g4) | Bước "đã tất toán" | Giữ nguyên (có căn cứ) + ghi chú | PB: vòng đời khoản vay kết thúc ở SETTLED |
| 6 | 3.3 | aivb-t2 (g4) | Lệch loại 2, câu bổ sung `giao-dich-bi-dao` | Đã sửa (STYLE-aivb E, gói 5) | Duyệt; PB 6B `POST.REVERSAL.1`, `POST.REJECT.1` |
| 7 | 3.3 | aivb-t6 (g4) | Chênh lệch hay tỷ lệ | Giữ nguyên (có căn cứ) + ghi chú | "Thu nhập lãi thuần" trên báo cáo kết quả kinh doanh TCTD là chênh lệch bằng tiền |
| 8 | 3.3 | aivb-f5 (g4) | Cohort 2018, 2019 bị cắt | Giữ nguyên (có căn cứ) | `\luuy` v2 đã nêu; hồ sơ từ 2019-12-15; bỏ cohort làm sai mẫu số |
| 9 | 3.3 | aivb-k5 (g5) | Diễn giải bảng đối chiếu | Đã sửa (`\luuy`, ghi chú) | Xác nhận: cơ cấu lại hết quá hạn là bình thường; xử lý rủi ro ngoại bảng, nghĩa vụ còn |
| 10 | 3.3 | aivb-k2 (g5) | Kho báo cáo chỉ giữ năm hiện hành | Đã sửa (`\luuy`) | Giữ; Luật Kế toán 2015 Điều 41: chứng từ năm trước vẫn lưu trữ, chỉ không có trong kho báo cáo |
| 11 | 3.3 | aivb-k4 (g5) | Tỉnh cư trú hay chi nhánh | Đã sửa (bối cảnh) | Giữ theo tỉnh; quyết định đổi thành "ưu tiên tỉnh nào", không "giao chỉ tiêu" cho tỉnh |
| 12 | 3.4 | aivb-f7 (g4) | Hạ Dễ? | Đã sửa (hạ Dễ, sửa lúc 23:20) | QUYET-DINH-CHUNG 0.1 mục 5 (theo quy_chuan, bỏ ngoại lệ "M8 không có Dễ"): một lỗi logic một chỗ là Sửa lỗi Dễ; ERD 2 bảng có chữ trên đường nối; BAN-DO cập nhật |
| 13 | 3.4 | aivb-k6 (g5) | Cấp Khó | Đã sửa (hạ Trung bình) | QUYET-DINH-CHUNG 2.3 mục 4; ERD 3 bảng có ký hiệu; BAN-DO cập nhật (medium 40, hard 16) |
| 14 | 3.6 | aivb-t5 (g4) | Mã có chữ "hoan" | Đã sửa (đổi mã) | → `aivb-t5-kenh-loai-giao-dich-ty-le-bi-dao` |
| 15 | 3.7 | aivb-p9 (g5) | Vai người hỏi | Giữ nguyên (có căn cứ) | Kế toán giao dịch có trong danh sách vai STYLE-aivb B; tên theo bảng dưới |
| 16 | 3.8 | aivb (tên nhân vật), phần gói 4, 5 | Một tên nhiều vai | Đã sửa ở gói 4, 5 | Bảng vai – tên dưới đây; gói 1–3 cần agent kia áp cùng bảng |

## Bảng vai – tên cố định (đề xuất cho cả bộ aivb, đã áp ở gói 4, 5)

Chọn tên đang dùng nhiều nhất cho mỗi vai, mỗi tên chỉ một vai.

| Vai | Tên | Gói 1–3 còn lệch (agent gói 1–3 xử lý) |
|---|---|---|
| Trưởng phòng quản lý rủi ro tín dụng | Chị Lan | g1 Anh Tuấn; g3 Chị Hạnh |
| Giám đốc khối nguồn vốn | Anh Minh | g1 Anh Hải |
| Trưởng phòng phát triển sản phẩm | Chị Hạnh | g1 Chị Thu, Chị Yến; g3 Chị Hoa |
| Chuyên viên thẩm định tín dụng | Anh Hải | g1 Anh Khánh; g2 Anh Quang, Chị Phương; g3 Anh Đức |
| Trưởng phòng vận hành thanh toán | Anh Quang | g1 Anh Phong; g2 Chị Mai; g3 Anh Hải |
| Trưởng phòng khách hàng cá nhân | Chị Ngân | g1 Chị Trang; g2 Chị Phương |
| Trưởng phòng khách hàng doanh nghiệp | Anh Tuấn | g1 Chị Ngọc |
| Chuyên viên quan hệ khách hàng | Anh Bảo | g1 Anh Khoa |
| Chuyên viên tuân thủ (KYC) | Chị Mai | g1 Anh Sơn; g2 Chị Thu |
| Kế toán giao dịch | Anh Khánh | g1 Chị Oanh; g3 Chị Thu |
| Giám đốc chi nhánh | Anh Hưng | g1 Chị Hoa; g2 Anh Hùng |
| Chuyên viên xử lý nợ | Anh Tâm | g1 Chị Dung; g2 Anh Đức; g3 Anh Tùng |
| Data engineer (câu Tối ưu) | Anh Sơn | – |
| Thực tập sinh (Sửa lỗi cấp thấp) | Bạn Vy | g1 Bạn Long, Bạn Nam; g2 Bạn Khoa, Bạn Nhi; g3 Bạn Khoa, Bạn Thảo |
| Giám đốc khối bán lẻ / khối vận hành (chỉ g3) | Anh Phong / Anh Quân | – |

Đổi tên khác giới thì đổi cả đại từ trong bối cảnh (đã làm ở g4 t1, t3, f9; g5 k4, k7, p2, p4, p6, p9).

## Không có yêu cầu dòng ẩn

Không điểm nào của gói 4, 5 cần thêm dòng vào `04_bo_sung_bien_the_aivb.sql`; không ghi `YEU-CAU-04.md`.

## Quy ước chung đã áp ở gói 4, 5 (QUYET-DINH-CHUNG bản 23:05, theo quy_chuan)

- 1.1 kết luận case: c7, c8, c9, c10 đổi "Đúng. " → "Đúng: ", bỏ "Chưa đúng. " ở phương án sai.
- 1.3 ERD Khó: k3, k5 (lời giải 2 bảng, 3 bảng nhiễu, chỉ khoá, `\erdkhoa`) hợp lệ theo mẫu d4; không sửa.
- 2.3 / 0.1 mục 5: k6 hạ Trung bình, f7 hạ Dễ. Thống kê BAN-DO sau gói 4–5: basic 14 · easy 31 · medium 39 · hard 16.

Bảng thống kê cấp trong BAN-DO chỉ tính thay đổi của gói 4, 5; agent gói 1–3 đổi cấp thì cộng tiếp.
