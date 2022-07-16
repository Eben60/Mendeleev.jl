
Base.show(io::IO, el::E) where E<: Union{Element, Element_M} = print(io, "Element(", el.name, ')')

ispresent(x) = !(isempty(x) && ismissing(x))
ispresent(x::Union{Float64, Quantity}) = !isnan(x)
ispresent(n::Int) = n ≥ 0
function printpresent(io::IO, name, v, suffix=""; pad=16)
    if ispresent(v)
        println(io, lpad(name, pad), ": ", typeof(v) <: Quantity ? v.val : v, suffix)
    end
end

function Base.show(io::IO, ::MIME"text/plain", el::E)  where E<: Union{Element, Element_M}
    println(io, el.name, " (", el.symbol, "), number ", el.number, ':')
    printpresent(io, "category", el.category)
    printpresent(io, "atomic mass", el.atomic_mass, " u")
    printpresent(io, "density", el.density, " g/cm³")
    printpresent(io, "molar heat", el.molar_heat, " J/mol⋅K")
    printpresent(io, "melting point", el.melt, " K")
    printpresent(io, "boiling point", el.boil, " K")
    printpresent(io, "phase", el.phase)
    printpresent(io, "shells", el.shells)
    printpresent(io, "e⁻-configuration", el.el_config)
    printpresent(io, "appearance", el.appearance)
    printpresent(io, "color", el.color)
    printpresent(io, "summary", el.summary)
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

function Base.show(io::IO, ::MIME"text/html", el::E)  where E<: Union{Element, Element_M}
    println(io, "<style>")
    println(io, "th{text-align:right; padding:5px;}td{text-align:left; padding:5px}")
    println(io, "</style>")
    println(io, el.name, " (", el.symbol, "), number ", el.number, ':')
    println(io, "<table>")
    printpresenthtml(io, "category", el.category)
    printpresenthtml(io, "atomic mass", el.atomic_mass, " u")
    printpresenthtml(io, "density", el.density, " g/cm³")
    printpresenthtml(io, "molar heat", el.molar_heat, " J/mol⋅K")
    printpresenthtml(io, "melting point", el.melt, " K")
    printpresenthtml(io, "boiling point", el.boil, " K")
    printpresenthtml(io, "phase", el.phase)
    printpresenthtml(io, "shells", el.shells)
    printpresenthtml(io, "electron configuration", el.el_config)
    printpresenthtml(io, "appearance", el.appearance)
    printpresenthtml(io, "color", el.color)
    printpresenthtml(io, "summary", el.summary)
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
