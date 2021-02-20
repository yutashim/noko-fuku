require 'rails_helper'
RSpec.describe 'Userモデルに関わる機能のテスト', type: :model do
  let(:set_user) do
    DatabaseCleaner.clean
    @user = FactoryBot.create(:user)
    @store = FactoryBot.create(:store)
  end
  before do
    set_user
  end
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションのに引っかかる' do
        @user.name = ''
        expect(@user).not_to be_valid
      end
    end
    context 'メールアドレスが空の場合' do
      it 'バリデーションに引っかかる' do
        @user.email = ''
        expect(@user).not_to be_valid
      end
    end
    context 'メールアドレスが重複する場合' do
      it 'バリデーションに引っかかる' do
        user_b = User.new(
          name: 'user',
          email: @user.email,
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user_b).not_to be_valid
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションに引っかかる' do
        @user.password = ''
        @user.password_confirmation = ''
        expect(@user).not_to be_valid
      end
    end
    context 'パスワードと確認用パスワードが一致しない場合' do
      it 'バリデーションに引っかかる' do
        @user.password = 'password'
        @user.password_confirmation = 'wordpass'
        expect(@user).not_to be_valid
      end
    end
    context 'コメントの内容が空の場合'do
      it 'バリデーションに引っかかる' do
        comment = @user.comments.build(content: '')
        expect(comment).not_to be_valid
      end
    end
    context 'Userが削除された場合' do
      it '結びついていたCommentも削除される' do
        comment = @user.comments.build(content: 'comment', store: @store)
        comment.save
        @user.destroy
        expect(Comment.find_by(id: comment.id)).to eq nil
      end
      it '結びついていたUserFavoriteも削除される' do
        favorite = @user.user_favorites.build(store: @store)
        favorite.save
        @user.destroy
        expect(UserFavorite.find_by(id: favorite.id)).to eq nil
      end
    end
    context 'UserFavoriteに重複したレコードがすでに存在するとき' do
      it 'バリデーションに引っかかる' do
        @user.user_favorites.create(store: @store)
        favorite = @user.user_favorites.build(store: @store)
        expect{ favorite.save }.to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end
end
