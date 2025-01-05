@testset "factor test" begin
    ϵ_ijk = SFactor("ϵ_ijk")
    @test getName(ϵ_ijk) == "ϵ_ijk"
    @test getFactor(ϵ_ijk) == 1

    δ_ijk = KDelta(:δ, (Site(:i), Site("j"), Site(L"k")))
    @test getSubType(δ_ijk) == :site
    @test text(δ_ijk) == LaTeXString("1 × δ_{i,j,\$k\$}")
    @test getFactor(δ_ijk) == 1
    @test getName(δ_ijk) == :δ
    @test -δ_ijk == KDelta(:δ, (Site(:i), Site("j"), Site(L"k")), -1)
    @test value(δ_ijk) == 0

    σz_upup = NFactor(Symbol("σ^z_{\\uparrow\\uparrow}"), 1, -2)
    @test text(σz_upup) == LaTeXString("-2 × σ^z_{\\uparrow\\uparrow}")
    @test -σz_upup == NFactor(Symbol("σ^z_{\\uparrow\\uparrow}"), 1, 2)
    @test value(σz_upup) == -2

    multi_nest_σδ = σz_upup * δ_ijk
    @test getFactor(multi_nest_σδ) == σz_upup
    @test getFactor(-multi_nest_σδ) == -σz_upup
    @test value(multi_nest_σδ) == 0
    multi_nest_δσ = δ_ijk * σz_upup
    @test getFactor(multi_nest_δσ) == KDelta(:δ, (Site(:i), Site("j"), Site(L"k")), -2)
    @test value(multi_nest_δσ) == 0

    σz = OFactor(:σz, (Spin(:σ), Spin(:σ′)), Dict((Spin(:↑), Spin(:↑))=>1, (Spin(:↓), Spin(:↑))=>0, (Spin(:↑), Spin(:↓))=>0, (Spin(:↓), Spin(:↓))=>-1))
    @test getFactor(σz * multi_nest_σδ) == σz * σz_upup

    ϵ_δ = ϵ_ijk + 2*δ_ijk
    @test getFactor(ϵ_δ) == 1
    @test ϵ_δ == LinearFactor((SFactor("ϵ_ijk"), KDelta(:δ, (Site(:i), Site("j"), Site(L"k")), 2)), 1)

    σz_δ = 2*σz_upup + δ_ijk
    @test value(σz_δ) == 2 * value(σz_upup) + value(δ_ijk)
    @test 2*σz_upup + δ_ijk == δ_ijk + 2*σz_upup
    @test value(σz_upup * σz_δ) == 8
    @test value(σz_upup * σz_δ) == value(σz_upup) * value(σz_δ)
    @test LinearFactor((1, 2, 3), -1) == -6
    @test LinearFactor((1, 2), σz_upup) == 3 * σz_upup
    @test LinearFactor((1, σz_upup), 2) == 2 * (σz_upup + 1)
end
