FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'task_title1' }
    content { 'task_content1' }
    deadline { 'task_deadline1' }
  end

  factory :second_task, class: Task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'task_title2' }
    content { 'task_content2' }
    deadline { 'task_deadline2' }
  end
end