FactoryBot.define do
  factory :task do
    title { 'task_title1' }
    content { 'task_content1' }
    # expired_at { 'task_expired_at1' }
  end

  factory :second_task, class: Task do
    title { 'task_title2' }
    content { 'task_content2' }
    # expired_at { 'task_expired_at2' }
  end

  factory :third_task, class: Task do
    title { 'task_title3' }
    content { 'task_content3' }
    # expired_at { 'task_expired_at3' }
  end
end