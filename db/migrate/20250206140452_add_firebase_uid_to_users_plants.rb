class AddFirebaseUidToUsersPlants < ActiveRecord::Migration[7.2]
    def change
      remove_column :users_plants, :uid
      add_column :users_plants, :firebase_uid, :string
      add_index :users_plants, :firebase_uid
  end
end
