

function ispresent() end

# these functions are calculated properties
# the function name consists of the prefix fn_ and the property name

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
