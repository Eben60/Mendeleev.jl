# # unused in program
# PeriodicTableFields = (:name, :appearance, :atomic_mass, :boil, :category, :color, :cpk_hex,
# :density, :discovered_by, :el_config, :melt, :molar_heat, :named_by, :number,
# :period, :phase, :source, :spectral_img, :summary, :symbol, :xpos, :ypos, :shells)

const properties2omit = [:color, :named_by, :discovered_by]
const properties2rename = [:source => :wikipedia, :number => :atomic_number,]
const calculated_properties = [:discovered_by, :series, :group, :oxistates, 
    :sconst, :ionenergy, :isotopes, :mass_number, :electrons, :neutrons, 
    :protons, :ionic_radii, :eneg, :inchi, :electrophilicity]

const synonym_fields = Dict(
    :atomic_mass => :atomic_weight,
    :boil => :boiling_point,
    :cpk_hex => :cpk_color,
    # :discovered_by => :discoverers, # calculated
    :melt => :melting_point,
    :molar_heat => :molar_heat_capacity,
    :name => :name,
    :density => :density,
    :period => :period,
    :symbol => :symbol,
    :number => :atomic_number
    )

fname2prop(s::Symbol) = eval(Symbol("fn_$s"))

const property_fns = Dict{Symbol, Function}([p => fname2prop(p) for p in calculated_properties])
