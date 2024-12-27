class Plant < ApplicationRecord
  # ネストされた属性を受け入れる
  accepts_nested_attributes_for :growth_condition, :care_schedule, :propagation_methods, :steps


  # 手順
  class Step < ApplicationRecord
    belongs_to :propagation_method
  end

  # 施肥期間
  class FertilizingPeriod < CarePeriod
    attribute :frequency, :string
  end

  # 剪定期間
  class PruningPeriod < CarePeriod
    attribute :description, :string
  end
end
