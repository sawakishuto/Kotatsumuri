class ChangePlantidToBigint < ActiveRecord::Migration[7.2]
  def up
    change_column :users_plants, :plantid, 'bigint USING plantid::bigint'
  end

  def down
    change_column :users_plants, :plantid, 'varchar USING plantid::varchar'
  end
end
