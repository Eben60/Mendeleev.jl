# push!(LOAD_PATH,"../src/")
using Documenter, Mendeleev

makedocs(
    modules = [Mendeleev],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Eben60",
    sitename = "Mendeleev.jl",
    pages = Any["Home" => "index.md", "Elements Data Fields" => "elements_data_fields.md", "Types" => "types.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/Eben60/Mendeleev.jl.git",
    versions = nothing,
    push_preview = true
)
