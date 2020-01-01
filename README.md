# BookSharingについて

## URL
https://booksharing2020.herokuapp.com/

## コンセプト
- 読んだ本の知識や感想をユーザー同士で共有し、学習効率のアップを促すサービス

## 何を意識して製作したか
- Ruby/Railsの基礎的な知識の定着と深化のため、[Ruby on Railsチュートリアル](https://railstutorial.jp/chapters/beginning?version=5.1)をベースに製作を進めた。
- 実際のRailsの現場を想定して、Slim, Sass, Bootstrap, RSpecを導入した。
- これからも適宜機能を追加していきます！乞うご期待！

## 実装した機能一覧
- ユーザー登録機能
- ログイン機能
- フォロー機能
- 記事一覧表示機能
- ページネーション機能
- 記事投稿機能
- 画像ファイルのアップロード機能
- 単体テスト、統合テスト

## 使用した技術一覧
### フロントエンド
- Slim/Sassでのマークアップ
- Bootstrapとメディアクエリを使用してレスポンシブデザイン化
### サーバーサイド
- 認証システムの仕組みを学ぶために認証系は自力で実装
- 画像アップローダーにCarrierWaveを使用
- RSpecを使用してテストを記述
### インフラ
- DB:SQLite(開発環境), PostgreSQL(本番環境)
- Herokuへのデプロイ

