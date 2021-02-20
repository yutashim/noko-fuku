require 'rails_helper'
RSpec.describe 'ストア管理機能のテスト', type: :system do
  before do
    DatabaseCleaner.clean
  end
  let(:login) do
    visit store_login_path
    fill_in 'Email', with: 'store_a@mail.com'
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
  end
  describe 'ユーザー登録' do
    it 'ストアの新規登録ができる' do
      visit new_store_path
      fill_in '店名', with: 'first_store'
      fill_in 'メールアドレス', with: 'first_store@mail.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_on '登録する'
      expect(page).to have_content 'first_store'
    end
  end
  describe 'ログイン機能、マイページ遷移のテスト' do
    before do
      @store_a = FactoryBot.create(:store)
      @store_b = FactoryBot.create(:store_b)
    end
    it '登録済みユーザーはログインできる' do
      visit store_login_path
      fill_in 'Email', with: 'store_a@mail.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
      click_link 'マイページ'
      expect(page).to have_content 'store_aさんのマイページ'
    end
    it '自分以外のマイページにアクセスするとお店の一覧ページに飛ばされる' do
      login
       visit store_mypage_path(@store_b.id)
       expect(page).to have_current_path stores_path
    end
  end
  describe 'ユーザーの編集、削除機能のテスト' do
    before do
      @store_a = FactoryBot.create(:store)
      @store_b = FactoryBot.create(:store_b)
    end
    it 'ユーザーは自分のプロフィールを編集できる' do
      login
      visit edit_store_path(@store_a.id)
      fill_in '店名', with: 'edited'
      fill_in 'メールアドレス', with: 'edited@mail.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_button '更新する'
      expect(Store.first.name).to eq 'edited'
      expect(Store.first.email).to eq 'edited@mail.com'
    end
    it '他のユーザーのプロフィール編集はできない' do
      login
      visit edit_store_path(@store_b.id)
      expect(page).to have_current_path stores_path
    end
    it 'ユーザーは自分のアカウントを削除できる' do
      login
      visit edit_store_path(@store_a.id)
      click_link '退会する'
      expect(Store.find_by(name: @store_a.name)).to eq nil
    end
  end
  describe 'お気に入り機能の追加、削除' do
    before do
      @store_a = FactoryBot.create(:store)
      @store_b = FactoryBot.create(:store_b)
      FactoryBot.create(:promotion, store: @store_b)
    end
    let(:add_favorite) do
      login
      visit store_path(@store_b.id)
      click_link 'お気に入り登録'
    end
    it 'お店をお気に入り登録できて、マイページでお店のお知らせが見れる' do
      add_favorite
      visit store_mypage_path(@store_a.id)
      expect(@store_a.following_stores.count).to eq 1
      expect(page).to have_content 'お店からのお知らせ'
    end
    it 'お気に入りの解除ができる' do
      add_favorite
      click_link 'お気に入り解除'
      expect(page).to have_content 'お気に入り登録'
      expect(@store_a.following_stores.count).to eq 0
    end
  end
  describe 'お店のお知らせ(promotion)を投稿機能' do
    before do
      @store_a = FactoryBot.create(:store)
      login
    end
    it 'お店はお知らせを投稿できる' do
      visit store_mypage_path(@store_a.id)
      click_link "広告を投稿する"
      fill_in 'タイトル', with: 'タイトルの入力'
      fill_in '内容', with: '内容の入力'
      click_button 'post'
      expect(page).to have_content 'タイトルの入力'
      expect(page).to have_content '内容の入力'
    end
  end
  describe '天気の表示' do
    it '所在地の登録があれば天気が表示される' do
      @store_a = FactoryBot.create(:store, city: '横浜市')
      visit store_path(@store_a.id)
      expect(page).to have_content 'ただ今の天気'
    end
  end
end
