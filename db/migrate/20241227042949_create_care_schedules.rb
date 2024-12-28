class CreateCareSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :care_schedules do |t|
      t.references :plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end