class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable,:omniauthable, :validatable

  validates :email, presence: false, allow_nil: true
  validates :encrypted_password, presence: false, allow_nil: true

  # Firebase UIDを必須にする
  validates :firebase_uid, presence: true, uniqueness: true
end
