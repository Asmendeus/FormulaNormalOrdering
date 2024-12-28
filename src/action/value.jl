# =============== Factor ==============
value(fac::Number) = fac
value(fac::NumberFactor; isstrict::Bool=true) = isstrict ? fac.value * fac.factor : fac

function value(fac::KroneckerDelta{N, T, <:SymbolType}; isstrict::Bool=false) where {N, T}
    if allequal(fac.subscript)
        return isstrict ? value(fac.factor) : fac.factor
    else
        return isstrict ? KroneckerDelta(fac.name, fac.subscript, value(fac.factor)) : fac
    end
end
function value(fac::KroneckerDelta{N, T, <:CertainType}) where {N, T}
    return allequal(fac.subscript) ? value(fac.factor) : 0
end
function value(fac::ProductKroneckerDelta{S}; isstrict::Bool=false) where S
    if all(x->allequal(x), fac.subscript)
        return isstrict ? value(fac.factor) : fac.factor
    else
        new_fac = fac.factor
        subdims = Set(map(x->getSubDim(x[1]), fac.subscript))
        for subdim in subdims
            subscript = fac.subscript[findall(x->getSubDim(x[1])==subdim, fac.subscript)]

            n = length(subscript)
            uf = IntDisjointSets(n)
            for i in 1:n
                for j in i+1:n
                    if !isempty(intersect(subscript[i], subscript[j]))
                        union!(uf, i, j)
                    end
                end
            end
            group_values = unique(uf.parents)

            for value in group_values
                subsubscript = Tuple(unique(Iterators.flatten(subscript[findall(x->x==value, uf.parents)])))
                if length(subsubscript) > 1
                    new_fac *= KroneckerDelta(fac.name, subsubscript, 1)
                end
            end
        end

        if isGKDelta(new_fac)
            return isstrict ? ProductKroneckerDelta(new_fac.name, new_fac.subscript, value(new_fac.factor)) : new_fac
        elseif isKDelta(new_fac)
            return value(new_fac; isstrict=isstrict)
        elseif isNFactor
            return value(new_fac; isstrict=isstrict)
        elseif isNumber
            return new_fac
        else
            throw(ErrorException("The case is out of consideration."))
        end
    end
end
function value(fac::ProductKroneckerDelta{<:CertainType})
    return all(x->allequal(x), fac.subscript) ? value(fac.factor) : 0
end