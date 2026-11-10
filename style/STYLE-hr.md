# Bộ chuẩn giọng văn và thuật ngữ · câu hỏi SQL Leaderboard trên bộ dữ liệu HR Analytics

Bản nháp 1 · 10/11/2026 · chờ giảng viên duyệt.

Áp dụng cho mọi phần chữ của một câu trong `cau-hoi.tex` thuộc bộ HR Analytics (quản trị nhân lực, database MySQL `hr`):
`\tieude`, `\boicanh`, `yeucau`, `rangbuoc`, `nghiepvu`, `\goiy`, `\phuongan`, `\khaibaokhainiem`, `\ghichuthietke`.
Cú pháp LaTeX và cách chấm theo `quy_chuan/goi-cau-hoi-mau/HUONG_DAN.md`; cấu trúc bảng, bẫy dữ liệu theo `mysql/README-hr.md`.

Thứ tự ưu tiên khi các nguồn mâu thuẫn:
1. Quyết định của giảng viên ở `STYLE-GUIDE-luyen-sql.md` mục H và `STYLE-scm.md` mục G (kế thừa A, C, D của SG).
2. Văn bản pháp quy: Bộ luật Lao động 2019 và Nghị định 145/2020/NĐ-CP. Từ nào luật đã định nghĩa (người lao động, làm thêm giờ, nghỉ hằng năm, đơn phương chấm dứt hợp đồng lao động…) thì **dùng đúng chữ của luật**.
3. Giáo trình đại học ngành quản trị nhân lực (NEU, ĐH Lao động – Xã hội, UEH) và bài tạp chí khoa học tiếng Việt.
4. Tài liệu của chính dự án: `data_dictionary.md`, `CHANGELOG_data_fixes.md`, `HR_Insight.pdf` (tên cột, cách tính, điểm nóng). Dự án viết bằng tiếng Anh, nên dự án quyết định **nghĩa** của cột, còn chữ tiếng Việt lấy theo nguồn 2–3.
5. Nguồn phổ thông (blog tuyển dụng, phần mềm nhân sự): chỉ khi bốn nguồn trên không có, ghi rõ.

---

## 0. Nguồn và mã viết tắt

Chú thích trạng thái: **mở** = đã mở trang và đọc nội dung; **TK** = chỉ thấy trong kết quả tìm kiếm (trang chặn công cụ hoặc trả rỗng).

| Mã | Tài liệu | Trạng thái |
|---|---|---|
| BLLĐ | Bộ luật Lao động số 45/2019/QH14 (hiệu lực 01/01/2021), toàn văn tại VCCI: https://vanban.vcci.com.vn/bo-luat-lao-dong-2019. Điều đã đối chiếu: 3 (giải thích từ ngữ), 13 (hợp đồng lao động), 20 (loại hợp đồng), 24–25, 27 (thử việc), 34–36 (chấm dứt, đơn phương chấm dứt), 90 (tiền lương), 93 (thang lương, bảng lương), 98 (tiền lương làm thêm giờ), 104 (thưởng), 105 (thời giờ làm việc bình thường), 107 (làm thêm giờ), 113 (nghỉ hằng năm), 124–125 (kỷ luật, sa thải), 169 (tuổi nghỉ hưu) | mở |
| NĐ145 | Nghị định 145/2020/NĐ-CP hướng dẫn BLLĐ về điều kiện lao động và quan hệ lao động: https://vanban.vcci.com.vn/nghi-dinh-1452020nd-cp-huong-dan-bo-luat-lao-dong-ve-dieu-kien-lao-dong-va-quan-he-lao-dong (Điều 55 tiền lương làm thêm giờ, 59–62 làm thêm giờ, 65–66 nghỉ hằng năm). Đang có dự thảo sửa đổi 2026, kiểm lại trước khi trích | mở |
| NEU | Giáo trình Quản trị nhân lực, Nguyễn Vân Điềm, Nguyễn Ngọc Quân (đồng chủ biên), NXB ĐH Kinh tế Quốc dân. Bản ghi thư viện: https://tailieuso.tnut.edu.vn/handle/123456789/1291 ; https://dspace.ctu.edu.vn/jspui/handle/123456789/87588 . Chương: kế hoạch hoá nguồn nhân lực, tuyển mộ – tuyển chọn, đánh giá thực hiện công việc, thù lao và phúc lợi, quan hệ lao động | TK (chỉ metadata, không có toàn văn) |
| UEH | Quản trị nguồn nhân lực, Trần Kim Dung, tái bản lần 8, NXB Tổng hợp TP.HCM, 2011, 497 tr. https://elib.vku.udn.vn/handle/123456789/2852?mode=full | mở (metadata) |
| ULSA | Giáo trình Tiền lương – Tiền công, Quản trị nhân lực của ĐH Lao động – Xã hội: **không tìm được bản trực tuyến**; một bản ghi NXB Lao động – Xã hội chưa rõ tác giả: https://lib.hpu.edu.vn/jspui/handle/123456789/36620 | TK |
| TCCT | Trịnh Việt Tiến, "Nhận diện hoạt động đánh giá thực hiện công việc trong công tác quản trị nhân lực của tổ chức", Tạp chí Công Thương, 06/07/2018: https://tapchicongthuong.vn/nhan-dien-hoat-dong-danh-gia-thuc-hien-cong-viec-trong-cong-tac-quan-tri-nhan-luc-cua-to-chuc-29006.htm | mở |
| GK | Bài về gắn kết của nhân viên, Tạp chí Phát triển KH&CN – Kinh tế, Luật và Quản lý (ĐHQG-HCM): https://stdjelm.scienceandtechnology.com.vn/index.php/stdjelm/article/download/662/1088 ; https://www.quanlynhanuoc.vn/2024/11/21/tang-cuong-gan-ket-cong-viec-cho-vien-chuc-va-nguoi-lao-dong-tai-cac-co-so-giao-duc-dai-hoc/ | TK |
| THNTD | Thương hiệu nhà tuyển dụng, Tạp chí Khoa học ĐHQGHN (Quản lý và Kinh tế): https://js.vnu.edu.vn/PaM/article/view/4411/4014 | TK |
| PT | Nguồn phổ thông (chỉ khi các nguồn trên không có): tỷ lệ nghỉ việc https://www.vietnamworks.com/hrinsider/turnover-rate-la-gi.html ; eNPS https://www.careerlink.vn/cam-nang-viec-lam/tu-van-nghe-nghiep/enps-la-gi ; ma trận 9 ô https://amis.misa.vn/79224/mo-hinh-ma-tran-9-box-grid/ ; định biên https://www.cake.me/resources/people-operations/dinh-bien-nhan-su-la-gi ; time to fill https://www.careerlink.vn/cam-nang-viec-lam/tu-van-nghe-nghiep/time-to-hire-la-gi ; vắng mặt https://www.careerlink.vn/cam-nang-viec-lam/kien-thuc-kinh-te/absenteeism-la-gi-va-thuong-gap-trong-nhung-truong-hop-nao ; compa-ratio (tiếng Anh) https://gusto.com/resources/glossary/compa-ratio | TK |
| DD | Dự án: `data/data_dictionary.md` (Revision 3), `data/CHANGELOG_data_fixes.md` (Revision 4) | đọc trực tiếp |
| DB | Database MySQL `hr`, kiểm ngày 10/11/2026 (`mysql/README-hr.md`) | đọc trực tiếp |

