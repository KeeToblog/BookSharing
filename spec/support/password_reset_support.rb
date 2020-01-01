module PasswordResetSupport

  def fill_in_signed_up_email_form(user, option = { invalid: false })
    if option[:invalid]
      fill_in "登録メールアドレス", with: ""
    else
      fill_in "登録メールアドレス", with: user.email
    end
  end
  
end
