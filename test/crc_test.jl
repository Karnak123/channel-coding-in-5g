include("../encoder/crc.jl")
using .CRC
using Test

@testset "CRC Encoder" begin
    a_prime = [1 1 0 1 0 0 1]       # dec = 105
    A_prime = length(a_prime)       # A_prime = 7
    g = g_6                         # g = [1 1 0 0 0 0 1]
    @test CRC_encoder(a_prime, A_prime, g) == [1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1]
end