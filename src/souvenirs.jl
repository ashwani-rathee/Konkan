# souvenir no. 1
function object_point(image_point::NTuple{3, Float64}, focal_length::Float64)::NTuple{3, Float64}
    return (image_point .* image_point[3]) ./ focal_length
end


"""
    plot(object_points::Array{NTuple{3, Float64}, 1}, focal_length::Float64)

Plots projection of multiple points given just object points and the focal length of the 
the pinhole camera used.

# Arguments
- `object_points::Array{NTuple{3, Float64}, 1}` : Points in the world
- `focal_length::Float64` : Focal length of the camera

# Example
```julia-repl
julia> using Konkan

julia> obj_points = map((x,y)->(x, y, round(exp(x^2+y^2), digits=2)), -1.0:0.1:1.0, -1.0:0.1:1.0)

julia> plot(obj_points, -2.0)
```
"""
function plot(object_points::Array{NTuple{3, Float64}, 1}, focal_length::Float64)
    image_points = project_multiple_points(object_points, focal_length)
    x1 = map(x->x[1], object_points)
    y1 = map(x->x[2], object_points)
    z1 = map(x->x[3], object_points)

    x = map(x->x[1], image_points)
    y = map(x->x[2], image_points)
    z = map(x->x[3], image_points)
    
    scene = Scene(; backgroundcolor=:grey)
    w, h = size(scene)
    sphere_plot = mesh!(scene, GLMakie.Sphere(Point3f(0), 0.1), color=:red)
    lines!(scene, Rect2f(Vec3f(-10,-10,0), Vec3f(20)), linewidth=0.5, color=:black)
    lines!(scene, Rect2f(Vec3f(0,-10,0), Vec3f(0,20,0)), linewidth=0.5, color=:black)
    lines!(scene, Rect2f(Vec3f(-10,0, 0), Vec3f(20,0,0)), linewidth=0.5, color=:black)
    lines!(scene, Rect2f(Vec3f(0,0,-10), Vec3f(0,0,20)), linewidth=0.5, color=:black)

    scatter!(scene, x1, y1, z1, color = :blue)
    lines!(scene, Rect3f(Vec3f(-5,-5,focal_length), Vec3f(10,10,0.01)), linewidth=0.5, color=:black)
    scatter!(scene, x, y, z, color = :red)

    cam = cam3d!(scene)
    c = cameracontrols(scene)
    c.eyeposition[] = [0,3,0]
    c.lookat[] = [0,0,0]
    update_cam!(scene)

    display(scene)
end
