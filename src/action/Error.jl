struct SubscriptDimensionError <: Exception
    message::String
end
Base.show(io::IO, e::SubscriptDimensionError) = print(io, "SubscriptDimensionError: ", e.message)

struct SubscriptTypeError <: Exception
    message::String
end
Base.show(io::IO, e::SubscriptTypeError) = print(io, "SubscriptTypeError: ", e.message)
