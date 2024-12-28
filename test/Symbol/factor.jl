σz_upup = NFactor("σ^{z}_{↑↑}", 1, 1)
σz_updn = NFactor("σ^{z}_{↑↓}", 0, 1)
σz_dnup = NFactor("σ^{z}_{↓↑}", 0, 1)
σz_dndn = NFactor("σ^{z}_{↓↓}", -1, 1)

@show σz_upup
@show value(σz_upup)
@show σz_updn
@show value(σz_updn)
@show σz_dndn
@show value(σz_dndn)

δ