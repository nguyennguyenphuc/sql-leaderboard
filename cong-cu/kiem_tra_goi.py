#!/usr/bin/env python3
"""kiem_tra_goi.py: bộ kiểm gói câu hỏi SQL Leaderboard (chuẩn aio-sql-cauhoi v0.4, CHOT-FORMAT-CAU-HOI mục 4 và 6).

    python cong-cu/kiem_tra_goi.py --goi <thư mục gói | gói.zip> --ra <thư mục ra> \
        --host sqllb-mysql --port 3306 [--user sql_runner] [--chi-phan-tich]

Mật khẩu user chạy bài: --password, hoặc biến SQLLB_RUNNER_PASSWORD, hoặc SQL_RUNNER_PASSWORD trong
mysql/.env (--env-file). Không in mật khẩu.
Ánh xạ bộ dữ liệu -> database: cong-cu/bien-the.json (--cau-hinh); không có thì public = <dulieu> (đổi '-' thành '_'),
hidden-N = <dulieu>_hidden_N.
Xuất <ra>/bao-cao-import.json; dòng cuối in "KIEM TRA: N loi".
"""
from __future__ import annotations

import argparse
import datetime as dt
import io
import json
import os
import re
import sys
import tempfile
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import doc_goi  # noqa: E402
from doc_goi import loi  # noqa: E402

FILE_GOI = ["cau-hoi.tex", "solution.sql", "aio-sql-cauhoi.sty", "HUONG_DAN.md"]
ZIP_TOI_DA = 2 * 1024 * 1024
SQL_TOI_DA = 256 * 1024
CAU_TOI_DA = 20


# ============================================================ đọc gói
def mo_goi(duong: Path, goi_loi: list, goi_cb: list) -> Path:
    if duong.is_file() and duong.suffix.lower() == ".zip":
        size = duong.stat().st_size
        if size > ZIP_TOI_DA:
            goi_loi.append(loi("GOI_QUA_LON", f"zip {size} byte > 2 MB", duong.name))
        tmp = Path(tempfile.mkdtemp(prefix="goi-"))
        with zipfile.ZipFile(duong) as z:
            ten = [n for n in z.namelist() if not n.endswith("/")]
            for n in ten:
                if "/" in n or "\\" in n:
                    goi_loi.append(loi("GOI_KHONG_PHANG", f"zip có thư mục con: {n}", duong.name))
            for n in ten:
                if n not in FILE_GOI:
                    goi_loi.append(loi("GOI_FILE_LA", f"zip có file lạ: {n} (chỉ 4 file {', '.join(FILE_GOI)})",
                                       duong.name))
            for n in ten:
                if n in FILE_GOI:
                    (tmp / n).write_bytes(z.read(n))
        thu_muc = tmp
    elif duong.is_dir():
        thu_muc = duong
        la = sorted(p.name for p in duong.iterdir() if p.is_file() and p.name not in FILE_GOI)
        if la:
            goi_cb.append(loi("GOI_FILE_LA", f"thư mục gói có file ngoài 4 file chuẩn (không đưa vào zip): "
                                             f"{', '.join(la[:8])}", str(duong)))
        if any(p.is_dir() for p in duong.iterdir()):
            goi_cb.append(loi("GOI_KHONG_PHANG", "thư mục gói có thư mục con (zip phải phẳng)", str(duong)))
        # ước lượng cỡ zip của 4 file
        buf = io.BytesIO()
        with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as z:
            for n in FILE_GOI:
                if (duong / n).is_file():
                    z.write(duong / n, n)
        if buf.tell() > ZIP_TOI_DA:
            goi_loi.append(loi("GOI_QUA_LON", f"zip 4 file ước tính {buf.tell()} byte > 2 MB", str(duong)))
    else:
        raise SystemExit(f"Không đọc được gói: {duong}")
    for n in FILE_GOI:
        if not (thu_muc / n).is_file():
            goi_loi.append(loi("GOI_THIEU_FILE", f"thiếu file {n}", n))
    sql = thu_muc / "solution.sql"
    if sql.is_file() and sql.stat().st_size > SQL_TOI_DA:
        goi_loi.append(loi("SQL_QUA_LON", f"solution.sql {sql.stat().st_size} byte > 256 KB", "solution.sql"))
    return thu_muc


