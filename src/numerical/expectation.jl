"""
    expectation(G::Matrix{<:Number}, op::MultiplyOperator, f::Function)
    expectation(G::Matrix{<:Number}, op::LinearOperator, f::Function)

# Input
- `G::Matrix{<:Number}`: Green function G_ij = ⟨ϕ|c^dag_i c_j|φ⟩ = I - ⟨ϕ|c_i c^dag_j|φ⟩
- `op::Union{MultiplyOperator, LinearOperator}`: operator with U(1) symmetry
- `f::Function`: the function mapping a basic operator with specific subscripts to an index

# Return
- `::Number`: expected value of the operator `op`

# Warning
The performance optimization of `expectation` function is poor, large-scale calculation
of the occasion, please use `wick` function manual calculation.
"""
function expectation(G::Matrix{<:Number}, op::MultiplyOperator, f::Function)
    if !isca(op)
        return expectation(G, sort(op), f)
    else
        if length(op.operators) == 1
            @assert isa(op.operators[1], AbstractIdentityOperator) "A single basic operator cannot calculate expectation."
            return value(op.factor)
        else
            @assert 2 * length(findall(x->getOpType(x)==:c, op.operators)) == length(op.operators) "Only support computing operator expectations with U(1) symmetry"
            return value(op.factor) * wick(G, map(f, op.operators)...)
        end
    end
end

function expectation(G::Matrix{<:Number}, op::LinearOperator, f::Function)
    return value(op.factor) * sum(map(x->expectation(G, x, f), op.operators))
end
