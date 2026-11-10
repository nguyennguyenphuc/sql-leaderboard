# MySQL 8.0 cho SQL Leaderboard · bộ dữ liệu GAME Jelly Trail Academy (`jelly`)

Dựng ngày 10/11/2026 trên cùng máy chủ chấm `sqllb-mysql` (xem `README.md`: container, mạng `sqllb`, `.env`, user `sql_runner`).
Nguồn: Postgres của lớp (`docker-postgres-1`), database `candy_game`, **chỉ schema `jelly_analytics`**, đọc ở chế độ
`default_transaction_read_only=on`. **Không** đọc schema `public` (tài khoản, mật khẩu băm, token, IP).

Game: *Jelly Trail Academy* (studio Jellybridge Learning Lab), game giải đố ghép kẹo (match-3) trên di động iOS/Android,
8 thị trường (VN, US, IN, ID, TH, BR, PH, GB). Dữ liệu **tổng hợp** (synthetic, manifest `dataset_version` 3.0),
60 ngày **2026-07-01 → 2026-08-29**.

| Thành phần | Giá trị |
|---|---|
| Database | `jelly` (public), `jelly_hidden_1` (biến thể ẩn) |
| Quyền | `sql_runner`: `SELECT` trên `jelly`, `jelly\_hidden\_%` (đã thêm vào `05_tai_khoan_cham_bai.sql`) |
| Bộ kiểm | `dulieu=jelly` → public `jelly`, hidden-1 `jelly_hidden_1` theo quy tắc mặc định của `kiem_tra_goi.py` (không cần sửa `bien-the.json`); đã chạy thử gói nháp `goi-cau-hoi/jelly/_thu/` → `KIEM TRA: 0 loi`, wrong thiếu cận trên rớt đúng ở hidden-1 |

## Dựng lại

```bash
bash mysql/jelly/02_nap_jelly.sh            # xuất CSV từ PG (chỉ đọc) + 01_tao_bang_jelly.sql + nạp + so số dòng (~1 phút)
                                            # --chi-nap: dùng lại CSV có sẵn trong mysql/jelly/du-lieu/
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/jelly/03_bien_the_an_jelly.sql   # ~50 giây
docker exec -i sqllb-mysql sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot' < mysql/jelly/04_bo_sung_bien_the_jelly.sql  # bổ sung (d)–(j), chạy lặp lại được; luôn chạy sau 03
# quyền: chạy lại 05_tai_khoan_cham_bai.sql (xem README.md) hoặc chỉ 2 lệnh GRANT của jelly
```

`mysql/jelly/du-lieu/` (CSV ~127 MB, `so-dong-pg.txt`) **không** đưa vào gói, không chia sẻ.

## Bảng, số dòng, phạm vi

Lấy **đủ** (không cắt cửa sổ): tổng **764.812 dòng** (≪ 6 triệu). Số dòng PG (cùng điều kiện) = MySQL cho cả 13 bảng.

| Bảng | Hạt (1 dòng là) | Số dòng `jelly` | `jelly_hidden_1` |
|---|---|---:|---:|
| `level_attempts` | một lượt chơi một màn | 249.777 | 224.719 |
| `ad_events` | một lần xem quảng cáo | 175.228 | 157.521 |
| `sessions` | một phiên chơi | 126.684 | 113.953 |
| `player_daily` | một người chơi × một ngày **có hoạt động** | 79.628 | 71.595 |
| `tutorial_steps` | một người chơi × một bước hướng dẫn đã bắt đầu (5 bước) | 62.782 | 56.534 |
| `booster_events` | một lần dùng vật phẩm hỗ trợ (booster) trong một lượt chơi | 43.659 | 39.208 |
| `users` | một người chơi (lúc cài đặt) | 14.355 | 12.920 |
| `ab_assignments` | một người chơi × một thử nghiệm A/B | 8.000 | 7.198 |
| `purchases` | một giao dịch mua trong ứng dụng (IAP) | 2.661 | 2.367 |
| `campaign_spend` | chi quảng cáo một ngày × chiến dịch × quốc gia × nền tảng | 1.920 | 1.921 |
| `daily_kpi` | một ngày (bảng chỉ số tổng hợp sẵn) | 60 | 62 |
| `level_metadata` | một màn (60 màn, 4 thế giới × 15) | 60 | 60 (2 màn đổi nhãn, (f)) |
| `liveops_events` | một sự kiện vận hành (3 sự kiện) | 3 | 4 |
| view `tutorial_step4_health` | tỷ lệ hoàn thành bước 4 theo phiên bản × nền tảng × vùng | (view) | (view) |
| view `level_28_30_health` | tỷ lệ thắng màn 28–30 theo phiên bản × nền tảng × vùng | (view) | (view) |

