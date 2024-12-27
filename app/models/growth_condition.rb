class GrowthCondition < ApplicationRecord
  belongs_to :plant
  validates :light, :soil, :hardiness_zone, presence: true
end