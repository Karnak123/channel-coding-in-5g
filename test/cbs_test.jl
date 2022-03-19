include("../encoder/cbs.jl")
using .CBS
using Base
using Test

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