**Không nạp:** view `live_player_wallets` (đọc `public.wallets` + `public.account_identities` = ví của tài khoản thật),
bảng `dataset_metadata` (manifest kỹ thuật). **Bỏ dòng "live":** trên PG, người dùng thật chơi qua web ghi thêm 3 người chơi
`aivb_…`, 10 phiên, 20 lượt chơi (2 lượt `in_progress`), 6 dòng `player_daily` và 6 dòng `daily_kpi` sau 2026-08-29
(tháng 9–11/2026). Đây là dữ liệu tài khoản thật nên **không** xuất; `02_nap_jelly.sh` lọc `user_id LIKE 'jta\_user\_%'`
và `daily_kpi.date <= '2026-08-29'`. Số còn lại khớp đúng manifest của bộ tổng hợp.

## Kiểu cột (PG lưu mọi cột dạng `text`)

| PG `text` chứa | MySQL | Cột |
|---|---|---|
| `'YYYY-MM-DD'` | `DATE` | `install_date`, `event_date`, `activity_date`, `campaign_spend.date`, `daily_kpi.date`, `start_date`, `end_date` |
| `'YYYY-MM-DDTHH:MM:SS'` | `DATETIME` (bỏ chữ `T`) | `event_time`, `sessions.session_start`, `ab_assignments.assigned_at/eligible_at/exposed_at` |
| số nguyên | `INT`/`SMALLINT`/`TINYINT` | `level_id`, `episode`, `moves_*`, `duration_*`, `cohort_day`, `sessions`, `playtime_minutes`, `max_level`, `dau`, … |
| cờ `'0'/'1'` | `TINYINT(1)` | `booster_used`, `extra_moves_offered`, `extra_moves_purchased`, `step_completed`, `is_refund` |
| tiền, tỷ lệ | `DECIMAL` đủ số lẻ có trong dữ liệu | `price_usd (6,2)`, `spend_usd (10,2)`, `revenue_usd (10,5)`, `player_daily.ad_revenue (10,4)`, `iap_revenue (8,2)`, `daily_kpi.arpdau (8,4)`, `designed_fail_probability (5,3)` |
| `'12.0'` hoặc rỗng | `SMALLINT` NULL | `purchases.level_id_if_relevant` |

Cột `date` viết `` `date` ``. View `tutorial_step4_health` có cột `` `rows` `` (từ khoá MySQL). Bẫy "số lưu dạng chữ"
của PG (`'10' < '9'`, `MAX(level_id)` theo chữ) **không còn** ở MySQL.

## Quan hệ (ERD dạng chữ)

PG chỉ khai báo khoá chính. MySQL thêm khoá chính hạt dữ liệu và **khoá ngoại logic**, đã kiểm 0 dòng trùng, 0 dòng mồ côi:

