"""
    abstract type AbstractAnyonOperator{θ, K} <: AbstractBasicOperator end

Abstract type of anyon operator.

# Description
`θ::Real` represents the swapping phase of identical anyons.
`K::Symbol` represents the type of basic operator, including `:a`(annihilation) and `:c`(creation).
"""
abstract type AbstractAnyonOperator{θ, K} <: AbstractBasicOperator end

getPhase(::AbstractAnyonOperator{θ, K}) where {θ, K} = θ
getOpType(::AbstractAnyonOperator{θ, K}) where {θ, K} = K


"""
    const AbstractBosonOperator{K} = AbstractAnyonOperator{0, K}
    const AbstractFermionOperator{K} = AbstractAnyonOperator{π, K}
"""
const AbstractBosonOperator{K} = AbstractAnyonOperator{0, K}
const AbstractFermionOperator{K} = AbstractAnyonOperator{π, K}
