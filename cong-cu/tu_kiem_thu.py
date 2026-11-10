#!/usr/bin/env python3
"""tu_kiem_thu.py: tự kiểm thử bộ kiểm gói (kiem_tra_goi.py).

    docker run --rm --network sqllb -v "C:\\Cong viec\\ProjectDA\\sql-leaderboard:/w" -w /w sqllb-tools \
        python cong-cu/tu_kiem_thu.py [--host sqllb-mysql --port 3306]

(1) Gói mẫu 16 câu (Datathon) chỉ phân tích: đủ 16 câu, 51 khối SQL, 0 lỗi.
(2) Gói thử goi-cau-hoi/_thu-bo-kiem (4 câu trên scm) chạy thật: 0 lỗi; wrong của t1 rớt đúng hidden-1.
(3) Làm hỏng gói thử từng chỗ một, mỗi lỗi phải bị bắt đúng mã lỗi, đúng câu.
In "TU KIEM THU: N/N dat" ở dòng cuối.
"""
from __future__ import annotations

import argparse
import contextlib
import io
import json
import shutil
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
sys.path.insert(0, str(HERE))
import kiem_tra_goi  # noqa: E402

GOI_MAU = ROOT / "quy_chuan" / "goi-cau-hoi-mau"
GOI_THU = ROOT / "goi-cau-hoi" / "_thu-bo-kiem"
RA = HERE / "ket-qua"

# (tên, file, chuỗi cũ, chuỗi mới, mã câu, mã lỗi, mức: loi|canh_bao)
HONG = [
    ("wrong khong rot", "solution.sql",
     "WHERE store_nbr = 44\n  AND `date` >= '2017-07-01';",
     "WHERE store_nbr = 44\n  AND `date` BETWEEN '2017-07-01' AND '2017-07-31';",
     "t1-ban-cua-hang-44", "WRONG_KHONG_ROT", "loi"),
    ("starter optimize sai ket qua", "solution.sql",
     "region = 'NAM'\n     AND order_date >= '2017-07-01'",
     "region = 'NAM'\n     AND order_date >= '2017-07-02'",
     "t3-don-theo-mien-thang-7", "STARTER_OPT_SAI_KET_QUA", "loi"),
    ("thieu khoa bat buoc (dang cua write)", "cau-hoi.tex",
     "hinhthuc=write, cap=basic, dang=A2,", "hinhthuc=write, cap=basic,",
     "t1-ban-cua-hang-44", "THIEU_KHOA", "loi"),
    ("khainiem chua khai bao", "cau-hoi.tex",
     "\\khainiem{po-giao-tre}", "\\khainiem{po-giao-tre}\n  \\khainiem{chua-khai-bao}",
     "t2-po-giao-tre-2016", "KHAINIEM_CHUA_KHAI_BAO", "loi"),
    ("nghiepvu lo so ket qua", "cau-hoi.tex",
     "\\luuy{Năm 2016 gồm các PO", "\\luuy{Năm 2016 có 7.657 PO giao trễ.}\n  \\luuy{Năm 2016 gồm các PO",
     "t2-po-giao-tre-2016", "NGHIEPVU_LO_SO", "canh_bao"),
    # thêm: các phép kiểm khác của quy chuẩn
    ("debug starter khong sai", "solution.sql",
     "WHERE received_date > promised_date\n  AND po_date >= '2016-01-01';",
     "WHERE received_date > promised_date\n  AND po_date >= '2016-01-01' AND po_date < '2017-01-01';",
     "t2-po-giao-tre-2016", "STARTER_DEBUG_KHONG_SAI", "loi"),
    ("optimize starter khong vi pham", "solution.sql",
     "-- [t3-don-theo-mien-thang-7] starter\n",
     "-- [t3-don-theo-mien-thang-7] starter\n"
     "SELECT COUNT(CASE WHEN region = 'BAC' THEN 1 END) AS bac,\n"
     "       COUNT(CASE WHEN region = 'TRUNG' THEN 1 END) AS trung,\n"
     "       COUNT(CASE WHEN region = 'NAM' THEN 1 END) AS nam\n"
     "FROM orders WHERE order_date >= '2017-07-01' AND order_date < '2017-08-01';\n\n"
     "-- [t3-don-theo-mien-thang-7] wrong: starter_cu_quet_3_lan\n",
     "t3-don-theo-mien-thang-7", "STARTER_OPT_KHONG_VI_PHAM", "loi"),
    ("ketluan hai phuongan dung", "cau-hoi.tex",
     "\\phuongan{Ba miền huỷ như nhau", "\\phuongan*{Ba miền huỷ như nhau",
     "t4-mien-huy-nhieu", "PHUONGAN_DUNG_SAI", "loi"),
    ("tu khoa ghi trong solution", "solution.sql",
     "-- [t1-ban-cua-hang-44] solution\nSELECT SUM(unit_sales) AS tong_ban\nFROM sales",
     "-- [t1-ban-cua-hang-44] solution\nWITH x AS (SELECT 1) DELETE FROM sales;\nSELECT SUM(unit_sales) AS tong_ban\nFROM sales",
     "t1-ban-cua-hang-44", "SQL_KHONG_HOP_LE", "loi"),
    ("case bước write thieu solution", "solution.sql",
     "-- [t4-mien-huy-nhieu.b1] solution", "-- [t4-mien-huy-nhieu.b1] wrong: bo_mat_solution",
     "t4-mien-huy-nhieu", "SQL_THIEU", "loi"),
]


