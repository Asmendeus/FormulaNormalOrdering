struct FormulaTypeError <: Exception
    message::String
end
Base.show(io::IO, e::FormulaTypeError) = print(io, "FormulaTypeError: ", e.message)

struct SubscriptDimensionError <: Exception
    message::String
end
Base.show(io::IO, e::SubscriptDimensionError) = print(io, "SubscriptDimensionError: ", e.message)
