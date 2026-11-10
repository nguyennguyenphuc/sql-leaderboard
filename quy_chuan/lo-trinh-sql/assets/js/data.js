// Nội dung lộ trình. Sửa ở đây, không cần sửa site.js.
// Bài có "co_san": true là câu đã có trong gói câu hỏi mẫu (mã trùng gói); còn lại là bài dự kiến, cần soạn.
// Bảng, cột trong bài đều có thật trong bộ Datathon 2026; cú pháp theo MySQL 8.0.
window.LOTRINH = {
  title: "Lộ trình luyện SQL",
  eyebrow: "Lộ trình luyện SQL · MySQL 8.0",
  headline: "Từ câu SELECT đầu tiên đến truy vấn phân tích",
  subtitle: "10 module đi từ lấy dữ liệu một bảng tới hàm cửa sổ và tối ưu truy vấn. Mỗi bài là một tình huống thật của công ty thời trang bán online, gắn với một mảng nghiệp vụ: bạn học SQL và học luôn cách doanh nghiệp đọc số liệu.",
  storageKey: "lotrinh-sql.v4",
  dataset: "Datathon 2026 · TMĐT thời trang (MySQL 8.0)",

  levels: {
    basic:  { label: "Cơ bản",     points: 10 },
    easy:   { label: "Dễ",         points: 20 },
    medium: { label: "Trung bình", points: 30 },
    hard:   { label: "Khó",        points: 50 }
  },
  forms: { write: "Viết truy vấn", debug: "Sửa lỗi", optimize: "Tối ưu" },

  // Mảng nghiệp vụ của bài. Mỗi bài gắn đúng một mảng (khoá "domain" trong bài).
  // Mỗi module có "vidu": mỗi mảng nghiệp vụ một ví dụ (một bài của module), hiện thành các tab trên thẻ lộ trình.
  domains: {
    sales:       { label: "Bán hàng",   desc: "Doanh thu, đơn hàng, sản phẩm" },
    marketing:   { label: "Marketing",  desc: "Kênh, khuyến mãi, lưu lượng web" },
    customer:    { label: "Khách hàng", desc: "Phân khúc, mua lại, giữ chân" },
    operations:  { label: "Vận hành",   desc: "Giao hàng, tồn kho" },
    finance:     { label: "Tài chính",  desc: "Thanh toán, biên lợi nhuận, đối soát" },
    after_sales: { label: "Hậu mãi",    desc: "Trả hàng, đánh giá" }
  },

  // Bộ truy vấn chạy minh hoạ ở đầu trang (kết quả thật trên Datathon, MySQL 8.0).
  demo: [
    { sql: "SELECT COUNT(*) AS so_khach\nFROM customers\nWHERE city = 'Hanoi';", cols: ["so_khach"], rows: [["4.240"]] },
    { sql: "SELECT COUNT(*) AS so_don_huy\nFROM orders\nWHERE order_status = 'cancelled'\n  AND order_date >= '2022-01-01'\n  AND order_date <  '2023-01-01';", cols: ["so_don_huy"], rows: [["3.384"]] },
    { sql: "SELECT\n  COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) AS so_huy,\n  COUNT(CASE WHEN order_status = 'delivered' THEN 1 END) AS so_giao,\n  COUNT(CASE WHEN order_status = 'returned'  THEN 1 END) AS so_tra\nFROM orders\nWHERE order_date >= '2022-01-01' AND order_date < '2023-01-01';", cols: ["so_huy", "so_giao", "so_tra"], rows: [["3.384", "27.688", "2.022"]] }
  ],

  modules: [
    {
      so: 1, id: "retrieval", icon: "search", name: "Retrieval", vi: "Lấy và lọc dữ liệu",
      vidu: [
        { ma: "r3-khach-55-email", domain: "marketing", q: "Khách 55+ ở Hà Nội đến từ email hay giới thiệu là ai?", how: "WHERE age_group = '55+' AND city = 'Hanoi' AND acquisition_channel IN (…)" },
        { ma: "r1-san-pham-dat-nhat", domain: "sales", q: "10 sản phẩm nào có giá niêm yết cao nhất?", how: "ORDER BY price DESC LIMIT 10" },
        { ma: "d1-khach-ha-noi", domain: "customer", q: "Có bao nhiêu khách ở Hà Nội?", how: "WHERE city = 'Hanoi'   -- giá trị chữ phải khớp từng ký tự" },
        { ma: "r6-don-dang-xu-ly", domain: "operations", q: "Đơn nào trong 7 ngày cuối năm vẫn chưa hoàn tất?", how: "WHERE order_status NOT IN ('delivered', 'cancelled', 'returned') AND order_date >= '2022-12-25'" }
      ],
      desc: "Chọn đúng cột, lọc đúng dòng, sắp xếp và giới hạn kết quả. Đây là phần mọi truy vấn khác dựa vào.",
      goals: [
        "Chọn cột, đặt bí danh, bỏ dòng trùng bằng DISTINCT",
        "Lọc bằng so sánh, AND/OR/NOT, IN, BETWEEN, LIKE",
        "Sắp xếp nhiều cột và lấy N dòng đầu"
      ],
      syntax: ["SELECT", "AS", "DISTINCT", "WHERE", "AND / OR / NOT", "IN", "BETWEEN", "LIKE", "ORDER BY", "LIMIT"],
      example: {
        task: "10 sản phẩm Streetwear đắt nhất",
        sql: "SELECT product_name, size, price\nFROM products\nWHERE category = 'Streetwear'\nORDER BY price DESC\nLIMIT 10;"
      },
      mistakes: [
        "Giá trị chữ phải khớp từng ký tự: 'Hanoi' khác 'Ha Noi'.",
        "AND được tính trước OR: viết a OR b AND c mà không có ngoặc là sai ý.",
        "Lọc khoảng ngày bằng >= ngày đầu và < ngày sau ngày cuối, không dùng <= ngày cuối với cột có giờ."
      ],
      exercises: [
        { ma: "r1-san-pham-dat-nhat", domain: "sales", title: "10 sản phẩm đắt nhất", level: "basic", form: "write", skill: "ORDER BY, LIMIT", tables: ["products"], task: "Liệt kê tên, nhóm hàng, giá của 10 sản phẩm có giá niêm yết cao nhất." },
        { ma: "d1-khach-ha-noi", domain: "customer", title: "Số khách ở Hà Nội ra 0", level: "basic", form: "debug", skill: "WHERE", tables: ["customers"], task: "Truy vấn lọc city = 'Ha Noi' nên ra 0. Sửa giá trị lọc cho đúng.", co_san: true },
        { ma: "r3-khach-55-email", domain: "marketing", title: "Khách 55+ ở Hà Nội đến từ email", level: "easy", form: "write", skill: "AND, IN", tables: ["customers"], task: "Khách nhóm tuổi 55+ ở Hanoi, kênh đăng ký là email_campaign hoặc referral; sắp theo customer_id." },
        { ma: "r4-khuyen-mai-2022", domain: "marketing", title: "Khuyến mãi bắt đầu trong năm 2022", level: "easy", form: "write", skill: "BETWEEN trên ngày", tables: ["promotions"], task: "Tên, loại, mức giảm của các chương trình bắt đầu trong năm 2022, sắp theo ngày bắt đầu." },
        { ma: "r5-ten-va-size", domain: "sales", title: "Sản phẩm SaigonFlex size S, M giá vừa", level: "medium", form: "write", skill: "LIKE, IN, BETWEEN", tables: ["products"], task: "Sản phẩm có tên bắt đầu bằng 'SaigonFlex', size S hoặc M, giá từ 1.000 đến 5.000." },
        { ma: "r6-don-dang-xu-ly", domain: "operations", title: "Đơn cuối năm chưa hoàn tất", level: "hard", form: "debug", skill: "NOT IN, thứ tự AND/OR", tables: ["orders"], task: "Truy vấn lấy đơn 7 ngày cuối 2022 chưa hoàn tất nhưng thiếu ngoặc quanh OR nên lẫn đơn của các năm khác. Sửa lại." }
      ]
    },
    {
      so: 2, id: "expressions", icon: "calc", name: "NULL & Expressions", vi: "Giá trị thiếu và cột tính toán",
      vidu: [
        { ma: "n3-nhan-muc-gia", domain: "sales", q: "Mỗi sản phẩm thuộc mức giá nào?", how: "CASE WHEN price < 1000 THEN 'Bình dân' WHEN … END" },
        { ma: "n1-lai-gop", domain: "finance", q: "Mỗi sản phẩm lãi gộp bao nhiêu?", how: "ROUND(price - cogs, 2) AS lai_gop" },
        { ma: "n4-bang-null", domain: "marketing", q: "Khuyến mãi nào áp dụng cho mọi nhóm hàng?", how: "WHERE applicable_category IS NULL   -- không phải = NULL" }
      ],
      desc: "Tạo cột mới từ phép tính, gán nhãn bằng CASE, và xử lý NULL, thứ hay làm sai kết quả nhất.",
      goals: [
        "Kiểm tra NULL bằng IS NULL, thay NULL bằng COALESCE",
        "Phép tính trên cột, làm tròn, tránh chia cho 0 bằng NULLIF",
        "Gán nhãn theo điều kiện bằng CASE WHEN"
      ],
      syntax: ["IS NULL", "IS NOT NULL", "COALESCE", "NULLIF", "+ − × ÷", "ROUND", "CASE WHEN", "CAST"],
      example: {
        task: "Biên lãi gộp và mức giá của từng sản phẩm",
        sql: "SELECT product_name,\n       ROUND(price - cogs, 2) AS lai_gop,\n       CASE WHEN price < 1000 THEN 'Bình dân'\n            WHEN price < 5000 THEN 'Trung'\n            ELSE 'Cao' END AS muc_gia\nFROM products;"
      },
      mistakes: [
        "= NULL không bao giờ đúng: phải viết IS NULL.",
        "Phép tính có một vế NULL thì cả kết quả là NULL.",
        "CASE dừng ở điều kiện đúng đầu tiên: đặt điều kiện hẹp lên trước."
      ],
      exercises: [
        { ma: "n1-lai-gop", domain: "finance", title: "Lãi gộp từng sản phẩm", level: "basic", form: "write", skill: "Phép tính, ROUND", tables: ["products"], task: "Tên sản phẩm, giá, giá vốn và lãi gộp (giá − giá vốn) làm tròn 2 chữ số." },
        { ma: "n2-dong-khong-ma", domain: "marketing", title: "Dòng hàng không dùng mã giảm giá", level: "basic", form: "write", skill: "IS NULL", tables: ["order_items"], task: "20 dòng hàng đầu tiên (theo order_id) không dùng mã khuyến mãi nào." },
        { ma: "n3-nhan-muc-gia", domain: "sales", title: "Gán nhãn mức giá", level: "easy", form: "write", skill: "CASE WHEN", tables: ["products"], task: "Thêm cột muc_gia: dưới 1.000 là Bình dân, dưới 5.000 là Trung, còn lại là Cao." },
        { ma: "n4-bang-null", domain: "marketing", title: "Khuyến mãi áp dụng mọi nhóm ra 0", level: "easy", form: "debug", skill: "= NULL và IS NULL", tables: ["promotions"], task: "Truy vấn lọc applicable_category = NULL nên không ra chương trình nào. Sửa lại." },
        { ma: "n5-ty-le-chiet-khau", domain: "finance", title: "Tỷ lệ chiết khấu từng dòng hàng", level: "medium", form: "write", skill: "NULLIF, ROUND", tables: ["order_items"], task: "Tỷ lệ chiết khấu = discount_amount / (quantity × unit_price), tính bằng %, an toàn khi mẫu số bằng 0." },
        { ma: "n6-mo-ta-khuyen-mai", domain: "marketing", title: "Mô tả chương trình khuyến mãi", level: "hard", form: "write", skill: "COALESCE, CASE lồng", tables: ["promotions"], task: "Một cột mô tả dạng 'Giảm 20% · Mọi nhóm hàng' hoặc 'Giảm 50 · Outdoor' từ promo_type, discount_value, applicable_category." }
      ]
    },
    {
      so: 3, id: "string-date", icon: "calendar", name: "String & Date", vi: "Xử lý chữ và ngày tháng",
      vidu: [
        { ma: "s4-giao-qua-7-ngay", domain: "operations", q: "Đơn nào giao quá 7 ngày kể từ lúc gửi?", how: "DATEDIFF(delivery_date, ship_date) > 7" },
        { ma: "s3-don-cuoi-tuan", domain: "sales", q: "Đơn tháng 12 nào được đặt vào cuối tuần?", how: "DAYOFWEEK(order_date) IN (1, 7)" },
        { ma: "s6-khuyen-mai-qua-nam", domain: "marketing", q: "Chương trình khuyến mãi nào kéo dài qua năm mới?", how: "YEAR(end_date) <> YEAR(start_date)" }
      ],
      desc: "Cắt, ghép, chuẩn hoá chữ; tách năm, tháng, thứ; tính khoảng cách giữa hai ngày.",
      goals: [
        "Ghép, cắt, chuẩn hoá chuỗi",
        "Tách năm, tháng, thứ trong tuần; định dạng ngày",
        "Tính số ngày giữa hai mốc, cộng trừ ngày"
      ],
      syntax: ["CONCAT", "TRIM", "UPPER / LOWER", "SUBSTRING_INDEX", "YEAR / MONTH", "DATE_FORMAT", "DAYOFWEEK", "DATEDIFF", "DATE_ADD"],
      example: {
        task: "Số ngày giao hàng của từng đơn",
        sql: "SELECT order_id, ship_date, delivery_date,\n       DATEDIFF(delivery_date, ship_date) AS so_ngay_giao\nFROM shipments\nORDER BY so_ngay_giao DESC\nLIMIT 20;"
      },
      mistakes: [
        "DATE_FORMAT(d, '%Y-%M') ra tên tháng, sắp theo chữ cái chứ không theo thứ tự tháng: dùng '%Y-%m'.",
        "DATEDIFF(a, b) là a − b: đảo vị trí thì ra số âm.",
        "Hàm bọc quanh cột ngày trong WHERE (YEAR(order_date) = 2022) làm MySQL không dùng được chỉ mục."
      ],
      exercises: [
        { ma: "s1-so-ngay-giao", domain: "operations", title: "Số ngày giao hàng", level: "basic", form: "write", skill: "DATEDIFF", tables: ["shipments"], task: "20 đơn giao lâu nhất: order_id, ngày gửi, ngày giao, số ngày giao." },
        { ma: "s2-thuong-hieu", domain: "sales", title: "Tách thương hiệu từ tên sản phẩm", level: "basic", form: "write", skill: "SUBSTRING_INDEX", tables: ["products"], task: "Thương hiệu là phần trước dấu cách đầu tiên của product_name. Liệt kê các thương hiệu khác nhau." },
        { ma: "s3-don-cuoi-tuan", domain: "sales", title: "Đơn đặt vào cuối tuần", level: "easy", form: "write", skill: "DAYOFWEEK", tables: ["orders"], task: "Đơn tháng 12/2022 đặt vào thứ Bảy hoặc Chủ nhật, kèm tên thứ." },
        { ma: "s4-giao-qua-7-ngay", domain: "operations", title: "Đơn giao quá 7 ngày", level: "easy", form: "write", skill: "DATEDIFF, DATE_ADD", tables: ["shipments"], task: "Đơn có ngày giao muộn hơn ngày gửi cộng 7 ngày, năm 2022." },
        { ma: "s5-thang-sai-thu-tu", domain: "sales", title: "Báo cáo tháng sắp sai thứ tự", level: "medium", form: "debug", skill: "DATE_FORMAT", tables: ["orders"], task: "Cột tháng dùng '%Y-%M' nên April đứng trước January. Sửa để sắp đúng thứ tự tháng." },
        { ma: "s6-khuyen-mai-qua-nam", domain: "marketing", title: "Khuyến mãi kéo dài qua năm mới", level: "hard", form: "write", skill: "YEAR, DATEDIFF, DATE_FORMAT", tables: ["promotions"], task: "Chương trình có ngày kết thúc khác năm với ngày bắt đầu: tên, số ngày chạy, tháng bắt đầu dạng 'MM/YYYY'." }
      ]
    },
    {
      so: 4, id: "aggregation", icon: "sigma", name: "Aggregation", vi: "Gom nhóm và tính chỉ số",
      vidu: [
        { ma: "a5-ty-le-huy-thanh-toan", domain: "finance", q: "Cách thanh toán nào bị huỷ đơn nhiều nhất?", how: "GROUP BY payment_method + SUM(CASE WHEN order_status = 'cancelled' …)" },
        { ma: "w1-don-huy-2022", domain: "sales", q: "Năm 2022 bị huỷ bao nhiêu đơn?", how: "COUNT(*) … WHERE order_status = 'cancelled'" },
        { ma: "d2-khach-mua-2022", domain: "customer", q: "Năm 2022 có bao nhiêu khách mua hàng?", how: "COUNT(DISTINCT customer_id)   -- không phải COUNT(*)" }
      ],
      desc: "Biến nhiều dòng thành con số: đếm, cộng, trung bình theo nhóm; lọc nhóm; đếm có điều kiện.",
      goals: [
        "Dùng COUNT, SUM, AVG, MIN, MAX và COUNT(DISTINCT)",
        "Gom theo một hoặc nhiều cột; lọc nhóm bằng HAVING",
        "Đếm và cộng có điều kiện bằng CASE trong hàm gộp"
      ],
      syntax: ["COUNT(*)", "COUNT(DISTINCT)", "SUM", "AVG", "MIN / MAX", "GROUP BY", "HAVING", "SUM(CASE WHEN …)"],
      example: {
        task: "Số đơn và tỷ lệ huỷ theo cách thanh toán, năm 2022",
        sql: "SELECT payment_method,\n       COUNT(*) AS so_don,\n       ROUND(100 * SUM(order_status = 'cancelled') / COUNT(*), 1) AS ty_le_huy\nFROM orders\nWHERE order_date >= '2022-01-01' AND order_date < '2023-01-01'\nGROUP BY payment_method\nORDER BY ty_le_huy DESC;"
      },
      mistakes: [
        "COUNT(*) đếm dòng, không đếm đối tượng: số khách phải dùng COUNT(DISTINCT customer_id).",
        "WHERE lọc dòng trước khi gom, HAVING lọc nhóm sau khi gom.",
        "Trung bình của các tỷ lệ khác tỷ lệ của tổng."
      ],
      exercises: [
        { ma: "w1-don-huy-2022", domain: "sales", title: "Có bao nhiêu đơn bị huỷ năm 2022?", level: "basic", form: "write", skill: "COUNT, WHERE", tables: ["orders"], task: "Đếm đơn trạng thái cancelled đặt trong năm 2022.", co_san: true },
        { ma: "a2-khach-theo-tuoi", domain: "customer", title: "Số khách theo nhóm tuổi", level: "basic", form: "write", skill: "GROUP BY", tables: ["customers"], task: "Số khách mỗi nhóm tuổi, sắp theo số khách giảm dần." },
        { ma: "d2-khach-mua-2022", domain: "customer", title: "Số khách mua năm 2022 cao bất thường", level: "easy", form: "debug", skill: "COUNT DISTINCT", tables: ["orders"], task: "Truy vấn đếm dòng đơn thay vì đếm khách. Sửa cho đúng.", co_san: true },
        { ma: "a4-thanh-pho-dong-khach", domain: "customer", title: "Thành phố có trên 3.000 khách", level: "easy", form: "write", skill: "HAVING", tables: ["customers"], task: "Thành phố và số khách, chỉ giữ thành phố có trên 3.000 khách." },
        { ma: "a5-ty-le-huy-thanh-toan", domain: "finance", title: "Tỷ lệ huỷ theo cách thanh toán", level: "medium", form: "write", skill: "SUM(CASE …)", tables: ["orders"], task: "Năm 2022: mỗi cách thanh toán có số đơn, số đơn huỷ, tỷ lệ huỷ (%)." },
        { ma: "a6-trung-binh-ty-le", domain: "finance", title: "Tỷ lệ chiết khấu toàn công ty bị sai", level: "hard", form: "debug", skill: "Tỷ lệ của tổng", tables: ["order_items"], task: "Báo cáo lấy AVG của tỷ lệ chiết khấu từng dòng. Sửa thành tổng chiết khấu chia tổng tiền hàng." }
      ]
    },
    {
      so: 5, id: "joins", icon: "link", name: "Joins", vi: "Ghép nhiều bảng",
      vidu: [
        { ma: "j3-khach-chua-mua", domain: "customer", q: "Bao nhiêu khách đăng ký mà chưa từng mua?", how: "customers LEFT JOIN orders … WHERE o.order_id IS NULL" },
        { ma: "j5-doanh-thu-nhom-hang", domain: "sales", q: "Nhóm hàng nào mang về nhiều doanh thu thuần nhất?", how: "orders JOIN order_items JOIN products … GROUP BY category" },
        { ma: "d3-doanh-thu-q4", domain: "finance", q: "Vì sao doanh thu quý 4 trên dashboard cao hơn sổ sách?", how: "bỏ JOIN order_items: nối một–nhiều làm cộng trùng payment_value" },
        { ma: "j1-don-kem-vung", domain: "operations", q: "Đơn mới nhất được giao tới thành phố, vùng nào?", how: "orders JOIN geography ON geography.zip = orders.zip" }
      ],
      desc: "Nối bảng theo khoá, giữ dòng không có cặp, tránh cộng trùng khi nối bảng một với bảng nhiều.",
      goals: [
        "Nối hai, ba bảng bằng INNER JOIN theo khoá",
        "Dùng LEFT JOIN để giữ dòng không có cặp, tìm dòng thiếu",
        "Nhận ra nhân dòng (fan-out) và cộng trùng"
      ],
      syntax: ["INNER JOIN", "LEFT JOIN", "ON", "nối nhiều bảng", "tự nối bảng", "LEFT JOIN … IS NULL"],
      example: {
        task: "Số đơn theo vùng giao hàng, năm 2022",
        sql: "SELECT g.region, COUNT(*) AS so_don\nFROM orders o\nJOIN geography g ON g.zip = o.zip\nWHERE o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'\nGROUP BY g.region\nORDER BY so_don DESC;"
      },
      mistakes: [
        "Nối orders với order_items rồi cộng payment_value: mỗi đơn bị cộng nhiều lần.",
        "Điều kiện của bảng bên phải đặt trong WHERE biến LEFT JOIN thành INNER JOIN.",
        "Nối sai cột (ví dụ customers.zip thay vì orders.zip) vẫn chạy được nhưng sai nghĩa."
      ],
      exercises: [
        { ma: "j1-don-kem-vung", domain: "operations", title: "Đơn kèm thành phố và vùng giao", level: "basic", form: "write", skill: "INNER JOIN", tables: ["orders", "geography"], task: "20 đơn mới nhất: mã đơn, ngày, thành phố và vùng giao." },
        { ma: "w2-don-theo-vung", domain: "customer", title: "Số đơn theo vùng năm 2022", level: "easy", form: "write", skill: "JOIN, GROUP BY", tables: ["orders", "geography"], task: "Đếm đơn năm 2022 theo vùng của địa chỉ giao hàng.", co_san: true },
        { ma: "j3-khach-chua-mua", domain: "customer", title: "Khách chưa từng đặt đơn", level: "easy", form: "write", skill: "LEFT JOIN … IS NULL", tables: ["customers", "orders"], task: "Có bao nhiêu khách đã đăng ký nhưng chưa có đơn nào?" },
        { ma: "d3-doanh-thu-q4", domain: "finance", title: "Doanh thu quý 4/2022 cao hơn sổ sách", level: "medium", form: "debug", skill: "Fan-out", tables: ["orders", "payments", "order_items"], task: "JOIN thừa order_items làm tiền thanh toán bị cộng nhiều lần. Sửa cho khớp sổ sách.", co_san: true },
        { ma: "j5-doanh-thu-nhom-hang", domain: "sales", title: "Doanh thu thuần theo nhóm hàng", level: "medium", form: "write", skill: "Nối 3 bảng", tables: ["orders", "order_items", "products"], task: "Năm 2022, đơn không huỷ: doanh thu thuần (đã trừ chiết khấu) theo nhóm hàng." },
        { ma: "j6-mua-cung-don", domain: "sales", title: "Cặp sản phẩm hay mua cùng đơn", level: "hard", form: "write", skill: "Tự nối bảng", tables: ["order_items", "products"], task: "10 cặp nhóm hàng xuất hiện cùng một đơn nhiều nhất; mỗi cặp chỉ tính một lần (A, B) không tính (B, A)." }
      ]
    },
    {
      so: 6, id: "subqueries", icon: "layers", name: "Subqueries", vi: "Truy vấn con",
      vidu: [
        { ma: "q4-not-in-null", domain: "marketing", q: "Mã khuyến mãi nào chưa từng được dùng?", how: "WHERE NOT EXISTS (SELECT 1 FROM order_items …)" },
        { ma: "q1-tren-gia-trung-binh", domain: "sales", q: "Sản phẩm nào đắt hơn giá trung bình?", how: "WHERE price > (SELECT AVG(price) FROM products)" },
        { ma: "q2-khach-tung-tra-hang", domain: "after_sales", q: "Bao nhiêu khách từng có đơn bị trả?", how: "WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_status = 'returned')" },
        { ma: "q6-don-dau-tien", domain: "customer", q: "Đơn đầu tiên của mỗi khách là đơn nào?", how: "WHERE order_date = (SELECT MIN(order_date) FROM orders o2 WHERE o2.customer_id = o.customer_id)" }
      ],
      desc: "Dùng kết quả của một truy vấn bên trong truy vấn khác: so với một mức chuẩn, lọc theo một tập, tính hai tầng.",
      goals: [
        "Truy vấn con trả một giá trị để so sánh",
        "Lọc theo tập bằng IN, EXISTS, NOT EXISTS",
        "Bảng dẫn xuất trong FROM; truy vấn con tương quan"
      ],
      syntax: ["(SELECT …) một giá trị", "IN (SELECT …)", "EXISTS", "NOT EXISTS", "FROM (SELECT …) t", "truy vấn con tương quan"],
      example: {
        task: "Sản phẩm có giá cao hơn giá trung bình",
        sql: "SELECT product_name, price\nFROM products\nWHERE price > (SELECT AVG(price) FROM products)\nORDER BY price DESC;"
      },
      mistakes: [
        "NOT IN với tập có NULL luôn ra rỗng: dùng NOT EXISTS.",
        "Truy vấn con trả nhiều dòng đặt sau dấu = sẽ báo lỗi.",
        "Truy vấn con tương quan chạy lại cho từng dòng: chậm trên bảng lớn."
      ],
      exercises: [
        { ma: "q1-tren-gia-trung-binh", domain: "sales", title: "Sản phẩm trên giá trung bình", level: "basic", form: "write", skill: "Truy vấn con một giá trị", tables: ["products"], task: "Sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm." },
        { ma: "q2-khach-tung-tra-hang", domain: "after_sales", title: "Khách từng có đơn bị trả", level: "easy", form: "write", skill: "IN / EXISTS", tables: ["customers", "orders"], task: "Số khách có ít nhất một đơn trạng thái returned." },
        { ma: "q3-khach-chua-danh-gia", domain: "after_sales", title: "Khách mua nhưng chưa từng đánh giá", level: "easy", form: "write", skill: "NOT EXISTS", tables: ["orders", "reviews"], task: "Số khách có đơn delivered nhưng chưa viết đánh giá nào." },
        { ma: "q4-not-in-null", domain: "marketing", title: "Khuyến mãi chưa từng được dùng ra 0", level: "medium", form: "debug", skill: "NOT IN và NULL", tables: ["promotions", "order_items"], task: "NOT IN (SELECT promo_id FROM order_items) ra rỗng vì promo_id có NULL. Sửa lại." },
        { ma: "q5-don-moi-khach", domain: "customer", title: "Số đơn trung bình mỗi khách theo năm", level: "medium", form: "write", skill: "Bảng dẫn xuất", tables: ["orders"], task: "Đếm đơn của từng khách mỗi năm trong một truy vấn con, rồi lấy trung bình theo năm." },
        { ma: "q6-don-dau-tien", domain: "customer", title: "Đơn đầu tiên của mỗi khách", level: "hard", form: "write", skill: "Truy vấn con tương quan", tables: ["orders"], task: "Với mỗi khách: mã và ngày của đơn đầu tiên. Nhiều đơn cùng ngày thì lấy mã đơn nhỏ nhất." }
      ]
    },
    {
      so: 7, id: "cte-sets", icon: "steps", name: "CTE & Set Operations", vi: "Chia bước và ghép tập",
      vidu: [
        { ma: "t4-ty-le-tra-nhom-hang", domain: "after_sales", q: "Nhóm hàng nào bị trả hàng nhiều nhất?", how: "WITH giao AS (…), tra AS (…) rồi nối hai CTE" },
        { ma: "d4-retention-cohort", domain: "customer", q: "Khách mới quý 1/2022 có quay lại vào tháng sau không?", how: "WITH dau AS (SELECT customer_id, MIN(order_date) …) + EXISTS" },
        { ma: "t3-union-mat-dong", domain: "marketing", q: "Số đơn mỗi kênh của 2021 và 2022 trong một bảng?", how: "… UNION ALL …   -- UNION sẽ bỏ mất dòng trùng" }
      ],
      desc: "Viết truy vấn nhiều bước dễ đọc bằng WITH, sinh dãy giá trị bằng WITH RECURSIVE, ghép kết quả bằng UNION.",
      goals: [
        "Tách truy vấn thành các bước đặt tên bằng WITH",
        "Tính hai đại lượng riêng rồi mới nối, tránh cộng trùng",
        "Sinh dãy tháng bằng WITH RECURSIVE; ghép tập bằng UNION / UNION ALL"
      ],
      syntax: ["WITH … AS", "nhiều CTE", "WITH RECURSIVE", "UNION", "UNION ALL"],
      example: {
        task: "Tỷ lệ trả hàng theo nhóm hàng: tính giao và trả riêng rồi mới nối",
        sql: "WITH giao AS (\n  SELECT p.category, SUM(oi.quantity) AS sl_giao\n  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id\n  JOIN products p ON p.product_id = oi.product_id\n  WHERE o.order_status IN ('delivered', 'returned')\n  GROUP BY p.category\n), tra AS (\n  SELECT p.category, SUM(r.return_quantity) AS sl_tra\n  FROM returns r JOIN products p ON p.product_id = r.product_id\n  GROUP BY p.category\n)\nSELECT giao.category, ROUND(100 * tra.sl_tra / giao.sl_giao, 2) AS ty_le_tra\nFROM giao JOIN tra ON tra.category = giao.category;"
      },
      mistakes: [
        "UNION bỏ dòng trùng: cộng số liệu từ hai nguồn phải dùng UNION ALL.",
        "Gộp mọi phép tính vào một lần nối thường gây nhân dòng; tách CTE trước.",
        "Tháng không có dữ liệu biến mất khỏi kết quả: sinh dãy tháng rồi LEFT JOIN."
      ],
      exercises: [
        { ma: "t1-viet-lai-cte", domain: "customer", title: "Viết lại bảng dẫn xuất thành CTE", level: "basic", form: "write", skill: "WITH", tables: ["orders"], task: "Số khách theo số đơn đã mua (1 đơn, 2 đơn…), viết bằng CTE." },
        { ma: "t2-hoat-dong-khach", domain: "customer", title: "Dòng thời gian hoạt động của khách", level: "easy", form: "write", skill: "UNION ALL", tables: ["orders", "reviews"], task: "Gộp ngày đặt đơn và ngày đánh giá của khách 58578 vào một cột, kèm loại hoạt động, sắp theo ngày." },
        { ma: "t3-union-mat-dong", domain: "marketing", title: "Tổng đơn hai năm bị thiếu", level: "easy", form: "debug", skill: "UNION và UNION ALL", tables: ["orders"], task: "Ghép số đơn theo kênh của 2021 và 2022 bằng UNION nên mất dòng trùng giá trị. Sửa lại." },
        { ma: "t4-ty-le-tra-nhom-hang", domain: "after_sales", title: "Tỷ lệ trả theo nhóm hàng 2022", level: "medium", form: "write", skill: "Hai CTE rồi nối", tables: ["orders", "order_items", "products", "returns"], task: "Số lượng giao và số lượng trả tính trong hai CTE riêng, rồi ra tỷ lệ trả theo nhóm hàng." },
        { ma: "w4-ty-le-tra-danh-muc-vung", domain: "after_sales", title: "Tỷ lệ trả theo nhóm hàng và vùng", level: "hard", form: "write", skill: "CTE, LEFT JOIN", tables: ["orders", "order_items", "products", "returns", "geography"], task: "Tỷ lệ trả từng cặp nhóm hàng × vùng năm 2022, mẫu số chỉ gồm hàng đã giao.", co_san: true },
        { ma: "d4-retention-cohort", domain: "customer", title: "Cohort nào cũng giữ chân 100%", level: "hard", form: "debug", skill: "CTE, EXISTS", tables: ["orders"], task: "Hai lỗi chồng nhau: xếp cohort theo signup_date và INNER JOIN làm mất mẫu số. Sửa cả hai.", co_san: true },
        { ma: "t7-du-12-thang", domain: "after_sales", title: "Đủ 12 tháng, tháng trống hiện 0", level: "hard", form: "write", skill: "WITH RECURSIVE", tables: ["orders", "geography"], task: "Số đơn returned mỗi tháng năm 2022 giao tới Da Nang; tháng không có đơn vẫn hiện 0." }
      ]
    },
    {
      so: 8, id: "window", icon: "window", name: "Window Functions", vi: "Hàm cửa sổ",
      vidu: [
        { ma: "w3-top3-san-pham", domain: "sales", q: "Ba sản phẩm bán chạy nhất mỗi nhóm hàng?", how: "ROW_NUMBER() OVER (PARTITION BY category ORDER BY doanh_thu DESC)" },
        { ma: "f7-pareto-khach", domain: "customer", q: "Bao nhiêu phần trăm khách tạo ra 80% doanh thu?", how: "SUM(tien) OVER (ORDER BY tien DESC) / SUM(tien) OVER ()" },
        { ma: "f6-yoy-theo-thang", domain: "finance", q: "Doanh thu tháng này tăng bao nhiêu so với cùng kỳ năm trước?", how: "LAG(doanh_thu, 12) OVER (ORDER BY thang)" }
      ],
      desc: "Tính trên một nhóm dòng mà vẫn giữ từng dòng: xếp hạng trong nhóm, so với dòng trước, cộng dồn, trung bình trượt.",
      goals: [
        "Xếp hạng trong nhóm: ROW_NUMBER, RANK, DENSE_RANK",
        "So với kỳ trước, kỳ sau: LAG, LEAD",
        "Luỹ kế, trung bình trượt, tỷ trọng: SUM/AVG OVER với khung ROWS"
      ],
      syntax: ["OVER ()", "PARTITION BY", "ORDER BY trong OVER", "ROW_NUMBER", "RANK / DENSE_RANK", "LAG / LEAD", "SUM() OVER", "ROWS BETWEEN"],
      example: {
        task: "Doanh thu từng ngày, ngày hôm trước và luỹ kế trong năm",
        sql: "SELECT `Date`, Revenue,\n  LAG(Revenue) OVER (ORDER BY `Date`) AS hom_truoc,\n  SUM(Revenue) OVER (\n    PARTITION BY YEAR(`Date`)\n    ORDER BY `Date`\n  ) AS luy_ke_nam\nFROM sales\nWHERE `Date` >= '2022-01-01';"
      },
      mistakes: [
        "Hai giá trị bằng nhau: ROW_NUMBER vẫn chia hạng khác nhau; cần tiêu chí phụ hoặc dùng RANK.",
        "Không thể lọc hàm cửa sổ trong WHERE: tính trong CTE rồi lọc ở ngoài.",
        "Thiếu PARTITION BY thì xếp hạng trên toàn bảng, không theo nhóm."
      ],
      exercises: [
        { ma: "f1-thu-tu-don", domain: "customer", title: "Đơn thứ mấy của khách", level: "basic", form: "write", skill: "ROW_NUMBER", tables: ["orders"], task: "Với các đơn năm 2022 của 5 khách đầu tiên: số thứ tự đơn của từng khách theo ngày đặt." },
        { ma: "f2-doanh-thu-hom-truoc", domain: "finance", title: "Doanh thu so với hôm trước", level: "easy", form: "write", skill: "LAG", tables: ["sales"], task: "Tháng 12/2022: doanh thu mỗi ngày, ngày hôm trước và chênh lệch (%)." },
        { ma: "f3-hang-nhom-hang", domain: "sales", title: "Xếp hạng nhóm hàng theo doanh thu", level: "easy", form: "write", skill: "RANK", tables: ["order_items", "products"], task: "Doanh thu gộp theo nhóm hàng và hạng của mỗi nhóm." },
        { ma: "w3-top3-san-pham", domain: "sales", title: "Ba sản phẩm bán chạy nhất mỗi nhóm hàng", level: "medium", form: "write", skill: "ROW_NUMBER, PARTITION BY", tables: ["orders", "order_items", "products"], task: "Top 3 sản phẩm theo doanh thu gộp 2022 trong mỗi nhóm hàng; hoà thì product_id nhỏ hơn đứng trước.", co_san: true },
        { ma: "f5-trung-binh-truot", domain: "finance", title: "Trung bình trượt 7 ngày", level: "medium", form: "write", skill: "ROWS BETWEEN", tables: ["sales"], task: "Doanh thu và trung bình 7 ngày gần nhất (gồm ngày đó), quý 4/2022." },
        { ma: "f6-yoy-theo-thang", domain: "finance", title: "Tăng trưởng cùng kỳ theo tháng", level: "hard", form: "write", skill: "LAG 12", tables: ["sales"], task: "Doanh thu từng tháng 2021–2022 và % thay đổi so với cùng tháng năm trước." },
        { ma: "f7-pareto-khach", domain: "customer", title: "Bao nhiêu % khách tạo 80% doanh thu", level: "hard", form: "write", skill: "SUM OVER luỹ kế", tables: ["orders", "payments"], task: "Xếp khách theo tiền đã trả năm 2022, tính tỷ trọng luỹ kế, tìm phần trăm khách đầu tiên đạt 80%." }
      ]
    },
    {
      so: 9, id: "data-quality", icon: "shield", name: "Data Quality", vi: "Kiểm tra và đối soát dữ liệu",
      vidu: [
        { ma: "k2-giao-khong-van-chuyen", domain: "operations", q: "Bao nhiêu đơn đã giao mà không có bản ghi vận chuyển?", how: "orders LEFT JOIN shipments … WHERE s.order_id IS NULL" },
        { ma: "k1-dong-trung", domain: "sales", q: "Dòng hàng nào bị ghi trùng?", how: "GROUP BY order_id, product_id HAVING COUNT(*) > 1" },
        { ma: "k3-tra-khong-ban-ghi", domain: "after_sales", q: "Đơn bị trả nào không có bản ghi trả hàng?", how: "WHERE order_status = 'returned' AND NOT EXISTS (SELECT 1 FROM returns …)" },
        { ma: "k4-dang-ky-sau-mua", domain: "customer", q: "Ngày đăng ký của khách có tin được không?", how: "so signup_date với MIN(order_date) của từng khách" },
        { ma: "k6-doi-soat-doanh-thu", domain: "finance", q: "Doanh thu bảng sales có khớp chi tiết đơn hàng không?", how: "SUM(quantity * unit_price) theo ngày so với sales.Revenue" }
      ],
      desc: "Trước khi báo cáo, kiểm tra số liệu có tin được không: dòng trùng, dòng thiếu, giá trị lạ, hai nguồn lệch nhau.",
      goals: [
        "Tìm dòng trùng và dòng thiếu cặp",
        "Phát hiện giá trị bất thường, ngoại lai",
        "Đối soát hai nguồn số liệu và giải thích phần chênh"
      ],
      syntax: ["GROUP BY … HAVING COUNT(*) > 1", "LEFT JOIN … IS NULL", "NOT EXISTS", "MIN / MAX / AVG", "so hai truy vấn tổng hợp"],
      example: {
        task: "Cặp (đơn, sản phẩm) xuất hiện nhiều hơn một lần",
        sql: "SELECT order_id, product_id, COUNT(*) AS so_dong\nFROM order_items\nGROUP BY order_id, product_id\nHAVING COUNT(*) > 1;"
      },
      mistakes: [
        "Bảng tổng hợp sẵn (sales) dùng định nghĩa khác bảng chi tiết: gồm cả đơn huỷ, chưa trừ chiết khấu.",
        "Cột khai báo (signup_date) có thể không đáng tin: kiểm tra với dữ liệu giao dịch.",
        "Ngoại lai kéo lệch trung bình: xem thêm MIN, MAX, phân vị."
      ],
      exercises: [
        { ma: "k1-dong-trung", domain: "sales", title: "Dòng hàng bị trùng", level: "basic", form: "write", skill: "HAVING COUNT > 1", tables: ["order_items"], task: "Các cặp (order_id, product_id) xuất hiện hơn một lần." },
        { ma: "k2-giao-khong-van-chuyen", domain: "operations", title: "Đơn đã giao nhưng không có vận chuyển", level: "easy", form: "write", skill: "LEFT JOIN … IS NULL", tables: ["orders", "shipments"], task: "Đếm đơn delivered không có dòng nào trong shipments." },
        { ma: "k3-tra-khong-ban-ghi", domain: "after_sales", title: "Đơn bị trả nhưng không có bản ghi trả", level: "easy", form: "write", skill: "NOT EXISTS", tables: ["orders", "returns"], task: "Đơn trạng thái returned không có dòng nào trong returns." },
        { ma: "k4-dang-ky-sau-mua", domain: "customer", title: "Ngày đăng ký sau ngày mua đầu tiên", level: "medium", form: "write", skill: "MIN, JOIN", tables: ["customers", "orders"], task: "Bao nhiêu % khách có mua hàng có signup_date muộn hơn đơn đầu tiên?" },
        { ma: "k5-ton-kho-bat-thuong", domain: "operations", title: "Số ngày tồn kho bất thường", level: "medium", form: "write", skill: "Ngoại lai", tables: ["inventory"], task: "Theo nhóm hàng: số dòng days_of_supply trên 1.000, giá trị lớn nhất, trung vị gần đúng." },
        { ma: "k6-doi-soat-doanh-thu", domain: "finance", title: "Đối soát sales.Revenue với chi tiết đơn", level: "hard", form: "write", skill: "Đối soát hai nguồn", tables: ["sales", "orders", "order_items"], task: "So doanh thu ngày trong sales với tổng quantity × unit_price từ order_items; chỉ ra định nghĩa nào làm hai số khớp." }
      ]
    },
    {
      so: 10, id: "performance", icon: "bolt", name: "Query Performance", vi: "Viết truy vấn chạy nhanh",
      vidu: [
        { ma: "o4-luy-ke-doanh-thu", domain: "finance", q: "Doanh thu luỹ kế trong năm, chạy nhanh hơn?", how: "SUM(Revenue) OVER (PARTITION BY YEAR(`Date`) ORDER BY `Date`)   -- thay tự nối bảng" },
        { ma: "o1-dem-don-theo-trang-thai", domain: "sales", q: "Đếm đơn huỷ, giao, trả chỉ với một lần quét bảng?", how: "COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END), …" },
        { ma: "p5-bo-tuong-quan", domain: "customer", q: "Số đơn của từng khách mà không chạy truy vấn con cho mỗi khách?", how: "customers LEFT JOIN orders … GROUP BY customer_id" }
      ],
      desc: "Cùng một kết quả nhưng đọc ít dữ liệu hơn: đọc kế hoạch chạy, dùng được chỉ mục, không quét bảng nhiều lần.",
      goals: [
        "Đọc EXPLAIN / EXPLAIN ANALYZE: bảng nào bị quét, bao nhiêu dòng",
        "Viết điều kiện dùng được chỉ mục",
        "Gộp nhiều lần quét thành một; thay tự nối bảng bằng hàm cửa sổ"
      ],
      syntax: ["EXPLAIN", "EXPLAIN ANALYZE", "chỉ mục (INDEX)", "đếm có điều kiện", "hàm cửa sổ thay tự nối"],
      example: {
        task: "Điều kiện dùng được chỉ mục trên order_date",
        sql: "-- Chậm: hàm bọc quanh cột, không dùng được chỉ mục\nSELECT COUNT(*) FROM orders WHERE YEAR(order_date) = 2022;\n\n-- Nhanh: so sánh trực tiếp trên cột\nSELECT COUNT(*) FROM orders\nWHERE order_date >= '2022-01-01' AND order_date < '2023-01-01';"
      },
      mistakes: [
        "Mỗi truy vấn con hay mỗi nhánh UNION thường quét lại bảng một lần.",
        "Tự nối bảng với điều kiện <= để cộng dồn: số dòng tăng theo bình phương.",
        "Đo bằng thời gian chạy không ổn định: so số lần quét và số dòng trong kế hoạch."
      ],
      exercises: [
        { ma: "o1-dem-don-theo-trang-thai", domain: "sales", title: "Đếm đơn theo trạng thái với một lần quét", level: "basic", form: "optimize", skill: "Đếm có điều kiện", tables: ["orders"], task: "Ba truy vấn con quét orders 3 lần; viết lại chỉ quét 1 lần.", co_san: true },
        { ma: "o2-doanh-thu-theo-nam", domain: "sales", title: "Doanh thu gộp 4 năm bằng một truy vấn", level: "easy", form: "optimize", skill: "GROUP BY thay UNION ALL", tables: ["orders", "order_items"], task: "Bốn nhánh UNION ALL quét lại bảng 4 lần; gom bằng một GROUP BY.", co_san: true },
        { ma: "p3-dung-chi-muc", domain: "sales", title: "Lọc năm dùng được chỉ mục", level: "easy", form: "optimize", skill: "Điều kiện trên cột", tables: ["orders"], task: "Thay YEAR(order_date) = 2022 bằng khoảng ngày để MySQL dùng chỉ mục; so số dòng đọc trong EXPLAIN ANALYZE." },
        { ma: "o3-san-pham-tren-trung-binh", domain: "sales", title: "Sản phẩm trên trung bình nhóm, không tính hai lần", level: "medium", form: "optimize", skill: "AVG() OVER", tables: ["orders", "order_items", "products"], task: "Truy vấn tính doanh thu sản phẩm hai lần; dùng hàm cửa sổ để chỉ tính một lần.", co_san: true },
        { ma: "p5-bo-tuong-quan", domain: "customer", title: "Bỏ truy vấn con tương quan", level: "medium", form: "optimize", skill: "JOIN + GROUP BY", tables: ["customers", "orders"], task: "Số đơn của từng khách được tính bằng truy vấn con chạy cho mỗi khách; viết lại bằng một lần gom." },
        { ma: "o4-luy-ke-doanh-thu", domain: "finance", title: "Doanh thu luỹ kế không dùng tự nối bảng", level: "hard", form: "optimize", skill: "SUM() OVER", tables: ["sales"], task: "Tự nối sales sinh hơn 5 triệu dòng trung gian; dùng SUM() OVER để giảm còn khoảng 10 nghìn.", co_san: true }
      ]
    }
  ]
};
