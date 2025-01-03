"""
    struct SymbolFactor <: AbstractMultiplyFactor
        name::Union{Symbol, AbstractString}
        factor::Union{Number, AbstractNamedFactor}
    end

# Description
    `SymbolFactor` is a factor struct suitable for plain formula text that has no definite value,
only a `name` and `factor` that supports nested structures. If you only want to return the formula
text, you can set all the coefficients to it.
"""
struct SymbolFactor <: AbstractMultiplyFactor
    name::Union{Symbol, AbstractString}
    factor::Union{Number, AbstractNamedFactor}

    function SymbolFactor(name::Union{Symbol, AbstractString}, factor::Union{Number, AbstractNamedFactor}=1)
        return factor == 0 ? 0 : new(name, factor)
    end
end
const SFactor = SymbolFactor
