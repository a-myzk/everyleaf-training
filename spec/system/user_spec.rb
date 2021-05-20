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
  end
end

# describe '【テストのグループ化（〇〇に関するテスト）】' do
#   context '【条件別にグループ化（〇〇の場合）】' do
#     before do
#       【共通の前準備をする】
#     end
#     it '【テストの内容（〇〇になること）】' do
#       【テストの処理（〇〇になることを期待する）】
#     end
#   end
# end