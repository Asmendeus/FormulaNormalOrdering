using LaTeXStrings, DataStructures

const SymbolType = Symbol
const CertainType = Union{AbstractString, Number}


# =============== Subscript ===============
abstract type AbstractSubscript{T, S} end

getSubDim(::AbstractSubscript{T, S}) where {T, S} = T
getSubType(::AbstractSubscript{T, S}) where {T, S} = S


struct GeneralSubscript{T, S} <: AbstractSubscript{T, S}
    subscript::S

    function GeneralSubscript{T}(subscript::S) where {T, S <: Union{SymbolType, CertainType}}
        return new{T, S}(subscript)
    end
end
const GSubscript{T, S} = GeneralSubscript{T, S}

const Site{S} = GeneralSubscript{:site, S}
const Spin{S} = GeneralSubscript{:spin, S}
const Orbital{S} = GeneralSubscript{:orbital, S}
const Layer{S} = GeneralSubscript{:layer, S}


isSubscript(sub) = typeof(sub) <: AbstractSubscript
isGSubscript(sub::AbstractSubscript) = typeof(sub) <: GeneralSubscript


text(sub::GeneralSubscript) = string(sub.subscript)


function Base.show(io::IO, op::AbstractSubscript)
    print(io, text(op))
end



# =============== Factor ===============
abstract type AbstractFactor end

abstract type AbstractGeneralFactor <: AbstractFactor end

struct NumberFactor <: AbstractGeneralFactor
    name::Union{AbstractString, Symbol}
    value::Number
    factor::Number
end
const NFactor = NumberFactor


abstract type AbstractKroneckerDelta{S} <: AbstractFactor end

struct KroneckerDelta{N, T, S} <: AbstractKroneckerDelta{S} where {N, T}
    name::Union{AbstractString, Symbol}
    subscript::NTuple{N, AbstractSubscript{T, S}}
    factor::Union{Number, AbstractGeneralFactor}

    function KroneckerDelta(name::Union{AbstractString, Symbol}, subscript::NTuple{N, AbstractSubscript{T, S}}, factor::Union{Number, AbstractGeneralFactor}) where {N, T, S}
        @assert N > 1
        return new{N, T, S}(name, subscript, factor)
    end
end
const KDelta = KroneckerDelta

struct ProductKroneckerDelta{S} <: AbstractKroneckerDelta{S}
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{Tuple{Vararg{AbstractSubscript}}}}
    factor::Union{Number, AbstractGeneralFactor}

    function ProductKroneckerDelta(name::Union{AbstractString, Symbol}, subscript::Tuple{Vararg{Tuple{Vararg{AbstractSubscript}}}}, factor::Union{Number, AbstractGeneralFactor})
        S = Union{(getSubType(x) for x in Iterators.flatten(subscript))...}
        @assert (S <: SymbolType || S <: CertainType) "The combination of `SymbolType` and `CertainType` is forbidden!"
        return new{S}(name, subscript, factor)
    end
end
const PKDelta = ProductKroneckerDelta


isFactor(fac) = typeof(fac) <: Union{Number, AbstractFactor}
isNumber(fac::Union{Number, AbstractFactor}) = typeof(fac) <: Number
isNFactor(fac::Union{Number, AbstractFactor}) = typeof(fac) <: NumberFactor
isKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: KroneckerDelta
isGKDelta(fac::Union{Number, AbstractFactor}) = typeof(fac) <: ProductKroneckerDelta

value(fac::Number) = fac
value(fac::NumberFactor) = fac.value * fac.factor
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


text(fac::Number)::LaTeXString = string(fac)
text(fac::NumberFactor)::LaTeXString = string(fac.factor) * " * " * string(fac.name)
function text(fac::KroneckerDelta{N, T, S})::LaTeXString where {N, T, S}
    return string(text(fac.factor)) * " * " * string(fac.name) * "_{$(_string_subscript(fac.subscript))}"
end
function text(fac::ProductKroneckerDelta{T})::LaTeXString where T
    str = string(text(fac.factor)) * " * "
    for subpair in fac.subscript
        str *= string(fac.name) * "_{$(_string_subscript(subpair))}"
    end
    return str
end

function _string_subscript(subscript::Tuple{Vararg{AbstractSubscript}})::String
    str = string(text(subscript[1]))
    for item in subscript[2:end]
        str *= "," * string(text(item))
    end
    return str
end



