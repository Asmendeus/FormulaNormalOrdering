"""
    struct KroneckerDelta <: AbstractFactor where T<:Union{Symbol, AbstractString, Number}
        name::AbstractString
        subscript::NTuple{2, T}
        fac::Number
    end

# Fields
- `name::AbstractString`: "1", "0" or LaTeXString("\\delta_{\$(subscript[1]),\$(subscript[2])}")
- `subscript::NTuple{2, T}`
- `fac::Number`
"""
struct KroneckerDelta{T} <: AbstractFactor where T<:Union{Symbol, AbstractString, Number}
    name::Union{AbstractString, Symbol}
    subscript::NTuple{2, T}
    fac::Number
    function KroneckerDelta(name::Union{AbstractString, Symbol}, subscript::NTuple{2, T}, fac::Number=1) where T<:Union{Symbol, AbstractString, Number}
        return new{T}(name, subscript, fac)
    end
end
const KDelta = KroneckerDelta