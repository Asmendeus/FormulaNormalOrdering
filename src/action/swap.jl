function swap(ops::Tuple{AbstractBosonOperator, AbstractBosonOperator})
    if (isBAOp(ops[1]) && isBCOp(ops[2]) && Set(map(x->getSubDim(x), op[1].subscript)) == Set(map(x->getSubDim(x), op[2].subscript)))
        op = GeneralSingleOperator([ops[2], ops[1]], 1)
        return GeneralMultiOperator([δ, op])
    elseif (isBCOp(ops[1]) && isBAOp(ops[2]) && Set(map(x->getSubDim(x), op[1].subscript)) == Set(map(x->getSubDim(x), op[2].subscript)))
        op = GeneralSingleOperator([ops[2], ops[1]], 1)
        return GeneralMultiOperator([δ, op])
    else
        return GeneralSingleOperator([ops[2], ops[1]], 1)
    end
end
function swap(ops::Tuple{AbstractBosonOperator, AbstractFermionOperator})
    return GeneralSingleOperator([ops[2], ops[1]], 1)
end
function swap(ops::Tuple{AbstractFermionOperator, AbstractBosonOperator})
    return GeneralSingleOperator([ops[2], ops[1]], 1)
end
function swap(ops::Tuple{AbstractFermionOperator, AbstractFermionOperator})
end

function swap(op::GeneralSingleOperator)
    @assert length(op.ops) == 2
end