################ IO ################
function Base.show(io::IO, op::AbstractNamedFactor)
    print(io, text(op))
end
function Base.show(io::IO, op::AbstractOperator)
    print(io, text(op))
end



############### math ###############
# =============== equality ===============
# Subscript
Base.:(==)(sub1::Subscript{S}, sub2::Subscript{S}) where S = (sub1.label == sub2.label)

# Factor
function Base.:(==)(fac1::SymbolFactor, fac2::SymbolFactor)
    return (fac1.name == fac2.name) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::KroneckerDelta{S}, fac2::KroneckerDelta{S}) where S
    return (Set(fac1.subscripts) == Set(fac2.subscripts)) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::NumberFactor, fac2::NumberFactor)
    return (fac1.name == fac2.name) && (fac1.value == fac2.value) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::OperatorFactor, fac2::OperatorFactor)
    return (fac1.name == fac2.name) && (fac1.subscripts == fac2.subscripts) && (fac1.values == fac2.values) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::LinearFactor, fac2::LinearFactor)
    return (fac1.factor == fac2.factor) && all(x->x in fac1.summation, fac2.summation) && all(x->x in fac2.summation, fac1.summation)
end

# Operator
function Base.:(==)(op1::AnyonOperator{θ₁, K}, op2::AnyonOperator{θ₂, K}) where {θ₁, θ₂, K}
    # return (θ₁ == θ₂) && (op1.name == op2.name) && (Set(op1.subscripts) == Set(op2.subscripts))
    return (θ₁ == θ₂) && (Set(op1.subscripts) == Set(op2.subscripts))
end
Base.:(==)(::IdentityOperator, ::IdentityOperator) = true
function Base.:(==)(op1::MultiplyOperator, op2::MultiplyOperator)
    return (op1.operators == op2.operators) && (op1.factor == op2.factor)
end
function Base.:(==)(op1::LinearOperator, op2::LinearOperator)
    return (op1.factor == op2.factor) && all(x->x in op1.operators, op2.operators) && all(x->x in op2.operators, op1.operators)
end


# =============== negative ===============
# Factor
Base.:-(fac::SymbolFactor) = typeof(fac)(fac.name, -fac.factor)
Base.:-(fac::KroneckerDelta) = typeof(fac)(fac.name, fac.subscripts, -fac.factor)
Base.:-(fac::NumberFactor) = typeof(fac)(fac.name, fac.value, -fac.factor)
Base.:-(fac::OperatorFactor) = typeof(fac)(fac.name, fac.subscripts, fac.values, -fac.factor)
Base.:-(fac::LinearFactor) = typeof(fac)(fac.summation, -fac.factor)

# Operator
Base.:-(op::AbstractBasicOperator) = MultiplyOperator(op, -1)
Base.:-(op::MultiplyOperator) = MultiplyOperator(op.operators, -op.factor)
Base.:-(op::LinearOperator) = LinearOperator(op.operators, -op.factor)


# =============== addition ===============
#? TODO: Merging can be done based on tree structure
# Factor
Base.:+(num::Number, fac::AbstractMultiplyFactor) = LinearFactor((num, fac))
Base.:+(fac::AbstractMultiplyFactor, num::Number) = LinearFactor((fac, num))
Base.:+(fac1::AbstractMultiplyFactor, fac2::AbstractMultiplyFactor) = LinearFactor((fac1, fac2))
Base.:+(num::Number, fac::LinearFactor) = LinearFactor((multiply_factor_to_all(fac)..., num))
Base.:+(fac::LinearFactor, num::Number) = LinearFactor((num, multiply_factor_to_all(fac)...))
Base.:+(fac1::AbstractMultiplyFactor, fac2::LinearFactor) = LinearFactor((fac1, multiply_factor_to_all(fac2)...))
Base.:+(fac1::LinearFactor, fac2::AbstractMultiplyFactor) = LinearFactor((multiply_factor_to_all(fac1)..., fac2))
Base.:+(fac1::LinearFactor, fac2::LinearFactor) = LinearFactor((multiply_factor_to_all(fac1)..., multiply_factor_to_all(fac2)...))

