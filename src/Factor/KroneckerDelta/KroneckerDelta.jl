"""
    struct KroneckerDelta{T} <: AbstractKroneckerDelta where T<:Union{Symbol, AbstractString, Number}
        name::Union{AbstractString, Symbol}
        subscript::NTuple{2, T}
        factor::Union{Number, GeneralFactor}
    end

# Fields
- `name::Union{AbstractString, Symbol}`: "1", "0" or LaTeXString("\\delta_{\$(subscript[1]),\$(subscript[2])}")
- `subscript::NTuple{2, T}`
- `factor::Union{Number, GeneralFactor}`
"""
struct KroneckerDelta{T} <: AbstractKroneckerDelta where T<:Union{Symbol, AbstractString, Number}
    name::Union{AbstractString, Symbol}
    subscript::NTuple{2, T}
    factor::Union{Number, GeneralFactor}
    function KroneckerDelta(name::Union{AbstractString, Symbol}, subscript::NTuple{2, T}, factor::Union{Number, GeneralFactor}=1) where T<:Union{Symbol, AbstractString, Number}
        return new{T}(name, subscript, factor)
    end
end
const KDelta = KroneckerDelta