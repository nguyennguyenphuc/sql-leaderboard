-- 01_tao_bang_scm.sql: 20 bảng Supply Chain cho MySQL 8.0 (bản rút gọn của leaderboard).
-- Sinh từ catalog Postgres của lớp (DB scm, schema scm), bỏ item_costs_monthly.
-- Không ghi tên database: chạy sau `USE scm;` hoặc `USE scm_hidden_1;` (xem 02_nap_scm.sh, 03_bien_the_an_scm.sql).
-- Đổi kiểu so với PG (ghi đủ trong README.md):
--   text ngày 'YYYY-MM-DD' (sales.date, orders.order_date, purchase_orders.*_date) -> DATE
--   inventory_snapshots.ym giữ CHAR(7) 'YYYY-MM'; shipments.week giữ VARCHAR 'YYYY-MM-DD/YYYY-MM-DD'
--   real (float4) -> DECIMAL(..,3)  (dữ liệu có tối đa 3 chữ số thập phân; DECIMAL cho tổng chính xác, hoà hạng đúng)
--   double precision -> DOUBLE;  boolean -> TINYINT(1);  timestamp -> DATETIME(6);  text -> VARCHAR(n)
--   PG phân vùng sales theo năm; MySQL thay bằng chỉ mục idx_sales_date.

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS warehouse_daily_ops, transactions, staffing_plan, store_attributes, shipments,
  sales, purchase_orders, orders, item_costs, inventory_snapshots, suppliers, warehouses, stores,
  sorting_hubs, oil, items, holidays, event_calendar, delivery_points, city_geo;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------ bảng danh mục
CREATE TABLE city_geo (
  city   VARCHAR(32) NOT NULL,
  lat    DOUBLE NULL,
  `long` DOUBLE NULL,
  PRIMARY KEY (city)
) ENGINE=InnoDB;

CREATE TABLE delivery_points (
  point_id VARCHAR(32) NOT NULL,
  city     VARCHAR(32) NULL,
  lat      DOUBLE NULL,
  `long`   DOUBLE NULL,
  weight   DOUBLE NULL,
  PRIMARY KEY (point_id)
) ENGINE=InnoDB;

