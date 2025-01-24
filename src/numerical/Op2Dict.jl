"""
    function Op2Dict(op::MultiplyOperator, f::Function)
    function Op2Dict(op::LinearOperator, f::Function)

# Arguments
- `op::Union{MultiplyOperator, LinearOperator}`: operator with U(1) symmetry
- `f::Function`: the function mapping a basic operator with specific subscripts to an index

# Return
- `::Dict{<:Tuple{Vararg{Int64}}, <:Number}`: the `Dict` instance converted from a many-body operator.
  Keys are indices of the basic operators and values are value of the factors.
"""
function Op2Dict(op::MultiplyOperator, f::Function)::Dict{<:Tuple{Vararg{Int64}}, <:Number}
    if isa(op.operators[1], AbstractAnyonOperator)
        return Dict(Tuple(map(f, op.operators))=>value(op.factor))
    else    # length(op.operators) == 1 && isa(op.operators[1], AbstractIdentityOperator)
        return Dict(()=>value(op.factor))
    end
end
function Op2Dict(op::LinearOperator, f::Function)::Dict{<:Tuple{Vararg{Int64}}, <:Number}
    _tempOp = value(op)
    if isa(_tempOp, LinearOperator)
        _tempOp = multiply_factor_to_all(_tempOp)
        return sum(map(x->Op2Dict(x, f), _tempOp.operators))
    elseif isa(_tempOp, MultiplyOperator)
        return Op2Dict(_tempOp, f)
    else    # isa(_tempOp, Number)
        return Dict(Tuple{Vararg{Int64}}()=>_tempOp)
    end
end
