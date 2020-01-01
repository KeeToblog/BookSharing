require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  describe "permanent cookies" do

    # 暗号化したユーザーIDと記憶トークンをrememberメソッドに渡して、それぞれの永続性クッキーを生成する
    before do
      @user = FactoryBot.create(:user)
      remember(@user)
    end

    # 一時セッションにユーザーがいる時のテスト
    context "when session exsists " do
      it "current_user returns right user" do
        expect(@user).to eq current_user
        expect(session[:user_id]).to eq current_user.id
      end
    end

    # 誤った記憶トークンをDBの記憶ダイジェストと比較する（authenticated?メソッドのテスト）
    context "when remember_digest iw wrong" do
      it "current_user returns nil" do
        # 渡された永続性ユーザーIDを元に生成したトークンではなく、適当な22の文字列(User.new_token)をトークンとして渡している
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end

  end

end
