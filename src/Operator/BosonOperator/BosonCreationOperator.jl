"""
    struct BosonCreationOperator <: AbstractBosonOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{AbstractSubscript}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{AbstractSubscript}}`
"""
struct BosonCreationOperator <: AbstractBosonOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}
end
const BCOp = BosonCreationOperator
