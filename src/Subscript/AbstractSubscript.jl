"""
    abstract type AbstractSubscript{T, S} end

Abstract type of the subscript.

# Description
`T::Symbol` represents the mode of a formula, only with two available values `:symbol` or `:certain`.
    In a formula, `T` must always be consistent, and mixing is prohibited.
    `T == :symbol` means that all named factors do not have actual values in this mode, only with a name.
    `T == :certain` means that all named factors have actual values in this mode. You can choose to output formulas in symbolic form, or convert named factors into exact numbers
`S::Symbol` represents the parameter dimension of the subscript, e.g., :site, :spin, ⋯
    Several possible parameter dimensions `S` have be provided. (See `Subscript` for more)
"""
abstract type AbstractSubscript{T, S} end

getType(::AbstractSubscript{T, S}) where {T, S} = T
getSubDim(::AbstractSubscript{T, S}) where {T, S} = S
