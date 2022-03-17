include("../encoder/crc.jl")
using .CRC

a_prime = [1 1 0 1 0 0 1]       # dec = 105
A_prime = length(a_prime)       # A_prime = 7
g = g_6                         # g = [1 1 0 0 0 0 1]

result = CRC_encoder(a_prime, A_prime, g)

println(length(result) == length(a_prime) + length(g) - 1)
println(result)