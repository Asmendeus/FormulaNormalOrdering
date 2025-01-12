module FormulaNormalOrdering

using AbstractTrees
using DataStructures
using LaTeXStrings
import Combinatorics.permutations

################# Subscript #################
export AbstractSubscript, getSubType
include("Subscript/AbstractSubscript.jl")

export Subscript, getSubLabel, Site, Spin, Orbital, Layer
include("Subscript/Subscript.jl")


################# Factor #################
export AbstractNamedFactor, getFactor
include("NamedFactor/AbstractNamedFactor.jl")

export AbstractMultiplyFactor
include("NamedFactor/MultiplyFactor/AbstractMultiplyFactor.jl")
export KroneckerDelta, KDelta
include("NamedFactor/MultiplyFactor/KroneckerDelta.jl")
export NumberFactor, NFactor
include("NamedFactor/MultiplyFactor/NumberFactor.jl")
export OperatorFactor, OFactor
include("NamedFactor/MultiplyFactor/OperatorFactor.jl")
export SymbolFactor, SFactor
include("NamedFactor/MultiplyFactor/SymbolFactor.jl")

export AbstractLinearFactor
include("NamedFactor/LinearFactor/AbstractLinearFactor.jl")
export LinearFactor, LFactor
include("NamedFactor/LinearFactor/LinearFactor.jl")


################# Operator #################
export AbstractOperator
include("Operator/AbstractOperator.jl")

export AbstractBasicOperator
include("Operator/BasicOperator/AbstractBasicOperator.jl")
export AbstractAnyonOperator, AbstractBosonOperator, AbstractFermionOperator
export getPhase, getOpType
include("Operator/BasicOperator/AnyonOperator/AbstractAnyonOperator.jl")
export AnyonOperator, getSubTypes, AnyonAnnihilationOperator, AAOp, AnyonCreationOperator, ACOp
export BosonOperator, BosonAnnihilationOperator, BAOp, BosonCreationOperator, BCOp
export FermionOperator, FermionAnnihilationOperator, FAOp, FermionCreationOperator, FCOp
include("Operator/BasicOperator/AnyonOperator/AnyonOperator.jl")
export AbstractIdentityOperator
include("Operator/BasicOperator/IdentityOperator/AbstractIdentityOperator.jl")
export IdentityOperator, IdOp
include("Operator/BasicOperator/IdentityOperator/IdentityOperator.jl")

export AbstractMultiplyOperator
include("Operator/MultiplyOperator/AbstractMultiplyOperator.jl")
export MultiplyOperator, MOp, getOperators
include("Operator/MultiplyOperator/MultiplyOperator.jl")

export AbstractLinearOperator
include("Operator/LinearOperator/AbstractLinearOperator.jl")
export LinearOperator, LOp
include("Operator/LinearOperator/LinearOperator.jl")


################# action #################
export FactorError, OperatorError
include("action/error.jl")
export text
include("action/text.jl")
export normalize_factor, multiply_factor_to_all, isca
include("action/tools.jl")
include("action/base.jl")
export value
include("action/value.jl")
export swap
include("action/swap.jl")
export sort
include("action/sort.jl")


################# numerical #################
export wick
include("numerical/wick.jl")
export expectation
include("numerical/expectation.jl")

end # module FormulaNormalOrdering
