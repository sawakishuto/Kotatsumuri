class AddPeriodTypeToCarePeriods < ActiveRecord::Migration[7.2]
  def change


    remove_column :care_periods, :start, :string
    remove_column :care_periods, :end, :string
    
    add_column :care_periods, :period_type, :date
    add_column :care_periods, :start, :date
    add_column :care_periods, :end, :date

  end
end
