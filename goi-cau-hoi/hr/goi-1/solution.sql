-- solution.sql: gói 1 của bộ HR Analytics (dulieu=hr), cú pháp MySQL 8.0, chỉ SELECT hoặc WITH.
-- Chạy trên hr (public) và hr_hidden_1 (hidden-1).
-- Mỗi truy vấn bắt đầu bằng một dòng đánh dấu, chạy tới dòng đánh dấu tiếp theo:
--   -- [ma-cau] solution          lời giải
--   -- [ma-cau] starter           truy vấn khởi đầu (debug: chạy được nhưng sai kết quả)
--   -- [ma-cau] wrong: ten_loi    bài sai thường gặp, phải rớt ít nhất một biến thể
--   -- [ma-cau.b1] solution       SQL của bước b1 trong case study
-- Các dòng trước dòng đánh dấu đầu tiên (như khối chú thích này) bị bỏ qua.

-- ================================================ MODULE 1 · RETRIEVAL

-- [hr-r1-lam-them-vn-thang-12] solution
SELECT employee_id, city, department, overtime_hours
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam'
  AND overtime_hours >= 30
ORDER BY overtime_hours DESC, employee_id;

-- [hr-r1-lam-them-vn-thang-12] wrong: quen_loc_thang
-- Rớt ở public: lấy dòng của cả 24 tháng, một người xuất hiện nhiều lần.
SELECT employee_id, city, department, overtime_hours
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND overtime_hours >= 30
ORDER BY overtime_hours DESC, employee_id;

-- [hr-r1-lam-them-vn-thang-12] wrong: lon_hon_han_30
-- Rớt ở public: mất những người làm thêm đúng 30 giờ.
SELECT employee_id, city, department, overtime_hours
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam'
  AND overtime_hours > 30
ORDER BY overtime_hours DESC, employee_id;

-- [hr-r2-nghi-tu-nguyen-thang-9] solution
SELECT employee_id, department, attrition_reason
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-09'
  AND attrition_type = 'Voluntary'
ORDER BY employee_id;

-- [hr-r2-nghi-tu-nguyen-thang-9] wrong: chi_loc_co_nghi
-- Rớt ở public: cờ nghỉ bằng 1 gồm cả nghỉ hưu và chấm dứt hợp đồng do công ty.
SELECT employee_id, department, attrition_reason
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-09'
  AND attrition_this_month = 1
ORDER BY employee_id;

-- [hr-r2-nghi-tu-nguyen-thang-9] wrong: quen_loc_thang
-- Rớt ở public: lấy người nghỉ tự nguyện của cả 24 tháng.
SELECT employee_id, department, attrition_reason
FROM employee_monthly_snapshot
WHERE attrition_type = 'Voluntary'
ORDER BY employee_id;

-- [hr-r3-tuyen-qua-gioi-thieu] solution
SELECT requisition_id, country, department, job_role, approval_date
FROM recruiting_pipeline
WHERE recruitment_source = 'Employee Referral'
  AND approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
ORDER BY approval_date, requisition_id;

-- [hr-r3-tuyen-qua-gioi-thieu] wrong: viet_tat_ten_nguon
-- Rớt ở public: giá trị trong bảng là 'Employee Referral', viết 'Referral' ra 0 dòng.
SELECT requisition_id, country, department, job_role, approval_date
FROM recruiting_pipeline
WHERE recruitment_source = 'Referral'
  AND approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
ORDER BY approval_date, requisition_id;

-- [hr-r3-tuyen-qua-gioi-thieu] wrong: thieu_can_duoi
-- Rớt ở public: chỉ có cận trên nên lấy cả yêu cầu duyệt năm 2024.
SELECT requisition_id, country, department, job_role, approval_date
FROM recruiting_pipeline
WHERE recruitment_source = 'Employee Referral'
  AND approval_date < '2026-01-01'
ORDER BY approval_date, requisition_id;