Không tìm được nguồn tiếng Việt kiểm được (dùng từ đề xuất, chờ giảng viên duyệt, xem mục F): compa-ratio, lương thị trường P50/P75, contractor, làm việc kết hợp, tuyển thay thế (backfill), vị trí then chốt, phỏng vấn thôi việc.

---

## A. Bảng thuật ngữ

Quy ước (kế thừa STYLE-scm A):
- Cột "Dùng trong đề" là đúng chữ cần viết. Thuật ngữ giữ tiếng Anh thì giải nghĩa tiếng Việt ở lần đầu trong mỗi câu: "compa-ratio (tỷ số lương trên mức thị trường)".
- Tên bảng, cột trong `\code{}`; giá trị chuỗi giữ **đúng tiếng Anh của DB**: `\code{'Voluntary'}`, `\code{'Customer Support'}`, `\code{'Vietnam'}`.
- Tên cột kết quả (alias) tiếng Việt không dấu theo cột "Dùng": `so_nguoi_nghi`, `ty_le_nghi_viec_pct`, `luong_bq`, `gio_lam_them`, `so_ngay_tuyen_bq`.
- Ngữ cảnh pháp lý (yêu cầu, tab Nghiệp vụ khi nhắc luật) dùng "người lao động", "người sử dụng lao động"; lời nhắn công sở (`\boicanh`) được nói "nhân viên", "công ty mình".

### A.1 Tổ chức, nhân sự, hợp đồng

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| employee (`employee_id`) | nhân viên; người lao động (khi nói theo luật) | nhân sự (chỉ một người), staff, ứng viên | BLLĐ Điều 3: "người lao động" | BLLĐ; DB |
| employer | công ty; người sử dụng lao động (ngữ cảnh luật) | chủ, sếp tổng | BLLĐ Điều 3 | BLLĐ |
| headcount (đếm người) | quân số; số nhân viên | headcount trong văn, "đầu người" | "quân số đầu kỳ / cuối kỳ / bình quân" | DD; DB |
| `employee_monthly_snapshot` | ảnh chụp nhân sự theo tháng; dòng nhân viên – tháng | bảng snapshot trong văn | một dòng = một nhân viên trong một tháng còn có tên | DD |
| `snapshot_month` | tháng (kỳ) dữ liệu; "tháng 12/2025", "kỳ 2025-12" | | chuỗi `'YYYY-MM'` | DB |
| `department` | phòng ban (khối) | bộ phận | giá trị: Engineering, Sales, Operations, Finance, HR, Customer Support | DD |
| `job_family`, `job_role` | nhóm chức danh; chức danh | job family trong văn, nghề | hai cột trùng nhau; bảng khác chỉ có `job_role` | DD |
| `job_level` (L1–L7) | bậc (bậc L1 … L7) | cấp bậc lương, level | bậc là thang 7 nấc của khung chức danh; L1 thấp nhất | DD; BLLĐ Điều 93 (thang lương) |
| `position_id`, `positions` | vị trí (một bộ nước – phòng ban – nhóm chức danh – bậc) | ghế, slot, seat | | DD |
| `manager_id` | quản lý trực tiếp | sếp, line manager trong văn | giá trị là `employee_id` của người quản lý | DD |
| `country`, `city` | nước; thành phố (nơi làm việc) | quốc gia sở tại, chi nhánh | giá trị tiếng Anh: 'Vietnam', 'Ho Chi Minh City' | DB |
| `employment_type` = 'Permanent' | nhân viên chính thức | nhân viên cơ hữu, biên chế | BLLĐ Điều 20 chỉ có HĐLĐ xác định / không xác định thời hạn; dữ liệu không ghi loại HĐLĐ | BLLĐ; DD |
| `employment_type` = 'Contractor' | nhân viên hợp đồng ngắn hạn (contractor) | lao động thời vụ, hợp đồng mùa vụ | BLLĐ 2019 đã bỏ "hợp đồng mùa vụ" | BLLĐ Điều 20; DD |
| labour contract | hợp đồng lao động (HĐLĐ) | hợp đồng làm việc | | BLLĐ Điều 13 |
| probation | thử việc; thời gian thử việc | probation | dữ liệu không có cột thử việc; chỉ dùng khi nói chung | BLLĐ Điều 24–25 |
| `work_model` | hình thức làm việc: tại văn phòng ('Office'), kết hợp ('Hybrid'), từ xa ('Remote') | WFH, onsite | | DD |
| `age`, `age_band` | tuổi; nhóm tuổi (18-24 … 55-65) | độ tuổi băng | | DD |
| `gender` | giới tính: nam, nữ, không công bố ('Non-disclosed') | giới khác, không xác định | nhóm thứ ba là giá trị hợp lệ, không phải lỗi | DD; CHANGELOG M2 |
| `tenure_months` | thâm niên (tháng) | tuổi nghề, số năm công tác | thâm niên tại công ty, 0 ở tháng đầu tiên | DD |
| new hire | nhân viên mới (tuyển mới) | người mới onboard | nhận biết bằng `tenure_months = 0` | DB |
| org chart; hierarchy | sơ đồ tổ chức; cây quản lý; tuyến báo cáo | org chart trong văn | | DD |
| span of control | số cấp dưới trực tiếp | tầm hạn quản trị | | NEU (khái niệm chung) |

