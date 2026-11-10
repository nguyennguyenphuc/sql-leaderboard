"""doc_goi.py: đọc gói câu hỏi SQL (cau-hoi.tex + solution.sql), chuẩn aio-sql-cauhoi v0.4.

Chỉ dùng thư viện chuẩn của Python. Hàm chính:
    doc_tex(text)  -> dict(khai_bao=..., cau=[...], loi=[...])
    doc_sql(text)  -> dict(khoi=[...], loi=[...])
    kiem_tinh(goi_tex, goi_sql) -> gắn lỗi/cảnh báo tĩnh (không cần MySQL) vào từng câu
Mỗi lỗi/cảnh báo là dict(ma_loi, thong_diep, file, dong).
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field

MA_RE = re.compile(r"^[a-z0-9-]{3,80}$")
DANG_HOP_LE = {f"{c}{i}" for c, n in (("A", 4), ("B", 4), ("C", 4), ("D", 3), ("E", 3)) for i in range(1, n + 1)}
HINHTHUC = {"write", "debug", "optimize", "case"}
CAP_DIEM = {"basic": 10, "easy": 20, "medium": 30, "hard": 50}
TRANGTHAI = {"nhap", "review", "duyet"}
KHOA_CAUHOI = {"ma", "dulieu", "domain", "hinhthuc", "cap", "dang", "diem", "kynang", "bay", "tacgia",
               "trangthai", "bokiemtra", "thutu", "socot", "saiso", "quettoida", "ngansach"}
KHOA_BUOC = {"ma", "diem", "hinhthuc", "bang"}
# lệnh được phép trong thân câu hỏi (cấu trúc + định dạng chữ cho phép theo CHOT mục 4)
LENH_CHO_PHEP = {"tieude", "boicanh", "begin", "end", "item", "code", "textbf", "emph", "erdbang", "erdnoi",
                 "erdkhoa", "erdghichu", "quytrinh", "khainiem", "luuy", "goiy", "ghichuthietke", "phuongan",
                 "nguonsolieu"}


def loi(ma_loi: str, thong_diep: str, file: str = "cau-hoi.tex", dong: int | None = None) -> dict:
    return {"ma_loi": ma_loi, "thong_diep": thong_diep, "file": file, "dong": dong}


# ============================================================ tiện ích đọc LaTeX
def bo_chu_thich(text: str) -> str:
    """Xoá chú thích % (không phải \\%) tới cuối dòng, giữ nguyên số dòng và vị trí ký tự còn lại."""
    out = []
    for line in text.split("\n"):
        i, cut = 0, None
        while i < len(line):
            ch = line[i]
            if ch == "\\":
                i += 2
                continue
            if ch == "%":
                cut = i
                break
            i += 1
        out.append(line if cut is None else line[:cut] + " " * (len(line) - cut))
    return "\n".join(out)


def doc_ngoac(text: str, i: int, mo: str = "{", dong: str = "}") -> tuple[str, int] | None:
    """text[i] phải là `mo` (sau khi bỏ khoảng trắng). Trả (nội dung, vị trí sau ngoặc đóng).
    Với [ ]: ngoặc vuông bên trong { } không tính."""
    j = bo_trang(text, i)
    if j >= len(text) or text[j] != mo:
        return None
    depth_b = 0  # độ sâu { }
    depth = 0
    k = j
    while k < len(text):
        ch = text[k]
        if ch == "\\":
            k += 2
            continue
        if mo == "{":
            if ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
                if depth == 0:
                    return text[j + 1:k], k + 1
        else:
            if ch == "{":
                depth_b += 1
            elif ch == "}":
                depth_b -= 1
            elif depth_b == 0 and ch == mo:
                depth += 1
            elif depth_b == 0 and ch == dong:
                depth -= 1
                if depth == 0:
                    return text[j + 1:k], k + 1
        k += 1
    return None


def bo_trang(text: str, i: int) -> int:
    while i < len(text) and text[i] in " \t\r\n":
        i += 1
    return i


def bo_ngoac_ngoai(v: str) -> str:
    v = v.strip()
    if len(v) >= 2 and v[0] == "{" and v[-1] == "}":
        r = doc_ngoac(v, 0)
        if r and r[1] == len(v):
            return r[0].strip()
    return v


def tach_phay(s: str) -> list[str]:
    """Tách theo dấu phẩy ở mức ngoài cùng (không nằm trong { })."""
    parts, depth, cur = [], 0, []
    i = 0
    while i < len(s):
        ch = s[i]
        if ch == "\\" and i + 1 < len(s):
            cur.append(s[i:i + 2])
            i += 2
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
        if ch == "," and depth == 0:
            parts.append("".join(cur))
            cur = []
        else:
            cur.append(ch)
        i += 1
    parts.append("".join(cur))
    return [p.strip() for p in parts if p.strip()]


def doc_khoa(s: str) -> tuple[dict, list[str]]:
    """'ma=x, kynang={A, B}, canhbao' -> ({'ma': 'x', 'kynang': 'A, B', 'canhbao': True}, [thứ tự khoá])"""
    d, order = {}, []
    for p in tach_phay(s):
        if "=" in p:
            k, v = p.split("=", 1)
            k = k.strip()
            d[k] = bo_ngoac_ngoai(v)
        else:
            k = p.strip()
            d[k] = True
        order.append(k)
    return d, order


def so_dong(text: str, pos: int) -> int:
    return text.count("\n", 0, pos) + 1


def tim_lenh(text: str, ten: str, start: int = 0, end: int | None = None):
    """Lặp các lần xuất hiện \\ten (không phải tiền tố của lệnh dài hơn). Trả (vị trí, sao)."""
    end = len(text) if end is None else end
    pat = re.compile(r"\\" + re.escape(ten) + r"(?![A-Za-z@])(\*?)")
    for m in pat.finditer(text, start, end):
        yield m.start(), m.end(), m.group(1) == "*"


def tim_moi_truong(text: str, ten: str, start: int = 0, end: int | None = None):
    """Lặp các môi trường \\begin{ten}...\\end{ten} (không lồng cùng tên). Trả (b, sau_begin, dau_end, e)."""
    end = len(text) if end is None else end
    b_pat = re.compile(r"\\begin\s*\{" + re.escape(ten) + r"\}")
    e_pat = re.compile(r"\\end\s*\{" + re.escape(ten) + r"\}")
    pos = start
    while True:
        mb = b_pat.search(text, pos, end)
        if not mb:
            return
        me = e_pat.search(text, mb.end(), end)
        if not me:
            yield mb.start(), mb.end(), None, None
            return
        yield mb.start(), mb.end(), me.start(), me.end()
        pos = me.end()


def che(text: str, a: int, b: int) -> str:
    """Thay text[a:b] bằng khoảng trắng (giữ xuống dòng) để quét mức ngoài."""
    seg = "".join("\n" if c == "\n" else " " for c in text[a:b])
    return text[:a] + seg + text[b:]


def van_ban_thuan(s: str) -> str:
    """Rút chữ thuần từ LaTeX để dò số (bỏ lệnh, giữ nội dung trong ngoặc)."""
    s = re.sub(r"\\([%_&#$])", r"\1", s)
    s = re.sub(r"\\[A-Za-z@]+\*?", " ", s)
    s = s.replace("{", " ").replace("}", " ").replace("[", " ").replace("]", " ")
    return re.sub(r"\s+", " ", s).strip()


# ============================================================ cau-hoi.tex
@dataclass
class Buoc:
    ma: str
    dong: int
    khoa: dict
    tieu_de: str
    hinhthuc: str | None
    diem: float | None
    bang: list[str]
    co_yeucau: bool
    phuongan: list[dict]          # [{dung: bool, noi_dung, dong}]
    co_luachon: bool


@dataclass
class Cau:
    ma: str
    dong: int
    dong_cuoi: int
    khoa: dict
    thu_tu_khoa: list[str]
    tieu_de: str | None
    co: dict = field(default_factory=dict)       # yeucau, rangbuoc, erd, nghiepvu, luachon (mức ngoài)
    erd: dict = field(default_factory=dict)      # bang -> [cột], noi: [...]
    nghiepvu_text: str = ""
    so_quytrinh: int = 0
    khainiem: list[tuple[str, int]] = field(default_factory=list)
    so_goiy: int = 0
    buoc: list[Buoc] = field(default_factory=list)
    lenh_la: list[tuple[str, int]] = field(default_factory=list)
    loi: list[dict] = field(default_factory=list)
    canh_bao: list[dict] = field(default_factory=list)

    # các giá trị đã chuẩn hoá
    @property
    def hinhthuc(self):
        return self.khoa.get("hinhthuc")

    @property
    def cap(self):
        return self.khoa.get("cap")

    @property
    def trangthai(self):
        return self.khoa.get("trangthai", "nhap")


def doc_cot_erd(spec: str) -> list[str]:
    cols = []
    for p in tach_phay(spec):
        m = re.match(r"\s*`?([A-Za-z_][A-Za-z0-9_]*)", p)
        if m:
            cols.append(m.group(1))
    return cols


def doc_erd(body: str, offset_text: str, base: int) -> dict:
    erd = {"bang": {}, "noi": [], "khoa": False}
    for s, e, _ in tim_lenh(body, "erdbang"):
        k = e
        opt = None
        j = bo_trang(body, k)
        if j < len(body) and body[j] == "[":
            r = doc_ngoac(body, j, "[", "]")
            if r:
                opt, k = r
        a = doc_ngoac(body, k)
        if not a:
            continue
        ten, k = a
        b = doc_ngoac(body, k)
        if not b:
            continue
        _, k = b
        c = doc_ngoac(body, k)
        if not c:
            continue
        erd["bang"][ten.strip()] = {"cot": doc_cot_erd(c[0]), "dong": so_dong(offset_text, base + s),
                                    "trangthai": (opt or "").strip()}
    for s, e, _ in tim_lenh(body, "erdnoi"):
        k = e
        j = bo_trang(body, k)
        if j < len(body) and body[j] == "[":
            r = doc_ngoac(body, j, "[", "]")
            if r:
                k = r[1]
        a = doc_ngoac(body, k)
        b = doc_ngoac(body, a[1]) if a else None
        if a and b:
            erd["noi"].append({"tu": a[0].strip(), "toi": b[0].strip(), "dong": so_dong(offset_text, base + s)})
    erd["khoa"] = any(True for _ in tim_lenh(body, "erdkhoa"))
    return erd


def doc_tex(text: str) -> dict:
    raw = text
    t = bo_chu_thich(text)
    res = {"khai_bao": {"dulieu": {}, "domain": {}, "khainiem": {}}, "cau": [], "loi": []}

    # ---------------- khai báo dùng chung
    for ten, so_tham in (("khaibaodulieu", 3), ("khaibaodomain", 3), ("khaibaokhainiem", 5)):
        kho = res["khai_bao"][ten.replace("khaibao", "")]
        for s, e, _ in tim_lenh(t, ten):
            args, k = [], e
            for _ in range(so_tham):
                r = doc_ngoac(t, k)
                if not r:
                    break
                args.append(r[0])
                k = r[1]
            d = so_dong(t, s)
            if len(args) != so_tham:
                res["loi"].append(loi("KHAI_BAO_SAI", f"\\{ten} cần {so_tham} tham số {{...}}", dong=d))
                continue
            ma = args[0].strip()
            if ma in kho:
                res["loi"].append(loi("KHAI_BAO_TRUNG", f"\\{ten}{{{ma}}} khai báo hai lần", dong=d))
            kho[ma] = {"ten": args[1].strip(), "tham_so": [a.strip() for a in args], "dong": d}

    # ---------------- các câu
    for b0, b1, e0, e1 in tim_moi_truong(t, "cauhoi"):
        d0 = so_dong(t, b0)
        if e0 is None:
            res["loi"].append(loi("THIEU_END", "\\begin{cauhoi} không có \\end{cauhoi}", dong=d0))
            break
        khoa, order, k = {}, [], b1
        j = bo_trang(t, k)
        if j < len(t) and t[j] == "[":
            r = doc_ngoac(t, j, "[", "]")
            if r:
                khoa, order = doc_khoa(r[0])
                k = r[1]
        body_start = k
        body = t[body_start:e0]
        cau = Cau(ma=str(khoa.get("ma", "")), dong=d0, dong_cuoi=so_dong(t, e0), khoa=khoa,
                  thu_tu_khoa=order, tieu_de=None)
        doc_than_cau(cau, body, t, body_start)
        res["cau"].append(cau)

    # ---------------- văn bản ngoài cauhoi (sau \begin{document}) có lệnh lạ thì bỏ qua (trang bìa)
    res["raw_dong"] = raw.count("\n") + 1
    return res


def gach_duoi_tran(body: str) -> list[int]:
    """Vị trí các dấu '_' không escape, nằm ngoài chỗ .sty đã \\detokenize (\\code, tham số \\erdbang, \\erdnoi,
    khoá của buoc)."""
    m = body
    for ten, so_arg in (("code", 1), ("erdbang", 3), ("erdnoi", 2)):
        for s, e, _ in tim_lenh(body, ten):
            k = e
            j = bo_trang(body, k)
            if ten == "erdbang" and j < len(body) and body[j] == "[":
                r = doc_ngoac(body, j, "[", "]")
                k = r[1] if r else k
            if ten == "erdnoi" and j < len(body) and body[j] == "[":
                r = doc_ngoac(body, j, "[", "]")
                k = r[1] if r else k          # khoá tren=, duoi= vẫn được kiểm
            a0 = k
            for _ in range(so_arg):
                r = doc_ngoac(body, k)
                if not r:
                    break
                k = r[1]
            m = che(m, a0 if ten != "code" else s, k)
    for b0, b1, _, _ in tim_moi_truong(body, "buoc"):
        j = bo_trang(body, b1)
        if j < len(body) and body[j] == "[":
            r = doc_ngoac(body, j, "[", "]")
            if r:
                m = che(m, j, r[1])
    return [x.start() for x in re.finditer(r"(?<!\\)_", m)]


def doc_than_cau(cau: Cau, body: str, t: str, base: int) -> None:
    def dong(pos):
        return so_dong(t, base + pos)

    # 1) tách các bước (case) trước, che đi để quét mức ngoài
    outer = body
    for bb0, bb1, be0, be1 in tim_moi_truong(body, "buoc"):
        if be0 is None:
            cau.loi.append(loi("THIEU_END", "\\begin{buoc} không có \\end{buoc}", dong=dong(bb0)))
            break
        k = bb1
        bkhoa = {}
        j = bo_trang(body, k)
        if j < len(body) and body[j] == "[":
            r = doc_ngoac(body, j, "[", "]")
            if r:
                bkhoa, _ = doc_khoa(r[0])
                k = r[1]
        tt = doc_ngoac(body, k)
        tieu_de = tt[0].strip() if tt else ""
        if tt:
            k = tt[1]
        bbody = body[k:be0]
        pas = []
        co_lc = False
        for l0, l1, le0, le1 in tim_moi_truong(bbody, "luachon"):
            co_lc = True
            if le0 is None:
                continue
            for s, e, sao in tim_lenh(bbody, "phuongan", l1, le0):
                a = doc_ngoac(bbody, e)
                pas.append({"dung": sao, "noi_dung": a[0].strip() if a else "", "dong": dong(k + s)})
        diem = None
        if "diem" in bkhoa:
            try:
                diem = float(bkhoa["diem"])
            except (TypeError, ValueError):
                cau.loi.append(loi("GIA_TRI_SAI", f"bước {bkhoa.get('ma')}: diem='{bkhoa['diem']}' không phải số",
                                   dong=dong(bb0)))
        for kk in bkhoa:
            if kk not in KHOA_BUOC:
                cau.canh_bao.append(loi("KHOA_LA", f"bước {bkhoa.get('ma')}: khoá lạ '{kk}'", dong=dong(bb0)))
        bang = [x.strip() for x in tach_phay(str(bkhoa.get("bang", "")))] if bkhoa.get("bang") not in (None, True) else []
        cau.buoc.append(Buoc(ma=str(bkhoa.get("ma", "")), dong=dong(bb0), khoa=bkhoa, tieu_de=tieu_de,
                             hinhthuc=bkhoa.get("hinhthuc") if isinstance(bkhoa.get("hinhthuc"), str) else None,
                             diem=diem, bang=bang,
                             co_yeucau=any(True for _ in tim_moi_truong(bbody, "yeucau")),
                             phuongan=pas, co_luachon=co_lc))
        outer = che(outer, bb0, be1)

    # 2) mức ngoài
    for s, e, _ in tim_lenh(outer, "tieude"):
        a = doc_ngoac(outer, e)
        if a:
            cau.tieu_de = a[0].strip()
            break
    for ten in ("yeucau", "rangbuoc", "erd", "nghiepvu", "luachon"):
        cau.co[ten] = False
        for x0, x1, xe0, xe1 in tim_moi_truong(outer, ten):
            cau.co[ten] = True
            if xe0 is None:
                cau.loi.append(loi("THIEU_END", f"\\begin{{{ten}}} không có \\end{{{ten}}}", dong=dong(x0)))
                continue
            if ten == "erd":
                cau.erd = doc_erd(outer[x1:xe0], t, base + x1)
            if ten == "nghiepvu":
                cau.nghiepvu_text += " " + outer[x1:xe0]
                cau.so_quytrinh += sum(1 for _ in tim_lenh(outer, "quytrinh", x1, xe0))
    cau.so_goiy = sum(1 for _ in tim_lenh(outer, "goiy"))

    # 3) \khainiem ở mọi nơi trong câu
    for s, e, _ in tim_lenh(body, "khainiem"):
        a = doc_ngoac(body, e)
        if a:
            cau.khainiem.append((a[0].strip(), dong(s)))

    # 4) lệnh lạ
    for m in re.finditer(r"\\([A-Za-z@]+)", body):
        if m.group(1) not in LENH_CHO_PHEP:
            cau.lenh_la.append((m.group(1), dong(m.start())))

    # 5) dấu '_' trần ngoài \code{} làm XeLaTeX báo "Missing $ inserted" (ví dụ tren={a.b_c = ...} của \erdnoi)
    for d in sorted({dong(v) for v in gach_duoi_tran(body)}):
        cau.canh_bao.append(loi("LATEX_GACH_DUOI", f"dòng {d}: dấu '_' nằm ngoài \\code{{}} (viết \\code{{...}} hoặc \\_), "
                                "XeLaTeX sẽ báo lỗi Missing $", dong=d))


# ============================================================ solution.sql
MARKER_RE = re.compile(
    r"^--\s*\[([a-z0-9\-]+)(?:\.([a-z0-9]+))?\]\s*(solution|starter|wrong)\s*:?\s*([A-Za-z0-9_\-]*)\s*$")
MARKER_GAN_RE = re.compile(r"^--\s*\[")  # trông như dòng đánh dấu

TU_KHOA_CAM = {"UPDATE", "DELETE", "CREATE", "ALTER", "DROP", "TRUNCATE", "RENAME", "GRANT", "REVOKE",
               "LOAD", "CALL", "HANDLER", "LOCK", "UNLOCK", "INTO", "OUTFILE", "DUMPFILE", "MERGE", "PREPARE",
               "EXECUTE", "DEALLOCATE", "FLUSH", "KILL", "SHUTDOWN", "INSTALL", "UNINSTALL", "OPTIMIZE",
               "ANALYZE", "REPAIR", "CHECKSUM", "SAVEPOINT", "COMMIT", "ROLLBACK"}
HAM_CAM = {"SLEEP", "BENCHMARK", "GET_LOCK", "LOAD_FILE", "RELEASE_LOCK", "RELEASE_ALL_LOCKS"}


@dataclass
class KhoiSQL:
    ma: str           # mã câu
    buoc: str | None  # mã bước (case)
    loai: str         # solution | starter | wrong
    ten: str          # tên lỗi (wrong)
    dong: int         # dòng đánh dấu
    sql: str          # nguyên văn (không gồm dòng đánh dấu)
    sql_chay: str = ""  # đã bỏ ';' cuối, sẵn để chạy
    loi: list = field(default_factory=list)

    @property
    def khoa(self):
        return f"{self.ma}.{self.buoc}" if self.buoc else self.ma


def tach_token(sql: str):
    """Lặp (loai, giá trị, vị trí) với loai ∈ {word, punct, string, ident}; bỏ chú thích."""
    i, n = 0, len(sql)
    while i < n:
        ch = sql[i]
        if ch in " \t\r\n":
            i += 1
        elif sql.startswith("--", i) and (i + 2 >= n or sql[i + 2] in " \t\r\n"):
            j = sql.find("\n", i)
            i = n if j < 0 else j + 1
        elif ch == "#":
            j = sql.find("\n", i)
            i = n if j < 0 else j + 1
        elif sql.startswith("/*", i):
            j = sql.find("*/", i + 2)
            i = n if j < 0 else j + 2
        elif ch in "'\"`":
            q = ch
            j = i + 1
            while j < n:
                if sql[j] == "\\" and q != "`":
                    j += 2
                    continue
                if sql[j] == q:
                    if j + 1 < n and sql[j + 1] == q:
                        j += 2
                        continue
                    break
                j += 1
            yield ("ident" if q == "`" else "string"), sql[i:j + 1], i
            i = j + 1
        elif ch.isalpha() or ch == "_" or ch == "@" or ch == "$":
            j = i
            while j < n and (sql[j].isalnum() or sql[j] in "_$@"):
                j += 1
            yield "word", sql[i:j], i
            i = j
        elif ch.isdigit():
            j = i
            while j < n and (sql[j].isalnum() or sql[j] == "."):
                j += 1
            yield "number", sql[i:j], i
            i = j
        else:
            yield "punct", ch, i
            i += 1


def kiem_cau_lenh(sql: str) -> tuple[str | None, list[str]]:
    """Trả (sql_chay, [lỗi]) cho một khối: đúng một câu SELECT/WITH, kết thúc ';', không có từ khoá ghi."""
    errs = []
    toks = list(tach_token(sql))
    if not toks:
        return None, ["khối rỗng"]
    first = next((v for k, v, _ in toks if k == "word" or (k == "punct" and v != "(")), None)
    if first is None or first.upper() not in ("SELECT", "WITH"):
        errs.append(f"truy vấn phải bắt đầu bằng SELECT hoặc WITH (gặp '{first}')")
    semis = [p for k, v, p in toks if k == "punct" and v == ";"]
    if not semis:
        errs.append("thiếu ';' kết thúc")
    elif len(semis) > 1 or toks[-1][1] != ";":
        errs.append("mỗi khối chỉ được một truy vấn, kết thúc bằng ';' (thấy nhiều câu lệnh hoặc chữ sau ';')")
    for idx, (k, v, p) in enumerate(toks):
        if k != "word":
            continue
        u = v.upper()
        nxt = toks[idx + 1][1] if idx + 1 < len(toks) else ""
        prev = toks[idx - 1][1] if idx > 0 else ""
        if prev == ".":
            continue  # tên cột như t.update
        if u in TU_KHOA_CAM:
            errs.append(f"từ khoá không cho phép: {u}")
        elif u in ("INSERT", "REPLACE") and nxt != "(":
            errs.append(f"từ khoá không cho phép: {u}")
        elif u in HAM_CAM and nxt == "(":
            errs.append(f"hàm không cho phép: {u}()")
        elif u.startswith("@"):
            errs.append(f"không dùng biến người dùng/hệ thống: {v}")
    sql_chay = None
    if semis:
        sql_chay = sql[:semis[-1]].rstrip()
    return sql_chay, sorted(set(errs), key=errs.index)


def doc_sql(text: str) -> dict:
    res = {"khoi": [], "loi": []}
    lines = text.split("\n")
    cur = None
    buf: list[str] = []

    def dong_khoi():
        if cur is None:
            return
        while buf and not buf[-1].strip():
            buf.pop()
        cur.sql = "\n".join(buf)
        res["khoi"].append(cur)

    for no, line in enumerate(lines, 1):
        s = line.rstrip("\r")
        m = MARKER_RE.match(s.strip())
        if m:
            dong_khoi()
            cur = KhoiSQL(ma=m.group(1), buoc=m.group(2), loai=m.group(3), ten=m.group(4), dong=no, sql="")
            buf = []
            if cur.loai == "wrong" and not cur.ten:
                cur.loi.append(loi("SQL_DANH_DAU_SAI", "dòng 'wrong' cần tên lỗi: -- [ma] wrong: ten_loi",
                                   "solution.sql", no))
            if cur.loai != "wrong" and cur.ten:
                cur.loi.append(loi("SQL_DANH_DAU_SAI", f"dòng '{cur.loai}' không có tên lỗi ('{cur.ten}')",
                                   "solution.sql", no))
            continue
        if MARKER_GAN_RE.match(s.strip()):
            res["loi"].append(loi("SQL_DANH_DAU_SAI", f"dòng đánh dấu sai cú pháp: {s.strip()[:80]}",
                                  "solution.sql", no))
        if cur is not None:
            buf.append(s)
    dong_khoi()

    for k in res["khoi"]:
        sql_chay, errs = kiem_cau_lenh(k.sql)
        k.sql_chay = sql_chay or ""
        for e in errs:
            k.loi.append(loi("SQL_KHONG_HOP_LE", f"[{k.khoa}] {k.loai}{(': ' + k.ten) if k.ten else ''}: {e}",
                             "solution.sql", k.dong))
    return res


# ============================================================ kiểm tĩnh
def so_thuc(v) -> float | None:
    try:
        return float(str(v).strip())
    except (TypeError, ValueError):
        return None


def doc_quettoida(v: str) -> tuple[dict, list[str]]:
    d, errs = {}, []
    for p in tach_phay(bo_ngoac_ngoai(str(v))):
        if "=" not in p:
            errs.append(f"quettoida: '{p}' phải có dạng bang=so")
            continue
        t, n = p.split("=", 1)
        try:
            n = int(n.strip())
            if n < 0:
                raise ValueError
            d[t.strip()] = n
        except ValueError:
            errs.append(f"quettoida: số lần quét '{n.strip()}' của {t.strip()} không phải số nguyên ≥ 0")
    if not d and not errs:
        errs.append("quettoida rỗng")
    return d, errs


def chuan_hoa(cau: Cau) -> dict:
    """Giá trị chấm đã chuẩn hoá (mặc định theo .sty / CHOT)."""
    k = cau.khoa
    bkt = k.get("bokiemtra", "public")
    return {
        "bokiemtra": [x.strip() for x in tach_phay(str(bkt))] if bkt is not True else ["public"],
        "thutu": k.get("thutu", "co"),
        "socot": k.get("socot", "vitri"),
        "saiso": so_thuc(k.get("saiso", 0.01)) if so_thuc(k.get("saiso", 0.01)) is not None else 0.01,
        "quettoida": doc_quettoida(k["quettoida"])[0] if "quettoida" in k else {},
        "ngansach": so_thuc(k.get("ngansach")) if "ngansach" in k else None,
        "diem": so_thuc(k["diem"]) if "diem" in k else CAP_DIEM.get(k.get("cap"), None),
    }


def kiem_tinh(goi_tex: dict, goi_sql: dict) -> None:
    kb = goi_tex["khai_bao"]
    cau_list: list[Cau] = goi_tex["cau"]
    theo_ma: dict[str, Cau] = {}
    for c in cau_list:
        k = c.khoa
        L, W = c.loi, c.canh_bao
        # ---- khoá chung
        for kk in c.thu_tu_khoa:
            if kk not in KHOA_CAUHOI:
                W.append(loi("KHOA_LA", f"khoá lạ '{kk}'", dong=c.dong))
        dup = {x for x in c.thu_tu_khoa if c.thu_tu_khoa.count(x) > 1}
        for x in dup:
            L.append(loi("KHOA_TRUNG", f"khoá '{x}' ghi hai lần", dong=c.dong))
        for bat_buoc in ("ma", "dulieu", "domain", "hinhthuc", "cap"):
            if bat_buoc not in k or k[bat_buoc] in ("", True):
                L.append(loi("THIEU_KHOA", f"thiếu khoá bắt buộc '{bat_buoc}'", dong=c.dong))
        if c.ma and not MA_RE.match(c.ma):
            L.append(loi("MA_SAI", f"ma '{c.ma}' không khớp ^[a-z0-9-]{{3,80}}$", dong=c.dong))
        if c.ma in theo_ma:
            L.append(loi("MA_TRUNG", f"ma '{c.ma}' trùng với câu ở dòng {theo_ma[c.ma].dong}", dong=c.dong))
        elif c.ma:
            theo_ma[c.ma] = c
        if isinstance(k.get("dulieu"), str) and k["dulieu"] not in kb["dulieu"]:
            L.append(loi("DULIEU_CHUA_KHAI_BAO", f"dulieu '{k['dulieu']}' chưa khai báo bằng \\khaibaodulieu",
                         dong=c.dong))
        if isinstance(k.get("domain"), str) and k["domain"] not in kb["domain"]:
            L.append(loi("DOMAIN_CHUA_KHAI_BAO", f"domain '{k['domain']}' chưa khai báo bằng \\khaibaodomain",
                         dong=c.dong))
        ht = k.get("hinhthuc")
        if isinstance(ht, str) and ht not in HINHTHUC:
            L.append(loi("GIA_TRI_SAI", f"hinhthuc '{ht}' không hợp lệ (write|debug|optimize|case)", dong=c.dong))
        if isinstance(k.get("cap"), str) and k["cap"] not in CAP_DIEM:
            L.append(loi("GIA_TRI_SAI", f"cap '{k['cap']}' không hợp lệ (basic|easy|medium|hard)", dong=c.dong))
        if "dang" in k and k["dang"] not in DANG_HOP_LE:
            L.append(loi("GIA_TRI_SAI", f"dang '{k['dang']}' không hợp lệ (A1..E3)", dong=c.dong))
        if "trangthai" in k and k["trangthai"] not in TRANGTHAI:
            L.append(loi("GIA_TRI_SAI", f"trangthai '{k['trangthai']}' không hợp lệ (nhap|review)", dong=c.dong))
        if "thutu" in k and k["thutu"] not in ("co", "khong"):
            L.append(loi("GIA_TRI_SAI", f"thutu '{k['thutu']}' không hợp lệ (co|khong)", dong=c.dong))
        if "socot" in k and k["socot"] not in ("vitri", "ten"):
            L.append(loi("GIA_TRI_SAI", f"socot '{k['socot']}' không hợp lệ (vitri|ten)", dong=c.dong))
        if "saiso" in k and (so_thuc(k["saiso"]) is None or so_thuc(k["saiso"]) < 0):
            L.append(loi("GIA_TRI_SAI", f"saiso '{k['saiso']}' phải là số ≥ 0", dong=c.dong))
        if "diem" in k and (so_thuc(k["diem"]) is None or so_thuc(k["diem"]) <= 0):
            L.append(loi("GIA_TRI_SAI", f"diem '{k['diem']}' phải là số > 0", dong=c.dong))
        if "bokiemtra" in k:
            vs = [x.strip() for x in tach_phay(str(k["bokiemtra"]))]
            for v in vs:
                if not re.match(r"^(public|hidden-[1-9][0-9]*)$", v):
                    L.append(loi("GIA_TRI_SAI", f"bokiemtra: biến thể '{v}' không hợp lệ (public|hidden-N)",
                                 dong=c.dong))
            if "public" not in vs:
                W.append(loi("BOKIEMTRA_THIEU_PUBLIC", "bokiemtra không có 'public'", dong=c.dong))
        if "quettoida" in k:
            _, errs = doc_quettoida(k["quettoida"])
            for e in errs:
                L.append(loi("GIA_TRI_SAI", e, dong=c.dong))
        if "ngansach" in k and (so_thuc(k["ngansach"]) is None or so_thuc(k["ngansach"]) < 1):
            L.append(loi("GIA_TRI_SAI", f"ngansach '{k['ngansach']}' phải là số ≥ 1", dong=c.dong))
        if not c.tieu_de:
            L.append(loi("THIEU_PHAN", "thiếu \\tieude{...}", dong=c.dong))

        # ---- bắt buộc theo hình thức (CHOT mục 4)
        if ht in ("write", "debug", "optimize"):
            if "dang" not in k:
                L.append(loi("THIEU_KHOA", f"{ht}: thiếu khoá bắt buộc 'dang'", dong=c.dong))
            for phan in ("yeucau", "erd", "nghiepvu"):
                if not c.co.get(phan):
                    L.append(loi("THIEU_PHAN", f"{ht}: thiếu \\begin{{{phan}}}", dong=c.dong))
            if c.buoc:
                L.append(loi("THUA_PHAN", f"{ht}: không dùng \\begin{{buoc}} (chỉ case)", dong=c.dong))
        if ht == "optimize":
            if not c.co.get("rangbuoc"):
                L.append(loi("THIEU_PHAN", "optimize: thiếu \\begin{rangbuoc}", dong=c.dong))
            if "quettoida" not in k and "ngansach" not in k:
                L.append(loi("THIEU_KHOA", "optimize: cần ít nhất một khoá quettoida hoặc ngansach", dong=c.dong))
        elif ("quettoida" in k or "ngansach" in k) and ht in HINHTHUC:
            W.append(loi("KHOA_THUA", f"{ht}: quettoida/ngansach chỉ dùng cho optimize", dong=c.dong))
        if ht == "case":
            for phan in ("erd", "nghiepvu"):
                if not c.co.get(phan):
                    L.append(loi("THIEU_PHAN", f"case: thiếu \\begin{{{phan}}}", dong=c.dong))
            if len(c.buoc) < 2:
                L.append(loi("THIEU_PHAN", f"case: cần ít nhất 2 \\begin{{buoc}} (có {len(c.buoc)})", dong=c.dong))
            ma_buoc = set()
            tong = 0.0
            for b in c.buoc:
                if not b.ma:
                    L.append(loi("THIEU_KHOA", "bước thiếu khoá 'ma'", dong=b.dong))
                elif not re.match(r"^[a-z0-9]+$", b.ma):
                    L.append(loi("MA_SAI", f"mã bước '{b.ma}' chỉ gồm chữ thường và số", dong=b.dong))
                elif b.ma in ma_buoc:
                    L.append(loi("MA_TRUNG", f"mã bước '{b.ma}' trùng", dong=b.dong))
                ma_buoc.add(b.ma)
                if b.diem is None:
                    L.append(loi("THIEU_KHOA", f"bước {b.ma}: thiếu khoá 'diem'", dong=b.dong))
                else:
                    tong += b.diem
                if b.hinhthuc not in ("write", "ketluan"):
                    L.append(loi("GIA_TRI_SAI" if b.hinhthuc else "THIEU_KHOA",
                                 f"bước {b.ma}: hinhthuc phải là write|ketluan (gặp '{b.hinhthuc}')", dong=b.dong))
                if b.hinhthuc == "write" and not b.co_yeucau:
                    W.append(loi("THIEU_PHAN", f"bước {b.ma}: bước write nên có \\begin{{yeucau}}", dong=b.dong))
                if b.hinhthuc == "ketluan":
                    so_dung = sum(1 for p in b.phuongan if p["dung"])
                    if not b.co_luachon:
                        L.append(loi("THIEU_PHAN", f"bước {b.ma} (ketluan): thiếu \\begin{{luachon}}", dong=b.dong))
                    elif so_dung != 1:
                        L.append(loi("PHUONGAN_DUNG_SAI",
                                     f"bước {b.ma} (ketluan): cần đúng một \\phuongan* (có {so_dung})", dong=b.dong))
                    if len(b.phuongan) < 2:
                        W.append(loi("PHUONGAN_IT", f"bước {b.ma} (ketluan): nên có ≥ 2 phương án", dong=b.dong))
            diem_cau = chuan_hoa(c)["diem"]
            if diem_cau is not None and c.buoc and abs(tong - diem_cau) > 1e-9:
                L.append(loi("DIEM_CASE_LECH", f"case: tổng điểm các bước {tong:g} khác điểm câu {diem_cau:g}",
                             dong=c.dong))

        # ---- tab Nghiệp vụ
        if c.so_quytrinh > 1:
            L.append(loi("QUYTRINH_NHIEU", f"tab Nghiệp vụ có {c.so_quytrinh} \\quytrinh (tối đa 1)", dong=c.dong))
        for ma_kn, d in c.khainiem:
            if ma_kn not in kb["khainiem"]:
                L.append(loi("KHAINIEM_CHUA_KHAI_BAO", f"\\khainiem{{{ma_kn}}} chưa khai báo bằng \\khaibaokhainiem",
                             dong=d))
        for ten, d in c.lenh_la:
            W.append(loi("LENH_LA", f"lệnh \\{ten} không nằm trong danh sách được dùng trong câu chữ", dong=d))

    # ---- nối khối SQL với câu
    for e in goi_sql["loi"]:
        goi_tex["loi"].append(e)
    khoi_theo: dict[str, list[KhoiSQL]] = {}
    for kh in goi_sql["khoi"]:
        c = theo_ma.get(kh.ma)
        if c is None:
            goi_tex["loi"].append(loi("SQL_KHONG_CO_CAU", f"khối [{kh.khoa}] {kh.loai}: không có câu ma='{kh.ma}'",
                                      "solution.sql", kh.dong))
            continue
        c.loi.extend(kh.loi)
        khoi_theo.setdefault(kh.khoa, []).append(kh)
        if kh.buoc:
            if c.hinhthuc != "case":
                c.loi.append(loi("SQL_KHONG_CO_CAU", f"khối [{kh.khoa}]: câu '{c.ma}' không phải case",
                                 "solution.sql", kh.dong))
            else:
                b = next((b for b in c.buoc if b.ma == kh.buoc), None)
                if b is None:
                    c.loi.append(loi("SQL_KHONG_CO_CAU", f"khối [{kh.khoa}]: câu không có bước '{kh.buoc}'",
                                     "solution.sql", kh.dong))
                elif b.hinhthuc == "ketluan":
                    c.loi.append(loi("SQL_THUA", f"khối [{kh.khoa}]: bước kết luận không có SQL",
                                     "solution.sql", kh.dong))
                if kh.loai == "starter":
                    c.canh_bao.append(loi("SQL_THUA", f"khối [{kh.khoa}] starter: bước case không dùng starter",
                                          "solution.sql", kh.dong))
        elif c.hinhthuc == "case":
            c.loi.append(loi("SQL_THUA", f"khối [{kh.ma}] {kh.loai}: câu case đặt SQL theo bước [ma.bN]",
                             "solution.sql", kh.dong))

    for c in cau_list:
        c.sql = {}  # khoa -> {"solution": [...], "starter": [...], "wrong": [...]}
        for khoa_, ds in khoi_theo.items():
            if khoa_ == c.ma or khoa_.startswith(c.ma + "."):
                for kh in ds:
                    c.sql.setdefault(khoa_, {"solution": [], "starter": [], "wrong": []})[kh.loai].append(kh)
        ht = c.hinhthuc
        g = c.sql.get(c.ma, {"solution": [], "starter": [], "wrong": []})
        if ht in ("write", "debug", "optimize"):
            if len(g["solution"]) != 1:
                c.loi.append(loi("SQL_THIEU", f"{ht}: cần đúng 1 khối solution (có {len(g['solution'])})",
                                 "solution.sql"))
            if len(g["wrong"]) < 1:
                c.loi.append(loi("SQL_THIEU", f"{ht}: cần ít nhất 1 khối wrong", "solution.sql"))
            if ht in ("debug", "optimize") and len(g["starter"]) != 1:
                c.loi.append(loi("SQL_THIEU", f"{ht}: cần đúng 1 khối starter (có {len(g['starter'])})",
                                 "solution.sql"))
            if ht == "write" and len(g["starter"]) > 1:
                c.loi.append(loi("SQL_THUA", "write: tối đa 1 khối starter", "solution.sql"))
            ten_wrong = [w.ten for w in g["wrong"]]
            for t in {x for x in ten_wrong if ten_wrong.count(x) > 1}:
                c.loi.append(loi("SQL_TRUNG", f"wrong '{t}' xuất hiện hai lần", "solution.sql"))
        if ht == "case":
            for b in c.buoc:
                if b.hinhthuc != "write":
                    continue
                gb = c.sql.get(f"{c.ma}.{b.ma}", {"solution": [], "starter": [], "wrong": []})
                if len(gb["solution"]) != 1:
                    c.loi.append(loi("SQL_THIEU", f"case bước {b.ma}: cần đúng 1 khối solution "
                                     f"[{c.ma}.{b.ma}] (có {len(gb['solution'])})", "solution.sql", b.dong))
