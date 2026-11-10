# Dòng bản đồ v4 · gói 4 Marketing (11/11/2026)

Dùng để thay các dòng tương ứng trong `../../BAN-DO-100-CAU.md` (mục "Gói 4 · M7 CTE & Set Operations, M8 Window Functions"); agent gói 4 không sửa thẳng bản đồ. Cột lấy từ `cau-hoi.tex` và khối `solution` của `solution.sql` theo cách sinh của bản đồ bản 2 (đề một câu: hai mục đầu của `yeucau`, cắt ở 200 ký tự; bảng: `FROM`/`JOIN` của lời giải, bỏ CTE). Chín câu đổi cấp và t5 (giữ cấp Khó, khoảng xét rút từ quý 1 về tháng 1/2025 vì thời gian chạy) cần thay dòng; mười câu còn lại (t1, t3, t4, t7, f1, f4, f5, f9, c7, c8) giữ nguyên dòng cũ.

| Mã cũ (dòng bị thay) | Mã mới | Cấp cũ → mới |
|---|---|---|
| mkt-t2-pheu-dang-dai | mkt-t2-pheu-dang-dai (giữ mã) | medium → easy |
| mkt-t5-dang-chay-binh-quan-theo-tuan | mkt-t5-dang-chay-binh-quan-theo-tuan (giữ mã) | hard → hard (đổi đề một câu, bẫy) |
| mkt-t6-phan-nhom-roi-ctr | mkt-t6-so-chien-dich-theo-so-kenh | hard → basic |
| mkt-t8-ty-le-roi-pheu-sai-mau | mkt-t8-ty-le-roi-pheu-sai-mau (giữ mã) | medium → easy |
| mkt-t9-bo-trung-khong-het | mkt-t9-bo-trung-khong-het (giữ mã) | hard → basic |
| mkt-f2-mom-purplle | mkt-f2-mom-purplle (giữ mã) | medium → easy |
| mkt-f3-truot-7-ngay-tira | mkt-f3-hang-luot-nhap-trong-ngay | hard → basic |
| mkt-f6-nhom-gia-tri-don-theo-phan-khuc | mkt-f6-nhom-gia-tri-don-theo-phan-khuc (giữ mã) | medium → easy |
| mkt-f7-chi-phi-luy-ke-nhay-bac | mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang | medium → basic |
| mkt-f8-lag-khong-chia-thuong-hieu | mkt-f8-thang-truoc-lay-so-thang-sau | hard → easy |

