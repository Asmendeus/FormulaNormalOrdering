"""
`T::Symbol` represents the mode of a NamedFactor, only with two available values `:symbol` or `:certain`.
    `T == :symbol` means that the named factor does not have an actual value, only with a name.
    `T == :certain` means that the named factor have an actual value. You can choose to output the factor in symbolic form, or convert it into an exact number
"""