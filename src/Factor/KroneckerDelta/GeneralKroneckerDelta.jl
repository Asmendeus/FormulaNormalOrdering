"""
    struct GeneralKroneckerDelta <: AbstractKroneckerDelta
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}
        factor::Union{Number, GeneralFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}`
- `factor::Union{Number, GeneralFactor}`
"""
struct GeneralKroneckerDelta <: AbstractKroneckerDelta
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}
    factor::Union{Number, GeneralFactor}
    function GeneralKroneckerDelta(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}, factor::Union{Number, GeneralFactor}=1)
        return new(name, subscript, factor)
    end
end
const GKDelta = GeneralKroneckerDelta