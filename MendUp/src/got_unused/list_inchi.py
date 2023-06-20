from mendeleev import element
import os.path

def inchiall(first=1, last=119):
    ens = {}
    for e in element(list(range(first, last))):
        inchi = e.inchi
        k = e.atomic_number
        ens.update({k : inchi})
    return ens

inchies = inchiall()

p = os.path.dirname(__file__)
outf = os.path.normpath(os.path.join(p, "../data/inchie_all.jl"))

with open(outf, "w") as txtfile:
    txtfile.write("# this is computer generated file - better not edit \n\n")
    txtfile.write("const inchi = [\n")

    for k in sorted(inchies.keys()):
        txtfile.write("    \"")
        txtfile.write(inchies[k])
        txtfile.write("\", \n")

    txtfile.write("]")

# for k in sorted(inchies.keys()):
#     print(inchies[k])

