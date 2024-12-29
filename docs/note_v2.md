## Structure

Subscript

```julia
abstract type AbstractSubscript{T, S}

getSubType(::AbstractSubscript{T, S}) where {T, S} = T
getSubDim(::AbstractSubscript{T, S}) where {T, S} = S

struct Subscript{T, S} <: AbstractSubscript{T, S}


# T == :Symbol || T == :Certain
```

Factor

```julia
abstract type AbstractFactor
abstract type AbstractLinearFactor <: AbstractFactor
abstract type AbstractMultiplyFactor <: AbstractLinearFactor
abstract type AbstractKronecker{T, S...} <: AbstractMultiplyFactor

struct NumberFactor <: AbstractMultiplyFactor
struct OperatorFactor{S...} <: AbstractMultiplyFactor
struct KroneckerDelta{T, S...} <: AbstractKronecker{T, S...}
struct LinearFactor <: AbstractLinearFactor
```

Operator

```julia
abstract type AbstractOperator{T}


abstract type AbstractBasicOperator{T, S...} <: AbstractOperator{T}

abstract type AbstractAnyonOperator{θ, T, S...} <: AbstractBasicOperator{T, S...}
getAmplitude(::AbstractAnyonOperator{θ, T, S...}) = θ
getSubType(::AbstractAnyonOperator{θ, T, S...}) = T
getSubDims(::AbstractAnyonOperator{θ, T, S...}) = (S...,)
struct AnyonOperator{θ, T, S...} <: AbstractAnyonOperator{θ, T, S...}

const AbstractBosonOperator = AbstractAnyonOperator{0}
const BosonOperator = AnyonOperator{0}

const AbstractFermionOperator = AbstractAnyonOperator{π}
const FermionOperator = AnyonOperator{π}


abstract type AbstractLinearOperator <: AbstractOperator
struct LinearOperator <: AbstractLinearOperator

abstract type AbstractMultiplyOperator <: AbstractLinearOpeartor
struct MultiplyOperator <: AbstractMultiplyOperator
```
