<p align="center">
  <a href="https://bmo.ahas.io/ja/"><img src="https://bmo.ahas.io/icon.svg" alt="BMO" width="120" height="120"></a>
</p>

<h1 align="center">BMO</h1>

<p align="center">自分のマシンで動く自分だけの AI チーム: 一人ひとりに BMO、組織とそのエージェントまで。</p>

<p align="center">
  <a href="https://bmo.ahas.io/ja/"><img alt="Website" src="https://img.shields.io/badge/website-bmo.ahas.io-6366f1?style=flat-square"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-22c55e?style=flat-square"></a>
  <a href="https://bmo.ahas.io/ja/releases/"><img alt="Version" src="https://img.shields.io/github/v/tag/ahas/bmo?include_prereleases&sort=semver&label=version&color=0ea5e9&style=flat-square"></a>
  <img alt="Rust" src="https://img.shields.io/badge/Rust-servers-b7410e?style=flat-square&logo=rust&logoColor=white">
  <img alt="Nuxt" src="https://img.shields.io/badge/Nuxt-console-00dc82?style=flat-square&logo=nuxt&logoColor=white">
  <img alt="Languages" src="https://img.shields.io/badge/i18n-ko%20%C2%B7%20en%20%C2%B7%20ja%20%C2%B7%20zh-f59e0b?style=flat-square">
</p>

<p align="center">
  <a href="https://bmo.ahas.io/ja/">ウェブサイト</a> · <a href="https://bmo.ahas.io/ja/guide/">ガイドブック</a> · <a href="https://bmo.ahas.io/ja/api/">API リファレンス</a> · <a href="https://bmo.ahas.io/ja/releases/">リリースノート</a>
</p>

<p align="center"><a href="README.md">English</a> | <a href="README.ko.md">한국어</a> | <b>日本語</b> | <a href="README.zh-CN.md">简体中文</a></p>

BMO システムはリポジトリの集まりで、ユニット1つにつきリポジトリ1つが、このフォルダの中に並んでいます。すべてのユニットが従う形は `STRUCTURE.md` に、各ユニットの役割はそのユニット自身の README と文書にあります。このリポジトリが追跡するのは構造、この一覧、インストールのランブックとそのプリセット、独立したスクリプト1本だけです。ユニットはここでは追跡せず、それぞれ自分の名前でほかのユニットの隣にクローンします。

## インストール

BMO は人の手ではなく、コーディングエージェントがインストールします。BMO を動かすマシンで Claude Code か Codex を開き、次の一行を渡してください。

```
https://bmo.ahas.io/install.md を読んで、このマシンに BMO をインストールして。
```

エージェントは `INSTALL.md` に従います。`presets.toml` にある `personal`(個人)、`team`(チーム)、`operator`(運用者)のどれにするかを尋ね、あなたにしかないものだけを尋ね、終わるとコンソールのアドレスを伝えます。

## フォルダ構成

| フォルダ | 中身 |
|---|---|
| `base/` | 基盤ライブラリ。ほかのユニットが取り込めるのはこの種類だけ |
| `resources/` | 中身だけを置き、読む側が探す場所に配置する。何も実行しない |
| `services/` | サービスごとに1フォルダ。プラットフォーム自身の仕組みもここにある |
| `tools/` | ツールのための自由な場所。ツールごとに1フォルダで、ほかのユニットを変えずに追加・削除できる |

## ユニット

