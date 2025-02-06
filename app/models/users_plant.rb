class UsersPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :user, foreign_key: :firebase_uid, primary_key: :firebase_uid


  # 受け取ったuidに紐づくplantidを取得。
  def self.plant_ids_for(uid)
    where(uid: uid).pluck(:plant_id)
  end
end
