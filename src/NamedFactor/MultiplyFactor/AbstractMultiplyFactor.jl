"""
    abstract type AbstractMultiplyFactor{T} <: AbstractNamedFactor{T} end

Abstract type of multiply factor.

# Description
Multiply factors are nested to achieve the multiply effect, with ability to nest with linear factors.
For a complete factor, all nested factor should have a same factor type `T`.
"""
abstract type AbstractMultiplyFactor{T} <: AbstractNamedFactor{T} end
