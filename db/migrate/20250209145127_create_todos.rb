class CreateTodos < ActiveRecord::Migration[7.2]
  def change
    create_table :todos do |t|
      t.string :taskname
      t.string :discription
      t.string :timing
      t.string :priority
      t.string :status
      t.string :duedate

      t.timestamps
    end
  end
end
