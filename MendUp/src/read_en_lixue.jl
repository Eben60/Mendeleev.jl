module LiXue

const None = missing

function alllixue(lx)
    lx01 = lx[begin+1:end-1]
    curles = r"{(.*?)}"
    lx02 = replace(lx01, curles => s"Dict(\1)")
    lx03 = replace(lx02, "'" => "\"")
    lx04 = replace(lx03, ":" => "=>")
    lx05 = "Dict($lx04)"
    lx_e = eval(Meta.parse(lx05))
    return lx_e
end

function ntlx(d)
    d1 = Dict()
    for (key, val) in d
        # print(key, ", ")
        push!(d1, lixuelem(key, val) )
    end
    return d1
end

lixuelem(key, val) = (;atomic_number=key[2], charge=key[3], symbol=Symbol(key[1]), ) => lxelemdict(val)


function lxelemdict(d)
    d1 = Dict()
    for (key, val) in d
        push!(d1, lixueitem(key) => val)
    end
    return d1
end

lixueitem(x) = (; coord = x[1], spin = x[2]) 

# ks = sort!(collect(keys(d)))

elkeys(ks, i) = filter(x -> x.atomic_number==i, ks)

function elvec(d)
    ks = sort!(collect(keys(d)))
    v = []
    for i in 1:118
        elks = elkeys(ks, i)
        if length(elks) == 0
            push!(v, missing)
        else
            ed = Dict()
            for k in elks
                push!(ed, k.charge => d[k])
            end
            push!(v, ed)
        end
    end
    return v
end

function d2nt(d)
    v = []
    for (key, value) in d
        coord = key.coord
        spin = key.spin
        if ismissing(spin) || spin == ""
            spin = missing
        end
        push!(v, (;coord, spin, value))
    end
    return v
end

function dd2dnt(d)
    ismissing(d) && return missing
    d1 = copy(d)
    for (key, value) in d1
        d1[key] = d2nt(value)
    end
    return d1
end

sormiss(x) = ismissing(x) ? "missing" : ":$x"

nt2str(nt) = "(:$(nt.coord), $(sormiss(nt.spin)), $(nt.value))"

function vnt2str(vnt)
    vs = nt2str.(vnt)
    s = join(vs, ", ")
    return "[$s]"
end

function dnt2str(d)
    ismissing(d) && return "missing"
    nts = [(;key, val) for (key, val) in d]
    sort!(nts)
    s = ["$(nt.key) => $(vnt2str(nt.val))" for nt in nts]
    return "Dict($(join(s, ", ")))"
end

function writelx2jul(v, fl)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const lixue_data = [")
        for x in v
            println(io, "    $x")
        end
        println(io, "]")
    end
    return nothing
end

function lixuepy2jul(fin="lixue_data.txt", fout="lixue_data.jl"; w=true)
    fin = normpath(@__DIR__, "../data/", fin)
    fout = normpath(@__DIR__, "../data/", fout)
    if !(@isdefined lx_in)
        lx_in = read(fin, String)
    end
    lxs = alllixue(lx_in)
    d = ntlx(lxs)
    v = elvec(d)
    v1 = [dd2dnt(x) for x in v]
    v2 = dnt2str.(v1)
    w && writelx2jul(v2, fout)
    return (;d,v,v1,v2)
end 

end # module
;