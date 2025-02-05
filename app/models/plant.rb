class Plant < ApplicationRecord
  
  has_one :growth_condition
  has_many :care_periods
  has_many :propagation_methods
  has_many :users, through: :users_plants
  has_many :users_plants
end
