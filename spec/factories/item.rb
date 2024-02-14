FactoryBot.define do
  factory :item do
    association :user
    name { 'テスト商品名' }
    description { 'テスト商品の説明' }
    price { 1000 }

    category { Category.all.sample }
    condition { Condition.all.sample }
    prefecture { Prefecture.all.sample }
    shipping_fee { ShippingFee.all.sample }
    shipping_day { ShippingDay.all.sample }

    after(:build) do |item|
      item.category_id = item.category.id
      item.condition_id = item.condition.id
      item.prefecture_id = item.prefecture.id
      item.shipping_fee_id = item.shipping_fee.id
      item.shipping_day_id = item.shipping_day.id

      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.png')), filename: 'test_image.png',
                        content_type: 'image/png')
    end
  end
end
