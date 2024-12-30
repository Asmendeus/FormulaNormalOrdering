"""
Operator ordering based on bubble sort.
"""
function Base.sort(op::GeneralSingleOperator; kwargs...)
    deltaname = haskey(kwargs, :deltaname) ? kwargs[:deltaname] : :δ
    @assert haskey(kwargs, :indices) ⊻ haskey(kwargs, :operator_order) "Too many or too few sort-by parameters!"
    operator_order = let
        if haskey(kwargs, :operator_order)
            operator_order = kwargs[:operator_order]
            @assert all(x->(x in operator_order), op.ops)
            unique(operator_order)
        elseif haskey(kwargs, :indices)
            indices = kwargs[:indices]
            @assert (Set(indices) == Set(1:length(indices)) && length(op.ops) == length(indices)) "Indices dismatch the GSOp."
            operator_order = ([op.ops[i] for i in indices])
            unique(operator_order)
        end
    end
    hash_sort_table = Dict(operator => i for (i, operator) in enumerate(operator_order))

    len = 1
    idx = 1
    new_ops = [deepcopy(op),]
    while idx <= len
        have_ordered = false
        while !have_ordered
            have_ordered = true
            for j in 1:length(new_ops[idx].ops)-1
                if hash_sort_table[new_ops[idx].ops[j]] > hash_sort_table[new_ops[idx].ops[j+1]]
                    _tempop = swap((new_ops[idx].ops[j], new_ops[idx].ops[j+1]); deltaname=deltaname)
                    if isGSOp(_tempop)
                        new_ops[idx].ops = [new_ops[idx].ops[1:j-1]..., _tempop.ops..., new_ops[idx].ops[j+2:end]...]
                        new_ops[idx].factor *= _tempop.factor
                    elseif isGMOp(_tempop)
                        push!(new_ops, GeneralSingleOperator(Union{typeof(new_ops[idx].ops[j]), typeof(new_ops[idx].ops[j+1])}[new_ops[idx].ops[1:j-1]..., _tempop.ops[2].ops..., new_ops[idx].ops[j+2:end]...], new_ops[idx].factor * _tempop.ops[2].factor))
                        new_ops[idx].ops = [new_ops[idx].ops[1:j-1]..., _tempop.ops[1].ops..., new_ops[idx].ops[j+2:end]...]
                        new_ops[idx].factor *= _tempop.ops[1].factor
                        len += 1
                    else
                        throw(Error("The case is out of consideration."))
                    end
                    have_ordered = false
                end
            end
        end
        idx += 1
    end

    if len == 1
        return GeneralSingleOperator(new_ops[1])
    else
        return GeneralMultiOperator(new_ops)
    end
end

function Base.sort(op::GeneralMultiOperator; kwargs...)
    if haskey(kwargs, :operator_order)
        operator_order = let
            operator_order = kwargs[:operator_order]
            @assert all(x->(x in operator_order), Iterators.flatten([y.ops for y in op.ops]))
            unique(operator_order)
        end
    else
        throw(ArgumentError("Missing sort-by parameter `operator_order`"))
    end

    return GeneralMultiOperator(+(map(x->sort(x; operator_order=operator_order), op.ops)...))
end