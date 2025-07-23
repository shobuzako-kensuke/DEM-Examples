# DEM-Examples

<!--
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15709255.svg)](https://doi.org/10.5281/zenodo.15709255)
-->

This is an open-source code using Discrete Element Method (DEM), providing
the following simulation examples:
1. Granular Column Collapse

|タイトル|
|:---:|
|asdf|


## ⚙️ Requirements

- Unix-like environment (Linux, macOS, or WSL on Windows)
- [Intel Fortran compiler](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html#gs.n7d5f5) (using `ifx`)
- Intel MKL (Math Kernel Library) for linear algebra routines
- `make` utility for building Fortran files
- Python with common libraries (e.g., `matplotlib`, `scipy`)
- `ffmpeg` for movie generation


## 🖥️ Usage

The following example shows how to simulate the 2D Taylor-Green vortex:

1. Clone or download this repository to your computer.
2. Navigate to `sph_code/benchmarks/2d-fixed-wall/source_code/` .
3. Run `make` to build the program.
4. Run `./start_calculation` to start the simulation.
5. After the simulation finishes, run `TG_main.py` to generate figures.


> [!NOTE]
> To simulate other cases, please refer to the [User Manual (Japanese)](./manual.pdf) and set the appropriate parameters.


## 🧑‍💻 Citation

If you use this simulator in your research, please cite the following two references:

#### 📄 Journal Article  
Shobuzako, K., Yoshida, S., Kawada, Y., Nakashima, R., Fujioka, S., & Asai, M. (2025).  
A generalized smoothed particle hydrodynamics method based on the moving least squares method and its discretization error estimation.  
*Results in Applied Mathematics*, 26, 100594. [https://doi.org/10.1016/j.rinam.2025.100594](https://doi.org/10.1016/j.rinam.2025.100594)

#### 📦 Software  
Shobuzako, K. (2025). *LS-SPH-Fluid-Simulator* (Version 1.0.0) [Computer software].  
Zenodo. https://doi.org/10.5281/zenodo.15709255


## 📖 User Manual (Japanese Only)

Please refer to the [LS-SPH Fluid Simulator User Manual](./manual.pdf), which is written in Japanese.  

An English version is not currently available.  
Please consider using translation tools such as AI.

## 🤝 Contributing
Contributions are welcome!  
If you'd like to improve the code, report a bug, or add a new feature, feel free to submit a pull request.

Please see [CONTRIBUTORS.md](./CONTRIBUTORS.md) for contributor information.

## 🔍 References
<a id="ref1">[1]</a>　
Shobuzako, K., Yoshida, S., Kawada, Y., Nakashima, R., Fujioka, S., & Asai, M. (2025).  
A generalized smoothed particle hydrodynamics method based on the moving least squares method and its discretization error estimation.  
*Results in Applied Mathematics*, 26, 100594. [https://doi.org/10.1016/j.rinam.2025.100594](https://doi.org/10.1016/j.rinam.2025.100594)



## 🪪 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) for details.
