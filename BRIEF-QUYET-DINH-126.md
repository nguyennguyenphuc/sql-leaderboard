# Xử lý 126 điểm "Chờ giảng viên" (BAO-CAO-TONG-HOP.md mục 3)

Giảng viên giao: quyết và sửa TOÀN BỘ 126 điểm, dựa trên (1) kiến thức domain trong tài liệu dự án ở
`Project DA\` và (2) chuẩn ra đề SQL tham khảo HackerRank. Không còn "chờ".

## Nguồn domain (CHỈ ĐỌC; KHÔNG quét đệ quy thư mục `Project DA` – Google Drive sẽ tải hàng loạt)
Liệt kê từng cấp thư mục bằng `ls` một cấp, rồi mở đúng file cần (pdf/docx/md/xlsx: dùng công cụ đọc phù hợp).
- Supply Chain: `Project DA\SupplyChain\` – sách dự án eDA2026 (SQL + Power BI) là chuẩn thuật ngữ; bảng thuật ngữ Việt–Anh. Các file `labs*.py` là bản nháp, KHÔNG dẫn.
- Finance (aivb): `Project DA\Finance\`, `Project DA\Finnance_Accounting\` – Blueprint, mô tả dữ liệu AIV Bank.
- Game (jelly): `Project DA\Game\`.
- HR: `Project DA\Project 02 HR Analytics\`.
- Marketing: `Project DA\Project 01 Marketing Analytics Foundations & Data Pipeline\` (và `Review Marketing\`, `Rewrite Marketing\` nếu cần).
- `Project DA\Portfolio Project Descriptions.pdf` – mô tả chung các dự án.
Khi tài liệu dự án không nói, dùng chuẩn giáo trình đại học Việt Nam / văn bản pháp quy (Bộ luật Lao động, Luật Các TCTD, thông tư NHNN…) qua WebSearch, ghi nguồn.

## Quy ước chung và thang cấp độ
Đọc `QUYET-DINH-CHUNG.md` ở thư mục gốc (do agent quy ước viết, có tham khảo HackerRank). Nếu file chưa có thì làm các mục khác trước, quay lại mục cấp độ/quy ước sau (kiểm bằng `ls`, chờ tối đa 25 phút).

## Cách làm từng điểm
1. Lấy các dòng của bộ mình trong BAO-CAO-TONG-HOP.md mục 3.1–3.4, 3.6–3.8 (mục 3.5 thuộc agent quy ước, nhưng ÁP DỤNG quyết định của nó vào gói của bộ mình).
2. Mỗi điểm: tra nguồn domain → ra QUYẾT ĐỊNH (có thể khác đề xuất mặc định nếu tài liệu nói khác) → sửa câu. Được phép: đổi lời đề, đổi SQL/wrong/starter, đổi cấp, đổi mã câu (`ma`) khi mã lệch nội dung – khi đổi mã phải đổi đồng bộ ở cau-hoi.tex, solution.sql, BANG-PHAN-CONG.md, DA-SUA.md, BAN-DO-100-CAU.md, bao-cao/kiem-cuoi/*.json không cần.
3. Điểm cần thêm dòng vào biến thể ẩn: chỉ sửa file `04_bo_sung_bien_the_<bo>.sql` của bộ mình, giữ idempotent, áp vào `<bo>_hidden_1` (KHÔNG đụng public), chạy lại solution mọi câu dùng bảng đó trên hai biến thể.
4. Văn bản mới qua cửa chặn giọng văn (BRIEF-KIEM-GOI.md bước 6, STYLE-<bo>.md): không giọng AI, không dịch máy, đúng thuật ngữ. Phương án case: giữ độ dài cân nhau, không lộ đáp án (K32).
5. Kiểm: MySQL đang rảnh – chạy bộ kiểm ĐẦY ĐỦ cho mọi gói đã sửa SQL/yêu cầu: `bash cong-cu/kiem_tat_ca.sh 2 <bo>` (hoặc lệnh một gói trong cong-cu/README.md) → mọi gói "KIEM TRA: 0 loi"; biên dịch lại `bash cong-cu/bien_dich.sh <goi> <đường dẫn ra tuyệt đối>` → 0 lỗi LaTeX.
6. Ghi trong DA-SUA.md của từng gói mục mới "Quyết định v3 (10/11)": mã | điểm | quyết định | căn cứ (file + trang/mục, hoặc URL) | đã sửa gì. Cập nhật BANG-PHAN-CONG.md (v3) và BAN-DO-100-CAU.md nếu đổi cấp/mã.
7. Ghi `goi-cau-hoi\<bo>\QUYET-DINH-126.md`: bảng mọi điểm của bộ → trạng thái "Đã sửa" / "Giữ nguyên (lý do có căn cứ)". Không để mục nào "chờ".

Báo cáo cuối (≤ 150 từ): số điểm đã sửa / giữ nguyên có căn cứ, các nguồn domain đã dùng, kết quả bộ kiểm từng gói, biên dịch, mã đã đổi.
