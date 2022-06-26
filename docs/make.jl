using Documenter, Mendeleev

makedocs(
    modules = [Mendeleev],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Eben60",
    sitename = "Mendeleev.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/Eben60/Mendeleev.jl.git",
    push_preview = true
)
