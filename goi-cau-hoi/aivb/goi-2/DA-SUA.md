# Đã sửa · gói 2 · AIV Bank (`aivb`) · v2 (10/11/2026)

Kiểm lại:
- Gói tạm `cong-cu/ket-qua/sua/aivb-goi-2/` (s6, a2, c3, c4, tức các câu đã sửa SQL hoặc yêu cầu ảnh hưởng tới kết quả) chạy thật trên MySQL: **KIEM TRA: 0 loi**.
- Cả gói phân tích tĩnh (`--chi-phan-tich`): **0 loi**.
- Biên dịch XeLaTeX: 44 trang, 0 lỗi, 0 ký tự thiếu.

| Mã | Đã sửa gì (theo B/C) | Kiểm lại |
|---|---|---|
| `aivb-s1-chi-nhanh-quan` | B: tiêu đề "Chi nhánh nào còn chữ ``Quận'' trong tên?"; bối cảnh đổi sang việc đổi tên chi nhánh sau khi bỏ cấp quận, để không còn bỏ sót chi nhánh nội thành; câu "giúp quyết định gì" mới; `\luuy` bỏ khuôn "…, nên …" và cụm "tên trụ sở". SQL giữ nguyên. | tĩnh |
| `aivb-s2-ho-kinh-doanh-fnb` | C: "gói thanh toán QR" → "dịch vụ thanh toán QR". | tĩnh |
| `aivb-s3-lenh-mobile-theo-thang` | B: tiêu đề "Số lệnh qua ứng dụng di động từng tháng năm 2026"; bỏ "mức dùng"; `\luuy` và gợi ý 1 viết lại (bỏ câu dịch máy "Năm 2026 kết thúc ở đâu?"). | tĩnh |
| `aivb-s4-tai-khoan-mo-giua-nam` | C: tiêu đề còn 10 tiếng; item định nghĩa tài khoản đang mở viết lại, mở bằng động từ; bối cảnh bỏ "từ dữ liệu hiện có"; `\ghichuthietke` ghi rõ câu chỉ sát Module 3 ở phần so sánh ngày. | tĩnh |
| `aivb-s5-giai-ngan-ngay-cuoi-thang` | B: hết mơ hồ, yêu cầu ghi rõ chỉ lấy ngày giải ngân đầu trên hợp đồng vay (`core_loan_contract.disbursement_date`), không xét các lần giải ngân sau (29 khoản, so với 47 nếu xét từng lần); bỏ ngoặc chỉ cách tránh bẫy trong yêu cầu; `domain=finance` → `sales` (STYLE G); "chạy chỉ tiêu" → "đạt chỉ tiêu". SQL giữ nguyên. | tĩnh |
| `aivb-s6-ngay-gia-tri-lech` | C: ngưỡng 50.000.000 → **30.000.000 đồng** (public 40 dòng, hidden-1 38 dòng, nên hai biến thể khác nhau); bối cảnh bỏ "cuối tuần làm việc" (lộ đáp án); `\luuy` "số ngày lệch không âm"; "ghi bằng số"; tiêu đề 9 tiếng; `\ghichuthietke` sửa thông tin sai về H(a). | **gói tạm 0 lỗi** |
| `aivb-s7-ma-dang-ky-kinh-doanh` | B: bối cảnh bỏ "ra 0 dòng" và câu lặp "Anh chị xem giúp em sai ở đâu."; tiêu đề "Tra đầu mã số đăng ký không ra tổ chức nào"; `\luuy` bỏ khuôn "…, nên …". | tĩnh |
| `aivb-s8-lenh-hoan-theo-thang` | Phá khuôn lặp: đổi người hỏi (Bạn Khoa), lời nhắn không nhắc "dòng", bỏ "Anh chị xem giúp em sai ở đâu.". Mã giữ nguyên theo BRIEF-SUA mục 3. | tĩnh |
| `aivb-s9-quyet-dinh-kyc-thang-12-2025` | B: `domain=after_sales` → `customer` (STYLE G: KYC theo vòng là `customer`); lời nhắn "Em sửa giúp chị truy vấn" → "Em xem lại giúp chị cách lấy danh sách."; giải nghĩa "nhận biết khách hàng (KYC)" ở lần đầu; giá trị mẫu ERD `'2025-12-31 10:00:02'` (có thật). | tĩnh |
| `aivb-a1-du-no-binh-quan` | C: yêu cầu bỏ định nghĩa vòng ("còn dư nợ: đang còn dư nợ"); đổi vai thành Trưởng phòng quản lý rủi ro tín dụng, "toàn bộ khoản vay của ngân hàng"; `\ghichuthietke` bỏ ẩn dụ "kéo". | tĩnh |
| `aivb-a2-khach-hang-theo-phan-khuc` | B: thêm item chỉ xét phân khúc cá nhân (`ref_segment.party_type = 'PERSON'`), cho khớp vai Trưởng phòng khách hàng cá nhân; câu dùng thật bảng thứ 2, đúng cấp Dễ; thêm wrong `quen_loc_ca_nhan`; tiêu đề "Mỗi phân khúc có bao nhiêu khách hàng theo từng trạng thái?"; KYC giải nghĩa, thống nhất "KYC không đạt". | **gói tạm 0 lỗi** |
| `aivb-a3-ho-so-vay-san-pham-hang-diem` | C: `cap=medium` → **easy** (1 bảng, 1 phép đếm có điều kiện); ERD 2 bảng có chữ trên đường nối; tiêu đề "Mỗi sản phẩm vay có bao nhiêu hồ sơ từng hạng?"; `\luuy` bỏ câu "không so hạng nào tốt hơn". SQL giữ nguyên. | tĩnh |
| `aivb-a4-ty-trong-kenh` | B: "truy vấn con vô hướng" → "truy vấn con trả về đúng một giá trị" (gợi ý và `kynang`). | tĩnh |
| `aivb-a5-nhom-dti-ty-le-duyet` | C: tiêu đề "Tỷ lệ duyệt thay đổi thế nào theo nhóm DTI?"; bối cảnh viết lại; ngưỡng ghi dạng 30\% / 50\% để giữ bẫy thang `dti`; gợi ý "dạng tỷ lệ từ 0 tới 1"; công thức khái niệm `ho-so-vay-va-ty-le-duyet` thống nhất "đã có quyết định". SQL giữ nguyên (ngưỡng 0,3 và 0,5 tương đương). | tĩnh |
| `aivb-a6-ty-le-khoan-vay-co-van-de` | B: tiêu đề "…đang có vấn đề hoặc đã xử lý rủi ro?"; yêu cầu ghi rõ trạng thái tại ngày chốt dữ liệu, khoản từng quá hạn rồi tất toán không tính; `\luuy` bỏ khuôn "…, nên … mới phản ánh…". | tĩnh |
| `aivb-a7-lenh-thanh-cong-2026` | C: tiêu đề "…cao hơn thực tế" (bỏ "thổi phồng"); yêu cầu bỏ "của chúng" và mệnh đề treo; phá khuôn lặp: người hỏi là Kế toán giao dịch, bỏ "Anh chị xem giúp em sai ở đâu.". | tĩnh |
| `aivb-a8-khach-nop-ho-so-theo-nam` | B: `cap=medium` → **easy** (mẫu debug COUNT(*)/COUNT(DISTINCT)); ERD 2 bảng, đường nối cảnh báo có chữ; "khách" → "người"; `\luuy` bỏ câu chỉ cách tránh bẫy. | tĩnh |
| `aivb-a9-thieu-nghe-nghiep-theo-thu-nhap` | C: tiêu đề "…cao bất thường" (bỏ "đếm ngược"); "nhóm thu nhập" → "khoảng thu nhập"; "gần như ai cũng thiếu" → "phần lớn cá nhân đều thiếu"; `cap=medium` → **easy**, ERD 2 bảng có chữ. | tĩnh |
| `aivb-c3-kenh-hoan-lenh-quy-4` | B: chấm oan (API 0,4258\% và ATM 0,4308\% cùng làm tròn 0,43) xử lý bằng **`thutu=khong`**, yêu cầu ghi bước này không xét thứ tự; bài sai `sap_theo_so_lenh` (không còn rớt) thay bằng `quen_can_tren` (rớt ở hidden-1); tiêu đề "Quý 4/2026 nên rà soát kênh giao dịch nào trước?"; `\luuy` bỏ câu cho sẵn đáp án; phương án ghi "ứng dụng di động (MOBILE)", "giao dịch tại quầy (BRANCH)"; "phòng chị". | **gói tạm 0 lỗi** |
| `aivb-c4-ho-so-vay-2025` | C: `\luuy` bỏ câu lộ kết luận; bước 1 đổi thành quy mô cả năm (số hồ sơ, tổng số tiền đề nghị, tỷ lệ duyệt), làm mẫu số cho bước 2; phương án đúng dựa vào bước 1 và bước 2; thêm phương án sai dùng tỷ lệ duyệt bước 1; tiêu đề "Năm 2025 nhu cầu vay tập trung ở sản phẩm nào?". | **gói tạm 0 lỗi** |

