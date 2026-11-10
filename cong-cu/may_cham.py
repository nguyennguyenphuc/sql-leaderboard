"""may_cham.py: chạy truy vấn trên MySQL (user chỉ SELECT), so kết quả, đo EXPLAIN ANALYZE.

    MayCham(host, port, user, password, timeout).chay(db, sql) -> KetQua
    so_ket_qua(a, b, thutu, socot, saiso) -> (bằng nhau?, lý do)
    MayCham.do_ke_hoach(db, sql) -> {"quet": {bang: n}, "dong_trung_gian": int, "khong_ro": [...], "ke_hoach": str}
"""
from __future__ import annotations

import datetime as dt
import decimal
import re
import threading
import time
from dataclasses import dataclass, field

import pymysql

try:
    import sqlglot
    from sqlglot import exp
except ImportError:  # chỉ cần cho đo optimize
    sqlglot = None


@dataclass
class KetQua:
    ok: bool
    cot: list[str] = field(default_factory=list)
    dong: list[tuple] = field(default_factory=list)
    loi: str | None = None
    giay: float = 0.0


class MayCham:
    def __init__(self, host, port, user, password, timeout=120):
        self.cfg = dict(host=host, port=int(port), user=user, password=password, charset="utf8mb4",
                        autocommit=True, connect_timeout=15)
        self.timeout = timeout
        self.conn = pymysql.connect(**self.cfg)
        self.db_hien_tai = None

    def dong(self):
        try:
            self.conn.close()
        except Exception:
            pass

    def _ket_noi_lai(self):
        self.dong()
        self.conn = pymysql.connect(**self.cfg)
        self.db_hien_tai = None

    def co_db(self, db: str) -> bool:
        try:
            with self.conn.cursor() as c:
                c.execute("SELECT 1 FROM information_schema.schemata WHERE schema_name = %s", (db,))
                return c.fetchone() is not None
        except pymysql.MySQLError:
            return False

    def schema(self, db: str) -> dict[str, set[str]]:
        """bảng -> {cột (chữ thường)}"""
        out: dict[str, set[str]] = {}
        with self.conn.cursor() as c:
            c.execute("SELECT table_name, column_name FROM information_schema.columns WHERE table_schema = %s",
                      (db,))
            for t, col in c.fetchall():
                out.setdefault(t.lower(), set()).add(col.lower())
        return out

    def _dung_db(self, db):
        if self.db_hien_tai != db:
            self.conn.select_db(db)
            self.db_hien_tai = db

    def _thuc_thi(self, db: str, sql: str):
        """Chạy có giới hạn thời gian: quá giờ thì KILL QUERY từ kết nối phụ (user tự kill được truy vấn của mình)."""
        self._dung_db(db)
        tid = self.conn.thread_id()
        bi_kill = {"v": False}

        def kill():
            bi_kill["v"] = True
            try:
                k = pymysql.connect(**self.cfg)
                with k.cursor() as c:
                    c.execute(f"KILL QUERY {int(tid)}")
                k.close()
            except Exception:
                pass

        timer = threading.Timer(self.timeout, kill)
        timer.start()
        t0 = time.time()
        try:
            with self.conn.cursor() as c:
                c.execute(sql)
                cot = [d[0] for d in c.description] if c.description else []
                dong = list(c.fetchall())
            return cot, dong, time.time() - t0
        except pymysql.MySQLError as e:
            if bi_kill["v"]:
                raise TimeoutError(f"quá {self.timeout} giây") from e
            raise
        finally:
            timer.cancel()

    def chay(self, db: str, sql: str) -> KetQua:
        try:
            cot, dong, giay = self._thuc_thi(db, sql)
            return KetQua(True, cot, [tuple(r) for r in dong], None, giay)
        except TimeoutError as e:
            self._ket_noi_lai()
            return KetQua(False, loi=str(e))
        except pymysql.MySQLError as e:
            if isinstance(e, (pymysql.err.OperationalError, pymysql.err.InterfaceError)) and \
                    e.args and e.args[0] in (2006, 2013, 0):
                self._ket_noi_lai()
            msg = e.args[1] if len(e.args) > 1 else str(e)
            return KetQua(False, loi=f"MySQL {e.args[0] if e.args else ''}: {msg}")

    # ------------------------------------------------------------ EXPLAIN ANALYZE
    def do_ke_hoach(self, db: str, sql: str, bang_that: set[str]) -> dict:
        try:
            _, dong, _ = self._thuc_thi(db, "EXPLAIN ANALYZE " + sql)
        except TimeoutError as e:
            self._ket_noi_lai()
            return {"loi": str(e)}
        except pymysql.MySQLError as e:
            return {"loi": f"MySQL {e.args[0] if e.args else ''}: {e.args[1] if len(e.args) > 1 else e}"}
        cay = "\n".join(str(r[0]) for r in dong)
        return phan_tich_ke_hoach(cay, sql, bang_that)


