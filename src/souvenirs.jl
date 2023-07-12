# souvenir no. 1
function object_point(image_point::NTuple{3, Float64}, focal_length::Float64)::NTuple{3, Float64}
    return (image_point .* image_point[3]) ./ focal_length
end
