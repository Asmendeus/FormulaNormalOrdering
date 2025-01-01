"""
    struct NumberFactor{T} <: AbstractMultiplyFactor{T}
        name::Union{Symbol, AbstractString}
        value::Number
        factor::Union{Number, AbstractNamedFactor{T}}
    end

# Fields
- `name::Union{Symbol, AbstractString}`
- `value::Number`
- `factor::Union{Number, AbstractNamedFactor{T}}`

# Description
`NamedFactor` is a factor with a certain value.
"""
struct NumberFactor{T} <: AbstractMultiplyFactor{T}
    name::Union{Symbol, AbstractString}
    value::Number
    factor::Union{Number, AbstractNamedFactor{T}}

    function NumberFactor(name::Union{Symbol, AbstractString}, value::Number, factor::AbstractNamedFactor{T}) where T
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        return new{T}(name, value, factor)
    end
    function NumberFactor{T}(name::Union{Symbol, AbstractString}, value::Number, factor::Number=1) where T
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        return factor == 0 ? 0 : new{T}(name, value, factor)
    end
end
const NFactor = NumberFactor


# Tree
children(fac::NumberFactor) = fac.factor
