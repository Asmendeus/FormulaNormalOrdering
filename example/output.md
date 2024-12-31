The following operators with $SU(2)_\text{spin}$ symmetry have been tested

example 1:

$$
\begin{align*}
\bm{S}_i\cdot\bm{S}_j &= \frac{1}{4}\sum_{\alpha=x,y,z}\sum_{\sigma_1,\sigma_2,\sigma_3,\sigma_4} c^\dag_{i,\sigma_1}\sigma^\alpha_{\sigma_1,\sigma_2}c_{i,\sigma_2}\ c^\dag_{j,\sigma_3}\sigma^\alpha_{\sigma_3,\sigma_4}c_{j,\sigma_4}\\ \\

\text{Input}: 
&0.25*\sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\alpha}_{\sigma_3,\sigma_4} × c^\dag_{i,\sigma_1}c_{i,\sigma_2}c^\dag_{j,\sigma_3}c_{j,\sigma_4}\\ \\

\text{Output}: 
&-0.25*\sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\alpha}_{\sigma_3,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_3}c_{i,\sigma_2}c_{j,\sigma_4} \\
&+ 0.25*\sigma^{\alpha}_{\sigma_1,\sigma_2} \sigma^{\alpha}_{\sigma_3,\sigma_4}*δ_{i,j}δ_{\sigma_2,\sigma_3} × c^\dag_{i,\sigma_1}c_{j,\sigma_4}
\end{align*}
$$

example 2:

$$
\begin{align*}
n_in_jn_k &= \sum_{\sigma_1,\sigma_2,\sigma_3} c^\dag_{i,\sigma_1} c_{i,\sigma_1} c^\dag_{j,\sigma_2} c_{j,\sigma_2} c^\dag_{k,\sigma_3} c_{k,\sigma_3}\\ \\

\text{Input}: 
&1 × c^\dag_{i,\sigma_1} c_{i,\sigma_1} c^\dag_{j,\sigma_2} c_{j,\sigma_2} c^\dag_{k,\sigma_3} c_{k,\sigma_3} \\ \\

