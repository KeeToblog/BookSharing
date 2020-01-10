# 成功メッセージ
shared_examples_for "success message" do |msg|
  it { subject.call; expect(flash[:success]).to eq msg }
end

# 失敗メッセージ
shared_examples_for "success message" do |msg|
  it { subject.call; expect(flash[:danger]).to eq msg }
end

# #リダイレクト
# shared_examples_for "redirect to path" do |msg|
#   it { subject.call, expect(response).to redirect_to path }
# end
