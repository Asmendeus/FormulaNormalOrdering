"""
    struct KroneckerDelta{S} <: AbstractMultiplyFactor where S
        name::Union{Symbol, AbstractString}
        subscripts::Tuple{Vararg{AbstractSubscript{S}}}
        factor::Union{Number, AbstractNamedFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscripts::Tuple{Vararg{AbstractSubscript{S}}}`
- `factor::Union{Number, AbstractNamedFactor}`

# Description
`KroneckerDelta` is actually a special `OperatorFactor`, representing a general Kronecker delta δ_{i,j,⋯}.
It is separated out because it plays an important role in operator swapping.

# Value
value(δ::KroneckerDelta) = value(δ.factor)      if allequal(δ.subscripts) == true
                         = 0                    if allequal(δ.subscripts) == false
"""
struct KroneckerDelta{S} <: AbstractMultiplyFactor where S
    name::Union{Symbol, AbstractString}
    subscripts::Tuple{Vararg{AbstractSubscript{S}}}
    factor::Union{Number, AbstractNamedFactor}

    function KroneckerDelta{S}(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript{S}}}, factor::Union{Number, AbstractNamedFactor}=1) where S
        length(subscripts) > 1 || throw(FactorError("KroneckerDelta needs at least two subscripts"))
        return factor == 0 ? 0 : new{S}(name, subscripts, factor)
    end
    function KroneckerDelta(name::Union{Symbol, AbstractString}, subscripts::Tuple{Vararg{AbstractSubscript{S}}}, factor::Union{Number, AbstractNamedFactor}=1) where S
        length(subscripts) > 1 || throw(FactorError("KroneckerDelta needs at least two subscripts"))
        return factor == 0 ? 0 : new{S}(name, subscripts, factor)
    end
end
const KDelta = KroneckerDelta

getSubType(::KroneckerDelta{S}) where S = S


# Tree
children(fac::KroneckerDelta) = fac.factor
