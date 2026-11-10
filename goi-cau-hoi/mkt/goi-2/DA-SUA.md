# Đã sửa · gói 2 · Marketing (`mkt`) · v2

Theo `REVIEW-B.md`, `REVIEW-C.md` và lời nhắn điều phối 10/11/2026. Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại: gói tạm `cong-cu/ket-qua/sua/mkt-goi-2/` (7 câu có sửa SQL hoặc yêu cầu: s6, a2, a6, a7, a8, c3, c4) chạy bộ kiểm thật; cả gói chạy `--chi-phan-tich`; biên dịch lại cả gói ra `cong-cu/ket-qua/bien-dich/mkt-goi-2/`.

| Mã | Đã sửa | Kiểm lại |
|---|---|---|
| `mkt-s1-social-nykaa-theo-thang` | B(1)(2): `\luuy` bỏ vế nói thẳng cận trên và câu lặp "tháng 6/2025 chưa đủ"; gợi ý 2 giữ vai trò đó. | tĩnh |
| `mkt-s2-ket-thuc-ngay-14-2` | C: tiêu đề còn 10 tiếng, bỏ "Influencer" trần; mục yêu cầu mở bằng động từ, bỏ câu về chiến dịch 1 ngày (không có trong dữ liệu); gợi ý 1 bỏ "cộng thẳng"; câu nghiệp vụ không gọi "chiến dịch Valentine". | tĩnh |
| `mkt-s3-bat-dau-cuoi-tuan` | B(1) tiêu đề "Mỗi loại chiến dịch có bao nhiêu phần trăm bắt đầu vào cuối tuần?"; B(2) `\luuy` bỏ "đáng chú ý", dùng mốc hai phần bảy; phá khuôn "Cho từng X". | tĩnh |
| `mkt-s4-ba-kenh-youtube-dau` | C: tiêu đề thành câu hỏi số đếm; bối cảnh tách câu, bỏ "mà… vì…"; yêu cầu bỏ lý do lộ bẫy dòng trùng, phá khuôn "Đếm cho từng"; mẹo đếm dấu phẩy chuyển từ `\luuy` sang gợi ý 1; gợi ý 2 chỉ nêu hàm, không viết sẵn biểu thức. | tĩnh |
| `mkt-s5-ngay-tho-khong-doc-duoc` | B(1) bối cảnh có câu nhờ, bỏ "mà"; B(2)(3) `\luuy` chỉ còn câu chung "ngày đọc được vẫn có thể nằm ngoài kỳ"; giá trị cụ thể và câu về NULL chuyển sang gợi ý 1 (viết lại "luôn ra NULL, không đúng cũng không sai"). | tĩnh |
| `mkt-s6-so-duoi-ma-lon-nhat` | C (gần hằng số): thu phạm vi về chiến dịch bắt đầu ngày 24/6/2025, ngày cuối có dữ liệu; kết quả khác nhau giữa các thương hiệu (public 4/2/10 chiến dịch, dải số khác nhau) và trả lời câu "mã có cấp theo ngày mở không" (không). Wrong `max_theo_chuoi` giờ sai cả giá trị ('5403' lớn hơn '38888' theo chữ). Bối cảnh bỏ "đang chạy", "liền mạch"; `\luuy` bỏ bị động, bỏ "Muốn… thì phải…"; tiêu đề bỏ "số mấy"; phá khuôn "Cho từng". | bộ kiểm (gói tạm) |
| `mkt-s7-dem-loai-ra-20-nhom` | B(1) tiêu đề "Đếm dòng thô theo loại chiến dịch ra 20 nhóm"; B(2) "MySQL so chuỗi có tính cả khoảng trắng". Trùng TRIM với a8: xử lý ở a8. | tĩnh |
| `mkt-s8-thang-sap-sai-thu-tu` | C: bối cảnh tả đúng triệu chứng (7/2024 nằm giữa bảng), có câu nhờ, "báo cáo 12 tháng" thay "báo cáo năm"; `\luuy` bỏ bị động và bỏ câu cho sẵn cách sửa. | tĩnh |
| `mkt-s9-dang-chay-ngay-1-1` | B (không bắt buộc): `\luuy` không còn nói cách sửa, chỉ nêu quy ước lịch chạy; phá khuôn "cho từng thương hiệu" ở yêu cầu. Giữ hai wrong (so ngày cuối với '2024-12-31' bằng `>` cho đúng kết quả nên không dùng làm wrong). | tĩnh |
| `mkt-a1-roi-tong-theo-thuong-hieu` | C: `\luuy` bỏ ẩn dụ "kéo"; yêu cầu mở bằng động từ. | tĩnh |
| `mkt-a2-pheu-theo-loai` | B(1) tiêu đề không còn hỏi loại "tốt nhất"; B(2) bối cảnh; B(3) yêu cầu bớt lặp "tỷ lệ"; cận trên chưa được kiểm → thêm cột `so_chien_dich` và wrong `thieu_can_tren` (rớt ở hidden-1). | bộ kiểm (gói tạm) |
| `mkt-a3-doi-tuong-quy-1` | C: tiêu đề "Nhóm đối tượng nào dẫn đầu doanh thu quý 1/2025?"; `\luuy` viết lại định nghĩa không đọc nhầm; phá khuôn "Cho từng". | tĩnh |
| `mkt-a4-bang-cheo-ngon-ngu` | B(1) hạ `medium` → `easy`, ERD 2 bảng có chữ trên đường nối; B(2) bối cảnh có câu nhờ, "lượt chuyển đổi" thay "đơn". SQL không đổi. | tĩnh |
| `mkt-a5-ngay-tren-500-chien-dich` | C: tiêu đề và bối cảnh sửa trật tự từ ("khởi chạy hơn 350 chiến dịch có lãi"); phá khuôn "Cho từng"; `\luuy` chỉ còn quy tắc nghiệp vụ hoà vốn, phần WHERE/HAVING chuyển sang gợi ý 1. Ngưỡng và mã: Chờ giảng viên (ghi trong `\ghichuthietke`). SQL không đổi. | tĩnh |
| `mkt-a6-doanh-thu-nykaa-theo-thang` | B: wrong mắc hai lỗi một lúc → đề v2 lấy "từ 1/7/2024 tới hết dữ liệu hiện có" (không mốc cuối), wrong `gom_theo_thang_bo_nam` chỉ còn lỗi bỏ năm, trùng lời giải ở public và rớt ở hidden-1; thêm wrong bình quân giản đơn giá trị đơn (rớt ở public). Đổi chủ đề sang giá trị đơn bình quân, bỏ cột số chiến dịch (không trùng s1, c3). Hạ `medium` → `easy`, ERD 2 bảng. `\luuy` bỏ câu khẩu hiệu; bối cảnh "gửi đối tác", có câu nhờ. Thêm khái niệm `gia-tri-don-bq`. | bộ kiểm (gói tạm) |
| `mkt-a7-roi-thuong-hieu-cao-bat-thuong` | C: wrong `avg_roi_tinh_lai` trùng starter → thay bằng `chi_phi_quen_nhan_chuyen_doi`; kỳ đổi sang nửa cuối 2024 để đáp số không trùng a1; `\luuy` bỏ ẩn dụ "một phiếu", "phải để". | bộ kiểm (gói tạm) |
| `mkt-a8-so-chien-dich-tho-thua` | B(1) hạ `medium` → `easy`; B(2) bỏ phần gom `TRIM(campaign_type)` (không trùng s7), trả một dòng `so_dong`, `so_chien_dich`; starter `COUNT(campaign_id)`; B(3) thay `bo_trim` bằng `COUNT(DISTINCT campaign_type)`. ERD 2 bảng. | bộ kiểm (gói tạm) |
| `mkt-a9-doanh-thu-theo-quy-gop-sai` | C: tiêu đề "Doanh thu theo quý không ghi năm" (thấy được trên public); bối cảnh 2 câu; `\luuy` bỏ "cận dưới, cận trên", "phải có", bỏ câu khẩu hiệu. SQL không đổi. | tĩnh |
| `mkt-c3-thang-nykaa-mo-nhieu-nhat` | B: K32 → ba phương án dài gần bằng nhau, từ rào "có thể" có ở cả phương án đúng và một phương án sai; số trong phương án đúng chính xác (chênh bình quân mỗi ngày chưa tới 10\%). Trùng s1/a6 → đổi thương hiệu sang Purplle (mã giữ nguyên, tiêu đề đổi); `\luuy` không lặp "tháng 6/2025 chưa đủ"; phá khuôn "Cho từng". | bộ kiểm (gói tạm) |
| `mkt-c4-loai-roi-duoi-muc-chung` | C: K32 → phương án theo đề xuất của C (dài gần bằng nhau, phương án sai thứ ba có từ rào, bỏ "kéo"); "chưa tới 0,03" thay "hai phần trăm"; `\luuy` bỏ câu nói trước kết luận; b2 wrong `AVG(roi)` không bắt được lỗi bình quân năm loại → thay bằng `doanh_thu_chia_chi_phi` (ROAS) và `thieu_can_tren`; ghi chú thiết kế ghi rõ vì sao không dùng bình quân năm ROI loại; phá khuôn "Cho từng". | bộ kiểm (gói tạm) |

## Chờ giảng viên

1. `mkt-a5-ngay-tren-500-chien-dich`: mã nói 500 chiến dịch, đề nói 350 chiến dịch có lãi (tháng 3/2025 chỉ 2 ngày trên 500). Ngưỡng đặt trên số đếm gần như chỉ phản ánh số chiến dịch mở trong ngày (tỷ lệ có lãi mỗi ngày 75–80\%). Cần chốt: giữ số đếm để dạy HAVING, thêm cột tỷ lệ, hay đổi mã (nếu mã chưa công bố). Cấp Trung bình cũng sát Dễ (review C).
2. `mkt-s4-ba-kenh-youtube-dau`: lý do "đại lý YouTube đối soát theo kênh ghi đầu" hơi gượng (review C); chưa có tình huống thật hơn.
3. `mkt-c3-thang-nykaa-mo-nhieu-nhat`: mã còn chữ "nykaa" nhưng v2 hỏi Purplle (không đổi mã theo BRIEF-SUA-GOI mục 3).
