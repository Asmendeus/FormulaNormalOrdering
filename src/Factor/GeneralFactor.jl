"""
    struct GeneralFactor <: AbstractFactor
        name::Union{AbstractString, Symbol}
        value::Number
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `value::Number`
"""
struct GeneralFactor <: AbstractFactor
    name::Union{AbstractString, Symbol}
    value::Number
    factor::Number
    function GeneralFactor(name::Union{AbstractString, Symbol}, value::Number, factor::Number)
        return new(name, value, factor)
    end
end
const GFactor = GeneralFactor