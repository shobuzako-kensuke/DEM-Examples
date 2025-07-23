# granular_column_collapse_2D

|Granular Column Collapse (2D) | Initial setting (an example) |
|:---:|:---:|
|<img src="https://github.com/user-attachments/assets/18cfbd63-cab5-45f0-a84d-abecbd7118e6" alt="granular_column_collapse" width=250>|<img src="https://github.com/user-attachments/assets/a8586839-d23b-4bf2-b056-c5f4cf1dba70" alt="initial_setting_granular_column_collapse_2D" width=250>|

## 📑 Fundamental files

|File name|Description|
|:---|:---|
|`input.f90`|Defines all simulation parameters (see `input.f90` for details).|
|`main.f90`|The main program for the DEM simulation, which calls Fortran subroutines.|
|`main.py`|Used for visualizing simulation results.|
|`Makefile`|Compiles the Fortran files.|
|`initialize_local.py`|Resets this local directory to its initial, distributed state.|

## 📉 Results
- The `output` directory is created when the simulation begins, and it stores simulation results as binary files.
- The `fig` directory is created after `main.py` is run, and it stores simulation figures.