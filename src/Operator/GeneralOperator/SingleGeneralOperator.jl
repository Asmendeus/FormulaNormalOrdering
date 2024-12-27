"""
    mutable struct SingleGeneralOperator <: AbstractGeneralOperator
        ops::Vector{Union{AbstractBosonOperator, AbstractFermionOperator, <:KroneckerDelta}}
        fac::Number
    end

# Fields
- `ops::Vector{Union{AbstractBosonOperator, AbstractFermionOperator, <:KroneckerDelta}}`
- `fac::Number`
"""
mutable struct SingleGeneralOperator <: AbstractGeneralOperator
    ops::Vector{<:Union{AbstractBosonOperator, AbstractFermionOperator, KroneckerDelta}}
    fac::Union{Number, KroneckerDelta, GeneralKroneckerDelta}
end
const SGOp = SingleGeneralOperator