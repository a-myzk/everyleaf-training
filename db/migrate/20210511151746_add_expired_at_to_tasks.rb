class AddExpiredAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :datetime, default: "2021-01-01 00:00:00", null:false
  end
end
