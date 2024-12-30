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


abstract type AbstractBasicOperator{K, T, S...} <: AbstractOperator{T} end

abstract type AbstractAnyonOperator{θ, K, T, S...} <: AbstractBasicOperator{K, T, S...} end
getAmplitude(::AbstractAnyonOperator{θ, K, T, S...}) = θ
getOperatorType(::AbstractAnyonOperator{θ, K, T, S...}) = K # in (:a, :annihilation, :c, :creation)
getType(::AbstractAnyonOperator{θ, K, T, S...}) = T
getSubDims(::AbstractAnyonOperator{θ, K, T, S...}) = (S...,)
struct AnyonOperator{θ, K, T, S...} <: AbstractAnyonOperator{θ, K, T, S...}

const AbstractBosonOperator{K, T, S...} = AbstractAnyonOperator{0, K, T, S...}
const BosonOperator{K, T, S...} = AnyonOperator{0, K, T, S...}

const AbstractFermionOperator{K, T, S...} = AbstractAnyonOperator{π, K, T, S...}
const FermionOperator{K, T, S...} = AnyonOperator{π, K, T, S...}


abstract type AbstractLinearOperator <: AbstractOperator end
struct LinearOperator <: AbstractLinearOperator

abstract type AbstractMultiplyOperator <: AbstractLinearOpeartor end
struct MultiplyOperator <: AbstractMultiplyOperator
```
