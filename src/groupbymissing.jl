using .Mendeleev: els, vs, ctypes, inst_elements

function fingerprint(x)
    s = zero(UInt128)
    two = UInt128(2)
    for i in 1:length(x)
        if ismissing(x[i])
            s += two^i
        end
    end
    return s
end

fngs = [fingerprint(v) for v in vs]
sfng = Set(fngs)
@show sfng

for t in ctypes
    println(t)
end

function maintype(t)
    !(t isa Union) && return t
    ts = Base.uniontypes(t)
    d=setdiff(ts, [Missing])
    @assert length(d)==1
    return collect(d)[1]
end

mts = map(maintype, ctypes)

function unmiss(x, mt)
    ! ismissing(x) && return x
    mt == Int64 && return typemin(Int64)
    mt == Float64 && return NaN64
    mt == String && return ""
    return nothing
end

unvs = [unmiss.(v, mts) for v in vs]

EM = inst_elements(unvs)
