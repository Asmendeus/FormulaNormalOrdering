module FormulaNormalOrdering

using DataStructures
using LaTeXStrings

################# Subscript #################
export AbstractSubscript, getType, getSubDim
include("Subscript/AbstractSubscript.jl")

export Subscript, getSubLabel, Site, Spin, Orbital, Layer
include("Subscript/Subscript.jl")

################# Factor #################


################# Operator #################


################# action #################
export FormulaTypeError, SubscriptDimensionError
include("action/Error.jl")

export text
include("action/text.jl")

include("action/base.jl")

end # module FormulaNormalOrdering
