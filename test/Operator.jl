using BenchmarkFreeFermions
using Test

fa1 = FAOp(:c, (Site(:i), Spin(:σ)))
fa1′ = FAOp(:c, (Spin(:σ), Site(:i)))
fa2 = FAOp(:c, (Site(:j), Spin(:σ′)))
fa3 = FAOp(:c, (Site(:i), Spin(:σ), Layer(:μ)))
fc1 = FCOp(:c, (Site(:i), Spin(:σ)))
fc2 = FCOp(:c, (Site(:j), Spin(:σ′)))
fc3 = FCOp(:c, (Site(:i), Spin(:σ), Layer(:μ)))

ba1 = BAOp(:b, (Site(:i), Spin(:σ)))
ba2 = BAOp(:b, (Site(:j), Spin(:σ′)))
ba3 = BAOp(:b, (Site(:i), Spin(:σ), Layer(:μ)))
bc1 = BCOp(:b, (Site(:i), Spin(:σ)))
bc2 = BCOp(:b, (Site(:j), Spin(:σ′)))
bc3 = BCOp(:b, (Site(:i), Spin(:σ), Layer(:μ)))

aa1 = AAOp{π/2}(:a, (Site(:i), Spin(:σ)))
aa2 = AAOp{π/2}(:a, (Site(:j), Spin(:σ′)))
ac1 = ACOp{π/2}(:a, (Site(:i), Spin(:σ)))
ac2 = ACOp{π/2}(:a, (Site(:j), Spin(:σ′)))

@testset "operator test: base" begin
    @test text(fa1) == LaTeXString("c_{i,σ}")
    @test text(fc1) == LaTeXString("c^\\dag_{i,σ}")
    @test text(fc1*fa1) == LaTeXString("c^\\dag_{i,σ}c_{i,σ}")
    @test fa1 == fa1′
    @test 2 * fc1 * fa1 == MOp([fc1, fa1], 2)
    @test fc1 + fa1 + 2*fc2 + 2*fa2 == 2*(fc2 + fa2) + (fc1 + fa1) == LOp([1*fa1, 2*fa2, 1*fc1, 2*fc2])
    @test bc1 + 2*ba1 + 3 == IdOp() * (3 + 2*ba1 + bc1) == LOp([2*ba1, 1*bc1, 3*IdOp()]) == value(3 + 2*ba1 + bc1)
    @test -2 * ac1 == 2 * (-ac1) == value(-2*ac1)
    @test IdOp() * aa1 * IdOp() == 1*aa1 == MOp(aa1) == value(1*aa1)
end

@testset "operator test: swap" begin
    @test swap(IdOp(), IdOp()) == 1 * IdOp()
    @test swap(fa1, IdOp()) == swap(IdOp(), fa1) == 1 * fa1

    @test swap(fa1, fa2) == swap(fa1 * fa2) == - fa2 * fa1
    @test value(swap(fa1, fa2)) == - fa2 * fa1
    @test swap(fa1, fc1) == swap(fa1 * fc1) == - fc1 * fa1 + KDelta(:δ, (Site(:i), Site(:i))) * KDelta(:δ, (Spin(:σ), Spin(:σ))) * IdOp()
    @test value(swap(fa1, fc1)) == - fc1 * fa1 + IdOp()
    @test swap(fa1, fc2) == swap(fa1 * fc2) == - fc2 * fa1 + KDelta(:δ, (Site(:i), Site(:j))) * KDelta(:δ, (Spin(:σ), Spin(:σ′))) * IdOp()
    @test value(swap(fa1, fc2)) == - fc2 * fa1
    @test swap(fa1, fc3) == swap(fa1 * fc3) == - fc3 * fa1
    @test value(swap(fa1, fc3)) == - fc3 * fa1

    @test swap(ba1, ba2) == swap(ba1 * ba2) == ba2 * ba1
    @test value(swap(ba1, ba2)) == ba2 * ba1
    @test swap(ba1, bc1) == swap(ba1 * bc1) == bc1 * ba1 + KDelta(:δ, (Site(:i), Site(:i))) * KDelta(:δ, (Spin(:σ), Spin(:σ))) * IdOp()
    @test value(swap(ba1, bc1)) == bc1 * ba1 + IdOp()
    @test swap(ba1, bc2) == swap(ba1 * bc2) == bc2 * ba1 + KDelta(:δ, (Site(:i), Site(:j))) * KDelta(:δ, (Spin(:σ), Spin(:σ′))) * IdOp()
    @test value(swap(ba1, bc2)) == bc2 * ba1
    @test swap(ba1, bc3) == swap(ba1 * bc3) == bc3 * ba1
    @test value(swap(ba1, bc3)) == bc3 * ba1
end

