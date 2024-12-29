σ1 = Spin(:σ1)
σ2 = Spin(:σ2)
σ3 = Spin(:σ3)
σ4 = Spin(:σ4)

si = Site(:i)
sj = Site(:j)
sk = Site(:k)
sl = Site(:l)

σz_upup = NFactor("σ^{z}_{↑↑}", 1, 1)


fa1 = FAOp(:c, (si,))
fc1 = FCOp(:c, (sj,))
@show fa1*fc1
@show swap(fa1*fc1)

fa2 = FAOp(:c, (si, σ1))
fc2 = FCOp(:c, (sj, σ2))
@show fa2*fc2*fa2
@show swap(fa2*fc2)*fa2


ba1 = BAOp(:b, (si,))
bc1 = BCOp(:b, (sj,))
@show ba1*bc1
@show swap(ba1*bc1)

ba2 = BAOp(:b, (si, σ1))
bc2 = BCOp(:b, (sj, σ2))
@show ba2*bc2*ba2
@show swap(ba2*bc2)*ba2