# ============================================================ phân tích kế hoạch
SCAN_RE = re.compile(
    r"->\s+(?P<op>(?:Single-row\s+)?(?:[Cc]overing\s+)?(?:[Ii]ndex\s+)?"
    r"(?:Table scan|scan|range scan(?: \(Multi-Range Read\))?|lookup|skip scan(?: for (?:grouping|deduplication))?"
    r"|search))\s+on\s+(?P<ten>`[^`]+`|<[^>]+>|\S+)")
COUNT_RE = re.compile(r"->\s+(?P<op>Count rows in|Constant row from)\s+(?P<ten>`[^`]+`|\S+)")
ACTUAL_RE = re.compile(r"\(actual time=[^ ]+ rows=(?P<rows>[0-9.e+\-]+) loops=(?P<loops>[0-9.e+\-]+)\)")


def ban_do_bi_danh(sql: str) -> tuple[dict[str, set[str]], set[str]]:
    """Dùng sqlglot: bí danh/tên -> {bảng thật}; và tập tên CTE + bảng dẫn xuất (bỏ khi đếm)."""
    ali: dict[str, set[str]] = {}
    ao: set[str] = set()
    if sqlglot is None:
        return ali, ao
    try:
        cay = sqlglot.parse_one(sql, read="mysql")
    except Exception:
        return ali, ao
    for cte in cay.find_all(exp.CTE):
        if cte.alias:
            ao.add(cte.alias.lower())
    for sq in cay.find_all(exp.Subquery):
        if sq.alias:
            ao.add(sq.alias.lower())
    for t in cay.find_all(exp.Table):
        ten = (t.name or "").lower()
        if not ten:
            continue
        if ten in ao and not t.args.get("db"):
            # tham chiếu tới CTE
            if t.alias:
                ao.add(t.alias.lower())
            continue
        ali.setdefault((t.alias or t.name).lower(), set()).add(ten)
        ali.setdefault(ten, set()).add(ten)
    return ali, ao


def _so(x: str) -> float:
    try:
        return float(x)
    except ValueError:
        return 0.0


def phan_tich_ke_hoach(cay: str, sql: str, bang_that: set[str]) -> dict:
    ali, ao = ban_do_bi_danh(sql)
    quet: dict[str, int] = {}
    khong_ro: list[str] = []
    dong_tg = 0.0
    for line in cay.splitlines():
        m = ACTUAL_RE.search(line)
        if m:
            dong_tg += _so(m.group("rows")) * _so(m.group("loops"))
        ms = SCAN_RE.search(line) or COUNT_RE.search(line)
        if not ms:
            continue
        ten = ms.group("ten").strip("`").lower()
        if ten.startswith("<"):
            continue                        # <temporary>, <union temporary>, <subqueryN>, <derivedN>
        if "using <auto_key" in line or "using <auto_distinct_key" in line:
            continue                        # tra cứu trên bảng dẫn xuất/CTE đã materialize
        if ten in ao:
            continue                        # CTE / bảng dẫn xuất
        that = ali.get(ten)
        if that and len(that) == 1:
            t = next(iter(that))
        elif that and len(that) > 1:
            # cùng bí danh cho nhiều bảng ở các phạm vi khác nhau: thử theo tên chỉ mục
            t = sorted(that)[0]
            khong_ro.append(f"{ten} -> {sorted(that)} (chọn {t})")
        elif ten in bang_that:
            t = ten
        else:
            t = ten
            khong_ro.append(f"{ten} (không đổi được về bảng thật)")
        quet[t] = quet.get(t, 0) + 1
    return {"quet": quet, "dong_trung_gian": int(round(dong_tg)), "khong_ro": khong_ro, "ke_hoach": cay}


