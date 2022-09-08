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

Base.getindex(iss::Isotopes, i::Integer) = iss.isotopes[i]
Base.getindex(iss::Isotopes, v::AbstractVector) = [iss[i] for i in v]

Base.get(iss::Isotopes, i::Integer, default) = get(iss.isotopes[i], i, default)


# support iterating over Isotopes
Base.eltype(iss::Isotopes) = Isotope
Base.length(iss::Isotopes) = length(iss.isotopes)
Base.iterate(iss::Isotopes, state...) = iterate(iss.isotopes, state...)


# Isotope equality is determined by atomic number and isotope mass number
Base.isequal(is1::Isotope, is2::Isotope) = (i1.atomic_number, i1.mass_number) == (i1.atomic_number, i1.mass_number)

# There is no need to use all the data in Isotope to calculated the hash
# since Isotope equality is determined by atomic number and isotope mass number.
Base.hash(is::Isotope, h::UInt) = hash((is.atomic_number, is.mass_number), h)

# Compare isotopes by by atomic number and isotope mass number to produce the most common way isotopes
# are sorted.
Base.isless(is1::Isotope, is2::Isotope) = (i1.atomic_number, i1.mass_number) < (i1.atomic_number, i1.mass_number)

# Provide a simple way to iterate over all isotopes.
Base.eachindex(iss::Isotopes) = eachindex(iss.isotopes)
