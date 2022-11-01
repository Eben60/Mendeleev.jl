module EnegTests
using Mendeleev, Test, Unitful
using Mendeleev: Electronegativities, LiXueDSet 

@testset "EnegTests" begin

    Cl = chem_elements.Cl
    cleneg = Cl.eneg
    feli = chem_elements.Fe.eneg.Li
    @test cleneg.atomic_number ≈ 17
    @test cleneg.Allen |> ustrip ≈ 16.97 
    @test cleneg.Allred |> ustrip ≈ 0.0006223854708703193 
    @test cleneg.Cottrell |> ustrip ≈ 0.2482260292881502 
    @test cleneg.Ghosh |> ustrip ≈ 0.263803 
    @test cleneg.Gordy |> ustrip ≈ 0.06161616161616161 
    @test cleneg.Martynov |> ustrip ≈ 7.640517652620142 
    @test cleneg.Mulliken |> ustrip ≈ 6.483815 
    @test cleneg.Nagle |> ustrip ≈ 0.7826754796597776 
    @test cleneg.Pauling |> ustrip ≈ 3.16 
    @test cleneg.Sanderson |> ustrip ≈ 0.81237728291421
 
    @test cleneg.Li[1].charge == 5
    @test cleneg.Li[1].coordination == :IIIPY
    @test ismissing(cleneg.Li[1].spin)
    @test length(cleneg.Li) == 3

    @test feli[4].spin == :LS
    @test feli[4].value |> ustrip ≈ 5.0193130327270925
    @test typeof(feli[4].value) == typeof(1.0u"1/pm")
    @test eltype(feli) == LiXueDSet
    @test feli(;charge=2) == feli[1:5]
    @test feli(;charge=2, coordination=:VI) == feli[[3, 4]]
    @test isempty(feli(;charge=4, spin=:HS))
    @test feli[[3, 4]] == [feli[3], feli[4]]
    @test_throws DomainError feli[4] < cleneg.Li[1]
# ≈
    


    
#     NotAnEl_IR = IonicRadius(1, 3, :III, 25.0u"pm", "0s7", 25.5u"pm", false, missing, :HS, 1.1u"C/m")
    
#     @test_throws DomainError Cl1minus < NotAnEl_IR
#     @test  Cl1minus != NotAnEl_IR
#     @test Cl1minus < Cl5plus
    
#     @test eltype(Cl.ionic_radii) == typeof(NotAnEl_IR)
#     @test length(Cl.ionic_radii) == 4
    @test Cl.ionic_radii[[2, 4]] == [Cl.ionic_radii[2], Cl.ionic_radii[4]]

end # testset
end # module