-- [hr-r4-sales-cong-tac-indonesia] solution
SELECT employee_id, job_level, business_travel_days
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Indonesia'
  AND job_family = 'Account Executive'
ORDER BY business_travel_days DESC, employee_id
LIMIT 10;

-- [hr-r4-sales-cong-tac-indonesia] wrong: loc_theo_phong_ban
-- Rớt ở public: phòng Sales gồm cả Country Sales Lead và Sales Development Rep.
SELECT employee_id, job_level, business_travel_days
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Indonesia'
  AND department = 'Sales'
ORDER BY business_travel_days DESC, employee_id
LIMIT 10;

-- [hr-r4-sales-cong-tac-indonesia] wrong: hoa_lay_id_lon_truoc
-- Rớt ở public: hạng 8 tới 11 bằng nhau, sắp employee_id giảm dần lấy sai người ở cuối danh sách.
SELECT employee_id, job_level, business_travel_days
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Indonesia'
  AND job_family = 'Account Executive'
ORDER BY business_travel_days DESC, employee_id DESC
LIMIT 10;

-- [hr-r5-tiem-nang-cao-chua-de-bat] solution
SELECT employee_id, job_family, job_level, months_since_promotion
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Indonesia'
  AND department = 'Customer Support'
  AND potential_rating = 'High'
  AND months_since_promotion >= 24
ORDER BY months_since_promotion DESC, employee_id;

-- [hr-r5-tiem-nang-cao-chua-de-bat] wrong: quen_loc_thang
-- Rớt ở public: một người ra nhiều dòng, mỗi tháng một dòng.
SELECT employee_id, job_family, job_level, months_since_promotion
FROM employee_monthly_snapshot
WHERE country = 'Indonesia'
  AND department = 'Customer Support'
  AND potential_rating = 'High'
  AND months_since_promotion >= 24
ORDER BY months_since_promotion DESC, employee_id;

-- [hr-r5-tiem-nang-cao-chua-de-bat] wrong: lon_hon_han_24
-- Rớt ở public: mất những người vừa tròn 24 tháng chưa được đề bạt.
SELECT employee_id, job_family, job_level, months_since_promotion
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Indonesia'
  AND department = 'Customer Support'
  AND potential_rating = 'High'
  AND months_since_promotion > 24
ORDER BY months_since_promotion DESC, employee_id;

-- [hr-r6-dong-bang-tuyen-thay-the] solution
SELECT position_id, country, department, job_role, job_level, vacancy_count
FROM position_plan
WHERE plan_period = 2025
  AND backfill_allowed = 'No'
  AND vacancy_count > 0
ORDER BY vacancy_count DESC, position_id;

-- [hr-r6-dong-bang-tuyen-thay-the] wrong: so_sanh_voi_so_0
-- Rớt ở public: backfill_allowed là chữ; so với số 0 thì cả 'Yes' và 'No'
-- đều đổi thành 0, lấy mọi vị trí còn trống.
SELECT position_id, country, department, job_role, job_level, vacancy_count
FROM position_plan
WHERE plan_period = 2025
  AND backfill_allowed = 0
  AND vacancy_count > 0
ORDER BY vacancy_count DESC, position_id;

-- [hr-r6-dong-bang-tuyen-thay-the] wrong: quen_nam_ke_hoach
-- Rớt ở public: lấy cả vị trí của năm kế hoạch 2024.
SELECT position_id, country, department, job_role, job_level, vacancy_count
FROM position_plan
WHERE backfill_allowed = 'No'
  AND vacancy_count > 0
ORDER BY vacancy_count DESC, position_id;

-- [hr-r7-danh-sach-nghi-huu-rong] starter
SELECT employee_id, snapshot_month, country, age
FROM employee_monthly_snapshot
WHERE attrition_type = 'Retired'
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
ORDER BY snapshot_month, employee_id;

