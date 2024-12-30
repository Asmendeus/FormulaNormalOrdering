abstract type AbstractSubscript{T, S} end

getSubType(::AbstractSubscript{T, S}) where {T, S} = T
getSubDim(::AbstractSubscript{T, S}) where {T, S} = S
