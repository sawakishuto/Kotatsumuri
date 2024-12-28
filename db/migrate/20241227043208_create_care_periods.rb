class CreateCarePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :care_periods do |t|
      t.references :care_schedule, null: false, foreign_key: true
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end