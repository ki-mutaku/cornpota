# cornpota

コンポタを作り最強のコンポタ師を目指すゲーム

## 開発環境

- Unity: `6.3 LTS`
- Template: Universal 2D (URP)
- バージョン管理: Git / GitHub
- Git LFS: 使用
- 対応開発環境
  - macOS (Apple Silicon)
  - Windows

## 開発の始め方

### 1. リポジトリをClone

```bash
git clone <repository-url>
cd cornpota
```

### 2. Git LFSをセットアップ

Git LFSがインストールされていない場合はインストールしてください。

macOS (Homebrew):

```bash
brew install git-lfs
git lfs install
```

Windows:

Git for Windows / Git LFSをインストールしたうえで、PowerShell等のターミナルを開き、

```bash
git lfs install
```

を実行してください。

その後、

```bash
git lfs pull
```

を実行します。

### 3. Unityで開く

Unity HubからCloneした `cornpota` フォルダを開いてください。

⚠️ **必ずUnity Editor `6000.3.24f1` を使用してください。**

---

## 🌿 Git運用

基本的に `main` へ直接Pushせず、作業用ブランチを作成します。

例:

```bash
git switch main
git pull

git switch -c feature/player-movement
```

作業後:

```bash
git add .
git commit -m "Add player movement"
git push -u origin feature/player-movement
```

GitHubでPull Requestを作成し、確認後 `main` にMergeします。

### ブランチ名

```text
feature/xxx  新機能
fix/xxx      バグ修正
docs/xxx     ドキュメント
```

例:

```text
feature/player-movement
feature/title-screen
fix/player-collision
```

---

## ⚠️ Unityでの共同開発ルール

### `.meta` ファイルを削除しない

Unityが生成する `.meta` ファイルもGitで管理します。

```text
Player.png
Player.png.meta
```

基本的にセットで扱ってください。

### Sceneの同時編集に注意

UnityのScene (`.unity`) は複数人で同時に編集するとコンフリクトが発生しやすいため、

- 担当するSceneを分ける
- Prefabを活用する
- 作業開始前に `main` の最新状態を取得する

ことを意識してください。

### 作業開始前

```bash
git switch main
git pull
```

最新状態からブランチを作成してください。

---

## 📦 Git LFS

画像・音声などの大きなバイナリファイルはGit LFSで管理します。

LFS対象ファイルは `.gitattributes` に定義されています。

通常通り、

```bash
git add .
git commit
git push
```

すれば、LFS対象ファイルは自動的にGit LFSで管理されます。

---

## 🔐 APIキー・秘密情報

APIキー、アクセストークン、パスワードなどをGitHubにPushしないでください。

```text
❌ API Key
❌ Access Token
❌ Password
❌ Secret Key
```

秘密情報を保存するファイル(例：`.env`等)は `.gitignore` の対象にします。

一度公開してしまった秘密情報は、GitHubからファイルを削除するだけでは不十分です。

誤ってPushした場合は、すぐにチームへ共有してキーを無効化してください。

---

## 👥 Team

| Name | Role |
|---|---|
| TBD | TBD |
| TBD | TBD |
| TBD | TBD |

---

## 📝 その他

開発ルールは必要に応じて随時更新します。
