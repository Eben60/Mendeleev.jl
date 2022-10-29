"""
    Mendeleev
Package package for accessing chemical elements data. Exports them as `chem_elements`, 
enabling access by name, symbol, or atomic number.
"""
module Mendeleev
using Unitful, UnitfulAtomic

include("data.jl/units.jl")
include("data.jl/seriesnames.jl")
include("data.jl/oxistates_data.jl")
include("data.jl/eneg_data.jl")
include("data.jl/lixue_data.jl")
include("Group_M_def_data.jl")
include("screeniningconsts_def.jl")
include("data.jl/screening_data.jl")
include("data.jl/ionization_data.jl")
include("eneg_LiXue_def.jl")
include("electroneg_def.jl")
include("isotopes_def.jl")
include("data.jl/isotopes_data.jl")
include("ChemElem_def.jl")
include("data.jl/elements_data.jl")
include("ChemElems.jl")
include("data.jl/ionrad_data.jl")
include("ionrad_def.jl")
include("data.jl/elements_init.jl")
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