# ============================================================ so kết quả
def _loai(v):
    if v is None:
        return "null"
    if isinstance(v, bool):
        return "so"
    if isinstance(v, (int, float, decimal.Decimal)):
        return "so"
    if isinstance(v, (bytes, bytearray)):
        return "chuoi"
    if isinstance(v, str):
        return "chuoi"
    if isinstance(v, (dt.datetime, dt.date, dt.time, dt.timedelta)):
        return "thoigian"
    return "khac"


def _chuoi(v):
    return v.decode("utf-8", "replace") if isinstance(v, (bytes, bytearray)) else v


def gia_tri_bang(a, b, saiso: float) -> bool:
    la, lb = _loai(a), _loai(b)
    if la != lb:
        return False
    if la == "null":
        return True
    if la == "so":
        try:
            return abs(float(a) - float(b)) <= saiso + 1e-9 * max(1.0, abs(float(a)))
        except (OverflowError, ValueError):
            return a == b
    if la == "chuoi":
        return _chuoi(a) == _chuoi(b)
    if la == "thoigian":
        return type(a) is type(b) and a == b
    return a == b


def _khoa_sap(row, saiso):
    out = []
    for v in row:
        l = _loai(v)
        if l == "null":
            out.append((0, 0))
        elif l == "so":
            q = saiso if saiso > 0 else 1e-9
            out.append((1, round(float(v) / q)))
        elif l == "chuoi":
            out.append((2, _chuoi(v)))
        else:
            out.append((3, str(v)))
    return tuple(out)


def so_ket_qua(chuan: KetQua, bai: KetQua, thutu: str = "co", socot: str = "vitri",
               saiso: float = 0.01) -> tuple[bool, str]:
    """So bài với chuẩn. Trả (bằng, lý do). Lý do không in giá trị dữ liệu."""
    if not bai.ok:
        return False, f"lỗi khi chạy: {bai.loi}"
    if len(bai.cot) != len(chuan.cot):
        return False, f"khác số cột ({len(bai.cot)} so với {len(chuan.cot)})"
    dong_bai = bai.dong
    if socot == "ten":
        ten_chuan = [c.lower() for c in chuan.cot]
        ten_bai = [c.lower() for c in bai.cot]
        if sorted(ten_chuan) != sorted(ten_bai) or len(set(ten_bai)) != len(ten_bai):
            return False, "khác tên cột"
        idx = [ten_bai.index(t) for t in ten_chuan]
        dong_bai = [tuple(r[i] for i in idx) for r in bai.dong]
    if len(dong_bai) != len(chuan.dong):
        return False, f"khác số dòng ({len(dong_bai)} so với {len(chuan.dong)})"
    a, b = list(chuan.dong), list(dong_bai)
    if thutu == "khong":
        a = sorted(a, key=lambda r: _khoa_sap(r, saiso))
        b = sorted(b, key=lambda r: _khoa_sap(r, saiso))
    for i, (ra, rb) in enumerate(zip(a, b), 1):
        for j, (va, vb) in enumerate(zip(ra, rb), 1):
            if not gia_tri_bang(va, vb, saiso):
                if _loai(va) != _loai(vb):
                    return False, f"khác kiểu giá trị ở dòng {i}, cột {j} ({_loai(vb)} so với {_loai(va)})"
                return False, f"khác giá trị ở dòng {i}, cột {j}"
    return True, "khớp"


def gia_tri_json(v):
    if isinstance(v, decimal.Decimal):
        return float(v) if v != v.to_integral_value() else int(v)
    if isinstance(v, (dt.date, dt.datetime, dt.time)):
        return v.isoformat()
    if isinstance(v, dt.timedelta):
        return str(v)
    if isinstance(v, (bytes, bytearray)):
        return v.decode("utf-8", "replace")
    return v
