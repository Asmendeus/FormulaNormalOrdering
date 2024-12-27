"""
    struct BosonAnnihilationOperator <: AbstractBosonOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}`
"""
struct BosonAnnihilationOperator <: AbstractBosonOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
end
const BAOp = BosonAnnihilationOperator