```
users (user_id PK) ─┬─< sessions (session_id PK, user_id)
                    ├─< player_daily (PK user_id+activity_date)
                    ├─< tutorial_steps (PK user_id+step_id, session_id → sessions)
                    ├─< ab_assignments (PK user_id+experiment_id)
                    ├─< level_attempts (attempt_id PK, session_id → sessions, level_id → level_metadata)
                    │        └─< booster_events (booster_event_id PK, attempt_id, session_id, level_id)
                    ├─< purchases (transaction_id PK, session_id, level_id_if_relevant → level_metadata, NULL được)
                    └─< ad_events (ad_id PK, session_id)
level_metadata (level_id PK) ─< level_attempts, booster_events, purchases
campaign_spend (PK date+campaign_id+country+target_platform)  ~ users.campaign_id / channel (nối logic, không FK)
daily_kpi (date PK)  = tổng hợp của player_daily/users theo ngày
liveops_events (event_id PK)  ~ nối theo khoảng ngày start_date..end_date
```

Chỉ mục: chép đủ của PG (`jelly_sessions_user_day_idx`, `jelly_daily_cohort_idx`, `jelly_daily_user_day_idx` → nay là PK,
`jelly_attempt_segment_idx`, `jelly_attempts_user_day_idx`, `jelly_boosters_user_day_idx`, `jelly_purchases_user_day_idx`,
`jelly_ads_user_day_idx`, `jelly_tutorial_segment_idx`) + thêm theo ngày: `idx_users_install`, `idx_sessions_date`,
`idx_daily_activity`, `idx_attempts_date`, `idx_ads_date`.

## Giá trị và bẫy dữ liệu đã kiểm (số thật trên `jelly`)

Danh mục: `platform` iOS 4.301 / Android 10.054 người chơi · `channel` (`campaign_id`): Organic (`ORG-000`) 5.253, Search Ads
(`JTA-SEA-SEARCH-101`) 3.176, Social Ads (`JTA-SOCIAL-204`) 3.159, Video Network (`JTA-VIDEO-330`) 2.091, Creator Campaign
(`JTA-CREATOR-077`) 676 · `device_tier` low/mid/high · thế giới (`episode`): 1 Cupcake Meadow (màn 1–15), 2 Jelly Jungle (16–30),
3 Licorice Lagoon (31–45), 4 Chocolate Volcano (46–60) · `difficulty_tag` normal 52, hard 4, super_hard 4 · `result`:
`complete` 202.162, `fail_out_of_moves` 32.801, `quit` 11.653, `crash` 3.161 · `product_type` 5 gói giá cố định
(starter_pack 0,99; extra_moves_pack 1,99; piggy_bank 2,99; booster_bundle 4,99; season_pass 9,99) · quảng cáo `rewarded`/`interstitial`,
4 `placement` · thử nghiệm A/B duy nhất `extra_moves_offer_timing`, 2 nhánh `control_after_3_fails` / `early_offer_after_1_fail`.

