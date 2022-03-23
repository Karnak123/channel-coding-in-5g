include("../encoder/cbs.jl")
include("../encoder/crc.jl")
include("../encoder/polar_encoder.jl")
include("../encoder/rate_matching.jl")
include("../encoder/cbc.jl")
include("../encoder/ibl.jl")
include("../encoder/ci.jl")
include("../encoder/sbi.jl")
using .CBS
using .CRC
using .PolarEncoder
using .RateMatching
using .CBC
using .IBL
using .CI
using .SBI
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

    @testset "Code Block Concatenation" begin
        @testset "Equal blocks of size E" begin
            a = [1 1 0 1 0 0 1]
            b = [1 1 0 1 0 0 1]
            E = 7
            @test code_block_concatenator(a, b, E) == [1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1]
        end

        @testset "Block size E and E+1" begin
            a = [1 1 0 1 0 0 1 1]
            b = [1 1 0 1 0 0 1]
            E = 7
            @test code_block_concatenator(a, b, E) == [1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0]
        end
    end

    @testset "Input Bit Interleaver" begin
        @testset "Block <= 164" begin
            K = 128
            a = rand((0, 1), K)
            @test length(bit_interleaver(a, K, PI_IL_Max)) == K
        end

        @testset "Block > 164" begin
            K = 256
            a = rand((0, 1), K)
            @test length(bit_interleaver(a, K, PI_IL_Max)) == K
        end
    end

    @testset "Channel Interleaver" begin
        E = 164
        e = rand((0, 1), E)
        @test length(channel_interleaver(e, E)) == E
    end

    @testset "Sub Block Interleaver" begin
        N = 2^rand(5:10)
        d = rand((0, 1), N)
        y = sub_block_interleaver(d, N)
        @test length(y) == N
        @test d!=y
    end
end