from mendeleev import element

for e in element(list(range(1,118))):
    for v in range(-7, 8):
        if v != 0:
            try:
                lixue = e.electronegativity('li-xue', charge=v)
                if len(lixue) != 0:     
                    print(e.name, v, lixue)
            except:
                print(e.name, v, "error")
