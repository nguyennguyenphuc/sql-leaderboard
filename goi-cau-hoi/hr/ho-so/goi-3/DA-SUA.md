# Đã sửa · gói 3 HR Analytics (hr) · v2

Sửa theo REVIEW-B.md và REVIEW-C.md (10/11/2026). Không đổi `ma`, không sửa database hay biến thể ẩn.
Kiểm lại:
- **Gói tạm** `cong-cu/ket-qua/sua/hr-goi-3/`: 6 câu có sửa SQL hoặc yêu cầu (j2, j5, q3, q6, c5, c6). Kết quả `KIEM TRA: 0 loi`; báo cáo ở `hr-goi-3-ket-qua/`.
- **Cả gói** chạy `--chi-phan-tich`: `KIEM TRA: 0 loi`.
- **Biên dịch** `bien_dich.sh`: PDF 45 trang, 0 lỗi LaTeX, 0 ký tự thiếu. Bản PDF chép vào `cong-cu/ket-qua/bien-dich/hr-goi-3/`.

| Mã | Đã sửa gì | Kiểm lại |
|---|---|---|
| hr-j1-yeu-cau-theo-bac | B: bối cảnh hỏi "chi phí bình quân mỗi yêu cầu" thay cho "tốn bao nhiêu"; yêu cầu đổi thành "Đếm số yêu cầu và tính chi phí … theo bậc" (phá khuôn "Tính cho từng"). | phân tích tĩnh |
| hr-j2-vi-tri-ngoai-ke-hoach | C: thêm cột `so_dong_ca_nam` (bảng dẫn xuất đếm dòng theo năm, nối theo năm) để kết quả hidden-1 khác public. Thêm wrong `thieu_can_tren`: dòng năm 2026 của E00002 lọt vào, nên rớt ở hidden-1. Tiêu đề đổi thành "Vị trí nào có người làm nhưng chưa có định biên?". Sửa câu bối cảnh và gợi ý 1 theo đề xuất. | gói tạm: 0 lỗi; 3 wrong cũ rớt cả hai biến thể, `thieu_can_tren` rớt hidden-1 |
| hr-j3-tuyen-thay-nguoi-nghi-vi-luong | B: sửa "tuyển thay vì" thành "tuyển người thay thế vì"; sửa "với lý do lương" thành "vì lý do lương"; giải nghĩa compa-ratio ở lần đầu. | phân tích tĩnh |
| hr-j4-tin-tuong-quan-ly-theo-phong | C (tuỳ chọn): bối cảnh chuyển sang câu hỏi; yêu cầu bỏ khuôn "tính cho từng". | phân tích tĩnh |
| hr-j5-luong-duoi-thi-truong | B (chấm oan): bỏ `\khainiem{compa-ratio}` khỏi câu. Lưu ý viết lại: so trực tiếp với 0,8 × P50, không dùng `compa_ratio` vì tiền lương được làm tròn **sau** khi tính cột này. Thẻ compa-ratio dùng chung thêm "trừ khi yêu cầu ghi rõ so trực tiếp với P50" và sửa lý do lệch. Yêu cầu, thẻ và wrong `dung_compa_ratio` nay khớp nhau. Tiêu đề đổi thành "Nước nào có nhiều người nhận lương dưới 80\% thị trường?". Sửa câu bối cảnh, "Theo từng nước, đếm…", "thang lương" thành "mức lương thị trường". ERD nối nhiễu theo `position_id` thay cho `country`. | gói tạm: 0 lỗi |
| hr-j6-quan-ly-khong-cao-hon | C: tiêu đề đổi thành "Bao nhiêu quản lý không cao bậc hơn cấp dưới?"; bối cảnh chuyển sang câu hỏi; yêu cầu "Đếm theo nước của nhân viên…". | phân tích tĩnh |
| hr-j7-phieu-khao-sat-gap-ba | Không sửa (B: Đạt). | – |
| hr-j8-nghi-co-tuyen-thay-the | Không sửa (C: Đạt). | – |
| hr-j9-trang-thai-quan-ly | B: tiêu đề đổi thành "Phân loại nhân viên theo quản lý trực tiếp ra thiếu người"; bối cảnh đổi "Em sửa giúp anh" thành "Em xem lỗi ở đâu". | phân tích tĩnh |
| hr-q1-luong-tren-bq-bac | C (tuỳ chọn): bối cảnh bỏ lặp "ở Việt Nam", chuyển sang câu hỏi. | phân tích tĩnh |
| hr-q2-tuyen-khi-het-cho-trong | B: tiêu đề đổi thành "Mỗi nước duyệt bao nhiêu yêu cầu tuyển cho vị trí đã đủ người?". Bối cảnh bỏ khẳng định sai "các vị trí đều đủ người", thay bằng "Nhiều vị trí cuối năm đã đủ người…". `dang` A1 đổi thành A3 (không trùng ô trong gói). Yêu cầu đổi thành "Theo từng nước, đếm…". Ghi chú thiết kế bỏ chữ "nếu". | phân tích tĩnh (SQL không đổi) |
| hr-q3-gan-ket-cao-nhat-moi-phong | C (chấm oan): phạm vi đổi sang nước × phòng ban. Bản truy vấn con tương quan nay dùng chỉ mục `idx_snap_country_dept`, chạy khoảng 20 giây khi máy chấm tải nặng (trước là 1 phút 42 giây). Có hoà điểm cao nhất: public 1 nhóm, hidden-1 2 nhóm. Thêm wrong `moi_nhom_mot_nguoi` (lấy MIN, mất người hoà), rớt cả hai biến thể. Wrong `max_toan_cong_ty` đổi thành `max_ca_nuoc`. Gợi ý 2 bỏ câu "truy vấn con tương quan … cho cùng kết quả". Tiêu đề, bối cảnh, yêu cầu, ERD, lưu ý cập nhật theo phạm vi mới. | gói tạm: 0 lỗi; 3 wrong rớt cả hai biến thể |
| hr-q4-nghi-du-dinh-o-lai-cao | B: yêu cầu "phiếu khảo sát gần nhất … tính tới hết quý có tháng nghỉ"; giải nghĩa `intent_to_stay` (thang 1 tới 5); bối cảnh ngắn lại, bỏ "trước đó". | phân tích tĩnh |
| hr-q5-sales-lam-them-tren-bq | C: tiêu đề đổi thành "Bao nhiêu nhân viên kinh doanh làm thêm trên mức bình quân?"; bối cảnh bỏ chữ "đội"; yêu cầu bỏ khuôn "Tính cho từng"; lưu ý "tổng giờ làm thêm cả năm bình quân trên một người". | phân tích tĩnh |
| hr-q6-yeu-cau-tuyen-lau | B: cột `tg_bq` đổi tên thành `so_ngay_tuyen_bq` (SQL và yêu cầu); gợi ý đổi "đặt nó" thành "đặt con số này". | gói tạm: 0 lỗi |
| hr-q7-chua-quan-ly-ai-ra-rong | C: tiêu đề đổi thành "Danh sách người bậc cao không quản lý ai ra rỗng". Lưu ý viết lại theo ý nghiệp vụ (người đứng đầu nhánh không có quản lý); phần kỹ thuật NOT IN gặp NULL chuyển sang gợi ý 1. | phân tích tĩnh |
| hr-q8-tren-bq-bac-sai-thang | B: bối cảnh tả đúng triệu chứng ("có cả người đang nhận thấp hơn mức bình quân của nhóm trong tháng 12"). Tiêu đề đổi thành "Danh sách lương trên bình quân phòng ban, bậc bị thừa người". Lưu ý "24 dòng tháng, mỗi dòng một mức lương". ERD bỏ nét nối n-1 sai (`country`). | phân tích tĩnh |
| hr-q9-ly-do-pho-bien-moi-nuoc | C: tiêu đề đổi thành "Bảng lý do nghỉ việc phổ biến nhất chỉ có một nước". Yêu cầu "mỗi nước hiện lý do có nhiều người nghỉ nhất". Lưu ý thay bằng ý nghiệp vụ, không nói chỗ sửa. Ghi chú thiết kế và chú thích SQL bỏ chữ "chen vào". | phân tích tĩnh |
| hr-c5-tuyen-thay-the-kip-khong | B (chấm oan): b2 ghi rõ nhóm không có yêu cầu thì `so_ngay_bq` là NULL, `so_di_lam_sau_2025` bằng 0. Phương án đúng viết "phần lớn" để đúng cả ở hidden-1 (nghỉ tự nguyện khoảng 90\%). Phương án 3 cũ đúng ở hidden-1 nên thay bằng lỗi đọc NULL thành 0 ngày; phương án này sai ở cả hai biến thể. Sửa tiêu đề và bối cảnh ("chỗ của người nghỉ có được tuyển người thay"). | gói tạm: 0 lỗi |
| hr-c6-luong-thap-va-nghi-viec | C: b2 và b3 ghi "không làm tròn quân số bình quân trước khi chia". Sửa tiêu đề, bối cảnh, lưu ý theo đề xuất. Giải thích phương án đúng đổi thành "hai lần rưỡi". ERD bỏ nét nối n-1 sai (`country`). | gói tạm: 0 lỗi |

