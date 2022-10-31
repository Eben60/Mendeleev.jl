julia> feli = els.Fe.eneg.Li
Li-Xue Electronegativities for Fe
    (Fe4+, coordination=VI, value=9.56 pm⁻¹)
    (Fe6+, coordination=IV, value=23.86 pm⁻¹)
    (Fe2+, coordination=IV, spin=HS, value=4.889 pm⁻¹)
    (Fe2+, coordination=IVSQ, spin=HS, value=4.826 pm⁻¹)
    (Fe2+, coordination=VI, spin=HS, value=4.092 pm⁻¹)
    (Fe2+, coordination=VIII, spin=HS, value=3.551 pm⁻¹)
    (Fe2+, coordination=VI, spin=LS, value=5.019 pm⁻¹)
    (Fe3+, coordination=IV, spin=HS, value=8.219 pm⁻¹)
    (Fe3+, coordination=VIII, spin=HS, value=5.629 pm⁻¹)
    (Fe3+, coordination=VI, spin=HS, value=6.596 pm⁻¹)
    (Fe3+, coordination=VI, spin=LS, value=7.505 pm⁻¹)
    (Fe3+, coordination=V, value=7.192 pm⁻¹)

julia> feli[1]
(Fe4+, coordination=VI, value=9.56 pm⁻¹)

julia> feli(;charge=2, coordination=:IV, spin=:HS)
1-element Vector{Mendeleev.LiXueDSet}:
 (Fe2+, coordination=IV, spin=HS, value=4.889 pm⁻¹)

