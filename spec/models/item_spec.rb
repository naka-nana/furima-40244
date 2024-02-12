require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
    @item.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
  end

  it '全ての項目が存在すれば保存できること' do
    expect(@item).to be_valid
  end

  it '画像がないと保存できないこと' do
    @item.image.detach
    @item.valid?
    expect(@item.errors.full_messages).to include('Image を1枚つけてください')
  end

  it '名前がないと保存できないこと' do
    @item.name = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Name can't be blank")
  end

  it '説明がないと保存できないこと' do
    @item.description = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Description can't be blank")
  end

  it '価格がないと保存できないこと' do
    @item.price = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Price can't be blank")
  end

  it '価格が300未満だと保存できないこと' do
    @item.price = 299
    @item.valid?
    expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
  end

  it '価格が9_999_999を超えると保存できないこと' do
    @item.price = 10_000_000
    @item.valid?
    expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
  end

  it '価格が整数でないと保存できないこと' do
    @item.price = '300.5'
    @item.valid?
    expect(@item.errors.full_messages).to include('Price must be an integer')
  end
end
