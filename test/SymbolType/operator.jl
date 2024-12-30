σ₁ = Spin(:σ₁)
σ₂ = Spin(:σ₂)
σ₃ = Spin(:σ₃)
σ₄ = Spin(:σ₄)

si = Site(:i)
sj = Site(:j)
sk = Site(:k)
sl = Site(:l)

σz_upup = NFactor("σ^{z}_{↑↑}", 1, 1)


fa1 = FAOp(:c, (si,))
fc1 = FCOp(:c, (sj,))
@show fa1*fc1
@show swap(fa1*fc1)

fa2 = FAOp(:c, (si, σ₁))
fc2 = FCOp(:c, (sj, σ₂))
@show fa2*fc2*fa2
@show swap(fa2*fc2)*fa2


ba1 = BAOp(:b, (si,))
bc1 = BCOp(:b, (sj,))
@show ba1*bc1
@show swap(ba1*bc1)

ba2 = BAOp(:b, (si, σ₁))
bc2 = BCOp(:b, (sj, σ₂))
@show ba2*bc2*ba2
@show swap(ba2*bc2)*ba2


@show op1 = fa1*fc1
@show swap(op1)
@assert swap(op1) == sort(op1; indices=[2,1]) == sort(op1; operators=[fc1, fa1])

@show op2 = fa2 * fc2
@show swap(op2)
@assert swap(op2) == sort(op2; indices=[2,1]) == sort(op2; operators=[fc2, fa2])

@show op3 = fa1 * fa1 * fc1 * fc1
@show value(sort(op3; operators=[fc1, fa1]))
@assert sort(op3; operators=[fc1, fa1]) == sort(op3; indices=[3,4,1,2])

fa3 = FAOp(:c, (si, σ₁))
fa4 = FAOp(:c, (sj, σ₂))
fc3 = FCOp(:c, (sk, σ₃))
fc4 = FCOp(:c, (sl, σ₄))
@show op4 = fa3 * fc3 * fa4 * fc4
@show value(sort(op4; operator_order=[fc3, fc4, fa3, fa4]))
