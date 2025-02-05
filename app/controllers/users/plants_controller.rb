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
end
end
