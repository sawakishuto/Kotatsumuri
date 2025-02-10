class UsersPlant < ApplicationRecord
  belongs_to :user, foreign_key: :firebase_uid, primary_key: :firebase_uid
  belongs_to :plant, optional: true
  # 受け取ったuidに紐づくplantidを取得。

  def self.plant_ids_for(uid)
    where(firebase_uid: uid).pluck(:plant_id)
  end
end
