# (re)start Julia first
using Pkg

Pkg.activate("MendUp")
include("MendUp.jl")

(; els_data, paths) = MendUp.mend_upd(;ret=true);
MendUp.load_Mendeleev()
(;not_doc, not_impl) = MendUp.checkdocs(paths)
@show not_doc
@show not_impl

;