# Operator
Base.:+(num_or_fac::Union{Number, AbstractNamedFactor}, op::AbstractBasicOperator) = LinearOperator([num_or_fac * IdentityOperator(), 1 * op])
Base.:+(op::AbstractBasicOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = LinearOperator([1 * op, num_or_fac * IdentityOperator()])
Base.:+(num_or_fac::Union{Number, AbstractNamedFactor}, op::MultiplyOperator) = LinearOperator([num_or_fac * IdentityOperator(), op])
Base.:+(op::MultiplyOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = LinearOperator([op, num_or_fac * IdentityOperator()])
Base.:+(num_or_fac::Union{Number, AbstractNamedFactor}, op::LinearOperator) = LinearOperator([num_or_fac * IdentityOperator(), multiply_factor_to_all(op).operators...])
Base.:+(op::LinearOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = LinearOperator([multiply_factor_to_all(op).operators..., num_or_fac * IdentityOperator()])

Base.:+(op1::AbstractBasicOperator, op2::AbstractBasicOperator) = LinearOperator([1 * op1, 1 * op2])
Base.:+(op1::AbstractBasicOperator, op2::MultiplyOperator) = LinearOperator([1 * op1, op2])
Base.:+(op1::MultiplyOperator, op2::AbstractBasicOperator) = LinearOperator([op1, 1 * op2])
Base.:+(op1::AbstractBasicOperator, op2::LinearOperator) = LinearOperator([1 * op1, multiply_factor_to_all(op2).operators...])
Base.:+(op1::LinearOperator, op2::AbstractBasicOperator) = LinearOperator([multiply_factor_to_all(op1).operators..., 1 * op2])

Base.:+(op1::MultiplyOperator, op2::MultiplyOperator) = LinearOperator([op1, op2])
Base.:+(op1::MultiplyOperator, op2::LinearOperator) = LinearOperator([op1, multiply_factor_to_all(op2).operators...])
Base.:+(op1::LinearOperator, op2::MultiplyOperator) = LinearOperator([multiply_factor_to_all(op1).operators..., op2])

Base.:+(op1::LinearOperator, op2::LinearOperator) = LinearOperator([multiply_factor_to_all(op1).operators..., multiply_factor_to_all(op2).operators...])


# =============== minus ===============
# Factor
Base.:-(num_or_fac1::Union{Number, AbstractNamedFactor}, num_or_fac2::Union{Number, AbstractNamedFactor}) = num_or_fac1 + (-num_or_fac2)

# Operator
Base.:-(num_or_fac::Union{Number, AbstractNamedFactor}, op::AbstractOperator) = num_or_fac + (-op)
Base.:-(op::AbstractOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = op + (-num_or_fac)
Base.:-(op1::AbstractOperator, op2::AbstractOperator) = op1 + (-op2)


# =============== multiply ===============
# Factor
Base.:*(fac::AbstractNamedFactor, num::Number) = num * fac
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, fac::SymbolFactor) = typeof(fac)(fac.name, num_or_fac * fac.factor)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, fac::KroneckerDelta{S}) where S = typeof(fac)(fac.name, fac.subscripts, num_or_fac * fac.factor)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, fac::NumberFactor) = typeof(fac)(fac.name, fac.value, num_or_fac * fac.factor)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, fac::OperatorFactor) = typeof(fac)(fac.name, fac.subscripts, fac.values, num_or_fac * fac.factor)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, fac::LinearFactor) = typeof(fac)(fac.summation, num_or_fac * fac.factor)

# Operator
Base.:*(op::AbstractBasicOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = MultiplyOperator(op, num_or_fac)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, op::AbstractBasicOperator) = MultiplyOperator(op, num_or_fac)
Base.:*(op::MultiplyOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = MultiplyOperator(op.operators, op.factor * num_or_fac)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, op::MultiplyOperator) = MultiplyOperator(op.operators, num_or_fac * op.factor)
Base.:*(op::LinearOperator, num_or_fac::Union{Number, AbstractNamedFactor}) = LinearOperator(op.operators, op.factor * num_or_fac)
Base.:*(num_or_fac::Union{Number, AbstractNamedFactor}, op::LinearOperator) = LinearOperator(op.operators, num_or_fac * op.factor)

Base.:*(op1::AbstractBasicOperator, op2::AbstractBasicOperator) = MultiplyOperator([op1, op2], 1)
Base.:*(op1::MultiplyOperator, op2::AbstractBasicOperator) = MultiplyOperator([op1.operators..., op2], op1.factor)
Base.:*(op1::AbstractBasicOperator, op2::MultiplyOperator) = MultiplyOperator([op1, op2.operators...], op2.factor)
Base.:*(op1::LinearOperator, op2::AbstractBasicOperator) = LinearOperator(map(x->x*op2, op1.operators), op1.factor)
Base.:*(op1::AbstractBasicOperator, op2::LinearOperator) = LinearOperator(map(x->op1*x, op2.operators), op2.factor)

Base.:*(op1::MultiplyOperator, op2::MultiplyOperator) = MultiplyOperator([op1.operators..., op2...], op1.factor * op2.factor)
Base.:*(op1::LinearOperator, op2::MultiplyOperator) = LinearOperator(map(x->x*op2, op1.operators), op1.factor)
Base.:*(op1::MultiplyOperator, op2::LinearOperator) = LinearOperator(map(x->op1*x, op2.operators), op2.factor)

Base.:*(op1::LinearOperator, op2::LinearOperator) = LinearOperator([x*y for x in op1.operators for y in op2.operators], op1.factor * op2.factor)
