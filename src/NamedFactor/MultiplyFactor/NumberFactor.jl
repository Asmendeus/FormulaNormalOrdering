"""
    struct NumberFactor <: AbstractMultiplyFactor
        name::Union{Symbol, AbstractString}
        value::Number
        factor::Union{Number, AbstractNamedFactor}
    end

# Fields
- `name::Union{Symbol, AbstractString}`
- `value::Number`
- `factor::Union{Number, AbstractNamedFactor}`

# Description
`NamedFactor` is a factor with a certain value.
"""
struct NumberFactor <: AbstractMultiplyFactor
    name::Union{Symbol, AbstractString}
    value::Number
    factor::Union{Number, AbstractNamedFactor}

    function NumberFactor(name::Union{Symbol, AbstractString}, value::Number, factor::Union{Number, AbstractNamedFactor}=1)
        return factor == 0 ? 0 : new(name, value, factor)
    end
end
const NFactor = NumberFactor


# Tree
children(fac::NumberFactor) = fac.factor
