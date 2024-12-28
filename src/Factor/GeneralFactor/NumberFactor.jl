"""
    struct NumberFactor <: AbstractGeneralFactor
        name::Union{AbstractString, Symbol}
        value::Number
        factor::Number
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `value::Number`
- `factor::Number`
"""
struct NumberFactor <: AbstractGeneralFactor
    name::Union{AbstractString, Symbol}
    value::Number
    factor::Number
end
const NFactor = NumberFactor
