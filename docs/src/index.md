
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Mendeleev.jl

A package for accessing chemical elements data. It's code was initially based on [PeriodicTable](https://github.com/JuliaPhysics/PeriodicTable.jl) Julia package, whereas the data come mainly from the Python [mendeleev](https://github.com/lmmentel/mendeleev) package. It can be used as a replacement for [PeriodicTable](https://github.com/JuliaPhysics/PeriodicTable.jl).

## Installation
As usual
```julia
] add Mendeleev
```

## Intentions
The aim was to have a package compatible with `PeriodicTable` as possible, but with much more comprehensive data 
from possibly reliable and traceable sources. The package should still be possibly lightweight like `PeriodicTable`. `Mendeleev`, like it's predessor, has only one direct dependence (`Unitful`), keeps data in static form, and takes about the same time to load (about half a second on a medium-range medium-aged notebook). See below for compatibility details.

Another aim was to make it easier to update data. Most data are read out from the (Python) `mendeleev` database by a separate external skript and converted to static Julia code, which further can be relatively straightforwardly edited, should that be necessary.

## Usage
Mendeleev.jl provides a Julia interface to a database of element
properties for all of the elements in the periodic table. In particular `Mendeleev` exports a global variable called `chem_elements`, which is a collection of
`ChemElem` data structures.

```julia
julia> using Mendeleev

julia> chem_elements
Elements(…118 elements…):
H                                                  He
Li Be                               B  C  N  O  F  Ne
Na Mg                               Al Si P  S  Cl Ar
K  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr
Rb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe
Cs Ba    Hf Ta W  Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn
Fr Ra    Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og
Uue                                                   
      La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu    
      Ac Th Pa U  Np Pu Am Cm Bk Cf Es Fm Md No Lr
```

You can look up elements by name (case-insensitive)
via `chem_elements["oxygen"]`, by symbol via `chem_elements[:O]`, or by number via
`chem_elements[8]`, for example.


All physical quantities are [unitful](https://painterqubits.github.io/Unitful.jl).

The data is pretty-printed when you look up an element in the Julia REPL.
For example:
```julia
julia> chem_elements["oxygen"]
Oxygen (O), number 8:
        category: diatomic nonmetal
     atomic mass: 15.999 u
natural isotopes: ((99.738% ¹⁶O m=15.99491462 u ), (0.04% ¹⁷O m=16.999131757 u ), (0.222% ¹⁸O m=17.999159613 u ))
         density: 0.001308 g/cm³
 molar heat cap.: 29.378 J/mol⋅K
   melting point: 54.8 K
   boiling point: 90.19 K
           phase: Gas
          shells: [2, 6]
e⁻-configuration: 1s² 2s² 2p⁴
         summary: Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.
  CAS identifier: 7782-44-7
   discovered by: 1774 by Joseph Priestly, Carl Wilhelm Scheele in England/Sweden
    NIST webbook: https://webbook.nist.gov/cgi/inchi/InChI%3D1S/O2/c1-2
   wikipedia URL: https://en.wikipedia.org/wiki/Oxygen
  spectral image: https://en.wikipedia.org/wiki/File:Oxygen_spectre.jpg

```

Alternatively, you may want to get a list of elements,
```julia
julia> chem_elements[1:4]
4-element Vector{ChemElem}:
    Element(Hydrogen)
    Element(Helium)
    Element(Lithium)
    Element(Beryllium)

```

## Data by
The data used for this package has been pulled up mainly from [mendeleev](https://github.com/lmmentel/mendeleev) by [Lukasz Mentel](https://github.com/lmmentel). See [mendeleev documentation](https://mendeleev.readthedocs.io/en/stable/data.html) for the data sources. Some information (but no physical quantities) taken over from [PeriodicTable.jl](https://github.com/JuliaPhysics/PeriodicTable.jl), which was in turn taken mostly from [here](https://github.com/Bowserinator/Periodic-Table-JSON).

##  List of `ChemElement` properties: 

* [Elements Data Fields](./elements_data_fields.md)

## Types and Functions
```@autodocs
Modules = [Mendeleev]
Order   = [:type, :function]
```

## Compatibility Issues
`PeriodicTable.jl` exports global variable called `elements`, which is a collection of `Element` data structures.
In `Mendeleev.jl` these called correspondingly `chem_elements` and `ChemElem`, the word "element" having too much 
meanings IMO. For legacy application you however still may use the old names:

```julia
julia> using Mendeleev: elements, Element
```

One property (`source`) got a different meaning, one (`color`) was omitted completely, and one (`named_by`) are omitted, but there exist similar property. For details, see _Elements Data_ section. 

Missing data were encoded in the `PeriodicTable.jl` resp. by empty strings and by `NaN`, as the package predates introduction of `Missing`. Here, we are using `Missing`.

## Developed by
* [Eben60](https://github.com/Eben60)

## Credits
Developers of `PeriodicTable.jl`
* [Rahul Lakhanpal](https://www.rahullakhanpal.in)
* [Steven G. Johnson](https://github.com/stevengj)
* [Jacob Wikmark](https://github.com/lancebeet)
* [Carsten Bauer](https://github.com/crstnbr)

Some data originally from 
* [here](https://github.com/Bowserinator/Periodic-Table-JSON)

Most data from 
[mendeleev](https://github.com/lmmentel/mendeleev) by [Lukasz Mentel](https://github.com/lmmentel)

_Wikipedia_ and _CRC Handbook of Chemistry and Physics (ISBN 9781482208689)_ were the most used primary data sources for _words, words, words_ and for _numbers_, respectively. 