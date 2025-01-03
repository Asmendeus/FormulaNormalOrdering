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