Dòng mới (cùng định dạng bảng của bản đồ: Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính):

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-t2-pheu-dang-dai | 4 | M7 | W | easy | D1 | mkt | Phễu bốn tầng của từng thương hiệu quý 1/2025 | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Ở mỗi thương hiệu, tính tổng số lượng của bốn tầng: nhận biết là tổng `impressions`, quan tâm là tổng `clicks`, cân nhắc là tổng ` … | C | thu-tu-tang |
| mkt-t5-dang-chay-binh-quan-theo-tuan | 4 | M7 | W | hard | B4 | ops | Bình quân mỗi ngày có bao nhiêu chiến dịch đang chạy? | Xét mọi ngày trong lịch từ ngày 1/1/2025 tới hết ngày 31/1/2025. · Đếm cho mỗi ngày số chiến dịch đang chạy (cả ba thương hiệu) như định nghĩa ở tab Nghiệp vụ, rồi gom các ngày theo tuần. | K, C | bo-chien-dich-bat-dau-truoc-ky, lech-bien-ngay-cuoi, can-tren-lay-them-ngay, tuan-chua-du |
| mkt-t6-so-chien-dich-theo-so-kenh | 4 | M7 | W | basic | A3 | mkt | Bao nhiêu chiến dịch chạy trên một, hai hay ba kênh? | Xét mọi dòng của `campaign_channels`; mỗi dòng là một kênh của một chiến dịch. · Số kênh của một chiến dịch là số dòng có cùng `campaign_id`. Đếm số kênh của từng chiến dịch, rồi đếm số chiến dịch the … | CC | nham-thu-tu-kenh-voi-so-kenh |
| mkt-t8-ty-le-roi-pheu-sai-mau | 4 | M7 | D | easy | D1 | mkt | Tỷ lệ rơi ở tầng cuối của phễu gần 100% | Truy vấn dưới đây tính tỷ lệ rơi của ba tầng quan tâm, cân nhắc, chuyển đổi ở mỗi loại chiến dịch bắt đầu trong tháng 5/2025, trên tổng của từng loại. · Tỷ lệ rơi của một tầng bằng 1 trừ (tổng tầng đó … | C | mau-so-tang-dau |
| mkt-t9-bo-trung-khong-het | 4 | M7 | D | basic | E1 | ops | Bỏ dòng trùng xong số dòng dữ liệu thô vẫn không đổi | Truy vấn dưới đây bỏ dòng trùng của `campaigns_raw` trong CTE rồi đếm số dòng, cộng doanh thu theo thương hiệu, nhưng không bỏ được dòng nào. · Hai dòng trùng hoàn toàn khi giống nhau ở mọi cột trừ `r … | R | cot-vi-tri |
| mkt-f2-mom-purplle | 4 | M8 | W | easy | B2 | sal | Doanh thu Purplle tăng giảm bao nhiêu so với tháng trước? | Xét các chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ ngày 1/7/2024 tới hết ngày 31/5/2025. · Tính doanh thu theo tháng của ngày bắt đầu chiến dịch. Mức thay đổi so với tháng trước bằng (doanh th … | C | mau-so-thang-truoc |
| mkt-f3-hang-luot-nhap-trong-ngay | 4 | M8 | W | basic | C1 | mkt | Thứ hạng lượt nhấp trong ngày của chiến dịch Social Media Purplle | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Social Media (marketing mạng xã hội, `type_id = 5`), ngôn ngữ English (`language_id = 2`), bắt đầu ngày 3/3/2025 hoặc ngày 4/3/2025. · Đánh số thứ … | C | thieu-partition |
| mkt-f6-nhom-gia-tri-don-theo-phan-khuc | 4 | M8 | W | easy | C4 | cus | Nhóm chiến dịch giá trị đơn cao nhất của từng phân khúc | Xét các chiến dịch bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Giá trị đơn bình quân của một chiến dịch bằng `revenue` chia `conversions`. | C | ntile-nhom-le |
| mkt-f7-chi-phi-luy-ke-ngay-nao-cung-bang | 4 | M8 | D | basic | B3 | fin | Chi phí luỹ kế quý 2 của Nykaa ngày nào cũng bằng nhau | Truy vấn dưới đây gom chi phí chiến dịch theo ngày bắt đầu của các chiến dịch Nykaa từ ngày 1/4/2025 tới hết ngày 30/6/2025, rồi tính chi phí luỹ kế, nhưng mọi ngày ra cùng một số. · Sửa để `chi_phi_l … | C | thieu-order-by-trong-over |
| mkt-f8-thang-truoc-lay-so-thang-sau | 4 | M8 | D | easy | B2 | mkt | Số chiến dịch tháng trước của Tira Beauty lại lấy số tháng sau | Truy vấn dưới đây đếm số chiến dịch Tira Beauty bắt đầu trong từng tháng từ tháng 7/2024 tới hết tháng 5/2025, rồi lấy số của tháng liền trước, nhưng cột tháng trước đang lấy nhầm tháng. · Sửa để `so_ … | C | nham-lag-lead |

Thống kê gói 4 sau v4 (cho phần thống kê cuối bản đồ): M7 2 basic · 3 easy · 2 medium · 2 hard (6 W + 3 D); M8 2 basic · 3 easy · 2 medium · 2 hard (6 W + 3 D); case c7 medium, c8 hard (không đổi).
