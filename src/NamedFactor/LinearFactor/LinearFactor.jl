"""
    struct LinearFactor <: AbstractLinearFactor
        summation::Tuple{Vararg{Union{Number, AbstractNamedFactor}}}
        factor::Union{Number, AbstractNamedFactor}
    end

# Fields
- `summation::Tuple{Vararg{Union{Number, AbstractNamedFactor}}}`
- `factor::Union{Number, AbstractNamedFactor}`

# Description
`LinearFactor` provides only an addition structure for `AbstractMultiplyFactor`
and a nested interface for `AbstractNamedFactor`, without a name.
"""
#? TODO: The same operators can be merged.
struct LinearFactor <: AbstractLinearFactor
    summation::Tuple{Vararg{Union{Number, AbstractMultiplyFactor}}}
    factor::Union{Number, AbstractNamedFactor}

    function LinearFactor(summation::Tuple{Vararg{Union{Number, AbstractMultiplyFactor}}}, factor::Union{Number, AbstractNamedFactor}=1)
        if length(summation) == 0
            return 0
        elseif length(summation) == 1
            return factor * summation[1]
        else
            return new(summation, factor)
        end
    end
    function LinearFactor(summation::Tuple{Vararg{Number}}, factor::Union{Number, AbstractNamedFactor}=1)
        return factor * sum(summation)
    end
end
const LFactor = LinearFactor


# Tree
children(fac::LinearFactor) = fac.factor
