text(fac::Number)::LaTeXString = string(fac)
text(fac::NumberFactor)::LaTeXString = string(fac.factor) * " * " * string(fac.name)
function text(fac::KroneckerDelta{T})::LaTeXString where T<:Union{Symbol, AbstractString, Number}
    return string(text(fac.factor)) * " * " * string(fac.name) * "_{$(_string_subscript(op.subscript.subscript))}"
end
function text(fac::ProductKroneckerDelta)::LaTeXString
    str = string(text(fac.factor)) * " * "
    for subpair in fac.subscript
        str *= string(fac.name) * "_{$(_string_subscript(subpair.subscript))}"
    end
    return str
end


function text(op::Union{BosonAnnihilationOperator, FermionAnnihilationOperator})::LaTeXString
    return string(op.name) * "_{$(_string_subscript(op.subscript.subscript))}"
end
function text(op::Union{BosonCreationOperator, FermionCreationOperator})::LaTeXString
    return string(op.name) * "^\\dag" * "_{$(_string_subscript(op.subscript.subscript))}"
end
function text(op::GeneralSingleOperator)::LaTeXString
    str = string(text(op.factor)) * " * "
    for o in op.ops
        str *= string(text(o))
    end
    return str
end
function text(op::GeneralMultiOperator)::LaTeXString
    str = string(text(op.ops[1]))
    for i in 2:length(op.ops)
        if text(op.ops[i])[1] != '-'
            str *= " + " * string(text(op.ops[i]))
        else
            str *= " - " * string(text(op.ops[i]))[2:end]
        end
    end
    return str
end


function _string_subscript(subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}})::String
    @assert !isempty(subscript) "The subscript is empty!"
    str = string(subscript[1])
    for item in subscript[2:end]
        str *= ","
        str *= typeof(item) <: AbstractString ? item : string(item)
    end
    return str
end