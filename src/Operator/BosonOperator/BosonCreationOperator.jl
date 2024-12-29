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

    function BosonCreationOperator(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{AbstractSubscript}})
        allunique(map(x->getSubDim(x), subscript)) || throw(SubscriptDimensionError("BCOp cannot have duplicate subscript dimensions!"))
        all(map(x->getSubType(x)<:SymbolType, subscript)) || all(map(x-getSubType(x)<:CertainType, subscript)) || throw(SubscriptTypeError("The combination of `SymbolType` and `CertainType` is forbidden!"))
        return new(name, subscript)
    end
end
const BCOp = BosonCreationOperator
