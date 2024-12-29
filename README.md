# FormulaNormalOrdering

This package provides automatic ordering of boson and fermion operators in formula form.

If you find any bugs or have any good suggestions, please submit an issue.

**WARNING**: 

The current version `v0.1` is **just a demo**. The next version `v0.2` is on the way, with a planned release in **January** or **February 2025**, which probably **not be compatible** with `v0.1`.

## Convention

### Subscript Dimension and Type

The subscript used to represent degrees of freedom accepts only three data types: `Symbol, AbstractString, Number`.

* The data types `AbstractString` and `Number` of subscript indicates that the value of the subscript has a clear meaning, e.g., site $\{1,2,3,\cdots\}$, spin $\{\uparrow,\downarrow\}$, orbital $\{sz,dz,dx,\cdots\}$, layer $\{t,m,b\}$ $\cdots$
* The data type `Symbol` of subscript indicates that the degree of freedom is symbolically represented, e.g., site $i$, spin $\sigma$, orbital $\alpha$, layer $\mu$ $\cdots$

This convention will show a different effect on `KroneckerDelta`, `GeneralKroneckerDelta` and any process or result involving them.

### Commutation and Anticommutation

The following operator combinations follow **commutation** relations: **Boson and Fermion**, **Fermion and Boson**, **Boson and Boson**

$$
\begin{align*}
\left[c^{\left(\dagger\right)}_{i,\sigma,\alpha,\cdots},\ b^{\left(\dagger\right)}_{j,\sigma^\prime,\beta,\cdots}\right] = \left[b^{\left(\dagger\right)}_{i,\sigma,\alpha,\cdots},\ c^{\left(\dagger\right)}_{j,\sigma^\prime,\beta,\cdots}\right] &= 0,\\

\left[b_{i,\sigma,\alpha,\cdots},\ b_{j,\sigma^\prime,\beta,\cdots}\right] = 
\left[b^\dagger_{i,\sigma,\alpha,\cdots},\ b^\dagger_{j,\sigma^\prime,\beta,\cdots}\right] &= 0,\\

\left[b_{i,\sigma,\alpha,\cdots},\ b^\dagger_{j,\sigma^\prime,\beta,\cdots}\right] = -\left[b^\dagger_{i,\sigma,\alpha,\cdots},\ b_{j,\sigma^\prime,\beta,\cdots}\right] &= \delta_{i,j}\cdot\delta_{\sigma,\sigma^\prime}\cdot\delta_{\alpha,\beta}\cdots
\end{align*}
$$

The following operator combination follows **anticommutation** relations: **Fermion and Fermion**

$$
\begin{align*}
\left\{c_{i,\sigma,\alpha,\cdots},\ c_{j,\sigma^\prime,\beta,\cdots}\right\} = \left\{c^\dagger_{i,\sigma,\alpha,\cdots},\ c^\dagger_{j,\sigma^\prime,\beta,\cdots}\right\} &= 0,\\

\left\{c_{i,\sigma,\alpha,\cdots},\ c^\dagger_{j,\sigma^\prime,\beta,\cdots}\right\} = \left\{c^\dagger_{i,\sigma,\alpha,\cdots},\ c_{j,\sigma^\prime,\beta,\cdots}\right\} &= \delta_{i,j}\cdot\delta_{\sigma,\sigma^\prime}\cdot\delta_{\alpha,\beta}\cdots
\end{align*}
$$

**Notice**: A Kronecker Delta $\delta_{i,j}$ occurs if and only if the correct operator combination has the same subscript dimensions. This means that unmatched dimensions will result in a commutator or anticommutator value of $0$, e.g., $\left[b_{i},b^\dagger_{j,\sigma}\right]=0,\ \left\{c^\dagger_{i,\alpha},c_{\sigma}\right\}=0,\cdots$

The criteria for determining whether two creation or annihilation operators are equal are operator type and subscript (regardless of order).

### Equality of `AbstractGeneralOperator`

`==` and `isequal` can not distinguish whether two `GeneralSingleOperator` or two `GeneralMultiOperator` are equal after sorting by the same rules, just judging in the current order.

## Urgent Improvement

1. `GeneralFactor`: `GeneralFactor<:AbstractGeneralFactor` has the form of a matrix in the space of subscript dimensions, such as the Pauli matrix. Its introduction needs to consider at least the following aspects:

   - It has `subscript` fieldname and a `value::Array{<:Number, N}`;
   - `subscript` should be handled with care when the function `value` are overloaded;
   - It should be carefully handled in association with Kronecker Delta that have the same subscript dimension(s)
   - `KroneckerDelta` and `ProductKroneckerDelta` may be combined into a subtype of `GeneralFactor`.
2. `LinearFactor`: Currently a `factor::Union{AbstractFactor, Number}`only supports multiplication and opposite number, which limits further simplification and summation of `GeneralMultiOperator`.
3. Anyon operator: The Anyon operator is not considered in this version. A reasonable data structure may be

   ```julia
   AbstractAnyonOperator{θ}<:AbstractOperator
   const AbstractBosonOperator = AbstractAnyonOperator{0}
   const AbstractFermionOperator = AbstractAnyonOperator{π}

   # a_i a^\dagger_j - e^{iθ} a^\dagger_j a_i = δ_{i,j}
   ```

   When the anyon operator is considered, a `::NumberFactor` can be set to store $\mathrm{e}^{\mathrm{i}\theta}$.

If you accomplish the above or any other necessary implementation, please feel free to contact me (3120231483@bit.edu.cn) or submit an issue.

## Update Plan

In my plan, the current version `v0.1` is **just a demo**.

The next version `v0.2` is on the way, with a planned release in **January** or **February 2025**, which probably **not be compatible** with `v0.1`. 

In fact, I've already designed the architecture for `v0.2`, which is highly readable, well-structured, and includes several optimizations compared to `v0.1`. These improvements will facilitate its future development and scalability. However, the biggest challenge is that the new version may be difficult to integrate with the current one, as the original design didn't fully account for future expansion. If you encounter any compatibility issues down the line, I sincerely apologize for the inconvenience.

In addition, detailed documentation and tutorials will also be available in the next release.
