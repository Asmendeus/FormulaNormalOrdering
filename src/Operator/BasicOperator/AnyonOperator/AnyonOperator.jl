"""
    struct AnyonOperator{θ, K, S...} <: AbstractAnyonOperator{θ, K, S...}
        name::Union{Symbol, AbstractString}
        subscript::Tuple{Vararg{AbstractSubscript}}
    end

# Fields
- `name::Union{Symbol, AbstractString}`
- `subscript::Tuple{Vararg{AbstractSubscript}}`
"""
struct AnyonOperator{θ, K, S...} <: AbstractAnyonOperator{θ, K, S...}
    name::Union{Symbol, AbstractString}
    subscript::Tuple{Vararg{AbstractSubscript}}

    function AnyonOperator{θ, K}(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}}) where {θ, K}
        isa(θ, Real) || throw(OperatorError("The swapping phase `θ` should be a real number!"))
        K in (:a, :annihilation, :c, :creation) || throw(OperatorError("The operator type `K` should be in (:a, :annihilation, :c, :creation)"))
        S = map(getSubType, subscript)
        return new{θ, K, S...}(name, subscript)
    end
end


"""
    const BosonOperator{K, S...} = AnyonOperator{0, K, S...}
    const BosonAnnihilationOperator{S...} = BosonOperator{:annihilation, S...}
    const BosonCreationOperator{S...} = BosonOperator{:creation, S...}
"""
const BosonOperator{K, S...} = AnyonOperator{0, K, S...}
function BosonOperator{K}(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}}) where K
        K in (:a, :annihilation, :c, :creation) || throw(OperatorError("The operator type `K` should be in (:a, :annihilation, :c, :creation)"))
        S = map(getSubType, subscript)
        return BosonOperator{K, S...}(name, subscript)
end

const BosonAnnihilationOperator{S...} = BosonOperator{:annihilation, S...}
function BosonAnnihilationOperator(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}})
    S = map(getSubType, subscript)
    return BosonAnnihilationOperator{S...}(name, subscript)
end
const BAOp = BosonAnnihilationOperator

const BosonCreationOperator{S...} = BosonOperator{:creation, S...}
function BosonCreationOperator(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}})
    S = map(getSubType, subscript)
    return BosonCreationOperator{S...}(name, subscript)
end
const BCOp = BosonCreationOperator


"""
    const FermionOperator{K, S...} = AnyonOperator{π, K, S...}
    const FermionAnnihilationOperator{S...} = FermionOperator{:annihilation, S...}
    const FermionCreationOperator{S...} = FermionOperator{:creation, S...}
"""
const FermionOperator{K, S...} = AnyonOperator{π, K, S...}
function FermionOperator{K}(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}}) where K
    K in (:a, :annihilation, :c, :creation) || throw(OperatorError("The operator type `K` should be in (:a, :annihilation, :c, :creation)"))
    S = map(getSubType, subscript)
    return FermionOperator{K, S...}(name, subscript)
end

const FermionAnnihilationOperator{S...} = FermionOperator{:annihilation, S...}
function FermionAnnihilationOperator(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}})
    S = map(getSubType, subscript)
    return FermionAnnihilationOperator{S...}(name, subscript)
end
const FAOp = FermionAnnihilationOperator

const FermionCreationOperator{S...} = FermionOperator{:creation, S...}
function FermionCreationOperator(name::Union{Symbol, AbstractString}, subscript::Tuple{Vararg{AbstractSubscript}})
    S = map(getSubType, subscript)
    return FermionCreationOperator{S...}(name, subscript)
end
const FCOp = FermionCreationOperator
