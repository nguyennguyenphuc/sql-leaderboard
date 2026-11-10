# Quyết định các điểm "Chờ giảng viên" · bộ Marketing (`mkt`)

Ngày 10/11/2026. Nguồn danh sách: `BAO-CAO-TONG-HOP.md` mục 3 (21 điểm của mkt) và các mục chung 3.5 có nhắc mkt (áp theo
`QUYET-DINH-CHUNG.md`, gọi tắt QĐC). Chi tiết từng điểm (căn cứ, đã sửa gì) ở mục "Quyết định v3 (10/11)" trong `ho-so/goi-<k>/DA-SUA.md` của từng gói.

Nguồn domain: BG = `lesson1_marketing_analytics_foundations.md` trong `H:\My Drive\09._PC\Giang-day\Soan bai\Project DA\Project 01 Marketing Analytics Foundations & Data Pipeline\`
(mục II.A.2 kênh, II.C.1 CTR, III.B từ điển dữ liệu, IV.B.7 ngày không hợp lệ, IV.D KPI theo thương hiệu, loại chiến dịch). Thư mục `Review Marketing\`, `Rewrite Marketing\` không có trong thư mục dự án.
Số liệu kiểm trực tiếp trên MySQL `mkt`, `mkt_hidden_1` ngày 10/11.

## 21 điểm của bộ

| # | Mục báo cáo | Mã câu (gói) | Điểm | Trạng thái | Quyết định / lý do |
|---|---|---|---|---|---|
| 1 | 3.1 | `mkt-k4` (g5) | Nhánh `'00-00-0000'` phụ thuộc `sql_mode` | Đã sửa | Giữ câu; máy chấm dùng `sql_mode` mặc định MySQL 8.0, ghi vào `mysql/README-mkt.md` (đã thử: mặc định ra NULL, `sql_mode=''` ra `0000-00-00`). BG IV.B.7 coi `00-00-0000` là ngày không parse được. |
| 2 | 3.3 | `mkt-t5` (g4) | Tuần cuối tháng 6 về 0 | Đã sửa | Khoảng xét đổi sang quý 1/2025, đổi SQL và bài sai. BG III.B: Date là ngày bắt đầu; dữ liệu dừng ở 24/6/2025. |
| 3 | 3.3 | `mkt-a5` (g2) | Ngưỡng 350 chiến dịch có lãi | Giữ nguyên (có căn cứ) | Câu dạy `HAVING` trên đếm có điều kiện (M4); BG IV.D cho thấy hiệu quả giữa các nhóm chênh rất nhỏ, ghi chú thiết kế nói rõ câu không dùng để so hiệu quả giữa ngày. |
| 4 | 3.3 | `mkt-j3` (g3) | Số liệu theo kênh là lượt hiển thị của cả chiến dịch | Giữ nguyên (có căn cứ) | BG II.A.2, III.B: chiến dịch chạy nhiều kênh cùng lúc, số liệu ghi cho cả chiến dịch; câu chỉ đếm sự có mặt, không chia hiệu quả theo kênh. |
| 5 | 3.3 | `mkt-q3` (g3) | CTR các loại chênh < 0,1 điểm % | Giữ nguyên (có căn cứ) | BG IV.D "chênh lệch giữa các loại campaign khá nhỏ", II.C.1 cảnh báo so CTR thiếu bối cảnh: v2 chỉ "xem kỹ hơn", không chuyển ngân sách. |
| 6 | 3.3 | `mkt-q9` (g3) | Điểm tương tác chỉ so trong cùng loại | Đã sửa (ghi chú) | BG III.B chỉ định nghĩa "thang điểm tổng hợp"; giữ là yêu cầu của người hỏi; `\ghichuthietke` bỏ "chờ giảng viên". |
| 7 | 3.3 | `mkt-p4` (g5) | "Kênh liên hệ trực tiếp" cho Email + WhatsApp | Giữ nguyên (có căn cứ) | BG II.A.2 mô tả hai kênh khác nhau, không có nhóm này: gọi đúng tên hai kênh. |
| 8 | 3.4 | `mkt-r4, r5, r6, n3, n5, n9` (g1) | Dễ một bảng, ERD 2 bảng | Đã sửa (ghi chú) | Chấp nhận Dễ (QĐC 2.3 mục 16); ghi chú r5, r6 bỏ "chờ giảng viên". |
| 9 | 3.4 | `mkt-t7, t9` (g4) | Cấp | Đã sửa | t7 hạ Dễ (QĐC 0.1 #5 bản 23:05: bỏ ngoại lệ M7, M8 không có Dễ; sửa một từ khoá dễ thấy), ERD 2 bảng; t9 giữ Khó vì starter sai định nghĩa dòng trùng (QĐC 2.3 mục 17). |
| 10 | 3.4 | `mkt-p1, k8, p9, p7` (g5) | Cấp | Đã sửa | p1 hạ Cơ bản, k8 hạ Dễ (ERD theo cấp), p9 giữ Khó (2 bẫy), p7 giữ TB (QĐC 2.3 mục 18). |
| 11 | 3.4 | `mkt-p3` (g5) | Starter gần Dễ, cấp Khó | Giữ nguyên cấp (có căn cứ) | Giữ Khó (QĐC 2.3 mục 19: bẫy hoà ở hidden-1 + hàm cửa sổ); `\ghichuthietke` ghi lý do. |
| 12 | 3.6 | `mkt-a5` (g2) | Mã "500" | Đã sửa | → `mkt-a5-ngay-tren-350-co-lai`. |
| 13 | 3.6 | `mkt-c3` (g2) | Mã "nykaa" | Đã sửa | → `mkt-c3-thang-purplle-mo-nhieu-nhat`. |
| 14 | 3.6 | `mkt-c2` (g1) | Mã lệch nội dung | Đã sửa | → `mkt-c2-file-tho-thieu-nhieu-nhat`. |
| 15 | 3.6 | `mkt-p3` (g5) | Mã "tuong-quan" | Đã sửa | → `mkt-p3-top-3-doanh-thu-moi-thuong-hieu`. |
| 16 | 3.7 | `mkt-s4` (g2) | Lý do "đại lý YouTube" gượng | Đã sửa | Bối cảnh mới: số đối chiếu trước khi dùng bảng tách chuỗi kênh (BG III.B: "sẽ cần tách cột này ra"). |
| 17 | 3.7 | `mkt-t6` (g4) | Mảng customer → finance | Giữ nguyên (có căn cứ) | STYLE-mkt G: ROI, chi phí thuộc finance; bản đồ đã cập nhật. |
| 18 | 3.8 | Khái niệm `kenh-da-tri` (g3) | "không phải kênh chính" | Đã sửa | Dùng chữ STYLE-mkt A.1: "không phải mức ưu tiên". |
| 19 | 3.8 | `mkt-f9` (g4) | "Tira Beauty có đủ năm loại" quý 1/2025 | Giữ nguyên (đã kiểm) | Đếm: 5 loại ở cả `mkt` (14.445 chiến dịch) và `mkt_hidden_1` (12.990). |
| 20 | 3.8 | Mã còn tên kỹ thuật | `luat`, `khong-dung-ham`, `tim-trung-khong-tu-noi`, `exists-thay-join-distinct` | Đã sửa | → `mkt-t4-quy-tac-doi-chieu-nhat-ky`, `mkt-k6-do-chinh-xac-quy-tac`, `mkt-p2-bao-cao-thang-3-theo-loai`, `mkt-p6-dong-trung-du-lieu-tho`, `mkt-p4-ctr-kenh-email-whatsapp`. |
| 21 | 3.8 | Lời nhắn "Sửa truy vấn dưới đây để …" (9 chỗ) | Khung câu Sửa lỗi | Giữ nguyên (có căn cứ) | Khung của gói mẫu CHOT cho câu debug; đã giảm 8 chỗ ở lượt rà giọng. |

## Mục chung 3.5 áp vào bộ mkt

| Mục | Câu | Trạng thái | Việc |
|---|---|---|---|
| QĐC 1.1 (bản 23:05) kết luận case | 10 case | Đã sửa | Theo case mẫu c1–c4 của quy chuẩn: 10 phương án đúng mở "Đúng: ", bỏ "Chưa đúng. " ở 20 phương án sai. |
| QĐC 1.2 case Cơ bản dùng `GROUP BY` | `mkt-c1`, `mkt-c2` | Đã sửa (ghi chú) | Một bảng, một cột gom; thêm câu chuẩn vào `\ghichuthietke`. |
| QĐC 1.3 (bản 23:05) ERD Khó | t5, t9, p3 | Giữ nguyên | Đầu lượt đã bỏ bảng nhiễu để còn ≤ 2; QĐC sửa theo quy chuẩn (Khó 5–7 bảng chỉ khoá, được thêm bảng nhiễu khi lời giải dùng ít bảng, mẫu o4) nên đã trả lại, ba câu giữ 5 bảng như v2. Các câu Khó khác không phải sửa. |
| QĐC 1.6 f2/f8 | `mkt-f2` | Đã sửa (ghi chú) | Thêm câu chuẩn vào `\ghichuthietke` f2. |

## Mã đã đổi (9)

| Cũ | Mới |
|---|---|
| `mkt-a5-ngay-tren-500-chien-dich` | `mkt-a5-ngay-tren-350-co-lai` |
| `mkt-c2-nhieu-don-vao-thuong-hieu-nao` | `mkt-c2-file-tho-thieu-nhieu-nhat` |
| `mkt-c3-thang-nykaa-mo-nhieu-nhat` | `mkt-c3-thang-purplle-mo-nhieu-nhat` |
| `mkt-p3-top-3-khong-dem-tuong-quan` | `mkt-p3-top-3-doanh-thu-moi-thuong-hieu` |
| `mkt-t4-luat-phat-hien-so-nhat-ky` | `mkt-t4-quy-tac-doi-chieu-nhat-ky` |
| `mkt-k6-do-chinh-xac-luat` | `mkt-k6-do-chinh-xac-quy-tac` |
| `mkt-p2-loc-thang-khong-dung-ham` | `mkt-p2-bao-cao-thang-3-theo-loai` |
| `mkt-p4-exists-thay-join-distinct` | `mkt-p4-ctr-kenh-email-whatsapp` |
| `mkt-p6-tim-trung-khong-tu-noi` | `mkt-p6-dong-trung-du-lieu-tho` |

Đổi đồng bộ ở `cau-hoi.tex`, `solution.sql`, `BANG-PHAN-CONG.md`, `DA-SUA.md`, `BAN-DO-100-CAU.md`. `REVIEW-*.md` và `BAO-CAO-TONG-HOP.md` giữ mã cũ (hồ sơ lịch sử).

## Kiểm

- Bộ kiểm đầy đủ (public + hidden-1, MySQL `sqllb-mysql`), từng gói, sau mọi sửa đổi: gói 1–5 đều **KIEM TRA: 0 loi**
  (log: `cong-cu/ket-qua/v3-mkt-goi-<k>.log`, báo cáo: `cong-cu/ket-qua/v3/mkt-goi-<k>/`). t5 với bài sai mới, t7 (easy), k8 (easy), p1 (basic): 0 lỗi, 0 cảnh báo.
  Gói 1–3 chạy lại phân tích tĩnh sau lần đổi tiền tố case: 0 lỗi.
- Biên dịch XeLaTeX (`cong-cu/bien_dich.sh`, ra `cong-cu/ket-qua/bien-dich/v3-mkt-goi-<k>/`): gói 1–5 = 43, 47, 49, 62, 60 trang; 0 lỗi LaTeX, 0 ký tự thiếu, 0 cảnh báo của gói lệnh.
- Không sửa `mysql/mkt/04_bo_sung_bien_the_mkt.sql`: không điểm nào cần thêm dòng vào `mkt_hidden_1`.
- Áp QUYET-DINH-CHUNG bản 23:05 (đối chiếu quy chuẩn): kết luận case "Đúng: " / không tiền tố; ERD Khó giữ 5 bảng; t7 hạ Dễ.
