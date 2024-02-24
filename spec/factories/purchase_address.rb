FactoryBot.define do
  factory :purchase_address do
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { 'テスト市' }
    address { 'テスト町1-1' }
    building_name { 'テストビル101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000'}
  end
end
