require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:second_task) }
  let!(:third_task) { FactoryBot.create(:third_task) }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'task_title'
        fill_in 'タスク詳細', with: 'task_content'
        # fill_in 'タスク詳細', with: 'task_expired_at'
        click_on '登録する'
        expect(page).to have_content 'task_title'
        expect(page).to have_content 'task_content'
        # expect(page).to have_content 'task_expired_at'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'task_title3'
      end
    end
    # context 'タスクが終了期限の降順に並んでいる場合' do
    #   it '終了期限の遠いタスクが一番上に表示される' do
    #     visit task_path(task.id)
    #     click_on '終了期限'
    #     task_list = all('.task_list')
    #     expect(task_list[0]).to have_content 'task_title3'
    #   end
    # end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end