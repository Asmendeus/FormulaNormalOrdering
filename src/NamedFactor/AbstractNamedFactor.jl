"""
    abstract type AbstractNamedFactor end

Abstract type of the named factor.

# Description
All structs from `AbstractNamedFactor` ought to have a fieldname `factor`.
"""
abstract type AbstractNamedFactor end

getFactor(fac::AbstractNamedFactor) = fac.factor