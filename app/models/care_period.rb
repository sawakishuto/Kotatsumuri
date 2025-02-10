class CarePeriod < ApplicationRecord
  belongs_to :plant
  validates :period_type, inclusion: { in: %w[blooming_period planting_period repotting_period fertilizing_period pruning_period] }
  validates :start_date, :end_date, presence: true

  # 検索日時が start_date < 今日 < end_date に該当するデータを取得
  def self.for_plant_ids_in_date_range(plant_ids, search_date)
    puts("search_date: #{search_date}")
    where(plant_id: plant_ids)
      .where("start_date <= ? AND end_date >= ?", search_date, search_date)
  end
end
