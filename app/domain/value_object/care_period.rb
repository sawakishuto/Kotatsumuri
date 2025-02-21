module Domain
  module ValueObject
    class Value::CarePeriod < Value::Base
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
      end

      private
      def evaluate_attributes
        %i[plant_id start_date end_date period_type]
      end

      def validate!
        raise ArgumentError, "plant_id is required" if @plant_id.nil?
        raise ArgumentError, "start_date is required" if @start_date.nil?
        raise ArgumentError, "end_date is required" if @end_date.nil?
        raise ArgumentError, "period_type is required" if @period_type.nil?
        raise DomainError, "period_type is invalid" if @period_type != "blooming_period" || @period_type != "pruning_period" || @period_type != "fertilizing_period" || @period_type != "planting_period" || @period_type != "repotting_period"
      end
    end
  end
end
