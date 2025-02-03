module Users
class CarePeriodsController < ApplicationController
  def show
    # モデルから関数を呼び出すだけの処理
    user = @current_user
    plant_ids = UsersPlant.plant_ids_for(user.firebase_uid)
    care_periods = CarePeriod.for_plant_ids(plant_ids)

    # jsonで返却
    if care_periods.exists?
      render json: care_periods
    else
      render json: { error: "CarePeriods not found" }, status: 404
    end
  end
end
end
