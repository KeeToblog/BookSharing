module HeaderSupport

  def header_has_right_link(user, option = { login: false })
    if option[:login]
      expect(page).to have_link('ユーザー一覧')
      expect(page).to have_link('アカウント')
      expect(page).not_to have_link('ログイン')
      expect(page).not_to have_link('新規登録')
    else
      expect(page).not_to have_link('ユーザー一覧')
      expect(page).not_to have_link('アカウント')
      expect(page).to have_link('ログイン')
      expect(page).to have_link('新規登録')
    end
  end
  
end
