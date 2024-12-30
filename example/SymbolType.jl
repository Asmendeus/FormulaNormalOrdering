# example 1
pauli_matrix_z_upup = NumberFactor("\\sigma^{z}_{\\uparrow\\uparrow}", 1, 1)
pauli_matrix_y_updn = NumberFactor("\\sigma^{x}_{\\uparrow\\downarrow}", -im, 1)
fc_i_up = FCOp(:c, (Site(:i), Spin(Symbol("\\uparrow"))))
fa_i_up = FAOp(:c, (Site(:i), Spin(Symbol("\\uparrow"))))
fc_j_up = FCOp(:c, (Site(:j), Spin(Symbol("\\uparrow"))))
fa_j_up = FAOp(:c, (Site(:j), Spin(Symbol("\\uparrow"))))

SᶻupSᶻup = 1/4 * pauli_matrix_z_upup * pauli_matrix_z_upup * (fc_i_up * fa_i_up * fc_j_up * fa_j_up)
op_ijij = sort(SᶻupSᶻup; operator_order=[fc_i_up, fc_j_up, fa_i_up, fa_j_up])
value(op_ijij)

# example 2
fc_i_σ₁ = FCOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fa_i_σ₁ = FAOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fc_j_σ₂ = FCOp(:c, (Site(:j), Spin(Symbol("\\sigma_2"))))
fa_j_σ₂ = FAOp(:c, (Site(:j), Spin(Symbol("\\sigma_2"))))
fc_k_σ₃ = FCOp(:c, (Site(:k), Spin(Symbol("\\sigma_3"))))
fa_k_σ₃ = FAOp(:c, (Site(:k), Spin(Symbol("\\sigma_3"))))
ni = fc_i_σ₁ * fa_i_σ₁
nj = fc_j_σ₂ * fa_j_σ₂
nk = fc_k_σ₃ * fa_k_σ₃
nnn = ni * nj * nk
nnn_ijkijk = sort(nnn; operator_order=[fc_i_σ₁, fc_j_σ₂, fc_k_σ₃, fa_i_σ₁, fa_j_σ₂, fa_k_σ₃])
value(nnn_ijkijk)