Base.show(io::IO, el::Element_M) = print(io, "Element(", el.name, ')')

ispresent(x) = !(isempty(x) && ismissing(x))
ispresent(x::Union{Float64, Quantity}) = !isnan(x)
ispresent(n::Int) = n ≥ 0
function printpresent(io::IO, name, v, suffix=""; pad=16)
    if ispresent(v)
        println(io, lpad(name, pad), ": ", typeof(v) <: Quantity ? v.val : v, suffix)
    end
end

function Base.show(io::IO, ::MIME"text/plain", el::Element_M)
    println(io, el.name, " (", el.symbol, "), number ", el.number, ':')
    printpresent(io, "category", el.category)
    printpresent(io, "atomic mass", el.atomic_mass, " u")
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
    printpresent(io, "named by", el.named_by)
    printpresent(io, "source", el.source)
    printpresent(io, "spectral image", el.spectral_img)
end

function printpresenthtml(io::IO, name, val, suffix="")
    if ispresent(val)
        println(io, "<tr><th>", name, "</th><td>", typeof(val) <: Quantity ? val.val : val, suffix, "</td></tr>")
    end
end

function Base.show(io::IO, ::MIME"text/html", el::Element_M)
    println(io, "<style>")
    println(io, "th{text-align:right; padding:5px;}td{text-align:left; padding:5px}")
    println(io, "</style>")
    println(io, el.name, " (", el.symbol, "), number ", el.number, ':')
    println(io, "<table>")
    printpresenthtml(io, "category", el.category)
    printpresenthtml(io, "atomic mass", el.atomic_mass, " u")
    printpresenthtml(io, "density", el.density, " g/cm³")
    printpresenthtml(io, "molar heat cap.", el.molar_heat, " J/mol⋅K")
    printpresenthtml(io, "melting point", el.melt, " K")
    printpresenthtml(io, "boiling point", el.boil, " K")
    printpresenthtml(io, "phase", el.phase)
    printpresenthtml(io, "shells", el.shells)
    printpresenthtml(io, "electron configuration", el.el_config)
    printpresenthtml(io, "appearance", el.appearance)
    # printpresenthtml(io, "color", el.color)  # the field is present for Co only, and also redundant (s. appearance)
    printpresenthtml(io, "summary", el.summary)
    printpresenthtml(io, "CAS identifier", el.cas)
    printpresenthtml(io, "discovered by", el.discovered_by)
    printpresenthtml(io, "named by", el.named_by)

    link = string("<a href=\"", el.source, "\">", el.source, "</a>")
    printpresenthtml(io, "source", link)
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

Base.getindex(e::Elements_M, i::Integer) = e.bynumber[i]
Base.getindex(e::Elements_M, i::AbstractString) = e.byname[lowercase(i)]
Base.getindex(e::Elements_M, i::Symbol) = e.bysymbol[i]
Base.getindex(e::Elements_M, v::AbstractVector) = Element_M[e[i] for i in v]
Base.haskey(e::Elements_M, i::Integer) = haskey(e.bynumber, i)
Base.haskey(e::Elements_M, i::AbstractString) = haskey(e.byname, lowercase(i))
Base.haskey(e::Elements_M, i::Symbol) = haskey(e.bysymbol, i)
Base.get(e::Elements_M, i::Integer, default) = get(e.bynumber, i, default)
Base.get(e::Elements_M, i::AbstractString, default) = get(e.byname, lowercase(i), default)
Base.get(e::Elements_M, i::Symbol, default) = get(e.bysymbol, i, default)

# support iterating over Elements_M
Base.eltype(e::Elements_M) = Element_M
Base.length(e::Elements_M) = length(e.data)
Base.iterate(e::Elements_M, state...) = iterate(e.data, state...)

 # compact one-line printing
 Base.show(io::IO, e::Elements_M) = print(io, "Elements(…", length(e), " elements…)")

 # pretty-printing as a periodic table
 function Base.show(io::IO, ::MIME"text/plain", e::Elements_M)
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
 Base.isequal(elm1::Element_M, elm2::Element_M) = elm1.number == elm2.number

 # There is no need to use all the data in Element to calculated the hash
 # since Element equality is determined by atomic number alone.
 Base.hash(elm::Element_M, h::UInt) = hash(elm.number, h)

 # Compare elements by atomic number to produce the most common way elements
 # are sorted.
 Base.isless(elm1::Element_M, elm2::Element_M) = elm1.number < elm2.number

 # Provide a simple way to iterate over all elements.
 Base.eachindex(elms::Element_M) = eachindex(elms.data)

 function Base.getproperty(e::Element_M, s::Symbol)
      s in keys(synonym_fields) && return getfield(e, synonym_fields[s])
      s in fieldnames(Element_M)  && return getfield(e, s)
      # in case it is a field of PeriodicTable elements only
      no = getfield(e, :atomic_number)
      e_pt = elements[no]
      return getfield(e_pt, s)
  end
