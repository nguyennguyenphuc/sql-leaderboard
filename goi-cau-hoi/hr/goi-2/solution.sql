-- solution.sql: gói 2 bộ HR Analytics (hr) · Module 3 String & Date, Module 4 Aggregation, case c3, c4.
-- Cú pháp MySQL 8.0, chỉ SELECT hoặc WITH. Chấm trên hr (public) và hr_hidden_1 (hidden-1).

-- ================================================================ MODULE 3 · STRING & DATE

-- [hr-s1-lam-them-quy-so-cung-ky] solution
SELECT CONCAT('Q', QUARTER(CONCAT(snapshot_month, '-01'))) AS quy,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END), 2) AS gio_lam_them_bq_2024,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours END), 2) AS gio_lam_them_bq_2025,
       ROUND(100 * (AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours END)
                    - AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END))
                 / AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END), 2) AS thay_doi_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY quy
ORDER BY quy;

-- [hr-s1-lam-them-quy-so-cung-ky] wrong: quarter_tren_chuoi
-- snapshot_month là chuỗi 'YYYY-MM', QUARTER() trả NULL nên mọi dòng dồn vào một nhóm NULL.
SELECT CONCAT('Q', QUARTER(snapshot_month)) AS quy,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END), 2) AS gio_lam_them_bq_2024,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours END), 2) AS gio_lam_them_bq_2025,
       ROUND(100 * (AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours END)
                    - AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END))
                 / AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END), 2) AS thay_doi_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY quy
ORDER BY quy;

-- [hr-s1-lam-them-quy-so-cung-ky] wrong: else_0_trong_avg
-- ELSE 0 biến dòng của năm kia thành 0 giờ, nên mỗi bình quân chỉ còn khoảng một nửa.
SELECT CONCAT('Q', QUARTER(CONCAT(snapshot_month, '-01'))) AS quy,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours ELSE 0 END), 2) AS gio_lam_them_bq_2024,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours ELSE 0 END), 2) AS gio_lam_them_bq_2025,
       ROUND(100 * (AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours ELSE 0 END)
                    - AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours ELSE 0 END))
                 / AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours ELSE 0 END), 2) AS thay_doi_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY quy
ORDER BY quy;

-- [hr-s1-lam-them-quy-so-cung-ky] wrong: nhan_quy_kem_nam
-- Nhãn quý kèm năm ('2024-Q1') tách hai năm ra hai dòng: mỗi dòng chỉ có một cột năm có số, cột còn lại NULL.
SELECT CONCAT(LEFT(snapshot_month, 4), '-Q', QUARTER(CONCAT(snapshot_month, '-01'))) AS quy,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END), 2) AS gio_lam_them_bq_2024,
       ROUND(AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours END), 2) AS gio_lam_them_bq_2025,
       ROUND(100 * (AVG(CASE WHEN LEFT(snapshot_month, 4) = '2025' THEN overtime_hours END)
                    - AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END))
                 / AVG(CASE WHEN LEFT(snapshot_month, 4) = '2024' THEN overtime_hours END), 2) AS thay_doi_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY quy
ORDER BY quy;

-- [hr-s2-nhan-viec-thu-hai] solution
SELECT requisition_id, department, job_role, start_date
FROM recruiting_pipeline
WHERE country = 'Vietnam'
  AND start_date >= '2025-01-01' AND start_date < '2026-01-01'
  AND DAYOFWEEK(start_date) = 2
ORDER BY start_date, requisition_id;

-- [hr-s2-nhan-viec-thu-hai] wrong: dung_weekday
-- WEEKDAY đánh số 0 là thứ Hai, nên WEEKDAY = 2 là thứ Tư.
SELECT requisition_id, department, job_role, start_date
FROM recruiting_pipeline
WHERE country = 'Vietnam'
  AND start_date >= '2025-01-01' AND start_date < '2026-01-01'
  AND WEEKDAY(start_date) = 2
ORDER BY start_date, requisition_id;

-- [hr-s2-nhan-viec-thu-hai] wrong: quen_can_tren
-- start_date có ngày tới tháng 4/2026, thiếu cận trên lấy cả thứ Hai năm 2026.
SELECT requisition_id, department, job_role, start_date
FROM recruiting_pipeline
WHERE country = 'Vietnam'
  AND start_date >= '2025-01-01'
  AND DAYOFWEEK(start_date) = 2
ORDER BY start_date, requisition_id;

