class CreateGrowthConditions < ActiveRecord::Migration[7.2]
  def change
    create_table :growth_conditions do |t|
      t.references :plant, null: false, foreign_key: true
      t.string :light
      t.string :soil
      t.string :hardiness_zone

      t.timestamps
    end
  end
end
