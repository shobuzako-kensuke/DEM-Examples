# DEM-Examples

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16356866.svg)](https://doi.org/10.5281/zenodo.16356866)

[日本語版はこちら](./README_ja.md)

This open-source code provides **Discrete Element Method (DEM) simulations**, including the following examples:

- Granular Column Collapse (2D)
- Cylinder Lift (2D)

|Granular Column Collapse | Cylinder Lift |
|:---:|:---:|
|<img src="https://github.com/user-attachments/assets/cb0b81a5-61bb-4860-b0f8-f94014b2cc68" alt="granular_column_collapse" width=300>|<img src="https://github.com/user-attachments/assets/fd3fed95-f3f8-4f3f-941c-7b6204d75d1b" alt="cylinder_lift" width=300>| 

> [!TIP]
> For DEM study,  [Basic_theory_DEM.pdf](./Basic_theory_DEM.pdf) might be a helpful resource.


## ⚙️ Requirements

This code is written in **Fortran** (for DEM calculations) and **Python** (for visualization).

| Category | Requirement | Notes |
|:---|:---|:---|
|Operating System |Unix-like environment | Tested on Windows Subsystem for Linux (WSL)|
|Compiler | Intel Fortran / gfortran| Tested with `ifx` (default) and `gfortran`
|Build Tool | `make` | For building Fortran files|
|Visualization | `Python` | Tested with `Python 3.12.0` and requires `matplotlib`|
|Movie Generation| `ffmpeg` | Required for Python scripts to generate movies|

> [!TIP]
> If `ffmpeg` is not installed, run `sudo apt install ffmpeg` .


## 🖥️ Usage

1. Navigate to the simulation directory (e.g., `dem_code/granular_column_collapse_2D/source_code/`)
2. Run `make` to build the Fortran programs.
3. Run `./start_calculation` to start the simulation.
4. After the simulation finishes, run `python main.py` to generate figures.

> [!NOTE]
> Each problem statement is described in the **README.md** in its directory.


## 🧑‍💻 Citation

Shobuzako, K. (2025). *DEM-Examples* (Version 1.1.0) [Computer software].  
Zenodo. https://doi.org/10.5281/zenodo.16356866


## 🤝 Contributing
Contributions are welcome!  
If you would like to improve the code, report a bug, or add a new feature, feel free to submit a pull request.


## 🪪 License

This project is licensed under [the MIT License](./LICENSE) .
