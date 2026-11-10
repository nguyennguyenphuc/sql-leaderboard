# Dòng bản đồ v4 · mkt gói 1 (11/11/2026)

Các dòng thay thế trong `goi-cau-hoi/mkt/BAN-DO-100-CAU.md`, mục "Gói 1 · M1 Retrieval, M2 NULL & Expressions". Không sửa trực tiếp file bản đồ (các agent gói 2–5 đang sửa song song); người cộng bảng tổng thay từng dòng theo cột "Thay dòng của mã cũ". Định dạng giống dòng hiện có (cột "Đề một câu" là hai mục đầu của `yeucau`).

| Thay dòng của mã cũ | Cấp cũ |
|---|---|
| `mkt-r2-working-women-tamil-tira` | basic |
| `mkt-r3-roi-thap-nhat-nykaa-q4` | basic |
| `mkt-r6-diem-tuong-tac-tu-30` | easy |
| `mkt-r9-youth-hoac-working-women-thua` | easy |
| `mkt-n4-lai-hoa-lo-quy-1` | easy |
| `mkt-n6-gia-tri-don-11-11` | easy |
| `mkt-n7-doanh-thu-tho-thap-bat-thuong` | basic |
| `mkt-n9-thieu-chi-phi-ra-0` | easy |

Dòng mới (cùng thứ tự):

| Mã | Gói | Module | HT | Cấp | Dạng | Mảng | Tiêu đề | Đề một câu | Bảng | Bẫy chính |
|---|---|---|---|---|---|---|---|---|---|---|
| mkt-r2-qua-8-3-tira-ban-tot | 1 | M1 | W | medium | A1 | sal | Chiến dịch quà tặng 8/3 nào của Tira Beauty bán tốt? | Xét các chiến dịch của Tira Beauty (`brand_id = 3`). · Lấy các chiến dịch quà tặng 8/3 bán tốt, theo định nghĩa ở tab Nghiệp vụ. | C | bien-between, nham-doi-tuong-voi-phan-khuc, bo-ngay-cuoi |
| mkt-r3-10-lo-nang-thue-ngoai-purplle-q4 | 1 | M1 | W | medium | A1 | fin | 10 chiến dịch thuê ngoài lỗ nặng nhất của Purplle quý 4/2024 | Xét các chiến dịch của Purplle (`brand_id = 2`) bắt đầu từ ngày 1/10/2024 tới hết ngày 31/12/2024, thuộc nhóm thuê ngoài (xem tab Nghiệp vụ). · Lấy đúng 10 chiến dịch có ROI (lợi tức đầu tư) thấp nhất theo cột `roi`. | C | hoa-hang-o-hang-cuoi, quy-tac-hoa-theo-chuoi, nhom-loai-chi-tra, thieu-can-tren |
| mkt-r6-noi-dung-mau-sinh-vien-nykaa-q2 | 1 | M1 | W | hard | A1 | mkt | Nội dung nào cho sinh viên của Nykaa quý 2/2025 đáng làm mẫu? | Xét các chiến dịch của Nykaa bắt đầu trong quý 2/2025. · Lấy chiến dịch có nội dung đáng làm mẫu cho sinh viên nói tiếng Hindi, theo tiêu chí ở tab Nghiệp vụ. | C | thieu-can-tren, nham-phan-khuc, giu-thue-ngoai, bien-20-diem, bien-14-ngay |
| mkt-r9-gioi-tre-cuoi-thang-6-thua | 1 | M1 | D | hard | A1 | cus | Chiến dịch cho sinh viên, giới trẻ nửa cuối tháng 6 ra thừa | Sửa truy vấn khởi đầu để lấy đúng các chiến dịch tiếng Hindi (`language_id = 3`) của Nykaa (`brand_id = 1`) bắt đầu từ ngày 16/6/2025 tới hết ngày 30/6/2025, nhắm tới sinh viên (College Students, mã 1) hoặc giới trẻ … | C | thu-tu-and-or, phu-dinh-hai-dieu-kien, thieu-can-tren |
| mkt-n4-nhom-lai-lo-nykaa-quy-2 | 1 | M2 | W | hard | A3 | fin | Chiến dịch Nykaa quý 2/2025 chia theo nhóm lãi lỗ ra sao? | Xét các chiến dịch của Nykaa bắt đầu trong quý 2/2025. · Xếp mỗi chiến dịch vào đúng một nhóm `'xem_lai_hop_dong'`, `'lo'`, `'hoa_von'` hoặc `'co_lai'`, theo quy tắc ở tab Nghiệp vụ. | C | thu-tu-case, bien-0-5, bien-bang-0, nham-cpa-voi-tong-chi-phi, thieu-can-tren |
| mkt-n6-ty-le-roi-sau-nhap-11-11 | 1 | M2 | W | medium | A2 | mkt | Tỷ lệ rơi sau lượt nhấp của chiến dịch Influencer Purplle dịp 11/11 | Xét các chiến dịch của Purplle (`brand_id = 2`), loại Influencer (marketing người ảnh hưởng, `type_id = 2`), bắt đầu ngày 11/11/2024. · Tính tỷ lệ rơi từ tầng quan tâm sang tầng cân nhắc của từng chiến dịch, theo khái niệm ở tab Nghiệp vụ; … | C | quen-1-tru, sai-tang-mau-so, quen-nhan-100 |
| mkt-n7-gia-tri-don-tho-lech | 1 | M2 | D | medium | A2 | sal | Giá trị đơn bình quân trên dữ liệu thô vẫn lệch | Sửa truy vấn khởi đầu để tính đúng giá trị đơn bình quân của toàn bộ `campaigns_raw` theo định nghĩa ở tab Nghiệp vụ. · Giữ nguyên cột `gia_tri_don` (đơn vị tiền, làm tròn 2 chữ số). | R | null-lech-dong-tu-mau, gia-tri-am, binh-quan-gian-don |
| mkt-n9-cpc-cpm-nykaa-thang-6-lech | 1 | M2 | D | hard | A2 | fin | CPC và CPM mạng xã hội Nykaa tháng 6 nhỏ bất thường | Sửa truy vấn khởi đầu để tính đúng CPC (chi phí trên mỗi lượt nhấp) và CPM (chi phí trên 1.000 lượt hiển thị) của các chiến dịch Social Media (marketing mạng xã hội, `type_id = 5`) tiếng Hindi … | C | nham-cpa-voi-tong-chi-phi, lam-tron-som, thieu-can-tren |

Phân bố sau v4 (đếm từ `cau-hoi.tex`): M1 Cơ bản r1, r7 · Dễ r4, r5, r8 · Trung bình r2, r3 · Khó r6, r9; M2 Cơ bản n1, n2 · Dễ n3, n5, n8 · Trung bình n6, n7 · Khó n4, n9. Mỗi module 6 W + 3 D. Case c1, c2 giữ Cơ bản.

Đối chiếu ô (dạng · mảng · cấp · HT) với bản đồ lúc sửa (11/11): cả 8 ô mới đều trống trong bộ: A1·sal·medium·W, A1·fin·medium·W, A1·mkt·hard·W, A1·cus·hard·D, A3·fin·hard·W, A2·mkt·medium·W, A2·sal·medium·D, A2·fin·hard·D. Ô cũ A1·mkt·easy·W (r6 trùng s4) nay chỉ còn s4. Các gói khác đang sửa song song: cần đối chiếu lại khi cộng bảng tổng.
