# konpota

コンポタを作り、最強のコンポタ師を目指すゲームです。

## 開発環境

- Godot: `4.7.2.stable.official.ed1daf0bf`
- レンダラー: Compatibility
- 3D物理エンジン: Jolt Physics
- バージョン管理: Git / GitHub
- 対応開発環境
  - macOS（Apple Silicon）
  - Windows

> プロジェクトの互換性を保つため、原則として上記と同じGodotバージョンを使用してください。

## 開発の始め方

### 1. リポジトリをクローンする

```bash
git clone git@github.com:ki-mutaku/konpota.git
cd konpota
```

HTTPSを使用する場合:

```bash
git clone https://github.com/ki-mutaku/konpota.git
cd konpota
```

### 2. Godotでプロジェクトを開く

1. Godot Project Managerを起動する
2. **Import**を選択する
3. クローンしたディレクトリ内の`project.godot`を選択する
4. **Import & Edit**を選択する

コマンドラインから開く場合:

```bash
godot --editor --path .
```

初回起動時はアセットのインポートに時間がかかる場合があります。

## Git運用

`main`へ直接プッシュせず、作業用ブランチを作成してください。

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

GitHubでPull Requestを作成し、レビュー後に`main`へマージします。

### ブランチ名

| 接頭辞     | 用途         | 例                        |
| ---------- | ------------ | ------------------------- |
| `feature/` | 新機能       | `feature/player-movement` |
| `fix/`     | バグ修正     | `fix/player-collision`    |
| `docs/`    | ドキュメント | `docs/update-readme`      |

## Godotでの共同開発ルール

### シーンとリソースの同時編集を避ける

Godotのシーン（`.tscn`）やリソース（`.tres`）はテキスト形式ですが、複数人が同時に編集するとコンフリクトが発生することがあります。

- 担当するシーンを分ける
- 大きなシーンは小さなシーンに分割する
- 共通要素は別シーンやリソースとして切り出す
- 作業開始前に`main`の最新状態を取り込む

### Godot関連ファイルをまとめてコミットする

スクリプト、シーン、リソース、元アセットに加えて、Godotが作成した`.uid`や`.import`ファイルがある場合は、関連する変更をまとめてコミットしてください。

主な管理対象:

```text
*.gd       GDScript
*.tscn     シーン
*.tres     リソース
*.godot    プロジェクト設定
*.uid      リソースUID
*.import   インポート設定
```

### プロジェクト設定はGodot Editorから変更する

`project.godot`は、原則としてGodot Editorの **Project > Project Settings** から変更してください。変更後は意図しない設定差分が含まれていないか確認します。

## 大容量アセット

画像・音声・動画などの大容量ファイルを追加する場合は、事前にチームへ共有してください。

現在、このリポジトリではGit LFSの対象ファイルは設定されていません。Git LFSを導入する場合は、対象の拡張子を`.gitattributes`に追加してからアセットをコミットします。

## APIキー・秘密情報

APIキー、アクセストークン、パスワードなどをGitHubへプッシュしないでください。

秘密情報を保存するファイル（例: `.env`）は`.gitignore`へ追加します。誤って公開した場合は、ファイルを削除するだけでなく、すぐにチームへ共有してキーを無効化してください。

## Team

| Name       | Role |
| ---------- | ---- |
| たくや     | TBD  |
| かなみ     | TBD  |
| けんたろう | TBD  |

## その他

開発ルールは、プロジェクトの進行に合わせて随時更新します。
