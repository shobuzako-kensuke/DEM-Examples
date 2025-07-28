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
```math
\begin{align}
m_{i}\frac{d\vec{v}_{i}}{dt}&=\sum_{j}\vec{f}_{ij}+m_{i}\vec{g}~, \\
I_{i}\frac{d\vec{\omega}_{i}}{dt}&=\sum_{j}\left(T_{ij}+M_{ij}\right)~,
\end{align}
```
where $m$ is the mass, $\vec{v}\equiv d\vec{x}/dt$ is the velocity, $t$ is the time, $\vec{g}$ is the gravitational acceleration, $I$ is the moment of inertia ($I=\frac{2}{5}mR^{2}$ for a uniform sphere), $\vec{\omega}$ is the angular velocity centered at $\vec{x}_ {i}$, and $\vec{f}_ {ij}$, $T_ {ij}$, and $M_ {ij}$ are the contact force, torque, and rolling friction moment, respectively, which are defined as
```math
\begin{align}
\vec{f}_{ij}&=\vec{f}_{n_{ij}}+\vec{f}_{t_{ij}}~, \\
T_{ij}&=(\vec{x}_{j}-\vec{x}_{i})\times \vec{f}_{t_{ij}}~, \\
M_{ij}&=-\mu_{r}R_{i}\left|\vec{f}_{n_{ij}}\right|\frac{\vec{\omega}_{i}-\vec{\omega}_{j}}{|\vec{\omega}_{i}-\vec{\omega}_{j}|}~,
\end{align}
```
where $\vec{f}_{n_{ij}}$ is the normal contact force, $\vec{f}_{t_{ij}}$ is the tangential contact force, $\mu_{r}$ is the coefficient of rolling friction, and $R$ is the particle radius.
In the DEM simulation, the contact force is modeled by the Kelvin-Voigt model, expressed as
```math
\begin{align}
\vec{f}_{n_{ij}}&=-k\vec{\delta}_{n_{ij}}-\eta\vec{v}_{n_{ij}}~, \\
\vec{f}_{t_{ij}}&=-k\vec{\delta}_{t_{ij}}-\eta\vec{v}_{t_{ij}}~,
\end{align}
```
where the subscripts $n$ and $t$ denote the normal and tangential directions, respectively, $k$ denotes the spring constant, $\vec{\delta}$ denotes the relative displacement, $\eta$ denotes the damping coefficient, and $\vec{v}_{ij}\equiv \vec{v}_{i}-\vec{v}_{j}$ denotes the relative velocity.
The damping coefficient $\eta$ is associated with the coefficient of restitution $\mathrm{e}$ and given by 
```math
\eta=-2(\ln \mathrm{e})\sqrt{\frac{mk}{\pi^{2}+(\ln \mathrm{e})^{2}}}~.
```

### Other topics
Equations (1) and (2) are solved by the explicit Euler method.
Therefore, the time step $\Delta t$ is limited by
```math
\Delta t < 2\sqrt{\frac{m}{k}}~.
```

The sliding friction is considered as follows 
```math
\begin{align}
    \begin{cases}
        \vec{f}_{t_{ij}}=\vec{f}_{t_{ij}} & (|\vec{f}_{t_{ij}}|\leq\mu_{s}|\vec{f}_{n_{ij}}|) \\
        \vec{f}_{t_{ij}}=-\mu_{s}|\vec{f}_{n_{ij}}|\vec{t}_{ij} & (|\vec{f}_{t_{ij}}|>\mu_{s}|\vec{f}_{n_{ij}}|) \\
    \end{cases}~,
\end{align}
```
where $\mu_{s}$ is the coefficient of sliding friction, $\vec{t}_{ij}$ is the unit tangential vector.
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