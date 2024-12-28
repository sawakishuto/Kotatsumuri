  # ケア期間
  class CarePeriod < ApplicationRecord
    belongs_to :care_schedule
    validates :period_type, inclusion: { in: %w[blooming planting repotting fertilizing pruning] }

    validates :start_date, end_date, presence: true
  end
