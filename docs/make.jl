push!(LOAD_PATH, "./src/")
using Documenter, FormulaNormalOrdering

makedocs(;
    modules = [FormulaNormalOrdering],
    sitename="FormulaNormalOrdering.jl",
    authors = "Jia-heng Ji",
    pages=["Home" => "index.md"],
    clean=true)