| # | Bẫy | Số thật |
|---|---|---|
| 1 | `player_daily` **chỉ có ngày có hoạt động** (không có dòng 0). Retention/DAU phải lấy mẫu số từ `users` (cohort cài đặt), không đếm trên `player_daily` | 14.355 người chơi đều có ≥ 1 dòng; D1 = 40,45%, D7 = 24,44% (cohort cài ≤ 2026-08-22) |
| 2 | Cohort chưa "chín": người cài sau 2026-08-22 chưa đủ 7 ngày quan sát → D7 phải loại cohort chưa đủ ngày | cửa sổ kết thúc 2026-08-29 |
| 3 | `cohort_day` = `activity_date − install_date` (đã kiểm 0 lệch); D0 là ngày cài | |
| 4 | `app_version` **thay đổi theo thời gian** (người chơi cập nhật): `player_daily/sessions.app_version` ≠ `users.app_version_install` | 20.026 dòng `player_daily` khác phiên bản lúc cài; 2.0.2 từ 07-01, 2.1.0 từ 07-30, 2.1.1 từ 08-15 |
| 5 | `max_level` là màn cao nhất **trong ngày**, không cộng dồn; có thể giảm | 2.675 lần giảm so với ngày trước; 58.480 ngày `max_level` ≠ `MAX(level_id)` của `level_attempts` cùng ngày |
| 6 | `tutorial_steps`: bước k+1 chỉ có dòng khi bước k hoàn thành → phễu đếm số dòng mỗi `step_id`; `step_completed=0` là bắt đầu nhưng bỏ dở | bước 1→5: 14.355 / 14.095 / 13.246 / 11.766 / 9.320 dòng; hoàn thành bước 5: 7.125 |
| 7 | `daily_kpi` là bảng tổng hợp sẵn **khớp đúng** `player_daily` (dau, sessions, playtime, iap, ad, crash) và `users` (new_users); `arpdau = ROUND((iap_revenue+ad_revenue)/dau, 4)` | 60/60 ngày khớp |
| 8 | Đối soát lệch thật giữa bảng sự kiện và tổng hợp: lượt chơi `result='crash'` ≠ `crash_count` | 3.161 lượt crash vs `SUM(crash_count)` = 546 |
| 9 | `level_attempts.extra_moves_purchased = 1` không phải giao dịch tiền: không khớp `purchases` gói `extra_moves_pack` | 2.409 lượt vs 645 giao dịch; 60 ngày-người `player_daily.extra_moves_purchased` ≠ tổng từ `level_attempts` |
| 10 | `player_daily.ad_revenue` (4 số lẻ) vs `SUM(ad_events.revenue_usd)` (5 số lẻ) lệch do làm tròn | 243 ngày-người lệch > 0,00005 |
| 11 | `player_daily.iap_revenue` khớp đúng `purchases`; `sessions`, `playtime_minutes` khớp `sessions` (COUNT, SUM `duration_minutes`); `boosters_used` khớp `booster_events` | 0 lệch |
| 12 | `purchases.level_id_if_relevant` NULL khi mua ở cửa hàng (không gắn màn) | 1.386 / 2.661 NULL |
| 13 | `is_refund` luôn 0, `currency` luôn `USD` → không có hoàn tiền; câu "doanh thu thuần" ra bằng doanh thu gộp | 0 giao dịch hoàn tiền |
| 14 | Organic không có chi phí: `campaign_spend` chỉ 4 chiến dịch trả phí; nối `users` với chi phí phải LEFT JOIN, CPI chỉ tính kênh trả phí | Organic 5.253 người chơi; tổng chi 112.121,10 USD |
| 15 | `campaign_spend` chia theo quốc gia × `target_platform`: gom theo ngày phải SUM, không lấy 1 dòng | 480 dòng/chiến dịch |
| 16 | `ab_assignments.exposed_at` NULL khi `exposure_status='not_exposed'` (được chia nhánh nhưng chưa gặp tình huống) — phân tích intention-to-treat dùng mọi người được chia, per-protocol chỉ `exposed` | 2.425 not_exposed / 5.575 exposed |
| 17 | `sessions.session_id` có 2 dạng: `jta_session_00000001` và `jta_session_v3_tutorial_000001` (phiên hướng dẫn, `entry_screen='tutorial'`); đừng cắt chuỗi lấy số | 3.986 phiên hướng dẫn |
| 18 | Doanh thu nhỏ: `revenue_usd` quảng cáo 0,00024–0,11489 USD/lần; làm tròn sớm sẽ lệch | tổng quảng cáo 1.046,72 USD; IAP 8.504,39 USD; 2.326 người trả tiền |
| 19 | `booster_events.action` chỉ có `use`; `world_name`/`difficulty_tag` lặp ở `level_attempts` (phi chuẩn hoá) khớp `level_metadata` | |
| 20 | Collation `utf8mb4_0900_ai_ci` không phân biệt hoa thường: `'ios' = 'iOS'` | |

## Biến thể ẩn `jelly_hidden_1` (`jelly/03_bien_the_an_jelly.sql` + `jelly/04_bo_sung_bien_the_jelly.sql`)

Bản sao `jelly` rồi đổi như sau (khuôn `datathon_2026_hidden_1`, `scm_hidden_1`); (a)–(c) ở 03, (d)–(j) ở 04 (bổ sung 10/11/2026 để câu chỉ dùng bảng danh mục / bảng phụ cũng khác public):