### A.2 Thời giờ làm việc, vắng mặt, đào tạo (mảng `operations`)

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| normal working hours | thời giờ làm việc bình thường | giờ hành chính | không quá 8 giờ/ngày, 48 giờ/tuần | BLLĐ Điều 105 |
| overtime (`overtime_hours`) | làm thêm giờ; giờ làm thêm (giờ/tháng) | tăng ca, OT | | BLLĐ Điều 107 |
| overtime cap | giới hạn làm thêm giờ: không quá 40 giờ/tháng, 200 giờ/năm (trường hợp đặc biệt 300 giờ/năm) | trần OT | trong DB, trần tháng khác theo nước (Malaysia tới 104); chỉ Việt Nam áp 40 giờ | BLLĐ Điều 107; NĐ145 Điều 60–62; DB |
| overtime pay | tiền lương làm thêm giờ (ít nhất 150% ngày thường) | tiền OT | dữ liệu không có cột này; câu ước tính phải ghi rõ giả định | BLLĐ Điều 98; NĐ145 Điều 55 |
| absence (`absence_days`) | số ngày vắng mặt (trong tháng) | nghỉ phép (khi không rõ loại), absenteeism | dữ liệu không tách nghỉ có phép / không phép | DD; PT |
| absenteeism rate | tỷ lệ vắng mặt | tỷ lệ nghỉ | công thức ghi trong yêu cầu từng câu | PT |
| annual leave | nghỉ hằng năm | nghỉ phép năm | 12/14/16 ngày làm việc | BLLĐ Điều 113 |
| training (`training_hours_6m`) | giờ đào tạo trong 6 tháng gần nhất | giờ training | | DD; NEU (đào tạo và phát triển) |
| business travel (`business_travel_days`) | số ngày công tác (trong tháng) | đi tour, travel | | DD |
| workforce planning | kế hoạch hoá nguồn nhân lực; định biên | hoạch định headcount | "định biên" dùng cho số người được duyệt cho một vị trí | NEU; PT |
| `planned_headcount` | định biên (số người kế hoạch) | quân số mục tiêu | | DD |
| `actual_headcount` | quân số thực tế (tháng 12 của năm kế hoạch) | | đếm cả người nghỉ trong tháng 12 (README-hr) | DD; DB |
| `vacancy_count` | số chỗ trống (định biên − quân số thực tế) | vị trí khuyết, lỗ hổng nhân sự | | DD |
| `critical_role_flag` | vị trí then chốt (bậc L4 trở lên) | vị trí trọng yếu, key role | | DD |
| `backfill_allowed` | được tuyển thay thế ('Yes') / đóng băng tuyển thay thế ('No') | backfill trong văn | giá trị chuỗi, không phải 0/1 | DD; DB |
| `business_priority` | mức ưu tiên kinh doanh: cao, trung bình, thấp | | | DD |
| `plan_period` | năm kế hoạch | kỳ kế hoạch | 2024, 2025 | DD |

### A.3 Tiền lương, thù lao (mảng `finance`)

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| salary (`monthly_salary_usd`) | tiền lương tháng (USD) | lương cứng, income | BLLĐ: "tiền lương" | BLLĐ Điều 90; DD |
| payroll | quỹ lương (tổng tiền lương tháng) | tổng chi lương nhân viên | | NEU (thù lao) |
| compensation & benefits | thù lao lao động; thù lao và phúc lợi | C&B, đãi ngộ (trong yêu cầu) | NEU dùng "thù lao lao động" | NEU; TCCT |
| pay scale / grid | thang lương, bảng lương | khung lương cứng | | BLLĐ Điều 93 |
| bonus | thưởng | | dữ liệu không có cột thưởng | BLLĐ Điều 104 |
| market salary (`market_salary_p50_usd`, `p75`) | mức lương thị trường trung vị (P50); mức lương thị trường phân vị 75 (P75) | lương benchmark, giá thị trường | lấy từ `country_market_benchmark` cùng năm, nước, chức danh, bậc | DD |
| `compa_ratio` | compa-ratio (tỷ số lương trên mức thị trường trung vị) | hệ số lương, chỉ số cạnh tranh lương | chưa có nguồn tiếng Việt chuẩn; dùng cột có sẵn, không tự tính lại | DD; PT (tiếng Anh) |
| below / above market | thấp hơn / cao hơn mức thị trường | trả hớ, trả dưới giá | | DD |
| promotion | đề bạt (thăng bậc); tăng lương khi đề bạt 8–15% | lên lon, thăng chức (trong yêu cầu) | NEU: "đề bạt"; nhận biết khi `job_level` tăng | NEU; DD |
| merit increase | tăng lương theo kết quả thực hiện công việc (3–6%) | tăng lương định kỳ | | DD |
| `months_since_promotion` | số tháng kể từ lần đề bạt gần nhất | | | DD |
| `internal_move_last_12m` | có đề bạt hoặc thuyên chuyển nội bộ trong 12 tháng | luân chuyển | | DD |
| `hiring_difficulty`, `unemployment_proxy` | mức khó tuyển (số càng lớn càng khó); mức thất nghiệp ước lượng: thấp, trung bình, cao | | | DD |

