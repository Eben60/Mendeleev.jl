

function ispresent() end

# these functions are calculated properties
# the function name consists of the prefix fn_ and the property name
"""
    fn_discovered_by(e::ChemElem)
Returns a string with information (if available) about the year of discovery, names of discoverers, and discovery location
"""
function fn_discovered_by(e)
    knwn = r"^\s*Known"i
    yr = e.discovery_year
    ds = e.discoverers
    lcn = e.discovery_location
    d_yr = ispresent(yr) ? "$yr " : ""
    d_lcn = ispresent(lcn) ? "in $lcn" : ""
    if ispresent(ds)
        if occursin(knwn, ds)
            d_ds = "$ds "
        else
            d_ds = "by $ds "
        end
    else
        d_ds = ""
    end

    return join([d_yr, d_ds, d_lcn], "")
end

# fn_number(e) = e.atomic_number

fn_series(e) = seriesnames[e.series_id]

fn_group(e) = groups_m[e.group_id]

fn_oxistates(e) = oxistates_data[e.atomic_number]

fn_ionenergy(e) = ionization_data[e.atomic_number]

function fn_sconst(e)
    n = e.atomic_number
    ! haskey(screenings_data, n) && return missing
    return screenings_data[n]
end

fn_isotopes(e) = isotopes_data[e.atomic_number]

fn_electrons(e) = e.atomic_number
fn_protons(e) = e.atomic_number

function most_abundant_is(e) 
    abuns = [i.abundance for i in e.isotopes]
    _, ix = findmax(abuns)
    return e.isotopes[ix]
end

"""
    fn_mass_number(e::ChemElem)
Return the mass number of the most abundant isotope, if there are any stable isotopes for this element.
Otherwise returns `missing`
"""
function fn_mass_number(e)
    ismissing(e.isotopes) && return missing
    return most_abundant_is(e).mass_number
end

"""
fn_neutrons(e::ChemElem)
Return the number of neutrons for the most abundant isotope, if there are any stable isotopes for this element.
Otherwise returns `missing`
"""
fn_neutrons(e) = e.mass_number - e.atomic_number

fn_ionic_radii(e) = IonicRadii(e)

fn_eneg(e) = Electronegativities(e.atomic_number)

fn_inchi(e) = "InchI=1S/$(e.symbol)"

fn_electrophilicity(e) = electrophilicities[e.atomic_number]

