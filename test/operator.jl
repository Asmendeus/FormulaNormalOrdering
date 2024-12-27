FC1 = FCOp(:c, (:i, :σ))
FA1 = FAOp(:c, (:j, :σ′))
N1 = FC1 * FA1

δsite = KroneckerDelta(:δ, (:i, :j))
δspin = KroneckerDelta(:δ, (:σ, :σ′))
Nδδ = - δsite * N1 * δspin