### A.4 Đánh giá, gắn kết, giữ chân (mảng `customer`)

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| performance appraisal (`performance_rating`) | đánh giá thực hiện công việc; điểm đánh giá thực hiện công việc (1–4, 4 cao nhất) | đánh giá hiệu suất, đánh giá KPI, chấm điểm nhân viên | đánh giá hằng năm | TCCT; NEU; DD |
| high performer (`high_performer_flag`) | nhân viên có kết quả thực hiện công việc cao (cờ = 1) | nhân tài, ngôi sao | cờ có thể = 1 khi điểm đánh giá trống | DD; DB |
| potential (`potential_rating`) | tiềm năng: cao, trung bình, thấp | | | DD |
| 9-box grid | ma trận 9 ô (kết quả × tiềm năng) | | | PT |
| employee engagement (`engagement_score`) | mức độ gắn kết (điểm gắn kết, 0–100) | độ hài lòng (khác khái niệm), engagement | phân biệt "gắn kết công việc" và "gắn bó với tổ chức" | GK; DD |
| `engagement_survey`, `survey_quarter` | khảo sát gắn kết theo quý; quý khảo sát ('2025-Q3') | pulse survey trong văn | | DD |
| `manager_trust_score` | điểm tin tưởng quản lý trực tiếp | | | DD |
| `manager_effectiveness_score` | điểm năng lực quản lý của quản lý trực tiếp | toxic zone, vùng độc hại | | DD |
| `workload_score`, `career_growth_score` | điểm hài lòng về khối lượng công việc; điểm hài lòng về cơ hội phát triển | | | DD |
| eNPS | eNPS (chỉ số nhân viên sẵn sàng giới thiệu công ty) = % người ủng hộ (9–10) − % người phản đối (0–6) | | thang −100 … +100 | PT; DD |
| `intent_to_stay` | ý định ở lại (thang 1–5) | | | DD |
| retention | giữ chân nhân viên; tỷ lệ giữ chân | retention trong văn | | PT |
| cohort | nhóm nhân viên vào cùng tháng / quý (cohort) | khoá tuyển | | QC |
| stagnation | chững lại về nghề nghiệp (lâu không được đề bạt) | đóng băng sự nghiệp | | DD |

### A.5 Tuyển dụng, thương hiệu nhà tuyển dụng (mảng `marketing`)

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| recruitment | tuyển dụng (gồm tuyển mộ và tuyển chọn) | săn người | NEU tách tuyển mộ / tuyển chọn | NEU |
| requisition (`requisition_id`) | yêu cầu tuyển dụng | phiếu đề xuất, job req | | DD |
| `requisition_type` = 'Backfill' | tuyển thay thế (cho người đã nghỉ) | backfill trong văn | `vacated_employee_id` là người đã nghỉ | DD |
| `requisition_type` = 'New headcount' | tuyển mới theo định biên tăng thêm | mở rộng headcount | | DD |
| `recruitment_source` | nguồn tuyển dụng (kênh tuyển) | kênh săn đầu người | giá trị giữ tiếng Anh: 'LinkedIn', 'Employee Referral' | DD |
| employee referral | giới thiệu nội bộ (nhân viên giới thiệu) | referral trong văn | | DD |
| `approval_date` | ngày duyệt yêu cầu tuyển dụng | | | DD |
| time to fill (`time_to_fill_days`) | thời gian tuyển (ngày, từ ngày duyệt tới ngày ứng viên nhận lời) | time-to-hire, thời gian lấp chỗ | `offer_accept_date = approval_date + time_to_fill_days` (khớp 100%) | DD; DB; PT |
| `offer_accept_date` | ngày nhận lời mời làm việc | ngày chốt offer | | DD |
| `start_date` | ngày bắt đầu làm việc | ngày onboard | có ngày sau 2025-12 | DD; DB |
| `recruiting_cost_usd` | chi phí tuyển dụng (USD mỗi yêu cầu) | cost per hire trong văn | | DD |
| employer branding | thương hiệu nhà tuyển dụng | thương hiệu tuyển dụng | | THNTD |
| candidate | ứng viên | — | SG cấm "ứng viên" theo nghĩa "phương án"; ở bộ HR chỉ dùng đúng nghĩa người dự tuyển | SG C.2 (ngoại lệ, xem F) |

### A.6 Nghỉ việc, thôi việc (mảng `after_sales`)

| Tiếng Anh / tên cột | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| attrition (`attrition_this_month`) | nghỉ việc; người nghỉ việc trong tháng | rời công ty, nhảy việc, churn | dòng của tháng nghỉ vẫn có trong bảng | DD; DB |
| turnover rate | tỷ lệ nghỉ việc = số người nghỉ / quân số bình quân trong kỳ | tỷ lệ churn, tỷ lệ biến động (khi không định nghĩa) | quy năm khi kỳ khác 12 tháng | PT; DD |
| `attrition_type` = 'Voluntary' | nghỉ việc tự nguyện (người lao động đơn phương chấm dứt hoặc xin nghỉ) | nghỉ ngang | | BLLĐ Điều 35; DD |
| `attrition_type` = 'Involuntary' | chấm dứt hợp đồng do người sử dụng lao động (không tự nguyện) | bị đuổi, sa thải (trừ khi là kỷ luật sa thải) | lý do trong DB luôn 'Performance' | BLLĐ Điều 36, 125; DD |
| `attrition_type` = 'Retirement' | nghỉ hưu | về vườn | | BLLĐ Điều 169 |
| `attrition_reason` | lý do nghỉ việc: lương ('Compensation'), phát triển nghề nghiệp ('Career Growth'), cân bằng công việc – cuộc sống ('Work-Life Balance'), quan hệ với quản lý ('Manager Relationship'), cá nhân ('Personal'), chuyển nơi ở ('Relocation'), kết quả công việc ('Performance'), nghỉ hưu ('Retirement') | | | DD |
| exit interview | phỏng vấn thôi việc | exit talk | lý do nghỉ là kết quả phỏng vấn thôi việc (giả định của bộ) | DD |
| `attrition_next_3m`, `_6m` | nghỉ việc trong 3 (6) tháng tới (biến mục tiêu) | nhãn y, target | chỉ dùng câu dự báo; tính cả nghỉ hưu | DD |
| hotspot | điểm nóng nghỉ việc (nước × phòng ban có tỷ lệ cao) | vùng đỏ | Philippines·Customer Support, Indonesia·Sales, Vietnam·Engineering | DD |
| survivor bias | thiên lệch người ở lại | | so điểm gắn kết người còn làm với người đã nghỉ | DD |

### A.7 Dữ liệu, SQL, thống kê

Kế thừa nguyên STYLE-scm A.4, A.5 (truy vấn, nối bảng, nhân dòng khi nối (fan-out), truy vấn con, CTE, hàm cửa sổ, xếp hạng,
luỹ kế, chỉ mục, lần quét bảng, phân vị, điểm phần trăm). Bổ sung:

