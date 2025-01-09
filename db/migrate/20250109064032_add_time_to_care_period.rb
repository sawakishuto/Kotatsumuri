class AddTimeToCarePeriod < ActiveRecord::Migration[7.2]
  def change
    remove_column :care_periods, :start, :date
    remove_column :care_periods, :end, :date
    remove_column :care_periods, :period_type, :date

    add_column :care_periods, :start_date, :datetime
    add_column :care_periods, :end_date, :datetime
    add_column :care_periods, :period_type, :string
  end
end
