Base.show(io::IO, el::ChemElem) = print(io, "Element(", el.name, ')')

ispresent(x::Missing) = false
ispresent(x::Union{AbstractArray, AbstractString}) = !  isempty(x)
ispresent(x::Union{AbstractFloat, Quantity}) = ! isnan(x)
ispresent(x::Int) = x >= 0 # TODO check!
ispresent(x::Group_M) = true
ispresent(x::Isotopes) = true

function printpresent(io::IO, name, v, suffix=""; pad=16)
    if ispresent(v)
        println(io, lpad(name, pad), ": ", typeof(v) <: Quantity ? v.val : v, suffix)
    end
end

function Base.show(io::IO, ::MIME"text/plain", el::ChemElem)
    println(io, el.name, " (", el.symbol, "), number ", el.atomic_number, ':')
    printpresent(io, "category", el.category)
    printpresent(io, "atomic mass", el.atomic_mass, " u")
    printpresent(io, "natural isotopes", el.isotopes)
    printpresent(io, "density", el.density, " g/cm³")
    printpresent(io, "molar heat cap.", el.molar_heat, " J/mol⋅K")
    printpresent(io, "melting point", el.melt, " K")
    printpresent(io, "boiling point", el.boil, " K")
    printpresent(io, "phase", el.phase)
    printpresent(io, "shells", el.shells)
    printpresent(io, "e⁻-configuration", el.el_config)
    printpresent(io, "appearance", el.appearance)
    # printpresent(io, "color", el.color) # the field is present for Co only, and also redundant (s. appearance)
    printpresent(io, "summary", el.summary)
    printpresent(io, "CAS identifier", el.cas)
    printpresent(io, "discovered by", el.discovered_by)
    # printpresent(io, "named by", el.named_by)
    printpresent(io, "NIST webbook", el.nist_webbook_url)
    printpresent(io, "wikipedia URL", el.wikipedia)
    printpresent(io, "spectral image", el.spectral_img)
end

function printpresenthtml(io::IO, name, val, suffix="")
    if ispresent(val)
        println(io, "<tr><th>", name, "</th><td>", typeof(val) <: Quantity ? val.val : val, suffix, "</td></tr>")
    end
end

function Base.show(io::IO, ::MIME"text/html", el::ChemElem)
    println(io, "<style>")
    println(io, "th{text-align:right; padding:5px;}td{text-align:left; padding:5px}")
    println(io, "</style>")
    println(io, el.name, " (", el.symbol, "), number ", el.atomic_number, ':')
    println(io, "<table>")
    printpresenthtml(io, "category", el.category)
    printpresenthtml(io, "atomic mass", el.atomic_mass, " u")
    printpresenthtml(io, "natural isotopes", el.isotopes)
    printpresenthtml(io, "density", el.density, " g/cm³")
    printpresenthtml(io, "molar heat cap.", el.molar_heat, " J/mol⋅K")
    printpresenthtml(io, "melting point", el.melt, " K")
    printpresenthtml(io, "boiling point", el.boil, " K")
    printpresenthtml(io, "phase", el.phase)
    printpresenthtml(io, "shells", el.shells)
    printpresenthtml(io, "e⁻-configuration", el.el_config)
    printpresenthtml(io, "appearance", el.appearance)
    printpresenthtml(io, "summary", el.summary)
    printpresenthtml(io, "CAS identifier", el.cas)
    printpresenthtml(io, "spectral image", el.spectral_img)
    printpresenthtml(io, "discovered by", el.discovered_by)
    link_wiki = string("<a href=\"", el.wikipedia, "\">", el.wikipedia, "</a>")
    printpresenthtml(io, "wikipedia", link_wiki)
    link_chemb = string("<a href=\"", el.nist_webbook_url, "\">", el.nist_webbook_url, "</a>")
    printpresenthtml(io, "NIST webbook", link_chemb)
    println(io, "</table>")

    if ispresent(el.spectral_img)
        width = 500
        file = replace(el.spectral_img, "https://en.wikipedia.org/wiki/File:" => "")
        #Wikimedia hotlinking api
        wm = "https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/"
        imgdomain = string(wm, file, "&width=$width")
        println(io, "<img src=\"", imgdomain, "\" alt=\"", file, "\">")
    end