| Biến thể · thay đổi | Khác public ở đâu | Bắt lỗi gì |
|---|---|---|
| (a) bỏ người chơi `CAST(SUBSTRING(user_id,10) AS UNSIGNED) % 10 = 7` cùng **mọi** dòng của họ ở 9 bảng theo người chơi | `users` −1.435, `level_attempts` −25.060 (~10%), `sessions` −12.733, `ad_events` −17.707, `player_daily` −8.035, `purchases` −295, …; FK nguyên vẹn | bài chép số từ lần Chạy thử public; mọi con số đều khác |
| (a') `daily_kpi` **tính lại** từ `player_daily`/`users` đúng công thức public | 62 dòng sau 04 (thêm 2026-09-01, 2026-09-02), số mới | câu đối soát `daily_kpi` ↔ `player_daily` vẫn khớp như public (không tạo lệch giả) |
| (b) thêm 1 ngày **2026-09-01** (ngay sau tháng cuối của cửa sổ) cho `jta_user_000648`: phiên `jta_session_00122699`, lượt `jta_attempt_000249778` (màn 58, complete), giao dịch `jta_txn_00002662` (Booster Bundle 4,99), quảng cáo `jta_ad_000175229`, dòng `player_daily` (cohort_day 60), dòng `daily_kpi` 2026-09-01 (dau 1) | 1 dòng sau ngày cuối 2026-08-29 ở 6 bảng | **thiếu cận trên** khi lọc tháng 8/2026 (`>= '2026-08-01'` không có `< '2026-09-01'`), "từ ngày X", "60 ngày quan sát"; lấy "ngày mới nhất" bằng `MAX(event_date)` |
| (b) thêm `campaign_spend` 2026-09-01 (chép dòng 2026-08-29 `JTA-SOCIAL-204`, VN, Android) | 1 dòng | thiếu cận trên với chi phí, CPI/ROAS tháng 8 |
| (c) đổi 1 lượt `fail_out_of_moves` của màn 32 (`MIN(attempt_id)`) thành `quit` | **thế giới Licorice Lagoon, top 3 màn theo số lượt bỏ cuộc (`result='quit'`)**: hạng 3 màn **32 = màn 34 = 71** (public: 34 = 82, 32 = 76, không hoà) | `RANK()`/`DENSE_RANK()` khi đề yêu cầu đúng 3 dòng (ra 4); thiếu quy tắc hoà (đề nên ghi "bằng nhau thì `level_id` nhỏ hơn trước") |
| (d) giao dịch `jta_txn_00002662` của (b) gắn màn: `level_id_if_relevant` = 58 (04) | trước đây rỗng; nay khớp public: mọi Booster Bundle đều gắn màn = `max_level` trong ngày | (sửa lệch dữ liệu, không bắt lỗi riêng) |
| (e) người chơi **chưa từng mua** `jta_user_001174` (iOS, VN, Social Ads, cài 2026-07-05, vẫn bản 2.0.2, đã tới màn 60) thêm 2026-09-01: phiên `jta_session_00122700`, lượt `jta_attempt_000249779` (màn 59, thua), giao dịch `jta_txn_00002663` Starter Pack **giá khuyến mãi 0,49**, dòng `player_daily`; và 2026-09-02: phiên `jta_session_00122701`, lượt `jta_attempt_000249780` (màn 60, complete), dòng `player_daily`; `daily_kpi` 2026-09-01 (dau 2), 2026-09-02 (dau 1) tính lại (04) | `sessions` +2, `level_attempts` +2, `purchases` +1, `player_daily` +2, `daily_kpi` +1; ngày cuối dữ liệu hoạt động là 2026-09-02; bảng giá có 6 cặp tên gói × giá | thiếu cận trên ở câu "người chưa mua" (j3), "đã mua Starter Pack" (c5.b1), "ngày DAU trên bình quân tháng" (q4: tháng 9 có 2 ngày DAU khác nhau), "màn chưa gắn giao dịch" (q9: màn 59, 60 có lượt sau 29/8); bài chép bảng giá (n5) |
| (f) đổi nhãn độ khó ở `level_metadata` **và** mọi lượt chơi của màn: màn 45 `hard` → `super_hard`, màn 59 `normal` → `hard` (04) | `super_hard` 5 màn, `hard` 4, `normal` 51 (public 4/4/52); `level_attempts` màn 45, 59 đổi `difficulty_tag` | bài chép danh sách màn siêu khó (r3), màn không phải `normal` (s2) |
| (g) thêm sự kiện `LIVE_004` *Jungle Jam Weekend* 2026-07-31 → 2026-08-02, không chồng sự kiện khác (04) | `liveops_events` 4 dòng | bài chép danh sách sự kiện trong kỳ (r6) |
| (h) `campaign_spend` `JTA-VIDEO-330` · VN · Android **+150 USD** ở 2026-07-11 và 2026-08-10 (ngày giữa sự kiện) (04) | 2 dòng đổi giá trị (số dòng giữ 1.921); Video Network có 2 ngày chi vượt bình quân + 2 độ lệch chuẩn | bài chép kết quả chi theo kênh tháng 8 (a3), luỹ kế tháng 7 (f3), ngày chi bất thường (k7: chỉ thấy khi lấy mức nền theo từng chiến dịch) |
| (i) `player_daily` `jta_user_003773` · 2026-08-24: `install_date` 2026-07-14 (users: 2026-07-15), `cohort_day` 41 tính theo ngày ghi lệch (04) | 1 dòng lệch ngày cài, chỉ thấy khi nối `users` | k3: bài so hai cột trong `player_daily` ra 0 lệch, bài đúng ra 1 |
| (j) `jta_user_000648` (GB, Organic) có thêm hoạt động **2026-08-30**: 1 phiên `jta_session_00122702`, 1 giao dịch Booster Bundle 4,99 USD `jta_txn_00002664` (màn 57), 1 dòng `player_daily`; `daily_kpi` có dòng 30/8 (04, v3 10/11) | ngày trong tháng 8 nhưng sau ngày cuối của public | r8: bài gắn cứng `event_date <= '2026-08-29'` rớt ở hidden-1 |

Không nạp lại phần (a) vào `campaign_spend`, `level_metadata`, `liveops_events` (không theo người chơi). Muốn có bẫy mới (ví dụ
trùng tên sản phẩm, thêm hoàn tiền) thì thêm `jelly_hidden_2` theo cùng cách và ghi vào bảng này.

**Lưu ý cho người soạn:** câu hỏi "tháng 8/2026" là tháng chưa trọn (tới 29/8); "tháng 7" trọn 31 ngày. Câu đúng phải có
cả cận trên để rớt wrong ở hidden-1. Câu top N trên Licorice Lagoon theo lượt bỏ cuộc là nơi có sẵn cặp hoà.

## File

| File | Việc |
|---|---|
| `jelly/01_tao_bang_jelly.sql` | 13 bảng + 2 view, PK/FK/index; không ghi tên database |
| `jelly/02_nap_jelly.sh` | xuất CSV từ PG (`COPY … TO STDOUT WITH CSV HEADER`, `NULL '\N'`, bỏ dòng live), tạo `jelly`, `LOAD DATA LOCAL INFILE`, `ANALYZE`, so số dòng |
| `jelly/03_bien_the_an_jelly.sql` | tạo `jelly_hidden_1` (gọi `SOURCE /sqllb/jelly/01_tao_bang_jelly.sql`), in số dòng và cặp hoà |
| `jelly/04_bo_sung_bien_the_jelly.sql` | bổ sung `jelly_hidden_1` (d)–(j) để câu chỉ dùng bảng danh mục/bảng phụ cũng khác public; chạy sau 03, lặp lại được |
| `05_tai_khoan_cham_bai.sql` | thêm `GRANT SELECT` cho `jelly`, `jelly\_hidden\_%` |
| `jelly/du-lieu/` | CSV + `so-dong-pg.txt` (không đưa vào gói) |
