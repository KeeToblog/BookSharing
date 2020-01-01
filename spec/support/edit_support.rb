module EditSupport

  def fill_in_edit_form(user, option = { invalid: false })
    if option[:invalid]
      fill_in "名前", with: ""
      fill_in "メールアドレス", with: "user@invalid"
      fill_in "パスワード", with: "foo"
      fill_in "パスワード（確認）", with: "bar"
    else
      fill_in "名前", with: "Foo Bar"
      fill_in "メールアドレス", with: "foo@bar.com"
      fill_in "パスワード", with: ""
      fill_in "パスワード（確認）", with: ""
    end
  end

  # def fill_in_edit_form(name, email, password = "", password_confirmation = "")
  #   fill_in "名前", with: name
  #   fill_in "メールアドレス", with: email
  #   fill_in "パスワード", with: password
  #   fill_in "パスワード（確認）", with: password_confirmation
  # end

end
