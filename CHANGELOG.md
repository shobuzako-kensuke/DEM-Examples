# CHANGELOG (更新履歴)

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),  
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).  

<!--## 
[Unreleased]

### Added
- `dem_code/cylinder_lift/`
-->

## [1.1.0] - 2025-07-29

### Added
- **Cylinder Lift プログラムを追加**
- readmeの日本語版を作成 (README_ja.md)
- makeにgfortranを追加
- 各テストのreadmeを追加し，各テストの簡単な説明を追加
- 出力に `eta` を追加（これに伴い，Pythonファイルも変更）
- Gate開放のしきい値 `U_threshold` をパラメータとして追加

### Changed
- readmeにifxとgfortranで計算できることを追記
- readmeのIntel MKLの記述を削除
- main.f90のコメントアウトを揃えた
- input.f90に `d0` を付けた
- out_progress.f90の `openedg` となる問題を修正した
- Gateが開かない場合があるので，しきい値を低くした
- ターミナルに出力する文字列を大文字始まりとした
- 諸々のcitationを `v1.1.0` とした
- Python codeを整理した

### Removed
- cal_recalculation.f90


## [1.0.0] - 2025-07-23

### Added
- README.md
- `dem_code/granular_column_collapse/`
- Basic_theory_DEM_ver1.pdf
- License
- CHANGELOG.md
- CITATION.cff