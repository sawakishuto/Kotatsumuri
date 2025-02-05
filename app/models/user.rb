class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
has_many :plants, through: :users_plants
has_many :users_plants
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable,:omniauthable, :validatable

  validates :email, presence: false, allow_nil: true

  validates :password, presence: false, allow_nil: true
    # Firebase UIDを必須にする
  validates :firebase_uid, presence: true, uniqueness: true

  def password_required?
    return false if firebase_uid.present? # Firebase ユーザーならパスワード不要
    super
  end

end
