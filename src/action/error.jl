struct FactorError <: Exception
    message::String
end
Base.show(io::IO, e::FactorError) = print(io, "FactorError: ", e.message)

struct FactorTypeError <: Exception
    message::String
end
Base.show(io::IO, e::FactorTypeError) = print(io, "FactorTypeError: ", e.message)