def chay(argv) -> tuple[int, str, dict]:
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        code = kiem_tra_goi.main(argv)
    ra = Path(argv[argv.index("--ra") + 1])
    bao = json.loads((ra / "bao-cao-import.json").read_text(encoding="utf-8"))
    return code, out.getvalue(), bao


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--host", default="sqllb-mysql")
    ap.add_argument("--port", default="3306")
    a = ap.parse_args()
    db = ["--host", a.host, "--port", str(a.port)]
    ket = []

    def dat(ten, ok, ghi=""):
        ket.append(ok)
        print(f"[{'DAT ' if ok else 'HONG'}] {ten}{(' · ' + ghi) if ghi else ''}", flush=True)

    # ---------------------------------------------------------------- (1)
    code, out, bao = chay(["--goi", str(GOI_MAU), "--ra", str(RA / "goi-cau-hoi-mau"), "--chi-phan-tich"])
    ht = {}
    for c in bao["cau"]:
        ht[c["hinhthuc"]] = ht.get(c["hinhthuc"], 0) + 1
    so_buoc = sum(len(c["buoc"]) for c in bao["cau"])
    cb = [(c["ma"], e["ma_loi"], e["dong"]) for c in bao["cau"] for e in c["canh_bao"]]
    dat("(1) goi mau: 16 cau, 51 khoi SQL, 0 loi",
        bao["tong"]["so_cau"] == 16 and bao["so_khoi_sql"] == 51 and bao["tong"]["so_loi"] == 0
        and ht == {"write": 4, "debug": 4, "optimize": 4, "case": 4} and so_buoc == 14
        and cb == [("o2-doanh-thu-theo-nam", "LATEX_GACH_DUOI", 360)],
        f"{bao['tong']['so_cau']} cau, {bao['so_khoi_sql']} khoi, {so_buoc} buoc case, {bao['tong']['so_loi']} loi; "
        f"canh bao: {cb} (loi bien dich XeLaTeX that cua goi mau)")

    # ---------------------------------------------------------------- (2)
    code, out, bao = chay(["--goi", str(GOI_THU), "--ra", str(RA / "_thu-bo-kiem")] + db)
    t1 = next(c for c in bao["cau"] if c["ma"] == "t1-ban-cua-hang-44")
    t3 = next(c for c in bao["cau"] if c["ma"] == "t3-don-theo-mien-thang-7")
    ok = (bao["tong"]["so_loi"] == 0 and code == 0
          and t1["wrong"]["quen_can_tren"]["rot_o"] == ["hidden-1"]
          and t3["optimize"]["starter"]["quet"].get("orders") == 3
          and t3["optimize"]["solution"]["quet"].get("orders") == 1)
    dat("(2) goi thu _thu-bo-kiem: 0 loi", ok,
        f"{bao['tong']['so_loi']} loi; t1 wrong rot o {t1['wrong']['quen_can_tren']['rot_o']}; "
        f"t3 quet starter/solution {t3['optimize']['starter']['quet']}/{t3['optimize']['solution']['quet']}")
    if not ok:
        print(out)

    # ---------------------------------------------------------------- (3)
    for ten, f, cu, moi, ma, ma_loi, muc in HONG:
        tmp = Path(tempfile.mkdtemp(prefix="hong-"))
        for p in GOI_THU.iterdir():
            shutil.copy(p, tmp / p.name)
        txt = (tmp / f).read_text(encoding="utf-8")
        if cu not in txt:
            dat(f"(3) {ten}", False, f"không tìm thấy chuỗi cần sửa trong {f}")
            continue
        (tmp / f).write_text(txt.replace(cu, moi, 1), encoding="utf-8")
        code, out, bao = chay(["--goi", str(tmp), "--ra", str(tmp / "ra")] + db)
        c = next((c for c in bao["cau"] if c["ma"] == ma), None)
        ds = (c["loi"] if muc == "loi" else c["canh_bao"]) if c else []
        bat = any(e["ma_loi"] == ma_loi for e in ds)
        tb = next((e["thong_diep"] for e in ds if e["ma_loi"] == ma_loi), "")
        dat(f"(3) {ten} -> {ma_loi} ({muc})", bat and (muc == "canh_bao" or code != 0),
            f"{ma}: {tb}" if bat else f"không bắt được; loi={[e['ma_loi'] for e in (c or {}).get('loi', [])]}")
        shutil.rmtree(tmp, ignore_errors=True)

    # ---------------------------------------------------------------- (4) so kết quả (không cần MySQL)
    import decimal
    from may_cham import KetQua, so_ket_qua
    K = lambda cot, *dong: KetQua(True, list(cot), list(dong))  # noqa: E731
    vd = [
        ("chuoi '2019' khac so 2019", K(["nam"], ("2019",)), K(["nam"], (2019,)), {}, False),
        ("Decimal = float trong sai so", K(["x"], (decimal.Decimal("1.004"),)), K(["x"], (1.0,)), {}, True),
        ("ngoai sai so", K(["x"], (decimal.Decimal("1.02"),)), K(["x"], (1.0,)), {}, False),
        ("NULL chi bang NULL", K(["x"], (None,)), K(["x"], (0,)), {}, False),
        ("NULL = NULL", K(["x"], (None,)), K(["x"], (None,)), {}, True),
        ("thu tu khac, thutu=co", K(["a"], (1,), (2,)), K(["a"], (2,), (1,)), {}, False),
        ("thu tu khac, thutu=khong", K(["a"], (1,), (2,)), K(["a"], (2,), (1,)), {"thutu": "khong"}, True),
        ("socot=ten, doi cho cot", K(["a", "b"], (1, "x")), K(["b", "a"], ("x", 1)), {"socot": "ten"}, True),
        ("socot=vitri, doi cho cot", K(["a", "b"], (1, "x")), K(["b", "a"], ("x", 1)), {}, False),
        ("khac so dong", K(["a"], (1,)), K(["a"], (1,), (1,)), {}, False),
    ]
    sai = [t for t, a, b, kw, mong in vd if so_ket_qua(a, b, **kw)[0] != mong]
    dat(f"(4) so ket qua: {len(vd)} truong hop", not sai, ("sai: " + ", ".join(sai)) if sai else "")

    print(f"TU KIEM THU: {sum(ket)}/{len(ket)} dat")
    return 0 if all(ket) else 1


if __name__ == "__main__":
    sys.exit(main())
