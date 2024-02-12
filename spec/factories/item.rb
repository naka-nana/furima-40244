FactoryBot.define do
  factory :item do
    association :user # Itemと関連するUserインスタンスを生成する
    name { "テスト商品名" }
    description { "テスト商品の説明" }
    price { 1000 } # 適当なデフォルト価格

    # Itemインスタンスがビルドされた後に実行されるブロック
    after(:build) do |item|
      # spec/fixturesフォルダにテスト用の画像ファイルを配置しておく
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
