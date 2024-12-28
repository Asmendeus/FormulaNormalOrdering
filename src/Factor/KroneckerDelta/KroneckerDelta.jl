"""
    struct KroneckerDelta{N, T, S} <: AbstractKroneckerDelta{S} where {N, T}
        name::Union{AbstractString, Symbol}
        subscript::NTuple{N, AbstractSubscript{T, S}}
        factor::Union{Number, AbstractGeneralFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`: recommanded names are `"\\delta"` and `:δ`
- `subscript::NTuple{N, AbstractSubscript{T, S}}`
- `factor::Union{Number, AbstractGeneralFactor}`

# Usage
A `KroneckerDelta` will be introduced when swapping two annihilation/creation operators.
If two `KroneckerDelta` have same `T` and at least one same value of subscript, they multiply together
to be a new `KroneckerDelta` with `T`, otherwise the product will become a `ProductKroneckerDelta`.
"""
struct KroneckerDelta{N, T, S} <: AbstractKroneckerDelta{S} where {N, T}
    name::Union{AbstractString, Symbol}
    subscript::NTuple{N, AbstractSubscript{T, S}}
    factor::Union{Number, AbstractGeneralFactor}

    function KroneckerDelta(name::Union{AbstractString, Symbol}, subscript::NTuple{N, AbstractSubscript{T, S}}, factor::Union{Number, AbstractGeneralFactor}) where {N, T, S}
        @assert N > 1
        return new{N, T, S}(name, subscript, factor)
    end
end
const KDelta = KroneckerDelta