| Tiếng Anh | Dùng trong đề | Không dùng | Ghi chú | Nguồn |
|---|---|---|---|---|
| recursive CTE | CTE đệ quy (duyệt cây quản lý) | truy vấn lặp | phải chặn độ sâu hoặc giữ đường đi vì cây có chu trình | DB |
| cycle (in hierarchy) | báo cáo vòng (A quản lý B, B quản lý A) | vòng lặp vô tận | | DB |
| missing value | ô trống (NULL); thiếu dữ liệu | dữ liệu rác | NULL ở 6 cột chỉ số là có chủ đích | CHANGELOG D3 |
| orphan key | vị trí không có trong kế hoạch (mồ côi) | | P0107 | CHANGELOG D1 |

---

## B. Giọng văn cho từng phần của câu hỏi

Kế thừa nguyên văn STYLE-scm mục B (B.1–B.7: độ dài tiêu đề ≤ 10 tiếng, bối cảnh 1–2 câu ≤ 35 tiếng, yêu cầu mở bằng động từ,
thứ tự 5 ý, đơn vị và làm tròn trong ngoặc, quy tắc bằng nhau nêu bằng khoá, gợi ý 2 nấc, phương án "Đúng. …").
Riêng cho bộ HR:

1. **Người hỏi** (`\boicanh[Tên · Vai trò]`): Trưởng phòng Nhân sự, Giám đốc Nhân sự (CHRO viết "Giám đốc Nhân sự"),
   Chuyên viên tuyển dụng, Trưởng nhóm tuyển dụng, Chuyên viên tiền lương – phúc lợi (C\&B), Chuyên viên phân tích nhân sự,
   Đối tác nhân sự của khối (HRBP viết "chuyên viên nhân sự phụ trách khối"), Trưởng phòng Kinh doanh, Trưởng nhóm Kỹ thuật,
   Kế toán trưởng, Giám đốc quốc gia; Data engineer cho câu Tối ưu; Thực tập sinh nhân sự cho câu Sửa lỗi cấp thấp.
2. **Tôn trọng con người**: không chế giễu, không gán nhãn ("nhân viên lười", "quản lý độc hại"); nói bằng chỉ số
   ("điểm năng lực quản lý dưới 55"). Câu về giới tính chỉ so sánh có mục đích công bằng lương, nêu rõ nhóm 'Non-disclosed' được loại hay giữ.
3. **Không nêu tên thật**: chỉ dùng `employee_id`. Không bịa họ tên cho nhân viên trong dữ liệu.
4. **Dẫn luật**: chỉ dẫn số điều trong `nghiepvu`/`\luuy` ("giới hạn 40 giờ/tháng theo Bộ luật Lao động 2019, Điều 107"); không trích dài.
5. **Tiền**: "USD", số chấm hàng nghìn ("3.650 USD"); lương là **tiền lương tháng**.
6. **Tháng và quý**: "tháng 12/2025", "quý 3/2025"; giá trị lọc giữ dạng DB (`\code{'2025-12'}`, `\code{'2025-Q3'}`).
   Mọi câu có mốc thời gian phải ghi **cả cận dưới và cận trên** (hidden-1 có dòng '2026-01', '2026-Q1', 2026-01-05).
7. **Định nghĩa người nghỉ**: mỗi câu nói rõ "nghỉ việc" gồm loại nào (tự nguyện / mọi loại kể cả nghỉ hưu).
8. **Quân số**: mỗi câu nói rõ quân số "cuối tháng" (trừ người nghỉ trong tháng) hay "có tên trong tháng" (mọi dòng).

Ví dụ đạt
- `\tieude{Phòng ban nào có tỷ lệ nghỉ việc tự nguyện cao nhất năm 2025?}`
- `\boicanh[Chị Hạnh · Trưởng phòng Nhân sự]{Tuần sau chị họp với ban giám đốc về nghỉ việc. Em xem giúp chị năm 2025 phòng ban nào mất người nhiều nhất so với quân số.}`
- `\boicanh[Anh Quân · Chuyên viên tiền lương – phúc lợi]{Anh đang rà mức lương bậc L5 ở Việt Nam trước kỳ điều chỉnh. Em lọc giúp anh ai đang nhận thấp hơn hẳn mặt bằng thị trường.}`
- `\luuy{Tháng nhân viên nghỉ việc vẫn có một dòng trong bảng. Quân số cuối tháng không tính người đã nghỉ trong tháng đó.}`

---

## C. Khuôn cấm

Kế thừa nguyên STYLE-scm mục C (C.1 cụm cấm, dấu "—", ẩn dụ động từ, danh từ dịch máy, K1–K32).
Bổ sung cho bộ HR:

| # | Khuôn | TRƯỚC | SAU |
|---|---|---|---|
| H1 | Tiếng Anh nhân sự trong văn | "OT của team Sales tăng, cần check engagement và attrition" | "Giờ làm thêm của phòng Kinh doanh tăng; cần xem điểm gắn kết và số người nghỉ việc" |
| H2 | Từ lóng nghỉ việc | "nhảy việc", "nghỉ ngang", "bị đuổi", "về vườn" | "nghỉ việc tự nguyện", "chấm dứt hợp đồng", "nghỉ hưu" |
| H3 | Gán nhãn con người | "quản lý độc hại", "nhân viên lười" | "quản lý có điểm năng lực quản lý dưới 55", "nhân viên vắng mặt trên 5 ngày/tháng" |
| H4 | "nhân sự" chỉ một người | "nhân sự E00123 nghỉ việc" | "nhân viên E00123 nghỉ việc" |
| H5 | Quy nguyên nhân từ dữ liệu mô phỏng | "Lương thấp khiến nhân viên nghỉ" | "Nhóm compa-ratio dưới 0,9 có tỷ lệ nghỉ việc cao hơn" |
| H6 | Lẫn "đánh giá hiệu suất" | "điểm hiệu suất (performance)" | "điểm đánh giá thực hiện công việc" |
| H7 | "tăng ca", "OT" | "giờ tăng ca", "OT tháng" | "giờ làm thêm" |
| H8 | "nghỉ phép năm" | "số ngày nghỉ phép năm" | "số ngày nghỉ hằng năm" (chỉ khi nói luật; dữ liệu chỉ có ngày vắng mặt) |

---

## E. Khái niệm khai báo cho bộ HR

Đã đối chiếu với cột thật của `hr` (10/11/2026). Bảng tóm tắt trước, khối LaTeX để dán sau.