## Chờ giảng viên

- **q2:** 260/317 yêu cầu trong kết quả là tuyển thay thế (`'Backfill'`). Chỗ trống bằng 0 ở tháng 12 có thể chính là kết quả của các yêu cầu này. Cần quyết định có tách hay loại yêu cầu `'Backfill'` không. Hiện giữ nguyên SQL, chỉ sửa bối cảnh cho đúng số liệu.
- **q4:** phiếu khảo sát cùng quý với tháng nghỉ có thể được làm sau ngày nghỉ. Cần xác nhận phiếu cùng quý có được coi là "phiếu gần nhất" trước khi nghỉ không. Hiện giữ cách tính tới hết quý có tháng nghỉ và đã bỏ chữ "trước đó" trong bối cảnh.
- **q3:** câu nêu `employee_id` của người có điểm gắn kết hằng tháng cao nhất (điểm ước lượng, có sai số đo) để mời chia sẻ. Cần xác nhận điều này có trái nguyên tắc bảo mật khảo sát không. Nếu trái, đổi mục đích thành "mức gắn kết cao nhất mỗi nhóm" và bỏ `employee_id`.
- Khuôn "Em … giúp anh/chị" và yêu cầu mở bằng "Xét …" đã giảm ở 9 câu (j1, j4, j6, j9, q1, q2, q4, c5, j2) nhưng chưa thay hết; nếu muốn giảm thêm, chờ giảng viên chốt.

