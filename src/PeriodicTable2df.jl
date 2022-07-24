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

rename!(dfpt, properties2rename)

toexclude = unique(vcat(collect(keys(synonym_fields)), calculated_properties, properties2omit))

select!(dfpt, Not(toexclude))
