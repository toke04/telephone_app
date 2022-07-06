# ここで定義したデータは、他のスペックフォルダから呼べる
# テストユーザー作成用
FactoryBot.define do
    factory :user, class: 'User' do
      sequence(:id) { |n| n } #オートインクリメントでidを作成
      name {Faker::Name.name} #ダミーの名前を作成
      src {rand(1000..9999)} #4桁の数字であれば何でも良い
      telephone_pass {SecureRandom.alphanumeric(rand(1..12))} #12文字以下で作成
      email {Faker::Internet.email} #ダミーのemail
      password {SecureRandom.alphanumeric} #制限なし
      created_at { Time.current }
      updated_at { Time.current }
    end
  end