module FormulaNormalOrdering

using DataStructures
using LaTeXStrings

################# Subscript #################
export AbstractSubscript, getSubType, getSubDim
include("Subscript/AbstractSubscript.jl")

export Subscript, Site, Spin, Orbital, Layer
include("Subscript/Subscript.jl")

################# Factor #################


################# Operator #################

################# action #################

end # module FormulaNormalOrdering
