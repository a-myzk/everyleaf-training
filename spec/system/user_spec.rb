require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'test_user'
        fill_in 'user[email]', with: 'test_user@a.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'アカウント作成'
        expect(page).to have_content 'test_user'
        expect(page).to have_content 'test_user@a.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能' do
    context '未ログイン状態の場合' do
      it 'ログインできる' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'test_email1@a.com'
        fill_in 'session[password]', with: 'password1'
        click_button 'ログイン'
        expect(page).to have_content 'のページ'
      end
    end
    context 'ログイン済みの場合' do
      before do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'test_email1@a.com'
        fill_in 'session[password]', with: 'password1'
        click_button 'ログイン'
      end
      it '自分の詳細画面(マイページ)に飛べる' do
        click_on 'プロフィール'
        expect(page).to have_content 'user1'
      end
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        admin_user = FactoryBot.create(:admin_user)
        visit user_path(admin_user.id)
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'ステータス名'
      end
      it 'ログアウトができる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面機能' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:admin_user)
    end
    context '管理ユーザがログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'test_email2@a.com'
        fill_in 'session[password]', with: 'password2'
        click_button 'ログイン'
      end
      it '管理ユーザは管理画面にアクセスできる' do
        click_on '管理画面'
        expect(page).to have_content '管理'
      end
      it '管理ユーザはユーザの新規登録ができる' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'test_user'
        fill_in 'user[email]', with: 'test_user@a.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'アカウント作成'
        expect(page).to have_content '登録しました'
      end
      it '管理ユーザはユーザの詳細画面にアクセスできる' do
        visit admin_users_path
        first('tbody tr').click_link '詳細'
        expect(page).to have_content '管理'
        expect(page).to have_content 'のページ'
      end
      it '管理ユーザはユーザの編集画面からユーザを編集できる' do
        visit admin_users_path
        first('tbody tr').click_link '編集'
        fill_in 'user[name]', with: 'test_user_edit'
        fill_in 'user[email]', with: 'test_user_edit@a.com'
        fill_in 'user[password]', with: 'password1'
        fill_in 'user[password_confirmation]', with: 'password1'
        click_on 'アカウント更新'
        expect(page).to have_content '更新しました'
      end
      it '管理ユーザはユーザの削除をできる' do
        visit admin_users_path
        all('tbody tr')[1].click_link '削除'
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '削除しました'
      end
    end
    context '一般ユーザがログインしている場合' do
      it '一般ユーザは管理画面にアクセスできるようにしない' do
        visit new_session_path
        fill_in 'session[email]', with: 'test_email1@a.com'
        fill_in 'session[password]', with: 'password1'
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content '管理者以外は管理画面にアクセスできません'
      end
    end
  end
end
