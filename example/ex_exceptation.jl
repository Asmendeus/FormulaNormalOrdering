L = 10
G = rand(ComplexF64, 2*L, 2*L) # Green function
G += G'

# Pauli matrix
σx_values = Dict((Spin(:↑), Spin(:↑))=>0, (Spin(:↑), Spin(:↓))=>1, (Spin(:↓), Spin(:↑))=>1, (Spin(:↓), Spin(:↓))=>0)
σy_values = Dict((Spin(:↑), Spin(:↑))=>0, (Spin(:↑), Spin(:↓))=>-1im, (Spin(:↓), Spin(:↑))=>1im, (Spin(:↓), Spin(:↓))=>0)
σz_values = Dict((Spin(:↑), Spin(:↑))=>1, (Spin(:↑), Spin(:↓))=>0, (Spin(:↓), Spin(:↑))=>0, (Spin(:↓), Spin(:↓))=>1)

function SS_expectation(G::Matrix{<:Number}, L::Int, i::Int, j::Int)
    val = 0
    for σ1 in (Spin(:↑), Spin(:↓)), σ2 in (Spin(:↑), Spin(:↓)), σ3 in (Spin(:↑), Spin(:↓)), σ4 in (Spin(:↑), Spin(:↓))
        σx12 = OFactor(:σx, (σ1, σ2), σx_values)
        σx34 = OFactor(:σx, (σ3, σ4), σx_values)
        σy12 = OFactor(:σy, (σ1, σ2), σy_values)
        σy34 = OFactor(:σy, (σ3, σ4), σy_values)
        σz12 = OFactor(:σz, (σ1, σ2), σz_values)
        σz34 = OFactor(:σz, (σ3, σ4), σz_values)
        fac = 1/4 * value(σx12*σx34 + σy12*σy34 + σz12*σz34)

        fc1 = FCOp(:c, (Site(i), σ1))
        fa1 = FAOp(:c, (Site(i), σ2))
        fc2 = FCOp(:c, (Site(j), σ3))
        fa2 = FAOp(:c, (Site(j), σ4))
        val += fac * expectation(G, fc1*fa1*fc2*fa2, x->x.subscripts[1].label+(x.subscripts[2] == Spin(:↑) ? 0 : L))
    end
    return val
end

function SSS_expectation(G::Matrix{<:Number}, L::Int, i::Int, j::Int, k::Int)
    val = 0
    for σ1 in (Spin(:↑), Spin(:↓)), σ2 in (Spin(:↑), Spin(:↓)), σ3 in (Spin(:↑), Spin(:↓)), σ4 in (Spin(:↑), Spin(:↓)), σ5 in (Spin(:↑), Spin(:↓)), σ6 in (Spin(:↑), Spin(:↓))
        σx12 = OFactor(:σx, (σ1, σ2), σx_values)
        σx34 = OFactor(:σx, (σ3, σ4), σx_values)
        σx56 = OFactor(:σx, (σ5, σ6), σx_values)
        σy12 = OFactor(:σy, (σ1, σ2), σy_values)
        σy34 = OFactor(:σy, (σ3, σ4), σy_values)
        σy56 = OFactor(:σy, (σ5, σ6), σy_values)
        σz12 = OFactor(:σz, (σ1, σ2), σz_values)
        σz34 = OFactor(:σz, (σ3, σ4), σz_values)
        σz56 = OFactor(:σz, (σ5, σ6), σz_values)
        fac = 1/8 * value(σx12*σy34*σz56 + σy12*σz34*σx56 + σz12*σx34*σy56 - σz12*σy34*σx56 - σy12*σx34*σz56 - σx12*σz34*σy56)

        fc1 = FCOp(:c, (Site(i), σ1))
        fa1 = FAOp(:c, (Site(i), σ2))
        fc2 = FCOp(:c, (Site(j), σ3))
        fa2 = FAOp(:c, (Site(j), σ4))
        fc3 = FCOp(:c, (Site(k), σ5))
        fa3 = FAOp(:c, (Site(k), σ6))
        val += fac * expectation(G, fc1*fa1*fc2*fa2*fc3*fa3, x->x.subscripts[1].label+(x.subscripts[2] == Spin(:↑) ? 0 : L))
    end
    return val
end
