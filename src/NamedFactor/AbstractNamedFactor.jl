"""
    abstract type AbstractNamedFactor{T} end

Abstract type of the named factor.

# Description
`T::Symbol` represents the type of a NamedFactor, only with two available values `:symbol` or `:certain`.
    `T == :symbol` means that the named factor does not have an actual value, only with a name.
    `T == :certain` means that the named factor have an actual value. You can choose to output the factor in symbolic form, or convert it into an exact number
"""
abstract type AbstractNamedFactor{T} end

getFactorType(::AbstractNamedFactor{T}) where T = T
