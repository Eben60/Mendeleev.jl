function ispresent() end

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

fn_number(e) = e.atomic_number

fn_series(e) = seriesnames[e.series]
