"""
    Base.sort(op::MultiplyOperator; deltaname::Union{Symbol, AbstractString}=:δ, idname::Union{Symbol, AbstractString}=:I, kwargs...)

# Arguments
- `op::MultiplyOperator`: many-body operator expected to be sorted
- `deltaname::Union{Symbol, AbstractString}=:δ`: name of KroneckerDelta(if it exists)
- `idname::Union{Symbol, AbstractString}=:I`: name of IdentityOperator(if it exists)

# Kwargs
- `operators::Union{Vector{<:AbstractBasicOperator}, Tuple{Vararg{<:AbstractBasicOperator}}}`: basic operator order
- `indices::Union{Vector{Int64}, NTuple{N, Int64}}`: index order mapping from basic operator order

# Return
- `op::Union{LinearOperator, MultiplyOperator}`: ordered many-body operator
"""
function Base.sort(op::MultiplyOperator; deltaname::Union{Symbol, AbstractString}=:δ, idname::Union{Symbol, AbstractString}=:I, kwargs...)
    length(op.operators) == 1 && throw(ArgumentError("Multiply operator with only one basic operator cannot be sorted"))

    # Generates a hash table for sorting
    order_list = let
        if haskey(kwargs, :operators)
            order_list = kwargs[:operators]
            @assert all(x->(x in order_list), op.operators) "operators dismatch the MOp."
            unique(order_list)
        elseif haskey(kwargs, :indices)
            indices = kwargs[:indices]
            @assert (Set(indices) == Set(1:length(indices)) && length(op.operators) == length(indices)) "Indices dismatch the MOp."
            order_list = [op.operators[i] for i in indices]
            unique(order_list)
        else
            ops_c = unique(filter(x->getOpType(x)==:c, op.operators))
            ops_a = unique(filter(x->getOpType(x)==:a, op.operators))
            vcat(ops_c, ops_a)
        end
    end
    hash_sort_table = Dict(operator => i for (i, operator) in enumerate(order_list))

    len = 1     # length of new_ops
    idx = 1     # index of the operator being sorted
    new_ops = [deepcopy(op),]

    # sort
    while idx <= len
        have_sorted = false
        while !have_sorted
            have_sorted = true
            for j in 1:length(new_ops[idx].operators)-1
                if hash_sort_table[new_ops[idx].operators[j]] > hash_sort_table[new_ops[idx].operators[j+1]]
                    _tempop = swap(new_ops[idx].operators[j], new_ops[idx].operators[j+1]; deltaname=deltaname, idname=idname)
                    if isa(_tempop, MultiplyOperator)
                        new_ops[idx].operators = [new_ops[idx].operators[1:j-1]..., _tempop.operators..., new_ops[idx].operators[j+2:end]...]
                        new_ops[idx].factor *= _tempop.factor
                    elseif isa(_tempop, LinearOperator)
                        push!(new_ops, MultiplyOperator([new_ops[idx].operators[1:j-1]..., _tempop.operators[2].operators..., new_ops[idx].operators[j+2:end]...], new_ops[idx].factor * _tempop.operators[2].factor))
                        new_ops[idx].operators = [new_ops[idx].operators[1:j-1]..., _tempop.operators[1].operators..., new_ops[idx].operators[j+2:end]...]
                        new_ops[idx].factor *= _tempop.operators[1].factor
                        len += 1
                    else
                        throw(Error("The case is out of consideration."))
                    end
                    have_sorted = false
                end
            end
        end
        idx += 1
    end

    return len == 1 ? new_ops[1] : LinearOperator(new_ops)
end

"""
    Base.sort(op::LinearOperator; deltaname::Union{Symbol, AbstractString}=:δ, idname::Union{Symbol, AbstractString}=:I, kwargs...)

# Arguments
- `op::LinearOperator`: many-body operator expected to be sorted
- `deltaname::Union{Symbol, AbstractString}=:δ`: name of KroneckerDelta(if it exists)
- `idname::Union{Symbol, AbstractString}=:I`: name of IdentityOperator(if it exists)

# Kwargs
- `operators::Union{Vector{<:AbstractBasicOperator}, Tuple{Vararg{<:AbstractBasicOperator}}}`: basic operator order

# Return
- `op::Union{LinearOperator, MultiplyOperator}`: ordered many-body operator
"""
function Base.sort(op::LinearOperator; deltaname::Union{Symbol, AbstractString}=:δ, idname::Union{Symbol, AbstractString}=:I, kwargs...)
    operators = let
        if haskey(kwargs, :operators)
            operators = kwargs[:operators]
            @assert all(x->(x in operators), Iterators.flatten([y.operators for y in op.operators]))
            unique(operators)
        else
            ops_c = unique(vcat([filter(x->getOpType(x)==:c, o.operators) for o in op.operators]...))
            ops_a = unique(vcat([filter(x->getOpType(x)==:a, o.operators) for o in op.operators]...))
            vcat(ops_c, ops_a)
        end
    end

    return sum(map(x->sort(x; deltaname=deltaname, idname=idname, operators=operators), op.operators))
end
