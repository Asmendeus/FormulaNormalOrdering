"""
    abstract type AbstractSubscript{S} end

Abstract type of the subscript.

# Description
`S::Symbol` represents the parameter dimension of the subscript, e.g., :site, :spin, ⋯
    Several possible parameter dimensions `S` have be provided. (See `Subscript` for more)
"""
abstract type AbstractSubscript{S} end

getSubDim(::AbstractSubscript{S}) where {S} = S
