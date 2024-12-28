  # ケアスケジュール
  class CareSchedule < ApplicationRecord
    belongs_to :plant
    has_many :care_periods, dependent: :destroy
  end