# BookSharingについて

## URL
https://apps.bookbooking2020.com/

## コンセプト
- 読んだ本の知識や感想をユーザー同士で共有し、学習効率のアップを促すサービスです。同じプログラミング初学者への情報共有と学習の振り返りのため、自分の本棚にはプログラミング関連の本を登録しました。

## こだわりポイント
- Ruby/Railsの基礎的な知識の定着を目的として、Ruby on Railsチュートリアルをベースに制作を進めました。
- 実際のRailsの現場を想像して、Slim, Sass, Bootstrap, RSpecを導入しました。
- 見た目（ビュー）のコードを簡潔に書くため、Bootstrapのコンポーネントを積極的に使いました。
- AWSをインフラに使用しました。多くの企業が使用しているツールであり、私自身もクラウドに興味があって勉強したかったからです。

## 実装した機能一覧
- ユーザー登録機能
- ログイン機能
- フォロー機能
- 記事一覧表示機能
- ページネーション機能
- 記事投稿機能
- 読書本投稿機能
- 読書本一覧（本棚）表示機能
- 読書本詳細（タイトル、画像、著者、内容とレビュー、おすすめポイント）表示機能
- 画像ファイルのアップロード機能
- 単体テスト、統合テスト

## 使用した技術一覧
### フロントエンド
- Slim/Sassでのマークアップ
- Bootstrapとメディアクエリを使用してレスポンシブデザイン化
### サーバーサイド
- 画像アップローダーにCarrierWaveを使用
- RSpecを使用してテストを記述
### インフラ
- AWS（EC2サーバー）にLinux, Nginx, MariaDB, Rubyの環境を構築
- DB:MariaDB(開発環境), MariaDB(本番環境)
- Webサーバー（Nginx）とWebアプリケーションサーバー（Puma）はUnixドメインソケットで接続
- Route53とロードバランサー(ELB）を使用してSSL通信化

## BookSharing システム構成図
![BookSharing_システム構成図](https://user-images.githubusercontent.com/57442237/86784727-d0478280-c09c-11ea-9d16-ac6e15764b01.jpg)
### 参照
- [Amazon Web Services 基礎からのネットワーク＆サーバー構築　改訂版](https://www.nikkeibp.co.jp/atclpubmkt/book/17/261530/)
- [ゼロからわかる Amazon Web Services超入門 はじめてのクラウド](https://gihyo.jp/book/2019/978-4-297-10661-4)
- [(下準備編)世界一丁寧なAWS解説。EC2を利用して、RailsアプリをAWSにあげるまで](https://qiita.com/naoki_mochizuki/items/f795fe3e661a3349a7ce)
