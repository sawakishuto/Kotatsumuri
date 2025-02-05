module Users
class PlantsController < ApplicationController
  def create
    begin
      userplant=UserPlant.create!(
        plant_id=params[:plantid],
        uid=@current_user.uid
      )


    rescue
        render json: {error:"保存に失敗しました"},status: :unprocessable_entity
    end
  end

  def index
  # ユーザーidの取得,userplantテーブルから自分のユーザーidがある植物のidを取得、plantテーブルからその植物の情報を取得
  uid=@current_user.uid

  end
  
  def care_info
    # モデルから関数を呼び出すだけの処理
    user = @current_user
    plant_ids = UsersPlant.plant_ids_for(user.firebase_uid)
    care_periods = CarePeriod.for_plant_ids(plant_ids)

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
        }
      end
      puts care_period_list
      render json: care_period_list
    else
      render json: { error: "CarePeriods not found" }, status: 404
    end
  end
end
end
