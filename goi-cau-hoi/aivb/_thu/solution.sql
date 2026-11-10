-- solution.sql: gói thử AIV Bank, MySQL 8.0. Chạy trên aivb (public) và aivb_hidden_1 (hidden-1).

-- [aivb-thu-mobile-thang-12] solution
SELECT SUM(amount) AS tong_tien
FROM core_payment_order
WHERE channel_code = 'MOBILE' AND payment_status = 'COMPLETED'
  AND transaction_date >= '2026-12-01' AND transaction_date < '2027-01-01';

-- [aivb-thu-mobile-thang-12] wrong: quen_can_tren
SELECT SUM(amount) AS tong_tien
FROM core_payment_order
WHERE channel_code = 'MOBILE' AND payment_status = 'COMPLETED'
  AND transaction_date >= '2026-12-01';
