# push!(LOAD_PATH,"../src/")
using Pkg

Pkg.activate("docs")

using Documenter, Mendeleev

# generate documentation locally. 
# keep in mind .gitignore - deps/deps.jl
makedocs(
    modules = [Mendeleev],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Eben60",
    sitename = "Mendeleev.jl",
    pages = Any["Home" => "index.md", "Elements Data Fields" => "elements_data_fields.md", "Types" => "types.md", "Changelog" => "changelog.md"],
    checkdocs = :exports, 
    warnonly = [:missing_docs],
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)
;

# depoloyment done on the server anyway
# don't normally run deploydocs here
deploydocs(
    repo = "github.com/Eben60/Mendeleev.jl.git",
    versions = nothing,
    push_preview = true
)