-- [hr-s3-cho-hoi-nhap-thu-hai] solution
SELECT country, COUNT(*) AS so_nguoi_moi,
       COUNT(CASE WHEN WEEKDAY(start_date) <> 0 THEN 1 END) AS so_phai_cho,
       ROUND(AVG(CASE WHEN WEEKDAY(start_date) <> 0 THEN 7 - WEEKDAY(start_date) END), 2) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY country;

-- [hr-s3-cho-hoi-nhap-thu-hai] wrong: dung_dayofweek_nhu_weekday
-- Dùng DAYOFWEEK với cách đánh số của WEEKDAY: DAYOFWEEK không bao giờ bằng 0 (thứ Hai là 2),
-- nên mọi người đều bị tính là phải chờ và số ngày chờ lệch theo thứ.
SELECT country, COUNT(*) AS so_nguoi_moi,
       COUNT(CASE WHEN DAYOFWEEK(start_date) <> 0 THEN 1 END) AS so_phai_cho,
       ROUND(AVG(CASE WHEN DAYOFWEEK(start_date) <> 0 THEN 7 - DAYOFWEEK(start_date) END), 2) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY country;

-- [hr-s3-cho-hoi-nhap-thu-hai] wrong: thu_hai_cho_7_ngay
-- 7 - WEEKDAY() cho người đi làm thứ Hai ra 7 ngày, và mọi người đều bị tính là phải chờ.
SELECT country, COUNT(*) AS so_nguoi_moi,
       COUNT(*) AS so_phai_cho,
       ROUND(AVG(7 - WEEKDAY(start_date)), 2) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY country;

-- [hr-s3-cho-hoi-nhap-thu-hai] wrong: binh_quan_gom_nguoi_khong_cho
-- Số ngày chờ đúng, nhưng bình quân trên mọi người mới, kể cả người đi làm đúng thứ Hai (chờ 0 ngày).
SELECT country, COUNT(*) AS so_nguoi_moi,
       COUNT(CASE WHEN WEEKDAY(start_date) <> 0 THEN 1 END) AS so_phai_cho,
       ROUND(AVG(MOD(7 - WEEKDAY(start_date), 7)), 2) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY country;

-- [hr-s3-cho-hoi-nhap-thu-hai] wrong: quen_can_tren
-- Rớt ở hidden-1: R0801 (Indonesia, duyệt 2026-01-05, đi làm thứ Ba 2026-03-10) lọt vào.
SELECT country, COUNT(*) AS so_nguoi_moi,
       COUNT(CASE WHEN WEEKDAY(start_date) <> 0 THEN 1 END) AS so_phai_cho,
       ROUND(AVG(CASE WHEN WEEKDAY(start_date) <> 0 THEN 7 - WEEKDAY(start_date) END), 2) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01'
GROUP BY country
ORDER BY country;

-- [hr-s4-cho-nhan-viec] solution
SELECT country, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(DATEDIFF(start_date, offer_accept_date)), 1) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY so_ngay_cho_bq DESC, country;

-- [hr-s4-cho-nhan-viec] wrong: dao_thu_tu_datediff
-- DATEDIFF(a, b) = a - b; đảo hai đối số ra số âm và đảo cả thứ tự sắp.
SELECT country, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(DATEDIFF(offer_accept_date, start_date)), 1) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY so_ngay_cho_bq DESC, country;

-- [hr-s4-cho-nhan-viec] wrong: tinh_tu_ngay_duyet
-- Tính từ ngày duyệt tới ngày đi làm là cả thời gian tuyển cộng thời gian chờ.
SELECT country, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(DATEDIFF(start_date, approval_date)), 1) AS so_ngay_cho_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY country
ORDER BY so_ngay_cho_bq DESC, country;

-- [hr-s5-y-dinh-o-lai-thap-2025] solution
SELECT employee_id, survey_quarter, intent_to_stay, eNPS,
       CONCAT(LEFT(survey_quarter, 4), '-',
              LPAD(CAST(RIGHT(survey_quarter, 1) AS UNSIGNED) * 3 - 2, 2, '0')) AS thang_dau_quy
FROM engagement_survey
WHERE survey_quarter >= '2025-Q1' AND survey_quarter <= '2025-Q4'
  AND intent_to_stay = 1 AND eNPS <= 2
ORDER BY survey_quarter, employee_id;

