# =============== Subscript ===============
isSubscript(sub) = isa(sub, AbstractSubscript)
isGSubscript(sub::AbstractSubscript) = isa(sub, GeneralSubscript)


# =============== Factor ===============
isFactor(fac) = isa(fac, Union{Number, AbstractFactor})
isNumber(fac::Union{Number, AbstractFactor}) = isa(fac, Number)
isNFactor(fac::Union{Number, AbstractFactor}) = isa(fac, NumberFactor)
isKDelta(fac::Union{Number, AbstractFactor}) = isa(fac, KroneckerDelta)
isPKDelta(fac::Union{Number, AbstractFactor}) = isa(fac, ProductKroneckerDelta)


# =============== Operator ===============
isOperator(op) = isa(op, AbstractOperator)

isBoson(op::AbstractOperator) = isa(op, AbstractBosonOperator)
isBAOp(op::AbstractOperator) = isa(op, BosonAnnihilationOperator)
isBCOp(op::AbstractOperator) = isa(op, BosonCreationOperator)

isFermion(op::AbstractOperator) = isa(op, AbstractFermionOperator)
isFAOp(op::AbstractOperator) = isa(op, FermionAnnihilationOperator)
isFCOp(op::AbstractOperator) = isa(op, FermionCreationOperator)

isGeneral(op::AbstractOperator) = isa(op, AbstractGeneralOperator)
isGSOp(op::AbstractOperator) = isa(op, GeneralSingleOperator)
isGMOp(op::AbstractOperator) = isa(op, GeneralMultiOperator)


