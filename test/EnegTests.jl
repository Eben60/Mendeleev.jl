module EnegTests
using Mendeleev, Test, Unitful
using Mendeleev: Electronegativities, LiXueDSet 

@testset "EnegTests" begin

    Cl = chem_elements.Cl
    cleneg = Cl.eneg
    feli = chem_elements.Fe.eneg.Li
    sien = chem_elements.Si.eneg
    @test cleneg.atomic_number ≈ 17
    @test cleneg.Allen |> ustrip ≈ 16.97 
    @test cleneg.Allred |> ustrip ≈ 0.0006223854708703193 
    @test cleneg.Cottrell |> ustrip ≈ 0.2482260292881502 
    @test cleneg.Ghosh |> ustrip ≈ 0.263803 
    @test cleneg.Gordy |> ustrip ≈ 0.06161616161616161 
    @test cleneg.Martynov |> ustrip ≈ 7.640517652620142 
    @test cleneg.Mulliken |> ustrip ≈ 8.2901775 
    @test cleneg.Nagle |> ustrip ≈ 0.7826754796597776 
    @test cleneg.Pauling |> ustrip ≈ 3.16 
    @test cleneg.Sanderson |> ustrip ≈ 0.81237728291421
 
    @test cleneg.Li[1].charge == 5
    @test cleneg.Li[1].coordination == :IIIPY
    @test ismissing(cleneg.Li[1].spin)
    @test length(cleneg.Li) == 3

    @test feli[4].spin == :LS
    @test feli[4].value |> ustrip ≈ 5.0193130327270925
    @test typeof(feli[4].value) == Float64 # TODO after clarifying units typeof(1.0u"1/pm")
    @test eltype(feli) == LiXueDSet
    @test feli(;charge=2) == feli[1:5]
    @test feli(;charge=2, coordination=:VI) == feli[[3, 4]]
    @test isempty(feli(;charge=4, spin=:HS))
    @test feli[[3, 4]] == [feli[3], feli[4]]
    @test_throws DomainError feli[4] < cleneg.Li[1]

    @test sien.Allen |> ustrip ≈ 11.33 
    @test sien.Allred |> ustrip ≈ 0.00030841260404280616 # 
    @test sien.Cottrell |> ustrip ≈ 0.18914508206391598 # 
    @test sien.Ghosh |> ustrip ≈ 0.178503 
    @test sien.Gordy |> ustrip ≈ 0.03577586206896551 # 
    @test sien.Martynov |> ustrip ≈ 5.0777041564076963 
    @test sien.Mulliken |> ustrip ≈ 4.77060205 
    @test sien.Nagle |> ustrip ≈ 0.4750985662830595 #
    @test sien.Pauling |> ustrip ≈ 1.9 
    @test sien.Sanderson |> ustrip ≈ 0.3468157872145231    
# ≈
    @test sien.Li(;charge=4, coordination=:VI)[1].value |> ustrip ≈ 9.74839542504959


end # testset
end # module