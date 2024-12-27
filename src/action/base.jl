function Base.show(io::IO, op::Union{AbstractOperator, AbstractFactor})
    print(io, text(op))
end


################ math ################
# ============== negative ==============
function Base.:-(op::KroneckerDelta)
    return KroneckerDelta(op.name, op.subscript, -op.fac)
end
function Base.:-(op::GeneralKroneckerDelta)
    return GeneralKroneckerDelta(op.name, op.subscript, -op.fac)
end
function Base.:-(op::SingleGeneralOperator)
    return SingleGeneralOperator(op.ops, -op.fac)
end

# ============== multiplication ==============
# Factor
Base.:*(op::GeneralKroneckerDelta, num::Number) = num * op
function Base.:*(num::Number, op::GeneralKroneckerDelta)
    return GeneralKroneckerDelta(op.name, op.subscript, num*op.fac)
end
Base.:*(op::KroneckerDelta, num::Number) = num * op
function Base.:*(num::Number, op::KroneckerDelta)
    return KroneckerDelta(op.name, op.subscript, num*op.fac)
end
function Base.:*(op1::KroneckerDelta, op2::KroneckerDelta)
    if op1.subscript == op2.subscript
        return KroneckerDelta(op1.name, op1.subscript, op1.fac * op2.fac)
    else
        return GeneralKroneckerDelta(op1.name, (op1.subscript, op2.subscript), op1.fac * op2.fac)
    end
end
Base.:*(op1::KroneckerDelta, op2::GeneralKroneckerDelta) = op2 * op1
function Base.:*(op1::GeneralKroneckerDelta, op2::KroneckerDelta)
    if any(map(x->x==op2.subscript, op1.subscript))
        return GeneralKroneckerDelta(op1.name, op1.subscript, op1.fac * op2.fac)
    else
        return GeneralKroneckerDelta(op1.name, (op1.subscript..., op2.subscript), op1.fac * op2.fac)
    end
end
function Base.:*(op1::GeneralKroneckerDelta, op2::GeneralKroneckerDelta)
    subscript = Tuple(Set(op1.subscript) ∪ Set(op2.subscript))
    return GeneralKroneckerDelta(op1.name, subscript, op1.fac * op2.fac)
end

# SingleGeneralOperator
Base.:*(op::SingleGeneralOperator, factor::Union{Number, AbstractFactor}) = factor * op
function Base.:*(factor::Union{Number, AbstractFactor}, op::SingleGeneralOperator)
    return SingleGeneralOperator(op.ops, factor * op.fac)
end
function Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator}, op2::Union{AbstractBosonOperator, AbstractFermionOperator})
    return SingleGeneralOperator([op1, op2], 1)
end
function Base.:*(op1::SingleGeneralOperator, op2::Union{AbstractBosonOperator, AbstractFermionOperator})
    return SingleGeneralOperator([op1.ops..., op2], op1.fac)
end
function Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator}, op2::SingleGeneralOperator)
    return SingleGeneralOperator([op1, op2.ops...], op2.fac)
end
function Base.:*(op1::SingleGeneralOperator, op2::SingleGeneralOperator)
    return SingleGeneralOperator([op1.ops..., op2.ops...], op1.fac * op2.fac)
end