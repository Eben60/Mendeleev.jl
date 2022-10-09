using Pkg, Coverage
Pkg.test("Mendeleev"; coverage=true)

srcfolder = normpath(@__DIR__, "../../src")
coverage = process_folder(srcfolder)

open("lcov.info", "w") do io
    LCOV.write(io, coverage)
end;

# coverage = merge_coverage_counts(coverage, filter!(
#     let prefixes = (joinpath(pwd(), "src", ""),
#                     joinpath(pwd(), "deps", ""))
#         c -> any(p -> startswith(c.filename, p), prefixes)
#     end,
#     LCOV.readfolder("test")))
# #

# @show get_summary(process_file(joinpath("src", "Mendeleev.jl")))