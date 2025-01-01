"""
    struct KroneckerDelta{T, S} <: AbstractMultiplyFactor{T} where S
        name::Union{Symbol, AbstractString}
        subscripts::Tuple{Vararg{AbstractSubscript{S}}}
        factor::Union{Number, AbstractNamedFactor{T}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscripts::Tuple{Vararg{AbstractSubscript{S}}}`
- `factor::Union{Number, AbstractNamedFactor}`

# Description
`KroneckerDelta` is actually a special `OperatorFactor`, representing a general Kronecker delta δ_{i,j,⋯}.
It is separated out because it plays an important role in operator swapping.

# Value
When the factor type `T` is :certain,
    value(δ::KroneckerDelta) = value(δ.factor)      if allequal(δ.subscripts) == true
                             = 0                    if allequal(δ.subscripts) == false

# Recommended name
If you only view the output text, a recommended name is ":δ",
If you want to export to LaTeX text, a recommended name is "\\delta".
"""
struct KroneckerDelta{T, S} <: AbstractMultiplyFactor{T} where S
    name::Union{Symbol, AbstractString}
    subscripts::Tuple{Vararg{AbstractSubscript{S}}}
    factor::Union{Number, AbstractNamedFactor{T}}

    function KroneckerDelta(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript{S}}}, factor::AbstractNamedFactor{T}) where {T, S}
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        length(subscripts) > 1 || throw(FactorError("KroneckerDelta needs at least two subscripts"))
        return new{T, S}(name, subscripts, factor)
    end
    function KroneckerDelta{T}(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript{S}}}, factor::Number) where {T, S}
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        length(subscripts) > 1 || throw(FactorError("KroneckerDelta needs at least two subscripts"))
        return new{T, S}(name, subscripts, factor)
    end
end
const KDelta = KroneckerDelta

getSubType(::KroneckerDelta{T, S}) where {T, S} = S


# Tree
children(fac::KroneckerDelta) = fac.factor
