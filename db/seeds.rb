User.create!(name: "けーと",
             email: "example@booksharing.com",
             password: "foobar",
             password_confirmation: "foobar",
             profile: "管理人の「けーと」です！Book Sharingをご利用いただきありがとうございます。本サービスでは、Twitterのようなミニブログの投稿とお気に入りの本の登録ができます。管理人の本棚には本サービス（ポートフォリオ）を制作するときに参考にした本が登録されています。プログラミング初学者にとってポートフォリオの制作は一つの山場。ここが踏ん張りどころです。本で得られる情報は良いヒントとなります。がんばってください！",
             activated: true,
             activated_at: Time.zone.now)

9.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  profile = Faker::Lorem.paragraph(sentence_count: 8, supplemental: false, random_sentences_to_add: 4)
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               profile: profile,
               activated: true,
               activated_at: Time.zone.now)
  end

Book.create!(
  title: "Bootstrap4 フロントエンド開発の教科書",
  author: "宮本麻矢(著), 朝平文彦(著), 山田祥寛(監修)",
  content:
"「Bootstrap」はTwitter社が開発したレスポンシブなWebページを簡単に作ることができるWebアプリケーションフレームワークです。HTMLとCSSの基本を押さえたらBootstrapも学ぶのがオススメです。Bootstrapには覚えるべきルールが少なからずありますが、マスターすればこれほど頼りになる存在はありません。本書では、テーブル、表、ボタン、フォーム、ナビゲーションなどの基本的なコンポーネントの作り方を網羅的に解説しています。この本は、本サイトの見た目にかなり貢献してくれました。感謝です。",
  good_point:
"本書が対象としている読者は「デザインは苦手」というエンジニアや「コーディングが苦手」というデザイナーです。もちろん、初めてポートフォリオに着手する初学者にとっても役立つ一冊となっています。初学者が洗練されたコンポーネントをゼロから作るのは骨が折れます。Bootstrapを使えばおしゃれなデザインが簡単にできますし、レスポンシブWebデザインに対応しているため、スマホ対応もお手軽に実現できます。ポートフォリオ制作なら「そこそこの見た目のWebサイト」をパパッと作るくらいで十分じゃないでしょうか。そんなときにぜひ押さえたいのがこの１冊。",
  picture: open("#{Rails.root}/db/fixtures/Bootstrap4.png"),
  user_id: 1
)

Book.create!(
  title: "体系的に学ぶ安全なWebアプリケーションの作り方 第2版 脆弱性が生まれる原理と対策の実践",
  author: "徳丸浩(著）",
  content:
"内容とレビューはまだありません。",
  good_point:
"Railsチュートリアルの2周目に取り組んでいるときに買ったのが本書です。初学者にとってキツいのがチュートリアル第６章から始まる認証システム。Railsチュートリアルでは、まずは自力で認証システムを実装することが推奨されています。とはいえ、そのままチュートリアルに突っ込んでも脳内にはセッション、クッキー、トークンの単語が踊っていることでしょう。本書で体系的な認証システムの仕組みを学んでおくのがおすすめです。「Railsチュートリアルは自分に何をさせようとしているのか」を理解しておけば挫折せずに取り組めますよ！",
  picture: open("#{Rails.root}/db/fixtures/DevelopingSecureWebApplications.png"),
  user_id: 1
)

Book.create!(
  title: "Everyday Rails RSPecによるRailsテスト入門",
  author: "Aaron Sumner(著), 伊藤淳一(訳), 秋元利春(訳), 魚振江(訳)",
  content:
"内容とレビューはまだありません。",
  good_point:
"おすすめポイントはまだありません。",
  picture: open("#{Rails.root}/db/fixtures/Everyday Rails RSpec.png"),
  user_id: 1
)

Book.create!(
  title: "HTML5/CSS3モダンコーディング",
  author: "吉田真麻",
  content:
"内容とレビューはまだありません。",
  good_point:
"おすすめポイントはまだありません。",
  picture: open("#{Rails.root}/db/fixtures/HTML_CSS3_モダンコーディング.png"),
  user_id: 1
)

Book.create!(
  title: "プロを目指す人のためのRuby入門",
  author: "伊藤淳一",
  content:
"内容とレビューはまだありません。",
  good_point:
"おすすめポイントはまだありません。",
  picture: open("#{Rails.root}/db/fixtures/Ruby_for_Professional.png"),
  user_id: 1
)

Book.create!(
  title: "現場で使える Ruby on Rails 5速習実践ガイド",
  author: "大場寧子(著), 松本拓也(著), 櫻井達生(著), (.etc",
  content:
"内容とレビューはまだありません。",
  good_point:
"おすすめポイントはまだありません。",
  picture: open("#{Rails.root}/db/fixtures/RubyOnRails5.png"),
  user_id: 1
)

Book.create!(
  title: "Webを支える技術",
  author: "山本陽平",
  content:
"内容とレビューはまだありません。",
  good_point:
"おすすめポイントはまだありません。",
  picture: open("#{Rails.root}/db/fixtures/Webを支える技術.png"),
  user_id: 1
)

10.times do
  users = User.order(:created_at).take(6)
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
10.times do
  users = User.where(id: [2,3,4,5,6])
  title = Faker::Book.title
  author = Faker::Book.author
  content = Faker::Lorem.sentence(5)
  good_point = Faker::Lorem.sentence(5)
  users.each { |user| user.books.create!(title: title, author: author, content: content, good_point: good_point ) }
end

users = User.all
user = users.first
following = users[2..9]
followers = users[3..8]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

