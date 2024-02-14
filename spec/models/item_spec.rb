require 'rails_helper'

RSpec.describe Item, type: :model do
  context '全ての項目が入力されていれば出品できる' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item, user: @user)
      @item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.png')), filename: 'test_image.png', 
                         content_type: 'image/png')
    end

    it '全ての項目が入力されていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '商品画像' do
    before do
      @item = FactoryBot.build(:item)
    end

    it '商品画像が空では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Image を1枚つけてください')
    end
  end

  context '商品名' do
    before do
      @item = FactoryBot.build(:item)
    end

    it '商品名が空では出品できない' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
  end

  context '商品説明' do
    before do
      @item = FactoryBot.build(:item)
    end

    it '商品説明が空では出品できない' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
  end

  context 'ActiveHash5項目' do
    before do
      @item = FactoryBot.build(:item)
    end

    it 'カテゴリーに「---」が選択されている場合は出品できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '商品の状態に「---」が選択されている場合は出品できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition must be other than 1')
    end

    it '配送料の負担に「---」が選択されている場合は出品できない' do
      @item.shipping_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee must be other than 1')
    end

    it '発送元の地域に「---」が選択されている場合は出品できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '発送までの日数に「---」が選択されている場合は出品できない' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
    end
  end

  context '価格' do
    before do
      @item = FactoryBot.build(:item)
    end

    it '価格が空では出品できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格に半角数字以外が含まれている場合は出品できない' do
      @item.price = 'abc123'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '価格が300円未満では出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が9_999_999円を超えると出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end
  end

  context '出品者情報' do
    before do
      @item = FactoryBot.build(:item)
    end

    it 'userが紐付いていなければ出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
