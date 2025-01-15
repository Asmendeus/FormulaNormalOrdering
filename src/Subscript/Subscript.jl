"""
    struct Subscript{S} <: AbstractSubscript{S}
        label::Union{Symbol, AbstractString, Number}
    end

# Field(s)
- `label::Union{Symbol, AbstractString, Number}`: the value of the subscript

# For dev
The data type of `label` can be expanded, as long as the new type can be stringed, i.e., string(::newType).
"""
struct Subscript{S} <: AbstractSubscript{S}
    label::Union{Symbol, AbstractString, Number}

    function Subscript{S}(label::Union{Symbol, AbstractString, Number}) where S
        return new{S}(label)
    end
    function Subscript(S::Symbol, label::Union{Symbol, AbstractString, Number})
        return new{S}(label)
    end
end

getSubLabel(sub::Subscript) = sub.label

# Preset subscript dimension
const Site = Subscript{:site}
const Spin = Subscript{:spin}
const Orbital = Subscript{:orbital}
const Layer = Subscript{:layer}
const Kpoint = Subscript{:kpoint}