-- [hr-s5-y-dinh-o-lai-thap-2025] wrong: thieu_so_0
-- Ghép số tháng không đệm số 0 ra '2025-7', không khớp dạng 'YYYY-MM' của snapshot_month.
SELECT employee_id, survey_quarter, intent_to_stay, eNPS,
       CONCAT(LEFT(survey_quarter, 4), '-',
              CAST(RIGHT(survey_quarter, 1) AS UNSIGNED) * 3 - 2) AS thang_dau_quy
FROM engagement_survey
WHERE survey_quarter >= '2025-Q1' AND survey_quarter <= '2025-Q4'
  AND intent_to_stay = 1 AND eNPS <= 2
ORDER BY survey_quarter, employee_id;

-- [hr-s5-y-dinh-o-lai-thap-2025] wrong: lay_thang_cuoi_quy
-- Nhân số quý với 3 cho tháng cuối quý, không phải tháng đầu quý.
SELECT employee_id, survey_quarter, intent_to_stay, eNPS,
       CONCAT(LEFT(survey_quarter, 4), '-',
              LPAD(CAST(RIGHT(survey_quarter, 1) AS UNSIGNED) * 3, 2, '0')) AS thang_dau_quy
FROM engagement_survey
WHERE survey_quarter >= '2025-Q1' AND survey_quarter <= '2025-Q4'
  AND intent_to_stay = 1 AND eNPS <= 2
ORDER BY survey_quarter, employee_id;

-- [hr-s5-y-dinh-o-lai-thap-2025] wrong: go_cung_thang
-- Gõ cứng tháng '-07' chỉ đúng cho quý 3.
SELECT employee_id, survey_quarter, intent_to_stay, eNPS,
       CONCAT(LEFT(survey_quarter, 4), '-07') AS thang_dau_quy
FROM engagement_survey
WHERE survey_quarter >= '2025-Q1' AND survey_quarter <= '2025-Q4'
  AND intent_to_stay = 1 AND eNPS <= 2
ORDER BY survey_quarter, employee_id;

-- [hr-s6-cong-tac-truong-nhom-sales] solution
SELECT CASE WHEN job_family LIKE '%Lead%' THEN 'Truong nhom' ELSE 'Nhan vien' END AS vai_tro,
       COUNT(*) AS so_dong,
       ROUND(AVG(business_travel_days), 2) AS ngay_cong_tac_bq
FROM employee_monthly_snapshot
WHERE department = 'Sales'
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY vai_tro
ORDER BY vai_tro;

-- [hr-s6-cong-tac-truong-nhom-sales] wrong: like_thieu_phan_tram
-- LIKE 'Lead' chỉ khớp chuỗi đúng bằng 'Lead', nên không ai là trưởng nhóm.
SELECT CASE WHEN job_family LIKE 'Lead' THEN 'Truong nhom' ELSE 'Nhan vien' END AS vai_tro,
       COUNT(*) AS so_dong,
       ROUND(AVG(business_travel_days), 2) AS ngay_cong_tac_bq
FROM employee_monthly_snapshot
WHERE department = 'Sales'
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY vai_tro
ORDER BY vai_tro;

-- [hr-s6-cong-tac-truong-nhom-sales] wrong: quen_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 (phòng Sales) lọt vào nhóm 'Nhan vien'.
SELECT CASE WHEN job_family LIKE '%Lead%' THEN 'Truong nhom' ELSE 'Nhan vien' END AS vai_tro,
       COUNT(*) AS so_dong,
       ROUND(AVG(business_travel_days), 2) AS ngay_cong_tac_bq
FROM employee_monthly_snapshot
WHERE department = 'Sales'
  AND snapshot_month >= '2025-01'
GROUP BY vai_tro
ORDER BY vai_tro;

-- [hr-s7-quy-luong-nam-lech-ke-toan] starter
SELECT LEFT(snapshot_month, 4) AS nam,
       SUM(monthly_salary_usd) AS quy_luong_nam,
       ROUND(SUM(monthly_salary_usd) / COUNT(DISTINCT snapshot_month), 0) AS quy_luong_bq_thang
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2024-01-01' AND '2025-12-31'
GROUP BY LEFT(snapshot_month, 4)
ORDER BY nam;

-- [hr-s7-quy-luong-nam-lech-ke-toan] solution
SELECT LEFT(snapshot_month, 4) AS nam,
       SUM(monthly_salary_usd) AS quy_luong_nam,
       ROUND(SUM(monthly_salary_usd) / COUNT(DISTINCT snapshot_month), 0) AS quy_luong_bq_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY LEFT(snapshot_month, 4)
ORDER BY nam;

