module IS
using Mendeleev, Unitful, Tables, DataFrames, CSV
using Main.Generate_MFiles

using Main.Generate_MFiles: dfs, round_pos, LAST_NO, isotopes_fl

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

isot = dfs.isotopes
# i2 = select(isot, :id, :atomic_number, :mass_number, :mass, :abundance, :half_life)
# i3 = select(isot, :id, :atomic_number, :atomic_number => (x -> sym.(x))  => :sym, :mass_number, :mass, :abundance, :half_life)

i4 = select(isot, :id, :atomic_number, :atomic_number => (x -> sym.(x))  => :sym, :atomic_number => (x -> abund.(x))  => :abund_elem, :mass_number, :mass, :abundance, :half_life, :is_radioactive  => (x -> Bool.(x)); renamecols=false)

# i5 = select(i4, [:half_life, :is_radioactive] .=> ByRow.(x -> (ismissing(x[2]) ? x[1] : Inf)))

# i5 = select(i4, [:half_life, :is_radioactive] => ByRow(x -> x[2]) => :rad)

hl = i4[!, :half_life]
ir = i4[!, :is_radioactive]

hlinf(hl, ir) = ir ? hl : Inf

hli = hlinf.(hl, ir)

i4.half_life = hli

; i5 = i4[.!ismissing.(i4.abundance), [:atomic_number, :mass_number, :mass, :abundance, :is_radioactive, :half_life]]


i4s = subset(i4, :abundance => (x -> .!ismissing.(x) ))[!, [:atomic_number, :mass_number, :mass, :abundance, :is_radioactive, :half_life]]



i5t = i5 |> rowtable .|> Tuple .|> collect .|> Generate_MFiles.round_pos

function elem_isotopes(no, df)
    nos = Set(df[!, :atomic_number])
    !(no in nos) && return missing
    el_data = subset(df, :atomic_number => (x -> x .== no )) |> rowtable .|> Tuple .|> collect .|> round_pos
    return el_data
end

i110 = elem_isotopes(110, i4s)
i2 = elem_isotopes(2, i4s)

d_isot = Dict(n => elem_isotopes(n, i4s) for n in 1:LAST_NO)

function isot_string(x)
    s = string.(x)
    j = join(s, ", ")
    return "Isotope($j)"
end

function isots_string(x)
    ismissing(x) && return "missing"
    j = join(isot_string.(x), ", ")
    return "Isotopes([$j])"
end

# function print_isotopes(io, atomic_number)
#     is = isots_string(d_isot[atomic_number])
#     if ismissing(ie)
#         println(io, "    $atomic_number => missing,")
#     else
#         en_strings = join(string.(ie), ", ")
#         println(io, "    $atomic_number => [$en_strings],")
#     end
#     return nothing
# end

function make_isotopes_data(fl)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const isotopes_data = Dict{Int64, Union{Missing, Isotopes}}(")
        for no in 1:LAST_NO
            println(io, "    $no => ", isots_string(d_isot[no]), ",")
        end
        println(io, ")")
    end
    return nothing
end

 make_isotopes_data(isotopes_fl)

# i5tr = Generate_MFiles.round_pos.(i5t, 13)

# is = Isotope.(i5t)

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
