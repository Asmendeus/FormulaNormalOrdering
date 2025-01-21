# FormulaNormalOrdering

A package providing a formulaic framework for anyon operators, including boson and fermion operators, and named coefficients.

## Features

- Support for pure formula derivation and export of LaTeX text
- Classification of subscripts for various models and lattices
- Support text and value conversion for named factors
- Implementation of common functions of formula derivation, e.g., normal ordering(`sort`)
- A universal and extensible architecture, easy to customize required functions, such as applying to numerical calculations, determining whether an many-body operator has certain symmetry, and so on.

## Structure

### Types

3 types: `Subscipt`, `NamedFactor`, `Operator`

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

### Methods

Some methods: `text`, `value`, `swap`, `sort`, `wick`, `expectation`

**formula methods**

`text`: export text in LaTeX form

`value`: convert a NamedFactor to a certain value

`swap`: swap two basic operators

`sort`: sort the basic operators in the many-body operators

**numerical methods**

`wick`: solve the expected value of a many-body operator without a factor in the form of $c^\dagger\cdots c^\dagger c\cdots c$ (with charge U(1) symmetry) by single-particle Green's function and wick theorem.

`expectation`: solve the expected value of a general many-body operator (low efficiency, for large-scale repeated calculation, it is recommended to use the `wick` function after `sort` the many-body operator).

## Guide

### Installation

The package `FormulaNormalOrdering` is not registered yet. You can install it by typing the following command

```julia-repl
julia> ]
pkg> add https://github.com/Asmendeus/FormulaNormalOrdering.git#main
```

### Subscript

`Subscript` is a notation for the physical meaning of the creation and annihilation operators, such as site, spin, orbital, $\cdots$

`OperatorFactor` (e.g. Pauli matrix), also supports the introduction of subscripts.

We start by generating a general subscript instance

```julia
Mysub = Subscript{:mysub}
sub1 = Mysub(1)
```

There are 5 subscript subtypes that have been defined

```julia
Site = Subscript{:site}
Spin = Subscript{:spin}
Orbital = Subscript{:orbital}
Layer = Subscript{:layer}
Kpoint = Subscript{:kpoint}
```

### NamedFactor

`NamedFactor` is a factor with certain physical meaning, e.g. Pauli matrix.

If you only need to do pure formula derivation and don't need to convert the factors from text to concrete values, then the use of `SymbolFactor` is recommended

```julia
σz = SFactor(:σz)
```

Otherwise `NumberFactor` and `OperatorFactor` are a better choice

```julia
σz_upup = NFactor("σz_{↑↑}", 1)

σz_dict = Dict((Spin(:↑), Spin(:↑))=>1, (Spin(:↑), Spin(:↓))=>0, (Spin(:↓), Spin(:↑))=>0, (Spin(:↓), Spin(:↓))=>-1)
σz_upup = OFactor(:σz, (Spin(:↑), Spin(:↑)), σz_dict)
```

### Operator

The basic operators are the anyon creation and annihilation operators

```julia
adag_iσ = ACOp{π/2}(:a, (Site(:i), Spin(:σ)))
a_jσ′ = AAOp{π/2}(:a, (Site(:j), Spin(:σ′)))
```

The most common fermion system and boson system are considered to be special anyon systems in the package. The boson and fermion operators are subtypes that inherit from anyon operator

```julia
bdag_i = BCOp(:b, Site(:i))
b_j = BAOp(:b, Site(:j))

fdag_iσ = FCOp(:f, (Site(:i), Spin(:σ)))
f_jσ′ = FAOp(:f, (Site(:j), Spin(:σ′)))
```

To represent a many-body operator, you can multiply several base operators

```julia
hop = fdag_iσ * f_jσ′
```

Factors can also be introduced by multiplication

```julia
hop = -1 * fdag_iσ * f_jσ′
```

### Formula Actions

You can export text of a Subscript, Factor or Operator instance in LaTeX form by `text` function

```julia
function text(::AbstractSubscript)::LaTeXString
function text(::Union{Number, AbstractNamedFactor})::LaTeXString
function text(::AbstractOperator)::LaTeXString
```

The function `value` converts a NamedFactor into a certain number.

```julia
function value(::AbstractNamedFactor)::Number
function value(::AbstractOperator)::AbstractOperator
```

The function `swap` swaps two basic operators (only fermion operators and boson operators are supported now)

```julia
function swap(op1::AbstractBasicOperator, op2::AbstractBasicOperator; kwargs...)
```

The function `sort` sorts the basic operators in the specified order. By default, all creation operators are preposed and all annihilation operators are postposed.

```julia
function sort(op::MultiplyOperator; kwargs...)
function sort(op::LinearOperator; kwargs...)
```

### Numerical Actions

The function `wick` solves the expected value of a many-body operator without a factor in the form of $c^\dagger\cdots c^\dagger c\cdots c$ (with charge U(1) symmetry) by single-particle Green's function and wick theorem. The input argument `G` is the single-particle Green's function, $G_{ij} = ⟨ϕ|c^\dagger_i c_j|φ⟩$, and each index in `indices` corresponds to the subscripts of a fermion operator.

```julia
function wick(G::Matrix{<:Number}, indices::Int...)
```

The function `expectation` solves the expected value of a general many-body operator

```julia
function expectation(G::Matrix{<:Number}, op::MultiplyOperator, f::Function)
function expectation(G::Matrix{<:Number}, op::LinearOperator, f::Function)
```

> WARNING: The performance optimization of `expectation` function is poor, large-scale calculation of the occasion, please use `wick` function manual calculation.

## How to contribute

- If you benefit from this package, please star it
- If you find a bug, you can submit an issue or a PR if you have fixed it
- If you are familiar with swapping or sorting anyon operators, submit a submit or a PR if you perfect the `swap` function for anyon operator
- If you need a feature (either a formula-only feature or one that combines with numerical methods) , please submit an issue (preferably with an implementation idea) and I'll update the feature as soon as possible. Or submit a PR if you've already implemented it.

The library is dedicated to automating arbitrary formula derivation process, so any related requirements will be considered. Please feel free to contact with me.
