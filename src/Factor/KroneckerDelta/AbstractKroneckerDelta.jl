"""
    abstract type AbstractKroneckerDelta{S} <: AbstractFactor end

Abstract type of Kronecker Delta.
`S` represents the data type of the subscripts, S <: Union{SymbolType, CertainType}.
"""
abstract type AbstractKroneckerDelta{S} <: AbstractFactor end
