module PT

using PeriodicTable, DataFrames

const fs = fieldnames(eltype(elements))

nt(e) = NamedTuple([f => getfield(e, f) for f in fs])
dfpt = DataFrame(nt.(elements))

end
