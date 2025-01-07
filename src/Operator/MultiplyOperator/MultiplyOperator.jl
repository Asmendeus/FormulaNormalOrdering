"""
    mutable struct MultiplyOperator <: AbstractMultiplyOperator
        operators::Vector{<:AbstractBasicOperator}
        factor::Union{Number, AbstractNamedFactor}
    end

# Fields
- `operators::Vector{<:AbstractBasicOperator}`
- `factor::Union{Number, AbstractNamedFactor}`

# Description
The many-body operator formed by multiplication of basic operators.
"""
mutable struct MultiplyOperator <: AbstractMultiplyOperator
    operators::Vector{<:AbstractBasicOperator}
    factor::Union{Number, AbstractNamedFactor}

    function MultiplyOperator(operators::Vector{<:AbstractBasicOperator}, factor::Union{Number, AbstractNamedFactor}=1)
        if factor == 0
            return 0
        else
            _tempops = filter(x -> !isa(x, AbstractIdentityOperator), operators)
            (length(_tempops) == 0) && (_tempops = [IdentityOperator(:I),])
            return new(_tempops, factor)
        end
    end
    function MultiplyOperator(operator::AbstractBasicOperator, factor::Union{Number, AbstractNamedFactor}=1)
        return factor == 0 ? 0 : new([operator,], factor)
    end
end
const MOp = MultiplyOperator

getOperators(op::MultiplyOperator) = op.operators
getFactor(op::MultiplyOperator) = op.factor
