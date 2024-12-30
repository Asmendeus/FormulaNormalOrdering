example 1:

$$
\begin{align*}
\text{Input}: 
&0.25*\sigma^{z}_{\uparrow\uparrow} \sigma^{z}_{\uparrow\uparrow} × c^\dag_{i,\uparrow}c_{i,\uparrow}c^\dag_{j,\uparrow}c_{j,\uparrow}\\ \\

\text{Output}: 
&-0.25*\sigma^{z}_{\uparrow\uparrow} \sigma^{z}_{\uparrow\uparrow} × c^\dag_{i,\uparrow}c^\dag_{j,\uparrow}c_{i,\uparrow}c_{j,\uparrow} + 0.25*\sigma^{z}_{\uparrow\uparrow} \sigma^{z}_{\uparrow\uparrow}*δ_{i,j}δ_{\uparrow,\uparrow} × c^\dag_{i,\uparrow}c_{j,\uparrow}\\ \\

\text{ValueOutput}:
&-0.25 × c^\dag_{i,\uparrow}c^\dag_{j,\uparrow}c_{i,\uparrow}c_{j,\uparrow} + 0.25*δ_{i,j} × c^\dag_{i,\uparrow}c_{j,\uparrow}
\end{align*}
$$

example 2:

$$
\begin{align*}
n_in_jn_k &= \sum_{\sigma_1,\sigma_2,\sigma_3} c^\dag_{i,\sigma_1} c_{i,\sigma_1} c^\dag_{j,\sigma_2} c_{j,\sigma_2} c^\dag_{k,\sigma_3} c_{k,\sigma_3}\\ \\

\text{Input}: n_in_jn_k &= 
1 × c^\dag_{i,\sigma_1} c_{i,\sigma_1} c^\dag_{j,\sigma_2} c_{j,\sigma_2} c^\dag_{k,\sigma_3} c_{k,\sigma_3} \\ \\

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
