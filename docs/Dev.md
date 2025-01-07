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

abstract type AbstractIdentityOperator <: AbstractBasicOperator end
abstract type AbstractAnyonOperator{θ, K} <: AbstractBasicOperator end
getPhase(::AbstractAnyonOperator{θ, K}) = θ
getOperatorType(::AbstractAnyonOperator{θ, K}) = K # in (:a, :c)

struct AnyonOperator{θ, K} <: AbstractAnyonOperator{θ, K}

const AbstractBosonOperator{K} = AbstractAnyonOperator{0, K}
const BosonOperator{K} = AnyonOperator{0, K}

const AbstractFermionOperator{K} = AbstractAnyonOperator{π, K}
const FermionOperator{K} = AnyonOperator{π, K}

struct IdentityOperator <: AbstractIdentityOperator


abstract type AbstractLinearOperator <: AbstractOperator end
struct LinearOperator <: AbstractLinearOperator

abstract type AbstractMultiplyOperator <: AbstractOpeartor end
struct MultiplyOperator <: AbstractMultiplyOperator
```