\text{Output}:
&-1 × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{i,\sigma_1}c_{j,\sigma_2}c_{k,\sigma_3} \\
&- 1*δ_{i,j}δ_{\sigma_1,\sigma_2} 
× c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c_{j,\sigma_2}c_{k,\sigma_3} \\
&- 1*δ_{j,k}δ_{\sigma_2,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{i,\sigma_1}c_{k,\sigma_3}\\
&+ 1*δ_{i,k}δ_{\sigma_1,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{j,\sigma_2}c_{k,\sigma_3}\\
&+ 1*δ_{i,j}δ_{\sigma_1,\sigma_2}δ_{j,k}δ_{\sigma_2,\sigma_3} × c^\dag_{i,\sigma_1}c_{k,\sigma_3}
\\ \\

\text{ValueOutput}:
&-1 × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{i,\sigma_1}c_{j,\sigma_2}c_{k,\sigma_3} \\
&- 1*δ_{\sigma_1,\sigma_2}δ_{i,j} 
× c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c_{j,\sigma_2}c_{k,\sigma_3} \\
&- 1*δ_{\sigma_2,\sigma_3}δ_{j,k} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{i,\sigma_1}c_{k,\sigma_3}\\
&+ 1*δ_{\sigma_1,\sigma_3}δ_{i,k} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{j,\sigma_2}c_{k,\sigma_3}\\
&+ 1*δ_{\sigma_1,\sigma_2,\sigma_3}δ_{i,j,k} × c^\dag_{i,\sigma_1}c_{k,\sigma_3}
\end{align*}
$$

example 3

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

example 4

$$
\begin{align*}
(F^\dag F)_{ij}\ n_k &= \sum_{\sigma_1,\sigma_2} c^\dag_{i\sigma_1} c_{j\sigma_1} c^\dag_{k\sigma_2} c_{k\sigma_2}\\ \\

\text{Input}:
&1 × c^\dag_{i,\sigma_1}c_{j,\sigma_1}c^\dag_{k,\sigma_2}c_{k,\sigma_2}\\ \\

\text{Output}:
&-1 × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_2}c_{j,\sigma_1}c_{k,\sigma_2} \\
&+ 1*δ_{j,k}δ_{\sigma_1,\sigma_2} × c^\dag_{i,\sigma_1}c_{k,\sigma_2}
\end{align*}
$$

example 5

$$
\begin{align*}
n_in_jn_kn_l &= \sum_{\sigma_1,\sigma_2,\sigma_3,\sigma_4} c^\dag_{i,\sigma_1} c_{i,\sigma_1} c^\dag_{j,\sigma_2} c_{j,\sigma_2} c^\dag_{k,\sigma_3} c_{k,\sigma_3} c^\dag_{l,\sigma_4} c_{l,\sigma_4}\\ \\

\text{Input}: &c^\dag_{i,\sigma_1}c_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{k,\sigma_3}c^\dag_{l,\sigma_4}c_{l,\sigma_4}
\\ \\

\text{Output}:
&1 × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c^\dag_{l,\sigma_4}c_{i,\sigma_1}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{i,j}δ_{\sigma_1,\sigma_2} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c^\dag_{l,\sigma_4}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{j,k}δ_{\sigma_2,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{l,\sigma_4}c_{i,\sigma_1}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{k,l}δ_{\sigma_3,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{i,\sigma_1}c_{j,\sigma_2}c_{l,\sigma_4} \\
&+ 1*δ_{i,k}δ_{\sigma_1,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{l,\sigma_4}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&+ 1*δ_{j,l}δ_{\sigma_2,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{i,\sigma_1}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{i,l}δ_{\sigma_1,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{i,j}δ_{\sigma_1,\sigma_2}δ_{j,k}δ_{\sigma_2,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{l,\sigma_4}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{i,j}δ_{\sigma_1,\sigma_2}δ_{k,l}δ_{\sigma_3,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c_{j,\sigma_2}c_{l,\sigma_4} \\
&+ 1*δ_{i,j}δ_{\sigma_1,\sigma_2}δ_{j,l}δ_{\sigma_2,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{j,k}δ_{\sigma_2,\sigma_3}δ_{k,l}δ_{\sigma_3,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{i,\sigma_1}c_{l,\sigma_4} \\
&+ 1*δ_{j,k}δ_{\sigma_2,\sigma_3}δ_{i,l}δ_{\sigma_1,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&+ 1*δ_{k,l}δ_{\sigma_3,\sigma_4}δ_{i,k}δ_{\sigma_1,\sigma_3} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{j,\sigma_2}c_{l,\sigma_4} \\
&- 1*δ_{i,k}δ_{\sigma_1,\sigma_3}δ_{j,l}δ_{\sigma_2,\sigma_4} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&+ 1*δ_{i,j}δ_{\sigma_1,\sigma_2}δ_{j,k}δ_{\sigma_2,\sigma_3}δ_{k,l}δ_{\sigma_3,\sigma_4} × c^\dag_{i,\sigma_1}c_{l,\sigma_4}
\\ \\

\text{ValueOutput}:
&1 × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c^\dag_{l,\sigma_4}c_{i,\sigma_1}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_1,\sigma_2}δ_{i,j} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c^\dag_{l,\sigma_4}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_2,\sigma_3}δ_{j,k} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{l,\sigma_4}c_{i,\sigma_1}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_3,\sigma_4}δ_{k,l} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{i,\sigma_1}c_{j,\sigma_2}c_{l,\sigma_4} \\
&+ 1*δ_{\sigma_1,\sigma_3}δ_{i,k} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{l,\sigma_4}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&+ 1*δ_{\sigma_2,\sigma_4}δ_{j,l} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{i,\sigma_1}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_1,\sigma_4}δ_{i,l} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c^\dag_{k,\sigma_3}c_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_1,\sigma_2,\sigma_3}δ_{i,j,k} × c^\dag_{i,\sigma_1}c^\dag_{l,\sigma_4}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_1,\sigma_2}δ_{\sigma_3,\sigma_4}δ_{i,j}δ_{k,l} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c_{j,\sigma_2}c_{l,\sigma_4} \\
&+ 1*δ_{\sigma_1,\sigma_2,\sigma_4}δ_{i,j,l} × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_3}c_{k,\sigma_3}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_2,\sigma_3,\sigma_4}δ_{j,k,l} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{i,\sigma_1}c_{l,\sigma_4} \\
&+ 1*δ_{\sigma_2,\sigma_3}δ_{\sigma_1,\sigma_4}δ_{j,k}δ_{i,l} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&+ 1*δ_{\sigma_3,\sigma_4,\sigma_1}δ_{k,l,i} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{j,\sigma_2}c_{l,\sigma_4} \\
&- 1*δ_{\sigma_1,\sigma_3}δ_{\sigma_2,\sigma_4}δ_{i,k}δ_{j,l} × c^\dag_{i,\sigma_1}c^\dag_{j,\sigma_2}c_{k,\sigma_3}c_{l,\sigma_4} \\
&+ 1*δ_{\sigma_1,\sigma_2,\sigma_3,\sigma_4}δ_{i,j,k,l} × c^\dag_{i,\sigma_1}c_{l,\sigma_4}
\end{align*}
$$

example 6

$$
\begin{align*}
\left(F^\dag F\right)_{ij}\left(F^\dag F\right)_{kl} &= \sum_{\sigma_1,\sigma_2} c^\dag_{i,\sigma_1} c_{j,\sigma_1} c^\dag_{k,\sigma_2} c_{l,\sigma_2}\\ \\

\text{Input}:
&1 × c^\dag_{i,\sigma_1}c_{j,\sigma_1}c^\dag_{k,\sigma_2}c_{l,\sigma_2}\\ \\

\text{Output}:
&-1 × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_2}c_{j,\sigma_1}c_{l,\sigma_2} \\
&+ 1*δ_{j,k}δ_{\sigma_1,\sigma_2} × c^\dag_{i,\sigma_1}c_{l,\sigma_2}\\ \\

\text{ValueOutput}:
&-1 × c^\dag_{i,\sigma_1}c^\dag_{k,\sigma_2}c_{j,\sigma_1}c_{l,\sigma_2} \\
&+ 1*δ_{\sigma_1,\sigma_2}δ_{j,k} × c^\dag_{i,\sigma_1}c_{l,\sigma_2}

\end{align*}
$$
