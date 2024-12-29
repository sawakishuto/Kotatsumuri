class AddStartDateToCarePeriod < ActiveRecord::Migration[7.2]
  def change
    remove_column :care_periods, :start, :date
    remove_column :care_periods, :end, :date

    add_column :care_periods, :start_date, :date
    add_column :care_periods, :end_date, :date
  end
end
