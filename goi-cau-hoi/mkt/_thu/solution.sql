-- solution.sql: gói thử bộ MARKETING, MySQL 8.0.

-- [mkt-thu-1-so-chien-dich-6-thang] solution
SELECT COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-01-01' AND start_date < '2025-07-01';

-- [mkt-thu-1-so-chien-dich-6-thang] wrong: quen_can_tren
SELECT COUNT(*) AS so_chien_dich
FROM campaigns
WHERE brand_id = 1
  AND start_date >= '2025-01-01';