Base.:-(fac::NumberFactor) = NumberFactor(fac.name, fac.value, -fac.factor)
Base.:-(fac::KroneckerDelta) = KroneckerDelta(fac.name, fac.subscript, -fac.factor)
Base.:-(fac::ProductKroneckerDelta) = ProductKroneckerDelta(fac.name, fac.subscript, -fac.factor)

Base.:*(fac1::AbstractFactor, fac2::Number) = fac2 * fac1
Base.:*(fac1::Number, fac2::NumberFactor) = NumberFactor(fac2.name, fac2.value, fac1 * fac2.factor)
Base.:*(fac1::Number, fac2::KroneckerDelta) = KroneckerDelta(fac2.name, fac2.subscript, fac1 * fac2.factor)
Base.:*(fac1::Number, fac2::ProductKroneckerDelta) = ProductKroneckerDelta(fac2.name, fac2.subscript, fac1 * op.factor)

function Base.:*(fac1::NumberFactor, fac2::NumberFactor)
    return NumberFactor(string(fac1.name)* " " * string(fac2.name), fac1.value * fac2.value, fac1.factor * fac2.factor)
end
Base.:*(fac1::KroneckerDelta, fac2::NumberFactor) = KroneckerDelta(fac1.name, fac1.subscript, fac1.factor * fac2)
Base.:*(fac1::NumberFactor, fac2::KroneckerDelta) = KroneckerDelta(fac2.name, fac2.subscript, fac1 * fac2.factor)
Base.:*(fac1::ProductKroneckerDelta, fac2::NumberFactor) = KroneckerDelta(fac1.name, fac1.subscript, fac1.factor * fac2)
Base.:*(fac1::NumberFactor, fac2::ProductKroneckerDelta) = KroneckerDelta(fac2.name, fac2.subscript, fac1 * fac2.factor)

function Base.:*(op1::KroneckerDelta, op2::KroneckerDelta)
    return ProductKroneckerDelta(op1.name, (op1.subscript, op2.subscript), op1.factor * op2.factor)
end
function Base.:*(op1::KroneckerDelta, op2::ProductKroneckerDelta)
    return ProductKroneckerDelta(op2.name, (op1.subscript, op2.subscript...), op1.factor * op2.factor)
end
function Base.:*(op1::ProductKroneckerDelta, op2::KroneckerDelta)
    return ProductKroneckerDelta(op1.name, (op1.subscript..., op2.subscript), op1.factor * op2.factor)
end

function Base.:*(op1::ProductKroneckerDelta, op2::ProductKroneckerDelta)
    return ProductKroneckerDelta(op1.name, (op1.subscript..., op2.subscript...), op1.factor * op2.factor)
end


function Base.show(io::IO, op::AbstractFactor)
    print(io, text(op))
end



abstract type AbstractOperator end
abstract type AbstractBosonOperator <: AbstractOperator end
struct BosonAnnihilationOperator <: AbstractBosonOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}
end
const BAOp = BosonAnnihilationOperator
struct BosonCreationOperator <: AbstractBosonOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}
end
const BCOp = BosonCreationOperator
abstract type AbstractFermionOperator <: AbstractOperator end
struct FermionAnnihilationOperator <: AbstractFermionOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}
end
const FAOp = FermionAnnihilationOperator
struct FermionCreationOperator <: AbstractFermionOperator
    name::Union{AbstractString, Symbol}
    subscript::Tuple{Vararg{AbstractSubscript}}
end
const FCOp = FermionCreationOperator
abstract type AbstractGeneralOperator <: AbstractOperator end
mutable struct GeneralSingleOperator <: AbstractGeneralOperator
    ops::Vector{<:Union{AbstractBosonOperator, AbstractFermionOperator}}
    factor::Union{Number, AbstractFactor}
end
const GSOp = GeneralSingleOperator
mutable struct GeneralMultiOperator <: AbstractGeneralOperator
    ops::Vector{<:GeneralSingleOperator}
    function GeneralMultiOperator(ops::Vector{<:GeneralSingleOperator})
        return new(ops)
    end
end
const GMOp = GeneralMultiOperator
GeneralMultiOperator(op::GeneralSingleOperator) = GeneralMultiOperator([op,])

isOperator(op) = typeof(op) <: AbstractOperator

isBoson(op::AbstractOperator) = typeof(op) <: AbstractBosonOperator
isBAOp(op::AbstractOperator) = typeof(op) <: BosonAnnihilationOperator
isBCOp(op::AbstractOperator) = typeof(op) <: BosonCreationOperator

