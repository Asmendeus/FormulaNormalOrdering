"""
    mutable struct GeneralMultiOperator <: AbstractGeneralOperator
        ops::Vector{<:GeneralSingleOperator}
    end

# Fields
- `ops::Vector{<:GeneralSingleOperator}`
"""
mutable struct GeneralMultiOperator <: AbstractGeneralOperator
    ops::Vector{<:GeneralSingleOperator}
    function GeneralMultiOperator(ops::Vector{<:GeneralSingleOperator})
        return new(sort(ops, by=x->length(x.ops), rev=true))
    end
end
const GMOp = GeneralMultiOperator

GeneralMultiOperator(op::GeneralSingleOperator) = GeneralMultiOperator([op,])
GeneralMultiOperator(op::GeneralMultiOperator) = op
