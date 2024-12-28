@show σz_upup = NFactor("σ^{z}_{↑↑}", 1, 1)
@show σz_updn = NFactor("σ^{z}_{↑↓}", 0, 1)
@show σz_dnup = NFactor("σ^{z}_{↓↑}", 0, 1)
@show σz_dndn = NFactor("σ^{z}_{↓↓}", -1, 1)

@show value(σz_upup)
@show value(σz_updn)
@show value(σz_dnup)
@show value(σz_dndn)

@show δsite = KDelta(:δ, (Site(:i), Site(:j)), - σz_upup)
@show value(δsite)
@show value(δsite; isstrict=true)

@show Δ = PKDelta(:δ, ((Site(:i), Site(:j)), (Site(:i), Site(:k), Site(:l)), (Spin(:↑), Spin(:↓))), -1)
@assert Δ == - KDelta(:δ, (Site(:i), Site(:j)), 1) * KDelta(:δ, (Site(:i), Site(:k), Site(:l)), 1) * KDelta(:δ, (Spin(:↑), Spin(:↓)), 1)

@show ΔΔ = Δ * Δ
@show value(ΔΔ)