-- [hr-r7-danh-sach-nghi-huu-rong] solution
SELECT employee_id, snapshot_month, country, age
FROM employee_monthly_snapshot
WHERE attrition_type = 'Retirement'
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
ORDER BY snapshot_month, employee_id;

-- [hr-r7-danh-sach-nghi-huu-rong] wrong: lay_moi_loai_nghi
-- Rớt ở public: cờ nghỉ bằng 1 gồm cả nghỉ tự nguyện và chấm dứt hợp đồng.
SELECT employee_id, snapshot_month, country, age
FROM employee_monthly_snapshot
WHERE attrition_this_month = 1
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
ORDER BY snapshot_month, employee_id;

-- [hr-r7-danh-sach-nghi-huu-rong] wrong: loc_theo_tuoi
-- Rớt ở public: người từ 60 tuổi trở lên phần lớn vẫn đang làm việc.
SELECT employee_id, snapshot_month, country, age
FROM employee_monthly_snapshot
WHERE age >= 60
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
ORDER BY snapshot_month, employee_id;

-- [hr-r8-yeu-cau-thang-3-thieu-ngay] starter
SELECT COUNT(*) AS so_yeu_cau, SUM(recruiting_cost_usd) AS chi_phi_usd
FROM recruiting_pipeline
WHERE start_date BETWEEN '2025-03-01' AND '2025-03-30';

-- [hr-r8-yeu-cau-thang-3-thieu-ngay] solution
SELECT COUNT(*) AS so_yeu_cau, SUM(recruiting_cost_usd) AS chi_phi_usd
FROM recruiting_pipeline
WHERE start_date >= '2025-03-01' AND start_date < '2025-04-01';

-- [hr-r8-yeu-cau-thang-3-thieu-ngay] wrong: chi_loc_thang_quen_nam
-- Rớt ở public: MONTH() = 3 lấy cả tháng 3/2024 và tháng 3/2026.
SELECT COUNT(*) AS so_yeu_cau, SUM(recruiting_cost_usd) AS chi_phi_usd
FROM recruiting_pipeline
WHERE MONTH(start_date) = 3;

-- [hr-r8-yeu-cau-thang-3-thieu-ngay] wrong: loc_theo_ngay_duyet
-- Rớt ở public: ngày duyệt khác ngày bắt đầu làm việc.
SELECT COUNT(*) AS so_yeu_cau, SUM(recruiting_cost_usd) AS chi_phi_usd
FROM recruiting_pipeline
WHERE approval_date >= '2025-03-01' AND approval_date < '2025-04-01';

-- [hr-r9-loc-tp-hcm-ra-0] starter
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND city = 'Ho Chi Minh'
  AND engagement_score <= 40;

-- [hr-r9-loc-tp-hcm-ra-0] solution
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND city = 'Ho Chi Minh City'
  AND engagement_score < 40;

-- [hr-r9-loc-tp-hcm-ra-0] wrong: loc_theo_nuoc
-- Rớt ở public: Việt Nam có hai thành phố, lọc theo nước lấy cả Hà Nội.
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam'
  AND engagement_score < 40;

-- [hr-r9-loc-tp-hcm-ra-0] wrong: quen_loc_thang
-- Rớt ở public: đếm dòng của cả 24 tháng.
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE city = 'Ho Chi Minh City'
  AND engagement_score < 40;

-- ================================= MODULE 2 · NULL & EXPRESSIONS

-- [hr-n1-vang-mat-binh-quan-thang-6] solution
SELECT COUNT(absence_days) AS so_dong_co_du_lieu,
       ROUND(AVG(absence_days), 2) AS ngay_vang_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-06';

-- [hr-n1-vang-mat-binh-quan-thang-6] wrong: chia_cho_moi_dong
-- Rớt ở public: COUNT(*) đếm cả dòng thiếu dữ liệu chấm công, bình quân thấp hơn.
SELECT COUNT(*) AS so_dong_co_du_lieu,
       ROUND(SUM(absence_days) / COUNT(*), 2) AS ngay_vang_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-06';

