# =============== Factor ===============
value(num::Number) = Number

function value(fac::AbstractNamedFactor{:symbol})
    throw(FactorTypeError("`value` is unavailable with the factor type `:symbol`!"))
end
value(fac::KroneckerDelta{:certain}) = allequal(fac.subscripts) ? value(fac.factor) : 0
value(fac::NumberFactor{:certain}) = fac.value * value(fac.factor)
value(fac::OperatorFactor{:certain}) = fac.values[fac.subscripts] * value(fac.factor)
value(fac::LinearFactor{:certain}) = sum(value, fac.summation) * value(fac.factor)