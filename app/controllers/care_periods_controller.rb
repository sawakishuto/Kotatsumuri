class CarePeriodsController < ApplicationController
  def show
    # モデルから関数を呼び出すだけの処理
    plant_ids = UsersPlant.plant_ids_for(params[:id])
    care_periods = CarePeriod.for_plant_ids(plant_ids)

    # jsonで返却
    if care_periods.exists?
      render json: care_periods
    else
      render json: { error: "CarePeriods not found" }, status: 404
    end
  end
end
