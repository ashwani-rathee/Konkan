

"""
    image_point(object_point::NTuple{3, Float64}, focal_length::Float64)::NTuple{3, Float64}

Returns point in the image plane given the object point in world and focal length. 

Pinhole projection is used here which is used to concentrate the image rays avoiding 
muddled up image on screen without any pinhole.

# Equation of Perspective Projection 

rone = rzero * focallength / zzero

- rone : image point (xone, yone, focallength)
- rzero : object point (xzero, yzero, zzero)
- focallength : distance between pinhole and screen
- zzero : distance between object and pinhole, depth of object

# Arguments
- `object_point::NTuple{3, Float64}` : Point in the world 
- `focal_length::Float64` : Focal Length of pinhole camera

# Example
```julia-repl
julia> using Perspective

julia> img_point = image_point((5.0,5.0,5.0), -5.0)
(-5.0, -5.0, -5.0)

```

"""
function image_point(object_point::NTuple{3, Float64}, focal_length::Float64)::NTuple{3, Float64}
    return round.((object_point .* focal_length) ./ object_point[3], digits = 2)
end


"""
    project_multiple_points(object_points::Array{NTuple{3, Float64}, 1}, focal_length::Float64)::Array{NTuple{3, Float64}, 1}

Returns pinhole camera projection of various object points where a pinhole camera with a certain 
focal length is given.

# Arguments
- `object_points::Array{NTuple{3, Float64}` : Arrays of points in world
- `focal_length::Float64` : Focal length of pinhole camera

# Example
```julia-repl
julia> using Perspective

julia> obj_points = map((x,y)->(x, y, round(exp(x^2+y^2), digits=2)), -1.0:0.1:1.0, -1.0:0.1:1.0)

julia> project_multiple_points(obj_points, -2.0)
21-element Vector{Tuple{Float64, Float64, Float64}}:
 (0.27, 0.27, -2.0)
 (0.36, 0.36, -2.0)
 -
 -
```
"""
function project_multiple_points(object_points::Array{NTuple{3, Float64}, 1}, focal_length::Float64)::Array{NTuple{3, Float64}, 1}
    image_points = []
    for object_point in object_points
        push!(image_points, image_point(object_point, focal_length))
    end
    return image_points
end 


