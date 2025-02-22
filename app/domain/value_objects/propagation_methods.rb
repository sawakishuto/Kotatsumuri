  module ValueObjects
    class ValueObjects::PropagationMethods < ValueObjects::Base
      attr_reader :plant_id, :method, :description

      validates :plant_id, presence: true
      validates :method, presence: true
      validates :description, presence: true

      def initialize(plant_id, method, description)
        @plant_id = plant_id
        @method = method
        @description = description
        super()
      end

      private
      def evaluate_attributes
        %i[plant_id method description]
      end
    end
  end
