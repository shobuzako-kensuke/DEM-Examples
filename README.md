# DEM-Examples

<!--
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15709255.svg)](https://doi.org/10.5281/zenodo.15709255)
-->

This open-source code provides **Discrete Element Method (DEM) simulations**, including the following examples:

- Granular Column Collapse (2D)
- Cylinder Lift (2D)

|Granular Column Collapse | Cylinder Lift |
|:---:|:---:|
|![Granular_column_collapse](https://github.com/user-attachments/assets/18cfbd63-cab5-45f0-a84d-abecbd7118e6) | ![Granular_column_collapse](https://github.com/user-attachments/assets/18cfbd63-cab5-45f0-a84d-abecbd7118e6)|



## ⚙️ Requirements

This code is written in **Fortran** (for DEM calculations) and **Python** (for visualization).

| Category | Requirement | Notes |
|:---|:---|:---|
|Operating System |Unix-like environment | Tested on Windows Subsystem for Linux (WSL)|
|Compiler | [Intel Fortran compiler](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html#gs.n7d5f5)| Uses the `ifx` command and Intel MKL (Math Kernel Library)
|Build Tool | `make` | For building Fortran files|
|Visualization | `Python` | Tested with `Python 3.12.0` and requires `matplotlib`|
|Movie Generation| `ffmpeg` | Required for Python scripts to generate movies|

> [!NOTE]
> If `ffmpeg` is not installed, run `sudo apt install ffmpeg` for WSL.


## 🖥️ Usage

1. Navigate to the simulation directory (e.g., `dem_code/granular_column_collapse_2D`)
2. Run `make` to build the Fortran programs.
3. Run `./start_calculation` to start the simulation.
4. After the simulation finishes, run `python main.py` to generate figures.


## 🧑‍💻 Citation

Shobuzako, K. (2025). *DEM-Examples* (Version 1.0.0) [Computer software].  
Zenodo. https://doi.org/10.5281/zenodo.15709255


## 🤝 Contributing
Contributions are welcome!  
If you would like to improve the code, report a bug, or add a new feature, feel free to submit a pull request.


## 🪪 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) for details.
