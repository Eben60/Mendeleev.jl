using Mendeleev

Fe = chem_elements[:Fe]

function most_abundant_is(e) 
    abuns = [i.abundance for i in e.isotopes]
    _, ix = findmax(abuns)
    return e.isotopes[ix]
end

function fn_mass_number(e)
    ismissing(e.isotopes) && return missing
    return most_abundant_is(e).mass_number
end

most_abundant_is(Fe)
fn_mass_number(Fe)