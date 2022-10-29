module Eneg

# module ElementaryChargeUnit
# using Unitful
# @unit qu "qu" ElementaryCharge Unitful.q true; 
# # @unit(symb,abbr,name,equals,tf,autodocs=false)
# end

using Unitful
using UnitfulAtomic # : e_au
# Unitful.register(ElementaryChargeUnit)

struct LiXue
    data::Float64
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
    Li::LiXue # Union{typeof(1.0/u"pm"), Missing} # ::EnegLiXue
end

p = 2u"e_au"/172u"pm"

end # module Eneg