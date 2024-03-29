﻿[Table of contents](./index.md)
# Elements Data
========

## The following data are from [mendeleev](https://mendeleev.readthedocs.io/en/stable/data.html) (see there for data sources):

| Name                            | Comment                                              |
|---------------------------------|------------------------------------------------------|
| `abundance_crust`               | Abundance in the Earth's crust                       |
| `abundance_sea`                 | Abundance in the seas                                |
| `annotation`                    | Annotations regarding the data                       |
| `atomic_number`                 | Atomic number                                        |
| `atomic_radius`                 | Atomic radius                                        |
| `atomic_radius_rahm`            | Atomic radius by Rahm et al.                         |
| `atomic_volume`                 | Atomic volume                                        |
| `atomic_weight`                 | Atomic weight                                        |
| `atomic_weight_uncertainty`     | Atomic weight uncertainty                            |
| `block`                         | Block in periodic table                              |
| `boiling_point`                 | Boiling temperature [^1]                             |
| `c6`                            | C_6 dispersion coefficient in a.u.                   |
| `c6_gb`                         | C_6 dispersion coefficient in a.u. (Gould & Bučko)   |
| `cas`                           | Chemical Abstracts Serice identifier                 |
| `covalent_radius_bragg`         | Covalent radius by Bragg                             |
| `covalent_radius_cordero`       | Covalent radius by Cerdero et al.                    |
| `covalent_radius_pyykko`        | Single bond covalent radius by Pyykko et al.         |
| `covalent_radius_pyykko_double` | Double bond covalent radius by Pyykko et al.         |
| `covalent_radius_pyykko_triple` | Triple bond covalent radius by Pyykko et al.         |
| `cpk_color`                     | Element color in CPK convention                      |
| `critical_pressure`             | Critical pressure [^1]                               |
| `critical_temperature`          | Critical temperature [^1]                            |
| `density`                       | Density at 295K [^2]                                 |
| `description`                   | Short description of the element                     |
| `dipole_polarizability`         | Dipole polarizability                                |
| `dipole_polarizability_unc`     | Dipole polarizability uncertainty                    |
| `discoverers`                   | The discoverers of the element                       |
| `discovery_location`            | The location where the element was discovered        |
| `discovery_year`                | The year the element was discovered                  |
| `electron_affinity`             | Electron affinity                                    |
| `electrons`                     | Number of electrons                                  |
| `electrophilicity`              | Electrophilicity index                               |
| `electronic_configuration`      | Ground state electron configuration (see also `el_config`)    |
| `eneg`                          | Electronegativities. Returns `Electronegativities` type   |
| `evaporation_heat`              | Evaporation heat                                     |
| `fusion_heat`                   | Fusion heat                                          |
| `gas_basicity`                  | Gas basicity                                         |
| `geochemical_class`             | Geochemical classification                           |
| `glawe_number`                  | Glawe's number (scale)                               |
| `goldschmidt_class`             | Goldschmidt classification                           |
| `group`                         | Group in periodic table                              |
| `heat_of_formation`             | Heat of formation                                    |
| `inchi`                         | International Chemical Identifier                    |
| `ionenergy`                     | Ionization energies                                  |
| `ionic_radii`                   | Ionic and crystal radii                              |
| `is_monoisotopic`               | Is the element monoisotopic                          |
| `is_radioactive`                | Is the element radioactive                           |
| `isotopes`                      | Isotopes [^3] . Returns `Isotopes` type              |
| `jmol_color`                    | Element color in Jmol convention                     |
| `lattice_constant`              | Lattice constant                                     |
| `lattice_structure`             | Lattice structure code                               |
| `mass_number`                   | Mass number (most abundant isotope)                  |
| `melting_point`                 | Melting temperature [^1]                              |
| `mendeleev_number`              | Mendeleev's number                                   |
| `metallic_radius`               | Single-bond metallic radius                          |
| `metallic_radius_c12`           | Metallic radius with 12 nearest neighbors            |
| `molar_heat_capacity`           | Molar heat capacity @ 25 C, 1 bar                    |
| `molcas_gv_color`               | Element color in MOCAS GV convention                 |
| `name`                          | Name in English                                      |
| `name_origin`                   | Origin of the name                                   |
| `neutrons`                      | Number of neutrons (most abundant isotope)           |
| `oxistates`                     | Main oxidation states [^4]                           |
| `nist_webbook_url`              | URL for the NIST Chemistry WebBook                   |
| `period`                        | Period in periodic table                             |
| `pettifor_number`               | Pettifor scale                                       |
| `proton_affinity`               | Proton affinity                                      |
| `protons`                       | Number of protons                                    |
| `sconst`                        | Nuclear charge screening constants. Returns `ScreenConstants` type.       |
| `series`                        | Index to chemical series                             |
| `sources`                       | Sources of the element                               |
| `specific_heat_capacity`        | Specific heat capacity @ 25 C, 1 bar                 |
| `symbol`                        | Chemical symbol                                      |
| `thermal_conductivity`          | Thermal conductivity @25 C                           |
| `triple_point_pressure`         | Triple point pressure [^1]                     |
| `triple_point_temperature`      | Triple point temperature [^1]                     |
| `uses`                          | Applications of the element                          |
| `vdw_radius`                    | Van der Waals radius                                 |
| `vdw_radius_alvarez`            | Van der Waals radius according to Alvarez            |
| `vdw_radius_batsanov`           | Van der Waals radius according to Batsanov           |
| `vdw_radius_bondi`              | Van der Waals radius according to Bondi              |
| `vdw_radius_dreiding`           | Van der Waals radius from the DREIDING FF            |
| `vdw_radius_mm3`                | Van der Waals radius from the MM3 FF                 |
| `vdw_radius_rt`                 | Van der Waals radius according to Rowland and Taylor |
| `vdw_radius_truhlar`            | Van der Waals radius according to Truhlar            |
| `vdw_radius_uff`                | Van der Waals radius from the UFF                    |

