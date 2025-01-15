# FormulaNormalOrdering

A package providing a formulaic framework for anyon operators, including boson and fermion operators, and named coefficients.

## Package Features

- Support for pure formula derivation and export of LaTeX text
- Classification of subscripts for various models and lattices
- Support for factor text and value conversion
- Implementation of common functions of formula derivation, e.g., normal ordering(`sort`)
- A universal and extensible architecture, easy to customize required functions, such as applying to numerical calculations, determining whether an many-body operator has certain symmetry, and so on.

## Package Structure

**Three types of datatype: `Subscipt`, `NamedFactor`, `Operator`**

**Subscript**: physical label like site, orbital, kpoint,...

```julia
abstract type AbstractSubscript{S}
struct Subscript{S} <: AbstractSubscript{S}
```

**NamedFactor**: Named factor with a physical meaning

```julia
abstract type AbstractNamedFactor

abstract type AbstractMultiplyFactor <: AbstractNamedFactor
struct KroneckerDelta{S} <: AbstractMultiplyFactor
struct NumberFactor <: AbstractMultiplyFactor
struct OperatorFactor <: AbstractMultiplyFactor
struct SymbolFactor <: AbstractMultiplyFactor

abstract type AbstractLinearFactor <: AbstractNamedFactor
struct LinearFactor <: AbstractLinearFactor
```

**Operator**: basic operator and many-body operator

```julia
abstract type AbstractOperator

abstract type AbstractBasicOperator <: AbstractOperator
abstract type AbstractAnyonOperator{θ, K} <: AbstractBasicOperator
struct AnyonOperator{θ, K} <: AbstractAnyonOperator{θ, K}
const AnyonAnnihilationOperator{θ} = AnyonOperator{θ, :a}
const AnyonCreationOperator{θ} = AnyonOperator{θ, :c}
const BosonOperator{K} = AnyonOperator{0, K}
const BosonAnnihilationOperator = BosonOperator{:a}
const BosonCreationOperator = BosonOperator{:c}
const FermionOperator{K} = AnyonOperator{π, K}
const FermionAnnihilationOperator = FermionOperator{:a}
const FermionCreationOperator = FermionOperator{:c}
abstract type AbstractIdentityOperator <: AbstractBasicOperator
struct IdentityOperator <: AbstractIdentityOperator

abstract type AbstractMultiplyOperator <: AbstractOperator
mutable struct MultiplyOperator <: AbstractMultiplyOperator

abstract type AbstractLinearOperator <: AbstractOperator
mutable struct LinearOperator <: AbstractLinearOperator
```

**Some methods: `text`, `value`, `swap`, `sort`, `wick`, `expectation`**

formula methods

`text`: export text in LaTeX form

`value`: convert a NamedFactor to a certain value

`swap`: swap two basic operators

`sort`: sort the basic operators in the many-body operators

numerical methods

`wick`: solve the expected value of a many-body operator without a factor in the form of $c^\dag\cdots c^\dag c\cdots c$ (with charge U(1) symmetry) by single-particle Green's function and wick theorem.

`expectation`: solve the expected value of a general many-body operator (low efficiency, for large-scale repeated calculation, it is recommended to use the `wick` function after `sort` the many-body operator).

## Package Guide

### Installation

```julia-repl
julia> ]
pkg> add https://github.com/Asmendeus/FormulaNormalOrdering.git#main
```
