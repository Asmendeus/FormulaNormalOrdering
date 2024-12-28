function swap(ops::Tuple{AbstractBosonOperator, AbstractBosonOperator})
    if (typeof(ops[1]) <: BosonAnnihilationOperator
        && typeof(ops[2]) <: BosonCreationOperator
        && length(ops[1].subscript) == length(ops[2].subscript))
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