### Electronegativities [^5] (type returned by `eneg` field):

| Name              | Comment                                 |
|-------------------|-----------------------------------------|
| `atomic_number`   | Atomic number                           |
| `Allen`           | Scale according to Allen                |
| `Allred`          | Scale of Allred-Rochow                  |
| `Cottrell`        | Scale of Cottrell-Sutton                |
| `Ghosh`           |                                         |
| `Gordy`           |                                         |
| `Martynov`        | Scale of Martynov-Batsanov              |
| `Mulliken`        |                                         |
| `Nagle`           |                                         |
| `Pauling`         |                                         |
| `Sanderson`       |                                         |
| `Li`              | Scale of Li-Xue. Returns `LiXue` type.  |

[^1]: For elements with several allotropes existing at the phase transition temperature, the phase transition data corresponding to the most common are reported, namely:  Antimony (gray), Carbon (graphite), Phosphorus (white), Selenium (gray), Sulfur (rhombic), Tin (white)

[^2]: For elements with several allotropes existing at room temperature, the density corresponding to the most common is reported, namely:  Antimony (gray), Berkelium (α form), Carbon (graphite), Phosphorus (white), Selenium (gray), Sulfur (rhombic), Tin (white)

[^3]: Only naturally occurring stable or "almost stable" isotopes are listed, and only mass and abundance data. For comprehensive information on isotopes, see [IsotopeTable](https://github.com/Gregstrq/IsotopeTable.jl). The `isotopes` property returns an `Isotopes` (see documentation for `Isotopes` and `Isotope` types).
   
[^4]: Retrieved by the package author mostly from Wikipedia - see comments in the source file `oxistates_data.jl`     

[^5]: See `mendeleev` [documentation](https://mendeleev.readthedocs.io/en/stable/electronegativity.html) for explanations and references

## Further properties, mostly from `PeriodicTable` (in part supported just for compatibility)

| Name           | Comment or synonym field                             |
|----------------|------------------------------------------------------|
| `appearance`   |           |
| `atomic_mass`  | -> `atomic_weight`          |
| `boil`         | -> `boiling_point`          |
| `category`     |           |
| `color`        |           |
| `cpk_hex`      | -> `cpk_color`          |
| `discovered_by` | year of discovery, names of discoverers, and discovery location |
| `el_config`    | electron configuration, another way          |
| `melt`         | -> `melting_point`          |
| `molar_heat`   | -> `molar_heat_capacity`          |
| `number`       | -> `atomic_number`          |
| `phase`        |           |
| `shells`       |           |
| `spectral_img` | Wikipedia picture URL          |
| `summary`      | Some arbitrary general information          |
| `xpos`         | x-position of the element in the Periodic Table          |
| `ypos`         | y-position (both used for pretty print only)          |
| `wikipedia`    | Wikipedia URL          |

## Properties from PeriodicTable omitted or changed in this package

| Name             | Comment                            |
|------------------|------------------------------------------------------|
| `color`          | see `appearance` (`color` was anyway missing for all elements but one)         |
| `named_by`       | see `name_origin`          |
| `source`         | was in all cases a Wikipedia link, thus renamed to `wikipedia` [^6] |


[^6]: In `PeriodicTable` the `source` field was the data source (which in all cases was a Wikipedia article on the element), whereas in (Python) `mendeleev` `sources` (plural) is the sources of the material substance. In this package the `source` field from `PeriodicTable` goes to `wikipedia` field.

