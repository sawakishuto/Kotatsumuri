class CreateUsersPlants < ActiveRecord::Migration[7.2]
  def change
    create_table :users_plants do |t|
      t.string :uid
      t.string :plantid

      t.timestamps
    end
  end
end
