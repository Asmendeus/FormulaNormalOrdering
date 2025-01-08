"""
    struct IdentityOperator <: AbstractIdentityOperator
        name::Union{Symbol, AbstractString}
    end

# Field(s)
- `name::Union{Symbol, AbstractString}`

# Description
`IdentityOperator` is not the identity operator in physics,
    but a tool used to convert a factor into an operator.
"""
struct IdentityOperator <: AbstractIdentityOperator
    name::Union{Symbol, AbstractString}

    function IdentityOperator(name::Union{Symbol, AbstractString}=:I)
        return new(name)
    end
end
const IdOp = IdentityOperator
