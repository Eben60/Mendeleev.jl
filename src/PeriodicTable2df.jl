# module PT
#
using PeriodicTable, DataFrames

fnms = fieldnames(eltype(elements))

nt(e) = NamedTuple([f => getfield(e, f) for f in fnms])
dfpt = DataFrame(nt.(elements))

function ptnames()
    for n in fnms
        print(n, " ; ")
    end
end