| # | Mã | Tên | Bảng chính | Nguồn |
|---|---|---|---|---|
| 1 | `thang-du-lieu` | Tháng dữ liệu và quân số | `employee_monthly_snapshot` | DD; DB |
| 2 | `quan-so-binh-quan` | Quân số bình quân | `employee_monthly_snapshot` | PT; DD |
| 3 | `nghi-viec` | Nghỉ việc và loại nghỉ việc | `employee_monthly_snapshot` | BLLĐ 35, 36, 169; DD |
| 4 | `ty-le-nghi-viec` | Tỷ lệ nghỉ việc | `employee_monthly_snapshot` | PT; DD |
| 5 | `nhan-vien-moi` | Nhân viên mới | `employee_monthly_snapshot` | DB |
| 6 | `lam-them-gio` | Làm thêm giờ | `employee_monthly_snapshot` | BLLĐ 107 |
| 7 | `ngay-vang-mat` | Số ngày vắng mặt | `employee_monthly_snapshot` | DD; PT |
| 8 | `luong-thang` | Tiền lương tháng và quỹ lương | `employee_monthly_snapshot` | BLLĐ 90 |
| 9 | `compa-ratio` | Compa-ratio | `employee_monthly_snapshot`, `country_market_benchmark` | DD |
| 10 | `luong-thi-truong` | Mức lương thị trường P50, P75 | `country_market_benchmark` | DD |
| 11 | `de-bat` | Đề bạt | `employee_monthly_snapshot` | NEU; DD |
| 12 | `danh-gia-thcv` | Điểm đánh giá thực hiện công việc | `employee_monthly_snapshot` | TCCT; DD |
| 13 | `hieu-suat-cao` | Nhân viên có kết quả thực hiện công việc cao | `employee_monthly_snapshot` | DD; DB |
| 14 | `diem-gan-ket` | Điểm gắn kết | `employee_monthly_snapshot`, `engagement_survey` | GK; DD |
| 15 | `enps` | eNPS | `engagement_survey` | PT |
| 16 | `quan-ly-truc-tiep` | Quản lý trực tiếp và cây quản lý | `employee_monthly_snapshot` | DD; DB |
| 17 | `dinh-bien` | Định biên và chỗ trống | `position_plan` | NEU; DD |
| 18 | `vi-tri-then-chot` | Vị trí then chốt | `position_plan` | DD |
| 19 | `yeu-cau-tuyen-dung` | Yêu cầu tuyển dụng, tuyển thay thế | `recruiting_pipeline` | DD |
| 20 | `thoi-gian-tuyen` | Thời gian tuyển (time to fill) | `recruiting_pipeline` | PT; DD |
| 21 | `chi-phi-tuyen-dung` | Chi phí tuyển dụng | `recruiting_pipeline` | DD |
| 22 | `diem-nong-nghi-viec` | Điểm nóng nghỉ việc | `employee_monthly_snapshot` | DD |

