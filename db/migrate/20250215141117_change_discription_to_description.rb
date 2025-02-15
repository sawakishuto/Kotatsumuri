class ChangeDiscriptionToDescription < ActiveRecord::Migration[7.2]
  def change
    remove_column :todos, :discription, :string

    add_column :todos, :description, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
