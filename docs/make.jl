push!(LOAD_PATH,"../src/")
using Konkan
using Documenter

DocMeta.setdocmeta!(Konkan, :DocTestSetup, :(using Konkan); recursive=true)

makedocs(;
    modules=[Konkan],
    sitename="Konkan.jl",
)

deploydocs(;
    repo="github.com/ashwani-rathee/Konkan.jl",
)