function maintype(t)
    !(t isa Union) && return t
    ts = Base.uniontypes(t)
    d=setdiff(ts, [Missing])
    @assert length(d)==1
    return collect(d)[1]
end

function unmiss(x, mt)
    ! ismissing(x) && return x
    mt == Int64 && return -9223372035824767958 # typemin(Int64) + Int64(rand(Int32))
    mt == Float64 && return NaN64
    mt == String && return ""
    return nothing
end

# mts = map(maintype, ctypes)
#
# unvs = [unmiss.(v, mts) for v in vs]
#
# EM = inst_elements(unvs)
