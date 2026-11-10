-- 04_bo_sung_bien_the_mkt.sql: bổ sung biến thể ẩn mkt_hidden_1 (chạy SAU 03_bien_the_an_mkt.sql).
--   docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/mkt/04_bo_sung_bien_the_mkt.sql
-- Chỉ sửa mkt_hidden_1, KHÔNG đụng mkt. Chạy lặp lại được: mỗi phần xoá dòng giả cũ theo khoá riêng rồi chèn lại.
-- (d) bản thô: thêm một nhóm trùng 3 dòng (PU-CMP-31194 chép lần thứ hai, row_index 55605, raw_id 900001)
--     + 1 dòng nhật ký DUPLICATE (log_id 60001) -> bắt lỗi "đếm số nhóm trùng" thay vì số dòng thừa (k2).

USE mkt_hidden_1;

-- ------------------------------------------------------------------ (d) nhóm trùng 3 dòng
DELETE FROM campaigns_raw WHERE raw_id = 900001;
DELETE FROM noise_log     WHERE log_id = 60001;

-- Purplle: PU-CMP-31194 (row_index gốc 30194, bản chép 55559) chép thêm lần nữa ở cuối file Purplle (row_index 55605)
INSERT INTO campaigns_raw (raw_id, brand_id, row_index, campaign_id, campaign_type, target_audience, duration, channel_used,
       impressions, clicks, leads, conversions, revenue, acquisition_cost, roi, `language`, engagement_score,
       customer_segment, date_raw)
SELECT 900001, brand_id, 55605, campaign_id, campaign_type, target_audience, duration, channel_used,
       impressions, clicks, leads, conversions, revenue, acquisition_cost, roi, `language`, engagement_score,
       customer_segment, date_raw
FROM campaigns_raw WHERE brand_id = 2 AND row_index = 55559 AND campaign_id = 'PU-CMP-31194';

INSERT INTO noise_log (log_id, brand_id, row_index, campaign_id, noise_type, column_name, old_value, new_value)
SELECT 60001, brand_id, row_index, campaign_id, noise_type, column_name, old_value, new_value
FROM noise_log WHERE brand_id = 2 AND campaign_id = 'PU-CMP-31194' AND noise_type = 'DUPLICATE'
ORDER BY log_id LIMIT 1;