def doc_text(p: Path) -> str:
    if not p.is_file():
        return ""
    b = p.read_bytes()
    if b.startswith(b"\xef\xbb\xbf"):
        b = b[3:]
    return b.decode("utf-8", "replace").replace("\r\n", "\n")


# ============================================================ cấu hình biến thể
def bien_the(dulieu: str, ten: str, cau_hinh: dict) -> str:
    m = cau_hinh.get(dulieu, {})
    if ten in m:
        return m[ten]
    goc = m.get("public", dulieu.replace("-", "_"))
    if ten == "public":
        return goc
    n = ten.split("-", 1)[1]
    return f"{goc}_hidden_{n}"


def doc_mat_khau(args) -> str | None:
    if args.password:
        return args.password
    if os.environ.get("SQLLB_RUNNER_PASSWORD"):
        return os.environ["SQLLB_RUNNER_PASSWORD"]
    envf = Path(args.env_file) if args.env_file else Path(__file__).resolve().parent.parent / "mysql" / ".env"
    if envf.is_file():
        for line in envf.read_text(encoding="utf-8").splitlines():
            if line.startswith("SQL_RUNNER_PASSWORD="):
                return line.split("=", 1)[1].strip().strip('"').strip("'")
    return None


# ============================================================ số trong tab Nghiệp vụ
SO_RE = re.compile(r"(?<![\w])(\d[\d.,]*\d|\d)(?![\w])")


def so_trong_van_ban(text: str) -> list[tuple[str, set[float]]]:
    """Các số trong văn bản, mỗi số kèm các cách hiểu (kiểu Việt 3.384 / 1,5 và kiểu Anh)."""
    out = []
    for m in SO_RE.finditer(doc_goi.van_ban_thuan(text)):
        s = m.group(1)
        cach = set()
        for thap_phan, nghin in ((",", "."), (".", ",")):
            t = s.replace(nghin, "")
            if t.count(thap_phan) <= 1:
                try:
                    cach.add(float(t.replace(thap_phan, ".")))
                except ValueError:
                    pass
        if cach:
            out.append((s, cach))
    return out


def so_trong_ket_qua(kq) -> list[float]:
    vals = []
    for r in kq.dong:
        for v in r:
            if doc_goi.so_thuc(v) is not None and not isinstance(v, (str, bytes)):
                vals.append(float(v))
    return vals


