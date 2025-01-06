"""
    abstract type AbstractAnyonOperator{θ, K, S...} <: AbstractBasicOperator end

Abstract type of anyon operator.

# Description
`θ::Real` represents the swapping phase of identical anyons.
`K::Symbol` represents the type of basic operator, including `annihilation`(`:a`) and `:creation`(`:c`).
`S::Symbol...` represent(s) the type(s) of the basic operator, e.g., `:site`, `:spin`, `:orbital`, ⋯
"""
abstract type AbstractAnyonOperator{θ, K, S...} <: AbstractBasicOperator end

getPhase(::AbstractAnyonOperator{θ, K, S...}) where {θ, K, S...} = θ
function getOpType(::AbstractAnyonOperator{θ, K, S...}) where {θ, K, S...}
    if K == :a
        return :annihilation
    elseif K == :c
        return :creation
    end
    return K
end
getSubTypes(::AbstractAnyonOperator{θ, K, S...}) where {θ, K, S...} = (S...)


"""
    const AbstractBosonOperator{K, S...} = AbstractAnyonOperator{0, K, S...}
    const AbstractFermionOperator{K, S...} = AbstractAnyonOperator{π, K, S...}
"""
const AbstractBosonOperator{K, S...} = AbstractAnyonOperator{0, K, S...}
const AbstractFermionOperator{K, S...} = AbstractAnyonOperator{π, K, S...}