| フォルダ | リポジトリ | 役割 |
|---|---|---|
| `base/chat` | [bmo-chat](https://github.com/ahas/bmo-chat) | プロバイダーとレシーバーの間のチャットプロトコルとそのクライアント |
| `base/text` | [bmo-text](https://github.com/ahas/bmo-text) | ルーム、コンソール、アーカイブが読むとおりに読み書きする Markdown とテキスト |
| `base/ui` | [bmo-ui](https://github.com/ahas/bmo-ui) | コンソールの Nuxt レイヤー：すべての画面を形づくるトークン、コンポーネント、振る舞い |
| `resources/persona` | [bmo-persona](https://github.com/ahas/bmo-persona) | チャットエージェントのペルソナ層と設定資料 |
| `resources/skills` | [bmo-skills](https://github.com/ahas/bmo-skills) | ワーカーに渡すスキルと、それを配置する道具 |
| `services/agency` | [bmo-agency](https://github.com/ahas/bmo-agency) | エージェントセッションの供給、配置、進行、終了と協働者プール |
| `services/arbiter` | [bmo-arbiter](https://github.com/ahas/bmo-arbiter) | エンジンがカードを共有する GPU ノードのカード調停役 |
| `services/artifact` | [bmo-artifact](https://github.com/ahas/bmo-artifact) | 文書の保管、検索、共有 |
| `services/brain` | [bmo-brain](https://github.com/ahas/bmo-brain) | ミドルウェアとしての記憶：行、ノート、監視、リマインダー、参照テキスト |
| `services/cache-siren` | [bmo-cache-siren](https://github.com/ahas/bmo-cache-siren) | プロンプトキャッシュのヒットと新規トークンのリアルタイム監視 |
| `services/cache-warmer` | [bmo-cache-warmer](https://github.com/ahas/bmo-cache-warmer) | プロンプトキャッシュを温めておくスケジューラー |
| `services/calendar` | [bmo-calendar](https://github.com/ahas/bmo-calendar) | カレンダー、予定、アラーム、予約 |
| `services/cli` | [bmo-cli](https://github.com/ahas/bmo-cli) | 各ユニットのコマンドを見つける入口コマンド |
| `services/discord` | [bmo-discord](https://github.com/ahas/bmo-discord) | Discord チャットプロバイダー |
| `services/drive` | [bmo-drive](https://github.com/ahas/bmo-drive) | ドライブ、オブジェクトストレージ、ノードのボリュームを横断するファイルビューア |
| `services/explorer` | [bmo-explorer](https://github.com/ahas/bmo-explorer) | 上流としての Web 読み取り：検索、ページ、プレビュー、画像 |
| `services/eye` | [bmo-eye](https://github.com/ahas/bmo-eye) | 見ること：ビジョンモデルが読む画像と動画 |
| `services/face` | [bmo-face](https://github.com/ahas/bmo-face) | ケースの画面に映る顔、そのエディタとサーバー |
| `services/gate` | [bmo-gate](https://github.com/ahas/bmo-gate) | ターンのゲート段階：参照、翻訳、記録 |
| `services/job` | [bmo-job](https://github.com/ahas/bmo-job) | ミドルウェアとしての TODO：項目、キュー、リース、質問、購読 |
| `services/mail` | [bmo-mail](https://github.com/ahas/bmo-mail) | 各アカウントのメールボックス上のメールサービス |
| `services/node` | [bmo-node](https://github.com/ahas/bmo-node) | マシン一覧とハードウェアモニター |
| `services/note` | [bmo-note](https://github.com/ahas/bmo-note) | BlockSuite エディタのノート、AFFiNE のフォーク |
| `services/pocket` | [bmo-pocket](https://github.com/ahas/bmo-pocket) | ツールホスト、ツール一覧、ツール SDK |
| `services/receiver` | [bmo-receiver](https://github.com/ahas/bmo-receiver) | チャットレシーバー：ルーム、ルール、会話ウィンドウ、ターン、起動 |
| `services/remote` | [bmo-remote](https://github.com/ahas/bmo-remote) | コンソールの裏にあるターミナルセッションとリモートデスクトップ |
| `services/research` | [bmo-research](https://github.com/ahas/bmo-research) | 文書として残るリサーチ |
| `services/review` | [bmo-review](https://github.com/ahas/bmo-review) | 登録されたチェックアウトのコードレビュー |
| `services/site` | [bmo-site](https://github.com/ahas/bmo-site) | bmo.ahas.io のプロジェクトサイト |
| `services/telegram` | [bmo-telegram](https://github.com/ahas/bmo-telegram) | Telegram チャットプロバイダー |
| `services/testbed` | [bmo-testbed](https://github.com/ahas/bmo-testbed) | テストベッド：キュー、テストスイート、クイックチェック、デプロイ |
| `services/theater` | [bmo-theater](https://github.com/ahas/bmo-theater) | 動画の保管庫：プレイリスト、続きから再生、字幕 |
| `services/voc` | [bmo-voc](https://github.com/ahas/bmo-voc) | お客様の声：メーカーへ送るバグ報告と提案 |
| `services/voice` | [bmo-voice](https://github.com/ahas/bmo-voice) | 音声エンジン：音声ノードでの学習済みの声と合成 |
| `services/web` | [bmo-web](https://github.com/ahas/bmo-web) | コンソール：アカウントサービス、言語パック、画面 |
| `tools/privacy-scan` | このリポジトリ | スクリプト1本：チェックアウトとその履歴の個人情報スキャン |

一部のサービスとツールは非公開のため、ここには載せていません。
