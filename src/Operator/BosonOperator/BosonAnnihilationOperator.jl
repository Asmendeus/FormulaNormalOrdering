"""
    struct BosonAnnihilationOperator <: AbstractBosonOperator
        name::Union{AbstractString, Symbol}
        subscript::Tuple{Vararg{AbstractSubscript}}
    end

# Fields
- `name::Union{AbstractString, Symbol}`
- `subscript::Tuple{Vararg{AbstractSubscript}}`
"""
struct BosonAnnihilationOperator <: AbstractBosonOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}

    function BosonAnnihilationOperator(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{AbstractSubscript}})
        allunique(map(x->getSubDim(x), subscript)) || throw(SubscriptDimensionError("BAOp cannot have duplicate subscript dimensions!"))
        all(map(x->getSubType(x)<:SymbolType, subscript)) || all(map(x-getSubType(x)<:CertainType, subscript)) || throw(SubscriptTypeError("The combination of `SymbolType` and `CertainType` is forbidden!"))
        return new(name, subscript)
    end
end
const BAOp = BosonAnnihilationOperator