CREATE TABLE event_calendar (
  `date`            DATE NOT NULL,
  event_name        VARCHAR(64) NULL,
  tier              VARCHAR(8) NULL,
  demand_multiplier DOUBLE NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB;

-- PG không có khoá chính cho holidays
CREATE TABLE holidays (
  `date`      DATE NULL,
  type        VARCHAR(16) NULL,
  locale      VARCHAR(16) NULL,
  locale_name VARCHAR(32) NULL,
  description VARCHAR(64) NULL,
  transferred TINYINT(1) NULL
) ENGINE=InnoDB;

CREATE TABLE items (
  item_nbr   INT NOT NULL,
  family     VARCHAR(32) NULL,
  class      INT NULL,
  perishable SMALLINT NULL,
  PRIMARY KEY (item_nbr)
) ENGINE=InnoDB;

CREATE TABLE oil (
  `date`     DATE NOT NULL,
  dcoilwtico DOUBLE NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB;

CREATE TABLE sorting_hubs (
  hub_id    VARCHAR(16) NOT NULL,
  dc_parent VARCHAR(16) NULL,
  city      VARCHAR(32) NULL,
  role      VARCHAR(16) NULL,
  lat       DOUBLE NULL,
  `long`    DOUBLE NULL,
  PRIMARY KEY (hub_id)
) ENGINE=InnoDB;

CREATE TABLE stores (
  store_nbr SMALLINT NOT NULL,
  city      VARCHAR(32) NULL,
  state     VARCHAR(32) NULL,
  type      VARCHAR(4) NULL,
  cluster   SMALLINT NULL,
  PRIMARY KEY (store_nbr)
) ENGINE=InnoDB;

CREATE TABLE warehouses (
  warehouse_id VARCHAR(16) NOT NULL,
  city         VARCHAR(32) NULL,
  lat          DOUBLE NULL,
  `long`       DOUBLE NULL,
  PRIMARY KEY (warehouse_id)
) ENGINE=InnoDB;

CREATE TABLE suppliers (
  supplier_id        VARCHAR(16) NOT NULL,
  supplier_name      VARCHAR(64) NULL,
  family             VARCHAR(32) NULL,
  city               VARCHAR(32) NULL,
  lat                DOUBLE NULL,
  `long`             DOUBLE NULL,
  promised_lead_days SMALLINT NULL,
  warehouse_id       VARCHAR(16) NULL,
  PRIMARY KEY (supplier_id),
  CONSTRAINT suppliers_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES warehouses (warehouse_id)
) ENGINE=InnoDB;

CREATE TABLE store_attributes (
  store_nbr      SMALLINT NOT NULL,
  city           VARCHAR(32) NULL,
  state          VARCHAR(32) NULL,
  type           VARCHAR(4) NULL,
  cluster        SMALLINT NULL,
  lat            DOUBLE NULL,
  `long`         DOUBLE NULL,
  area_m2        DOUBLE NULL,
  rent_month_usd DOUBLE NULL,
  PRIMARY KEY (store_nbr),
  CONSTRAINT store_attributes_store_nbr_fkey FOREIGN KEY (store_nbr) REFERENCES stores (store_nbr)
) ENGINE=InnoDB;

CREATE TABLE item_costs (
  item_nbr   INT NOT NULL,
  family     VARCHAR(32) NULL,
  perishable SMALLINT NULL,
  unit_price DOUBLE NULL,
  unit_cost  DOUBLE NULL,
  PRIMARY KEY (item_nbr),
  CONSTRAINT item_costs_item_nbr_fkey FOREIGN KEY (item_nbr) REFERENCES items (item_nbr)
) ENGINE=InnoDB;

CREATE TABLE staffing_plan (
  hub_id             VARCHAR(16) NOT NULL,
  `date`             DATE NOT NULL,
  headcount_ke_hoach INT NULL,
  headcount_thuc_te  INT NULL,
  PRIMARY KEY (hub_id, `date`),
  CONSTRAINT staffing_plan_hub_id_fkey FOREIGN KEY (hub_id) REFERENCES sorting_hubs (hub_id)
) ENGINE=InnoDB;

CREATE TABLE warehouse_daily_ops (
  hub_id             VARCHAR(16) NOT NULL,
  `date`             DATE NOT NULL,
  orders_to_process  INT NULL,
  backlog_dau_ngay   DOUBLE NULL,
  backlog_cuoi_ngay  DOUBLE NULL,
  headcount          INT NULL,
  total_weight_kg    DOUBLE NULL,
  avg_sort_time_min  DOUBLE NULL,
  workload_ratio     DOUBLE NULL,
  headcount_ke_hoach INT NULL,
  PRIMARY KEY (hub_id, `date`),
  CONSTRAINT warehouse_daily_ops_hub_id_fkey FOREIGN KEY (hub_id) REFERENCES sorting_hubs (hub_id)
) ENGINE=InnoDB;

CREATE TABLE transactions (
  `date`       DATE NOT NULL,
  store_nbr    SMALLINT NOT NULL,
  transactions INT NULL,
  PRIMARY KEY (`date`, store_nbr),
  CONSTRAINT transactions_store_nbr_fkey FOREIGN KEY (store_nbr) REFERENCES stores (store_nbr)
) ENGINE=InnoDB;

CREATE TABLE shipments (
  shipment_id   VARCHAR(16) NOT NULL,
  warehouse_id  VARCHAR(16) NULL,
  store_nbr     SMALLINT NULL,
  week          VARCHAR(24) NULL,       -- 'YYYY-MM-DD/YYYY-MM-DD' (thứ Hai/Chủ nhật), giữ như PG
  km_to_dc      DOUBLE NULL,
  units_shipped DOUBLE NULL,
  promised_days SMALLINT NULL,
  actual_days   DOUBLE NULL,
  on_time       SMALLINT NULL,
  in_full       SMALLINT NULL,
  otif          SMALLINT NULL,
  PRIMARY KEY (shipment_id),
  CONSTRAINT shipments_store_nbr_fkey FOREIGN KEY (store_nbr) REFERENCES stores (store_nbr),
  CONSTRAINT shipments_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES warehouses (warehouse_id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------------ bảng sự kiện
CREATE TABLE purchase_orders (
  po_id              VARCHAR(16) NOT NULL,
  supplier_id        VARCHAR(16) NULL,
  item_nbr           INT NULL,
  po_date            DATE NULL,          -- PG: text
  qty_ordered        DECIMAL(12,3) NULL, -- PG: real
  promised_lead_days SMALLINT NULL,
  promised_date      DATE NULL,          -- PG: text
  received_date      DATE NULL,          -- PG: text (NULL = chưa nhận)
  km_supplier_to_dc  DOUBLE NULL,
  qty_received       DECIMAL(12,3) NULL,
  qty_defect         DECIMAL(12,3) NULL,
  defect_rate        DOUBLE NULL,
  inspection_result  VARCHAR(16) NULL,
  PRIMARY KEY (po_id),
  KEY idx_po_supplier (supplier_id),
  CONSTRAINT purchase_orders_item_nbr_fkey FOREIGN KEY (item_nbr) REFERENCES items (item_nbr),
  CONSTRAINT purchase_orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id)
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id                 VARCHAR(16) NOT NULL,
  order_date               DATE NULL,          -- PG: text
  region                   VARCHAR(8) NULL,
  origin_hub_id            VARCHAR(16) NULL,
  dest_hub_id              VARCHAR(16) NULL,
  dest_city                VARCHAR(32) NULL,
  dest_point_id            VARCHAR(32) NULL,
  family                   VARCHAR(32) NULL,
  weight_kg                DOUBLE NULL,
  order_value_usd          DOUBLE NULL,
  created_at               DATETIME(6) NULL,
  picked_at                DATETIME(6) NULL,
  dispatched_at            DATETIME(6) NULL,
  hub_arrived_at           DATETIME(6) NULL,
  delivered_at             DATETIME(6) NULL,
  t1_tao_don_pick_h        DOUBLE NULL,
  t2_pick_xuat_h           DOUBLE NULL,
  t3a_di_chuyen_h          DOUBLE NULL,
  t3b_sorting_h            DOUBLE NULL,
  t4_kho_giao_h            DOUBLE NULL,
  lead_time_total_h        DOUBLE NULL,
  promised_h               DOUBLE NULL,
  on_time                  SMALLINT NULL,
  checkout_group           VARCHAR(16) NULL,
  voucher_manually_applied TINYINT(1) NULL,
  voucher_applied          TINYINT(1) NULL,
  is_cancelled             TINYINT(1) NULL,
  PRIMARY KEY (order_id),
  KEY idx_orders_date (order_date),
  KEY idx_orders_hub (dest_hub_id),
  CONSTRAINT orders_dest_hub_id_fkey FOREIGN KEY (dest_hub_id) REFERENCES sorting_hubs (hub_id),
  CONSTRAINT orders_dest_point_id_fkey FOREIGN KEY (dest_point_id) REFERENCES delivery_points (point_id),
  CONSTRAINT orders_origin_hub_id_fkey FOREIGN KEY (origin_hub_id) REFERENCES sorting_hubs (hub_id)
) ENGINE=InnoDB;

-- PG: khoá chính (store_nbr, item_nbr, ym), chỉ mục ym; không có khoá ngoại
CREATE TABLE inventory_snapshots (
  store_nbr       SMALLINT NOT NULL,
  item_nbr        INT NOT NULL,
  ym              CHAR(7) NOT NULL,      -- 'YYYY-MM', giữ dạng chuỗi như PG
  on_hand_begin   DECIMAL(12,3) NULL,
  received        DECIMAL(12,3) NULL,
  sold            DECIMAL(12,3) NULL,
  on_hand_end     DECIMAL(12,3) NULL,
  inventory_value DOUBLE NULL,
  thieu_hut       DECIMAL(12,3) NULL,
  PRIMARY KEY (store_nbr, item_nbr, ym),
  KEY idx_inv_ym (ym)
) ENGINE=InnoDB;

-- PG: bảng phân vùng theo năm, không khoá chính, chỉ mục (store_nbr, item_nbr); không có khoá ngoại
CREATE TABLE sales (
  `date`      DATE NOT NULL,             -- PG: text
  store_nbr   SMALLINT NULL,
  item_nbr    INT NULL,
  unit_sales  DECIMAL(12,3) NULL,        -- PG: real; âm = trả hàng
  onpromotion TINYINT(1) NULL,
  KEY idx_sales_store_item (store_nbr, item_nbr),
  KEY idx_sales_date (`date`)
) ENGINE=InnoDB;
