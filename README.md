# FormulaNormalOrdering

This package provides automatic ordering of boson and fermion operators in formula form.

If you find any bugs or have any good suggestions, please submit an issue.

## Convention

The subscript used to represent degrees of freedom accepts only three data types: `Symbol, AbstractString, Number`.

* The data types `AbstractString` and `Number` of subscript indicates that the value of the subscript has a clear meaning, e.g., site $\{1,2,3,\cdots\}$, spin $\{\uparrow,\downarrow\}$, layer $\{t, m, b\}$, orbital $\{sz,dz,dx,\cdots\}$, $\cdots$
* The data type `Symbol` of subscript indicates that the degree of freedom is symbolically represented, e.g., site $i$, spin $\sigma$, layer $\mu$, orbital $\alpha$, $\cdots$

This convention will show a different effect on `KroneckerDelta`, `GeneralKroneckerDelta` and any process or result involving them.