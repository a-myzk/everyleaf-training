FactoryBot.define do
  factory :task do
    title { 'task_title1' }
    content { 'task_content1' }
    expired_at { '2021-05-01 00:00:00' }
    status { 1 }
    priority { 1 }
    association :user
  end

  factory :second_task, class: Task do
    title { 'task_title2' }
    content { 'task_content2' }
    expired_at { '2021-05-15 00:00:00' }
    status { 2 }
    priority { 2 }
    association :user
  end

  factory :third_task, class: Task do
    title { 'task_title3' }
    content { 'task_content3' }
    expired_at { '2021-05-10 00:00:00' }
    status { 3 }
    priority { 3 }
    association :user
  end
end