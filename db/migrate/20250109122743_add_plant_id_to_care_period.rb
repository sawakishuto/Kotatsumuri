class AddPlantIdToCarePeriod < ActiveRecord::Migration[7.2]
  def change
    # 1. `plant_id` カラムを追加（NOT NULL 制約はつけない）
    add_reference :care_periods, :plant, foreign_key: true

    # 2. 既存のデータにデフォルト値を設定（例: 最初のPlantのIDを設定する）
    reversible do |dir|
      dir.up do
        default_plant_id = Plant.first&.id # 必要に応じて変更
        CarePeriod.update_all(plant_id: default_plant_id) if default_plant_id.present?
      end
    end

    # 3. `NOT NULL` 制約を追加
    change_column_null :care_periods, :plant_id, false
  end
end
