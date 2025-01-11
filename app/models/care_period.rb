  # ケア期間
  class CarePeriod < ApplicationRecord
    belongs_to :plant
    validates :period_type, inclusion: { in: %w[blooming_period planting_period repotting_period fertilizing_period pruning_period] }
    validates :start_date, :end_date, presence: true
  end
