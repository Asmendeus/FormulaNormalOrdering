module FormulaNormalOrdering

using AbstractTrees
using DataStructures
using LaTeXStrings

################# Subscript #################
export AbstractSubscript, getSubType
include("Subscript/AbstractSubscript.jl")

export Subscript, getSubLabel, Site, Spin, Orbital, Layer
include("Subscript/Subscript.jl")


################# Factor #################
export AbstractNamedFactor, getFactorType
include("NamedFactor/AbstractNamedFactor.jl")

export AbstractMultiplyFactor
include("NamedFactor/MultiplyFactor/AbstractMultiplyFactor.jl")
export KroneckerDelta, KDelta
include("NamedFactor/MultiplyFactor/KroneckerDelta.jl")
export NumberFactor, NFactor
include("NamedFactor/MultiplyFactor/NumberFactor.jl")
export OperatorFactor, OFactor
include("NamedFactor/MultiplyFactor/OperatorFactor.jl")

export AbstractLinearFactor
include("NamedFactor/LinearFactor/AbstractLinearFactor.jl")
export LinearFactor, LFactor
include("NamedFactor/LinearFactor/LinearFactor.jl")

################# Operator #################


################# action #################
export FactorError, FactorTypeError
include("action/error.jl")

export text
include("action/text.jl")

include("action/base.jl")

export value
include("action/value.jl")

end # module FormulaNormalOrdering
