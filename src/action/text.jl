"""
    text(sub_fac_op::Union{AbstractSubscript, AbstractNamedFactor, Number, AbstractOperator})

# Description
Export LaTeX text of the argument.
"""
function text(sub_fac_op::Union{AbstractSubscript, AbstractNamedFactor, Number, AbstractOperator}) end

# =============== Subscript ===============
text(sub::Subscript)::LaTeXString = string(getSubLabel(sub))


# =============== Factor ===============
#? TODO: Text can be simplified when factor is 1 or -1
text(num::Number)::LaTeXString = string(num)
text(fac::SymbolFactor)::LaTeXString = text(fac.factor) * (isa(fac.factor, Number) ? " × " : "") * string(fac.name)
text(fac::KroneckerDelta)::LaTeXString = text(fac.factor) * (isa(fac.factor, Number) ? " × " : "") * string(fac.name) * "_{$(_string_subscripts(fac.subscripts))}"
text(fac::NumberFactor)::LaTeXString = text(fac.factor) * (isa(fac.factor, Number) ? " × " : "") * string(fac.name)
text(fac::OperatorFactor)::LaTeXString = text(fac.factor) * (isa(fac.factor, Number) ? " × " : "") * string(fac.name) * "_{$(_string_subscripts(fac.subscripts))}"
function text(fac::LinearFactor)
    str = text(fac.factor) * (isa(fac.factor, Number) ? " × " : "")
    str *= "("
    str *= text(fac.summation[1])
    for f in fac.summation[2:end]
        str *= (text(f)[1] == '-') ? (" - " * text(f)[2:end]) : (" + " * text(f))
    end
    str *= ")"
    return str
end


# =============== Operator ===============
#? TODO: Text can be simplified when factor is 1 or -1
function text(op::AnyonOperator{θ, K})::LaTeXString where {θ, K}
    return string(op.name) * (getOpType(op) == :a ? "" : "^\\dag") * "_{$(_string_subscripts(op.subscripts))}"
end
text(op::IdentityOperator)::LaTeXString = string(op.name)
function text(op::MultiplyOperator)::LaTeXString
    str = text(op.factor) * " × "
    for o in op.operators
        str *= text(o)
    end
    return str
end
function text(op::LinearOperator)::LaTeXString
    str = text(op.factor) * " × "
    str *= "("
    str *= text(op.operators[1])
    for o in op.operators[2:end]
        str *= text(o)[1] == '-' ? " - " * text(o)[2:end] : " + " * text(o)
    end
    str *= ")"
    return str
end


# =============== built-in function ===============
function _string_subscripts(subs::Tuple{Vararg{AbstractSubscript}})::String
    str = string(text(subs[1]))
    for sub in subs[2:end]
        str *= "," * string(text(sub))
    end
    return str
end
