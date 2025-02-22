  module Entity
    class Plant
      attr_reader :name, :description, :search_key, :image_url, :care_periods, :growth_conditions, :propagation_methods

      def initialize(name, description, search_key, image_url, care_periods_params = [], growth_conditions, propagation_methods)
        @name = name
        @description = description
        @search_key = search_key
        @image_url = image_url
        @growth_conditions = Domain::ValueObject::Value::GrowthConditions.new(growth_conditions[:plant_id], growth_conditions[:light], growth_conditions[:soil], growth_conditions[:hardiness_zone])
        @propagation_methods = Domain::ValueObject::Value::PropagationMethods.new(propagation_methods[:plant_id], propagation_methods[:method], propagation_methods[:description])
        @care_periods = create_care_periods(care_periods_params)
      end

      def create_care_periods(care_periods)
        @care_periods = care_periods.map do |care_period|
          Domain::ValueObject::Value::CarePeriod.new(care_period[:plant_id], care_period[:start_date], care_period[:end_date], care_period[:period_type])
        end
      end
    end
  end
