"""
    abstract type AbstractSubscript{T, S} end

Abstract type of subscript.
`T` represents the parameter dimension of the subscript, e.g., :site, :spin, :orbital, ⋯
`S` represents the data type of the subscripts, S <: Union{SymbolType, CertainType}.
"""
abstract type AbstractSubscript{T, S} end

getSubDim(::AbstractSubscript{T, S}) where {T, S} = T
getSubType(::AbstractSubscript{T, S}) where {T, S} = S