```latex
% ---------------------------------------------------------------- khái niệm · HR Analytics
% \khaibaokhainiem{ma}{Tên}{Định nghĩa}{Công thức}{Trong bộ dữ liệu}

\khaibaokhainiem{thang-du-lieu}{Tháng dữ liệu và quân số}
  {Mỗi tháng dữ liệu ghi một ảnh chụp danh sách nhân viên. Quân số cuối tháng là số nhân viên còn làm việc vào ngày cuối tháng.}
  {quân số cuối tháng = số dòng của tháng - số người nghỉ trong tháng}
  {\code{employee_monthly_snapshot}: một dòng là một nhân viên trong một tháng; \code{snapshot_month} dạng chuỗi \code{'2025-12'}, từ \code{'2024-01'} tới \code{'2025-12'}. Tháng nhân viên nghỉ việc vẫn có dòng, với \code{attrition_this_month} = 1.}
\khaibaokhainiem{quan-so-binh-quan}{Quân số bình quân}
  {Quân số bình quân là số nhân viên trung bình của các tháng trong kỳ, dùng làm mẫu số cho các tỷ lệ theo đầu người.}
  {tổng số dòng các tháng trong kỳ / số tháng}
  {đếm dòng của \code{employee_monthly_snapshot} theo \code{snapshot_month}; câu hỏi ghi rõ có trừ người nghỉ trong tháng hay không.}
\khaibaokhainiem{nghi-viec}{Nghỉ việc và loại nghỉ việc}
  {Nghỉ việc là việc chấm dứt quan hệ lao động giữa nhân viên và công ty. Nghỉ việc tự nguyện do người lao động chủ động; nghỉ không tự nguyện do người sử dụng lao động chấm dứt hợp đồng; nghỉ hưu do đủ tuổi.}
  {}
  {\code{attrition_this_month} = 1 ở tháng nghỉ; \code{attrition_type}: \code{'Voluntary'}, \code{'Involuntary'}, \code{'Retirement'}; \code{attrition_reason} là lý do. Hai cột này trống (NULL) ở mọi tháng khác.}
\khaibaokhainiem{ty-le-nghi-viec}{Tỷ lệ nghỉ việc}
  {Tỷ lệ nghỉ việc là phần nhân viên nghỉ việc trong kỳ so với quân số bình quân của kỳ.}
  {số người nghỉ việc trong kỳ / quân số bình quân của kỳ}
  {người nghỉ đếm bằng \code{attrition_this_month} = 1; câu hỏi ghi rõ loại nghỉ việc được tính và có quy năm hay không.}
\khaibaokhainiem{nhan-vien-moi}{Nhân viên mới}
  {Nhân viên mới là người bắt đầu làm việc tại công ty trong kỳ đang xét.}
  {}
  {dòng đầu tiên của nhân viên có \code{tenure_months} = 0; người có mặt từ \code{'2024-01'} không phải nhân viên mới.}
\khaibaokhainiem{lam-them-gio}{Làm thêm giờ}
  {Làm thêm giờ là khoảng thời gian làm việc ngoài thời giờ làm việc bình thường. Ở Việt Nam, số giờ làm thêm không quá 40 giờ trong một tháng.}
  {}
  {\code{overtime_hours}: giờ làm thêm trong tháng của từng nhân viên; giới hạn trong dữ liệu khác nhau theo nước.}
\khaibaokhainiem{ngay-vang-mat}{Số ngày vắng mặt}
  {Số ngày vắng mặt là số ngày nhân viên không có mặt làm việc trong tháng, không tính ngày nghỉ theo lịch.}
  {}
  {\code{absence_days} (0 tới 20); khoảng 5\% dòng trống (NULL) do thiếu dữ liệu chấm công, không phải 0 ngày.}
\khaibaokhainiem{luong-thang}{Tiền lương tháng và quỹ lương}
  {Tiền lương là khoản tiền công ty trả cho người lao động theo thoả thuận để thực hiện công việc. Quỹ lương là tổng tiền lương của mọi nhân viên trong kỳ.}
  {quỹ lương tháng = tổng tiền lương tháng của nhân viên có tên trong tháng}
  {\code{monthly_salary_usd} (USD, đã làm tròn); dữ liệu không có thưởng, phụ cấp.}
\khaibaokhainiem{compa-ratio}{Compa-ratio (tỷ số lương trên mức thị trường)}
  {Compa-ratio so tiền lương của một người với mức lương thị trường trung vị của cùng chức danh, bậc và nước. Giá trị dưới 1 là trả thấp hơn thị trường.}
  {tiền lương tháng / mức lương thị trường P50}
  {có sẵn ở \code{compa_ratio}; câu hỏi dùng cột này. Tự tính lại từ \code{country_market_benchmark} sẽ lệch tới 0,04 vì lương đã làm tròn.}
\khaibaokhainiem{luong-thi-truong}{Mức lương thị trường P50, P75}
  {Mức lương thị trường P50 là mức mà một nửa số người cùng chức danh trên thị trường nhận thấp hơn; P75 là mức mà 75\% nhận thấp hơn.}
  {}
  {\code{country_market_benchmark}: nối theo \code{benchmark_year} = năm của \code{snapshot_month}, \code{country}, \code{job_role} = \code{job_family}, \code{job_level}.}
\khaibaokhainiem{de-bat}{Đề bạt}
  {Đề bạt là việc đưa nhân viên lên vị trí có bậc cao hơn, kèm mức lương cao hơn.}
  {}
  {nhận biết khi \code{job_level} của một nhân viên tăng so với tháng trước; \code{months_since_promotion} trở về 0; \code{position_id} đổi theo bậc.}
\khaibaokhainiem{danh-gia-thcv}{Điểm đánh giá thực hiện công việc}
  {Đánh giá thực hiện công việc là việc so kết quả làm việc của người lao động với tiêu chuẩn đã đặt ra, làm cơ sở cho khen thưởng, đề bạt và đãi ngộ.}
  {}
  {\code{performance_rating} từ 1 tới 4 (4 cao nhất), đánh giá hằng năm; khoảng 2\% dòng trống (NULL).}
\khaibaokhainiem{hieu-suat-cao}{Nhân viên có kết quả thực hiện công việc cao}
  {Nhân viên có kết quả thực hiện công việc cao là người đạt mức đánh giá cao nhất của kỳ đánh giá.}
  {performance\_rating = 4}
  {cờ \code{high_performer_flag}; cờ được tính trước khi một số điểm đánh giá bị trống, nên có dòng cờ bằng 1 mà \code{performance_rating} trống. Câu hỏi ghi rõ dùng cờ hay dùng điểm.}
\khaibaokhainiem{diem-gan-ket}{Điểm gắn kết}
  {Mức độ gắn kết phản ánh sự tận tâm về thể chất, nhận thức và cảm xúc của nhân viên với công việc.}
  {}
  {hai nguồn khác nhau: \code{employee_monthly_snapshot.engagement_score} (ước lượng hằng tháng, có sai số đo, khoảng 3,5\% trống) và \code{engagement_survey.engagement_score} (khảo sát theo quý, \code{survey_quarter} dạng \code{'2025-Q3'}). Câu hỏi ghi rõ dùng nguồn nào.}
\khaibaokhainiem{enps}{eNPS}
  {eNPS đo mức nhân viên sẵn sàng giới thiệu công ty là nơi làm việc tốt.}
  {\% người ủng hộ (9 hoặc 10 điểm) - \% người phản đối (0 tới 6 điểm), thang -100 tới +100}
  {\code{engagement_survey.eNPS}, thang 0 tới 10, một phiếu cho mỗi nhân viên mỗi quý.}
\khaibaokhainiem{quan-ly-truc-tiep}{Quản lý trực tiếp và cây quản lý}
  {Quản lý trực tiếp là người giao việc và đánh giá nhân viên. Nối các cặp nhân viên và quản lý tạo thành cây quản lý của tổ chức.}
  {}
  {\code{manager_id} là \code{employee_id} của quản lý (bậc L5 trở lên, cùng nước và phòng ban); khoảng 1\% trống. Quản lý có thể đã nghỉ việc trước tháng đang xét, và có cặp hai người ghi là quản lý của nhau, nên khi duyệt cây phải chặn độ sâu.}
\khaibaokhainiem{dinh-bien}{Định biên và chỗ trống}
  {Định biên là số người được duyệt cho một vị trí trong năm kế hoạch. Chỗ trống là phần định biên chưa có người.}
  {chỗ trống = định biên - quân số thực tế}
  {\code{position_plan}: \code{planned_headcount}, \code{actual_headcount} (số dòng tháng 12, gồm cả người nghỉ trong tháng 12), \code{vacancy_count}; khoá (\code{plan_period}, \code{position_id}). Có vị trí có nhân viên nhưng không có trong kế hoạch năm.}
\khaibaokhainiem{vi-tri-then-chot}{Vị trí then chốt}
  {Vị trí then chốt là vị trí mà việc để trống ảnh hưởng lớn tới hoạt động, cần ưu tiên tuyển thay thế và quy hoạch kế nhiệm.}
  {bậc từ L4 trở lên}
  {\code{position_plan.critical_role_flag} = 1; \code{backfill_allowed} là chuỗi \code{'Yes'} hoặc \code{'No'}.}
\khaibaokhainiem{yeu-cau-tuyen-dung}{Yêu cầu tuyển dụng và tuyển thay thế}
  {Yêu cầu tuyển dụng là đề nghị đã được duyệt để tuyển người cho một vị trí. Tuyển thay thế là tuyển cho chỗ của người đã nghỉ việc; tuyển mới là tuyển cho định biên tăng thêm.}
  {}
  {\code{recruiting_pipeline}: \code{requisition_type} \code{'Backfill'} (có \code{vacated_employee_id}) hoặc \code{'New headcount'} (trống); \code{attrition_month} là tháng người cũ nghỉ.}
\khaibaokhainiem{thoi-gian-tuyen}{Thời gian tuyển (time to fill)}
  {Thời gian tuyển là số ngày từ khi yêu cầu tuyển dụng được duyệt tới khi ứng viên nhận lời mời làm việc.}
  {ngày nhận lời - ngày duyệt}
  {có sẵn ở \code{time_to_fill_days}; ngày bắt đầu làm việc \code{start_date} đến sau ngày nhận lời 14 tới 45 ngày, có thể sau tháng 12/2025.}
\khaibaokhainiem{chi-phi-tuyen-dung}{Chi phí tuyển dụng}
  {Chi phí tuyển dụng là tổng chi phí để tuyển được một người cho một yêu cầu tuyển dụng.}
  {}
  {\code{recruiting_cost_usd} (USD mỗi yêu cầu), cao hơn với bậc cao và với nguồn tuyển qua đơn vị trung gian.}
\khaibaokhainiem{diem-nong-nghi-viec}{Điểm nóng nghỉ việc}
  {Điểm nóng nghỉ việc là nhóm nước và phòng ban có tỷ lệ nghỉ việc cao hơn hẳn mặt bằng chung của công ty.}
  {tỷ lệ nghỉ việc của nhóm / tỷ lệ nghỉ việc toàn công ty}
  {nhóm theo \code{country} và \code{department} của \code{employee_monthly_snapshot}.}
```

