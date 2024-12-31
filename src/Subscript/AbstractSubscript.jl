"""
    abstract type AbstractSubscript{S} end

Abstract type of the subscript.

# Description
`S::Symbol` represents the subscript type, e.g., :site, :spin, ⋯
    Several possible subscript type `S` have be provided. (See `Subscript` for more)
"""
abstract type AbstractSubscript{S} end

getSubType(::AbstractSubscript{S}) where {S} = S
