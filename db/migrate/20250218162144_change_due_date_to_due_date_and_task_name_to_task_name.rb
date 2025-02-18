class ChangeDueDateToDueDateAndTaskNameToTaskName < ActiveRecord::Migration[7.2]
  def change
    remove_column :todos, :taskname
    remove_column :todos, :duedate

    add_column :todos, :task_name, :string
    add_column :todos, :due_date, :string
  end
end
