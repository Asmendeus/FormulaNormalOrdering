"""
    abstract type AbstractMultiplyFactor <: AbstractNamedFactor end

Abstract type of multiply factor.

# Description
Multiply factors are nested to achieve the multiply effect, with ability to nest with linear factors.
All structs from `AbstractMultiplyFactor` should have a fieldname `name::Union{Symbol, AbstractString}` for text.

# Tips for name
The standard multiply factor text is "[num] × [name1][name2][name3]⋯".
If you only view the output text, recommended name type is `Symbol`, e.g. :δ,
If you want to export to LaTeX text, recommended name type is `String`, e.g. "\\delta".
If you want to put " " or "×" between two factor names, you are recommended to add them to the end of factor name.
"""
abstract type AbstractMultiplyFactor <: AbstractNamedFactor end

getName(fac::AbstractMultiplyFactor) = fac.name
