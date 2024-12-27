function text(op::Union{BosonAnnihilationOperator, FermionAnnihilationOperator})::LaTeXString
    return string(op.name) * "_{$(_string_subscript(op.subscript))}"
end
function text(op::Union{BosonCreationOperator, FermionCreationOperator})::LaTeXString
    return string(op.name) * "^\\dag" * "_{$(_string_subscript(op.subscript))}"
end

function text(op::KroneckerDelta{T})::LaTeXString where T<:Union{Symbol, AbstractString, Number}
    if op.subscript[1] == op.subscript[2]
        return "$(op.fac)"
    else
        if T <: Symbol
            return string(op.fac) * " * " * string(op.name) * "_{$(_string_subscript(op.subscript))}"
        else
            return "0"
        end
    end
end
function text(op::GeneralKroneckerDelta)::LaTeXString
    str = string(op.fac) * " * "
    for subpair in op.subscript
        if subpair[1] == subpair[2]
            continue
        elseif eltype(subpair) <: Symbol
            str *= string(op.name) * "_{$(_string_subscript(subpair))}"
        else
            str = "0"
            break
        end
    end
    return str
end

text(num::Number) = string(num)

function text(op::SingleGeneralOperator)::LaTeXString
    str = string(text(op.fac))
    str == "0" && return LaTeXString("0")
    str *= " * "
    for o in op.ops
        str *= string(text(o))
    end
    return str
end

function text(op::MultiGeneralOperator)::LaTeXString

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