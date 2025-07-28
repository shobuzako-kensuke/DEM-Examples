# DEM-Examples (日本語版)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16356866.svg)](https://doi.org/10.5281/zenodo.16356866)

[English README](./README.md)

**離散要素法 (DEM) シミュレーション** を実行するためのソースコードです．  
以下の計算が可能です．

- Granular Column Collapse (2D)
- Cylinder Lift (2D)

|Granular Column Collapse | Cylinder Lift |
|:---:|:---:|
|<img src="https://github.com/user-attachments/assets/18cfbd63-cab5-45f0-a84d-abecbd7118e6" alt="granular_column_collapse" width=300>|<img src="https://github.com/user-attachments/assets/18cfbd63-cab5-45f0-a84d-abecbd7118e6" alt="granular_column_collapse" width=300>| 


> [!TIP]
> DEMのお勉強には [Basic_theory_DEM.pdf](./Basic_theory_DEM.pdf) が役に立つかもしれません．


## ⚙️ 動作環境

DEM計算には **Fortran** を利用し，その可視化には **Python** を利用します．  
必要な環境は以下の通りです．

| カテゴリ | 必要な環境 | メモ |
|:---|:---|:---|
|OS |Unix系環境 (Linux, MacOS, WSLなど) | テスト環境：Windows Subsystem for Linux (WSL)|
|コンパイラ| Intel Fortran または gfortran| `ifx` (デフォルト) と `gfortran` が利用可能
|ビルド | `make` | Fortran ファイルのビルドに利用|
|可視化 | `Python` | テスト環境：`Python 3.12.0` (`matplotlib` が必要)|
|動画作成| `ffmpeg` | Pythonファイルで必要|

> [!TIP]
> WSLのインストール方法や，WSL上でFortranやPythonを実行するための環境構築の方法などには以下のQiita記事をご参照ください．  
> [WSL2のインストールとアンインストール](https://qiita.com/zakoken/items/61141df6aeae9e3f8e36)  
> [WSL2によるgfortranとintel fortranの環境構築](https://qiita.com/zakoken/items/2a5e629020ce68f3efe1)  
> [WSL2によるPython3の環境構築](https://qiita.com/zakoken/items/8ddfda7267e7d95b3c46)  

> [!TIP]
> (Unix系環境の場合) `ffmpeg` がインストールされていない場合は, ターミナルを開いて `sudo apt install ffmpeg` を実行してください．


## 🖥️ 使い方

1. 該当ディレクトリに移動 (例：`dem_code/granular_column_collapse_2D/source_code/`)
2. ターミナルから `make` を実行し，Fortranファイルをコンパイル
3. 続けて，`./start_calculation` を実行し，DEM計算を開始
4. 計算終了後, `python main.py` を実行し，動画等を作成

> [!NOTE]
> 各問題設定は，それぞれのディレクトリに置かれた **README.md** に記述されています．


## 🧑‍💻 引用情報

Shobuzako, K. (2025). *DEM-Examples* (Version 1.1.0) [Computer software].  
Zenodo. https://doi.org/10.5281/zenodo.16356866


## 🤝 プロジェクトへの貢献

コードの改善，バグの報告，または新機能の追加等にご協力いただける方は，お気軽にプルリクエストを送信してください．


## 🪪 ライセンス

本プロジェクトは [MIT ライセンス](./LICENSE) に準拠しています．