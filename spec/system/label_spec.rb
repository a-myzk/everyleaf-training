require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  # let(:user) { FactoryBot.create(:user) }
  # let!(:label) { FactoryBot.create(:label) }
  # let!(:second_label) { FactoryBot.create(:second_label) }
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
    visit new_session_path
    fill_in 'session[email]', with: 'test_email1@a.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'ログイン'
    visit tasks_path
  end

  describe 'ラベル登録機能' do
    context 'タスクを新規作成した際にラベルを選択した場合' do
      it '作成したタスクにラベルが紐付いて表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'task_title'
        fill_in 'task[content]', with: 'task_content'
        fill_in 'task[expired_at]', with: '2021-05-01 00:00:00'.to_date
        find('.status_field').set(1)
        find('.priority_field').set(1)
        check 'label1'
        click_on '登録する'
        expect(page).to have_content 'task_content'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'label1'
      end
    end
  end

end