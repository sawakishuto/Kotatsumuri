  # ケアスケジュール
  class CareSchedule < ApplicationRecord
    belongs_to :plant
    has_one :blooming_period, class_name: "CarePeriod"
    has_one :planting_period, class_name: "CarePeriod"
    has_one :repotting_period, class_name: "CarePeriod"
    has_one :fertilizing_period, class_name: "FertilizingPeriod"
    has_one :pruning_period, class_name: "PruningPeriod"
  end