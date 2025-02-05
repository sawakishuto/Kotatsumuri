class PlantsController < ApplicationController
  def index
    query = params[:query]
    @plants = Plant.where("name LIKE ?", "%#{query}%").first

    if @plants.nil?
      response = OpenAiService.new.get_response(query)
      if response[:success]
        puts response[:reply]
        ActiveRecord::Base.transaction do
          @plant = Plant.create!(
            name: response[:reply]["name"],
            description: response[:reply]["description"],
            search_key: response[:reply]["search_key"]
          )
          response[:reply]["care_periods"].each do |care_period|
            CarePeriod.create!(
              start_date: Date.strptime("2000-#{care_period["start_date"]}", "%Y-%m-%d"),
              end_date: Date.strptime("2000-#{care_period["end_date"]}", "%Y-%m-%d"),
              period_type: care_period["period_type"],
              plant_id: @plant.id
            )
          end

          GrowthCondition.create!(
            plant_id: @plant.id,
            light: response[:reply]["growth_conditions"]["light"],
            soil: response[:reply]["growth_conditions"]["soil"],
            hardiness_zone: response[:reply]["growth_conditions"]["hardiness_zone"]
          )
        end

        PropagationMethod.create!(
          plant_id: @plant.id,
          description: response[:reply]["propagation_methods"].first["description"]
        )
      end
      @plants = Plant.where("name LIKE ?", "%#{query}%").first
      @care_periods = CarePeriod.where("plant_id = ?", @plants.id)
      @growth_conditions = GrowthCondition.where("plant_id = ?", @plants.id)
      render json: {
        plant: {
          id: @plants.id,
          name: @plants.name,
          description: @plants.description,
          care_periods: @care_periods,
          growth_conditions: @growth_conditions[0],
          is_registered: false
        }
      }
    else
      @care_periods = CarePeriod.where("plant_id = ?", @plants.id)
      @growth_conditions = GrowthCondition.where("plant_id = ?", @plants.id)
      @is_registered = UsersPlant.where("uid = ? AND plantid = ?", @current_user.firebase_uid, @plants.id).exists?
      puts @is_registered
      render json: {
        plant: {
          id: @plants.id,
          name: @plants.name,
          description: @plants.description,
          care_periods: @care_periods,
          growth_conditions: @growth_conditions[0],
          is_registered: @is_registered
        }
      }
    end
  end
end