isFermion(op::AbstractOperator) = typeof(op) <: AbstractFermionOperator
isFAOp(op::AbstractOperator) = typeof(op) <: FermionAnnihilationOperator
isFCOp(op::AbstractOperator) = typeof(op) <: FermionCreationOperator

isGeneral(op::AbstractOperator) = typeof(op) <: AbstractGeneralOperator
isGSOp(op::AbstractOperator) = typeof(op) <: GeneralSingleOperator
isGMOp(op::AbstractOperator) = typeof(op) <: GeneralMultiOperator

function text(op::Union{BosonAnnihilationOperator, FermionAnnihilationOperator})::LaTeXString
    return string(op.name) * "_{$(_string_subscript(op.subscript))}"
end
function text(op::Union{BosonCreationOperator, FermionCreationOperator})::LaTeXString
    return string(op.name) * "^\\dag" * "_{$(_string_subscript(op.subscript))}"
end
function text(op::GeneralSingleOperator)::LaTeXString
    str = string(text(op.factor)) * " * "
    for o in op.ops
        str *= string(text(o))
    end
    return str
end
function text(op::GeneralMultiOperator)::LaTeXString
    str = string(text(op.ops[1]))
    for i in 2:length(op.ops)
        if text(op.ops[i])[1] != '-'
            str *= " + " * string(text(op.ops[i]))
        else
            str *= " - " * string(text(op.ops[i]))[2:end]
        end
    end
    return str
end

function Base.show(io::IO, op::AbstractOperator)
    print(io, text(op))
end

function Base.:+(op1::GeneralSingleOperator, op2::GeneralSingleOperator)
    return GeneralMultiOperator([op1, op2])
end
function Base.:+(op1::GeneralMultiOperator, op2::GeneralSingleOperator)
    return GeneralMultiOperator([op1.ops..., op2])
end
function Base.:+(op1::GeneralSingleOperator, op2::GeneralMultiOperator)
    return GeneralMultiOperator([op1, op2.ops...])
end
function Base.:+(op1::GeneralMultiOperator, op2::GeneralMultiOperator)
    return GeneralMultiOperator([op1.ops..., op2.ops...])
end

Base.:-(op::GeneralSingleOperator) = GeneralSingleOperator(op.ops, -op.factor)
Base.:-(op::GeneralMultiOperator) = GeneralMultiOperator(map(x->-x, op.ops))
Base.:-(op1::Union{GeneralSingleOperator, GeneralMultiOperator}, op2::Union{GeneralSingleOperator, GeneralMultiOperator}) = op1 + (-op2)

# GeneralSingleOperator
Base.:*(op::GeneralSingleOperator, fac::Union{Number, AbstractFactor}) = GeneralSingleOperator(op.ops, op.factor * fac)
Base.:*(fac::Union{Number, AbstractFactor}, op::GeneralSingleOperator) = GeneralSingleOperator(op.ops, fac * op.factor)
Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator}, op2::Union{AbstractBosonOperator, AbstractFermionOperator}) = GeneralSingleOperator([op1, op2], 1)
Base.:*(op1::GeneralSingleOperator, op2::Union{AbstractBosonOperator, AbstractFermionOperator}) = GeneralSingleOperator([op1.ops..., op2], op1.factor)
Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator}, op2::GeneralSingleOperator) = GeneralSingleOperator([op1, op2.ops...], op2.factor)
Base.:*(op1::GeneralSingleOperator, op2::GeneralSingleOperator) = GeneralSingleOperator([op1.ops..., op2.ops...], op1.factor * op2.factor)

# GeneralMultiOperator
Base.:*(op::GeneralMultiOperator, fac::Union{Number, AbstractFactor}) = GeneralMultiOperator(map(x->x*fac, op.ops))
Base.:*(fac::Union{Number, AbstractFactor}, op::GeneralMultiOperator) = GeneralMultiOperator(map(x->fac*x, op.ops))
Base.:*(op1::GeneralMultiOperator, op2::Union{AbstractBosonOperator, AbstractFermionOperator, GeneralSingleOperator}) = GeneralMultiOperator(map(x->x*op2, op1.ops))
Base.:*(op1::Union{AbstractBosonOperator, AbstractFermionOperator, GeneralSingleOperator}, op2::GeneralMultiOperator) = GeneralMultiOperator(map(x->op1*x, op2.ops))
Base.:*(op1::GeneralMultiOperator, op2::GeneralMultiOperator) = GeneralMultiOperator([x*y for x in op1.ops for y in op2.ops])