# ============================================================ kiểm một câu trên MySQL
class KiemCau:
    def __init__(self, may, cau, cau_hinh, args):
        self.may, self.c, self.args = may, cau, args
        self.ch = doc_goi.chuan_hoa(cau)
        dl = cau.khoa.get("dulieu")
        self.bt = [(v, bien_the(dl, v, cau_hinh)) for v in self.ch["bokiemtra"]]
        self.bao = {"kiem_tra": [], "solution": {}, "wrong": {}, "starter": {}, "optimize": None, "buoc": {}}
        self.ket_qua_sol = {}  # khoa -> {variant: KetQua}

    def ghi(self, phep, ket_qua, chi_tiet=""):
        self.bao["kiem_tra"].append({"phep": phep, "ket_qua": ket_qua, "chi_tiet": chi_tiet})

    def L(self, ma, msg, dong=None, file="solution.sql"):
        self.c.loi.append(loi(ma, msg, file, dong))
        self.ghi(ma, "loi", msg)

    def W(self, ma, msg, dong=None, file="solution.sql"):
        self.c.canh_bao.append(loi(ma, msg, file, dong))
        self.ghi(ma, "canh_bao", msg)

    # ---------------------------------------------------------------- tiện ích
    def kiem_bien_the(self) -> bool:
        ok = True
        for v, db in self.bt:
            if not self.may.co_db(db):
                self.L("BIEN_THE_KHONG_CO", f"biến thể {v} -> database '{db}' không có (hoặc user không có quyền)",
                       file="cau-hoi.tex", dong=self.c.dong)
                ok = False
        return ok

    def kiem_schema(self, schema: dict):
        c = self.c
        for ten, info in c.erd.get("bang", {}).items():
            if ten.lower() not in schema:
                c.loi.append(loi("ERD_BANG_KHONG_CO", f"ERD: bảng '{ten}' không có trong {self.bt[0][1]}",
                                 dong=info["dong"]))
                continue
            for col in info["cot"]:
                if col.lower() not in schema[ten.lower()]:
                    c.loi.append(loi("ERD_COT_KHONG_CO", f"ERD: cột '{ten}.{col}' không có", dong=info["dong"]))
        for noi in c.erd.get("noi", []):
            for dau in (noi["tu"], noi["toi"]):
                if "." not in dau:
                    c.loi.append(loi("ERD_NOI_SAI", f"\\erdnoi: '{dau}' phải có dạng bang.cot", dong=noi["dong"]))
                    continue
                t, col = dau.split(".", 1)
                if t.lower() not in schema or col.lower() not in schema[t.lower()]:
                    c.loi.append(loi("ERD_COT_KHONG_CO", f"\\erdnoi: '{dau}' không có trong schema", dong=noi["dong"]))
        for t in self.ch["quettoida"]:
            if t.lower() not in schema:
                c.loi.append(loi("QUETTOIDA_BANG_KHONG_CO", f"quettoida: bảng '{t}' không có", dong=c.dong))
        for b in c.buoc:
            for t in b.bang:
                if t.lower() not in schema:
                    c.loi.append(loi("BUOC_BANG_KHONG_CO", f"bước {b.ma}: bang '{t}' không có", dong=b.dong))

    def chay_moi_bt(self, khoi):
        return {v: self.may.chay(db, khoi.sql_chay) for v, db in self.bt}

    def so(self, a, b):
        return self.may_so(a, b)

    def may_so(self, chuan, bai):
        import may_cham
        return may_cham.so_ket_qua(chuan, bai, self.ch["thutu"], self.ch["socot"], self.ch["saiso"])

    # ---------------------------------------------------------------- solution
    def kiem_solution(self, khoa, sol, nhan) -> dict | None:
        import may_cham
        kq = {}
        ok = True
        for v, db in self.bt:
            r1 = self.may.chay(db, sol.sql_chay)
            if not r1.ok:
                self.L("SOLUTION_LOI", f"{nhan} solution không chạy được trên {v}: {r1.loi}", sol.dong)
                ok = False
                continue
            r2 = self.may.chay(db, sol.sql_chay)
            bang, ly_do = may_cham.so_ket_qua(r1, r2, self.ch["thutu"], "vitri", self.ch["saiso"])
            if not bang:
                self.L("SOLUTION_KHONG_TAT_DINH", f"{nhan} solution chạy 2 lần khác kết quả trên {v} ({ly_do})",
                       sol.dong)
                ok = False
            if not r1.dong:
                self.W("SOLUTION_0_DONG", f"{nhan} solution ra 0 dòng trên {v}", sol.dong)
            kq[v] = r1
            self.bao["solution"].setdefault(khoa, {})[v] = {
                "so_dong": len(r1.dong), "cot": r1.cot, "giay": round(r1.giay, 3),
                "dong_dau": [[may_cham.gia_tri_json(x) for x in r] for r in r1.dong[:5]]}
        if ok:
            self.ghi("solution_chay_moi_bien_the", "dat", f"{nhan}: {', '.join(v for v, _ in self.bt)}; chạy 2 lần cùng kết quả")
        self.ket_qua_sol[khoa] = kq
        return kq if ok else None

    def doi_chieu(self, chuan: dict, khoi) -> dict:
        """Chạy khối trên mọi biến thể và so với chuẩn: {v: (bằng, lý do)}"""
        out = {}
        for v, db in self.bt:
            if v not in chuan:
                continue
            r = self.may.chay(db, khoi.sql_chay)
            out[v] = self.may_so(chuan[v], r)
        return out

    # ---------------------------------------------------------------- optimize
    def do(self, khoi, bang_that):
        v0, db0 = next(((v, db) for v, db in self.bt if v == "public"), self.bt[0])
        return self.may.do_ke_hoach(db0, khoi.sql_chay, bang_that)

    def vi_pham(self, do, do_sol) -> list[str]:
        out = []
        for t, n in self.ch["quettoida"].items():
            k = do["quet"].get(t.lower(), 0)
            if k > n:
                out.append(f"{t} quét {k} lần > {n}")
        ns = self.ch["ngansach"]
        if ns is not None and do_sol and "dong_trung_gian" in do_sol:
            gioi_han = ns * max(do_sol["dong_trung_gian"], 1)
            if do["dong_trung_gian"] > gioi_han:
                out.append(f"dòng trung gian {do['dong_trung_gian']} > {ns:g} × {do_sol['dong_trung_gian']}")
        return out

    # ---------------------------------------------------------------- chạy
    def chay(self, schema):
        c, ht = self.c, self.c.hinhthuc
        if not self.kiem_bien_the():
            return
        self.kiem_schema(schema)
        bang_that = set(schema)
        if ht in ("write", "debug", "optimize"):
            g = c.sql.get(c.ma, {})
            sols = g.get("solution", [])
            if len(sols) != 1 or not sols[0].sql_chay or sols[0].loi:
                self.ghi("solution", "bo_qua", "không có solution hợp lệ")
                return
            sol = sols[0]
            chuan = self.kiem_solution(c.ma, sol, f"[{c.ma}]")
            if chuan is None:
                return
            do_sol = None
            if ht == "optimize":
                do_sol = self.do(sol, bang_that)
                opt = {"rang_buoc": {"quettoida": self.ch["quettoida"], "ngansach": self.ch["ngansach"]},
                       "solution": {k: v for k, v in do_sol.items() if k != "ke_hoach"}, "starter": None, "wrong": {}}
                self.bao["optimize"] = opt
                if "loi" in do_sol:
                    self.L("DO_KE_HOACH_LOI", f"không đo được solution: {do_sol['loi']}", sol.dong)
                    do_sol = None
                else:
                    vp = self.vi_pham(do_sol, do_sol)
                    if vp:
                        self.L("SOLUTION_VI_PHAM", f"solution vi phạm ràng buộc: {'; '.join(vp)}", sol.dong)
                    else:
                        self.ghi("solution_thoa_rang_buoc", "dat", json.dumps(do_sol["quet"]) +
                                 f", dòng trung gian {do_sol['dong_trung_gian']}")
                    if do_sol["khong_ro"]:
                        self.W("DO_KE_HOACH_KHONG_RO", f"solution: {do_sol['khong_ro']}", sol.dong)

            # ---- starter
            st = (g.get("starter") or [None])[0]
            if st is not None and st.sql_chay and not st.loi:
                dc = self.doi_chieu(chuan, st)
                self.bao["starter"] = {v: ("khớp" if b else ly) for v, (b, ly) in dc.items()}
                loi_chay = [v for v, (b, ly) in dc.items() if ly.startswith("lỗi khi chạy")]
                if loi_chay:
                    (self.L if ht in ("debug", "optimize") else self.W)(
                        "STARTER_LOI", f"starter không chạy được trên {', '.join(loi_chay)}: "
                                       f"{dc[loi_chay[0]][1]}", st.dong)
                elif ht == "debug":
                    if all(b for b, _ in dc.values()):
                        self.L("STARTER_DEBUG_KHONG_SAI", "debug: starter cho kết quả giống solution trên mọi biến thể",
                               st.dong)
                    else:
                        self.ghi("starter_debug_sai", "dat",
                                 ", ".join(f"{v}: {ly}" for v, (b, ly) in dc.items() if not b))
                elif ht == "optimize":
                    sai = [f"{v}: {ly}" for v, (b, ly) in dc.items() if not b]
                    if sai:
                        self.L("STARTER_OPT_SAI_KET_QUA", f"optimize: starter phải ĐÚNG kết quả ({'; '.join(sai)})",
                               st.dong)
                    else:
                        self.ghi("starter_opt_dung_ket_qua", "dat", "khớp mọi biến thể")
                    if do_sol:
                        do_st = self.do(st, bang_that)
                        self.bao["optimize"]["starter"] = {k: v for k, v in do_st.items() if k != "ke_hoach"}
                        if "loi" in do_st:
                            self.L("DO_KE_HOACH_LOI", f"không đo được starter: {do_st['loi']}", st.dong)
                        else:
                            vp = self.vi_pham(do_st, do_sol)
                            self.bao["optimize"]["starter"]["vi_pham"] = vp
                            if not vp:
                                self.L("STARTER_OPT_KHONG_VI_PHAM",
                                       f"optimize: starter không vi phạm ràng buộc nào ({json.dumps(do_st['quet'])}, "
                                       f"dòng trung gian {do_st['dong_trung_gian']})", st.dong)
                            else:
                                self.ghi("starter_opt_vi_pham", "dat", "; ".join(vp))

            # ---- wrong
            for w in g.get("wrong", []):
                if not w.sql_chay or w.loi:
                    continue
                dc = self.doi_chieu(chuan, w)
                chi = {v: ("qua" if b else f"rot ({ly})") for v, (b, ly) in dc.items()}
                rot = [v for v, (b, _) in dc.items() if not b]
                vp = []
                if ht == "optimize" and not rot and do_sol:
                    do_w = self.do(w, bang_that)
                    if "loi" not in do_w:
                        vp = self.vi_pham(do_w, do_sol)
                        self.bao["optimize"]["wrong"][w.ten] = {k: v for k, v in do_w.items() if k != "ke_hoach"}
                        self.bao["optimize"]["wrong"][w.ten]["vi_pham"] = vp
                self.bao["wrong"][w.ten] = {"bien_the": chi, "rot_o": rot, "vi_pham_rang_buoc": vp}
                if any(ly.startswith("lỗi khi chạy") for _, ly in dc.values()):
                    self.W("WRONG_LOI_CHAY", f"wrong '{w.ten}' báo lỗi MySQL (nên là truy vấn chạy được nhưng sai)",
                           w.dong)
                if not rot and not vp:
                    self.L("WRONG_KHONG_ROT", f"wrong '{w.ten}' không rớt biến thể nào"
                           + (" và không vi phạm ràng buộc" if ht == "optimize" else ""), w.dong)
                else:
                    self.ghi("wrong_rot", "dat", f"{w.ten}: rớt ở {', '.join(rot) or '-'}"
                             + (f"; vi phạm {', '.join(vp)}" if vp else ""))
        elif ht == "case":
            for b in c.buoc:
                if b.hinhthuc != "write":
                    continue
                khoa = f"{c.ma}.{b.ma}"
                g = c.sql.get(khoa, {})
                sols = g.get("solution", [])
                if len(sols) != 1 or not sols[0].sql_chay or sols[0].loi:
                    continue
                chuan = self.kiem_solution(khoa, sols[0], f"[{khoa}]")
                bao_b = {"wrong": {}}
                if chuan is None:
                    self.bao["buoc"][b.ma] = bao_b
                    continue
                for w in g.get("wrong", []):
                    if not w.sql_chay or w.loi:
                        continue
                    dc = self.doi_chieu(chuan, w)
                    rot = [v for v, (bb, _) in dc.items() if not bb]
                    bao_b["wrong"][w.ten] = {"bien_the": {v: ("qua" if bb else f"rot ({ly})") for v, (bb, ly) in dc.items()},
                                             "rot_o": rot}
                    if not rot:
                        self.L("WRONG_KHONG_ROT", f"bước {b.ma}: wrong '{w.ten}' không rớt biến thể nào", w.dong)
                    else:
                        self.ghi("wrong_rot", "dat", f"{b.ma}/{w.ten}: rớt ở {', '.join(rot)}")
                self.bao["buoc"][b.ma] = bao_b

        # ---- tab Nghiệp vụ không lộ kết quả
        gia_tri = []
        for khoa, theo_bt in self.ket_qua_sol.items():
            for v, kq in theo_bt.items():
                if v == "public" or len(theo_bt) == 1:
                    gia_tri += so_trong_ket_qua(kq)
        lo = []
        for s, cach in so_trong_van_ban(c.nghiepvu_text):
            for x in cach:
                if x >= 100 and any(abs(x - y) <= max(self.ch["saiso"], 1e-9) for y in gia_tri):
                    lo.append(s)
                    break
        if lo:
            self.W("NGHIEPVU_LO_SO", f"tab Nghiệp vụ có số trùng kết quả lời giải: {', '.join(sorted(set(lo)))}",
                   c.dong, "cau-hoi.tex")
        elif self.ket_qua_sol:
            self.ghi("nghiepvu_khong_lo_so", "dat")


