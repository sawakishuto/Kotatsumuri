class RemoveCareScheduleIdToCarePeriod < ActiveRecord::Migration[7.2]
  def change
    # 外部キー制約を削除
    remove_foreign_key :care_periods, :care_schedules

    # カラム自体も削除（必要なら）
    remove_column :care_periods, :care_schedule_id, :bigint
  end
end
