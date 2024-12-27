module FormulaNormalOrdering

using LaTeXStrings


export AbstractFactor
include("Factor/AbstractFactor.jl")

export KroneckerDelta, KDelta
export GeneralKroneckerDelta, GKDelta
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
export isBoson, isBAOp, isBCOp
export isFermion, isFAOp, isFCOp
export isGeneral, isDelta, isSGOp, isMGOp, value
include("action/tools.jl")
export swap
include("action/swap.jl")
include("action/sort.jl")

end # module FormulaNormalOrdering
