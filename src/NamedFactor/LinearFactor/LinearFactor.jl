"""
    struct LinearFactor{T} <: AbstractLinearFactor{T}
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
struct LinearFactor{T} <: AbstractLinearFactor{T}
    summation::Tuple{Vararg{Union{Number, AbstractMultiplyFactor{T}}}}
    factor::Union{Number, AbstractNamedFactor{T}}

    function LinearFactor(summation::Tuple{Vararg{Union{Number, AbstractMultiplyFactor{T}}}}, factor::Union{Number, AbstractNamedFactor{T}}) where T
        T in (:symbol, :certain) || throw(FactorTypeError("Unacceptable factor type $T. Factor type should be :symbol or :certain"))
        if length(summation) == 0
            return 0
        elseif length(summation) == 1
            return factor * summation[1]
        else
            return new{T}(summation, factor)
        end
    end
    function LinearFactor(summation::Tuple{Vararg{Number}}, factor::Number)
        return factor * sum(summation)
    end
end
const LFactor = LinearFactor


# Tree
children(fac::LinearFactor) = fac.factor
