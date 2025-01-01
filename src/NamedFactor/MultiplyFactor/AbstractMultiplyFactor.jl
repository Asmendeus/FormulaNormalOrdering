"""
    abstract type AbstractMultiplyFactor{T} <: AbstractNamedFactor{T} end

Abstract type of multiply factor.

# Description
Multiply factors are nested to achieve the multiply effect, with ability to nest with linear factors.
For a complete factor, all nested factor should have a same factor type `T`.

# Tips for name
All structs from `AbstractMultiplyFactor` should have a fieldname `name::Union{Symbol, AbstractString}` for text.
The standard factor text is "[num] × [name1][name2][name3]⋯".
If you want to put " " or "×" between two factor names, a recommended way is to add them to the end of factor name.
"""
abstract type AbstractMultiplyFactor{T} <: AbstractNamedFactor{T} end
