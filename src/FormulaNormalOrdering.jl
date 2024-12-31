module FormulaNormalOrdering

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

export AbstractLinearFactor
include("NamedFactor/LinearFactor/AbstractLinearFactor.jl")


################# Operator #################


################# action #################
export text
include("action/text.jl")

include("action/base.jl")

end # module FormulaNormalOrdering
