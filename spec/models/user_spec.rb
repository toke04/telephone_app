require 'rails_helper'

RSpec.describe User, type: :model do
  # この記述でFactoryBotで書いた情報でユーザーデータをビルド。
  let(:user) { build(:user) }

  it "正しくユーザーが登録されるか" do
    #　buildメソッドで作成した、userインスタンスが有効かどうか
    expect(user).to be_valid
  end

  it "[name.src,email]がなければ無効であること" do
    user1 = User.new(
      name: nil,
      src: nil,
      email: nil,
      password: SecureRandom.alphanumeric
    )
    user1.valid? #実行させる
    expect(user1.errors[:name]).to include("を入力してください") #エラーメッセージが含まれているか確かめる
    expect(user1.errors[:src]).to include("を入力してください") 
    expect(user1.errors[:email]).to include("を入力してください") 
  end

  it "重複した[name,src,email]は、作成できないこと" do
    # ダミーデータ作成
    user2 = User.create(
      name: "伊藤", 
      src: 3333,
      telephone_pass: SecureRandom.alphanumeric(rand(1..12)),
      email: "user2@user.com", 
      password: SecureRandom.alphanumeric 
    )
    # 重複したユーザーを作成
    user2 = User.new(
      name: "伊藤", 
      src: 3333, 
      email: "user2@user.com"
    )
    user2.valid?
    expect(user2.errors[:name]).to include("はすでに存在します")
    expect(user2.errors[:src]).to include("はすでに存在します")
    expect(user2.errors[:email]).to include("はすでに存在します")
  end
end