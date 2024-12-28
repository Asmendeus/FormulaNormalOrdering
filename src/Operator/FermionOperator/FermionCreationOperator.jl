"""
    struct FermionCreationOperator <: AbstractFermionOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{AbstractSubscript}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{AbstractSubscript}}`
"""
struct FermionCreationOperator <: AbstractFermionOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}
end
const FCOp = FermionCreationOperator