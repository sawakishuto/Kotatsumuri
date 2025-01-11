class DropCareScheduleToCarePeriod < ActiveRecord::Migration[7.2]
  def change
    drop_table :care_schedules
  end
end
