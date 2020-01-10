User.create!(name: "けーと",
             email: "example@booksharing.com",
             password: "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  end

Book.create!(
  title: "Sign",
  author: "Mr.children",
  content: "届いてくれるといいな
  君の分かんないところで 僕も今奏でてるよ
  育たないで萎れてた新芽みたいな音符(おもい)を
  二つ重ねて鳴らすハーモニー
  
  「ありがとう」と「ごめんね」を繰り返して僕ら
  人恋しさを積み木みたいに乗せてゆく
  
  ありふれた時間が愛しく思えたら
  それは愛の仕業と 小さく笑った
  君が見せる仕草 僕に向けられてるサイン
  もう 何ひとつ見落とさない
  そんなことを考えている
  ",
  good_point: "たまに無頓着な言葉で汚し合って
  互いの未熟さに嫌気がさす
  でもいつかは裸になり甘い体温に触れて
  優しさを見せつけ合う
  
  似てるけどどこか違う だけど同じ匂い
  身体でも心でもなく愛している
  
  僅かだって明かりが心に灯るなら
  大切にしなきゃ と僕らは誓った
  めぐり逢った すべてのものから送られるサイン
  もう 何ひとつ見逃さない
  そうやって暮らしてゆこう
  
  緑道の木漏れ日が君に当たって揺れる
  時間の美しさと残酷さを知る
  
  残された時間が僕らにはあるから
  大切にしなきゃと 小さく笑った
  君が見せる仕草 僕を強くさせるサイン
  もう 何ひとつ見落とさない
  そうやって暮らしてゆこう
  そんなことを考えている",
  picture: nil,
  user_id: 1
)

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
10.times do
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

