include("../encoder/polar_encoder.jl")
using .PolarEncoder
using Test

@testset "Polar Encoder" begin
    u = [1 1]
    N = 2
    result = polar_encoder(u, N)
    @test result == [2 1]
end