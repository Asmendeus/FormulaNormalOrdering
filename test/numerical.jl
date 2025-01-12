using BenchmarkFreeFermions
using LinearAlgebra
using Test

@testset "numerical test: wick" begin
    tol = 1e-12
    num_nan_wick = 0
    num_nan_expect = 0

    # random free spinless fermion Hamiltonian
    L = 10  # 1-D lattice length
    H = rand(ComplexF64, L, L)
    H += H'

    # exact results
    ϵ, V = EigenModes(H)
    μ = (ϵ[div(L, 2)] + ϵ[div(L, 2)+1]) / 2  # half filling
    ξ = ϵ .- μ
    G = GreenFunction(ξ, V, Inf)
    G′ = Matrix(I, L, L) - transpose(G)

    # wick
    for i1 in 1:L, j1 in 1:L
        w = wick(G′, i1, j1)
        e = ExpectationValue(G, [i1, j1], [1,])
        (!isnan(w) && !isnan(e)) && (@test abs(w - e) < tol)
        isnan(w) && (num_nan_wick += 1)
        isnan(e) && (num_nan_expect += 1)
    end
    for i1 in 1:L, i2 in 1:L, j1 in 1:L, j2 in 1:L
        w = wick(G′, i1, i2, j1, j2)
        e = ExpectationValue(G, [i1, i2, j1, j2], [1, 2])
        (!isnan(w) && !isnan(e)) && (@test abs(w - e) < tol)
        isnan(w) && (num_nan_wick += 1)
        isnan(e) && (num_nan_expect += 1)
    end
    for i1 in 1:L, i2 in 1:L, i3 in 1:L, j1 in 1:L, j2 in 1:L, j3 in 1:L
        w = wick(G′, i1, i2, i3, j1, j2, j3)
        e = ExpectationValue(G, [i1, i2, i3, j1, j2, j3], [1, 2, 3])
        !isnan(w) && (!isnan(e) && @test abs(w - e) < tol)
        isnan(w) && (num_nan_wick += 1)
        isnan(e) && (num_nan_expect += 1)
    end
    println("number of `NaN` from `wick` is $num_nan_wick")
    println("number of `NaN` from `ExpectationValue` is $num_nan_expect")
end

@testset "numerical test: expectation" begin
end
