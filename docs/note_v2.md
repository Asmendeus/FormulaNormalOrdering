## Structure

Subscript

```julia
abstract type AbstractSubscript{S} end
struct Subscript{S} <: AbstractSubscript{S}

# S = :site, :spin, :orbital, ...
```

Factor

```julia
abstract type AbstractNamedFactor{T} end

abstract type AbstractLinearFactor{T} <: AbstractNamedFactor{T} end
abstract type AbstractMultiplyFactor{T} <: AbstractNamedFactor{T} end

struct NumberFactor{T} <: AbstractMultiplyFactor{T}
struct OperatorFactor{T, S...} <: AbstractMultiplyFactor{T}
struct KroneckerDelta{T, S...} <: AbstractMultiplyFactor{T}

struct LinearFactor{T} <: AbstractLinearFactor{T}
```

Operator

```julia
abstract type AbstractOperator end


abstract type AbstractBasicOperator{K, S...} <: AbstractOperator end

abstract type AbstractAnyonOperator{θ, K, S...} <: AbstractBasicOperator{K, S...} end
getAmplitude(::AbstractAnyonOperator{θ, K, S...}) = θ
getOperatorType(::AbstractAnyonOperator{θ, K, S...}) = K # in (:a, :annihilation, :c, :creation)
getSubDims(::AbstractAnyonOperator{θ, K, S...}) = (S...,)
struct AnyonOperator{θ, K, S...} <: AbstractAnyonOperator{θ, K, S...}

const AbstractBosonOperator{K, S...} = AbstractAnyonOperator{0, K, S...}
const BosonOperator{K, S...} = AnyonOperator{0, K, S...}

const AbstractFermionOperator{K, S...} = AbstractAnyonOperator{π, K, S...}
const FermionOperator{K, S...} = AnyonOperator{π, K, S...}


abstract type AbstractLinearOperator <: AbstractOperator end
struct LinearOperator <: AbstractLinearOperator

abstract type AbstractMultiplyOperator <: AbstractOpeartor end
struct MultiplyOperator <: AbstractMultiplyOperator
```
