include("../encoder/rate_matching.jl")
using .RateMatching
using Base
using Test

@testset "Rate Matching" begin
    @testset "Repetition" begin
        N = 1024
        E = 1300
        K = 1088
        y = rand((0, 1), N)
        result = rate_matching(y, N, E, 1088)
        @test length(result) == E
    end

    @testset "Puncturing" begin
        N = 1024
        E = 1000
        K = E * 7 / 16
        y = rand((0, 1), N)
        result = rate_matching(y, N, E, K)
        @test result == y[N-E+1:N]
    end

    @testset "Shortening" begin
        N = 1024
        E = 1000
        K = E * 8 / 16
        y = rand((0, 1), N)
        result = rate_matching(y, N, E, K)
        @test result == y[1:E]
    end
end