-- [hr-n1-vang-mat-binh-quan-thang-6] wrong: quen_loc_thang
-- Rớt ở public: tính trên cả 24 tháng, số dòng có dữ liệu lớn hơn nhiều.
SELECT COUNT(absence_days) AS so_dong_co_du_lieu,
       ROUND(AVG(absence_days), 2) AS ngay_vang_bq
FROM employee_monthly_snapshot;

-- [hr-n2-thieu-diem-gan-ket] solution
SELECT employee_id, country, department
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND engagement_score IS NULL
ORDER BY employee_id;

-- [hr-n2-thieu-diem-gan-ket] wrong: so_bang_null
-- Rớt ở public: so sánh bằng với NULL không bao giờ đúng, ra 0 dòng.
SELECT employee_id, country, department
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND engagement_score = NULL
ORDER BY employee_id;

-- [hr-n2-thieu-diem-gan-ket] wrong: quen_loc_thang
-- Rớt ở public: lấy dòng thiếu điểm của cả 24 tháng.
SELECT employee_id, country, department
FROM employee_monthly_snapshot
WHERE engagement_score IS NULL
ORDER BY employee_id;

-- [hr-n3-nhom-compa-ratio] solution
SELECT CASE WHEN compa_ratio < 0.9 THEN 'thap_hon'
            WHEN compa_ratio <= 1.1 THEN 'ngang'
            ELSE 'cao_hon' END AS nhom_compa,
       COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY nhom_compa
ORDER BY nhom_compa;

-- [hr-n3-nhom-compa-ratio] wrong: sai_bien_nhom
-- Rớt ở public: người có compa-ratio đúng 0,9 bị xếp vào nhóm thấp hơn, đúng 1,1 vào nhóm cao hơn.
SELECT CASE WHEN compa_ratio <= 0.9 THEN 'thap_hon'
            WHEN compa_ratio < 1.1 THEN 'ngang'
            ELSE 'cao_hon' END AS nhom_compa,
       COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY nhom_compa
ORDER BY nhom_compa;

-- [hr-n3-nhom-compa-ratio] wrong: hieu_la_phan_tram
-- Rớt ở public: compa_ratio là tỷ số, so với 90 và 110 thì mọi người vào nhóm thấp hơn.
SELECT CASE WHEN compa_ratio < 90 THEN 'thap_hon'
            WHEN compa_ratio <= 110 THEN 'ngang'
            ELSE 'cao_hon' END AS nhom_compa,
       COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY nhom_compa
ORDER BY nhom_compa;

-- [hr-n4-ty-le-nghi-tu-nguyen-2024] solution
SELECT SUM(attrition_this_month) AS so_nguoi_nghi,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_tu_nguyen,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / SUM(attrition_this_month), 2) AS ty_le_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2024-12';

-- [hr-n4-ty-le-nghi-tu-nguyen-2024] wrong: mau_so_moi_dong
-- Rớt ở public: COUNT(*) đếm mọi dòng của năm, kể cả người không nghỉ.
SELECT COUNT(*) AS so_nguoi_nghi,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_tu_nguyen,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / COUNT(*), 2) AS ty_le_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2024-12';

-- [hr-n4-ty-le-nghi-tu-nguyen-2024] wrong: bo_nghi_huu_khoi_mau_so
-- Rớt ở public: đề tính mọi loại nghỉ việc, kể cả nghỉ hưu.
SELECT COUNT(CASE WHEN attrition_type <> 'Retirement' THEN 1 END) AS so_nguoi_nghi,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_tu_nguyen,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / COUNT(CASE WHEN attrition_type <> 'Retirement' THEN 1 END), 2)
         AS ty_le_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2024-12';

