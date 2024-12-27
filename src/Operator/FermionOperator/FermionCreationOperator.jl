"""
    struct FermionCreationOperator <: AbstractFermionOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}`
"""
struct FermionCreationOperator <: AbstractFermionOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
end
const FCOp = FermionCreationOperator