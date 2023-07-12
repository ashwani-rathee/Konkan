using Perspective
using Documenter

DocMeta.setdocmeta!(Perspective, :DocTestSetup, :(using Perspective); recursive=true)

makedocs(;
    modules=[Perspective],
    authors="ashwani rathee <ab669522@gmail.com> and contributors",
    repo="https://github.com/ashwani-rathee/Perspective.jl/blob/{commit}{path}#{line}",
    sitename="Perspective.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://ashwani-rathee.github.io/Perspective.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ashwani-rathee/Perspective.jl",
    devbranch="master",
)
