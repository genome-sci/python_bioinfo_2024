# 2024年度先進ゲノム支援(PAGS)、DDBJ合同 中級者情報解析講習会

## 概要
- 日時：
- 1日目：2025年2月6日（木）12：30 ～ 18:00
- 2日目：2025年2月7日（金） 9：20 〜 16:00
- 会場：
    オンライン開催(Zoom webinar)

## スケジュール（予定）：講習内容とスケジュールは多少変更になる場合があります。
【2月6日：1日目】
- 12：30～12：40　講習会説明
- 12：40～13：50　[1-1 生成AI時代のPythonプログラミング　遺伝研　森宙史](https://github.com/genome-sci/python_bioinfo_2024/tree/main/1-1)
- 14：00～15：30　[1-2 Jupyter notebook、Biopythonを用いた処理　遺伝研　谷澤靖洋](https://github.com/genome-sci/python_bioinfo_2024/tree/main/1-2)
- 15：40～16：10　[1-3 Numpy　遺伝研　東光一](https://github.com/genome-sci/python_bioinfo_2024/tree/main/1-3)
- 16：10～17：10　[1-4 表形式ファイルの処理（Pandas）　遺伝研　坂本美佳](https://github.com/genome-sci/python_bioinfo_2024/tree/main/1-4)
- 17：10～18：00　質疑応答

【2月7日：2日目】
- 9：20〜10：50　[2-1 視覚化 (matplotlib, seaborn)　遺伝研　黒川真臣](https://github.com/genome-sci/python_bioinfo_2024/tree/main/2-1)
- 11：00〜12：30　[2-2 Pythonを用いたシングルセルRNA-seq解析（基礎）　遺伝研　東光一](https://github.com/genome-sci/python_bioinfo_2024/tree/main/2-2)
- 12：30〜13：20　昼食休憩
- 13：20〜15：00　[2-3 Pythonを用いたシングルセルRNA-seq解析（発展）　遺伝研　東光一](https://github.com/genome-sci/python_bioinfo_2024/tree/main/2-2)
- 15：00～16：00　質疑応答


## プログラム実行環境の準備
本講習会では Linux/Mac 環境で miniforge を使って必要なライブラリをインストールして実行することを想定しています。  
Windows をご使用の場合、WSL2 を使った Linux 環境か Linux の仮想マシンで実行環境を用意してください。

### miniforge 仮想環境へのインストール
miniforge は[公式ウェブサイト](https://github.com/conda-forge/miniforge)の手順等に従ってインストールしてください。miniforge のかわりに Anaconda、miniconda、micromamba 等を使っても構いません。

- 仮想環境の作成
`pags2024` という名称で仮想環境を作成し、Python 3.11 をインストールします。Anaconda/miniconda を使用している場合には `mamba` コマンドの代わりに `conda` コマンドを使用してください。
```
mamba create -n pags2024 python=3.11
# 仮想環境の有効化
mamba activate pags2024
```
仮想環境から抜けるには `mamba deactivate` を実行します。

- モジュールのインストール
仮想環境 `pags2024` を有効化した状態で行なってください。
```
mamba install -c conda-forge jupyter
mamba install -c bioconda biopython bcbio-gff
mamba install -c conda-forge matplotlib-venn
mamba install -c conda-forge scanpy python-igraph leidenalg
mamba install -c conda-forge scvi-tools
mamba install -c bioconda scvelo
mamba install -c conda-forge -c bioconda cellrank
mamba install -c conda-forge scikit-misc
```

- Jupyter notebookの起動
```
# ソースコード取得
git clone https://github.com/genome-sci/python_bioinfo_2024.git

# ディレクトリに移動
cd python_bioinfo_2024

# jupyter notebook起動
jupyter notebook
```
起動すると自動でWebブラウザが立ち上がります。
Webブラウザが立ち上がらない場合には、http://localhost:8888/ にアクセスしてください。

### Docker を利用する場合
```
# ソースコード取得
git clone https://github.com/genome-sci/python_bioinfo_2024.git

# ディレクトリに移動
cd python_bioinfo_2024

# コンテナイメージをビルド (pags:2024という名称のイメージを作成します)
docker build -t pags:2024 .

# jupyter notebook 起動
docker run -it --rm -v $PWD:/python_bioinfo_2024 -p 8888:8888 pags:2024

# コンテナ内ででコマンドを実行する
docker run -it --rm -v $PWD:/python_bioinfo_2024 -p 8888:8888 pags:2024 bash
```

Jupyter notebook を開くには起動後、ウェブブラウザから http://localhost:8888 を開いてください。
