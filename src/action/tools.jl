isOperator(Op) = typeof(Op) <: AbstractOperator

isBoson(Op::AbstractOperator) = typeof(Op) <: AbstractBosonOperator
isABOp(Op::AbstractOperator) = typeof(Op) <: BosonAnnihilationOperator
isCBOp(Op::AbstractOperator) = typeof(Op) <: BosonCreationOperator

isFermion(Op::AbstractOperator) = typeof(Op) <: AbstractFermionOperator
isAFOp(Op::AbstractOperator) = typeof(Op) <: FermionAnnihilationOperator
isCFOp(Op::AbstractOperator) = typeof(Op) <: FermionCreationOperator

isGeneral(Op::AbstractOperator) = typeof(Op) <: AbstractGeneralOperator
isSGOp(Op::AbstractOperator) = typeof(Op) <: SingleGeneralOperator
isMGOp(Op::AbstractOperator) = typeof(Op) <: MultiGeneralOperator


isFactor(fac) = typeof(fac) <: Union{Number, AbstractFactor}
isNumber(fac::Union{Number, AbstractFactor}) = typeof(fac) <: Number
isGFactor(fac::Union{Number, AbstractFactor}) = typeof(fac) <: GeneralFactor
isKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: KroneckerDelta
isGKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: GeneralKroneckerDelta

value(fac::Number) = fac
value(fac::GeneralFactor) = fac.value * fac.factor
function value(factor::KroneckerDelta{T}) where T
    if factor.subscript[1] == factor.subscript[2]
        return value(factor.factor)
    elseif T <: Symbol
        return factor
    else
        return 0
    end
end
function value(factor::GeneralKroneckerDelta)
    if all(map(x->x[1]==x[2], factor.subscript))
        return value(factor.factor)
    elseif any(map(x->(x[1]!=x[2] && eltype(x) <: Union{AbstractString, Number}), factor.subscript))
        return 0
    else
        return factor
    end
end
