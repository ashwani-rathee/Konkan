@testset "projection.jl" begin

    @testset "image_point" begin
        img_point = image_point((5.0, 5.0, 5.0), 5.0)
        @test typeof(img_point) == NTuple{3, Float64}
        @test img_point == (5.0,5.0,5.0)
    end

    @testset "project_multiple_points" begin
        img_points = project_multiple_points(map((x,y)->(x, y, round(exp(x^2+y^2), digits=2)), -1.0:0.5:1.0, -1.0:0.5:1.0), -2.0)
        @test typeof(img_points) == Array{NTuple{3, Float64}, 1}
        @test img_points == Vector{Tuple{Float64, Float64, Float64}}(
            [(0.27, 0.27, -2.0),
             (0.61, 0.61, -2.0),
             (-0.0, -0.0, -2.0),
             (-0.61, -0.61, -2.0),
            (-0.27, -0.27, -2.0)])
    end
    
end