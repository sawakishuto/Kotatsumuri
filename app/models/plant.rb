class Plant < ApplicationRecord
    # 他のアソシエーション
    has_one :growth_condition
    has_many :care_periods
    has_many :propagation_methods
end
