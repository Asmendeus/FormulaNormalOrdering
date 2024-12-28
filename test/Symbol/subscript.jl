σ1 = Spin(:σ1)
σ2 = Spin(:σ2)
σ3 = Spin(:σ3)
σ4 = Spin(:σ4)

si = Site(:i)
sj = Site(:j)

orb1 = Orbital(:α)
orb2 = Orbital(:α′)

@assert isSubscript(σ1)
@assert isGSubscript(σ1)
@assert eltype(σ1) == :spin
