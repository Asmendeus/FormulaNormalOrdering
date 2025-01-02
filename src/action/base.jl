################ IO ################
function Base.show(io::IO, op::AbstractNamedFactor)
    print(io, text(op))
end
# function Base.show(io::IO, op::AbstractOperator)
#     print(io, text(op))
# end



############### math ###############
# =============== equality ===============
# Subscript
Base.(==)(sub1::Subscript{S}, sub2::Subscript{S}) = (sub1.label == sub2.label)

# Factor
function Base.:(==)(fac1::KroneckerDelta{T, S}, fac2::KroneckerDelta{T, S}) where {T, S}
    return (Set(fac1.subscripts) == Set(fac2.subscripts)) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::NumberFactor{T}, fac2::NumberFactor{T}) where T
    return (fac1.name == fac2.name) && (fac1.value == fac2.value) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::OperatorFactor{T}, fac2::OperatorFactor{T}) where T
    return (fac1.name == fac2.name) && (fac1.subscripts == fac2.subscripts) && (fac1.values == fac2.values) && (fac1.factor == fac2.factor)
end
function Base.:(==)(fac1::LinearFactor{T}, fac2::LinearFactor{T}) where T
    return (Set(fac1.summation) == Set(fac2.summation)) && (fac1.factor == fac2.factor)
end

# =============== negative ===============
# Factor
Base.:-(fac::KroneckerDelta) = typeof(fac)(fac.name, fac.subscripts, -fac.factor)
Base.:-(fac::NumberFactor) = typeof(fac)(fac.name, fac.value, -fac.factor)
Base.:-(fac::OperatorFactor) = typeof(fac)(fac.name, fac.subscripts, fac.values, -fac.factor)
Base.:-(fac::LinearFactor) = typeof(fac)(fac.summation, -fac.factor)


# =============== addition ===============
# Factor
#? TODO: Merging can be done based on tree structure
Base.:+(num::Number, fac::AbstractMultiplyFactor) = LinearFactor([num, fac], 1)
Base.:+(fac::AbstractMultiplyFactor, num::Number) = LinearFactor([fac, num], 1)
Base.:+(fac1::AbstractMultiplyFactor{T}, fac2::AbstractMultiplyFactor{T}) where T = LinearFactor([fac1, fac2], 1)
Base.:+(num::Number, fac::LinearFactor) = LinearFactor([multiply_factor_to_all(fac)..., num], 1)
Base.:+(fac::LinearFactor, num::Number) = LinearFactor([num, multiply_factor_to_all(fac)...], 1)
Base.:+(fac1::AbstractMultiplyFactor{T}, fac2::LinearFactor{T}) where T = LinearFactor([fac1, multiply_factor_to_all(fac2)...], 1)
Base.:+(fac1::LinearFactor{T}, fac2::AbstractMultiplyFactor{T}) where T = LinearFactor([multiply_factor_to_all(fac1)..., fac2], 1)
Base.:+(fac1::LinearFactor{T}, fac2::LinearFactor{T}) where T = LinearFactor([multiply_factor_to_all(fac1)..., multiply_factor_to_all(fac2)...], 1)


# =============== minus ===============
# Factor
Base.:-(num::Number, fac::AbstractNamedFactor) = num + (-fac)
Base.:-(fac::AbstractNamedFactor, num::Number) = fac + (-num)
Base.:-(fac1::AbstractNamedFactor, fac2::AbstractNamedFactor) = fac1 + (-fac2)


# =============== multiply ===============
# Factor
Base.:*(fac::AbstractNamedFactor, num::Number) = num * fac
Base.:*(num_or_fac::Number, fac::KroneckerDelta) = typeof(fac)(fac.name, fac.subscripts, num_or_fac * fac.factor)
Base.:*(num_or_fac::Number, fac::NumberFactor) = typeof(fac)(fac.name, fac.value, num_or_fac * fac.factor)
Base.:*(num_or_fac::Number, fac::OperatorFactor) = typeof(fac)(fac.name, fac.subscripts, fac.values, num_or_fac * fac.factor)
Base.:*(num_or_fac::Number, fac::LinearFactor) = typeof(fac)(fac.summation, num_or_fac * fac.factor)

