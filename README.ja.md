[English](README.md) | [한국어](README.ko.md) | **日本語** | [简体中文](README.zh-CN.md)

# bmo

BMO システムはリポジトリの集まりで、ユニット1つにつきリポジトリ1つが、このフォルダの中に並んでいます。すべてのユニットが従う形は `STRUCTURE.md` に、各ユニットの役割はそのユニット自身の README と文書にあります。このリポジトリが追跡するのは構造、この一覧、独立したスクリプト1本だけです。ユニットはここでは追跡せず、それぞれ自分の名前でほかのユニットの隣にクローンします。

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
| `base/chat` | bmo-chat | プロバイダーとレシーバーの間のチャットプロトコルとそのクライアント |
| `base/text` | bmo-text | ルーム、コンソール、アーカイブが読むとおりに読み書きする Markdown とテキスト |
| `base/ui` | bmo-ui | コンソールの Nuxt レイヤー：すべての画面を形づくるトークン、コンポーネント、振る舞い |
| `resources/persona` | bmo-persona | チャットエージェントのペルソナ層と設定資料 |
| `resources/skills` | bmo-skills | ワーカーに渡すスキルと、それを配置する道具 |
| `services/agency` | bmo-agency | エージェントセッションの供給、配置、進行、終了と協働者プール |
| `services/arbiter` | bmo-arbiter | エンジンがカードを共有する GPU ノードのカード調停役 |
| `services/artifact` | bmo-artifact | 文書の保管、検索、共有 |
| `services/brain` | bmo-brain | ミドルウェアとしての記憶：行、ノート、監視、リマインダー、参照テキスト |
| `services/cache-siren` | bmo-cache-siren | プロンプトキャッシュのヒットと新規トークンのリアルタイム監視 |
| `services/cache-warmer` | bmo-cache-warmer | プロンプトキャッシュを温めておくスケジューラー |
| `services/calendar` | bmo-calendar | カレンダー、予定、アラーム、予約 |
| `services/cli` | bmo-cli | 各ユニットのコマンドを見つける入口コマンド |
| `services/discord` | bmo-discord | Discord チャットプロバイダー |
| `services/drive` | bmo-drive | ドライブ、オブジェクトストレージ、ノードのボリュームを横断するファイルビューア |
| `services/explorer` | bmo-explorer | 上流としての Web 読み取り：検索、ページ、プレビュー、画像 |
| `services/eye` | bmo-eye | 見ること：ビジョンモデルが読む画像と動画 |
| `services/face` | bmo-face | ケースの画面に映る顔、そのエディタとサーバー |
| `services/gate` | bmo-gate | ターンのゲート段階：参照、翻訳、記録 |
| `services/job` | bmo-job | ミドルウェアとしての TODO：項目、キュー、リース、質問、購読 |
| `services/mail` | bmo-mail | 各アカウントのメールボックス上のメールサービス |
| `services/node` | bmo-node | マシン一覧とハードウェアモニター |
| `services/note` | bmo-note | BlockSuite エディタのノート、AFFiNE のフォーク |
| `services/pocket` | bmo-pocket | ツールホスト、ツール一覧、ツール SDK |
| `services/receiver` | bmo-receiver | チャットレシーバー：ルーム、ルール、会話ウィンドウ、ターン、起動 |
| `services/remote` | bmo-remote | コンソールの裏にあるターミナルセッションとリモートデスクトップ |
| `services/research` | bmo-research | 文書として残るリサーチ |
| `services/review` | bmo-review | 登録されたチェックアウトのコードレビュー |
| `services/site` | bmo-site | bmo.ahas.io のプロジェクトサイト |
| `services/telegram` | bmo-telegram | Telegram チャットプロバイダー |
| `services/testbed` | bmo-testbed | テストベッド：キュー、テストスイート、クイックチェック、デプロイ |
| `services/theater` | bmo-theater | 動画の保管庫：プレイリスト、続きから再生、字幕 |
| `services/voc` | bmo-voc | お客様の声：メーカーへ送るバグ報告と提案 |
| `services/voice` | bmo-voice | 音声エンジン：音声ノードでの学習済みの声と合成 |
| `services/web` | bmo-web | コンソール：アカウントサービス、言語パック、画面 |
| `tools/privacy-scan` | このリポジトリ | スクリプト1本：チェックアウトとその履歴の個人情報スキャン |

一部のサービスとツールは非公開のため、ここには載せていません。
