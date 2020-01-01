module SignupSupport

  def fill_in_signup_form(user, option = { invalid: false })
    if option[:invalid]
      fill_in "名前", with: ""
      fill_in "メールアドレス", with: "user@invalid"
      fill_in "パスワード", with: "foo"
      fill_in "パスワード（確認）", with: "bar"
    else
      fill_in "名前", with: "Example User"
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認）", with: "password"
    end
  end

end
