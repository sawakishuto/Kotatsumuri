class ChangePlantidToBigint < ActiveRecord::Migration[7.2]
  # PostgreSQLでは、型の互換性がない場合、手動で USING を指定する必要がある
  def up
    change_column :users_plants, :plantid, 'bigint USING plantid::bigint'
  end

  def down
    change_column :users_plants, :plantid, 'varchar USING plantid::varchar'
  end
end
