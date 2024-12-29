using LaTeXStrings, DataStructures

const SymbolType = Symbol
const CertainType = Union{AbstractString, Number}

include("src/Subscript/AbstractSubscript.jl")
include("src/Subscript/GeneralSubscript.jl")

include("src/Factor/AbstractFactor.jl")
include("src/Factor/GeneralFactor/AbstractGeneralFactor.jl")
include("src/Factor/GeneralFactor/NumberFactor.jl")
include("src/Factor/KroneckerDelta/AbstractKroneckerDelta.jl")
include("src/Factor/KroneckerDelta/KroneckerDelta.jl")
include("src/Factor/KroneckerDelta/ProductKroneckerDelta.jl")

include("src/Operator/AbstractOperator.jl")
include("src/Operator/BosonOperator/AbstractBosonOperator.jl")
include("src/Operator/BosonOperator/BosonAnnihilationOperator.jl")
include("src/Operator/BosonOperator/BosonCreationOperator.jl")
include("src/Operator/FermionOperator/AbstractFermionOperator.jl")
include("src/Operator/FermionOperator/FermionAnnihilationOperator.jl")
include("src/Operator/FermionOperator/FermionCreationOperator.jl")
include("src/Operator/GeneralOperator/AbstractGeneralOperator.jl")
include("src/Operator/GeneralOperator/GeneralSingleOperator.jl")
include("src/Operator/GeneralOperator/GeneralMultiOperator.jl")

include("src/action/Error.jl")
include("src/action/text.jl")
include("src/action/base.jl")
include("src/action/tools.jl")
include("src/action/value.jl")
