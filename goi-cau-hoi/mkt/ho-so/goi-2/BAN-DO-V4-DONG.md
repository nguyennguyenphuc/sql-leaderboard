# Dòng bản đồ v4 · gói 2 Marketing (11/11/2026)

Dùng để thay các dòng tương ứng trong `../../BAN-DO-100-CAU.md` (mục "Gói 2 · M3 String & Date, M4 Aggregation"); agent gói 2 không sửa thẳng bản đồ. Cột lấy từ `cau-hoi.tex` và khối `solution` của `solution.sql` theo cách sinh của bản đồ bản 2 (đề một câu: hai mục đầu của `yeucau`, cắt ở 200 ký tự; bảng: `FROM`/`JOIN` của lời giải, bỏ CTE). Tám câu đổi; mười hai câu còn lại (s2, s4, s5, s6, s7, a2, a4, a5, a8, a9, c3, c4) giữ nguyên dòng cũ.

| Mã cũ (dòng bị thay) | Mã mới | Cấp cũ → mới |
|---|---|---|
| mkt-s1-social-nykaa-theo-thang | mkt-s1-social-nykaa-chay-sang-thang-sau | basic → medium |
| mkt-s3-bat-dau-cuoi-tuan | mkt-s3-tong-ket-cho-qua-cuoi-tuan | easy → hard |
| mkt-s8-thang-sap-sai-thu-tu | mkt-s8-tuan-dau-nam-bi-tach-doi | easy → medium |
| mkt-s9-dang-chay-ngay-1-1 | mkt-s9-dang-chay-dau-thang-lech | easy → hard |
| mkt-a1-roi-tong-theo-thuong-hieu | mkt-a1-chi-phi-cho-chien-dich-lo | easy → hard |
| mkt-a3-doi-tuong-quy-1 | mkt-a3-doi-tuong-quy-1 (giữ mã) | easy → basic |
| mkt-a6-doanh-thu-nykaa-theo-thang | mkt-a6-doanh-thu-nykaa-theo-thang (giữ mã) | easy → basic |
| mkt-a7-roi-thuong-hieu-cao-bat-thuong | mkt-a7-roi-thang-nykaa-lech-tai-chinh | easy → hard |

Dòng mới (cùng định dạng bảng của bản đồ: Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính):

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-s1-social-nykaa-chay-sang-thang-sau | 2 | M3 | W | medium | B1 | mkt | Bao nhiêu chiến dịch mạng xã hội Nykaa chạy sang tháng sau? | Xét các chiến dịch của Nykaa (`brand_id = 1`), loại Social Media (marketing mạng xã hội, `type_id = 5`), bắt đầu từ ngày 1/7/2024 tới hết ngày 31/5/2025 (11 tháng đủ). · Theo tháng của ngày bắt đầu, đ … | C | lech-mot-ngay-ngay-cuoi, so-thang-qua-nam, giu-thang-chua-du |
| mkt-s3-tong-ket-cho-qua-cuoi-tuan | 2 | M3 | W | hard | A3 | ops | Bao nhiêu chiến dịch phải chờ qua cuối tuần mới được tổng kết? | Xét mọi chiến dịch của ba thương hiệu bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Theo loại chiến dịch, tính số chiến dịch, số chiến dịch phải chờ họp tổng kết, tỷ lệ phải chờ và tổng số ngày c … | C | xet-thu-ngay-cuoi, dayofweek-1-la-chu-nhat, dem-ngay-cho-nguoc, thieu-can-tren |
| mkt-s8-tuan-dau-nam-bi-tach-doi | 2 | M3 | D | medium | B1 | mkt | Số chiến dịch theo tuần bị tách đôi ở tuần đầu năm | Truy vấn dưới đây cần đếm số chiến dịch của ba thương hiệu bắt đầu trong từng tuần, tuần tính từ thứ Hai tới hết Chủ nhật, cho 9 tuần từ tuần bắt đầu ngày 2/12/2024 tới tuần bắt đầu ngày 27/1/2025. · … | C | tuan-tach-o-ranh-gioi-nam, dayofweek-1-la-chu-nhat |
| mkt-s9-dang-chay-dau-thang-lech | 2 | M3 | D | hard | B4 | ops | Số chiến dịch đang chạy ngày đầu tháng lệch lịch chạy | Truy vấn dưới đây cần đếm số chiến dịch của ba thương hiệu đang chạy (khái niệm ở tab Nghiệp vụ) vào ngày 1 của từng tháng, từ ngày 1/8/2024 tới ngày 1/6/2025. · Truy vấn có ba lỗi chồng nhau. Sửa cho … | K, C | bo-ngay-bat-dau, lech-mot-ngay-ngay-cuoi, thieu-can-tren |
| mkt-a1-chi-phi-cho-chien-dich-lo | 2 | M4 | W | hard | A2 | fin | Mỗi thương hiệu chi bao nhiêu cho chiến dịch lỗ? | Xét các chiến dịch bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Theo từng thương hiệu, tính số chiến dịch, số chiến dịch lỗ, tỷ trọng chi phí của các chiến dịch lỗ trong tổng chi phí chiến dịch … | C | lo-theo-cot-roi-lam-tron, nham-cpa-voi-tong-chi-phi, ty-trong-theo-so-dem, avg-cua-ty-le, thieu-can-tren |
| mkt-a3-doi-tuong-quy-1 | 2 | M4 | W | basic | A3 | cus | Nhóm đối tượng nào dẫn đầu doanh thu quý 1/2025? | Xét các chiến dịch của ba thương hiệu bắt đầu từ ngày 1/1/2025 tới hết ngày 31/3/2025. · Tính số chiến dịch và tổng doanh thu của từng nhóm đối tượng mục tiêu (`target_audience_id`). | C | thieu-can-tren |
| mkt-a6-doanh-thu-nykaa-theo-thang | 2 | M4 | W | basic | B1 | sal | Lượt chuyển đổi và doanh thu của Nykaa theo tháng | Xét các chiến dịch của Nykaa (`brand_id = 1`) bắt đầu từ ngày 1/7/2024 tới hết ngày 30/6/2025. · Theo tháng của ngày bắt đầu, đếm số chiến dịch và cộng lượt chuyển đổi (`conversions`), doanh thu (`rev … | C | thieu-can-tren |
| mkt-a7-roi-thang-nykaa-lech-tai-chinh | 2 | M4 | D | hard | B1 | fin | Chi phí và ROI theo tháng của Nykaa lệch số tài chính | Truy vấn dưới đây cần tính, theo tháng của ngày bắt đầu, số chiến dịch, tổng chi phí chiến dịch và ROI (lợi tức đầu tư) theo tỷ lệ của tổng của các chiến dịch Nykaa (`brand_id = 1`), loại Social Media … | C | nham-cpa-voi-tong-chi-phi, avg-cua-ty-le, nham-roi-voi-roas, thieu-can-tren |

Ô mới (dạng · mảng · cấp · hình thức) đã so với `cau-hoi.tex` của gói 1, 3, 4, 5 lúc 11/11 (các gói đang được sửa song song): không trùng. Hai ô đã tránh khi đối chiếu: A2 · fin · hard · D (trùng `mkt-n9-cpc-cpm-nykaa-thang-6-lech` gói 1, nên a7 chuyển sang B1) và A3 · mkt · basic · W (trùng `mkt-t6-so-chien-dich-theo-so-kenh` gói 4, nên giữ a2 ở Dễ và hạ a6 thay).
