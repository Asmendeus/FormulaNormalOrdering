# =============== Subscript ===============
text(sub::Subscript)::LaTeXString = string(getSubLabel(sub))


# =============== Factor ===============
function text(num::Number)::LaTeXString
    if num == 1
        return ""
    elseif num == -1
        return "-"
    else
        return string(num) * " × "
    end
end
text(fac::KroneckerDelta)::LaTeXString = text(fac.factor) * "_{$(_string_subscripts(fac.subscripts))}"
text(fac::NumberFactor)::LaTeXString = text(fac.factor) * string(fac.name)
text(fac::OperatorFactor)::LaTeXString = text(fac.factor) * string(fac.name) * "_{$(_string_subscripts(fac.subscripts))}"
function text(fac::LinearFactor)
    str = text(fac.factor) * "(" * (isa(fac.summation[1], Number) ? string(fac.summation[1]) : text(fac.summation[1]))
    for i in 2:length(fac.summation)
        _temptext = isa(fac.summation[i], Number) ? string(fac.summation[i]) : text(fac.summation[i])
        if _temptext[1] == '-'
            str *= " - " * _temptext[2:end]
        else
            str *= " + " * _temptext
        end
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