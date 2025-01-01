"""
    struct OperatorFactor{T} <: AbstractMultiplyFactor{T}
        name::Union{Symbol, AbstractString}
        subscripts::Tuple{Vararg{AbstractSubscript}}
        values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}
        factor::Union{Number, AbstractNamedFactor{T}}
    end

# Fields
- `name::Union{Symbol, AbstractString}`
- `subscripts::Tuple{Vararg{AbstractSubscript}}`
- `values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}`
- `factor::Union{Number, AbstractNamedFactor{T}}`

# Description
`OperatorFactor` is a factor whose value depends on the subscripts.
All of possible values are stored in `values`, and its value is selected by `subscripts` in `:certain` type.
"""
struct OperatorFactor{T} <: AbstractMultiplyFactor{T}
    name::Union{Symbol, AbstractString}
    subscripts::Tuple{Vararg{AbstractSubscript}}
    values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}
    factor::Union{Number, AbstractNamedFactor{T}}

    function OperatorFactor(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript}}, values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}, factor::AbstractNamedFactor{T}) where T
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        T == :certain && !all(sub->(sub in keys(subscripts)), subscripts) && throw(FactorError("No value match the subscripts $(subscripts)!"))
        return new{T}(name, subscripts, values, factor)
    end
    function OperatorFactor{T}(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript}}, values::Dict{<:Tuple{Vararg{AbstractSubscript}}, <:Number}, factor::Number) where T
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        T == :certain && !all(sub->(sub in keys(subscripts)), subscripts) && throw(FactorError("No value match the subscripts $(subscripts)!"))
        return new{T}(name, subscripts, values, factor)
    end
end
const OFactor = OperatorFactor


# Tree
children(fac::OperatorFactor) = fac.factor
