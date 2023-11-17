class AddIsCompletedToTodo < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :is_completed, :boolean, default: false
  end
end
