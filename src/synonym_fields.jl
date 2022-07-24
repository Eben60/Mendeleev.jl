# TODO rename :source to :wikipedia

const synonym_fields = Dict(
    :atomic_mass => :atomic_weight,
    :boil => :boiling_point,
    :cpk_hex => :cpk_color,
    # :discovered_by => :discoverers, # calculated
    :melt => :melting_point,
    :number => :atomic_number,
    :molar_heat => :molar_heat_capacity
    )

const calculated_properties = [:discovered_by,]

fname2prop(s::Symbol) = Symbol("fn_$s")


property_fns = Dict([p => fname2prop(p) for p in calculated_properties])
