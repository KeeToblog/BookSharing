RSpec.shared_context "project setup" do
  let(:admin_params) { attributes_for(:login_user, admin: true) }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
end
