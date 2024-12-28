module FormulaNormalOrdering

using LaTeXStrings


export AbstractFactor
include("Factor/AbstractFactor.jl")

export GeneralFactor, GFactor
include("Factor/GeneralFactor.jl")

export AbstractKroneckerDelta
export KroneckerDelta, KDelta
export GeneralKroneckerDelta, GKDelta
include("Factor/KroneckerDelta/AbstractKroneckerDelta.jl")
include("Factor/KroneckerDelta/KroneckerDelta.jl")
include("Factor/KroneckerDelta/GeneralKroneckerDelta.jl")


export AbstractOperator
include("Operator/AbstractOperator.jl")

export AbstractBosonOperator
export BosonAnnihilationOperator, BAOp
export BosonCreationOperator, BCOp
include("Operator/BosonOperator/AbstractBosonOperator.jl")
include("Operator/BosonOperator/BosonAnnihilationOperator.jl")
include("Operator/BosonOperator/BosonCreationOperator.jl")

export AbstractFermionOperator
export FermionAnnihilationOperator, FAOp
export FermionCreationOperator, FCOp
include("Operator/FermionOperator/AbstractFermionOperator.jl")
include("Operator/FermionOperator/FermionAnnihilationOperator.jl")
include("Operator/FermionOperator/FermionCreationOperator.jl")

export AbstractGeneralOperator
export SingleGeneralOperator, SGOp
export MultiGeneralOperator, MGOp
include("Operator/GeneralOperator/AbstractGeneralOperator.jl")
include("Operator/GeneralOperator/SingleGeneralOperator.jl")
include("Operator/GeneralOperator/MultiGeneralOperator.jl")


export text
include("action/text.jl")
include("action/base.jl")
export isOperator, isBoson, isBAOp, isBCOp, isFermion, isFAOp, isFCOp, isGeneral, isSGOp, isMGOp
export isFactor, isNumber, isGFactor, isKDelta, isGKDelta, value
include("action/tools.jl")
export swap
include("action/swap.jl")
include("action/sort.jl")

end # module FormulaNormalOrdering
