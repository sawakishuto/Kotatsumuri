class Plant < ApplicationRecord
    # 他のアソシエーション
    has_one :growth_condition
    has_one :care_schedule
    has_many :propagation_methods
end
