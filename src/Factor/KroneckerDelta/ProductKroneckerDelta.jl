"""
    struct ProductKroneckerDelta{S} <: AbstractKroneckerDelta{S}
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{NTuple{<:Integer, <:AbstractSubscript}}}
        factor::Union{Number, AbstractGeneralFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{NTuple{<:Integer, <:AbstractSubscript}}}`
- `factor::Union{Number, AbstractGeneralFactor}`

# Usage
`ProductKroneckerDelta{S′}` is the product of a series of `KroneckerDelta{S}`, S′ = Union{S...}.
"""
struct ProductKroneckerDelta{S} <: AbstractKroneckerDelta{S}
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{Tuple{Vararg{AbstractSubscript}}}}
    factor::Union{Number, AbstractGeneralFactor}

    function ProductKroneckerDelta(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{Tuple{Vararg{AbstractSubscript}}}}, factor::Union{Number, AbstractGeneralFactor})
        all(x->length(x)>1, subscript) || throw(ArgumentError("Every KroneckerDelta in ProductKroneckerDelta should have at least 2 subscript."))
        all((allequal(map(y->getSubDim(y), x)) for x in subscript)) || throw(SubscriptDimensionError("Mismatched subscript dimensions!"))
        S = Union{(getSubType(x) for x in Iterators.flatten(subscript))...}
        S <: SymbolType || S <: CertainType || throw(SubscriptTypeError("The combination of `SymbolType` and `CertainType` is forbidden!"))
        return new{S}(name, subscript, factor)
    end
end
const PKDelta = ProductKroneckerDelta
