function swap(ops::Tuple{Union{AbstractBosonOperator, AbstractFermionOperator}, Union{AbstractBosonOperator, AbstractFermionOperator}})
    name = ops[2].name * ops[1].name
    if all(isBoson, ops)
        # TODO
    elseif all(isFermion, ops)
        # TODO
    else
        return SGOp(name, [ops[2], ops[1]], 1)
    end
end

function swap(op::SingleGeneralOperator)
    @assert length(op.ops) == 2
end