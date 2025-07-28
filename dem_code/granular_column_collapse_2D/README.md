# granular_column_collapse_2D

|Granular Column Collapse (2D) | Initial setting (an example) |
|:---:|:---:|
|<img src="https://github.com/user-attachments/assets/18cfbd63-cab5-45f0-a84d-abecbd7118e6" alt="granular_column_collapse" width=300>|<img src="https://github.com/user-attachments/assets/a8586839-d23b-4bf2-b056-c5f4cf1dba70" alt="initial_setting_granular_column_collapse_2D" width=300>|

## 🚩Problem Statement

### Overview
1. Particles are set at the top left corner.
2. They free fall, resulting in the formation of a stable configuration.
3. If the maximum particle speed `U_max` exceeds `U_threshold`, the gate begins to open at a fixed lift speed `v_lift`.
4. Particles become stationary at the angle of repose.

### Governing Equations
The governing equations of a DEM particle $i$ are expressed as:
$$
\begin{align}
m_{i}\frac{d\bm{v}_{i}}{dt}&=\sum_{j}\bm{f}_{ij}+m_{i}\bm{g}~, \\
I_{i}\frac{d\bm{\omega}_{i}}{dt}&=\sum_{j}\left(\bm{T}_{ij}+\bm{M}_{ij}\right)~,
\end{align}
$$
where $m$ is the mass, $\bm{v}\equiv dx/dt$ is the velocity, $t$ is the time, $g$ is the gravitational acceleration, $I$ is the moment of inertia ($I=\frac{2}{5}mR^{2}$ for a uniform sphere), $\omega$ is the angular velocity centered at $\bm{x}_{i}$, and $\bm{f}_{ij}$, $\bm{T}_{ij}$, and $\bm{M}_{ij}$ are the contact force, torque, and rolling friction moment, respectively, which are defined as
$$
\begin{align}
\bm{f}_{ij}&=\bm{f}_{n_{ij}}+\bm{f}_{t_{ij}}~, \\
\bm{T}_{ij}&=(\bm{x}_{j}-\bm{x}_{i})\times \bm{f}_{t_{ij}}~, \\
\bm{M}_{ij}&=-\mu_{r}R_{i}\left|\bm{f}_{n_{ij}}\right|\frac{\bm{\omega}_{i}-\bm{\omega}_{j}}{|\bm{\omega}_{i}-\bm{\omega}_{j}|}~,
\end{align}
$$
where $\bm{f}_{n_{ij}}$ is the normal contact force, $\bm{f}_{t_{ij}}$ is the tangential contact force, $\mu_{r}$ is the coefficient of rolling friction, and $\bm{R}$ is the particle radius.
In the DEM simulation, the contact force is modeled by the Kelvin-Voigt model, expressed as
$$
\begin{align}
\bm{f}_{n_{ij}}&=-k\bm{\delta}_{n_{ij}}-\eta\bm{v}_{n_{ij}}~, \\
\bm{f}_{t_{ij}}&=-k\bm{\delta}_{t_{ij}}-\eta\bm{v}_{t_{ij}}~,
\end{align}
$$
where the subscripts $n$ and $t$ denote the normal and tangential directions, respectively, $k$ denotes the spring constant, $\bm{\delta}$ denotes the relative displacement, $\eta$ denotes the damping coefficient, and $\bm{v}_{ij}\equiv \bm{v}_{i}-\bm{v}_{j}$ denotes the relative velocity.
The damping coefficient $\eta$ is associated with the coefficient of restitution $\mathrm{e}$ and given by 
$$
\eta=-2(\ln \mathrm{e})\sqrt{\frac{mk}{\pi^{2}+(\ln \mathrm{e})^{2}}}~.
$$

### Other topics
Equations (1) and (2) are solved by the explicit Euler method.
Therefore, the time step $\Delta t$ is limited by
$$
\Delta t < 2\sqrt{\frac{m}{k}}~.
$$  

The sliding friction is considered as follows 
$$
\begin{align}
    \begin{cases}
        \bm{f}_{t_{ij}}=\bm{f}_{t_{ij}} & (|\bm{f}_{t_{ij}}|\leq\mu_{s}|\bm{f}_{n_{ij}}|) \\
        \bm{f}_{t_{ij}}=-\mu_{s}|\bm{f}_{n_{ij}}|\bm{t}_{ij} & (|\bm{f}_{t_{ij}}|>\mu_{s}|\bm{f}_{n_{ij}}|) \\
    \end{cases}~,
\end{align}
$$
where $\mu_{s}$ is the coefficient of sliding friction, $\bm{t}_{ij}$ is the unit tangential vector.
When contacting with a rigid wall, $\mu_{s}$ is replaced by the coefficient of particle-wall friction $\mu_{w}$.

> [!TIP]
> Further details of the DEM theory are described in [Basic_theory_DEM.pdf](../../Basic_theory_DEM.pdf).

## 📑 Fundamental Files

|File name|Description|
|:---|:---|
|`input.f90`|Defines all simulation parameters (see `input.f90` for details).|
|`main.f90`|The main program for the DEM simulation, which calls Fortran subroutines.|
|`main.py`|Used for visualizing simulation results.|
|`Makefile`|Compiles the Fortran files.|
|`initialize_local.py`|Resets this local directory to its initial, distributed state.|

## 📁 Simulation Results Storage

- **Simulation results** are saved as binary files in the `output` directory, which is created when the simulation begins.
- **Simulation figures** are saved in the `fig` directory, which is created after `main.py` is run.