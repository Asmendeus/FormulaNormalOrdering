# FormulaNormalOrdering

This package provides automatic ordering of boson and fermion operators in formula form.

If you find any bugs or have any good suggestions, please feel free to contact me (3120231483@bit.edu.cn) or submit an issue.

## Subscript Convention

The subscript used to represent degrees of freedom accepts only three data types: `Symbol, AbstractString, Number`.

* The data types `AbstractString` and `Number` of subscript indicates that the value of the subscript has a clear meaning, e.g., site $\{1,2,3,\cdots\}$, spin $\{\uparrow,\downarrow\}$, orbital $\{sz,dz,dx,\cdots\}$, layer $\{t,m,b\}$ $\cdots$
* The data type `Symbol` of subscript indicates that the degree of freedom is symbolically represented, e.g., site $i$, spin $\sigma$, orbital $\alpha$, layer $\mu$ $\cdots$

This convention will show a different effect on `KroneckerDelta`, `GeneralKroneckerDelta` and any process or result involving them.
