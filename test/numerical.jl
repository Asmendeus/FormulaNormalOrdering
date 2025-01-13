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
    G′ = GreenFunction(ξ, V, Inf; reverse=true)

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
    G′ = GreenFunction(ξ, V, Inf; reverse=true)

    # expectation
    for i1 in 1:L, i2 in 1:L, j1 in 1:L, j2 in 1:L
        fc1 = FCOp(:c, Site(i1))
        fc2 = FCOp(:c, Site(i2))
        fa1 = FAOp(:c, Site(j1))
        fa2 = FAOp(:c, Site(j2))

        e_iijj = ExpectationValue(G, [i1, i2, j1, j2], [1, 2])
        e_ijij = ExpectationValue(G, [i1, j1, i2, j2], [1, 3])
        e_jiji = ExpectationValue(G, [j1, i1, j2, i2], [2, 4])
        e_jjii = ExpectationValue(G, [j1, j2, i1, i2], [3, 4])

        w_iijj = expectation(G′, fc1*fc2*fa1*fa2, x->x.subscripts[1].label)
        w_ijij = expectation(G′, fc1*fa1*fc2*fa2, x->x.subscripts[1].label)
        w_jiji = expectation(G′, fa1*fc1*fa2*fc2, x->x.subscripts[1].label)
        w_jjii = expectation(G′, fa1*fa2*fc1*fc2, x->x.subscripts[1].label)
        w_1add4 = expectation(G′, fc1*fc2*fa1*fa2+fa1*fa2*fc1*fc2, x->x.subscripts[1].label)

        !isnan(w_iijj) && (!isnan(e_iijj) && @test abs(w_iijj - e_iijj) < tol)
        isnan(w_iijj) && (num_nan_wick += 1)
        isnan(e_iijj) && (num_nan_expect += 1)

        !isnan(w_ijij) && (!isnan(e_ijij) && @test abs(w_ijij - e_ijij) < tol)
        isnan(w_ijij) && (num_nan_wick += 1)
        isnan(e_ijij) && (num_nan_expect += 1)

        !isnan(w_jiji) && (!isnan(e_jiji) && @test abs(w_jiji - e_jiji) < tol)
        isnan(w_jiji) && (num_nan_wick += 1)
        isnan(e_jiji) && (num_nan_expect += 1)

        !isnan(w_jjii) && (!isnan(e_jjii) && @test abs(w_jjii - e_jjii) < tol)
        isnan(w_jjii) && (num_nan_wick += 1)
        isnan(e_jjii) && (num_nan_expect += 1)

        @test abs(w_iijj + w_jjii - w_1add4) < tol
    end

    println("number of `NaN` from `wick` is $num_nan_wick")
    println("number of `NaN` from `ExpectationValue` is $num_nan_expect")
end
