# 1-1　　生成AI時代のPythonプログラミング
### 国立遺伝学研究所　情報研究系　森宙史<br><br>

## 本講習の目的
生成AIを利用したPythonプログラミングの方法について学ぶ<br><br>

## 本講習（講義）で使用する環境
大規模言語モデル（LLM）を基盤としたチャット形式の生成AIサービスのモデルのバージョンは
- OpenAI [ChatGPT](https://chatgpt.com/) Plus, GPT-4o
- Anthropic [Claude](https://claude.ai/chat/) 3.5 Sonnet
- Google [Gemini](https://gemini.google.com/) 2.0 Flash
- Hugging Face [HuggingChat](https://huggingface.co/chat/conversation/) (オープンソースのLLM：Llama 3.3やDeepSeek R1等）

になります。

チャット型生成AIとのやり取りには、Google ChromeまたはFirefoxブラウザを使用します。

講師がWebブラウザ等でデモを行う形で講習を行います。

本講習を受講する際には、受講者の上記生成AIサービスのアカウント登録は不要です。

### 生成AIでの応答は再現性は無く、応答が講師-受講者間で異なることも多い点に注意してください<br><br>

## 本講習受講者の背景（アンケートより）
- Pythonプログラミング経験者 72%
- プログラミングに生成AIを利用している方 64%
<br><br>
## 背景
Transformerの論文が発表された2017年からまだ10年も経過していないが、2022年に登場したChatGPTに代表される生成AIは教育・研究開発分野に深く浸透している。生成AIと言ってもAlphaFold3やDNA・タンパク質の言語モデル、画像・音声・映像・テキスト生成AI等様々なものが存在している。それらの中で、特にLLMを基盤としたテキスト生成AIは、
- 要約
- 推論
- 変換
- 拡張

の4種類のタスクが得意であり、研究開発分野でも論文要約、プログラムのバグ取り、言語翻訳、プログラム生成等に広く使われている。<br>
本講習では、この中でプログラミング関連の内容について扱う。<br><br>

## 生成AIを用いたプログラミングの注意点
- コードの中身を理解して間違いが無いかチェックする（結果に責任を持つ）
  - プログラムが間違っていると、自身の責任になる
  - 間違ったプログラムで解析を行った結果で論文を出版すると、あとで大問題になることもある
  - 教育目的のプログラミング課題に生成AIを使うことは禁止されていることも多いので、注意
- 機密情報を入力・アップロードしない
  - 生成AIの学習に使われて情報漏洩の危険性がある
- 限界を知る
  - 再現性の問題
  - 最新情報では無い
  - ハルシネーション
  - 一度で完璧な応答を期待しない
<br><br>

## 用語の定義
- プロンプト: チャット形式の生成AIに送信するテキストメッセージのこと
- 応答: プロンプトに対して生成AIが返答したテキストメッセージのこと
- コンテキスト: 現在のプロジェクト内の過去のプロンプトと応答の履歴のこと。限度はあるが、生成AIは応答を生成する際にコンテキストを考慮する。

## 本講習（講義）で使用する各チャット型生成AIサービスの概要
2025年2月6日時点での解説である点に注意
- [ChatGPT](https://chatgpt.com/)
  - OpenAI社が提供している世界で最も有名なチャット型生成AIサービス。継続的な利用にはアカウント登録が必要。LLMとしてはGPT-4o (GPT-4 Omni) が現在は基本的に使用されている。ただし、ログインしないと、2021年9月までの情報を基に学習したGPT3.5を使用することになる。
  - 無料版のChatGPTにはプログラム生成機能があり、1ヶ月22ドルのChatGPT Plusにはプログラム実行機能も備わっている。
  - GPT-4oでは2024年6月までの情報を基に学習している。本講習では講師は主としてChatGPT Plusをデモとして使用する。
- [Claude](https://claude.ai/chat/)
  - Anthropic社が提供しているチャット型生成AIサービス。利用にはアカウント登録が必要であるが、無料で利用可能。
  - LLMとしてはClaude 3.5 Sonnetが現在は基本的に使用されている。プログラム実行機能は無い。
  - 2024年4月までの情報を基に学習している。
- [Gemini](https://gemini.google.com/)
  - Google社が提供しているチャット型生成AIサービス。利用にはGoogleアカウントが必要であるが、無料で利用可能。
  - 元々はGeminiはLLM自体の名前であり、Bardがチャット型生成AIサービスだったが、2024年初めに両者はBardからGeminiに名前が統一された。
  - LLMとしてはGemini 2.0 Flashを用いており、いつまでの情報を基に学習しているかは公開されていない。
- [HuggingChat](https://huggingface.co/chat/conversation/)
  - Hugging Face社が提供しているチャット型生成AIサービス。利用にはアカウント登録が必要であるが、無料で利用可能。
  - Llama 3.3やDeepSeek R1等の様々なオープンソースのLLMを選択してチャット型生成AIサービスを利用できる。
  - LLM自体の研究開発目的で利用されることが多い。

## Pythonプログラミング利用例
プロンプト<br>
```
RNA-seqのサンプルデータを作成するために、Pythonを用いて、下記のようなcsvを作成してください。
遺伝子ID, サンプル1の遺伝子発現量, サンプル2の発現量
```
応答例<br>
```
import pandas as pd
import numpy as np

# サンプルデータの作成
np.random.seed(42)  # 再現性のためにシードを固定
num_genes = 100  # 遺伝子の数
gene_ids = [f'Gene_{i+1}' for i in range(num_genes)]
sample1_expression = np.random.poisson(lam=20, size=num_genes)  # サンプル1の発現量
sample2_expression = np.random.poisson(lam=25, size=num_genes)  # サンプル2の発現量

# データフレームの作成
df = pd.DataFrame({
    'Gene_ID': gene_ids,
    'Sample_1': sample1_expression,
    'Sample_2': sample2_expression
})

# CSVとして保存
csv_filename = "/mnt/data/rna_seq_sample_data.csv"
df.to_csv(csv_filename, index=False)
```

## デバッグ利用例
プロンプト<br>
```
コードをローカル環境で実行したら、下記のエラーが出ました。なぜでしょうか？
OSError: Cannot save file into a non-existent directory: '/mnt/data'
```
応答例<br>
```
エラーの原因は、ローカル環境で '/mnt/data' というディレクトリが存在しないためです。
```

## プロンプト改善例
ステップごとにしてほしい処理を記述する。<br>
プロンプト<br>
```
RNA-seqのサンプルデータを作成するために、Pythonを用いて、下記のようなcsvを作成してください。
遺伝子ID, サンプル1の遺伝子発現量, サンプル2の発現量
手順:
1. 遺伝子IDのリストを作成（例として100個の遺伝子）
2. 負の二項分布に従うランダムな遺伝子発現量を生成（0から10000の範囲）
3. データフレームの作成
4. CSVとして保存 (ファイル名はrnaseqdata.csv)
```
他にもChatGPTやGemini等でのプロンプトエンジニアリングとして有名なテクニックとしては、<br>
創造的な答えが欲しい場合
```
temperatureを2に設定して答えてください。
```
保守的な答えが欲しい場合
```
temperatureを0に設定して答えてください。
```
という一行を追加すると良いが、プログラミングではほぼ使わない。
<br><br>
## AIペアプログラミングツール
Pythonプログラムを頻繁に書く必要がある場合は、ソースコードエディタと連携したAIペアプログラミングツールが有用である。<br>
その代表例は、ソースコードエディタである
[Visual Studio Code](https://code.visualstudio.com/)とAIペアプログラミングツール[GitHub Copilot](https://github.com/features/copilot)の組み合わせである。<br>
GitHub Copilotは2024年12月中旬以降、機能的な制限はあるものの、[無料での利用が可能](https://github.blog/jp/2024-12-19-github-copilot-in-vscode-free/)
となり、爆発的に利用者が増えている。<br>
GitHub Copilotの利用にはGitHubアカウントが必要である。<br>
VSCode上でExtensionsとしてGitHub Copilotを利用することで、コードの補完やチャットでのプログラム生成・デバッグ等の機能をVSCode内で完結して使用でき、日々のコーディングの効率が向上するため、プログラムを書く頻度が高い方にはお勧めである。<br>
