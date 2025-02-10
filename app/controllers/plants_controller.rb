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
        image = Plant.search_wikipedia_image_url(query)
        if image.present?
          @plant.update!(image_url: image)
        else
          @plant.update!(image_url: "https://sesupport.edumall.jp/hc/article_attachments/900009570963/noImage.jpg")
        end
        # @plant = Plant.where("name LIKE ?", "%#{query}%").first
        @care_periods = CarePeriod.where("plant_id = ?", @plant.id)
        @growth_conditions = GrowthCondition.where("plant_id = ?", @plant.id)
        render json: {
        plant: {
          id: @plant.id,
          name: @plant.name,
          description: @plant.description,
          care_periods: @care_periods,
          growth_conditions: @growth_conditions[0],
          is_registered: false,
          image_url: @plant.image_url
          }
        }
      else
        render json: { error: response[:error] }, status: :unprocessable_entity
      end
    else
      @care_periods = CarePeriod.where("plant_id = ?", @plants.id)
      @growth_conditions = GrowthCondition.where("plant_id = ?", @plants.id)
      @is_registered = UsersPlant.where("firebase_uid = ? AND plant_id = ?", @current_user.firebase_uid, @plants.id).exists?
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
