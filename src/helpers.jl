"""
    struc2tup(s, i=typemax(Int))
A helper function, converting (at most the first i) fields of the type f into a tuple

# Examples
```julia-repl
julia> r = 1//2; struc2tup(r)
(1, 2)
julia> r = 1//2; struc2tup(r, 1)
(1,)
```
"""
function struc2tup(s, i=typemax(Int))
    fs = fieldnames(typeof(s))
    if length(fs) > i
        fs = fs[1:i]
    end
    return Tuple(getfield(s, f) for f in fs)
end

s2t_isless(s1, s2, i=typemax(Int)) = isless(struc2tup(s1, i), struc2tup(s2, i))