-- [hr-n5-co-hieu-suat-cao-thieu-diem] solution
SELECT COUNT(CASE WHEN snapshot_month <= '2024-12' THEN 1 END) AS so_dong_2024,
       COUNT(CASE WHEN snapshot_month >= '2025-01' THEN 1 END) AS so_dong_2025
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  AND high_performer_flag = 1
  AND performance_rating IS NULL;

-- [hr-n5-co-hieu-suat-cao-thieu-diem] wrong: khac_4_bo_sot_null
-- Rớt ở public: so sánh <> 4 với ô trống không đúng, dòng thiếu điểm bị loại, ra 0.
SELECT COUNT(CASE WHEN snapshot_month <= '2024-12' THEN 1 END) AS so_dong_2024,
       COUNT(CASE WHEN snapshot_month >= '2025-01' THEN 1 END) AS so_dong_2025
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  AND high_performer_flag = 1
  AND performance_rating <> 4;

-- [hr-n5-co-hieu-suat-cao-thieu-diem] wrong: quen_loc_co
-- Rớt ở public: đếm mọi dòng thiếu điểm đánh giá, kể cả dòng không gắn cờ.
SELECT COUNT(CASE WHEN snapshot_month <= '2024-12' THEN 1 END) AS so_dong_2024,
       COUNT(CASE WHEN snapshot_month >= '2025-01' THEN 1 END) AS so_dong_2025
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
  AND performance_rating IS NULL;

-- [hr-n6-nhan-loai-yeu-cau] solution
SELECT CASE WHEN vacated_employee_id IS NULL THEN 'tuyen_moi'
            ELSE 'tuyen_thay_the' END AS loai_yeu_cau,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY loai_yeu_cau
ORDER BY loai_yeu_cau;

-- [hr-n6-nhan-loai-yeu-cau] wrong: so_voi_chuoi_rong
-- Rớt ở public: ô trống khác chuỗi rỗng, mọi yêu cầu bị gán 'tuyen_thay_the'.
SELECT CASE WHEN vacated_employee_id = '' THEN 'tuyen_moi'
            ELSE 'tuyen_thay_the' END AS loai_yeu_cau,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY loai_yeu_cau
ORDER BY loai_yeu_cau;

-- [hr-n6-nhan-loai-yeu-cau] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có thêm yêu cầu tuyển mới R0801 duyệt ngày 2026-01-05.
SELECT CASE WHEN vacated_employee_id IS NULL THEN 'tuyen_moi'
            ELSE 'tuyen_thay_the' END AS loai_yeu_cau,
       COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq_usd
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01'
GROUP BY loai_yeu_cau
ORDER BY loai_yeu_cau;

-- [hr-n7-gio-dao-tao-thap] starter
SELECT ROUND(AVG(COALESCE(training_hours_6m, 0)), 2) AS gio_dao_tao_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-n7-gio-dao-tao-thap] solution
SELECT ROUND(AVG(training_hours_6m), 2) AS gio_dao_tao_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-n7-gio-dao-tao-thap] wrong: bo_ca_dong_0_gio
-- Rớt ở public: có người thật sự không đào tạo giờ nào; bỏ họ làm bình quân cao lên.
SELECT ROUND(AVG(training_hours_6m), 2) AS gio_dao_tao_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND training_hours_6m > 0;

-- [hr-n8-dem-tiem-nang-thieu] starter
SELECT COUNT(*) AS so_nguoi_du_dieu_kien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND potential_rating <> 'Low';

-- [hr-n8-dem-tiem-nang-thieu] solution
SELECT COUNT(*) AS so_nguoi_du_dieu_kien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND (potential_rating <> 'Low' OR potential_rating IS NULL);

-- [hr-n8-dem-tiem-nang-thieu] wrong: thieu_ngoac_quanh_or
-- Rớt ở public: AND tính trước OR, nên lấy thêm người chưa đánh giá của mọi tháng.
SELECT COUNT(*) AS so_nguoi_du_dieu_kien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND potential_rating <> 'Low' OR potential_rating IS NULL;

