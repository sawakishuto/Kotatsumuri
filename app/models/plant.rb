class Plant < ApplicationRecord
  
  has_one :growth_condition
  has_many :care_periods
  has_many :propagation_methods
end
