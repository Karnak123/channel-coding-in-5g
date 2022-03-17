include("../encoder/polar_encoder.jl")
using .PolarEncoder

u = [1 1]
N = 2
result = polar_encoder(u, N)
println(result == [2 1])