# =============== Subscript ===============
isSubscript(sub) = typeof(sub) <: AbstractSubscript
isGSubscript(sub::AbstractSubscript) = typeof(sub) <: GeneralSubscript


# =============== Factor ===============
isFactor(fac) = typeof(fac) <: Union{Number, AbstractFactor}
isNumber(fac::Union{Number, AbstractFactor}) = typeof(fac) <: Number
isNFactor(fac::Union{Number, AbstractFactor}) = typeof(fac) <: NumberFactor
isKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: KroneckerDelta
isGKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: ProductKroneckerDelta


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


