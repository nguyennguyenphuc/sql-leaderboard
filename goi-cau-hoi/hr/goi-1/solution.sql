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

-- [hr-r2-nghi-tu-nguyen-can-giu-quy-3] solution
SELECT employee_id, snapshot_month, department, attrition_reason,
       performance_rating, potential_rating
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-07' AND '2025-09'
  AND attrition_type = 'Voluntary'
  AND attrition_reason IN ('Compensation', 'Career Growth',
                           'Manager Relationship', 'Work-Life Balance')
  AND (performance_rating = 4 OR potential_rating = 'High')
ORDER BY snapshot_month, employee_id;

-- [hr-r2-nghi-tu-nguyen-can-giu-quy-3] wrong: thieu_ngoac_quanh_or
-- Rớt ở public: AND tính trước OR, nên lấy thêm người tiềm năng cao của mọi tháng.
SELECT employee_id, snapshot_month, department, attrition_reason,
       performance_rating, potential_rating
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-07' AND '2025-09'
  AND attrition_type = 'Voluntary'
  AND attrition_reason IN ('Compensation', 'Career Growth',
                           'Manager Relationship', 'Work-Life Balance')
  AND performance_rating = 4 OR potential_rating = 'High'
ORDER BY snapshot_month, employee_id;

-- [hr-r2-nghi-tu-nguyen-can-giu-quy-3] wrong: bo_loc_ly_do
-- Rớt ở public: lẫn người nghỉ vì lý do cá nhân, chuyển nơi ở.
SELECT employee_id, snapshot_month, department, attrition_reason,
       performance_rating, potential_rating
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-07' AND '2025-09'
  AND attrition_type = 'Voluntary'
  AND (performance_rating = 4 OR potential_rating = 'High')
ORDER BY snapshot_month, employee_id;

-- [hr-r2-nghi-tu-nguyen-can-giu-quy-3] wrong: ket_qua_cao_tu_3
-- Rớt ở public: định nghĩa lấy điểm 4, điểm 3 không thuộc nhóm kết quả cao.
SELECT employee_id, snapshot_month, department, attrition_reason,
       performance_rating, potential_rating
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2025-07' AND '2025-09'
  AND attrition_type = 'Voluntary'
  AND attrition_reason IN ('Compensation', 'Career Growth',
                           'Manager Relationship', 'Work-Life Balance')
  AND (performance_rating >= 3 OR potential_rating = 'High')
ORDER BY snapshot_month, employee_id;

-- [hr-r3-yeu-cau-tuyen-cham-quy-4] solution
SELECT requisition_id, requisition_type, recruitment_source, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01' AND approval_date < '2026-01-01'
  AND recruitment_source IN ('LinkedIn', 'Indeed', 'CareerBuilder')
  AND ((requisition_type = 'New headcount' AND time_to_fill_days > 30)
       OR (requisition_type = 'Backfill' AND time_to_fill_days > 45))
ORDER BY time_to_fill_days DESC, requisition_id;

-- [hr-r3-yeu-cau-tuyen-cham-quy-4] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có R0801 duyệt 2026-01-05, qua Indeed, tuyển mới 31 ngày.
SELECT requisition_id, requisition_type, recruitment_source, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01'
  AND recruitment_source IN ('LinkedIn', 'Indeed', 'CareerBuilder')
  AND ((requisition_type = 'New headcount' AND time_to_fill_days > 30)
       OR (requisition_type = 'Backfill' AND time_to_fill_days > 45))
ORDER BY time_to_fill_days DESC, requisition_id;

-- [hr-r3-yeu-cau-tuyen-cham-quy-4] wrong: mot_chuan_30_ngay
-- Rớt ở public: tuyển thay thế được tới 45 ngày, áp 30 ngày cho mọi loại lấy thừa.
SELECT requisition_id, requisition_type, recruitment_source, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01' AND approval_date < '2026-01-01'
  AND recruitment_source IN ('LinkedIn', 'Indeed', 'CareerBuilder')
  AND time_to_fill_days > 30
ORDER BY time_to_fill_days DESC, requisition_id;

-- [hr-r3-yeu-cau-tuyen-cham-quy-4] wrong: thieu_ngoac_quanh_or
-- Rớt ở public: vế tuyển thay thế sau OR không còn bị giới hạn bởi kỳ duyệt và nguồn.
SELECT requisition_id, requisition_type, recruitment_source, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01' AND approval_date < '2026-01-01'
  AND recruitment_source IN ('LinkedIn', 'Indeed', 'CareerBuilder')
  AND requisition_type = 'New headcount' AND time_to_fill_days > 30
   OR requisition_type = 'Backfill' AND time_to_fill_days > 45
