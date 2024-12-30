module FormulaNormalOrdering

using DataStructures
using LaTeXStrings

################# Subscript #################
export AbstractSubscript, getSubType, getSubDim
include("Subscript/AbstractSubscript.jl")

export Subscript, getSubLabel, Site, Spin, Orbital, Layer
include("Subscript/Subscript.jl")

################# Factor #################


################# Operator #################

################# action #################
export SubscriptTypeError, SubscriptDimensionError
include("action/Error.jl")

end # module FormulaNormalOrdering
