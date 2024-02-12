require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe 'アイテムの保存' do
    context 'アイテムが保存できる場合' do
      it '全ての項目が存在すれば保存できること' do
        expect(@item).to be_valid
      end
    end

    context 'アイテムが保存できない場合' do
      it '名前がないと保存できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '説明がないと保存できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it '価格がないと保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300未満だと保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9_999_999を超えると保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '画像がないと保存できない' do
        @item.image.detach # ActiveStorageを使っている場合、attachされている画像をdetachする
        @item.valid?
        expect(@item.errors.full_messages).to include("Image を1枚つけてください") # 正しいエラーメッセージに修正
      end
    end
  end
end
