from mendeleev import element
import os.path

def mullikenall(first=1, last=118):
# def mullikenall(first=1, last=6):
    ens = {}
    for e in element(list(range(first, last))):

        mulliken = e.electronegativity('mulliken')
        k = (e.symbol, e.atomic_number)
        n = e.atomic_number
        s = e.symbol
        if(mulliken is None):
            m = "missing"
        else:
            m = mulliken
        ens.update({s :m})
        # print(",",  m, "#", s)
        # print(mulliken)
    return ens

mullikall = mullikenall()

# with open("mulliken.json", "w") as jsfile:
#     json.dump(mulliken, jsfile)
p = os.path.dirname(__file__)
outf = os.path.normpath(os.path.join(p, "../data/mulliken_data.txt"))
with open(outf, "w") as txtfile:
    for k, v in mullikall.items():
        txtfile.write(f", {v} #= {k} =#")
