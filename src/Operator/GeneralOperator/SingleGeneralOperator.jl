"""
    mutable struct SingleGeneralOperator <: AbstractGeneralOperator
        ops::Vector{Union{AbstractBosonOperator, AbstractFermionOperator, <:KroneckerDelta}}
        factor::Union{Number, AbstractFactor}
    end

# Fields
- `ops::Vector{Union{AbstractBosonOperator, AbstractFermionOperator, <:KroneckerDelta}}`
- `factor::Union{Number, AbstractFactor}`
"""
mutable struct SingleGeneralOperator <: AbstractGeneralOperator
    ops::Vector{<:Union{AbstractBosonOperator, AbstractFermionOperator, KroneckerDelta}}
    factor::Union{Number, AbstractFactor}
end
const SGOp = SingleGeneralOperator