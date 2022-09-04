struct Isotope
    atomic_number::Int
    mass_number::Int
    mass::Float64
    abundance::Union{Float64, Missing}
    is_radioactive::Bool
    half_life::Union{Float64, Missing}
end

# Isotope(x::Vector) = Isotope(x...)
