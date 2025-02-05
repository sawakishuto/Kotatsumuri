class ChangeLineUserIdToFirebaseUid < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :line_user_id, :string

    add_column :users, :firebase_uid, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
