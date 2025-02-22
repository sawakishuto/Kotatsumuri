  module ValueObject
    class ValueObject::GrowthConditions < ValueObject::Base
      attr_reader :plant_id, :light, :soil, :hardiness_zone

      validates :plant_id, presence: true
      validates :light, presence: true
      validates :soil, presence: true
      validates :hardiness_zone, presence: true

      def initialize(plant_id, light, soil, hardiness_zone)
        @plant_id = plant_id
        @light = light
        @soil = soil
        @hardiness_zone = hardiness_zone
        super()
      end

      private
      def evaluate_attributes
        %i[plant_id light soil hardiness_zone]
      end
    end
  end