Ghi chú cho người soạn: không đưa vào tab Nghiệp vụ các quan hệ của bộ sinh dữ liệu (hệ số nhân của điểm nóng, AUC ≈ 0,73–0,78, mức giảm gắn kết theo tháng) như là phát hiện; đó là giả định dựng sẵn (DD).

---

## F. Điểm cần giảng viên chốt

1. **compa-ratio**: không tìm được thuật ngữ tiếng Việt chuẩn; đề xuất giữ "compa-ratio" kèm giải nghĩa "tỷ số lương trên mức thị trường".
2. **"ứng viên"**: SG C.2 cấm từ này (theo nghĩa "phương án"); bộ HR cần đúng nghĩa "người dự tuyển". Đề xuất cho phép riêng ở bộ HR.
3. **Contractor**: dữ liệu không ghi loại HĐLĐ; đề xuất "nhân viên hợp đồng ngắn hạn (contractor)", tránh "thời vụ" (BLLĐ 2019 đã bỏ HĐ mùa vụ).
4. **Quân số trong tỷ lệ nghỉ việc**: đề xuất mặc định "quân số bình quân = số dòng / số tháng" (có tên trong tháng); câu nào khác phải ghi rõ.
5. Giáo trình NEU, ĐH Lao động – Xã hội, UEH **không có bản trực tuyến**; cột nguồn hiện dựa trên BLLĐ 2019, NĐ145, bài Tạp chí Công Thương và metadata giáo trình. Nếu giảng viên có bản giấy (NEU chương Đánh giá thực hiện công việc, Thù lao; ULSA Tiền lương – Tiền công) cần đối chiếu lại A.3, A.4.

---

## G. Ánh xạ 6 khoá mảng nghiệp vụ chuẩn (`domain`) sang bộ HR – CẦN DEV DUYỆT

Bộ HR không có bán hàng, khách hàng hay hậu mãi theo nghĩa đen. Theo yêu cầu "không thêm khoá mới", 6 khoá chuẩn được
**mượn tên** như sau. Tên hiển thị trong `\khaibaodomain{khoa}{Tên hiển thị}{mô tả}` dùng chữ nhân sự (cột 2), nên học viên
không thấy chữ "Bán hàng", "Hậu mãi".

| Khoá chuẩn | Tên hiển thị đề xuất | Nội dung câu hỏi | Bảng chính |
|---|---|---|---|
| `operations` | Vận hành nhân sự | quân số, làm thêm giờ, vắng mặt, đào tạo, định biên, chỗ trống, cây quản lý | `employee_monthly_snapshot`, `position_plan`, `positions` |
| `finance` | Tiền lương và chi phí nhân sự | tiền lương, quỹ lương, compa-ratio, lương thị trường, đề bạt và tăng lương, tiền lương làm thêm giờ ước tính | `employee_monthly_snapshot`, `country_market_benchmark` |
| `customer` | Nhân viên và giữ chân | gắn kết, khảo sát, eNPS, ý định ở lại, đánh giá thực hiện công việc, tiềm năng, cohort giữ chân | `engagement_survey`, `employee_monthly_snapshot` |
| `marketing` | Tuyển dụng và thương hiệu nhà tuyển dụng | yêu cầu tuyển dụng, nguồn tuyển, thời gian tuyển, chi phí tuyển dụng, phễu tuyển dụng | `recruiting_pipeline`, `position_plan` |
| `sales` | Khối Kinh doanh | câu chỉ về phòng `'Sales'`: quân số, ngày công tác, làm thêm, nghỉ việc của đội kinh doanh (dữ liệu **không có doanh số**, nên "năng suất" chỉ đo bằng đầu vào lao động) | `employee_monthly_snapshot` (lọc `department = 'Sales'`) |
| `after_sales` | Nghỉ việc và thôi việc | người nghỉ, tỷ lệ nghỉ việc, loại và lý do nghỉ (phỏng vấn thôi việc), nghỉ hưu, biến mục tiêu nghỉ việc 3/6 tháng, điểm nóng | `employee_monthly_snapshot`, `recruiting_pipeline` (tuyển thay thế) |

Rủi ro: `sales` mỏng (chỉ một phòng ban); báo cáo theo mảng trên giao diện sẽ hiện "sales" cho câu nhân sự khối kinh doanh.
**Nếu dev muốn khoá riêng cho HR** (ví dụ `workforce`, `compensation`, `engagement`, `recruiting`, `attrition`) thì phải sửa
danh sách khoá ở bộ kiểm và giao diện; bộ chuẩn này chưa làm, chờ dev duyệt. Ghi khoá thật trong `domain=` của mọi câu theo
bảng trên để đổi tên hàng loạt về sau được.
