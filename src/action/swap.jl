function swap(op1::AbstractBasicOperator, op2::AbstractBasicOperator;
              deltaname::Union{Symbol, AbstractString}=:δ, idname::Union{Symbol, AbstractString}=:I)
    if isa(op1, AbstractIdentityOperator) || isa(op2, AbstractIdentityOperator)
        return op2 * op1
    elseif isa(op1, AbstractBosonOperator) && isa(op2, AbstractFermionOperator)
        return op2 * op1
    elseif isa(op1, AbstractFermionOperator) && isa(op2, AbstractBosonOperator)
        return op2 * op1
    elseif isa(op1, AbstractBosonOperator) && isa(op2, AbstractBosonOperator)
        if ((isa(op1, BosonAnnihilationOperator) && isa(op2, BosonCreationOperator)) || (isa(op1, BosonCreationOperator) && isa(op2, BosonAnnihilationOperator))) && (Set(map(x->typeof(x), op1.subscripts)) == Set(map(x->typeof(x), op2.subscripts)))
            _tempfac = prod([KroneckerDelta(deltaname, (op1.subscripts[findfirst(x->isa(x, subtype), op1.subscripts)], op2.subscripts[findfirst(x->isa(x, subtype), op2.subscripts)])) for subtype in Set(map(x->typeof(x), op1.subscripts))])
            return op2 * op1 + _tempfac * IdentityOperator(idname)
        else
            return op2 * op1
        end
    elseif isa(op1, AbstractFermionOperator) && isa(op2, AbstractFermionOperator)
        if ((isa(op1, FermionAnnihilationOperator) && isa(op2, FermionCreationOperator)) || (isa(op1, FermionCreationOperator) && isa(op2, FermionAnnihilationOperator))) && (Set(map(x->typeof(x), op1.subscripts)) == Set(map(x->typeof(x), op2.subscripts)))
            _tempfac = prod([KroneckerDelta(deltaname, (op1.subscripts[findfirst(x->isa(x, subtype), op1.subscripts)], op2.subscripts[findfirst(x->isa(x, subtype), op2.subscripts)])) for subtype in Set(map(x->typeof(x), op1.subscripts))])
            return - op2 * op1 + _tempfac * IdentityOperator(idname)
        else
            return - op2 * op1
        end
    else
        println("Error Statement:")
        println("This error trigger indicates that you are trying to swap two operators, at least one of which is an anyon operator.")
        println("The feature has not been implemented yet, because the author is not familiar with the swap rules of anyon operators.")
        println("If you know more about it, please feel free to contact me, or submit an issue in Github.")
        throw(MethodError(swap, (op1, op2)))
    end
end

function swap(op::MultiplyOperator)
    @assert length(op.operators) == 2 "The number of basic operators that make up the multiply operator must be 2!"
    return op.factor * swap(op.operators[1], op.operators[2])
end
