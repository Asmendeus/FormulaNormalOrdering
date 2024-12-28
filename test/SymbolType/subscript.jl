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
@assert getSubDim(σ1) == :spin
@assert getSubType(σ1) <: Symbol

cellsite{S} = GSubscript{:cellsite, S}
