# =============== Subscript ===============
text(sub::GeneralSubscript) = string(sub.subscript)


# =============== Factor ===============
text(fac::Number)::LaTeXString = string(fac)
text(fac::NumberFactor)::LaTeXString = string(fac.factor) * "*" * string(fac.name)
function text(fac::KroneckerDelta{N, T, S})::LaTeXString where {N, T, S}
    return string(text(fac.factor)) * "*" * string(fac.name) * "_{$(_string_subscript(fac.subscript))}"
end
function text(fac::ProductKroneckerDelta{T})::LaTeXString where T
    str = string(text(fac.factor)) * "*"
    for subpair in fac.subscript
        str *= string(fac.name) * "_{$(_string_subscript(subpair))}"
    end
    return str
end


# =============== Operator ===============
function text(op::Union{BosonAnnihilationOperator, FermionAnnihilationOperator})::LaTeXString
    return string(op.name) * "_{$(_string_subscript(op.subscript))}"
end
function text(op::Union{BosonCreationOperator, FermionCreationOperator})::LaTeXString
    return string(op.name) * "^\\dag" * "_{$(_string_subscript(op.subscript))}"
end
function text(op::GeneralSingleOperator)::LaTeXString
    isempty(op.ops) && return text(op.factor)
    str = string(text(op.factor)) * " × "
    for o in op.ops
        str *= string(text(o))
    end
    return str
end
function text(op::GeneralMultiOperator)::LaTeXString
    str = string(text(op.ops[1]))
    for i in 2:length(op.ops)
        if isempty(text(op.ops[i]))
            continue
        elseif text(op.ops[i])[1] != '-'
            str *= " + " * string(text(op.ops[i]))
        else
            str *= " - " * string(text(op.ops[i]))[2:end]
        end
    end
    return str
end


function _string_subscript(subscript::Tuple{Vararg{AbstractSubscript}})::String
    str = string(text(subscript[1]))
    for item in subscript[2:end]
        str *= "," * string(text(item))
    end
    return str
end
