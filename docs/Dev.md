## Structure

Subscript

```julia
abstract type AbstractSubscript{S} end
struct Subscript{S} <: AbstractSubscript{S}

# S = :site, :spin, :orbital, ...
```

Factor

```julia
abstract type AbstractNamedFactor end

abstract type AbstractLinearFactor <: AbstractNamedFactor end
abstract type AbstractMultiplyFactor <: AbstractNamedFactor end

struct NumberFactor <: AbstractMultiplyFactor
struct OperatorFactor <: AbstractMultiplyFactor
struct KroneckerDelta{S} <: AbstractMultiplyFactor

struct LinearFactor <: AbstractLinearFactor
```

Operator

```julia
abstract type AbstractOperator end


abstract type AbstractBasicOperator <: AbstractOperator end

abstract type AbstractAnyonOperator{θ, K, S...} <: AbstractBasicOperator end
getAmplitude(::AbstractAnyonOperator{θ, K, S...}) = θ
getOperatorType(::AbstractAnyonOperator{θ, K, S...}) = K # in (:a, :annihilation, :c, :creation)
getSubDims(::AbstractAnyonOperator{θ, K, S...}) = (S...,)
struct AnyonOperator{θ, K, S...} <: AbstractAnyonOperator{θ, K, S...}

const AbstractBosonOperator{K, S...} = AbstractAnyonOperator{0, K, S...}
const BosonOperator{K, S...} = AnyonOperator{0, K, S...}

const AbstractFermionOperator{K, S...} = AbstractAnyonOperator{π, K, S...}
const FermionOperator{K, S...} = AnyonOperator{π, K, S...}

struct IdentityOperator <: AbstractBasicOperator


abstract type AbstractLinearOperator <: AbstractOperator end
struct LinearOperator <: AbstractLinearOperator

abstract type AbstractMultiplyOperator <: AbstractOpeartor end
struct MultiplyOperator <: AbstractMultiplyOperator
```
