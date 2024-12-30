struct Subscript{T, S} <: AbstractSubscript{T, S}
    label::S

    function Subscript{T}(label::S) where {T, S <: Union{Symbol, AbstractString, Number}}
        return new{T, S}(label)
    end
end

const Site{S} = GeneralSubscript{:site, S}
const Spin{S} = GeneralSubscript{:spin, S}
const Orbital{S} = GeneralSubscript{:orbital, S}
const Layer{S} = GeneralSubscript{:layer, S}
