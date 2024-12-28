# =============== Subscript ===============
isSubscript(sub) = typeof(sub) <: AbstractSubscript
isGSubscript(sub::AbstractSubscript) = typeof(sub) <: GeneralSubscript

# =============== Factor ===============
isFactor(fac) = typeof(fac) <: Union{Number, AbstractFactor}
isNumber(fac::Union{Number, AbstractFactor}) = typeof(fac) <: Number
isNFactor(fac::Union{Number, AbstractFactor}) = typeof(fac) <: NumberFactor
isKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: KroneckerDelta
isGKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: GeneralKroneckerDelta

value(fac::Number) = fac
value(fac::NumberFactor) = fac.value * fac.factor
function value(fac::KroneckerDelta{N, T, S}) where {N, T, S}
    if all(x->x==fac.subscript[1], fac.subscript)
        return value(fac.factor)
    elseif typeof(T) <: Symbol
        return fac
    else
        return 0
    end
end
function value(fac::GeneralKroneckerDelta)
    if all(subsubscript->all(x->x==subsubscript[1], subsubscript), fac.subscript)
        return value(fac.factor)
    elseif any(subsubscript->any(x->x!=subsubscript[1], subsubscript), fac.subscript) && all()
        return 0
    else
        return fac
    end
end


# =============== Operator ===============
isOperator(op) = typeof(op) <: AbstractOperator

isBoson(op::AbstractOperator) = typeof(op) <: AbstractBosonOperator
isBAOp(op::AbstractOperator) = typeof(op) <: BosonAnnihilationOperator
isBCOp(op::AbstractOperator) = typeof(op) <: BosonCreationOperator

isFermion(op::AbstractOperator) = typeof(op) <: AbstractFermionOperator
isFAOp(op::AbstractOperator) = typeof(op) <: FermionAnnihilationOperator
isFCOp(op::AbstractOperator) = typeof(op) <: FermionCreationOperator

isGeneral(op::AbstractOperator) = typeof(op) <: AbstractGeneralOperator
isGSOp(op::AbstractOperator) = typeof(op) <: GeneralSingleOperator
isGMOp(op::AbstractOperator) = typeof(op) <: GeneralMultiOperator
