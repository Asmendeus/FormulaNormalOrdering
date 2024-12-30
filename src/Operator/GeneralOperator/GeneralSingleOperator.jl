"""
    mutable struct GeneralSingleOperator <: AbstractGeneralOperator
        ops::Vector{Union{AbstractBosonOperator, AbstractFermionOperator}}
        factor::Union{Number, AbstractFactor}
    end

# Fields
- `ops::Vector{Union{AbstractBosonOperator, AbstractFermionOperator}}`
- `factor::Union{Number, AbstractFactor}`
"""
mutable struct GeneralSingleOperator <: AbstractGeneralOperator
    ops::Vector{<:Union{AbstractBosonOperator, AbstractFermionOperator}}
    factor::Union{Number, AbstractFactor}
end
const GSOp = GeneralSingleOperator

GeneralSingleOperator(op::GeneralSingleOperator) = op