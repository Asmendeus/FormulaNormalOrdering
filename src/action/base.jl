function Base.show(io::IO, op::Union{AbstractOperator, AbstractFactor})
    print(io, text(op))
end


################ math ################
# ============== addition ==============
function Base.:+(op1::SingleGeneralOperator, op2::SingleGeneralOperator)
    return MultiGeneralOperator([op1, op2])
end
function Base.:+(op1::MultiGeneralOperator, op2::SingleGeneralOperator)
    return MultiGeneralOperator([op1.ops..., op2])
end
function Base.:+(op1::SingleGeneralOperator, op2::MultiGeneralOperator)
    return MultiGeneralOperator([op1, op2.ops...])
end
function Base.:+(op1::MultiGeneralOperator, op2::MultiGeneralOperator)
    return MultiGeneralOperator([op1.ops..., op2.ops...])
end


# ============== minus ==============
Base.:-(fac::GeneralFactor) = GeneralFactor(fac.name, fac.value, -fac.factor)
Base.:-(fac::KroneckerDelta) = KroneckerDelta(fac.name, fac.subscript, -fac.factor)
Base.:-(fac::GeneralKroneckerDelta) = GeneralKroneckerDelta(fac.name, fac.subscript, -fac.factor)
Base.:-(op::SingleGeneralOperator) = SingleGeneralOperator(op.ops, -op.factor)
Base.:-(op::MultiGeneralOperator) = MultiGeneralOperator(map(x->-x, op.ops))
Base.:-(op1::Union{SingleGeneralOperator, MultiGeneralOperator}, op2::Union{SingleGeneralOperator, MultiGeneralOperator}) = op1 + (-op2)


# ============== multiplication ==============
# Factor
Base.:*(fac1::AbstractFactor, fac2::Number) = fac2 * fac1
Base.:*(fac1::Number, fac2::GeneralFactor) = GeneralFactor(fac2.name, fac2.value, fac1 * fac2.factor)
Base.:*(fac1::Number, fac2::KroneckerDelta) = KroneckerDelta(fac2.name, fac2.subscript, fac1 * fac2.factor)
Base.:*(fac1::Number, fac2::GeneralKroneckerDelta) = GeneralKroneckerDelta(fac2.name, fac2.subscript, fac1 * op.factor)

function Base.:*(fac1::GeneralFactor, fac2::GeneralFactor)
    return GeneralFactor(string(fac1.name)* " " * string(fac2.name), fac1.value * fac2.value, fac1.factor * fac2.factor)
end
Base.(fac1::KroneckerDelta, fac2::GeneralFactor) = KroneckerDelta(fac1.name, fac1.subscript, fac1.factor * fac2)
Base.(fac1::GeneralFactor, fac2::KroneckerDelta) = KroneckerDelta(fac2.name, fac2.subscript, fac1 * fac2.factor)
Base.(fac1::GeneralKroneckerDelta, fac2::GeneralFactor) = KroneckerDelta(fac1.name, fac1.subscript, fac1.factor * fac2)
Base.(fac1::GeneralFactor, fac2::GeneralKroneckerDelta) = KroneckerDelta(fac2.name, fac2.subscript, fac1 * fac2.factor)

function Base.:*(op1::KroneckerDelta, op2::KroneckerDelta)
    if op1.subscript == op2.subscript
        return KroneckerDelta(op1.name, op1.subscript, op1.factor * op2.factor)
    else
        return GeneralKroneckerDelta(op1.name, (op1.subscript, op2.subscript), op1.factor * op2.factor)
    end
end
function Base.:*(op1::KroneckerDelta, op2::GeneralKroneckerDelta)
    if any(map(x->x==op1.subscript, op2.subscript))
        return GeneralKroneckerDelta(op2.name, op2.subscript, op1.factor * op2.factor)
    else
        return GeneralKroneckerDelta(op2.name, (op1.subscript, op2.subscript...), op1.factor * op2.factor)
    end
end
function Base.:*(op1::GeneralKroneckerDelta, op2::KroneckerDelta)
    if any(map(x->x==op2.subscript, op1.subscript))
        return GeneralKroneckerDelta(op1.name, op1.subscript, op1.factor * op2.factor)
    else
        return GeneralKroneckerDelta(op1.name, (op1.subscript..., op2.subscript), op1.factor * op2.factor)
    end
end

function Base.:*(op1::GeneralKroneckerDelta, op2::GeneralKroneckerDelta)
    subscript = Tuple(Set(op1.subscript) ∪ Set(op2.subscript))
    return GeneralKroneckerDelta(op1.name, subscript, op1.factor * op2.factor)
end

# SingleGeneralOperator
Base.:*(op::SingleGeneralOperator, fac::Union{Number, AbstractFactor}) = SingleGeneralOperator(op.ops, op.factor * fac)
Base.:*(fac::Union{Number, AbstractFactor}, op::SingleGeneralOperator) = SingleGeneralOperator(op.ops, fac * op.factor)
Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator}, op2::Union{AbstractBosonOperator, AbstractFermionOperator}) = SingleGeneralOperator([op1, op2], 1)
Base.:*(op1::SingleGeneralOperator, op2::Union{AbstractBosonOperator, AbstractFermionOperator}) = SingleGeneralOperator([op1.ops..., op2], op1.factor)
Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator}, op2::SingleGeneralOperator) = SingleGeneralOperator([op1, op2.ops...], op2.factor)
Base.:*(op1::SingleGeneralOperator, op2::SingleGeneralOperator) = SingleGeneralOperator([op1.ops..., op2.ops...], op1.factor * op2.factor)

# MultiGeneralOperator
Base.:*(op::MultiGeneralOperator, fac::Union{Number, AbstractFactor}) = MultiGeneralOperator(map(x->x*fac, op.ops))
Base.:*(fac::Union{Number, AbstractFactor}, op::MultiGeneralOperator) = MultiGeneralOperator(map(x->fac*x, op.ops))
Base.:*(op1::MultiGeneralOperator, op2::Union{AbstractBosonOperator, AbstractFermionOperator, SingleGeneralOperator}) = MultiGeneralOperator(map(x->x*op2, op1.ops))
Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator, SingleGeneralOperator}, op2::MultiGeneralOperator) = MultiGeneralOperator(map(x->op1*x, op2.ops))
Base.:*(op1::MultiGeneralOperator, op2::MultiGeneralOperator) = MultiGeneralOperator([x*y for x in op1.ops for y in op2.ops])