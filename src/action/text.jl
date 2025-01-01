# =============== Subscript ===============
text(sub::Subscript)::LaTeXString = string(getSubLabel(sub))


# =============== Factor ===============
text(num::Number)::LaTeXString = string(num) * " × "
text(fac::KroneckerDelta)::LaTeXString = text(fac.factor) * string(fac.name) * "_{$(_string_subscripts(fac.subscripts))}"
text(fac::NumberFactor)::LaTeXString = text(fac.factor) * string(fac.name)
text(fac::OperatorFactor)::LaTeXString = text(fac.factor) * string(fac.name) * "_{$(_string_subscripts(fac.subscripts))}"
function text(fac::LinearFactor)
    str = text(fac.factor) * "(" * (isa(fac.summation[1], Number) ? string(fac.summation[1]) : text(fac.summation[1]))
    for i in 2:length(fac.summation)
        _temptext = isa(fac.summation[i], Number) ? string(fac.summation[i]) : text(fac.summation[i])
        str *= (_temptext[1] == '-') ? (" - " * _temptext[2:end]) : (" + " * _temptext)
    end
    str *= ")"
    return str
end


# =============== Operator ===============



function _string_subscripts(subs::Tuple{Vararg{AbstractSubscript}})::String
    str = string(text(subs[1]))
    for sub in subs[2:end]
        str *= "," * string(text(sub))
    end
    return str
end