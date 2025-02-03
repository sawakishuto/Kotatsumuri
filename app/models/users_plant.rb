class UsersPlant < ApplicationRecord
  belongs_to :plant

  # 受け取ったuidに紐づくplantidを取得。
  def self.plant_ids_for(uid)
    where(uid: uid).pluck(:plantid)
  end
end
