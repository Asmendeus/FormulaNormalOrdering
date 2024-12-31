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
Site(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Site(label)

const Spin = Subscript{:spin}
Spin(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Spin(label)

const Orbital = Subscript{:orbital}
Orbital(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Orbital(label)

const Layer = Subscript{:layer}
Layer(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Layer(label)