-- [hr-n8-dem-tiem-nang-thieu] wrong: chi_dem_hai_muc
-- Rớt ở public: liệt kê 'High' và 'Medium' vẫn bỏ sót người chưa được đánh giá.
SELECT COUNT(*) AS so_nguoi_du_dieu_kien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND potential_rating IN ('High', 'Medium');

-- [hr-n9-tien-lam-them-lech] starter
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(ROUND(monthly_salary_usd / 176, 0) * 1.5 * overtime_hours), 2)
         AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam';

-- [hr-n9-tien-lam-them-lech] solution
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(monthly_salary_usd / 176 * 1.5 * overtime_hours), 2) AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam';

-- [hr-n9-tien-lam-them-lech] wrong: quen_muc_150
-- Rớt ở public: trả giờ làm thêm bằng giờ thường, thiếu mức 150%.
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(monthly_salary_usd / 176 * overtime_hours), 2) AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam';

-- [hr-n9-tien-lam-them-lech] wrong: lam_tron_tung_nguoi
-- Rớt ở public: làm tròn tiền của từng người tới USD rồi mới cộng.
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(ROUND(monthly_salary_usd / 176 * 1.5 * overtime_hours, 0)), 2)
         AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam';

-- ============================================ CASE STUDY · CƠ BẢN

-- [hr-c1-thang-nghi-nhieu-nhat.b1] solution
SELECT snapshot_month AS thang,
       COUNT(*) AS so_nhan_vien,
       SUM(attrition_this_month) AS so_nguoi_nghi,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_tu_nguyen
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-c1-thang-nghi-nhieu-nhat.b1] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có thêm tháng '2026-01'.
SELECT snapshot_month AS thang,
       COUNT(*) AS so_nhan_vien,
       SUM(attrition_this_month) AS so_nguoi_nghi,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_tu_nguyen
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-c1-thang-nghi-nhieu-nhat.b1] wrong: count_dem_ca_so_0
-- Rớt ở public: COUNT(cột cờ) đếm cả dòng có cờ bằng 0, ra bằng số nhân viên.
SELECT snapshot_month AS thang,
       COUNT(*) AS so_nhan_vien,
       COUNT(attrition_this_month) AS so_nguoi_nghi,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_tu_nguyen
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY snapshot_month
ORDER BY thang;

-- [hr-c2-thieu-diem-gan-ket-theo-phong.b1] solution
SELECT department,
       COUNT(*) AS so_dong,
       COUNT(*) - COUNT(engagement_score) AS so_dong_thieu,
       ROUND(100 * (COUNT(*) - COUNT(engagement_score)) / COUNT(*), 2) AS ty_le_thieu_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY ty_le_thieu_pct DESC, department;

-- [hr-c2-thieu-diem-gan-ket-theo-phong.b1] wrong: dem_dong_co_diem
-- Rớt ở public: COUNT(engagement_score) đếm dòng có điểm, không phải dòng thiếu.
SELECT department,
       COUNT(*) AS so_dong,
       COUNT(engagement_score) AS so_dong_thieu,
       ROUND(100 * COUNT(engagement_score) / COUNT(*), 2) AS ty_le_thieu_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY ty_le_thieu_pct DESC, department;

-- [hr-c2-thieu-diem-gan-ket-theo-phong.b1] wrong: sap_theo_so_dong_thieu
-- Rớt ở public: sắp theo số dòng thiếu đưa phòng đông người lên đầu, sai thứ tự đề yêu cầu.
SELECT department,
       COUNT(*) AS so_dong,
       COUNT(*) - COUNT(engagement_score) AS so_dong_thieu,
       ROUND(100 * (COUNT(*) - COUNT(engagement_score)) / COUNT(*), 2) AS ty_le_thieu_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY so_dong_thieu DESC, department;
