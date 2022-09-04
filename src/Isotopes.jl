module IS
using Mendeleev, Unitful, Tables, DataFrames, CSV
using Main.Generate_MFiles

isot_fl = "auxillary/isotopes.txt"

els = ELEMENTS_M

el(x) = ELEMENTS_M[x]
color(x) = el(x).jmol_color
sym(x) = string(el(x).symbol)
abund(x) = maximum([el(x).abundance_crust |> ustrip, el(x).abundance_sea |> ustrip])


struct Isotope
    atomic_number::Int
    mass_number::Int
    mass::Float64
    abundance::Union{Float64, Missing}
    is_radioactive::Bool # 0, 1, missing in the database
    half_life::Union{Float64, Missing} # missing -> Inf if stable
end

Isotope(x::Vector) = Isotope(x...)

isot = Generate_MFiles.dfs.isotopes
i2 = select(isot, :id, :atomic_number, :mass_number, :mass, :abundance, :half_life)
i3 = select(isot, :id, :atomic_number, :atomic_number => (x -> sym.(x))  => :sym, :mass_number, :mass, :abundance, :half_life)

i4 = select(isot, :id, :atomic_number, :atomic_number => (x -> sym.(x))  => :sym, :atomic_number => (x -> abund.(x))  => :abund_elem, :mass_number, :mass, :abundance, :half_life, :is_radioactive  => (x -> Bool.(x)); renamecols=false)

# i5 = select(i4, [:half_life, :is_radioactive] .=> ByRow.(x -> (ismissing(x[2]) ? x[1] : Inf)))

# i5 = select(i4, [:half_life, :is_radioactive] => ByRow(x -> x[2]) => :rad)

hl = i4[!, :half_life]
ir = i4[!, :is_radioactive]

hlinf(hl, ir) = ir ? hl : Inf

hli = hlinf.(hl, ir)

i4.half_life = hli

i5 = i4[.!ismissing.(i4.abundance), [:atomic_number, :mass_number, :mass, :abundance, :is_radioactive, :half_life]]

i5t = i5 |> rowtable .|> Tuple .|> collect .|> Generate_MFiles.round_pos
# i5tr = Generate_MFiles.round_pos.(i5t, 13)

is = Isotope.(i5t)

# CSV.write(isot_fl, i4; delim='\t', missingstring="missing")

# :x2 => (x -> x .- minimum(x)) => :x2)


# :name => (x -> uppercase.(x)) => :NAME)
# transform!(scr, :symbol => (x->Symbol.(x)); renamecols=false)
# isot = isot[!, ]
# include("src/Generate_MFiles.jl"); include("src/isotopes.jl"); isot = IS.isot;

# julia> Set(ans[!, :half_life_unit])
# Set{Union{Missing, String}} with 7 elements:
#   "d"
#   missing
#   "ms"
#   "a"
#   "h"
#   "min"
#   "s

end #IS
