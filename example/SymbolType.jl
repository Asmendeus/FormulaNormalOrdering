# example 1
#! WARNING: The Pauli matrix was incorrectly assigned because the current version `v0.1`
#! does not support subscripts for a factor and the function `value` is not available.
#! This problem will be solved in `v0.2`.
pauli_matrix_12 = NumberFactor("\\sigma^{\\alpha}_{\\sigma_1,\\sigma_2}", 1, 1)
pauli_matrix_34 = NumberFactor("\\sigma^{\\alpha}_{\\sigma_3,\\sigma_4}", 1, 1)
fc_i_σ₁ = FCOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fa_i_σ₂ = FAOp(:c, (Site(:i), Spin(Symbol("\\sigma_2"))))
fc_j_σ₃ = FCOp(:c, (Site(:j), Spin(Symbol("\\sigma_3"))))
fa_j_σ₄ = FAOp(:c, (Site(:j), Spin(Symbol("\\sigma_4"))))

SS = 1/4 * fc_i_σ₁ * pauli_matrix_12 * fa_i_σ₂ * fc_j_σ₃ * pauli_matrix_34 * fa_j_σ₄
SS_ij = sort(SS; operator_order=[fc_i_σ₁, fc_j_σ₃, fa_i_σ₂, fa_j_σ₄])

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


# example 3
#! WARNING: Same problem with example 3
pauli_matrix_12 = NumberFactor("\\sigma^{\\alpha}_{\\sigma_1,\\sigma_2}", 1, 1)
pauli_matrix_34 = NumberFactor("\\sigma^{\\beta}_{\\sigma_3,\\sigma_4}", 1, 1)
pauli_matrix_56 = NumberFactor("\\sigma^{\\gamma}_{\\sigma_5,\\sigma_6}", 1, 1)
LeviCivita_αβγ = NumberFactor("\\epsilon_{\\alpha\\beta\\gamma}", 1, 1)
fc_i_σ₁ = FCOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fa_i_σ₂ = FAOp(:c, (Site(:i), Spin(Symbol("\\sigma_2"))))
fc_j_σ₃ = FCOp(:c, (Site(:j), Spin(Symbol("\\sigma_3"))))
fa_j_σ₄ = FAOp(:c, (Site(:j), Spin(Symbol("\\sigma_4"))))
fc_k_σ₅ = FCOp(:c, (Site(:k), Spin(Symbol("\\sigma_5"))))
fa_k_σ₆ = FAOp(:c, (Site(:k), Spin(Symbol("\\sigma_6"))))


SSS = 0.125 * LeviCivita_αβγ * fc_i_σ₁ * pauli_matrix_12 * fa_i_σ₂ * fc_j_σ₃ * pauli_matrix_34 * fa_j_σ₄ * fc_k_σ₅ * pauli_matrix_56 * fa_k_σ₆
SSS_ijkijk = sort(SSS; operator_order=[fc_i_σ₁, fc_j_σ₃, fc_k_σ₅, fa_i_σ₂, fa_j_σ₄, fa_k_σ₆])


# example 4
fc_i_σ₁ = FCOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fa_j_σ₁ = FAOp(:c, (Site(:j), Spin(Symbol("\\sigma_1"))))
fc_k_σ₂ = FCOp(:c, (Site(:k), Spin(Symbol("\\sigma_2"))))
fa_k_σ₂ = FAOp(:c, (Site(:k), Spin(Symbol("\\sigma_2"))))

FdagFn = fc_i_σ₁ * fa_j_σ₁ * fc_k_σ₂ * fa_k_σ₂
FdagFn_ikjk = sort(FdagFn; operator_order=[fc_i_σ₁, fc_k_σ₂, fa_j_σ₁, fa_k_σ₂])


# example 5
fc_i_σ₁ = FCOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fa_i_σ₁ = FAOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fc_j_σ₂ = FCOp(:c, (Site(:j), Spin(Symbol("\\sigma_2"))))
fa_j_σ₂ = FAOp(:c, (Site(:j), Spin(Symbol("\\sigma_2"))))
fc_k_σ₃ = FCOp(:c, (Site(:k), Spin(Symbol("\\sigma_3"))))
fa_k_σ₃ = FAOp(:c, (Site(:k), Spin(Symbol("\\sigma_3"))))
fc_l_σ₄ = FCOp(:c, (Site(:l), Spin(Symbol("\\sigma_4"))))
fa_l_σ₄ = FAOp(:c, (Site(:l), Spin(Symbol("\\sigma_4"))))
ni = fc_i_σ₁ * fa_i_σ₁
nj = fc_j_σ₂ * fa_j_σ₂
nk = fc_k_σ₃ * fa_k_σ₃
nl = fc_l_σ₄ * fa_l_σ₄
nnnn = ni * nj * nk * nl
nnnn_ijklijkl = sort(nnnn; operator_order=[fc_i_σ₁, fc_j_σ₂, fc_k_σ₃, fc_l_σ₄, fa_i_σ₁, fa_j_σ₂, fa_k_σ₃, fa_l_σ₄])
value(nnnn_ijklijkl)


# example 6
fc_i_σ₁ = FCOp(:c, (Site(:i), Spin(Symbol("\\sigma_1"))))
fa_j_σ₁ = FAOp(:c, (Site(:j), Spin(Symbol("\\sigma_1"))))
fc_k_σ₂ = FCOp(:c, (Site(:k), Spin(Symbol("\\sigma_2"))))
fa_l_σ₂ = FAOp(:c, (Site(:l), Spin(Symbol("\\sigma_2"))))

FdagFFdagF = fc_i_σ₁ * fa_j_σ₁ * fc_k_σ₂ * fa_l_σ₂
FdagFFdagF_ijklijkl = sort(FdagFFdagF; operator_order=[fc_i_σ₁, fc_k_σ₂, fa_j_σ₁, fa_l_σ₂])
value(FdagFFdagF_ijklijkl)