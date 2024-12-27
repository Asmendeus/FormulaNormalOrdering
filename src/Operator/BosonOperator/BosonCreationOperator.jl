"""
    struct BosonCreationOperator <: AbstractBosonOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}`
"""
struct BosonCreationOperator <: AbstractBosonOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
end
const BCOp = BosonCreationOperator