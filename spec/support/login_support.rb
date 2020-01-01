module LoginSupport

  def fill_in_login_form(user, option = { invalid: false })
    if option[:invalid]
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
    else
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
    end
  end
  
  def login_as(user, remember_me: '1')
    post login_path, params: { session: { email: user.email, password: user.password, remember_me: remember_me} }
    expect(response).to redirect_to(user_path(user))
  end
  
end
