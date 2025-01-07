"""
    struct OperatorFactor <: AbstractMultiplyFactor
        name::Union{Symbol, AbstractString}
        subscripts::Tuple{Vararg{AbstractSubscript}}
        values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}
        factor::Union{Number, AbstractNamedFactor}
    end

# Fields
- `name::Union{Symbol, AbstractString}`
- `subscripts::Tuple{Vararg{AbstractSubscript}}`
- `values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}`
- `factor::Union{Number, AbstractNamedFactor}`

# Description
`OperatorFactor` is a factor whose value depends on the subscripts.
All of possible values are stored in `values`, and its value is selected by `subscripts` in `:certain` type.
"""
struct OperatorFactor <: AbstractMultiplyFactor
    name::Union{Symbol, AbstractString}
    subscripts::Tuple{Vararg{AbstractSubscript}}
    values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}
    factor::Union{Number, AbstractNamedFactor}

    function OperatorFactor(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript}}, values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}, factor::Union{Number, AbstractNamedFactor}=1)
        return factor == 0 ? 0 : new(name, subscripts, values, factor)
    end
    function OperatorFactor(name::Union{Symbol, AbstractString}, subscript::AbstractSubscript, values::Dict{<:AbstractSubscript, <:Number}, factor::Union{Number, AbstractNamedFactor}=1)
        return factor == 0 ? 0 : new(name, (subscript,), Dict((key,)=>value for (key, value) in values), factor)
    end
end
const OFactor = OperatorFactor


# Tree
children(fac::OperatorFactor) = fac.factor
