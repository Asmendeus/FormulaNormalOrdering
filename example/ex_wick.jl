L = 10
G = rand(ComplexF64, 2*L, 2*L) # Green function
G += G'

# Pauli matrix
σx = [0 1; 1 0]
σy = [0 -1im; 1im 0]
σz = [1 0; 0 1]

# ⟨Sᵢ·Sⱼ⟩
function SS_expectation(G::Matrix{<:Number}, L::Int, i::Int, j::Int)
    val = 0
    for σ1 in 1:2, σ2 in 1:2, σ3 in 1:2, σ4 in 1:2
        fac = 0.25 * (σx[σ1,σ2]*σx[σ3,σ4] + σy[σ1,σ2]*σy[σ3,σ4] + σz[σ1,σ2]*σz[σ3,σ4])
        val -= fac * wick(G, i+(σ1-1)*L, j+(σ3-1)*L, i+(σ2-1)*L, j+(σ4-1)*L)
        if (i == j) && (σ2 == σ3)
            val += fac * wick(G, i+(σ1-1)*L, j+(σ4-1)*L)
        end
    end
    return val
end

# ⟨Sᵢ·(Sⱼ×Sₖ)⟩
function SSS_expectation(G::Matrix{<:Number}, L::Int, i::Int, j::Int, k::Int)
    val = 0
    for σ1 in 1:2, σ2 in 1:2, σ3 in 1:2, σ4 in 1:2, σ5 in 1:2, σ6 in 1:2
        fac = 0.125 * (σx[σ1,σ2]*σy[σ3,σ4]*σz[σ5,σ6]+σy[σ1,σ2]*σz[σ3,σ4]*σx[σ5,σ6]+σz[σ1,σ2]*σx[σ3,σ4]*σy[σ5,σ6]
                      -σz[σ1,σ2]*σy[σ3,σ4]*σx[σ5,σ6]-σy[σ1,σ2]*σx[σ3,σ4]*σz[σ5,σ6]-σx[σ1,σ2]*σz[σ3,σ4]*σy[σ5,σ6])
        val -= fac * wick(G, i+(σ1-1)*L, j+(σ3-1)*L, k+(σ5-1)*L, i+(σ2-1)*L, j+(σ4-1)*L, k+(σ6-1)*L)
        if (i == j) && (σ2 == σ3)
            val -= fac * wick(G, i+(σ1-1)*L, k+(σ5-1)*L, j+(σ4-1)*L, k+(σ6-1)*L)
        end
        if (j == k) && (σ4 == σ5)
            val -= fac * wick(G, i+(σ1-1)*L, j+(σ3-1)*L, i+(σ2-1)*L, k+(σ6-1)*L)
        end
        if (k == i) && (σ2 == σ5)
            val += fac * wick(G, i+(σ1-1)*L, j+(σ3-1)*L, j+(σ4-1)*L, k+(σ6-1)*L)
        end
        if (i == j == k) && (σ2 == σ3) && (σ4 == σ5)
            val += fac * wick(G, i+(σ1-1)*L, k+(σ6-1)*L)
        end
    end
    return val
end