Đổi cấp làm phân bổ cấp của gói khác bản đồ: basic 4, easy 13, medium 3 (bản đồ: 4/10/6). M4 vẫn có ≥ 1 câu Dễ. Không ô dạng × mảng × cấp × hình thức nào trùng.

## Đã xử lý (bổ sung biến thể ẩn 10/11)

- **Hai biến thể cho cùng kết quả** ở s1, s2, s4, s5, s7, s9, a2, a3, a5, a6, a8, a9, c4 (trước ở mục Chờ giảng viên): `mysql/aivb/04_bo_sung_bien_the_aivb.sql` thêm cụm khách hàng giả (d)–(k): chi nhánh "Quận 3" (CN13), hộ kinh doanh "…F\&B" mã `0100000125-001`, tài khoản đóng 15/9/2026, khách thiếu nghề nghiệp, KYC tháng 12/2025, hồ sơ, quyết định, khoản vay giải ngân ngày cuối tháng. Chạy solution trên `aivb` và `aivb_hidden_1` (user `sql_runner`): cả 13 câu nay khác public (s1 3/2 dòng, s2 19/18, s5 31/29, s7 11/10, s9 62/61; s4, a2, a3, a5, a6, a8, a9, c4.b1, c4.b2 khác giá trị), chép kết quả Chạy thử rớt ở hidden-1.

## Chờ giảng viên

1. **a1:** tên "dư nợ bình quân" (`du_no_bq`) ở ngân hàng thường hiểu là bình quân theo thời gian; câu dùng "bình quân một khoản vay". Cần xác nhận cách gọi.
2. **a3:** chiều tốt – xấu của hạng điểm A–D chưa chốt. Tỷ lệ duyệt theo hạng không đơn điệu (A 70,9\%, B 65,8\%, C 68,0\%, D 66,7\%), nên chưa ghi "A là rủi ro thấp nhất" vào đề.
3. **a6:** gộp đang quá hạn, đã cơ cấu lại và đã xử lý rủi ro thành "khoản vay có vấn đề" có phải cách báo cáo quen dùng không.
4. **Khái niệm `chi-nhanh`:** định nghĩa do người soạn viết, chưa đối chiếu Luật Các tổ chức tín dụng.
5. **s8:** mã chứa "hoan" (`aivb-s8-lenh-hoan-theo-thang`) lệch STYLE A.5; không đổi mã theo BRIEF-SUA mục 3. Có đổi thành `…-lenh-bi-dao-theo-thang` không.
