"""
    mutable struct MultiGeneralOperator <: AbstractGeneralOperator
        ops::Vector{<:SingleGeneralOperator}
    end

# Fields
- `ops::Vector{<:SingleGeneralOperator}`
"""
mutable struct MultiGeneralOperator <: AbstractGeneralOperator
    ops::Vector{<:SingleGeneralOperator}
end
const MGOp = MultiGeneralOperator