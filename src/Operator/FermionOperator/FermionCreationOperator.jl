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

    function FermionCreationOperator(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{AbstractSubscript}})
        allunique(map(x-getSubDim(x), subscript)) || throw(SubscriptDimensionError("Repeated subscript dimensions are forbidden!"))
        all(map(x-getSubType(x)<:SymbolType, subscript)) || all(map(x-getSubType(x)<:CertainType, subscript)) || throw(SubscriptTypeError("The combination of `SymbolType` and `CertainType` is forbidden!"))
        return new(name, subscript)
    end
end
const FCOp = FermionCreationOperator
