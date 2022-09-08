struct Isotope
    atomic_number::Int
    mass_number::Int
    mass::typeof(1.0*u"u")
    abundance::Float64
end

Isotope(atomic_number, mass_number, mass::Float64, abundance) =
    Isotope(atomic_number, mass_number, mass*u"u", abundance)

struct Isotopes
    isotopes::Vector{Isotope}
end
