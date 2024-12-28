"""
    abstract type AbstractGeneralFactor <: AbstractFactor

Abstract type of factor with certain physical meaning,
absorbing normal coefficient that have no physical meaning,
e.g., negative Pauli matrix: -2 * σ^z_{σσ′}.
"""
abstract type AbstractGeneralFactor <: AbstractFactor end
