################ IO ################
function Base.show(io::IO, op::AbstractFactor)
    print(io, text(op))
end
# function Base.show(io::IO, op::AbstractOperator)
#     print(io, text(op))
# end

############### math ###############
