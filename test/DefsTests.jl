module DefsTests
using Mendeleev, Test
using Mendeleev: elements_data

@testset "ReprTests" begin

@test elements_data[:abundance_crust][1] == 1400.0
@test elements_data[:abundance_sea][3] == 0.18
@test ismissing(elements_data[:annotation][3])
@test elements_data[:appearance][12] == "shiny grey solid"
@test elements_data[:atomic_radius][1:4] == [
    25.0 , # H
    120.0 , # He
    145.0 , # Li
    105.0
    ]
@test elements_data[:atomic_radius_rahm][1] == 154.0
@test elements_data[:name_origin][18] == "Greek: argos (inactive)."
@test elements_data[:proton_affinity][18] == 369.2
@test elements_data[:xpos][18] == 18
end
end