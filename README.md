# FormulaNormalOrdering

This package provides automatic ordering of boson and fermion operators in formula form.

If you find any bugs or have any good suggestions, please submit an issue.

**WARNING**:

The current version `v0.1` is **just a demo**. The next version `v0.2` is on the way, with a planned release in **January** or **February 2025**, which **not be compatible** with `v0.1`. See Update Plan for more.

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

## Tips

The function `sort` establishes a hash table by processing the order of the operators passed in(it will be processed by the function `unique` first), so the same operators will always be put together after sorting.

If you want a freer sort, make sure that there are no duplicate operators in the `GeneralOperator` you enter. This can be done by **changing the name of the duplicate operator**.

## An Example

$$
\begin{align*}
\bm{S}_i \cdot (\bm{S}_j \times \bm{S}_k) &= \frac{1}{8} \sum_{\alpha, \beta, \gamma} \epsilon_{\alpha \beta \gamma} \, c_{i,\sigma_1}^\dagger \sigma_{\sigma_1,\sigma_2}^\alpha c_{i,\sigma_2} \, c_{j,\sigma_3}^\dagger \sigma_{\sigma_3,\sigma_4}^\beta c_{j,\sigma_4} \, c_{k,\sigma_5}^\dagger \sigma_{\sigma_5,\sigma_6}^\gamma c_{k,\sigma_6} \\ \\

\text{Input}:
&0.125*\epsilon_{\alpha\beta\gamma} \sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\beta}_{\sigma_3,\sigma_4} \sigma^{\gamma}_{\sigma_5,\sigma_6} × c^\dag_{i,\sigma_1}c_{i,\sigma_2}c^\dag_{j,\sigma_3}c_{j,\sigma_4}c^\dag_{k,\sigma_5}c_{k,\sigma_6} \\ \\

\text{Output}:
&-0.125*\epsilon_{\alpha\beta\gamma} \sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\beta}_{\sigma_3,\sigma_4} \sigma^{\gamma}_{\sigma_5,\sigma_6} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_3}c^\dag_{k,\sigma_5}c_{i,\sigma_2}c_{j,\sigma_4}c_{k,\sigma_6} \\
&- 0.125*\epsilon_{\alpha\beta\gamma} \sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\beta}_{\sigma_3,\sigma_4} \sigma^{\gamma}_{\sigma_5,\sigma_6}*δ_{i,j}δ_{\sigma_2,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_5}c_{j,\sigma_4}c_{k,\sigma_6} \\
&- 0.125*\epsilon_{\alpha\beta\gamma} \sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\beta}_{\sigma_3,\sigma_4} \sigma^{\gamma}_{\sigma_5,\sigma_6}*δ_{j,k}δ_{\sigma_4,\sigma_5} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_3}c_{i,\sigma_2}c_{k,\sigma_6} \\
&+ 0.125*\epsilon_{\alpha\beta\gamma} \sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\beta}_{\sigma_3,\sigma_4} \sigma^{\gamma}_{\sigma_5,\sigma_6}*δ_{i,k}δ_{\sigma_2,\sigma_5} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_3}c_{j,\sigma_4}c_{k,\sigma_6} \\
&+ 0.125*\epsilon_{\alpha\beta\gamma} \sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\beta}_{\sigma_3,\sigma_4} \sigma^{\gamma}_{\sigma_5,\sigma_6}*δ_{i,j}δ_{\sigma_2,\sigma_3}δ_{j,k}δ_{\sigma_4,\sigma_5} × c^\dag_{i,\sigma_1}c_{k,\sigma_6}
\end{align*}
$$

## Update Plan

The current version `v0.1` is **just a demo**. Part of the structural design is not reasonable, leading to the difficulty of continuing development. The following two sections address some of these issues.

The new version `v0.2` is on the way, with a planned release in **January** or **February 2025**, which **not be compatible** with `v0.1`.

I've already designed the architecture for `v0.2`, which is highly readable, well-structured, and includes several optimizations compared to `v0.1`. I believe these improvements will facilitate its future development and scalability.

The biggest problem is that the new version may be difficult to integrate with the current one, as the original design didn't fully account for future expansion. If you encounter any compatibility issues down the line, I sincerely apologize for the inconvenience.

In addition, detailed documentation and tutorials will also be available in the next release.

## Urgent Structural Adjustment

1. Subscript Type is a terrible concept that only works in `value(factor::AbstractFactor)`, so a better concept is the Factor Type which should be set as a type parameter rather than a parameter type.
2. At present, the addition and multiplication of factors and operators are not properly designed. A better idea is to design structures that are parallel to addition (including number multiplication) and multiplication, e.g., `eltpye(::Multiplication)=Linear` and `eltype(::Linear)=Multiplication`.
   Multiplication can be implemented with a nested structure, and addition takes into account the Array structure.

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
