"""
    value(fac_op::Union{AbstractNamedFactor, Number, AbstractOperator})

# Description
Return a certain value for factors.
"""
function value(fac_op::Union{AbstractNamedFactor, Number, AbstractOperator}) end

# =============== Factor ===============
value(num::Number) = num

function value(fac::SymbolFactor)
    throw(FactorError("A `SymbolFactor` can't get a value!"))
end
value(fac::KroneckerDelta) = allequal(fac.subscripts) ? value(fac.factor) : 0
value(fac::NumberFactor) = fac.value * value(fac.factor)
function value(fac::OperatorFactor)
    fac.subscripts in keys(fac.values) || throw(FactorError("No value matches the subscripts $(fac.subscripts)!"))
    return fac.values[fac.subscripts] * value(fac.factor)
end
value(fac::LinearFactor) = sum(value, fac.summation) * value(fac.factor)

# =============== Operator ===============
value(op::AbstractBasicOperator) = op
value(op::MultiplyOperator) = MultiplyOperator(op.operators, value(op.factor))
function value(op::LinearOperator)
    _tempsum = map(value, op.operators)
    _tempsum = eltype(_tempsum) <: AbstractMultiplyFactor ? _tempsum : [_tempsum[i] for i in findall(x->x!=0, _tempsum)]
    return LinearOperator(_tempsum, value(op.factor))
end
