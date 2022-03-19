include("../encoder/cbs.jl")
include("../encoder/crc.jl")
include("../encoder/polar_encoder.jl")
include("../encoder/rate_matching.jl")
using .CBS
using .CRC
using .PolarEncoder
using .RateMatching
using Base
using Test

@testset "Encoder" begin
    @testset "Code Block Segmentation" begin
        @testset "A > 1013 && A % 2 == 1" begin
            A = 1015
            a = rand((0, 1), A)
            G = 1088
            result = code_block_segmentor(a, A, G)
            @test length(result) == 2
            @test length(result[1]) == length(result[2])
            @test length(result[1]) == ceil(Int, A / 2)
        end
    
        @testset "A > 1013 && A % 2 == 0" begin
            A = 1014
            a = rand((0, 1), A)
            G = 1088
            result = code_block_segmentor(a, A, G)
            @test length(result) == 2
            @test length(result[1]) == length(result[2])
            @test length(result[1]) == ceil(Int, A / 2)
        end
    
        @testset "A < 360 || G < 1088" begin
            A = 256
            a = rand((0, 1), A)
            G = 1080
            result = code_block_segmentor(a, A, G)
            @test length(result) == 1
            @test length(result[1]) == A
        end
    end

    @testset "CRC Encoder" begin
        a_prime = [1 1 0 1 0 0 1]       # dec = 105
        A_prime = length(a_prime)       # A_prime = 7
        g = g_6                         # g = [1 1 0 0 0 0 1]
        @test CRC_encoder(a_prime, A_prime, g) == [1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1]
    end

    @testset "Polar Encoder" begin
        u = [1 1]
        N = 2
        @test polar_encoder(u, N) == [2 1]
    end

    @testset "Rate Matching" begin
        @testset "Repetition" begin
            N = 1024
            E = 1300
            K = 1088
            y = rand((0, 1), N)
            @test length(rate_matching(y, N, E, K)) == E
        end
    
        @testset "Puncturing" begin
            N = 1024
            E = 1000
            K = E * 7 / 16
            y = rand((0, 1), N)
            @test rate_matching(y, N, E, K) == y[N-E+1:N]
        end
    
        @testset "Shortening" begin
            N = 1024
            E = 1000
            K = E * 8 / 16
            y = rand((0, 1), N)
            @test rate_matching(y, N, E, K) == y[1:E]
        end
    end
end