-- [hr-s7-quy-luong-nam-lech-ke-toan] wrong: bo_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 tạo thêm dòng năm 2026.
SELECT LEFT(snapshot_month, 4) AS nam,
       SUM(monthly_salary_usd) AS quy_luong_nam,
       ROUND(SUM(monthly_salary_usd) / COUNT(DISTINCT snapshot_month), 0) AS quy_luong_bq_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01'
GROUP BY LEFT(snapshot_month, 4)
ORDER BY nam;

-- [hr-s7-quy-luong-nam-lech-ke-toan] wrong: giu_moc_cu_chia_12
-- Chỉ đổi mẫu số sang 12: quỹ lương năm 2024 vẫn thiếu tháng 1.
SELECT LEFT(snapshot_month, 4) AS nam,
       SUM(monthly_salary_usd) AS quy_luong_nam,
       ROUND(SUM(monthly_salary_usd) / 12, 0) AS quy_luong_bq_thang
FROM employee_monthly_snapshot
WHERE snapshot_month BETWEEN '2024-01-01' AND '2025-12-31'
GROUP BY LEFT(snapshot_month, 4)
ORDER BY nam;

-- [hr-s7-quy-luong-nam-lech-ke-toan] wrong: dung_year_tren_chuoi
-- Sửa mốc lọc nhưng lấy năm bằng YEAR() trên chuỗi 'YYYY-MM' ra NULL.
SELECT YEAR(snapshot_month) AS nam,
       SUM(monthly_salary_usd) AS quy_luong_nam,
       ROUND(SUM(monthly_salary_usd) / COUNT(DISTINCT snapshot_month), 0) AS quy_luong_bq_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-01' AND snapshot_month <= '2025-12'
GROUP BY YEAR(snapshot_month)
ORDER BY nam;

-- [hr-s8-quy-4-thieu-thang-12] starter
SELECT DATE_FORMAT(approval_date, '%Y-%m') AS thang, COUNT(*) AS so_yeu_cau
FROM recruiting_pipeline
WHERE approval_date BETWEEN '2025-10-01' AND '2025-12-01'
GROUP BY thang
ORDER BY thang;

-- [hr-s8-quy-4-thieu-thang-12] solution
SELECT DATE_FORMAT(approval_date, '%Y-%m') AS thang, COUNT(*) AS so_yeu_cau
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01' AND approval_date < '2026-01-01'
GROUP BY thang
ORDER BY thang;

-- [hr-s8-quy-4-thieu-thang-12] wrong: bo_han_can_tren
-- Bỏ hẳn cận trên: rớt ở hidden-1 (R0801 duyệt ngày 2026-01-05 tạo thêm tháng '2026-01').
SELECT DATE_FORMAT(approval_date, '%Y-%m') AS thang, COUNT(*) AS so_yeu_cau
FROM recruiting_pipeline
WHERE approval_date >= '2025-10-01'
GROUP BY thang
ORDER BY thang;

-- [hr-s9-quan-so-cuoi-thang-lech] starter
SELECT DATE_FORMAT(CONCAT(snapshot_month, '-01'), '%Y-%c') AS thang,
       COUNT(*) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-07'
GROUP BY thang
ORDER BY thang;

-- [hr-s9-quan-so-cuoi-thang-lech] solution
SELECT DATE_FORMAT(CONCAT(snapshot_month, '-01'), '%Y-%c') AS thang,
       COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-07' AND snapshot_month <= '2025-12'
GROUP BY snapshot_month
ORDER BY snapshot_month;

-- [hr-s9-quan-so-cuoi-thang-lech] wrong: chi_sua_thu_tu
-- Sắp đúng nhưng còn đếm cả người nghỉ trong tháng và thiếu cận trên.
SELECT DATE_FORMAT(CONCAT(snapshot_month, '-01'), '%Y-%c') AS thang,
       COUNT(*) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-07'
GROUP BY snapshot_month
ORDER BY snapshot_month;

-- [hr-s9-quan-so-cuoi-thang-lech] wrong: sua_hai_loi_thieu_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 tạo thêm tháng '2026-1'.
SELECT DATE_FORMAT(CONCAT(snapshot_month, '-01'), '%Y-%c') AS thang,
       COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-07'
GROUP BY snapshot_month
ORDER BY snapshot_month;

-- [hr-s9-quan-so-cuoi-thang-lech] wrong: sap_theo_do_dai_nhan
-- Sắp theo độ dài nhãn rồi theo nhãn: tháng một chữ số của cả hai năm đứng trước tháng 10, 11, 12.
SELECT DATE_FORMAT(CONCAT(snapshot_month, '-01'), '%Y-%c') AS thang,
       COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-07' AND snapshot_month <= '2025-12'
