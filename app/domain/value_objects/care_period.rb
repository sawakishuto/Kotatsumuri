  module ValueObjects
    class ValueObjects::CarePeriod < ValueObjects::Base
      attr_reader :plant_id, :start_date, :end_date, :period_type

      validates :plant_id, presence: true
      validates :start_date, presence: true
      validates :end_date, presence: true
      validates :period_type, presence: true

      def initialize(plant_id, start_date, end_date, period_type)
        @plant_id = plant_id
        @start_date = start_date
        @end_date = end_date
        @period_type = period_type
        super()
        validate_type!
      end

      private
      def evaluate_attributes
        %i[plant_id start_date end_date period_type]
      end

      def validate_type!
        render unless period_type.in?(%w[blooming_period pruning_period planting_period fertilizing_period repotting_period])
      end
    end
  end
