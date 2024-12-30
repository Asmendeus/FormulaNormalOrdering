## Structure

Subscript

```julia
abstract type AbstractSubscript{T, S} end
struct Subscript{T, S} <: AbstractSubscript{T,S}

# T == :Symbol || T == :Certain
# S = :Site, :Spin, :Orbital, ...
```

Factor

```julia
abstract type AbstractNamedFactor{T} end
abstract type AbstractLinearFactor{T} <: AbstractNamedFactor{T} end
abstract type AbstractMultiplyFactor{T} <: AbstractLinearFactor{T} end

struct NumberFactor{T} <: AbstractMultiplyFactor{T}
struct OperatorFactor{T, S...} <: AbstractMultiplyFactor{T}
struct KroneckerDelta{T, S...} <: AbstractMultiplyFactor{T}
struct LinearFactor{T} <: AbstractLinearFactor{T}
```

Operator

```julia
abstract type AbstractOperator{T} end


abstract type AbstractBasicOperator{T, S...} <: AbstractOperator{T} end

abstract type AbstractAnyonOperator{θ, T, S...} <: AbstractBasicOperator{T, S...} end
getAmplitude(::AbstractAnyonOperator{θ, T, S...}) = θ
getSubType(::AbstractAnyonOperator{θ, T, S...}) = T
getSubDims(::AbstractAnyonOperator{θ, T, S...}) = (S...,)
struct AnyonOperator{θ, T, S...} <: AbstractAnyonOperator{θ, T, S...}

const AbstractBosonOperator = AbstractAnyonOperator{0}
const BosonOperator = AnyonOperator{0}

const AbstractFermionOperator = AbstractAnyonOperator{π}
const FermionOperator = AnyonOperator{π}


abstract type AbstractLinearOperator <: AbstractOperator end
struct LinearOperator <: AbstractLinearOperator

abstract type AbstractMultiplyOperator <: AbstractLinearOpeartor end
struct MultiplyOperator <: AbstractMultiplyOperator
```
