"""
    abstract type AbstractLinearFactor{T} <: AbstractNamedFactor{T} end

Abstract type of linear factor.

# Description
Linear factors are linearly structured through `Tuple`, with ability to nest with multiply factors.
For a complete factor, all nested factor should have a same factor type `T`.
"""
abstract type AbstractLinearFactor{T} <: AbstractNamedFactor{T} end
