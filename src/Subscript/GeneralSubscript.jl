"""
    struct GeneralSubscript{T, S} <: AbstractSubscript{T} where S <: Union{SymbolType, CertainType}
        subscript::S
    end

# Fields
- `subscript::Union{SymbolType, CertainType}`: the value of the subscript.

# Usage
Comparisons can only be made when the two subscripts are in the same parameter dimension `T`.
If `S <: SymbolType`, the degree of freedom of the parameter dimension `T` is symbolically represented;
otherwise `S <: CertainType`, the value of the subscript has a clear meaning.
See the README file for more details.
"""
struct GeneralSubscript{T, S} <: AbstractSubscript{T, S}
    subscript::S

    function GeneralSubscript{T}(subscript::S) where {T, S <: Union{SymbolType, CertainType}}
        return new{T, S}(subscript)
    end
end
const GSubscript{T, S} = GeneralSubscript{T, S}

const Site{S} = GeneralSubscript{:site, S}
const Spin{S} = GeneralSubscript{:spin, S}
const Orbital{S} = GeneralSubscript{:orbital, S}
const Layer{S} = GeneralSubscript{:layer, S}
