class ChangePlantidToPlantId < ActiveRecord::Migration[7.2]
  def change
    remove_column :users_plants, :plantid, :bigint

    add_column :users_plants, :plant_id, :bigint
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