ORDER BY time_to_fill_days DESC, requisition_id;

-- [hr-r3-yeu-cau-tuyen-cham-quy-4] wrong: lay_moi_nguon
-- Rớt ở public: lẫn yêu cầu qua giới thiệu nội bộ, trang web công ty và nguồn khác.
SELECT requisition_id, requisition_type, recruitment_source, time_to_fill_days
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01' AND approval_date < '2026-01-01'
  AND ((requisition_type = 'New headcount' AND time_to_fill_days > 30)
       OR (requisition_type = 'Backfill' AND time_to_fill_days > 45))
ORDER BY time_to_fill_days DESC, requisition_id;

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

-- [hr-r8-phu-cap-di-lai-sales-thieu-nguoi] starter
SELECT employee_id, snapshot_month, job_family, work_model, business_travel_days
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND job_family LIKE 'Sales%'
  AND work_model IN ('Remote', 'Hybrid')
  AND snapshot_month >= '2025-10'
  AND business_travel_days > 9
ORDER BY snapshot_month, employee_id;

-- [hr-r8-phu-cap-di-lai-sales-thieu-nguoi] solution
SELECT employee_id, snapshot_month, job_family, work_model, business_travel_days
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND department = 'Sales'
  AND work_model IN ('Remote', 'Hybrid')
  AND snapshot_month >= '2025-10' AND snapshot_month <= '2025-12'
  AND business_travel_days >= 9
ORDER BY snapshot_month, employee_id;

-- [hr-r8-phu-cap-di-lai-sales-thieu-nguoi] wrong: quen_can_tren
-- Rớt ở hidden-1: biến thể có dòng '2026-01' của E00002 (Account Executive, làm từ xa, 9 ngày công tác).
SELECT employee_id, snapshot_month, job_family, work_model, business_travel_days
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND department = 'Sales'
  AND work_model IN ('Remote', 'Hybrid')
  AND snapshot_month >= '2025-10'
  AND business_travel_days >= 9
ORDER BY snapshot_month, employee_id;

-- [hr-r8-phu-cap-di-lai-sales-thieu-nguoi] wrong: giu_lon_hon_9
-- Rớt ở public: bỏ những tháng có đúng 9 ngày công tác.
SELECT employee_id, snapshot_month, job_family, work_model, business_travel_days
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND department = 'Sales'
  AND work_model IN ('Remote', 'Hybrid')
  AND snapshot_month >= '2025-10' AND snapshot_month <= '2025-12'
  AND business_travel_days > 9
ORDER BY snapshot_month, employee_id;

-- [hr-r8-phu-cap-di-lai-sales-thieu-nguoi] wrong: like_hai_dau_van_thieu
-- Rớt ở public: '%Sales%' lấy thêm Country Sales Lead nhưng vẫn thiếu Account Executive.
SELECT employee_id, snapshot_month, job_family, work_model, business_travel_days
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND job_family LIKE '%Sales%'
  AND work_model IN ('Remote', 'Hybrid')
  AND snapshot_month >= '2025-10' AND snapshot_month <= '2025-12'
  AND business_travel_days >= 9
ORDER BY snapshot_month, employee_id;

-- [hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu] starter
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND city = 'Ho Chi Minh City'
  AND engagement_score < 40
   OR manager_effectiveness_score < 55;

-- [hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu] solution
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND city = 'Ho Chi Minh City'
  AND (engagement_score < 40 OR manager_effectiveness_score < 55);

-- [hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu] wrong: doi_or_thanh_and
-- Rớt ở public: chỉ đếm người thoả cả hai điều kiện.
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND city = 'Ho Chi Minh City'
  AND engagement_score < 40
  AND manager_effectiveness_score < 55;

-- [hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu] wrong: loc_theo_nuoc
-- Rớt ở public: Việt Nam có hai thành phố, lọc theo nước lấy cả Hà Nội.
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND country = 'Vietnam'
  AND (engagement_score < 40 OR manager_effectiveness_score < 55);

-- [hr-r9-tp-hcm-can-tro-chuyen-qua-nhieu] wrong: nhan_ca_nguong
-- Rớt ở public: người đúng 40 điểm gắn kết hoặc đúng 55 điểm năng lực quản lý không thuộc nhóm.
SELECT COUNT(*) AS so_nguoi
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
  AND city = 'Ho Chi Minh City'
  AND (engagement_score <= 40 OR manager_effectiveness_score <= 55);

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

