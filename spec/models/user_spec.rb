require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when user data is valid' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'creates a user' do
      expect(@user).to be_valid
    end
  end

  context 'when user data is invalid' do
    before do
      # Setup invalid user data here
    end

  it 'nicknameが空では登録できない' do
    @user.nickname = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
  end

  it 'emailが空では登録できない' do
    @user.email = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it 'passwordが空だと登録できない' do
    @user.password = ''
    @user.password_confirmation = '' # 両方空にする
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end

  it 'パスワードが6文字以上であること' do
    @user.password = '12345'
    @user.password_confirmation = '12345'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end

  it 'パスワードが半角英字のみでは登録できない' do
    @user.password = 'abcdef'
    @user.password_confirmation = 'abcdef'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
  end

  it 'パスワードが半角数字のみでは登録できない' do
    @user.password = '123456'
    @user.password_confirmation = '123456'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
  end

  it 'パスワードが半角英数字混合であれば登録できる' do
    @user.password = 'abc123'
    @user.password_confirmation = 'abc123'
    @user.last_name = '山田'
    @user.first_name = '太郎'
    @user.last_name_kana = 'ヤマダ'
    @user.first_name_kana = 'タロウ'
    @user.birth_date = '2000-01-01'
    expect(@user).to be_valid
  end

  it 'パスワードとパスワード（確認）が一致しなければ登録できない' do
    @user.password = 'abc123'
    @user.password_confirmation = 'abc124' # 確認用パスワードが異なる
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it 'last_nameが空では登録できない' do
    @user.password = 'abc123'
    @user.password_confirmation = 'abc123'
    @user.last_name = '' # last_nameを空に設定
    @user.first_name = '太郎'
    @user.last_name_kana = 'ヤマダ'
    @user.first_name_kana = 'タロウ'
    @user.birth_date = '2000-01-01'
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end

  it 'first_nameが空では登録できない' do
    @user.first_name = '' # 名前を空にする
    @user.valid?
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end

  it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
    @user.last_name = 'yamada' # 半角英字での入力
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name is invalid")
  end

  it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
    @user.first_name = 'tarou' # 半角英字での入力
    @user.valid?
    expect(@user.errors.full_messages).to include("First name is invalid")
  end

  it 'last_name_kanaが空では登録できない' do
    @user.last_name_kana = '' # 空の入力
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana can't be blank")
  end

  it 'first_name_kanaが空では登録できない' do
    @user.first_name_kana = '' # 空の入力
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana can't be blank")
  end

  it 'last_name_kanaがカタカナ以外では登録できない' do
    @user.last_name_kana = 'やまだ' # ひらがなを入力
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana is must be Katakana")
  end

  it 'first_name_kanaがカタカナ以外では登録できない' do
    @user.first_name_kana = 'たろう' # ひらがなを入力
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana is must be Katakana")
  end

  it '生年月日が空では登録できない' do
    @user.birth_date = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Birth date can't be blank")
  end
end