"""
    struct GeneralKroneckerDelta <: AbstractFactor
        name::AbstractString
        subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}
        fac::Number
    end

# Fields
- `name::AbstractString`
- `subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}`
- `fac::Number`
"""
struct GeneralKroneckerDelta <: AbstractFactor
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}
    fac::Number
    function GeneralKroneckerDelta(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{NTuple{2, <:Union{Symbol, AbstractString, Number}}}}, fac::Number=1)
        return new(name, subscript, fac)
    end
end
const GKDelta = GeneralKroneckerDelta