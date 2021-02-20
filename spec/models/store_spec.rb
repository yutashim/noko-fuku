require 'rails_helper'
RSpec.describe 'Userモデルに関わる機能のテスト', type: :model do
  before do
    DatabaseCleaner.clean
  end
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it ''
    end
    context 'メールアドレスが空の場合' do
      it ''
    end
    context 'メールアドレスが重複する場合' do

    end
    context 'パスワードが空の場合' do
      it ''
    end
    context 'パスワードと確認用パスワードが一致しない場合' do
      it ''
    end
    context 'コメントの内容が空の場合'do
      it ''
    end
    context 'Userが削除された場合' do
      it '結びついていたCommentも削除される' do

      end
      it '結びついていたUserFavoriteも削除される' do

      end
    end
    context 'UserFavoriteに重複したレコードがすでに存在するとき' do
      it ''
    end

  end
end
