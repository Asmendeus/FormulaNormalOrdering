"""
    struct AnyonOperator{θ, K} <: AbstractAnyonOperator{θ, K} where S
        name::Union{Symbol, AbstractString}
        subscripts::Tuple{Vararg{AbstractSubscript}}
    end

    const AnyonAnnihilationOperator{θ} = AnyonOperator{θ, :a}
    const AnyonCreationOperator{θ} = AnyonOperator{θ, :c}

# Fields
- `name::Union{Symbol, AbstractString}`
- `subscripts::Tuple{Vararg{AbstractSubscript}}`
"""
struct AnyonOperator{θ, K} <: AbstractAnyonOperator{θ, K}
    name::Union{Symbol, AbstractString}
    subscripts::Tuple{Vararg{AbstractSubscript}}

    function AnyonOperator{θ, K}(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript}}) where {θ, K}
        isa(θ, Real) || throw(OperatorError("The swapping phase `θ` should be a real number!"))
        K in (:a, :c) || throw(OperatorError("The operator type `K` should be in (:a, :c)"))
        allunique(map(x->typeof(x), subscripts)) || throw(OperatorError("The types of operator subscripts should all be different"))
        return new{θ, K}(name, subscripts)
    end
    function AnyonOperator{θ, K}(name::Union{Symbol, AbstractString}, subscript::AbstractSubscript) where {θ, K}
        isa(θ, Real) || throw(OperatorError("The swapping phase `θ` should be a real number!"))
        K in (:a, :c) || throw(OperatorError("The operator type `K` should be in (:a, :c)"))
        return new{θ, K}(name, (subscript,))
    end
end

const AnyonAnnihilationOperator{θ} = AnyonOperator{θ, :a}
const AAOp = AnyonAnnihilationOperator

const AnyonCreationOperator{θ} = AnyonOperator{θ, :c}
const ACOp = AnyonCreationOperator

getSubTypes(op::AnyonOperator) = map(getSubType, op.subscripts)


"""
    const BosonOperator{K} = AnyonOperator{0, K}
    const BosonAnnihilationOperator = BosonOperator{:a}
    const BosonCreationOperator = BosonOperator{:c}
"""
const BosonOperator{K} = AnyonOperator{0, K}

const BosonAnnihilationOperator = BosonOperator{:a}
const BAOp = BosonAnnihilationOperator

const BosonCreationOperator = BosonOperator{:c}
const BCOp = BosonCreationOperator


"""
    const FermionOperator{K} = AnyonOperator{π, K}
    const FermionAnnihilationOperator = FermionOperator{:a}
    const FermionCreationOperator = FermionOperator{:c}
"""
const FermionOperator{K} = AnyonOperator{π, K}

const FermionAnnihilationOperator = FermionOperator{:a}
const FAOp = FermionAnnihilationOperator

const FermionCreationOperator = FermionOperator{:c}
const FCOp = FermionCreationOperator