GROUP BY thang
ORDER BY LENGTH(thang), thang;

-- [hr-s9-quan-so-cuoi-thang-lech] wrong: doi_nhan_hai_chu_so
-- Đổi nhãn sang '2024-07' thì sắp đúng, nhưng cột thang không còn dạng '2024-7' như yêu cầu.
SELECT DATE_FORMAT(CONCAT(snapshot_month, '-01'), '%Y-%m') AS thang,
       COUNT(*) - SUM(attrition_this_month) AS quan_so_cuoi_thang
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2024-07' AND snapshot_month <= '2025-12'
GROUP BY thang
ORDER BY thang;

-- ================================================================ MODULE 4 · AGGREGATION

-- [hr-a1-nghi-theo-ly-do-2025] solution
SELECT attrition_reason, COUNT(*) AS so_nguoi_nghi
FROM employee_monthly_snapshot
WHERE attrition_type = 'Voluntary'
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY attrition_reason
ORDER BY so_nguoi_nghi DESC, attrition_reason;

-- [hr-a1-nghi-theo-ly-do-2025] wrong: gop_moi_loai_nghi
-- Lọc tháng nghỉ thay vì loại nghỉ: lẫn nghỉ hưu và chấm dứt hợp đồng.
SELECT attrition_reason, COUNT(*) AS so_nguoi_nghi
FROM employee_monthly_snapshot
WHERE attrition_this_month = 1
  AND snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY attrition_reason
ORDER BY so_nguoi_nghi DESC, attrition_reason;

-- [hr-a1-nghi-theo-ly-do-2025] wrong: quen_loc_nam
SELECT attrition_reason, COUNT(*) AS so_nguoi_nghi
FROM employee_monthly_snapshot
WHERE attrition_type = 'Voluntary'
GROUP BY attrition_reason
ORDER BY so_nguoi_nghi DESC, attrition_reason;

-- [hr-a2-luong-theo-bac] solution
SELECT job_level, COUNT(*) AS so_nhan_vien,
       ROUND(AVG(monthly_salary_usd), 0) AS luong_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY job_level
ORDER BY job_level;

-- [hr-a2-luong-theo-bac] wrong: quen_loc_thang
-- Trộn 24 tháng: đếm dòng thay người, lương bình quân lẫn mức lương cũ.
SELECT job_level, COUNT(*) AS so_nhan_vien,
       ROUND(AVG(monthly_salary_usd), 0) AS luong_bq
FROM employee_monthly_snapshot
GROUP BY job_level
ORDER BY job_level;

-- [hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu] solution
SELECT job_family,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Voluntary' AND high_performer_flag = 1 THEN 1 END) AS so_nghi_ket_qua_cao,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 12), 2) AS ty_le_nghi_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY job_family
ORDER BY so_nghi_tu_nguyen DESC, job_family
LIMIT 3;

-- [hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu] wrong: dem_moi_loai_nghi
-- Cờ nghỉ gồm cả nghỉ hưu, chấm dứt hợp đồng: thứ hạng đổi (Backend Engineer lên hạng 3 ở public).
SELECT job_family,
       SUM(attrition_this_month) AS so_nghi_tu_nguyen,
       COUNT(CASE WHEN attrition_this_month = 1 AND high_performer_flag = 1 THEN 1 END) AS so_nghi_ket_qua_cao,
       ROUND(100 * SUM(attrition_this_month) / (COUNT(*) / 12), 2) AS ty_le_nghi_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY job_family
ORDER BY so_nghi_tu_nguyen DESC, job_family
LIMIT 3;

-- [hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu] wrong: mau_so_dem_nguoi
-- Mẫu số đếm mọi người từng có tên trong năm, lớn hơn quân số bình quân.
SELECT job_family,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Voluntary' AND high_performer_flag = 1 THEN 1 END) AS so_nghi_ket_qua_cao,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / COUNT(DISTINCT employee_id), 2) AS ty_le_nghi_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY job_family
ORDER BY so_nghi_tu_nguyen DESC, job_family
LIMIT 3;

-- [hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu] wrong: dung_diem_danh_gia
-- Dùng performance_rating = 4 thay cờ: bỏ sót người có cờ bằng 1 mà điểm đánh giá trống.
SELECT job_family,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Voluntary' AND performance_rating = 4 THEN 1 END) AS so_nghi_ket_qua_cao,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 12), 2) AS ty_le_nghi_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY job_family
ORDER BY so_nghi_tu_nguyen DESC, job_family
LIMIT 3;

