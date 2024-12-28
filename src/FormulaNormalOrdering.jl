module FormulaNormalOrdering

using DataStructures
using LaTeXStrings

################# SubscriptType #################
const SymbolType = Symbol
const CertainType = Union{AbstractString, Number}

export SymbolType, CertainType


################# Subscript #################
export AbstractSubscript, getSubDim, getSubType
include("Subscript/AbstractSubscript.jl")

export GeneralSubscript, GSubscript
export Site, Spin, Orbital, Layer
include("Subscript/GeneralSubscript.jl")


################# Factor #################
export AbstractFactor
include("Factor/AbstractFactor.jl")

export AbstractGeneralFactor
include("Factor/GeneralFactor/AbstractGeneralFactor.jl")
export NumberFactor, NFactor
include("Factor/GeneralFactor/NumberFactor.jl")

export AbstractKroneckerDelta
include("Factor/KroneckerDelta/AbstractKroneckerDelta.jl")
export KroneckerDelta, KDelta
include("Factor/KroneckerDelta/KroneckerDelta.jl")
export ProductKroneckerDelta, PKDelta
include("Factor/KroneckerDelta/ProductKroneckerDelta.jl")


################# Operator #################
export AbstractOperator
include("Operator/AbstractOperator.jl")

export AbstractBosonOperator
include("Operator/BosonOperator/AbstractBosonOperator.jl")
export BosonAnnihilationOperator, BAOp
include("Operator/BosonOperator/BosonAnnihilationOperator.jl")
export BosonCreationOperator, BCOp
include("Operator/BosonOperator/BosonCreationOperator.jl")

export AbstractFermionOperator
include("Operator/FermionOperator/AbstractFermionOperator.jl")
export FermionAnnihilationOperator, FAOp
include("Operator/FermionOperator/FermionAnnihilationOperator.jl")
export FermionCreationOperator, FCOp
include("Operator/FermionOperator/FermionCreationOperator.jl")

export AbstractGeneralOperator
include("Operator/GeneralOperator/AbstractGeneralOperator.jl")
export GeneralSingleOperator, GSOp
include("Operator/GeneralOperator/GeneralSingleOperator.jl")
export GeneralMultiOperator, GMOp
include("Operator/GeneralOperator/GeneralMultiOperator.jl")


################# action #################
export text
include("action/text.jl")

include("action/base.jl")

export isSubscript, isGSubscript
export isFactor, isNumber, isNFactor, isKDelta, isGKDelta
export isOperator, isBoson, isBAOp, isBCOp, isFermion, isFAOp, isFCOp, isGeneral, isGSOp, isGMOp
include("action/tools.jl")

export value
include("action/value.jl")

export swap
include("action/swap.jl")

include("action/sort.jl")

end # module FormulaNormalOrdering
