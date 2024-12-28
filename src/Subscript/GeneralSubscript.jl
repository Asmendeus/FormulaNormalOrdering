"""
    struct GeneralSubscript{T, S} <: AbstractSubscript{T} where S <: Union{Symbol, AbstractString, Number}
        subscript::S
    end

# Fields
- `subscript::Union{Symbol, AbstractString, Number}`: the certain value of the subscript.

# Usage
Comparisons can only be made when the two subscripts are in the same parameter dimension `T`.
If `S <: Symbol`, the degree of freedom of the parameter dimension `T` is symbolically represented;
else `S <: Union{AbstractString, Number}`, the value of the subscript has a clear meaning.
See the README file for more details.
"""
struct GeneralSubscript{T, S} <: AbstractSubscript{T} where S <: Union{Symbol, AbstractString, Number}
    subscript::S

    function GeneralSubscript{T}(subscript::S) where {T, S <: Union{Symbol, AbstractString, Number}}
        return new{T, S}(subscript)
    end
end
const GSubscript{T, S} = GeneralSubscript{T, S}

const Site{S} = GeneralSubscript{:site, S}
const Spin{S} = GeneralSubscript{:spin, S}
const Orbital{S} = GeneralSubscript{:orbital, S}
const Layer{S} = GeneralSubscript{:layer, S}
