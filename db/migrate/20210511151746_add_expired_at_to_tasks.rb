class AddExpiredAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :datetime, default: -> { "now()" }, null:false
  end
end
