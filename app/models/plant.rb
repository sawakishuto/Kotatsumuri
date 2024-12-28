class Plant < ApplicationRecord
  accepts_nested_attributes_for :growth_condition, :care_schedule, :propagation_methods
end
