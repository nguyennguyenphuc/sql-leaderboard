#!/usr/bin/env python3
# sinh_thong_ke.py: sinh lại phần THỐNG KÊ của goi-cau-hoi/<bo>/BAN-DO-100-CAU.md từ cau-hoi.tex thật.
# Chạy trong container sqllb-tools (hoặc bất kỳ python3 nào):
#   docker compose run --rm tools python cong-cu/sinh_thong_ke.py <bo>        # in thống kê ra màn hình
#   docker compose run --rm tools python cong-cu/sinh_thong_ke.py <bo> --ghi  # in + hướng dẫn thay vào BAN-DO
# Chỉ ĐỌC cau-hoi.tex; không tự sửa BAN-DO-100-CAU.md (người dùng thay khối "## Thống kê" bằng đầu ra này).
import io, os, re, sys

CAP = ["basic", "easy", "medium", "hard"]
TEN_CAP = {"basic": "Cơ bản", "easy": "Dễ", "medium": "Trung bình", "hard": "Khó"}
TEN_HT = {"write": "Viết", "debug": "Sửa lỗi", "optimize": "Tối ưu", "case": "Case"}
TEN_MANG = {"sales": "Bán hàng", "marketing": "Marketing", "customer": "Khách hàng",
            "operations": "Vận hành", "finance": "Tài chính", "after_sales": "Hậu mãi"}
MA_MANG = {"sales": "sal", "marketing": "mkt", "customer": "cus",
           "operations": "ops", "finance": "fin", "after_sales": "as"}
KHOP = re.compile(r"\\begin\{cauhoi\}\[([^\]]*)\]", re.S)


def doc_cauhoi(duong_dan):
    noi_dung = io.open(duong_dan, encoding="utf-8").read()
    ket_qua = []
    for m in KHOP.finditer(noi_dung):
        thuoc_tinh = {}
        for cap in m.group(1).split(","):
            if "=" in cap:
                k, v = cap.split("=", 1)
                thuoc_tinh[k.strip()] = v.strip()
        ket_qua.append(thuoc_tinh)
    return ket_qua


def dem(ds, cot):
    bang = {}
    for t in ds:
        khoa = t.get(cot, "?")
        bang[khoa] = bang.get(khoa, 0) + 1
    return bang


def main():
    bo = sys.argv[1]
    ghi = "--ghi" in sys.argv
    goc = os.path.join("goi-cau-hoi", bo)
    tat_ca, theo_goi = [], {}
    for k in range(1, 6):
        ds = doc_cauhoi(os.path.join(goc, f"goi-{k}", "cau-hoi.tex"))
        theo_goi[k] = ds
        tat_ca += ds

    dong = []
    dong.append(f"## Thống kê (sinh lại tự động từ cau-hoi.tex, {len(tat_ca)} câu)")
    # 1. module x cap
    bang = {}
    for t in tat_ca:
        ma = t.get("ma", "?")
        tien_to = ma[len(bo) + 1] if ma.startswith(bo + "-") else "?"
        bang.setdefault(tien_to, {}).setdefault(t.get("cap", "?"), 0)
        bang[tien_to][t.get("cap", "?")] += 1
    dong.append("\n### Module × cấp\n")
    dong.append("| Tiền tố | " + " | ".join(TEN_CAP[c] for c in CAP) + " |")
    dong.append("|---|" + "---:|" * 4)
    for tien_to in sorted(bang):
        dong.append(f"| `{tien_to}` | " + " | ".join(str(bang[tien_to].get(c, 0)) for c in CAP) + " |")
    # 2. hinh thuc x cap
    bang2 = dem_cap(tat_ca, "hinhthuc")
    dong.append("\n### Hình thức × cấp\n")
    dong.append("| Hình thức | " + " | ".join(TEN_CAP[c] for c in CAP) + " | Cộng |")
    dong.append("|---|" + "---:|" * 5)
    for ht in ["write", "debug", "optimize", "case"]:
        if ht in bang2:
            dong.append(f"| {TEN_HT[ht]} | " + " | ".join(str(bang2[ht].get(c, 0)) for c in CAP)
                        + f" | {sum(bang2[ht].values())} |")
    # 3. hinh thuc x mảng
    bang3 = {}
    for t in tat_ca:
        bang3.setdefault(t.get("hinhthuc", "?"), {}).setdefault(t.get("domain", "?"), 0)
        bang3[t["hinhthuc"]][t.get("domain", "?")] += 1
    mang_ds = sorted({m for t in bang3.values() for m in t})
    dong.append("\n### Hình thức × mảng\n")
    dong.append("| Hình thức | " + " | ".join(TEN_MANG.get(m, m) for m in mang_ds) + " |")
    dong.append("|---|" + "---:|" * len(mang_ds))
    for ht in ["write", "debug", "optimize", "case"]:
        if ht in bang3:
            dong.append(f"| {TEN_HT[ht]} | " + " | ".join(str(bang3[ht].get(m, 0)) for m in mang_ds) + " |")
    # 4. tung goi: cap + so cau
    dong.append("\n### Theo gói\n")
    dong.append("| Gói | " + " | ".join(TEN_CAP[c] for c in CAP) + " | Cộng |")
    dong.append("|---|" + "---:|" * 5)
    for k in range(1, 6):
        ds = theo_goi[k]
        dong.append(f"| goi-{k} | " + " | ".join(str(sum(1 for t in ds if t.get("cap") == c) for c in CAP))
                    + f" | {len(ds)} |")
    # 5. trùng ô trong cùng bo (dang x mang x cap x hinhthuc)
    o = {}
    for k in range(1, 6):
        for t in theo_goi[k]:
            khoa = (t.get("dang", "?"), t.get("domain", "?"), t.get("cap", "?"), t.get("hinhthuc", "?"))
            o.setdefault(khoa, []).append((k, t.get("ma", "?")))
    trung = {k_: v for k_, v in o.items() if len(v) > 1}
    dong.append("\n### Ô trùng trong cùng bộ (dạng × mảng × cấp × hình thức)\n")
    if trung:
        for k_, v in sorted(trung.items()):
            dong.append(f"- {' · '.join(k_)}: " + ", ".join(f"goi-{g} `{m}`" for g, m in v))
    else:
        dong.append("Không có.")

    van_ban = "\n".join(dong)
    print(van_ban)
    if ghi:
        print("\n--> Thay khối '## Thống kê' trong goi-cau-hoi/%s/BAN-DO-100-CAU.md bằng đầu ra trên." % bo)


def dem_cap(ds, cot):
    bang = {}
    for t in ds:
        bang.setdefault(t.get(cot, "?"), {}).setdefault(t.get("cap", "?"), 0)
        bang[t[cot]][t.get("cap", "?")] += 1
    return bang


if __name__ == "__main__":
    main()
