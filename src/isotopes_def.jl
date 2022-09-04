struct Isotope
    atomic_number::Int
    mass_number::Int
    mass::typeof(1.0*u"u")
    abundance::Union{Float64, Missing}
    is_radioactive::Bool
    half_life::Union{typeof(1.0*u"yr"), Missing}
end

Isotope(atomic_number, mass_number, mass::Float64, abundance, is_radioactive, half_life::Union{Float64, Missing}) =
    Isotope(atomic_number, mass_number, mass*u"u", abundance, is_radioactive, half_life*u"yr")

# Isotope(x::Vector) = Isotope(x...)
