# example1: nᵢnⱼ = ∑_{σ₁,σ₂} c^dag_{i,σ₁} c_{i,σ₁} c^dag_{j,σ₂} c_{j,σ₂}
fc_i_σ1 = FCOp(:c, (Site(:i), Spin(:σ₁)))
fa_i_σ1 = FAOp(:c, (Site(:i), Spin(:σ₁)))
fc_j_σ2 = FCOp(:c, (Site(:j), Spin(:σ₂)))
fa_j_σ2 = FAOp(:c, (Site(:j), Spin(:σ₂)))

nn = fc_i_σ1 * fa_i_σ1 * fc_j_σ2 * fa_j_σ2
@show text(sort(nn));

# example2: Sᵢ·Sⱼ = ∑_{α=x,y,z; σ₁,σ₂,σ₃,σ₄} 1//4 * c^dag_{i,σ₁} σ^α_{σ₁σ₂} c_{i,σ₂} c^dag_{j,σ₃} σ^α_{σ₃σ₄} c_{j,σ₄}
σ_α_12 = SFactor("σ^α_{σ₁σ₂}")
σ_α_34 = SFactor("σ^α_{σ₃σ₄}")

fc_i_σ1 = FCOp(:c, (Site(:i), Spin(:σ₁)))
fa_i_σ2 = FAOp(:c, (Site(:i), Spin(:σ₂)))
fc_j_σ3 = FCOp(:c, (Site(:j), Spin(:σ₃)))
fa_j_σ4 = FAOp(:c, (Site(:j), Spin(:σ₄)))

SS = 1/4 * fc_i_σ1 * σ_α_12 * fa_i_σ2 * fc_j_σ3 * σ_α_34 * fa_j_σ4
@show text(sort(SS));

# example3: nᵢnⱼnₖ = ∑_{σ₁,σ₂,σ₃} c^dag_{i,σ₁} c_{i,σ₁} c^dag_{j,σ₂} c_{j,σ₂} c^dag_{k,σ₃} c_{k,σ₃}
fc_i_σ1 = FCOp(:c, (Site(:i), Spin(:σ₁)))
fa_i_σ1 = FAOp(:c, (Site(:i), Spin(:σ₁)))
fc_j_σ2 = FCOp(:c, (Site(:j), Spin(:σ₂)))
fa_j_σ2 = FAOp(:c, (Site(:j), Spin(:σ₂)))
fc_k_σ3 = FCOp(:c, (Site(:k), Spin(:σ₃)))
fa_k_σ3 = FAOp(:c, (Site(:k), Spin(:σ₃)))

nnn = fc_i_σ1 * fa_i_σ1 * fc_j_σ2 * fa_j_σ2 * fc_k_σ3 * fa_k_σ3
@show text(sort(nnn));

# example4: Sᵢ·(Sⱼ×Sₖ) = ∑_{α,β,γ} 1//8 ϵ_{αβγ} c^dag_{i,σ₁} σ^α_{σ₁σ₂} c_{i,σ₂} c^dag_{j,σ₃} σ^β_{σ₃σ₄} c_{j,σ₄} c^dag_{k,σ₅} σ^γ_{σ₅σ₆} c_{k,σ₆}
σ_α_12 = SFactor("σ^α_{σ₁σ₂}")
σ_β_34 = SFactor("σ^β_{σ₃σ₄}")
σ_γ_56 = SFactor("σ^γ_{σ₅σ₆}")

fc_i_σ1 = FCOp(:c, (Site(:i), Spin(:σ₁)))
fa_i_σ2 = FAOp(:c, (Site(:i), Spin(:σ₂)))
fc_j_σ3 = FCOp(:c, (Site(:j), Spin(:σ₃)))
fa_j_σ4 = FAOp(:c, (Site(:j), Spin(:σ₄)))
fc_k_σ5 = FCOp(:c, (Site(:k), Spin(:σ₅)))
fa_k_σ6 = FAOp(:c, (Site(:k), Spin(:σ₆)))

SSS = 1/8 * fc_i_σ1 * σ_α_12 * fa_i_σ2 * fc_j_σ3 * σ_β_34 * fa_j_σ4 * fc_k_σ5 * σ_γ_56 * fa_k_σ6
@show text(sort(SSS));