@testset "operator test: sort" begin
    δii = KDelta(:δ, (Site(:i), Site(:i))); δij = KDelta(:δ, (Site(:i), Site(:j))); δjj = KDelta(:δ, (Site(:j), Site(:j)));
    δσσ = KDelta(:δ, (Spin(:σ), Spin(:σ))); δσσ′ = KDelta(:δ, (Spin(:σ), Spin(:σ′))); δσ′σ′ = KDelta(:δ, (Spin(:σ′), Spin(:σ′)));

    @test sort(fa1*fa2; operators=[fa2, fa1]) == sort(fa1*fa2; indices=[2,1]) == swap(fa1,fa2) == swap(fa1*fa2)
    @test sort(fa1*fc1; operators=[fc1, fa1]) == sort(fa1*fc1; indices=[2,1]) == sort(fa1*fc1) == swap(fa1,fc1) == swap(fa1*fc1)
    @test sort(fa1*fc2; operators=[fc2, fa1]) == sort(fa1*fc2; indices=[2,1]) == sort(fa1*fc2) == swap(fa1,fc2) == swap(fa1*fc2)
    @test (sort(fa1*fa2*fc1*fc2; operators=[fc1, fc2, fa1, fa2]) == sort(fa1*fa2*fc1*fc2; indices=[3,4,1,2]) == sort(fa1*fa2*fc1*fc2)
        == fc1*fc2*fa1*fa2 + δii*δσσ*fc2*fa2 + δjj*δσ′σ′*fc1*fa1 - δij*δσσ′*fc1*fa2 - δij*δσσ′*fc2*fa1 + δij*δσσ′*δij*δσσ′ - δjj*δσ′σ′*δii*δσσ)
    @test (sort(fa1*fa2*fc1*fc1; operators=[fc1, fa1, fa2]) == sort(fa1*fa2*fc1*fc1; indices=[3,4,1,2]) == sort(fa1*fa2*fc1*fc1; indices=[4,3,1,2]) == sort(fa1*fa2*fc1*fc1)
        == fc1*fc1*fa1*fa2 + δii*δσσ*fc1*fa2 + δij*δσσ′*fc1*fa1 - δii*δσσ*fc1*fa2 - δij*δσσ′*fc1*fa1 + δij*δσσ′*δii*δσσ - δij*δσσ′*δii*δσσ)
    @test (sort(fa1*fa1*fc1*fc1; operators=[fc1, fa1]) == sort(fa1*fa1*fc1*fc1; indices=[3,4,1,2]) == sort(fa1*fa1*fc1*fc1)
        == fc1*fc1*fa1*fa1 + δii*δσσ*fc1*fa1 + δii*δσσ*fc1*fa1 - δii*δσσ*fc1*fa1 - δii*δσσ*fc1*fa1 + δii*δσσ*δii*δσσ - δii*δσσ*δii*δσσ)

    @test sort(ba1*ba2; operators=[ba2, ba1]) == sort(ba1*ba2; indices=[2,1]) == swap(ba1,ba2) == swap(ba1*ba2)
    @test sort(ba1*bc1; operators=[bc1, ba1]) == sort(ba1*bc1; indices=[2,1]) == swap(ba1,bc1) == swap(ba1*bc1)
    @test sort(ba1*bc2; operators=[bc2, ba1]) == sort(ba1*bc2; indices=[2,1]) == swap(ba1,bc2) == swap(ba1*bc2)
    @test (sort(ba1*ba2*bc1*bc2; operators=[bc1, bc2, ba1, ba2]) == sort(ba1*ba2*bc1*bc2; indices=[3,4,1,2]) == sort(ba1*ba2*bc1*bc2)
        == bc1*bc2*ba1*ba2 + δii*δσσ*bc2*ba2 + δjj*δσ′σ′*bc1*ba1 + δij*δσσ′*bc1*ba2 + δij*δσσ′*bc2*ba1 + δij*δσσ′*δij*δσσ′ + δjj*δσ′σ′*δii*δσσ)
    @test (sort(ba1*ba2*bc1*bc1; operators=[bc1, ba1, ba2]) == sort(ba1*ba2*bc1*bc1; indices=[3,4,1,2]) == sort(ba1*ba2*bc1*bc1; indices=[4,3,1,2]) == sort(ba1*ba2*bc1*bc1)
        == bc1*bc1*ba1*ba2 + δii*δσσ*bc1*ba2 + δij*δσσ′*bc1*ba1 + δii*δσσ*bc1*ba2 + δij*δσσ′*bc1*ba1 + δij*δσσ′*δii*δσσ + δij*δσσ′*δii*δσσ)
    @test (sort(ba1*ba1*bc1*bc1; operators=[bc1, ba1]) == sort(ba1*ba1*bc1*bc1; indices=[3,4,1,2]) == sort(ba1*ba1*bc1*bc1)
        == bc1*bc1*ba1*ba1 + δii*δσσ*bc1*ba1 + δii*δσσ*bc1*ba1 + δii*δσσ*bc1*ba1 + δii*δσσ*bc1*ba1 + δii*δσσ*δii*δσσ + δii*δσσ*δii*δσσ)

    @test (sort(fa1*fa2 + 2*fa1*fc1 + fa1*fc2 + 3*fa1*fa2*fc1*fc2 + fa1*fa2*4*fc1*fc1 + fa1*fa1*5*fc1*fc1; operators=[fc1,fc2,fa1,fa2])
        == sort(fa1*fa2) + sort(2*fa1*fc1) + sort(fa1*fc2) + 3*sort(fa1*fa2*fc1*fc2) + 4*sort(fa1*fa2*fc1*fc1) + sort(fa1*fa1*5*fc1*fc1))
    @test (sort(ba1*ba2 + 2*ba1*bc1 + ba1*bc2 + 3*ba1*ba2*bc1*bc2 + ba1*ba2*4*bc1*bc1 + ba1*ba1*5*bc1*bc1; operators=[bc1,bc2,ba1,ba2])
        == sort(ba1*ba2) + sort(2*ba1*bc1) + sort(ba1*bc2) + 3*sort(ba1*ba2*bc1*bc2) + 4*sort(ba1*ba2*bc1*bc1) + sort(ba1*ba1*5*bc1*bc1))
end