# ============================================================ chương trình chính
def main(argv=None):
    ap = argparse.ArgumentParser(description="Kiểm gói câu hỏi SQL Leaderboard")
    ap.add_argument("--goi", required=True, help="thư mục gói (4 file) hoặc file .zip")
    ap.add_argument("--ra", required=True, help="thư mục ghi bao-cao-import.json")
    ap.add_argument("--host", default="sqllb-mysql")
    ap.add_argument("--port", type=int, default=3306)
    ap.add_argument("--user", default="sql_runner")
    ap.add_argument("--password", default=None)
    ap.add_argument("--env-file", default=None, help="file .env chứa SQL_RUNNER_PASSWORD (mặc định mysql/.env)")
    ap.add_argument("--cau-hinh", default=None, help="JSON ánh xạ dulieu -> database theo biến thể")
    ap.add_argument("--timeout", type=int, default=180, help="giây tối đa mỗi truy vấn")
    ap.add_argument("--chi-phan-tich", action="store_true", help="chỉ đọc gói, không chạy SQL")
    args = ap.parse_args(argv)

    goi_loi, goi_cb = [], []
    duong = Path(args.goi)
    thu_muc = mo_goi(duong, goi_loi, goi_cb)
    tex = doc_goi.doc_tex(doc_text(thu_muc / "cau-hoi.tex"))
    sqlp = doc_goi.doc_sql(doc_text(thu_muc / "solution.sql"))
    doc_goi.kiem_tinh(tex, sqlp)
    goi_loi += tex["loi"]
    cau_list = tex["cau"]
    if len(cau_list) > CAU_TOI_DA:
        goi_loi.append(loi("GOI_QUA_NHIEU_CAU", f"{len(cau_list)} câu > {CAU_TOI_DA}"))
    if not cau_list:
        goi_loi.append(loi("GOI_KHONG_CO_CAU", "cau-hoi.tex không có \\begin{cauhoi}"))

    cfg_path = Path(args.cau_hinh) if args.cau_hinh else Path(__file__).resolve().parent / "bien-the.json"
    cau_hinh = json.loads(cfg_path.read_text(encoding="utf-8")) if cfg_path.is_file() else {}

    bao_cau = {}
    may = None
    if not args.chi_phan_tich:
        import may_cham
        pw = doc_mat_khau(args)
        if pw is None:
            raise SystemExit("Thiếu mật khẩu: --password, SQLLB_RUNNER_PASSWORD hoặc --env-file")
        may = may_cham.MayCham(args.host, args.port, args.user, pw, args.timeout)
        schema_cache = {}
        for c in cau_list:
            if c.trangthai == "nhap":
                continue
            if any(e["ma_loi"] in ("THIEU_KHOA", "DULIEU_CHUA_KHAI_BAO", "MA_SAI") for e in c.loi) \
                    and not isinstance(c.khoa.get("dulieu"), str):
                continue
            k = KiemCau(may, c, cau_hinh, args)
            db0 = k.bt[0][1] if k.bt else None
            if db0 not in schema_cache:
                schema_cache[db0] = may.schema(db0) if db0 and may.co_db(db0) else {}
            print(f"  ... chạy {c.ma}", flush=True)
            k.chay(schema_cache[db0])
            bao_cau[c.ma] = k
        may.dong()

    # ---------------- báo cáo
    tong_loi = len(goi_loi)
    tong_cb = len(goi_cb)
    ds = []
    for c in cau_list:
        ch = doc_goi.chuan_hoa(c)
        bo_qua = c.trangthai == "nhap"
        k = bao_cau.get(c.ma)
        muc = {
            "ma": c.ma, "dong": c.dong, "tieu_de": c.tieu_de, "hinhthuc": c.hinhthuc, "cap": c.cap,
            "dang": c.khoa.get("dang"), "domain": c.khoa.get("domain"), "dulieu": c.khoa.get("dulieu"),
            "diem": ch["diem"], "trangthai": c.trangthai, "bo_qua": bo_qua,
            "cham": {"bokiemtra": ch["bokiemtra"], "thutu": ch["thutu"], "socot": ch["socot"], "saiso": ch["saiso"],
                     "quettoida": ch["quettoida"], "ngansach": ch["ngansach"]},
            "buoc": [{"ma": b.ma, "hinhthuc": b.hinhthuc, "diem": b.diem, "bang": b.bang,
                      "so_phuongan": len(b.phuongan), "phuongan_dung": [i for i, p in enumerate(b.phuongan) if p["dung"]]}
                     for b in c.buoc],
            "khoi_sql": {kh: {loai: [x.ten or loai for x in v] for loai, v in g.items() if v}
                         for kh, g in getattr(c, "sql", {}).items()},
            "loi": [] if bo_qua else c.loi,
            "canh_bao": c.canh_bao if not bo_qua else c.canh_bao + c.loi,
        }
        loi_tinh = [e for e in c.loi if not e["ma_loi"].startswith(("SOLUTION_", "STARTER_", "WRONG_", "DO_KE_",
                                                                       "BIEN_THE_", "ERD_", "QUETTOIDA_", "BUOC_BANG"))]
        tinh = [{"phep": "kiem_tinh (khoá, phần bắt buộc theo hình thức, khối SQL, khái niệm, bước case)",
                 "ket_qua": "loi" if loi_tinh else "dat", "chi_tiet": f"{len(loi_tinh)} lỗi"}]
        muc["kiem_tra"] = tinh
        if k:
            muc.update({"kiem_tra": tinh + k.bao["kiem_tra"], "solution": k.bao["solution"], "starter": k.bao["starter"],
                        "wrong": k.bao["wrong"], "optimize": k.bao["optimize"], "buoc_wrong": k.bao["buoc"],
                        "bien_the": dict(k.bt)})
        if not bo_qua:
            tong_loi += len(c.loi)
        tong_cb += len(muc["canh_bao"])
        ds.append(muc)

    bao_cao = {
        "goi": str(duong), "thoi_gian": dt.datetime.now().isoformat(timespec="seconds"),
        "may_chu": None if args.chi_phan_tich else f"{args.host}:{args.port} (user {args.user})",
        "chi_phan_tich": args.chi_phan_tich,
        "khai_bao": {k: sorted(v) for k, v in tex["khai_bao"].items()},
        "so_khoi_sql": len(sqlp["khoi"]),
        "loi_goi": goi_loi, "canh_bao_goi": goi_cb,
        "cau": ds,
        "tong": {"so_cau": len(cau_list), "so_cau_bo_qua": sum(1 for c in ds if c["bo_qua"]),
                 "so_loi": tong_loi, "so_canh_bao": tong_cb},
    }
    ra = Path(args.ra)
    ra.mkdir(parents=True, exist_ok=True)
    (ra / "bao-cao-import.json").write_text(json.dumps(bao_cao, ensure_ascii=False, indent=2, default=str),
                                            encoding="utf-8")

    # ---------------- tóm tắt
    print(f"Gói: {duong}  ·  {len(cau_list)} câu  ·  {len(sqlp['khoi'])} khối SQL"
          + ("  ·  chỉ phân tích (không chạy SQL)" if args.chi_phan_tich else ""))
    for e in goi_loi:
        print(f"  [LOI goi] {e['ma_loi']}: {e['thong_diep']} ({e['file']}{':' + str(e['dong']) if e['dong'] else ''})")
    for e in goi_cb:
        print(f"  [canh bao goi] {e['ma_loi']}: {e['thong_diep']}")
    for m in ds:
        nhan = "BO QUA (nhap)" if m["bo_qua"] else ("OK " if not m["loi"] else "LOI")
        print(f"{nhan:4} {m['ma']:<40} {str(m['hinhthuc']):<9} {str(m['cap']):<7} "
              f"{len(m['loi'])} loi, {len(m['canh_bao'])} canh bao")
        for e in m["loi"]:
            print(f"     - LOI {e['ma_loi']}: {e['thong_diep']} ({e['file']}{':' + str(e['dong']) if e['dong'] else ''})")
        for e in m["canh_bao"]:
            print(f"     - canh bao {e['ma_loi']}: {e['thong_diep']}")
        if m.get("optimize") and m["optimize"].get("starter"):
            o = m["optimize"]
            print(f"     · do: solution {o['solution'].get('quet')} / {o['solution'].get('dong_trung_gian')} dong;"
                  f" starter {o['starter'].get('quet')} / {o['starter'].get('dong_trung_gian')} dong")
        for ten, w in (m.get("wrong") or {}).items():
            print(f"     · wrong {ten}: rot o {', '.join(w['rot_o']) or '-'}"
                  + (f"; vi pham {', '.join(w['vi_pham_rang_buoc'])}" if w.get("vi_pham_rang_buoc") else ""))
        for mb, bw in (m.get("buoc_wrong") or {}).items():
            for ten, w in bw.get("wrong", {}).items():
                print(f"     · {mb} wrong {ten}: rot o {', '.join(w['rot_o']) or '-'}")
    print(f"Bao cao: {ra / 'bao-cao-import.json'}")
    print(f"KIEM TRA: {tong_loi} loi")
    return 0 if tong_loi == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
