FactoryBot.define do
  factory :item do
    association :user
    name { 'テスト商品名' }
    description { 'テスト商品の説明' }
    price { 1000 }

    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    shipping_fee_id { Faker::Number.between(from: 2, to: 3) }
    shipping_day_id { Faker::Number.between(from: 2, to: 4) }

    after(:build) do |item|
      # item.category_id = item.category.id
      # item.condition_id = item.condition.id
      # item.prefecture_id = item.prefecture.id
      # item.shipping_fee_id = item.shipping_fee.id { 2 }
      # item.shipping_day_id = item.shipping_day.id { 2 }

      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.png')), filename: 'test_image.png',
                        content_type: 'image/png')
    end
  end
end
