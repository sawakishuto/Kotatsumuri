module Users
class PlantsController < ApplicationController
  def create
    begin
      plant = Plant.find_by_id(params[:plant_id])
      users_plant = UsersPlant.new(firebase_uid: @current_user.firebase_uid, plant_id: plant.id)
      Rails.logger.debug "UsersPlant instance: #{users_plant.inspect}"

      users_plant.save!
    rescue
        render json: { error: "保存に失敗しました"  }, status: :unprocessable_entity
    end
  end

  # def index
  # # ユーザーidの取得,userplantテーブルから自分のユーザーidがある植物のidを取得、plantテーブルからその植物の情報を取得
  # uid=@current_user.uid
  def  index
    begin
     users_id=@current_user.firebase_uid
     plants_ids=UsersPlant.where(firebase_uid: users_id).pluck(:id)
     plants=Plant.where(id: plants_ids)
     render json: { plants: plants }
    rescue
      render json: { error: "見つかりませんでした" }
    end
  end

  # end

  def care_info
    # モデルから関数を呼び出すだけの処理
    user = @current_user
    plant_ids = UsersPlant.plant_ids_for(user.firebase_uid)
    specific_time = Time.now
    care_periods = CarePeriod.for_plant_ids_in_date_range(plant_ids, specific_time)

    # jsonで返却
    if care_periods.exists?
      care_period_list = []
      care_periods.each do |care_period|
        plant_name = Plant.find(care_period.plant_id).name

        care_period_list << {
          plant_id: care_period.plant_id,
          plant_name: plant_name,
          id: care_period.id,
          start_date: care_period.start_date,
          end_date: care_period.end_date,
          period_type: care_period.period_type,
          image_url: Plant.find(care_period.plant_id).image_url
        }
      end
      puts care_period_list
      render json: care_period_list
    else
      render json: { error: "CarePeriods not found" }, status: 404
    end
  end
  def get_diagnoses
        user = @current_user
        plant_id = params[:plant_id]
        response = OpenAiService.new.post_diagnoses(
          name: params[:name],
          location: params[:location],
          sunlight: params[:sunlight],
          ventilation: params[:ventilation],
          soil_type: params[:soil_type],
          temperature: params[:temperature],
          leaf_color: params[:leaf_color],
          stem_root_condition: params[:stem_root_condition], 
          watering_frequency: params[:watering_frequency],  
          fertilizer_type: params[:fertilizer_type],    
          fertilizing_frequency: params[:fertilizing_frequency],
          pesticide_history: params[:pesticide_history],
          recent_weather: params[:recent_weather],
          image: params[:image]
        )
  
        if response[:success]
          render json: response[:reply], status: :ok
        else
          render json: { error: response[:error] }, status: :unprocessable_entity
        end
      end
    end
  end


