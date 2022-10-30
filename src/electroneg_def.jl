function fields(t)
    nms = fieldnames(t)
    tps = nonmissingtype.(fieldtypes(t))
    return NamedTuple{nms}(tps)
end

struct Electronegativities
    atomic_number::Int
    Allen::Union{typeof(1.0*u"eV"), Missing} # eV or Ry ??
    Allred::Union{typeof(1.0(u"e_au"^2/u"pm"^2)), Missing}
    Cottrell::Union{typeof(1.0(u"e_au"/u"pm")^(1//2)), Missing}
    Ghosh::Union{typeof(1.0/u"pm"), Missing}
    Gordy::Union{typeof(1.0(u"e_au"/u"pm")), Missing}
    Martynov::Union{typeof(1.0*u"eV^(1//2)"), Missing}
    Mulliken::Union{typeof(1.0*u"eV"), Missing}
    Nagle::Union{typeof(1.0u"Å^-1"), Missing}
    Pauling::Union{typeof(1.0*u"eV^(1//2)"), Missing}
    Sanderson::Union{Float64, Missing} # unitless
    Li::Union{LiXue, Missing}
end

Electronegativities(; atomic_number, Allen, Allred, Cottrell, Ghosh, Gordy, Martynov, Mulliken, Nagle, Pauling, Sanderson, Li) = 
    Electronegativities(atomic_number, Allen, Allred, Cottrell, Ghosh, Gordy, Martynov, Mulliken, Nagle, Pauling, Sanderson, Li)

totype(x, T) = ismissing(x) ? missing : T(x)

function Electronegativities(i::Integer)
    fs = fields(Electronegativities)
    data = (;[k => totype(v[i], fs[k]) for (k, v) in pairs(eneg_data)]...)
    return Electronegativities(;atomic_number=i, Li=lx_or_missing(i), data...)
end

function Base.show(io::IO, en::Electronegativities)
    println(io, "Electronegativities for $(chem_elements[en.atomic_number].symbol)")
    for f in fieldnames(Electronegativities)
        x = getfield(en, f)
        if !ismissing(x) && f != :Li
            println(io, "    $f=$x")
        end
    end
    show(io, en.Li)
end
