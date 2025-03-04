# CHANGELOG

All notable changes to `FormulaNormalOrdering` will be documented in this file.

## [v0.2.1] - 2025-01-24

### Added

- Add function `Op2Dict`

### Improved

- Optimize the output text when the number factors are 1 and -1

## [v0.2.0] - 2025-01-22

### Overview

This is the first official release of `FormulaNormalOrdering`, a package designed for providing a formulaic framework for anyon operators, including boson and fermion operators, and named coefficients.

### Features

- Support for pure formula derivation and export of LaTeX text
- Classification of subscripts for various models and lattices
- Support text and value conversion for named factors
- Implementation of common functions of formula derivation, e.g., normal ordering(`sort`)
- A universal and extensible architecture, easy to customize required functions, such as applying to numerical calculations, determining whether an many-body operator has certain symmetry, and so on.

### Known Issues

* [X] Text is redundant when the number coefficient is 1 or -1
* [ ] The feature of merging similar items of factors and operators has not been realized
* [ ] The named factors of different orders are not judged to be equal
* [X] Lack of numerical methods for transforming operators into number factors and indices
* [ ] Lack of symmetry related methods
