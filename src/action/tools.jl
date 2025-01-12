"""
    normalize_factor(fac::AbstractNamedFactor)

# Description
return a new named factor that replaces the factor of the input factor with 1
"""
normalize_factor(fac::KroneckerDelta) = typeof(fac)(fac.name, fac.subscripts, 1)
normalize_factor(fac::NumberFactor) = typeof(fac)(fac.name, fac.value, 1)
normalize_factor(fac::OperatorFactor) = typeof(fac)(fac.name, fac.subscripts, fac.values, 1)
normalize_factor(fac::LinearFactor) = typeof(fac)(fac.summation, 1)

"""
    multiply_factor_to_all(fac::AbstractLinearFactor)

# Description
return a new linear factor that multiply the factor to all summation factors
"""
multiply_factor_to_all(fac::LinearFactor) = map(x->fac.factor * x, fac.summation)

"""
    multiply_factor_to_all(op::LinearOperator)

# Description
return a new linear operator that multiply the factor to all summation operators
"""
multiply_factor_to_all(op::LinearOperator) = LinearOperator(map(x->op.factor * x, op.operators))

"""
    isca(op::MultiplyOperator)
    isca(op::LinearOperator)

# Description
Returns a Boolean variable indicating whether all creation operators precede annihilation operators
"""
function isca(op::MultiplyOperator)::Bool
    if length(op.operators) > 1
        _indices = findall(x->getOpType(x)==:c, op.operators)
        return _indices == collect(1:length(_indices))
    else
        return true
    end
end

function isca(op::LinearOperator)::Bool
    return all(isca, op.operators)
end