-- [hr-a3-nhom-chuc-danh-nghi-tu-nguyen-nhieu] wrong: hoa_xep_nguoc
-- Rớt ở hidden-1: Backend Engineer và Support Specialist hoà ở hạng 3; xếp job_family giảm dần chọn nhầm nhóm.
SELECT job_family,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       COUNT(CASE WHEN attrition_type = 'Voluntary' AND high_performer_flag = 1 THEN 1 END) AS so_nghi_ket_qua_cao,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 12), 2) AS ty_le_nghi_tu_nguyen_pct
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY job_family
ORDER BY so_nghi_tu_nguyen DESC, job_family DESC
LIMIT 3;

-- [hr-a4-phong-compa-thap] solution
SELECT country, department, COUNT(*) AS so_nhan_vien,
       ROUND(AVG(compa_ratio), 3) AS compa_ratio_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY country, department
HAVING AVG(compa_ratio) < 0.9
ORDER BY compa_ratio_bq, country, department;

-- [hr-a4-phong-compa-thap] wrong: loc_dong_bang_where
-- Lọc từng người có compa-ratio dưới 0,9 rồi mới lấy bình quân: sai tập nhóm và sai giá trị.
SELECT country, department, COUNT(*) AS so_nhan_vien,
       ROUND(AVG(compa_ratio), 3) AS compa_ratio_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12' AND compa_ratio < 0.9
GROUP BY country, department
ORDER BY compa_ratio_bq, country, department;

-- [hr-a4-phong-compa-thap] wrong: chi_theo_phong_ban
-- Gom theo phòng ban toàn công ty: mức thấp của một nước bị nước khác bù lại.
SELECT 'Tất cả' AS country, department, COUNT(*) AS so_nhan_vien,
       ROUND(AVG(compa_ratio), 3) AS compa_ratio_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
HAVING AVG(compa_ratio) < 0.9
ORDER BY compa_ratio_bq, department;

-- [hr-a5-chi-phi-thoi-gian-tuyen] solution
SELECT requisition_type, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY requisition_type
ORDER BY requisition_type;

-- [hr-a5-chi-phi-thoi-gian-tuyen] wrong: quen_can_tren
-- Rớt ở hidden-1: R0801 (tuyển mới, duyệt 2026-01-05) lọt vào nhóm 'New headcount'.
SELECT requisition_type, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01'
GROUP BY requisition_type
ORDER BY requisition_type;

-- [hr-a5-chi-phi-thoi-gian-tuyen] wrong: loc_theo_ngay_di_lam
-- Lọc năm theo ngày bắt đầu làm việc thay vì ngày duyệt: đổi tập yêu cầu.
SELECT requisition_type, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq
FROM recruiting_pipeline
WHERE start_date >= '2025-01-01' AND start_date < '2026-01-01'
GROUP BY requisition_type
ORDER BY requisition_type;

-- [hr-a6-enps-theo-quy] solution
SELECT survey_quarter, COUNT(*) AS so_phieu,
       ROUND(100 * SUM(CASE WHEN eNPS >= 9 THEN 1 ELSE 0 END) / COUNT(*)
           - 100 * SUM(CASE WHEN eNPS <= 6 THEN 1 ELSE 0 END) / COUNT(*), 2) AS enps
FROM engagement_survey
WHERE survey_quarter >= '2024-Q1' AND survey_quarter <= '2025-Q4'
GROUP BY survey_quarter
ORDER BY survey_quarter;

-- [hr-a6-enps-theo-quy] wrong: tinh_trung_lap_la_phan_doi
-- Xếp người 7-8 điểm vào nhóm phản đối.
SELECT survey_quarter, COUNT(*) AS so_phieu,
       ROUND(100 * SUM(CASE WHEN eNPS >= 9 THEN 1 ELSE 0 END) / COUNT(*)
           - 100 * SUM(CASE WHEN eNPS <= 8 THEN 1 ELSE 0 END) / COUNT(*), 2) AS enps
FROM engagement_survey
WHERE survey_quarter >= '2024-Q1' AND survey_quarter <= '2025-Q4'
GROUP BY survey_quarter
ORDER BY survey_quarter;

