"""
    Isotope
This struct describes a single isotope. Only naturally occuring stable or almost stable isotopes are included.
It is not exported.
```
    atomic_number::Int
    mass_number::Int
    mass::typeof(1.0*u"u")
    abundance::Float64
```    
"""
struct Isotope
    atomic_number::Int
    mass_number::Int
    mass::typeof(1.0*u"u")
    abundance::Float64
end

Isotope(atomic_number, mass_number, mass::Float64, abundance) =
    Isotope(atomic_number, mass_number, mass*u"u", abundance)


"""
    Isotopes
This struct is a container for isotopes of an element. It provides access only by 
position(s) in the array of the (stable or almost stable) isotopes of this elements.
More comprehensive isotopes data is published in a separate package `IsotopeTable.jl`. 
It is not exported.
"""   
struct Isotopes
    isotopes::Vector{Isotope}
end

Base.getindex(iss::Isotopes, i::Integer) = iss.isotopes[i]
Base.getindex(iss::Isotopes, v::AbstractVector) = [iss[i] for i in v]


# support iterating over Isotopes
Base.eltype(iss::Isotopes) = Isotope
Base.length(iss::Isotopes) = length(iss.isotopes)
Base.iterate(iss::Isotopes, state...) = iterate(iss.isotopes, state...)


# Isotope equality is determined by atomic number and isotope mass number
Base.isequal(is1::Isotope, is2::Isotope) = (is1.atomic_number, is1.mass_number) == (is2.atomic_number, is2.mass_number)


# Compare isotopes by by atomic number and isotope mass number to produce the most common way isotopes
# are sorted.
Base.isless(is1::Isotope, is2::Isotope) = (is1.atomic_number, is1.mass_number) < (is2.atomic_number, is2.mass_number)

# Provide a simple way to iterate over all isotopes.
Base.eachindex(iss::Isotopes) = eachindex(iss.isotopes)


function Base.show(io::IO, iss::Isotopes)
    is_strings = [string(is) for is in iss]
    print(io, "(", join(is_strings, ", "), ")")
    return nothing
end

function subsuperchar(c, sub)
    subscripts = Dict(
        '0' => '₀',
        '1' => '₁',
        '2' => '₂',
        '3' => '₃',
        '4' => '₄',
        '5' => '₅',
        '6' => '₆',
        '7' => '₇',
        '8' => '₈',
        '9' => '₉',
    )

    superscripts = Dict(
        '0' => '⁰',
        '1' => '¹',
        '2' => '²',
        '3' => '³',
        '4' => '⁴',
        '5' => '⁵',
        '6' => '⁶',
        '7' => '⁷',
        '8' => '⁸',
        '9' => '⁹',
    )
    if sub
        return subscripts[c]
    else
        return superscripts[c]
    end
end

function subsuperstring(x, sub=false)
    s = string(x)
    carr = [subsuperchar(c, sub) for c in s]
    return join(carr, "")
end

function Base.show(io::IO, is::Isotope)
    sym = chem_elements[is.atomic_number].symbol |> string
    mass_no_superscript = subsuperstring(is.mass_number)

    print(io, "($((is.abundance)*100)% $mass_no_superscript$sym m=$(is.mass) )")
    return nothing
end
