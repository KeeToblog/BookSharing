source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# 環境変数の保存ファイル
gem 'dotenv-rails', groups: [:development, :test]
# 画像のリサイズ
gem 'mini_magick', '4.7.0'
# 画像アップローダー
gem 'carrierwave', '1.2.2'
# jQuery(JavaScriptライブラリ)
gem 'jquery-rails'
# ダミーユーザーを作る
gem 'faker'
# シンプルかつ堅牢なページネーションメソッド
gem 'will_paginate'
# Bootstrapのページネーションスタイルを使ってwill_pagenateを構成する
gem 'bootstrap-will_paginate'
# Bootstrapを使うことでアプリケーションをレスポンシブデザインにできる
gem "bootstrap", "~> 4.3.1"
# パスワードをハッシュ化させるbcrypt
gem 'bcrypt'
# Slimジェネレーターの導入
gem 'slim-rails'
# ERB形式のファイルをSlimに変更できる。途中でSlim形式に変更したいときに便利なgem
gem 'html2slim'
# Sassを編集してfont-awesomeを組み込むgem
gem 'font-awesome-sass', '~> 5.11.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # 開発（ローカル）環境（development, test）ではRailsに初めからついているSQLite3を使う。
  # gem 'sqlite3'
  gem 'mysql2'
  # RubyにおけるBDDのためのテスティングフレームワーク
  gem 'rspec-rails', '~> 3.7'
  # テスト用データを作成する。Rails標準のFixtureの代替になる。
  gem 'factory_bot_rails', '~> 4.11'
  # assignsメソッドとassert_templateメソッドが使えるようになる（Rails4以降では非推奨）
  gem 'rails-controller-testing'
end



group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # binstubをインストールすることで、アプリケーションの起動時間を素早くするSPringの恩恵が受けられる。
  gem 'spring-commands-rspec'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'shoulda-matchers'
end

group :production do
  # 本番環境（production）、つまりherokeではpg（PostgreSQL）というデータベースを使う。
  # gem 'pg'
  gem 'mysql2'
  # 本番環境で画像をアップロードする
  gem 'fog', '1.42'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'paperclip'