-- [hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4] solution
SELECT COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi_tu_nguyen,
       ROUND(COUNT(*) / 3, 2) AS quan_so_bq,
       ROUND(100 * 4 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(*) / 3), 2) AS ty_le_quy_nam_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-10' AND snapshot_month <= '2025-12';

-- [hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4] wrong: mau_so_la_so_dong
-- Rớt ở public: số dòng của ba tháng gấp ba quân số bình quân.
SELECT COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi_tu_nguyen,
       COUNT(*) AS quan_so_bq,
       ROUND(100 * 4 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / COUNT(*), 2) AS ty_le_quy_nam_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-10' AND snapshot_month <= '2025-12';

-- [hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4] wrong: quen_quy_nam
-- Rớt ở public: tỷ lệ của ba tháng chưa nhân 4 nên không so được với mục tiêu năm.
SELECT COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi_tu_nguyen,
       ROUND(COUNT(*) / 3, 2) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(*) / 3), 2) AS ty_le_quy_nam_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-10' AND snapshot_month <= '2025-12';

-- [hr-n4-ty-le-nghi-tu-nguyen-quy-nam-q4] wrong: thieu_can_tren
-- Rớt ở hidden-1: biến thể có dòng '2026-01' của E00002, quân số bình quân lệch.
SELECT COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nguoi_nghi_tu_nguyen,
       ROUND(COUNT(*) / 3, 2) AS quan_so_bq,
       ROUND(100 * 4 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END)
             / (COUNT(*) / 3), 2) AS ty_le_quy_nam_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-10';

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

-- [hr-n6-phan-loai-thieu-nguoi-2025] solution
SELECT CASE WHEN actual_headcount = 0 THEN 'chua_co_nguoi'
            WHEN vacancy_count >= 2
              OR 100 * vacancy_count / planned_headcount >= 10 THEN 'thieu_nhieu'
            WHEN vacancy_count > 0 THEN 'thieu_it'
            ELSE 'du_nguoi' END AS nhom_thieu_nguoi,
       COUNT(*) AS so_vi_tri,
       SUM(vacancy_count) AS tong_cho_trong
FROM position_plan
WHERE plan_period = 2025
GROUP BY nhom_thieu_nguoi
ORDER BY nhom_thieu_nguoi;

-- [hr-n6-phan-loai-thieu-nguoi-2025] wrong: xet_chua_co_nguoi_sau
-- Rớt ở hidden-1: P0901 chưa có ai nhưng thiếu 2 người, bị xếp vào thiếu nhiều.
SELECT CASE WHEN vacancy_count >= 2
              OR 100 * vacancy_count / planned_headcount >= 10 THEN 'thieu_nhieu'
            WHEN actual_headcount = 0 THEN 'chua_co_nguoi'
            WHEN vacancy_count > 0 THEN 'thieu_it'
            ELSE 'du_nguoi' END AS nhom_thieu_nguoi,
       COUNT(*) AS so_vi_tri,
       SUM(vacancy_count) AS tong_cho_trong
FROM position_plan
WHERE plan_period = 2025
GROUP BY nhom_thieu_nguoi
ORDER BY nhom_thieu_nguoi;

-- [hr-n6-phan-loai-thieu-nguoi-2025] wrong: tren_10_phan_tram
-- Rớt ở public: vị trí thiếu đúng 10% định biên phải thuộc thiếu nhiều.
SELECT CASE WHEN actual_headcount = 0 THEN 'chua_co_nguoi'
            WHEN vacancy_count >= 2
              OR 100 * vacancy_count / planned_headcount > 10 THEN 'thieu_nhieu'
            WHEN vacancy_count > 0 THEN 'thieu_it'
            ELSE 'du_nguoi' END AS nhom_thieu_nguoi,
       COUNT(*) AS so_vi_tri,
       SUM(vacancy_count) AS tong_cho_trong
FROM position_plan
WHERE plan_period = 2025
GROUP BY nhom_thieu_nguoi
ORDER BY nhom_thieu_nguoi;

-- [hr-n6-phan-loai-thieu-nguoi-2025] wrong: so_ty_so_voi_10
-- Rớt ở public: tỷ số chưa nhân 100 không bao giờ đạt 10, chỉ còn điều kiện thiếu từ 2 người.
SELECT CASE WHEN actual_headcount = 0 THEN 'chua_co_nguoi'
            WHEN vacancy_count >= 2
              OR vacancy_count / planned_headcount >= 10 THEN 'thieu_nhieu'
            WHEN vacancy_count > 0 THEN 'thieu_it'
            ELSE 'du_nguoi' END AS nhom_thieu_nguoi,
       COUNT(*) AS so_vi_tri,
       SUM(vacancy_count) AS tong_cho_trong
