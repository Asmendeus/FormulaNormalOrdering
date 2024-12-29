function swap(ops::Tuple{AbstractBosonOperator, AbstractFermionOperator})
    return GeneralSingleOperator([ops[2], ops[1]], 1)
end
function swap(ops::Tuple{AbstractFermionOperator, AbstractBosonOperator})
    return GeneralSingleOperator([ops[2], ops[1]], 1)
end
function swap(ops::Tuple{AbstractBosonOperator, AbstractBosonOperator}; deltaname::Union{Symbol, AbstractString}=:δ)
    if (isBAOp(ops[1]) && isBCOp(ops[2]) && Set(map(x->getSubDim(x), ops[1].subscript)) == Set(map(x->getSubDim(x), ops[2].subscript)))
        if length(ops[1].subscript) == 1
            δ = KroneckerDelta(deltaname, (ops[1].subscript..., ops[2].subscript...), 1)
        else
            δ = ProductKroneckerDelta(deltaname, map(sub->(sub, ops[2].subscript[findfirst(x->typeof(x)==typeof(sub), ops[2].subscript)]), ops[1].subscript), 1)
        end
        δ = GeneralSingleOperator(Vector{Union{BosonAnnihilationOperator, BosonCreationOperator}}(), δ)
        op = GeneralSingleOperator([ops[2], ops[1]], 1)
        return GeneralMultiOperator([δ, op])
    elseif (isBCOp(ops[1]) && isBAOp(ops[2]) && Set(map(x->getSubDim(x), ops[1].subscript)) == Set(map(x->getSubDim(x), ops[2].subscript)))
        if length(ops[1].subscript) == 1
            δ = -KroneckerDelta(deltaname, (ops[1].subscript..., ops[2].subscript...), 1)
        else
            δ = -ProductKroneckerDelta(deltaname, map(sub->(sub, ops[2].subscript[findfirst(x->typeof(x)==typeof(sub), ops[2].subscript)]), ops[1].subscript), 1)
        end
        δ = GeneralSingleOperator(Vector{Union{BosonAnnihilationOperator, BosonCreationOperator}}(), δ)
        op = GeneralSingleOperator([ops[2], ops[1]], 1)
        return GeneralMultiOperator([δ, op])
    else
        return GeneralSingleOperator([ops[2], ops[1]], 1)
    end
end
function swap(ops::Tuple{AbstractFermionOperator, AbstractFermionOperator}; deltaname::Union{Symbol, AbstractString}=:δ)
    if (((isFAOp(ops[1]) && isFCOp(ops[2])) || (isFCOp(ops[1]) && isFAOp(ops[2]))) && Set(map(x->getSubDim(x), ops[1].subscript)) == Set(map(x->getSubDim(x), ops[2].subscript)))
        if length(ops[1].subscript) == 1
            δ = KroneckerDelta(deltaname, (ops[1].subscript..., ops[2].subscript...), 1)
        else
            δ = ProductKroneckerDelta(deltaname, map(sub->(sub, ops[2].subscript[findfirst(x->typeof(x)==typeof(sub), ops[2].subscript)]), ops[1].subscript), 1)
        end
        δ = GeneralSingleOperator(Vector{Union{FermionAnnihilationOperator, FermionCreationOperator}}(), δ)
        op = GeneralSingleOperator([ops[2], ops[1]], -1)
        return GeneralMultiOperator([δ, op])
    else
        return GeneralSingleOperator([ops[2], ops[1]], -1)
    end
end

function swap(op::GeneralSingleOperator)
    @assert length(op.ops) == 2
    return op.factor * swap(Tuple(op.ops))
end
