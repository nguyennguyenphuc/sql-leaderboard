-- solution.sql: gói nháp jelly (1 câu).

-- [jelly-thu-doanh-thu-iap-thang-8] solution
SELECT SUM(price_usd) AS doanh_thu
FROM purchases
WHERE event_date >= '2026-08-01' AND event_date < '2026-09-01';

-- [jelly-thu-doanh-thu-iap-thang-8] wrong: quen_can_tren
SELECT SUM(price_usd) AS doanh_thu
FROM purchases
WHERE event_date >= '2026-08-01';
