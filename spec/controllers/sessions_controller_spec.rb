require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # describe "POST #create" do
  #   it "login successfully" do
  #     user = FactoryBot.create(:user)
  #     post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1'}}
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
