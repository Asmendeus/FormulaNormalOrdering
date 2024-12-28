"""
    struct KroneckerDelta{N, T, S} <: AbstractKroneckerDelta where {N, T, S <: AbstractSubscript{T}}
        name::Union{AbstractString, Symbol}
        subscript::NTuple{N, S}
        factor::Union{Number, AbstractGeneralFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`: recommanded names are `:δ`, `"\\delta"`
- `subscript::NTuple{N, S}`
- `factor::Union{Number, AbstractGeneralFactor}`

# Usage
`T` represents the parameter dimension of the subscript.
A `KroneckerDelta` will be introduced when swapping two annihilation/creation operators.
If different `KroneckerDelta` have the same `T`, they multiply together to be a new `KroneckerDelta`
with the `T`, otherwise the product will become a `ProductKroneckerDelta`.
"""
struct KroneckerDelta{N, T, S} <: AbstractKroneckerDelta where {N, T, S <: AbstractSubscript{T}}
    name::Union{AbstractString, Symbol}
    subscript::NTuple{N, S}
    factor::Union{Number, AbstractGeneralFactor}

    function KroneckerDelta(name::Union{AbstractString, Symbol}, subscript::NTuple{N, S}, factor::Union{Number, AbstractGeneralFactor}) where {N, T, S <: AbstractSubscript{T}}
        @assert N > 1
        return new{N, T, S}(name, subscript, factor)
    end
end
const KDelta = KroneckerDelta
