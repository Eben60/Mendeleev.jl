# module IS
# using Mendeleev, Unitful, Tables, DataFrames, CSV
# using Main.Generate_MFiles
#
# using Main.Generate_MFiles: dfs, round_pos, LAST_NO, isotopes_fl
#
# isot_fl = "auxillary/isotopes.txt"

# els = ELEMENTS_M
#
# el(x) = ELEMENTS_M[x]
# color(x) = el(x).jmol_color


# abund(x) = maximum([el(x).abundance_crust |> ustrip, el(x).abundance_sea |> ustrip])
#

# struct Isotope
#     atomic_number::Int
#     mass_number::Int
#     mass::Float64
#     abundance::Union{Float64, Missing}
#     is_radioactive::Bool # 0, 1, missing in the database
#     half_life::Union{Float64, Missing} # missing -> Inf if stable
# end
#
# Isotope(x::Vector) = Isotope(x...)

el(x) = elements[x] # to enable broadcasting over x
sym(x) = string(el(x).symbol)

isot = dfs.isotopes
i4 = select(isot, :id, :atomic_number, :atomic_number => (x -> sym.(x))  => :sym, :mass_number, :mass, :abundance; renamecols=false)
i4s = subset(i4, :abundance => (x -> .!ismissing.(x) ))[!, [:atomic_number, :mass_number, :mass, :abundance]]

function elem_isotopes(no, df)
    nos = Set(df[!, :atomic_number])
    !(no in nos) && return missing
    el_data = subset(df, :atomic_number => (x -> x .== no )) |> rowtable .|> Tuple .|> collect .|> round_pos
    return el_data
end

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
#
# end # module IS
