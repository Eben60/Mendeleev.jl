"""
    ChemElem
This struct's fields correspond to only the most basic data pertaining to a chemical element, 
all other data being accessed via properties.
It is exported.
```
    atomic_number::Int
    name::String
    symbol::Symbol
```
"""
struct ChemElem
    atomic_number::Int
    name::String
    symbol::Symbol
end
