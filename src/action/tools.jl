isBoson(Op::AbstractOperator) = typeof(Op) <: AbstractBosonOperator
isABOp(Op::AbstractOperator) = typeof(Op) <: BosonAnnihilationOperator
isCBOp(Op::AbstractOperator) = typeof(Op) <: BosonCreationOperator

isFermion(Op::AbstractOperator) = typeof(Op) <: AbstractFermionOperator
isAFOp(Op::AbstractOperator) = typeof(Op) <: FermionAnnihilationOperator
isCFOp(Op::AbstractOperator) = typeof(Op) <: FermionCreationOperator

isGeneral(Op::AbstractOperator) = typeof(Op) <: AbstractGeneralOperator
isDelta(Op::AbstractOperator) = typeof(Op) <: KroneckerDelta
isSGOp(Op::AbstractOperator) = typeof(Op) <: SingleGeneralOperator
isMGOp(Op::AbstractOperator) = typeof(Op) <: MultiGeneralOperator

value(num::Number) = num
function value(op::KroneckerDelta{T}) where T
    if op.subscript[1] == op.subscript[2]
        return op.fac
    elseif T <: Symbol
        return op
    else
        return 0
    end
end
function value(op::GeneralKroneckerDelta)
    if all(map(x->x[1]==x[2], op.subscript))
        return op.fac
    elseif any(map(x->(x[1]!=x[2] && eltype(x) <: Union{AbstractString, Number}), op.subscript))
        return 0
    else
        return op
    end
end