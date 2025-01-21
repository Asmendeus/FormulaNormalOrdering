"""
    abstract type AbstractSubscript{S} end

Abstract type of the subscript.

# Description
`S::Symbol` represents the physical type of the subscript, e.g., :site, :spin, ⋯
    Several possible subscript type `S` have be provided. (See `Subscript` for more)
"""
abstract type AbstractSubscript{S} end

"""
    function getSubType(::AbstractSubscript{S})

# Argument(s)
- `::AbstractSubscript{S}`

# Return
- `S::Symbol`: the physical type of the subscript
"""
getSubType(::AbstractSubscript{S}) where {S} = S
