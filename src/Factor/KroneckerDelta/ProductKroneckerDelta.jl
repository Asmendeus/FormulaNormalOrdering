"""
    struct ProductKroneckerDelta <: AbstractKroneckerDelta
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{NTuple{<:Integer, <:AbstractSubscript}}}
        factor::Union{Number, AbstractGeneralFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{NTuple{<:Integer, <:AbstractSubscript}}}`
- `factor::Union{Number, AbstractGeneralFactor}`

# Usage
`ProductKroneckerDelta` is the product of a series of `KroneckerDelta{T}` with different `T`.
"""
struct ProductKroneckerDelta{T} <: AbstractKroneckerDelta
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{NTuple{<:Integer, <:AbstractSubscript}}}
    factor::Union{Number, AbstractGeneralFactor}

    function ProductKroneckerDelta(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{NTuple{<:Integer, <:AbstractSubscript}}}, factor::Union{Number, AbstractGeneralFactor})
        T = Union{(typeof(x[1]) for x in subscript)...}
        return new{T}(name, subscript, factor)
    end
end
const PKDelta = ProductKroneckerDelta
