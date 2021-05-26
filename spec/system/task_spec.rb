require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:third_task) { FactoryBot.create(:third_task, user: user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'test_email1@a.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'ログイン'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'task_title'
        fill_in 'タスク詳細', with: 'task_content'
        fill_in '終了期限', with: '2021-05-01 00:00:00'.to_date
        find('.status_field').set(1)
        find('.priority_field').set(1)
        click_on '登録する'
        expect(page).to have_content 'task_content'
        expect(page).to have_content '未着手'
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
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の遠いタスクが一番上に表示される' do
        visit tasks_path
        within '.sort_expired' do
          click_on '終了期限'
        end
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'task_title2'
      end
    end
  end

  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      before do
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in 'タスク名', with: 'task'
          click_on '検索'
          expect(page).to have_content 'task'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select '未着手', from: 'search_status'
          click_on '検索'
          expect(page).to have_content '未着手'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in 'タスク名', with: 'task'
          select '未着手', from: 'search_status'
          click_on '検索'
          expect(page).to have_content 'task'
          expect(page).to have_content '未着手'
        end
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, user: user)
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end