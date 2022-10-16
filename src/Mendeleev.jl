"""
    Mendeleev
Package package for accessing chemical elements data. Exports them as `chem_elements`, 
enabling access by name, symbol, or atomic number.
"""
module Mendeleev
using Unitful

include("units.jl")
include("seriesnames.jl")
include("oxistates_data.jl")
include("Group_M_def_data.jl")
include("screeniningconsts_def.jl")
include("screening_data.jl")
include("ionization_data.jl")
include("isotopes_def.jl")
include("isotopes_data.jl")
include("ChemElem_def.jl")
include("elements_data.jl")
include("ChemElems.jl")
include("ionrad_data.jl")
include("ionrad_def.jl")
include("elements_init.jl")
include("synonym_fields.jl")
include("property_functions.jl")
include("overloads.jl")


export ChemElem # struct definition
export chem_elements # all elements data

# import these explicitly for legacy (formerly PeriodicTable.jl based) applications
elements = chem_elements
Element = ChemElem 

els = chem_elements # import this short form if you like

end  # module Mendeleev
