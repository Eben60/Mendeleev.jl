from mendeleev import element
import os.path

def lixueall(first=1, last=118):
    ens = {}
    for e in element(list(range(first, last))):
        for v in range(-7, 8):
            if v != 0:
                try:
                    lixue = e.electronegativity('li-xue', charge=v)
                    if len(lixue) != 0:
                        k = (e.symbol, e.atomic_number, v)
                        ens.update({k : lixue})
                        # print(len(ens), k, ens[k])
                except:
                    pass
                    # print(e.name, v, "error")
    return ens

lixue = lixueall()

# with open("lixue.json", "w") as jsfile:
#     json.dump(lixue, jsfile)
p = os.path.dirname(__file__)
outf = os.path.normpath(os.path.join(p, "../data/lixue_data.txt"))
with open(outf, "w") as txtfile:
    txtfile.write(str(lixue))