## Quyết định v3 (10/11)

Nguồn domain: DD = `Project 02 HR Analytics\data\data_dictionary.md`; GEN = `scripts\augment_datasets.py` (chỉ đọc); QDC = `QUYET-DINH-CHUNG.md`.

| Mã | Điểm | Quyết định | Căn cứ | Đã sửa gì |
|---|---|---|---|---|
| `hr-q3-gan-ket-cao-nhat-moi-phong` | Nêu `employee_id` người có điểm gắn kết cao nhất để mời chia sẻ (bảo mật khảo sát) | Đổi mục đích sang đặt mục tiêu gắn kết theo nhóm; bỏ `employee_id`, trả mức cao nhất và số người đạt (đổi SQL) | DD mục 1 (`engagement_score` hằng tháng là ước lượng có sai số đo), mục 4 (khảo sát quý); thông lệ chỉ báo cáo kết quả gắn kết theo nhóm, không nhận diện cá nhân (ví dụ ngưỡng nhóm báo cáo tối thiểu: https://support.cultureamp.com/en/articles/7048607-report-filters) | Tiêu đề "Điểm gắn kết cao nhất từng phòng ban mỗi nước", lời nhắn, yêu cầu (cột `diem_cao_nhat`, `so_nguoi_dat`), mục đích, lưu ý (thông tin nhạy cảm, báo cáo theo nhóm), gợi ý 2, ghi chú thiết kế; solution mới; wrong `max_ca_nuoc`, `max_ca_24_thang` viết lại theo cột mới; thay `moi_nhom_mot_nguoi` bằng `quen_thang_truy_van_ngoai`. Hoà điểm cao nhất vẫn được chấm qua `so_nguoi_dat` (public 1 nhóm, hidden-1 2 nhóm có 2 người) |
| `hr-q2-tuyen-khi-het-cho-trong` | 260/317 yêu cầu là `'Backfill'` | Giữ SQL (đếm mọi loại); thêm lưu ý | DD mục 2 (`vacancy_count` chốt tháng 12), mục 3 (`'Backfill'` sinh từ người nghỉ); GEN dòng 600–609 | Lưu ý: yêu cầu thay thế mở khi có người nghỉ, chỗ trống 0 ở tháng 12 có thể chính là kết quả của chúng; ghi chú thiết kế |
| `hr-q4-nghi-du-dinh-o-lai-cao` | Phiếu cùng quý với tháng nghỉ có thể làm sau ngày nghỉ | Giữ cách tính tới hết quý có tháng nghỉ | DD mục 4 ("rows stop once an employee leaves"); GEN dòng 415–426 (phiếu của một quý ghi ở tháng đầu tiên người đó còn làm trong quý) và 648–660 (phiếu chạy tới hết quý nghỉ): phiếu quý nghỉ luôn có trước hoặc cùng tháng nghỉ | Lưu ý thêm câu khảo sát làm khi nhân viên còn làm việc; ghi chú thiết kế ghi căn cứ |
| `hr-c6-luong-thap-va-nghi-viec` · RS | K32: chỉ phương án đúng có câu rào "theo dõi thêm" | Bỏ rào ở phương án đúng | BAO-CAO 3.1, K32 | Phương án đúng viết lại, không còn dài nhất; ý tương quan chuyển vào lời giải thích; ghi chú thiết kế |
| `hr-c5`, `hr-c6` | Tiền tố lời giải thích bước kết luận | Theo gói mẫu quy chuẩn: phương án đúng mở bằng "Đúng: ", phương án sai không có tiền tố | QDC 1.1 (sửa theo quy_chuan 23:05; `quy_chuan/goi-cau-hoi-mau/cau-hoi.tex` c1–c4) | "Đúng. " → "Đúng: " ở 2 phương án đúng; phương án sai không tiền tố (lượt trước đã thêm "Chưa đúng. ", nay gỡ lại theo quy chuẩn) |

## v4 – đủ 4 cấp mỗi module (11/11/2026)

Theo `BRIEF-CAP-DO-MODULE.md`: mỗi module 2 Cơ bản · 3 Dễ · 2 Trung bình · 2 Khó (không tính case), theo lộ trình `quy_chuan/lo-trinh-sql/assets/js/data.js` (Joins: `j1-don-kem-vung` basic, `j6-mua-cung-don` hard; Subqueries: `q1-tren-gia-trung-binh` basic, `q6-don-dau-tien` hard). Case c5, c6 giữ nguyên cấp.

| Module | Trước (Cơ bản/Dễ/TB/Khó) | Sau | Hình thức sau (write/debug) |
|---|---|---|---|
| M5 Joins | 0 / 3 / 6 / 0 | 2 / 3 / 2 / 2 | 6 / 3 (debug: j8 Cơ bản, j7 Dễ, j9 Khó) |
| M6 Subqueries | 0 / 4 / 5 / 0 | 2 / 3 / 2 / 2 | 6 / 3 (debug: q8 Cơ bản, q7 Dễ, q9 Khó) |

Số câu viết lại tối thiểu: M5 thừa 4 câu Trung bình (2 → Cơ bản, 2 → Khó); M6 thừa 1 Dễ và 3 Trung bình (1 Dễ + 1 TB → Cơ bản, 2 TB → Khó). Tổng 8 câu. Giữ j1, j3, j7 (Dễ), j5, j6 (TB), q1, q2, q7 (Dễ), q3, q5 (TB).

| Mã cũ → mã mới | Cấp cũ → mới | Đổi gì | 5 trục (bảng lời giải · bước · mơ hồ · bẫy · nghiệp vụ) |
|---|---|---|---|
| `hr-j2-vi-tri-ngoai-ke-hoach` → `hr-j2-ngoai-dinh-bien-van-tuyen` | Trung bình → Khó | Thêm nguồn thứ ba: số yêu cầu tuyển được duyệt cho vị trí ngoài định biên trong cùng năm (bảng dẫn xuất, `LEFT JOIN`, 0 khi không có); thêm `department`, `job_level`; bỏ cột `so_dong_ca_nam`. Đề nói bằng ngôn ngữ kiểm toán; ERD 5 bảng chỉ khoá, 2 bảng nhiễu, cách nối ở `\erdkhoa`. 5 wrong. | 3 bảng · 4 tầng · ngôn ngữ kinh doanh, nối ở `\erdkhoa` · 5 bẫy (thiếu năm, nhân dòng khi nối thẳng bảng tuyển dụng, phòng ban từ kế hoạch ra NULL, `INNER JOIN` mất P0239, thiếu cận trên chỉ lộ ở hidden-1) · đối chiếu định biên theo năm với tuyển dụng. Đạt Khó 5/5 (số bảng không bắt buộc) |
| `hr-j4-tin-tuong-quan-ly-theo-phong` → `hr-j4-tin-tuong-quan-ly-cskh-philippines` | Trung bình → Cơ bản | Bỏ gom theo phòng ban; một dòng `so_phieu`, `tin_tuong_bq` cho phòng Customer Support ở Philippines. Yêu cầu ghi rõ điều kiện nối (`employee_id`, `snapshot_month = '2025-12'`). ERD 2 bảng có giá trị mẫu và chữ trên đường nối, bỏ bảng nhiễu `positions`. | 2 bảng (Cơ bản của Joins trên lộ trình là nối 2 bảng) · 1 tầng · ghi rõ cột, giá trị lọc, điều kiện nối · 0 bẫy · 1 khái niệm. Đạt Cơ bản 4/5 (số bảng theo lộ trình) |
| `hr-j8-nghi-co-tuyen-thay-the` → `hr-j8-nghi-thang-11-ra-rong` | Trung bình → Cơ bản | Đổi bài: danh sách người phòng Kỹ thuật nghỉ tháng 11/2025 kèm yêu cầu tuyển thay thế; starter nối nhầm `requisition_id = employee_id` nên ra 0 dòng (lỗi dễ thấy, giá trị mẫu R… và E… là manh mối). ERD 2 bảng có giá trị mẫu, bỏ bảng nhiễu. | 2 bảng · 1 tầng · ghi rõ cột, giá trị lọc · sửa lỗi một chỗ dễ thấy · 1 khái niệm. Đạt Cơ bản 4/5 |
| `hr-j9-trang-thai-quan-ly` → `hr-j9-trang-thai-quan-ly-vuot-100` | Trung bình → Khó | Starter thêm lỗi thứ hai (thiếu điều kiện cùng tháng chồng lên `INNER JOIN`) và cột `ty_le_pct`; triệu chứng: một nhóm, tỷ lệ quá 2.000%. Sửa một lỗi vẫn sai. ERD 5 bảng chỉ khoá (lời giải 1 bảng nên thêm nhiễu cho đủ 5, như mẫu d4, o4). 3 wrong. | 1 bảng tự nối · 3 tầng · yêu cầu không chỉ chỗ sai, ERD trung tính · 3 bẫy (ô quản lý trống, quản lý đã nghỉ, nhân dòng theo tháng) · sửa lỗi: 2 lỗi chồng nhau. Đạt Khó 3/5 + trục sửa lỗi |
| `hr-q4-nghi-du-dinh-o-lai-cao` → `hr-q4-khao-sat-khong-bao-truoc` | Trung bình → Khó | Từ danh sách cá nhân sang chỉ số theo nước: số người nghỉ tự nguyện, số người khảo sát không báo trước (phiếu gần nhất tới hết quý nghỉ có `intent_to_stay` ≥ 3), tỷ lệ. Định nghĩa ở tab Nghiệp vụ; ERD 5 bảng chỉ khoá, cách dựng quý ở `\erdkhoa`. Bỏ `employee_id` theo tinh thần quyết định v3 của q3 (kết quả khảo sát báo cáo theo nhóm). 4 wrong. | 2 bảng · 4 tầng · chỉ số định nghĩa ở tab Nghiệp vụ · 4 bẫy (quý lớn nhất cả bảng, so chuỗi quý với tháng, lọc trước khi đếm, tính mọi loại nghỉ; hoà tỷ lệ 0 ở hidden-1) · chỉ số nhiều điều kiện. Đạt Khó 4/5 |
| `hr-q6-yeu-cau-tuyen-lau` → `hr-q6-yeu-cau-thang-12-tuyen-lau` | Dễ → Cơ bản | Liệt kê yêu cầu duyệt tháng 12/2025 có thời gian tuyển lớn hơn bình quân của mọi yêu cầu trong bảng (truy vấn con không lọc, phạm vi nêu rõ). Bỏ phép đếm; ERD 1 bảng có giá trị mẫu (lấy từ tháng 3/2025, không thuộc kết quả), bỏ bảng nhiễu; 1 gợi ý. | 1 bảng · 1 tầng · ghi rõ cột, giá trị lọc, phạm vi bình quân · 0 bẫy (bẫy phạm vi bình quân của bản Dễ đã gỡ) · 1 khái niệm. Đúng mẫu `q1-tren-gia-trung-binh`. Đạt Cơ bản 5/5 |
| `hr-q8-tren-bq-bac-sai-thang` → `hr-q8-tren-bq-phong-sai-nam` | Trung bình → Cơ bản | Đổi sang truy vấn con một giá trị (không tương quan): phòng Finance ở Singapore, tháng 12/2025; starter lọc tháng `'2024-12'` trong truy vấn con (sai giá trị lọc). ERD 1 bảng có giá trị mẫu, bỏ 2 bảng nhiễu. | 1 bảng · 1 tầng · ghi rõ cột, giá trị lọc · sửa lỗi một chỗ dễ thấy · 1 khái niệm. Đạt Cơ bản 5/5 |
| `hr-q9-ly-do-pho-bien-moi-nuoc` → `hr-q9-ly-do-pho-bien-hai-loi` | Trung bình → Khó | Starter thêm lỗi thứ hai (đếm mọi lượt nghỉ, sai định nghĩa người nghỉ tự nguyện) chồng lên `MAX` không tương quan; sửa một lỗi vẫn sai (Thái Lan thêm dòng `'Retirement'` trong nhóm hoà). Yêu cầu không nói chỗ sai; ERD 5 bảng chỉ khoá. 2 wrong. | 1 bảng · 3–4 tầng · không nêu chỗ sai, triệu chứng chỉ lộ lỗi thứ nhất · 3 bẫy (thiếu tương quan, nghỉ hưu, hoà lý do) · sửa lỗi: 2 lỗi chồng nhau, có sai định nghĩa chỉ số. Đạt Khó 3/5 + trục sửa lỗi |

Kết quả public khác hidden-1 ở cả 8 câu (bộ kiểm, `dong_dau`). Solution chạy dưới 0,3 giây mỗi biến thể.

Ô dạng × mảng × cấp × hình thức: không trùng trong gói. Trùng ô giữa các gói: `hr-j8-nghi-thang-11-ra-rong` (A1 · after_sales · basic · debug) cùng ô với `hr-r7-danh-sach-nghi-huu-rong` (gói 1) – được phép, ghi để tham khảo. Nội dung gần: j8 và j3 cùng cặp bảng, cùng khoá nối (khác hình thức, cấp); q8 và q1 cùng chủ đề lương trên bình quân (khác nước, phòng, cấp, hình thức).

Kiểm:
- Bộ kiểm đầy đủ (`cong-cu/kiem_tra_goi.py --goi goi-cau-hoi/hr/goi-3 --ra cong-cu/ket-qua/cap-do/hr-goi-3`): 20 câu, `KIEM TRA: 0 loi`, 0 cảnh báo. Mọi wrong mới rớt ≥ 1 biến thể; `hr-j2…thieu_can_tren`, `hr-j8…left_join_giu_nguoi_chua_co_yeu_cau` chỉ rớt ở hidden-1 như thiết kế.
- Biên dịch `bash cong-cu/bien_dich.sh goi-cau-hoi/hr/goi-3 <ra>`: 0 lỗi LaTeX, 0 ký tự thiếu (PDF ở `cong-cu/ket-qua/cap-do/hr-goi-3/bien-dich/`).
- Thư mục gói vẫn đúng 4 file.

Cập nhật kèm: `\ghichuthietke` của j3 (bẫy thiếu điều kiện tháng nay ở j6, j9); dòng gói 3 trong `../../BAN-DO-100-CAU.md` (chỉ 8 dòng của gói; phần thống kê của bản đồ chưa đếm lại vì các gói khác đang sửa song song).
