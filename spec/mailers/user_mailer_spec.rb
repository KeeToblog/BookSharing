require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  # アカウント有効化メールのテスト
  describe "account_activation" do

    let(:mail) { UserMailer.account_activation(user) }
    let(:user) { FactoryBot.create(:user) }

    it "renders the headers" do
      expect(mail.subject).to eq("【Book Sharing】アカウントの有効化をお願いします")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end
    it "renders the body" do
      user.activation_token = User.new_token
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include user.name
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include user.activation_token
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include CGI.escape(user.email)
    end
  end

  # パスワード再設定メールのテスト
  describe "password_reset" do

    let(:mail) { UserMailer.password_reset(user) }
    let(:user) { FactoryBot.create(:user) }

    it "renders the headers" do
      user.reset_token = User.new_token
      expect(mail.subject).to eq("【Book Sharing】パスワードの再設定をお願いします")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end
    it "renders the body" do
      user.reset_token = User.new_token
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include user.name
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include user.reset_token
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include CGI.escape(user.email)
    end
  end
end
