from mendeleev import element
import os.path

def ephyall(first=1, last=119):
    ens = {}
    for e in element(list(range(first, last))):
        ephy = e.electrophilicity()
        k = (e.atomic_number, e.symbol)
        ens.update({k : ephy})
    return ens

ephys = ephyall()

p = os.path.dirname(__file__)
outf = os.path.normpath(os.path.join(p, "../data/ephil_data.jl"))

with open(outf, "w") as txtfile:
    txtfile.write("# this is computer generated file - better not edit \n\n")
    txtfile.write("const electrophilicities = [\n")

    for k in sorted(ephys.keys()):
        txtfile.write("    ")
        ephy = ephys[k]
        if ephy == None:
            txtfile.write("missing")
        else:
            txtfile.write(str(ephys[k]))
        txtfile.write(", # ")
        txtfile.write(k[1])
        txtfile.write("\n")       
    txtfile.write("]\n")

# for k in sorted(ephys.keys()):
#     print(ephys[k])

