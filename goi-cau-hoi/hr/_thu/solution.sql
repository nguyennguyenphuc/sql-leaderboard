-- solution.sql: gói thử 1 câu bộ HR, MySQL 8.0. Chạy trên hr (public) và hr_hidden_1 (hidden-1).

-- [hr-thu-top3-lam-them-2025] solution
SELECT employee_id, SUM(overtime_hours) AS tong_gio
FROM employee_monthly_snapshot
WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
GROUP BY employee_id
ORDER BY tong_gio DESC, employee_id
LIMIT 3;

-- [hr-thu-top3-lam-them-2025] wrong: dung_rank
-- Rớt ở hidden-1: hạng 3 hoà (E01799 = E02682 = 849) nên RANK() trả 4 dòng.
WITH t AS (
  SELECT employee_id, SUM(overtime_hours) AS tong_gio,
         RANK() OVER (ORDER BY SUM(overtime_hours) DESC) AS hang
  FROM employee_monthly_snapshot
  WHERE snapshot_month >= '2025-01' AND snapshot_month <= '2025-12'
  GROUP BY employee_id)
SELECT employee_id, tong_gio FROM t WHERE hang <= 3 ORDER BY tong_gio DESC, employee_id;
