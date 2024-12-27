class Plant < ApplicationRecord
  # ネストされた属性を受け入れる
  accepts_nested_attributes_for :growth_condition, :care_schedule, :propagation_methods

end
