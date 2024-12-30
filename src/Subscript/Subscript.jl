"""
    struct Subscript{T, S} <: AbstractSubscript{T, S}
        label::Union{Symbol, AbstractString, Number}
    end

# Field(s)
- `label::Union{Symbol, AbstractString, Number}`: the value of the subscript

# For dev
The data type of `label` can be expanded, as long as the new type can be stringed, i.e., string(::newType).
"""
struct Subscript{T, S} <: AbstractSubscript{T, S}
    label::Union{Symbol, AbstractString, Number}

    function Subscript{T, S}(label::Union{Symbol, AbstractString, Number}) where {T, S}
        T in (:symbol, :certain) || throw(FormulaTypeError("The type `T` of Subscript{T, S} should be in (:Symbol, :Certain)"))
        return new{T, S}(label)
    end
    function Subscript(T::Symbol, S::Symbol, label::Union{Symbol, AbstractString, Number})
        T in (:symbol, :certain) || throw(FormulaTypeError("The type `T` of Subscript{T, S} should be in (:Symbol, :Certain)"))
        return new{T, S}(label)
    end
end

getSubLabel(sub::Subscript) = sub.label

# Preset subscript dimension
const Site{T} = Subscript{T, :site}
Site(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Site{T}(label)

const Spin{T} = Subscript{T, :spin}
Spin(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Spin{T}(label)

const Orbital{T} = Subscript{T, :orbital}
Orbital(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Orbital{T}(label)

const Layer{T} = Subscript{T, :layer}
Layer(T::Symbol, label::Union{Symbol, AbstractString, Number}) = Layer{T}(label)
