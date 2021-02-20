require 'rails_helper'
RSpec.describe 'ユーザー管理機能のテスト', type: :system do
  before do
    DatabaseCleaner.clean
  end
  let(:login) do
    visit new_session_path
    fill_in 'Email', with: 'user_a@email.com'
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
  end
  describe 'ユーザー登録' do
    it 'ユーザーの新規登録ができる' do
      visit new_user_path
      fill_in '名前', with: 'first_user'
      fill_in 'メールアドレス', with: 'first_user@mail.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_on '登録する'
      expect(page).to have_content 'first_userさんのマイページ'
    end
  end
  describe 'ログイン機能、マイページ遷移のテスト' do
    before do
      @user_a = FactoryBot.create(:user)
      @user_b = FactoryBot.create(:user_b)
    end
    it '登録済みユーザーはログインできる' do
      visit new_session_path
      fill_in 'Email', with: 'user_a@email.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
      click_link 'マイページ'
      expect(page).to have_content 'user_aさんのマイページ'
    end
    it '自分以外のマイページにアクセスするとお店の一覧ページに飛ばされる' do
      login
       visit user_path(@user_b.id)
       expect(page).to have_current_path stores_path
    end
  end
  describe 'ユーザーの編集、削除機能のテスト' do
    before do
      @user_a = FactoryBot.create(:user)
      @user_b = FactoryBot.create(:user_b)
    end
    it 'ユーザーは自分のプロフィールを編集できる' do
      login
      visit edit_user_path(@user_a.id)
      fill_in '名前', with: 'edited'
      fill_in 'メールアドレス', with: 'edited@mail.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_button '更新する'
      expect(User.first.name).to eq 'edited'
      expect(User.first.email).to eq 'edited@mail.com'
    end
    it '他のユーザーのプロフィール編集はできない' do
      login
      visit edit_user_path(@user_b.id)
      expect(page).to have_current_path stores_path
    end
    it 'ユーザーは自分のアカウントを削除できる' do
      login
      visit edit_user_path(@user_a.id)
      click_link '退会する'
      expect(User.find_by(name: @user_a.name)).to eq nil
    end
  end
  describe 'お気に入り機能の追加、削除' do
    before do
      @user_a = FactoryBot.create(:user)
      @store = FactoryBot.create(:store)
      FactoryBot.create(:promotion)
    end
    let(:add_favorite) do
      login
      visit store_path(@store.id)
      click_link 'お気に入り登録'
    end
    it 'お店をお気に入り登録できて、マイページでお店のお知らせが見れる' do
      add_favorite
      visit user_path(@user_a.id)
      expect(page).to have_content 'お店からのお知らせ'
    end
    it 'お気に入りの解除ができる' do
      add_favorite
      click_link 'お気に入り解除'
      expect(page).to have_content 'お気に入り登録'
      expect(@user_a.favorite_stores.count).to eq 0
    end
  end
  describe 'コメントの投稿、編集、削除機能のテスト' do
    before do
      @user_a = FactoryBot.create(:user)
      @store = FactoryBot.create(:store)
      login
      visit store_path(@store.id)
    end
    let(:comment) do
      fill_in 'comment_input_create', with: 'コメントの投稿'
      click_button '登録する'
    end
    it 'お店に対してコメントを投稿できる' do
      comment
      expect(page).to have_content 'コメントの投稿'
    end
    it 'コメントの編集ができる' do
      comment
      click_link '編集'
      fill_in 'comment_input_edit', with: 'コメントの編集'
      click_button '更新する'
      expect(page).to have_content 'コメントの編集'
    end
    it 'コメントの削除ができる' do
      comment
      click_on '削除'
      expect(page).to have_content 'コメントが削除されました'
      expect(Comment.count).to eq 0
    end
  end
end
