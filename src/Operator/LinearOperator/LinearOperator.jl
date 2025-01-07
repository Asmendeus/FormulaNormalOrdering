mutable struct LinearOperator <: AbstractLinearOperator
    operators::Vector{<:AbstractMultiplyOperator}
    factor::Union{Number, AbstractNamedFactor}

    function LinearOperator(operators::Vector{<:AbstractMultiplyOperator}, factor::Union{Number, AbstractNamedFactor}=1)
        if length(operators) == 0
            return 0
        elseif length(operators) == 1
            return factor * operators[1]
        else
            return factor == 0 ? 0 : new(operators, factor)
        end
    end
    function LinearOperator(operator::AbstractMultiplyOperator, factor::Union{Number, AbstractNamedFactor}=1)
        return factor * operator
    end
end
const LOp = LinearOperator

getOperators(op::LinearOperator) = op.operators
getFactor(op::LinearOperator) = op.factor