FROM position_plan
WHERE plan_period = 2025
GROUP BY nhom_thieu_nguoi
ORDER BY nhom_thieu_nguoi;

-- [hr-n6-phan-loai-thieu-nguoi-2025] wrong: quen_nam_ke_hoach
-- Rớt ở public: lấy cả vị trí của năm kế hoạch 2024.
SELECT CASE WHEN actual_headcount = 0 THEN 'chua_co_nguoi'
            WHEN vacancy_count >= 2
              OR 100 * vacancy_count / planned_headcount >= 10 THEN 'thieu_nhieu'
            WHEN vacancy_count > 0 THEN 'thieu_it'
            ELSE 'du_nguoi' END AS nhom_thieu_nguoi,
       COUNT(*) AS so_vi_tri,
       SUM(vacancy_count) AS tong_cho_trong
FROM position_plan
GROUP BY nhom_thieu_nguoi
ORDER BY nhom_thieu_nguoi;

-- [hr-n7-ty-le-chua-dao-tao-cao] starter
SELECT COUNT(CASE WHEN COALESCE(training_hours_6m, 0) = 0 THEN 1 END) AS so_nguoi_0_gio,
       ROUND(100 * COUNT(CASE WHEN COALESCE(training_hours_6m, 0) = 0 THEN 1 END)
             / COUNT(*), 2) AS ty_le_chua_dao_tao_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-n7-ty-le-chua-dao-tao-cao] solution
SELECT COUNT(CASE WHEN training_hours_6m = 0 THEN 1 END) AS so_nguoi_0_gio,
       ROUND(100 * COUNT(CASE WHEN training_hours_6m = 0 THEN 1 END)
             / COUNT(training_hours_6m), 2) AS ty_le_chua_dao_tao_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-n7-ty-le-chua-dao-tao-cao] wrong: chi_sua_tu_so
-- Rớt ở public: mẫu số COUNT(*) vẫn đếm cả người thiếu dữ liệu đào tạo.
SELECT COUNT(CASE WHEN training_hours_6m = 0 THEN 1 END) AS so_nguoi_0_gio,
       ROUND(100 * COUNT(CASE WHEN training_hours_6m = 0 THEN 1 END)
             / COUNT(*), 2) AS ty_le_chua_dao_tao_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

-- [hr-n7-ty-le-chua-dao-tao-cao] wrong: chi_sua_mau_so
-- Rớt ở public: tử số vẫn coi người thiếu dữ liệu là 0 giờ.
SELECT COUNT(CASE WHEN COALESCE(training_hours_6m, 0) = 0 THEN 1 END) AS so_nguoi_0_gio,
       ROUND(100 * COUNT(CASE WHEN COALESCE(training_hours_6m, 0) = 0 THEN 1 END)
             / COUNT(training_hours_6m), 2) AS ty_le_chua_dao_tao_pct
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12';

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

-- [hr-n9-tien-lam-them-quy-4-lech] starter
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(ROUND(monthly_salary_usd / 176, 0) * 0.5 * overtime_hours), 2)
         AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month >= '2025-10';

-- [hr-n9-tien-lam-them-quy-4-lech] solution
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(monthly_salary_usd / 176 * 1.5 * overtime_hours), 2) AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month >= '2025-10' AND snapshot_month <= '2025-12';

-- [hr-n9-tien-lam-them-quy-4-lech] wrong: quen_can_tren
-- Rớt ở hidden-1: biến thể có dòng '2026-01' của E00002 ở Việt Nam, 8 giờ làm thêm.
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(monthly_salary_usd / 176 * 1.5 * overtime_hours), 2) AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month >= '2025-10';

-- [hr-n9-tien-lam-them-quy-4-lech] wrong: giu_lam_tron_som
-- Rớt ở public: làm tròn tiền lương giờ trước khi nhân làm tổng lệch hàng trăm USD.
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(ROUND(monthly_salary_usd / 176, 0) * 1.5 * overtime_hours), 2)
         AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month >= '2025-10' AND snapshot_month <= '2025-12';

-- [hr-n9-tien-lam-them-quy-4-lech] wrong: chi_tinh_phan_cong_them
-- Rớt ở public: 150% là cả tiền lương giờ lẫn phần cộng thêm, không phải riêng 50%.
SELECT SUM(overtime_hours) AS tong_gio_lam_them,
       ROUND(SUM(monthly_salary_usd / 176 * 0.5 * overtime_hours), 2) AS tien_lam_them_usd
FROM employee_monthly_snapshot
WHERE country = 'Vietnam'
  AND snapshot_month >= '2025-10' AND snapshot_month <= '2025-12';

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
