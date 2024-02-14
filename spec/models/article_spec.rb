require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'アイテムの保存' do
    before do
      @user = FactoryBot.create(:user) # @user を作成
      @item = FactoryBot.build(:item, user: @user) # @user を関連付けて @item を作成
    end

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

      it 'カテゴリーが選択されていないと保存できない' do
        @item.category_id = 1 # 「---」に対応するidが選択された場合
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it '商品の状態が選択されていないと保存できない' do
        @item.condition_id = 1 # 「---」に対応するidが選択された場合
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      it '発送元地域が選択されていないと保存できない' do
        @item.prefecture_id = 1 # 「---」に対応するidが選択された場合
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '送料が選択されていないと保存できない' do
        @item.shipping_fee_id = 1 # 「---」に対応するidが選択された場合
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee must be other than 1')
      end

      it '発送が選択されていないと保存できない' do
        @item.shipping_day_id = 1 # 「---」に対応するidが選択された場合
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
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

      it '価格が半角数字以外の値を含む場合は保存できない' do
        @item.price = 'abc123' # 半角数字以外の値を含む場合
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '画像がないと保存できない' do
        @item.image.detach # ActiveStorageを使っている場合、attachされている画像をdetachする
        @item.valid?
        expect(@item.errors.full_messages).to include('Imageを入力してください')
      end
    end
  end
end