-- [hr-a6-enps-theo-quy] wrong: quen_can_tren
-- Rớt ở hidden-1: phiếu '2026-Q1' của E00002 tạo thêm một quý.
SELECT survey_quarter, COUNT(*) AS so_phieu,
       ROUND(100 * SUM(CASE WHEN eNPS >= 9 THEN 1 ELSE 0 END) / COUNT(*)
           - 100 * SUM(CASE WHEN eNPS <= 6 THEN 1 ELSE 0 END) / COUNT(*), 2) AS enps
FROM engagement_survey
WHERE survey_quarter >= '2024-Q1'
GROUP BY survey_quarter
ORDER BY survey_quarter;

-- [hr-a7-dem-nguoi-theo-phong-trung] starter
SELECT department, COUNT(*) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-a7-dem-nguoi-theo-phong-trung] solution
SELECT department, COUNT(DISTINCT employee_id) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-a7-dem-nguoi-theo-phong-trung] wrong: chi_dem_thang_12
-- Chỉ đếm người có tên tháng 12: bỏ sót người đã nghỉ trong năm.
SELECT department, COUNT(DISTINCT employee_id) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-a7-dem-nguoi-theo-phong-trung] wrong: chia_cho_12
-- Chia số dòng cho 12 là quân số bình quân, không phải số người từng làm.
SELECT department, ROUND(COUNT(*) / 12, 0) AS so_nhan_vien
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY department
ORDER BY department;

-- [hr-a8-luong-bq-tu-bq-phong] starter
SELECT country, ROUND(AVG(luong_bq_phong), 0) AS luong_bq
FROM (
  SELECT country, department, AVG(monthly_salary_usd) AS luong_bq_phong
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY country, department
) AS t
GROUP BY country
ORDER BY country;

-- [hr-a8-luong-bq-tu-bq-phong] solution
SELECT country, ROUND(AVG(monthly_salary_usd), 0) AS luong_bq
FROM employee_monthly_snapshot
WHERE snapshot_month = '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-a8-luong-bq-tu-bq-phong] wrong: binh_quan_ca_nam
-- Lấy cả 12 tháng năm 2025 thay vì tháng 12/2025: lẫn mức lương trước đề bạt, tăng lương.
SELECT country, ROUND(AVG(monthly_salary_usd), 0) AS luong_bq
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-a8-luong-bq-tu-bq-phong] wrong: binh_quan_theo_bac
-- Đổi nhóm con từ phòng ban sang bậc vẫn là trung bình của trung bình.
SELECT country, ROUND(AVG(luong_bq_bac), 0) AS luong_bq
FROM (
  SELECT country, job_level, AVG(monthly_salary_usd) AS luong_bq_bac
  FROM employee_monthly_snapshot
  WHERE snapshot_month = '2025-12'
  GROUP BY country, job_level
) AS t
GROUP BY country
ORDER BY country;

-- [hr-a9-ty-le-nghi-sales-quy-nam] starter
SELECT country,
       SUM(attrition_this_month) AS so_nghi_tu_nguyen,
       ROUND(COUNT(DISTINCT employee_id), 1) AS quan_so_bq,
       ROUND(100 * SUM(attrition_this_month) / COUNT(DISTINCT employee_id) * 12 / 6, 2) AS ty_le_nghi_tu_nguyen_nam_pct
FROM employee_monthly_snapshot
WHERE department = 'Sales' AND snapshot_month >= '2025-07'
GROUP BY country
ORDER BY country;

-- [hr-a9-ty-le-nghi-sales-quy-nam] solution
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(*) / 6, 1) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 6) * 12 / 6, 2) AS ty_le_nghi_tu_nguyen_nam_pct
FROM employee_monthly_snapshot
WHERE department = 'Sales' AND snapshot_month >= '2025-07' AND snapshot_month <= '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-a9-ty-le-nghi-sales-quy-nam] wrong: chi_sua_loai_nghi
-- Sửa số người nghỉ nhưng giữ mẫu số đếm người và thiếu cận trên.
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(DISTINCT employee_id), 1) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / COUNT(DISTINCT employee_id) * 12 / 6, 2) AS ty_le_nghi_tu_nguyen_nam_pct
FROM employee_monthly_snapshot
WHERE department = 'Sales' AND snapshot_month >= '2025-07'
GROUP BY country
ORDER BY country;

-- [hr-a9-ty-le-nghi-sales-quy-nam] wrong: sua_hai_loi_thieu_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 làm tăng quân số bình quân của Vietnam.
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(*) / 6, 1) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 6) * 12 / 6, 2) AS ty_le_nghi_tu_nguyen_nam_pct
FROM employee_monthly_snapshot
WHERE department = 'Sales' AND snapshot_month >= '2025-07'
GROUP BY country
ORDER BY country;

