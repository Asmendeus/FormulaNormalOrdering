"""
    struct FermionAnnihilationOperator <: AbstractFermionOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}`
"""
struct FermionAnnihilationOperator <: AbstractFermionOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{Union{Symbol, AbstractString, Number}}}
end
const FAOp = FermionAnnihilationOperator