end

Base.getindex(e::ChemElems, i::Integer) = e.data[e.bynumber[i]]
Base.getindex(e::ChemElems, i::AbstractString) = e.data[e.byname[lowercase(i)]]
Base.getindex(e::ChemElems, i::Symbol) = e.data[e.bysymbol[i]]
Base.getindex(e::ChemElems, v::AbstractVector) = ChemElem[e[i] for i in v]
Base.haskey(e::ChemElems, i::Integer) = haskey(e.bynumber, i)
Base.haskey(e::ChemElems, i::AbstractString) = haskey(e.byname, lowercase(i))
Base.haskey(e::ChemElems, i::Symbol) = haskey(e.bysymbol, i)

# TODO or not TODO
# actually I don't see any need for get with default value
# get(::ChemElem, ::Int64, ::ChemElem)
# @test_broken F === get(chem_elements, 9, O) === get(chem_elements, "oops", F) === get(chem_elements, :F, O)
# Base.get(e::ChemElems, i::Integer, default) = get(e.data[e.bynumber[i]], i, default)
# Base.get(e::ChemElems, i::AbstractString, default) = get(e.data[e.byname[i]], lowercase(i), default)
# Base.get(e::ChemElems, i::Symbol, default) = get(e.data[e.bysymbol[i]], i, default)

# support iterating over ChemElems
Base.eltype(e::ChemElems) = ChemElem
Base.length(e::ChemElems) = length(e.data)
Base.iterate(e::ChemElems, state...) = iterate(e.data, state...)

# compact one-line printing
Base.show(io::IO, e::ChemElems) = print(io, "Elements(…", length(e), " elements…)")

# pretty-printing as a periodic table
function Base.show(io::IO, ::MIME"text/plain", e::ChemElems)
     println(io, e, ':')
     table = fill("   ", 10,18)
     for el in e
         table[el.ypos, el.xpos] = rpad(el.symbol, 3)
     end
     for i = 1:size(table,1)
         for j = 1:size(table, 2)
             print(io, table[i,j])
         end
         println(io)
     end
end

# Since Element equality is determined by atomic number alone...
Base.isequal(elm1::ChemElem, elm2::ChemElem) = elm1.atomic_number == elm2.atomic_number

# There is no need to use all the data in Element to calculated the hash
# since Element equality is determined by atomic number alone.
Base.hash(elm::ChemElem, h::UInt) = hash(elm.atomic_number, h)

# Compare elements by atomic number to produce the most common way elements
# are sorted.
Base.isless(elm1::ChemElem, elm2::ChemElem) = elm1.atomic_number < elm2.atomic_number

# Provide a simple way to iterate over all elements.
Base.eachindex(elms::ChemElems) = eachindex(elms.data)

function getprop_unitless(e::ChemElem, s::Symbol)
    s in fieldnames(ChemElem)  && return getfield(e, s)
    haskey(elements_data, s) && return elements_data[s][e.atomic_number]
    s in calculated_properties && return eval(property_fns[s])(e)
    haskey(synonym_fields, s) && return getproperty(e, synonym_fields[s])

    throw(DomainError(s, "nonexistent ChemElem property"))
end

function Base.getproperty(e::ChemElem, s::Symbol)
    p = getprop_unitless(e::ChemElem, s::Symbol)
    haskey(f_units, s) && return p * f_units[s]
    return p
end

Base.propertynames(e::ChemElem) = sort(collect(union(keys(synonym_fields), keys(elements_data), calculated_properties, fieldnames(ChemElem))))
Base.hasproperty(e::ChemElem, p::Symbol) = p in propertynames(e)