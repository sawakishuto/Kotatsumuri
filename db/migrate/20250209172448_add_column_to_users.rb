class AddColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :todos, :users_plants_id, :bigint
  end
end
