require 'rails_helper'
RSpec.describe 'Storeモデルに関わる機能のテスト', type: :model do
  let(:set_store) do
    @store = FactoryBot.create(:store)
    @store_b = FactoryBot.create(:store_b)
  end
  before do
    DatabaseCleaner.clean
    set_store
  end
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションのに引っかかる' do
        @store.name = ''
        expect(@store).not_to be_valid
      end
    end
    context 'メールアドレスが空の場合' do
      it 'バリデーションに引っかかる' do
        @store.email = ''
        expect(@store).not_to be_valid
      end
    end
    context 'メールアドレスが重複する場合' do
      it 'バリデーションに引っかかる' do
        @store_b.email = @store.email
        expect(@store_b).not_to be_valid
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションに引っかかる' do
        @store.password = ''
        @store.password_confirmation = ''
        expect(@store).not_to be_valid
      end
    end
    context 'パスワードと確認用パスワードが一致しない場合' do
      it 'バリデーションに引っかかる' do
        @store.password = 'password'
        @store.password_confirmation = 'wordpass'
        expect(@store).not_to be_valid
      end
    end
    context 'お知らせ(広告)の内容が空の場合'do
      it 'バリデーションに引っかかる' do
        promotion = @store.promotions.build(content: '')
        expect(promotion).not_to be_valid
      end
    end
    context 'storeが削除された場合' do
      it '結びついていたお知らせ(広告)も削除される' do
        promotion = @store.promotions.build(content: 'content')
        promotion.save
        @store.destroy
        expect(Promotion.find_by(id: promotion.id)).to eq nil
      end
      it '結びついていたStoreFavoriteも削除される' do
        favorite = @store.active_follows.build(followed: @store_b)
        favorite.save
        @store.destroy
        expect(StoreFavorite.find_by(id: favorite.id)).to eq nil
      end
    end
    context 'StoreFavoriteに重複したレコードがすでに存在するとき' do
      it 'バリデーションに引っかかる' do
        @store.active_follows.create(followed: @store_b)
        favorite = @store.active_follows.build(followed: @store_b)
        expect{ favorite.save }.to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end
end