-- [hr-a9-ty-le-nghi-sales-quy-nam] wrong: khong_quy_nam
-- Đúng số người nghỉ và quân số bình quân, nhưng quên quy tỷ lệ 6 tháng ra năm.
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(*) / 6, 1) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 6), 2) AS ty_le_nghi_tu_nguyen_nam_pct
FROM employee_monthly_snapshot
WHERE department = 'Sales' AND snapshot_month >= '2025-07' AND snapshot_month <= '2025-12'
GROUP BY country
ORDER BY country;

-- [hr-a9-ty-le-nghi-sales-quy-nam] wrong: chia_12_thang
-- Quân số bình quân chia 12 dù kỳ chỉ có 6 tháng.
SELECT country,
       COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) AS so_nghi_tu_nguyen,
       ROUND(COUNT(*) / 12, 1) AS quan_so_bq,
       ROUND(100 * COUNT(CASE WHEN attrition_type = 'Voluntary' THEN 1 END) / (COUNT(*) / 12) * 12 / 6, 2) AS ty_le_nghi_tu_nguyen_nam_pct
FROM employee_monthly_snapshot
WHERE department = 'Sales' AND snapshot_month >= '2025-07' AND snapshot_month <= '2025-12'
GROUP BY country
ORDER BY country;

-- ================================================================ CASE STUDY

-- [hr-c3-lam-them-malaysia.b1] solution
SELECT country, COUNT(*) AS so_dong,
       ROUND(AVG(overtime_hours), 1) AS gio_lam_them_bq,
       MAX(overtime_hours) AS gio_lam_them_max,
       COUNT(CASE WHEN overtime_hours > 40 THEN 1 END) AS so_dong_tren_40
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY country
ORDER BY gio_lam_them_bq DESC, country;

-- [hr-c3-lam-them-malaysia.b1] wrong: quen_can_tren
-- Rớt ở hidden-1: dòng '2026-01' của E00002 làm tăng số dòng của Vietnam.
SELECT country, COUNT(*) AS so_dong,
       ROUND(AVG(overtime_hours), 1) AS gio_lam_them_bq,
       MAX(overtime_hours) AS gio_lam_them_max,
       COUNT(CASE WHEN overtime_hours > 40 THEN 1 END) AS so_dong_tren_40
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01'
GROUP BY country
ORDER BY gio_lam_them_bq DESC, country;

-- [hr-c4-nguon-tuyen-nhanh-re.b1] solution
SELECT COUNT(*) AS so_yeu_cau,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01';

-- [hr-c4-nguon-tuyen-nhanh-re.b1] wrong: quen_can_tren
-- Rớt ở hidden-1: R0801 (duyệt 2026-01-05) cộng thêm một yêu cầu.
SELECT COUNT(*) AS so_yeu_cau,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01';

-- [hr-c4-nguon-tuyen-nhanh-re.b1] wrong: binh_quan_cua_binh_quan_nguon
-- Lấy bình quân của bình quân từng nguồn: nguồn 1 yêu cầu nặng ngang nguồn 100 yêu cầu.
SELECT SUM(n) AS so_yeu_cau,
       ROUND(AVG(ngay), 1) AS so_ngay_tuyen_bq,
       ROUND(AVG(cp), 0) AS chi_phi_bq
FROM (
  SELECT recruitment_source, COUNT(*) AS n, AVG(time_to_fill_days) AS ngay, AVG(recruiting_cost_usd) AS cp
  FROM recruiting_pipeline
  WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
  GROUP BY recruitment_source
) AS t;

-- [hr-c4-nguon-tuyen-nhanh-re.b2] solution
SELECT recruitment_source, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq,
       ROUND(AVG(recruiting_cost_usd), 0) AS chi_phi_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY recruitment_source
ORDER BY chi_phi_bq, recruitment_source;

-- [hr-c4-nguon-tuyen-nhanh-re.b2] wrong: tong_chi_phi
-- Tổng chi phí của nguồn phụ thuộc số yêu cầu, không so được mức tốn kém của mỗi lần tuyển.
SELECT recruitment_source, COUNT(*) AS so_yeu_cau,
       ROUND(AVG(time_to_fill_days), 1) AS so_ngay_tuyen_bq,
       SUM(recruiting_cost_usd) AS chi_phi_bq
FROM recruiting_pipeline
WHERE approval_date >= '2025-01-01' AND approval_date < '2026-01-01'
GROUP BY recruitment_source
ORDER BY chi_phi_bq, recruitment_source;
